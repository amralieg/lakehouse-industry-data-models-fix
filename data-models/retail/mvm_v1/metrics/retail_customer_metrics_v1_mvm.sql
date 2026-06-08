-- Metric views for domain: customer | Business: Retail | Version: 1 | Generated on: 2026-05-04 13:23:00

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer profile master entity. Tracks customer base health, acquisition economics, loyalty distribution, lifecycle stage composition, and consent posture — all critical inputs for CRM, marketing, and retention strategy."
  source: "`retail_ecm`.`customer`.`profile`"
  dimensions:
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which the customer was acquired (e.g. organic, paid, referral, in-store). Used to evaluate channel ROI and acquisition mix."
    - name: "customer_type"
      expr: customer_type
      comment: "Classification of the customer (e.g. B2C individual, B2B, employee). Drives segmentation and policy differentiation."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current stage in the customer lifecycle (e.g. new, active, at-risk, lapsed, churned). Core dimension for retention and re-engagement programs."
    - name: "loyalty_tier"
      expr: loyalty_tier
      comment: "Customer loyalty tier (e.g. Bronze, Silver, Gold, Platinum). Used to evaluate tier distribution and loyalty program effectiveness."
    - name: "profile_status"
      expr: profile_status
      comment: "Operational status of the profile (e.g. active, inactive, merged, deleted). Used to filter and monitor data quality."
    - name: "preferred_contact_method"
      expr: preferred_contact_method
      comment: "Customer's preferred communication channel (e.g. email, SMS, push). Informs omnichannel engagement strategy."
    - name: "preferred_language"
      expr: preferred_language
      comment: "Customer's preferred language. Used for localisation and communication personalisation."
    - name: "gender"
      expr: gender
      comment: "Self-reported gender of the customer. Used for demographic segmentation and inclusivity reporting."
    - name: "acquisition_month"
      expr: DATE_TRUNC('MONTH', acquisition_date)
      comment: "Month of customer acquisition. Used to track cohort growth and acquisition trends over time."
    - name: "last_purchase_month"
      expr: DATE_TRUNC('MONTH', last_purchase_date)
      comment: "Month of the customer's most recent purchase. Used to identify recency cohorts and lapsed-customer windows."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Indicates whether the customer holds VIP status. Used to monitor VIP base size and target high-value customer programs."
    - name: "marketing_consent_flag"
      expr: marketing_consent_flag
      comment: "Whether the customer has given marketing consent. Critical for GDPR/CCPA compliance and addressable audience sizing."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether the customer has provided GDPR consent. Required for EU market compliance reporting."
    - name: "ccpa_opt_out_flag"
      expr: ccpa_opt_out_flag
      comment: "Whether the customer has opted out under CCPA. Required for US privacy compliance reporting."
    - name: "employee_flag"
      expr: employee_flag
      comment: "Indicates whether the customer is also an employee. Used to exclude or separately analyse employee purchases."
  measures:
    - name: "total_active_customers"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN profile_id END)
      comment: "Count of customers with an active profile status. The primary measure of addressable customer base size — a core executive KPI."
    - name: "total_customers"
      expr: COUNT(profile_id)
      comment: "Total count of all customer profiles regardless of status. Used as the denominator for penetration and consent rate calculations."
    - name: "marketing_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_consent_flag = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of customers who have given marketing consent. Directly determines the size of the legally addressable marketing audience — a compliance and revenue-risk KPI."
    - name: "gdpr_consent_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of EU customers with active GDPR consent. Regulatory compliance KPI; a decline signals legal exposure."
    - name: "vip_customer_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN profile_id END)
      comment: "Number of customers with VIP status. Tracks the size of the highest-value customer cohort, informing premium service investment decisions."
    - name: "vip_penetration_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN vip_flag = TRUE THEN profile_id END) / NULLIF(COUNT(CASE WHEN profile_status = 'active' THEN profile_id END), 0), 2)
      comment: "Percentage of active customers who are VIP. Measures the depth of the high-value customer tier relative to the active base."
    - name: "avg_customer_acquisition_cost"
      expr: AVG(CAST(cac_amount AS DOUBLE))
      comment: "Average cost to acquire a customer across all profiles. A fundamental marketing efficiency KPI used to evaluate channel and campaign ROI."
    - name: "total_customer_acquisition_cost"
      expr: SUM(CAST(cac_amount AS DOUBLE))
      comment: "Total spend on customer acquisition across all profiles. Used to assess total marketing investment and budget allocation."
    - name: "avg_cltv_score"
      expr: AVG(CAST(cltv_score AS DOUBLE))
      comment: "Average predicted customer lifetime value score across the customer base. A strategic KPI for prioritising retention investment and forecasting long-term revenue."
    - name: "avg_mdm_confidence_score"
      expr: AVG(CAST(mdm_confidence_score AS DOUBLE))
      comment: "Average master data management match confidence score. Measures customer data quality — low scores indicate identity resolution issues that inflate customer counts and degrade personalisation."
    - name: "email_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN email_opt_in_flag = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of customers opted into email communications. Determines the reachable email audience size, directly impacting email campaign revenue potential."
    - name: "sms_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sms_opt_in_flag = TRUE THEN profile_id END) / NULLIF(COUNT(profile_id), 0), 2)
      comment: "Percentage of customers opted into SMS communications. Measures the reachable SMS audience, a high-conversion channel for promotions and alerts."
    - name: "lapsed_customer_count"
      expr: COUNT(CASE WHEN lifecycle_stage = 'lapsed' THEN profile_id END)
      comment: "Number of customers in the lapsed lifecycle stage. A leading indicator of churn risk; growth in this metric triggers win-back campaign investment."
    - name: "churned_customer_count"
      expr: COUNT(CASE WHEN lifecycle_stage = 'churned' THEN profile_id END)
      comment: "Number of customers classified as churned. Tracks permanent customer loss; used to calculate churn rate and evaluate retention programme effectiveness."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs over customer accounts. Covers credit exposure, outstanding balances, account lifecycle health, and B2B vs B2C account composition — essential for finance, credit risk, and commercial teams."
  source: "`retail_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current operational status of the account (e.g. active, suspended, closed). Primary filter for active account analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g. retail, wholesale, employee). Used to segment commercial vs consumer account performance."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account (e.g. standard, premium, enterprise). Used to evaluate tier-based revenue and credit exposure."
    - name: "preferred_channel"
      expr: preferred_channel
      comment: "Customer's preferred shopping channel (e.g. in-store, online, mobile). Used for omnichannel strategy and channel investment decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency associated with the account. Used for multi-currency financial reporting and FX exposure analysis."
    - name: "b2b_pricing_flag"
      expr: b2b_pricing_flag
      comment: "Indicates whether the account uses B2B pricing. Separates B2B and B2C account populations for commercial analysis."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Indicates whether the account is tax-exempt. Used for tax liability reporting and compliance."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Whether the account has opted into marketing communications. Used to size the marketable account base."
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened. Used for cohort analysis of account acquisition trends."
    - name: "last_transaction_month"
      expr: DATE_TRUNC('MONTH', last_transaction_date)
      comment: "Month of the account's most recent transaction. Used to identify recency cohorts and dormant accounts."
    - name: "source_system"
      expr: source_system
      comment: "Source system that originated the account record. Used for data lineage and migration quality monitoring."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'active' THEN account_id END)
      comment: "Count of accounts with active status. The primary measure of the active commercial customer base — a core revenue-generating population metric."
    - name: "total_accounts"
      expr: COUNT(account_id)
      comment: "Total count of all accounts regardless of status. Used as the denominator for account health and activation rate calculations."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all accounts. A critical credit risk and accounts-receivable KPI monitored by finance leadership."
    - name: "avg_outstanding_balance"
      expr: AVG(CAST(outstanding_balance AS DOUBLE))
      comment: "Average outstanding balance per account. Used to benchmark individual account exposure against portfolio norms."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Measures total credit exposure — a key risk management and capital allocation KPI."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Used to evaluate credit policy generosity and compare across account tiers."
    - name: "credit_utilisation_rate"
      expr: ROUND(100.0 * SUM(CAST(outstanding_balance AS DOUBLE)) / NULLIF(SUM(CAST(credit_limit AS DOUBLE)), 0), 2)
      comment: "Ratio of total outstanding balance to total credit limit, expressed as a percentage. A primary credit risk KPI — high utilisation signals elevated default risk and triggers credit review."
    - name: "suspended_account_count"
      expr: COUNT(CASE WHEN account_status = 'suspended' THEN account_id END)
      comment: "Number of suspended accounts. Tracks accounts under restriction; growth signals credit, fraud, or compliance issues requiring intervention."
    - name: "account_suspension_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN account_status = 'suspended' THEN account_id END) / NULLIF(COUNT(account_id), 0), 2)
      comment: "Percentage of accounts that are currently suspended. A portfolio health KPI; rising suspension rates indicate systemic credit or compliance problems."
    - name: "tax_exempt_account_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts. Used for tax liability forecasting and compliance audit preparation."
    - name: "b2b_account_count"
      expr: COUNT(CASE WHEN b2b_pricing_flag = TRUE THEN account_id END)
      comment: "Number of accounts on B2B pricing. Tracks the size of the wholesale/commercial customer base, informing B2B revenue strategy."
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN account_id END) / NULLIF(COUNT(CASE WHEN account_status = 'active' THEN account_id END), 0), 2)
      comment: "Percentage of active accounts opted into marketing. Determines the marketable account base size for campaign planning and revenue forecasting."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service quality and operational efficiency KPIs. Tracks case volume, resolution performance, SLA compliance, escalation rates, and refund exposure — critical for CX leadership, operations, and cost management."
  source: "`retail_ecm`.`customer`.`service_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case (e.g. open, in-progress, resolved, closed). Primary dimension for workload and backlog analysis."
    - name: "case_type"
      expr: case_type
      comment: "Type of service case (e.g. return, complaint, inquiry, fraud). Used to identify the most common issue categories driving service volume."
    - name: "channel"
      expr: channel
      comment: "Channel through which the case was raised (e.g. phone, email, chat, in-store). Used to evaluate channel-level service demand and cost."
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the case (e.g. low, medium, high, critical). Used to monitor high-priority case volumes and SLA adherence."
    - name: "assigned_team"
      expr: assigned_team
      comment: "Team responsible for resolving the case. Used for workload distribution and team performance analysis."
    - name: "resolution_code"
      expr: resolution_code
      comment: "Standardised code describing how the case was resolved. Used to identify resolution patterns and process improvement opportunities."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Indicates whether the case was escalated. Used to track escalation rates as a proxy for first-contact resolution failure."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Indicates whether the case breached its SLA target. Core service quality KPI dimension for compliance and penalty risk monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of any financial amounts on the case (e.g. refund). Used for multi-currency financial reporting."
    - name: "case_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the service case was created. Used for trend analysis of case volume over time."
    - name: "case_owner_type"
      expr: case_owner_type
      comment: "Type of owner handling the case (e.g. agent, bot, self-service). Used to evaluate automation vs human handling rates."
  measures:
    - name: "total_cases"
      expr: COUNT(service_case_id)
      comment: "Total number of service cases created. The primary volume KPI for customer service operations — drives staffing and capacity planning."
    - name: "open_case_count"
      expr: COUNT(CASE WHEN is_closed = FALSE THEN service_case_id END)
      comment: "Number of currently open (unresolved) cases. Tracks the live service backlog — a key operational health metric for CX leadership."
    - name: "case_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_closed = TRUE THEN service_case_id END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases that have been closed/resolved. Measures service team throughput and effectiveness — a primary CX operational KPI."
    - name: "sla_breach_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN sla_breach_flag = TRUE THEN service_case_id END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases that breached their SLA target. A critical service quality KPI; high breach rates trigger operational review and may carry contractual or regulatory penalties."
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN service_case_id END) / NULLIF(COUNT(service_case_id), 0), 2)
      comment: "Percentage of cases that were escalated. Measures first-contact resolution failure rate — a leading indicator of customer dissatisfaction and service cost inflation."
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total monetary value of refunds issued through service cases. A direct cost-of-service KPI; high refund totals signal product quality, fulfilment, or fraud issues."
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per service case. Used to benchmark refund generosity and identify outlier cases requiring policy review."
    - name: "avg_sla_target_hours"
      expr: AVG(CAST(sla_target_hours AS DOUBLE))
      comment: "Average SLA target resolution time in hours across cases. Used to evaluate whether SLA commitments are appropriately calibrated to case complexity."
    - name: "escalated_case_count"
      expr: COUNT(CASE WHEN escalation_flag = TRUE THEN service_case_id END)
      comment: "Absolute count of escalated cases. Tracks escalation volume for capacity planning of specialist resolution teams."
    - name: "distinct_customers_with_cases"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers who have raised at least one service case. Used to calculate the proportion of the customer base experiencing service issues."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over customer segments. Tracks segment size, value, churn risk, and NPS across the segment portfolio — used by marketing, CRM, and strategy teams to prioritise investment and evaluate segmentation effectiveness."
  source: "`retail_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_name"
      expr: segment_name
      comment: "Business name of the customer segment. Primary label for segment-level reporting and campaign targeting."
    - name: "segment_type"
      expr: segment_type
      comment: "Classification of the segment (e.g. behavioural, demographic, RFM). Used to evaluate the mix of segmentation methodologies in use."
    - name: "segment_status"
      expr: segment_status
      comment: "Operational status of the segment (e.g. active, archived, draft). Used to filter analysis to live, actionable segments."
    - name: "priority_tier"
      expr: priority_tier
      comment: "Priority tier assigned to the segment (e.g. tier 1, tier 2). Used to focus investment on the highest-priority customer groups."
    - name: "b2b_b2c_indicator"
      expr: b2b_b2c_indicator
      comment: "Indicates whether the segment is B2B or B2C. Used to separate commercial and consumer segment performance."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the segment (e.g. national, regional, global). Used for geographic market analysis."
    - name: "target_marketing_channel"
      expr: target_marketing_channel
      comment: "Primary marketing channel targeted for this segment. Used to align channel investment with segment strategy."
    - name: "discount_sensitivity"
      expr: discount_sensitivity
      comment: "Discount sensitivity classification of the segment (e.g. high, medium, low). Used to calibrate promotional depth and protect margin."
    - name: "refresh_frequency"
      expr: refresh_frequency
      comment: "How frequently the segment membership is recalculated. Used to assess segment data freshness and operational readiness."
    - name: "owning_business_unit"
      expr: owning_business_unit
      comment: "Business unit responsible for the segment. Used for accountability and budget allocation in marketing planning."
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the segment became effective. Used to track segment portfolio evolution over time."
  measures:
    - name: "total_segments"
      expr: COUNT(segment_id)
      comment: "Total number of defined customer segments. Tracks the breadth of the segmentation portfolio — used to manage complexity and governance overhead."
    - name: "total_segment_membership"
      expr: SUM(CAST(membership_count AS BIGINT))
      comment: "Total customer memberships across all segments. Measures the aggregate reach of the segmentation framework — a key input for campaign audience sizing."
    - name: "avg_segment_membership"
      expr: AVG(CAST(membership_count AS DOUBLE))
      comment: "Average number of customers per segment. Used to evaluate segment granularity — very small or very large averages indicate over- or under-segmentation."
    - name: "avg_segment_cltv"
      expr: AVG(CAST(average_cltv AS DOUBLE))
      comment: "Average predicted customer lifetime value across segments. A strategic KPI for evaluating the overall value quality of the segment portfolio."
    - name: "avg_segment_aov"
      expr: AVG(CAST(average_aov AS DOUBLE))
      comment: "Average order value across segments. Used to identify high-AOV segments for premium product and upsell targeting."
    - name: "avg_segment_purchase_frequency"
      expr: AVG(CAST(average_purchase_frequency AS DOUBLE))
      comment: "Average purchase frequency across segments. Measures engagement depth of the segment portfolio — low frequency signals re-engagement opportunity."
    - name: "avg_churn_risk_score"
      expr: AVG(CAST(churn_risk_score AS DOUBLE))
      comment: "Average churn risk score across segments. A leading indicator of revenue at risk — rising scores trigger proactive retention investment."
    - name: "avg_segment_nps"
      expr: AVG(CAST(nps_score AS DOUBLE))
      comment: "Average Net Promoter Score across segments. Measures customer advocacy and satisfaction at the segment level — a key input for brand and CX strategy."
    - name: "high_churn_risk_segment_count"
      expr: COUNT(CASE WHEN churn_risk_score >= 0.7 THEN segment_id END)
      comment: "Number of segments with a churn risk score of 0.7 or above. Identifies the segments requiring immediate retention intervention to protect revenue."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'active' THEN segment_id END)
      comment: "Number of currently active segments. Tracks the live, actionable segment portfolio size for marketing operations planning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_consent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Privacy compliance and consent governance KPIs. Tracks consent coverage, withdrawal rates, double opt-in completion, and minor consent flags — essential for GDPR/CCPA compliance, legal risk management, and addressable audience governance."
  source: "`retail_ecm`.`customer`.`consent`"
  dimensions:
    - name: "consent_type"
      expr: consent_type
      comment: "Type of consent recorded (e.g. marketing, data processing, profiling). Used to monitor consent coverage by regulatory category."
    - name: "consent_status"
      expr: consent_status
      comment: "Current status of the consent record (e.g. active, withdrawn, expired). Primary dimension for compliance reporting."
    - name: "consent_scope"
      expr: consent_scope
      comment: "Scope of the consent (e.g. brand-level, program-level, global). Used to evaluate the breadth of consent coverage."
    - name: "legal_basis"
      expr: legal_basis
      comment: "Legal basis for data processing (e.g. consent, legitimate interest, contract). Required for GDPR Article 30 records of processing activities."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction governing the consent (e.g. EU, US-CA, UK). Used for jurisdiction-specific compliance reporting."
    - name: "collection_channel"
      expr: collection_channel
      comment: "Channel through which consent was collected (e.g. web, in-store, app). Used to evaluate consent collection effectiveness by channel."
    - name: "consent_method"
      expr: consent_method
      comment: "Method used to obtain consent (e.g. checkbox, signature, verbal). Used for audit and legal defensibility assessment."
    - name: "language"
      expr: language
      comment: "Language in which consent was presented. Used to verify that consent was obtained in the customer's language as required by GDPR."
    - name: "privacy_policy_version"
      expr: privacy_policy_version
      comment: "Version of the privacy policy under which consent was obtained. Used to identify customers who need re-consent after policy updates."
    - name: "consent_month"
      expr: DATE_TRUNC('MONTH', consent_timestamp)
      comment: "Month consent was recorded. Used to track consent collection trends and the impact of consent campaigns."
    - name: "minor_consent_flag"
      expr: minor_consent_flag
      comment: "Indicates whether the consent involves a minor. Used for child data protection compliance monitoring."
  measures:
    - name: "total_consent_records"
      expr: COUNT(consent_id)
      comment: "Total number of consent records. Baseline volume metric for consent management operations and audit completeness."
    - name: "active_consent_count"
      expr: COUNT(CASE WHEN consent_status = 'active' THEN consent_id END)
      comment: "Number of currently active consent records. Determines the legally compliant addressable audience size — a direct revenue-enabling compliance KPI."
    - name: "consent_withdrawal_count"
      expr: COUNT(CASE WHEN withdrawal_timestamp IS NOT NULL THEN consent_id END)
      comment: "Number of consent records that have been withdrawn. Tracks opt-out volume; rising withdrawals signal trust or communication issues requiring CX intervention."
    - name: "consent_withdrawal_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN withdrawal_timestamp IS NOT NULL THEN consent_id END) / NULLIF(COUNT(consent_id), 0), 2)
      comment: "Percentage of consent records that have been withdrawn. A key privacy health KPI; high withdrawal rates indicate customer trust erosion or over-communication."
    - name: "double_opt_in_completion_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN double_opt_in_confirmed = TRUE THEN consent_id END) / NULLIF(COUNT(CASE WHEN consent_type = 'marketing' THEN consent_id END), 0), 2)
      comment: "Percentage of marketing consents where double opt-in was confirmed. Measures the quality and legal robustness of the marketing consent base — critical for anti-spam compliance."
    - name: "minor_consent_count"
      expr: COUNT(CASE WHEN minor_consent_flag = TRUE THEN consent_id END)
      comment: "Number of consent records flagged as involving a minor. Tracks child data exposure — a high-priority regulatory risk requiring parental consent verification."
    - name: "parental_consent_verified_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN parental_consent_verified = TRUE THEN consent_id END) / NULLIF(COUNT(CASE WHEN minor_consent_flag = TRUE THEN consent_id END), 0), 2)
      comment: "Percentage of minor consent records where parental consent has been verified. A critical child protection compliance KPI — any gap represents regulatory and reputational risk."
    - name: "distinct_customers_with_active_consent"
      expr: COUNT(DISTINCT CASE WHEN consent_status = 'active' THEN profile_id END)
      comment: "Number of unique customers with at least one active consent record. Measures the breadth of the consented customer base for audience planning."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment membership and loyalty programme enrolment KPIs. Tracks membership volume, assignment confidence, manual override rates, and active membership health — used by CRM, loyalty, and marketing teams to evaluate segmentation quality and programme participation."
  source: "`retail_ecm`.`customer`.`customer_membership`"
  dimensions:
    - name: "customer_membership_status"
      expr: customer_membership_status
      comment: "Current status of the customer's segment membership (e.g. active, expired, pending). Primary dimension for membership health analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method used to assign the customer to the segment (e.g. rule-based, ML model, manual). Used to evaluate the mix of automated vs manual segmentation."
    - name: "manual_override_flag"
      expr: manual_override_flag
      comment: "Indicates whether the segment assignment was manually overridden. Used to monitor data governance quality and analyst intervention rates."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the membership became effective. Used to track membership enrolment trends over time."
    - name: "end_month"
      expr: DATE_TRUNC('MONTH', end_date)
      comment: "Month the membership expired or is scheduled to expire. Used to forecast membership churn and renewal planning."
  measures:
    - name: "total_memberships"
      expr: COUNT(customer_membership_id)
      comment: "Total number of customer segment memberships. Baseline volume metric for the segmentation programme — tracks overall enrolment scale."
    - name: "active_membership_count"
      expr: COUNT(CASE WHEN customer_membership_status = 'active' THEN customer_membership_id END)
      comment: "Number of currently active segment memberships. Measures the live, actionable segment population — the foundation for targeted marketing execution."
    - name: "avg_assignment_confidence_score"
      expr: AVG(CAST(assignment_confidence_score AS DOUBLE))
      comment: "Average confidence score of segment assignments. Measures the quality of the segmentation model — low scores indicate the model needs retraining, reducing campaign effectiveness."
    - name: "manual_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN manual_override_flag = TRUE THEN customer_membership_id END) / NULLIF(COUNT(customer_membership_id), 0), 2)
      comment: "Percentage of segment assignments that were manually overridden. High override rates signal that the automated segmentation model is not trusted or performing well — a model quality KPI."
    - name: "distinct_customers_enrolled"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers enrolled in at least one segment. Measures the breadth of segmentation programme coverage across the customer base."
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`customer_payment_method`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment method portfolio KPIs. Tracks payment method diversity, gift card and store credit balances, active payment method rates, and verification status — used by finance, fraud, and digital commerce teams."
  source: "`retail_ecm`.`customer`.`payment_method`"
  dimensions:
    - name: "payment_method_type"
      expr: payment_method_type
      comment: "Type of payment method (e.g. credit card, debit card, digital wallet, BNPL, gift card). Used to analyse payment mix and channel preferences."
    - name: "card_brand"
      expr: card_brand
      comment: "Card network brand (e.g. Visa, Mastercard, Amex). Used to evaluate card brand distribution and negotiate interchange rates."
    - name: "digital_wallet_provider"
      expr: digital_wallet_provider
      comment: "Digital wallet provider (e.g. Apple Pay, Google Pay, PayPal). Used to track digital wallet adoption and prioritise integration investment."
    - name: "bnpl_provider"
      expr: bnpl_provider
      comment: "Buy Now Pay Later provider (e.g. Klarna, Afterpay). Used to monitor BNPL adoption and associated credit risk exposure."
    - name: "is_active"
      expr: is_active
      comment: "Whether the payment method is currently active. Used to filter to usable payment instruments for checkout conversion analysis."
    - name: "is_default"
      expr: is_default
      comment: "Whether this is the customer's default payment method. Used to understand the primary payment instrument distribution."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the payment method (e.g. verified, pending, failed). Used for fraud risk and checkout readiness analysis."
    - name: "issuing_bank"
      expr: issuing_bank
      comment: "Bank that issued the payment instrument. Used for bank-level acceptance rate and fraud pattern analysis."
    - name: "card_country_code"
      expr: card_country_code
      comment: "Country of the issuing bank. Used for cross-border payment analysis and fraud geo-risk monitoring."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the payment method was added. Used to track payment method enrolment trends over time."
  measures:
    - name: "total_payment_methods"
      expr: COUNT(payment_method_id)
      comment: "Total number of stored payment methods. Baseline metric for payment vault size — used to assess checkout readiness and tokenisation scale."
    - name: "active_payment_method_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN payment_method_id END)
      comment: "Number of currently active payment methods. Measures the live, usable payment instrument pool — directly impacts checkout conversion rates."
    - name: "active_payment_method_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active = TRUE THEN payment_method_id END) / NULLIF(COUNT(payment_method_id), 0), 2)
      comment: "Percentage of stored payment methods that are active. A checkout health KPI — low rates indicate stale or expired instruments that degrade conversion."
    - name: "total_gift_card_balance"
      expr: SUM(CAST(gift_card_balance AS DOUBLE))
      comment: "Total outstanding gift card balance across all payment methods. A financial liability KPI — represents deferred revenue that must be honoured and is monitored by finance."
    - name: "total_store_credit_balance"
      expr: SUM(CAST(store_credit_balance AS DOUBLE))
      comment: "Total outstanding store credit balance across all payment methods. A financial liability KPI representing committed future spend — monitored for redemption forecasting and balance sheet accuracy."
    - name: "avg_gift_card_balance"
      expr: AVG(CAST(gift_card_balance AS DOUBLE))
      comment: "Average gift card balance per payment method record. Used to evaluate gift card utilisation patterns and identify dormant high-balance cards."
    - name: "distinct_customers_with_active_payment"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN profile_id END)
      comment: "Number of unique customers with at least one active payment method on file. Measures checkout-ready customer base size — a key e-commerce conversion enablement metric."
    - name: "verified_payment_method_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'verified' THEN payment_method_id END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN payment_method_id END), 0), 2)
      comment: "Percentage of active payment methods that are fully verified. A fraud risk and checkout quality KPI — unverified instruments increase chargeback and fraud exposure."
$$;