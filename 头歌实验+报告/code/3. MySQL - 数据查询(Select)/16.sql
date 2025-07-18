-- 16) 查询持有相同基金组合的客户对，如编号为A的客户持有的基金，编号为B的客户也持有，反过来，编号为B的客户持有的基金，编号为A的客户也持有，则(A,B)即为持有相同基金组合的二元组，请列出这样的客户对。为避免过多的重复，如果(1,2)为满足条件的元组，则不必显示(2,1)，即只显示编号小者在前的那一对，这一组客户编号分别命名为c_id1,c_id2。

-- 请用一条SQL语句实现该查询：
SELECT DISTINCT A.pro_c_id AS c_id1, B.pro_c_id AS c_id2
FROM property A,property B
WHERE 
    A.pro_c_id < B.pro_c_id AND   #避免重复条件
    NOT EXISTS(                   #条件1：A持有的基金都在B的持有中（双重否定后）
        SELECT * 
        FROM property C
        WHERE A.pro_c_id = C.pro_c_id AND C.pro_type = 3 AND C.pro_pif_id NOT IN (
            SELECT pro_pif_id 
            FROM property D
            WHERE D.pro_c_id = B.pro_c_id AND D.pro_type = 3
        )
    ) AND
    NOT EXISTS(                   #条件2：B持有的基金都在A的持有中（双重否定后）
        SELECT * 
        FROM property E
        WHERE B.pro_c_id = E.pro_c_id AND E.pro_type = 3 AND E.pro_pif_id NOT IN (
            SELECT pro_pif_id 
            FROM property F
            WHERE F.pro_c_id = A.pro_c_id AND F.pro_type = 3
        ) 
    ) AND
    EXISTS(                       #条件3：A至少持有一只基金（避免与没有持有任何基金的客户形成无效对）
        SELECT *
        FROM property G
        WHERE G.pro_c_id = A.pro_c_id AND G.pro_type = 3
    );






/*  end  of  your code  */