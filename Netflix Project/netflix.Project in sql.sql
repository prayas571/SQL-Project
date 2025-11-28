create database netflix1;
use netflix1;
select * from netflix_titles;


#1. Count the number of Movies vs TV Shows

select type,count(*) as total_count from netflix_titles group by type;

#2. Find the most common rating for movies and TV shows

select * from netflix_titles;

SELECT * FROM (
    SELECT rating, COUNT(*) AS total_count
    FROM netflix_titles
    WHERE type = 'Movie'
    GROUP BY rating
    ORDER BY total_count DESC
    LIMIT 1
) AS movie_rating

UNION ALL

SELECT * FROM (
    SELECT rating, COUNT(*) AS total_count
    FROM netflix_titles
    WHERE type = 'TV Show'
    GROUP BY rating
    ORDER BY total_count DESC
    LIMIT 1
) AS tv_rating;

#3. List all movies released in a specific year (e.g., 2020)

select * from netflix_titles where release_year = 2020;

#4. Find the top 5 countries with the most content on Netflix

select country , count(*) as total_count from netflix_titles group by country order by total_count desc limit 5;

#5. Identify the longest movie

SELECT title, duration
FROM netflix_titles
WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC
LIMIT 1;


#6. Find content added in the last 5 years

SELECT *
FROM netflix_titles
WHERE date_added >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);


#7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix_titles where director = "Rajiv Chilaka";

#8. List all TV shows with more than 5 seasons

SELECT title, duration
FROM netflix_titles
WHERE type = 'TV Show'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;


#9. Count the number of content items in each genre

SELECT listed_in AS genre, COUNT(*) AS total_count
FROM netflix_titles
GROUP BY listed_in
ORDER BY total_count DESC;


#10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!

SELECT release_year, COUNT(*) AS total_content
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC
LIMIT 5;


#11. List all movies that are documentaries

SELECT *
FROM netflix_titles
WHERE listed_in LIKE '%Documentary%';

 #12. Find all content without a director
SELECT * FROM netflix_titles
WHERE director IS NULL;

#13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
SELECT COUNT(*) 
FROM netflix_titles
WHERE `cast` LIKE '%Salman Khan%'
  AND release_year >= 2015;
  
#14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
  
 SELECT `cast`, COUNT(*) AS movie_count
FROM netflix_titles
WHERE country = 'India'
  AND type = 'Movie'
GROUP BY `cast`
ORDER BY movie_count DESC
LIMIT 10;


# 15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
#the description field. Label content containing these keywords as 'Bad' and all other 
#content as 'Good'. Count how many items fall into each category.

SELECT 
    CASE 
        WHEN description LIKE '%kill%' 
          OR description LIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category,
    COUNT(*) AS total_items
FROM netflix_titles
GROUP BY category;

