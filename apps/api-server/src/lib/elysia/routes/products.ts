import { Elysia, t } from "elysia";
import { db } from "@/server/db";
import {
  ProductService,
  TaxService,
  ProductGroupService,
  StorageLocationService,
} from "@/server/services";

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
  .patch(
    "/groups/:id",
    async ({ params: { id }, body, set }) => {
      const group = await groupService.updateGroup(id, body);
      if (!group) {
        set.status = 404;
        return "Group not found";
      }
      return group;
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
        parentId: t.Optional(t.Nullable(t.String())),
        description: t.Optional(t.Nullable(t.String())),
        isActive: t.Optional(t.Boolean()),
      }),
    },
  )
  .delete("/groups/:id", async ({ params: { id }, set }) => {
    const result = await groupService.deleteGroup(id);
    if (!result.group) {
      set.status = 404;
      return "Group not found";
    }

    if (result.action === "deactivated") {
      return {
        success: true,
        action: "deactivated",
        message:
          "Grup tidak bisa dihapus karena masih digunakan. Grup telah dinonaktifkan secara otomatis.",
      };
    }

    return { success: true, action: "deleted" };
  })

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
  .patch(
    "/taxes/:id",
    async ({ params: { id }, body, set }) => {
      const tax = await taxService.updateTax(id, body);
      if (!tax) {
        set.status = 404;
        return "Tax not found";
      }
      return tax;
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
        rate: t.Optional(t.String()),
        code: t.Optional(t.String()),
        isFixed: t.Optional(t.Boolean()),
        isEnabled: t.Optional(t.Boolean()),
      }),
    },
  )
  .delete("/taxes/:id", async ({ params: { id }, set }) => {
    const result = await taxService.deleteTax(id);
    if (!result.tax) {
      set.status = 404;
      return "Tax not found";
    }

    if (result.action === "deactivated") {
      return {
        success: true,
        action: "deactivated",
        message:
          "Pajak tidak bisa dihapus karena masih digunakan. Pajak telah dinonaktifkan secara otomatis.",
      };
    }

    return { success: true, action: "deleted" };
  })

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
  .patch(
    "/locations/:id",
    async ({ params: { id }, body, set }) => {
      const location = await locationService.updateLocation(id, body);
      if (!location) {
        set.status = 404;
        return "Location not found";
      }
      return location;
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
      }),
    },
  )
  .delete("/locations/:id", async ({ params: { id }, set }) => {
    try {
      const location = await locationService.deleteLocation(id);
      if (!location) {
        set.status = 404;
        return "Location not found";
      }
      return { success: true };
    } catch (error: any) {
      if (error.code === "23503" || error.cause?.code === "23503") {
        set.status = 409;
        return {
          error: "Conflict",
          message:
            "Lokasi simpan tidak bisa dihapus karena masih digunakan oleh produk.",
        };
      }
      throw error;
    }
  })

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
    const result = await productService.deleteProduct(id);
    if (!result.product) {
      set.status = 404;
      return "Product not found";
    }

    if (result.action === "deactivated") {
      return {
        success: true,
        action: "deactivated",
        message:
          "Produk tidak bisa dihapus karena sudah memiliki data transaksi. Produk telah dinonaktifkan secara otomatis.",
      };
    }

    return { success: true, action: "deleted" };
  });
