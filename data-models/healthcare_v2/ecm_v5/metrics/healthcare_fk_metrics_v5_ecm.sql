-- Metric views for domain: fk | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`fk_new_connections`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metric view tracking FK connection integrity across the healthcare data model - monitors cross-domain linkage completeness for clinical orders, provider networks, and scheduling appointments to ensure referential integrity and data governance compliance."
  source: "`healthcare_ecm_v1`.`fk`.`new_connections`"
  dimensions:
    - name: "has_clinical_order_link"
      expr: CASE WHEN clinical_order_id IS NOT NULL THEN 'Linked' ELSE 'Unlinked' END
      comment: "Indicates whether the record has a valid clinical order FK connection - critical for order-to-encounter traceability"
    - name: "has_provider_network_link"
      expr: CASE WHEN provider_network_id IS NOT NULL THEN 'Linked' ELSE 'Unlinked' END
      comment: "Indicates whether the record has a valid provider network FK connection - essential for network adequacy and claims routing"
    - name: "has_scheduling_visit_link"
      expr: CASE WHEN scheduling_appointment_visit_id IS NOT NULL THEN 'Linked' ELSE 'Unlinked' END
      comment: "Indicates whether the scheduling appointment has a valid visit FK connection - required for appointment-to-encounter reconciliation"
  measures:
    - name: "total_connection_records"
      expr: COUNT(1)
      comment: "Total number of FK connection records representing cross-domain linkages that were previously unlinked"
    - name: "clinical_order_linked_count"
      expr: COUNT(CASE WHEN clinical_order_id IS NOT NULL THEN 1 END)
      comment: "Count of records with established clinical order linkage - measures pharmacy-to-order integration completeness"
    - name: "provider_network_linked_count"
      expr: COUNT(CASE WHEN provider_network_id IS NOT NULL THEN 1 END)
      comment: "Count of records with established provider network linkage - measures insurance network referential integrity"
    - name: "scheduling_visit_linked_count"
      expr: COUNT(CASE WHEN scheduling_appointment_visit_id IS NOT NULL THEN 1 END)
      comment: "Count of records with established scheduling-to-visit linkage - measures appointment reconciliation completeness"
    - name: "fully_linked_connection_count"
      expr: COUNT(CASE WHEN clinical_order_id IS NOT NULL AND provider_network_id IS NOT NULL AND scheduling_appointment_visit_id IS NOT NULL THEN 1 END)
      comment: "Count of records where all three FK connections are established - indicates complete cross-domain integration health"
$$;