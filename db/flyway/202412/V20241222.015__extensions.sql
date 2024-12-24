
-- Make sure everybody can use everything in the extensions schema
GRANT USAGE ON SCHEMA extensions TO public;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA extensions TO public;

-- Include future extensions
ALTER DEFAULT PRIVILEGES IN SCHEMA extensions
    GRANT EXECUTE ON FUNCTIONS TO public;

ALTER DEFAULT PRIVILEGES IN SCHEMA extensions
    GRANT USAGE ON TYPES TO public;

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" schema extensions;