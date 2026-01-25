import { Elysia, t } from "elysia";
import { db } from "../index";
import {
  products,
  productGroups,
  taxes,
  storageLocations,
} from "@cashier/database";
import { eq } from "drizzle-orm";

export const productRoutes = new Elysia({ prefix: "/products" })
  // --- Product Groups ---
  .get("/groups", async () => {
    return await db.select().from(productGroups);
  })
  .post(
    "/groups",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      await db.insert(productGroups).values({
        id,
        name: body.name,
        createdAt: now,
        updatedAt: now,
      });
      return { id };
    },
    {
      body: t.Object({
        name: t.String(),
      }),
    },
  )

  // --- Taxes ---
  .get("/taxes", async () => {
    return await db.select().from(taxes);
  })
  .post(
    "/taxes",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      await db.insert(taxes).values({
        id,
        name: body.name,
        rate: body.rate,
        createdAt: now,
        updatedAt: now,
      });
      return { id };
    },
    {
      body: t.Object({
        name: t.String(),
        rate: t.String(),
      }),
    },
  )

  // --- Storage Locations ---
  .get("/locations", async () => {
    return await db.select().from(storageLocations);
  })
  .post(
    "/locations",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      await db.insert(storageLocations).values({
        id,
        name: body.name,
        createdAt: now,
        updatedAt: now,
      });
      return { id };
    },
    {
      body: t.Object({
        name: t.String(),
      }),
    },
  )

  // --- Products ---
  .get("/", async () => {
    return await db.select().from(products);
  })
  .get("/:id", async ({ params: { id }, set }) => {
    const result = await db
      .select()
      .from(products)
      .where(eq(products.id, id))
      .limit(1);
    if (result.length === 0) {
      set.status = 404;
      return "Product not found";
    }
    return result[0];
  })
  .post(
    "/",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      await db.insert(products).values({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return { id };
    },
    {
      body: t.Object({
        name: t.String(),
        code: t.Optional(t.String()),
        barcode: t.Optional(t.String()),
        unit: t.Optional(t.String()),
        groupId: t.Optional(t.String()),
        isActive: t.Optional(t.Boolean()),
        isDefaultQuantity: t.Optional(t.Boolean()),
        isService: t.Optional(t.Boolean()),
        ageRestriction: t.Optional(t.String()),
        description: t.Optional(t.String()),
        cost: t.Optional(t.String()),
        markup: t.Optional(t.String()),
        salePrice: t.Optional(t.String()),
        taxId: t.Optional(t.String()),
        priceIncludesTax: t.Optional(t.Boolean()),
        priceChangeAllowed: t.Optional(t.Boolean()),
        enableInventoryTracking: t.Optional(t.Boolean()),
        stockQuantity: t.Optional(t.String()),
        storageLocationId: t.Optional(t.String()),
        minStockLevel: t.Optional(t.String()),
        reorderPoint: t.Optional(t.String()),
        image: t.Optional(t.String()),
        color: t.Optional(t.String()),
        internalComments: t.Optional(t.String()),
        receiptNotes: t.Optional(t.String()),
        supplierNotes: t.Optional(t.String()),
      }),
    },
  )
  .patch(
    "/:id",
    async ({ params: { id }, body, set }) => {
      const now = new Date();
      const result = await db
        .update(products)
        .set({
          ...body,
          updatedAt: now,
        })
        .where(eq(products.id, id))
        .returning();

      if (result.length === 0) {
        set.status = 404;
        return "Product not found";
      }
      return result[0];
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
        code: t.Optional(t.String()),
        barcode: t.Optional(t.String()),
        unit: t.Optional(t.String()),
        groupId: t.Optional(t.String()),
        isActive: t.Optional(t.Boolean()),
        isDefaultQuantity: t.Optional(t.Boolean()),
        isService: t.Optional(t.Boolean()),
        ageRestriction: t.Optional(t.String()),
        description: t.Optional(t.String()),
        cost: t.Optional(t.String()),
        markup: t.Optional(t.String()),
        salePrice: t.Optional(t.String()),
        taxId: t.Optional(t.String()),
        priceIncludesTax: t.Optional(t.Boolean()),
        priceChangeAllowed: t.Optional(t.Boolean()),
        enableInventoryTracking: t.Optional(t.Boolean()),
        stockQuantity: t.Optional(t.String()),
        storageLocationId: t.Optional(t.String()),
        minStockLevel: t.Optional(t.String()),
        reorderPoint: t.Optional(t.String()),
        image: t.Optional(t.String()),
        color: t.Optional(t.String()),
        internalComments: t.Optional(t.String()),
        receiptNotes: t.Optional(t.String()),
        supplierNotes: t.Optional(t.String()),
      }),
    },
  )
  .delete("/:id", async ({ params: { id }, set }) => {
    const result = await db
      .delete(products)
      .where(eq(products.id, id))
      .returning();
    if (result.length === 0) {
      set.status = 404;
      return "Product not found";
    }
    return { success: true };
  });
