-- Metric views for domain: customer | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_port_community_participant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the port community participant master — covers participant portfolio health, credit exposure, ISPS compliance posture, and customer tier distribution. Used by commercial, compliance, and executive teams to steer onboarding, credit risk, and regulatory standing."
  source: "`shipping_ports_ecm`.`customer`.`port_community_participant`"
  dimensions:
    - name: "participant_type"
      expr: participant_type
      comment: "Type of port community participant (e.g. Shipping Line, Freight Forwarder, Customs Broker, Trucking Company) — primary segmentation axis for commercial analysis."
    - name: "customer_tier"
      expr: customer_tier
      comment: "Commercial tier assigned to the participant (e.g. Platinum, Gold, Silver) — used to segment revenue and service-level obligations."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the participant (Active, Suspended, Deactivated) — key filter for active-portfolio analysis."
    - name: "isps_accreditation_status"
      expr: isps_accreditation_status
      comment: "ISPS security accreditation status — used by port security and compliance teams to monitor regulatory standing."
    - name: "sanctions_screening_status"
      expr: sanctions_screening_status
      comment: "Latest sanctions screening outcome — critical compliance dimension for AML and trade-control reporting."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the participant — links commercial tier to service delivery obligations."
    - name: "dangerous_goods_approved"
      expr: dangerous_goods_approved
      comment: "Flag indicating whether the participant is approved to handle dangerous goods — used for cargo-type eligibility analysis."
    - name: "onboarding_year_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month of participant onboarding — used to track new-participant acquisition trends over time."
    - name: "credit_currency_code"
      expr: credit_currency_code
      comment: "Currency in which the participant credit limit is denominated — required for multi-currency credit exposure reporting."
  measures:
    - name: "total_participants"
      expr: COUNT(DISTINCT port_community_participant_id)
      comment: "Total number of distinct port community participants — baseline portfolio size KPI used by commercial leadership to track market reach."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total approved credit limit extended across all participants — primary credit risk exposure metric monitored by finance and risk committees."
    - name: "avg_credit_limit_per_participant"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per participant — indicates the typical credit exposure per counterparty; used to benchmark new credit applications."
    - name: "participants_with_isps_expiry_risk"
      expr: COUNT(DISTINCT CASE WHEN isps_accreditation_expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND isps_accreditation_status = 'Active' THEN port_community_participant_id END)
      comment: "Number of active participants whose ISPS accreditation expires within 30 days — operational risk KPI for port security compliance teams to trigger renewal actions."
    - name: "participants_pending_sanctions_clearance"
      expr: COUNT(DISTINCT CASE WHEN sanctions_screening_status NOT IN ('Cleared', 'Approved') THEN port_community_participant_id END)
      comment: "Number of participants not yet cleared through sanctions screening — compliance risk KPI; any non-zero value triggers immediate review by the compliance officer."
    - name: "dangerous_goods_approved_participants"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_approved = TRUE THEN port_community_participant_id END)
      comment: "Count of participants approved for dangerous goods handling — used by terminal operations to assess DG-capable counterparty capacity."
    - name: "vessel_operator_participants"
      expr: COUNT(DISTINCT CASE WHEN vessel_operator_flag = TRUE THEN port_community_participant_id END)
      comment: "Number of participants classified as vessel operators — used by commercial teams to track shipping line and vessel operator portfolio size."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_participant_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account-level financial health and commercial performance KPIs — covers credit utilisation, overdue exposure, deposit adequacy, and account lifecycle. Used by finance, credit risk, and commercial teams for portfolio management and collections prioritisation."
  source: "`shipping_ports_ecm`.`customer`.`participant_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of participant account (e.g. Shipping Line, Freight Forwarder, Importer) — primary segmentation for commercial and credit analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Commercial tier of the account — used to segment revenue and prioritise collections and relationship management."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Suspended, Closed) — key filter for active-portfolio reporting."
    - name: "service_line"
      expr: service_line
      comment: "Port service line associated with the account (e.g. Container, Bulk, RoRo) — used to segment revenue and credit exposure by business line."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used by the account (e.g. EFT, Letter of Credit, Cash) — used by treasury to manage payment risk and cash flow forecasting."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code assigned to the account — used to segment accounts by credit period and assess collections risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Billing currency of the account — required for multi-currency financial exposure reporting."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the account — links commercial tier to service delivery obligations and penalty exposure."
    - name: "edi_enabled"
      expr: edi_enabled
      comment: "Whether the account is EDI-enabled — used by IT and operations to track digital integration adoption."
    - name: "account_open_year_month"
      expr: DATE_TRUNC('MONTH', account_open_date)
      comment: "Month the account was opened — used to track new account acquisition trends and cohort analysis."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN participant_account_id END)
      comment: "Total number of active participant accounts — baseline commercial portfolio KPI used by the CCO to track active customer base size."
    - name: "total_credit_limit_portfolio"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — aggregate credit risk exposure monitored by the CFO and credit committee."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance across all accounts — primary collections and cash flow KPI for the finance team."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables amount — critical collections risk KPI; drives prioritisation of dunning and credit suspension actions."
    - name: "avg_credit_utilisation_pct"
      expr: AVG(CAST(credit_utilisation_pct AS DOUBLE))
      comment: "Average credit utilisation percentage across accounts — indicates how much of the approved credit portfolio is drawn; high values signal elevated credit risk."
    - name: "total_deposit_held"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total security deposits held from participants — used by treasury to assess collateral coverage against outstanding credit exposure."
    - name: "accounts_with_overdue_balance"
      expr: COUNT(DISTINCT CASE WHEN overdue_amount > 0 THEN participant_account_id END)
      comment: "Number of accounts carrying an overdue balance — collections workload KPI used by the credit control team to size recovery efforts."
    - name: "total_last_payment_amount"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Sum of the most recent payment received per account — used as a proxy for recent cash inflow from the customer portfolio."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate granted across accounts — used by commercial leadership to monitor margin leakage from negotiated discounts."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_credit_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk assessment KPIs — tracks credit limit decisions, score distributions, risk categorisation, and watch-list exposure. Used by the credit committee, CFO, and risk management to govern credit policy and monitor counterparty risk."
  source: "`shipping_ports_ecm`.`customer`.`credit_assessment`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the credit assessment (Approved, Rejected, Pending, Under Review) — primary filter for pipeline and decision analysis."
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of credit assessment (New, Annual Review, Ad-hoc) — used to segment assessment volume by trigger type."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the participant (Low, Medium, High, Critical) — primary risk segmentation dimension for portfolio monitoring."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned during assessment — used to benchmark against external bureau ratings and track rating migration."
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Historical payment behaviour rating — key input to credit scoring; used to segment participants by payment reliability."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which credit limits are assessed — required for multi-currency credit exposure reporting."
    - name: "security_deposit_required"
      expr: security_deposit_required
      comment: "Whether a security deposit was required as a condition of credit approval — used to track collateral requirements across the portfolio."
    - name: "is_watch_list"
      expr: is_watch_list
      comment: "Flag indicating the participant is on the credit watch list — used by the credit committee to monitor elevated-risk counterparties."
    - name: "assessment_year_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month of credit assessment — used to track assessment pipeline volume and approval trends over time."
    - name: "approval_level"
      expr: approval_level
      comment: "Approval authority level required for the credit decision (e.g. Manager, Director, Board) — used to track escalation patterns."
  measures:
    - name: "total_approved_credit_limit"
      expr: SUM(CAST(approved_credit_limit AS DOUBLE))
      comment: "Total credit limit approved across all assessments — aggregate credit exposure KPI monitored by the CFO and credit committee."
    - name: "total_requested_credit_limit"
      expr: SUM(CAST(requested_credit_limit AS DOUBLE))
      comment: "Total credit limit requested by participants — used to measure demand for credit facilities and compare against approved amounts."
    - name: "total_assessed_credit_limit"
      expr: SUM(CAST(assessed_credit_limit AS DOUBLE))
      comment: "Total credit limit recommended by assessors before final approval — used to track the gap between assessor recommendation and final approval decision."
    - name: "avg_credit_score"
      expr: AVG(CAST(credit_score AS DOUBLE))
      comment: "Average credit score across all assessments — portfolio-level credit quality indicator used by the risk committee to monitor overall counterparty risk."
    - name: "total_outstanding_balance_at_assessment"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance recorded at time of assessment — used to assess credit utilisation relative to approved limits at the point of review."
    - name: "total_security_deposit_required"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposit amount required across assessments — used by treasury to track collateral obligations and cash held as security."
    - name: "watch_list_participants"
      expr: COUNT(DISTINCT CASE WHEN is_watch_list = TRUE THEN port_community_participant_id END)
      comment: "Number of distinct participants currently on the credit watch list — elevated-risk portfolio KPI; any increase triggers immediate credit committee review."
    - name: "credit_approval_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN assessment_status = 'Approved' THEN credit_assessment_id END) / NULLIF(COUNT(DISTINCT credit_assessment_id), 0), 2)
      comment: "Percentage of credit assessments resulting in approval — used by commercial and credit teams to monitor credit policy tightness and approval pipeline efficiency."
    - name: "avg_approved_vs_requested_ratio"
      expr: ROUND(AVG(CAST(approved_credit_limit AS DOUBLE) / NULLIF(CAST(requested_credit_limit AS DOUBLE), 0)), 4)
      comment: "Average ratio of approved credit limit to requested credit limit — measures how conservatively the credit committee approves requests; values below 1.0 indicate systematic haircuts."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_accreditation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Accreditation portfolio KPIs — tracks the status, validity, insurance coverage, and revocation patterns of participant accreditations. Used by compliance, port security, and operations teams to ensure all active participants hold valid credentials."
  source: "`shipping_ports_ecm`.`customer`.`accreditation`"
  dimensions:
    - name: "accreditation_type"
      expr: accreditation_type
      comment: "Type of accreditation (e.g. ISPS, Dangerous Goods, Customs Broker) — primary segmentation for compliance reporting."
    - name: "accreditation_category"
      expr: accreditation_category
      comment: "Category of accreditation — used to group accreditations by regulatory regime or operational scope."
    - name: "accreditation_status"
      expr: accreditation_status
      comment: "Current status of the accreditation (Active, Expired, Suspended, Revoked) — primary filter for compliance posture analysis."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the accreditation document — used by compliance teams to track document validation pipeline."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the accreditation — used to track upcoming renewals and prevent lapses in compliance coverage."
    - name: "issuing_authority_country"
      expr: issuing_authority_country
      comment: "Country of the issuing authority — used for cross-border compliance analysis and mutual recognition reporting."
    - name: "scope_level"
      expr: scope_level
      comment: "Scope level of the accreditation (e.g. Terminal, Port, National) — used to assess coverage breadth of participant credentials."
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the accreditation is mandatory for port access — used to prioritise compliance monitoring for non-negotiable credentials."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of accreditation expiry — used to build forward-looking expiry calendars and trigger renewal workflows."
  measures:
    - name: "total_active_accreditations"
      expr: COUNT(DISTINCT CASE WHEN accreditation_status = 'Active' THEN accreditation_id END)
      comment: "Total number of currently active accreditations — baseline compliance coverage KPI; a decline signals emerging credential gaps across the participant community."
    - name: "accreditations_expiring_within_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND accreditation_status = 'Active' THEN accreditation_id END)
      comment: "Number of active accreditations expiring within 30 days — forward-looking compliance risk KPI used by port security to trigger renewal actions before lapses occur."
    - name: "revoked_accreditations"
      expr: COUNT(DISTINCT CASE WHEN is_revoked = TRUE THEN accreditation_id END)
      comment: "Total number of revoked accreditations — compliance integrity KPI; elevated counts indicate systemic issues with participant credential management."
    - name: "total_insurance_coverage_amount"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all accreditations — used by risk management to assess aggregate insurance protection held by the participant community."
    - name: "avg_insurance_coverage_amount"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage amount per accreditation — used to benchmark coverage adequacy against minimum port authority requirements."
    - name: "accreditation_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accreditation_status = 'Active' AND is_revoked = FALSE THEN accreditation_id END) / NULLIF(COUNT(DISTINCT accreditation_id), 0), 2)
      comment: "Percentage of accreditations that are active and not revoked — overall compliance health rate; used in regulatory reporting to demonstrate port authority governance effectiveness."
    - name: "mandatory_accreditations_lapsed"
      expr: COUNT(DISTINCT CASE WHEN is_mandatory = TRUE AND accreditation_status != 'Active' THEN accreditation_id END)
      comment: "Number of mandatory accreditations that are not currently active — critical compliance risk KPI; any non-zero value requires immediate remediation to maintain port operating licence."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_port_access_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Port access permit KPIs — tracks permit issuance, validity, ISPS security levels, background check status, and revocation patterns. Used by port security, ISPS officers, and compliance teams to maintain controlled access to restricted port areas."
  source: "`shipping_ports_ecm`.`customer`.`port_access_permit`"
  dimensions:
    - name: "permit_type"
      expr: permit_type
      comment: "Type of port access permit (e.g. Permanent, Temporary, Visitor, Contractor) — primary segmentation for access control analysis."
    - name: "permit_category"
      expr: permit_category
      comment: "Category of the permit — used to group permits by access scope and regulatory regime."
    - name: "permit_status"
      expr: permit_status
      comment: "Current status of the permit (Active, Expired, Suspended, Revoked) — primary filter for active access control reporting."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level associated with the permit — used by port security to segment access rights by threat level."
    - name: "background_check_status"
      expr: background_check_status
      comment: "Status of the background check for the permit holder — compliance dimension used to ensure all active permit holders have cleared security vetting."
    - name: "holder_nationality"
      expr: holder_nationality
      comment: "Nationality of the permit holder — used for ISPS and customs compliance reporting on workforce demographics."
    - name: "escort_required"
      expr: escort_required
      comment: "Whether the permit holder requires an escort within the port — used by security operations to plan escort resource requirements."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the permit — used to track permit issuance by regulatory body and identify concentration risk."
    - name: "issue_year_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month the permit was issued — used to track permit issuance volume trends and seasonal access patterns."
  measures:
    - name: "total_active_permits"
      expr: COUNT(DISTINCT CASE WHEN permit_status = 'Active' THEN port_access_permit_id END)
      comment: "Total number of currently active port access permits — baseline security perimeter KPI; used by the ISPS officer to monitor the size of the authorised access population."
    - name: "permits_expiring_within_30_days"
      expr: COUNT(DISTINCT CASE WHEN expiry_date <= DATE_ADD(CURRENT_DATE(), 30) AND permit_status = 'Active' THEN port_access_permit_id END)
      comment: "Number of active permits expiring within 30 days — forward-looking security risk KPI used to trigger renewal workflows before access lapses."
    - name: "revoked_permits"
      expr: COUNT(DISTINCT CASE WHEN permit_status = 'Revoked' THEN port_access_permit_id END)
      comment: "Total number of revoked permits — security integrity KPI; elevated counts indicate systemic access control issues requiring investigation."
    - name: "permits_without_cleared_background_check"
      expr: COUNT(DISTINCT CASE WHEN background_check_status != 'Cleared' AND permit_status = 'Active' THEN port_access_permit_id END)
      comment: "Number of active permits where the holder has not cleared a background check — critical ISPS compliance risk KPI; any non-zero value requires immediate security review."
    - name: "escort_required_permit_count"
      expr: COUNT(DISTINCT CASE WHEN escort_required = TRUE AND permit_status = 'Active' THEN port_access_permit_id END)
      comment: "Number of active permits requiring escort — used by security operations to plan and resource escort duties within the terminal."
    - name: "permit_active_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN permit_status = 'Active' THEN port_access_permit_id END) / NULLIF(COUNT(DISTINCT port_access_permit_id), 0), 2)
      comment: "Percentage of all permits that are currently active — overall access permit health rate; declining values indicate permit management backlogs or elevated revocation activity."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_service_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service request KPIs — tracks request volumes, resolution performance, SLA breach rates, escalation patterns, and dispute exposure. Used by customer service management, operations, and executive teams to monitor service quality and customer satisfaction."
  source: "`shipping_ports_ecm`.`customer`.`service_request`"
  dimensions:
    - name: "request_type"
      expr: request_type
      comment: "Type of service request (e.g. Complaint, Enquiry, Dispute, Documentation) — primary segmentation for service demand analysis."
    - name: "service_request_category"
      expr: service_request_category
      comment: "Category of the service request — used to group requests by operational domain for workload and trend analysis."
    - name: "request_status"
      expr: request_status
      comment: "Current status of the service request (Open, In Progress, Resolved, Closed) — primary filter for workload and backlog reporting."
    - name: "priority"
      expr: priority
      comment: "Priority level of the service request (Critical, High, Medium, Low) — used to segment workload by urgency and assess SLA risk."
    - name: "channel"
      expr: channel
      comment: "Channel through which the request was lodged (e.g. Email, Phone, Portal, EDI) — used to track digital adoption and channel cost analysis."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the request has been escalated — used to identify systemic service failures requiring management intervention."
    - name: "isps_related"
      expr: isps_related
      comment: "Whether the request is related to ISPS security — used by compliance teams to track security-related service demand."
    - name: "imdg_related"
      expr: imdg_related
      comment: "Whether the request is related to IMDG dangerous goods — used by operations to track hazardous cargo service demand."
    - name: "lodgement_year_month"
      expr: DATE_TRUNC('MONTH', lodgement_timestamp)
      comment: "Month the service request was lodged — used to track request volume trends and seasonal demand patterns."
    - name: "subcategory"
      expr: subcategory
      comment: "Sub-category of the service request — provides granular classification for root cause analysis and process improvement."
  measures:
    - name: "total_service_requests"
      expr: COUNT(DISTINCT service_request_id)
      comment: "Total number of service requests lodged — baseline service demand KPI used by customer service management to size team capacity and track demand trends."
    - name: "open_service_requests"
      expr: COUNT(DISTINCT CASE WHEN request_status IN ('Open', 'In Progress') THEN service_request_id END)
      comment: "Number of currently open service requests — workload backlog KPI; used by operations managers to monitor queue depth and allocate resources."
    - name: "sla_response_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_response_breached = TRUE THEN service_request_id END) / NULLIF(COUNT(DISTINCT service_request_id), 0), 2)
      comment: "Percentage of service requests where the SLA response target was breached — primary service quality KPI; directly linked to customer satisfaction scores and penalty exposure."
    - name: "sla_resolution_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_resolution_breached = TRUE THEN service_request_id END) / NULLIF(COUNT(DISTINCT service_request_id), 0), 2)
      comment: "Percentage of service requests where the SLA resolution target was breached — end-to-end service quality KPI; used in quarterly business reviews to assess service delivery performance."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN service_request_id END) / NULLIF(COUNT(DISTINCT service_request_id), 0), 2)
      comment: "Percentage of service requests that were escalated — service quality stress indicator; high escalation rates signal systemic first-line resolution failures."
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount AS DOUBLE))
      comment: "Total financial value of disputes raised through service requests — financial risk KPI monitored by finance and commercial teams to quantify billing and service dispute exposure."
    - name: "avg_dispute_amount"
      expr: AVG(CAST(dispute_amount AS DOUBLE))
      comment: "Average dispute amount per service request — used to benchmark dispute severity and prioritise high-value dispute resolution."
    - name: "regulatory_notification_required_count"
      expr: COUNT(DISTINCT CASE WHEN regulatory_notification_required = TRUE THEN service_request_id END)
      comment: "Number of service requests requiring regulatory notification — compliance workload KPI; used by the compliance team to ensure all mandatory notifications are filed on time."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_sla_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA performance measurement KPIs — tracks breach rates, penalty exposure, variance from targets, and remediation status across all measured service commitments. Used by operations, commercial, and executive teams to govern service quality and manage penalty liability."
  source: "`shipping_ports_ecm`.`customer`.`sla_performance`"
  dimensions:
    - name: "metric_category"
      expr: metric_category
      comment: "Category of the SLA metric being measured (e.g. Vessel Turnaround, Gate Processing, Crane Productivity) — primary segmentation for performance analysis."
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the specific SLA metric — granular dimension for drill-down analysis of individual KPI performance."
    - name: "service_type"
      expr: service_type
      comment: "Type of port service covered by the SLA — used to segment performance by operational service line."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA measurement resulted in a breach — primary filter for breach analysis and remediation tracking."
    - name: "breach_severity"
      expr: breach_severity
      comment: "Severity of the SLA breach (Minor, Major, Critical) — used to prioritise remediation actions and escalation decisions."
    - name: "breach_direction"
      expr: breach_direction
      comment: "Direction of the breach (Over/Under target) — used to distinguish between capacity overruns and underperformance scenarios."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment associated with the SLA measurement — used to analyse performance differentiation across commercial tiers."
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type of the SLA measurement (Daily, Weekly, Monthly) — used to align performance reporting with contractual measurement windows."
    - name: "penalty_applicable_flag"
      expr: penalty_applicable_flag
      comment: "Whether a financial penalty applies to the breach — used by finance to identify and accrue penalty liabilities."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions for breached SLAs — used by operations to track corrective action completion."
    - name: "measurement_year_month"
      expr: DATE_TRUNC('MONTH', measurement_event_timestamp)
      comment: "Month of the SLA measurement event — used to track performance trends over time and identify deteriorating service areas."
  measures:
    - name: "total_sla_measurements"
      expr: COUNT(DISTINCT sla_performance_id)
      comment: "Total number of SLA measurements recorded — baseline measurement coverage KPI; used to verify that all contractual SLAs are being actively monitored."
    - name: "total_sla_breaches"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_performance_id END)
      comment: "Total number of SLA breaches recorded — primary service quality KPI; directly linked to customer satisfaction, penalty liability, and contract renewal risk."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_performance_id END) / NULLIF(COUNT(DISTINCT sla_performance_id), 0), 2)
      comment: "Percentage of SLA measurements resulting in a breach — headline service quality rate used in board and customer QBR reporting."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty amount accrued from SLA breaches — primary financial liability KPI monitored by the CFO; drives urgency of remediation investment decisions."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average percentage variance from SLA target across all measurements — indicates the typical magnitude of performance deviation; used to assess whether breaches are marginal or systemic."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total absolute variance from SLA targets — aggregate performance gap KPI used to quantify the overall scale of service delivery shortfall."
    - name: "penalty_applicable_breach_count"
      expr: COUNT(DISTINCT CASE WHEN penalty_applicable_flag = TRUE AND breach_flag = TRUE THEN sla_performance_id END)
      comment: "Number of breaches where a financial penalty is applicable — financial risk KPI used by finance to size penalty accruals and prioritise remediation of highest-cost breaches."
    - name: "waived_penalty_count"
      expr: COUNT(DISTINCT CASE WHEN waiver_flag = TRUE THEN sla_performance_id END)
      comment: "Number of SLA breaches where the penalty was waived — commercial governance KPI; high waiver rates may indicate inconsistent penalty enforcement or excessive commercial concessions."
    - name: "customer_notified_breach_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN customer_notified_flag = TRUE AND breach_flag = TRUE THEN sla_performance_id END) / NULLIF(COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_performance_id END), 0), 2)
      comment: "Percentage of SLA breaches where the customer was notified — contractual obligation compliance rate; failure to notify customers of breaches creates additional legal and reputational risk."
    - name: "avg_actual_vs_target_ratio"
      expr: ROUND(AVG(CAST(actual_value AS DOUBLE) / NULLIF(CAST(target_value AS DOUBLE), 0)), 4)
      comment: "Average ratio of actual measured value to SLA target value — normalised performance index across heterogeneous SLA metrics; values above 1.0 indicate overperformance, below 1.0 indicate underperformance."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_sla_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA profile configuration KPIs — tracks the portfolio of SLA commitments, penalty structures, breach thresholds, and remediation obligations. Used by commercial, legal, and operations teams to govern SLA contract design and monitor aggregate penalty exposure."
  source: "`shipping_ports_ecm`.`customer`.`sla_profile`"
  dimensions:
    - name: "profile_type"
      expr: profile_type
      comment: "Type of SLA profile (e.g. Standard, Premium, Custom) — used to segment SLA commitments by commercial tier."
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the SLA profile (Active, Expired, Draft) — primary filter for active SLA obligation reporting."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the profile — used to segment performance obligations by commercial tier."
    - name: "metric_type"
      expr: metric_type
      comment: "Type of metric governed by the SLA profile (e.g. Turnaround Time, Throughput, Availability) — used to categorise SLA obligations by operational domain."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty applicable for breach (e.g. Fixed, Percentage, Credit) — used by finance to model penalty liability scenarios."
    - name: "penalty_basis"
      expr: penalty_basis
      comment: "Basis on which the penalty is calculated (e.g. Per Day, Per TEU, Per Incident) — used to model penalty accrual under different breach scenarios."
    - name: "breach_flag"
      expr: breach_flag
      comment: "Whether the SLA profile is currently in breach — used to identify active contractual violations requiring remediation."
    - name: "remediation_status"
      expr: remediation_status
      comment: "Status of remediation actions for breached SLA profiles — used by operations to track corrective action completion."
    - name: "force_majeure_applicable"
      expr: force_majeure_applicable
      comment: "Whether force majeure provisions apply to the SLA profile — used by legal to identify profiles with reduced penalty exposure under exceptional circumstances."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the SLA profile became effective — used to track SLA portfolio evolution and contract renewal cycles."
  measures:
    - name: "total_active_sla_profiles"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'Active' THEN sla_profile_id END)
      comment: "Total number of active SLA profiles — baseline SLA obligation portfolio KPI; used by commercial and legal teams to track the scope of contractual service commitments."
    - name: "total_penalty_value_at_risk"
      expr: SUM(CAST(penalty_value AS DOUBLE))
      comment: "Total penalty value defined across all SLA profiles — maximum penalty liability at risk KPI; used by finance to size worst-case penalty exposure in financial planning."
    - name: "total_penalty_amount_applied"
      expr: SUM(CAST(penalty_amount_applied AS DOUBLE))
      comment: "Total penalty amount actually applied across SLA profiles — realised penalty cost KPI; used by finance to track actual penalty charges and compare against accruals."
    - name: "total_credit_cap_value"
      expr: SUM(CAST(credit_cap_value AS DOUBLE))
      comment: "Total credit cap value across SLA profiles — maximum credit liability KPI; used by finance to cap worst-case credit exposure from SLA breaches."
    - name: "avg_breach_threshold"
      expr: AVG(CAST(breach_threshold AS DOUBLE))
      comment: "Average breach threshold across SLA profiles — used by commercial teams to benchmark the stringency of SLA commitments and identify profiles with unusually tight tolerances."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across profiles — used to benchmark performance targets and assess whether commitments are aligned with operational capability."
    - name: "profiles_in_breach"
      expr: COUNT(DISTINCT CASE WHEN breach_flag = TRUE THEN sla_profile_id END)
      comment: "Number of SLA profiles currently in breach — active contractual violation KPI; used by operations and legal to prioritise remediation and manage customer relationship risk."
    - name: "total_teu_volume_under_sla"
      expr: SUM(CAST(teu_volume AS DOUBLE))
      comment: "Total TEU volume committed under SLA profiles — commercial volume obligation KPI; used by terminal operations to plan capacity against contracted throughput commitments."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`customer_relationship_manager`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Relationship manager assignment and performance KPIs — tracks revenue targets, TEU volume targets, churn risk, strategic account coverage, and assignment health. Used by commercial leadership to govern key account management effectiveness and resource allocation."
  source: "`shipping_ports_ecm`.`customer`.`relationship_manager`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the relationship manager assignment (Active, Ended, On Hold) — primary filter for active coverage analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (Primary, Secondary, Interim) — used to distinguish primary account ownership from supporting coverage roles."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment covered by the relationship manager — used to analyse coverage distribution across commercial tiers."
    - name: "role_type"
      expr: role_type
      comment: "Role type of the relationship manager (e.g. Key Account Manager, Port Sales Executive) — used to segment performance targets by role."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the accounts managed — used to assess whether high-tier accounts have appropriate relationship management coverage."
    - name: "escalation_tier"
      expr: escalation_tier
      comment: "Escalation tier for the relationship — used to track accounts requiring elevated management attention."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Whether the account is flagged as a churn risk — critical retention KPI dimension; used by commercial leadership to prioritise retention interventions."
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Whether the account is classified as a strategic account — used to ensure strategic accounts receive dedicated relationship management coverage."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which revenue targets are denominated — required for multi-currency target reporting."
    - name: "assignment_start_year_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month the assignment started — used to track relationship manager assignment trends and tenure analysis."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN relationship_manager_id END)
      comment: "Total number of active relationship manager assignments — coverage KPI used by commercial leadership to ensure all key accounts have assigned managers."
    - name: "total_annual_revenue_target"
      expr: SUM(CAST(annual_revenue_target AS DOUBLE))
      comment: "Total annual revenue target across all active relationship manager assignments — aggregate commercial target KPI used by the CCO to track total revenue commitment."
    - name: "total_annual_teu_volume_target"
      expr: SUM(CAST(annual_teu_volume_target AS DOUBLE))
      comment: "Total annual TEU volume target across all relationship manager assignments — aggregate throughput commitment KPI used by terminal operations and commercial teams."
    - name: "avg_response_time_target_hours"
      expr: AVG(CAST(response_time_target_hours AS DOUBLE))
      comment: "Average response time target in hours across relationship manager assignments — used to benchmark service responsiveness commitments and identify accounts with unusually demanding SLAs."
    - name: "churn_risk_accounts"
      expr: COUNT(DISTINCT CASE WHEN churn_risk_flag = TRUE AND assignment_status = 'Active' THEN relationship_manager_id END)
      comment: "Number of active assignments flagged as churn risk — retention risk KPI; used by commercial leadership to prioritise retention investment and escalate at-risk accounts."
    - name: "strategic_accounts_covered"
      expr: COUNT(DISTINCT CASE WHEN strategic_account_flag = TRUE AND assignment_status = 'Active' THEN relationship_manager_id END)
      comment: "Number of active assignments covering strategic accounts — strategic portfolio coverage KPI; used by the CCO to ensure all strategic accounts have dedicated relationship management."
    - name: "primary_assignment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_primary = TRUE AND assignment_status = 'Active' THEN relationship_manager_id END) / NULLIF(COUNT(DISTINCT CASE WHEN assignment_status = 'Active' THEN relationship_manager_id END), 0), 2)
      comment: "Percentage of active assignments designated as primary — account ownership clarity KPI; low rates indicate accounts with unclear primary ownership, creating service delivery risk."
$$;