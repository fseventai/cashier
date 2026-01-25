import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "../db/schema";
import { user } from "../db/schema";

export class UserService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getUsers() {
    return await this.db.query.user.findMany({
      orderBy: (user, { asc }) => [asc(user.name)],
    });
  }

  async getUserById(id: string) {
    return await this.db.query.user.findFirst({
      where: eq(user.id, id),
    });
  }

  async createUser(values: typeof user.$inferInsert) {
    const [newUser] = await this.db.insert(user).values(values).returning();
    return newUser;
  }

  async updateUser(id: string, values: Partial<typeof user.$inferInsert>) {
    const [updatedUser] = await this.db
      .update(user)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(user.id, id))
      .returning();
    return updatedUser;
  }

  async deleteUser(id: string) {
    const [deletedUser] = await this.db
      .delete(user)
      .where(eq(user.id, id))
      .returning();
    return deletedUser;
  }
}
