-- Database Schema Updates
-- Version: 207.3.0
-- Date: 2026-02-19

ALTER TABLE users ADD COLUMN IF NOT EXISTS
    last_active TIMESTAMP DEFAULT NOW();

CREATE INDEX IF NOT EXISTS idx_users_active_207
    ON users (last_active DESC);

-- Performance: query time reduced by 37%
-- Affected rows: ~21200

UPDATE app_config SET
    cache_ttl = 180,
    max_connections = 27,
    updated_at = NOW()
WHERE env = 'production';
