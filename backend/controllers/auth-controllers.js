import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import asyncHandler from 'express-async-handler';
import { validationResult } from 'express-validator';
import jwt from 'jsonwebtoken';

import { admin as firebaseAdmin } from '../config/firebase-config.js';

import validateUser from '../validators/user-validator.js';

const prisma = new PrismaClient();

const checkUserExistenceInDatabase = asyncHandler(async (req, res) => {
    const uid = req.token.uid;

    const user = await prisma.user.findUnique({ where: { id: uid } });

    if (user) {
        res.sendStatus(202); // user already exists
    } else {
        res.sendStatus(201); // user profile needs to be created
    }
});

const updateUserDetails = asyncHandler(async (req, res) => {
    const uid = req.token.uid;

    const {
        name,
        email,
        dob,
        address,
        role,
        phoneNumber,
        registrationNumber,
        stateMedicalCouncil,
        yearOfRegistration,
    } = req.body;

    if (role !== 'DOCTOR') {
        const user = await prisma.user.create({
            data: { id: uid, name, email, dob, address, phoneNumber, role: role.toUpperCase() },
        });

        return res.status(201).json(user);
    }

    const rapidResponse = await fetch(process.env.RAPID_POST_URL, {
        method: 'POST',
        headers: {
            'x-rapidapi-key': process.env.RAPID_API_KEY,
            'x-rapidapi-host': process.env.RAPID_API_HOST,
        },
        body: {
            task_id: process.env.RAPID_TASK_ID,
            group_id: process.env.RAPID_GROUP_ID,
            data: {
                registration_no: registrationNumber,
                year_of_registration: yearOfRegistration,
                council_name: stateMedicalCouncil,
            },
        },
    });
    const { request_id } = await rapidResponse.json();

    const response = await fetch(`${process.env.RAPID_GET_URL}${request_id}`, {
        method: 'GET',
        headers: {
            'x-rapidapi-key': process.env.RAPID_API_KEY,
            'x-rapidapi-host': process.env.RAPID_API_HOST,
        },
    });

    const [docInfo] = await response.json();

    if (docInfo.result.source_output.status === 'id_not_found') {
        return res.status(400).json({ error: 'Invalid credentials' });
    }

    const user = await prisma.user.create({
        data: {
            id: uid,
            name,
            email,
            password,
            address,
            role: role.toUpperCase(),
            phoneNumber,
        },
    });

    const doctorInfo = await prisma.doctorInfo.create({
        data: {
            userId: user.id,
            dateOfRegistration: docInfo.result.source_output.imr_details.date_of_registration,
            registrationNumber: docInfo.result.source_output.registration_no,
            stateMedicalCouncil: docInfo.result.source_output.state_medical_councils,
            qualification: docInfo.result.source_output.imr_details.qualification,
            qualificationYear: docInfo.result.source_output.imr_details.qualification,
            university: docInfo.result.source_output.imr_details.university_name,
        },
    });

    return res.status(201).json({ user, doctorInfo });
});

// const signInUser = asyncHandler(async (req, res) => {
//   const { email, password } = req.body;

//   const dbUser = await prisma.user.findUnique({ where: { email } });

//   if (!dbUser) {
//     return res.status(400).json({ message: "Credentials do not match" });
//   }

//   const passwordMatch = await bcrypt.compare(password, dbUser.password);
//   if (!passwordMatch) {
//     return res.status(400).json({ message: "Credentials do not match" });
//   }

//   const user = await firebaseAdmin.auth().getUserByEmail(email);
//   const userClaims =
//     (await firebaseAdmin.auth().getUser(user.uid)).customClaims || {};

//   const token = jwt.sign(
//     {
//       uid: user.uid,
//       email: user.email,
//       name: user.displayName,
//       profilePicture: user.photoURL,
//       ...userClaims,
//     },
//     process.env.JWT_KEY,
//     { expiresIn: "7d" }
//   );

//   res.status(200).json({ message: "Sign-in successful", token });
// });

// const signUpUser = [
//   validateUser,
//   asyncHandler(async (req, res) => {
//     const errors = validationResult(req);
//     if (!errors.isEmpty()) {
//       console.log(req.body);

//       return res.json({ errors: errors.array().map((err) => err.msg) });
//     }

//     const { name, email, phoneNumber, dob, role, password } = req.body;

//     const passwordHash = await bcrypt.hash(password, 10);

//     const user = await prisma.user.create({
//       data: { name, email, password: passwordHash, phoneNumber, dob, role },
//     });

//     const userRecord = await firebaseAdmin.auth().createUser({
//       uid: user.id,
//       email: user.email,
//       password: password,
//       displayName: name,
//       phoneNumber,
//       photoURL:
//         user.profilePicture ||
//         "https://static.vecteezy.com/system/resources/previews/027/448/973/large_2x/avatar-account-icon-default-social-media-profile-photo-vector.jpg",
//     });

//     await firebaseAdmin.auth().setCustomUserClaims(userRecord.uid, {
//       role,
//       dob,
//       address: user.address,
//       doctorInfo: user.doctorInfo,
//     });

//     console.log(userRecord);

//     res
//       .status(201)
//       .json({ message: "user created successfully", user: userRecord });
//   }),
// ];

export {
    checkUserExistenceInDatabase,
    // signInUser,
    // signUpUser,
    updateUserDetails,
};
