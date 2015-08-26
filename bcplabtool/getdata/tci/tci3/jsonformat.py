#encoding:utf8

import json
import  codecs, sys

name='tci00005.json'

name='tciprodv3.json'
f=open(name,'r')
of=open(name+'.txt','w')
for line in f:
    dictdata=json.loads(line)
    out=json.dumps(dictdata,indent=4, ensure_ascii=False).encode('utf8')
    of.write(out+'\n')
	
of.close()

'''
for i in [1]:
	name='tci0000'+str(i)+'.json'
	f=open(name,'r')
	of=open(name+'.txt','w')
	for line in f:
		dictdata=json.loads(line)
		out=json.dumps(dictdata,indent=4).encode('utf8')
		of.write(out+'\n')
	
	of.close()
        '''
'''	
for i in [1,2,3,4,5]:
	name='tci0000'+str(i)+'.json'
	f=codecs.open(name,'r',encoding='utf8')
	of=codecs.open(name+'.txt','w', encoding='utf8')
	for line in f:
		dictdata=json.loads(line)
		out=json.dumps(dictdata,indent=4, ensure_ascii=False)
		of.write(out+'\n')
	
	of.close()
'''
