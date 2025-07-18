-- 获得兼职总酬劳前三名的客户:
SELECT c.c_name,c.c_id_card,SUM(w.w_amount) AS total_salary
FROM client c,wage w
WHERE w.w_type = 2 and c.c_id = w.w_c_id
GROUP BY c.c_id, c.c_name, c.c_id_card
ORDER BY total_salary DESC
LIMIT 3;




/* end of you code */