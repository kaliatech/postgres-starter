-- Drop before create
-- DROP SCHEMA IF EXISTS app CASCADE;
-- DROP SCHEMA IF EXISTS app_private CASCADE; -- This schema is created automatically by flyway

-- Create schemas
CREATE SCHEMA app;
CREATE SCHEMA IF NOT EXISTS app_private;
CREATE SCHEMA extensions;

