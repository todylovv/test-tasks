CREATE TABLE employee (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    price INT,
    FOREIGN KEY (employee_id) REFERENCES employee(id)
);


INSERT INTO employee (name) VALUES
    ('Сотрудник 1'),
    ('Сотрудник 2'),
    ('Сотрудник 3');

INSERT INTO sales (employee_id, price) VALUES
    (1, 500),
    (1, 300),
    (2, 700),
    (2, 800),
    (3, 600),
    (3, 400),
    (3, 300);


WITH sales_summary AS (
  SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    COUNT(s.id) AS sales_c,
    SUM(s.price) AS sales_s
  FROM employee e
  LEFT JOIN sales s ON e.id = s.employee_id
  GROUP BY e.id, e.name
),
ranked_sales AS (
  SELECT
    *,
    RANK() OVER (ORDER BY sales_c DESC) AS sales_rank_c,
    RANK() OVER (ORDER BY sales_s DESC) AS sales_rank_s
  FROM sales_summary
)
SELECT
  r.employee_id AS id,
  r.employee_name AS name,
  r.sales_c,
  r.sales_rank_c,
  r.sales_s,
  r.sales_rank_s
FROM ranked_sales r;
