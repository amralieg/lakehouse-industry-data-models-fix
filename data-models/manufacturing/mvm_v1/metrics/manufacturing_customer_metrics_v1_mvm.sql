-- Metric views for domain: customer | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the customer account master — covers account portfolio health, revenue potential, credit exposure, and segmentation quality. Used by Sales, Finance, and CX leadership to steer account strategy and risk management."
  source: "`manufacturing_ecm`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the account (e.g. Active, Inactive, Prospect). Primary filter for active-portfolio analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Direct, Distributor, OEM). Drives channel and go-to-market segmentation."
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "ISO country code of the account billing address. Enables geographic revenue and risk analysis."
    - name: "billing_state_province"
      expr: billing_state_province
      comment: "State or province of the billing address. Supports sub-national territory performance analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the account. Used to bucket accounts by financial risk tier."
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification of the account. Enables vertical-market segmentation and benchmarking."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level tier assigned to the account (e.g. Gold, Silver, Bronze). Drives service prioritisation and resource allocation."
    - name: "is_strategic_account"
      expr: is_strategic_account
      comment: "Boolean flag indicating whether the account is designated as strategic. Used to isolate the strategic portfolio in executive dashboards."
    - name: "is_global_account"
      expr: is_global_account
      comment: "Boolean flag indicating whether the account is managed as a global account. Supports global vs. regional account analysis."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Distribution channel through which the account is served. Enables channel-mix and margin analysis."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales organisation responsible for the account. Supports sales-org performance and coverage analysis."
    - name: "account_source"
      expr: account_source
      comment: "Origin of the account record (e.g. CRM, ERP, Web). Useful for data quality and lead-source attribution."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened. Enables cohort and new-account trend analysis."
    - name: "revenue_currency_code"
      expr: revenue_currency_code
      comment: "Currency in which account revenue is reported. Required for multi-currency revenue normalisation."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of account records. Baseline measure for portfolio size and coverage analysis."
    - name: "active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Count of accounts with Active status. Core KPI for measuring the live customer base size."
    - name: "strategic_accounts"
      expr: COUNT(CASE WHEN is_strategic_account = TRUE THEN 1 END)
      comment: "Count of accounts flagged as strategic. Tracks the size of the high-priority portfolio that receives dedicated resources."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all accounts. Proxy for total addressable wallet and portfolio revenue potential."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per account. Indicates average account size and helps identify revenue concentration risk."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts. Key risk exposure metric for Finance and Credit teams."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account. Benchmarks credit policy generosity and informs credit review cycles."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across accounts. Governs CRM hygiene investment decisions and MDM programme effectiveness."
    - name: "global_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_global_account = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts designated as global. Tracks internationalisation of the customer base and global account programme scale."
    - name: "strategic_account_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_strategic_account = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts designated as strategic. Monitors strategic portfolio concentration and programme eligibility."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and collections KPIs derived from customer credit profiles. Used by Finance, Credit Control, and Risk teams to monitor exposure, overdue balances, DSO trends, and credit utilisation across the customer portfolio."
  source: "`manufacturing_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the profile (e.g. Active, On Hold, Blocked). Primary filter for risk-active accounts."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the customer. Enables risk-tier segmentation of the portfolio."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category classification (e.g. Low, Medium, High). Drives collections strategy and credit limit decisions."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Boolean indicating whether the account is currently on credit hold. Critical operational flag for order fulfilment gating."
    - name: "credit_segment"
      expr: credit_segment
      comment: "Credit segment grouping for the customer. Supports portfolio-level credit policy analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Preferred payment method of the customer. Informs cash flow forecasting and payment risk profiling."
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms code (e.g. NET30, NET60). Drives DSO benchmarking and working capital analysis."
    - name: "collection_strategy_code"
      expr: collection_strategy_code
      comment: "Collections strategy assigned to the account. Enables effectiveness analysis of different collections approaches."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level. Tracks severity of overdue collections across the portfolio."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile. Required for multi-currency exposure normalisation."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "How often the credit profile is reviewed (e.g. Annual, Quarterly). Supports credit governance and review scheduling."
    - name: "last_credit_review_month"
      expr: DATE_TRUNC('MONTH', last_credit_review_date)
      comment: "Month of the last credit review. Enables identification of stale credit profiles requiring refresh."
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(1)
      comment: "Total number of credit profiles. Baseline for portfolio coverage and credit governance completeness."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold. Directly impacts order fulfilment capacity and revenue at risk."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all credit profiles. Represents maximum financial exposure to the customer portfolio."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance. Core accounts-receivable KPI for cash flow and working capital management."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables. Critical collections KPI — directly tied to bad debt risk and cash flow shortfall."
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision held against the portfolio. Key P&L risk metric reviewed by Finance and Audit."
    - name: "avg_credit_utilisation_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilisation percentage across profiles. Indicates how heavily customers are drawing on their credit lines — high utilisation signals liquidity stress."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across credit profiles. Core working capital efficiency KPI — higher DSO means slower cash conversion."
    - name: "avg_payment_behaviour_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behaviour score across the portfolio. Predictive indicator of future payment risk and collections effort required."
    - name: "credit_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles currently on hold. Tracks portfolio-level credit risk concentration and order fulfilment risk."
    - name: "overdue_to_outstanding_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(overdue_amount AS DOUBLE)) / NULLIF(SUM(CAST(outstanding_balance AS DOUBLE)), 0), 2)
      comment: "Overdue amount as a percentage of total outstanding balance. Measures the quality of the receivables book — higher ratio signals deteriorating collections performance."
    - name: "avg_early_payment_discount_pct"
      expr: AVG(CAST(early_payment_discount_pct AS DOUBLE))
      comment: "Average early payment discount offered across profiles. Informs the cost of accelerating cash collection and discount policy calibration."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_account_site`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPIs for customer installation sites — covers site portfolio composition, manufacturing capability, maintenance scheduling, and operational readiness. Used by Field Service, Operations, and Account Management to prioritise site investments and service delivery."
  source: "`manufacturing_ecm`.`customer`.`account_site`"
  dimensions:
    - name: "site_status"
      expr: site_status
      comment: "Operational status of the site (e.g. Active, Decommissioned, Under Construction). Primary filter for live site analysis."
    - name: "site_type"
      expr: site_type
      comment: "Classification of the site (e.g. Manufacturing Plant, Warehouse, Office). Drives service model and resource allocation decisions."
    - name: "site_criticality_rating"
      expr: site_criticality_rating
      comment: "Criticality rating of the site (e.g. Critical, High, Medium, Low). Determines maintenance priority and SLA tier assignment."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier assigned to the site. Governs response time commitments and field service resource allocation."
    - name: "industry_segment"
      expr: industry_segment
      comment: "Industry vertical of the site. Enables vertical-market analysis of the installed base."
    - name: "safety_classification"
      expr: safety_classification
      comment: "Safety classification of the site. Required for regulatory compliance reporting and HSE risk management."
    - name: "environmental_classification"
      expr: environmental_classification
      comment: "Environmental classification of the site. Supports sustainability reporting and environmental compliance tracking."
    - name: "mes_system_present"
      expr: mes_system_present
      comment: "Boolean indicating whether a Manufacturing Execution System is present. Tracks digital manufacturing maturity of the installed base."
    - name: "scada_system_present"
      expr: scada_system_present
      comment: "Boolean indicating whether a SCADA system is present. Tracks automation and remote monitoring capability across sites."
    - name: "operates_24x7"
      expr: operates_24x7
      comment: "Boolean indicating 24x7 operation. Drives SLA design, on-call staffing, and parts availability planning."
    - name: "is_headquarters"
      expr: is_headquarters
      comment: "Boolean indicating whether the site is the account headquarters. Supports account hierarchy and primary contact routing."
    - name: "commissioning_date_year"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year the site was commissioned. Enables installed-base vintage analysis and proactive lifecycle management."
    - name: "next_scheduled_maintenance_month"
      expr: DATE_TRUNC('MONTH', next_scheduled_maintenance_date)
      comment: "Month of next scheduled maintenance. Supports field service capacity planning and maintenance backlog management."
  measures:
    - name: "total_sites"
      expr: COUNT(1)
      comment: "Total number of customer sites. Baseline measure for installed-base size and field service coverage scope."
    - name: "active_sites"
      expr: COUNT(CASE WHEN site_status = 'Active' THEN 1 END)
      comment: "Count of operationally active sites. Core KPI for live installed-base management and service delivery planning."
    - name: "sites_with_mes"
      expr: COUNT(CASE WHEN mes_system_present = TRUE THEN 1 END)
      comment: "Number of sites with a Manufacturing Execution System. Tracks digital manufacturing penetration across the customer base."
    - name: "sites_with_scada"
      expr: COUNT(CASE WHEN scada_system_present = TRUE THEN 1 END)
      comment: "Number of sites with SCADA systems. Measures automation and remote monitoring capability — key for upsell of connected services."
    - name: "sites_operating_24x7"
      expr: COUNT(CASE WHEN operates_24x7 = TRUE THEN 1 END)
      comment: "Number of sites operating 24x7. Drives on-call staffing requirements and premium SLA contract sizing."
    - name: "total_plant_floor_area_sqm"
      expr: SUM(CAST(plant_floor_area_sqm AS DOUBLE))
      comment: "Total plant floor area in square metres across all sites. Proxy for installed-base scale and potential equipment density."
    - name: "avg_plant_floor_area_sqm"
      expr: AVG(CAST(plant_floor_area_sqm AS DOUBLE))
      comment: "Average plant floor area per site. Benchmarks site size and informs equipment and service capacity planning."
    - name: "mes_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mes_system_present = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with MES present. Strategic KPI for digital transformation programme tracking and upsell opportunity sizing."
    - name: "scada_penetration_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN scada_system_present = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sites with SCADA present. Tracks automation maturity and remote monitoring service attach rate."
    - name: "critical_sites_24x7_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN site_criticality_rating = 'Critical' AND operates_24x7 = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN site_criticality_rating = 'Critical' THEN 1 END), 0), 2)
      comment: "Percentage of critical-rated sites that operate 24x7. Identifies the highest-risk service coverage requirement for SLA design and on-call resource planning."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA portfolio KPIs covering contract value, service commitment levels, renewal risk, and penalty exposure. Used by Service Operations, Finance, and Account Management to manage SLA performance, renewal pipeline, and contractual risk."
  source: "`manufacturing_ecm`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (e.g. Active, Expired, Pending Renewal). Primary filter for live contract portfolio analysis."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. Full Service, Preventive Maintenance, Remote Monitoring). Drives service model and cost-to-serve analysis."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier of the agreement (e.g. Platinum, Gold, Silver). Governs resource prioritisation and response time commitments."
    - name: "service_region"
      expr: service_region
      comment: "Geographic region covered by the SLA. Enables regional service capacity and revenue analysis."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency of the agreement (e.g. Monthly, Quarterly, Annual). Impacts cash flow forecasting and revenue recognition."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SLA agreement. Required for multi-currency contract value reporting."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Boolean indicating whether the agreement auto-renews. Identifies contracts requiring proactive renewal management."
    - name: "penalty_clause_applicable"
      expr: penalty_clause_applicable
      comment: "Boolean indicating whether a penalty clause applies. Flags agreements with financial downside risk from SLA breaches."
    - name: "field_service_included"
      expr: field_service_included
      comment: "Boolean indicating whether field service is included. Drives field service resource demand forecasting."
    - name: "preventive_maintenance_included"
      expr: preventive_maintenance_included
      comment: "Boolean indicating whether preventive maintenance is included. Tracks PM programme scope and scheduling requirements."
    - name: "remote_monitoring_included"
      expr: remote_monitoring_included
      comment: "Boolean indicating whether remote monitoring is included. Measures connected services attach rate across the SLA portfolio."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the SLA became effective. Enables cohort analysis of contract vintage and renewal cycle planning."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the SLA expires. Critical for renewal pipeline management and revenue-at-risk forecasting."
  measures:
    - name: "total_sla_agreements"
      expr: COUNT(1)
      comment: "Total number of SLA agreements. Baseline measure for service contract portfolio size."
    - name: "active_sla_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN 1 END)
      comment: "Count of currently active SLA agreements. Core KPI for live service contract coverage and recurring revenue base."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all SLA agreements. Primary revenue KPI for the service contracts business."
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annualised fee across all SLA agreements. Represents the recurring service revenue run rate."
    - name: "avg_annual_fee_per_agreement"
      expr: AVG(CAST(annual_fee AS DOUBLE))
      comment: "Average annual fee per SLA agreement. Benchmarks contract size and informs pricing strategy for new agreements."
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average contracted uptime target across SLA agreements. Reflects the service commitment level and operational risk the company has accepted."
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average contracted initial response time in hours. Tracks the stringency of response commitments across the portfolio."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average contracted resolution time in hours. Measures the overall service intensity of the SLA portfolio."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across agreements. Tracks logistics and fulfilment commitment levels embedded in SLAs."
    - name: "agreements_with_penalty_clause"
      expr: COUNT(CASE WHEN penalty_clause_applicable = TRUE THEN 1 END)
      comment: "Number of agreements with an active penalty clause. Quantifies the portfolio exposure to financial penalties from SLA breaches."
    - name: "penalty_clause_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN penalty_clause_applicable = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA agreements carrying a penalty clause. Tracks financial risk concentration in the service contract portfolio."
    - name: "remote_monitoring_attach_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_monitoring_included = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SLA agreements that include remote monitoring. Strategic KPI for connected services penetration and digital service revenue growth."
    - name: "auto_renewal_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN auto_renewal = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of agreements set to auto-renew. Indicates recurring revenue stickiness and renewal risk exposure for non-auto agreements."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_contact`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer contact quality, engagement, and coverage KPIs. Used by Sales, Marketing, and CX teams to assess contact database health, decision-maker coverage, and marketing consent compliance."
  source: "`manufacturing_ecm`.`customer`.`customer_contact`"
  dimensions:
    - name: "customer_contact_status"
      expr: customer_contact_status
      comment: "Status of the contact record (e.g. Active, Inactive, Unsubscribed). Primary filter for reachable contact analysis."
    - name: "contact_type"
      expr: contact_type
      comment: "Type of contact (e.g. Technical, Commercial, Executive). Enables role-based coverage analysis."
    - name: "job_title"
      expr: job_title
      comment: "Job title of the contact. Supports persona-based segmentation and decision-maker identification."
    - name: "department"
      expr: department
      comment: "Department of the contact. Enables departmental coverage analysis within accounts."
    - name: "persona"
      expr: persona
      comment: "Marketing or sales persona assigned to the contact. Drives targeted campaign and content strategy."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Preferred channel for outreach (e.g. Email, Phone, LinkedIn). Informs multi-channel engagement strategy."
    - name: "lead_source"
      expr: lead_source
      comment: "Source through which the contact was acquired. Enables lead-source ROI and channel attribution analysis."
    - name: "is_decision_maker"
      expr: is_decision_maker
      comment: "Boolean indicating whether the contact is a decision maker. Critical for sales coverage and deal acceleration analysis."
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Boolean indicating whether the contact is the primary contact for the account. Supports account coverage completeness tracking."
    - name: "marketing_opt_in"
      expr: marketing_opt_in
      comment: "Boolean indicating marketing consent. Required for GDPR-compliant campaign targeting and consent rate monitoring."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier of the contact. Enables service-tier-based contact prioritisation."
    - name: "mailing_country_code"
      expr: mailing_country_code
      comment: "Country of the contact mailing address. Supports geographic coverage and regional engagement analysis."
    - name: "last_activity_month"
      expr: DATE_TRUNC('MONTH', last_activity_date)
      comment: "Month of last recorded activity. Enables contact engagement recency analysis and dormant contact identification."
  measures:
    - name: "total_contacts"
      expr: COUNT(1)
      comment: "Total number of customer contacts. Baseline measure for contact database size and coverage."
    - name: "active_contacts"
      expr: COUNT(CASE WHEN customer_contact_status = 'Active' THEN 1 END)
      comment: "Count of active contacts. Represents the reachable contact universe for sales and marketing engagement."
    - name: "decision_maker_contacts"
      expr: COUNT(CASE WHEN is_decision_maker = TRUE THEN 1 END)
      comment: "Count of contacts identified as decision makers. Critical KPI for sales coverage — insufficient decision-maker contacts correlates with longer sales cycles."
    - name: "marketing_opted_in_contacts"
      expr: COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END)
      comment: "Count of contacts with active marketing consent. Defines the legally reachable marketing audience size."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across contacts. Governs CRM hygiene investment and MDM programme effectiveness for the contact domain."
    - name: "decision_maker_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_decision_maker = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contacts who are decision makers. Tracks sales coverage quality — low rates indicate insufficient executive engagement."
    - name: "marketing_consent_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN marketing_opt_in = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contacts with marketing opt-in consent. GDPR compliance KPI and indicator of addressable marketing audience health."
    - name: "do_not_call_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN do_not_call = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contacts flagged as do-not-call. Tracks outreach restriction prevalence and its impact on telesales capacity."
    - name: "technical_contact_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_contact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contacts flagged as technical contacts. Measures technical stakeholder coverage — important for complex solution sales and post-sale support."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio KPIs covering segment economics, revenue targets, credit policy, and discount structure. Used by Sales Strategy, Finance, and Marketing to design and govern customer segmentation programmes."
  source: "`manufacturing_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Status of the segment (e.g. Active, Inactive, Under Review). Primary filter for live segment analysis."
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. Strategic, Growth, Transactional). Drives differentiated go-to-market and service model design."
    - name: "channel_type"
      expr: channel_type
      comment: "Distribution channel associated with the segment. Enables channel-mix analysis across the segment portfolio."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment. Supports regional segment performance and coverage analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical targeted by the segment. Enables vertical-market strategy and revenue concentration analysis."
    - name: "pricing_tier_code"
      expr: pricing_tier_code
      comment: "Pricing tier assigned to the segment. Governs price book selection and margin management."
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier code for the segment. Drives service level commitments and cost-to-serve modelling."
    - name: "strategic_account_flag"
      expr: strategic_account_flag
      comment: "Boolean indicating whether the segment is designated as strategic. Identifies segments receiving dedicated account management resources."
    - name: "rebate_eligible"
      expr: rebate_eligible
      comment: "Boolean indicating whether accounts in this segment are eligible for rebates. Tracks rebate programme scope and financial liability."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the segment became effective. Enables segment vintage and lifecycle analysis."
  measures:
    - name: "total_segments"
      expr: COUNT(1)
      comment: "Total number of customer segments. Baseline measure for segmentation programme complexity and coverage."
    - name: "active_segments"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN 1 END)
      comment: "Count of active segments. Tracks the live segmentation structure used for go-to-market execution."
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total revenue target across all segments in USD. Aggregates the revenue ambition of the segmentation programme — used in annual planning."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average target gross margin percentage across segments. Benchmarks the margin ambition of the segment portfolio and informs pricing strategy."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit allocated across segments in USD. Represents the aggregate credit policy exposure by segment design."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate across segments. Tracks the overall discount burden embedded in the segmentation structure — high rates erode margin."
    - name: "avg_revenue_band_max_usd"
      expr: AVG(CAST(revenue_band_max AS DOUBLE))
      comment: "Average upper revenue band threshold across segments. Indicates the revenue ceiling used to qualify accounts into segments."
    - name: "rebate_eligible_segment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rebate_eligible = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments with rebate eligibility. Tracks the scope of the rebate programme and associated financial liability."
    - name: "strategic_segment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN strategic_account_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of segments designated as strategic. Monitors the concentration of strategic focus in the segmentation model."
$$;