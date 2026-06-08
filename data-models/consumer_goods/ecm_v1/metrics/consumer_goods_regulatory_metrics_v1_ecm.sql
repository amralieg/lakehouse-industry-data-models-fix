-- Metric views for domain: regulatory | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core regulatory action KPIs to monitor compliance workload, escalation risk and financial exposure"
  source: "`consumer_goods_ecm`.`regulatory`.`action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Category of the regulatory action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the action"
    - name: "action_month"
      expr: DATE_TRUNC('month', action_date)
      comment: "Month in which the action occurred"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction code governing the action"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total number of regulatory actions recorded"
    - name: "escalated_actions"
      expr: SUM(CASE WHEN escalation_flag THEN 1 ELSE 0 END)
      comment: "Count of actions flagged for escalation"
    - name: "external_audit_actions"
      expr: SUM(CASE WHEN external_audit_required_flag THEN 1 ELSE 0 END)
      comment: "Count of actions that require an external audit"
    - name: "total_financial_penalties"
      expr: SUM(CAST(financial_penalty_amount AS DOUBLE))
      comment: "Sum of financial penalties associated with regulatory actions"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_compliance_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to evaluate compliance assessment volume, required actions and timeliness"
  source: "`consumer_goods_ecm`.`regulatory`.`compliance_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of compliance assessment (e.g., internal, external)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status reported"
    - name: "assessment_month"
      expr: DATE_TRUNC('month', assessment_date)
      comment: "Month of the assessment"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of compliance assessments performed"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required THEN 1 ELSE 0 END)
      comment: "Number of assessments that identified a required corrective action"
    - name: "avg_assessment_duration_days"
      expr: AVG(DATEDIFF(closure_date, assessment_date))
      comment: "Average number of days from assessment to closure"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_product_recall`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic recall KPIs to track volume, effectiveness and high‑risk events"
  source: "`consumer_goods_ecm`.`regulatory`.`product_recall`"
  dimensions:
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall"
    - name: "recall_type"
      expr: recall_type
      comment: "Type of recall (e.g., voluntary, mandatory)"
    - name: "recall_month"
      expr: DATE_TRUNC('month', recall_initiation_date)
      comment: "Month when the recall was initiated"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction governing the recall"
  measures:
    - name: "total_recalls"
      expr: COUNT(1)
      comment: "Total number of product recall events"
    - name: "total_quantity_recalled_units"
      expr: SUM(CAST(quantity_recalled_units AS DOUBLE))
      comment: "Sum of units recalled across all events"
    - name: "avg_recall_effectiveness_percentage"
      expr: AVG(CAST(recall_effectiveness_percentage AS DOUBLE))
      comment: "Average recall effectiveness percentage"
    - name: "high_severity_recalls"
      expr: SUM(CASE WHEN recall_classification = 'High' THEN 1 ELSE 0 END)
      comment: "Count of recalls classified as high severity"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key obligation metrics for budgeting and risk oversight"
  source: "`consumer_goods_ecm`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Classification of the compliance obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status of the obligation"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction governing the obligation"
  measures:
    - name: "total_obligations"
      expr: COUNT(1)
      comment: "Total number of regulatory compliance obligations"
    - name: "active_obligations"
      expr: SUM(CASE WHEN is_active THEN 1 ELSE 0 END)
      comment: "Count of obligations that are currently active"
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Aggregate estimated cost to achieve compliance"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to monitor regulatory change volume, mandatory impact and lifecycle"
  source: "`consumer_goods_ecm`.`regulatory`.`change`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type/category of the regulatory change"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the change is mandatory"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month when the change became effective"
    - name: "jurisdiction_id"
      expr: jurisdiction_id
      comment: "Jurisdiction associated with the change"
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total number of regulatory changes recorded"
    - name: "mandatory_changes"
      expr: SUM(CASE WHEN is_mandatory THEN 1 ELSE 0 END)
      comment: "Count of changes that are mandatory"
    - name: "avg_change_duration_days"
      expr: AVG(DATEDIFF(expiration_date, effective_date))
      comment: "Average lifespan of a regulatory change in days"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`regulatory_surveillance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surveillance event KPIs to assess incident volume, financial risk, and safety outcomes"
  source: "`consumer_goods_ecm`.`regulatory`.`surveillance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Category of the surveillance event"
    - name: "injury_reported_flag"
      expr: injury_reported_flag
      comment: "Whether the event involved a reported injury"
    - name: "event_month"
      expr: DATE_TRUNC('month', event_occurrence_date)
      comment: "Month of the event occurrence"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority overseeing the event"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of surveillance events logged"
    - name: "total_financial_impact_estimate"
      expr: SUM(CAST(financial_impact_estimate AS DOUBLE))
      comment: "Sum of estimated financial impact across events"
    - name: "injury_reported_events"
      expr: SUM(CASE WHEN injury_reported_flag THEN 1 ELSE 0 END)
      comment: "Count of events where an injury was reported"
$$;