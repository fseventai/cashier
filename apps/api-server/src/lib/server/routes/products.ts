import { Elysia, t } from "elysia";
import { db } from "../index";
import {
  ProductService,
  TaxService,
  ProductGroupService,
  StorageLocationService,
} from "@cashier/database";

const productService = new ProductService(db);
const taxService = new TaxService(db);
const groupService = new ProductGroupService(db);
const locationService = new StorageLocationService(db);

export const productRoutes = new Elysia({ prefix: "/products" })
  // --- Product Groups ---
  .get("/groups", async () => {
    return await groupService.getGroups();
  })
  .post(
    "/groups",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const group = await groupService.createGroup({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return group;
    },
    {
      body: t.Object({
        name: t.String(),
      }),
    },
  )

  // --- Taxes ---
  .get("/taxes", async () => {
    return await taxService.getTaxes();
  })
  .post(
    "/taxes",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const tax = await taxService.createTax({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return tax;
    },
    {
      body: t.Object({
        name: t.String(),
        rate: t.String(),
        code: t.Optional(t.String()),
        isFixed: t.Optional(t.Boolean()),
        isEnabled: t.Optional(t.Boolean()),
      }),
    },
  )

  // --- Storage Locations ---
  .get("/locations", async () => {
    return await locationService.getLocations();
  })
  .post(
    "/locations",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const location = await locationService.createLocation({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return location;
    },
    {
      body: t.Object({
        name: t.String(),
      }),
    },
  )

  // --- Products ---
  .get("/", async () => {
    return await productService.getProducts();
  })
  .get("/:id", async ({ params: { id }, set }) => {
    const product = await productService.getProductById(id);
    if (!product) {
      set.status = 404;
      return "Product not found";
    }
    return product;
  })
  .post(
    "/",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const product = await productService.createProduct({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return product;
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
      const product = await productService.updateProduct(id, body);
      if (!product) {
        set.status = 404;
        return "Product not found";
      }
      return product;
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
    const product = await productService.deleteProduct(id);
    if (!product) {
      set.status = 404;
      return "Product not found";
    }
    return { success: true };
  });
