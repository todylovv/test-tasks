CREATE TABLE dates (check_date DATE);

INSERT INTO dates (check_date) VALUES (CURRENT_DATE);

INSERT INTO dates (check_date)
SELECT check_date + (generate_series(1, 999) * '1 day'::INTERVAL)
FROM dates;


WITH RECURSIVE random_dates AS (
  SELECT 
    CURRENT_DATE AS check_date,
    1 AS iteration
  UNION ALL
  SELECT
    (rd.check_date + ((FLOOR(RANDOM() * 6) + 2) * '1 day'::INTERVAL))::DATE,
    rd.iteration + 1
  FROM random_dates rd
  WHERE rd.iteration < 100
)
SELECT check_date
FROM random_dates
ORDER BY check_date;
