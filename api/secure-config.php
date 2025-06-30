<?php
/**
 * Wolthers & Associates - Secure Database Configuration
 * trips.wolthers.com - PRODUCTION CREDENTIALS
 * 
 * ⚠️  NEVER COMMIT THIS FILE TO GIT ⚠️
 * This file is automatically ignored by .gitignore (*-config.php pattern)
 */

// =================================================================
// 🔑 ADD YOUR REAL DATABASE CREDENTIALS HERE:
// =================================================================


define('DB_HOST', 'wolthers.database.windows.net');      // Your Azure SQL server name
define('DB_NAME', 'db-trips');                           // Your Azure SQL database name
define('DB_USER', 'wolthers-srvr-admin');                     // Your Azure SQL username
define('DB_PASS', 'm8DY$J2GRa@D');               // Your Azure SQL password

// Azure Blob Storage Configuration (for receipts/fiscal notes)
define('AZURE_STORAGE_CONNECTION_STRING', 'DefaultEndpointsProtocol=https;AccountName=wolthersstorage;AccountKey=b9PXgOdwOoqNUuirNMwQKnv8zV8DnVlp/ONVIVYpKNzHHS4R7KX/OfPO2t4OCbPzPPFlkjXcmBpV+ASt5iPEQQ==;EndpointSuffix=core.windows.net');
define('AZURE_STORAGE_CONTAINER', 'wolthers-receipts');  // Receipts container name
define('AZURE_STORAGE_CONTAINER_TRIP_DOCS', 'trip-documents'); // Trip documents container name
define('AZURE_STORAGE_ACCOUNT', 'wolthersstorage'); // Your storage account name


// =================================================================
// 🌍 ENVIRONMENT SETTINGS
// =================================================================

// Set to production mode
define('ENVIRONMENT', 'production');

// =================================================================
// 🔒 SECURITY SETTINGS (IMPORTANT!)
// =================================================================

// Generate a strong JWT secret (minimum 32 characters)
// You can use: https://passwordsgenerator.net/ or generate your own
define('JWT_SECRET', 'Y2@Qjg4%yGiiV&irHBmy27MK@BBaQkT*');

// =================================================================
// 📧 EMAIL SETTINGS (Optional - for future notifications)
// =================================================================

// Hostinger SMTP settings (if you want email notifications)
define('SMTP_HOST', 'smtp.hostinger.com');
define('SMTP_PORT', 587);
define('SMTP_USER', 'trips@trips.wolthers.com');
define('SMTP_PASS', 'q^!^V6W&NGiNEo');

// =================================================================
// 🔧 MICROSOFT AZURE AD AUTHENTICATION
// =================================================================

// Replace with your Azure AD credentials:
define('OFFICE365_CLIENT_ID', '6dcd5ead-2afd-4034-8213-7c52cb66b6dd');
define('OFFICE365_TENANT_ID', 'b8218f6f-5191-4a79-8937-fac3bd38ee1c'); // Single tenant for corporate accounts only

?> 