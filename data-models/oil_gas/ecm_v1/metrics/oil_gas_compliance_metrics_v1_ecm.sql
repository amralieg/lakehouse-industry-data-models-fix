-- Metric views for domain: compliance | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 05:05:28

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_calendar_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "High‑level view of compliance calendar penalties and overdue items"
  source: "`oil_gas_ecm`.`compliance`.`calendar`"
  dimensions:
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit responsible for the compliance item"
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Domain of compliance (e.g., safety, environmental)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the compliance obligation"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Governing regulatory authority"
    - name: "due_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Calendar month of the due date"
  measures:
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_exposure_usd AS DOUBLE))
      comment: "Total potential penalty exposure across all compliance calendar items"
    - name: "overdue_count"
      expr: SUM(CASE WHEN overdue_flag THEN 1 ELSE 0 END)
      comment: "Number of compliance items that are overdue"
    - name: "total_items"
      expr: COUNT(1)
      comment: "Total number of compliance calendar records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit‑finding KPI view for risk and penalty analysis"
  source: "`oil_gas_ecm`.`compliance`.`compliance_audit_finding`"
  dimensions:
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit linked to the audit finding"
    - name: "finding_category"
      expr: finding_category
      comment: "Category of the audit finding"
    - name: "risk_classification"
      expr: risk_classification
      comment: "Risk classification (e.g., High, Medium, Low)"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding"
    - name: "audit_finding_source"
      expr: audit_finding_source
      comment: "Source of the audit finding"
    - name: "ghg_related"
      expr: ghg_related
      comment: "Whether the finding is GHG‑related"
    - name: "identified_month"
      expr: DATE_TRUNC('month', identified_date)
      comment: "Month the finding was identified"
  measures:
    - name: "total_actual_penalty"
      expr: SUM(CAST(actual_penalty_usd AS DOUBLE))
      comment: "Sum of actual penalties assessed from audit findings"
    - name: "total_potential_penalty"
      expr: SUM(CAST(potential_penalty_usd AS DOUBLE))
      comment: "Sum of potential penalties from audit findings"
    - name: "high_risk_findings"
      expr: SUM(CASE WHEN risk_classification = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high‑risk audit findings"
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Total number of audit findings"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certification compliance and renewal risk view"
  source: "`oil_gas_ecm`.`compliance`.`compliance_certification`"
  dimensions:
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the certification"
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (Active, Expired, etc.)"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., ISO, API)"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory or standards body that issued the certification"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month in which the certification expires"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications recorded"
    - name: "active_certifications"
      expr: SUM(CASE WHEN certification_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of certifications that are currently active"
    - name: "certifications_expiring_30d"
      expr: SUM(CASE WHEN DATEDIFF(expiration_date, current_date) BETWEEN 0 AND 30 THEN 1 ELSE 0 END)
      comment: "Certifications expiring within the next 30 days"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit status and fee KPI view"
  source: "`oil_gas_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit"
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit"
    - name: "permit_type"
      expr: permit_type
      comment: "Type of permit (e.g., drilling, emission)"
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the permit expires"
  measures:
    - name: "total_permits"
      expr: COUNT(1)
      comment: "Total number of permits recorded"
    - name: "active_permits"
      expr: SUM(CASE WHEN permit_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of permits currently active"
    - name: "expired_permits"
      expr: SUM(CASE WHEN expiration_date < current_date THEN 1 ELSE 0 END)
      comment: "Count of permits that have expired"
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with permits"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_esg_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key ESG reporting metrics for executive sustainability oversight"
  source: "`oil_gas_ecm`.`compliance`.`esg_report`"
  dimensions:
    - name: "reporting_framework"
      expr: reporting_framework
      comment: "ESG reporting framework used (e.g., GRI, SASB)"
    - name: "report_status"
      expr: report_status
      comment: "Status of the ESG report"
    - name: "report_type"
      expr: report_type
      comment: "Type of ESG report (annual, quarterly, etc.)"
    - name: "reporting_year"
      expr: YEAR(reporting_period_start)
      comment: "Fiscal year of the reporting period"
  measures:
    - name: "total_scope1"
      expr: SUM(CAST(scope1_ghg_emissions_mt AS DOUBLE))
      comment: "Total Scope 1 GHG emissions (metric tonnes)"
    - name: "total_scope2"
      expr: SUM(CAST(scope2_ghg_emissions_mt AS DOUBLE))
      comment: "Total Scope 2 GHG emissions (metric tonnes)"
    - name: "total_scope3"
      expr: SUM(CAST(scope3_ghg_emissions_mt AS DOUBLE))
      comment: "Total Scope 3 GHG emissions (metric tonnes)"
    - name: "avg_renewable_energy_pct"
      expr: AVG(CAST(renewable_energy_pct AS DOUBLE))
      comment: "Average percentage of energy from renewable sources"
    - name: "total_carbon_offset"
      expr: SUM(CAST(carbon_offset_mt AS DOUBLE))
      comment: "Total carbon offsets purchased (metric tonnes)"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_regulatory_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory penalty financial exposure and payment status view"
  source: "`oil_gas_ecm`.`compliance`.`regulatory_penalty`"
  dimensions:
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty (e.g., Pending, Finalized)"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the penalty"
  measures:
    - name: "total_assessed_amount"
      expr: SUM(CAST(assessed_amount AS DOUBLE))
      comment: "Total assessed penalty amount"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount of penalties that have been paid"
    - name: "unpaid_assessed_amount"
      expr: SUM(CASE WHEN payment_status <> 'Paid' THEN assessed_amount ELSE 0 END)
      comment: "Assessed penalty amount that remains unpaid"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Violation tracking and penalty exposure view"
  source: "`oil_gas_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "violation_category"
      expr: violation_category
      comment: "Category of the violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the violation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction where the violation occurred"
    - name: "violation_type"
      expr: violation_type
      comment: "Type of violation (e.g., environmental, safety)"
    - name: "violation_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month the violation was discovered"
  measures:
    - name: "total_violations"
      expr: COUNT(1)
      comment: "Total number of recorded violations"
    - name: "high_severity_violations"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of violations classified as high severity"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of monetary penalties associated with violations"
$$;