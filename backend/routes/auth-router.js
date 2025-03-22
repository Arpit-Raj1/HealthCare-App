import { Router } from 'express';

import { checkUserExistenceInDatabase, signInUser, signUpUser } from '../controllers/auth-controllers.js';

const authRouter = Router();

authRouter.post('/sign-up', signUpUser);
authRouter.post('/sign-in', signInUser);
authRouter.post('/verify', checkUserExistenceInDatabase);

export default authRouter;
