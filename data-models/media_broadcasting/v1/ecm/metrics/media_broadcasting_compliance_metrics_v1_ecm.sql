-- Metric views for domain: compliance | Business: Media Broadcasting | Version: 1 | Generated on: 2026-05-08 17:09:06

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_accessibility_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance health metrics for accessibility obligations"
  source: "`media_broadcasting_ecm`.`compliance`.`accessibility_obligation`"
  dimensions:
    - name: "applicable_regulation"
      expr: applicable_regulation
      comment: "Regulation governing the obligation"
    - name: "geographic_jurisdiction"
      expr: geographic_jurisdiction
      comment: "Jurisdiction of the obligation"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of accessibility obligation"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the obligation became effective"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of accessibility obligations"
    - name: "count_compliant"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of obligations marked as Compliant"
    - name: "avg_compliance_percentage"
      expr: AVG(CAST(compliance_percentage AS DOUBLE))
      comment: "Average compliance percentage across obligations"
    - name: "avg_target_compliance_percentage"
      expr: AVG(CAST(target_compliance_percentage AS DOUBLE))
      comment: "Average target compliance percentage"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_broadcast_license_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and technical metrics for broadcast licenses"
  source: "`media_broadcasting_ecm`.`compliance`.`broadcast_license`"
  dimensions:
    - name: "license_status"
      expr: broadcast_license_status
      comment: "Current status of the license"
    - name: "jurisdiction_country_code"
      expr: jurisdiction_country_code
      comment: "Country code of the licensing jurisdiction"
    - name: "service_type"
      expr: service_type
      comment: "Type of broadcast service provided"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the license became effective"
  measures:
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total annual fees across broadcast licenses"
    - name: "avg_power_output"
      expr: AVG(CAST(power_output_erp_watts AS DOUBLE))
      comment: "Average ERP power output (watts) of broadcast facilities"
    - name: "license_count"
      expr: COUNT(1)
      comment: "Number of broadcast licenses"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_audit_costs`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost and volume metrics for compliance audits"
  source: "`media_broadcasting_ecm`.`compliance`.`audit`"
  dimensions:
    - name: "audit_type"
      expr: audit_type
      comment: "Classification of audit (e.g., internal, external)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "audit_firm_name"
      expr: audit_firm_name
      comment: "External firm conducting the audit"
    - name: "audit_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the audit was created"
  measures:
    - name: "total_audit_cost"
      expr: SUM(CAST(audit_cost AS DOUBLE))
      comment: "Total cost of audits performed"
    - name: "avg_audit_cost"
      expr: AVG(CAST(audit_cost AS DOUBLE))
      comment: "Average cost per audit"
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of audit records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_audit_finding_penalties`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial risk exposure from audit findings"
  source: "`media_broadcasting_ecm`.`compliance`.`audit_finding`"
  dimensions:
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Risk rating assigned to the finding"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding"
    - name: "audit_type"
      expr: audit_type
      comment: "Audit type associated with the finding"
    - name: "finding_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the finding was recorded"
  measures:
    - name: "total_potential_penalty"
      expr: SUM(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Sum of potential penalties across audit findings"
    - name: "avg_potential_penalty"
      expr: AVG(CAST(potential_penalty_amount AS DOUBLE))
      comment: "Average potential penalty per finding"
    - name: "finding_count"
      expr: COUNT(1)
      comment: "Number of audit findings"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_license_renewal_fees`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for broadcast license renewals"
  source: "`media_broadcasting_ecm`.`compliance`.`license_renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal process"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority overseeing the renewal"
    - name: "renewal_year"
      expr: DATE_TRUNC('year', renewal_cycle_start_date)
      comment: "Year the renewal cycle started"
  measures:
    - name: "total_renewal_fee"
      expr: SUM(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Total renewal fees paid for broadcast licenses"
    - name: "avg_renewal_fee"
      expr: AVG(CAST(renewal_fee_amount AS DOUBLE))
      comment: "Average renewal fee per license"
    - name: "renewal_count"
      expr: COUNT(1)
      comment: "Number of license renewal records"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_privacy_requests_volume`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational metrics for privacy request handling"
  source: "`media_broadcasting_ecm`.`compliance`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (e.g., access, deletion)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework governing the request (e.g., GDPR, CCPA)"
    - name: "request_year"
      expr: DATE_TRUNC('year', created_timestamp)
      comment: "Year the request was created"
  measures:
    - name: "total_requests"
      expr: COUNT(1)
      comment: "Total number of privacy requests received"
    - name: "total_data_volume_gb"
      expr: SUM(CAST(data_volume_processed AS DOUBLE))
      comment: "Total data volume processed for privacy requests (GB)"
    - name: "avg_processing_time_hours"
      expr: AVG(CAST(processing_time_hours AS DOUBLE))
      comment: "Average processing time per request (hours)"
$$;

CREATE OR REPLACE VIEW `media_broadcasting_ecm`.`_metrics`.`compliance_incident_financial_impact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact assessment of compliance incidents"
  source: "`media_broadcasting_ecm`.`compliance`.`incident`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory authority involved"
    - name: "incident_year"
      expr: DATE_TRUNC('year', incident_date)
      comment: "Year the incident occurred"
  measures:
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact from compliance incidents"
    - name: "incident_count"
      expr: COUNT(1)
      comment: "Number of compliance incidents recorded"
$$;