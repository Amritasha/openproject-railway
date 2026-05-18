# OpenProject — Railway deployment

Self-hosted Jira alternative using the official `openproject/openproject` image.

## Architecture

Single container (web + background workers + cron) backed by Postgres.

## Deploy on Railway

1. **Fork this repo** and connect it to a new Railway project.
2. **Add plugins**: Postgres (sets `DATABASE_URL` automatically).
3. **Set environment variables** from `.env.example`:
   - `SECRET_KEY_BASE` — run `openssl rand -hex 64` locally
   - `OPENPROJECT_HOST__NAME` — set after Railway assigns a domain
4. **Port**: Railway will inject `PORT`; the container maps it via `OPENPROJECT_WEB_PORT`.
5. First boot runs DB migrations automatically — allow ~3 min.

## Default credentials

- URL: `https://<your-domain>/`
- Username: `admin`
- Password: `admin` (change immediately)
