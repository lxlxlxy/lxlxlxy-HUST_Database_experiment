-- 3) 查询既买了保险又买了基金的客户的名称、邮箱和电话。结果依c_id排序
-- 请用一条SQL语句实现该查询：

SELECT c.c_name, c.c_mail, c.c_phone
FROM client c
WHERE EXISTS (
    SELECT 1
    FROM property p1
    WHERE p1.pro_c_id = c.c_id
    AND p1.pro_type = 2
)
AND EXISTS (
    SELECT 1
    FROM property p2
    WHERE p2.pro_c_id = c.c_id
    AND p2.pro_type = 3
)
ORDER BY c.c_id;