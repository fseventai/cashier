import { db } from "../db";
import * as schema from "../db/schema";
import { eq, and, gte, lte, sql, desc } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";

export class DashboardService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getStats(startDate?: Date, endDate?: Date) {
    const start = startDate || new Date(new Date().setHours(0, 0, 0, 0));
    const end = endDate || new Date(new Date().setHours(23, 59, 59, 999));

    // 1. Total Sales Count & Amount (within period)
    const salesStats = await this.db
      .select({
        count: sql<number>`count(*)`,
        totalAmount: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .where(
        and(
          gte(schema.salesDocuments.date, start),
          lte(schema.salesDocuments.date, end),
          eq(schema.salesDocuments.documentType, "Faktur Penjualan"),
        ),
      );

    // 2. Top Products (within period)
    const topProducts = await this.db
      .select({
        productId: schema.salesItems.productId,
        name: schema.salesItems.name,
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
          gte(schema.salesDocuments.date, start),
          lte(schema.salesDocuments.date, end),
          eq(schema.salesDocuments.documentType, "Faktur Penjualan"),
        ),
      )
      .groupBy(schema.salesItems.productId, schema.salesItems.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesItems.quantity} AS NUMERIC))`))
      .limit(5);

    // 3. Hourly Sales (within period)
    const hourlySales = await this.db
      .select({
        hour: sql<number>`extract(hour from ${schema.salesDocuments.date})`,
        count: sql<number>`count(*)`,
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .where(
        and(
          gte(schema.salesDocuments.date, start),
          lte(schema.salesDocuments.date, end),
          eq(schema.salesDocuments.documentType, "Faktur Penjualan"),
        ),
      )
      .groupBy(sql`extract(hour from ${schema.salesDocuments.date})`)
      .orderBy(sql`extract(hour from ${schema.salesDocuments.date})`);

    // 4. Top Customers (within period)
    const topCustomers = await this.db
      .select({
        customerId: schema.salesDocuments.customerId,
        name: schema.customers.name,
        count: sql<number>`count(*)`,
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .leftJoin(
        schema.customers,
        eq(schema.salesDocuments.customerId, schema.customers.id),
      )
      .where(
        and(
          gte(schema.salesDocuments.date, start),
          lte(schema.salesDocuments.date, end),
          eq(schema.salesDocuments.documentType, "Faktur Penjualan"),
        ),
      )
      .groupBy(schema.salesDocuments.customerId, schema.customers.name)
      .orderBy(desc(sql`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`))
      .limit(5);

    return {
      salesCount: salesStats[0]?.count || 0,
      totalAmount: salesStats[0]?.totalAmount || 0,
      topProducts,
      hourlySales,
      topCustomers,
    };
  }

  async getMonthlySales(year: number) {
    const startOfYear = new Date(year, 0, 1);
    const endOfYear = new Date(year, 11, 31, 23, 59, 59, 999);

    const monthlySales = await this.db
      .select({
        month: sql<number>`extract(month from ${schema.salesDocuments.date})`,
        total: sql<number>`sum(CAST(${schema.salesDocuments.total} AS NUMERIC))`,
      })
      .from(schema.salesDocuments)
      .where(
        and(
          gte(schema.salesDocuments.date, startOfYear),
          lte(schema.salesDocuments.date, endOfYear),
          eq(schema.salesDocuments.documentType, "Faktur Penjualan"),
        ),
      )
      .groupBy(sql`extract(month from ${schema.salesDocuments.date})`)
      .orderBy(sql`extract(month from ${schema.salesDocuments.date})`);

    // Ensure all 12 months are present
    const result = Array.from({ length: 12 }, (_, i) => ({
      month: i + 1,
      total: 0,
    }));

    for (const row of monthlySales) {
      result[row.month - 1].total = row.total;
    }

    // Identify top performing month
    let topMonth = { month: 0, total: 0 };
    let totalYearly = 0;
    for (const m of result) {
      totalYearly += m.total;
      if (m.total > topMonth.total) {
        topMonth = m;
      }
    }

    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return {
      yearlyTotal: totalYearly,
      topMonth: topMonth.total > 0 ? monthNames[topMonth.month - 1] : "N/A",
      topMonthAmount: topMonth.total,
      monthlyData: result,
    };
  }
}
