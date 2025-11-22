# Healthcare Data Analysis Using SQL  
### Project by **Bhuvan Gupta**

---

## 📌 Project Overview  
This project is a complete SQL-based analysis of a synthetic **Healthcare** dataset.  
It includes a fully defined database schema, 22 analytical SQL queries, and a stored procedure for donor–recipient blood matching.

The goal of this project is to demonstrate SQL skills in:  
- Data Exploration  
- Aggregation & Grouping  
- Window Functions  
- Stored Procedures  
- Date Functions  
- Healthcare Analytics  
- Ranking & Distribution Analysis  

---

## 📁 Included Files  
### **1. Complete_Healthcare_Project.sql**  
This file contains:  
✔ Database creation script  
✔ Table schema  
✔ All queries (1–22)  
✔ Stored procedure `Blood_Matcher`  
✔ Comments explaining each section  

### **2. README.md**  
Documentation explaining project purpose, usage, and instructions.

---

## 🗂️ Database Schema  

```
Healthcare (
    Patient_ID INT PRIMARY KEY AUTO_INCREMENT,
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
)
```

This schema supports all analytics performed in the SQL project.

---

## 🧪 Analytical Objectives  
The SQL script answers the following questions:

1. Count total patients  
2. Maximum age  
3. Average age  
4. Age-wise distribution  
5. Highest patient age group  
6. Rank ages by patient count  
7. Frequency of medical conditions  
8. Medication ranking within each disease  
9. Most preferred insurance provider  
10. Most preferred hospital  
11. Average billing per condition  
12. Billing summary with hospital stay  
13. Total days hospitalized  
14. Patients discharged with *Normal* test results  
15. Blood type distribution (age 20–45)  
16. Count universal donors & recipients  
17. **Stored Procedure:** Match O− donors to AB+ recipients  
18. Admissions in 2024 & 2025  
19. Billing statistics per insurance  
20. Patient risk category (Normal / Abnormal / Inconclusive)  
21. Patient count by blood group  
22. Total billing per insurance provider  

---

## 🚀 How to Use the Project  

### **Step 1 — Open MySQL Workbench**  
### **Step 2 — Load `Complete_Healthcare_Project.sql`**  
### **Step 3 — Execute Entire Script**  

You may:  
- Manually insert data into the Healthcare table, OR  
- Import your CSV file using MySQL Workbench → Table Data Import Wizard  

Once data is loaded, all 22 queries will generate insights.

---

## 👨‍💻 Author  
**Bhuvan Gupta**  
