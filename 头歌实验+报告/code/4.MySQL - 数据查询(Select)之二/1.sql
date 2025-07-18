 -- 1) 查询销售总额前三的理财产品
--   请用一条SQL语句实现该查询：
select * from
(
    select pyear, 
            rank() over(partition by pyear order by sumamount desc) as rk,#先按pyear字段分组，再根据sumamount降序排序
            p_id,
            sumamount
    from 
    (
        select 
            year(pro_purchase_time) as pyear, 
            p_id, 
            sum(p_amount * pro_quantity) as sumamount
        from property, finances_product
        where pro_pif_id = p_id and pro_type = 1 and year(pro_purchase_time) in (2010,2011)
        group by p_id, pyear
    ) as temp1           #计算每款理财产品每年的销售总额
) as temp2
where rk <= 3   #输出销售总额sumamount为前三的产品






/*  end  of  your code  */