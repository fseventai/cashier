import { pgTable, text, timestamp, boolean } from "drizzle-orm/pg-core";

export const user = pgTable("user", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  email: text("email").notNull().unique(),
  emailVerified: boolean("email_verified").notNull(),
  image: text("image"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const session = pgTable("session", {
  id: text("id").primaryKey(),
  expiresAt: timestamp("expires_at").notNull(),
  token: text("token").notNull().unique(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
  ipAddress: text("ip_address"),
  userAgent: text("user_agent"),
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
});

export const account = pgTable("account", {
  id: text("id").primaryKey(),
  accountId: text("account_id").notNull(),
  providerId: text("provider_id").notNull(),
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
  accessToken: text("access_token"),
  refreshToken: text("refresh_token"),
  idToken: text("id_token"),
  accessTokenExpiresAt: timestamp("access_token_expires_at"),
  refreshTokenExpiresAt: timestamp("refresh_token_expires_at"),
  scope: text("scope"),
  password: text("password"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const verification = pgTable("verification", {
  id: text("id").primaryKey(),
  identifier: text("identifier").notNull(),
  value: text("value").notNull(),
  expiresAt: timestamp("expires_at").notNull(),
  createdAt: timestamp("created_at"),
  updatedAt: timestamp("updated_at"),
});

export const productGroups = pgTable("product_groups", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const taxes = pgTable("taxes", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  rate: text("rate").notNull(), // text to handle percentage precisely or numeric
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const storageLocations = pgTable("storage_locations", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const products = pgTable("products", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  code: text("code"),
  barcode: text("barcode"),
  unit: text("unit"),
  groupId: text("group_id").references(() => productGroups.id),
  isActive: boolean("is_active").notNull().default(true),
  isDefaultQuantity: boolean("is_default_quantity").notNull().default(true),
  isService: boolean("is_service").notNull().default(false),
  ageRestriction: text("age_restriction"), // Store as string to handle empty/null easily from UI
  description: text("description"),
  cost: text("cost").notNull().default("0"),
  markup: text("markup").notNull().default("0"),
  salePrice: text("sale_price").notNull().default("0"),
  taxId: text("tax_id").references(() => taxes.id),
  priceIncludesTax: boolean("price_includes_tax").notNull().default(true),
  priceChangeAllowed: boolean("price_change_allowed").notNull().default(false),
  enableInventoryTracking: boolean("enable_inventory_tracking")
    .notNull()
    .default(true),
  stockQuantity: text("stock_quantity").notNull().default("0"),
  storageLocationId: text("storage_location_id").references(
    () => storageLocations.id,
  ),
  minStockLevel: text("min_stock_level").notNull().default("0"),
  reorderPoint: text("reorder_point").notNull().default("0"),
  image: text("image"),
  color: text("color"),
  internalComments: text("internal_comments"),
  receiptNotes: text("receipt_notes"),
  supplierNotes: text("supplier_notes"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});
