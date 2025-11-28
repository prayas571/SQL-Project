🍕 Pizza Runner SQL Case Study

A Complete End-to-End SQL Analysis Project

📌 Project Overview

This project is a full SQL case study inspired by the Pizza Runner delivery startup.
The goal is to analyze customer orders, pizza preparation, delivery performance, runner metrics, and overall business operations using SQL.

The dataset includes customer orders, runner deliveries, pizza types, toppings, and operational details — making it a realistic scenario for practicing SQL analytics, data cleaning, and business intelligence.

🎯 Objectives

This project solves real business questions, including:

Customer ordering behavior

Pizza order frequency & topping preferences

Runner performance, speed, and delivery success

Revenue, cost, and profitability insights

Data cleaning and transformation

Operational efficiency metrics

🧰 Tools Used

MySQL

SQL Joins, Aggregations, String Functions

Data Cleaning & Preprocessing

Time & Date Analysis

Business Metrics Calculation

🗂️ Database Structure

The project uses the following tables:

1. runners

Information about delivery runners and registration dates.

2. customer_orders

Each pizza ordered by customers, including toppings, extras, exclusions, and timestamps.

3. runner_orders

Delivery details such as distance, duration, pickup time, cancellations.

4. pizza_names

Pizza types (Meatlovers, Vegetarian).

5. pizza_recipes

Toppings included in each pizza.

6. pizza_toppings

Mapping of topping IDs to topping names.

🧹 Data Cleaning Performed

Before analysis, extensive data cleaning was completed:

✔ Handling nulls in pickup time, distance, and duration
✔ Converting distance to numeric format
✔ Removing words from duration (minutes, mins, minute)
✔ Standardizing exclusions/extras fields
✔ Fixing inconsistent formatting in toppings
✔ Ensuring proper numeric casting for calculations

Clean data enabled accurate business insights and metric calculations.

📊 Analysis & Key Insights
A. Pizza Order Metrics

Total pizzas ordered

Unique customer orders

Pizza types ordered by each customer

Maximum pizzas in a single order

Pizzas with modifications (extras/exclusions)

Hour-wise and day-wise ordering patterns

These insights reveal order demand patterns and customer food preferences.

B. Runner & Delivery Performance

Successful deliveries for each runner

Average arrival time to pick up orders

Delivery preparation time based on number of pizzas

Distance covered per customer

Fastest vs slowest delivery time gaps

Speed (km/h) for each runner

Successful delivery percentage

This section measures operational efficiency and runner performance levels.

C. Pricing, Revenue & Profitability

Assuming fixed pizza prices:

Meat Lovers → $12

Vegetarian → $10

Additional insights include:

Total revenue from all delivered pizzas

Revenue when $1 is charged for each extra

Cost of paying runners ($0.30 per km)

Net profit after delivery compensation

This reveals the financial performance of Pizza Runner.

📈 What This Project Demonstrates
✔ Strong SQL Skills

Complex joins, group-by analytics, string transformations, numeric cleaning, date/time functions.

✔ End-to-End Thinking

From raw data → cleaning → analysis → insights → business decisions.

✔ Real Business Problem Solving

Revenue, cost, runner efficiency, customer behavior — all essential for data analyst roles.

✔ Clean, Reusable SQL Workflow

Uncovers insights across operations, customers, and delivery performance.

📂 Project Structure
📁 PizzaRunner-SQL-CaseStudy
│── README.md
│── pizza_runner.sql
│── data (optional)
│── outputs/insights (optional)

🚀 Conclusion

This SQL case study provides a complete analytical workflow for a food delivery startup.
It showcases practical SQL knowledge, real-world business insight generation, and strong problem-solving skills — making it an excellent project for portfolios, resumes, and GitHub.
