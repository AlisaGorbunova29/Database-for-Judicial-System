-- Триггер на кол-во решённых дел у судьи. Обновляется, когда либо добавляется новое дело со статусом "решено (>0)"
-- или изменяется статус на "решено (>0)"
CREATE OR REPLACE FUNCTION update_solved_litigation_cnt() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
    IF (NEW.status_value >= 1 AND (OLD.status_value = 0 or OLD.status_value is NULL)) THEN
      UPDATE law.judge SET solved_litigation_cnt = solved_litigation_cnt + 1 WHERE judge_nm = NEW.judge_nm;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER update_solved_litigation_cnt_trigger 
AFTER INSERT OR UPDATE ON law.litigation FOR EACH ROW
EXECUTE FUNCTION update_solved_litigation_cnt(); 



-- Tриггер на кол-во дел, которые рассматриваются больше 6 месяцев. Обновляется, когда в таблице появляется дело,
-- которое рассматриваются дольше 6 месяцев
CREATE OR REPLACE FUNCTION update_long_litigation_cnt() RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'UPDATE') THEN
    IF (((EXTRACT(YEAR FROM age(NEW.next_sitting_dt, NEW.opening_sitting_dt)) * 12) + 
		 EXTRACT(MONTH FROM age(NEW.next_sitting_dt, NEW.opening_sitting_dt))) > 6 AND 
		((EXTRACT(YEAR FROM age(OLD.next_sitting_dt, OLD.opening_sitting_dt)) * 12) + 
		 EXTRACT(MONTH FROM age(OLD.next_sitting_dt, OLD.opening_sitting_dt))) <= 6
		) THEN
      UPDATE law.judge SET long_litigation_cnt = long_litigation_cnt + 1 WHERE judge_nm = NEW.judge_nm;
    END IF;
  END IF;
  IF (TG_OP = 'INSERT') THEN
    IF (((EXTRACT(YEAR FROM age(NEW.next_sitting_dt, NEW.opening_sitting_dt)) * 12) + 
		 EXTRACT(MONTH FROM age(NEW.next_sitting_dt, NEW.opening_sitting_dt))) > 6) AND 
		THEN
      UPDATE law.judge SET long_litigation_cnt = long_litigation_cnt + 1 WHERE judge_nm = NEW.judge_nm;
    END IF;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER update_long_litigation_cnt_trigger 
AFTER INSERT OR UPDATE ON law.litigation FOR EACH ROW
EXECUTE FUNCTION update_long_litigation_cnt(); 
