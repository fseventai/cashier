import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { productGroups } from "@/server/db/schema";

export class ProductGroupService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getGroups() {
    return await this.db.query.productGroups.findMany({
      with: {
        parent: true,
      },
    });
  }

  async getGroupById(id: string) {
    return await this.db.query.productGroups.findFirst({
      where: eq(productGroups.id, id),
      with: {
        parent: true,
      },
    });
  }

  async createGroup(values: typeof productGroups.$inferInsert) {
    const [group] = await this.db
      .insert(productGroups)
      .values(values)
      .returning();
    return group;
  }

  async updateGroup(
    id: string,
    values: Partial<typeof productGroups.$inferInsert>,
  ) {
    const [group] = await this.db
      .update(productGroups)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(productGroups.id, id))
      .returning();
    return group;
  }

  async deleteGroup(id: string) {
    try {
      const [group] = await this.db
        .delete(productGroups)
        .where(eq(productGroups.id, id))
        .returning();
      return { group, action: "deleted" as const };
    } catch (error: any) {
      if (error.code === "23503" || error.cause?.code === "23503") {
        const [group] = await this.db
          .update(productGroups)
          .set({ isActive: false, updatedAt: new Date() })
          .where(eq(productGroups.id, id))
          .returning();
        return { group, action: "deactivated" as const };
      }
      throw error;
    }
  }
}
