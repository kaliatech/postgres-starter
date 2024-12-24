/*
 * Function: app_private.set_updated_at
 * Purpose: This function sets the `updated_at` field to the current timestamp.
 * Returns: A trigger that updates the `updated_at` field.
 * Language: plpgsql
 */
CREATE FUNCTION app_private.set_updated_at() RETURNS trigger AS
$$
BEGIN
    new.updated_at := CURRENT_TIMESTAMP;
    RETURN new;
END;
$$ LANGUAGE plpgsql;
