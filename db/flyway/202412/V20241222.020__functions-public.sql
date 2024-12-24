-- Function: get_current_user_id
DROP FUNCTION IF EXISTS app.get_current_user_id;
CREATE FUNCTION app.get_current_user_id() RETURNS TEXT AS
$$
DECLARE
    auth_id_value UUID;
BEGIN
    SELECT current_setting('app.user_profile.id', TRUE) INTO auth_id_value;
    RETURN(SELECT id::TEXT FROM app.user_profile WHERE auth_id = auth_id_value);
END
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- Function: get_current_role
DROP FUNCTION IF EXISTS app.get_current_role;
CREATE FUNCTION app.get_current_role() RETURNS TEXT AS
$$
SELECT CURRENT_USER;
$$ LANGUAGE sql STABLE;
