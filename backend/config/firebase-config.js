import admin from "firebase-admin";
import { readFile } from "node:fs/promises";

const serviceAccount = JSON.parse(
  await readFile(
    "/home/tangerine/HealthCare-App/backend/config/firebase-service-account-key.json",
    "utf8"
  )
);

admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });

export { admin };
