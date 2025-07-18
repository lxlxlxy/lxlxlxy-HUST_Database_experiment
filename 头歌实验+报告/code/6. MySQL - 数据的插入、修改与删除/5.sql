use finance1;
-- 请用一条update语句将手机号码为“13686431238”的这位客户的投资资产(理财、保险与基金)的状态置为“冻结”。：
update property set pro_status='冻结'
where pro_id in
(
    select pro_id
    from client
    where pro_c_id = client.c_id and client.c_phone="13686431238"
);



/* the end of your code */