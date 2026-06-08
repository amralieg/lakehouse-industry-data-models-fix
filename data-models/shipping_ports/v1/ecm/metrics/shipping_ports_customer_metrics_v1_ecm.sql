-- Metric views for domain: customer | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_port_community_participant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer metrics tracking participant counts, credit exposure, and operational status across the port community ecosystem"
  source: "`shipping_ports_ecm`.`customer`.`port_community_participant`"
  dimensions:
    - name: "participant_type"
      expr: participant_type
      comment: "Type of port community participant (shipping line, freight forwarder, customs broker, terminal operator, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the participant (active, suspended, inactive)"
    - name: "customer_tier"
      expr: customer_tier
      comment: "Customer tier classification for segmentation and service level differentiation"
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "Service level agreement tier code defining response and performance commitments"
    - name: "isps_accreditation_status"
      expr: isps_accreditation_status
      comment: "International Ship and Port Facility Security accreditation status"
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Status of sanctions screening compliance check"
    - name: "dangerous_goods_approved"
      expr: dangerous_goods_approved
      comment: "Flag indicating whether participant is approved to handle dangerous goods"
    - name: "vessel_operator_flag"
      expr: vessel_operator_flag
      comment: "Flag indicating whether participant operates vessels"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the participant was onboarded to the port community system"
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month the participant was onboarded for cohort analysis"
    - name: "credit_currency_code"
      expr: credit_currency_code
      comment: "Currency code for credit limit and financial transactions"
  measures:
    - name: "total_participants"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Total count of unique port community participants"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit exposure across all participants in local currencies"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per participant"
    - name: "participants_with_dangerous_goods_approval"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_approved = TRUE THEN port_community_participant_id END)
      comment: "Count of participants authorized to handle dangerous goods"
    - name: "participants_with_vessel_operations"
      expr: COUNT(DISTINCT CASE WHEN vessel_operator_flag = TRUE THEN port_community_participant_id END)
      comment: "Count of participants operating vessels"
    - name: "participants_with_active_isps"
      expr: COUNT(DISTINCT CASE WHEN isps_accreditation_status = 'Active' THEN port_community_participant_id END)
      comment: "Count of participants with active ISPS accreditation"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_participant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational metrics for participant accounts including revenue, credit utilization, payment performance, and volume commitments"
  source: "`shipping_ports_ecm`.`customer`.`participant_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the participant account (active, suspended, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (corporate, individual, government, etc.)"
    - name: "account_tier"
      expr: account_tier
      comment: "Account tier for service differentiation and pricing"
    - name: "billing_cycle"
      expr: billing_cycle
      comment: "Billing cycle frequency (monthly, weekly, on-demand)"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code defining due date calculation"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account"
    - name: "service_line"
      expr: service_line
      comment: "Primary service line for the account (container, bulk, ro-ro, etc.)"
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "Service level agreement tier code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for account transactions"
    - name: "account_open_year"
      expr: YEAR(account_open_date)
      comment: "Year the account was opened"
    - name: "account_open_month"
      expr: DATE_TRUNC('MONTH', account_open_date)
      comment: "Month the account was opened for cohort analysis"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Total count of unique participant accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across all accounts"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount across all accounts"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilisation_pct AS DOUBLE))
      comment: "Average credit utilization percentage across accounts"
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage across accounts"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total security deposit amount held across accounts"
    - name: "accounts_with_overdue_balance"
      expr: COUNT(DISTINCT CASE WHEN CAST(overdue_amount AS DOUBLE) > 0 THEN participant_account_id END)
      comment: "Count of accounts with overdue balances"
    - name: "accounts_with_edi_enabled"
      expr: COUNT(DISTINCT CASE WHEN edi_enabled = TRUE THEN participant_account_id END)
      comment: "Count of accounts with EDI integration enabled"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service request performance metrics tracking volume, resolution efficiency, SLA compliance, and customer satisfaction across request types and channels"
  source: "`shipping_ports_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (inquiry, complaint, change request, incident, etc.)"
    - name: "service_request_category"
      expr: service_request_category
      comment: "High-level category of the service request"
    - name: "subcategory"
      expr: subcategory
      comment: "Detailed subcategory of the service request"
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (open, in progress, resolved, closed, cancelled)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the service request (critical, high, medium, low)"
    - name: "channel"
      expr: channel
      comment: "Channel through which the request was submitted (portal, email, phone, EDI, etc.)"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the request was escalated"
    - name: "sla_response_breached"
      expr: sla_response_breached
      comment: "Flag indicating whether SLA response time was breached"
    - name: "sla_resolution_breached"
      expr: sla_resolution_breached
      comment: "Flag indicating whether SLA resolution time was breached"
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Flag indicating whether regulatory notification is required"
    - name: "isps_related"
      expr: isps_related
      comment: "Flag indicating whether request is ISPS security related"
    - name: "imdg_related"
      expr: imdg_related
      comment: "Flag indicating whether request is IMDG dangerous goods related"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the service request was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service request was created"
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the service request was created"
  measures:
    - name: "total_service_requests"
      expr: COUNT(DISTINCT service_request_id)
      comment: "Total count of unique service requests"
    - name: "escalated_requests"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN service_request_id END)
      comment: "Count of service requests that were escalated"
    - name: "sla_response_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_response_breached = TRUE THEN service_request_id END)
      comment: "Count of service requests with SLA response time breaches"
    - name: "sla_resolution_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_resolution_breached = TRUE THEN service_request_id END)
      comment: "Count of service requests with SLA resolution time breaches"
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total disputed amount across all service requests"
    - name: "avg_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average dispute amount per service request"
    - name: "regulatory_notifications_required"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required = TRUE THEN service_request_id END)
      comment: "Count of service requests requiring regulatory notification"
    - name: "isps_related_requests"
      expr: COUNT(DISTINCT CASE WHEN isps_related = TRUE THEN service_request_id END)
      comment: "Count of ISPS security related service requests"
    - name: "dangerous_goods_related_requests"
      expr: COUNT(DISTINCT CASE WHEN imdg_related = TRUE THEN service_request_id END)
      comment: "Count of dangerous goods related service requests"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_credit_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and assessment metrics tracking credit limit approvals, risk ratings, assessment outcomes, and credit decision performance"
  source: "`shipping_ports_ecm`.`customer`.`credit_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the credit assessment (pending, approved, rejected, under review)"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of credit assessment (new, renewal, review, ad-hoc)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned after assessment"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (low, medium, high, critical)"
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the credit decision"
    - name: "security_deposit_required"
      expr: security_deposit_required
      comment: "Flag indicating whether security deposit is required"
    - name: "is_watch_list"
      expr: is_watch_list
      comment: "Flag indicating whether participant is on credit watch list"
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Rating of historical payment performance"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for credit amounts"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the credit assessment was performed"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the credit assessment was performed"
  measures:
    - name: "total_assessments"
      expr: COUNT(DISTINCT credit_assessment_id)
      comment: "Total count of unique credit assessments"
    - name: "total_requested_credit_limit"
      expr: SUM(CAST(requested_credit_limit AS DOUBLE))
      comment: "Total credit limit requested across all assessments"
    - name: "total_approved_credit_limit"
      expr: SUM(CAST(approved_credit_limit AS DOUBLE))
      comment: "Total credit limit approved across all assessments"
    - name: "total_assessed_credit_limit"
      expr: SUM(CAST(assessed_credit_limit AS DOUBLE))
      comment: "Total credit limit assessed by credit analysts"
    - name: "avg_credit_score"
      expr: AVG(CAST(credit_score AS DOUBLE))
      comment: "Average credit score across assessments"
    - name: "total_security_deposit_amount"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposit amount required across assessments"
    - name: "assessments_requiring_deposit"
      expr: COUNT(DISTINCT CASE WHEN security_deposit_required = TRUE THEN credit_assessment_id END)
      comment: "Count of assessments requiring security deposit"
    - name: "assessments_on_watch_list"
      expr: COUNT(DISTINCT CASE WHEN is_watch_list = TRUE THEN credit_assessment_id END)
      comment: "Count of assessments flagged for credit watch list"
    - name: "approved_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'Approved' THEN credit_assessment_id END)
      comment: "Count of approved credit assessments"
    - name: "rejected_assessments"
      expr: COUNT(DISTINCT CASE WHEN assessment_status = 'Rejected' THEN credit_assessment_id END)
      comment: "Count of rejected credit assessments"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement performance metrics tracking SLA compliance, breach rates, penalty exposure, and service quality across customer segments"
  source: "`shipping_ports_ecm`.`customer`.`sla_performance`"
  dimensions:
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric being measured"
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the SLA metric (operational, financial, quality, safety)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service covered by the SLA"
    - name: "measurement_status"
      expr: measurement_status
      comment: "Status of the SLA measurement (measured, pending, disputed, validated)"
    - name: "breach_flag"
      expr: breach_flag
      comment: "Flag indicating whether SLA was breached"
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity level of the SLA breach (minor, major, critical)"
    - name: "breach_direction"
      expr: breach_direction
      comment: "Direction of the breach (above target, below target)"
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Flag indicating whether penalty is applicable for the breach"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Flag indicating whether penalty was waived"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating whether the breach was escalated"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the measurement is disputed"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for the SLA measurement"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (daily, weekly, monthly, quarterly)"
    - name: "measurement_year"
      expr: YEAR(measurement_event_timestamp)
      comment: "Year of the SLA measurement event"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_event_timestamp)
      comment: "Month of the SLA measurement event"
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(DISTINCT sla_performance_id)
      comment: "Total count of unique SLA performance measurements"
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_performance_id END)
      comment: "Total count of SLA breaches"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount across all SLA measurements"
    - name: "avg_actual_value"
      expr: AVG(CAST(actual_value AS DOUBLE))
      comment: "Average actual performance value across measurements"
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average target performance value across measurements"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage from target across measurements"
    - name: "measurements_with_penalty"
      expr: COUNT(DISTINCT CASE WHEN penalty_applicable_flag = TRUE THEN sla_performance_id END)
      comment: "Count of measurements where penalty is applicable"
    - name: "measurements_with_waiver"
      expr: COUNT(DISTINCT CASE WHEN waiver_flag = TRUE THEN sla_performance_id END)
      comment: "Count of measurements where penalty was waived"
    - name: "escalated_breaches"
      expr: COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN sla_performance_id END)
      comment: "Count of SLA breaches that were escalated"
    - name: "disputed_measurements"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN sla_performance_id END)
      comment: "Count of SLA measurements under dispute"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_onboarding_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding funnel and conversion metrics tracking application volume, approval rates, cycle time, and screening outcomes"
  source: "`shipping_ports_ecm`.`customer`.`onboarding_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of the onboarding application (submitted, under review, approved, rejected, withdrawn)"
    - name: "workflow_stage"
      expr: workflow_stage
      comment: "Current workflow stage of the application"
    - name: "participant_type"
      expr: participant_type
      comment: "Type of participant applying for onboarding"
    - name: "application_channel"
      expr: application_channel
      comment: "Channel through which application was submitted (online, in-person, agent)"
    - name: "isps_screening_status"
      expr: isps_screening_status
      comment: "Status of ISPS security screening"
    - name: "sanctions_screening_outcome"
      expr: sanctions_screening_outcome
      comment: "Outcome of sanctions screening check"
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of background check"
    - name: "credit_assessment_status"
      expr: credit_assessment_status
      comment: "Status of credit assessment"
    - name: "document_checklist_status"
      expr: document_checklist_status
      comment: "Status of document checklist completion"
    - name: "is_resubmission"
      expr: is_resubmission
      comment: "Flag indicating whether application is a resubmission"
    - name: "rejection_category"
      expr: rejection_category
      comment: "Category of rejection reason if application was rejected"
    - name: "submission_year"
      expr: YEAR(submission_timestamp)
      comment: "Year the application was submitted"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month the application was submitted"
  measures:
    - name: "total_applications"
      expr: COUNT(DISTINCT onboarding_application_id)
      comment: "Total count of unique onboarding applications"
    - name: "approved_applications"
      expr: COUNT(DISTINCT CASE WHEN application_status = 'Approved' THEN onboarding_application_id END)
      comment: "Count of approved onboarding applications"
    - name: "rejected_applications"
      expr: COUNT(DISTINCT CASE WHEN application_status = 'Rejected' THEN onboarding_application_id END)
      comment: "Count of rejected onboarding applications"
    - name: "resubmitted_applications"
      expr: COUNT(DISTINCT CASE WHEN is_resubmission = TRUE THEN onboarding_application_id END)
      comment: "Count of applications that are resubmissions"
    - name: "total_proposed_credit_limit"
      expr: SUM(CAST(proposed_credit_limit AS DOUBLE))
      comment: "Total proposed credit limit across all applications"
    - name: "avg_proposed_credit_limit"
      expr: AVG(CAST(proposed_credit_limit AS DOUBLE))
      comment: "Average proposed credit limit per application"
    - name: "applications_with_sanctions_cleared"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_outcome = 'Cleared' THEN onboarding_application_id END)
      comment: "Count of applications with cleared sanctions screening"
    - name: "applications_with_isps_cleared"
      expr: COUNT(DISTINCT CASE WHEN isps_screening_status = 'Cleared' THEN onboarding_application_id END)
      comment: "Count of applications with cleared ISPS screening"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation and permit compliance metrics tracking active accreditations, expiry risk, revocation rates, and insurance coverage across accreditation types"
  source: "`shipping_ports_ecm`.`customer`.`accreditation`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (ISPS, dangerous goods, vehicle access, personnel, etc.)"
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Category of accreditation"
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current status of the accreditation (active, expired, suspended, revoked)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the accreditation"
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the accreditation"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Flag indicating whether accreditation is mandatory"
    - name: "is_revoked"
      expr: is_revoked
      comment: "Flag indicating whether accreditation has been revoked"
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of the accreditation"
    - name: "issuing_authority_country"
      expr: issuing_authority_country
      comment: "Country of the issuing authority"
    - name: "insurance_currency_code"
      expr: insurance_currency_code
      comment: "Currency code for insurance coverage"
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the accreditation was issued"
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the accreditation expires"
    - name: "expiry_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the accreditation expires for renewal planning"
  measures:
    - name: "total_accreditations"
      expr: COUNT(DISTINCT accreditation_id)
      comment: "Total count of unique accreditations"
    - name: "active_accreditations"
      expr: COUNT(DISTINCT CASE WHEN accreditation_status = 'Active' THEN accreditation_id END)
      comment: "Count of active accreditations"
    - name: "expired_accreditations"
      expr: COUNT(DISTINCT CASE WHEN accreditation_status = 'Expired' THEN accreditation_id END)
      comment: "Count of expired accreditations"
    - name: "revoked_accreditations"
      expr: COUNT(DISTINCT CASE WHEN is_revoked = TRUE THEN accreditation_id END)
      comment: "Count of revoked accreditations"
    - name: "mandatory_accreditations"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE THEN accreditation_id END)
      comment: "Count of mandatory accreditations"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all accreditations"
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount per accreditation"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_communication_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer communication effectiveness metrics tracking message volume, delivery success, response rates, and channel performance"
  source: "`shipping_ports_ecm`.`customer`.`communication_log`"
  dimensions:
    - name: "communication_type"
      expr: communication_type
      comment: "Type of communication (notification, alert, inquiry, response, etc.)"
    - name: "channel"
      expr: channel
      comment: "Communication channel (email, SMS, EDI, portal, phone)"
    - name: "direction"
      expr: direction
      comment: "Direction of communication (inbound, outbound)"
    - name: "communication_status"
      expr: communication_status
      comment: "Status of the communication (sent, delivered, failed, pending)"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the communication"
    - name: "priority"
      expr: priority
      comment: "Priority level of the communication"
    - name: "is_acknowledged"
      expr: is_acknowledged
      comment: "Flag indicating whether communication was acknowledged"
    - name: "is_response_required"
      expr: is_response_required
      comment: "Flag indicating whether response is required"
    - name: "is_regulatory"
      expr: is_regulatory
      comment: "Flag indicating whether communication is regulatory"
    - name: "escalation_status"
      expr: escalation_status
      comment: "Escalation status of the communication"
    - name: "edi_message_type"
      expr: edi_message_type
      comment: "EDI message type for EDI communications"
    - name: "isps_classification"
      expr: isps_classification
      comment: "ISPS security classification of the communication"
    - name: "created_year"
      expr: YEAR(created_timestamp)
      comment: "Year the communication was created"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the communication was created"
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_timestamp)
      comment: "Date the communication was created"
  measures:
    - name: "total_communications"
      expr: COUNT(DISTINCT communication_log_id)
      comment: "Total count of unique communications"
    - name: "acknowledged_communications"
      expr: COUNT(DISTINCT CASE WHEN is_acknowledged = TRUE THEN communication_log_id END)
      comment: "Count of communications that were acknowledged"
    - name: "communications_requiring_response"
      expr: COUNT(DISTINCT CASE WHEN is_response_required = TRUE THEN communication_log_id END)
      comment: "Count of communications requiring response"
    - name: "regulatory_communications"
      expr: COUNT(DISTINCT CASE WHEN is_regulatory = TRUE THEN communication_log_id END)
      comment: "Count of regulatory communications"
    - name: "failed_deliveries"
      expr: COUNT(DISTINCT CASE WHEN delivery_status = 'Failed' THEN communication_log_id END)
      comment: "Count of communications with failed delivery"
    - name: "escalated_communications"
      expr: COUNT(DISTINCT CASE WHEN escalation_status = 'Escalated' THEN communication_log_id END)
      comment: "Count of communications that were escalated"
$$;