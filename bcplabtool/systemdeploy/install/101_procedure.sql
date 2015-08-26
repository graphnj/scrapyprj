
/*
zhu.jinhua @20150131  实现根据一个catid查找所有子类id的列表，如下格式
-- select queryChildCatlist(catid);  搜索catid的所有子类树
*/
DROP FUNCTION IF EXISTS queryChildCatlist;
CREATE FUNCTION `queryChildCatlist` (catid INT)
RETURNS VARCHAR(4000)
BEGIN
DECLARE sTemp VARCHAR(4000);
DECLARE sTempChd VARCHAR(4000);

SET sTemp = '$';
SET sTempChd = cast(catid as char);

WHILE sTempChd is not NULL DO
SET sTemp = CONCAT(sTemp,',',sTempChd);
SELECT group_concat(cat_id) INTO sTempChd FROM ecs_category where FIND_IN_SET(parent_id,sTempChd)>0;
END WHILE;
return sTemp;
END;



/*
zhu.jinhua @20150131  实现根据一个catid查找所有父类id的列表，如下格式
mysql>  select queryAllParentCatIdbycatid(101010017);
    select cat_id,cat_name from ecs_category where find_in_set(cat_id, queryAllParentCatIdbycatid(101010017));
+----------------------------------+
| queryAllParentCatIdbycatid(101010017) |
+----------------------------------+
| 0,1,101,10101,101010017          |
+----------------------------------+
1 row in set

+-----------+--------------+
| cat_id    | cat_name     |
+-----------+--------------+
|         1 | 仪器仪表     |
|       101 | 化学分析仪器 |
|     10101 | 色谱         |
| 101010017 | 色谱检测器   |
+-----------+--------------+
4 rows in set
*/
DROP FUNCTION IF EXISTS queryAllParentCatIdbycatid;
CREATE FUNCTION `queryAllParentCatIdbycatid` (catid INT)
RETURNS VARCHAR(4000)
BEGIN
    DECLARE sTemp VARCHAR(4000);
    DECLARE sTempParent VARCHAR(4000);

    SET sTempParent = cast(catid as char);
    SET sTemp = sTempParent;

    WHILE sTempParent!=0 DO
    SELECT parent_id INTO sTempParent FROM ecs_category where sTempParent=cat_id;
    SET sTemp = CONCAT(sTempParent,',',sTemp);
    END WHILE;
    return sTemp;
END;
    

    

/* zhu.jinhua @20150131  实现根据一个catid查找所有父类id及名字的列表，如下格式
select queryAllParentCatInfobycatid(101010017);
+-------------------------------------------------------------+
| queryAllParentCatInfobycatid(101010017)                         |
+-------------------------------------------------------------+
| 1,仪器仪表|101,化学分析仪器|10101,色谱|101010017,色谱检测器 |
+-------------------------------------------------------------+
1 row in set 
*/    
DROP FUNCTION IF EXISTS queryAllParentCatInfobycatid;
CREATE FUNCTION `queryAllParentCatInfobycatid` (catid INT)
RETURNS VARCHAR(1000)
BEGIN
    DECLARE sTemp VARCHAR(1000);
    DECLARE curr_parentid VARCHAR(4000);
    DECLARE curr_id int(11);
    DECLARE curr_name varchar(100);
        
    SET sTemp = '';
    SET curr_parentid = cast(catid as char);

    WHILE curr_parentid!=0 DO

    SELECT cat_id,cat_name, parent_id INTO curr_id,curr_name, curr_parentid 
        FROM ecs_category where curr_parentid=cat_id;
    if sTemp=''
    then
        SET sTemp = curr_name;
    else
        SET sTemp = CONCAT(curr_name, ' | ',sTemp);
    end if;
    SET sTemp = CONCAT(curr_id,',',sTemp);
    END WHILE;
    return sTemp;
END;


