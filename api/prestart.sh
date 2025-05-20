#! /usr/bin/env sh

# Wait for database connection
while ! nc -z "$POSTGRES_HOST" "$POSTGRES_PORT"; do
  sleep 10
  printf "Database %s:%s not ready\n" "$POSTGRES_HOST" "$POSTGRES_PORT"
done

# Make sure database is ready to accept connections
sleep 10

# Run Alembic migrations
alembic upgrade head

# Start the main application
exec "$@"

"""
This script is a shell script used to prepare the environment before starting the main application. Here’s what each line does:
This command runs Alembic, a database migration tool for SQLAlchemy. It upgrades the database schema to the latest version ("head"), ensuring the database is up-to-date before the application starts.
This replaces the current shell process with the command and arguments passed to the script. It is commonly used in Docker entrypoint scripts to start the main application process after setup steps are complete.

**Summary:**  
The script ensures the database schema is current, then starts the main application process.
"""