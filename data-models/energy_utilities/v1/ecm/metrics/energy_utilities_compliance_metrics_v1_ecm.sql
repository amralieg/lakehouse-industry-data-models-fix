-- Metric views for domain: compliance | Business: Energy Utilities | Version: 1 | Generated on: 2026-05-04 21:07:37

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit performance and financial impact metrics"
  source: "`energy_utilities_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Open, Closed)"
    - name: "audit_type"
      expr: audit_type
      comment: "Type/category of the audit"
    - name: "audit_program_id"
      expr: audit_program_id
      comment: "Identifier of the audit program"
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of audit records"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of all penalties assessed in audits"
    - name: "average_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per audit"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key metrics for audit findings and associated financial impact"
  source: "`energy_utilities_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding"
    - name: "finding_type"
      expr: finding_type
      comment: "Classification of the finding"
    - name: "risk_severity"
      expr: risk_severity
      comment: "Severity rating of the risk"
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month the finding was discovered"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings"
    - name: "total_actual_penalty_amount"
      expr: SUM(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Sum of actual penalties associated with findings"
    - name: "average_actual_penalty_amount"
      expr: AVG(CAST(actual_penalty_amount AS DOUBLE))
      comment: "Average actual penalty per finding"
    - name: "repeat_finding_count"
      expr: SUM(CASE WHEN repeat_finding_flag THEN 1 ELSE 0 END)
      comment: "Count of findings flagged as repeat"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk assessment volume and exposure metrics"
  source: "`energy_utilities_ecm`.`compliance`.`compliance_risk_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of risk assessment (e.g., Quarterly, Ad-hoc)"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the assessment aligns to"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month the assessment was conducted"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments performed"
    - name: "total_estimated_financial_exposure"
      expr: SUM(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Aggregate estimated financial exposure across assessments"
    - name: "average_estimated_financial_exposure"
      expr: AVG(CAST(estimated_financial_exposure AS DOUBLE))
      comment: "Average estimated financial exposure per assessment"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_emissions_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance and emissions performance metrics"
  source: "`energy_utilities_ecm`.`compliance`.`emissions_report`"
  dimensions:
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the report"
    - name: "emission_unit_of_measure"
      expr: emission_unit_of_measure
      comment: "Unit of measure for emissions"
    - name: "reporting_period_start_month"
      expr: DATE_TRUNC('month', reporting_period_start_date)
      comment: "Month the reporting period started"
    - name: "power_plant_id"
      expr: power_plant_id
      comment: "Identifier of the power plant associated with the report"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of emissions reports filed"
    - name: "total_measured_emission_quantity"
      expr: SUM(CAST(measured_emission_quantity AS DOUBLE))
      comment: "Sum of measured emissions across reports"
    - name: "average_emission_rate"
      expr: AVG(CAST(emission_rate AS DOUBLE))
      comment: "Average emission rate (e.g., tons per MWh)"
    - name: "total_compliance_margin"
      expr: SUM(CAST(compliance_margin AS DOUBLE))
      comment: "Aggregate compliance margin across reports"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_bes_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility capacity and emissions factor overview"
  source: "`energy_utilities_ecm`.`compliance`.`bes_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Classification of the facility (e.g., Generation, Transmission)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel used by the facility"
    - name: "country_code"
      expr: country_code
      comment: "ISO country code where the facility is located"
    - name: "city"
      expr: city
      comment: "City of the facility location"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of BES facilities"
    - name: "total_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Combined generation capacity of all facilities (MW)"
    - name: "average_capacity_mw"
      expr: AVG(CAST(capacity_mw AS DOUBLE))
      comment: "Average generation capacity per facility (MW)"
    - name: "total_emission_factor"
      expr: SUM(CAST(emission_factor_tco2_per_mwh AS DOUBLE))
      comment: "Sum of CO2 emission factors across facilities"
$$;

CREATE OR REPLACE VIEW `energy_utilities_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Obligation inventory and financial risk metrics"
  source: "`energy_utilities_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Category of the obligation (e.g., Environmental, Safety)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing the obligation"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the obligation became effective"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "total_penalty_amount_usd"
      expr: SUM(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Sum of penalty amounts (USD) across obligations"
    - name: "average_penalty_amount_usd"
      expr: AVG(CAST(penalty_amount_usd AS DOUBLE))
      comment: "Average penalty amount (USD) per obligation"
$$;