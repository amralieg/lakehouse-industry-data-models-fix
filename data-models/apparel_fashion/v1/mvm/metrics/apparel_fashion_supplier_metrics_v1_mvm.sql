-- Metric views for domain: supplier | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance KPIs tracking quality, delivery, compliance, and cost competitiveness across evaluation periods"
  source: "`apparel_fashion_ecm`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "evaluation_period_start_date"
      expr: evaluation_period_start_date
      comment: "Start date of the vendor evaluation period"
    - name: "evaluation_period_end_date"
      expr: evaluation_period_end_date
      comment: "End date of the vendor evaluation period"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Current status of the vendor evaluation (e.g., Draft, Approved, Final)"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Vendor performance tier classification (e.g., Platinum, Gold, Silver, Bronze)"
    - name: "previous_tier"
      expr: previous_tier
      comment: "Previous performance tier for trend analysis"
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Indicates whether the vendor tier changed in this evaluation period"
    - name: "remediation_plan_required_flag"
      expr: remediation_plan_required_flag
      comment: "Indicates whether a remediation plan is required for underperformance"
    - name: "evaluation_frequency"
      expr: evaluation_frequency
      comment: "Frequency of vendor evaluations (e.g., Monthly, Quarterly, Annual)"
    - name: "evaluator_role"
      expr: evaluator_role
      comment: "Role of the person conducting the evaluation"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated"
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_po_value_usd AS DOUBLE))
      comment: "Total purchase order value in USD across all evaluated vendors"
    - name: "avg_overall_weighted_score"
      expr: AVG(CAST(overall_weighted_score AS DOUBLE))
      comment: "Average overall weighted vendor performance score"
    - name: "avg_otif_rate_percent"
      expr: AVG(CAST(otif_rate_percent AS DOUBLE))
      comment: "Average on-time in-full delivery rate percentage across vendors"
    - name: "avg_aql_defect_rate_percent"
      expr: AVG(CAST(aql_defect_rate_percent AS DOUBLE))
      comment: "Average acceptable quality level defect rate percentage"
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_score AS DOUBLE))
      comment: "Average compliance audit score across vendors"
    - name: "avg_cost_competitiveness_index"
      expr: AVG(CAST(cost_competitiveness_index AS DOUBLE))
      comment: "Average cost competitiveness index measuring vendor pricing efficiency"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score reflecting ESG performance"
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization percentage across vendors"
    - name: "avg_claim_rate_percent"
      expr: AVG(CAST(claim_rate_percent AS DOUBLE))
      comment: "Average claim rate percentage indicating quality issues"
    - name: "avg_order_fill_rate_percent"
      expr: AVG(CAST(order_fill_rate_percent AS DOUBLE))
      comment: "Average order fill rate percentage measuring fulfillment capability"
    - name: "avg_innovation_score"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation score reflecting vendor product development capability"
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average responsiveness rating measuring vendor communication and agility"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance audit KPIs tracking factory social, environmental, and ethical compliance performance"
  source: "`apparel_fashion_ecm`.`supplier`.`compliance_audit`"
  dimensions:
    - name: "audit_date"
      expr: audit_date
      comment: "Date the compliance audit was conducted"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Social, Environmental, Health & Safety)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Scheduled, In Progress, Completed)"
    - name: "final_audit_status"
      expr: final_audit_status
      comment: "Final outcome status of the audit (e.g., Pass, Conditional Pass, Fail)"
    - name: "audit_grade"
      expr: audit_grade
      comment: "Letter grade assigned to the audit (e.g., A, B, C, D, F)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned based on audit findings (e.g., Low, Medium, High, Critical)"
    - name: "audit_framework"
      expr: audit_framework
      comment: "Audit framework or standard used (e.g., WRAP, BSCI, SA8000)"
    - name: "auditing_firm"
      expr: auditing_firm
      comment: "Third-party auditing firm that conducted the audit"
    - name: "announced_flag"
      expr: announced_flag
      comment: "Indicates whether the audit was announced or unannounced"
    - name: "reaudit_required_flag"
      expr: reaudit_required_flag
      comment: "Indicates whether a re-audit is required due to findings"
    - name: "cap_required_flag"
      expr: cap_required_flag
      comment: "Indicates whether a corrective action plan is required"
    - name: "cap_approved_flag"
      expr: cap_approved_flag
      comment: "Indicates whether the corrective action plan has been approved"
  measures:
    - name: "audit_count"
      expr: COUNT(DISTINCT compliance_audit_id)
      comment: "Total number of compliance audits conducted"
    - name: "factory_count"
      expr: COUNT(DISTINCT production_factory_id)
      comment: "Number of unique factories audited"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors audited"
    - name: "avg_factory_score"
      expr: AVG(CAST(factory_score AS DOUBLE))
      comment: "Average factory compliance score across all audits"
    - name: "total_audit_cost_amount"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total cost of compliance audits conducted"
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average duration of audits in days"
    - name: "reaudit_required_count"
      expr: SUM(CASE WHEN reaudit_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring re-audit due to critical findings"
    - name: "cap_required_count"
      expr: SUM(CASE WHEN cap_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of audits requiring corrective action plans"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit finding KPIs tracking non-conformances, corrective actions, and remediation effectiveness"
  source: "`apparel_fashion_ecm`.`supplier`.`audit_finding`"
  dimensions:
    - name: "finding_identified_date"
      expr: finding_identified_date
      comment: "Date the audit finding was identified"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the finding (e.g., Critical, Major, Minor, Observation)"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the finding (e.g., Labor Rights, Health & Safety, Environment)"
    - name: "finding_subcategory"
      expr: finding_subcategory
      comment: "Subcategory providing more granular classification"
    - name: "closure_status"
      expr: closure_status
      comment: "Current closure status of the finding (e.g., Open, In Progress, Closed, Overdue)"
    - name: "corrective_action_required"
      expr: corrective_action_required
      comment: "Indicates whether corrective action is required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the finding has been escalated"
    - name: "repeat_finding_flag"
      expr: repeat_finding_flag
      comment: "Indicates whether this is a repeat finding from previous audits"
    - name: "verification_method"
      expr: verification_method
      comment: "Method used to verify closure of the finding"
    - name: "responsible_party_title"
      expr: responsible_party_title
      comment: "Title of the person responsible for remediation"
  measures:
    - name: "finding_count"
      expr: COUNT(DISTINCT audit_finding_id)
      comment: "Total number of audit findings identified"
    - name: "total_cost_to_remediate"
      expr: SUM(CAST(cost_to_remediate AS DOUBLE))
      comment: "Total estimated cost to remediate all findings"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all findings"
    - name: "critical_finding_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity findings requiring immediate action"
    - name: "repeat_finding_count"
      expr: SUM(CASE WHEN repeat_finding_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of repeat findings indicating systemic issues"
    - name: "escalated_finding_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of findings escalated to senior management"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Production delivery schedule KPIs tracking time-and-action milestone adherence and critical path performance"
  source: "`apparel_fashion_ecm`.`supplier`.`delivery_schedule`"
  dimensions:
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the delivery schedule (e.g., On Track, At Risk, Delayed, Completed)"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether this schedule is on the critical path for delivery"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the schedule has been escalated due to delays"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason for schedule escalation"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated for this production schedule"
    - name: "shipment_terms"
      expr: shipment_terms
      comment: "Shipment terms (e.g., FOB, CIF, DDP)"
    - name: "tna_template_version"
      expr: tna_template_version
      comment: "Version of the time-and-action template used"
  measures:
    - name: "schedule_count"
      expr: COUNT(DISTINCT delivery_schedule_id)
      comment: "Total number of delivery schedules tracked"
    - name: "work_order_count"
      expr: COUNT(DISTINCT work_order_id)
      comment: "Number of unique work orders in delivery schedules"
    - name: "avg_factory_capacity_utilization_pct"
      expr: AVG(CAST(factory_capacity_utilization_pct AS DOUBLE))
      comment: "Average factory capacity utilization percentage across schedules"
    - name: "critical_path_schedule_count"
      expr: SUM(CASE WHEN critical_path_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules on the critical path requiring priority attention"
    - name: "escalated_schedule_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of schedules escalated due to delays or risks"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_capacity_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier capacity planning KPIs tracking available, allocated, and reserved production capacity"
  source: "`apparel_fashion_ecm`.`supplier`.`capacity_profile`"
  dimensions:
    - name: "capacity_type"
      expr: capacity_type
      comment: "Type of capacity (e.g., Cutting, Sewing, Finishing, Packing)"
    - name: "capacity_status"
      expr: capacity_status
      comment: "Current status of capacity (e.g., Available, Allocated, Reserved, Blocked)"
    - name: "capacity_risk_level"
      expr: capacity_risk_level
      comment: "Risk level associated with capacity availability (e.g., Low, Medium, High)"
    - name: "capacity_unit_of_measure"
      expr: capacity_unit_of_measure
      comment: "Unit of measure for capacity (e.g., Units, Dozens, Pieces)"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status of the factory"
    - name: "peak_season_flag"
      expr: peak_season_flag
      comment: "Indicates whether this capacity is during peak season"
    - name: "capacity_valid_from_date"
      expr: capacity_valid_from_date
      comment: "Start date of capacity validity period"
    - name: "capacity_valid_to_date"
      expr: capacity_valid_to_date
      comment: "End date of capacity validity period"
  measures:
    - name: "capacity_profile_count"
      expr: COUNT(DISTINCT capacity_profile_id)
      comment: "Total number of capacity profiles tracked"
    - name: "total_available_capacity_units"
      expr: SUM(CAST(available_capacity_units AS DOUBLE))
      comment: "Total available production capacity units across all suppliers"
    - name: "total_allocated_capacity_units"
      expr: SUM(CAST(allocated_capacity_units AS DOUBLE))
      comment: "Total allocated production capacity units"
    - name: "total_reserved_capacity_units"
      expr: SUM(CAST(reserved_capacity_units AS DOUBLE))
      comment: "Total reserved production capacity units"
    - name: "total_capacity_units_per_month"
      expr: SUM(CAST(capacity_units_per_month AS DOUBLE))
      comment: "Total monthly production capacity units"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage across suppliers"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate percentage"
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average on-time in-full target percentage"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master KPIs tracking onboarding progress, risk profile, and strategic vendor classification"
  source: "`apparel_fashion_ecm`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., Manufacturer, Agent, Trading Company)"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Strategic tier classification (e.g., Tier 1, Tier 2, Tier 3)"
    - name: "business_status"
      expr: business_status
      comment: "Current business status (e.g., Active, Inactive, Suspended, Onboarding)"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current stage in the vendor onboarding process"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the vendor is headquartered"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether this is a preferred strategic vendor"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Indicates whether the vendor is EDI capable for electronic transactions"
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Indicates whether the vendor is eligible for vendor-managed inventory"
    - name: "lc_terms_required_flag"
      expr: lc_terms_required_flag
      comment: "Indicates whether letter of credit terms are required"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total number of vendors in the supplier base"
    - name: "avg_onboarding_completion_percentage"
      expr: AVG(CAST(onboarding_completion_percentage AS DOUBLE))
      comment: "Average onboarding completion percentage across vendors"
    - name: "avg_quality_rating_score"
      expr: AVG(CAST(quality_rating_score AS DOUBLE))
      comment: "Average quality rating score across vendors"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across vendor base"
    - name: "total_moq_value"
      expr: SUM(CAST(moq_value AS DOUBLE))
      comment: "Total minimum order quantity value across all vendors"
    - name: "preferred_vendor_count"
      expr: SUM(CASE WHEN preferred_vendor_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of preferred strategic vendors"
    - name: "edi_capable_vendor_count"
      expr: SUM(CASE WHEN edi_capable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EDI-capable vendors for digital integration"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk assessment KPIs tracking inherent and residual risk across categories and mitigation effectiveness"
  source: "`apparel_fashion_ecm`.`supplier`.`risk_assessment`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date the risk assessment was conducted"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., Initial, Periodic, Event-Driven)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (e.g., Draft, In Review, Approved)"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., Financial, Operational, Compliance, Reputational)"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory providing more granular risk classification"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before mitigation (e.g., Low, Medium, High, Critical)"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after mitigation controls"
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of risk mitigation efforts (e.g., Not Started, In Progress, Completed)"
    - name: "esg_flag"
      expr: esg_flag
      comment: "Indicates whether this is an ESG-related risk"
    - name: "business_impact_area"
      expr: business_impact_area
      comment: "Business area impacted by the risk"
  measures:
    - name: "risk_assessment_count"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total number of risk assessments conducted"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors assessed for risk"
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost AS DOUBLE))
      comment: "Total cost of risk mitigation activities"
    - name: "high_risk_count"
      expr: SUM(CASE WHEN inherent_risk_rating IN ('High', 'Critical') THEN 1 ELSE 0 END)
      comment: "Count of high or critical inherent risk assessments requiring priority mitigation"
    - name: "esg_risk_count"
      expr: SUM(CASE WHEN esg_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of ESG-related risks requiring sustainability focus"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_material_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material supplier KPIs tracking raw material sourcing, sustainability attributes, and supplier qualification"
  source: "`apparel_fashion_ecm`.`supplier`.`material_supplier`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the material supplier (e.g., Approved, Pending, Rejected)"
    - name: "material_type"
      expr: material_type
      comment: "Type of material supplied (e.g., Fabric, Trim, Packaging)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the material originates"
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the material supplier relationship is currently active"
    - name: "preferred_supplier_flag"
      expr: preferred_supplier_flag
      comment: "Indicates whether this is a preferred material supplier"
    - name: "is_organic"
      expr: is_organic
      comment: "Indicates whether the material is certified organic"
    - name: "is_recycled"
      expr: is_recycled
      comment: "Indicates whether the material contains recycled content"
    - name: "is_bci_cotton"
      expr: is_bci_cotton
      comment: "Indicates whether cotton is Better Cotton Initiative certified"
    - name: "is_oeko_tex_certified"
      expr: is_oeko_tex_certified
      comment: "Indicates whether the material is Oeko-Tex certified for safety"
    - name: "quality_rating"
      expr: quality_rating
      comment: "Quality rating of the material supplier"
    - name: "delivery_performance_rating"
      expr: delivery_performance_rating
      comment: "Delivery performance rating of the material supplier"
  measures:
    - name: "material_supplier_count"
      expr: COUNT(DISTINCT material_supplier_id)
      comment: "Total number of material supplier relationships"
    - name: "material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Number of unique materials sourced"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all material suppliers"
    - name: "total_capacity_per_month"
      expr: SUM(CAST(capacity_per_month AS DOUBLE))
      comment: "Total monthly material supply capacity"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across material suppliers"
    - name: "sustainable_material_supplier_count"
      expr: SUM(CASE WHEN (is_organic = TRUE OR is_recycled = TRUE OR is_bci_cotton = TRUE) THEN 1 ELSE 0 END)
      comment: "Count of material suppliers providing sustainable materials"
    - name: "oeko_tex_certified_count"
      expr: SUM(CASE WHEN is_oeko_tex_certified = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Oeko-Tex certified material suppliers ensuring chemical safety"
$$;