--
-- 表的结构 `ecs_template`
--

DROP TABLE IF EXISTS `ecs_template`;
CREATE TABLE `ecs_template` (
  `filename` varchar(30) NOT NULL default '',
  `region` varchar(40) NOT NULL default '',
  `library` varchar(64) NOT NULL default '',
  `sort_order` tinyint(1) unsigned NOT NULL default '0',
  `id` smallint(5) unsigned NOT NULL default '0',
  `number` tinyint(1) unsigned NOT NULL default '5',
  `type` tinyint(1) unsigned NOT NULL default '0',
  `theme` varchar(60) NOT NULL default '',
  `remarks` varchar(30) NOT NULL default '',
  KEY `filename` (`filename`,`region`),
  KEY `theme` (`theme`),
  KEY `remarks` (`remarks`)
)  ENGINE=MyISAM;

INSERT INTO `ecs_template` (`filename`, `region`, `library`, `sort_order`, `id`, `number`, `type`, `theme`, `remarks`) VALUES
('index', '左边区域', '/library/vote_list.lbi', 8, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/email_list.lbi', 9, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/order_query.lbi', 6, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/cart.lbi', 0, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/promotion_info.lbi', 3, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/auction.lbi', 4, 0, 3, 0, 'default', ''),
('index', '左边区域', '/library/group_buy.lbi', 5, 0, 3, 0, 'default', ''),
('index', '', '/library/recommend_promotion.lbi', 0, 0, 4, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_hot.lbi', 2, 0, 200, 0, 'default', ''),   -- from 10 to 200
('index', '右边主区域', '/library/recommend_new.lbi', 1, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_best.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_instrument.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_consume_accessory.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_reagent.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_safeGuarding.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_labFurniture.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_hardware_tool.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_secondHandInstrument.lbi', 0, 0, 10, 0, 'default', ''),
('index', '右边主区域', '/library/recommend_labBuilding.lbi', 0, 0, 10, 0, 'default', ''),

('index', '左边区域', '/library/invoice_query.lbi', 7, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/top10.lbi', 2, 0, 0, 0, 'default', ''),
('index', '左边区域', '/library/category_tree.lbi', 1, 0, 0, 0, 'default', ''),
('index', '', '/library/brands.lbi', '0', '0', '11', '0', 'default', ''),
('category', '左边区域', '/library/category_tree.lbi', 1, 0, 0, 0, 'default', ''),
('category', '右边区域', '/library/recommend_best.lbi', 0, 0, 5, 0, 'default', ''),
('category', '右边区域', '/library/goods_list.lbi', 1, 0, 0, 0, 'default', ''),
('category', '右边区域', '/library/pages.lbi', 2, 0, 0, 0, 'default', ''),
('category', '左边区域', '/library/cart.lbi', 0, 0, 0, 0, 'default', ''),
('category', '左边区域', '/library/price_grade.lbi', 3, 0, 0, 0, 'default', ''),
('category', '左边区域', '/library/filter_attr.lbi', 2, 0, 0, 0, 'default', '');
