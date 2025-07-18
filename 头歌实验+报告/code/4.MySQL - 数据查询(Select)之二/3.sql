   -- 3) 查询购买了所有畅销理财产品的客户
--   请用一条SQL语句实现该查询：
SELECT DISTINCT pro_c_id    
FROM property p1
WHERE NOT EXISTS(       #NOT EXISTS：不存在某个畅销产品是当前客户没有购买的则该客户会被选中
   SELECT * 
   FROM 
      (SELECT pro_pif_id
      FROM property
      WHERE pro_type = 1
      GROUP BY pro_pif_id
      HAVING COUNT(*)>2) fin_pos  #识别出畅销的理财产品作为子查询表
   WHERE fin_pos.pro_pif_id NOT IN   #子查询表示客户购买的所有理财产品，not in表示找出当前客户(p1.pro_c_id)没有购买的畅销产品
      (SELECT pro_pif_id
      FROM property p2
      WHERE p1.pro_c_id = p2.pro_c_id AND
      p2.pro_type = 1)
);






/*  end  of  your code  */