CREATE SCHEMA pizza_runner;


use pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
   runner_id INT,
   registration_date DATE
);

INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');
  
  select * from runners;
  
  
  DROP TABLE IF EXISTS customer_orders;
  CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time TIMESTAMP
);

INSERT INTO customer_orders
  (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
  
  select * from customer_orders;
  
  DROP TABLE IF EXISTS runner_orders;
  CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

select * from runner_orders;


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);

INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');
  select * from pizza_names;
  
  DROP TABLE IF EXISTS pizza_recipes;
  CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');
  

DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);

INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  select * from pizza_toppings;

#====================================================================================
# Data Cleaning
#==================
UPDATE runner_orders
SET pickup_time = NULL
WHERE pickup_time = 'null' OR pickup_time = '';

UPDATE runner_orders
SET distance = NULL
WHERE distance = 'null' OR distance = '';

UPDATE runner_orders
SET duration = NULL
WHERE duration = 'null' OR duration = '';

UPDATE runner_orders
SET cancellation = NULL
WHERE cancellation = 'null' OR cancellation = '';

select * from runner_orders;
#=======================================
UPDATE runner_orders
SET distance = REPLACE(distance, 'km', '');

UPDATE runner_orders
SET distance = TRIM(distance) + 0;   -- force numeric

-- Clean duration: remove words and cast to integer
UPDATE runner_orders
SET duration = REPLACE(duration, 'minutes', '');

UPDATE runner_orders
SET duration = REPLACE(duration, 'minute', '');

UPDATE runner_orders
SET duration = REPLACE(duration, 'mins', '');

UPDATE runner_orders
SET duration = TRIM(duration) + 0;

select * from runner_orders;

#========================================

UPDATE customer_orders
SET exclusions = NULL
WHERE exclusions = 'null' OR exclusions = '';

UPDATE customer_orders
SET extras = NULL
WHERE extras = 'null' OR extras = '';

select * from customer_orders;
#====================================================
# QUESTION
#=============


# A. Pizza Metrics
#1 How many pizzas were ordered?
select count(*) as total_count from customer_orders;

#2 How many unique customer orders were made?
select count(distinct order_id) as unique_orders from customer_orders;

#3 How many successful orders were delivered by each runner?
select runner_id , count(order_id) as successful_order from runner_orders
 where cancellation is null group by runner_id;

#4 How many of each type of pizza was delivered?
select pizza_id , count(*) as pizza_delivered 
from customer_orders c join runner_orders r
on c.order_id = r.order_id 
where r. cancellation is null
group by pizza_id;


#5 How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id,
       p.pizza_name,
       COUNT(*) AS pizzas_ordered
FROM customer_orders c
JOIN pizza_names p
  ON c.pizza_id = p.pizza_id
GROUP BY c.customer_id, p.pizza_name
ORDER BY c.customer_id, p.pizza_name;


#6 What was the maximum number of pizzas delivered in a single order?
select c.order_id , count(*) as pizzas_in_order
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where r.cancellation is null
group by c.order_id
order by pizzas_in_order desc limit 1;


#7 For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT c.customer_id,
       COUNT(*) AS pizzas_with_changes
FROM customer_orders c
JOIN runner_orders r
  ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
  AND (c.exclusions IS NOT NULL OR c.extras IS NOT NULL)
GROUP BY c.customer_id;

#8 How many pizzas were delivered that had both exclusions and extras?
select count(*) as pizzas_with_exclusions_and_extras
from customer_orders c
join runner_orders r
where r.cancellation IS NULL
AND c.exclusions IS NOT NULL
  AND c.extras IS NOT NULL;
  
#9 What was the total volume of pizzas ordered for each hour of the day?
SELECT 
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_pizzas
FROM customer_orders c
JOIN runner_orders r 
    ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY HOUR(order_time)
ORDER BY order_hour;

#10 What was the volume of orders for each day of the week?
select dayname(c.order_time) as day_of_week,
count(*) as total_pizzas
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where r.cancellation is null
group by dayname(order_time)
order by field(day_of_week,
    'Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday');
    

    
    
#B. Runner and Customer Experience
#================================================
#How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT 
    FLOOR(DATEDIFF(registration_date, '2021-01-01') / 7)+ 1 
    AS week_number,
    COUNT(runner_id) AS runners_signed_up
