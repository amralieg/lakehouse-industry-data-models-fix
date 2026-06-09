-- Metric views for domain: customer | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 19:31:38

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account portfolio health, credit exposure, and account lifecycle for strategic customer management decisions."
  source: "`transport_shipping_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, inactive, suspended, closed)"
    - name: "account_tier"
      expr: account_tier
      comment: "Customer tier classification indicating strategic importance and service level"
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account (corporate, SME, individual, government)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry sector the customer operates in for vertical analysis"
    - name: "billing_country_code"
      expr: billing_country_code
      comment: "Country of billing address for geographic segmentation"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account (good, hold, suspended)"
    - name: "preferred_service_mode"
      expr: preferred_service_mode
      comment: "Customer preferred transport mode (air, ocean, road, rail, multimodal)"
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the customer for service level differentiation"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the customer was onboarded for cohort analysis"
    - name: "aeo_certified_flag"
      expr: CASE WHEN aeo_certified = true THEN 'AEO Certified' ELSE 'Not Certified' END
      comment: "Whether the customer holds Authorized Economic Operator certification"
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of customer accounts in the portfolio"
    - name: "active_accounts"
      expr: SUM(CASE WHEN account_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active customer accounts"
    - name: "total_credit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts representing financial exposure"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account indicating typical credit appetite"
    - name: "accounts_on_credit_hold"
      expr: SUM(CASE WHEN credit_status = 'hold' THEN 1 ELSE 0 END)
      comment: "Number of accounts currently on credit hold requiring attention"
    - name: "kyc_verified_accounts"
      expr: SUM(CASE WHEN kyc_verified = true THEN 1 ELSE 0 END)
      comment: "Count of accounts that have completed KYC verification for compliance tracking"
    - name: "edi_capable_accounts"
      expr: SUM(CASE WHEN edi_capable = true THEN 1 ELSE 0 END)
      comment: "Count of accounts with EDI integration capability for digital maturity assessment"
    - name: "aeo_certified_accounts"
      expr: SUM(CASE WHEN aeo_certified = true THEN 1 ELSE 0 END)
      comment: "Count of AEO-certified accounts for customs facilitation and trade compliance reporting"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and financial health metrics for monitoring portfolio credit exposure, delinquency, and payment behavior across the customer base."
  source: "`transport_shipping_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the profile (active, suspended, closed)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "External or internal credit rating assigned to the customer"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification for portfolio risk segmentation"
    - name: "payment_behavior_code"
      expr: payment_behavior_code
      comment: "Code indicating historical payment behavior pattern"
    - name: "payment_terms_code"
      expr: payment_terms_code
      comment: "Payment terms assigned to the customer"
    - name: "credit_control_area"
      expr: credit_control_area
      comment: "Credit control area for regional credit management"
    - name: "profile_type"
      expr: profile_type
      comment: "Type of credit profile for categorization"
    - name: "credit_hold_flag"
      expr: CASE WHEN credit_hold_flag = true THEN 'On Hold' ELSE 'Active' END
      comment: "Whether the account is currently on credit hold"
  measures:
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total approved credit limit across all profiles representing maximum exposure"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance owed by customers"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue amount requiring collections action"
    - name: "avg_days_sales_outstanding"
      expr: AVG(CAST(days_sales_outstanding AS DOUBLE))
      comment: "Average DSO indicating cash collection efficiency"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_limit_utilization_pct AS DOUBLE))
      comment: "Average credit limit utilization percentage across portfolio"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit headroom across all customers"
    - name: "total_open_order_exposure"
      expr: SUM(CAST(open_order_exposure AS DOUBLE))
      comment: "Total exposure from open orders not yet invoiced"
    - name: "profiles_on_hold"
      expr: SUM(CASE WHEN credit_hold_flag = true THEN 1 ELSE 0 END)
      comment: "Count of credit profiles currently on hold"
    - name: "total_security_deposits"
      expr: SUM(CAST(security_deposit_amount AS DOUBLE))
      comment: "Total security deposits held as credit risk mitigation"
    - name: "credit_insured_profiles"
      expr: SUM(CASE WHEN credit_insurance_flag = true THEN 1 ELSE 0 END)
      comment: "Count of profiles covered by credit insurance"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales pipeline and revenue opportunity metrics for tracking deal flow, conversion, and projected revenue growth in the logistics business."
  source: "`transport_shipping_ecm`.`customer`.`opportunity`"
  dimensions:
    - name: "stage"
      expr: stage
      comment: "Current stage in the sales pipeline (prospecting, qualification, proposal, negotiation, closed)"
    - name: "primary_service_line"
      expr: primary_service_line
      comment: "Primary logistics service line (express, freight, supply chain, ecommerce)"
    - name: "sales_region"
      expr: sales_region
      comment: "Geographic sales region for territory performance analysis"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Target customer segment for the opportunity"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast classification (pipeline, best case, commit, closed)"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (new business, expansion, renewal, cross-sell)"
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel that generated the opportunity"
    - name: "origin_region"
      expr: origin_region
      comment: "Origin region of the trade lane for the opportunity"
    - name: "destination_region"
      expr: destination_region
      comment: "Destination region of the trade lane for the opportunity"
    - name: "is_strategic"
      expr: CASE WHEN is_strategic = true THEN 'Strategic' ELSE 'Standard' END
      comment: "Whether the opportunity is flagged as strategically important"
  measures:
    - name: "total_pipeline_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Total estimated annual revenue in the pipeline"
    - name: "weighted_pipeline_revenue"
      expr: SUM(CAST(estimated_annual_revenue AS DOUBLE) * CAST(close_probability_pct AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline revenue for forecasting"
    - name: "avg_deal_size"
      expr: AVG(CAST(estimated_annual_revenue AS DOUBLE))
      comment: "Average estimated annual revenue per opportunity indicating deal quality"
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the pipeline"
    - name: "avg_close_probability"
      expr: AVG(CAST(close_probability_pct AS DOUBLE))
      comment: "Average close probability across opportunities indicating pipeline health"
    - name: "total_estimated_teu"
      expr: SUM(CAST(estimated_annual_teu AS DOUBLE))
      comment: "Total estimated annual TEU volume in the pipeline for capacity planning"
    - name: "strategic_opportunities"
      expr: SUM(CASE WHEN is_strategic = true THEN 1 ELSE 0 END)
      comment: "Count of strategically important opportunities requiring executive attention"
    - name: "total_estimated_weight_kg"
      expr: SUM(CAST(estimated_annual_weight_kg AS DOUBLE))
      comment: "Total estimated annual weight in pipeline for network capacity planning"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service quality and operational performance metrics tracking case resolution, SLA compliance, and customer satisfaction for service excellence management."
  source: "`transport_shipping_ecm`.`customer`.`service_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case (open, in progress, resolved, closed)"
    - name: "case_type"
      expr: case_type
      comment: "Category of service case (delivery issue, billing, customs, damage, delay)"
    - name: "priority"
      expr: priority
      comment: "Case priority level (critical, high, medium, low)"
    - name: "account_segment"
      expr: account_segment
      comment: "Customer segment for prioritization and SLA differentiation"
    - name: "service_mode"
      expr: service_mode
      comment: "Transport mode related to the case (air, ocean, road)"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for geographic root cause analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for geographic root cause analysis"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level of the case"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause classification for systemic issue identification"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution outcome code for resolution pattern analysis"
    - name: "origin_channel"
      expr: origin_channel
      comment: "Channel through which the case was raised (phone, email, portal, API)"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of service cases for workload and quality tracking"
    - name: "escalated_cases"
      expr: SUM(CASE WHEN is_escalated = true THEN 1 ELSE 0 END)
      comment: "Count of escalated cases indicating service failures requiring management attention"
    - name: "sla_response_breached_cases"
      expr: SUM(CASE WHEN sla_first_response_breached = true THEN 1 ELSE 0 END)
      comment: "Count of cases where first response SLA was breached"
    - name: "sla_resolution_breached_cases"
      expr: SUM(CASE WHEN sla_resolution_breached = true THEN 1 ELSE 0 END)
      comment: "Count of cases where resolution SLA was breached"
    - name: "claims_initiated_cases"
      expr: SUM(CASE WHEN claims_initiated = true THEN 1 ELSE 0 END)
      comment: "Count of cases that resulted in claims indicating financial impact"
    - name: "reopened_cases"
      expr: SUM(CASE WHEN CAST(reopen_count AS INT) > 0 THEN 1 ELSE 0 END)
      comment: "Count of cases that were reopened indicating incomplete resolution"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_volume_commitment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Volume commitment performance metrics tracking contracted vs actual volumes, attainment rates, and financial incentive/penalty exposure for commercial management."
  source: "`transport_shipping_ecm`.`customer`.`customer_volume_commitment`"
  dimensions:
    - name: "commitment_status"
      expr: commitment_status
      comment: "Current status of the volume commitment (active, expired, terminated)"
    - name: "service_line"
      expr: service_line
      comment: "Logistics service line the commitment applies to"
    - name: "service_mode"
      expr: service_mode
      comment: "Transport mode for the commitment (air, ocean, road, rail)"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for trade lane commitment analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane commitment analysis"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Period type for volume measurement (monthly, quarterly, annual)"
    - name: "volume_unit"
      expr: volume_unit
      comment: "Unit of measure for volume (TEU, kg, shipments)"
    - name: "load_type"
      expr: load_type
      comment: "Load type classification (FCL, LCL, FTL, LTL)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for financial terms of the commitment"
    - name: "auto_renew_flag"
      expr: CASE WHEN auto_renew = true THEN 'Auto-Renew' ELSE 'Manual' END
      comment: "Whether the commitment auto-renews at expiry"
  measures:
    - name: "total_committed_volume"
      expr: SUM(CAST(committed_volume AS DOUBLE))
      comment: "Total contracted volume across all commitments"
    - name: "total_actual_volume"
      expr: SUM(CAST(actual_volume_to_date AS DOUBLE))
      comment: "Total actual volume delivered against commitments"
    - name: "total_target_volume"
      expr: SUM(CAST(target_volume AS DOUBLE))
      comment: "Total target volume for commitment performance tracking"
    - name: "avg_volume_attainment_pct"
      expr: AVG(CAST(volume_attainment_pct AS DOUBLE))
      comment: "Average volume attainment percentage indicating overall commitment performance"
    - name: "total_volume_variance"
      expr: SUM(CAST(volume_variance AS DOUBLE))
      comment: "Total volume variance (positive = over-delivery, negative = shortfall)"
    - name: "total_accrued_incentives"
      expr: SUM(CAST(accrued_incentive_amount AS DOUBLE))
      comment: "Total incentive amounts accrued for over-performance"
    - name: "total_accrued_penalties"
      expr: SUM(CAST(accrued_penalty_amount AS DOUBLE))
      comment: "Total penalty amounts accrued for under-performance"
    - name: "active_commitments"
      expr: SUM(CASE WHEN commitment_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active volume commitments"
    - name: "underperforming_commitments"
      expr: SUM(CASE WHEN performance_alert_triggered = true THEN 1 ELSE 0 END)
      comment: "Count of commitments where performance alert has been triggered requiring intervention"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding efficiency and pipeline metrics tracking time-to-value, completion rates, and bottlenecks in the customer activation process."
  source: "`transport_shipping_ecm`.`customer`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding process"
    - name: "stage"
      expr: stage
      comment: "Current stage in the onboarding workflow"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment being onboarded for resource allocation"
    - name: "account_type"
      expr: account_type
      comment: "Type of account being onboarded"
    - name: "channel"
      expr: channel
      comment: "Sales channel that originated the onboarding"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Target SLA tier for the new customer"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status in the onboarding process"
    - name: "credit_assessment_status"
      expr: credit_assessment_status
      comment: "Credit assessment status during onboarding"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Primary origin country for the customer being onboarded"
  measures:
    - name: "total_onboardings"
      expr: COUNT(1)
      comment: "Total number of customer onboarding processes"
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage indicating onboarding progress"
    - name: "total_credit_limit_onboarding"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit being provisioned for customers in onboarding pipeline"
    - name: "on_hold_onboardings"
      expr: SUM(CASE WHEN onboarding_status = 'on_hold' THEN 1 ELSE 0 END)
      comment: "Count of onboardings currently on hold requiring unblocking"
    - name: "completed_onboardings"
      expr: SUM(CASE WHEN onboarding_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed onboardings"
    - name: "dangerous_goods_certified"
      expr: SUM(CASE WHEN dangerous_goods_certified = true THEN 1 ELSE 0 END)
      comment: "Count of onboardings with dangerous goods certification for hazmat readiness"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales lead generation and conversion metrics tracking pipeline quality, lead velocity, and revenue potential for go-to-market effectiveness."
  source: "`transport_shipping_ecm`.`customer`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead in the qualification funnel"
    - name: "lead_source"
      expr: lead_source
      comment: "Channel or source that generated the lead"
    - name: "lead_type"
      expr: lead_type
      comment: "Type classification of the lead"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the prospect for targeting analysis"
    - name: "country_code"
      expr: country_code
      comment: "Country of the lead for geographic market analysis"
    - name: "service_interest"
      expr: service_interest
      comment: "Logistics service the lead is interested in"
    - name: "transport_mode_interest"
      expr: transport_mode_interest
      comment: "Transport mode the lead is interested in"
    - name: "sales_territory_code"
      expr: sales_territory_code
      comment: "Sales territory for performance attribution"
    - name: "is_converted"
      expr: CASE WHEN is_converted = true THEN 'Converted' ELSE 'Not Converted' END
      comment: "Whether the lead has been converted to an opportunity"
  measures:
    - name: "total_leads"
      expr: COUNT(1)
      comment: "Total number of leads in the pipeline"
    - name: "converted_leads"
      expr: SUM(CASE WHEN is_converted = true THEN 1 ELSE 0 END)
      comment: "Count of leads successfully converted to opportunities"
    - name: "total_estimated_annual_revenue"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue potential from all leads"
    - name: "avg_estimated_annual_revenue"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per lead indicating lead quality"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_ecommerce_seller`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "E-commerce seller portfolio metrics tracking seller health, fulfillment readiness, and service performance for the e-commerce logistics business unit."
  source: "`transport_shipping_ecm`.`customer`.`ecommerce_seller`"
  dimensions:
    - name: "seller_status"
      expr: seller_status
      comment: "Current status of the e-commerce seller (active, suspended, offboarded)"
    - name: "seller_type"
      expr: seller_type
      comment: "Type of seller (marketplace, D2C, hybrid)"
    - name: "marketplace_platform"
      expr: marketplace_platform
      comment: "E-commerce marketplace platform the seller operates on"
    - name: "service_mode"
      expr: service_mode
      comment: "Preferred logistics service mode for the seller"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Primary origin country for the seller's shipments"
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier assigned to the seller"
    - name: "cross_border_enabled_flag"
      expr: CASE WHEN cross_border_enabled = true THEN 'Cross-Border' ELSE 'Domestic Only' END
      comment: "Whether the seller is enabled for cross-border shipping"
    - name: "cod_enabled_flag"
      expr: CASE WHEN cod_enabled = true THEN 'COD Enabled' ELSE 'Prepaid Only' END
      comment: "Whether cash-on-delivery is enabled for the seller"
  measures:
    - name: "total_sellers"
      expr: COUNT(1)
      comment: "Total number of e-commerce sellers in the portfolio"
    - name: "active_sellers"
      expr: SUM(CASE WHEN seller_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active e-commerce sellers"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(otd_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across sellers"
    - name: "avg_return_rate_pct"
      expr: AVG(CAST(return_rate_pct AS DOUBLE))
      comment: "Average return rate percentage indicating fulfillment quality"
    - name: "cross_border_sellers"
      expr: SUM(CASE WHEN cross_border_enabled = true THEN 1 ELSE 0 END)
      comment: "Count of sellers enabled for cross-border operations"
    - name: "hazmat_certified_sellers"
      expr: SUM(CASE WHEN hazmat_certified = true THEN 1 ELSE 0 END)
      comment: "Count of sellers certified for hazardous materials handling"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_sla_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA entitlement portfolio metrics tracking service level commitments, performance targets, and penalty/incentive exposure for contract governance."
  source: "`transport_shipping_ecm`.`customer`.`sla_entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of the SLA entitlement (active, expired, suspended)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level for service differentiation analysis"
    - name: "service_line"
      expr: service_line
      comment: "Logistics service line the SLA covers"
    - name: "service_mode"
      expr: service_mode
      comment: "Transport mode the SLA applies to"
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for trade lane SLA analysis"
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for trade lane SLA analysis"
    - name: "measurement_period"
      expr: measurement_period
      comment: "SLA measurement period (monthly, quarterly, annual)"
    - name: "penalty_applicable_flag"
      expr: CASE WHEN penalty_clause_applicable = true THEN 'Penalty Applicable' ELSE 'No Penalty' END
      comment: "Whether penalty clauses are applicable to this entitlement"
  measures:
    - name: "total_entitlements"
      expr: COUNT(1)
      comment: "Total number of SLA entitlements in the portfolio"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(otd_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across entitlements"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average on-time-in-full target percentage for complete delivery performance"
    - name: "total_penalty_cap_exposure"
      expr: SUM(CAST(penalty_cap_amount AS DOUBLE))
      comment: "Total maximum penalty exposure across all entitlements"
    - name: "entitlements_with_penalties"
      expr: SUM(CASE WHEN penalty_clause_applicable = true THEN 1 ELSE 0 END)
      comment: "Count of entitlements with penalty clauses for risk assessment"
    - name: "entitlements_with_incentives"
      expr: SUM(CASE WHEN incentive_clause_applicable = true THEN 1 ELSE 0 END)
      comment: "Count of entitlements with incentive clauses for upside tracking"
    - name: "avg_incentive_rate_pct"
      expr: AVG(CAST(incentive_rate_pct AS DOUBLE))
      comment: "Average incentive rate percentage for over-performance rewards"
$$;