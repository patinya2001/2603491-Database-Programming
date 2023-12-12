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
-- Table structure for table `product_list`
--

DROP TABLE IF EXISTS `product_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_list` (
  `SKU` int NOT NULL,
  `sales_id` int NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `product_price` float NOT NULL,
  `product_cost` float NOT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SKU`),
  UNIQUE KEY `SKU_UNIQUE` (`SKU`),
  KEY `sales_id_idx` (`sales_id`),
  CONSTRAINT `FK_sales_product_list` FOREIGN KEY (`sales_id`) REFERENCES `sales_type` (`sales_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_list`
--

LOCK TABLES `product_list` WRITE;
/*!40000 ALTER TABLE `product_list` DISABLE KEYS */;
INSERT INTO `product_list` VALUES (16,7,'สันคอหมูสไลด์',0,0,NULL),(17,7,'สันนอกหมูสไลด์',0,0,NULL),(18,7,'สามชั้นสไลด์',0,0,NULL),(19,7,'ตับหมูสไลด์',0,0,NULL),(21,7,'หมูนุ๊มนุ่ม',0,0,NULL),(24,7,'ฟองเต้าหู้ซีฟู้ด',0,0,NULL),(25,7,'เต้าหู้ปลา',0,0,NULL),(26,7,'ลูกชิ้นกุ้ง',0,0,NULL),(27,7,'ลูกชิ้นปูฮอกไกโด',0,0,NULL),(30,7,'ปลาหมึก',0,0,NULL),(31,7,'ปลาหมึกกรอบ',0,0,NULL),(32,7,'แมงกะพรุน',0,0,NULL),(33,7,'กุ้ง',0,0,NULL),(35,7,'เต้าหู้สอดไส้ชีส',0,0,NULL),(36,7,'เกี๊ยวกุ้ง',0,0,NULL),(37,7,'ไข่ไก่',0,0,NULL),(38,7,'เต้าหู้ไข่',0,0,NULL),(39,7,'วุ้นเส้นถั่วเขียว',0,0,NULL),(40,7,'บะหมี่ผัก',0,0,NULL),(41,7,'มอสซาเรลล่าชีส',0,0,NULL),(42,7,'ข้าวกระเทียม',0,0,NULL),(43,7,'ไก่ทอดกรอบจัง',0,0,NULL),(44,8,'ซุปใสไต้หวัน',0,0,NULL),(45,8,'ซุปญี่ปุ่นน้ำดำ',0,0,NULL),(46,8,'ซุปต้มยำน้ำใส',0,0,NULL),(49,8,'ซุปหม่าล่า',0,0,NULL),(50,6,'เครื่องดื่มรีฟิล',39,39,NULL),(51,6,'น้ำเปล่า',20,20,NULL),(52,1,'Buffet Starter',189,189,NULL),(53,1,'Buffet Deluxe',269,269,NULL),(68,5,'เพิ่มเตา+น้ำซุป 1 ช่อง',59,59,NULL),(69,5,'เพิ่มเตา+น้ำซุป 2 ช่อง',69,69,NULL),(114,4,'ไอศครีม',39,39,NULL),(176,2,'ชุดหมูประหยัด A',319,199,NULL),(202,3,'สามชั้นสไลด์',49,49,NULL),(234,3,'น้ําจิ้มสุกี้ (ขวด)',49,49,NULL),(240,3,'ชุดหมูประหยัด A',199,199,NULL),(241,3,'ชุดหมูประหยัด B',259,259,NULL),(245,3,'ซุปญี่ปุ่นน้ำดำ',39,29,NULL),(250,7,'ชุดหมูรวม',0,0,NULL),(251,3,'ปลาดอร์รี่',39,39,NULL),(254,7,'ปลาดอร์รี่',0,0,NULL),(262,7,'หอยแมลงภู่',0,0,NULL),(266,7,'คริสตัลไข่ปลา',0,0,NULL),(290,7,'ยำสาหร่าย',0,0,NULL),(294,7,'สาหร่ายวากะเมะ',0,0,NULL),(298,7,'เนื้อใบพาย',0,0,NULL),(302,7,'เนื้อเสือร้องให้',0,0,NULL),(306,7,'เนื้อริบอาย',0,0,NULL),(314,7,'หมูหมักพริกไทดำ',0,0,NULL),(318,7,'หอยเชล',0,0,NULL),(322,1,'Buffet Premium',299,0,NULL),(325,7,'เนื้อน่องลาย',0,0,NULL),(326,7,'ไส้หมู',0,0,NULL),(334,7,'ฟองเต้าหู้จีน',0,0,NULL),(338,7,'เส้นมันเทศ',0,0,NULL),(342,7,'เส้นหม่าล่าจีน',0,0,NULL),(346,7,'บะหมี่หยก',0,0,NULL),(351,8,'ซุปกระดูกหมู',0,0,NULL),(10011,8,'เติมน้ําซุป',0,0,NULL);
/*!40000 ALTER TABLE `product_list` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-12  8:27:46
