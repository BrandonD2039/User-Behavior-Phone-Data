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

-- Average Data Usage by Behavior Class

SELECT user_behavior_class, AVG(data_usage) AS "Average Data Use"
FROM phonedata
GROUP BY user_behavior_class
ORDER BY user_behavior_class;

-- Average App Usage Time sorted by Operating System

SELECT operating_system, AVG(app_usage_time) AS "Average Use"
FROM phonedata
GROUP by operating_system
ORDER BY operating_system;

-- Average App Usage Time sorted by Device Model

SELECT device_model, AVG(app_usage_time) AS "Average Use"
FROM phonedata
GROUP BY device_model
ORDER BY device_model;

-- Comparing the 5 user behavior classes by their screen time; ordered by ascending screen time

SELECT user_behavior_class, AVG(screen_on_time) AS "Screen Time"
FROM phonedata
GROUP BY user_behavior_class
ORDER BY "Screen Time" ASC;

-- Comparing the average app usage time to the age and gender of the demographic; ordered by age ascending

SELECT age, gender, AVG(app_usage_time) / 60 AS "App Usage in Hours"
FROM phonedata
GROUP BY age, gender
ORDER BY age ASC;

-- Average screen time in hours by gender

SELECT gender, AVG(screen_on_time) AS "Screen Time in Hours"
FROM phonedata
GROUP BY gender;

-- Distribution of Age based on Behavior Class (And the number in the age range)

SELECT user_behavior_class,
	CASE
		WHEN age <18 THEN 'Under 18'
		WHEN age between 18 and 24 THEN '18-24'
		WHEN age between 25 and 31 THEN '25-31'
		WHEN age between 32 and 38 THEN '32-38'
		WHEN age between 39 and 45 THEN '39-45'
		WHEN AGE > 45 THEN 'Over 45'
	END AS age_range,
COUNT(*) AS count
FROM phonedata
GROUP BY  user_behavior_class, age_range
ORDER BY user_behavior_class, age_range;

-- Device and OS Trends

-- Most common to least common device models for extreme usage

SELECT device_model AS "Device Model", COUNT(device_model) AS "# Of Appearances", user_behavior_class AS "Behavior Level" 
FROM phonedata
WHERE user_behavior_class = 5
GROUP BY device_model, user_behavior_class;

-- Average Data Consumption (In MB) by oeprating system

SELECT operating_system AS "Operating System",
ROUND(avg(data_usage),2) AS "Data Consumption in MB"
FROM phonedata
GROUP BY "Operating System";

-- Battery drain comparison between iOS and Android devices (Daily battery consumption in mAh.)

SELECT operating_system AS "OS",  ROUND(AVG(battery_drain), 2) AS "Average Battery Drain in mAH"
FROM phonedata
GROUP BY operating_system;;

-- To Determine if there is a correlation between data usage (in MB) and app range (with number of instances)

SELECT 
CASE
		WHEN apps_installed BETWEEN 10 AND 20 THEN '10-20'
		WHEN apps_installed BETWEEN 21 AND 30 THEN '21-30'
		WHEN apps_installed BETWEEN 31 AND 40 THEN '31-40'
		WHEN apps_installed BETWEEN 41 AND 50 THEN '41-50'
		WHEN apps_installed BETWEEN 51 AND 60 THEN '51-60'
		WHEN apps_installed BETWEEN 61 AND 70 THEN '61-70'
		WHEN apps_installed BETWEEN 71 AND 80 THEN '71-80'
		WHEN apps_installed BETWEEN 81 AND 90 THEN '81-90'
		WHEN apps_installed BETWEEN 91 AND 100 THEN '91-100'
	END AS app_range,
	CASE
		WHEN data_usage BETWEEN 100 AND 500 THEN '100-500'
		WHEN data_usage BETWEEN 501 AND 1000 THEN '501-1000'
		WHEN data_usage BETWEEN  1001 AND 1500 THEN '1001-1500'
		WHEN data_usage BETWEEN 1501 AND 2000 THEN '1501-2000'
		WHEN data_usage BETWEEN 2001 AND 2500 THEN '2001-2500'
	END AS "Data Usage in Megabytes",
COUNT(*) AS "# Of Instances"
FROM phonedata
GROUP BY app_range, "Data Usage in Megabytes"
ORDER BY app_range, "Data Usage in Megabytes";

-- Behavioral Insights

-- To Determine if there is a correlation between data usage (in MB) and app range (with number of instances)

