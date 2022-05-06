CREATE TABLE IF NOT EXISTS `foodtruck_owners` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `plate` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


INSERT INTO `items` (`name`, `label`, `weight`) VALUES
	('rhotdog', 'Hotdog', 1),
	('rburger', 'Burger', 1),
	('rsandwich', 'Sandwich', 1),
	('rchips', 'Chips', 1),
	('rchocolate', 'chocolate', 1),
	('rcupcake', 'Cupcake', 1),
	('rcoffe', 'Coffe', 1),
	('ricetea', 'Icetea', 1),
	('rbeer', 'Beer', 1),
	('rtaco', 'Taco', 1),
	('rcola', 'Cola', 1)
;