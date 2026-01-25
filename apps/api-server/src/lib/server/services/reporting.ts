import { db } from "../db";
import * as schema from "../db/schema";
import { eq, and, gte, lte, sql, desc, sum, count } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";

export class ReportingService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getProductsReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        productId: schema.salesItems.productId,
        name: schema.salesItems.name,
        code: schema.salesItems.code,
        quantity: sql<number>`sum(CAST(${schema.salesItems.quantity} AS NUMERIC))`,
        total: sql<number>`sum(CAST(${schema.salesItems.total} AS NUMERIC))`,
      })
      .from(schema.salesItems)
      .innerJoin(
        schema.salesDocuments,
        eq(schema.salesItems.documentId, schema.salesDocuments.id),
      )
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(
        schema.salesItems.productId,
        schema.salesItems.name,
        schema.salesItems.code,
      )
      .orderBy(desc(sql`sum(CAST(${schema.salesItems.total} AS NUMERIC))`));
  }

  async getProductGroupsReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        groupId: schema.products.groupId,
        groupName: schema.productGroups.name,
        quantity: sql<number>`sum(CAST(${schema.salesItems.quantity} AS NUMERIC))`,
        total: sql<number>`sum(CAST(${schema.salesItems.total} AS NUMERIC))`,
      })
      .from(schema.salesItems)
      .innerJoin(
        schema.salesDocuments,
        eq(schema.salesItems.documentId, schema.salesDocuments.id),
      )
      .innerJoin(
        schema.products,
        eq(schema.salesItems.productId, schema.products.id),
      )
      .leftJoin(
        schema.productGroups,
        eq(schema.products.groupId, schema.productGroups.id),
      )
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(schema.products.groupId, schema.productGroups.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesItems.total} AS NUMERIC))`));
  }

  async getCustomersReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        customerId: schema.salesDocuments.customerId,
        name: schema.customers.name,
        count: count(schema.salesDocuments.id),
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .leftJoin(
        schema.customers,
        eq(schema.salesDocuments.customerId, schema.customers.id),
      )
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(schema.salesDocuments.customerId, schema.customers.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`));
  }

  async getUsersReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        userId: schema.salesDocuments.userId,
        userName: schema.user.name,
        count: count(schema.salesDocuments.id),
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .innerJoin(schema.user, eq(schema.salesDocuments.userId, schema.user.id))
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(schema.salesDocuments.userId, schema.user.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`));
  }

  async getPaymentTypesReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        paymentType: schema.salesDocuments.paymentType,
        count: count(schema.salesDocuments.id),
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(schema.salesDocuments.paymentType)
      .orderBy(desc(sql`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`));
  }

  async getDailySalesReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        date: sql<string>`DATE(${schema.salesDocuments.date})`,
        count: count(schema.salesDocuments.id),
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(sql`DATE(${schema.salesDocuments.date})`)
      .orderBy(sql`DATE(${schema.salesDocuments.date})`);
  }

  async getProfitMarginReport(startDate: Date, endDate: Date) {
    return await this.db
      .select({
        productId: schema.salesItems.productId,
        name: schema.salesItems.name,
        revenue: sql<number>`sum(CAST(${schema.salesItems.total} AS NUMERIC))`,
        cost: sql<number>`sum(CAST(${schema.products.cost} AS NUMERIC) * CAST(${schema.salesItems.quantity} AS NUMERIC))`,
        profit: sql<number>`sum(CAST(${schema.salesItems.total} AS NUMERIC) - (CAST(${schema.products.cost} AS NUMERIC) * CAST(${schema.salesItems.quantity} AS NUMERIC)))`,
      })
      .from(schema.salesItems)
      .innerJoin(
        schema.salesDocuments,
        eq(schema.salesItems.documentId, schema.salesDocuments.id),
      )
      .innerJoin(
        schema.products,
        eq(schema.salesItems.productId, schema.products.id),
      )
      .where(
        and(
          gte(schema.salesDocuments.date, startDate),
          lte(schema.salesDocuments.date, endDate),
        ),
      )
      .groupBy(schema.salesItems.productId, schema.salesItems.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesItems.total} AS NUMERIC))`));
  }
}
