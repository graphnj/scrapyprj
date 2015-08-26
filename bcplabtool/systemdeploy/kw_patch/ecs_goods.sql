/*
Navicat MySQL Data Transfer

Source Server         : MYSQL
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : bcplabdemo

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2014-12-08 16:32:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ecs_goods`
-- ----------------------------
DROP TABLE IF EXISTS `ecs_goods`;
CREATE TABLE `ecs_goods` (
  `goods_id` mediumint(8) unsigned NOT NULL auto_increment,
  `cat_id` int(11) unsigned NOT NULL default '0',
  `goods_sn` varchar(60) NOT NULL default '',
  `goods_name` varchar(120) NOT NULL default '',
  `goods_name_style` varchar(60) NOT NULL default '+',
  `click_count` int(10) unsigned NOT NULL default '0',
  `brand_id` smallint(5) unsigned NOT NULL default '0',
  `provider_name` varchar(100) NOT NULL default '',
  `goods_number` smallint(5) unsigned NOT NULL default '0',
  `goods_weight` decimal(10,3) unsigned NOT NULL default '0.000',
  `market_price` decimal(10,2) unsigned NOT NULL default '0.00',
  `shop_price` decimal(10,2) unsigned NOT NULL default '0.00',
  `promote_price` decimal(10,2) unsigned NOT NULL default '0.00',
  `promote_start_date` int(11) unsigned NOT NULL default '0',
  `promote_end_date` int(11) unsigned NOT NULL default '0',
  `warn_number` tinyint(3) unsigned NOT NULL default '1',
  `keywords` varchar(255) NOT NULL default '',
  `goods_brief` varchar(255) NOT NULL default '',
  `goods_desc` text NOT NULL,
  `goods_thumb` varchar(255) NOT NULL default '',
  `goods_img` varchar(255) NOT NULL default '',
  `original_img` varchar(255) NOT NULL default '',
  `is_real` tinyint(3) unsigned NOT NULL default '1',
  `extension_code` varchar(30) NOT NULL default '',
  `is_on_sale` tinyint(1) unsigned NOT NULL default '1',
  `is_alone_sale` tinyint(1) unsigned NOT NULL default '1',
  `is_shipping` tinyint(1) unsigned NOT NULL default '0',
  `integral` int(10) unsigned NOT NULL default '0',
  `add_time` int(10) unsigned NOT NULL default '0',
  `sort_order` smallint(4) unsigned NOT NULL default '100',
  `is_delete` tinyint(1) unsigned NOT NULL default '0',
  `is_best` tinyint(1) unsigned NOT NULL default '0',
  `is_new` tinyint(1) unsigned NOT NULL default '0',
  `is_hot` tinyint(1) unsigned NOT NULL default '0',
  `is_promote` tinyint(1) unsigned NOT NULL default '0',
  `bonus_type_id` tinyint(3) unsigned NOT NULL default '0',
  `last_update` int(10) unsigned NOT NULL default '0',
  `goods_type` int(11) unsigned NOT NULL default '0',
  `seller_note` varchar(255) NOT NULL default '',
  `give_integral` int(11) NOT NULL default '-1',
  `rank_integral` int(11) NOT NULL default '-1',
  `suppliers_id` smallint(5) unsigned default NULL,
  `is_check` tinyint(1) unsigned default NULL,
  `goods_en_name` varchar(200) default NULL,
  `reagent_rank` tinyint(2) default NULL,
  `reagent_purity` varchar(60) default NULL,
  `goods_unit` varchar(10) default NULL,
  `reagent_package_business` varchar(200) default NULL,
  `chem_cas` varchar(100) default NULL,
  `chem_mdl` varchar(100) default NULL,
  `chem_molecular_formula` varchar(100) default NULL,
  `chem_formula_weight` decimal(10,2) default NULL,
  `mach_config` varchar(200) default NULL,
  `mach_purchase_date` int(11) default NULL,
  `mach_purchase_price` decimal(10,2) default NULL,
  `mach_recency` tinyint(2) default NULL,
  `mach_installation_services` tinyint(1) default NULL,
  `goods_datum` varchar(255) default NULL,
  PRIMARY KEY  (`goods_id`),
  KEY `goods_sn` (`goods_sn`),
  KEY `cat_id` (`cat_id`),
  KEY `last_update` (`last_update`),
  KEY `brand_id` (`brand_id`),
  KEY `goods_weight` (`goods_weight`),
  KEY `promote_end_date` (`promote_end_date`),
  KEY `promote_start_date` (`promote_start_date`),
  KEY `goods_number` (`goods_number`),
  KEY `sort_order` (`sort_order`)
) ENGINE=MyISAM AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ecs_goods
-- ----------------------------
INSERT INTO `ecs_goods` VALUES ('19', '4', 'ECS000019', 'test', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417734271', '100', '0', '0', '0', '0', '0', '0', '1417734271', '0', '', '-1', '-1', '0', null, '', '0', '', '', '', '', '', '', '0.00', '', '1417680000', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('18', '4', 'ECS000018', 'test', '+', '0', '0', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417734049', '100', '0', '0', '0', '0', '0', '0', '1417734049', '0', '', '-1', '-1', '0', null, '', '0', '', '', '', '', '', '', '0.00', '', '1417680000', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('17', '6', 'ECS000017', 'zxxxx', '+', '1', '0', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417726778', '100', '0', '0', '0', '0', '0', '0', '1417726778', '0', '', '-1', '-1', '0', null, '', '0', '', '', '', '', '', '', '0.00', '', '1417680000', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('35', '1', 'ECS000020', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417974361', '100', '1', '0', '0', '0', '0', '0', '1417975128', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('36', '1', 'xx55', 'testname', '+', '0', '3', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417977547', '100', '0', '0', '0', '0', '0', '0', '1417977547', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('37', '1', 'ECS000037', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417978093', '100', '0', '0', '0', '0', '0', '0', '1417978093', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('38', '4', 'xxx666', '实验家具', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417987448', '100', '0', '0', '0', '0', '0', '0', '1417987448', '0', '', '-1', '-1', '0', null, '实验家具en', '0', '', '', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('39', '9', 'xxx6666', '实验家具', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', 'images/201412/thumb_img/39_thumb_G_1417987608231.jpg', 'images/201412/goods_img/39_G_1417987608634.jpg', 'images/201412/source_img/39_G_1417987608145.png', '1', '', '0', '0', '0', '0', '1417987607', '100', '0', '0', '0', '0', '0', '0', '1417987607', '0', '', '-1', '-1', '0', null, '实验家具', '0', '', '', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('40', '6', 'ECS000040', 'nanmesdsdd', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417987951', '100', '0', '0', '0', '0', '0', '0', '1417987951', '0', '', '-1', '-1', '0', null, 'nanmesdsdd_en', '0', '', '', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('41', '3', 'testsss', 'testsss', '+', '0', '1', '', '100', '50.000', '0.00', '10010.01', '0.00', '0', '0', '10', '', '', '<p>&nbsp;dddddssss</p>', 'images/201412/thumb_img/41_thumb_G_1417988084491.jpg', 'images/201412/goods_img/41_G_1417988084763.jpg', 'images/201412/source_img/41_G_1417988084226.png', '1', '', '0', '0', '0', '0', '1417988084', '100', '0', '0', '0', '0', '0', '0', '1417988084', '0', '', '-1', '-1', '0', null, 'testsss', '0', '', 'ml', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', '');
INSERT INTO `ecs_goods` VALUES ('42', '6', 'etssd', 'etssd', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', 'images/201412/thumb_img/42_thumb_G_1417988287058.jpg', 'images/201412/goods_img/42_G_1417988287166.jpg', 'images/201412/source_img/42_G_1417988287930.png', '1', '', '0', '0', '1', '0', '1417988287', '100', '0', '0', '0', '0', '0', '0', '1417988287', '0', '', '-1', '-1', '0', null, 'etssd', '0', '', '', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', 'upload/goods/1417988283784033955.sql');
INSERT INTO `ecs_goods` VALUES ('43', '1', 'ECS000043', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('44', '1', 'ECS000044', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('45', '1', 'ECS000045', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('46', '1', 'ECS000046', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('47', '1', 'ECS000047', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('48', '1', 'ECS000048', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('49', '1', 'ECS000049', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988666', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('50', '1', 'ECS000050', '', '+', '0', '0', '', '0', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988758', '100', '1', '0', '0', '0', '0', '0', '1417988853', '0', '', '-1', '-1', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('51', '1', 'xx55', 'testname', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('52', '1', 'xx55', 'testname1', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('53', '1', 'xx55', 'testname2', '+', '1', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('54', '1', 'xx55', 'testname3', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('55', '1', 'xx55', 'testname4', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('56', '1', 'xx55', 'testname5', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('57', '1', 'xx55', 'testname6', '+', '1', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417988887', '100', '0', '0', '0', '0', '0', '0', '1417988887', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('58', '2', 'xx55', '中文名称', '+', '0', '3', '', '0', '0.000', '0.00', '10000.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417992569', '100', '0', '0', '0', '0', '0', '0', '1417992569', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, '后昂', '0', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('59', '6', 'ECS000059', 'test', '+', '0', '1', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', '', '0', '0', '0', '0', '1417994949', '100', '0', '0', '0', '0', '0', '0', '1417994949', '0', '', '-1', '-1', '0', null, 'test', '0', '', '', '', '', '', '', '0.00', '', '1417939200', '0.00', '0', '0', 'upload/goods/1417994949081002985');
INSERT INTO `ecs_goods` VALUES ('60', '2', 'xx55', '中文名称', '+', '0', '3', '', '0', '0.000', '0.00', '10000.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417995976', '100', '0', '0', '0', '0', '0', '0', '1417995976', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, '后昂', '0', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('61', '2', 'xx55', '中文名称', '+', '0', '3', '', '0', '0.000', '0.00', '10000.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417996009', '100', '0', '0', '0', '0', '0', '0', '1417996009', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, '后昂', '0', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('62', '2', 'xx55', '中文名称', '+', '0', '3', '', '0', '0.000', '0.00', '10000.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417996044', '100', '0', '0', '0', '0', '0', '0', '1417996044', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, '后昂', '0', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('63', '2', 'xx55', '中文名称', '+', '0', '3', '', '0', '0.000', '0.00', '10000.00', '0.00', '0', '0', '1', '', '', '', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997043', '100', '0', '0', '0', '0', '0', '0', '1417997043', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, '后昂', '0', '0.00', '0', '0', null);
INSERT INTO `ecs_goods` VALUES ('64', '1', 'xx55', 'testname', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997537', '100', '0', '0', '0', '0', '0', '0', '1417997537', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('65', '1', 'xx55', '产品名称', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997537', '100', '0', '0', '0', '0', '0', '0', '1417997537', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('66', '1', 'xx55', '产品名称', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997537', '100', '0', '0', '0', '0', '0', '0', '1417997537', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('67', '1', 'xx55', 'testname3', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997537', '100', '0', '0', '0', '0', '0', '0', '1417997537', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('68', '1', 'xx55', 'testname4', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997538', '100', '0', '0', '0', '0', '0', '0', '1417997538', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('69', '1', 'xx55', 'testname5', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997538', '100', '0', '0', '0', '0', '0', '0', '1417997538', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('70', '1', 'xx55', 'testname6', '+', '1', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997538', '100', '0', '0', '0', '0', '0', '0', '1417997538', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('71', '1', 'xx55', 'testname', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997826', '100', '0', '0', '0', '0', '0', '0', '1417997826', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('72', '1', 'xx55', '产品名称', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997826', '100', '0', '0', '0', '0', '0', '0', '1417997826', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('73', '1', 'xx55', '产品名称', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997826', '100', '0', '0', '0', '0', '0', '0', '1417997826', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('74', '1', 'xx55', 'testname3', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997827', '100', '0', '0', '0', '0', '0', '0', '1417997827', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('75', '1', 'xx55', 'testname4', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997827', '100', '0', '0', '0', '0', '0', '0', '1417997827', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('76', '1', 'xx55', 'testname5', '+', '0', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997827', '100', '0', '0', '0', '0', '0', '0', '1417997827', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `ecs_goods` VALUES ('77', '1', 'xx55', 'testname6', '+', '1', '3', '', '0', '0.000', '0.00', '1000.00', '0.00', '0', '0', '1', '', '', 'ddsd', '', '', '', '1', 'virtual_card', '1', '1', '0', '0', '1417997827', '100', '0', '0', '0', '0', '0', '0', '1417997827', '0', '', '-1', '-1', null, null, 'testenname', null, null, 'ml', null, null, null, null, null, null, null, null, null, null, null);
