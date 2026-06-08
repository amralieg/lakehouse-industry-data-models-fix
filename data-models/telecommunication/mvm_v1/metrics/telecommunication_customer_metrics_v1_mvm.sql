-- Metric views for domain: customer | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account health and value metrics including ARPU, CLTV, churn risk, and account status distribution for strategic customer management and retention analysis"
  source: "`telecommunication_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, suspended, terminated, etc.)"
    - name: "account_tier"
      expr: account_tier
      comment: "Service tier or segment classification of the account"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (consumer, business, enterprise, etc.)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Marketing or business segment classification"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired"
    - name: "credit_class"
      expr: credit_class
      comment: "Credit risk classification of the account"
    - name: "cltv_segment"
      expr: cltv_segment
      comment: "Customer lifetime value segment bucket"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the customer account was acquired"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month the customer account was acquired"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the account is flagged as VIP"
    - name: "auto_pay_enabled_flag"
      expr: auto_pay_enabled_flag
      comment: "Indicates whether auto-pay is enabled"
    - name: "paperless_billing_flag"
      expr: paperless_billing_flag
      comment: "Indicates whether paperless billing is enabled"
    - name: "fraud_flag"
      expr: fraud_flag
      comment: "Indicates whether the account is flagged for fraud"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total number of unique customer accounts"
    - name: "total_arpu"
      expr: SUM(CAST(arpu AS DOUBLE))
      comment: "Sum of average revenue per user across all accounts"
    - name: "avg_arpu"
      expr: AVG(CAST(arpu AS DOUBLE))
      comment: "Average revenue per user across accounts - key profitability indicator"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score - critical for proactive retention strategy"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score - key risk management metric"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts - critical AR and cash flow metric"
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts - risk exposure metric"
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction score - key customer experience indicator"
    - name: "high_churn_risk_accounts"
      expr: COUNT(DISTINCT CASE WHEN CAST(churn_risk_score AS DOUBLE) > 70 THEN customer_account_id END)
      comment: "Count of accounts with high churn risk (score > 70) - immediate retention action trigger"
    - name: "vip_accounts"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN customer_account_id END)
      comment: "Count of VIP accounts requiring premium service"
    - name: "fraud_flagged_accounts"
      expr: COUNT(DISTINCT CASE WHEN fraud_flag = TRUE THEN customer_account_id END)
      comment: "Count of accounts flagged for fraud - risk management KPI"
    - name: "autopay_enabled_accounts"
      expr: COUNT(DISTINCT CASE WHEN auto_pay_enabled_flag = TRUE THEN customer_account_id END)
      comment: "Count of accounts with auto-pay enabled - payment efficiency indicator"
    - name: "paperless_accounts"
      expr: COUNT(DISTINCT CASE WHEN paperless_billing_flag = TRUE THEN customer_account_id END)
      comment: "Count of paperless billing accounts - cost reduction and sustainability metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_subscriber`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscriber lifecycle, service adoption, and risk metrics including activation trends, 5G penetration, churn risk, and fraud scores for network planning and retention strategy"
  source: "`telecommunication_ecm`.`customer`.`subscriber`"
  dimensions:
    - name: "subscriber_status"
      expr: subscriber_status
      comment: "Current status of the subscriber (active, suspended, deactivated, etc.)"
    - name: "subscriber_type"
      expr: subscriber_type
      comment: "Type of subscriber (prepaid, postpaid, etc.)"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Marketing or business segment classification"
    - name: "credit_class"
      expr: credit_class
      comment: "Credit risk classification"
    - name: "data_speed_tier"
      expr: data_speed_tier
      comment: "Data speed tier subscribed by the user"
    - name: "qos_profile"
      expr: qos_profile
      comment: "Quality of service profile assigned to the subscriber"
    - name: "roaming_profile"
      expr: roaming_profile
      comment: "Roaming profile configuration"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the subscriber was activated"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the subscriber was activated"
    - name: "five_g_enabled_flag"
      expr: five_g_enabled_flag
      comment: "Indicates whether 5G service is enabled"
    - name: "volte_enabled_flag"
      expr: volte_enabled_flag
      comment: "Indicates whether VoLTE is enabled"
    - name: "vowifi_enabled_flag"
      expr: vowifi_enabled_flag
      comment: "Indicates whether VoWiFi is enabled"
    - name: "roaming_enabled_flag"
      expr: roaming_enabled_flag
      comment: "Indicates whether roaming is enabled"
    - name: "esim_eligible_flag"
      expr: esim_eligible_flag
      comment: "Indicates whether subscriber is eligible for eSIM"
  measures:
    - name: "total_subscribers"
      expr: COUNT(DISTINCT subscriber_id)
      comment: "Total number of unique subscribers - core business volume metric"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across subscribers - critical retention planning metric"
    - name: "avg_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average customer lifetime value score - strategic investment prioritization metric"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score - security and risk management KPI"
    - name: "five_g_enabled_subscribers"
      expr: COUNT(DISTINCT CASE WHEN five_g_enabled_flag = TRUE THEN subscriber_id END)
      comment: "Count of 5G-enabled subscribers - network modernization and ARPU uplift indicator"
    - name: "volte_enabled_subscribers"
      expr: COUNT(DISTINCT CASE WHEN volte_enabled_flag = TRUE THEN subscriber_id END)
      comment: "Count of VoLTE-enabled subscribers - voice quality and network efficiency metric"
    - name: "vowifi_enabled_subscribers"
      expr: COUNT(DISTINCT CASE WHEN vowifi_enabled_flag = TRUE THEN subscriber_id END)
      comment: "Count of VoWiFi-enabled subscribers - coverage enhancement metric"
    - name: "roaming_enabled_subscribers"
      expr: COUNT(DISTINCT CASE WHEN roaming_enabled_flag = TRUE THEN subscriber_id END)
      comment: "Count of roaming-enabled subscribers - international revenue opportunity metric"
    - name: "esim_eligible_subscribers"
      expr: COUNT(DISTINCT CASE WHEN esim_eligible_flag = TRUE THEN subscriber_id END)
      comment: "Count of eSIM-eligible subscribers - digital transformation readiness metric"
    - name: "high_churn_risk_subscribers"
      expr: COUNT(DISTINCT CASE WHEN CAST(churn_risk_score AS DOUBLE) > 70 THEN subscriber_id END)
      comment: "Count of subscribers with high churn risk - immediate retention intervention trigger"
    - name: "high_value_subscribers"
      expr: COUNT(DISTINCT CASE WHEN CAST(cltv_score AS DOUBLE) > 80 THEN subscriber_id END)
      comment: "Count of high-value subscribers (CLTV > 80) - premium service targeting metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case resolution efficiency, SLA compliance, and retention effectiveness metrics for operational excellence and customer experience management"
  source: "`telecommunication_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case"
    - name: "case_type"
      expr: case_type
      comment: "Type or classification of the case"
    - name: "case_category"
      expr: case_category
      comment: "Category of the case"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the case"
    - name: "channel"
      expr: channel
      comment: "Channel through which the case was created"
    - name: "origin"
      expr: origin
      comment: "Origin or source of the case"
    - name: "owning_team"
      expr: owning_team
      comment: "Team responsible for the case"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the case"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the issue"
    - name: "retention_outcome"
      expr: retention_outcome
      comment: "Outcome of retention efforts"
    - name: "created_year"
      expr: YEAR(created_date)
      comment: "Year the case was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month the case was created"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the case was escalated"
    - name: "fcr_flag"
      expr: fcr_flag
      comment: "First call resolution flag"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether SLA was breached"
    - name: "regulatory_flag"
      expr: regulatory_flag
      comment: "Indicates whether case has regulatory implications"
    - name: "offer_accepted_flag"
      expr: offer_accepted_flag
      comment: "Indicates whether retention offer was accepted"
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT case_id)
      comment: "Total number of customer service cases - workload and demand metric"
    - name: "avg_time_to_resolution_hours"
      expr: AVG(CAST(time_to_resolution_hours AS DOUBLE))
      comment: "Average time to resolve cases in hours - operational efficiency KPI"
    - name: "fcr_cases"
      expr: COUNT(DISTINCT CASE WHEN fcr_flag = TRUE THEN case_id END)
      comment: "Count of first call resolution cases - service quality and efficiency metric"
    - name: "sla_breach_cases"
      expr: COUNT(DISTINCT CASE WHEN sla_breach_flag = TRUE THEN case_id END)
      comment: "Count of cases with SLA breaches - service level compliance metric"
    - name: "escalated_cases"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN case_id END)
      comment: "Count of escalated cases - complexity and service quality indicator"
    - name: "regulatory_cases"
      expr: COUNT(DISTINCT CASE WHEN regulatory_flag = TRUE THEN case_id END)
      comment: "Count of cases with regulatory implications - compliance risk metric"
    - name: "retention_offer_accepted_cases"
      expr: COUNT(DISTINCT CASE WHEN offer_accepted_flag = TRUE THEN case_id END)
      comment: "Count of cases where retention offer was accepted - save rate metric"
    - name: "total_offer_value"
      expr: SUM(CAST(offer_value AS DOUBLE))
      comment: "Total value of retention offers made - retention investment metric"
    - name: "total_retention_cost"
      expr: SUM(CAST(retention_cost AS DOUBLE))
      comment: "Total cost of retention activities - retention program efficiency metric"
    - name: "avg_offer_value"
      expr: AVG(CAST(offer_value AS DOUBLE))
      comment: "Average value of retention offers per case"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction quality, channel effectiveness, and sentiment metrics for contact center optimization and customer experience improvement"
  source: "`telecommunication_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred"
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction"
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (inbound, outbound)"
    - name: "topic_category"
      expr: topic_category
      comment: "Primary topic category of the interaction"
    - name: "topic_subcategory"
      expr: topic_subcategory
      comment: "Subcategory of the interaction topic"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Resolution status of the interaction"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the interaction"
    - name: "queue_name"
      expr: queue_name
      comment: "Queue or team that handled the interaction"
    - name: "language_code"
      expr: language_code
      comment: "Language used in the interaction"
    - name: "interaction_year"
      expr: YEAR(start_timestamp)
      comment: "Year the interaction started"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month the interaction started"
    - name: "fcr_flag"
      expr: fcr_flag
      comment: "First call resolution flag"
    - name: "callback_requested_flag"
      expr: callback_requested_flag
      comment: "Indicates whether callback was requested"
    - name: "nps_survey_triggered_flag"
      expr: nps_survey_triggered_flag
      comment: "Indicates whether NPS survey was triggered"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions - contact center volume metric"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across interactions - customer experience health indicator"
    - name: "fcr_interactions"
      expr: COUNT(DISTINCT CASE WHEN fcr_flag = TRUE THEN interaction_id END)
      comment: "Count of first call resolution interactions - service efficiency KPI"
    - name: "callback_requested_interactions"
      expr: COUNT(DISTINCT CASE WHEN callback_requested_flag = TRUE THEN interaction_id END)
      comment: "Count of interactions requiring callback - service level and capacity planning metric"
    - name: "nps_survey_triggered_interactions"
      expr: COUNT(DISTINCT CASE WHEN nps_survey_triggered_flag = TRUE THEN interaction_id END)
      comment: "Count of interactions that triggered NPS survey - feedback coverage metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription lifecycle, recurring revenue, and renewal metrics for revenue forecasting and product performance analysis"
  source: "`telecommunication_ecm`.`customer`.`subscription`"
  dimensions:
    - name: "addon_status"
      expr: addon_status
      comment: "Status of the subscription addon"
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the subscription was activated"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month the subscription was activated"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for subscription cancellation"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether auto-renewal is enabled"
  measures:
    - name: "total_subscriptions"
      expr: COUNT(DISTINCT subscription_id)
      comment: "Total number of subscriptions - product adoption metric"
    - name: "total_recurring_charge"
      expr: SUM(CAST(recurring_charge AS DOUBLE))
      comment: "Total recurring revenue from subscriptions - core MRR/ARR metric"
    - name: "avg_recurring_charge"
      expr: AVG(CAST(recurring_charge AS DOUBLE))
      comment: "Average recurring charge per subscription - pricing effectiveness metric"
    - name: "total_proration_amount"
      expr: SUM(CAST(proration_amount AS DOUBLE))
      comment: "Total proration adjustments - billing accuracy and customer satisfaction metric"
    - name: "auto_renewal_subscriptions"
      expr: COUNT(DISTINCT CASE WHEN auto_renewal_flag = TRUE THEN subscription_id END)
      comment: "Count of subscriptions with auto-renewal enabled - revenue predictability metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_device_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device lifecycle, 5G readiness, and BYOD adoption metrics for network planning and device strategy"
  source: "`telecommunication_ecm`.`customer`.`device_registration`"
  dimensions:
    - name: "device_status"
      expr: device_status
      comment: "Current status of the registered device"
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which device was registered"
    - name: "os_type"
      expr: os_type
      comment: "Operating system type of the device"
    - name: "sim_slot_type"
      expr: sim_slot_type
      comment: "Type of SIM slot (physical, eSIM, dual)"
    - name: "wifi_capability"
      expr: wifi_capability
      comment: "WiFi capability of the device"
    - name: "deregistration_reason"
      expr: deregistration_reason
      comment: "Reason for device deregistration"
    - name: "registration_year"
      expr: YEAR(registration_date)
      comment: "Year the device was registered"
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month the device was registered"
    - name: "byod_flag"
      expr: byod_flag
      comment: "Indicates whether device is bring-your-own-device"
    - name: "network_capability_5g"
      expr: network_capability_5g
      comment: "Indicates whether device supports 5G"
    - name: "network_capability_4g"
      expr: network_capability_4g
      comment: "Indicates whether device supports 4G"
    - name: "volte_capable"
      expr: volte_capable
      comment: "Indicates whether device is VoLTE capable"
    - name: "device_financing_flag"
      expr: device_financing_flag
      comment: "Indicates whether device is financed"
    - name: "insurance_enrollment_flag"
      expr: insurance_enrollment_flag
      comment: "Indicates whether device insurance is enrolled"
    - name: "ceir_block_flag"
      expr: ceir_block_flag
      comment: "Indicates whether device is blocked in CEIR"
  measures:
    - name: "total_devices"
      expr: COUNT(DISTINCT device_registration_id)
      comment: "Total number of registered devices - device base metric"
    - name: "byod_devices"
      expr: COUNT(DISTINCT CASE WHEN byod_flag = TRUE THEN device_registration_id END)
      comment: "Count of bring-your-own-device registrations - BYOD program adoption metric"
    - name: "five_g_capable_devices"
      expr: COUNT(DISTINCT CASE WHEN network_capability_5g = TRUE THEN device_registration_id END)
      comment: "Count of 5G-capable devices - network modernization readiness metric"
    - name: "volte_capable_devices"
      expr: COUNT(DISTINCT CASE WHEN volte_capable = TRUE THEN device_registration_id END)
      comment: "Count of VoLTE-capable devices - voice quality infrastructure readiness"
    - name: "financed_devices"
      expr: COUNT(DISTINCT CASE WHEN device_financing_flag = TRUE THEN device_registration_id END)
      comment: "Count of financed devices - device financing program volume metric"
    - name: "insured_devices"
      expr: COUNT(DISTINCT CASE WHEN insurance_enrollment_flag = TRUE THEN device_registration_id END)
      comment: "Count of insured devices - insurance program penetration metric"
    - name: "ceir_blocked_devices"
      expr: COUNT(DISTINCT CASE WHEN ceir_block_flag = TRUE THEN device_registration_id END)
      comment: "Count of CEIR-blocked devices - fraud and theft prevention metric"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price_amount AS DOUBLE))
      comment: "Total purchase price of all devices - device revenue metric"
    - name: "total_residual_value"
      expr: SUM(CAST(residual_value_amount AS DOUBLE))
      comment: "Total residual value of financed devices - asset value and risk metric"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`customer_address`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network coverage, serviceability, and infrastructure readiness metrics for network expansion planning and service availability analysis"
  source: "`telecommunication_ecm`.`customer`.`address`"
  dimensions:
    - name: "address_type"
      expr: address_type
      comment: "Type of address (service, billing, etc.)"
    - name: "dwelling_type"
      expr: dwelling_type
      comment: "Type of dwelling at the address"
    - name: "city"
      expr: city
      comment: "City of the address"
    - name: "state_province"
      expr: state_province
      comment: "State or province of the address"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the address"
    - name: "broadband_coverage_tier"
      expr: broadband_coverage_tier
      comment: "Broadband coverage tier available at the address"
    - name: "validation_status"
      expr: validation_status
      comment: "Address validation status"
    - name: "validation_source"
      expr: validation_source
      comment: "Source of address validation"
    - name: "active_flag"
      expr: active_flag
      comment: "Indicates whether the address is active"
    - name: "ftth_serviceable_flag"
      expr: ftth_serviceable_flag
      comment: "Indicates whether fiber-to-the-home is serviceable"
    - name: "gpon_serviceable_flag"
      expr: gpon_serviceable_flag
      comment: "Indicates whether GPON is serviceable"
    - name: "lte_coverage_flag"
      expr: lte_coverage_flag
      comment: "Indicates whether LTE coverage is available"
    - name: "n5g_coverage_flag"
      expr: n5g_coverage_flag
      comment: "Indicates whether 5G coverage is available"
    - name: "mdu_flag"
      expr: mdu_flag
      comment: "Indicates whether address is multi-dwelling unit"
    - name: "primary_address_flag"
      expr: primary_address_flag
      comment: "Indicates whether this is the primary address"
  measures:
    - name: "total_addresses"
      expr: COUNT(DISTINCT address_id)
      comment: "Total number of addresses - addressable market size metric"
    - name: "ftth_serviceable_addresses"
      expr: COUNT(DISTINCT CASE WHEN ftth_serviceable_flag = TRUE THEN address_id END)
      comment: "Count of fiber-to-the-home serviceable addresses - fiber footprint metric"
    - name: "gpon_serviceable_addresses"
      expr: COUNT(DISTINCT CASE WHEN gpon_serviceable_flag = TRUE THEN address_id END)
      comment: "Count of GPON serviceable addresses - GPON infrastructure coverage metric"
    - name: "lte_coverage_addresses"
      expr: COUNT(DISTINCT CASE WHEN lte_coverage_flag = TRUE THEN address_id END)
      comment: "Count of addresses with LTE coverage - 4G network reach metric"
    - name: "five_g_coverage_addresses"
      expr: COUNT(DISTINCT CASE WHEN n5g_coverage_flag = TRUE THEN address_id END)
      comment: "Count of addresses with 5G coverage - 5G network expansion metric"
    - name: "mdu_addresses"
      expr: COUNT(DISTINCT CASE WHEN mdu_flag = TRUE THEN address_id END)
      comment: "Count of multi-dwelling unit addresses - bulk service opportunity metric"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for addresses - data governance metric"
    - name: "avg_maximum_download_speed_mbps"
      expr: AVG(CAST(maximum_download_speed_mbps AS DOUBLE))
      comment: "Average maximum download speed available - network capability metric"
    - name: "avg_maximum_upload_speed_mbps"
      expr: AVG(CAST(maximum_upload_speed_mbps AS DOUBLE))
      comment: "Average maximum upload speed available - network capability metric"
$$;