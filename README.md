# 🎵 Music Store Database — MySQL

A relational database project analyzing a music store's operations using SQL — covering sales, customer behavior, artist performance, and genre trends across 11 real business queries.

---

## 📁 Folder Structure

```
music-store-mysql/
│
├── queries/
│   └── Music_Store_Project.sql   # All 11 SQL queries with logic comments
│
├── erd/
│   └── music_store_erd.png       # Entity Relationship Diagram (add yours here)
│
└── README.md
```

---

## 📌 Project Overview

This project uses SQL to answer real business questions from a music store database. It covers employee hierarchy, customer spending, invoice analysis, genre popularity, and country-level insights — using multi-table JOINs, subqueries, aggregations, and window functions.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| MySQL / PostgreSQL | Relational database engine |
| MySQL Workbench | Query execution & schema design |
| SQL | Data querying & analysis |

---

## 🗃️ Database Schema

Key tables used across queries:

| Table | Description |
|-------|-------------|
| `employee` | Staff records with job levels/hierarchy |
| `customer` | Customer details |
| `invoice` | Purchase invoices with billing country/city |
| `invoiceline` | Line items per invoice (track, price, qty) |
| `track` | Song details with genre and album reference |
| `album` | Albums linked to artists |
| `artist` | Artist names |
| `genre` | Music genre classification |

---

## 🔍 Business Questions Answered (11 Queries)

| # | Question | Technique Used |
|---|----------|----------------|
| 1 | Who is the senior-most employee? | `ORDER BY levels DESC LIMIT 1` |
| 2 | Which country has the most invoices? | `COUNT + GROUP BY + ORDER BY` |
| 3 | Top 3 countries by total invoice value | `SUM + GROUP BY + LIMIT 3` |
| 4 | Best city by total invoice revenue | `SUM + GROUP BY + LIMIT 1` |
| 5 | Customer who spent the most money | Multi-table JOIN + Subquery |
| 6 | Rock music listeners (name, email) | 5-table JOIN + WHERE genre filter |
| 7 | Top 10 Rock artists by track count | JOIN + GROUP BY + LIMIT 10 |
| 8 | Tracks longer than average duration | Scalar subquery in WHERE clause |
| 9 | Amount spent per customer per artist | Multi-table JOIN + GROUP BY |
| 10 | Top genre per country | `DENSE_RANK()` window function |
| 11 | Top spending customer per country | `DENSE_RANK()` window function |

---

## 📊 Sample Query — Top Spending Customer per Country

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

## 🚀 How to Run

1. Install [MySQL](https://dev.mysql.com/downloads/) or [PostgreSQL](https://www.postgresql.org/download/)
2. Import the Music Store database (schema + data)
3. Open `queries/Music_Store_Project.sql`
4. Execute queries one by one to explore the results

---

## 📄 License

This project is for educational and portfolio purposes.
