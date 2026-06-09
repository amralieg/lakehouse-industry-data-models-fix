-- Metric views for domain: experience | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_guest_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest satisfaction and sentiment metrics derived from post-stay feedback submissions. Tracks overall satisfaction scores, NPS classification distribution, service recovery triggers, and recommendation intent — key KPIs for brand health and loyalty strategy."
  source: "`travel_hospitality_ecm`.`experience`.`guest_feedback`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level satisfaction benchmarking."
    - name: "feedback_submission_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Day the feedback was submitted, enabling trend analysis over time."
    - name: "feedback_submission_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of feedback submission for period-over-period reporting."
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS segment of the respondent: Promoter, Passive, or Detractor."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "High-level sentiment label (Positive, Neutral, Negative) for quick segmentation."
    - name: "source_system"
      expr: source_system
      comment: "Originating feedback platform (e.g., Medallia, TripAdvisor, direct survey)."
    - name: "language_code"
      expr: language_code
      comment: "Language of the feedback submission for multilingual analysis."
    - name: "stay_date_from"
      expr: stay_date_from
      comment: "Start date of the guest stay associated with this feedback."
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Indicates whether the feedback contains a formal complaint."
    - name: "would_recommend_flag"
      expr: would_recommend_flag
      comment: "Whether the guest indicated they would recommend the property."
    - name: "would_return_flag"
      expr: would_return_flag
      comment: "Whether the guest indicated intent to return."
    - name: "service_recovery_required_flag"
      expr: service_recovery_required_flag
      comment: "Flags feedback that triggered a service recovery workflow."
    - name: "survey_completion_status"
      expr: survey_completion_status
      comment: "Whether the survey was fully completed, partially completed, or abandoned."
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(1)
      comment: "Total number of guest feedback records submitted. Baseline volume metric for survey response tracking."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall guest satisfaction rating across all feedback submissions. Primary KPI for brand-level guest experience performance."
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score (GSS) from feedback records. Core hospitality KPI used in brand scorecards and GM performance reviews."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction (CSAT) score. Tracks transactional satisfaction at the interaction level."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service quality rating. Directly informs staffing, training, and service standard investments."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating. Key operational KPI for housekeeping performance management."
    - name: "avg_room_rating"
      expr: AVG(CAST(room_rating AS DOUBLE))
      comment: "Average room quality rating. Informs capital expenditure decisions for room renovation programs."
    - name: "avg_fnb_rating"
      expr: AVG(CAST(fnb_rating AS DOUBLE))
      comment: "Average food and beverage rating. Steers F&B investment, menu strategy, and outlet performance reviews."
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities satisfaction rating. Guides amenity investment and package design decisions."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average perceived value-for-money rating. Critical for pricing strategy and rate plan optimization."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average NLP-derived sentiment score across feedback verbatims. Enables automated brand health monitoring at scale."
    - name: "total_complaints"
      expr: COUNT(CASE WHEN complaint_flag = TRUE THEN 1 END)
      comment: "Total number of feedback records flagged as complaints. Tracks complaint volume for service quality management."
    - name: "total_service_recovery_triggers"
      expr: COUNT(CASE WHEN service_recovery_required_flag = TRUE THEN 1 END)
      comment: "Number of feedback submissions that triggered a service recovery workflow. Measures the scale of service failure requiring remediation."
    - name: "total_would_recommend"
      expr: COUNT(CASE WHEN would_recommend_flag = TRUE THEN 1 END)
      comment: "Count of guests who indicated they would recommend the property. Numerator for recommendation rate calculation."
    - name: "total_would_return"
      expr: COUNT(CASE WHEN would_return_flag = TRUE THEN 1 END)
      comment: "Count of guests who indicated intent to return. Numerator for return intent rate, a leading loyalty indicator."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time in hours between feedback submission and management response. Measures responsiveness as a service quality KPI."
    - name: "distinct_properties_with_feedback"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties receiving feedback in the period. Measures survey program coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_gss_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated Guest Satisfaction Score (GSS) metrics at the program, property, and period level. Tracks NPS, promoter/detractor distribution, response rates, and year-over-year variance — the primary executive scorecard for guest experience performance."
  source: "`travel_hospitality_ecm`.`experience`.`gss_score`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level GSS benchmarking."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand segment (e.g., Luxury, Premium, Select) for brand-level performance comparison."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Granularity of the measurement period (Monthly, Quarterly, Annual)."
    - name: "measurement_start_date"
      expr: measurement_start_date
      comment: "Start date of the GSS measurement window."
    - name: "measurement_end_date"
      expr: measurement_end_date
      comment: "End date of the GSS measurement window."
    - name: "department_code"
      expr: department_code
      comment: "Department associated with the GSS score for departmental performance tracking."
    - name: "data_source"
      expr: data_source
      comment: "Source system or survey platform that generated the GSS score."
    - name: "score_band"
      expr: score_band
      comment: "Categorical band of the GSS score (e.g., Top Box, Mid, Bottom Box) for distribution analysis."
    - name: "salt_target_attained_flag"
      expr: salt_target_attained_flag
      comment: "Whether the SALT (Satisfaction and Loyalty Tracking) target score was achieved in this period."
    - name: "published_flag"
      expr: published_flag
      comment: "Whether the GSS score has been officially published for reporting."
    - name: "gm_review_required_flag"
      expr: gm_review_required_flag
      comment: "Flags scores requiring General Manager review, typically below threshold."
  measures:
    - name: "avg_gss_score_value"
      expr: AVG(CAST(gss_score_value AS DOUBLE))
      comment: "Average GSS score across all records in the selection. Primary executive KPI for guest satisfaction performance."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score. Measures guest loyalty and likelihood to recommend — a leading indicator of revenue growth."
    - name: "avg_promoter_percent"
      expr: AVG(CAST(promoter_percent AS DOUBLE))
      comment: "Average percentage of Promoters (NPS score 9-10). Tracks the share of highly loyal guests."
    - name: "avg_detractor_percent"
      expr: AVG(CAST(detractor_percent AS DOUBLE))
      comment: "Average percentage of Detractors (NPS score 0-6). High detractor rates signal brand risk and churn."
    - name: "avg_passive_percent"
      expr: AVG(CAST(passive_percent AS DOUBLE))
      comment: "Average percentage of Passive respondents (NPS score 7-8). Passives represent conversion opportunity to Promoters."
    - name: "avg_top_box_percent"
      expr: AVG(CAST(top_box_percent AS DOUBLE))
      comment: "Average Top Box percentage (highest satisfaction tier). Industry-standard KPI for luxury and premium brand benchmarking."
    - name: "avg_bottom_box_percent"
      expr: AVG(CAST(bottom_box_percent AS DOUBLE))
      comment: "Average Bottom Box percentage (lowest satisfaction tier). Tracks the proportion of highly dissatisfied guests requiring intervention."
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average survey response rate. Low response rates reduce statistical confidence and signal survey program health issues."
    - name: "avg_grr_percent"
      expr: AVG(CAST(grr_percent AS DOUBLE))
      comment: "Average Guest Return Rate (GRR) percentage. Measures repeat visit intent as a loyalty and revenue retention KPI."
    - name: "avg_yoy_variance"
      expr: AVG(CAST(yoy_variance AS DOUBLE))
      comment: "Average year-over-year GSS score variance. Tracks improvement or decline in guest satisfaction relative to prior year."
    - name: "avg_prior_period_variance"
      expr: AVG(CAST(prior_period_variance AS DOUBLE))
      comment: "Average variance versus the prior measurement period. Enables short-cycle performance monitoring between reporting periods."
    - name: "avg_salt_target_score"
      expr: AVG(CAST(salt_target_score AS DOUBLE))
      comment: "Average SALT target score set for the period. Used to contextualize actual GSS performance against brand commitments."
    - name: "total_salt_target_attained"
      expr: COUNT(CASE WHEN salt_target_attained_flag = TRUE THEN 1 END)
      comment: "Number of periods/properties where the SALT target was achieved. Tracks brand standard compliance across the portfolio."
    - name: "total_gm_review_required"
      expr: COUNT(CASE WHEN gm_review_required_flag = TRUE THEN 1 END)
      comment: "Count of GSS records requiring GM review. Measures the volume of underperforming properties needing leadership intervention."
    - name: "avg_confidence_interval_lower"
      expr: AVG(CAST(confidence_interval_lower AS DOUBLE))
      comment: "Average lower bound of the GSS confidence interval. Supports statistical rigor in executive reporting."
    - name: "avg_confidence_interval_upper"
      expr: AVG(CAST(confidence_interval_upper AS DOUBLE))
      comment: "Average upper bound of the GSS confidence interval. Supports statistical rigor in executive reporting."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case management metrics tracking complaint volume, resolution efficiency, SLA compliance, escalation rates, and compensation costs. Directly informs service quality investment, staffing, and guest recovery strategy."
  source: "`travel_hospitality_ecm`.`experience`.`service_case`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the service case originated."
    - name: "case_category"
      expr: case_category
      comment: "High-level category of the service issue (e.g., Housekeeping, F&B, Front Desk)."
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Detailed subcategory for root cause analysis and targeted improvement."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (Open, In Progress, Resolved, Closed)."
    - name: "case_origin"
      expr: case_origin
      comment: "Channel through which the case was raised (e.g., Front Desk, App, Social Media)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the case (Critical, High, Medium, Low)."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current escalation state of the case."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the case was resolved (e.g., Compensation, Apology, Room Move)."
    - name: "root_cause"
      expr: root_cause
      comment: "Root cause classification for systemic issue identification and prevention."
    - name: "guest_lifetime_value_segment"
      expr: guest_lifetime_value_segment
      comment: "LTV segment of the guest involved, enabling prioritized recovery for high-value guests."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the service failure was preventable. Drives process improvement initiatives."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the case was resolved within SLA target hours."
    - name: "social_media_mention_flag"
      expr: social_media_mention_flag
      comment: "Whether the case involved a social media mention, indicating reputational risk."
    - name: "case_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created for trend and volume analysis."
    - name: "source_system"
      expr: source_system
      comment: "System of record where the case was originated."
  measures:
    - name: "total_service_cases"
      expr: COUNT(1)
      comment: "Total number of service cases. Baseline volume metric for service failure tracking."
    - name: "avg_actual_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average time in hours to resolve a service case. Core operational KPI for service recovery speed and SLA management."
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_total_value AS DOUBLE))
      comment: "Total monetary value of compensation issued across all service cases. Tracks the financial cost of service failures."
    - name: "avg_compensation_value"
      expr: AVG(CAST(compensation_total_value AS DOUBLE))
      comment: "Average compensation value per service case. Benchmarks recovery generosity and cost-per-failure."
    - name: "total_escalated_cases"
      expr: COUNT(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 END)
      comment: "Number of cases that were escalated. High escalation rates indicate systemic service quality issues."
    - name: "total_sla_compliant_cases"
      expr: COUNT(CASE WHEN sla_compliance_flag = TRUE THEN 1 END)
      comment: "Number of cases resolved within SLA target. Numerator for SLA compliance rate calculation."
    - name: "total_preventable_cases"
      expr: COUNT(CASE WHEN preventable_flag = TRUE THEN 1 END)
      comment: "Number of cases classified as preventable. Drives process improvement ROI analysis."
    - name: "total_social_media_cases"
      expr: COUNT(CASE WHEN social_media_mention_flag = TRUE THEN 1 END)
      comment: "Number of cases with social media exposure. Tracks reputational risk volume requiring priority management."
    - name: "total_grr_outcome_cases"
      expr: COUNT(CASE WHEN grr_outcome_flag = TRUE THEN 1 END)
      comment: "Number of cases with a positive Guest Return Rate outcome post-resolution. Measures service recovery effectiveness in retaining guests."
    - name: "total_follow_up_required_cases"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of cases requiring follow-up action. Tracks open obligations in the service recovery pipeline."
    - name: "distinct_properties_with_cases"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties generating service cases. Measures portfolio-wide service issue spread."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_service_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service recovery action metrics tracking the financial cost, fulfillment effectiveness, and guest acceptance of recovery interventions. Enables ROI analysis of recovery programs and informs authorization policy decisions."
  source: "`travel_hospitality_ecm`.`experience`.`service_recovery_action`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the recovery action was executed."
    - name: "recovery_action_category"
      expr: recovery_action_category
      comment: "Category of recovery action (e.g., Upgrade, Discount, Complimentary Service)."
    - name: "recovery_action_type"
      expr: recovery_action_type
      comment: "Specific type of recovery action for granular cost and effectiveness analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Whether the recovery action was fulfilled, pending, or cancelled."
    - name: "guest_acceptance_status"
      expr: guest_acceptance_status
      comment: "Whether the guest accepted the recovery offer. Measures offer relevance and effectiveness."
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization tier required to approve the recovery action (e.g., Supervisor, GM, Corporate)."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used to deliver the recovery action to the guest."
    - name: "is_proactive"
      expr: is_proactive
      comment: "Whether the recovery was proactively offered before a complaint was raised."
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the recovery action, enabling root cause trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the monetary recovery value."
    - name: "action_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the recovery action was created for trend analysis."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether a follow-up is required to confirm guest satisfaction post-recovery."
  measures:
    - name: "total_recovery_actions"
      expr: COUNT(1)
      comment: "Total number of service recovery actions executed. Baseline volume metric for recovery program scale."
    - name: "total_monetary_recovery_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all recovery actions. Tracks the financial cost of service failure remediation across the portfolio."
    - name: "avg_monetary_recovery_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recovery action. Benchmarks recovery generosity and informs authorization policy calibration."
    - name: "total_proactive_recoveries"
      expr: COUNT(CASE WHEN is_proactive = TRUE THEN 1 END)
      comment: "Number of proactive recovery actions initiated before a formal complaint. Measures the maturity of the proactive service culture."
    - name: "total_guest_accepted_recoveries"
      expr: COUNT(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 END)
      comment: "Number of recovery actions accepted by the guest. Numerator for recovery acceptance rate — measures offer relevance."
    - name: "total_fulfilled_recoveries"
      expr: COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 END)
      comment: "Number of recovery actions successfully fulfilled. Tracks execution reliability of the recovery program."
    - name: "distinct_cases_with_recovery"
      expr: COUNT(DISTINCT service_case_id)
      comment: "Number of distinct service cases that received at least one recovery action. Measures recovery program reach."
    - name: "distinct_properties_with_recovery"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties executing recovery actions. Tracks portfolio-wide recovery program adoption."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_amenity_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amenity fulfillment operational metrics tracking delivery performance, cost, guest satisfaction, and complimentary amenity usage. Informs amenity program ROI, delivery SLA management, and loyalty tier service differentiation."
  source: "`travel_hospitality_ecm`.`experience`.`amenity_fulfillment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the amenity was fulfilled."
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of amenity (e.g., Welcome Amenity, Birthday, Anniversary) for program-level analysis."
    - name: "amenity_name"
      expr: amenity_name
      comment: "Name of the specific amenity for item-level performance tracking."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current status of the amenity fulfillment (Delivered, Pending, Cancelled, Failed)."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the amenity (e.g., In-Room, At Check-In, Concierge)."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the amenity was provided complimentarily. Enables cost analysis of complimentary program spend."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest receiving the amenity. Enables tier-differentiated service analysis."
    - name: "occasion_type"
      expr: occasion_type
      comment: "Occasion driving the amenity (e.g., Birthday, Anniversary, VIP Arrival)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amenity cost."
    - name: "charge_posted_flag"
      expr: charge_posted_flag
      comment: "Whether the amenity charge was posted to the guest folio."
    - name: "guest_acknowledgment_flag"
      expr: guest_acknowledgment_flag
      comment: "Whether the guest acknowledged receipt of the amenity."
    - name: "scheduled_delivery_date"
      expr: scheduled_delivery_date
      comment: "Scheduled delivery date for time-based fulfillment analysis."
    - name: "fulfillment_month"
      expr: DATE_TRUNC('month', actual_delivery_timestamp)
      comment: "Month of actual amenity delivery for trend analysis."
  measures:
    - name: "total_amenity_fulfillments"
      expr: COUNT(1)
      comment: "Total number of amenity fulfillment records. Baseline volume metric for amenity program scale."
    - name: "total_amenity_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all amenity fulfillments. Tracks the financial investment in the amenity program."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per amenity. Benchmarks amenity cost efficiency and informs procurement decisions."
    - name: "total_complimentary_amenities"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary amenities provided. Tracks the volume and implied cost of complimentary program commitments."
    - name: "total_complimentary_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of complimentary amenities. Quantifies the financial impact of the complimentary amenity program."
    - name: "total_guest_acknowledged"
      expr: COUNT(CASE WHEN guest_acknowledgment_flag = TRUE THEN 1 END)
      comment: "Number of amenities acknowledged by the guest. Numerator for acknowledgment rate — measures delivery confirmation effectiveness."
    - name: "total_cancelled_fulfillments"
      expr: COUNT(CASE WHEN fulfillment_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled amenity fulfillments. Tracks fulfillment failure rate for operational reliability management."
    - name: "distinct_guests_receiving_amenities"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of distinct guests who received amenities. Measures the breadth of amenity program reach."
    - name: "distinct_properties_fulfilling_amenities"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties executing amenity fulfillments. Tracks portfolio-wide program adoption."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_online_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online review reputation metrics tracking normalized ratings, sentiment, management response rates, and competitive positioning across OTA and review platforms. Critical for brand reputation management and revenue impact analysis."
  source: "`travel_hospitality_ecm`.`experience`.`online_review`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the online review."
    - name: "review_date_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of the review for trend analysis."
    - name: "review_date"
      expr: review_date
      comment: "Date the review was published on the platform."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "NLP-derived sentiment classification (Positive, Neutral, Negative)."
    - name: "traveler_type"
      expr: traveler_type
      comment: "Type of traveler (Business, Leisure, Family, Couple) for segment-level reputation analysis."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Whether management has responded to the review (Responded, Pending, Not Required)."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review for multilingual reputation monitoring."
    - name: "competitive_set_flag"
      expr: competitive_set_flag
      comment: "Whether the review is from a competitive set property for benchmarking."
    - name: "verified_stay_flag"
      expr: verified_stay_flag
      comment: "Whether the reviewer had a verified stay, indicating review authenticity."
    - name: "review_visibility_status"
      expr: review_visibility_status
      comment: "Current visibility status of the review on the platform."
    - name: "platform_rating_scale"
      expr: platform_rating_scale
      comment: "Rating scale used by the platform (e.g., 1-5, 1-10) for normalization context."
  measures:
    - name: "total_online_reviews"
      expr: COUNT(1)
      comment: "Total number of online reviews ingested. Baseline volume metric for review monitoring coverage."
    - name: "avg_normalized_rating"
      expr: AVG(CAST(normalized_rating AS DOUBLE))
      comment: "Average normalized rating across all platforms. Primary reputation KPI enabling cross-platform comparison."
    - name: "avg_platform_native_rating"
      expr: AVG(CAST(platform_native_rating AS DOUBLE))
      comment: "Average platform-native rating. Used for platform-specific benchmarking and OTA ranking optimization."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average NLP sentiment score across review verbatims. Enables automated reputation health monitoring at scale."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service rating from online reviews. Cross-validates internal GSS service scores with external perception."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating from online reviews. External validation of housekeeping performance."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value-for-money rating from online reviews. Informs pricing strategy and rate competitiveness."
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating from online reviews. Guides amenity investment decisions."
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location rating from online reviews. Contextualizes overall scores for location-constrained properties."
    - name: "total_reviews_with_management_response"
      expr: COUNT(CASE WHEN management_response_status = 'Responded' THEN 1 END)
      comment: "Number of reviews that received a management response. Numerator for management response rate — a key OTA ranking factor."
    - name: "total_verified_stay_reviews"
      expr: COUNT(CASE WHEN verified_stay_flag = TRUE THEN 1 END)
      comment: "Number of reviews from verified stays. Measures the proportion of authentic, high-credibility reviews."
    - name: "distinct_properties_reviewed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with online reviews in the period. Measures reputation monitoring coverage."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_guest_experience_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest experience program enrollment metrics tracking participation, fulfillment progress, post-program satisfaction, and program cost. Enables program ROI analysis and loyalty-linked experience investment decisions."
  source: "`travel_hospitality_ecm`.`experience`.`guest_experience_enrollment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the guest experience program enrollment occurred."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the enrollment (Active, Completed, Cancelled, Pending)."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Channel through which the guest enrolled in the program."
    - name: "amenity_fulfillment_status"
      expr: amenity_fulfillment_status
      comment: "Status of amenity fulfillment within the enrollment."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the program enrollment was complimentary."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the enrollment (Paid, Pending, Waived)."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the program cost."
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_timestamp)
      comment: "Month of enrollment for trend and seasonality analysis."
    - name: "scheduled_start_date"
      expr: scheduled_start_date
      comment: "Scheduled start date of the program for capacity and demand planning."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for enrollment cancellation for churn analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of guest experience program enrollments. Baseline volume metric for program demand."
    - name: "total_program_cost"
      expr: SUM(CAST(total_program_cost AS DOUBLE))
      comment: "Total cost of all guest experience program enrollments. Tracks the financial investment in the experience program portfolio."
    - name: "avg_program_cost"
      expr: AVG(CAST(total_program_cost AS DOUBLE))
      comment: "Average cost per program enrollment. Benchmarks program cost efficiency and informs pricing decisions."
    - name: "avg_post_program_gss_score"
      expr: AVG(CAST(post_program_gss_score AS DOUBLE))
      comment: "Average GSS score recorded after program completion. Measures the satisfaction impact of experience programs."
    - name: "avg_post_program_csat_score"
      expr: AVG(CAST(post_program_csat_score AS DOUBLE))
      comment: "Average CSAT score recorded after program completion. Tracks transactional satisfaction with the program experience."
    - name: "avg_fulfillment_progress_percentage"
      expr: AVG(CAST(fulfillment_progress_percentage AS DOUBLE))
      comment: "Average fulfillment progress percentage across active enrollments. Tracks operational delivery against program commitments."
    - name: "total_complimentary_enrollments"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary program enrollments. Tracks the volume and implied cost of complimentary program commitments."
    - name: "total_cancelled_enrollments"
      expr: COUNT(CASE WHEN program_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled enrollments. Tracks program cancellation rate for demand reliability analysis."
    - name: "distinct_guests_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests enrolled in experience programs. Measures program reach across the guest base."
    - name: "distinct_properties_with_enrollments"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with active program enrollments. Tracks portfolio-wide program adoption."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment metrics tracking request volume, fulfillment rates, cost, and guest satisfaction by request type and loyalty tier. Enables service personalization investment decisions and loyalty-differentiated service analysis."
  source: "`travel_hospitality_ecm`.`experience`.`experience_special_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the special request was submitted."
    - name: "request_type"
      expr: request_type
      comment: "High-level type of special request (e.g., Dietary, Room Preference, Transportation)."
    - name: "request_subtype"
      expr: request_subtype
      comment: "Detailed subtype for granular request analysis and fulfillment optimization."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (Pending, Fulfilled, Cancelled, Declined)."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the request for SLA management."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the requesting guest. Enables tier-differentiated fulfillment analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the request was fulfilled complimentarily."
    - name: "is_loyalty_member_request"
      expr: is_loyalty_member_request
      comment: "Whether the request was made by a loyalty program member."
    - name: "is_service_recovery"
      expr: is_service_recovery
      comment: "Whether the request is part of a service recovery action."
    - name: "is_repeat_request"
      expr: is_repeat_request
      comment: "Whether this is a repeat request from the same guest. Indicates unresolved preferences or recurring needs."
    - name: "request_source"
      expr: request_source
      comment: "Channel through which the request was submitted (App, Front Desk, Concierge)."
    - name: "request_submitted_month"
      expr: DATE_TRUNC('month', request_submitted_timestamp)
      comment: "Month the request was submitted for trend analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the request cost."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests submitted. Baseline volume metric for personalization demand."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of fulfilling special requests. Tracks the financial investment in personalized guest services."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per special request. Benchmarks fulfillment cost efficiency."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of special requests. Enables budget forecasting for personalization programs."
    - name: "total_charge_to_guest"
      expr: SUM(CAST(charge_to_guest_amount AS DOUBLE))
      comment: "Total amount charged to guests for special requests. Tracks revenue generated from premium personalization services."
    - name: "total_fulfilled_requests"
      expr: COUNT(CASE WHEN request_status = 'Fulfilled' THEN 1 END)
      comment: "Number of successfully fulfilled special requests. Numerator for fulfillment rate calculation."
    - name: "total_loyalty_member_requests"
      expr: COUNT(CASE WHEN is_loyalty_member_request = TRUE THEN 1 END)
      comment: "Number of special requests from loyalty members. Measures the personalization demand from the loyalty base."
    - name: "total_service_recovery_requests"
      expr: COUNT(CASE WHEN is_service_recovery = TRUE THEN 1 END)
      comment: "Number of requests classified as service recovery. Tracks the volume of recovery-driven personalization."
    - name: "total_complimentary_requests"
      expr: COUNT(CASE WHEN is_complimentary = TRUE THEN 1 END)
      comment: "Number of complimentary special requests. Tracks the volume of no-charge personalization commitments."
    - name: "distinct_guests_with_requests"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Number of distinct guests submitting special requests. Measures personalization program reach."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest interaction touchpoint metrics tracking interaction volume, sentiment, VIP handling, special request fulfillment, and follow-up compliance. Enables frontline service quality management and touchpoint optimization."
  source: "`travel_hospitality_ecm`.`experience`.`guest_interaction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the guest interaction occurred."
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (e.g., Check-In, Complaint, Concierge Request, Housekeeping)."
    - name: "interaction_location"
      expr: interaction_location
      comment: "Physical or digital location where the interaction took place."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the interaction for departmental performance tracking."
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (Resolved, Escalated, Pending, Positive)."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "NLP-derived sentiment of the interaction (Positive, Neutral, Negative)."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Whether the interaction involved a VIP guest. Enables VIP service quality monitoring."
    - name: "guest_initiated_flag"
      expr: guest_initiated_flag
      comment: "Whether the interaction was initiated by the guest or by staff."
    - name: "nps_eligible_flag"
      expr: nps_eligible_flag
      comment: "Whether the interaction is eligible to trigger an NPS survey."
    - name: "special_request_fulfilled_flag"
      expr: special_request_fulfilled_flag
      comment: "Whether a special request was fulfilled during this interaction."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether a follow-up action is required after this interaction."
    - name: "interaction_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of the interaction for trend analysis."
    - name: "interaction_language"
      expr: interaction_language
      comment: "Language used during the interaction for multilingual service analysis."
  measures:
    - name: "total_guest_interactions"
      expr: COUNT(1)
      comment: "Total number of guest interactions recorded. Baseline volume metric for touchpoint activity."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all guest interactions. Tracks frontline service quality through NLP-derived signals."
    - name: "total_vip_interactions"
      expr: COUNT(CASE WHEN vip_status_flag = TRUE THEN 1 END)
      comment: "Number of interactions involving VIP guests. Enables VIP service quality monitoring and resource allocation."
    - name: "total_special_requests_fulfilled"
      expr: COUNT(CASE WHEN special_request_fulfilled_flag = TRUE THEN 1 END)
      comment: "Number of interactions where a special request was fulfilled. Measures in-stay personalization delivery effectiveness."
    - name: "total_follow_up_required"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of interactions requiring follow-up. Tracks open service obligations in the frontline pipeline."
    - name: "total_nps_eligible_interactions"
      expr: COUNT(CASE WHEN nps_eligible_flag = TRUE THEN 1 END)
      comment: "Number of interactions eligible to trigger NPS surveys. Measures the potential survey population for response rate optimization."
    - name: "total_amenity_offered"
      expr: COUNT(CASE WHEN amenity_offered_flag = TRUE THEN 1 END)
      comment: "Number of interactions where an amenity was offered. Tracks proactive service and upsell activity at the touchpoint level."
    - name: "distinct_guests_interacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests with recorded interactions. Measures touchpoint coverage across the in-stay guest population."
$$;