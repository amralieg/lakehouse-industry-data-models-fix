-- Metric views for domain: payment | Business: Ecommerce | Version: 1 | Generated on: 2026-05-05 00:54:17

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction KPIs covering gross revenue, net revenue, fee burden, refund exposure, fraud risk, and settlement efficiency. Primary steering dashboard for the payments domain."
  source: "`ecommerce_ecm`.`payment`.`payment_transaction`"
  dimensions:
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the payment was made (e.g. web, mobile, in-store), enabling channel-level performance analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment instrument type (e.g. credit card, debit card, wallet), used to assess method-level adoption and risk."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (e.g. Visa, Mastercard, Amex), used for network-level fee and volume analysis."
    - name: "payment_transaction_status"
      expr: payment_transaction_status
      comment: "Current status of the transaction (e.g. completed, failed, pending), critical for funnel and success-rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the transaction, enabling multi-currency volume reporting."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the transaction (e.g. settled, pending, failed), used to track cash conversion."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the transaction is part of a recurring billing cycle, enabling subscription revenue segmentation."
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Flags transactions that have been charged back, used to isolate chargeback-affected volume."
    - name: "merchant_category_code"
      expr: merchant_category_code
      comment: "MCC code classifying the merchant type, used for regulatory and risk segmentation."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Calendar day of the transaction, used for daily trend analysis."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Calendar month of the transaction, used for monthly revenue and volume reporting."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date on which the transaction was settled, used for cash-flow timing analysis."
  measures:
    - name: "total_gross_payment_volume"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment volume (GPV) processed. The primary top-line revenue signal for the payments business; executives track this as the headline volume KPI."
    - name: "total_net_payment_volume"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net payment volume after fees and deductions. Reflects actual economic value retained and is used to assess net revenue contribution."
    - name: "total_fee_amount"
      expr: SUM(CAST(amount_fee AS DOUBLE))
      comment: "Total fees charged on transactions. Tracks fee burden and is used to evaluate gateway and processing cost efficiency."
    - name: "total_tax_amount"
      expr: SUM(CAST(amount_tax AS DOUBLE))
      comment: "Total tax collected across transactions. Required for regulatory reporting and tax liability management."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total value refunded to customers. High refund volume signals product quality or fraud issues and directly erodes net revenue."
    - name: "avg_transaction_value"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross transaction value. A key indicator of customer spending behaviour and product mix; declining ATV signals basket erosion."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of payment transactions processed. Baseline volume metric used to normalise all rate-based KPIs."
    - name: "successful_transaction_count"
      expr: COUNT(CASE WHEN payment_transaction_status = 'completed' THEN 1 END)
      comment: "Count of successfully completed transactions. Used to compute success rates and assess gateway reliability."
    - name: "failed_transaction_count"
      expr: COUNT(CASE WHEN payment_transaction_status = 'failed' THEN 1 END)
      comment: "Count of failed transactions. Elevated failure counts indicate gateway issues, fraud blocks, or card decline problems requiring immediate intervention."
    - name: "chargeback_transaction_count"
      expr: COUNT(CASE WHEN chargeback_flag = TRUE THEN 1 END)
      comment: "Number of transactions that resulted in a chargeback. Feeds the chargeback rate KPI and triggers risk and compliance reviews."
    - name: "recurring_transaction_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Count of recurring/subscription transactions. Tracks subscription billing health and recurring revenue base."
    - name: "unique_seller_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers generating payment transactions. Measures marketplace payment breadth and seller activation."
    - name: "unique_order_count"
      expr: COUNT(DISTINCT header_id)
      comment: "Number of distinct orders with payment transactions. Used to reconcile payment volume against order volume."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization-level KPIs covering approval rates, fraud flags, settlement efficiency, and fee analysis. Enables real-time monitoring of payment gateway health and fraud exposure."
  source: "`ecommerce_ecm`.`payment`.`authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Outcome of the authorization request (e.g. approved, declined, pending), the primary dimension for approval-rate analysis."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the authorization was initiated, used for channel-level approval rate benchmarking."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used for the authorization, enabling method-level decline analysis."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand, used to identify network-specific approval rate issues."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the billing address, used for geographic fraud and decline pattern analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency, used for multi-currency authorization volume reporting."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the authorization was flagged as potentially fraudulent, used to segment fraud-impacted volume."
    - name: "is_captured"
      expr: is_captured
      comment: "Whether the authorization has been captured (converted to a charge), used to measure capture conversion."
    - name: "is_voided"
      expr: is_voided
      comment: "Whether the authorization was voided before capture, used to track void rates and abandoned checkouts."
    - name: "three_ds_result"
      expr: three_ds_result
      comment: "Result of 3D Secure authentication, used to assess SCA compliance and its impact on approval rates."
    - name: "decline_reason"
      expr: decline_reason
      comment: "Reason code for declined authorizations, used to diagnose and remediate specific decline categories."
    - name: "authorization_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Calendar day of the authorization, used for daily approval rate trending."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month of the authorization, used for monthly volume and approval rate reporting."
  measures:
    - name: "total_auth_amount"
      expr: SUM(CAST(auth_amount AS DOUBLE))
      comment: "Total value of all authorization requests. Represents the gross attempted payment volume and is the top-line authorization KPI."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total amount settled from authorized transactions. The gap between auth amount and settlement amount reveals capture leakage."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total authorization fees incurred. Used to track gateway cost per authorization and negotiate fee structures."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharges applied to authorizations. Tracks surcharge revenue and customer cost impact."
    - name: "authorization_count"
      expr: COUNT(1)
      comment: "Total number of authorization attempts. Baseline volume metric for all authorization rate calculations."
    - name: "approved_authorization_count"
      expr: COUNT(CASE WHEN authorization_status = 'approved' THEN 1 END)
      comment: "Number of approved authorizations. Used to compute the authorization approval rate, a critical gateway health KPI."
    - name: "declined_authorization_count"
      expr: COUNT(CASE WHEN authorization_status = 'declined' THEN 1 END)
      comment: "Number of declined authorizations. Elevated declines signal card issuer friction, fraud blocks, or gateway misconfiguration."
    - name: "fraud_flagged_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of authorizations flagged as fraudulent. Feeds the fraud flag rate KPI and triggers risk team review."
    - name: "captured_authorization_count"
      expr: COUNT(CASE WHEN is_captured = TRUE THEN 1 END)
      comment: "Number of authorizations that were successfully captured. Used to compute the capture conversion rate."
    - name: "voided_authorization_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of authorizations that were voided. High void rates indicate checkout abandonment or order cancellation issues."
    - name: "avg_auth_amount"
      expr: AVG(CAST(auth_amount AS DOUBLE))
      comment: "Average authorization amount. Tracks typical transaction size and is used to detect anomalous authorization patterns."
    - name: "avg_exchange_rate"
      expr: AVG(CAST(exchange_rate AS DOUBLE))
      comment: "Average exchange rate applied to authorizations. Used to monitor FX exposure and cross-border transaction economics."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback KPIs covering dispute volume, financial exposure, recovery rates, fraud liability, and compliance outcomes. Chargebacks are a critical risk and cost signal for the payments domain."
  source: "`ecommerce_ecm`.`payment`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current status of the chargeback (e.g. open, won, lost, pending), used to track dispute resolution pipeline."
    - name: "dispute_category"
      expr: dispute_category
      comment: "High-level category of the dispute (e.g. fraud, not-as-described, not-received), used to identify root-cause patterns."
    - name: "dispute_type"
      expr: dispute_type
      comment: "Type of dispute filed, used for granular chargeback reason analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Network-specific chargeback reason code, used for card-scheme compliance and dispute strategy."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the chargeback (e.g. won, lost, reversed), used to measure dispute win rate."
    - name: "liability_party"
      expr: liability_party
      comment: "Party bearing financial liability for the chargeback (merchant, issuer, acquirer), used for loss attribution."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network associated with the chargeback, used for network-level chargeback rate monitoring."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the original payment was made, used to identify high-chargeback channels."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the chargeback, used for multi-currency financial exposure reporting."
    - name: "evidence_submitted_flag"
      expr: evidence_submitted_flag
      comment: "Whether evidence was submitted for the dispute, used to measure dispute response compliance."
    - name: "is_fraudulent_flag"
      expr: is_fraudulent_flag
      comment: "Indicates whether the chargeback was classified as fraudulent, used to segment fraud-driven chargeback exposure."
    - name: "merchant_location_country"
      expr: merchant_location_country
      comment: "Country of the merchant involved in the chargeback, used for geographic risk analysis."
    - name: "chargeback_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Calendar month the chargeback was created, used for monthly chargeback trend reporting."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the chargeback was settled, used for cash-flow impact timing."
  measures:
    - name: "total_chargeback_original_amount"
      expr: SUM(CAST(amount_original AS DOUBLE))
      comment: "Total original transaction amount subject to chargebacks. Represents gross chargeback exposure and is the headline financial risk KPI."
    - name: "total_chargeback_net_amount"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net amount lost to chargebacks after recoveries. Directly impacts P&L and is tracked by finance and risk leadership."
    - name: "total_chargeback_fee_amount"
      expr: SUM(CAST(amount_fee AS DOUBLE))
      comment: "Total fees incurred on chargebacks. Chargeback fees compound the financial loss and are a key cost-of-risk metric."
    - name: "total_liability_amount"
      expr: SUM(CAST(liability_amount AS DOUBLE))
      comment: "Total financial liability attributed to chargebacks. Used by finance to provision for chargeback losses."
    - name: "total_chargeback_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total chargeback processing fees charged by the acquiring bank. Tracks the operational cost of dispute handling."
    - name: "chargeback_count"
      expr: COUNT(1)
      comment: "Total number of chargebacks filed. Baseline volume metric used to compute chargeback rates against transaction volume."
    - name: "won_chargeback_count"
      expr: COUNT(CASE WHEN outcome = 'won' THEN 1 END)
      comment: "Number of chargebacks won by the merchant. Used to compute the dispute win rate, a key operational efficiency KPI."
    - name: "lost_chargeback_count"
      expr: COUNT(CASE WHEN outcome = 'lost' THEN 1 END)
      comment: "Number of chargebacks lost by the merchant. Lost chargebacks represent confirmed financial losses and trigger process reviews."
    - name: "fraudulent_chargeback_count"
      expr: COUNT(CASE WHEN is_fraudulent_flag = TRUE THEN 1 END)
      comment: "Number of chargebacks classified as fraudulent. Feeds the fraud-driven chargeback rate and informs fraud prevention investment."
    - name: "evidence_submitted_count"
      expr: COUNT(CASE WHEN evidence_submitted_flag = TRUE THEN 1 END)
      comment: "Number of chargebacks for which evidence was submitted. Low evidence submission rates indicate operational gaps in dispute management."
    - name: "avg_chargeback_amount"
      expr: AVG(CAST(amount_original AS DOUBLE))
      comment: "Average original amount per chargeback. Tracks typical chargeback size and helps identify high-value dispute segments."
    - name: "unique_seller_chargeback_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers with chargebacks. Identifies sellers with systemic chargeback issues requiring intervention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud case KPIs covering fraud exposure, recovery rates, investigation efficiency, and high-risk case concentration. Enables the risk and compliance teams to steer fraud prevention investment and measure detection effectiveness."
  source: "`ecommerce_ecm`.`payment`.`fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case (e.g. open, closed, escalated), used to track investigation pipeline health."
    - name: "fraud_type"
      expr: fraud_type
      comment: "Classification of the fraud type (e.g. account takeover, card-not-present, synthetic identity), used to prioritise prevention strategies."
    - name: "detection_source"
      expr: detection_source
      comment: "Source that detected the fraud (e.g. rule engine, ML model, manual review), used to evaluate detection channel effectiveness."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final resolution of the fraud case (e.g. confirmed fraud, false positive, unresolved), used to measure investigation accuracy."
    - name: "rule_name"
      expr: rule_name
      comment: "Name of the fraud detection rule that triggered the case, used to evaluate rule-level precision and recall."
    - name: "rule_action"
      expr: rule_action
      comment: "Action taken by the fraud rule (e.g. block, review, allow), used to assess rule aggressiveness and false-positive impact."
    - name: "is_high_risk"
      expr: is_high_risk
      comment: "Flags cases classified as high risk, used to segment and prioritise the most critical fraud investigations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the fraudulent transaction, used for multi-currency fraud exposure reporting."
    - name: "geo_country_code"
      expr: geo_country_code
      comment: "Country where the fraud originated, used for geographic fraud pattern analysis and regulatory reporting."
    - name: "fraud_detection_month"
      expr: DATE_TRUNC('month', detection_timestamp)
      comment: "Calendar month the fraud was detected, used for monthly fraud trend reporting."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Calendar day of the fraudulent transaction, used for daily fraud volume trending."
  measures:
    - name: "total_fraud_amount"
      expr: SUM(CAST(fraud_amount AS DOUBLE))
      comment: "Total monetary value of confirmed fraud cases. The headline fraud exposure KPI tracked by risk, finance, and executive leadership."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered from fraud cases. Measures the effectiveness of fraud recovery operations and directly offsets fraud losses."
    - name: "total_processing_fee_on_fraud"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total processing fees incurred on fraudulent transactions. Represents the operational cost overhead of fraud beyond the direct loss."
    - name: "fraud_case_count"
      expr: COUNT(1)
      comment: "Total number of fraud cases opened. Baseline volume metric used to compute fraud rates and track detection throughput."
    - name: "high_risk_case_count"
      expr: COUNT(CASE WHEN is_high_risk = TRUE THEN 1 END)
      comment: "Number of cases classified as high risk. High-risk case concentration drives escalation decisions and resource allocation."
    - name: "confirmed_fraud_case_count"
      expr: COUNT(CASE WHEN resolution_outcome = 'confirmed_fraud' THEN 1 END)
      comment: "Number of cases confirmed as genuine fraud. Used to compute the fraud confirmation rate and validate detection model precision."
    - name: "avg_fraud_amount"
      expr: AVG(CAST(fraud_amount AS DOUBLE))
      comment: "Average fraud amount per case. Tracks typical fraud ticket size and helps identify high-value fraud vectors."
    - name: "avg_recovery_amount"
      expr: AVG(CAST(recovery_amount AS DOUBLE))
      comment: "Average recovery amount per fraud case. Benchmarks recovery efficiency and informs investment in recovery operations."
    - name: "unique_seller_fraud_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers associated with fraud cases. Identifies sellers with systemic fraud exposure requiring account review."
    - name: "unique_merchant_account_fraud_count"
      expr: COUNT(DISTINCT merchant_account_id)
      comment: "Number of distinct merchant accounts involved in fraud cases. Used to assess merchant-level fraud concentration and risk."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement KPIs covering net settlement amounts, fee structures, manual settlement rates, and settlement cycle efficiency. Enables finance and treasury teams to manage cash flow and fee optimisation."
  source: "`ecommerce_ecm`.`payment`.`settlement`"
  dimensions:
    - name: "settlement_status"
      expr: settlement_status
      comment: "Current status of the settlement batch (e.g. completed, pending, failed), used to track settlement pipeline health."
    - name: "settlement_type"
      expr: settlement_type
      comment: "Type of settlement (e.g. standard, chargeback, refund), used to decompose settlement volume by purpose."
    - name: "settlement_method"
      expr: settlement_method
      comment: "Method used for settlement (e.g. ACH, wire, SWIFT), used to analyse settlement channel costs and timing."
    - name: "currency_code"
      expr: currency_code
      comment: "Settlement currency, used for multi-currency cash flow reporting."
    - name: "cycle"
      expr: cycle
      comment: "Settlement cycle (e.g. daily, weekly, monthly), used to analyse settlement frequency and cash conversion speed."
    - name: "is_manual_settlement"
      expr: is_manual_settlement
      comment: "Indicates whether the settlement was processed manually, used to track operational overhead and automation gaps."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the settlement record, used for reconciliation and audit trail analysis."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the settlement was processed, used for daily and monthly cash flow reporting."
    - name: "settlement_month"
      expr: DATE_TRUNC('month', settlement_timestamp)
      comment: "Calendar month of the settlement, used for monthly treasury and finance reporting."
  measures:
    - name: "total_settlement_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross settlement amount processed. The primary cash-flow KPI for treasury; tracks total funds moving through the settlement layer."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net settlement amount after all fees. Represents actual cash received by the business and is the key treasury liquidity metric."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_total_amount AS DOUBLE))
      comment: "Total fees deducted from settlements. Tracks the aggregate cost of payment processing and informs gateway fee negotiation."
    - name: "total_interchange_fee"
      expr: SUM(CAST(interchange_fee AS DOUBLE))
      comment: "Total interchange fees paid to card networks. Interchange is typically the largest component of payment processing cost."
    - name: "total_gateway_fee"
      expr: SUM(CAST(gateway_fee AS DOUBLE))
      comment: "Total gateway fees incurred. Used to benchmark gateway cost efficiency and support vendor negotiation."
    - name: "total_cross_border_fee"
      expr: SUM(CAST(cross_border_fee AS DOUBLE))
      comment: "Total cross-border transaction fees. Tracks the cost of international payment processing and informs FX strategy."
    - name: "total_currency_conversion_fee"
      expr: SUM(CAST(currency_conversion_fee AS DOUBLE))
      comment: "Total currency conversion fees. Measures FX conversion cost and supports multi-currency pricing decisions."
    - name: "total_assessment_fee"
      expr: SUM(CAST(assessment_fee AS DOUBLE))
      comment: "Total assessment fees charged by card networks. Tracks network assessment cost as a component of total processing expense."
    - name: "settlement_batch_count"
      expr: COUNT(1)
      comment: "Total number of settlement batches processed. Used to monitor settlement throughput and operational volume."
    - name: "manual_settlement_count"
      expr: COUNT(CASE WHEN is_manual_settlement = TRUE THEN 1 END)
      comment: "Number of manually processed settlements. High manual settlement counts indicate automation gaps and increased operational risk."
    - name: "avg_net_settlement_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net settlement amount per batch. Used to track typical settlement size and detect anomalous settlement patterns."
    - name: "avg_processing_fee_rate"
      expr: AVG(CAST(processing_fee_rate AS DOUBLE))
      comment: "Average processing fee rate across settlements. Benchmarks effective fee rates and supports gateway contract optimisation."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_reconciliation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reconciliation KPIs covering match rates, variance amounts, unmatched line exposure, and reconciliation cycle efficiency. Critical for finance controls, audit readiness, and cash integrity."
  source: "`ecommerce_ecm`.`payment`.`reconciliation`"
  dimensions:
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Current status of the reconciliation run (e.g. completed, in-progress, failed), used to track reconciliation pipeline health."
    - name: "run_type"
      expr: run_type
      comment: "Type of reconciliation run (e.g. daily, monthly, ad-hoc), used to segment reconciliation performance by cycle type."
    - name: "source_system"
      expr: source_system
      comment: "Source system being reconciled, used to identify which systems have the highest variance or unmatched line rates."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the reconciliation, used for multi-currency variance analysis."
    - name: "exception_reason_code"
      expr: exception_reason_code
      comment: "Reason code for reconciliation exceptions, used to diagnose and remediate systematic reconciliation failures."
    - name: "period_start_date"
      expr: period_start_date
      comment: "Start date of the reconciliation period, used for period-over-period variance trending."
    - name: "period_end_date"
      expr: period_end_date
      comment: "End date of the reconciliation period, used to define the reconciliation window for reporting."
    - name: "reconciliation_month"
      expr: DATE_TRUNC('month', run_timestamp)
      comment: "Calendar month of the reconciliation run, used for monthly finance close reporting."
  measures:
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total monetary variance between internal and external records. The headline reconciliation quality KPI; large variances trigger finance investigations and audit escalations."
    - name: "total_internal_amount"
      expr: SUM(CAST(total_internal_amount AS DOUBLE))
      comment: "Total amount per internal records across reconciliation runs. Used as the reference baseline for variance calculation."
    - name: "total_external_amount"
      expr: SUM(CAST(total_external_amount AS DOUBLE))
      comment: "Total amount per external (bank/gateway) records. Compared against internal amounts to identify discrepancies."
    - name: "total_matched_lines"
      expr: SUM(CAST(matched_line_count AS DOUBLE))
      comment: "Total number of matched reconciliation lines. Used to compute the match rate and assess reconciliation completeness."
    - name: "total_unmatched_lines"
      expr: SUM(CAST(unmatched_line_count AS DOUBLE))
      comment: "Total number of unmatched reconciliation lines. Unmatched lines represent unresolved discrepancies and are a key audit risk indicator."
    - name: "total_reconciliation_lines"
      expr: SUM(CAST(total_line_count AS DOUBLE))
      comment: "Total number of lines processed across all reconciliation runs. Baseline volume metric for match rate computation."
    - name: "reconciliation_run_count"
      expr: COUNT(1)
      comment: "Total number of reconciliation runs executed. Used to monitor reconciliation cadence and operational throughput."
    - name: "avg_variance_amount"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average variance amount per reconciliation run. Tracks typical reconciliation quality and detects deteriorating match accuracy over time."
    - name: "reconciliation_runs_with_variance_count"
      expr: COUNT(CASE WHEN variance_amount <> 0 THEN 1 END)
      comment: "Number of reconciliation runs that produced a non-zero variance. High counts indicate systemic data quality or timing issues."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund KPIs covering refund volume, net refund cost, processing fees, fraud-flagged refunds, and refund method distribution. Refunds directly erode revenue and signal product or fulfilment quality issues."
  source: "`ecommerce_ecm`.`payment`.`payment_refund`"
  dimensions:
    - name: "payment_refund_status"
      expr: payment_refund_status
      comment: "Current status of the refund (e.g. completed, pending, failed), used to track refund processing pipeline health."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund (e.g. full, partial, promotional), used to decompose refund volume by category."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. original payment method, store credit, bank transfer), used to analyse refund channel costs."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund, used to identify root causes driving refund volume (e.g. damaged goods, wrong item, fraud)."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the original payment was made, used to identify high-refund channels."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method of the original transaction, used to analyse refund rates by payment instrument."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund, used for multi-currency refund exposure reporting."
    - name: "is_fraud"
      expr: is_fraud
      comment: "Indicates whether the refund was associated with a fraud case, used to segment fraud-driven refund exposure."
    - name: "request_source"
      expr: request_source
      comment: "Source that initiated the refund request (e.g. customer, agent, system), used to analyse refund initiation patterns."
    - name: "refund_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Calendar month the refund was initiated, used for monthly refund trend reporting."
    - name: "refund_date"
      expr: DATE_TRUNC('day', initiated_timestamp)
      comment: "Calendar day the refund was initiated, used for daily refund volume trending."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross refund amount issued. The headline refund exposure KPI; directly reduces net revenue and is tracked by finance and operations leadership."
    - name: "total_net_refund_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net refund amount after fees. Represents the actual cash outflow from refunds and is the key P&L impact metric."
    - name: "total_refund_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees incurred on refund processing. Tracks the operational cost of issuing refunds beyond the refund principal."
    - name: "total_refund_processing_fee"
      expr: SUM(CAST(processing_fee AS DOUBLE))
      comment: "Total processing fees charged on refund transactions. Used to assess the full cost of refund operations."
    - name: "refund_count"
      expr: COUNT(1)
      comment: "Total number of refunds issued. Baseline volume metric used to compute refund rates and track operational refund throughput."
    - name: "fraud_refund_count"
      expr: COUNT(CASE WHEN is_fraud = TRUE THEN 1 END)
      comment: "Number of refunds associated with fraud cases. Fraud-driven refunds represent a compounded loss (original fraud + refund cost) and require immediate risk action."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Tracks typical refund size and helps identify high-value refund segments requiring policy review."
    - name: "unique_seller_refund_count"
      expr: COUNT(DISTINCT seller_profile_id)
      comment: "Number of distinct sellers generating refunds. Identifies sellers with disproportionate refund rates requiring operational intervention."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_merchant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchant account KPIs covering transaction limits, fee structures, compliance status, and account health. Enables risk, compliance, and commercial teams to manage merchant portfolio quality."
  source: "`ecommerce_ecm`.`payment`.`merchant_account`"
  dimensions:
    - name: "merchant_account_status"
      expr: merchant_account_status
      comment: "Current status of the merchant account (e.g. active, suspended, terminated), used to track portfolio health."
    - name: "account_type"
      expr: account_type
      comment: "Type of merchant account (e.g. standard, premium, marketplace), used to segment the merchant portfolio."
    - name: "pci_compliance_status"
      expr: pci_compliance_status
      comment: "PCI DSS compliance status of the merchant account, used for regulatory risk monitoring."
    - name: "compliance_audit_status"
      expr: compliance_audit_status
      comment: "Status of the most recent compliance audit, used to identify accounts requiring remediation."
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency in which the merchant account settles, used for multi-currency portfolio analysis."
    - name: "payment_network"
      expr: payment_network
      comment: "Payment network associated with the merchant account (e.g. Visa, Mastercard), used for network-level portfolio analysis."
    - name: "merchant_category_code"
      expr: merchant_category_code
      comment: "MCC code classifying the merchant type, used for regulatory segmentation and risk profiling."
    - name: "is_multi_currency"
      expr: is_multi_currency
      comment: "Indicates whether the account supports multiple currencies, used to segment international merchant capability."
    - name: "fraud_detection_enabled"
      expr: fraud_detection_enabled
      comment: "Indicates whether fraud detection is enabled on the account, used to assess fraud control coverage across the merchant portfolio."
    - name: "onboarding_month"
      expr: DATE_TRUNC('month', onboarding_date)
      comment: "Month the merchant account was onboarded, used for cohort analysis of merchant portfolio growth."
  measures:
    - name: "merchant_account_count"
      expr: COUNT(1)
      comment: "Total number of merchant accounts. Tracks portfolio size and is the baseline for all merchant-level rate calculations."
    - name: "active_merchant_account_count"
      expr: COUNT(CASE WHEN merchant_account_status = 'active' THEN 1 END)
      comment: "Number of active merchant accounts. Active account count is the primary measure of merchant portfolio health and commercial reach."
    - name: "pci_non_compliant_count"
      expr: COUNT(CASE WHEN pci_compliance_status <> 'compliant' THEN 1 END)
      comment: "Number of merchant accounts not meeting PCI DSS compliance. Non-compliant accounts represent regulatory and financial risk requiring immediate remediation."
    - name: "fraud_detection_disabled_count"
      expr: COUNT(CASE WHEN fraud_detection_enabled = FALSE THEN 1 END)
      comment: "Number of merchant accounts with fraud detection disabled. Accounts without fraud detection are disproportionately exposed to fraud losses."
    - name: "total_daily_volume_limit"
      expr: SUM(CAST(daily_volume_limit AS DOUBLE))
      comment: "Total daily volume limit across all merchant accounts. Represents the maximum daily processing capacity of the merchant portfolio."
    - name: "total_monthly_volume_limit"
      expr: SUM(CAST(monthly_volume_limit AS DOUBLE))
      comment: "Total monthly volume limit across all merchant accounts. Used to assess portfolio capacity headroom against actual transaction volumes."
    - name: "avg_processing_fee_rate"
      expr: AVG(CAST(processing_fee_rate AS DOUBLE))
      comment: "Average processing fee rate across merchant accounts. Benchmarks fee competitiveness and informs commercial pricing strategy."
    - name: "avg_chargeback_fee_rate"
      expr: AVG(CAST(chargeback_fee_rate AS DOUBLE))
      comment: "Average chargeback fee rate across merchant accounts. Tracks the cost burden of chargebacks at the portfolio level."
