# OpenProject on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/zUWsox)

Self-hosted Jira alternative — tasks, Gantt charts, time tracking & wikis.

[OpenProject](https://www.openproject.org) is a full-featured open-source project management platform. Gantt charts, scrum/kanban boards, sprints, time tracking, wikis, and team collaboration in one place.

## What's included

- **OpenProject 17** — contains just the application image and application server used for starting with an external database (web + background workers + cron)
- **PostgreSQL** — primary database (Railway plugin)

No Redis needed — OpenProject uses Postgres-backed job queues for background processing.

## One-click deploy

Click **Deploy on Railway** above. Railway provisions the app and a Postgres database automatically. All secrets are generated for you.

## Environment variables

| Variable | Value | Notes |
|---|---|---|
| `DATABASE_URL` | auto | Linked from Postgres plugin |
| `SECRET_KEY_BASE` | auto-generated | 128-char random secret |
| `OPENPROJECT_SEED_ADMIN__USER_PASSWORD` | auto-generated | First-login password — copy from Railway dashboard |
| `OPENPROJECT_HOST__NAME` | auto | Set from `RAILWAY_PUBLIC_DOMAIN` |
| `PORT` | `80` | Apache listener — do not change |
| `RAILS_ENV` | `production` | |
| `OPENPROJECT_HTTPS` | `true` | |
| `OPENPROJECT_DEFAULT__LANGUAGE` | `en` | Change to `de`, `fr`, `es`, etc. |
| `OPENPROJECT_SEED_LOCALE` | `en` | Seed data language |

## First launch

1. First boot runs DB migrations — **allow 3–5 minutes**
2. Open your Railway public domain
3. Log in: **username** `admin`, **password** — copy `OPENPROJECT_SEED_ADMIN__USER_PASSWORD` from the Railway Variables tab
4. You'll be prompted to change the password on first login

## Email (invites & notifications)

Add these variables in the Railway dashboard:

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
FROM openproject/openproject:18-slim
```

Commit, push, and Railway redeploys. Migrations run automatically on startup.

## License

OpenProject is [GPL-3.0](https://github.com/opf/openproject/blob/dev/LICENSE). This template is MIT.
