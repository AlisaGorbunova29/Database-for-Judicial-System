-- функция law.get_layer возвращает по номеру дела юриста, который в нём учавствуют.
 CREATE OR REPLACE FUNCTION law.get_layer(lit_no int)
 RETURNS TABLE (
	 layer_nm VARCHAR(32),
	 legal_team_nm VARCHAR(32),
	 cost_value INTEGER
 ) 
 AS 
 $$
 BEGIN
 	RETURN QUERY
 	SELECT
	 	comp.layer_nm,
	 	lay.legal_team_nm,
	 	lay.cost_value
	FROM law.plaintiff AS plf
		JOIN law.company AS comp ON plf.company_nm = comp.company_nm
		JOIN law.layer AS  lay ON comp.layer_nm = lay.layer_nm
	WHERE comp.layer_nm IS NOT NULL AND plf.litigation_no = lit_no
	UNION ALL
	SELECT
	 	comp.layer_nm,
	 	lay.legal_team_nm,
	 	lay.cost_value
	FROM law.defendant AS def
		JOIN law.company AS comp ON def.company_nm = comp.company_nm
		JOIN law.layer AS  lay ON comp.layer_nm = lay.layer_nm
	WHERE comp.layer_nm IS NOT NULL AND def.litigation_no = lit_no;
 END;
 $$ LANGUAGE plpgsql;
 
 -- функция law.top_legal_team возвращает таблицу,содержающую информацию 
 -- о самом лучшем (по кол-во выгранных дел) юристе по названию юридической контора
 CREATE OR REPLACE FUNCTION law.top_legal_team(team_nm VARCHAR(32))
 RETURNS TABLE(
	 layer_nm VARCHAR(32),
	 successful_case_cnt INTEGER
 )
 AS
 $$
 BEGIN
 	 RETURN QUERY
	 SELECT 
		lay.layer_nm,
		lay.successful_case_cnt
	 FROM law.layer AS lay
		JOIN law.legal_team AS team ON lay.legal_team_nm = team.legal_team_nm
	 WHERE team.legal_team_nm = team_nm
	 ORDER BY lay.successful_case_cnt DESC
	 LIMIT 1;
 END;
 $$ LANGUAGE plpgsql;
 
 
 --функция, удаляющая судей, у которых нет дел в производстве (т.е. в таблице дел).
CREATE FUNCTION law.delete_judges() 
RETURNS VOID 
AS 
$$
BEGIN
    DELETE FROM law.judge j
    WHERE NOT EXISTS (
        SELECT 1 
        FROM law.litigation l 
        WHERE l.judge_nm = j.judge_nm
    );
END;
$$ LANGUAGE plpgsql;
 

