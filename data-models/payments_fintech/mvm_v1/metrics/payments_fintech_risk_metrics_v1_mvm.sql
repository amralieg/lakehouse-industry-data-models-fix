-- Metric views for domain: risk | Business: Payments Fintech | Version: 1 | Generated on: 2026-05-03 21:26:52

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key risk assessment KPIs for executive monitoring"
  source: "`payments_fintech_ecm`.`risk`.`assessment`"
  dimensions:
    - name: "assessment_date"
      expr: assessment_date
      comment: "Date of the assessment"
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type/category of the assessment"
    - name: "party_type"
      expr: party_type
      comment: "Type of party being assessed"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier assigned to the assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of risk assessments performed"
    - name: "avg_overall_risk_score"
      expr: AVG(CAST(overall_risk_score AS DOUBLE))
      comment: "Average overall risk score across assessments"
    - name: "avg_credit_risk_score"
      expr: AVG(CAST(credit_risk_score AS DOUBLE))
      comment: "Average credit risk score"
    - name: "avg_operational_risk_score"
      expr: AVG(CAST(operational_risk_score AS DOUBLE))
      comment: "Average operational risk score"
    - name: "avg_regulatory_risk_score"
      expr: AVG(CAST(regulatory_risk_score AS DOUBLE))
      comment: "Average regulatory risk score"
    - name: "avg_reputational_risk_score"
      expr: AVG(CAST(reputational_risk_score AS DOUBLE))
      comment: "Average reputational risk score"
    - name: "avg_transaction_amount_last_30d"
      expr: AVG(CAST(transaction_amount_last_30d AS DOUBLE))
      comment: "Average transaction amount over the last 30 days"
    - name: "avg_transaction_volume_last_30d"
      expr: AVG(CAST(transaction_volume_last_30d AS DOUBLE))
      comment: "Average transaction volume over the last 30 days"
    - name: "high_risk_assessments"
      expr: SUM(CASE WHEN is_high_risk THEN 1 ELSE 0 END)
      comment: "Count of assessments flagged as high risk"
    - name: "manual_review_assessments"
      expr: SUM(CASE WHEN is_manual_review THEN 1 ELSE 0 END)
      comment: "Count of assessments that required manual review"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational risk event metrics for monitoring and response"
  source: "`payments_fintech_ecm`.`risk`.`event`"
  dimensions:
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the event"
    - name: "event_type"
      expr: event_type
      comment: "Category/type of the risk event"
    - name: "risk_dimension"
      expr: risk_dimension
      comment: "Risk dimension the event belongs to"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the event"
    - name: "source_system"
      expr: source_system
      comment: "Originating system of the event"
    - name: "is_threshold_exceeded"
      expr: is_threshold_exceeded
      comment: "Boolean flag indicating threshold breach"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of risk events recorded"
    - name: "sum_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total monetary amount associated with events"
    - name: "avg_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average event amount"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across events"
    - name: "threshold_exceeded_events"
      expr: SUM(CASE WHEN is_threshold_exceeded THEN 1 ELSE 0 END)
      comment: "Count of events where a risk threshold was exceeded"
    - name: "regulatory_flagged_events"
      expr: SUM(CASE WHEN regulatory_flag THEN 1 ELSE 0 END)
      comment: "Count of events flagged for regulatory concerns"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_credit_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit limit utilization and capacity metrics for risk capacity planning"
  source: "`payments_fintech_ecm`.`risk`.`credit_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of credit limit"
    - name: "limit_status"
      expr: limit_status
      comment: "Current status of the limit"
    - name: "limit_source"
      expr: limit_source
      comment: "Source system or policy for the limit"
    - name: "risk_profile_id"
      expr: risk_profile_id
      comment: "Associated risk profile identifier"
    - name: "model_id"
      expr: model_id
      comment: "Model used for limit assignment"
    - name: "effective_from"
      expr: effective_from
      comment: "Date when the limit became effective"
    - name: "effective_until"
      expr: effective_until
      comment: "Date when the limit expires"
  measures:
    - name: "total_credit_limits"
      expr: COUNT(1)
      comment: "Total number of credit limit records"
    - name: "sum_limit_amount"
      expr: SUM(CAST(limit_amount AS DOUBLE))
      comment: "Aggregate credit limit amount"
    - name: "avg_limit_amount"
      expr: AVG(CAST(limit_amount AS DOUBLE))
      comment: "Average credit limit amount"
    - name: "avg_utilization_pct"
      expr: AVG(utilization_amount / NULLIF(limit_amount, 0))
      comment: "Average utilization percentage of credit limits"
    - name: "avg_available_credit"
      expr: AVG(CAST(available_credit AS DOUBLE))
      comment: "Average available credit across limits"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated risk profile scores for strategic risk oversight"
  source: "`payments_fintech_ecm`.`risk`.`risk_risk_profile`"
  dimensions:
    - name: "risk_profile_id"
      expr: risk_profile_id
      comment: "Unique identifier of the risk profile"
    - name: "party_type"
      expr: party_type
      comment: "Party type associated with the profile"
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification"
    - name: "risk_approval_status"
      expr: risk_approval_status
      comment: "Current approval status of the risk profile"
    - name: "risk_approval_by"
      expr: risk_approval_by
      comment: "Approver of the risk profile"
  measures:
    - name: "total_profiles"
      expr: COUNT(1)
      comment: "Total number of risk profiles"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average overall risk score across profiles"
    - name: "avg_aml_score"
      expr: AVG(CAST(aml_score AS DOUBLE))
      comment: "Average AML score"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud score"
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score"
    - name: "avg_risk_exposure_limit"
      expr: AVG(CAST(risk_exposure_limit AS DOUBLE))
      comment: "Average risk exposure limit"
    - name: "avg_risk_exposure_used"
      expr: AVG(CAST(risk_exposure_used AS DOUBLE))
      comment: "Average risk exposure used"
    - name: "avg_risk_limit_utilization_pct"
      expr: AVG(CAST(risk_limit_utilization_pct AS DOUBLE))
      comment: "Average risk limit utilization percentage"
    - name: "approval_required_profiles"
      expr: SUM(CASE WHEN risk_approval_required THEN 1 ELSE 0 END)
      comment: "Count of profiles requiring risk approval"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Policy-level limits and thresholds for governance and compliance"
  source: "`payments_fintech_ecm`.`risk`.`policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Category of the policy"
    - name: "policy_name"
      expr: policy_name
      comment: "Human‑readable name of the policy"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for monetary limits"
    - name: "effective_from"
      expr: effective_from
      comment: "Policy effective start date"
    - name: "effective_until"
      expr: effective_until
      comment: "Policy effective end date"
  measures:
    - name: "total_policies"
      expr: COUNT(1)
      comment: "Total number of risk policies"
    - name: "avg_daily_exposure_limit"
      expr: AVG(CAST(daily_exposure_limit AS DOUBLE))
      comment: "Average daily exposure limit across policies"
    - name: "avg_monthly_exposure_limit"
      expr: AVG(CAST(monthly_exposure_limit AS DOUBLE))
      comment: "Average monthly exposure limit"
    - name: "avg_risk_score_threshold"
      expr: AVG(CAST(risk_score_threshold AS DOUBLE))
      comment: "Average risk score threshold defined in policies"
    - name: "avg_transaction_limit_amount"
      expr: AVG(CAST(transaction_limit_amount AS DOUBLE))
      comment: "Average transaction limit amount"
    - name: "approval_required_policies"
      expr: SUM(CASE WHEN approval_required_flag THEN 1 ELSE 0 END)
      comment: "Count of policies that require explicit approval"
