CREATE SCHEMA law

CREATE TABLE law.judge(
	judge_nm               varchar(32)  PRIMARY KEY,
	experience_year        integer      CHECK (experience_year >= 0),
	city_nm                varchar(32)  NOT NULL,
	speciality             varchar(32)  NOT NULL,
	solved_litigation_cnt  integer      CHECK (solved_litigation_cnt >= 0),
	long_litigation_cnt    integer      CHECK (long_litigation_cnt >= 0)
);

CREATE TABLE law.expert(
	organisation_nm  varchar(32)  PRIMARY KEY,
	speciality_nm    varchar(32)  NOT NULL,
	city_nm          varchar(32)  NOT NULL,
	cost_value       integer      CHECK (cost_value > 0)
);

CREATE TABLE law.legal_team(
	legal_team_nm  varchar(32)  PRIMARY KEY,
	city_nm        varchar(32)  NOT NULL,
	speciality_nm  varchar(32)  NOT NULL
);

CREATE TABLE law.layer(
	layer_nm             varchar(32)  PRIMARY KEY,
	experience_year      integer      CHECK (experience_year >= 0),
	mobile_phone_no      varchar(15)  CHECK (mobile_phone_no ~ '^(8)-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}$'),
	cost_value           integer      NOT NULL,
	legal_team_nm        varchar(32),
	successful_case_cnt  integer      CHECK (successful_case_cnt >= 0),
	
	FOREIGN KEY (legal_team_nm) 
		REFERENCES law.legal_team(legal_team_nm)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS law.company(
	company_nm       varchar(32)  PRIMARY KEY,
	mobile_phone_no  varchar(15)  CHECK (mobile_phone_no ~ '^(8)-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}$'),
	activity_nm      varchar(32)  NOT NULL,
	city_nm          varchar(32)  NOT NULL,
	layer_nm         varchar(32),
	FOREIGN KEY (layer_nm) 
		REFERENCES law.layer(layer_nm)
			ON DELETE SET NULL
			ON UPDATE CASCADE
);

CREATE TABLE law.litigation(
	litigation_no      integer      PRIMARY KEY,
	opening_sitting_dt date,
	next_sitting_dt    date,
	status_value       integer      CHECK (0 <= status_value AND status_value <= 3),
	judge_nm           varchar(32),
	
	FOREIGN KEY (judge_nm) 
		REFERENCES law.judge(judge_nm)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
);

CREATE TABLE law.litigation_history(
	litigation_no     integer,
	litigation_dt     date,
	status_now_value  integer      CHECK (0 <= status_now_value AND status_now_value <= 3),
	judge_nm          varchar(32),
	FOREIGN KEY (judge_nm) 
		REFERENCES law.judge(judge_nm)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
);

CREATE TABLE law.expert_in_litigation(
	organisation_nm  varchar(32)  NOT NULL,
	litigation_no    integer      NOT NULL,
	FOREIGN KEY (organisation_nm) 
		REFERENCES law.expert(organisation_nm)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	FOREIGN KEY (litigation_no) 
		REFERENCES law.litigation(litigation_no)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);

CREATE TABLE law.plaintiff(
	company_nm     varchar(32)  NOT NULL,
	litigation_no  integer      NOT NULL,
	FOREIGN KEY (company_nm) 
		REFERENCES law.company(company_nm)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	FOREIGN KEY (litigation_no) 
		REFERENCES law.litigation(litigation_no)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);

CREATE TABLE law.defendant(
	company_nm     varchar(32)  NOT NULL,
	litigation_no  integer      NOT NULL,
	
	FOREIGN KEY (company_nm) 
		REFERENCES law.company(company_nm)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	FOREIGN KEY (litigation_no) 
		REFERENCES law.litigation(litigation_no)
			ON DELETE CASCADE
			ON UPDATE CASCADE
);

