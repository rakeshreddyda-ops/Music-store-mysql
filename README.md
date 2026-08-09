# 🎵 Music Store Analytics — SQL Business Insights

> Analyzes music store sales data using SQL to uncover customer behavior, top-performing artists, and revenue drivers for business decision-making.

---

## 📌 Problem Statement

Music store businesses generate large volumes of transactional data but often lack clear insights into customer purchasing behavior, top-performing artists, and revenue trends. Without structured analysis, it becomes difficult to make data-driven decisions on marketing, inventory, and regional strategy.

---

## 💡 Solution

Built a relational SQL-based analysis system to answer key business questions using structured queries. The project extracts actionable insights such as top customers, best-selling genres, and country-wise revenue trends using advanced SQL techniques.

---

## 🛠️ Tech Stack

* **SQL (MySQL / PostgreSQL)** — Data querying & analysis
* **MySQL Workbench** — Query execution & schema design
* **Relational Database Design** — Structured data modeling

---

## 🚀 Key Features

* Solved **11 real-world business problems** using SQL
* Used **complex JOINs (up to 5 tables)** for deep data analysis
* Implemented **window functions (DENSE_RANK)** for ranking insights
* Performed **customer segmentation & revenue analysis**
* Identified **top genres, artists, and high-value customers**
* Built **scalable query logic with subqueries & aggregations**

---

## 📊 Results (Key Insights)

* Identified **top spending customers across countries**
* Discovered **highest revenue-generating cities and regions**
* Found **most popular genre (Rock) and top-performing artists**
* Revealed **customer purchase patterns and retention signals**
* Ranked **top genres per country using window functions**

---

## 💼 Business Impact ⭐

* Helps businesses **identify high-value customers** for targeted marketing
* Enables **data-driven inventory decisions** (popular genres/artists)
* Supports **regional expansion strategy** using country-level insights
* Improves **revenue optimization** through customer behavior analysis
* Provides a foundation for **BI dashboards and reporting systems**

---

## 📁 Project Structure

```
music-store-mysql/
│
├── queries/
│   └── Music_Store_Project.sql
│
├── erd/
│   └── music_store_erd.png
│
└── README.md
```

---

## 🗃️ Database Schema

Key tables used:

* `customer` — Customer information
* `invoice` — Purchase transactions
* `invoiceline` — Detailed sales data
* `track` — Song-level data
* `genre` — Music categories
* `artist` — Artist information
* `album` — Album mapping
* `employee` — Organizational hierarchy

---

## 📊 Sample Query — Top Customer per Country

```sql
SELECT customer_id, first_name, last_name, billing_country
FROM (
    SELECT c.customer_id, c.first_name, c.last_name, i.billing_country,
           SUM(il.unit_price * il.quantity) AS Total_sales,
           DENSE_RANK() OVER (
               PARTITION BY i.billing_country
               ORDER BY SUM(il.unit_price * il.quantity) DESC
           ) AS rnk
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoiceline il ON i.invoice_id = il.invoice_id
    GROUP BY c.customer_id, c.first_name, c.last_name, i.billing_country
) rt
WHERE rnk = 1;
```

---

## 📸 Screenshots 

* ER Diagram
  <img width="1315" height="731" alt="image" src="https://github.com/user-attachments/assets/319d4df0-6464-41df-b0a9-1ac40b1e2123" />

* Query Results
  <img width="1949" height="855" alt="image" src="https://github.com/user-attachments/assets/dbb9eabd-3977-4dd4-a8a2-dc6faf21be31" />
  <img width="2000" height="842" alt="image" src="https://github.com/user-attachments/assets/809d0888-6669-430e-bdb4-7a7ed4c7477e" />
  <img width="2000" height="847" alt="image" src="https://github.com/user-attachments/assets/d6a636a4-33fb-4a4b-a9ba-3f9ca8611e1b" />
  <img width="2000" height="873" alt="image" src="https://github.com/user-attachments/assets/b19f635b-e86e-452f-ade8-71434886a302" />


---

## ⚙️ How to Run

1. Install MySQL or PostgreSQL
2. Import the Music Store dataset
3. Open SQL file from `/queries`
4. Execute queries to explore insights

---

## 📄 License

This project is intended for portfolio and educational use.
