-- Metric views for domain: returns | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core RMA (Return Merchandise Authorization) performance metrics tracking return volume, financial exposure, fraud risk, and resolution efficiency. Primary steering KPI layer for the returns domain."
  source: "`retail_ecm`.`returns`.`rma`"
  dimensions:
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g., in-store, online, vendor) used to segment return volume and cost by channel."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (e.g., mail-in, drop-off, pickup) for logistics and cost analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return, enabling root-cause analysis of return drivers."
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., open, closed, pending) for pipeline and backlog monitoring."
    - name: "refund_method"
      expr: refund_method
      comment: "Method by which the refund was issued (e.g., original payment, store credit, gift card) for financial liability analysis."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Outcome code assigned to the returned item (e.g., restock, liquidate, destroy) for recovery planning."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the physical inspection of the returned item, used to track inspection throughput and SLA compliance."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the RMA for triage and SLA management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which RMA financial values are denominated, for multi-currency reporting."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the RMA was identified as fraudulent, enabling fraud cohort analysis."
    - name: "authorization_date"
      expr: DATE_TRUNC('day', authorization_date)
      comment: "Date the RMA was authorized, used for daily/weekly trend analysis of return intake."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month the RMA was authorized, used for monthly return volume and cost trending."
    - name: "closed_date_month"
      expr: DATE_TRUNC('month', closed_date)
      comment: "Month the RMA was closed, used to measure resolution cycle time and throughput."
    - name: "return_shipping_paid_by"
      expr: return_shipping_paid_by
      comment: "Party responsible for return shipping cost (retailer vs. customer), driving cost allocation decisions."
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the RMA record, used for data quality and channel attribution."
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs initiated. Primary volume KPI for the returns domain — tracks return intake rate and operational load."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value refunded across all RMAs. Direct measure of financial liability from returns — critical for P&L impact assessment."
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Sum of expected recovery value across all RMAs. Used to forecast recovery revenue and assess gap between expected and actual recovery."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping across all RMAs. Key operational cost driver — informs decisions on return shipping policy and carrier negotiations."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected from customers. Measures revenue offset against return processing costs."
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of cash refunds. Tracks liability on the balance sheet and customer retention via credit issuance."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all RMAs. Monitors overall fraud exposure in the returns portfolio — triggers investigation when trending upward."
    - name: "fraudulent_rma_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of RMAs flagged as fraudulent. Directly measures fraud volume — used to size fraud prevention investment and track program effectiveness."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund value per RMA. Benchmarks refund generosity and detects anomalies in refund amounts that may indicate policy abuse."
    - name: "store_credit_rma_count"
      expr: COUNT(CASE WHEN refund_method = 'store_credit' THEN 1 END)
      comment: "Number of RMAs resolved via store credit. Measures store credit adoption rate as a refund deflection strategy."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial refund performance metrics covering refund volume, total payout, fraud exposure, tax and shipping components, and settlement timeliness. Drives finance and operations decisions on refund liability and fraud controls."
  source: "`retail_ecm`.`returns`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current processing status of the refund (e.g., pending, completed, failed) for pipeline monitoring."
    - name: "refund_type"
      expr: refund_type
      comment: "Classification of the refund (e.g., full, partial, exchange) for financial reporting segmentation."
    - name: "refund_method"
      expr: refund_method
      comment: "Payment method used for the refund (e.g., original card, store credit, check) for treasury and liability analysis."
    - name: "channel"
      expr: channel
      comment: "Sales/return channel (e.g., in-store, online) where the refund was initiated, for channel-level P&L attribution."
    - name: "reason_code"
      expr: reason_code
      comment: "Standardized reason code for the refund, enabling root-cause analysis of refund drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund transaction for multi-currency financial reporting."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the refund was identified as fraudulent, enabling fraud cohort analysis."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor used to execute the refund, for processor performance and cost benchmarking."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the refund was initiated, for monthly refund volume and liability trending."
    - name: "actual_settlement_date_month"
      expr: DATE_TRUNC('month', actual_settlement_date)
      comment: "Month the refund was actually settled, for cash flow and settlement lag analysis."
    - name: "processor_response_code"
      expr: processor_response_code
      comment: "Response code from the payment processor, used to diagnose refund failures and processor issues."
  measures:
    - name: "total_refund_count"
      expr: COUNT(1)
      comment: "Total number of refund transactions processed. Primary volume KPI for refund operations — tracks refund intake and processing load."
    - name: "total_refund_payout"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total monetary value paid out in refunds. Most critical financial KPI for the returns domain — directly impacts gross margin and cash flow."
    - name: "total_merchandise_refunded"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise value component of refunds. Isolates product cost from shipping and tax in refund liability analysis."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded. Required for tax compliance reporting and reconciliation with tax authorities."
    - name: "total_shipping_refunded"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping cost refunded to customers. Measures shipping cost exposure from returns — informs return shipping policy decisions."
    - name: "total_restocking_fee_revenue"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected, offsetting refund costs. Measures effectiveness of restocking fee policy in recovering return processing costs."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total value of adjustments applied to refunds. Tracks discretionary adjustments that may indicate policy exceptions or fraud."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of refunds flagged as fraudulent. Measures fraud volume in the refund pipeline — key input for fraud prevention investment decisions."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all refund transactions. Monitors portfolio-level fraud exposure — triggers controls review when trending upward."
    - name: "avg_total_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund value per transaction. Benchmarks refund generosity and detects anomalous refund amounts indicative of policy abuse."
    - name: "failed_refund_count"
      expr: COUNT(CASE WHEN refund_status = 'failed' THEN 1 END)
      comment: "Number of refunds that failed processing. Measures operational failure rate — high values indicate processor or system issues requiring immediate intervention."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return request intake and approval funnel metrics. Tracks request volume, fraud risk, approval rates, and resolution preferences to optimize the customer return experience and control fraud exposure."
  source: "`retail_ecm`.`returns`.`return_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the return request (e.g., pending, approved, denied) for funnel and conversion analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return request, enabling root-cause analysis of return drivers."
    - name: "return_method"
      expr: return_method
      comment: "Preferred return method selected by the customer (e.g., mail-in, in-store drop-off) for logistics planning."
    - name: "preferred_resolution_type"
      expr: preferred_resolution_type
      comment: "Customer's preferred resolution (e.g., refund, exchange, store credit) for demand planning of resolution types."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request for SLA and triage management."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating whether the return request was flagged for fraud review, enabling fraud cohort analysis."
    - name: "is_within_return_window"
      expr: is_within_return_window
      comment: "Indicates whether the request was made within the eligible return window — key policy compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated refund amount for multi-currency financial reporting."
    - name: "denial_reason_code"
      expr: denial_reason_code
      comment: "Reason code for denied return requests, used to analyze denial patterns and policy effectiveness."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the return request was submitted, for monthly intake volume trending."
    - name: "source_system_code"
      expr: source_system_code
      comment: "Source system that originated the return request, for channel attribution and data quality monitoring."
    - name: "pickup_requested_flag"
      expr: pickup_requested_flag
      comment: "Indicates whether the customer requested a pickup for the return, driving logistics capacity planning."
  measures:
    - name: "total_return_requests"
      expr: COUNT(1)
      comment: "Total number of return requests submitted. Primary intake volume KPI — tracks demand on the returns processing pipeline."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'approved' THEN 1 END)
      comment: "Number of return requests approved. Measures approval throughput and policy acceptance rate."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN request_status = 'denied' THEN 1 END)
      comment: "Number of return requests denied. Tracks denial volume — high denial rates may indicate policy friction or customer experience issues."
    - name: "fraud_flagged_request_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of return requests flagged for fraud. Measures fraud exposure at the intake stage — key input for fraud prevention investment."
    - name: "out_of_window_request_count"
      expr: COUNT(CASE WHEN is_within_return_window = FALSE THEN 1 END)
      comment: "Number of return requests submitted outside the eligible return window. Measures policy exception volume and customer compliance with return windows."
    - name: "total_estimated_refund_exposure"
      expr: SUM(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Total estimated refund value across all open return requests. Measures forward-looking financial liability from the return request pipeline."
    - name: "avg_estimated_refund_amount"
      expr: AVG(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Average estimated refund value per return request. Benchmarks refund size and detects anomalous high-value requests for review."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across all return requests. Monitors portfolio-level fraud risk at the intake stage — triggers controls review when trending upward."
    - name: "pickup_requested_count"
      expr: COUNT(CASE WHEN pickup_requested_flag = TRUE THEN 1 END)
      comment: "Number of return requests where the customer requested a pickup. Drives logistics capacity planning for return pickup operations."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returned item disposition and recovery value metrics. Tracks how returned inventory is resolved (restock, liquidate, destroy) and the financial recovery achieved versus estimated, driving merchandise recovery optimization."
  source: "`retail_ecm`.`returns`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition applied to the returned item (e.g., restock, liquidate, destroy, donate) — primary dimension for recovery strategy analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition process (e.g., pending, completed) for pipeline and throughput monitoring."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the returned item (e.g., A, B, C) — key driver of recovery value and disposition routing decisions."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code associated with the disposition, enabling root-cause analysis of return and disposition patterns."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code assigned during inspection, used to identify product quality issues and drive vendor accountability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which recovery values are denominated for multi-currency financial reporting."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Indicates whether the returned item is classified as hazardous material, driving compliance and disposal cost analysis."
    - name: "restocking_fee_applied"
      expr: restocking_fee_applied
      comment: "Indicates whether a restocking fee was applied to this disposition, for fee policy effectiveness analysis."
    - name: "completion_date_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the disposition was completed, for monthly recovery throughput and value trending."
    - name: "decision_date_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month the disposition decision was made, for decision cycle time and backlog analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the disposed quantity, for volume normalization across product types."
  measures:
    - name: "total_disposition_count"
      expr: COUNT(1)
      comment: "Total number of disposition records processed. Measures returned item processing throughput — key operational volume KPI."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE))
      comment: "Total actual monetary value recovered from disposed items. Primary financial recovery KPI — directly measures the revenue recaptured from returns."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value at time of disposition decision. Used to measure forecast accuracy and identify recovery shortfalls."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected across all dispositions. Measures fee revenue contribution to offsetting return processing costs."
    - name: "avg_actual_recovery_value"
      expr: AVG(CAST(actual_recovery_value AS DOUBLE))
      comment: "Average actual recovery value per disposed item. Benchmarks recovery efficiency and identifies condition grades or disposition types with poor recovery rates."
    - name: "avg_estimated_recovery_value"
      expr: AVG(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Average estimated recovery value per disposed item. Used alongside avg_actual_recovery_value to measure estimation accuracy and recovery gap."
    - name: "hazmat_disposition_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of dispositions involving hazardous materials. Tracks compliance exposure and disposal cost drivers for hazmat returns."
    - name: "restocking_fee_applied_count"
      expr: COUNT(CASE WHEN restocking_fee_applied = TRUE THEN 1 END)
      comment: "Number of dispositions where a restocking fee was applied. Measures restocking fee policy application rate."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_restock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returned inventory restock performance metrics. Tracks restocked quantity, value recovery, inspection compliance, and inventory adjustment posting to optimize reverse logistics and inventory recovery efficiency."
  source: "`retail_ecm`.`returns`.`restock_event`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Status of the restocked inventory (e.g., available, quarantine, damaged) for inventory quality and availability analysis."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the restocked item — drives pricing, placement, and recovery value decisions."
    - name: "restock_location_type"
      expr: restock_location_type
      comment: "Type of location where the item was restocked (e.g., store floor, warehouse, clearance) for inventory placement analysis."
    - name: "restock_reason_code"
      expr: restock_reason_code
      comment: "Reason code for the restock event, enabling root-cause analysis of restock patterns."
    - name: "inspection_completed"
      expr: inspection_completed
      comment: "Indicates whether inspection was completed before restocking — key quality control compliance dimension."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Indicates whether inspection was required for this restock event, for SLA and compliance monitoring."
    - name: "inventory_adjustment_posted"
      expr: inventory_adjustment_posted
      comment: "Indicates whether the inventory adjustment was posted to the ledger — critical for financial reconciliation monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which restock values are denominated for multi-currency financial reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for restocked quantity, for volume normalization across product types."
    - name: "restock_month"
      expr: DATE_TRUNC('month', restock_timestamp)
      comment: "Month the restock event occurred, for monthly restock throughput and value trending."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the restock event record, for data quality and channel attribution."
  measures:
    - name: "total_restock_events"
      expr: COUNT(1)
      comment: "Total number of restock events. Measures reverse logistics throughput — tracks how many returned items are successfully returned to sellable inventory."
    - name: "total_quantity_restocked"
      expr: SUM(CAST(quantity_restocked AS DOUBLE))
      comment: "Total units restocked to inventory from returns. Primary volume KPI for reverse logistics — measures inventory recovery throughput."
    - name: "total_restocked_value"
      expr: SUM(CAST(restocked_value AS DOUBLE))
      comment: "Total monetary value of inventory restocked from returns. Measures the financial value recovered through restocking — key input for return ROI analysis."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of restocked items. Used alongside restocked_value to compute recovery rate and markdown impact from returns."
    - name: "avg_restocked_value_per_unit"
      expr: AVG(CAST(restocked_value AS DOUBLE))
      comment: "Average restocked value per restock event. Benchmarks recovery efficiency and identifies condition grades or location types with poor value recovery."
    - name: "inspection_required_not_completed_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE AND inspection_completed = FALSE THEN 1 END)
      comment: "Number of restock events where inspection was required but not completed. Measures inspection compliance gap — a quality and liability risk indicator."
    - name: "adjustment_not_posted_count"
      expr: COUNT(CASE WHEN inventory_adjustment_posted = FALSE THEN 1 END)
      comment: "Number of restock events where the inventory adjustment was not posted to the ledger. Measures financial reconciliation risk — unposted adjustments create inventory and accounting discrepancies."
    - name: "avg_original_cost"
      expr: AVG(CAST(original_cost AS DOUBLE))
      comment: "Average original cost per restocked item. Used to benchmark the cost basis of returned inventory being recovered."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_return_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical return receipt and receiving metrics. Tracks received quantity versus authorized quantity, discrepancy rates, inspection compliance, and refund trigger rates to manage receiving accuracy and downstream refund initiation."
  source: "`retail_ecm`.`returns`.`return_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the return receipt (e.g., received, pending inspection, closed) for receiving pipeline monitoring."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (e.g., mail-in, in-store) for channel-level receiving analysis."
    - name: "receiving_location_type"
      expr: receiving_location_type
      comment: "Type of location where the return was received (e.g., store, DC, third-party) for network-level receiving analysis."
    - name: "condition_assessment"
      expr: condition_assessment
      comment: "Physical condition assessment of the received return, driving disposition routing and recovery value estimation."
    - name: "packaging_condition"
      expr: packaging_condition
      comment: "Condition of the packaging upon receipt, used for quality analysis and vendor accountability."
    - name: "disposition_recommendation"
      expr: disposition_recommendation
      comment: "Recommended disposition for the received item (e.g., restock, liquidate, destroy) for downstream processing planning."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Indicates whether a quantity or condition discrepancy was identified at receipt — key quality control dimension."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy identified (e.g., quantity short, wrong item, damaged) for root-cause analysis."
    - name: "refund_triggered_flag"
      expr: refund_triggered_flag
      comment: "Indicates whether receipt of this return triggered a refund, for refund initiation rate analysis."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Indicates whether the received item is eligible for restocking, for inventory recovery planning."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Indicates whether inspection is required for this receipt, for inspection workload planning."
    - name: "recovery_value_currency_code"
      expr: recovery_value_currency_code
      comment: "Currency of the estimated recovery value for multi-currency financial reporting."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month the return was received, for monthly receiving volume and discrepancy trending."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of return receipts processed. Primary receiving volume KPI — measures return intake throughput at the physical receiving stage."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total units physically received from returns. Measures actual return volume at the receiving dock — key input for inventory and refund processing."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total units authorized for return. Used alongside total_received_quantity to measure receiving compliance and identify over/under-shipments."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value of received returns. Measures forward-looking financial recovery from the receiving pipeline."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with identified discrepancies. Measures receiving accuracy — high discrepancy rates indicate carrier, customer, or process issues requiring intervention."
    - name: "refund_triggered_receipt_count"
      expr: COUNT(CASE WHEN refund_triggered_flag = TRUE THEN 1 END)
      comment: "Number of receipts that triggered a refund. Measures refund initiation rate from the receiving stage — key input for refund liability forecasting."
    - name: "restocking_eligible_receipt_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of received returns eligible for restocking. Measures inventory recovery opportunity from the return pipeline."
    - name: "avg_estimated_recovery_value"
      expr: AVG(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Average estimated recovery value per receipt. Benchmarks recovery potential per return and identifies high-value return cohorts."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store credit issuance, redemption, and liability metrics. Tracks issued amounts, remaining balances, expiration risk, and escheatment exposure to manage store credit as a balance sheet liability and customer retention instrument."
  source: "`retail_ecm`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit (e.g., active, redeemed, expired, voided) for liability and lifecycle analysis."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit (e.g., return credit, promotional credit, goodwill) for liability segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the store credit for multi-currency balance sheet reporting."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Indicates whether the store credit is eligible for escheatment (unclaimed property laws) — critical for legal compliance monitoring."
    - name: "breakage_estimate_applied_flag"
      expr: breakage_estimate_applied_flag
      comment: "Indicates whether a breakage estimate has been applied to this credit — used for revenue recognition and liability reduction analysis."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Indicates whether the store credit is transferable between customers, for fraud and policy analysis."
    - name: "combinable_with_promotions_flag"
      expr: combinable_with_promotions_flag
      comment: "Indicates whether the credit can be combined with promotions, for promotional liability analysis."
    - name: "redemption_channel_restriction"
      expr: redemption_channel_restriction
      comment: "Channel restriction on redemption (e.g., in-store only, online only) for channel-level liability analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the store credit was issued, for monthly issuance volume and liability trending."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the store credit expires, for expiration risk and breakage forecasting."
    - name: "void_reason_code"
      expr: void_reason_code
      comment: "Reason code for voided store credits, for fraud and operational analysis."
  measures:
    - name: "total_store_credits_issued"
      expr: COUNT(1)
      comment: "Total number of store credits issued. Primary volume KPI for store credit program — tracks issuance rate and program scale."
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total monetary value of store credits issued. Measures total store credit liability created — critical balance sheet KPI for finance."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total outstanding balance across all active store credits. Measures current store credit liability on the balance sheet — key input for financial reporting."
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit amount issued per transaction. Benchmarks credit generosity and detects anomalous high-value issuances."
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per store credit. Measures redemption depth — low averages indicate high redemption rates (positive for customer engagement)."
    - name: "escheatment_eligible_count"
      expr: COUNT(CASE WHEN escheatment_eligible_flag = TRUE THEN 1 END)
      comment: "Number of store credits eligible for escheatment. Measures legal compliance exposure — unclaimed credits subject to state unclaimed property laws."
    - name: "voided_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'voided' THEN 1 END)
      comment: "Number of store credits that have been voided. Tracks void rate — high void rates may indicate fraud, system errors, or policy abuse."
    - name: "expired_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'expired' THEN 1 END)
      comment: "Number of store credits that have expired without full redemption. Measures breakage volume — key input for breakage revenue recognition."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RMA line-item financial and operational metrics. Tracks returned SKU-level cost, retail value, refund amounts, vendor credits, and liquidation proceeds to enable product-level return profitability and vendor accountability analysis."
  source: "`retail_ecm`.`returns`.`rma_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the RMA line item (e.g., pending, received, closed) for line-level pipeline monitoring."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return at the line item level, enabling SKU-level root-cause analysis of return drivers."
    - name: "condition_code"
      expr: condition_code
      comment: "Physical condition code of the returned item at the line level, driving disposition and recovery value decisions."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome assigned to the returned line item (e.g., restock, liquidate, destroy) for recovery strategy analysis."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Indicates whether the returned line item is eligible for restocking, for inventory recovery planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item financial values for multi-currency reporting."
    - name: "inspection_date_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month the line item was inspected, for inspection throughput trending."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the RMA line was created, for monthly return line volume trending."
  measures:
    - name: "total_rma_lines"
      expr: COUNT(1)
      comment: "Total number of RMA line items. Measures return line volume — more granular than RMA count, reflecting total SKU-level return activity."
    - name: "total_extended_retail_amount"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned line items. Measures gross merchandise value at risk from returns — key input for return rate and margin impact analysis."
    - name: "total_extended_cost_amount"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned line items. Measures the cost basis of returned inventory — used to compute return cost rate and gross margin impact."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued at the line item level. Measures line-level refund liability — enables SKU and category-level refund analysis."
    - name: "total_vendor_credit_amount"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit received for returned line items. Measures vendor accountability and cost recovery from supplier returns — key for vendor negotiation."
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total proceeds from liquidation of returned line items. Measures liquidation recovery revenue — key input for disposition strategy optimization."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at the line item level. Measures fee revenue contribution to offsetting return processing costs at the SKU level."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of returned items. Benchmarks the cost profile of returned inventory and identifies high-cost return categories."
    - name: "restocking_eligible_line_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of RMA lines eligible for restocking. Measures inventory recovery opportunity at the line level — key input for reverse logistics planning."
$$;