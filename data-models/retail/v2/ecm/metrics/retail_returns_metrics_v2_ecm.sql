-- Metric views for domain: returns | Business: Retail | Version: 2 | Generated on: 2026-06-23 23:42:36

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core RMA (Return Merchandise Authorization) performance metrics tracking return volume, financial exposure, fraud risk, and resolution efficiency. Primary steering dashboard for the returns operations team and VP of Customer Experience."
  source: "`vibe_retail_v1`.`returns`.`rma`"
  dimensions:
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g. in-store, online, call-center) — used to benchmark channel-level return rates and cost-to-serve."
    - name: "return_type"
      expr: return_type
      comment: "Classification of the return (e.g. standard, warranty, defective, exchange) — drives disposition routing and policy compliance analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized reason code for the return — key driver of product quality and supplier accountability reporting."
    - name: "rma_status"
      expr: rma_status
      comment: "Current lifecycle status of the RMA (e.g. open, received, closed, cancelled) — used to monitor pipeline health and SLA compliance."
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g. original_payment, store_credit, exchange) — informs cash-flow and liability forecasting."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the RMA (e.g. high, medium, low) — used to assess SLA adherence by priority tier."
    - name: "authorization_date"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month of RMA authorization — enables trend analysis of return volumes over time."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the RMA was identified as fraudulent — used to segment fraud vs. legitimate return KPIs."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Outcome disposition assigned to the returned item (e.g. restock, liquidate, destroy) — drives recovery value analysis."
  measures:
    - name: "total_rma_count"
      expr: COUNT(1)
      comment: "Total number of RMAs authorized. Baseline volume metric for return rate benchmarking and capacity planning."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued across all RMAs. Direct P&L impact metric used by Finance and Operations leadership."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund value per RMA. Tracks whether high-value items are driving disproportionate return costs."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected across all RMAs. Measures cost-recovery effectiveness of the restocking fee policy."
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping borne by the retailer. Key cost-to-serve component for returns logistics optimization."
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of cash refunds. Tracks liability exposure and customer retention via credit issuance."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across RMAs. Elevated scores signal systemic fraud patterns requiring loss-prevention intervention."
    - name: "fraudulent_rma_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of RMAs flagged as fraudulent. Directly informs fraud prevention investment and policy tightening decisions."
    - name: "fraud_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RMAs identified as fraudulent. Executive KPI for returns fraud risk — triggers policy review when elevated."
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Total expected recovery value from all open RMAs. Used by Finance for accrual and liability estimation."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level return metrics providing SKU-granular visibility into return volumes, financial impact, vendor credit recovery, and restocking eligibility. Used by Merchandising, Finance, and Vendor Management teams."
  source: "`vibe_retail_v1`.`returns`.`rma_line`"
  dimensions:
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the returned line item — primary driver of product quality and supplier accountability analysis."
    - name: "condition_code"
      expr: condition_code
      comment: "Physical condition of the returned item (e.g. new, damaged, defective) — determines disposition routing and recovery value."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome assigned to the line (e.g. restock, liquidate, vendor return) — drives recovery value and inventory impact."
    - name: "line_status"
      expr: line_status
      comment: "Current processing status of the RMA line — used to monitor pipeline throughput and identify bottlenecks."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Whether the returned item is eligible for restocking — key input to inventory recovery rate calculations."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of item inspection — enables trend analysis of inspection throughput and backlog."
  measures:
    - name: "total_rma_lines"
      expr: COUNT(1)
      comment: "Total number of RMA line items processed. Baseline throughput metric for returns operations capacity planning."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund value issued at the line level. Granular P&L impact metric for SKU-level return cost analysis."
    - name: "total_extended_retail_amount"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned merchandise. Measures gross merchandise value at risk from returns."
    - name: "total_extended_cost_amount"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned merchandise. Used to calculate net margin impact of returns."
    - name: "total_vendor_credit_amount"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit recovered on returned lines. Measures supplier accountability and credit recovery effectiveness."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at line level. Tracks policy enforcement and cost-recovery per SKU."
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total revenue recovered through liquidation of returned items. Key metric for secondary recovery channel performance."
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average retail price of returned items. Identifies whether high-value SKUs are disproportionately returned."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost of returned items. Used alongside retail price to compute return margin impact."
    - name: "restocking_eligible_line_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of returned lines eligible for restocking. Drives inventory recovery planning and restock labor scheduling."
    - name: "restocking_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of returned lines eligible for restocking. Executive KPI for returns quality — higher rates indicate better product condition on return."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund financial performance metrics covering total refund liability, settlement timing, fraud exposure, and channel-level refund patterns. Core Finance and Customer Experience steering dashboard."
  source: "`vibe_retail_v1`.`returns`.`refund`"
  dimensions:
    - name: "refund_method"
      expr: method
      comment: "Refund method used (e.g. original_payment, store_credit, check) — informs cash-flow forecasting and customer preference analysis."
    - name: "refund_type"
      expr: refund_type
      comment: "Classification of the refund (e.g. full, partial, restocking_fee_waived) — used to analyze policy consistency and exception rates."
    - name: "refund_status"
      expr: refund_status
      comment: "Current processing status of the refund (e.g. pending, processed, failed) — used to monitor settlement pipeline health."
    - name: "channel"
      expr: channel
      comment: "Channel through which the refund was initiated (e.g. store, online, call-center) — enables channel-level cost-to-serve analysis."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund — primary driver of root-cause analysis for return and refund reduction programs."
    - name: "is_fraudulent"
      expr: is_fraudulent
      comment: "Flag indicating whether the refund was identified as fraudulent — used to segment fraud vs. legitimate refund KPIs."
    - name: "initiated_month"
      expr: DATE_TRUNC('month', initiated_timestamp)
      comment: "Month the refund was initiated — enables trend analysis of refund volumes and financial liability over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the refund transaction — required for multi-currency financial consolidation."
  measures:
    - name: "total_refund_count"
      expr: COUNT(1)
      comment: "Total number of refunds processed. Baseline volume metric for refund operations capacity and trend monitoring."
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total monetary value of all refunds issued. Primary P&L impact metric for the returns domain — reviewed at every financial close."
    - name: "total_merchandise_refund_amount"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise component of refunds. Isolates product-level refund liability from shipping and tax components."
    - name: "total_tax_refunded"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded. Required for tax liability reconciliation and regulatory reporting."
    - name: "total_shipping_refunded"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping costs refunded to customers. Measures logistics cost exposure from return shipping policy."
    - name: "total_restocking_fee_collected"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees collected, offsetting gross refund liability. Measures policy enforcement effectiveness."
    - name: "avg_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund value per transaction. Tracks whether high-value refunds are trending up, signaling product quality or fraud issues."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across refund transactions. Elevated scores trigger loss-prevention review and policy tightening."
    - name: "fraudulent_refund_count"
      expr: COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END)
      comment: "Count of refunds flagged as fraudulent. Direct input to fraud loss quantification and prevention ROI calculations."
    - name: "fraud_refund_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_fraudulent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of refunds identified as fraudulent. Executive KPI for returns fraud risk management."
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amounts applied to refunds (e.g. price corrections, goodwill). Tracks exception handling and policy override costs."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return request intake and approval funnel metrics measuring request volume, approval rates, fraud risk, and SLA compliance. Used by Customer Service leadership and Operations to optimize the returns intake process."
  source: "`vibe_retail_v1`.`returns`.`return_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the return request (e.g. pending, approved, denied, cancelled) — used to monitor approval funnel health."
    - name: "request_channel"
      expr: request_channel
      comment: "Channel through which the return was requested (e.g. online, in-store, phone) — enables channel-level conversion and cost analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return request — primary driver of product quality and policy compliance analysis."
    - name: "preferred_resolution_type"
      expr: preferred_resolution_type
      comment: "Customer's preferred resolution (e.g. refund, exchange, store_credit) — informs resolution mix planning and customer satisfaction strategy."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the request — used to assess SLA adherence by priority tier."
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Flag indicating suspected fraud on the return request — used to segment fraud-risk requests for targeted review."
    - name: "is_within_return_window"
      expr: is_within_return_window
      comment: "Whether the request was made within the policy return window — key compliance and exception-rate metric."
    - name: "request_month"
      expr: DATE_TRUNC('month', request_timestamp)
      comment: "Month the return request was submitted — enables trend analysis of return request volumes."
  measures:
    - name: "total_return_requests"
      expr: COUNT(1)
      comment: "Total number of return requests submitted. Baseline volume metric for returns intake capacity planning."
    - name: "approved_request_count"
      expr: COUNT(CASE WHEN request_status = 'approved' THEN 1 END)
      comment: "Number of return requests approved. Used to calculate approval rate and monitor policy consistency."
    - name: "denied_request_count"
      expr: COUNT(CASE WHEN request_status = 'denied' THEN 1 END)
      comment: "Number of return requests denied. Elevated denial rates may indicate policy friction or customer experience issues."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN request_status = 'approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return requests approved. Executive KPI for returns policy effectiveness and customer experience."
    - name: "fraud_flagged_request_count"
      expr: COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END)
      comment: "Number of return requests flagged for fraud risk. Drives loss-prevention resource allocation and policy review."
    - name: "fraud_flag_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN fraud_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return requests flagged for fraud. Tracks fraud risk exposure at the intake stage."
    - name: "out_of_window_request_count"
      expr: COUNT(CASE WHEN is_within_return_window = FALSE THEN 1 END)
      comment: "Number of return requests submitted outside the policy return window. Measures policy exception volume and associated cost risk."
    - name: "avg_estimated_refund_amount"
      expr: AVG(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Average estimated refund value per return request. Used for financial accrual and liability forecasting."
    - name: "total_estimated_refund_amount"
      expr: SUM(CAST(estimated_refund_amount AS DOUBLE))
      comment: "Total estimated refund liability from all open return requests. Key input to Finance accrual and cash-flow planning."
    - name: "avg_fraud_risk_score"
      expr: AVG(CAST(fraud_risk_score AS DOUBLE))
      comment: "Average fraud risk score at intake. Monitors whether fraud risk is trending up across the return request population."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposition outcome metrics measuring recovery value, condition distribution, and financial performance of returned merchandise processing. Used by Operations, Finance, and Sustainability teams to optimize recovery strategies."
  source: "`vibe_retail_v1`.`returns`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of disposition applied (e.g. restock, liquidate, donate, destroy) — primary dimension for recovery strategy analysis."
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition process — used to monitor pipeline throughput and identify processing bottlenecks."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the returned item (e.g. A, B, C, salvage) — key driver of recovery value and disposition routing."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code associated with the disposition — links return cause to recovery outcome for root-cause analysis."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the item is classified as hazardous material — drives compliance cost and specialized handling requirements."
    - name: "restocking_fee_applied"
      expr: restocking_fee_applied
      comment: "Whether a restocking fee was applied — used to measure policy enforcement consistency."
    - name: "decision_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month the disposition decision was made — enables trend analysis of disposition throughput and recovery value over time."
  measures:
    - name: "total_dispositions"
      expr: COUNT(1)
      comment: "Total number of disposition decisions made. Baseline throughput metric for returns processing operations."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE))
      comment: "Total actual monetary value recovered from disposed items. Primary financial outcome metric for the disposition process."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value at time of disposition decision. Used to measure forecast accuracy vs. actual recovery."
    - name: "avg_actual_recovery_value"
      expr: AVG(CAST(actual_recovery_value AS DOUBLE))
      comment: "Average recovery value per disposed item. Benchmarks recovery efficiency across disposition types and condition grades."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected during disposition. Measures cost-recovery from the restocking fee policy."
    - name: "recovery_vs_estimate_variance"
      expr: SUM(CAST(actual_recovery_value AS DOUBLE) - CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total variance between actual and estimated recovery value. Negative variance signals over-optimistic recovery forecasting."
    - name: "hazmat_disposition_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of hazardous material dispositions. Tracks compliance exposure and specialized handling cost drivers."
    - name: "avg_recovery_vs_estimate_ratio"
      expr: ROUND(AVG(actual_recovery_value / NULLIF(estimated_recovery_value, 0)), 4)
      comment: "Average ratio of actual to estimated recovery value per disposition. Values below 1.0 indicate systematic over-estimation of recovery."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_liquidation_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidation batch financial performance metrics measuring recovery rates, net proceeds, and cost efficiency of secondary merchandise disposal. Used by Finance, Operations, and Sustainability leadership to optimize liquidation strategy."
  source: "`vibe_retail_v1`.`returns`.`liquidation_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the liquidation batch (e.g. pending, sold, settled, cancelled) — used to monitor pipeline health and settlement timing."
    - name: "liquidation_channel"
      expr: liquidation_channel
      comment: "Channel used for liquidation (e.g. auction, bulk_buyer, donation, destruction) — primary dimension for channel performance comparison."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Whether the batch contains hazardous materials — drives compliance cost and specialized handling requirements."
    - name: "requires_data_destruction"
      expr: requires_data_destruction
      comment: "Whether items require data destruction before disposal — tracks compliance cost for electronics and data-bearing items."
    - name: "sale_month"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month of liquidation sale — enables trend analysis of liquidation volumes and recovery rates over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the liquidation transaction — required for multi-currency financial consolidation."
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of liquidation batches processed. Baseline throughput metric for liquidation operations."
    - name: "total_net_recovery_amount"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net proceeds from liquidation after fees and costs. Primary financial outcome metric for the liquidation program."
    - name: "total_final_sale_price"
      expr: SUM(CAST(final_sale_price AS DOUBLE))
      comment: "Total gross sale price achieved across all liquidation batches. Measures gross revenue from secondary merchandise disposal."
    - name: "total_cost_value"
      expr: SUM(CAST(total_cost_value AS DOUBLE))
      comment: "Total original cost value of liquidated merchandise. Used to calculate the loss recognized through liquidation."
    - name: "total_liquidation_fees"
      expr: SUM(CAST(liquidation_fees AS DOUBLE))
      comment: "Total fees paid to liquidation partners. Measures cost of the liquidation channel and informs partner negotiation."
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost AS DOUBLE))
      comment: "Total transportation costs incurred for liquidation shipments. Key cost component in net recovery calculation."
    - name: "total_tax_write_off_amount"
      expr: SUM(CAST(tax_write_off_amount AS DOUBLE))
      comment: "Total tax write-off value from liquidated merchandise. Informs tax planning and financial reporting."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate percentage across liquidation batches. Executive KPI for liquidation program effectiveness — benchmarked against industry norms."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of liquidated merchandise in cubic meters. Used for logistics capacity planning and cost-per-unit analysis."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of liquidated merchandise in kilograms. Used for transportation cost benchmarking and carrier rate analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_liquidation_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level liquidation recovery metrics enabling granular analysis of which products, categories, and condition grades yield the best secondary market recovery. Used by Merchandising and Finance to optimize liquidation routing decisions."
  source: "`vibe_retail_v1`.`returns`.`liquidation_item`"
  dimensions:
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the liquidated item — primary driver of recovery value per unit."
    - name: "liquidation_channel"
      expr: liquidation_channel
      comment: "Channel used to liquidate the item — enables channel-level recovery rate benchmarking."
    - name: "category_code"
      expr: category_code
      comment: "Product category of the liquidated item — used to identify which categories have the best and worst recovery rates."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome code — links liquidation results back to the disposition decision for feedback loop analysis."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Original return reason for the item — connects liquidation outcomes to return root causes."
    - name: "brand_name"
      expr: brand_name
      comment: "Brand of the liquidated item — enables brand-level recovery rate analysis for vendor accountability."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the liquidation item record was created — enables trend analysis of liquidation item volumes."
  measures:
    - name: "total_liquidation_items"
      expr: COUNT(1)
      comment: "Total number of liquidation item lines processed. Baseline throughput metric for liquidation item processing."
    - name: "total_actual_recovery_value"
      expr: SUM(CAST(actual_total_recovery_value AS DOUBLE))
      comment: "Total actual recovery value across all liquidation items. Primary financial outcome metric at the item level."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_total_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value at time of liquidation. Used to measure forecast accuracy vs. actual recovery."
    - name: "total_loss_amount"
      expr: SUM(CAST(loss_amount AS DOUBLE))
      comment: "Total loss recognized on liquidated items (cost minus recovery). Measures the financial cost of the returns and liquidation process."
    - name: "avg_recovery_rate_pct"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate percentage per liquidation item. Benchmarks recovery efficiency by condition grade, category, and channel."
    - name: "avg_actual_recovery_per_unit"
      expr: AVG(CAST(actual_recovery_value_per_unit AS DOUBLE))
      comment: "Average actual recovery value per unit. Used to benchmark liquidation pricing effectiveness across channels and condition grades."
    - name: "recovery_forecast_variance"
      expr: SUM(CAST(actual_total_recovery_value AS DOUBLE) - CAST(estimated_total_recovery_value AS DOUBLE))
      comment: "Total variance between actual and estimated recovery value at item level. Negative values indicate systematic over-estimation."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of liquidated items in kilograms. Used for logistics cost allocation and per-unit transportation cost analysis."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return fraud investigation metrics tracking fraud case volumes, financial exposure, detection effectiveness, and enforcement outcomes. Used by Loss Prevention, Legal, and Finance leadership to manage fraud risk and quantify losses."
  source: "`vibe_retail_v1`.`returns`.`return_fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud case (e.g. open, under_investigation, closed, escalated) — used to monitor investigation pipeline health."
    - name: "fraud_typology"
      expr: fraud_typology
      comment: "Type of fraud scheme identified (e.g. wardrobing, receipt_fraud, stolen_goods) — primary dimension for fraud pattern analysis."
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the fraud (e.g. system_alert, associate_report, audit) — used to evaluate detection channel effectiveness."
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Outcome of the fraud investigation (e.g. confirmed, unsubstantiated, referred_to_law_enforcement) — tracks enforcement effectiveness."
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level assigned to the investigation — used to assess resource allocation and SLA adherence by priority."
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of financial recovery from the fraud case — tracks civil recovery and chargeback collection effectiveness."
    - name: "case_opened_month"
      expr: DATE_TRUNC('month', case_opened_timestamp)
      comment: "Month the fraud case was opened — enables trend analysis of fraud case volumes over time."
  measures:
    - name: "total_fraud_cases"
      expr: COUNT(1)
      comment: "Total number of return fraud cases opened. Baseline volume metric for loss prevention capacity planning."
    - name: "total_estimated_fraud_value"
      expr: SUM(CAST(estimated_fraud_value_amount AS DOUBLE))
      comment: "Total estimated financial exposure from return fraud cases. Primary metric for quantifying fraud loss and justifying prevention investment."
    - name: "total_civil_recovery_amount"
      expr: SUM(CAST(civil_recovery_amount AS DOUBLE))
      comment: "Total civil recovery amounts collected from fraud perpetrators. Measures enforcement effectiveness and recovery ROI."
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across cases. Tracks whether fraud detection models are correctly prioritizing high-risk cases."
    - name: "avg_customer_return_value_90d"
      expr: AVG(CAST(customer_return_value_90d AS DOUBLE))
      comment: "Average 90-day return value for customers involved in fraud cases. Identifies high-value fraud perpetrators for targeted enforcement."
    - name: "management_review_required_count"
      expr: COUNT(CASE WHEN management_review_required_flag = TRUE THEN 1 END)
      comment: "Number of fraud cases requiring management review. Tracks escalation volume and management bandwidth requirements."
    - name: "civil_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN civil_recovery_amount > 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fraud cases where civil recovery was achieved. Measures enforcement effectiveness and deterrence program ROI."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store credit liability and redemption metrics tracking issued balances, outstanding liability, expiry risk, and escheatment exposure. Used by Finance and Customer Experience leadership to manage store credit program economics."
  source: "`vibe_retail_v1`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit (e.g. active, redeemed, expired, voided) — used to monitor liability and breakage rates."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit (e.g. return_credit, goodwill, promotional) — enables analysis of credit issuance by source."
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which the store credit was issued (e.g. store, online, call-center) — used for channel-level liability analysis."
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Whether the store credit is eligible for escheatment to the state — tracks regulatory compliance exposure."
    - name: "combinable_with_promotions_flag"
      expr: combinable_with_promotions_flag
      comment: "Whether the credit can be combined with promotions — informs promotional liability stacking risk."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month the store credit was issued — enables cohort analysis of credit issuance and redemption patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the store credit — required for multi-currency liability consolidation."
  measures:
    - name: "total_store_credits_issued"
      expr: COUNT(1)
      comment: "Total number of store credits issued. Baseline volume metric for store credit program activity."
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total monetary value of store credits issued. Measures gross liability created by the store credit program."
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total outstanding store credit balance across all active credits. Primary liability metric for Finance balance sheet reporting."
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit value issued per transaction. Tracks whether credit values are trending up, indicating policy generosity changes."
    - name: "active_credit_count"
      expr: COUNT(CASE WHEN store_credit_status = 'active' THEN 1 END)
      comment: "Number of currently active store credits. Measures outstanding liability count for redemption forecasting."
    - name: "escheatment_eligible_count"
      expr: COUNT(CASE WHEN escheatment_eligible_flag = TRUE THEN 1 END)
      comment: "Number of store credits eligible for escheatment. Tracks regulatory compliance exposure and required state remittance."
    - name: "escheatment_eligible_balance"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN remaining_balance ELSE 0 END)
      comment: "Total balance of store credits eligible for escheatment. Quantifies regulatory liability for state unclaimed property reporting."
    - name: "breakage_estimate_applied_count"
      expr: COUNT(CASE WHEN breakage_estimate_applied_flag = TRUE THEN 1 END)
      comment: "Number of store credits with breakage estimates applied. Tracks revenue recognition from unredeemed credit breakage."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_vendor_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor credit recovery metrics tracking expected vs. actual credit amounts, dispute rates, and settlement timing. Used by Accounts Payable, Merchandising, and Vendor Management to optimize supplier credit recovery."
  source: "`vibe_retail_v1`.`returns`.`vendor_credit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the vendor credit (e.g. pending, received, disputed, applied) — used to monitor credit recovery pipeline health."
    - name: "credit_type"
      expr: credit_type
      comment: "Type of vendor credit (e.g. return_to_vendor, defective_allowance, chargeback) — enables analysis by credit source."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the vendor credit — required for multi-currency AP reconciliation."
    - name: "credit_month"
      expr: DATE_TRUNC('month', credit_date)
      comment: "Month the vendor credit was issued — enables trend analysis of credit recovery volumes over time."
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for credit disputes — identifies systemic vendor credit discrepancy patterns for negotiation leverage."
  measures:
    - name: "total_vendor_credits"
      expr: COUNT(1)
      comment: "Total number of vendor credit records. Baseline volume metric for vendor credit recovery operations."
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total actual vendor credit amount received. Primary metric for measuring supplier credit recovery performance."
    - name: "total_expected_credit_amount"
      expr: SUM(CAST(expected_credit_amount AS DOUBLE))
      comment: "Total expected vendor credit amount. Used to calculate credit recovery rate and identify shortfalls."
    - name: "total_credit_variance_amount"
      expr: SUM(CAST(credit_variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual vendor credits. Negative variance indicates under-recovery requiring dispute resolution."
    - name: "total_restocking_fee_amount"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees charged to vendors. Measures cost-recovery from vendor return policies."
    - name: "avg_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average vendor credit amount per transaction. Benchmarks credit recovery efficiency across vendors."
    - name: "credit_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(credit_amount AS DOUBLE)) / NULLIF(SUM(CAST(expected_credit_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of expected vendor credit actually received. Executive KPI for vendor credit recovery effectiveness — below 95% triggers AP dispute escalation."
    - name: "disputed_credit_count"
      expr: COUNT(CASE WHEN credit_status = 'disputed' THEN 1 END)
      comment: "Number of vendor credits in dispute. Tracks dispute volume and associated AP resolution workload."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_rtv_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return-to-vendor line metrics measuring vendor return volumes, credit recovery, chargeback effectiveness, and shipment compliance. Used by Merchandising, Vendor Management, and Finance to manage supplier return programs."
  source: "`vibe_retail_v1`.`returns`.`rtv_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the RTV line (e.g. pending, shipped, credited, closed) — used to monitor RTV pipeline throughput."
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the vendor return — primary driver of supplier accountability and defect analysis."
    - name: "condition_code"
      expr: condition_code
      comment: "Physical condition of the returned item — determines vendor credit eligibility and chargeback applicability."
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition outcome for the RTV line — links vendor return to final merchandise disposition."
    - name: "shipped_month"
      expr: DATE_TRUNC('month', shipped_date)
      comment: "Month the RTV shipment was sent — enables trend analysis of vendor return volumes over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the RTV transaction — required for multi-currency vendor credit reconciliation."
  measures:
    - name: "total_rtv_lines"
      expr: COUNT(1)
      comment: "Total number of RTV lines processed. Baseline throughput metric for vendor return operations."
    - name: "total_return_quantity"
      expr: SUM(CAST(return_quantity AS DOUBLE))
      comment: "Total units returned to vendors. Measures vendor return program volume and supplier accountability."
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost AS DOUBLE))
      comment: "Total cost value of merchandise returned to vendors. Measures gross financial exposure in the RTV program."
    - name: "total_vendor_credit_expected"
      expr: SUM(CAST(vendor_credit_expected_total AS DOUBLE))
      comment: "Total expected vendor credit for RTV lines. Used to forecast credit recovery and identify shortfalls."
    - name: "total_vendor_credit_actual"
      expr: SUM(CAST(vendor_credit_actual_total AS DOUBLE))
      comment: "Total actual vendor credit received for RTV lines. Primary metric for measuring vendor credit recovery performance."
    - name: "total_chargeback_amount"
      expr: SUM(CAST(chargeback_amount AS DOUBLE))
      comment: "Total chargeback amounts assessed to vendors. Measures cost-recovery through vendor penalty programs."
    - name: "total_credit_variance_amount"
      expr: SUM(CAST(credit_variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual vendor credits at line level. Identifies vendors with systematic credit shortfalls."
    - name: "vendor_credit_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(vendor_credit_actual_total AS DOUBLE)) / NULLIF(SUM(CAST(vendor_credit_expected_total AS DOUBLE)), 0), 2)
      comment: "Percentage of expected vendor credit actually received at line level. Executive KPI for RTV program effectiveness — below target triggers vendor escalation."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of items returned to vendors. Used to benchmark RTV program value and prioritize high-cost vendor returns."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_restock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restock event metrics measuring the volume, value, and efficiency of returned merchandise being reintegrated into sellable inventory. Used by Inventory Management and Operations to optimize recovery from returns."
  source: "`vibe_retail_v1`.`returns`.`restock_event`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status assigned after restocking (e.g. available, quarantine, clearance) — used to monitor quality of restocked inventory."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the restocked item — primary driver of markdown requirement and recovery value."
    - name: "restock_reason_code"
      expr: restock_reason_code
      comment: "Reason code for the restock event — links restock activity back to return root causes."
    - name: "restock_location_type"
      expr: restock_location_type
      comment: "Type of location where item was restocked (e.g. store_floor, backroom, dc) — used for location-level restock analysis."
    - name: "inspection_required"
      expr: inspection_required
      comment: "Whether inspection was required before restocking — tracks inspection compliance and associated labor cost."
    - name: "inventory_adjustment_posted"
      expr: inventory_adjustment_posted
      comment: "Whether the inventory adjustment was posted to the system — monitors restock process completion and data integrity."
    - name: "restock_month"
      expr: DATE_TRUNC('month', restock_timestamp)
      comment: "Month of the restock event — enables trend analysis of restock volumes and recovery value over time."
  measures:
    - name: "total_restock_events"
      expr: COUNT(1)
      comment: "Total number of restock events. Baseline throughput metric for returns-to-inventory recovery operations."
    - name: "total_quantity_restocked"
      expr: SUM(CAST(quantity_restocked AS DOUBLE))
      comment: "Total units restocked from returns. Measures the volume of inventory recovered through the returns process."
    - name: "total_restocked_value"
      expr: SUM(CAST(restocked_value AS DOUBLE))
      comment: "Total value of merchandise successfully restocked. Primary metric for measuring inventory recovery value from returns."
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of restocked items. Used to calculate recovery rate relative to original cost basis."
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown value applied to restocked items. Measures the cost of condition-related price reductions on returned merchandise."
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown percentage applied to restocked items. Tracks whether return condition is deteriorating, requiring deeper markdowns."
    - name: "inspection_completed_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN inspection_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required inspections completed before restocking. Measures compliance with inspection policy — below target indicates process risk."
    - name: "adjustment_posted_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inventory_adjustment_posted = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of restock events with inventory adjustments posted. Measures data integrity and system synchronization compliance."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return shipment logistics metrics measuring shipping costs, delivery performance, and exception rates for inbound return shipments. Used by Logistics and Operations leadership to optimize return shipping cost and customer experience."
  source: "`vibe_retail_v1`.`returns`.`return_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the return shipment (e.g. label_created, in_transit, delivered, exception) — used to monitor return shipment pipeline."
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of return shipment (e.g. customer_return, rtv, store_transfer) — enables cost analysis by shipment type."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination for the return shipment (e.g. store, dc, vendor) — used for routing cost and efficiency analysis."
    - name: "exception_type"
      expr: exception_type
      comment: "Type of shipment exception encountered (e.g. lost, damaged, refused) — primary dimension for exception root-cause analysis."
    - name: "delivery_signature_required"
      expr: delivery_signature_required
      comment: "Whether delivery signature was required — tracks premium service usage and associated cost."
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month the return shipment was sent — enables trend analysis of return shipment volumes and costs."
    - name: "shipping_cost_currency_code"
      expr: shipping_cost_currency_code
      comment: "Currency of the shipping cost — required for multi-currency logistics cost consolidation."
  measures:
    - name: "total_return_shipments"
      expr: COUNT(1)
      comment: "Total number of return shipments processed. Baseline volume metric for return logistics operations."
    - name: "total_shipping_cost"
      expr: SUM(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Total cost of return shipping. Primary cost metric for return logistics — directly impacts returns program profitability."
    - name: "total_label_cost"
      expr: SUM(CAST(label_cost_amount AS DOUBLE))
      comment: "Total cost of return shipping labels. Measures label program cost and informs carrier rate negotiation."
    - name: "total_insurance_amount"
      expr: SUM(CAST(insurance_amount AS DOUBLE))
      comment: "Total insurance value on return shipments. Tracks risk coverage cost for high-value return shipments."
    - name: "avg_shipping_cost"
      expr: AVG(CAST(shipping_cost_amount AS DOUBLE))
      comment: "Average shipping cost per return shipment. Benchmarks carrier rate efficiency and identifies cost outliers."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of return shipments in kilograms. Used for carrier rate benchmarking and cost-per-kg analysis."
    - name: "total_volume_m3"
      expr: SUM(CAST(total_volume_m3 AS DOUBLE))
      comment: "Total volume of return shipments in cubic meters. Used for dimensional weight pricing analysis and carrier optimization."
    - name: "exception_shipment_count"
      expr: COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END)
      comment: "Number of return shipments with exceptions. Tracks logistics quality and carrier performance issues."
    - name: "exception_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN exception_type IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return shipments with exceptions. Executive KPI for return logistics quality — elevated rates trigger carrier review."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_return_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return receipt processing metrics measuring receiving accuracy, inspection throughput, discrepancy rates, and recovery value estimation. Used by Warehouse Operations and Finance to manage the physical returns receiving process."
  source: "`vibe_retail_v1`.`returns`.`return_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the return receipt (e.g. pending, inspected, processed, discrepancy) — used to monitor receiving pipeline health."
    - name: "receiving_location_type"
      expr: receiving_location_type
      comment: "Type of location receiving the return (e.g. store, dc, vendor_hub) — enables location-type cost and throughput analysis."
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (e.g. mail, in-store, carrier_pickup) — used for channel-level receiving cost analysis."
    - name: "discrepancy_flag"
      expr: discrepancy_flag
      comment: "Whether a discrepancy was found between authorized and received quantities — primary quality metric for receiving accuracy."
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Whether inspection was required for the receipt — tracks inspection workload and compliance."
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Whether the received return is eligible for restocking — key input to inventory recovery planning."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month the return was received — enables trend analysis of receiving volumes and throughput."
  measures:
    - name: "total_return_receipts"
      expr: COUNT(1)
      comment: "Total number of return receipts processed. Baseline throughput metric for returns receiving operations."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total quantity authorized for return across all receipts. Used to measure receiving compliance against authorization."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received. Compared against authorized quantity to identify over/under-receipt patterns."
    - name: "total_estimated_recovery_value"
      expr: SUM(CAST(estimated_recovery_value AS DOUBLE))
      comment: "Total estimated recovery value of received returns. Used for financial accrual and disposition planning."
    - name: "discrepancy_receipt_count"
      expr: COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END)
      comment: "Number of receipts with quantity or condition discrepancies. Tracks receiving accuracy and potential fraud or carrier damage."
    - name: "discrepancy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN discrepancy_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of return receipts with discrepancies. Executive KPI for receiving quality — elevated rates trigger process and carrier review."
    - name: "restocking_eligible_receipt_count"
      expr: COUNT(CASE WHEN restocking_eligible_flag = TRUE THEN 1 END)
      comment: "Number of receipts where items are eligible for restocking. Measures inventory recovery opportunity from the receiving process."
    - name: "refund_triggered_count"
      expr: COUNT(CASE WHEN refund_triggered_flag = TRUE THEN 1 END)
      comment: "Number of receipts that triggered an automatic refund. Tracks automated refund processing volume and associated financial liability."
$$;

CREATE OR REPLACE VIEW `vibe_retail_v1`.`_metrics`.`returns_exchange_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Exchange order metrics measuring exchange volume, financial differentials, fulfillment performance, and customer resolution patterns. Used by Customer Experience and Operations leadership to optimize the exchange program."
  source: "`vibe_retail_v1`.`returns`.`exchange_order`"
  dimensions:
    - name: "exchange_order_status"
      expr: exchange_order_status
      comment: "Current status of the exchange order (e.g. pending, approved, shipped, completed, cancelled) — used to monitor exchange fulfillment pipeline."
    - name: "exchange_type"
      expr: exchange_type
      comment: "Type of exchange (e.g. same_item, different_item, upgrade) — enables analysis of exchange program complexity and cost."
    - name: "exchange_source_channel"
      expr: exchange_source_channel
      comment: "Channel through which the exchange was initiated — used for channel-level exchange rate and cost analysis."
    - name: "exchange_reason_code"
      expr: exchange_reason_code
      comment: "Reason code for the exchange — primary driver of product quality and customer satisfaction analysis."
    - name: "fulfillment_channel"
      expr: fulfillment_channel
      comment: "Channel used to fulfill the exchange (e.g. ship_to_home, bopis, in-store) — used for fulfillment cost analysis."
    - name: "additional_payment_required_flag"
      expr: additional_payment_required_flag
      comment: "Whether additional payment was required for the exchange — tracks upgrade exchange volume and associated revenue."
    - name: "expedited_shipping_flag"
      expr: expedited_shipping_flag
      comment: "Whether expedited shipping was used for the exchange — tracks premium fulfillment cost exposure."
    - name: "exchange_initiated_month"
      expr: DATE_TRUNC('month', exchange_initiated_date)
      comment: "Month the exchange was initiated — enables trend analysis of exchange volumes over time."
  measures:
    - name: "total_exchange_orders"
      expr: COUNT(1)
      comment: "Total number of exchange orders created. Baseline volume metric for exchange program activity."
    - name: "total_price_differential_amount"
      expr: SUM(CAST(price_differential_amount AS DOUBLE))
      comment: "Total price differential collected on exchanges (upgrade revenue). Measures incremental revenue generated through the exchange program."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amounts issued on exchanges (downgrade credits). Measures financial liability from exchanges where replacement is lower value."
    - name: "avg_price_differential"
      expr: AVG(CAST(price_differential_amount AS DOUBLE))
      comment: "Average price differential per exchange order. Tracks whether exchanges are trending toward upgrades (positive) or downgrades (negative)."
    - name: "additional_payment_exchange_count"
      expr: COUNT(CASE WHEN additional_payment_required_flag = TRUE THEN 1 END)
      comment: "Number of exchanges requiring additional payment. Measures upgrade exchange volume and associated incremental revenue opportunity."
    - name: "shipping_cost_waived_count"
      expr: COUNT(CASE WHEN shipping_cost_waived_flag = TRUE THEN 1 END)
      comment: "Number of exchanges where shipping cost was waived. Tracks shipping cost concession volume and associated cost exposure."
    - name: "shipping_waiver_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN shipping_cost_waived_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of exchanges with shipping cost waived. Measures policy exception rate and associated logistics cost subsidy."
$$;