import { pgTable, text, timestamp, boolean } from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

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
  code: text("code"),
  rate: text("rate").notNull(), // text to handle percentage precisely or numeric
  isFixed: boolean("is_fixed").notNull().default(false),
  isEnabled: boolean("is_enabled").notNull().default(true),
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

export const productGroupsRelations = relations(productGroups, ({ many }) => ({
  products: many(products),
}));

export const taxesRelations = relations(taxes, ({ many }) => ({
  products: many(products),
}));

export const storageLocationsRelations = relations(
  storageLocations,
  ({ many }) => ({
    products: many(products),
  }),
);

export const productsRelations = relations(products, ({ one }) => ({
  group: one(productGroups, {
    fields: [products.groupId],
    references: [productGroups.id],
  }),
  tax: one(taxes, {
    fields: [products.taxId],
    references: [taxes.id],
  }),
  storageLocation: one(storageLocations, {
    fields: [products.storageLocationId],
    references: [storageLocations.id],
  }),
}));

export const customers = pgTable("customers", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  code: text("code"),
  taxNumber: text("tax_number"),
  streetName: text("street_name"),
  buildingNumber: text("building_number"),
  additionalStreetName: text("additional_street_name"),
  plotIdentification: text("plot_identification"),
  district: text("district"),
  postalCode: text("postal_code"),
  city: text("city"),
  state: text("state"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const companies = pgTable("companies", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  taxNumber: text("tax_number"),
  streetName: text("street_name"),
  buildingNumber: text("building_number"),
  additionalStreetName: text("additional_street_name"),
  plotIdentification: text("plot_identification"),
  district: text("district"),
  postalCode: text("postal_code"),
  city: text("city"),
  province: text("province"),
  country: text("country"),
  phone: text("phone"),
  email: text("email"),
  bankAccountNumber: text("bank_account_number"),
  bankDetails: text("bank_details"),
  logo: text("logo"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const members = pgTable("members", {
  id: text("id").primaryKey(),
  fullName: text("full_name").notNull(),
  identityNumber: text("identity_number"),
  phoneNumber: text("phone_number"),
  email: text("email"),
  initialDeposit: text("initial_deposit").notNull().default("0"),
  loyaltyLevel: text("loyalty_level").notNull().default("Bronze"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const stockMovements = pgTable("stock_movements", {
  id: text("id").primaryKey(),
  productId: text("product_id")
    .notNull()
    .references(() => products.id),
  type: text("type").notNull(), // 'in', 'out', 'adjustment'
  quantity: text("quantity").notNull(), // amount changed
  reason: text("reason"),
  createdAt: timestamp("created_at").notNull(),
});

export const stockMovementsRelations = relations(stockMovements, ({ one }) => ({
  product: one(products, {
    fields: [stockMovements.productId],
    references: [products.id],
  }),
}));

export const productsStockRelations = relations(products, ({ many }) => ({
  movements: many(stockMovements),
}));
