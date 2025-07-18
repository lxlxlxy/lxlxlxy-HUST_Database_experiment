-- 17 查询2022年2月购买基金的高峰期。至少连续三个交易日，所有投资者购买基金的总金额超过100万(含)，则称这段连续交易日为投资者购买基金的高峰期。只有交易日才能购买基金,但不能保证每个交易日都有投资者购买基金。2022年春节假期之后的第1个交易日为2月7日,周六和周日是非交易日，其余均为交易日。请列出高峰时段的日期和当日基金的总购买金额，按日期顺序排序。总购买金额命名为total_amount。
--    请用一条SQL语句实现该查询：
SELECT pro_purchase_time,total_amount
FROM
    (SELECT pro_purchase_time, total_amount, IF(DATEDIFF(pro_purchase_time, @curday) = IF(DATEDIFF(pro_purchase_time, "2022-2-7")%7 = 0, 3, 1), @dayOffset, @dayOffset := @dayOffset+1) AS gapDay, @curday := pro_purchase_time
    FROM (SELECT @dayOffset := 0, @curday := 0 ) AS d,
        (SELECT pro_purchase_time, SUM(pro_quantity*f_amount) AS total_amount
        FROM fund, property
        WHERE fund.f_id = property.pro_pif_id AND
                property.pro_type = 3 AND
                pro_purchase_time >= "2022-2-7" AND
                pro_purchase_time <= "2022-2-28" AND
                DATEDIFF(pro_purchase_time,"2022-2-5")%7 >1            
        GROUP BY pro_purchase_time
        HAVING SUM(pro_quantity*f_amount) >= 1000000
        ORDER BY pro_purchase_time ASC) AS highs
    ) AS peaks
WHERE gapDay IN 
    (SELECT gapDay
    FROM    
        (SELECT pro_purchase_time, total_amount, IF(DATEDIFF(pro_purchase_time, @curdays) = IF(DATEDIFF(pro_purchase_time, "2022-2-7")%7 = 0, 3, 1), @dayOffsets, @dayOffsets := @dayOffsets+1) AS gapDay, @curdays := pro_purchase_time
        FROM (SELECT @dayOffsets := 0, @curdays := 0 ) AS d,
            (SELECT pro_purchase_time, SUM(pro_quantity*f_amount) AS total_amount
            FROM fund, property
            WHERE fund.f_id = property.pro_pif_id AND
                    property.pro_type = 3 AND
                    pro_purchase_time >= "2022-2-7" AND
                    pro_purchase_time <= "2022-2-28" AND
                    DATEDIFF(pro_purchase_time,"2022-2-5")%7 >1            
            GROUP BY pro_purchase_time
            HAVING SUM(pro_quantity*f_amount) >= 1000000
            ORDER BY pro_purchase_time ASC) AS high
        ) AS peak
    GROUP BY gapDay
    HAVING COUNT(*)>=3);





/*  end  of  your code  */