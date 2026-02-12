-- =========================
-- Dataset (Schema + Inserts)
-- =========================

CREATE TABLE clientes (
  cliente_id INT,
  nome TEXT
);

INSERT INTO clientes VALUES
(1,'A'),
(2,'B'),
(3,'C'),
(4,'D'),
(5,'E');

CREATE TABLE vendas (
  venda_id INT,
  cliente_id INT,
  mes TEXT,
  valor INT
);

-- Note: Customer D has no sales at all (inactive)
-- Note: Customer E has only old sales (inactive in the latest month)
INSERT INTO vendas VALUES
(1,1,'Jan',1000),
(2,2,'Jan',2000),
(3,1,'Fev',1500),
(4,3,'Fev',3000),
(5,2,'Mar',2500),
(6,5,'Jan',800);

-- =========================
-- Assumption: Latest month is 'Mar'
-- =========================

-- Q1) Inactive customers (no sales in latest month)
SELECT c.cliente_id,
       c.nome
FROM clientes c
LEFT JOIN vendas v
  ON c.cliente_id = v.cliente_id
 AND v.mes = 'Mar'
WHERE v.cliente_id IS NULL;

-- Q2) Active vs Inactive customers (count)
SELECT
  CASE
    WHEN v.cliente_id IS NULL THEN 'Inactive'
    ELSE 'Active'
  END AS status,
  COUNT(*) AS customers
FROM clientes c
LEFT JOIN (
  SELECT DISTINCT cliente_id
  FROM vendas
  WHERE mes = 'Mar'
) v
ON c.cliente_id = v.cliente_id
GROUP BY status;

-- Q3) Inactive rate (churn proxy)
SELECT
  (SUM(CASE WHEN v.cliente_id IS NULL THEN 1 ELSE 0 END) * 1.0) / COUNT(*) AS inactive_rate
FROM clientes c
LEFT JOIN (
  SELECT DISTINCT cliente_id
  FROM vendas
  WHERE mes = 'Mar'
) v
ON c.cliente_id = v.cliente_id;

-- Q4) Risk classification based on last purchase month (simple rule)
-- If last purchase is 'Mar' => Low Risk
-- If last purchase is 'Fev' => Medium Risk
-- If last purchase is 'Jan' or NULL => High Risk
SELECT c.cliente_id,
       c.nome,
       MAX(v.mes) AS last_purchase_month,
       CASE
         WHEN MAX(v.mes) = 'Mar' THEN 'Low Risk'
         WHEN MAX(v.mes) = 'Fev' THEN 'Medium Risk'
         WHEN MAX(v.mes) = 'Jan' THEN 'High Risk'
         ELSE 'High Risk'
       END AS risk_bucket
FROM clientes c
LEFT JOIN vendas v
ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id, c.nome;
