-- Metric views for domain: experience | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core guest satisfaction KPIs derived from post-stay and in-stay feedback submissions. Tracks NPS, CSAT, sentiment, and service recovery signals to steer guest experience investment and operational improvement."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_feedback`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the feedback was collected — primary grouping for property-level performance benchmarking."
    - name: "guest_segment"
      expr: guest_segment
      comment: "Guest segment classification (e.g., leisure, business, group) enabling segment-level satisfaction analysis."
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification bucket (Promoter, Passive, Detractor) for distribution analysis."
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Categorical sentiment label (Positive, Neutral, Negative) derived from verbatim analysis."
    - name: "primary_topic"
      expr: primary_topic
      comment: "Primary topic extracted from feedback verbatim (e.g., cleanliness, service, F&B) for root-cause analysis."
    - name: "survey_completion_status"
      expr: survey_completion_status
      comment: "Whether the survey was fully completed, partially completed, or abandoned — affects response quality."
    - name: "stay_date_from"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Month of stay start date for trend analysis of satisfaction over time."
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Boolean flag indicating whether the feedback contained a formal complaint."
    - name: "service_recovery_required_flag"
      expr: service_recovery_required_flag
      comment: "Boolean flag indicating whether service recovery was triggered by this feedback."
    - name: "would_recommend_flag"
      expr: would_recommend_flag
      comment: "Whether the guest indicated they would recommend the property — a leading loyalty indicator."
  measures:
    - name: "total_feedback_submissions"
      expr: COUNT(1)
      comment: "Total number of feedback records submitted. Baseline volume metric for response rate and trend analysis."
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall guest satisfaction rating across all feedback submissions. Primary KPI for property-level guest experience performance."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across feedback submissions. Strategic loyalty and advocacy indicator used in QBRs and brand benchmarking."
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction Score. Tracks transactional satisfaction at the interaction level."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average AI-derived sentiment score from verbatim feedback. Enables trend detection before formal scores are submitted."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service quality rating. Directly tied to staff performance and training investment decisions."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating. Key driver of overall satisfaction and a primary housekeeping performance indicator."
    - name: "avg_room_rating"
      expr: AVG(CAST(room_rating AS DOUBLE))
      comment: "Average room quality rating. Informs capital investment decisions for room renovation and PIP planning."
    - name: "avg_fnb_rating"
      expr: AVG(CAST(fnb_rating AS DOUBLE))
      comment: "Average food and beverage rating. Steers F&B outlet investment, menu development, and staffing decisions."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average perceived value-for-money rating. Critical for pricing strategy and rate plan positioning."
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time in hours between feedback submission and management response. SLA compliance and guest recovery speed indicator."
    - name: "complaint_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback submissions that contain a formal complaint. Tracks service failure frequency and drives corrective action prioritization."
    - name: "service_recovery_trigger_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback records that triggered a service recovery action. Measures the scale of service failures requiring remediation."
    - name: "would_recommend_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who indicated they would recommend the property. Leading indicator of brand advocacy and repeat business."
    - name: "would_return_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who indicated they would return. Direct loyalty and retention signal used in revenue forecasting."
    - name: "avg_topic_confidence_score"
      expr: AVG(CAST(topic_confidence_score AS DOUBLE))
      comment: "Average confidence score of the AI topic extraction model. Monitors ML model reliability for feedback analytics."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case management KPIs tracking resolution efficiency, SLA compliance, escalation rates, and compensation costs. Drives operational excellence and guest recovery investment decisions."
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_case`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the service case originated — enables property-level case management benchmarking."
    - name: "case_category"
      expr: case_category
      comment: "High-level category of the service case (e.g., room issue, billing, F&B) for root-cause analysis."
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Detailed subcategory for granular issue classification and targeted corrective action."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the case (Open, In Progress, Resolved, Closed) for workload and backlog management."
    - name: "priority_level"
      expr: priority_level
      comment: "Case priority (Critical, High, Medium, Low) for SLA tier assignment and resource allocation."
    - name: "escalation_status"
      expr: escalation_status
      comment: "Whether the case has been escalated and to what level — tracks management intervention frequency."
    - name: "resolution_type"
      expr: resolution_type
      comment: "How the case was resolved (e.g., compensation, apology, room change) for recovery strategy analysis."
    - name: "case_origin"
      expr: case_origin
      comment: "Channel through which the case was raised (front desk, app, OTA, social) for omnichannel service tracking."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the case was created for trend analysis of service failure volume over time."
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the case was deemed preventable — drives process improvement and training investment."
    - name: "guest_lifetime_value_segment"
      expr: guest_lifetime_value_segment
      comment: "LTV segment of the guest involved — prioritizes recovery resources toward high-value guests."
  measures:
    - name: "total_service_cases"
      expr: COUNT(1)
      comment: "Total number of service cases opened. Baseline volume metric for service failure tracking."
    - name: "avg_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average time in hours to resolve a service case. Primary SLA performance indicator for guest recovery speed."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resolved within SLA target. Tracks operational discipline and guest commitment fulfillment."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were escalated. High escalation rates signal systemic service failures requiring leadership intervention."
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_total_value AS DOUBLE))
      comment: "Total monetary value of compensation offered across all service cases. Tracks financial cost of service failures and recovery spend."
    - name: "avg_compensation_per_case"
      expr: AVG(CAST(compensation_total_value AS DOUBLE))
      comment: "Average compensation value per service case. Benchmarks recovery generosity and informs compensation policy calibration."
    - name: "preventable_case_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases classified as preventable. Directly drives process improvement ROI calculations and training investment."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring follow-up contact with the guest. Indicates incomplete first-contact resolution."
    - name: "social_media_mention_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN social_media_mention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with associated social media mentions. Tracks reputational risk exposure from service failures."
    - name: "grr_outcome_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN grr_outcome_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with a positive Guest Recognition & Recovery outcome. Measures effectiveness of the service recovery program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_gss_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Satisfaction Score (GSS) aggregate KPIs at property and period level. Tracks NPS, promoter/detractor distribution, response rates, and year-over-year variance for brand compliance and competitive benchmarking."
  source: "`vibe_travel_hospitality_v1`.`experience`.`gss_score`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for property-level GSS benchmarking and brand compliance tracking."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type (monthly, quarterly, annual) for appropriate aggregation and trend comparison."
    - name: "measurement_start_date"
      expr: DATE_TRUNC('month', measurement_start_date)
      comment: "Month of measurement period start for time-series trend analysis."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment for which the GSS was calculated — enables segment-level satisfaction benchmarking."
    - name: "department_code"
      expr: department_code
      comment: "Department associated with the GSS score for departmental accountability tracking."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code for cross-brand GSS comparison and brand standard compliance."
    - name: "region_code"
      expr: region_code
      comment: "Regional grouping for portfolio-level GSS performance analysis."
    - name: "score_band"
      expr: score_band
      comment: "Score band classification (e.g., Excellent, Good, Needs Improvement) for quick performance tiering."
    - name: "salt_target_attained_flag"
      expr: salt_target_attained_flag
      comment: "Whether the SALT (Satisfaction and Loyalty Tracking) target was attained — brand compliance indicator."
    - name: "gm_review_required_flag"
      expr: gm_review_required_flag
      comment: "Whether the score triggered a General Manager review — tracks accountability escalation frequency."
  measures:
    - name: "avg_gss_value"
      expr: AVG(CAST(value AS DOUBLE))
      comment: "Average GSS score across all measurement records. Primary brand performance KPI used in QBRs and owner reporting."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average NPS score from GSS measurement periods. Strategic loyalty indicator for brand investment decisions."
    - name: "avg_promoter_percent"
      expr: AVG(CAST(promoter_percent AS DOUBLE))
      comment: "Average percentage of promoters across measurement periods. Tracks brand advocacy strength."
    - name: "avg_detractor_percent"
      expr: AVG(CAST(detractor_percent AS DOUBLE))
      comment: "Average percentage of detractors. High detractor rates signal systemic service issues requiring immediate intervention."
    - name: "avg_passive_percent"
      expr: AVG(CAST(passive_percent AS DOUBLE))
      comment: "Average percentage of passive respondents. Passives represent conversion opportunity to promoters."
    - name: "avg_response_rate_pct"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average survey response rate. Low response rates reduce statistical confidence and may indicate guest disengagement."
    - name: "avg_top_box_percent"
      expr: AVG(CAST(top_box_percent AS DOUBLE))
      comment: "Average top-box score percentage (highest satisfaction tier). Brand standard compliance metric."
    - name: "avg_bottom_box_percent"
      expr: AVG(CAST(bottom_box_percent AS DOUBLE))
      comment: "Average bottom-box score percentage (lowest satisfaction tier). Tracks severe dissatisfaction prevalence."
    - name: "avg_yoy_variance"
      expr: AVG(CAST(yoy_variance AS DOUBLE))
      comment: "Average year-over-year GSS variance. Tracks improvement trajectory for strategic planning and incentive compensation."
    - name: "avg_prior_period_variance"
      expr: AVG(CAST(prior_period_variance AS DOUBLE))
      comment: "Average variance from prior period score. Short-term momentum indicator for operational course correction."
    - name: "salt_target_attainment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of measurement periods where the SALT target was attained. Brand compliance KPI tied to franchise and management agreements."
    - name: "avg_grr_percent"
      expr: AVG(CAST(grr_percent AS DOUBLE))
      comment: "Average Guest Recognition & Recovery rate. Measures the effectiveness of proactive service recovery programs."
    - name: "avg_salt_target_score"
      expr: AVG(CAST(salt_target_score AS DOUBLE))
      comment: "Average SALT target score across measurement periods. Provides context for attainment rate interpretation."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_online_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online review analytics KPIs tracking normalized ratings, sentiment, topic distribution, and management response performance across OTA and review platforms. Drives reputation management strategy and competitive positioning."
  source: "`vibe_travel_hospitality_v1`.`experience`.`online_review`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property for which the review was submitted — primary grouping for property reputation benchmarking."
    - name: "review_date_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month of review submission for trend analysis of online reputation over time."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "AI-derived sentiment classification (Positive, Neutral, Negative) for reputation signal monitoring."
    - name: "primary_topic"
      expr: primary_topic
      comment: "Primary topic extracted from review text for competitive intelligence and operational improvement targeting."
    - name: "traveler_type"
      expr: traveler_type
      comment: "Type of traveler (business, leisure, family, couple) for segment-level reputation analysis."
    - name: "management_response_status"
      expr: management_response_status
      comment: "Whether management has responded to the review — tracks response program compliance."
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language of the review for multilingual reputation monitoring."
    - name: "competitive_set_flag"
      expr: competitive_set_flag
      comment: "Whether the review is from a competitive set property — enables competitive benchmarking."
    - name: "verified_stay_flag"
      expr: verified_stay_flag
      comment: "Whether the reviewer had a verified stay — filters for authentic reviews in quality analysis."
    - name: "review_visibility_status"
      expr: review_visibility_status
      comment: "Current visibility status of the review (published, removed, flagged) for content moderation tracking."
  measures:
    - name: "total_reviews"
      expr: COUNT(1)
      comment: "Total number of online reviews collected. Volume baseline for review program coverage analysis."
    - name: "avg_normalized_rating"
      expr: AVG(CAST(normalized_rating AS DOUBLE))
      comment: "Average normalized rating (standardized across platforms to a common scale). Primary cross-platform reputation KPI."
    - name: "avg_platform_native_rating"
      expr: AVG(CAST(platform_native_rating AS DOUBLE))
      comment: "Average rating on the platform's native scale. Used for platform-specific ranking and visibility optimization."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average AI-derived sentiment score from review text. Provides continuous signal between discrete rating updates."
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness sub-rating from reviews. Directly informs housekeeping investment and standard-setting."
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service sub-rating from reviews. Drives staff training and service standard decisions."
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value-for-money sub-rating. Informs pricing strategy and rate plan positioning."
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities sub-rating. Guides capital investment in property facilities and amenity upgrades."
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location sub-rating. Contextualizes overall performance relative to fixed location attributes."
    - name: "management_response_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN management_response_status = 'Responded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews that received a management response. Tracks reputation management program engagement and platform algorithm compliance."
    - name: "avg_topic_confidence_score"
      expr: AVG(CAST(topic_confidence_score AS DOUBLE))
      comment: "Average confidence score of the topic extraction model applied to reviews. Monitors AI model reliability for reputation analytics."
    - name: "distinct_properties_reviewed"
      expr: COUNT(DISTINCT property_id)
      comment: "Number of distinct properties with online reviews in the period. Tracks review program coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_service_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service recovery action KPIs tracking recovery cost, fulfillment effectiveness, and authorization patterns. Enables financial control of recovery spend and measurement of recovery program ROI."
  source: "`vibe_travel_hospitality_v1`.`experience`.`service_recovery_action`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the recovery action was executed — enables property-level recovery spend benchmarking."
    - name: "recovery_action_category"
      expr: recovery_action_category
      comment: "Category of recovery action (e.g., room upgrade, F&B credit, loyalty points) for spend mix analysis."
    - name: "recovery_action_type"
      expr: recovery_action_type
      comment: "Specific type of recovery action for granular cost attribution and effectiveness measurement."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status of the recovery action — tracks execution completion rates."
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level required for the recovery action — monitors empowerment policy compliance."
    - name: "guest_acceptance_status"
      expr: guest_acceptance_status
      comment: "Whether the guest accepted the recovery offer — measures recovery offer effectiveness."
    - name: "is_proactive"
      expr: is_proactive
      comment: "Whether the recovery was proactive (before complaint) or reactive — tracks proactive service culture adoption."
    - name: "reason_code"
      expr: reason_code
      comment: "Root cause reason code for the recovery action — drives systemic issue identification."
    - name: "created_timestamp_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the recovery action was created for trend analysis of recovery spend over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the recovery monetary value for multi-currency portfolio analysis."
  measures:
    - name: "total_recovery_actions"
      expr: COUNT(1)
      comment: "Total number of service recovery actions executed. Volume baseline for recovery program scale assessment."
    - name: "total_recovery_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all service recovery actions. Primary financial KPI for recovery program cost control."
    - name: "avg_recovery_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per recovery action. Benchmarks recovery generosity and informs authorization policy calibration."
    - name: "fulfillment_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions that were fully fulfilled. Tracks execution reliability of the recovery program."
    - name: "guest_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery offers accepted by guests. Measures relevance and appropriateness of recovery offers."
    - name: "proactive_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions that were proactive rather than reactive. Tracks cultural shift toward anticipatory service."
    - name: "follow_up_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required = TRUE AND follow_up_completed_timestamp IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required follow-ups that were completed. Tracks guest recovery closure discipline."
    - name: "total_cost_center_charges"
      expr: SUM(CAST(cost_center_code AS DOUBLE))
      comment: "Total cost center charges associated with recovery actions. Enables departmental cost attribution for recovery spend."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality audit KPIs tracking brand standard compliance scores, deficiency rates, and corrective action completion. Drives property investment prioritization and brand compliance management."
  source: "`vibe_travel_hospitality_v1`.`experience`.`quality_audit`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property audited — primary grouping for brand compliance benchmarking across the portfolio."
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (brand standard, safety, food safety, mystery guest) for audit program coverage analysis."
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (Scheduled, In Progress, Completed, Overdue) for audit program management."
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Pass/Fail outcome of the audit — primary brand compliance binary indicator."
    - name: "certification_level_achieved"
      expr: certification_level_achieved
      comment: "Certification level achieved (e.g., Gold, Silver, Bronze) for tiered brand standard tracking."
    - name: "audit_date_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month of audit for trend analysis of compliance scores over time."
    - name: "brand_compliance_flag"
      expr: brand_compliance_flag
      comment: "Whether the property achieved full brand compliance — franchise agreement compliance indicator."
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action was required — tracks remediation workload across the portfolio."
    - name: "re_inspection_required_flag"
      expr: re_inspection_required_flag
      comment: "Whether a re-inspection was required — indicates severity of compliance failures."
    - name: "gm_accountability_flag"
      expr: gm_accountability_flag
      comment: "Whether the GM was held accountable for audit outcomes — tracks leadership accountability program."
  measures:
    - name: "total_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted. Baseline for audit program coverage and frequency analysis."
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score across all audits. Primary brand compliance KPI for portfolio-level quality management."
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service quality score from audits. Drives staff training investment and service standard enforcement."
    - name: "avg_housekeeping_score"
      expr: AVG(CAST(housekeeping_score AS DOUBLE))
      comment: "Average housekeeping score from audits. Informs housekeeping staffing, training, and equipment investment."
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility condition score. Drives capital expenditure prioritization for property improvement plans."
    - name: "avg_fnb_score"
      expr: AVG(CAST(fnb_score AS DOUBLE))
      comment: "Average F&B quality score from audits. Steers F&B investment, menu standards, and outlet management."
    - name: "avg_amenity_score"
      expr: AVG(CAST(amenity_score AS DOUBLE))
      comment: "Average amenity quality score. Guides amenity upgrade investment and maintenance prioritization."
    - name: "avg_spa_score"
      expr: AVG(CAST(spa_score AS DOUBLE))
      comment: "Average spa quality score from audits. Informs spa facility investment and therapist training decisions."
    - name: "brand_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits achieving full brand compliance. Core franchise agreement KPI tracked by brand management."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits with a Pass determination. Portfolio-level quality compliance rate."
    - name: "corrective_action_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action. Tracks remediation burden across the portfolio."
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance between current and prior audit score. Tracks improvement trajectory for each property."
    - name: "corrective_action_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_completion_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required corrective actions that were completed. Tracks follow-through on audit remediation commitments."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_reputation_alert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reputation alert KPIs tracking alert volume, severity distribution, response speed, and recovery cost. Enables proactive reputation risk management and SLA compliance monitoring."
  source: "`vibe_travel_hospitality_v1`.`experience`.`reputation_alert`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property associated with the reputation alert — enables property-level reputation risk monitoring."
    - name: "alert_type"
      expr: alert_type
      comment: "Type of reputation alert (e.g., negative review spike, social media mention, complaint threshold) for risk categorization."
    - name: "alert_status"
      expr: alert_status
      comment: "Current status of the alert (Open, Acknowledged, Resolved, Closed) for workload management."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the alert (Critical, High, Medium, Low) for prioritization and escalation."
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of the underlying complaint driving the alert for root-cause analysis."
    - name: "department_responsible"
      expr: department_responsible
      comment: "Department responsible for resolving the alert — enables departmental accountability tracking."
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether the alert was escalated to senior management — tracks severity of reputation incidents."
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether the alert was responded to within SLA — tracks reputation response program discipline."
    - name: "triggered_timestamp_month"
      expr: DATE_TRUNC('month', triggered_timestamp)
      comment: "Month the alert was triggered for trend analysis of reputation risk over time."
  measures:
    - name: "total_reputation_alerts"
      expr: COUNT(1)
      comment: "Total number of reputation alerts triggered. Volume baseline for reputation risk exposure assessment."
    - name: "total_recovery_cost"
      expr: SUM(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Total financial cost of recovery actions associated with reputation alerts. Tracks reputational damage financial impact."
    - name: "avg_recovery_cost"
      expr: AVG(CAST(recovery_cost_amount AS DOUBLE))
      comment: "Average recovery cost per reputation alert. Benchmarks cost of reputational incidents for budget planning."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score of content triggering reputation alerts. Tracks severity of negative sentiment driving alerts."
    - name: "avg_variance_from_threshold"
      expr: AVG(CAST(variance_from_threshold AS DOUBLE))
      comment: "Average variance from the alert threshold score. Measures how far below acceptable levels the triggering content scored."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts responded to within SLA. Tracks reputation management program responsiveness."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts escalated to senior management. Tracks frequency of high-severity reputation incidents."
    - name: "guest_contact_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_contacted_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reputation alerts where the guest was directly contacted. Tracks proactive outreach in reputation recovery."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_amenity_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amenity fulfillment KPIs tracking delivery performance, cost, guest satisfaction, and complimentary amenity spend. Drives operational efficiency and guest experience investment decisions."
  source: "`vibe_travel_hospitality_v1`.`experience`.`amenity_fulfillment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the amenity was fulfilled — enables property-level fulfillment performance benchmarking."
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of amenity (e.g., F&B, floral, turndown) for spend mix and fulfillment performance analysis."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Current fulfillment status (Delivered, Pending, Cancelled, Failed) for operational performance tracking."
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of delivery (in-room, at check-in, via butler) for process efficiency analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the amenity was complimentary — enables cost tracking of complimentary program spend."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier for amenity fulfillment — tracks tier-based amenity program execution."
    - name: "occasion_type"
      expr: occasion_type
      comment: "Occasion type (birthday, anniversary, honeymoon) for occasion-based amenity program analysis."
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Month of scheduled delivery for trend analysis of amenity fulfillment volume."
    - name: "charge_posted_flag"
      expr: charge_posted_flag
      comment: "Whether a charge was posted to the guest folio — tracks revenue capture from amenity fulfillment."
  measures:
    - name: "total_amenity_fulfillments"
      expr: COUNT(1)
      comment: "Total number of amenity fulfillment records. Baseline volume metric for amenity program scale."
    - name: "total_fulfillment_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all amenity fulfillments. Primary financial KPI for amenity program cost management."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost per amenity item. Benchmarks procurement efficiency and vendor pricing."
    - name: "avg_guest_feedback_score"
      expr: AVG(CAST(guest_feedback AS DOUBLE))
      comment: "Average guest feedback score for amenity fulfillments. Measures guest satisfaction with the amenity program."
    - name: "complimentary_amenity_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN total_cost ELSE 0 END)
      comment: "Total cost of complimentary amenities. Tracks the financial investment in loyalty and VIP recognition programs."
    - name: "complimentary_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenity fulfillments that were complimentary. Tracks the scale of complimentary program relative to total fulfillments."
    - name: "fulfillment_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'Delivered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenity fulfillments successfully delivered. Tracks operational execution reliability."
    - name: "guest_acknowledgment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acknowledgment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of fulfillments acknowledged by the guest. Tracks delivery confirmation and guest engagement with amenity program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_experience_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest experience program enrollment KPIs tracking enrollment volume, program completion, satisfaction outcomes, and cost. Drives experience program investment and design decisions."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_experience_enrollment`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the enrollment occurred — enables property-level program participation analysis."
    - name: "program_status"
      expr: program_status
      comment: "Current status of the enrollment (Active, Completed, Cancelled, Waitlisted) for program management."
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which the guest enrolled (app, front desk, concierge) for channel effectiveness analysis."
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source system or campaign that drove the enrollment for attribution analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the enrollment was complimentary — tracks complimentary program cost."
    - name: "amenity_fulfillment_status"
      expr: amenity_fulfillment_status
      comment: "Status of amenity fulfillment associated with the enrollment — tracks program delivery execution."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment for trend analysis of program participation over time."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of program cost for multi-currency portfolio analysis."
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of guest experience program enrollments. Baseline volume metric for program adoption."
    - name: "total_program_cost"
      expr: SUM(CAST(total_program_cost AS DOUBLE))
      comment: "Total cost of all guest experience program enrollments. Primary financial KPI for experience program investment management."
    - name: "avg_program_cost"
      expr: AVG(CAST(total_program_cost AS DOUBLE))
      comment: "Average cost per enrollment. Benchmarks program cost efficiency and informs pricing decisions."
    - name: "avg_post_program_csat_score"
      expr: AVG(CAST(post_program_csat_score AS DOUBLE))
      comment: "Average CSAT score collected after program completion. Measures program satisfaction and ROI on experience investment."
    - name: "avg_post_program_gss_score"
      expr: AVG(CAST(post_program_gss_score AS DOUBLE))
      comment: "Average GSS score collected after program completion. Tracks program impact on overall guest satisfaction."
    - name: "avg_fulfillment_progress_pct"
      expr: AVG(CAST(fulfillment_progress_percentage AS DOUBLE))
      comment: "Average fulfillment progress percentage across enrollments. Tracks program delivery completion rates."
    - name: "complimentary_enrollment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that were complimentary. Tracks the scale of complimentary experience program investment."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN program_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that were cancelled. High cancellation rates signal program design or delivery issues."
    - name: "avg_feedback_score"
      expr: AVG(CAST(feedback_comments AS DOUBLE))
      comment: "Average feedback score from enrolled guests. Measures overall satisfaction with the experience program."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_case_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Case activity KPIs tracking resolution activity efficiency, escalation patterns, compensation offered, and SLA milestone compliance. Drives service team performance management and case resolution optimization."
  source: "`vibe_travel_hospitality_v1`.`experience`.`case_activity`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the case activity occurred — enables property-level service team performance benchmarking."
    - name: "activity_type"
      expr: activity_type
      comment: "Type of case activity (call, email, in-person, escalation) for channel and effort analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (Open, Completed, Pending) for workload management."
    - name: "department_code"
      expr: department_code
      comment: "Department responsible for the activity — enables departmental workload and performance analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the activity involved an escalation — tracks escalation frequency by department and type."
    - name: "priority"
      expr: priority
      comment: "Priority level of the case activity for SLA tier assignment."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the activity (phone, email, chat, in-person) for omnichannel service analysis."
    - name: "guest_sentiment"
      expr: guest_sentiment
      comment: "Sentiment of the guest during the activity — tracks emotional state progression through case resolution."
    - name: "activity_timestamp_month"
      expr: DATE_TRUNC('month', activity_timestamp)
      comment: "Month of activity for trend analysis of case activity volume and patterns."
    - name: "sla_milestone_flag"
      expr: sla_milestone_flag
      comment: "Whether the activity represents an SLA milestone — tracks SLA checkpoint compliance."
  measures:
    - name: "total_case_activities"
      expr: COUNT(1)
      comment: "Total number of case activities logged. Baseline volume metric for service team workload assessment."
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_value AS DOUBLE))
      comment: "Total compensation value offered across all case activities. Tracks financial cost of case resolution compensation."
    - name: "avg_compensation_value"
      expr: AVG(CAST(compensation_value AS DOUBLE))
      comment: "Average compensation value per case activity. Benchmarks compensation generosity and informs policy calibration."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities that involved an escalation. Tracks service team escalation frequency and management burden."
    - name: "compensation_offered_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compensation_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of case activities where compensation was offered. Tracks recovery program utilization rate."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities requiring follow-up. High rates indicate incomplete resolution at first contact."
    - name: "sla_milestone_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_milestone_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of activities that hit SLA milestones on time. Tracks SLA checkpoint adherence across the case lifecycle."
    - name: "distinct_cases_with_activity"
      expr: COUNT(DISTINCT service_case_id)
      comment: "Number of distinct service cases with recorded activities. Tracks active case management coverage."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest interaction KPIs tracking interaction volume, sentiment, special request fulfillment, and VIP engagement. Drives service personalization strategy and staff performance management."
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_interaction`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the interaction occurred — enables property-level interaction quality benchmarking."
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of guest interaction (check-in, concierge, complaint, upsell) for interaction mix analysis."
    - name: "interaction_outcome"
      expr: interaction_outcome
      comment: "Outcome of the interaction (resolved, escalated, referred) for effectiveness measurement."
    - name: "department_code"
      expr: department_code
      comment: "Department that handled the interaction — enables departmental service quality benchmarking."
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification of the interaction — tracks emotional tone of guest-staff interactions."
    - name: "vip_status_flag"
      expr: vip_status_flag
      comment: "Whether the guest has VIP status — enables VIP-specific interaction quality tracking."
    - name: "guest_initiated_flag"
      expr: guest_initiated_flag
      comment: "Whether the interaction was guest-initiated or staff-initiated — tracks proactive service engagement."
    - name: "interaction_timestamp_month"
      expr: DATE_TRUNC('month', interaction_timestamp)
      comment: "Month of interaction for trend analysis of interaction volume and quality over time."
    - name: "nps_eligible_flag"
      expr: nps_eligible_flag
      comment: "Whether the interaction is eligible for NPS survey follow-up — tracks survey program coverage."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of guest interactions recorded. Baseline volume metric for service touchpoint coverage."
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment score across all guest interactions. Real-time service quality signal for operational management."
    - name: "special_request_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN special_request_fulfilled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions where a special request was fulfilled. Tracks service personalization execution rate."
    - name: "vip_interaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN vip_status_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions involving VIP guests. Tracks VIP engagement intensity and recognition program execution."
    - name: "proactive_interaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_initiated_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that were staff-initiated (proactive). Tracks proactive service culture adoption."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions requiring follow-up. Indicates incomplete resolution at first contact."
    - name: "distinct_guests_interacted"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guests with recorded interactions. Tracks breadth of personalized service program reach."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_special_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Special request fulfillment KPIs tracking request volume, fulfillment rates, cost, and guest satisfaction. Drives service personalization investment and operational capacity planning."
  source: "`vibe_travel_hospitality_v1`.`experience`.`experience_special_request`"
  dimensions:
    - name: "property_id"
      expr: property_id
      comment: "Property where the special request was made — enables property-level fulfillment performance benchmarking."
    - name: "request_type"
      expr: request_type
      comment: "Type of special request (dietary, accessibility, room preference, occasion) for demand analysis."
    - name: "request_subtype"
      expr: request_subtype
      comment: "Detailed subtype for granular request categorization and fulfillment capacity planning."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the request (Pending, Fulfilled, Cancelled, Failed) for operational tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request for resource allocation and SLA assignment."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the request was fulfilled complimentarily — tracks complimentary service program cost."
    - name: "is_loyalty_member_request"
      expr: is_loyalty_member_request
      comment: "Whether the request was from a loyalty member — tracks loyalty program service differentiation."
    - name: "is_service_recovery"
      expr: is_service_recovery
      comment: "Whether the request is part of a service recovery — tracks recovery-driven special request volume."
    - name: "request_source"
      expr: request_source
      comment: "Channel through which the request was submitted (app, front desk, pre-arrival email) for channel analysis."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Guest loyalty tier for the request — enables tier-based fulfillment performance analysis."
  measures:
    - name: "total_special_requests"
      expr: COUNT(1)
      comment: "Total number of special requests submitted. Baseline volume metric for service personalization demand."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost of fulfilling special requests. Primary financial KPI for special request program cost management."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost of special requests. Used for budget planning and cost variance analysis."
    - name: "avg_actual_cost"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per special request. Benchmarks fulfillment cost efficiency."
    - name: "cost_variance"
      expr: SUM((CAST(actual_cost_amount AS DOUBLE)) - (CAST(estimated_cost_amount AS DOUBLE)))
      comment: "Total variance between actual and estimated fulfillment cost. Tracks cost estimation accuracy and budget adherence."
    - name: "fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN request_status = 'Fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests successfully fulfilled. Core service personalization execution KPI."
    - name: "avg_guest_satisfaction_rating"
      expr: AVG(CAST(guest_feedback_comment AS DOUBLE))
      comment: "Average guest satisfaction rating for special request fulfillment. Measures quality of personalized service delivery."
    - name: "repeat_request_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_repeat_request = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests that are repeat requests from the same guest. Tracks preference learning and anticipatory service effectiveness."
    - name: "loyalty_member_request_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_loyalty_member_request = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of special requests from loyalty members. Tracks loyalty program service differentiation utilization."
    - name: "total_charge_to_guest"
      expr: SUM(CAST(charge_to_guest_amount AS DOUBLE))
      comment: "Total amount charged to guests for special request fulfillment. Tracks revenue capture from special request services."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_guest_predictive_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest predictive score KPIs tracking AI model coverage and score distribution for churn risk and upsell propensity. Enables data-driven personalization and proactive retention investment decisions. (VREQ-023: AI/ML story for guest domain.)"
  source: "`vibe_travel_hospitality_v1`.`experience`.`guest_predictive_score`"
  dimensions:
    - name: "model_version"
      expr: model_version
      comment: "Version of the predictive model that generated the score — enables model performance comparison and governance."
    - name: "churn_risk_score"
      expr: churn_risk_score
      comment: "Churn risk score band for the guest — used as a dimension to segment guests by retention risk level."
    - name: "upsell_propensity_score"
      expr: upsell_propensity_score
      comment: "Upsell propensity score band — used as a dimension to segment guests by revenue uplift opportunity."
    - name: "next_best_offer_code"
      expr: next_best_offer_code
      comment: "Next-best-offer recommendation code — tracks offer distribution across the guest base."
    - name: "scored_timestamp_month"
      expr: DATE_TRUNC('month', scored_timestamp)
      comment: "Month the score was generated for model refresh cadence monitoring."
  measures:
    - name: "total_scored_guests"
      expr: COUNT(1)
      comment: "Total number of guest profiles with a predictive score. Tracks AI model coverage across the guest base."
    - name: "distinct_scored_profiles"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of distinct guest profiles scored. Ensures model coverage breadth for personalization program reach."
    - name: "distinct_offer_codes_recommended"
      expr: COUNT(DISTINCT next_best_offer_code)
      comment: "Number of distinct next-best-offer codes recommended. Tracks offer diversity in the AI recommendation engine."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`experience_nps_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NPS survey program KPIs tracking survey configuration, response rate targets, and program coverage. Drives survey program design and response rate improvement investment."
  source: "`vibe_travel_hospitality_v1`.`experience`.`nps_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of NPS survey (post-stay, in-stay, post-event) for program coverage analysis."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey program (Active, Paused, Archived) for program management."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Event that triggers the survey (checkout, F&B visit, spa treatment) for touchpoint coverage analysis."
    - name: "target_segment"
      expr: target_segment
      comment: "Target guest segment for the survey — enables segment-specific survey program design."
    - name: "language_code"
      expr: language_code
      comment: "Language of the survey for multilingual program coverage analysis."
    - name: "distribution_frequency"
      expr: distribution_frequency
      comment: "How frequently the survey is distributed — tracks survey fatigue risk management."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the survey program became effective for program lifecycle tracking."
    - name: "salt_program_linked_flag"
      expr: salt_program_linked_flag
      comment: "Whether the survey is linked to the SALT brand program — tracks brand program integration."
    - name: "incentive_offered_flag"
      expr: incentive_offered_flag
      comment: "Whether an incentive is offered for survey completion — tracks incentive program utilization."
  measures:
    - name: "total_active_surveys"
      expr: COUNT(1)
      comment: "Total number of NPS survey programs. Baseline for survey program portfolio management."
    - name: "avg_target_response_rate_pct"
      expr: AVG(CAST(target_response_rate_percent AS DOUBLE))
      comment: "Average target response rate across survey programs. Benchmarks ambition level of the survey program portfolio."
    - name: "distinct_trigger_events"
      expr: COUNT(DISTINCT trigger_event)
      comment: "Number of distinct trigger events covered by NPS surveys. Tracks touchpoint coverage breadth of the survey program."
    - name: "incentive_program_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN incentive_offered_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of survey programs offering an incentive. Tracks investment in response rate improvement through incentivization."
    - name: "salt_linked_survey_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN salt_program_linked_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPS surveys linked to the SALT brand program. Tracks brand program integration completeness."
$$;