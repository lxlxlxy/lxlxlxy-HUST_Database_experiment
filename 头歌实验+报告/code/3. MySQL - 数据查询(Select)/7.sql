-- 7) 查询身份证隶属武汉市没有买过任何理财产品的客户的名称、电话号、邮箱。
--    请用一条SQL语句实现该查询：
select c_name,c_phone,c_mail
from client
where c_id_card like '4201%' and not exists(
    select 1
    from property
    where pro_type=1 and property.pro_c_id=client.c_id
)
order by c_id;




/*  end  of  your code  */