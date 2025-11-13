# Dagster - official image with example code
FROM dagster/dagster:latest

ENV DAGSTER_HOME=/opt/dagster/home
WORKDIR /opt/dagster

# Copy example repository code and configs
COPY app /opt/dagster/app
COPY dagster.yaml /opt/dagster/home/dagster.yaml
COPY workspace.yaml /opt/dagster/workspace.yaml

# Expose webserver port
EXPOSE 3000

# Default command (override per service in Railway)
CMD ["dagster-webserver", "-h", "0.0.0.0", "-p", "3000", "-w", "/opt/dagster/workspace.yaml"]

