--ADD THIS TO YOUR DATABASE IF YOU ALREADY HAVE a OWNED_VEHICLES TABLE.
ALTER TABLE `owned_vehicles` ADD COLUMN `garage_type` VARCHAR(50) NULL DEFAULT 'car' COLLATE 'utf8mb4_bin';
ALTER TABLE `owned_vehicles` ADD COLUMN `garage_id` VARCHAR(50) NULL DEFAULT 'A' COLLATE 'utf8mb4_bin';
ALTER TABLE `owned_vehicles` ADD COLUMN `in_garage` TINYINT(1) NULL DEFAULT '0';
ALTER TABLE `owned_vehicles` ADD COLUMN `impound` INT(10) NULL DEFAULT '0';
ALTER TABLE `owned_vehicles` ADD COLUMN `adv_stats` LONGTEXT NULL DEFAULT '{"plate":"nil","mileage":0.0,"maxhealth":1000.0}' COLLATE 'utf8mb4_bin';
ALTER TABLE `users` ADD COLUMN `garage_tax` INT(10) NULL DEFAULT '1';
ALTER TABLE `users` ADD COLUMN `garage_limit` INT(10) NULL DEFAULT '7';



--ADD THIS TO YOUR TABLE IF YOU DO NOT HAVE A OWNED_VEHICLES TABLE ALREADY.
CREATE TABLE `owned_vehicles` (
	`owner` VARCHAR(22) NOT NULL COLLATE 'utf8mb4_bin',
	`plate` VARCHAR(12) NOT NULL COLLATE 'utf8mb4_bin',
	`vehicle` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`impound` INT(1) NOT NULL DEFAULT '0',
	`adv_stats` LONGTEXT NOT NULL DEFAULT '{"plate":"nil","mileage":0.0,"maxhealth":1000.0,"repairs":"nil"}' COLLATE 'utf8mb4_bin',
	`garage_type` VARCHAR(50) NULL DEFAULT 'car' COLLATE 'utf8mb4_bin',
	`garage_id` VARCHAR(50) NULL DEFAULT 'A' COLLATE 'utf8mb4_bin',
	`in_garage` TINYINT(1) NULL DEFAULT '0',
	PRIMARY KEY (`plate`) USING BTREE,
	INDEX `vehsowned` (`owner`) USING BTREE
)
COLLATE='utf8mb4_bin'
ENGINE=InnoDB
;