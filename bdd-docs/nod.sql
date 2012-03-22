-- phpMyAdmin SQL Dump
-- version 3.4.5deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 22, 2012 at 04:10 PM
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
  `contact_telephone` int(11) NOT NULL,
  `contact_email` int(11) NOT NULL,
  `contact_site_web` int(11) NOT NULL,
  PRIMARY KEY (`contact_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gps`
--

CREATE TABLE IF NOT EXISTS `gps` (
  `gps_id` int(11) NOT NULL AUTO_INCREMENT,
  `gps_longitude` int(11) NOT NULL,
  `gps_latitude` int(11) NOT NULL,
  `gps_adresse` varchar(255) NOT NULL,
  `gps_zip` int(11) NOT NULL,
  `gps_commune` varchar(255) NOT NULL,
  PRIMARY KEY (`gps_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `horaires`
--

CREATE TABLE IF NOT EXISTS `horaires` (
  `horaires_id` int(11) NOT NULL AUTO_INCREMENT,
  `horaire_libelle` int(11) NOT NULL,
  `horaire_date_debut_periode` date NOT NULL,
  `horaire_date_fin_periode` date NOT NULL,
  `horaire_heure_debut` time NOT NULL,
  `horaire_heure_fin` time NOT NULL,
  `horaire_jours_semaine` varchar(7) NOT NULL,
  `horaire_tarifs_id` int(11) NOT NULL,
  PRIMARY KEY (`horaires_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `parcs`
--

CREATE TABLE IF NOT EXISTS `parcs` (
  `parc_id` int(11) NOT NULL AUTO_INCREMENT,
  `parc_jeux` tinyint(1) NOT NULL,
  `parc_mobilier_pique_nique` tinyint(1) NOT NULL,
  `parc_pataugeoire` tinyint(1) NOT NULL,
  `parc_fontaine` tinyint(1) NOT NULL,
  `parc_sanitaire` tinyint(1) NOT NULL,
  `parc_abri` tinyint(1) NOT NULL,
  `parc_acces_handicapes` tinyint(1) NOT NULL,
  `parc_collection_vegetale` tinyint(1) NOT NULL,
  `parc_gardien` tinyint(1) NOT NULL,
  `parc_jardin_clos` tinyint(1) NOT NULL,
  PRIMARY KEY (`parc_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `point_of_interest`
--

CREATE TABLE IF NOT EXISTS `point_of_interest` (
  `poi_id` int(11) NOT NULL AUTO_INCREMENT,
  `poi_libelle` varchar(255) NOT NULL,
  `poi_description` text NOT NULL,
  `poi_id_tan_arret_proximite` int(11) NOT NULL,
  `poi_contact_id` int(11) NOT NULL,
  `poi_gps_id` int(11) NOT NULL,
  `poi_type` varchar(80) NOT NULL,
  `poi_horaire` int(11) NOT NULL,
  `poi_horaire_exc` int(11) NOT NULL,
  PRIMARY KEY (`poi_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `popularite`
--

CREATE TABLE IF NOT EXISTS `popularite` (
  `popularite_id` int(11) NOT NULL AUTO_INCREMENT,
  `popularite_note` int(11) NOT NULL,
  `popularite_id_poi` int(11) NOT NULL,
  PRIMARY KEY (`popularite_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tan_arrets`
--

CREATE TABLE IF NOT EXISTS `tan_arrets` (
  `arret_id` int(11) NOT NULL AUTO_INCREMENT,
  `arret_ligne` int(11) NOT NULL,
  `nom_arret` varchar(255) NOT NULL,
  PRIMARY KEY (`arret_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tarifs`
--

CREATE TABLE IF NOT EXISTS `tarifs` (
  `tarif_id` int(11) NOT NULL AUTO_INCREMENT,
  `tarif_montant_individuel` int(11) NOT NULL,
  `tarif_montant_groupe` int(11) NOT NULL,
  `tarif_montant_abonnement` int(11) NOT NULL,
  PRIMARY KEY (`tarif_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
