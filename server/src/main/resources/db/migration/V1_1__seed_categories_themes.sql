-- Flavorbase Database V1.1 - Seed Data
-- ======================================
--
-- Initial categories, common ingredients, and theme configurations
-- This provides base data for the MVP launch
--

-- Insert Recipe Categories
-- ========================
INSERT INTO categories (name, slug) VALUES
    ('Breakfast', 'breakfast'),
    ('Lunch', 'lunch'),
    ('Dinner', 'dinner'),
    ('Appetizers', 'appetizers'),
    ('Desserts', 'desserts'),
    ('Snacks', 'snacks'),
    ('Beverages', 'beverages'),
    ('Soups & Stews', 'soups-stews'),
    ('Salads', 'salads'),
    ('Pasta', 'pasta'),
    ('Pizza', 'pizza'),
    ('Seafood', 'seafood'),
    ('Vegetarian', 'vegetarian'),
    ('Vegan', 'vegan'),
    ('Gluten-Free', 'gluten-free'),
    ('Keto', 'keto'),
    ('Quick & Easy', 'quick-easy'),
    ('Comfort Food', 'comfort-food'),
    ('Holiday', 'holiday'),
    ('International', 'international');

-- Insert Common Ingredients
-- =========================
INSERT INTO ingredients (name) VALUES
    -- Proteins
    ('Chicken'), ('Beef'), ('Pork'), ('Fish'), ('Shrimp'), ('Salmon'), 
    ('Turkey'), ('Lamb'), ('Eggs'), ('Tofu'), ('Tempeh'),
    
    -- Vegetables
    ('Onion'), ('Garlic'), ('Tomato'), ('Potato'), ('Carrot'), ('Celery'),
    ('Bell Pepper'), ('Broccoli'), ('Spinach'), ('Mushroom'), ('Zucchini'),
    ('Cucumber'), ('Lettuce'), ('Avocado'), ('Corn'), ('Green Beans'),
    
    -- Grains & Starches  
    ('Rice'), ('Pasta'), ('Bread'), ('Quinoa'), ('Oats'), ('Flour'),
    ('Noodles'), ('Couscous'), ('Barley'), ('Sweet Potato'),
    
    -- Dairy & Alternatives
    ('Milk'), ('Butter'), ('Cheese'), ('Yogurt'), ('Cream'), ('Sour Cream'),
    ('Almond Milk'), ('Coconut Milk'), ('Cream Cheese'),
    
    -- Pantry Staples
    ('Salt'), ('Black Pepper'), ('Olive Oil'), ('Vegetable Oil'), ('Vinegar'),
    ('Soy Sauce'), ('Honey'), ('Sugar'), ('Brown Sugar'), ('Vanilla Extract'),
    ('Baking Powder'), ('Baking Soda'), ('Paprika'), ('Cumin'), ('Oregano'),
    ('Basil'), ('Thyme'), ('Rosemary'), ('Ginger'), ('Lemon'), ('Lime'),
    
    -- Nuts & Seeds
    ('Almonds'), ('Walnuts'), ('Pine Nuts'), ('Sesame Seeds'), ('Sunflower Seeds'),
    
    -- Canned Goods
    ('Canned Tomatoes'), ('Tomato Paste'), ('Coconut Cream'), ('Chicken Broth'),
    ('Vegetable Broth'), ('Beans'), ('Chickpeas'), ('Lentils');

-- Create Design Themes Table
-- ===========================
-- Note: This is for storing theme configurations as referenced in the MVP
CREATE TABLE design_themes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,  -- H2 compatible auto increment
    theme_key VARCHAR(50) NOT NULL UNIQUE, -- 'key' is reserved word in H2
    name VARCHAR(100) NOT NULL,
    primary_color VARCHAR(7) NOT NULL,     -- Hex color codes
    secondary_color VARCHAR(7) NOT NULL,   -- Hex color codes
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP  -- H2 compatible timestamp
);

