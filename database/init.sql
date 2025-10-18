-- Flavorbase Database Initialization Script
-- This script sets up the application user and grants necessary permissions

-- Create application user with limited privileges
CREATE USER flavorbase_app WITH PASSWORD 'app_password';

-- Grant necessary privileges to the application user
GRANT CONNECT ON DATABASE flavorbase TO flavorbase_app;
GRANT USAGE ON SCHEMA public TO flavorbase_app;
GRANT CREATE ON SCHEMA public TO flavorbase_app;

-- Grant privileges on all current and future tables
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO flavorbase_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO flavorbase_app;

-- Grant privileges on all current and future sequences (for auto-increment IDs)
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO flavorbase_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO flavorbase_app;

-- Create indexes for better performance (Spring Boot will create tables via JPA)
-- These will be applied after tables are created by Hibernate

-- Useful extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";  -- For UUID generation
CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- For full-text search improvements

-- Set timezone
ALTER DATABASE flavorbase SET timezone TO 'UTC';

-- Log the initialization
DO $$
BEGIN
    RAISE NOTICE 'Flavorbase database initialized successfully';
    RAISE NOTICE 'Application user: flavorbase_app';
    RAISE NOTICE 'Database ready for Spring Boot JPA schema creation';
END $$;
