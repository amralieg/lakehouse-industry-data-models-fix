-- Metric views for domain: procurement | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for purchase order volume, value, approval status, and supplier concentration — core procurement steering metrics for CPO and VP Procurement dashboards."
  source: "`vibe_automotive_v1`.`procurement`.`procurement_purchase_order`"
  dimensions:
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type (standard, blanket, consignment, etc.) for spend segmentation."
    - name: "po_status"
      expr: procurement_purchase_order_status
      comment: "Current lifecycle status of the purchase order (open, closed, cancelled, blocked)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — used to identify bottlenecks in the PO approval pipeline."
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing org code for regional or entity-level spend analysis."
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group responsible for the order — supports buyer performance analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (EXW, DDP, FOB, etc.) for logistics cost attribution."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms agreed with supplier — used for cash flow and DPO analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of PO creation for trend and seasonality analysis."
    - name: "order_year"
      expr: YEAR(order_date)
      comment: "Fiscal year of PO creation for annual spend reporting."
  measures:
    - name: "total_po_count"
      expr: COUNT(1)
      comment: "Total number of purchase orders — baseline volume metric for procurement throughput."
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross spend committed across all purchase orders — primary procurement spend KPI."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend (after discounts) — used for actual cost tracking and budget variance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax liability across purchase orders — supports tax reporting and compliance."
    - name: "avg_po_value"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per purchase order — signals procurement complexity and consolidation opportunities."
    - name: "pending_approval_po_count"
      expr: COUNT(CASE WHEN approval_status NOT IN ('APPROVED','REJECTED','CANCELLED') THEN 1 END)
      comment: "Number of POs awaiting approval — identifies approval pipeline bottlenecks impacting supply continuity."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers receiving POs — measures supplier base breadth and concentration risk."
    - name: "total_quantity_ordered"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total units ordered across all POs — supports demand and inventory planning."
    - name: "avg_days_to_delivery"
      expr: AVG(DATEDIFF(delivery_date, order_date))
      comment: "Average lead time from PO creation to expected delivery — key supplier performance and supply chain risk indicator."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable and invoice processing KPIs — tracks invoice volumes, payment performance, three-way match rates, and tax exposure for CFO and AP operations."
  source: "`vibe_automotive_v1`.`procurement`.`supplier_invoice`"
  dimensions:
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current invoice processing status (open, paid, blocked, disputed)."
    - name: "invoice_type"
      expr: invoice_type
      comment: "Invoice type (standard, credit memo, debit memo) for AP categorization."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment execution status — used to track outstanding liabilities."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (wire, ACH, check) for treasury and cash management analysis."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Agreed payment terms — used for DPO calculation and early payment discount analysis."
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match result (matched, unmatched, partial) — critical for invoice automation and fraud prevention."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency AP reporting."
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date for AP aging and cash flow trend analysis."
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of accounting posting for period-close accuracy."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual AP and spend reporting."
    - name: "e_invoice_flag"
      expr: e_invoice_flag
      comment: "Whether invoice was received electronically — measures e-invoicing adoption rate."
  measures:
    - name: "total_invoice_count"
      expr: COUNT(1)
      comment: "Total number of supplier invoices processed — baseline AP throughput metric."
    - name: "total_gross_invoiced"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross invoiced amount — primary AP liability metric for cash flow planning."
    - name: "total_net_invoiced"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net invoiced amount after discounts — actual AP obligation."
    - name: "total_tax_invoiced"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on invoices — supports VAT/GST reclaim and tax compliance reporting."
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total early payment or volume discounts captured — measures working capital optimization."
    - name: "avg_invoice_value"
      expr: AVG(CAST(gross_amount AS DOUBLE))
      comment: "Average invoice value — used to benchmark invoice complexity and processing cost per invoice."
    - name: "three_way_match_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN three_way_match_status = 'MATCHED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices with successful three-way match — key AP automation and compliance KPI; low rates signal process or data quality issues."
    - name: "e_invoice_adoption_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN e_invoice_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of invoices received electronically — measures digitization progress and processing cost reduction."
    - name: "blocked_invoice_count"
      expr: COUNT(CASE WHEN invoice_status = 'BLOCKED' THEN 1 END)
      comment: "Number of blocked invoices — operational KPI for AP exception management and supplier relationship risk."
    - name: "avg_days_to_due"
      expr: AVG(DATEDIFF(due_date, invoice_date))
      comment: "Average days from invoice date to due date — proxy for effective payment terms and DPO management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_spend_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Granular spend analytics KPIs — the primary source for spend cube analysis, category management, and savings tracking used by CPO, category managers, and finance."
  source: "`vibe_automotive_v1`.`procurement`.`spend_transaction`"
  dimensions:
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the spend transaction (posted, pending, reversed) for spend accuracy."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the spend transaction — used to separate committed vs. approved spend."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity classification code for category-level spend analysis."
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center for departmental spend allocation and budget variance reporting."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for annual spend budget vs. actuals reporting."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for monthly spend tracking and period-close reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend normalization."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms on the transaction — used for DPO and working capital analysis."
    - name: "is_service_line"
      expr: is_service_line
      comment: "Distinguishes goods vs. services spend — critical for indirect spend and SRM strategy."
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of spend transaction for trend and run-rate analysis."
    - name: "project_code"
      expr: project_code
      comment: "Project code for project-based spend tracking and CAPEX/OPEX classification."
  measures:
    - name: "total_spend_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total spend amount across all transactions — the primary spend cube KPI for category management."
    - name: "total_net_spend"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net spend after tax — used for budget vs. actuals and savings baseline calculations."
    - name: "total_gross_spend"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross spend including tax — used for total cost of ownership and AP liability reporting."
    - name: "total_tax_spend"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of spend — supports tax reclaim and compliance reporting."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers in spend — measures supplier base concentration and rationalization opportunity."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of spend transactions — used to compute average transaction value and processing cost."
    - name: "avg_transaction_value"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average spend per transaction — low values signal maverick or tail spend requiring consolidation."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity purchased — supports volume-based pricing negotiation and demand planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid — benchmarked against target prices to measure price compliance and savings."
    - name: "blocked_spend_amount"
      expr: SUM(CASE WHEN is_blocked = TRUE THEN amount ELSE 0 END)
      comment: "Total spend amount on blocked transactions — identifies AP holds impacting supplier payments and supply continuity."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_evaluation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard KPIs — tracks quality, delivery, cost, and overall supplier scores to drive SRM decisions, development plans, and sourcing strategy."
  source: "`vibe_automotive_v1`.`procurement`.`supplier_evaluation`"
  dimensions:
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Type of evaluation (annual review, incident-triggered, PPAP, etc.) for performance segmentation."
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the evaluation (draft, completed, approved) for pipeline tracking."
    - name: "supplier_category"
      expr: supplier_category
      comment: "Supplier category (strategic, preferred, approved, conditional) for tiered SRM analysis."
    - name: "supplier_region"
      expr: supplier_region
      comment: "Geographic region of the supplier — used for regional supply risk and performance benchmarking."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level (low, medium, high, critical) — drives escalation and development plan triggers."
    - name: "recommended_action"
      expr: recommended_action
      comment: "Recommended action from evaluation (maintain, develop, phase-out, disqualify) — key SRM decision output."
    - name: "evaluation_period"
      expr: evaluation_period
      comment: "Evaluation period (e.g., Q1-2024) for trend analysis across periods."
    - name: "evaluation_month"
      expr: DATE_TRUNC('MONTH', evaluation_date)
      comment: "Month of evaluation for temporal performance trend analysis."
  measures:
    - name: "evaluated_supplier_count"
      expr: COUNT(DISTINCT procurement_supplier_id)
      comment: "Number of unique suppliers evaluated — measures SRM program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score — primary SRM KPI for executive supplier health dashboards."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across evaluated suppliers — drives quality development investment decisions."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score — signals supply chain reliability and logistics risk."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score — used in sourcing strategy and renegotiation decisions."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across suppliers — key supply chain KPI for production continuity."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate — critical quality KPI for incoming material quality management."
    - name: "avg_invoice_accuracy_pct"
      expr: AVG(CAST(invoice_accuracy_pct AS DOUBLE))
      comment: "Average invoice accuracy percentage — measures AP process efficiency and supplier billing compliance."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_level IN ('HIGH', 'CRITICAL') THEN 1 END)
      comment: "Number of suppliers rated high or critical risk — executive KPI for supply chain risk exposure requiring immediate action."
    - name: "avg_price_variance_pct"
      expr: AVG(CAST(price_variance_pct AS DOUBLE))
      comment: "Average price variance percentage vs. target — measures procurement price discipline and contract compliance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_savings_initiative`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement savings pipeline and realization KPIs — tracks target vs. actual savings, initiative types, and delivery rates for CPO savings reporting and category strategy."
  source: "`vibe_automotive_v1`.`procurement`.`savings_initiative`"
  dimensions:
    - name: "initiative_type"
      expr: initiative_type
      comment: "Type of savings initiative (price reduction, demand management, specification change, etc.) for savings strategy analysis."
    - name: "initiative_status"
      expr: savings_initiative_status
      comment: "Current status of the savings initiative (pipeline, approved, realized, cancelled) for pipeline management."
    - name: "commodity"
      expr: commodity
      comment: "Commodity or spend category for savings attribution and category management reporting."
    - name: "region_code"
      expr: region_code
      comment: "Geographic region for regional savings performance benchmarking."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or site for site-level savings tracking."
    - name: "program_year"
      expr: program_year
      comment: "Program year for annual savings target vs. actuals reporting."
    - name: "savings_validation_method"
      expr: savings_validation_method
      comment: "Method used to validate savings (finance-validated, self-reported, audited) — affects savings credibility scoring."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month savings initiative became effective — for run-rate and timing analysis."
  measures:
    - name: "total_target_savings"
      expr: SUM(CAST(target_savings_amount AS DOUBLE))
      comment: "Total targeted savings across all initiatives — primary procurement savings pipeline KPI for CPO target-setting."
    - name: "total_actual_savings"
      expr: SUM(CAST(actual_savings_amount AS DOUBLE))
      comment: "Total realized savings — the definitive savings delivery KPI used in executive and board reporting."
    - name: "total_baseline_spend"
      expr: SUM(CAST(baseline_spend AS DOUBLE))
      comment: "Total baseline spend against which savings are measured — required for savings rate calculation."
    - name: "savings_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_savings_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of targeted savings actually realized — the key procurement delivery effectiveness KPI; below 80% triggers executive review."
    - name: "savings_as_pct_of_baseline"
      expr: ROUND(100.0 * SUM(CAST(actual_savings_amount AS DOUBLE)) / NULLIF(SUM(CAST(baseline_spend AS DOUBLE)), 0), 2)
      comment: "Actual savings as a percentage of baseline spend — normalizes savings performance across categories and regions."
    - name: "initiative_count"
      expr: COUNT(1)
      comment: "Total number of savings initiatives — measures procurement team activity and pipeline breadth."
    - name: "avg_savings_per_initiative"
      expr: AVG(CAST(actual_savings_amount AS DOUBLE))
      comment: "Average realized savings per initiative — used to prioritize high-value initiatives and resource allocation."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_sourcing_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic sourcing pipeline KPIs — tracks RFx events, award values, evaluation scores, and sourcing strategy execution for category managers and CPO."
  source: "`vibe_automotive_v1`.`procurement`.`sourcing_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of sourcing event (RFI, RFQ, RFP, e-auction) for sourcing strategy analysis."
    - name: "sourcing_event_status"
      expr: sourcing_event_status
      comment: "Current status of the sourcing event (draft, active, awarded, cancelled) for pipeline management."
    - name: "sourcing_strategy"
      expr: sourcing_strategy
      comment: "Sourcing strategy applied (single source, dual source, competitive bid) — key strategic procurement dimension."
    - name: "commodity_group"
      expr: commodity_group
      comment: "Commodity group for category-level sourcing activity analysis."
    - name: "buyer_department"
      expr: buyer_department
      comment: "Buying department for workload and performance analysis by procurement team."
    - name: "is_multi_source"
      expr: is_multi_source
      comment: "Whether the event resulted in multi-source award — measures supply risk diversification."
    - name: "evaluation_method"
      expr: evaluation_method
      comment: "Evaluation methodology (total cost, weighted criteria, price-only) for sourcing quality assessment."
    - name: "award_month"
      expr: DATE_TRUNC('MONTH', award_decision_date)
      comment: "Month of award decision for sourcing cycle time and pipeline throughput analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the sourcing event for multi-currency award value reporting."
  measures:
    - name: "total_sourcing_events"
      expr: COUNT(1)
      comment: "Total number of sourcing events — measures strategic sourcing activity volume and team throughput."
    - name: "total_award_value"
      expr: SUM(CAST(award_amount AS DOUBLE))
      comment: "Total value of awarded sourcing events — primary strategic sourcing value KPI for CPO reporting."
    - name: "total_target_spend"
      expr: SUM(CAST(target_spend_amount AS DOUBLE))
      comment: "Total spend under management in sourcing events — measures procurement coverage of addressable spend."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average supplier evaluation score across sourcing events — measures quality of sourcing decisions."
    - name: "award_vs_target_ratio"
      expr: ROUND(100.0 * SUM(CAST(award_amount AS DOUBLE)) / NULLIF(SUM(CAST(target_spend_amount AS DOUBLE)), 0), 2)
      comment: "Award value as percentage of target spend — measures sourcing efficiency and negotiation outcome vs. plan."
    - name: "avg_days_to_award"
      expr: AVG(DATEDIFF(award_decision_date, submission_deadline))
      comment: "Average days from submission deadline to award decision — measures sourcing cycle time efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incoming quality and supplier nonconformance KPIs — tracks defect rates, rejection volumes, corrective action closure, and PPM performance for quality and procurement leadership."
  source: "`vibe_automotive_v1`.`procurement`.`supplier_nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance record (open, under review, closed) for exception management."
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance (critical, major, minor) for risk prioritization."
    - name: "defect_code"
      expr: defect_code
      comment: "Defect classification code for Pareto analysis of top defect types."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category (design, process, material, logistics) for systemic quality improvement."
    - name: "detection_point"
      expr: detection_point
      comment: "Where the defect was detected (incoming inspection, line, customer) — measures detection effectiveness."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective action (open, in-progress, verified, closed) for 8D closure tracking."
    - name: "closure_status"
      expr: closure_status
      comment: "Overall closure status of the NCR — used for open NCR aging analysis."
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_date)
      comment: "Month of defect detection for trend analysis and quality performance reporting."
  measures:
    - name: "total_ncr_count"
      expr: COUNT(1)
      comment: "Total number of supplier nonconformance records — baseline incoming quality KPI."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity of parts rejected — measures incoming quality impact on production supply."
    - name: "total_inspected_quantity"
      expr: SUM(CAST(total_inspected_quantity AS DOUBLE))
      comment: "Total quantity inspected — denominator for rejection rate and PPM calculations."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rejected_quantity AS DOUBLE)) / NULLIF(SUM(CAST(total_inspected_quantity AS DOUBLE)), 0), 4)
      comment: "Percentage of inspected parts rejected — key incoming quality KPI; high rates trigger supplier development actions."
    - name: "avg_ppm_count"
      expr: AVG(CAST(ppm_count AS DOUBLE))
      comment: "Average PPM defect count per supplier NCR — industry-standard quality metric for supplier scorecards."
    - name: "open_ncr_count"
      expr: COUNT(CASE WHEN closure_status NOT IN ('CLOSED', 'CANCELLED') THEN 1 END)
      comment: "Number of open nonconformance records — operational KPI for quality exception backlog management."
    - name: "corrective_action_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN corrective_action_status = 'CLOSED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NCRs with closed corrective actions — measures supplier responsiveness and quality system effectiveness."
    - name: "critical_ncr_count"
      expr: COUNT(CASE WHEN severity = 'CRITICAL' THEN 1 END)
      comment: "Number of critical severity nonconformances — executive escalation KPI for supply quality risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence and on-time delivery KPIs — measures supplier delivery performance against committed schedules, critical for production continuity and JIT supply."
  source: "`vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status (scheduled, in-transit, delivered, overdue) for supply chain visibility."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Schedule line status for delivery commitment tracking."
    - name: "delivery_priority"
      expr: delivery_priority
      comment: "Delivery priority level — used to focus expediting efforts on critical supply lines."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Boolean flag indicating on-time delivery — primary dimension for OTD rate calculation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_delivery_date)
      comment: "Month of scheduled delivery for supply plan adherence trend analysis."
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_delivery_date)
      comment: "Month of requested delivery for demand vs. supply alignment analysis."
  measures:
    - name: "total_schedule_lines"
      expr: COUNT(1)
      comment: "Total number of delivery schedule lines — baseline supply schedule volume metric."
    - name: "total_scheduled_quantity"
      expr: SUM(CAST(scheduled_quantity AS DOUBLE))
      comment: "Total quantity scheduled for delivery — used for supply plan coverage and production readiness."
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total quantity actually delivered — measures supply fulfillment against schedule."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total open (undelivered) quantity — measures supply shortfall risk to production."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_time_delivery_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of schedule lines delivered on time — the primary supplier delivery performance KPI for production continuity."
    - name: "delivery_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(delivered_quantity AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_quantity AS DOUBLE)), 0), 2)
      comment: "Delivered quantity as percentage of scheduled quantity — measures supply completeness and JIT adherence."
    - name: "avg_confirmed_vs_requested_days"
      expr: AVG(DATEDIFF(confirmed_delivery_date, requested_delivery_date))
      comment: "Average days difference between confirmed and requested delivery dates — measures supplier schedule flexibility and responsiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract portfolio KPIs — tracks contract values, expiry risk, renewal rates, and coverage for legal, procurement, and finance leadership."
  source: "`vibe_automotive_v1`.`procurement`.`supplier_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated, draft) for portfolio health monitoring."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (framework, call-off, blanket, spot) for contract strategy analysis."
    - name: "contract_category"
      expr: contract_category
      comment: "Spend category of the contract for category management coverage analysis."
    - name: "is_master_agreement"
      expr: is_master_agreement
      comment: "Whether the contract is a master agreement — used to distinguish strategic from transactional contracts."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for working capital and DPO analysis."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction for legal risk and compliance analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year contract became effective for vintage analysis."
    - name: "effective_end_month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
      comment: "Month of contract expiry for renewal pipeline and expiry risk management."
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of supplier contracts — measures contract portfolio size and coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total committed contract value — primary contract portfolio KPI for spend under contract reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value — used to benchmark contract size and identify consolidation opportunities."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN DATEDIFF(effective_end_date, CURRENT_DATE()) BETWEEN 0 AND 90 AND contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active contracts expiring within 90 days — critical risk KPI for contract renewal pipeline management."
    - name: "expiring_within_90_days_value"
      expr: SUM(CASE WHEN DATEDIFF(effective_end_date, CURRENT_DATE()) BETWEEN 0 AND 90 AND contract_status = 'ACTIVE' THEN total_contract_value ELSE 0 END)
      comment: "Total value of contracts expiring within 90 days — financial exposure from contract renewal risk."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'ACTIVE' THEN 1 END)
      comment: "Number of currently active contracts — measures effective contract coverage of supply base."
    - name: "renewal_option_count"
      expr: COUNT(CASE WHEN renewal_option IS NOT NULL AND renewal_option != '' THEN 1 END)
      comment: "Number of contracts with renewal options — measures flexibility in contract portfolio for continuity planning."
    - name: "avg_volume_commitment"
      expr: AVG(CAST(volume_commitment_quantity AS DOUBLE))
      comment: "Average volume commitment per contract — used for supply security and demand planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_eprocurement_portal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "E-procurement platform adoption and capability KPIs — measures digital procurement maturity, supplier onboarding, and platform utilization per VREQ-022 e-procurement portal coverage requirement."
  source: "`vibe_automotive_v1`.`procurement`.`eprocurement_portal`"
  dimensions:
    - name: "portal_status"
      expr: portal_status
      comment: "Operational status of the portal (active, decommissioned, pilot) for platform portfolio management."
    - name: "portal_type"
      expr: portal_type
      comment: "Type of portal (Ariba, Covisint, SupplyOn, custom) for platform strategy analysis."
    - name: "platform_provider"
      expr: platform_provider
      comment: "Technology provider of the e-procurement platform — used for vendor management and license cost analysis."
    - name: "deployment_model"
      expr: deployment_model
      comment: "Deployment model (cloud, on-premise, hybrid) for IT architecture and cost analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic coverage of the portal for regional procurement digitization tracking."
    - name: "erp_system_code"
      expr: erp_system_code
      comment: "Integrated ERP system (SAP, Oracle, etc.) for integration landscape analysis."
    - name: "gdpr_compliant_flag"
      expr: gdpr_compliant_flag
      comment: "GDPR compliance status of the portal — mandatory for EU procurement operations."
    - name: "go_live_year"
      expr: YEAR(go_live_date)
      comment: "Year the portal went live for platform maturity and adoption cohort analysis."
  measures:
    - name: "active_portal_count"
      expr: COUNT(CASE WHEN portal_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active e-procurement portals — measures digital procurement platform footprint."
    - name: "total_annual_license_cost"
      expr: SUM(CAST(annual_license_cost AS DOUBLE))
      comment: "Total annual license cost across all portals — key IT spend KPI for procurement technology ROI analysis."
    - name: "total_annual_spend_limit"
      expr: SUM(CAST(annual_spend_limit AS DOUBLE))
      comment: "Total spend capacity across all portals — measures e-procurement platform coverage of total addressable spend."
    - name: "avg_uptime_sla_pct"
      expr: AVG(CAST(uptime_sla_percent AS DOUBLE))
      comment: "Average uptime SLA across portals — measures platform reliability for procurement operations."
    - name: "supplier_onboarding_enabled_count"
      expr: COUNT(CASE WHEN supplier_onboarding_flag = TRUE THEN 1 END)
      comment: "Number of portals with supplier onboarding enabled — measures digital supplier collaboration capability."
    - name: "three_way_match_enabled_count"
      expr: COUNT(CASE WHEN three_way_match_flag = TRUE THEN 1 END)
      comment: "Number of portals with automated three-way match — measures AP automation maturity."
    - name: "avg_max_po_value"
      expr: AVG(CAST(max_po_value AS DOUBLE))
      comment: "Average maximum PO value threshold per portal — used for procurement authority and delegation analysis."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_spend_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spend category taxonomy and strategic coverage KPIs — measures category management maturity, direct vs. indirect split, and strategic category coverage per VREQ-022 commodity management requirement."
  source: "`vibe_automotive_v1`.`procurement`.`spend_category`"
  dimensions:
    - name: "category_type"
      expr: spend_category_type
      comment: "Type of spend category (direct, indirect, services, capex) for spend portfolio segmentation."
    - name: "category_status"
      expr: spend_category_status
      comment: "Status of the category (active, inactive, under review) for taxonomy governance."
    - name: "direct_indirect_flag"
      expr: direct_indirect_flag
      comment: "Boolean flag distinguishing direct (production) from indirect spend categories — fundamental procurement segmentation."
    - name: "strategic_flag"
      expr: strategic_flag
      comment: "Whether the category is designated as strategic — used to prioritize category management resources."
    - name: "commodity_group"
      expr: commodity_group
      comment: "Commodity group for commodity management and hedging strategy analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the category hierarchy (L1, L2, L3) for taxonomy depth analysis."
    - name: "scope"
      expr: scope
      comment: "Geographic or organizational scope of the category for global vs. regional category management."
    - name: "is_leaf"
      expr: is_leaf
      comment: "Whether the category is a leaf node in the taxonomy — used to identify actionable spend buckets."
  measures:
    - name: "total_category_count"
      expr: COUNT(1)
      comment: "Total number of spend categories — measures taxonomy breadth and granularity."
    - name: "active_category_count"
      expr: COUNT(CASE WHEN spend_category_status = 'ACTIVE' THEN 1 END)
      comment: "Number of active spend categories — measures effective taxonomy coverage for spend classification."
    - name: "strategic_category_count"
      expr: COUNT(CASE WHEN strategic_flag = TRUE THEN 1 END)
      comment: "Number of strategically managed categories — measures category management program scope and maturity."
    - name: "direct_category_count"
      expr: COUNT(CASE WHEN direct_indirect_flag = TRUE THEN 1 END)
      comment: "Number of direct spend categories — used to assess production material category coverage."
    - name: "leaf_category_count"
      expr: COUNT(CASE WHEN is_leaf = TRUE THEN 1 END)
      comment: "Number of leaf-level categories — measures taxonomy actionability for spend analysis."
    - name: "avg_sourcing_strategy_score"
      expr: AVG(CAST(sourcing_strategy AS DOUBLE))
      comment: "Average sourcing strategy score across categories — measures strategic sourcing maturity across the spend portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_supplier_regulatory_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier regulatory compliance KPIs — tracks certification status, expiry risk, and compliance gaps across the supply base for compliance, legal, and procurement leadership."
  source: "`vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (compliant, non-compliant, pending, expired) for risk monitoring."
    - name: "compliance_type"
      expr: compliance_type
      comment: "Type of compliance requirement (REACH, RoHS, conflict minerals, GDPR, etc.) for regulatory coverage analysis."
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category (environmental, safety, data privacy, trade) for risk domain segmentation."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Regulatory jurisdiction (EU, US, China, etc.) for geographic compliance risk analysis."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean compliance flag — primary dimension for compliant vs. non-compliant supplier segmentation."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Regulatory body issuing the compliance requirement — used for authority-level compliance tracking."
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of certification expiry for renewal pipeline management."
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of compliance assessment for trend analysis."
  measures:
    - name: "total_compliance_records"
      expr: COUNT(1)
      comment: "Total supplier regulatory compliance records — baseline compliance program coverage metric."
    - name: "compliant_supplier_count"
      expr: COUNT(CASE WHEN is_compliant = TRUE THEN 1 END)
      comment: "Number of compliant supplier-regulation pairs — measures supply base regulatory health."
    - name: "non_compliant_supplier_count"
      expr: COUNT(CASE WHEN is_compliant = FALSE THEN 1 END)
      comment: "Number of non-compliant supplier-regulation pairs — critical risk KPI requiring immediate procurement action."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of supplier-regulation pairs in compliance — executive KPI for supply chain regulatory risk exposure."
    - name: "expiring_within_60_days_count"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) BETWEEN 0 AND 60 AND is_compliant = TRUE THEN 1 END)
      comment: "Number of certifications expiring within 60 days — proactive compliance renewal risk KPI."
    - name: "distinct_compliant_suppliers"
      expr: COUNT(DISTINCT CASE WHEN is_compliant = TRUE THEN procurement_supplier_id END)
      comment: "Number of unique suppliers with at least one compliant certification — measures supply base regulatory coverage breadth."
    - name: "avg_days_to_expiry"
      expr: AVG(DATEDIFF(expiry_date, CURRENT_DATE()))
      comment: "Average days until certification expiry across active compliance records — measures compliance portfolio freshness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_payment_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accounts payable payment execution KPIs — tracks payment run performance, discount capture, settlement efficiency, and cash outflow for treasury and CFO reporting."
  source: "`vibe_automotive_v1`.`procurement`.`payment_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the payment run (completed, failed, partial, pending) for AP operations monitoring."
    - name: "run_type"
      expr: run_type
      comment: "Type of payment run (regular, urgent, manual) for payment process analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method (wire, ACH, check, SEPA) for treasury and bank reconciliation."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement status for cash position and bank reconciliation."
    - name: "is_automated"
      expr: is_automated
      comment: "Whether the payment run was automated — measures AP automation maturity."
    - name: "discount_taken_flag"
      expr: discount_taken_flag
      comment: "Whether early payment discounts were captured — measures working capital optimization."
    - name: "currency_code"
      expr: currency_code
      comment: "Payment currency for multi-currency treasury reporting."
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of payment run for cash flow trend and AP aging analysis."
  measures:
    - name: "total_payment_runs"
      expr: COUNT(1)
      comment: "Total number of payment runs — baseline AP throughput metric."
    - name: "total_gross_paid"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross amount paid across all payment runs — primary cash outflow KPI for treasury."
    - name: "total_net_paid"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net amount paid after discounts — actual cash outflow for working capital management."
    - name: "total_discount_captured"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total early payment discounts captured — measures working capital optimization from dynamic discounting."
    - name: "discount_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_gross_amount AS DOUBLE)), 0), 2)
      comment: "Discount captured as percentage of gross payment — measures effectiveness of early payment discount programs."
    - name: "total_tax_paid"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax paid across payment runs — supports tax reporting and VAT reconciliation."
    - name: "avg_invoices_per_run"
      expr: AVG(CAST(number_of_invoices AS DOUBLE))
      comment: "Average number of invoices per payment run — measures payment run efficiency and batching effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_capex_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure requisition KPIs — tracks CAPEX pipeline, approval rates, budget utilization, and investment by asset category for CFO and plant management."
  source: "`vibe_automotive_v1`.`procurement`.`capex_requisition`"
  dimensions:
    - name: "capex_status"
      expr: capex_requisition_status
      comment: "Current status of the CAPEX requisition (draft, submitted, approved, rejected, capitalized) for pipeline management."
    - name: "asset_category"
      expr: asset_category
      comment: "Asset category (tooling, machinery, IT, building) for CAPEX portfolio analysis."
    - name: "justification_type"
      expr: justification_type
      comment: "Business justification type (capacity expansion, replacement, compliance, new product) for investment strategy analysis."
    - name: "funding_source"
      expr: funding_source
      comment: "Funding source for the CAPEX — used for budget allocation and financial planning."
    - name: "approval_authority_level"
      expr: approval_authority_level
      comment: "Required approval authority level — measures CAPEX governance and delegation of authority compliance."
    - name: "capitalized_flag"
      expr: capitalized_flag
      comment: "Whether the asset has been capitalized — used for asset register and depreciation tracking."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Whether regulatory approval is required — identifies compliance-driven CAPEX."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of CAPEX request for annual investment planning and budget cycle analysis."
  measures:
    - name: "total_capex_requests"
      expr: COUNT(1)
      comment: "Total number of CAPEX requisitions — measures investment pipeline volume."
    - name: "total_estimated_investment"
      expr: SUM(CAST(estimated_investment AS DOUBLE))
      comment: "Total estimated CAPEX investment requested — primary CAPEX pipeline value KPI for CFO and board reporting."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved CAPEX budget — measures authorized investment vs. requested for budget governance."
    - name: "budget_approval_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_budget AS DOUBLE)) / NULLIF(SUM(CAST(estimated_investment AS DOUBLE)), 0), 2)
      comment: "Approved budget as percentage of estimated investment — measures CAPEX approval efficiency and investment prioritization."
    - name: "avg_asset_life_years"
      expr: AVG(CAST(asset_life_years AS DOUBLE))
      comment: "Average expected asset life in years — used for depreciation planning and total cost of ownership analysis."
    - name: "total_tax_on_capex"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax component of CAPEX requisitions — supports tax planning and reclaim analysis."
    - name: "pending_approval_capex_value"
      expr: SUM(CASE WHEN capex_requisition_status NOT IN ('APPROVED', 'REJECTED', 'CANCELLED', 'CAPITALIZED') THEN estimated_investment ELSE 0 END)
      comment: "Total value of CAPEX requests pending approval — measures investment decision backlog and approval cycle risk."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`procurement_approval_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approval process efficiency and spend impact"
  source: "`vibe_automotive_v1`.`procurement`.`approval`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Current status of the approval"
    - name: "approver_role"
      expr: approver_role
      comment: "Role of the approver"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the approval is for a critical transaction"
    - name: "approval_month"
      expr: DATE_TRUNC('month', approval_timestamp)
      comment: "Month of the approval action"
  measures:
    - name: "approval_count"
      expr: COUNT(1)
      comment: "Number of approval records"
    - name: "total_approved_amount"
      expr: SUM(CAST(approved_amount AS DOUBLE))
      comment: "Total amount approved"
    - name: "average_approved_amount"
      expr: AVG(CAST(approved_amount AS DOUBLE))
      comment: "Average approved amount per record"
    - name: "auto_approval_count"
      expr: SUM(CASE WHEN is_auto_approved THEN 1 ELSE 0 END)
      comment: "Count of approvals that were auto‑approved"
$$;