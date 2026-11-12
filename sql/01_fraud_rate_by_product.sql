SELECT ProductCD,
       COUNT(*) AS transactions,
       ROUND(AVG(isFraud) * 100, 2) AS fraud_pct
FROM train
GROUP BY ProductCD
ORDER BY fraud_pct DESC;