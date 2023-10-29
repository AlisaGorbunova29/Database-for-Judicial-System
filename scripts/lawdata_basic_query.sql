-- CRUD запросы: CREATE, READ, UPDATE и DELETE

-- CREATE

INSERT INTO law.judge (judge_nm, experience_year, city_nm, speciality,	solved_litigation_cnt,	long_litigation_cnt) VALUES
	('Soveliev',    7,  'Nizhny Novgorod', 'bankruptcy', 529, 0),
	('Kositsin', 2, 'Saratov', 'tax controversy', 97, 0);
	
INSERT INTO law.defendant(company_nm, litigation_no) VALUES
	('Alfa', 8233),
	('Mega King', 5412),
	('Brandyck', 6123);
	
INSERT INTO law.expert_in_litigation(organisation_nm, litigation_no) VALUES
	('Union', 5123),
	('GosExpert', 1623),
	('TechStroy', 5243),
	('BankrateExpert', 6762);
	

INSERT INTO law.layer(layer_nm,	experience_year, mobile_phone_no, cost_value, legal_team_nm, successful_case_cnt) VALUES
	('Voronin', 12, '8-949-375-01-03', 10000, NULL, 692);
	
-- UPDATE

UPDATE law.judge
	SET judge_nm = 'Filipova'
WHERE judge_nm = 'Smirnova';

UPDATE law.judge
	SET experience_year = 9
WHERE judge_nm = 'Fedorova';

UPDATE law.layer
	SET successful_case_cnt = 700
WHERE layer_nm = 'Voronin';

UPDATE law.layer
	SET mobile_phone_no = '8-932-765-12-27'
WHERE mobile_phone_no = '8-876-456-32-14';

UPDATE law.company
	SET city_nm = 'Nizhny Novgorod'
WHERE company_nm = 'Alfa';

UPDATE law.company
	SET layer_nm = NULL
WHERE company_nm = 'SKY LINE';

UPDATE law.legal_team
	SET legal_team_nm = 'TrueLaw'
WHERE legal_team_nm = 'AVELAN';

UPDATE law.expert
	SET cost_value = 7000
WHERE organisation_nm = 'Triad';

UPDATE law.expert
	SET city_nm = 'Moscow'
WHERE organisation_nm = 'Atlanta';

UPDATE law.litigation
	SET next_sitting_dt = '2022-12-13'
WHERE litigation_no = 5412;

-- DELETE

DELETE FROM law.judge
WHERE judge_nm = 'Kositsin';

DELETE FROM law.litigation 
WHERE litigation_no = 1234;

DELETE FROM law.litigation_history
WHERE litigation_no = 1234;

DELETE FROM law.litigation 
WHERE litigation_no = 5412;

DELETE FROM law.litigation_history
WHERE litigation_no = 5412;

DELETE FROM law.expert
WHERE organisation_nm = 'TechStroy';

DELETE FROM law.layer
WHERE layer_nm = 'Bogdanova';

DELETE FROM law.legal_team
WHERE legal_team_nm = 'Agentis';

DELETE FROM law.company
WHERE company_nm = 'SKY LINE';

DELETE FROM law.layer
WHERE layer_nm = 'Belyaeva';

-- READ

SELECT
	judge_nm as judge
FROM law.judge
ORDER BY judge_nm DESC;

SELECT
	layer_nm as layer,
	cost_value as cost
FROM law.layer;

SELECT
	organisation_nm as organisation,
	speciality_nm as speciality
FROM law.expert;

SELECT *
FROM law.litigation
ORDER BY litigation_no;

SELECT *
FROM law.defendant
WHERE litigation_no > 3000;

SELECT *
FROM law.plaintiff
WHERE company_nm LIKE 'M%';

SELECT 
	judge_nm as judge,
	solved_litigation_cnt
FROM law.judge
WHERE solved_litigation_cnt > 400;

SELECT
	litigation_no,
	opening_sitting_dt
FROM law.litigation
WHERE opening_sitting_dt > '2020-01-01';

SELECT 
	litigation_no,
	next_sitting_dt - opening_sitting_dt as time
FROM law.litigation
WHERE status_value = 1;

SELECT
	layer_nm as layer,
	experience_year 
FROM law.layer
WHERE experience_year > 5;

