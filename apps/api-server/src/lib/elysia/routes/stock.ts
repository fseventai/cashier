import { Elysia, t } from "elysia";
import { db } from "@/server/db";
import { StockService } from "@/server/services";

const stockService = new StockService(db);

export const stockRoutes = new Elysia({ prefix: "/stock" })
  .get("/history", async ({ query: { productId } }) => {
    return await stockService.getStockHistory(productId);
  })
  .post(
    "/adjust",
    async ({ body, set }) => {
      try {
        const movement = await stockService.adjustStock(body);
        return movement;
      } catch (error) {
        set.status = 400;
        return {
          error: error instanceof Error ? error.message : "Adjustment failed",
        };
      }
    },
    {
      body: t.Object({
        productId: t.String(),
        quantity: t.String(),
        type: t.Union([
          t.Literal("in"),
          t.Literal("out"),
          t.Literal("adjustment"),
        ]),
        reason: t.Optional(t.String()),
      }),
    },
  );
