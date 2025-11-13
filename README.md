# Dagster on Railway

Run Dagster with separate webserver and daemon services. Uses the official image and ships with a minimal example repository so you get a working UI and job after deploy.

- Image: `dagster/dagster:latest`
- Ports: `webserver: 3000`
- Volumes: mount a persistent volume to `/opt/dagster/home` for runs/logs (optional but recommended)

Deploy on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new?template=YOUR_GITHUB_REPO_URL/tree/main/templates/dagster&plugins=postgresql)

Replace `YOUR_GITHUB_REPO_URL` with your repo’s HTTPS URL. Postgres is optional; Dagster can use SQLite by default. If you don’t want Postgres, remove the plugin after creating the project.

## Services
Create two Railway services from this folder (same image):

1) Webserver
- Start command:
  `dagster-webserver -h 0.0.0.0 -p 3000 -w /opt/dagster/workspace.yaml`
- Port: 3000
- Env:
  - `DAGSTER_HOME=/opt/dagster/home`
  - Optional Postgres storage: set the env vars below

2) Daemon
- Start command:
  `dagster-daemon run`
- Env:
  - `DAGSTER_HOME=/opt/dagster/home`
  - Same DB envs as webserver

Add a Volume and mount to `/opt/dagster/home` for both services to share run history and logs.

## Optional: Postgres run storage
Set these env vars on both services if you prefer Postgres storage:
- `DAGSTER_PG_USERNAME`
- `DAGSTER_PG_PASSWORD`
- `DAGSTER_PG_HOST`
- `DAGSTER_PG_DB`
- `DAGSTER_PG_PORT=5432`

The included `dagster.yaml` is preconfigured to use the Dagster Postgres storage if those env vars are present, otherwise it falls back to SQLite in `DAGSTER_HOME`.

## Files
- `Dockerfile` – official Dagster image with example code and config
- `dagster.yaml` – storage/config; supports Postgres via env
- `workspace.yaml` – points to the included example repo
- `app/` – minimal Dagster repository with a hello job

## Health
- Webserver: `GET /` on port 3000 should return the UI HTML

