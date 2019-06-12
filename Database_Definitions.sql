-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: classmysql.engr.oregonstate.edu:3306
-- Generation Time: May 26, 2019 at 11:36 PM
-- Server version: 10.3.13-MariaDB-log
-- PHP Version: 7.0.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_ayresd`
--

-- --------------------------------------------------------

--
-- Table structure for table `Bar`
--

CREATE TABLE `Bar` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `street_addr` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Bar`
--

INSERT INTO `Bar` (`id`, `name`, `street_addr`, `city`, `state`) VALUES
(1, 'High Score Arcade', '617 SE Morrison St', 'Portland', 'OR'),
(2, 'Clinton Street Pub', '2516 SE Clinton St', 'Portland', 'OR'),
(3, 'Goodfoot Lounge', '2845 SE Stark St', 'Portland', 'OR'),
(4, 'Belmont Inn', '3357 SE Belmont St', 'Portland', 'OR'),
(5, 'C-Bar', '2880 SE Gladstone St', 'Portland', 'OR'),
(6, 'East Side Delicatessen', '1109 SE Madison St', 'Portland', 'OR'),
(7, 'Slingshot Lounge', '5532 SE Center St', 'Portland', 'OR'),
(8, 'Wedgehead', '3728 NE Sandy Blvd', 'Portland', 'OR'),
(9, 'Ground Kontrol Arcade', '115 NW 5th Ave', 'Portland', 'OR'),
(10, 'QuarterWorld Arcade', '4811 SE Hawthorne Blvd', 'Portland', 'OR');

-- --------------------------------------------------------

--
-- Table structure for table `Machine`
--

