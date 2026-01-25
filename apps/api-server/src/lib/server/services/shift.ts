import { eq, and, sql, desc, isNull } from "drizzle-orm";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";
import * as schema from "../db/schema";
import { shifts, salesDocuments, cashTransactions } from "../db/schema";

export class ShiftService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getActiveShift(userId: string) {
    return await this.db.query.shifts.findFirst({
      where: and(eq(shifts.userId, userId), eq(shifts.status, "open")),
      with: {
        user: true,
      },
    });
  }

  async openShift(params: {
    userId: string;
    pos?: string;
    openingBalance: string;
    openingNote?: string;
  }) {
    const id = crypto.randomUUID();
    const now = new Date();

    const [shift] = await this.db
      .insert(shifts)
      .values({
        id,
        userId: params.userId,
        pos: params.pos,
        openedAt: now,
        openingBalance: params.openingBalance,
        openingNote: params.openingNote,
        status: "open",
        createdAt: now,
        updatedAt: now,
      })
      .returning();

    return shift;
  }

  async closeShift(
    id: string,
    params: {
      closingBalance: string;
      closingNote?: string;
    },
  ) {
    const now = new Date();

    // Calculate expected balance
    const expectedBalance = await this.calculateExpectedBalance(id);

    const discrepancy = (
      parseFloat(params.closingBalance) - expectedBalance
    ).toString();

    const [shift] = await this.db
      .update(shifts)
      .set({
        closedAt: now,
        closingBalance: params.closingBalance,
        expectedBalance: expectedBalance.toString(),
        discrepancy,
        closingNote: params.closingNote,
        status: "closed",
        updatedAt: now,
      })
      .where(eq(shifts.id, id))
      .returning();

    return shift;
  }

  async calculateExpectedBalance(shiftId: string): Promise<number> {
    // Get shift's opening balance
    const shift = await this.db.query.shifts.findFirst({
      where: eq(shifts.id, shiftId),
    });

    if (!shift) return 0;

    const openingBalance = parseFloat(shift.openingBalance);

    // Get cash sales for this shift's period
    // Since we don't have shiftId on sales yet, we use time-based calculation
    const salesResult = await this.db
      .select({
        total: sql<number>`COALESCE(SUM(CAST(${salesDocuments.total} AS NUMERIC)), 0)`,
      })
      .from(salesDocuments)
      .where(
        and(
          eq(salesDocuments.paymentType, "Cash"),
          sql`${salesDocuments.date} >= ${shift.openedAt}`,
          shift.closedAt
            ? sql`${salesDocuments.date} <= ${shift.closedAt}`
            : sql`1=1`,
        ),
      );

    const cashSales = salesResult[0]?.total || 0;

    // Get cash transactions (in/out) for this shift's period
    const cashResult = await this.db
      .select({
        totalIn: sql<number>`COALESCE(SUM(CASE WHEN ${cashTransactions.type} = 'in' THEN CAST(${cashTransactions.amount} AS NUMERIC) ELSE 0 END), 0)`,
        totalOut: sql<number>`COALESCE(SUM(CASE WHEN ${cashTransactions.type} = 'out' THEN CAST(${cashTransactions.amount} AS NUMERIC) ELSE 0 END), 0)`,
      })
      .from(cashTransactions)
      .where(
        and(
          sql`${cashTransactions.createdAt} >= ${shift.openedAt}`,
          shift.closedAt
            ? sql`${cashTransactions.createdAt} <= ${shift.closedAt}`
            : sql`1=1`,
        ),
      );

    const cashIn = cashResult[0]?.totalIn || 0;
    const cashOut = cashResult[0]?.totalOut || 0;

    return openingBalance + cashSales + cashIn - cashOut;
  }

  async getShiftHistory(filters?: { userId?: string; limit?: number }) {
    return await this.db.query.shifts.findMany({
      where: filters?.userId ? eq(shifts.userId, filters.userId) : undefined,
      with: {
        user: true,
      },
      orderBy: [desc(shifts.openedAt)],
      limit: filters?.limit || 50,
    });
  }

  async getShiftById(id: string) {
    return await this.db.query.shifts.findFirst({
      where: eq(shifts.id, id),
      with: {
        user: true,
      },
    });
  }
}
