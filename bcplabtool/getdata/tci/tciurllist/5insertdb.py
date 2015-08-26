#encoding:utf8
'''
zhu.jinhua@20150524
从casinfo.txt读取casno于cascnname的对应关系
9dingproduct.txt中每行是一条产品记录
7769-79-1@2-氨基十六烷酸@2-Aminohexadecanoic acid@AL145@95%@九鼎化学@AL145-1g:¥950.00|AL145-5g:¥3525.00@
分别对应casno 中文名，英文名，货号goods_sn, 实际参数goods_spec,品牌， 多个规格

'''
#import MySQLdb
import os,re,json,codecs
#config
goods_id_start=10095000

brand_id=40
#config end
'''
INSERT INTO `ecs_member_price` VALUES ('3102', '10000463', '1', '1.00', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3103', '10000463', '2', '0.95', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3104', '10000463', '3', '0.90', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3105', '10000463', '4', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3106', '10000463', '5', '0.80', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3107', '10000463', '6', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES ('3108', '10000463', '7', '0.75', '0.00');

INSERT INTO `ecs_goods_attr` VALUES ('2769', '10000463', '3413', 'M132A-25g', '188');
INSERT INTO `ecs_goods_attr` VALUES ('2770', '10000463', '3413', 'M132A-100g', '550');

INSERT INTO `ecs_goods` VALUES ('10000463', '30101', 'M132A', '50-01-1test', '+', '0', '44', '', '1', '0.000', '0.00', '0.00', '0.00', '0', '0', '1', '试剂标物 化学试剂 通用试剂 M132A-25g M132A-100g', '', '', '', '', '', '1', '', '1', '1', '0', '0', '1432193879', '100', '0', '0', '0', '0', '0', '0', '1432193879', '30101', '', '-1', '-1', '0', null, '', null, null, null, null, null, null, null, null, null, null, null, null, null, '', '50-01-1', '99%', null);
'''

casnamemap={}
dbrecordvalues=[]

    
    
str_goods='''INSERT INTO `ecs_goods` (`goods_id`, `cat_id`, `goods_sn`, `goods_name`, `brand_id`, `provider_name`,  `goods_number`, `goods_weight`, \
`warn_number`, `keywords`, `is_real`, `is_on_sale`, `is_alone_sale`, `is_shipping`, `integral`, `add_time`, `sort_order`, \
`bonus_type_id`, `last_update`, `goods_type`, `suppliers_id`, `goods_en_name`, `goods_casno`, `goods_reg_spec`, `goods_reg_specid`) \
    VALUES ("%s", "30101", "%s", "%s", %d, "", 1, 0.000, \
    1, "%s", 1, 1,     1, 0, 0, 1438948246, 100, \
    0, 1438948246, 30101, 0, "%s", "%s", "%s", NULL);'''

goods_attr_sql_template="INSERT INTO `ecs_goods_attr` (`goods_id`,`attr_id`,`attr_value`,`attr_price`)VALUES ('%s', '3413', '%s', '%s');"

        
str_goods_memberprice_template='''INSERT INTO `ecs_member_price` VALUES (0, '%s', '1', '1.00', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '2', '0.95', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '3', '0.90', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '4', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '5', '0.80', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '6', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '7', '0.75', '0.00');'''


f=open('insertprod.sql','w')


def ForTCI():

    tcirecord=codecs.open('tciprodv3.json',encoding='utf8')

    goods_index=0

    tci_sn_goodsid=open('/home/mysql/db/tci_sn_goodsid.txt').read().split('\n')
    map_sngoodsid={}
    for record in tci_sn_goodsid:
        s=record.split('\t')
        if len(s)>1:
            map_sngoodsid[s[0]]=s[1]

    for line in tcirecord:


        oneprod=json.loads(line)

        #print oneprod

        #7769-79-1@2-氨基十六烷酸@2-Aminohexadecanoic acid@AL145@95%@九鼎化学@AL145-1g:¥950.00|AL145-5g:¥3525.00@

        #1150114-77-4@4-Cyano-2-fluorophenylboronic acid  4-氰基-2-氟苯硼酸@4-Cyano-2-fluorophenylboronic acid@44539@4-Cyano-2-fluorophenylboronic acid, 97%@AcrosOrganics@(445390010)1 GR:7613@


        #(goods_id, cnname,enname,goods_sn, goods_name, keyword包装,goods_casno,goods_reg_spec)

        cnname=oneprod['cnname']#oneprod[4]+oneprod[1]

        enname=oneprod['enname']

        goods_sn=oneprod['produrl'].split('/')[-2]
        #print goods_index,' casno:',oneprod['casno']
        casno=''
        if oneprod['casno']:
            casno=oneprod['casno'][0]

        purity=oneprod['purity']

        #print ('%s'%(goods_id_start+goods_index), oneprod[1],cnname,oneprod[4],oneprod[0],oneprod[2])

        #dbrecordvalues.append(('%s'%(goods_id_start+goods_index), oneprod[1],u'%s'%(cnname),oneprod[4],oneprod[0],u'%s'%(oneprod[2])))

        #print type(cnname),type(oneprod[4]),type(oneprod[2])

        goods_id=goods_id_start+goods_index

        goods_id=map_sngoodsid[goods_sn]
        print 'goodsid='+goods_id+'  sn='+goods_sn
        #AcrosOrganics,FisherSci,MaybridgeBB,BioReagents,FisherLCMS

        brand_id=40 #TCI


        onerecordpara=('%s'%(goods_id), goods_sn,cnname, brand_id,oneprod['cnaliasname'],enname,casno,purity)

        prodrecord=str_goods.decode('utf8')%onerecordpara

        prodrecord=prodrecord.encode('utf8')

        f.write(prodrecord+'\n')



        speclist=oneprod['speclist']

        for attr in speclist:

            spec=attr['catalog']

            price=attr['catalogprice']


            goods_attr_sql=goods_attr_sql_template%(goods_id,spec,price)

            f.write(goods_attr_sql+'\n')


        str_goods_memberprice=str_goods_memberprice_template%(goods_id,goods_id,goods_id,goods_id,goods_id,goods_id,goods_id)

        f.write(str_goods_memberprice+'\n')



        goods_index+=1
        if goods_index==13000:
            goods_index=45000


if __name__ == '__main__':
    #test()
    #initcasname()
    
    ForTCI()
    
    os.system('pause')
