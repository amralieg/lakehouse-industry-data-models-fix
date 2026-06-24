-- Metric views for domain: customer | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer account portfolio health metrics — tracks account risk, credit quality, and strategic segmentation for executive portfolio steering and sales leadership decisions."
  source: "`vibe_semiconductors_v1`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Lifecycle status of the account (Active, Inactive, Churned, Prospect) for portfolio segmentation."
    - name: "account_type"
      expr: account_type
      comment: "Classification of account type (Direct, Distributor, OEM, ODM) for channel analysis."
    - name: "revenue_tier"
      expr: revenue_tier
      comment: "Revenue tier band (Tier 1, Tier 2, Tier 3) used to prioritize strategic accounts."
    - name: "strategic_classification"
      expr: strategic_classification
      comment: "Strategic importance classification (Strategic, Key, Standard) for executive account reviews."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the account for regional performance analysis."
    - name: "industry_vertical"
      expr: industry_vertical
      comment: "Industry vertical (Automotive, Consumer, Industrial, Data Center) for vertical market analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the account for risk-weighted portfolio analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the account for regulatory and export control reporting."
    - name: "sales_region"
      expr: sales_region
      comment: "Sales region assignment for territory-level performance tracking."
    - name: "creation_year_month"
      expr: DATE_TRUNC('month', creation_date)
      comment: "Month of account creation for cohort and new-logo trend analysis."
    - name: "last_order_year_month"
      expr: DATE_TRUNC('month', last_order_date)
      comment: "Month of last order for recency-based churn risk segmentation."
    - name: "tax_exempt_flag"
      expr: tax_exempt_flag
      comment: "Whether the account is tax-exempt, relevant for revenue recognition and compliance reporting."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Total number of active customer accounts. Core portfolio size KPI used in QBRs and board decks to track customer base growth."
    - name: "avg_account_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across the account portfolio. Executives use this to monitor portfolio-level credit and compliance risk exposure."
    - name: "high_risk_account_count"
      expr: COUNT(CASE WHEN risk_score > 70 THEN account_id END)
      comment: "Number of accounts with risk score above 70. Triggers credit review and collections escalation when elevated."
    - name: "strategic_account_count"
      expr: COUNT(CASE WHEN strategic_classification = 'Strategic' THEN account_id END)
      comment: "Count of accounts classified as Strategic. Used to track coverage of highest-value customer relationships."
    - name: "tax_exempt_account_count"
      expr: COUNT(CASE WHEN tax_exempt_flag = TRUE THEN account_id END)
      comment: "Number of tax-exempt accounts. Required for revenue recognition and tax compliance reporting."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer credit risk and utilization metrics — tracks credit exposure, utilization rates, and overdue balances to steer credit policy and collections strategy."
  source: "`vibe_semiconductors_v1`.`customer`.`credit_profile`"
  dimensions:
    - name: "credit_profile_status"
      expr: credit_profile_status
      comment: "Current status of the credit profile (Active, Suspended, Under Review) for portfolio segmentation."
    - name: "credit_profile_type"
      expr: credit_profile_type
      comment: "Type of credit profile (Standard, Preferred, Restricted) for tiered credit management."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating for risk-banded analysis of credit exposure."
    - name: "credit_rating_external"
      expr: credit_rating_external
      comment: "External agency credit rating for cross-referencing internal vs. external risk assessments."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category (Low, Medium, High, Critical) for credit risk tiering and escalation triggers."
    - name: "credit_hold"
      expr: credit_hold
      comment: "Whether the account is currently on credit hold — directly impacts order fulfillment decisions."
    - name: "is_preferred_customer"
      expr: is_preferred_customer
      comment: "Whether the customer has preferred status, affecting credit terms and priority treatment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile for multi-currency exposure analysis."
    - name: "credit_review_year_month"
      expr: DATE_TRUNC('month', credit_review_date)
      comment: "Month of last credit review for tracking review cadence compliance."
  measures:
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit_usd AS DOUBLE))
      comment: "Total credit limit extended across all customer accounts in USD. Core credit exposure KPI for CFO and credit committee oversight."
    - name: "total_credit_used_usd"
      expr: SUM(CAST(credit_used_usd AS DOUBLE))
      comment: "Total credit currently utilized across all accounts in USD. Measures actual credit exposure vs. limit."
    - name: "total_outstanding_balance_usd"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total outstanding balance across all credit profiles. Key AR aging and collections KPI."
    - name: "total_overdue_amount_usd"
      expr: SUM(CAST(overdue_amount AS DOUBLE))
      comment: "Total overdue balance across all accounts. Triggers collections escalation and bad-debt provisioning decisions."
    - name: "avg_credit_utilization_pct"
      expr: AVG(CAST(credit_utilization_pct AS DOUBLE))
      comment: "Average credit utilization percentage across accounts. Executives use this to assess portfolio-level credit saturation and risk."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold = TRUE THEN credit_profile_id END)
      comment: "Number of accounts currently on credit hold. Directly impacts order fulfillment capacity and revenue at risk."
    - name: "avg_credit_limit_usd"
      expr: AVG(CAST(credit_limit_usd AS DOUBLE))
      comment: "Average credit limit per account. Used to benchmark credit policy generosity and compare across customer tiers."
    - name: "high_utilization_account_count"
      expr: COUNT(CASE WHEN credit_utilization_pct > 80 THEN credit_profile_id END)
      comment: "Accounts with credit utilization above 80%. Leading indicator of credit stress requiring proactive review."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design win pipeline and revenue potential metrics — tracks design win volume, estimated revenue, NRE commitments, and win stage progression for strategic product and sales decisions."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_win`"
  dimensions:
    - name: "win_status"
      expr: win_status
      comment: "Current status of the design win (Active, Lost, Cancelled, Production) for pipeline stage analysis."
    - name: "stage"
      expr: stage
      comment: "Pipeline stage of the design win (Evaluation, Design-In, Design-Win, Production) for funnel analysis."
    - name: "target_application"
      expr: target_application
      comment: "Target end application (Automotive, IoT, Server, Mobile) for market segment revenue analysis."
    - name: "process_node"
      expr: process_node
      comment: "Process technology node of the design win for technology roadmap alignment analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type for the design win, relevant for packaging capacity planning."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation of the IC for product lifecycle and roadmap analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue estimate for multi-currency pipeline reporting."
    - name: "nre_required_flag"
      expr: nre_required_flag
      comment: "Whether NRE is required for this design win, affecting deal economics and margin."
    - name: "competitive_displacement_flag"
      expr: competitive_displacement_flag
      comment: "Whether this win displaced a competitor — key strategic metric for market share gain tracking."
    - name: "win_year_month"
      expr: DATE_TRUNC('month', win_date)
      comment: "Month of design win confirmation for trend and seasonality analysis."
    - name: "production_ramp_year_month"
      expr: DATE_TRUNC('month', production_ramp_date)
      comment: "Month of expected production ramp for revenue timing and capacity planning."
  measures:
    - name: "total_design_wins"
      expr: COUNT(customer_design_win_id)
      comment: "Total number of design wins. Core pipeline volume KPI tracked in every sales QBR and board deck."
    - name: "total_estimated_annual_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue from all design wins in USD. Primary pipeline value KPI for revenue forecasting and investor reporting."
    - name: "avg_estimated_annual_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per design win. Used to assess deal quality and compare across segments and applications."
    - name: "total_nre_amount_usd"
      expr: SUM(CAST(nre_amount_usd AS DOUBLE))
      comment: "Total NRE committed across all design wins. Tracks engineering investment required to convert pipeline to production revenue."
    - name: "total_estimated_annual_unit_volume"
      expr: SUM(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Total estimated annual unit volume across all design wins. Drives capacity planning and wafer start forecasting."
    - name: "competitive_displacement_wins"
      expr: COUNT(CASE WHEN competitive_displacement_flag = TRUE THEN customer_design_win_id END)
      comment: "Number of design wins that displaced a competitor. Key market share gain metric for strategic planning."
    - name: "active_design_win_count"
      expr: COUNT(CASE WHEN win_status = 'Active' THEN customer_design_win_id END)
      comment: "Number of currently active design wins in the pipeline. Measures live pipeline health for sales leadership."
    - name: "avg_estimated_annual_unit_volume"
      expr: AVG(CAST(estimated_annual_unit_volume AS DOUBLE))
      comment: "Average annual unit volume per design win. Used to identify high-volume vs. niche design wins for capacity prioritization."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Design registration pipeline metrics — tracks registration volume, NRE budget commitments, qualification progress, and tapeout timelines to manage design funnel conversion."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_design_registration`"
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the design registration (Pending, Approved, Expired, Converted) for funnel stage analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the registered design for readiness-to-production tracking."
    - name: "target_application"
      expr: target_application
      comment: "Target end application for market segment analysis of the design pipeline."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology node demand analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type for packaging capacity planning alignment."
    - name: "platform_generation"
      expr: platform_generation
      comment: "Platform generation for product roadmap alignment analysis."
    - name: "design_complexity"
      expr: design_complexity
      comment: "Complexity classification of the design for resource and NRE estimation."
    - name: "nre_budget_currency"
      expr: nre_budget_currency
      comment: "Currency of the NRE budget for multi-currency financial reporting."
    - name: "registration_year_month"
      expr: DATE_TRUNC('month', registration_date)
      comment: "Month of registration for pipeline intake trend analysis."
    - name: "tapeout_target_year_month"
      expr: DATE_TRUNC('month', tapeout_target_date)
      comment: "Month of tapeout target for capacity and mask shop planning."
  measures:
    - name: "total_design_registrations"
      expr: COUNT(customer_design_registration_id)
      comment: "Total number of design registrations. Measures top-of-funnel design activity and customer engagement with the product portfolio."
    - name: "total_nre_budget_amount"
      expr: SUM(CAST(nre_budget_amount AS DOUBLE))
      comment: "Total NRE budget committed across all design registrations. Tracks engineering investment pipeline for financial planning."
    - name: "avg_nre_budget_amount"
      expr: AVG(CAST(nre_budget_amount AS DOUBLE))
      comment: "Average NRE budget per design registration. Used to benchmark deal size and complexity across customer segments."
    - name: "avg_expected_yield_percent"
      expr: AVG(CAST(expected_yield_percent AS DOUBLE))
      comment: "Average expected yield percentage across registered designs. Informs fab capacity planning and revenue yield assumptions."
    - name: "approved_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Approved' THEN customer_design_registration_id END)
      comment: "Number of approved design registrations. Measures conversion from registration to active design engagement."
    - name: "expired_registration_count"
      expr: COUNT(CASE WHEN registration_status = 'Expired' THEN customer_design_registration_id END)
      comment: "Number of expired design registrations. Indicates lost pipeline opportunities requiring follow-up or process improvement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer pricing agreement metrics — tracks pricing levels, discount depth, volume commitments, and agreement coverage to steer pricing strategy and margin management."
  source: "`vibe_semiconductors_v1`.`customer`.`price_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the price agreement (Active, Expired, Pending Approval) for coverage analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of price agreement (Volume, NRE, Spot, Contract) for pricing channel analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the agreement for governance and compliance tracking."
    - name: "pricing_channel"
      expr: pricing_channel
      comment: "Channel through which pricing is applied (Direct, Distributor, OEM) for channel margin analysis."
    - name: "pricing_region"
      expr: pricing_region
      comment: "Geographic region of the price agreement for regional pricing strategy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the price agreement for multi-currency pricing analysis."
    - name: "volume_tier"
      expr: volume_tier
      comment: "Volume tier of the agreement for tiered pricing structure analysis."
    - name: "is_price_locked"
      expr: is_price_locked
      comment: "Whether the price is locked, indicating committed pricing that cannot be changed without renegotiation."
    - name: "price_source"
      expr: price_source
      comment: "Source of the price (List, Negotiated, Spot) for pricing governance analysis."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the price agreement became effective for pricing trend analysis."
    - name: "expiration_year_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the price agreement expires for renewal pipeline management."
  measures:
    - name: "total_price_agreements"
      expr: COUNT(price_agreement_id)
      comment: "Total number of price agreements in force. Measures pricing coverage across the customer portfolio."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price in USD across all price agreements. Core ASP (Average Selling Price) KPI for margin and pricing strategy decisions."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage granted across price agreements. Executives use this to monitor pricing discipline and margin leakage."
    - name: "avg_tier_price"
      expr: AVG(CAST(tier_price AS DOUBLE))
      comment: "Average tier price across volume-tiered agreements. Used to assess volume pricing competitiveness."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity committed across all price agreements. Measures volume commitment pipeline for demand planning."
    - name: "price_locked_agreement_count"
      expr: COUNT(CASE WHEN is_price_locked = TRUE THEN price_agreement_id END)
      comment: "Number of price-locked agreements. Measures committed pricing exposure that limits pricing flexibility."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer engagement activity metrics — tracks interaction volume, budget, escalation rates, and billable activity to measure customer relationship health and sales effectiveness."
  source: "`vibe_semiconductors_v1`.`customer`.`engagement_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of engagement activity (Meeting, Demo, Support, Training) for activity mix analysis."
    - name: "activity_category"
      expr: activity_category
      comment: "Category of the activity (Pre-Sales, Post-Sales, Technical, Executive) for engagement depth analysis."
    - name: "channel"
      expr: channel
      comment: "Channel through which the activity occurred (In-Person, Virtual, Phone, Email) for channel effectiveness analysis."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the engagement activity (Positive, Neutral, Negative, Follow-Up Required) for effectiveness measurement."
    - name: "region"
      expr: region
      comment: "Geographic region of the engagement for regional coverage analysis."
    - name: "is_billable"
      expr: is_billable
      comment: "Whether the activity is billable to the customer, relevant for NRE and professional services revenue tracking."
    - name: "is_escalated"
      expr: is_escalated
      comment: "Whether the activity was escalated, indicating customer satisfaction risk requiring management attention."
    - name: "risk_flag"
      expr: risk_flag
      comment: "Whether the activity carries a risk flag for proactive account risk management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the activity budget for multi-currency engagement cost analysis."
    - name: "activity_year_month"
      expr: DATE_TRUNC('month', activity_date)
      comment: "Month of the activity for engagement trend and cadence analysis."
  measures:
    - name: "total_engagement_activities"
      expr: COUNT(engagement_activity_id)
      comment: "Total number of customer engagement activities. Measures overall customer interaction volume and sales team coverage."
    - name: "total_engagement_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to engagement activities. Tracks customer engagement investment for ROI analysis."
    - name: "avg_engagement_budget"
      expr: AVG(CAST(budget_amount AS DOUBLE))
      comment: "Average budget per engagement activity. Used to benchmark investment per interaction and optimize engagement spend."
    - name: "escalated_activity_count"
      expr: COUNT(CASE WHEN is_escalated = TRUE THEN engagement_activity_id END)
      comment: "Number of escalated engagement activities. Leading indicator of customer satisfaction issues requiring executive intervention."
    - name: "billable_activity_count"
      expr: COUNT(CASE WHEN is_billable = TRUE THEN engagement_activity_id END)
      comment: "Number of billable engagement activities. Tracks professional services and NRE activity that generates direct revenue."
    - name: "risk_flagged_activity_count"
      expr: COUNT(CASE WHEN risk_flag = TRUE THEN engagement_activity_id END)
      comment: "Number of activities flagged as risk. Aggregated risk signal for account health monitoring and proactive intervention."
    - name: "unique_accounts_engaged"
      expr: COUNT(DISTINCT engagement_account_id)
      comment: "Number of distinct accounts with engagement activity. Measures breadth of active customer coverage by the sales and FAE teams."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_qualification_status`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer product qualification metrics — tracks qualification completion rates, scores, and compliance status to manage customer readiness for production and regulatory requirements."
  source: "`vibe_semiconductors_v1`.`customer`.`qualification_status`"
  dimensions:
    - name: "overall_qualification_status"
      expr: overall_qualification_status
      comment: "Overall qualification status (Qualified, In Progress, Failed, Expired) for portfolio qualification health."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (AEC-Q, IATF, PPAP, Customer-Specific) for compliance program tracking."
    - name: "qualification_level"
      expr: qualification_level
      comment: "Level of qualification achieved for tiered qualification program management."
    - name: "aec_q_status"
      expr: aec_q_status
      comment: "AEC-Q automotive qualification status — critical for automotive customer compliance."
    - name: "iatf_16949_status"
      expr: iatf_16949_status
      comment: "IATF 16949 quality management system status for automotive supply chain compliance."
    - name: "ppap_status"
      expr: ppap_status
      comment: "PPAP (Production Part Approval Process) status for automotive and industrial customer qualification."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the qualification for expiry and renewal management."
    - name: "qualification_start_year_month"
      expr: DATE_TRUNC('month', qualification_start_date)
      comment: "Month qualification started for cycle time and throughput analysis."
    - name: "qualification_completion_year_month"
      expr: DATE_TRUNC('month', qualification_completion_date)
      comment: "Month qualification completed for on-time delivery tracking."
  measures:
    - name: "total_qualification_records"
      expr: COUNT(qualification_status_id)
      comment: "Total number of customer qualification records. Measures qualification program scope and coverage."
    - name: "qualified_count"
      expr: COUNT(CASE WHEN overall_qualification_status = 'Qualified' THEN qualification_status_id END)
      comment: "Number of fully qualified customer-product combinations. Directly measures production readiness and revenue enablement."
    - name: "qualification_in_progress_count"
      expr: COUNT(CASE WHEN overall_qualification_status = 'In Progress' THEN qualification_status_id END)
      comment: "Number of qualifications currently in progress. Measures active qualification pipeline and resource demand."
    - name: "avg_qualification_score"
      expr: AVG(CAST(qualification_score AS DOUBLE))
      comment: "Average qualification score across all records. Used to benchmark qualification quality and identify systemic issues."
    - name: "expired_qualification_count"
      expr: COUNT(CASE WHEN expiry_date < CURRENT_DATE THEN qualification_status_id END)
      comment: "Number of expired qualifications. Indicates compliance risk — expired qualifications may block shipments to regulated customers."
    - name: "aec_q_qualified_count"
      expr: COUNT(CASE WHEN aec_q_status = 'Qualified' THEN qualification_status_id END)
      comment: "Number of AEC-Q qualified customer-product combinations. Critical KPI for automotive market access and revenue enablement."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_distributor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor agreement portfolio metrics — tracks agreement coverage, discount levels, MDF entitlements, and exclusivity to manage channel economics and partner performance."
  source: "`vibe_semiconductors_v1`.`customer`.`distributor_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the distributor agreement (Active, Expired, Terminated) for channel coverage analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of distributor agreement (Authorized, Exclusive, Value-Added) for channel structure analysis."
    - name: "tier"
      expr: tier
      comment: "Distributor tier (Gold, Silver, Bronze) for tiered partner program management."
    - name: "territory"
      expr: territory
      comment: "Territory covered by the distributor agreement for geographic channel coverage analysis."
    - name: "territory_country_code"
      expr: territory_country_code
      comment: "Country code of the distributor territory for country-level channel analysis."
    - name: "exclusive_distribution"
      expr: exclusive_distribution
      comment: "Whether the distribution rights are exclusive — affects channel conflict management and pricing strategy."
    - name: "stock_rotation_rights"
      expr: stock_rotation_rights
      comment: "Whether the distributor has stock rotation rights — impacts inventory liability and channel inventory management."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the agreement for multi-currency channel economics analysis."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the agreement became effective for channel coverage trend analysis."
    - name: "expiration_year_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the agreement expires for renewal pipeline management."
  measures:
    - name: "total_distributor_agreements"
      expr: COUNT(distributor_agreement_id)
      comment: "Total number of distributor agreements. Measures channel partner coverage breadth."
    - name: "active_distributor_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN distributor_agreement_id END)
      comment: "Number of currently active distributor agreements. Core channel health KPI for sales leadership."
    - name: "avg_commission_rate"
      expr: AVG(CAST(commission_rate AS DOUBLE))
      comment: "Average commission rate across distributor agreements. Used to benchmark channel cost and optimize partner economics."
    - name: "avg_discount_rate_percent"
      expr: AVG(CAST(discount_rate_percent AS DOUBLE))
      comment: "Average discount rate granted to distributors. Monitors channel margin leakage and pricing discipline."
    - name: "total_mdf_entitlement_amount"
      expr: SUM(CAST(mdf_entitlement_amount AS DOUBLE))
      comment: "Total Market Development Fund (MDF) entitlement across all distributor agreements. Tracks channel marketing investment commitments."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusive_distribution = TRUE THEN distributor_agreement_id END)
      comment: "Number of exclusive distributor agreements. Measures channel exclusivity exposure and competitive lock-in."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_tool_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer fab tool allocation metrics — tracks allocated capacity, utilization rates, and reserved wafer starts to manage customer-committed fab capacity and tool utilization efficiency."
  source: "`vibe_semiconductors_v1`.`customer`.`tool_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Current status of the tool allocation (Active, Pending, Expired, Cancelled) for capacity commitment tracking."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Type of allocation (Dedicated, Shared, Reserved) for capacity structure analysis."
    - name: "allocation_priority"
      expr: allocation_priority
      comment: "Priority of the allocation for capacity conflict resolution and scheduling."
    - name: "priority_class"
      expr: priority_class
      comment: "Priority class of the allocation for tiered capacity management."
    - name: "technology_node_nm"
      expr: technology_node_nm
      comment: "Technology node in nanometers for node-level capacity demand analysis."
    - name: "is_dedicated"
      expr: is_dedicated
      comment: "Whether the tool allocation is dedicated to a single customer — impacts capacity flexibility and pricing."
    - name: "is_guaranteed_flag"
      expr: is_guaranteed_flag
      comment: "Whether the capacity is guaranteed — measures committed capacity obligations to customers."
    - name: "allocation_start_year_month"
      expr: DATE_TRUNC('month', allocation_start_date)
      comment: "Month the allocation starts for capacity planning timeline analysis."
    - name: "allocation_end_year_month"
      expr: DATE_TRUNC('month', allocation_end_date)
      comment: "Month the allocation ends for capacity release planning."
  measures:
    - name: "total_tool_allocations"
      expr: COUNT(tool_allocation_id)
      comment: "Total number of customer tool allocations. Measures scope of customer capacity commitments across the fab."
    - name: "avg_allocated_capacity_percent"
      expr: AVG(CAST(allocated_capacity_percent AS DOUBLE))
      comment: "Average allocated capacity percentage across all tool allocations. Core fab capacity utilization KPI for operations and sales planning."
    - name: "avg_actual_utilization_percent"
      expr: AVG(CAST(actual_utilization_percent AS DOUBLE))
      comment: "Average actual utilization percentage. Compared against allocated capacity to identify under-utilization and capacity recovery opportunities."
    - name: "avg_allocation_percentage"
      expr: AVG(CAST(allocation_percentage AS DOUBLE))
      comment: "Average allocation percentage per customer tool commitment. Used to assess concentration risk in capacity commitments."
    - name: "total_reserved_capacity_hours"
      expr: SUM(CAST(reserved_capacity_hours AS DOUBLE))
      comment: "Total reserved capacity hours across all customer tool allocations. Measures total committed fab capacity in hours for operations planning."
    - name: "avg_reserved_capacity_wph"
      expr: AVG(CAST(reserved_capacity_wph AS DOUBLE))
      comment: "Average reserved capacity in wafers per hour. Key throughput commitment metric for fab capacity management."
    - name: "dedicated_allocation_count"
      expr: COUNT(CASE WHEN is_dedicated = TRUE THEN tool_allocation_id END)
      comment: "Number of dedicated tool allocations. Measures capacity locked to single customers — impacts fab flexibility and pricing power."
    - name: "guaranteed_allocation_count"
      expr: COUNT(CASE WHEN is_guaranteed_flag = TRUE THEN tool_allocation_id END)
      comment: "Number of guaranteed capacity allocations. Measures contractual capacity obligations that cannot be reallocated without penalty."
    - name: "utilization_gap_avg"
      expr: AVG(CAST(utilization_target_percent AS DOUBLE) - CAST(actual_utilization_percent AS DOUBLE))
      comment: "Average gap between target and actual utilization percentage. Identifies systematic under-utilization of committed capacity requiring corrective action."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer segment strategic metrics — tracks revenue targets, market share goals, and discount rates by segment to steer go-to-market strategy and resource allocation."
  source: "`vibe_semiconductors_v1`.`customer`.`segment`"
  dimensions:
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (Active, Inactive, Under Review) for portfolio management."
    - name: "vertical_market"
      expr: vertical_market
      comment: "Vertical market of the segment (Automotive, Industrial, Consumer, Data Center) for market strategy analysis."
    - name: "sub_vertical"
      expr: sub_vertical
      comment: "Sub-vertical within the market for granular segment strategy analysis."
    - name: "region"
      expr: region
      comment: "Geographic region of the segment for regional go-to-market planning."
    - name: "strategic_priority_tier"
      expr: strategic_priority_tier
      comment: "Strategic priority tier of the segment for resource allocation decisions."
    - name: "sales_motion"
      expr: sales_motion
      comment: "Sales motion applied to the segment (Direct, Channel, Hybrid) for sales strategy analysis."
    - name: "pricing_strategy"
      expr: pricing_strategy
      comment: "Pricing strategy for the segment (Value, Competitive, Cost-Plus) for margin management."
    - name: "tam_band"
      expr: tam_band
      comment: "Total Addressable Market band for the segment for market sizing and investment prioritization."
    - name: "target_customer_type"
      expr: target_customer_type
      comment: "Target customer type within the segment for sales targeting and coverage planning."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month the segment definition became effective for strategy evolution tracking."
  measures:
    - name: "total_segments"
      expr: COUNT(segment_id)
      comment: "Total number of defined customer segments. Measures go-to-market segmentation coverage."
    - name: "total_revenue_target_usd"
      expr: SUM(CAST(revenue_target_usd AS DOUBLE))
      comment: "Total revenue target across all segments in USD. Core top-down revenue planning KPI for executive and board reporting."
    - name: "avg_revenue_target_usd"
      expr: AVG(CAST(revenue_target_usd AS DOUBLE))
      comment: "Average revenue target per segment. Used to assess balance of revenue ambition across the segment portfolio."
    - name: "avg_market_share_target_percent"
      expr: AVG(CAST(market_share_target_percent AS DOUBLE))
      comment: "Average market share target percentage across segments. Tracks strategic ambition for market penetration."
    - name: "avg_discount_rate"
      expr: AVG(CAST(discount_rate AS DOUBLE))
      comment: "Average discount rate across segments. Monitors pricing discipline and margin management by segment strategy."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'Active' THEN segment_id END)
      comment: "Number of active customer segments. Measures active go-to-market coverage and segmentation health."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer sample request fulfillment metrics — tracks sample request volume, cost, fulfillment rates, and cycle times to manage pre-sales sample programs and design-in support."
  source: "`vibe_semiconductors_v1`.`customer`.`customer_sample_request`"
  dimensions:
    - name: "customer_sample_request_status"
      expr: customer_sample_request_status
      comment: "Current status of the sample request (Pending, Approved, Fulfilled, Cancelled) for pipeline management."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the sample request for operational tracking."
    - name: "sample_purpose"
      expr: sample_purpose
      comment: "Purpose of the sample request (Evaluation, Qualification, Demo, Prototype) for program effectiveness analysis."
    - name: "cost_currency"
      expr: cost_currency
      comment: "Currency of the sample cost for multi-currency cost analysis."
    - name: "request_year_month"
      expr: DATE_TRUNC('month', request_date)
      comment: "Month of the sample request for demand trend analysis."
    - name: "delivery_requested_year_month"
      expr: DATE_TRUNC('month', delivery_requested_date)
      comment: "Month of requested delivery for fulfillment cycle time analysis."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(customer_sample_request_id)
      comment: "Total number of customer sample requests. Measures pre-sales design-in activity and customer evaluation pipeline."
    - name: "total_sample_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of samples provided to customers. Tracks pre-sales investment in customer design-in programs."
    - name: "avg_sample_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per sample request. Used to benchmark sample program economics and optimize cost-per-design-win."
    - name: "total_net_sample_cost"
      expr: SUM(CAST(cost_net AS DOUBLE))
      comment: "Total net cost of samples after adjustments. Measures actual sample program investment net of recoveries."
    - name: "fulfilled_sample_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'Fulfilled' THEN customer_sample_request_id END)
      comment: "Number of fulfilled sample requests. Measures sample program execution effectiveness and customer service level."
    - name: "pending_sample_count"
      expr: COUNT(CASE WHEN customer_sample_request_status = 'Pending' THEN customer_sample_request_id END)
      comment: "Number of pending sample requests. Measures backlog in the sample fulfillment pipeline requiring operational attention."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`customer_nda_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "NDA agreement coverage and compliance metrics — tracks NDA portfolio health, expiry risk, and mutual agreement coverage to manage IP protection and customer engagement compliance."
  source: "`vibe_semiconductors_v1`.`customer`.`nda_agreement`"
  dimensions:
    - name: "nda_agreement_status"
      expr: nda_agreement_status
      comment: "Current status of the NDA (Active, Expired, Terminated, Pending) for compliance coverage analysis."
    - name: "nda_type"
      expr: nda_type
      comment: "Type of NDA (Mutual, One-Way, Multi-Party) for agreement structure analysis."
    - name: "confidentiality_level"
      expr: confidentiality_level
      comment: "Confidentiality level of the NDA for IP protection tiering."
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Legal jurisdiction of the NDA for cross-border compliance management."
    - name: "is_mutual"
      expr: is_mutual
      comment: "Whether the NDA is mutual — affects IP protection balance and negotiation posture."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the NDA became effective for coverage trend analysis."
    - name: "expiration_year_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the NDA expires for renewal pipeline management."
  measures:
    - name: "total_nda_agreements"
      expr: COUNT(nda_agreement_id)
      comment: "Total number of NDA agreements. Measures IP protection coverage across the customer and supplier portfolio."
    - name: "active_nda_count"
      expr: COUNT(CASE WHEN nda_agreement_status = 'Active' THEN nda_agreement_id END)
      comment: "Number of currently active NDAs. Core IP protection coverage KPI for legal and compliance teams."
    - name: "expired_nda_count"
      expr: COUNT(CASE WHEN expiration_date < CURRENT_DATE THEN nda_agreement_id END)
      comment: "Number of expired NDAs. Measures IP protection compliance risk — expired NDAs may expose confidential information."
    - name: "mutual_nda_count"
      expr: COUNT(CASE WHEN is_mutual = TRUE THEN nda_agreement_id END)
      comment: "Number of mutual NDAs. Measures balanced IP protection coverage vs. one-way agreements."
    - name: "unique_accounts_with_nda"
      expr: COUNT(DISTINCT nda_account_id)
      comment: "Number of distinct accounts covered by an NDA. Measures breadth of IP protection coverage across the customer base."
$$;