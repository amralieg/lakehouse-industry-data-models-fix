-- Metric views for domain: brokerage | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_deal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core deal pipeline and transaction performance metrics for the brokerage domain. Tracks deal volume, value, commission economics, and pipeline conversion across deal types, stages, and transaction sides."
  source: "`real_estate_ecm`.`brokerage`.`brokerage_deal`"
  dimensions:
    - name: "deal_type"
      expr: deal_type
      comment: "Type of brokerage deal (e.g. sale, lease, sublease) used to segment pipeline and revenue analysis."
    - name: "deal_stage"
      expr: stage
      comment: "Current pipeline stage of the deal (e.g. prospect, LOI, under contract, closed) for funnel analysis."
    - name: "transaction_side"
      expr: side
      comment: "Brokerage side of the transaction (buy-side, sell-side, tenant-rep, landlord-rep) for revenue attribution."
    - name: "deal_source"
      expr: deal_source
      comment: "Origin channel of the deal (e.g. referral, inbound, outbound, MLS) for lead source effectiveness analysis."
    - name: "is_co_brokerage"
      expr: is_co_brokerage
      comment: "Indicates whether the deal involves a co-brokerage arrangement, affecting net commission economics."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the deal is under an exclusive brokerage arrangement."
    - name: "projected_close_month"
      expr: DATE_TRUNC('MONTH', projected_close_date)
      comment: "Month bucket of the projected close date for pipeline forecasting and capacity planning."
    - name: "actual_close_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Month bucket of the actual close date for closed-deal revenue trending."
    - name: "dead_reason"
      expr: dead_reason
      comment: "Reason a deal was lost or killed, used for win/loss analysis and pipeline quality improvement."
  measures:
    - name: "total_deals"
      expr: COUNT(1)
      comment: "Total number of brokerage deals in the pipeline or closed. Baseline volume KPI for deal flow monitoring."
    - name: "total_commission_amount"
      expr: SUM(CAST(commission_amount AS DOUBLE))
      comment: "Total gross commission dollars across all deals. Primary revenue KPI for brokerage operations."
    - name: "total_total_consideration"
      expr: SUM(CAST(total_consideration AS DOUBLE))
      comment: "Total transaction consideration (sale price or lease value) across all deals. Measures aggregate deal volume and market activity."
    - name: "total_sale_price"
      expr: SUM(CAST(sale_price AS DOUBLE))
      comment: "Total sale price across closed sale transactions. Key revenue and market volume indicator for investment sales."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate percentage across deals. Monitors pricing power and competitive positioning of the brokerage."
    - name: "avg_deal_size_sqft"
      expr: AVG(CAST(size_sqft AS DOUBLE))
      comment: "Average deal size in square feet. Indicates the scale of transactions and helps segment small vs. large deal activity."
    - name: "total_pipeline_value"
      expr: SUM(CAST(total_consideration AS DOUBLE) * CAST(probability_pct AS DOUBLE) / 100.0)
      comment: "Probability-weighted pipeline value (total consideration × probability %). Core forward-looking revenue forecast metric for leadership."
    - name: "avg_lease_rate_psf"
      expr: AVG(CAST(lease_rate_psf AS DOUBLE))
      comment: "Average lease rate per square foot across lease deals. Benchmarks leasing pricing against market rates."
    - name: "avg_tenant_improvement_allowance"
      expr: AVG(CAST(tenant_improvement_allowance AS DOUBLE))
      comment: "Average tenant improvement allowance offered across lease deals. Tracks concession levels and their impact on net effective rent."
    - name: "avg_co_broker_commission_pct"
      expr: AVG(CAST(co_broker_commission_pct AS DOUBLE))
      comment: "Average co-broker commission split percentage. Monitors co-brokerage cost and cooperation economics."
    - name: "commission_to_consideration_ratio"
      expr: ROUND(100.0 * SUM(CAST(commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_consideration AS DOUBLE)), 0), 4)
      comment: "Effective commission rate as a percentage of total consideration. Measures brokerage yield on transaction volume — a key profitability efficiency ratio."
    - name: "closed_deals"
      expr: COUNT(CASE WHEN actual_close_date IS NOT NULL THEN 1 END)
      comment: "Number of deals that have reached a confirmed close. Tracks conversion from pipeline to closed revenue."
    - name: "dead_deals"
      expr: COUNT(CASE WHEN dead_date IS NOT NULL THEN 1 END)
      comment: "Number of deals that have been killed or lost. Used to compute win rate and diagnose pipeline attrition."
    - name: "deal_win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_close_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_close_date IS NOT NULL OR dead_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of resolved deals (closed or dead) that were won (closed). Core pipeline quality and sales effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_commission`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission economics and payment performance metrics. Tracks gross commission income, agent splits, co-broker costs, referral fees, tax withholding, and payment status to govern brokerage profitability and compliance."
  source: "`real_estate_ecm`.`brokerage`.`commission`"
  dimensions:
    - name: "commission_type"
      expr: commission_type
      comment: "Type of commission (e.g. sale, lease, referral, renewal) for revenue mix analysis."
    - name: "commission_status"
      expr: commission_status
      comment: "Current status of the commission record (e.g. pending, approved, paid, disputed) for cash flow and compliance monitoring."
    - name: "brokerage_side"
      expr: brokerage_side
      comment: "Side of the transaction the brokerage represents (buy, sell, tenant, landlord) for revenue attribution."
    - name: "is_co_broker"
      expr: is_co_broker
      comment: "Indicates whether a co-broker is involved, affecting net commission retained by the house."
    - name: "is_referral"
      expr: is_referral
      comment: "Indicates whether the commission includes a referral fee obligation."
    - name: "trigger_event"
      expr: trigger_event
      comment: "Business event that triggered the commission (e.g. lease execution, closing, renewal) for revenue recognition timing."
    - name: "paid_month"
      expr: DATE_TRUNC('MONTH', paid_date)
      comment: "Month in which the commission was paid. Used for cash flow trending and period-over-period revenue analysis."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month in which the commission was approved. Tracks approval cycle timing and revenue recognition lag."
  measures:
    - name: "total_gross_commission_amount"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission income (GCI) across all commission records. Primary top-line revenue KPI for the brokerage."
    - name: "total_net_commission_to_house"
      expr: SUM(CAST(net_commission_to_house AS DOUBLE))
      comment: "Total net commission retained by the brokerage house after agent splits and co-broker fees. Core profitability KPI."
    - name: "total_agent_commission_amount"
      expr: SUM(CAST(agent_commission_amount AS DOUBLE))
      comment: "Total commission paid out to agents. Measures agent compensation cost and split economics."
    - name: "total_co_broker_commission_amount"
      expr: SUM(CAST(co_broker_commission_amount AS DOUBLE))
      comment: "Total commission paid to co-brokers. Tracks co-brokerage cost and its impact on net revenue."
    - name: "total_referral_fee_amount"
      expr: SUM(CAST(referral_fee_amount AS DOUBLE))
      comment: "Total referral fees paid out. Monitors referral network cost and its contribution to deal sourcing."
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total commission dollars actually disbursed. Tracks cash outflow and payment completion against approved amounts."
    - name: "total_tax_withholding_amount"
      expr: SUM(CAST(tax_withholding_amount AS DOUBLE))
      comment: "Total tax withheld from commission payments. Ensures regulatory compliance with withholding obligations."
    - name: "avg_agent_split_pct"
      expr: AVG(CAST(agent_split_pct AS DOUBLE))
      comment: "Average agent commission split percentage. Benchmarks agent compensation structure and informs split tier negotiations."
    - name: "house_retention_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_commission_to_house AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross commission income retained by the brokerage house after all splits and fees. Key profitability efficiency ratio for leadership."
    - name: "co_broker_cost_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(co_broker_commission_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Co-broker commission as a percentage of gross commission income. Monitors the cost of co-brokerage arrangements on overall margin."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(rate_pct AS DOUBLE))
      comment: "Average commission rate percentage applied to consideration. Tracks pricing power and rate compression over time."
    - name: "unpaid_commission_amount"
      expr: SUM(CASE WHEN paid_date IS NULL THEN CAST(gross_commission_amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross commission not yet paid. Measures outstanding commission liability and cash flow exposure."
    - name: "disputed_commission_count"
      expr: COUNT(CASE WHEN dispute_reason IS NOT NULL THEN 1 END)
      comment: "Number of commission records with an active dispute. Tracks compliance risk and operational friction in commission processing."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_listing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Listing inventory, pricing, and market performance metrics. Tracks active inventory, pricing levels, days on market, and listing conversion to inform pricing strategy and inventory management."
  source: "`real_estate_ecm`.`brokerage`.`listing`"
  dimensions:
    - name: "listing_type"
      expr: listing_type
      comment: "Type of listing (e.g. for sale, for lease, sublease) for inventory segmentation."
    - name: "listing_status"
      expr: listing_status
      comment: "Current status of the listing (e.g. active, under contract, closed, expired) for inventory health monitoring."
    - name: "deal_stage"
      expr: deal_stage
      comment: "Pipeline stage associated with the listing for funnel and conversion analysis."
    - name: "is_exclusive"
      expr: is_exclusive
      comment: "Indicates whether the listing is held under an exclusive agreement, affecting competitive positioning."
    - name: "is_mls_syndicated"
      expr: is_mls_syndicated
      comment: "Indicates whether the listing is syndicated to MLS, affecting market exposure and lead generation."
    - name: "is_costar_syndicated"
      expr: is_costar_syndicated
      comment: "Indicates whether the listing is syndicated to CoStar, a key commercial real estate data platform."
    - name: "listing_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the listing went live. Used for cohort analysis of listing performance and market timing."
    - name: "listing_close_month"
      expr: DATE_TRUNC('MONTH', close_date)
      comment: "Month the listing closed. Used for closed inventory trending and seasonality analysis."
  measures:
    - name: "total_listings"
      expr: COUNT(1)
      comment: "Total number of listings. Baseline inventory volume KPI for market coverage and broker productivity."
    - name: "active_listings"
      expr: COUNT(CASE WHEN listing_status = 'Active' THEN 1 END)
      comment: "Number of currently active listings. Tracks live inventory available to the market."
    - name: "total_listing_price"
      expr: SUM(CAST(price AS DOUBLE))
      comment: "Total asking price across all listings. Measures aggregate inventory value under management."
    - name: "total_close_price"
      expr: SUM(CAST(close_price AS DOUBLE))
      comment: "Total closed transaction value across sold/leased listings. Tracks realized transaction volume."
    - name: "avg_lease_rate_psf"
      expr: AVG(CAST(lease_rate_psf AS DOUBLE))
      comment: "Average asking lease rate per square foot across lease listings. Benchmarks pricing against submarket rates."
    - name: "avg_listing_price"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average asking price per listing. Tracks pricing trends and average deal size in the portfolio."
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total gross leasable area across all listings. Measures the scale of inventory under management."
    - name: "avg_nla_sqft"
      expr: AVG(CAST(nla_sqft AS DOUBLE))
      comment: "Average net leasable area per listing. Indicates typical deal size and space configuration in the portfolio."
    - name: "avg_commission_rate_pct"
      expr: AVG(CAST(commission_rate_pct AS DOUBLE))
      comment: "Average commission rate across listings. Monitors pricing power and rate trends in listing agreements."
    - name: "price_to_close_ratio"
      expr: ROUND(SUM(CAST(close_price AS DOUBLE)) / NULLIF(SUM(CAST(price AS DOUBLE)), 0), 4)
      comment: "Ratio of total close price to total asking price. Measures negotiation outcomes and pricing accuracy — a key market intelligence KPI."
    - name: "avg_tenant_improvement_allowance"
      expr: AVG(CAST(tenant_improvement_allowance AS DOUBLE))
      comment: "Average tenant improvement allowance offered on lease listings. Tracks concession levels and their impact on net effective rent."
    - name: "avg_cam_rate_psf"
      expr: AVG(CAST(cam_rate_psf AS DOUBLE))
      comment: "Average CAM (common area maintenance) rate per square foot. Monitors occupancy cost burden on tenants and its effect on leasing velocity."
    - name: "avg_parking_ratio"
      expr: AVG(CAST(parking_ratio AS DOUBLE))
      comment: "Average parking ratio across listings. A key amenity metric influencing tenant demand and lease competitiveness."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_broker`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker productivity, compensation, and compliance metrics. Tracks GCI performance, production tiers, license status, and workforce composition to support talent management and regulatory oversight."
  source: "`real_estate_ecm`.`brokerage`.`broker`"
  dimensions:
    - name: "broker_type"
      expr: broker_type
      comment: "Classification of the broker (e.g. associate, managing, principal) for productivity segmentation."
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g. W-2, 1099, independent contractor) for workforce cost and compliance analysis."
    - name: "production_tier"
      expr: production_tier
      comment: "Production tier assigned to the broker based on GCI thresholds. Used for compensation plan management and talent retention."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the broker is currently active. Used to filter productive headcount from total roster."
    - name: "office_location"
      expr: office_location
      comment: "Physical office location of the broker for geographic productivity analysis."
    - name: "team_name"
      expr: team_name
      comment: "Team the broker belongs to for team-level performance benchmarking."
    - name: "dual_agency_authorized"
      expr: dual_agency_authorized
      comment: "Indicates whether the broker is authorized for dual agency transactions, affecting deal eligibility."
    - name: "ccim_designation"
      expr: ccim_designation
      comment: "Indicates whether the broker holds a CCIM designation, a key commercial real estate credential."
    - name: "sior_designation"
      expr: sior_designation
      comment: "Indicates whether the broker holds a SIOR designation, a premier industrial and office brokerage credential."
    - name: "hire_year"
      expr: DATE_TRUNC('YEAR', hire_date)
      comment: "Year the broker was hired. Used for tenure cohort analysis and retention tracking."
  measures:
    - name: "total_brokers"
      expr: COUNT(1)
      comment: "Total number of broker records. Baseline headcount KPI for workforce planning."
    - name: "active_brokers"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active brokers. Tracks productive headcount available for deal execution."
    - name: "total_gci_ytd"
      expr: SUM(CAST(gci_ytd AS DOUBLE))
      comment: "Total gross commission income year-to-date across all brokers. Primary revenue production KPI for the brokerage workforce."
    - name: "total_gci_prior_year"
      expr: SUM(CAST(gci_prior_year AS DOUBLE))
      comment: "Total gross commission income for the prior year across all brokers. Baseline for year-over-year growth analysis."
    - name: "avg_gci_ytd_per_broker"
      expr: AVG(CAST(gci_ytd AS DOUBLE))
      comment: "Average GCI year-to-date per broker. Measures individual broker productivity and benchmarks against production tier thresholds."
    - name: "avg_gci_prior_year_per_broker"
      expr: AVG(CAST(gci_prior_year AS DOUBLE))
      comment: "Average GCI prior year per broker. Used for year-over-year productivity comparison and compensation planning."
    - name: "gci_ytd_growth_rate_pct"
      expr: ROUND(100.0 * (SUM(CAST(gci_ytd AS DOUBLE)) - SUM(CAST(gci_prior_year AS DOUBLE))) / NULLIF(SUM(CAST(gci_prior_year AS DOUBLE)), 0), 2)
      comment: "Year-over-year GCI growth rate percentage across the broker workforce. Key strategic KPI for revenue trajectory and talent investment decisions."
    - name: "avg_continuing_education_hours"
      expr: AVG(CAST(continuing_education_hours_completed AS DOUBLE))
      comment: "Average continuing education hours completed per broker. Monitors license compliance and professional development investment."
    - name: "brokers_with_ccim"
      expr: COUNT(CASE WHEN ccim_designation = TRUE THEN 1 END)
      comment: "Number of brokers holding CCIM designation. Tracks credential depth as a competitive differentiator and talent quality indicator."
    - name: "brokers_with_sior"
      expr: COUNT(CASE WHEN sior_designation = TRUE THEN 1 END)
      comment: "Number of brokers holding SIOR designation. Tracks elite credential coverage for industrial and office specialization."
    - name: "credential_coverage_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN ccim_designation = TRUE OR sior_designation = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN is_active = TRUE THEN 1 END), 0), 2)
      comment: "Percentage of active brokers holding at least one major professional designation (CCIM or SIOR). Measures talent quality and competitive positioning."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_showing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Showing activity, prospect engagement, and leasing funnel metrics. Tracks showing volume, outcomes, follow-up compliance, and prospect interest to optimize leasing velocity and broker effectiveness."
  source: "`real_estate_ecm`.`brokerage`.`showing`"
  dimensions:
    - name: "showing_type"
      expr: showing_type
      comment: "Type of showing (e.g. in-person, virtual, open house) for channel effectiveness analysis."
    - name: "showing_status"
      expr: showing_status
      comment: "Status of the showing (e.g. scheduled, completed, cancelled, no-show) for activity quality monitoring."
    - name: "outcome"
      expr: outcome
      comment: "Outcome of the showing (e.g. interested, not interested, offer submitted) for funnel conversion analysis."
    - name: "prospect_interest_level"
      expr: prospect_interest_level
      comment: "Prospect interest level recorded after the showing (e.g. high, medium, low) for pipeline prioritization."
    - name: "deal_stage"
      expr: deal_stage
      comment: "Deal stage at the time of the showing for funnel stage analysis."
    - name: "prospect_side"
      expr: prospect_side
      comment: "Side of the prospect (buyer, tenant, investor) for demand segmentation."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Indicates whether a follow-up action is required after the showing. Tracks broker responsiveness obligations."
    - name: "nda_executed"
      expr: nda_executed
      comment: "Indicates whether an NDA was executed for the showing, relevant for confidential listings."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', CAST(scheduled_start AS DATE))
      comment: "Month the showing was scheduled. Used for activity volume trending and seasonality analysis."
  measures:
    - name: "total_showings"
      expr: COUNT(1)
      comment: "Total number of showings conducted. Baseline leasing activity KPI for broker productivity and market demand."
    - name: "completed_showings"
      expr: COUNT(CASE WHEN showing_status = 'Completed' THEN 1 END)
      comment: "Number of showings that were completed (not cancelled or no-show). Measures effective prospect engagement."
    - name: "cancelled_showings"
      expr: COUNT(CASE WHEN showing_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled showings. Tracks prospect attrition and scheduling efficiency."
    - name: "showing_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN showing_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of scheduled showings that were completed. Measures prospect commitment quality and scheduling effectiveness."
    - name: "high_interest_showings"
      expr: COUNT(CASE WHEN prospect_interest_level = 'High' THEN 1 END)
      comment: "Number of showings resulting in high prospect interest. Leading indicator of deal conversion and pipeline quality."
    - name: "high_interest_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prospect_interest_level = 'High' THEN 1 END) / NULLIF(COUNT(CASE WHEN showing_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed showings resulting in high prospect interest. Measures listing quality and broker presentation effectiveness."
    - name: "follow_up_overdue_showings"
      expr: COUNT(CASE WHEN follow_up_required = TRUE AND follow_up_due_date < CURRENT_DATE() AND follow_up_action IS NULL THEN 1 END)
      comment: "Number of showings with overdue follow-up actions. Tracks broker responsiveness and CRM compliance — directly impacts conversion rates."
    - name: "avg_budget_psf"
      expr: AVG(CAST(budget_psf AS DOUBLE))
      comment: "Average prospect budget per square foot across showings. Benchmarks demand-side pricing expectations against listing rates."
    - name: "unique_prospects_shown"
      expr: COUNT(DISTINCT brokerage_prospect_id)
      comment: "Number of distinct prospects who have attended at least one showing. Measures breadth of active demand in the pipeline."
    - name: "unique_listings_shown"
      expr: COUNT(DISTINCT listing_id)
      comment: "Number of distinct listings that have received at least one showing. Tracks inventory exposure and identifies unlisted or under-shown properties."
    - name: "avg_showings_per_listing"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT listing_id), 0), 2)
      comment: "Average number of showings per listing. Measures listing demand intensity and helps identify slow-moving inventory."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline quality, lead conversion, and demand-side metrics. Tracks prospect volume, qualification status, budget capacity, and engagement to optimize lead management and conversion strategy."
  source: "`real_estate_ecm`.`brokerage`.`brokerage_prospect`"
  dimensions:
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. buyer, tenant, investor) for demand segmentation and pipeline management."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the prospect (e.g. qualified, unqualified, pending) for pipeline quality filtering."
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel that generated the prospect (e.g. referral, website, cold call) for marketing ROI analysis."
    - name: "lost_reason"
      expr: lost_reason
      comment: "Reason the prospect was lost. Used for win/loss analysis and pipeline improvement."
    - name: "gdpr_consent_given"
      expr: gdpr_consent_given
      comment: "Indicates whether GDPR consent was obtained. Tracks regulatory compliance for prospect data handling."
    - name: "is_do_not_contact"
      expr: is_do_not_contact
      comment: "Indicates whether the prospect has opted out of contact. Critical for compliance and outreach governance."
    - name: "ti_requirement"
      expr: ti_requirement
      comment: "Indicates whether the prospect requires tenant improvement allowance. Affects deal economics and landlord negotiation."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the prospect record was created. Used for lead volume trending and cohort conversion analysis."
    - name: "target_move_in_month"
      expr: DATE_TRUNC('MONTH', target_move_in_date)
      comment: "Month the prospect targets to move in. Used for demand timing and pipeline urgency segmentation."
  measures:
    - name: "total_prospects"
      expr: COUNT(1)
      comment: "Total number of brokerage prospects. Baseline demand pipeline volume KPI."
    - name: "qualified_prospects"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Number of qualified prospects. Measures actionable pipeline depth available for deal conversion."
    - name: "prospect_qualification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects that are qualified. Measures lead quality from inbound and outbound channels."
    - name: "total_budget_capacity"
      expr: SUM(CAST(total_budget AS DOUBLE))
      comment: "Total budget capacity across all prospects. Measures aggregate demand-side purchasing power in the pipeline."
    - name: "avg_budget_psf"
      expr: AVG(CAST(budget_psf AS DOUBLE))
      comment: "Average prospect budget per square foot. Benchmarks demand-side pricing expectations against available inventory rates."
    - name: "avg_cap_rate_target"
      expr: AVG(CAST(cap_rate_target AS DOUBLE))
      comment: "Average target cap rate across investment prospects. Tracks investor return expectations and their alignment with available inventory."
    - name: "avg_irr_target"
      expr: AVG(CAST(irr_target AS DOUBLE))
      comment: "Average target IRR across investment prospects. Measures investor return hurdle rates to inform deal structuring and pricing."
    - name: "do_not_contact_prospects"
      expr: COUNT(CASE WHEN is_do_not_contact = TRUE THEN 1 END)
      comment: "Number of prospects flagged as do-not-contact. Tracks compliance exposure and effective reachable pipeline size."
    - name: "contactable_prospect_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_do_not_contact = FALSE OR is_do_not_contact IS NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prospects that are contactable (not do-not-contact). Measures effective outreach universe for sales and marketing."
    - name: "avg_total_budget"
      expr: AVG(CAST(total_budget AS DOUBLE))
      comment: "Average total budget per prospect. Indicates average deal size potential in the demand pipeline."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_commission_split`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commission disbursement and agent payout metrics. Tracks split amounts, net disbursements, deductions, withholding, and payment status to govern agent compensation accuracy and financial controls."
  source: "`real_estate_ecm`.`brokerage`.`commission_split`"
  dimensions:
    - name: "recipient_type"
      expr: recipient_type
      comment: "Type of commission recipient (e.g. agent, team, referral partner) for payout segmentation."
    - name: "disbursement_status"
      expr: disbursement_status
      comment: "Current disbursement status (e.g. pending, approved, disbursed, reversed) for payment pipeline monitoring."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the commission split for financial controls and audit compliance."
    - name: "brokerage_side"
      expr: brokerage_side
      comment: "Transaction side associated with the split for revenue attribution analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment (e.g. ACH, check, wire) for treasury and payment operations analysis."
    - name: "is_1099_reportable"
      expr: is_1099_reportable
      comment: "Indicates whether the disbursement is 1099-reportable. Critical for tax compliance and IRS reporting obligations."
    - name: "disbursement_month"
      expr: DATE_TRUNC('MONTH', actual_disbursement_date)
      comment: "Month of actual disbursement. Used for cash flow trending and period-close reconciliation."
  measures:
    - name: "total_split_amount"
      expr: SUM(CAST(split_amount AS DOUBLE))
      comment: "Total commission split amount across all disbursement records. Measures total agent payout obligation."
    - name: "total_net_disbursement_amount"
      expr: SUM(CAST(net_disbursement_amount AS DOUBLE))
      comment: "Total net amount actually disbursed to recipients after all deductions. Primary cash outflow KPI for commission operations."
    - name: "total_gross_commission_amount"
      expr: SUM(CAST(gross_commission_amount AS DOUBLE))
      comment: "Total gross commission amount associated with splits. Used to reconcile split totals against gross commission records."
    - name: "total_desk_fee_deduction"
      expr: SUM(CAST(desk_fee_deduction AS DOUBLE))
      comment: "Total desk fee deductions applied to commission splits. Tracks brokerage desk fee revenue and its impact on agent net pay."
    - name: "total_errors_omissions_deduction"
      expr: SUM(CAST(errors_omissions_deduction AS DOUBLE))
      comment: "Total E&O insurance deductions from commission splits. Monitors insurance cost recovery and compliance with E&O requirements."
    - name: "total_withholding_amount"
      expr: SUM(CAST(withholding_amount AS DOUBLE))
      comment: "Total tax withholding applied to commission disbursements. Ensures compliance with withholding tax obligations."
    - name: "avg_split_pct"
      expr: AVG(CAST(split_pct AS DOUBLE))
      comment: "Average commission split percentage across all disbursement records. Benchmarks agent split economics and compensation plan effectiveness."
    - name: "net_disbursement_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(net_disbursement_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_amount AS DOUBLE)), 0), 2)
      comment: "Net disbursement as a percentage of gross commission. Measures the effective payout rate after all deductions — a key agent compensation efficiency ratio."
    - name: "pending_disbursement_amount"
      expr: SUM(CASE WHEN disbursement_status = 'Pending' THEN CAST(net_disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total net disbursement amount in pending status. Tracks outstanding agent payment obligations and cash flow timing."
    - name: "reversed_disbursement_amount"
      expr: SUM(CASE WHEN reversal_date IS NOT NULL THEN CAST(net_disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total disbursement amount that has been reversed. Monitors payment error rates and financial restatement risk."
    - name: "reportable_1099_amount"
      expr: SUM(CASE WHEN is_1099_reportable = TRUE THEN CAST(net_disbursement_amount AS DOUBLE) ELSE 0 END)
      comment: "Total disbursement amount subject to 1099 reporting. Critical for IRS compliance and year-end tax reporting obligations."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_referral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Referral network performance and fee economics metrics. Tracks referral volume, fee income, deal outcomes, and network effectiveness to optimize referral partnerships and inbound/outbound deal flow."
  source: "`real_estate_ecm`.`brokerage`.`referral`"
  dimensions:
    - name: "referral_type"
      expr: referral_type
      comment: "Type of referral (e.g. inbound, outbound, reciprocal) for network flow analysis."
    - name: "referral_status"
      expr: referral_status
      comment: "Current status of the referral (e.g. active, closed, expired, lost) for pipeline monitoring."
    - name: "deal_outcome"
      expr: deal_outcome
      comment: "Outcome of the referred deal (e.g. closed, lost, pending) for conversion analysis."
    - name: "direction"
      expr: direction
      comment: "Direction of the referral (inbound to firm vs. outbound from firm) for net referral economics."
    - name: "payment_direction"
      expr: payment_direction
      comment: "Direction of fee payment (paying vs. receiving) for cash flow and P&L attribution."
    - name: "fee_structure"
      expr: fee_structure
      comment: "Fee structure of the referral agreement (e.g. flat fee, percentage of GCI) for economics analysis."
    - name: "is_reciprocal"
      expr: is_reciprocal
      comment: "Indicates whether the referral is part of a reciprocal arrangement. Tracks mutual referral network value."
    - name: "source_network"
      expr: source_network
      comment: "Network or platform that sourced the referral (e.g. NAR, SIOR, personal network) for channel effectiveness analysis."
    - name: "agreement_month"
      expr: DATE_TRUNC('MONTH', agreement_date)
      comment: "Month the referral agreement was executed. Used for referral volume trending."
  measures:
    - name: "total_referrals"
      expr: COUNT(1)
      comment: "Total number of referral records. Baseline referral network activity KPI."
    - name: "closed_referrals"
      expr: COUNT(CASE WHEN deal_outcome = 'Closed' THEN 1 END)
      comment: "Number of referrals that resulted in a closed deal. Measures referral network conversion effectiveness."
    - name: "referral_conversion_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN deal_outcome = 'Closed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of referrals that converted to closed deals. Key referral network quality and ROI metric."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total referral fee amount across all referrals. Measures gross referral fee income and expense."
    - name: "total_gross_commission_income"
      expr: SUM(CAST(gross_commission_income AS DOUBLE))
      comment: "Total gross commission income generated from referred deals. Measures the revenue value of the referral network."
    - name: "total_actual_deal_value"
      expr: SUM(CAST(actual_deal_value AS DOUBLE))
      comment: "Total actual deal value across closed referrals. Measures the aggregate transaction volume sourced through referrals."
    - name: "avg_fee_pct"
      expr: AVG(CAST(fee_pct AS DOUBLE))
      comment: "Average referral fee percentage. Benchmarks referral cost and income rates against industry norms."
    - name: "referral_fee_to_gci_ratio"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_commission_income AS DOUBLE)), 0), 2)
      comment: "Referral fee as a percentage of gross commission income. Measures the cost of referral-sourced deals relative to their revenue contribution."
    - name: "avg_actual_deal_value"
      expr: AVG(CAST(actual_deal_value AS DOUBLE))
      comment: "Average actual deal value per referral. Indicates the typical deal size sourced through the referral network."
    - name: "unique_referring_firms"
      expr: COUNT(DISTINCT referring_firm_name)
      comment: "Number of distinct referring firms in the network. Measures referral network breadth and diversification."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`brokerage_broker_license`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Broker license compliance, renewal, and disciplinary risk metrics. Tracks license status, CE compliance, E&O coverage, disciplinary actions, and renewal timelines to manage regulatory risk and workforce compliance."
  source: "`real_estate_ecm`.`brokerage`.`broker_license`"
  dimensions:
    - name: "license_type"
      expr: license_type
      comment: "Type of broker license (e.g. salesperson, broker, managing broker) for compliance segmentation."
    - name: "license_status"
      expr: license_status
      comment: "Current status of the license (e.g. active, expired, suspended, revoked) for compliance risk monitoring."
    - name: "license_class"
      expr: license_class
      comment: "License class designation for regulatory classification and reporting."
    - name: "ce_compliance_status"
      expr: ce_compliance_status
      comment: "Continuing education compliance status (e.g. compliant, non-compliant, pending) for regulatory risk tracking."
    - name: "renewal_status"
      expr: renewal_status
      comment: "License renewal status (e.g. renewed, pending, lapsed) for proactive renewal management."
    - name: "disciplinary_flag"
      expr: disciplinary_flag
      comment: "Indicates whether the license has an active disciplinary action. Critical compliance risk indicator."
    - name: "errors_omissions_insured"
      expr: errors_omissions_insured
      comment: "Indicates whether the broker has active E&O insurance coverage. Tracks insurance compliance obligations."
    - name: "reciprocal_license"
      expr: reciprocal_license
      comment: "Indicates whether the license is a reciprocal license from another state. Tracks multi-state practice eligibility."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month the license expires. Used for proactive renewal pipeline management and compliance risk forecasting."
  measures:
    - name: "total_licenses"
      expr: COUNT(1)
      comment: "Total number of broker license records. Baseline compliance inventory KPI."
    - name: "active_licenses"
      expr: COUNT(CASE WHEN license_status = 'Active' THEN 1 END)
      comment: "Number of currently active licenses. Tracks compliant broker capacity available for transactions."
    - name: "expired_licenses"
      expr: COUNT(CASE WHEN license_status = 'Expired' THEN 1 END)
      comment: "Number of expired licenses. Identifies compliance violations requiring immediate remediation."
    - name: "license_active_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN license_status = 'Active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of licenses that are currently active. Measures overall license compliance health across the broker workforce."
    - name: "disciplinary_action_count"
      expr: COUNT(CASE WHEN disciplinary_flag = TRUE THEN 1 END)
      comment: "Number of licenses with active disciplinary actions. Critical regulatory risk KPI for compliance oversight and E&O exposure management."
    - name: "ce_non_compliant_count"
      expr: COUNT(CASE WHEN ce_compliance_status = 'Non-Compliant' THEN 1 END)
      comment: "Number of licenses with non-compliant continuing education status. Tracks CE compliance risk and potential license suspension exposure."
    - name: "uninsured_license_count"
      expr: COUNT(CASE WHEN errors_omissions_insured = FALSE THEN 1 END)
      comment: "Number of licenses without active E&O insurance coverage. Measures uninsured liability exposure across the broker workforce."
    - name: "eo_coverage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN errors_omissions_insured = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN license_status = 'Active' THEN 1 END), 0), 2)
      comment: "Percentage of active licenses with E&O insurance coverage. Key risk management KPI for brokerage liability governance."
    - name: "licenses_expiring_within_90_days"
      expr: COUNT(CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN 1 END)
      comment: "Number of licenses expiring within the next 90 days. Proactive compliance KPI for renewal pipeline management and risk prevention."
    - name: "reciprocal_license_count"
      expr: COUNT(CASE WHEN reciprocal_license = TRUE THEN 1 END)
      comment: "Number of reciprocal licenses held by brokers. Tracks multi-state practice capacity and geographic market coverage."
$$;