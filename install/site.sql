-- MySQL dump 10.13  Distrib 5.5.53, for Win32 (AMD64)
--
-- Host: localhost    Database: site
-- ------------------------------------------------------
-- Server version	5.5.53

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
-- Table structure for table `wp_allot`
--

DROP TABLE IF EXISTS `wp_allot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_allot` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(18) NOT NULL,
  `order_id` mediumint(18) NOT NULL,
  `time` varchar(18) DEFAULT NULL,
  `my_fee` varchar(18) DEFAULT NULL COMMENT '变化的资金',
  `is_win` tinyint(1) DEFAULT NULL COMMENT '是否盈利1盈利2亏损3无效',
  `nowmoney` varchar(255) DEFAULT NULL COMMENT '此刻余额',
  `type` tinyint(1) DEFAULT '1' COMMENT '1红利结算2手续费结算',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_allot`
--

LOCK TABLES `wp_allot` WRITE;
/*!40000 ALTER TABLE `wp_allot` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_allot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_area`
--

DROP TABLE IF EXISTS `wp_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_area` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pid` smallint(5) NOT NULL DEFAULT '0',
  `code` char(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='地址表(省/市/县/区)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_area`
--

LOCK TABLES `wp_area` WRITE;
/*!40000 ALTER TABLE `wp_area` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_balance`
--

DROP TABLE IF EXISTS `wp_balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_balance` (
  `bpid` int(11) NOT NULL AUTO_INCREMENT,
  `bptype` varchar(10) DEFAULT NULL COMMENT '1充值 2加款 3正在充值 4取消 5提现 6减款',
  `bptime` int(20) DEFAULT NULL COMMENT '操作时间',
  `bpprice` decimal(16,2) DEFAULT NULL COMMENT '收支金额',
  `realprice` decimal(16,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '实际到账',
  `remarks` text COMMENT '备注',
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `isverified` int(11) NOT NULL DEFAULT '0' COMMENT ' 0 待审核 1通过  2是拒绝 3是审核中',
  `cltime` int(20) DEFAULT NULL COMMENT '审核时间',
  `bankid` int(8) DEFAULT NULL COMMENT '银行卡id,对应wp_bankinfo',
  `bpbalance` varchar(28) DEFAULT NULL COMMENT '充值/提现后的余额',
  `btime` varchar(18) DEFAULT NULL COMMENT '提交时间',
  `reg_par` varchar(10) DEFAULT '0' COMMENT '手续费',
  `balance_sn` varchar(32) DEFAULT NULL COMMENT '订单编号',
  `pay_type` varchar(20) DEFAULT NULL COMMENT '支付方式',
  `truename` varchar(255) NOT NULL DEFAULT '' COMMENT '存款人',
  `isshow` int(1) NOT NULL DEFAULT '1' COMMENT '是否显示订单',
  PRIMARY KEY (`bpid`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_balance`
--

LOCK TABLES `wp_balance` WRITE;
/*!40000 ALTER TABLE `wp_balance` DISABLE KEYS */;
INSERT INTO `wp_balance` VALUES (88,'2',1694252535,10000.00,0.00,'Successfully added funds to the system',1058649,1,1694252535,NULL,'19840.06',NULL,'0',NULL,NULL,'',1),(89,'6',1694252634,100.00,0.00,'System deduction successful',1058649,1,1694252634,NULL,'19740.06',NULL,'0',NULL,NULL,'',1),(90,'2',1694277089,123123.00,0.00,'Successfully added funds to the system',1058692,1,1694277089,NULL,'123123',NULL,'0',NULL,NULL,'',1),(91,'5',1694277164,123.00,121.77,'undefined',1058692,1,1694277547,7,'121980.00','1694277164','1.23',NULL,'bankinfo','',1);
/*!40000 ALTER TABLE `wp_balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_bankcard`
--

DROP TABLE IF EXISTS `wp_bankcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bankcard` (
  `id` mediumint(28) NOT NULL AUTO_INCREMENT,
  `bankno` mediumint(28) DEFAULT NULL COMMENT '总行代码',
  `accntnm` varchar(18) DEFAULT NULL COMMENT '持卡人姓名',
  `cityno` mediumint(18) DEFAULT NULL COMMENT '城市代码',
  `address` varchar(288) DEFAULT NULL COMMENT '地址',
  `uid` mediumint(18) DEFAULT NULL COMMENT '用户id',
  `accntno` varchar(38) DEFAULT NULL COMMENT '账号',
  `isdelete` tinyint(8) DEFAULT '0',
  `content` varchar(100) NOT NULL DEFAULT '',
  `phone` varchar(18) DEFAULT NULL,
  `scard` varchar(38) DEFAULT NULL COMMENT '身份证号码',
  `provinceid` mediumint(18) DEFAULT NULL COMMENT '省份id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_bankcard`
--

LOCK TABLES `wp_bankcard` WRITE;
/*!40000 ALTER TABLE `wp_bankcard` DISABLE KEYS */;
INSERT INTO `wp_bankcard` VALUES (26,NULL,'搜索',NULL,'啊实打实大苏打',1058649,'2061801533944525132',0,'啊大苏打撒旦',NULL,NULL,NULL);
/*!40000 ALTER TABLE `wp_bankcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_bankinfo`
--

DROP TABLE IF EXISTS `wp_bankinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_bankinfo` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '绑定',
  `name` varchar(20) NOT NULL COMMENT '币种',
  `address` varchar(255) NOT NULL COMMENT '省份',
  `qrcode` varchar(255) NOT NULL COMMENT '城市',
  `isdelete` tinyint(3) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_bankinfo`
--

LOCK TABLES `wp_bankinfo` WRITE;
/*!40000 ALTER TABLE `wp_bankinfo` DISABLE KEYS */;
INSERT INTO `wp_bankinfo` VALUES (6,1058649,'USDT','20 61 80 15 33 94 45 2 51 32','',0),(7,1058692,'USDT','123123123123123123123','',0);
/*!40000 ALTER TABLE `wp_bankinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_banks`
--

DROP TABLE IF EXISTS `wp_banks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_banks` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `bank_no` int(18) DEFAULT NULL,
  `bank_nm` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_banks`
--

LOCK TABLES `wp_banks` WRITE;
/*!40000 ALTER TABLE `wp_banks` DISABLE KEYS */;
INSERT INTO `wp_banks` VALUES (1,102,'中国工商银行'),(2,103,'中国农业银行'),(3,104,'中国银行'),(4,105,'中国建设银行'),(5,301,'交通银行'),(6,308,'招商银行'),(7,309,'兴业银行'),(8,305,'中国民生银行'),(9,306,'广东发展银行'),(10,307,'平安银行股份有限'),(11,310,'上海浦东发展银行'),(12,304,'华夏银行'),(13,313,'其他城市商业银行'),(14,1401,'邯郸市城市信用社'),(15,314,'其他农村商业银行'),(16,315,'恒丰银行'),(17,403,'中国邮政储蓄银行'),(18,303,'中国光大银行'),(19,302,'中信银行'),(20,316,'浙商银行股份有限'),(21,318,'渤海银行股份有限'),(22,423,'杭州市商业银行'),(23,412,'温州市商业银行'),(24,424,'南京市商业银行'),(25,461,'长沙市商业银行'),(26,409,'济南市商业银行'),(27,422,'石家庄市商业银行'),(28,458,'西宁市商业银行'),(29,404,'烟台市商业银行'),(30,462,'潍坊市商业银行'),(31,515,'德州市商业银行'),(32,431,'临沂市商业银行'),(33,481,'威海商业银行'),(34,497,'莱芜市商业银行'),(35,450,'青岛市商业银行'),(36,319,'徽商银行'),(37,322,'上海农村商业银行');
/*!40000 ALTER TABLE `wp_banks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_blacklist`
--

DROP TABLE IF EXISTS `wp_blacklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_blacklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ip` varchar(32) NOT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_blacklist`
--

LOCK TABLES `wp_blacklist` WRITE;
/*!40000 ALTER TABLE `wp_blacklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_blacklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_cardinfo`
--

DROP TABLE IF EXISTS `wp_cardinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_cardinfo` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) NOT NULL COMMENT '用户id',
  `id_type` int(1) DEFAULT NULL,
  `name` varchar(18) DEFAULT NULL COMMENT '身份证名字',
  `card_id` varchar(28) DEFAULT NULL COMMENT '身份证号',
  `front_pic` varchar(100) DEFAULT NULL COMMENT '身份证照片',
  `reverse_pic` varchar(88) DEFAULT NULL,
  `ctime` varchar(18) DEFAULT NULL,
  `is_check` int(1) DEFAULT '0' COMMENT '初级认证 0未认证1待审核2审核成功',
  `up_check` int(1) DEFAULT '0' COMMENT '高级认证 0未认证1待审核2审核成功',
  `utime` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_cardinfo`
--

LOCK TABLES `wp_cardinfo` WRITE;
/*!40000 ALTER TABLE `wp_cardinfo` DISABLE KEYS */;
INSERT INTO `wp_cardinfo` VALUES (16,1058649,0,'阿迪斯','123123123123123123','\\public\\uploads\\20230909\\20230909212609299.jpeg','\\public\\uploads\\20230909\\20230909212611300.jpeg','1694265951',2,2,'1694265973');
/*!40000 ALTER TABLE `wp_cardinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_catproduct`
--

DROP TABLE IF EXISTS `wp_catproduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_catproduct` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) DEFAULT NULL,
  `myat` double(11,1) DEFAULT '10.0' COMMENT '点差*',
  `myatjia` double(11,2) DEFAULT '0.00' COMMENT '点差+',
  `ask` double(11,2) DEFAULT '0.00' COMMENT '现在的价格',
  `high` double(11,2) DEFAULT '0.00' COMMENT '最高',
  `low` double(11,2) DEFAULT '0.00' COMMENT '最低',
  `open` double(11,2) DEFAULT '0.00' COMMENT '今开',
  `close` double(11,2) DEFAULT '0.00' COMMENT '昨收',
  `eidtime` int(20) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_catproduct`
--

LOCK TABLES `wp_catproduct` WRITE;
/*!40000 ALTER TABLE `wp_catproduct` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_catproduct` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_conf`
--

DROP TABLE IF EXISTS `wp_conf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_conf` (
  `id` mediumint(2) NOT NULL AUTO_INCREMENT,
  `webname` varchar(88) NOT NULL DEFAULT '软盟微交易系统' COMMENT '站点名称',
  `onelive` double(3,2) DEFAULT NULL COMMENT '一级分销',
  `twolive` double(3,2) DEFAULT NULL COMMENT '二级分销',
  `threelive` double(3,2) DEFAULT NULL COMMENT '三级分销',
  `pagenum` int(8) NOT NULL DEFAULT '20' COMMENT '后台分页',
  `closswebcon` text COMMENT '关闭网站说明',
  `webisopen` int(1) DEFAULT '1' COMMENT '是否关闭网站',
  `daygiveint` int(20) NOT NULL DEFAULT '0' COMMENT '每日签到赠送积分',
  `inttomoney` varchar(20) NOT NULL DEFAULT '1:1' COMMENT '积分与现金比例',
  `ordermin` decimal(20,2) NOT NULL DEFAULT '20.00' COMMENT '微交易单笔交易金额最小值限制',
  `ordermax` decimal(20,2) NOT NULL DEFAULT '5000.00' COMMENT '微交易单笔交易金额最大值限制',
  `cashmin` decimal(20,2) NOT NULL DEFAULT '100.00' COMMENT '单笔提现限制最小值',
  `cashmax` decimal(20,2) NOT NULL DEFAULT '1000.00' COMMENT '单笔提现限制最大值',
  `rechargemin` decimal(20,2) NOT NULL DEFAULT '20.00' COMMENT '单笔充值限制最小值',
  `rechargemax` decimal(20,2) NOT NULL DEFAULT '1000.00' COMMENT '单笔充值限制最大值',
  `usermaxrecharge` decimal(20,2) NOT NULL DEFAULT '1000.00' COMMENT '用户当天最大提现申请金额',
  `festivalisrec` tinyint(2) NOT NULL DEFAULT '0' COMMENT '非工作日是否支持提现',
  `userallhold` decimal(20,2) NOT NULL DEFAULT '2000.00' COMMENT '用户最大持仓金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_conf`
--

LOCK TABLES `wp_conf` WRITE;
/*!40000 ALTER TABLE `wp_conf` DISABLE KEYS */;
INSERT INTO `wp_conf` VALUES (1,'软盟微交易系统V2.0演示版',3.00,2.00,1.00,20,'网站升级维护中……',1,100,'100:1',20.00,1000.00,100.00,1000.00,20.00,1000.00,1000.00,0,2000.00);
/*!40000 ALTER TABLE `wp_conf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_config`
--

DROP TABLE IF EXISTS `wp_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_config`
--

LOCK TABLES `wp_config` WRITE;
/*!40000 ALTER TABLE `wp_config` DISABLE KEYS */;
INSERT INTO `wp_config` VALUES (1,'web_name',1,'网站名称',1,'','',1509027150,1509027150,1,'OKEX',1),(2,'is_close',1,'网站是否关闭',1,'0关闭，1开启','',1498580751,1498580751,0,'1',9),(3,'is_reg',5,'是否开放用户注册',2,'','',1498580857,1498580857,1,'1',1),(4,'web_poundage',1,'每笔平台收取手续费',2,'如：2%，就填写2即可','',1498580887,1498580887,1,'2',2),(5,'day_cash',1,'每日最多提现次数',2,'','',1499137504,1499137504,1,'5',12),(6,'live_num',1,'平台分销级数',2,'','',1498580962,1498580962,0,'5',4),(7,'pay_choose',1,'投资金额',2,'以 | 符号隔开','',1498581030,1498581030,1,'100|500|1000|5000|10000|50000|100000',5),(8,'order_min_price',1,'单笔最低下单金额',2,'','',1504767331,1504767331,1,'50',6),(9,'order_max_price',1,'单笔最高下单金额',2,'','',1504767338,1504767338,1,'100000000',7),(10,'reg_par',1,'每笔提现手续费',2,'输入百分比，如2%就输入2','',1499132509,1499132509,1,'2',8),(11,'cash_min',1,'最低提现金额',2,'','',1499132653,1499132653,1,'10',9),(12,'cash_max',1,'单笔提现最大金额',2,'','',1499132757,1499132757,1,'5000000',10),(13,'cash_day_max',1,'当日累计最高提现金额',2,'','',1499138112,1499138112,1,'100000000',11),(14,'is_cash',5,'是否开启提现',2,'','',1499138225,1499138225,1,'1',15),(15,'msm_SignName',1,'短信签名',1,'','',1499259617,1499259617,0,'中泰国际',3),(16,'msm_appkey',1,'短信key',1,'','',1499259639,1499259639,0,'短信宝用户名',4),(17,'msm_secretkey',1,'短信秘钥',1,'','',1499259659,1499259659,0,'短信宝密码',6),(18,'msm_TCode',1,'短信模板',1,'','',1499259682,1499259682,0,'',7),(19,'allot_point',1,'代理红利分配比例',2,'百分比，80%输入80。平仓后按照下单价格乘以此比例进行对冲 ','',1500304738,1500304738,0,'100',16),(20,'yongjin_point',1,'代理佣金分配比例',2,'百分比，10%输入10。平仓后按照下单价格乘以此比例为手续费奖励给代理团队','',1500304746,1500304746,0,'10',17),(21,'reg_type',1,'注册是否需要激活',2,'1不需激活2需要激活','',1502335131,1502335131,0,'1',21),(22,'kong_end',1,'订单受风控时间',2,'输入10-15，则订单在平仓之前10-15秒开始受到风控影响。','',1514738027,1514738027,1,'8-12',28),(23,'userpay_max',1,'单笔最大入金',2,'','',1504678164,1504678164,1,'10000000',28),(24,'userpay_min',1,'单笔最小入金',2,'','',1504678193,1504678193,1,'10',29),(25,'max_order_count',1,'最大持仓单数',2,'','',1504770831,1504770831,1,'10',7),(26,'web_logo',3,'LOGO',1,'PNG格式','',1506779011,1506779011,1,'/public/uploads/20230903/20230903182436701.jpeg',10),(27,'sys_kefu',1,'在线客服',1,'系统客服链接[--> /kefu/php/app.php?widget-mobile <--]','',1506779458,1506779458,1,'https://direct.lc.chat/15914826',8),(28,'reg_push',1,'充值金额',2,'用|隔开','',1506779553,1506779553,1,'100|500|1000|5000|10000|50000',30),(29,'can_kong',1,'可单控用户',3,'0009598,25,3,130','',1535033268,1535033268,1,'',40),(30,'role_ks',1,'开始提现时间',2,'在指定的时间段可以提现 例：9:00','',1553020924,1553020924,1,'09:00',0),(31,'role_js',1,'结束提现时间',2,'在指定的时间段可以提现 例：22:00','',1553021039,1553021039,1,'22:00',0),(33,'sys_limit',5,'超过警戒线是否平仓',2,'','',0,0,0,'0',0),(34,'sys_luhn_card',5,'银行卡号校验',2,'','',0,0,0,'0',0),(35,'sys_app_url',1,'APP链接URL',2,'','',0,0,0,'',41),(37,'sys_truename',5,'姓名注册开关',2,'','',0,0,0,'1',0),(38,'sys_mobile',5,'手机注册开关',2,'','',0,0,0,'0',0),(39,'sys_invit',5,'推荐码注册开关',2,'','',0,0,1,'0',0),(40,'sys_rates',5,'利息宝开关',2,'','',0,0,0,'1',0),(41,'sys_jifen',5,'积分开关',2,'','',0,0,0,'0',0),(42,'sys_pingcang',5,'手动平仓开关',2,'','',0,0,1,'0',0),(43,'sys_reg_caijin',1,'注册送彩金',2,'放空或0，即不送','',0,0,1,'5',0),(44,'sys_log_caijin',1,'每天首登送彩金',2,'放空或0，即不送','',0,0,0,'0',0),(45,'sys_homepage',1,'首页切换',2,'1或者2','',0,0,0,'2',0),(46,'sys_kefu_name',1,'客服名称',3,'客服名','',0,0,1,'小美',0),(47,'sys_kefu_img',3,'客服头像',3,'客服头像','',0,0,1,'\\public\\jpg\\kefu_img.png',0),(48,'sys_greeting',2,'客服问候',3,'客服问候','',0,0,1,'您好，请问有什么需要帮助的~~',0),(49,'sys_buy_once',5,'单一待结算订单',2,'仅能一笔待结算订单','',0,0,0,'0',0),(50,'sys_hide_yingkui',5,'隐藏止盈止损',2,'','',0,0,0,'1',0),(51,'sys_robot',1,'机器人赢利',2,'1显示 0隐藏','',0,0,0,'0',0),(52,'sys_yue_benjin',1,'利息宝本金',2,'1不冻结，可下注，不可提现 2本金冻结，不下注不提现','',0,0,0,'2',0),(53,'register_id',5,'身份证注册开关',2,'','',0,0,0,'1',0),(54,'whatsapp_kefu',1,'WhatsApp客服',1,'','',1506779458,1506779458,1,'',8),(57,'income_hidden',5,'收益率开关',2,'','',1506779458,1506779458,1,'0',8),(58,'iosapp',4,'IOS App',1,'Mobileconfig格式','',1506779011,1506779011,1,'',10),(59,'androidapp',4,'Android App',1,'Apk格式','',1506779011,1506779011,1,'',10),(60,'sendEmail',1,'发送邮箱账号',1,'填写发送邮箱账号','',1689676623,1689676623,1,'xiaozhangzhangdan@gmail.com',12),(61,'sendEmailPassWord',1,'邮箱专用密码',1,'填写邮箱专用密码','',1689676701,1689676701,1,'wdvbbnafdsivmpzu',12),(62,'sendEmailName',1,'邮箱团队名称',1,'填写邮箱团队名称','',1689676873,1689676873,1,'Crypot',12),(63,'sendSmsUser',1,'短信宝账号',1,'填写短信宝账号','',1689677777,1689677777,1,'kahhd654',11),(64,'sendSmsPassWord',1,'短信宝密钥',1,'填写短信宝密钥','',1689677815,1689677815,1,'c7f03ca45c7b4e7697ac73c77e7bf8f1',11),(65,'sendSmsContent',1,'短信宝模板',1,'填写短信宝模板','',1689695706,1689695706,1,'【Crypot】Your authentication code is {code}.',11),(66,'amount_name',1,'客户端金额标识',2,'修改站点金额标识符，例：USD','',1693810840,1693810840,1,'USD',0),(67,'amount_name_admin',1,'后台金额标识符',2,'填写后台金额标识符，例：$','',1693811272,1693811272,1,'$',0);
/*!40000 ALTER TABLE `wp_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_dt_productag0`
--

DROP TABLE IF EXISTS `wp_dt_productag0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_dt_productag0` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '0为波动数据，1为数据源',
  `pid` varchar(18) DEFAULT NULL,
  `name` varchar(18) DEFAULT NULL,
  `price` varchar(18) DEFAULT NULL COMMENT '现价',
  `open` varchar(18) DEFAULT NULL COMMENT '开盘',
  `close` varchar(18) DEFAULT NULL COMMENT '收盘',
  `high` varchar(18) DEFAULT NULL COMMENT '最高',
  `low` varchar(18) DEFAULT NULL COMMENT '最低',
  `diff` varchar(18) DEFAULT NULL COMMENT '振幅',
  `diffrate` varchar(18) DEFAULT NULL COMMENT '波幅',
  `updatetime` varchar(18) DEFAULT NULL,
  `rands` varchar(8) DEFAULT NULL,
  `point` varchar(8) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='白银数据源';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_dt_productag0`
--

LOCK TABLES `wp_dt_productag0` WRITE;
/*!40000 ALTER TABLE `wp_dt_productag0` DISABLE KEYS */;
INSERT INTO `wp_dt_productag0` VALUES (1,1,'23','白银',NULL,'3730.00','3712.00','3739.00','3725.00',NULL,NULL,'1526978686',NULL,NULL,0);
/*!40000 ALTER TABLE `wp_dt_productag0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_gallery`
--

DROP TABLE IF EXISTS `wp_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_gallery` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '标题',
  `img` varchar(64) NOT NULL DEFAULT '' COMMENT '图片',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1显示 0隐藏',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='轮播图';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_gallery`
--

LOCK TABLES `wp_gallery` WRITE;
/*!40000 ALTER TABLE `wp_gallery` DISABLE KEYS */;
INSERT INTO `wp_gallery` VALUES (1,'1','/public/uploads/20230320/d52b3b4d96c3ff3c5ba07db61ec5ae4e.jpg',1,1),(2,'2','/public/uploads/20230320/13dbe414b56938ba1756077d168da765.jpg',1,2),(3,'3','/public/uploads/20230320/66d195c08cb416209f4c32c7824d160c.jpg',1,3),(11,'1','/public/uploads/20230328/66f55dabd04f173ca5e9a3234faa44aa.jpg',1,0);
/*!40000 ALTER TABLE `wp_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_integral`
--

DROP TABLE IF EXISTS `wp_integral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_integral` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `type` int(1) DEFAULT '0' COMMENT '0购买1签到2注册',
  `amount` int(8) DEFAULT '0' COMMENT '数量',
  `time` int(18) DEFAULT NULL COMMENT '时间',
  `uid` mediumint(8) DEFAULT NULL COMMENT '用户id',
  `oid` mediumint(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_integral`
--

LOCK TABLES `wp_integral` WRITE;
/*!40000 ALTER TABLE `wp_integral` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_integral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_invest`
--

DROP TABLE IF EXISTS `wp_invest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_invest` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `days` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '期限 天',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1分红  2百分比',
  `rates` decimal(5,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分红 或 利率',
  `min` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '起投金额',
  `max` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最大可投',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1启用',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `proid` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8 COMMENT='利息宝';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_invest`
--

LOCK TABLES `wp_invest` WRITE;
/*!40000 ALTER TABLE `wp_invest` DISABLE KEYS */;
INSERT INTO `wp_invest` VALUES (1002,7,2,14.00,100,0,1,0,38),(1003,14,2,42.00,1000,0,1,0,38),(1004,30,2,120.00,5000,0,1,0,38),(1005,45,2,225.00,10000,0,1,0,38),(1006,60,2,360.00,50000,0,1,0,38),(1007,90,2,630.00,100000,0,1,0,38);
/*!40000 ALTER TABLE `wp_invest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_klinedata`
--

DROP TABLE IF EXISTS `wp_klinedata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_klinedata` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `ktime` varchar(18) NOT NULL COMMENT 'k线时间',
  `updata` varchar(18) DEFAULT NULL COMMENT '最高值',
  `downdata` varchar(18) DEFAULT NULL COMMENT '最低值',
  `pid` mediumint(18) NOT NULL COMMENT '产品id',
  `opendata` varchar(18) DEFAULT NULL COMMENT '开盘价格',
  `closdata` varchar(18) DEFAULT NULL COMMENT '关盘价格',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_klinedata`
--

LOCK TABLES `wp_klinedata` WRITE;
/*!40000 ALTER TABLE `wp_klinedata` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_klinedata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_log`
--

DROP TABLE IF EXISTS `wp_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `loguser` varchar(50) DEFAULT NULL COMMENT '登录tel',
  `logname` varchar(50) DEFAULT NULL COMMENT '登录名',
  `otype` int(10) DEFAULT NULL COMMENT '用户类型',
  `geoip` varchar(15) DEFAULT NULL COMMENT 'IP地址',
  `type` int(1) DEFAULT NULL COMMENT '0登录失败 \r\n1登录成功\r\n2异常登录\r\n3修改登录密码\r\n4修改提现密码',
  `action` varchar(255) DEFAULT NULL COMMENT '操作',
  `useragent` varchar(255) DEFAULT NULL COMMENT 'user-agent',
  `content` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_at` int(10) DEFAULT NULL COMMENT '登录时间',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `online` int(10) DEFAULT NULL,
  `session_id` varchar(50) DEFAULT NULL,
  `token` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_log`
--

LOCK TABLES `wp_log` WRITE;
/*!40000 ALTER TABLE `wp_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_newsclass`
--

DROP TABLE IF EXISTS `wp_newsclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_newsclass` (
  `fid` int(11) NOT NULL AUTO_INCREMENT,
  `fclass` varchar(255) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_newsclass`
--

LOCK TABLES `wp_newsclass` WRITE;
/*!40000 ALTER TABLE `wp_newsclass` DISABLE KEYS */;
INSERT INTO `wp_newsclass` VALUES (1,'最新资讯',0),(2,'财经要闻',0),(3,'系统公告',1),(4,'时政新闻',1);
/*!40000 ALTER TABLE `wp_newsclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_newsinfo`
--

DROP TABLE IF EXISTS `wp_newsinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_newsinfo` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `ntitle` varchar(255) DEFAULT NULL COMMENT '标题',
  `ncontent` text COMMENT '内容',
  `ncover` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `fid` int(11) DEFAULT NULL COMMENT '新闻分类id',
  `ntime` int(20) DEFAULT NULL COMMENT '发布时间',
  `nauthor` varchar(18) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_newsinfo`
--

LOCK TABLES `wp_newsinfo` WRITE;
/*!40000 ALTER TABLE `wp_newsinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_newsinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_notice`
--

DROP TABLE IF EXISTS `wp_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1启用 0停用',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='公告';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_notice`
--

LOCK TABLES `wp_notice` WRITE;
/*!40000 ALTER TABLE `wp_notice` DISABLE KEYS */;
INSERT INTO `wp_notice` VALUES (6,'OKEX Thông báo !','OKEX là một sàn giao dịch tiền mã hóa sáng tạo với các dịch vụ tài chính tiên tiến. Chúng tôi dựa vào công nghệ blockchain để cung cấp mọi thứ bạn cần để giao dịch và đầu tư khôn ngoan.Hãy trải nghiệm hàng trăm token và cặp giao dịch. Với OKEX, bạn có thể tham gia vào một trong những sàn giao dịch tiền mã hóa hàng đầu về khối lượng giao dịch. Chúng tôi cung cấp dich vụ cho hàng triệu người dùng tại hơn 100 quốc gia, trong đó bao gồm dịch vụ giao dịch giao ngay, ký quỹ, hợp đồng tương lai, quyền chọn, hoán đổi vĩnh cửu, DeFi, cho vay và khai thác.',1,1679070397);
/*!40000 ALTER TABLE `wp_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_opentime`
--

DROP TABLE IF EXISTS `wp_opentime`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_opentime` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `pid` mediumint(18) NOT NULL,
  `opentime` varchar(888) DEFAULT NULL COMMENT '开市时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_opentime`
--

LOCK TABLES `wp_opentime` WRITE;
/*!40000 ALTER TABLE `wp_opentime` DISABLE KEYS */;
INSERT INTO `wp_opentime` VALUES (49,56,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-'),(51,59,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(52,14,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-'),(53,23,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(54,57,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(55,58,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(56,15,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(57,38,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(58,11,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(59,29,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(60,31,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(61,35,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(62,41,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(63,39,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(64,12,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(65,16,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(66,45,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(67,34,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(68,36,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(69,32,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(70,42,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(71,13,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(72,17,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(73,22,'00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00-00:00~24:00---'),(74,0,'00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-00:00-24:00|07:00-24:00-');
/*!40000 ALTER TABLE `wp_opentime` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_order`
--

DROP TABLE IF EXISTS `wp_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_order` (
  `oid` int(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '下单用户uid',
  `pid` int(11) NOT NULL COMMENT '产品ID',
  `ostyle` int(12) NOT NULL DEFAULT '0' COMMENT '0涨 1跌，',
  `buytime` int(20) DEFAULT NULL COMMENT '建仓',
  `onumber` int(20) DEFAULT NULL COMMENT '手数',
  `selltime` int(20) DEFAULT '0' COMMENT '平仓',
  `ostaus` int(11) DEFAULT NULL COMMENT '0交易，1平仓',
  `buyprice` decimal(16,3) NOT NULL COMMENT '入仓价',
  `sellprice` decimal(16,3) NOT NULL DEFAULT '0.000' COMMENT '平仓价',
  `endprofit` varchar(20) DEFAULT '0' COMMENT '点数/分钟数',
  `endloss` varchar(11) DEFAULT '0' COMMENT '盈亏比例',
  `point` decimal(10,5) unsigned NOT NULL DEFAULT '0.00000' COMMENT '指数变化/盈亏1%',
  `fee` decimal(12,1) DEFAULT NULL COMMENT '总费用',
  `eid` decimal(12,2) NOT NULL COMMENT '1点位、2时间',
  `orderno` varchar(32) DEFAULT NULL COMMENT '订单编号',
  `ptitle` varchar(20) DEFAULT NULL COMMENT '商品名称',
  `commission` decimal(12,1) DEFAULT '0.0' COMMENT '佣金',
  `ploss` decimal(16,2) DEFAULT '0.00' COMMENT '盈亏',
  `display` int(11) DEFAULT '0' COMMENT '0,可查询，1不可查询',
  `isshow` int(1) DEFAULT '0',
  `is_win` tinyint(1) DEFAULT NULL COMMENT '是否盈利1盈利2亏损3无效',
  `kong_type` tinyint(1) DEFAULT '0' COMMENT '0不空1盈利2亏损',
  `sx_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '手续费',
  PRIMARY KEY (`oid`),
  KEY `uidd` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=1539 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_order`
--

LOCK TABLES `wp_order` WRITE;
/*!40000 ALTER TABLE `wp_order` DISABLE KEYS */;
INSERT INTO `wp_order` VALUES (1535,1058649,14,1,1694240004,NULL,1694240184,1,1943.709,1943.592,'20,30','50,100',0.00800,100.0,2.00,'202309091413248653','XAU/USD',9840.1,96.75,0,0,1,1,2.00),(1536,1058692,14,0,1694277110,NULL,1694277290,1,1943.709,1943.652,'20,30','10,20',0.00800,1000.0,2.00,'202309100031501961','XAU/USD',122103.0,-252.59,0,0,2,2,20.00),(1537,1058649,14,0,1694278422,NULL,1694278602,1,1918.386,1918.342,'20,30','10,20',0.00800,1000.0,2.00,'202309100053429697','XAU/USD',18816.8,-248.13,0,0,2,2,20.00),(1538,1058649,14,1,1694278467,NULL,1694278647,1,1918.386,1918.286,'20,30','10,20',0.00800,1000.0,2.00,'202309100054272676','XAU/USD',17796.8,197.03,0,0,1,1,20.00);
/*!40000 ALTER TABLE `wp_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_order_log`
--

DROP TABLE IF EXISTS `wp_order_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_order_log` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(8) DEFAULT NULL,
  `oid` mediumint(8) DEFAULT NULL,
  `addprice` decimal(10,2) DEFAULT NULL,
  `addpoint` decimal(10,2) DEFAULT NULL,
  `time` int(10) DEFAULT NULL,
  `user_money` decimal(20,2) DEFAULT NULL,
  `is_delete` int(2) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1530 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_order_log`
--

LOCK TABLES `wp_order_log` WRITE;
/*!40000 ALTER TABLE `wp_order_log` DISABLE KEYS */;
INSERT INTO `wp_order_log` VALUES (1526,1058649,1535,196.75,0.00,1694278010,19836.81,0),(1527,1058692,1536,747.41,0.00,1694278010,122727.41,0),(1528,1058649,1537,751.87,0.00,1694278650,18548.68,0),(1529,1058649,1538,1197.03,0.00,1694278650,19745.71,0);
/*!40000 ALTER TABLE `wp_order_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_payment`
--

DROP TABLE IF EXISTS `wp_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_payment` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `pay_name` varchar(288) NOT NULL COMMENT '支付名称',
  `is_use` tinyint(1) NOT NULL COMMENT '是否使用1使用0不使用',
  `pay_point` varchar(8) NOT NULL COMMENT '手续费',
  `pay_conf` text NOT NULL COMMENT '配置信息',
  `isdelete` tinyint(1) DEFAULT NULL COMMENT '是否删除1删除0未删除',
  `dotime` varchar(18) NOT NULL COMMENT '操作时间',
  `pay_order` int(8) DEFAULT NULL COMMENT '排序，数组越大越靠前显示',
  `thumb` varchar(100) NOT NULL DEFAULT '' COMMENT '图片，二维码',
  `account_no` text NOT NULL COMMENT '账号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_payment`
--

LOCK TABLES `wp_payment` WRITE;
/*!40000 ALTER TABLE `wp_payment` DISABLE KEYS */;
INSERT INTO `wp_payment` VALUES (5,'银行卡',1,'0','Chuyển khoản nội địa',0,'1694274192',NULL,'','BankEximbank NameNGUYEN THANH TINH STK 0815608543\r\n'),(6,'USDT充值',1,'0','mcb_usdtpay',1,'1693737206',NULL,'',''),(7,'在线充值',0,'0','mcb_visapay',0,'1681401444',NULL,'','');
/*!40000 ALTER TABLE `wp_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_payorder`
--

DROP TABLE IF EXISTS `wp_payorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_payorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `uuid` int(11) NOT NULL DEFAULT '0' COMMENT '后台所属渠道商id',
  `money` decimal(10,2) DEFAULT NULL COMMENT '金额',
  `cost` decimal(10,2) DEFAULT NULL COMMENT '手续费2%',
  `istype` int(11) DEFAULT NULL COMMENT '10001表示支付宝，20001表示微信',
  `orderid` varchar(255) DEFAULT NULL COMMENT '订单号',
  `goodsname` varchar(255) DEFAULT NULL COMMENT '订单名称',
  `pay_type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '支付状态：1表示未支付，2表示已经支付',
  `opid` tinyint(3) DEFAULT NULL COMMENT '操作员id(1熊，2周，3董，4李)',
  `ctime` varchar(12) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='支付订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_payorder`
--

LOCK TABLES `wp_payorder` WRITE;
/*!40000 ALTER TABLE `wp_payorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_payorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_price_log`
--

DROP TABLE IF EXISTS `wp_price_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_price_log` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `uid` mediumint(18) DEFAULT NULL,
  `oid` mediumint(18) DEFAULT NULL COMMENT '订单id',
  `type` tinyint(1) DEFAULT NULL COMMENT '1增加2减少',
  `account` varchar(18) DEFAULT NULL COMMENT '变动金额',
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `content` varchar(255) DEFAULT NULL COMMENT '说明',
  `time` varchar(18) DEFAULT NULL COMMENT '时间',
  `nowmoney` varchar(18) DEFAULT NULL COMMENT '此刻余额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3727 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_price_log`
--

LOCK TABLES `wp_price_log` WRITE;
/*!40000 ALTER TABLE `wp_price_log` DISABLE KEYS */;
INSERT INTO `wp_price_log` VALUES (3300,1058649,1375,2,'100','下单','下单成功','1689482409','9003.84'),(3301,1058649,1375,1,'112.64','结单','订单到期获利结算','1689482590','9116.48'),(3302,1058649,1376,2,'100','下单','下单成功','1689482641','9016.48'),(3303,1058649,1376,1,'83.05','结单','订单到期获利结算','1689482821','9099.53'),(3304,1058649,1377,2,'100','下单','下单成功','1689561014','8999.53'),(3305,1058649,1377,1,'118.6','结单','订单到期获利结算','1689561245','9118.13'),(3306,1058649,1,2,'1000','提现','提现申请','1689592049','8118.13'),(3307,1058649,1378,2,'5000','下单','下单成功','1689609556','3118.13'),(3308,1058649,1378,1,'5736.99','结单','订单到期获利结算','1689609868','8855.12'),(3309,1058649,2,2,'100','提现','提现申请','1689616072','8755.12'),(3310,1058649,3,2,'100','提现','提现申请','1689616143','8655.12'),(3311,1058649,3,1,'100.00','提现','拒绝申请：','1689616179','8755.12'),(3312,1058649,2,1,'100.00','提现','拒绝申请：','1689616184','8855.12'),(3313,1058649,1,1,'1000.00','提现','拒绝申请：','1689616189','9855.12'),(3314,1058649,1379,2,'1000','下单','下单成功','1693720663','8855.12'),(3315,1058649,1379,1,'1186.94','结单','订单到期获利结算','1693720846','10042.06'),(3316,1058655,7,1,'1000','充值','后台加款','1693738640','1000'),(3317,1058655,6,1,'100.00','充值','会员充值','1693738648','1000.00'),(3318,1058653,5,1,'500.00','充值','会员充值','1693738656','0.00'),(3319,1058656,8,1,'1000','充值','后台加款','1693738678','1000'),(3320,1058653,5,1,'500.00','充值','会员充值','1693738687','500.00'),(3321,1058655,6,1,'100.00','充值','会员充值','1693738689','1100.00'),(3322,1058655,9,1,'20000.00','充值','会员充值','1693738724','1000.00'),(3323,1058655,1380,2,'5000','下单','下单成功','1693738773','16000'),(3324,1058655,1381,2,'10000','下单','下单成功','1693738946','6000'),(3325,1058655,1380,1,'9120.12','结单','订单到期获利结算','1693738954','15120.12'),(3326,1058655,1381,1,'16577.93','结单','订单到期获利结算','1693739128','31698.05'),(3327,1058655,1382,2,'5000','下单','下单成功','1693739323','26698.05'),(3328,1058655,1,2,'26698','利息宝','投资','1693739456','26698.05'),(3329,1058655,1382,1,'9763.76','结单','订单到期获利结算','1693739506','9763.81'),(3330,1058655,1383,2,'1000','下单','下单成功','1693739847','8763.81'),(3331,1058655,1383,1,'777.48','结单','订单到期获利结算','1693740028','9541.29'),(3332,1058660,11,1,'1000.00','充值','会员充值','1693741609','0.00'),(3333,1058649,3,1,'100.00','提现','通过申请：','1693741626','9942.06'),(3334,1058680,21,1,'20000.00','充值','会员充值','1693741784','0.00'),(3335,1058671,20,1,'1000.00','充值','会员充值','1693741788','0.00'),(3336,1058664,19,1,'1000.00','充值','会员充值','1693741791','0.00'),(3337,1058677,18,1,'10000.00','充值','会员充值','1693741794','0.00'),(3338,1058670,23,1,'10000.00','充值','会员充值','1693741798','0.00'),(3339,1058676,22,1,'10000.00','充值','会员充值','1693741801','0.00'),(3340,1058675,17,1,'5000.00','充值','会员充值','1693741804','0.00'),(3341,1058664,16,1,'1000.00','充值','会员充值','1693741807','1000.00'),(3342,1058677,15,1,'20000.00','充值','会员充值','1693741811','10000.00'),(3343,1058666,14,1,'10000.00','充值','会员充值','1693741814','0.00'),(3344,1058682,24,1,'20000.00','充值','会员充值','1693741827','0.00'),(3345,1058683,25,1,'20000.00','充值','会员充值','1693741843','0.00'),(3346,1058674,26,1,'1000.00','充值','会员充值','1693741848','0.00'),(3347,1058669,28,1,'1000.00','充值','会员充值','1693741853','0.00'),(3348,1058674,29,1,'1000.00','充值','会员充值','1693741857','1000.00'),(3349,1058683,27,1,'20000.00','充值','会员充值','1693741860','20000.00'),(3350,1058663,13,1,'10000.00','充值','会员充值','1693741875','0.00'),(3351,1058663,12,1,'10000.00','充值','会员充值','1693741882','10000.00'),(3352,1058660,10,1,'1000.00','充值','会员充值','1693741886','1000.00'),(3353,1058668,30,1,'20000.00','充值','会员充值','1693741897','0.00'),(3354,1058658,31,1,'20000.00','充值','会员充值','1693741930','0.00'),(3355,1058669,32,1,'10000.00','充值','会员充值','1693741937','1000.00'),(3356,1058666,1384,2,'1000','下单','下单成功','1693741942','9000'),(3357,1058672,34,1,'1000.00','充值','会员充值','1693741966','0.00'),(3358,1058673,33,1,'5000.00','充值','会员充值','1693741970','0.00'),(3359,1058675,2,2,'200','利息宝','投资','1693741978','5000.00'),(3360,1058675,3,2,'200','利息宝','投资','1693741979','4800.00'),(3361,1058678,35,1,'20000.00','充值','会员充值','1693741986','0.00'),(3362,1058684,37,1,'10000.00','充值','会员充值','1693741991','0.00'),(3363,1058667,36,1,'1000.00','充值','会员充值','1693741995','0.00'),(3364,1058657,40,1,'10000.00','充值','会员充值','1693742010','0.00'),(3365,1058679,39,1,'20000.00','充值','会员充值','1693742014','0.00'),(3366,1058672,38,1,'1000.00','充值','会员充值','1693742018','1000.00'),(3367,1058666,1384,1,'1976.79','结单','订单到期获利结算','1693742122','10976.79'),(3368,1058660,1385,2,'1000','下单','下单成功','1693742146','1000'),(3369,1058676,1386,2,'1000','下单','下单成功','1693742161','9000'),(3370,1058662,41,1,'10000.00','充值','会员充值','1693742224','0.00'),(3371,1058663,1387,2,'20000','下单','下单成功','1693742248','0'),(3372,1058675,1388,2,'100','下单','下单成功','1693742279','4500'),(3373,1058671,42,2,'1000.00','提现','提现申请','1693742342','0.00'),(3374,1058676,1386,1,'1646.69','结单','订单到期获利结算','1693742343','10646.69'),(3375,1058680,1389,2,'100','下单','下单成功','1693742385','19900'),(3376,1058674,1390,2,'100','下单','下单成功','1693742402','1900'),(3377,1058660,43,2,'1000','提现','提现申请','1693742410','0.00'),(3378,1058675,1391,2,'300','下单','下单成功','1693742411','4200'),(3379,1058677,1392,2,'100','下单','下单成功','1693742419','29900'),(3380,1058663,1387,1,'14933.2','结单','订单到期获利结算','1693742431','14933.20'),(3381,1058662,1393,2,'1000','下单','下单成功','1693742433','9000'),(3382,1058672,1394,2,'1000','下单','下单成功','1693742446','1000'),(3383,1058660,1385,1,'1194.61','结单','订单到期获利结算','1693742446','1194.61'),(3384,1058664,1395,2,'100','下单','下单成功','1693742446','1900'),(3385,1058675,1388,1,'159.95','结单','订单到期获利结算','1693742461','4359.95'),(3386,1058673,1396,2,'1000','下单','下单成功','1693742473','4000'),(3387,1058684,1397,2,'1000','下单','下单成功','1693742484','9000'),(3388,1058680,1398,2,'1000','下单','下单成功','1693742490','18900'),(3389,1058675,1399,2,'300','下单','下单成功','1693742499','4059.95'),(3390,1058671,45,1,'1000.00','充值','会员充值','1693742532','0.00'),(3391,1058659,44,1,'10000.00','充值','会员充值','1693742536','0.00'),(3392,1058667,1400,2,'100','下单','下单成功','1693742541','900'),(3393,1058670,1401,2,'1000','下单','下单成功','1693742545','9000'),(3394,1058682,1402,2,'1000','下单','下单成功','1693742546','19000'),(3395,1058668,1403,2,'1000','下单','下单成功','1693742554','19000'),(3396,1058680,1389,1,'73.28','结单','订单到期获利结算','1693742565','18973.28'),(3397,1058671,1404,2,'100','下单','下单成功','1693742570','900'),(3398,1058674,1390,1,'76.12','结单','订单到期获利结算','1693742583','1976.12'),(3399,1058675,1391,1,'214.89','结单','订单到期获利结算','1693742593','4274.84'),(3400,1058659,1405,2,'1000','下单','下单成功','1693742597','9000'),(3401,1058677,1392,1,'75.93','结单','订单到期获利结算','1693742599','29975.93'),(3402,1058663,46,2,'2000','提现','提现申请','1693742601','12933.20'),(3403,1058662,1393,1,'1698.2','结单','订单到期获利结算','1693742614','10698.20'),(3404,1058672,1394,1,'737.64','结单','订单到期获利结算','1693742626','1737.64'),(3405,1058664,1395,1,'79.74','结单','订单到期获利结算','1693742626','1979.74'),(3406,1058658,1406,2,'20000','下单','下单成功','1693742647','0'),(3407,1058680,1407,2,'5000','下单','下单成功','1693742648','13973.28'),(3408,1058675,1408,2,'1000','下单','下单成功','1693742656','3274.84'),(3409,1058673,1396,1,'737.14','结单','订单到期获利结算','1693742656','4737.14'),(3410,1058669,1409,2,'5000','下单','下单成功','1693742663','6000'),(3411,1058684,1397,1,'737.11','结单','订单到期获利结算','1693742665','9737.11'),(3412,1058680,1398,1,'722.75','结单','订单到期获利结算','1693742671','14696.03'),(3413,1058675,1399,1,'216.11','结单','订单到期获利结算','1693742680','3490.95'),(3414,1058678,1410,2,'20000','下单','下单成功','1693742681','0'),(3415,1058675,1411,2,'2000','下单','下单成功','1693742690','1490.95'),(3416,1058664,1412,2,'1000','下单','下单成功','1693742700','979.74'),(3417,1058667,1400,1,'76.58','结单','订单到期获利结算','1693742721','976.58'),(3418,1058670,1401,1,'779.66','结单','订单到期获利结算','1693742725','9779.66'),(3419,1058682,1402,1,'749.71','结单','订单到期获利结算','1693742727','19749.71'),(3420,1058668,1403,1,'703.21','结单','订单到期获利结算','1693742736','19703.21'),(3421,1058662,1413,2,'100','下单','下单成功','1693742747','10598.2'),(3422,1058671,1404,1,'73.02','结单','订单到期获利结算','1693742751','973.02'),(3423,1058659,1405,1,'756.97','结单','订单到期获利结算','1693742779','9756.97'),(3424,1058684,1414,2,'1000','下单','下单成功','1693742818','8737.11'),(3425,1058658,1406,1,'14919.27','结单','订单到期获利结算','1693742827','14919.27'),(3426,1058680,1407,1,'3740.11','结单','订单到期获利结算','1693742829','18436.14'),(3427,1058677,1415,2,'1000','下单','下单成功','1693742830','28975.93'),(3428,1058667,1416,2,'900','下单','下单成功','1693742830','76.58'),(3429,1058675,1408,1,'713.64','结单','订单到期获利结算','1693742839','2204.59'),(3430,1058669,1409,1,'3876.59','结单','订单到期获利结算','1693742845','9876.59'),(3431,1058663,1417,2,'1000','下单','下单成功','1693742856','11933.2'),(3432,1058678,1410,1,'14996.79','结单','订单到期获利结算','1693742862','14996.79'),(3433,1058671,1418,2,'100','下单','下单成功','1693742864','873.02'),(3434,1058675,1411,1,'1436.07','结单','订单到期获利结算','1693742872','3640.66'),(3435,1058664,1412,1,'716.6','结单','订单到期获利结算','1693742880','1696.34'),(3436,1058676,47,2,'1000','提现','提现申请','1693742881','9646.69'),(3437,1058659,48,2,'2000','提现','提现申请','1693742885','7756.97'),(3438,1058682,1419,2,'5000','下单','下单成功','1693742899','14749.71'),(3439,1058675,1420,2,'3500','下单','下单成功','1693742924','140.66'),(3440,1058670,1421,2,'1000','下单','下单成功','1693742928','8779.66'),(3441,1058662,1413,1,'159.8','结单','订单到期获利结算','1693742929','10758.00'),(3442,1058673,1422,2,'1000','下单','下单成功','1693742934','3737.14'),(3443,1058678,1423,2,'14996.79','下单','下单成功','1693742940','0'),(3444,1058657,1424,2,'300','下单','下单成功','1693742944','9700'),(3445,1058660,1425,2,'1000','下单','下单成功','1693742947','194.61'),(3446,1058658,1426,2,'10000','下单','下单成功','1693742960','4919.27'),(3447,1058684,1414,1,'1742.09','结单','订单到期获利结算','1693743001','10479.20'),(3448,1058677,1415,1,'1659.75','结单','订单到期获利结算','1693743013','30635.68'),(3449,1058667,1416,1,'1533.07','结单','订单到期获利结算','1693743013','1609.65'),(3450,1058673,1427,2,'1000','下单','下单成功','1693743032','2737.14'),(3451,1058677,1428,2,'1000','下单','下单成功','1693743036','29635.68'),(3452,1058663,1417,1,'1503.67','结单','订单到期获利结算','1693743037','13436.87'),(3453,1058671,1418,1,'165.95','结单','订单到期获利结算','1693743045','1038.97'),(3454,1058664,49,2,'1696','提现','提现申请','1693743050','0.34'),(3455,1058682,1419,1,'9649.14','结单','订单到期获利结算','1693743079','24398.85'),(3456,1058675,1420,1,'5519.51','结单','订单到期获利结算','1693743106','5660.17'),(3457,1058670,1421,1,'1644.42','结单','订单到期获利结算','1693743108','10424.08'),(3458,1058673,1422,1,'1844.57','结单','订单到期获利结算','1693743114','4581.71'),(3459,1058678,1423,1,'27155.2','结单','订单到期获利结算','1693743120','27155.20'),(3460,1058666,50,2,'1000','提现','提现申请','1693743121','9976.79'),(3461,1058657,1424,1,'453.4','结单','订单到期获利结算','1693743128','10153.40'),(3462,1058658,1426,1,'19926.1','结单','订单到期获利结算','1693743142','24845.37'),(3463,1058663,1429,2,'13436.87','下单','下单成功','1693743144','0'),(3464,1058677,51,2,'1000','提现','提现申请','1693743165','28635.68'),(3465,1058666,1430,2,'1000','下单','下单成功','1693743174','8976.79'),(3466,1058684,1431,2,'5000','下单','下单成功','1693743178','5479.2'),(3467,1058679,1432,2,'10000','下单','下单成功','1693743190','10000'),(3468,1058678,1433,2,'27155.2','下单','下单成功','1693743193','0'),(3469,1058673,1427,1,'1828.72','结单','订单到期获利结算','1693743213','6410.43'),(3470,1058677,1428,1,'1767.72','结单','订单到期获利结算','1693743217','30403.40'),(3471,1058660,1425,1,'1107.06','结单','订单到期获利结算','1693743250','1301.67'),(3472,1058675,1434,2,'5000','下单','下单成功','1693743298','660.17'),(3473,1058686,52,1,'10000.00','充值','会员充值','1693743318','0.00'),(3474,1058671,1435,2,'300','下单','下单成功','1693743318','738.97'),(3475,1058686,53,2,'5000','提现','提现申请','1693743321','5000.00'),(3476,1058663,1429,1,'21719.87','结单','订单到期获利结算','1693743325','21719.87'),(3477,1058660,1436,2,'1000','下单','下单成功','1693743328','301.67'),(3478,1058666,1430,1,'1536.99','结单','订单到期获利结算','1693743354','10513.78'),(3479,1058684,1431,1,'7709.56','结单','订单到期获利结算','1693743358','13188.76'),(3480,1058682,1437,2,'5000','下单','下单成功','1693743367','19398.85'),(3481,1058679,1432,1,'18620.91','结单','订单到期获利结算','1693743370','28620.91'),(3482,1058678,1433,1,'44367.33','结单','订单到期获利结算','1693743377','44367.33'),(3483,1058663,1438,2,'21719.87','下单','下单成功','1693743424','0'),(3484,1058680,1439,2,'10000','下单','下单成功','1693743429','8436.14'),(3485,1058657,54,2,'153','提现','提现申请','1693743459','10000.40'),(3486,1058675,1434,1,'9480.3','结单','订单到期获利结算','1693743481','10140.47'),(3487,1058678,58,2,'500','提现','提现申请','1693743491','43867.33'),(3488,1058671,1435,1,'585.3','结单','订单到期获利结算','1693743498','1324.27'),(3489,1058662,59,2,'1000','提现','提现申请','1693743509','9758.00'),(3490,1058662,60,2,'1000','提现','提现申请','1693743510','8758.00'),(3491,1058662,61,2,'1000','提现','提现申请','1693743510','7758.00'),(3492,1058660,1436,1,'1875.86','结单','订单到期获利结算','1693743511','2177.53'),(3493,1058682,1437,1,'7505','结单','订单到期获利结算','1693743550','26903.85'),(3494,1058662,1440,2,'5000','下单','下单成功','1693743562','2758'),(3495,1058678,62,2,'500','提现','提现申请','1693743595','43367.33'),(3496,1058663,1438,1,'38863.82','结单','订单到期获利结算','1693743604','38863.82'),(3497,1058680,1439,1,'15655.74','结单','订单到期获利结算','1693743610','24091.88'),(3498,1058663,1441,2,'38863.82','下单','下单成功','1693743631','0'),(3499,1058660,1442,2,'2000','下单','下单成功','1693743636','177.53'),(3500,1058675,1443,2,'3000','下单','下单成功','1693743644','7140.47'),(3501,1058679,63,2,'8000','提现','提现申请','1693743668','20620.91'),(3502,1058673,64,2,'6410','提现','提现申请','1693743676','0.43'),(3503,1058662,1440,1,'5000.0','结单','订单到期获利结算','1693743742','7758.00'),(3504,1058666,1444,2,'1000','下单','下单成功','1693743765','9513.78'),(3505,1058662,1445,2,'5000','下单','下单成功','1693743803','2758'),(3506,1058663,1441,1,'77007.16','结单','订单到期获利结算','1693743811','77007.16'),(3507,1058676,1446,2,'1000','下单','下单成功','1693743817','8646.69'),(3508,1058660,1442,1,'3879.44','结单','订单到期获利结算','1693743817','4056.97'),(3509,1058675,1443,1,'5955.16','结单','订单到期获利结算','1693743826','13095.63'),(3510,1058676,1447,2,'1000','下单','下单成功','1693743841','7646.69'),(3511,1058663,1448,2,'77007.16','下单','下单成功','1693743856','0'),(3512,1058666,1449,2,'1000','下单','下单成功','1693743858','8513.78'),(3513,1058675,1450,2,'6000','下单','下单成功','1693743862','7095.63'),(3514,1058676,1451,2,'1000','下单','下单成功','1693743886','6646.69'),(3515,1058666,1452,2,'1000','下单','下单成功','1693743894','7513.78'),(3516,1058666,1444,1,'1519.62','结单','订单到期获利结算','1693743945','9033.40'),(3517,1058673,66,1,'5000.00','充值','会员充值','1693743952','0.43'),(3518,1058673,65,1,'5000.00','充值','会员充值','1693743955','5000.43'),(3519,1058681,57,1,'1000.00','充值','会员充值','1693743959','0.00'),(3520,1058681,56,1,'10000.00','充值','会员充值','1693743962','1000.00'),(3521,1058681,55,1,'10000.00','充值','会员充值','1693743966','11000.00'),(3522,1058677,1453,2,'1000','下单','下单成功','1693743967','29403.4'),(3523,1058662,1445,1,'3780.1','结单','订单到期获利结算','1693743984','6538.10'),(3524,1058676,1446,1,'1624.57','结单','订单到期获利结算','1693744000','8271.26'),(3525,1058676,1447,1,'1875.93','结单','订单到期获利结算','1693744023','10147.19'),(3526,1058663,1448,1,'133109.9','结单','订单到期获利结算','1693744039','133109.90'),(3527,1058666,1449,1,'1838.02','结单','订单到期获利结算','1693744039','10871.42'),(3528,1058675,1450,1,'11744.53','结单','订单到期获利结算','1693744042','18840.16'),(3529,1058662,1454,2,'5000','下单','下单成功','1693744058','1538.1'),(3530,1058676,1451,1,'1807.41','结单','订单到期获利结算','1693744066','11954.60'),(3531,1058666,1452,1,'1768.46','结单','订单到期获利结算','1693744075','12639.88'),(3532,1058670,67,2,'2000','提现','提现申请','1693744118','8424.08'),(3533,1058677,1453,1,'1846.82','结单','订单到期获利结算','1693744150','31250.22'),(3534,1058660,1455,2,'4000','下单','下单成功','1693744154','56.97'),(3535,1058663,1456,2,'133109.9','下单','下单成功','1693744181','0'),(3536,1058662,1457,2,'1000','下单','下单成功','1693744206','538.1'),(3537,1058662,1454,1,'3997.23','结单','订单到期获利结算','1693744240','4535.33'),(3538,1058666,1458,2,'1000','下单','下单成功','1693744284','11639.88'),(3539,1058657,1459,2,'1000','下单','下单成功','1693744298','9000.4'),(3540,1058676,1460,2,'1000','下单','下单成功','1693744305','10954.6'),(3541,1058660,1455,1,'6658.34','结单','订单到期获利结算','1693744335','6715.31'),(3542,1058663,1456,1,'230359.78','结单','订单到期获利结算','1693744363','230359.78'),(3543,1058675,1461,2,'18000','下单','下单成功','1693744367','840.16'),(3544,1058662,1457,1,'1559.54','结单','订单到期获利结算','1693744386','6094.87'),(3545,1058684,1462,2,'10000','下单','下单成功','1693744391','3188.76'),(3546,1058676,1463,2,'1000','下单','下单成功','1693744413','9954.6'),(3547,1058663,1464,2,'230359.78','下单','下单成功','1693744419','0'),(3548,1058662,1465,2,'5000','下单','下单成功','1693744421','1094.87'),(3549,1058666,1466,2,'1000','下单','下单成功','1693744431','10639.88'),(3550,1058666,1458,1,'1552.34','结单','订单到期获利结算','1693744465','12192.22'),(3551,1058657,1459,1,'1872.04','结单','订单到期获利结算','1693744479','10872.44'),(3552,1058676,1460,1,'1803.79','结单','订单到期获利结算','1693744485','11758.39'),(3553,1058676,1467,2,'1000','下单','下单成功','1693744531','10758.39'),(3554,1058675,1461,1,'35127.01','结单','订单到期获利结算','1693744548','35967.17'),(3555,1058684,1462,1,'18592.82','结单','订单到期获利结算','1693744572','21781.58'),(3556,1058675,1468,2,'10200','下单','下单成功','1693744578','25767.17'),(3557,1058666,1469,2,'1020','下单','下单成功','1693744591','11172.22'),(3558,1058676,1463,1,'1901.56','结单','订单到期获利结算','1693744594','12659.95'),(3559,1058663,1464,1,'381526.07','结单','订单到期获利结算','1693744600','381526.07'),(3560,1058662,1465,1,'3859.54','结单','订单到期获利结算','1693744602','4954.41'),(3561,1058670,1470,2,'1020','下单','下单成功','1693744603','7404.08'),(3562,1058666,1466,1,'1735.17','结单','订单到期获利结算','1693744612','12907.39'),(3563,1058686,71,2,'5000','提现','提现申请','1693744633','0.00'),(3564,1058660,1471,2,'5100','下单','下单成功','1693744710','1615.31'),(3565,1058676,1467,1,'1716.64','结单','订单到期获利结算','1693744711','14376.59'),(3566,1058676,1472,2,'1020','下单','下单成功','1693744724','13356.59'),(3567,1058675,1468,1,'17747.15','结单','订单到期获利结算','1693744758','43514.32'),(3568,1058666,1469,1,'1506.07','结单','订单到期获利结算','1693744773','14413.46'),(3569,1058676,1473,2,'1020','下单','下单成功','1693744778','12336.59'),(3570,1058670,1470,1,'1648.96','结单','订单到期获利结算','1693744785','9053.04'),(3571,1058666,1474,2,'1020','下单','下单成功','1693744824','13393.46'),(3572,1058677,72,1,'100.00','充值','会员充值','1693744834','31250.22'),(3573,1058688,70,1,'50000.00','充值','会员充值','1693744837','0.00'),(3574,1058688,69,1,'50000.00','充值','会员充值','1693744840','50000.00'),(3575,1058673,1475,2,'1020','下单','下单成功','1693744842','7651.71'),(3576,1058662,68,1,'10000.00','充值','会员充值','1693744844','4954.41'),(3577,1058677,1476,2,'10200','下单','下单成功','1693744851','21150.22'),(3578,1058655,73,2,'9541.29','提现','提现申请','1693744877','0.00'),(3579,1058660,1471,1,'8670.01','结单','订单到期获利结算','1693744890','10285.32'),(3580,1058668,74,2,'19703.21','提现','提现申请','1693744902','0.00'),(3581,1058676,1472,1,'1785.53','结单','订单到期获利结算','1693744906','14122.12'),(3582,1058688,1477,2,'10200','下单','下单成功','1693744926','89800'),(3583,1058676,1473,1,'1979.45','结单','订单到期获利结算','1693744959','16101.57'),(3584,1058669,1478,2,'5100','下单','下单成功','1693744967','4776.59'),(3585,1058663,1479,2,'204000','下单','下单成功','1693744971','177526.07'),(3586,1058674,75,2,'76','提现','提现申请','1693744997','1900.12'),(3587,1058666,1474,1,'1994.4','结单','订单到期获利结算','1693745005','15387.86'),(3588,1058674,76,2,'12','提现','提现申请','1693745010','1888.12'),(3589,1058673,1475,1,'1586.19','结单','订单到期获利结算','1693745022','9237.90'),(3590,1058677,1476,1,'19461.75','结单','订单到期获利结算','1693745031','40611.97'),(3591,1058660,1480,2,'10200','下单','下单成功','1693745042','85.32'),(3592,1058688,1477,1,'7045.09','结单','订单到期获利结算','1693745106','96845.09'),(3593,1058669,1478,1,'8826.15','结单','订单到期获利结算','1693745150','13602.74'),(3594,1058663,1479,1,'314413.83','结单','订单到期获利结算','1693745152','491939.90'),(3595,1058671,1481,2,'1224','下单','下单成功','1693745204','100.27'),(3596,1058660,1480,1,'15251.15','结单','订单到期获利结算','1693745223','15336.47'),(3597,1058663,1482,2,'408000','下单','下单成功','1693745253','83939.9'),(3598,1058672,77,2,'1737.64','提现','提现申请','1693745277','0.00'),(3599,1058662,1483,2,'10200','下单','下单成功','1693745381','4754.41'),(3600,1058671,1481,1,'1890.02','结单','订单到期获利结算','1693745386','1990.29'),(3601,1058663,1482,1,'744378.86','结单','订单到期获利结算','1693745434','828318.76'),(3602,1058688,78,2,'50000','提现','提现申请','1693745439','46845.09'),(3603,1058688,79,2,'20000','提现','提现申请','1693745471','26845.09'),(3604,1058660,1484,2,'15300','下单','下单成功','1693745534','36.469999999999'),(3605,1058662,1483,1,'7540.4','结单','订单到期获利结算','1693745562','12294.81'),(3606,1058660,1484,1,'28371.41','结单','订单到期获利结算','1693745715','28407.88'),(3607,1058660,1485,2,'25500','下单','下单成功','1693745804','2907.88'),(3608,1058660,1485,1,'48064.38','结单','订单到期获利结算','1693745985','50972.26'),(3609,1058660,1486,2,'49980','下单','下单成功','1693746050','992.26'),(3610,1058660,1486,1,'93671.17','结单','订单到期获利结算','1693746232','94663.43'),(3611,1058660,1487,2,'91800','下单','下单成功','1693746437','2863.43'),(3612,1058660,1487,1,'150847.44','结单','订单到期获利结算','1693746618','153710.87'),(3613,1058660,1488,2,'153000','下单','下单成功','1693746798','710.87'),(3614,1058660,1488,1,'233850.78','结单','订单到期获利结算','1693746978','234561.65'),(3615,1058655,80,1,'50000.00','充值','会员充值','1693747399','0.00'),(3616,1058660,1489,2,'224400','下单','下单成功','1693747656','10161.65'),(3617,1058660,1489,1,'333454.13','结单','订单到期获利结算','1693747837','343615.78'),(3618,1058675,1490,2,'40800','下单','下单成功','1693748934','2714.32'),(3619,1058675,1490,1,'76226.76','结单','订单到期获利结算','1693749115','78941.08'),(3620,1058675,1491,2,'76500','下单','下单成功','1693749366','2441.08'),(3621,1058675,1491,1,'143822.48','结单','订单到期获利结算','1693749547','146263.56'),(3622,1058666,1492,2,'1020','下单','下单成功','1693749606','14367.86'),(3623,1058666,1492,1,'1875.88','结单','订单到期获利结算','1693749787','16243.74'),(3624,1058682,1493,2,'5100','下单','下单成功','1693751464','21803.85'),(3625,1058663,1494,2,'612000','下单','下单成功','1693751543','216318.76'),(3626,1058682,1493,1,'9162.8','结单','订单到期获利结算','1693751644','30966.65'),(3627,1058660,1495,2,'336600','下单','下单成功','1693751657','7015.78'),(3628,1058663,1494,1,'947632.6','结单','订单到期获利结算','1693751725','1163951.36'),(3629,1058663,1496,2,'918000','下单','下单成功','1693751835','245951.36'),(3630,1058660,1495,1,'568436.83','结单','订单到期获利结算','1693751839','575452.61'),(3631,1058663,1496,1,'1504104.96','结单','订单到期获利结算','1693752015','1750056.32'),(3632,1058666,1497,2,'1020','下单','下单成功','1693752059','15223.74'),(3633,1058666,1497,1,'1687.39','结单','订单到期获利结算','1693752241','16911.13'),(3634,1058666,1498,2,'102','下单','下单成功','1693753545','16809.13'),(3635,1058666,1498,1,'188.19','结单','订单到期获利结算','1693753725','16997.32'),(3636,1058666,1499,2,'1020','下单','下单成功','1693754006','15977.32'),(3637,1058666,1499,1,'1932.41','结单','订单到期获利结算','1693754188','17909.73'),(3638,1058663,1500,2,'1020000','下单','下单成功','1693754626','730056.32'),(3639,1058684,1501,2,'5100','下单','下单成功','1693754657','16681.58'),(3640,1058663,1500,1,'1998498.74','结单','订单到期获利结算','1693754809','2728555.06'),(3641,1058684,1501,1,'8785.07','结单','订单到期获利结算','1693754840','25466.65'),(3642,1058663,1502,2,'2040000','下单','下单成功','1693754859','688555.06'),(3643,1058660,1503,2,'561000','下单','下单成功','1693754889','14452.61'),(3644,1058663,1502,1,'3274331.34','结单','订单到期获利结算','1693755040','3962886.40'),(3645,1058670,1504,2,'1020','下单','下单成功','1693755067','8033.04'),(3646,1058660,1503,1,'968634.39','结单','订单到期获利结算','1693755070','983087.00'),(3647,1058681,1505,2,'10200','下单','下单成功','1693755122','10800'),(3648,1058670,1504,1,'1519.86','结单','订单到期获利结算','1693755250','9552.90'),(3649,1058681,1505,1,'15806.26','结单','订单到期获利结算','1693755303','26606.26'),(3650,1058663,1506,2,'3060000','下单','下单成功','1693758931','902886.4'),(3651,1058663,1506,1,'5528235.46','结单','订单到期获利结算','1693759120','6431121.86'),(3652,1058689,0,1,'5','彩金','注册送彩金','1693801208','0'),(3653,1058670,1507,2,'1020','下单','下单成功','1693801364','8532.9'),(3654,1058670,1507,1,'1871.85','结单','订单到期获利结算','1693801549','10404.75'),(3655,1058670,1508,2,'1020','下单','下单成功','1693801660','9384.75'),(3656,1058670,1508,1,'1714.89','结单','订单到期获利结算','1693801844','11099.64'),(3657,1058671,1509,2,'510','下单','下单成功','1693803489','1480.29'),(3658,1058671,1509,1,'863.29','结单','订单到期获利结算','1693803671','2343.58'),(3659,1058663,1510,2,'4080000','下单','下单成功','1693804273','2351121.86'),(3660,1058663,1510,1,'7177924.12','结单','订单到期获利结算','1693804460','9529045.98'),(3661,1058663,1511,2,'8160000','下单','下单成功','1693804491','1369045.98'),(3662,1058663,1511,1,'13171062.72','结单','订单到期获利结算','1693804677','14540108.70'),(3663,1058663,1512,2,'13260000','下单','下单成功','1693804771','1280108.7'),(3664,1058663,1512,1,'22843380.95','结单','订单到期获利结算','1693804952','24123489.65'),(3665,1058666,1513,2,'1020','下单','下单成功','1693805204','16889.73'),(3666,1058666,85,2,'5000','提现','提现申请','1693805227','11889.73'),(3667,1058676,1514,2,'1020','下单','下单成功','1693805243','15081.57'),(3668,1058676,86,2,'5000','提现','提现申请','1693805257','10081.57'),(3669,1058663,1515,2,'22440000','下单','下单成功','1693805385','1683489.65'),(3670,1058666,1513,1,'1803.85','结单','订单到期获利结算','1693805385','13693.58'),(3671,1058676,1514,1,'1856.69','结单','订单到期获利结算','1693805425','11938.26'),(3672,1058663,1515,1,'34713995.8','结单','订单到期获利结算','1693805570','36397485.45'),(3673,1058663,1516,2,'30600000','下单','下单成功','1693805582','5797485.45'),(3674,1058663,1516,1,'57916334.65','结单','订单到期获利结算','1693805771','63713820.10'),(3675,1058676,1517,2,'1020','下单','下单成功','1693806085','10918.26'),(3676,1058676,1518,2,'1020','下单','下单成功','1693806092','9898.26'),(3677,1058676,1517,1,'1626.1','结单','订单到期获利结算','1693806272','11524.36'),(3678,1058676,1518,1,'1723.45','结单','订单到期获利结算','1693806281','13247.81'),(3679,1058663,1519,2,'61200000','下单','下单成功','1693807536','2513820.1'),(3680,1058663,1519,1,'90467724.94','结单','订单到期获利结算','1693807719','92981545.04'),(3681,1058663,1520,2,'86700000','下单','下单成功','1693808589','6281545.04'),(3682,1058670,1521,2,'1020','下单','下单成功','1693808822','10079.64'),(3683,1058670,1521,1,'1648.25','结单','订单到期获利结算','1693809013','11727.89'),(3684,1058663,1522,2,'102000000','下单','下单成功','1693809358','68524032.45'),(3685,1058667,1523,2,'1020','下单','下单成功','1693809480','589.65'),(3686,1058663,1524,2,'91800000','下单','下单成功','1693809644','166375821.82'),(3687,1058667,1523,1,'1662.44','结单','订单到期获利结算','1693809669','2252.09'),(3688,1058676,1525,2,'5100','下单','下单成功','1693809789','8147.81'),(3689,1058670,1526,2,'1020','下单','下单成功','1693809957','10707.89'),(3690,1058676,1525,1,'8669.8','结单','订单到期获利结算','1693809971','16817.61'),(3691,1058684,1527,2,'10200','下单','下单成功','1693810001','15266.65'),(3692,1058663,87,2,'100000','提现','提现申请','1693810059','320947561.61'),(3693,1058670,1526,1,'1632.99','结单','订单到期获利结算','1693810141','12340.88'),(3694,1058684,1527,1,'16386.16','结单','订单到期获利结算','1693810183','31652.81'),(3695,1058667,1528,2,'2040','下单','下单成功','1693810446','212.09'),(3696,1058676,1529,2,'1020','下单','下单成功','1693810476','15797.61'),(3697,1058670,1530,2,'1020','下单','下单成功','1693810521','11320.88'),(3698,1058690,0,1,'5','彩金','注册送彩金','1693810582','0'),(3699,1058667,1528,1,'3391.97','结单','订单到期获利结算','1693810630','3604.06'),(3700,1058676,1529,1,'1862.8','结单','订单到期获利结算','1693810662','17660.41'),(3701,1058670,1530,1,'1654.61','结单','订单到期获利结算','1693810702','12975.49'),(3702,1058689,84,1,'10000.00','充值','会员充值','1693810977','5.00'),(3703,1058664,83,1,'5000.00','充值','会员充值','1693810980','0.34'),(3704,1058685,82,1,'1000.00','充值','会员充值','1693810983','0.00'),(3705,1058677,81,1,'10000.00','充值','会员充值','1693810987','40611.97'),(3706,1058662,1531,2,'10200','下单','下单成功','1693811088','2094.81'),(3707,1058671,1532,2,'2040','下单','下单成功','1693811216','303.58'),(3708,1058667,1533,2,'3060','下单','下单成功','1693811250','544.06'),(3709,1058662,1531,1,'18109.82','结单','订单到期获利结算','1693811277','20204.63'),(3710,1058671,1532,1,'3722.75','结单','订单到期获利结算','1693811398','4026.33'),(3711,1058667,1533,1,'5842.17','结单','订单到期获利结算','1693811431','6386.23'),(3712,1058670,1534,2,'1020','下单','下单成功','1693811702','11955.49'),(3713,1058670,1534,1,'1721','结单','订单到期获利结算','1693811882','13676.49'),(3714,1058649,1535,2,'102','下单','下单成功','1694240004','9840.06'),(3715,1058649,88,1,'10000','充值','后台加款','1694252535','19840.06'),(3716,1058649,89,2,'-100','提现','后台扣款','1694252634','19740.06'),(3717,1058649,4,2,'100','利息宝','投资','1694254892','19740.06'),(3718,1058692,90,1,'123123','充值','后台加款','1694277089','123123'),(3719,1058692,1536,2,'1020','下单','下单成功','1694277110','122103'),(3720,1058692,91,2,'123','提现','提现申请','1694277164','121980.00'),(3721,1058649,1535,1,'196.75','结单','订单到期获利结算','1694278010','19836.81'),(3722,1058692,1536,1,'747.41','结单','订单到期获利结算','1694278010','122727.41'),(3723,1058649,1537,2,'1020','下单','下单成功','1694278422','18816.81'),(3724,1058649,1538,2,'1020','下单','下单成功','1694278467','17796.81'),(3725,1058649,1537,1,'751.87','结单','订单到期获利结算','1694278650','18548.68'),(3726,1058649,1538,1,'1197.03','结单','订单到期获利结算','1694278651','19745.71');
/*!40000 ALTER TABLE `wp_price_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_productclass`
--

DROP TABLE IF EXISTS `wp_productclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_productclass` (
  `pcid` mediumint(8) NOT NULL AUTO_INCREMENT,
  `pcname` varchar(8) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  PRIMARY KEY (`pcid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_productclass`
--

LOCK TABLES `wp_productclass` WRITE;
/*!40000 ALTER TABLE `wp_productclass` DISABLE KEYS */;
INSERT INTO `wp_productclass` VALUES (1,'油',1),(2,'金属',1),(3,'啥的萨达是123',1),(4,'指数',1),(5,'外汇',0);
/*!40000 ALTER TABLE `wp_productclass` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_productdata`
--

DROP TABLE IF EXISTS `wp_productdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_productdata` (
  `id` int(28) NOT NULL AUTO_INCREMENT,
  `pid` varchar(18) DEFAULT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `Price` varchar(18) DEFAULT NULL,
  `Open` varchar(18) DEFAULT NULL,
  `Close` varchar(18) DEFAULT NULL,
  `High` varchar(18) DEFAULT NULL COMMENT '最高',
  `Low` varchar(18) DEFAULT NULL COMMENT '最低',
  `Diff` varchar(18) DEFAULT NULL COMMENT '振幅',
  `DiffRate` varchar(18) DEFAULT NULL COMMENT '波幅',
  `UpdateTime` varchar(18) DEFAULT NULL,
  `rands` varchar(8) DEFAULT NULL,
  `point` varchar(8) DEFAULT NULL,
  `isdelete` int(1) DEFAULT '0',
  `is_deal` tinyint(3) DEFAULT '0' COMMENT '是否交易中',
  `img` varchar(100) DEFAULT NULL COMMENT '图像',
  `procode` varchar(20) DEFAULT NULL COMMENT '请求代码',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序从小到大',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_productdata`
--

LOCK TABLES `wp_productdata` WRITE;
/*!40000 ALTER TABLE `wp_productdata` DISABLE KEYS */;
INSERT INTO `wp_productdata` VALUES (9,'11','Brazil Index','4.29504','4.2464','4.2899','4.3932','4.1964','0','0','1693811949','','',0,1,NULL,NULL,8),(10,'12','USD CHF','0.88333','0.8856','0.8832','0.8860','0.8831','0','0','1693811949','','',0,1,'/public/guoqi/1.png','fx_saudusd',14),(11,'13','OMG','7.84004','7.8448','7.8440','7.8463','7.8380','0','0','1693811949','','',0,1,'/public/guoqi/5.png','fx_snzdusd',21),(12,'14','XAU/USD','1918.398','1919.96','1919.93','1930.00','1917.66','0','0','1694313963','','',0,1,'/public/jpg/llg.png','hf_GC',0),(13,'15','Precious metal','24.118','24.165','24.217','24.316','24.117','0','0','1693811949','','',0,1,'/public/jpg/lls.png',NULL,2),(14,'16','USD KRW','1.35294','1.3533','1.3511','1.3546','1.3521','0','0','1693811949','','',0,1,'/public/guoqi/6.png','fx_seurusd',15),(15,'17','XLM','31.89402','31.8180','31.8485','31.9120','31.8180','0','0','1693811949','','',0,1,'/public/guoqi/7.png','fx_susdjpy',22),(20,'22','BTS','3848.9508','3812.99','0','3854.26','3804.59','0','0','1693811949','','',0,1,'/public/pjpg/AU.png','sz399300',23),(21,'23','XAG/USD','24.1359','24.1625','24.4344','24.2932','24.0771','0','0','1693811949',NULL,NULL,0,1,'/public/jpg/silver.png',NULL,1),(27,'29','France Index','1368.18','1369.000','0','1385.000','1366.000','0','0','1693811949',NULL,NULL,0,1,'/public/guoqi/2.png',NULL,9),(29,'31','Swiss Index','1639.82','1635.99','1639.85','1647.04','1625.17','0','0','1693811949',NULL,NULL,0,1,'/public/guoqi/4.png',NULL,10),(30,'32','DOGE','1.26208','1.2584','1.2649','1.2623','1.2580','0','0','1693811949',NULL,NULL,0,1,'/public/guoqi/7.png',NULL,19),(32,'34','USDJPY','146.245','146.180','145.628','146.350','146.000','0','0','1693811949',NULL,NULL,0,1,'/public/guoqi/5.png',NULL,17),(33,'35','UK Index','19.85483','19.5333','19.849','20.0399','19.2201','0','0','1693811949',NULL,NULL,0,1,'/public/jpg/GU.png',NULL,11),(34,'36','EURUSD','1.07979','1.0776','1.0830','1.0800','1.0770','0','0','1693811949',NULL,NULL,0,1,'/public/jpg/EU.png',NULL,18),(36,'38','US Index','25998.60019','25927.7','25998.59','26133','25805.75','0','0','1693811949',NULL,NULL,0,1,'/public/guoqi/3.png',NULL,7),(37,'39','Japan Index','85.56995','86.06','85.55','86.09','85.42','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,13),(39,'41','Korea Index','2.70309','2.700','2.765','2.707','2.651','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,12),(40,'42','LTC','64.317','64.35','64.3','64.98','63.58','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,20),(43,'45','USD Thai Baht','0.6101','0.5937','0.5960','0.5960','0.5935','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,16),(52,'56','OIL/USD','87.21','86.77','86.87','87.95','86.15','0','0','1694313963',NULL,NULL,0,1,NULL,NULL,3),(53,'57','SPIF','104.03997','104.2300','103.7310','104.2800','104.0400','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,4),(54,'58','NYMEXCNG','2.70313','2.700','2.765','2.707','2.651','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,5),(55,'59','USD Index','104.0415','104.230','103.731','104.280','104.040','0','0','1693811949',NULL,NULL,0,1,NULL,NULL,6);
/*!40000 ALTER TABLE `wp_productdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_productinfo`
--

DROP TABLE IF EXISTS `wp_productinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_productinfo` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `ptitle` varchar(255) DEFAULT NULL COMMENT '标题',
  `cid` int(11) DEFAULT NULL COMMENT '产品分类id',
  `otid` int(11) DEFAULT NULL COMMENT '开市方案id',
  `isopen` int(1) DEFAULT '1',
  `point` varchar(255) DEFAULT NULL COMMENT '点数',
  `point_low` varchar(18) DEFAULT '0.00000' COMMENT '波动最小值',
  `point_top` varchar(18) DEFAULT '0.00000' COMMENT '波动最大值',
  `rands` varchar(18) DEFAULT '0.00000' COMMENT '随机波动范围',
  `content` text COMMENT '备注',
  `time` int(11) DEFAULT NULL COMMENT '添加时间',
  `isdelete` int(1) DEFAULT NULL COMMENT '0',
  `procode` varchar(18) DEFAULT NULL COMMENT ' 产品代码',
  `add_data` double(18,4) DEFAULT '0.0000' COMMENT '除汇率以外的算法',
  `protime` varchar(20) DEFAULT NULL COMMENT '时间玩法间隔',
  `propoint` varchar(10) DEFAULT NULL COMMENT '点位玩法间隔',
  `proscale` varchar(20) NOT NULL DEFAULT '0' COMMENT '波动/盈亏1%',
  `proorder` int(18) DEFAULT '0' COMMENT '排序',
  `img` varchar(128) DEFAULT NULL COMMENT '各种货币的图片',
  `promoney` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_productinfo`
--

LOCK TABLES `wp_productinfo` WRITE;
/*!40000 ALTER TABLE `wp_productinfo` DISABLE KEYS */;
INSERT INTO `wp_productinfo` VALUES (11,'Brazil Index',5,1,1,'98','0.00001','0.00015','0.008','',1681538667,0,'ant',0.0000,'3,5,10,15','','0.008',6,'/public/uploads/20230301/pic_11.png','3000,5000,10000,15000'),(12,'USD CHF',5,1,0,'79789','0.00001','0.00005','0.008','',1681539026,0,'29',0.0000,'3,5,10,15','','0.008',10,'/public/uploads/20230301/pic_12.png','3000,5000,10000,15000'),(13,'OMG',5,0,0,'232','0.00001','0.00005','0.008','',1681538802,0,'30',0.0000,'3,5,10,15','','0.008',10,'/public/uploads/20230301/pic_13.png','3000,5000,10000,15000'),(14,'XAU/USD',5,0,1,'6978','0.001','0.010','0.008','',1694239999,0,'llg',0.0000,'3,5,10,15','','0.008',4,'/public/uploads/20230203/pic_14.png','3000,5000,10000,15000'),(15,'Precious metal',5,0,1,'1234','0.001','0.01','0.004','',1681538631,0,'lls',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230321/pic_15.png','3000,5000,10000,15000'),(16,'USD KRW',5,0,0,'37696','0.00001','0.00005','0.00003','',1681539002,0,'33',0.0000,'3,5,10,15','','0.00002',10,'/public/uploads/20230301/pic_16.png','3000,5000,10000,15000'),(17,'XLM',5,0,0,'6876','0.00001','0.00005','0.00003','',1681538793,0,'34',0.0000,'3,5,10,15','','0.00002',10,'/public/uploads/20230301/pic_17.png','3000,5000,10000,15000'),(22,'BTS',5,0,1,'546','0.0001','0.0009','0.15','',1693811909,0,'43',0.0000,'3,5,10,15','','0.008',0,'/public/uploads/20230301/pic_22.png','3000,5000,10000,15000'),(23,'XAG/USD',5,NULL,1,'434','0.001','0.010','0.005','',1693740002,0,'13',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230203/pic_23.png','3000,5000,10000,15000'),(29,'France Index',5,1,1,NULL,'0.01','0.10','0.08','',1681622611,0,'96',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_29.png','3000,5000,10000,15000'),(31,'Swiss Index',5,1,1,NULL,'0.03','0.18','0.04','',1681538685,0,'eth',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_31.png','3000,5000,10000,15000'),(32,'DOGE',5,1,1,NULL,'0.00001','0.00020','0.00010','',1681538946,0,'26',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_32.png','3000,5000,10000,15000'),(34,'USDJPY',5,1,1,NULL,'0.005','0.015','0.005','',1681538965,0,'31',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_34.png','3000,5000,10000,15000'),(35,'UK Index',5,1,1,NULL,'0.00001','0.00015','0.00012','',1681538735,0,'sol',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_35.png','3000,5000,10000,15000'),(36,'EURUSD',5,NULL,1,NULL,'0.00001','0.00005','0.00003','',1681538955,0,'24',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_36.png','3000,5000,10000,15000'),(38,'US Index',5,NULL,1,NULL,'0.00001','0.00015','0.008','',1681538652,0,'btc',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_38.png','3000,5000,10000,15000'),(39,'Japan Index',5,NULL,1,NULL,'0.00001','0.00015','0.008','',1681538773,0,'116',0.0000,'3,5,10,15',NULL,'0.035',0,'/public/uploads/20230301/pic_39.png','3000,5000,10000,15000'),(41,'Korea Index',5,NULL,1,NULL,'0.00001','0.00015','0.008','',1681538747,0,'15',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_41.png','3000,5000,10000,15000'),(42,'LTC',5,NULL,1,NULL,'0.001','0.015','0.008','',1681538930,0,'ltc',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_42.png','3000,5000,10000,15000'),(45,'USD Thai Baht',5,NULL,1,NULL,'0.001','0.015','0.008','',1681538990,0,'27',0.0000,'3,5,10,15',NULL,'0.008',0,'/public/uploads/20230301/pic_45.png','3000,5000,10000,15000'),(56,'OIL/USD',5,NULL,1,NULL,'0.001','0.009','0.0008','国际原油',1693739887,0,'14',0.0000,'3,5,10,15',NULL,'0.1',0,'/public/uploads/20230320/pic_56.png','3000,5000,10000,15000'),(57,'SPIF',5,NULL,1,NULL,'0.000009','0.00015','0.0008','美指期货',1681538612,0,'11',0.0000,'3,5,10,15',NULL,'0.1',0,'/public/uploads/20230321/pic_57.png','3000,5000,10000,15000'),(58,'NYMEXCNG',5,NULL,1,NULL,'0.00009','0.00015','0.0008','',1681539068,0,'15',0.0000,'3,5,10,15',NULL,'0.1',0,'/public/uploads/20230321/pic_58.png','3000,5000,10000,15000'),(59,'USD Index',5,NULL,1,NULL,'0.0009','0.0015','0.0008','',1693740030,0,'22',0.0000,'3,5,10,15',NULL,'0.1',0,'/public/uploads/20230321/pic_59.png','3000,5000,10000,15000');
/*!40000 ALTER TABLE `wp_productinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_productprice`
--

DROP TABLE IF EXISTS `wp_productprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_productprice` (
  `id` mediumint(18) NOT NULL AUTO_INCREMENT,
  `order_min_price` varchar(50) DEFAULT NULL COMMENT '最小下注额',
  `order_max_price` varchar(50) DEFAULT NULL COMMENT '最大下注额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_productprice`
--

LOCK TABLES `wp_productprice` WRITE;
/*!40000 ALTER TABLE `wp_productprice` DISABLE KEYS */;
INSERT INTO `wp_productprice` VALUES (1,'20','50000'),(2,'100','100000'),(3,'20','1000000'),(4,'10000','10000000');
/*!40000 ALTER TABLE `wp_productprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_refundlog`
--

DROP TABLE IF EXISTS `wp_refundlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_refundlog` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `mch_appid` varchar(28) DEFAULT NULL,
  `mchid` varchar(18) DEFAULT NULL,
  `device_info` varchar(288) DEFAULT NULL,
  `nonce_str` varchar(28) DEFAULT NULL,
  `payment_no` varchar(18) DEFAULT NULL,
  `partner_trade_no` varchar(18) DEFAULT NULL,
  `payment_time` datetime DEFAULT NULL,
  `result_code` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_refundlog`
--

LOCK TABLES `wp_refundlog` WRITE;
/*!40000 ALTER TABLE `wp_refundlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_refundlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_reward`
--

DROP TABLE IF EXISTS `wp_reward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_reward` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `reg_money` decimal(5,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '邀请注册奖励',
  `invest_percent` decimal(5,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '邀请投注奖励%',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='邀请奖励';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_reward`
--

LOCK TABLES `wp_reward` WRITE;
/*!40000 ALTER TABLE `wp_reward` DISABLE KEYS */;
INSERT INTO `wp_reward` VALUES (1,0.00,0.00);
/*!40000 ALTER TABLE `wp_reward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_risk`
--

DROP TABLE IF EXISTS `wp_risk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_risk` (
  `id` mediumint(8) NOT NULL AUTO_INCREMENT,
  `to_win` text CHARACTER SET utf8 COMMENT '指定客户赢利',
  `to_loss` text CHARACTER SET utf8 COMMENT '指定客户亏损',
  `chance` text CHARACTER SET utf8 COMMENT '风控概率',
  `min_price` varchar(18) CHARACTER SET utf8 DEFAULT NULL COMMENT '最小风控值',
  `min_yk` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '止盈止损下限',
  `max_yk` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '止盈止损上限',
  `min_yk1` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间1止盈',
  `max_yk1` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间1止损',
  `min_yk2` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间2止盈',
  `max_yk2` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间2止损',
  `min_yk3` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间3止盈',
  `max_yk3` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间3止损',
  `min_yk4` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间4止盈',
  `max_yk4` varchar(8) NOT NULL DEFAULT '0' COMMENT '时间4止损',
  `min_gain` decimal(4,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '盈亏下限',
  `max_gain` decimal(4,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '盈亏上限',
  `special_yk` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '强制指定的用户100%输赢',
  `percent` decimal(5,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '盈亏',
  `min_lost` decimal(4,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '未指定，盈亏下限',
  `max_lost` decimal(4,1) unsigned NOT NULL DEFAULT '0.0' COMMENT '未指定，盈亏上限',
  `time1` varchar(5) NOT NULL DEFAULT '' COMMENT '起始时间',
  `time2` varchar(5) NOT NULL DEFAULT '' COMMENT '结束时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_risk`
--

LOCK TABLES `wp_risk` WRITE;
/*!40000 ALTER TABLE `wp_risk` DISABLE KEYS */;
INSERT INTO `wp_risk` VALUES (8,'1058657|1058679|1058672|1058684|1058667|1058678|1058672|1058673|1058669|1058658|1058668|1058674|1058669|1058683|1058674|1058683|1058682|1058670|1058676|1058680|1058671|1058664|1058677|1058675|1058664|1058677|1058666|1058663|1058663|1058660|1058660|1058655|1058656|1058655|1058655|1058653|1058653|1058671|1058659|1058662','','10-1000:50|1000-2000:100|2000-5000:500|5000-10000:20|10000-100000000:10','10',20,50,'10,20','20,30','10,20','20,30','10,20','20,30','10,20','20,30',3.0,8.0,0,0.00,5.0,8.0,'00:00','00:01');
/*!40000 ALTER TABLE `wp_risk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_slide`
--

DROP TABLE IF EXISTS `wp_slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_slide` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `img` varchar(64) NOT NULL DEFAULT '' COMMENT '幻灯片',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='幻灯片';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_slide`
--

LOCK TABLES `wp_slide` WRITE;
/*!40000 ALTER TABLE `wp_slide` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_slide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_sysbank`
--

DROP TABLE IF EXISTS `wp_sysbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_sysbank` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(255) NOT NULL DEFAULT '' COMMENT '银行名称',
  `bank_addr` varchar(255) NOT NULL DEFAULT '' COMMENT '开户网点',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '户名',
  `card_no` varchar(255) NOT NULL DEFAULT '' COMMENT '账号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='入款银行';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_sysbank`
--

LOCK TABLES `wp_sysbank` WRITE;
/*!40000 ALTER TABLE `wp_sysbank` DISABLE KEYS */;
INSERT INTO `wp_sysbank` VALUES (1,'Eximbank ','Ngân hàng thương mại cổ phần Xuất Nhập khẩu Việt Nam',' NGUYEN THANH TINH ','0815608543');
/*!40000 ALTER TABLE `wp_sysbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_userbind`
--

DROP TABLE IF EXISTS `wp_userbind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_userbind` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `btime` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_userbind`
--

LOCK TABLES `wp_userbind` WRITE;
/*!40000 ALTER TABLE `wp_userbind` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_userbind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_usercode`
--

DROP TABLE IF EXISTS `wp_usercode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_usercode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(255) NOT NULL COMMENT '所属用户id',
  `code` varchar(6) NOT NULL COMMENT '邀请码',
  `type` varchar(11) NOT NULL COMMENT '渠道ID',
  `time` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_usercode`
--

LOCK TABLES `wp_usercode` WRITE;
/*!40000 ALTER TABLE `wp_usercode` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_usercode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_userinfo`
--

DROP TABLE IF EXISTS `wp_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_userinfo` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '',
  `upwd` varchar(32) NOT NULL,
  `epwd` varchar(32) DEFAULT NULL COMMENT '交易密码',
  `utel` varchar(32) DEFAULT NULL,
  `utime` int(20) DEFAULT NULL COMMENT '注册时间',
  `agenttype` int(20) DEFAULT '0' COMMENT '0普通客户，1申请经纪人中，2经纪人',
  `otype` int(11) NOT NULL DEFAULT '0' COMMENT '0普通会员，2会员单位，1经纪人,3超级管理员,1和2已废弃，101为代理商',
  `ustatus` int(11) NOT NULL DEFAULT '0' COMMENT '0正常状态，1冻结状态，',
  `oid` varchar(28) DEFAULT NULL COMMENT '上线字段',
  `address` varchar(30) DEFAULT NULL COMMENT '地址',
  `portrait` varchar(100) DEFAULT NULL COMMENT '头像',
  `lastlog` int(20) DEFAULT NULL COMMENT '最后登录时间',
  `lastip` varchar(15) NOT NULL DEFAULT '' COMMENT 'IP',
  `managername` varchar(20) DEFAULT NULL COMMENT '上线用户名',
  `comname` varchar(20) DEFAULT NULL COMMENT '公司名称',
  `comqua` varchar(50) DEFAULT NULL COMMENT '公司资质',
  `rebate` varchar(11) DEFAULT NULL COMMENT '返点',
  `feerebate` varchar(11) DEFAULT '0' COMMENT '手续费返点',
  `usertype` int(11) DEFAULT '0' COMMENT '0不是微信用户。1是微信用户',
  `wxtype` int(11) DEFAULT '0' COMMENT '1表示微信还没注册，0微信已注册成会员。',
  `openid` varchar(50) DEFAULT NULL COMMENT '存微信用户的id',
  `nickname` varchar(32) NOT NULL DEFAULT '' COMMENT '用户昵称',
  `icard` varchar(18) DEFAULT NULL COMMENT '身份证号',
  `logintime` varchar(18) DEFAULT NULL,
  `usermoney` decimal(18,2) DEFAULT '0.00',
  `freeze` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '冻结',
  `userpoint` int(10) DEFAULT '100' COMMENT '积分',
  `minprice` decimal(10,2) DEFAULT NULL,
  `sessionkey` varchar(32) DEFAULT '',
  `domain` varchar(18) NOT NULL DEFAULT '' COMMENT '注册域名',
  `online` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1在线 0不在线',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `log_caijin` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1送彩金 0不送',
  `scard` varchar(32) DEFAULT NULL COMMENT '身份证',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `utel` (`utel`)
) ENGINE=InnoDB AUTO_INCREMENT=1058693 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_userinfo`
--

LOCK TABLES `wp_userinfo` WRITE;
/*!40000 ALTER TABLE `wp_userinfo` DISABLE KEYS */;
INSERT INTO `wp_userinfo` VALUES (1058647,'admin','123456','123456','admin@admin.com',1480061674,2,3,0,'','','',1694235525,'0.0.0.0','','','','','0',0,0,'','admin','','1526017454',0.00,0.00,100,0.00,'','',0,0,1,NULL),(1058649,'ggabram','123456','123456','ggabram',1674905731,0,0,0,'1058650',NULL,NULL,1694278398,'0.0.0.0',NULL,NULL,NULL,NULL,'0',0,0,NULL,'高高','211410199608131876','1694278398',19745.71,17300.00,100,NULL,'68488','',0,1694278467,1,NULL);
/*!40000 ALTER TABLE `wp_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_userinvest`
--

DROP TABLE IF EXISTS `wp_userinvest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_userinvest` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UID',
  `username` varchar(255) NOT NULL DEFAULT '' COMMENT '客户名',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT '标ID',
  `days` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '天数',
  `money` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本金',
  `interest` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '分红 或 利息',
  `state` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '1待分红 2已分红',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '投资时间',
  `totime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '回款时间',
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='客户投资';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_userinvest`
--

LOCK TABLES `wp_userinvest` WRITE;
/*!40000 ALTER TABLE `wp_userinvest` DISABLE KEYS */;
INSERT INTO `wp_userinvest` VALUES (4,1058649,'ggabram',1002,7,100,14.00,1,1694254892,1694859692,'US Index');
/*!40000 ALTER TABLE `wp_userinvest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `wp_view_proinfo`
--

DROP TABLE IF EXISTS `wp_view_proinfo`;
/*!50001 DROP VIEW IF EXISTS `wp_view_proinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `wp_view_proinfo` (
  `is_deal` tinyint NOT NULL,
  `Low` tinyint NOT NULL,
  `High` tinyint NOT NULL,
  `Close` tinyint NOT NULL,
  `Open` tinyint NOT NULL,
  `Price` tinyint NOT NULL,
  `isdelete` tinyint NOT NULL,
  `Name` tinyint NOT NULL,
  `pid` tinyint NOT NULL,
  `sort` tinyint NOT NULL,
  `UpdateTime` tinyint NOT NULL,
  `img` tinyint NOT NULL,
  `Diff` tinyint NOT NULL,
  `DiffRate` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `wp_webconfig`
--

DROP TABLE IF EXISTS `wp_webconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_webconfig` (
  `id` int(11) NOT NULL,
  `isopen` int(11) NOT NULL DEFAULT '0' COMMENT '0开启，1关闭',
  `webname` varchar(20) DEFAULT NULL COMMENT '网站名称',
  `onelevel` varchar(20) NOT NULL,
  `twolevel` varchar(20) NOT NULL,
  `Pscale` varchar(20) NOT NULL,
  `begintime` int(20) DEFAULT NULL COMMENT '休市开始时间',
  `endtime` int(20) DEFAULT NULL COMMENT '休市结束时间',
  `notice` varchar(100) DEFAULT NULL COMMENT '公告',
  `isnotice` int(10) DEFAULT '0' COMMENT '0开启，1关闭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_webconfig`
--

LOCK TABLES `wp_webconfig` WRITE;
/*!40000 ALTER TABLE `wp_webconfig` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_webconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_wechat`
--

DROP TABLE IF EXISTS `wp_wechat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_wechat` (
  `wcid` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(255) DEFAULT NULL COMMENT 'AppID(应用ID)',
  `appsecret` varchar(255) DEFAULT NULL COMMENT 'AppSecret(应用密钥)',
  `wxname` varchar(255) DEFAULT NULL COMMENT '公众号名称',
  `wxlogin` varchar(255) DEFAULT NULL COMMENT '微信原始账号',
  `wxurl` varchar(255) DEFAULT NULL COMMENT 'url服务器地址',
  `token` varchar(255) DEFAULT NULL COMMENT '令牌',
  `encodingaeskey` varchar(255) DEFAULT NULL COMMENT '消息加密解密秘钥',
  `parterid` int(11) DEFAULT NULL COMMENT '微信商户账号',
  `parterkey` varchar(255) DEFAULT NULL COMMENT '32位密码',
  PRIMARY KEY (`wcid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_wechat`
--

LOCK TABLES `wp_wechat` WRITE;
/*!40000 ALTER TABLE `wp_wechat` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_wechat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wp_words`
--

DROP TABLE IF EXISTS `wp_words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_words` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `content` varchar(200) NOT NULL DEFAULT '' COMMENT '常用语',
  `state` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1正常 -1不正常',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客服常用语';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wp_words`
--

LOCK TABLES `wp_words` WRITE;
/*!40000 ALTER TABLE `wp_words` DISABLE KEYS */;
/*!40000 ALTER TABLE `wp_words` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `wp_view_proinfo`
--

/*!50001 DROP TABLE IF EXISTS `wp_view_proinfo`*/;
/*!50001 DROP VIEW IF EXISTS `wp_view_proinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`site`@`127.0.0.1` SQL SECURITY INVOKER */
/*!50001 VIEW `wp_view_proinfo` AS select `wp_productdata`.`is_deal` AS `is_deal`,`wp_productdata`.`Low` AS `Low`,`wp_productdata`.`High` AS `High`,`wp_productdata`.`Close` AS `Close`,`wp_productdata`.`Open` AS `Open`,`wp_productdata`.`Price` AS `Price`,`wp_productdata`.`isdelete` AS `isdelete`,`wp_productdata`.`Name` AS `Name`,`wp_productdata`.`pid` AS `pid`,`wp_productdata`.`sort` AS `sort`,`wp_productdata`.`UpdateTime` AS `UpdateTime`,`wp_productinfo`.`img` AS `img`,`wp_productdata`.`Diff` AS `Diff`,`wp_productdata`.`DiffRate` AS `DiffRate` from (`wp_productinfo` join `wp_productdata`) where (`wp_productinfo`.`pid` = `wp_productdata`.`pid`) */;
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

-- Dump completed on 2023-09-10 10:48:37
