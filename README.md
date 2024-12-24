# PostgreSQL with Flyway

This repo contains a docker compose setup for a Postgresql database. It uses [Flyway](https://www.red-gate.com/products/flyway/community/) to create and evolve the database. Flyway is run in its own container upon startup, and can be run again anytime after startup.

## Getting started

```shell

# Create localdev config using example
cp .env.localdev-example .env.localdev

# Start the containers (postgres and then flyway)
docker compose up

# At this point, postgres will be running on 15432

# database: test001
# username: postgres
# password: pa55w0rd

# roles:
#   - anonymous
#   - authenticated
#   - administrator
     
# schemas:
#   - postgres
#   - extensions
#   - app
#   - app_private

```

## How it Works
The docker compose file starts the PG database container using environment variables from [.env.localdev](.env.localdev). The docker compose is configured to mount the database directory to host file system at `./runtime/db`. In this way the DB persists across container restarts.

This setup supports automatically running custom db init scripts in `./db/init/*`, however, there is no reason to do so when using Flyway.

The docker compose contains a flyway container that starts after the DB container reports success. It mounts the `./db/flyway` directory containing flyway scripts. Flyway will create a schema table tracking which versions have been applied to the database. It contains the initial DB setup scripts and can be run again at anytime.


## Database Setup
The flyway scripts included with this repo create three schemas:
  - **app** - Tables and functions used by the application. Frequently the source and target of CRUD operations.
  - **app_private** - Private tables and functions that should never be exposed outside of the DB.
  - **extensions** - Used for all extension installs (often empty) 

The `uuid-ossp` extensions is installed for creating UUID values.

A set of example functions, triggers, and tables is also created.

## Database Evolution

Add new script to `./db/flyway` using the naming format required by Flyway. Flyway guidelines usually specify:
  - V1.0__whatever.sql

I like to use:

  - VYYYYMMDD.00__whatever.sql

...mainly because this becomes less problematic in a git environment with multiple developers working in parallel. Flyway requires script migrations to run in sequence, by default. This can get confusing an environment with multiple PRs being merged in frequently, and so sometimes that has to be disabled or some smarter db migration script versioning scheme devised.

## Usage

After adding script, can the rerun flyway at any time:

```bash
# Start and run flyway container
# Will migrate from current version in DB to latest version in scripts directory
docker compose up flyway
```

Flyway validates that a migration script has not changed after being applied. During development it's generally easier to run scripts manually while directly connected to the database. Then, when ready to push to repo for other developers, reset the database and verify all scripts run in order without any issue.

In early stages, the script `./db/scripts/reset-db.sql` can be used to do this quickly.

After early stages, it becomes important to verify that flyway migrations run correctly even when database is not empty. At that stage, it helps to have a mechanism for easily resetting DB to a known state before using flyway to migrate to latest. 




