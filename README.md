# Telecom Churn Analysis

##  Overview

This repository contains SQL queries used to analyze customer churn in a telecom dataset. The dataset is stored in a database table named telcom_clean_data#csv$. The queries provide insights into churn rate, revenue contribution, and factors influencing customer churn.

## SQL Queries and Insights 

### Scenario 1 :  Analyze Churn Rate


    SELECT ROUND(COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*),  2) AS Churn_Rate 
    FROM  [dbo].[telcom_clean_data#csv$] ;
- This query calculates the percentage of customers who have churned.


###  Scenario 2 : Top Cities with Highest Churn Rate

     SELECT City, COUNT(*) AS Churned_Customers,
       (COUNT(*) * 100.0 /   (SELECT COUNT(*) 
         FROM  [dbo].[telcom_clean_data#csv$]  WHERE Churn = 1)) AS Churn_Percentage 
	 
     FROM  [dbo].[telcom_clean_data#csv$]
     WHERE Churn = 1 GROUP BY City HAVING COUNT  (*) > 0ORDER BY Churn_Percentage DESC;  
- This query identifies the cities with the highest churn rate.


###  Scenario 3 : Revenue Contribution by Age Group

    SELECT 
        CASE 
          WHEN Age < 30 THEN 'Under 30'
          WHEN Age BETWEEN 30 AND 50 THEN '30-50'
          ELSE 'Above 50' 
       END AS Age_Group,
	   SUM( [Total Revenue]) as Total_revenue_perc

       FROM  [dbo].[telcom_clean_data#csv$]
     GROUP BY CASE 
          WHEN Age < 30 THEN 'Under 30'
          WHEN Age BETWEEN 30 AND 50 THEN '30-50'
          ELSE 'Above 50' 
       END
    ORDER BY Total_revenue_perc DESC;

- This query calculates the revenue contribution by different age groups.

 
###  Scenario 4: Effect of Online Security on Churn
     
      
      
    SELECT [Online Security], COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS    Churned_Customers,
    (SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Churn_Rate
    
    FROM [dbo].[telcom_clean_data#csv$]
    GROUP BY [Online Security]
    HAVING [Online Security] IS NOT NULL
    ORDER BY Churn_Rate DESC;


- This query examines the impact of online security on churn.
 
###  Scenario 5: Average Monthly Charges by Contract Type

   
    SELECT [Contract], COUNT(*) AS Total_Customers,
    AVG([Monthly Charge]) AS Avg_Monthly_Charge
    
    FROM [dbo].[telcom_clean_data#csv$]
    WHERE [Monthly Charge] IS NOT NULL
    GROUP BY [Contract]
    ORDER BY Avg_Monthly_Charge DESC;

- This query analyzes how average monthly charges vary by contract type.

###  Scenario 6  :  Identify Regions (Cities) with the Highest Churn

    SELECT  City, COUNT(CASE WHEN Churn = 1 THEN 1 END) AS ChurnedCustomers,
    COUNT(*) AS TotalCustomers,
    (COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRate
    
    FROM  [dbo].[telcom_clean_data#csv$]
    GROUP BY City
    ORDER BY ChurnRate DESC;


###  Scenario  7 : Impact of Paperless Billing on Churn

    SELECT  [Paperless Billing],
    COUNT(CASE WHEN Churn = 1 THEN 1 END) AS ChurnedCustomers,
    COUNT(*) AS TotalCustomers,
    (COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRate
    
    FROM  [dbo].[telcom_clean_data#csv$]
    GROUP BY [Paperless Billing]
    ORDER BY ChurnRate DESC;
    
- This query finds cities with the highest churn rate.

- This query assesses the impact of paperless billing on customer churn.

###  Scenario  8 : Customer Lifetime Value (CLTV) Segmentation

- This query categorizes customers based on their Customer Lifetime Value (CLTV)
