# 请填写语句，完成以下功能：
#(1) 创建用户tom和jerry，初始密码均为'123456'；
CREATE USER tom IDENTIFIED BY '123456';
CREATE USER jerry IDENTIFIED BY '123456';
#(2) 授予用户tom查询客户的姓名，邮箱和电话的权限,且tom可转授权限；
GRANT SELECT(c_name, c_mail, c_phone) ON TABLE client TO tom WITH GRANT OPTION;
#(3) 授予用户jerry修改银行卡余额的权限；
GRANT UPDATE(b_balance) ON TABLE bank_card TO jerry;
#(4) 收回用户Cindy查询银行卡信息的权限。
REVOKE SELECT ON TABLE bank_card FROM Cindy;