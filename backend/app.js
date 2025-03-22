// import express from 'express';
// import expressAsyncHandler from 'express-async-handler';
// import { fetchRequestUrl } from './utils/fetchRequestUrl.utils.js';
// import cors from 'cors';

// const app = express();
// const port = 3000;

// app.use(cors());

// app.get('/', (req, res) => {
//     res.send('Hello World!');
// });

// app.post('/verify', async (req, res) => {
//     const data = {
//         registrationNumber: '12345',
//         stateMedicalCouncil: 'Bombay Medical Council',
//         yearOfRegistration: '1960',
//     };

//     const requestUrl = await fetchRequestUrl(data);
//     console.log(requestUrl);
//     res.send(requestUrl);
// });

// app.listen(port, () => {
//     console.log(`App is running on http://localhost:${port}`);
// });
