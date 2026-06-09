-- Metric views for domain: correspondence | Business: Life Insurance | Version: 1 | Generated on: 2026-05-04 03:35:10

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_communication`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core communication delivery and engagement metrics tracking outbound and inbound correspondence performance, delivery success rates, and response timeliness across all channels"
  source: "`life_insurance_ecm`.`correspondence`.`communication`"
  dimensions:
    - name: "communication_status"
      expr: communication_status
      comment: "Current status of the communication (sent, delivered, failed, read)"
    - name: "communication_category"
      expr: communication_category
      comment: "Business category of communication (regulatory, service, marketing, claims)"
    - name: "direction"
      expr: direction
      comment: "Communication direction (inbound or outbound)"
    - name: "comm_channel"
      expr: comm_channel_id
      comment: "Communication channel used for delivery"
    - name: "language_code"
      expr: language_code
      comment: "Language of the communication"
    - name: "priority"
      expr: priority
      comment: "Priority level of the communication"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Whether communication is mandated by regulation"
    - name: "is_complaint"
      expr: is_complaint
      comment: "Whether communication is complaint-related"
    - name: "sent_month"
      expr: DATE_TRUNC('MONTH', sent_timestamp)
      comment: "Month when communication was sent"
    - name: "delivered_month"
      expr: DATE_TRUNC('MONTH', delivered_timestamp)
      comment: "Month when communication was delivered"
  measures:
    - name: "total_communications"
      expr: COUNT(1)
      comment: "Total number of communications sent or received"
    - name: "delivered_communications"
      expr: COUNT(CASE WHEN delivered_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of communications successfully delivered"
    - name: "failed_communications"
      expr: COUNT(CASE WHEN delivery_failure_reason IS NOT NULL THEN 1 END)
      comment: "Number of communications that failed delivery"
    - name: "read_communications"
      expr: COUNT(CASE WHEN read_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of communications opened/read by recipient"
    - name: "regulatory_communications"
      expr: COUNT(CASE WHEN is_regulatory_required = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated communications"
    - name: "complaint_communications"
      expr: COUNT(CASE WHEN is_complaint = TRUE THEN 1 END)
      comment: "Number of complaint-related communications"
    - name: "avg_delivery_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(delivered_timestamp) - UNIX_TIMESTAMP(sent_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from sent to delivered"
    - name: "avg_read_time_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(read_timestamp) - UNIX_TIMESTAMP(delivered_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from delivered to read"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint management and resolution performance metrics tracking complaint volume, resolution effectiveness, regulatory escalations, and customer satisfaction outcomes"
  source: "`life_insurance_ecm`.`correspondence`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (open, investigating, resolved, closed)"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Primary category of the complaint"
    - name: "complaint_source"
      expr: complaint_source
      comment: "Source channel through which complaint was received"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to complaint"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether complaint has been escalated"
    - name: "regulator_involved_flag"
      expr: regulator_involved_flag
      comment: "Whether regulatory body is involved"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified during investigation"
    - name: "resolution_outcome"
      expr: resolution_outcome
      comment: "Final outcome of complaint resolution"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month when complaint was received"
    - name: "closed_month"
      expr: DATE_TRUNC('MONTH', closed_date)
      comment: "Month when complaint was closed"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints received"
    - name: "open_complaints"
      expr: COUNT(CASE WHEN complaint_status IN ('Open', 'Investigating', 'Assigned') THEN 1 END)
      comment: "Number of complaints currently open or in progress"
    - name: "closed_complaints"
      expr: COUNT(CASE WHEN closed_date IS NOT NULL THEN 1 END)
      comment: "Number of complaints closed"
    - name: "escalated_complaints"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of complaints escalated to higher authority"
    - name: "regulator_involved_complaints"
      expr: COUNT(CASE WHEN regulator_involved_flag = TRUE THEN 1 END)
      comment: "Number of complaints involving regulatory bodies"
    - name: "complaints_with_financial_remedy"
      expr: COUNT(CASE WHEN financial_remedy_amount > 0 THEN 1 END)
      comment: "Number of complaints resulting in financial remedy"
    - name: "total_financial_remedy_amount"
      expr: SUM(CAST(financial_remedy_amount AS DOUBLE))
      comment: "Total financial remedies paid to complainants"
    - name: "avg_financial_remedy_amount"
      expr: AVG(CAST(financial_remedy_amount AS DOUBLE))
      comment: "Average financial remedy amount per complaint"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, received_date) AS DOUBLE))
      comment: "Average days from complaint receipt to resolution"
    - name: "avg_closure_days"
      expr: AVG(CAST(DATEDIFF(closed_date, received_date) AS DOUBLE))
      comment: "Average days from complaint receipt to closure"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_call_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Call center performance and quality metrics tracking call volume, handling efficiency, customer satisfaction, and service quality outcomes"
  source: "`life_insurance_ecm`.`correspondence`.`call_record`"
  dimensions:
    - name: "call_direction"
      expr: call_direction
      comment: "Direction of call (inbound or outbound)"
    - name: "call_type"
      expr: call_type
      comment: "Type of call (service, sales, complaint, inquiry)"
    - name: "call_disposition"
      expr: call_disposition
      comment: "Final disposition of the call"
    - name: "authentication_status"
      expr: authentication_status
      comment: "Whether caller was successfully authenticated"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether call was escalated"
    - name: "complaint_flag"
      expr: complaint_flag
      comment: "Whether call involved a complaint"
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Whether follow-up action is required"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Whether call is reportable to regulators"
    - name: "call_month"
      expr: DATE_TRUNC('MONTH', call_start_timestamp)
      comment: "Month when call occurred"
  measures:
    - name: "total_calls"
      expr: COUNT(1)
      comment: "Total number of calls handled"
    - name: "inbound_calls"
      expr: COUNT(CASE WHEN call_direction = 'Inbound' THEN 1 END)
      comment: "Number of inbound calls received"
    - name: "outbound_calls"
      expr: COUNT(CASE WHEN call_direction = 'Outbound' THEN 1 END)
      comment: "Number of outbound calls made"
    - name: "escalated_calls"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of calls escalated to supervisor or specialist"
    - name: "complaint_calls"
      expr: COUNT(CASE WHEN complaint_flag = TRUE THEN 1 END)
      comment: "Number of calls involving complaints"
    - name: "calls_requiring_followup"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of calls requiring follow-up action"
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_assurance_score AS DOUBLE))
      comment: "Average quality assurance score across reviewed calls"
    - name: "calls_with_qa_review"
      expr: COUNT(CASE WHEN qa_review_date IS NOT NULL THEN 1 END)
      comment: "Number of calls that underwent quality assurance review"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_outbound_notice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbound notice delivery and compliance metrics tracking regulatory notice fulfillment, delivery performance, cost efficiency, and compliance deadline adherence"
  source: "`life_insurance_ecm`.`correspondence`.`outbound_notice`"
  dimensions:
    - name: "notice_status"
      expr: notice_status
      comment: "Current status of the notice (scheduled, generated, dispatched, delivered)"
    - name: "notice_type"
      expr: notice_type
      comment: "Type of notice being sent"
    - name: "notice_category"
      expr: notice_category
      comment: "Business category of the notice"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether notice is mandated by regulation"
    - name: "suppression_flag"
      expr: suppression_flag
      comment: "Whether notice was suppressed from delivery"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the notice"
    - name: "delivery_preference"
      expr: delivery_preference
      comment: "Preferred delivery method (electronic, mail, etc.)"
    - name: "language_code"
      expr: language_code
      comment: "Language of the notice"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the notice"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_send_date)
      comment: "Month when notice was scheduled for delivery"
    - name: "dispatch_month"
      expr: DATE_TRUNC('MONTH', dispatch_timestamp)
      comment: "Month when notice was dispatched"
  measures:
    - name: "total_notices"
      expr: COUNT(1)
      comment: "Total number of outbound notices"
    - name: "regulatory_notices"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated notices"
    - name: "dispatched_notices"
      expr: COUNT(CASE WHEN dispatch_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of notices successfully dispatched"
    - name: "suppressed_notices"
      expr: COUNT(CASE WHEN suppression_flag = TRUE THEN 1 END)
      comment: "Number of notices suppressed from delivery"
    - name: "total_notice_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of producing and delivering notices"
    - name: "avg_notice_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per notice"
    - name: "total_page_count"
      expr: SUM(CAST(page_count AS DOUBLE))
      comment: "Total pages across all notices"
    - name: "avg_page_count"
      expr: AVG(CAST(page_count AS DOUBLE))
      comment: "Average pages per notice"
    - name: "notices_meeting_compliance_deadline"
      expr: COUNT(CASE WHEN dispatch_timestamp <= compliance_deadline_date THEN 1 END)
      comment: "Number of notices dispatched before compliance deadline"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_returned_mail`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Returned mail tracking and address quality metrics measuring delivery failure rates, address verification effectiveness, and unclaimed property risk"
  source: "`life_insurance_ecm`.`correspondence`.`returned_mail`"
  dimensions:
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for mail return"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Status of returned mail resolution"
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of correspondence that was returned"
    - name: "address_verification_status"
      expr: address_verification_status
      comment: "Status of address verification attempt"
    - name: "ncoa_match_found_flag"
      expr: ncoa_match_found_flag
      comment: "Whether NCOA (National Change of Address) match was found"
    - name: "dmf_match_found_flag"
      expr: dmf_match_found_flag
      comment: "Whether Death Master File match was found"
    - name: "skip_trace_initiated_flag"
      expr: skip_trace_initiated_flag
      comment: "Whether skip trace investigation was initiated"
    - name: "regulatory_reporting_required_flag"
      expr: regulatory_reporting_required_flag
      comment: "Whether return requires regulatory reporting"
    - name: "unclaimed_property_state"
      expr: unclaimed_property_state
      comment: "State jurisdiction for unclaimed property reporting"
    - name: "return_month"
      expr: DATE_TRUNC('MONTH', return_date)
      comment: "Month when mail was returned"
  measures:
    - name: "total_returned_mail"
      expr: COUNT(1)
      comment: "Total number of returned mail items"
    - name: "resolved_returns"
      expr: COUNT(CASE WHEN resolution_date IS NOT NULL THEN 1 END)
      comment: "Number of returned mail items successfully resolved"
    - name: "ncoa_matches"
      expr: COUNT(CASE WHEN ncoa_match_found_flag = TRUE THEN 1 END)
      comment: "Number of returns with successful NCOA address match"
    - name: "dmf_matches"
      expr: COUNT(CASE WHEN dmf_match_found_flag = TRUE THEN 1 END)
      comment: "Number of returns with Death Master File match (deceased)"
    - name: "skip_traces_initiated"
      expr: COUNT(CASE WHEN skip_trace_initiated_flag = TRUE THEN 1 END)
      comment: "Number of skip trace investigations initiated"
    - name: "regulatory_reportable_returns"
      expr: COUNT(CASE WHEN regulatory_reporting_required_flag = TRUE THEN 1 END)
      comment: "Number of returns requiring regulatory reporting"
    - name: "unclaimed_property_notifications"
      expr: COUNT(CASE WHEN unclaimed_property_notification_date IS NOT NULL THEN 1 END)
      comment: "Number of unclaimed property notifications sent"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(resolution_date, return_date) AS DOUBLE))
      comment: "Average days from mail return to resolution"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_bulk_comm_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bulk communication campaign performance metrics tracking campaign delivery effectiveness, cost efficiency, engagement rates, and regulatory compliance"
  source: "`life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`"
  dimensions:
    - name: "bulk_comm_campaign_status"
      expr: bulk_comm_campaign_status
      comment: "Current status of the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of bulk communication campaign"
    - name: "campaign_category"
      expr: campaign_category
      comment: "Business category of the campaign"
    - name: "business_trigger"
      expr: business_trigger
      comment: "Business event that triggered the campaign"
    - name: "regulatory_requirement_flag"
      expr: regulatory_requirement_flag
      comment: "Whether campaign is mandated by regulation"
    - name: "approval_required_flag"
      expr: approval_required_flag
      comment: "Whether campaign required approval"
    - name: "language_code"
      expr: language_code
      comment: "Language of campaign communications"
    - name: "priority"
      expr: priority
      comment: "Priority level of the campaign"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_dispatch_date)
      comment: "Month when campaign was scheduled"
    - name: "actual_dispatch_month"
      expr: DATE_TRUNC('MONTH', actual_dispatch_date)
      comment: "Month when campaign was actually dispatched"
  measures:
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of bulk communication campaigns"
    - name: "completed_campaigns"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of campaigns completed"
    - name: "regulatory_campaigns"
      expr: COUNT(CASE WHEN regulatory_requirement_flag = TRUE THEN 1 END)
      comment: "Number of regulatory-mandated campaigns"
    - name: "total_target_recipients"
      expr: SUM(CAST(target_recipient_count AS DOUBLE))
      comment: "Total target recipient count across all campaigns"
    - name: "total_actual_sent"
      expr: SUM(CAST(actual_sent_count AS DOUBLE))
      comment: "Total communications actually sent across all campaigns"
    - name: "total_delivery_success"
      expr: SUM(CAST(delivery_success_count AS DOUBLE))
      comment: "Total successful deliveries across all campaigns"
    - name: "total_delivery_failure"
      expr: SUM(CAST(delivery_failure_count AS DOUBLE))
      comment: "Total delivery failures across all campaigns"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost_amount AS DOUBLE))
      comment: "Total estimated cost across all campaigns"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_amount AS DOUBLE))
      comment: "Total actual cost across all campaigns"
    - name: "avg_cost_per_campaign"
      expr: AVG(CAST(actual_cost_amount AS DOUBLE))
      comment: "Average actual cost per campaign"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_doi_inquiry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Department of Insurance inquiry and regulatory response metrics tracking inquiry volume, resolution timeliness, corrective actions, and financial penalties"
  source: "`life_insurance_ecm`.`correspondence`.`doi_inquiry`"
  dimensions:
    - name: "inquiry_status"
      expr: inquiry_status
      comment: "Current status of the DOI inquiry"
    - name: "inquiry_type"
      expr: inquiry_type
      comment: "Type of regulatory inquiry"
    - name: "inquiry_category"
      expr: inquiry_category
      comment: "Category of the inquiry"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body conducting the inquiry"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction of the inquiry"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to inquiry"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether inquiry has been escalated"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required"
    - name: "investigation_required_flag"
      expr: investigation_required_flag
      comment: "Whether formal investigation is required"
    - name: "legal_counsel_involved_flag"
      expr: legal_counsel_involved_flag
      comment: "Whether legal counsel is involved"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', inquiry_received_date)
      comment: "Month when inquiry was received"
  measures:
    - name: "total_inquiries"
      expr: COUNT(1)
      comment: "Total number of DOI inquiries received"
    - name: "open_inquiries"
      expr: COUNT(CASE WHEN inquiry_status IN ('Open', 'In Progress', 'Under Investigation') THEN 1 END)
      comment: "Number of inquiries currently open"
    - name: "closed_inquiries"
      expr: COUNT(CASE WHEN disposition_date IS NOT NULL THEN 1 END)
      comment: "Number of inquiries closed"
    - name: "escalated_inquiries"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END)
      comment: "Number of inquiries escalated"
    - name: "inquiries_requiring_corrective_action"
      expr: COUNT(CASE WHEN corrective_action_required_flag = TRUE THEN 1 END)
      comment: "Number of inquiries requiring corrective action"
    - name: "inquiries_with_legal_counsel"
      expr: COUNT(CASE WHEN legal_counsel_involved_flag = TRUE THEN 1 END)
      comment: "Number of inquiries involving legal counsel"
    - name: "inquiries_with_fines"
      expr: COUNT(CASE WHEN fine_or_penalty_amount > 0 THEN 1 END)
      comment: "Number of inquiries resulting in fines or penalties"
    - name: "total_fines_and_penalties"
      expr: SUM(CAST(fine_or_penalty_amount AS DOUBLE))
      comment: "Total fines and penalties assessed"
    - name: "avg_fine_amount"
      expr: AVG(CAST(fine_or_penalty_amount AS DOUBLE))
      comment: "Average fine or penalty amount per inquiry"
    - name: "avg_response_days"
      expr: AVG(CAST(DATEDIFF(response_submitted_date, inquiry_received_date) AS DOUBLE))
      comment: "Average days from inquiry receipt to response submission"
    - name: "avg_disposition_days"
      expr: AVG(CAST(DATEDIFF(disposition_date, inquiry_received_date) AS DOUBLE))
      comment: "Average days from inquiry receipt to final disposition"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_queue_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work queue assignment and SLA performance metrics tracking workload distribution, handling efficiency, SLA compliance, and escalation patterns"
  source: "`life_insurance_ecm`.`correspondence`.`queue_assignment`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the queue assignment"
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign work (auto, manual, skill-based)"
    - name: "correspondence_type"
      expr: correspondence_type
      comment: "Type of correspondence assigned"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the assignment"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation level of the assignment"
    - name: "channel"
      expr: channel
      comment: "Communication channel of the assignment"
    - name: "is_active"
      expr: is_active
      comment: "Whether assignment is currently active"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether SLA was breached"
    - name: "assignment_month"
      expr: DATE_TRUNC('MONTH', assignment_date)
      comment: "Month when work was assigned"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when work was completed"
  measures:
    - name: "total_assignments"
      expr: COUNT(1)
      comment: "Total number of queue assignments"
    - name: "active_assignments"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active assignments"
    - name: "completed_assignments"
      expr: COUNT(CASE WHEN completion_date IS NOT NULL THEN 1 END)
      comment: "Number of completed assignments"
    - name: "sla_breached_assignments"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Number of assignments that breached SLA"
    - name: "reassigned_items"
      expr: COUNT(CASE WHEN CAST(reassignment_count AS INT) > 0 THEN 1 END)
      comment: "Number of items that were reassigned"
    - name: "avg_handling_hours"
      expr: AVG(CAST(actual_handling_hours AS DOUBLE))
      comment: "Average actual handling time in hours"
    - name: "avg_sla_breach_hours"
      expr: AVG(CAST(sla_breach_hours AS DOUBLE))
      comment: "Average hours by which SLA was breached"
    - name: "avg_skill_match_score"
      expr: AVG(CAST(skill_match_score AS DOUBLE))
      comment: "Average skill match score for assignments"
    - name: "avg_workload_balance_score"
      expr: AVG(CAST(workload_balance_score AS DOUBLE))
      comment: "Average workload balance score across assignments"
