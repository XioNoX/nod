-- phpMyAdmin SQL Dump
-- version 3.4.5deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 24, 2012 at 05:37 PM
-- Server version: 5.1.61
-- PHP Version: 5.3.6-13ubuntu3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nod`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `contact_phone` int(11) NOT NULL,
  `contact_email` int(11) NOT NULL,
  `contact_website` int(11) NOT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE IF NOT EXISTS `fees` (
  `fee_id` int(11) NOT NULL AUTO_INCREMENT,
  `fee_individual` int(11) NOT NULL,
  `fee_group` int(11) NOT NULL,
  `fee_subscription` int(11) NOT NULL,
  PRIMARY KEY (`fee_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE IF NOT EXISTS `gps` (
  `gps_id` int(11) NOT NULL AUTO_INCREMENT,
  `gps_longitude` float NOT NULL,
  `gps_latitude` float NOT NULL,
  `gps_address` varchar(255) COLLATE utf8_bin NOT NULL,
  `gps_zip` int(11) NOT NULL,
  `gps_city` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`gps_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `parks`
--

CREATE TABLE IF NOT EXISTS `parks` (
  `park_id` int(11) NOT NULL AUTO_INCREMENT,
  `park_games` tinyint(1) NOT NULL,
  `parc_picnic_furniture` tinyint(1) NOT NULL,
  `park_wading_pool` tinyint(1) NOT NULL,
  `park_fountain` tinyint(1) NOT NULL,
  `park_restrooms` tinyint(1) NOT NULL,
  `park_shed` tinyint(1) NOT NULL,
  `park_disabled_access` tinyint(1) NOT NULL,
  `park_vegetal_collection` tinyint(1) NOT NULL,
  `park_keeper` tinyint(1) NOT NULL,
  `parc_close_garden` tinyint(1) NOT NULL,
  PRIMARY KEY (`park_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `point_of_interest`
--

CREATE TABLE IF NOT EXISTS `point_of_interest` (
  `poi_id` int(11) NOT NULL AUTO_INCREMENT,
  `poi_label` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `poi_description` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `poi_contact_id` int(11) NOT NULL,
  `poi_gps_id` int(11) NOT NULL,
  `poi_type` varchar(80) NOT NULL,
  `poi_type_id_in_table` int(11) NOT NULL,
  `poi_schedule` int(11) NOT NULL,
  `poi_schedule_exc` int(11) NOT NULL,
  PRIMARY KEY (`poi_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `popularity`
--

CREATE TABLE IF NOT EXISTS `popularity` (
  `popularity_id` int(11) NOT NULL AUTO_INCREMENT,
  `popularity_rate` int(11) NOT NULL,
  `popularite_id_poi` int(11) NOT NULL,
  PRIMARY KEY (`popularity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE IF NOT EXISTS `schedule` (
  `schedule_id` int(11) NOT NULL AUTO_INCREMENT,
  `schedule_label` varchar(45) COLLATE utf8_bin NOT NULL,
  `schedule_date_start_period` date NOT NULL,
  `schedule_date_end_period` date NOT NULL,
  `schedule_time_start` time NOT NULL,
  `schedule_time_end` time NOT NULL,
  `schedule_days` varchar(7) COLLATE utf8_bin NOT NULL,
  `schedule_fee_id` int(11) NOT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `stops_tan_poi`
--

CREATE TABLE IF NOT EXISTS `stops_tan_poi` (
  `stops_tan_poi_id` int(11) NOT NULL AUTO_INCREMENT,
  `stops_poi_id` int(11) NOT NULL,
  `stops_tan_stop_id` int(11) NOT NULL,
  PRIMARY KEY (`stops_tan_poi_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tan_stops`
--

CREATE TABLE IF NOT EXISTS `tan_stops` (
  `stop_id` int(11) NOT NULL AUTO_INCREMENT,
  `stop_number_of_line` int(11) NOT NULL,
  `stop_name_stop` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `stop_longitude` float NOT NULL,
  `stop_latitude` float NOT NULL,
  PRIMARY KEY (`stop_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
