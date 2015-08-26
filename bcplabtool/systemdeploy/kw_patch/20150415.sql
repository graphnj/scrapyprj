

ALTER TABLE `ecs_brand` ADD COLUMN `brand_contact`  varchar(300)  NOT NULL DEFAULT '';
ALTER TABLE `ecs_brand` ADD COLUMN `brand_remark`   varchar(300)  NOT NULL DEFAULT '';
ALTER TABLE `ecs_brand` ADD COLUMN `brand_issupp`  boolean  DEFAULT false;

ALTER TABLE `ecs_suppliers` modify COLUMN `suppliers_contact`  varchar(300)  NOT NULL DEFAULT '';
ALTER TABLE `ecs_suppliers` ADD COLUMN `suppliers_remark`   varchar(300)  NOT NULL DEFAULT '';
ALTER TABLE `ecs_suppliers` modify COLUMN `suppliers_desc`   text;


ALTER TABLE `ecs_suppliers_brand_rel` ADD COLUMN `discnt_vat17`  decimal(3,2) NOT NULL default '1.00';
ALTER TABLE `ecs_suppliers_brand_rel` ADD COLUMN `discnt_invoice` decimal(3,2) NOT NULL default '1.00';
ALTER TABLE `ecs_suppliers_brand_rel` ADD COLUMN `discnt_noinvoice`  decimal(3,2) NOT NULL default '1.00';


ALTER TABLE `ecs_goods` MODIFY COLUMN `goods_desc`  mediumtext NOT NULL DEFAULT '';
ALTER TABLE `ecs_goods_cat` MODIFY COLUMN `cat_id`  int(11) UNSIGNED NOT NULL DEFAULT 0;














