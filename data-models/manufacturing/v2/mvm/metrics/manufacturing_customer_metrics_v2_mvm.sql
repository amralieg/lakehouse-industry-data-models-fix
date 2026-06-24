-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the customer account master — covers account portfolio health, revenue potential, credit exposure, and segmentation quality. Used by Sales, Finance, and Executive leadership to steer account strategy."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the customer account (e.g. Active, Inactive, Suspended). Primary filter for active-portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Direct, Distributor, OEM). Drives channel and go-to-market segmentation."
    - name: "account_source"
      expr: account_source
      comment: "Origin channel through which the account was acquired (e.g. Inbound, Partner, Campaign). Used for acquisition-channel ROI analysis."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of the account's billing address. Enables geographic revenue and credit-risk segmentation."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the billing address. Supports sub-national geographic analysis."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel assigned to the account (e.g. Direct, Wholesale). Key dimension for channel performance reporting."
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification of the account. Enables vertical-market segmentation and benchmarking."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service-level tier assigned to the account (e.g. Gold, Silver, Bronze). Used to prioritise service resources and measure tier distribution."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "SAP/ERP sales organisation responsible for the account. Enables sales-org level performance roll-ups."
    - name: "is_global_account"
      expr: is_global_account
      comment: "Flag indicating whether the account is managed as a global/strategic account. Separates global from local account KPIs."
    - name: "preferred_language_code"
      expr: preferred_language_code
      comment: "Preferred communication language of the account. Supports localisation and regional engagement analysis."
    - name: "open_date_month"
      expr: DATE_TRUNC('month', open_date)
      comment: "Month the account was opened. Enables cohort and vintage analysis of account acquisition trends."
    - name: "last_activity_date_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of the most recent activity on the account. Used to identify dormant or at-risk accounts."
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total number of distinct customer accounts. Baseline portfolio-size KPI used in all account-level dashboards."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of self-reported annual revenue across all accounts. Proxy for total addressable wallet size of the customer portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account. Indicates average account size and helps identify revenue concentration risk."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts. Key Finance KPI for aggregate credit exposure management."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy consistency and identifies outlier accounts."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average MDM/CRM data quality score across accounts. Tracks master data hygiene — low scores signal enrichment or deduplication campaigns needed."
    - name: "global_account_count"
      expr: COUNT(DISTINCT CASE WHEN is_global_account = TRUE THEN customer_account_id END)
      comment: "Number of accounts flagged as global/strategic. Tracks the size of the strategic account portfolio requiring dedicated management."
    - name: "strategic_account_revenue_total"
      expr: SUM(CAST(CASE WHEN is_global_account = TRUE THEN annual_revenue ELSE 0 END AS DOUBLE))
      comment: "Total annual revenue attributable to global/strategic accounts. Measures revenue concentration in the strategic tier."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and receivables health KPIs derived from customer credit profiles. Used by Finance, Credit Control, and Risk Management to monitor exposure, overdue balances, and payment behaviour across the customer base."
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification of the credit profile (e.g. Low, Medium, High). Primary dimension for credit risk segmentation."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level for the account. Indicates severity of collections activity in progress."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which credit limits and balances are denominated. Required for multi-currency credit exposure analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean flag indicating whether the account is currently on credit hold. Critical operational dimension for order-release workflows."
    - name: "bank_account_verified_flag"
      expr: bank_account_verified_flag
      comment: "Indicates whether the customer's bank account has been verified. Proxy for payment reliability and onboarding completeness."
    - name: "oldest_overdue_days"
      expr: oldest_overdue_days
      comment: "Age bucket of the oldest overdue invoice. Used to stratify collections urgency."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the credit profile became effective. Enables trend analysis of credit policy changes over time."
    - name: "last_credit_review_date_month"
      expr: DATE_TRUNC('month', last_credit_review_date)
      comment: "Month of the last credit review. Identifies accounts with stale credit assessments."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance across all credit profiles. Core Finance KPI for AR exposure and cash-flow forecasting."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables amount. Directly drives collections prioritisation and bad-debt provisioning decisions."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Aggregate credit limit extended across all profiled accounts. Measures total credit exposure approved by Finance."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilisation percentage across accounts. High averages signal elevated default risk and trigger credit review campaigns."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across credit profiles. Key AR efficiency KPI — rising DSO signals deteriorating payment behaviour."
    - name: "avg_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behaviour score across accounts. Composite indicator of customer payment reliability used in credit decisioning."
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision amount held against the portfolio. Directly impacts P&L and is a key Finance reporting metric."
    - name: "accounts_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of accounts currently on credit hold. Operational KPI for order management — high counts block revenue and require immediate credit-team action."
    - name: "avg_payment_terms_days"
      expr: AVG(CAST(payment_terms_days AS DOUBLE))
      comment: "Average payment terms (in days) across credit profiles. Benchmarks working-capital impact of negotiated payment terms across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead pipeline and conversion KPIs for the manufacturing sales funnel. Used by Sales, Marketing, and Revenue Operations to track lead volume, quality, conversion performance, and pipeline value."
  source: "`vibe_manufacturing_v1`.`customer`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead in the sales funnel (e.g. New, Qualified, Disqualified, Converted). Primary funnel-stage dimension."
    - name: "lead_type"
      expr: lead_type
      comment: "Classification of the lead (e.g. Inbound, Outbound, Partner Referral). Enables lead-source quality comparison."
    - name: "buying_stage"
      expr: buying_stage
      comment: "Buyer journey stage of the lead (e.g. Awareness, Consideration, Decision). Aligns marketing and sales engagement to buyer readiness."
    - name: "source"
      expr: source
      comment: "Marketing or sales source that generated the lead (e.g. Web, Event, Cold Call). Used for campaign attribution and ROI analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the lead. Enables geographic pipeline analysis and territory planning."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region assigned to the lead. Supports regional pipeline and quota attainment reporting."
    - name: "company_industry"
      expr: company_industry
      comment: "Industry vertical of the lead's company. Enables vertical-market pipeline analysis."
    - name: "company_size"
      expr: company_size
      comment: "Size band of the lead's company (e.g. SMB, Mid-Market, Enterprise). Drives segmentation of pipeline by deal complexity."
    - name: "grade"
      expr: grade
      comment: "Lead quality grade assigned by scoring model (e.g. A, B, C, D). Key dimension for prioritising sales follow-up."
    - name: "is_converted"
      expr: is_converted
      comment: "Boolean flag indicating whether the lead has been converted to an opportunity. Core conversion funnel dimension."
    - name: "disqualification_reason"
      expr: disqualification_reason
      comment: "Reason the lead was disqualified. Identifies systemic lead quality or targeting issues."
    - name: "created_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the lead was created. Enables lead volume trend and cohort analysis."
    - name: "conversion_date_month"
      expr: DATE_TRUNC('month', conversion_date)
      comment: "Month the lead was converted. Used to measure conversion velocity and funnel throughput over time."
  measures:
    - name: "total_leads"
      expr: COUNT(DISTINCT lead_id)
      comment: "Total number of distinct leads in the pipeline. Baseline volume KPI for top-of-funnel health monitoring."
    - name: "converted_leads"
      expr: COUNT(DISTINCT CASE WHEN is_converted = TRUE THEN lead_id END)
      comment: "Number of leads successfully converted to opportunities. Measures sales funnel throughput and marketing effectiveness."
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Total estimated deal value across all leads in the pipeline. Proxy for top-of-funnel revenue potential — used in pipeline coverage analysis."
    - name: "avg_estimated_deal_value"
      expr: AVG(CAST(estimated_deal_value AS DOUBLE))
      comment: "Average estimated deal value per lead. Indicates average deal size entering the funnel — informs resource allocation and quota setting."
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue of lead companies. Measures the aggregate wallet size of the lead pool for prioritisation."
    - name: "converted_deal_value"
      expr: SUM(CAST(CASE WHEN is_converted = TRUE THEN estimated_deal_value ELSE 0 END AS DOUBLE))
      comment: "Total estimated deal value of converted leads. Measures the revenue value successfully progressed through the top of the funnel."
    - name: "avg_annual_energy_consumption_mwh"
      expr: AVG(CAST(annual_energy_consumption_mwh AS DOUBLE))
      comment: "Average annual energy consumption (MWh) of lead companies. Manufacturing-specific KPI for sizing automation/energy solution opportunities."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement and relationship health KPIs derived from interaction records. Used by Sales, Customer Success, and Marketing to monitor engagement intensity, complaint rates, and satisfaction trends."
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (e.g. Call, Meeting, Email, Site Visit). Enables channel-mix and engagement-type analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (e.g. Completed, Pending, Cancelled). Used to track follow-through rates on customer engagements."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction (e.g. Phone, Video, In-Person). Supports channel effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Business outcome of the interaction (e.g. Order Placed, Issue Resolved, No Action). Measures interaction effectiveness."
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment classification of the interaction (e.g. Positive, Neutral, Negative). Leading indicator of customer satisfaction and churn risk."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the interaction (e.g. High, Medium, Low). Used to assess urgency distribution of customer engagements."
    - name: "is_customer_complaint"
      expr: is_customer_complaint
      comment: "Boolean flag indicating whether the interaction was a customer complaint. Critical quality and satisfaction KPI dimension."
    - name: "country_code"
      expr: country_code
      comment: "Country where the interaction occurred. Enables geographic engagement and complaint analysis."
    - name: "interaction_date_month"
      expr: DATE_TRUNC('month', interaction_date)
      comment: "Month of the interaction. Enables trend analysis of engagement volume and quality over time."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flag indicating whether a follow-up action is required. Tracks open action items from customer interactions."
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of distinct customer interactions. Baseline engagement volume KPI — declining counts signal reduced customer engagement."
    - name: "total_complaint_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_customer_complaint = TRUE THEN interaction_id END)
      comment: "Total number of interactions flagged as customer complaints. Direct quality and satisfaction KPI — rising counts trigger CAPA and service improvement actions."
    - name: "total_interaction_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total time invested in customer interactions (minutes). Measures customer success team capacity utilisation and engagement depth."
    - name: "avg_interaction_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per customer interaction (minutes). Benchmarks engagement depth — unusually short or long durations signal process or satisfaction issues."
    - name: "executive_sponsor_interactions"
      expr: COUNT(DISTINCT CASE WHEN is_executive_sponsor_involved = TRUE THEN interaction_id END)
      comment: "Number of interactions involving an executive sponsor. Tracks executive engagement intensity with strategic accounts — a leading indicator of deal health."
    - name: "interactions_requiring_followup"
      expr: COUNT(DISTINCT CASE WHEN follow_up_required = TRUE THEN interaction_id END)
      comment: "Number of interactions with an open follow-up action required. Operational KPI for sales and customer success pipeline hygiene."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA portfolio and contractual commitment KPIs. Used by Service Operations, Finance, and Account Management to monitor SLA coverage, contract value, penalty exposure, and service tier distribution."
  source: "`vibe_manufacturing_v1`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (e.g. Active, Expired, Terminated). Primary filter for active SLA portfolio analysis."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. Response Time, Uptime, Delivery). Enables analysis of commitment mix across the service portfolio."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the SLA (e.g. Platinum, Gold, Silver). Drives resource allocation and tier-level performance reporting."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Frequency at which the SLA is billed (e.g. Monthly, Quarterly, Annual). Used for revenue recognition and cash-flow planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SLA contract value. Required for multi-currency contract portfolio analysis."
    - name: "service_region"
      expr: service_region
      comment: "Geographic region covered by the SLA. Enables regional service capacity and commitment analysis."
    - name: "penalty_clause_applicable"
      expr: penalty_clause_applicable
      comment: "Flag indicating whether a financial penalty clause applies. Segments high-risk SLAs requiring strict operational compliance."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Flag indicating whether the SLA auto-renews. Used to forecast recurring contract revenue and identify manual renewal risk."
    - name: "field_service_included"
      expr: field_service_included
      comment: "Flag indicating whether field service is included in the SLA. Drives field service capacity planning."
    - name: "effective_date_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SLA became effective. Enables contract vintage and renewal cohort analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the SLA expires. Critical for renewal pipeline management and revenue-at-risk forecasting."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all SLA agreements. Core Finance KPI for contracted service revenue and backlog reporting."
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual recurring fee across active SLA agreements. Measures annualised contracted service revenue — key for ARR/MRR reporting."
    - name: "avg_annual_fee_per_agreement"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per SLA agreement. Benchmarks contract value and identifies upsell opportunities in lower-tier agreements."
    - name: "total_active_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN sla_agreement_id END)
      comment: "Number of currently active SLA agreements. Baseline KPI for active service portfolio size and coverage."
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average contracted uptime target percentage across SLA agreements. Measures the aggregate service commitment level — high averages signal demanding SLA obligations."
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average contracted initial response time (hours) across SLAs. Benchmarks service responsiveness commitments — used to plan support staffing levels."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average contracted resolution time (hours) across SLAs. Key service operations KPI — drives technician capacity and spare-parts inventory planning."
    - name: "agreements_with_penalty_clause"
      expr: COUNT(DISTINCT CASE WHEN penalty_clause_applicable = TRUE THEN sla_agreement_id END)
      comment: "Number of SLA agreements with an active financial penalty clause. Measures financial risk exposure from SLA non-compliance — high counts require strict operational monitoring."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage committed in SLAs. Manufacturing-specific KPI linking service agreements to supply chain performance obligations."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact quality, engagement, and data governance KPIs. Used by Sales, Marketing, and MDM teams to monitor contact coverage, data quality, consent compliance, and decision-maker penetration."
  source: "`vibe_manufacturing_v1`.`customer`.`contact`"
  dimensions:
    - name: "contact_type"
      expr: contact_type
      comment: "Classification of the contact (e.g. Technical, Commercial, Executive). Enables analysis of contact mix and decision-maker coverage."
    - name: "customer_contact_status"
      expr: customer_contact_status
      comment: "Lifecycle status of the contact (e.g. Active, Inactive, Unsubscribed). Primary filter for reachable contact population."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the contact. Enables persona-level engagement analysis and decision-maker identification."
    - name: "department"
      expr: department
      comment: "Department of the contact within their organisation. Supports multi-threaded account engagement analysis."
    - name: "persona"
      expr: persona
      comment: "Marketing persona assigned to the contact. Drives personalised campaign targeting and content strategy."
    - name: "lead_source"
      expr: lead_source
      comment: "Source through which the contact was acquired. Used for contact acquisition channel attribution."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Contact's preferred channel for communication (e.g. Email, Phone, LinkedIn). Optimises outreach strategy and response rates."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the contact. Enables service-tier-level contact coverage analysis."
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Flag indicating whether the contact is a decision maker. Critical dimension for measuring executive-level account penetration."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Flag indicating whether the contact has opted into marketing communications. Measures marketable contact population size."
    - name: "last_activity_date_month"
      expr: DATE_TRUNC('month', last_activity_date)
      comment: "Month of the contact's last recorded activity. Used to identify dormant contacts and prioritise re-engagement campaigns."
  measures:
    - name: "total_contacts"
      expr: COUNT(DISTINCT contact_id)
      comment: "Total number of distinct contacts across all accounts. Baseline KPI for contact database coverage and growth."
    - name: "decision_maker_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_decision_maker = TRUE THEN contact_id END)
      comment: "Number of contacts identified as decision makers. Measures executive-level penetration of the account base — low counts signal risk in deal progression."
    - name: "marketing_opted_in_contacts"
      expr: COUNT(DISTINCT CASE WHEN marketing_opt_in = TRUE THEN contact_id END)
      comment: "Number of contacts opted into marketing communications. Defines the reachable marketing audience — directly impacts campaign reach and pipeline generation."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average MDM data quality score across all contacts. Tracks contact data hygiene — low scores trigger enrichment and deduplication initiatives."
    - name: "technical_contacts"
      expr: COUNT(DISTINCT CASE WHEN technical_contact_flag = TRUE THEN contact_id END)
      comment: "Number of contacts flagged as technical contacts. Manufacturing-specific KPI for measuring technical stakeholder coverage — critical for product adoption and support escalation."
    - name: "primary_contacts"
      expr: COUNT(DISTINCT CASE WHEN is_primary_contact = TRUE THEN contact_id END)
      comment: "Number of contacts designated as the primary contact for their account. Measures account coverage completeness — accounts without a primary contact are at risk."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio and commercial policy KPIs. Used by Sales Strategy, Finance, and Marketing to monitor segment health, revenue targets, credit policy, and discount structures across the customer base."
  source: "`vibe_manufacturing_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Lifecycle status of the segment (e.g. Active, Inactive, Under Review). Primary filter for active segment portfolio analysis."
    - name: "segment_type"
      expr: segment_type
      comment: "Classification of the segment (e.g. Strategic, Growth, Maintenance). Drives resource allocation and go-to-market strategy."
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel type associated with the segment. Enables channel-level segment performance analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment. Supports regional market strategy and territory planning."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical targeted by the segment. Enables vertical-market strategy and benchmarking."
    - name: "pricing_tier_code"
      expr: pricing_tier_code
      comment: "Pricing tier assigned to the segment. Drives pricing strategy analysis and margin management."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier code assigned to the segment. Links segment classification to service commitment levels."
    - name: "rebate_eligible"
      expr: rebate_eligible
      comment: "Flag indicating whether accounts in this segment are eligible for rebates. Used to quantify rebate liability exposure."
    - name: "effective_from_date_month"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month the segment became effective. Enables segment vintage and policy change analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of distinct customer segments. Baseline KPI for segment portfolio complexity and governance."
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total revenue target across all segments (USD). Aggregates the commercial ambition of the segment portfolio — used in top-down revenue planning."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average target gross margin percentage across segments. Benchmarks the profitability ambition of the segment portfolio — informs pricing and discount policy."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit allocated across all segments (USD). Measures aggregate credit policy exposure by segment — used in credit risk governance."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate percentage across segments. Tracks commercial discount policy — rising averages signal margin erosion risk."
    - name: "total_revenue_band_max"
      expr: SUM(CAST(revenue_band_max AS DOUBLE))
      comment: "Sum of maximum revenue band thresholds across segments. Measures the upper bound of total addressable revenue defined by segment policy."
    - name: "rebate_eligible_segments"
      expr: COUNT(DISTINCT CASE WHEN rebate_eligible = TRUE THEN segment_id END)
      comment: "Number of segments eligible for rebates. Quantifies rebate programme scope — used by Finance to estimate rebate liability and accruals."
$$;