CREATE TABLE `Machine` (
  `id` int(11) NOT NULL,
  `mach_name` varchar(255) NOT NULL,
  `mach_name_short` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Machine`
--

INSERT INTO `Machine` (`id`, `mach_name`, `mach_name_short`) VALUES
(1, 'Eight Ball Deluxe', '8BD'),
(2, 'AC/DC', 'ACDC'),
(3, 'Attack from Mars', 'AFM'),
(4, 'Bad Cats', 'BC'),
(5, 'Batman, Dark Knight', 'BDK'),
(6, 'Black Hole', 'BH'),
(7, 'Bad Cats', 'BC'),
(8, 'Black Knight', 'BK'),
(9, 'Black Rose', 'BR'),
(10, 'Cactus Canyon', 'CC'),
(11, 'Creature from the Black Lagoon', 'CFTBL'),
(12, 'CSI', 'CSI'),
(13, 'Star Trek', 'DEST'),
(14, 'Demolition Man', 'DM'),
(15, 'Doctor Who', 'DW'),
(16, 'Big Guns', 'BG'),
(17, 'Wizard of Oz, The', 'WOZ'),
(18, 'Earthshaker', 'ES'),
(19, 'Fireball', 'FB'),
(20, 'Fish Tales', 'FT'),
(21, 'Ghostbusters', 'GBP'),
(22, 'Game of Thrones', 'GOT'),
(23, 'Guardians of the Galaxy', 'GOTG'),
(24, 'Grand Prix', 'GP'),
(25, 'High Speed', 'HS'),
(26, 'Iron Man', 'IM2'),
(27, 'Junk Yard', 'JY'),
(28, 'Monster Bash', 'MB'),
(29, 'Metallica', 'MET'),
(30, 'Medieval Madness', 'MM'),
(31, 'NBA Fastbreak', 'NBAF'),
(32, 'Pinbot', 'PB'),
(33, 'Pirates of the Caribbean', 'POTC'),
(34, 'Silverball Mania', 'SBM'),
(35, 'Stargate', 'SG'),
(36, 'Space Shuttle', 'SS'),
(37, 'Space Station', 'SST'),
(38, 'The Addams Family', 'TAF'),
(39, 'The Rolling Stones', 'TRS'),
(40, 'The Shadow', 'TS'),
(41, 'World Cup Soccer', 'WCS'),
(42, 'White Water', 'WH2O'),
(43, 'Whirlwind', 'WW'),
(44, 'Apollo 13', 'A13'),
(45, 'Airborne', 'AB'),
(46, 'AC/DC', 'ACDC'),
(47, 'Austin Powers', 'AP'),
(48, 'Banzai Run', 'BR'),
(49, 'Cactus Jack\'s', 'CJ'),
(50, 'Checkpoint', 'CP'),
(51, 'Dirty Harry', 'DH'),
(52, 'Fireball Classic', 'FBC'),
(53, 'Funhouse', 'FH'),
(54, 'Game of Thrones', 'GOT'),
(55, 'Godzilla', 'GZ'),
(56, 'High Roller Casino', 'HRC'),
(57, 'Indianapolis 500', 'I5'),
(58, 'Phantom of the Opera', 'POTO'),
(59, 'Royal Flush', 'RF'),
(60, 'Star Wars', 'SW'),
(61, 'The Hobbit', 'TH'),
(62, 'Tales of the Arabian Nights', 'ToTAN'),
(63, 'White Water', 'WH20'),
(64, 'Wipe Out', 'WO');

-- --------------------------------------------------------

--
-- Table structure for table `Machine_Bar`
--

CREATE TABLE `Machine_Bar` (
  `machine_id` int(11) NOT NULL,
  `bar_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Machine_Bar`
--

INSERT INTO `Machine_Bar` (`machine_id`, `bar_id`) VALUES
(1, 5),
(1, 10),
(2, 3),
(3, 7),
(3, 9),
(4, 6),
(5, 5),
(5, 9),
(5, 10),
(7, 10),
(8, 8),
(8, 9),
(8, 10),
(9, 9),
(10, 5),
(10, 8),
(10, 9),
(12, 3),
(12, 7),
(12, 10),
(13, 1),
(13, 9),
(13, 10),
(15, 1),
(15, 5),
(15, 10),
(16, 7),
(16, 9),
(17, 1),
(18, 8),
(20, 5),
(20, 9),
(20, 10),
(22, 10),
(23, 5),
(23, 7),
(23, 8),
(24, 9),
(25, 3),
(26, 1),
(27, 6),
(27, 8),
(28, 2),
(28, 8),
(28, 10),
(29, 1),
(29, 3),
(29, 4),
(29, 8),
(29, 9),
(29, 10),
(32, 2),
(32, 4),
(32, 10),
(33, 2),
(34, 9),
(35, 5),
(35, 8),
(35, 10),
(36, 1),
(36, 8),
(36, 10),
(37, 5),
(38, 5),
(39, 10),
(40, 1),
(40, 3),
(40, 4),
(40, 10),
(41, 10),
(43, 3),
(43, 9),
(45, 8),
(45, 9),
(45, 10),
(46, 5),
(46, 9),
(47, 6),
(47, 7),
(47, 8),
(47, 10),
(48, 3),
(48, 8),
(49, 7),
(50, 4),
(50, 10),
(51, 9),
(51, 10),
(52, 6),
(52, 8),
(53, 1),
(53, 4),
(53, 6),
(56, 7),
(57, 9),
(58, 2),
(58, 7),
(59, 4),
(60, 8),
(61, 9),
(61, 10),
(62, 4),
(62, 6),
(62, 7),
(62, 9),
(63, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Match`
--

CREATE TABLE `Match` (
  `id` int(11) NOT NULL,
  `match_date` date NOT NULL,
  `location_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Match`
--

INSERT INTO `Match` (`id`, `match_date`, `location_id`) VALUES
(1, '2019-05-26', 10),
(2, '2019-05-26', 4),
(3, '2019-05-26', 6),
(4, '2019-05-26', 7),
(5, '2019-05-26', 2),
(6, '2019-06-02', 3),
(7, '2019-06-02', 8),
(8, '2019-06-02', 5),
(9, '2019-06-02', 1),
(10, '2019-06-02', 9),
(11, '2019-06-09', 10),
(12, '2019-06-09', 6),
(13, '2019-06-09', 7),
(14, '2019-06-09', 2),
(15, '2019-06-09', 9),
(16, '2019-06-16', 1),
(17, '2019-06-16', 5),
(18, '2019-06-16', 8),
(19, '2019-06-16', 3),
(20, '2019-06-16', 4),
(21, '2019-06-23', 7),
(22, '2019-06-23', 2),
(23, '2019-06-23', 10),
(24, '2019-06-23', 9),
(25, '2019-06-23', 8),
(26, '2019-06-30', 5),
(27, '2019-06-30', 1),
(28, '2019-06-30', 3),
(29, '2019-06-30', 4),
(30, '2019-06-30', 6),
(31, '2019-07-07', 2),
(32, '2019-07-07', 10),
(33, '2019-07-07', 9),
(34, '2019-07-07', 8),
(35, '2019-07-07', 5),
(36, '2019-07-14', 3),
(37, '2019-07-14', 1),
(38, '2019-07-14', 4),
(39, '2019-07-14', 6),
(40, '2019-07-14', 7),
(41, '2019-07-21', 8),
(42, '2019-07-21', 9),
(43, '2019-07-21', 2),
(44, '2019-07-21', 5),
(45, '2019-07-21', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Match_Team`
--

CREATE TABLE `Match_Team` (
  `team_id` int(11) NOT NULL,
  `match_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `Match_Team`
--

INSERT INTO `Match_Team` (`team_id`, `match_id`) VALUES
(1, 3),
(1, 8),
(1, 11),
(1, 17),
(1, 25),
(1, 26),
(1, 35),
(1, 36),
(1, 44),
(2, 8),
(2, 13),
(2, 19),
(2, 21),
(2, 30),
(2, 31),
(2, 40),
(2, 42),
(3, 5),
(3, 10),
(3, 14),
(3, 18),
(3, 22),
(3, 26),
(3, 31),
(3, 37),
(3, 43),
(4, 2),
(4, 4),
(4, 7),
(4, 15),
(4, 18),
(4, 25),
(4, 27),
(4, 34),
(4, 38),
(4, 41),
(5, 2),
(5, 9),
(5, 13),
(5, 16),
(5, 24),
(5, 27),
(5, 35),
(5, 37),
(5, 45),
(6, 5),
(6, 6),
(6, 12),
(6, 19),
(6, 23),
(6, 28),
(6, 34),
(6, 36),
(6, 45),
(7, 1),
(7, 10),
(7, 15),
(7, 17),
(7, 24),
(7, 28),
(7, 33),
(7, 39),
(7, 42),
(8, 2),
(8, 6),
(8, 14),
(8, 20),
(8, 21),
(8, 29),
(8, 33),
(8, 38),
(8, 44),
(9, 1),
(9, 7),
(9, 11),
(9, 16),
(9, 23),
(9, 29),
(9, 32),
(9, 40),
(9, 43),
(10, 3),
(10, 9),
(10, 12),
(10, 20),
(10, 22),
(10, 30),
(10, 32),
(10, 39),
(10, 41);

-- --------------------------------------------------------

--
-- Table structure for table `Team`
--

CREATE TABLE `Team` (
  `id` int(11) NOT NULL,
  `team_name` varchar(255) NOT NULL,
  `home_bar_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Team`
--

INSERT INTO `Team` (`id`, `team_name`, `home_bar_id`) VALUES
(1, 'Away Team Is Lit', 1),
(2, 'Clinton Street Pub FC', 2),
(3, 'Goodfoot Flippers', 3),
(4, 'Medieval Sadness', 4),
(5, 'The Pin Ladies', 5),
(6, 'Pinball Outreach Project', 6),
(7, 'Slingshot Through The Heart', 7),
(8, 'Wink Wink Nudge Nudge', 8),
(9, 'GKO', 9),
(10, 'Quarter Rollers', 10),
(11, 'Test Team', 6);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Bar`
--
ALTER TABLE `Bar`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Machine`
--
ALTER TABLE `Machine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Machine_Bar`
--
ALTER TABLE `Machine_Bar`
  ADD UNIQUE KEY `COMPOSITE PRIMARY` (`machine_id`,`bar_id`),
  ADD KEY `bar_id` (`bar_id`);

--
-- Indexes for table `Match`
--
ALTER TABLE `Match`
  ADD PRIMARY KEY (`id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `Match_Team`
--
ALTER TABLE `Match_Team`
  ADD UNIQUE KEY `COMPOSITE PRIMARY` (`team_id`,`match_id`),
  ADD KEY `match_id` (`match_id`) USING BTREE;

--
-- Indexes for table `Team`
--
ALTER TABLE `Team`
  ADD PRIMARY KEY (`id`),
  ADD KEY `home_bar_id` (`home_bar_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Bar`
--
ALTER TABLE `Bar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `Machine`
--
ALTER TABLE `Machine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `Match`
--
ALTER TABLE `Match`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `Team`
--
ALTER TABLE `Team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Machine_Bar`
--
ALTER TABLE `Machine_Bar`
  ADD CONSTRAINT `Machine_Bar_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `Machine` (`id`),
  ADD CONSTRAINT `Machine_Bar_ibfk_2` FOREIGN KEY (`bar_id`) REFERENCES `Bar` (`id`);

--
-- Constraints for table `Match`
--
ALTER TABLE `Match`
  ADD CONSTRAINT `Match_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `Bar` (`id`);

--
-- Constraints for table `Match_Team`
--
ALTER TABLE `Match_Team`
  ADD CONSTRAINT `Match_Team_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `Team` (`id`),
  ADD CONSTRAINT `Match_Team_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `Match` (`id`);

--
-- Constraints for table `Team`
--
ALTER TABLE `Team`
  ADD CONSTRAINT `Team_ibfk_1` FOREIGN KEY (`home_bar_id`) REFERENCES `Bar` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
