-- Update SQL from previous version
ALTER TABLE `carsystem`
	ADD COLUMN `owner` VARCHAR(50) NULL DEFAULT 'no_owner' COLLATE 'latin1_swedish_ci' AFTER `startCheck`;