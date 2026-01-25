import "dotenv/config";
import postgres from "postgres";
import { drizzle } from "drizzle-orm/postgres-js";
import * as schema from "./schema";
import { DATABASE_URL } from "$env/static/private";

const connectionString = DATABASE_URL;

// For query client
const queryClient = postgres(connectionString);
export const db = drizzle(queryClient, { schema });
