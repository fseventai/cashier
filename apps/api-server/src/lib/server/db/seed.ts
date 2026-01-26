import "dotenv/config";
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { faker } from "@faker-js/faker";
import * as schema from "./schema";

if (!process.env.DATABASE_URL) {
  throw new Error("DATABASE_URL is not defined");
}

const client = postgres(process.env.DATABASE_URL);
const db = drizzle(client, { schema });

async function seed() {
  console.log("🌱 Starting seed...");

  try {
    // 1. Cleanup (Optional: be careful with this in production!)
    // For now, we will just append or maybe clean specific tables if needed.
    // Let's clean up for a fresh start in development.
    await db.delete(schema.salesItems);
    await db.delete(schema.salesDocuments);
    await db.delete(schema.stockMovements);
    await db.delete(schema.products);
    await db.delete(schema.productGroups);
    await db.delete(schema.taxes);
    await db.delete(schema.storageLocations);
    await db.delete(schema.members);
    await db.delete(schema.customers);
    await db.delete(schema.companies);
    await db.delete(schema.session);
    await db.delete(schema.account);
    await db.delete(schema.user);

    console.log("🧹 Cleaned up existing data");

    // ... (rest of the insertions) ...
    // 2. Users (continued below)

    // 2. Users
    const usersData = Array.from({ length: 5 }).map(() => {
      const firstName = faker.person.firstName();
      const lastName = faker.person.lastName();
      return {
        id: faker.string.uuid(),
        name: `${firstName} ${lastName}`,
        firstName,
        lastName,
        email: faker.internet.email(),
        emailVerified: true,
        image: faker.image.avatar(),
        accessLevel: faker.helpers.arrayElement(["Admin", "User", "Staff"]),
        isActive: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      };
    });

    await db.insert(schema.user).values(usersData);
    console.log(`👤 Created ${usersData.length} users`);

    // 3. Product Groups
    const rootGroup = {
      id: faker.string.uuid(),
      name: "Products (Root)",
      description: "Root group for products",
      isActive: true,
      parentId: null,
      createdAt: new Date(),
      updatedAt: new Date(),
    };

    const groupsData = Array.from({ length: 5 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.commerce.department(),
      description: faker.lorem.sentence(),
      isActive: true,
      parentId: rootGroup.id,
      createdAt: new Date(),
      updatedAt: new Date(),
    }));

    await db.insert(schema.productGroups).values([rootGroup, ...groupsData]);
    console.log(`📦 Created ${groupsData.length} product groups`);

    // 4. Taxes
    const taxesData = [
      {
        id: faker.string.uuid(),
        name: "PPN",
        rate: "11",
        code: "PPN11",
        isFixed: false,
        isEnabled: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        id: faker.string.uuid(),
        name: "PPN 12%",
        rate: "12",
        code: "PPN12",
        isFixed: false,
        isEnabled: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        id: faker.string.uuid(),
        name: "No Tax",
        rate: "0",
        code: "NONE",
        isFixed: false,
        isEnabled: true,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
    ];
    await db.insert(schema.taxes).values(taxesData);
    console.log(`💰 Created ${taxesData.length} taxes`);

    // 5. Storage Locations
    const locationsData = Array.from({ length: 3 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.location.city(),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));
    await db.insert(schema.storageLocations).values(locationsData);
    console.log(`📍 Created ${locationsData.length} storage locations`);

    // 6. Products
    const productsData = [];
    for (let i = 0; i < 50; i++) {
      const group = faker.helpers.arrayElement(groupsData);
      const tax = faker.helpers.arrayElement(taxesData);
      const location = faker.helpers.arrayElement(locationsData);

      productsData.push({
        id: faker.string.uuid(),
        name: faker.commerce.productName(),
        code: faker.commerce.isbn(),
        barcode: faker.string.numeric(13),
        unit: "pcs",
        groupId: group.id,
        isActive: true,
        isDefaultQuantity: true,
        isService: false,
        description: faker.commerce.productDescription(),
        cost: faker.commerce.price({ min: 1000, max: 50000 }),
        markup: "0", // Simplified
        salePrice: faker.commerce.price({ min: 60000, max: 150000 }),
        taxId: tax.id,
        priceIncludesTax: true,
        storageLocationId: location.id,
        stockQuantity: faker.number.int({ min: 0, max: 100 }).toString(),
        minStockLevel: "10",
        reorderPoint: "20",
        image: faker.image.url(),
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }
    await db.insert(schema.products).values(productsData);
    console.log(`🍔 Created ${productsData.length} products`);

    // 7. Companies
    const companiesData = Array.from({ length: 3 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.company.name(),
      email: faker.internet.email(),
      phone: faker.phone.number(),
      streetName: faker.location.street(),
      city: faker.location.city(),
      country: faker.location.country(),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));
    await db.insert(schema.companies).values(companiesData);
    console.log(`🏢 Created ${companiesData.length} companies`);

    // 8. Customers
    const customersData = Array.from({ length: 10 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.person.fullName(),
      code: faker.string.alphanumeric(6).toUpperCase(),
      email: faker.internet.email(),
      phone: faker.phone.number(),
      city: faker.location.city(),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));
    await db.insert(schema.customers).values(customersData);
    console.log(`👥 Created ${customersData.length} customers`);

    // 9. Members
    const membersData = Array.from({ length: 10 }).map(() => ({
      id: faker.string.uuid(),
      fullName: faker.person.fullName(),
      email: faker.internet.email(),
      phoneNumber: faker.phone.number(),
      loyaltyLevel: faker.helpers.arrayElement([
        "Bronze",
        "Silver",
        "Gold",
        "Platinum",
      ]),
      initialDeposit: faker.commerce.price({ min: 0, max: 1000000 }),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));
    await db.insert(schema.members).values(membersData);
    console.log(`🏅 Created ${membersData.length} members`);

    // 10. Stock Movements (Initial)
    const movementsData = productsData.map((p) => ({
      id: faker.string.uuid(),
      productId: p.id,
      type: "adjustment",
      quantity: p.stockQuantity,
      reason: "Initial Seed",
      userId: faker.helpers.arrayElement(usersData).id,
      createdAt: new Date(),
    }));
    await db.insert(schema.stockMovements).values(movementsData);
    console.log(`📈 Created ${movementsData.length} stock movements`);

    // 11. Sales Documents & Items
    console.log(
      "📑 Creating sales documents and items (50 records for dashboard)...",
    );
    for (let i = 0; i < 50; i++) {
      const u = faker.helpers.arrayElement(usersData);
      const c = faker.helpers.arrayElement(customersData);
      const docId = faker.string.uuid();

      // Randomly choose between Invoice and Return
      const docType = faker.helpers.weightedArrayElement([
        { weight: 9, value: "Faktur Penjualan" },
        { weight: 1, value: "Retur Penjualan" },
      ]);
      const isReturn = docType === "Retur Penjualan";

      const paymentType = faker.helpers.arrayElement([
        "Cash",
        "Credit Card",
        "Bank Transfer",
        "E-Wallet",
      ]);

      // Spread dates across the year 2025
      const month = faker.number.int({ min: 0, max: 11 });
      const day = faker.number.int({ min: 1, max: 28 });
      const hour = faker.number.int({ min: 8, max: 21 }); // Business hours
      const date = new Date(
        2025,
        month,
        day,
        hour,
        faker.number.int({ min: 0, max: 59 }),
      );

      const itemsCount = faker.number.int({ min: 1, max: 8 });
      const items = [];
      let subtotal = 0;
      let totalTax = 0;

      for (let j = 0; j < itemsCount; j++) {
        const product = faker.helpers.arrayElement(productsData);
        const qty = faker.number.int({ min: 1, max: 5 }) * (isReturn ? -1 : 1);
        const priceExcl = parseFloat(product.salePrice);
        const taxRate = 0.11;
        const price = priceExcl * (1 + taxRate);
        const itemSubtotal = priceExcl * qty;
        const itemTotal = price * qty;
        const itemTax = itemTotal - itemSubtotal;

        subtotal += itemSubtotal;
        totalTax += itemTax;

        items.push({
          id: faker.string.uuid(),
          documentId: docId,
          productId: product.id,
          code: product.code,
          name: product.name,
          unit: product.unit,
          quantity: qty.toString(),
          priceExcl: priceExcl.toString(),
          taxPercent: "11",
          price: price.toFixed(2),
          subtotal: itemSubtotal.toString(),
          discount: "0",
          total: itemTotal.toFixed(2),
          createdAt: date,
          updatedAt: date,
        });
      }

      const total = subtotal + totalTax;

      await db.insert(schema.salesDocuments).values({
        id: docId,
        number: isReturn
          ? `RET-2025-${(i + 1).toString().padStart(4, "0")}`
          : `INV-2025-${(i + 1).toString().padStart(4, "0")}`,
        documentType: docType,
        paymentType: isReturn ? null : paymentType, // Returns usually don't have a direct payment type or handle it differently
        userId: u.id,
        customerId: c.id,
        pos: faker.helpers.arrayElement(["Utama", "Cabang 1", "Cabang 2"]),
        date: date,
        discount: "0",
        subtotal: subtotal.toString(),
        tax: totalTax.toFixed(2),
        total: total.toFixed(2),
        createdAt: date,
        updatedAt: date,
      });

      await db.insert(schema.salesItems).values(items);
    }
    console.log(`✅ Created 100 sales documents for year 2025`);

    console.log("✅ Seed completed successfully");
  } catch (error) {
    console.error("❌ Seed failed:", error);
    process.exit(1);
  } finally {
    await client.end();
  }
}

seed();
