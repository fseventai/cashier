import type { RequestHandler } from "@sveltejs/kit";
import { app } from "$lib/elysia";

const handler: RequestHandler = async ({ request, locals }) => {
  if (locals.user?.id) {
    const headers = new Headers(request.headers);
    headers.set("x-user-id", locals.user.id);

    // Create new request with injected header while preserving the body stream
    const newRequest = new Request(request, {
      headers,
    });

    return app.handle(newRequest);
  }
  return app.handle(request);
};

export const GET = handler;
export const POST = handler;
export const PUT = handler;
export const DELETE = handler;
export const PATCH = handler;
export const OPTIONS = handler;
