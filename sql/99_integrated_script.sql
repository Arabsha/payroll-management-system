
-- Payroll Management System - Final Integrated SQL Script 
-- Author: Arabsha (Self Project)
-- Date: October 2025

-- ========== 1. TABLE CREATION ==========
-- 1.1 Departments
CREATE TABLE departments (
    dept_id     NUMBER PRIMARY KEY,
    dept_name   VARCHAR2(50) NOT NULL,
    location    VARCHAR2(50)
);

-- 1.2 Salary Structure (percentages for HRA, DA, Tax, PF)
CREATE TABLE salary_structure (
    salary_id     NUMBER PRIMARY KEY,
    basic_pay     NUMBER(10,2) NOT NULL,
    hra_percent   NUMBER(5,2) DEFAULT 0,
    da_percent    NUMBER(5,2) DEFAULT 0,
    tax_percent   NUMBER(5,2) DEFAULT 0,
    pf_percent    NUMBER(5,2) DEFAULT 0
);

-- 1.3 Employees
CREATE TABLE employees (
    emp_id      NUMBER PRIMARY KEY,
    emp_name    VARCHAR2(100) NOT NULL,
    gender      VARCHAR2(10),
    job_title   VARCHAR2(50),
    dept_id     NUMBER REFERENCES departments(dept_id),
    salary_id   NUMBER REFERENCES salary_structure(salary_id),
    hire_date   DATE
);