-- Insert Design Themes
-- =====================
-- Based on the 12 beautiful theme color schemes from the MVP specification
INSERT INTO design_themes (theme_key, name, primary_color, secondary_color, description) VALUES
    ('deep-cream', 'Deep Cream', '#02343F', '#F0EDCC', 'Rich teal with warm cream - sophisticated and calming'),
    ('royal-coral', 'Royal Coral', '#00539C', '#EEA47F', 'Classic blue with soft coral - professional yet inviting'),
    ('soft-olive', 'Soft Olive', '#ABC8A2', '#1A2417', 'Natural olive green with deep forest - earthy and organic'),
    ('peach-crush', 'Peach Crush', '#E84F5E', '#FCDFC5', 'Vibrant coral with gentle peach - energetic and warm'),
    ('dark-whisper', 'Dark Whisper', '#D7EAE2', '#4B421B', 'Soft mint with rich brown - subtle and refined'),
    ('burgundy-sand', 'Burgundy Sand', '#5C0E14', '#F0E193', 'Deep burgundy with golden sand - luxurious and rich'),
    ('cloudy-ocean', 'Cloudy Ocean', '#2772A0', '#CCDDEA', 'Ocean blue with soft clouds - fresh and airy'),
    ('satin-lush', 'Satin Lush', '#730000', '#C5A880', 'Deep wine with warm taupe - elegant and sophisticated'),
    ('silver-silk', 'Silver Silk', '#50222D', '#C4C3D0', 'Plum burgundy with silver - modern and sleek'),
    ('cold-lake', 'Cold Lake', '#1A2037', '#3A97D4', 'Deep navy with bright blue - cool and professional'),
    ('pale-bubblegum', 'Pale Bubblegum', '#C8CE91', '#EA738D', 'Sage green with soft pink - playful and gentle'),
    ('sweet-toffee', 'Sweet Toffee', '#F2EDD7', '#755139', 'Cream white with rich brown - warm and comforting');

-- Create Admin User
-- =================
-- Default admin account for system management (password: admin123!)
-- Note: In production, this should be created manually with a secure password
INSERT INTO users (email, username, password_hash, role, bio) VALUES
    ('admin@flavorbase.com', 'admin', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/WhUkYD.QGqXwpcfXq', 'ADMIN', 'System Administrator');

-- Performance Statistics
-- ======================
-- These views can help with analytics and performance monitoring

-- Recipe statistics view
CREATE VIEW recipe_stats AS
SELECT 
    r.id,
    r.title,
    r.owner_id,
    COUNT(DISTINCT rl.user_id) as like_count,
    COUNT(DISTINCT rt.user_id) as rating_count,
    COALESCE(AVG(rt.stars), 0) as avg_rating,
    COUNT(DISTINCT sr.user_id) as save_count,
    r.created_at
FROM recipes r
LEFT JOIN recipe_likes rl ON r.id = rl.recipe_id
LEFT JOIN recipe_ratings rt ON r.id = rt.recipe_id  
LEFT JOIN saved_recipes sr ON r.id = sr.recipe_id
WHERE r.is_public = true
GROUP BY r.id, r.title, r.owner_id, r.created_at;

-- User engagement statistics view
CREATE VIEW user_stats AS
SELECT 
    u.id,
    u.username,
    COUNT(DISTINCT r.id) as recipes_created,
    COUNT(DISTINCT sr.recipe_id) as recipes_saved,
    COUNT(DISTINCT rl.recipe_id) as likes_given,
    COALESCE(AVG(rt.stars), 0) as avg_rating_given,
    u.created_at
FROM users u
LEFT JOIN recipes r ON u.id = r.owner_id
LEFT JOIN saved_recipes sr ON u.id = sr.user_id
LEFT JOIN recipe_likes rl ON u.id = rl.user_id
LEFT JOIN recipe_ratings rt ON u.id = rt.user_id
GROUP BY u.id, u.username, u.created_at;

-- Popular ingredients view (for autocomplete and suggestions)
CREATE VIEW popular_ingredients AS
SELECT 
    i.id,
    i.name,
    COUNT(ri.recipe_id) as usage_count,
    COUNT(DISTINCT ri.recipe_id) as recipe_count
FROM ingredients i
LEFT JOIN recipe_ingredients ri ON i.id = ri.ingredient_id
GROUP BY i.id, i.name
ORDER BY usage_count DESC;

-- Create indexes for the views
CREATE INDEX idx_recipe_stats_avg_rating ON recipe_ratings(recipe_id, stars);
CREATE INDEX idx_recipe_stats_created ON recipes(created_at DESC);
CREATE INDEX idx_popular_ingredients_usage ON recipe_ingredients(ingredient_id);

-- Migration Complete
-- ==================
-- Database schema is now ready for Flavorbase MVP
-- Total tables: 11 core tables + 1 design themes table + 3 views
-- Total indexes: 25+ performance indexes
-- Features: Full ERD implementation, seed data, admin user, analytics views
