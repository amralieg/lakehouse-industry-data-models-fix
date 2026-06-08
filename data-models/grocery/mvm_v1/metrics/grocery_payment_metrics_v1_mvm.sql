-- Metric views for domain: payment | Business: Grocery | Version: 1 | Generated on: 2026-05-04 20:38:05

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core payment transaction KPIs covering revenue throughput, tender mix, discount impact, tax collection, cashback liability, and chargeback exposure. Primary steering dashboard for payment operations and finance leadership."
  source: "`grocery_ecm`.`payment`.`transaction`"
  dimensions:
    - name: "transaction_channel"
      expr: channel
      comment: "Sales channel through which the transaction was initiated (e.g., in-store POS, ecommerce, mobile app, fuel center) — enables channel-level payment performance analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Classification of the transaction (e.g., sale, refund, void, cashback) — essential for filtering to revenue-generating events vs. reversals."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction (e.g., approved, declined, pending, settled) — used to isolate successful vs. failed payment events."
    - name: "card_type"
      expr: card_type
      comment: "Type of card used (e.g., credit, debit, prepaid) — informs interchange cost modeling and tender-mix strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the transaction — supports multi-currency reporting and FX exposure tracking."
    - name: "card_entry_mode"
      expr: card_entry_mode
      comment: "Method by which card data was captured (e.g., chip, swipe, tap, keyed) — relevant for fraud risk segmentation and interchange qualification."
    - name: "processor_name"
      expr: processor_name
      comment: "Name of the payment processor that handled the transaction — enables processor-level cost and performance benchmarking."
    - name: "chargeback_flag"
      expr: chargeback_flag
      comment: "Boolean indicator that this transaction has an associated chargeback — used to segment chargeback-exposed revenue."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Calendar date of the transaction, truncated to day — primary time dimension for daily revenue and volume trending."
    - name: "transaction_month"
      expr: DATE_TRUNC('month', transaction_timestamp)
      comment: "Calendar month of the transaction — supports monthly financial close and period-over-period comparisons."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date on which the transaction was settled with the acquiring bank — used to reconcile cash flow timing vs. transaction date."
    - name: "pos_terminal_code"
      expr: pos_terminal_code
      comment: "Identifier of the POS terminal that processed the transaction — enables terminal-level throughput and error-rate analysis."
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross payment volume across all transactions. Primary revenue throughput KPI used in daily financial reporting and executive dashboards."
    - name: "avg_transaction_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average transaction value. Tracks basket-size trends at the payment level; a declining average signals mix shift or promotional pressure."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total promotional and markdown discounts applied at the transaction level. Measures promotional cost and its drag on net revenue."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total sales tax collected across transactions. Required for tax remittance reconciliation and regulatory compliance reporting."
    - name: "total_cashback_amount"
      expr: SUM(CAST(cashback_amount AS DOUBLE))
      comment: "Total cashback disbursed to shoppers at POS. Represents a direct cash outflow liability tracked by treasury and store operations."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts collected (relevant for deli, floral, and service departments). Informs labor cost allocation and service quality programs."
    - name: "total_fuel_reward_discount_applied"
      expr: SUM(CAST(fuel_reward_discount_applied AS DOUBLE))
      comment: "Total fuel reward discounts redeemed at the transaction level. Measures the cost of the fuel loyalty program and its redemption velocity."
    - name: "total_snap_eligible_amount"
      expr: SUM(CAST(snap_eligible_amount AS DOUBLE))
      comment: "Total SNAP/EBT-eligible transaction amounts. Required for USDA SNAP program compliance reporting and government reimbursement reconciliation."
    - name: "total_wic_eligible_amount"
      expr: SUM(CAST(wic_eligible_amount AS DOUBLE))
      comment: "Total WIC-eligible transaction amounts. Required for WIC program compliance and state agency reimbursement reporting."
    - name: "total_subtotal_amount"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-discount subtotal across transactions. Used to compute effective tax rate and discount penetration rate in BI."
    - name: "chargeback_exposed_transaction_count"
      expr: COUNT(CASE WHEN chargeback_flag = TRUE THEN transaction_id END)
      comment: "Count of transactions flagged as having an associated chargeback. Tracks chargeback incidence rate and exposure volume for risk management."
    - name: "distinct_transaction_count"
      expr: COUNT(DISTINCT transaction_id)
      comment: "Count of unique payment transactions. Core volume KPI used to compute approval rates, average ticket, and throughput per channel or terminal."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment authorization performance KPIs covering approval rates, partial approvals, void rates, response latency, and fraud signal indicators. Used by payment operations, risk, and treasury to optimize gateway routing and reduce decline losses."
  source: "`grocery_ecm`.`payment`.`authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Outcome of the authorization request (e.g., approved, declined, partial, timeout) — primary dimension for approval-rate analysis."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (e.g., Visa, Mastercard, Amex, Discover) — used to analyze approval rates and interchange costs by network."
    - name: "channel"
      expr: channel
      comment: "Transaction channel (e.g., POS, ecommerce, mobile) — enables channel-level authorization performance benchmarking."
    - name: "entry_mode"
      expr: entry_mode
      comment: "Card data entry method (e.g., chip, swipe, contactless, keyed) — correlates with fraud risk and interchange qualification tier."
    - name: "processor_name"
      expr: processor_name
      comment: "Payment processor that handled the authorization — used for processor-level approval rate and latency benchmarking."
    - name: "cardholder_verification_method"
      expr: cardholder_verification_method
      comment: "Method used to verify the cardholder (e.g., PIN, signature, no CVM) — relevant for fraud risk and chargeback liability analysis."
    - name: "three_d_secure_status"
      expr: three_d_secure_status
      comment: "3D Secure authentication outcome — used to assess fraud liability shift and ecommerce authorization quality."
    - name: "avs_result_code"
      expr: avs_result_code
      comment: "Address Verification Service result code — used to segment authorizations by fraud risk signal strength."
    - name: "cvv_result_code"
      expr: cvv_result_code
      comment: "CVV verification result code — key fraud signal dimension for card-not-present authorization quality analysis."
    - name: "is_void"
      expr: is_void
      comment: "Boolean flag indicating the authorization was subsequently voided — used to measure void rate and its impact on net authorized volume."
    - name: "partial_approval_flag"
      expr: partial_approval_flag
      comment: "Boolean flag indicating the authorization was only partially approved — relevant for EBT/gift card split-tender scenarios."
    - name: "authorization_date"
      expr: DATE_TRUNC('day', requested_at_timestamp)
      comment: "Calendar date of the authorization request — primary time dimension for daily approval rate trending."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', requested_at_timestamp)
      comment: "Calendar month of the authorization request — supports monthly payment performance reviews."
  measures:
    - name: "total_authorized_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross amount authorized. Represents the payment volume pipeline before settlement; compared against settled amounts to detect leakage."
    - name: "total_partial_approved_amount"
      expr: SUM(CAST(partial_approved_amount AS DOUBLE))
      comment: "Total amount approved in partial-approval scenarios. Measures the gap between requested and approved amounts in split-tender transactions."
    - name: "total_ebt_balance_remaining"
      expr: SUM(CAST(ebt_balance_remaining AS DOUBLE))
      comment: "Total EBT balance remaining after authorization. Used to monitor EBT program utilization and ensure compliance with SNAP/WIC benefit limits."
    - name: "total_fuel_rewards_redeemed_amount"
      expr: SUM(CAST(fuel_rewards_redeemed_amount AS DOUBLE))
      comment: "Total fuel reward dollars redeemed at authorization. Measures the financial cost of the fuel loyalty program at the point of redemption."
    - name: "approved_authorization_count"
      expr: COUNT(CASE WHEN authorization_status = 'approved' THEN authorization_id END)
      comment: "Count of approved authorizations. Numerator for authorization approval rate — a key payment health KPI monitored by operations and finance."
    - name: "total_authorization_count"
      expr: COUNT(DISTINCT authorization_id)
      comment: "Total count of authorization attempts. Denominator for approval rate and decline rate calculations; baseline volume KPI."
    - name: "voided_authorization_count"
      expr: COUNT(CASE WHEN is_void = TRUE THEN authorization_id END)
      comment: "Count of voided authorizations. Elevated void rates signal operational issues (e.g., abandoned carts, POS errors) that reduce effective throughput."
    - name: "partial_approval_count"
      expr: COUNT(CASE WHEN partial_approval_flag = TRUE THEN authorization_id END)
      comment: "Count of partial approvals. Tracks split-tender frequency, particularly for EBT and gift card transactions, informing tender-type strategy."
    - name: "avg_authorized_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average authorized transaction amount. Benchmarks typical transaction size at the authorization stage; deviations may indicate fraud or data quality issues."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Chargeback risk and financial impact KPIs covering dispute volume, financial exposure, recovery performance, fraud indicators, and representment effectiveness. Critical for risk management, finance, and compliance leadership."
  source: "`grocery_ecm`.`payment`.`chargeback`"
  dimensions:
    - name: "chargeback_status"
      expr: chargeback_status
      comment: "Current lifecycle status of the chargeback case (e.g., open, won, lost, pending) — primary dimension for case pipeline management."
    - name: "dispute_category"
      expr: dispute_category
      comment: "Category of the dispute (e.g., fraud, not-as-described, not-received) — used to identify root causes and prioritize prevention programs."
    - name: "reason_code"
      expr: reason_code
      comment: "Card network reason code for the chargeback — enables granular root-cause analysis and representment strategy by code."
    - name: "card_type"
      expr: card_type
      comment: "Card type associated with the disputed transaction — used to analyze chargeback rates by card network and type."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final resolution of the chargeback (e.g., won, lost, settled) — measures representment effectiveness and financial recovery rate."
    - name: "fraud_indicator_flag"
      expr: fraud_indicator_flag
      comment: "Boolean flag indicating the chargeback is associated with a fraud event — used to segment fraud-driven vs. service-driven disputes."
    - name: "evidence_submitted_flag"
      expr: evidence_submitted_flag
      comment: "Boolean flag indicating evidence was submitted for representment — used to measure operational compliance with dispute response SLAs."
    - name: "customer_contacted_flag"
      expr: customer_contacted_flag
      comment: "Boolean flag indicating the customer was contacted during the dispute process — tracks customer service engagement in chargeback resolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the disputed amount — supports multi-currency chargeback exposure reporting."
    - name: "chargeback_received_month"
      expr: DATE_TRUNC('month', received_timestamp)
      comment: "Month the chargeback was received — primary time dimension for monthly chargeback volume and financial impact trending."
    - name: "original_transaction_date"
      expr: original_transaction_date
      comment: "Date of the original transaction that was disputed — used to measure lag between transaction and chargeback, informing fraud detection timing."
    - name: "issuing_bank_name"
      expr: issuing_bank_name
      comment: "Name of the bank that issued the disputed card — enables issuer-level chargeback rate analysis and relationship management."
  measures:
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total dollar value of all disputed transactions. Primary financial exposure KPI for chargeback risk — monitored by CFO and risk leadership."
    - name: "total_chargeback_fee"
      expr: SUM(CAST(fee AS DOUBLE))
      comment: "Total fees charged by the acquiring bank for processing chargebacks. Direct cost of disputes beyond the disputed amount — tracked for cost management."
    - name: "total_net_financial_impact"
      expr: SUM(CAST(net_financial_impact AS DOUBLE))
      comment: "Total net financial impact of chargebacks after recoveries and fees. The true bottom-line cost of the chargeback portfolio — key P&L metric."
    - name: "total_recovery_amount"
      expr: SUM(CAST(recovery_amount AS DOUBLE))
      comment: "Total amount recovered through representment and dispute resolution. Measures the effectiveness of the chargeback recovery program."
    - name: "total_chargeback_count"
      expr: COUNT(DISTINCT chargeback_id)
      comment: "Total number of chargeback cases. Volume KPI used to compute chargeback rate against transaction volume — a key card network compliance threshold."
    - name: "fraud_chargeback_count"
      expr: COUNT(CASE WHEN fraud_indicator_flag = TRUE THEN chargeback_id END)
      comment: "Count of chargebacks flagged as fraud-related. Tracks fraud-driven dispute volume — elevated counts trigger fraud prevention program reviews."
    - name: "won_chargeback_count"
      expr: COUNT(CASE WHEN resolution_outcome = 'won' THEN chargeback_id END)
      comment: "Count of chargebacks resolved in the merchant's favor. Numerator for win rate calculation — measures representment program effectiveness."
    - name: "evidence_submitted_count"
      expr: COUNT(CASE WHEN evidence_submitted_flag = TRUE THEN chargeback_id END)
      comment: "Count of chargebacks for which evidence was submitted. Measures operational compliance with representment SLAs and dispute response coverage."
    - name: "avg_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average disputed transaction amount. Benchmarks typical chargeback size; large averages indicate high-value fraud or fulfillment disputes."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund operations KPIs covering refund volume, financial impact, processing costs, store credit issuance, and special program reversals (EBT, WIC, prescription). Used by store operations, finance, and compliance to manage return policy costs and regulatory obligations."
  source: "`grocery_ecm`.`payment`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g., pending, approved, completed, rejected) — used to track refund pipeline and identify processing bottlenecks."
    - name: "refund_type"
      expr: refund_type
      comment: "Classification of the refund (e.g., return, price adjustment, chargeback-related) — enables root-cause analysis of refund drivers."
    - name: "initiated_by_channel"
      expr: initiated_by_channel
      comment: "Channel through which the refund was initiated (e.g., in-store, online, call center) — used to benchmark refund rates by channel."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund — enables systematic analysis of return drivers to inform product quality and policy decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund — supports multi-currency refund liability reporting."
    - name: "return_to_original_tender_flag"
      expr: return_to_original_tender_flag
      comment: "Boolean flag indicating the refund was returned to the original payment method — used to track tender-type refund routing compliance."
    - name: "store_credit_issued_flag"
      expr: store_credit_issued_flag
      comment: "Boolean flag indicating store credit was issued instead of a cash/card refund — tracks store credit issuance rate and its impact on future revenue."
    - name: "chargeback_related_flag"
      expr: chargeback_related_flag
      comment: "Boolean flag indicating the refund is associated with a chargeback — used to separate chargeback-driven refunds from voluntary returns."
    - name: "ebt_snap_reversal_flag"
      expr: ebt_snap_reversal_flag
      comment: "Boolean flag indicating an EBT/SNAP benefit reversal — required for USDA SNAP program compliance and benefit reconciliation."
    - name: "wic_reversal_flag"
      expr: wic_reversal_flag
      comment: "Boolean flag indicating a WIC benefit reversal — required for WIC program compliance and state agency reporting."
    - name: "prescription_reversal_flag"
      expr: prescription_reversal_flag
      comment: "Boolean flag indicating a pharmacy prescription reversal — used for pharmacy operations and insurance billing reconciliation."
    - name: "refund_month"
      expr: DATE_TRUNC('month', refund_timestamp)
      comment: "Calendar month of the refund — primary time dimension for monthly refund cost trending and period-over-period analysis."
    - name: "refund_date"
      expr: DATE_TRUNC('day', refund_timestamp)
      comment: "Calendar date of the refund — used for daily refund volume monitoring and anomaly detection."
  measures:
    - name: "total_refund_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross refund dollars issued. Primary refund cost KPI — directly reduces net revenue and is monitored by finance and store operations leadership."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded. Required for accurate tax liability reconciliation and remittance adjustments with tax authorities."
    - name: "total_processing_fee_amount"
      expr: SUM(CAST(processing_fee_amount AS DOUBLE))
      comment: "Total processing fees incurred on refunds. Measures the operational cost of the refund process beyond the refunded amount itself."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected on returns. Measures revenue recovery from the return process and policy enforcement effectiveness."
    - name: "total_store_credit_amount"
      expr: SUM(CAST(store_credit_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of cash/card refunds. Represents deferred liability that will be redeemed in future transactions — tracked by treasury."
    - name: "total_fuel_rewards_adjustment_amount"
      expr: SUM(CAST(fuel_rewards_adjustment_amount AS DOUBLE))
      comment: "Total fuel reward adjustments applied during refunds. Measures the loyalty program cost impact of the return process."
    - name: "total_refund_count"
      expr: COUNT(DISTINCT refund_id)
      comment: "Total number of refund transactions. Volume KPI used to compute refund rate against sales volume — a key return policy performance indicator."
    - name: "chargeback_related_refund_count"
      expr: COUNT(CASE WHEN chargeback_related_flag = TRUE THEN refund_id END)
      comment: "Count of refunds triggered by chargebacks. Measures the operational burden of chargeback-driven refund processing on store and finance teams."
    - name: "store_credit_issued_count"
      expr: COUNT(CASE WHEN store_credit_issued_flag = TRUE THEN refund_id END)
      comment: "Count of refunds resolved via store credit issuance. Tracks store credit adoption rate and its effectiveness as a retention tool."
    - name: "avg_refund_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average refund amount per transaction. Benchmarks typical refund size; large averages may indicate high-value fraud returns or policy abuse."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_settlement_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Settlement batch financial reconciliation KPIs covering batch amounts, fee structures, variance detection, and reconciliation status. Used by treasury, finance, and payment operations to ensure accurate and timely fund settlement."
  source: "`grocery_ecm`.`payment`.`settlement_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the settlement batch (e.g., open, submitted, settled, rejected) — primary dimension for batch pipeline monitoring."
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Reconciliation outcome for the batch (e.g., reconciled, variance, pending) — used to identify batches requiring finance team intervention."
    - name: "batch_type"
      expr: batch_type
      comment: "Type of settlement batch (e.g., standard, ecommerce, pharmacy, fuel) — enables segment-level settlement performance analysis."
    - name: "settlement_currency"
      expr: settlement_currency
      comment: "Currency in which the batch was settled — supports multi-currency treasury reconciliation."
    - name: "batch_date"
      expr: batch_date
      comment: "Date the settlement batch was closed — primary time dimension for daily settlement volume and funding timing analysis."
    - name: "funding_date"
      expr: funding_date
      comment: "Date funds were deposited into the merchant bank account — used to measure settlement lag and cash flow timing."
    - name: "batch_month"
      expr: DATE_TRUNC('month', batch_close_timestamp)
      comment: "Calendar month of batch close — supports monthly financial close reconciliation and period-over-period settlement trending."
  measures:
    - name: "total_batch_amount"
      expr: SUM(CAST(total_batch_amount AS DOUBLE))
      comment: "Total gross amount across all settlement batches. Primary cash flow KPI — represents funds expected to be deposited by the acquiring bank."
    - name: "total_net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount AS DOUBLE))
      comment: "Total net settlement amount after fees, refunds, and chargebacks. The actual cash received from the acquirer — key treasury and cash management KPI."
    - name: "total_interchange_fee_amount"
      expr: SUM(CAST(total_interchange_fee_amount AS DOUBLE))
      comment: "Total interchange fees paid to card-issuing banks. One of the largest payment processing cost line items — monitored by finance for cost optimization."
    - name: "total_assessment_fee_amount"
      expr: SUM(CAST(total_assessment_fee_amount AS DOUBLE))
      comment: "Total card network assessment fees. Tracks the cost of card network participation — used in total cost of acceptance analysis."
    - name: "total_chargeback_amount_in_batch"
      expr: SUM(CAST(total_chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts deducted within settlement batches. Measures the direct financial impact of chargebacks on settlement cash flows."
    - name: "total_refund_amount_in_batch"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total refund amounts processed within settlement batches. Tracks refund cash outflows at the settlement level for treasury reconciliation."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total settlement variance (difference between expected and actual settlement amounts). Elevated variances trigger finance investigation and may indicate processing errors or fraud."
    - name: "batch_count"
      expr: COUNT(DISTINCT settlement_batch_id)
      comment: "Total number of settlement batches processed. Volume KPI for settlement operations throughput — used to monitor batch processing efficiency."
    - name: "avg_net_settlement_amount"
      expr: AVG(CAST(net_settlement_amount AS DOUBLE))
      comment: "Average net settlement amount per batch. Benchmarks typical batch size — significant deviations may indicate batch configuration issues or volume anomalies."
    - name: "variance_batch_count"
      expr: COUNT(CASE WHEN reconciliation_status = 'variance' THEN settlement_batch_id END)
      comment: "Count of batches with a reconciliation variance. Measures the frequency of settlement discrepancies — a key operational quality metric for payment operations."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift card program financial and operational KPIs covering outstanding liability, activation performance, fraud exposure, and escheatment risk. Used by finance, treasury, and marketing to manage the gift card program P&L and regulatory compliance."
  source: "`grocery_ecm`.`payment`.`gift_card`"
  dimensions:
    - name: "gift_card_type"
      expr: gift_card_type
      comment: "Type of gift card (e.g., physical, digital, corporate) — used to analyze program performance and liability by card type."
    - name: "activation_status"
      expr: activation_status
      comment: "Current activation status of the gift card (e.g., active, inactive, redeemed, expired) — primary dimension for portfolio lifecycle analysis."
    - name: "program_name"
      expr: program_name
      comment: "Name of the gift card program (e.g., holiday, corporate, loyalty) — enables program-level performance and liability analysis."
    - name: "purchase_channel"
      expr: purchase_channel
      comment: "Channel through which the gift card was purchased (e.g., in-store, online, third-party) — used to analyze distribution channel effectiveness."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift card — supports multi-currency gift card liability reporting."
    - name: "is_reloadable"
      expr: is_reloadable
      comment: "Boolean flag indicating whether the gift card can be reloaded — used to segment open-loop vs. closed-loop card program economics."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Boolean flag indicating the gift card has been flagged for fraud — used to monitor fraud exposure within the gift card portfolio."
    - name: "escheatment_status"
      expr: escheatment_status
      comment: "Escheatment status of the gift card (e.g., pending, escheated, exempt) — required for state unclaimed property law compliance reporting."
    - name: "is_expired"
      expr: is_expired
      comment: "Boolean flag indicating the gift card has expired — used to track breakage and expired card liability release."
    - name: "issue_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month the gift card was activated — used for cohort-based liability aging and breakage rate analysis."
    - name: "issue_date"
      expr: issue_date
      comment: "Date the gift card was issued — primary time dimension for gift card cohort analysis and liability aging."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total outstanding gift card liability (unredeemed balances). A direct balance sheet liability — monitored by treasury and finance for accurate financial reporting."
    - name: "total_initial_load_amount"
      expr: SUM(CAST(initial_load_amount AS DOUBLE))
      comment: "Total initial value loaded onto gift cards at activation. Measures gross gift card program revenue and the total liability created at issuance."
    - name: "total_breakage_amount"
      expr: SUM(CAST(initial_load_amount AS DOUBLE) - CAST(current_balance AS DOUBLE))
      comment: "Total gift card breakage (initial load minus current balance). Represents revenue recognized from unredeemed gift card value — a key gift card program P&L metric."
    - name: "active_gift_card_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN gift_card_id END)
      comment: "Count of currently active gift cards. Measures the size of the active gift card portfolio and outstanding liability exposure."
    - name: "fraud_flagged_card_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN gift_card_id END)
      comment: "Count of gift cards flagged for fraud. Tracks fraud exposure within the gift card program — elevated counts trigger fraud prevention reviews."
    - name: "total_gift_card_count"
      expr: COUNT(DISTINCT gift_card_id)
      comment: "Total number of gift cards issued. Baseline volume KPI for gift card program scale and growth tracking."
    - name: "avg_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average remaining balance per active gift card. Benchmarks redemption velocity — declining averages indicate healthy redemption activity."
    - name: "avg_initial_load_amount"
      expr: AVG(CAST(initial_load_amount AS DOUBLE))
      comment: "Average initial load amount per gift card. Tracks gift card denomination trends and informs program pricing strategy."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_gateway`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment gateway operational and cost KPIs covering uptime, transaction fees, chargeback fees, and contract economics. Used by payment operations and procurement to optimize gateway selection, routing, and vendor contract negotiations."
  source: "`grocery_ecm`.`payment`.`gateway`"
  dimensions:
    - name: "gateway_name"
      expr: gateway_name
      comment: "Name of the payment gateway — primary dimension for gateway-level performance and cost benchmarking."
    - name: "gateway_type"
      expr: gateway_type
      comment: "Type of gateway (e.g., hosted, integrated, direct) — used to segment gateway architecture and associated risk profiles."
    - name: "gateway_status"
      expr: gateway_status
      comment: "Current operational status of the gateway (e.g., active, inactive, maintenance) — used to monitor gateway availability."
    - name: "processor_name"
      expr: processor_name
      comment: "Underlying payment processor for the gateway — used to analyze processor-level cost and performance across gateway configurations."
    - name: "pci_dss_compliance_level"
      expr: pci_dss_compliance_level
      comment: "PCI DSS compliance level of the gateway — required for security governance and vendor risk management reporting."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating the gateway is currently active — used to filter to live gateways in operational dashboards."
    - name: "supports_tokenization"
      expr: supports_tokenization
      comment: "Boolean flag indicating the gateway supports payment tokenization — used to assess PCI scope reduction capabilities."
    - name: "supports_3ds"
      expr: supports_3ds
      comment: "Boolean flag indicating the gateway supports 3D Secure authentication — relevant for ecommerce fraud liability shift analysis."
    - name: "acquirer_bank"
      expr: acquirer_bank
      comment: "Acquiring bank associated with the gateway — used for acquirer-level relationship and cost management analysis."
  measures:
    - name: "avg_gateway_uptime_percentage"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average uptime percentage across payment gateways. Core SLA metric — below-threshold uptime directly impacts transaction approval rates and revenue."
    - name: "total_monthly_gateway_fee"
      expr: SUM(CAST(monthly_gateway_fee AS DOUBLE))
      comment: "Total monthly fixed fees paid to payment gateways. Measures the fixed cost component of payment infrastructure — used in total cost of acceptance analysis."
    - name: "total_chargeback_fee_per_gateway"
      expr: SUM(CAST(chargeback_fee AS DOUBLE))
      comment: "Total chargeback fees charged by each gateway. Enables gateway-level chargeback cost comparison to inform routing and contract negotiation decisions."
    - name: "avg_transaction_fee_percentage"
      expr: AVG(CAST(transaction_fee_percentage AS DOUBLE))
      comment: "Average variable transaction fee percentage across gateways. Key input for total cost of acceptance modeling and gateway routing optimization."
    - name: "total_transaction_fee_fixed"
      expr: SUM(CAST(transaction_fee_fixed AS DOUBLE))
      comment: "Total fixed per-transaction fees across gateways. Measures the fixed variable cost component of payment processing for cost benchmarking."
    - name: "active_gateway_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN gateway_id END)
      comment: "Count of currently active payment gateways. Measures payment infrastructure redundancy — low counts indicate single-point-of-failure risk."
$$;

CREATE OR REPLACE VIEW `grocery_ecm`.`_metrics`.`payment_transaction_tender`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tender-level transaction KPIs covering tender mix, fraud signals, surcharges, tip collection, and fuel reward redemptions at the line-item level. Used by payment operations and finance to analyze tender-type economics and fraud patterns."
  source: "`grocery_ecm`.`payment`.`transaction_tender`"
  dimensions:
    - name: "tender_status"
      expr: tender_status
      comment: "Status of the individual tender line (e.g., approved, declined, voided) — used to analyze tender-level approval rates."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand for the tender (e.g., Visa, Mastercard, Amex) — used to analyze tender mix and associated interchange costs."
    - name: "card_entry_method"
      expr: card_entry_method
      comment: "Method used to capture card data (e.g., chip, swipe, tap, keyed) — correlates with fraud risk and interchange qualification."
    - name: "mobile_wallet_type"
      expr: mobile_wallet_type
      comment: "Type of mobile wallet used (e.g., Apple Pay, Google Pay, Samsung Pay) — tracks digital wallet adoption and associated processing characteristics."
    - name: "ebt_benefit_type"
      expr: ebt_benefit_type
      comment: "Type of EBT benefit applied (e.g., SNAP, cash) — required for government program compliance and benefit utilization reporting."
    - name: "tender_currency_code"
      expr: tender_currency_code
      comment: "Currency of the tender — supports multi-currency tender analysis."
    - name: "cvv_verified_flag"
      expr: cvv_verified_flag
      comment: "Boolean flag indicating CVV was successfully verified — used to segment tender lines by fraud risk signal."
    - name: "pin_verified_flag"
      expr: pin_verified_flag
      comment: "Boolean flag indicating PIN was successfully verified — used to analyze PIN-authenticated vs. signature-based tender security."
    - name: "signature_captured_flag"
      expr: signature_captured_flag
      comment: "Boolean flag indicating a signature was captured — used to monitor signature threshold compliance and cardholder verification method mix."
    - name: "tender_date"
      expr: DATE_TRUNC('day', tender_timestamp)
      comment: "Calendar date of the tender event — primary time dimension for daily tender volume and mix trending."
    - name: "tender_month"
      expr: DATE_TRUNC('month', tender_timestamp)
      comment: "Calendar month of the tender event — supports monthly tender mix and cost analysis."
    - name: "settlement_date"
      expr: settlement_date
      comment: "Date the tender was included in a settlement batch — used to reconcile tender-level activity against settlement cash flows."
  measures:
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total amount tendered across all tender lines. Measures gross payment volume at the tender level — used to analyze tender mix and associated processing costs."
    - name: "total_surcharge_amount"
      expr: SUM(CAST(surcharge_amount AS DOUBLE))
      comment: "Total surcharges collected on card transactions. Measures surcharge revenue and compliance with card network surcharge rules."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total tip amounts collected at the tender level. Informs labor cost allocation for tipped service departments."
    - name: "total_change_due_amount"
      expr: SUM(CAST(change_due_amount AS DOUBLE))
      comment: "Total change disbursed on cash tender transactions. Measures cash handling volume and informs cash management and till balancing operations."
    - name: "total_fuel_reward_discount_amount"
      expr: SUM(CAST(fuel_reward_discount_amount AS DOUBLE))
      comment: "Total fuel reward discounts applied at the tender level. Measures the redemption cost of the fuel loyalty program at point of payment."
    - name: "total_fraud_score_sum"
      expr: SUM(CAST(fraud_score AS DOUBLE))
      comment: "Sum of fraud scores across tender lines. Used as a portfolio-level fraud risk signal — high aggregate scores indicate elevated fraud exposure requiring investigation."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score per tender line. Benchmarks the fraud risk profile of the tender portfolio — rising averages trigger fraud prevention program reviews."
    - name: "distinct_tender_count"
      expr: COUNT(DISTINCT transaction_tender_id)
      comment: "Total count of tender line items. Baseline volume KPI for tender-level throughput analysis and multi-tender transaction frequency."
    - name: "cvv_verified_tender_count"
      expr: COUNT(CASE WHEN cvv_verified_flag = TRUE THEN transaction_tender_id END)
      comment: "Count of tender lines with successful CVV verification. Numerator for CVV verification rate — measures card-not-present fraud control coverage."
    - name: "pin_verified_tender_count"
      expr: COUNT(CASE WHEN pin_verified_flag = TRUE THEN transaction_tender_id END)
      comment: "Count of tender lines with successful PIN verification. Tracks PIN authentication adoption rate — higher PIN rates correlate with lower fraud liability."
$$;