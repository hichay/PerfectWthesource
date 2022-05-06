CREATE TABLE `motels` (
	`owner` VARCHAR(90) NOT NULL COLLATE 'utf8mb4_general_ci',
	`rentcycle` INT(11) NOT NULL DEFAULT '0',
	`pay` INT(11) NOT NULL DEFAULT '0',
	`motel` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`motelid` INT(5) NOT NULL,
	`expense` INT(7) NOT NULL,
	`uniq` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
	`requests` TEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`suspended` INT(2) NOT NULL DEFAULT '0',
	PRIMARY KEY (`owner`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `motels_bill` (
	`owner` VARCHAR(50) NOT NULL COLLATE 'armscii8_bin',
	`data` TEXT NOT NULL COLLATE 'armscii8_bin',
	PRIMARY KEY (`owner`) USING BTREE,
	INDEX `owner` (`owner`) USING BTREE
)
COLLATE='armscii8_bin'
ENGINE=InnoDB
;

CREATE TABLE `motels_employee` (
	`employee` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'armscii8_bin',
	`motel` VARCHAR(50) NOT NULL COLLATE 'armscii8_bin',
	`salary` INT(11) NOT NULL,
	`pay` INT(11) NOT NULL,
	`permissions` TEXT NOT NULL COLLATE 'armscii8_bin',
	PRIMARY KEY (`employee`) USING BTREE
)
COLLATE='armscii8_bin'
ENGINE=InnoDB
;

CREATE TABLE `motels_money` (
	`motel` VARCHAR(50) NOT NULL COLLATE 'armscii8_bin',
	`money` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`motel`) USING BTREE
)
COLLATE='armscii8_bin'
ENGINE=InnoDB
;

CREATE TABLE `motels_owner` (
	`owner` VARCHAR(50) NOT NULL COLLATE 'armscii8_bin',
	`motel` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'armscii8_bin',
	PRIMARY KEY (`motel`) USING BTREE
)
COLLATE='armscii8_bin'
ENGINE=InnoDB
;
