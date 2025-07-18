UPDATE wage
INNER JOIN (
    #获取指定身份证号客户的c_id及其2023年总酬劳
    SELECT w.w_c_id,SUM(w.w_amount) AS total_salary
    FROM wage w
    INNER JOIN client c ON w.w_c_id = c.c_id
    WHERE c.c_id_card = '420108199702144323' AND YEAR(w.w_time) = 2023           
    GROUP BY w.w_c_id
) AS t ON wage.w_c_id = t.w_c_id
SET 
    #计算并扣除税款（若总酬劳 > 60000）
    wage.w_amount = wage.w_amount - (
        GREATEST(t.total_salary - 60000, 0) * 0.2 * (wage.w_amount / t.total_salary)
    ),
    #设置扣税标志：总酬劳 > 60000 时标记为 'Y'
    wage.w_tax = IF(t.total_salary > 60000, 'Y', 'N')
WHERE 
    YEAR(wage.w_time) = 2023  #仅更新2023年的记录
    AND wage.w_c_id = t.w_c_id;  #仅仅更新指定用户的酬劳




/* end of you code */ 