-- Metric views for domain: customer | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 08:28:29

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the customer account master — tracks portfolio health, revenue potential, credit exposure, and account lifecycle for executive steering."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Classifies accounts (e.g. Direct, Distributor, OEM) for segment-level analysis."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Inactive, Prospect, Churned)."
    - name: "sla_tier"
      expr: sla_tier
      comment: "Service level tier assigned to the account, used to stratify KPIs by service commitment."
    - name: "industry_naics_code"
      expr: industry_naics_code
      comment: "NAICS industry classification enabling vertical-level performance analysis."
    - name: "sales_organization_code"
      expr: sales_organization_code
      comment: "Sales org responsible for the account, enabling org-level portfolio analysis."
    - name: "distribution_channel_code"
      expr: distribution_channel_code
      comment: "Go-to-market channel (Direct, Indirect, eCommerce) for channel mix analysis."
    - name: "is_global_account"
      expr: is_global_account
      comment: "Flag indicating whether the account is managed as a global account."
    - name: "open_date_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened, used for cohort and vintage analysis."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Count of active customer accounts — baseline portfolio size metric for executive dashboards."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of reported annual revenue across all accounts — indicates total addressable wallet in the portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per customer account — signals account quality and upsell potential."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — key risk management metric for CFO and credit teams."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — benchmarks credit policy consistency across the portfolio."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average MDM data quality score across accounts — low scores indicate data governance risk affecting downstream analytics."
    - name: "global_account_count"
      expr: COUNT(CASE WHEN is_global_account = TRUE THEN customer_account_id END)
      comment: "Number of accounts flagged as global — tracks strategic global account program scale."
    - name: "accounts_opened_in_period"
      expr: COUNT(CASE WHEN open_date IS NOT NULL THEN customer_account_id END)
      comment: "Count of accounts with a recorded open date — used to track new account acquisition velocity."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk KPIs derived from customer credit profiles — monitors overdue exposure, credit utilization, and DSO to steer collections and credit policy decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "risk_category"
      expr: risk_category
      comment: "Credit risk category (Low, Medium, High) for risk-stratified analysis."
    - name: "dunning_level"
      expr: dunning_level
      comment: "Current dunning escalation level — indicates collections urgency."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether the account is currently on credit hold — critical operational flag."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile for multi-currency portfolio analysis."
    - name: "last_credit_review_month"
      expr: DATE_TRUNC('MONTH', last_credit_review_date)
      comment: "Month of last credit review — used to identify stale credit assessments."
  measures:
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding AR balance across all credit profiles — primary receivables exposure metric for CFO."
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue balance across all accounts — drives collections prioritization and bad debt provisioning."
    - name: "total_bad_debt_provision"
      expr: SUM(CAST(bad_debt_provision_amount AS DOUBLE))
      comment: "Total bad debt provision held — reflects expected credit loss and impacts P&L."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across accounts — high utilization signals liquidity stress in the customer base."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding — core cash conversion metric; rising DSO signals collections deterioration."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of accounts currently on credit hold — operational risk indicator for order management and sales."
    - name: "avg_payment_behavior_score"
      expr: AVG(CAST(payment_behavior_score AS DOUBLE))
      comment: "Average payment behavior score across the portfolio — predictive indicator of future payment risk."
    - name: "total_credit_insurance_coverage"
      expr: SUM(CAST(credit_insurance_coverage_limit AS DOUBLE))
      comment: "Total credit insurance coverage limit in force — measures risk mitigation coverage against the outstanding balance."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead pipeline and conversion KPIs — tracks lead volume, estimated deal value, and conversion performance to steer demand generation and sales investment decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead (New, Working, Qualified, Converted, Disqualified)."
    - name: "lead_source"
      expr: lead_source
      comment: "Origin channel of the lead (Web, Event, Referral, Campaign) for marketing ROI analysis."
    - name: "lead_type"
      expr: lead_type
      comment: "Type of lead (Inbound, Outbound, Partner) for pipeline mix analysis."
    - name: "buying_stage"
      expr: buying_stage
      comment: "Buyer journey stage — indicates readiness to purchase and pipeline velocity."
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for regional pipeline performance analysis."
    - name: "company_industry"
      expr: company_industry
      comment: "Industry vertical of the lead company for vertical-level demand analysis."
    - name: "is_converted"
      expr: is_converted
      comment: "Whether the lead has been converted to an account/opportunity."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the lead was created — used for lead volume trend and cohort analysis."
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads in the pipeline — baseline demand generation volume metric."
    - name: "converted_leads"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN customer_lead_id END)
      comment: "Number of leads successfully converted — measures sales pipeline effectiveness."
    - name: "lead_conversion_rate_numerator"
      expr: COUNT(CASE WHEN is_converted = TRUE THEN customer_lead_id END)
      comment: "Numerator for lead conversion rate calculation (converted leads). Divide by total_leads to get conversion rate."
    - name: "total_estimated_deal_value"
      expr: SUM(CAST(estimated_deal_value AS DOUBLE))
      comment: "Total estimated deal value across all open leads — measures pipeline value for revenue forecasting."
    - name: "avg_estimated_deal_value"
      expr: AVG(CAST(estimated_deal_value AS DOUBLE))
      comment: "Average estimated deal value per lead — indicates deal size trends and target segment quality."
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue of lead companies — measures total addressable revenue in the pipeline."
    - name: "avg_annual_energy_consumption_mwh"
      expr: AVG(CAST(annual_energy_consumption_mwh AS DOUBLE))
      comment: "Average annual energy consumption of lead companies in MWh — relevant for industrial/energy solution sizing and targeting."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_sla_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA portfolio KPIs — monitors service commitment coverage, financial value, and performance targets to steer service operations and contract renewal decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`sla_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the SLA agreement (Active, Expired, Pending, Terminated)."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (Response, Resolution, Uptime, Delivery) for service tier analysis."
    - name: "service_tier"
      expr: service_tier
      comment: "Service tier level (Gold, Silver, Bronze) for tiered performance benchmarking."
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing cadence (Monthly, Quarterly, Annual) for revenue recognition planning."
    - name: "auto_renewal"
      expr: auto_renewal
      comment: "Whether the agreement auto-renews — impacts renewal pipeline and churn risk."
    - name: "field_service_included"
      expr: field_service_included
      comment: "Whether field service visits are included — drives field service capacity planning."
    - name: "effective_date_month"
      expr: DATE_TRUNC('MONTH', effective_date)
      comment: "Month the SLA became effective — used for contract vintage and cohort analysis."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month the SLA expires — used for renewal pipeline forecasting."
  measures:
    - name: "total_active_sla_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN sla_agreement_id END)
      comment: "Number of active SLA agreements — measures the scale of the contracted service portfolio."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all SLA agreements — key revenue backlog metric for service business."
    - name: "total_annual_fee"
      expr: SUM(CAST(annual_fee AS DOUBLE))
      comment: "Total annual recurring fee from SLA agreements — measures annualized service revenue."
    - name: "avg_uptime_target_pct"
      expr: AVG(CAST(uptime_target_pct AS DOUBLE))
      comment: "Average contracted uptime target — benchmarks service commitment level across the portfolio."
    - name: "avg_initial_response_time_hours"
      expr: AVG(CAST(initial_response_time_hours AS DOUBLE))
      comment: "Average contracted initial response time in hours — measures service responsiveness commitment."
    - name: "avg_resolution_time_hours"
      expr: AVG(CAST(resolution_time_hours AS DOUBLE))
      comment: "Average contracted resolution time in hours — key service quality commitment metric."
    - name: "agreements_expiring_count"
      expr: COUNT(CASE WHEN expiry_date <= CURRENT_DATE AND agreement_status = 'Active' THEN sla_agreement_id END)
      comment: "Count of active agreements that have reached or passed their expiry date — drives renewal urgency and churn risk management."
    - name: "avg_on_time_delivery_target_pct"
      expr: AVG(CAST(on_time_delivery_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across SLA agreements — aligns logistics and supply chain to customer commitments."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Entitlement utilization and coverage KPIs — tracks consumed vs. allocated service entitlements to identify under-utilized contracts and at-risk customers."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_entitlement`"
  dimensions:
    - name: "entitlement_type"
      expr: entitlement_type
      comment: "Type of entitlement (Warranty, Service Contract, Support Plan) for coverage mix analysis."
    - name: "customer_entitlement_status"
      expr: customer_entitlement_status
      comment: "Current status of the entitlement (Active, Expired, Suspended)."
    - name: "coverage_type"
      expr: coverage_type
      comment: "Coverage scope (Parts, Labor, Full) for entitlement value analysis."
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier associated with the entitlement for tiered service analysis."
    - name: "is_active"
      expr: is_active
      comment: "Whether the entitlement is currently active."
    - name: "auto_renew"
      expr: auto_renew
      comment: "Whether the entitlement auto-renews — impacts renewal revenue forecasting."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the entitlement started — used for cohort and vintage analysis."
  measures:
    - name: "total_active_entitlements"
      expr: COUNT(CASE WHEN is_active = TRUE THEN customer_entitlement_id END)
      comment: "Number of active customer entitlements — measures the scale of the service coverage portfolio."
    - name: "total_contracted_value"
      expr: SUM(CAST(contracted_value AS DOUBLE))
      comment: "Total contracted value of all entitlements — measures the financial scale of the entitlement portfolio."
    - name: "total_service_hours_allocated"
      expr: SUM(CAST(service_hours_allocation AS DOUBLE))
      comment: "Total service hours allocated across all entitlements — drives field service capacity planning."
    - name: "total_service_hours_consumed"
      expr: SUM(CAST(service_hours_consumed AS DOUBLE))
      comment: "Total service hours consumed — measures actual service delivery against contracted allocation."
    - name: "avg_service_hours_utilization_pct_numerator"
      expr: SUM(CAST(service_hours_consumed AS DOUBLE))
      comment: "Numerator for service hours utilization rate. Divide by total_service_hours_allocated to compute utilization percentage."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining entitlement quantity across all active entitlements — identifies unused capacity and renewal opportunity."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total quantity consumed across all entitlements — measures entitlement burn rate."
    - name: "total_spare_parts_credit_limit"
      expr: SUM(CAST(spare_parts_credit_limit AS DOUBLE))
      comment: "Total spare parts credit limit across entitlements — measures parts coverage exposure for supply chain planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hierarchy KPIs — measures ownership concentration, credit rollup eligibility, and hierarchy health to support global account management and consolidation decisions."
  source: "`vibe_manufacturing_v1`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Status of the hierarchy relationship (Active, Inactive, Pending)."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the hierarchy (Global, Regional, Local) for rollup analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Tier classification of the account within the hierarchy."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the hierarchy (Global, Regional, Country) for territory analysis."
    - name: "credit_rollup_eligible"
      expr: credit_rollup_eligible
      comment: "Whether credit limits roll up through this hierarchy node — critical for consolidated credit risk management."
    - name: "revenue_rollup_eligible_flag"
      expr: CASE WHEN revenue_rollup_eligible > 0 THEN TRUE ELSE FALSE END
      comment: "Derived flag indicating whether revenue rolls up through this hierarchy node."
  measures:
    - name: "total_hierarchy_relationships"
      expr: COUNT(1)
      comment: "Total number of account hierarchy relationships — measures the complexity and scale of the account structure."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships — indicates consolidation concentration for financial reporting."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across hierarchy records — low scores indicate MDM gaps that distort consolidated reporting."
    - name: "credit_rollup_eligible_count"
      expr: COUNT(CASE WHEN credit_rollup_eligible = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchy nodes eligible for credit rollup — measures consolidated credit risk exposure scope."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding efficiency KPIs — tracks onboarding completion rates, SLA breaches, and time-to-first-order to steer onboarding process improvement and resource allocation."
  source: "`vibe_manufacturing_v1`.`customer`.`customer_onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process (In Progress, Completed, Blocked, Cancelled)."
    - name: "stage"
      expr: stage
      comment: "Current onboarding stage (KYC, Credit Setup, ERP Setup, Training) for funnel analysis."
    - name: "account_type"
      expr: account_type
      comment: "Type of account being onboarded for segment-level onboarding performance analysis."
    - name: "account_segment"
      expr: account_segment
      comment: "Customer segment for the onboarding record — enables segment-level SLA and completion analysis."
    - name: "sla_breach_flag"
      expr: sla_breach_flag
      comment: "Whether the onboarding SLA has been breached — critical operational quality indicator."
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the onboarding has been escalated — indicates process risk and resource need."
    - name: "initiated_month"
      expr: DATE_TRUNC('MONTH', initiated_timestamp)
      comment: "Month onboarding was initiated — used for volume trend and cohort analysis."
  measures:
    - name: "total_onboardings"
      expr: COUNT(1)
      comment: "Total number of customer onboarding records — baseline volume metric for onboarding capacity planning."
    - name: "completed_onboardings"
      expr: COUNT(CASE WHEN onboarding_status = 'Completed' THEN customer_onboarding_id END)
      comment: "Number of successfully completed onboardings — measures onboarding throughput."
    - name: "sla_breach_count"
      expr: COUNT(CASE WHEN sla_breach_flag = TRUE THEN customer_onboarding_id END)
      comment: "Number of onboardings that breached the SLA target — key process quality metric driving corrective action."
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage across active onboardings — measures onboarding progress and identifies bottlenecks."
    - name: "avg_credit_limit_approved"
      expr: AVG(CAST(credit_limit_approved AS DOUBLE))
      comment: "Average credit limit approved during onboarding — benchmarks credit policy application consistency."
    - name: "total_credit_limit_approved"
      expr: SUM(CAST(credit_limit_approved AS DOUBLE))
      comment: "Total credit limit approved across all onboarded customers — measures new credit exposure created through onboarding."
    - name: "first_order_readiness_count"
      expr: COUNT(CASE WHEN first_order_readiness_flag = TRUE THEN customer_onboarding_id END)
      comment: "Number of onboardings where the customer is ready to place their first order — measures pipeline readiness for revenue activation."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer interaction engagement KPIs — measures interaction volume, sentiment, and follow-up discipline to steer customer success and relationship health management."
  source: "`vibe_manufacturing_v1`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of interaction (Call, Meeting, Email, Site Visit) for channel engagement analysis."
    - name: "interaction_status"
      expr: interaction_status
      comment: "Status of the interaction (Completed, Planned, Cancelled) for pipeline hygiene."
    - name: "channel"
      expr: channel
      comment: "Communication channel used for the interaction — drives channel mix optimization."
    - name: "sentiment_category"
      expr: sentiment_category
      comment: "Sentiment classification (Positive, Neutral, Negative) for customer health scoring."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the interaction (Deal Progressed, Issue Resolved, No Action) for effectiveness analysis."
    - name: "is_customer_complaint"
      expr: is_customer_complaint
      comment: "Whether the interaction was a customer complaint — used to track complaint volume and escalation."
    - name: "interaction_date_month"
      expr: DATE_TRUNC('MONTH', interaction_date)
      comment: "Month of the interaction — used for engagement trend and seasonality analysis."
  measures:
    - name: "total_interactions"
      expr: COUNT(1)
      comment: "Total number of customer interactions — baseline engagement volume metric for customer success teams."
    - name: "total_complaint_interactions"
      expr: COUNT(CASE WHEN is_customer_complaint = TRUE THEN interaction_id END)
      comment: "Number of interactions flagged as customer complaints — key customer satisfaction risk indicator."
    - name: "avg_interaction_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration of customer interactions in minutes — measures engagement depth and resource consumption."
    - name: "total_interaction_duration_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total time invested in customer interactions — measures customer success resource allocation."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN interaction_id END)
      comment: "Number of interactions requiring follow-up action — measures open action backlog for account managers."
    - name: "unique_customers_engaged"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Number of distinct customer accounts with recorded interactions — measures breadth of active customer engagement."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment portfolio KPIs — tracks segment revenue targets, discount policies, and strategic account concentration to steer go-to-market and pricing strategy."
  source: "`vibe_manufacturing_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (Industry, Geographic, Behavioral) for segmentation strategy analysis."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (Active, Inactive, Under Review)."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical associated with the segment for vertical-level performance analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the segment for regional strategy analysis."
    - name: "pricing_tier_code"
      expr: pricing_tier_code
      comment: "Pricing tier assigned to the segment — drives pricing strategy and margin analysis."
    - name: "rebate_eligible"
      expr: rebate_eligible
      comment: "Whether accounts in this segment are eligible for rebates — impacts margin planning."
  measures:
    - name: "total_active_segments"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Number of active customer segments — measures go-to-market segmentation coverage."
    - name: "total_target_revenue_usd"
      expr: SUM(CAST(target_revenue_usd AS DOUBLE))
      comment: "Total revenue target across all segments — measures aggregate revenue ambition for planning."
    - name: "avg_target_gross_margin_pct"
      expr: AVG(CAST(target_gross_margin_pct AS DOUBLE))
      comment: "Average target gross margin percentage across segments — benchmarks profitability expectations by segment."
    - name: "avg_discount_rate_pct"
      expr: AVG(CAST(discount_rate_pct AS DOUBLE))
      comment: "Average discount rate applied across segments — measures pricing concession level and margin risk."
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit allocated across all segments — measures aggregate credit risk exposure by segment portfolio."
$$;