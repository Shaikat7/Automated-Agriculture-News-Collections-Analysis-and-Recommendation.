-- MySQL dump 10.14  Distrib 5.5.68-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: NEWS_PORTAL
-- ------------------------------------------------------
-- Server version	5.5.68-MariaDB

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
-- Table structure for table `Articles`
--

DROP TABLE IF EXISTS `Articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Articles` (
  `ArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `ArticleTitle` varchar(200) DEFAULT NULL,
  `ArticleText` text NOT NULL,
  `ArticleDate` datetime NOT NULL,
  `ArticleUrl` varchar(767) NOT NULL,
  PRIMARY KEY (`ArticleID`),
  UNIQUE KEY `ArticleUrl` (`ArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=391139 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `AgricultureNewsDetails`
--

DROP TABLE IF EXISTS `AgricultureNewsDetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AgricultureNewsDetails` (
 `NewsArticleID` int(11) NOT NULL,
  `Locations` varchar(50) DEFAULT NULL,
  `Criminals` text,
  `Victims` text,
  `Crime` text,
  `CrimeSeverity` float DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `ArticleAge` text,
  `DateString` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`NewsArticleID`),
  CONSTRAINT `AgricultureNewsDetails_ibfk_1` FOREIGN KEY (`NewsArticleID`) REFERENCES `NewsArticles` (`NewsArticleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `LocationInfo`
--

DROP TABLE IF EXISTS `LocationInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LocationInfo` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT,
  `queried_name` varchar(50) DEFAULT NULL,
  `display_name` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postcode` varchar(6) DEFAULT NULL,
  `class` varchar(20) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `osm_type` varchar(20) DEFAULT NULL,
  `lat` double DEFAULT NULL,
  `lon` double DEFAULT NULL,
  `min_lat` double DEFAULT NULL,
  `max_lat` double DEFAULT NULL,
  `min_lon` double DEFAULT NULL,
  `max_lon` double DEFAULT NULL,
  `crime_score` double DEFAULT NULL,
  `LastModifiedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3433 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MaxScore`
--

DROP TABLE IF EXISTS `MaxScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MaxScore` (
  `max_score` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `NewsArticles`
--

DROP TABLE IF EXISTS `NewsArticles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NewsArticles` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
DROP TABLE IF EXISTS `NonAgricultureArticles`;
-- Table structure for table ``
--

DROP TABLE IF EXISTS `NonAgricultureArticles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NonAgricultureArticles` (
  `ArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `ArticleTitle` varchar(200) DEFAULT NULL,
  `ArticleText` text NOT NULL,
  `ArticleDate` datetime NOT NULL,
  `ArticleUrl` varchar(767) NOT NULL,
  PRIMARY KEY (`ArticleID`),
  UNIQUE KEY `ArticleUrl` (`ArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `words`
--

DROP TABLE IF EXISTS `words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `words` (
  `word_id` int(11) NOT NULL AUTO_INCREMENT,
  `word` varchar(50) DEFAULT NULL,
  `forms` text,
  PRIMARY KEY (`word_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Subclass
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DROP TABLE IF EXISTS `OtherAgriNews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OtherAgriNews` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/////////////////////////////////////////////////////////////////////////////////////

DROP TABLE IF EXISTS `1_Government`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `1_Government` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

..............................
DROP TABLE IF EXISTS `2_Weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `2_Weather` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
........................................
DROP TABLE IF EXISTS `3_International`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `3_International` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
...........................................................
DROP TABLE IF EXISTS `4_Ecconomic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `4_Ecconomic` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
........................................................
DROP TABLE IF EXISTS `5_Animal_Husbandry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `5_Animal_Husbandry` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
........................................................
DROP TABLE IF EXISTS `6_Crop_Diseases_and_Protections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `6_Crop_Diseases_and_Protections` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
.........................................................
DROP TABLE IF EXISTS `7_Technologies_and_Methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `7_Technologies_and_Methods` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Sentiment Analysis
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
DROP TABLE IF EXISTS `Positive_sentiment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Positive_sentiment` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

...........................................................................

DROP TABLE IF EXISTS `Negative_sentiment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Negative_sentiment` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
.........................................................

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Time sensitive
/////////////////////////////////////////////////////////////////////////////////////////////////////
DROP TABLE IF EXISTS `Time_sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Time_sensitive` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
................................................................................
DROP TABLE IF EXISTS `Not_Time_sensitive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Not_Time_sensitive` (
  `NewsArticleID` int(11) NOT NULL AUTO_INCREMENT,
  `NewsArticleTitle` varchar(200) DEFAULT NULL,
  `NewsArticleText` text,
  `NewsArticleDate` datetime DEFAULT NULL,
  `NewsArticleUrl` varchar(767) NOT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `AnalyzedBy` varchar(20) DEFAULT NULL,
  `NewsType` varchar(10) DEFAULT NULL,
  `TimeStamp` datetime DEFAULT NULL,
  `DuplicateReferenceId` int(11) DEFAULT NULL,
  `ExtractedLocation` varchar(256) DEFAULT NULL,
  `ExtractedName` varchar(256) DEFAULT NULL,
  `entities_dict` text,
  PRIMARY KEY (`NewsArticleID`),
  UNIQUE KEY `NewsArticleUrl` (`NewsArticleUrl`)
) ENGINE=InnoDB AUTO_INCREMENT=796074 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

