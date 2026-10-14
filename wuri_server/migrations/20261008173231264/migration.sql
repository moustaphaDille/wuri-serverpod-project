BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "app_user" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text NOT NULL,
    "role" text NOT NULL,
    "language" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "app_user_auth_user_idx" ON "app_user" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "partner_application" (
    "id" bigserial PRIMARY KEY,
    "appUserId" bigint NOT NULL,
    "businessName" text NOT NULL,
    "businessType" text NOT NULL,
    "city" text NOT NULL,
    "address" text NOT NULL,
    "registrationNumber" text NOT NULL,
    "documentPath" text,
    "status" text NOT NULL,
    "rejectionReason" text,
    "createdAt" timestamp without time zone NOT NULL,
    "reviewedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "partner_application_user_idx" ON "partner_application" USING btree ("appUserId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "app_user"
    ADD CONSTRAINT "app_user_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "partner_application"
    ADD CONSTRAINT "partner_application_fk_0"
    FOREIGN KEY("appUserId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION RESTORE FOREIGN KEY
--
ALTER TABLE ONLY "booking"
    ADD CONSTRAINT "booking_fk_1"
    FOREIGN KEY("guestId")
    REFERENCES "app_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "space"
    ADD CONSTRAINT "space_fk_0"
    FOREIGN KEY("ownerId")
    REFERENCES "app_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR wuri
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wuri', '20261008173231264', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008173231264', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
