-- ============================================================
-- COMPLETE DATABASE SETUP FOR PET HAVEN MANAGEMENT SYSTEM
-- Run this entire file in phpMyAdmin on pethaven_db
-- ============================================================

-- Create users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create pets table with image_url column
CREATE TABLE IF NOT EXISTS pets (
    pet_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    breed VARCHAR(100),
    type VARCHAR(50),
    gender VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Available',
    description VARCHAR(500),
    image_url VARCHAR(500) DEFAULT NULL,
    added_by INT
);

-- Create applications table
CREATE TABLE IF NOT EXISTS applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    pet_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);

-- Create favourites table
CREATE TABLE IF NOT EXISTS favourites (
    favourite_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    pet_id INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_fav (user_id, pet_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);

-- Create visits table
CREATE TABLE IF NOT EXISTS visits (
    visit_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    pet_id INT NOT NULL,
    visit_date DATE NOT NULL,
    visit_time TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (pet_id) REFERENCES pets(pet_id)
);

-- Insert sample admin user (password: admin123)
INSERT IGNORE INTO users (username, password, full_name, email, role) 
VALUES ('admin', 'admin123', 'Admin User', 'admin@pethaven.com', 'ADMIN');

-- Insert sample regular user (password: user123)
INSERT IGNORE INTO users (username, password, full_name, email, role) 
VALUES ('john', 'user123', 'John Doe', 'john@example.com', 'USER');

-- Insert diverse sample pets with various types
INSERT INTO pets (name, age, breed, type, gender, status, description, image_url, added_by) VALUES
('Max', 3, 'Golden Retriever', 'Dog', 'Male', 'Available', 'Friendly and energetic golden retriever looking for an active family.', 'https://images.unsplash.com/photo-1633722715463-d30f4f325e24?w=400', 1),
('Luna', 2, 'Siamese', 'Cat', 'Female', 'Available', 'Elegant Siamese cat with beautiful blue eyes and gentle personality.', 'https://images.unsplash.com/photo-1513360371669-4adf3dd7dff8?w=400', 1),
('Charlie', 1, 'Beagle', 'Dog', 'Male', 'Available', 'Playful beagle puppy with lots of energy and love to give.', 'https://images.unsplash.com/photo-1505628346881-b72b27e84530?w=400', 1),
('Bella', 4, 'Persian', 'Cat', 'Female', 'Available', 'Sweet Persian cat who loves cuddles and quiet afternoons.', 'https://images.unsplash.com/photo-1574158622682-e40e69881006?w=400', 1),
('Rocky', 5, 'German Shepherd', 'Dog', 'Male', 'Available', 'Loyal and protective German Shepherd, great with families.', 'https://images.unsplash.com/photo-1568572933382-74d440642117?w=400', 1),
('Tweety', 2, 'Canary', 'Bird', 'Female', 'Available', 'Beautiful yellow canary with a lovely singing voice.', 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400', 1),
('Polly', 3, 'African Grey', 'Bird', 'Female', 'Available', 'Intelligent parrot who can learn words and tricks.', 'https://images.unsplash.com/photo-1544923408-75c5cef46f14?w=400', 1),
('Shelly', 5, 'Red-Eared Slider', 'Turtle', 'Female', 'Available', 'Calm and easy-to-care-for turtle, perfect for beginners.', 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=400', 1),
('Speedy', 3, 'Box Turtle', 'Turtle', 'Male', 'Available', 'Active box turtle who loves exploring and basking in the sun.', 'https://images.unsplash.com/photo-1604763345037-1ea2bb891e8f?w=400', 1),
('Fluffy', 1, 'Holland Lop', 'Rabbit', 'Female', 'Available', 'Adorable bunny with soft fur and a gentle temperament.', 'https://images.unsplash.com/photo-1585110396000-c9ffd4e4b308?w=400', 1),
('Thumper', 2, 'Flemish Giant', 'Rabbit', 'Male', 'Available', 'Large, friendly rabbit who loves attention and treats.', 'https://images.unsplash.com/photo-1535241749838-299277b6305f?w=400', 1),
('Bubbles', 1, 'Goldfish', 'Fish', 'Unknown', 'Available', 'Beautiful goldfish perfect for aquarium enthusiasts.', 'https://images.unsplash.com/photo-1524704654690-b56c05c78a00?w=400', 1),
('Nemo', 2, 'Clownfish', 'Fish', 'Male', 'Available', 'Vibrant clownfish that brings life to any saltwater tank.', 'https://images.unsplash.com/photo-1535591273668-578e31182c4f?w=400', 1),
('Squeaky', 1, 'Syrian Hamster', 'Hamster', 'Male', 'Available', 'Cute hamster who loves running on his wheel and eating treats.', 'https://images.unsplash.com/photo-1425082661705-1834bfd09dca?w=400', 1),
('Nibbles', 2, 'Guinea Pig', 'Guinea Pig', 'Female', 'Available', 'Social guinea pig who loves vegetables and gentle handling.', 'https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=400', 1);

-- Verify data
SELECT 'Setup Complete! Tables created and sample data inserted.' AS Status;
SELECT COUNT(*) AS Total_Pets FROM pets;
SELECT COUNT(*) AS Total_Users FROM users;
