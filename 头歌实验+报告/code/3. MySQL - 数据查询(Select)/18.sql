 -- 18) 查询至少有一张信用卡余额超过5000元的客户编号，以及该客户持有的信用卡总余额，总余额命名为credit_card_amount。
--    请用一条SQL语句实现该查询：
SELECT b_c_id, credit_card_amount
FROM   #从子查询b_amount中选择客户ID和信用卡总余额
    (SELECT b_c_id, SUM(b_balance) AS credit_card_amount
    FROM bank_card
    WHERE b_type = "信用卡"
    GROUP BY b_c_id) AS b_amount  #以编号分组计算信用卡余额
WHERE EXISTS    #至少有一张大于5000，存在表示
    (SELECT * FROM bank_card
    WHERE b_amount.b_c_id = bank_card.b_c_id AND
    b_type="信用卡" AND
    b_balance > 5000)
ORDER BY b_c_id ASC;





/*  end  of  your code  */


 