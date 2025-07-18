SELECT w.w_org,SUM(w.w_amount) AS total_salary
FROM wage w,client c
WHERE w.w_type = 2 and w.w_c_id = c.c_id
GROUP BY w.w_org
ORDER BY total_salary DESC
LIMIT 3;





/* end of you code */