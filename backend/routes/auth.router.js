import { Router } from 'express';

const authRouter = Router();

authRouter.post('/login', (req, res) => signInUser);

authRouter.post('/register', (req, res) => {
    /* ... */
});
