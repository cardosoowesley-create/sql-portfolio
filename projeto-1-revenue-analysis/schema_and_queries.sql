-- =========================
-- Dataset (Schema + Inserts)
-- =========================

CREATE TABLE vendas (
  id INT,
  cliente TEXT,
  valor INT
);

INSERT INTO vendas VALUES
(1,'A',1000),
(2,'B',2000),
(3,'A',1500),
(4,'C',3000),
(5,'B',2500);

-- =========================
-- Q1) Revenue per customer
-- =========================
SELECT cliente, SUM(valor) AS receita
FROM vendas
GROUP BY cliente;

-- =========================
-- Q2) Customers above average revenue
-- =========================
SELECT rc.cliente, rc.receita
FROM (
  SELECT cliente, SUM(valor) AS receita
  FROM vendas
  GROUP BY cliente
) rc
WHERE rc.receita > (
  SELECT AVG(receita)
  FROM (
    SELECT cliente, SUM(valor) AS receita
    FROM vendas
    GROUP BY cliente
  ) t
);

-- =========================
-- Q3) Customer segmentation
-- =========================
SELECT cliente,
       SUM(valor) AS receita,
       CASE
         WHEN SUM(valor) >= 4000 THEN 'High Value'
         WHEN SUM(valor) >= 2500 THEN 'Mid Value'
         ELSE 'Low Value'
       END AS segmento
FROM vendas
GROUP BY cliente;
