-- Metric views for domain: technology | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_it_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT incident resolution, impact, and service quality metrics for operational steering and SLA management"
  source: "`ngo_ecm`.`technology`.`it_incident`"
  dimensions:
    - name: "incident_severity"
      expr: severity_level
      comment: "Severity classification of the incident (critical, high, medium, low)"
    - name: "incident_category"
      expr: incident_category
      comment: "Primary category of the incident for root cause analysis"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (open, in progress, resolved, closed)"
    - name: "security_incident_flag"
      expr: security_incident
      comment: "Whether the incident is classified as a security incident"
    - name: "data_breach_flag"
      expr: data_breach
      comment: "Whether the incident involved a data breach requiring notification"
    - name: "affected_country_office"
      expr: affected_country_office
      comment: "Country office impacted by the incident"
    - name: "affected_program"
      expr: affected_program
      comment: "Program or service line affected by the incident"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for trend analysis and prevention"
    - name: "escalation_flag"
      expr: escalated
      comment: "Whether the incident was escalated to higher support tiers"
    - name: "detected_month"
      expr: DATE_TRUNC('MONTH', detected_timestamp)
      comment: "Month when the incident was first detected"
    - name: "resolved_month"
      expr: DATE_TRUNC('MONTH', resolved_timestamp)
      comment: "Month when the incident was resolved"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of IT incidents reported"
    - name: "total_downtime_minutes"
      expr: SUM(CAST(downtime_minutes AS DOUBLE))
      comment: "Total system downtime in minutes caused by incidents"
    - name: "avg_downtime_per_incident"
      expr: AVG(CAST(downtime_minutes AS DOUBLE))
      comment: "Average downtime per incident in minutes"
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Total financial impact of incidents in USD"
    - name: "avg_financial_impact_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per incident in USD"
    - name: "total_impacted_users"
      expr: SUM(CAST(impacted_user_count AS DOUBLE))
      comment: "Total number of users impacted across all incidents"
    - name: "avg_impacted_users_per_incident"
      expr: AVG(CAST(impacted_user_count AS DOUBLE))
      comment: "Average number of users impacted per incident"
    - name: "avg_mttr_minutes"
      expr: AVG(CAST(mean_time_to_resolution_minutes AS DOUBLE))
      comment: "Average mean time to resolution across incidents in minutes"
    - name: "security_incidents_count"
      expr: SUM(CASE WHEN security_incident = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents classified as security incidents"
    - name: "data_breach_incidents_count"
      expr: SUM(CASE WHEN data_breach = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents involving data breaches"
    - name: "escalated_incidents_count"
      expr: SUM(CASE WHEN escalated = TRUE THEN 1 ELSE 0 END)
      comment: "Count of incidents that required escalation"
    - name: "avg_user_satisfaction_rating"
      expr: AVG(CAST(user_satisfaction_rating AS DOUBLE))
      comment: "Average user satisfaction rating for resolved incidents"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_it_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT project portfolio performance, budget variance, and delivery health metrics for strategic investment decisions"
  source: "`ngo_ecm`.`technology`.`it_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the IT project (planning, in progress, completed, cancelled)"
    - name: "project_category"
      expr: project_category
      comment: "Category classification of the project"
    - name: "project_type"
      expr: project_type
      comment: "Type of IT project (infrastructure, application, integration, etc.)"
    - name: "health_status"
      expr: health_status
      comment: "Overall health status of the project (green, amber, red)"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment for the project"
    - name: "priority"
      expr: priority
      comment: "Priority level of the project for resource allocation"
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Project delivery methodology (agile, waterfall, hybrid)"
    - name: "sponsoring_domain"
      expr: sponsoring_domain
      comment: "Business domain sponsoring the project"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data classification level for compliance and security"
    - name: "planned_start_quarter"
      expr: DATE_TRUNC('QUARTER', planned_start_date)
      comment: "Planned start quarter for portfolio planning"
    - name: "planned_end_quarter"
      expr: DATE_TRUNC('QUARTER', planned_end_date)
      comment: "Planned end quarter for portfolio planning"
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IT projects in the portfolio"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all projects"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all projects"
    - name: "avg_budget_per_project"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per project"
    - name: "avg_actual_cost_per_project"
      expr: AVG(CAST(actual_cost AS DOUBLE))
      comment: "Average actual cost per project"
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across active projects"
    - name: "total_user_count"
      expr: SUM(CAST(user_count AS DOUBLE))
      comment: "Total number of users impacted by all projects"
    - name: "total_integration_count"
      expr: SUM(CAST(integration_count AS DOUBLE))
      comment: "Total number of system integrations across all projects"
    - name: "at_risk_projects_count"
      expr: SUM(CASE WHEN health_status IN ('amber', 'red') THEN 1 ELSE 0 END)
      comment: "Count of projects with amber or red health status requiring intervention"
    - name: "high_priority_projects_count"
      expr: SUM(CASE WHEN priority = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-priority projects for resource allocation"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service desk performance, SLA compliance, and user satisfaction metrics for operational excellence"
  source: "`ngo_ecm`.`technology`.`service_request`"
  dimensions:
    - name: "request_status"
      expr: service_request_status
      comment: "Current status of the service request"
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (access, hardware, software, support)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the service request"
    - name: "resolution_category"
      expr: resolution_category
      comment: "Category of resolution applied"
    - name: "assignment_group"
      expr: assignment_group
      comment: "Support team assigned to the request"
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the request breached SLA targets"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the request was escalated"
    - name: "submitted_month"
      expr: DATE_TRUNC('MONTH', submitted_timestamp)
      comment: "Month when the service request was submitted"
    - name: "resolved_month"
      expr: DATE_TRUNC('MONTH', resolved_timestamp)
      comment: "Month when the service request was resolved"
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests submitted"
    - name: "avg_time_spent_hours"
      expr: AVG(CAST(time_spent_hours AS DOUBLE))
      comment: "Average time spent resolving service requests in hours"
    - name: "total_time_spent_hours"
      expr: SUM(CAST(time_spent_hours AS DOUBLE))
      comment: "Total time spent on service requests in hours"
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target in hours across service requests"
    - name: "sla_breach_count"
      expr: SUM(CASE WHEN sla_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service requests that breached SLA"
    - name: "escalated_requests_count"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of service requests that were escalated"
    - name: "avg_requester_satisfaction_rating"
      expr: AVG(CAST(requester_satisfaction_rating AS DOUBLE))
      comment: "Average requester satisfaction rating for resolved requests"
    - name: "avg_reopened_count"
      expr: AVG(CAST(reopened_count AS DOUBLE))
      comment: "Average number of times requests were reopened"
    - name: "total_reopened_requests"
      expr: SUM(CAST(reopened_count AS DOUBLE))
      comment: "Total count of request reopenings indicating quality issues"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license utilization, cost optimization, and compliance metrics for IT spend management"
  source: "`ngo_ecm`.`technology`.`software_license`"
  dimensions:
    - name: "license_status"
      expr: license_status
      comment: "Current status of the software license"
    - name: "license_type"
      expr: license_type
      comment: "Type of software license (perpetual, subscription, concurrent)"
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (cloud, on-premise, hybrid)"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Software vendor name for spend analysis"
    - name: "product_name"
      expr: product_name
      comment: "Software product name"
    - name: "compliance_status"
      expr: compliance_status
      comment: "License compliance status (compliant, at risk, non-compliant)"
    - name: "support_tier"
      expr: support_tier
      comment: "Support tier level for the license"
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Primary business domain using the license"
    - name: "is_mission_critical"
      expr: is_mission_critical
      comment: "Whether the software is classified as mission-critical"
    - name: "auto_renewal_enabled"
      expr: auto_renewal_enabled
      comment: "Whether auto-renewal is enabled for the license"
    - name: "expiration_quarter"
      expr: DATE_TRUNC('QUARTER', expiration_date)
      comment: "Quarter when the license expires for renewal planning"
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of software licenses managed"
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost of all software licenses"
    - name: "avg_annual_cost_per_license"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per software license"
    - name: "total_seats_purchased"
      expr: SUM(CAST(total_seats_purchased AS DOUBLE))
      comment: "Total number of license seats purchased"
    - name: "total_seats_consumed"
      expr: SUM(CAST(seats_consumed AS DOUBLE))
      comment: "Total number of license seats actively consumed"
    - name: "total_seats_available"
      expr: SUM(CAST(seats_available AS DOUBLE))
      comment: "Total number of unused license seats available"
    - name: "avg_cost_per_seat"
      expr: AVG(CAST(cost_per_seat AS DOUBLE))
      comment: "Average cost per license seat"
    - name: "mission_critical_licenses_count"
      expr: SUM(CASE WHEN is_mission_critical = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mission-critical software licenses requiring priority management"
    - name: "non_compliant_licenses_count"
      expr: SUM(CASE WHEN compliance_status = 'non-compliant' THEN 1 ELSE 0 END)
      comment: "Count of licenses in non-compliant status requiring remediation"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_system_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "System platform portfolio cost, coverage, and lifecycle metrics for technology investment decisions"
  source: "`ngo_ecm`.`technology`.`system_platform`"
  dimensions:
    - name: "platform_status"
      expr: platform_status
      comment: "Current operational status of the system platform"
    - name: "platform_type"
      expr: platform_type
      comment: "Type of system platform (ERP, CRM, HCM, custom, etc.)"
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (SaaS, PaaS, IaaS, on-premise)"
    - name: "hosting_environment"
      expr: hosting_environment
      comment: "Hosting environment (cloud, on-premise, hybrid)"
    - name: "vendor_name"
      expr: vendor_name
      comment: "Vendor providing the system platform"
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Primary business domain served by the platform"
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data classification level for security and compliance"
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "Disaster recovery tier classification"
    - name: "support_tier"
      expr: support_tier
      comment: "Support tier level for the platform"
    - name: "is_mobile_enabled"
      expr: is_mobile_enabled
      comment: "Whether the platform supports mobile access"
    - name: "is_offline_capable"
      expr: is_offline_capable
      comment: "Whether the platform supports offline operation"
    - name: "go_live_quarter"
      expr: DATE_TRUNC('QUARTER', go_live_date)
      comment: "Quarter when the platform went live"
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of system platforms in the portfolio"
    - name: "total_annual_cost"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost of all system platforms"
    - name: "avg_annual_cost_per_platform"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per system platform"
    - name: "total_user_count"
      expr: SUM(CAST(user_count AS DOUBLE))
      comment: "Total number of users across all platforms"
    - name: "avg_user_count_per_platform"
      expr: AVG(CAST(user_count AS DOUBLE))
      comment: "Average number of users per platform"
    - name: "total_integration_count"
      expr: SUM(CAST(integration_count AS DOUBLE))
      comment: "Total number of integrations across all platforms"
    - name: "avg_integration_count_per_platform"
      expr: AVG(CAST(integration_count AS DOUBLE))
      comment: "Average number of integrations per platform"
    - name: "mobile_enabled_platforms_count"
      expr: SUM(CASE WHEN is_mobile_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with mobile capability"
    - name: "offline_capable_platforms_count"
      expr: SUM(CASE WHEN is_offline_capable = TRUE THEN 1 ELSE 0 END)
      comment: "Count of platforms with offline capability for field operations"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_user_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User account security posture, access governance, and compliance metrics for identity and access management"
  source: "`ngo_ecm`.`technology`.`user_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the user account"
    - name: "account_type"
      expr: account_type
      comment: "Type of user account (employee, contractor, service, partner)"
    - name: "access_level"
      expr: access_level
      comment: "Access level granted to the account"
    - name: "privileged_account_flag"
      expr: privileged_account_flag
      comment: "Whether the account has privileged access rights"
    - name: "mfa_enrolled_flag"
      expr: mfa_enrolled_flag
      comment: "Whether multi-factor authentication is enrolled"
    - name: "beneficiary_data_access_flag"
      expr: beneficiary_data_access_flag
      comment: "Whether the account has access to beneficiary data"
    - name: "donor_data_access_flag"
      expr: donor_data_access_flag
      comment: "Whether the account has access to donor data"
    - name: "financial_system_access_flag"
      expr: financial_system_access_flag
      comment: "Whether the account has access to financial systems"
    - name: "remote_access_enabled_flag"
      expr: remote_access_enabled_flag
      comment: "Whether remote access is enabled for the account"
    - name: "field_access_flag"
      expr: field_access_flag
      comment: "Whether the account has field location access"
    - name: "account_locked_flag"
      expr: account_locked_flag
      comment: "Whether the account is currently locked"
    - name: "activation_month"
      expr: DATE_TRUNC('MONTH', activation_date)
      comment: "Month when the account was activated"
  measures:
    - name: "total_user_accounts"
      expr: COUNT(1)
      comment: "Total number of user accounts provisioned"
    - name: "active_accounts_count"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active user accounts"
    - name: "privileged_accounts_count"
      expr: SUM(CASE WHEN privileged_account_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of privileged accounts requiring enhanced monitoring"
    - name: "mfa_enrolled_accounts_count"
      expr: SUM(CASE WHEN mfa_enrolled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with multi-factor authentication enrolled"
    - name: "beneficiary_data_access_accounts_count"
      expr: SUM(CASE WHEN beneficiary_data_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with beneficiary data access requiring safeguarding compliance"
    - name: "donor_data_access_accounts_count"
      expr: SUM(CASE WHEN donor_data_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with donor data access requiring audit compliance"
    - name: "financial_system_access_accounts_count"
      expr: SUM(CASE WHEN financial_system_access_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with financial system access requiring segregation of duties review"
    - name: "remote_access_accounts_count"
      expr: SUM(CASE WHEN remote_access_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of accounts with remote access enabled"
    - name: "locked_accounts_count"
      expr: SUM(CASE WHEN account_locked_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of locked accounts requiring investigation or unlock"
    - name: "avg_failed_login_attempts"
      expr: AVG(CAST(failed_login_attempts AS DOUBLE))
      comment: "Average failed login attempts per account indicating potential security issues"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_security_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Security assessment findings, risk exposure, and remediation progress metrics for cybersecurity governance"
  source: "`ngo_ecm`.`technology`.`security_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the security assessment"
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of security assessment (penetration test, vulnerability scan, audit, etc.)"
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating from the assessment"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status resulting from the assessment"
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation efforts for identified findings"
    - name: "conducting_entity_type"
      expr: conducting_entity_type
      comment: "Type of entity conducting the assessment (internal, external, third-party)"
    - name: "beneficiary_data_at_risk"
      expr: beneficiary_data_at_risk
      comment: "Whether beneficiary data was identified as at risk"
    - name: "donor_reporting_required"
      expr: donor_reporting_required
      comment: "Whether donor reporting is required for the findings"
    - name: "assessment_quarter"
      expr: DATE_TRUNC('QUARTER', assessment_date)
      comment: "Quarter when the assessment was conducted"
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of security assessments conducted"
    - name: "total_critical_findings"
      expr: SUM(CAST(critical_findings_count AS DOUBLE))
      comment: "Total number of critical security findings requiring immediate action"
    - name: "total_high_findings"
      expr: SUM(CAST(high_findings_count AS DOUBLE))
      comment: "Total number of high-severity security findings"
    - name: "total_medium_findings"
      expr: SUM(CAST(medium_findings_count AS DOUBLE))
      comment: "Total number of medium-severity security findings"
    - name: "total_low_findings"
      expr: SUM(CAST(low_findings_count AS DOUBLE))
      comment: "Total number of low-severity security findings"
    - name: "total_findings"
      expr: SUM(CAST(total_findings_count AS DOUBLE))
      comment: "Total number of security findings across all assessments"
    - name: "avg_critical_findings_per_assessment"
      expr: AVG(CAST(critical_findings_count AS DOUBLE))
      comment: "Average number of critical findings per assessment"
    - name: "total_assessment_cost"
      expr: SUM(CAST(assessment_cost AS DOUBLE))
      comment: "Total cost of security assessments"
    - name: "avg_assessment_cost"
      expr: AVG(CAST(assessment_cost AS DOUBLE))
      comment: "Average cost per security assessment"
    - name: "beneficiary_data_at_risk_assessments_count"
      expr: SUM(CASE WHEN beneficiary_data_at_risk = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments identifying beneficiary data at risk requiring safeguarding response"
    - name: "donor_reporting_required_assessments_count"
      expr: SUM(CASE WHEN donor_reporting_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of assessments requiring donor notification and reporting"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Change management success rate, risk mitigation, and CAB governance metrics for IT change control"
  source: "`ngo_ecm`.`technology`.`change_request`"
  dimensions:
    - name: "change_status"
      expr: change_request_status
      comment: "Current status of the change request"
    - name: "change_type"
      expr: change_type
      comment: "Type of change (standard, normal, emergency)"
    - name: "change_category"
      expr: change_category
      comment: "Category of the change request"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment for the change"
    - name: "priority"
      expr: priority
      comment: "Priority level of the change request"
    - name: "cab_approval_required"
      expr: cab_approval_required
      comment: "Whether CAB approval is required for the change"
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "CAB approval status for the change"
    - name: "downtime_required"
      expr: downtime_required
      comment: "Whether the change requires system downtime"
    - name: "implementation_outcome"
      expr: implementation_outcome
      comment: "Outcome of the change implementation (success, partial, failed)"
    - name: "post_implementation_review_completed"
      expr: post_implementation_review_completed
      comment: "Whether post-implementation review was completed"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_timestamp)
      comment: "Month when the change was scheduled"
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests submitted"
    - name: "successful_changes_count"
      expr: SUM(CASE WHEN implementation_outcome = 'success' THEN 1 ELSE 0 END)
      comment: "Count of successfully implemented changes"
    - name: "failed_changes_count"
      expr: SUM(CASE WHEN implementation_outcome = 'failed' THEN 1 ELSE 0 END)
      comment: "Count of failed change implementations requiring investigation"
    - name: "emergency_changes_count"
      expr: SUM(CASE WHEN change_type = 'emergency' THEN 1 ELSE 0 END)
      comment: "Count of emergency changes indicating potential process gaps"
    - name: "high_risk_changes_count"
      expr: SUM(CASE WHEN risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-risk changes requiring enhanced oversight"
    - name: "downtime_required_changes_count"
      expr: SUM(CASE WHEN downtime_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes requiring system downtime"
    - name: "total_estimated_downtime_minutes"
      expr: SUM(CAST(estimated_downtime_minutes AS DOUBLE))
      comment: "Total estimated downtime in minutes for all changes"
    - name: "avg_estimated_downtime_minutes"
      expr: AVG(CAST(estimated_downtime_minutes AS DOUBLE))
      comment: "Average estimated downtime per change in minutes"
    - name: "post_implementation_review_completed_count"
      expr: SUM(CASE WHEN post_implementation_review_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of changes with completed post-implementation reviews for continuous improvement"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_vulnerability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vulnerability exposure, remediation velocity, and patch compliance metrics for cybersecurity risk management"
  source: "`ngo_ecm`.`technology`.`vulnerability`"
  dimensions:
    - name: "vulnerability_status"
      expr: vulnerability_status
      comment: "Current status of the vulnerability"
    - name: "severity_rating"
      expr: severity_rating
      comment: "Severity rating of the vulnerability"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assessment for the vulnerability"
    - name: "vulnerability_type"
      expr: vulnerability_type
      comment: "Type of vulnerability identified"
    - name: "discovery_method"
      expr: discovery_method
      comment: "Method by which the vulnerability was discovered"
    - name: "exploitability_status"
      expr: exploitability_status
      comment: "Whether the vulnerability is actively exploited in the wild"
    - name: "patch_available"
      expr: patch_available
      comment: "Whether a patch is available for the vulnerability"
    - name: "workaround_available"
      expr: workaround_available
      comment: "Whether a workaround is available for the vulnerability"
    - name: "affected_data_classification"
      expr: affected_data_classification
      comment: "Data classification level of affected systems"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the vulnerability remediation"
    - name: "discovery_quarter"
      expr: DATE_TRUNC('QUARTER', discovery_date)
      comment: "Quarter when the vulnerability was discovered"
  measures:
    - name: "total_vulnerabilities"
      expr: COUNT(1)
      comment: "Total number of vulnerabilities identified"
    - name: "critical_vulnerabilities_count"
      expr: SUM(CASE WHEN severity_rating = 'critical' THEN 1 ELSE 0 END)
      comment: "Count of critical vulnerabilities requiring immediate remediation"
    - name: "high_severity_vulnerabilities_count"
      expr: SUM(CASE WHEN severity_rating = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-severity vulnerabilities"
    - name: "actively_exploited_vulnerabilities_count"
      expr: SUM(CASE WHEN exploitability_status = 'actively_exploited' THEN 1 ELSE 0 END)
      comment: "Count of vulnerabilities actively exploited in the wild requiring urgent action"
    - name: "avg_cvss_score"
      expr: AVG(CAST(cvss_score AS DOUBLE))
      comment: "Average CVSS score across all vulnerabilities"
    - name: "patch_available_vulnerabilities_count"
      expr: SUM(CASE WHEN patch_available = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vulnerabilities with patches available for deployment"
    - name: "no_patch_available_vulnerabilities_count"
      expr: SUM(CASE WHEN patch_available = FALSE THEN 1 ELSE 0 END)
      comment: "Count of vulnerabilities without patches requiring workaround or mitigation"
    - name: "remediated_vulnerabilities_count"
      expr: SUM(CASE WHEN vulnerability_status = 'remediated' THEN 1 ELSE 0 END)
      comment: "Count of successfully remediated vulnerabilities"
    - name: "verified_remediation_count"
      expr: SUM(CASE WHEN verification_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Count of vulnerabilities with verified remediation"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`technology_it_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset lifecycle, depreciation, and warranty management metrics for capital planning and asset optimization"
  source: "`ngo_ecm`.`technology`.`it_asset`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "Category of the IT asset"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of IT asset (laptop, server, network device, etc.)"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the asset"
    - name: "asset_condition"
      expr: asset_condition
      comment: "Physical condition of the asset"
    - name: "assigned_location_type"
      expr: assigned_location_type
      comment: "Type of location where the asset is assigned"
    - name: "assigned_country_code"
      expr: assigned_country_code
      comment: "Country code where the asset is deployed"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the IT asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset"
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage for the asset"
    - name: "procurement_quarter"
      expr: DATE_TRUNC('QUARTER', procurement_date)
      comment: "Quarter when the asset was procured"
  measures:
    - name: "total_it_assets"
      expr: COUNT(1)
      comment: "Total number of IT assets under management"
    - name: "total_procurement_cost"
      expr: SUM(CAST(procurement_cost AS DOUBLE))
      comment: "Total procurement cost of all IT assets"
    - name: "avg_procurement_cost_per_asset"
      expr: AVG(CAST(procurement_cost AS DOUBLE))
      comment: "Average procurement cost per IT asset"
    - name: "total_salvage_value"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total salvage value of all IT assets"
    - name: "avg_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life in years across IT assets"
    - name: "active_assets_count"
      expr: SUM(CASE WHEN lifecycle_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active IT assets in production use"
    - name: "retired_assets_count"
      expr: SUM(CASE WHEN lifecycle_status = 'retired' THEN 1 ELSE 0 END)
      comment: "Count of retired IT assets"
    - name: "end_of_life_assets_count"
      expr: SUM(CASE WHEN lifecycle_status = 'end_of_life' THEN 1 ELSE 0 END)
      comment: "Count of end-of-life assets requiring replacement planning"
$$;