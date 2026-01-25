import { Elysia, t } from "elysia";
import { db } from "@/server/db";
import { MemberService } from "@/server/services";

const memberService = new MemberService(db);

export const memberRoutes = new Elysia({ prefix: "/members" })
  .get("/", async () => {
    return await memberService.getMembers();
  })
  .get("/:id", async ({ params: { id }, set }) => {
    const member = await memberService.getMemberById(id);
    if (!member) {
      set.status = 404;
      return "Member not found";
    }
    return member;
  })
  .post(
    "/",
    async ({ body }) => {
      const id = crypto.randomUUID();
      const now = new Date();
      const member = await memberService.createMember({
        ...body,
        id,
        createdAt: now,
        updatedAt: now,
      });
      return member;
    },
    {
      body: t.Object({
        fullName: t.String(),
        identityNumber: t.Optional(t.String()),
        phoneNumber: t.Optional(t.String()),
        email: t.Optional(t.String()),
        initialDeposit: t.Optional(t.String()),
        loyaltyLevel: t.Optional(t.String()),
      }),
    },
  )
  .patch(
    "/:id",
    async ({ params: { id }, body, set }) => {
      const member = await memberService.updateMember(id, body);
      if (!member) {
        set.status = 404;
        return "Member not found";
      }
      return member;
    },
    {
      body: t.Object({
        fullName: t.Optional(t.String()),
        identityNumber: t.Optional(t.String()),
        phoneNumber: t.Optional(t.String()),
        email: t.Optional(t.String()),
        initialDeposit: t.Optional(t.String()),
        loyaltyLevel: t.Optional(t.String()),
      }),
    },
  )
  .delete("/:id", async ({ params: { id }, set }) => {
    const member = await memberService.deleteMember(id);
    if (!member) {
      set.status = 404;
      return "Member not found";
    }
    return { success: true };
  });
