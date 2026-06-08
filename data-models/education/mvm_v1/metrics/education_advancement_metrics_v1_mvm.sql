-- Metric views for domain: advancement | Business: Education | Version: 1 | Generated on: 2026-05-06 15:08:33

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising performance metrics derived from individual gift transactions. Tracks total giving volume, donor engagement depth, and gift portfolio composition to steer fundraising strategy and campaign investment decisions."
  source: "`education_ecm`.`advancement`.`gift`"
  filter: gift_status NOT IN ('Voided', 'Reversed')
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Classification of the gift (e.g., Outright, Pledge Payment, Matching, In-Kind) for portfolio mix analysis."
    - name: "gift_source"
      expr: gift_source
      comment: "Channel or origin through which the gift was received (e.g., Direct Mail, Online, Major Gift Officer) to evaluate solicitation channel effectiveness."
    - name: "payment_method"
      expr: payment_method
      comment: "Method of payment used (e.g., Check, Credit Card, Stock, Wire) to understand donor payment preferences and processing costs."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted, unrestricted, or temporarily restricted, which drives fund deployment flexibility."
    - name: "gift_status"
      expr: gift_status
      comment: "Current processing status of the gift (e.g., Posted, Pending, Acknowledged) for pipeline and reconciliation tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the gift was received, relevant for international donor analysis."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift receipt for trend analysis and seasonal fundraising pattern identification."
    - name: "gift_date_fiscal_year"
      expr: YEAR(gift_date)
      comment: "Calendar year of gift date used as a proxy for fiscal year cohort analysis."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates whether the donor requested anonymity, relevant for recognition and stewardship planning."
    - name: "matching_gift_eligible_flag"
      expr: matching_gift_eligible_flag
      comment: "Flags gifts eligible for employer matching, enabling identification of unclaimed matching gift revenue."
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Indicates whether the gift must be reported under IPEDS federal reporting requirements."
    - name: "case_reportable_flag"
      expr: case_reportable_flag
      comment: "Indicates whether the gift is reportable under CASE (Council for Advancement and Support of Education) counting standards."
  measures:
    - name: "total_gift_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift revenue received in the gift's native currency. Primary fundraising performance KPI used in board decks and campaign progress reporting."
    - name: "total_gift_amount_usd"
      expr: SUM(CAST(amount_usd AS DOUBLE))
      comment: "Total gift revenue normalized to USD for cross-currency campaign and portfolio comparisons."
    - name: "total_tax_deductible_amount"
      expr: SUM(CAST(tax_deductible_amount AS DOUBLE))
      comment: "Total tax-deductible portion of gifts received, required for IRS compliance reporting and donor acknowledgment letters."
    - name: "total_gifts"
      expr: COUNT(1)
      comment: "Total number of gift transactions processed. Used to measure fundraising activity volume and donor participation rates."
    - name: "unique_donors"
      expr: COUNT(DISTINCT donor_id)
      comment: "Number of distinct donors who made at least one gift. Core metric for donor breadth and participation rate benchmarking."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size per transaction. Tracks donor generosity trends and informs ask-amount calibration for solicitation strategies."
    - name: "largest_gift_amount"
      expr: MAX(CAST(largest_gift_amount AS DOUBLE))
      comment: "Maximum single gift amount recorded on a gift record, representing the high-water mark for major gift performance tracking."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Aggregate lifetime giving totals across all gift records. Indicates cumulative donor investment in the institution."
    - name: "matching_gift_eligible_count"
      expr: COUNT(CASE WHEN matching_gift_eligible_flag = TRUE THEN 1 END)
      comment: "Number of gifts eligible for employer matching programs. Identifies uncaptured matching revenue opportunity."
    - name: "total_stock_shares"
      expr: SUM(CAST(stock_shares AS DOUBLE))
      comment: "Total number of stock shares donated. Tracks non-cash gift volume for investment office and gift acceptance policy monitoring."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic fundraising campaign performance metrics. Enables leadership to evaluate campaign ROI, goal attainment, and portfolio health across all active and completed campaigns."
  source: "`education_ecm`.`advancement`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Classification of the campaign (e.g., Annual Fund, Capital, Endowment, Comprehensive) for portfolio segmentation."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current lifecycle status of the campaign (e.g., Planning, Active, Quiet Phase, Closed) for pipeline management."
    - name: "phase"
      expr: phase
      comment: "Current phase of the campaign (e.g., Quiet, Public, Wrap-Up) to track campaign lifecycle progression."
    - name: "priority"
      expr: priority
      comment: "Strategic priority level assigned to the campaign, used to allocate staff and resources."
    - name: "visibility_status"
      expr: visibility_status
      comment: "Whether the campaign is publicly announced or in a quiet phase, relevant for communications and PR strategy."
    - name: "case_reporting_classification"
      expr: case_reporting_classification
      comment: "CASE reporting classification for the campaign, required for benchmarking against peer institutions."
    - name: "currency_code"
      expr: currency_code
      comment: "Primary currency of the campaign for multi-currency portfolio analysis."
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign launched, enabling cohort analysis of campaign performance by vintage."
    - name: "recognition_tier"
      expr: recognition_tier
      comment: "Donor recognition tier associated with the campaign, used to evaluate major gift pipeline alignment."
  measures:
    - name: "total_amount_raised"
      expr: SUM(CAST(amount_raised AS DOUBLE))
      comment: "Total funds raised across all campaigns. The primary KPI for fundraising performance reported to the board and president."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Aggregate campaign goal amounts. Used as the denominator for campaign goal attainment rate calculations."
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted fundraising investment across campaigns. Used to compute cost-to-raise ratios."
    - name: "total_quiet_phase_goal"
      expr: SUM(CAST(quiet_phase_goal_amount AS DOUBLE))
      comment: "Aggregate quiet phase goal amounts, tracking major gift pipeline commitments before public campaign launch."
    - name: "total_minimum_giving_threshold"
      expr: SUM(CAST(minimum_giving_threshold AS DOUBLE))
      comment: "Sum of minimum giving thresholds across campaigns, used to assess donor qualification criteria at portfolio level."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN campaign_status = 'Active' THEN 1 END)
      comment: "Number of currently active campaigns. Tracks organizational fundraising capacity and staff workload distribution."
    - name: "total_campaigns"
      expr: COUNT(1)
      comment: "Total number of campaigns in the portfolio. Baseline for campaign portfolio management and resource allocation."
    - name: "avg_goal_amount"
      expr: AVG(CAST(goal_amount AS DOUBLE))
      comment: "Average campaign goal size. Indicates the scale and ambition of fundraising initiatives over time."
    - name: "avg_amount_raised"
      expr: AVG(CAST(amount_raised AS DOUBLE))
      comment: "Average amount raised per campaign. Benchmarks campaign productivity and informs future goal-setting."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge receivables and fulfillment metrics. Tracks outstanding commitments, payment velocity, and write-off risk to support cash flow forecasting and donor stewardship prioritization."
  source: "`education_ecm`.`advancement`.`pledge`"
  filter: pledge_status NOT IN ('Voided', 'Cancelled')
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current fulfillment status of the pledge (e.g., Active, Fulfilled, Delinquent, Written Off) for receivables aging analysis."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge commitment (e.g., Standard, Conditional, Challenge) for portfolio segmentation."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Payment schedule frequency (e.g., Monthly, Quarterly, Annual) to forecast cash inflows."
    - name: "payment_method"
      expr: payment_method
      comment: "Donor's chosen payment method for installments, relevant for payment processing and default risk assessment."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pledge for multi-currency receivables reporting."
    - name: "matching_gift_eligible_flag"
      expr: matching_gift_eligible_flag
      comment: "Flags pledges eligible for employer matching, enabling proactive matching gift solicitation."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made, enabling vintage cohort analysis of pledge fulfillment rates."
    - name: "designation"
      expr: designation
      comment: "Fund or purpose designation for the pledge, used to track restricted vs. unrestricted commitment pipelines."
  measures:
    - name: "total_pledge_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total face value of all pledges. Represents the full fundraising commitment pipeline and is a key input to multi-year campaign projections."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total cash collected against pledges. Measures pledge fulfillment progress and actual cash received."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total uncollected pledge balance. Critical receivables metric for cash flow forecasting and delinquency management."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total amount written off from uncollectable pledges. Tracks credit risk and informs pledge acceptance policy decisions."
    - name: "total_tax_deductible_amount"
      expr: SUM(CAST(tax_deductible_amount AS DOUBLE))
      comment: "Tax-deductible portion of pledge payments, required for IRS substantiation and donor acknowledgment compliance."
    - name: "total_pledges"
      expr: COUNT(1)
      comment: "Total number of pledge records. Baseline for pledge portfolio size and donor commitment tracking."
    - name: "unique_pledging_donors"
      expr: COUNT(DISTINCT donor_id)
      comment: "Number of distinct donors with active pledges. Measures depth of multi-year donor commitment to the institution."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average pledge size. Benchmarks donor commitment levels and informs major gift threshold calibration."
    - name: "avg_next_installment_amount"
      expr: AVG(CAST(next_installment_amount AS DOUBLE))
      comment: "Average upcoming installment amount across active pledges. Used for near-term cash flow forecasting."
    - name: "delinquent_pledge_count"
      expr: COUNT(CASE WHEN pledge_status = 'Delinquent' THEN 1 END)
      comment: "Number of pledges in delinquent status. Triggers stewardship intervention and write-off risk assessment."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_major_gift_proposal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline and proposal performance metrics. Provides leadership visibility into the major gift funnel, weighted pipeline value, and proposal conversion rates to drive principal gift strategy."
  source: "`education_ecm`.`advancement`.`major_gift_proposal`"
  dimensions:
    - name: "proposal_stage"
      expr: proposal_stage
      comment: "Current stage of the proposal in the major gift pipeline (e.g., Identification, Cultivation, Solicitation, Stewardship) for funnel analysis."
    - name: "proposal_status"
      expr: proposal_status
      comment: "Current status of the proposal (e.g., Active, Funded, Declined, Withdrawn) for pipeline health monitoring."
    - name: "proposal_type"
      expr: proposal_type
      comment: "Type of major gift proposal (e.g., Endowment, Capital, Annual, Planned) for portfolio mix analysis."
    - name: "proposal_outcome"
      expr: proposal_outcome
      comment: "Final outcome of closed proposals (e.g., Funded, Declined, Redirected) for conversion rate benchmarking."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Intended purpose of the major gift (e.g., Scholarship, Chair, Building, Program) to align with institutional priorities."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the proposal ask amount for multi-currency pipeline reporting."
    - name: "board_approval_required_flag"
      expr: board_approval_required_flag
      comment: "Flags proposals requiring board approval, used to manage governance pipeline and approval timelines."
    - name: "gift_agreement_executed_flag"
      expr: gift_agreement_executed_flag
      comment: "Indicates whether a gift agreement has been executed, a key milestone in major gift closing process."
    - name: "confidential_flag"
      expr: confidential_flag
      comment: "Marks proposals that are confidential, relevant for access control and reporting segmentation."
    - name: "proposal_start_year"
      expr: YEAR(proposal_start_date)
      comment: "Year the proposal was initiated, enabling vintage cohort analysis of pipeline conversion timelines."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Donor recognition level associated with the proposal, used to track naming opportunity pipeline."
  measures:
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total face value of all major gift asks in the pipeline. The primary major gift pipeline KPI reported to the president and board."
    - name: "total_weighted_amount"
      expr: SUM(CAST(weighted_amount AS DOUBLE))
      comment: "Probability-weighted pipeline value across all proposals. Provides a risk-adjusted forecast of expected major gift revenue."
    - name: "total_committed_amount"
      expr: SUM(CAST(committed_amount AS DOUBLE))
      comment: "Total amount formally committed by donors. Represents secured major gift revenue not yet fully received."
    - name: "total_proposals"
      expr: COUNT(1)
      comment: "Total number of major gift proposals in the portfolio. Baseline for pipeline volume and gift officer productivity measurement."
    - name: "active_proposals"
      expr: COUNT(CASE WHEN proposal_status = 'Active' THEN 1 END)
      comment: "Number of currently active proposals. Tracks live pipeline size and gift officer workload."
    - name: "funded_proposals"
      expr: COUNT(CASE WHEN proposal_outcome = 'Funded' THEN 1 END)
      comment: "Number of proposals that resulted in a funded gift. Used as the numerator for proposal conversion rate analysis."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average major gift ask amount. Benchmarks gift officer portfolio calibration and informs ask strategy."
    - name: "avg_weighted_amount"
      expr: AVG(CAST(weighted_amount AS DOUBLE))
      comment: "Average probability-weighted proposal value. Indicates the quality and confidence level of the pipeline."
    - name: "unique_donors_in_pipeline"
      expr: COUNT(DISTINCT donor_id)
      comment: "Number of distinct donors with active major gift proposals. Measures breadth of major gift prospect engagement."
    - name: "proposals_with_gift_agreement"
      expr: COUNT(CASE WHEN gift_agreement_executed_flag = TRUE THEN 1 END)
      comment: "Number of proposals with executed gift agreements. Tracks legal commitment milestones in the major gift closing process."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_endowment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Endowment portfolio health and performance metrics. Enables investment committee and CFO to monitor endowment market value, spending distributions, underwater exposure, and NACUBO/IPEDS compliance."
  source: "`education_ecm`.`advancement`.`endowment`"
  filter: fund_status NOT IN ('Closed', 'Terminated')
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of endowment fund (e.g., True Endowment, Term Endowment, Quasi-Endowment) for regulatory and investment classification."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the endowment fund (e.g., Active, Pending, Suspended) for portfolio management."
    - name: "purpose_category"
      expr: purpose_category
      comment: "Broad purpose category of the endowment (e.g., Scholarship, Chair, Program, Research) for strategic alignment reporting."
    - name: "spending_policy_method"
      expr: spending_policy_method
      comment: "Method used to calculate annual spending distributions (e.g., Unitized, Hybrid, Total Return) for investment policy compliance."
    - name: "underwater_flag"
      expr: underwater_flag
      comment: "Indicates whether the endowment's market value has fallen below its historic gift value. Critical risk flag for investment committee."
    - name: "nacubo_reportable_flag"
      expr: nacubo_reportable_flag
      comment: "Flags endowments included in NACUBO annual endowment study reporting."
    - name: "ipeds_reportable_flag"
      expr: ipeds_reportable_flag
      comment: "Flags endowments subject to IPEDS federal reporting requirements."
    - name: "establishment_year"
      expr: YEAR(establishment_date)
      comment: "Year the endowment was established, enabling vintage cohort analysis of endowment growth and performance."
    - name: "stewardship_report_status"
      expr: stewardship_report_status
      comment: "Status of the annual stewardship report to the donor (e.g., Pending, Sent, Overdue) for compliance tracking."
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(market_value AS DOUBLE))
      comment: "Total endowment market value across all funds. The primary endowment portfolio KPI reported to the board investment committee."
    - name: "total_current_principal"
      expr: SUM(CAST(current_principal_amount AS DOUBLE))
      comment: "Total current principal balance across all endowment funds. Tracks the investable corpus of the endowment portfolio."
    - name: "total_original_principal"
      expr: SUM(CAST(original_principal_amount AS DOUBLE))
      comment: "Total original gift principal across all endowments. Used to compute cumulative investment growth and underwater exposure."
    - name: "total_annual_distribution"
      expr: SUM(CAST(annual_distribution_amount AS DOUBLE))
      comment: "Total annual spending distributions from endowment funds. Directly funds scholarships, chairs, and programs — a key budget planning input."
    - name: "total_ytd_distribution"
      expr: SUM(CAST(ytd_distribution_amount AS DOUBLE))
      comment: "Year-to-date distributions paid from endowment funds. Tracks in-year spending against annual distribution budgets."
    - name: "total_underwater_amount"
      expr: SUM(CAST(underwater_amount AS DOUBLE))
      comment: "Total dollar amount by which underwater endowments fall below their historic gift value. Quantifies investment risk exposure requiring board attention."
    - name: "total_endowment_funds"
      expr: COUNT(1)
      comment: "Total number of endowment funds under management. Baseline for portfolio scale and stewardship workload assessment."
    - name: "underwater_fund_count"
      expr: COUNT(CASE WHEN underwater_flag = TRUE THEN 1 END)
      comment: "Number of endowment funds currently underwater. Triggers investment committee review and spending suspension decisions."
    - name: "avg_market_value"
      expr: AVG(CAST(market_value AS DOUBLE))
      comment: "Average market value per endowment fund. Benchmarks fund size distribution and identifies outlier funds requiring special management."
    - name: "avg_spending_policy_rate"
      expr: AVG(CAST(spending_policy_rate AS DOUBLE))
      comment: "Average spending policy rate across endowment funds. Monitors compliance with board-approved spending policy parameters."
    - name: "total_units_held"
      expr: SUM(CAST(units_held AS DOUBLE))
      comment: "Total unitized pool units held across all endowment funds. Used in unitized pool performance attribution and distribution calculations."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_donor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor portfolio and relationship health metrics. Enables advancement leadership to monitor donor pipeline quality, giving capacity, consecutive giving loyalty, and stewardship tier distribution."
  source: "`education_ecm`.`advancement`.`donor`"
  filter: deceased_flag = FALSE AND do_not_contact_flag = FALSE
  dimensions:
    - name: "donor_type"
      expr: donor_type
      comment: "Classification of the donor (e.g., Individual, Corporation, Foundation, Estate) for portfolio segmentation and solicitation strategy."
    - name: "donor_status"
      expr: donor_status
      comment: "Current giving status of the donor (e.g., Active, Lapsed, Prospect, Deceased) for retention and reactivation analysis."
    - name: "stewardship_tier"
      expr: stewardship_tier
      comment: "Assigned stewardship tier (e.g., Platinum, Gold, Silver) reflecting cumulative giving level and relationship depth."
    - name: "giving_capacity_rating"
      expr: giving_capacity_rating
      comment: "Wealth screening-derived capacity rating for the donor, used to prioritize major gift cultivation and portfolio assignments."
    - name: "constituent_classification"
      expr: constituent_classification
      comment: "Broad classification of the donor's relationship to the institution (e.g., Alumni, Parent, Friend, Faculty) for affinity-based segmentation."
    - name: "primary_affiliation"
      expr: primary_affiliation
      comment: "Primary institutional affiliation of the donor (e.g., College of Engineering, School of Business) for unit-level fundraising reporting."
    - name: "portfolio_assignment"
      expr: portfolio_assignment
      comment: "Gift officer or team assigned to manage the donor relationship, enabling portfolio productivity analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "Country of the donor's primary address for geographic giving analysis and international fundraising strategy."
    - name: "wealth_screening_year"
      expr: YEAR(wealth_screening_date)
      comment: "Year of the most recent wealth screening, used to identify donors with stale capacity ratings requiring re-screening."
  measures:
    - name: "total_fiscal_year_giving"
      expr: SUM(CAST(fiscal_year_giving_total AS DOUBLE))
      comment: "Total current fiscal year giving across all donors. Primary in-year fundraising performance metric for advancement leadership."
    - name: "total_donors"
      expr: COUNT(1)
      comment: "Total number of donor records in the portfolio. Baseline for donor universe size and participation rate benchmarking."
    - name: "avg_fiscal_year_giving"
      expr: AVG(CAST(fiscal_year_giving_total AS DOUBLE))
      comment: "Average current fiscal year giving per donor. Tracks per-donor productivity and informs ask amount calibration."
    - name: "do_not_solicit_count"
      expr: COUNT(CASE WHEN do_not_solicit_flag = TRUE THEN 1 END)
      comment: "Number of donors flagged as do-not-solicit. Tracks solicitable universe size and compliance with donor preferences."
    - name: "donors_with_portfolio_assignment"
      expr: COUNT(CASE WHEN portfolio_assignment IS NOT NULL THEN 1 END)
      comment: "Number of donors assigned to a gift officer portfolio. Measures major gift officer coverage and capacity utilization."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_prospect_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect research and wealth screening metrics. Enables major gift officers and advancement leadership to evaluate prospect pipeline quality, capacity distribution, and research coverage for strategic portfolio management."
  source: "`education_ecm`.`advancement`.`prospect_rating`"
  filter: rating_status = 'Active'
  dimensions:
    - name: "assigned_rating_tier"
      expr: assigned_rating_tier
      comment: "Assigned wealth and capacity tier (e.g., $1M+, $500K-$1M) for pipeline segmentation and major gift prioritization."
    - name: "capacity_rating"
      expr: capacity_rating
      comment: "Estimated giving capacity rating from wealth screening, used to prioritize cultivation and solicitation activities."
    - name: "inclination_rating"
      expr: inclination_rating
      comment: "Prospect's assessed inclination or affinity toward the institution, combined with capacity to prioritize outreach."
    - name: "rating_type"
      expr: rating_type
      comment: "Type of rating (e.g., Internal, Vendor, Self-Reported) to assess data quality and source reliability."
    - name: "research_source"
      expr: research_source
      comment: "Source of the prospect research data (e.g., iWave, DonorSearch, Internal) for vendor performance evaluation."
    - name: "research_vendor_code"
      expr: research_vendor_code
      comment: "Code identifying the wealth screening vendor, used to compare vendor coverage and accuracy."
    - name: "rating_year"
      expr: YEAR(rating_date)
      comment: "Year the prospect rating was assigned, used to identify stale ratings requiring refresh."
    - name: "political_contributions_flag"
      expr: political_contributions_flag
      comment: "Indicates whether the prospect has documented political contributions, a proxy for philanthropic propensity."
  measures:
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Total estimated giving capacity across all rated prospects. Quantifies the addressable major gift opportunity in the prospect pool."
    - name: "total_estimated_net_worth"
      expr: SUM(CAST(estimated_net_worth AS DOUBLE))
      comment: "Aggregate estimated net worth across the prospect portfolio. Provides a macro view of wealth concentration in the donor pipeline."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Benchmarks portfolio quality and informs major gift ask calibration."
    - name: "avg_affinity_score"
      expr: AVG(CAST(affinity_score AS DOUBLE))
      comment: "Average affinity score across rated prospects. Tracks institutional engagement depth in the prospect pool."
    - name: "avg_propensity_score"
      expr: AVG(CAST(propensity_score AS DOUBLE))
      comment: "Average propensity-to-give score across prospects. Prioritizes outreach to highest-likelihood donors."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across prospect ratings. Monitors research data integrity and identifies records needing enrichment."
    - name: "total_rated_prospects"
      expr: COUNT(1)
      comment: "Total number of prospect rating records. Measures research coverage of the prospect universe."
    - name: "avg_capacity_range_high"
      expr: AVG(CAST(estimated_capacity_range_high AS DOUBLE))
      comment: "Average upper bound of estimated capacity range. Used for optimistic pipeline scenario planning."
    - name: "avg_capacity_range_low"
      expr: AVG(CAST(estimated_capacity_range_low AS DOUBLE))
      comment: "Average lower bound of estimated capacity range. Used for conservative pipeline scenario planning."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_planned_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned and deferred gift pipeline metrics. Enables advancement leadership to monitor the bequest and planned gift portfolio value, commitment status, and stewardship coverage for long-term endowment growth planning."
  source: "`education_ecm`.`advancement`.`gift`"
  dimensions:
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the planned gift for multi-currency portfolio reporting."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates whether the planned gift donor requested anonymity, relevant for recognition and stewardship planning."
  measures:
    - name: "total_planned_gifts"
      expr: COUNT(1)
      comment: "Total number of planned gift commitments. Tracks planned giving program scale and bequest society membership."
    - name: "unique_planned_gift_donors"
      expr: COUNT(DISTINCT donor_id)
      comment: "Number of distinct donors with planned gift commitments. Measures bequest society membership breadth."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_engagement_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor and alumni engagement activity metrics. Tracks the volume, quality, and cost of engagement touchpoints to evaluate moves management effectiveness and gift officer productivity."
  source: "`education_ecm`.`advancement`.`engagement_activity`"
  filter: activity_status != 'Cancelled'
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of engagement activity (e.g., Visit, Call, Email, Event, Proposal) for channel mix and moves management analysis."
    - name: "channel"
      expr: channel
      comment: "Communication or engagement channel used (e.g., In-Person, Phone, Digital) to evaluate channel effectiveness."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the engagement activity (e.g., Completed, Planned, Pending) for pipeline and follow-up tracking."
    - name: "outcome"
      expr: outcome
      comment: "Recorded outcome of the engagement activity (e.g., Positive, Neutral, Declined) to assess cultivation progress."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the engagement activity, used to evaluate gift officer time allocation."
    - name: "is_major_gift_related"
      expr: is_major_gift_related
      comment: "Flags activities directly related to a major gift proposal, enabling major gift pipeline activity analysis."
    - name: "is_volunteer_activity"
      expr: is_volunteer_activity
      comment: "Indicates whether the activity involved volunteer engagement, relevant for volunteer management and pipeline development."
    - name: "follow_up_required"
      expr: follow_up_required
      comment: "Flags activities requiring follow-up action, used to monitor gift officer responsiveness and pipeline momentum."
    - name: "activity_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the engagement activity for trend analysis and gift officer productivity reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the activity cost for multi-currency engagement cost reporting."
  measures:
    - name: "total_activities"
      expr: COUNT(1)
      comment: "Total number of engagement activities recorded. Primary gift officer productivity metric used in moves management dashboards."
    - name: "total_engagement_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of engagement activities. Used to compute cost-per-contact and evaluate fundraising efficiency."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across activities. Tracks the quality and depth of donor relationships over time."
    - name: "unique_alumni_engaged"
      expr: COUNT(DISTINCT alumnus_id)
      comment: "Number of distinct alumni touched by engagement activities. Measures breadth of alumni relationship management."
    - name: "major_gift_related_activities"
      expr: COUNT(CASE WHEN is_major_gift_related = TRUE THEN 1 END)
      comment: "Number of activities directly tied to major gift proposals. Tracks major gift cultivation intensity and pipeline momentum."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required = TRUE THEN 1 END)
      comment: "Number of activities with outstanding follow-up actions. Monitors gift officer responsiveness and pipeline health."
    - name: "avg_cost_per_activity"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per engagement activity. Benchmarks fundraising efficiency and informs engagement channel investment decisions."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_stewardship_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship program execution metrics. Tracks stewardship touchpoint volume, delivery performance, and IRS compliance to ensure donor retention and regulatory adherence."
  source: "`education_ecm`.`advancement`.`stewardship_action`"
  filter: action_status != 'Cancelled'
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Type of stewardship action (e.g., Thank You Letter, Impact Report, Recognition Event, IRS Receipt) for program mix analysis."
    - name: "action_status"
      expr: action_status
      comment: "Current status of the stewardship action (e.g., Scheduled, Completed, Overdue) for compliance and SLA monitoring."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship communication (e.g., Mail, Email, Phone, In-Person) for channel effectiveness analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery confirmation status of the stewardship communication (e.g., Delivered, Bounced, Returned) for quality assurance."
    - name: "moves_management_stage"
      expr: moves_management_stage
      comment: "Moves management stage associated with the stewardship action, linking stewardship to cultivation pipeline progression."
    - name: "recognition_level"
      expr: recognition_level
      comment: "Donor recognition level associated with the stewardship action, used to ensure appropriate recognition tier treatment."
    - name: "irs_acknowledgment_required"
      expr: irs_acknowledgment_required
      comment: "Flags actions requiring IRS acknowledgment letters for gifts over $250, critical for donor tax compliance."
    - name: "impact_metrics_included"
      expr: impact_metrics_included
      comment: "Indicates whether the stewardship communication included impact metrics, a best practice for donor retention."
    - name: "donor_response_received"
      expr: donor_response_received
      comment: "Indicates whether the donor responded to the stewardship communication, measuring engagement effectiveness."
    - name: "action_month"
      expr: DATE_TRUNC('MONTH', action_date)
      comment: "Month of the stewardship action for trend analysis and program cadence monitoring."
  measures:
    - name: "total_stewardship_actions"
      expr: COUNT(1)
      comment: "Total number of stewardship actions executed. Primary metric for stewardship program activity volume and staff productivity."
    - name: "total_stewardship_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Used to compute cost-per-stewardship-touch and evaluate program ROI."
    - name: "unique_donors_stewarded"
      expr: COUNT(DISTINCT donor_id)
      comment: "Number of distinct donors who received stewardship actions. Measures stewardship program coverage across the donor portfolio."
    - name: "irs_acknowledgment_pending_count"
      expr: COUNT(CASE WHEN irs_acknowledgment_required = TRUE AND irs_acknowledgment_sent_date IS NULL THEN 1 END)
      comment: "Number of gifts requiring IRS acknowledgment letters that have not yet been sent. Critical compliance risk metric."
    - name: "donor_response_count"
      expr: COUNT(CASE WHEN donor_response_received = TRUE THEN 1 END)
      comment: "Number of stewardship actions that received a donor response. Used as the numerator for stewardship response rate analysis."
    - name: "completed_actions"
      expr: COUNT(CASE WHEN action_status = 'Completed' THEN 1 END)
      comment: "Number of stewardship actions successfully completed. Tracks program execution rate and staff follow-through."
    - name: "avg_stewardship_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship action. Benchmarks program efficiency and informs budget planning for stewardship activities."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_alumni_event_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Alumni event participation and engagement metrics. Tracks registration volume, attendance conversion, and VIP engagement to evaluate event program effectiveness and alumni engagement ROI."
  source: "`education_ecm`.`advancement`.`alumni_event_registration`"
  filter: registration_status != 'Cancelled'
  dimensions:
    - name: "registration_status"
      expr: registration_status
      comment: "Current status of the event registration (e.g., Registered, Attended, No-Show, Waitlisted) for attendance conversion analysis."
    - name: "ticket_type"
      expr: ticket_type
      comment: "Type of ticket or registration category (e.g., General, VIP, Student, Complimentary) for revenue and audience mix analysis."
    - name: "registration_source"
      expr: registration_source
      comment: "Channel through which the registration was made (e.g., Online, Phone, Walk-In) for channel effectiveness evaluation."
    - name: "vip_flag"
      expr: vip_flag
      comment: "Identifies VIP registrants for high-touch engagement tracking and major gift cultivation event analysis."
    - name: "referral_source"
      expr: referral_source
      comment: "Source that referred the registrant to the event, used to evaluate marketing channel effectiveness."
    - name: "registration_month"
      expr: DATE_TRUNC('MONTH', registration_date)
      comment: "Month of registration for event pipeline and early registration trend analysis."
    - name: "check_in_method"
      expr: check_in_method
      comment: "Method used for event check-in (e.g., QR Code, Manual, App) for operational efficiency analysis."
  measures:
    - name: "total_registrations"
      expr: COUNT(1)
      comment: "Total number of event registrations. Primary metric for event demand and alumni engagement program reach."
    - name: "unique_alumni_registered"
      expr: COUNT(DISTINCT alumnus_id)
      comment: "Number of distinct alumni who registered for events. Measures alumni engagement program breadth."
    - name: "total_engagement_score"
      expr: SUM(CAST(engagement_score AS DOUBLE))
      comment: "Aggregate engagement score across all registrations. Tracks cumulative alumni engagement value generated through events."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score per registration. Benchmarks event quality and alumni engagement depth."
    - name: "vip_registration_count"
      expr: COUNT(CASE WHEN vip_flag = TRUE THEN 1 END)
      comment: "Number of VIP registrations. Tracks high-value prospect and major donor event participation for cultivation pipeline management."
    - name: "attended_count"
      expr: COUNT(CASE WHEN registration_status = 'Attended' THEN 1 END)
      comment: "Number of registrants who actually attended the event. Used as the numerator for attendance conversion rate analysis."
