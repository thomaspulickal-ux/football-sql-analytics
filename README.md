# Football SQL Analytics Project

## 📌 Overview
This project demonstrates the design and analysis of a relational MySQL database for football competitions, matches, and player performance.

The database is designed to support analytical queries commonly used in data analytics and reporting roles, such as player performance analysis, disciplinary tracking, and competition-level insights.

---

## 🧱 Database Design
The project includes the following core tables:

- **players** – Player profile, nationality, position, and market value  
- **competitions** – Football competitions (e.g., La Liga)  
- **matches** – Match-level details linked to competitions  
- **player_stats_match** – Match-level player statistics (goals, cards)

Relational integrity is maintained using primary and foreign keys.

---

## 🔍 Key SQL Concepts Used
- INNER JOIN and LEFT JOIN  
- GROUP BY and HAVING  
- Subqueries using IN and EXISTS  
- Aggregate functions (COUNT, SUM, AVG)  
- Data manipulation (UPDATE, DELETE)  
- Schema evolution (ALTER TABLE)

---

## 📊 Sample Analysis Performed
- Number of matches per competition  
- Average player market value by nationality  
- Total goals, yellow cards, and red cards by player  
- Players participating in specific competitions  
- Players scoring more than one goal in a single match  
- Inclusion of players with no match statistics using LEFT JOIN  

---

## 🛠️ Tech Stack
- MySQL  
- SQL  
- GitHub  

---

## 🚀 How to Use
1. Run the table creation statements.
2. Insert sample data (optional).
3. Execute analytical queries from the SQL file to generate insights.

---

## 📎 Project Purpose
This project was built to demonstrate practical SQL skills, data modeling, and analytical thinking for roles in:
- Data Analytics
- Business Analytics
- Finance & Reporting
