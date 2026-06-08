-- Metric views for domain: guest | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking guest acquisition, loyalty enrollment, and profile quality"
  source: "`travel_hospitality_ecm`.`guest`.`profile`"
  dimensions:
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (individual, corporate, group, etc.)"
    - name: "vip_status"
      expr: vip_status
      comment: "VIP status designation"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty program tier"
    - name: "profile_status"
      expr: profile_status
      comment: "Active, inactive, or merged profile status"
    - name: "country_of_residence"
      expr: country_of_residence_code
      comment: "Guest country of residence ISO code"
    - name: "preferred_language"
      expr: preferred_language_code
      comment: "Guest preferred language code"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in
      comment: "Whether guest has opted into marketing communications"
    - name: "email_opt_in_flag"
      expr: email_opt_in
      comment: "Whether guest has opted into email communications"
    - name: "loyalty_enrollment_year"
      expr: YEAR(loyalty_enrollment_date)
      comment: "Year guest enrolled in loyalty program"
    - name: "loyalty_enrollment_month"
      expr: DATE_TRUNC('MONTH', loyalty_enrollment_date)
      comment: "Month guest enrolled in loyalty program"
    - name: "profile_creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year profile was created"
    - name: "profile_creation_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month profile was created"
  measures:
    - name: "total_guest_profiles"
      expr: COUNT(profile_id)
      comment: "Total number of guest profiles"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guest profiles"
    - name: "loyalty_member_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END)
      comment: "Number of guests enrolled in loyalty program"
    - name: "vip_guest_count"
      expr: COUNT(DISTINCT CASE WHEN vip_status IS NOT NULL AND vip_status != '' THEN profile_id END)
      comment: "Number of guests with VIP status"
    - name: "marketing_opt_in_count"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Number of guests opted into marketing"
    - name: "email_opt_in_count"
      expr: COUNT(DISTINCT CASE WHEN email_opt_in = TRUE THEN profile_id END)
      comment: "Number of guests opted into email"
    - name: "loyalty_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_member_number IS NOT NULL THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests enrolled in loyalty program"
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests opted into marketing communications"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_stay_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest stay performance metrics tracking revenue, occupancy, satisfaction, and loyalty behavior"
  source: "`travel_hospitality_ecm`.`guest`.`stay_history`"
  dimensions:
    - name: "stay_status"
      expr: stay_status
      comment: "Status of the stay (checked-in, checked-out, no-show, cancelled)"
    - name: "market_segment"
      expr: market_segment_code
      comment: "Market segment code for the stay"
    - name: "booking_channel"
      expr: booking_channel_code
      comment: "Channel through which booking was made"
    - name: "rate_plan"
      expr: rate_plan_code
      comment: "Rate plan code applied to the stay"
    - name: "room_type"
      expr: room_type_code
      comment: "Type of room booked"
    - name: "guest_type"
      expr: guest_type
      comment: "Type of guest (transient, group, contract)"
    - name: "loyalty_tier_at_stay"
      expr: loyalty_tier_at_stay
      comment: "Guest loyalty tier at time of stay"
    - name: "vip_code"
      expr: vip_code
      comment: "VIP designation code for the stay"
    - name: "complimentary_flag"
      expr: complimentary_flag
      comment: "Whether stay was complimentary"
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of guest arrival"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of guest arrival"
    - name: "arrival_quarter"
      expr: DATE_TRUNC('QUARTER', arrival_date)
      comment: "Quarter of guest arrival"
    - name: "departure_year"
      expr: YEAR(departure_date)
      comment: "Year of guest departure"
    - name: "departure_month"
      expr: DATE_TRUNC('MONTH', departure_date)
      comment: "Month of guest departure"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Year booking was made"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month booking was made"
  measures:
    - name: "total_stays"
      expr: COUNT(stay_history_id)
      comment: "Total number of stays"
    - name: "unique_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests with stays"
    - name: "total_room_nights"
      expr: SUM(CAST(los_nights AS BIGINT))
      comment: "Total room nights across all stays"
    - name: "total_room_revenue"
      expr: SUM(CAST(room_revenue AS DOUBLE))
      comment: "Total room revenue generated"
    - name: "total_fb_revenue"
      expr: SUM(CAST(fb_revenue AS DOUBLE))
      comment: "Total food and beverage revenue"
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(ancillary_revenue AS DOUBLE))
      comment: "Total ancillary revenue (spa, parking, etc.)"
    - name: "total_revenue"
      expr: SUM(CAST(total_folio_amount AS DOUBLE))
      comment: "Total revenue across all revenue streams"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected"
    - name: "avg_daily_rate"
      expr: AVG(CAST(adr AS DOUBLE))
      comment: "Average daily rate across stays"
    - name: "avg_length_of_stay"
      expr: AVG(CAST(los_nights AS DOUBLE))
      comment: "Average length of stay in nights"
    - name: "avg_revenue_per_stay"
      expr: AVG(CAST(total_folio_amount AS DOUBLE))
      comment: "Average total revenue per stay"
    - name: "avg_room_revenue_per_stay"
      expr: AVG(CAST(room_revenue AS DOUBLE))
      comment: "Average room revenue per stay"
    - name: "avg_fb_revenue_per_stay"
      expr: AVG(CAST(fb_revenue AS DOUBLE))
      comment: "Average F&B revenue per stay"
    - name: "avg_ancillary_revenue_per_stay"
      expr: AVG(CAST(ancillary_revenue AS DOUBLE))
      comment: "Average ancillary revenue per stay"
    - name: "revpar"
      expr: ROUND(SUM(CAST(room_revenue AS DOUBLE)) / NULLIF(SUM(CAST(los_nights AS DOUBLE)), 0), 2)
      comment: "Revenue per available room (room revenue divided by room nights)"
    - name: "fb_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN CAST(fb_revenue AS DOUBLE) > 0 THEN stay_history_id END) / NULLIF(COUNT(DISTINCT stay_history_id), 0), 2)
      comment: "Percentage of stays with F&B revenue"
    - name: "ancillary_attachment_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN CAST(ancillary_revenue AS DOUBLE) > 0 THEN stay_history_id END) / NULLIF(COUNT(DISTINCT stay_history_id), 0), 2)
      comment: "Percentage of stays with ancillary revenue"
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average guest satisfaction score"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "total_loyalty_points_earned"
      expr: SUM(CAST(loyalty_points_earned AS BIGINT))
      comment: "Total loyalty points earned across all stays"
    - name: "total_qualifying_nights"
      expr: SUM(CAST(qualifying_nights AS BIGINT))
      comment: "Total nights that qualify for loyalty status"
    - name: "service_recovery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN service_recovery_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(DISTINCT stay_history_id), 0), 2)
      comment: "Percentage of stays requiring service recovery"
    - name: "complimentary_stay_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN complimentary_flag = TRUE THEN stay_history_id END) / NULLIF(COUNT(DISTINCT stay_history_id), 0), 2)
      comment: "Percentage of stays that were complimentary"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value and predictive metrics for strategic guest relationship management"
  source: "`travel_hospitality_ecm`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "Lifetime value tier classification"
    - name: "loyalty_tier"
      expr: loyalty_tier_code
      comment: "Current loyalty tier"
    - name: "market_segment"
      expr: market_segment_code
      comment: "Primary market segment"
    - name: "preferred_brand"
      expr: preferred_brand_code
      comment: "Guest preferred brand"
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Whether guest is at risk of churning"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether guest has VIP status"
    - name: "calculation_year"
      expr: YEAR(calculation_date)
      comment: "Year LTV was calculated"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_date)
      comment: "Month LTV was calculated"
    - name: "first_stay_year"
      expr: YEAR(first_stay_date)
      comment: "Year of guest first stay"
    - name: "most_recent_stay_year"
      expr: YEAR(most_recent_stay_date)
      comment: "Year of most recent stay"
  measures:
    - name: "total_guests_valued"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of guests with LTV calculations"
    - name: "avg_ltv_score"
      expr: AVG(CAST(ltv_score AS DOUBLE))
      comment: "Average lifetime value score"
    - name: "total_lifetime_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total historical revenue across all guests"
    - name: "total_room_revenue"
      expr: SUM(CAST(total_room_revenue AS DOUBLE))
      comment: "Total historical room revenue"
    - name: "total_fb_revenue"
      expr: SUM(CAST(total_fb_revenue AS DOUBLE))
      comment: "Total historical F&B revenue"
    - name: "total_ancillary_revenue"
      expr: SUM(CAST(total_ancillary_revenue AS DOUBLE))
      comment: "Total historical ancillary revenue"
    - name: "avg_lifetime_revenue_per_guest"
      expr: AVG(CAST(total_revenue AS DOUBLE))
      comment: "Average lifetime revenue per guest"
    - name: "total_room_nights"
      expr: SUM(CAST(total_room_nights AS BIGINT))
      comment: "Total room nights across all guests"
    - name: "total_stays"
      expr: SUM(CAST(total_stays AS BIGINT))
      comment: "Total stays across all guests"
    - name: "avg_stays_per_guest"
      expr: AVG(CAST(total_stays AS DOUBLE))
      comment: "Average number of stays per guest"
    - name: "avg_room_nights_per_guest"
      expr: AVG(CAST(total_room_nights AS DOUBLE))
      comment: "Average room nights per guest"
    - name: "avg_daily_rate"
      expr: AVG(CAST(average_daily_rate AS DOUBLE))
      comment: "Average daily rate across guest portfolio"
    - name: "avg_length_of_stay"
      expr: AVG(CAST(average_length_of_stay AS DOUBLE))
      comment: "Average length of stay across guest portfolio"
    - name: "avg_revenue_per_stay"
      expr: AVG(CAST(average_revenue_per_stay AS DOUBLE))
      comment: "Average revenue per stay across guest portfolio"
    - name: "avg_guest_tenure_days"
      expr: AVG(CAST(guest_tenure_days AS DOUBLE))
      comment: "Average guest tenure in days"
    - name: "avg_days_since_last_stay"
      expr: AVG(CAST(days_since_last_stay AS DOUBLE))
      comment: "Average days since last stay (recency metric)"
    - name: "total_projected_12m_revenue"
      expr: SUM(CAST(projected_12m_revenue AS DOUBLE))
      comment: "Total projected revenue for next 12 months"
    - name: "avg_projected_12m_revenue_per_guest"
      expr: AVG(CAST(projected_12m_revenue AS DOUBLE))
      comment: "Average projected 12-month revenue per guest"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score"
    - name: "churn_risk_guest_count"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_flag = TRUE THEN profile_id END)
      comment: "Number of guests flagged as churn risk"
    - name: "churn_risk_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN churn_risk_flag = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests at churn risk"
    - name: "avg_next_stay_propensity_score"
      expr: AVG(CAST(next_stay_propensity_score AS DOUBLE))
      comment: "Average propensity score for next stay"
    - name: "avg_gss_score"
      expr: AVG(CAST(average_gss_score AS DOUBLE))
      comment: "Average guest satisfaction score"
    - name: "avg_nps_score"
      expr: AVG(CAST(average_nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "total_complaints"
      expr: SUM(CAST(total_complaints AS BIGINT))
      comment: "Total complaints across all guests"
    - name: "avg_complaints_per_guest"
      expr: AVG(CAST(total_complaints AS DOUBLE))
      comment: "Average complaints per guest"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate account performance metrics tracking B2B revenue, contract compliance, and account health"
  source: "`travel_hospitality_ecm`.`guest`.`corporate_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Status of corporate account (active, inactive, suspended)"
    - name: "account_type"
      expr: account_type
      comment: "Type of corporate account"
    - name: "market_segment"
      expr: market_segment_code
      comment: "Market segment classification"
    - name: "industry_sic_code"
      expr: industry_sic_code
      comment: "Standard Industrial Classification code"
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "North American Industry Classification System code"
    - name: "vip_tier"
      expr: vip_tier
      comment: "VIP tier designation for corporate account"
    - name: "rate_program_type"
      expr: rate_program_type
      comment: "Type of negotiated rate program"
    - name: "direct_billing_enabled"
      expr: direct_billing_enabled
      comment: "Whether direct billing is enabled"
    - name: "tax_exempt_status"
      expr: tax_exempt_status
      comment: "Tax exemption status"
    - name: "mice_eligible"
      expr: mice_eligible
      comment: "Whether account is eligible for MICE (Meetings, Incentives, Conferences, Exhibitions)"
    - name: "contract_start_year"
      expr: YEAR(contract_start_date)
      comment: "Year contract started"
    - name: "contract_end_year"
      expr: YEAR(contract_end_date)
      comment: "Year contract ends"
    - name: "contract_start_month"
      expr: DATE_TRUNC('MONTH', contract_start_date)
      comment: "Month contract started"
  measures:
    - name: "total_corporate_accounts"
      expr: COUNT(corporate_account_id)
      comment: "Total number of corporate accounts"
    - name: "unique_corporate_accounts"
      expr: COUNT(DISTINCT corporate_account_id)
      comment: "Distinct count of corporate accounts"
    - name: "active_account_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN corporate_account_id END)
      comment: "Number of active corporate accounts"
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all accounts"
    - name: "avg_annual_revenue_target"
      expr: AVG(CAST(annual_revenue_target AS DOUBLE))
      comment: "Average annual revenue target per account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account"
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across accounts"
    - name: "direct_billing_enabled_count"
      expr: COUNT(DISTINCT CASE WHEN direct_billing_enabled = TRUE THEN corporate_account_id END)
      comment: "Number of accounts with direct billing enabled"
    - name: "direct_billing_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN direct_billing_enabled = TRUE THEN corporate_account_id END) / NULLIF(COUNT(DISTINCT corporate_account_id), 0), 2)
      comment: "Percentage of accounts with direct billing enabled"
    - name: "mice_eligible_count"
      expr: COUNT(DISTINCT CASE WHEN mice_eligible = TRUE THEN corporate_account_id END)
      comment: "Number of accounts eligible for MICE business"
    - name: "mice_eligible_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mice_eligible = TRUE THEN corporate_account_id END) / NULLIF(COUNT(DISTINCT corporate_account_id), 0), 2)
      comment: "Percentage of accounts eligible for MICE business"
    - name: "tax_exempt_account_count"
      expr: COUNT(DISTINCT CASE WHEN tax_exempt_status IS NOT NULL AND tax_exempt_status != '' THEN corporate_account_id END)
      comment: "Number of accounts with tax exemption"
    - name: "loyalty_eligible_account_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_program_eligible = TRUE THEN corporate_account_id END)
      comment: "Number of accounts eligible for loyalty program"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_group_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Group block performance metrics tracking contracted vs actual pickup, attrition, and group revenue"
  source: "`travel_hospitality_ecm`.`guest`.`guest_group_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Status of group block (tentative, definite, cancelled)"
    - name: "group_type"
      expr: group_type
      comment: "Type of group (corporate, association, leisure, etc.)"
    - name: "market_segment"
      expr: market_segment_code
      comment: "Market segment code"
    - name: "source_of_business"
      expr: source_of_business_code
      comment: "Source of business code"
    - name: "group_rate_code"
      expr: group_rate_code
      comment: "Rate code applied to group"
    - name: "repeat_group_flag"
      expr: repeat_group_flag
      comment: "Whether this is a repeat group"
    - name: "vip_flag"
      expr: vip_flag
      comment: "Whether group has VIP designation"
    - name: "rooming_list_status"
      expr: rooming_list_status
      comment: "Status of rooming list submission"
    - name: "arrival_year"
      expr: YEAR(arrival_date)
      comment: "Year of group arrival"
    - name: "arrival_month"
      expr: DATE_TRUNC('MONTH', arrival_date)
      comment: "Month of group arrival"
    - name: "arrival_quarter"
      expr: DATE_TRUNC('QUARTER', arrival_date)
      comment: "Quarter of group arrival"
    - name: "contracted_year"
      expr: YEAR(contracted_date)
      comment: "Year block was contracted"
    - name: "contracted_month"
      expr: DATE_TRUNC('MONTH', contracted_date)
      comment: "Month block was contracted"
  measures:
    - name: "total_group_blocks"
      expr: COUNT(guest_group_block_id)
      comment: "Total number of group blocks"
    - name: "unique_group_blocks"
      expr: COUNT(DISTINCT guest_group_block_id)
      comment: "Distinct count of group blocks"
    - name: "definite_block_count"
      expr: COUNT(DISTINCT CASE WHEN block_status = 'Definite' THEN guest_group_block_id END)
      comment: "Number of definite (confirmed) group blocks"
    - name: "total_contracted_room_nights"
      expr: SUM(CAST(contracted_room_nights AS BIGINT))
      comment: "Total contracted room nights across all blocks"
    - name: "total_rooms_picked_up"
      expr: SUM(CAST(rooms_picked_up AS BIGINT))
      comment: "Total rooms actually picked up (actualized)"
    - name: "total_peak_block_rooms"
      expr: SUM(CAST(peak_block_rooms AS BIGINT))
      comment: "Total peak night rooms blocked"
    - name: "avg_contracted_room_nights"
      expr: AVG(CAST(contracted_room_nights AS DOUBLE))
      comment: "Average contracted room nights per block"
    - name: "avg_rooms_picked_up"
      expr: AVG(CAST(rooms_picked_up AS DOUBLE))
      comment: "Average rooms picked up per block"
    - name: "avg_contracted_rate"
      expr: AVG(CAST(contracted_rate_amount AS DOUBLE))
      comment: "Average contracted rate across blocks"
    - name: "total_deposit_required"
      expr: SUM(CAST(deposit_required_amount AS DOUBLE))
      comment: "Total deposit amount required across all blocks"
    - name: "total_deposit_received"
      expr: SUM(CAST(deposit_received_amount AS DOUBLE))
      comment: "Total deposit amount received"
    - name: "avg_attrition_pct"
      expr: AVG(CAST(attrition_pct AS DOUBLE))
      comment: "Average attrition percentage across blocks"
    - name: "avg_wash_pct"
      expr: AVG(CAST(wash_pct AS DOUBLE))
      comment: "Average wash (cancellation) percentage"
    - name: "pickup_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(rooms_picked_up AS DOUBLE)) / NULLIF(SUM(CAST(contracted_room_nights AS DOUBLE)), 0), 2)
      comment: "Overall pickup rate (actual vs contracted room nights)"
    - name: "deposit_collection_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(deposit_received_amount AS DOUBLE)) / NULLIF(SUM(CAST(deposit_required_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of required deposits collected"
    - name: "repeat_group_count"
      expr: COUNT(DISTINCT CASE WHEN repeat_group_flag = TRUE THEN guest_group_block_id END)
      comment: "Number of repeat group blocks"
    - name: "repeat_group_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN repeat_group_flag = TRUE THEN guest_group_block_id END) / NULLIF(COUNT(DISTINCT guest_group_block_id), 0), 2)
      comment: "Percentage of blocks from repeat groups"
    - name: "vip_group_count"
      expr: COUNT(DISTINCT CASE WHEN vip_flag = TRUE THEN guest_group_block_id END)
      comment: "Number of VIP group blocks"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_privacy_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDPR and privacy compliance metrics tracking request volume, processing time, and regulatory adherence"
  source: "`travel_hospitality_ecm`.`guest`.`privacy_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of privacy request (access, erasure, rectification, portability)"
    - name: "request_status"
      expr: request_status
      comment: "Current status of privacy request"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel through which request was submitted"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction (GDPR, CCPA, etc.)"
    - name: "verification_status"
      expr: verification_status
      comment: "Status of identity verification"
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of request"
    - name: "legal_hold_flag"
      expr: legal_hold_flag
      comment: "Whether request is under legal hold"
    - name: "extension_granted_flag"
      expr: extension_granted_flag
      comment: "Whether processing extension was granted"
    - name: "third_party_notification_required"
      expr: third_party_notification_required
      comment: "Whether third-party notification is required"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year request was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month request was submitted"
    - name: "submission_quarter"
      expr: DATE_TRUNC('QUARTER', submission_date)
      comment: "Quarter request was submitted"
    - name: "completion_year"
      expr: YEAR(completion_date)
      comment: "Year request was completed"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month request was completed"
  measures:
    - name: "total_privacy_requests"
      expr: COUNT(privacy_request_id)
      comment: "Total number of privacy requests"
    - name: "unique_privacy_requests"
      expr: COUNT(DISTINCT privacy_request_id)
      comment: "Distinct count of privacy requests"
    - name: "unique_guests_requesting"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests submitting privacy requests"
    - name: "completed_request_count"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'Completed' THEN privacy_request_id END)
      comment: "Number of completed privacy requests"
    - name: "pending_request_count"
      expr: COUNT(DISTINCT CASE WHEN request_status IN ('Pending', 'In Progress') THEN privacy_request_id END)
      comment: "Number of pending or in-progress requests"
    - name: "overdue_request_count"
      expr: COUNT(DISTINCT CASE WHEN request_status = 'Overdue' THEN privacy_request_id END)
      comment: "Number of overdue requests"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN request_status = 'Completed' THEN privacy_request_id END) / NULLIF(COUNT(DISTINCT privacy_request_id), 0), 2)
      comment: "Percentage of requests completed"
    - name: "extension_granted_count"
      expr: COUNT(DISTINCT CASE WHEN extension_granted_flag = TRUE THEN privacy_request_id END)
      comment: "Number of requests granted processing extensions"
    - name: "extension_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN extension_granted_flag = TRUE THEN privacy_request_id END) / NULLIF(COUNT(DISTINCT privacy_request_id), 0), 2)
      comment: "Percentage of requests requiring extensions"
    - name: "legal_hold_count"
      expr: COUNT(DISTINCT CASE WHEN legal_hold_flag = TRUE THEN privacy_request_id END)
      comment: "Number of requests under legal hold"
    - name: "total_records_accessed"
      expr: SUM(CAST(records_accessed_count AS BIGINT))
      comment: "Total records accessed across all requests"
    - name: "total_records_deleted"
      expr: SUM(CAST(records_deleted_count AS BIGINT))
      comment: "Total records deleted (erasure requests)"
    - name: "total_records_rectified"
      expr: SUM(CAST(records_rectified_count AS BIGINT))
      comment: "Total records rectified (correction requests)"
    - name: "avg_records_accessed_per_request"
      expr: AVG(CAST(records_accessed_count AS DOUBLE))
      comment: "Average records accessed per request"
    - name: "avg_guest_communications_sent"
      expr: AVG(CAST(guest_communication_sent_count AS DOUBLE))
      comment: "Average communications sent per request"
    - name: "third_party_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN third_party_notification_required = TRUE THEN privacy_request_id END)
      comment: "Number of requests requiring third-party notification"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`guest_communication_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Marketing consent and GDPR compliance metrics tracking opt-in rates, consent lifecycle, and channel preferences"
  source: "`travel_hospitality_ecm`.`guest`.`communication_consent`"
  dimensions:
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (granted, withdrawn, expired)"
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, transactional, profiling)"
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Purpose for which consent was granted"
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was captured"
    - name: "consent_source"
      expr: consent_source
      comment: "Source system or channel of consent"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing (GDPR Article 6)"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction (GDPR, CCPA, etc.)"
    - name: "double_opt_in_flag"
      expr: double_opt_in_flag
      comment: "Whether double opt-in was used"
    - name: "profiling_consent_flag"
      expr: profiling_consent_flag
      comment: "Whether profiling consent was granted"
    - name: "third_party_sharing_consent_flag"
      expr: third_party_sharing_consent_flag
      comment: "Whether third-party sharing consent was granted"
    - name: "suppression_list_flag"
      expr: suppression_list_flag
      comment: "Whether guest is on suppression list"
    - name: "consent_granted_year"
      expr: YEAR(consent_granted_date)
      comment: "Year consent was granted"
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', consent_granted_date)
      comment: "Month consent was granted"
    - name: "consent_withdrawn_year"
      expr: YEAR(consent_withdrawn_date)
      comment: "Year consent was withdrawn"
    - name: "consent_withdrawn_month"
      expr: DATE_TRUNC('MONTH', consent_withdrawn_date)
      comment: "Month consent was withdrawn"
  measures:
    - name: "total_consent_records"
      expr: COUNT(communication_consent_id)
      comment: "Total number of consent records"
    - name: "unique_consent_records"
      expr: COUNT(DISTINCT communication_consent_id)
      comment: "Distinct count of consent records"
    - name: "unique_guests_with_consent"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Distinct count of guests with consent records"
    - name: "active_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Granted' THEN communication_consent_id END)
      comment: "Number of active (granted) consents"
    - name: "withdrawn_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Withdrawn' THEN communication_consent_id END)
      comment: "Number of withdrawn consents"
    - name: "expired_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'Expired' THEN communication_consent_id END)
      comment: "Number of expired consents"
    - name: "consent_grant_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'Granted' THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of consents currently granted"
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'Withdrawn' THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of consents withdrawn"
    - name: "double_opt_in_count"
      expr: COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN communication_consent_id END)
      comment: "Number of consents using double opt-in"
    - name: "double_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN double_opt_in_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of consents using double opt-in"
    - name: "profiling_consent_count"
      expr: COUNT(DISTINCT CASE WHEN profiling_consent_flag = TRUE THEN communication_consent_id END)
      comment: "Number of consents for profiling"
    - name: "profiling_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN profiling_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of guests consenting to profiling"
    - name: "third_party_sharing_consent_count"
      expr: COUNT(DISTINCT CASE WHEN third_party_sharing_consent_flag = TRUE THEN communication_consent_id END)
      comment: "Number of consents for third-party sharing"
    - name: "third_party_sharing_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_sharing_consent_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of guests consenting to third-party sharing"
    - name: "suppression_list_count"
      expr: COUNT(DISTINCT CASE WHEN suppression_list_flag = TRUE THEN communication_consent_id END)
      comment: "Number of guests on suppression list"
    - name: "suppression_list_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN suppression_list_flag = TRUE THEN communication_consent_id END) / NULLIF(COUNT(DISTINCT communication_consent_id), 0), 2)
      comment: "Percentage of guests on suppression list"
$$;