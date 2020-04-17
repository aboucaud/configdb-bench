-- MySQL dump 10.13  Distrib 5.5.9, for osx10.6 (i386)
--
-- Host: localhost    Database: ccs
-- ------------------------------------------------------
-- Server version	5.5.56-MariaDB

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
-- Table structure for table `ccs_agentDesc`
--

DROP TABLE IF EXISTS `ccs_agentDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_agentDesc` (
  `agentName` varchar(255) NOT NULL,
  `agentType` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`agentName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_agentState`
--

DROP TABLE IF EXISTS `ccs_agentState`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_agentState` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agentName` varchar(255) NOT NULL,
  `hashMD5` varbinary(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_agentSt_ageNa_hasMD5_u` (`agentName`,`hashMD5`)
) ENGINE=InnoDB AUTO_INCREMENT=70803 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_agentState_componentStates_join`
--

DROP TABLE IF EXISTS `ccs_agentState_componentStates_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_agentState_componentStates_join` (
  `agentStateId` bigint(20) NOT NULL,
  `componentStateId` bigint(20) DEFAULT NULL,
  `componentName` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`agentStateId`,`componentName`),
  KEY `ccs_agentStBuDe_componenStId_stateBuDe_fk` (`componentStateId`),
  CONSTRAINT `ccs_agentState_componentStates_join_ibfk_1` FOREIGN KEY (`componentStateId`) REFERENCES `ccs_stateBundleDesc` (`id`),
  CONSTRAINT `ccs_agentStBuDe_agentStId_agentSt_fk` FOREIGN KEY (`agentStateId`) REFERENCES `ccs_agentState` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_alertDesc`
--

DROP TABLE IF EXISTS `ccs_alertDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_alertDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `alertDescription` varchar(255) DEFAULT NULL,
  `alertId` varchar(255) DEFAULT NULL,
  `agentName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_alertDe_agentNa_alertId_u` (`agentName`,`alertId`),
  CONSTRAINT `ccs_alertDe_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_baseDesc`
--

DROP TABLE IF EXISTS `ccs_cfg_baseDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_baseDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hashMD5` varbinary(100) NOT NULL,
  `agentName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_cfg_baseDe_hashMD5_u` (`hashMD5`),
  KEY `ccs_cfg_baseDe_agentNa_agentDe_fk` (`agentName`),
  CONSTRAINT `ccs_cfg_baseDe_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_baseDesc_configParam_join`
--

DROP TABLE IF EXISTS `ccs_cfg_baseDesc_configParam_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_baseDesc_configParam_join` (
  `baseDescriptionId` bigint(20) NOT NULL,
  `configurationParametersId` bigint(20) NOT NULL,
  PRIMARY KEY (`baseDescriptionId`,`configurationParametersId`),
  KEY `ccs_cfg_baseDePa_configurPaId_cfg_confPa_fk` (`configurationParametersId`),
  CONSTRAINT `ccs_cfg_baseDePa_baseDeId_cfg_baseDe_fk` FOREIGN KEY (`baseDescriptionId`) REFERENCES `ccs_cfg_baseDesc` (`id`),
  CONSTRAINT `ccs_cfg_baseDePa_configurPaId_cfg_confPa_fk` FOREIGN KEY (`configurationParametersId`) REFERENCES `ccs_cfg_configParam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_config`
--

DROP TABLE IF EXISTS `ccs_cfg_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) DEFAULT NULL,
  `configName` varchar(255) DEFAULT NULL,
  `defaultVersion` bit(1) NOT NULL,
  `hashMD5` varbinary(100) NOT NULL,
  `latestVersion` bit(1) NOT NULL,
  `tsaved` bigint(20) NOT NULL,
  `version` int(11) NOT NULL,
  `baseDescriptionId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_cfg_conf_baDeId_ca_coNa_ve_u` (`baseDescriptionId`,`category`,`configName`,`version`),
  KEY `ccs_cfg_conf_hashMD5_i` (`hashMD5`),
  CONSTRAINT `ccs_cfg_conf_baseDeId_cfg_baseDe_fk` FOREIGN KEY (`baseDescriptionId`) REFERENCES `ccs_cfg_baseDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_configInfoData`
--

DROP TABLE IF EXISTS `ccs_cfg_configInfoData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_configInfoData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` bigint(20) NOT NULL,
  `agentName` varchar(255) NOT NULL,
  `agentStateId` bigint(20) NOT NULL,
  `descriptionId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_cfg_confInDa_time_i` (`time`),
  KEY `ccs_cfg_confInDa_agentNa_agentDe_fk` (`agentName`),
  KEY `ccs_cfg_confInDa_agentStId_agentSt_fk` (`agentStateId`),
  KEY `ccs_cfg_confInDa_descriptId_cfg_desc_fk` (`descriptionId`),
  CONSTRAINT `ccs_cfg_confInDa_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`),
  CONSTRAINT `ccs_cfg_confInDa_agentStId_agentSt_fk` FOREIGN KEY (`agentStateId`) REFERENCES `ccs_agentState` (`id`),
  CONSTRAINT `ccs_cfg_confInDa_descriptId_cfg_desc_fk` FOREIGN KEY (`descriptionId`) REFERENCES `ccs_cfg_description` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_configInfoData_configRuns_join`
--

DROP TABLE IF EXISTS `ccs_cfg_configInfoData_configRuns_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_configInfoData_configRuns_join` (
  `configurationInfoDataId` bigint(20) NOT NULL,
  `configurationRunsId` bigint(20) NOT NULL,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`configurationInfoDataId`,`category`),
  KEY `ccs_cfg_confInDaRu_configurRuId_cfg_confRu_fk` (`configurationRunsId`),
  CONSTRAINT `ccs_cfg_confInDaRu_configurInDaId_cfg_confInDa_fk` FOREIGN KEY (`configurationInfoDataId`) REFERENCES `ccs_cfg_configInf
oData` (`id`),
  CONSTRAINT `ccs_cfg_confInDaRu_configurRuId_cfg_confRu_fk` FOREIGN KEY (`configurationRunsId`) REFERENCES `ccs_cfg_configRun` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_configParam`
--

DROP TABLE IF EXISTS `ccs_cfg_configParam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_configParam` (
  `id` bigint(20) NOT NULL,
  `agentName` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `descriptionStr` varchar(255) DEFAULT NULL,
  `finalValue` varchar(255) DEFAULT NULL,
  `componentName` varchar(255) DEFAULT NULL,
  `parameterName` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_cfg_confPa_agNa_coNa_paNa_ty_ca_fiVa_u` (`agentName`,`componentName`,`parameterName`,`type`,`category`,`finalValue`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_configParamValue`
--

DROP TABLE IF EXISTS `ccs_cfg_configParamValue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_configParamValue` (
  `id` bigint(20) NOT NULL,
  `TChanged` bigint(20) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `configurationId` bigint(20) DEFAULT NULL,
  `configurationParameterId` bigint(20) NOT NULL,
  `configurationRunId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_cfg_confPaVa_confiPaId_value_tCh_u` (`configurationParameterId`,`value`,`TChanged`),
  KEY `ccs_cfg_confPaVa_configurId_cfg_conf_fk` (`configurationId`),
  KEY `ccs_cfg_confPaVa_configurRuId_cfg_confRu_fk` (`configurationRunId`),
  CONSTRAINT `ccs_cfg_confPaVa_configurId_cfg_conf_fk` FOREIGN KEY (`configurationId`) REFERENCES `ccs_cfg_config` (`id`),
  CONSTRAINT `ccs_cfg_confPaVa_configurPaId_cfg_confPa_fk` FOREIGN KEY (`configurationParameterId`) REFERENCES `ccs_cfg_configParam` (`id`),
  CONSTRAINT `ccs_cfg_confPaVa_configurRuId_cfg_confRu_fk` FOREIGN KEY (`configurationRunId`) REFERENCES `ccs_cfg_configRun` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_configRun`
--

DROP TABLE IF EXISTS `ccs_cfg_configRun`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_configRun` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tstart` bigint(20) NOT NULL,
  `tstop` bigint(20) NOT NULL,
  `configurationId` bigint(20) NOT NULL,
  `descriptionId` bigint(20) NOT NULL,
  `globalConfigurationId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_cfg_confRu_configurId_cfg_conf_fk` (`configurationId`),
  KEY `ccs_cfg_confRu_descriptId_cfg_desc_fk` (`descriptionId`),
  KEY `ccs_cfg_confRu_globalCoId_cfg_globCo_fk` (`globalConfigurationId`),
  CONSTRAINT `ccs_cfg_confRu_configurId_cfg_conf_fk` FOREIGN KEY (`configurationId`) REFERENCES `ccs_cfg_config` (`id`),
  CONSTRAINT `ccs_cfg_confRu_descriptId_cfg_desc_fk` FOREIGN KEY (`descriptionId`) REFERENCES `ccs_cfg_description` (`id`),
  CONSTRAINT `ccs_cfg_confRu_globalCoId_cfg_globCo_fk` FOREIGN KEY (`globalConfigurationId`) REFERENCES `ccs_cfg_globalConfig` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_description`
--

DROP TABLE IF EXISTS `ccs_cfg_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_description` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `baseDescriptionId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_cfg_desc_baseDeId_cfg_baseDe_fk` (`baseDescriptionId`),
  CONSTRAINT `ccs_cfg_desc_baseDeId_cfg_baseDe_fk` FOREIGN KEY (`baseDescriptionId`) REFERENCES `ccs_cfg_baseDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_description_finalValues_join`
--

DROP TABLE IF EXISTS `ccs_cfg_description_finalValues_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_description_finalValues_join` (
  `descriptionId` bigint(20) NOT NULL,
  `finalValuesId` bigint(20) NOT NULL,
  PRIMARY KEY (`descriptionId`,`finalValuesId`),
  KEY `ccs_cfg_descVa_finalVaId_cfg_confPa_fk` (`finalValuesId`),
  CONSTRAINT `ccs_cfg_descVa_descriptId_cfg_desc_fk` FOREIGN KEY (`descriptionId`) REFERENCES `ccs_cfg_description` (`id`),
  CONSTRAINT `ccs_cfg_descVa_finalVaId_cfg_confPa_fk` FOREIGN KEY (`finalValuesId`) REFERENCES `ccs_cfg_configParam` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_globalConfig`
--

DROP TABLE IF EXISTS `ccs_cfg_globalConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_globalConfig` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `latest` bit(1) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `descriptionId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_cfg_globCo_descrId_name_versi_u` (`descriptionId`,`name`,`version`),
  CONSTRAINT `ccs_cfg_globCo_descriptId_cfg_baseDe_fk` FOREIGN KEY (`descriptionId`) REFERENCES `ccs_cfg_baseDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_cfg_globalConfig_configs_join`
--

DROP TABLE IF EXISTS `ccs_cfg_globalConfig_configs_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_cfg_globalConfig_configs_join` (
  `globalConfigurationId` bigint(20) NOT NULL,
  `configurationsId` bigint(20) NOT NULL,
  `configurations_KEY` varchar(255) NOT NULL,
  PRIMARY KEY (`globalConfigurationId`,`configurations_KEY`),
  KEY `ccs_cfg_globCo_configurId_cfg_conf_fk` (`configurationsId`),
  CONSTRAINT `ccs_cfg_globCo_configurId_cfg_conf_fk` FOREIGN KEY (`configurationsId`) REFERENCES `ccs_cfg_config` (`id`),
  CONSTRAINT `ccs_cfg_globCo_globalCoId_cfg_globCo_fk` FOREIGN KEY (`globalConfigurationId`) REFERENCES `ccs_cfg_globalConfig` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_clearedAlertData`
--

DROP TABLE IF EXISTS `ccs_clearedAlertData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_clearedAlertData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` bigint(20) NOT NULL,
  `agentName` varchar(255) NOT NULL,
  `agentStateId` bigint(20) NOT NULL,
  `alertDescId` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_clearedAlDa_time_i` (`time`),
  KEY `ccs_clearedAlDa_agentNa_agentDe_fk` (`agentName`),
  KEY `ccs_clearedAlDa_agentStId_agentSt_fk` (`agentStateId`),
  KEY `ccs_clearedAlDa_alertDeId_alertDe_fk` (`alertDescId`),
  CONSTRAINT `ccs_clearedAlDa_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`),
  CONSTRAINT `ccs_clearedAlDa_agentStId_agentSt_fk` FOREIGN KEY (`agentStateId`) REFERENCES `ccs_agentState` (`id`),
  CONSTRAINT `ccs_clearedAlDa_alertDeId_alertDe_fk` FOREIGN KEY (`alertDescId`) REFERENCES `ccs_alertDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_counters`
--

DROP TABLE IF EXISTS `ccs_counters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_counters` (
  `date` varchar(8) NOT NULL,
  `value` int(11) NOT NULL,
  `source` varchar(2) NOT NULL,
  `controller` varchar(2) NOT NULL,
  PRIMARY KEY (`source`,`controller`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_dataDesc`
--

DROP TABLE IF EXISTS `ccs_dataDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_dataDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agentName` varchar(255) NOT NULL,
  `dataName` varchar(255) NOT NULL,
  `dataType` varchar(100) DEFAULT NULL,
  `active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_dataDe_agentNa_dataNa_u` (`agentName`,`dataName`),
  KEY `ccs_dataDe_agentNa_i` (`agentName`)
) ENGINE=InnoDB AUTO_INCREMENT=408 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_dataGroup`
--

DROP TABLE IF EXISTS `ccs_dataGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_dataGroup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `agentName` varchar(255) DEFAULT NULL,
  `groupName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_dataGr_agentNa_groupNa_u` (`agentName`,`groupName`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_dataGroup_members_join`
--

DROP TABLE IF EXISTS `ccs_dataGroup_members_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_dataGroup_members_join` (
  `dataGroupId` bigint(20) NOT NULL,
  `memberId` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dataGroupId`,`memberId`),
  KEY `ccs_dataGrDe_membersId_dataDe_fk` (`memberId`),
  CONSTRAINT `ccs_dataGrDe_dataGrId_dataGr_fk` FOREIGN KEY (`dataGroupId`) REFERENCES `ccs_dataGroup` (`id`),
  CONSTRAINT `ccs_dataGroup_members_join_ibfk_1` FOREIGN KEY (`memberId`) REFERENCES `ccs_dataDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_enhanced_sequence`
--

DROP TABLE IF EXISTS `ccs_enhanced_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_enhanced_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_innerStateDesc`
--

DROP TABLE IF EXISTS `ccs_innerStateDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_innerStateDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `enumClassName` varchar(255) NOT NULL,
  `enumValue` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1270 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_metaDataData`
--

DROP TABLE IF EXISTS `ccs_metaDataData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_metaDataData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `endTime` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `startTime` bigint(20) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `dataDescId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_metaDaDa_dataDeId_i` (`dataDescId`),
  KEY `ccs_metaDaDa_startTi_i` (`startTime`),
  KEY `ccs_metaDaDa_endTi_i` (`endTime`),
  KEY `ccs_metaDaDa_dataDeId_startTi_endTi_i` (`dataDescId`,`startTime`,`endTime`),
  CONSTRAINT `ccs_metaDaDa_dataDeId_dataGr_fk` FOREIGN KEY (`dataDescId`) REFERENCES `ccs_dataGroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=707056 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_plotData`
--

DROP TABLE IF EXISTS `ccs_plotData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_plotData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `plotData` longtext,
  `time` bigint(20) NOT NULL,
  `dataDescId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_plotDa_dataDeId_i` (`dataDescId`),
  KEY `ccs_plotDa_time_i` (`time`),
  CONSTRAINT `ccs_plotDa_dataDeId_dataDe_fk` FOREIGN KEY (`dataDescId`) REFERENCES `ccs_dataDesc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26597 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_raisedAlertData`
--

DROP TABLE IF EXISTS `ccs_raisedAlertData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_raisedAlertData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` bigint(20) NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `alertCause` varchar(255) DEFAULT NULL,
  `severity` varchar(255) DEFAULT NULL,
  `agentName` varchar(255) NOT NULL,
  `agentStateId` bigint(20) NOT NULL,
  `alertDescId` bigint(20) NOT NULL,
  `clearingAlertId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_raisedAlDa_time_i` (`time`),
  KEY `ccs_raisedAlDa_agentNa_agentDe_fk` (`agentName`),
  KEY `ccs_raisedAlDa_agentStId_agentSt_fk` (`agentStateId`),
  KEY `ccs_raisedAlDa_alertDeId_alertDe_fk` (`alertDescId`),
  KEY `ccs_raisedAlDa_clearingAlId_clearedAlDa_fk` (`clearingAlertId`),
  CONSTRAINT `ccs_raisedAlDa_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`),
  CONSTRAINT `ccs_raisedAlDa_agentStId_agentSt_fk` FOREIGN KEY (`agentStateId`) REFERENCES `ccs_agentState` (`id`),
  CONSTRAINT `ccs_raisedAlDa_alertDeId_alertDe_fk` FOREIGN KEY (`alertDescId`) REFERENCES `ccs_alertDesc` (`id`),
  CONSTRAINT `ccs_raisedAlDa_clearingAlId_clearedAlDa_fk` FOREIGN KEY (`clearingAlertId`) REFERENCES `ccs_clearedAlertData` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9220 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_rawData`
--

DROP TABLE IF EXISTS `ccs_rawData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_rawData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `doubleData` double DEFAULT NULL,
  `stringData` varchar(255) DEFAULT NULL,
  `time` bigint(20) NOT NULL,
  `dataDescId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`,`time`),
  KEY `ccs_rawDa_time_i` (`time`),
  KEY `ccs_rawDa_dataDeId_time_i` (`dataDescId`,`time`),
  CONSTRAINT `ccs_rawDa_dataDeId_dataDe_fk` FOREIGN KEY (`dataDescId`) REFERENCES `ccs_dataDesc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50441187 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_statData`
--

DROP TABLE IF EXISTS `ccs_statData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_statData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `average` double NOT NULL,
  `maxval` double DEFAULT NULL,
  `minval` double DEFAULT NULL,
  `n` int(11) NOT NULL,
  `sum2` double NOT NULL,
  `statDescId` bigint(20) DEFAULT NULL,
  `statTimeIntervalId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_statDa_statDeId_statTiInId_u` (`statDescId`,`statTimeIntervalId`),
  KEY `ccs_statDa_statTiInId_statTiIn_fk` (`statTimeIntervalId`),
  KEY `ccs_statDa_statDeId_statTiInId_i` (`statDescId`,`statTimeIntervalId`),
  CONSTRAINT `ccs_statDa_statDeId_statDe_fk` FOREIGN KEY (`statDescId`) REFERENCES `ccs_statDesc` (`id`),
  CONSTRAINT `ccs_statDa_statTiInId_statTiIn_fk` FOREIGN KEY (`statTimeIntervalId`) REFERENCES `ccs_statTimeInterval` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=475975 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_statDesc`
--

DROP TABLE IF EXISTS `ccs_statDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_statDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timeBinWidth` bigint(20) NOT NULL,
  `dataDescId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_statDe_dataDeId_timeBiWi_u` (`dataDescId`,`timeBinWidth`),
  KEY `ccs_statDe_dataDeId_i` (`dataDescId`),
  CONSTRAINT `ccs_statDe_dataDeId_dataDe_fk` FOREIGN KEY (`dataDescId`) REFERENCES `ccs_dataDesc` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1227 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_statTimeInterval`
--

DROP TABLE IF EXISTS `ccs_statTimeInterval`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_statTimeInterval` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `binWidth` bigint(20) NOT NULL,
  `startTime` bigint(20) NOT NULL,
  `endTime` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ccs_statTiIn_startTi_binWi_u` (`startTime`,`binWidth`),
  KEY `ccs_statTiIn_startTi_i` (`startTime`),
  KEY `ccs_statTiIn_binWi_i` (`binWidth`),
  KEY `ccs_statTiIn_binWi_startTi_i` (`binWidth`,`startTime`),
  KEY `ccs_statTiIn_endTi_i` (`endTime`)
) ENGINE=InnoDB AUTO_INCREMENT=71011 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_stateBundleDesc`
--

DROP TABLE IF EXISTS `ccs_stateBundleDesc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_stateBundleDesc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `hashMD5` varbinary(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_stateBundleDesc_componentStates_join`
--

DROP TABLE IF EXISTS `ccs_stateBundleDesc_componentStates_join`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_stateBundleDesc_componentStates_join` (
  `stateBundleDescId` bigint(20) NOT NULL,
  `componentStateId` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`stateBundleDescId`,`componentStateId`),
  KEY `ccs_stateBuDeStDe_componenStId_innerStDe_fk` (`componentStateId`),
  CONSTRAINT `ccs_stateBuDeStDe_stateBuDeId_stateBuDe_fk` FOREIGN KEY (`stateBundleDescId`) REFERENCES `ccs_stateBundleDesc` (`id`),
  CONSTRAINT `ccs_stateBundleDesc_componentStates_join_ibfk_1` FOREIGN KEY (`componentStateId`) REFERENCES `ccs_innerStateDesc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ccs_stateChangeNotificationData`
--

DROP TABLE IF EXISTS `ccs_stateChangeNotificationData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ccs_stateChangeNotificationData` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` bigint(20) NOT NULL,
  `agentName` varchar(255) NOT NULL,
  `agentStateId` bigint(20) NOT NULL,
  `oldStateId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ccs_stateChNoDa_agentNa_agentDe_fk` (`agentName`),
  KEY `ccs_stateChNoDa_agentStId_agentSt_fk` (`agentStateId`),
  KEY `ccs_stateChNoDa_oldStId_agentSt_fk` (`oldStateId`),
  CONSTRAINT `ccs_stateChNoDa_agentNa_agentDe_fk` FOREIGN KEY (`agentName`) REFERENCES `ccs_agentDesc` (`agentName`),
  CONSTRAINT `ccs_stateChNoDa_agentStId_agentSt_fk` FOREIGN KEY (`agentStateId`) REFERENCES `ccs_agentState` (`id`),
  CONSTRAINT `ccs_stateChNoDa_oldStId_agentSt_fk` FOREIGN KEY (`oldStateId`) REFERENCES `ccs_agentState` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-10-15 18:58:04

insert into ccs_enhanced_sequence values(1);
