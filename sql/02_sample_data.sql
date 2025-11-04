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
