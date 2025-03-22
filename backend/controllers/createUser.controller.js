const { prisma } = require('../config/connectDb');
import asyncHandler from 'express-async-handler';

export const createUser = async (req, res) => {
    const {
        name,
        email,
        password,
        role,
        registrationNumber = null,
        stateMedicalCouncil = null,
        yearOfRegistration = null,
    } = req.body;

    if (role != 'DOCTOR') {
        asyncHandler(async (req, res) => {
            const user = await prisma.user.create({
                data: {
                    name,
                    email,
                    password,
                    role,
                },
            });

            res.status(201).json(user);
        });
    } else {
        asyncHandler(async (req, res) => {
            const user = await prisma.user.create({
                data: {
                    name,
                    email,
                    password,
                    role,
                    registrationNumber,
                    stateMedicalCouncil,
                    yearOfRegistration,
                },
            });

            res.status(201).json(user);
        });
    }
};
