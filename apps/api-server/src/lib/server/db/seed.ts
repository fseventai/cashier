import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { faker } from "@faker-js/faker";
import { DATABASE_URL } from "$env/static/private";
import * as schema from "./schema";

if (!DATABASE_URL) {
  throw new Error("DATABASE_URL is not defined");
}

const client = postgres(DATABASE_URL);
const db = drizzle(client, { schema });

async function seed() {
  console.log("🌱 Starting seed...");

  try {
    // 1. Cleanup (Optional: be careful with this in production!)
    // For now, we will just append or maybe clean specific tables if needed.
    // Let's clean up for a fresh start in development.
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

    // 2. Users
    const usersData = Array.from({ length: 5 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.person.fullName(),
      email: faker.internet.email(),
      emailVerified: true,
      image: faker.image.avatar(),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));

    await db.insert(schema.user).values(usersData);
    console.log(`👤 Created ${usersData.length} users`);

    // 3. Product Groups
    const groupsData = Array.from({ length: 5 }).map(() => ({
      id: faker.string.uuid(),
      name: faker.commerce.department(),
      createdAt: new Date(),
      updatedAt: new Date(),
    }));

    await db.insert(schema.productGroups).values(groupsData);
    console.log(`📦 Created ${groupsData.length} product groups`);

    // 4. Taxes
    const taxesData = [
      {
        id: faker.string.uuid(),
        name: "PPN",
        rate: "0.11",
        code: "PPN",
        isFixed: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      },
      {
        id: faker.string.uuid(),
        name: "No Tax",
        rate: "0",
        code: "NONE",
        isFixed: false,
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
        image: faker.image.urlLoremFlickr({ category: "food" }),
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
      createdAt: new Date(),
    }));
    await db.insert(schema.stockMovements).values(movementsData);
    console.log(`📈 Created ${movementsData.length} stock movements`);

    console.log("✅ Seed completed successfully");
  } catch (error) {
    console.error("❌ Seed failed:", error);
    process.exit(1);
  } finally {
    await client.end();
  }
}

seed();
