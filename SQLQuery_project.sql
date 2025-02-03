--- Churn dataset

select * from [dbo].[telcom_clean_data#csv$];

--  Scenario 1: Analyze Churn Rate

SELECT    ROUND(COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*),  2) AS Churn_Rate
FROM  [dbo].[telcom_clean_data#csv$] ;



-- 2 Top Cities with Highest Churn Rate

SELECT City, COUNT(*) AS Churned_Customers, 
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM  [dbo].[telcom_clean_data#csv$]   WHERE Churn = 1)) AS Churn_Percentage
FROM  [dbo].[telcom_clean_data#csv$]
WHERE Churn = 1
GROUP BY City
HAVING COUNT(*) > 0
ORDER BY Churn_Percentage DESC;
 


 -- 3  Revenue Contribution by Age Group
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


--4  Effect of Online Security on Churn

SELECT 
    [Online Security], 
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) AS Churned_Customers,
    (SUM(CASE WHEN Churn = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Churn_Rate
FROM [dbo].[telcom_clean_data#csv$]
GROUP BY [Online Security]
HAVING [Online Security] IS NOT NULL
ORDER BY Churn_Rate DESC;



-- 5 Average Monthly Charges by Contract Type

SELECT 
    [Contract], 
    COUNT(*) AS Total_Customers,
    AVG([Monthly Charge]) AS Avg_Monthly_Charge

FROM [dbo].[telcom_clean_data#csv$]
WHERE [Monthly Charge] IS NOT NULL
GROUP BY [Contract]
ORDER BY Avg_Monthly_Charge DESC;

-- 6 Identify regions(city)  with the highest churn.

SELECT 
    City, 
    COUNT(CASE WHEN Churn = 1 THEN 1 END) AS ChurnedCustomers,
    COUNT(*) AS TotalCustomers,
    (COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRate
FROM  [dbo].[telcom_clean_data#csv$]
GROUP BY City
ORDER BY ChurnRate DESC;

--  7 Impact of Paperless Billing on Churn
SELECT 
    [Paperless Billing],
    COUNT(CASE WHEN Churn = 1 THEN 1 END) AS ChurnedCustomers,
    COUNT(*) AS TotalCustomers,
    (COUNT(CASE WHEN Churn = 1 THEN 1 END) * 100.0 / COUNT(*)) AS ChurnRate
FROM  [dbo].[telcom_clean_data#csv$]
GROUP BY [Paperless Billing]
ORDER BY ChurnRate DESC;

-- 8   Customer Lifetime Value (CLTV) Segmentation

SELECT 
    CASE 
        WHEN CLTV > 5000 THEN 'High Value'
        WHEN CLTV BETWEEN 2000 AND 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CLTV_Segment, 
    COUNT(*) AS CustomerCount
FROM  [dbo].[telcom_clean_data#csv$]
GROUP BY 
    CASE 
        WHEN CLTV > 5000 THEN 'High Value'
        WHEN CLTV BETWEEN 2000 AND 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END
ORDER BY CustomerCount DESC;
