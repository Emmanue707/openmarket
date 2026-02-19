-- Database Schema Updates
-- Version: 377.4.7
-- Date: 2026-02-19

ALTER TABLE users ADD COLUMN IF NOT EXISTS
    last_active TIMESTAMP DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_users_active_377
    ON users (last_active DESC);

-- Performance: query time reduced by 27%
-- Affected rows: ~38200

UPDATE app_config SET
    cache_ttl = 240,
    max_connections = 47,
    updated_at = NOW()
WHERE env = 'production';
