-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: survey
-- ------------------------------------------------------
-- Server version	5.7.15-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupID` int(11) NOT NULL,
  `groupSize` int(11) DEFAULT NULL,
  `results` int(11) DEFAULT NULL,
  PRIMARY KEY (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,4,0),(2,4,0),(3,4,0),(4,4,0),(5,4,0),(6,4,0),(7,4,0),(8,4,0),(9,4,0),(10,4,0),(11,4,0),(12,4,0),(13,4,0),(14,4,0),(15,4,0),(16,4,0),(17,4,0),(18,4,0),(19,4,0),(20,4,0),(21,4,0),(22,4,0),(23,4,0),(24,4,0),(25,4,0),(26,4,0),(27,4,0),(28,4,0),(29,4,0),(30,4,0),(31,4,0),(32,4,0),(33,4,0),(34,4,0),(35,4,0),(36,4,0),(37,4,0),(38,4,0),(39,4,0),(40,4,0),(41,5,0),(42,5,0),(43,5,0),(44,5,0),(45,5,0),(46,5,0),(47,5,0),(48,5,0),(49,5,0),(50,5,0),(51,5,0),(52,5,0),(53,5,0),(54,5,0),(55,5,0),(56,5,0),(57,5,0),(58,5,0),(59,5,0),(60,5,0),(61,5,0),(62,5,0),(63,5,0),(64,5,0),(65,5,0),(66,5,0),(67,5,0),(68,5,0),(69,5,0),(70,5,0),(71,5,0),(72,5,0),(73,5,0),(74,5,0),(75,5,0),(76,5,0),(77,5,0),(78,5,0),(79,5,0),(80,5,0),(81,6,0),(82,6,0),(83,6,0),(84,6,0),(85,6,0),(86,6,0),(87,6,0),(88,6,0),(89,6,0),(90,6,0),(91,6,0),(92,6,0),(93,6,0),(94,6,0),(95,6,0),(96,6,0),(97,6,0),(98,6,0),(99,6,0),(100,6,0),(101,6,0),(102,6,0),(103,6,0),(104,6,0),(105,6,0),(106,6,0),(107,6,0),(108,6,0),(109,6,0),(110,6,0),(111,6,0),(112,6,0),(113,6,0),(114,6,0),(115,6,0),(116,6,0),(117,6,0),(118,6,0),(119,6,0),(120,6,0),(121,7,0),(122,7,0),(123,7,0),(124,7,0),(125,7,0),(126,7,0),(127,7,0),(128,7,0),(129,7,0),(130,7,0),(131,7,0),(132,7,0),(133,7,0),(134,7,0),(135,7,0),(136,7,0),(137,7,0),(138,7,0),(139,7,0),(140,7,0),(141,7,0),(142,7,0),(143,7,0),(144,7,0),(145,7,0),(146,7,0),(147,7,0),(148,7,0),(149,7,0),(150,7,0),(151,7,0),(152,7,0),(153,7,0),(154,7,0),(155,7,0),(156,7,0),(157,7,0),(158,7,0),(159,7,0),(160,7,0),(161,8,0),(162,8,0),(163,8,0),(164,8,0),(165,8,0),(166,8,0),(167,8,0),(168,8,0),(169,8,0),(170,8,0),(171,8,0),(172,8,0),(173,8,0),(174,8,0),(175,8,0),(176,8,0),(177,8,0),(178,8,0),(179,8,0),(180,8,0),(181,8,0),(182,8,0),(183,8,0),(184,8,0),(185,8,0),(186,8,0),(187,8,0),(188,8,0),(189,8,0),(190,8,0),(191,8,0),(192,8,0),(193,8,0),(194,8,0),(195,8,0),(196,8,0),(197,8,0),(198,8,0),(199,8,0),(200,8,0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-03-08 13:40:49