-- 1.4 Attendance (composite PK: emp_id + month_year)
CREATE TABLE attendance (
    emp_id       NUMBER,
    month_year   VARCHAR2(7), -- 'YYYY-MM'
    present_days NUMBER(3) CHECK (present_days >= 0),
    total_days   NUMBER(3) DEFAULT 30 CHECK (total_days > 0),
    CONSTRAINT pk_attendance PRIMARY KEY (emp_id, month_year),
    CONSTRAINT fk_att_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- 1.5 Payroll (composite PK: emp_id + month_year)
CREATE TABLE payroll (
    emp_id       NUMBER,
    month_year   VARCHAR2(7),
    gross_salary NUMBER(12,2),
    deductions   NUMBER(12,2),
    net_salary   NUMBER(12,2),
    generated_on DATE DEFAULT SYSDATE,
    CONSTRAINT pk_payroll PRIMARY KEY (emp_id, month_year),
    CONSTRAINT fk_pay_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- ========== 2. SAMPLE DATA ==========
-- 2.1 Departments
INSERT INTO departments VALUES (1, 'HR', 'Chennai');
INSERT INTO departments VALUES (2, 'Finance', 'Mumbai');
INSERT INTO departments VALUES (3, 'IT', 'Bangalore');
INSERT INTO departments VALUES (4, 'Sales', 'Hyderabad');
INSERT INTO departments VALUES (5, 'Admin', 'Delhi');

-- 2.2 Salary Structure (basic_pay, hra%, da%, tax%, pf%)
INSERT INTO salary_structure VALUES (1, 30000, 20, 10, 5, 12);
INSERT INTO salary_structure VALUES (2, 35000, 18, 9, 6, 12);
INSERT INTO salary_structure VALUES (3, 40000, 22, 11, 7, 12);
INSERT INTO salary_structure VALUES (4, 45000, 20, 10, 8, 13);
INSERT INTO salary_structure VALUES (5, 50000, 25, 12, 8, 13);

-- 2.3 Employees (emp_id, name, gender, job_title, dept_id, salary_id, hire_date)
INSERT INTO employees VALUES (101, 'John Louis', 'Male', 'HR Executive', 1, 1, TO_DATE('2022-03-15','YYYY-MM-DD'));
INSERT INTO employees VALUES (102, 'Divya Bharati', 'Female', 'Finance Analyst', 2, 2, TO_DATE('2021-07-10','YYYY-MM-DD'));
INSERT INTO employees VALUES (103, 'Khaja Mohideen', 'Male', 'Software Developer', 3, 3, TO_DATE('2023-01-20','YYYY-MM-DD'));
INSERT INTO employees VALUES (104, 'Padma Shree', 'Female', 'Sales Representative', 4, 3, TO_DATE('2022-09-01','YYYY-MM-DD'));
INSERT INTO employees VALUES (105, 'Shyam Kumar', 'Male', 'Admin Officer', 5, 2, TO_DATE('2021-11-25','YYYY-MM-DD'));
INSERT INTO employees VALUES (106, 'Aparna Das', 'Female', 'Database Administrator', 3, 4, TO_DATE('2023-02-05','YYYY-MM-DD'));
INSERT INTO employees VALUES (107, 'Vinoth Kumar', 'Male', 'HR Assistant', 1, 1, TO_DATE('2022-05-30','YYYY-MM-DD'));
INSERT INTO employees VALUES (108, 'Mohammed Yusuf', 'Male', 'Sales Manager', 4, 5, TO_DATE('2020-12-14','YYYY-MM-DD'));
INSERT INTO employees VALUES (109, 'Simran Kaur', 'Female', 'Accountant', 2, 2, TO_DATE('2021-08-18','YYYY-MM-DD'));
INSERT INTO employees VALUES (110, 'Jacob Raj', 'Male', 'System Analyst', 3, 3, TO_DATE('2023-04-11','YYYY-MM-DD'));
INSERT INTO employees VALUES (111, 'Sundar Venkat', 'Male', 'Network Engineer', 3, 2, TO_DATE('2023-08-25','YYYY-MM-DD'));
INSERT INTO employees VALUES (112, 'Pooja Mahesh', 'Female', 'Talent Acquisition Executive', 1, 3, TO_DATE('2024-02-19','YYYY-MM-DD'));
INSERT INTO employees VALUES (113, 'Hari Haran', 'Male', 'Audit Associate', 2, 4, TO_DATE('2022-11-10','YYYY-MM-DD'));
INSERT INTO employees VALUES (114, 'Asma Banu', 'Female', 'Office Coordinator', 5, 1, TO_DATE('2022-09-06','YYYY-MM-DD'));
INSERT INTO employees VALUES (115, 'Mohammed Zubair', 'Male', 'Data Analyst', 3, 3, TO_DATE('2023-04-15','YYYY-MM-DD'));
INSERT INTO employees VALUES (116, 'Antony Roselet', 'Female', 'QA Tester', 3, 2, TO_DATE('2021-07-25','YYYY-MM-DD'));
INSERT INTO employees VALUES (117, 'Darun Kumar', 'Male', 'Budget Analyst', 2, 4, TO_DATE('2022-10-20','YYYY-MM-DD'));
INSERT INTO employees VALUES (118, 'Faizal Salahuddin', 'Male', 'UI/UX Designer', 3, 2, TO_DATE('2020-02-04','YYYY-MM-DD'));
INSERT INTO employees VALUES (119, 'Anjali Rao', 'Female', 'Sales Operations Analyst', 4, 3, TO_DATE('2021-05-20','YYYY-MM-DD'));
INSERT INTO employees VALUES (120, 'Priya Singh', 'Female', 'Procurement Officer', 5, 1, TO_DATE('2024-03-15','YYYY-MM-DD'));

-- 2.4 Attendance (emp_id, month_year, present_days, total_days)
INSERT INTO attendance VALUES (101, '2025-10', 28, 31);
INSERT INTO attendance VALUES (102, '2025-10', 30, 31);
INSERT INTO attendance VALUES (103, '2025-10', 27, 31);
INSERT INTO attendance VALUES (104, '2025-10', 29, 31);
INSERT INTO attendance VALUES (105, '2025-10', 30, 31);
INSERT INTO attendance VALUES (106, '2025-10', 26, 31);
INSERT INTO attendance VALUES (107, '2025-10', 28, 31);
INSERT INTO attendance VALUES (108, '2025-10', 30, 31);
INSERT INTO attendance VALUES (109, '2025-10', 29, 31);
INSERT INTO attendance VALUES (110, '2025-10', 25, 31);
INSERT INTO attendance VALUES (111, '2025-10', 27, 31);
INSERT INTO attendance VALUES (112, '2025-10', 26, 31);
INSERT INTO attendance VALUES (113, '2025-10', 26, 31);
INSERT INTO attendance VALUES (114, '2025-10', 28, 31);
INSERT INTO attendance VALUES (115, '2025-10', 30, 31);
INSERT INTO attendance VALUES (116, '2025-10', 31, 31);
INSERT INTO attendance VALUES (117, '2025-10', 28, 31);
INSERT INTO attendance VALUES (118, '2025-10', 25, 31);
INSERT INTO attendance VALUES (119, '2025-10', 29, 31);
INSERT INTO attendance VALUES (120, '2025-10', 31, 31);

COMMIT;

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
CREATE OR REPLACE PROCEDURE view_salary_slip(
    p_emp_id IN NUMBER,
    p_month  IN VARCHAR2
)
IS
    v_emp_name    employees.emp_name%TYPE;
    v_gross       payroll.gross_salary%TYPE;
    v_deductions  payroll.deductions%TYPE;
    v_net         payroll.net_salary%TYPE;
    v_gen_date    DATE;
BEGIN
    SELECT e.emp_name, p.gross_salary, p.deductions, p.net_salary, SYSDATE
      INTO v_emp_name, v_gross, v_deductions, v_net, v_gen_date
      FROM employees e
      JOIN payroll p ON e.emp_id = p.emp_id
     WHERE p.emp_id = p_emp_id
       AND p.month_year = p_month;

    DBMS_OUTPUT.PUT_LINE('--- Salary Slip ---');
    DBMS_OUTPUT.PUT_LINE('Employee     : ' || v_emp_name || ' (' || p_emp_id || ')');
    DBMS_OUTPUT.PUT_LINE('Month        : ' || p_month);
    DBMS_OUTPUT.PUT_LINE('Gross Salary : ' || TO_CHAR(v_gross, '999,999.99'));
    DBMS_OUTPUT.PUT_LINE('Deductions   : ' || TO_CHAR(v_deductions, '999,999.99'));
    DBMS_OUTPUT.PUT_LINE('Net Salary   : ' || TO_CHAR(v_net, '999,999.99'));
    DBMS_OUTPUT.PUT_LINE('Generated On : ' || TO_CHAR(v_gen_date, 'DD-MON-YY'));

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No record found for Employee ID: ' || p_emp_id || ' and Month: ' || p_month);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
-- 3.4 Procedure: monthly_payroll_summary
CREATE OR REPLACE PROCEDURE monthly_payroll_summary(p_month IN VARCHAR2)
IS
  CURSOR c_pay IS
    SELECT e.emp_id,
           e.emp_name,
           p.net_salary
      FROM employees e
      JOIN payroll p
        ON e.emp_id = p.emp_id
     WHERE p.month_year = p_month;

  v_total_expense NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Monthly Payroll Summary for ' || p_month || ' ---');

  FOR rec IN c_pay LOOP
    DBMS_OUTPUT.PUT_LINE(
      'ID:' || rec.emp_id ||
      ' | ' || rec.emp_name ||
      ' | Net: ' || TO_CHAR(rec.net_salary, '99999.99')
    );
    v_total_expense := v_total_expense + rec.net_salary;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('--------------------------------------------');
  DBMS_OUTPUT.PUT_LINE('Total Expense (' || p_month || '): ' ||
                       TO_CHAR(v_total_expense, '999,999.99'));
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No payroll records found for ' || p_month);
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
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
