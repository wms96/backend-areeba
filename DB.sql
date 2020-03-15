-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.19 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table areeba.card_information
DROP TABLE IF EXISTS `card_information`;
CREATE TABLE IF NOT EXISTS `card_information` (
  `clientId` int unsigned DEFAULT NULL,
  `cardNumber` varchar(50) DEFAULT NULL,
  `expiryDate` int DEFAULT NULL,
  `securityCode` int DEFAULT NULL,
  `cardholderName` varchar(255) DEFAULT NULL,
  `cardId` int DEFAULT NULL,
  `contractId` int DEFAULT NULL,
  `contractNumber` varchar(50) DEFAULT NULL,
  `bankId` varchar(50) DEFAULT NULL,
  KEY `FK_card_information_users` (`clientId`),
  CONSTRAINT `FK_card_information_users` FOREIGN KEY (`clientId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table areeba.card_information: ~0 rows (approximately)
/*!40000 ALTER TABLE `card_information` DISABLE KEYS */;
INSERT INTO `card_information` (`clientId`, `cardNumber`, `expiryDate`, `securityCode`, `cardholderName`, `cardId`, `contractId`, `contractNumber`, `bankId`) VALUES
	(NULL, NULL, 2301, 656, ' Super Man', 629330, 629320, ' 000028-P-324460', ' 157856685855'),
	(2, '5114200290843273', 2301, 317, 'Super Man', 629450, 629440, '000028-P-190370', '157856685855'),
	(2, '5114200258598547', 2301, 400, 'Super Man', 629490, 629480, '000028-P-867920', '157856685855');
/*!40000 ALTER TABLE `card_information` ENABLE KEYS */;

-- Dumping structure for table areeba.credit
DROP TABLE IF EXISTS `credit`;
CREATE TABLE IF NOT EXISTS `credit` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int unsigned DEFAULT NULL,
  `transaction` int unsigned DEFAULT NULL,
  `amount` int DEFAULT NULL,
  `details` char(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_credit_users` (`client_id`),
  CONSTRAINT `FK_credit_users` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table areeba.credit: ~0 rows (approximately)
/*!40000 ALTER TABLE `credit` DISABLE KEYS */;
INSERT INTO `credit` (`id`, `client_id`, `transaction`, `amount`, `details`, `created_at`) VALUES
	(1, 3, 1, 121212, 'asdasdasd', '2020-03-14 22:59:56'),
	(2, 2, 1, 2020, 'test', '2020-03-14 23:23:49'),
	(3, 3, 1, 121212, 'asdasdasd', '2020-03-14 23:50:46'),
	(4, 2, 1, 2020, 'test', '2020-03-14 23:56:37'),
	(5, 2, 2, 123213, 'ts', '2020-03-15 06:09:22'),
	(6, 2, 6, 2020, 'asd', '2020-03-15 06:11:40'),
	(7, 2, 1, 2020, 'asd', '2020-03-15 06:19:09'),
	(8, 2, 1, 2020, 'asd', '2020-03-15 06:20:18'),
	(9, 2, 1, 2020, 'asd', '2020-03-15 06:21:18'),
	(10, 2, 1, 2020, 'asd', '2020-03-15 06:22:32'),
	(11, 2, 1, 2020, 'asd', '2020-03-15 06:44:10'),
	(12, 2, 1, 2020, 'asd', '2020-03-15 06:45:26'),
	(13, 2, 23, 12, '122112', '2020-03-15 08:28:22');
/*!40000 ALTER TABLE `credit` ENABLE KEYS */;

-- Dumping structure for table areeba.debit
DROP TABLE IF EXISTS `debit`;
CREATE TABLE IF NOT EXISTS `debit` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int unsigned NOT NULL,
  `amount` int DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users` (`client_id`),
  CONSTRAINT `FK__users` FOREIGN KEY (`client_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table areeba.debit: ~0 rows (approximately)
/*!40000 ALTER TABLE `debit` DISABLE KEYS */;
INSERT INTO `debit` (`id`, `client_id`, `amount`, `details`, `created_at`) VALUES
	(1, 3, 121212, 'asdasdasd', '2020-03-14 21:45:54'),
	(2, 2, 2020, 'Name', '2020-03-14 22:26:23'),
	(3, 2, 123, 'Name', '2020-03-14 22:48:18'),
	(4, 2, 2020, 'test', '2020-03-14 23:08:16'),
	(5, 2, 2020, '2020', '2020-03-14 23:09:32'),
	(6, 2, 2020, '2020', '2020-03-14 23:10:31'),
	(7, 2, 2020, 'we', '2020-03-14 23:12:57'),
	(8, 2, 2020, 'test', '2020-03-14 23:23:09'),
	(9, 3, 121212, 'asdasdasd', '2020-03-14 23:40:39'),
	(10, 3, 121212, 'asdasdasd', '2020-03-14 23:41:09'),
	(11, 3, 121212, 'asdasdasd', '2020-03-14 23:41:36'),
	(12, 3, 121212, 'asdasdasd', '2020-03-14 23:43:15'),
	(13, 2, 2020, 'test', '2020-03-14 23:55:08'),
	(14, 2, 123213, 'ts', '2020-03-15 06:08:26'),
	(15, 2, 2020, 'asd', '2020-03-15 06:11:30'),
	(16, 2, 2020, '123456', '2020-03-15 08:12:14'),
	(17, 2, 123456789, 'asdasdasdasd', '2020-03-15 08:12:41'),
	(18, 2, 1235, 'sadasd', '2020-03-15 08:14:12'),
	(19, 2, 123, '123123', '2020-03-15 08:15:57'),
	(20, 2, 121212, '121212', '2020-03-15 08:16:56'),
	(21, 2, 16161, 'sbbsbsb', '2020-03-15 08:19:47'),
	(22, 2, 12, 'ggg', '2020-03-15 08:25:43'),
	(23, 2, 12, '122112', '2020-03-15 08:28:01');
/*!40000 ALTER TABLE `debit` ENABLE KEYS */;

-- Dumping structure for table areeba.history
DROP TABLE IF EXISTS `history`;
CREATE TABLE IF NOT EXISTS `history` (
  `credit_id` int unsigned NOT NULL,
  `debit_id` int unsigned NOT NULL,
  KEY `FK__credit` (`credit_id`),
  KEY `FK__debit` (`debit_id`),
  CONSTRAINT `FK__credit` FOREIGN KEY (`credit_id`) REFERENCES `credit` (`id`),
  CONSTRAINT `FK__debit` FOREIGN KEY (`debit_id`) REFERENCES `debit` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table areeba.history: ~0 rows (approximately)
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
INSERT INTO `history` (`credit_id`, `debit_id`) VALUES
	(3, 12),
	(4, 13);
/*!40000 ALTER TABLE `history` ENABLE KEYS */;

-- Dumping structure for table areeba.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone_number` int NOT NULL,
  `address` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `qr_ref` varchar(255) NOT NULL,
  `last_requested_token` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table areeba.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone_number`, `address`, `password`, `qr_ref`, `last_requested_token`, `created_at`, `last_login`) VALUES
	(2, 'ramy', 'merheb', 'ramymerheb@gmail.com', 71035881, NULL, '$2a$10$06VTVeKZg6iTB0g7x9AUjOfrIqjvt3UfDGI.Gzp62Np7CaPfrBgLq', '$2a$10$xEhK3FuMJiGnptTrtPeJMeGqdywjMHUPK8hGha8LG385YA7su1nvi', NULL, '2020-03-14 10:39:19', '2020-03-15 08:28:15'),
	(3, 'ramy', 'merheb', 'ramymerheb@gmail.com', 710358132, NULL, '$2a$10$oP0f9yPs/4JD35d.cbfreuELxZVRfo2kY6qK/Z2sX7nW..QpbXDz2', '$2a$10$oP0f9yPs/4JD35d.cbfreuCb937kIMslfd8d2oFCx7hF2bFlubPMy', NULL, '2020-03-14 14:43:37', NULL),
	(4, 'ramy', 'merheb', 'ramymerheb@gmail.com', 722358132, NULL, '$2a$10$WgBjBAvYvPIiHoz8qq4JP.eTTfjfzCOPJ8FMR37uViRWG3u.C7mnW', '$2a$10$WgBjBAvYvPIiHoz8qq4JP.Y5Mmm58FK9ZU3nBlZCAygy6aEFjWFwm', NULL, '2020-03-14 14:54:08', '2020-03-14 16:54:02'),
	(5, 'Jurassic', 'Park', 'ramymerheb1996@gmail.com', 123321111, '123321111', '$2a$10$L6Gps6w2KBffWpBeUbskaOAvzEG2ngQA3/V5gj6aJncGXTf1MLwUi', '$2a$10$L6Gps6w2KBffWpBeUbskaOOPz.whav6Qf1OwQ1JjCkNsPQ2tIP0Rm', NULL, '2020-03-14 15:21:42', NULL),
	(6, 'ramy', 'merheb', 'ramymerheb@gmail.com', 123456789, 'Name', '$2a$10$L6Gps6w2KBffWpBeUbskaOx/9v8sgJi/I5ZZIJkOg0xIOqCAMXVFC', '$2a$10$L6Gps6w2KBffWpBeUbskaO0s1qlmU4QKoI4ZoClQdqs1I6ilrB.fC', NULL, '2020-03-14 16:10:37', NULL),
	(7, 'rrrr', 'tttt', 'rara@gmail.com', 1242152152, 'Name', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.6vhDuNwiJV5fBisy4l70g8153q6YFAu', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.1CX6B9x46TJx.87lR.2fCoyyNsIQKSm', NULL, '2020-03-14 16:18:40', NULL),
	(8, 'asdasd', 'hgjhgj', 'gjhhjghjg@hjgj.com', 565456456, 'asdasdName', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.FkuHCUCd9iFOiRtYMAH.g/RGp5wEh3u', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.LUI19IejEqLTneZbhraeJkUYpiFVkFu', NULL, '2020-03-14 16:24:06', NULL),
	(9, 'asdjlasdjl', 'sdkljsalkdj', 'aksjdlkas@adssda.com', 123456888, '12345688Name', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.FkuHCUCd9iFOiRtYMAH.g/RGp5wEh3u', '$2a$10$f9bLRXeDEE8V5b3ZnVFHN.XTCI8UeSQrBP5jrP6T1bSCw3I3u7C36', NULL, '2020-03-14 16:28:05', NULL),
	(10, 'ramy', 'merheb', 'ramymerheb@gmail.com', 11111111, 'Name', '$2a$10$mltJANuz6oeYQc7sqS0rteGxd7BQV1PdBCybFs32ImLOr5Zgzv/0O', '$2a$10$mltJANuz6oeYQc7sqS0rteWHvFeOZtz6uksPncE.Ungsx/Xsi1RMW', NULL, '2020-03-14 16:43:24', NULL),
	(11, '123456', '123456', '123465@gmail.com', 123456, '231465', '$2a$10$06VTVeKZg6iTB0g7x9AUjOfrIqjvt3UfDGI.Gzp62Np7CaPfrBgLq', '$2a$10$06VTVeKZg6iTB0g7x9AUjOPnqKsYSqVyIc3coSFC58pJjykbpLB0a', NULL, '2020-03-14 19:51:53', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
