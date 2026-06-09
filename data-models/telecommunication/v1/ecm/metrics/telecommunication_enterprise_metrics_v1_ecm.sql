-- Metric views for domain: enterprise | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 05:01:11

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and risk metrics for corporate accounts"
  source: "`telecommunication_ecm`.`enterprise`.`corporate_account`"
  dimensions:
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the corporate account"
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code of the corporate headquarters"
  measures:
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of corporate account records"
    - name: "total_average_monthly_revenue"
      expr: SUM(CAST(average_revenue_per_month AS DOUBLE))
      comment: "Sum of average monthly revenue across accounts"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score for corporate accounts"
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Total customer lifetime value across corporate accounts"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_managed_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and service type metrics for managed services"
  source: "`telecommunication_ecm`.`enterprise`.`managed_service`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of managed service offered"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the service"
    - name: "activation_date"
      expr: activation_date
      comment: "Date the managed service was activated"
  measures:
    - name: "service_count"
      expr: COUNT(1)
      comment: "Number of managed service records"
    - name: "total_monthly_recurring_charge"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring charge for managed services"
    - name: "average_monthly_recurring_charge"
      expr: AVG(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Average monthly recurring charge per managed service"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_sdwan_topology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and SLA performance metrics for SD-WAN topologies"
  source: "`telecommunication_ecm`.`enterprise`.`sdwan_topology`"
  dimensions:
    - name: "topology_name"
      expr: topology_name
      comment: "Descriptive name of the SD-WAN topology"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier for the topology"
    - name: "cloud_providers_integrated"
      expr: cloud_providers_integrated
      comment: "Cloud providers integrated with the topology"
    - name: "activation_date"
      expr: activation_date
      comment: "Date the topology became active"
  measures:
    - name: "topology_count"
      expr: COUNT(1)
      comment: "Number of SD-WAN topology records"
    - name: "total_monthly_recurring_charge"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring charge for SD-WAN topologies"
    - name: "average_sla_availability_target_pct"
      expr: AVG(CAST(sla_availability_target_pct AS DOUBLE))
      comment: "Average SLA availability target percentage"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial metrics for enterprise contracts"
  source: "`telecommunication_ecm`.`enterprise`.`enterprise_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., subscription, service)"
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the contract"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency used for the contract"
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of enterprise contracts"
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Sum of contract ceiling values"
    - name: "average_minimum_commitment_arr"
      expr: AVG(CAST(minimum_commitment_arr AS DOUBLE))
      comment: "Average minimum commitment ARR across contracts"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_iot_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue and reliability metrics for IoT deployments"
  source: "`telecommunication_ecm`.`enterprise`.`iot_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current operational status of the deployment"
    - name: "connectivity_technology"
      expr: connectivity_technology
      comment: "Technology used for connectivity (e.g., LTE, 5G)"
    - name: "geographic_coverage_zones"
      expr: geographic_coverage_zones
      comment: "Geographic zones covered by the deployment"
    - name: "activation_date"
      expr: activation_date
      comment: "Date the IoT deployment was activated"
  measures:
    - name: "deployment_count"
      expr: COUNT(1)
      comment: "Number of IoT deployments"
    - name: "total_monthly_recurring_charge"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring charge for IoT deployments"
    - name: "average_uptime_sla_percentage"
      expr: AVG(CAST(uptime_sla_percentage AS DOUBLE))
      comment: "Average uptime SLA percentage across deployments"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity and operational metrics for enterprise sites"
  source: "`telecommunication_ecm`.`enterprise`.`enterprise_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Classification of the site (e.g., data center, office)"
    - name: "primary_service_type"
      expr: primary_service_type
      comment: "Primary service type delivered at the site"
    - name: "is_24x7_operation"
      expr: is_24x7_operation
      comment: "Flag indicating 24x7 operation"
    - name: "site_status"
      expr: site_status
      comment: "Current operational status of the site"
  measures:
    - name: "site_count"
      expr: COUNT(1)
      comment: "Number of enterprise sites"
    - name: "total_bandwidth_requirement_mbps"
      expr: SUM(CAST(bandwidth_requirement_mbps AS DOUBLE))
      comment: "Total bandwidth requirement across sites (Mbps)"
    - name: "average_bandwidth_requirement_mbps"
      expr: AVG(CAST(bandwidth_requirement_mbps AS DOUBLE))
      comment: "Average bandwidth requirement per site (Mbps)"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and frequency of SLA breaches"
  source: "`telecommunication_ecm`.`enterprise`.`sla_breach`"
  dimensions:
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type/category of the breach"
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the breach (e.g., open, resolved)"
  measures:
    - name: "breach_count"
      expr: COUNT(1)
      comment: "Number of SLA breach records"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for breaches"
    - name: "average_credit_amount"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per breach"
$$;