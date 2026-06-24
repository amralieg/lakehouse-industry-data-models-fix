-- Metric views for domain: interoperability | Business: Healthcare | Version: 2 | Generated on: 2026-06-23 14:47:42

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs over the HL7/interface message log — throughput, processing latency, SLA adherence, and error rates. These are core interface-engine reliability metrics for IT operations and integration leadership."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_log`"
  dimensions:
    - name: "message_standard"
      expr: message_standard
      comment: "Messaging standard (HL7v2, FHIR, CDA, X12) used for the message — segments throughput and reliability by interoperability standard."
    - name: "message_type"
      expr: message_type
      comment: "Message type code (e.g. ADT, ORM, ORU) — lets operations analyze volume and failures by clinical/business event type."
    - name: "processing_status"
      expr: processing_status
      comment: "Terminal processing status of the message — used to break out success vs failure rates."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation outcome of the message payload — surfaces structural/conformance quality issues."
    - name: "transport_protocol"
      expr: transport_protocol
      comment: "Transport protocol (MLLP, HTTPS, SFTP) — segments reliability by connectivity channel."
    - name: "message_day"
      expr: DATE_TRUNC('DAY', message_timestamp)
      comment: "Day the message was sent — primary time grain for throughput and trend analysis."
  measures:
    - name: "Message Volume"
      expr: COUNT(1)
      comment: "Total messages processed — baseline throughput metric leadership uses to size interface capacity."
    - name: "Avg Processing Latency Ms"
      expr: AVG(CAST(processing_latency_ms AS DOUBLE))
      comment: "Average end-to-end processing latency in milliseconds — directly tracks integration performance against SLA targets."
    - name: "Total Payload Bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total bytes transmitted — capacity-planning input for interface engine and network sizing."
    - name: "SLA Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages meeting the processing SLA — leadership intervenes when this drops below contractual targets."
    - name: "Error Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN processing_status = 'ERROR' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages ending in error — primary reliability KPI triggering interface remediation."
    - name: "Duplicate Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_duplicate = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages flagged as duplicates — indicates upstream routing or retry misconfiguration."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_message_error`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface message error management KPIs — error severity mix, escalation, resolution backlog and SLA breaches. Used by integration support leadership to manage operational risk."
  source: "`vibe_healthcare_v1`.`interoperability`.`message_error`"
  dimensions:
    - name: "error_category"
      expr: error_category
      comment: "Category of the message error (transformation, validation, connectivity) — drives root-cause analysis and team routing."
    - name: "error_severity"
      expr: error_severity
      comment: "Severity of the error — prioritizes which failures get immediate attention."
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution state — distinguishes open backlog from closed errors."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause — supports systemic problem-management and prevention initiatives."
    - name: "error_day"
      expr: DATE_TRUNC('DAY', error_timestamp)
      comment: "Day the error occurred — time grain for error trend monitoring."
  measures:
    - name: "Error Count"
      expr: COUNT(1)
      comment: "Total interface errors — baseline operational risk volume."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of errors that breached resolution SLA — escalation KPI for support leadership."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of errors requiring escalation — indicates first-line resolution effectiveness."
    - name: "Resolved Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN resolution_status = 'RESOLVED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of errors resolved — measures support team throughput and backlog burn-down."
    - name: "Retry Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN retry_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of errors eligible for automated retry — informs automation opportunity for self-healing interfaces."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_interface_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface availability and downtime impact KPIs — duration, uptime vs SLA, message loss, and review compliance. Critical for integration reliability and CIO-level operational risk reporting."
  source: "`vibe_healthcare_v1`.`interoperability`.`interface_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Planned vs unplanned downtime type — separates maintenance from incident-driven outages."
    - name: "impact_severity"
      expr: impact_severity
      comment: "Business impact severity of the outage — prioritizes major incident review."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Categorized root cause of the outage — drives systemic reliability improvements."
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event — distinguishes active incidents from resolved."
    - name: "downtime_day"
      expr: DATE_TRUNC('DAY', downtime_start_timestamp)
      comment: "Day the outage started — time grain for availability trending."
  measures:
    - name: "Downtime Event Count"
      expr: COUNT(1)
      comment: "Number of interface outage events — frequency component of reliability."
    - name: "Total Downtime Minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total minutes of interface unavailability — direct input to availability SLA and operational risk."
    - name: "Avg Actual Uptime Pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average achieved uptime percentage — benchmarked against SLA targets by leadership."
    - name: "Total Messages Lost"
      expr: SUM(CAST(messages_lost_count AS DOUBLE))
      comment: "Total messages lost during outages — quantifies data-integrity impact requiring reprocessing."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of outages breaching uptime SLA — escalation and vendor-accountability KPI."
    - name: "Post Incident Review Completion Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN post_incident_review_completed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of major outages with completed post-incident review — governance/compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_resource_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR API access KPIs — request volume, response performance, access-grant rates, and Cures Act information-blocking exceptions. Used for ONC/CMS interoperability compliance and API performance management."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_resource_log`"
  dimensions:
    - name: "fhir_resource_type"
      expr: fhir_resource_type
      comment: "FHIR resource type accessed — segments API usage by clinical data domain."
    - name: "operation_type"
      expr: operation_type
      comment: "FHIR operation (read, search, create) — analyzes API usage patterns."
    - name: "access_decision"
      expr: access_decision
      comment: "Whether access was granted or denied — central to information-blocking and consent monitoring."
    - name: "http_status_code"
      expr: http_status_code
      comment: "HTTP status of the API response — surfaces error vs success distribution."
    - name: "request_day"
      expr: DATE_TRUNC('DAY', request_timestamp)
      comment: "Day of the API request — time grain for usage and performance trending."
  measures:
    - name: "FHIR Request Volume"
      expr: COUNT(1)
      comment: "Total FHIR API requests — baseline measure of patient/provider access API adoption (CMS Patient Access metric)."
    - name: "Access Denial Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN access_decision = 'DENIED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of requests denied — monitored against Cures Act information-blocking obligations."
    - name: "Cures Act Exception Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cures_act_exception_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of accesses invoking a Cures Act exception — compliance risk indicator for information-blocking attestations."
    - name: "Data Segmentation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN data_segmentation_applied = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of accesses with sensitive-data segmentation applied — privacy/consent enforcement KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health information exchange query KPIs — query volume, success/match rates, response time, and consent verification. Used by HIE governance and clinical informatics to manage exchange effectiveness."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_query`"
  dimensions:
    - name: "query_type"
      expr: query_type
      comment: "Type of HIE query (patient discovery, document query) — segments exchange activity."
    - name: "query_status"
      expr: query_status
      comment: "Outcome status of the query — distinguishes success from failure/no-match."
    - name: "query_priority"
      expr: query_priority
      comment: "Priority of the query — separates urgent clinical lookups from routine."
    - name: "data_sensitivity_level"
      expr: data_sensitivity_level
      comment: "Sensitivity level of requested data — drives consent and Part 2 handling analysis."
    - name: "query_day"
      expr: DATE_TRUNC('DAY', query_timestamp)
      comment: "Day of the query — time grain for HIE utilization trending."
  measures:
    - name: "HIE Query Volume"
      expr: COUNT(1)
      comment: "Total HIE queries issued — adoption and utilization baseline for exchange participation value."
    - name: "Avg Query Response Seconds"
      expr: AVG(CAST(query_response_time_seconds AS DOUBLE))
      comment: "Average HIE query response time — performance KPI for exchange network and partner endpoints."
    - name: "Avg Match Confidence Score"
      expr: AVG(CAST(match_confidence_score AS DOUBLE))
      comment: "Average patient-match confidence — data-quality KPI for identity resolution in exchange."
    - name: "Total Documents Returned"
      expr: SUM(CAST(documents_returned_count AS DOUBLE))
      comment: "Total clinical documents returned via HIE — quantifies care-coordination value delivered."
    - name: "Consent Verified Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_verified = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of queries with verified consent — privacy compliance KPI for HIE governance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_patient_identity_match`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient identity matching KPIs — match scores, manual review burden, duplicate detection, and processing speed. Critical for enterprise master patient index (EMPI) data-quality governance."
  source: "`vibe_healthcare_v1`.`interoperability`.`patient_identity_match`"
  dimensions:
    - name: "match_result_status"
      expr: match_result_status
      comment: "Outcome of the identity match (matched, no-match, multiple) — core EMPI quality dimension."
    - name: "match_confidence_level"
      expr: match_confidence_level
      comment: "Confidence tier of the match — segments high vs low-confidence resolutions."
    - name: "match_method"
      expr: match_method
      comment: "Matching method used (deterministic/probabilistic) — compares algorithm effectiveness."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of identity transaction — segments match activity by use case."
    - name: "match_day"
      expr: DATE_TRUNC('DAY', match_request_timestamp)
      comment: "Day of the match request — time grain for EMPI quality trending."
  measures:
    - name: "Identity Match Volume"
      expr: COUNT(1)
      comment: "Total identity match transactions — baseline EMPI workload."
    - name: "Avg Match Score"
      expr: AVG(CAST(match_score AS DOUBLE))
      comment: "Average match score — data-quality KPI; declining scores indicate degrading demographic data."
    - name: "Manual Review Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN manual_review_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of matches requiring manual review — labor-cost and automation-opportunity KPI."
    - name: "Duplicate Detection Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN duplicate_record_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of transactions flagging duplicate records — patient-safety and data-integrity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_care_transition_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Event notification (ADT/care-transition) delivery KPIs — delivery success, acknowledgment, SLA adherence and CMS Condition of Participation compliance for e-notifications."
  source: "`vibe_healthcare_v1`.`interoperability`.`care_transition_notification`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Care-transition event type (admit, discharge, transfer) — segments notification activity."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome of the notification — central success/failure dimension."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used to deliver the notification (Direct, FHIR, HL7) — compares channel reliability."
    - name: "notification_priority"
      expr: notification_priority
      comment: "Priority of the notification — separates urgent transitions from routine."
    - name: "notification_day"
      expr: DATE_TRUNC('DAY', notification_sent_timestamp)
      comment: "Day the notification was sent — time grain for compliance trending."
  measures:
    - name: "Notification Volume"
      expr: COUNT(1)
      comment: "Total care-transition notifications sent — baseline for CMS e-notification Condition of Participation."
    - name: "Acknowledgment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of notifications acknowledged by receiver — confirms closed-loop care coordination."
    - name: "SLA Breach Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of notifications breaching delivery SLA — operational and compliance risk KPI."
    - name: "CMS Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_interoperability_compliant_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of notifications meeting CMS interoperability compliance criteria — regulatory attestation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_promoting_interoperability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Promoting Interoperability / MIPS measure performance KPIs — performance rates, met thresholds, data completeness and payment adjustment. Direct input to value-based reimbursement attestation."
  source: "`vibe_healthcare_v1`.`interoperability`.`promoting_interoperability`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "PI measure category — groups measures for objective-level scoring."
    - name: "measure_name"
      expr: measure_name
      comment: "Specific PI/MIPS measure — enables measure-level performance review."
    - name: "attestation_status"
      expr: attestation_status
      comment: "Attestation status of the measure — distinguishes submitted from pending."
    - name: "cms_program_year"
      expr: cms_program_year
      comment: "CMS program year — supports year-over-year performance comparison."
    - name: "reporting_period_end"
      expr: DATE_TRUNC('MONTH', reporting_period_end_date)
      comment: "Reporting period end month — time grain for attestation cycles."
  measures:
    - name: "Measure Record Count"
      expr: COUNT(1)
      comment: "Number of PI measure records — baseline coverage of reporting obligations."
    - name: "Avg Performance Rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across measures — headline PI scoring KPI for value-based payment."
    - name: "Performance Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN performance_met_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of measures meeting threshold — determines incentive eligibility and avoids payment penalty."
    - name: "Avg Data Completeness Pct"
      expr: AVG(CAST(data_completeness_percentage AS DOUBLE))
      comment: "Average data-completeness percentage — submission-quality KPI affecting score validity."
    - name: "Avg Payment Adjustment Pct"
      expr: AVG(CAST(payment_adjustment_percentage AS DOUBLE))
      comment: "Average payment adjustment percentage — direct financial impact of interoperability performance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_public_health_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Public health reporting KPIs — submission volume, acknowledgment/success, case counts, and PI-attestation eligibility. Used for ELR/eCR/IIS reporting compliance and public health partnership management."
  source: "`vibe_healthcare_v1`.`interoperability`.`public_health_report`"
  dimensions:
    - name: "report_type"
      expr: report_type
      comment: "Public health report type (ELR, eCR, immunization) — segments mandatory reporting streams."
    - name: "submission_status"
      expr: submission_status
      comment: "Submission outcome status — distinguishes accepted from rejected submissions."
    - name: "reporting_agency_name"
      expr: reporting_agency_name
      comment: "Receiving public health agency — analyzes reporting by jurisdiction/partner."
    - name: "submission_day"
      expr: DATE_TRUNC('DAY', submission_timestamp)
      comment: "Day of submission — time grain for reporting cadence monitoring."
  measures:
    - name: "Report Submission Volume"
      expr: COUNT(1)
      comment: "Total public health reports submitted — baseline mandated-reporting throughput."
    - name: "Total Case Count"
      expr: SUM(CAST(case_count AS DOUBLE))
      comment: "Total reportable cases transmitted — public health surveillance contribution volume."
    - name: "Submission Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN submission_status = 'ACCEPTED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of submissions accepted by the agency — reporting quality and compliance KPI."
    - name: "PI Attestation Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN attestation_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of reports eligible for PI attestation — links public health reporting to incentive program credit."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_direct_message`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct Secure Messaging KPIs — delivery success, read receipts, retries and HIPAA/Meaningful Use eligibility. Used for secure-clinical-messaging adoption and reliability management."
  source: "`vibe_healthcare_v1`.`interoperability`.`direct_message`"
  dimensions:
    - name: "message_type"
      expr: message_type
      comment: "Direct message type — segments secure messaging activity by purpose."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome of the Direct message — core success/failure dimension."
    - name: "message_priority"
      expr: message_priority
      comment: "Priority of the message — separates urgent clinical exchanges."
    - name: "workflow_status"
      expr: workflow_status
      comment: "Workflow processing status — tracks message lifecycle state."
    - name: "send_day"
      expr: DATE_TRUNC('DAY', send_timestamp)
      comment: "Day the message was sent — time grain for messaging volume trending."
  measures:
    - name: "Direct Message Volume"
      expr: COUNT(1)
      comment: "Total Direct secure messages — baseline adoption metric for clinical interoperability."
    - name: "Delivery Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_status = 'DELIVERED' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages successfully delivered — reliability KPI for HISP/trust-bundle exchange."
    - name: "Read Receipt Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN read_receipt_received = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages with confirmed read receipts — closed-loop communication assurance."
    - name: "Meaningful Use Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN meaningful_use_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of messages eligible for Meaningful Use credit — links messaging to incentive attestation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_conformance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interoperability conformance/certification testing KPIs — pass rates, critical failures and go-live readiness. Used by integration program leadership to manage partner onboarding certification risk."
  source: "`vibe_healthcare_v1`.`interoperability`.`conformance_test`"
  dimensions:
    - name: "conformance_status"
      expr: conformance_status
      comment: "Overall conformance status of the test — pass/fail/conditional grouping."
    - name: "test_scope"
      expr: test_scope
      comment: "Scope of the conformance test — segments by standard or transaction set tested."
    - name: "go_live_readiness_status"
      expr: go_live_readiness_status
      comment: "Go-live readiness assessment — gating dimension for partner activation."
    - name: "onc_certification_criteria"
      expr: onc_certification_criteria
      comment: "ONC certification criteria targeted — links testing to regulatory certification."
    - name: "test_day"
      expr: DATE_TRUNC('DAY', test_execution_timestamp)
      comment: "Day the test executed — time grain for certification program tracking."
  measures:
    - name: "Conformance Test Count"
      expr: COUNT(1)
      comment: "Total conformance tests executed — baseline certification activity."
    - name: "Avg Pass Percentage"
      expr: AVG(CAST(pass_percentage AS DOUBLE))
      comment: "Average test-case pass percentage — headline certification-readiness KPI."
    - name: "Remediation Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of tests requiring remediation — predicts onboarding delays and rework cost."
    - name: "Retest Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN retest_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of tests needing retest — cycle-time and program-efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_fhir_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR endpoint reliability and compliance KPIs — uptime, response time, request volume and CMS/ONC API compliance posture. Used for API platform health and regulatory readiness."
  source: "`vibe_healthcare_v1`.`interoperability`.`fhir_endpoint`"
  dimensions:
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of FHIR endpoint — segments patient-access vs provider vs payer endpoints."
    - name: "environment"
      expr: environment
      comment: "Deployment environment (prod, test) — isolates production reliability metrics."
    - name: "operational_status"
      expr: operational_status
      comment: "Operational status of the endpoint — distinguishes active from deprecated endpoints."
    - name: "fhir_version"
      expr: fhir_version
      comment: "FHIR version supported — tracks version adoption across endpoints."
  measures:
    - name: "Endpoint Count"
      expr: COUNT(1)
      comment: "Number of FHIR endpoints — inventory baseline for API platform governance."
    - name: "Avg Uptime Pct"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average endpoint uptime — reliability KPI for patient/provider access APIs against CMS expectations."
    - name: "Total Requests Last 30 Days"
      expr: SUM(CAST(total_requests_last_30_days AS DOUBLE))
      comment: "Total API requests over trailing 30 days — adoption and load KPI for capacity planning."
    - name: "CMS Compliance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN cms_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of endpoints flagged CMS-compliant — regulatory readiness KPI for interoperability rules."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_onboarding_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Trading-partner onboarding project KPIs — budget variance, on-time go-live, and risk posture. Used by integration program leadership to steer onboarding portfolio delivery."
  source: "`vibe_healthcare_v1`.`interoperability`.`onboarding_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project status — distinguishes active, on-hold and closed onboardings."
    - name: "project_phase"
      expr: project_phase
      comment: "Lifecycle phase of the project — tracks portfolio progress."
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface being onboarded — segments delivery effort by integration type."
    - name: "risk_level"
      expr: risk_level
      comment: "Assessed risk level — prioritizes program management attention."
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', project_initiation_date)
      comment: "Month the project initiated — time grain for portfolio intake trending."
  measures:
    - name: "Project Count"
      expr: COUNT(1)
      comment: "Number of onboarding projects — portfolio size baseline."
    - name: "Total Budget Amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted onboarding spend — financial planning input for integration program."
    - name: "Total Actual Cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual onboarding cost — paired with budget to compute portfolio cost variance."
    - name: "Certification Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of projects requiring certification — predicts onboarding complexity and timeline risk."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_cda_document`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CDA document processing and compliance metrics."
  source: "`vibe_healthcare_v1`.`interoperability`.`cda_document`"
  dimensions:
    - name: "document_status"
      expr: document_status
      comment: "Current status of the CDA document."
    - name: "document_type_name"
      expr: document_type_name
      comment: "Document type name."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date document was created."
    - name: "validation_status"
      expr: validation_status
      comment: "Validation status of the document."
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of CDA documents."
    - name: "total_document_size_bytes"
      expr: SUM(CAST(document_size_bytes AS DOUBLE))
      comment: "Sum of document sizes in bytes."
    - name: "validated_documents"
      expr: SUM(CASE WHEN validation_status = 'VALID' THEN 1 ELSE 0 END)
      comment: "Count of documents with validation status VALID."
    - name: "hipaa_compliant_documents"
      expr: SUM(CASE WHEN hipaa_compliant_flag THEN 1 ELSE 0 END)
      comment: "Count of documents marked HIPAA compliant."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_hie_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "HIE transaction volume and success metrics."
  source: "`vibe_healthcare_v1`.`interoperability`.`hie_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of HIE transaction."
    - name: "direction"
      expr: direction
      comment: "Direction of transaction (inbound/outbound)."
    - name: "source_system_name"
      expr: source_system_name
      comment: "Name of source system."
    - name: "destination_system_name"
      expr: destination_system_name
      comment: "Name of destination system."
    - name: "transaction_date"
      expr: DATE_TRUNC('day', transaction_timestamp)
      comment: "Date of transaction."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of HIE transactions."
    - name: "successful_transactions"
      expr: SUM(CASE WHEN acknowledgment_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of transactions with acknowledgment code indicating success."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`interoperability_subscription_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription notification delivery and SLA metrics."
  source: "`vibe_healthcare_v1`.`interoperability`.`subscription_notification`"
  dimensions:
    - name: "subscription_topic_id"
      expr: subscription_topic_id
      comment: "Subscription topic identifier."
    - name: "interface_channel_id"
      expr: interface_channel_id
      comment: "Interface channel used."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the notification."
    - name: "notification_sent_date"
      expr: DATE_TRUNC('day', notification_timestamp)
      comment: "Date notification was sent."
    - name: "triggering_event_type"
      expr: triggering_event_type
      comment: "Type of event that triggered the notification."
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total subscription notifications sent."
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag THEN 1 ELSE 0 END)
      comment: "Count of notifications that breached SLA."
    - name: "failed_deliveries"
      expr: SUM(CASE WHEN delivery_status = 'FAILED' THEN 1 ELSE 0 END)
      comment: "Count of notifications with delivery status FAILED."
$$;