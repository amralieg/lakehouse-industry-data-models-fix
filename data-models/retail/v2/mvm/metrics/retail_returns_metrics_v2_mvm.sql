-- Metric views for domain: returns | Business: Retail | Version: 2 | Generated on: 2026-06-24 00:42:49

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for return request volume, approval/denial rates, fraud risk, and refund exposure. Enables leadership to monitor return demand, channel mix, and financial liability from pending returns."
  source: "`vibe_retail_v1`.`returns`.`return_request`"
  dimensions:
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the return was initiated (e.g., online, in-store, call center). Used to analyze return volume and fraud risk by channel."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the return request (e.g., pending, approved, denied). Drives operational triage and SLA monitoring."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return (e.g., defective, wrong item, changed mind). Key driver of root-cause analysis and supplier accountability."
    - name: "preferred_resolution_type"
      expr: preferred_resolution_type
      comment: "Customer-preferred resolution (e.g., refund, exchange, store credit). Informs fulfillment planning and customer satisfaction strategy."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (e.g., mail-in, drop-off, in-store). Drives logistics cost analysis."
    - name: "is_within_return_window"
      expr: is_within_return_window
      comment: "Flag indicating whether the return was requested within the policy return window. Critical for policy compliance and exception tracking."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Boolean flag indicating suspected fraudulent return request. Used to monitor and contain return fraud exposure."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the return request. Used for SLA management and escalation routing."
    - name: "request_date"
      expr: DATE_TRUNC('day', request_timestamp)
      comment: "Date the return request was submitted, truncated to day. Used for trend analysis and SLA compliance tracking."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the return request was submitted. Used for monthly return volume trending and seasonality analysis."
    - name: "original_purchase_date"
      expr: original_purchase_date
      comment: "Date of the original purchase associated with the return. Used to compute days-to-return and policy window compliance."
  measures:
    - name: "total_return_requests"
      expr: COUNT(1)
      comment: "Total number of return requests submitted. Baseline volume KPI for return demand monitoring and capacity planning."
    - name: "approved_return_requests"
      expr: COUNT(CASE WHEN request_status = 'approved' THEN 1 END)
      comment: "Number of return requests that were approved. Used to compute approval rate and assess policy leniency."
    - name: "denied_return_requests"
      expr: COUNT(CASE WHEN request_status = 'denied' THEN 1 END)
      comment: "Number of return requests that were denied. Tracks policy enforcement effectiveness and customer friction points."
    - name: "fraudulent_return_requests"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of return requests flagged as fraudulent. Directly informs loss prevention strategy and fraud containment investment."
    - name: "out_of_window_return_requests"
      expr: COUNT(CASE WHEN is_within_return_window = FALSE THEN 1 END)
      comment: "Number of return requests submitted outside the policy return window. Measures policy exception volume and associate override frequency."
    - name: "total_estimated_refund_exposure"
      expr: SUM(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Total estimated refund liability from all open return requests. Critical financial exposure metric for treasury and finance planning."
    - name: "avg_estimated_refund_amount"
      expr: AVG(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Average estimated refund amount per return request. Benchmarks refund size and identifies high-value return segments."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score across return requests. Monitors overall fraud risk exposure and triggers investigation thresholds."
    - name: "pickup_requested_count"
      expr: COUNT(CASE WHEN pickup_requested_flag = TRUE THEN 1 END)
      comment: "Number of return requests where customer requested pickup. Drives reverse logistics capacity planning and cost forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core RMA (Return Merchandise Authorization) performance metrics covering authorization volume, financial recovery, fraud, refund processing, and return channel mix. Primary operational and financial steering view for the returns domain."
  source: "`vibe_retail_v1`.`returns`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., open, closed, pending inspection). Used for pipeline management and throughput analysis."
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g., online, in-store, call center). Drives channel-level return cost and volume analysis."
    - name: "return_method"
      expr: return_method
      comment: "Physical method used to return merchandise (e.g., mail, drop-off, in-store). Informs reverse logistics cost allocation."
    - name: "return_type"
      expr: return_type
      comment: "Classification of the return type (e.g., customer return, vendor return, warranty). Enables segmented financial and operational reporting."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return. Root-cause analysis driver for product quality, fulfillment accuracy, and supplier accountability."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., original payment, store credit, check). Informs payment operations and customer preference analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of the merchandise inspection (e.g., pending, passed, failed). Tracks inspection throughput and quality gate performance."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Boolean flag indicating the RMA was identified as fraudulent. Used for fraud loss quantification and prevention program evaluation."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the RMA. Used for SLA management and escalation routing."
    - name: "return_shipping_paid_by"
      expr: return_shipping_paid_by
      comment: "Party responsible for return shipping cost (e.g., customer, retailer, vendor). Drives shipping cost allocation and policy benchmarking."
    - name: "authorization_month"
      expr: DATE_TRUNC('month', authorization_timestamp)
      comment: "Month the RMA was authorized. Used for monthly return authorization volume trending."
    - name: "authorization_date"
      expr: authorization_date
      comment: "Date the RMA was authorized. Used for daily operational monitoring and SLA compliance."
    - name: "received_date"
      expr: received_date
      comment: "Date the returned merchandise was physically received. Used to compute return transit time and receiving throughput."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which RMA financial amounts are denominated. Required for multi-currency financial reporting."
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of RMAs created. Baseline return volume KPI for operational capacity and trend monitoring."
    - name: "fraudulent_rmas"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Number of RMAs identified as fraudulent. Quantifies fraud exposure and informs loss prevention investment decisions."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all RMAs. Primary financial liability metric for returns — directly impacts P&L."
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Total expected recovery value from returned merchandise. Used to assess merchandise recovery efficiency vs. actual refund cost."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected across RMAs. Measures fee revenue that offsets return processing costs."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping across all RMAs. Key reverse logistics cost driver for carrier contract negotiations."
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of cash refunds. Tracks store credit liability and its impact on future revenue retention."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA. Benchmarks refund size and identifies high-value return segments requiring policy review."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across RMAs. Monitors portfolio-level fraud risk and calibrates fraud detection model thresholds."
    - name: "closed_rmas"
      expr: COUNT(CASE WHEN rma_status = 'closed' THEN 1 END)
      comment: "Number of RMAs that have been fully closed. Measures return resolution throughput and operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level RMA metrics providing SKU-level return financial analysis including refund amounts, cost recovery, restocking fees, liquidation proceeds, and vendor credit. Enables product-level return profitability and supplier accountability analysis."
  source: "`vibe_retail_v1`.`returns`.`rma_line`"
  dimensions:
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return at the line level. Enables SKU-level root-cause analysis for product quality and fulfillment issues."
    - name: "condition_code"
      expr: condition_code
      comment: "Condition of the returned item at the line level (e.g., new, damaged, used). Drives disposition routing and recovery value estimation."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition decision for the returned line item (e.g., restock, liquidate, destroy). Directly impacts recovery value and inventory planning."
    - name: "line_status"
      expr: line_status
      comment: "Current processing status of the RMA line (e.g., pending, received, processed). Used for pipeline and throughput monitoring."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Boolean flag indicating whether the returned item is eligible for restocking. Drives inventory recovery rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which line-level financial amounts are denominated. Required for multi-currency financial reporting."
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date the returned line item was inspected. Used for inspection throughput and SLA compliance analysis."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the RMA line was created. Used for monthly return line volume and financial trending."
    - name: "sku"
      expr: sku
      comment: "SKU identifier of the returned item. Enables product-level return rate and financial impact analysis."
  measures:
    - name: "total_rma_lines"
      expr: COUNT(1)
      comment: "Total number of RMA line items. Measures return volume at the SKU level for product-level return rate analysis."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued at the line level. SKU-level financial liability metric for product return cost analysis."
    - name: "total_extended_retail_amount"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned merchandise at the line level. Used to compute return rate as a percentage of sales and assess revenue impact."
    - name: "total_extended_cost_amount"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned merchandise. Used to compute gross margin impact of returns and cost recovery efficiency."
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total proceeds from liquidation of returned merchandise. Measures secondary recovery revenue and liquidation program effectiveness."
    - name: "total_vendor_credit_amount"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit received for returned merchandise. Tracks supplier accountability and vendor return program financial performance."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at the line level. Measures fee revenue contribution to offsetting return processing costs."
    - name: "total_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total unit cost of all returned items. Used in conjunction with recovery amounts to compute net return cost to the business."
    - name: "avg_refund_amount_per_line"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA line item. Benchmarks per-unit refund cost and identifies high-value return SKUs."
    - name: "restocking_eligible_lines"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of returned line items eligible for restocking. Measures inventory recovery potential and restocking program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for refund processing covering total refund liability, tax and shipping components, fraud exposure, settlement timing, and refund method mix. Core P&L and cash flow steering view for the returns domain."
  source: "`vibe_retail_v1`.`returns`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g., pending, processed, failed). Used for refund pipeline management and settlement monitoring."
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund issued (e.g., full, partial, exchange differential). Enables segmented financial analysis of refund liability."
    - name: "method"
      expr: method
      comment: "Refund payment method (e.g., original payment, store credit, check). Drives payment operations planning and customer preference analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the refund was processed (e.g., online, in-store). Used for channel-level refund cost and volume analysis."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Boolean flag indicating the refund was identified as fraudulent. Used to quantify fraud-driven financial losses."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which refund amounts are denominated. Required for multi-currency financial reporting."
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor used to execute the refund. Used for processor performance benchmarking and fee analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund. Enables root-cause analysis of refund drivers and policy effectiveness evaluation."
    - name: "actual_settlement_date"
      expr: actual_settlement_date
      comment: "Date the refund was actually settled. Used to measure settlement cycle time and identify processing delays."
    - name: "processed_month"
      expr: DATE_TRUNC('month', processed_timestamp)
      comment: "Month the refund was processed. Used for monthly refund liability trending and cash flow forecasting."
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refunds processed. Baseline volume KPI for refund operations monitoring."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total refund amount paid out across all refunds. Primary financial liability metric — directly impacts cash flow and P&L."
    - name: "total_merchandise_refund_amount"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise component of refunds. Isolates product return cost from shipping and tax components for gross margin analysis."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded. Required for tax compliance reporting and accurate net refund cost calculation."
    - name: "total_shipping_refunded"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping amount refunded to customers. Measures shipping cost absorption from returns and informs free-returns policy cost."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected, offsetting refund costs. Measures fee program revenue contribution."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total price adjustment amounts applied to refunds. Tracks promotional and price-match adjustments impacting refund liability."
    - name: "fraudulent_refund_amount"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN CAST(total_refund_amount AS DOUBLE) ELSE 0 END)
      comment: "Total refund amount associated with fraudulent transactions. Quantifies direct financial loss from return fraud — key loss prevention KPI."
    - name: "avg_total_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction. Benchmarks refund size and identifies anomalous high-value refund patterns."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all refunds. Monitors portfolio-level fraud risk and calibrates detection model performance."
    - name: "distinct_customers_refunded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who received refunds. Measures refund program reach and identifies repeat-refund customer segments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandise disposition metrics tracking recovery value realization, restocking fee collection, and disposition type mix for returned goods. Enables leadership to optimize secondary recovery programs and assess disposition efficiency."
  source: "`vibe_retail_v1`.`returns`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition applied to returned merchandise (e.g., restock, liquidate, destroy, donate). Primary driver of recovery value analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition process (e.g., pending, completed, cancelled). Used for pipeline and throughput monitoring."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade assigned to the returned item (e.g., A, B, C). Drives disposition routing decisions and recovery value benchmarking."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code associated with the disposition. Used for root-cause analysis of disposition drivers."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect code assigned during inspection. Enables product quality analysis and supplier accountability tracking."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Boolean flag indicating the item is classified as hazardous material. Required for regulatory compliance and specialized disposal cost tracking."
    - name: "restocking_fee_applied"
      expr: restocking_fee_applied
      comment: "Boolean flag indicating a restocking fee was applied. Used to measure fee program compliance and revenue contribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which disposition financial amounts are denominated. Required for multi-currency financial reporting."
    - name: "decision_date"
      expr: decision_date
      comment: "Date the disposition decision was made. Used for disposition cycle time analysis and SLA compliance."
    - name: "completion_month"
      expr: DATE_TRUNC('month', completion_date)
      comment: "Month the disposition was completed. Used for monthly disposition throughput and recovery value trending."
  measures:
    - name: "total_dispositions"
      expr: COUNT(1)
      comment: "Total number of disposition records processed. Baseline throughput KPI for the disposition pipeline."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE))
      comment: "Total actual recovery value realized from disposed merchandise. Primary financial recovery KPI — measures secondary market and liquidation program effectiveness."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value at time of disposition decision. Used to benchmark actual vs. estimated recovery and assess valuation accuracy."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected during disposition. Measures fee revenue contribution to offsetting return processing and disposition costs."
    - name: "avg_actual_recovery_value"
      expr: AVG(CAST(actual_recovery_value AS DOUBLE))
      comment: "Average actual recovery value per disposition. Benchmarks per-unit recovery efficiency across disposition types and condition grades."
    - name: "avg_estimated_recovery_value"
      expr: AVG(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Average estimated recovery value per disposition. Used alongside actual recovery average to compute estimation accuracy."
    - name: "hazmat_dispositions"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of hazardous material dispositions. Required for regulatory compliance reporting and specialized disposal cost budgeting."
    - name: "completed_dispositions"
      expr: COUNT(CASE WHEN disposition_status = 'completed' THEN 1 END)
      comment: "Number of dispositions that have been fully completed. Measures disposition throughput and operational efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receiving and inspection metrics for returned merchandise covering receipt volume, quantity discrepancies, inspection completion, refund trigger rates, and recovery value at point of receipt. Enables operations leadership to monitor receiving throughput and quality gate performance."
  source: "`vibe_retail_v1`.`returns`.`return_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the return receipt (e.g., received, inspected, processed). Used for receiving pipeline monitoring."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the merchandise (e.g., mail, in-store, drop-off). Drives reverse logistics cost and volume analysis."
    - name: "receiving_location_type"
      expr: receiving_location_type
      comment: "Type of location where the return was received (e.g., store, DC, third-party). Used for receiving network capacity planning."
    - name: "condition_assessment"
      expr: condition_assessment
      comment: "Condition assessment of the returned merchandise at receipt. Drives disposition routing and recovery value estimation."
    - name: "packaging_condition"
      expr: packaging_condition
      comment: "Condition of the packaging at receipt. Used for product quality analysis and supplier packaging standards evaluation."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Boolean flag indicating a quantity or condition discrepancy was found at receipt. Tracks receiving accuracy and fraud indicators."
    - name: "discrepancy_type"
      expr: discrepancy_type
      comment: "Type of discrepancy identified at receipt (e.g., quantity short, wrong item, damaged). Enables root-cause analysis of receiving exceptions."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Boolean flag indicating inspection is required for this receipt. Used for inspection workload planning and SLA management."
    - name: "refund_triggered_flag"
      expr: refund_triggered_flag
      comment: "Boolean flag indicating a refund was triggered upon receipt. Measures auto-refund rate and its financial impact."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Boolean flag indicating the received return is eligible for restocking. Measures inventory recovery rate at point of receipt."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month the return was received. Used for monthly receiving volume trending and capacity planning."
    - name: "recovery_value_currency_code"
      expr: recovery_value_currency_code
      comment: "Currency of the estimated recovery value. Required for multi-currency financial reporting."
  measures:
    - name: "total_return_receipts"
      expr: COUNT(1)
      comment: "Total number of return receipts processed. Baseline receiving throughput KPI for operations monitoring."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of units received across all return receipts. Measures physical return volume for inventory and capacity planning."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total quantity authorized for return. Used alongside received quantity to compute receipt compliance rate."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value of received returns. Measures potential financial recovery from the receiving pipeline."
    - name: "avg_estimated_recovery_value"
      expr: AVG(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Average estimated recovery value per return receipt. Benchmarks per-receipt recovery potential across receiving locations and return methods."
    - name: "discrepancy_receipts"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of return receipts with identified discrepancies. Measures receiving accuracy and fraud indicator rate — key quality and loss prevention KPI."
    - name: "refund_triggered_receipts"
      expr: COUNT(CASE WHEN refund_triggered_flag = TRUE THEN 1 END)
      comment: "Number of receipts that automatically triggered a refund. Measures auto-refund rate and its contribution to total refund liability."
    - name: "restocking_eligible_receipts"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of received returns eligible for restocking. Measures inventory recovery rate and restocking program effectiveness."
    - name: "inspection_required_receipts"
      expr: COUNT(CASE WHEN inspection_required_flag = TRUE THEN 1 END)
      comment: "Number of receipts requiring inspection. Drives inspection workload forecasting and SLA capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_exchange_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exchange order metrics tracking exchange volume, refund differentials, fulfillment channel mix, and expedited shipping usage. Enables leadership to monitor exchange program performance, cost, and customer experience outcomes."
  source: "`vibe_retail_v1`.`returns`.`exchange_order`"
  dimensions:
    - name: "exchange_order_status"
      expr: exchange_order_status
      comment: "Current status of the exchange order (e.g., initiated, approved, shipped, delivered, cancelled). Used for exchange pipeline monitoring."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (e.g., same-item, cross-SKU, upgrade). Enables segmented analysis of exchange program complexity and cost."
    - name: "exchange_reason_code"
      expr: exchange_reason_code
      comment: "Reason code for the exchange request. Drives root-cause analysis of exchange drivers and product quality issues."
    - name: "exchange_source_channel"
      expr: exchange_source_channel
      comment: "Channel through which the exchange was initiated (e.g., online, in-store, call center). Used for channel-level exchange cost and volume analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel used to fulfill the exchange order. Drives fulfillment cost allocation and capacity planning."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to process any refund differential on the exchange. Informs payment operations planning."
    - name: "expedited_shipping_flag"
      expr: expedited_shipping_flag
      comment: "Boolean flag indicating expedited shipping was used for the exchange. Measures premium shipping cost exposure from exchange program."
    - name: "shipping_cost_waived_flag"
      expr: shipping_cost_waived_flag
      comment: "Boolean flag indicating shipping cost was waived for the exchange. Measures shipping cost absorption and its impact on exchange program profitability."
    - name: "price_differential_currency_code"
      expr: price_differential_currency_code
      comment: "Currency of the price differential on the exchange. Required for multi-currency financial reporting."
    - name: "exchange_initiated_month"
      expr: DATE_TRUNC('month', exchange_initiated_date)
      comment: "Month the exchange was initiated. Used for monthly exchange volume trending and seasonality analysis."
  measures:
    - name: "total_exchange_orders"
      expr: COUNT(1)
      comment: "Total number of exchange orders created. Baseline exchange program volume KPI."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund differential amount issued on exchange orders. Measures net financial outflow from price-differential exchanges."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund differential per exchange order. Benchmarks exchange price differential size and informs pricing policy review."
    - name: "expedited_shipping_exchanges"
      expr: COUNT(CASE WHEN expedited_shipping_flag = TRUE THEN 1 END)
      comment: "Number of exchange orders fulfilled with expedited shipping. Quantifies premium shipping cost exposure from the exchange program."
    - name: "shipping_cost_waived_exchanges"
      expr: COUNT(CASE WHEN shipping_cost_waived_flag = TRUE THEN 1 END)
      comment: "Number of exchange orders where shipping cost was waived. Measures shipping cost absorption and its impact on exchange program profitability."
    - name: "completed_exchanges"
      expr: COUNT(CASE WHEN exchange_order_status = 'completed' THEN 1 END)
      comment: "Number of exchange orders that have been fully completed and delivered. Measures exchange fulfillment throughput and completion rate."
    - name: "distinct_customers_exchanged"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers who initiated exchange orders. Measures exchange program reach and identifies repeat-exchange customer segments."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store credit liability and redemption metrics covering issued amounts, remaining balances, escheatment risk, and expiration exposure. Enables finance leadership to manage store credit liability, breakage estimates, and regulatory escheatment obligations."
  source: "`vibe_retail_v1`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit (e.g., active, redeemed, expired, voided). Used for liability portfolio management."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit issued (e.g., return credit, promotional credit, goodwill). Enables segmented liability analysis."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the store credit was issued (e.g., in-store, online, call center). Used for channel-level credit issuance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which store credit amounts are denominated. Required for multi-currency financial reporting."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Boolean flag indicating the store credit is eligible for escheatment (unclaimed property). Critical for regulatory compliance and liability management."
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Boolean flag indicating the store credit is transferable. Used for fraud risk assessment and program policy analysis."
    - name: "breakage_estimate_applied_flag"
      expr: breakage_estimate_applied_flag
      comment: "Boolean flag indicating a breakage estimate has been applied to this credit. Used for revenue recognition and liability reduction tracking."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the store credit was issued. Used for monthly credit issuance volume and liability trending."
    - name: "expiration_date"
      expr: expiration_date
      comment: "Date the store credit expires. Used for expiration cohort analysis and liability rundown forecasting."
    - name: "redemption_channel_restriction"
      expr: redemption_channel_restriction
      comment: "Channel restriction on store credit redemption. Used for channel-level redemption planning and customer experience analysis."
  measures:
    - name: "total_store_credits_issued"
      expr: COUNT(1)
      comment: "Total number of store credits issued. Baseline volume KPI for store credit program monitoring."
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total store credit amount issued. Primary liability metric for finance — represents outstanding obligation to customers."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance across all active store credits. Current outstanding liability metric — critical for balance sheet and cash flow planning."
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit amount issued per transaction. Benchmarks credit size and informs program design decisions."
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per store credit. Used to assess redemption velocity and estimate future liability rundown."
    - name: "escheatment_eligible_credits"
      expr: COUNT(CASE WHEN escheatment_eligible_flag = TRUE THEN 1 END)
      comment: "Number of store credits eligible for escheatment. Required for regulatory compliance reporting and unclaimed property filing."
    - name: "escheatment_eligible_balance"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN CAST(remaining_balance AS DOUBLE) ELSE 0 END)
      comment: "Total remaining balance of escheatment-eligible store credits. Quantifies regulatory liability exposure for unclaimed property compliance."
    - name: "voided_credits"
      expr: COUNT(CASE WHEN store_credit_status = 'voided' THEN 1 END)
      comment: "Number of store credits that have been voided. Monitors credit cancellation rate and potential customer satisfaction issues."
    - name: "distinct_customers_with_credit"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct customers holding store credits. Measures store credit program reach and customer retention potential."
$$;