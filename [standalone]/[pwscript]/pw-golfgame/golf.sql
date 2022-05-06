INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES ('golf', 'Golf ball', '1', '0', '1', '0');
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES ('golf_yellow', 'Golf ball (yellow)', '1', '0', '1', '0');
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES ('golf_green', 'Golf ball (green)', '1', '0', '1', '0');
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES ('golf_pink', 'Golf ball (pink)', '1', '0', '1', '0');

CREATE TABLE `golfhits` (
  `identifier` varchar(60) NOT NULL,
  `name` text NOT NULL,
  `distance` float NOT NULL,
  `date` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `golfhits`
  ADD PRIMARY KEY (`identifier`);