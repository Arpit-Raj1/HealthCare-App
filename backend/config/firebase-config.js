import admin from 'firebase-admin';
import { readFile } from 'node:fs/promises';

import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const serviceAccount = JSON.parse(
    await readFile(path.join(__dirname, 'gsc-swatify-firebase-adminsdk-fbsvc-4741c27c06.json'), 'utf8')
);

admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });

export { admin };
