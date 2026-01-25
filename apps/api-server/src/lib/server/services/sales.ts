import { db } from "../db";
import * as schema from "../db/schema";
import { eq, desc } from "drizzle-orm";
import { faker } from "@faker-js/faker";
import type { PostgresJsDatabase } from "drizzle-orm/postgres-js";

export class SalesService {
  constructor(private db: PostgresJsDatabase<typeof schema>) {}

  async getAllDocuments() {
    return await this.db.query.salesDocuments.findMany({
      with: {
        user: true,
        customer: true,
        items: true,
      },
      orderBy: [desc(schema.salesDocuments.date)],
    });
  }

  async getDocumentById(id: string) {
    return await this.db.query.salesDocuments.findFirst({
      where: eq(schema.salesDocuments.id, id),
      with: {
        user: true,
        customer: true,
        items: true,
      },
    });
  }

  async createDocument(data: {
    number: string;
    documentType: string;
    userId: string;
    customerId?: string;
    pos?: string;
    date: Date;
    items: {
      productId?: string;
      code?: string;
      name: string;
      unit?: string;
      quantity: string;
      priceExcl: string;
      taxPercent: string;
      price: string;
      subtotal: string;
      discount: string;
      total: string;
    }[];
  }) {
    const docId = faker.string.uuid();

    // Calculate totals if not provided or to ensure consistency
    let subtotal = 0;
    let tax = 0;
    let total = 0;

    for (const item of data.items) {
      subtotal += parseFloat(item.subtotal);
      total += parseFloat(item.total);
    }
    tax = total - subtotal;

    await db.transaction(async (tx) => {
      await tx.insert(schema.salesDocuments).values({
        id: docId,
        number: data.number,
        documentType: data.documentType,
        userId: data.userId,
        customerId: data.customerId,
        pos: data.pos,
        date: data.date,
        subtotal: subtotal.toString(),
        tax: tax.toFixed(2),
        total: total.toFixed(2),
        createdAt: new Date(),
        updatedAt: new Date(),
      });

      const itemsWithIds = data.items.map((item) => ({
        ...item,
        id: faker.string.uuid(),
        documentId: docId,
        createdAt: new Date(),
        updatedAt: new Date(),
      }));

      await tx.insert(schema.salesItems).values(itemsWithIds);
    });

    return this.getDocumentById(docId);
  }

  async deleteDocument(id: string) {
    await this.db
      .delete(schema.salesDocuments)
      .where(eq(schema.salesDocuments.id, id));
  }
}
