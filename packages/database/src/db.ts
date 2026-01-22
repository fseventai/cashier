import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import * as schema from "./schema";

export const createDb = (databaseUrl: string) => {
  const client = postgres(databaseUrl, { prepare: false });
  return drizzle(client, { schema });
};

export * from "./schema";