$$;

CREATE OR REPLACE VIEW `education_ecm`.`_metrics`.`advancement_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Advancement fund portfolio metrics. Enables finance and advancement leadership to monitor fund market values, endowment thresholds, spending policy compliance, and underwater fund exposure across the fund portfolio."
  source: "`education_ecm`.`advancement`.`advancement_fund`"
  filter: fund_status NOT IN ('Closed', 'Terminated')
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of advancement fund (e.g., Endowed, Current Use, Quasi-Endowment) for portfolio classification and investment policy alignment."
    - name: "fund_status"
      expr: fund_status
      comment: "Current operational status of the fund (e.g., Active, Pending, Suspended) for portfolio management."
    - name: "nacubo_classification"
      expr: nacubo_classification
      comment: "NACUBO classification of the fund for peer benchmarking and regulatory reporting."
    - name: "donor_recognition_level"
      expr: donor_recognition_level
      comment: "Recognition level associated with the fund's naming donor, used for stewardship and recognition program management."
    - name: "scholarship_fund_flag"
      expr: scholarship_fund_flag
      comment: "Identifies scholarship funds for student aid impact reporting and financial aid office coordination."
    - name: "underwater_status_flag"
      expr: underwater_status_flag
      comment: "Flags funds whose market value has fallen below the minimum endowment threshold, requiring investment committee attention."
    - name: "donor_advised_flag"
      expr: donor_advised_flag
      comment: "Identifies donor-advised funds, which have distinct legal and stewardship requirements."
    - name: "spending_calculation_method"
      expr: spending_calculation_method
      comment: "Method used to calculate annual spending from the fund, relevant for investment policy compliance monitoring."
    - name: "investment_pool_assignment"
      expr: investment_pool_assignment
      comment: "Investment pool to which the fund is assigned, used for investment performance attribution."
    - name: "last_valuation_year"
      expr: YEAR(last_valuation_date)
      comment: "Year of the most recent fund valuation, used to identify funds with stale valuations."
  measures:
    - name: "total_market_value"
      expr: SUM(CAST(current_market_value AS DOUBLE))
      comment: "Total current market value across all advancement funds. Primary fund portfolio KPI for investment committee and CFO reporting."
    - name: "total_original_gift_amount"
      expr: SUM(CAST(original_gift_amount AS DOUBLE))
      comment: "Total original gift principal across all funds. Used to compute cumulative investment growth and underwater exposure."
    - name: "total_minimum_endowment_threshold"
      expr: SUM(CAST(minimum_endowment_threshold AS DOUBLE))
      comment: "Aggregate minimum endowment thresholds across all funds. Used to assess total at-risk exposure for underwater fund analysis."
    - name: "total_funds"
      expr: COUNT(1)
      comment: "Total number of advancement funds under management. Baseline for portfolio scale and stewardship workload."
    - name: "underwater_fund_count"
      expr: COUNT(CASE WHEN underwater_status_flag = TRUE THEN 1 END)
      comment: "Number of funds currently underwater (market value below minimum threshold). Triggers investment committee review."
    - name: "scholarship_fund_count"
      expr: COUNT(CASE WHEN scholarship_fund_flag = TRUE THEN 1 END)
      comment: "Number of scholarship funds in the portfolio. Tracks student aid funding capacity and financial aid office coordination needs."
    - name: "avg_market_value"
      expr: AVG(CAST(current_market_value AS DOUBLE))
      comment: "Average market value per advancement fund. Benchmarks fund size distribution and identifies outlier funds."
    - name: "avg_spending_policy_rate"
      expr: AVG(CAST(spending_policy_rate AS DOUBLE))
      comment: "Average spending policy rate across all funds. Monitors compliance with board-approved spending policy parameters."
$$;