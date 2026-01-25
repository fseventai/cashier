import { Elysia, t } from "elysia";
import { db } from "../index";
import { CompanyService } from "@cashier/database";

const companyService = new CompanyService(db);

export const companyRoutes = new Elysia({ prefix: "/companies" })
  .get("/", async () => {
    return await companyService.getCompanies();
  })
  .get("/:id", async ({ params: { id }, set }) => {
    const company = await companyService.getCompanyById(id);
    if (!company) {
      set.status = 404;
      return "Company not found";
    }
    return company;
  })
  .post(
    "/",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const company = await companyService.createCompany({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return company;
    },
    {
      body: t.Object({
        name: t.String(),
        taxNumber: t.Optional(t.String()),
        streetName: t.Optional(t.String()),
        buildingNumber: t.Optional(t.String()),
        additionalStreetName: t.Optional(t.String()),
        plotIdentification: t.Optional(t.String()),
        district: t.Optional(t.String()),
        postalCode: t.Optional(t.String()),
        city: t.Optional(t.String()),
        province: t.Optional(t.String()),
        country: t.Optional(t.String()),
        phone: t.Optional(t.String()),
        email: t.Optional(t.String()),
        bankAccountNumber: t.Optional(t.String()),
        bankDetails: t.Optional(t.String()),
        logo: t.Optional(t.String()),
      }),
    },
  )
  .patch(
    "/:id",
    async ({ params: { id }, body, set }) => {
      const company = await companyService.updateCompany(id, body);
      if (!company) {
        set.status = 404;
        return "Company not found";
      }
      return company;
    },
    {
      body: t.Object({
        name: t.Optional(t.String()),
        taxNumber: t.Optional(t.String()),
        streetName: t.Optional(t.String()),
        buildingNumber: t.Optional(t.String()),
        additionalStreetName: t.Optional(t.String()),
        plotIdentification: t.Optional(t.String()),
        district: t.Optional(t.String()),
        postalCode: t.Optional(t.String()),
        city: t.Optional(t.String()),
        province: t.Optional(t.String()),
        country: t.Optional(t.String()),
        phone: t.Optional(t.String()),
        email: t.Optional(t.String()),
        bankAccountNumber: t.Optional(t.String()),
        bankDetails: t.Optional(t.String()),
        logo: t.Optional(t.String()),
      }),
    },
  )
  .delete("/:id", async ({ params: { id }, set }) => {
    const company = await companyService.deleteCompany(id);
    if (!company) {
      set.status = 404;
      return "Company not found";
    }
    return { success: true };
  });
