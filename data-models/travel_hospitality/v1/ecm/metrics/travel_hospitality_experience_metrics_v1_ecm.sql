-- Metric views for domain: experience | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 03:54:25

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_guest_feedback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest satisfaction and feedback metrics tracking CSAT, NPS, GSS scores, and sentiment across all guest touchpoints and channels"
  source: "`travel_hospitality_ecm`.`experience`.`guest_feedback`"
  dimensions:
    - name: "feedback_date"
      expr: DATE_TRUNC('day', submission_timestamp)
      comment: "Date the feedback was submitted by the guest"
    - name: "feedback_month"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Month of feedback submission for trend analysis"
    - name: "stay_month"
      expr: DATE_TRUNC('month', stay_date_from)
      comment: "Month of the guest stay being reviewed"
    - name: "guest_segment"
      expr: guest_segment
      comment: "Guest market segment classification"
    - name: "nps_classification"
      expr: nps_classification
      comment: "NPS classification: Promoter, Passive, or Detractor"
    - name: "sentiment_indicator"
      expr: sentiment_indicator
      comment: "Overall sentiment classification of the feedback"
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Whether the feedback contains a complaint"
    - name: "service_recovery_required_flag"
      expr: service_recovery_required_flag
      comment: "Whether service recovery action is required"
    - name: "would_recommend_flag"
      expr: would_recommend_flag
      comment: "Whether guest would recommend the property"
    - name: "would_return_flag"
      expr: would_return_flag
      comment: "Whether guest would return to the property"
    - name: "survey_completion_status"
      expr: survey_completion_status
      comment: "Status of survey completion"
    - name: "language_code"
      expr: language_code
      comment: "Language in which feedback was provided"
  measures:
    - name: "total_feedback_responses"
      expr: COUNT(1)
      comment: "Total number of guest feedback responses received"
    - name: "unique_guests_providing_feedback"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests who provided feedback"
    - name: "avg_overall_rating"
      expr: AVG(CAST(overall_rating AS DOUBLE))
      comment: "Average overall guest satisfaction rating"
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average Customer Satisfaction (CSAT) score"
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score AS DOUBLE))
      comment: "Average Guest Satisfaction Score (GSS) - primary satisfaction metric"
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average rating for service quality"
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average rating for property cleanliness"
    - name: "avg_room_rating"
      expr: AVG(CAST(room_rating AS DOUBLE))
      comment: "Average rating for room quality"
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average rating for property amenities"
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average rating for property location"
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average rating for value received"
    - name: "avg_fnb_rating"
      expr: AVG(CAST(fnb_rating AS DOUBLE))
      comment: "Average rating for food and beverage services"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment analysis score from feedback text"
    - name: "avg_response_time_hours"
      expr: AVG(CAST(response_time_hours AS DOUBLE))
      comment: "Average time in hours to respond to guest feedback"
    - name: "complaint_count"
      expr: SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Total number of feedback responses containing complaints"
    - name: "complaint_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN complaint_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback responses that contain complaints"
    - name: "service_recovery_required_count"
      expr: SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of feedback responses requiring service recovery action"
    - name: "service_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN service_recovery_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of feedback requiring service recovery intervention"
    - name: "would_recommend_count"
      expr: SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of guests who would recommend the property"
    - name: "recommendation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN would_recommend_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who would recommend the property - key loyalty indicator"
    - name: "would_return_count"
      expr: SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of guests who would return to the property"
    - name: "return_intent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN would_return_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of guests who would return - key retention indicator"
    - name: "promoter_count"
      expr: SUM(CASE WHEN nps_classification = 'Promoter' THEN 1 ELSE 0 END)
      comment: "Number of NPS promoters (score 9-10)"
    - name: "detractor_count"
      expr: SUM(CASE WHEN nps_classification = 'Detractor' THEN 1 ELSE 0 END)
      comment: "Number of NPS detractors (score 0-6)"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service case resolution and efficiency metrics tracking guest issues, complaints, and service recovery effectiveness"
  source: "`travel_hospitality_ecm`.`experience`.`service_case`"
  dimensions:
    - name: "case_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the service case was created"
    - name: "case_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the service case was created"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case"
    - name: "case_category"
      expr: case_category
      comment: "Primary category of the service case"
    - name: "case_subcategory"
      expr: case_subcategory
      comment: "Detailed subcategory of the service case"
    - name: "case_origin"
      expr: case_origin
      comment: "Channel through which the case was originated"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the case"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the case"
    - name: "resolution_type"
      expr: resolution_type
      comment: "Type of resolution provided"
    - name: "root_cause"
      expr: root_cause
      comment: "Identified root cause of the issue"
    - name: "guest_lifetime_value_segment"
      expr: guest_lifetime_value_segment
      comment: "Guest lifetime value segment classification"
    - name: "guest_satisfaction_post_resolution"
      expr: guest_satisfaction_post_resolution
      comment: "Guest satisfaction level after case resolution"
    - name: "sla_compliance_flag"
      expr: sla_compliance_flag
      comment: "Whether case was resolved within SLA target"
    - name: "grr_outcome_flag"
      expr: grr_outcome_flag
      comment: "Whether case resulted in Guest Recovery Resolution (GRR) outcome"
    - name: "preventable_flag"
      expr: preventable_flag
      comment: "Whether the issue was preventable"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required"
    - name: "social_media_mention_flag"
      expr: social_media_mention_flag
      comment: "Whether case involved social media mention"
  measures:
    - name: "total_service_cases"
      expr: COUNT(1)
      comment: "Total number of service cases opened"
    - name: "unique_guests_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests who opened service cases"
    - name: "avg_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average time in hours to resolve service cases"
    - name: "total_compensation_value"
      expr: SUM(CAST(compensation_total_value AS DOUBLE))
      comment: "Total monetary value of compensation provided across all cases"
    - name: "avg_compensation_per_case"
      expr: AVG(CAST(compensation_total_value AS DOUBLE))
      comment: "Average compensation value per service case"
    - name: "sla_compliant_cases"
      expr: SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases resolved within SLA target"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases resolved within SLA - key operational efficiency metric"
    - name: "grr_outcome_cases"
      expr: SUM(CASE WHEN grr_outcome_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases with successful Guest Recovery Resolution outcome"
    - name: "grr_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN grr_outcome_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases achieving Guest Recovery Resolution - key service recovery effectiveness metric"
    - name: "preventable_cases"
      expr: SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases identified as preventable"
    - name: "preventable_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN preventable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were preventable - key quality improvement indicator"
    - name: "escalated_cases"
      expr: SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 ELSE 0 END)
      comment: "Number of cases that required escalation"
    - name: "escalation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_status IS NOT NULL AND escalation_status != 'None' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring escalation - indicator of first-contact resolution effectiveness"
    - name: "social_media_cases"
      expr: SUM(CASE WHEN social_media_mention_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases involving social media mentions"
    - name: "social_media_case_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN social_media_mention_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with social media mentions - reputation risk indicator"
    - name: "follow_up_required_cases"
      expr: SUM(CASE WHEN follow_up_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of cases requiring follow-up action"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_online_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Online reputation and review metrics tracking guest ratings, sentiment, and management response effectiveness across OTA and review platforms"
  source: "`travel_hospitality_ecm`.`experience`.`online_review`"
  dimensions:
    - name: "review_date"
      expr: DATE_TRUNC('day', review_date)
      comment: "Date the review was posted"
    - name: "review_month"
      expr: DATE_TRUNC('month', review_date)
      comment: "Month the review was posted"
    - name: "stay_month"
      expr: DATE_TRUNC('month', stay_start_date)
      comment: "Month of the guest stay being reviewed"
    - name: "sentiment_classification"
      expr: sentiment_classification
      comment: "Sentiment classification of the review (positive, neutral, negative)"
    - name: "traveler_type"
      expr: traveler_type
      comment: "Type of traveler who posted the review"
    - name: "review_language_code"
      expr: review_language_code
      comment: "Language in which the review was written"
    - name: "verified_stay_flag"
      expr: verified_stay_flag
      comment: "Whether the review is from a verified stay"
    - name: "management_response_status"
      expr: management_response_status
      comment: "Status of management response to the review"
    - name: "review_visibility_status"
      expr: review_visibility_status
      comment: "Visibility status of the review on the platform"
    - name: "competitive_set_flag"
      expr: competitive_set_flag
      comment: "Whether review is from competitive set property"
  measures:
    - name: "total_online_reviews"
      expr: COUNT(1)
      comment: "Total number of online reviews received"
    - name: "unique_reviewers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests who posted reviews"
    - name: "avg_normalized_rating"
      expr: AVG(CAST(normalized_rating AS DOUBLE))
      comment: "Average normalized rating across all platforms (standardized scale)"
    - name: "avg_platform_native_rating"
      expr: AVG(CAST(platform_native_rating AS DOUBLE))
      comment: "Average rating in platform native scale"
    - name: "avg_cleanliness_rating"
      expr: AVG(CAST(cleanliness_rating AS DOUBLE))
      comment: "Average cleanliness rating from online reviews"
    - name: "avg_service_rating"
      expr: AVG(CAST(service_rating AS DOUBLE))
      comment: "Average service rating from online reviews"
    - name: "avg_location_rating"
      expr: AVG(CAST(location_rating AS DOUBLE))
      comment: "Average location rating from online reviews"
    - name: "avg_value_rating"
      expr: AVG(CAST(value_rating AS DOUBLE))
      comment: "Average value rating from online reviews"
    - name: "avg_amenities_rating"
      expr: AVG(CAST(amenities_rating AS DOUBLE))
      comment: "Average amenities rating from online reviews"
    - name: "avg_sentiment_score"
      expr: AVG(CAST(sentiment_score AS DOUBLE))
      comment: "Average sentiment analysis score from review text"
    - name: "verified_stay_reviews"
      expr: SUM(CASE WHEN verified_stay_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of reviews from verified stays"
    - name: "verified_stay_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verified_stay_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews from verified stays - credibility indicator"
    - name: "reviews_with_management_response"
      expr: SUM(CASE WHEN management_response_status = 'Responded' THEN 1 ELSE 0 END)
      comment: "Number of reviews that received management response"
    - name: "management_response_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN management_response_status = 'Responded' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews receiving management response - key engagement metric"
    - name: "positive_sentiment_reviews"
      expr: SUM(CASE WHEN sentiment_classification = 'Positive' THEN 1 ELSE 0 END)
      comment: "Number of reviews with positive sentiment"
    - name: "negative_sentiment_reviews"
      expr: SUM(CASE WHEN sentiment_classification = 'Negative' THEN 1 ELSE 0 END)
      comment: "Number of reviews with negative sentiment"
    - name: "positive_sentiment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sentiment_classification = 'Positive' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reviews with positive sentiment - key reputation health indicator"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_gss_score`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest Satisfaction Score (GSS) performance metrics tracking property-level satisfaction trends, NPS, and target attainment"
  source: "`travel_hospitality_ecm`.`experience`.`gss_score`"
  dimensions:
    - name: "measurement_period_start"
      expr: DATE_TRUNC('day', measurement_start_date)
      comment: "Start date of the GSS measurement period"
    - name: "measurement_period_end"
      expr: DATE_TRUNC('day', measurement_end_date)
      comment: "End date of the GSS measurement period"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (daily, weekly, monthly, quarterly)"
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code for the property"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code"
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment classification"
    - name: "department_code"
      expr: department_code
      comment: "Department code for departmental GSS tracking"
    - name: "score_band"
      expr: score_band
      comment: "GSS score performance band classification"
    - name: "salt_target_attained_flag"
      expr: salt_target_attained_flag
      comment: "Whether SALT (Service and Loyalty Tracking) target was attained"
    - name: "published_flag"
      expr: published_flag
      comment: "Whether the GSS score has been published"
    - name: "gm_review_required_flag"
      expr: gm_review_required_flag
      comment: "Whether General Manager review is required"
    - name: "brand_qa_review_flag"
      expr: brand_qa_review_flag
      comment: "Whether brand quality assurance review is required"
  measures:
    - name: "total_gss_measurements"
      expr: COUNT(1)
      comment: "Total number of GSS measurement periods"
    - name: "unique_properties_measured"
      expr: COUNT(DISTINCT property_id)
      comment: "Distinct count of properties with GSS measurements"
    - name: "avg_gss_score"
      expr: AVG(CAST(gss_score_value AS DOUBLE))
      comment: "Average Guest Satisfaction Score - primary satisfaction metric"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score"
    - name: "avg_top_box_percent"
      expr: AVG(CAST(top_box_percent AS DOUBLE))
      comment: "Average percentage of top-box (highest) satisfaction ratings"
    - name: "avg_bottom_box_percent"
      expr: AVG(CAST(bottom_box_percent AS DOUBLE))
      comment: "Average percentage of bottom-box (lowest) satisfaction ratings"
    - name: "avg_promoter_percent"
      expr: AVG(CAST(promoter_percent AS DOUBLE))
      comment: "Average percentage of NPS promoters"
    - name: "avg_detractor_percent"
      expr: AVG(CAST(detractor_percent AS DOUBLE))
      comment: "Average percentage of NPS detractors"
    - name: "avg_passive_percent"
      expr: AVG(CAST(passive_percent AS DOUBLE))
      comment: "Average percentage of NPS passives"
    - name: "avg_grr_percent"
      expr: AVG(CAST(grr_percent AS DOUBLE))
      comment: "Average Guest Recovery Resolution percentage"
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average survey response rate percentage"
    - name: "avg_prior_period_variance"
      expr: AVG(CAST(prior_period_variance AS DOUBLE))
      comment: "Average variance from prior period GSS score"
    - name: "avg_yoy_variance"
      expr: AVG(CAST(yoy_variance AS DOUBLE))
      comment: "Average year-over-year variance in GSS score"
    - name: "salt_target_attainment_count"
      expr: SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of periods where SALT target was attained"
    - name: "salt_target_attainment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN salt_target_attained_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of periods achieving SALT target - key performance indicator"
    - name: "avg_salt_target_score"
      expr: AVG(CAST(salt_target_score AS DOUBLE))
      comment: "Average SALT target score threshold"
    - name: "gm_review_required_count"
      expr: SUM(CASE WHEN gm_review_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of periods requiring General Manager review"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_service_recovery_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service recovery action effectiveness metrics tracking compensation, fulfillment, and post-recovery satisfaction outcomes"
  source: "`travel_hospitality_ecm`.`experience`.`service_recovery_action`"
  dimensions:
    - name: "action_created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the service recovery action was created"
    - name: "action_created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the service recovery action was created"
    - name: "recovery_action_category"
      expr: recovery_action_category
      comment: "Category of service recovery action"
    - name: "recovery_action_type"
      expr: recovery_action_type
      comment: "Specific type of service recovery action"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of recovery action fulfillment"
    - name: "guest_acceptance_status"
      expr: guest_acceptance_status
      comment: "Guest acceptance status of the recovery action"
    - name: "authorization_level"
      expr: authorization_level
      comment: "Authorization level required for the recovery action"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the service recovery action"
    - name: "is_proactive"
      expr: is_proactive
      comment: "Whether the recovery action was proactive (before complaint)"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up is required after recovery action"
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used to communicate the recovery action"
    - name: "cost_center_code"
      expr: cost_center_code
      comment: "Cost center code for recovery action expense"
  measures:
    - name: "total_recovery_actions"
      expr: COUNT(1)
      comment: "Total number of service recovery actions taken"
    - name: "unique_guests_receiving_recovery"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests receiving service recovery actions"
    - name: "total_recovery_monetary_value"
      expr: SUM(CAST(monetary_value AS DOUBLE))
      comment: "Total monetary value of all service recovery actions"
    - name: "avg_recovery_monetary_value"
      expr: AVG(CAST(monetary_value AS DOUBLE))
      comment: "Average monetary value per service recovery action"
    - name: "fulfilled_actions"
      expr: SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END)
      comment: "Number of recovery actions successfully fulfilled"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions successfully fulfilled - key execution metric"
    - name: "guest_accepted_actions"
      expr: SUM(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 ELSE 0 END)
      comment: "Number of recovery actions accepted by guests"
    - name: "guest_acceptance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acceptance_status = 'Accepted' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions accepted by guests - key satisfaction indicator"
    - name: "proactive_recovery_actions"
      expr: SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END)
      comment: "Number of proactive service recovery actions"
    - name: "proactive_recovery_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_proactive = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of recovery actions that were proactive - service excellence indicator"
    - name: "follow_up_required_actions"
      expr: SUM(CASE WHEN follow_up_required = TRUE THEN 1 ELSE 0 END)
      comment: "Number of recovery actions requiring follow-up"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_quality_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property quality audit and brand compliance metrics tracking audit scores, deficiencies, and corrective action effectiveness"
  source: "`travel_hospitality_ecm`.`experience`.`quality_audit`"
  dimensions:
    - name: "audit_date"
      expr: DATE_TRUNC('day', audit_date)
      comment: "Date the quality audit was conducted"
    - name: "audit_month"
      expr: DATE_TRUNC('month', audit_date)
      comment: "Month the quality audit was conducted"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of quality audit conducted"
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit"
    - name: "auditor_organization"
      expr: auditor_organization
      comment: "Organization conducting the audit"
    - name: "pass_fail_determination"
      expr: pass_fail_determination
      comment: "Pass or fail determination of the audit"
    - name: "certification_level_achieved"
      expr: certification_level_achieved
      comment: "Certification level achieved in the audit"
    - name: "brand_compliance_flag"
      expr: brand_compliance_flag
      comment: "Whether property is in brand compliance"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "corrective_action_completion_status"
      expr: corrective_action_completion_status
      comment: "Status of corrective action completion"
    - name: "re_inspection_required_flag"
      expr: re_inspection_required_flag
      comment: "Whether re-inspection is required"
    - name: "gm_accountability_flag"
      expr: gm_accountability_flag
      comment: "Whether General Manager accountability is flagged"
  measures:
    - name: "total_quality_audits"
      expr: COUNT(1)
      comment: "Total number of quality audits conducted"
    - name: "unique_properties_audited"
      expr: COUNT(DISTINCT property_id)
      comment: "Distinct count of properties audited"
    - name: "avg_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall audit score across all audits"
    - name: "avg_housekeeping_score"
      expr: AVG(CAST(housekeeping_score AS DOUBLE))
      comment: "Average housekeeping audit score"
    - name: "avg_service_score"
      expr: AVG(CAST(service_score AS DOUBLE))
      comment: "Average service audit score"
    - name: "avg_facility_score"
      expr: AVG(CAST(facility_score AS DOUBLE))
      comment: "Average facility audit score"
    - name: "avg_fnb_score"
      expr: AVG(CAST(fnb_score AS DOUBLE))
      comment: "Average food and beverage audit score"
    - name: "avg_amenity_score"
      expr: AVG(CAST(amenity_score AS DOUBLE))
      comment: "Average amenity audit score"
    - name: "avg_spa_score"
      expr: AVG(CAST(spa_score AS DOUBLE))
      comment: "Average spa audit score"
    - name: "avg_score_variance"
      expr: AVG(CAST(score_variance AS DOUBLE))
      comment: "Average variance from prior audit score"
    - name: "audits_passed"
      expr: SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END)
      comment: "Number of audits with pass determination"
    - name: "audit_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_determination = 'Pass' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits passed - key quality compliance metric"
    - name: "brand_compliant_audits"
      expr: SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits meeting brand compliance standards"
    - name: "brand_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN brand_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits meeting brand compliance - key brand standards metric"
    - name: "total_critical_deficiencies"
      expr: SUM(CAST(critical_deficiency_count AS BIGINT))
      comment: "Total number of critical deficiencies identified"
    - name: "total_major_deficiencies"
      expr: SUM(CAST(major_deficiency_count AS BIGINT))
      comment: "Total number of major deficiencies identified"
    - name: "total_minor_deficiencies"
      expr: SUM(CAST(minor_deficiency_count AS BIGINT))
      comment: "Total number of minor deficiencies identified"
    - name: "total_deficiencies"
      expr: SUM(CAST(deficiency_count AS BIGINT))
      comment: "Total number of all deficiencies identified"
    - name: "corrective_action_required_audits"
      expr: SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring corrective action"
    - name: "corrective_action_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of audits requiring corrective action"
    - name: "re_inspection_required_audits"
      expr: SUM(CASE WHEN re_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of audits requiring re-inspection"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_amenity_fulfillment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest amenity fulfillment and delivery metrics tracking fulfillment status, costs, and guest satisfaction with amenity services"
  source: "`travel_hospitality_ecm`.`experience`.`amenity_fulfillment`"
  dimensions:
    - name: "scheduled_delivery_date"
      expr: DATE_TRUNC('day', scheduled_delivery_date)
      comment: "Scheduled date for amenity delivery"
    - name: "scheduled_delivery_month"
      expr: DATE_TRUNC('month', scheduled_delivery_date)
      comment: "Scheduled month for amenity delivery"
    - name: "actual_delivery_date"
      expr: DATE_TRUNC('day', actual_delivery_timestamp)
      comment: "Actual date amenity was delivered"
    - name: "amenity_category"
      expr: amenity_category
      comment: "Category of amenity provided"
    - name: "amenity_name"
      expr: amenity_name
      comment: "Name of the specific amenity"
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Status of amenity fulfillment"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method used to deliver the amenity"
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the amenity was complimentary"
    - name: "charge_posted_flag"
      expr: charge_posted_flag
      comment: "Whether charge was posted to guest folio"
    - name: "guest_acknowledgment_flag"
      expr: guest_acknowledgment_flag
      comment: "Whether guest acknowledged receipt"
    - name: "guest_satisfaction_score"
      expr: guest_satisfaction_score
      comment: "Guest satisfaction score for the amenity"
    - name: "occasion_type"
      expr: occasion_type
      comment: "Type of occasion for the amenity (birthday, anniversary, etc.)"
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Loyalty tier of the guest receiving amenity"
  measures:
    - name: "total_amenity_fulfillments"
      expr: COUNT(1)
      comment: "Total number of amenity fulfillment requests"
    - name: "unique_guests_receiving_amenities"
      expr: COUNT(DISTINCT guest_profile_id)
      comment: "Distinct count of guests receiving amenities"
    - name: "total_amenity_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all amenities fulfilled"
    - name: "avg_amenity_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per amenity fulfillment"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of amenities"
    - name: "fulfilled_amenities"
      expr: SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END)
      comment: "Number of amenities successfully fulfilled"
    - name: "fulfillment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fulfillment_status = 'Fulfilled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenities successfully fulfilled - key service delivery metric"
    - name: "complimentary_amenities"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END)
      comment: "Number of complimentary amenities provided"
    - name: "complimentary_amenity_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenities provided complimentary"
    - name: "total_complimentary_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of complimentary amenities - key cost metric"
    - name: "guest_acknowledged_amenities"
      expr: SUM(CASE WHEN guest_acknowledgment_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of amenities acknowledged by guests"
    - name: "guest_acknowledgment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN guest_acknowledgment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of amenities acknowledged by guests - delivery confirmation metric"
    - name: "charges_posted"
      expr: SUM(CASE WHEN charge_posted_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Number of amenities with charges posted to folio"
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`experience_guest_experience_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Guest experience program enrollment and participation metrics tracking program costs, completion, and post-program satisfaction"
  source: "`travel_hospitality_ecm`.`experience`.`guest_experience_enrollment`"
  dimensions:
    - name: "enrollment_date"
      expr: DATE_TRUNC('day', enrollment_date)
      comment: "Date of program enrollment"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of program enrollment"
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('day', scheduled_start_date)
      comment: "Scheduled start date of the program"
    - name: "scheduled_end_date"
      expr: DATE_TRUNC('day', scheduled_end_date)
      comment: "Scheduled end date of the program"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the program enrollment"
    - name: "enrollment_channel"
      expr: enrollment_channel
      comment: "Channel through which enrollment occurred"
    - name: "enrollment_source"
      expr: enrollment_source
      comment: "Source of the enrollment"
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Whether the program is complimentary"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for the program"
    - name: "amenity_fulfillment_status"
      expr: amenity_fulfillment_status
      comment: "Status of amenity fulfillment for the program"
  measures:
    - name: "total_program_enrollments"
      expr: COUNT(1)
      comment: "Total number of guest experience program enrollments"
    - name: "unique_guests_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of guests enrolled in programs"
    - name: "total_program_cost"
      expr: SUM(CAST(total_program_cost AS DOUBLE))
      comment: "Total cost of all guest experience programs"
    - name: "avg_program_cost"
      expr: AVG(CAST(total_program_cost AS DOUBLE))
      comment: "Average cost per guest experience program"
    - name: "avg_fulfillment_progress"
      expr: AVG(CAST(fulfillment_progress_percentage AS DOUBLE))
      comment: "Average fulfillment progress percentage across programs"
    - name: "avg_post_program_csat"
      expr: AVG(CAST(post_program_csat_score AS DOUBLE))
      comment: "Average post-program Customer Satisfaction score"
    - name: "avg_post_program_gss"
      expr: AVG(CAST(post_program_gss_score AS DOUBLE))
      comment: "Average post-program Guest Satisfaction Score"
    - name: "complimentary_programs"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END)
      comment: "Number of complimentary programs provided"
    - name: "complimentary_program_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_complimentary = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs provided complimentary"
    - name: "total_complimentary_program_cost"
      expr: SUM(CASE WHEN is_complimentary = TRUE THEN CAST(total_program_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of complimentary programs - key investment metric"
    - name: "completed_programs"
      expr: SUM(CASE WHEN program_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Number of programs completed"
    - name: "program_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN program_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of programs completed - key engagement metric"
$$;