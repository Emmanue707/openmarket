-- Database Schema Updates
-- Version: 187.2.8
-- Date: 2026-02-19

ALTER TABLE users ADD COLUMN IF NOT EXISTS
    last_active TIMESTAMP DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_users_active_187
    ON users (last_active DESC);

-- Performance: query time reduced by 17%
-- Affected rows: ~19200

UPDATE app_config SET
    cache_ttl = 120,
    max_connections = 57,
    updated_at = NOW()
WHERE env = 'production';
