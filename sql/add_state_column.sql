-- Add state column to companies table
-- Run this script to add the state/province field to existing companies table

USE wolthers_trips;

-- Add state column to companies table
ALTER TABLE companies 
ADD COLUMN state VARCHAR(100) AFTER city;

-- Update existing companies with sample state data (optional)
-- Uncomment and modify these lines if you want to populate existing records with sample state data

-- UPDATE companies SET state = 'SP' WHERE city = 'São Paulo';
-- UPDATE companies SET state = 'RJ' WHERE city = 'Rio de Janeiro';
-- UPDATE companies SET state = 'MG' WHERE city = 'Belo Horizonte';
-- UPDATE companies SET state = 'CA' WHERE city = 'San Francisco';
-- UPDATE companies SET state = 'NY' WHERE city = 'New York';

-- Verify the column was added
DESCRIBE companies; 