SELECT
CASE
		WHEN apps_installed BETWEEN 10 AND 20 THEN '10-20'
		WHEN apps_installed BETWEEN 21 AND 30 THEN '21-30'
		WHEN apps_installed BETWEEN 31 AND 40 THEN '31-40'
		WHEN apps_installed BETWEEN 41 AND 50 THEN '41-50'
		WHEN apps_installed BETWEEN 51 AND 60 THEN '51-60'
		WHEN apps_installed BETWEEN 61 AND 70 THEN '61-70'
		WHEN apps_installed BETWEEN 71 AND 80 THEN '71-80'
		WHEN apps_installed BETWEEN 81 AND 90 THEN '81-90'
		WHEN apps_installed BETWEEN 91 AND 100 THEN '91-100'
	END AS app_range,
	CASE
		WHEN data_usage BETWEEN 100 AND 500 THEN '100-500'
		WHEN data_usage BETWEEN 501 AND 1000 THEN '501-1000'
		WHEN data_usage BETWEEN 1001 AND 1500 THEN '1001-1500'
		WHEN data_usage BETWEEN 1501 AND 2000 THEN '1501-2000'
		WHEN data_usage BETWEEN 2001 AND 2500 THEN '2001-2500'
	END AS "Data Usage in Megabytes",		
COUNT(*) AS "# Of Instances"
FROM phonedata
GROUP BY app_range, "Data Usage in Megabytes"
ORDER BY app_range, "Data Usage in Megabytes";

-- Frequency distribution of user bnehavior classes

SELECT user_behavior_class, COUNT(user_id) AS "Number of users" 
FROM phonedata
GROUP BY user_behavior_class;

-- Averaege battery drain by the number of apps installed on a device

SELECT 
	CASE
		WHEN apps_installed BETWEEN 10 AND 20 THEN '10-20'
		WHEN apps_installed BETWEEN 21 AND 30 THEN '21-30'
		WHEN apps_installed BETWEEN 31 AND 40 THEN '31-40'
		WHEN apps_installed BETWEEN 41 AND 50 THEN '41-50'
		WHEN apps_installed BETWEEN 51 and 60 THEN '51-60'
		WHEN apps_installed BETWEEN 61 AND 70 THEN '61-70'
		WHEN apps_installed BETWEEN 71 AND 80 THEN '71-80'
		WHEN apps_installed BETWEEN 81 AND 90 THEN '81-90'
		WHEN apps_installed BETWEEN 91 AND 100 THEN '91-100'
	END AS "Apps Installed Range",
	CASE
		WHEN battery_drain BETWEEN 100 AND 500 THEN '100-500'
		WHEN battery_drain BETWEEN 501 AND 1000 THEN '501-1000'
		WHEN battery_drain BETWEEN 1001 AND 1500 THEN '1001-1500'
		WHEN battery_drain BETWEEN 1501 AND 2000 THEN '1501-2000'
		WHEN battery_drain BETWEEN 2001 AND 2500 THEN '2001-2500'
		WHEN battery_drain BETWEEN 2501 AND 3000 THEN '2501-3000'
	END AS "Battery Drain", 
COUNT(battery_drain) AS "Number of instances"
FROM phonedata
GROUP BY "Apps Installed Range", "Battery Drain"
ORDER BY "Apps Installed Range" ASC, "Battery Drain";

-- Comparison of Screen-On-Time and App Usage Time within User Behavior Classes

SELECT user_behavior_class AS "User Behavior Class",
	CASE
		WHEN screen_on_time BETWEEN 0 AND 4 THEN '1-4 Hours'
		WHEN screen_on_time BETWEEN 4 AND 8 THEN '4-8 Hours'
		WHEN screen_on_time BETWEEN 8 AND  12 THEN '8-12 Hours '
	END AS "Screen Time Range",
	CASE
		WHEN app_usage_time / 60 BETWEEN 0 AND 1 THEN '0-1 Hours'
		WHEN app_usage_time / 60 BETWEEN 2 AND 3 THEN '2-3 Hours'
		WHEN app_usage_time / 60 BETWEEN 4 AND 5 THEN '4-5 Hours'
		WHEN app_usage_time / 60 BETWEEN 6 AND 7 THEN '6-7 Hours'
		WHEN app_usage_time / 60 BETWEEN 8 AND 9 THEN '8-9 Hours'
		WHEN app_usage_time / 60 > 9 THEN '9+ Hours'
	END AS "App Usage Range in Hours",
