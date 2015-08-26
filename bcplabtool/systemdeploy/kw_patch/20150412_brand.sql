

ALTER TABLE `ecs_brand` ADD COLUMN `brand_contact`  varchar(300) DEFAULT '';
ALTER TABLE `ecs_brand` ADD COLUMN `brand_remark`   varchar(300) DEFAULT '';
ALTER TABLE `ecs_brand` ADD COLUMN `brand_is_supp`  boolean  NOT NULL DEFAULT false;


ALTER TABLE `ecs_goods` MODIFY COLUMN `goods_desc`  mediumtext NOT NULL DEFAULT '';
ALTER TABLE `ecs_goods_cat` MODIFY COLUMN `cat_id`  int(11) UNSIGNED NOT NULL DEFAULT 0;














