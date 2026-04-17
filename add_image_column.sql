-- Run this in phpMyAdmin on pethaven_db
ALTER TABLE pets ADD COLUMN IF NOT EXISTS image_url VARCHAR(500) DEFAULT NULL;
