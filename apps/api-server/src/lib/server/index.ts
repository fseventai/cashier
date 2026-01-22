import { createDb } from "@cashier/database";
import { createAuth } from "@cashier/auth";
import { env } from "$env/dynamic/private";

export const db = createDb(env.DATABASE_URL || "");
export const auth = createAuth(db);
