-- Metric views for domain: order | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fulfillment performance and volume"
  source: "`healthcare_ecm`.`order`.`fulfillment`"
  dimensions:
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of the fulfillment (e.g., completed, pending)"
  measures:
    - name: "fulfillment_count"
      expr: COUNT(1)
      comment: "Number of fulfillment records"
    - name: "total_fulfilled_quantity"
      expr: SUM(CAST(fulfilled_quantity AS DOUBLE))
      comment: "Total quantity that has been fulfilled"
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity originally ordered"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_authorization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authorization throughput and approval rates"
  source: "`healthcare_ecm`.`order`.`order_authorization`"
  dimensions:
    - name: "authorization_status"
      expr: authorization_status
      comment: "Current status of the authorization request"
    - name: "authorization_type"
      expr: authorization_type
      comment: "Type of authorization (e.g., prior, concurrent)"
  measures:
    - name: "total_authorizations"
      expr: COUNT(1)
      comment: "Total number of order authorizations submitted"
    - name: "approved_authorizations"
      expr: SUM(CASE WHEN authorization_status = 'Approved' THEN 1 ELSE 0 END)
      comment: "Count of authorizations that were approved"
    - name: "total_approved_quantity"
      expr: SUM(CAST(approved_quantity AS DOUBLE))
      comment: "Sum of quantities approved across all authorizations"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`order_cpoe_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical decision support alert volume and acknowledgment"
  source: "`healthcare_ecm`.`order`.`cpoe_alert`"
  dimensions:
    - name: "alert_severity"
      expr: alert_severity
      comment: "Severity level of the alert"
    - name: "alert_type"
      expr: alert_type
      comment: "Category/type of the alert"
    - name: "alert_source_system"
      expr: alert_source_system
      comment: "System that generated the alert"
  measures:
    - name: "total_alerts"
      expr: COUNT(1)
      comment: "Total number of CPOE alerts generated"
    - name: "alerts_acknowledged"
      expr: SUM(CASE WHEN alert_acknowledged_flag THEN 1 ELSE 0 END)
      comment: "Count of alerts that were acknowledged by clinicians"
$$;