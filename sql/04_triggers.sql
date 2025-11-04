-- 3.6 Trigger: attendance validation (before insert/update)
CREATE OR REPLACE TRIGGER trg_check_attendance
BEFORE INSERT OR UPDATE ON attendance
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- check employee exists
    SELECT COUNT(*) INTO v_count FROM employees WHERE emp_id = :NEW.emp_id;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist: '||:NEW.emp_id);
    END IF;

    -- validate present_days <= total_days
    IF :NEW.present_days < 0 OR :NEW.present_days > :NEW.total_days THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid present_days for emp '||:NEW.emp_id);
    END IF;
END;
/
-- End of Script
