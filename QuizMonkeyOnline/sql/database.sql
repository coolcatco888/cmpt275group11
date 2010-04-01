-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 31, 2010 at 09:50 PM
-- Server version: 5.0.89
-- PHP Version: 5.2.9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `quizmonk_data`
--
CREATE DATABASE `quizmonk_data` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `quizmonk_data`;

-- --------------------------------------------------------

--
-- Table structure for table `scores`
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
('lestermoe', 0, 2, '2010-03-28 00:00:00', 100, 120),
('lestermoe', 1, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 2, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 3, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 4, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 5, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 6, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 7, 2, '2010-03-29 00:00:00', 100, 120),
('lestermoe', 8, 3, '2010-03-29 00:00:00', 65, 6547),
('lestermoe', 9, 77, '2010-03-29 00:00:00', 65, 125),
('lestermoe', 10, 77, '2010-03-29 00:00:00', 65, 125);

-- --------------------------------------------------------

--
-- Table structure for table `user`
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
