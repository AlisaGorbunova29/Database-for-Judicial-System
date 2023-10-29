-- Выводит все города, в которых было решено более 1000 дел

SELECT
	city_nm as city,
	sum(solved_litigation_cnt) as cnt_solved_litigation
FROM law.judge
GROUP BY city 
HAVING sum(solved_litigation_cnt) > 1000;

-- Выводит в алфавитном порядке всех юристов, которые учавствовали как ответчики хотя бы в одном деле

SELECT 
	dc.litigation_no,
	dc.layer_nm as layer
FROM (law.defendant as d 
      JOIN law.company as c ON d.company_nm = c.company_nm) as dc
WHERE dc.layer_nm IS NOT NULL
ORDER BY dc.layer_nm DESC;

-- средняя стоимость услуг эксперта в разных городах

SELECT
	organisation_nm as expert,
	cost_value as cost,
	city_nm as city,
	avg(cost_value) OVER (PARTITION BY city_nm) as avg_cost_in_city
FROM law.expert;


--  Рейтинг судей по кол-ву решённых дел в каждом городе
SELECT
	ROW_NUMBER() OVER (PARTITION BY city_nm ORDER BY solved_litigation_cnt DESC),
	judge_nm,
	city_nm,
	solved_litigation_cnt
FROM law.judge;

--  рейтинг юристов по кол-ву выйгранных дел
WITH 
	plaintiff_lawyer_gain AS (
		(SELECT *
	 	 FROM (law.company JOIN law.plaintiff ON law.company.company_nm = law.plaintiff.company_nm) as res1
	     		JOIN (SELECT
			   	 	  	  litigation_no
			           FROM law.litigation
			           WHERE status_value = 2
		       ) as res2 ON res1.litigation_no = res2.litigation_no
	    )
	),
	defendants_lawyer_gain AS (
		(SELECT *
	 	 FROM (law.company JOIN law.defendant ON law.company.company_nm = law.defendant.company_nm) as res1
	           JOIN (SELECT
			   	 	 	litigation_no
			     	 FROM law.litigation
			     	 WHERE status_value = 3
		      ) as res2 ON res1.litigation_no = res2.litigation_no
	    )
	)

SELECT 
    dense_rank() OVER (ORDER BY count(answer.layer_nm) DESC),
	answer.layer_nm as layer
FROM 
	((SELECT * FROM plaintiff_lawyer_gain)
	UNION
	(SELECT * FROM defendants_lawyer_gain)) AS answer
WHERE answer.layer_nm IS NOT NULL
GROUP BY answer.layer_nm;


-- Дата предыдущего изменения по делу
SELECT
	litigation_no,
	litigation_dt as date_changes,
	LAG(litigation_dt, 1, NULL) OVER (PARTITION BY litigation_no ORDER BY litigation_dt) as prev_date_changes
FROM law.litigation_history;

