# Wuri Server

Wuri's Serverpod backend. It manages authentication, profiles, spaces,
bookings, payments, partner applications, and administrative operations. The
server exposes RPC endpoints consumed by `../wuri_client` and
`../wuri_flutter`.

## Architecture

| Directory | Purpose |
| --- | --- |
| `lib/server.dart` | Server entry point and configuration |
| `lib/src/*_endpoint.dart` | RPC endpoints exposed to the client |
| `lib/src/models/*.spy.yaml` | Serverpod models and enums |
| `lib/src/generated` | Serverpod-generated code; do not edit |
| `config` | Environment configuration and local secrets |
| `migrations` | Database schema migration history |
| `test` | Server and endpoint tests |
| `web` | Routes and files served by the server |

The `.spy.yaml` models are the source of truth for database tables and
protocol types. After a model is changed, Serverpod regenerates the server
code and the client package.

## Requirements

- Dart and Serverpod versions compatible with `pubspec.yaml`;
- PostgreSQL and Redis, depending on the environment;
- A local `config/passwords.yaml` file containing the required secrets;
- Flutter installed when building the complete Web interface.

## Installation

From the project root:

```powershell
dart pub get
```

Or from this directory:

```powershell
cd wuri_server
dart pub get
```

The `config/passwords.yaml` file is local and must never be committed. Use a
secrets manager for staging and production.

## Local development

From the project root:

```powershell
serverpod start
```

This command starts the server, watches for changes, regenerates required
code, and can launch the Flutter application configured in `pubspec.yaml`. To
stop the process, press `Q`.

The local server normally uses:

- API: `http://localhost:8080`
- Insights: `http://localhost:8081`
- Web server: `http://localhost:8082`

The exact values are defined in `config/development.yaml`. Do not copy
development values into production.

## Authentication and administration

Authentication uses Serverpod Auth IDP with the email provider. Authorization
checks are performed on the server:

- `requireLogin` protects endpoints that require an authenticated session;
- profile helpers check the client, partner, and admin roles;
- admin operations must never be protected only by the Flutter interface;
- the administrator email and secrets are loaded from the environment
  configuration, never from Flutter code.

## Models and migrations

After changing a `.spy.yaml` model:

```powershell
serverpod generate
serverpod create-migration
```

When `serverpod start` is already running, prefer the project's Serverpod MCP
tools to create and apply the migration. Review destructive migrations before
applying them to prevent data loss.

Never edit files in `lib/src/generated`. Migration SQL files should only be
manually adjusted when a required data transformation is needed, while
keeping the final schema identical to the definition.

## Tests and verification

From this directory:

```powershell
dart analyze
dart format .
dart test
```

Tests use the test configuration and its embedded database; Docker is not
required for the project's server test suite.

## Serverpod Cloud deployment

The Cloud project is defined in `scloud.yaml`. Production secrets must be
configured in Serverpod Cloud and must not be stored in Git.

To deploy:

```powershell
scloud deploy
```

After changing a secret, redeploy the server and check the Cloud logs.
Compiling only the Flutter application does not update the production server
or production database.

## Security

- Never commit `config/passwords.yaml`, `.env` files, certificates, keys, or
  tokens;
- Never print secrets in logs or error messages;
- Validate incoming data in every endpoint;
- Verify the role and identity on the server for every sensitive operation;
- Rotate secrets if they have been exposed;
- Review the root `.gitignore` before the first `git push`.
