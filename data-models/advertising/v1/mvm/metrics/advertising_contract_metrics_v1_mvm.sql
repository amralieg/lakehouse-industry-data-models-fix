-- Metric views for domain: contract | Business: Advertising | Version: 1 | Generated on: 2026-05-08 03:48:00

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over master agreements — tracks portfolio value, liability exposure, contract lifecycle health, and renewal risk across all advertiser and supplier agreements."
  source: "`advertising_ecm`.`contract`.`agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current lifecycle status of the agreement (e.g. Active, Expired, Terminated, Draft) — primary filter for portfolio health analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Classification of the agreement (e.g. MSA, SOW, Vendor, Media) — used to segment portfolio by contract category."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Commercial pricing model governing the agreement (e.g. Fixed Fee, Time & Materials, CPM) — key dimension for revenue model analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code of the agreement — used for multi-currency portfolio segmentation."
    - name: "counterparty_type"
      expr: counterparty_type
      comment: "Type of counterparty (e.g. Advertiser, Supplier, Agency) — enables portfolio split by relationship type."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the agreement auto-renews — critical for forecasting future committed revenue without manual intervention."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the agreement became effective — used for cohort and vintage analysis of contract starts."
    - name: "expiry_year_month"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the agreement expires — used to build contract expiry calendars and renewal pipeline views."
    - name: "governing_law"
      expr: governing_law
      comment: "Jurisdiction governing the agreement — used for legal and compliance segmentation."
    - name: "sla_included_flag"
      expr: sla_included_flag
      comment: "Indicates whether an SLA is embedded in the agreement — used to assess service commitment coverage."
  measures:
    - name: "total_committed_value"
      expr: SUM(CAST(total_committed_value AS DOUBLE))
      comment: "Total contractually committed value across all agreements — the primary revenue backlog KPI for executive portfolio reviews."
    - name: "avg_committed_value_per_agreement"
      expr: AVG(CAST(total_committed_value AS DOUBLE))
      comment: "Average committed value per agreement — benchmarks deal size and informs pricing strategy and negotiation targets."
    - name: "total_liability_cap"
      expr: SUM(CAST(liability_cap_amount AS DOUBLE))
      comment: "Aggregate liability cap exposure across all agreements — critical risk management KPI for legal and finance leadership."
    - name: "avg_liability_cap"
      expr: AVG(CAST(liability_cap_amount AS DOUBLE))
      comment: "Average liability cap per agreement — used to benchmark risk exposure relative to deal size."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Active' THEN agreement_id END)
      comment: "Number of currently active agreements — baseline portfolio health metric for operational and executive dashboards."
    - name: "expiring_within_90_days_count"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN agreement_id END)
      comment: "Number of agreements expiring within the next 90 days — renewal pipeline urgency KPI for account management and legal teams."
    - name: "auto_renewal_agreement_count"
      expr: COUNT(CASE WHEN auto_renewal_flag = TRUE THEN agreement_id END)
      comment: "Count of agreements with auto-renewal enabled — measures passive revenue retention without manual renegotiation."
    - name: "terminated_agreement_count"
      expr: COUNT(CASE WHEN agreement_status = 'Terminated' THEN agreement_id END)
      comment: "Number of terminated agreements — churn signal used to assess contract attrition and relationship health."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers under contract — measures breadth of client portfolio coverage."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers under contract — measures vendor portfolio diversity and dependency concentration."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_amendment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPIs tracking contract change activity — measures budget volatility, amendment velocity, legal review compliance, and scope revision patterns across all contract amendments."
  source: "`advertising_ecm`.`contract`.`amendment`"
  dimensions:
    - name: "amendment_status"
      expr: amendment_status
      comment: "Current status of the amendment (e.g. Pending, Approved, Rejected) — primary filter for amendment pipeline management."
    - name: "amendment_type"
      expr: amendment_type
      comment: "Type of change captured in the amendment (e.g. Budget, Scope, Term Extension) — used to categorize change drivers."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the amendment financial values — used for multi-currency budget delta analysis."
    - name: "legal_review_required"
      expr: legal_review_required
      comment: "Indicates whether legal review was required for this amendment — used to assess legal workload and compliance adherence."
    - name: "legal_review_completed"
      expr: legal_review_completed
      comment: "Indicates whether legal review was completed — used to identify amendments pending legal clearance."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the amendment became effective — used for trend analysis of contract change activity over time."
    - name: "change_reason"
      expr: change_reason
      comment: "Business reason driving the amendment — used to identify systemic causes of contract changes."
  measures:
    - name: "total_budget_delta"
      expr: SUM(CAST(budget_delta_amount AS DOUBLE))
      comment: "Net budget change across all amendments — measures total financial impact of contract modifications on committed spend."
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Sum of all revised budget amounts post-amendment — reflects the updated total financial commitment after changes."
    - name: "total_original_budget"
      expr: SUM(CAST(original_budget_amount AS DOUBLE))
      comment: "Sum of all original budget amounts before amendment — baseline for measuring budget variance driven by contract changes."
    - name: "avg_budget_delta_per_amendment"
      expr: AVG(CAST(budget_delta_amount AS DOUBLE))
      comment: "Average budget change per amendment — benchmarks the typical financial impact of a contract modification."
    - name: "amendment_count"
      expr: COUNT(amendment_id)
      comment: "Total number of amendments — measures contract change velocity and operational complexity of the contract portfolio."
    - name: "pending_legal_review_count"
      expr: COUNT(CASE WHEN legal_review_required = TRUE AND legal_review_completed = FALSE THEN amendment_id END)
      comment: "Number of amendments requiring but not yet completing legal review — legal bottleneck KPI for risk and compliance management."
    - name: "approved_amendment_count"
      expr: COUNT(CASE WHEN amendment_status = 'Approved' THEN amendment_id END)
      comment: "Number of approved amendments — measures throughput of the amendment approval process."
    - name: "distinct_agreements_amended"
      expr: COUNT(DISTINCT agreement_id)
      comment: "Number of distinct agreements that have been amended — measures breadth of contract instability across the portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_deliverable`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial KPIs for contract deliverables — tracks delivery performance, cost variance, billable value, and milestone completion across all contracted work items."
  source: "`advertising_ecm`.`contract`.`contract_deliverable`"
  dimensions:
    - name: "contract_deliverable_status"
      expr: contract_deliverable_status
      comment: "Current status of the deliverable (e.g. In Progress, Completed, Rejected, Overdue) — primary operational health dimension."
    - name: "deliverable_type"
      expr: deliverable_type
      comment: "Category of deliverable (e.g. Creative Asset, Report, Media Plan) — used to segment delivery performance by work type."
    - name: "priority"
      expr: priority
      comment: "Priority level of the deliverable — used to focus operational attention on high-priority delivery risk."
    - name: "is_milestone"
      expr: is_milestone
      comment: "Indicates whether the deliverable is a contract milestone — used to track milestone completion rates separately from routine deliverables."
    - name: "responsible_team"
      expr: responsible_team
      comment: "Team responsible for delivering the work item — used for team-level performance and capacity analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the deliverable cost and billing amounts — used for multi-currency financial analysis."
    - name: "due_year_month"
      expr: DATE_TRUNC('month', due_date)
      comment: "Month the deliverable is due — used for delivery pipeline and workload forecasting."
    - name: "requires_client_approval"
      expr: requires_client_approval
      comment: "Indicates whether client sign-off is required — used to identify deliverables at risk of approval delays."
  measures:
    - name: "total_billable_amount"
      expr: SUM(CAST(billable_amount AS DOUBLE))
      comment: "Total billable value of all deliverables — primary revenue recognition KPI for contract delivery performance."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across all deliverables — used to measure cost efficiency against contracted budgets."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all deliverables — baseline for cost variance and budget adherence analysis."
    - name: "total_cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Aggregate cost overrun or saving across all deliverables — key profitability signal for project and contract management."
    - name: "total_actual_hours"
      expr: SUM(CAST(actual_hours AS DOUBLE))
      comment: "Total actual hours worked across all deliverables — used for resource utilization and capacity planning."
    - name: "total_estimated_hours"
      expr: SUM(CAST(estimated_hours AS DOUBLE))
      comment: "Total estimated hours across all deliverables — baseline for hours variance and staffing efficiency analysis."
    - name: "avg_billable_amount_per_deliverable"
      expr: AVG(CAST(billable_amount AS DOUBLE))
      comment: "Average billable amount per deliverable — benchmarks revenue yield per unit of contracted work."
    - name: "completed_deliverable_count"
      expr: COUNT(CASE WHEN contract_deliverable_status = 'Completed' THEN contract_deliverable_id END)
      comment: "Number of completed deliverables — measures delivery throughput and contract execution progress."
    - name: "overdue_deliverable_count"
      expr: COUNT(CASE WHEN contract_deliverable_status != 'Completed' AND due_date < CURRENT_DATE THEN contract_deliverable_id END)
      comment: "Number of deliverables past their due date and not yet completed — critical SLA breach risk indicator."
    - name: "milestone_completion_count"
      expr: COUNT(CASE WHEN is_milestone = TRUE AND contract_deliverable_status = 'Completed' THEN contract_deliverable_id END)
      comment: "Number of completed contract milestones — measures progress against key contractual checkpoints."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_insertion_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and performance KPIs for contract insertion orders — tracks authorized spend, committed media inventory, agency commission, and IO lifecycle status across all media buying commitments."
  source: "`advertising_ecm`.`contract`.`contract_insertion_order`"
  dimensions:
    - name: "io_status"
      expr: io_status
      comment: "Current status of the insertion order (e.g. Active, Pending, Cancelled, Completed) — primary filter for IO portfolio management."
    - name: "io_type"
      expr: io_type
      comment: "Type of insertion order (e.g. Standard, Programmatic, Direct) — used to segment media buying activity by procurement method."
    - name: "media_channel"
      expr: media_channel
      comment: "Media channel covered by the IO (e.g. Digital, TV, OOH, Social) — key dimension for channel-level spend analysis."
    - name: "buying_method"
      expr: buying_method
      comment: "Method used to buy media (e.g. Direct, Programmatic, Auction) — used to analyze procurement efficiency by buying approach."
    - name: "rate_type"
      expr: rate_type
      comment: "Pricing rate type (e.g. CPM, CPC, CPA, Flat Fee) — used to segment IO portfolio by commercial pricing model."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the IO financial values — used for multi-currency spend analysis."
    - name: "flight_start_year_month"
      expr: DATE_TRUNC('month', flight_start_date)
      comment: "Month the IO flight begins — used for spend forecasting and media calendar planning."
    - name: "flight_end_year_month"
      expr: DATE_TRUNC('month', flight_end_date)
      comment: "Month the IO flight ends — used for budget expiry and pacing analysis."
  measures:
    - name: "total_authorized_spend"
      expr: SUM(CAST(total_authorized_spend AS DOUBLE))
      comment: "Total media spend authorized across all insertion orders — primary financial commitment KPI for media buying portfolios."
    - name: "avg_authorized_spend_per_io"
      expr: AVG(CAST(total_authorized_spend AS DOUBLE))
      comment: "Average authorized spend per insertion order — benchmarks IO deal size and informs media planning norms."
    - name: "total_agency_commission"
      expr: SUM(CAST(agency_commission_rate AS DOUBLE) * CAST(total_authorized_spend AS DOUBLE) / 100.0)
      comment: "Estimated total agency commission revenue derived from IO spend and commission rate — key agency revenue KPI."
    - name: "total_third_party_ad_serving_fee"
      expr: SUM(CAST(third_party_ad_serving_fee AS DOUBLE))
      comment: "Total third-party ad serving fees across all IOs — measures technology cost overhead on media buys."
    - name: "total_committed_impressions"
      expr: SUM(CAST(committed_impressions AS DOUBLE))
      comment: "Total impressions committed across all IOs — measures contracted media inventory volume for delivery planning."
    - name: "total_committed_clicks"
      expr: SUM(CAST(committed_clicks AS DOUBLE))
      comment: "Total clicks committed across all IOs — measures contracted performance volume for click-based campaigns."
    - name: "total_committed_conversions"
      expr: SUM(CAST(committed_conversions AS DOUBLE))
      comment: "Total conversions committed across all IOs — measures contracted outcome volume for performance-based campaigns."
    - name: "active_io_count"
      expr: COUNT(CASE WHEN io_status = 'Active' THEN contract_insertion_order_id END)
      comment: "Number of currently active insertion orders — baseline operational metric for media buying pipeline management."
    - name: "distinct_campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns covered by insertion orders — measures breadth of active media campaign commitments."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_rate_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing governance KPIs for contract rate cards — tracks negotiated rates, discount and markup levels, rate card coverage, and pricing model distribution across the commercial rate structure."
  source: "`advertising_ecm`.`contract`.`contract_rate_card`"
  dimensions:
    - name: "contract_rate_card_status"
      expr: contract_rate_card_status
      comment: "Current status of the rate card (e.g. Active, Expired, Draft) — primary filter for pricing governance reviews."
    - name: "rate_card_type"
      expr: rate_card_type
      comment: "Type of rate card (e.g. Standard, Negotiated, Volume) — used to segment pricing structures by commercial tier."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied on the rate card (e.g. CPM, Fixed, Retainer) — key dimension for commercial model analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line the rate card applies to (e.g. Creative, Media, Strategy) — used for service-level pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the rate card values — used for multi-currency pricing analysis."
    - name: "is_negotiable"
      expr: is_negotiable
      comment: "Indicates whether the rate card is open to negotiation — used to segment standard vs. negotiated pricing."
    - name: "geography_scope"
      expr: geography_scope
      comment: "Geographic scope of the rate card — used to analyze pricing variation by market or region."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the rate card became effective — used for pricing vintage and rate change trend analysis."
  measures:
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate AS DOUBLE))
      comment: "Average base rate across all rate cards — benchmarks the standard pricing level for commercial negotiations."
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage granted across rate cards — measures pricing concession levels and negotiation outcomes."
    - name: "avg_markup_percentage"
      expr: AVG(CAST(markup_percentage AS DOUBLE))
      comment: "Average markup percentage applied across rate cards — measures margin uplift built into contracted pricing."
    - name: "max_base_rate"
      expr: MAX(CAST(base_rate AS DOUBLE))
      comment: "Maximum base rate across all rate cards — identifies the ceiling of contracted pricing for benchmarking and outlier detection."
    - name: "min_base_rate"
      expr: MIN(CAST(base_rate AS DOUBLE))
      comment: "Minimum base rate across all rate cards — identifies the floor of contracted pricing for competitive and margin analysis."
    - name: "active_rate_card_count"
      expr: COUNT(CASE WHEN contract_rate_card_status = 'Active' THEN contract_rate_card_id END)
      comment: "Number of currently active rate cards — measures the breadth of live pricing agreements in the portfolio."
    - name: "distinct_advertiser_count"
      expr: COUNT(DISTINCT advertiser_id)
      comment: "Number of distinct advertisers with active rate cards — measures client pricing coverage across the portfolio."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_renewal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for contract renewal management — tracks renewal pipeline value, win/loss outcomes, churn risk, pricing model changes, and negotiation cycle performance."
  source: "`advertising_ecm`.`contract`.`renewal`"
  dimensions:
    - name: "renewal_status"
      expr: renewal_status
      comment: "Current status of the renewal (e.g. In Negotiation, Won, Lost, Pending) — primary filter for renewal pipeline management."
    - name: "renewal_type"
      expr: renewal_type
      comment: "Type of renewal (e.g. Auto, Negotiated, Early) — used to segment renewal activity by process type."
    - name: "outcome"
      expr: outcome
      comment: "Final outcome of the renewal process (e.g. Renewed, Churned, Renegotiated) — key dimension for win/loss analysis."
    - name: "churn_risk_flag"
      expr: churn_risk_flag
      comment: "Indicates whether the renewal is flagged as churn risk — used to prioritize retention interventions."
    - name: "pricing_model_change_flag"
      expr: pricing_model_change_flag
      comment: "Indicates whether the pricing model changed at renewal — used to track commercial model evolution across the portfolio."
    - name: "scope_change_flag"
      expr: scope_change_flag
      comment: "Indicates whether the scope of work changed at renewal — used to identify upsell and downsell patterns."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the renewal financial values — used for multi-currency renewal value analysis."
    - name: "effective_year_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the renewed contract becomes effective — used for renewal cohort and revenue timing analysis."
    - name: "auto_renewal_clause_flag"
      expr: auto_renewal_clause_flag
      comment: "Indicates whether the contract contains an auto-renewal clause — used to forecast passive vs. active renewal pipeline."
  measures:
    - name: "total_new_term_value"
      expr: SUM(CAST(new_term_value AS DOUBLE))
      comment: "Total value of renewed contracts in the new term — primary revenue retention KPI for executive renewal reviews."
    - name: "total_prior_term_value"
      expr: SUM(CAST(prior_term_value AS DOUBLE))
      comment: "Total value of contracts in the prior term — baseline for measuring renewal growth or contraction."
    - name: "total_value_change"
      expr: SUM(CAST(value_change_amount AS DOUBLE))
      comment: "Net value change across all renewals — measures aggregate revenue expansion or contraction from the renewal cycle."
    - name: "avg_value_change_percentage"
      expr: AVG(CAST(value_change_percentage AS DOUBLE))
      comment: "Average percentage value change per renewal — benchmarks pricing power and commercial negotiation outcomes."
    - name: "avg_renewal_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average renewal probability score across the pipeline — used to forecast expected renewal revenue and prioritize at-risk accounts."
    - name: "churn_risk_renewal_count"
      expr: COUNT(CASE WHEN churn_risk_flag = TRUE THEN renewal_id END)
      comment: "Number of renewals flagged as churn risk — measures the volume of at-risk revenue requiring retention action."
    - name: "won_renewal_count"
      expr: COUNT(CASE WHEN outcome = 'Renewed' THEN renewal_id END)
      comment: "Number of successfully won renewals — measures retention success rate for the contract portfolio."
    - name: "lost_renewal_count"
      expr: COUNT(CASE WHEN outcome = 'Churned' THEN renewal_id END)
      comment: "Number of lost renewals resulting in churn — measures revenue attrition from failed contract renewals."
    - name: "weighted_pipeline_value"
      expr: SUM(CAST(new_term_value AS DOUBLE) * CAST(probability_score AS DOUBLE) / 100.0)
      comment: "Probability-weighted renewal pipeline value — provides a risk-adjusted forecast of expected renewal revenue for financial planning."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_sla`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service level agreement KPIs — tracks SLA target coverage, penalty exposure, breach thresholds, and compliance monitoring status across all contracted service commitments."
  source: "`advertising_ecm`.`contract`.`sla`"
  dimensions:
    - name: "sla_status"
      expr: sla_status
      comment: "Current status of the SLA (e.g. Active, Breached, Expired, Suspended) — primary filter for SLA compliance monitoring."
    - name: "sla_type"
      expr: sla_type
      comment: "Type of SLA (e.g. Response Time, Delivery, Quality, Uptime) — used to segment service commitments by category."
    - name: "metric_name"
      expr: metric_name
      comment: "Name of the performance metric being measured by the SLA — used to group SLA performance by specific service dimension."
    - name: "measurement_frequency"
      expr: measurement_frequency
      comment: "How frequently the SLA metric is measured (e.g. Daily, Weekly, Monthly) — used to assess monitoring cadence coverage."
    - name: "penalty_mechanism"
      expr: penalty_mechanism
      comment: "Type of penalty applied on SLA breach (e.g. Credit, Termination, Fee) — used to assess financial risk of SLA failures."
    - name: "compliance_tracking_enabled"
      expr: compliance_tracking_enabled
      comment: "Indicates whether automated compliance tracking is active for the SLA — used to identify SLAs with monitoring gaps."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the SLA became effective — used for SLA vintage and coverage trend analysis."
  measures:
    - name: "total_penalty_exposure"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total financial penalty exposure across all SLAs — primary risk KPI for legal and finance leadership managing service commitments."
    - name: "avg_sla_target_value"
      expr: AVG(CAST(target_value AS DOUBLE))
      comment: "Average SLA target value across all service commitments — benchmarks the stringency of contracted service levels."
    - name: "avg_breach_threshold"
      expr: AVG(CAST(breach_threshold AS DOUBLE))
      comment: "Average breach threshold across all SLAs — measures the tolerance band built into contracted service commitments."
    - name: "active_sla_count"
      expr: COUNT(CASE WHEN sla_status = 'Active' THEN sla_id END)
      comment: "Number of currently active SLAs — baseline metric for service commitment portfolio coverage."
    - name: "breached_sla_count"
      expr: COUNT(CASE WHEN sla_status = 'Breached' THEN sla_id END)
      comment: "Number of SLAs currently in breach — critical operational risk KPI triggering immediate remediation action."
    - name: "untracked_sla_count"
      expr: COUNT(CASE WHEN compliance_tracking_enabled = FALSE THEN sla_id END)
      comment: "Number of SLAs without automated compliance tracking — identifies governance gaps in service level monitoring."
    - name: "distinct_supplier_sla_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers with active SLA commitments — measures vendor accountability coverage across the supply chain."
$$;

CREATE OR REPLACE VIEW `advertising_ecm`.`_metrics`.`contract_sow`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and commercial KPIs for Statements of Work — tracks total contract value, budget composition, agency fee yield, performance bonus potential, and SOW portfolio health."
  source: "`advertising_ecm`.`contract`.`sow`"
  dimensions:
    - name: "sow_status"
      expr: sow_status
      comment: "Current status of the SOW (e.g. Active, Draft, Expired, Terminated) — primary filter for SOW portfolio management."
    - name: "sow_type"
      expr: sow_type
      comment: "Type of SOW (e.g. Project, Retainer, Campaign) — used to segment work commitments by engagement model."
    - name: "billing_model"
      expr: billing_model
      comment: "Billing model for the SOW (e.g. Fixed Fee, Time & Materials, Retainer) — key commercial model dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the SOW financial values — used for multi-currency portfolio analysis."
    - name: "invoicing_frequency"
      expr: invoicing_frequency
      comment: "Frequency of invoicing under the SOW (e.g. Monthly, Milestone, Quarterly) — used for cash flow forecasting."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Indicates whether the SOW auto-renews — used to forecast passive revenue continuity."
    - name: "effective_start_year_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the SOW became effective — used for SOW cohort and revenue vintage analysis."
    - name: "effective_end_year_month"
      expr: DATE_TRUNC('month', effective_end_date)
      comment: "Month the SOW expires — used for revenue expiry forecasting and renewal pipeline planning."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contracted value across all SOWs — primary revenue backlog KPI for agency and client portfolio reviews."
    - name: "total_media_budget"
      expr: SUM(CAST(media_budget_amount AS DOUBLE))
      comment: "Total media budget committed across all SOWs — measures the scale of media investment under management."
    - name: "total_production_budget"
      expr: SUM(CAST(production_budget_amount AS DOUBLE))
      comment: "Total production budget across all SOWs — measures creative and production investment under contract."
    - name: "total_agency_fee"
      expr: SUM(CAST(agency_fee_amount AS DOUBLE))
      comment: "Total agency fee revenue across all SOWs — primary agency revenue KPI for financial planning and margin analysis."
    - name: "total_performance_bonus_potential"
      expr: SUM(CAST(performance_bonus_amount AS DOUBLE))
      comment: "Total performance bonus potential across all SOWs — measures upside revenue contingent on performance delivery."
    - name: "avg_contract_value_per_sow"
      expr: AVG(CAST(total_contract_value AS DOUBLE))
      comment: "Average total contract value per SOW — benchmarks deal size and informs commercial strategy for new engagements."
    - name: "active_sow_count"
      expr: COUNT(CASE WHEN sow_status = 'Active' THEN sow_id END)
      comment: "Number of currently active SOWs — baseline portfolio health metric for account management and revenue forecasting."
    - name: "expiring_sow_within_90_days_count"
      expr: COUNT(CASE WHEN effective_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN sow_id END)
      comment: "Number of SOWs expiring within 90 days — renewal urgency KPI for account management and revenue retention planning."
    - name: "distinct_brand_count"
      expr: COUNT(DISTINCT brand_id)
      comment: "Number of distinct brands covered by active SOWs — measures breadth of brand-level service commitments."
$$;