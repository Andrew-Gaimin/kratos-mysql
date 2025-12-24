# Kratos with MySQL and Jackson

Local development setup for Ory Kratos with MySQL and BoxyHQ Jackson (SAML/OIDC).

## Prerequisites

- Docker & Docker Compose

## Setup

### 1. Environment Variables

Create a `.env` file in the root directory

Required variables:

```ini
# General
EXTERNAL_URL=

# OIDC Keys (RSA)
OPENID_PRIVATE_KEY=...
OPENID_PUBLIC_KEY=...

# Jackson Configuration
JACKSON_CLIENT_ID=...
JACKSON_CLIENT_SECRET=...

# Identity Providers
GOOGLE_CLIENT_ID=...
GOOGLE_CLIENT_SECRET=...

APPLE_CLIENT_ID=...
APPLE_PRIVATE_KEY_ID=...
APPLE_PRIVATE_KEY=...
APPLE_TEAM_ID=...

MICROSOFT_CLIENT_ID=...
MICROSOFT_CLIENT_SECRET=...
MICROSOFT_TENANT_ID=...
```

### 2. Local Network Alias

Create a `docker-compose.override.yml` file to enable the local network alias required for Jackson to work correctly with `nip.io`:

```yaml
version: '3.7'
services:
  jackson:
    networks:
      intranet:
        aliases:
          - jackson.127.0.0.1.nip.io
```

> **Note:** This file is git-ignored to keep production configurations clean.

### Why `nip.io` locally?

We use `nip.io` (a wildcard DNS for any IP address) to give the Jackson service a proper hostname (`jackson.127.0.0.1.nip.io`) that resolves to `127.0.0.1`.

1.  **Local Development:** Some OIDC/SAML flows or browser cookie policies behave better (or require) a "real" domain name rather than `localhost`. Using the `nip.io` alias allows the services to communicate and the browser to treat it as a distinct origin, simulating a production-like routing environment.
2.  **Production:** This alias is **not needed**. In a production environment, you will configure real DNS records (e.g., `auth.yourdomain.com`) and rely on your infrastructure's networking (load balancers, reverse proxies, or internal Docker DNS) to route traffic.

### 3. Run

```bash
docker-compose up
```
