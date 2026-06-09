-- Metric views for domain: enterprise | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core enterprise account health and value metrics including revenue performance, customer lifetime value, and churn risk indicators"
  source: "`telecommunication_ecm`.`enterprise`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the corporate account (active, suspended, closed, etc.)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry classification of the corporate account for vertical analysis"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification for risk segmentation"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Channel through which the account was acquired"
    - name: "annual_revenue_range"
      expr: annual_revenue_range
      comment: "Revenue band classification for account segmentation"
    - name: "employee_count_range"
      expr: employee_count_range
      comment: "Employee count band for company size analysis"
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency code for multi-currency revenue analysis"
    - name: "headquarters_country_code"
      expr: headquarters_country_code
      comment: "Country code for geographic revenue analysis"
    - name: "contract_year"
      expr: YEAR(contract_start_date)
      comment: "Year of contract start for cohort analysis"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month of contract start for time-series analysis"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT corporate_account_id)
      comment: "Total number of unique corporate accounts"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(average_revenue_per_month AS DOUBLE))
      comment: "Total monthly recurring revenue across all corporate accounts"
    - name: "average_monthly_revenue_per_account"
      expr: AVG(CAST(average_revenue_per_month AS DOUBLE))
      comment: "Average monthly revenue per corporate account"
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Total customer lifetime value across all accounts"
    - name: "average_customer_lifetime_value"
      expr: AVG(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Average customer lifetime value per account"
    - name: "average_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across accounts for retention monitoring"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended to corporate accounts"
    - name: "accounts_with_autopay"
      expr: COUNT(DISTINCT CASE WHEN auto_pay_enabled = TRUE THEN corporate_account_id END)
      comment: "Number of accounts with auto-pay enabled for payment efficiency tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise contract value and commitment metrics including ARR, MRR, contract value, and renewal tracking"
  source: "`telecommunication_ecm`.`enterprise`.`enterprise_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the enterprise contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type classification of the enterprise contract"
    - name: "government_framework_type"
      expr: government_framework_type
      comment: "Government framework classification for public sector contracts"
    - name: "currency_code"
      expr: currency_code
      comment: "Contract currency for multi-currency analysis"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract has auto-renewal enabled"
    - name: "contract_year"
      expr: YEAR(effective_date)
      comment: "Year of contract effective date for cohort analysis"
    - name: "contract_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month of contract effective date for time-series analysis"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of contract expiry for renewal pipeline analysis"
    - name: "expiry_quarter"
      expr: DATE_TRUNC('QUARTER', expiry_date)
      comment: "Quarter of contract expiry for renewal forecasting"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT enterprise_contract_id)
      comment: "Total number of unique enterprise contracts"
    - name: "total_annual_recurring_revenue"
      expr: SUM(CAST(minimum_commitment_arr AS DOUBLE))
      comment: "Total annual recurring revenue committed across all contracts"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(minimum_commitment_mrr AS DOUBLE))
      comment: "Total monthly recurring revenue committed across all contracts"
    - name: "average_arr_per_contract"
      expr: AVG(CAST(minimum_commitment_arr AS DOUBLE))
      comment: "Average annual recurring revenue per contract"
    - name: "total_contract_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Total maximum contract value across all contracts"
    - name: "total_early_termination_fees"
      expr: SUM(CAST(early_termination_fee AS DOUBLE))
      comment: "Total early termination fees at risk across all contracts"
    - name: "contracts_with_auto_renewal"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN enterprise_contract_id END)
      comment: "Number of contracts with auto-renewal enabled for retention forecasting"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_managed_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Managed service revenue and operational metrics including MRR, service mix, and SLA compliance tracking"
  source: "`telecommunication_ecm`.`enterprise`.`managed_service`"
  dimensions:
    - name: "service_status"
      expr: service_status
      comment: "Current operational status of the managed service"
    - name: "service_type"
      expr: service_type
      comment: "Type classification of the managed service"
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level for quality and pricing segmentation"
    - name: "redundancy_type"
      expr: redundancy_type
      comment: "Redundancy configuration for reliability analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency revenue analysis"
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether encryption is enabled for security compliance tracking"
    - name: "noc_monitoring_enabled"
      expr: noc_monitoring_enabled
      comment: "Whether NOC monitoring is enabled for service quality tracking"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of service activation for cohort analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of service activation for time-series analysis"
  measures:
    - name: "total_managed_services"
      expr: COUNT(DISTINCT managed_service_id)
      comment: "Total number of unique managed service instances"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring revenue from all managed services"
    - name: "average_mrr_per_service"
      expr: AVG(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Average monthly recurring revenue per managed service"
    - name: "services_with_encryption"
      expr: COUNT(DISTINCT CASE WHEN encryption_enabled = TRUE THEN managed_service_id END)
      comment: "Number of services with encryption enabled for security compliance"
    - name: "services_with_noc_monitoring"
      expr: COUNT(DISTINCT CASE WHEN noc_monitoring_enabled = TRUE THEN managed_service_id END)
      comment: "Number of services with NOC monitoring for operational coverage tracking"
    - name: "services_with_proactive_monitoring"
      expr: COUNT(DISTINCT CASE WHEN proactive_monitoring_enabled = TRUE THEN managed_service_id END)
      comment: "Number of services with proactive monitoring for service quality"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_iot_deployment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IoT deployment scale and revenue metrics including device counts, data allowances, and MRR tracking"
  source: "`telecommunication_ecm`.`enterprise`.`iot_deployment`"
  dimensions:
    - name: "deployment_status"
      expr: deployment_status
      comment: "Current operational status of the IoT deployment"
    - name: "iot_use_case_type"
      expr: iot_use_case_type
      comment: "Use case classification for IoT deployment segmentation"
    - name: "connectivity_technology"
      expr: connectivity_technology
      comment: "Connectivity technology type for network planning"
    - name: "sim_type"
      expr: sim_type
      comment: "SIM card type for inventory and technology tracking"
    - name: "roaming_enabled_flag"
      expr: roaming_enabled_flag
      comment: "Whether roaming is enabled for coverage analysis"
    - name: "platform_provider"
      expr: platform_provider
      comment: "IoT platform provider for vendor analysis"
    - name: "primary_coverage_country_code"
      expr: primary_coverage_country_code
      comment: "Primary coverage country for geographic analysis"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency revenue analysis"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of deployment activation for cohort analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of deployment activation for time-series analysis"
  measures:
    - name: "total_iot_deployments"
      expr: COUNT(DISTINCT iot_deployment_id)
      comment: "Total number of unique IoT deployments"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring revenue from all IoT deployments"
    - name: "average_mrr_per_deployment"
      expr: AVG(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Average monthly recurring revenue per IoT deployment"
    - name: "total_monthly_data_allowance_mb"
      expr: SUM(CAST(monthly_data_allowance_mb AS DOUBLE))
      comment: "Total monthly data allowance across all deployments in megabytes"
    - name: "average_data_allowance_per_deployment"
      expr: AVG(CAST(monthly_data_allowance_mb AS DOUBLE))
      comment: "Average monthly data allowance per deployment in megabytes"
    - name: "average_uptime_sla_percentage"
      expr: AVG(CAST(uptime_sla_percentage AS DOUBLE))
      comment: "Average uptime SLA percentage across all deployments"
    - name: "deployments_with_roaming"
      expr: COUNT(DISTINCT CASE WHEN roaming_enabled_flag = TRUE THEN iot_deployment_id END)
      comment: "Number of deployments with roaming enabled for coverage tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_uc_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unified communications subscription metrics including seat counts, MRR, and feature adoption tracking"
  source: "`telecommunication_ecm`.`enterprise`.`uc_subscription`"
  dimensions:
    - name: "subscription_status"
      expr: subscription_status
      comment: "Current status of the UC subscription"
    - name: "uc_platform_type"
      expr: uc_platform_type
      comment: "UC platform type for technology mix analysis"
    - name: "feature_pack"
      expr: feature_pack
      comment: "Feature pack tier for product mix analysis"
    - name: "provisioning_status"
      expr: provisioning_status
      comment: "Provisioning status for operational tracking"
    - name: "integration_type"
      expr: integration_type
      comment: "Integration type for ecosystem analysis"
    - name: "call_recording_enabled"
      expr: call_recording_enabled
      comment: "Whether call recording is enabled for compliance tracking"
    - name: "e911_enabled"
      expr: e911_enabled
      comment: "Whether E911 is enabled for safety compliance tracking"
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Whether auto-renewal is enabled for retention forecasting"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency revenue analysis"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of subscription activation for cohort analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of subscription activation for time-series analysis"
  measures:
    - name: "total_uc_subscriptions"
      expr: COUNT(DISTINCT uc_subscription_id)
      comment: "Total number of unique UC subscriptions"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_recurring_revenue AS DOUBLE))
      comment: "Total monthly recurring revenue from all UC subscriptions"
    - name: "average_mrr_per_subscription"
      expr: AVG(CAST(monthly_recurring_revenue AS DOUBLE))
      comment: "Average monthly recurring revenue per UC subscription"
    - name: "average_monthly_seat_charge"
      expr: AVG(CAST(monthly_seat_charge AS DOUBLE))
      comment: "Average monthly charge per seat across all subscriptions"
    - name: "average_uptime_target_percentage"
      expr: AVG(CAST(uptime_percentage_target AS DOUBLE))
      comment: "Average uptime SLA target percentage across subscriptions"
    - name: "subscriptions_with_call_recording"
      expr: COUNT(DISTINCT CASE WHEN call_recording_enabled = TRUE THEN uc_subscription_id END)
      comment: "Number of subscriptions with call recording enabled for compliance tracking"
    - name: "subscriptions_with_e911"
      expr: COUNT(DISTINCT CASE WHEN e911_enabled = TRUE THEN uc_subscription_id END)
      comment: "Number of subscriptions with E911 enabled for safety compliance"
    - name: "subscriptions_with_auto_renewal"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_enabled = TRUE THEN uc_subscription_id END)
      comment: "Number of subscriptions with auto-renewal for retention forecasting"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_sdwan_topology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SD-WAN topology performance and revenue metrics including site counts, SLA targets, and MRR tracking"
  source: "`telecommunication_ecm`.`enterprise`.`sdwan_topology`"
  dimensions:
    - name: "topology_status"
      expr: topology_status
      comment: "Current operational status of the SD-WAN topology"
    - name: "topology_design_type"
      expr: topology_design_type
      comment: "Design type classification for architecture analysis"
    - name: "orchestration_platform"
      expr: orchestration_platform
      comment: "Orchestration platform for vendor analysis"
    - name: "encryption_standard"
      expr: encryption_standard
      comment: "Encryption standard for security compliance tracking"
    - name: "failover_mode"
      expr: failover_mode
      comment: "Failover mode for reliability analysis"
    - name: "cloud_on_ramp_enabled"
      expr: cloud_on_ramp_enabled
      comment: "Whether cloud on-ramp is enabled for cloud integration tracking"
    - name: "firewall_enabled"
      expr: firewall_enabled
      comment: "Whether firewall is enabled for security tracking"
    - name: "ids_ips_enabled"
      expr: ids_ips_enabled
      comment: "Whether IDS/IPS is enabled for security tracking"
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency code for multi-currency revenue analysis"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year of topology activation for cohort analysis"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month of topology activation for time-series analysis"
  measures:
    - name: "total_sdwan_topologies"
      expr: COUNT(DISTINCT sdwan_topology_id)
      comment: "Total number of unique SD-WAN topologies"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Total monthly recurring revenue from all SD-WAN topologies"
    - name: "average_mrr_per_topology"
      expr: AVG(CAST(monthly_recurring_charge AS DOUBLE))
      comment: "Average monthly recurring revenue per SD-WAN topology"
    - name: "average_sla_availability_target"
      expr: AVG(CAST(sla_availability_target_pct AS DOUBLE))
      comment: "Average SLA availability target percentage across topologies"
    - name: "average_sla_packet_loss_target"
      expr: AVG(CAST(sla_packet_loss_target_pct AS DOUBLE))
      comment: "Average SLA packet loss target percentage across topologies"
    - name: "average_failover_threshold_packet_loss"
      expr: AVG(CAST(failover_threshold_packet_loss_pct AS DOUBLE))
      comment: "Average failover threshold packet loss percentage for reliability tracking"
    - name: "topologies_with_cloud_on_ramp"
      expr: COUNT(DISTINCT CASE WHEN cloud_on_ramp_enabled = TRUE THEN sdwan_topology_id END)
      comment: "Number of topologies with cloud on-ramp enabled for cloud integration tracking"
    - name: "topologies_with_firewall"
      expr: COUNT(DISTINCT CASE WHEN firewall_enabled = TRUE THEN sdwan_topology_id END)
      comment: "Number of topologies with firewall enabled for security tracking"
    - name: "topologies_with_ids_ips"
      expr: COUNT(DISTINCT CASE WHEN ids_ips_enabled = TRUE THEN sdwan_topology_id END)
      comment: "Number of topologies with IDS/IPS enabled for security tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_sla_breach`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA breach impact and credit metrics including breach counts, severity distribution, and financial impact tracking"
  source: "`telecommunication_ecm`.`enterprise`.`sla_breach`"
  dimensions:
    - name: "breach_status"
      expr: breach_status
      comment: "Current status of the SLA breach"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity classification of the SLA breach"
    - name: "breach_type"
      expr: breach_type
      comment: "Type classification of the SLA breach"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for trend analysis"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level for operational tracking"
    - name: "credit_issued_flag"
      expr: credit_issued_flag
      comment: "Whether credit was issued for financial impact tracking"
    - name: "repeat_breach_flag"
      expr: repeat_breach_flag
      comment: "Whether this is a repeat breach for quality tracking"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether the breach is disputed for resolution tracking"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation is required for operational tracking"
    - name: "credit_currency_code"
      expr: credit_currency_code
      comment: "Currency code for multi-currency credit analysis"
    - name: "breach_year"
      expr: YEAR(breach_start_timestamp)
      comment: "Year of breach start for trend analysis"
    - name: "breach_month"
      expr: DATE_TRUNC('MONTH', breach_start_timestamp)
      comment: "Month of breach start for time-series analysis"
  measures:
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT sla_breach_id)
      comment: "Total number of unique SLA breaches"
    - name: "total_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total credit amount issued for SLA breaches"
    - name: "average_credit_per_breach"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average credit amount per SLA breach"
    - name: "average_actual_metric_value"
      expr: AVG(CAST(actual_metric_value AS DOUBLE))
      comment: "Average actual metric value during breaches"
    - name: "average_contracted_threshold"
      expr: AVG(CAST(contracted_threshold_value AS DOUBLE))
      comment: "Average contracted threshold value for comparison"
    - name: "breaches_with_credit_issued"
      expr: COUNT(DISTINCT CASE WHEN credit_issued_flag = TRUE THEN sla_breach_id END)
      comment: "Number of breaches where credit was issued for financial impact"
    - name: "repeat_breaches"
      expr: COUNT(DISTINCT CASE WHEN repeat_breach_flag = TRUE THEN sla_breach_id END)
      comment: "Number of repeat breaches for quality tracking"
    - name: "disputed_breaches"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN sla_breach_id END)
      comment: "Number of disputed breaches for resolution tracking"
    - name: "breaches_requiring_escalation"
      expr: COUNT(DISTINCT CASE WHEN escalation_required_flag = TRUE THEN sla_breach_id END)
      comment: "Number of breaches requiring escalation for operational tracking"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`enterprise_discount_scheme`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount scheme effectiveness metrics including discount amounts, tier distribution, and approval tracking"
  source: "`telecommunication_ecm`.`enterprise`.`discount_scheme`"
  dimensions:
    - name: "scheme_status"
      expr: scheme_status
      comment: "Current status of the discount scheme"
    - name: "discount_type"
      expr: discount_type
      comment: "Type classification of the discount"
    - name: "tier_level"
      expr: tier_level
      comment: "Tier level for volume-based discount analysis"
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for discount applicability analysis"
    - name: "stacking_allowed"
      expr: stacking_allowed
      comment: "Whether discount stacking is allowed for pricing complexity tracking"
    - name: "renewal_eligibility"
      expr: renewal_eligibility
      comment: "Whether scheme is eligible for renewal for retention tracking"
    - name: "proration_allowed"
      expr: proration_allowed
      comment: "Whether proration is allowed for billing flexibility tracking"
    - name: "billing_currency_code"
      expr: billing_currency_code
      comment: "Currency code for multi-currency discount analysis"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of scheme approval for trend analysis"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Year of scheme effective start for cohort analysis"
  measures:
    - name: "total_discount_schemes"
      expr: COUNT(DISTINCT discount_scheme_id)
      comment: "Total number of unique discount schemes"
    - name: "average_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across all schemes"
    - name: "total_discount_fixed_amount"
      expr: SUM(CAST(discount_fixed_amount AS DOUBLE))
      comment: "Total fixed discount amount across all schemes"
    - name: "average_discount_fixed_amount"
      expr: AVG(CAST(discount_fixed_amount AS DOUBLE))
      comment: "Average fixed discount amount per scheme"
    - name: "total_maximum_discount_cap"
      expr: SUM(CAST(maximum_discount_cap AS DOUBLE))
      comment: "Total maximum discount cap across all schemes"
    - name: "average_minimum_commitment_threshold"
      expr: AVG(CAST(minimum_commitment_threshold AS DOUBLE))
      comment: "Average minimum commitment threshold for discount eligibility"
    - name: "average_tier_threshold_lower"
      expr: AVG(CAST(tier_threshold_lower AS DOUBLE))
      comment: "Average lower tier threshold for volume discount analysis"
    - name: "average_tier_threshold_upper"
      expr: AVG(CAST(tier_threshold_upper AS DOUBLE))
      comment: "Average upper tier threshold for volume discount analysis"
    - name: "schemes_with_stacking_allowed"
      expr: COUNT(DISTINCT CASE WHEN stacking_allowed = TRUE THEN discount_scheme_id END)
      comment: "Number of schemes allowing discount stacking for pricing complexity tracking"
    - name: "schemes_with_renewal_eligibility"
      expr: COUNT(DISTINCT CASE WHEN renewal_eligibility = TRUE THEN discount_scheme_id END)
      comment: "Number of schemes eligible for renewal for retention tracking"
$$;