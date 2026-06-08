-- Metric views for domain: technology | Business: Education | Version: 1 | Generated on: 2026-05-06 12:16:12

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core incident management KPIs tracking resolution efficiency, SLA compliance, and business impact across IT service incidents"
  source: "`education_ecm`.`technology`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, in progress, resolved, closed)"
    - name: "severity_level"
      expr: severity_level
      comment: "Business severity classification (critical, high, medium, low)"
    - name: "incident_category"
      expr: incident_category
      comment: "Primary category of the incident for trend analysis"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation tier indicating management involvement"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the incident breached its SLA target"
    - name: "detection_method"
      expr: detection_method
      comment: "How the incident was detected (monitoring, user report, etc.)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trend analysis and prevention"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when incident was created for time-series analysis"
    - name: "created_quarter"
      expr: DATE_TRUNC('QUARTER', created_timestamp)
      comment: "Quarter when incident was created for executive reporting"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of incidents for volume tracking"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents that breached SLA targets"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents meeting SLA targets - key service quality metric"
    - name: "avg_resolution_minutes"
      expr: AVG(CAST(sla_actual_resolution_minutes AS DOUBLE))
      comment: "Average time to resolve incidents in minutes - operational efficiency KPI"
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of incidents - business cost metric"
    - name: "avg_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per incident for severity calibration"
    - name: "critical_incident_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical severity incidents requiring executive attention"
    - name: "escalated_incident_count"
      expr: SUM(CASE WHEN escalation_timestamp IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of incidents requiring escalation - process effectiveness indicator"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change management effectiveness KPIs tracking success rates, risk levels, and downtime impact for IT changes"
  source: "`education_ecm`.`technology`.`change_request`"
  dimensions:
    - name: "change_status"
      expr: change_status
      comment: "Current status of the change request"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (standard, normal, emergency)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk assessment level for the change"
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "Change Advisory Board approval status"
    - name: "implementation_outcome"
      expr: implementation_outcome
      comment: "Actual outcome of change implementation (success, failure, partial)"
    - name: "downtime_required"
      expr: downtime_required
      comment: "Whether the change required system downtime"
    - name: "priority"
      expr: priority
      comment: "Change priority level"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month when change was scheduled for capacity planning"
  measures:
    - name: "total_changes"
      expr: COUNT(1)
      comment: "Total number of change requests for volume tracking"
    - name: "successful_changes"
      expr: SUM(CASE WHEN implementation_outcome = 'Success' THEN 1 ELSE 0 END)
      comment: "Count of successfully implemented changes"
    - name: "change_success_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN implementation_outcome = 'Success' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of changes successfully implemented - key quality metric"
    - name: "failed_changes"
      expr: SUM(CASE WHEN implementation_outcome = 'Failure' THEN 1 ELSE 0 END)
      comment: "Count of failed changes requiring rollback or remediation"
    - name: "emergency_change_count"
      expr: SUM(CASE WHEN change_type = 'Emergency' THEN 1 ELSE 0 END)
      comment: "Count of emergency changes indicating process maturity"
    - name: "total_actual_downtime_minutes"
      expr: SUM(CAST(actual_downtime_minutes AS DOUBLE))
      comment: "Total actual downtime caused by changes - availability impact metric"
    - name: "avg_actual_downtime_minutes"
      expr: AVG(CAST(actual_downtime_minutes AS DOUBLE))
      comment: "Average downtime per change for planning accuracy"
    - name: "high_risk_change_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk changes requiring executive oversight"
    - name: "changes_with_downtime"
      expr: SUM(CASE WHEN downtime_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes requiring downtime for capacity planning"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_it_service_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service availability and reliability KPIs tracking outage frequency, duration, and business impact across IT services"
  source: "`education_ecm`.`technology`.`it_service_outage`"
  dimensions:
    - name: "outage_status"
      expr: outage_status
      comment: "Current status of the outage"
    - name: "severity_level"
      expr: severity_level
      comment: "Business severity of the outage"
    - name: "outage_type"
      expr: outage_type
      comment: "Type of outage (planned, unplanned)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for prevention strategies"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the outage breached availability SLA"
    - name: "vendor_involved_flag"
      expr: vendor_involved_flag
      comment: "Whether vendor was involved in resolution"
    - name: "outage_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month when outage started for trend analysis"
  measures:
    - name: "total_outages"
      expr: COUNT(1)
      comment: "Total number of service outages"
    - name: "unplanned_outage_count"
      expr: SUM(CASE WHEN outage_type = 'Unplanned' THEN 1 ELSE 0 END)
      comment: "Count of unplanned outages - reliability indicator"
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total outage duration in minutes - availability impact metric"
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average outage duration for MTTR tracking"
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of outages - business cost metric"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outages breaching availability SLA"
    - name: "availability_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outages meeting availability SLA - key service quality metric"
    - name: "critical_outage_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical outages requiring executive attention"
    - name: "vendor_related_outage_count"
      expr: SUM(CASE WHEN vendor_involved_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outages involving vendor - supplier performance indicator"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_it_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT project portfolio KPIs tracking budget performance, schedule adherence, and strategic alignment"
  source: "`education_ecm`.`technology`.`it_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the IT project"
    - name: "project_type"
      expr: project_type
      comment: "Type of IT project"
    - name: "project_phase"
      expr: project_phase
      comment: "Current phase of the project lifecycle"
    - name: "priority_level"
      expr: priority_level
      comment: "Business priority level"
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating of the project"
    - name: "strategic_alignment_category"
      expr: strategic_alignment_category
      comment: "Strategic alignment classification for portfolio management"
    - name: "project_category"
      expr: project_category
      comment: "Project category for portfolio segmentation"
    - name: "planned_start_quarter"
      expr: DATE_TRUNC('QUARTER', planned_start_date)
      comment: "Quarter when project was planned to start"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IT projects in portfolio"
    - name: "total_approved_budget"
      expr: SUM(CAST(total_approved_budget AS DOUBLE))
      comment: "Total approved budget across all projects - portfolio investment metric"
    - name: "total_budget_spent"
      expr: SUM(CAST(budget_spent_to_date AS DOUBLE))
      comment: "Total budget spent to date - burn rate tracking"
    - name: "total_budget_committed"
      expr: SUM(CAST(budget_committed AS DOUBLE))
      comment: "Total budget committed but not yet spent"
    - name: "avg_budget_utilization_rate"
      expr: ROUND(100.0 * AVG(CAST(budget_spent_to_date AS DOUBLE) / NULLIF(CAST(total_approved_budget AS DOUBLE), 0)), 2)
      comment: "Average budget utilization percentage - financial efficiency metric"
    - name: "high_risk_project_count"
      expr: SUM(CASE WHEN risk_rating = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk projects requiring executive oversight"
    - name: "active_project_count"
      expr: SUM(CASE WHEN project_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of currently active projects for capacity planning"
    - name: "completed_project_count"
      expr: SUM(CASE WHEN project_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of completed projects for delivery tracking"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_cybersecurity_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity incident KPIs tracking threat detection, response times, and data breach impact for risk management"
  source: "`education_ecm`.`technology`.`incident`"
  dimensions:
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the cybersecurity incident"
    - name: "severity_level"
      expr: severity_level
      comment: "Severity classification of the security incident"
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_timestamp)
      comment: "Month when incident was detected for trend analysis"
  measures:
    - name: "total_security_incidents"
      expr: COUNT(1)
      comment: "Total number of cybersecurity incidents"
    - name: "critical_security_incident_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical security incidents requiring immediate executive action"
    - name: "total_financial_impact"
      expr: SUM(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Total estimated financial impact of security incidents - risk cost metric"
    - name: "avg_financial_impact"
      expr: AVG(CAST(estimated_financial_impact AS DOUBLE))
      comment: "Average financial impact per security incident"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_it_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT contract and vendor management KPIs tracking spend, renewal risk, and compliance for procurement optimization"
  source: "`education_ecm`.`technology`.`it_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the IT contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of IT contract (software, hardware, services, etc.)"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether contract auto-renews"
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (monthly, annual, etc.)"
    - name: "service_level_agreement_flag"
      expr: service_level_agreement_flag
      comment: "Whether contract includes SLA"
    - name: "data_privacy_compliance_flag"
      expr: data_privacy_compliance_flag
      comment: "Whether contract meets data privacy requirements"
    - name: "contract_end_quarter"
      expr: DATE_TRUNC('QUARTER', contract_end_date)
      comment: "Quarter when contract ends for renewal planning"
  measures:
    - name: "total_contracts"
      expr: COUNT(1)
      comment: "Total number of IT contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total value of all IT contracts - portfolio investment metric"
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost across all contracts - recurring spend metric"
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value for benchmarking"
    - name: "active_contract_count"
      expr: SUM(CASE WHEN contract_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active contracts"
    - name: "auto_renewal_contract_count"
      expr: SUM(CASE WHEN auto_renewal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with auto-renewal - renewal risk indicator"
    - name: "contracts_with_sla"
      expr: SUM(CASE WHEN service_level_agreement_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts with SLA - service quality coverage metric"
    - name: "data_privacy_compliant_count"
      expr: SUM(CASE WHEN data_privacy_compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of contracts meeting data privacy requirements - compliance metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license optimization KPIs tracking utilization, compliance, and cost efficiency for license management"
  source: "`education_ecm`.`technology`.`software_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the software license"
    - name: "license_type"
      expr: license_type
      comment: "Type of software license (perpetual, subscription, etc.)"
    - name: "compliance_status"
      expr: compliance_status
      comment: "License compliance status"
    - name: "software_category"
      expr: software_category
      comment: "Category of software for portfolio analysis"
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Whether license auto-renews"
    - name: "is_open_source"
      expr: is_open_source
      comment: "Whether this is open source software"
    - name: "usage_tracking_enabled"
      expr: usage_tracking_enabled
      comment: "Whether usage tracking is enabled"
    - name: "expiration_quarter"
      expr: DATE_TRUNC('QUARTER', license_expiration_date)
      comment: "Quarter when license expires for renewal planning"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of software licenses"
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual software license cost - recurring spend metric"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value of all licenses"
    - name: "avg_annual_cost"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per license"
    - name: "non_compliant_license_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of non-compliant licenses - audit risk indicator"
    - name: "compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses in compliance - key audit metric"
    - name: "active_license_count"
      expr: SUM(CASE WHEN license_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active licenses"
    - name: "open_source_license_count"
      expr: SUM(CASE WHEN is_open_source = TRUE THEN 1 ELSE 0 END)
      comment: "Count of open source licenses for portfolio mix analysis"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_access_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access certification and compliance KPIs tracking certification completion, risk levels, and access governance effectiveness"
  source: "`education_ecm`.`technology`.`access_certification`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the access certification"
    - name: "certification_type"
      expr: certification_type
      comment: "Type of access certification"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the certification"
    - name: "compliance_framework"
      expr: compliance_framework
      comment: "Compliance framework driving the certification"
    - name: "automated_flag"
      expr: automated_flag
      comment: "Whether certification is automated"
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Whether escalation was required"
    - name: "due_quarter"
      expr: DATE_TRUNC('QUARTER', due_date)
      comment: "Quarter when certification is due"
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of access certifications"
    - name: "completed_certification_count"
      expr: SUM(CASE WHEN certification_status = 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of completed certifications"
    - name: "completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN certification_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications completed - key compliance metric"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all certifications"
    - name: "high_risk_certification_count"
      expr: SUM(CASE WHEN risk_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk certifications requiring priority attention"
    - name: "escalated_certification_count"
      expr: SUM(CASE WHEN escalation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of certifications requiring escalation - process effectiveness indicator"
    - name: "automated_certification_count"
      expr: SUM(CASE WHEN automated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of automated certifications - efficiency metric"
    - name: "automation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN automated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of certifications automated - operational efficiency KPI"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_vulnerability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability management KPIs tracking remediation effectiveness, risk exposure, and security posture across IT assets"
  source: "`education_ecm`.`technology`.`vulnerability`"
  dimensions:
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level of the vulnerability"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Current remediation status"
    - name: "business_criticality"
      expr: business_criticality
      comment: "Business criticality of affected system"
    - name: "network_exposure"
      expr: network_exposure
      comment: "Network exposure level of the vulnerability"
    - name: "data_classification_exposure"
      expr: data_classification_exposure
      comment: "Data classification level exposed by vulnerability"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of remediation"
    - name: "discovery_source"
      expr: discovery_source
      comment: "Source that discovered the vulnerability"
    - name: "discovery_month"
      expr: DATE_TRUNC('MONTH', discovery_date)
      comment: "Month when vulnerability was discovered"
  measures:
    - name: "total_vulnerabilities"
      expr: COUNT(1)
      comment: "Total number of vulnerabilities"
    - name: "critical_vulnerability_count"
      expr: SUM(CASE WHEN severity_level = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of critical vulnerabilities requiring immediate action"
    - name: "high_severity_vulnerability_count"
      expr: SUM(CASE WHEN severity_level = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high severity vulnerabilities"
    - name: "avg_cvss_score"
      expr: AVG(CAST(cvss_base_score AS DOUBLE))
      comment: "Average CVSS base score - overall risk exposure metric"
    - name: "remediated_vulnerability_count"
      expr: SUM(CASE WHEN remediation_status = 'Remediated' THEN 1 ELSE 0 END)
      comment: "Count of remediated vulnerabilities"
    - name: "remediation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN remediation_status = 'Remediated' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vulnerabilities remediated - key security effectiveness metric"
    - name: "open_vulnerability_count"
      expr: SUM(CASE WHEN remediation_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Count of open vulnerabilities - current risk exposure"
    - name: "high_criticality_exposure_count"
      expr: SUM(CASE WHEN business_criticality = 'High' THEN 1 ELSE 0 END)
      comment: "Count of vulnerabilities on high-criticality systems - business risk indicator"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT service request KPIs tracking fulfillment efficiency, customer satisfaction, and service desk performance"
  source: "`education_ecm`.`technology`.`service_request`"
  dimensions:
    - name: "service_request_status"
      expr: service_request_status
      comment: "Current status of the service request"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the request"
    - name: "request_category"
      expr: request_category
      comment: "Category of service request"
    - name: "request_subcategory"
      expr: request_subcategory
      comment: "Subcategory for detailed analysis"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether request breached SLA"
    - name: "escalated_flag"
      expr: escalated_flag
      comment: "Whether request was escalated"
    - name: "submission_channel"
      expr: submission_channel
      comment: "Channel used to submit request"
    - name: "opened_month"
      expr: DATE_TRUNC('MONTH', opened_timestamp)
      comment: "Month when request was opened"
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests"
    - name: "resolved_request_count"
      expr: SUM(CASE WHEN service_request_status = 'Resolved' THEN 1 ELSE 0 END)
      comment: "Count of resolved service requests"
    - name: "resolution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN service_request_status = 'Resolved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests resolved - service desk effectiveness metric"
    - name: "avg_actual_effort_hours"
      expr: AVG(CAST(actual_effort_hours AS DOUBLE))
      comment: "Average effort hours per request - resource planning metric"
    - name: "total_actual_effort_hours"
      expr: SUM(CAST(actual_effort_hours AS DOUBLE))
      comment: "Total effort hours across all requests"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of requests breaching SLA"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_breach_flag = FALSE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requests meeting SLA - key service quality metric"
    - name: "escalated_request_count"
      expr: SUM(CASE WHEN escalated_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated requests - first-level resolution effectiveness indicator"
    - name: "avg_customer_satisfaction_score"
      expr: AVG(CAST(customer_satisfaction_score AS DOUBLE))
      comment: "Average customer satisfaction score - service quality metric"
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`technology_it_chargeback`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT cost allocation and chargeback KPIs tracking consumption-based billing, cost recovery, and departmental IT spend"
  source: "`education_ecm`.`technology`.`it_chargeback`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the chargeback"
    - name: "chargeback_method"
      expr: chargeback_method
      comment: "Method used for chargeback calculation"
    - name: "service_category"
      expr: service_category
      comment: "Category of IT service being charged"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Whether chargeback is disputed"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the chargeback"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period for detailed tracking"
    - name: "charged_department_code"
      expr: charged_department_code
      comment: "Department being charged"
    - name: "billing_month"
      expr: DATE_TRUNC('MONTH', billing_period_start_date)
      comment: "Month of billing period"
  measures:
    - name: "total_chargebacks"
      expr: COUNT(1)
      comment: "Total number of chargeback transactions"
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total chargeback amount - IT cost recovery metric"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charge after adjustments and discounts"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount applied"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount"
    - name: "avg_charge_amount"
      expr: AVG(CAST(total_charge_amount AS DOUBLE))
      comment: "Average chargeback amount per transaction"
    - name: "disputed_chargeback_count"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of disputed chargebacks - billing accuracy indicator"
    - name: "dispute_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN dispute_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of chargebacks disputed - billing quality metric"
    - name: "paid_chargeback_count"
      expr: SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END)
      comment: "Count of paid chargebacks"
    - name: "collection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_status = 'Paid' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of chargebacks collected - cost recovery effectiveness metric"
$$;