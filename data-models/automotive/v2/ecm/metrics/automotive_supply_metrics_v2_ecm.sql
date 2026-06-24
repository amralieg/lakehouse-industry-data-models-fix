-- Metric views for domain: supply | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master KPIs: active supplier base composition, tier distribution, and onboarding trends. Used by procurement leadership to assess supply base health, geographic concentration risk, and supplier diversity."
  source: "`vibe_automotive_v1`.`supply`.`supply_supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classification of supplier (e.g., Tier 1, Tier 2, raw material, service) for supply base segmentation."
    - name: "tier_level"
      expr: tier_level
      comment: "Supply chain tier level of the supplier, used to assess direct vs. sub-tier exposure."
    - name: "country_code"
      expr: country_code
      comment: "Country of supplier headquarters, used for geographic concentration and geopolitical risk analysis."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance rating assigned to the supplier, used to segment high vs. low performers."
    - name: "is_active"
      expr: is_active
      comment: "Whether the supplier is currently active in the supply base."
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the supplier was onboarded, used to track supply base growth over time."
  measures:
    - name: "total_suppliers"
      expr: COUNT(1)
      comment: "Total number of supplier records. Baseline KPI for supply base size used in executive supply base reviews."
    - name: "active_suppliers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active suppliers. Tracks the live supply base available for production sourcing."
    - name: "inactive_suppliers"
      expr: COUNT(CASE WHEN is_active = FALSE THEN 1 END)
      comment: "Count of inactive/deactivated suppliers. Elevated counts may indicate supply base rationalization or risk events."
    - name: "distinct_countries"
      expr: COUNT(DISTINCT country_code)
      comment: "Number of distinct countries in the supply base. Measures geographic diversification and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard KPIs covering quality (PPM), on-time delivery (OTD), compliance, sustainability, and overall performance tier. Core dashboard for supplier relationship management and strategic sourcing decisions."
  source: "`vibe_automotive_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier (e.g., Preferred, Approved, Conditional, Disqualified) for segmenting scorecard results."
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Reporting period for the scorecard (e.g., Q1-2024), enabling trend analysis over time."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the scorecard (e.g., Draft, Reviewed, Approved), used to filter finalized results."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Indicates whether a corrective action was triggered for this supplier in this period."
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start)
      comment: "Year of the evaluation period start date, used for year-over-year performance trending."
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Month of the evaluation period, used for monthly performance trend analysis."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score across all scorecards. Primary KPI for supplier health in QBRs and executive reviews."
    - name: "avg_quality_ppm"
      expr: AVG(CAST(quality_ppm AS DOUBLE))
      comment: "Average parts-per-million defect rate across suppliers. Critical quality KPI — elevated PPM triggers supplier development actions."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers. Directly impacts production schedule adherence and customer delivery commitments."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average regulatory and contractual compliance score. Used to identify suppliers at risk of non-compliance penalties."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across suppliers. Increasingly mandatory for ESG reporting and OEM sustainability commitments."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply risk score. High risk scores trigger supply chain resilience interventions and dual-sourcing decisions."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average PPM defect rate from scorecard records. Used alongside quality_ppm for cross-validation of quality performance."
    - name: "avg_ppap_on_time_completion_rate"
      expr: AVG(CAST(ppap_on_time_completion_rate AS DOUBLE))
      comment: "Average PPAP on-time completion rate. Low rates indicate supplier readiness issues that delay new model launches."
    - name: "avg_delivery_quantity_accuracy_pct"
      expr: AVG(CAST(delivery_quantity_accuracy_pct AS DOUBLE))
      comment: "Average delivery quantity accuracy percentage. Deviations from 100% cause inventory imbalances and line stoppages."
    - name: "suppliers_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN 1 END)
      comment: "Number of supplier-period combinations where a corrective action was triggered. Tracks supplier quality escalation volume."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average supplier responsiveness score. Low responsiveness scores indicate communication and agility gaps in the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply purchase order KPIs covering order volume, spend, and status distribution. Used by procurement and supply chain leadership to monitor purchasing activity, open order exposure, and spend by supplier."
  source: "`vibe_automotive_v1`.`supply`.`supply_purchase_order`"
  dimensions:
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g., Open, Confirmed, Closed, Cancelled) for pipeline analysis."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g., Standard, Blanket, Consignment) for spend categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase order, used for multi-currency spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility, used to analyze logistics cost allocation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the PO, used for cash flow and working capital analysis."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was placed, used for monthly spend trend analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month the delivery is due, used for inbound supply planning and capacity alignment."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders issued. Baseline volume KPI for procurement activity tracking."
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total committed spend across all purchase orders. Primary spend KPI for budget vs. actual procurement analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average purchase order value. Used to assess order consolidation opportunities and procurement efficiency."
    - name: "open_po_count"
      expr: COUNT(CASE WHEN po_status = 'Open' THEN 1 END)
      comment: "Number of open purchase orders. Tracks outstanding supply commitments and inbound pipeline."
    - name: "open_po_spend"
      expr: SUM(CASE WHEN po_status = 'Open' THEN total_amount ELSE 0 END)
      comment: "Total spend value of open purchase orders. Measures uncommitted/undelivered supply exposure."
    - name: "cancelled_po_count"
      expr: COUNT(CASE WHEN po_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled purchase orders. High cancellation rates indicate demand volatility or supplier issues."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level KPIs covering line spend, goods receipt performance, and delivery compliance. Used by supply chain and procurement teams to track part-level procurement execution and receipt accuracy."
  source: "`vibe_automotive_v1`.`supply`.`supply_po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line (e.g., Open, Partially Received, Closed) for pipeline and fulfillment analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered part, used for volume analysis across different part types."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month the line item is due for delivery, used for inbound supply scheduling."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total number of purchase order lines. Baseline KPI for procurement line-item activity volume."
    - name: "total_line_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend across all PO lines. Granular spend KPI used for part-level cost analysis and supplier spend concentration."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines. Used to track price trends and benchmark against target prices."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity ordered across all PO lines. Used for volume planning and supplier capacity alignment."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Compared to ordered quantity to measure fulfillment completeness."
    - name: "receipt_fulfillment_rate"
      expr: ROUND(100.0 * SUM(CAST(goods_receipt_quantity AS DOUBLE)) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been received. Core delivery fulfillment KPI — low rates indicate supply shortages or delivery failures."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt KPIs covering inbound quality, acceptance rates, and rejection performance. Used by quality and supply chain teams to monitor inbound part quality and supplier delivery compliance."
  source: "`vibe_automotive_v1`.`supply`.`supply_goods_receipt`"
  dimensions:
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection outcome status (e.g., Passed, Failed, Pending) for filtering quality-compliant receipts."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location where received goods are placed, used for inventory placement analysis."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt, used for inbound volume trending and seasonal supply analysis."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions. Baseline inbound activity KPI."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of parts received. Used to measure inbound supply volume against production demand."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection. Measures usable inbound supply available for production."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at goods receipt. High rejection volumes indicate supplier quality failures and supply risk."
    - name: "acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accepted_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity that passes inspection. Core inbound quality KPI — low rates trigger supplier corrective actions."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of received quantity rejected. Directly impacts production availability and supplier quality ratings."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence KPIs measuring on-time delivery performance and quantity accuracy at the schedule line level. Used by supply chain planners and procurement to manage supplier delivery reliability."
  source: "`vibe_automotive_v1`.`supply`.`supply_delivery_schedule`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Status of the delivery schedule line (e.g., On Time, Late, Partial, Cancelled) for delivery performance segmentation."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of delivery schedule (e.g., Firm, Forecast, JIT) for planning horizon analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled delivery date, used for supply planning and capacity alignment."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of actual delivery, used to compare against scheduled month for lateness analysis."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total number of delivery schedule lines. Baseline KPI for inbound supply schedule volume."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery. Used to align inbound supply with production demand plans."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total quantity actually delivered. Compared to scheduled quantity to measure delivery completeness."
    - name: "schedule_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of scheduled quantity actually delivered. Primary delivery adherence KPI — below 95% typically triggers supply escalation."
    - name: "on_time_delivery_lines"
      expr: COUNT(CASE WHEN delivery_status = 'On Time' THEN 1 END)
      comment: "Number of schedule lines delivered on time. Used to compute OTD rate for supplier scorecards."
    - name: "late_delivery_lines"
      expr: COUNT(CASE WHEN delivery_status = 'Late' THEN 1 END)
      comment: "Number of late delivery schedule lines. High counts indicate supplier delivery reliability issues requiring intervention."
    - name: "otd_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'On Time' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "On-time delivery rate as a percentage of all schedule lines. Core supplier KPI used in scorecards and executive supply reviews."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP (Production Part Approval Process) submission KPIs tracking approval rates, submission levels, and disposition outcomes. Used by supplier quality engineers and program managers to ensure part readiness for production launch."
  source: "`vibe_automotive_v1`.`supply`.`supply_ppap_submission`"
  dimensions:
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the PPAP submission (e.g., Submitted, Approved, Rejected, Pending) for pipeline tracking."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5 per AIAG standard), indicating the depth of documentation required."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the PPAP (e.g., Full Approval, Interim Approval, Rejected) for quality gate analysis."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month of PPAP submission, used for program launch readiness trending."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month of PPAP approval, used to measure approval cycle time and launch readiness."
  measures:
    - name: "total_ppap_submissions"
      expr: COUNT(1)
      comment: "Total number of PPAP submissions. Baseline KPI for supplier part approval activity volume."
    - name: "approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END)
      comment: "Number of fully approved PPAP submissions. Measures supplier readiness for production."
    - name: "rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN 1 END)
      comment: "Number of rejected PPAP submissions. High rejection rates indicate supplier quality system deficiencies."
    - name: "ppap_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of PPAP submissions that achieve full approval. Critical launch readiness KPI — below target triggers program risk escalation."
    - name: "avg_approval_cycle_days"
      expr: AVG(DATEDIFF(approval_date, submission_date))
      comment: "Average number of days from PPAP submission to approval. Long cycle times delay production launch and increase program risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (CAR) KPIs tracking issue severity, closure rates, and resolution timeliness. Used by supplier quality teams to manage supplier non-conformances and drive continuous improvement."
  source: "`vibe_automotive_v1`.`supply`.`supply_corrective_action`"
  dimensions:
    - name: "supply_corrective_action_status"
      expr: supply_corrective_action_status
      comment: "Current status of the corrective action (e.g., Open, In Progress, Closed, Overdue) for pipeline management."
    - name: "severity"
      expr: severity
      comment: "Severity level of the corrective action issue (e.g., Critical, Major, Minor) for prioritization."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the corrective action was created, used for trend analysis of supplier quality issues."
    - name: "closure_month"
      expr: DATE_TRUNC('month', closure_date)
      comment: "Month the corrective action was closed, used for resolution cycle time analysis."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of supplier corrective actions issued. Baseline KPI for supplier quality issue volume."
    - name: "open_corrective_actions"
      expr: COUNT(CASE WHEN supply_corrective_action_status = 'Open' THEN 1 END)
      comment: "Number of currently open corrective actions. High open counts indicate unresolved supplier quality risks."
    - name: "critical_corrective_actions"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity corrective actions. Critical CARs require immediate executive attention and may trigger supply disruption."
    - name: "closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN supply_corrective_action_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that have been closed. Low closure rates indicate supplier quality management ineffectiveness."
    - name: "avg_resolution_days"
      expr: AVG(DATEDIFF(closure_date, created_timestamp))
      comment: "Average days from corrective action creation to closure. Long resolution times increase production quality risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_disruption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply disruption KPIs tracking disruption frequency, severity, and resolution status. Used by supply chain risk management and executive leadership to monitor supply continuity threats and mitigation effectiveness."
  source: "`vibe_automotive_v1`.`supply`.`disruption`"
  dimensions:
    - name: "disruption_type"
      expr: disruption_type
      comment: "Type of supply disruption (e.g., Natural Disaster, Logistics Failure, Supplier Insolvency, Quality Hold) for root cause categorization."
    - name: "severity"
      expr: severity
      comment: "Severity of the disruption (e.g., Critical, High, Medium, Low) for risk prioritization."
    - name: "disruption_status"
      expr: disruption_status
      comment: "Current status of the disruption (e.g., Active, Mitigated, Resolved) for supply risk dashboard."
    - name: "disruption_start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the disruption started, used for seasonal and trend analysis of supply risk events."
  measures:
    - name: "total_disruptions"
      expr: COUNT(1)
      comment: "Total number of supply disruption events. Baseline KPI for supply chain resilience monitoring."
    - name: "active_disruptions"
      expr: COUNT(CASE WHEN disruption_status = 'Active' THEN 1 END)
      comment: "Number of currently active supply disruptions. Real-time risk KPI used in supply chain war room dashboards."
    - name: "critical_disruptions"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Number of critical severity disruptions. Critical disruptions directly threaten production continuity and require C-level escalation."
    - name: "avg_disruption_duration_days"
      expr: AVG(DATEDIFF(end_date, start_date))
      comment: "Average duration of supply disruptions in days. Longer durations indicate greater supply chain vulnerability and mitigation ineffectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound inspection quality KPIs measuring defect rates, inspection outcomes, and disposition decisions. Used by quality and supply chain teams to monitor incoming part quality and supplier performance at the receiving dock."
  source: "`vibe_automotive_v1`.`supply`.`inbound_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall inspection result (e.g., Pass, Fail, Conditional) for quality gate analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Pending, In Progress, Complete) for workload management."
    - name: "disposition"
      expr: disposition
      comment: "Disposition decision for inspected parts (e.g., Accept, Reject, Rework, Return to Supplier)."
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g., Visual, Dimensional, Functional) for process analysis."
    - name: "inspection_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month of inspection, used for quality trend analysis over time."
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inbound inspections performed. Baseline KPI for inbound quality control activity."
    - name: "avg_defect_rate_ppm"
      expr: AVG(CAST(defect_rate_ppm AS DOUBLE))
      comment: "Average inbound defect rate in parts per million. Core quality KPI — elevated PPM triggers supplier corrective actions and impacts scorecard."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that pass. Low pass rates indicate systemic supplier quality issues requiring escalation."
    - name: "fail_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN inspection_result = 'Fail' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections that fail. Directly impacts production availability and supplier quality ratings."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ (Request for Quotation) KPIs covering sourcing activity volume, pricing competitiveness, and response cycle times. Used by procurement and sourcing teams to manage competitive bidding and supplier selection efficiency."
  source: "`vibe_automotive_v1`.`supply`.`rfq`"
  dimensions:
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g., Draft, Issued, Closed, Awarded) for pipeline management."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g., New Business, Re-sourcing, Tooling) for sourcing activity categorization."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ for governance and compliance tracking."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFQ (e.g., Critical, High, Normal) for workload prioritization."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month the RFQ was issued, used for sourcing activity trend analysis."
    - name: "tooling_required"
      expr: tooling_required
      comment: "Whether tooling investment is required, used to segment RFQs by capital commitment."
  measures:
    - name: "total_rfqs"
      expr: COUNT(1)
      comment: "Total number of RFQs issued. Baseline KPI for sourcing activity volume."
    - name: "total_target_spend"
      expr: SUM(CAST(target_price_amount AS DOUBLE))
      comment: "Total target price value across all RFQs. Measures the scale of sourcing activity and potential spend under management."
    - name: "avg_target_price"
      expr: AVG(CAST(target_price_amount AS DOUBLE))
      comment: "Average target price per RFQ. Used to benchmark quoted prices against internal cost targets."
    - name: "total_estimated_volume"
      expr: SUM(CAST(quantity_estimate AS DOUBLE))
      comment: "Total estimated quantity across all RFQs. Used for supplier capacity planning and volume commitment analysis."
    - name: "avg_response_lead_days"
      expr: AVG(DATEDIFF(response_due_date, issue_timestamp))
      comment: "Average number of days allowed for supplier response. Used to assess sourcing process speed and supplier engagement timelines."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ response KPIs measuring supplier quoting competitiveness, price vs. target variance, and response quality. Used by sourcing teams to evaluate supplier bids and make award decisions."
  source: "`vibe_automotive_v1`.`supply`.`rfq_response`"
  dimensions:
    - name: "rfq_response_status"
      expr: rfq_response_status
      comment: "Status of the RFQ response (e.g., Submitted, Under Review, Awarded, Rejected) for bid pipeline management."
    - name: "quoted_currency"
      expr: quoted_currency
      comment: "Currency of the quoted price, used for multi-currency bid normalization."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Whether the responding supplier is on the preferred supplier list, used to track preferred vs. new supplier bid activity."
    - name: "freight_included"
      expr: freight_included
      comment: "Whether freight costs are included in the quoted price, used for total landed cost comparison."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the response was submitted, used for sourcing cycle time analysis."
  measures:
    - name: "total_rfq_responses"
      expr: COUNT(1)
      comment: "Total number of RFQ responses received. Baseline KPI for supplier engagement in competitive sourcing events."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across all responses. Used to benchmark supplier pricing and identify outliers."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total value of all quoted responses. Measures the scale of competitive bids received."
    - name: "avg_tooling_cost"
      expr: AVG(CAST(tooling_cost AS DOUBLE))
      comment: "Average tooling cost quoted by suppliers. Tooling investment is a major upfront cost in new model sourcing decisions."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by suppliers. Used to assess negotiation leverage and supplier pricing flexibility."
    - name: "avg_capacity_commitment"
      expr: AVG(CAST(capacity_commitment AS DOUBLE))
      comment: "Average capacity commitment offered by suppliers. Used to validate supplier ability to meet production volume requirements."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_scheduling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling agreement KPIs covering contracted volume, pricing, and delivery performance commitments. Used by supply chain and procurement to manage long-term supply contracts and monitor adherence to agreed terms."
  source: "`vibe_automotive_v1`.`supply`.`scheduling_agreement`"
  dimensions:
    - name: "scheduling_agreement_status"
      expr: scheduling_agreement_status
      comment: "Current status of the scheduling agreement (e.g., Active, Expired, Terminated) for contract portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of scheduling agreement (e.g., Kanban, JIT, Standard) for supply strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement, used for multi-currency contract value analysis."
    - name: "kanban_flag"
      expr: kanban_flag
      comment: "Whether the agreement operates on a Kanban replenishment model, used to segment lean supply agreements."
    - name: "agreement_start_year"
      expr: YEAR(start_date)
      comment: "Year the scheduling agreement became effective, used for contract vintage analysis."
    - name: "agreement_end_year"
      expr: YEAR(end_date)
      comment: "Year the scheduling agreement expires, used for contract renewal pipeline management."
  measures:
    - name: "total_scheduling_agreements"
      expr: COUNT(1)
      comment: "Total number of scheduling agreements. Baseline KPI for long-term supply contract portfolio size."
    - name: "total_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total contracted annual volume across all scheduling agreements. Used for production capacity planning and supplier volume commitments."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average contracted unit price across scheduling agreements. Used to monitor price trends and benchmark against market rates."
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage across scheduling agreements. Measures supplier delivery performance against contracted commitments."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual PPM defect rate across scheduling agreements. Measures supplier quality performance against contracted quality targets."
    - name: "otd_vs_target_gap"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE) - CAST(target_otd_percent AS DOUBLE))
      comment: "Average gap between actual and target OTD percentage. Negative values indicate suppliers are underperforming delivery commitments."
    - name: "ppm_vs_target_gap"
      expr: AVG(CAST(actual_ppm AS DOUBLE) - CAST(target_ppm AS DOUBLE))
      comment: "Average gap between actual and target PPM. Positive values indicate suppliers are exceeding quality defect targets, requiring corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit KPIs tracking audit outcomes, scores, finding severity, and re-audit requirements. Used by supplier quality and compliance teams to manage supplier qualification and continuous improvement programs."
  source: "`vibe_automotive_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Initial Qualification, Surveillance, Re-audit, Process) for audit program management."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (e.g., Pass, Conditional Pass, Fail) for supplier qualification status."
    - name: "audit_standard"
      expr: audit_standard
      comment: "Standard against which the audit was conducted (e.g., IATF 16949, ISO 14001, VDA 6.3) for compliance tracking."
    - name: "closure_status"
      expr: closure_status
      comment: "Status of audit finding closure (e.g., Open, In Progress, Closed) for corrective action tracking."
    - name: "re_audit_required"
      expr: re_audit_required
      comment: "Whether a re-audit is required based on findings, used to prioritize follow-up audit scheduling."
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month the audit was conducted, used for audit program activity trending."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of supplier audits conducted. Baseline KPI for supplier qualification program activity."
    - name: "avg_audit_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average supplier audit score. Primary audit quality KPI used in supplier development and qualification decisions."
    - name: "failed_audits"
      expr: COUNT(CASE WHEN audit_result = 'Fail' THEN 1 END)
      comment: "Number of failed audits. Failed audits trigger supplier disqualification reviews and supply risk escalation."
    - name: "re_audit_required_count"
      expr: COUNT(CASE WHEN re_audit_required = TRUE THEN 1 END)
      comment: "Number of audits requiring re-audit. High counts indicate systemic supplier quality system deficiencies."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN audit_result = 'Pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits that pass. Core supplier qualification KPI used in supply base health reporting."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_compliance_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier regulatory compliance assignment KPIs tracking certification coverage, expiry risk, and compliance status. Used by compliance and procurement teams to ensure suppliers meet regulatory requirements."
  source: "`vibe_automotive_v1`.`supply`.`supplier_compliance_assignment`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., Compliant, Non-Compliant, Pending, Expired) for regulatory risk monitoring."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the compliance assignment became effective, used for compliance coverage trend analysis."
    - name: "expiry_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the compliance certification expires, used for proactive renewal management."
  measures:
    - name: "total_compliance_assignments"
      expr: COUNT(1)
      comment: "Total number of supplier compliance assignments. Baseline KPI for regulatory compliance coverage scope."
    - name: "compliant_assignments"
      expr: COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END)
      comment: "Number of compliant supplier-requirement assignments. Measures the breadth of regulatory compliance coverage."
    - name: "non_compliant_assignments"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of non-compliant assignments. Non-compliance can result in regulatory penalties and supply disruption."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_status = 'Compliant' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier compliance assignments that are compliant. Core regulatory risk KPI for executive compliance dashboards."
    - name: "expiring_within_90_days"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN 1 END)
      comment: "Number of compliance certifications expiring within 90 days. Proactive risk KPI to prevent compliance lapses."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price agreement KPIs covering contracted unit prices, annual volume commitments, and delivery/quality performance against targets. Used by procurement and commodity management to monitor supplier pricing and contract performance."
  source: "`vibe_automotive_v1`.`supply`.`price_agreement`"
  dimensions:
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Current status of the price agreement (e.g., Active, Expired, Under Negotiation) for contract portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g., Annual, Multi-Year, Spot) for pricing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price agreement, used for multi-currency spend analysis."
    - name: "commodity_index_linked_flag"
      expr: commodity_index_linked_flag
      comment: "Whether the price is linked to a commodity index, used to segment fixed vs. variable price agreements."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the price agreement became effective, used for pricing trend analysis."
  measures:
    - name: "total_price_agreements"
      expr: COUNT(1)
      comment: "Total number of price agreements. Baseline KPI for contracted pricing portfolio size."
    - name: "total_contracted_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total annual volume committed across all price agreements. Used for production capacity and spend planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price across all price agreements. Used to benchmark pricing and track year-over-year price trends."
    - name: "avg_annual_price_reduction_commitment"
      expr: AVG(CAST(annual_price_reduction_commitment AS DOUBLE))
      comment: "Average annual price reduction commitment. Measures the value of year-over-year cost reduction secured through supplier negotiations."
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual OTD percentage across price agreements. Used to correlate pricing with delivery performance."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual PPM defect rate across price agreements. Used to correlate pricing with quality performance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_commodity_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity group KPIs covering pricing, risk, sustainability, and hedging coverage. Used by commodity managers and procurement leadership to manage raw material exposure, price volatility, and strategic sourcing decisions."
  source: "`vibe_automotive_v1`.`supply`.`commodity_group`"
  dimensions:
    - name: "commodity_group_status"
      expr: commodity_group_status
      comment: "Current status of the commodity group (e.g., Active, Inactive, Under Review) for portfolio management."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic classification of the commodity (e.g., Critical, Leverage, Routine, Bottleneck) per Kraljic matrix."
    - name: "commodity_group_category"
      expr: commodity_group_category
      comment: "Category of the commodity group (e.g., Raw Material, Electronic, Mechanical) for spend categorization."
    - name: "hedging_strategy"
      expr: hedging_strategy
      comment: "Hedging strategy applied to the commodity (e.g., Forward Contract, Spot, Index-Linked) for financial risk management."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Whether the commodity group contains hazardous materials, used for regulatory compliance and logistics planning."
    - name: "is_global"
      expr: is_global
      comment: "Whether the commodity is sourced globally, used for geographic risk and supply chain resilience analysis."
  measures:
    - name: "total_commodity_groups"
      expr: COUNT(1)
      comment: "Total number of commodity groups. Baseline KPI for commodity portfolio breadth."
    - name: "avg_average_cost_usd"
      expr: AVG(CAST(average_cost_usd AS DOUBLE))
      comment: "Average cost per commodity group. Used to track commodity cost trends and benchmark against market prices."
    - name: "avg_price_volatility_index"
      expr: AVG(CAST(price_volatility_index AS DOUBLE))
      comment: "Average price volatility index across commodity groups. High volatility drives hedging and dual-sourcing decisions."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply risk score across commodity groups. Used to prioritize risk mitigation investments."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score across commodity groups. Used for ESG reporting and responsible sourcing compliance."
    - name: "avg_hedge_coverage_pct"
      expr: AVG(CAST(hedge_coverage_pct AS DOUBLE))
      comment: "Average hedging coverage percentage across commodity groups. Low coverage on volatile commodities increases financial risk exposure."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_ckd_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CKD (Completely Knocked Down) shipment KPIs tracking shipment volume, freight costs, customs clearance, and delivery performance. Used by global supply chain and CKD operations teams to manage international vehicle kit logistics."
  source: "`vibe_automotive_v1`.`supply`.`ckd_shipment`"
  dimensions:
    - name: "ckd_shipment_status"
      expr: ckd_shipment_status
      comment: "Current status of the CKD shipment (e.g., In Transit, Arrived, Customs Hold, Delivered) for shipment pipeline management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (e.g., Sea, Air, Rail) for freight cost and lead time analysis."
    - name: "customs_clearance_status"
      expr: customs_clearance_status
      comment: "Customs clearance status (e.g., Cleared, Pending, Held) for import compliance monitoring."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing the CKD shipment, used for cost allocation and risk transfer analysis."
    - name: "destination_plant_code"
      expr: destination_plant_code
      comment: "Destination assembly plant code, used for plant-level CKD supply analysis."
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month the CKD shipment departed, used for shipment volume trend analysis."
  measures:
    - name: "total_ckd_shipments"
      expr: COUNT(1)
      comment: "Total number of CKD shipments. Baseline KPI for CKD supply chain activity volume."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all CKD shipments. Major cost KPI for CKD operations — directly impacts vehicle landed cost."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per CKD shipment. Used to benchmark logistics efficiency and negotiate carrier rates."
    - name: "total_shipment_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total declared value of CKD shipments. Used for customs valuation, insurance, and financial reporting."
    - name: "total_kits_shipped"
      expr: SUM(CAST(kit_count AS DOUBLE))
      comment: "Total number of CKD kits shipped. Used to measure CKD supply volume against assembly plant production plans."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight of CKD shipments in kilograms. Used for freight capacity planning and carrier rate negotiations."
    - name: "avg_transit_days"
      expr: AVG(DATEDIFF(actual_arrival_date, departure_date))
      comment: "Average transit time in days from departure to actual arrival. Used to optimize CKD supply lead times and buffer stock levels."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound shipment KPIs covering freight costs, delivery window adherence, and shipment volume. Used by supply chain and logistics teams to monitor inbound supply performance and freight spend."
  source: "`vibe_automotive_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the inbound shipment (e.g., In Transit, Arrived, Delayed) for supply pipeline monitoring."
    - name: "mode_of_transport"
      expr: mode_of_transport
      comment: "Transport mode (e.g., Road, Rail, Sea, Air) for freight cost and lead time analysis."
    - name: "incoterm"
      expr: incoterm
      comment: "Incoterms governing the shipment, used for cost allocation and risk transfer analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Whether the shipment was expedited, used to track premium freight costs driven by supply disruptions."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Whether the shipment contains hazardous materials, used for compliance and logistics planning."
    - name: "ship_month"
      expr: DATE_TRUNC('month', ship_date)
      comment: "Month the shipment departed, used for inbound supply volume trend analysis."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total number of inbound shipments. Baseline KPI for inbound supply chain activity."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost. Major supply chain cost KPI — premium freight from expediting is a key cost reduction target."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per inbound shipment. Used to benchmark logistics efficiency and identify cost reduction opportunities."
    - name: "expedited_shipment_count"
      expr: COUNT(CASE WHEN is_expedited = TRUE THEN 1 END)
      comment: "Number of expedited inbound shipments. High counts indicate supply disruptions driving premium freight costs."
    - name: "expedited_freight_cost"
      expr: SUM(CASE WHEN is_expedited = TRUE THEN freight_cost ELSE 0 END)
      comment: "Total freight cost for expedited shipments. Measures the financial impact of supply disruptions on logistics costs."
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of inbound shipments in kilograms. Used for freight capacity planning and carrier rate negotiations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_sourcing_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing nomination KPIs tracking nomination volume, target pricing, and program coverage. Used by commodity managers and sourcing teams to manage supplier selection decisions for new programs."
  source: "`vibe_automotive_v1`.`supply`.`sourcing_nomination`"
  dimensions:
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the sourcing nomination (e.g., Nominated, Approved, Rejected, Pending) for pipeline management."
    - name: "commodity"
      expr: commodity
      comment: "Commodity category of the nominated part, used for spend and sourcing strategy analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the nomination, used for regional sourcing strategy and localization analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the nomination (e.g., High, Medium, Low) for supply risk management."
    - name: "is_jit"
      expr: is_jit
      comment: "Whether the nomination is for a JIT (Just-In-Time) supply arrangement, used to segment lean supply nominations."
    - name: "nomination_month"
      expr: DATE_TRUNC('month', nomination_date)
      comment: "Month the nomination was made, used for sourcing activity trend analysis."
  measures:
    - name: "total_nominations"
      expr: COUNT(1)
      comment: "Total number of sourcing nominations. Baseline KPI for new program sourcing activity volume."
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated across all sourcing nominations. Used to measure the scale of supply commitments being established."
    - name: "avg_target_piece_price"
      expr: AVG(CAST(target_piece_price AS DOUBLE))
      comment: "Average target piece price across nominations. Used to benchmark nominated prices against cost targets."
    - name: "approved_nominations"
      expr: COUNT(CASE WHEN nomination_status = 'Approved' THEN 1 END)
      comment: "Number of approved sourcing nominations. Measures the pace of supplier selection decisions for new programs."
    - name: "nomination_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nomination_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of nominations that receive approval. Low rates indicate sourcing strategy misalignment or supplier qualification issues."
$$;