-- 10) 查询当前总的可用资产收益(被冻结的资产除外)前三名的客户的名称、身份证号及其总收益，按收益降序输出，总收益命名为total_income。不考虑并列排名情形。
--    请用一条SQL语句实现该查询：
select c_name,c_id_card,(select sum(pro_income) from property where pro_c_id=client.c_id and pro_status!='冻结') as total_income
from client
where c_id in(
    select pro_c_id
    from(
        select pro_c_id,sum(pro_income)as total
        from property
        where pro_status !='冻结'
        group by pro_c_id
        order by total desc
        limit 3
    )as tmp  
)
order by total_income desc;









/*  end  of  your code  */ 