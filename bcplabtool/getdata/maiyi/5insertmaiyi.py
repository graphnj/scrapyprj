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
goods_id_start=10131000

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
`bonus_type_id`, `last_update`, `goods_type`, `suppliers_id`, `goods_en_name`, `goods_casno`, `goods_reg_spec`, `goods_reg_specid`,`shop_price`,`goods_desc`,`goods_img`,`goods_thumb`,`original_img`) \
    VALUES ("%s", "%s", "%s", "%s", %d, "", 1, 0.000, \
    1, "%s", 1, 1,     1, 0, 0, 1439631888, 100, \
    0, 1439631888, 0, 0, "%s", "%s", "%s", NULL,"%s","%s","%s","%s","%s");'''

goods_attr_sql_template="INSERT INTO `ecs_goods_attr` (`goods_id`,`attr_id`,`attr_value`,`attr_price`)VALUES ('%s', '3413', '%s', '%s');"

        
str_goods_memberprice_template='''INSERT INTO `ecs_member_price` VALUES (0, '%s', '1', '1.00', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '2', '0.95', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '3', '0.90', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '4', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '5', '0.80', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '6', '0.85', '0.00');
INSERT INTO `ecs_member_price` VALUES (0, '%s', '7', '0.75', '0.00');'''


f=open('insertmaiyiprod.sql','w')


def ForTCI():

    catmap={}
    fcatmap=codecs.open('cat.txt',encoding='utf8')
    for l in fcatmap:
        #print 'line:',l
        onecat=l.split()
        #print onecat
        if len(onecat)>=2:
            catmap[onecat[0]]=onecat[-1]
            #print onecat[0],onecat[-1]

    branddict={
u"HACH哈希":      41,
u"ALP":      42,
u"ATAGO爱拓":      43,
u"BINDER宾得":      44,
u"Brookfield博勒飞":      45,
u"Enwave恩威":      46,
u"GBC":      47,
u"ALALIS安莱立思":      48,
u"IKA仪科":      49,
u"JEIOTECH杰奥特":      50,
u"KEEZO":      51,
u"Lovibond 罗维朋":      52,
u"MEMMERT美墨尔特":      53,
u"METTLER梅特勒":      54,
u"OHAUS奥豪斯":      55,
u"SARTORIUS赛多利斯":      56,
u"UNICO尤尼柯":      57,
u"VELP":      58,
u"X-Rite爱色丽":      59,
u"YAMATO雅马拓":      60,
u"艾本德":      61,
u"澳柯玛":      62,
u"保定兰格":      63,
u"北京东西分析":      64,
u"北京六一":      65,
u"北京中惠普":      66,
u"常州国华":      67,
u"长城科工贸":      68,
u"成都金凤":      69,
u"岛津":      70,
u"德国普兰德":      71,
u"德国耶拿":      72,
u"德图仪器":      73,
u"海门其林贝尔":      74,
u"湖南湘仪":      75,
u"吉大小天鹅":      76,
u"精科实业":      77,
u"昆山舒美":      78,
u"立德泰勀":      79,
u"美国YSI":      80,
u"美国精骐":      81,
u"美析（中国）":      82,
u"宁波新芝":      83,
u"青岛海尔Haier":      84,
u"青浦沪西":      85,
u"上光六厂":      86,
u"上海安亭":      87,
u"上海昂尼":      88,
u"上海彼爱姆（BM）":      89,
u"上海标模":      90,
u"上海博迅":      91,
u"上海昌吉":      92,
u"上海大龙":      93,
u"上海菲恰尔":      94,
u"上海光谱":      95,
u"上海和泰":      96,
u"上海恒平":      97,
u"上海黄海药检":      98,
u"上海慧泰":      99,
u"上海嘉鹏科技有限公司":     100,
u"上海锦凯":     101,
u"上海精宏":     102,
u"上海精科（上分）":     103,
u"上海精科天美":     104,
u"上海精科（物光）":     105,
u"上海菁海":     106,
u"上海菁华":     107,
u"上海科导":     108,
u"上海雷磁":     109,
u"上海棱光":     110,
u"上海良平":     111,
u"上海龙跃":     112,
u"上海美谱达":     113,
u"上海沛欧":     114,
u"上海纤检":     115,
u"上海全浦":     116,
u"上海三申":     117,
u"上海三信":     118,
u"上海申安":     119,
u"上海申光":     120,
u"上海司乐":     121,
u"上海天能":     122,
u"上海伟业":     123,
u"上海现代环境":     124,
u"上海新嘉":     125,
u"上海昕瑞":     126,
u"上海欣茂":     127,
u"上海雅谭":     128,
u"上海亚荣":     129,
u"上海易测":     130,
u"上海元析":     131,
u"上海越平":     132,
u"上海跃进":     133,
u"苏净仪器自控设备有限公司":     134,
u"苏州安泰":     135,
u"苏州净化":     136,
u"天大天发":     137,
u"天津港东":     138,
u"天津恒奥":     139,
u"伊尔姆":     140,
u"致微仪器":     141,
u"中科美菱":     142,
            }


    tcirecord=codecs.open('maiyi20150815noyiheng.json',encoding='utf8')

    goods_index=0



    for line in tcirecord:


        oneprod=json.loads(line)

        #print oneprod

        #7769-79-1@2-氨基十六烷酸@2-Aminohexadecanoic acid@AL145@95%@九鼎化学@AL145-1g:¥950.00|AL145-5g:¥3525.00@

        #1150114-77-4@4-Cyano-2-fluorophenylboronic acid  4-氰基-2-氟苯硼酸@4-Cyano-2-fluorophenylboronic acid@44539@4-Cyano-2-fluorophenylboronic acid, 97%@AcrosOrganics@(445390010)1 GR:7613@


        #(goods_id, cnname,enname,goods_sn, goods_name, keyword包装,goods_casno,goods_reg_spec)

        cnname=oneprod['cnname']#oneprod[4]+oneprod[1]

        if len(cnname)>200:
            print "too long cnname:",cnname
        enname=''#oneprod['enname']
        cnaliasname=''
        casno=''


        goods_sn=oneprod['goods_sn']
        #print goods_index,' casno:',oneprod['casno']

        #if oneprod['casno']:
        #    casno=oneprod['casno'][0]

        purity=oneprod['purity'].replace('"','\\"')

        #print ('%s'%(goods_id_start+goods_index), oneprod[1],cnname,oneprod[4],oneprod[0],oneprod[2])

        #dbrecordvalues.append(('%s'%(goods_id_start+goods_index), oneprod[1],u'%s'%(cnname),oneprod[4],oneprod[0],u'%s'%(oneprod[2])))

        #print type(cnname),type(oneprod[4]),type(oneprod[2])

        goods_id=goods_id_start+goods_index

        #AcrosOrganics,FisherSci,MaybridgeBB,BioReagents,FisherLCMS

        brand_id=branddict[oneprod['brand']]
        #print "catalog:"+oneprod['catalog2']
        catid=catmap[oneprod['catalog2']]
        price=oneprod['price'].replace(',','')
        goods_desc=oneprod['goods_desc_prod'].replace('"','\\"')+'<br>'+oneprod['goods_desc_para'].replace('"','\\"')
        #print "catalog:"+oneprod['catalog2']+"  goodsid:"+str(goods_id)+"  desc len="+str(len(goods_desc))
        imgpath=oneprod['goods_img']
        onerecordpara=('%s'%(goods_id), catid, goods_sn,cnname, brand_id, cnaliasname, enname, casno, purity, price, goods_desc, imgpath, imgpath, imgpath)

        prodrecord=str_goods.decode('utf8')%onerecordpara

        prodrecord=prodrecord.encode('utf8')

        f.write(prodrecord+'\n')



        '''speclist=oneprod['speclist']

        for attr in speclist:

            spec=attr['catalog']

            price=attr['catalogprice']


            goods_attr_sql=goods_attr_sql_template%(goods_id,spec,price)

            f.write(goods_attr_sql+'\n')
'''

        str_goods_memberprice=str_goods_memberprice_template%(goods_id,goods_id,goods_id,goods_id,goods_id,goods_id,goods_id)

        f.write(str_goods_memberprice+'\n')



        goods_index+=1


if __name__ == '__main__':
    #test()
    #initcasname()
    
    ForTCI()
    
    os.system('pause')
