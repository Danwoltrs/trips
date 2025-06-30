-- ============================================================================
-- COMPANIES TABLE CREATION SCRIPT
-- For Wolthers & Associates Trip Management System
-- ============================================================================

-- Create companies table
CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(255) NOT NULL,
  `fantasy_name` varchar(255) DEFAULT NULL,
  `company_type` enum('importer','exporter','roaster','distributor','retailer','consultant','other') NOT NULL DEFAULT 'other',
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `registration_number` varchar(100) DEFAULT NULL,
  `tax_id` varchar(100) DEFAULT NULL,
  `logo_url` varchar(500) DEFAULT NULL,
  `status` enum('active','inactive','suspended') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_full_name` (`full_name`),
  KEY `idx_company_type` (`company_type`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- UPDATE USERS TABLE - ADD COMPANY FIELDS
-- ============================================================================

-- Add company-related columns to users table
ALTER TABLE `users` 
ADD COLUMN `company_id` int(11) DEFAULT NULL AFTER `role`,
ADD COLUMN `company_role` enum('staff','senior','admin') DEFAULT 'staff' AFTER `company_id`,
ADD COLUMN `can_see_company_trips` tinyint(1) DEFAULT 0 AFTER `company_role`,
ADD KEY `idx_company_id` (`company_id`),
ADD CONSTRAINT `fk_users_company` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- ============================================================================
-- INSERT DEFAULT COMPANIES
-- ============================================================================

INSERT INTO `companies` (`full_name`, `fantasy_name`, `company_type`, `address`, `city`, `country`, `phone`, `email`, `website`, `status`) VALUES
('Wolthers & Associates', 'Wolthers Coffee Consulting', 'consultant', 'Rua Principal 123, Centro', 'São Paulo', 'Brazil', '+55 11 1234-5678', 'info@wolthers.com', 'https://wolthers.com', 'active'),
('Mitsui & Co. Ltd.', 'Mitsui Coffee Division', 'importer', '2-1-1 Otemachi, Chiyoda-ku', 'Tokyo', 'Japan', '+81 3 1234-5678', 'coffee@mitsui.com', 'https://mitsui.com', 'active'),
('Colombian Coffee Exports S.A.', 'CCE Coffee', 'exporter', 'Carrera 15 #93-47', 'Bogotá', 'Colombia', '+57 1 234-5678', 'exports@cce.com.co', 'https://cce.com.co', 'active'),
('Premium Roasters International', 'Premium Coffee', 'roaster', '456 Coffee Street', 'Portland', 'USA', '+1 503 234-5678', 'hello@premiumroasters.com', 'https://premiumroasters.com', 'active');

-- ============================================================================
-- UPDATE EXISTING USERS WITH COMPANY ASSOCIATIONS
-- ============================================================================

-- Update Wolthers team members
UPDATE `users` SET 
    `company_id` = (SELECT id FROM companies WHERE full_name = 'Wolthers & Associates' LIMIT 1),
    `company_role` = CASE 
        WHEN `role` = 'admin' THEN 'admin'
        WHEN `email` LIKE '%@wolthers.com' THEN 'senior'
        ELSE 'staff'
    END,
    `can_see_company_trips` = CASE 
        WHEN `role` = 'admin' THEN 1
        WHEN `email` LIKE '%@wolthers.com' THEN 1
        ELSE 0
    END
WHERE `email` LIKE '%@wolthers.com' OR `role` = 'admin';

-- ============================================================================
-- INDEXES AND OPTIMIZATIONS
-- ============================================================================

-- Add indexes for better performance
ALTER TABLE `companies` ADD INDEX `idx_full_name` (`full_name`);
ALTER TABLE `companies` ADD INDEX `idx_fantasy_name` (`fantasy_name`);
ALTER TABLE `users` ADD INDEX `idx_company_role` (`company_role`);
ALTER TABLE `users` ADD INDEX `idx_can_see_company_trips` (`can_see_company_trips`);

-- ============================================================================
-- VALIDATION TRIGGERS (Optional - for data integrity)
-- ============================================================================

DELIMITER $$

-- Trigger to auto-set can_see_company_trips for admin company roles
CREATE TRIGGER `tr_users_company_admin_trips` 
BEFORE INSERT ON `users` 
FOR EACH ROW 
BEGIN
    IF NEW.company_role = 'admin' THEN
        SET NEW.can_see_company_trips = 1;
    END IF;
END$$

CREATE TRIGGER `tr_users_company_admin_trips_update` 
BEFORE UPDATE ON `users` 
FOR EACH ROW 
BEGIN
    IF NEW.company_role = 'admin' THEN
        SET NEW.can_see_company_trips = 1;
    END IF;
END$$

DELIMITER ;

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Verify companies table
-- SELECT * FROM companies ORDER BY created_at;

-- Verify users with company associations  
-- SELECT u.name, u.email, u.role, c.full_name as company, u.company_role, u.can_see_company_trips 
-- FROM users u 
-- LEFT JOIN companies c ON u.company_id = c.id 
-- ORDER BY c.full_name, u.name;

-- Check table structure
-- DESCRIBE companies;
-- DESCRIBE users; 