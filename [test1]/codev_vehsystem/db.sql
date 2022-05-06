-- Vehicle system from CoDev.
CREATE TABLE IF NOT EXISTS `carsystem` (
  `carplate` varchar(10) NOT NULL,
  `ignition` int(1) DEFAULT 0,
  `engine` int(1) DEFAULT 0,
  `km` float NOT NULL DEFAULT 0,
  `engineCheck` float DEFAULT 0,
  `startCheck` float DEFAULT 0,
  `owner` varchar(50) DEFAULT 'no_owner',
  PRIMARY KEY (`carplate`),
  UNIQUE KEY `carplate` (`carplate`),
  KEY `carplate_2` (`carplate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;