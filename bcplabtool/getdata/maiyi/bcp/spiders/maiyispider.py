# -*- coding: utf-8 -*-
from scrapy.spiders import Spider
from scrapy.selector import HtmlXPathSelector 
from scrapy.utils.url import urljoin_rfc 
from scrapy.http import Request 
from bcp.items import *
from scrapy.selector import Selector
from scrapy.shell import inspect_response
import urllib,urllib2,httplib,json
import logging
import bs4
import re,os


logging.basicConfig(level=logging.ERROR)
log=logging.getLogger('tcispider')

class maiyiSpider(Spider):
    name = "maiyi"
    start_urls = ["http://www.sh17.com/chanpin" ]
    #start_urls = ["http://www.sh17.com/site/left/81"]

    m_handlelist=[]
    def __init__(self, *args, **kwargs):
        print "init"
        self.m_handlelist=[]#open('nullcnname.txt').read().split('\n')

    def getpricejson(self,commodityid,cookie):
        #定义需要进行发送的数据      
        params = urllib.urlencode({'commodityCode':commodityid  });       
        #定义一些文件头      
        headers = {"Content-Type":"application/x-www-form-urlencoded",       
           "Connection":"Keep-Alive",
        "Accept":"application/json, text/javascript, */*; q=0.01",
        "Origin":"http://www.tcichemicals.com",
        "User-Agent":"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.107 Safari/537.36",
        "Content-Type":"application/x-www-form-urlencoded",
        "Accept-Encoding":"gzip, deflate",
        "Referer":"http://www.tcichemicals.com/eshop/zh/cn/commodity/"+commodityid+"/",
        "cookie":"JSESSIONID="+cookie['JSESSIONID']+"; WS-ID=MUqirffH%24Jc%3D"
#        "cookie":"JSESSIONID=6B0B3133A0A4E51E0FEAF2559657C516; WS-ID=MUqirffH%24Jc%3D"
        }; 
        #conn 与网站构建一个连接      
        conn = httplib.HTTPConnection("www.tcichemicals.com");       
        #tci要求用的POST   
        conn.request(method="POST",url="/eshop/ajax/catalog/price_stock/init",body=params,headers=headers);       
        #返回处理后的数据  ，只能read一次    
        try:
            jsonres = conn.getresponse().read(); 
            #print 'header:',headers
            print 'response:',jsonres
            dictres=json.JSONDecoder().decode(jsonres)
            speclist=[]
            for sku in dictres["skuList"]:
                onerecord={}
                onerecord['catalog']=sku['skuCode']
                onerecord['catalogprice']=sku['catalogPrice'][:-4].replace(',','')
                speclist.append(onerecord)
            return speclist
        except:
            return []


    def parseProdPage(self,response):
        #content = content.encode('utf8')
        item = response.meta['item']
        #inspect_response(response, self)
        item['produrl']=response.url
        log.debug('recv prod response from '+response.url)
        div_intro1_li_list=response.xpath('//div[@class="intro1"]//li')
        for linode in div_intro1_li_list:
            spanname=linode.xpath('span/text()').extract()
            if spanname:
                log.debug('spanname='+spanname[0].encode('utf8'))
                if u'制造商型号：'==spanname[0]:
                    item['goods_sn']=linode.xpath('b/text()').extract()[0]
                if u'品　　　牌：'==spanname[0]:
                    item['brand']=linode.xpath('a/text()').extract()[0]
        marketprice=response.xpath('//div[@class="intro1"]/ul[@class="ul1"]/li/b/text()').extract()
        #inspect_response(response, self)
        item['price']=''
        if marketprice:
            item['price']=marketprice[0][1:]

        '''desc=response.xpath('//div[@class="desc"]')
        if len(desc)>0:
            item['goods_desc_prod']=desc[0].extract()
        if len(desc)>1:
            item['goods_desc_para']=desc[1].extract()
        '''
        desc=response.xpath('//div[@id="e_con0"]/div[@class="desc"]').extract()[0]
        bsoup=bs4.BeautifulSoup(desc,"lxml")
        item['goods_desc_prod']=''.join(bsoup.text.replace('\n','<br>').replace(u'特 点',u'<h3><red>特 点<red></h3>'))
        desc=response.xpath('//div[@id="e_con1"]/div[@class="desc"]').extract()[0]
        #规格参数格式简单，有些是表格，为了展示表格，就要将html保存下来，但对那些不是表格的也成了保存html了
        item['goods_desc_para']=desc

        image_path=response.xpath('//a[@class="cloud-zoom"]/@href').extract()[0]
        imagefilename=image_path.split('/')[-1]
        item['goods_img']='images/201508/images/'+imagefilename
        imageurlall=urljoin_rfc('http://www.sh17.com',image_path)
        localfile=os.path.join('images',imagefilename)
        urllib.urlretrieve(imageurlall,localfile)
        log.debug('produrl=%s, price=%s',item['produrl'],item['price'])

        return item

    def parsecatalog2url(self,response):
        #log.msg('respdata='+str(response))
        #items = []
        item = response.meta['item']
        

        #inspect_response(response, self)
        if response.url.find('?')<0:
            #每个分类的第一页，需要获取其余页urllist
            totalpageli=response.xpath('//li[@class="last"]/a/@href').extract()
            if totalpageli:
                lastp=totalpageli[0]#/site/left/388?Node_page=2
                try:
                    lastpage=int(lastp.split('=')[-1])
                except:
                    log.error('get last page fail.'+lastp)
                for p in range(2,lastpage+1):
                    tempurl = response.url+'?Node_page='+str(p)
                    yield Request(tempurl,meta={'item':item},callback=self.parsecatalog2url)

        #item = response.meta['item']
        #inspect_response(response, self)
        #urlnodelist=response.xpath('//tr/td[@rowspan="2"]/h3/a')
        urlnodelist=response.xpath('//div[@class="kind_table"]//tr')
        #items.append(item)
        #log.msg('url==='+str(item['produrl']))
        #inspect_response(response, self)
        for urlnode in urlnodelist:
            url=urlnode.xpath('td[@rowspan="2"]/h3/a/@href').extract()
            if not url:
                continue
            item = response.meta['item']
            proditem=BcpItem()
            proditem['catalog2']=item['catalog2']
            proditem['catalog2url']=item['catalog2url']
            url=url[0]


            urlall=urljoin_rfc('http://www.sh17.com/', url)
            log.debug('prod url='+urlall+'   urllist count='+str(len(urlnodelist)))
            if self.m_handlelist and urlall not in self.m_handlelist:
                log.debug('skip:'+urlall)
                continue
            proditem['produrl']=urlall
            proditem['cnname']=urlnode.xpath('td[@rowspan="2"]/h3/a/text()').extract()[0]
            goodspara=urlnode.xpath('td[4]').extract()
            proditem['purity']=''
            if goodspara:
                para=goodspara[0]
                proditem['purity']=bs4.BeautifulSoup(para,"lxml").text.replace('\n',' ')
            log.debug('cnname='+proditem['cnname'])
            
            yield Request(proditem['produrl'],meta={'item':proditem},callback=self.parseProdPage)

    
    
    def parse(self, response):
        items = []

        #inspect_response(response, self)
        #temp=response.xpath('//div[@class="section-box  mt10"]//ul/li/p/a')
        #catalog1=temp[0].xpath('span/text()').extract()
        
        #inspect_response(response, self)
        temp=response.xpath('//div[@class="kind_contant"]//dl/dd/p/a')
        #catalog2list=temp[1:].xpath('text()').extract()
        #catalog2urllist=temp[1:].xpath('@href').extract()

        #inspect_response(response, self)
        #for i in range(1):#len(catalog2urllist)):
        for node in temp:
            item = BcpItem()
            #item['catalog1'] = ''
            cat2=node.xpath('text()').extract()[0]
            cat2url=node.xpath('@href').extract()[0]

            #if cat2url.split('/')[-1]!='81':
            #    #test code
            #    continue

            #inspect_response(response, self)
            log.debug('cat2:'+cat2+'   url:'+cat2url)
            item['catalog2'] = cat2
            tempurl = urljoin_rfc('http://www.sh17.com/', cat2url)
            item['catalog2url']=tempurl#.replace('catalog/keyword_index','category_index')[:-6]
            #i=i+1
            #item['title'] =  title[i][:-1]
            items.append(item)

            yield Request(item['catalog2url'],meta={'item':item},callback=self.parsecatalog2url)
        #return items
        #    items.append(item)
        '''for item in items[0:1]:
            log.debug('catalog2url='+str(item['catalog2url']))
            yield Request(item['catalog2url'],meta={'item':item},callback=self.parsecatalog2url)
'''


