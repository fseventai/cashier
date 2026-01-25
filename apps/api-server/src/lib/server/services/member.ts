import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { members } from "@/server/db/schema";

export class MemberService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getMembers() {
    return await this.db.query.members.findMany({
      orderBy: (members, { desc }) => [desc(members.createdAt)],
    });
  }

  async getMemberById(id: string) {
    return await this.db.query.members.findFirst({
      where: eq(members.id, id),
    });
  }

  async createMember(values: typeof members.$inferInsert) {
    const [member] = await this.db.insert(members).values(values).returning();
    return member;
  }

  async updateMember(id: string, values: Partial<typeof members.$inferInsert>) {
    const [member] = await this.db
      .update(members)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(members.id, id))
      .returning();
    return member;
  }

  async deleteMember(id: string) {
    const [member] = await this.db
      .delete(members)
      .where(eq(members.id, id))
      .returning();
    return member;
  }
}
