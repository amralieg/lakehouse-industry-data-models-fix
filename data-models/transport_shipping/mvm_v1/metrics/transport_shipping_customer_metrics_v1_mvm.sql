-- Metric views for domain: customer | Business: Transport Shipping | Version: 1 | Generated on: 2026-05-08 22:31:03

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, credit exposure, and account health across segments and tiers"
  source: "`transport_shipping_ecm`.`customer`.`customer_account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the customer account (active, suspended, closed)"
    - name: "account_tier"
      expr: account_tier
      comment: "Customer tier classification for segmentation and service level"
    - name: "account_type"
      expr: account_type
      comment: "Type of customer account (enterprise, SMB, individual)"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of the customer for market analysis"
    - name: "credit_status"
      expr: credit_status
      comment: "Credit standing of the account (approved, hold, review)"
    - name: "onboarding_year"
      expr: YEAR(onboarding_date)
      comment: "Year the account was onboarded for cohort analysis"
    - name: "onboarding_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month the account was onboarded for cohort tracking"
    - name: "billing_country"
      expr: billing_country_code
      comment: "Country of billing address for geographic analysis"
    - name: "aeo_certified_flag"
      expr: aeo_certified
      comment: "Whether account holds AEO certification for customs facilitation"
    - name: "ctpat_member_flag"
      expr: ctpat_member
      comment: "Whether account is C-TPAT member for supply chain security"
    - name: "edi_capable_flag"
      expr: edi_capable
      comment: "Whether account has EDI integration capability"
    - name: "api_integration_enabled_flag"
      expr: api_integration_enabled
      comment: "Whether account has API integration enabled for automation"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT customer_account_id)
      comment: "Total number of unique customer accounts"
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts in base currency"
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account for portfolio risk assessment"
    - name: "active_accounts"
      expr: COUNT(DISTINCT CASE WHEN account_status = 'Active' THEN customer_account_id END)
      comment: "Number of accounts in active status available for business"
    - name: "aeo_certified_accounts"
      expr: COUNT(DISTINCT CASE WHEN aeo_certified = TRUE THEN customer_account_id END)
      comment: "Number of AEO-certified accounts for customs efficiency tracking"
    - name: "edi_enabled_accounts"
      expr: COUNT(DISTINCT CASE WHEN edi_capable = TRUE THEN customer_account_id END)
      comment: "Number of EDI-capable accounts for automation penetration"
    - name: "api_integrated_accounts"
      expr: COUNT(DISTINCT CASE WHEN api_integration_enabled = TRUE THEN customer_account_id END)
      comment: "Number of API-integrated accounts for digital adoption tracking"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and payment performance metrics for portfolio management and credit policy decisions"
  source: "`transport_shipping_ecm`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current credit status of the profile (approved, hold, review)"
    - name: "risk_category"
      expr: risk_category
      comment: "Risk classification for credit exposure management"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the customer"
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Whether account is currently on credit hold"
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Whether credit is insured for risk mitigation"
    - name: "billing_currency"
      expr: billing_currency
      comment: "Currency of billing for multi-currency portfolio analysis"
    - name: "payment_behavior_code"
      expr: payment_behavior_code
      comment: "Payment behavior classification for collections strategy"
    - name: "last_review_year"
      expr: YEAR(last_review_date)
      comment: "Year of last credit review for review cycle tracking"
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(DISTINCT credit_profile_id)
      comment: "Total number of credit profiles under management"
    - name: "total_approved_credit_limit"
      expr: SUM(CAST(approved_credit_limit AS DOUBLE))
      comment: "Total approved credit limit across portfolio"
    - name: "total_available_credit"
      expr: SUM(CAST(available_credit AS DOUBLE))
      comment: "Total available credit capacity for new business"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding receivables balance across portfolio"
    - name: "total_overdue_amount"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue receivables requiring collection action"
    - name: "total_open_order_exposure"
      expr: SUM(CAST(open_order_exposure AS DOUBLE))
      comment: "Total credit exposure from open orders not yet invoiced"
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_limit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across portfolio for capacity planning"
    - name: "avg_days_sales_outstanding"
      expr: AVG(CAST(days_sales_outstanding AS DOUBLE))
      comment: "Average DSO across portfolio for working capital efficiency"
    - name: "profiles_on_credit_hold"
      expr: COUNT(DISTINCT CASE WHEN credit_hold_flag = TRUE THEN credit_profile_id END)
      comment: "Number of profiles on credit hold requiring resolution"
    - name: "insured_credit_profiles"
      expr: COUNT(DISTINCT CASE WHEN credit_insurance_flag = TRUE THEN credit_profile_id END)
      comment: "Number of insured credit profiles for risk mitigation coverage"
    - name: "total_insured_credit_limit"
      expr: SUM(CAST(insured_credit_limit AS DOUBLE))
      comment: "Total insured credit limit for risk transfer assessment"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_service_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service case metrics for service quality, resolution efficiency, and SLA compliance tracking"
  source: "`transport_shipping_ecm`.`customer`.`service_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the service case (open, in progress, resolved, closed)"
    - name: "case_type"
      expr: case_type
      comment: "Type of service case for issue categorization"
    - name: "priority"
      expr: priority
      comment: "Priority level of the case for resource allocation"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for management visibility"
    - name: "origin_channel"
      expr: origin_channel
      comment: "Channel through which case was initiated (phone, email, portal)"
    - name: "root_cause_category"
      expr: root_cause_category
      comment: "Root cause category for quality improvement initiatives"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution code for outcome tracking"
    - name: "is_escalated_flag"
      expr: is_escalated
      comment: "Whether case has been escalated for attention"
    - name: "sla_first_response_breached_flag"
      expr: sla_first_response_breached
      comment: "Whether first response SLA was breached"
    - name: "sla_resolution_breached_flag"
      expr: sla_resolution_breached
      comment: "Whether resolution SLA was breached"
    - name: "case_created_month"
      expr: DATE_TRUNC('MONTH', case_created_timestamp)
      comment: "Month case was created for trend analysis"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Origin country of shipment related to case"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country of shipment related to case"
    - name: "service_mode"
      expr: service_mode
      comment: "Service mode related to the case (air, ocean, road)"
  measures:
    - name: "total_cases"
      expr: COUNT(DISTINCT service_case_id)
      comment: "Total number of service cases for volume tracking"
    - name: "open_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status IN ('Open', 'In Progress') THEN service_case_id END)
      comment: "Number of cases currently open requiring action"
    - name: "resolved_cases"
      expr: COUNT(DISTINCT CASE WHEN case_status = 'Resolved' THEN service_case_id END)
      comment: "Number of cases resolved for productivity tracking"
    - name: "escalated_cases"
      expr: COUNT(DISTINCT CASE WHEN is_escalated = TRUE THEN service_case_id END)
      comment: "Number of escalated cases requiring management intervention"
    - name: "sla_first_response_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_first_response_breached = TRUE THEN service_case_id END)
      comment: "Number of first response SLA breaches for service quality monitoring"
    - name: "sla_resolution_breaches"
      expr: COUNT(DISTINCT CASE WHEN sla_resolution_breached = TRUE THEN service_case_id END)
      comment: "Number of resolution SLA breaches for performance management"
    - name: "cases_with_claims"
      expr: COUNT(DISTINCT CASE WHEN claims_initiated = TRUE THEN service_case_id END)
      comment: "Number of cases that resulted in claims for cost impact assessment"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_onboarding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer onboarding pipeline and conversion metrics for sales operations and customer acquisition efficiency"
  source: "`transport_shipping_ecm`.`customer`.`onboarding`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of onboarding process (in progress, completed, on hold, rejected)"
    - name: "stage"
      expr: stage
      comment: "Current stage in onboarding workflow for pipeline visibility"
    - name: "channel"
      expr: channel
      comment: "Acquisition channel for marketing attribution"
    - name: "account_type"
      expr: account_type
      comment: "Type of account being onboarded for segment analysis"
    - name: "sla_tier"
      expr: sla_tier
      comment: "Target SLA tier for service level planning"
    - name: "kyc_status"
      expr: kyc_status
      comment: "KYC verification status for compliance tracking"
    - name: "credit_assessment_status"
      expr: credit_assessment_status
      comment: "Credit assessment status for risk approval tracking"
    - name: "edi_setup_status"
      expr: edi_setup_status
      comment: "EDI integration setup status for automation readiness"
    - name: "customs_setup_status"
      expr: customs_setup_status
      comment: "Customs setup status for trade compliance readiness"
    - name: "training_status"
      expr: training_status
      comment: "Customer training status for adoption readiness"
    - name: "initiation_month"
      expr: DATE_TRUNC('MONTH', initiation_date)
      comment: "Month onboarding was initiated for pipeline cohort analysis"
    - name: "target_go_live_month"
      expr: DATE_TRUNC('MONTH', target_go_live_date)
      comment: "Target go-live month for capacity planning"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Primary origin country for geographic expansion tracking"
  measures:
    - name: "total_onboarding_records"
      expr: COUNT(DISTINCT onboarding_id)
      comment: "Total number of onboarding records in pipeline"
    - name: "completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Completed' THEN onboarding_id END)
      comment: "Number of successfully completed onboardings for conversion tracking"
    - name: "in_progress_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'In Progress' THEN onboarding_id END)
      comment: "Number of onboardings currently in progress for pipeline management"
    - name: "rejected_onboardings"
      expr: COUNT(DISTINCT CASE WHEN onboarding_status = 'Rejected' THEN onboarding_id END)
      comment: "Number of rejected onboardings for loss analysis"
    - name: "avg_checklist_completion_pct"
      expr: AVG(CAST(checklist_completion_pct AS DOUBLE))
      comment: "Average checklist completion percentage for process efficiency tracking"
    - name: "total_contracted_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit contracted during onboarding for portfolio growth"
    - name: "kyc_completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN kyc_status = 'Completed' THEN onboarding_id END)
      comment: "Number of onboardings with completed KYC for compliance readiness"
    - name: "edi_enabled_onboardings"
      expr: COUNT(DISTINCT CASE WHEN edi_setup_status = 'Completed' THEN onboarding_id END)
      comment: "Number of onboardings with EDI setup complete for automation adoption"
    - name: "training_completed_onboardings"
      expr: COUNT(DISTINCT CASE WHEN training_status = 'Completed' THEN onboarding_id END)
      comment: "Number of onboardings with training complete for customer readiness"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_sla_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SLA entitlement and service commitment metrics for contract compliance and service level management"
  source: "`transport_shipping_ecm`.`customer`.`sla_entitlement`"
  dimensions:
    - name: "entitlement_status"
      expr: entitlement_status
      comment: "Current status of SLA entitlement (active, expired, suspended)"
    - name: "sla_tier"
      expr: sla_tier
      comment: "SLA tier level for service differentiation"
    - name: "service_line"
      expr: service_line
      comment: "Service line covered by entitlement"
    - name: "service_mode"
      expr: service_mode
      comment: "Transport mode covered by SLA (air, ocean, road)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Origin country for geographic SLA analysis"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country for lane-specific SLA tracking"
    - name: "penalty_clause_applicable_flag"
      expr: penalty_clause_applicable
      comment: "Whether penalty clause applies for financial risk tracking"
    - name: "incentive_clause_applicable_flag"
      expr: incentive_clause_applicable
      comment: "Whether incentive clause applies for performance bonus tracking"
    - name: "auto_renewal_flag"
      expr: auto_renewal
      comment: "Whether entitlement auto-renews for retention tracking"
    - name: "effective_year"
      expr: YEAR(effective_from_date)
      comment: "Year entitlement became effective for cohort analysis"
  measures:
    - name: "total_entitlements"
      expr: COUNT(DISTINCT sla_entitlement_id)
      comment: "Total number of SLA entitlements under management"
    - name: "active_entitlements"
      expr: COUNT(DISTINCT CASE WHEN entitlement_status = 'Active' THEN sla_entitlement_id END)
      comment: "Number of active SLA entitlements for service capacity planning"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(otd_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage across entitlements"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average on-time in-full target percentage for service quality benchmarking"
    - name: "entitlements_with_penalties"
      expr: COUNT(DISTINCT CASE WHEN penalty_clause_applicable = TRUE THEN sla_entitlement_id END)
      comment: "Number of entitlements with penalty clauses for financial risk exposure"
    - name: "entitlements_with_incentives"
      expr: COUNT(DISTINCT CASE WHEN incentive_clause_applicable = TRUE THEN sla_entitlement_id END)
      comment: "Number of entitlements with incentive clauses for performance bonus tracking"
    - name: "avg_penalty_rate_pct"
      expr: AVG(CAST(penalty_rate_pct AS DOUBLE))
      comment: "Average penalty rate percentage for financial impact modeling"
    - name: "avg_incentive_rate_pct"
      expr: AVG(CAST(incentive_rate_pct AS DOUBLE))
      comment: "Average incentive rate percentage for bonus cost estimation"
    - name: "total_penalty_cap_amount"
      expr: SUM(CAST(penalty_cap_amount AS DOUBLE))
      comment: "Total penalty cap amount across portfolio for maximum risk exposure"
    - name: "total_min_volume_weight_kg"
      expr: SUM(CAST(min_volume_weight_kg AS DOUBLE))
      comment: "Total minimum volume weight commitment for capacity planning"
    - name: "total_min_volume_teu"
      expr: SUM(CAST(min_volume_teu AS DOUBLE))
      comment: "Total minimum TEU commitment for container capacity planning"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment definition and commercial tier metrics for strategic segmentation and pricing strategy"
  source: "`transport_shipping_ecm`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of customer segment (active, inactive, under review)"
    - name: "segment_type"
      expr: segment_type
      comment: "Type of customer segment for classification"
    - name: "commercial_tier"
      expr: commercial_tier
      comment: "Commercial tier for pricing and service differentiation"
    - name: "sla_tier_code"
      expr: sla_tier_code
      comment: "SLA tier code for service level mapping"
    - name: "pricing_model_code"
      expr: pricing_model_code
      comment: "Pricing model applied to segment"
    - name: "account_management_model"
      expr: account_management_model
      comment: "Account management model for resource allocation"
    - name: "preferred_transport_mode"
      expr: preferred_transport_mode
      comment: "Preferred transport mode for segment"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of segment (global, regional, domestic)"
    - name: "edi_integration_required_flag"
      expr: edi_integration_required
      comment: "Whether EDI integration is required for segment"
    - name: "api_access_eligible_flag"
      expr: api_access_eligible
      comment: "Whether segment is eligible for API access"
    - name: "dangerous_goods_eligible_flag"
      expr: dangerous_goods_eligible
      comment: "Whether segment is eligible for dangerous goods handling"
    - name: "ecommerce_fulfillment_eligible_flag"
      expr: ecommerce_fulfillment_eligible
      comment: "Whether segment is eligible for e-commerce fulfillment services"
  measures:
    - name: "total_segments"
      expr: COUNT(DISTINCT segment_id)
      comment: "Total number of customer segments defined"
    - name: "active_segments"
      expr: COUNT(DISTINCT CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Number of active customer segments for portfolio management"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit in USD across all segments for portfolio capacity"
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Average credit limit per segment for tier benchmarking"
    - name: "total_revenue_band_min_usd"
      expr: SUM(CAST(revenue_band_min_usd AS DOUBLE))
      comment: "Total minimum revenue band threshold for segment qualification"
    - name: "total_revenue_band_max_usd"
      expr: SUM(CAST(revenue_band_max_usd AS DOUBLE))
      comment: "Total maximum revenue band threshold for segment ceiling"
    - name: "avg_otd_target_pct"
      expr: AVG(CAST(otd_target_pct AS DOUBLE))
      comment: "Average on-time delivery target percentage by segment for service design"
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average on-time in-full target percentage by segment for quality standards"
    - name: "edi_required_segments"
      expr: COUNT(DISTINCT CASE WHEN edi_integration_required = TRUE THEN segment_id END)
      comment: "Number of segments requiring EDI integration for automation investment"
    - name: "api_eligible_segments"
      expr: COUNT(DISTINCT CASE WHEN api_access_eligible = TRUE THEN segment_id END)
      comment: "Number of segments eligible for API access for digital strategy"
    - name: "hazmat_eligible_segments"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_eligible = TRUE THEN segment_id END)
      comment: "Number of segments eligible for dangerous goods for capability planning"
    - name: "ecommerce_eligible_segments"
      expr: COUNT(DISTINCT CASE WHEN ecommerce_fulfillment_eligible = TRUE THEN segment_id END)
      comment: "Number of segments eligible for e-commerce fulfillment for market opportunity"
$$;

CREATE OR REPLACE VIEW `transport_shipping_ecm`.`_metrics`.`customer_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account hierarchy and consolidation metrics for enterprise account management and revenue roll-up analysis"
  source: "`transport_shipping_ecm`.`customer`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Current status of account hierarchy (active, inactive, pending)"
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy relationship (parent-child, affiliate, subsidiary)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in hierarchy for organizational depth analysis"
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of relationship between accounts"
    - name: "country_of_domicile"
      expr: country_of_domicile
      comment: "Country of domicile for geographic hierarchy analysis"
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical of hierarchy for sector analysis"
    - name: "consolidation_flag"
      expr: consolidation_flag
      comment: "Whether hierarchy uses financial consolidation"
    - name: "credit_consolidation_flag"
      expr: credit_consolidation_flag
      comment: "Whether credit is consolidated across hierarchy"
    - name: "revenue_roll_up_flag"
      expr: revenue_roll_up_flag
      comment: "Whether revenue rolls up to parent account"
    - name: "pricing_inheritance_flag"
      expr: pricing_inheritance_flag
      comment: "Whether pricing inherits from parent"
    - name: "sla_inheritance_flag"
      expr: sla_inheritance_flag
      comment: "Whether SLA inherits from parent"
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year hierarchy was approved for cohort tracking"
  measures:
    - name: "total_hierarchies"
      expr: COUNT(DISTINCT account_hierarchy_id)
      comment: "Total number of account hierarchies under management"
    - name: "active_hierarchies"
      expr: COUNT(DISTINCT CASE WHEN hierarchy_status = 'Active' THEN account_hierarchy_id END)
      comment: "Number of active account hierarchies for enterprise account tracking"
    - name: "total_annual_contracted_revenue"
      expr: SUM(CAST(annual_contracted_revenue AS DOUBLE))
      comment: "Total annual contracted revenue across all hierarchies for portfolio value"
    - name: "avg_annual_contracted_revenue"
      expr: AVG(CAST(annual_contracted_revenue AS DOUBLE))
      comment: "Average annual contracted revenue per hierarchy for deal size benchmarking"
    - name: "total_consolidated_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total consolidated credit limit across hierarchies for risk exposure"
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage in hierarchies for control analysis"
    - name: "avg_voting_rights_percentage"
      expr: AVG(CAST(voting_rights_percentage AS DOUBLE))
      comment: "Average voting rights percentage for governance analysis"
    - name: "consolidated_hierarchies"
      expr: COUNT(DISTINCT CASE WHEN consolidation_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchies with financial consolidation for reporting complexity"
    - name: "credit_consolidated_hierarchies"
      expr: COUNT(DISTINCT CASE WHEN credit_consolidation_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchies with consolidated credit for risk management"
    - name: "revenue_rollup_hierarchies"
      expr: COUNT(DISTINCT CASE WHEN revenue_roll_up_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchies with revenue roll-up for performance aggregation"
    - name: "pricing_inheritance_hierarchies"
      expr: COUNT(DISTINCT CASE WHEN pricing_inheritance_flag = TRUE THEN account_hierarchy_id END)
      comment: "Number of hierarchies with pricing inheritance for contract simplification"
$$;