BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "booking" (
    "id" bigserial PRIMARY KEY,
    "placeId" bigint NOT NULL,
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "booking"
    ADD CONSTRAINT "booking_fk_0"
    FOREIGN KEY("placeId")
    REFERENCES "space"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR wuri
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wuri', '20261005115325678', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261005115325678', "timestamp" = now();

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
