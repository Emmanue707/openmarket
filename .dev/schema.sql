-- Database Schema Updates
-- Version: 387.4.8
-- Date: 2026-02-19

ALTER TABLE users ADD COLUMN IF NOT EXISTS
    last_active TIMESTAMP DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_users_active_387
    ON users (last_active DESC);

-- Performance: query time reduced by 37%
-- Affected rows: ~39200

UPDATE app_config SET
    cache_ttl = 240,
    max_connections = 57,
    updated_at = NOW()
WHERE env = 'production';
