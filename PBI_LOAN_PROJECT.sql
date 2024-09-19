create database PBI_LOAN_PROJECT;
USE PBI_LOAN_PROJECT;
select * from loan;

desc loan;

SET SQL_SAFE_UPDATES = 0;


UPDATE loan 
SET issue_date = STR_TO_DATE(issue_date, '%d-%m-%Y');
UPDATE loan 
SET last_credit_pull_date  = STR_TO_DATE(last_credit_pull_date, '%d-%m-%Y');
Update loan
SET last_payment_date  = STR_TO_DATE(last_payment_date, '%d-%m-%Y');
update loan
set next_payment_date  = STR_TO_DATE(next_payment_date, '%d-%m-%Y');


alter table loan
modify issue_date date;
alter table loan
modify last_credit_pull_date date;
alter table loan
modify last_payment_date date;
alter table loan
modify next_payment_date date;

select * from loan;

SELECT COUNT(id) AS Total_Loan_Applications FROM loan;

SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

-- MTD-PMTD/PMTD( For comparing the monthly percentage increase or decrease of loan applications )

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM loan;

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

select * from loan;

SELECT SUM(total_payment) AS Total_Amount_Received FROM loan;

SELECT SUM(total_payment) AS MTD_Total_Amount_Received FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate)*100,2) AS Avg_Interest_Rate FROM loan;
-- It is in percentage so we have to multiply it by 100


SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Avg_Interest_Rate FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Avg_Interest_Rate FROM loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(dti)*100,2) AS Avg_DTI FROM loan;

SELECT ROUND(AVG(dti)*100,2) AS MTD_Avg_DTI FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021;

SELECT ROUND(AVG(dti)*100,2) AS PMTD_Avg_DTI FROM loan
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021;

SELECT  (COUNT(CASE WHEN loan_status = "Fully Paid" OR loan_status = "Current" THEN ID END)*100)
		/
		COUNT(id) AS Good_Loan_Percentage
FROM loan;

SELECT COUNT(id) AS Good_Loan_Applications FROM loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";

SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM loan
WHERE loan_status = "Fully Paid" OR loan_status = "Current";



SELECT  (COUNT(CASE WHEN loan_status = "Charged off" THEN ID END)*100)
		/
		COUNT(id) AS Bad_Loan_Percentage
FROM loan;

SELECT COUNT(id) AS Bad_Loan_Applications FROM loan
WHERE loan_status = "Charged off";

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM loan
WHERE loan_status = "Charged off";

SELECT SUM(total_payment) AS Bad_Loan_Received_Amount FROM loan
WHERE loan_status = "Charged off";

SELECT loan_status,
COUNT(id) AS Total_Applocations_Count,
SUM(total_payment) AS Total_amount_Received,
SUM(loan_amount) AS Total_Amount_Funded,
ROUND(AVG(int_rate * 100),2) AS Average_Interest_rate,
ROUND(AVG(dti * 100),2) AS Average_DTI
FROM loan
GROUP BY loan_status;

SELECT loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Amount_Funded
FROM loan
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021
GROUP BY loan_status;

select * from loan;


SELECT
        MONTH(issue_date) AS Month_Number,
        MONTHNAME(issue_date) AS Month_Name,
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Loan_Funded,
        SUM(total_payment) AS Total_Received_Amount
FROM loan
GROUP BY MONTH(issue_date), MONTHNAME(issue_date)
ORDER BY MONTH(issue_date), MONTHNAME(issue_date);


SELECT
        address_state,
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Loan_Funded,
        SUM(total_payment) AS Total_Received_Amount
FROM loan
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;


SELECT
        emp_length,
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Loan_Funded,
        SUM(total_payment) AS Total_Received_Amount
FROM loan
GROUP BY emp_length
ORDER BY emp_length;

SELECT
        purpose,
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Loan_Funded,
        SUM(total_payment) AS Total_Received_Amount
FROM loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;


SELECT
        home_ownership,
        COUNT(id) AS Total_Loan_Applications,
        SUM(loan_amount) AS Total_Loan_Funded,
        SUM(total_payment) AS Total_Received_Amount
FROM loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


