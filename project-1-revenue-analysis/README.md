# Project 1 — Revenue Analysis & Customer Segmentation (SQL)

## Business Context
This project simulates a simple revenue analysis to answer common FP&A / FinOps questions:

- Which customers generate the highest revenue?
- Which customers perform above average?
- How can customers be segmented by value?

## Dataset
Table `vendas` containing:
- id (int)
- cliente (text)
- valor (int)

## Questions Answered
1. Revenue per customer
2. Customers with above-average revenue
3. Customer segmentation using CASE WHEN

## How to Run
- Copy the SQL script from `schema_and_queries.sql`
- Execute it in a SQL playground (DB Fiddle / SQLite)
- Run the queries in sequence

## Key Insights
- Customer **B** concentrates the highest revenue and is classified as a high-value customer.
- Segmentation helps prioritize retention and commercial strategies based on customer value.
