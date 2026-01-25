import "dotenv/config";
import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { db } from "@/server/db";
import * as schema from "@/server/db/schema";
import { hashPassword, verifyPassword } from "@/server/password";
import { BETTER_AUTH_URL } from "$env/static/private";

export const auth = betterAuth({
  database: drizzleAdapter(db, {
    provider: "pg",
    schema,
  }),
  emailAndPassword: {
    enabled: true,
    requireEmailVerification: false,
    password: {
      hash: hashPassword,
      verify: verifyPassword,
    },
  },
  session: {
    expiresIn: 60 * 60 * 24 * 7, // 7 days
    updateAge: 60 * 60 * 24, // 1 day
  },
  trustedOrigins: [
    "http://localhost:5173",
    "http://10.237.167.107:5173",
    BETTER_AUTH_URL!,
    "cashier://", // Flutter App Scheme
  ],
  advanced: {
    disableCSRFCheck: true,
  },
});

export type Session = typeof auth.$Infer.Session;
