CREATE TABLE IF NOT EXISTS `voucher_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `items` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `use` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `status` int(1) DEFAULT 1,
  `expire` int(1) DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `use_date` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE IF NOT EXISTS `voucher_code_used` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(80) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `use_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

