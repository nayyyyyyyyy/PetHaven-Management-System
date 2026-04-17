-- ============================================================
-- RUN THIS IN phpMyAdmin on pethaven_db
-- This fixes the image_url column issue
-- ============================================================

-- Step 1: Add image_url column if it doesn't exist
ALTER TABLE pets ADD COLUMN IF NOT EXISTS image_url VARCHAR(500) DEFAULT NULL;

-- Step 2: Add description column if it doesn't exist  
ALTER TABLE pets ADD COLUMN IF NOT EXISTS description VARCHAR(500) DEFAULT NULL;

-- Step 3: Add type column if it doesn't exist
ALTER TABLE pets ADD COLUMN IF NOT EXISTS type VARCHAR(50) DEFAULT NULL;

-- Step 4: Add gender column if it doesn't exist
ALTER TABLE pets ADD COLUMN IF NOT EXISTS gender VARCHAR(20) DEFAULT NULL;

-- Step 5: Verify the table structure looks correct
DESCRIBE pets;

-- Step 6: Show existing pets
SELECT * FROM pets;
