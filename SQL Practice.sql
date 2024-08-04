--LEVEL 1
--use emp, dept AND ORDER tables 
Q1 - How to find duplicates in a given table
Q2 -> How to delete duplicates
Q3 -> difference berween union and union all
Q4 -> diffrence between rank.row number and dense rank
Q5 -> employees who are not present in deparament table
Q6 > second highest salary in each dep
Q7 -> find all transaction done by Shilpa
Q8 -> self join, manager salary > emp salary
Q9 -> Joins Left join/äner join
Q10 -› update query to swap gender


Q1 - How to find duplicates in a given table

SELECT *
  FROM EMP;

--use emp and dept tables   
--Q1 - How to find duplicates in a given table
SELECT emp_id, count(*)
  FROM EMP
  group by 1
  having count(*)>1
  ;

--Q2 -> How to delete duplicates
WITH CTE_DUPS AS 
(
    SELECT 
    EMP_ID
    ,ROW_NUMBER() OVER(PARTITION BY EMP_ID) AS ROW_NUM
    FROM EMP
)
DELETE FROM CTE_DUPS
WHERE ROW_NUM>1;

--Q5 -> employees who are not present in deparament table
SELECT * FROM DEPT;

SELECT * FROM EMP;

SELECT 
* FROM EMP
WHERE DEPARTMENT_ID NOT IN 
(
    SELECT DEP_ID FROM DEPT
);


--Q6 > second highest salary in each dep
SELECT 
DEPARTMENT_ID
,MAX(SALARY) AS HIGHEST_SALARY
FROM EMP
GROUP BY 1;

WITH CTE_RNK AS 
(
    SELECT 
    DEPARTMENT_ID
    ,SALARY
    ,RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) as rnk
    FROM EMP
)
SELECT * FROM CTE_RNK
WHERE RNK=1;

--Q7 -> find all transaction done by Shilpa
SELECT * 
FROM ORDERS
WHERE UPPER(CUSTOMER_NAME)='SHILPA';

--Q8 -> EMP TABLE manager salary > emp salary
SELECT * FROM EMP;

SELECT 
EMP.EMP_ID AS MANAGER
,EMP1.EMP_ID AS EMPLOYEE
,EMP.SALARY AS MANAGER_SALARY
,EMP1.SALARY AS EMPLOYEE_SALARY
FROM EMP EMP
JOIN EMP EMP1 
ON EMP.EMP_ID = EMP1.MANAGER_ID
WHERE EMP.SALARY > EMP1.SALARY;

/*
2	Mohit	100	15000	5	48
XX
4	Rohit	100	5000	2	16
6	Agam	200	12000	2	14
7	Sanjay	200	9000	2	13
8	Ashish	200	5000	2	12
1	Saurabh900	12000	2	51
;
*/
--Q10 -› update query to swap gender

SELECT * FROM ORDERS;

UPDATE ORDERS
SET CUSTOMER_GENDER = CASE WHEN UPPER(CUSTOMER_GENDER) = 'MALE' THEN 'FEMALE'
                        WHEN UPPER(CUSTOMER_GENDER) = 'FEMALE' THEN 'MALE'
                        END;

SELECT * FROM ORDERS;

--LEVEL 2
--USE events TABLE
--1. write a query to find no of gold medal per swimmer for swimmer who won only gold medals


SELECT * FROM events
;

--ID / EVENT / YEAR / GOLD / SILVER / BRONZE
--1	100m	2016	AmthhewMcgarray	donald	barbara

--for swimmer who won only gold medals
    --no of gold medal 
        --per swimmer
 
SELECT 
GOLD
,COUNT(*)AS GOLD_MEDALS
FROM 
events
WHERE GOLD NOT IN 
(
    SELECT SILVER FROM events
    UNION
    SELECT BRONZE FROM events
)
GROUP BY 1
ORDER BY 2 DESC
;

#USE tickets
#2.write a sql to find business day between create date and resolved date by excluding weekend and public holidays


select * from tickets ;

SELECT current_date();


SELECT datediff(CREATE_DATE,RESOLVED_DATE)
FROM TICKETS
;


SELECT 
CREATE_DATE
,RESOLVED_DATE
,extract(MONTH FROM CREATE_DATE)
,datediff(CREATE_DATE,RESOLVED_DATE)
FROM TICKETS;


SELECT DATE_SUB(current_date(),INTERVAL 10 DAY);

SELECT 
CREATE_DATE
,RESOLVED_DATE
,extract(MONTH FROM CREATE_DATE)
,datediff(CREATE_DATE,RESOLVED_DATE)
FROM TICKETS;

#USE HOSPITAL TABLE
#write a sql to find the total number of people present inside the hospital-


