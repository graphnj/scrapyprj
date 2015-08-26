# -*- coding: utf-8 -*-

# Define here the models for your scraped items
#
# See documentation in:
# http://doc.scrapy.org/en/latest/topics/items.html

from scrapy.item import Item, Field


class BcpItem(Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    catalog1=Field()#一级分类
    catalog2=Field()#二级分类
    catalog2url=Field()#二级url
    produrl=Field()#本产品的url
    cnname=Field()#中文名
    enname=Field()#英文名
    cnaliasname=Field()#中文别名
    casno=Field()#casno
    goods_sn=Field()#货号
    brand=Field()#品牌
    price=Field()#无标配时商品价格
    purity=Field()#纯度
    speclist=Field()#规格&price
    goods_desc_prod=Field()#描述，简介
    goods_desc_para=Field()#描述参数
    goods_img=Field()#goods image
    desc=Field()
