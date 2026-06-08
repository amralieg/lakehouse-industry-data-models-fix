-- Metric views for domain: customer | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 19:57:14

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, credit exposure, and customer lifecycle performance"
  source: "`waste_management_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, suspended, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account (commercial, residential, industrial)"
    - name: "account_tier"
      expr: account_tier
      comment: "Customer tier classification for service and pricing differentiation"
    - name: "waste_generator_class"
      expr: waste_generator_class
      comment: "EPA waste generator classification (large quantity, small quantity, conditionally exempt)"
    - name: "customer_since_year"
      expr: YEAR(customer_since_date)
      comment: "Year the customer relationship began"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the customer account"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms negotiated with customer"
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Whether customer is enrolled in automatic payment"
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Whether customer has opted for paperless billing"
    - name: "portal_access_enabled"
      expr: portal_access_enabled
      comment: "Whether customer has online portal access enabled"
  measures:
    - name: "total_customer_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total number of unique customer accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per customer account"
    - name: "autopay_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN autopay_enrolled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers enrolled in autopay - key indicator of payment automation and DSO reduction"
    - name: "paperless_adoption_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN paperless_billing = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers using paperless billing - drives operational cost reduction"
    - name: "portal_activation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN portal_access_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of customers with portal access enabled - indicates digital engagement and self-service adoption"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service request performance metrics tracking fulfillment efficiency, SLA compliance, and customer satisfaction"
  source: "`waste_management_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request"
    - name: "request_type_code"
      expr: request_type_code
      comment: "Type of service request"
    - name: "request_subtype_code"
      expr: request_subtype_code
      comment: "Subtype classification of service request"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the service request"
    - name: "channel_source"
      expr: channel_source
      comment: "Channel through which the service request was submitted"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the service request was escalated"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the service request breached SLA"
    - name: "regulatory_flag"
      expr: regulatory_flag
      comment: "Whether the service request has regulatory implications"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the service request was submitted"
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream associated with the service request"
  measures:
    - name: "total_service_requests"
      expr: COUNT(DISTINCT service_request_id)
      comment: "Total number of service requests"
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests that breached SLA - critical operational quality metric"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests that required escalation - indicates first-line resolution effectiveness"
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score for completed service requests"
    - name: "total_additional_charges"
      expr: SUM(CAST(additional_charge_amount AS DOUBLE))
      comment: "Total additional charges generated from service requests - incremental revenue opportunity"
    - name: "avg_estimated_weight_tons"
      expr: AVG(CAST(estimated_weight_tons AS DOUBLE))
      comment: "Average estimated weight in tons per service request"
    - name: "regulatory_request_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests with regulatory implications - compliance risk indicator"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint metrics tracking resolution performance, root causes, and financial impact"
  source: "`waste_management_ecm`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Type of complaint"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel of the complaint"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the complaint"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated"
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Whether the complaint was escalated to regulatory authorities"
    - name: "repeat_complaint_flag"
      expr: repeat_complaint_flag
      comment: "Whether this is a repeat complaint"
    - name: "credit_issued_flag"
      expr: credit_issued_flag
      comment: "Whether a credit was issued to resolve the complaint"
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Root cause classification of the complaint"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Outcome of the complaint resolution"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month when the complaint was received"
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the complaint"
  measures:
    - name: "total_complaints"
      expr: COUNT(DISTINCT complaint_id)
      comment: "Total number of customer complaints"
    - name: "regulatory_escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints escalated to regulatory authorities - critical compliance risk metric"
    - name: "repeat_complaint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_complaint_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints that are repeats - indicates systemic issue resolution effectiveness"
    - name: "total_credit_issued"
      expr: SUM(CAST(credit_amount_usd AS DOUBLE))
      comment: "Total credit amount issued to resolve complaints - direct financial impact of service failures"
    - name: "avg_credit_per_complaint"
      expr: AVG(CAST(credit_amount_usd AS DOUBLE))
      comment: "Average credit amount issued per complaint"
    - name: "credit_issuance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of complaints resolved with credit issuance - indicates financial remedy frequency"
    - name: "total_billing_disputes"
      expr: SUM(CAST(billing_dispute_amount_usd AS DOUBLE))
      comment: "Total amount under billing dispute - revenue at risk metric"
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score post-complaint resolution"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_nps_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Net Promoter Score metrics tracking customer loyalty, satisfaction trends, and feedback quality"
  source: "`waste_management_ecm`.`customer`.`nps_response`"
  dimensions:
    - name: "nps_score"
      expr: nps_score
      comment: "Net Promoter Score value (0-10)"
    - name: "respondent_category"
      expr: respondent_category
      comment: "Category of respondent (promoter, passive, detractor)"
    - name: "survey_channel"
      expr: survey_channel
      comment: "Channel through which the survey was administered"
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the NPS response"
    - name: "trigger_event_type"
      expr: trigger_event_type
      comment: "Event that triggered the NPS survey"
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Whether follow-up action is required based on the response"
    - name: "follow_up_status"
      expr: follow_up_status
      comment: "Status of follow-up action"
    - name: "response_month"
      expr: DATE_TRUNC('MONTH', response_timestamp)
      comment: "Month when the NPS response was received"
    - name: "survey_language"
      expr: survey_language
      comment: "Language in which the survey was administered"
    - name: "device_type"
      expr: device_type
      comment: "Device type used to complete the survey"
  measures:
    - name: "total_nps_responses"
      expr: COUNT(DISTINCT nps_response_id)
      comment: "Total number of NPS survey responses"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score - primary customer loyalty metric"
    - name: "avg_secondary_question_score"
      expr: AVG(CAST(secondary_question_score AS DOUBLE))
      comment: "Average score for secondary survey question"
    - name: "avg_response_latency_hours"
      expr: AVG(CAST(response_latency_hours AS DOUBLE))
      comment: "Average time in hours between survey send and response - indicates engagement level"
    - name: "follow_up_required_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of NPS responses requiring follow-up - indicates detractor volume and service recovery workload"
    - name: "verbatim_feedback_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verbatim_feedback IS NOT NULL AND verbatim_feedback != '' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of responses with verbatim feedback - indicates depth of customer engagement"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_service_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service enrollment metrics tracking active services, revenue, and customer retention"
  source: "`waste_management_ecm`.`customer`.`service_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the service enrollment"
    - name: "service_frequency"
      expr: service_frequency
      comment: "Frequency of service delivery"
    - name: "service_level"
      expr: service_level
      comment: "Level of service provided"
    - name: "container_type"
      expr: container_type
      comment: "Type of container assigned to the service"
    - name: "hazardous_waste_flag"
      expr: hazardous_waste_flag
      comment: "Whether the service involves hazardous waste"
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether a permit is required for the service"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the service enrollment auto-renews"
    - name: "access_restriction_flag"
      expr: access_restriction_flag
      comment: "Whether there are access restrictions at the service location"
    - name: "enrollment_start_month"
      expr: DATE_TRUNC('MONTH', enrollment_start_date)
      comment: "Month when the service enrollment started"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency of billing for the service"
    - name: "origination_channel"
      expr: origination_channel
      comment: "Channel through which the enrollment originated"
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(DISTINCT service_enrollment_id)
      comment: "Total number of active service enrollments"
    - name: "total_monthly_recurring_revenue"
      expr: SUM(CAST(monthly_rate_usd AS DOUBLE))
      comment: "Total monthly recurring revenue from all service enrollments - primary revenue metric"
    - name: "avg_monthly_rate"
      expr: AVG(CAST(monthly_rate_usd AS DOUBLE))
      comment: "Average monthly rate per service enrollment"
    - name: "avg_diversion_target_pct"
      expr: AVG(CAST(diversion_target_pct AS DOUBLE))
      comment: "Average diversion target percentage across enrollments - sustainability performance indicator"
    - name: "hazardous_waste_enrollment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hazardous_waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments involving hazardous waste - regulatory complexity indicator"
    - name: "auto_renewal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments with auto-renewal - customer retention and revenue predictability metric"
    - name: "avg_container_count"
      expr: AVG(CAST(container_count AS DOUBLE))
      comment: "Average number of containers per service enrollment"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales lead metrics tracking pipeline quality, conversion performance, and revenue opportunity"
  source: "`waste_management_ecm`.`customer`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the sales lead"
    - name: "lead_source"
      expr: lead_source
      comment: "Source of the sales lead"
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect"
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the prospect"
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of service requested by the prospect"
    - name: "is_hazardous_waste_generator"
      expr: is_hazardous_waste_generator
      comment: "Whether the prospect generates hazardous waste"
    - name: "decision_maker_confirmed"
      expr: decision_maker_confirmed
      comment: "Whether the decision maker has been confirmed"
    - name: "budget_confirmed"
      expr: budget_confirmed
      comment: "Whether the budget has been confirmed"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when the lead was created"
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region for the lead"
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason the lead was lost (if applicable)"
  measures:
    - name: "total_leads"
      expr: COUNT(DISTINCT lead_id)
      comment: "Total number of sales leads"
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue from all leads - pipeline value metric"
    - name: "avg_estimated_annual_revenue"
      expr: AVG(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Average estimated annual revenue per lead - deal size indicator"
    - name: "total_estimated_monthly_volume_tons"
      expr: SUM(CAST(estimated_monthly_volume_tons AS DOUBLE))
      comment: "Total estimated monthly volume in tons across all leads - capacity planning metric"
    - name: "avg_estimated_monthly_volume_tons"
      expr: AVG(CAST(estimated_monthly_volume_tons AS DOUBLE))
      comment: "Average estimated monthly volume in tons per lead"
    - name: "decision_maker_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN decision_maker_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads with confirmed decision maker - sales qualification quality metric"
    - name: "budget_confirmation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN budget_confirmed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads with confirmed budget - sales qualification quality metric"
    - name: "hazardous_waste_lead_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous_waste_generator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of leads involving hazardous waste - high-value service mix indicator"
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average lead qualification score - pipeline quality indicator"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer referral program metrics tracking conversion performance, reward costs, and acquisition efficiency"
  source: "`waste_management_ecm`.`customer`.`referral`"
  dimensions:
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral"
    - name: "channel"
      expr: channel
      comment: "Channel through which the referral was made"
    - name: "reward_type"
      expr: reward_type
      comment: "Type of reward offered for the referral"
    - name: "reward_fulfillment_status"
      expr: reward_fulfillment_status
      comment: "Status of reward fulfillment"
    - name: "eligibility_verified_flag"
      expr: eligibility_verified_flag
      comment: "Whether referral eligibility has been verified"
    - name: "duplicate_flag"
      expr: duplicate_flag
      comment: "Whether the referral is a duplicate"
    - name: "self_referral_flag"
      expr: self_referral_flag
      comment: "Whether the referral is a self-referral"
    - name: "referral_month"
      expr: DATE_TRUNC('MONTH', referral_date)
      comment: "Month when the referral was made"
    - name: "service_type_requested"
      expr: service_type_requested
      comment: "Type of service requested by the referred prospect"
    - name: "service_district_code"
      expr: service_district_code
      comment: "Service district code for the referral"
  measures:
    - name: "total_referrals"
      expr: COUNT(DISTINCT referral_id)
      comment: "Total number of customer referrals"
    - name: "total_reward_amount"
      expr: SUM(CAST(reward_amount AS DOUBLE))
      comment: "Total reward amount paid or committed for referrals - referral program cost metric"
    - name: "avg_reward_amount"
      expr: AVG(CAST(reward_amount AS DOUBLE))
      comment: "Average reward amount per referral"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Total customer acquisition cost through referral program - CAC metric"
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost_usd AS DOUBLE))
      comment: "Average customer acquisition cost per referral - efficiency metric for referral channel"
    - name: "duplicate_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN duplicate_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that are duplicates - program quality and fraud indicator"
    - name: "self_referral_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN self_referral_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that are self-referrals - program abuse indicator"
    - name: "eligibility_verification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN eligibility_verified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals with verified eligibility - program quality control metric"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_container_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container asset utilization metrics tracking deployment, rental revenue, and service performance"
  source: "`waste_management_ecm`.`customer`.`container_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the container assignment"
    - name: "container_type"
      expr: container_type
      comment: "Type of container assigned"
    - name: "material_stream"
      expr: material_stream
      comment: "Material stream for the container"
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the container"
    - name: "collection_frequency"
      expr: collection_frequency
      comment: "Frequency of collection for the container"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for the assignment"
    - name: "regulatory_manifest_required"
      expr: regulatory_manifest_required
      comment: "Whether a regulatory manifest is required"
    - name: "lock_required"
      expr: lock_required
      comment: "Whether a lock is required on the container"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month when the container was delivered"
    - name: "condition_at_delivery"
      expr: condition_at_delivery
      comment: "Condition of the container at delivery"
  measures:
    - name: "total_container_assignments"
      expr: COUNT(DISTINCT container_assignment_id)
      comment: "Total number of container assignments"
    - name: "total_monthly_rental_revenue"
      expr: SUM(CAST(monthly_rental_rate AS DOUBLE))
      comment: "Total monthly rental revenue from container assignments - asset monetization metric"
    - name: "avg_monthly_rental_rate"
      expr: AVG(CAST(monthly_rental_rate AS DOUBLE))
      comment: "Average monthly rental rate per container assignment"
    - name: "avg_size_cubic_yards"
      expr: AVG(CAST(size_cubic_yards AS DOUBLE))
      comment: "Average container size in cubic yards"
    - name: "avg_size_gallons"
      expr: AVG(CAST(size_gallons AS DOUBLE))
      comment: "Average container size in gallons"
    - name: "avg_missed_pickup_count"
      expr: AVG(CAST(missed_pickup_count AS DOUBLE))
      comment: "Average number of missed pickups per container - service quality metric"
    - name: "regulatory_manifest_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_manifest_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of container assignments requiring regulatory manifest - compliance complexity indicator"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_service_suspension`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service suspension metrics tracking churn risk, revenue impact, and reactivation performance"
  source: "`waste_management_ecm`.`customer`.`service_suspension`"
  dimensions:
    - name: "suspension_status"
      expr: suspension_status
      comment: "Current status of the service suspension"
    - name: "suspension_type"
      expr: suspension_type
      comment: "Type of service suspension"
    - name: "suspension_reason_code"
      expr: suspension_reason_code
      comment: "Reason code for the suspension"
    - name: "is_permanent"
      expr: is_permanent
      comment: "Whether the suspension is permanent (churn)"
    - name: "billing_adjustment_required"
      expr: billing_adjustment_required
      comment: "Whether a billing adjustment is required"
    - name: "container_retrieval_required"
      expr: container_retrieval_required
      comment: "Whether container retrieval is required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the suspension was escalated"
    - name: "auto_resume_enabled"
      expr: auto_resume_enabled
      comment: "Whether automatic resume is enabled"
    - name: "suspension_start_month"
      expr: DATE_TRUNC('MONTH', suspension_start_date)
      comment: "Month when the suspension started"
    - name: "service_type"
      expr: service_type
      comment: "Type of service suspended"
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream for the suspended service"
  measures:
    - name: "total_service_suspensions"
      expr: COUNT(DISTINCT service_suspension_id)
      comment: "Total number of service suspensions"
    - name: "total_billing_credit_amount"
      expr: SUM(CAST(billing_credit_amount AS DOUBLE))
      comment: "Total billing credit amount issued for suspensions - revenue impact of service interruptions"
    - name: "avg_billing_credit_amount"
      expr: AVG(CAST(billing_credit_amount AS DOUBLE))
      comment: "Average billing credit amount per suspension"
    - name: "avg_suspension_duration_days"
      expr: AVG(CAST(suspension_duration_days AS DOUBLE))
      comment: "Average duration of service suspensions in days - customer retention risk indicator"
    - name: "permanent_suspension_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_permanent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suspensions that are permanent - churn rate metric"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of suspensions that were escalated - severity indicator"
    - name: "avg_prior_suspension_count"
      expr: AVG(CAST(prior_suspension_count AS DOUBLE))
      comment: "Average number of prior suspensions per customer - repeat issue indicator"
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction metrics tracking contact center efficiency, first contact resolution, and satisfaction"
  source: "`waste_management_ecm`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction"
    - name: "channel"
      expr: channel
      comment: "Channel through which the interaction occurred"
    - name: "direction"
      expr: direction
      comment: "Direction of the interaction (inbound/outbound)"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction"
    - name: "topic_category"
      expr: topic_category
      comment: "Category of the interaction topic"
    - name: "topic_subcategory"
      expr: topic_subcategory
      comment: "Subcategory of the interaction topic"
    - name: "is_escalated"
      expr: is_escalated
      comment: "Whether the interaction was escalated"
    - name: "is_first_contact_resolution"
      expr: is_first_contact_resolution
      comment: "Whether the issue was resolved on first contact"
    - name: "regulatory_complaint_flag"
      expr: regulatory_complaint_flag
      comment: "Whether the interaction is a regulatory complaint"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', interaction_timestamp)
      comment: "Month when the interaction occurred"
    - name: "agent_team"
      expr: agent_team
      comment: "Team of the agent handling the interaction"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions"
    - name: "avg_duration_seconds"
      expr: AVG(CAST(duration_seconds AS DOUBLE))
      comment: "Average interaction duration in seconds - contact center efficiency metric"
    - name: "avg_wait_duration_seconds"
      expr: AVG(CAST(wait_duration_seconds AS DOUBLE))
      comment: "Average wait time in seconds - customer experience metric"
    - name: "avg_hold_duration_seconds"
      expr: AVG(CAST(hold_duration_seconds AS DOUBLE))
      comment: "Average hold time in seconds - service quality metric"
    - name: "first_contact_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_first_contact_resolution = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions resolved on first contact - primary contact center quality metric"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that were escalated - indicates agent capability and issue complexity"
    - name: "avg_transfer_count"
      expr: AVG(CAST(transfer_count AS DOUBLE))
      comment: "Average number of transfers per interaction - routing efficiency metric"
    - name: "avg_csat_score"
      expr: AVG(CAST(csat_score AS DOUBLE))
      comment: "Average customer satisfaction score for interactions"
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score from interactions"
    - name: "regulatory_complaint_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_complaint_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of interactions that are regulatory complaints - compliance risk indicator"
$$;