-- Metric views for domain: client | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the client account master — credit exposure, portfolio health, and account mix. Used by sales leadership and finance to monitor client risk, revenue potential, and account lifecycle status."
  source: "`staffing_hr_ecm_v1`.`client`.`client_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the client account (e.g. Active, Inactive, On Hold). Primary segmentation for portfolio health analysis."
    - name: "client_type"
      expr: client_type
      comment: "Classification of the client (e.g. Direct, MSP, VMS). Drives service model and pricing strategy."
    - name: "company_size_tier"
      expr: company_size_tier
      comment: "Size tier of the client company (e.g. Enterprise, Mid-Market, SMB). Used for segmented revenue and risk analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA commitment tier assigned to the client. Indicates service level obligations and associated cost-to-serve."
    - name: "primary_state"
      expr: primary_state
      comment: "State/province of the client's primary address. Enables geographic portfolio analysis."
    - name: "primary_country"
      expr: primary_country
      comment: "Country of the client's primary address. Supports global portfolio segmentation."
    - name: "naics_code"
      expr: naics_code
      comment: "NAICS industry classification of the client. Used for vertical market analysis and benchmarking."
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Contractual payment terms in days (e.g. Net 30, Net 60). Impacts DSO and cash flow forecasting."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Frequency at which invoices are issued to the client. Relevant for billing operations and cash cycle analysis."
    - name: "msa_effective_date"
      expr: DATE_TRUNC('month', msa_effective_date)
      comment: "Month the Master Service Agreement became effective. Used to track contract cohort aging."
    - name: "msa_expiration_date"
      expr: DATE_TRUNC('month', msa_expiration_date)
      comment: "Month the MSA expires. Used to identify renewal pipeline and at-risk contracts."
    - name: "nda_on_file"
      expr: nda_on_file
      comment: "Indicates whether a Non-Disclosure Agreement is on file for the client. Compliance and risk flag."
    - name: "po_required"
      expr: po_required
      comment: "Indicates whether a Purchase Order is required before work can begin. Affects order-to-cash cycle time."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all client accounts. Measures aggregate credit exposure for the portfolio — a key risk management KPI monitored by finance and credit teams."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per client account. Benchmarks credit generosity relative to client tier and informs credit policy calibration."
    - name: "active_client_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN client_account_id END)
      comment: "Number of distinct active client accounts. Core portfolio size KPI used by sales leadership to track book-of-business growth."
    - name: "on_hold_client_count"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'On Hold' THEN client_account_id END)
      comment: "Number of client accounts currently on hold. Elevated counts signal collection or compliance issues requiring immediate intervention."
    - name: "on_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN account_status = 'On Hold' THEN client_account_id END) / NULLIF(COUNT(DISTINCT client_account_id), 0), 2)
      comment: "Percentage of client accounts currently on hold. A rising rate signals deteriorating portfolio health and triggers credit/collections review."
    - name: "msp_client_count"
      expr: COUNT(DISTINCT CASE WHEN msp_provider_name IS NOT NULL AND msp_provider_name <> '' THEN client_account_id END)
      comment: "Number of clients operating under a Managed Service Provider arrangement. Tracks MSP channel penetration within the portfolio."
    - name: "nda_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nda_on_file = TRUE THEN client_account_id END) / NULLIF(COUNT(DISTINCT client_account_id), 0), 2)
      comment: "Percentage of client accounts with an NDA on file. A compliance KPI — low coverage exposes the firm to IP and confidentiality risk."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and accounts-receivable health KPIs derived from client credit profiles. Used by finance, credit, and collections teams to monitor exposure, aging, and risk tier distribution."
  source: "`staffing_hr_ecm_v1`.`client`.`credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (e.g. Active, Expired, Under Review). Primary filter for active credit exposure analysis."
    - name: "risk_tier"
      expr: risk_tier
      comment: "Internal risk classification assigned to the client (e.g. Low, Medium, High). Drives credit limit decisions and collection priority."
    - name: "credit_decision"
      expr: credit_decision
      comment: "Outcome of the most recent credit review (e.g. Approved, Declined, Conditional). Tracks underwriting outcomes over time."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether the client is currently on credit hold. Immediate operational flag for order management and billing teams."
    - name: "bankruptcy_flag"
      expr: bankruptcy_flag
      comment: "Indicates whether the client has a bankruptcy on record. Critical risk flag for credit exposure and collections escalation."
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Indicates whether insurance is required for this client. Compliance dimension for risk management reporting."
    - name: "litigation_flag"
      expr: litigation_flag
      comment: "Indicates whether the client is involved in active litigation. Elevated litigation counts signal legal and financial risk."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the credit profile is denominated. Required for multi-currency portfolio normalization."
    - name: "payment_terms_days"
      expr: payment_terms_days
      comment: "Contractual payment terms in days. Used to segment DSO analysis by payment terms cohort."
    - name: "decision_date_month"
      expr: DATE_TRUNC('month', decision_date)
      comment: "Month of the credit decision. Enables trend analysis of credit approvals and declines over time."
    - name: "last_credit_review_date_month"
      expr: DATE_TRUNC('month', last_credit_review_date)
      comment: "Month of the last credit review. Used to identify stale profiles that require re-evaluation."
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all active credit profiles. Measures aggregate credit exposure — a primary risk KPI for the CFO and credit committee."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(total_outstanding_balance AS DOUBLE))
      comment: "Total outstanding accounts-receivable balance across all clients. Directly tied to cash flow and working capital — a board-level financial health metric."
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total remaining credit available to clients. Measures headroom in the credit portfolio and informs new business capacity decisions."
    - name: "credit_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Percentage of total credit limit currently utilized (outstanding balance / credit limit). A high utilization rate signals elevated collection risk and may trigger credit limit reviews."
    - name: "total_aging_30_days"
      expr: SUM(CAST(aging_30_days_amount AS DOUBLE))
      comment: "Total receivables aged 30 days. Component of the AR aging ladder — used by collections to prioritize outreach."
    - name: "total_aging_60_days"
      expr: SUM(CAST(aging_60_days_amount AS DOUBLE))
      comment: "Total receivables aged 60 days. Elevated 60-day aging signals early-stage collection risk requiring escalation."
    - name: "total_aging_90_plus_days"
      expr: SUM(CAST(aging_90_plus_days_amount AS DOUBLE))
      comment: "Total receivables aged 90+ days. The most critical aging bucket — directly tied to bad debt risk and write-off exposure."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_actual_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across client credit profiles. A core cash conversion efficiency KPI — rising DSO signals deteriorating collections performance."
    - name: "credit_hold_client_count"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN client_account_id END)
      comment: "Number of distinct clients currently on credit hold. Elevated counts block revenue generation and require immediate finance intervention."
    - name: "high_risk_client_count"
      expr: COUNT(DISTINCT CASE WHEN risk_tier = 'High' THEN client_account_id END)
      comment: "Number of clients classified in the highest risk tier. Used by the credit committee to size potential bad debt reserves."
    - name: "aging_90_plus_concentration_pct"
      expr: ROUND(100.0 * SUM(CAST(aging_90_plus_days_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_outstanding_balance AS DOUBLE)), 0), 2)
      comment: "Percentage of total outstanding balance that is 90+ days past due. A rising concentration rate is a leading indicator of bad debt and triggers collections escalation."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_sla_measurement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA compliance and service quality KPIs measured at the client-program level. Used by operations, account management, and client success teams to monitor contractual obligations, penalty exposure, and service delivery performance."
  source: "`staffing_hr_ecm_v1`.`client`.`sla_measurement`"
  dimensions:
    - name: "sla_metric_type"
      expr: sla_metric_type
      comment: "Type of SLA being measured (e.g. Fill Rate, Time-to-Fill, Quality of Service). Primary dimension for SLA performance analysis."
    - name: "measurement_status"
      expr: measurement_status
      comment: "Current status of the SLA measurement record (e.g. Finalized, Pending, Disputed). Filters for actionable vs. in-progress measurements."
    - name: "period_type"
      expr: period_type
      comment: "Reporting period type (e.g. Monthly, Quarterly, Annual). Used to align SLA performance to contractual review cadences."
    - name: "is_compliant"
      expr: is_compliant
      comment: "Boolean flag indicating whether the SLA measurement met the contractual target. Core compliance dimension for SLA scorecards."
    - name: "penalty_triggered"
      expr: penalty_triggered
      comment: "Indicates whether a financial penalty was triggered by this measurement. Directly tied to revenue leakage and client relationship risk."
    - name: "bonus_triggered"
      expr: bonus_triggered
      comment: "Indicates whether a performance bonus was earned by this measurement. Tracks upside incentive attainment."
    - name: "compliance_direction"
      expr: compliance_direction
      comment: "Direction of SLA compliance (e.g. Above Target, Below Target). Provides directional context beyond the binary is_compliant flag."
    - name: "qbr_period_flag"
      expr: qbr_period_flag
      comment: "Indicates whether this measurement falls within a Quarterly Business Review period. Used to filter QBR-specific performance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of penalty and bonus amounts. Required for multi-currency financial impact analysis."
    - name: "period_start_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month the measurement period started. Enables time-series trending of SLA compliance performance."
    - name: "period_end_month"
      expr: DATE_TRUNC('month', period_end_date)
      comment: "Month the measurement period ended. Used for period-over-period SLA performance comparison."
  measures:
    - name: "sla_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_compliant = TRUE THEN sla_measurement_id END) / NULLIF(COUNT(DISTINCT sla_measurement_id), 0), 2)
      comment: "Percentage of SLA measurements that met their contractual target. The primary SLA health KPI — a declining rate triggers client escalation and operational review."
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalties incurred due to SLA breaches. Directly measures revenue leakage from service failures — a critical P&L impact metric."
    - name: "total_bonus_amount"
      expr: SUM(CAST(bonus_amount AS DOUBLE))
      comment: "Total performance bonuses earned from exceeding SLA targets. Measures upside incentive attainment and service excellence."
    - name: "net_sla_financial_impact"
      expr: SUM((CAST(bonus_amount AS DOUBLE)) - (CAST(penalty_amount AS DOUBLE)))
      comment: "Net financial impact of SLA performance (bonuses earned minus penalties incurred). A positive value indicates net incentive attainment; negative signals net penalty exposure requiring operational intervention."
    - name: "avg_fill_rate_actual_pct"
      expr: AVG(CAST(fill_rate_actual AS DOUBLE))
      comment: "Average actual fill rate across all SLA measurements. Measures the staffing organization's ability to fulfill client requisitions — a core operational efficiency KPI."
    - name: "avg_qos_actual_rate_pct"
      expr: AVG(CAST(qos_actual_rate AS DOUBLE))
      comment: "Average actual Quality of Service rate. Measures placement quality and worker retention — directly tied to client satisfaction and contract renewal probability."
    - name: "avg_ttf_actual_days"
      expr: AVG(CAST(ttf_actual_avg_days AS DOUBLE))
      comment: "Average actual Time-to-Fill in days. A key operational speed KPI — elevated TTF signals sourcing bottlenecks and risks client satisfaction and contract compliance."
    - name: "avg_tts_actual_days"
      expr: AVG(CAST(tts_actual_avg_days AS DOUBLE))
      comment: "Average actual Time-to-Submit in days. Measures recruiter responsiveness — a leading indicator of fill rate performance and supplier competitiveness."
    - name: "avg_account_health_score"
      expr: AVG(CAST(account_health_score AS DOUBLE))
      comment: "Average account health score across measured periods. A composite client relationship health indicator used in QBRs and renewal risk assessments."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average percentage variance between actual and target SLA values. Measures the magnitude of SLA deviation — large average variance signals systemic service delivery issues."
    - name: "penalty_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN penalty_triggered = TRUE THEN sla_measurement_id END) / NULLIF(COUNT(DISTINCT sla_measurement_id), 0), 2)
      comment: "Percentage of SLA measurements that triggered a financial penalty. A rising rate signals deteriorating service delivery and escalating financial risk."
    - name: "avg_retention_rate_actual_pct"
      expr: AVG(CAST(retention_rate_actual AS DOUBLE))
      comment: "Average actual worker retention rate across SLA measurements. Retention is a leading indicator of placement quality, client satisfaction, and gross margin stability."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_managed_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program-level KPIs for managed staffing programs. Used by program managers, account executives, and operations leadership to monitor program health, financial targets, and compliance posture."
  source: "`staffing_hr_ecm_v1`.`client`.`managed_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Current lifecycle status of the managed program (e.g. Active, Expired, Pending). Primary filter for active program portfolio analysis."
    - name: "program_type"
      expr: program_type
      comment: "Type of managed program (e.g. MSP, RPO, On-Site). Drives service model segmentation and cost-to-serve analysis."
    - name: "governance_model"
      expr: governance_model
      comment: "Governance structure of the program (e.g. Fully Managed, Co-Managed, Self-Managed). Impacts staffing resource allocation and margin."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA commitment tier for the program. Used to segment performance reporting by service obligation level."
    - name: "program_scope"
      expr: program_scope
      comment: "Geographic or functional scope of the program. Used for capacity planning and regional performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which program financials are denominated. Required for multi-currency portfolio normalization."
    - name: "performance_review_frequency"
      expr: performance_review_frequency
      comment: "Cadence of formal program performance reviews (e.g. Monthly, Quarterly). Indicates governance rigor and client engagement intensity."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the program became effective. Used to track program cohort aging and renewal pipeline."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the program expires. Used to identify at-risk programs requiring renewal action."
    - name: "eor_required"
      expr: eor_required
      comment: "Indicates whether Employer of Record services are required. Drives compliance cost and service complexity segmentation."
    - name: "ic_allowed"
      expr: ic_allowed
      comment: "Indicates whether Independent Contractors are permitted under the program. Affects worker classification risk and compliance posture."
  measures:
    - name: "total_annual_spend_estimate"
      expr: SUM(CAST(annual_spend_estimate AS DOUBLE))
      comment: "Total estimated annual staffing spend across all managed programs. The primary revenue pipeline KPI for program management — used by leadership to size the managed book of business."
    - name: "avg_annual_spend_estimate"
      expr: AVG(CAST(annual_spend_estimate AS DOUBLE))
      comment: "Average estimated annual spend per managed program. Benchmarks program size and informs resource allocation decisions."
    - name: "avg_markup_cap_pct"
      expr: AVG(CAST(markup_cap_pct AS DOUBLE))
      comment: "Average markup cap percentage across managed programs. A margin ceiling KPI — declining averages signal pricing pressure and margin compression risk."
    - name: "avg_msp_fee_pct"
      expr: AVG(CAST(msp_fee_pct AS DOUBLE))
      comment: "Average MSP fee percentage charged across programs. Directly tied to managed services revenue — used to benchmark fee competitiveness and margin contribution."
    - name: "avg_target_fill_rate_pct"
      expr: AVG(CAST(target_fill_rate AS DOUBLE))
      comment: "Average contractual fill rate target across programs. Establishes the performance baseline against which actual fill rates are benchmarked."
    - name: "avg_target_qos_rate_pct"
      expr: AVG(CAST(target_qos_rate AS DOUBLE))
      comment: "Average contractual Quality of Service target across programs. Establishes the quality baseline for SLA compliance monitoring."
    - name: "active_program_count"
      expr: COUNT(DISTINCT CASE WHEN program_status = 'Active' THEN managed_program_id END)
      comment: "Number of currently active managed programs. Core portfolio size KPI for program management leadership."
    - name: "avg_direct_hire_fee_pct"
      expr: AVG(CAST(direct_hire_fee_pct AS DOUBLE))
      comment: "Average direct hire fee percentage across programs. Measures permanent placement fee yield — a key revenue mix indicator for the direct hire business line."
    - name: "avg_conversion_fee_pct"
      expr: AVG(CAST(conversion_fee_pct AS DOUBLE))
      comment: "Average temp-to-perm conversion fee percentage. Tracks conversion revenue yield — rising averages indicate strong permanent placement demand from the temp workforce."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_program_supplier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supplier performance and program participation KPIs within client managed programs. Used by vendor management, program managers, and procurement teams to evaluate supplier quality, compliance, and competitive positioning."
  source: "`staffing_hr_ecm_v1`.`client`.`program_supplier`"
  dimensions:
    - name: "supplier_status"
      expr: supplier_status
      comment: "Current status of the supplier within the program (e.g. Active, Suspended, Terminated). Primary filter for active supplier roster analysis."
    - name: "supplier_tier"
      expr: supplier_tier
      comment: "Tier ranking of the supplier within the program (e.g. Tier 1, Tier 2, Preferred). Drives requisition routing priority and performance expectations."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance posture of the supplier (e.g. Compliant, Non-Compliant, Pending). Critical for risk management and program governance."
    - name: "diversity_certified"
      expr: diversity_certified
      comment: "Indicates whether the supplier holds a diversity certification. Used to track diversity supplier spend and program diversity goals."
    - name: "diversity_certification_type"
      expr: diversity_certification_type
      comment: "Type of diversity certification held (e.g. MBE, WBE, SDVOB). Enables granular diversity spend reporting."
    - name: "insurance_verified"
      expr: insurance_verified
      comment: "Indicates whether the supplier's insurance has been verified. A compliance gate — unverified suppliers represent legal and financial risk."
    - name: "onboarding_complete"
      expr: onboarding_complete
      comment: "Indicates whether the supplier has completed the program onboarding process. Incomplete onboarding blocks requisition routing."
    - name: "preferred_worker_type"
      expr: preferred_worker_type
      comment: "Worker classification the supplier specializes in (e.g. W2, 1099, Corp-to-Corp). Used for worker classification risk segmentation."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which supplier financials are denominated. Required for multi-currency program analysis."
    - name: "enrollment_date_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month the supplier enrolled in the program. Used to track supplier cohort performance and onboarding velocity."
  measures:
    - name: "avg_fill_rate_pct"
      expr: AVG(CAST(fill_rate_percent AS DOUBLE))
      comment: "Average fill rate percentage across program suppliers. Measures supplier effectiveness at fulfilling requisitions — a primary vendor performance KPI used in supplier scorecards and tier reviews."
    - name: "avg_time_to_fill_days"
      expr: AVG(CAST(avg_time_to_fill_days AS DOUBLE))
      comment: "Average time-to-fill in days across program suppliers. Measures supplier speed — a key SLA compliance driver and client satisfaction indicator."
    - name: "avg_fall_off_rate_pct"
      expr: AVG(CAST(fall_off_rate_percent AS DOUBLE))
      comment: "Average fall-off rate percentage across suppliers. Measures placement quality — high fall-off rates signal poor candidate screening and increase client disruption and replacement costs."
    - name: "avg_performance_score"
      expr: AVG(CAST(performance_score AS DOUBLE))
      comment: "Average composite performance score across program suppliers. The primary supplier quality KPI — used in tier reviews, preferred supplier decisions, and program renewal negotiations."
    - name: "avg_markup_cap_pct"
      expr: AVG(CAST(markup_cap_percent AS DOUBLE))
      comment: "Average markup cap percentage across program suppliers. Measures pricing ceiling compliance — suppliers exceeding caps represent contract violations and margin risk."
    - name: "avg_max_bill_rate"
      expr: AVG(CAST(max_bill_rate AS DOUBLE))
      comment: "Average maximum bill rate authorized across program suppliers. Used to benchmark rate card competitiveness and identify outlier pricing."
    - name: "compliant_supplier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN compliance_status = 'Compliant' THEN program_supplier_id END) / NULLIF(COUNT(DISTINCT program_supplier_id), 0), 2)
      comment: "Percentage of program suppliers in compliant status. A declining rate signals growing compliance risk across the supplier network and triggers vendor management intervention."
    - name: "diversity_supplier_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN diversity_certified = TRUE THEN program_supplier_id END) / NULLIF(COUNT(DISTINCT program_supplier_id), 0), 2)
      comment: "Percentage of program suppliers that are diversity-certified. Tracks progress against client diversity spend commitments and ESG reporting requirements."
    - name: "insurance_verified_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN insurance_verified = TRUE THEN program_supplier_id END) / NULLIF(COUNT(DISTINCT program_supplier_id), 0), 2)
      comment: "Percentage of program suppliers with verified insurance. A compliance health KPI — unverified suppliers represent legal liability and should be flagged for immediate remediation."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client engagement activity and relationship health KPIs. Used by account managers, sales leadership, and client success teams to monitor interaction cadence, pipeline progression, and NPS-linked engagement outcomes."
  source: "`staffing_hr_ecm_v1`.`client`.`engagement`"
  dimensions:
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of client engagement activity (e.g. QBR, Sales Call, On-Site Visit, Email). Primary dimension for activity mix analysis."
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the engagement (e.g. Completed, Scheduled, Cancelled). Used to filter for completed vs. planned activity."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the engagement (e.g. In-Person, Video, Phone, Email). Tracks channel mix and effectiveness."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the engagement (e.g. Won, Lost, Follow-Up Required). Directly linked to pipeline conversion and revenue impact."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Sales pipeline stage associated with the engagement. Used to track deal progression and forecast conversion probability."
    - name: "is_qbr"
      expr: is_qbr
      comment: "Indicates whether the engagement was a Quarterly Business Review. QBR cadence is a leading indicator of client retention and contract renewal."
    - name: "is_executive_sponsor_present"
      expr: is_executive_sponsor_present
      comment: "Indicates whether an executive sponsor attended the engagement. Executive presence correlates with higher deal velocity and retention rates."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Indicates whether a follow-up action is required. Tracks open action items that could impact client satisfaction if unresolved."
    - name: "assigned_staff_role"
      expr: assigned_staff_role
      comment: "Role of the staff member who conducted the engagement (e.g. Account Manager, Recruiter, Director). Used for activity attribution and workload analysis."
    - name: "engagement_month"
      expr: DATE_TRUNC('month', engagement_timestamp)
      comment: "Month the engagement occurred. Enables time-series trending of client interaction cadence."
    - name: "scheduled_date_month"
      expr: DATE_TRUNC('month', scheduled_date)
      comment: "Month the engagement was scheduled. Used to compare planned vs. actual engagement activity."
  measures:
    - name: "total_engagement_count"
      expr: COUNT(DISTINCT engagement_id)
      comment: "Total number of distinct client engagements. Measures relationship activity volume — a leading indicator of client retention and pipeline health."
    - name: "qbr_count"
      expr: COUNT(DISTINCT CASE WHEN is_qbr = TRUE THEN engagement_id END)
      comment: "Number of Quarterly Business Reviews conducted. QBR cadence is a contractual obligation for many managed programs — low counts signal relationship neglect and renewal risk."
    - name: "avg_engagement_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of client engagements in minutes. Longer engagements typically indicate deeper strategic discussions — a proxy for relationship depth and deal complexity."
    - name: "follow_up_required_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN engagement_id END) / NULLIF(COUNT(DISTINCT engagement_id), 0), 2)
      comment: "Percentage of engagements requiring follow-up action. A high rate with low resolution velocity signals account management capacity issues and client satisfaction risk."
    - name: "executive_sponsor_engagement_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_executive_sponsor_present = TRUE THEN engagement_id END) / NULLIF(COUNT(DISTINCT engagement_id), 0), 2)
      comment: "Percentage of engagements with executive sponsor presence. Higher executive engagement rates correlate with stronger client relationships and faster deal progression."
    - name: "avg_nps_score"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score captured during engagements. A direct measure of client satisfaction and loyalty — a leading indicator of contract renewal and expansion revenue."
    - name: "unique_clients_engaged"
      expr: COUNT(DISTINCT client_account_id)
      comment: "Number of distinct client accounts with at least one engagement. Measures breadth of active relationship coverage — gaps indicate accounts at risk of churn due to neglect."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_account_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client account segmentation and wallet share KPIs. Used by sales strategy, account management, and finance to analyze revenue potential, margin targets, and segment-level performance across the client portfolio."
  source: "`staffing_hr_ecm_v1`.`client`.`account_segment`"
  dimensions:
    - name: "segment_tier"
      expr: segment_tier
      comment: "Current segment tier of the client account (e.g. Strategic, Growth, Transactional). Primary dimension for portfolio prioritization and resource allocation."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment record (e.g. Active, Expired). Used to filter for current segmentation data."
    - name: "primary_service_line"
      expr: primary_service_line
      comment: "Primary staffing service line for the account (e.g. Light Industrial, IT, Healthcare). Enables service line revenue mix analysis."
    - name: "vertical_industry"
      expr: vertical_industry
      comment: "Industry vertical of the client account. Used for vertical market performance benchmarking and growth strategy."
    - name: "geographic_market"
      expr: geographic_market
      comment: "Geographic market of the account segment. Enables regional revenue and margin analysis."
    - name: "annual_revenue_band"
      expr: annual_revenue_band
      comment: "Revenue band of the client company. Used to segment accounts by size for targeted sales and service strategies."
    - name: "headcount_band"
      expr: headcount_band
      comment: "Employee headcount band of the client. Proxy for staffing demand potential and account size."
    - name: "preferred_supplier_status"
      expr: preferred_supplier_status
      comment: "Preferred supplier designation for the account (e.g. Preferred, Approved, Conditional). Tracks competitive positioning within the client's supplier ecosystem."
    - name: "msp_program_flag"
      expr: msp_program_flag
      comment: "Indicates whether the account operates under an MSP program. Used to segment managed vs. direct service delivery."
    - name: "rpo_program_flag"
      expr: rpo_program_flag
      comment: "Indicates whether the account has an RPO program. Tracks recruitment process outsourcing penetration within the portfolio."
    - name: "vms_program_flag"
      expr: vms_program_flag
      comment: "Indicates whether the account uses a VMS platform. Impacts requisition routing complexity and technology cost."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned at the segment level. Used to align service delivery resources with contractual obligations."
    - name: "segment_review_date_month"
      expr: DATE_TRUNC('month', segment_review_date)
      comment: "Month of the last segment review. Used to identify stale segmentations that may no longer reflect current account potential."
  measures:
    - name: "total_estimated_annual_staffing_spend"
      expr: SUM(CAST(estimated_annual_staffing_spend AS DOUBLE))
      comment: "Total estimated annual staffing spend across all account segments. The primary revenue potential KPI — used by sales leadership to size the addressable market and prioritize account investment."
    - name: "avg_estimated_annual_staffing_spend"
      expr: AVG(CAST(estimated_annual_staffing_spend AS DOUBLE))
      comment: "Average estimated annual staffing spend per account segment. Benchmarks account value and informs tiering decisions."
    - name: "avg_gross_margin_target_pct"
      expr: AVG(CAST(gross_margin_target_pct AS DOUBLE))
      comment: "Average gross margin target percentage across account segments. The primary margin expectation KPI — used by finance and pricing teams to set and monitor profitability thresholds."
    - name: "avg_markup_pct"
      expr: AVG(CAST(markup_pct AS DOUBLE))
      comment: "Average markup percentage across account segments. Measures pricing yield — declining averages signal competitive pricing pressure and margin compression."
    - name: "avg_wallet_share_pct"
      expr: AVG(CAST(wallet_share_pct AS DOUBLE))
      comment: "Average wallet share percentage captured within each account segment. Measures penetration of the client's total staffing spend — a key growth opportunity indicator for account managers."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across account segments. Measures aggregate credit exposure at the segment level — used by finance to monitor risk concentration."
    - name: "avg_conversion_fee_pct"
      expr: AVG(CAST(conversion_fee_pct AS DOUBLE))
      comment: "Average temp-to-perm conversion fee percentage across segments. Tracks conversion revenue yield by segment tier and service line."
    - name: "avg_direct_hire_fee_pct"
      expr: AVG(CAST(direct_hire_fee_pct AS DOUBLE))
      comment: "Average direct hire fee percentage across segments. Measures permanent placement fee yield — a key revenue mix indicator for the direct hire business line."
    - name: "avg_fall_off_rate_pct"
      expr: AVG(CAST(fall_off_rate_pct AS DOUBLE))
      comment: "Average fall-off rate percentage across account segments. Measures placement quality at the segment level — high fall-off rates increase replacement costs and damage client relationships."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`client_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate card pricing KPIs at the client level. Used by pricing, sales, and finance teams to monitor bill rate levels, markup yield, and rate card compliance across the client portfolio."
  source: "`staffing_hr_ecm_v1`.`client`.`client_rate_card`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate card (e.g. Approved, Pending, Rejected). Used to filter for active, approved pricing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the rate card is denominated. Required for multi-currency pricing analysis."
    - name: "burden_rate_included"
      expr: burden_rate_included
      comment: "Indicates whether burden costs are included in the bill rate. Affects gross margin calculation and pricing comparability."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the rate card became effective. Used to track pricing changes over time and identify rate escalation trends."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the rate card expires. Used to identify rate cards requiring renewal and assess pricing pipeline."
    - name: "approved_date_month"
      expr: DATE_TRUNC('month', approved_date)
      comment: "Month the rate card was approved. Used to measure rate card approval cycle time."
  measures:
    - name: "avg_bill_rate_regular"
      expr: AVG(CAST(bill_rate_regular AS DOUBLE))
      comment: "Average regular bill rate across client rate cards. The primary pricing benchmark KPI — used by pricing teams to monitor rate competitiveness and identify outliers."
    - name: "avg_bill_rate_ot"
      expr: AVG(CAST(bill_rate_ot AS DOUBLE))
      comment: "Average overtime bill rate across client rate cards. Overtime rate yield impacts gross margin on high-OT accounts — monitored by finance and pricing."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across client rate cards. Measures pricing yield — a core margin driver monitored by sales leadership and finance."
    - name: "avg_spread_amount"
      expr: AVG(CAST(spread_amount AS DOUBLE))
      comment: "Average spread (bill rate minus pay rate) across rate cards. Measures gross margin per hour in dollar terms — a direct profitability KPI."
    - name: "avg_burden_rate_percentage"
      expr: AVG(CAST(burden_rate_percentage AS DOUBLE))
      comment: "Average burden rate percentage across rate cards. Measures employer cost load — used by finance to validate margin assumptions in pricing models."
    - name: "avg_max_bill_rate"
      expr: AVG(CAST(max_bill_rate AS DOUBLE))
      comment: "Average maximum bill rate ceiling across rate cards. Used to benchmark rate cap levels and identify accounts with restrictive pricing constraints."
    - name: "avg_min_bill_rate"
      expr: AVG(CAST(min_bill_rate AS DOUBLE))
      comment: "Average minimum bill rate floor across rate cards. Used to ensure pricing floors are maintained and margin thresholds are not breached."
    - name: "avg_conversion_fee_percentage"
      expr: AVG(CAST(conversion_fee_percentage AS DOUBLE))
      comment: "Average temp-to-perm conversion fee percentage across rate cards. Tracks conversion revenue yield at the rate card level."
    - name: "avg_direct_placement_fee_percentage"
      expr: AVG(CAST(direct_placement_fee_percentage AS DOUBLE))
      comment: "Average direct placement fee percentage across rate cards. Measures permanent placement fee yield — a key revenue mix indicator for the direct hire business line."
$$;