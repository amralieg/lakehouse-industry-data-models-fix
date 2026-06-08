-- Metric views for domain: channel | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:55:55

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_booking_source`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking Source business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`booking_source`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Api Connectivity Type"
      expr: api_connectivity_type
    - name: "Attribution Hierarchy Level"
      expr: attribution_hierarchy_level
    - name: "Booking Source Status"
      expr: booking_source_status
    - name: "Booking Window Max Days"
      expr: booking_window_max_days
    - name: "Booking Window Min Days"
      expr: booking_window_min_days
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Applicable"
      expr: connectivity_fee_applicable
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Source Code"
      expr: crs_source_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking Source"
      expr: COUNT(DISTINCT booking_source_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Bar Eligible"
      expr: bar_eligible
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Category"
      expr: channel_category
    - name: "Channel Code"
      expr: channel_code
    - name: "Channel Description"
      expr: channel_description
    - name: "Channel Name"
      expr: channel_name
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Method"
      expr: connectivity_method
    - name: "Content Distribution Enabled"
      expr: content_distribution_enabled
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Channel Code"
      expr: crs_channel_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel"
      expr: COUNT(DISTINCT channel_id)
    - name: "Total Booking Fee Usd"
      expr: SUM(booking_fee_usd)
    - name: "Average Booking Fee Usd"
      expr: AVG(booking_fee_usd)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Sla Uptime Pct"
      expr: SUM(sla_uptime_pct)
    - name: "Average Sla Uptime Pct"
      expr: AVG(sla_uptime_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Booking business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_booking`"
  dimensions:
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Channel Type"
      expr: channel_type
    - name: "Check In Date"
      expr: check_in_date
    - name: "Check Out Date"
      expr: check_out_date
    - name: "Corporate Account Code"
      expr: corporate_account_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Booking Reference"
      expr: crs_booking_reference
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Segment Number"
      expr: gds_segment_number
    - name: "Is Cancelled"
      expr: is_cancelled
    - name: "Is Modified"
      expr: is_modified
    - name: "Is Rate Parity Compliant"
      expr: is_rate_parity_compliant
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Booking"
      expr: COUNT(DISTINCT channel_booking_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Channel Commission Amount"
      expr: SUM(channel_commission_amount)
    - name: "Average Channel Commission Amount"
      expr: AVG(channel_commission_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Gross Booking Value"
      expr: SUM(gross_booking_value)
    - name: "Average Gross Booking Value"
      expr: AVG(gross_booking_value)
    - name: "Total Net Revenue Amount"
      expr: SUM(net_revenue_amount)
    - name: "Average Net Revenue Amount"
      expr: AVG(net_revenue_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Contract business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_contract`"
  dimensions:
    - name: "Bar Access"
      expr: bar_access
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Connectivity Fee Type"
      expr: connectivity_fee_type
    - name: "Content Requirements"
      expr: content_requirements
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Dispute Resolution Jurisdiction"
      expr: dispute_resolution_jurisdiction
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Contract"
      expr: COUNT(DISTINCT channel_contract_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Marketing Coop Amount"
      expr: SUM(marketing_coop_amount)
    - name: "Average Marketing Coop Amount"
      expr: AVG(marketing_coop_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Inventory Allocation business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_inventory_allocation`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Active Status"
      expr: active_status
    - name: "Allocated Units"
      expr: allocated_units
    - name: "Allocation Reference Number"
      expr: allocation_reference_number
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Allotment Type"
      expr: allotment_type
    - name: "Applied By User"
      expr: applied_by_user
    - name: "Available Units"
      expr: available_units
    - name: "Cancellation Count"
      expr: cancellation_count
    - name: "Channel Type"
      expr: channel_type
    - name: "Consumed Units"
      expr: consumed_units
    - name: "Created Date"
      expr: created_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Out"
      expr: days_out
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Inventory Allocation"
      expr: COUNT(DISTINCT channel_inventory_allocation_id)
    - name: "Total Channel Allocation Pct"
      expr: SUM(channel_allocation_pct)
    - name: "Average Channel Allocation Pct"
      expr: AVG(channel_allocation_pct)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee"
      expr: SUM(connectivity_fee)
    - name: "Average Connectivity Fee"
      expr: AVG(connectivity_fee)
    - name: "Total Overbooking Limit Pct"
      expr: SUM(overbooking_limit_pct)
    - name: "Average Overbooking Limit Pct"
      expr: AVG(overbooking_limit_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_negotiated_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Negotiated Rate business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_negotiated_rate`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Consortia Code"
      expr: consortia_code
    - name: "Consortia Name"
      expr: consortia_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Code"
      expr: crs_rate_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Gds Loading Status"
      expr: gds_loading_status
    - name: "Is Last Room Availability"
      expr: is_last_room_availability
    - name: "Is Rate Parity Required"
      expr: is_rate_parity_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Negotiated Rate"
      expr: COUNT(DISTINCT channel_negotiated_rate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_channel_rate_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Rate Plan business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`channel_rate_plan`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Approved By"
      expr: approved_by
    - name: "Booking Window End Date"
      expr: booking_window_end_date
    - name: "Booking Window Start Date"
      expr: booking_window_start_date
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Rate Plan Status"
      expr: channel_rate_plan_status
    - name: "Close Out Days"
      expr: close_out_days
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Of Week Applicable"
      expr: days_of_week_applicable
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Is Package Rate"
      expr: is_package_rate
    - name: "Is Rate Parity Applicable"
      expr: is_rate_parity_applicable
    - name: "Is Refundable"
      expr: is_refundable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Rate Plan"
      expr: COUNT(DISTINCT channel_rate_plan_id)
    - name: "Total Base Rate Amount"
      expr: SUM(base_rate_amount)
    - name: "Average Base Rate Amount"
      expr: AVG(base_rate_amount)
    - name: "Total Channel Rate Amount"
      expr: SUM(channel_rate_amount)
    - name: "Average Channel Rate Amount"
      expr: AVG(channel_rate_amount)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Rate Adjustment Value"
      expr: SUM(rate_adjustment_value)
    - name: "Average Rate Adjustment Value"
      expr: AVG(rate_adjustment_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_commission_accrual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission Accrual business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`commission_accrual`"
  dimensions:
    - name: "Accrual Date"
      expr: accrual_date
    - name: "Accrual Status"
      expr: accrual_status
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Commission Type"
      expr: commission_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Notes"
      expr: dispute_notes
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Is Commissionable"
      expr: is_commissionable
    - name: "Local Currency Code"
      expr: local_currency_code
    - name: "Market Segment Code"
      expr: market_segment_code
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Due Date"
      expr: payment_due_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commission Accrual"
      expr: COUNT(DISTINCT commission_accrual_id)
    - name: "Total Adr"
      expr: SUM(adr)
    - name: "Average Adr"
      expr: AVG(adr)
    - name: "Total Commission Amount Base"
      expr: SUM(commission_amount_base)
    - name: "Average Commission Amount Base"
      expr: AVG(commission_amount_base)
    - name: "Total Commission Amount Local"
      expr: SUM(commission_amount_local)
    - name: "Average Commission Amount Local"
      expr: AVG(commission_amount_local)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Connectivity Fee Amount"
      expr: SUM(connectivity_fee_amount)
    - name: "Average Connectivity Fee Amount"
      expr: AVG(connectivity_fee_amount)
    - name: "Total Fx Rate"
      expr: SUM(fx_rate)
    - name: "Average Fx Rate"
      expr: AVG(fx_rate)
    - name: "Total Gross Booking Value"
      expr: SUM(gross_booking_value)
    - name: "Average Gross Booking Value"
      expr: AVG(gross_booking_value)
    - name: "Total Total Cost Of Acquisition"
      expr: SUM(total_cost_of_acquisition)
    - name: "Average Total Cost Of Acquisition"
      expr: AVG(total_cost_of_acquisition)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_commission_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission Schedule business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`commission_schedule`"
  dimensions:
    - name: "Applies To Cancellations"
      expr: applies_to_cancellations
    - name: "Applies To No Shows"
      expr: applies_to_no_shows
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Accrual Enabled"
      expr: auto_accrual_enabled
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Booking Window Max Days"
      expr: booking_window_max_days
    - name: "Booking Window Min Days"
      expr: booking_window_min_days
    - name: "Commission Basis"
      expr: commission_basis
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Fee Currency Code"
      expr: fee_currency_code
    - name: "Fee Structure"
      expr: fee_structure
    - name: "Fee Type"
      expr: fee_type
    - name: "Gl Account Code"
      expr: gl_account_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Commission Schedule"
      expr: COUNT(DISTINCT commission_schedule_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Flat Fee Amount"
      expr: SUM(flat_fee_amount)
    - name: "Average Flat Fee Amount"
      expr: AVG(flat_fee_amount)
    - name: "Total Max Commission Amount"
      expr: SUM(max_commission_amount)
    - name: "Average Max Commission Amount"
      expr: AVG(max_commission_amount)
    - name: "Total Min Commission Amount"
      expr: SUM(min_commission_amount)
    - name: "Average Min Commission Amount"
      expr: AVG(min_commission_amount)
    - name: "Total Tier 1 Rate Pct"
      expr: SUM(tier_1_rate_pct)
    - name: "Average Tier 1 Rate Pct"
      expr: AVG(tier_1_rate_pct)
    - name: "Total Tier 1 Threshold"
      expr: SUM(tier_1_threshold)
    - name: "Average Tier 1 Threshold"
      expr: AVG(tier_1_threshold)
    - name: "Total Tier 2 Rate Pct"
      expr: SUM(tier_2_rate_pct)
    - name: "Average Tier 2 Rate Pct"
      expr: AVG(tier_2_rate_pct)
    - name: "Total Tier 2 Threshold"
      expr: SUM(tier_2_threshold)
    - name: "Average Tier 2 Threshold"
      expr: AVG(tier_2_threshold)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_connectivity_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Connectivity Fee business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`connectivity_fee`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Billing Frequency"
      expr: billing_frequency
    - name: "Booking Segment"
      expr: booking_segment
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Fee Basis"
      expr: fee_basis
    - name: "Fee Currency"
      expr: fee_currency
    - name: "Fee Description"
      expr: fee_description
    - name: "Fee Reference Number"
      expr: fee_reference_number
    - name: "Fee Status"
      expr: fee_status
    - name: "Fee Type"
      expr: fee_type
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Invoice Frequency"
      expr: invoice_frequency
    - name: "Is Negotiated Rate"
      expr: is_negotiated_rate
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Connectivity Fee"
      expr: COUNT(DISTINCT connectivity_fee_id)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Maximum Fee Amount"
      expr: SUM(maximum_fee_amount)
    - name: "Average Maximum Fee Amount"
      expr: AVG(maximum_fee_amount)
    - name: "Total Minimum Fee Amount"
      expr: SUM(minimum_fee_amount)
    - name: "Average Minimum Fee Amount"
      expr: AVG(minimum_fee_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_crs_channel_mapping`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crs Channel Mapping business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`crs_channel_mapping`"
  dimensions:
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Channel Contract Reference"
      expr: channel_contract_reference
    - name: "Channel Property Code"
      expr: channel_property_code
    - name: "Channel Type"
      expr: channel_type
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Content Sync Enabled"
      expr: content_sync_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Property Code"
      expr: crs_property_code
    - name: "Crs Rate Plan Code"
      expr: crs_rate_plan_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Guarantee Policy Code"
      expr: guarantee_policy_code
    - name: "Inventory Allocation Type"
      expr: inventory_allocation_type
    - name: "Is Mobile Optimized"
      expr: is_mobile_optimized
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crs Channel Mapping"
      expr: COUNT(DISTINCT crs_channel_mapping_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Rate Offset Value"
      expr: SUM(rate_offset_value)
    - name: "Average Rate Offset Value"
      expr: AVG(rate_offset_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_gds_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gds Connection business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`gds_connection`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Availability Sync Method"
      expr: availability_sync_method
    - name: "Chain Code"
      expr: chain_code
    - name: "Connection Status"
      expr: connection_status
    - name: "Connectivity Type"
      expr: connectivity_type
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Corporate Rate Enabled"
      expr: corporate_rate_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crs Interface Code"
      expr: crs_interface_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Display Priority"
      expr: display_priority
    - name: "Gds Name"
      expr: gds_name
    - name: "Gds Network Code"
      expr: gds_network_code
    - name: "Gds Tier"
      expr: gds_tier
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gds Connection"
      expr: COUNT(DISTINCT gds_connection_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Connectivity Fee Monthly Usd"
      expr: SUM(connectivity_fee_monthly_usd)
    - name: "Average Connectivity Fee Monthly Usd"
      expr: AVG(connectivity_fee_monthly_usd)
    - name: "Total Segment Fee Usd"
      expr: SUM(segment_fee_usd)
    - name: "Average Segment Fee Usd"
      expr: AVG(segment_fee_usd)
    - name: "Total Uptime Sla Pct"
      expr: SUM(uptime_sla_pct)
    - name: "Average Uptime Sla Pct"
      expr: AVG(uptime_sla_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory Allocation business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`inventory_allocation`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inventory Allocation"
      expr: COUNT(DISTINCT inventory_allocation_id)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_metasearch_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metasearch Listing business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`metasearch_listing`"
  dimensions:
    - name: "Bid Strategy Type"
      expr: bid_strategy_type
    - name: "Booking Count"
      expr: booking_count
    - name: "Connectivity Type"
      expr: connectivity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Device Type"
      expr: device_type
    - name: "Direct Booking Url"
      expr: direct_booking_url
    - name: "Display Rank"
      expr: display_rank
    - name: "Effective From"
      expr: effective_from
    - name: "Effective To"
      expr: effective_to
    - name: "Is Direct Booking Eligible"
      expr: is_direct_booking_eligible
    - name: "Is Rate Parity Monitored"
      expr: is_rate_parity_monitored
    - name: "Last Bid Updated Timestamp"
      expr: last_bid_updated_timestamp
    - name: "Listing Reference Code"
      expr: listing_reference_code
    - name: "Listing Status"
      expr: listing_status
    - name: "Listing Type"
      expr: listing_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Metasearch Listing"
      expr: COUNT(DISTINCT metasearch_listing_id)
    - name: "Total Bid Amount"
      expr: SUM(bid_amount)
    - name: "Average Bid Amount"
      expr: AVG(bid_amount)
    - name: "Total Bid Multiplier"
      expr: SUM(bid_multiplier)
    - name: "Average Bid Multiplier"
      expr: AVG(bid_multiplier)
    - name: "Total Booking Revenue"
      expr: SUM(booking_revenue)
    - name: "Average Booking Revenue"
      expr: AVG(booking_revenue)
    - name: "Total Click Count"
      expr: SUM(click_count)
    - name: "Average Click Count"
      expr: AVG(click_count)
    - name: "Total Click Through Rate"
      expr: SUM(click_through_rate)
    - name: "Average Click Through Rate"
      expr: AVG(click_through_rate)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Cpa Actual"
      expr: SUM(cpa_actual)
    - name: "Average Cpa Actual"
      expr: AVG(cpa_actual)
    - name: "Total Cpc Actual"
      expr: SUM(cpc_actual)
    - name: "Average Cpc Actual"
      expr: AVG(cpc_actual)
    - name: "Total Daily Budget Cap"
      expr: SUM(daily_budget_cap)
    - name: "Average Daily Budget Cap"
      expr: AVG(daily_budget_cap)
    - name: "Total Impression Count"
      expr: SUM(impression_count)
    - name: "Average Impression Count"
      expr: AVG(impression_count)
    - name: "Total Monthly Budget Cap"
      expr: SUM(monthly_budget_cap)
    - name: "Average Monthly Budget Cap"
      expr: AVG(monthly_budget_cap)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_ota_campaign_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ota Campaign Participation business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`ota_campaign_participation`"
  dimensions:
    - name: "Actual Booking Volume"
      expr: actual_booking_volume
    - name: "Agreement Reference"
      expr: agreement_reference
    - name: "Campaign End Date"
      expr: campaign_end_date
    - name: "Campaign Start Date"
      expr: campaign_start_date
    - name: "Content Requirements"
      expr: content_requirements
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Participation Status"
      expr: participation_status
    - name: "Promotional Placement Type"
      expr: promotional_placement_type
    - name: "Target Booking Volume"
      expr: target_booking_volume
    - name: "Campaign End Date Month"
      expr: DATE_TRUNC('MONTH', campaign_end_date)
    - name: "Campaign Start Date Month"
      expr: DATE_TRUNC('MONTH', campaign_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ota Campaign Participation"
      expr: COUNT(DISTINCT ota_campaign_participation_id)
    - name: "Total Actual Revenue Amount"
      expr: SUM(actual_revenue_amount)
    - name: "Average Actual Revenue Amount"
      expr: AVG(actual_revenue_amount)
    - name: "Total Coop Marketing Budget"
      expr: SUM(coop_marketing_budget)
    - name: "Average Coop Marketing Budget"
      expr: AVG(coop_marketing_budget)
    - name: "Total Hotel Contribution Amount"
      expr: SUM(hotel_contribution_amount)
    - name: "Average Hotel Contribution Amount"
      expr: AVG(hotel_contribution_amount)
    - name: "Total Ota Coop Budget Amount"
      expr: SUM(ota_coop_budget_amount)
    - name: "Average Ota Coop Budget Amount"
      expr: AVG(ota_coop_budget_amount)
    - name: "Total Partner Contribution Amount"
      expr: SUM(partner_contribution_amount)
    - name: "Average Partner Contribution Amount"
      expr: AVG(partner_contribution_amount)
    - name: "Total Performance Bonus Earned"
      expr: SUM(performance_bonus_earned)
    - name: "Average Performance Bonus Earned"
      expr: AVG(performance_bonus_earned)
    - name: "Total Target Revenue Amount"
      expr: SUM(target_revenue_amount)
    - name: "Average Target Revenue Amount"
      expr: AVG(target_revenue_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_ota_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ota Partner business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`ota_partner`"
  dimensions:
    - name: "Affiliate Network"
      expr: affiliate_network
    - name: "Cancellation Policy Type"
      expr: cancellation_policy_type
    - name: "Channel Manager Platform"
      expr: channel_manager_platform
    - name: "Commission Model"
      expr: commission_model
    - name: "Connectivity Fee Frequency"
      expr: connectivity_fee_frequency
    - name: "Connectivity Protocol"
      expr: connectivity_protocol
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Agreement"
      expr: data_sharing_agreement
    - name: "Gdpr Data Processor"
      expr: gdpr_data_processor
    - name: "Gds Chain Code"
      expr: gds_chain_code
    - name: "Hq Country Code"
      expr: hq_country_code
    - name: "Inventory Allocation Model"
      expr: inventory_allocation_model
    - name: "Last Room Availability"
      expr: last_room_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ota Partner"
      expr: COUNT(DISTINCT ota_partner_id)
    - name: "Total Base Commission Rate Pct"
      expr: SUM(base_commission_rate_pct)
    - name: "Average Base Commission Rate Pct"
      expr: AVG(base_commission_rate_pct)
    - name: "Total Connectivity Fee Usd"
      expr: SUM(connectivity_fee_usd)
    - name: "Average Connectivity Fee Usd"
      expr: AVG(connectivity_fee_usd)
    - name: "Total Content Score"
      expr: SUM(content_score)
    - name: "Average Content Score"
      expr: AVG(content_score)
    - name: "Total Preferred Commission Rate Pct"
      expr: SUM(preferred_commission_rate_pct)
    - name: "Average Preferred Commission Rate Pct"
      expr: AVG(preferred_commission_rate_pct)
    - name: "Total Review Score"
      expr: SUM(review_score)
    - name: "Average Review Score"
      expr: AVG(review_score)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_package_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Rate business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`package_rate`"
  dimensions:
    - name: "Cancellation Policy Override"
      expr: cancellation_policy_override
    - name: "Created Date"
      expr: created_date
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Is Active"
      expr: is_active
    - name: "Last Rate Update Timestamp"
      expr: last_rate_update_timestamp
    - name: "Minimum Advance Booking"
      expr: minimum_advance_booking
    - name: "Modified Date"
      expr: modified_date
    - name: "Rate Loading Status"
      expr: rate_loading_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective From Date Month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Rate"
      expr: COUNT(DISTINCT package_rate_id)
    - name: "Total Channel Package Price"
      expr: SUM(channel_package_price)
    - name: "Average Channel Package Price"
      expr: AVG(channel_package_price)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_rate_parity_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Parity Audit business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`rate_parity_audit`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Audit Reference Number"
      expr: audit_reference_number
    - name: "Audit Status"
      expr: audit_status
    - name: "Audit Timestamp"
      expr: audit_timestamp
    - name: "Cancellation Policy Type"
      expr: cancellation_policy_type
    - name: "Channel Rate Url"
      expr: channel_rate_url
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Raised Date"
      expr: dispute_raised_date
    - name: "Dispute Reference Number"
      expr: dispute_reference_number
    - name: "Dispute Resolved Date"
      expr: dispute_resolved_date
    - name: "Is Parity Violation"
      expr: is_parity_violation
    - name: "Is Rate Inclusive"
      expr: is_rate_inclusive
    - name: "Los Nights"
      expr: los_nights
    - name: "Meal Plan Code"
      expr: meal_plan_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Parity Audit"
      expr: COUNT(DISTINCT rate_parity_audit_id)
    - name: "Total Contracted Parity Rate"
      expr: SUM(contracted_parity_rate)
    - name: "Average Contracted Parity Rate"
      expr: AVG(contracted_parity_rate)
    - name: "Total Direct Rate"
      expr: SUM(direct_rate)
    - name: "Average Direct Rate"
      expr: AVG(direct_rate)
    - name: "Total Observed Rate"
      expr: SUM(observed_rate)
    - name: "Average Observed Rate"
      expr: AVG(observed_rate)
    - name: "Total Rate Variance"
      expr: SUM(rate_variance)
    - name: "Average Rate Variance"
      expr: AVG(rate_variance)
    - name: "Total Rate Variance Pct"
      expr: SUM(rate_variance_pct)
    - name: "Average Rate Variance Pct"
      expr: AVG(rate_variance_pct)
    - name: "Total Tolerance Threshold Pct"
      expr: SUM(tolerance_threshold_pct)
    - name: "Average Tolerance Threshold Pct"
      expr: AVG(tolerance_threshold_pct)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_stop_sell`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stop Sell business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`stop_sell`"
  dimensions:
    - name: "Action Type"
      expr: action_type
    - name: "Applied By User"
      expr: applied_by_user
    - name: "Approval Required"
      expr: approval_required
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Manager Reference"
      expr: channel_manager_reference
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Out"
      expr: days_out
    - name: "Effective Timestamp"
      expr: effective_timestamp
    - name: "Is All Channels"
      expr: is_all_channels
    - name: "Is All Room Types"
      expr: is_all_room_types
    - name: "Is System Generated"
      expr: is_system_generated
    - name: "Lift Reason Code"
      expr: lift_reason_code
    - name: "Lift Timestamp"
      expr: lift_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Stop Sell"
      expr: COUNT(DISTINCT stop_sell_id)
    - name: "Total Adr At Apply"
      expr: SUM(adr_at_apply)
    - name: "Average Adr At Apply"
      expr: AVG(adr_at_apply)
    - name: "Total Occupancy At Apply"
      expr: SUM(occupancy_at_apply)
    - name: "Average Occupancy At Apply"
      expr: AVG(occupancy_at_apply)
    - name: "Total Revpar At Apply"
      expr: SUM(revpar_at_apply)
    - name: "Average Revpar At Apply"
      expr: AVG(revpar_at_apply)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`channel_wholesale_allotment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wholesale Allotment business metrics"
  source: "`travel_hospitality_ecm`.`channel`.`wholesale_allotment`"
  dimensions:
    - name: "Allotment Reference Number"
      expr: allotment_reference_number
    - name: "Allotment Status"
      expr: allotment_status
    - name: "Allotment Type"
      expr: allotment_type
    - name: "Booking Deadline Date"
      expr: booking_deadline_date
    - name: "Cancellation Count"
      expr: cancellation_count
    - name: "Connectivity Type"
      expr: connectivity_type
    - name: "Consumed Units"
      expr: consumed_units
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiry Date"
      expr: contract_expiry_date
    - name: "Contracted Allotment Size"
      expr: contracted_allotment_size
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Daily Allotment Size"
      expr: daily_allotment_size
    - name: "Is Closed To Arrival"
      expr: is_closed_to_arrival
    - name: "Is Stop Sell"
      expr: is_stop_sell
    - name: "Last Room Availability"
      expr: last_room_availability
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wholesale Allotment"
      expr: COUNT(DISTINCT wholesale_allotment_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Contracted Net Rate"
      expr: SUM(contracted_net_rate)
    - name: "Average Contracted Net Rate"
      expr: AVG(contracted_net_rate)
    - name: "Total Rack Rate"
      expr: SUM(rack_rate)
    - name: "Average Rack Rate"
      expr: AVG(rack_rate)
    - name: "Total Wash Factor Pct"
      expr: SUM(wash_factor_pct)
    - name: "Average Wash Factor Pct"
      expr: AVG(wash_factor_pct)
$$;