$$;

CREATE OR REPLACE VIEW `payments_fintech_ecm`.`_metrics`.`risk_underwriting_decision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Underwriting decision performance and risk indicators"
  source: "`payments_fintech_ecm`.`risk`.`underwriting_decision`"
  dimensions:
    - name: "decision_outcome"
      expr: decision_outcome
      comment: "Result of the underwriting decision"
    - name: "decision_type"
      expr: decision_type
      comment: "Type/category of decision"
    - name: "decision_status"
      expr: decision_status
      comment: "Current status of the decision"
    - name: "is_fraud_flag"
      expr: is_fraud_flag
      comment: "Boolean flag indicating fraud suspicion"
    - name: "is_high_risk_flag"
      expr: is_high_risk_flag
      comment: "Boolean flag indicating high risk"
    - name: "decision_date"
      expr: DATE_TRUNC('day', decision_timestamp)
      comment: "Date of the decision"
  measures:
    - name: "total_decisions"
      expr: COUNT(1)
      comment: "Total underwriting decisions recorded"
    - name: "avg_decision_confidence"
      expr: AVG(CAST(decision_confidence AS DOUBLE))
      comment: "Average confidence score of decisions"
    - name: "avg_reserve_amount"
      expr: AVG(CAST(reserve_amount AS DOUBLE))
      comment: "Average reserve amount held"
    - name: "avg_reserve_rate"
      expr: AVG(CAST(reserve_rate AS DOUBLE))
      comment: "Average reserve rate"
    - name: "fraud_flagged_decisions"
      expr: SUM(CASE WHEN is_fraud_flag THEN 1 ELSE 0 END)
      comment: "Count of decisions flagged as fraud"
    - name: "high_risk_flagged_decisions"
      expr: SUM(CASE WHEN is_high_risk_flag THEN 1 ELSE 0 END)
      comment: "Count of decisions flagged as high risk"
$$;