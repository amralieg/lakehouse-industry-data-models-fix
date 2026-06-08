-- Metric views for domain: supplier | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_vendor_scorecard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic vendor performance KPIs tracking quality, delivery, compliance, and cost competitiveness for supplier steering decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`vendor_scorecard`"
  dimensions:
    - name: "evaluation_period_start_date"
      expr: evaluation_period_start_date
      comment: "Start date of the evaluation period for time-series analysis"
    - name: "evaluation_period_end_date"
      expr: evaluation_period_end_date
      comment: "End date of the evaluation period for time-series analysis"
    - name: "evaluation_year"
      expr: YEAR(evaluation_period_start_date)
      comment: "Year of evaluation for annual trending"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_period_start_date), '-', YEAR(evaluation_period_start_date))
      comment: "Quarter of evaluation for quarterly business reviews"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Vendor performance tier classification (e.g., Platinum, Gold, Silver, Bronze)"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Status of the scorecard evaluation (e.g., Draft, Approved, Final)"
    - name: "tier_change_flag"
      expr: tier_change_flag
      comment: "Indicates whether vendor tier changed during this evaluation period"
    - name: "remediation_plan_required_flag"
      expr: remediation_plan_required_flag
      comment: "Indicates whether vendor requires remediation plan due to poor performance"
    - name: "evaluator_role"
      expr: evaluator_role
      comment: "Role of the employee conducting the evaluation"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated - key for supplier base sizing decisions"
    - name: "avg_overall_weighted_score"
      expr: AVG(CAST(overall_weighted_score AS DOUBLE))
      comment: "Average overall vendor performance score - primary steering KPI for supplier portfolio health"
    - name: "avg_otif_rate_percent"
      expr: AVG(CAST(otif_rate_percent AS DOUBLE))
      comment: "Average on-time in-full delivery rate - critical supply chain reliability KPI"
    - name: "avg_aql_defect_rate_percent"
      expr: AVG(CAST(aql_defect_rate_percent AS DOUBLE))
      comment: "Average acceptable quality level defect rate - key quality steering metric"
    - name: "avg_compliance_audit_score"
      expr: AVG(CAST(compliance_audit_score AS DOUBLE))
      comment: "Average compliance audit score - critical for risk management and ethical sourcing decisions"
    - name: "avg_sustainability_score"
      expr: AVG(CAST(sustainability_score AS DOUBLE))
      comment: "Average sustainability score - strategic ESG performance indicator"
    - name: "avg_cost_competitiveness_index"
      expr: AVG(CAST(cost_competitiveness_index AS DOUBLE))
      comment: "Average cost competitiveness index - key for sourcing cost optimization decisions"
    - name: "avg_capacity_utilization_percent"
      expr: AVG(CAST(capacity_utilization_percent AS DOUBLE))
      comment: "Average capacity utilization - informs capacity planning and allocation decisions"
    - name: "total_po_value_usd"
      expr: SUM(CAST(total_po_value_usd AS DOUBLE))
      comment: "Total purchase order value in USD - measures vendor business volume for strategic sourcing decisions"
    - name: "avg_claim_rate_percent"
      expr: AVG(CAST(claim_rate_percent AS DOUBLE))
      comment: "Average claim rate percentage - indicates quality and service issues requiring intervention"
    - name: "avg_order_fill_rate_percent"
      expr: AVG(CAST(order_fill_rate_percent AS DOUBLE))
      comment: "Average order fill rate - measures vendor ability to meet demand"
    - name: "avg_pp_sample_approval_rate_percent"
      expr: AVG(CAST(pp_sample_approval_rate_percent AS DOUBLE))
      comment: "Average pre-production sample approval rate - indicates design-to-production efficiency"
    - name: "avg_responsiveness_rating"
      expr: AVG(CAST(responsiveness_rating AS DOUBLE))
      comment: "Average responsiveness rating - measures vendor collaboration quality"
    - name: "avg_innovation_score"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation score - strategic metric for product development partnerships"
    - name: "vendors_requiring_remediation"
      expr: COUNT(DISTINCT CASE WHEN remediation_plan_required_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors requiring remediation plans - triggers intervention actions"
    - name: "vendors_with_tier_change"
      expr: COUNT(DISTINCT CASE WHEN tier_change_flag = TRUE THEN vendor_id END)
      comment: "Count of vendors with tier changes - indicates portfolio dynamics requiring review"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and ethical sourcing audit KPIs for risk management and regulatory steering decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`compliance_audit`"
  dimensions:
    - name: "audit_date"
      expr: audit_date
      comment: "Date of the audit for time-series compliance tracking"
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year of audit for annual compliance reporting"
    - name: "audit_quarter"
      expr: CONCAT('Q', QUARTER(audit_date), '-', YEAR(audit_date))
      comment: "Quarter of audit for quarterly compliance reviews"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Social, Environmental, Quality, Safety)"
    - name: "audit_framework"
      expr: audit_framework
      comment: "Audit framework used (e.g., WRAP, BSCI, SA8000, ISO)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Scheduled, In Progress, Completed)"
    - name: "final_audit_status"
      expr: final_audit_status
      comment: "Final audit outcome status (e.g., Passed, Failed, Conditional)"
    - name: "audit_grade"
      expr: audit_grade
      comment: "Audit grade assigned (e.g., A, B, C, D, F)"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the supplier (e.g., Low, Medium, High, Critical)"
    - name: "announced_flag"
      expr: announced_flag
      comment: "Whether audit was announced or unannounced - impacts audit rigor"
    - name: "reaudit_required_flag"
      expr: reaudit_required_flag
      comment: "Indicates whether re-audit is required due to findings"
    - name: "cap_required_flag"
      expr: cap_required_flag
      comment: "Indicates whether corrective action plan is required"
    - name: "cap_approved_flag"
      expr: cap_approved_flag
      comment: "Indicates whether corrective action plan has been approved"
    - name: "auditing_firm"
      expr: auditing_firm
      comment: "Third-party auditing firm conducting the audit"
  measures:
    - name: "audit_count"
      expr: COUNT(DISTINCT compliance_audit_id)
      comment: "Total number of compliance audits conducted - measures audit coverage"
    - name: "supplier_factory_count"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique supplier factories audited - key for supply chain visibility"
    - name: "avg_factory_score"
      expr: AVG(CAST(factory_score AS DOUBLE))
      comment: "Average factory compliance score - primary compliance health indicator"
    - name: "total_audit_cost_amount"
      expr: SUM(CAST(audit_cost_amount AS DOUBLE))
      comment: "Total audit cost - informs compliance program budget decisions"
    - name: "avg_audit_duration_days"
      expr: AVG(CAST(audit_duration_days AS DOUBLE))
      comment: "Average audit duration in days - measures audit efficiency"
    - name: "audits_requiring_reaudit"
      expr: COUNT(DISTINCT CASE WHEN reaudit_required_flag = TRUE THEN compliance_audit_id END)
      comment: "Count of audits requiring re-audit - triggers escalation and intervention"
    - name: "audits_requiring_cap"
      expr: COUNT(DISTINCT CASE WHEN cap_required_flag = TRUE THEN compliance_audit_id END)
      comment: "Count of audits requiring corrective action plans - measures non-compliance severity"
    - name: "high_risk_factories"
      expr: COUNT(DISTINCT CASE WHEN risk_rating IN ('High', 'Critical') THEN supplier_factory_id END)
      comment: "Count of high-risk factories - critical for risk mitigation prioritization"
    - name: "avg_worker_interviews_count"
      expr: AVG(CAST(worker_interviews_count AS DOUBLE))
      comment: "Average number of worker interviews per audit - indicates audit thoroughness"
    - name: "cap_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cap_approved_flag = TRUE THEN compliance_audit_id END) / NULLIF(COUNT(DISTINCT CASE WHEN cap_required_flag = TRUE THEN compliance_audit_id END), 0), 2)
      comment: "Percentage of required CAPs that have been approved - measures remediation progress"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_capacity_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier capacity planning and utilization KPIs for production allocation and sourcing decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`capacity_profile`"
  dimensions:
    - name: "capacity_valid_from_date"
      expr: capacity_valid_from_date
      comment: "Start date of capacity validity period"
    - name: "capacity_valid_to_date"
      expr: capacity_valid_to_date
      comment: "End date of capacity validity period"
    - name: "capacity_year"
      expr: YEAR(capacity_valid_from_date)
      comment: "Year of capacity for annual capacity planning"
    - name: "capacity_month"
      expr: DATE_TRUNC('MONTH', capacity_valid_from_date)
      comment: "Month of capacity for monthly production planning"
    - name: "capacity_status"
      expr: capacity_status
      comment: "Status of capacity (e.g., Confirmed, Tentative, Expired)"
    - name: "capacity_type"
      expr: capacity_type
      comment: "Type of capacity (e.g., Regular, Overtime, Peak Season)"
    - name: "capacity_risk_level"
      expr: capacity_risk_level
      comment: "Risk level of capacity availability (e.g., Low, Medium, High)"
    - name: "product_category"
      expr: product_category
      comment: "Product category for capacity specialization analysis"
    - name: "product_subcategory"
      expr: product_subcategory
      comment: "Product subcategory for detailed capacity planning"
    - name: "peak_season_flag"
      expr: peak_season_flag
      comment: "Indicates whether capacity is for peak season"
    - name: "compliance_certification_status"
      expr: compliance_certification_status
      comment: "Compliance certification status of the capacity provider"
    - name: "capacity_unit_of_measure"
      expr: capacity_unit_of_measure
      comment: "Unit of measure for capacity (e.g., units, dozens, pieces)"
  measures:
    - name: "capacity_profile_count"
      expr: COUNT(DISTINCT capacity_profile_id)
      comment: "Number of capacity profiles - measures capacity planning coverage"
    - name: "supplier_factory_count"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique supplier factories with capacity profiles"
    - name: "total_capacity_units_per_month"
      expr: SUM(CAST(capacity_units_per_month AS DOUBLE))
      comment: "Total monthly capacity units available - key for production planning decisions"
    - name: "total_allocated_capacity_units"
      expr: SUM(CAST(allocated_capacity_units AS DOUBLE))
      comment: "Total allocated capacity units - measures committed production volume"
    - name: "total_available_capacity_units"
      expr: SUM(CAST(available_capacity_units AS DOUBLE))
      comment: "Total available capacity units - indicates open capacity for new orders"
    - name: "total_reserved_capacity_units"
      expr: SUM(CAST(reserved_capacity_units AS DOUBLE))
      comment: "Total reserved capacity units - measures pre-committed capacity"
    - name: "avg_utilization_percentage"
      expr: AVG(CAST(utilization_percentage AS DOUBLE))
      comment: "Average capacity utilization percentage - critical efficiency and planning KPI"
    - name: "avg_otif_target_percentage"
      expr: AVG(CAST(otif_target_percentage AS DOUBLE))
      comment: "Average on-time in-full target percentage - measures delivery commitment level"
    - name: "avg_quality_acceptance_rate"
      expr: AVG(CAST(quality_acceptance_rate AS DOUBLE))
      comment: "Average quality acceptance rate - indicates expected quality performance"
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity - informs order sizing decisions"
    - name: "avg_maximum_order_quantity"
      expr: AVG(CAST(maximum_order_quantity AS DOUBLE))
      comment: "Average maximum order quantity - indicates capacity constraints"
    - name: "high_risk_capacity_profiles"
      expr: COUNT(DISTINCT CASE WHEN capacity_risk_level = 'High' THEN capacity_profile_id END)
      comment: "Count of high-risk capacity profiles - triggers risk mitigation actions"
    - name: "peak_season_capacity_profiles"
      expr: COUNT(DISTINCT CASE WHEN peak_season_flag = TRUE THEN capacity_profile_id END)
      comment: "Count of peak season capacity profiles - informs seasonal planning"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time and action (TNA) delivery schedule performance KPIs for production timeline management and OTIF steering"
  source: "`apparel_fashion_ecm`.`supplier`.`delivery_schedule`"
  dimensions:
    - name: "schedule_start_date"
      expr: schedule_start_date
      comment: "Start date of the delivery schedule"
    - name: "schedule_year"
      expr: YEAR(schedule_start_date)
      comment: "Year of schedule for annual production planning"
    - name: "schedule_quarter"
      expr: CONCAT('Q', QUARTER(schedule_start_date), '-', YEAR(schedule_start_date))
      comment: "Quarter of schedule for quarterly production reviews"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Status of the delivery schedule (e.g., On Track, At Risk, Delayed, Completed)"
    - name: "season_code"
      expr: season_code
      comment: "Season code for seasonal production analysis"
    - name: "critical_path_flag"
      expr: critical_path_flag
      comment: "Indicates whether schedule is on critical path - requires priority attention"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether schedule has been escalated due to delays"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason for schedule escalation"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms for the delivery schedule"
    - name: "shipment_terms"
      expr: shipment_terms
      comment: "Shipment terms (Incoterms) for the delivery"
  measures:
    - name: "delivery_schedule_count"
      expr: COUNT(DISTINCT delivery_schedule_id)
      comment: "Total number of delivery schedules - measures production pipeline volume"
    - name: "supplier_factory_count"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique supplier factories in production - measures factory engagement"
    - name: "avg_factory_capacity_utilization_pct"
      expr: AVG(CAST(factory_capacity_utilization_pct AS DOUBLE))
      comment: "Average factory capacity utilization - key production efficiency indicator"
    - name: "schedules_on_critical_path"
      expr: COUNT(DISTINCT CASE WHEN critical_path_flag = TRUE THEN delivery_schedule_id END)
      comment: "Count of schedules on critical path - requires priority management attention"
    - name: "escalated_schedules"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN delivery_schedule_id END)
      comment: "Count of escalated schedules - triggers intervention and root cause analysis"
    - name: "critical_path_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN critical_path_flag = TRUE THEN delivery_schedule_id END) / NULLIF(COUNT(DISTINCT delivery_schedule_id), 0), 2)
      comment: "Percentage of schedules on critical path - measures production risk exposure"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN delivery_schedule_id END) / NULLIF(COUNT(DISTINCT delivery_schedule_id), 0), 2)
      comment: "Percentage of schedules escalated - key delivery risk indicator requiring action"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_sustainability_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ESG and sustainability performance KPIs for ethical sourcing and corporate responsibility steering decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`sustainability_profile`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date of sustainability assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual ESG reporting"
    - name: "profile_status"
      expr: profile_status
      comment: "Status of the sustainability profile (e.g., Active, Under Review, Expired)"
    - name: "esg_reporting_framework"
      expr: esg_reporting_framework
      comment: "ESG reporting framework used (e.g., GRI, SASB, CDP)"
    - name: "traceability_level"
      expr: traceability_level
      comment: "Level of supply chain traceability (e.g., Tier 1, Tier 2, Full)"
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Status of corrective action plan for sustainability issues"
    - name: "bci_certified_flag"
      expr: bci_certified_flag
      comment: "Better Cotton Initiative certification status"
    - name: "gots_certified_flag"
      expr: gots_certified_flag
      comment: "Global Organic Textile Standard certification status"
    - name: "oeko_tex_certified_flag"
      expr: oeko_tex_certified_flag
      comment: "OEKO-TEX certification status"
    - name: "bluesign_certified_flag"
      expr: bluesign_certified_flag
      comment: "Bluesign certification status"
    - name: "iso_14001_certified_flag"
      expr: iso_14001_certified_flag
      comment: "ISO 14001 environmental management certification status"
    - name: "living_wage_compliant_flag"
      expr: living_wage_compliant_flag
      comment: "Living wage compliance status - critical social responsibility indicator"
  measures:
    - name: "sustainability_profile_count"
      expr: COUNT(DISTINCT sustainability_profile_id)
      comment: "Number of sustainability profiles - measures ESG program coverage"
    - name: "supplier_factory_count"
      expr: COUNT(DISTINCT supplier_factory_id)
      comment: "Number of unique supplier factories with sustainability profiles"
    - name: "avg_higg_fem_score"
      expr: AVG(CAST(higg_fem_score AS DOUBLE))
      comment: "Average Higg FEM environmental score - key environmental performance indicator"
    - name: "avg_higg_fslm_score"
      expr: AVG(CAST(higg_fslm_score AS DOUBLE))
      comment: "Average Higg FSLM social/labor score - key social responsibility indicator"
    - name: "avg_carbon_footprint_tco2e_year"
      expr: AVG(CAST(carbon_footprint_tco2e_year AS DOUBLE))
      comment: "Average carbon footprint in tCO2e per year - critical climate impact metric"
    - name: "avg_renewable_energy_percentage"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy percentage - measures clean energy adoption"
    - name: "avg_waste_diversion_rate_percentage"
      expr: AVG(CAST(waste_diversion_rate_percentage AS DOUBLE))
      comment: "Average waste diversion rate - measures circular economy progress"
    - name: "avg_water_usage_intensity_liters_kg"
      expr: AVG(CAST(water_usage_intensity_liters_kg AS DOUBLE))
      comment: "Average water usage intensity in liters per kg - key water stewardship metric"
    - name: "avg_gender_equality_score"
      expr: AVG(CAST(gender_equality_score AS DOUBLE))
      comment: "Average gender equality score - measures diversity and inclusion progress"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average sustainability risk score - informs risk mitigation prioritization"
    - name: "living_wage_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN living_wage_compliant_flag = TRUE THEN sustainability_profile_id END) / NULLIF(COUNT(DISTINCT sustainability_profile_id), 0), 2)
      comment: "Percentage of suppliers compliant with living wage - critical social responsibility KPI"
    - name: "bci_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN bci_certified_flag = TRUE THEN sustainability_profile_id END) / NULLIF(COUNT(DISTINCT sustainability_profile_id), 0), 2)
      comment: "Percentage of suppliers with BCI certification - measures sustainable cotton sourcing"
    - name: "gots_certification_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN gots_certified_flag = TRUE THEN sustainability_profile_id END) / NULLIF(COUNT(DISTINCT sustainability_profile_id), 0), 2)
      comment: "Percentage of suppliers with GOTS certification - measures organic textile sourcing"
    - name: "zdhc_compliant_suppliers"
      expr: COUNT(DISTINCT CASE WHEN zdhc_mrsl_compliant_flag = TRUE THEN supplier_factory_id END)
      comment: "Count of ZDHC MRSL compliant suppliers - critical chemical management indicator"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_vendor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor master data and onboarding KPIs for supplier portfolio management and strategic sourcing decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`vendor`"
  dimensions:
    - name: "vendor_type"
      expr: vendor_type
      comment: "Type of vendor (e.g., CMT, OEM, ODM, Material Supplier)"
    - name: "business_status"
      expr: business_status
      comment: "Business status of vendor (e.g., Active, Inactive, Suspended, Onboarding)"
    - name: "tier_classification"
      expr: tier_classification
      comment: "Tier classification (e.g., Tier 1, Tier 2, Strategic, Preferred)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for geographic sourcing analysis"
    - name: "onboarding_stage"
      expr: onboarding_stage
      comment: "Current onboarding stage (e.g., Initiated, Documentation, Audit, Approved)"
    - name: "preferred_vendor_flag"
      expr: preferred_vendor_flag
      comment: "Indicates whether vendor has preferred status"
    - name: "edi_capable_flag"
      expr: edi_capable_flag
      comment: "Indicates whether vendor is EDI capable for system integration"
    - name: "vmi_eligible_flag"
      expr: vmi_eligible_flag
      comment: "Indicates whether vendor is eligible for vendor-managed inventory"
    - name: "lc_terms_required_flag"
      expr: lc_terms_required_flag
      comment: "Indicates whether letter of credit terms are required"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for vendor transactions"
    - name: "incoterms"
      expr: incoterms
      comment: "Default Incoterms for vendor shipments"
  measures:
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Total number of vendors - measures supplier base size for portfolio decisions"
    - name: "active_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN business_status = 'Active' THEN vendor_id END)
      comment: "Count of active vendors - key for active supplier base management"
    - name: "preferred_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN preferred_vendor_flag = TRUE THEN vendor_id END)
      comment: "Count of preferred vendors - measures strategic supplier relationships"
    - name: "avg_quality_rating_score"
      expr: AVG(CAST(quality_rating_score AS DOUBLE))
      comment: "Average quality rating score - key vendor quality performance indicator"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average vendor risk score - critical for risk management decisions"
    - name: "avg_onboarding_completion_percentage"
      expr: AVG(CAST(onboarding_completion_percentage AS DOUBLE))
      comment: "Average onboarding completion percentage - measures onboarding efficiency"
    - name: "avg_moq_value"
      expr: AVG(CAST(moq_value AS DOUBLE))
      comment: "Average minimum order quantity value - informs order consolidation decisions"
    - name: "edi_capable_vendor_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN edi_capable_flag = TRUE THEN vendor_id END) / NULLIF(COUNT(DISTINCT vendor_id), 0), 2)
      comment: "Percentage of EDI-capable vendors - measures digital integration readiness"
    - name: "vmi_eligible_vendor_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vmi_eligible_flag = TRUE THEN vendor_id END) / NULLIF(COUNT(DISTINCT vendor_id), 0), 2)
      comment: "Percentage of VMI-eligible vendors - indicates advanced partnership opportunities"
    - name: "high_risk_vendor_count"
      expr: COUNT(DISTINCT CASE WHEN risk_score >= 70 THEN vendor_id END)
      comment: "Count of high-risk vendors (risk score >= 70) - triggers risk mitigation actions"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`supplier_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier risk assessment KPIs for proactive risk management and mitigation steering decisions"
  source: "`apparel_fashion_ecm`.`supplier`.`risk_assessment`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date of risk assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year of assessment for annual risk reporting"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., Initial, Periodic, Event-Driven, Re-assessment)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (e.g., In Progress, Completed, Under Review)"
    - name: "risk_category"
      expr: risk_category
      comment: "Category of risk (e.g., Financial, Operational, Compliance, Reputational, ESG)"
    - name: "risk_subcategory"
      expr: risk_subcategory
      comment: "Subcategory of risk for detailed analysis"
    - name: "inherent_risk_rating"
      expr: inherent_risk_rating
      comment: "Inherent risk rating before mitigation (e.g., Low, Medium, High, Critical)"
    - name: "residual_risk_rating"
      expr: residual_risk_rating
      comment: "Residual risk rating after mitigation - key for risk acceptance decisions"
    - name: "mitigation_status"
      expr: mitigation_status
      comment: "Status of risk mitigation (e.g., Not Started, In Progress, Completed)"
    - name: "business_impact_area"
      expr: business_impact_area
      comment: "Business area impacted by the risk"
    - name: "geographic_risk_region"
      expr: geographic_risk_region
      comment: "Geographic region associated with the risk"
    - name: "esg_flag"
      expr: esg_flag
      comment: "Indicates whether risk is ESG-related - critical for sustainability reporting"
  measures:
    - name: "risk_assessment_count"
      expr: COUNT(DISTINCT risk_assessment_id)
      comment: "Total number of risk assessments - measures risk management activity"
    - name: "vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors assessed - measures risk coverage"
    - name: "total_mitigation_cost"
      expr: SUM(CAST(mitigation_cost AS DOUBLE))
      comment: "Total cost of risk mitigation - informs risk management budget decisions"
    - name: "avg_mitigation_cost"
      expr: AVG(CAST(mitigation_cost AS DOUBLE))
      comment: "Average mitigation cost per risk - measures risk remediation investment"
    - name: "high_inherent_risk_count"
      expr: COUNT(DISTINCT CASE WHEN inherent_risk_rating IN ('High', 'Critical') THEN risk_assessment_id END)
      comment: "Count of high inherent risk assessments - triggers immediate attention"
    - name: "high_residual_risk_count"
      expr: COUNT(DISTINCT CASE WHEN residual_risk_rating IN ('High', 'Critical') THEN risk_assessment_id END)
      comment: "Count of high residual risk assessments - indicates unmitigated exposure requiring action"
    - name: "esg_risk_count"
      expr: COUNT(DISTINCT CASE WHEN esg_flag = TRUE THEN risk_assessment_id END)
      comment: "Count of ESG-related risks - critical for sustainability and reputation management"
    - name: "mitigation_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mitigation_status = 'Completed' THEN risk_assessment_id END) / NULLIF(COUNT(DISTINCT risk_assessment_id), 0), 2)
      comment: "Percentage of risks with completed mitigation - measures risk management effectiveness"
$$;