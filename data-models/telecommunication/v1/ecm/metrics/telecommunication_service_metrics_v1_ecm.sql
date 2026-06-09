-- Metric views for domain: service | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_activation_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key activation performance metrics"
  source: "`telecommunication_ecm`.`service`.`activation_event`"
  dimensions:
    - name: "activation_channel"
      expr: activation_channel
      comment: "Channel used for activation (e.g., online, in‑store)"
    - name: "activation_method"
      expr: activation_method
      comment: "Method of activation (e.g., remote, field)"
    - name: "activation_month"
      expr: DATE_TRUNC('month', activation_timestamp)
      comment: "Month of activation"
  measures:
    - name: "total_activations"
      expr: COUNT(1)
      comment: "Total number of activation events recorded"
    - name: "successful_activations"
      expr: SUM(CASE WHEN activation_status = 'Success' THEN 1 ELSE 0 END)
      comment: "Count of activations that completed successfully"
    - name: "avg_bandwidth_allocated"
      expr: AVG(CAST(bandwidth_allocated_mbps AS DOUBLE))
      comment: "Average bandwidth allocated (Mbps) per activation"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_contract_service_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and contract health metrics"
  source: "`telecommunication_ecm`.`service`.`contract_service_line`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service (e.g., Provisioned, Suspended)"
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_start_date)
      comment: "Billing month for the contract"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of contract service lines"
    - name: "active_contracts"
      expr: SUM(CASE WHEN line_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Number of contracts currently active"
    - name: "total_mrr"
      expr: SUM(CAST(mrr_amount AS DOUBLE))
      comment: "Monthly recurring revenue (MRR) across all contracts"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_provisioning_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provisioning efficiency and SLA adherence"
  source: "`telecommunication_ecm`.`service`.`provisioning_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the provisioning order"
    - name: "order_type"
      expr: order_type
      comment: "Business type of the order (e.g., New, Upgrade)"
    - name: "requested_activation_month"
      expr: DATE_TRUNC('month', requested_activation_date)
      comment: "Month the customer requested activation"
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total provisioning orders created"
    - name: "fallout_orders"
      expr: SUM(CASE WHEN fallout_flag THEN 1 ELSE 0 END)
      comment: "Orders that experienced provisioning fallout"
    - name: "sla_compliant_orders"
      expr: SUM(CASE WHEN sla_compliance_flag THEN 1 ELSE 0 END)
      comment: "Orders that met SLA compliance"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_svc_instance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core service instance capacity and usage"
  source: "`telecommunication_ecm`.`service`.`svc_instance`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Business service type (e.g., Broadband, Mobile)"
    - name: "service_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the service instance"
    - name: "technology_type"
      expr: technology_type
      comment: "Underlying technology (e.g., LTE, Fiber)"
  measures:
    - name: "total_instances"
      expr: COUNT(1)
      comment: "Total service instances in the catalog"
    - name: "total_bandwidth"
      expr: SUM(CAST(bandwidth_mbps AS DOUBLE))
      comment: "Aggregate bandwidth (Mbps) provisioned across all instances"
    - name: "avg_data_allowance_gb"
      expr: AVG(CAST(data_allowance_gb AS DOUBLE))
      comment: "Average data allowance (GB) per service instance"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_qos_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality of Service profile performance indicators"
  source: "`telecommunication_ecm`.`service`.`service_qos_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Classification of QoS profile"
    - name: "qci_value"
      expr: qci_value
      comment: "QoS Class Identifier value"
    - name: "profile_status"
      expr: service_qos_profile_status
      comment: "Current status of the QoS profile"
  measures:
    - name: "total_qos_profiles"
      expr: COUNT(1)
      comment: "Number of QoS profiles defined"
    - name: "avg_guaranteed_downlink_kbps"
      expr: AVG(CAST(guaranteed_bit_rate_downlink_kbps AS DOUBLE))
      comment: "Average guaranteed downlink bitrate (kbps)"
    - name: "avg_maximum_uplink_kbps"
      expr: AVG(CAST(maximum_bit_rate_uplink_kbps AS DOUBLE))
      comment: "Average maximum uplink bitrate (kbps)"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_roaming_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Roaming usage and quality metrics"
  source: "`telecommunication_ecm`.`service`.`service_roaming_session`"
  dimensions:
    - name: "roaming_country_code"
      expr: roaming_country_code
      comment: "ISO country code of visited network"
    - name: "visited_network_code"
      expr: visited_network_code
      comment: "Network code of the visited carrier"
    - name: "session_month"
      expr: DATE_TRUNC('month', session_start_timestamp)
      comment: "Month of the roaming session"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total roaming sessions recorded"
    - name: "total_data_volume_mb"
      expr: SUM(CAST(data_volume_mb AS DOUBLE))
      comment: "Total data volume (MB) consumed during roaming"
    - name: "avg_voice_minutes"
      expr: AVG(CAST(voice_minutes AS DOUBLE))
      comment: "Average voice minutes per roaming session"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`service_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational visit performance metrics"
  source: "`telecommunication_ecm`.`service`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (e.g., Installation, Repair)"
    - name: "technician_id"
      expr: technician_id
      comment: "Identifier of the technician who performed the visit"
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the visit"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total field visits performed"
    - name: "avg_labor_hours"
      expr: AVG(CAST(labor_hours AS DOUBLE))
      comment: "Average labor hours per visit"
    - name: "avg_customer_satisfaction"
      expr: AVG(CAST(customer_satisfaction_rating AS DOUBLE))
      comment: "Average customer satisfaction rating per visit"
$$;