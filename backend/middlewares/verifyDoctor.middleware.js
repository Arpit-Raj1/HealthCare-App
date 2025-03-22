const fetch = require('node-fetch');
import asyncHandler from 'express-async-handler';
import { fetchRequestUrl } from '../utils/fetchRequestUrl.utils';

export const verifyDoctor = asyncHandler(async (req, res) => {
    const { registrationNumber, stateMedicalCouncil, yearOfRegistration } = req.body;
    const data = {
        registrationNumber,
        stateMedicalCouncil,
        yearOfRegistration,
    };

    const requestUrl = fetchRequestUrl(data);
    console.log(requestUrl);
});
