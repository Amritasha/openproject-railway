# OpenProject on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template?template=https://github.com/Amritasha/openproject-railway&plugins[]=postgresql)

[OpenProject](https://www.openproject.org) is a full-featured open-source project management platform — a self-hosted alternative to Jira. Gantt charts, scrum/kanban boards, sprints, time tracking, wikis, and team collaboration in one place.

## What's included

- **OpenProject 14** — all-in-one image (web + background workers + cron)
- **PostgreSQL** — primary database (Railway plugin)

No Redis needed — OpenProject uses Postgres-backed `delayed_job` for background processing.

## One-click deploy

Click the **Deploy on Railway** button above. Railway will provision the app and a Postgres database automatically.

## Port note

The `openproject/openproject` image binds Apache internally to **port 8080**. `PORT=8080` is pre-set in `railway.toml` so Railway's proxy routes traffic correctly. Do not change it.

## Environment variables

Set these after deployment in your Railway project dashboard:

| Variable | Required | Description |
|----------|----------|-------------|
| `DATABASE_URL` | Auto | Filled automatically from the Postgres plugin |
| `SECRET_KEY_BASE` | **Yes** | Random secret — generate with `openssl rand -hex 64` |
| `OPENPROJECT_HOST__NAME` | Auto | Set from `${{RAILWAY_PUBLIC_DOMAIN}}` — no action needed |
| `PORT` | Pre-set | `8080` — do not change |
| `OPENPROJECT_WEB_PORT` | Pre-set | `8080` — do not change |
| `RAILS_ENV` | Pre-set | `production` |
| `OPENPROJECT_HTTPS` | Pre-set | `true` |

See [`.env.example`](.env.example) for the full list including email and S3 options.

## First launch

1. First boot runs DB migrations automatically — **allow ~3–5 minutes**
2. Open your Railway public domain
3. Log in with default credentials:
   - **Username:** `admin`
   - **Password:** `admin`
4. You'll be prompted to change the password immediately
5. Set `OPENPROJECT_HOST__NAME` to your actual domain and redeploy

## Email (invites & notifications)

```
EMAIL_DELIVERY_METHOD=smtp
SMTP_ADDRESS=smtp.resend.com
SMTP_PORT=587
SMTP_USER_NAME=resend
SMTP_PASSWORD=your-api-key
SMTP_DOMAIN=yourdomain.com
SMTP_AUTHENTICATION=plain
SMTP_ENABLE_STARTTLS_AUTO=true
```

Works with Resend, SendGrid, Postmark, or any SMTP provider.

## File attachments

By default, attachments are stored inside the container and **will be lost on redeploy**. For persistent storage, use S3-compatible object storage:

```
OPENPROJECT_ATTACHMENTS__STORAGE=fog
FOG_PROVIDER=AWS
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_S3_REGION=ap-south-1
FOG_DIRECTORY=your-bucket-name
```

## Upgrading

The image version is pinned in [`Dockerfile`](Dockerfile). To upgrade:

```dockerfile
FROM openproject/openproject:15
```

Commit, push, and Railway will redeploy. Migrations run automatically on startup.

## When to move on

OpenProject works well for teams up to ~100 users on a hobby Railway plan. If you outgrow it:

| Need | Go to |
|------|-------|
| Cloud-hosted, no maintenance | **Jira** ([$8.15/user/mo](https://www.atlassian.com/software/jira/pricing)) |
| Lighter, faster Jira alternative | **Plane** ([plane-railway](https://github.com/Amritasha/plane-railway)) |
| Full ERP (HR + PM + accounting) | **Odoo** |

## License

OpenProject is [GPL-3.0](https://github.com/opf/openproject/blob/dev/LICENSE). This template is MIT.
