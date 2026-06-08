-- Metric views for domain: loyalty | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:56:16

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accrual Rule business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`accrual_rule`"
  dimensions:
    - name: "Applicable Brands"
      expr: applicable_brands
    - name: "Applicable Property Ids"
      expr: applicable_property_ids
    - name: "Applicable Regions"
      expr: applicable_regions
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Booking Channel Restriction"
      expr: booking_channel_restriction
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Day Of Week Restriction"
      expr: day_of_week_restriction
    - name: "Earning Basis"
      expr: earning_basis
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Rate Codes"
      expr: eligible_rate_codes
    - name: "Excluded Rate Codes"
      expr: excluded_rate_codes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Accrual Rule"
      expr: COUNT(DISTINCT accrual_rule_id)
    - name: "Total Estimated Annual Points Volume"
      expr: SUM(estimated_annual_points_volume)
    - name: "Average Estimated Annual Points Volume"
      expr: AVG(estimated_annual_points_volume)
    - name: "Total Minimum Transaction Amount"
      expr: SUM(minimum_transaction_amount)
    - name: "Average Minimum Transaction Amount"
      expr: AVG(minimum_transaction_amount)
    - name: "Total Points Per Currency Unit"
      expr: SUM(points_per_currency_unit)
    - name: "Average Points Per Currency Unit"
      expr: AVG(points_per_currency_unit)
    - name: "Total Segment Multiplier"
      expr: SUM(segment_multiplier)
    - name: "Average Segment Multiplier"
      expr: AVG(segment_multiplier)
    - name: "Total Tier Multiplier"
      expr: SUM(tier_multiplier)
    - name: "Average Tier Multiplier"
      expr: AVG(tier_multiplier)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_benefit_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Entitlement business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`benefit_entitlement`"
  dimensions:
    - name: "Advance Booking Required Days"
      expr: advance_booking_required_days
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Benefit Description"
      expr: benefit_description
    - name: "Benefit Name"
      expr: benefit_name
    - name: "Benefit Type Code"
      expr: benefit_type_code
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Combinable Flag"
      expr: combinable_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligible Property List"
      expr: eligible_property_list
    - name: "Entitlement Source"
      expr: entitlement_source
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Granted Timestamp"
      expr: granted_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Entitlement"
      expr: COUNT(DISTINCT benefit_entitlement_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_benefit_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Benefit Redemption business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`benefit_redemption`"
  dimensions:
    - name: "Acknowledgment Method"
      expr: acknowledgment_method
    - name: "Acknowledgment Timestamp"
      expr: acknowledgment_timestamp
    - name: "Actual Delivery Minutes"
      expr: actual_delivery_minutes
    - name: "Benefit Status"
      expr: benefit_status
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Location"
      expr: delivery_location
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Entitlement Date"
      expr: entitlement_date
    - name: "Entitlement Source"
      expr: entitlement_source
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Exception Notes"
      expr: exception_notes
    - name: "Exception Reason Code"
      expr: exception_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Benefit Redemption"
      expr: COUNT(DISTINCT benefit_redemption_id)
    - name: "Total Cost To Property Amount"
      expr: SUM(cost_to_property_amount)
    - name: "Average Cost To Property Amount"
      expr: AVG(cost_to_property_amount)
    - name: "Total Monetary Value Amount"
      expr: SUM(monetary_value_amount)
    - name: "Average Monetary Value Amount"
      expr: AVG(monetary_value_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`certificate`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Certificate Number"
      expr: certificate_number
    - name: "Certificate Status"
      expr: certificate_status
    - name: "Certificate Type"
      expr: certificate_type
    - name: "Combinable Flag"
      expr: combinable_flag
    - name: "Complimentary Flag"
      expr: complimentary_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Eligible Property List"
      expr: eligible_property_list
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Issue Channel"
      expr: issue_channel
    - name: "Issue Date"
      expr: issue_date
    - name: "Issue Reason"
      expr: issue_reason
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Certificate"
      expr: COUNT(DISTINCT certificate_id)
    - name: "Total Face Value"
      expr: SUM(face_value)
    - name: "Average Face Value"
      expr: AVG(face_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_fraud_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fraud Alert business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`fraud_alert`"
  dimensions:
    - name: "Account Frozen Flag"
      expr: account_frozen_flag
    - name: "Account Frozen Timestamp"
      expr: account_frozen_timestamp
    - name: "Alert Number"
      expr: alert_number
    - name: "Alert Severity"
      expr: alert_severity
    - name: "Alert Status"
      expr: alert_status
    - name: "Alert Type"
      expr: alert_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Detection Method"
      expr: detection_method
    - name: "Detection Timestamp"
      expr: detection_timestamp
    - name: "False Positive Reason"
      expr: false_positive_reason
    - name: "Geolocation Country Code"
      expr: geolocation_country_code
    - name: "Investigation Assigned To"
      expr: investigation_assigned_to
    - name: "Investigation Notes"
      expr: investigation_notes
    - name: "Investigation Start Timestamp"
      expr: investigation_start_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fraud Alert"
      expr: COUNT(DISTINCT fraud_alert_id)
    - name: "Total Monetary Value Involved"
      expr: SUM(monetary_value_involved)
    - name: "Average Monetary Value Involved"
      expr: AVG(monetary_value_involved)
    - name: "Total Points Amount Involved"
      expr: SUM(points_amount_involved)
    - name: "Average Points Amount Involved"
      expr: AVG(points_amount_involved)
    - name: "Total Points Reversed Amount"
      expr: SUM(points_reversed_amount)
    - name: "Average Points Reversed Amount"
      expr: AVG(points_reversed_amount)
    - name: "Total Risk Score"
      expr: SUM(risk_score)
    - name: "Average Risk Score"
      expr: AVG(risk_score)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_loyalty_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty Enrollment business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`loyalty_enrollment`"
  dimensions:
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Device Type"
      expr: device_type
    - name: "Documentation Submitted Flag"
      expr: documentation_submitted_flag
    - name: "Email Consent Flag"
      expr: email_consent_flag
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Enrollment Timestamp"
      expr: enrollment_timestamp
    - name: "Initial Tier"
      expr: initial_tier
    - name: "Ip Address"
      expr: ip_address
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Match Expiry Date"
      expr: match_expiry_date
    - name: "Match Tier Granted"
      expr: match_tier_granted
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Loyalty Enrollment"
      expr: COUNT(DISTINCT loyalty_enrollment_id)
    - name: "Total Welcome Bonus Points"
      expr: SUM(welcome_bonus_points)
    - name: "Average Welcome Bonus Points"
      expr: AVG(welcome_bonus_points)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`member`"
  dimensions:
    - name: "Account Closure Date"
      expr: account_closure_date
    - name: "Account Closure Reason"
      expr: account_closure_reason
    - name: "Communication Opt In"
      expr: communication_opt_in
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Preference"
      expr: currency_preference
    - name: "Email Opt In"
      expr: email_opt_in
    - name: "Enrollment Channel"
      expr: enrollment_channel
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Stay Date"
      expr: last_stay_date
    - name: "Lifetime Nights"
      expr: lifetime_nights
    - name: "Lifetime Stays"
      expr: lifetime_stays
    - name: "Membership Number"
      expr: membership_number
    - name: "Membership Status"
      expr: membership_status
    - name: "Next Stay Date"
      expr: next_stay_date
    - name: "Nps Score"
      expr: nps_score
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member"
      expr: COUNT(DISTINCT member_id)
    - name: "Total Current Points Balance"
      expr: SUM(current_points_balance)
    - name: "Average Current Points Balance"
      expr: AVG(current_points_balance)
    - name: "Total Lifetime Points Earned"
      expr: SUM(lifetime_points_earned)
    - name: "Average Lifetime Points Earned"
      expr: AVG(lifetime_points_earned)
    - name: "Total Lifetime Revenue"
      expr: SUM(lifetime_revenue)
    - name: "Average Lifetime Revenue"
      expr: AVG(lifetime_revenue)
    - name: "Total Points Expired"
      expr: SUM(points_expired)
    - name: "Average Points Expired"
      expr: AVG(points_expired)
    - name: "Total Points Redeemed"
      expr: SUM(points_redeemed)
    - name: "Average Points Redeemed"
      expr: AVG(points_redeemed)
    - name: "Total Salt Score"
      expr: SUM(salt_score)
    - name: "Average Salt Score"
      expr: AVG(salt_score)
    - name: "Total Ytd Revenue"
      expr: SUM(ytd_revenue)
    - name: "Average Ytd Revenue"
      expr: AVG(ytd_revenue)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Preference business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`member_preference`"
  dimensions:
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Confirmed Date"
      expr: last_confirmed_date
    - name: "Last Observed Date"
      expr: last_observed_date
    - name: "Last Updated Date"
      expr: last_updated_date
    - name: "Notes"
      expr: notes
    - name: "Observation Count"
      expr: observation_count
    - name: "Override Flag"
      expr: override_flag
    - name: "Preference Category"
      expr: preference_category
    - name: "Preference Source"
      expr: preference_source
    - name: "Preference Status"
      expr: preference_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Property Restriction"
      expr: property_restriction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Preference"
      expr: COUNT(DISTINCT member_preference_id)
    - name: "Total Preference Value"
      expr: SUM(preference_value)
    - name: "Average Preference Value"
      expr: AVG(preference_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_member_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Member Segment business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`member_segment`"
  dimensions:
    - name: "Allow Overlap Flag"
      expr: allow_overlap_flag
    - name: "Brand Restriction"
      expr: brand_restriction
    - name: "Campaign Eligible Flag"
      expr: campaign_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Current Member Count"
      expr: current_member_count
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusion Criteria"
      expr: exclusion_criteria
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Inclusion Criteria"
      expr: inclusion_criteria
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Refresh Timestamp"
      expr: last_refresh_timestamp
    - name: "Maximum Nights"
      expr: maximum_nights
    - name: "Minimum Nights"
      expr: minimum_nights
    - name: "Minimum Stays"
      expr: minimum_stays
    - name: "Model Version"
      expr: model_version
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Member Segment"
      expr: COUNT(DISTINCT member_segment_id)
    - name: "Total Confidence Threshold"
      expr: SUM(confidence_threshold)
    - name: "Average Confidence Threshold"
      expr: AVG(confidence_threshold)
    - name: "Total Engagement Score Threshold"
      expr: SUM(engagement_score_threshold)
    - name: "Average Engagement Score Threshold"
      expr: AVG(engagement_score_threshold)
    - name: "Total Maximum Ltv"
      expr: SUM(maximum_ltv)
    - name: "Average Maximum Ltv"
      expr: AVG(maximum_ltv)
    - name: "Total Minimum Ltv"
      expr: SUM(minimum_ltv)
    - name: "Average Minimum Ltv"
      expr: AVG(minimum_ltv)
    - name: "Total Salt Score Threshold"
      expr: SUM(salt_score_threshold)
    - name: "Average Salt Score Threshold"
      expr: AVG(salt_score_threshold)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_package_purchase`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Package Purchase business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`package_purchase`"
  dimensions:
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Package Status"
      expr: package_status
    - name: "Points Redeemed"
      expr: points_redeemed
    - name: "Purchase Channel"
      expr: purchase_channel
    - name: "Purchase Date"
      expr: purchase_date
    - name: "Sessions Included"
      expr: sessions_included
    - name: "Sessions Used"
      expr: sessions_used
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Package Purchase"
      expr: COUNT(DISTINCT package_purchase_id)
    - name: "Total Purchase Price"
      expr: SUM(purchase_price)
    - name: "Average Purchase Price"
      expr: AVG(purchase_price)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_partner_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partner Program business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`partner_program`"
  dimensions:
    - name: "Api Authentication Method"
      expr: api_authentication_method
    - name: "Api Integration Endpoint"
      expr: api_integration_endpoint
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Sharing Consent Flag"
      expr: data_sharing_consent_flag
    - name: "Earn Eligibility Flag"
      expr: earn_eligibility_flag
    - name: "Last Sync Timestamp"
      expr: last_sync_timestamp
    - name: "Marketing Consent Flag"
      expr: marketing_consent_flag
    - name: "Maximum Transfer Amount"
      expr: maximum_transfer_amount
    - name: "Minimum Transfer Amount"
      expr: minimum_transfer_amount
    - name: "Partner Code"
      expr: partner_code
    - name: "Partner Contact Email"
      expr: partner_contact_email
    - name: "Partner Contact Name"
      expr: partner_contact_name
    - name: "Partner Contact Phone"
      expr: partner_contact_phone
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partner Program"
      expr: COUNT(DISTINCT partner_program_id)
    - name: "Total Hotel To Partner Ratio"
      expr: SUM(hotel_to_partner_ratio)
    - name: "Average Hotel To Partner Ratio"
      expr: AVG(hotel_to_partner_ratio)
    - name: "Total Partner To Hotel Ratio"
      expr: SUM(partner_to_hotel_ratio)
    - name: "Average Partner To Hotel Ratio"
      expr: AVG(partner_to_hotel_ratio)
    - name: "Total Revenue Share Percentage"
      expr: SUM(revenue_share_percentage)
    - name: "Average Revenue Share Percentage"
      expr: AVG(revenue_share_percentage)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_points_ledger`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points Ledger business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`points_ledger`"
  dimensions:
    - name: "Activity Date"
      expr: activity_date
    - name: "Adjustment Notes"
      expr: adjustment_notes
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Base Currency Code"
      expr: base_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Qualifying"
      expr: is_qualifying
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Partner Confirmation Number"
      expr: partner_confirmation_number
    - name: "Partner Program Code"
      expr: partner_program_code
    - name: "Posting Date"
      expr: posting_date
    - name: "Source Activity Type"
      expr: source_activity_type
    - name: "Source System"
      expr: source_system
    - name: "Tier At Transaction"
      expr: tier_at_transaction
    - name: "Transaction Number"
      expr: transaction_number
    - name: "Transaction Status"
      expr: transaction_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Points Ledger"
      expr: COUNT(DISTINCT points_ledger_id)
    - name: "Total Balance After Transaction"
      expr: SUM(balance_after_transaction)
    - name: "Average Balance After Transaction"
      expr: AVG(balance_after_transaction)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Points Amount"
      expr: SUM(points_amount)
    - name: "Average Points Amount"
      expr: AVG(points_amount)
    - name: "Total Transfer Fee Amount"
      expr: SUM(transfer_fee_amount)
    - name: "Average Transfer Fee Amount"
      expr: AVG(transfer_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_points_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Points Transfer business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`points_transfer`"
  dimensions:
    - name: "Api Transaction Reference"
      expr: api_transaction_reference
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Failure Reason Code"
      expr: failure_reason_code
    - name: "Failure Reason Description"
      expr: failure_reason_description
    - name: "Member Tier At Transfer"
      expr: member_tier_at_transfer
    - name: "Notes"
      expr: notes
    - name: "Partner Confirmation Number"
      expr: partner_confirmation_number
    - name: "Partner Member Account Number"
      expr: partner_member_account_number
    - name: "Processing Start Timestamp"
      expr: processing_start_timestamp
    - name: "Processing Time Seconds"
      expr: processing_time_seconds
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Request Channel"
      expr: request_channel
    - name: "Request Source Ip Address"
      expr: request_source_ip_address
    - name: "Request Timestamp"
      expr: request_timestamp
    - name: "Reversal Flag"
      expr: reversal_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Points Transfer"
      expr: COUNT(DISTINCT points_transfer_id)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Hotel Points Amount"
      expr: SUM(hotel_points_amount)
    - name: "Average Hotel Points Amount"
      expr: AVG(hotel_points_amount)
    - name: "Total Partner Currency Amount"
      expr: SUM(partner_currency_amount)
    - name: "Average Partner Currency Amount"
      expr: AVG(partner_currency_amount)
    - name: "Total Promotional Bonus Points"
      expr: SUM(promotional_bonus_points)
    - name: "Average Promotional Bonus Points"
      expr: AVG(promotional_bonus_points)
    - name: "Total Transfer Fee Amount"
      expr: SUM(transfer_fee_amount)
    - name: "Average Transfer Fee Amount"
      expr: AVG(transfer_fee_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_program_config`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Config business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`program_config`"
  dimensions:
    - name: "Api Integration Enabled Flag"
      expr: api_integration_enabled_flag
    - name: "Cash Plus Points Enabled Flag"
      expr: cash_plus_points_enabled_flag
    - name: "Ccpa Compliant Flag"
      expr: ccpa_compliant_flag
    - name: "Configuration Effective Date"
      expr: configuration_effective_date
    - name: "Configuration Expiry Date"
      expr: configuration_expiry_date
    - name: "Contact Center Email"
      expr: contact_center_email
    - name: "Contact Center Phone"
      expr: contact_center_phone
    - name: "Conversion Currency Code"
      expr: conversion_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Name"
      expr: currency_name
    - name: "Data Retention Policy Months"
      expr: data_retention_policy_months
    - name: "Family Pooling Enabled Flag"
      expr: family_pooling_enabled_flag
    - name: "Gdpr Compliant Flag"
      expr: gdpr_compliant_flag
    - name: "Gifting Enabled Flag"
      expr: gifting_enabled_flag
    - name: "Inactivity Period Months"
      expr: inactivity_period_months
    - name: "Liability Estimation Method"
      expr: liability_estimation_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Config"
      expr: COUNT(DISTINCT program_config_id)
    - name: "Total Breakage Assumption Rate"
      expr: SUM(breakage_assumption_rate)
    - name: "Average Breakage Assumption Rate"
      expr: AVG(breakage_assumption_rate)
    - name: "Total Points To Currency Conversion Rate"
      expr: SUM(points_to_currency_conversion_rate)
    - name: "Average Points To Currency Conversion Rate"
      expr: AVG(points_to_currency_conversion_rate)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Award Fulfillment Date"
      expr: award_fulfillment_date
    - name: "Bonus Nights Credit"
      expr: bonus_nights_credit
    - name: "Bonus Points Amount"
      expr: bonus_points_amount
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Marketing Channel"
      expr: marketing_channel
    - name: "Minimum Nights"
      expr: minimum_nights
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Promotion Name"
      expr: promotion_name
    - name: "Promotion Status"
      expr: promotion_status
    - name: "Promotion Type"
      expr: promotion_type
    - name: "Qualifying Criteria Description"
      expr: qualifying_criteria_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion"
      expr: COUNT(DISTINCT promotion_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Budget Cap Amount"
      expr: SUM(budget_cap_amount)
    - name: "Average Budget Cap Amount"
      expr: AVG(budget_cap_amount)
    - name: "Total Budget Consumed Amount"
      expr: SUM(budget_consumed_amount)
    - name: "Average Budget Consumed Amount"
      expr: AVG(budget_consumed_amount)
    - name: "Total Minimum Spend Amount"
      expr: SUM(minimum_spend_amount)
    - name: "Average Minimum Spend Amount"
      expr: AVG(minimum_spend_amount)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Distribution business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion_distribution`"
  dimensions:
    - name: "Actual Bookings"
      expr: actual_bookings
    - name: "Channel Priority Rank"
      expr: channel_priority_rank
    - name: "Created Date"
      expr: created_date
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Performance Target Bookings"
      expr: performance_target_bookings
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Distribution"
      expr: COUNT(DISTINCT promotion_distribution_id)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Budget Consumed Amount"
      expr: SUM(budget_consumed_amount)
    - name: "Average Budget Consumed Amount"
      expr: AVG(budget_consumed_amount)
    - name: "Total Promotion Rate Multiplier"
      expr: SUM(promotion_rate_multiplier)
    - name: "Average Promotion Rate Multiplier"
      expr: AVG(promotion_rate_multiplier)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Enrollment business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion_enrollment`"
  dimensions:
    - name: "Award Date"
      expr: award_date
    - name: "Award Reference Number"
      expr: award_reference_number
    - name: "Award Timestamp"
      expr: award_timestamp
    - name: "Bonus Awarded Flag"
      expr: bonus_awarded_flag
    - name: "Bonus Currency Code"
      expr: bonus_currency_code
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Communication Sent Flag"
      expr: communication_sent_flag
    - name: "Communication Sent Timestamp"
      expr: communication_sent_timestamp
    - name: "Completion Date"
      expr: completion_date
    - name: "Completion Timestamp"
      expr: completion_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Enrollment Date"
      expr: enrollment_date
    - name: "Enrollment Method"
      expr: enrollment_method
    - name: "Enrollment Number"
      expr: enrollment_number
    - name: "Enrollment Status"
      expr: enrollment_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Enrollment"
      expr: COUNT(DISTINCT promotion_enrollment_id)
    - name: "Total Bonus Amount"
      expr: SUM(bonus_amount)
    - name: "Average Bonus Amount"
      expr: AVG(bonus_amount)
    - name: "Total Bonus Points"
      expr: SUM(bonus_points)
    - name: "Average Bonus Points"
      expr: AVG(bonus_points)
    - name: "Total Progress Percentage"
      expr: SUM(progress_percentage)
    - name: "Average Progress Percentage"
      expr: AVG(progress_percentage)
    - name: "Total Progress Value"
      expr: SUM(progress_value)
    - name: "Average Progress Value"
      expr: AVG(progress_value)
    - name: "Total Qualifying Threshold"
      expr: SUM(qualifying_threshold)
    - name: "Average Qualifying Threshold"
      expr: AVG(qualifying_threshold)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_promotion_treatment_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Treatment Rule business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`promotion_treatment_rule`"
  dimensions:
    - name: "Created Date"
      expr: created_date
    - name: "Current Redemptions"
      expr: current_redemptions
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Maximum Redemptions"
      expr: maximum_redemptions
    - name: "Rule Status"
      expr: rule_status
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Treatment Rule"
      expr: COUNT(DISTINCT promotion_treatment_rule_id)
    - name: "Total Bonus Points Multiplier"
      expr: SUM(bonus_points_multiplier)
    - name: "Average Bonus Points Multiplier"
      expr: AVG(bonus_points_multiplier)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Minimum Spend"
      expr: SUM(minimum_spend)
    - name: "Average Minimum Spend"
      expr: AVG(minimum_spend)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`redemption`"
  dimensions:
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Confirmation Timestamp"
      expr: confirmation_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fulfillment Channel"
      expr: fulfillment_channel
    - name: "Fulfillment Date"
      expr: fulfillment_date
    - name: "Fulfillment Timestamp"
      expr: fulfillment_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Partner Code"
      expr: partner_code
    - name: "Property Code"
      expr: property_code
    - name: "Redemption Number"
      expr: redemption_number
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Redemption Type"
      expr: redemption_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Redemption"
      expr: COUNT(DISTINCT redemption_id)
    - name: "Total Cash Amount"
      expr: SUM(cash_amount)
    - name: "Average Cash Amount"
      expr: AVG(cash_amount)
    - name: "Total Monetary Equivalent Value"
      expr: SUM(monetary_equivalent_value)
    - name: "Average Monetary Equivalent Value"
      expr: AVG(monetary_equivalent_value)
    - name: "Total Points Redeemed"
      expr: SUM(points_redeemed)
    - name: "Average Points Redeemed"
      expr: AVG(points_redeemed)
    - name: "Total Points Refunded"
      expr: SUM(points_refunded)
    - name: "Average Points Refunded"
      expr: AVG(points_refunded)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_redemption_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Redemption Rule business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`redemption_rule`"
  dimensions:
    - name: "Advance Booking Days"
      expr: advance_booking_days
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Combinable With Promotions"
      expr: combinable_with_promotions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Property Codes"
      expr: eligible_property_codes
    - name: "Eligible Rate Codes"
      expr: eligible_rate_codes
    - name: "Excluded Property Codes"
      expr: excluded_property_codes
    - name: "Excluded Rate Codes"
      expr: excluded_rate_codes
    - name: "Lra Applicable"
      expr: lra_applicable
    - name: "Maximum Los"
      expr: maximum_los
    - name: "Minimum Los"
      expr: minimum_los
    - name: "Modified By"
      expr: modified_by
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Redemption Rule"
      expr: COUNT(DISTINCT redemption_rule_id)
    - name: "Total Maximum Earn Per Stay"
      expr: SUM(maximum_earn_per_stay)
    - name: "Average Maximum Earn Per Stay"
      expr: AVG(maximum_earn_per_stay)
    - name: "Total Maximum Redemption Per Transaction"
      expr: SUM(maximum_redemption_per_transaction)
    - name: "Average Maximum Redemption Per Transaction"
      expr: AVG(maximum_redemption_per_transaction)
    - name: "Total Minimum Points Balance"
      expr: SUM(minimum_points_balance)
    - name: "Average Minimum Points Balance"
      expr: AVG(minimum_points_balance)
    - name: "Total Points Rate"
      expr: SUM(points_rate)
    - name: "Average Points Rate"
      expr: AVG(points_rate)
    - name: "Total Tier Multiplier Base"
      expr: SUM(tier_multiplier_base)
    - name: "Average Tier Multiplier Base"
      expr: AVG(tier_multiplier_base)
    - name: "Total Tier Multiplier Gold"
      expr: SUM(tier_multiplier_gold)
    - name: "Average Tier Multiplier Gold"
      expr: AVG(tier_multiplier_gold)
    - name: "Total Tier Multiplier Platinum"
      expr: SUM(tier_multiplier_platinum)
    - name: "Average Tier Multiplier Platinum"
      expr: AVG(tier_multiplier_platinum)
    - name: "Total Tier Multiplier Silver"
      expr: SUM(tier_multiplier_silver)
    - name: "Average Tier Multiplier Silver"
      expr: AVG(tier_multiplier_silver)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_reward_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reward Catalog business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`reward_catalog`"
  dimensions:
    - name: "Availability Type"
      expr: availability_type
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Tier Base"
      expr: eligible_tier_base
    - name: "Eligible Tier Gold"
      expr: eligible_tier_gold
    - name: "Eligible Tier Platinum"
      expr: eligible_tier_platinum
    - name: "Eligible Tier Silver"
      expr: eligible_tier_silver
    - name: "Featured Flag"
      expr: featured_flag
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Image Url"
      expr: image_url
    - name: "Inventory Count"
      expr: inventory_count
    - name: "Inventory Threshold"
      expr: inventory_threshold
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reward Catalog"
      expr: COUNT(DISTINCT reward_catalog_id)
    - name: "Total Monetary Value"
      expr: SUM(monetary_value)
    - name: "Average Monetary Value"
      expr: AVG(monetary_value)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_tier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`tier`"
  dimensions:
    - name: "Bonus Points On Enrollment"
      expr: bonus_points_on_enrollment
    - name: "Breakfast Benefit Flag"
      expr: breakfast_benefit_flag
    - name: "Color Code"
      expr: color_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dedicated Support Flag"
      expr: dedicated_support_flag
    - name: "Display Order"
      expr: display_order
    - name: "Downgrade Grace Period Months"
      expr: downgrade_grace_period_months
    - name: "Early Checkin Hours"
      expr: early_checkin_hours
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Guaranteed Availability Flag"
      expr: guaranteed_availability_flag
    - name: "Icon Url"
      expr: icon_url
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Late Checkout Hours"
      expr: late_checkout_hours
    - name: "Lounge Access Flag"
      expr: lounge_access_flag
    - name: "Priority Reservation Flag"
      expr: priority_reservation_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier"
      expr: COUNT(DISTINCT tier_id)
    - name: "Total Points Earning Multiplier"
      expr: SUM(points_earning_multiplier)
    - name: "Average Points Earning Multiplier"
      expr: AVG(points_earning_multiplier)
    - name: "Total Qualification Spend Threshold"
      expr: SUM(qualification_spend_threshold)
    - name: "Average Qualification Spend Threshold"
      expr: AVG(qualification_spend_threshold)
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`loyalty_tier_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tier History business metrics"
  source: "`travel_hospitality_ecm`.`loyalty`.`tier_history`"
  dimensions:
    - name: "Change Number"
      expr: change_number
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Change Reason Description"
      expr: change_reason_description
    - name: "Change Timestamp"
      expr: change_timestamp
    - name: "Change Type"
      expr: change_type
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Current Tier Flag"
      expr: is_current_tier_flag
    - name: "Notification Sent Flag"
      expr: notification_sent_flag
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
    - name: "Override Approval Code"
      expr: override_approval_code
    - name: "Override Justification"
      expr: override_justification
    - name: "Previous Tier Code"
      expr: previous_tier_code
    - name: "Qualification Basis"
      expr: qualification_basis
    - name: "Qualifying Nights Achieved"
      expr: qualifying_nights_achieved
    - name: "Qualifying Period End Date"
      expr: qualifying_period_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tier History"
      expr: COUNT(DISTINCT tier_history_id)
    - name: "Total Bonus Points Awarded"
      expr: SUM(bonus_points_awarded)
    - name: "Average Bonus Points Awarded"
      expr: AVG(bonus_points_awarded)
    - name: "Total Qualifying Points Achieved"
      expr: SUM(qualifying_points_achieved)
    - name: "Average Qualifying Points Achieved"
      expr: AVG(qualifying_points_achieved)
    - name: "Total Qualifying Spend Amount"
      expr: SUM(qualifying_spend_amount)
    - name: "Average Qualifying Spend Amount"
      expr: AVG(qualifying_spend_amount)
    - name: "Total Threshold Points Required"
      expr: SUM(threshold_points_required)
    - name: "Average Threshold Points Required"
      expr: AVG(threshold_points_required)
    - name: "Total Threshold Spend Required"
      expr: SUM(threshold_spend_required)
    - name: "Average Threshold Spend Required"
      expr: AVG(threshold_spend_required)
$$;