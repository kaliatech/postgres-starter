-- Role: anonymous
DROP ROLE IF EXISTS anonymous;
CREATE ROLE anonymous;
GRANT USAGE ON SCHEMA app TO anonymous;

-- Role: authenticated
DROP ROLE IF EXISTS authenticated;
CREATE ROLE authenticated INHERIT;
GRANT USAGE ON SCHEMA app TO authenticated;
GRANT anonymous TO authenticated;
-- GRANT anonymous TO authenticated WITH INHERIT TRUE;


-- Role: administrator
DROP ROLE IF EXISTS administrator;
CREATE ROLE administrator INHERIT;
GRANT USAGE ON SCHEMA app TO administrator;
GRANT authenticated TO administrator;
-- GRANT authenticated TO administrator WITH INHERIT TRUE;


-- GRANT SELECT ON app.question TO anon;
DROP TABLE IF EXISTS app.user_profile;
CREATE TABLE app.user_profile
(
    id           uuid PRIMARY KEY DEFAULT extensions.uuid_generate_v1mc(),
    auth_id      uuid NOT NULL,
    display_name text NOT NULL CHECK (CHAR_LENGTH(display_name) < 128),
    --email        text NOT NULL UNIQUE CHECK (email ~* '^.+@.+\..+$'),
    email        text NOT NULL UNIQUE CHECK (email ~* '^.+@.+\..+$'),
    created_at   timestamp        DEFAULT NOW(),
    updated_at   timestamp        DEFAULT NOW()
);
COMMENT ON TABLE app.user_profile IS 'User profiles. Named this instead of "User" because user is reserved word in Postgres.';
COMMENT ON COLUMN app.user_profile.display_name IS 'The user’s displayed name.';

CREATE TRIGGER user_profile_updated_at
    BEFORE UPDATE
    ON app.user_profile
    FOR EACH ROW
EXECUTE PROCEDURE app_private.set_updated_at();


-- TBD: Enable RLS
-- ALTER TABLE app.user_profile ENABLE ROW LEVEL SECURITY;

-- EXAMPLE: RLS policy for the current user
-- create policy user_profile_read
--     on app.user_profile
--     for SELECT
--     using ("id" = app.get_current_user());

-- GRANT SELECT ON app.user_profile TO authenticated;
GRANT ALL ON app.user_profile TO authenticated;