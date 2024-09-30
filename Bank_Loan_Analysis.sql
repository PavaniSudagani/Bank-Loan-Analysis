
-- Bank loan Analysis --

create database bankloandb;
use bankloandb;
select * from bankloandata;
describe bankloandata;

------------------------------------ 

-- previously date_issue coloumn was in text datatype I have changed to date format by adding new coloumn named date_issue using below queries 

ALTER TABLE bankloandata
ADD COLUMN date_issue DATE;

UPDATE bankloandata
SET date_issue = STR_TO_DATE(issue_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;

UPDATE bankloandata
SET date_issue = STR_TO_DATE(issue_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;
---------------------------------------- 

-- previously last_credit_pull_date coloumn was in text datatype I have changed to date format by adding new coloumn named last_credit_pull_date using below queries 

ALTER TABLE bankloandata
ADD COLUMN pull_date_last_credit DATE;

UPDATE bankloandata
SET pull_date_last_credit = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;

UPDATE bankloandata
SET pull_date_last_credit = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;

------------------------------- 

-- previously last_payment_date coloumn was in text datatype I have changed to date format by adding new coloumn named last_payment_date using below queries 

ALTER TABLE bankloandata
ADD COLUMN last_paymentdate DATE;

UPDATE bankloandata
SET last_paymentdate = STR_TO_DATE(last_payment_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 0;

UPDATE bankloandata
SET last_paymentdate = STR_TO_DATE(last_payment_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;
--------------------------------------

-- previously next_payment_date coloumn was in text datatype I have changed to date format by adding new coloumn named next_payment_date using below queries 

ALTER TABLE bankloandata
ADD COLUMN next_paymentdate DATE;

UPDATE bankloandata
SET next_paymentdate = STR_TO_DATE(next_payment_date, '%d-%m-%Y');
 
SET SQL_SAFE_UPDATES = 0;

UPDATE bankloandata
SET next_paymentdate = STR_TO_DATE(next_payment_date, '%d-%m-%Y');

SET SQL_SAFE_UPDATES = 1;

------------------------------- 

-- previously annual_income coloumn was in int datatype I have changed to float using below queries 

ALTER TABLE bankloandata
MODIFY annual_income DOUBLE;

--------------------- 

-- Now I have dropped the issue_date coloumn as it is not needed  
ALTER TABLE bankloandata DROP COLUMN issue_date;

-- I have renamned date_issue(new coloumn) to previous coloumn name issue_date 
ALTER TABLE bankloandata
RENAME COLUMN date_issue TO issue_date;

--------------------------------------- 

-- Now I have dropped the last_credit_pull_date coloumn as it is not needed  
ALTER TABLE bankloandata DROP COLUMN last_credit_pull_date;

 -- here I have renamed the pull_date_last_credit(new coloumn) TO last_credit_pull_date (as previous  coloumn name)
ALTER TABLE bankloandata
RENAME COLUMN pull_date_last_credit TO last_credit_pull_date;


-------------------------------------------- 

-- Now I have dropped the last_payment_date coloumn as it is not needed  
ALTER TABLE bankloandata DROP COLUMN last_payment_date;

-- here i had renamed  last_paymentdate(new coloumn) to previous coloumn name
ALTER TABLE bankloandata
RENAME COLUMN last_paymentdate TO last_payment_date;


----------------------------- 

-- Now I have dropped the next_payment_date coloumn as it is not needed  
ALTER TABLE bankloandata DROP COLUMN next_payment_date;

-- here I have renamed next_paymentdate(new coloumn) to previous coloumn name 
ALTER TABLE bankloandata
RENAME COLUMN next_paymentdate TO next_payment_date;

-- -----------------------------------------------------------

-- Total loan applications 
 SELECT COUNT(id) AS Total_Applications FROM bankloandata; 

 -- MTD Loan Applications -- 
 SELECT COUNT(id) AS MTD_total_loan_Applications  FROM bankloandata
WHERE MONTH(issue_date) = 12 and year(issue_date) = 2021;

 -- PMTD Loan Applications -- 
 select count(id) as PMTD_total_loan_Applications from bankloandata
where month(issue_date) = 11 AND year(issue_date) = 2021 ;

-----------------------------------------------------
 
-- Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bankloandata;

-- MTD Total Funded Amount
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bankloandata
WHERE MONTH(issue_date) = 12 AND year(issue_date) = 2021 ;

-- PMTD Total Funded Amount
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM bankloandata
WHERE MONTH(issue_date) = 11 and year(issue_date) = 2021;

------------------------------------------------------

-- Total Amount Received
 SELECT SUM(total_payment) AS Total_Amount_Collected FROM bankloandata;
 
-- MTD Total Amount Received
SELECT SUM(total_payment) AS MTD_Total_Amount_Collected FROM bankloandata
WHERE MONTH(issue_date) = 12 AND year(issue_date) = 2021 ;

-- PMTD Total Amount Received
SELECT SUM(total_payment) AS PMTD_Total_Amount_Collected FROM bankloandata
WHERE MONTH(issue_date) = 11 AND year(issue_date) = 2021 ;

---------------------------------------------------------------------- 

-- Average Interest Rate
select round(avg(int_rate),4) * 100 as avg_interest_rate from bankloandata;

-- MTD Average Interest
select round(avg(int_rate),4) * 100 as MTD_avg_interest_rate from bankloandata
where month(issue_date) = 12 and year(issue_date) = 2021;

-- PMTD Average Interest
select round(avg(int_rate),4) * 100 as PMTD_avg_interest_rate from bankloandata
where month(issue_date) = 11 and year(issue_date) = 2021;

----------------------------------------------------------------------- 

-- Avg DTI
select round(avg(dti), 4)* 100 as avg_dti from bankloandata;

-- MTD Avg DTI
select avg(dti)* 100 as MTD_avg_dti from bankloandata
where month(issue_date) = 12 and year(issue_date) = 2021;

-- PMTD Avg DTI
select round(avg(dti), 4)* 100 as PMTD_avg_dti from bankloandata
where month(issue_date) = 12 and year(issue_date) = 2021;
-------------------------------------------------------------------- 

-- GOOD LOAN ISSUED
-- Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bankloandata;

-- Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bankloandata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bankloandata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bankloandata
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'; 

------------------------------------------------------------------ 

-- BAD LOAN ISSUED
-- Bad Loan Percentage

SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bankloandata;

-- Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bankloandata
WHERE loan_status = 'Charged Off';

-- Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bankloandata
WHERE loan_status = 'Charged Off';

-- Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bankloandata
WHERE loan_status = 'Charged Off';

--------------------------------------------------- 

-- LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bankloandata
    GROUP BY
        loan_status;


SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bankloandata
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status;

----------------------------------------

-- A.	BANK LOAN REPORT | OVERVIEW
 
-- MONTH
SELECT 
	MONTH(issue_date) AS Month_number, 
	MONTHNAME(issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date);

-- STATE
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY address_state
ORDER BY COUNT(id)  Desc;

-- TERM
SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY term
ORDER BY term;

-- EMPLOYEE LENGTH
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY emp_length
ORDER BY COUNT(id) desc;


-- PURPOSE
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY purpose
ORDER BY purpose;

-- HOME OWNERSHIP
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bankloandata
GROUP BY home_ownership
ORDER BY home_ownership;