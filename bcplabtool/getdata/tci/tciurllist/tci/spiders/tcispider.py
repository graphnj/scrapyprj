# -*- coding: utf-8 -*-
from scrapy.spider import BaseSpider
from scrapy.selector import HtmlXPathSelector 
from scrapy.utils.url import urljoin_rfc 
from scrapy.http import Request 
from tci.items import TciItem
from scrapy.selector import Selector
from scrapy.shell import inspect_response
import urllib,urllib2,httplib,json
import logging
import bs4
import re,string


logging.basicConfig(level=logging.ERROR)
log=logging.getLogger('tcispider')

class tciSpider(BaseSpider):
    name = "tciv2"
    '''
功能材料
有机合成化学
生物科学
分析化学
化学结构
'''
    defaulturl=   "http://www.tcichemicals.com/eshop/zh/cn/catalog/keyword_initial/"
    start_urls = [
     ]

    m_handledlist=[]
    def __init__(self, *args, **kwargs):
        print "init"

        print self.start_urls    
        self.m_handledlist=[]
        try:
            fi=open('urllist.txt')
            if fi:
                urllist=fi.read().split('\n')
                for url in urllist:
                    self.start_urls.append(url)
        except:
            log.debug('file handledlist notexist')
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


    def parse(self,response):
        #content = content.encode('utf8')
        item=TciItem()
        item['catalog1']=''
        item['catalog2']=''
        item['catalog2url']=''
        
        #inspect_response(response, self)
        item['produrl']=response.url
        log.debug('produrl=%s',item['produrl'])
        commid=response.xpath('//input[@id="commodityCode"]/@value')[0].extract()

        setcookielist=response.headers.getlist('Set-Cookie')
        cookie={}
        for ck in setcookielist:
            if ck[:5]=='JSESS':
                cookie['JSESSIONID']=ck.split(';')[0].split('=')[1]
                log.info('use JSESSIONID=%s',cookie['JSESSIONID'])

        item['speclist']=self.getpricejson(commid,cookie)
        #inspect_response(response, self)

        soup=bs4.BeautifulSoup(response.body)
        pagetitle=soup.find_all(id="page-title")
        if pagetitle:
            #delete the 2nd line of chinese desc
            #we use xpath to extract enname, but there <i><small> etc. in page-title, it's truncated, :(  --zhu.jinhua 20150730
            enname=re.sub('\n.*','',pagetitle[0].text)
            item['enname']=enname
        #item['cnname']=response.xpath('//table[@class="syg-tbl"]/tr/td/text()')[0].extract()

        '''tempforcnname=response.xpath('//table[@class="syg-tbl"]/tr')
        item['cnaliasname']=[]
        for tr in tempforcnname:
            if u'中文名'==tr.xpath('th/text()')[0].extract():
                item['cnname']=tr.xpath('td/text()')[0].extract()

            if u'中文别名'==tr.xpath('th/text()')[0].extract():
                item['cnaliasname'].append(tr.xpath('td/text()')[0].extract())'''


        item['casno']=response.xpath('//table[@class="base-tbl"]/tr')[4].xpath('td/span/text()').extract()

        sygtbl=soup.find_all("table",attrs={"class":"syg-tbl"})
        if sygtbl:
            #sygtbl[0].text=
            #u'\n\n\u522b\u540d (\u82f1\u6587)\nL-Ascorbyl 2,6-Dipalmitate\n\n\n\u4e2d\u6587\u540d\n2,6-\u4e8c-O-\u68d5\u6988\u9170-L-\u6297\u574f\u8840\u9178\n\n\n\u4e2d\u6587\u522b\u540d\nL-\u6297\u574f\u8840\u9178-2,6-\u4e8c\u68d5\u6988\u9178\u916f\n\n'

            namelist=re.sub('^\n+|\n+$','',sygtbl[0].text).split('\n\n\n')
            item['cnname']=''
            item['cnaliasname']=''
            for name in namelist:
                #对于例外的\n要删除几转成需要的个数。前面已假定三个\n为每条记录的分割。一个\n为pair间的分割
                namepair=re.sub('\n+','\n',re.sub('^\n+|\n+$','',name)).split('\n')
                if u'中文名'==namepair[0] and len(namepair)>1:
                    item['cnname']=namepair[1]
                if u'中文别名'==namepair[0] and len(namepair)>1:
                    item['cnaliasname']+=namepair[1]+'; '


        '''purityxpath=response.xpath('//div[@id="tabPanel01"]//div[@class="section-box bobW pb10"]')[0].xpath('table[@class="base-tbl"]//tr')
        purity=''
        for tr in purityxpath:
            purity+=tr.xpath("th/span/text()")[0].extract()+': '+tr.xpath("td/span/text()")[0].extract()+'; '
        item['purity']=purity'''
        
        sectionbox=response.xpath('//div[@id="tabPanel01"]//div[@class="section-box bobW pb10"]')
        purity=''
        for tabpanel in sectionbox:
            title=tabpanel.xpath('h3/text()')[0].extract()
            if title == u'规格':
                trs=tabpanel.xpath('table[@class="base-tbl"]//tr')
                for tr in trs:
                    purity+=tr.xpath("th/span/text()")[0].extract()+': '+tr.xpath("td/span/text()")[0].extract()+'; '
        item['purity']=purity
        
        return item
    def parsecatalog2url(self,response):
        #log.msg('respdata='+str(response))
        #items = []
        item = response.meta['item']
        #inspect_response(response, self)
        urllist=response.xpath('//dl[@class="chem-name"]/dd/a/@href').extract()
        #items.append(item)
        #log.msg('url==='+str(item['produrl']))
        #inspect_response(response, self)
        for url in urllist:
            commid= url.split('/')[-2]
            #if commid!='O0157':
                #log.info('commid='+commid)
            #    continue
            urlall=urljoin_rfc('http://www.tcichemicals.com/', url)
            log.debug('urlall='+urlall+'   len(m_handledlist)='+str(len(self.m_handledlist)))
            if self.m_handledlist and urlall not in self.m_handledlist:
                log.debug('skip:'+urlall)
                continue
            yield Request(urlall,meta={'item':item},callback=self.parseProdPage)

        #return item
    def parse111(self, response):
        items = []

        alllist=open('alllist.txt').read().split('\n')
        handlecount=0
        for r in alllist:
            pair=r.split('-')
            char=pair[0][0]
            start=int(pair[0][1:5])
            end=int(pair[1][1:5])
            for i in range(start,end+1):
                sn=char+'%04d'%(i)
                #print 'handledlist:',len(self.m_handledlist)
                if sn in self.m_handledlist:
                    #print 'skip sn:',sn
                    continue
                produrl='http://www.tcichemicals.com/eshop/zh/cn/commodity/'+sn+'/'
                handlecount+=1

                yield Request(produrl, callback=self.parseProd)
                
                #print produrl
        return


