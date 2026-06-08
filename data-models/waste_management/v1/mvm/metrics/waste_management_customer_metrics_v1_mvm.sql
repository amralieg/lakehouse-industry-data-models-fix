-- Metric views for domain: customer | Business: Waste Management | Version: 1 | Generated on: 2026-05-07 22:39:52

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer account master — tracks portfolio health, credit exposure, churn risk, and account lifecycle for executive and operational steering."
  source: "`waste_management_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Suspended, Closed, etc.) — primary segmentation axis for portfolio health reporting."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (Residential, Commercial, Industrial, Municipal) — drives service-line and revenue-mix analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Revenue or strategic tier assigned to the account — used to prioritize retention and service investment."
    - name: "segment_id"
      expr: segment_id
      comment: "Foreign key to the customer segment — enables cohort-level KPI slicing without a join when segment_id is used as a filter/group key."
    - name: "waste_generator_class"
      expr: waste_generator_class
      comment: "EPA waste generator classification (SQG, LQG, VSQG) — critical for regulatory compliance reporting and hazardous-waste revenue segmentation."
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit standing of the account — used to monitor financial risk exposure across the portfolio."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms (Net 30, Net 60, etc.) — informs cash-flow forecasting and collections strategy."
    - name: "industry_code"
      expr: industry_code
      comment: "SIC/NAICS industry code of the customer — enables vertical-market performance analysis."
    - name: "preferred_payment_method"
      expr: preferred_payment_method
      comment: "Customer's preferred payment method — informs autopay adoption and payment processing cost analysis."
    - name: "customer_since_year_month"
      expr: DATE_TRUNC('MONTH', customer_since_date)
      comment: "Month the customer relationship began — used for cohort retention and tenure-based analysis."
    - name: "closed_year_month"
      expr: DATE_TRUNC('MONTH', closed_date)
      comment: "Month the account was closed — used for churn trend analysis over time."
    - name: "autopay_enrolled"
      expr: autopay_enrolled
      comment: "Whether the account is enrolled in autopay — used to measure autopay adoption rate and its correlation with payment performance."
    - name: "paperless_billing"
      expr: paperless_billing
      comment: "Whether the account has opted into paperless billing — tracks digital adoption and operational cost reduction."
    - name: "tax_exempt"
      expr: tax_exempt
      comment: "Whether the account holds a tax exemption — required for revenue reporting and compliance."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Total number of active customer accounts — the primary portfolio size KPI used in executive dashboards and capacity planning."
    - name: "total_accounts"
      expr: COUNT(customer_account_id)
      comment: "Total customer accounts across all statuses — baseline denominator for rate calculations and portfolio sizing."
    - name: "total_suspended_accounts"
      expr: COUNT(CASE WHEN account_status = 'Suspended' THEN customer_account_id END)
      comment: "Number of suspended accounts — a leading indicator of churn risk and collections pressure."
    - name: "total_closed_accounts"
      expr: COUNT(CASE WHEN account_status = 'Closed' THEN customer_account_id END)
      comment: "Number of closed (churned) accounts — used to compute churn rate and evaluate retention program effectiveness."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit extended across all accounts — measures total financial exposure and informs credit risk management."
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — benchmarks credit policy consistency and identifies outlier accounts."
    - name: "autopay_enrolled_accounts"
      expr: COUNT(CASE WHEN autopay_enrolled = TRUE THEN customer_account_id END)
      comment: "Number of accounts enrolled in autopay — measures adoption of automated payment, which reduces DSO and collections cost."
    - name: "paperless_billing_accounts"
      expr: COUNT(CASE WHEN paperless_billing = TRUE THEN customer_account_id END)
      comment: "Number of accounts on paperless billing — tracks digital transformation progress and paper/postage cost reduction."
    - name: "portal_access_enabled_accounts"
      expr: COUNT(CASE WHEN portal_access_enabled = TRUE THEN customer_account_id END)
      comment: "Number of accounts with self-service portal access enabled — measures digital engagement and potential for call-deflection savings."
    - name: "tax_exempt_accounts"
      expr: COUNT(CASE WHEN tax_exempt = TRUE THEN customer_account_id END)
      comment: "Number of tax-exempt accounts — required for accurate revenue and tax liability reporting."
    - name: "hazardous_waste_generator_accounts"
      expr: COUNT(CASE WHEN waste_generator_class IS NOT NULL AND waste_generator_class != '' THEN customer_account_id END)
      comment: "Number of accounts with a regulated waste generator classification — quantifies the regulated-waste customer base for compliance and specialized service capacity planning."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer complaint quality and resolution KPIs — tracks complaint volume, severity, escalation rates, SLA compliance, and financial impact of credits issued. Directly informs service quality, regulatory risk, and customer satisfaction strategy."
  source: "`waste_management_ecm`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_type"
      expr: complaint_type
      comment: "Category of the complaint (Missed Pickup, Billing Dispute, Hazardous Waste, etc.) — primary axis for root-cause and service-quality analysis."
    - name: "complaint_subtype"
      expr: subtype
      comment: "Sub-classification of the complaint — enables granular drill-down within complaint categories."
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current resolution status of the complaint (Open, In Progress, Resolved, Closed) — used to monitor backlog and resolution throughput."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity rating of the complaint — used to prioritize response resources and track high-severity complaint trends."
    - name: "complaint_source"
      expr: complaint_source
      comment: "Channel through which the complaint was received (Phone, Portal, Email, Regulatory Agency) — informs channel strategy and staffing."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for resolving the complaint — enables workload balancing and team-level performance measurement."
    - name: "root_cause_code"
      expr: root_cause_code
      comment: "Coded root cause of the complaint — drives systemic improvement initiatives and recurring issue identification."
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of the complaint resolution — used to evaluate resolution quality and customer satisfaction impact."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the complaint was escalated — used to compute escalation rate and identify systemic service failures."
    - name: "regulatory_escalation_flag"
      expr: regulatory_escalation_flag
      comment: "Whether the complaint was escalated to a regulatory agency — a critical risk indicator for compliance and legal exposure."
    - name: "repeat_complaint_flag"
      expr: repeat_complaint_flag
      comment: "Whether this is a repeat complaint from the same customer — measures first-contact resolution effectiveness."
    - name: "credit_issued_flag"
      expr: credit_issued_flag
      comment: "Whether a billing credit was issued to resolve the complaint — used to track financial concession patterns."
    - name: "incident_month"
      expr: DATE_TRUNC('MONTH', incident_date)
      comment: "Month the complaint incident occurred — enables trend analysis of complaint volume over time."
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_timestamp)
      comment: "Month the complaint was received — used for intake volume trending and seasonal pattern detection."
  measures:
    - name: "total_complaints"
      expr: COUNT(complaint_id)
      comment: "Total number of complaints received — the primary service quality volume KPI tracked in operational and executive reviews."
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status NOT IN ('Resolved', 'Closed') THEN complaint_id END)
      comment: "Number of unresolved complaints currently open — measures backlog pressure and resolution capacity."
    - name: "escalated_complaints"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints that were escalated — numerator for escalation rate; high values signal systemic service failures."
    - name: "regulatory_escalated_complaints"
      expr: COUNT(CASE WHEN regulatory_escalation_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints escalated to a regulatory agency — a critical compliance risk KPI monitored by legal and operations leadership."
    - name: "repeat_complaints"
      expr: COUNT(CASE WHEN repeat_complaint_flag = TRUE THEN complaint_id END)
      comment: "Number of repeat complaints — measures first-contact resolution failure rate; high values indicate unresolved root causes."
    - name: "complaints_with_credit_issued"
      expr: COUNT(CASE WHEN credit_issued_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints resolved with a billing credit — numerator for credit concession rate analysis."
    - name: "total_credit_amount_usd"
      expr: SUM(CAST(credit_amount_usd AS DOUBLE))
      comment: "Total dollar value of billing credits issued to resolve complaints — measures the direct financial cost of service failures."
    - name: "avg_credit_amount_usd"
      expr: AVG(CAST(credit_amount_usd AS DOUBLE))
      comment: "Average credit amount issued per complaint — benchmarks the cost-per-resolution and identifies high-cost complaint categories."
    - name: "total_billing_dispute_amount_usd"
      expr: SUM(CAST(billing_dispute_amount_usd AS DOUBLE))
      comment: "Total dollar value of billing amounts under dispute — measures financial exposure from billing accuracy issues."
    - name: "avg_billing_dispute_amount_usd"
      expr: AVG(CAST(billing_dispute_amount_usd AS DOUBLE))
      comment: "Average billing dispute amount per complaint — used to assess billing accuracy and prioritize dispute resolution resources."
    - name: "distinct_customers_with_complaints"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customer accounts that have filed at least one complaint — measures breadth of service quality issues across the customer base."
    - name: "legal_hold_complaints"
      expr: COUNT(CASE WHEN legal_hold_flag = TRUE THEN complaint_id END)
      comment: "Number of complaints under legal hold — a risk management KPI monitored by legal and compliance teams."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_service_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service enrollment lifecycle and portfolio KPIs — tracks active enrollments, cancellations, suspension patterns, and service mix. Directly informs revenue retention, capacity planning, and service delivery strategy."
  source: "`waste_management_ecm`.`customer`.`service_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the service enrollment (Active, Suspended, Cancelled, Expired) — primary axis for portfolio health and churn analysis."
    - name: "service_level"
      expr: service_level
      comment: "Service tier or level associated with the enrollment — used to analyze service mix and revenue quality."
    - name: "container_type"
      expr: container_type
      comment: "Type of container associated with the enrollment — informs asset deployment planning and service capacity."
    - name: "origination_channel"
      expr: origination_channel
      comment: "Channel through which the enrollment was originated (Sales, Portal, Call Center) — measures channel effectiveness and acquisition cost."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for enrollment cancellation — drives churn root-cause analysis and retention program design."
    - name: "service_day_of_week"
      expr: service_day_of_week
      comment: "Scheduled day of week for service — used for route load balancing and operational capacity planning."
    - name: "hazardous_waste_flag"
      expr: hazardous_waste_flag
      comment: "Whether the enrollment involves hazardous waste services — segments regulated vs. standard service enrollments for compliance reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether the enrollment is set to auto-renew — measures contract renewal automation and revenue predictability."
    - name: "permit_required_flag"
      expr: permit_required_flag
      comment: "Whether a permit is required for this enrollment — used to track regulatory compliance readiness across the service portfolio."
    - name: "enrollment_start_month"
      expr: DATE_TRUNC('MONTH', enrollment_start_date)
      comment: "Month the enrollment became effective — used for cohort analysis and new enrollment trend tracking."
    - name: "cancellation_month"
      expr: DATE_TRUNC('MONTH', cancellation_date)
      comment: "Month the enrollment was cancelled — used for churn trend analysis and seasonality detection."
    - name: "segment_id"
      expr: segment_id
      comment: "Customer segment associated with the enrollment — enables segment-level service portfolio analysis."
  measures:
    - name: "total_active_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Active' THEN service_enrollment_id END)
      comment: "Total number of active service enrollments — the primary service portfolio size KPI used in capacity planning and revenue forecasting."
    - name: "total_enrollments"
      expr: COUNT(service_enrollment_id)
      comment: "Total service enrollments across all statuses — baseline denominator for enrollment rate and churn rate calculations."
    - name: "total_cancelled_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Cancelled' THEN service_enrollment_id END)
      comment: "Number of cancelled enrollments — numerator for cancellation/churn rate; directly tied to revenue loss."
    - name: "total_suspended_enrollments"
      expr: COUNT(CASE WHEN enrollment_status = 'Suspended' THEN service_enrollment_id END)
      comment: "Number of suspended enrollments — leading indicator of at-risk revenue and potential churn."
    - name: "hazardous_waste_enrollments"
      expr: COUNT(CASE WHEN hazardous_waste_flag = TRUE THEN service_enrollment_id END)
      comment: "Number of enrollments involving hazardous waste services — measures the regulated-service portfolio size for compliance capacity planning."
    - name: "auto_renewal_enrollments"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN service_enrollment_id END)
      comment: "Number of enrollments set to auto-renew — measures revenue predictability and contract management efficiency."
    - name: "permit_required_enrollments"
      expr: COUNT(CASE WHEN permit_required_flag = TRUE THEN service_enrollment_id END)
      comment: "Number of enrollments requiring a permit — used to track regulatory compliance obligations across the active service portfolio."
    - name: "avg_diversion_target_pct"
      expr: AVG(CAST(diversion_target_pct AS DOUBLE))
      comment: "Average waste diversion target percentage across enrollments — measures the portfolio-level sustainability commitment and tracks progress toward environmental goals."
    - name: "distinct_service_addresses_enrolled"
      expr: COUNT(DISTINCT service_address_id)
      comment: "Number of unique service addresses covered by enrollments — measures geographic service footprint and density."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service request operational KPIs — tracks request volume, SLA compliance, escalation rates, and resolution quality. Directly informs field operations efficiency, customer satisfaction, and SLA contract performance."
  source: "`waste_management_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "request_type_code"
      expr: request_type_code
      comment: "Type of service request (Pickup, Delivery, Swap, Repair, etc.) — primary axis for operational workload analysis."
    - name: "request_subtype_code"
      expr: request_subtype_code
      comment: "Sub-type of the service request — enables granular drill-down within request categories for root-cause analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (Open, Scheduled, Completed, Cancelled) — used to monitor backlog and throughput."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the service request — used to analyze SLA compliance by priority tier and resource allocation."
    - name: "channel_source"
      expr: channel_source
      comment: "Channel through which the request was submitted (Portal, Phone, Mobile App, Field) — measures digital self-service adoption."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the service request — used to track unbilled completed work and revenue leakage."
    - name: "waste_stream_type"
      expr: waste_stream_type
      comment: "Type of waste stream associated with the request — enables service-line performance analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the request breached its SLA — used to compute SLA breach rate, a key contract performance and customer satisfaction KPI."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the request was escalated — used to compute escalation rate and identify systemic operational failures."
    - name: "regulatory_flag"
      expr: regulatory_flag
      comment: "Whether the request has a regulatory component — segments compliance-driven requests for risk monitoring."
    - name: "tipping_fee_applicable"
      expr: tipping_fee_applicable
      comment: "Whether a tipping fee applies to this request — used to identify revenue-generating disposal events."
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month the service request was submitted — used for volume trend analysis and seasonal demand planning."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month the service is scheduled — used for forward-looking capacity and route planning."
    - name: "service_frequency_type"
      expr: service_frequency_type
      comment: "Frequency type of the service (On-Demand, Scheduled, Emergency) — informs resource planning and pricing strategy."
  measures:
    - name: "total_service_requests"
      expr: COUNT(service_request_id)
      comment: "Total number of service requests submitted — the primary operational volume KPI for field operations and capacity planning."
    - name: "open_service_requests"
      expr: COUNT(CASE WHEN request_status NOT IN ('Completed', 'Cancelled') THEN service_request_id END)
      comment: "Number of service requests currently open or in-progress — measures operational backlog and response capacity."
    - name: "completed_service_requests"
      expr: COUNT(CASE WHEN request_status = 'Completed' THEN service_request_id END)
      comment: "Number of completed service requests — measures operational throughput and fulfillment rate."
    - name: "sla_breached_requests"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN service_request_id END)
      comment: "Number of service requests that breached their SLA — numerator for SLA breach rate; directly tied to contract penalties and customer satisfaction."
    - name: "escalated_requests"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN service_request_id END)
      comment: "Number of escalated service requests — measures the volume of requests requiring management intervention."
    - name: "regulatory_requests"
      expr: COUNT(CASE WHEN regulatory_flag = TRUE THEN service_request_id END)
      comment: "Number of service requests with a regulatory component — measures compliance-driven workload for regulatory reporting."
    - name: "total_estimated_weight_tons"
      expr: SUM(CAST(estimated_weight_tons AS DOUBLE))
      comment: "Total estimated waste weight in tons across all service requests — measures throughput volume for capacity and disposal planning."
    - name: "avg_estimated_weight_tons"
      expr: AVG(CAST(estimated_weight_tons AS DOUBLE))
      comment: "Average estimated waste weight per service request — benchmarks load size for route optimization and vehicle capacity planning."
    - name: "distinct_customers_with_requests"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers who submitted service requests — measures active service demand breadth across the customer base."
    - name: "tipping_fee_applicable_requests"
      expr: COUNT(CASE WHEN tipping_fee_applicable = TRUE THEN service_request_id END)
      comment: "Number of service requests where a tipping fee applies — measures the volume of fee-generating disposal events for revenue tracking."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_account_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account lifecycle transition KPIs — tracks status change patterns, churn classification, financial exposure at transition, and win-back eligibility. Enables churn prediction, collections strategy, and reactivation campaign targeting."
  source: "`waste_management_ecm`.`customer`.`account_status_history`"
  dimensions:
    - name: "transition_type"
      expr: transition_type
      comment: "Type of status transition (Activation, Suspension, Cancellation, Reactivation) — primary axis for lifecycle event analysis."
    - name: "new_status"
      expr: new_status
      comment: "The status the account transitioned into — used to measure inflow into each lifecycle state."
    - name: "prior_status"
      expr: prior_status
      comment: "The status the account transitioned from — used to analyze transition paths and identify at-risk patterns."
    - name: "churn_classification"
      expr: churn_classification
      comment: "Classification of the churn event (Voluntary, Involuntary, Competitive Loss, Regulatory) — drives targeted retention and win-back strategy."
    - name: "reason_code"
      expr: reason_code
      comment: "Coded reason for the status transition — enables root-cause analysis of churn and suspension events."
    - name: "suspension_reason_category"
      expr: suspension_reason_category
      comment: "Category of the suspension reason (Non-Payment, Regulatory, Operational) — informs collections and compliance response."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Channel used to notify the customer of the status change — measures notification effectiveness and channel preference alignment."
    - name: "reactivation_eligible"
      expr: reactivation_eligible
      comment: "Whether the account is eligible for reactivation — used to size win-back campaign audiences."
    - name: "hazardous_waste_account"
      expr: hazardous_waste_account
      comment: "Whether the account handles hazardous waste — segments regulated account transitions for compliance monitoring."
    - name: "sla_breach"
      expr: sla_breach
      comment: "Whether an SLA breach was associated with this transition — used to correlate service failures with account churn."
    - name: "effective_month"
      expr: DATE_TRUNC('MONTH', effective_timestamp)
      comment: "Month the status transition became effective — used for churn and reactivation trend analysis over time."
    - name: "initiating_system"
      expr: initiating_system
      comment: "System that initiated the status change (CRM, Billing, Compliance) — used to audit automated vs. manual transitions."
  measures:
    - name: "total_status_transitions"
      expr: COUNT(account_status_history_id)
      comment: "Total number of account status transitions — baseline volume KPI for lifecycle event monitoring."
    - name: "churn_events"
      expr: COUNT(CASE WHEN new_status IN ('Closed', 'Cancelled', 'Terminated') THEN account_status_history_id END)
      comment: "Number of transitions into a closed/churned state — the primary churn volume KPI used in retention and revenue forecasting."
    - name: "reactivation_events"
      expr: COUNT(CASE WHEN transition_type = 'Reactivation' THEN account_status_history_id END)
      comment: "Number of account reactivations — measures win-back program effectiveness and recovered revenue opportunity."
    - name: "suspension_events"
      expr: COUNT(CASE WHEN new_status = 'Suspended' THEN account_status_history_id END)
      comment: "Number of account suspensions — a leading indicator of collections pressure and potential churn."
    - name: "reactivation_eligible_accounts"
      expr: COUNT(CASE WHEN reactivation_eligible = TRUE THEN account_status_history_id END)
      comment: "Number of transitions where the account is eligible for reactivation — sizes the addressable win-back audience for marketing campaigns."
    - name: "total_ar_balance_at_transition_usd"
      expr: SUM(CAST(ar_balance_at_transition AS DOUBLE))
      comment: "Total accounts receivable balance outstanding at the time of status transition — measures financial exposure associated with churn and suspension events."
    - name: "avg_ar_balance_at_transition_usd"
      expr: AVG(CAST(ar_balance_at_transition AS DOUBLE))
      comment: "Average AR balance at the time of status transition — benchmarks the financial risk profile of churning or suspended accounts."
    - name: "total_write_off_amount_usd"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total dollar amount written off at account transition — measures bad debt impact from churn and collections failures."
    - name: "avg_write_off_amount_usd"
      expr: AVG(CAST(write_off_amount AS DOUBLE))
      comment: "Average write-off amount per transition event — benchmarks bad debt severity and informs credit policy decisions."
    - name: "sla_breach_transitions"
      expr: COUNT(CASE WHEN sla_breach = TRUE THEN account_status_history_id END)
      comment: "Number of status transitions associated with an SLA breach — measures the correlation between service failures and account churn."
    - name: "notification_sent_transitions"
      expr: COUNT(CASE WHEN notification_sent = TRUE THEN account_status_history_id END)
      comment: "Number of transitions where a customer notification was successfully sent — measures notification compliance and communication effectiveness."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_waste_generator_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory compliance and waste generator KPIs — tracks EPA registration status, hazardous waste volumes, inspection outcomes, violation exposure, and biennial reporting compliance. Critical for environmental regulatory risk management."
  source: "`waste_management_ecm`.`customer`.`waste_generator_profile`"
  dimensions:
    - name: "accumulation_area_type"
      expr: accumulation_area_type
      comment: "Type of waste accumulation area (Satellite, Central, 90-Day) — used to classify generator compliance obligations."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Outcome of the most recent compliance inspection (Pass, Fail, Conditional) — primary axis for regulatory risk segmentation."
    - name: "open_violation_flag"
      expr: open_violation_flag
      comment: "Whether the generator has an open regulatory violation — critical risk indicator for compliance and legal teams."
    - name: "manifest_required_flag"
      expr: manifest_required_flag
      comment: "Whether a hazardous waste manifest is required for this generator — used to ensure regulatory documentation compliance."
    - name: "e_manifest_registered_flag"
      expr: e_manifest_registered_flag
      comment: "Whether the generator is registered for EPA e-Manifest — measures digital compliance adoption."
    - name: "universal_waste_handler_flag"
      expr: universal_waste_handler_flag
      comment: "Whether the generator handles universal waste (batteries, lamps, etc.) — segments universal waste compliance obligations."
    - name: "contingency_plan_on_file"
      expr: contingency_plan_on_file
      comment: "Whether a contingency plan is on file for the generator — measures emergency preparedness compliance."
    - name: "personnel_training_current_flag"
      expr: personnel_training_current_flag
      comment: "Whether personnel training is current for this generator — tracks training compliance status across the regulated customer base."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry code of the waste generator — enables industry-vertical compliance risk analysis."
    - name: "state_program_code"
      expr: state_program_code
      comment: "State-level regulatory program code — used for state-specific compliance reporting and jurisdiction analysis."
    - name: "last_inspection_month"
      expr: DATE_TRUNC('MONTH', last_inspection_date)
      comment: "Month of the most recent compliance inspection — used to identify generators overdue for inspection."
    - name: "biennial_report_due_month"
      expr: DATE_TRUNC('MONTH', biennial_report_due_date)
      comment: "Month the biennial hazardous waste report is due — used to track upcoming regulatory filing deadlines."
  measures:
    - name: "total_generator_profiles"
      expr: COUNT(waste_generator_profile_id)
      comment: "Total number of waste generator profiles — measures the size of the regulated customer base requiring compliance management."
    - name: "open_violation_generators"
      expr: COUNT(CASE WHEN open_violation_flag = TRUE THEN waste_generator_profile_id END)
      comment: "Number of generators with open regulatory violations — the primary compliance risk KPI monitored by environmental health and safety leadership."
    - name: "generators_failing_inspection"
      expr: COUNT(CASE WHEN inspection_result = 'Fail' THEN waste_generator_profile_id END)
      comment: "Number of generators that failed their most recent compliance inspection — measures regulatory non-compliance exposure."
    - name: "generators_missing_contingency_plan"
      expr: COUNT(CASE WHEN contingency_plan_on_file = FALSE THEN waste_generator_profile_id END)
      comment: "Number of generators without a contingency plan on file — identifies emergency preparedness compliance gaps."
    - name: "generators_with_lapsed_training"
      expr: COUNT(CASE WHEN personnel_training_current_flag = FALSE THEN waste_generator_profile_id END)
      comment: "Number of generators where personnel training is not current — measures training compliance risk across the regulated portfolio."
    - name: "total_estimated_hazardous_volume_kg_per_month"
      expr: SUM(CAST(estimated_hazardous_volume_kg_per_month AS DOUBLE))
      comment: "Total estimated monthly hazardous waste volume in kilograms across all generators — measures aggregate regulatory waste throughput for capacity and disposal planning."
    - name: "avg_estimated_hazardous_volume_kg_per_month"
      expr: AVG(CAST(estimated_hazardous_volume_kg_per_month AS DOUBLE))
      comment: "Average monthly hazardous waste volume per generator — benchmarks generator size and informs generator classification (SQG vs. LQG) monitoring."
    - name: "total_estimated_monthly_volume_tons"
      expr: SUM(CAST(estimated_monthly_volume_tons AS DOUBLE))
      comment: "Total estimated monthly waste volume in tons across all generator profiles — measures aggregate waste throughput for landfill and transfer station capacity planning."
    - name: "avg_estimated_monthly_volume_tons"
      expr: AVG(CAST(estimated_monthly_volume_tons AS DOUBLE))
      comment: "Average monthly waste volume per generator in tons — used to benchmark generator size and optimize collection frequency."
    - name: "e_manifest_registered_generators"
      expr: COUNT(CASE WHEN e_manifest_registered_flag = TRUE THEN waste_generator_profile_id END)
      comment: "Number of generators registered for EPA e-Manifest — measures digital compliance adoption and readiness for paperless manifest processing."
    - name: "manifest_required_generators"
      expr: COUNT(CASE WHEN manifest_required_flag = TRUE THEN waste_generator_profile_id END)
      comment: "Number of generators requiring hazardous waste manifests — measures the scope of manifest compliance obligations across the customer base."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_container_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container asset deployment and utilization KPIs — tracks container assignments, service frequency, size distribution, and missed pickups. Informs asset management, route optimization, and service quality decisions."
  source: "`waste_management_ecm`.`customer`.`container_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the container assignment (Active, Removed, Pending) — primary axis for active asset portfolio analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of service associated with the container (Trash, Recycling, Organics, Hazardous) — enables service-line asset analysis."
    - name: "material_stream"
      expr: material_stream
      comment: "Waste material stream for the container (MSW, Cardboard, Glass, Hazardous) — used for recycling program and diversion analysis."
    - name: "collection_frequency"
      expr: collection_frequency
      comment: "Scheduled collection frequency (Weekly, Bi-Weekly, Monthly, On-Demand) — informs route density and capacity planning."
    - name: "collection_day_of_week"
      expr: collection_day_of_week
      comment: "Scheduled collection day — used for route load balancing and operational scheduling."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment associated with the container assignment — enables segment-level asset deployment analysis."
    - name: "enclosure_required"
      expr: enclosure_required
      comment: "Whether an enclosure is required for the container — informs site preparation and compliance requirements."
    - name: "lock_required"
      expr: lock_required
      comment: "Whether a lock is required for the container — used to track security compliance and asset protection requirements."
    - name: "regulatory_manifest_required"
      expr: regulatory_manifest_required
      comment: "Whether a regulatory manifest is required for this container — segments regulated waste container assignments."
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month the container was delivered — used for asset deployment trend analysis."
    - name: "removal_month"
      expr: DATE_TRUNC('MONTH', removal_date)
      comment: "Month the container was removed — used for asset retrieval trend and churn analysis."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN container_assignment_id END)
      comment: "Total number of active container assignments — the primary asset deployment KPI for fleet and operations management."
    - name: "total_assignments"
      expr: COUNT(container_assignment_id)
      comment: "Total container assignments across all statuses — baseline for assignment rate and asset utilization calculations."
    - name: "total_size_cubic_yards"
      expr: SUM(CAST(size_cubic_yards AS DOUBLE))
      comment: "Total container capacity in cubic yards across all active assignments — measures aggregate waste collection capacity deployed in the field."
    - name: "avg_size_cubic_yards"
      expr: AVG(CAST(size_cubic_yards AS DOUBLE))
      comment: "Average container size in cubic yards — benchmarks container sizing decisions and informs right-sizing recommendations."
    - name: "total_size_gallons"
      expr: SUM(CAST(size_gallons AS DOUBLE))
      comment: "Total container capacity in gallons across all assignments — used for liquid waste and small container capacity planning."
    - name: "distinct_customers_with_containers"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with at least one container assignment — measures active service footprint."
    - name: "distinct_service_addresses_with_containers"
      expr: COUNT(DISTINCT service_address_id)
      comment: "Number of unique service addresses with container assignments — measures geographic asset deployment density."
    - name: "regulatory_manifest_required_assignments"
      expr: COUNT(CASE WHEN regulatory_manifest_required = TRUE THEN container_assignment_id END)
      comment: "Number of container assignments requiring a regulatory manifest — measures the scope of hazardous waste container compliance obligations."
