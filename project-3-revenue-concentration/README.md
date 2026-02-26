# Project 3 — Revenue Concentration (Strategic Customers) — SQL

## Business Context
FP&A teams often need to understand revenue concentration to assess risk and prioritize retention.
This project identifies “strategic customers” based on revenue and ticket size and calculates how much of total revenue they represent.

## Dataset
Table `vendas` (sales transactions):
- id (int)
- cliente (text)
- mes (text)
- valor (int)

## Questions Answered
1) Which customers are “strategic” based on:
   - total revenue > 2000
   - average ticket > 1200
2) What % of total revenue comes from strategic customers?
3) How concentrated is revenue by customer (ranking and share)?

## How to Run
- Execute `schema_and_queries.sql` in a SQL playground (DB Fiddle / SQLite)
- Run the queries in order

## Key Insights (with sample data)
- Strategic customers represent the majority of total revenue.
- High concentration indicates potential retention risk if top accounts churn.
