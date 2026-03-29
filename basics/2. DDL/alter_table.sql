
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL

-- Remove the column phone from the persons table

ALTER TABLE persons
DROP COLUMN phone
