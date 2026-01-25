import { Elysia, t } from "elysia";
import { db } from "../index";
import { CustomerService } from "@cashier/database";

const customerService = new CustomerService(db);

export const customerRoutes = new Elysia({ prefix: "/customers" })
  .get("/", async () => {
    return await customerService.getCustomers();
  })
  .get("/:id", async ({ params: { id }, set }) => {
    const customer = await customerService.getCustomerById(id);
    if (!customer) {
      set.status = 404;
      return "Customer not found";
    }
    return customer;
  })
  .post(
    "/",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const customer = await customerService.createCustomer({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return customer;
    },
    {
      body: t.Object({
        name: t.String(),
        code: t.Optional(t.String()),
        taxNumber: t.Optional(t.String()),
        streetName: t.Optional(t.String()),
        buildingNumber: t.Optional(t.String()),
        additionalStreetName: t.Optional(t.String()),
        plotIdentification: t.Optional(t.String()),
        district: t.Optional(t.String()),
        postalCode: t.Optional(t.String()),
        city: t.Optional(t.String()),
        state: t.Optional(t.String()),
      }),
    },
  )
  .patch(
    "/:id",
    async ({ params: { id }, body, set }) => {
      const customer = await customerService.updateCustomer(id, body);
      if (!customer) {
        set.status = 404;
        return "Customer not found";
      }
      return customer;
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
        code: t.Optional(t.String()),
        taxNumber: t.Optional(t.String()),
        streetName: t.Optional(t.String()),
        buildingNumber: t.Optional(t.String()),
        additionalStreetName: t.Optional(t.String()),
        plotIdentification: t.Optional(t.String()),
        district: t.Optional(t.String()),
        postalCode: t.Optional(t.String()),
        city: t.Optional(t.String()),
        state: t.Optional(t.String()),
      }),
    },
  )
  .delete("/:id", async ({ params: { id }, set }) => {
    const customer = await customerService.deleteCustomer(id);
    if (!customer) {
      set.status = 404;
      return "Customer not found";
    }
    return { success: true };
  });
