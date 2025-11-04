-- ========== 3. PL/SQL: PROCEDURES, FUNCTION, TRIGGER ==========

-- 3.1 Procedure: generate_payroll for single employee
CREATE OR REPLACE PROCEDURE generate_payroll (
    p_emp_id     employees.emp_id%TYPE,
    p_month_year IN VARCHAR2
) AS
    v_basic       salary_structure.basic_pay%TYPE;
    v_hra_p       salary_structure.hra_percent%TYPE;
    v_da_p        salary_structure.da_percent%TYPE;
    v_tax_p       salary_structure.tax_percent%TYPE;
    v_pf_p        salary_structure.pf_percent%TYPE;
    v_present     attendance.present_days%TYPE;
    v_total       attendance.total_days%TYPE;
    v_hra         NUMBER;
    v_da          NUMBER;
    v_tax         NUMBER;
    v_pf          NUMBER;
    v_leave_ded   NUMBER;
    v_gross       NUMBER;
    v_deductions  NUMBER;
    v_net         NUMBER(9,2);
BEGIN
    -- get base and percents
    SELECT s.basic_pay, s.hra_percent, s.da_percent, s.tax_percent, s.pf_percent
    INTO v_basic, v_hra_p, v_da_p, v_tax_p, v_pf_p
    FROM salary_structure s
    JOIN employees e ON e.salary_id = s.salary_id
    WHERE e.emp_id = p_emp_id;

    -- get attendance
    SELECT present_days, total_days
    INTO v_present, v_total
    FROM attendance
    WHERE emp_id = p_emp_id AND month_year = p_month_year;

    -- calculate components
    v_hra := (v_hra_p/100) * v_basic;
    v_da  := (v_da_p/100) * v_basic;
    v_tax := (v_tax_p/100) * v_basic;
    v_pf  := (v_pf_p/100) * v_basic;

    v_gross := v_basic + v_hra + v_da;
    v_leave_ded := (v_basic / v_total) * (v_total - v_present);
    v_deductions := v_tax + v_pf + v_leave_ded;
    v_net := v_gross - v_deductions;

    -- upsert into payroll: if exists update else insert
    BEGIN
        UPDATE payroll
        SET gross_salary = v_gross,
            deductions = v_deductions,
            net_salary = v_net,
            generated_on = SYSDATE
        WHERE emp_id = p_emp_id AND month_year = p_month_year;

        IF SQL%ROWCOUNT = 0 THEN
            INSERT INTO payroll (emp_id, month_year, gross_salary, deductions, net_salary)
            VALUES (p_emp_id, p_month_year, v_gross, v_deductions, v_net);
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Payroll generated for employee '||p_emp_id||' month '||p_month_year||' : Net='||TO_CHAR(v_net));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Missing data for employee '||p_emp_id||' or attendance for '||p_month_year);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: '||SQLERRM);
END;
/
-- 3.2 Procedure: generate_all_payroll for all employees
CREATE OR REPLACE PROCEDURE generate_all_payroll (
    p_month_year IN VARCHAR2
) AS
BEGIN
    FOR r IN (SELECT emp_id FROM employees) LOOP
        BEGIN
            generate_payroll(r.emp_id, p_month_year);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Failed for '||r.emp_id||' : '||SQLERRM);
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Payroll generation completed for '||p_month_year);
END;
/
-- 3.3 Procedure: view_salary_slip
CREATE OR REPLACE PROCEDURE view_salary_slip (
    p_emp_id IN NUMBER,
    p_month_year IN VARCHAR2
) AS
    v_name employees.emp_name%TYPE;
    v_gross payroll.gross_salary%TYPE;
    v_ded  payroll.deductions%TYPE;
    v_net  payroll.net_salary%TYPE;
    v_date payroll.generated_on%TYPE;
BEGIN
    SELECT e.emp_name, p.gross_salary, p.deductions, p.net_salary, p.generated_on
    INTO v_name, v_gross, v_ded, v_net, v_date
    FROM payroll p JOIN employees e ON e.emp_id = p.emp_id
    WHERE p.emp_id = p_emp_id AND p.month_year = p_month_year;

    DBMS_OUTPUT.PUT_LINE('--- Salary Slip ---');
    DBMS_OUTPUT.PUT_LINE('Employee : '||v_name||' ('||p_emp_id||')');
    DBMS_OUTPUT.PUT_LINE('Month    : '||p_month_year);
    DBMS_OUTPUT.PUT_LINE('Gross    : '||v_gross);
    DBMS_OUTPUT.PUT_LINE('Deductions: '||v_ded);
    DBMS_OUTPUT.PUT_LINE('Net Salary: '||v_net);
    DBMS_OUTPUT.PUT_LINE('Generated On: '||v_date);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No payroll found for '||p_emp_id||' and month '||p_month_year);
END;
/
-- 3.4 Procedure: monthly_payroll_summary
CREATE OR REPLACE PROCEDURE monthly_payroll_summary (
    p_month_year IN VARCHAR2
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Monthly Payroll Summary for '||p_month_year||' ---');
    FOR rec IN (
        SELECT e.emp_id, e.emp_name, p.net_salary
        FROM payroll p JOIN employees e ON e.emp_id = p.emp_id
        WHERE p.month_year = p_month_year
        ORDER BY e.emp_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('ID:'||rec.emp_id||' | '||rec.emp_name||' | Net: '||rec.net_salary);
    END LOOP;
END;
/
-- 3.5 Function: total_salary_expense
CREATE OR REPLACE FUNCTION total_salary_expense (
    p_month_year IN VARCHAR2
) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(net_salary),0) INTO v_total FROM payroll WHERE month_year = p_month_year;
    RETURN v_total;
EXCEPTION
    WHEN OTHERS THEN
        RETURN 0;
END;
/
