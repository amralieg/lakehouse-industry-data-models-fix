-- Metric views for domain: technology | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational IT incident management KPIs for the NGO technology domain. Tracks incident volume, financial impact, breach exposure, and resolution quality. Relevant to SAP S/4HANA (VISION), eTools, DHIS2, Kobo Toolbox, and Primero environments. Supports donor audit requirements and cybersecurity governance reporting. PII note: reported_by and assigned_to are staff identifiers — apply pii_staff masking policy in Unity Catalog."
  source: "`vibe_ngo_v1`.`technology`.`it_incident`"
  dimensions:
    - name: "incident_severity_level"
      expr: severity_level
      comment: "Severity classification (Critical/High/Medium/Low) for slicing incident KPIs by impact tier."
    - name: "incident_category"
      expr: incident_category
      comment: "Functional category of the incident (e.g. Network, Application, Security) for trend analysis."
    - name: "incident_status"
      expr: incident_status
      comment: "Current lifecycle status of the incident (Open, In Progress, Resolved, Closed)."
    - name: "is_security_incident"
      expr: security_incident
      comment: "Boolean flag indicating whether the incident is classified as a security event, enabling security-specific dashboards."
    - name: "is_data_breach"
      expr: data_breach
      comment: "Boolean flag for data breach incidents — critical for donor audit and regulatory breach-notification tracking."
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification to support problem management and preventive action prioritization."
    - name: "escalation_level"
      expr: escalation_level
      comment: "Escalation tier reached during incident lifecycle, used to assess support capacity and SLA adherence."
    - name: "incident_reported_month"
      expr: DATE_TRUNC('month', reported_timestamp)
      comment: "Month the incident was reported, enabling trend analysis over time."
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of IT incidents recorded. Baseline volume KPI for capacity planning and trend monitoring."
    - name: "total_security_incidents"
      expr: COUNT(CASE WHEN security_incident = TRUE THEN 1 END)
      comment: "Count of incidents classified as security events. Directly informs cybersecurity posture and donor audit readiness."
    - name: "total_data_breach_incidents"
      expr: COUNT(CASE WHEN data_breach = TRUE THEN 1 END)
      comment: "Count of confirmed data breach incidents. Critical for regulatory breach-notification obligations and beneficiary data protection governance."
    - name: "total_financial_impact_usd"
      expr: SUM(CAST(financial_impact_usd AS DOUBLE))
      comment: "Aggregate financial impact of all incidents in USD. Informs risk quantification, insurance, and budget reserve decisions."
    - name: "avg_financial_impact_per_incident_usd"
      expr: AVG(CAST(financial_impact_usd AS DOUBLE))
      comment: "Average financial impact per incident. Used to benchmark incident cost and prioritize prevention investments."
    - name: "breach_notification_required_count"
      expr: COUNT(CASE WHEN breach_notification_required = TRUE THEN 1 END)
      comment: "Number of incidents requiring formal breach notification. Tracks regulatory compliance exposure under GDPR, donor data agreements, and humanitarian data protection standards."
    - name: "escalated_incident_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalated = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of incidents that were escalated. High rates signal support capacity gaps or SLA failures requiring leadership intervention."
    - name: "open_incident_count"
      expr: COUNT(CASE WHEN incident_status NOT IN ('Closed', 'Resolved') THEN 1 END)
      comment: "Count of incidents not yet resolved or closed. Operational backlog KPI for IT service management steering."
    - name: "workaround_applied_count"
      expr: COUNT(CASE WHEN workaround_applied = TRUE THEN 1 END)
      comment: "Number of incidents resolved via workaround rather than permanent fix. Indicates technical debt and problem management backlog."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_vulnerability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity vulnerability management KPIs for the NGO technology domain. Tracks vulnerability exposure, remediation velocity, and risk posture across IT assets and platforms. Critical for donor cybersecurity audits, GDPR/data-protection compliance, and protection of beneficiary data in systems such as Primero, DHIS2, and Kobo Toolbox. PII note: reported_by and verified_by are staff identifiers — apply pii_staff masking policy."
  source: "`vibe_ngo_v1`.`technology`.`vulnerability`"
  dimensions:
    - name: "vulnerability_severity_rating"
      expr: severity_rating
      comment: "Severity classification (Critical/High/Medium/Low/Informational) for risk-tiered vulnerability reporting."
    - name: "vulnerability_risk_level"
      expr: risk_level
      comment: "Overall risk level assigned to the vulnerability, used for prioritization and executive risk dashboards."
    - name: "vulnerability_type"
      expr: vulnerability_type
      comment: "Type of vulnerability (e.g. SQL Injection, Misconfiguration, Unpatched Software) for root-cause trend analysis."
    - name: "vulnerability_status"
      expr: vulnerability_status
      comment: "Current remediation lifecycle status (Open, In Remediation, Remediated, Accepted Risk)."
    - name: "patch_available_flag"
      expr: patch_available
      comment: "Whether a vendor patch is available, enabling prioritization of patchable vs. unmitigated vulnerabilities."
    - name: "affected_data_classification"
      expr: affected_data_classification
      comment: "Data classification level of assets affected (e.g. Confidential-Beneficiary, PII-Staff). Supports data protection impact assessment."
    - name: "discovery_month"
      expr: DATE_TRUNC('month', discovery_date)
      comment: "Month the vulnerability was discovered, enabling trend analysis of new vulnerability intake."
    - name: "exploitability_status"
      expr: exploitability_status
      comment: "Whether the vulnerability is actively exploitable, used to prioritize emergency remediation."
  measures:
    - name: "total_open_vulnerabilities"
      expr: COUNT(CASE WHEN vulnerability_status NOT IN ('Remediated', 'Closed', 'Accepted Risk') THEN 1 END)
      comment: "Total count of unresolved vulnerabilities. Primary cybersecurity posture KPI for executive and donor reporting."
    - name: "critical_high_vulnerability_count"
      expr: COUNT(CASE WHEN severity_rating IN ('Critical', 'High') THEN 1 END)
      comment: "Count of Critical and High severity vulnerabilities. Directly informs emergency patching prioritization and risk escalation decisions."
    - name: "avg_cvss_score"
      expr: AVG(CAST(cvss_score AS DOUBLE))
      comment: "Average CVSS score across all vulnerabilities. Provides a normalized risk severity benchmark for portfolio-level risk management."
    - name: "max_cvss_score"
      expr: MAX(cvss_score)
      comment: "Maximum CVSS score in scope. Identifies the most severe vulnerability present — a key executive risk indicator."
    - name: "patchable_open_vulnerability_count"
      expr: COUNT(CASE WHEN patch_available = TRUE AND vulnerability_status NOT IN ('Remediated', 'Closed') THEN 1 END)
      comment: "Count of open vulnerabilities with an available patch. Measures actionable remediation backlog — high counts indicate patch management failures."
    - name: "remediation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vulnerability_status IN ('Remediated', 'Closed') THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of all vulnerabilities that have been remediated. Core KPI for cybersecurity program effectiveness and donor audit compliance."
    - name: "beneficiary_data_at_risk_vulnerability_count"
      expr: COUNT(CASE WHEN affected_data_classification LIKE '%Beneficiary%' OR affected_data_classification LIKE '%PII%' THEN 1 END)
      comment: "Count of vulnerabilities affecting beneficiary or PII-classified data assets. Highest-priority humanitarian data protection metric — triggers mandatory escalation under most donor data agreements."
    - name: "workaround_available_count"
      expr: COUNT(CASE WHEN workaround_available = TRUE AND vulnerability_status NOT IN ('Remediated', 'Closed') THEN 1 END)
      comment: "Open vulnerabilities with a documented workaround. Indicates interim risk mitigation coverage while permanent fixes are pending."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT asset lifecycle and financial KPIs for the NGO technology domain. Tracks asset inventory value, procurement spend, depreciation exposure, and lifecycle health. Supports donor asset-tracking requirements, grant-funded equipment accountability, and field-office asset management across country operations. Relevant to SAP S/4HANA fixed-asset modules and NGO asset registers."
  source: "`vibe_ngo_v1`.`technology`.`it_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of IT asset (Laptop, Server, Network Equipment, Mobile Device, etc.) for category-level analysis."
    - name: "asset_category"
      expr: asset_category
      comment: "Broader asset category grouping for portfolio-level reporting and budget planning."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage (Active, In Repair, Decommissioned, Disposed) for asset health monitoring."
    - name: "asset_condition"
      expr: asset_condition
      comment: "Physical condition rating of the asset, used for maintenance prioritization and replacement planning."
    - name: "assigned_location_type"
      expr: assigned_location_type
      comment: "Type of location where asset is deployed (Country Office, Field Site, HQ) for geographic distribution analysis."
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied (Straight-Line, Declining Balance) — relevant for IPSAS and US GAAP fixed-asset reporting."
    - name: "procurement_year"
      expr: DATE_TRUNC('year', procurement_date)
      comment: "Year of asset procurement for cohort-based lifecycle and spend analysis."
    - name: "warranty_status"
      expr: CASE WHEN warranty_expiry_date >= CURRENT_DATE() THEN 'In Warranty' ELSE 'Out of Warranty' END
      comment: "Derived warranty status indicating whether the asset is currently covered, supporting maintenance cost forecasting."
  measures:
    - name: "total_assets"
      expr: COUNT(1)
      comment: "Total number of IT assets in the register. Baseline inventory KPI for asset management governance."
    - name: "total_procurement_cost_usd"
      expr: SUM(CAST(procurement_cost AS DOUBLE))
      comment: "Total procurement cost of all IT assets in USD. Key capital expenditure KPI for budget planning and donor asset accountability."
    - name: "avg_procurement_cost_usd"
      expr: AVG(CAST(procurement_cost AS DOUBLE))
      comment: "Average procurement cost per asset. Benchmarks unit cost for procurement efficiency and vendor negotiation."
    - name: "total_salvage_value_usd"
      expr: SUM(CAST(salvage_value AS DOUBLE))
      comment: "Total estimated salvage value of all assets. Informs disposal planning and residual value recovery decisions."
    - name: "net_asset_book_value_usd"
      expr: SUM(CAST(procurement_cost AS DOUBLE) - CAST(salvage_value AS DOUBLE))
      comment: "Approximate net book value (procurement cost minus salvage value) across the asset portfolio. Supports IPSAS and US GAAP fixed-asset balance sheet reporting."
    - name: "active_asset_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of assets in active service. Operational fleet size KPI for capacity and refresh planning."
    - name: "out_of_warranty_asset_count"
      expr: COUNT(CASE WHEN warranty_expiry_date < CURRENT_DATE() AND lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of active assets no longer under warranty. Drives maintenance budget forecasting and replacement prioritization."
    - name: "assets_due_for_disposal_count"
      expr: COUNT(CASE WHEN lifecycle_status IN ('Decommissioned', 'Disposed') THEN 1 END)
      comment: "Count of assets at end-of-life. Supports secure disposal planning and donor grant closeout asset reporting."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_software_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Software license portfolio KPIs for the NGO technology domain. Tracks license spend, utilization, compliance posture, and renewal risk. Supports cost optimization, donor-funded software accountability, and compliance with software audit requirements. Relevant to SAP, Salesforce, Microsoft, and humanitarian-specific platforms (DHIS2, Kobo, Primero)."
  source: "`vibe_ngo_v1`.`technology`.`software_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "License model (Perpetual, Subscription, SaaS, Open Source) for spend and risk categorization."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (Active, Expired, Pending Renewal, Cancelled) for compliance monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "License compliance state (Compliant, Over-deployed, Under-utilized) — critical for audit risk management."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (Cloud, On-Premise, Hybrid) for infrastructure cost allocation."
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Business domain the license primarily serves (Finance, MEL, Field, HR) for cross-domain cost allocation."
    - name: "is_mission_critical"
      expr: is_mission_critical
      comment: "Flag indicating mission-critical systems — used to prioritize renewal and continuity planning."
    - name: "renewal_quarter"
      expr: DATE_TRUNC('quarter', renewal_date)
      comment: "Quarter in which the license is due for renewal, enabling proactive renewal pipeline management."
  measures:
    - name: "total_annual_license_cost_usd"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual software license spend in USD. Primary cost KPI for technology budget management and donor cost allocation."
    - name: "avg_cost_per_seat_usd"
      expr: AVG(CAST(cost_per_seat AS DOUBLE))
      comment: "Average cost per licensed seat. Benchmarks per-user software cost for vendor negotiation and budget planning."
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of software licenses in the portfolio. Baseline inventory for license governance."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN renewal_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) AND license_status = 'Active' THEN 1 END)
      comment: "Count of active licenses expiring within 90 days. Renewal pipeline KPI — prevents unplanned service disruptions and compliance gaps."
    - name: "non_compliant_license_count"
      expr: COUNT(CASE WHEN compliance_status NOT IN ('Compliant') THEN 1 END)
      comment: "Count of licenses in a non-compliant state. Directly informs audit risk exposure and vendor penalty avoidance."
    - name: "mission_critical_license_count"
      expr: COUNT(CASE WHEN is_mission_critical = TRUE THEN 1 END)
      comment: "Count of mission-critical software licenses. Supports business continuity planning and prioritized renewal budgeting."
    - name: "auto_renewal_enabled_count"
      expr: COUNT(CASE WHEN auto_renewal_enabled = TRUE THEN 1 END)
      comment: "Count of licenses with auto-renewal enabled. Tracks uncontrolled spend commitments requiring procurement oversight."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_system_platform`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Enterprise system platform portfolio KPIs for the NGO technology domain. Tracks platform costs, operational health, and lifecycle status across the UN-agency and INGO technology stack including SAP S/4HANA (VISION), eTools, InSight, DHIS2, Kobo Toolbox, Primero, Salesforce, and Raisers Edge NXT. Supports CIO-level portfolio governance and donor-funded system accountability."
  source: "`vibe_ngo_v1`.`technology`.`system_platform`"
  dimensions:
    - name: "platform_type"
      expr: platform_type
      comment: "Type of platform (ERP, CRM, MEL, Field Data Collection, ITSM, etc.) for portfolio segmentation."
    - name: "platform_status"
      expr: platform_status
      comment: "Operational status of the platform (Active, Decommissioned, In Implementation, Sunset) for lifecycle governance."
    - name: "deployment_type"
      expr: deployment_type
      comment: "Deployment model (Cloud SaaS, On-Premise, Hybrid) for infrastructure cost and risk categorization."
    - name: "hosting_environment"
      expr: hosting_environment
      comment: "Hosting environment (AWS, Azure, On-Premise Data Center, etc.) for cloud spend and vendor risk analysis."
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Highest data classification level hosted on the platform (Confidential-Beneficiary, PII-Staff, Public) — critical for data protection governance."
    - name: "primary_business_domain"
      expr: primary_business_domain
      comment: "Primary business domain served by the platform for cross-domain technology investment analysis."
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "DR tier assigned to the platform (Tier 1 Mission Critical, Tier 2, Tier 3) for business continuity planning."
    - name: "go_live_year"
      expr: DATE_TRUNC('year', go_live_date)
      comment: "Year the platform went live, enabling platform age and refresh cycle analysis."
  measures:
    - name: "total_platforms"
      expr: COUNT(1)
      comment: "Total number of system platforms in the portfolio. Baseline for technology landscape complexity assessment."
    - name: "total_annual_platform_cost_usd"
      expr: SUM(CAST(annual_cost AS DOUBLE))
      comment: "Total annual cost of all system platforms in USD. Primary technology investment KPI for CIO budget governance and donor cost allocation."
    - name: "avg_annual_platform_cost_usd"
      expr: AVG(CAST(annual_cost AS DOUBLE))
      comment: "Average annual cost per platform. Benchmarks platform unit economics for portfolio rationalization decisions."
    - name: "active_platform_count"
      expr: COUNT(CASE WHEN platform_status = 'Active' THEN 1 END)
      comment: "Count of currently active platforms. Operational portfolio size KPI for complexity and rationalization management."
    - name: "platforms_with_beneficiary_data_count"
      expr: COUNT(CASE WHEN data_classification_level LIKE '%Beneficiary%' OR data_classification_level LIKE '%Confidential%' THEN 1 END)
      comment: "Count of platforms hosting beneficiary or confidential data. Drives data protection impact assessment scope and donor audit coverage."
    - name: "offline_capable_platform_count"
      expr: COUNT(CASE WHEN is_offline_capable = TRUE THEN 1 END)
      comment: "Count of platforms with offline capability. Critical for field operations in low-connectivity humanitarian contexts — informs field deployment readiness."
    - name: "mobile_enabled_platform_count"
      expr: COUNT(CASE WHEN is_mobile_enabled = TRUE THEN 1 END)
      comment: "Count of mobile-enabled platforms. Supports field data collection strategy and last-mile connectivity planning."
    - name: "platforms_nearing_contract_end_count"
      expr: COUNT(CASE WHEN contract_end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 180) AND platform_status = 'Active' THEN 1 END)
      comment: "Active platforms with contracts expiring within 180 days. Procurement pipeline KPI preventing unplanned service disruptions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT project portfolio KPIs for the NGO technology domain. Tracks project delivery performance, budget variance, and strategic alignment. Supports CIO portfolio governance, donor-funded technology project accountability, and digital transformation program management. Relevant to SAP implementation projects, eTools rollouts, DHIS2 deployments, and Kobo Toolbox field data collection initiatives."
  source: "`vibe_ngo_v1`.`technology`.`it_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current project lifecycle status (Planning, In Progress, On Hold, Completed, Cancelled) for portfolio health monitoring."
    - name: "project_category"
      expr: project_category
      comment: "Category of IT project (Infrastructure, Application, Security, Data/Analytics, Digital Transformation) for investment analysis."
    - name: "project_type"
      expr: project_type
      comment: "Project type (New Implementation, Upgrade, Migration, Integration) for portfolio composition analysis."
    - name: "health_status"
      expr: health_status
      comment: "RAG health status (Green/Amber/Red) for executive portfolio dashboard and escalation triggers."
    - name: "risk_level"
      expr: risk_level
      comment: "Project risk level for prioritized oversight and resource allocation decisions."
    - name: "delivery_methodology"
      expr: delivery_methodology
      comment: "Delivery approach (Agile, Waterfall, Hybrid) for methodology effectiveness benchmarking."
    - name: "sponsoring_domain"
      expr: sponsoring_domain
      comment: "Business domain sponsoring the project (Finance, MEL, Field, HR) for cross-domain investment attribution."
    - name: "project_start_year"
      expr: DATE_TRUNC('year', planned_start_date)
      comment: "Planned start year for cohort-based portfolio analysis and annual investment planning."
  measures:
    - name: "total_projects"
      expr: COUNT(1)
      comment: "Total number of IT projects in the portfolio. Baseline for portfolio size and capacity planning."
    - name: "total_budget_amount_usd"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total approved budget across all IT projects in USD. Primary capital investment KPI for CIO budget governance."
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual spend across all IT projects in USD. Tracks realized expenditure against approved budgets."
    - name: "total_budget_variance_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(budget_amount AS DOUBLE))
      comment: "Aggregate budget variance (actual minus budget) across the portfolio. Negative = under budget; positive = over budget. Key financial control KPI."
    - name: "avg_percent_complete"
      expr: AVG(CAST(percent_complete AS DOUBLE))
      comment: "Average completion percentage across active projects. Portfolio delivery progress KPI for executive steering."
    - name: "at_risk_project_count"
      expr: COUNT(CASE WHEN health_status IN ('Red', 'Amber') THEN 1 END)
      comment: "Count of projects with Amber or Red health status. Escalation trigger KPI — drives portfolio review and intervention decisions."
    - name: "completed_project_count"
      expr: COUNT(CASE WHEN project_status = 'Completed' THEN 1 END)
      comment: "Count of successfully completed projects. Delivery throughput KPI for IT department performance evaluation."
    - name: "cancelled_project_count"
      expr: COUNT(CASE WHEN project_status = 'Cancelled' THEN 1 END)
      comment: "Count of cancelled projects. Tracks investment waste and strategic alignment failures requiring governance review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_access_provisioning`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Identity and access management (IAM) KPIs for the NGO technology domain. Tracks access provisioning lifecycle, privileged access exposure, compliance signoff rates, and beneficiary/financial data access governance. Critical for donor cybersecurity audits, GDPR compliance, and humanitarian data protection. Supports JML (Joiner-Mover-Leaver) lifecycle governance. PII note: target_user_email is PII — apply pii_staff masking policy in Unity Catalog."
  source: "`vibe_ngo_v1`.`technology`.`access_provisioning`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of the access provisioning request (Pending, Approved, Active, Revoked, Expired) for lifecycle monitoring."
    - name: "request_type"
      expr: request_type
      comment: "Type of access request (New Access, Modification, Revocation, Recertification) for IAM process analysis."
    - name: "jml_lifecycle_stage"
      expr: jml_lifecycle_stage
      comment: "Joiner-Mover-Leaver lifecycle stage associated with the provisioning event — critical for access hygiene governance."
    - name: "data_classification_access_level"
      expr: data_classification_access_level
      comment: "Data classification level of the access granted (Public, Internal, Confidential, Restricted-Beneficiary) for risk-tiered reporting."
    - name: "target_system_environment"
      expr: target_system_environment
      comment: "Target system environment (Production, UAT, Development) for environment-specific access control analysis."
    - name: "beneficiary_data_access_flag"
      expr: beneficiary_data_access_flag
      comment: "Whether the provisioned access includes beneficiary data — highest sensitivity tier requiring enhanced oversight."
    - name: "financial_data_access_flag"
      expr: financial_data_access_flag
      comment: "Whether the provisioned access includes financial data — relevant for segregation of duties and donor audit controls."
    - name: "provisioning_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month access became effective, enabling trend analysis of access provisioning volume."
  measures:
    - name: "total_provisioning_requests"
      expr: COUNT(1)
      comment: "Total number of access provisioning requests. Baseline IAM volume KPI for capacity and process efficiency monitoring."
    - name: "beneficiary_data_access_grant_count"
      expr: COUNT(CASE WHEN beneficiary_data_access_flag = TRUE THEN 1 END)
      comment: "Count of access grants including beneficiary data access. Highest-sensitivity IAM KPI — directly informs data protection impact assessments and donor audit scope."
    - name: "compliance_signoff_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN compliance_signoff_required_flag = TRUE AND compliance_signoff_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN compliance_signoff_required_flag = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of required compliance signoffs that have been completed. Measures IAM governance adherence — gaps trigger audit findings."
    - name: "mfa_required_provisioning_count"
      expr: COUNT(CASE WHEN multi_factor_authentication_required_flag = TRUE THEN 1 END)
      comment: "Count of access grants requiring MFA. Tracks enforcement of multi-factor authentication policy across sensitive system access."
    - name: "donor_audit_flagged_access_count"
      expr: COUNT(CASE WHEN donor_audit_requirement_flag = TRUE THEN 1 END)
      comment: "Count of access grants flagged for donor audit requirements. Directly supports grant compliance reporting and donor cybersecurity covenant adherence."
    - name: "active_access_grant_count"
      expr: COUNT(CASE WHEN request_status = 'Active' THEN 1 END)
      comment: "Count of currently active access grants. Operational access footprint KPI for least-privilege governance and periodic access review."
    - name: "overdue_access_review_count"
      expr: COUNT(CASE WHEN access_review_due_date < CURRENT_DATE() AND request_status = 'Active' THEN 1 END)
      comment: "Count of active access grants with overdue access reviews. Critical compliance KPI — overdue reviews represent unmitigated access risk and audit exposure."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT service desk KPIs for the NGO technology domain. Tracks service request volume, resolution performance, SLA compliance, and user satisfaction. Supports IT service management governance and operational efficiency reporting. Relevant to ITSM platforms serving field offices, country offices, and HQ staff across the NGO technology stack."
  source: "`vibe_ngo_v1`.`technology`.`service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (Access Request, Hardware, Software, Information, Incident) for demand analysis."
    - name: "service_request_status"
      expr: service_request_status
      comment: "Current lifecycle status of the service request for backlog and throughput monitoring."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority assigned to the request (Critical, High, Medium, Low) for SLA tier analysis."
    - name: "resolution_category"
      expr: resolution_category
      comment: "How the request was resolved (Self-Service, Knowledge Article, Technician, Escalated) for deflection and efficiency analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the request breached its SLA target — key service quality indicator."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the request was escalated, indicating complexity or support capacity issues."
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Month the request was submitted for trend and seasonality analysis."
  measures:
    - name: "total_service_requests"
      expr: COUNT(1)
      comment: "Total number of service requests submitted. Baseline demand KPI for IT service desk capacity planning."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN 1 END)
      comment: "Count of requests that breached SLA targets. Primary service quality KPI — high counts trigger staffing and process improvement decisions."
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = FALSE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of service requests resolved within SLA targets. Core IT service management KPI for vendor and team performance evaluation."
    - name: "avg_time_spent_hours"
      expr: AVG(CAST(time_spent_hours AS DOUBLE))
      comment: "Average technician time spent per service request. Efficiency KPI for resource utilization and cost-per-ticket analysis."
    - name: "total_time_spent_hours"
      expr: SUM(CAST(time_spent_hours AS DOUBLE))
      comment: "Total technician hours consumed by service requests. Informs staffing capacity planning and IT operational cost allocation."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target resolution time in hours across all requests. Benchmarks service level commitments by priority tier."
    - name: "avg_requester_feedback_score"
      expr: AVG(CAST(requester_feedback AS DOUBLE))
      comment: "Average user satisfaction score from requester feedback. Measures IT service quality from the end-user perspective — informs service improvement investments."
    - name: "open_request_count"
      expr: COUNT(CASE WHEN service_request_status NOT IN ('Closed', 'Resolved', 'Cancelled') THEN 1 END)
      comment: "Count of currently open service requests. Operational backlog KPI for daily IT service management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_security_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cybersecurity assessment portfolio KPIs for the NGO technology domain. Tracks assessment coverage, findings severity, remediation status, and cost. Supports donor cybersecurity audit requirements, GDPR data protection impact assessments, and organizational cyber risk governance. Particularly critical for systems hosting beneficiary data (Primero, DHIS2, Kobo Toolbox)."
  source: "`vibe_ngo_v1`.`technology`.`security_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of security assessment (Penetration Test, Vulnerability Scan, Audit, DPIA, Risk Assessment) for coverage analysis."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the assessment (Planned, In Progress, Completed, Remediation In Progress) for pipeline monitoring."
    - name: "overall_risk_rating"
      expr: overall_risk_rating
      comment: "Overall risk rating from the assessment (Critical/High/Medium/Low) for executive risk dashboard."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance outcome of the assessment (Compliant, Non-Compliant, Partially Compliant) for regulatory reporting."
    - name: "beneficiary_data_at_risk"
      expr: beneficiary_data_at_risk
      comment: "Whether the assessment identified beneficiary data at risk — highest-priority humanitarian data protection indicator."
    - name: "donor_reporting_required"
      expr: donor_reporting_required
      comment: "Whether assessment findings must be reported to donors — tracks grant compliance obligations."
    - name: "assessment_year"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Year of assessment for annual coverage and trend analysis."
  measures:
    - name: "total_assessments"
      expr: COUNT(1)
      comment: "Total number of security assessments conducted. Baseline coverage KPI for cybersecurity program governance."
    - name: "total_assessment_cost_usd"
      expr: SUM(CAST(assessment_cost AS DOUBLE))
      comment: "Total spend on security assessments in USD. Cybersecurity investment KPI for budget planning and donor cost allocation."
    - name: "avg_assessment_cost_usd"
      expr: AVG(CAST(assessment_cost AS DOUBLE))
      comment: "Average cost per security assessment. Benchmarks assessment procurement efficiency."
    - name: "assessments_with_beneficiary_data_at_risk_count"
      expr: COUNT(CASE WHEN beneficiary_data_at_risk = TRUE THEN 1 END)
      comment: "Count of assessments identifying beneficiary data at risk. Highest-priority humanitarian data protection KPI — triggers mandatory escalation and remediation."
    - name: "non_compliant_assessment_count"
      expr: COUNT(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Count of assessments with non-compliant outcomes. Directly informs regulatory risk exposure and corrective action planning."
    - name: "donor_reportable_assessment_count"
      expr: COUNT(CASE WHEN donor_reporting_required = TRUE THEN 1 END)
      comment: "Count of assessments requiring donor reporting. Tracks grant compliance obligations and donor relationship risk."
    - name: "overdue_remediation_count"
      expr: COUNT(CASE WHEN remediation_deadline < CURRENT_DATE() AND remediation_status NOT IN ('Completed', 'Closed') THEN 1 END)
      comment: "Count of assessments with overdue remediation deadlines. Critical risk governance KPI — overdue remediations represent unmitigated cyber risk and potential donor covenant breaches."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT change management KPIs for the NGO technology domain. Tracks change volume, approval rates, implementation outcomes, and rollback frequency. Supports ITIL change governance, CAB effectiveness measurement, and operational risk management across the NGO technology stack including SAP, eTools, and field data systems."
  source: "`vibe_ngo_v1`.`technology`.`change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "Type of change (Standard, Normal, Emergency) for risk-tiered change analysis."
    - name: "change_request_status"
      expr: change_request_status
      comment: "Current lifecycle status of the change request for pipeline and backlog monitoring."
    - name: "change_category"
      expr: change_category
      comment: "Functional category of the change (Infrastructure, Application, Security, Configuration) for impact analysis."
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level assigned to the change (High/Medium/Low) for governance and approval routing."
    - name: "cab_approval_status"
      expr: cab_approval_status
      comment: "CAB approval outcome (Approved, Rejected, Deferred) for change governance effectiveness measurement."
    - name: "downtime_required"
      expr: downtime_required
      comment: "Whether the change requires system downtime — critical for field operations scheduling and beneficiary service continuity."
    - name: "submitted_month"
      expr: DATE_TRUNC('month', submitted_timestamp)
      comment: "Month the change request was submitted for trend and volume analysis."
  measures:
    - name: "total_change_requests"
      expr: COUNT(1)
      comment: "Total number of change requests submitted. Baseline change volume KPI for CAB capacity and process governance."
    - name: "cab_approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cab_approval_status = 'Approved' THEN 1 END) / NULLIF(COUNT(CASE WHEN cab_approval_required = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of CAB-reviewed changes that were approved. Measures change quality and CAB governance effectiveness."
    - name: "post_implementation_review_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN post_implementation_review_completed = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN change_request_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed changes with completed post-implementation reviews. Measures change management maturity and lessons-learned capture."
    - name: "emergency_change_count"
      expr: COUNT(CASE WHEN change_type = 'Emergency' THEN 1 END)
      comment: "Count of emergency changes. High volumes indicate reactive IT operations and insufficient change planning — a key process maturity KPI."
    - name: "failed_change_count"
      expr: COUNT(CASE WHEN implementation_outcome IN ('Failed', 'Rolled Back') THEN 1 END)
      comment: "Count of changes that failed or required rollback. Directly measures change implementation quality and operational risk."
    - name: "change_failure_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implementation_outcome IN ('Failed', 'Rolled Back') THEN 1 END) / NULLIF(COUNT(CASE WHEN change_request_status = 'Closed' THEN 1 END), 0), 2)
      comment: "Percentage of closed changes that failed or were rolled back. Core ITIL change management KPI — high rates trigger process improvement and risk escalation."
    - name: "downtime_required_change_count"
      expr: COUNT(CASE WHEN downtime_required = TRUE THEN 1 END)
      comment: "Count of changes requiring system downtime. Informs maintenance window planning and beneficiary service continuity risk management."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_it_problem`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IT problem management KPIs for the NGO technology domain. Tracks problem investigation progress, resolution efficiency, and recurring issue patterns. Supports root cause elimination, technical debt reduction, and proactive incident prevention. Connected to system_platform_id (per VREQ-035) enabling platform-level problem analysis."
  source: "`vibe_ngo_v1`.`technology`.`it_problem`"
  dimensions:
    - name: "it_problem_status"
      expr: it_problem_status
      comment: "Current lifecycle status of the problem (Open, Under Investigation, Known Error, Resolved, Closed)."
    - name: "problem_category"
      expr: problem_category
      comment: "Functional category of the problem for root cause trend analysis and preventive action targeting."
    - name: "severity"
      expr: severity
      comment: "Severity level of the problem for prioritization and escalation decisions."
    - name: "priority"
      expr: priority
      comment: "Priority assigned to the problem for resource allocation and resolution sequencing."
    - name: "is_known_error"
      expr: known_error
      comment: "Whether the problem has been classified as a known error with a documented workaround."
    - name: "is_recurring_problem"
      expr: recurring_problem
      comment: "Whether the problem is a recurring issue — recurring problems indicate systemic failures requiring architectural intervention."
    - name: "environment"
      expr: environment
      comment: "System environment where the problem was detected (Production, UAT, Development) for impact scoping."
    - name: "detected_month"
      expr: DATE_TRUNC('month', detected_date)
      comment: "Month the problem was detected for trend and backlog analysis."
  measures:
    - name: "total_problems"
      expr: COUNT(1)
      comment: "Total number of IT problems recorded. Baseline problem management volume KPI."
    - name: "open_problem_count"
      expr: COUNT(CASE WHEN it_problem_status NOT IN ('Resolved', 'Closed') THEN 1 END)
      comment: "Count of unresolved problems. Operational backlog KPI — high counts indicate systemic technical debt requiring investment."
    - name: "recurring_problem_count"
      expr: COUNT(CASE WHEN recurring_problem = TRUE THEN 1 END)
      comment: "Count of recurring problems. Identifies systemic failures and architectural weaknesses requiring root cause elimination investment."
    - name: "avg_actual_resolution_hours"
      expr: AVG(CAST(actual_resolution_hours AS DOUBLE))
      comment: "Average actual hours to resolve a problem. Measures problem management efficiency and informs staffing and tooling investment decisions."
    - name: "avg_estimated_resolution_hours"
      expr: AVG(CAST(estimated_resolution_hours AS DOUBLE))
      comment: "Average estimated resolution hours. Compared against actual to assess estimation accuracy and planning quality."
    - name: "resolution_effort_variance_hours"
      expr: SUM(CAST(actual_resolution_hours AS DOUBLE) - CAST(estimated_resolution_hours AS DOUBLE))
      comment: "Total variance between actual and estimated resolution effort in hours. Positive = over-effort; negative = under-effort. Informs capacity planning accuracy."
    - name: "known_error_count"
      expr: COUNT(CASE WHEN known_error = TRUE THEN 1 END)
      comment: "Count of problems classified as known errors. Tracks documented technical debt with workarounds — informs permanent fix prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_network_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network infrastructure KPIs for the NGO technology domain. Tracks connectivity capacity, SLA commitments, and geographic coverage across field offices and country operations. Critical for humanitarian field operations where connectivity directly impacts beneficiary service delivery, data collection (Kobo Toolbox, DHIS2), and program management (eTools). Connected to field.country via country_id (per VREQ-041)."
  source: "`vibe_ngo_v1`.`technology`.`network_site`"
  dimensions:
    - name: "site_type"
      expr: site_type
      comment: "Type of network site (Country Office, Field Office, Warehouse, HQ, Mobile Hub) for geographic and operational analysis."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Primary connectivity technology (Fiber, VSAT, 4G/LTE, WIMAX) for technology mix and resilience analysis."
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "DR tier of the network site for business continuity planning and resilience investment prioritization."
    - name: "security_classification"
      expr: security_classification
      comment: "Security classification of the network site for access control and compliance scoping."
    - name: "region"
      expr: region
      comment: "Geographic region of the network site for regional connectivity analysis and investment planning."
    - name: "vpn_enabled"
      expr: vpn_enabled
      comment: "Whether VPN is enabled at the site — critical for secure remote access and data protection in field environments."
    - name: "installation_year"
      expr: DATE_TRUNC('year', installation_date)
      comment: "Year the network site was installed for infrastructure age and refresh cycle analysis."
  measures:
    - name: "total_network_sites"
      expr: COUNT(1)
      comment: "Total number of network sites in the infrastructure portfolio. Baseline for geographic coverage assessment."
    - name: "total_bandwidth_capacity_mbps"
      expr: SUM(CAST(bandwidth_capacity_mbps AS DOUBLE))
      comment: "Total network bandwidth capacity in Mbps across all sites. Informs infrastructure investment and capacity planning decisions."
    - name: "avg_bandwidth_capacity_mbps"
      expr: AVG(CAST(bandwidth_capacity_mbps AS DOUBLE))
      comment: "Average bandwidth capacity per network site. Benchmarks connectivity standards and identifies under-served field locations."
    - name: "avg_uptime_sla_percentage"
      expr: AVG(CAST(uptime_sla_percentage AS DOUBLE))
      comment: "Average contracted uptime SLA across all network sites. Measures connectivity commitment quality for field operations."
    - name: "total_monthly_connectivity_cost_usd"
      expr: SUM(CAST(monthly_cost_usd AS DOUBLE))
      comment: "Total monthly spend on network connectivity in USD. Primary connectivity cost KPI for budget governance and ISP contract optimization."
    - name: "sites_without_vpn_count"
      expr: COUNT(CASE WHEN vpn_enabled = FALSE THEN 1 END)
      comment: "Count of network sites without VPN enabled. Security risk KPI — unprotected sites expose beneficiary and program data to interception."
    - name: "sites_without_firewall_count"
      expr: COUNT(CASE WHEN firewall_enabled = FALSE THEN 1 END)
      comment: "Count of network sites without firewall protection. Critical cybersecurity gap KPI requiring immediate remediation."
    - name: "total_backup_bandwidth_capacity_mbps"
      expr: SUM(CAST(backup_bandwidth_mbps AS DOUBLE))
      comment: "Total backup bandwidth capacity across all sites. Measures network resilience and business continuity coverage for field operations."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_connectivity_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network connectivity performance and outage KPIs for the NGO technology domain. Tracks uptime, latency, packet loss, and outage impact across field and country office network sites. Directly informs field operations continuity, beneficiary data collection reliability (Kobo Toolbox, DHIS2), and SLA compliance with ISP providers."
  source: "`vibe_ngo_v1`.`technology`.`connectivity_log`"
  dimensions:
    - name: "connection_status"
      expr: connection_status
      comment: "Current connectivity status (Connected, Degraded, Disconnected) for real-time and trend monitoring."
    - name: "connection_type"
      expr: connection_type
      comment: "Type of connection (Primary, Backup, Failover) for resilience and redundancy analysis."
    - name: "cause_classification"
      expr: cause_classification
      comment: "Root cause classification of connectivity issues for ISP accountability and infrastructure improvement."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the connectivity event for escalation and response prioritization."
    - name: "sla_compliant_flag"
      expr: sla_compliant_flag
      comment: "Whether the connectivity measurement was within SLA targets — key ISP performance indicator."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the connectivity measurement for trend and seasonal analysis."
  measures:
    - name: "total_connectivity_events"
      expr: COUNT(1)
      comment: "Total number of connectivity log events. Baseline for network monitoring volume and coverage."
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total cumulative outage duration in minutes. Primary network reliability KPI — directly measures operational disruption to field programs and beneficiary services."
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per event in minutes. Benchmarks incident severity and ISP response effectiveness."
    - name: "avg_latency_ms"
      expr: AVG(CAST(latency_ms AS DOUBLE))
      comment: "Average network latency in milliseconds. Measures connection quality for real-time applications (video conferencing, SAP, eTools)."
    - name: "avg_packet_loss_percent"
      expr: AVG(CAST(packet_loss_percent AS DOUBLE))
      comment: "Average packet loss percentage. High values indicate network degradation affecting data collection reliability and program management systems."
    - name: "avg_download_speed_mbps"
      expr: AVG(CAST(download_speed_mbps AS DOUBLE))
      comment: "Average download speed in Mbps. Measures actual vs. contracted bandwidth performance for ISP accountability."
    - name: "sla_non_compliant_event_count"
      expr: COUNT(CASE WHEN sla_compliant_flag = FALSE THEN 1 END)
      comment: "Count of connectivity events that breached SLA targets. Drives ISP penalty claims and contract renegotiation decisions."
    - name: "avg_bandwidth_utilization_pct"
      expr: AVG(CAST(bandwidth_utilization_percent AS DOUBLE))
      comment: "Average bandwidth utilization percentage. Capacity planning KPI — high utilization triggers upgrade investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_user_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "User account governance KPIs for the NGO technology domain. Tracks account lifecycle, MFA adoption, privileged access exposure, and data access footprint. Supports identity governance, donor cybersecurity audit requirements, and humanitarian data protection compliance. PII note: email_address, username are PII — apply pii_staff masking policy in Unity Catalog. Accounts linked to partner organizations (partner_org_id) require additional access governance scrutiny."
  source: "`vibe_ngo_v1`.`technology`.`user_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the user account (Active, Suspended, Deprovisioned, Locked) for lifecycle governance."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (Staff, Partner, Service Account, Admin) for access governance segmentation."
    - name: "mfa_enrolled_flag"
      expr: mfa_enrolled_flag
      comment: "Whether the account has MFA enrolled — critical security control for donor audit and data protection compliance."
    - name: "privileged_account_flag"
      expr: privileged_account_flag
      comment: "Whether the account has privileged (admin-level) access — highest risk tier requiring enhanced monitoring."
    - name: "beneficiary_data_access_flag"
      expr: beneficiary_data_access_flag
      comment: "Whether the account has access to beneficiary data — highest sensitivity tier for humanitarian data protection governance."
    - name: "financial_system_access_flag"
      expr: financial_system_access_flag
      comment: "Whether the account has financial system access — relevant for segregation of duties and donor financial audit controls."
    - name: "remote_access_enabled_flag"
      expr: remote_access_enabled_flag
      comment: "Whether remote access is enabled for the account — security risk factor for field and home-working staff."
    - name: "provisioning_month"
      expr: DATE_TRUNC('month', provisioning_date)
      comment: "Month the account was provisioned for JML lifecycle trend analysis."
  measures:
    - name: "total_user_accounts"
      expr: COUNT(1)
      comment: "Total number of user accounts in the system. Baseline identity governance KPI."
    - name: "active_account_count"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Count of currently active user accounts. Operational access footprint KPI for license cost management and security governance."
    - name: "mfa_enrollment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mfa_enrolled_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN account_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active accounts with MFA enrolled. Critical cybersecurity KPI — low rates represent significant breach risk and donor audit exposure."
    - name: "privileged_account_count"
      expr: COUNT(CASE WHEN privileged_account_flag = TRUE AND account_status = 'Active' THEN 1 END)
      comment: "Count of active privileged accounts. Least-privilege governance KPI — excessive privileged accounts represent elevated security risk."
    - name: "beneficiary_data_access_account_count"
      expr: COUNT(CASE WHEN beneficiary_data_access_flag = TRUE AND account_status = 'Active' THEN 1 END)
      comment: "Count of active accounts with beneficiary data access. Highest-sensitivity data protection KPI — must be minimized and regularly reviewed per humanitarian data protection standards."
    - name: "locked_account_count"
      expr: COUNT(CASE WHEN account_locked_flag = TRUE THEN 1 END)
      comment: "Count of locked user accounts. Indicates potential security incidents or policy enforcement actions requiring investigation."
    - name: "accounts_with_expired_passwords_count"
      expr: COUNT(CASE WHEN password_expiry_date < CURRENT_DATE() AND account_status = 'Active' THEN 1 END)
      comment: "Count of active accounts with expired passwords. Password hygiene KPI — expired passwords represent credential security risk and policy non-compliance."
    - name: "data_protection_acknowledgment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN data_protection_acknowledgment_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN account_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active accounts with data protection acknowledgment completed. Compliance KPI for GDPR, donor data agreements, and humanitarian data protection policy adherence."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`technology_backup_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Data backup and recovery KPIs for the NGO technology domain. Tracks backup coverage, success rates, storage consumption, and RPO/RTO compliance. Critical for business continuity, donor data protection requirements, and operational resilience of humanitarian systems including SAP, DHIS2, Primero, and Kobo Toolbox. Connected to user_account_id (per VREQ-036) for accountability tracking."
  source: "`vibe_ngo_v1`.`technology`.`backup_schedule`"
  dimensions:
    - name: "backup_type"
      expr: backup_type
      comment: "Type of backup (Full, Incremental, Differential, Snapshot) for coverage and storage analysis."
    - name: "backup_frequency"
      expr: backup_frequency
      comment: "Backup frequency (Daily, Weekly, Hourly, Real-time) for RPO compliance assessment."
    - name: "last_backup_status"
      expr: last_backup_status
      comment: "Status of the most recent backup execution (Success, Failed, Partial) for operational health monitoring."
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the backup schedule (Active, Suspended, Disabled) for coverage gap identification."
    - name: "data_classification_level"
      expr: data_classification_level
      comment: "Data classification level of the backed-up asset — prioritizes recovery for beneficiary and financial data."
    - name: "disaster_recovery_tier"
      expr: disaster_recovery_tier
      comment: "DR tier of the backup schedule for business continuity planning and recovery prioritization."
    - name: "storage_provider"
      expr: storage_provider
      comment: "Backup storage provider (AWS S3, Azure Blob, On-Premise) for vendor risk and cost analysis."
    - name: "encryption_enabled"
      expr: encryption_enabled
      comment: "Whether backup data is encrypted — mandatory for beneficiary and financial data protection compliance."
  measures:
    - name: "total_backup_schedules"
      expr: COUNT(1)
      comment: "Total number of backup schedules configured. Baseline coverage KPI for data protection governance."
    - name: "backup_success_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN last_backup_status = 'Success' THEN 1 END) / NULLIF(COUNT(CASE WHEN last_backup_status IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of backup schedules with a successful last backup. Primary data protection reliability KPI — low rates indicate recovery risk."
    - name: "failed_backup_count"
      expr: COUNT(CASE WHEN last_backup_status = 'Failed' THEN 1 END)
      comment: "Count of backup schedules with a failed last backup. Operational alert KPI — failed backups represent unprotected data and recovery risk."
    - name: "total_last_backup_size_gb"
      expr: SUM(CAST(last_backup_size_gb AS DOUBLE))
      comment: "Total size of last backup executions in GB. Storage capacity planning KPI for backup infrastructure investment."
    - name: "avg_last_backup_size_gb"
      expr: AVG(CAST(last_backup_size_gb AS DOUBLE))
      comment: "Average backup size per schedule in GB. Benchmarks data growth and informs storage tier optimization."
    - name: "unencrypted_backup_count"
      expr: COUNT(CASE WHEN encryption_enabled = FALSE AND schedule_status = 'Active' THEN 1 END)
      comment: "Count of active backup schedules without encryption. Critical data protection gap — unencrypted backups of beneficiary or financial data violate donor data agreements and GDPR."
    - name: "avg_compression_ratio"
      expr: AVG(CAST(compression_ratio AS DOUBLE))
      comment: "Average compression ratio achieved across backup schedules. Storage efficiency KPI for infrastructure cost optimization."
    - name: "verification_enabled_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN backup_verification_enabled = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of backup schedules with verification enabled. Measures backup integrity assurance coverage — unverified backups may be unrecoverable."
$$;