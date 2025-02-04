# Telecom Churn Analysis

##  Overview

This repository contains SQL queries used to analyze customer churn in a telecom dataset. The dataset is stored in a database table named telcom_clean_data#csv$. The queries provide insights into churn rate, revenue contribution, and factors influencing customer churn.

## SQL Queries and Insights
### Scenario 1 :  Analyze Churn Rate


      SELECT ROUND(COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*),  2) AS Churn_Rate FROM  [dbo].[telcom_clean_data#csv$] ;

- This query calculates the percentage of customers who have churned.


###  Scenario 2 : Top Cities with Highest Churn Rate

     SELECT City, COUNT(*) AS Churned_Customers, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM  [dbo].[telcom_clean_data#csv$]  WHERE Churn = 1)) AS Churn_Percentage FROM  [dbo].[telcom_clean_data#csv$]WHERE Churn = 1 GROUP BY City HAVING COUNT  (*) > 0ORDER BY Churn_Percentage DESC

- This query identifies the cities with the highest churn rate.


###  Scenario 3 : Revenue Contribution by Age Group

- This query calculates the revenue contribution by different age groups.


###  Scenario 4: Effect of Online Security on Churn

- This query examines the impact of online security on churn.

###  Scenario 5: Average Monthly Charges by Contract Type

- This query analyzes how average monthly charges vary by contract type.

###  Scenario 6  :  Identify Regions (Cities) with the Highest Churn

- This query finds cities with the highest churn rate.

###  Scenario  7 : Impact of Paperless Billing on Churn

- This query assesses the impact of paperless billing on customer churn.

###  Scenario  8 : Customer Lifetime Value (CLTV) Segmentation

- This query categorizes customers based on their Customer Lifetime Value (CLTV)
