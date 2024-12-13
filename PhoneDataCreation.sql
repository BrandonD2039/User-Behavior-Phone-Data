-- In order to insert the data from a .csv file, I first had to create a table with the proper data types.

create table phonedata (
User_ID int,
Device_Model varchar (20),
Operating_System varchar(20),
App_Usage_Time int,
Screen_On_Time numeric,
Battery_Drain int,
Apps_Installed int,
Data_Usage int,
Age int,
Gender varchar(20),
User_Behavior_Class int
);
/* 
Further Steps
1. Ensure the dataset was saved as a .csv 
2. Deleted the first row of data in the excel file (This was the headers)
3. From this point, I went over to PostgreSQL and imported the data
*/ 

--In order to get the correct insights out of the data, the correct questions have to be asked. Starting off, I did some analysis on the general usage of the data.

-- General Usage of Data

-- Average Data Usage by Behavior Class

SELECT user_behavior_class, avg(data_usage) AS "Average Data Use"
FROM phonedata
GROUP BY user_behavior_class
ORDER BY user_behavior_class;


-- Average App Usage Time sorted by Operating System

SELECT operating_system, avg(app_usage_time) AS "Average Use"
FROM phonedata
GROUP BY operating_system
ORDER BY operating_system;

-- Average App Usage Time sorted by Device Model

SELECT device_model, avg(app_usage_time) AS "Average Use"
FROM phonedata
GROUP BY device_model
ORDER BY device_model;

-- Comparing the 5 user behavior classes by their screen time; ordered by ascending screen time

SELECT user_behavior_class, avg(screen_on_time) AS "Screen Time"
FROM phonedata
GROUP BY user_behavior_class
ORDER BY "Screen Time" ASC;

-- Demographic Insights

