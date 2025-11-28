create database zomato;
use zomato;

select * from zomato_mock_dataset;

#A. Basic Data Understanding (1–10)
#========================================================

#1. Display the first 10 records of the dataset.

select * from zomato_mock_dataset limit 10;

#2. Show all unique cities in the dataset.

select distinct city from zomato_mock_dataset;

#3. Count the total number of restaurants in the dataset.

select count(*) as total_restaurants from zomato_mock_dataset;

#4. Find the total number of unique cuisines offered.

select count(distinct cuisines) as unique_cuisines from zomato_mock_dataset;

#5. List all restaurants located in the city "Bangalore".

select * from zomato_mock_dataset where city = "Bangalore";

#6. Show the distinct values for the Price range column.

SELECT DISTINCT `Price Range` 
FROM zomato_mock_dataset;


#7. Display the minimum and maximum Average Cost for two.

select min(`Average Cost for two`) as min_cost,
       max(`Average Cost for two`) as max_cost
from zomato_mock_dataset;


#8. Count how many restaurants offer "Has Table booking" as "Yes".

SELECT COUNT(*) AS `table booking yes`
FROM zomato_mock_dataset
WHERE `Has Table booking` = 'Yes';

#9. Find the average Aggregate rating across all restaurants.

select avg(`Aggregate rating`) as avg_rating from zomato_mock_dataset;

#10. Show the restaurant with the highest number of Votes

SELECT `Restaurant Name`, City, Cuisines, Votes
FROM zomato_mock_dataset
ORDER BY Votes DESC
LIMIT 1;

select `Restaurant Name`,Votes from zomato_mock_dataset order by Votes 
desc limit 1;


#B. Filtering Data (11–20)
#=======================================
#11. List all restaurants that serve "Chinese" cuisine.

select * from zomato_mock_dataset where Cuisines like '%Chinese%';

#12. Find all restaurants with Aggregate rating greater than 4.5.

select * from zomato_mock_dataset where `Aggregate rating` > 4.5;

#13. Show restaurants with Average Cost for two less than 500 in Mumbai.

select *from zomato_mock_dataset where `Average Cost for two` < 500
and City = 'Mumbai';

#14. Display restaurants where Has Online delivery is "Yes" and Is delivering now is "Yes".

select * from  zomato_mock_dataset where `Has Online delivery` = 'Yes'
and `Is delivering now` = 'Yes';

#15. Find all restaurants in Delhi with Price range = 4.

select * from zomato_mock_dataset where City = 'Delhi' and `Price range` = 4;

#16. Show restaurants that have "Cafe" in their Cuisines.

select * from zomato_mock_dataset where Cuisines like '%Cafe%';

#17. Display all restaurants with Votes above 1000 and located in Chennai.

select * from zomato_mock_dataset where Votes > 1000 and City = 'chennai';

#18. Find restaurants in Pune with Aggregate rating between 3.0 and 4.0.

select * from zomato_mock_dataset where City = 'Pune' and `Aggregate rating` between 3.0 and 4.0;


#19. Show restaurants that do not offer table booking.

#20. Find restaurants in Kolkata with Average Cost for two more than 1500.



