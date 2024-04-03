# Billing
Recall all resources under a project accumulate into one billing account.

## Budgets
Budgets let you track your spend and alert you accordingly.
Budgets are set on a specific project and have either:
1. A fixed budget amount
1. An amount matched to the previous month's spend

Alerts send emails to billing admins after spend exceeds a percentage of the budget (or another specified amount).
You can also send an alert if the spend is forecasted to exceed the relevant amount by the end of the budget period.

In addition to emails, you can use Cloud Pub/Sub to programatically act on spend updates.

## Labels
Labels can help you optimise your spend.
E.g. you might label VM instances that are spread across different regions to identify instances sending lots of traffic to another continent.

## BigQuery
You can label all your resources and export billing data to BigQuery for analysis.