SELECT * FROM HOSPITAL ORDER BY EMP_ID,TIME;

#OUT - 1,5
#IN  - 2,3,4

SELECT 
EMP_ID
,TIME
,CASE WHEN ACTION = 'in' THEN TIME END AS IN_TIME
,CASE WHEN ACTION = 'out' THEN TIME END AS OUT_TIME
FROM HOSPITAL 
;

#OPTION 1 
SELECT * FROM 
(
SELECT 
EMP_ID
,MAX(CASE WHEN ACTION = 'in' THEN TIME END) AS IN_TIME
,MAX(CASE WHEN ACTION = 'out' THEN TIME END) AS OUT_TIME
FROM HOSPITAL 
GROUP BY EMP_ID
) TBL
WHERE IN_TIME > OUT_TIME
OR OUT_TIME IS NULL;

SELECT * FROM HOSPITAL;

#OPTION 2 
WITH CTE_IN_TIME AS 
(
	SELECT 
    EMP_ID
    ,MAX(TIME) AS IN_TIME
    FROM HOSPITAL 
    WHERE ACTION = 'in'
    GROUP BY 1 
)
,CTE_OUT_TIME AS 
(
	SELECT 
    EMP_ID
    ,MAX(TIME) AS OUT_TIME
    FROM HOSPITAL 
    WHERE ACTION = 'out'
    GROUP BY 1 
)
SELECT 
*
FROM CTE_IN_TIME IN_TIME 
LEFT JOIN CTE_OUT_TIME OUT_TIME
ON IN_TIME.EMP_ID = OUT_TIME.EMP_ID
WHERE IN_TIME.IN_TIME > OUT_TIME.OUT_TIME
OR OUT_TIME.OUT_TIME IS NULL 
;

#OPTION 3

SELECT 
EMP_ID
,MAX(TIME) AS LATEST_TIME
FROM HOSPITAL 
GROUP BY 1
HAVING (EMP_ID,LATEST_TIME) IN 
	(
		SELECT 
		EMP_ID
		,MAX(TIME) AS LATEST_TIME
		FROM HOSPITAL 
        WHERE ACTION = 'in'
        GROUP BY 1 
    )
 
 #OPTION 4 using rank 
 
 SELECT * FROM HOSPITAL
 ;
 
 WITH CTE_RANK AS 
 (
	SELECT
    EMP_ID
    ,ACTION
    ,TIME
    ,RANK() OVER(PARTITION BY EMP_ID ORDER BY TIME DESC) AS RNK
    FROM HOSPITAL
)
SELECT 
EMP_ID
,TIME
FROM CTE_RANK
WHERE ACTION = 'in'
AND RNK=1;

/*
USE AIRBNB_SEARCHES TABLE 
4. Find the room types that are searched most no of times.
Output the room type alongside the number of searches for it.
If the filter for room types has more than one room type, consider each unique room type as a separate row.
Sort the result based on the number of searches in descending order.
*/


SELECT * FROM AIRBNB_SEARCHES;

DESCRIBE AIRBNB_SEARCHES;

#user_id. / date_searched / filter_room_types
#entire home - 2 / private room - 3 / SHARED ROOM - 2

WITH CTE_ROOM_SEARCH_COUNT AS 
(
SELECT 
USER_ID
,SUM(CASE WHEN filter_room_types LIKE '%entire%' THEN 1 ELSE 0 END) AS ENTIRE_ROOM
,SUM(CASE WHEN filter_room_types LIKE '%private%' THEN 1 ELSE 0 END) AS PRIVATE_ROOM
,SUM(CASE WHEN filter_room_types LIKE '%shared%' THEN 1 ELSE 0 END) AS SHARED_ROOM
FROM AIRBNB_SEARCHES
GROUP BY 1 
)
,CTE_AGGREGATE  AS 
(
SELECT CASE WHEN ENTIRE_ROOM=1 THEN 'ENTIRE_HOME' END AS ROOM_TYPE FROM CTE_ROOM_SEARCH_COUNT
UNION ALL
SELECT CASE WHEN PRIVATE_ROOM=1 THEN 'PRIVATE_ROOM' END AS ROOM_TYPE FROM CTE_ROOM_SEARCH_COUNT
UNION ALL 
SELECT CASE WHEN SHARED_ROOM=1 THEN 'SHARED_ROOM' END AS ROOM_TYPE FROM CTE_ROOM_SEARCH_COUNT
)
SELECT 
ROOM_TYPE
,COUNT(*) AS SEARCH_COUNT
FROM CTE_AGGREGATE
WHERE ROOM_TYPE IS NOT NULL
GROUP BY 1 ;

#DO SUM ON CASE
#ASSIGN THE OUTPUT TO THE VALUE
#IGNORE NULL RESULTS