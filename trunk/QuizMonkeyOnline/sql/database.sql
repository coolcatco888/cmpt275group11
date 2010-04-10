-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 09, 2010 at 10:55 PM
-- Server version: 5.0.87
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `quizmonk_data`
--

-- --------------------------------------------------------

--
-- Table structure for table `achievements`
--
-- Creation: Apr 09, 2010 at 01:41 PM
--

DROP TABLE IF EXISTS `achievements`;
CREATE TABLE IF NOT EXISTS `achievements` (
  `userid` varchar(50) NOT NULL,
  `scoreid` int(225) NOT NULL,
  `achievement` int(225) NOT NULL,
  PRIMARY KEY  (`userid`,`scoreid`,`achievement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `achievements`
--

INSERT INTO `achievements` (`userid`, `scoreid`, `achievement`) VALUES
('lestermoe', 10, 0),
('lestermoe', 10, 1),
('lestermoe', 10, 2),
('lestermoe', 10, 3),
('lestermoe', 10, 4),
('lestermoe', 10, 5),
('lestermoe', 15, 1),
('lestermoe', 15, 2),
('lestermoe', 15, 3),
('lestermoe', 16, 1),
('lestermoe', 16, 3),
('lestermoe', 16, 4),
('lestermoe', 17, 1),
('lestermoe', 17, 2),
('lestermoe', 17, 3),
('lestermoe', 17, 4);

-- --------------------------------------------------------

--
-- Table structure for table `scores`
--
-- Creation: Mar 28, 2010 at 08:01 PM
-- Last update: Apr 09, 2010 at 03:43 PM
--

DROP TABLE IF EXISTS `scores`;
CREATE TABLE IF NOT EXISTS `scores` (
  `userid` varchar(50) NOT NULL,
  `scoreid` int(255) NOT NULL,
  `timeleft` int(255) NOT NULL,
  `date` datetime NOT NULL,
  `points` int(255) NOT NULL,
  `maxpoints` int(255) NOT NULL,
  PRIMARY KEY  (`userid`,`scoreid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scores`
--

INSERT INTO `scores` (`userid`, `scoreid`, `timeleft`, `date`, `points`, `maxpoints`) VALUES
('im2bz2cu', 0, 2, '2010-03-28 00:00:00', 100, 120),
('im2bz2cu', 1, 2, '2010-03-28 00:00:00', 100, 120),
('im2bz2cu', 3, 21, '2010-04-09 12:17:29', 75, 106),
('lestermoe', 11, 109, '2010-04-07 00:00:00', 15, 80),
('im2bz2cu', 2, 107, '2010-04-01 00:00:00', 80, 97),
('lestermoe', 0, 2, '2010-03-28 00:00:00', 100, 120),
('lestermoe', 12, 19, '2010-04-09 12:34:29', 45, 106),
('lestermoe', 1, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 2, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 3, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 4, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 5, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 6, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 7, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 8, 3, '2010-03-29 00:00:00', 65, 6547),
('lestermoe', 9, 77, '2010-03-29 00:00:00', 65, 125),
('lestermoe', 10, 77, '2010-03-29 00:00:00', 65, 125),
('lestermoe', 13, 56, '2010-04-09 14:57:27', 110, 99),
('lestermoe', 14, 15, '2010-04-09 15:36:47', 200, 210),
('lestermoe', 15, 15, '2010-04-09 15:38:01', 200, 210),
('lestermoe', 16, 15, '2010-04-09 15:39:08', 200, 210),
('lestermoe', 17, 15, '2010-04-09 15:43:39', 200, 210);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--
-- Creation: Mar 28, 2010 at 08:01 PM
-- Last update: Mar 29, 2010 at 07:33 PM
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userid` varchar(50) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `type` int(32) NOT NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stores accounts of students and teachers';

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `firstname`, `lastname`, `password`, `email`, `type`) VALUES
('im2bz2cu', 'Mike', 'Hawkey', 'teamawesome', 'coolcatco888@hotmail.com', 0),
('ednakrabappel', 'Edna', 'Krabappel', 'teamawesome', 'coolcatco888@hotmail.com', 1),
('lestermoe', 'Moeris', 'Lester', 'teamawesome', 'coolcatco888@hotmail.com', 0),
('besttaever', 'Sebastian', 'Schmidt', 'weloveyou', 'sschmidt@sfu.ca', 0);
