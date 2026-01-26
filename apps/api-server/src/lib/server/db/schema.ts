import { pgTable, text, timestamp, boolean, index } from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";

// ============================================
// Better-Auth Required Tables
// ============================================

export const user = pgTable("user", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  phoneNumber: text("phone_number").unique(),
  email: text("email").notNull().unique(),
  emailVerified: boolean("email_verified").default(false).notNull(),
  image: text("image"),
  firstName: text("first_name"),
  lastName: text("last_name"),
  accessLevel: text("access_level"), // e.g., 'Admin', 'User', 'Staff'
  isActive: boolean("is_active").default(true).notNull(),
  createdAt: timestamp("created_at").defaultNow().notNull(),
  updatedAt: timestamp("updated_at")
    .defaultNow()
    .$onUpdate(() => /* @__PURE__ */ new Date())
    .notNull(),
});

export const session = pgTable(
  "session",
  {
    id: text("id").primaryKey(),
    expiresAt: timestamp("expires_at").notNull(),
    token: text("token").notNull().unique(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => /* @__PURE__ */ new Date())
      .notNull(),
    ipAddress: text("ip_address"),
    userAgent: text("user_agent"),
    userId: text("user_id")
      .notNull()
      .references(() => user.id, { onDelete: "cascade" }),
  },
  (table) => [index("session_userId_idx").on(table.userId)],
);

export const account = pgTable(
  "account",
  {
    id: text("id").primaryKey(),
    accountId: text("account_id").notNull(),
    providerId: text("provider_id").notNull(),
    userId: text("user_id")
      .notNull()
      .references(() => user.id, { onDelete: "cascade" }),
    accessToken: text("access_token"),
    refreshToken: text("refresh_token"),
    idToken: text("id_token"),
    accessTokenExpiresAt: timestamp("access_token_expires_at"),
    refreshTokenExpiresAt: timestamp("refresh_token_expires_at"),
    scope: text("scope"),
    password: text("password"),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .$onUpdate(() => /* @__PURE__ */ new Date())
      .notNull(),
  },
  (table) => [index("account_userId_idx").on(table.userId)],
);

export const verification = pgTable(
  "verification",
  {
    id: text("id").primaryKey(),
    identifier: text("identifier").notNull(),
    value: text("value").notNull(),
    expiresAt: timestamp("expires_at").notNull(),
    createdAt: timestamp("created_at").defaultNow().notNull(),
    updatedAt: timestamp("updated_at")
      .defaultNow()
      .$onUpdate(() => /* @__PURE__ */ new Date())
      .notNull(),
  },
  (table) => [index("verification_identifier_idx").on(table.identifier)],
);

export const userRelations = relations(user, ({ many }) => ({
  sessions: many(session),
  accounts: many(account),
}));

export const sessionRelations = relations(session, ({ one }) => ({
  user: one(user, {
    fields: [session.userId],
    references: [user.id],
  }),
}));

export const accountRelations = relations(account, ({ one }) => ({
  user: one(user, {
    fields: [account.userId],
    references: [user.id],
  }),
}));

// ============================================
// Product Tables
// ============================================

