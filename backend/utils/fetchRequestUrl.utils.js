import asyncHandler from 'express-async-handler';

export const fetchRequestUrl = asyncHandler(async (data) => {
    const options = {
        method: 'POST',
        headers: {
            'x-rapidapi-key': process.env.RAPID_API_KEY || '',
            'x-rapidapi-host': process.env.RAPID_API_HOST || '',
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            task_id: process.env.RAPID_TASK_ID,
            group_id: process.env.RAPID_GROUP_ID,
            data,
        }),
    };

    const response = await fetch(process.env.RAPID_GET_REQUEST_ID_URL || '', options);
    return await response.json();
});
