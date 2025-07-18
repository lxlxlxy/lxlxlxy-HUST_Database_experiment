WITH filtered_data AS (  # 筛选出全职（w_type=1）的工资记录，并关联客户表确保客户有效
    SELECT w.w_org, w.w_c_id, w.w_amount, w.w_time   #机构ID、客户ID、工资金额、发放时间
    FROM  wage w,client c
    WHERE w.w_c_id = c.c_id AND  w.w_type = 1
),
monthly_salary AS (  
    SELECT w_org,w_c_id, DATE_FORMAT(w_time, '%Y-%m') AS month, SUM(w_amount) AS monthly_total
    FROM filtered_data
    GROUP BY w_org, w_c_id, month
),  #按机构、客户、月份分组，计算每个客户每月的工资总和
employee_avg AS (
    SELECT w_org, w_c_id, AVG(monthly_total) AS avg_monthly_salary
    FROM monthly_salary
    GROUP BY w_org, w_c_id
),  #计算每个员工在统计期内的平均月工资
org_summary AS (
    SELECT ms.w_org,
    SUM(ms.monthly_total) AS total_amount,
    COUNT(DISTINCT ms.w_c_id) AS employee_count,
    COUNT(DISTINCT ms.month) AS month_count,
    MAX(ms.monthly_total) AS max_wage,
    MIN(ms.monthly_total) AS min_wage
    FROM 
        monthly_salary ms
    GROUP BY 
        ms.w_org
),  #按机构分组，计算:total_amount 机构总工资支出,employee_count员工人数,month_count月份数,max_wage/min_wage最高最低薪资
ranked_employees AS (
    SELECT 
        ea.w_org,
        ea.avg_monthly_salary,
        ROW_NUMBER() OVER (PARTITION BY ea.w_org ORDER BY ea.avg_monthly_salary) AS row_num,
        COUNT(*) OVER (PARTITION BY ea.w_org) AS total_employees
    FROM employee_avg ea
),  #为每个机构的员工按平均工资升序编号，并统计机构总人数。
median_calculation AS (
    SELECT re.w_org,AVG(re.avg_monthly_salary) AS mid_wage
    FROM 
        ranked_employees re
    WHERE 
        re.row_num IN (
            (re.total_employees + 1) DIV 2,    #奇数则相等，偶数则为中间两个数
            (re.total_employees + 2) DIV 2
        )
    GROUP BY 
        re.w_org
)  #通过定位中位数位置，计算机构工资中位数
SELECT 
    os.w_org,
    os.total_amount,
    ROUND(os.total_amount / (os.employee_count * os.month_count), 2) AS average_wage,
    os.max_wage,
    os.min_wage,
    COALESCE(ROUND(mc.mid_wage, 2), 0) AS mid_wage  -- 处理空值
FROM org_summary os
LEFT JOIN median_calculation mc ON os.w_org = mc.w_org
ORDER BY os.total_amount DESC;

/* end of you code */