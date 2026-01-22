import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import * as schema from "@cashier/database";

export const createAuth = (db: any) => {
  return betterAuth({
    database: drizzleAdapter(db, {
      provider: "pg",
      schema: {
        ...schema,
      },
    }),
    emailAndPassword: {
      enabled: true,
    },
  });
};
