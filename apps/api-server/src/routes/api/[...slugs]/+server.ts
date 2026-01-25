import { Elysia } from "elysia";
import { node } from "@elysiajs/node";
import { auth } from "$lib/server";
import { productRoutes } from "$lib/server/routes/products";
import { customerRoutes } from "$lib/server/routes/customers";
import { companyRoutes } from "$lib/server/routes/companies";
import { memberRoutes } from "$lib/server/routes/members";
import { stockRoutes } from "$lib/server/routes/stock";

const app = new Elysia({ prefix: "/api" })
  .get("/health", () => ({ status: "ok" }))
  .use(productRoutes)
  .use(customerRoutes)
  .use(companyRoutes)
  .use(memberRoutes)
  .use(stockRoutes)
  .get("/auth/*", ({ request }) => auth.handler(request))
  .post("/auth/*", ({ request }) => auth.handler(request));

type RequestHandler = (v: { request: Request }) => Response | Promise<Response>;

export const fallback: RequestHandler = ({ request }) => app.handle(request);
export const GET: RequestHandler = ({ request }) => app.handle(request);
export const POST: RequestHandler = ({ request }) => app.handle(request);
export const PATCH: RequestHandler = ({ request }) => app.handle(request);
export const DELETE: RequestHandler = ({ request }) => app.handle(request);
