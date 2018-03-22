-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: TMS
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

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
-- Current Database: `TMS`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `TMS` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `TMS`;

--
-- Table structure for table `featuregroups`
--

DROP TABLE IF EXISTS `featuregroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `featuregroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fgname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `featuregroups`
--

LOCK TABLES `featuregroups` WRITE;
/*!40000 ALTER TABLE `featuregroups` DISABLE KEYS */;
INSERT INTO `featuregroups` VALUES (1,'callProc'),(2,'IPv6'),(3,'selftest'),(4,'permission');
/*!40000 ALTER TABLE `featuregroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(255) NOT NULL,
  `prod_rls_id` int(11) NOT NULL,
  `fg_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `features_ibfk_1` (`prod_rls_id`),
  KEY `features_ibfk_2` (`fg_id`),
  CONSTRAINT `features_ibfk_1` FOREIGN KEY (`prod_rls_id`) REFERENCES `product_rls` (`id`),
  CONSTRAINT `features_ibfk_2` FOREIGN KEY (`fg_id`) REFERENCES `featuregroups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (6,'RoutingTable',1,1),(7,'selftest',2,2),(8,'IPV6Support',3,3),(9,'Authentication',2,4),(10,'Authorisation',4,4);
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_rls`
--

DROP TABLE IF EXISTS `product_rls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_rls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) NOT NULL,
  `rls_num` varchar(100) NOT NULL,
  `rls_name` varchar(255) NOT NULL,
  `rls_type` varchar(255) NOT NULL,
  `remarks` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_prod_rls` (`prod_id`,`rls_num`),
  CONSTRAINT `product_rls_ibfk_1` FOREIGN KEY (`prod_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_rls`
--

LOCK TABLES `product_rls` WRITE;
/*!40000 ALTER TABLE `product_rls` DISABLE KEYS */;
INSERT INTO `product_rls` VALUES (1,1,'1.0.0','US_MKT','Major','With new features for cloud'),(2,1,'2.0.0','US_MKT','Minor','With new features for cloud'),(3,2,'5.x','US_MKT','Major','With new features for cloud'),(4,2,'6.x','US_MKT','Major','With new features for cloud');
/*!40000 ALTER TABLE `product_rls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Router'),(2,'SIP_Proxy');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testcases`
--

DROP TABLE IF EXISTS `testcases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testcases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feat_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `setup` varchar(255) NOT NULL,
  `exec_steps` varchar(255) NOT NULL,
  `expected_result` varchar(255) NOT NULL,
  `automate` tinyint(1) DEFAULT '1',
  `automt_sts` tinyint(1) DEFAULT '0',
  `script_path` varchar(255) DEFAULT NULL,
  `status` enum('Active','Obsolete') DEFAULT 'Active',
  `author_id` int(11) NOT NULL,
  `created` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `feat_id` (`feat_id`),
  CONSTRAINT `testcases_ibfk_1` FOREIGN KEY (`feat_id`) REFERENCES `features` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testcases`
--

LOCK TABLES `testcases` WRITE;
/*!40000 ALTER TABLE `testcases` DISABLE KEYS */;
INSERT INTO `testcases` VALUES (3,8,'A4','A4','A4','A4','A4',1,0,'A4','Active',9005,'2017-04-08 07:07:50','2017-04-08 07:07:50'),(4,6,'A5','some description','some setup','some steps','some result',1,0,'some path','Active',9005,'2017-04-08 08:05:05','2017-04-08 08:05:05'),(5,10,'chg A5','some description','some setup','some steps','some result',1,0,'some path','Active',9003,'2017-04-08 21:32:52','2017-04-08 21:32:52'),(6,6,'test','some descrtesiption','some setup','some steps','some result',1,0,'some path','Active',9005,'2018-03-18 11:25:05','2018-03-18 11:25:05');
/*!40000 ALTER TABLE `testcases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `Users`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Users` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `Users`;

--
-- Table structure for table `memberships`
--

DROP TABLE IF EXISTS `memberships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `memberships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `memberships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `memberships_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberships`
--

LOCK TABLES `memberships` WRITE;
/*!40000 ALTER TABLE `memberships` DISABLE KEYS */;
INSERT INTO `memberships` VALUES (1,9005,3001);
/*!40000 ALTER TABLE `memberships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_role` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=3011 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (3001,'Admin'),(3008,'DevEngineer'),(3007,'DevManager'),(3002,'EngDirector'),(3003,'HRDirector'),(3004,'HRManager'),(3010,'Others'),(3006,'TestEngineer'),(3005,'TestManager'),(3009,'Viewer');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,9005,3001);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_roles_view`
--

DROP TABLE IF EXISTS `user_roles_view`;
/*!50001 DROP VIEW IF EXISTS `user_roles_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `user_roles_view` AS SELECT 
 1 AS `user_id`,
 1 AS `username`,
 1 AS `email`,
 1 AS `mobilenumber`,
 1 AS `role_id`,
 1 AS `role`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobilenumber` varchar(255) DEFAULT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `canlogin` tinyint(1) DEFAULT '1',
  `lastlogin` datetime DEFAULT NULL,
  `pw_changed` datetime DEFAULT NULL,
  `pw_reset_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9028 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (9005,'eeee','eeee@y.com','9898989898','eeee','ee','{CRYPT}$2a$10$fw0XpycqD5JL88Hu7mrFVuFP8AlopoOyTGAjbPXQJla5DKM.HxVdy',NULL,'2017-02-15 05:23:22','2017-02-15 05:23:22','Active',1,NULL,NULL,NULL),(9024,'oooo','oooo@y.com','2121212121','oooo','oo','{CRYPT}$2a$10$/iY5qZMJzFfJtXTBxCgc0ep.e7XksKRwW4mXoJJCgbfSKcOFoklj.',NULL,'2017-02-28 20:27:46','2017-02-28 20:27:46','Active',1,NULL,NULL,NULL),(9025,'vvvv','vvvv@y.com','2121212121','vvvv','oo','{CRYPT}$2a$10$ymY1zc.sFh4LQi2L5zZzHOg07QIUNP/o0.gIjbNYn65fnVpIgTaL.',NULL,'2017-02-28 20:30:23','2017-02-28 20:30:23','Active',1,NULL,NULL,NULL),(9026,'xxxx','xxxx@y.com','2121212121','xxxx','oo','{CRYPT}$2a$10$Y1owO3cQ0miyXjCvrU5jVOCg5/SU3W.uw.adTeg5WtkWZj.HIDjeK',NULL,'2017-02-28 20:37:57','2017-02-28 20:37:57','Active',1,NULL,NULL,NULL),(9027,'aaaa','aaaa@y.com','2121212121','aaaa','oo','{CRYPT}$2a$10$OHjGR9RN2UC7gfYkFZdVWeBw11/SxKFe7Rk3PkGCSP/l44p8qOsS.',NULL,'2017-02-28 20:39:43','2017-02-28 20:39:43','Active',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `TMS`
--

USE `TMS`;

--
-- Current Database: `Users`
--

USE `Users`;

--
-- Final view structure for view `user_roles_view`
--

/*!50001 DROP VIEW IF EXISTS `user_roles_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`opensips`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `user_roles_view` AS select `memberships`.`user_id` AS `user_id`,`users`.`username` AS `username`,`users`.`email` AS `email`,`users`.`mobilenumber` AS `mobilenumber`,`memberships`.`role_id` AS `role_id`,`roles`.`role` AS `role` from ((`users` left join `memberships` on((`users`.`id` = `memberships`.`user_id`))) left join `roles` on((`roles`.`id` = `memberships`.`role_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-20 20:11:21
