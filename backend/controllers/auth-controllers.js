import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
import asyncHandler from "express-async-handler";
import { validationResult } from "express-validator";
import jwt from "jsonwebtoken";

import { admin as firebaseAdmin } from "../config/firebase-config.js";

import validateUser from "../validators/user-validator.js";

const prisma = new PrismaClient();

const signInUser = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  const dbUser = await prisma.user.findUnique({ where: { email } });

  if (!dbUser) {
    return res.status(400).json({ message: "Credentials do not match" });
  }

  const passwordMatch = await bcrypt.compare(password, dbUser.password);
  if (!passwordMatch) {
    return res.status(400).json({ message: "Credentials do not match" });
  }

  const user = await firebaseAdmin.auth().getUserByEmail(email);
  const userClaims = (await firebaseAdmin.auth().getUser(user.uid)).customClaims || {};

  const token = jwt.sign(
    {
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      profilePicture: user.photoURL,
      ...userClaims,
    },
    process.env.JWT_KEY,
    { expiresIn: "7d" }
  );

  res.status(200).json({ message: "Sign-in successful", token });
});

const signUpUser = [
  validateUser,
  asyncHandler(async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      console.log(req.body);

      return res.json({ errors: errors.array().map((err) => err.msg) });
    }

    const { name, email, phoneNumber, dob, role, password } = req.body;

    const passwordHash = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: { name, email, password: passwordHash, phoneNumber, dob, role },
    });

    const userRecord = await firebaseAdmin.auth().createUser({
      uid: user.id,
      email: user.email,
      password: user.password,
      displayName: user.name,
      phoneNumber: user.phoneNumber,
      photoURL:
        user.profilePicture ||
        "https://static.vecteezy.com/system/resources/previews/027/448/973/large_2x/avatar-account-icon-default-social-media-profile-photo-vector.jpg",
    });

    await firebaseAdmin.auth().setCustomUserClaims(userRecord.uid, {
      role,
      dob,
      address: user.address,
      doctorInfo: user.doctorInfo,
    });

    console.log(userRecord);

    res
      .status(201)
      .json({ message: "user created successfully", user: userRecord });
  }),
];

export { signInUser, signUpUser };
