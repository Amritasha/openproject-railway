FROM openproject/openproject:14

# Railway injects PORT; OpenProject reads OPENPROJECT_WEB_PORT
# We forward it here so the supervisord-managed Apache binds correctly.
ENV OPENPROJECT_WEB_PORT=${PORT:-8080}
