INSERT INTO law.judge (judge_nm, experience_year, city_nm, speciality,	solved_litigation_cnt,	long_litigation_cnt) VALUES
	('Ivanov',    0,  'Moscow',           'bankruptcy', 123, 0),
	('Smirnova',  3,  'Nizhny Novgorod',  'property disputes', 113, 2),
	('Kuznetsov', 10, 'Saratov',          'bankruptcy', 877, 0),
	('Popova',    5,  'Saratov',          'property disputes', 160, 5),
	('Vasiliev',  4,  'Saratov',          'property disputes', 150, 10),
	('Petrov',    1,  'Saint Petersburg', 'bankruptcy', 131, 0),
	('Sokolova',  3,  'Saint Petersburg', 'tax controversy', 257, 7),
	('Mikhailov', 6,  'Moscow',           'tax controversy', 343, 0),
	('Novikova',  6,  'Moscow',           'bankruptcy', 136, 0),
	('Fedorova',  8,  'Moscow',           'property disputes', 467, 4);

INSERT INTO law.expert(organisation_nm, speciality_nm, city_nm, cost_value) VALUES
	('Triad', 'property disputes', 'Moscow', 5000),
	('Union', 'bankruptcy', 'Saint Petersburg', 3000),
	('Atlanta', 'bankruptcy', 'Saratov', 1500),
	('TechStroy', 'property disputes', 'Saratov', 7500),
	('Esin', 'property disputes', 'Saratov', 2300),
	('GreenExpert', 'tax controversy', 'Moscow', 3100),
	('RegionExpert', 'tax controversy', 'Saint Petersburg', 5600),
	('GosExpert', 'property disputes', 'Saint Petersburg', 7000),
	('BankrateExpert', 'property disputes', 'Moscow', 8000),
	('ExpertStroy', 'bankruptcy', 'Saint Petersburg', 5000);


INSERT INTO law.legal_team(legal_team_nm, city_nm, speciality_nm) VALUES
	('Agentis', 'Saint Petersburg', 'tax controversy'),
	('Aegis', 'Saint Petersburg', 'bankruptcy'),
	('Jurax', 'Saratov', 'property disputes'),
	('AVELAN', 'Moscow', 'property disputes'),
	('Result', 'Moscow', 'bankruptcy'),
	('Verdict','Saratov', 'tax controversy'),
	('Bartolius', 'Moscow', 'bankruptcy'),
	('Infralex', 'Saint Petersburg', 'bankruptcy'),
	('Orchards', 'Moscow', 'tax controversy');
	
INSERT INTO law.layer(layer_nm,	experience_year, mobile_phone_no, cost_value, legal_team_nm, successful_case_cnt) VALUES
	('Zaitsev', 3, '8-917-123-34-64', 7000, 'Agentis', 190),
	('Pavlova', 5, '8-923-231-54-12', 3500, 'Jurax', 240),
	('Semyonov', 14, '8-954-361-57-13', 4700, 'Bartolius', 513),
	('Golubev', 2, '8-987-342-25-16', 8100, 'Aegis', 130),
	('Vinogradova', 4, '8-954-345-24-31', 4700, 'Verdict', 270),
	('Bogdanova', 3, '8-954-387-21-65', 5300, 'Result', 430),
	('Vorobyev', 5, '8-876-456-32-14', 3800, 'AVELAN', 220),
	('Fedorova', 0, '8-973-276-43-17', 9700, 'Bartolius', 11),
	('Mikhailov', 1,'8-953-767-23-15', 1700, 'Result', 17),
	('Belyaeva', 3, '8-943-256-73-25', 2400, 'Infralex', 25),
	('Tarasova', 6, '8-954-765-27-86', 5700, 'Orchards',74);
	
