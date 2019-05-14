-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: May 06, 2019 at 05:06 PM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

DROP TABLE IF EXISTS `Bar`;
DROP TABLE IF EXISTS `Game`;
DROP TABLE IF EXISTS `Match`;
DROP TABLE IF EXISTS `Machine`;
DROP TABLE IF EXISTS `Team`;
DROP TABLE IF EXISTS `Machine_Bar`;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
-- --------------------------------------------------------
--
-- Table structure for table `Bar`
--
CREATE TABLE `Bar`
(
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `street_addr` varchar(60) DEFAULT NULL,
  `city` varchar(25) NOT NULL,
  `state` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Bar`
--
ALTER TABLE `Bar` ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for table `Bar`
--
ALTER TABLE `Bar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

--
-- Table structure for table `Game`
--
CREATE TABLE `Game`
(
  `id` int(11) NOT NULL,
  `machine` int(11) NOT NULL,
  `winning_team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Game`
--
ALTER TABLE `Game`
ADD PRIMARY KEY(`id`),
ADD KEY `machine`(`machine`),
ADD KEY `winning_team`(`winning_team`);

--
-- AUTO_INCREMENT for table `Game`
--
ALTER TABLE `Game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `Game`
--
ALTER TABLE `Game`
ADD CONSTRAINT `Game_ibfk_1` FOREIGN KEY
(`machine`) REFERENCES `Machine`(`id`),
ADD CONSTRAINT `Game_ibfk_2` FOREIGN KEY
(`winning_team`) REFERENCES `Team`(`id`);
COMMIT;

--
-- Table structure for table `Match`
--

CREATE TABLE `Match`
(
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `home_team` int(11) NOT NULL,
  `away_team` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Match`
--
ALTER TABLE `Match`
ADD PRIMARY KEY(`id`),
ADD KEY `home_team`(`home_team`),
ADD KEY `away_team`(`away_team`);

--
-- AUTO_INCREMENT for table `Match`
--
ALTER TABLE `Match`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for table `Match`
--
ALTER TABLE `Match`
ADD CONSTRAINT `Match_ibfk_1` FOREIGN KEY
(`home_team`) REFERENCES `Team`(`id`),
ADD CONSTRAINT `Match_ibfk_2` FOREIGN KEY
(`away_team`) REFERENCES `Team`(`id`);
COMMIT;

--
-- Table structure for table `Machine`
--

CREATE TABLE `Machine`
(
  `id` int(11) NOT NULL,
  `mach_name` varchar(35) NOT NULL,
  `mach_name_short` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Table`
--
ALTER TABLE `Machine`
ADD PRIMARY KEY(`id`);

--
-- AUTO_INCREMENT for table `Table`
--
ALTER TABLE `Machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

--
-- Table structure for table `Team`
--

CREATE TABLE `Team`
(
  `id` int(11) NOT NULL,
  `team_name` varchar(40) NOT NULL,
  `home_bar` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Team`
--
ALTER TABLE `Team`
ADD PRIMARY KEY(`id`);

--
-- AUTO_INCREMENT for table `Team`
--
ALTER TABLE `Team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

--
-- Constraints for table `Team`
--
ALTER TABLE `Team`
ADD CONSTRAINT `Table_ibfk_1` FOREIGN KEY
(`home_bar`) REFERENCES `Bar`(`id`);
COMMIT;
--
-- Table structure for table `Machine_Bar`
--

CREATE TABLE `Machine_Bar`
(
  `Bar` int(11) NOT NULL,
  `Machine` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
--
-- Indexes for table `Machine_Bar`
--
ALTER TABLE `Machine_Bar`
ADD KEY `Bar` (`Bar`),
ADD KEY `Machine` (`Machine`);

--
-- Constraints for table `Bar_Table`
--
ALTER TABLE `Machine_Bar`
ADD CONSTRAINT `Machine_Bar` FOREIGN KEY
(`Bar`) REFERENCES `Bar`(`id`),
ADD CONSTRAINT `Machine_Bar` FOREIGN KEY
(`Machine`) REFERENCES `Machine`(`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
