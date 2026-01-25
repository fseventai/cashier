import { eq } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { products } from "@/server/db/schema";

export class ProductService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getProducts() {
    return await this.db.query.products.findMany({
      with: {
        group: true,
        tax: true,
        storageLocation: true,
      },
    });
  }

  async getProductById(id: string) {
    return await this.db.query.products.findFirst({
      where: eq(products.id, id),
      with: {
        group: true,
        tax: true,
        storageLocation: true,
      },
    });
  }

  async createProduct(values: typeof products.$inferInsert) {
    const [product] = await this.db.insert(products).values(values).returning();
    return product;
  }

  async updateProduct(
    id: string,
    values: Partial<typeof products.$inferInsert>,
  ) {
    const [product] = await this.db
      .update(products)
      .set({ ...values, updatedAt: new Date() })
      .where(eq(products.id, id))
      .returning();
    return product;
  }

  async deleteProduct(id: string) {
    const [product] = await this.db
      .delete(products)
      .where(eq(products.id, id))
      .returning();
    return product;
  }
}
