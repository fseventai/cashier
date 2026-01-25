import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { companies } from "@/server/db/schema";

export class CompanyService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getCompanies() {
    return await this.db.query.companies.findMany();
  }

  async getCompanyById(id: string) {
    return await this.db.query.companies.findFirst({
      where: eq(companies.id, id),
    });
  }

  async createCompany(values: typeof companies.$inferInsert) {
    const [company] = await this.db
      .insert(companies)
      .values(values)
      .returning();
    return company;
  }

  async updateCompany(
    id: string,
    values: Partial<typeof companies.$inferInsert>,
  ) {
    const [company] = await this.db
      .update(companies)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(companies.id, id))
      .returning();
    return company;
  }

  async deleteCompany(id: string) {
    const [company] = await this.db
      .delete(companies)
      .where(eq(companies.id, id))
      .returning();
    return company;
  }
}
