-- Metric views for domain: passenger | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:47:29

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core passenger profile metrics tracking customer base composition, segmentation, and data quality for strategic customer analytics and marketing targeting."
  source: "`airlines_ecm`.`passenger`.`profile`"
  dimensions:
    - name: "customer_segment"
      expr: customer_segment
      comment: "Business segment classification of the passenger (e.g., leisure, business, premium)"
    - name: "passenger_type"
      expr: passenger_type
      comment: "Type of passenger (e.g., adult, child, infant, senior)"
    - name: "country_of_residence"
      expr: country_of_residence
      comment: "Country where the passenger resides, used for market analysis"
    - name: "nationality"
      expr: nationality
      comment: "Passenger nationality for regulatory and market segmentation"
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the passenger profile (e.g., active, inactive, suspended)"
    - name: "vip_indicator"
      expr: vip_indicator
      comment: "Flag indicating VIP status for premium service delivery"
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether passenger has consented to marketing communications"
    - name: "data_sharing_consent"
      expr: data_sharing_consent
      comment: "Whether passenger has consented to data sharing"
    - name: "preferred_language"
      expr: preferred_language
      comment: "Passenger's preferred language for communications"
    - name: "creation_source"
      expr: creation_source
      comment: "Channel or system where the profile was originally created"
    - name: "profile_creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year the profile was created for cohort analysis"
    - name: "profile_creation_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the profile was created for trend analysis"
  measures:
    - name: "total_passenger_profiles"
      expr: COUNT(1)
      comment: "Total number of passenger profiles in the system"
    - name: "unique_passengers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of unique passenger profiles"
    - name: "vip_passenger_count"
      expr: SUM(CASE WHEN vip_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers with VIP status"
    - name: "marketing_opt_in_count"
      expr: SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers who have opted in to marketing"
    - name: "data_sharing_consent_count"
      expr: SUM(CASE WHEN data_sharing_consent = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers who have consented to data sharing"
    - name: "avg_profile_completeness_score"
      expr: AVG(CAST(completeness_score AS DOUBLE))
      comment: "Average profile completeness score indicating data quality and customer engagement"
    - name: "vip_penetration_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vip_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passenger base with VIP status, key metric for premium segment sizing"
    - name: "marketing_opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN marketing_opt_in = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passengers opted in to marketing, critical for campaign reach planning"
    - name: "data_consent_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_sharing_consent = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passengers who have consented to data sharing, key compliance and personalization metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger booking behavior and revenue metrics tracking booking patterns, fare performance, and upgrade activity for revenue management and customer experience optimization."
  source: "`airlines_ecm`.`passenger`.`passenger_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the booking (e.g., confirmed, cancelled, no-show)"
    - name: "booking_class"
      expr: booking_class
      comment: "Booking class code indicating fare type and inventory bucket"
    - name: "cabin_class"
      expr: cabin_class
      comment: "Cabin class of the booking (e.g., economy, business, first)"
    - name: "booking_source"
      expr: booking_source
      comment: "Channel through which the booking was made (e.g., web, mobile, GDS, call center)"
    - name: "fare_currency"
      expr: fare_currency
      comment: "Currency in which the fare was paid"
    - name: "upgrade_indicator"
      expr: upgrade_indicator
      comment: "Flag indicating whether the booking was upgraded"
    - name: "booking_creation_year"
      expr: YEAR(created_timestamp)
      comment: "Year the booking was created for trend analysis"
    - name: "booking_creation_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the booking was created for seasonality analysis"
    - name: "check_in_status"
      expr: CASE WHEN check_in_timestamp IS NOT NULL THEN 'Checked In' ELSE 'Not Checked In' END
      comment: "Whether the passenger has checked in for the flight"
    - name: "boarding_status"
      expr: CASE WHEN boarding_timestamp IS NOT NULL THEN 'Boarded' ELSE 'Not Boarded' END
      comment: "Whether the passenger has boarded the flight"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of passenger bookings"
    - name: "unique_bookings"
      expr: COUNT(DISTINCT passenger_booking_id)
      comment: "Count of unique passenger bookings"
    - name: "total_fare_revenue"
      expr: SUM(CAST(fare_amount AS DOUBLE))
      comment: "Total fare revenue across all bookings, primary revenue metric for passenger business"
    - name: "avg_fare_amount"
      expr: AVG(CAST(fare_amount AS DOUBLE))
      comment: "Average fare amount per booking, key yield indicator"
    - name: "upgraded_bookings_count"
      expr: SUM(CASE WHEN upgrade_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of bookings that were upgraded"
    - name: "checked_in_bookings_count"
      expr: SUM(CASE WHEN check_in_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of bookings where passenger has checked in"
    - name: "boarded_bookings_count"
      expr: SUM(CASE WHEN boarding_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of bookings where passenger has boarded"
    - name: "upgrade_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN upgrade_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings that were upgraded, key metric for ancillary revenue and customer satisfaction"
    - name: "check_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN check_in_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings where passenger checked in, operational efficiency metric"
    - name: "boarding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN boarding_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings where passenger boarded, key show rate metric for revenue management"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_ssr_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special service request metrics tracking ancillary service demand, fulfillment performance, and revenue from passenger service requests for operational planning and ancillary revenue optimization."
  source: "`airlines_ecm`.`passenger`.`ssr_record`"
  dimensions:
    - name: "ssr_code"
      expr: ssr_code
      comment: "Standard SSR code identifying the type of special service requested"
    - name: "ssr_category"
      expr: ssr_category
      comment: "Category of special service (e.g., meal, accessibility, baggage, pet)"
    - name: "ssr_status"
      expr: ssr_status
      comment: "Current status of the SSR (e.g., requested, confirmed, fulfilled, cancelled)"
    - name: "is_chargeable"
      expr: is_chargeable
      comment: "Whether the service request incurs a charge"
    - name: "requires_advance_notice"
      expr: requires_advance_notice
      comment: "Whether the service requires advance notice"
    - name: "requires_medical_clearance"
      expr: requires_medical_clearance
      comment: "Whether the service requires medical clearance"
    - name: "medical_clearance_status"
      expr: medical_clearance_status
      comment: "Status of medical clearance for the service"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the SSR was booked"
    - name: "is_interline"
      expr: is_interline
      comment: "Whether the SSR applies to an interline segment"
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year the SSR was requested for trend analysis"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the SSR was requested for seasonality analysis"
  measures:
    - name: "total_ssr_requests"
      expr: COUNT(1)
      comment: "Total number of special service requests"
    - name: "unique_ssr_requests"
      expr: COUNT(DISTINCT ssr_record_id)
      comment: "Count of unique special service requests"
    - name: "total_ssr_revenue"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total revenue from chargeable special service requests, key ancillary revenue metric"
    - name: "avg_ssr_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per special service request"
    - name: "chargeable_ssr_count"
      expr: SUM(CASE WHEN is_chargeable = TRUE THEN 1 ELSE 0 END)
      comment: "Number of special service requests that incur a charge"
    - name: "confirmed_ssr_count"
      expr: SUM(CASE WHEN ssr_status = 'confirmed' THEN 1 ELSE 0 END)
      comment: "Number of confirmed special service requests"
    - name: "fulfilled_ssr_count"
      expr: SUM(CASE WHEN service_delivery_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of special service requests that were fulfilled"
    - name: "medical_clearance_required_count"
      expr: SUM(CASE WHEN requires_medical_clearance = TRUE THEN 1 ELSE 0 END)
      comment: "Number of SSRs requiring medical clearance"
    - name: "ssr_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_delivery_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SSRs successfully fulfilled, critical operational quality metric"
    - name: "chargeable_ssr_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_chargeable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SSRs that are chargeable, key metric for ancillary revenue opportunity"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger consent and privacy compliance metrics tracking opt-in rates, consent lifecycle, and regulatory compliance for GDPR/privacy management and marketing effectiveness."
  source: "`airlines_ecm`.`passenger`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (e.g., marketing, data sharing, profiling)"
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent (e.g., granted, withdrawn, expired)"
    - name: "processing_purpose"
      expr: processing_purpose
      comment: "Purpose for which data processing consent was granted"
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for processing under applicable regulation"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Jurisdiction under which the consent was collected"
    - name: "channel"
      expr: channel
      comment: "Channel through which consent was collected"
    - name: "opt_in_flag"
      expr: opt_in_flag
      comment: "Whether the consent represents an opt-in"
    - name: "minor_consent_flag"
      expr: minor_consent_flag
      comment: "Whether the consent relates to a minor"
    - name: "dpo_review_flag"
      expr: dpo_review_flag
      comment: "Whether the consent has been reviewed by Data Protection Officer"
    - name: "consent_granted_year"
      expr: YEAR(granted_timestamp)
      comment: "Year the consent was granted for trend analysis"
    - name: "consent_granted_month"
      expr: DATE_TRUNC('MONTH', granted_timestamp)
      comment: "Month the consent was granted for trend analysis"
  measures:
    - name: "total_consent_records"
      expr: COUNT(1)
      comment: "Total number of consent records"
    - name: "unique_consent_records"
      expr: COUNT(DISTINCT consent_id)
      comment: "Count of unique consent records"
    - name: "opt_in_count"
      expr: SUM(CASE WHEN opt_in_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of opt-in consents"
    - name: "withdrawn_consent_count"
      expr: SUM(CASE WHEN withdrawn_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of consents that have been withdrawn"
    - name: "minor_consent_count"
      expr: SUM(CASE WHEN minor_consent_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of consents relating to minors"
    - name: "dpo_reviewed_count"
      expr: SUM(CASE WHEN dpo_review_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of consents reviewed by Data Protection Officer"
    - name: "opt_in_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_in_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that are opt-ins, critical metric for marketing reach and compliance"
    - name: "consent_withdrawal_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN withdrawn_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been withdrawn, key metric for customer trust and privacy compliance"
    - name: "dpo_review_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dpo_review_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents reviewed by DPO, compliance quality metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_corporate_traveller`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate traveller program metrics tracking corporate account performance, discount utilization, and VIP status for B2B relationship management and corporate sales optimization."
  source: "`airlines_ecm`.`passenger`.`corporate_traveller`"
  dimensions:
    - name: "corporate_tier"
      expr: corporate_tier
      comment: "Tier level of the corporate account (e.g., platinum, gold, silver)"
    - name: "affiliation_status"
      expr: affiliation_status
      comment: "Current affiliation status with the corporate program"
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Whether the corporate traveller has VIP status"
    - name: "duty_of_care_flag"
      expr: duty_of_care_flag
      comment: "Whether duty of care services are enabled for the traveller"
    - name: "company_name"
      expr: company_name
      comment: "Name of the corporate account"
    - name: "department_name"
      expr: department_name
      comment: "Department within the corporate account"
    - name: "affiliation_year"
      expr: YEAR(effective_from_date)
      comment: "Year the corporate affiliation became effective"
    - name: "affiliation_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the corporate affiliation became effective"
  measures:
    - name: "total_corporate_travellers"
      expr: COUNT(1)
      comment: "Total number of corporate travellers"
    - name: "unique_corporate_travellers"
      expr: COUNT(DISTINCT corporate_traveller_id)
      comment: "Count of unique corporate travellers"
    - name: "vip_corporate_travellers_count"
      expr: SUM(CASE WHEN vip_status_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of corporate travellers with VIP status"
    - name: "duty_of_care_enabled_count"
      expr: SUM(CASE WHEN duty_of_care_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of corporate travellers with duty of care enabled"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage across corporate travellers, key metric for corporate pricing strategy"
    - name: "vip_penetration_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vip_status_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate travellers with VIP status, indicator of premium corporate segment size"
    - name: "duty_of_care_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN duty_of_care_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of corporate travellers with duty of care enabled, key metric for corporate service value proposition"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_traveller_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Passenger segmentation and propensity metrics tracking customer lifetime value, churn risk, and ancillary propensity for targeted marketing and retention strategies."
  source: "`airlines_ecm`.`passenger`.`traveller_segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Name of the traveller segment"
    - name: "segment_code"
      expr: segment_code
      comment: "Code identifying the traveller segment"
    - name: "segment_category"
      expr: segment_category
      comment: "Category of the segment (e.g., behavioral, demographic, value-based)"
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment assignment"
    - name: "lifetime_value_tier"
      expr: lifetime_value_tier
      comment: "Lifetime value tier of the passenger (e.g., high, medium, low)"
    - name: "loyalty_engagement_level"
      expr: loyalty_engagement_level
      comment: "Level of engagement with loyalty program"
    - name: "price_sensitivity_indicator"
      expr: price_sensitivity_indicator
      comment: "Indicator of passenger price sensitivity"
    - name: "travel_frequency_band"
      expr: travel_frequency_band
      comment: "Band indicating travel frequency (e.g., frequent, occasional, rare)"
    - name: "corporate_affiliation_flag"
      expr: corporate_affiliation_flag
      comment: "Whether the passenger has corporate affiliation"
    - name: "targeting_eligible_flag"
      expr: targeting_eligible_flag
      comment: "Whether the passenger is eligible for targeted campaigns"
    - name: "segment_assignment_year"
      expr: YEAR(assignment_date)
      comment: "Year the segment was assigned"
    - name: "segment_assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month the segment was assigned"
  measures:
    - name: "total_segmented_passengers"
      expr: COUNT(1)
      comment: "Total number of segmented passengers"
    - name: "unique_segmented_passengers"
      expr: COUNT(DISTINCT traveller_segment_id)
      comment: "Count of unique segmented passengers"
    - name: "avg_ancillary_propensity_score"
      expr: AVG(CAST(ancillary_propensity_score AS DOUBLE))
      comment: "Average propensity to purchase ancillary services, critical for ancillary revenue targeting"
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score, key metric for retention strategy prioritization"
    - name: "avg_revenue_contribution_score"
      expr: AVG(CAST(revenue_contribution_score AS DOUBLE))
      comment: "Average revenue contribution score, indicator of customer value distribution"
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence in segment assignment, data quality metric for segmentation model"
    - name: "targeting_eligible_count"
      expr: SUM(CASE WHEN targeting_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers eligible for targeted campaigns"
    - name: "corporate_affiliated_count"
      expr: SUM(CASE WHEN corporate_affiliation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers with corporate affiliation"
    - name: "targeting_eligible_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN targeting_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passengers eligible for targeting, key metric for addressable marketing audience"
    - name: "corporate_affiliation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corporate_affiliation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passengers with corporate affiliation, B2B market penetration metric"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_accessibility_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accessibility service demand and compliance metrics tracking special assistance requirements, mobility aid usage, and service delivery for regulatory compliance and inclusive service design."
  source: "`airlines_ecm`.`passenger`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the accessibility profile"
  measures:
    - name: "total_accessibility_profiles"
      expr: COUNT(1)
      comment: "Total number of accessibility profiles"
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`passenger_watchlist_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security screening and watchlist compliance metrics tracking screening outcomes, match rates, and resolution performance for aviation security and regulatory compliance."
  source: "`airlines_ecm`.`passenger`.`watchlist_check`"
  dimensions:
    - name: "check_status"
      expr: check_status
      comment: "Status of the watchlist check (e.g., clear, pending, match)"
    - name: "match_status"
      expr: match_status
      comment: "Match status against watchlist"
    - name: "screening_program"
      expr: screening_program
      comment: "Screening program used (e.g., TSA, EU PNR, APIS)"
    - name: "screening_jurisdiction"
      expr: screening_jurisdiction
      comment: "Jurisdiction under which screening was performed"
    - name: "selectee_indicator"
      expr: selectee_indicator
      comment: "Whether passenger was selected for additional screening"
    - name: "boarding_pass_issued"
      expr: boarding_pass_issued
      comment: "Whether boarding pass was issued after screening"
    - name: "check_year"
      expr: YEAR(check_timestamp)
      comment: "Year the watchlist check was performed"
    - name: "check_month"
      expr: DATE_TRUNC('MONTH', check_timestamp)
      comment: "Month the watchlist check was performed"
  measures:
    - name: "total_watchlist_checks"
      expr: COUNT(1)
      comment: "Total number of watchlist checks performed"
    - name: "unique_watchlist_checks"
      expr: COUNT(DISTINCT watchlist_check_id)
      comment: "Count of unique watchlist checks"
    - name: "match_count"
      expr: SUM(CASE WHEN match_status = 'match' THEN 1 ELSE 0 END)
      comment: "Number of watchlist matches"
    - name: "selectee_count"
      expr: SUM(CASE WHEN selectee_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Number of passengers selected for additional screening"
    - name: "boarding_pass_issued_count"
      expr: SUM(CASE WHEN boarding_pass_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Number of checks where boarding pass was issued"
    - name: "resolved_checks_count"
      expr: SUM(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Number of checks that have been resolved"
    - name: "avg_match_score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score across all checks"
    - name: "match_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN match_status = 'match' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks resulting in watchlist match, key security metric"
    - name: "selectee_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN selectee_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of passengers selected for additional screening, operational impact metric"
    - name: "boarding_pass_issuance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN boarding_pass_issued = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks resulting in boarding pass issuance, clearance efficiency metric"
    - name: "resolution_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of checks that have been resolved, operational efficiency and compliance metric"
$$;