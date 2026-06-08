-- Metric views for domain: client | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_advertiser`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the advertiser master entity — tracks portfolio health, consent compliance, onboarding velocity, and churn exposure across the client base."
  source: "`advertising_ecm`.`client`.`advertiser`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the advertiser account (e.g. Active, Suspended, Churned) — primary segmentation for portfolio health analysis."
    - name: "account_tier"
      expr: account_tier
      comment: "Commercial tier of the advertiser (e.g. Platinum, Gold, Silver) — used to prioritise resource allocation and service levels."
    - name: "holding_company_name"
      expr: holding_company_name
      comment: "Parent holding company of the advertiser — enables roll-up analysis of revenue and risk concentration by holding group."
    - name: "registered_office_country"
      expr: registered_office_country
      comment: "Country of the advertiser's registered office — supports geographic segmentation and regulatory compliance reporting."
    - name: "is_agency_managed"
      expr: is_agency_managed
      comment: "Flag indicating whether the advertiser is managed through an agency intermediary — distinguishes direct vs. agency-managed revenue streams."
    - name: "preferred_currency"
      expr: preferred_currency
      comment: "Advertiser's preferred billing currency — relevant for FX exposure and multi-currency revenue reporting."
    - name: "onboarding_year_month"
      expr: DATE_TRUNC('MONTH', onboarding_date)
      comment: "Month of advertiser onboarding — used to track new client acquisition velocity over time."
    - name: "churn_year_month"
      expr: DATE_TRUNC('MONTH', churn_date)
      comment: "Month of advertiser churn — used to track client attrition trends and seasonality."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Whether the advertiser has provided GDPR consent — critical for data usage compliance segmentation."
    - name: "ccpa_consent_flag"
      expr: ccpa_consent_flag
      comment: "Whether the advertiser has provided CCPA consent — critical for US privacy compliance segmentation."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Contractual payment terms for the advertiser (e.g. Net 30, Net 60) — used in cash flow and credit risk analysis."
    - name: "reporting_cadence"
      expr: reporting_cadence
      comment: "Frequency of reporting agreed with the advertiser — used to assess service delivery obligations."
  measures:
    - name: "total_active_advertisers"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN advertiser_id END)
      comment: "Count of advertisers with Active status — the primary measure of live portfolio size used in executive dashboards and QBRs."
    - name: "total_advertisers"
      expr: COUNT(advertiser_id)
      comment: "Total count of all advertiser records regardless of status — baseline denominator for portfolio penetration and conversion rate calculations."
    - name: "total_churned_advertisers"
      expr: COUNT(CASE WHEN churn_date IS NOT NULL THEN advertiser_id END)
      comment: "Count of advertisers that have churned (churn_date populated) — key input to churn rate and retention analysis."
    - name: "gdpr_consent_coverage_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN advertiser_id END)
      comment: "Number of advertisers with GDPR consent on file — measures regulatory compliance coverage; a drop triggers immediate legal/compliance action."
    - name: "ccpa_consent_coverage_count"
      expr: COUNT(CASE WHEN ccpa_consent_flag = TRUE THEN advertiser_id END)
      comment: "Number of advertisers with CCPA consent on file — measures US privacy compliance coverage across the client portfolio."
    - name: "agency_managed_advertiser_count"
      expr: COUNT(CASE WHEN is_agency_managed = TRUE THEN advertiser_id END)
      comment: "Count of advertisers managed through agency intermediaries — informs channel mix strategy and direct vs. indirect revenue split."
    - name: "direct_managed_advertiser_count"
      expr: COUNT(CASE WHEN is_agency_managed = FALSE THEN advertiser_id END)
      comment: "Count of advertisers managed directly (not via agency) — used alongside agency_managed_advertiser_count to assess channel balance."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_agency_relationship`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and operational KPIs for agency-advertiser relationships — tracks billings, commission economics, fee structures, and relationship health to steer agency partnership strategy."
  source: "`advertising_ecm`.`client`.`agency_relationship`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the agency-advertiser relationship (e.g. Active, Terminated, Under Review) — primary filter for live vs. historical relationship analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Type of agency relationship (e.g. AOR, Project, Retainer) — used to segment revenue and resource allocation by engagement model."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Commercial tier of the relationship — used to prioritise account management effort and investment."
    - name: "aor_designation"
      expr: aor_designation
      comment: "Agency of Record designation — identifies whether the agency holds AOR status, a key strategic indicator of relationship depth."
    - name: "fee_structure_type"
      expr: fee_structure_type
      comment: "Type of fee structure (e.g. Commission, Retainer, Project Fee) — used to analyse revenue model mix and margin implications."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the agency relationship — used for regional revenue and resource planning."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Whether the agency relationship is exclusive — exclusive relationships carry higher strategic value and retention risk."
    - name: "competitive_conflict_flag"
      expr: competitive_conflict_flag
      comment: "Flag indicating a competitive conflict exists within this relationship — used to manage conflict-of-interest risk and client retention."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the relationship became effective — used to track new relationship acquisition velocity."
    - name: "renewal_year_month"
      expr: DATE_TRUNC('MONTH', renewal_date)
      comment: "Month the relationship is due for renewal — used in pipeline and retention planning."
    - name: "pitch_type"
      expr: pitch_type
      comment: "Type of pitch that originated the relationship (e.g. Competitive, Incumbent, Sole Source) — used to assess win strategy effectiveness."
    - name: "scope_of_services"
      expr: scope_of_services
      comment: "Services in scope for the agency relationship — used to segment revenue by service line and identify cross-sell opportunities."
  measures:
    - name: "total_estimated_annual_billings"
      expr: SUM(CAST(estimated_annual_billings AS DOUBLE))
      comment: "Sum of estimated annual billings across all agency relationships — the primary top-line revenue pipeline metric reviewed at every QBR and board deck."
    - name: "avg_estimated_annual_billings"
      expr: AVG(CAST(estimated_annual_billings AS DOUBLE))
      comment: "Average estimated annual billings per agency relationship — used to benchmark relationship value and identify under-performing accounts."
    - name: "total_annual_fee_amount"
      expr: SUM(CAST(annual_fee_amount AS DOUBLE))
      comment: "Total contracted annual fee revenue across all agency relationships — directly tied to recognised revenue and financial forecasting."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across agency relationships — a key margin lever; declining averages signal pricing pressure or mix shift."
    - name: "total_active_relationships"
      expr: COUNT(CASE WHEN relationship_status = 'Active' THEN agency_relationship_id END)
      comment: "Count of currently active agency-advertiser relationships — baseline measure of live client engagement portfolio."
    - name: "total_relationships_with_conflict"
      expr: COUNT(CASE WHEN competitive_conflict_flag = TRUE THEN agency_relationship_id END)
      comment: "Number of relationships flagged with a competitive conflict — a risk metric; high counts signal client retention and reputational exposure."
    - name: "exclusive_relationship_count"
      expr: COUNT(CASE WHEN is_exclusive = TRUE THEN agency_relationship_id END)
      comment: "Count of exclusive agency relationships — exclusive relationships represent the highest-value, highest-retention-risk segment of the portfolio."
    - name: "relationships_due_for_renewal_count"
      expr: COUNT(CASE WHEN renewal_date <= ADD_MONTHS(CURRENT_DATE(), 3) AND renewal_date >= CURRENT_DATE() THEN agency_relationship_id END)
      comment: "Count of relationships with renewal dates within the next 90 days — a leading indicator of revenue at risk requiring proactive retention action."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_revenue_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue target attainment and pipeline KPIs — tracks target-setting, pipeline coverage, growth ambition, and ROAS targets to steer commercial performance management."
  source: "`advertising_ecm`.`client`.`revenue_target`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the revenue target — primary time dimension for annual performance management and board reporting."
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter of the revenue target — used for quarterly business review (QBR) performance tracking."
    - name: "target_type"
      expr: target_type
      comment: "Type of revenue target (e.g. Gross Revenue, Net Revenue, Fee Revenue) — used to segment performance by revenue recognition method."
    - name: "target_period_type"
      expr: target_period_type
      comment: "Period granularity of the target (e.g. Annual, Quarterly, Monthly) — used to align target analysis to the correct planning horizon."
    - name: "target_status"
      expr: target_status
      comment: "Current status of the revenue target (e.g. Draft, Approved, Revised) — used to filter to approved targets for official reporting."
    - name: "service_line"
      expr: service_line
      comment: "Service line associated with the revenue target (e.g. Media, Creative, PR) — enables P&L analysis by business unit."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the revenue target — used for multi-currency normalisation and FX impact analysis."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Confidence level assigned to the target (e.g. High, Medium, Low) — used to risk-weight pipeline and forecast accuracy analysis."
    - name: "is_stretch_target"
      expr: is_stretch_target
      comment: "Flag indicating whether this is a stretch (aspirational) target vs. a committed target — used to separate base plan from upside scenario analysis."
    - name: "target_setting_method"
      expr: target_setting_method
      comment: "Method used to set the target (e.g. Top-Down, Bottom-Up, Negotiated) — used to assess forecast reliability and planning process quality."
    - name: "period_start_year_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month the target period begins — used for time-series trending of revenue targets."
  measures:
    - name: "total_target_amount_usd"
      expr: SUM(CAST(target_amount_usd AS DOUBLE))
      comment: "Total revenue target in USD across all records — the primary top-line commercial ambition metric used in board and investor reporting."
    - name: "total_pipeline_amount"
      expr: SUM(CAST(pipeline_amount AS DOUBLE))
      comment: "Total pipeline value associated with revenue targets — measures the opportunity funnel available to achieve targets; a leading indicator of target attainment."
    - name: "total_original_target_amount"
      expr: SUM(CAST(original_target_amount AS DOUBLE))
      comment: "Sum of original (pre-revision) target amounts — used alongside total_target_amount_usd to quantify the magnitude of target revisions over the planning cycle."
    - name: "avg_account_growth_rate_pct"
      expr: AVG(CAST(account_growth_rate_pct AS DOUBLE))
      comment: "Average account growth rate percentage across revenue targets — a strategic KPI indicating the ambition level of the commercial plan; declining averages signal market headwinds."
    - name: "avg_contracted_sow_coverage_pct"
      expr: AVG(CAST(contracted_sow_coverage_pct AS DOUBLE))
      comment: "Average percentage of the revenue target covered by contracted Statements of Work — measures revenue certainty; low coverage signals high at-risk revenue requiring pipeline action."
    - name: "avg_roas_target"
      expr: AVG(CAST(roas_target AS DOUBLE))
      comment: "Average Return on Ad Spend target across all revenue targets — a key advertiser value metric; used to assess whether campaign ROI commitments are realistic and achievable."
    - name: "stretch_target_count"
      expr: COUNT(CASE WHEN is_stretch_target = TRUE THEN revenue_target_id END)
      comment: "Number of stretch targets in the plan — used to assess the proportion of upside vs. committed revenue in the commercial forecast."
    - name: "approved_target_count"
      expr: COUNT(CASE WHEN target_status = 'Approved' THEN revenue_target_id END)
      comment: "Count of approved revenue targets — baseline for official plan coverage; gaps between total and approved targets indicate planning process delays."
    - name: "total_targets"
      expr: COUNT(revenue_target_id)
      comment: "Total count of revenue target records — denominator for approval rate and stretch target ratio calculations."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_account_team`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Workforce and capacity KPIs for account team assignments — tracks staffing coverage, billing rate economics, FTE allocation, and conflict exposure to steer talent and resource management."
  source: "`advertising_ecm`.`client`.`account_team`"
  dimensions:
    - name: "assignment_status"
      expr: assignment_status
      comment: "Current status of the account team assignment (e.g. Active, Pending, Ended) — primary filter for live staffing analysis."
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of assignment (e.g. Dedicated, Shared, Fractional) — used to segment capacity and cost allocation by engagement model."
    - name: "team_function"
      expr: team_function
      comment: "Functional area of the team member (e.g. Strategy, Creative, Media, Analytics) — used for workforce planning and skill gap analysis."
    - name: "seniority_level"
      expr: seniority_level
      comment: "Seniority level of the team member (e.g. Junior, Mid, Senior, Director) — used to analyse team composition, cost structure, and delivery risk."
    - name: "role"
      expr: role
      comment: "Specific role of the team member on the account — used for coverage analysis and succession planning."
    - name: "billing_rate_type"
      expr: billing_rate_type
      comment: "Type of billing rate applied (e.g. Hourly, Daily, Fixed) — used to segment revenue contribution by billing model."
    - name: "client_facing_flag"
      expr: client_facing_flag
      comment: "Whether the team member is client-facing — used to assess client relationship coverage and service delivery capacity."
    - name: "conflict_of_interest_flag"
      expr: conflict_of_interest_flag
      comment: "Whether a conflict of interest has been identified for this assignment — a risk metric requiring immediate management action when flagged."
    - name: "is_primary_contact"
      expr: is_primary_contact
      comment: "Whether the team member is the primary client contact — used to ensure every account has a designated primary contact for relationship continuity."
    - name: "start_year_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the assignment started — used to track staffing ramp velocity and onboarding patterns."
  measures:
    - name: "total_active_assignments"
      expr: COUNT(CASE WHEN assignment_status = 'Active' THEN account_team_id END)
      comment: "Count of currently active account team assignments — the primary measure of live staffing coverage across the client portfolio."
    - name: "total_planned_hours_per_month"
      expr: SUM(CAST(planned_hours_per_month AS DOUBLE))
      comment: "Total planned hours per month across all active assignments — measures total capacity committed to client delivery; a key input to resource utilisation and profitability analysis."
    - name: "avg_planned_hours_per_month"
      expr: AVG(CAST(planned_hours_per_month AS DOUBLE))
      comment: "Average planned hours per month per assignment — used to benchmark workload distribution and identify over- or under-allocated team members."
    - name: "total_billing_rate_usd"
      expr: SUM(CAST(billing_rate_usd AS DOUBLE))
      comment: "Sum of billing rates across all assignments — proxy for total billable rate capacity; used in revenue-per-head and rate card analysis."
    - name: "avg_billing_rate_usd"
      expr: AVG(CAST(billing_rate_usd AS DOUBLE))
      comment: "Average billing rate in USD across assignments — a key pricing metric; declining averages signal rate erosion or unfavourable mix shift toward junior staff."
    - name: "avg_fte_allocation_pct"
      expr: AVG(CAST(fte_allocation_pct AS DOUBLE))
      comment: "Average FTE allocation percentage across assignments — measures how fully team members are allocated; low averages indicate under-utilisation and margin leakage."
    - name: "conflict_of_interest_assignment_count"
      expr: COUNT(CASE WHEN conflict_of_interest_flag = TRUE THEN account_team_id END)
      comment: "Number of assignments with an active conflict of interest flag — a compliance risk metric; any non-zero value requires immediate review and remediation."
    - name: "accounts_without_primary_contact"
      expr: COUNT(CASE WHEN is_primary_contact = FALSE OR is_primary_contact IS NULL THEN account_team_id END)
      comment: "Count of assignments where no primary contact is designated — identifies client relationship coverage gaps that increase churn and satisfaction risk."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Brand portfolio KPIs — tracks media budget scale, programmatic eligibility, digital readiness, and brand health indicators to steer brand investment and activation strategy."
  source: "`advertising_ecm`.`client`.`brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current lifecycle status of the brand (e.g. Active, Discontinued, Pending Launch) — primary filter for live brand portfolio analysis."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Commercial tier of the brand (e.g. Hero, Core, Tail) — used to prioritise media investment and agency resource allocation."
    - name: "brand_category"
      expr: brand_category
      comment: "Product or service category of the brand — used for competitive analysis and category-level budget benchmarking."
    - name: "primary_channel"
      expr: primary_channel
      comment: "Primary advertising channel for the brand (e.g. Digital, TV, OOH) — used to analyse channel mix and investment allocation."
    - name: "primary_market_country"
      expr: primary_market_country
      comment: "Primary market country for the brand — used for geographic revenue and investment analysis."
    - name: "digital_advertising_enabled"
      expr: digital_advertising_enabled
      comment: "Whether the brand is enabled for digital advertising — used to assess digital transformation progress across the brand portfolio."
    - name: "programmatic_eligible"
      expr: programmatic_eligible
      comment: "Whether the brand is eligible for programmatic buying — programmatic-eligible brands unlock automated, data-driven media efficiency."
    - name: "is_house_brand"
      expr: is_house_brand
      comment: "Whether the brand is a house (proprietary) brand vs. a client brand — used to separate internal and external brand investment."
    - name: "budget_currency"
      expr: budget_currency
      comment: "Currency of the brand's annual media budget — used for multi-currency normalisation in global portfolio analysis."
    - name: "launch_year_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month the brand was launched — used to track new brand activation velocity and portfolio growth trends."
    - name: "safety_level"
      expr: safety_level
      comment: "Brand safety classification level — used to ensure media placements comply with brand safety requirements and avoid reputational risk."
  measures:
    - name: "total_annual_media_budget"
      expr: SUM(CAST(annual_media_budget AS DOUBLE))
      comment: "Total annual media budget across all brands — the primary measure of advertising investment scale; directly informs agency revenue forecasting and media planning capacity."
    - name: "avg_annual_media_budget"
      expr: AVG(CAST(annual_media_budget AS DOUBLE))
      comment: "Average annual media budget per brand — used to benchmark brand investment levels and identify under-invested brands relative to portfolio norms."
    - name: "avg_sov_target_pct"
      expr: AVG(CAST(sov_target_pct AS DOUBLE))
      comment: "Average Share of Voice target percentage across brands — a strategic competitive metric; declining averages signal weakening market position ambitions."
    - name: "total_active_brands"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN brand_id END)
      comment: "Count of currently active brands in the portfolio — baseline measure of live brand management scope and agency workload."
    - name: "programmatic_eligible_brand_count"
      expr: COUNT(CASE WHEN programmatic_eligible = TRUE THEN brand_id END)
      comment: "Number of brands eligible for programmatic buying — measures the portfolio's readiness for automated media efficiency; a key digital transformation KPI."
    - name: "digital_enabled_brand_count"
      expr: COUNT(CASE WHEN digital_advertising_enabled = TRUE THEN brand_id END)
      comment: "Number of brands enabled for digital advertising — tracks digital activation coverage across the portfolio; gaps represent untapped digital revenue opportunity."
    - name: "total_brands"
      expr: COUNT(brand_id)
      comment: "Total count of brand records — denominator for digital enablement rate, programmatic eligibility rate, and active brand ratio calculations."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_brief`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign brief pipeline and budget KPIs — tracks brief volume, budget indication, approval velocity, and campaign objective mix to steer creative and media planning capacity."
  source: "`advertising_ecm`.`client`.`client_brief`"
  dimensions:
    - name: "brief_status"
      expr: brief_status
      comment: "Current status of the client brief (e.g. Draft, Submitted, Approved, Closed) — primary filter for active pipeline vs. historical brief analysis."
    - name: "brief_type"
      expr: brief_type
      comment: "Type of brief (e.g. Campaign, Always-On, Tactical, Brand) — used to segment workload and resource allocation by engagement type."
    - name: "campaign_objective"
      expr: campaign_objective
      comment: "Primary campaign objective (e.g. Awareness, Consideration, Conversion) — used to analyse brief mix and align agency capabilities to client goals."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the brief (e.g. High, Medium, Low) — used to triage workload and ensure high-priority briefs receive adequate resource."
    - name: "primary_kpi"
      expr: primary_kpi
      comment: "Primary KPI the campaign is designed to move (e.g. Reach, CTR, ROAS, CPA) — used to align measurement frameworks and reporting to client objectives."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the campaign brief — used for regional capacity planning and media market analysis."
    - name: "is_agency_managed"
      expr: is_agency_managed
      comment: "Whether the brief is managed by an agency — used to distinguish direct client briefs from agency-intermediated work."
    - name: "is_confidential"
      expr: is_confidential
      comment: "Whether the brief is marked confidential — used to enforce data access controls and identify sensitive campaign work."
    - name: "campaign_start_year_month"
      expr: DATE_TRUNC('MONTH', campaign_start_date)
      comment: "Month the campaign is scheduled to start — used to forecast workload peaks and media activation timelines."
    - name: "submission_year_month"
      expr: DATE_TRUNC('MONTH', submission_date)
      comment: "Month the brief was submitted — used to track brief intake velocity and pipeline build rate over time."
    - name: "budget_currency_code"
      expr: budget_currency_code
      comment: "Currency of the brief's budget indication — used for multi-currency pipeline normalisation."
  measures:
    - name: "total_budget_indication_amount"
      expr: SUM(CAST(budget_indication_amount AS DOUBLE))
      comment: "Total indicated budget across all client briefs — the primary measure of campaign revenue pipeline; directly informs media planning capacity and agency revenue forecasting."
    - name: "avg_budget_indication_amount"
      expr: AVG(CAST(budget_indication_amount AS DOUBLE))
      comment: "Average indicated budget per brief — used to benchmark brief value and identify shifts in campaign scale that affect resource planning."
    - name: "total_active_briefs"
      expr: COUNT(CASE WHEN brief_status NOT IN ('Closed', 'Cancelled') THEN client_brief_id END)
      comment: "Count of briefs not yet closed or cancelled — measures the live campaign pipeline volume requiring active agency resource."
    - name: "total_approved_briefs"
      expr: COUNT(CASE WHEN brief_status = 'Approved' THEN client_brief_id END)
      comment: "Count of approved briefs — measures confirmed campaign work entering production; a leading indicator of near-term revenue recognition."
    - name: "total_briefs"
      expr: COUNT(client_brief_id)
      comment: "Total count of all brief records — denominator for approval rate, conversion rate, and pipeline coverage ratio calculations."
    - name: "avg_primary_kpi_target_value"
      expr: AVG(CAST(primary_kpi_target_value AS DOUBLE))
      comment: "Average primary KPI target value across briefs — used to assess the ambition level of campaign objectives and benchmark against historical delivery performance."
    - name: "high_priority_brief_count"
      expr: COUNT(CASE WHEN priority_level = 'High' THEN client_brief_id END)
      comment: "Count of high-priority briefs — used to assess urgency of the pipeline and ensure adequate resource allocation to the most strategically important campaigns."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`client_advertiser_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Holding company and advertiser hierarchy KPIs — tracks ownership concentration, billing consolidation, and hierarchy coverage to steer enterprise account management and revenue roll-up reporting."
  source: "`advertising_ecm`.`client`.`advertiser_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Current status of the hierarchy relationship (e.g. Active, Inactive, Pending) — primary filter for live vs. historical hierarchy analysis."
    - name: "hierarchy_type"
      expr: hierarchy_type
      comment: "Type of hierarchy (e.g. Ownership, Billing, Reporting) — used to segment hierarchy analysis by business purpose."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the hierarchy (e.g. Global, Regional, Local) — used to analyse revenue concentration at different organisational tiers."
    - name: "market_region"
      expr: market_region
      comment: "Market region of the hierarchy node — used for regional revenue roll-up and geographic concentration analysis."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the advertiser hierarchy — used for vertical market analysis and competitive conflict management."
    - name: "country_code"
      expr: country_code
      comment: "Country code of the hierarchy node — used for geographic revenue attribution and regulatory compliance segmentation."
    - name: "billing_consolidation_flag"
      expr: billing_consolidation_flag
      comment: "Whether billing is consolidated at this hierarchy level — used to identify accounts eligible for consolidated invoicing and volume discount analysis."
    - name: "is_primary_hierarchy"
      expr: is_primary_hierarchy
      comment: "Whether this is the primary hierarchy relationship for the advertiser — used to deduplicate roll-up reporting to the canonical hierarchy."
    - name: "sov_rollup_flag"
      expr: sov_rollup_flag
      comment: "Whether Share of Voice metrics roll up through this hierarchy node — used to ensure SOV reporting is correctly aggregated at the holding company level."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the hierarchy relationship became effective — used to track structural changes in the advertiser portfolio over time."
  measures:
    - name: "total_agency_commission_rate_sum"
      expr: SUM(CAST(agency_commission_rate AS DOUBLE))
      comment: "Sum of agency commission rates across hierarchy relationships — used as a portfolio-level input to total commission revenue modelling."
    - name: "avg_agency_commission_rate"
      expr: AVG(CAST(agency_commission_rate AS DOUBLE))
      comment: "Average agency commission rate across advertiser hierarchy relationships — a key margin metric; declining averages signal rate compression at the holding company level."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships — used to assess the depth of ownership linkages and identify minority vs. majority-owned entities for revenue attribution."
    - name: "total_active_hierarchy_relationships"
      expr: COUNT(CASE WHEN hierarchy_status = 'Active' THEN advertiser_hierarchy_id END)
      comment: "Count of active advertiser hierarchy relationships — measures the structural complexity of the client portfolio; growth indicates M&A activity or new holding company onboarding."
    - name: "billing_consolidated_relationship_count"
      expr: COUNT(CASE WHEN billing_consolidation_flag = TRUE THEN advertiser_hierarchy_id END)
      comment: "Count of hierarchy relationships with billing consolidation enabled — measures the proportion of the portfolio on consolidated billing, which reduces invoicing cost and improves cash flow predictability."
    - name: "total_hierarchy_relationships"
      expr: COUNT(advertiser_hierarchy_id)
      comment: "Total count of advertiser hierarchy records — denominator for consolidation rate, active rate, and SOV rollup coverage calculations."
$$;