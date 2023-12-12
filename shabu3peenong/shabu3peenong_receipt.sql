-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: shabu3peenong
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `receipt_id` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_id` int NOT NULL,
  `receipt_date` datetime NOT NULL,
  `receipt_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_order` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_system` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_cashier` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receipt_total` float NOT NULL,
  `receipt_discount` float NOT NULL,
  `receipt_net` float NOT NULL,
  `receipt_customer_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_customer_contact` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`receipt_id`),
  KEY `FK_branch_id_idx` (`branch_id`),
  CONSTRAINT `FK_branch_receipt` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES ('4-16439',1,'2023-01-09 17:15:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',287,0,287,'nan','nan','nan','ปิด'),('4-16440',1,'2023-01-09 17:18:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',308,0,308,'nan','nan','nan','ปิด'),('4-16441',1,'2023-01-09 17:46:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',287,0,287,'nan','nan','nan','ปิด'),('4-16442',1,'2023-01-09 18:03:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',228,0,228,'nan','nan','nan','ปิด'),('4-16443',1,'2023-01-09 18:54:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',199,0,199,'nan','nan','nan','ปิด'),('4-16444',1,'2023-01-09 19:00:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',1014,0,1014,'nan','nan','nan','ปิด'),('4-16445',1,'2023-01-09 19:11:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',259,0,259,'nan','nan','nan','ปิด'),('4-16446',1,'2023-01-09 20:14:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',735,0,735,'nan','nan','nan','ปิด'),('4-16447',1,'2023-01-09 20:27:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',616,0,616,'nan','nan','nan','ปิด'),('4-16448',1,'2023-01-09 20:37:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',1083,0,1083,'nan','nan','nan','ปิด'),('4-16449',1,'2023-01-09 21:58:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',319,0,319,'nan','nan','nan','ปิด'),('4-16450',1,'2023-01-09 21:58:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',855,0,855,'nan','nan','nan','ปิด'),('4-16451',1,'2023-01-09 21:58:00','ลดราคา','ทานในร้าน','iPad Center Phaholyothin 52','พนักงานเสิร์ฟ',676,0,676,'nan','nan','nan','ปิด');
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-12  8:27:45
