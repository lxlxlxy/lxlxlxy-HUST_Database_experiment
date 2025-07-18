 -- 6) 查找相似的理财客户
 #找出与每个客户最相似的其他客户（基于共同持有的理财产品），并限制每个客户只显示最多2个最相似的客户
 #查询每位客户(pac)的相似度排名值小于3的相似客户(pbc)列表，以及该每位客户和他的每位相似客户的共同持有的理财产品数(common)、相似度排名值(crank)
#
--   请用一条SQL语句实现该查询：
SELECT pac, pbc, common, crank
FROM  
    (SELECT pac, pbc, common, rank() over(partition by pac order by common,pbc) AS crank  #主要按共同产品数降序(common）,相同数量时按客户ID排序(pbc)
    FROM
        (SELECT pac, pbc, COUNT(*) AS common
        FROM
            (SELECT DISTINCT p1.pro_c_id AS pac, p2.pro_c_id AS pbc, p2.pro_pif_id
            FROM property p1, property p2
            WHERE p1.pro_c_id <> p2.pro_c_id AND
                p2.pro_type = 1 AND
                p2.pro_pif_id IN 
                (SELECT p3.pro_pif_id
                FROM property p3
                WHERE p3.pro_c_id = p1.pro_c_id AND   #配对客户持有的产品必须是主客户也持有的产品
                    p3.pro_type = 1)) common_c   # 找出所有客户对 及其 共同持有的理财产品
        GROUP BY pac,pbc) common_b               #计算每对客户共同持有的理财产品数量(common)
    ) common_a                                   #为每个主客户(pac)的相似客户分配排名（crank）
WHERE crank <= 2; 

/*  end  of  your code  */