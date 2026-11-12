SELECT (TransactionDT // 3600) % 24 AS hour_of_day,
       COUNT(*) AS transactions,
       ROUND(AVG(isFraud) * 100, 2) AS fraud_pct
FROM train
GROUP BY 1
ORDER BY 1