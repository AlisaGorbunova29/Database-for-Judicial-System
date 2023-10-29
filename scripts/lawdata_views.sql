-- Представления

-- скрытие служебных полей для таблицы судьи:
CREATE VIEW official_info_judge AS
SELECT
	judge_nm as judge_name,  
	city_nm as city,
	speciality
FROM law.judge;

-- скрытие личных данных о компаниях
CREATE VIEW official_info_company AS
SELECT
	company_nm as name_company,
	overlay(mobile_phone_no placing '-***-***-**-' from 2),
	activity_nm as activity_name,
	city_nm as city
FROM law.company;

-- таблица с 'экспертами', которые специализируются на банкротстве
CREATE VIEW official_info_bankruptcy_expert AS
SELECT
	organisation_nm as organisation_name,
	speciality_nm as speciality, 
	city_nm as city, 
	cost_value as cost
FROM law.expert
WHERE speciality_nm = 'bankruptcy'
WITH LOCAL CHECK OPTION;

-- информация об эксперте по делу. Можно использовать для сбора статистики о кол-ве денег, которое было потрачено на экспертов
CREATE VIEW expert_and_cost AS
SELECT 
    law.litigation.litigation_no as litigation_no,
	law.expert.organisation_nm as organisation_nm,
	law.expert.speciality_nm as speciality_name,
	law.expert.cost_value as cost_value	
FROM law.expert 
	INNER JOIN law.expert_in_litigation 
	ON law.expert.organisation_nm = law.expert_in_litigation.organisation_nm
	INNER JOIN law.litigation
	ON law.expert_in_litigation.litigation_no = law.litigation.litigation_no;
	
-- полная информация о деле и судье, которая его ведёт. Можно использовать для подсчёта кол-ва дел, которые решены в пользу 
-- исца или ответчика. Также можно узнать сколько дел какой специализации есть в данный момент
CREATE VIEW judge_and_litigation AS
SELECT 
	law.judge.judge_nm as judge_name,
	law.judge.city_nm as city,
	law.judge.speciality as speciality,
	law.litigation.litigation_no as litigation_no,
	law.litigation.next_sitting_dt as next_sitting_dt,
	law.litigation.status_value as status_value
FROM law.judge
	JOIN law.litigation
	ON law.judge.judge_nm = law.litigation.judge_nm;
	
-- сводная таблица об участниках делу
CREATE VIEW participants AS
SELECT 
	law.litigation.litigation_no as litigation_no,
	law.litigation.judge_nm as judge_name,
	law.company.company_nm as company_name,
	law.company.layer_nm as layer_name,
	law.litigation.status_value as status_value
FROM ((SELECT *
       FROM law.defendant) 
	  UNION
      (SELECT* 
	  FROM law.plaintiff)) as con
	 JOIN law.litigation
	 ON con.litigation_no = law.litigation.litigation_no
	 JOIN law.company
	 ON con.company_nm = law.company.company_nm;
		

