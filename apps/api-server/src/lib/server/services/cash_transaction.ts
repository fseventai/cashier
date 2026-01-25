import { db } from "../db";
import * as schema from "../db/schema";
import { eq, desc } from "drizzle-orm";
import { faker } from "@faker-js/faker";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";

export class CashTransactionService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getAll() {
    return await this.db.query.cashTransactions.findMany({
      with: {
        user: true,
      },
      orderBy: [desc(schema.cashTransactions.createdAt)],
    });
  }

  async create(data: {
    type: "in" | "out";
    amount: string;
    description?: string;
    userId: string;
  }) {
    const id = faker.string.uuid();
    await this.db.insert(schema.cashTransactions).values({
      id,
      ...data,
      createdAt: new Date(),
      updatedAt: new Date(),
    });

    return await this.db.query.cashTransactions.findFirst({
      where: eq(schema.cashTransactions.id, id),
      with: {
        user: true,
      },
    });
  }

  async delete(id: string) {
    await this.db
      .delete(schema.cashTransactions)
      .where(eq(schema.cashTransactions.id, id));
  }
}
