

-- 20150319
-- insert into ecs_goods_type( cat_id,cat_name,enabled,attr_group) select cat_id,cat_name,1,'' from ecs_category where cat_id not in (select parent_id from ecs_category);


/* 20150320 begin */
ALTER TABLE `ecs_goods` MODIFY COLUMN `goods_type`  int(11) UNSIGNED NOT NULL DEFAULT 0;

insert into ecs_attribute( cat_id,attr_name,attr_input_type,attr_type,attr_values,attr_index,is_linked) select cat_id,'标配',0,1,'',1,1 from ecs_goods_type;

insert into ecs_attribute( cat_id,attr_name,attr_input_type,attr_type,attr_values) select cat_id,'选配',0,2,'' from ecs_goods_type;
/* 20150320 end */

