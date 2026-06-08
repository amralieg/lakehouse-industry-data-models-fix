-- Metric views for domain: guest | Business: Restaurants | Version: 1 | Generated on: 2026-05-06 03:57:03

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking the active guest base, loyalty enrollment, marketing reachability, and average spend per guest. Used by CRM, marketing, and executive teams to assess guest base health and engagement depth."
  source: "`restaurants_ecm`.`guest`.`profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the guest profile (e.g., active, inactive, suspended). Used to segment the active vs. churned guest base."
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of the guest (e.g., loyalty member, anonymous, corporate). Drives segmentation for targeted campaigns."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty program tier of the guest (e.g., bronze, silver, gold). Key dimension for value-based segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country of the guest profile. Enables geographic performance analysis."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications. Critical for measuring reachable audience size."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest's preferred communication language. Used for localization and campaign targeting."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the guest. Used for demographic segmentation in marketing analysis."
    - name: "data_source"
      expr: data_source
      comment: "Origin system that created the guest profile (e.g., POS, app, web). Helps assess data quality and channel acquisition."
    - name: "primary_contact_method"
      expr: primary_contact_method
      comment: "Preferred contact channel for the guest (e.g., email, SMS, push). Informs channel strategy."
  measures:
    - name: "total_active_guests"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Total number of distinct active guest profiles. Core KPI for measuring the size of the engaged guest base."
    - name: "total_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total number of distinct guest profiles across all statuses. Baseline for guest universe sizing."
    - name: "loyalty_enrolled_guests"
      expr: COUNT(DISTINCT CASE WHEN loyalty_tier IS NOT NULL THEN profile_id END)
      comment: "Number of guests enrolled in a loyalty tier. Measures loyalty program penetration across the guest base."
    - name: "marketing_reachable_guests"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END)
      comment: "Number of guests who have opted into marketing communications. Defines the addressable audience for campaigns."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of total historical spend across all guest profiles. Measures the cumulative revenue contribution of the guest base."
    - name: "avg_check_value_per_guest"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value per guest profile. Indicates guest spending intensity and is a key input to revenue forecasting."
    - name: "email_consent_rate"
      expr: COUNT(DISTINCT CASE WHEN consent_email = TRUE THEN profile_id END)
      comment: "Number of guests with email marketing consent. Used to measure email channel reachability and compliance posture."
    - name: "sms_consent_rate"
      expr: COUNT(DISTINCT CASE WHEN consent_sms = TRUE THEN profile_id END)
      comment: "Number of guests with SMS marketing consent. Used to measure SMS channel reachability and compliance posture."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value metrics providing insight into historical spend, predicted future value, transaction frequency, and loyalty segmentation. Used by finance, CRM, and marketing leadership to prioritize high-value guest retention and acquisition strategies."
  source: "`restaurants_ecm`.`guest`.`lifetime_value`"
  dimensions:
    - name: "segment"
      expr: segment
      comment: "Guest value segment (e.g., high-value, at-risk, lapsed). Primary dimension for LTV-based guest segmentation."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Indicates whether the guest is a loyalty program member. Enables comparison of LTV between loyalty and non-loyalty guests."
    - name: "ltv_status"
      expr: ltv_status
      comment: "Current status of the LTV record (e.g., active, archived). Used to filter to current LTV calculations."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which LTV values are denominated. Required for multi-currency financial analysis."
    - name: "data_refresh_cycle"
      expr: data_refresh_cycle
      comment: "Frequency at which LTV data is refreshed (e.g., daily, weekly, monthly). Indicates data freshness for analytical trust."
    - name: "ltv_calculation_date"
      expr: ltv_calculation_date
      comment: "Date on which the LTV was last calculated. Used for time-series trending of LTV snapshots."
    - name: "first_visit_date"
      expr: first_visit_date
      comment: "Date of the guest's first recorded visit. Enables cohort analysis by acquisition vintage."
    - name: "most_recent_visit_date"
      expr: most_recent_visit_date
      comment: "Date of the guest's most recent visit. Used to identify recency cohorts and at-risk guests."
  measures:
    - name: "total_historical_spend"
      expr: SUM(CAST(total_historical_spend AS DOUBLE))
      comment: "Sum of all historical spend across guest LTV records. Represents the total revenue generated by the guest base to date."
    - name: "avg_historical_spend_per_guest"
      expr: AVG(CAST(total_historical_spend AS DOUBLE))
      comment: "Average historical spend per guest LTV record. Benchmarks individual guest value against the portfolio average."
    - name: "total_predicted_future_value"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Sum of predicted future value across all guests. Represents the forward-looking revenue potential of the guest base, used in retention investment decisions."
    - name: "avg_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per guest. Used to benchmark expected future revenue per guest and prioritize retention spend."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value across guest LTV records. Key indicator of per-visit spending behavior."
    - name: "avg_transactions_per_month"
      expr: AVG(CAST(average_transactions_per_month AS DOUBLE))
      comment: "Average number of transactions per month per guest. Measures visit frequency, a core driver of LTV and loyalty program ROI."
    - name: "loyalty_member_guest_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_member_flag = TRUE THEN primary_lifetime_guest_profile_id END)
      comment: "Number of distinct loyalty member guests in the LTV dataset. Used to measure loyalty program coverage of the high-value guest base."
    - name: "total_guest_ltv_records"
      expr: COUNT(DISTINCT primary_lifetime_guest_profile_id)
      comment: "Total number of distinct guests with LTV records. Baseline denominator for LTV coverage and penetration metrics."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest visit metrics capturing visit volume, channel mix, and loyalty engagement at the visit level. Used by operations, marketing, and executive teams to track traffic trends, channel performance, and loyalty-driven visit behavior."
  source: "`restaurants_ecm`.`guest`.`visit`"
  dimensions:
    - name: "unit_id"
      expr: unit_id
      comment: "Restaurant unit where the visit occurred. Enables location-level traffic analysis."
    - name: "digital_account_id"
      expr: digital_account_id
      comment: "Digital account associated with the visit. Used to distinguish digital vs. non-digital guest visits."
    - name: "loyalty_member_id"
      expr: loyalty_member_id
      comment: "Loyalty member associated with the visit. Used to measure loyalty-driven visit volume."
    - name: "shift_id"
      expr: shift_id
      comment: "Shift during which the visit occurred. Enables daypart and labor-period traffic analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(DISTINCT visit_id)
      comment: "Total number of distinct guest visits. Primary traffic KPI used to track footfall trends across units and time periods."
    - name: "unique_guests_visited"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests who visited. Measures reach and breadth of guest engagement, distinct from raw visit volume."
    - name: "loyalty_visits"
      expr: COUNT(DISTINCT CASE WHEN loyalty_member_id IS NOT NULL THEN visit_id END)
      comment: "Number of visits attributed to loyalty program members. Measures loyalty program's contribution to total traffic."
    - name: "digital_visits"
      expr: COUNT(DISTINCT CASE WHEN digital_account_id IS NOT NULL THEN visit_id END)
      comment: "Number of visits associated with a digital account. Tracks digital channel engagement and app-driven traffic."
    - name: "visits_with_order"
      expr: COUNT(DISTINCT CASE WHEN guest_order_id IS NOT NULL THEN visit_id END)
      comment: "Number of visits that resulted in a recorded order. Measures visit-to-transaction conversion at the unit level."
    - name: "loyalty_visit_rate"
      expr: COUNT(DISTINCT CASE WHEN loyalty_member_id IS NOT NULL THEN visit_id END)
      comment: "Raw count of loyalty visits used as numerator for loyalty visit penetration analysis. Pair with total_visits for rate calculation in BI."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction survey metrics measuring survey response volume, completion rates, and satisfaction signal distribution across brands, units, and dayparts. Used by operations, franchise management, and CX leadership to monitor guest experience quality and identify service gaps."
  source: "`restaurants_ecm`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the satisfaction survey. Enables brand-level CX benchmarking."
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey administered (e.g., post-visit, delivery, digital). Segments satisfaction data by survey methodology."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the surveyed visit occurred (e.g., breakfast, lunch, dinner). Identifies time-of-day service quality patterns."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the survey was delivered (e.g., email, SMS, in-app). Used to assess survey channel effectiveness."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the survey was completed, partially completed, or abandoned. Key input to response rate analysis."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Operational status of the survey record (e.g., active, closed). Used to filter to valid survey responses."
    - name: "visit_date"
      expr: visit_date
      comment: "Date of the visit associated with the survey. Enables time-series trending of satisfaction scores."
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed. Used for localization analysis and ensuring representative sampling."
    - name: "nps_score"
      expr: nps_score
      comment: "Net Promoter Score response value. Dimension for distribution analysis of promoter, passive, and detractor segments."
    - name: "csat_score"
      expr: csat_score
      comment: "Customer Satisfaction Score response value. Dimension for satisfaction distribution analysis."
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(DISTINCT satisfaction_survey_id)
      comment: "Total number of satisfaction surveys sent. Baseline measure for survey program reach and volume."
    - name: "completed_surveys"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END)
      comment: "Number of fully completed surveys. Numerator for survey completion rate, a key indicator of guest engagement with feedback programs."
    - name: "surveys_with_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_given = TRUE THEN satisfaction_survey_id END)
      comment: "Number of surveys where the guest provided data consent. Measures compliance-eligible survey volume for regulatory and privacy reporting."
    - name: "promoter_responses"
      expr: COUNT(DISTINCT CASE WHEN nps_score IN ('9', '10') THEN satisfaction_survey_id END)
      comment: "Number of survey responses with NPS scores of 9 or 10 (promoters). Used to calculate NPS promoter share and track brand advocacy."
    - name: "detractor_responses"
      expr: COUNT(DISTINCT CASE WHEN nps_score IN ('0', '1', '2', '3', '4', '5', '6') THEN satisfaction_survey_id END)
      comment: "Number of survey responses with NPS scores of 0–6 (detractors). Used to calculate NPS detractor share and identify at-risk guest relationships."
    - name: "unique_guests_surveyed"
      expr: COUNT(DISTINCT primary_satisfaction_guest_profile_id)
      comment: "Number of distinct guests who received a satisfaction survey. Measures survey program coverage relative to the total guest base."
    - name: "surveys_linked_to_orders"
      expr: COUNT(DISTINCT CASE WHEN guest_order_id IS NOT NULL THEN satisfaction_survey_id END)
      comment: "Number of surveys linked to a specific guest order. Measures the proportion of satisfaction feedback that can be tied to a transaction for root-cause analysis."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint metrics tracking complaint volume, escalation rates, resolution performance, and financial remediation costs. Used by operations, franchise management, and quality assurance leadership to monitor service recovery effectiveness and identify systemic issues."
  source: "`restaurants_ecm`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the complaint (e.g., food quality, service, cleanliness). Primary dimension for root-cause analysis of guest dissatisfaction."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., open, resolved, escalated). Used to track complaint pipeline and resolution backlog."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint (e.g., low, medium, high, critical). Drives prioritization of complaint handling resources."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution applied (e.g., refund, replacement, apology). Used to analyze resolution strategy effectiveness."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Whether the complaint has been resolved. Key dimension for measuring service recovery completion rates."
    - name: "channel"
      expr: channel
      comment: "Channel through which the complaint was submitted (e.g., in-store, app, phone, social). Identifies complaint intake channel patterns."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the complaint was escalated. Used to measure escalation rate as a proxy for unresolved service failures."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which resolution amounts are denominated. Required for multi-currency financial analysis of complaint costs."
    - name: "complaint_timestamp"
      expr: complaint_timestamp
      comment: "Timestamp when the complaint was filed. Used for time-series trending of complaint volume and response time analysis."
  measures:
    - name: "total_complaints"
      expr: COUNT(DISTINCT complaint_id)
      comment: "Total number of distinct guest complaints filed. Primary KPI for monitoring guest dissatisfaction volume and service quality trends."
    - name: "escalated_complaints"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints that were escalated. Measures the volume of unresolved or high-severity service failures requiring management intervention."
    - name: "resolved_complaints"
      expr: COUNT(DISTINCT CASE WHEN resolution_status = 'resolved' THEN complaint_id END)
      comment: "Number of complaints that have been resolved. Numerator for complaint resolution rate, a key service recovery KPI."
    - name: "total_resolution_cost"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total financial cost of complaint resolutions (refunds, replacements, etc.). Measures the direct financial impact of service failures on the business."
    - name: "avg_resolution_cost"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average resolution cost per complaint. Benchmarks the cost of service recovery and informs resolution policy decisions."
    - name: "unique_guests_complained"
      expr: COUNT(DISTINCT complaint_guest_profile_id)
      comment: "Number of distinct guests who filed at least one complaint. Used to measure complaint incidence rate relative to the active guest base."
    - name: "high_severity_complaints"
      expr: COUNT(DISTINCT CASE WHEN severity_level IN ('high', 'critical') THEN complaint_id END)
      comment: "Number of complaints classified as high or critical severity. Tracks the volume of complaints most likely to drive guest churn and brand damage."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_digital_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Digital account metrics measuring digital channel adoption, account health, security posture, and marketing consent across the guest base. Used by digital product, marketing, and security teams to track app engagement, account quality, and consent compliance."
  source: "`restaurants_ecm`.`guest`.`digital_account`"
  dimensions:
    - name: "digital_account_status"
      expr: digital_account_status
      comment: "Current status of the digital account (e.g., active, suspended, locked). Used to segment the healthy vs. at-risk digital account base."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier of the digital account (e.g., standard, premium). Used for value-based segmentation of the digital guest base."
    - name: "registration_channel"
      expr: registration_channel
      comment: "Channel through which the digital account was registered (e.g., app, web, in-store kiosk). Measures digital acquisition channel effectiveness."
    - name: "device_type"
      expr: device_type
      comment: "Type of device used for the digital account (e.g., iOS, Android, web). Informs platform investment and UX prioritization."
    - name: "two_factor_enabled"
      expr: two_factor_enabled
      comment: "Whether two-factor authentication is enabled on the account. Measures security posture of the digital account base."
    - name: "consent_marketing"
      expr: consent_marketing
      comment: "Whether the digital account holder has consented to marketing. Defines the digitally reachable marketing audience."
    - name: "privacy_opt_out"
      expr: privacy_opt_out
      comment: "Whether the guest has opted out of data privacy sharing. Critical for compliance and addressable audience sizing."
    - name: "effective_from"
      expr: effective_from
      comment: "Date from which the digital account became effective. Used for cohort analysis of digital account activations."
  measures:
    - name: "total_digital_accounts"
      expr: COUNT(DISTINCT digital_account_id)
      comment: "Total number of distinct digital accounts. Measures the size of the digital guest base and app adoption."
    - name: "active_digital_accounts"
      expr: COUNT(DISTINCT CASE WHEN digital_account_status = 'active' THEN digital_account_id END)
      comment: "Number of currently active digital accounts. Core KPI for digital channel health and active user base sizing."
    - name: "marketing_consented_accounts"
      expr: COUNT(DISTINCT CASE WHEN consent_marketing = TRUE THEN digital_account_id END)
      comment: "Number of digital accounts with marketing consent. Defines the digitally addressable marketing audience for campaign planning."
    - name: "two_factor_enabled_accounts"
      expr: COUNT(DISTINCT CASE WHEN two_factor_enabled = TRUE THEN digital_account_id END)
      comment: "Number of digital accounts with two-factor authentication enabled. Measures security adoption rate across the digital guest base."
    - name: "privacy_opted_out_accounts"
      expr: COUNT(DISTINCT CASE WHEN privacy_opt_out = TRUE THEN digital_account_id END)
      comment: "Number of digital accounts where the guest has opted out of data privacy sharing. Tracks privacy opt-out volume for compliance monitoring."
    - name: "locked_accounts"
      expr: COUNT(DISTINCT CASE WHEN lockout_timestamp IS NOT NULL THEN digital_account_id END)
      comment: "Number of digital accounts that have been locked out. Measures account security incidents and potential friction in the digital guest experience."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent metrics tracking consent coverage, type distribution, channel opt-in rates, and consent expiry risk across the guest base. Used by legal, compliance, and marketing teams to ensure regulatory adherence (GDPR, CCPA) and maintain a compliant addressable audience."
  source: "`restaurants_ecm`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent recorded (e.g., marketing, data processing, third-party sharing). Primary dimension for consent coverage analysis by purpose."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g., active, revoked, expired). Used to measure the live consented audience."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (e.g., explicit opt-in, implied, double opt-in). Informs compliance posture and consent quality."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was collected (e.g., app, web, in-store). Used to analyze consent acquisition channel effectiveness."
    - name: "data_processing_scope"
      expr: data_processing_scope
      comment: "Scope of data processing covered by the consent (e.g., analytics, personalization, advertising). Required for GDPR purpose-limitation compliance."
    - name: "email_consent"
      expr: email_consent
      comment: "Whether the guest has consented to email communications. Defines the email-reachable consented audience."
    - name: "sms_consent"
      expr: sms_consent
      comment: "Whether the guest has consented to SMS communications. Defines the SMS-reachable consented audience."
    - name: "marketing_consent"
      expr: marketing_consent
      comment: "Whether the guest has consented to marketing use of their data. Core compliance dimension for campaign audience qualification."
    - name: "consent_expiry_date"
      expr: consent_expiry_date
      comment: "Date on which the consent record expires. Used to identify consents approaching expiry requiring renewal outreach."
    - name: "brand_id"
      expr: brand_id
      comment: "Brand associated with the consent record. Enables brand-level consent compliance reporting."
  measures:
    - name: "total_consent_records"
      expr: COUNT(DISTINCT consent_record_id)
      comment: "Total number of distinct consent records. Baseline measure for consent program coverage and data governance reporting."
    - name: "active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Number of currently active consent records. Defines the live consented audience for compliant data processing and marketing."
    - name: "revoked_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END)
      comment: "Number of consent records that have been revoked. Tracks consent withdrawal volume, a key regulatory risk indicator."
    - name: "marketing_consented_guests"
      expr: COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN primary_consent_guest_profile_id END)
      comment: "Number of distinct guests with active marketing consent. Defines the compliant addressable audience for marketing campaigns."
    - name: "email_consented_guests"
      expr: COUNT(DISTINCT CASE WHEN email_consent = TRUE THEN primary_consent_guest_profile_id END)
      comment: "Number of distinct guests with email consent. Measures the email-reachable compliant audience size."
    - name: "third_party_consented_guests"
      expr: COUNT(DISTINCT CASE WHEN third_party_consent = TRUE THEN primary_consent_guest_profile_id END)
      comment: "Number of distinct guests who have consented to third-party data sharing. Critical for partnership and data monetization compliance."
    - name: "expiring_consents_90d"
      expr: COUNT(DISTINCT CASE WHEN consent_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND consent_status = 'active' THEN consent_record_id END)
      comment: "Number of active consent records expiring within the next 90 days. Proactive compliance KPI to trigger consent renewal campaigns before expiry."
