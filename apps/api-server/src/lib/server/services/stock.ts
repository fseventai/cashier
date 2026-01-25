import { eq, sql } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "@/server/db/schema";
import { stockMovements, products } from "@/server/db/schema";

export class StockService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getStockHistory(productId?: string) {
    return await this.db.query.stockMovements.findMany({
      where: productId ? eq(stockMovements.productId, productId) : undefined,
      with: {
        product: true,
      },
      orderBy: (stockMovements, { desc }) => [desc(stockMovements.createdAt)],
    });
  }

  async adjustStock(params: {
    productId: string;
    quantity: string;
    type: "in" | "out" | "adjustment";
    reason?: string;
  }) {
    return await this.db.transaction(async (tx) => {
      const id = crypto.randomUUID();
      const now = new Date();

      // 1. Log movement
      const [movement] = await tx
        .insert(stockMovements)
        .values({
          id,
          productId: params.productId,
          type: params.type,
          quantity: params.quantity,
          reason: params.reason,
          createdAt: now,
        })
        .returning();

      // 2. Update product stock quantity
      // Logic: newStock = oldStock + (type === 'out' ? -quantity : quantity)
      const changeAmount =
        params.type === "out" ? `-${params.quantity}` : params.quantity;

      await tx
        .update(products)
        .set({
          stockQuantity: sql`${products.stockQuantity} + ${changeAmount}`,
          updatedAt: now,
        })
        .where(eq(products.id, params.productId));

      return movement;
    });
  }
}
