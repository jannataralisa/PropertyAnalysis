
--check the datat of the table
SELECT * FROM [dbo].[AUS_Post_suburb]
SELECT * FROM  	[dbo].[NSW_PropertyMedainValue]

-- Create a  new column as composite primary key AUS POSTCODE TABLE
ALTER TABLE [dbo].[AUS_Post_suburb]
DROP COLUMN combined_postcode_suburb


ALTER TABLE [dbo].[AUS_Post_suburb]
ADD combined_postcode_suburb nvarchar(255) 

UPDATE [dbo].[AUS_Post_suburb]
SET combined_postcode_suburb = CONCAT(postcode, '-', suburb)

ALTER TABLE [dbo].[AUS_Post_suburb]
ALTER COLUMN combined_postcode_suburb nvarchar(255) NOT NULL --to set it primary key column it need to be not null
ALTER TABLE [AUS_Post_suburb]
ADD CONSTRAINT PK_AUS_Post_suburb PRIMARY KEY (combined_postcode_suburb)


-- Create a  new column as composite primary key NSW PropertyMedianTABLE

ALTER TABLE [dbo].[NSW_PropertyMedainValue]
ADD combined_postcode_suburb nvarchar(255) 

UPDATE [dbo].[NSW_PropertyMedainValue]
SET combined_postcode_suburb = CONCAT(postcode, '-', suburb)

ALTER TABLE [dbo].[NSW_PropertyMedainValue]
ALTER COLUMN combined_postcode_suburb nvarchar(255) NOT NULL

ALTER TABLE [NSW_PropertyMedainValue]
ADD CONSTRAINT PK_NSW_PropertyMedainValue PRIMARY KEY (combined_postcode_suburb)

ALTER TABLE [dbo].[NSW_PropertyMedainValue]
DROP COLUMN NSW_combined_postcode_suburb


---TASK 3----
-- 1) Find out the number of cities in each state.
SELECT 
	state, 
	COUNT (DISTINCT city) AS city
FROM 
	[dbo].[AUS_Post_suburb]
GROUP BY state
ORDER BY city DESC


-- 2) Find out the number of unique postcodes, and suburbs in each city 

SELECT 
	city, 
	COUNT (DISTINCT postcode) AS Postcode,
	COUNT (DISTINCT suburb) AS suburb
FROM 
	[dbo].[AUS_Post_suburb]
GROUP BY city
ORDER BY postcode DESC

/* 3) Query the Average Property Median Value by Suburb, and by Postcode separately,
and then by Suburb and Postcode together. Then put Where condition to remove
those records where there is no median value.*/

-- Query the Average Property Median Value by Suburb,
SELECT 
	DISTINCT suburb,
	AVG ([Property_Median_Value]) AS AverageMedianValue
FROM 
	[dbo].[NSW_PropertyMedainValue]
WHERE Property_Median_Value  is not null
GROUP BY suburb

--Query the Average Property Median Value by Suburb, and by Postcode separately,

SELECT 
	DISTINCT postcode,
	AVG ([Property_Median_Value]) AS AverageMedianValue
FROM 
	[dbo].[NSW_PropertyMedainValue]
WHERE Property_Median_Value  is not null
GROUP BY postcode 
ORDER BY postcode 

SELECT 
	DISTINCT postcode,suburb,
	AVG ([Property_Median_Value]) AS AverageMedianValue
FROM 
	[dbo].[NSW_PropertyMedainValue]
WHERE Property_Median_Value  is not null
GROUP BY suburb, postcode
