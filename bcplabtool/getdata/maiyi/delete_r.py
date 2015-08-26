
fi=open('maiyi20150815noyihengr.json')
fo=open('maiyi20150815noyiheng.json','w')
for i in fi:
    str=i.replace('\\r\\n','').replace('\\r','')
    fo.write(str)
