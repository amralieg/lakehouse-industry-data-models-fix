-- Metric views for domain: guest | Business: Restaurants | Version: 2 | Generated on: 2026-06-22 15:12:58

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest profile metrics tracking acquisition, engagement, lifetime value, and consent health across the guest base. Used by CRM, marketing, and loyalty teams to steer guest strategy."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "guest_type"
      expr: guest_type
      comment: "Classification of guest (e.g., loyalty member, anonymous, corporate) for segmentation analysis."
    - name: "profile_status"
      expr: profile_status
      comment: "Current lifecycle status of the guest profile (active, inactive, merged, suppressed)."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Guest preferred language for localization and communication targeting."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier derived from the profile record, used to segment high-value guests."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the guest has opted into marketing communications — critical for reachable audience sizing."
    - name: "data_source"
      expr: data_source
      comment: "Origin system of the guest profile (POS, app, web, third-party) for data quality and channel attribution."
    - name: "country_code"
      expr: country_code
      comment: "Guest country for geographic segmentation and regulatory compliance scoping."
    - name: "gender"
      expr: gender
      comment: "Guest gender for demographic analysis and personalization."
    - name: "primary_contact_method"
      expr: primary_contact_method
      comment: "Preferred contact channel (email, SMS, push) for communication effectiveness analysis."
  measures:
    - name: "total_active_guests"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Count of distinct active guest profiles. Core audience size KPI used by marketing and CRM to size reachable base."
    - name: "total_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Total distinct guest profiles regardless of status. Used to track overall database growth."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests opted into marketing. Directly drives reachable audience size and campaign ROI potential."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_spent AS DOUBLE))
      comment: "Sum of all guest lifetime spend across the portfolio. Primary revenue attribution metric for the guest base."
    - name: "avg_lifetime_spend_per_guest"
      expr: AVG(CAST(total_spent AS DOUBLE))
      comment: "Average lifetime spend per guest profile. Benchmarks guest value and informs acquisition cost thresholds."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average transaction check value across guest profiles. Indicates spending behavior and upsell opportunity."
    - name: "total_lifetime_visits"
      expr: SUM(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Total cumulative visits across all guest profiles. Measures engagement depth and frequency at portfolio level."
    - name: "avg_visits_per_guest"
      expr: AVG(CAST(total_lifetime_visits AS DOUBLE))
      comment: "Average number of visits per guest. Key retention and frequency metric used in loyalty and CRM strategy."
    - name: "loyalty_enrolled_guest_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_program_id IS NOT NULL THEN profile_id END)
      comment: "Number of guests enrolled in a loyalty program. Tracks loyalty penetration of the guest base."
    - name: "loyalty_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_program_id IS NOT NULL THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guest profiles enrolled in loyalty. Strategic KPI for loyalty program growth and guest engagement."
    - name: "consent_email_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_email = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests with email consent. Governs email campaign reachability and regulatory compliance posture."
    - name: "consent_sms_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_sms = TRUE THEN profile_id END) / NULLIF(COUNT(DISTINCT profile_id), 0), 2)
      comment: "Percentage of guests with SMS consent. Governs SMS campaign reachability and compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest visit frequency, spend, and satisfaction metrics. Used by operations, marketing, and loyalty teams to understand visit behavior, dwell time, and per-visit economics."
  source: "`vibe_restaurants_v1`.`guest`.`guest_visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (dine-in, drive-thru, delivery, takeout) for channel-level visit analysis."
    - name: "visit_channel"
      expr: visit_channel
      comment: "Channel through which the visit occurred, enabling omnichannel visit frequency analysis."
    - name: "daypart"
      expr: daypart
      comment: "Time-of-day segment (breakfast, lunch, dinner, late-night) for daypart visit distribution analysis."
    - name: "visit_date"
      expr: DATE_TRUNC('day', visit_date)
      comment: "Visit date truncated to day for daily visit trend analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Visit month for monthly trend and seasonality analysis."
    - name: "is_first_visit"
      expr: is_first_visit
      comment: "Flag indicating whether this was the guest's first visit. Used to track new guest acquisition."
    - name: "is_repeat_visit"
      expr: is_repeat_visit
      comment: "Flag indicating a repeat visit. Used to measure retention and loyalty behavior."
    - name: "channel"
      expr: channel
      comment: "Order channel associated with the visit for cross-channel visit analysis."
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of guest visits. Fundamental traffic volume KPI for operations and marketing."
    - name: "unique_visiting_guests"
      expr: COUNT(DISTINCT profile_id)
      comment: "Count of distinct guests who visited. Measures reach and active guest base size."
    - name: "first_visit_count"
      expr: COUNT(DISTINCT CASE WHEN is_first_visit = TRUE THEN guest_visit_id END)
      comment: "Number of first-time guest visits. Tracks new guest acquisition through visit behavior."
    - name: "repeat_visit_count"
      expr: COUNT(DISTINCT CASE WHEN is_repeat_visit = TRUE THEN guest_visit_id END)
      comment: "Number of repeat visits. Core retention metric indicating guest loyalty and frequency."
    - name: "repeat_visit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_repeat_visit = TRUE THEN guest_visit_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of visits that are repeat visits. Key retention KPI used in loyalty and CRM strategy."
    - name: "total_visit_spend"
      expr: SUM(CAST(spend_amount AS DOUBLE))
      comment: "Total spend across all guest visits. Primary revenue contribution metric from visit-level data."
    - name: "avg_spend_per_visit"
      expr: AVG(CAST(spend_amount AS DOUBLE))
      comment: "Average spend per guest visit. Benchmarks per-visit economics and informs upsell strategy."
    - name: "avg_check_amount"
      expr: AVG(CAST(check_amount AS DOUBLE))
      comment: "Average check amount per visit. Tracks ticket size trends and menu mix effectiveness."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average guest satisfaction score per visit. Directly tied to guest retention and brand health."
    - name: "avg_party_size"
      expr: AVG(CAST(party_size AS DOUBLE))
      comment: "Average party size per visit. Informs table capacity planning and per-cover revenue calculations."
    - name: "avg_dwell_time_minutes"
      expr: AVG(CAST(dwell_minutes AS DOUBLE))
      comment: "Average dwell time in minutes per visit. Operational KPI for table turn management and throughput optimization."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_lifetime_value`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest lifetime value metrics tracking historical spend, predicted future value, and visit frequency. Used by finance, marketing, and loyalty leadership to prioritize high-value guest investment."
  source: "`vibe_restaurants_v1`.`guest`.`lifetime_value`"
  dimensions:
    - name: "ltv_tier"
      expr: ltv_tier
      comment: "LTV tier classification (e.g., platinum, gold, silver, bronze) for value-based segmentation."
    - name: "ltv_status"
      expr: ltv_status
      comment: "Current LTV calculation status (active, lapsed, churned) for lifecycle segmentation."
    - name: "loyalty_member_flag"
      expr: loyalty_member_flag
      comment: "Whether the guest is a loyalty member. Enables comparison of LTV between loyalty and non-loyalty guests."
    - name: "segment"
      expr: segment
      comment: "Guest segment label from LTV model for strategic cohort analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of LTV calculations for multi-market financial reporting."
    - name: "ltv_calculation_date"
      expr: DATE_TRUNC('month', ltv_calculation_date)
      comment: "Month of LTV calculation for trend analysis of portfolio value over time."
    - name: "data_refresh_cycle"
      expr: data_refresh_cycle
      comment: "Frequency of LTV model refresh (daily, weekly, monthly) for data freshness governance."
  measures:
    - name: "total_historical_spend"
      expr: SUM(CAST(total_historical_spend AS DOUBLE))
      comment: "Total realized lifetime spend across all guests. Primary portfolio revenue attribution metric."
    - name: "avg_historical_spend_per_guest"
      expr: AVG(CAST(total_historical_spend AS DOUBLE))
      comment: "Average historical lifetime spend per guest. Benchmarks guest value for acquisition cost and retention investment decisions."
    - name: "total_predicted_future_value"
      expr: SUM(CAST(predicted_future_value AS DOUBLE))
      comment: "Sum of predicted future value across all guests. Forward-looking revenue potential used in investment planning."
    - name: "avg_predicted_future_value"
      expr: AVG(CAST(predicted_future_value AS DOUBLE))
      comment: "Average predicted future value per guest. Informs retention investment thresholds and loyalty tier design."
    - name: "total_visits"
      expr: SUM(CAST(total_visits AS DOUBLE))
      comment: "Total cumulative visits across all guest LTV records. Measures engagement depth at portfolio level."
    - name: "avg_visits_per_guest"
      expr: AVG(CAST(total_visits AS DOUBLE))
      comment: "Average total visits per guest. Key frequency metric for loyalty and retention strategy."
    - name: "avg_check_value"
      expr: AVG(CAST(average_check_value AS DOUBLE))
      comment: "Average check value per guest from LTV model. Tracks per-transaction spend trends."
    - name: "avg_transactions_per_month"
      expr: AVG(CAST(average_transactions_per_month AS DOUBLE))
      comment: "Average monthly transaction frequency per guest. Core visit frequency KPI for loyalty program design."
    - name: "loyalty_member_ltv_total"
      expr: SUM(CAST(CASE WHEN loyalty_member_flag = TRUE THEN total_historical_spend ELSE 0 END AS DOUBLE))
      comment: "Total historical spend from loyalty members only. Quantifies the revenue contribution of the loyalty program."
    - name: "non_loyalty_ltv_total"
      expr: SUM(CAST(CASE WHEN loyalty_member_flag = FALSE THEN total_historical_spend ELSE 0 END AS DOUBLE))
      comment: "Total historical spend from non-loyalty guests. Identifies revenue at risk and loyalty enrollment opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_satisfaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and NPS metrics from post-visit surveys. Used by operations, brand, and franchise leadership to monitor guest experience quality and identify service recovery needs."
  source: "`vibe_restaurants_v1`.`guest`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (post-visit, delivery, catering, digital) for channel-specific satisfaction analysis."
    - name: "satisfaction_survey_status"
      expr: satisfaction_survey_status
      comment: "Survey completion status (completed, partial, abandoned) for response quality filtering."
    - name: "daypart"
      expr: daypart
      comment: "Daypart during which the surveyed visit occurred for time-of-day satisfaction analysis."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel through which the survey was delivered (email, SMS, in-app, kiosk)."
    - name: "visit_date"
      expr: DATE_TRUNC('day', visit_date)
      comment: "Date of the visit associated with the survey for daily satisfaction trend analysis."
    - name: "visit_month"
      expr: DATE_TRUNC('month', visit_date)
      comment: "Month of the visit for monthly satisfaction trend and seasonality analysis."
    - name: "language"
      expr: language
      comment: "Language in which the survey was completed for multilingual market analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Whether the survey was fully completed, used to filter for valid responses."
  measures:
    - name: "total_surveys_sent"
      expr: COUNT(1)
      comment: "Total number of surveys sent. Baseline for response rate calculation and survey program reach."
    - name: "total_surveys_completed"
      expr: COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END)
      comment: "Number of fully completed surveys. Determines valid sample size for satisfaction scoring."
    - name: "survey_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN completion_status = 'completed' THEN satisfaction_survey_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surveys completed. Measures survey program effectiveness and guest engagement with feedback."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction (CSAT) score. Primary guest experience KPI used in brand and operations reviews."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score (NPS). Strategic brand health metric used in board and investor reporting."
    - name: "promoter_count"
      expr: COUNT(DISTINCT CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END)
      comment: "Number of promoter responses (NPS 9-10). Used to calculate NPS and identify brand advocates."
    - name: "detractor_count"
      expr: COUNT(DISTINCT CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)
      comment: "Number of detractor responses (NPS 0-6). Identifies at-risk guests requiring service recovery."
    - name: "net_promoter_score"
      expr: ROUND(100.0 * (COUNT(DISTINCT CASE WHEN nps_score >= 9 THEN satisfaction_survey_id END) - COUNT(DISTINCT CASE WHEN nps_score <= 6 THEN satisfaction_survey_id END)) / NULLIF(COUNT(DISTINCT CASE WHEN nps_score IS NOT NULL THEN satisfaction_survey_id END), 0), 2)
      comment: "Calculated NPS as (Promoters - Detractors) / Total respondents * 100. The definitive brand loyalty metric."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest complaint volume, severity, resolution, and escalation metrics. Used by operations, food safety, and guest relations leadership to manage service recovery and identify systemic quality issues."
  source: "`vibe_restaurants_v1`.`guest`.`complaint`"
  dimensions:
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of complaint (food quality, service, cleanliness, order accuracy) for root cause analysis."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the complaint for prioritization and escalation management."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current resolution status of the complaint (open, in-progress, resolved, closed)."
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided (refund, replacement, apology, voucher) for resolution effectiveness analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the complaint was received (in-store, phone, app, social media)."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated. Used to track escalation rates and identify high-severity patterns."
    - name: "complaint_month"
      expr: DATE_TRUNC('month', CAST(complaint_timestamp AS DATE))
      comment: "Month of complaint for trend analysis and seasonal pattern identification."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Final resolution status for tracking complaint closure rates."
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of guest complaints. Baseline volume metric for service quality monitoring."
    - name: "escalated_complaint_count"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN complaint_id END)
      comment: "Number of escalated complaints. High escalation rates signal systemic service failures requiring leadership intervention."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that were escalated. Key service quality KPI used in operations reviews."
    - name: "resolved_complaint_count"
      expr: COUNT(DISTINCT CASE WHEN resolution_status = 'resolved' THEN complaint_id END)
      comment: "Number of complaints successfully resolved. Measures service recovery effectiveness."
    - name: "resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN resolution_status = 'resolved' THEN complaint_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints resolved. Core service recovery KPI for guest relations and operations."
    - name: "total_resolution_amount"
      expr: SUM(CAST(resolution_amount AS DOUBLE))
      comment: "Total monetary value of complaint resolutions (refunds, vouchers). Tracks financial cost of service failures."
    - name: "avg_resolution_amount"
      expr: AVG(CAST(resolution_amount AS DOUBLE))
      comment: "Average resolution amount per complaint. Benchmarks cost-per-complaint for service recovery budget planning."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average CSAT score from complaint records. Measures satisfaction with the complaint resolution process."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS from complaint records. Tracks whether complaint handling converts detractors to promoters."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment health, size, and refresh metrics. Used by marketing and CRM teams to manage audience segmentation quality, dynamic segment performance, and targeting effectiveness."
  source: "`vibe_restaurants_v1`.`guest`.`guest_segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (behavioral, demographic, value-based, predictive) for segmentation strategy analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the segment is currently active. Used to filter for live segments in campaign targeting."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Whether the segment is dynamically refreshed vs. static. Informs segment maintenance and data freshness."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How often the segment is refreshed (real-time, daily, weekly) for data currency governance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the segment became effective for cohort and vintage analysis."
    - name: "segment_name"
      expr: segment_name
      comment: "Business name of the segment for reporting and dashboard labeling."
  measures:
    - name: "total_active_segments"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN guest_segment_id END)
      comment: "Number of active guest segments. Tracks segmentation portfolio breadth for marketing targeting."
    - name: "total_segments"
      expr: COUNT(DISTINCT guest_segment_id)
      comment: "Total number of guest segments defined. Measures segmentation model coverage."
    - name: "dynamic_segment_count"
      expr: COUNT(DISTINCT CASE WHEN is_dynamic = TRUE THEN guest_segment_id END)
      comment: "Number of dynamically refreshed segments. Tracks real-time personalization capability."
    - name: "dynamic_segment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_dynamic = TRUE THEN guest_segment_id END) / NULLIF(COUNT(DISTINCT guest_segment_id), 0), 2)
      comment: "Percentage of segments that are dynamic. Measures sophistication of the segmentation infrastructure."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest segment membership metrics tracking assignment rates, confidence scores, and membership health. Used by marketing and data science teams to evaluate segmentation model quality and audience composition."
  source: "`vibe_restaurants_v1`.`guest`.`guest_segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership (active, expired, removed) for active audience sizing."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the guest to the segment (rule-based, ML model, manual) for model attribution."
    - name: "assignment_source"
      expr: assignment_source
      comment: "Source system that triggered the segment assignment for data lineage and quality governance."
    - name: "is_active"
      expr: is_active
      comment: "Whether the membership is currently active. Used to filter for live audience members."
    - name: "joined_date"
      expr: DATE_TRUNC('month', joined_date)
      comment: "Month the guest joined the segment for cohort and vintage analysis."
    - name: "membership_source"
      expr: membership_source
      comment: "Source of the membership record for data provenance tracking."
  measures:
    - name: "total_active_memberships"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN guest_segment_membership_id END)
      comment: "Total active segment memberships. Measures live audience size across all segments."
    - name: "unique_guests_in_segments"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests assigned to at least one segment. Measures segmentation coverage of the guest base."
    - name: "avg_confidence_score"
      expr: AVG(CAST(confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments. Measures segmentation model precision and reliability."
    - name: "avg_membership_score"
      expr: AVG(CAST(membership_score AS DOUBLE))
      comment: "Average membership score across all assignments. Tracks overall segment fit quality."
    - name: "high_confidence_membership_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN confidence_score >= 0.8 THEN guest_segment_membership_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of memberships with high confidence scores (>=0.8). Measures segmentation model quality."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest consent health metrics tracking opt-in rates, consent coverage, and regulatory compliance posture. Used by legal, privacy, and marketing teams to ensure compliant audience management."
  source: "`vibe_restaurants_v1`.`guest`.`consent_record`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent (marketing, analytics, third-party sharing) for consent category analysis."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (active, revoked, expired) for compliance posture monitoring."
    - name: "consent_purpose"
      expr: consent_purpose
      comment: "Business purpose for which consent was obtained for regulatory reporting."
    - name: "consent_source_channel"
      expr: consent_source_channel
      comment: "Channel through which consent was collected (app, web, in-store, call center)."
    - name: "consent_method"
      expr: consent_method
      comment: "Method of consent collection (explicit opt-in, double opt-in, implied) for compliance audit."
    - name: "consent_month"
      expr: DATE_TRUNC('month', consent_timestamp)
      comment: "Month consent was recorded for trend analysis of consent collection rates."
    - name: "data_processing_scope"
      expr: data_processing_scope
      comment: "Scope of data processing covered by the consent for GDPR/CCPA compliance reporting."
  measures:
    - name: "total_active_consents"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN consent_record_id END)
      comment: "Total active consent records. Defines the legally reachable audience for marketing and data processing."
    - name: "total_consents"
      expr: COUNT(1)
      comment: "Total consent records across all statuses. Baseline for consent coverage and compliance reporting."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with marketing opt-in. Governs reachable marketing audience size."
    - name: "email_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN email_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with email opt-in. Directly determines email campaign audience size."
    - name: "sms_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sms_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consent records with SMS opt-in. Determines SMS campaign audience size."
    - name: "revoked_consent_count"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END)
      comment: "Number of revoked consents. Tracks opt-out volume and regulatory compliance risk."
    - name: "consent_revocation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_status = 'revoked' THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of consents that have been revoked. Rising revocation rates signal brand trust or communication fatigue issues."
    - name: "third_party_consent_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN third_party_consent = TRUE THEN consent_record_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests consenting to third-party data sharing. Critical for data monetization and partnership compliance."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_allergen_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest allergen profile metrics tracking allergen prevalence, severity, and verification rates. Used by food safety, operations, and menu teams to manage allergen risk and ensure guest safety."
  source: "`vibe_restaurants_v1`.`guest`.`profile`"
  dimensions:
    - name: "All Records"
      expr: "1"
  measures:
    - name: "total_allergen_profiles"
      expr: COUNT(1)
      comment: "Total allergen profile records. Baseline for allergen prevalence analysis across the guest base."
    - name: "unique_guests_with_allergens"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests with at least one allergen profile. Measures allergen risk exposure in the guest base."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_identity_resolution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity resolution quality metrics tracking match confidence, duplicate detection, and golden record rates. Used by data governance and CRM teams to ensure a clean, unified guest identity foundation."
  source: "`vibe_restaurants_v1`.`guest`.`identity_resolution`"
  dimensions:
    - name: "match_method"
      expr: match_method
      comment: "Method used for identity matching (deterministic, probabilistic, hybrid) for model attribution."
    - name: "guest_status"
      expr: guest_status
      comment: "Current guest status in the identity graph (active, merged, suppressed) for lifecycle analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Guest lifecycle stage (new, active, lapsed, churned) for retention and reactivation analysis."
    - name: "golden_record_flag"
      expr: golden_record_flag
      comment: "Whether this record is the golden (master) record for the guest. Used to measure MDM quality."
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Whether this record is identified as a duplicate. Used to track data quality and deduplication progress."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier from identity resolution for value-based segmentation."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred communication channel for channel strategy analysis."
  measures:
    - name: "total_identity_records"
      expr: COUNT(1)
      comment: "Total identity resolution records. Baseline for identity graph size and coverage."
    - name: "golden_record_count"
      expr: COUNT(DISTINCT CASE WHEN golden_record_flag = TRUE THEN identity_resolution_id END)
      comment: "Number of golden (master) guest records. Measures the size of the unified guest identity base."
    - name: "duplicate_record_count"
      expr: COUNT(DISTINCT CASE WHEN duplicate_flag = TRUE THEN identity_resolution_id END)
      comment: "Number of identified duplicate records. Tracks data quality debt in the identity graph."
    - name: "duplicate_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN duplicate_flag = TRUE THEN identity_resolution_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of identity records flagged as duplicates. Key MDM data quality KPI — high rates indicate identity resolution failures."
    - name: "avg_match_confidence_score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average confidence score of identity matches. Measures identity resolution model precision."
    - name: "avg_total_lifetime_spend"
      expr: AVG(CAST(total_lifetime_spend AS DOUBLE))
      comment: "Average lifetime spend per resolved identity. Benchmarks guest value from the unified identity perspective."
    - name: "total_lifetime_spend"
      expr: SUM(CAST(total_lifetime_spend AS DOUBLE))
      comment: "Total lifetime spend across all resolved identities. Portfolio-level revenue attribution from the identity graph."
