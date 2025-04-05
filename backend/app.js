import cors from 'cors';
import 'dotenv/config';
import express from 'express';

import authRouter from './routes/auth-router.js';

const PORT = process.env.PORT || 8000;

const app = express();

/* handle cross-origin requests */
app.use(cors({ origin: true }));

/* parse  */
app.use(express.json());

/* routes */
app.use('/auth', authRouter);

/* async error handler */
app.use((err, req, res, next) => {
    console.log(err);
    res.status(400).json(err);
});

app.get('/', (req, res) => {
    res.send('Hello World!');
});

/* startup */
app.listen(PORT, '0.0.0.0', () => {
    console.log(`Listening on port ${PORT} ...`);
});

export default app;
