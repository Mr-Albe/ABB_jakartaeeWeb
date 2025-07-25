-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 22, 2025 at 01:21 PM
-- Server version: 8.2.0
-- PHP Version: 8.3.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stationdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `approvisionnement`
--

DROP TABLE IF EXISTS `approvisionnement`;
CREATE TABLE IF NOT EXISTS `approvisionnement` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_station` int DEFAULT NULL,
  `type_carburant` enum('gazoline','diesel') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  `date_livraison` date DEFAULT NULL,
  `id_fournisseur` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_station` (`id_station`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approvisionnement`
--

INSERT INTO `approvisionnement` (`id`, `id_station`, `type_carburant`, `quantite`, `date_livraison`, `id_fournisseur`) VALUES
(6, 37, 'diesel', 1000, '2025-07-17', '5'),
(5, 36, 'diesel', 30000, '2025-07-21', '5'),
(7, 38, 'diesel', 75000, '2025-07-17', '5');

-- --------------------------------------------------------

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
CREATE TABLE IF NOT EXISTS `station` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `rue` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `commune` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `capacite_gazoline` int NOT NULL,
  `capacite_diesel` int NOT NULL,
  `quantite_gazoline` int NOT NULL,
  `quantite_diesel` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `station`
--

INSERT INTO `station` (`id`, `numero`, `rue`, `commune`, `capacite_gazoline`, `capacite_diesel`, `quantite_gazoline`, `quantite_diesel`) VALUES
(37, '003', 'Prison', 'Limonade', 450000, 340000, 450000, 131000),
(38, '009', 'st Filomene', 'Cap-Haitien', 4500, 4500, 5, 750),
(35, '001', 'St Melon', 'Limonade', 450000, 450000, 450000, 35000),
(36, '002', 'st Filomene', 'Cap-Haitien', 450000, 3540000, 39000, 114500);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
