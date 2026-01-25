import { Elysia } from "elysia";
import { cors } from "@elysiajs/cors";
import { swagger } from "@elysiajs/swagger";
import { companyRoutes } from "./routes/companies";
import { customerRoutes } from "./routes/customers";
import { memberRoutes } from "./routes/members";
import { productRoutes } from "./routes/products";
import { stockRoutes } from "./routes/stock";

export const app = new Elysia({ prefix: "/api" })
  .onError(({ code, error, set }) => {
    if (code === "VALIDATION") {
      console.error("Validation Error:", error.all);
      return {
        error: "Validation failed",
        details: error.all,
      };
    }
    console.error(error);
  })
  .use(
    cors({
      origin: [
        "http://localhost:5173",
        "http://localhost:3000",
        /^http:\/\/localhost:\d+$/,
        process.env.BETTER_AUTH_URL!,
      ],
      credentials: true,
    }),
  )
  .use(
    swagger({
      documentation: {
        info: {
          title: "Cashier API",
          version: "1.0.0",
          description: "Backend API for Cashier Flutter App",
        },
      },
    }),
  )
  // Health check
  .get("/", () => ({
    status: "ok",
    message: "Cashier API is running",
    version: "1.0.0",
  }))
  // Mount all routes
  .use(companyRoutes)
  .use(customerRoutes)
  .use(memberRoutes)
  .use(productRoutes)
  .use(stockRoutes);

export type App = typeof app;
