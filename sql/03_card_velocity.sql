WITH f AS (
    SELECT isFraud,
           COUNT(*) OVER (
               PARTITION BY card1
               ORDER BY TransactionDT
               RANGE BETWEEN 86400 PRECEDING AND 1 PRECEDING
           ) AS txns_prev_24h
    FROM train
)
SELECT CASE WHEN txns_prev_24h = 0 THEN '0'
            WHEN txns_prev_24h <= 2 THEN '1-2'
            WHEN txns_prev_24h <= 5 THEN '3-5'
            ELSE '6+' END AS prior_24h_txns,
       COUNT(*) AS transactions,
       ROUND(AVG(isFraud) * 100, 2) AS fraud_pct
FROM f
GROUP BY 1
ORDER BY 1