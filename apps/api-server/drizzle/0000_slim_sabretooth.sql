CREATE TABLE "account" (
	"id" text PRIMARY KEY NOT NULL,
	"account_id" text NOT NULL,
	"provider_id" text NOT NULL,
	"user_id" text NOT NULL,
	"access_token" text,
	"refresh_token" text,
	"id_token" text,
	"access_token_expires_at" timestamp,
	"refresh_token_expires_at" timestamp,
	"scope" text,
	"password" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "cash_transactions" (
	"id" text PRIMARY KEY NOT NULL,
	"type" text NOT NULL,
	"amount" text DEFAULT '0' NOT NULL,
	"description" text,
	"user_id" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "companies" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"tax_number" text,
	"street_name" text,
	"building_number" text,
	"additional_street_name" text,
	"plot_identification" text,
	"district" text,
	"postal_code" text,
	"city" text,
	"province" text,
	"country" text,
	"phone" text,
	"email" text,
	"bank_account_number" text,
	"bank_details" text,
	"logo" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "customers" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"code" text,
	"tax_number" text,
	"street_name" text,
	"building_number" text,
	"additional_street_name" text,
	"plot_identification" text,
	"district" text,
	"postal_code" text,
	"city" text,
	"state" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "members" (
	"id" text PRIMARY KEY NOT NULL,
	"full_name" text NOT NULL,
	"identity_number" text,
	"phone_number" text,
	"email" text,
	"initial_deposit" text DEFAULT '0' NOT NULL,
	"loyalty_level" text DEFAULT 'Bronze' NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "product_groups" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "products" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"code" text,
	"barcode" text,
	"unit" text,
	"group_id" text,
	"is_active" boolean DEFAULT true NOT NULL,
	"is_default_quantity" boolean DEFAULT true NOT NULL,
	"is_service" boolean DEFAULT false NOT NULL,
	"age_restriction" text,
	"description" text,
	"cost" text DEFAULT '0' NOT NULL,
	"markup" text DEFAULT '0' NOT NULL,
	"sale_price" text DEFAULT '0' NOT NULL,
	"tax_id" text,
	"price_includes_tax" boolean DEFAULT true NOT NULL,
	"price_change_allowed" boolean DEFAULT false NOT NULL,
	"enable_inventory_tracking" boolean DEFAULT true NOT NULL,
	"stock_quantity" text DEFAULT '0' NOT NULL,
	"storage_location_id" text,
	"min_stock_level" text DEFAULT '0' NOT NULL,
	"reorder_point" text DEFAULT '0' NOT NULL,
	"image" text,
	"color" text,
	"internal_comments" text,
	"receipt_notes" text,
	"supplier_notes" text,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "sales_documents" (
	"id" text PRIMARY KEY NOT NULL,
	"number" text NOT NULL,
	"document_type" text NOT NULL,
	"ref_document_id" text,
	"user_id" text NOT NULL,
	"customer_id" text,
	"payment_type" text,
	"pos" text,
	"date" timestamp NOT NULL,
	"discount" text DEFAULT '0' NOT NULL,
	"subtotal" text DEFAULT '0' NOT NULL,
	"tax" text DEFAULT '0' NOT NULL,
	"total" text DEFAULT '0' NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	CONSTRAINT "sales_documents_number_unique" UNIQUE("number")
);
--> statement-breakpoint
CREATE TABLE "sales_items" (
	"id" text PRIMARY KEY NOT NULL,
	"document_id" text NOT NULL,
	"product_id" text,
	"code" text,
	"name" text NOT NULL,
	"unit" text,
	"quantity" text DEFAULT '0' NOT NULL,
	"price_excl" text DEFAULT '0' NOT NULL,
	"tax_percent" text DEFAULT '0' NOT NULL,
	"price" text DEFAULT '0' NOT NULL,
	"subtotal" text DEFAULT '0' NOT NULL,
	"discount" text DEFAULT '0' NOT NULL,
	"total" text DEFAULT '0' NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "session" (
	"id" text PRIMARY KEY NOT NULL,
	"expires_at" timestamp NOT NULL,
	"token" text NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp NOT NULL,
	"ip_address" text,
	"user_agent" text,
	"user_id" text NOT NULL,
	CONSTRAINT "session_token_unique" UNIQUE("token")
);
--> statement-breakpoint
CREATE TABLE "stock_movements" (
	"id" text PRIMARY KEY NOT NULL,
	"product_id" text NOT NULL,
	"type" text NOT NULL,
	"quantity" text NOT NULL,
	"reason" text,
	"created_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "storage_locations" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "taxes" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"code" text,
	"rate" text NOT NULL,
	"is_fixed" boolean DEFAULT false NOT NULL,
	"is_enabled" boolean DEFAULT true NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "user" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"phone_number" text,
	"email" text NOT NULL,
	"email_verified" boolean DEFAULT false NOT NULL,
	"image" text,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "user_phone_number_unique" UNIQUE("phone_number"),
	CONSTRAINT "user_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "verification" (
	"id" text PRIMARY KEY NOT NULL,
	"identifier" text NOT NULL,
	"value" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
ALTER TABLE "account" ADD CONSTRAINT "account_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "cash_transactions" ADD CONSTRAINT "cash_transactions_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "products" ADD CONSTRAINT "products_group_id_product_groups_id_fk" FOREIGN KEY ("group_id") REFERENCES "public"."product_groups"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "products" ADD CONSTRAINT "products_tax_id_taxes_id_fk" FOREIGN KEY ("tax_id") REFERENCES "public"."taxes"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "products" ADD CONSTRAINT "products_storage_location_id_storage_locations_id_fk" FOREIGN KEY ("storage_location_id") REFERENCES "public"."storage_locations"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales_documents" ADD CONSTRAINT "sales_documents_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales_documents" ADD CONSTRAINT "sales_documents_customer_id_customers_id_fk" FOREIGN KEY ("customer_id") REFERENCES "public"."customers"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales_items" ADD CONSTRAINT "sales_items_document_id_sales_documents_id_fk" FOREIGN KEY ("document_id") REFERENCES "public"."sales_documents"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "sales_items" ADD CONSTRAINT "sales_items_product_id_products_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "session" ADD CONSTRAINT "session_user_id_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "stock_movements" ADD CONSTRAINT "stock_movements_product_id_products_id_fk" FOREIGN KEY ("product_id") REFERENCES "public"."products"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "account_userId_idx" ON "account" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "session_userId_idx" ON "session" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "verification_identifier_idx" ON "verification" USING btree ("identifier");