$$;

CREATE OR REPLACE VIEW `life_insurance_ecm`.`_metrics`.`correspondence_escalation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Escalation management and resolution metrics tracking escalation volume, severity, financial impact, regulatory risk, and resolution effectiveness"
  source: "`life_insurance_ecm`.`correspondence`.`escalation`"
  dimensions:
    - name: "escalation_status"
      expr: escalation_status
      comment: "Current status of the escalation"
    - name: "escalation_type"
      expr: escalation_type
      comment: "Type of escalation"
    - name: "escalation_category"
      expr: escalation_category
      comment: "Category of the escalation"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Level of escalation (L1, L2, L3, executive)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the escalation"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the escalation"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category identified"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution code for the escalation"
    - name: "is_litigation_risk"
      expr: is_litigation_risk
      comment: "Whether escalation poses litigation risk"
    - name: "is_regulatory_reportable"
      expr: is_regulatory_reportable
      comment: "Whether escalation is reportable to regulators"
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Whether legal review is required"
    - name: "escalation_month"
      expr: DATE_TRUNC('MONTH', escalation_date)
      comment: "Month when escalation occurred"
  measures:
    - name: "total_escalations"
      expr: COUNT(1)
      comment: "Total number of escalations"
    - name: "open_escalations"
      expr: COUNT(CASE WHEN escalation_status IN ('Open', 'In Progress', 'Under Review') THEN 1 END)
      comment: "Number of escalations currently open"
    - name: "resolved_escalations"
      expr: COUNT(CASE WHEN resolution_timestamp IS NOT NULL THEN 1 END)
      comment: "Number of escalations resolved"
    - name: "litigation_risk_escalations"
      expr: COUNT(CASE WHEN is_litigation_risk = TRUE THEN 1 END)
      comment: "Number of escalations with litigation risk"
    - name: "regulatory_reportable_escalations"
      expr: COUNT(CASE WHEN is_regulatory_reportable = TRUE THEN 1 END)
      comment: "Number of escalations reportable to regulators"
    - name: "escalations_requiring_legal_review"
      expr: COUNT(CASE WHEN legal_review_required = TRUE THEN 1 END)
      comment: "Number of escalations requiring legal review"
    - name: "escalations_with_financial_impact"
      expr: COUNT(CASE WHEN financial_impact_amount > 0 THEN 1 END)
      comment: "Number of escalations with financial impact"
    - name: "total_financial_impact"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all escalations"
    - name: "avg_financial_impact"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per escalation"
    - name: "total_sla_breach_hours"
      expr: SUM(CAST(sla_breach_hours AS DOUBLE))
      comment: "Total SLA breach hours across all escalations"
    - name: "avg_sla_breach_hours"
      expr: AVG(CAST(sla_breach_hours AS DOUBLE))
      comment: "Average SLA breach hours per escalation"
    - name: "avg_resolution_days"
      expr: AVG(CAST(DATEDIFF(actual_resolution_date, escalation_date) AS DOUBLE))
      comment: "Average days from escalation to resolution"
$$;