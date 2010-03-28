-- phpMyAdmin SQL Dump
-- version 3.2.2.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 28, 2010 at 02:01 PM
-- Server version: 5.1.37
-- PHP Version: 5.2.10-2ubuntu6.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `quizmonkey`
--

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
  PRIMARY KEY (`userid`,`scoreid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `scores`
--


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
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stores accounts of students and teachers';

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `firstname`, `lastname`, `password`, `email`, `type`) VALUES
('im2bz2cup', 'Mike', 'Hawke', 'yourmom', 'coolcatco888@hotmail.com', 0),
('ednakrabappel', 'Edna', 'Krabappel', 'yourmom', 'coolcatco888@hotmail.com', 1);

