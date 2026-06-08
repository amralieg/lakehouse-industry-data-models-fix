-- Metric views for domain: interoperability | Business: Healthcare | Version: 1 | Generated on: 2026-05-04 16:32:35

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`interoperability_care_transition_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care transition notifications performance metrics."
  source: "`healthcare_ecm`.`interoperability`.`care_transition_notification`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site where notification originated."
    - name: "interface_channel_id"
      expr: interface_channel_id
      comment: "Interface channel used for notification."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status of the notification."
    - name: "notification_priority"
      expr: notification_priority
      comment: "Priority level of the notification."
    - name: "notification_sent_date"
      expr: DATE_TRUNC('day', notification_sent_timestamp)
      comment: "Date of notification sent."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total number of care transition notifications."
    - name: "successful_acknowledgments"
      expr: SUM(CASE WHEN acknowledgment_received_flag THEN 1 ELSE 0 END)
      comment: "Count of notifications where acknowledgment was received."
    - name: "total_payload_bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total payload size in bytes across notifications."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of notifications that breached SLA."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`interoperability_cda_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDA document processing and compliance metrics."
  source: "`healthcare_ecm`.`interoperability`.`cda_document`"
  dimensions:
    - name: "document_status"
      expr: document_status
      comment: "Current status of the CDA document."
    - name: "document_type_name"
      expr: document_type_name
      comment: "Document type name."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date document was created."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the document."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of CDA documents."
    - name: "total_document_size_bytes"
      expr: SUM(CAST(document_size_bytes AS DOUBLE))
      comment: "Sum of document sizes in bytes."
    - name: "validated_documents"
      expr: SUM(CASE WHEN validation_status = 'VALID' THEN 1 ELSE 0 END)
      comment: "Count of documents with validation status VALID."
    - name: "hipaa_compliant_documents"
      expr: SUM(CASE WHEN hipaa_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of documents marked HIPAA compliant."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`interoperability_interface_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface downtime impact and SLA adherence metrics."
  source: "`healthcare_ecm`.`interoperability`.`interface_downtime`"
  dimensions:
    - name: "interface_channel_id"
      expr: interface_channel_id
      comment: "Interface channel impacted."
    - name: "interface_engine_id"
      expr: interface_engine_id
      comment: "Interface engine impacted."
    - name: "downtime_type"
      expr: downtime_type
      comment: "Type of downtime event."
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of downtime."
    - name: "downtime_start_date"
      expr: DATE_TRUNC('day', downtime_start_timestamp)
      comment: "Date downtime started."
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total downtime events recorded."
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Aggregate downtime duration in minutes."
    - name: "average_uptime_percentage"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage during downtime periods."
    - name: "messages_lost_total"
      expr: SUM(CAST(messages_lost_count AS DOUBLE))
      comment: "Total number of messages lost due to downtime."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of downtime events that breached SLA."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`interoperability_subscription_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription notification delivery and SLA metrics."
  source: "`healthcare_ecm`.`interoperability`.`subscription_notification`"
  dimensions:
    - name: "subscription_topic_id"
      expr: subscription_topic_id
      comment: "Subscription topic identifier."
    - name: "interface_channel_id"
      expr: interface_channel_id
      comment: "Interface channel used."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "notification_sent_date"
      expr: DATE_TRUNC('day', notification_timestamp)
      comment: "Date notification was sent."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the notification."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total subscription notifications sent."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of notifications that breached SLA."
    - name: "failed_deliveries"
      expr: SUM(CASE WHEN delivery_status = 'FAILED' THEN 1 ELSE 0 END)
      comment: "Count of notifications with delivery status FAILED."
$$;

CREATE OR REPLACE VIEW `healthcare_ecm`.`_metrics`.`interoperability_hie_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIE transaction volume and success metrics."
  source: "`healthcare_ecm`.`interoperability`.`hie_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of HIE transaction."
    - name: "direction"
      expr: direction
      comment: "Direction of transaction (inbound/outbound)."
    - name: "source_system_name"
      expr: source_system_name
      comment: "Name of source system."
    - name: "destination_system_name"
      expr: destination_system_name
      comment: "Name of destination system."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of transaction."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of HIE transactions."
    - name: "successful_transactions"
      expr: SUM(CASE WHEN acknowledgment_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of transactions with acknowledgment code indicating success."
$$;