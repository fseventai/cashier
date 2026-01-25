import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "../schema";
import { storageLocations } from "../schema";

export class StorageLocationService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getLocations() {
    return await this.db.query.storageLocations.findMany();
  }

  async getLocationById(id: string) {
    return await this.db.query.storageLocations.findFirst({
      where: eq(storageLocations.id, id),
    });
  }

  async createLocation(values: typeof storageLocations.$inferInsert) {
    const [location] = await this.db
      .insert(storageLocations)
      .values(values)
      .returning();
    return location;
  }

  async updateLocation(
    id: string,
    values: Partial<typeof storageLocations.$inferInsert>,
  ) {
    const [location] = await this.db
      .update(storageLocations)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(storageLocations.id, id))
      .returning();
    return location;
  }

  async deleteLocation(id: string) {
    const [location] = await this.db
      .delete(storageLocations)
      .where(eq(storageLocations.id, id))
      .returning();
    return location;
  }
}
