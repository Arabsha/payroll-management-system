
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
