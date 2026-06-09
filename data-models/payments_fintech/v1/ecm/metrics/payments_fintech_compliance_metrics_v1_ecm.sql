-- Metric views for domain: compliance | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 18:22:09

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core compliance case volume and risk overview"
  source: "`payments_fintech_ecm`.`compliance`.`compliance_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case"
    - name: "case_type"
      expr: case_type
      comment: "Category/type of the case"
    - name: "regulatory_jurisdiction_id"
      expr: regulatory_jurisdiction_id
      comment: "Jurisdiction governing the case"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the case was created"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of compliance cases"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across cases"
    - name: "open_cases"
      expr: SUM(CASE WHEN case_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Number of cases currently open"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_breach_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Breach notification severity and reporting metrics"
  source: "`payments_fintech_ecm`.`compliance`.`breach_notification`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach"
    - name: "regulatory_jurisdiction_id"
      expr: regulatory_jurisdiction_id
      comment: "Jurisdiction of the breach"
    - name: "is_reported_to_board"
      expr: is_reported_to_board
      comment: "Whether breach was reported to the board"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the breach was created"
  measures:
    - name: "total_breaches"
      expr: COUNT(1)
      comment: "Total breach notifications recorded"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score of breaches"
    - name: "reported_to_board_breaches"
      expr: SUM(CASE WHEN is_reported_to_board THEN 1 ELSE 0 END)
      comment: "Number of breaches reported to the board"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and status of regulatory filings"
  source: "`payments_fintech_ecm`.`compliance`.`regulatory_filing`"
  dimensions:
    - name: "filing_status"
      expr: filing_status
      comment: "Current status of the filing"
    - name: "filing_type"
      expr: filing_type
      comment: "Type/category of the filing"
    - name: "regulatory_jurisdiction_id"
      expr: regulatory_jurisdiction_id
      comment: "Jurisdiction of the filing"
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the filing was created"
  measures:
    - name: "total_filings"
      expr: COUNT(1)
      comment: "Total regulatory filings submitted"
    - name: "total_filing_amount"
      expr: SUM(CAST(filing_amount AS DOUBLE))
      comment: "Sum of monetary amounts across filings"
    - name: "average_filing_amount"
      expr: AVG(CAST(filing_amount AS DOUBLE))
      comment: "Average filing amount"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_sanctions_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and outcomes of sanctions screening"
  source: "`payments_fintech_ecm`.`compliance`.`sanctions_check`"
  dimensions:
    - name: "list_name"
      expr: list_name
      comment: "Name of the sanctions list"
    - name: "regulatory_jurisdiction_id"
      expr: regulatory_jurisdiction_id
      comment: "Jurisdiction for the check"
    - name: "hit_indicator"
      expr: hit_indicator
      comment: "Whether the check resulted in a hit"
    - name: "is_critical"
      expr: is_critical
      comment: "Whether the hit is marked critical"
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total sanctions checks performed"
    - name: "hit_count"
      expr: SUM(CASE WHEN hit_indicator THEN 1 ELSE 0 END)
      comment: "Number of checks that hit a sanctions list"
    - name: "average_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score for hits"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_control_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control assessment performance and outcomes"
  source: "`payments_fintech_ecm`.`compliance`.`control_assessment`"
  dimensions:
    - name: "assessment_outcome"
      expr: assessment_outcome
      comment: "Result of the assessment"
    - name: "control_category"
      expr: control_category
      comment: "Category of the control assessed"
    - name: "regulatory_obligation_id"
      expr: regulatory_obligation_id
      comment: "Regulatory obligation linked to the assessment"
    - name: "assessment_date"
      expr: DATE_TRUNC('day', assessment_timestamp)
      comment: "Date of the assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total control assessments performed"
    - name: "average_effectiveness_score"
      expr: AVG(CAST(control_effectiveness_score AS DOUBLE))
      comment: "Average effectiveness score across assessments"
    - name: "failed_assessments"
      expr: SUM(CASE WHEN assessment_outcome = 'Failed' THEN 1 ELSE 0 END)
      comment: "Number of assessments with a failed outcome"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`compliance_control`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Control inventory and risk weighting"
  source: "`payments_fintech_ecm`.`compliance`.`control`"
  dimensions:
    - name: "control_status"
      expr: control_status
      comment: "Current status of the control"
    - name: "control_type"
      expr: control_type
      comment: "Type of control (e.g., preventive, detective)"
    - name: "regulatory_framework"
      expr: regulatory_framework
      comment: "Regulatory framework the control belongs to"
    - name: "effective_from_date"
      expr: DATE_TRUNC('day', effective_from)
      comment: "Effective start date of the control"
  measures:
    - name: "total_controls"
      expr: COUNT(1)
      comment: "Total number of controls defined"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across controls"
    - name: "key_controls"
      expr: SUM(CASE WHEN is_key_control THEN 1 ELSE 0 END)
      comment: "Number of controls marked as key"
$$;