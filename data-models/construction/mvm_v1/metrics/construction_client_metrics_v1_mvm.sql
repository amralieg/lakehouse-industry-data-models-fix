-- Metric views for domain: client | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic client account metrics covering portfolio health, credit exposure, revenue potential, and relationship quality. Used by BD, Finance, and Executive leadership to steer client strategy and risk management."
  source: "`construction_ecm`.`client`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current lifecycle status of the client account (e.g. Active, Inactive, Suspended) — primary filter for portfolio health analysis."
    - name: "account_type"
      expr: account_type
      comment: "Classification of the account (e.g. Owner, Developer, Government, Contractor) — drives segmentation of revenue and pipeline."
    - name: "client_tier"
      expr: client_tier
      comment: "Strategic tier assigned to the client (e.g. Tier 1, Tier 2, Tier 3) — used to prioritise BD investment and relationship management."
    - name: "industry_sector"
      expr: industry_sector
      comment: "Industry sector of the client (e.g. Infrastructure, Energy, Commercial) — enables sector-level portfolio analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the client account — supports geographic revenue and risk distribution analysis."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating assigned to the client — used to segment accounts by financial risk profile."
    - name: "prequalification_status"
      expr: prequalification_status
      comment: "Current prequalification status of the client — determines eligibility to bid on projects."
    - name: "preferred_contract_type"
      expr: preferred_contract_type
      comment: "Client's preferred contract type (e.g. Lump Sum, Reimbursable, Alliance) — informs commercial strategy."
    - name: "payment_terms"
      expr: payment_terms
      comment: "Standard payment terms agreed with the client — used in cash flow and working capital analysis."
    - name: "hse_compliance_required"
      expr: hse_compliance_required
      comment: "Flag indicating whether HSE compliance is mandated for this client — used in risk and compliance reporting."
    - name: "is_jv_entity"
      expr: is_jv_entity
      comment: "Indicates whether the account represents a joint venture entity — used to segment JV vs direct client portfolio."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the client relationship commenced — used to analyse client tenure cohorts and loyalty."
    - name: "last_project_award_year"
      expr: YEAR(last_project_award_date)
      comment: "Year of the most recent project award from this client — used to identify dormant vs active clients."
  measures:
    - name: "total_active_accounts"
      expr: COUNT(CASE WHEN account_status = 'Active' THEN account_id END)
      comment: "Total number of active client accounts. Baseline KPI for portfolio size — executives use this to track client base growth and churn."
    - name: "total_annual_revenue"
      expr: SUM(CAST(annual_revenue AS DOUBLE))
      comment: "Sum of declared annual revenue across all client accounts. Proxy for total addressable market value of the client portfolio — used in strategic planning and tier assignment."
    - name: "avg_annual_revenue_per_account"
      expr: AVG(CAST(annual_revenue AS DOUBLE))
      comment: "Average annual revenue per client account. Used to benchmark account value and identify under-monetised relationships relative to client size."
    - name: "total_credit_limit"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit extended across all client accounts. Key risk exposure metric monitored by Finance and Credit Risk teams."
    - name: "avg_credit_limit_per_account"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per client account. Used to assess whether credit policy is consistently applied across the portfolio."
    - name: "accounts_with_prequalification_active"
      expr: COUNT(CASE WHEN prequalification_status = 'Active' THEN account_id END)
      comment: "Number of client accounts with an active prequalification status. Directly determines the pool of clients eligible to receive RFPs — a leading indicator of pipeline capacity."
    - name: "accounts_prequalification_expiring_90d"
      expr: COUNT(CASE WHEN prequalification_expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN account_id END)
      comment: "Number of client accounts whose prequalification expires within 90 days. Operational risk metric — expired prequalifications block RFP issuance and must be renewed proactively."
    - name: "accounts_on_do_not_contact"
      expr: COUNT(CASE WHEN do_not_contact = TRUE THEN account_id END)
      comment: "Number of accounts flagged as Do Not Contact. Compliance and BD risk metric — high counts indicate relationship deterioration or legal constraints."
    - name: "accounts_requiring_hse_compliance"
      expr: COUNT(CASE WHEN hse_compliance_required = TRUE THEN account_id END)
      comment: "Number of client accounts requiring HSE compliance. Used by HSE and project delivery teams to size compliance overhead and resource requirements."
    - name: "jv_entity_account_count"
      expr: COUNT(CASE WHEN is_jv_entity = TRUE THEN account_id END)
      comment: "Number of accounts that are joint venture entities. Used by BD and Legal to track JV partnership exposure and governance obligations."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pipeline and win/loss metrics for client opportunities. Core BD and commercial performance view used by executives to manage revenue pipeline, conversion rates, and strategic win rates."
  source: "`construction_ecm`.`client`.`client_opportunity`"
  dimensions:
    - name: "opportunity_status"
      expr: opportunity_status
      comment: "Current status of the opportunity (e.g. Open, Won, Lost, Withdrawn) — primary dimension for pipeline stage analysis."
    - name: "pipeline_stage"
      expr: pipeline_stage
      comment: "Stage in the BD pipeline (e.g. Identify, Qualify, Propose, Negotiate) — used to analyse pipeline velocity and conversion."
    - name: "win_loss_outcome"
      expr: win_loss_outcome
      comment: "Final outcome of the opportunity (Won / Lost / No Bid) — primary dimension for win rate and loss analysis."
    - name: "sector"
      expr: sector
      comment: "Market sector of the opportunity (e.g. Infrastructure, Energy, Commercial) — enables sector-level pipeline and win rate analysis."
    - name: "project_type"
      expr: project_type
      comment: "Type of construction project (e.g. Highway, Bridge, Power Plant) — used to analyse win rates and pipeline value by project type."
    - name: "project_location_country"
      expr: project_location_country
      comment: "Country where the project is located — supports geographic pipeline distribution analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model for the opportunity (e.g. EPC, D&B, Alliance) — used to analyse commercial performance by contract structure."
    - name: "bid_no_bid_decision"
      expr: bid_no_bid_decision
      comment: "Decision to bid or not bid on the opportunity — used to analyse bid selectivity and resource allocation."
    - name: "strategic_priority"
      expr: strategic_priority
      comment: "Strategic priority classification of the opportunity — used to ensure pipeline investment aligns with corporate strategy."
    - name: "is_jv_bid"
      expr: is_jv_bid
      comment: "Indicates whether the bid is a joint venture — used to analyse JV vs solo bid performance and win rates."
    - name: "expected_award_year"
      expr: YEAR(expected_award_date)
      comment: "Year the award is expected — used for pipeline timing and revenue forecasting."
    - name: "bid_submission_year"
      expr: YEAR(bid_submission_date)
      comment: "Year the bid was submitted — used to analyse bid volume trends over time."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for losing the opportunity — used in win/loss analysis to identify systemic commercial weaknesses."
  measures:
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value of all opportunities in the pipeline. Primary revenue pipeline KPI used by executives to assess forward revenue potential."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_pipeline_value AS DOUBLE))
      comment: "Sum of probability-weighted pipeline values. Risk-adjusted revenue forecast used in financial planning and resource allocation decisions."
    - name: "avg_opportunity_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity. Used to track deal size trends and assess whether the business is targeting appropriately sized projects."
    - name: "total_bid_cost_estimate"
      expr: SUM(CAST(bid_cost_estimate AS DOUBLE))
      comment: "Total estimated cost of bidding across all opportunities. Used by Finance and BD to manage bid budget and assess cost-of-sales efficiency."
    - name: "avg_probability_of_win_pct"
      expr: AVG(CAST(probability_of_win_pct AS DOUBLE))
      comment: "Average probability of win across active opportunities. Leading indicator of pipeline quality — declining averages signal deteriorating competitiveness."
    - name: "won_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Won' THEN client_opportunity_id END)
      comment: "Number of opportunities won. Numerator for win rate calculation — used to track BD conversion performance."
    - name: "lost_opportunity_count"
      expr: COUNT(CASE WHEN win_loss_outcome = 'Lost' THEN client_opportunity_id END)
      comment: "Number of opportunities lost. Used alongside won count to compute win rate and identify loss patterns by sector, type, or competitor."
    - name: "total_won_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Won' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of won opportunities. Direct measure of BD-generated revenue — core KPI for commercial performance reviews."
    - name: "total_lost_contract_value"
      expr: SUM(CASE WHEN win_loss_outcome = 'Lost' THEN CAST(estimated_contract_value AS DOUBLE) ELSE 0 END)
      comment: "Total contract value of lost opportunities. Measures revenue foregone — used to quantify the cost of losing and prioritise win-rate improvement initiatives."
    - name: "jv_bid_opportunity_count"
      expr: COUNT(CASE WHEN is_jv_bid = TRUE THEN client_opportunity_id END)
      comment: "Number of opportunities pursued as joint ventures. Used to track JV strategy execution and assess JV vs solo bid performance."
    - name: "opportunities_past_expected_award"
      expr: COUNT(CASE WHEN expected_award_date < CURRENT_DATE AND opportunity_status NOT IN ('Won', 'Lost', 'Withdrawn') THEN client_opportunity_id END)
      comment: "Number of open opportunities where the expected award date has passed. Operational risk metric — stale pipeline inflates forecasts and requires BD intervention."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_account_credit_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit risk and exposure metrics for client credit profiles. Used by Finance, Credit Risk, and CFO to monitor portfolio credit health, overdue balances, and insurance coverage."
  source: "`construction_ecm`.`client`.`account_credit_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the credit profile (e.g. Active, Expired, Under Review) — primary filter for active credit risk monitoring."
    - name: "client_segment"
      expr: client_segment
      comment: "Client segment assigned in the credit profile — used to analyse credit risk concentration by segment."
    - name: "internal_credit_score"
      expr: internal_credit_score
      comment: "Internal credit score band assigned to the client — primary risk classification dimension."
    - name: "external_credit_rating"
      expr: external_credit_rating
      comment: "External credit rating from a rating agency — used alongside internal score for dual-validation risk analysis."
    - name: "external_rating_agency"
      expr: external_rating_agency
      comment: "Name of the external rating agency — used to assess consistency across rating sources."
    - name: "payment_history_rating"
      expr: payment_history_rating
      comment: "Historical payment behaviour rating — leading indicator of future default risk."
    - name: "credit_hold_flag"
      expr: credit_hold_flag
      comment: "Indicates whether the client is currently on credit hold — critical operational flag that blocks new contract execution."
    - name: "credit_insurance_flag"
      expr: credit_insurance_flag
      comment: "Indicates whether credit insurance is in place — used to assess net vs gross credit exposure."
    - name: "sovereign_risk_flag"
      expr: sovereign_risk_flag
      comment: "Indicates whether the client carries sovereign risk — used for country-level credit risk concentration analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the credit profile — used for FX-adjusted exposure analysis."
    - name: "credit_review_frequency"
      expr: credit_review_frequency
      comment: "Frequency at which the credit profile is reviewed — used to ensure high-risk clients are reviewed more frequently."
  measures:
    - name: "total_credit_limit_amount"
      expr: SUM(CAST(credit_limit_amount AS DOUBLE))
      comment: "Total credit limit extended across all active credit profiles. Primary measure of total credit exposure — monitored by CFO and Credit Risk committee."
    - name: "total_current_exposure_amount"
      expr: SUM(CAST(current_exposure_amount AS DOUBLE))
      comment: "Total current credit exposure across all client profiles. Measures actual outstanding risk vs approved limits — key input to credit risk reporting."
    - name: "total_overdue_balance_amount"
      expr: SUM(CAST(overdue_balance_amount AS DOUBLE))
      comment: "Total overdue balance across all client credit profiles. Direct measure of collections risk — triggers escalation and provisioning decisions."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_exposure_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across client profiles. Quantifies contractual penalty risk — used in legal and financial risk reviews."
    - name: "total_credit_insurance_limit"
      expr: SUM(CAST(credit_insurance_limit_amount AS DOUBLE))
      comment: "Total credit insurance limit in place across insured client profiles. Measures the portion of credit exposure that is hedged — used to compute net uninsured exposure."
    - name: "avg_dso_days"
      expr: AVG(CAST(dso_days AS DOUBLE))
      comment: "Average Days Sales Outstanding across client credit profiles. Core working capital efficiency metric — rising DSO signals deteriorating collections performance."
    - name: "accounts_on_credit_hold"
      expr: COUNT(CASE WHEN credit_hold_flag = TRUE THEN account_credit_profile_id END)
      comment: "Number of client credit profiles currently on credit hold. Operational risk metric — clients on hold cannot receive new work orders, directly impacting revenue."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across client credit profiles. Used by Finance to forecast retention cash flows and assess commercial terms consistency."
    - name: "profiles_due_for_credit_review"
      expr: COUNT(CASE WHEN next_credit_review_date <= CURRENT_DATE AND profile_status = 'Active' THEN account_credit_profile_id END)
      comment: "Number of active credit profiles where the next review date has passed. Governance compliance metric — overdue reviews represent unmanaged credit risk."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_project_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Client project engagement performance metrics covering contract value, satisfaction, retention, and relationship health. Used by Delivery, Commercial, and Executive teams to manage client relationships and project commercial outcomes."
  source: "`construction_ecm`.`client`.`project_engagement`"
  dimensions:
    - name: "engagement_status"
      expr: engagement_status
      comment: "Current status of the project engagement (e.g. Active, Completed, Disputed) — primary filter for active portfolio analysis."
    - name: "engagement_type"
      expr: engagement_type
      comment: "Type of client engagement (e.g. EPC, PMC, Advisory) — used to segment commercial performance by delivery model."
    - name: "sector"
      expr: sector
      comment: "Industry sector of the engagement — enables sector-level performance and satisfaction analysis."
    - name: "client_role"
      expr: client_role
      comment: "Role of the client in the engagement (e.g. Owner, Developer, Funder) — used to understand relationship dynamics."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Tier of the client relationship for this engagement — used to prioritise account management effort."
    - name: "repeat_client"
      expr: repeat_client
      comment: "Indicates whether the client is a repeat client — key loyalty and retention dimension for BD strategy."
    - name: "procurement_method"
      expr: procurement_method
      comment: "Procurement method used (e.g. Competitive Tender, Negotiated, Framework) — used to analyse win rates and margin by procurement route."
    - name: "dispute_status"
      expr: dispute_status
      comment: "Current dispute status of the engagement — used to identify and escalate at-risk client relationships."
    - name: "funding_source"
      expr: funding_source
      comment: "Source of project funding (e.g. Government, Private, Multilateral) — used to assess payment risk and project stability."
    - name: "engagement_start_year"
      expr: YEAR(engagement_start_date)
      comment: "Year the engagement commenced — used for cohort analysis of client engagement performance over time."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Indicates whether LEED certification is required for this engagement — used to track ESG-driven project requirements."
  measures:
    - name: "total_contract_value"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Total contract value across all client project engagements. Primary revenue backlog metric — used by executives to track secured revenue and delivery pipeline."
    - name: "avg_contract_value"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value per engagement. Used to track deal size trends and assess whether the business is growing its average project scale."
    - name: "total_approved_variation_value"
      expr: SUM(CAST(approved_variation_value AS DOUBLE))
      comment: "Total value of approved contract variations. Measures scope growth and commercial management effectiveness — high variation values indicate scope management issues or opportunities."
    - name: "total_advance_payment_amount"
      expr: SUM(CAST(advance_payment_amount AS DOUBLE))
      comment: "Total advance payments received across engagements. Cash flow metric — advance payments improve working capital and reduce financing costs."
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(satisfaction_score AS DOUBLE))
      comment: "Average client satisfaction score across engagements. Leading indicator of repeat business and referral potential — declining scores trigger account management intervention."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across engagements. Used by Finance to forecast retention cash flows and assess commercial terms consistency across the portfolio."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across engagements. Risk metric — high LD rates increase delivery risk and potential financial penalties."
    - name: "repeat_client_engagement_count"
      expr: COUNT(CASE WHEN repeat_client = TRUE THEN project_engagement_id END)
      comment: "Number of engagements with repeat clients. Key loyalty metric — repeat client ratio directly measures client retention success and relationship quality."
    - name: "engagements_with_active_disputes"
      expr: COUNT(CASE WHEN dispute_status NOT IN ('None', 'Resolved', 'Closed') AND dispute_status IS NOT NULL THEN project_engagement_id END)
      comment: "Number of engagements with active disputes. Risk and relationship health metric — active disputes threaten revenue, reputation, and future pipeline."
    - name: "total_jv_participation_percentage"
      expr: AVG(CAST(jv_participation_percentage AS DOUBLE))
      comment: "Average JV participation percentage across joint venture engagements. Used to assess the company's equity stake and risk exposure in JV-delivered projects."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_framework_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Framework agreement portfolio metrics covering contracted value, utilisation, and commercial terms. Used by Commercial, Legal, and BD teams to manage long-term client agreements and identify renewal and extension opportunities."
  source: "`construction_ecm`.`client`.`framework_agreement`"
  dimensions:
    - name: "client_framework_agreement_status"
      expr: client_framework_agreement_status
      comment: "Current status of the framework agreement (e.g. Active, Expired, Terminated) — primary filter for active agreement portfolio."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of framework agreement (e.g. Master Services, Call-Off, Alliance) — used to segment commercial performance by agreement structure."
    - name: "sector"
      expr: sector
      comment: "Industry sector covered by the agreement — enables sector-level framework portfolio analysis."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model specified in the agreement — used to analyse commercial performance by contract structure."
    - name: "procurement_route"
      expr: procurement_route
      comment: "Procurement route used to establish the agreement — used to assess competitive vs negotiated agreement performance."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region covered by the agreement — supports regional portfolio and revenue analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country of the framework agreement — used for geographic risk and revenue distribution analysis."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective — used for cohort analysis of agreement performance and longevity."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the agreement expires — used to identify renewal pipeline and manage agreement lifecycle."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — used to assess financial commitment and risk profile of agreements."
  measures:
    - name: "total_ceiling_value"
      expr: SUM(CAST(ceiling_value AS DOUBLE))
      comment: "Total ceiling value across all framework agreements. Measures the maximum contracted revenue potential from framework agreements — key BD and commercial planning metric."
    - name: "total_committed_value"
      expr: SUM(CAST(committed_value AS DOUBLE))
      comment: "Total committed (called-off) value across framework agreements. Measures actual revenue secured under frameworks — used to track framework utilisation and revenue realisation."
    - name: "avg_ceiling_value"
      expr: AVG(CAST(ceiling_value AS DOUBLE))
      comment: "Average ceiling value per framework agreement. Used to benchmark agreement scale and assess whether frameworks are sized appropriately for client needs."
    - name: "total_max_calloff_value"
      expr: SUM(CAST(max_calloff_value AS DOUBLE))
      comment: "Total maximum call-off value across all framework agreements. Used to understand the upper bound of individual call-off revenue potential."
    - name: "avg_retention_percentage"
      expr: AVG(CAST(retention_percentage AS DOUBLE))
      comment: "Average retention percentage across framework agreements. Used by Finance to forecast retention cash flows and assess commercial terms consistency."
    - name: "avg_liquidated_damages_rate"
      expr: AVG(CAST(liquidated_damages_rate AS DOUBLE))
      comment: "Average liquidated damages rate across framework agreements. Risk metric — used to assess contractual penalty exposure across the framework portfolio."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN client_framework_agreement_status = 'Active' THEN framework_agreement_id END)
      comment: "Number of currently active framework agreements. Baseline portfolio metric — used to track the size of the active long-term client agreement base."
    - name: "agreements_expiring_90d"
      expr: COUNT(CASE WHEN expiry_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) AND client_framework_agreement_status = 'Active' THEN framework_agreement_id END)
      comment: "Number of active framework agreements expiring within 90 days. Renewal pipeline metric — triggers proactive commercial engagement to retain framework revenue."
    - name: "agreements_with_extension_options"
      expr: COUNT(CASE WHEN extension_options IS NOT NULL AND extension_options != '' THEN framework_agreement_id END)
      comment: "Number of framework agreements that include extension options. Used by BD to identify agreements where tenure can be extended without re-tendering — preserving revenue with lower BD cost."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_rfp_issuance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RFP issuance and tender pipeline metrics. Used by BD, Commercial, and Executive teams to monitor tender activity, pipeline value, and bid requirement complexity across client sectors."
  source: "`construction_ecm`.`client`.`rfp_issuance`"
  dimensions:
    - name: "rfp_status"
      expr: rfp_status
      comment: "Current status of the RFP (e.g. Issued, Closed, Awarded, Cancelled) — primary filter for active tender pipeline analysis."
    - name: "solicitation_type"
      expr: solicitation_type
      comment: "Type of solicitation (e.g. Open Tender, Selective Tender, Negotiated) — used to analyse bid selectivity and win rate by procurement route."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project being tendered — enables sector-level pipeline and win rate analysis."
    - name: "client_sector"
      expr: client_sector
      comment: "Sector classification of the issuing client — used to segment RFP activity by client industry."
    - name: "contract_type"
      expr: contract_type
      comment: "Contract type specified in the RFP (e.g. Lump Sum, Reimbursable, GMP) — used to analyse commercial risk profile of the tender pipeline."
    - name: "delivery_model"
      expr: delivery_model
      comment: "Delivery model required by the RFP — used to assess resource and capability requirements across the tender pipeline."
    - name: "country_code"
      expr: country_code
      comment: "Country where the tendered project is located — supports geographic pipeline distribution analysis."
    - name: "bim_required"
      expr: bim_required
      comment: "Indicates whether BIM is required — used to assess digital delivery capability demand across the tender pipeline."
    - name: "leed_certification_required"
      expr: leed_certification_required
      comment: "Indicates whether LEED certification is required — used to track ESG-driven tender requirements."
    - name: "performance_bond_required"
      expr: performance_bond_required
      comment: "Indicates whether a performance bond is required — used to assess financial commitment requirements across the tender pipeline."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year the RFP was issued — used to analyse tender volume and pipeline value trends over time."
  measures:
    - name: "total_estimated_contract_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all issued RFPs. Primary tender pipeline value metric — used by executives to assess the total revenue opportunity in the active tender market."
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per RFP. Used to track deal size trends in the tender market and assess whether the business is targeting appropriately scaled opportunities."
    - name: "total_active_rfp_count"
      expr: COUNT(CASE WHEN rfp_status NOT IN ('Closed', 'Cancelled', 'Awarded') THEN rfp_issuance_id END)
      comment: "Number of currently active RFPs. Baseline tender pipeline activity metric — used to track BD workload and pipeline velocity."
    - name: "avg_technical_score_weight"
      expr: AVG(CAST(technical_score_weight AS DOUBLE))
      comment: "Average technical score weighting across RFPs. Used to assess whether the tender market is shifting towards quality-based or price-based evaluation — informs bid strategy."
    - name: "avg_commercial_score_weight"
      expr: AVG(CAST(commercial_score_weight AS DOUBLE))
      comment: "Average commercial score weighting across RFPs. Paired with technical score weight to understand evaluation balance — high commercial weight signals price-competitive markets."
    - name: "avg_local_content_requirement_pct"
      expr: AVG(CAST(local_content_requirement_pct AS DOUBLE))
      comment: "Average local content requirement percentage across RFPs. Used by Supply Chain and BD to assess local sourcing obligations and their impact on bid competitiveness."
    - name: "avg_bid_bond_percentage"
      expr: AVG(CAST(bid_bond_percentage AS DOUBLE))
      comment: "Average bid bond percentage required across RFPs. Used by Finance to forecast bid bond facility utilisation and assess financial commitment requirements."
    - name: "rfps_with_liquidated_damages"
      expr: COUNT(CASE WHEN liquidated_damages_applicable = TRUE THEN rfp_issuance_id END)
      comment: "Number of RFPs that include liquidated damages clauses. Risk metric — high LD prevalence increases delivery risk and requires careful bid pricing and programme management."
    - name: "rfps_past_submission_deadline"
      expr: COUNT(CASE WHEN submission_deadline < CURRENT_TIMESTAMP AND rfp_status NOT IN ('Closed', 'Awarded', 'Cancelled') THEN rfp_issuance_id END)
      comment: "Number of RFPs where the submission deadline has passed but status has not been updated. Data quality and pipeline hygiene metric — stale RFPs distort pipeline value reporting."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`client_jv_structure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Joint venture structure metrics covering capital commitment, equity distribution, and JV portfolio health. Used by BD, Legal, and Finance to manage JV partnerships, governance obligations, and capital exposure."
  source: "`construction_ecm`.`client`.`jv_structure`"
  dimensions:
    - name: "jv_status"
      expr: jv_status
      comment: "Current status of the JV structure (e.g. Active, Dissolved, In Formation) — primary filter for active JV portfolio analysis."
    - name: "jv_type"
      expr: jv_type
      comment: "Type of joint venture (e.g. Incorporated, Unincorporated, Consortium) — used to segment governance and liability exposure."
    - name: "project_sector"
      expr: project_sector
      comment: "Sector of the project delivered by the JV — enables sector-level JV portfolio analysis."
    - name: "country_of_operation"
      expr: country_of_operation
      comment: "Country where the JV operates — used for geographic risk and regulatory compliance analysis."
    - name: "is_lead_sponsor_internal"
      expr: is_lead_sponsor_internal
      comment: "Indicates whether the internal entity is the lead sponsor — used to assess governance responsibility and risk exposure."
    - name: "liability_structure"
      expr: liability_structure
      comment: "Liability structure of the JV (e.g. Joint and Several, Several Only) — critical risk dimension for legal and financial exposure analysis."
    - name: "management_structure_type"
      expr: management_structure_type
      comment: "Management structure of the JV — used to assess operational control and governance complexity."
    - name: "profit_sharing_basis"
      expr: profit_sharing_basis
      comment: "Basis on which profits are shared among JV participants — used in financial modelling and partner relationship management."
    - name: "formation_year"
      expr: YEAR(formation_date)
      comment: "Year the JV was formed — used for cohort analysis of JV performance and longevity."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the JV is currently active — used as a quick filter for active JV portfolio reporting."
  measures:
    - name: "total_committed_capital"
      expr: SUM(CAST(total_committed_capital AS DOUBLE))
      comment: "Total capital committed across all JV structures. Primary financial exposure metric — used by Finance and Board to monitor total JV capital at risk."
    - name: "avg_committed_capital_per_jv"
      expr: AVG(CAST(total_committed_capital AS DOUBLE))
      comment: "Average capital committed per JV structure. Used to benchmark JV investment scale and assess whether capital is concentrated in a small number of large JVs."
    - name: "avg_total_equity_pct"
      expr: AVG(CAST(total_equity_pct AS DOUBLE))
      comment: "Average total equity percentage across JV structures. Used to assess the company's average ownership stake and associated governance rights and risk exposure."
    - name: "active_jv_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN jv_structure_id END)
      comment: "Number of currently active JV structures. Baseline portfolio metric — used to track the size and complexity of the active JV portfolio."
    - name: "lead_sponsor_jv_count"
      expr: COUNT(CASE WHEN is_lead_sponsor_internal = TRUE THEN jv_structure_id END)
      comment: "Number of JVs where the internal entity is the lead sponsor. Governance risk metric — lead sponsor JVs carry higher management responsibility and reputational exposure."
    - name: "jvs_approaching_dissolution"
      expr: COUNT(CASE WHEN dissolution_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 180) AND is_active = TRUE THEN jv_structure_id END)
      comment: "Number of active JVs with a dissolution date within 180 days. Operational planning metric — triggers wind-down planning, asset transfer, and partner settlement processes."
$$;