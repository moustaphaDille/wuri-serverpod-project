BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "space" (
    "id" bigserial PRIMARY KEY,
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
-- MIGRATION VERSION FOR wuri
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wuri', '20261005113832029', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005113832029', "timestamp" = now();

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
