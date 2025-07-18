  -- 2) 投资积极且偏好理财类产品的客户
--   请用一条SQL语句实现该查询：
SELECT DISTINCT finances_pos.pro_c_id
FROM
  (SELECT COUNT(*) AS finances_num,pro_c_id
  FROM property
  WHERE pro_type = 1
  GROUP BY pro_c_id
  HAVING COUNT(*)>=3) finances_pos,     #统计每个客户购买的理财产品总数
  (SELECT IFNULL(COUNT(*),0) AS fund_num,pro_c_id
  FROM property
  WHERE pro_type = 3
  GROUP BY pro_c_id) fund_pos          #统计每个客户购买的基金产品总数
WHERE finances_pos.finances_num>fund_pos.fund_num AND
  finances_pos.pro_c_id = fund_pos.pro_c_id   #最外层查询条件：理财产品数量 > 基金产品数量
ORDER BY finances_pos.pro_c_id ASC;






/*  end  of  your code  */