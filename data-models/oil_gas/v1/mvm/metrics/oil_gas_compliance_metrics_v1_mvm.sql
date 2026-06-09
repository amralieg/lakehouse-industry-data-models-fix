-- Metric views for domain: compliance | Business: Oil Gas | Version: 1 | Generated on: 2026-05-04 09:27:20

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance cost and risk metrics per obligation"
  source: "`oil_gas_ecm`.`compliance`.`obligation`"
  dimensions:
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the obligation"
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of the regulatory obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status (e.g., compliant, non‑compliant)"
    - name: "penalty_risk_level"
      expr: penalty_risk_level
      comment: "Risk level associated with potential penalties"
    - name: "effective_from_date"
      expr: effective_from_date
      comment: "Date the obligation became effective"
  measures:
    - name: "total_estimated_compliance_cost"
      expr: SUM(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Total estimated cost to achieve compliance for all obligations"
    - name: "total_max_penalty_amount"
      expr: SUM(CAST(max_penalty_amount AS DOUBLE))
      comment: "Aggregate of the maximum possible penalties across obligations"
    - name: "average_estimated_compliance_cost"
      expr: AVG(CAST(estimated_compliance_cost AS DOUBLE))
      comment: "Average estimated compliance cost per obligation"
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Number of obligation records"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_violation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Violation risk and financial impact metrics"
  source: "`oil_gas_ecm`.`compliance`.`violation`"
  dimensions:
    - name: "regulatory_authority_id"
      expr: regulatory_authority_id
      comment: "Identifier of the regulatory authority overseeing the violation"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Geographic jurisdiction of the violation"
    - name: "violation_category"
      expr: violation_category
      comment: "High‑level category of the violation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the violation"
    - name: "violation_type"
      expr: violation_type
      comment: "Specific type of violation"
  measures:
    - name: "violation_count"
      expr: COUNT(1)
      comment: "Total number of violation records"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Sum of monetary penalties assessed for violations"
    - name: "average_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per violation"
    - name: "distinct_obligation_count"
      expr: COUNT(DISTINCT obligation_id)
      comment: "Number of unique obligations that have at least one violation"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_regulatory_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Audit activity and associated financial exposure"
  source: "`oil_gas_ecm`.`compliance`.`regulatory_audit`"
  dimensions:
    - name: "regulatory_authority_id"
      expr: regulatory_authority_id
      comment: "Regulatory authority conducting the audit"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., internal, external)"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "overall_outcome"
      expr: overall_outcome
      comment: "High‑level outcome of the audit"
    - name: "esg_category"
      expr: esg_category
      comment: "ESG focus area of the audit"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of regulatory audits performed"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalties identified across audits"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Effectiveness and cost of compliance corrective actions"
  source: "`oil_gas_ecm`.`compliance`.`compliance_corrective_action`"
  dimensions:
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Domain of compliance the action addresses"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the corrective action"
    - name: "action_status"
      expr: action_status
      comment: "Current status of the corrective action"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority linked to the action"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Category of the root cause identified"
  measures:
    - name: "action_count"
      expr: COUNT(1)
      comment: "Total corrective actions recorded"
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost_usd AS DOUBLE))
      comment: "Sum of estimated costs for corrective actions"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost_usd AS DOUBLE))
      comment: "Sum of actual costs incurred for corrective actions"
    - name: "average_completion_delay_days"
      expr: AVG(DATEDIFF(actual_completion_date, target_completion_date))
      comment: "Average number of days corrective actions were completed after the target date"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Permit financial and environmental compliance metrics"
  source: "`oil_gas_ecm`.`compliance`.`permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Classification of the permit"
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit"
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Jurisdiction level (e.g., federal, state)"
    - name: "is_reportable_to_sec"
      expr: is_reportable_to_sec
      comment: "Indicates if the permit is reportable to SEC"
    - name: "regulatory_authority_id"
      expr: regulatory_authority_id
      comment: "Regulatory authority overseeing the permit"
  measures:
    - name: "permit_count"
      expr: COUNT(1)
      comment: "Total permits recorded"
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount AS DOUBLE))
      comment: "Aggregate bond amount required for permits"
    - name: "average_emission_limit_value"
      expr: AVG(CAST(emission_limit_value AS DOUBLE))
      comment: "Average emission limit value across permits"
$$;

CREATE OR REPLACE VIEW `oil_gas_ecm`.`_metrics`.`compliance_regulatory_penalty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact of regulatory penalties"
  source: "`oil_gas_ecm`.`compliance`.`regulatory_penalty`"
  dimensions:
    - name: "regulatory_authority_id"
      expr: regulatory_authority_id
      comment: "Regulatory authority issuing the penalty"
    - name: "jurisdiction_level"
      expr: jurisdiction_level
      comment: "Jurisdiction level of the penalty"
    - name: "penalty_status"
      expr: penalty_status
      comment: "Current status of the penalty (e.g., pending, settled)"
    - name: "penalty_title"
      expr: penalty_title
      comment: "Descriptive title of the penalty"
  measures:
    - name: "penalty_count"
      expr: COUNT(1)
      comment: "Number of regulatory penalties recorded"
    - name: "total_assessed_amount"
      expr: SUM(CAST(assessed_amount AS DOUBLE))
      comment: "Sum of assessed penalty amounts"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Sum of penalties that have been paid"
$$;