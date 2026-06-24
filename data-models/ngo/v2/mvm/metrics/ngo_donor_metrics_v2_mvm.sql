-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-06-23 02:03:19

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Tracks donation volume, value, net revenue, matching gifts, and refund exposure — the primary KPIs for fundraising performance reviews."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (e.g. one-time, recurring, in-kind) used to segment revenue streams."
    - name: "gift_status"
      expr: gift_status
      comment: "Processing status of the gift (e.g. posted, pending, reversed) for pipeline and reconciliation analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted, unrestricted, or temporarily restricted — critical for fund allocation decisions."
    - name: "acknowledgement_type"
      expr: acknowledgement_type
      comment: "Method used to acknowledge the gift, supporting donor stewardship quality analysis."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift has a corporate match, enabling matching gift revenue tracking."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Flags anonymous gifts for reporting and recognition exclusion."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Identifies refunded gifts for net revenue and donor satisfaction analysis."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates tribute or memorial gifts, supporting targeted stewardship."
    - name: "gift_date"
      expr: gift_date
      comment: "Date the gift was made, used for time-series revenue trending."
    - name: "gl_posting_date"
      expr: gl_posting_date
      comment: "General ledger posting date for financial period alignment."
    - name: "irs_compliant_flag"
      expr: irs_compliant_flag
      comment: "Flags gifts that meet IRS compliance requirements, critical for regulatory reporting."
  measures:
    - name: "total_gift_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross donation revenue across all gifts. Primary fundraising revenue KPI for executive dashboards and board reporting."
    - name: "total_net_gift_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net donation revenue after fees and deductions. Reflects actual funds available for programmatic use."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total processing fees incurred on gifts. Informs cost-of-fundraising analysis and payment channel optimization."
    - name: "total_goods_services_value"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total value of goods or services provided to donors, required for IRS quid-pro-quo disclosure and net deductible gift calculation."
    - name: "gift_count"
      expr: COUNT(1)
      comment: "Total number of gift transactions. Baseline volume metric for fundraising throughput and campaign response analysis."
    - name: "unique_donor_count"
      expr: COUNT(DISTINCT primary_gift_constituent_id)
      comment: "Number of unique donors who made at least one gift. Core donor base size metric for retention and acquisition tracking."
    - name: "average_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gross gift size. Tracks donor generosity trends and informs ask-amount strategy."
    - name: "average_net_gift_amount"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net gift amount after fees. Reflects true average revenue yield per gift."
    - name: "matching_gift_count"
      expr: COUNT(CASE WHEN matching_gift_flag = TRUE THEN 1 END)
      comment: "Number of gifts with a corporate match. Tracks matching gift program utilization and incremental revenue opportunity."
    - name: "total_matching_gift_amount"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total gross amount of gifts that have a corporate match. Quantifies matching gift revenue contribution."
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Number of refunded gifts. Elevated refund counts signal donor dissatisfaction or processing errors requiring investigation."
    - name: "total_refund_amount"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of refunded gifts. Measures revenue at risk from refunds and informs donor relations interventions."
    - name: "unacknowledged_gift_count"
      expr: COUNT(CASE WHEN notification_sent_flag = FALSE THEN 1 END)
      comment: "Number of gifts where donor notification has not been sent. Stewardship gap metric — unacknowledged gifts risk donor lapse."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge fulfillment and pipeline metrics tracking committed donor revenue, outstanding balances, write-offs, and installment health. Essential for cash-flow forecasting and major donor stewardship."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g. active, fulfilled, lapsed, cancelled) for pipeline segmentation."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g. standard, endowment, challenge) for revenue stream classification."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Payment frequency (e.g. monthly, quarterly, annual) for cash-flow forecasting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Flags recurring pledges, which represent predictable long-term revenue."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for a corporate match, informing matching gift solicitation strategy."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Flags anonymous pledges for recognition and reporting exclusions."
    - name: "pledge_date"
      expr: pledge_date
      comment: "Date the pledge was made, used for cohort and vintage analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for pledge cancellation, enabling root-cause analysis of pledge attrition."
  measures:
    - name: "total_pledge_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total committed pledge value across all pledges. Primary pipeline revenue metric for cash-flow forecasting and board reporting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount already collected against pledges. Measures pledge fulfillment progress and realized revenue."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total uncollected pledge balance. Represents future committed revenue and informs collection prioritization."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total pledge amounts written off as uncollectable. Tracks revenue loss from pledge defaults and informs risk management."
    - name: "pledge_count"
      expr: COUNT(1)
      comment: "Total number of pledges. Baseline volume metric for pledge pipeline size."
    - name: "unique_pledging_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with active or historical pledges. Measures depth of committed donor relationships."
    - name: "average_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average total pledge commitment per pledge record. Benchmarks pledge ask strategy and donor capacity utilization."
    - name: "average_balance_outstanding"
      expr: AVG(CAST(balance_outstanding AS DOUBLE))
      comment: "Average outstanding balance per pledge. Identifies typical collection exposure per pledge relationship."
    - name: "total_next_installment_amount"
      expr: SUM(CAST(next_installment_amount AS DOUBLE))
      comment: "Total value of next scheduled installments across all active pledges. Short-term cash-flow forecast metric."
    - name: "cancelled_pledge_count"
      expr: COUNT(CASE WHEN pledge_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled pledges. Elevated cancellations signal donor dissatisfaction or economic stress requiring leadership attention."
    - name: "recurring_pledge_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring pledges. Recurring pledges represent the most predictable revenue stream and are a strategic retention KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline metrics tracking solicitation stage, weighted pipeline value, probability, and close rates. Drives major gift officer performance management and revenue forecasting."
  source: "`vibe_ngo_v1`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current pipeline stage (e.g. identification, cultivation, solicitation, stewardship) for funnel analysis."
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift (e.g. outright, bequest, planned) for portfolio segmentation."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Intended programmatic purpose of the gift, linking major gifts to strategic priorities."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification of the opportunity for fund allocation planning."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year target for the opportunity, enabling annual pipeline and goal tracking."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the opportunity was identified, informing prospecting strategy ROI."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active opportunities for pipeline reporting vs. closed/lost."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates matching gift eligibility, enabling incremental revenue projection."
    - name: "donor_recognition_level"
      expr: donor_recognition_level
      comment: "Proposed recognition tier for the donor, used in stewardship planning."
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Projected close date for time-bucketed pipeline forecasting."
    - name: "loss_reason"
      expr: loss_reason
      comment: "Reason for lost opportunities, enabling win/loss analysis and strategy refinement."
  measures:
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total solicitation ask value across all major gift opportunities. Represents the gross pipeline ask and fundraising ambition."
    - name: "total_expected_gift_amount"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total expected gift value across all opportunities. Primary major gift pipeline revenue forecast metric."
    - name: "total_weighted_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value. Risk-adjusted revenue forecast used in board-level financial planning."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of major gift opportunities in the pipeline. Baseline volume metric for portfolio size and officer workload."
    - name: "active_opportunity_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active major gift opportunities. Tracks live pipeline health and officer engagement."
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents with major gift opportunities. Measures breadth of major donor cultivation portfolio."
    - name: "average_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across all opportunities. Indicates overall pipeline confidence and quality."
    - name: "average_expected_gift_amount"
      expr: AVG(CAST(expected_gift_amount AS DOUBLE))
      comment: "Average expected gift size per opportunity. Benchmarks major gift ask strategy and portfolio composition."
    - name: "average_weighted_value"
      expr: AVG(CAST(weighted_value AS DOUBLE))
      comment: "Average probability-weighted value per opportunity. Normalizes pipeline quality across officers and portfolios."
    - name: "total_active_ask_amount"
      expr: SUM(CASE WHEN is_active = TRUE THEN CAST(ask_amount AS DOUBLE) ELSE 0 END)
      comment: "Total ask amount for active opportunities only. Represents the live solicitation pipeline value for near-term revenue planning."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance metrics measuring fundraising ROI, goal attainment, and cost efficiency. Enables leadership to evaluate which campaigns deliver the highest return and inform future investment decisions."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. active, closed, planned) for pipeline vs. completed analysis."
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g. annual fund, capital, emergency) for portfolio segmentation."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel (e.g. direct mail, digital, events) for channel ROI comparison."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment, linking campaigns to strategic impact priorities."
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Intended donor segment for the campaign, enabling segment-level performance analysis."
    - name: "is_active"
      expr: is_active
      comment: "Flags currently active campaigns for real-time performance monitoring."
    - name: "is_public"
      expr: is_public
      comment: "Indicates whether the campaign is publicly visible, relevant for brand and communications strategy."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Flags campaigns eligible for matching gifts, enabling incremental revenue tracking."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates tax deductibility status, relevant for donor incentive and compliance reporting."
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date for time-series and cohort analysis."
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date for duration and deadline-based performance tracking."
  measures:
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total funds raised across all campaigns. Primary fundraising revenue KPI for executive and board reporting."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all campaigns. Baseline for goal attainment and gap analysis."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost incurred to run campaigns. Core input for fundraising efficiency and ROI calculations."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Baseline volume metric for portfolio breadth."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Tracks live fundraising activity and resource deployment."
    - name: "average_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across campaigns. Directly measures fundraising efficiency — a core KPI for investment decisions."
    - name: "average_goal_amount"
      expr: AVG(CAST(goal_amount AS DOUBLE))
      comment: "Average campaign fundraising goal. Benchmarks campaign ambition and planning norms."
    - name: "average_raised_amount"
      expr: AVG(CAST(total_raised_amount AS DOUBLE))
      comment: "Average funds raised per campaign. Normalizes performance across campaigns of different scales."
    - name: "matching_gift_eligible_campaign_count"
      expr: COUNT(CASE WHEN matching_gift_eligible = TRUE THEN 1 END)
      comment: "Number of campaigns eligible for matching gifts. Tracks matching gift program reach and incremental revenue opportunity."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal-level fundraising performance metrics covering response rates, ROI, cost efficiency, and revenue yield. Enables direct comparison of solicitation tactics and channel effectiveness."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. acquisition, renewal, upgrade) for tactic-level performance segmentation."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal for active vs. completed performance comparison."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel (e.g. email, direct mail, phone) for channel ROI and response rate analysis."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Flags control group appeals for A/B test and experimental design analysis."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Flags test segment appeals, enabling lift measurement against control groups."
    - name: "mailing_date"
      expr: mailing_date
      comment: "Date the appeal was mailed or deployed, for time-series response and revenue analysis."
    - name: "start_date"
      expr: start_date
      comment: "Appeal start date for campaign window analysis."
    - name: "end_date"
      expr: end_date
      comment: "Appeal end date for duration and deadline-based performance tracking."
    - name: "manager_name"
      expr: manager_name
      comment: "Appeal manager for accountability and performance attribution."
  measures:
    - name: "total_revenue_amount"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary appeal-level revenue KPI for fundraising performance reviews."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of running appeals. Core input for cost-per-dollar-raised and ROI calculations."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total solicitation ask value across all appeals. Measures fundraising ambition and ask strategy scale."
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeals. Baseline volume metric for solicitation activity."
    - name: "average_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average donor response rate across appeals. Key effectiveness metric — low response rates trigger channel or message strategy reviews."
    - name: "average_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Directly measures appeal efficiency and informs future investment allocation."
    - name: "average_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount per appeal. Benchmarks ask strategy and informs ask-string optimization."
    - name: "average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount per appeal record. Tracks donor generosity response to specific appeal tactics."
    - name: "total_average_gift_amount"
      expr: SUM(CAST(average_gift_amount AS DOUBLE))
      comment: "Sum of average gift amounts across appeals, used as a portfolio-level input for weighted gift size analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor portfolio health and capacity metrics tracking lifetime giving, estimated capacity, retention signals, and compliance status. Drives major donor identification, segmentation, and stewardship prioritization."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g. individual, foundation, corporation, government) for portfolio segmentation."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder (e.g. major donor, mid-level, annual fund) for tiered stewardship strategy."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship depth tier for prioritizing cultivation and stewardship resources."
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive/deceased status for portfolio hygiene and active donor base sizing."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Flags deceased constituents for exclusion from active solicitation and portfolio reporting."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "GDPR consent status — critical for regulatory compliance and permissioned communication."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Email opt-in status for digital channel reachability analysis."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Official Development Assistance eligibility flag for DAC-compliant reporting."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Flags DAC member donors for OECD/DAC regulatory reporting requirements."
    - name: "communication_preference"
      expr: communication_preference
      comment: "Preferred communication channel for donor engagement optimization."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Donor's preferred grant modality (e.g. project, pooled, budget support) for proposal alignment."
    - name: "prospect_research_rating"
      expr: prospect_research_rating
      comment: "Wealth screening and prospect research rating for major gift prioritization."
    - name: "first_gift_date"
      expr: first_gift_date
      comment: "Date of first gift for donor tenure and cohort analysis."
    - name: "last_gift_date"
      expr: last_gift_date
      comment: "Date of most recent gift for recency analysis and lapse risk identification."
  measures:
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures the cumulative value of the donor portfolio — a primary board-level KPI."
    - name: "average_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Benchmarks donor value and informs major gift threshold setting."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across the donor portfolio. Quantifies the theoretical fundraising ceiling and informs campaign goal-setting."
    - name: "average_estimated_giving_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent. Identifies capacity utilization gaps and major gift upgrade opportunities."
    - name: "total_largest_gift_amount"
      expr: SUM(CAST(largest_gift_amount AS DOUBLE))
      comment: "Sum of each constituent's largest single gift. Proxy for peak donor generosity and transformational gift potential."
    - name: "average_largest_gift_amount"
      expr: AVG(CAST(largest_gift_amount AS DOUBLE))
      comment: "Average of each constituent's largest gift. Benchmarks major gift potential across the portfolio."
    - name: "constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituents in the database. Baseline portfolio size metric."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'Active' THEN 1 END)
      comment: "Number of active constituents. Tracks the live, engageable donor base size — a key retention and growth metric."
    - name: "gdpr_consented_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 END)
      comment: "Number of constituents with valid GDPR consent. Regulatory compliance metric — insufficient consent coverage triggers legal risk."
    - name: "email_opted_in_count"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN 1 END)
      comment: "Number of constituents opted in to email communications. Measures digital channel reach for cost-effective donor engagement."
    - name: "deceased_constituent_count"
      expr: COUNT(CASE WHEN deceased_flag = TRUE THEN 1 END)
      comment: "Number of deceased constituents. Tracks portfolio attrition and informs planned giving and bequest pipeline analysis."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect pipeline metrics tracking identification, qualification, capacity, and conversion. Enables major gift and development officers to manage cultivation pipelines and forecast future donor acquisition."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (e.g. identified, qualified, cultivating, converted, disqualified) for funnel analysis."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. individual, foundation, corporate) for portfolio segmentation."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect for pipeline stage distribution analysis."
    - name: "research_stage"
      expr: research_stage
      comment: "Prospect research completion stage, informing data quality and readiness for solicitation."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus of the prospect for regional fundraising strategy alignment."
    - name: "source_of_wealth"
      expr: source_of_wealth
      comment: "Primary wealth source for prospect segmentation and tailored cultivation strategies."
    - name: "last_contact_type"
      expr: last_contact_type
      comment: "Type of most recent contact for engagement quality analysis."
    - name: "identification_date"
      expr: identification_date
      comment: "Date the prospect was identified for pipeline age and velocity analysis."
    - name: "expected_close_date"
      expr: expected_close_date
      comment: "Expected conversion date for near-term pipeline forecasting."
    - name: "disqualification_reason"
      expr: disqualification_reason
      comment: "Reason for prospect disqualification, enabling pipeline quality and sourcing strategy improvement."
  measures:
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Quantifies the theoretical value of the prospect pipeline for goal-setting."
    - name: "average_estimated_capacity"
      expr: AVG(CAST(estimated_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Benchmarks prospect quality and informs ask strategy."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total planned solicitation ask across all prospects. Measures the aggregate ask pipeline value."
    - name: "average_solicitation_amount"
      expr: AVG(CAST(solicitation_amount AS DOUBLE))
      comment: "Average planned ask per prospect. Benchmarks ask strategy relative to capacity estimates."
    - name: "total_estimated_gift_range_max"
      expr: SUM(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Total upper-bound estimated gift range across all prospects. Represents the optimistic pipeline ceiling for scenario planning."
    - name: "total_estimated_gift_range_min"
      expr: SUM(CAST(estimated_gift_range_min AS DOUBLE))
      comment: "Total lower-bound estimated gift range across all prospects. Represents the conservative pipeline floor for financial planning."
    - name: "average_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average conversion probability across all prospects. Indicates overall pipeline confidence and qualification quality."
    - name: "average_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across prospects. Tracks portfolio wealth concentration and major gift potential."
    - name: "prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospects in the pipeline. Baseline volume metric for pipeline breadth."
    - name: "unique_prospect_constituent_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents in the prospect pipeline. Measures the breadth of active cultivation relationships."
    - name: "converted_prospect_count"
      expr: COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 END)
      comment: "Number of prospects who have converted to donors. Tracks pipeline conversion success and acquisition effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship engagement metrics tracking activity volume, solicitation activity, follow-up compliance, and impact communication. Enables leadership to assess relationship management quality and its link to donor retention."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of stewardship activity (e.g. call, meeting, report, event) for engagement channel analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Completion status of the activity for pipeline and follow-up management."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship activity for channel effectiveness analysis."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan, enabling plan progression and completion tracking."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the activity for resource allocation and urgency analysis."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment from the interaction, tracking relationship health over time."
    - name: "activity_outcome"
      expr: activity_outcome
      comment: "Outcome of the stewardship activity for effectiveness and conversion analysis."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Flags activities requiring follow-up, enabling pipeline management and accountability."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity, linking stewardship to revenue generation."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Flags activities where an impact story was shared, tracking mission-driven stewardship quality."
    - name: "acknowledgement_sent_flag"
      expr: acknowledgement_sent_flag
      comment: "Indicates whether an acknowledgement was sent, tracking stewardship compliance."
    - name: "activity_date"
      expr: activity_date
      comment: "Date of the stewardship activity for time-series engagement trend analysis."
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities. Baseline engagement volume metric — low activity counts signal under-investment in donor relationships."
    - name: "unique_donor_touched_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors who received at least one stewardship touch. Measures breadth of active relationship management."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total solicitation ask value made during stewardship activities. Links relationship management directly to revenue pipeline generation."
    - name: "total_cost_amount"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Enables cost-per-touch and stewardship ROI analysis."
    - name: "average_cost_per_activity"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Benchmarks stewardship efficiency and informs budget allocation."
    - name: "solicitation_activity_count"
      expr: COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 END)
      comment: "Number of stewardship activities that included a solicitation. Tracks how often relationship touchpoints convert to asks."
    - name: "impact_story_shared_count"
      expr: COUNT(CASE WHEN impact_story_shared_flag = TRUE THEN 1 END)
      comment: "Number of activities where an impact story was shared. Measures mission-driven stewardship quality, linked to donor retention."
    - name: "follow_up_pending_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE AND activity_status != 'Completed' THEN 1 END)
      comment: "Number of activities with outstanding follow-up actions. Operational accountability metric — high counts indicate stewardship pipeline risk."
    - name: "acknowledgement_sent_count"
      expr: COUNT(CASE WHEN acknowledgement_sent_flag = TRUE THEN 1 END)
      comment: "Number of activities where an acknowledgement was sent. Tracks stewardship compliance and donor recognition quality."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fund portfolio metrics tracking balance, restriction compliance, cost-share obligations, and endowment policy. Enables finance and development leadership to manage fund health, compliance, and strategic allocation."
  source: "`vibe_ngo_v1`.`donor`.`fund`"
  dimensions:
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g. active, closed, suspended) for portfolio health monitoring."
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (e.g. restricted, unrestricted, endowment, emergency) for financial classification."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification (e.g. restricted, unrestricted, temporarily restricted) for compliance and allocation planning."
    - name: "category"
      expr: category
      comment: "Fund category for portfolio segmentation and reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the fund for regional allocation and impact reporting."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment for impact reporting and strategic portfolio analysis."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for official development assistance reporting compliance."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for donor stewardship and compliance scheduling."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Flags funds with cost-share obligations, critical for compliance and budget planning."
    - name: "audit_required"
      expr: audit_required
      comment: "Flags funds requiring external audit, informing compliance workload and risk management."
    - name: "inception_date"
      expr: inception_date
      comment: "Fund inception date for portfolio age and vintage analysis."
    - name: "closure_date"
      expr: closure_date
      comment: "Fund closure date for lifecycle and sunset planning."
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all funds. Primary fund portfolio health metric for finance and board reporting."
    - name: "average_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per fund. Benchmarks fund size and informs portfolio concentration analysis."
    - name: "total_minimum_gift_amount"
      expr: SUM(CAST(minimum_gift_amount AS DOUBLE))
      comment: "Total minimum gift thresholds across all funds. Informs donor qualification and fund access strategy."
    - name: "average_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds. Tracks overhead recovery and cost compliance with donor agreements."
    - name: "average_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage across funds with cost-share requirements. Measures co-financing obligation burden."
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of funds in the portfolio. Baseline metric for fund portfolio breadth."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN fund_status = 'Active' THEN 1 END)
      comment: "Number of currently active funds. Tracks the live fund portfolio available for programmatic deployment."
    - name: "cost_share_required_fund_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of funds with cost-share requirements. Tracks compliance obligation exposure across the fund portfolio."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of funds requiring external audit. Informs compliance workload planning and risk management."
    - name: "average_endowment_spending_policy"
      expr: AVG(CAST(endowment_spending_policy AS DOUBLE))
      comment: "Average endowment spending policy rate across endowment funds. Tracks sustainability of endowment drawdown relative to investment returns."
$$;