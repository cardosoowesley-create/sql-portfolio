# Project 2 — Customer Churn / Inactive Customers (SQL)

## Business Context
The company wants to identify customers who became inactive (no purchases in the most recent period).
This is a common FP&A/FinOps need to support retention actions and revenue forecasting.

## Dataset
Two tables:
- `clientes` (customer master data)
- `vendas` (transactions)

## Questions Answered
1) Which customers are inactive (no sales)?
2) How many customers are active vs inactive?
3) What is the churn/inactive rate?
4) How to classify customers into risk categories using CASE WHEN?

## How to Run
- Copy and execute `schema_and_queries.sql` in a SQL playground (DB Fiddle / SQLite).
- Run queries in order.

## Key Insights (with current sample data)
- Customers without any recent sales are flagged as inactive and should be targeted for retention.
- LEFT JOIN is critical to avoid hiding churn by excluding customers with no transactions.
