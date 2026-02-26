-- ======================================
-- Dataset (Schema + Inserts)
-- ======================================

CREATE TABLE vendas (
  id INT,
  cliente TEXT,
  mes TEXT,
  valor INT
);

INSERT INTO vendas VALUES
(1,'A','Jan',1000),
(2,'B','Jan',2000),
(3,'A','Fev',1500),
(4,'C','Fev',3000),
(5,'B','Mar',2500),
(6,'C','Mar',500),
(7,'D','Mar',1200),
(8,'B','Fev',800);

-- ======================================
-- Q1) Revenue per customer
-- ======================================
SELECT cliente,
       SUM(valor) AS receita_total,
       AVG(valor) AS ticket_medio,
       COUNT(*) AS qtd_vendas
FROM vendas
GROUP BY cliente
ORDER BY receita_total DESC;

-- ======================================
-- Q2) Strategic customers (rules)
-- Rule: total revenue > 2000 AND avg ticket > 1200
-- ======================================
SELECT cliente,
       SUM(valor) AS receita_total,
       AVG(valor) AS ticket_medio
FROM vendas
GROUP BY cliente
HAVING SUM(valor) > 2000
   AND AVG(valor) > 1200
ORDER BY receita_total DESC;

-- ======================================
-- Q3) % of total revenue from strategic customers
-- ======================================
SELECT 
  SUM(receita_total) * 1.0 / (SELECT SUM(valor) FROM vendas) AS pct_revenue_strategic
FROM (
    SELECT cliente,
           SUM(valor) AS receita_total,
           AVG(valor) AS ticket_medio
    FROM vendas
    GROUP BY cliente
    HAVING SUM(valor) > 2000
       AND AVG(valor) > 1200
) strategic;

-- ======================================
-- Q4) Revenue concentration: share (%) per customer
-- ======================================
SELECT cliente,
       SUM(valor) AS receita_total,
       ROUND(SUM(valor) * 100.0 / (SELECT SUM(valor) FROM vendas), 2) AS share_pct
FROM vendas
GROUP BY cliente
ORDER BY receita_total DESC;

-- ======================================
-- Q5) Top 1 customer share (classic concentration metric)
-- ======================================
SELECT 
  ROUND(MAX(receita_total) * 100.0 / (SELECT SUM(valor) FROM vendas), 2) AS top1_share_pct
FROM (
  SELECT cliente, SUM(valor) AS receita_total
  FROM vendas
  GROUP BY cliente
) t;
