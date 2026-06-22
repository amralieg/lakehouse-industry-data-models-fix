-- Metric views for domain: client | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic client account KPIs covering portfolio value, credit exposure, pipeline health, and relationship quality — used by BD and finance leadership to steer client investment and risk decisions."
  source: "`vibe_construction_v1`.`client`.`account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of client account (e.g. Owner, Developer, Government) for portfolio segmentation."
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the account (Active, Inactive, Prospect) for pipeline health analysis."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier classification (Tier 1, 2, 3) used to prioritise BD investment and executive engagement."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client for market segment analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the client account for geographic revenue and risk analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating of the account for financial risk segmentation."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status indicating whether the client is eligible for new awards."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Client's preferred contract delivery model (Lump Sum, GMP, Cost-Plus) for commercial strategy."
    - name: "hse_compliance_required"
      expr: hse_compliance_required
      comment: "Flag indicating whether HSE compliance is mandated for this account, used in risk profiling."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Flag indicating whether LEED certification is required, used for sustainability pipeline analysis."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced, used for cohort and tenure analysis."
    - name: "last_project_award_year"
      expr: YEAR(last_project_award_date)
      comment: "Year of the most recent project award, used to identify dormant accounts."
  measures:
    - name: "total_accounts"
      expr: COUNT(1)
      comment: "Total number of client accounts in the portfolio — baseline measure for portfolio size tracking."
    - name: "active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN 1 END)
      comment: "Number of currently active client accounts — key indicator of live relationship portfolio health."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of annual revenue across all client accounts — proxy for total addressable client value in the portfolio."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account — used to benchmark account value and identify under-performing relationships."
    - name: "total_credit_limit_exposure"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all accounts — critical for treasury and credit risk management."
    - name: "avg_credit_limit"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per account — used to assess credit policy consistency across the portfolio."
    - name: "accounts_with_hse_requirement"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN 1 END)
      comment: "Number of accounts requiring HSE compliance — informs HSE resource planning and risk exposure."
    - name: "accounts_requiring_leed"
      expr: COUNT(CASE WHEN leed_certification_required = TRUE THEN 1 END)
      comment: "Number of accounts requiring LEED certification — drives sustainability capability investment decisions."
    - name: "accounts_prequalified"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of accounts with approved prequalification status — indicates the immediately awardable client base."
    - name: "prequalification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of accounts with approved prequalification — measures BD pipeline readiness."
    - name: "jv_entity_count"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN 1 END)
      comment: "Number of accounts flagged as JV entities — used to track joint-venture partnership exposure and governance obligations."
    - name: "do_not_contact_count"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN 1 END)
      comment: "Number of accounts marked do-not-contact — used to ensure BD outreach compliance and avoid regulatory breaches."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Business development pipeline KPIs covering opportunity value, win rates, bid conversion, and weighted pipeline — used by BD leadership and executives to steer pursuit strategy and resource allocation."
  source: "`vibe_construction_v1`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current stage of the opportunity (Prospect, Qualified, Bid, Won, Lost) for pipeline funnel analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Detailed pipeline stage for granular funnel tracking and conversion analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (Civil, Building, Infrastructure) for sector-level pipeline analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the opportunity for market segment performance tracking."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project will be executed — used for geographic pipeline and risk analysis."
    - name: "project_location_region"
      expr: project_location_region
      comment: "Region of the project for sub-national pipeline distribution analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Contract delivery model (EPC, D&B, CM) for commercial strategy analysis."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Bid/No-Bid decision outcome for pursuit efficiency and resource utilisation analysis."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final win/loss outcome for win-rate and competitive performance tracking."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Flag indicating whether the bid is a joint venture — used to track JV pursuit strategy."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity for executive portfolio steering."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the award is expected — used for pipeline timing and revenue forecasting."
    - name: "bid_submission_year"
      expr: YEAR(bid_submission_date)
      comment: "Year of bid submission for cohort-based win-rate analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the opportunity value for multi-currency portfolio analysis."
  measures:
    - name: "total_opportunities"
      expr: COUNT(1)
      comment: "Total number of opportunities in the BD pipeline — baseline measure for pipeline volume."
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all opportunities — primary measure of pipeline size for executive reporting."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values — the most decision-relevant pipeline measure for revenue forecasting."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity — used to assess deal size trends and target market positioning."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average win probability across the pipeline — indicates overall pipeline quality and BD confidence."
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of bidding across all opportunities — used to manage BD spend and bid/no-bid ROI."
    - name: "avg_bid_cost_estimate"
      expr: AVG(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Average bid cost per opportunity — benchmarks pursuit efficiency and cost-to-win ratios."
    - name: "won_opportunities"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END)
      comment: "Number of opportunities won — key BD performance indicator for executive scorecards."
    - name: "lost_opportunities"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN 1 END)
      comment: "Number of opportunities lost — used to analyse competitive performance and loss reasons."
    - name: "win_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN win_loss_outcome = 'Won' THEN 1 END) / NULLIF(COUNT(CASE WHEN win_loss_outcome IN ('Won','Lost') THEN 1 END), 0), 2)
      comment: "Win rate as a percentage of decided opportunities — the primary BD effectiveness KPI for executive review."
    - name: "won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN estimated_contract_value ELSE 0 END)
      comment: "Total contract value of won opportunities — measures revenue secured from BD activity."
    - name: "avg_project_duration_months"
      expr: AVG(CAST(project_duration_months AS DOUBLE))
      comment: "Average project duration in months across opportunities — used for resource planning and backlog forecasting."
    - name: "jv_bid_count"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN 1 END)
      comment: "Number of JV bid opportunities — tracks JV pursuit strategy execution against corporate targets."
    - name: "jv_bid_value"
      expr: SUM(CASE WHEN is_jv_bid = TRUE THEN estimated_contract_value ELSE 0 END)
      comment: "Total estimated value of JV bid opportunities — measures JV partnership pipeline contribution."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and financial exposure KPIs for the client portfolio — used by finance, treasury, and credit risk teams to manage credit limits, overdue balances, and sovereign risk."
  source: "`vibe_construction_v1`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (Active, Under Review, Suspended) for risk monitoring."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Internal credit rating for risk-tier segmentation of the client portfolio."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External agency credit rating for cross-validation of internal risk assessments."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Name of the external rating agency for source credibility analysis."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment classification for portfolio-level credit risk analysis."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Flag indicating whether the account is on credit hold — critical for accounts receivable and project award decisions."
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Flag indicating sovereign risk exposure — used for country-level credit risk management."
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Flag indicating whether credit insurance is in place — used to assess net risk exposure."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile for multi-currency risk aggregation."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "Frequency of credit reviews (Monthly, Quarterly, Annual) for governance compliance tracking."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the credit profile became effective — used for vintage analysis of credit decisions."
  measures:
    - name: "total_credit_profiles"
      expr: COUNT(1)
      comment: "Total number of active credit profiles — baseline measure for credit portfolio size."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END)
      comment: "Number of accounts currently on credit hold — critical risk indicator for revenue and project award decisions."
    - name: "credit_hold_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN credit_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of credit profiles on hold — measures portfolio-level credit stress for treasury reporting."
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all client profiles — primary measure of credit exposure for treasury management."
    - name: "total_current_exposure"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current financial exposure across all client profiles — key risk metric for credit committee reporting."
    - name: "total_overdue_balance"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue balance across all client profiles — critical collections and cash flow risk indicator."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across the client portfolio — measures collections efficiency and working capital impact."
    - name: "total_ld_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all client profiles — measures contractual penalty risk for executive risk reporting."
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance coverage in place — measures the insured portion of credit risk for net exposure calculation."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across client profiles — used to assess cash flow timing and retention release obligations."
    - name: "sovereign_risk_exposure_count"
      expr: COUNT(CASE WHEN sovereign_risk_flag = TRUE THEN 1 END)
      comment: "Number of client profiles with sovereign risk — used for country-level risk concentration analysis."
    - name: "avg_payment_history_rating"
      expr: AVG(CAST(payment_history_rating AS DOUBLE))
      comment: "Average payment history rating across the portfolio — leading indicator of future collections performance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement KPIs covering contract value, retention, satisfaction, and relationship health — used by project directors and client relationship managers to steer delivery performance and repeat business."
  source: "`vibe_construction_v1`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement (Active, Completed, Suspended) for portfolio health monitoring."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of engagement (Design, Construction, EPC, Advisory) for service line analysis."
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement (Owner, Developer, Funder) for relationship type analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the engagement for market performance analysis."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (Tender, Negotiated, Framework) for commercial strategy analysis."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier classification for strategic account management prioritisation."
    - name: "repeat_client"
      expr: repeat_client
      comment: "Flag indicating whether this is a repeat client — key metric for client retention strategy."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status for risk and legal exposure monitoring."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (Private, Government, PPP) for revenue quality analysis."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the engagement commenced — used for cohort analysis of client relationships."
    - name: "contract_currency"
      expr: contract_currency
      comment: "Currency of the contract for multi-currency revenue analysis."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Flag indicating LEED certification requirement — used for sustainability delivery tracking."
  measures:
    - name: "total_engagements"
      expr: COUNT(1)
      comment: "Total number of client project engagements — baseline measure for active client relationship portfolio."
    - name: "active_engagements"
      expr: COUNT(CASE WHEN engagement_status = 'Active' THEN 1 END)
      comment: "Number of currently active project engagements — primary measure of live delivery portfolio size."
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contracted value across all client engagements — primary revenue backlog measure for executive reporting."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per engagement — used to benchmark deal size and assess portfolio mix."
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total approved variation value across engagements — measures scope growth and commercial management effectiveness."
    - name: "variation_to_contract_ratio_pct"
      expr: ROUND(100.0 * SUM(CAST(approved_variation_value AS DOUBLE)) / NULLIF(SUM(CAST(contract_value AS DOUBLE)), 0), 2)
      comment: "Approved variations as a percentage of original contract value — key commercial risk and scope management KPI."
    - name: "total_advance_payment"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments received across engagements — used for cash flow and working capital management."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across engagements — primary client relationship health KPI for executive scorecards."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across engagements — measures cash flow timing risk from retention obligations."
    - name: "repeat_client_count"
      expr: COUNT(CASE WHEN repeat_client = TRUE THEN 1 END)
      comment: "Number of engagements with repeat clients — measures client loyalty and relationship stickiness."
    - name: "repeat_client_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN repeat_client = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagements from repeat clients — the primary client retention KPI for BD and executive review."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements — used to assess contractual penalty risk exposure in the portfolio."
    - name: "engagements_with_disputes"
      expr: COUNT(CASE WHEN dispute_status IS NOT NULL AND dispute_status != 'None' THEN 1 END)
      comment: "Number of engagements with active disputes — critical legal and commercial risk indicator for executive oversight."
    - name: "avg_jv_participation_pct"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average JV participation percentage across JV engagements — used to assess revenue share and risk allocation in JV projects."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client satisfaction and relationship health KPIs derived from post-project surveys — used by client relationship managers and executives to track NPS trends, satisfaction drivers, and escalation risk."
  source: "`vibe_construction_v1`.`client`.`survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Type of survey (Post-Project, Mid-Project, Annual Relationship) for benchmarking by survey category."
    - name: "survey_status"
      expr: survey_status
      comment: "Current status of the survey (Sent, Completed, Overdue) for response rate tracking."
    - name: "nps_category"
      expr: nps_category
      comment: "NPS category (Promoter, Passive, Detractor) for loyalty segmentation and advocacy analysis."
    - name: "client_sector"
      expr: client_sector
      comment: "Client sector for satisfaction benchmarking across industry verticals."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type for satisfaction analysis by delivery model."
    - name: "relationship_risk_level"
      expr: relationship_risk_level
      comment: "Relationship risk level (Low, Medium, High, Critical) for proactive account management prioritisation."
    - name: "escalation_required_flag"
      expr: escalation_required_flag
      comment: "Flag indicating whether escalation is required — used to trigger executive intervention for at-risk relationships."
    - name: "repeat_client_flag"
      expr: repeat_client_flag
      comment: "Flag indicating repeat client — used to compare satisfaction between new and returning clients."
    - name: "channel"
      expr: channel
      comment: "Survey delivery channel (Email, Phone, In-Person) for response quality analysis."
    - name: "response_year"
      expr: YEAR(response_date)
      comment: "Year of survey response — used for year-over-year satisfaction trend analysis."
    - name: "project_milestone"
      expr: project_milestone
      comment: "Project milestone at which the survey was administered — used to track satisfaction at key delivery gates."
  measures:
    - name: "total_surveys"
      expr: COUNT(1)
      comment: "Total number of surveys issued — baseline measure for client feedback programme coverage."
    - name: "completed_surveys"
      expr: COUNT(CASE WHEN survey_status = 'Completed' THEN 1 END)
      comment: "Number of completed surveys — measures client engagement with the feedback programme."
    - name: "survey_response_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN survey_status = 'Completed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Survey response rate as a percentage — measures effectiveness of the client feedback programme."
    - name: "avg_overall_satisfaction_score"
      expr: AVG(CAST(overall_satisfaction_score AS DOUBLE))
      comment: "Average overall client satisfaction score — the primary client experience KPI for executive and board reporting."
    - name: "avg_quality_score"
      expr: AVG(CAST(quality_score AS DOUBLE))
      comment: "Average quality satisfaction score — measures client perception of construction quality delivery."
    - name: "avg_schedule_score"
      expr: AVG(CAST(schedule_score AS DOUBLE))
      comment: "Average schedule satisfaction score — measures client perception of on-time delivery performance."
    - name: "avg_safety_score"
      expr: AVG(CAST(safety_score AS DOUBLE))
      comment: "Average safety satisfaction score — measures client perception of HSE performance on their projects."
    - name: "avg_cost_management_score"
      expr: AVG(CAST(cost_management_score AS DOUBLE))
      comment: "Average cost management satisfaction score — measures client perception of commercial management effectiveness."
    - name: "avg_communication_score"
      expr: AVG(CAST(communication_score AS DOUBLE))
      comment: "Average communication satisfaction score — measures client perception of project communication quality."
    - name: "avg_relationship_health_score"
      expr: AVG(CAST(relationship_health_score AS DOUBLE))
      comment: "Average relationship health score — composite indicator of overall client relationship strength for account management."
    - name: "avg_innovation_score"
      expr: AVG(CAST(innovation_score AS DOUBLE))
      comment: "Average innovation satisfaction score — measures client perception of value-add and innovation delivery."
    - name: "escalation_required_count"
      expr: COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END)
      comment: "Number of surveys requiring escalation — critical early-warning indicator for at-risk client relationships."
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(CASE WHEN survey_status = 'Completed' THEN 1 END), 0), 2)
      comment: "Percentage of completed surveys requiring escalation — measures the proportion of dissatisfied clients needing executive intervention."
    - name: "promoter_count"
      expr: COUNT(CASE WHEN nps_category = 'Promoter' THEN 1 END)
      comment: "Number of NPS Promoters — measures the base of highly satisfied clients likely to provide referrals and repeat business."
    - name: "detractor_count"
      expr: COUNT(CASE WHEN nps_category = 'Detractor' THEN 1 END)
      comment: "Number of NPS Detractors — measures the base of dissatisfied clients at risk of churn and negative advocacy."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP pipeline and bid opportunity KPIs — used by BD and tendering leadership to track pipeline value, bid requirements, and submission timelines for pursuit prioritisation."
  source: "`vibe_construction_v1`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (Issued, Closed, Awarded, Cancelled) for pipeline stage analysis."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (Open Tender, Selective Tender, Negotiated) for procurement route analysis."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project for market segment pipeline analysis."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type (Lump Sum, GMP, Cost-Plus) for commercial strategy analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model (EPC, D&B, CM) for capability and resource planning."
    - name: "country_code"
      expr: country_code
      comment: "Country of the RFP for geographic pipeline analysis."
    - name: "bim_required"
      expr: bim_required
      comment: "Flag indicating BIM requirement — used to assess digital delivery capability demand."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Flag indicating LEED certification requirement — used for sustainability pipeline tracking."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Flag indicating performance bond requirement — used for bonding capacity planning."
    - name: "bid_bond_required"
      expr: bid_bond_required
      comment: "Flag indicating bid bond requirement — used for bonding capacity and cash flow planning."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued — used for year-over-year pipeline volume analysis."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "Required LEED certification level for sustainability capability demand analysis."
  measures:
    - name: "total_rfps"
      expr: COUNT(1)
      comment: "Total number of RFPs issued — baseline measure for market opportunity volume."
    - name: "total_estimated_rfp_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all RFPs — primary measure of addressable market pipeline for BD strategy."
    - name: "avg_estimated_rfp_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP — used to assess deal size trends and target market positioning."
    - name: "rfps_requiring_bim"
      expr: COUNT(CASE WHEN bim_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring BIM — measures digital delivery capability demand in the market."
    - name: "bim_requirement_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bim_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of RFPs requiring BIM — tracks market adoption of digital delivery requirements."
    - name: "rfps_requiring_leed"
      expr: COUNT(CASE WHEN leed_certification_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring LEED certification — measures sustainability delivery demand in the market."
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average technical score weighting across RFPs — indicates market preference for technical vs commercial evaluation."
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average commercial score weighting across RFPs — used to calibrate bid pricing strategy."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage — used to assess local subcontracting and workforce obligations."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across RFPs — used to assess contractual risk levels in the pipeline."
    - name: "rfps_with_performance_bond"
      expr: COUNT(CASE WHEN performance_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a performance bond — used for bonding capacity and surety planning."
    - name: "rfps_with_bid_bond"
      expr: COUNT(CASE WHEN bid_bond_required = TRUE THEN 1 END)
      comment: "Number of RFPs requiring a bid bond — used for bid cost and bonding capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_prequalification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client prequalification pipeline KPIs — used by BD and procurement leadership to track prequalification approval rates, scoring, and eligibility for new project awards."
  source: "`vibe_construction_v1`.`client`.`client_prequalification`"
  dimensions:
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status (Approved, Pending, Rejected, Expired) for pipeline eligibility analysis."
    - name: "work_category"
      expr: work_category
      comment: "Category of work for which prequalification applies — used for capability and capacity planning."
    - name: "procurement_category"
      expr: procurement_category
      comment: "Procurement category for prequalification scope analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the prequalification for geographic eligibility analysis."
    - name: "hse_certification_required"
      expr: hse_certification_required
      comment: "Flag indicating HSE certification requirement — used to track compliance obligations."
    - name: "quality_certification_required"
      expr: quality_certification_required
      comment: "Flag indicating quality certification requirement — used to track ISO/quality compliance obligations."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Flag indicating LEED certification requirement — used for sustainability capability tracking."
    - name: "rfp_eligibility_flag"
      expr: rfp_eligibility_flag
      comment: "Flag indicating RFP eligibility — measures the proportion of clients eligible for new tender invitations."
    - name: "renewal_required"
      expr: renewal_required
      comment: "Flag indicating renewal is required — used to manage prequalification expiry and pipeline continuity."
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of prequalification submission — used for cohort analysis of approval rates."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year of prequalification expiry — used for renewal pipeline management."
  measures:
    - name: "total_prequalifications"
      expr: COUNT(1)
      comment: "Total number of client prequalifications — baseline measure for prequalification programme volume."
    - name: "approved_prequalifications"
      expr: COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END)
      comment: "Number of approved prequalifications — measures the size of the immediately awardable client base."
    - name: "approval_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN prequalification_status = 'Approved' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Prequalification approval rate — measures the quality of the client pipeline entering the BD process."
    - name: "avg_prequalification_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average prequalification score — used to benchmark client capability levels and set minimum thresholds."
    - name: "avg_minimum_passing_score"
      expr: AVG(CAST(minimum_passing_score AS DOUBLE))
      comment: "Average minimum passing score threshold — used to assess the rigour of prequalification standards."
    - name: "avg_max_project_value"
      expr: AVG(CAST(max_project_value AS DOUBLE))
      comment: "Average maximum project value clients are prequalified for — measures the capacity ceiling of the approved client base."
    - name: "avg_submitted_trir"
      expr: AVG(CAST(submitted_trir AS DOUBLE))
      comment: "Average Total Recordable Incident Rate submitted by clients — measures HSE performance of the prequalified client base."
    - name: "rfp_eligible_count"
      expr: COUNT(CASE WHEN rfp_eligibility_flag = TRUE THEN 1 END)
      comment: "Number of prequalifications with RFP eligibility — measures the immediately tender-ready client pipeline."
    - name: "rfp_eligibility_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN rfp_eligibility_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of prequalifications with RFP eligibility — key BD pipeline readiness indicator."
    - name: "renewals_required_count"
      expr: COUNT(CASE WHEN renewal_required = TRUE THEN 1 END)
      comment: "Number of prequalifications requiring renewal — used to manage pipeline continuity and avoid eligibility gaps."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_account_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client account hierarchy and ownership structure KPIs — used by BD, legal, and finance leadership to understand group-level exposure, JV structures, and consolidation obligations."
  source: "`vibe_construction_v1`.`client`.`account_hierarchy`"
  dimensions:
    - name: "hierarchy_status"
      expr: hierarchy_status
      comment: "Current status of the hierarchy relationship (Active, Dissolved, Restructured) for portfolio governance."
    - name: "arrangement_type"
      expr: arrangement_type
      comment: "Type of ownership arrangement (Subsidiary, JV, Associate) for legal and financial consolidation analysis."
    - name: "relationship_type"
      expr: relationship_type
      comment: "Nature of the relationship (Parent-Child, JV Partner, Affiliate) for group structure analysis."
    - name: "consolidation_method"
      expr: consolidation_method
      comment: "Consolidation method (Full, Proportional, Equity) for financial reporting compliance."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the corporate hierarchy — used to identify ultimate parent vs subsidiary relationships."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hierarchy relationship for regional exposure analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the hierarchy relationship for cross-border ownership and regulatory analysis."
    - name: "is_primary_hierarchy"
      expr: is_primary_hierarchy
      comment: "Flag indicating the primary hierarchy path — used to avoid double-counting in group consolidation."
    - name: "lead_partner_flag"
      expr: lead_partner_flag
      comment: "Flag indicating the lead partner in a JV structure — used for governance and accountability tracking."
    - name: "effective_from_year"
      expr: YEAR(effective_from_date)
      comment: "Year the hierarchy relationship became effective — used for structural change analysis."
  measures:
    - name: "total_hierarchy_relationships"
      expr: COUNT(1)
      comment: "Total number of account hierarchy relationships — baseline measure for corporate structure complexity."
    - name: "active_relationships"
      expr: COUNT(CASE WHEN hierarchy_status = 'Active' THEN 1 END)
      comment: "Number of currently active hierarchy relationships — measures live corporate structure complexity."
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage across hierarchy relationships — used to assess consolidation thresholds and control analysis."
    - name: "avg_voting_rights_percentage"
      expr: AVG(CAST(voting_rights_percentage AS DOUBLE))
      comment: "Average voting rights percentage — used to assess governance control and board representation obligations."
    - name: "jv_relationships_count"
      expr: COUNT(CASE WHEN arrangement_type = 'JV' THEN 1 END)
      comment: "Number of JV hierarchy relationships — measures JV partnership complexity and governance obligations."
    - name: "lead_partner_count"
      expr: COUNT(CASE WHEN lead_partner_flag = TRUE THEN 1 END)
      comment: "Number of relationships where the firm is lead partner — measures leadership position in JV structures."
    - name: "dissolved_relationships"
      expr: COUNT(CASE WHEN hierarchy_status = 'Dissolved' THEN 1 END)
      comment: "Number of dissolved hierarchy relationships — used to track corporate restructuring activity and historical exposure."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`client_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client framework agreement KPIs covering committed value, ceiling utilisation, and commercial terms — used by BD and commercial leadership to manage long-term client relationships and framework performance."
  source: "`vibe_construction_v1`.`client`.`client_framework_agreement`"
  dimensions:
    - name: "client_framework_agreement_status"
      expr: client_framework_agreement_status
      comment: "Current status of the framework agreement (Active, Expired, Terminated) for portfolio management."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (Master Services, Call-Off, Panel) for commercial strategy analysis."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the framework for market segment performance analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the framework for regional revenue analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model under the framework for capability planning."
    - name: "procurement_route"
      expr: procurement_route
      comment: "Procurement route used to establish the framework for commercial benchmarking."
    - name: "insurance_required"
      expr: insurance_required
      comment: "Flag indicating insurance requirement — used for compliance and risk management."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Flag indicating performance bond requirement — used for bonding capacity planning."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the framework became effective — used for vintage analysis of framework agreements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the framework agreement for multi-currency revenue analysis."
  measures:
    - name: "total_framework_agreements"
      expr: COUNT(1)
      comment: "Total number of client framework agreements — baseline measure for long-term relationship portfolio size."
    - name: "active_framework_agreements"
      expr: COUNT(CASE WHEN client_framework_agreement_status = 'Active' THEN 1 END)
      comment: "Number of active framework agreements — measures the live long-term client relationship portfolio."
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Total ceiling value across all framework agreements — measures the maximum addressable revenue from framework relationships."
    - name: "total_committed_value"
      expr: SUM(CAST(committed_value AS DOUBLE))
      comment: "Total committed value across all framework agreements — measures revenue already secured under frameworks."
    - name: "framework_utilisation_pct"
      expr: ROUND(100.0 * SUM(CAST(committed_value AS DOUBLE)) / NULLIF(SUM(CAST(ceiling_value AS DOUBLE)), 0), 2)
      comment: "Framework utilisation rate — measures how much of the available framework ceiling has been committed, a key commercial performance KPI."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across framework agreements — used to assess cash flow timing obligations."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across frameworks — used to assess contractual risk exposure in long-term relationships."
    - name: "avg_duration_months"
      expr: AVG(CAST(duration_months AS DOUBLE))
      comment: "Average framework duration in months — used for relationship longevity analysis and renewal planning."
    - name: "avg_max_calloff_value"
      expr: AVG(CAST(max_calloff_value AS DOUBLE))
      comment: "Average maximum call-off value per framework — used to assess individual project size limits under frameworks."
    - name: "frameworks_expiring_within_year"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 365) THEN 1 END)
      comment: "Number of framework agreements expiring within the next 12 months — critical renewal pipeline indicator for BD planning."
$$;