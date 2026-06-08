-- Metric views for domain: quality | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 09:03:30

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit finding KPIs for executive oversight of audit effectiveness and timeliness"
  source: "`consumer_goods_ecm`.`quality`.`audit_finding`"
  dimensions:
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the finding"
    - name: "finding_status"
      expr: finding_status
      comment: "Current status of the finding (e.g., Open, Closed)"
    - name: "finding_classification"
      expr: finding_classification
      comment: "Classification of the finding (e.g., Critical, Major, Minor)"
  measures:
    - name: "total_audit_findings"
      expr: COUNT(1)
      comment: "Total number of audit findings recorded"
    - name: "closed_audit_findings"
      expr: SUM(CASE WHEN finding_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of audit findings that have been closed"
    - name: "average_closure_days"
      expr: AVG(DATEDIFF(closure_date, finding_date))
      comment: "Average number of days between finding date and closure date for closed findings"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_capa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CAPA performance metrics to monitor corrective action effectiveness and cost impact"
  source: "`consumer_goods_ecm`.`quality`.`capa`"
  dimensions:
    - name: "capa_status"
      expr: capa_status
      comment: "Current status of the CAPA (e.g., Open, Closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the CAPA"
    - name: "severity"
      expr: severity
      comment: "Severity of the issue addressed by the CAPA"
    - name: "process_area"
      expr: process_area
      comment: "Business process area impacted"
  measures:
    - name: "total_capa"
      expr: COUNT(1)
      comment: "Total number of CAPA records"
    - name: "closed_capa"
      expr: SUM(CASE WHEN capa_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of CAPA records that have been closed"
    - name: "average_capa_duration_days"
      expr: AVG(DATEDIFF(closure_date, initiated_date))
      comment: "Average days from CAPA initiation to closure"
    - name: "total_cost_impact"
      expr: SUM(CAST(cost_impact_amount AS DOUBLE))
      comment: "Sum of monetary cost impact across all CAPA"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_nonconformance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nonconformance KPIs to track quality incidents, financial exposure, and severity distribution"
  source: "`consumer_goods_ecm`.`quality`.`nonconformance`"
  dimensions:
    - name: "nonconformance_status"
      expr: nonconformance_status
      comment: "Current status of the nonconformance (e.g., Open, Closed)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the nonconformance"
    - name: "source_system"
      expr: source_system
      comment: "Originating system that reported the nonconformance"
  measures:
    - name: "total_nonconformance"
      expr: COUNT(1)
      comment: "Total number of nonconformance events recorded"
    - name: "closed_nonconformance"
      expr: SUM(CASE WHEN nonconformance_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Count of nonconformance events that have been closed"
    - name: "average_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact of nonconformance events"
    - name: "high_severity_count"
      expr: SUM(CASE WHEN severity = 'High' THEN 1 ELSE 0 END)
      comment: "Number of high‑severity nonconformance events"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_inspection_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection result metrics to monitor product conformity and defect occurrence"
  source: "`consumer_goods_ecm`.`quality`.`inspection_result`"
  dimensions:
    - name: "inspection_characteristic_code"
      expr: inspection_characteristic_code
      comment: "Code identifying the inspected characteristic"
    - name: "result_status"
      expr: result_status
      comment: "Overall status of the inspection result"
    - name: "control_chart_violation_flag"
      expr: control_chart_violation_flag
      comment: "Flag indicating if a control chart rule was violated"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspection results recorded"
    - name: "failed_inspections"
      expr: SUM(CASE WHEN measured_value NOT BETWEEN lower_specification_limit AND upper_specification_limit THEN 1 ELSE 0 END)
      comment: "Count of inspections where measured value fell outside specification limits"
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`quality_batch_release`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Batch release KPIs to assess production yield and quality release efficiency"
  source: "`consumer_goods_ecm`.`quality`.`batch_release`"
  dimensions:
    - name: "manufacturing_site_code"
      expr: manufacturing_site_code
      comment: "Code of the manufacturing site where the batch was produced"
    - name: "sku_id"
      expr: sku_id
      comment: "SKU identifier for the product batch"
    - name: "release_decision"
      expr: release_decision
      comment: "Decision outcome of the batch release (e.g., Approved, Hold)"
  measures:
    - name: "total_batch_quantity"
      expr: SUM(CAST(batch_size_quantity AS DOUBLE))
      comment: "Total quantity of product in batches released"
    - name: "total_released_quantity"
      expr: SUM(CAST(released_quantity AS DOUBLE))
      comment: "Total quantity that was released after quality approval"
    - name: "total_rejected_quantity"
      expr: SUM(CAST(rejected_quantity AS DOUBLE))
      comment: "Total quantity rejected during batch release"
$$;