-- Metric views for domain: compliance | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-05 00:38:04

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_audit_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit performance indicators, including timeliness and financial penalties"
  source: "`energy_utilities_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., safety, financial)"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audits recorded"
    - name: "audits_completed_on_time"
      expr: SUM(CASE WHEN actual_end_date <= scheduled_end_date THEN 1 ELSE 0 END)
      comment: "Count of audits where actual end date did not exceed the scheduled end date"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of monetary penalties assessed across all audits"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per audit"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_audit_finding_severity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Severity and financial impact of audit findings"
  source: "`energy_utilities_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity_classification"
      expr: severity_classification
      comment: "Severity classification of the finding (e.g., High, Medium, Low)"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "high_severity_findings"
      expr: SUM(CASE WHEN severity_classification = 'High' THEN 1 ELSE 0 END)
      comment: "Count of findings classified as high severity"
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Sum of actual penalties associated with findings"
    - name: "avg_potential_penalty_amount"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty amount per finding"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_enforcement_action_penalties`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial outcomes of enforcement actions"
  source: "`energy_utilities_ecm`.`compliance`.`enforcement_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of enforcement action"
  measures:
    - name: "total_enforcement_actions"
      expr: COUNT(1)
      comment: "Total number of enforcement actions taken"
    - name: "total_final_penalty"
      expr: SUM(CAST(final_penalty_assessed AS DOUBLE))
      comment: "Sum of final penalties assessed across enforcement actions"
    - name: "avg_proposed_penalty"
      expr: AVG(CAST(proposed_penalty_amount AS DOUBLE))
      comment: "Average proposed penalty amount"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_emissions_reporting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core emissions performance metrics"
  source: "`energy_utilities_ecm`.`compliance`.`emissions_report`"
  dimensions:
    - name: "reporting_year"
      expr: DATE_TRUNC('year', reporting_period_start_date)
      comment: "Year of the reporting period"
  measures:
    - name: "total_measured_emission_quantity"
      expr: SUM(CAST(measured_emission_quantity AS DOUBLE))
      comment: "Total measured emissions (tons) reported"
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross generation associated with the emissions report"
    - name: "avg_emission_rate"
      expr: AVG(CAST(emission_rate AS DOUBLE))
      comment: "Average emission rate (e.g., tons per MWh)"
    - name: "total_operating_hours"
      expr: SUM(CAST(operating_hours AS DOUBLE))
      comment: "Total operating hours reported"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_rec_certificate_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and environmental impact of compliance REC certificates"
  source: "`energy_utilities_ecm`.`compliance`.`compliance_rec_certificate`"
  dimensions:
    - name: "certificate_status"
      expr: certificate_status
      comment: "Current status of the certificate"
  measures:
    - name: "total_rec_mwh"
      expr: SUM(CAST(compliance_credit_mwh AS DOUBLE))
      comment: "Total renewable energy credits (MWh) issued"
    - name: "total_emissions_avoided_tons"
      expr: SUM(CAST(emissions_avoided_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions avoided (tons) due to RECs"
    - name: "avg_energy_quantity_mwh"
      expr: AVG(CAST(energy_quantity_mwh AS DOUBLE))
      comment: "Average energy quantity per certificate"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price_per_rec AS DOUBLE))
      comment: "Sum of purchase price per REC"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_program_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budgetary overview of compliance programs"
  source: "`energy_utilities_ecm`.`compliance`.`program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type/category of the compliance program"
  measures:
    - name: "total_programs"
      expr: COUNT(1)
      comment: "Number of compliance programs"
    - name: "total_budget_usd"
      expr: SUM(CAST(budget_usd AS DOUBLE))
      comment: "Total budget allocated to programs (USD)"
    - name: "avg_minimum_passing_score_pct"
      expr: AVG(CAST(minimum_passing_score_pct AS DOUBLE))
      comment: "Average minimum passing score percentage across programs"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_rate_case_changes`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate case financial impact metrics"
  source: "`energy_utilities_ecm`.`compliance`.`rate_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the rate case"
  measures:
    - name: "total_rate_cases"
      expr: COUNT(1)
      comment: "Total number of rate cases filed"
    - name: "avg_approved_rate_increase_percent"
      expr: AVG(CAST(approved_rate_increase_percent AS DOUBLE))
      comment: "Average approved rate increase percentage"
    - name: "avg_proposed_rate_increase_percent"
      expr: AVG(CAST(proposed_rate_increase_percent AS DOUBLE))
      comment: "Average proposed rate increase percentage"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_regulatory_filing_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial summary of regulatory filings"
  source: "`energy_utilities_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing"
  measures:
    - name: "total_filing_amount"
      expr: SUM(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement amount across filings"
    - name: "avg_cpcn_capital_cost_estimate"
      expr: AVG(CAST(cpcn_capital_cost_estimate AS DOUBLE))
      comment: "Average capital cost estimate for CPCN filings"
    - name: "avg_proposed_rate_change_percent"
      expr: AVG(CAST(proposed_rate_change_percent AS DOUBLE))
      comment: "Average proposed rate change percentage"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_violation_penalties`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Penalty impact of regulatory violations"
  source: "`energy_utilities_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_type"
      expr: violation_type
      comment: "Classification of the violation"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of violations recorded"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of penalties assessed for violations"
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_bes_facility_capacity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity and emission characteristics of BES facilities"
  source: "`energy_utilities_ecm`.`compliance`.`bes_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of BES facility"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of BES facilities"
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Aggregate capacity of facilities (MW)"
    - name: "avg_emission_factor_tco2_per_mwh"
      expr: AVG(CAST(emission_factor_tco2_per_mwh AS DOUBLE))
      comment: "Average emission factor (tCO2 per MWh)"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_training_efficiency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and resource usage of compliance training"
  source: "`energy_utilities_ecm`.`compliance`.`training_record`"
  dimensions:
    - name: "training_course_name"
      expr: training_course_name
      comment: "Name of the training course"
  measures:
    - name: "total_training_records"
      expr: COUNT(1)
      comment: "Total training records captured"
    - name: "avg_assessment_score"
      expr: AVG(CAST(assessment_score AS DOUBLE))
      comment: "Average assessment score across trainings"
    - name: "total_actual_time_spent_hours"
      expr: SUM(CAST(actual_time_spent_hours AS DOUBLE))
      comment: "Total hours spent in training"
$$;