$$;

CREATE OR REPLACE VIEW `restaurants_ecm`.`_metrics`.`guest_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest preference metrics measuring dietary, allergen, and communication preference coverage across the guest base. Used by menu planning, marketing, and CRM teams to personalize guest experiences, ensure allergen safety compliance, and optimize communication channel strategies."
  source: "`restaurants_ecm`.`guest`.`preference`"
  dimensions:
    - name: "preference_type"
      expr: preference_type
      comment: "Type of preference recorded (e.g., dietary, communication, payment). Primary dimension for preference category analysis."
    - name: "preference_status"
      expr: preference_status
      comment: "Current status of the preference record (e.g., active, inactive). Used to filter to current, actionable preferences."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Whether the guest follows a vegan diet. Used to size the vegan guest segment for menu and marketing decisions."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Whether the guest follows a vegetarian diet. Used to size the vegetarian guest segment."
    - name: "is_halal"
      expr: is_halal
      comment: "Whether the guest requires halal food. Used to size the halal-requirement segment for menu compliance and location planning."
    - name: "is_kosher"
      expr: is_kosher
      comment: "Whether the guest requires kosher food. Used to size the kosher-requirement segment."
    - name: "has_nut_allergy"
      expr: has_nut_allergy
      comment: "Whether the guest has a nut allergy. Critical for allergen safety compliance and menu personalization."
    - name: "has_dairy_allergy"
      expr: has_dairy_allergy
      comment: "Whether the guest has a dairy allergy. Critical for allergen safety compliance."
    - name: "has_gluten_allergy"
      expr: has_gluten_allergy
      comment: "Whether the guest has a gluten allergy. Critical for allergen safety compliance."
    - name: "preferred_service_channel"
      expr: preferred_service_channel
      comment: "Guest's preferred service channel (e.g., dine-in, drive-through, delivery). Informs channel capacity planning and personalization."
    - name: "preferred_daypart"
      expr: preferred_daypart
      comment: "Guest's preferred visit daypart (e.g., breakfast, lunch, dinner). Used for daypart-targeted marketing and operational planning."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing via their preference record. Used to cross-validate marketing consent coverage."
    - name: "communication_channel_preference"
      expr: communication_channel_preference
      comment: "Guest's preferred communication channel (e.g., email, SMS, push). Drives channel strategy for CRM and campaign execution."
  measures:
    - name: "total_preference_records"
      expr: COUNT(DISTINCT preference_id)
      comment: "Total number of distinct guest preference records. Baseline measure for preference data coverage across the guest base."
    - name: "guests_with_dietary_preferences"
      expr: COUNT(DISTINCT CASE WHEN is_vegan = TRUE OR is_vegetarian = TRUE OR is_halal = TRUE OR is_kosher = TRUE THEN preference_guest_profile_id END)
      comment: "Number of distinct guests with at least one dietary preference recorded. Measures the size of the dietary-preference guest segment requiring menu personalization."
    - name: "guests_with_allergen_flags"
      expr: COUNT(DISTINCT CASE WHEN has_nut_allergy = TRUE OR has_dairy_allergy = TRUE OR has_gluten_allergy = TRUE THEN preference_guest_profile_id END)
      comment: "Number of distinct guests with at least one allergen flag. Critical safety KPI for measuring the at-risk guest population requiring allergen-safe menu options."
    - name: "marketing_opted_in_guests"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN preference_guest_profile_id END)
      comment: "Number of distinct guests who have opted into marketing via their preference record. Measures the preference-layer marketing reachable audience."
    - name: "active_preference_records"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN preference_id END)
      comment: "Number of currently active preference records. Measures the volume of actionable, current guest preferences available for personalization."
    - name: "vegan_guest_count"
      expr: COUNT(DISTINCT CASE WHEN is_vegan = TRUE THEN preference_guest_profile_id END)
      comment: "Number of distinct guests with a vegan dietary preference. Used to size the vegan segment for menu development and targeted marketing investment."
    - name: "halal_guest_count"
      expr: COUNT(DISTINCT CASE WHEN is_halal = TRUE THEN preference_guest_profile_id END)
      comment: "Number of distinct guests requiring halal food. Used for location-level halal compliance planning and menu certification decisions."
$$;