-- Metric views for domain: supplier | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Executive-level supplier performance scorecard tracking delivery reliability, quality acceptance, and overall scorecard ratings across the active supplier base. Used in quarterly business reviews to steer sourcing strategy and supplier development investments."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier`"
  filter: supplier_status = 'ACTIVE'
  dimensions:
    - name: "supplier_category"
      expr: supplier_category
      comment: "Category of the supplier (e.g., raw material, contract manufacturer, MRO) for segmented performance analysis."
    - name: "business_type"
      expr: business_type
      comment: "Business type classification of the supplier (e.g., distributor, OEM, tier-1) to benchmark performance by supply chain tier."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Current risk tier assigned to the supplier, enabling risk-stratified performance monitoring."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the supplier (e.g., approved, conditional, disqualified) for filtering active vs. probationary suppliers."
    - name: "headquarters_country"
      expr: headquarters_country
      comment: "Country of supplier headquarters for geographic supply risk and regional sourcing analysis."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Preferred transaction currency of the supplier for FX exposure analysis."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the supplier relationship began, enabling tenure-based performance cohort analysis."
  measures:
    - name: "total_active_suppliers"
      expr: COUNT(1)
      comment: "Total count of active suppliers in the base. Baseline KPI for supply base breadth and concentration risk assessment."
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate (%) across suppliers. A primary supply chain reliability KPI used to identify underperforming suppliers requiring corrective action."
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average incoming quality acceptance rate (%) across suppliers. Directly tied to production yield and cost of poor quality; triggers supplier development when below threshold."
    - name: "avg_overall_scorecard_rating"
      expr: AVG(CAST(overall_scorecard_rating AS DOUBLE))
      comment: "Average overall scorecard rating across the supplier base. Composite KPI used in QBRs to assess supply base health and prioritize development resources."
    - name: "single_source_supplier_count"
      expr: COUNT(CASE WHEN iso9001_certified = FALSE AND qualification_status = 'APPROVED' THEN 1 END)
      comment: "Count of approved suppliers that are not ISO 9001 certified, flagging quality system gaps in the approved vendor base."
    - name: "iso9001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso9001_certified = TRUE THEN 1 END)
      comment: "Number of suppliers holding ISO 9001 certification. Used to track quality management system coverage across the supply base."
    - name: "iso14001_certified_supplier_count"
      expr: COUNT(CASE WHEN iso14001_certified = TRUE THEN 1 END)
      comment: "Number of suppliers holding ISO 14001 environmental certification. Tracks ESG compliance coverage in the supply chain."
    - name: "minority_or_diverse_supplier_count"
      expr: COUNT(CASE WHEN minority_owned = TRUE OR woman_owned = TRUE OR small_business = TRUE THEN 1 END)
      comment: "Count of diverse suppliers (minority-owned, woman-owned, or small business). Tracks supplier diversity program performance against corporate ESG commitments."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (days) across the supplier base. Used by treasury and procurement to manage working capital and negotiate standardized terms."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic supplier scorecard metrics tracking quality, delivery, cost, and responsiveness scores. Used by supply chain leadership to rank suppliers, trigger development plans, and make sourcing decisions."
  source: "`vibe_manufacturing_v1`.`supplier`.`scorecard`"
  filter: scorecard_status = 'PUBLISHED'
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Evaluation period type (e.g., monthly, quarterly, annual) for time-series scorecard trend analysis."
    - name: "rating_tier"
      expr: rating_tier
      comment: "Current performance tier (e.g., Preferred, Approved, Conditional, Disqualified) for supplier segmentation and sourcing decisions."
    - name: "previous_rating_tier"
      expr: previous_rating_tier
      comment: "Prior period rating tier to identify suppliers improving or declining in performance."
    - name: "evaluation_period_start_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of the evaluation period start for annual trend analysis."
    - name: "evaluation_period_start_quarter"
      expr: CONCAT(YEAR(evaluation_period_start_date), '-Q', QUARTER(evaluation_period_start_date))
      comment: "Quarter of the evaluation period for quarterly performance trending."
    - name: "improvement_actions_required"
      expr: improvement_actions_required
      comment: "Flag indicating whether improvement actions were mandated, used to track the proportion of suppliers on performance improvement plans."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the purchase value evaluated in the scorecard period."
  measures:
    - name: "total_scorecards_published"
      expr: COUNT(1)
      comment: "Total number of published scorecards. Baseline measure for scorecard program coverage and cadence compliance."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall supplier score across all published scorecards. Primary composite KPI for supply base health used in executive steering meetings."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality dimension score. Directly linked to incoming quality, scrap, and rework costs; triggers quality corrective actions when below threshold."
    - name: "avg_delivery_score"
      expr: AVG(CAST(delivery_score AS DOUBLE))
      comment: "Average delivery dimension score. Tied to production schedule adherence and customer service levels; drives logistics and supplier capacity interventions."
    - name: "avg_cost_score"
      expr: AVG(CAST(cost_score AS DOUBLE))
      comment: "Average cost dimension score. Reflects price competitiveness and cost variance; informs sourcing strategy and renegotiation priorities."
    - name: "avg_responsiveness_score"
      expr: AVG(CAST(responsiveness_score AS DOUBLE))
      comment: "Average responsiveness dimension score. Measures supplier agility and communication quality; critical for managing supply disruptions."
    - name: "avg_otd_percentage"
      expr: AVG(CAST(otd_percentage AS DOUBLE))
      comment: "Average on-time delivery percentage across evaluated scorecards. Key operational KPI for supply chain reliability management."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average parts-per-million defect rate across scorecards. Industry-standard quality KPI used to benchmark suppliers against quality targets and trigger SCAR processes."
    - name: "total_purchase_value_evaluated"
      expr: SUM(CAST(total_purchase_value AS DOUBLE))
      comment: "Total purchase value covered by published scorecards. Indicates the spend under active performance management."
    - name: "avg_cost_variance_percentage"
      expr: AVG(CAST(cost_variance_percentage AS DOUBLE))
      comment: "Average cost variance percentage versus target. Tracks pricing discipline and contract compliance across the supply base."
    - name: "suppliers_requiring_improvement_count"
      expr: COUNT(CASE WHEN improvement_actions_required = TRUE THEN 1 END)
      comment: "Number of suppliers flagged for mandatory improvement actions. Drives supplier development resource allocation and escalation decisions."
    - name: "avg_responsiveness_index"
      expr: AVG(CAST(responsiveness_index AS DOUBLE))
      comment: "Average responsiveness index score. Composite measure of supplier communication speed and issue resolution agility."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_risk`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk assessment metrics covering financial, operational, quality, ESG, geopolitical, and cybersecurity risk dimensions. Used by supply chain risk management and procurement leadership to prioritize mitigation investments and sourcing diversification."
  source: "`vibe_manufacturing_v1`.`supplier`.`risk_rating`"
  filter: assessment_status = 'APPROVED'
  dimensions:
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier (e.g., Critical, High, Medium, Low) for risk-stratified supplier management and escalation routing."
    - name: "residual_risk_level"
      expr: residual_risk_level
      comment: "Residual risk level after mitigation actions, used to assess effectiveness of risk controls."
    - name: "country_risk_rating"
      expr: country_risk_rating
      comment: "Country-level risk rating for geopolitical and regulatory exposure analysis."
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the risk assessment (e.g., FMEA, scorecard, third-party) for comparability analysis."
    - name: "assessment_period_year"
      expr: YEAR(assessment_period_start_date)
      comment: "Year of the assessment period for annual risk trend analysis."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Indicates single-source supply dependency, a critical concentration risk factor for executive supply chain resilience reviews."
    - name: "sanctions_flag"
      expr: sanctions_flag
      comment: "Indicates whether the supplier is subject to trade sanctions, a compliance-critical dimension for legal and procurement leadership."
    - name: "conflict_minerals_flag"
      expr: conflict_minerals_flag
      comment: "Indicates conflict minerals exposure for ESG and regulatory compliance reporting."
  measures:
    - name: "total_risk_assessments"
      expr: COUNT(1)
      comment: "Total number of approved risk assessments. Baseline measure for risk program coverage across the supply base."
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessed suppliers. Primary composite risk KPI used in executive risk reviews to steer mitigation investment."
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score. Tracks supplier financial health and insolvency exposure; triggers financial monitoring or dual-sourcing decisions."
    - name: "avg_quality_risk_score"
      expr: AVG(CAST(quality_risk_score AS DOUBLE))
      comment: "Average quality risk score. Linked to incoming quality performance and production disruption risk."
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score. Reflects supply continuity and capacity risk; informs safety stock and dual-sourcing strategies."
    - name: "avg_esg_risk_score"
      expr: AVG(CAST(esg_risk_score AS DOUBLE))
      comment: "Average ESG risk score. Tracks environmental, social, and governance exposure in the supply chain for sustainability reporting and investor relations."
    - name: "avg_geopolitical_risk_score"
      expr: AVG(CAST(geopolitical_risk_score AS DOUBLE))
      comment: "Average geopolitical risk score. Measures exposure to trade disruptions, tariffs, and political instability; drives supply chain regionalization decisions."
    - name: "avg_cybersecurity_risk_score"
      expr: AVG(CAST(cybersecurity_risk_score AS DOUBLE))
      comment: "Average cybersecurity risk score. Tracks digital supply chain vulnerability; triggers cybersecurity audit and remediation requirements."
    - name: "avg_ppm_defect_rate"
      expr: AVG(CAST(ppm_defect_rate AS DOUBLE))
      comment: "Average PPM defect rate from risk assessments. Cross-references quality performance data to validate risk tier assignments."
    - name: "avg_lead_time_volatility_index"
      expr: AVG(CAST(lead_time_volatility_index AS DOUBLE))
      comment: "Average lead time volatility index. Measures supply timing unpredictability; directly informs safety stock policy and production planning buffers."
    - name: "high_risk_supplier_count"
      expr: COUNT(CASE WHEN overall_risk_tier IN ('CRITICAL', 'HIGH') THEN 1 END)
      comment: "Count of suppliers rated Critical or High risk. Executive KPI for supply chain resilience; triggers board-level risk reporting when elevated."
    - name: "single_source_high_risk_count"
      expr: COUNT(CASE WHEN single_source_flag = TRUE AND overall_risk_tier IN ('CRITICAL', 'HIGH') THEN 1 END)
      comment: "Count of single-source suppliers with Critical or High risk rating. Highest-priority supply continuity risk requiring immediate dual-sourcing or mitigation action."
    - name: "avg_credit_score"
      expr: AVG(CAST(credit_score AS DOUBLE))
      comment: "Average supplier credit score. Financial health indicator used by treasury and procurement to assess payment term risk and advance payment exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit program metrics tracking audit coverage, findings severity, CAPA compliance, and risk rating changes. Used by quality and procurement leadership to manage supplier quality system compliance and audit program effectiveness."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., system, process, product, follow-up) for audit program mix analysis."
    - name: "audit_method"
      expr: audit_method
      comment: "Audit method (e.g., on-site, remote, desktop) for resource planning and coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., planned, in-progress, closed) for pipeline and backlog management."
    - name: "audit_result"
      expr: audit_result
      comment: "Overall audit result (e.g., pass, conditional pass, fail) for pass-rate trending and supplier segmentation."
    - name: "certification_standard"
      expr: certification_standard
      comment: "Certification standard audited against (e.g., ISO 9001, IATF 16949) for standard-specific compliance tracking."
    - name: "risk_rating_post_audit"
      expr: risk_rating_post_audit
      comment: "Risk rating assigned after the audit, used to track risk tier changes resulting from audit findings."
    - name: "capa_required_flag"
      expr: capa_required_flag
      comment: "Indicates whether a CAPA was required, used to measure the proportion of audits generating corrective action obligations."
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of the audit for annual audit program coverage and trend analysis."
    - name: "audit_quarter"
      expr: CONCAT(YEAR(audit_date), '-Q', QUARTER(audit_date))
      comment: "Quarter of the audit for quarterly audit cadence and findings trend analysis."
  measures:
    - name: "total_audits_conducted"
      expr: COUNT(1)
      comment: "Total number of supplier audits conducted. Baseline KPI for audit program coverage and cadence compliance."
    - name: "avg_audit_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average audit score across all audits. Primary quality system compliance KPI used to benchmark supplier performance against certification standards."
    - name: "total_audit_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of supplier audits. Used by procurement and quality leadership to manage audit program budget and ROI."
    - name: "avg_audit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per supplier audit. Benchmarks audit efficiency and informs decisions on remote vs. on-site audit mix."
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS BIGINT))
      comment: "Total critical findings across all audits. High-severity quality system deficiency indicator requiring immediate escalation and CAPA."
    - name: "total_major_findings"
      expr: SUM(CAST(major_findings_count AS BIGINT))
      comment: "Total major findings across all audits. Tracks systemic quality system gaps requiring structured corrective action."
    - name: "total_minor_findings"
      expr: SUM(CAST(minor_findings_count AS BIGINT))
      comment: "Total minor findings across all audits. Tracks improvement opportunities and early warning signals before they escalate."
    - name: "avg_total_findings_per_audit"
      expr: AVG(CAST(total_findings_count AS DOUBLE))
      comment: "Average number of findings per audit. Measures audit thoroughness and supplier quality system maturity."
    - name: "capa_required_audit_count"
      expr: COUNT(CASE WHEN capa_required_flag = TRUE THEN 1 END)
      comment: "Number of audits that generated a CAPA requirement. Tracks the proportion of audits identifying systemic issues requiring corrective action."
    - name: "follow_up_audit_required_count"
      expr: COUNT(CASE WHEN follow_up_audit_required_flag = TRUE THEN 1 END)
      comment: "Number of audits requiring a follow-up audit. Indicates the volume of unresolved findings requiring re-verification, a key audit closure efficiency metric."
    - name: "risk_rating_improved_count"
      expr: COUNT(CASE WHEN risk_rating_post_audit < risk_rating_pre_audit THEN 1 END)
      comment: "Number of audits where the post-audit risk rating improved versus pre-audit. Measures audit program effectiveness in driving supplier risk reduction."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier corrective action (SCAR) metrics tracking issue resolution cycle times, recurrence rates, cost impacts, and closure effectiveness. Used by quality and supply chain leadership to manage supplier quality improvement programs and measure SCAR program ROI."
  source: "`vibe_manufacturing_v1`.`supplier`.`corrective_action`"
  dimensions:
    - name: "corrective_action_status"
      expr: corrective_action_status
      comment: "Current status of the corrective action (e.g., open, in-progress, closed, overdue) for pipeline and backlog management."
    - name: "issue_type"
      expr: issue_type
      comment: "Type of quality issue (e.g., dimensional, material, process, documentation) for Pareto analysis of root cause categories."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the issue (e.g., critical, major, minor) for risk-stratified corrective action management."
    - name: "root_cause_analysis_method"
      expr: root_cause_analysis_method
      comment: "Root cause analysis method used (e.g., 8D, 5-Why, Fishbone) for methodology effectiveness benchmarking."
    - name: "recurrence_flag"
      expr: recurrence_flag
      comment: "Indicates whether the issue is a recurrence of a prior SCAR, a critical quality system health indicator."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the corrective action was escalated, used to track escalation rates and supplier responsiveness."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the issue was raised for annual SCAR volume and trend analysis."
    - name: "issue_quarter"
      expr: CONCAT(YEAR(issue_date), '-Q', QUARTER(issue_date))
      comment: "Quarter the issue was raised for quarterly corrective action program performance reviews."
  measures:
    - name: "total_corrective_actions"
      expr: COUNT(1)
      comment: "Total number of supplier corrective actions issued. Baseline KPI for SCAR program volume and supplier quality issue frequency."
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Total financial impact of supplier quality issues. Directly quantifies the cost of poor supplier quality for executive business case and supplier development investment decisions."
    - name: "avg_cost_impact_per_scar"
      expr: AVG(CAST(cost_impact_amount AS DOUBLE))
      comment: "Average cost impact per corrective action. Benchmarks issue severity and informs supplier risk tier assignments."
    - name: "total_affected_quantity"
      expr: SUM(CAST(affected_quantity AS DOUBLE))
      comment: "Total quantity of parts or materials affected by supplier quality issues. Measures production exposure and containment scope."
    - name: "recurrence_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recurrence_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that are recurrences of prior issues. Key quality system effectiveness KPI; high recurrence rates indicate ineffective root cause analysis or corrective actions."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corrective actions that required escalation. Measures supplier responsiveness and SCAR program management effectiveness."
    - name: "open_scar_count"
      expr: COUNT(CASE WHEN corrective_action_status NOT IN ('CLOSED', 'CANCELLED') THEN 1 END)
      comment: "Count of open corrective actions. Tracks the active SCAR backlog requiring management attention and supplier follow-up."
    - name: "avg_cycle_time_days"
      expr: AVG(DATEDIFF(closure_date, issue_date))
      comment: "Average days from issue date to closure. Measures SCAR resolution speed; long cycle times indicate supplier responsiveness or complexity issues requiring intervention."
    - name: "avg_containment_cycle_time_days"
      expr: AVG(DATEDIFF(containment_action_date, issue_date))
      comment: "Average days from issue identification to containment action. Measures how quickly suppliers contain quality escapes to protect production."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_qualification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier qualification metrics tracking approval rates, qualification coverage by commodity, expiry risk, and re-qualification needs. Used by procurement and quality leadership to manage the approved supplier base and ensure sourcing compliance."
  source: "`vibe_manufacturing_v1`.`supplier`.`qualification`"
  dimensions:
    - name: "qualification_status"
      expr: qualification_status
      comment: "Current qualification status (e.g., approved, conditional, disqualified, expired) for supply base compliance monitoring."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (e.g., new supplier, re-qualification, commodity extension) for qualification program mix analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category covered by the qualification for spend-category compliance analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating at time of qualification for risk-stratified qualification management."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP level required for the qualification, indicating the depth of production part approval required."
    - name: "re_qualification_eligible"
      expr: re_qualification_eligible
      comment: "Indicates whether the supplier is eligible for re-qualification, used to manage qualification renewal pipeline."
    - name: "certification_required"
      expr: certification_required
      comment: "Indicates whether a certification is required for this qualification, for compliance gate management."
    - name: "qualification_year"
      expr: YEAR(approval_date)
      comment: "Year of qualification approval for annual qualification program volume and trend analysis."
  measures:
    - name: "total_qualifications"
      expr: COUNT(1)
      comment: "Total number of supplier qualifications on record. Baseline measure for qualification program coverage."
    - name: "approved_qualification_count"
      expr: COUNT(CASE WHEN qualification_status = 'APPROVED' THEN 1 END)
      comment: "Count of fully approved qualifications. Measures the size of the compliant approved supplier base."
    - name: "conditional_approval_count"
      expr: COUNT(CASE WHEN qualification_status = 'CONDITIONAL' THEN 1 END)
      comment: "Count of conditionally approved qualifications. Tracks suppliers on probationary status requiring active monitoring and development."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) BETWEEN 0 AND 90 THEN 1 END)
      comment: "Count of qualifications expiring within 90 days. Critical supply continuity risk KPI; triggers re-qualification initiation to prevent sourcing disruptions."
    - name: "expired_qualification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND qualification_status = 'APPROVED' THEN 1 END)
      comment: "Count of qualifications that have expired but remain in approved status. Compliance risk indicator requiring immediate remediation."
    - name: "avg_audit_score_at_qualification"
      expr: AVG(CAST(audit_score AS DOUBLE))
      comment: "Average audit score at time of qualification. Benchmarks the quality bar for supplier approval decisions."
    - name: "avg_qualification_cycle_time_days"
      expr: AVG(DATEDIFF(approval_date, evaluation_start_date))
      comment: "Average days from evaluation start to qualification approval. Measures qualification process efficiency; long cycle times delay new supplier onboarding and sourcing flexibility."
    - name: "disqualified_supplier_count"
      expr: COUNT(CASE WHEN qualification_status = 'DISQUALIFIED' THEN 1 END)
      comment: "Count of disqualified suppliers. Tracks supply base attrition and the need for replacement sourcing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier certification portfolio metrics tracking certification coverage, expiry risk, nonconformance rates, and procurement gate compliance. Used by quality and procurement leadership to ensure supply chain certification compliance and manage renewal programs."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ISO 9001, IATF 16949, AS9100) for standard-specific compliance coverage analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (e.g., active, expired, suspended, revoked) for compliance portfolio health monitoring."
    - name: "issuing_body"
      expr: issuing_body
      comment: "Certification issuing body for accreditation source analysis and recognition scope."
    - name: "certification_level"
      expr: certification_level
      comment: "Level of certification achieved for tiered compliance analysis."
    - name: "business_criticality"
      expr: business_criticality
      comment: "Business criticality of the certification (e.g., mandatory, preferred, informational) for risk-stratified renewal prioritization."
    - name: "procurement_gate_enabled"
      expr: procurement_gate_enabled
      comment: "Indicates whether this certification is a procurement gate, blocking purchasing from non-certified suppliers."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating associated with the certification status for risk-stratified compliance management."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of certification expiry for renewal pipeline planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of supplier certifications on record. Baseline measure for certification portfolio coverage."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'ACTIVE' THEN 1 END)
      comment: "Count of currently active certifications. Measures the compliant certification coverage across the supply base."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN DATEDIFF(expiry_date, CURRENT_DATE()) BETWEEN 0 AND 90 AND certification_status = 'ACTIVE' THEN 1 END)
      comment: "Count of active certifications expiring within 90 days. Critical compliance risk KPI triggering renewal actions to prevent procurement gate failures."
    - name: "expired_active_certification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE() AND certification_status = 'ACTIVE' THEN 1 END)
      comment: "Count of certifications past expiry date but still marked active. Compliance data quality and risk indicator requiring immediate remediation."
    - name: "procurement_gate_at_risk_count"
      expr: COUNT(CASE WHEN procurement_gate_enabled = TRUE AND (certification_status != 'ACTIVE' OR expiry_date < CURRENT_DATE()) THEN 1 END)
      comment: "Count of procurement-gated certifications that are expired or inactive. Directly blocks compliant purchasing; highest-priority compliance remediation KPI."
    - name: "corrective_actions_required_count"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END)
      comment: "Count of certifications with open corrective action requirements. Tracks the volume of certification nonconformances requiring supplier remediation."
    - name: "total_major_nonconformances"
      expr: SUM(CAST(major_nonconformance_count AS BIGINT))
      comment: "Total major nonconformances across all certifications. Measures systemic quality system failures requiring escalated corrective action."
    - name: "total_minor_nonconformances"
      expr: SUM(CAST(minor_nonconformance_count AS BIGINT))
      comment: "Total minor nonconformances across all certifications. Tracks improvement opportunities and early warning signals in supplier quality systems."
    - name: "auto_renewal_enabled_count"
      expr: COUNT(CASE WHEN auto_renewal_enabled = TRUE THEN 1 END)
      comment: "Count of certifications with auto-renewal enabled. Measures the proportion of the certification portfolio under automated renewal management."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_development_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier development plan metrics tracking improvement program effectiveness, KPI achievement rates, cost savings, and closure outcomes. Used by supply chain development teams and procurement leadership to measure ROI of supplier improvement investments."
  source: "`vibe_manufacturing_v1`.`supplier`.`development_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the development plan (e.g., active, completed, cancelled) for pipeline and completion rate analysis."
    - name: "action_type"
      expr: action_type
      comment: "Type of development action (e.g., quality improvement, capacity expansion, cost reduction) for program mix analysis."
    - name: "issue_type"
      expr: issue_type
      comment: "Type of issue driving the development plan for root cause category analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity of the issue addressed by the plan for risk-stratified development program management."
    - name: "priority"
      expr: priority
      comment: "Priority level of the development plan for resource allocation and scheduling decisions."
    - name: "closure_outcome"
      expr: closure_outcome
      comment: "Outcome of closed development plans (e.g., successful, partial, failed) for program effectiveness measurement."
    - name: "plan_start_year"
      expr: YEAR(plan_start_date)
      comment: "Year the development plan was initiated for annual program volume and investment trend analysis."
  measures:
    - name: "total_development_plans"
      expr: COUNT(1)
      comment: "Total number of supplier development plans. Baseline measure for development program scope and investment level."
    - name: "total_estimated_cost_impact"
      expr: SUM(CAST(estimated_cost_impact AS DOUBLE))
      comment: "Total estimated cost impact of development plans. Quantifies the financial exposure driving supplier development investments."
    - name: "total_estimated_savings"
      expr: SUM(CAST(estimated_savings AS DOUBLE))
      comment: "Total estimated savings from development plans. Measures the expected ROI of supplier development program investments."
    - name: "avg_kpi_improvement_pct"
      expr: ROUND(100.0 * AVG((actual_kpi_value - baseline_kpi_value) / NULLIF(baseline_kpi_value, 0)), 2)
      comment: "Average percentage improvement in KPI value from baseline to actual. Primary effectiveness KPI for supplier development programs; measures whether improvement targets are being achieved."
    - name: "avg_target_kpi_value"
      expr: AVG(CAST(target_kpi_value AS DOUBLE))
      comment: "Average target KPI value set in development plans. Benchmarks the ambition level of improvement programs."
    - name: "avg_actual_kpi_value"
      expr: AVG(CAST(actual_kpi_value AS DOUBLE))
      comment: "Average actual KPI value achieved in development plans. Measures realized improvement versus targets."
    - name: "avg_plan_duration_days"
      expr: AVG(DATEDIFF(plan_end_date, plan_start_date))
      comment: "Average planned duration of development plans in days. Informs resource planning and timeline expectations for supplier improvement programs."
    - name: "avg_actual_completion_days"
      expr: AVG(DATEDIFF(actual_completion_date, plan_start_date))
      comment: "Average actual days to complete development plans. Compared against planned duration to measure execution discipline and supplier commitment."
    - name: "successful_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN closure_outcome = 'SUCCESSFUL' THEN 1 END) / NULLIF(COUNT(CASE WHEN plan_status = 'COMPLETED' THEN 1 END), 0), 2)
      comment: "Percentage of completed development plans with successful outcomes. Primary program effectiveness KPI for supplier development ROI reporting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_approved_vendor_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Approved Vendor List (AVL) metrics tracking supply base coverage, quality and delivery ratings, spend targets, and single-source risk. Used by procurement and supply chain leadership to manage sourcing compliance and supply base optimization."
  source: "`vibe_manufacturing_v1`.`supplier`.`approved_vendor_list`"
  filter: avl_status = 'ACTIVE'
  dimensions:
    - name: "avl_status"
      expr: avl_status
      comment: "Status of the AVL entry (e.g., active, inactive, under review) for supply base compliance monitoring."
    - name: "commodity_code"
      expr: commodity_code
      comment: "Commodity code for spend-category supply base analysis and sourcing strategy decisions."
    - name: "material_group"
      expr: material_group
      comment: "Material group for category management and supply base rationalization analysis."
    - name: "geographic_supply_region"
      expr: geographic_supply_region
      comment: "Geographic supply region for supply chain regionalization and risk diversification analysis."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating of the AVL entry for risk-stratified supply base management."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Indicates single-source supply dependency, a critical concentration risk factor for supply chain resilience reviews."
    - name: "ppap_level"
      expr: ppap_level
      comment: "PPAP level required for the AVL entry, indicating production part approval depth."
    - name: "supplier_designation"
      expr: supplier_designation
      comment: "Supplier designation tier (e.g., preferred, approved, conditional) for sourcing priority analysis."
  measures:
    - name: "total_avl_entries"
      expr: COUNT(1)
      comment: "Total number of active AVL entries. Baseline measure for approved supply base breadth."
    - name: "total_annual_spend_target"
      expr: SUM(CAST(annual_spend_target AS DOUBLE))
      comment: "Total annual spend target across all AVL entries. Measures the financial scope of the approved supply base under management."
    - name: "avg_quality_rating"
      expr: AVG(CAST(quality_rating AS DOUBLE))
      comment: "Average quality rating across AVL entries. Primary supply base quality health KPI used in sourcing decisions and supplier rationalization."
    - name: "avg_delivery_rating"
      expr: AVG(CAST(delivery_rating AS DOUBLE))
      comment: "Average delivery performance rating across AVL entries. Tracks supply chain reliability across the approved vendor base."
    - name: "avg_cost_competitiveness_rating"
      expr: AVG(CAST(cost_competitiveness_rating AS DOUBLE))
      comment: "Average cost competitiveness rating across AVL entries. Informs sourcing strategy and supplier rationalization decisions."
    - name: "single_source_entry_count"
      expr: COUNT(CASE WHEN single_source_flag = TRUE THEN 1 END)
      comment: "Count of single-source AVL entries. Measures supply concentration risk requiring dual-sourcing or risk mitigation strategies."
    - name: "single_source_spend_target"
      expr: SUM(CASE WHEN single_source_flag = TRUE THEN annual_spend_target ELSE 0 END)
      comment: "Total annual spend target at risk from single-source dependencies. Quantifies financial exposure from supply concentration for executive risk reporting."
    - name: "avg_moq"
      expr: AVG(CAST(moq AS DOUBLE))
      comment: "Average minimum order quantity across AVL entries. Informs inventory policy and working capital requirements for the approved supply base."
    - name: "certification_required_count"
      expr: COUNT(CASE WHEN certification_required_flag = TRUE THEN 1 END)
      comment: "Count of AVL entries requiring supplier certification. Tracks the scope of certification compliance obligations in the supply base."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier onboarding program metrics tracking cycle times, completion rates, blocking issues, and spend pipeline. Used by procurement and supply chain leadership to manage new supplier activation speed and onboarding program efficiency."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current onboarding status (e.g., in-progress, completed, rejected, on-hold) for pipeline and backlog management."
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding (e.g., new supplier, new site, re-activation) for program mix analysis."
    - name: "commodity_category"
      expr: commodity_category
      comment: "Commodity category for the onboarding request for category-level supply base expansion tracking."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned during onboarding for risk-stratified process management."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the onboarding request for resource allocation and SLA management."
    - name: "blocking_issue_flag"
      expr: blocking_issue_flag
      comment: "Indicates whether a blocking issue is preventing onboarding completion, for escalation and resolution tracking."
    - name: "quality_audit_required_flag"
      expr: quality_audit_required_flag
      comment: "Indicates whether a quality audit is required as part of onboarding, for audit resource planning."
    - name: "request_year"
      expr: YEAR(request_date)
      comment: "Year of the onboarding request for annual new supplier activation volume analysis."
    - name: "request_quarter"
      expr: CONCAT(YEAR(request_date), '-Q', QUARTER(request_date))
      comment: "Quarter of the onboarding request for quarterly supply base expansion trend analysis."
  measures:
    - name: "total_onboarding_requests"
      expr: COUNT(1)
      comment: "Total number of supplier onboarding requests. Baseline measure for new supplier pipeline volume."
    - name: "completed_onboarding_count"
      expr: COUNT(CASE WHEN onboarding_status = 'COMPLETED' THEN 1 END)
      comment: "Count of successfully completed onboardings. Measures new supplier activation throughput."
    - name: "rejected_onboarding_count"
      expr: COUNT(CASE WHEN onboarding_status = 'REJECTED' THEN 1 END)
      comment: "Count of rejected onboarding requests. Tracks supply base qualification failure rate and sourcing pipeline attrition."
    - name: "onboarding_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN onboarding_status = 'COMPLETED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding requests successfully completed. Primary onboarding program effectiveness KPI used in procurement operations reviews."
    - name: "total_estimated_annual_spend_pipeline"
      expr: SUM(CAST(estimated_annual_spend AS DOUBLE))
      comment: "Total estimated annual spend from suppliers in the onboarding pipeline. Quantifies the financial value of new supply base additions for procurement strategy."
    - name: "blocked_onboarding_count"
      expr: COUNT(CASE WHEN blocking_issue_flag = TRUE THEN 1 END)
      comment: "Count of onboardings with active blocking issues. Tracks the volume of stalled activations requiring escalation and resolution."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average onboarding cycle time in days. Measures process efficiency; long cycle times delay supply base expansion and sourcing flexibility."
    - name: "avg_cycle_time_completed_days"
      expr: AVG(CASE WHEN onboarding_status = 'COMPLETED' THEN DATEDIFF(actual_completion_date, request_date) END)
      comment: "Average actual days from request to completion for completed onboardings. Benchmarks end-to-end onboarding speed against SLA targets."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier agreement portfolio metrics tracking contract value, coverage, compliance, and renewal risk. Used by procurement and legal leadership to manage contract portfolio health, renewal obligations, and commercial risk."
  source: "`vibe_manufacturing_v1`.`supplier`.`agreement`"
  filter: agreement_status = 'ACTIVE'
  dimensions:
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of agreement (e.g., MSA, NDA, supply agreement, framework) for contract portfolio mix analysis."
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement (e.g., active, expired, terminated, under negotiation) for portfolio health monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for FX exposure and multi-currency portfolio analysis."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews, for renewal obligation and risk management."
    - name: "esg_compliance_flag"
      expr: esg_compliance_flag
      comment: "Indicates whether the agreement includes ESG compliance clauses, for sustainability program coverage tracking."
    - name: "ip_protection_clause_flag"
      expr: ip_protection_clause_flag
      comment: "Indicates whether the agreement includes IP protection clauses, for intellectual property risk management."
    - name: "governing_law"
      expr: governing_law
      comment: "Governing law jurisdiction of the agreement for legal risk and compliance analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year the agreement became effective for contract vintage and renewal cycle analysis."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(1)
      comment: "Total number of active supplier agreements. Baseline measure for contract portfolio coverage."
    - name: "total_contract_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total value of active supplier agreements. Primary commercial KPI for procurement portfolio management and spend under contract reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_value AS DOUBLE))
      comment: "Average value per supplier agreement. Benchmarks contract size and informs negotiation strategy."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN DATEDIFF(effective_end_date, CURRENT_DATE()) BETWEEN 0 AND 90 THEN 1 END)
      comment: "Count of agreements expiring within 90 days. Critical commercial risk KPI triggering renewal negotiations to prevent supply disruption."
    - name: "expiring_within_90_days_value"
      expr: SUM(CASE WHEN DATEDIFF(effective_end_date, CURRENT_DATE()) BETWEEN 0 AND 90 THEN total_value ELSE 0 END)
      comment: "Total value of agreements expiring within 90 days. Quantifies the commercial exposure from near-term contract renewals."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END)
      comment: "Count of agreements with auto-renewal enabled. Tracks the proportion of the portfolio under automated renewal management."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms AS DOUBLE))
      comment: "Average payment terms (days) across active agreements. Used by treasury to manage working capital and standardize payment terms across the supply base."
    - name: "esg_compliant_agreement_count"
      expr: COUNT(CASE WHEN esg_compliance_flag = TRUE THEN 1 END)
      comment: "Count of agreements with ESG compliance clauses. Tracks sustainability program coverage in the supplier contract portfolio."
    - name: "avg_discount_terms"
      expr: AVG(CAST(discount_terms AS DOUBLE))
      comment: "Average discount terms value across agreements. Measures commercial benefit captured through negotiated supplier discounts."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier audit finding metrics tracking finding severity distribution, closure rates, recurrence, and CAPA linkage. Used by quality leadership to manage audit finding resolution, identify systemic supplier quality issues, and measure audit program effectiveness."
  source: "`vibe_manufacturing_v1`.`supplier`.`supplier_audit_finding`"
  dimensions:
    - name: "finding_type"
      expr: finding_type
      comment: "Type of audit finding (e.g., major nonconformance, minor nonconformance, observation) for severity distribution analysis."
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding for risk-stratified resolution management and escalation routing."
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., open, in-progress, closed, verified) for backlog and closure rate management."
    - name: "process_area"
      expr: process_area
      comment: "Process area where the finding was identified for Pareto analysis of systemic quality system weaknesses."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category of the finding for systemic issue identification and prevention program targeting."
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Indicates whether the finding is a repeat of a prior audit finding, a critical quality system effectiveness indicator."
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether a corrective action is required for the finding, for CAPA obligation tracking."
    - name: "identified_year"
      expr: YEAR(identified_date)
      comment: "Year the finding was identified for annual finding volume and trend analysis."
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings. Baseline measure for audit finding volume and quality system compliance status."
    - name: "open_finding_count"
      expr: COUNT(CASE WHEN finding_status NOT IN ('CLOSED', 'VERIFIED') THEN 1 END)
      comment: "Count of open audit findings. Tracks the active remediation backlog requiring supplier action and follow-up."
    - name: "repeat_finding_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_finding_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that are repeats of prior audit findings. Key quality system effectiveness KPI; high repeat rates indicate ineffective corrective actions or systemic supplier quality system failures."
    - name: "finding_closure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN finding_status IN ('CLOSED', 'VERIFIED') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of findings that have been closed or verified. Measures audit finding resolution effectiveness and supplier responsiveness."
    - name: "avg_closure_cycle_time_days"
      expr: AVG(CASE WHEN finding_status IN ('CLOSED', 'VERIFIED') THEN DATEDIFF(closure_date, identified_date) END)
      comment: "Average days from finding identification to closure. Measures supplier responsiveness and corrective action implementation speed."
    - name: "escalated_finding_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Count of findings that required escalation. Tracks the volume of findings where normal resolution processes were insufficient."
    - name: "capa_linked_finding_count"
      expr: COUNT(CASE WHEN corrective_action_required = TRUE THEN 1 END)
      comment: "Count of findings requiring corrective action. Measures the scope of formal CAPA obligations generated by the audit program."
    - name: "overdue_finding_count"
      expr: COUNT(CASE WHEN due_date < CURRENT_DATE() AND finding_status NOT IN ('CLOSED', 'VERIFIED') THEN 1 END)
      comment: "Count of findings past their due date and not yet closed. Critical escalation KPI for supplier quality management; overdue findings indicate non-compliance with corrective action commitments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_risk_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated risk assessment metrics for suppliers."
  source: "`vibe_manufacturing_v1`.`supplier`.`risk_rating`"
  dimensions:
    - name: "supplier_id"
      expr: supplier_id
      comment: "Identifier of the supplier"
    - name: "overall_risk_tier"
      expr: overall_risk_tier
      comment: "Overall risk tier classification"
    - name: "country_risk_rating"
      expr: country_risk_rating
      comment: "Country-level risk rating"
    - name: "assessment_year"
      expr: YEAR(assessment_period_start_date)
      comment: "Year of the risk assessment period"
  measures:
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score"
    - name: "avg_financial_risk_score"
      expr: AVG(CAST(financial_risk_score AS DOUBLE))
      comment: "Average financial risk score"
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score"
    - name: "risk_rating_count"
      expr: COUNT(1)
      comment: "Number of risk rating records"
    - name: "high_overall_risk_count"
      expr: SUM(CASE WHEN overall_risk_score > 80 THEN 1 ELSE 0 END)
      comment: "Count of high overall risk scores (>80)"
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`supplier_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Site-level capacity and quality performance metrics."
  source: "`vibe_manufacturing_v1`.`supplier`.`site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the site"
    - name: "site_type"
      expr: site_type
      comment: "Type/category of the site"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the site"
    - name: "country_code"
      expr: country_code
      comment: "Country code where the site is located"
    - name: "site_name"
      expr: site_name
      comment: "Descriptive name of the site"
    - name: "active_year"
      expr: YEAR(active_from_date)
      comment: "Year the site became active"
  measures:
    - name: "avg_delivery_performance_score"
      expr: AVG(CAST(delivery_performance_score AS DOUBLE))
      comment: "Average delivery performance score across sites"
    - name: "total_production_capacity_annual"
      expr: SUM(CAST(production_capacity_annual AS DOUBLE))
      comment: "Total annual production capacity across all sites"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality score across sites"
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of supplier sites"
$$;