COUNT(*) AS "# Of Instances"
FROM phonedata
GROUP BY "Screen Time Range", "App Usage Range in Hours", "User Behavior Class"
ORDER BY "Screen Time Range", user_behavior_class, "App Usage Range in Hours" DESC;

-- Performance Metrics

-- Top 5 users with the highest app usage time 

SELECT user_id AS "User ID", app_usage_time AS "App Usage Time in Minutes" FROM phonedata
ORDER BY app_usage_time DESC 
FETCH FIRST 5 ROWS ONLY;

-- Top 5 users with the highest data consumption

SELECT user_id AS "User ID", data_usage AS "Data Usage in MB"
FROM phonedata
ORDER BY data_usage DESC
FETCH FIRST 5 ROWS ONLY;

-- Determine if there is a trend in app usage & screen time for different user behavior classes

SELECT
app_usage_time AS "App Usage in Minutes",
screen_on_time AS "Screen Time in Hours",
user_behavior_class AS "User Behavior Class"
FROM phonedata
ORDER BY "User Behavior Class";

-- Advanced Segment Analytics

-- Relationship between app usage time and battery drain across user behavior classes

SELECT 
app_usage_time AS "App Usage in Minutes",
battery_drain AS "Battery drain in mAh",
user_behavior_class AS "User Behavior Class"
FROM phonedata
ORDER BY "User Behavior Class";
 
-- Average daily data usage for users aged 18-25 vs. 26-40.

SELECT
	CASE
		WHEN age BETWEEN 18 AND 25 THEN '18-25'
		WHEN age BETWEEN 26 AND 50 THEN '26-50'
		WHEN age > 50 THEN 'Over 50'
	end as "Age Range",
ROUND(AVG(data_usage),2) AS "Daily Data Usage in MB",
	COUNT(*) AS "# Of Instances"
	FROM phonedata
	GROUP BY "Age Range"
	ORDER BY "Age Range" ASC;

-- Percentage of Users in each behavior class using iOS vs Android Operating System

SELECT user_behavior_class AS "User Behavior Class", operating_system AS "Operating System",
ROUND(COUNT(*) * 100.00 / SUM(COUNT(*)) OVER(), 2) AS "Operating System Share"
FROM phonedata
GROUP BY user_behavior_class, operating_system
ORDER BY user_behavior_class ASC, "Operating System Share" DESC;

-- Visualization Queries

-- Group screen-on time into buckets (e.g., 1-2 hours, 2-3 hours) and count users in each bucket.

SELECT 
	CASE
		WHEN screen_on_time BETWEEN 0 AND 3 THEN '0-3 Hours'
		WHEN screen_on_time BETWEEN 3 AND 6 THEN '3-6 Hours'
		WHEN screen_on_time BETWEEN 6 AND 9 THEN '6-9 Hours'
		WHEN screen_on_time BETWEEN 9 AND 12 THEN '9-12 Hours'
	END AS "Screen Time Range",
	COUNT(screen_on_time) AS "Number of Users"
	FROM phonedata
	GROUP BY "Screen Time Range"
	ORDER BY "Screen Time Range";

-- Aggregate battery drain and data consumption by user behavior class for a stacked bar chart.

SELECT 
user_behavior_class AS "User Behavior Class", 
ROUND(AVG(battery_drain), 2) AS "Average Battery Drain in mAh", 
ROUND(AVG(data_usage), 2) AS "Average Data Usage in MB"
FROM phonedata
GROUP BY user_behavior_class
ORDER BY user_behavior_class;

-- Comparison of average app usage time across all device models in a line or bar graph.

SELECT
device_model AS "Device Model",
ROUND(AVG(app_usage_time), 2) AS  "App Usage Time in Minutes"
FROM phonedata
GROUP BY "Device Model"
ORDER BY "App Usage Time in Minutes" ASC;

-- Aggregate average app usage time, screen-on time, battery drain, and data usage by user behavior class

SELECT
user_behavior_class AS "User Behavior Class",
ROUND(AVG(app_usage_time), 2) AS "Average App Usage in Minutes",
ROUND(AVG(screen_on_time), 2) AS "Averaege Screen On Time in Hours",
ROUND(AVG(battery_drain), 2) AS "Average Battery Drain in mAh",
ROUND(AVG(data_usage), 2) AS "Averaege Data Usage in MB"
FROM phonedata
GROUP BY "User Behavior Class"
ORDER BY "User Behavior Class";