$$;

CREATE OR REPLACE VIEW `vibe_restaurants_v1`.`_metrics`.`guest_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest communication delivery, engagement, and suppression metrics. Used by marketing and CRM teams to optimize channel performance, deliverability, and guest communication health."
  source: "`vibe_restaurants_v1`.`guest`.`communication`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel (email, SMS, push, in-app) for channel-level performance analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the communication (delivered, bounced, failed) for deliverability monitoring."
    - name: "open_status"
      expr: open_status
      comment: "Whether the communication was opened by the recipient for engagement rate calculation."
    - name: "click_status"
      expr: click_status
      comment: "Whether the recipient clicked a link in the communication for click-through rate analysis."
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Whether the communication was suppressed due to opt-out or compliance rules."
    - name: "unsubscribe_flag"
      expr: unsubscribe_flag
      comment: "Whether the recipient unsubscribed after receiving this communication."
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication for multilingual campaign performance analysis."
    - name: "event_month"
      expr: DATE_TRUNC('month', event_timestamp)
      comment: "Month the communication event occurred for trend analysis."
  measures:
    - name: "total_communications_sent"
      expr: COUNT(1)
      comment: "Total communications sent. Baseline volume metric for communication program scale."
    - name: "delivered_count"
      expr: COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN communication_id END)
      comment: "Number of successfully delivered communications. Measures deliverability and channel health."
    - name: "delivery_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN communication_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of communications successfully delivered. Core channel health KPI for email and SMS programs."
    - name: "open_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN open_status = 'opened' THEN communication_id END) / NULLIF(COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN communication_id END), 0), 2)
      comment: "Percentage of delivered communications that were opened. Primary engagement metric for email and push campaigns."
    - name: "click_through_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN click_status = 'clicked' THEN communication_id END) / NULLIF(COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN communication_id END), 0), 2)
      comment: "Percentage of delivered communications with at least one click. Measures content relevance and call-to-action effectiveness."
    - name: "unsubscribe_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN unsubscribe_flag = TRUE THEN communication_id END) / NULLIF(COUNT(DISTINCT CASE WHEN delivery_status = 'delivered' THEN communication_id END), 0), 2)
      comment: "Percentage of delivered communications resulting in unsubscribe. Rising rates signal communication fatigue or irrelevance."
    - name: "suppression_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN suppression_flag = TRUE THEN communication_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of communications suppressed. Tracks compliance-driven suppression and opt-out health."
$$;