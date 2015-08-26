str='insert into ecs_brand set brand_id=%d,brand_name="%s",brand_desc="";'

fi=open('maiyibrand.txt')
brandlist=[]
for brand in fi:
    brandlist.append(brand[:-1])

print len(brandlist)

for i in range(41,150):
    print str%(i,brandlist[i-41])

