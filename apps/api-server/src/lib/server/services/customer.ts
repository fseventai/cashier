import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { customers } from "@/server/db/schema";

export class CustomerService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getCustomers() {
    return await this.db.query.customers.findMany({
      orderBy: (customers, { desc }) => [desc(customers.createdAt)],
    });
  }

  async getCustomerById(id: string) {
    return await this.db.query.customers.findFirst({
      where: eq(customers.id, id),
    });
  }

  async createCustomer(values: typeof customers.$inferInsert) {
    const [customer] = await this.db
      .insert(customers)
      .values(values)
      .returning();
    return customer;
  }

  async updateCustomer(
    id: string,
    values: Partial<typeof customers.$inferInsert>,
  ) {
    const [customer] = await this.db
      .update(customers)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(customers.id, id))
      .returning();
    return customer;
  }

  async deleteCustomer(id: string) {
    const [customer] = await this.db
      .delete(customers)
      .where(eq(customers.id, id))
      .returning();
    return customer;
  }
}
