# Fraud Detection on IEEE-CIS Transactions

Fraud detection on the Kaggle IEEE-CIS dataset (590,540 transactions, 3.5% fraud): SQL (DuckDB) for exploration and feature engineering, LightGBM for modelling, a cost-based decision threshold, and SHAP for explanation.

## Approach
1. SQL exploration in `/sql`: fraud rate by product code, hour and card activity.
2. Card-history features in SQL (`sql/04_card_velocity_features.sql`): transactions and spend in the previous 24 hours, time since the card's last transaction, amount vs the card's past average. Windows only look backwards, so there is no leakage.
3. Time-based split: train on the earliest 80% of transactions, test on the latest 20%.
4. Models: logistic regression, LightGBM, LightGBM + SQL features.
5. Decision threshold chosen on a separate validation period using assumed costs.
6. SHAP to explain predictions.

## Results (test period, 3.44% fraud)
| Model | PR-AUC | ROC-AUC |
| --- | --- | --- |
| Random guessing | 0.034 | 0.50 |
| Logistic regression | 0.182 | 0.808 |
| LightGBM | 0.561 | 0.914 |
| LightGBM + SQL card features | 0.570 | 0.917 |

- Fraud rate is 2.4% for cards with no transactions in the previous 24 hours, 4.3% for cards with 3-5, and 3.7% for 6 or more.
- The SQL features added about 0.009 PR-AUC (single run), and none are among the top 10 SHAP features.
- Cost-based threshold (assumed review cost of 5 per flag; a missed fraud costs its transaction amount): threshold 0.02 flags 18.8% of transactions, catches 83% of fraud at 15% precision, and costs 65% less than flagging nothing. This step trains on a smaller window (70% of the data), so that model scores slightly lower (PR-AUC 0.52).
- Top SHAP features: TransactionAmt, C13, card6, P_emaildomain, C5.

## Limitations
- `card1` and `card2` are only a rough stand-in for a unique card.
- The review cost and "missed fraud costs its amount" are assumptions.
- One train/test split, no repeated runs, no hyperparameter tuning.
- Many columns are anonymised, so I describe their importance, not their meaning.

## Data
Download from the [Kaggle competition](https://www.kaggle.com/competitions/ieee-fraud-detection) into `data/`. Not included in this repo.
