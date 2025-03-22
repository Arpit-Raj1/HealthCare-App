const fetch = require('node-fetch');
import asyncHandler from 'express-async-handler';

const doctorData = asyncHandler(async (req, res) => {
    const { requestUrl } = req.body;
    const options = {
        method: 'GET',
        headers: {
            'x-rapidapi-key': process.env.RAPID_API_KEY || '',
            'x-rapidapi-host': process.env.RAPID_API_HOST || '',
        },
    };

    const response = await fetch(process.env.RAPID_REQUEST_URL + requestUrl, options);
});
