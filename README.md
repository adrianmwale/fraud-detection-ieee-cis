# Fraud Detection on IEEE-CIS Transactions

End-to-end fraud detection project on the Kaggle IEEE-CIS dataset (590k transactions, 3.5% fraud).

## Approach
- SQL (DuckDB): data loading, joins, exploratory queries and window-function features (`/sql`)
- Time-based train/validation split to avoid leakage
- LightGBM model evaluated with PR-AUC
- SHAP explanations and a cost-based decision threshold (in progress)

## Key findings so far
- Fraud rate is 3.5% overall, so accuracy is a misleading metric.
- Product code C has an 11.69% fraud rate, about 3.3x the overall rate.

## Status
Baseline model in progress.

## Data
Download from the [Kaggle competition](https://www.kaggle.com/competitions/ieee-fraud-detection) into `data/`. Not included in this repo.
