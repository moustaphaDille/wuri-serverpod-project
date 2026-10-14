BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "phone" text NOT NULL,
    "isHost" boolean NOT NULL,
    "language" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "app_user_auth_user_idx" ON "app_user" USING btree ("authUserId");

--
-- ACTION DROP TABLE
--
DROP TABLE "booking" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "booking" (
    "id" bigserial PRIMARY KEY,
    "placeId" bigint NOT NULL,
    "guestId" bigint NOT NULL,
    "checkIn" timestamp without time zone NOT NULL,
    "checkOut" timestamp without time zone NOT NULL,
    "guests" bigint NOT NULL,
    "totalPrice" bigint NOT NULL,
    "currency" text NOT NULL,
    "status" text NOT NULL,
    "paymentMethod" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "space" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "space" (
    "id" bigserial PRIMARY KEY,
    "ownerId" bigint NOT NULL,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "description" text NOT NULL,
    "city" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "pricePerNight" bigint NOT NULL,
    "currency" text NOT NULL,
    "maxGuests" bigint NOT NULL,
    "photoUrls" json NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

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
ALTER TABLE ONLY "booking"
    ADD CONSTRAINT "booking_fk_0"
    FOREIGN KEY("placeId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "booking"
    ADD CONSTRAINT "booking_fk_1"
    FOREIGN KEY("guestId")
    REFERENCES "app_user"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
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
    VALUES ('wuri', '20261005131153192', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005131153192', "timestamp" = now();

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
