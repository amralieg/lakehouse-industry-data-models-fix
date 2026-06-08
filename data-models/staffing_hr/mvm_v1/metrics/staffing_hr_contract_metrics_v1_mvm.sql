-- Metric views for domain: contract | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 22:27:45

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_msa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Master Service Agreement (MSA) portfolio health metrics. Tracks active contract coverage, financial exposure, liability caps, and compliance requirements across client accounts. Used by legal, finance, and executive leadership to govern client contract risk and renewal pipeline."
  source: "`staffing_hr_ecm_v1`.`contract`.`msa`"
  dimensions:
    - name: "msa_status"
      expr: msa_status
      comment: "Current lifecycle status of the MSA (e.g. Active, Expired, Terminated, Pending). Primary filter for portfolio health analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the MSA. Used to segment risk and compliance exposure by geography."
    - name: "dispute_resolution_method"
      expr: dispute_resolution_method
      comment: "Method specified for dispute resolution (e.g. Arbitration, Litigation, Mediation). Informs legal risk profiling."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the MSA auto-renews. Critical for renewal pipeline forecasting and opt-out deadline management."
    - name: "nda_attached_flag"
      expr: nda_attached_flag
      comment: "Indicates whether an NDA is attached to the MSA. Used for compliance completeness audits."
    - name: "sla_attached_flag"
      expr: sla_attached_flag
      comment: "Indicates whether an SLA is attached to the MSA. Used to assess service commitment coverage."
    - name: "payment_terms_net_days"
      expr: payment_terms_net_days
      comment: "Payment terms in net days (e.g. Net 30, Net 60). Used for cash flow and DSO analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the MSA became effective. Used for cohort and vintage analysis of contract portfolio."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the MSA expires. Used for renewal pipeline and expiration risk forecasting."
    - name: "liability_cap_currency"
      expr: liability_cap_currency
      comment: "Currency of the liability cap. Used for multi-currency financial risk normalization."
  measures:
    - name: "active_msa_count"
      expr: COUNT(CASE WHEN msa_status = 'Active' THEN msa_id END)
      comment: "Number of currently active MSAs. Core portfolio size KPI used by legal and executive leadership to track client contract coverage."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total aggregate liability cap exposure across all MSAs. Critical financial risk metric for CFO and legal leadership to size maximum contractual exposure."
    - name: "avg_liability_cap_amount"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap per MSA. Benchmarks typical contractual risk exposure per client agreement."
    - name: "total_conversion_fee_revenue_potential"
      expr: SUM(CAST(conversion_fee_percentage AS DOUBLE))
      comment: "Sum of conversion fee percentages across MSAs. Proxy for potential permanent placement revenue embedded in the contract portfolio."
    - name: "avg_conversion_fee_percentage"
      expr: AVG(CAST(conversion_fee_percentage AS DOUBLE))
      comment: "Average conversion fee percentage across MSAs. Used by sales leadership to benchmark fee competitiveness and negotiate new agreements."
    - name: "msa_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN msa_status = 'Active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN msa_id END)
      comment: "Number of active MSAs expiring within the next 90 days. Renewal pipeline urgency metric used by account management and legal teams."
    - name: "auto_renewal_msa_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN msa_id END)
      comment: "Number of MSAs with auto-renewal enabled. Used to forecast contract continuity and identify opt-out deadline risks."
    - name: "msa_without_nda_count"
      expr: COUNT(CASE WHEN nda_attached_flag = FALSE OR nda_attached_flag IS NULL THEN msa_id END)
      comment: "Number of MSAs missing an attached NDA. Compliance gap metric used by legal to prioritize remediation."
    - name: "msa_without_sla_count"
      expr: COUNT(CASE WHEN sla_attached_flag = FALSE OR sla_attached_flag IS NULL THEN msa_id END)
      comment: "Number of MSAs without an attached SLA. Service commitment coverage gap metric for operations and client success leadership."
    - name: "total_workers_comp_minimum_exposure"
      expr: SUM(CAST(workers_comp_minimum_usd AS DOUBLE))
      comment: "Total minimum workers compensation insurance required across all MSAs. Risk management KPI for insurance compliance oversight."
    - name: "total_general_liability_minimum_exposure"
      expr: SUM(CAST(general_liability_minimum_usd AS DOUBLE))
      comment: "Total minimum general liability insurance required across all MSAs. Aggregate insurance compliance exposure metric."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_sow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Statement of Work (SOW) portfolio metrics covering contract value, workforce scope, delivery timelines, and compliance requirements. Used by delivery, finance, and executive leadership to manage project-based engagements and revenue pipeline."
  source: "`staffing_hr_ecm_v1`.`contract`.`sow`"
  dimensions:
    - name: "sow_status"
      expr: sow_status
      comment: "Current lifecycle status of the SOW (e.g. Active, Draft, Completed, Terminated). Primary filter for portfolio health."
    - name: "sow_type"
      expr: sow_type
      comment: "Type of SOW engagement (e.g. Time & Materials, Fixed Price, Managed Service). Used to segment revenue model and margin analysis."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model used in the SOW. Drives revenue recognition and margin analysis by engagement type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SOW contract value. Required for multi-currency revenue reporting."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Frequency of invoicing (e.g. Weekly, Monthly, Milestone). Used for cash flow forecasting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the SOW auto-renews. Used for renewal pipeline and revenue continuity forecasting."
    - name: "renewal_eligible_flag"
      expr: renewal_eligible_flag
      comment: "Indicates whether the SOW is eligible for renewal. Used to size the renewable revenue base."
    - name: "nda_required_flag"
      expr: nda_required_flag
      comment: "Indicates whether an NDA is required for the SOW. Compliance completeness tracking."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the SOW engagement starts. Used for revenue ramp and cohort analysis."
    - name: "end_date_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the SOW engagement ends. Used for revenue cliff and renewal pipeline forecasting."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the SOW. Used for geographic risk and compliance segmentation."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value (TCV) across all SOWs. Primary revenue pipeline KPI for finance and executive leadership."
    - name: "avg_contract_value"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average contract value per SOW. Used to benchmark deal size and identify upsell opportunities."
    - name: "active_sow_count"
      expr: COUNT(CASE WHEN sow_status = 'Active' THEN sow_id END)
      comment: "Number of currently active SOWs. Core delivery portfolio size metric."
    - name: "total_active_contract_value"
      expr: SUM(CASE WHEN sow_status = 'Active' THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of active SOWs only. Represents current revenue under management for delivery and finance leadership."
    - name: "total_estimated_fte_count"
      expr: SUM(CAST(estimated_fte_count AS DOUBLE))
      comment: "Total estimated FTE headcount across all SOWs. Workforce demand planning metric for resource management and capacity forecasting."
    - name: "avg_estimated_fte_count"
      expr: AVG(CAST(estimated_fte_count AS DOUBLE))
      comment: "Average estimated FTE count per SOW. Used to benchmark engagement size and staffing intensity."
    - name: "sow_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN sow_status = 'Active' AND end_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN sow_id END)
      comment: "Number of active SOWs ending within 90 days. Revenue cliff and renewal urgency metric for account management."
    - name: "renewable_sow_count"
      expr: COUNT(CASE WHEN renewal_eligible_flag = TRUE AND sow_status = 'Active' THEN sow_id END)
      comment: "Number of active SOWs eligible for renewal. Quantifies the renewable revenue base for sales and account management planning."
    - name: "total_renewable_contract_value"
      expr: SUM(CASE WHEN renewal_eligible_flag = TRUE THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of renewal-eligible SOWs. Sizes the renewable revenue opportunity for strategic planning."
    - name: "terminated_sow_count"
      expr: COUNT(CASE WHEN sow_status = 'Terminated' THEN sow_id END)
      comment: "Number of terminated SOWs. Early termination rate input metric for client health and delivery quality monitoring."
    - name: "total_terminated_contract_value"
      expr: SUM(CASE WHEN sow_status = 'Terminated' THEN CAST(total_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value lost to SOW terminations. Revenue at risk metric for executive and client success leadership."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract rate schedule metrics covering bill rates, pay rates, margins, markups, and spread across job categories, skill levels, and geographies. Used by pricing, finance, and operations leadership to govern rate competitiveness, margin health, and compliance with approved rate cards."
  source: "`staffing_hr_ecm_v1`.`contract`.`contract_rate_schedule`"
  dimensions:
    - name: "rate_schedule_type"
      expr: rate_schedule_type
      comment: "Type of rate schedule (e.g. Standard, Premium, VMS). Used to segment margin and pricing analysis by engagement model."
    - name: "job_category"
      expr: job_category
      comment: "Job category covered by the rate schedule. Primary dimension for workforce pricing analysis."
    - name: "skill_level"
      expr: skill_level
      comment: "Skill level tier (e.g. Junior, Mid, Senior). Used to analyze rate and margin variation by worker seniority."
    - name: "labor_classification"
      expr: labor_classification
      comment: "Labor classification (e.g. W2, 1099, Corp-to-Corp). Critical for compliance and margin analysis by worker type."
    - name: "rate_unit"
      expr: rate_unit
      comment: "Unit of rate measurement (e.g. Hourly, Daily, Weekly). Required for rate normalization and comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate schedule. Required for multi-currency pricing analysis."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the rate schedule. Used for regional pricing and margin benchmarking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the rate schedule (e.g. Approved, Pending, Rejected). Used for governance and compliance tracking."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the rate schedule is currently active. Primary filter for live pricing analysis."
    - name: "effective_start_date_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the rate schedule became effective. Used for rate trend and pricing cohort analysis."
  measures:
    - name: "avg_bill_rate"
      expr: AVG(CAST(bill_rate AS DOUBLE))
      comment: "Average bill rate across rate schedules. Core pricing KPI used by sales and finance to benchmark client-facing rates."
    - name: "avg_pay_rate"
      expr: AVG(CAST(pay_rate AS DOUBLE))
      comment: "Average pay rate across rate schedules. Used by operations and finance to benchmark worker compensation levels."
    - name: "avg_spread"
      expr: AVG(CAST(spread AS DOUBLE))
      comment: "Average spread (bill rate minus pay rate) across rate schedules. Direct margin contribution metric for pricing and finance leadership."
    - name: "total_spread"
      expr: SUM(CAST(spread AS DOUBLE))
      comment: "Total spread across all rate schedules. Aggregate gross margin proxy for the contract rate portfolio."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage across rate schedules. Used by pricing leadership to benchmark and govern markup levels by segment."
    - name: "avg_gross_margin_percentage"
      expr: AVG(CAST(gross_margin_percentage AS DOUBLE))
      comment: "Average gross margin percentage across rate schedules. Primary profitability KPI for finance and executive leadership."
    - name: "avg_burden_rate"
      expr: AVG(CAST(burden_rate AS DOUBLE))
      comment: "Average burden rate across rate schedules. Used by finance to assess total employer cost and true margin after burden."
    - name: "avg_per_diem_allowance"
      expr: AVG(CAST(per_diem_allowance AS DOUBLE))
      comment: "Average per diem allowance across rate schedules. Used by finance to track travel and living cost commitments embedded in contracts."
    - name: "active_rate_schedule_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN contract_rate_schedule_id END)
      comment: "Number of currently active rate schedules. Portfolio size metric for pricing governance and rate card management."
    - name: "unapproved_rate_schedule_count"
      expr: COUNT(CASE WHEN approval_status != 'Approved' AND is_active = TRUE THEN contract_rate_schedule_id END)
      comment: "Number of active rate schedules not yet approved. Governance compliance gap metric for finance and legal review."
    - name: "avg_overtime_multiplier"
      expr: AVG(CAST(overtime_multiplier AS DOUBLE))
      comment: "Average overtime multiplier across rate schedules. Used by finance to model overtime cost exposure in workforce contracts."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract amendment activity metrics tracking volume, financial impact, approval timelines, and compliance of contract changes. Used by legal, finance, and operations leadership to govern contract change management and assess financial exposure from amendments."
  source: "`staffing_hr_ecm_v1`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected, Executed). Primary filter for amendment pipeline analysis."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of amendment (e.g. Rate Change, Scope Extension, Termination). Used to categorize change drivers and financial impact."
    - name: "initiated_by"
      expr: initiated_by
      comment: "Party who initiated the amendment (e.g. Client, Vendor, Internal). Used to analyze change request patterns and accountability."
    - name: "requires_rate_schedule_update"
      expr: requires_rate_schedule_update
      comment: "Indicates whether the amendment requires a rate schedule update. Used to prioritize pricing team workload."
    - name: "requires_sla_update"
      expr: requires_sla_update
      comment: "Indicates whether the amendment requires an SLA update. Used to prioritize operations and legal review workload."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the amendment is currently active. Used to filter live vs. historical amendment analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the amendment became effective. Used for amendment volume trend analysis."
    - name: "initiated_date_month"
      expr: DATE_TRUNC('MONTH', initiated_date)
      comment: "Month the amendment was initiated. Used for change request volume trending and backlog analysis."
    - name: "finance_approver"
      expr: finance_approver
      comment: "Name of the finance approver for the amendment. Used for approval workload and accountability analysis."
  measures:
    - name: "total_amendment_count"
      expr: COUNT(amendment_id)
      comment: "Total number of amendments. Baseline contract change volume metric for legal and operations leadership."
    - name: "total_financial_impact_amount"
      expr: SUM(CAST(financial_impact_amount AS DOUBLE))
      comment: "Total financial impact of all amendments. Critical metric for finance leadership to quantify contract change exposure and revenue/cost adjustments."
    - name: "avg_financial_impact_amount"
      expr: AVG(CAST(financial_impact_amount AS DOUBLE))
      comment: "Average financial impact per amendment. Used to benchmark the materiality of contract changes and prioritize review resources."
    - name: "pending_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Pending' THEN amendment_id END)
      comment: "Number of amendments currently pending approval. Backlog metric for legal and finance teams to manage review queues."
    - name: "pending_financial_impact_amount"
      expr: SUM(CASE WHEN amendment_status = 'Pending' THEN CAST(financial_impact_amount AS DOUBLE) ELSE 0 END)
      comment: "Total financial impact of pending amendments. Quantifies unresolved financial exposure awaiting approval decisions."
    - name: "rejected_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Rejected' THEN amendment_id END)
      comment: "Number of rejected amendments. Quality and governance metric indicating contract change friction or misalignment."
    - name: "amendments_requiring_rate_update_count"
      expr: COUNT(CASE WHEN requires_rate_schedule_update = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring a rate schedule update. Pricing team workload and prioritization metric."
    - name: "amendments_requiring_sla_update_count"
      expr: COUNT(CASE WHEN requires_sla_update = TRUE THEN amendment_id END)
      comment: "Number of amendments requiring an SLA update. Operations and legal workload metric for service commitment governance."
    - name: "avg_days_to_finance_approval"
      expr: AVG(CAST(DATEDIFF(finance_approval_date, initiated_date) AS DOUBLE))
      comment: "Average number of days from amendment initiation to finance approval. Process efficiency KPI for contract change management cycle time."
    - name: "avg_days_to_execution"
      expr: AVG(CAST(DATEDIFF(execution_date, initiated_date) AS DOUBLE))
      comment: "Average number of days from amendment initiation to execution. End-to-end amendment cycle time metric for legal and operations efficiency."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor agreement portfolio metrics covering supplier contract coverage, financial risk, compliance requirements, and markup governance. Used by procurement, legal, and executive leadership to manage vendor relationships and supply chain contract risk."
  source: "`staffing_hr_ecm_v1`.`contract`.`vendor_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the vendor agreement (e.g. Active, Expired, Terminated). Primary filter for active vendor contract portfolio."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of vendor agreement (e.g. Subcontractor, Staffing Agency, MSP). Used to segment vendor relationship and risk analysis."
    - name: "tier_classification"
      expr: tier_classification
      comment: "Vendor tier classification (e.g. Tier 1, Tier 2, Preferred). Used for strategic vendor segmentation and spend analysis."
    - name: "diversity_certification_status"
      expr: diversity_certification_status
      comment: "Diversity certification status of the vendor. Used for supplier diversity program tracking and compliance reporting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the vendor agreement auto-renews. Used for renewal pipeline and opt-out deadline management."
    - name: "everify_required_flag"
      expr: everify_required_flag
      comment: "Indicates whether E-Verify is required under the agreement. Compliance tracking for employment eligibility verification."
    - name: "fee_schedule_type"
      expr: fee_schedule_type
      comment: "Type of fee schedule in the vendor agreement. Used to segment vendor cost structure analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the vendor agreement. Used for geographic risk and compliance segmentation."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the vendor agreement became effective. Used for vendor onboarding trend and cohort analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the vendor agreement expires. Used for renewal pipeline and expiration risk forecasting."
  measures:
    - name: "active_vendor_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN vendor_agreement_id END)
      comment: "Number of currently active vendor agreements. Core supplier network size metric for procurement and operations leadership."
    - name: "total_liability_cap_amount"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total aggregate liability cap across all vendor agreements. Financial risk exposure metric for CFO and legal leadership."
    - name: "avg_liability_cap_amount"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap per vendor agreement. Used to benchmark contractual risk exposure per supplier relationship."
    - name: "avg_markup_cap_percentage"
      expr: AVG(CAST(markup_cap_percentage AS DOUBLE))
      comment: "Average markup cap percentage across vendor agreements. Pricing governance metric ensuring vendor markups stay within contracted limits."
    - name: "vendor_agreements_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN vendor_agreement_id END)
      comment: "Number of active vendor agreements expiring within 90 days. Supply chain continuity risk metric for procurement leadership."
    - name: "total_general_liability_minimum_exposure"
      expr: SUM(CAST(general_liability_minimum_usd AS DOUBLE))
      comment: "Total minimum general liability insurance required across all vendor agreements. Aggregate insurance compliance exposure metric."
    - name: "total_workers_comp_minimum_exposure"
      expr: SUM(CAST(workers_comp_minimum_usd AS DOUBLE))
      comment: "Total minimum workers compensation insurance required across vendor agreements. Risk management KPI for insurance compliance oversight."
    - name: "total_errors_omissions_minimum_exposure"
      expr: SUM(CAST(errors_omissions_minimum_usd AS DOUBLE))
      comment: "Total minimum errors and omissions insurance required across vendor agreements. Professional liability risk exposure metric."
    - name: "diversity_certified_vendor_count"
      expr: COUNT(CASE WHEN diversity_certification_status IS NOT NULL AND diversity_certification_status != 'None' THEN vendor_agreement_id END)
      comment: "Number of vendor agreements with diversity-certified suppliers. Supplier diversity program performance metric for ESG and compliance reporting."
    - name: "terminated_vendor_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN vendor_agreement_id END)
      comment: "Number of terminated vendor agreements. Supplier attrition and relationship health metric for procurement leadership."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract renewal pipeline and outcome metrics tracking renewal volume, rate changes, negotiation timelines, and opt-out activity. Used by account management, legal, and executive leadership to manage contract continuity, revenue retention, and renewal process efficiency."
  source: "`staffing_hr_ecm_v1`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g. Pending, In Negotiation, Completed, Opted Out). Primary filter for renewal pipeline analysis."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g. Auto, Negotiated, Extension). Used to segment renewal activity by process type."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the renewal process (e.g. Renewed, Terminated, Opted Out). Used for win/loss analysis of contract renewals."
    - name: "negotiation_status"
      expr: negotiation_status
      comment: "Current status of renewal negotiations. Used to track negotiation pipeline and identify stalled renewals."
    - name: "priority"
      expr: priority
      comment: "Priority level of the renewal (e.g. High, Medium, Low). Used to triage renewal workload and focus account management effort."
    - name: "auto_renewal_enabled_flag"
      expr: auto_renewal_enabled_flag
      comment: "Indicates whether auto-renewal is enabled. Used to segment automatic vs. negotiated renewal pipelines."
    - name: "opt_out_received_flag"
      expr: opt_out_received_flag
      comment: "Indicates whether an opt-out notice was received. Used to track contract termination signals and revenue at risk."
    - name: "sla_review_required_flag"
      expr: sla_review_required_flag
      comment: "Indicates whether an SLA review is required as part of the renewal. Used to prioritize operations and legal review workload."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the renewed contract becomes effective. Used for renewal cohort and revenue continuity analysis."
    - name: "expiration_date_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the contract being renewed expires. Used for renewal deadline pipeline management."
  measures:
    - name: "total_renewal_count"
      expr: COUNT(renewal_id)
      comment: "Total number of contract renewals in the pipeline. Baseline renewal activity volume metric."
    - name: "renewals_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN renewal_status NOT IN ('Completed', 'Opted Out') AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN renewal_id END)
      comment: "Number of open renewals with contracts expiring within 90 days. Urgency pipeline metric for account management and legal teams."
    - name: "opt_out_received_count"
      expr: COUNT(CASE WHEN opt_out_received_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals where an opt-out notice was received. Revenue at risk and client churn signal metric for executive leadership."
    - name: "avg_rate_change_percentage"
      expr: AVG(CAST(rate_change_percentage AS DOUBLE))
      comment: "Average rate change percentage across renewals. Pricing trend metric used by finance and sales to assess rate escalation or compression at renewal."
    - name: "total_rate_change_percentage"
      expr: SUM(CAST(rate_change_percentage AS DOUBLE))
      comment: "Sum of rate change percentages across renewals. Aggregate pricing movement indicator for portfolio-level rate trend analysis."
    - name: "avg_days_negotiation_cycle"
      expr: AVG(CAST(DATEDIFF(negotiation_end_date, negotiation_start_date) AS DOUBLE))
      comment: "Average number of days to complete renewal negotiations. Process efficiency KPI for legal and account management teams."
    - name: "avg_days_to_renewal_outcome"
      expr: AVG(CAST(DATEDIFF(outcome_date, trigger_date) AS DOUBLE))
      comment: "Average number of days from renewal trigger to final outcome. End-to-end renewal cycle time metric for operational efficiency benchmarking."
    - name: "successfully_renewed_count"
      expr: COUNT(CASE WHEN outcome = 'Renewed' THEN renewal_id END)
      comment: "Number of contracts successfully renewed. Revenue retention metric and primary KPI for account management performance."
    - name: "renewal_with_sla_review_count"
      expr: COUNT(CASE WHEN sla_review_required_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals requiring SLA review. Operations workload planning metric for service commitment governance at renewal."
    - name: "alert_sent_count"
      expr: COUNT(CASE WHEN alert_sent_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals where an expiration alert was sent. Process compliance metric ensuring timely renewal notifications are issued."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Level Agreement (SLA) portfolio metrics covering penalty exposure, target values, breach thresholds, and compliance governance. Used by operations, legal, and executive leadership to manage service commitment risk and financial penalty exposure."
  source: "`staffing_hr_ecm_v1`.`contract`.`sla`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA (e.g. Active, Expired, Breached, Suspended). Primary filter for active SLA portfolio analysis."
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the SLA metric being measured (e.g. Fill Rate, Time-to-Fill, Quality Score). Used to segment performance by service commitment type."
    - name: "penalty_type"
      expr: penalty_type
      comment: "Type of penalty for SLA breach (e.g. Financial, Service Credit, Termination Right). Used to assess severity of breach consequences."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "Frequency of SLA measurement (e.g. Weekly, Monthly, Quarterly). Used to segment reporting cadence and breach detection timing."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Indicates whether escalation is required for this SLA. Used to prioritize high-risk SLA monitoring."
    - name: "reporting_required_flag"
      expr: reporting_required_flag
      comment: "Indicates whether formal reporting is required for this SLA. Used for compliance and client reporting workload planning."
    - name: "auto_renew_flag"
      expr: auto_renew_flag
      comment: "Indicates whether the SLA auto-renews. Used for SLA continuity and renewal pipeline management."
    - name: "job_category_scope"
      expr: job_category_scope
      comment: "Job category scope of the SLA. Used to segment service commitment analysis by workforce category."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the SLA. Used for regional service commitment and penalty exposure analysis."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the SLA became effective. Used for SLA portfolio vintage and trend analysis."
  measures:
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN sla_status = 'Active' THEN sla_id END)
      comment: "Number of currently active SLAs. Core service commitment portfolio size metric for operations and legal leadership."
    - name: "total_penalty_amount_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amount exposure across all SLAs. Critical financial risk metric for CFO and legal leadership to size maximum SLA breach cost."
    - name: "avg_penalty_amount"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per SLA. Used to benchmark financial consequence severity per service commitment."
    - name: "total_penalty_cap_amount"
      expr: SUM(CAST(penalty_cap_amount AS DOUBLE))
      comment: "Total capped penalty exposure across all SLAs. Maximum financial liability metric for risk management and contract negotiation."
    - name: "avg_penalty_percentage"
      expr: AVG(CAST(penalty_percentage AS DOUBLE))
      comment: "Average penalty percentage across SLAs. Used to benchmark the financial severity of SLA breach penalties relative to contract value."
    - name: "avg_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across all active SLAs. Used to benchmark service commitment levels and assess target realism."
    - name: "avg_breach_threshold"
      expr: AVG(CAST(breach_threshold AS DOUBLE))
      comment: "Average breach threshold across SLAs. Used to assess how much performance buffer exists before financial penalties are triggered."
    - name: "slas_requiring_escalation_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE AND sla_status = 'Active' THEN sla_id END)
      comment: "Number of active SLAs with escalation requirements. High-risk SLA monitoring metric for operations and client success leadership."
    - name: "slas_with_reporting_requirement_count"
      expr: COUNT(CASE WHEN reporting_required_flag = TRUE AND sla_status = 'Active' THEN sla_id END)
      comment: "Number of active SLAs requiring formal reporting. Compliance workload metric for operations and client reporting teams."
    - name: "sla_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN sla_status = 'Active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN sla_id END)
      comment: "Number of active SLAs expiring within 90 days. Service commitment continuity risk metric for operations and legal teams."
$$;

CREATE OR REPLACE VIEW `staffing_hr_ecm_v1`.`_metrics`.`contract_ic_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Independent Contractor (IC) agreement metrics covering payment rates, liability exposure, compliance requirements, and worker classification governance. Used by legal, finance, and compliance leadership to manage IC engagement risk, co-employment exposure, and contractor payment economics."
  source: "`staffing_hr_ecm_v1`.`contract`.`ic_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the IC agreement (e.g. Active, Expired, Terminated). Primary filter for active IC contract portfolio."
    - name: "contract_type"
      expr: contract_type
      comment: "Type of IC contract (e.g. Project-Based, Retainer, Time & Materials). Used to segment IC engagement model analysis."
    - name: "worker_classification_basis"
      expr: worker_classification_basis
      comment: "Basis for worker classification as independent contractor. Critical compliance dimension for co-employment and misclassification risk analysis."
    - name: "payment_structure"
      expr: payment_structure
      comment: "Payment structure of the IC agreement (e.g. Hourly, Fixed, Milestone). Used for payment economics and cash flow analysis."
    - name: "payment_currency"
      expr: payment_currency
      comment: "Currency of IC payments. Required for multi-currency contractor payment analysis."
    - name: "invoice_frequency"
      expr: invoice_frequency
      comment: "Frequency of IC invoicing. Used for accounts payable workload and cash flow forecasting."
    - name: "non_compete_flag"
      expr: non_compete_flag
      comment: "Indicates whether a non-compete clause is included. Used for talent mobility and competitive risk analysis."
    - name: "insurance_required_flag"
      expr: insurance_required_flag
      comment: "Indicates whether insurance is required from the IC. Compliance tracking for contractor risk management."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the IC agreement became effective. Used for contractor engagement cohort and trend analysis."
    - name: "governing_law_jurisdiction"
      expr: governing_law_jurisdiction
      comment: "Legal jurisdiction governing the IC agreement. Used for geographic compliance and risk segmentation."
  measures:
    - name: "active_ic_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN ic_agreement_id END)
      comment: "Number of currently active IC agreements. Core independent contractor workforce size metric for legal and operations leadership."
    - name: "total_payment_rate_commitment"
      expr: SUM(CAST(payment_rate AS DOUBLE))
      comment: "Total payment rate commitment across all IC agreements. Aggregate contractor cost exposure metric for finance leadership."
    - name: "avg_payment_rate"
      expr: AVG(CAST(payment_rate AS DOUBLE))
      comment: "Average payment rate per IC agreement. Used to benchmark contractor compensation levels and assess rate competitiveness."
    - name: "total_liability_cap_exposure"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Total liability cap exposure across all IC agreements. Financial risk metric for legal and CFO oversight of contractor liability."
    - name: "avg_liability_cap_amount"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap per IC agreement. Used to benchmark contractual risk exposure per contractor engagement."
    - name: "total_general_liability_minimum_exposure"
      expr: SUM(CAST(general_liability_minimum_usd AS DOUBLE))
      comment: "Total minimum general liability insurance required across IC agreements. Insurance compliance exposure metric."
    - name: "total_professional_liability_minimum_exposure"
      expr: SUM(CAST(professional_liability_minimum_usd AS DOUBLE))
      comment: "Total minimum professional liability insurance required across IC agreements. E&O risk exposure metric for compliance leadership."
    - name: "ic_agreements_expiring_within_90_days_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' AND expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN ic_agreement_id END)
      comment: "Number of active IC agreements expiring within 90 days. Contractor continuity and re-engagement pipeline metric."
    - name: "non_compete_ic_agreement_count"
      expr: COUNT(CASE WHEN non_compete_flag = TRUE THEN ic_agreement_id END)
      comment: "Number of IC agreements with non-compete clauses. Talent mobility restriction metric for legal and talent strategy leadership."
    - name: "insurance_required_ic_count"
      expr: COUNT(CASE WHEN insurance_required_flag = TRUE THEN ic_agreement_id END)
      comment: "Number of IC agreements requiring contractor insurance. Compliance coverage metric for risk management oversight."
$$;