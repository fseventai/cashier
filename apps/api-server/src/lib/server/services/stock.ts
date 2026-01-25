import { eq, and, sql, desc, or, gte, lte, ne, isNotNull } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "../db/schema";
import { stockMovements, products, productGroups, taxes } from "../db/schema";

export class StockService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getStockHistory(productId?: string) {
    return await this.db.query.stockMovements.findMany({
      where: productId ? eq(stockMovements.productId, productId) : undefined,
      with: {
        product: true,
        user: true,
      },
      orderBy: (stockMovements, { desc }) => [desc(stockMovements.createdAt)],
    });
  }

  async adjustStock(params: {
    productId: string;
    userId: string;
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
          userId: params.userId,
          type: params.type,
          quantity: params.quantity,
          reason: params.reason,
          createdAt: now,
        })
        .returning();

      // 2. Update product stock quantity
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

  async getProductsWithStock(filters: {
    groupId?: string;
    searchQuery?: string;
    status?: "negative" | "non-zero" | "zero" | "all";
  }) {
    const conditions = [];

    if (filters.groupId) {
      conditions.push(eq(products.groupId, filters.groupId));
    }

    if (filters.searchQuery) {
      conditions.push(
        or(
          sql`${products.name} ILIKE ${`%${filters.searchQuery}%`}`,
          sql`${products.code} ILIKE ${`%${filters.searchQuery}%`}`,
          sql`${products.barcode} ILIKE ${`%${filters.searchQuery}%`}`,
        ),
      );
    }

    if (filters.status === "negative") {
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) < 0`);
    } else if (filters.status === "non-zero") {
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) <> 0`);
    } else if (filters.status === "zero") {
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) = 0`);
    }

    return await this.db
      .select({
        id: products.id,
        code: products.code,
        name: products.name,
        unit: products.unit,
        stockQuantity: products.stockQuantity,
        cost: products.cost,
        salePrice: products.salePrice,
        taxName: taxes.name,
        taxRate: taxes.rate,
      })
      .from(products)
      .leftJoin(taxes, eq(products.taxId, taxes.id))
      .where(and(...conditions))
      .orderBy(products.name);
  }

  async getInventorySummary(filters: {
    groupId?: string;
    searchQuery?: string;
    status?: "negative" | "non-zero" | "zero" | "all";
  }) {
    const conditions = [];
    if (filters.groupId) conditions.push(eq(products.groupId, filters.groupId));
    if (filters.searchQuery)
      conditions.push(
        sql`${products.name} ILIKE ${`%${filters.searchQuery}%`}`,
      );

    if (filters.status === "negative")
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) < 0`);
    else if (filters.status === "non-zero")
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) <> 0`);
    else if (filters.status === "zero")
      conditions.push(sql`CAST(${products.stockQuantity} AS NUMERIC) = 0`);

    const result = await this.db
      .select({
        totalCost: sql<number>`SUM(CAST(${products.cost} AS NUMERIC) * CAST(${products.stockQuantity} AS NUMERIC))`,
        totalSale: sql<number>`SUM(CAST(${products.salePrice} AS NUMERIC) * CAST(${products.stockQuantity} AS NUMERIC))`,
        totalCount: sql<number>`COUNT(*)`,
      })
      .from(products)
      .where(and(...conditions));

    return result[0];
  }

  async getLowStockItems() {
    return await this.db
      .select()
      .from(products)
      .where(
        sql`CAST(${products.stockQuantity} AS NUMERIC) <= CAST(${products.reorderPoint} AS NUMERIC)`,
      )
      .orderBy(products.name);
  }
}
