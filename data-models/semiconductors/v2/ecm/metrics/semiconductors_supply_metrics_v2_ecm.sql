-- Metric views for domain: supply | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic supplier health and risk metrics for portfolio management, sourcing decisions, and executive supplier reviews."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier`"
  dimensions:
    - name: "supplier_type"
      expr: supplier_type
      comment: "Classifies supplier by type (e.g., foundry, OSAT, chemical, gas) for portfolio segmentation."
    - name: "supplier_group"
      expr: supplier_group
      comment: "Supplier group or commodity cluster for category management."
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current lifecycle status of the supplier (active, probation, disqualified)."
    - name: "country_code"
      expr: country_code
      comment: "Country of supplier headquarters for geopolitical risk analysis."
    - name: "financial_rating"
      expr: financial_rating
      comment: "External financial health rating for credit and continuity risk assessment."
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality performance tier assigned to the supplier."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Flag indicating EAR export-control applicability for compliance segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Flag indicating ITAR export-control applicability."
    - name: "is_certified_kga"
      expr: is_certified_kga
      comment: "Whether supplier holds Known Good Assembly certification."
  measures:
    - name: "total_suppliers"
      expr: COUNT(1)
      comment: "Total number of supplier records; baseline for portfolio size tracking."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average supply risk score across the supplier portfolio; drives risk mitigation prioritization."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score; used in ESG supplier reporting and sourcing decisions."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit extended to suppliers; informs financial exposure management."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit exposure across all suppliers; key financial risk metric for treasury."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN risk_score >= 70 THEN 1 END)
      comment: "Number of suppliers with risk score >= 70; triggers executive escalation and dual-sourcing review."
    - name: "ear_itar_controlled_supplier_count"
      expr: COUNT(CASE WHEN ear_controlled = TRUE OR itar_controlled = TRUE THEN 1 END)
      comment: "Count of suppliers subject to EAR or ITAR controls; critical for export compliance program sizing."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procurement spend, cycle time, and compliance metrics for supply chain cost management and operational efficiency."
  source: "`vibe_semiconductors_v1`.`supply`.`purchase_order`"
  dimensions:
    - name: "purchase_order_status"
      expr: purchase_order_status
      comment: "Current status of the purchase order (open, closed, cancelled) for pipeline visibility."
    - name: "purchase_order_type"
      expr: purchase_order_type
      comment: "Type of purchase order (standard, blanket, NRE) for spend categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency spend analysis."
    - name: "purchase_group"
      expr: purchase_group
      comment: "Purchasing group responsible for the order; enables buyer performance analysis."
    - name: "purchasing_org"
      expr: purchasing_org
      comment: "Purchasing organization for organizational spend allocation."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms (e.g., DDP, FOB) affecting landed cost and risk transfer."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status for compliance and audit tracking."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Whether the PO involves EAR-controlled materials; compliance segmentation."
    - name: "order_date_month"
      expr: DATE_TRUNC('MONTH', order_date)
      comment: "Month of order placement for spend trend analysis."
  measures:
    - name: "total_purchase_orders"
      expr: COUNT(1)
      comment: "Total number of purchase orders; baseline procurement volume metric."
    - name: "total_gross_spend"
      expr: SUM(CAST(total_gross_amount AS DOUBLE))
      comment: "Total gross procurement spend; primary cost metric for supply chain finance."
    - name: "total_net_spend"
      expr: SUM(CAST(total_net_amount AS DOUBLE))
      comment: "Total net procurement spend after discounts; used for budget vs. actuals reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(total_tax_amount AS DOUBLE))
      comment: "Total tax liability on purchase orders; supports tax provision and compliance reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured across POs; measures procurement negotiation effectiveness."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price paid; benchmarks against target price and tracks price trends."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage achieved; KPI for procurement negotiation performance."
    - name: "avg_freight_amount"
      expr: AVG(CAST(freight_amount AS DOUBLE))
      comment: "Average freight cost per PO; informs logistics cost optimization decisions."
    - name: "total_freight_spend"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight spend across all POs; key input for logistics cost reduction programs."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_po_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level procurement metrics for spend analysis, delivery performance, and material cost management."
  source: "`vibe_semiconductors_v1`.`supply`.`po_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the PO line (open, partially received, closed) for backlog management."
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Goods receipt status for delivery tracking and supplier performance."
    - name: "currency_code"
      expr: currency_code
      comment: "Line-level currency for multi-currency spend analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms at line level for landed cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity normalization."
    - name: "is_service_line"
      expr: is_service_line
      comment: "Distinguishes material lines from service lines for spend categorization."
    - name: "is_final_invoice"
      expr: is_final_invoice
      comment: "Indicates whether the line has been finally invoiced; supports AP closure tracking."
    - name: "delivery_date_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of scheduled delivery for supply timeline analysis."
  measures:
    - name: "total_po_lines"
      expr: COUNT(1)
      comment: "Total PO line count; baseline for procurement line-item volume."
    - name: "total_line_spend"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total spend across all PO lines; primary line-level cost metric."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount on PO lines after discounts; used for accrual and budget tracking."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered; measures procurement volume for capacity planning."
    - name: "total_receipt_quantity"
      expr: SUM(CAST(receipt_quantity AS DOUBLE))
      comment: "Total quantity received; used to compute receipt rate vs. ordered quantity."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount captured at line level; measures negotiation savings."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average unit price at line level; benchmarks material cost trends."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on PO lines; supports tax compliance and AP reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound goods quality, quantity, and compliance metrics for supplier delivery performance and receiving operations."
  source: "`vibe_semiconductors_v1`.`supply`.`goods_receipt`"
  dimensions:
    - name: "goods_receipt_status"
      expr: goods_receipt_status
      comment: "Status of the goods receipt (posted, blocked, reversed) for receiving pipeline visibility."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection outcome for incoming material quality tracking."
    - name: "quality_status"
      expr: quality_status
      comment: "Quality disposition (unrestricted, blocked, in-QI) for inventory usability."
    - name: "movement_type"
      expr: movement_type
      comment: "SAP-style movement type for goods movement categorization."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt valuation."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the receipt passed compliance checks; critical for regulatory traceability."
    - name: "posting_date_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt posting for trend analysis."
    - name: "receipt_date_month"
      expr: DATE_TRUNC('MONTH', receipt_date)
      comment: "Month of physical receipt for on-time delivery analysis."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total goods receipt transactions; baseline for inbound volume tracking."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity received from suppliers; measures inbound supply volume."
    - name: "total_accepted_quantity"
      expr: SUM(CAST(accepted_quantity AS DOUBLE))
      comment: "Total quantity accepted after inspection; key quality acceptance metric."
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected at incoming inspection; drives supplier corrective action."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods received; used for AP accrual and spend reporting."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received after adjustments; used for inventory valuation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goods receipts; supports tax compliance reporting."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score at receipt; identifies high-risk inbound material streams."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit quality, compliance, and risk metrics for supply chain governance and qualification programs."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (quality, environmental, financial, EHS) for program segmentation."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (planned, in-progress, closed) for pipeline management."
    - name: "audit_result"
      expr: audit_result
      comment: "Outcome of the audit (pass, conditional pass, fail) for supplier rating."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall supplier rating from the audit for strategic tier assignment."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the audit for regulatory reporting."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions raised from the audit."
    - name: "audit_category"
      expr: audit_category
      comment: "Category of audit (initial, surveillance, re-qualification) for program tracking."
    - name: "audit_date_month"
      expr: DATE_TRUNC('MONTH', audit_date)
      comment: "Month of audit execution for trend and cadence analysis."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the audit covers EAR-controlled scope."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of supplier audits conducted; baseline for audit program coverage."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across all supplier audits; primary supplier quality KPI for executive reviews."
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score from audits; supports ESG supplier reporting."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score from audits; drives risk-based audit frequency decisions."
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost_usd AS DOUBLE))
      comment: "Total cost of supplier audits; used for quality program budget management."
    - name: "avg_audit_duration_hours"
      expr: AVG(CAST(audit_duration_hours AS DOUBLE))
      comment: "Average audit duration in hours; informs resource planning for audit programs."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_result = 'fail' THEN 1 END)
      comment: "Number of failed audits; triggers supplier escalation and disqualification review."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('closed', 'verified') THEN 1 END)
      comment: "Number of audits with open corrective actions; measures supplier responsiveness and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance scorecard metrics for strategic supplier management, tier decisions, and QBR reporting."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_scorecard`"
  dimensions:
    - name: "supplier_scorecard_status"
      expr: supplier_scorecard_status
      comment: "Status of the scorecard (draft, published, archived) for reporting cycle management."
    - name: "scorecard_type"
      expr: scorecard_type
      comment: "Type of scorecard (quarterly, annual, project-based) for period segmentation."
    - name: "strategic_tier"
      expr: strategic_tier
      comment: "Strategic tier of the supplier (preferred, approved, conditional) for portfolio management."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall performance rating for executive supplier review."
    - name: "pcn_compliance"
      expr: pcn_compliance
      comment: "Whether supplier is compliant with PCN notification obligations."
    - name: "scoring_period_start_month"
      expr: DATE_TRUNC('MONTH', scoring_period_start)
      comment: "Start of scoring period for time-series performance trending."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of scorecard data for data quality governance."
  measures:
    - name: "total_scorecards"
      expr: COUNT(1)
      comment: "Total scorecards issued; baseline for supplier performance program coverage."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier performance score; primary KPI for supplier QBR and tier decisions."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score; drives quality improvement programs and supplier selection."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery performance score; informs logistics and lead-time improvement initiatives."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost competitiveness score; supports sourcing strategy and negotiation decisions."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate across scorecards; key supply reliability KPI."
    - name: "avg_dppm"
      expr: AVG(CAST(dppm AS DOUBLE))
      comment: "Average defective parts per million from scorecards; primary incoming quality metric for executive review."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score from scorecards; used to prioritize risk mitigation investments."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification program metrics for approved vendor list management and supply chain risk governance."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (qualified, conditional, disqualified) for AVL management."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (initial, re-qualification, extension) for program tracking."
    - name: "qualification_program_type"
      expr: qualification_program_type
      comment: "Program type (quality, environmental, financial) for multi-dimensional qualification tracking."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall qualification rating for supplier tier assignment."
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Status of corrective actions from qualification findings."
    - name: "findings_severity"
      expr: findings_severity
      comment: "Severity of qualification findings (critical, major, minor) for risk prioritization."
    - name: "qualification_date_year"
      expr: DATE_TRUNC('YEAR', qualification_date)
      comment: "Year of qualification for cohort and renewal cycle analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total supplier qualification records; baseline for AVL program coverage."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score from qualification assessments; primary quality gate metric."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score from qualifications; drives risk-based sourcing decisions."
    - name: "qualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'qualified' THEN 1 END)
      comment: "Number of fully qualified suppliers; measures AVL depth and sourcing optionality."
    - name: "expiring_qualification_count"
      expr: COUNT(CASE WHEN validity_end_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Qualifications expiring within 90 days; triggers re-qualification scheduling to prevent supply disruption."
    - name: "open_corrective_action_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('closed', 'verified') THEN 1 END)
      comment: "Qualifications with open corrective actions; measures compliance risk in the supplier base."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (SCAR) metrics for quality improvement tracking, cost of poor quality, and supplier accountability."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (open, in-progress, closed, verified)."
    - name: "scar_status"
      expr: scar_status
      comment: "SCAR lifecycle status for program management reporting."
    - name: "severity"
      expr: severity
      comment: "Severity of the issue (critical, major, minor) for prioritization."
    - name: "priority"
      expr: priority
      comment: "Priority level of the corrective action for resource allocation."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of root cause (process, material, equipment) for systemic improvement analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the SCAR involves a compliance issue for regulatory tracking."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the SCAR involves EAR-controlled materials."
    - name: "issued_timestamp_month"
      expr: DATE_TRUNC('MONTH', issued_timestamp)
      comment: "Month SCAR was issued for trend analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of corrective action effectiveness."
  measures:
    - name: "total_scars"
      expr: COUNT(1)
      comment: "Total supplier corrective actions issued; baseline for supplier quality program activity."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost of corrective actions; measures cost of poor quality attributable to suppliers."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost of corrective actions; used for quality cost forecasting."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average cost per corrective action; benchmarks SCAR resolution efficiency."
    - name: "open_scar_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('closed', 'verified') THEN 1 END)
      comment: "Number of open SCARs; key supplier accountability metric for executive review."
    - name: "critical_scar_count"
      expr: COUNT(CASE WHEN severity = 'critical' THEN 1 END)
      comment: "Number of critical-severity SCARs; triggers immediate supplier escalation and containment."
    - name: "overdue_scar_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND corrective_action_status NOT IN ('closed', 'verified') THEN 1 END)
      comment: "Number of SCARs past due date; measures supplier responsiveness and compliance risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply chain risk assessment metrics for executive risk visibility, mitigation prioritization, and business continuity planning."
  source: "`vibe_semiconductors_v1`.`supply`.`risk_assessment`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Category of supply risk (geopolitical, single-source, financial, quality) for risk portfolio analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level (critical, high, medium, low) for prioritization and escalation."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the risk assessment (open, mitigated, closed) for risk register management."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Severity of potential business impact for risk prioritization."
    - name: "disruption_status"
      expr: disruption_status
      comment: "Status of any associated disruption event."
    - name: "disruption_event_type"
      expr: disruption_event_type
      comment: "Type of disruption (natural disaster, geopolitical, supplier failure) for scenario planning."
    - name: "assessment_date_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of risk assessment for trend analysis."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total risk assessments in the register; baseline for risk program coverage."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across the supply portfolio; primary executive risk KPI."
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score; informs treasury and insurance decisions."
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score; drives dual-sourcing and geographic diversification strategy."
    - name: "avg_probability_percent"
      expr: AVG(CAST(probability_percent AS DOUBLE))
      comment: "Average probability of risk materialization; used in expected-value risk calculations."
    - name: "high_risk_assessment_count"
      expr: COUNT(CASE WHEN risk_level IN ('critical', 'high') THEN 1 END)
      comment: "Number of high or critical risk assessments; triggers executive escalation and mitigation investment."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average composite risk score; used for supplier risk ranking and portfolio heat maps."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_disruption_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply disruption event metrics for business continuity management, financial impact quantification, and executive crisis reporting."
  source: "`vibe_semiconductors_v1`.`supply`.`disruption_event`"
  dimensions:
    - name: "disruption_type"
      expr: disruption_type
      comment: "Type of disruption (natural disaster, logistics, supplier insolvency) for scenario categorization."
    - name: "disruption_category"
      expr: disruption_category
      comment: "Category of disruption for root cause and trend analysis."
    - name: "event_severity"
      expr: event_severity
      comment: "Severity of the disruption event for escalation and response prioritization."
    - name: "disruption_event_status"
      expr: disruption_event_status
      comment: "Current status of the disruption event (active, contained, resolved)."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level reached (operational, management, executive) for governance tracking."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether the disruption involves EAR-controlled materials for compliance impact assessment."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "Whether the disruption involves ITAR-controlled materials."
    - name: "disruption_start_month"
      expr: DATE_TRUNC('MONTH', disruption_start_timestamp)
      comment: "Month disruption started for trend and seasonality analysis."
  measures:
    - name: "total_disruption_events"
      expr: COUNT(1)
      comment: "Total disruption events recorded; baseline for supply chain resilience tracking."
    - name: "total_estimated_financial_impact"
      expr: SUM(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Total estimated financial impact of disruptions; primary executive KPI for business continuity investment decisions."
    - name: "avg_estimated_financial_impact"
      expr: AVG(CAST(estimated_financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per disruption event; benchmarks event severity and insurance coverage adequacy."
    - name: "total_impacted_po_quantity"
      expr: SUM(CAST(impacted_po_quantity AS DOUBLE))
      comment: "Total PO quantity impacted by disruptions; measures supply volume at risk."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of disruption events; used for risk-weighted business continuity planning."
    - name: "active_disruption_count"
      expr: COUNT(CASE WHEN disruption_event_status = 'active' THEN 1 END)
      comment: "Number of currently active disruptions; real-time supply chain health indicator for operations."
    - name: "high_severity_event_count"
      expr: COUNT(CASE WHEN event_severity IN ('critical', 'high') THEN 1 END)
      comment: "Number of high or critical severity disruption events; triggers executive crisis response."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_inbound_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inbound logistics performance metrics for on-time delivery, freight cost management, and supply chain visibility."
  source: "`vibe_semiconductors_v1`.`supply`.`inbound_shipment`"
  dimensions:
    - name: "inbound_shipment_status"
      expr: inbound_shipment_status
      comment: "Current status of the inbound shipment (in-transit, arrived, customs-hold) for logistics visibility."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Detailed shipment status for operational tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport (air, sea, road, rail) for logistics cost and lead-time analysis."
    - name: "incoterms"
      expr: incoterms
      comment: "Delivery terms for risk transfer and cost allocation analysis."
    - name: "origin_country"
      expr: origin_country
      comment: "Country of origin for geopolitical risk and customs compliance analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the shipment for customs and export control tracking."
    - name: "cold_chain_required"
      expr: cold_chain_required
      comment: "Whether cold chain handling is required; critical for specialty chemical and photoresist shipments."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "Whether shipment contains EAR-controlled items."
    - name: "ship_date_month"
      expr: DATE_TRUNC('MONTH', ship_date)
      comment: "Month of shipment for inbound volume trend analysis."
  measures:
    - name: "total_inbound_shipments"
      expr: COUNT(1)
      comment: "Total inbound shipments; baseline for inbound logistics volume tracking."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total inbound freight cost; primary logistics spend metric for cost reduction programs."
    - name: "avg_freight_cost"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment; benchmarks logistics efficiency and carrier performance."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total inbound shipment weight in kg; used for freight rate benchmarking and capacity planning."
    - name: "total_volume_m3"
      expr: SUM(CAST(volume_m3 AS DOUBLE))
      comment: "Total inbound shipment volume in cubic meters; informs warehouse receiving capacity planning."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of inbound shipments; identifies high-risk lanes and suppliers."
    - name: "on_time_shipment_count"
      expr: COUNT(CASE WHEN actual_arrival_date <= estimated_arrival_date THEN 1 END)
      comment: "Number of shipments arriving on or before estimated date; measures supplier and carrier delivery reliability."
    - name: "late_shipment_count"
      expr: COUNT(CASE WHEN actual_arrival_date > estimated_arrival_date THEN 1 END)
      comment: "Number of late inbound shipments; drives carrier performance management and safety stock decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply forecast accuracy and volume metrics for demand-supply balancing, capacity planning, and inventory optimization."
  source: "`vibe_semiconductors_v1`.`supply`.`supply_forecast`"
  dimensions:
    - name: "forecast_status"
      expr: forecast_status
      comment: "Status of the forecast (draft, approved, published) for planning cycle management."
    - name: "forecast_type"
      expr: forecast_type
      comment: "Type of forecast (statistical, consensus, supplier-confirmed) for accuracy benchmarking."
    - name: "forecast_method"
      expr: forecast_method
      comment: "Forecasting method used for model performance comparison."
    - name: "forecast_period"
      expr: forecast_period
      comment: "Planning period (weekly, monthly, quarterly) for horizon analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial forecast valuation."
    - name: "is_ltb"
      expr: is_ltb
      comment: "Whether this is a last-time-buy forecast; critical for end-of-life supply planning."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the forecast involves compliance-sensitive materials."
    - name: "forecast_date_month"
      expr: DATE_TRUNC('MONTH', forecast_date)
      comment: "Month of forecast creation for version and accuracy trend analysis."
  measures:
    - name: "total_forecast_records"
      expr: COUNT(1)
      comment: "Total forecast records; baseline for planning coverage."
    - name: "total_forecast_quantity"
      expr: SUM(CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted supply quantity; primary volume metric for capacity and procurement planning."
    - name: "total_prior_forecast_quantity"
      expr: SUM(CAST(prior_forecast_quantity AS DOUBLE))
      comment: "Total prior period forecast quantity; used to compute forecast revision magnitude."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total forecast variance (current vs. prior); measures forecast stability and planning reliability."
    - name: "avg_confidence_level_percent"
      expr: AVG(CAST(confidence_level_percent AS DOUBLE))
      comment: "Average forecast confidence level; informs safety stock and buffer inventory decisions."
    - name: "total_forecast_value"
      expr: SUM(CAST(price_per_unit AS DOUBLE) * CAST(forecast_quantity AS DOUBLE))
      comment: "Total forecasted supply value (price × quantity); used for procurement budget planning."
    - name: "ltb_forecast_quantity"
      expr: SUM(CASE WHEN is_ltb = TRUE THEN forecast_quantity ELSE 0 END)
      comment: "Total last-time-buy forecast quantity; critical for end-of-life inventory and supply continuity planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_sourcing_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sourcing contract value, compliance, and coverage metrics for strategic procurement governance and spend under contract tracking."
  source: "`vibe_semiconductors_v1`.`supply`.`sourcing_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sourcing contract (framework, spot, long-term) for spend categorization."
    - name: "contract_status"
      expr: contract_status
      comment: "Current contract status (active, expired, terminated) for portfolio management."
    - name: "sourcing_contract_status"
      expr: sourcing_contract_status
      comment: "Detailed sourcing contract lifecycle status."
    - name: "approval_status"
      expr: approval_status
      comment: "Contract approval status for governance and compliance tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency spend analysis."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for category management and spend analytics."
    - name: "effective_date_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year contract became effective for portfolio vintage analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of contract expiry for renewal pipeline management."
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total sourcing contracts; baseline for contract portfolio coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all sourcing contracts; primary spend-under-contract KPI for procurement governance."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value; benchmarks deal size and negotiation outcomes."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average contracted unit price; tracks price trend and negotiation effectiveness."
    - name: "total_target_quantity"
      expr: SUM(CAST(target_quantity AS DOUBLE))
      comment: "Total committed quantity across contracts; measures supply volume under contract."
    - name: "expiring_contract_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND contract_status = 'active' THEN 1 END)
      comment: "Active contracts expiring within 90 days; drives renewal pipeline management to prevent supply gaps."
    - name: "active_contract_count"
      expr: COUNT(CASE WHEN contract_status = 'active' THEN 1 END)
      comment: "Number of active sourcing contracts; measures current supply coverage and procurement reach."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply agreement commitment, pricing, and performance metrics for long-term supply security and cost management."
  source: "`vibe_semiconductors_v1`.`supply`.`supply_agreement`"
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of supply agreement (LTA, spot, consignment) for portfolio segmentation."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (active, expired, terminated)."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for financial analysis."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Whether the agreement auto-renews; informs renewal pipeline management."
    - name: "dual_source_flag"
      expr: dual_source_flag
      comment: "Whether dual sourcing is in place; measures supply resilience coverage."
    - name: "force_majeure_clause_flag"
      expr: force_majeure_clause_flag
      comment: "Whether force majeure clause is included; informs risk and legal exposure."
    - name: "effective_start_date_year"
      expr: DATE_TRUNC('YEAR', effective_start_date)
      comment: "Year agreement started for portfolio vintage analysis."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total supply agreements; baseline for long-term supply coverage."
    - name: "total_agreement_value"
      expr: SUM(CAST(total_agreement_value AS DOUBLE))
      comment: "Total value of all supply agreements; primary long-term supply commitment KPI."
    - name: "total_annual_committed_value"
      expr: SUM(CAST(annual_committed_value_usd AS DOUBLE))
      comment: "Total annual committed spend under supply agreements; used for budget planning and supplier dependency analysis."
    - name: "total_annual_contract_value"
      expr: SUM(CAST(annual_contract_value_usd AS DOUBLE))
      comment: "Total annual contract value across agreements; measures contracted revenue for suppliers."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average contracted unit price; tracks price trend and cost reduction progress."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate from agreements; measures supply reliability under contract."
    - name: "dual_sourced_agreement_count"
      expr: COUNT(CASE WHEN dual_source_flag = TRUE THEN 1 END)
      comment: "Number of agreements with dual sourcing; measures supply resilience and single-source risk mitigation."
    - name: "total_annual_volume_commitment"
      expr: SUM(CAST(annual_volume_commitment AS DOUBLE))
      comment: "Total annual volume committed under supply agreements; critical for capacity planning and supplier allocation."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_approved_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved vendor list (AVL) quality, risk, and compliance metrics for supply base governance and qualification management."
  source: "`vibe_semiconductors_v1`.`supply`.`approved_vendor`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the vendor (approved, conditional, suspended) for AVL management."
    - name: "approved_vendor_status"
      expr: approved_vendor_status
      comment: "Detailed vendor status for lifecycle tracking."
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (foundry, OSAT, chemical, equipment) for category analysis."
    - name: "quality_tier"
      expr: quality_tier
      comment: "Quality tier assigned to the vendor for sourcing preference decisions."
    - name: "financial_rating"
      expr: financial_rating
      comment: "Financial health rating for credit and continuity risk assessment."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status for compliance program tracking."
    - name: "country_code"
      expr: country_code
      comment: "Country of vendor for geopolitical risk segmentation."
    - name: "approval_date_year"
      expr: DATE_TRUNC('YEAR', approval_date)
      comment: "Year of vendor approval for AVL vintage and renewal analysis."
  measures:
    - name: "total_approved_vendors"
      expr: COUNT(1)
      comment: "Total approved vendors on the AVL; baseline for supply base breadth."
    - name: "avg_audit_score"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score across approved vendors; primary quality gate metric for AVL maintenance."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of approved vendors; drives risk-based sourcing and dual-source decisions."
    - name: "expiring_vendor_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Vendors with approval expiring within 90 days; triggers re-qualification to prevent supply disruption."
    - name: "high_risk_vendor_count"
      expr: COUNT(CASE WHEN risk_score >= 70 THEN 1 END)
      comment: "Number of approved vendors with high risk scores; informs dual-sourcing and contingency planning."
    - name: "suspended_vendor_count"
      expr: COUNT(CASE WHEN approved_vendor_status = 'suspended' THEN 1 END)
      comment: "Number of suspended vendors; measures supply base disruption and sourcing gap risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_osat_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "OSAT (outsourced assembly and test) work order cost, quality, and delivery metrics for packaging supply chain management."
  source: "`vibe_semiconductors_v1`.`supply`.`osat_work_order`"
  dimensions:
    - name: "osat_work_order_status"
      expr: osat_work_order_status
      comment: "Current status of the OSAT work order (issued, in-progress, completed, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the work order for governance tracking."
    - name: "package_type"
      expr: package_type
      comment: "Package type (BGA, QFN, flip-chip) for cost and yield analysis by package."
    - name: "service_type"
      expr: service_type
      comment: "Type of OSAT service (assembly, test, assembly+test) for cost allocation."
    - name: "priority"
      expr: priority
      comment: "Work order priority for capacity allocation and scheduling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost analysis."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Whether the work order involves EAR-controlled items for compliance tracking."
    - name: "planned_start_date_month"
      expr: DATE_TRUNC('MONTH', planned_start_date)
      comment: "Month of planned start for capacity and scheduling analysis."
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total OSAT work orders; baseline for outsourced assembly volume tracking."
    - name: "total_assembly_cost"
      expr: SUM(CAST(total_assembly_cost AS DOUBLE))
      comment: "Total OSAT assembly cost; primary cost metric for packaging supply chain finance."
    - name: "avg_unit_assembly_cost"
      expr: AVG(CAST(unit_assembly_cost AS DOUBLE))
      comment: "Average unit assembly cost; benchmarks OSAT pricing and drives cost reduction negotiations."
    - name: "total_nre_charge"
      expr: SUM(CAST(nre_charge AS DOUBLE))
      comment: "Total NRE charges from OSAT vendors; tracks non-recurring engineering cost exposure."
    - name: "total_die_quantity"
      expr: SUM(CAST(die_quantity AS DOUBLE))
      comment: "Total die quantity across OSAT work orders; measures assembly volume for capacity planning."
    - name: "avg_risk_assessment_score"
      expr: AVG(CAST(risk_assessment_score AS DOUBLE))
      comment: "Average risk score of OSAT work orders; identifies high-risk assembly programs."
    - name: "open_work_order_count"
      expr: COUNT(CASE WHEN osat_work_order_status NOT IN ('completed', 'cancelled') THEN 1 END)
      comment: "Number of open OSAT work orders; measures current outsourced assembly pipeline."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_requirement_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "MRP metrics for supply-demand balancing, procurement planning, and material availability management."
  source: "`vibe_semiconductors_v1`.`supply`.`material_requirement_plan`"
  dimensions:
    - name: "material_requirement_plan_status"
      expr: material_requirement_plan_status
      comment: "Status of the MRP record (planned, firmed, released) for planning pipeline management."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (MRP, MPS, reorder-point) for planning methodology analysis."
    - name: "lot_sizing_procedure"
      expr: lot_sizing_procedure
      comment: "Lot sizing procedure used for procurement optimization analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for planned cost analysis."
    - name: "is_fixed_lot"
      expr: is_fixed_lot
      comment: "Whether fixed lot sizing is applied; informs inventory optimization decisions."
    - name: "batch_managed_flag"
      expr: batch_managed_flag
      comment: "Whether batch management is active for the material."
    - name: "demand_date_month"
      expr: DATE_TRUNC('MONTH', demand_date)
      comment: "Month of demand for supply-demand gap analysis."
    - name: "planned_delivery_date_month"
      expr: DATE_TRUNC('MONTH', planned_delivery_date)
      comment: "Month of planned delivery for supply timeline analysis."
  measures:
    - name: "total_mrp_records"
      expr: COUNT(1)
      comment: "Total MRP planning records; baseline for planning coverage."
    - name: "total_gross_requirement_qty"
      expr: SUM(CAST(gross_requirement_qty AS DOUBLE))
      comment: "Total gross material requirement quantity; primary demand signal for procurement planning."
    - name: "total_net_requirement_qty"
      expr: SUM(CAST(net_requirement_qty AS DOUBLE))
      comment: "Total net material requirement after available stock; drives purchase order creation."
    - name: "total_planned_order_qty"
      expr: SUM(CAST(planned_order_qty AS DOUBLE))
      comment: "Total planned order quantity; measures procurement volume to be released."
    - name: "total_planned_cost"
      expr: SUM(CAST(planned_cost AS DOUBLE))
      comment: "Total planned procurement cost from MRP; used for budget planning and cash flow forecasting."
    - name: "total_demand_quantity"
      expr: SUM(CAST(demand_quantity AS DOUBLE))
      comment: "Total demand quantity across MRP records; measures overall material demand volume."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity; benchmarks inventory buffer levels for supply continuity."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_supplier_quotation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier quotation and sourcing decision metrics for competitive procurement, price benchmarking, and award analysis."
  source: "`vibe_semiconductors_v1`.`supply`.`supplier_quotation`"
  dimensions:
    - name: "quotation_status"
      expr: quotation_status
      comment: "Status of the quotation (submitted, evaluated, awarded, rejected) for RFQ pipeline management."
    - name: "supplier_quotation_status"
      expr: supplier_quotation_status
      comment: "Detailed supplier quotation status for sourcing workflow tracking."
    - name: "award_decision"
      expr: award_decision
      comment: "Award decision outcome (awarded, not-awarded, split) for sourcing decision analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Quotation currency for multi-currency price comparison."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for category-level price benchmarking."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Whether the quotation meets compliance requirements."
    - name: "is_ear_controlled"
      expr: is_ear_controlled
      comment: "Whether the quoted item is EAR-controlled."
    - name: "quotation_date_month"
      expr: DATE_TRUNC('MONTH', quotation_date)
      comment: "Month of quotation for RFQ activity trend analysis."
  measures:
    - name: "total_quotations"
      expr: COUNT(1)
      comment: "Total supplier quotations received; baseline for sourcing activity volume."
    - name: "total_quoted_price"
      expr: SUM(CAST(quoted_total_price AS DOUBLE))
      comment: "Total quoted price across all quotations; measures sourcing spend under evaluation."
    - name: "avg_quoted_unit_price"
      expr: AVG(CAST(quoted_unit_price AS DOUBLE))
      comment: "Average quoted unit price; primary price benchmarking metric for procurement negotiations."
    - name: "avg_award_price"
      expr: AVG(CAST(award_price AS DOUBLE))
      comment: "Average awarded price; measures actual sourcing cost vs. quoted price."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average supplier evaluation score; measures overall supplier competitiveness in RFQ process."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of quotations; informs risk-adjusted sourcing decisions."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount offered across quotations; measures negotiation savings potential."
    - name: "awarded_quotation_count"
      expr: COUNT(CASE WHEN award_decision = 'awarded' THEN 1 END)
      comment: "Number of awarded quotations; measures sourcing decision throughput and RFQ conversion rate."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_consignment_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consignment inventory agreement metrics for working capital optimization, supplier-managed inventory, and risk management."
  source: "`vibe_semiconductors_v1`.`supply`.`consignment_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Status of the consignment agreement (active, expired, terminated)."
    - name: "consignment_agreement_status"
      expr: consignment_agreement_status
      comment: "Detailed consignment agreement lifecycle status."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of consignment arrangement for inventory strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Agreement currency for financial exposure analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the consignment agreement."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the consignment arrangement for supply risk management."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month agreement became effective for portfolio analysis."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total consignment agreements; baseline for consignment inventory program coverage."
    - name: "total_consignment_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of consignment inventory under agreement; measures working capital benefit from supplier-managed inventory."
    - name: "total_max_consignment_value"
      expr: SUM(CAST(max_consignment_value AS DOUBLE))
      comment: "Total maximum consignment value authorized; measures maximum financial exposure under consignment programs."
    - name: "total_consignment_quantity"
      expr: SUM(CAST(consignment_quantity AS DOUBLE))
      comment: "Total consignment quantity across agreements; measures inventory volume under supplier management."
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average consignment unit price; benchmarks consignment pricing vs. standard purchase pricing."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Number of active consignment agreements; measures current consignment inventory program scale."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`supply_material_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material certification compliance metrics for regulatory adherence, PCN management, and supply chain traceability."
  source: "`vibe_semiconductors_v1`.`supply`.`material_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (valid, expired, revoked) for compliance tracking."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (RoHS, REACH, TSCA, ISO) for regulatory program segmentation."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard the certification covers for regulatory reporting."
    - name: "pcn_change_type"
      expr: pcn_change_type
      comment: "Type of product change notification (material, process, site) for change impact analysis."
    - name: "pcn_requalification_decision"
      expr: pcn_requalification_decision
      comment: "Requalification decision from PCN (required, waived, in-progress) for supply continuity planning."
    - name: "pcn_customer_notification_required"
      expr: pcn_customer_notification_required
      comment: "Whether customer notification is required for the PCN; drives customer communication obligations."
    - name: "issue_date_year"
      expr: DATE_TRUNC('YEAR', issue_date)
      comment: "Year of certification issuance for compliance portfolio vintage analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total material certifications; baseline for compliance coverage of the supply base."
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of material certifications; identifies high-risk materials requiring enhanced compliance monitoring."
    - name: "avg_test_value"
      expr: AVG(CAST(test_value AS DOUBLE))
      comment: "Average test value from certification testing; used for material quality benchmarking."
    - name: "expiring_certification_count"
      expr: COUNT(CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Certifications expiring within 90 days; triggers renewal to prevent compliance gaps and supply disruption."
    - name: "pcn_notification_required_count"
      expr: COUNT(CASE WHEN pcn_customer_notification_required = TRUE THEN 1 END)
      comment: "Number of certifications requiring customer PCN notification; drives customer communication program workload."
    - name: "requalification_required_count"
      expr: COUNT(CASE WHEN pcn_requalification_decision = 'required' THEN 1 END)
      comment: "Number of certifications requiring requalification; measures qualification program backlog from supply changes."
$$;