INSERT INTO law.company(company_nm,	mobile_phone_no, activity_nm, city_nm, layer_nm) VALUES
	('SKY LINE', '8-965-356-74-20', 'transport', 'Saratov', 'Tarasova'),
	('MegaKorp', '8-912-234-32-61', 'building', 'Moscow', 'Golubev'),
	('Finam', '8-823-654-12-24', 'finance', 'Saint Petersburg', NULL),
	('Ocean', '8-934-123-45-23', 'building', 'Saratov', 'Pavlova'),
	('Alfa', '8-964-276-34-12', 'finance', 'Moscow', 'Golubev'),
	('EuroPlan', '8-765-346-23-12', 'building', 'Saint Petersburg', NULL),
	('Branded', '8-974-364-75-65',  'transport', 'Saratov', 'Fedorova'),
	('Mega', '8-954-351-25-46', 'transport', 'Moscow', 'Mikhailov'),
	('Brandyck', '8-932-643-34-12', 'building', 'Saint Petersburg', 'Fedorova'),
	('Mega King', '8-987-345-12-26',  'transport', 'Saratov', NULL);
	
INSERT INTO law.litigation(litigation_no, opening_sitting_dt, next_sitting_dt, status_value, judge_nm) VALUES
	(1234, '2023-03-15', '2023-04-17', 0, 'Smirnova'),
	(3451, '2021-12-12', '2023-04-19', 0, 'Sokolova'),
	(5243, '2020-11-08', '2021-12-12', 1, 'Popova'),
	(5412, '2021-08-10', '2022-11-13', 2, 'Kuznetsov'),
	(6123, '2019-04-11', '2019-05-17', 3, 'Petrov'),
	(5123, '2012-09-23', '2013-03-28', 1, 'Vasiliev'),
	(1623, '2020-12-15', '2021-12-12', 3, 'Kuznetsov'),
	(6762, '2022-09-13', '2023-04-18', 0, 'Novikova'),
	(4623, '2015-04-30', '2015-09-27', 1, 'Fedorova'),
	(8233, '2021-05-14', '2021-07-21', 2, 'Fedorova');
	
INSERT INTO law.litigation_history(litigation_no, litigation_dt, status_now_value, judge_nm) VALUES
    (3451, '2023-01-23', 0, 'Kuznetsov'),
	(1234, '2023-04-17', 0, 'Smirnova'),
	(3451, '2023-04-19', 0, 'Sokolova'),
	(5243, '2021-12-12', 1, 'Popova'),
	(5412, '2022-11-13', 2, 'Kuznetsov'),
	(6123, '2019-05-17', 3, 'Petrov'),
	(5123, '2013-03-28', 1, 'Vasiliev'),
	(1623, '2021-12-12', 3, 'Kuznetsov'),
	(6762, '2023-04-18', 0, 'Novikova'),
	(4623, '2015-09-27', 1, 'Fedorova'),
	(8233, '2021-07-21', 2, 'Fedorova');
	
INSERT INTO law.expert_in_litigation(organisation_nm, litigation_no) VALUES
	('Triad', 5243),
	('Esin', 1623),
	('TechStroy', 6762),
	('Triad', 5123),
	('RegionExpert', 5243),
	('Atlanta', 1234),
	('GreenExpert', 1623),
	('BankrateExpert', 3451),
	('RegionExpert', 5243),
	('Esin', 1623);
	
INSERT INTO law.plaintiff(company_nm, litigation_no) VALUES
	('SKY LINE', 1234),
	('MegaKorp', 5243),
	('Finam', 3451),
	('Ocean', 6123),
	('Alfa', 5123),
	('EuroPlan', 6762),
	('Branded', 5412),
	('Mega', 1623),
	('Brandyck', 1623),
	('Mega King', 8233);
	
INSERT INTO law.defendant(company_nm, litigation_no) VALUES
	('Mega King', 1234),
	('Mega', 5243),
	('Brandyck', 3451),
	('Alfa', 6123),
	('Ocean', 5123),
	('Branded', 6762),
	('EuroPlan', 5412),
	('MegaKorp', 1623),
	('Finam', 1623),
	('SKY LINE', 8233);

