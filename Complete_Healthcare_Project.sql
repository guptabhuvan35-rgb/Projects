-- Healthcare Data Analysis Project by Bhuvan Gupta
-- Complete SQL Script (Schema + All Queries)

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS Healthcare;
USE Healthcare;

-- 2. Create Table Schema (Compatible with all queries)
DROP TABLE IF EXISTS Healthcare;

CREATE TABLE Healthcare (
    Patient_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(200),
    Age INT,
    Gender VARCHAR(20),
    Medical_Condition VARCHAR(200),
    Medication VARCHAR(200),
    Insurance_Provider VARCHAR(200),
    Hospital VARCHAR(200),
    Doctor VARCHAR(200),
    Blood_Type VARCHAR(5),
    Test_Results VARCHAR(50),
    Billing_Amount DECIMAL(10,2),
    Date_of_Admission DATE,
    Discharge_Date DATE
);

-- NOTE: Insert your dataset values below or import CSV externally.
-- Example insert format:
-- INSERT INTO Healthcare (Name, Age, Gender, Medical_Condition, Medication, Insurance_Provider, Hospital, Doctor, Blood_Type, Test_Results, Billing_Amount, Date_of_Admission, Discharge_Date)
-- VALUES ('John Doe', 45, 'Male', 'Diabetes', 'Metformin', 'ABC Insurance', 'City Hospital', 'Dr. Smith', 'O+', 'Normal', 12000.50, '2024-03-12', '2024-03-15');

-----------------------------------------------------------
-- ALL ANALYSIS QUERIES BELOW
-----------------------------------------------------------

-- 1. Count total records
SELECT COUNT(*) FROM Healthcare;

-- 2. Max age
SELECT MAX(Age) AS Maximum_Age FROM Healthcare;

-- 3. Average age
SELECT ROUND(AVG(Age),0) AS Average_Age FROM Healthcare;

-- 4. Age-wise distribution
SELECT Age, COUNT(*) AS Total FROM Healthcare GROUP BY Age ORDER BY Age DESC;

-- 5. Highest age count
SELECT Age, COUNT(*) AS Total FROM Healthcare GROUP BY Age ORDER BY Total DESC, Age DESC;

-- 6. Ranking ages
SELECT Age, COUNT(*) AS Total,
DENSE_RANK() OVER(ORDER BY COUNT(*) DESC, Age DESC) AS Ranking_Admitted
FROM Healthcare GROUP BY Age;

-- 7. Medical condition distribution
SELECT Medical_Condition, COUNT(*) AS Total_Patients
FROM Healthcare GROUP BY Medical_Condition ORDER BY Total_Patients DESC;

-- 8. Medication ranking per condition
SELECT Medical_Condition, Medication, COUNT(*) AS Total_Medications_to_Patients,
RANK() OVER(PARTITION BY Medical_Condition ORDER BY COUNT(*) DESC) AS Rank_Medicine
FROM Healthcare GROUP BY Medical_Condition, Medication;

-- 9. Most preferred insurance
SELECT Insurance_Provider, COUNT(*) AS Total
FROM Healthcare GROUP BY Insurance_Provider ORDER BY Total DESC;

-- 10. Most preferred hospital
SELECT Hospital, COUNT(*) AS Total
FROM Healthcare GROUP BY Hospital ORDER BY Total DESC;

-- 11. Average billing by condition
SELECT Medical_Condition, ROUND(AVG(Billing_Amount),2) AS Avg_Billing_Amount
FROM Healthcare GROUP BY Medical_Condition;

-- 12. Billing & stay duration
SELECT Medical_Condition, Name, Hospital,
DATEDIFF(Discharge_Date, Date_of_Admission) AS Number_of_Days,
SUM(Billing_Amount) OVER(PARTITION BY Hospital) AS Total_Amount
FROM Healthcare;

-- 13. Stay duration
SELECT Name, Medical_Condition, Billing_Amount,
Hospital, DATEDIFF(Discharge_Date, Date_of_Admission) AS Total_Hospitalized_days
FROM Healthcare;

-- 14. Normal test results
SELECT Medical_Condition, Hospital,
DATEDIFF(Discharge_Date, Date_of_Admission) AS Total_Hospitalized_days, Test_Results
FROM Healthcare WHERE Test_Results = 'Normal';

-- 15. Blood type distribution for age 20–45
SELECT Age, Blood_Type, COUNT(*) AS Count_Blood_Type
FROM Healthcare WHERE Age BETWEEN 20 AND 45 GROUP BY Age, Blood_Type;

-- 16. Universal donor & receiver count
SELECT 
(SELECT COUNT(*) FROM Healthcare WHERE Blood_Type='O-') AS Universal_Donor,
(SELECT COUNT(*) FROM Healthcare WHERE Blood_Type='AB+') AS Universal_Receiver;

-- 17. Blood matching procedure
DELIMITER $$
CREATE PROCEDURE Blood_Matcher(IN Patient_Name VARCHAR(200))
BEGIN 
SELECT D.Name AS Donor_Name, D.Age AS Donor_Age, D.Blood_Type AS Donor_Blood,
D.Hospital AS Donor_Hospital, R.Name AS Receiver_Name,
R.Age AS Receiver_Age, R.Blood_Type AS Receiver_Blood, R.Hospital AS Receiver_Hospital
FROM Healthcare D
JOIN Healthcare R ON D.Blood_Type='O-' AND R.Blood_Type='AB+'
WHERE R.Name REGEXP Patient_Name AND D.Age BETWEEN 20 AND 40;
END$$
DELIMITER ;

-- 18. Admissions in 2024 & 2025
SELECT Hospital, COUNT(*) AS Total_Admitted
FROM Healthcare
WHERE YEAR(Date_of_Admission) IN (2024, 2025)
GROUP BY Hospital ORDER BY Total_Admitted DESC;

-- 19. Billing statistics by insurance
SELECT Insurance_Provider,
ROUND(AVG(Billing_Amount),0) AS Average_Amount,
ROUND(MIN(Billing_Amount),0) AS Minimum_Amount,
ROUND(MAX(Billing_Amount),0) AS Maximum_Amount
FROM Healthcare GROUP BY Insurance_Provider;

-- 20. Risk category based on test results
SELECT Name, Medical_Condition, Test_Results,
CASE 
    WHEN Test_Results = 'Inconclusive' THEN 'Need More Checks'
    WHEN Test_Results = 'Normal' THEN 'Discharge Allowed'
    WHEN Test_Results = 'Abnormal' THEN 'Critical'
END AS Status, Hospital, Doctor
FROM Healthcare;

-- 21. Total patients by blood group
SELECT Blood_Type, COUNT(*) AS Total_Patient
FROM Healthcare GROUP BY Blood_Type;

-- 22. Total billing per insurance provider
SELECT Insurance_Provider, ROUND(SUM(Billing_Amount),2) AS Total_Amount
FROM Healthcare GROUP BY Insurance_Provider;
