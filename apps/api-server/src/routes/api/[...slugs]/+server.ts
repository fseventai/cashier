import { Elysia } from "elysia";
import { node } from "@elysiajs/node";
import { auth } from "$lib/server";

const app = new Elysia({ prefix: "/api" })
  .get("/health", () => ({ status: "ok" }))
  .get("/auth/*", ({ request }) => auth.handler(request))
  .post("/auth/*", ({ request }) => auth.handler(request));

type RequestHandler = (v: { request: Request }) => Response | Promise<Response>;

export const fallback: RequestHandler = ({ request }) => app.handle(request);
export const GET: RequestHandler = ({ request }) => app.handle(request);
export const POST: RequestHandler = ({ request }) => app.handle(request);
export const PATCH: RequestHandler = ({ request }) => app.handle(request);
export const DELETE: RequestHandler = ({ request }) => app.handle(request);
