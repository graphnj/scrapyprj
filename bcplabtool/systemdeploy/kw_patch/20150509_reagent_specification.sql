DROP TABLE IF EXISTS `ecs_reagent_specifications`;
CREATE TABLE `ecs_reagent_specifications` (
`id`  int(8) unsigned NOT NULL auto_increment,
`Name`  varchar(200) NOT NULL default '',
`CASID`  varchar(50) NOT NULL default '',
`Concentration`  varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
)  ENGINE=innodb;

ALTER TABLE `ecs_goods` ADD COLUMN `goods_casno`  varchar(40) default NULL;

ALTER TABLE `ecs_goods` ADD COLUMN `goods_reg_spec`  varchar(100) default NULL;
ALTER TABLE `ecs_goods` ADD COLUMN `goods_reg_specid`  varchar(100) default NULL;