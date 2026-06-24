-- Metric views for domain: supply | Business: Automotive | Version: 2 | Generated on: 2026-06-23 05:54:22

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics covering quality, delivery, compliance, risk, and sustainability dimensions. Used by procurement leadership to evaluate and tier suppliers, trigger corrective actions, and steer sourcing decisions."
  source: "`vibe_automotive_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Foreign key to the supplier master — enables per-supplier performance slicing."
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant receiving the supplier's parts — enables plant-level supplier performance analysis."
    - name: "scorecard_period"
      expr: scorecard_period
      comment: "Business period label (e.g. Q1-2024) for the scorecard evaluation — enables trend analysis across periods."
    - name: "performance_tier"
      expr: performance_tier
      comment: "Supplier performance tier classification (e.g. Gold, Silver, Bronze) — key segmentation dimension for strategic sourcing."
    - name: "corrective_action_flag"
      expr: corrective_action_flag
      comment: "Boolean flag indicating whether a corrective action is open for this supplier in this period — used to filter at-risk suppliers."
    - name: "review_status"
      expr: review_status
      comment: "Current review status of the scorecard (e.g. Approved, Pending) — used to filter finalized vs. in-progress evaluations."
    - name: "evaluation_period_start"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Month bucket of the evaluation period start date — enables monthly trend analysis."
    - name: "evaluation_period_end"
      expr: DATE_TRUNC('month', evaluation_period_end)
      comment: "Month bucket of the evaluation period end date — used to align scorecard windows."
    - name: "scoring_methodology_version"
      expr: scoring_methodology_version
      comment: "Version of the scoring methodology applied — ensures comparability when methodology changes."
  measures:
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score across evaluated periods. Primary KPI for supplier ranking and tier assignment decisions."
    - name: "avg_quality_ppm"
      expr: AVG(CAST(quality_ppm AS DOUBLE))
      comment: "Average quality defect rate in parts-per-million. Directly drives quality risk decisions and corrective action escalation."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage. Core supply reliability KPI used in quarterly business reviews and sourcing nominations."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average PPM defect rate from scorecard evaluations. Used to benchmark supplier quality against industry targets."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average regulatory and contractual compliance score. Informs risk management and supplier audit prioritization."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply risk score. Triggers risk mitigation actions and dual-sourcing decisions when elevated."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score. Used in ESG reporting and supplier selection for programs with sustainability mandates."
    - name: "avg_delivery_quantity_accuracy_pct"
      expr: AVG(CAST(delivery_quantity_accuracy_pct AS DOUBLE))
      comment: "Average delivery quantity accuracy percentage. Measures how precisely suppliers deliver the ordered quantity — impacts production scheduling."
    - name: "avg_ppap_on_time_completion_rate"
      expr: AVG(CAST(ppap_on_time_completion_rate AS DOUBLE))
      comment: "Average PPAP on-time completion rate. Indicates supplier readiness for new program launches — critical for SOP timing."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average supplier responsiveness score. Measures speed and quality of supplier communication — key for disruption management."
    - name: "avg_commodity_price_competitiveness_score"
      expr: AVG(CAST(commodity_price_competitiveness_score AS DOUBLE))
      comment: "Average commodity price competitiveness score. Used by procurement to benchmark pricing and negotiate cost reductions."
    - name: "count_corrective_actions_open"
      expr: COUNT(CASE WHEN corrective_action_flag = TRUE THEN supplier_scorecard_id END)
      comment: "Number of scorecards with open corrective actions. Tracks supplier quality escalation volume — drives supplier development resource allocation."
    - name: "count_evaluated_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers evaluated in the selected period. Measures scorecard coverage — ensures no strategic supplier is unreviewed."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order volume, value, and cycle metrics. Used by procurement and finance leadership to monitor spend, order flow, and supplier payment terms compliance."
  source: "`vibe_automotive_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier receiving the purchase order — primary dimension for spend-by-supplier analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Manufacturing plant issuing the purchase order — enables plant-level procurement spend analysis."
    - name: "po_status"
      expr: po_status
      comment: "Current status of the purchase order (e.g. Open, Closed, Cancelled) — used to filter active vs. completed spend."
    - name: "po_type"
      expr: po_type
      comment: "Type of purchase order (e.g. Standard, Blanket, Emergency) — enables spend categorization by procurement strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency of the purchase order — required for multi-currency spend reporting."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed on the PO (e.g. Net30, Net60) — used to analyze working capital and cash flow exposure."
    - name: "incoterms"
      expr: incoterms
      comment: "Incoterms governing delivery responsibility — used to analyze logistics cost allocation."
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month the purchase order was placed — enables monthly procurement spend trend analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month the delivery is due — used to align procurement commitments with production schedules."
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total purchase order spend value. Primary procurement spend KPI used in budget reviews and supplier spend analysis."
    - name: "avg_po_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average value per purchase order. Indicates order consolidation efficiency — low averages may signal fragmented ordering."
    - name: "count_purchase_orders"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Total number of distinct purchase orders issued. Measures procurement transaction volume and workload."
    - name: "count_active_purchase_orders"
      expr: COUNT(CASE WHEN po_status NOT IN ('Closed', 'Cancelled') THEN purchase_order_id END)
      comment: "Number of purchase orders in an active (non-closed, non-cancelled) state. Tracks open procurement commitments."
    - name: "count_distinct_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with purchase orders in the period. Measures supplier base breadth and concentration risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods receipt quality and acceptance metrics. Used by quality and supply chain leadership to monitor supplier delivery quality, rejection rates, and inspection outcomes."
  source: "`vibe_automotive_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier who shipped the goods — primary dimension for supplier quality analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Receiving plant — enables plant-level inbound quality analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Result of the goods inspection (e.g. Passed, Failed, Pending) — key quality gate dimension."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt — enables monthly inbound quality trend analysis."
    - name: "supplier_plant_id"
      expr: supplier_plant_id
      comment: "Specific supplier plant that shipped the goods — enables plant-level supplier quality differentiation."
  measures:
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity of parts received from suppliers. Baseline inbound volume measure for supply chain throughput analysis."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity of parts accepted after inspection. Measures effective inbound supply available for production."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of parts rejected at goods receipt. High rejection volumes signal supplier quality failures requiring corrective action."
    - name: "avg_acceptance_rate_pct"
      expr: AVG(CAST(accepted_quantity AS DOUBLE) / NULLIF(CAST(received_quantity AS DOUBLE), 0)) * 100
      comment: "Average acceptance rate as a percentage of received quantity per receipt. Core inbound quality KPI — low rates trigger supplier audits."
    - name: "avg_rejection_rate_pct"
      expr: AVG(CAST(rejected_quantity AS DOUBLE) / NULLIF(CAST(received_quantity AS DOUBLE), 0)) * 100
      comment: "Average rejection rate as a percentage of received quantity per receipt. Directly linked to supplier quality performance and production disruption risk."
    - name: "count_receipts"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Total number of goods receipts processed. Measures inbound logistics transaction volume."
    - name: "count_failed_inspections"
      expr: COUNT(CASE WHEN inspection_status = 'Failed' THEN goods_receipt_id END)
      comment: "Number of goods receipts that failed inspection. Tracks quality gate failures — drives supplier corrective action and escalation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence and quantity accuracy metrics. Used by supply chain and production planning leadership to monitor supplier on-time delivery performance and schedule compliance."
  source: "`vibe_automotive_v1`.`supply`.`delivery_schedule`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier responsible for the delivery — primary dimension for OTD performance by supplier."
    - name: "plant_id"
      expr: plant_id
      comment: "Receiving plant — enables plant-level delivery schedule adherence analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current status of the delivery (e.g. On-Time, Late, Partial) — key dimension for filtering delivery performance categories."
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of delivery schedule (e.g. JIT, Kanban, Standard) — enables analysis by replenishment strategy."
    - name: "scheduled_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month of the scheduled delivery — enables monthly delivery schedule adherence trending."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('month', actual_delivery_date)
      comment: "Month of the actual delivery — used to compare against scheduled month for lateness analysis."
  measures:
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery. Baseline supply commitment measure for production planning."
    - name: "total_actual_quantity"
      expr: SUM(CAST(actual_quantity AS DOUBLE))
      comment: "Total quantity actually delivered. Measures realized supply vs. planned supply — gaps signal production risk."
    - name: "avg_quantity_fulfillment_rate_pct"
      expr: AVG(CAST(actual_quantity AS DOUBLE) / NULLIF(CAST(scheduled_quantity AS DOUBLE), 0)) * 100
      comment: "Average delivery quantity fulfillment rate per schedule line. Measures how accurately suppliers deliver the scheduled quantity — critical for JIT production."
    - name: "count_on_time_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date <= scheduled_date THEN delivery_schedule_id END)
      comment: "Number of deliveries made on or before the scheduled date. Numerator for OTD rate calculation — core supplier reliability KPI."
    - name: "count_late_deliveries"
      expr: COUNT(CASE WHEN actual_delivery_date > scheduled_date THEN delivery_schedule_id END)
      comment: "Number of deliveries made after the scheduled date. Tracks supply disruption frequency — high counts trigger supplier escalation."
    - name: "count_total_scheduled_deliveries"
      expr: COUNT(DISTINCT delivery_schedule_id)
      comment: "Total number of scheduled delivery lines. Denominator for OTD rate and fulfillment rate calculations."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ pipeline, pricing competitiveness, and sourcing cycle metrics. Used by procurement and sourcing leadership to monitor quote activity, target price achievement, and supplier engagement."
  source: "`vibe_automotive_v1`.`supply`.`rfq`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier invited to respond to the RFQ — enables per-supplier sourcing activity analysis."
    - name: "rfq_status"
      expr: rfq_status
      comment: "Current status of the RFQ (e.g. Open, Awarded, Cancelled) — used to filter active vs. closed sourcing events."
    - name: "rfq_type"
      expr: rfq_type
      comment: "Type of RFQ (e.g. New Business, Resourcing, Cost Reduction) — enables analysis by sourcing strategy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the RFQ (e.g. Approved, Pending, Rejected) — tracks governance compliance in sourcing."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification of the part being sourced — enables spend category analysis."
    - name: "priority"
      expr: priority
      comment: "Priority level of the RFQ (e.g. Critical, High, Normal) — used to focus procurement resources on high-priority sourcing events."
    - name: "issue_month"
      expr: DATE_TRUNC('month', issue_timestamp)
      comment: "Month the RFQ was issued — enables monthly sourcing pipeline trend analysis."
    - name: "required_delivery_month"
      expr: DATE_TRUNC('month', required_delivery_date)
      comment: "Month the sourced part is required — used to align sourcing timelines with program launch schedules."
    - name: "tooling_required"
      expr: tooling_required
      comment: "Boolean flag indicating whether tooling investment is required — used to segment RFQs by capital commitment."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Boolean flag indicating whether regulatory approval is needed — used to identify compliance-sensitive sourcing events."
  measures:
    - name: "total_target_price_value"
      expr: SUM(CAST(target_price_amount AS DOUBLE))
      comment: "Total target price value across all RFQs. Measures the procurement savings target embedded in the sourcing pipeline."
    - name: "avg_target_price_amount"
      expr: AVG(CAST(target_price_amount AS DOUBLE))
      comment: "Average target price per RFQ. Used to benchmark sourcing ambition and compare against quoted prices."
    - name: "total_net_price_value"
      expr: SUM(CAST(net_price_amount AS DOUBLE))
      comment: "Total net price value across RFQs. Measures the actual quoted value in the sourcing pipeline."
    - name: "total_estimated_quantity"
      expr: SUM(CAST(quantity_estimate AS DOUBLE))
      comment: "Total estimated volume across RFQs. Used to size the sourcing pipeline and assess supplier capacity requirements."
    - name: "count_open_rfqs"
      expr: COUNT(CASE WHEN rfq_status = 'Open' THEN rfq_id END)
      comment: "Number of RFQs currently open. Measures active sourcing workload — used to manage procurement team capacity."
    - name: "count_total_rfqs"
      expr: COUNT(DISTINCT rfq_id)
      comment: "Total number of RFQs issued. Measures sourcing activity volume across the procurement pipeline."
    - name: "count_rfqs_requiring_tooling"
      expr: COUNT(CASE WHEN tooling_required = TRUE THEN rfq_id END)
      comment: "Number of RFQs requiring tooling investment. Used to forecast capital expenditure commitments in the sourcing pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_rfq_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFQ response competitiveness, pricing, and supplier engagement metrics. Used by procurement leadership to evaluate quote quality, price competitiveness, and supplier responsiveness in sourcing events."
  source: "`vibe_automotive_v1`.`supply`.`rfq_response`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier who submitted the RFQ response — primary dimension for supplier quote competitiveness analysis."
    - name: "rfq_id"
      expr: rfq_id
      comment: "RFQ this response belongs to — used to group competing quotes for the same sourcing event."
    - name: "rfq_response_status"
      expr: rfq_response_status
      comment: "Status of the RFQ response (e.g. Submitted, Awarded, Rejected) — used to filter awarded vs. competing quotes."
    - name: "quoted_currency"
      expr: quoted_currency
      comment: "Currency of the quoted price — required for multi-currency price comparison."
    - name: "shipping_method"
      expr: shipping_method
      comment: "Shipping method proposed by the supplier — used to analyze logistics cost trade-offs in sourcing decisions."
    - name: "is_preferred_supplier"
      expr: is_preferred_supplier
      comment: "Boolean flag indicating whether the responding supplier is on the preferred supplier list — used to track preferred vs. non-preferred quote activity."
    - name: "freight_included"
      expr: freight_included
      comment: "Boolean flag indicating whether freight is included in the quoted price — ensures price comparability."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month the RFQ response was submitted — enables monthly supplier responsiveness trend analysis."
  measures:
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price across responses. Core price competitiveness KPI — compared against target price to measure sourcing achievement."
    - name: "total_quoted_value"
      expr: SUM(CAST(total_price AS DOUBLE))
      comment: "Total quoted value across all RFQ responses. Measures the total commercial value in the sourcing pipeline."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered by suppliers. Measures supplier price flexibility — used in negotiation strategy."
    - name: "total_tooling_cost"
      expr: SUM(CAST(tooling_cost AS DOUBLE))
      comment: "Total tooling cost quoted across responses. Used to forecast capital investment required to award new business."
    - name: "avg_capacity_commitment"
      expr: AVG(CAST(capacity_commitment AS DOUBLE))
      comment: "Average capacity commitment offered by suppliers. Used to assess whether suppliers can meet volume requirements before award."
    - name: "count_responses"
      expr: COUNT(DISTINCT rfq_response_id)
      comment: "Total number of RFQ responses received. Measures supplier market engagement — low response rates signal sourcing risk."
    - name: "count_preferred_supplier_responses"
      expr: COUNT(CASE WHEN is_preferred_supplier = TRUE THEN rfq_response_id END)
      comment: "Number of responses from preferred suppliers. Tracks preferred supplier participation rate in sourcing events."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price agreement value, performance commitment, and compliance metrics. Used by procurement and finance leadership to monitor contracted pricing, annual price reduction commitments, and supplier performance against agreement targets."
  source: "`vibe_automotive_v1`.`supply`.`price_agreement`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier party to the price agreement — primary dimension for contracted spend analysis."
    - name: "price_agreement_status"
      expr: price_agreement_status
      comment: "Current status of the price agreement (e.g. Active, Expired, Terminated) — used to filter live vs. historical agreements."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (e.g. Long-Term, Spot, Annual) — enables analysis by contracting strategy."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price agreement — required for multi-currency contracted spend analysis."
    - name: "commodity_index_linked_flag"
      expr: commodity_index_linked_flag
      comment: "Boolean flag indicating whether the price is linked to a commodity index — used to identify price volatility exposure."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the agreement — used to identify agreements pending regulatory or legal sign-off."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms in the agreement — used for working capital and cash flow analysis."
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the price agreement became effective — enables cohort analysis of agreement vintages."
    - name: "effective_end_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the price agreement expires — used to identify upcoming contract renewals."
  measures:
    - name: "total_contracted_annual_volume_value"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total contracted annual volume across active price agreements. Measures the scale of committed supply — used in capacity planning and spend forecasting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price across agreements. Used to benchmark pricing levels and track year-over-year price evolution."
    - name: "total_annual_price_reduction_commitment"
      expr: SUM(CAST(annual_price_reduction_commitment AS DOUBLE))
      comment: "Total annual price reduction committed by suppliers across all agreements. Directly measures procurement cost-down pipeline — a primary procurement KPI."
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage recorded against price agreements. Measures supplier delivery performance relative to contractual commitments."
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target OTD percentage committed in price agreements. Used as the benchmark for actual OTD performance evaluation."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual PPM defect rate recorded against price agreements. Measures supplier quality performance relative to contractual quality commitments."
    - name: "avg_target_ppm"
      expr: AVG(CAST(target_ppm AS DOUBLE))
      comment: "Average target PPM committed in price agreements. Used as the quality benchmark for supplier performance evaluation."
    - name: "count_active_agreements"
      expr: COUNT(CASE WHEN price_agreement_status = 'Active' THEN price_agreement_id END)
      comment: "Number of currently active price agreements. Measures the breadth of contracted supply coverage."
    - name: "count_commodity_index_linked_agreements"
      expr: COUNT(CASE WHEN commodity_index_linked_flag = TRUE THEN price_agreement_id END)
      comment: "Number of price agreements linked to commodity indices. Quantifies commodity price volatility exposure in the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_scheduling_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling agreement volume, performance, and compliance metrics. Used by supply chain and procurement leadership to monitor long-term supply commitments, delivery rhythm adherence, and contract health."
  source: "`vibe_automotive_v1`.`supply`.`scheduling_agreement`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier party to the scheduling agreement — primary dimension for supply commitment analysis."
    - name: "plant_id"
      expr: plant_id
      comment: "Receiving plant — enables plant-level scheduling agreement coverage analysis."
    - name: "scheduling_agreement_status"
      expr: scheduling_agreement_status
      comment: "Current status of the scheduling agreement (e.g. Active, Expired, Terminated) — used to filter live supply commitments."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of scheduling agreement (e.g. Kanban, Standard, JIT) — enables analysis by replenishment strategy."
    - name: "delivery_rhythm"
      expr: delivery_rhythm
      comment: "Delivery frequency pattern (e.g. Daily, Weekly) — used to analyze supply chain cadence and logistics efficiency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the scheduling agreement — required for multi-currency contracted spend analysis."
    - name: "kanban_flag"
      expr: kanban_flag
      comment: "Boolean flag indicating whether the agreement uses Kanban replenishment — used to segment lean vs. traditional supply agreements."
    - name: "compliance_approval_status"
      expr: compliance_approval_status
      comment: "Compliance approval status of the agreement — used to identify agreements pending regulatory sign-off."
    - name: "start_month"
      expr: DATE_TRUNC('month', start_date)
      comment: "Month the scheduling agreement started — enables cohort analysis of agreement vintages."
    - name: "end_month"
      expr: DATE_TRUNC('month', end_date)
      comment: "Month the scheduling agreement expires — used to identify upcoming contract renewals and supply continuity risks."
  measures:
    - name: "total_contracted_annual_volume"
      expr: SUM(CAST(total_annual_volume AS DOUBLE))
      comment: "Total annual volume committed across scheduling agreements. Measures the scale of long-term supply commitments — used in capacity and production planning."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average contracted price per unit across scheduling agreements. Used to benchmark pricing and track cost evolution over agreement vintages."
    - name: "avg_actual_otd_percent"
      expr: AVG(CAST(actual_otd_percent AS DOUBLE))
      comment: "Average actual on-time delivery percentage across scheduling agreements. Measures supplier delivery reliability against long-term supply commitments."
    - name: "avg_target_otd_percent"
      expr: AVG(CAST(target_otd_percent AS DOUBLE))
      comment: "Average target OTD percentage committed in scheduling agreements. Benchmark for evaluating actual delivery performance."
    - name: "avg_actual_ppm"
      expr: AVG(CAST(actual_ppm AS DOUBLE))
      comment: "Average actual PPM defect rate across scheduling agreements. Measures supplier quality performance against long-term quality commitments."
    - name: "count_active_agreements"
      expr: COUNT(CASE WHEN scheduling_agreement_status = 'Active' THEN scheduling_agreement_id END)
      comment: "Number of currently active scheduling agreements. Measures the breadth of long-term supply coverage — gaps indicate sourcing risk."
    - name: "count_kanban_agreements"
      expr: COUNT(CASE WHEN kanban_flag = TRUE THEN scheduling_agreement_id END)
      comment: "Number of scheduling agreements using Kanban replenishment. Measures lean supply chain adoption across the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_ppap_submission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PPAP submission status, approval cycle, and supplier readiness metrics. Used by quality and program management leadership to monitor supplier part approval readiness for new program launches and engineering changes."
  source: "`vibe_automotive_v1`.`supply`.`ppap_submission`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier submitting the PPAP — primary dimension for supplier launch readiness analysis."
    - name: "receiving_plant_id"
      expr: receiving_plant_id
      comment: "Plant receiving the PPAP submission — enables plant-level launch readiness tracking."
    - name: "submission_status"
      expr: submission_status
      comment: "Current status of the PPAP submission (e.g. Submitted, Approved, Rejected) — key dimension for launch readiness gating."
    - name: "disposition"
      expr: disposition
      comment: "Final disposition of the PPAP (e.g. Full Approval, Interim Approval, Rejected) — used to classify supplier readiness outcomes."
    - name: "submission_level"
      expr: submission_level
      comment: "PPAP submission level (1-5 per AIAG standard) — indicates the depth of documentation required and provided."
    - name: "reason_for_submission"
      expr: reason_for_submission
      comment: "Reason triggering the PPAP (e.g. New Part, Engineering Change, Tooling Change) — used to analyze PPAP volume by trigger type."
    - name: "supplier_plant_id"
      expr: supplier_plant_id
      comment: "Supplier plant submitting the PPAP — enables plant-level supplier readiness differentiation."
    - name: "submission_month"
      expr: DATE_TRUNC('month', submission_date)
      comment: "Month the PPAP was submitted — enables monthly PPAP pipeline trend analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the PPAP was approved — used to measure approval cycle time and track launch readiness milestones."
  measures:
    - name: "count_total_submissions"
      expr: COUNT(DISTINCT ppap_submission_id)
      comment: "Total number of PPAP submissions. Measures supplier launch readiness activity volume across the program portfolio."
    - name: "count_approved_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Approved' THEN ppap_submission_id END)
      comment: "Number of PPAP submissions with full approval. Measures supplier readiness achievement — directly gates production launch."
    - name: "count_rejected_submissions"
      expr: COUNT(CASE WHEN submission_status = 'Rejected' THEN ppap_submission_id END)
      comment: "Number of PPAP submissions rejected. High rejection counts signal supplier quality system deficiencies and launch risk."
    - name: "count_pending_submissions"
      expr: COUNT(CASE WHEN submission_status NOT IN ('Approved', 'Rejected') THEN ppap_submission_id END)
      comment: "Number of PPAP submissions still pending disposition. Measures open launch readiness risk — critical for program timing."
    - name: "count_distinct_suppliers_with_ppap"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with PPAP submissions. Measures the breadth of supplier launch readiness activity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_sourcing_nomination`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing nomination pipeline, volume commitment, and strategic sourcing metrics. Used by procurement and program management leadership to monitor supplier nominations, target pricing, and sourcing strategy execution."
  source: "`vibe_automotive_v1`.`supply`.`sourcing_nomination`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Nominated supplier — primary dimension for sourcing nomination analysis by supplier."
    - name: "nomination_status"
      expr: nomination_status
      comment: "Current status of the sourcing nomination (e.g. Nominated, Awarded, Cancelled) — used to track sourcing pipeline progression."
    - name: "commodity"
      expr: commodity
      comment: "Commodity category of the nominated part — enables spend category analysis in the sourcing pipeline."
    - name: "region"
      expr: region
      comment: "Geographic region of the sourcing nomination — used to analyze regional supply base strategy and risk concentration."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the sourcing nomination (e.g. High, Medium, Low) — used to prioritize risk mitigation in the sourcing pipeline."
    - name: "priority"
      expr: priority
      comment: "Priority level of the nomination — used to focus sourcing resources on critical program requirements."
    - name: "is_jit"
      expr: is_jit
      comment: "Boolean flag indicating JIT delivery requirement — used to segment nominations by supply chain strategy."
    - name: "is_jis"
      expr: is_jis
      comment: "Boolean flag indicating JIS (Just-In-Sequence) delivery requirement — used to identify high-complexity supply arrangements."
    - name: "model_year"
      expr: model_year
      comment: "Vehicle model year associated with the nomination — enables program-year cohort analysis."
    - name: "nomination_month"
      expr: DATE_TRUNC('month', nomination_date)
      comment: "Month the sourcing nomination was issued — enables monthly sourcing pipeline trend analysis."
  measures:
    - name: "total_nominated_volume"
      expr: SUM(CAST(nominated_volume AS DOUBLE))
      comment: "Total volume nominated across sourcing nominations. Measures the scale of supply commitments in the sourcing pipeline — used in capacity planning."
    - name: "total_target_piece_price_value"
      expr: SUM(CAST(target_piece_price AS DOUBLE))
      comment: "Total target piece price value across nominations. Measures the procurement cost target embedded in the sourcing pipeline."
    - name: "avg_target_piece_price"
      expr: AVG(CAST(target_piece_price AS DOUBLE))
      comment: "Average target piece price per nomination. Used to benchmark sourcing price ambition and compare against awarded prices."
    - name: "count_active_nominations"
      expr: COUNT(CASE WHEN nomination_status NOT IN ('Cancelled', 'Closed') THEN sourcing_nomination_id END)
      comment: "Number of active sourcing nominations. Measures the live sourcing pipeline — used to manage procurement workload and program coverage."
    - name: "count_high_risk_nominations"
      expr: COUNT(CASE WHEN risk_rating = 'High' THEN sourcing_nomination_id END)
      comment: "Number of sourcing nominations rated as high risk. Tracks supply risk concentration — triggers dual-sourcing or risk mitigation actions."
    - name: "count_jit_nominations"
      expr: COUNT(CASE WHEN is_jit = TRUE THEN sourcing_nomination_id END)
      comment: "Number of nominations requiring JIT delivery. Measures the complexity and operational risk of the supply base — JIT failures directly stop production."
    - name: "count_distinct_nominated_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers nominated. Measures supply base breadth and concentration — low counts signal single-source risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier master metrics covering supply base composition, tier structure, and onboarding. Used by procurement leadership to monitor supply base health, diversity, and strategic supplier coverage."
  source: "`vibe_automotive_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Type of supplier (e.g. Tier 1, Tier 2, Direct, Indirect) — primary segmentation dimension for supply base analysis."
    - name: "tier_level"
      expr: tier_level
      comment: "Tier level of the supplier in the supply chain hierarchy — used to analyze supply chain depth and risk exposure."
    - name: "country_code"
      expr: country_code
      comment: "Country of the supplier — used to analyze geographic supply base concentration and geopolitical risk."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating of the supplier (e.g. A, B, C) — used to segment the supply base by quality performance."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the supplier is currently active — used to filter the active supply base."
    - name: "onboarding_year"
      expr: DATE_TRUNC('year', onboarding_date)
      comment: "Year the supplier was onboarded — enables supply base vintage analysis and onboarding trend tracking."
  measures:
    - name: "count_active_suppliers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN supplier_id END)
      comment: "Number of currently active suppliers. Measures the size of the active supply base — used in supply base rationalization decisions."
    - name: "count_total_suppliers"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Total number of suppliers in the master. Measures overall supply base breadth including inactive suppliers."
    - name: "count_suppliers_by_country"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN supplier_id END)
      comment: "Number of active suppliers — when grouped by country_code dimension, reveals geographic supply concentration and single-country dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Purchase order line-level spend, quantity, and fulfillment metrics. Used by procurement and finance leadership to monitor line-level spend accuracy, goods receipt fulfillment, and pricing compliance."
  source: "`vibe_automotive_v1`.`supply`.`po_line`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Supplier on the PO line — enables per-supplier line-level spend analysis."
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line (e.g. Open, Closed, Partially Received) — used to filter active vs. completed line items."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity — used to ensure comparability in quantity analysis."
    - name: "delivery_month"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Month the PO line is due for delivery — enables monthly procurement commitment analysis."
  measures:
    - name: "total_po_line_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount across all PO lines. Measures line-level procurement spend — used for spend analytics and budget reconciliation."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity ordered across PO lines. Measures procurement volume commitments."
    - name: "total_goods_receipt_quantity"
      expr: SUM(CAST(goods_receipt_quantity AS DOUBLE))
      comment: "Total quantity received against PO lines. Measures actual supply fulfillment vs. ordered quantity."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price across PO lines. Used to benchmark pricing against price agreements and detect pricing anomalies."
    - name: "avg_fulfillment_rate_pct"
      expr: AVG(CAST(goods_receipt_quantity AS DOUBLE) / NULLIF(CAST(quantity AS DOUBLE), 0)) * 100
      comment: "Average goods receipt fulfillment rate per PO line. Measures how completely suppliers fulfill ordered quantities — low rates signal supply shortages."
$$;