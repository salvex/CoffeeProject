CREATE DATABASE  IF NOT EXISTS `coffedb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `coffedb`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coffedb
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `availability` (
  `ref_machine` int(11) NOT NULL,
  `ref_product` int(11) NOT NULL,
  `qntY` int(11) DEFAULT NULL,
  PRIMARY KEY (`ref_machine`,`ref_product`),
  KEY `ref_product_idx` (`ref_product`),
  CONSTRAINT `ref_machine` FOREIGN KEY (`ref_machine`) REFERENCES `machine` (`idmachine`),
  CONSTRAINT `ref_product` FOREIGN KEY (`ref_product`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
INSERT INTO `availability` VALUES (1,1,5),(1,2,3),(1,3,6),(1,4,2),(1,5,1),(1,6,6),(1,7,5),(2,1,0),(2,2,2),(2,3,15),(2,4,9),(2,5,4),(2,6,7),(2,7,3),(3,1,4),(3,2,5),(3,3,6),(3,4,1),(3,5,3),(3,6,4),(3,7,5),(4,1,3),(4,2,9),(4,3,6),(4,4,1),(4,5,2),(4,6,0),(4,7,5);
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connection`
--

DROP TABLE IF EXISTS `connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `connection` (
  `ref_email` varchar(44) NOT NULL,
  `ref_machine` int(11) NOT NULL,
  PRIMARY KEY (`ref_email`,`ref_machine`),
  KEY `machine_key_idx` (`ref_machine`) /*!80000 INVISIBLE */,
  KEY `email_key_idx` (`ref_email`) /*!80000 INVISIBLE */,
  CONSTRAINT `email_key` FOREIGN KEY (`ref_email`) REFERENCES `user` (`email`),
  CONSTRAINT `machine_key` FOREIGN KEY (`ref_machine`) REFERENCES `machine` (`idmachine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connection`
--

LOCK TABLES `connection` WRITE;
/*!40000 ALTER TABLE `connection` DISABLE KEYS */;
/*!40000 ALTER TABLE `connection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `machine`
--

DROP TABLE IF EXISTS `machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `machine` (
  `idmachine` int(11) NOT NULL,
  `brand` varchar(45) DEFAULT NULL,
  `isOccupied` int(11) DEFAULT '0',
  PRIMARY KEY (`idmachine`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `machine`
--

LOCK TABLES `machine` WRITE;
/*!40000 ALTER TABLE `machine` DISABLE KEYS */;
INSERT INTO `machine` VALUES (1,'Samsung',0),(2,'MK01',0),(3,'MK02',0),(4,'MK03',0);
/*!40000 ALTER TABLE `machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `product` (
  `idproduct` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  `desc` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Espresso','0.50','Caffè Espresso'),(2,'Corto','0.50','Caffè Corto'),(3,'Ginseng','0.70','Caffè Ginseng'),(4,'Macchiato','0.60','Caffè Macchiato'),(5,'Latte','0.40','Latte'),(6,'Bicchiere','0.10','Bicchiere vuoto'),(7,'Cioccolata','0.60','Cioccolata');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `surname` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `password` varchar(79) DEFAULT NULL,
  `walletQnty` float DEFAULT NULL,
  PRIMARY KEY (`iduser`,`email`),
  UNIQUE KEY `email_uq` (`email`) /*!80000 INVISIBLE */
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */; 
INSERT INTO `user` VALUES (4,'aa','aa','porly@gmail.com','1234569012','$s0$41010$EcPiVehEX3xhtu3sTRLEtQ==$fWTJA6qbQUA3XpVnZ7yIhkneJ08OZcCiTsIxpnd0ZIQ=',0),(5,'Paperino','Papero','pappi@gmail.com','1234569012','$s0$41010$jhHt2QDUsHqShtr2N5Pxcg==$m9r2OLzH+7SQjCzAv5Vypp+xtn3tpQM00ONGOFuCf+w=',0),(6,'Marco','Rossi','marco.rossi@prova.it','1234569012','$s0$41010$ZNfcwkN7ezwbrxZHM6PtMA==$2T2aUHp2BPwqLsHMUDe4QL7USH4o0miZYI5kGXhv/DE=',59.5),(7,'salvo','salvo','prova5@gmail.com','1234569012','$s0$41010$XerX2CaaXhW37gLlD4rB2A==$xmbJsWpY8pMOaJ2nbqj0mBaTxXaJfegvX6hdR6DVviE=',0),(8,'Andrea','Bianchi','andrea.bianchi@prova.it','4447778291','$s0$41010$vBGkz07U2CZjFLkziRDc0A==$NknFuYETwy5l8j1qLVRo3rq33xvcQc+Db3RyYNOKNXs=',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-13 10:53:32
