-- Metric views for domain: interoperability | Business: Healthcare | Version: 5 | Generated on: 2026-05-21 09:24:55

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_message_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core message exchange operational metrics tracking throughput, latency, reliability, and SLA compliance across all interface channels. Essential for IT operations leadership to monitor integration health and identify degradation."
  source: "`healthcare_ecm_v1`.`interoperability`.`message_log`"
  dimensions:
    - name: "message_standard"
      expr: message_standard
      comment: "HL7v2, FHIR, CDA, X12 - the exchange standard used for the message"
    - name: "message_type"
      expr: message_type
      comment: "ADT, ORM, ORU, MDM etc. - the clinical/administrative message category"
    - name: "processing_status"
      expr: processing_status
      comment: "Current processing state of the message (delivered, failed, queued, etc.)"
    - name: "validation_status"
      expr: validation_status
      comment: "Whether the message passed structural and content validation"
    - name: "transport_protocol"
      expr: transport_protocol
      comment: "Communication protocol used (MLLP, HTTPS, SFTP, etc.)"
    - name: "message_month"
      expr: DATE_TRUNC('MONTH', message_timestamp)
      comment: "Month the message was sent/received for trend analysis"
    - name: "sla_met_flag"
      expr: CASE WHEN sla_met = TRUE THEN 'SLA Met' ELSE 'SLA Missed' END
      comment: "Whether the message met its SLA threshold"
    - name: "phi_present_flag"
      expr: CASE WHEN phi_present = TRUE THEN 'PHI Present' ELSE 'No PHI' END
      comment: "Whether the message contained protected health information"
  measures:
    - name: "total_messages"
      expr: COUNT(1)
      comment: "Total number of messages processed across all channels"
    - name: "total_payload_bytes"
      expr: SUM(CAST(payload_size_bytes AS DOUBLE))
      comment: "Total data volume exchanged in bytes - indicates integration load"
    - name: "avg_processing_latency_ms"
      expr: AVG(CAST(processing_latency_ms AS DOUBLE))
      comment: "Average time to process a message end-to-end in milliseconds"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_met = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of messages meeting SLA thresholds - key operational KPI"
    - name: "duplicate_message_count"
      expr: SUM(CASE WHEN is_duplicate = TRUE THEN 1 ELSE 0 END)
      comment: "Count of duplicate messages detected - indicates source system issues"
    - name: "failed_message_count"
      expr: SUM(CASE WHEN processing_status = 'ERROR' OR processing_status = 'FAILED' THEN 1 ELSE 0 END)
      comment: "Count of messages that failed processing - requires investigation"
    - name: "avg_payload_size_bytes"
      expr: AVG(CAST(payload_size_bytes AS DOUBLE))
      comment: "Average message size in bytes - useful for capacity planning"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_message_error`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface error analytics for identifying systemic integration failures, SLA breaches, and resolution effectiveness. Critical for integration team operational management and vendor accountability."
  source: "`healthcare_ecm_v1`.`interoperability`.`message_error`"
  dimensions:
    - name: "error_category"
      expr: error_category
      comment: "Classification of error type (validation, connectivity, transformation, etc.)"
    - name: "error_severity"
      expr: error_severity
      comment: "Severity level of the error (critical, warning, informational)"
    - name: "resolution_status"
      expr: resolution_status
      comment: "Current resolution state (open, in-progress, resolved, escalated)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for pattern analysis"
    - name: "error_month"
      expr: DATE_TRUNC('MONTH', error_timestamp)
      comment: "Month of error occurrence for trend analysis"
    - name: "sla_breach_flag"
      expr: CASE WHEN sla_breach_flag = TRUE THEN 'SLA Breached' ELSE 'Within SLA' END
      comment: "Whether the error resolution breached SLA targets"
    - name: "escalation_flag"
      expr: CASE WHEN escalation_flag = TRUE THEN 'Escalated' ELSE 'Not Escalated' END
      comment: "Whether the error required escalation"
  measures:
    - name: "total_errors"
      expr: COUNT(1)
      comment: "Total interface errors - primary volume indicator for integration health"
    - name: "critical_error_count"
      expr: SUM(CASE WHEN error_severity = 'CRITICAL' THEN 1 ELSE 0 END)
      comment: "Count of critical severity errors requiring immediate attention"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of errors that breached resolution SLA - drives vendor/team accountability"
    - name: "escalated_error_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of errors requiring escalation - indicates systemic issues"
    - name: "unresolved_error_count"
      expr: SUM(CASE WHEN resolution_status != 'RESOLVED' AND resolution_status != 'CLOSED' THEN 1 ELSE 0 END)
      comment: "Count of currently unresolved errors - operational backlog indicator"
    - name: "retry_eligible_count"
      expr: SUM(CASE WHEN retry_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of errors eligible for automated retry - automation opportunity metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_interface_downtime`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interface availability and downtime impact metrics for SLA reporting, vendor management, and infrastructure investment decisions. Directly impacts patient safety when clinical interfaces are unavailable."
  source: "`healthcare_ecm_v1`.`interoperability`.`interface_downtime`"
  dimensions:
    - name: "downtime_type"
      expr: downtime_type
      comment: "Planned maintenance vs unplanned outage classification"
    - name: "impact_severity"
      expr: impact_severity
      comment: "Business impact severity (critical, high, medium, low)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for infrastructure investment decisions"
    - name: "downtime_status"
      expr: downtime_status
      comment: "Current status of the downtime event"
    - name: "detection_method"
      expr: detection_method
      comment: "How the downtime was detected (monitoring, user report, etc.)"
    - name: "downtime_month"
      expr: DATE_TRUNC('MONTH', downtime_start_timestamp)
      comment: "Month of downtime occurrence for trend analysis"
    - name: "sla_breach_flag"
      expr: CASE WHEN sla_breach_flag = TRUE THEN 'SLA Breached' ELSE 'Within SLA' END
      comment: "Whether the downtime breached availability SLA"
  measures:
    - name: "total_downtime_events"
      expr: COUNT(1)
      comment: "Total number of downtime events - frequency indicator"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Total minutes of interface unavailability - primary availability KPI"
    - name: "avg_downtime_duration_minutes"
      expr: AVG(CAST(downtime_duration_minutes AS DOUBLE))
      comment: "Average duration per downtime event - indicates recovery effectiveness"
    - name: "total_messages_lost"
      expr: SUM(CAST(messages_lost_count AS DOUBLE))
      comment: "Total messages permanently lost during downtime - patient safety risk indicator"
    - name: "total_messages_queued"
      expr: SUM(CAST(messages_queued_count AS DOUBLE))
      comment: "Total messages queued during downtime - indicates recovery workload"
    - name: "avg_actual_uptime_pct"
      expr: AVG(CAST(actual_uptime_percentage AS DOUBLE))
      comment: "Average actual uptime percentage across downtime-affected channels"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of downtime events breaching availability SLA - drives infrastructure investment"
    - name: "unplanned_downtime_count"
      expr: SUM(CASE WHEN downtime_type = 'UNPLANNED' THEN 1 ELSE 0 END)
      comment: "Count of unplanned outages - reliability indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_hie_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Health Information Exchange transaction metrics measuring cross-organization data sharing volume, success rates, and consent compliance. Critical for CMS interoperability rule compliance and care coordination effectiveness."
  source: "`healthcare_ecm_v1`.`interoperability`.`hie_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of HIE transaction (query, push, subscription, etc.)"
    - name: "direction"
      expr: direction
      comment: "Inbound vs outbound data flow direction"
    - name: "hie_transaction_status"
      expr: hie_transaction_status
      comment: "Current status of the HIE transaction"
    - name: "message_standard"
      expr: message_standard
      comment: "Exchange standard used (FHIR, CDA, HL7v2, etc.)"
    - name: "consent_status"
      expr: consent_status
      comment: "Patient consent status for the exchange - 42 CFR Part 2 compliance"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_timestamp)
      comment: "Month of transaction for volume trending"
    - name: "security_classification"
      expr: security_classification
      comment: "Data sensitivity classification level"
  measures:
    - name: "total_hie_transactions"
      expr: COUNT(1)
      comment: "Total HIE transactions - measures cross-organization data sharing volume"
    - name: "successful_transactions"
      expr: SUM(CASE WHEN hie_transaction_status = 'COMPLETED' OR hie_transaction_status = 'ACKNOWLEDGED' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed HIE transactions"
    - name: "failed_transactions"
      expr: SUM(CASE WHEN hie_transaction_status = 'FAILED' OR hie_transaction_status = 'ERROR' THEN 1 ELSE 0 END)
      comment: "Count of failed HIE transactions requiring investigation"
    - name: "consent_blocked_transactions"
      expr: SUM(CASE WHEN consent_status = 'DENIED' OR consent_status = 'RESTRICTED' THEN 1 ELSE 0 END)
      comment: "Transactions blocked due to consent restrictions - monitors consent workflow impact"
    - name: "transformation_applied_count"
      expr: SUM(CASE WHEN transformation_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of transactions requiring data transformation - indicates mapping complexity"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_fhir_resource_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR API usage and performance metrics for monitoring Patient Access API, Provider Access API, and Payer-to-Payer API compliance per CMS Interoperability and Prior Authorization Final Rule."
  source: "`healthcare_ecm_v1`.`interoperability`.`fhir_resource_log`"
  dimensions:
    - name: "fhir_resource_type"
      expr: fhir_resource_type
      comment: "FHIR resource type accessed (Patient, Encounter, Condition, etc.)"
    - name: "operation_type"
      expr: operation_type
      comment: "FHIR operation performed (read, search, create, update, etc.)"
    - name: "http_status_code"
      expr: http_status_code
      comment: "HTTP response status code indicating success or failure type"
    - name: "access_decision"
      expr: access_decision
      comment: "Authorization decision (permit, deny) - monitors access control effectiveness"
    - name: "fhir_version_code"
      expr: fhir_version_code
      comment: "FHIR version (R4, R4B, etc.) for standards compliance tracking"
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month of API request for volume trending"
    - name: "cures_act_exception_flag"
      expr: CASE WHEN cures_act_exception_flag = TRUE THEN '21st Century Cures Exception' ELSE 'Standard Access' END
      comment: "Whether a Cures Act information blocking exception was applied"
    - name: "data_segmentation_applied"
      expr: CASE WHEN data_segmentation_applied = TRUE THEN 'Segmented' ELSE 'Full Access' END
      comment: "Whether data segmentation for privacy was applied (42 CFR Part 2)"
  measures:
    - name: "total_fhir_requests"
      expr: COUNT(1)
      comment: "Total FHIR API requests - measures API adoption and load"
    - name: "access_denied_count"
      expr: SUM(CASE WHEN access_decision = 'DENY' THEN 1 ELSE 0 END)
      comment: "Count of denied access requests - monitors security and consent enforcement"
    - name: "cures_act_exception_count"
      expr: SUM(CASE WHEN cures_act_exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of Cures Act exceptions applied - ONC compliance monitoring"
    - name: "data_segmentation_count"
      expr: SUM(CASE WHEN data_segmentation_applied = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests where data segmentation was applied - 42 CFR Part 2 compliance"
    - name: "distinct_patients_accessed"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients whose data was accessed via FHIR APIs"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_fhir_endpoint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "FHIR endpoint health and compliance metrics for monitoring CMS-mandated API availability, ONC certification status, and partner connectivity. Essential for regulatory compliance reporting."
  source: "`healthcare_ecm_v1`.`interoperability`.`fhir_endpoint`"
  dimensions:
    - name: "fhir_version"
      expr: fhir_version
      comment: "FHIR version supported by the endpoint"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the endpoint (active, degraded, offline)"
    - name: "endpoint_type"
      expr: endpoint_type
      comment: "Type of endpoint (patient access, provider directory, payer-to-payer, etc.)"
    - name: "environment"
      expr: environment
      comment: "Deployment environment (production, staging, sandbox)"
    - name: "authentication_method"
      expr: authentication_method
      comment: "Authentication method used (SMART on FHIR, OAuth2, etc.)"
    - name: "cms_compliance_flag"
      expr: CASE WHEN cms_compliance_flag = TRUE THEN 'CMS Compliant' ELSE 'Non-Compliant' END
      comment: "Whether endpoint meets CMS interoperability rule requirements"
    - name: "onc_certification_flag"
      expr: CASE WHEN onc_certification_flag = TRUE THEN 'ONC Certified' ELSE 'Not Certified' END
      comment: "Whether endpoint has ONC Health IT certification"
  measures:
    - name: "total_endpoints"
      expr: COUNT(1)
      comment: "Total FHIR endpoints managed - infrastructure scope indicator"
    - name: "active_endpoints"
      expr: SUM(CASE WHEN operational_status = 'ACTIVE' THEN 1 ELSE 0 END)
      comment: "Count of currently active endpoints"
    - name: "cms_compliant_endpoints"
      expr: SUM(CASE WHEN cms_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CMS-compliant endpoints - regulatory compliance KPI"
    - name: "avg_uptime_percentage"
      expr: AVG(CAST(uptime_percentage AS DOUBLE))
      comment: "Average uptime across all endpoints - availability KPI"
    - name: "total_requests_last_30_days"
      expr: SUM(CAST(total_requests_last_30_days AS DOUBLE))
      comment: "Total API requests across all endpoints in last 30 days - adoption metric"
    - name: "bulk_data_capable_endpoints"
      expr: SUM(CASE WHEN bulk_data_export_support_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of endpoints supporting bulk FHIR export - population health readiness"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_care_transition_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care transition notification delivery and timeliness metrics per CMS Condition of Participation requirements for patient event notifications. Directly impacts care coordination and readmission prevention."
  source: "`healthcare_ecm_v1`.`interoperability`.`care_transition_notification`"
  dimensions:
    - name: "delivery_status"
      expr: delivery_status
      comment: "Current delivery status of the notification"
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used for notification delivery (Direct, FHIR, fax, etc.)"
    - name: "message_type_code"
      expr: message_type_code
      comment: "Type of care transition event (admission, discharge, transfer)"
    - name: "notification_priority"
      expr: notification_priority
      comment: "Priority level of the notification"
    - name: "notification_month"
      expr: DATE_TRUNC('MONTH', notification_sent_timestamp)
      comment: "Month notification was sent for trend analysis"
    - name: "sla_breach_flag"
      expr: CASE WHEN sla_breach_flag = TRUE THEN 'SLA Breached' ELSE 'Within SLA' END
      comment: "Whether notification delivery breached timeliness SLA"
    - name: "cms_interoperability_compliant_flag"
      expr: CASE WHEN cms_interoperability_compliant_flag = TRUE THEN 'CMS Compliant' ELSE 'Non-Compliant' END
      comment: "Whether notification meets CMS interoperability requirements"
    - name: "patient_consent_status"
      expr: patient_consent_status
      comment: "Patient consent status for the notification"
  measures:
    - name: "total_notifications"
      expr: COUNT(1)
      comment: "Total care transition notifications sent - care coordination volume"
    - name: "delivered_notifications"
      expr: SUM(CASE WHEN delivery_status = 'DELIVERED' OR delivery_status = 'ACKNOWLEDGED' THEN 1 ELSE 0 END)
      comment: "Count of successfully delivered notifications"
    - name: "failed_notifications"
      expr: SUM(CASE WHEN delivery_status = 'FAILED' OR delivery_status = 'UNDELIVERABLE' THEN 1 ELSE 0 END)
      comment: "Count of failed notification deliveries - care coordination gap"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of notifications breaching delivery SLA - timeliness compliance"
    - name: "avg_payload_size_bytes"
      expr: AVG(CAST(payload_size_bytes AS DOUBLE))
      comment: "Average notification payload size for capacity planning"
    - name: "cms_compliant_count"
      expr: SUM(CASE WHEN cms_interoperability_compliant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of CMS-compliant notifications - regulatory compliance KPI"
    - name: "acknowledgment_received_count"
      expr: SUM(CASE WHEN acknowledgment_received_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of notifications with confirmed receipt - delivery assurance metric"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_conformance_test`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interoperability conformance testing metrics tracking go-live readiness, certification compliance, and partner onboarding quality. Essential for managing integration project risk and ONC certification."
  source: "`healthcare_ecm_v1`.`interoperability`.`conformance_test`"
  dimensions:
    - name: "conformance_status"
      expr: conformance_status
      comment: "Overall conformance test result status"
    - name: "test_result"
      expr: test_result
      comment: "Pass/fail result of the test execution"
    - name: "test_environment"
      expr: test_environment
      comment: "Environment where test was executed (integration, staging, production)"
    - name: "go_live_readiness_status"
      expr: go_live_readiness_status
      comment: "Whether the tested interface is ready for production go-live"
    - name: "test_scope"
      expr: test_scope
      comment: "Scope of testing (unit, integration, end-to-end, certification)"
    - name: "test_month"
      expr: DATE_TRUNC('MONTH', test_execution_date)
      comment: "Month of test execution for progress tracking"
    - name: "remediation_required_flag"
      expr: CASE WHEN remediation_required_flag = TRUE THEN 'Remediation Required' ELSE 'Passed' END
      comment: "Whether test failures require remediation before go-live"
  measures:
    - name: "total_test_executions"
      expr: COUNT(1)
      comment: "Total conformance tests executed - testing effort indicator"
    - name: "passed_tests"
      expr: SUM(CASE WHEN test_result = 'PASS' THEN 1 ELSE 0 END)
      comment: "Count of passed conformance tests"
    - name: "failed_tests"
      expr: SUM(CASE WHEN test_result = 'FAIL' THEN 1 ELSE 0 END)
      comment: "Count of failed conformance tests requiring remediation"
    - name: "avg_pass_percentage"
      expr: AVG(CAST(pass_percentage AS DOUBLE))
      comment: "Average pass rate across test suites - quality indicator"
    - name: "go_live_ready_count"
      expr: SUM(CASE WHEN go_live_readiness_status = 'READY' THEN 1 ELSE 0 END)
      comment: "Count of interfaces ready for production go-live"
    - name: "remediation_required_count"
      expr: SUM(CASE WHEN remediation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of tests requiring remediation - project risk indicator"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_promoting_interoperability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CMS Promoting Interoperability (formerly Meaningful Use) program performance metrics for tracking measure compliance, payment adjustments, and attestation readiness. Directly impacts Medicare reimbursement."
  source: "`healthcare_ecm_v1`.`interoperability`.`promoting_interoperability`"
  dimensions:
    - name: "measure_category"
      expr: measure_category
      comment: "PI measure category (e-Prescribing, Health Information Exchange, etc.)"
    - name: "measure_identifier"
      expr: measure_identifier
      comment: "Specific PI measure ID for detailed tracking"
    - name: "attestation_status"
      expr: attestation_status
      comment: "Current attestation status for the reporting period"
    - name: "reporting_year"
      expr: reporting_year
      comment: "CMS program year for the measure"
    - name: "reporting_entity_type"
      expr: reporting_entity_type
      comment: "Type of reporting entity (eligible clinician, eligible hospital, CAH)"
    - name: "performance_met_flag"
      expr: CASE WHEN performance_met_flag = TRUE THEN 'Met' ELSE 'Not Met' END
      comment: "Whether the performance threshold was met for the measure"
    - name: "cms_program_year"
      expr: cms_program_year
      comment: "CMS program year designation"
  measures:
    - name: "total_measures_reported"
      expr: COUNT(1)
      comment: "Total PI measures reported - program participation scope"
    - name: "measures_met"
      expr: SUM(CASE WHEN performance_met_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of measures meeting performance threshold - compliance KPI"
    - name: "avg_performance_rate"
      expr: AVG(CAST(performance_rate AS DOUBLE))
      comment: "Average performance rate across all measures - program health indicator"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_percentage AS DOUBLE))
      comment: "Average data completeness across measures - data quality indicator"
    - name: "total_payment_adjustment_impact"
      expr: AVG(CAST(payment_adjustment_percentage AS DOUBLE))
      comment: "Average payment adjustment percentage - direct revenue impact metric"
    - name: "hardship_exception_count"
      expr: SUM(CASE WHEN hardship_exception_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hardship exceptions filed - indicates program burden"
$$;

CREATE OR REPLACE VIEW `healthcare_ecm_v1`.`_metrics`.`interoperability_onboarding_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Integration partner onboarding project metrics tracking timeline adherence, budget performance, and go-live success rates. Essential for IT PMO and vendor management decisions."
  source: "`healthcare_ecm_v1`.`interoperability`.`onboarding_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project status (discovery, build, testing, live, closed)"
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the onboarding project"
    - name: "priority"
      expr: priority
      comment: "Project priority level for resource allocation"
    - name: "interface_type"
      expr: interface_type
      comment: "Type of interface being onboarded (ADT, orders, results, etc.)"
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status of the integration"
    - name: "risk_level"
      expr: risk_level
      comment: "Current risk level assessment for the project"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total onboarding projects - integration portfolio size"
    - name: "active_projects"
      expr: SUM(CASE WHEN project_status NOT IN ('CLOSED', 'CANCELLED', 'COMPLETED') THEN 1 ELSE 0 END)
      comment: "Count of currently active onboarding projects - resource demand indicator"
    - name: "total_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all onboarding projects"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across projects"
    - name: "avg_budget_variance"
      expr: AVG(CAST(actual_cost AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Average budget variance per project - financial management KPI"
    - name: "certified_projects"
      expr: SUM(CASE WHEN certification_status = 'CERTIFIED' THEN 1 ELSE 0 END)
      comment: "Count of projects achieving certification - quality milestone metric"
    - name: "high_risk_projects"
      expr: SUM(CASE WHEN risk_level = 'HIGH' OR risk_level = 'CRITICAL' THEN 1 ELSE 0 END)
      comment: "Count of high/critical risk projects requiring executive attention"
$$;