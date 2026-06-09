-- Metric views for domain: product | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:30:14

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_addon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Addon business metrics"
  source: "`telecommunication_ecm`.`product`.`addon`"
  dimensions:
    - name: "Activation Method"
      expr: activation_method
    - name: "Addon Category"
      expr: addon_category
    - name: "Addon Code"
      expr: addon_code
    - name: "Addon Description"
      expr: addon_description
    - name: "Addon Name"
      expr: addon_name
    - name: "Addon Type"
      expr: addon_type
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Deactivation Method"
      expr: deactivation_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Product Code"
      expr: external_product_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Addon"
      expr: COUNT(DISTINCT addon_id)
    - name: "Total Quota Value"
      expr: SUM(quota_value)
    - name: "Average Quota Value"
      expr: AVG(quota_value)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundle business metrics"
  source: "`telecommunication_ecm`.`product`.`bundle`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Bundle Category"
      expr: bundle_category
    - name: "Bundle Code"
      expr: bundle_code
    - name: "Bundle Description"
      expr: bundle_description
    - name: "Bundle Name"
      expr: bundle_name
    - name: "Bundle Type"
      expr: bundle_type
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Component Substitution Allowed"
      expr: component_substitution_allowed
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Included Flag"
      expr: device_included_flag
    - name: "Downgrade Eligible Flag"
      expr: downgrade_eligible_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bundle"
      expr: COUNT(DISTINCT bundle_id)
    - name: "Total Activation Fee"
      expr: SUM(activation_fee)
    - name: "Average Activation Fee"
      expr: AVG(activation_fee)
    - name: "Total Data Allowance Gb"
      expr: SUM(data_allowance_gb)
    - name: "Average Data Allowance Gb"
      expr: AVG(data_allowance_gb)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Early Termination Fee"
      expr: SUM(early_termination_fee)
    - name: "Average Early Termination Fee"
      expr: AVG(early_termination_fee)
    - name: "Total Installation Fee"
      expr: SUM(installation_fee)
    - name: "Average Installation Fee"
      expr: AVG(installation_fee)
    - name: "Total Price Amount"
      expr: SUM(price_amount)
    - name: "Average Price Amount"
      expr: AVG(price_amount)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_bundle_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundle Component business metrics"
  source: "`telecommunication_ecm`.`product`.`bundle_component`"
  dimensions:
    - name: "Component Quantity"
      expr: component_quantity
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Mandatory Component"
      expr: is_mandatory_component
    - name: "Sequence Number"
      expr: sequence_number
    - name: "Substitution Allowed"
      expr: substitution_allowed
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bundle Component"
      expr: COUNT(DISTINCT bundle_component_id)
    - name: "Total Component Discount Percentage"
      expr: SUM(component_discount_percentage)
    - name: "Average Component Discount Percentage"
      expr: AVG(component_discount_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_catalog_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Catalog Item business metrics"
  source: "`telecommunication_ecm`.`product`.`catalog_item`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Catalog Version"
      expr: catalog_version
    - name: "Channel Count"
      expr: channel_count
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "End Of Life Date"
      expr: end_of_life_date
    - name: "End Of Sale Date"
      expr: end_of_sale_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Availability"
      expr: geographic_availability
    - name: "Is Bundled"
      expr: is_bundled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Catalog Item"
      expr: COUNT(DISTINCT catalog_item_id)
    - name: "Total Base Price"
      expr: SUM(base_price)
    - name: "Average Base Price"
      expr: AVG(base_price)
    - name: "Total Data Allowance Gb"
      expr: SUM(data_allowance_gb)
    - name: "Average Data Allowance Gb"
      expr: AVG(data_allowance_gb)
    - name: "Total Download Speed Mbps"
      expr: SUM(download_speed_mbps)
    - name: "Average Download Speed Mbps"
      expr: AVG(download_speed_mbps)
    - name: "Total Sla Mttr Hours"
      expr: SUM(sla_mttr_hours)
    - name: "Average Sla Mttr Hours"
      expr: AVG(sla_mttr_hours)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
    - name: "Total Upload Speed Mbps"
      expr: SUM(upload_speed_mbps)
    - name: "Average Upload Speed Mbps"
      expr: AVG(upload_speed_mbps)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_device_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Device Model business metrics"
  source: "`telecommunication_ecm`.`product`.`device_model`"
  dimensions:
    - name: "Battery Capacity Mah"
      expr: battery_capacity_mah
    - name: "Color Variants"
      expr: color_variants
    - name: "Compliance Certifications"
      expr: compliance_certifications
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Category"
      expr: device_category
    - name: "Device Subcategory"
      expr: device_subcategory
    - name: "Dimensions"
      expr: dimensions
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Display Resolution"
      expr: display_resolution
    - name: "Drm Support"
      expr: drm_support
    - name: "Dual Sim Support"
      expr: dual_sim_support
    - name: "End Of Support Date"
      expr: end_of_support_date
    - name: "Esim Capable"
      expr: esim_capable
    - name: "Ethernet Ports"
      expr: ethernet_ports
    - name: "Frequency Bands"
      expr: frequency_bands
    - name: "Gps Enabled"
      expr: gps_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Device Model"
      expr: COUNT(DISTINCT device_model_id)
    - name: "Total Display Size Inches"
      expr: SUM(display_size_inches)
    - name: "Average Display Size Inches"
      expr: AVG(display_size_inches)
    - name: "Total Retail Price"
      expr: SUM(retail_price)
    - name: "Average Retail Price"
      expr: AVG(retail_price)
    - name: "Total Sar Value"
      expr: SUM(sar_value)
    - name: "Average Sar Value"
      expr: AVG(sar_value)
    - name: "Total Wholesale Cost"
      expr: SUM(wholesale_cost)
    - name: "Average Wholesale Cost"
      expr: AVG(wholesale_cost)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_eligibility_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Rule business metrics"
  source: "`telecommunication_ecm`.`product`.`eligibility_rule`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Compliance Framework"
      expr: compliance_framework
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Error Message"
      expr: error_message
    - name: "Evaluation Frequency"
      expr: evaluation_frequency
    - name: "External Rule Code"
      expr: external_rule_code
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Mandatory"
      expr: is_mandatory
    - name: "Is Overridable"
      expr: is_overridable
    - name: "Logical Operator"
      expr: logical_operator
    - name: "Market Segment"
      expr: market_segment
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Rule"
      expr: COUNT(DISTINCT eligibility_rule_id)
    - name: "Total Rule Value"
      expr: SUM(rule_value)
    - name: "Average Rule Value"
      expr: AVG(rule_value)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_offering`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offering business metrics"
  source: "`telecommunication_ecm`.`product`.`offering`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Bundle Flag"
      expr: bundle_flag
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Competitive Positioning"
      expr: competitive_positioning
    - name: "Content Entitlements"
      expr: content_entitlements
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Class Eligibility"
      expr: credit_class_eligibility
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Included Flag"
      expr: device_included_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Rules Summary"
      expr: eligibility_rules_summary
    - name: "Etf Structure"
      expr: etf_structure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Offering"
      expr: COUNT(DISTINCT offering_id)
    - name: "Total Base Monthly Price"
      expr: SUM(base_monthly_price)
    - name: "Average Base Monthly Price"
      expr: AVG(base_monthly_price)
    - name: "Total Data Allowance Gb"
      expr: SUM(data_allowance_gb)
    - name: "Average Data Allowance Gb"
      expr: AVG(data_allowance_gb)
    - name: "Total Download Speed Mbps"
      expr: SUM(download_speed_mbps)
    - name: "Average Download Speed Mbps"
      expr: AVG(download_speed_mbps)
    - name: "Total One Time Activation Fee"
      expr: SUM(one_time_activation_fee)
    - name: "Average One Time Activation Fee"
      expr: AVG(one_time_activation_fee)
    - name: "Total Upload Speed Mbps"
      expr: SUM(upload_speed_mbps)
    - name: "Average Upload Speed Mbps"
      expr: AVG(upload_speed_mbps)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_price_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Plan business metrics"
  source: "`telecommunication_ecm`.`product`.`price_plan`"
  dimensions:
    - name: "Advance Payment Required Flag"
      expr: advance_payment_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Bundle Eligible Flag"
      expr: bundle_eligible_flag
    - name: "Charge Type"
      expr: charge_type
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Geographic Availability"
      expr: geographic_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Plan"
      expr: COUNT(DISTINCT price_plan_id)
    - name: "Total Base Price Amount"
      expr: SUM(base_price_amount)
    - name: "Average Base Price Amount"
      expr: AVG(base_price_amount)
    - name: "Total Early Termination Fee"
      expr: SUM(early_termination_fee)
    - name: "Average Early Termination Fee"
      expr: AVG(early_termination_fee)
    - name: "Total Included Quantity"
      expr: SUM(included_quantity)
    - name: "Average Included Quantity"
      expr: AVG(included_quantity)
    - name: "Total Maximum Charge Amount"
      expr: SUM(maximum_charge_amount)
    - name: "Average Maximum Charge Amount"
      expr: AVG(maximum_charge_amount)
    - name: "Total Minimum Commitment Amount"
      expr: SUM(minimum_commitment_amount)
    - name: "Average Minimum Commitment Amount"
      expr: AVG(minimum_commitment_amount)
    - name: "Total Overage Rate"
      expr: SUM(overage_rate)
    - name: "Average Overage Rate"
      expr: AVG(overage_rate)
    - name: "Total Sla Uptime Percentage"
      expr: SUM(sla_uptime_percentage)
    - name: "Average Sla Uptime Percentage"
      expr: AVG(sla_uptime_percentage)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Offer business metrics"
  source: "`telecommunication_ecm`.`product`.`promo_offer`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Approved By"
      expr: approved_by
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Bonus Data Unit"
      expr: bonus_data_unit
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discount Currency Code"
      expr: discount_currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligibility Channel"
      expr: eligibility_channel
    - name: "Eligibility Customer Type"
      expr: eligibility_customer_type
    - name: "Eligibility Geographic Scope"
      expr: eligibility_geographic_scope
    - name: "Eligibility Product Category"
      expr: eligibility_product_category
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Free Trial Duration"
      expr: free_trial_duration
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Offer"
      expr: COUNT(DISTINCT promo_offer_id)
    - name: "Total Bonus Data Amount"
      expr: SUM(bonus_data_amount)
    - name: "Average Bonus Data Amount"
      expr: AVG(bonus_data_amount)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Budget Consumed"
      expr: SUM(budget_consumed)
    - name: "Average Budget Consumed"
      expr: AVG(budget_consumed)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Target Arpu Impact"
      expr: SUM(target_arpu_impact)
    - name: "Average Target Arpu Impact"
      expr: AVG(target_arpu_impact)
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`product_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Spec business metrics"
  source: "`telecommunication_ecm`.`product`.`spec`"
  dimensions:
    - name: "Allowance Type"
      expr: allowance_type
    - name: "Channel Count"
      expr: channel_count
    - name: "Characteristic Name"
      expr: characteristic_name
    - name: "Concurrent Streams"
      expr: concurrent_streams
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dvr Hours"
      expr: dvr_hours
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Rollover Enabled"
      expr: is_rollover_enabled
    - name: "Is Shared"
      expr: is_shared
    - name: "Is Unlimited"
      expr: is_unlimited
    - name: "Modified By"
      expr: modified_by
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Overage Policy"
      expr: overage_policy
    - name: "Priority Level"
      expr: priority_level
    - name: "Qos Class"
      expr: qos_class
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Spec"
      expr: COUNT(DISTINCT spec_id)
    - name: "Total Allowance Quantity"
      expr: SUM(allowance_quantity)
    - name: "Average Allowance Quantity"
      expr: AVG(allowance_quantity)
    - name: "Total Bandwidth Mbps"
      expr: SUM(bandwidth_mbps)
    - name: "Average Bandwidth Mbps"
      expr: AVG(bandwidth_mbps)
    - name: "Total Burst Bandwidth Mbps"
      expr: SUM(burst_bandwidth_mbps)
    - name: "Average Burst Bandwidth Mbps"
      expr: AVG(burst_bandwidth_mbps)
    - name: "Total Characteristic Value"
      expr: SUM(characteristic_value)
    - name: "Average Characteristic Value"
      expr: AVG(characteristic_value)
    - name: "Total Download Speed Mbps"
      expr: SUM(download_speed_mbps)
    - name: "Average Download Speed Mbps"
      expr: AVG(download_speed_mbps)
    - name: "Total Fair Use Limit Gb"
      expr: SUM(fair_use_limit_gb)
    - name: "Average Fair Use Limit Gb"
      expr: AVG(fair_use_limit_gb)
    - name: "Total Latency Ms"
      expr: SUM(latency_ms)
    - name: "Average Latency Ms"
      expr: AVG(latency_ms)
    - name: "Total Mttr Hours"
      expr: SUM(mttr_hours)
    - name: "Average Mttr Hours"
      expr: AVG(mttr_hours)
    - name: "Total Roaming Data Allowance Gb"
      expr: SUM(roaming_data_allowance_gb)
    - name: "Average Roaming Data Allowance Gb"
      expr: AVG(roaming_data_allowance_gb)
    - name: "Total Sla Uptime Percent"
      expr: SUM(sla_uptime_percent)
    - name: "Average Sla Uptime Percent"
      expr: AVG(sla_uptime_percent)
    - name: "Total Throttle Speed Mbps"
      expr: SUM(throttle_speed_mbps)
    - name: "Average Throttle Speed Mbps"
      expr: AVG(throttle_speed_mbps)
    - name: "Total Upload Speed Mbps"
      expr: SUM(upload_speed_mbps)
    - name: "Average Upload Speed Mbps"
      expr: AVG(upload_speed_mbps)
$$;