$$;

CREATE OR REPLACE VIEW `ecommerce_ecm`.`_metrics`.`payment_wallet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital wallet KPIs covering wallet balances, transaction activity, credit/debit flows, and wallet health. Enables product and finance teams to manage the digital wallet ecosystem and customer funds."
  source: "`ecommerce_ecm`.`payment`.`wallet`"
  dimensions:
    - name: "wallet_status"
      expr: wallet_status
      comment: "Current status of the wallet (e.g. active, suspended, closed), used to track wallet portfolio health."
    - name: "wallet_type"
      expr: wallet_type
      comment: "Type of wallet (e.g. consumer, merchant, promotional), used to segment wallet volume and balance by purpose."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the wallet, used for multi-currency balance and flow reporting."
    - name: "is_default_wallet"
      expr: is_default_wallet
      comment: "Indicates whether the wallet is the customer's default payment method, used to measure wallet adoption as primary payment instrument."
    - name: "wallet_creation_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the wallet was created, used for cohort analysis of wallet adoption and balance growth."
    - name: "last_transaction_month"
      expr: DATE_TRUNC('month', last_transaction_timestamp)
      comment: "Month of the most recent wallet transaction, used to identify active vs. dormant wallets."
  measures:
    - name: "total_wallet_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance held across all wallets. Represents customer funds under management and is a key liability metric for finance and treasury."
    - name: "total_pending_balance"
      expr: SUM(CAST(pending_balance AS DOUBLE))
      comment: "Total pending balance across wallets. Pending balances represent funds in transit and are tracked for liquidity management."
    - name: "total_credits"
      expr: SUM(CAST(total_credits AS DOUBLE))
      comment: "Total credits loaded into wallets. Tracks wallet top-up activity and informs customer engagement with the wallet product."
    - name: "total_debits"
      expr: SUM(CAST(total_debits AS DOUBLE))
      comment: "Total debits from wallets. Tracks wallet spend activity and is used to measure wallet utilisation as a payment instrument."
    - name: "wallet_count"
      expr: COUNT(1)
      comment: "Total number of wallets. Tracks wallet product adoption and is the baseline for all wallet-level rate calculations."
    - name: "active_wallet_count"
      expr: COUNT(CASE WHEN wallet_status = 'active' THEN 1 END)
      comment: "Number of active wallets. Active wallet count is the primary measure of wallet product health and customer engagement."
    - name: "default_wallet_count"
      expr: COUNT(CASE WHEN is_default_wallet = TRUE THEN 1 END)
      comment: "Number of wallets set as the customer's default payment method. Measures wallet adoption as the primary checkout instrument."
    - name: "avg_wallet_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per wallet. Tracks typical customer wallet funding level and informs wallet product design and incentive strategies."
    - name: "total_wallet_transaction_count"
      expr: SUM(CAST(transaction_count AS DOUBLE))
      comment: "Total number of transactions processed across all wallets. Measures aggregate wallet usage activity and throughput."
$$;