FROM runners
GROUP BY week_number
ORDER BY week_number;

#What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
select r.runner_id,
round(avg(timestampdiff(minute,c.order_time,r.pickup_time)),2) 
as avg_arrival_time_minutes
from customer_orders c
join runner_orders r
on c.order_id = c.order_id
where r.cancellation is null
group by r.runner_id
order by r.runner_id;

#Is there any relationship between the number of pizzas and how long the order takes to prepare?
select c.order_id,
count(c.pizza_id) as number_of_pizzas,
timestampdiff(minute,c.order_time,r.pickup_time) as prep_time_minutes
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where r.cancellation is null
group by c.order_id,c.order_time,r.pickup_time
order by number_of_pizzas desc;


SELECT 
    number_of_pizzas,
    ROUND(AVG(prep_time_minutes), 2) AS avg_prep_time
FROM (
    SELECT 
        c.order_id,
        COUNT(c.pizza_id) AS number_of_pizzas,
        TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time) AS prep_time_minutes
    FROM customer_orders c
    JOIN runner_orders r 
        ON c.order_id = r.order_id
    WHERE r.cancellation IS NULL
      AND r.pickup_time IS NOT NULL
    GROUP BY c.order_id, c.order_time, r.pickup_time
) sub
GROUP BY number_of_pizzas
ORDER BY number_of_pizzas;


#What was the average distance travelled for each customer?

SELECT  c.customer_id,
    ROUND(AVG(r.distance), 2) AS avg_distance
FROM customer_orders c
JOIN runner_orders r
    ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
GROUP BY c.customer_id
ORDER BY c.customer_id;


#What was the difference between the longest and shortest delivery times for all orders?
select 
max(timestampdiff(minute,c.order_time,r.pickup_time)) -
min(timestampdiff(minute,c.order_time,r.pickup_time)) as delivery_time_diff
from customer_orders c
join runner_orders r
on c.order_id = r.order_id
where r.cancellation is null
and r.pickup_time is not null;

#What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT 
    r.runner_id,
    r.order_id,
    ROUND(r.distance / (TIMESTAMPDIFF(MINUTE, MIN(c.order_time), r.pickup_time) / 60), 2) AS avg_speed_kmh
FROM runner_orders r
JOIN customer_orders c
    ON c.order_id = r.order_id
WHERE r.cancellation IS NULL
  AND r.distance IS NOT NULL
  AND r.pickup_time IS NOT NULL
GROUP BY r.runner_id, r.order_id, r.distance, r.pickup_time
ORDER BY r.runner_id, r.order_id;

#What is the successful delivery percentage for each runner?
SELECT 
    runner_id,
    ROUND(100 * SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS success_percentage
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;





#Pricing and Ratings
#===========================
#If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
SELECT 
    SUM(
        CASE 
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
    ) AS total_revenue
FROM customer_orders co
JOIN runner_orders r ON co.order_id = r.order_id
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
WHERE r.cancellation IS NULL;


#What if there was an additional $1 charge for any pizza extras?
#Add cheese is $1 extra

SELECT 
    SUM(
        CASE 
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
        + 
        -- Count extras: add $1 per extra topping
        IF(co.extras IS NOT NULL AND co.extras <> '', 
           LENGTH(co.extras) - LENGTH(REPLACE(co.extras, ',', '')) + 1, 0)
    ) AS total_revenue_with_extras
FROM customer_orders co
JOIN runner_orders r ON co.order_id = r.order_id
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
WHERE r.cancellation IS NULL;




#If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - 
#how much money does Pizza Runner have left over after these deliveries?

SELECT 
    ROUND(SUM(
        CASE 
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
    ), 2) AS total_revenue,
    
    ROUND(SUM(r.distance * 0.30), 2) AS total_runner_cost,
    
    ROUND(SUM(
        CASE 
            WHEN pn.pizza_name = 'Meatlovers' THEN 12
            WHEN pn.pizza_name = 'Vegetarian' THEN 10
            ELSE 0
        END
    ) - SUM(r.distance * 0.30), 2) AS net_earnings
FROM customer_orders co
JOIN runner_orders r ON co.order_id = r.order_id
JOIN pizza_names pn ON co.pizza_id = pn.pizza_id
WHERE r.cancellation IS NULL;




