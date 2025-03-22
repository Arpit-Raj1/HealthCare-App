import { PrismaClient } from "@prisma/client";
import { body } from "express-validator";

const prisma = new PrismaClient();

const validateUser = [
  body("email")
    .trim()
    .isEmail()
    .withMessage("Email is not valid")
    .custom(async (email) => {
      const count = await prisma.user.count({ where: { email } });
      console.log(count);
      if (count) {
        throw new Error(
          `There is already an account associated with this email`
        );
      }
      return true;
    }),
];

export default validateUser;
