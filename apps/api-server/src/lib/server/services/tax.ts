import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { taxes } from "@/server/db/schema";

export class TaxService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getTaxes() {
    return await this.db.query.taxes.findMany();
  }

  async getTaxById(id: string) {
    return await this.db.query.taxes.findFirst({
      where: eq(taxes.id, id),
    });
  }

  async createTax(values: typeof taxes.$inferInsert) {
    const [tax] = await this.db.insert(taxes).values(values).returning();
    return tax;
  }

  async updateTax(id: string, values: Partial<typeof taxes.$inferInsert>) {
    const [tax] = await this.db
      .update(taxes)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(taxes.id, id))
      .returning();
    return tax;
  }

  async deleteTax(id: string) {
    const [tax] = await this.db
      .delete(taxes)
      .where(eq(taxes.id, id))
      .returning();
    return tax;
  }
}
