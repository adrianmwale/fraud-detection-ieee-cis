SELECT
    TransactionID,
    COUNT(*) OVER w24                                          AS txns_prev_24h,
    COALESCE(SUM(TransactionAmt) OVER w24, 0)                  AS amt_prev_24h,
    TransactionDT - LAG(TransactionDT) OVER wseq               AS secs_since_prev_txn,
    TransactionAmt / NULLIF(AVG(TransactionAmt) OVER wpast, 0) AS amt_vs_card_avg,
    (TransactionDT // 3600) % 24                               AS hour_of_day
FROM train
WINDOW
    w24   AS (PARTITION BY card1, card2 ORDER BY TransactionDT
              RANGE BETWEEN 86400 PRECEDING AND 1 PRECEDING),
    wseq  AS (PARTITION BY card1, card2 ORDER BY TransactionDT, TransactionID),
    wpast AS (PARTITION BY card1, card2 ORDER BY TransactionDT, TransactionID
              ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING);
