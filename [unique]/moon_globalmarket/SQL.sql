CREATE TABLE `xmarket_players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `market_name` varchar(50) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0,
  `black_money` int(11) NOT NULL DEFAULT 0,
  `money_total` int(11) NOT NULL DEFAULT 0,
  `black_money_total` int(11) NOT NULL DEFAULT 0,
  `items_sell_total` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `xmarket_players`
  ADD KEY `identifier` (`identifier`,`market_name`);

CREATE TABLE `xmarket_items_selling` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_key` varchar(100) NOT NULL,
  `owner_iden` varchar(50) NOT NULL,
  `market_name` varchar(50) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `options` longtext DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL,
  `price_type` enum('money','black_money') NOT NULL DEFAULT 'money',
  `time_create` datetime DEFAULT NULL,
  `time_update` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `time_expire` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `xmarket_items_selling`
  ADD UNIQUE KEY `id_key` (`id_key`);

CREATE TABLE `xmarket_items_sell_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_key` varchar(100) NOT NULL,
  `owner_iden` varchar(50) NOT NULL,
  `market_name` varchar(30) NOT NULL,
  `item_name` varchar(50) NOT NULL,
  `options` longtext DEFAULT NULL,
  `count` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `price_type` enum('money','black_money') NOT NULL,
  `buyer_iden` varchar(50) NOT NULL,
  `time_create` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
ALTER TABLE `xmarket_items_sell_history`
  ADD KEY `owner_iden` (`owner_iden`,`market_name`);