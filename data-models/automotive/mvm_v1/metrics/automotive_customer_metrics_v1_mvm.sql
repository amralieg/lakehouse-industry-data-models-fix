-- Metric views for domain: customer | Business: Automotive | Version: 1 | Generated on: 2026-05-07 02:15:05

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case performance and resolution metrics tracking case volume, resolution efficiency, SLA compliance, and customer satisfaction outcomes"
  source: "`automotive_ecm`.`customer`.`case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of customer service case (complaint, inquiry, technical support, etc.)"
    - name: "case_category"
      expr: case_category
      comment: "Primary category classification of the case"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (open, in progress, resolved, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the case"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation tier of the case"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the case was initiated (phone, email, web, mobile app)"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Code indicating how the case was resolved"
    - name: "customer_satisfaction_score"
      expr: customer_satisfaction_score
      comment: "Customer satisfaction rating for case resolution"
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_timestamp)
      comment: "Month when the case was opened"
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_timestamp)
      comment: "Month when the case was closed"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of customer service cases"
    - name: "total_closed_cases"
      expr: COUNT(CASE WHEN case_status = 'Closed' THEN 1 END)
      comment: "Total number of cases that have been closed"
    - name: "total_escalated_cases"
      expr: COUNT(CASE WHEN escalation_level IS NOT NULL THEN 1 END)
      comment: "Total number of cases that have been escalated"
    - name: "case_resolution_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that have been resolved and closed"
    - name: "case_escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_level IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that required escalation"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_individual`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Individual customer value, engagement, and lifecycle metrics tracking customer lifetime value, loyalty tier distribution, and marketing engagement"
  source: "`automotive_ecm`.`customer`.`individual`"
  dimensions:
    - name: "customer_type"
      expr: customer_type
      comment: "Classification of customer type"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Current loyalty program tier of the customer"
    - name: "individual_status"
      expr: individual_status
      comment: "Current status of the individual customer record"
    - name: "segment"
      expr: segment
      comment: "Customer segment classification"
    - name: "gender"
      expr: gender
      comment: "Gender of the individual customer"
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country where the customer resides"
    - name: "employment_status"
      expr: employment_status
      comment: "Employment status of the customer"
    - name: "annual_income_band"
      expr: annual_income_band
      comment: "Income band classification of the customer"
    - name: "marketing_opt_in_email_flag"
      expr: marketing_opt_in_email
      comment: "Whether customer has opted in to email marketing"
  measures:
    - name: "total_customers"
      expr: COUNT(1)
      comment: "Total number of individual customers"
    - name: "total_cltv"
      expr: SUM(CAST(cltv_estimate AS DOUBLE))
      comment: "Total estimated customer lifetime value across all customers"
    - name: "avg_cltv"
      expr: AVG(CAST(cltv_estimate AS DOUBLE))
      comment: "Average estimated customer lifetime value per customer"
    - name: "email_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_email = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers who have opted in to email marketing"
    - name: "phone_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_phone = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers who have opted in to phone marketing"
    - name: "sms_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in_sms = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers who have opted in to SMS marketing"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_loyalty_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Loyalty program performance metrics tracking member engagement, points economics, tier distribution, and redemption behavior"
  source: "`automotive_ecm`.`customer`.`loyalty_membership`"
  dimensions:
    - name: "current_tier"
      expr: current_tier
      comment: "Current loyalty tier of the member"
    - name: "program_status"
      expr: program_status
      comment: "Status of the loyalty membership (active, inactive, suspended)"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the member enrolled in the loyalty program"
    - name: "preferred_redemption_category"
      expr: preferred_redemption_category
      comment: "Category of rewards the member prefers to redeem"
    - name: "redemption_eligibility_flag"
      expr: redemption_eligibility_flag
      comment: "Whether the member is currently eligible to redeem points"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when the member enrolled in the loyalty program"
  measures:
    - name: "total_members"
      expr: COUNT(1)
      comment: "Total number of loyalty program members"
    - name: "total_active_members"
      expr: COUNT(CASE WHEN program_status = 'Active' THEN 1 END)
      comment: "Total number of active loyalty program members"
    - name: "total_points_balance"
      expr: SUM(CAST(points_balance AS DOUBLE))
      comment: "Total points balance across all loyalty members"
    - name: "avg_points_balance"
      expr: AVG(CAST(points_balance AS DOUBLE))
      comment: "Average points balance per loyalty member"
    - name: "total_lifetime_points_earned"
      expr: SUM(CAST(lifetime_points_earned AS DOUBLE))
      comment: "Total lifetime points earned across all members"
    - name: "total_points_redeemed"
      expr: SUM(CAST(total_points_redeemed AS DOUBLE))
      comment: "Total points redeemed across all members"
    - name: "total_points_earned_this_year"
      expr: SUM(CAST(points_earned_this_year AS DOUBLE))
      comment: "Total points earned by all members in the current year"
    - name: "total_points_redeemed_this_year"
      expr: SUM(CAST(points_redeemed_this_year AS DOUBLE))
      comment: "Total points redeemed by all members in the current year"
    - name: "redemption_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_points_redeemed AS DOUBLE)) / NULLIF(SUM(CAST(lifetime_points_earned AS DOUBLE)), 0), 2)
      comment: "Percentage of lifetime earned points that have been redeemed"
    - name: "active_member_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN program_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of loyalty members with active status"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score and customer feedback metrics tracking customer advocacy, satisfaction trends, and follow-up effectiveness"
  source: "`automotive_ecm`.`customer`.`nps_response`"
  dimensions:
    - name: "promoter_category"
      expr: promoter_category
      comment: "NPS category classification (promoter, passive, detractor)"
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey conducted"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was delivered"
    - name: "touchpoint"
      expr: touchpoint
      comment: "Customer touchpoint being measured by the survey"
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up action on the NPS response"
    - name: "nps_response_status"
      expr: nps_response_status
      comment: "Status of the NPS response record"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_date)
      comment: "Month when the customer responded to the survey"
  measures:
    - name: "total_responses"
      expr: COUNT(1)
      comment: "Total number of NPS survey responses"
    - name: "total_promoters"
      expr: COUNT(CASE WHEN promoter_category = 'Promoter' THEN 1 END)
      comment: "Total number of promoter responses (NPS 9-10)"
    - name: "total_detractors"
      expr: COUNT(CASE WHEN promoter_category = 'Detractor' THEN 1 END)
      comment: "Total number of detractor responses (NPS 0-6)"
    - name: "total_passives"
      expr: COUNT(CASE WHEN promoter_category = 'Passive' THEN 1 END)
      comment: "Total number of passive responses (NPS 7-8)"
    - name: "promoter_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promoter_category = 'Promoter' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses that are promoters"
    - name: "detractor_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN promoter_category = 'Detractor' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses that are detractors"
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses that require follow-up action"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_organization_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and fleet customer account metrics tracking account value, credit exposure, fleet size distribution, and account tier performance"
  source: "`automotive_ecm`.`customer`.`organization_account`"
  dimensions:
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the organization account"
    - name: "organization_account_status"
      expr: organization_account_status
      comment: "Current status of the organization account"
    - name: "classification"
      expr: classification
      comment: "Classification type of the organization"
    - name: "government_entity_type"
      expr: government_entity_type
      comment: "Type of government entity if applicable"
    - name: "fleet_size"
      expr: fleet_size
      comment: "Size classification of the organization's vehicle fleet"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with the organization"
    - name: "naics_code"
      expr: naics_code
      comment: "North American Industry Classification System code"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of organization accounts"
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Total annual revenue across all organization accounts"
    - name: "avg_annual_revenue"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per organization account"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all organization accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per organization account"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master customer entity metrics tracking total customer base, lifecycle status distribution, customer lifetime value, and data quality compliance"
  source: "`automotive_ecm`.`customer`.`party`"
  dimensions:
    - name: "party_type"
      expr: party_type
      comment: "Type of party (individual, organization)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the party"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Segment classification of the customer"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the customer"
    - name: "country_code"
      expr: country_code
      comment: "Country code of the customer"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification of the customer"
    - name: "kyc_status"
      expr: kyc_status
      comment: "Know Your Customer verification status"
    - name: "marketing_opt_in_flag"
      expr: marketing_opt_in
      comment: "Whether customer has opted in to marketing communications"
    - name: "gdpr_consent_email_flag"
      expr: gdpr_consent_email
      comment: "Whether customer has provided GDPR consent for email"
    - name: "onboarding_channel"
      expr: onboarding_channel
      comment: "Channel through which the customer was onboarded"
  measures:
    - name: "total_parties"
      expr: COUNT(1)
      comment: "Total number of customer parties"
    - name: "total_customer_lifetime_value"
      expr: SUM(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Total customer lifetime value across all parties"
    - name: "avg_customer_lifetime_value"
      expr: AVG(CAST(customer_lifetime_value AS DOUBLE))
      comment: "Average customer lifetime value per party"
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parties who have opted in to marketing"
    - name: "gdpr_email_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_consent_email = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parties who have provided GDPR email consent"
    - name: "gdpr_sms_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_consent_sms = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parties who have provided GDPR SMS consent"
    - name: "kyc_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN kyc_status = 'Verified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of parties with verified KYC status"
$$;

CREATE OR REPLACE VIEW `automotive_ecm`.`_metrics`.`customer_vehicle_ownership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle ownership lifecycle and portfolio metrics tracking acquisition patterns, ownership duration, disposition trends, and fleet composition"
  source: "`automotive_ecm`.`customer`.`vehicle_ownership`"
  dimensions:
    - name: "ownership_type"
      expr: ownership_type
      comment: "Type of vehicle ownership (lease, purchase, fleet)"
    - name: "vehicle_ownership_status"
      expr: vehicle_ownership_status
      comment: "Current status of the vehicle ownership record"
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the vehicle was acquired"
    - name: "disposition_type"
      expr: disposition_type
      comment: "Type of vehicle disposition (trade-in, sale, return)"
    - name: "registration_country"
      expr: registration_country
      comment: "Country where the vehicle is registered"
    - name: "registration_state"
      expr: registration_state
      comment: "State or province where the vehicle is registered"
    - name: "is_primary_vehicle_flag"
      expr: is_primary_vehicle
      comment: "Whether this is the customer's primary vehicle"
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month when the vehicle was acquired"
    - name: "disposition_month"
      expr: DATE_TRUNC('MONTH', disposition_date)
      comment: "Month when the vehicle was disposed"
  measures:
    - name: "total_ownerships"
      expr: COUNT(1)
      comment: "Total number of vehicle ownership records"
    - name: "total_active_ownerships"
      expr: COUNT(CASE WHEN vehicle_ownership_status = 'Active' THEN 1 END)
      comment: "Total number of active vehicle ownerships"
    - name: "total_disposed_ownerships"
      expr: COUNT(CASE WHEN disposition_date IS NOT NULL THEN 1 END)
      comment: "Total number of vehicle ownerships that have been disposed"
    - name: "total_purchase_price"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price across all vehicle ownerships"
    - name: "avg_purchase_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per vehicle ownership"
    - name: "avg_current_odometer"
      expr: AVG(CAST(current_odometer AS DOUBLE))
      comment: "Average current odometer reading across all vehicles"
    - name: "avg_odometer_at_acquisition"
      expr: AVG(CAST(odometer_at_acquisition AS DOUBLE))
      comment: "Average odometer reading at time of acquisition"
    - name: "avg_disposition_odometer"
      expr: AVG(CAST(disposition_odometer AS DOUBLE))
      comment: "Average odometer reading at time of disposition"
$$;