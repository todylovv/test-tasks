CREATE TABLE transfers (
    from_account INT,
    to_account INT,
    amount INT,
    tdate DATE
);

INSERT INTO transfers (from_account, to_account, amount, tdate) VALUES
    (1, 2, 1000, '2023-01-01'),
    (2, 1, 500, '2023-01-02'),
    (3, 1, 800, '2023-01-03'),
    (2, 3, 300, '2023-01-04'),
    (1, 3, 600, '2023-01-05');


WITH ranked_transfers AS (
  SELECT
    from_account AS acc,
    tdate AS dt,
    -amount AS balance_change
  FROM transfers
  UNION ALL
  SELECT
    to_account AS acc,
    tdate AS dt,
    amount AS balance_change
  FROM transfers
),
ranked_and_cumulative AS (
  SELECT
    acc,
    dt,
    balance_change,
    SUM(balance_change) OVER (PARTITION BY acc ORDER BY dt) AS cumulative_balance
  FROM ranked_transfers
),
periods AS (
  SELECT
    acc,
    dt AS dt_from,
    LEAD(dt, 1, '3000-01-01'::DATE) OVER (PARTITION BY acc ORDER BY dt) AS dt_to,
    cumulative_balance AS balance
  FROM ranked_and_cumulative
)
SELECT
  acc,
  dt_from,
  dt_to,
  balance
FROM periods
WHERE dt_from < dt_to
ORDER BY dt_from;
