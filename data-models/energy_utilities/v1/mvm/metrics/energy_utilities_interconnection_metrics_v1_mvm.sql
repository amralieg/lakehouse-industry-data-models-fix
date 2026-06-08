-- Metric views for domain: interconnection | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for interconnection agreements"
  source: "`energy_utilities_ecm`.`interconnection`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the agreement"
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type/category of the agreement"
    - name: "der_technology_type"
      expr: der_technology_type
      comment: "Distributed Energy Resource technology type"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year the agreement was commissioned"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires"
    - name: "nem_program_enrolled_flag"
      expr: nem_program_enrolled_flag
      comment: "Flag indicating enrollment in NEM program"
    - name: "sgip_eligible_flag"
      expr: sgip_eligible_flag
      comment: "Flag indicating SGIP eligibility"
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total number of interconnection agreements"
    - name: "total_nameplate_capacity_kw"
      expr: SUM(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Sum of nameplate capacity (kW) across all agreements"
    - name: "avg_nameplate_capacity_kw"
      expr: AVG(CAST(nameplate_capacity_kw AS DOUBLE))
      comment: "Average nameplate capacity (kW) per agreement"
    - name: "total_interconnection_study_cost_usd"
      expr: SUM(CAST(interconnection_study_cost_usd AS DOUBLE))
      comment: "Total cost of interconnection studies (USD) incurred"
    - name: "pct_agreements_with_study_required"
      expr: AVG(CASE WHEN interconnection_study_required_flag THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of agreements that require an interconnection study"
    - name: "avg_agreement_lifespan_days"
      expr: AVG(DATEDIFF(expiration_date, commissioning_date))
      comment: "Average lifespan of agreements in days (from commissioning to expiration)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics that reflect the health and throughput of the interconnection application process"
  source: "`energy_utilities_ecm`.`interconnection`.`application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the application"
    - name: "der_technology_type"
      expr: der_technology_type
      comment: "DER technology type requested"
    - name: "nem_eligible"
      expr: nem_eligible
      comment: "Flag indicating NEM eligibility"
    - name: "sgip_eligible"
      expr: sgip_eligible
      comment: "Flag indicating SGIP eligibility"
    - name: "application_tier"
      expr: application_tier
      comment: "Tier classification of the application"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the application"
    - name: "application_year"
      expr: YEAR(application_date)
      comment: "Year the application was submitted"
  measures:
    - name: "total_applications"
      expr: COUNT(1)
      comment: "Total number of interconnection applications"
    - name: "total_export_capacity_kw"
      expr: SUM(CAST(export_capacity_kw AS DOUBLE))
      comment: "Sum of requested export capacity (kW) across applications"
    - name: "avg_export_capacity_kw"
      expr: AVG(CAST(export_capacity_kw AS DOUBLE))
      comment: "Average requested export capacity (kW) per application"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fee amount (USD) associated with applications"
    - name: "pct_applications_fee_paid"
      expr: AVG(CASE WHEN fee_paid THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of applications where the fee has been paid"
    - name: "avg_time_to_approval_days"
      expr: AVG(DATEDIFF(approval_date, application_date))
      comment: "Average days from application submission to approval"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for interconnection fees"
  source: "`energy_utilities_ecm`.`interconnection`.`fee`"
  dimensions:
    - name: "fee_status"
      expr: fee_status
      comment: "Current status of the fee"
    - name: "fee_category"
      expr: fee_category
      comment: "Category of the fee"
    - name: "fee_type"
      expr: fee_type
      comment: "Type of the fee"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for the fee amount"
    - name: "fee_year"
      expr: YEAR(created_timestamp)
      comment: "Year the fee record was created"
    - name: "fee_number"
      expr: fee_number
      comment: "Unique fee identifier"
  measures:
    - name: "total_fees"
      expr: COUNT(1)
      comment: "Total number of fee records"
    - name: "total_fee_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Sum of fee amounts (USD)"
    - name: "total_applicant_cost_share"
      expr: SUM(CAST(applicant_cost_share_amount AS DOUBLE))
      comment: "Total applicant cost share amount (USD)"
    - name: "total_utility_cost_share"
      expr: SUM(CAST(utility_cost_share_amount AS DOUBLE))
      comment: "Total utility cost share amount (USD)"
    - name: "pct_fees_with_dispute"
      expr: AVG(CASE WHEN dispute_flag THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of fees that are under dispute"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance (USD) per fee"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_hosting_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning metrics for interconnection hosting"
  source: "`energy_utilities_ecm`.`interconnection`.`hosting_capacity`"
  dimensions:
    - name: "assessment_methodology"
      expr: assessment_methodology
      comment: "Methodology used for the hosting capacity assessment"
    - name: "assessment_software_tool"
      expr: assessment_software_tool
      comment: "Software tool used for the assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the assessment was performed"
    - name: "nem_agreement_applicable_flag"
      expr: nem_agreement_applicable_flag
      comment: "Flag indicating applicability of NEM agreement"
    - name: "sgip_eligible_flag"
      expr: sgip_eligible_flag
      comment: "Flag indicating SGIP eligibility"
  measures:
    - name: "total_available_hosting_capacity_kw"
      expr: SUM(CAST(available_hosting_capacity_kw AS DOUBLE))
      comment: "Total available hosting capacity (kW) across all assessments"
    - name: "avg_available_hosting_capacity_kw"
      expr: AVG(CAST(available_hosting_capacity_kw AS DOUBLE))
      comment: "Average available hosting capacity (kW) per assessment"
    - name: "total_minimum_hosting_capacity_kw"
      expr: SUM(CAST(minimum_hosting_capacity_kw AS DOUBLE))
      comment: "Sum of minimum hosting capacity (kW) required"
    - name: "pct_assessments_with_upgrade_estimate"
      expr: AVG(CASE WHEN upgrade_cost_estimate_usd IS NOT NULL AND upgrade_cost_estimate_usd > 0 THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of hosting capacity assessments that include an upgrade cost estimate"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_impact_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for interconnection impact studies"
  source: "`energy_utilities_ecm`.`interconnection`.`impact_study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the impact study"
    - name: "study_type"
      expr: study_type
      comment: "Type of impact study"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the study"
    - name: "study_initiation_year"
      expr: YEAR(study_initiation_date)
      comment: "Year the study was initiated"
    - name: "load_flow_analysis_performed_flag"
      expr: load_flow_analysis_performed_flag
      comment: "Flag indicating if load flow analysis was performed"
  measures:
    - name: "total_impact_studies"
      expr: COUNT(1)
      comment: "Total number of impact studies conducted"
    - name: "total_study_cost_estimate_amount"
      expr: SUM(CAST(study_cost_estimate_amount AS DOUBLE))
      comment: "Sum of estimated study costs (USD)"
    - name: "avg_study_duration_days"
      expr: AVG(DATEDIFF(study_actual_completion_date, study_initiation_date))
      comment: "Average duration of impact studies in days"
    - name: "pct_studies_with_network_upgrades_required"
      expr: AVG(CASE WHEN network_upgrades_required_flag THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of studies that identified required network upgrades"
    - name: "total_network_upgrade_cost_estimate_amount"
      expr: SUM(CAST(network_upgrade_cost_estimate_amount AS DOUBLE))
      comment: "Total estimated cost for network upgrades identified by studies"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`interconnection_network_upgrade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial metrics for network upgrade projects"
  source: "`energy_utilities_ecm`.`interconnection`.`network_upgrade`"
  dimensions:
    - name: "feeder_id"
      expr: feeder_id
      comment: "Feeder associated with the network upgrade"
    - name: "upgrade_type"
      expr: upgrade_type
      comment: "Type of upgrade (e.g., transformer, line)"
  measures:
    - name: "total_network_upgrades"
      expr: COUNT(1)
      comment: "Total number of network upgrade projects"
    - name: "total_estimated_cost_amount"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Sum of estimated costs for network upgrades (USD)"
    - name: "total_actual_cost_amount"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Sum of actual costs incurred for network upgrades (USD)"
    - name: "avg_capacity_increase_mw"
      expr: AVG(CAST(capacity_increase_mw AS DOUBLE))
      comment: "Average capacity increase (MW) delivered by upgrades"
    - name: "pct_upgrades_completed"
      expr: AVG(CASE WHEN actual_completion_date IS NOT NULL THEN 1.0 ELSE 0.0 END) * 100
      comment: "Percentage of network upgrades that have been completed"
$$;