export const productGroups = pgTable("product_groups", {
  id: text("id").primaryKey(),
  name: text("name").notNull(),
  parentId: text("parent_id"),
  description: text("description"),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const productGroupsParentRelations = relations(
  productGroups,
  ({ one }) => ({
    parent: one(productGroups, {
      fields: [productGroups.parentId],
      references: [productGroups.id],
      relationName: "parent_child",
    }),
  }),
);

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

// ============================================
// Customer Tables
// ============================================

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

// ============================================
// Company Tables
// ============================================

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

// ============================================
// Member Tables
// ============================================

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

// ============================================
// Stock Tables
// ============================================

export const stockMovements = pgTable("stock_movements", {
  id: text("id").primaryKey(),
  productId: text("product_id")
    .notNull()
    .references(() => products.id),
  type: text("type").notNull(), // 'in', 'out', 'adjustment'
  quantity: text("quantity").notNull(), // amount changed
  reason: text("reason"),
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
  createdAt: timestamp("created_at").notNull(),
});

export const stockMovementsRelations = relations(stockMovements, ({ one }) => ({
  product: one(products, {
    fields: [stockMovements.productId],
    references: [products.id],
  }),
  user: one(user, {
    fields: [stockMovements.userId],
    references: [user.id],
  }),
}));

export const productsStockRelations = relations(products, ({ many }) => ({
  movements: many(stockMovements),
}));

// ============================================
// Sales Tables
// ============================================

export const salesDocuments = pgTable("sales_documents", {
  id: text("id").primaryKey(),
  number: text("number").notNull().unique(), // e.g., INV-2025-001
  documentType: text("document_type").notNull(), // 'Faktur Penjualan', 'Retur Penjualan'
  refDocumentId: text("ref_document_id"), // for returns
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
  customerId: text("customer_id").references(() => customers.id),
  paymentType: text("payment_type"), // 'Cash', 'Credit Card', 'Bank Transfer'
  pos: text("pos"),
  date: timestamp("date").notNull(),
  discount: text("discount").notNull().default("0"),
  subtotal: text("subtotal").notNull().default("0"),
  tax: text("tax").notNull().default("0"),
  total: text("total").notNull().default("0"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const salesItems = pgTable("sales_items", {
  id: text("id").primaryKey(),
  documentId: text("document_id")
    .notNull()
    .references(() => salesDocuments.id, { onDelete: "cascade" }),
  productId: text("product_id").references(() => products.id),
  code: text("code"),
  name: text("name").notNull(),
  unit: text("unit"),
  quantity: text("quantity").notNull().default("0"),
  priceExcl: text("price_excl").notNull().default("0"),
  taxPercent: text("tax_percent").notNull().default("0"),
  price: text("price").notNull().default("0"),
  subtotal: text("subtotal").notNull().default("0"),
  discount: text("discount").notNull().default("0"),
  total: text("total").notNull().default("0"),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const salesDocumentsRelations = relations(
  salesDocuments,
  ({ one, many }) => ({
    user: one(user, {
      fields: [salesDocuments.userId],
      references: [user.id],
    }),
    customer: one(customers, {
      fields: [salesDocuments.customerId],
      references: [customers.id],
    }),
    items: many(salesItems),
    refDocument: one(salesDocuments, {
      fields: [salesDocuments.refDocumentId],
      references: [salesDocuments.id],
      relationName: "ref_document",
    }),
  }),
);

export const salesItemsRelations = relations(salesItems, ({ one }) => ({
  document: one(salesDocuments, {
    fields: [salesItems.documentId],
    references: [salesDocuments.id],
  }),
  product: one(products, {
    fields: [salesItems.productId],
    references: [products.id],
  }),
}));

// ============================================
// Cash Transaction Tables
// ============================================

export const cashTransactions = pgTable("cash_transactions", {
  id: text("id").primaryKey(),
  type: text("type").notNull(), // 'in', 'out'
  amount: text("amount").notNull().default("0"),
  description: text("description"),
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const cashTransactionsRelations = relations(
  cashTransactions,
  ({ one }) => ({
    user: one(user, {
      fields: [cashTransactions.userId],
      references: [user.id],
    }),
  }),
);

// ============================================
// Shift Management Tables
// ============================================

export const shifts = pgTable("shifts", {
  id: text("id").primaryKey(),
  userId: text("user_id")
    .notNull()
    .references(() => user.id),
  pos: text("pos"), // e.g., 'Utama', 'Cabang 1'
  openedAt: timestamp("opened_at").notNull(),
  closedAt: timestamp("closed_at"),
  openingBalance: text("opening_balance").notNull().default("0"),
  closingBalance: text("closing_balance"),
  expectedBalance: text("expected_balance"),
  discrepancy: text("discrepancy"),
  openingNote: text("opening_note"),
  closingNote: text("closing_note"),
  status: text("status").notNull().default("open"), // 'open', 'closed'
  createdAt: timestamp("created_at").notNull(),
  updatedAt: timestamp("updated_at").notNull(),
});

export const shiftsRelations = relations(shifts, ({ one }) => ({
  user: one(user, {
    fields: [shifts.userId],
    references: [user.id],
  }),
}));
