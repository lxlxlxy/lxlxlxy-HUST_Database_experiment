use fib;

-- 创建存储过程`sp_fibonacci(in m int)`，向表fibonacci插入斐波拉契数列的前m项，及其对应的斐波拉契数。fibonacci表初始值为一张空表。请保证你的存储过程可以多次运行而不出错。

drop procedure if exists sp_fibonacci;
delimiter $$
create procedure sp_fibonacci(in m int)
begin
######## 请补充代码完成存储过程体 ########
DECLARE x0, x1, i, xt INT;
INSERT INTO fibonacci VALUES (0, 0);
SET x0 = 0, x1 = 1, i = 1;
WHILE i<m DO
    SET xt = x0 + x1;
    INSERT INTO fibonacci VALUES (i, x1);
    SET x0 = x1;
    SET x1 = xt;
    SET i = i + 1;
END WHILE;

end $$

delimiter ;

 