$$;

CREATE OR REPLACE VIEW `waste_management_ecm`.`_metrics`.`customer_communication_preference`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer communication consent and digital engagement KPIs — tracks opt-in rates, suppression, channel preferences, and consent compliance. Informs marketing strategy, regulatory notice delivery, and digital engagement investment."
  source: "`waste_management_ecm`.`customer`.`communication_preference`"
  dimensions:
    - name: "channel"
      expr: channel
      comment: "Communication channel (Email, SMS, Phone, Mail, Portal) — primary axis for channel mix and digital adoption analysis."
    - name: "preference_type"
      expr: preference_type
      comment: "Type of communication preference (Marketing, Service, Billing, Regulatory) — used to segment consent by communication purpose."
    - name: "notification_type"
      expr: notification_type
      comment: "Specific notification type associated with the preference — enables granular opt-in analysis by notification category."
    - name: "consent_status"
      expr: consent_status
      comment: "Current consent status (Active, Expired, Withdrawn) — primary axis for consent compliance monitoring."
    - name: "consent_method"
      expr: consent_method
      comment: "Method by which consent was obtained (Web Form, Paper, Verbal, Import) — used for consent audit and regulatory compliance."
    - name: "language_preference"
      expr: language_preference
      comment: "Customer's preferred language for communications — informs multilingual communication strategy and localization investment."
    - name: "opt_in_status"
      expr: opt_in_status
      comment: "Current opt-in status for the preference — used to measure active consent rates across channels."
    - name: "is_active"
      expr: is_active
      comment: "Whether the communication preference record is currently active — used to filter to current consent state."
    - name: "suppression_list_flag"
      expr: suppression_list_flag
      comment: "Whether the contact is on a suppression list — critical for compliance with CAN-SPAM, TCPA, and other communication regulations."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the preference became effective — used for consent trend analysis over time."
  measures:
    - name: "total_preference_records"
      expr: COUNT(communication_preference_id)
      comment: "Total communication preference records — baseline for consent coverage and opt-in rate calculations."
    - name: "active_opt_in_preferences"
      expr: COUNT(CASE WHEN is_active = TRUE AND opt_in_status = 'Opted In' THEN communication_preference_id END)
      comment: "Number of active opt-in communication preferences — measures the reachable audience for each communication channel."
    - name: "suppressed_contacts"
      expr: COUNT(CASE WHEN suppression_list_flag = TRUE THEN communication_preference_id END)
      comment: "Number of contacts on suppression lists — measures the volume of contacts excluded from outreach for compliance reasons."
    - name: "do_not_contact_preferences"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN communication_preference_id END)
      comment: "Number of preferences with a do-not-contact flag — critical compliance KPI to prevent regulatory violations."
    - name: "billing_alert_opt_in_count"
      expr: COUNT(CASE WHEN billing_alert_opt_in = TRUE THEN communication_preference_id END)
      comment: "Number of customers opted into billing alerts — measures adoption of proactive billing communication, which reduces disputes and late payments."
    - name: "portal_notification_enabled_count"
      expr: COUNT(CASE WHEN portal_notification_enabled = TRUE THEN communication_preference_id END)
      comment: "Number of customers with portal notifications enabled — measures digital self-service engagement and potential for call-deflection."
    - name: "nps_survey_opt_in_count"
      expr: COUNT(CASE WHEN nps_survey_opt_in = TRUE THEN communication_preference_id END)
      comment: "Number of customers opted into NPS surveys — measures the addressable audience for customer satisfaction measurement programs."
    - name: "regulatory_notice_opt_in_count"
      expr: COUNT(CASE WHEN regulatory_notice_opt_in = TRUE THEN communication_preference_id END)
      comment: "Number of customers opted into regulatory notices — measures compliance with mandatory regulatory communication delivery obligations."
    - name: "distinct_customers_with_preferences"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of unique customers with at least one communication preference on record — measures consent management coverage across the customer base."
$$;