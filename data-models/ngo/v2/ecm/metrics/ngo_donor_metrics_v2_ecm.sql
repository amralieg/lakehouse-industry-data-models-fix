-- Metric views for domain: donor | Business: Ngo | Version: 2 | Generated on: 2026-06-23 01:23:48

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Covers total revenue, net revenue after fees, gift mix by type and channel, matching gift leverage, and refund rates. Primary KPI surface for fundraising performance reviews, board decks, and donor audit reporting. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT, SAP S/4HANA (VISION) for INGO finance integration."
  source: "`vibe_ngo_v1`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Classification of the gift (e.g. cash, in-kind, stock, wire transfer). Enables revenue mix analysis by gift vehicle."
    - name: "gift_status"
      expr: gift_status
      comment: "Current processing status of the gift (e.g. posted, pending, reversed). Used to filter to confirmed revenue."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Donor restriction classification (unrestricted, temporarily restricted, permanently restricted). Critical for ASC 958 / IPSAS net asset reporting."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month bucket of gift date for trend analysis and monthly fundraising dashboards."
    - name: "gift_date_year"
      expr: YEAR(gift_date)
      comment: "Fiscal/calendar year of gift for year-over-year revenue comparison."
    - name: "payment_channel"
      expr: CAST(payment_channel AS STRING)
      comment: "Channel through which payment was received (e.g. online, mail, event). Drives channel ROI analysis. Note: stored as DOUBLE in source — cast to STRING for grouping."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift is a corporate matching gift. Used to measure employer match leverage."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether the gift was refunded. Used to compute net revenue and refund rate."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates whether the gift was made in honor or memory of someone. Informs tribute giving program performance."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates whether the donor requested anonymity. Relevant for recognition and reporting exclusions."
    - name: "irs_compliant_flag"
      expr: irs_compliant_flag
      comment: "Indicates whether the gift meets IRS substantiation requirements. Critical for compliance and audit readiness."
    - name: "gl_posting_date_month"
      expr: DATE_TRUNC('MONTH', gl_posting_date)
      comment: "Month of GL posting date for financial period alignment under ASC 958 / IPSAS revenue recognition. [pii_de_identified]"
  measures:
    - name: "total_gift_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift revenue across all gifts in scope. Primary fundraising KPI for board and executive reporting. [ASC 958 / IPSAS 23 revenue recognition]"
    - name: "total_net_gift_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net gift revenue after deducting processing fees and goods/services value. Represents true philanthropic income available for mission delivery."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred on gifts. Informs cost-of-fundraising analysis and channel fee benchmarking."
    - name: "total_goods_services_value"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total fair market value of goods or services provided to donors in exchange for gifts. Required for IRS quid pro quo disclosure compliance."
    - name: "gift_count"
      expr: COUNT(1)
      comment: "Total number of gift transactions. Used to compute average gift size and track fundraising volume trends."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gross gift amount per transaction. Tracks donor generosity trends and informs ask-string calibration."
    - name: "matching_gift_revenue"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from corporate matching gifts. Measures employer match leverage and informs matching gift program investment."
    - name: "refund_amount"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total dollar value of refunded gifts. Elevated refund amounts signal donor dissatisfaction or processing errors requiring investigation."
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Number of refunded gift transactions. Used alongside refund_amount to compute refund rate and assess gift quality."
    - name: "irs_compliant_gift_count"
      expr: COUNT(CASE WHEN irs_compliant_flag = TRUE THEN 1 END)
      comment: "Number of gifts meeting IRS substantiation requirements. Compliance KPI for audit readiness and donor receipt quality."
    - name: "max_single_gift_amount"
      expr: MAX(CAST(amount AS DOUBLE))
      comment: "Largest single gift amount in the reporting period. Identifies major gift activity and outlier transactions for review."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge fulfillment and pipeline metrics tracking multi-installment donor commitments. Covers outstanding balances, fulfillment rates, write-off exposure, and recurring giving health. Essential for cash flow forecasting and major gift pipeline management. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g. active, fulfilled, lapsed, cancelled, written-off). Primary filter for pipeline vs. closed analysis."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g. standard, recurring, challenge). Informs pledge program mix and fulfillment rate benchmarking."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Payment frequency for installment pledges (monthly, quarterly, annually). Drives cash flow forecasting granularity."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the pledge is a recurring/sustainer commitment. Recurring giving is a key revenue stability metric."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made. Enables cohort analysis of pledge fulfillment by vintage year."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made. Used for monthly pledge acquisition trend reporting."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for employer matching. Used to identify matching gift pipeline value."
  measures:
    - name: "total_pledge_amount_committed"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total face value of all pledges committed. Represents the full fundraising pipeline and is a leading indicator of future revenue."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against pledges to date. Measures pledge fulfillment progress and cash received."
    - name: "total_balance_outstanding"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total unpaid pledge balance remaining. Critical for accounts receivable forecasting and cash flow planning."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total pledge amounts written off as uncollectible. Elevated write-offs signal lapsed donor risk and inform bad-debt provisioning."
    - name: "pledge_count"
      expr: COUNT(1)
      comment: "Total number of pledge records. Used to compute average pledge size and track pledge acquisition volume."
    - name: "unique_pledging_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors with active or historical pledges. Measures depth of multi-year donor commitment."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average total pledge commitment per pledge record. Benchmarks pledge ask-string effectiveness and donor capacity alignment."
    - name: "avg_balance_outstanding"
      expr: AVG(CAST(balance_outstanding AS DOUBLE))
      comment: "Average outstanding balance per pledge. Identifies whether pledge balances are being collected on schedule."
    - name: "recurring_pledge_count"
      expr: COUNT(CASE WHEN is_recurring = TRUE THEN 1 END)
      comment: "Number of recurring/sustainer pledges. Recurring giving count is a primary revenue stability and donor loyalty KPI."
    - name: "recurring_pledge_committed_amount"
      expr: SUM(CASE WHEN is_recurring = TRUE THEN CAST(total_pledge_amount AS DOUBLE) ELSE 0 END)
      comment: "Total committed value of recurring pledges. Represents the predictable revenue base from sustainer donors."
    - name: "last_payment_amount_total"
      expr: SUM(CAST(last_payment_amount AS DOUBLE))
      comment: "Sum of most recent installment payments across all pledges. Used to monitor current-period cash collections from pledge portfolio."
    - name: "next_installment_amount_total"
      expr: SUM(CAST(next_installment_amount AS DOUBLE))
      comment: "Total of next scheduled installment amounts across active pledges. Forward-looking cash flow forecast for the next collection cycle."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline and solicitation performance metrics. Tracks weighted pipeline value, stage conversion, probability-adjusted revenue forecasts, and officer portfolio productivity. Core KPI surface for major gifts officers, VP of Development, and board fundraising committee. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current stage in the major gift solicitation pipeline (e.g. identification, cultivation, solicitation, stewardship, closed-won, closed-lost). Primary pipeline segmentation dimension."
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift vehicle (e.g. outright, pledge, planned, matching). Informs gift vehicle mix analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification of the major gift opportunity (unrestricted, restricted). Informs fund allocation planning."
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Programmatic purpose designated by the donor (e.g. education, health, emergency response). Aligns major gift pipeline to program funding needs."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year in which the gift is expected to close. Enables annual fundraising goal tracking and year-end pipeline reviews."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the opportunity is currently active. Used to filter pipeline to live opportunities vs. historical closed records."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the opportunity qualifies for employer matching. Used to identify matching gift leverage in the major gift pipeline."
    - name: "expected_close_date_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month the gift is expected to close. Enables monthly pipeline maturity and close-date distribution analysis."
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which the prospect was identified (e.g. event, referral, direct mail). Informs prospect sourcing ROI."
  measures:
    - name: "total_expected_gift_amount"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total face value of all major gift opportunities in the pipeline. Represents the gross fundraising pipeline before probability weighting."
    - name: "total_weighted_pipeline_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value across all opportunities. The primary major gift revenue forecast metric used in board and executive reporting."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total amount solicited across all major gift asks. Compared against expected gift amounts to assess ask calibration."
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Total number of major gift opportunities. Tracks pipeline volume and officer workload."
    - name: "active_opportunity_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active major gift opportunities. Core pipeline health metric for major gifts program management."
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct prospects with major gift opportunities. Measures breadth of major gift prospect pool."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across all opportunities. Declining average probability signals pipeline quality deterioration requiring officer intervention."
    - name: "avg_expected_gift_amount"
      expr: AVG(CAST(expected_gift_amount AS DOUBLE))
      comment: "Average expected gift size per opportunity. Benchmarks major gift ask calibration against donor capacity ratings."
    - name: "max_expected_gift_amount"
      expr: MAX(CAST(expected_gift_amount AS DOUBLE))
      comment: "Largest single expected gift in the pipeline. Identifies transformational gift opportunities requiring executive attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising campaign performance and ROI metrics. Tracks revenue raised against goals, cost of fundraising, ROI, and campaign portfolio health. Used by development directors and CFOs to evaluate campaign investment decisions and optimize the fundraising portfolio. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT, SAP S/4HANA."
  source: "`vibe_ngo_v1`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of fundraising campaign (e.g. annual fund, capital campaign, emergency appeal, endowment). Enables portfolio mix analysis."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g. planning, active, closed). Used to filter to active campaigns for live performance monitoring."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel for the campaign (e.g. direct mail, digital, events, major gifts). Drives channel ROI benchmarking."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating whether the campaign is currently active. Used to segment live vs. historical campaign performance."
    - name: "is_public"
      expr: is_public
      comment: "Indicates whether the campaign is publicly visible. Relevant for digital campaign performance vs. private solicitation analysis."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Indicates whether the campaign qualifies for employer matching gifts. Used to measure matching gift leverage by campaign."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment of the campaign. Enables impact-aligned fundraising portfolio analysis for INGO and UN-agency donors."
    - name: "start_date_year"
      expr: YEAR(start_date)
      comment: "Year the campaign started. Enables year-over-year campaign performance comparison."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates whether gifts to this campaign are tax-deductible. Relevant for donor communications and IRS compliance reporting."
  measures:
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total revenue raised across all campaigns. Primary fundraising performance KPI for executive and board reporting."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all campaigns. Used as denominator for goal attainment rate calculation."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost incurred to run fundraising campaigns. Used in cost-of-fundraising ratio analysis and charity watchdog benchmarking."
    - name: "campaign_count"
      expr: COUNT(1)
      comment: "Total number of campaigns. Tracks portfolio size and enables per-campaign average performance benchmarking."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Monitors live fundraising portfolio breadth."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across campaigns. Primary efficiency metric for fundraising investment decisions — campaigns below benchmark trigger review."
    - name: "avg_goal_amount"
      expr: AVG(CAST(goal_amount AS DOUBLE))
      comment: "Average fundraising goal per campaign. Benchmarks campaign ambition and informs goal-setting for future campaigns."
    - name: "avg_raised_amount"
      expr: AVG(CAST(total_raised_amount AS DOUBLE))
      comment: "Average revenue raised per campaign. Used alongside avg_goal_amount to assess typical goal attainment."
    - name: "max_raised_amount"
      expr: MAX(CAST(total_raised_amount AS DOUBLE))
      comment: "Highest revenue raised by a single campaign. Identifies top-performing campaigns for replication and investment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Direct marketing appeal performance metrics covering response rates, ROI, cost efficiency, and revenue per piece. Used by direct response fundraising teams to optimize mailing strategy, channel mix, and ask-string calibration. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (e.g. acquisition, renewal, upgrade, lapsed reactivation). Enables performance benchmarking by appeal strategy."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g. planned, in-flight, completed). Used to filter to completed appeals for ROI analysis."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel for the appeal (e.g. direct mail, email, digital, telemarketing). Primary dimension for channel ROI benchmarking."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Indicates whether the appeal is a control group in an A/B test. Used to compare test vs. control performance."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Indicates whether the appeal is a test segment. Used alongside control_group_flag for A/B test analysis."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month the appeal was mailed. Enables seasonal response rate and revenue trend analysis."
    - name: "mailing_date_year"
      expr: YEAR(mailing_date)
      comment: "Year the appeal was mailed. Enables year-over-year appeal performance comparison."
  measures:
    - name: "total_appeal_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeals. Primary direct response fundraising revenue KPI."
    - name: "total_appeal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of running appeals (production, postage, fulfillment). Used in cost-per-dollar-raised and ROI calculations."
    - name: "appeal_count"
      expr: COUNT(1)
      comment: "Total number of appeal records. Tracks direct response program volume."
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeals. Core direct mail performance benchmark — declining rates trigger list hygiene and creative review."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Measures fundraising efficiency — appeals below 1.0 are net-negative and require strategic review."
    - name: "avg_average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount per appeal. Benchmarks ask-string effectiveness and donor generosity by appeal type and channel."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total ask amount across all appeals. Compared against total revenue to assess ask calibration effectiveness."
    - name: "max_roi_ratio"
      expr: MAX(CAST(roi_ratio AS DOUBLE))
      comment: "Highest ROI ratio achieved by a single appeal. Identifies top-performing appeal formats and channels for investment scaling."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor and constituent base health metrics covering portfolio size, giving capacity, lifecycle stage, and consent compliance. Used by development leadership to assess donor base quality, GDPR/data compliance posture, and prospect pipeline depth. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT. NOTE: Fields such as primary_email, mailing_address_line1, primary_phone, preferred_name, legal_name are classified [pii_donor] and subject to dynamic masking policies per VREQ-029."
  source: "`vibe_ngo_v1`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g. individual, foundation, corporation, government). Primary segmentation for donor portfolio analysis."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier assigned to the constituent (e.g. major donor, mid-level, annual fund, lapsed). Drives stewardship resource allocation."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder (e.g. bilateral, multilateral, private foundation, corporate, individual). Relevant for IATI reporting and ODA tracking."
    - name: "record_status"
      expr: record_status
      comment: "Current status of the constituent record (e.g. active, inactive, deceased, merged). Used to filter to active donor base."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Indicates whether the constituent has provided GDPR consent for communications. Critical compliance dimension for EU donor data governance."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Indicates whether the constituent has opted in to email communications. Drives digital fundraising audience sizing."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Indicates whether the constituent is deceased. Used to suppress deceased records from active solicitation and compute planned giving pipeline."
    - name: "dac_member_flag"
      expr: dac_member_flag
      comment: "Indicates whether the constituent is a DAC (OECD Development Assistance Committee) member. Relevant for ODA-eligible funding classification."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Indicates whether the constituent's contributions qualify as Official Development Assistance. Critical for IATI and DAC reporting."
    - name: "first_gift_date_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift. Enables donor cohort analysis and retention rate calculation by acquisition vintage."
  measures:
    - name: "constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituent records. Measures donor base size — a foundational metric for fundraising capacity planning."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'active' THEN 1 END)
      comment: "Number of active constituent records. Tracks the live donor base available for solicitation."
    - name: "gdpr_consented_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 END)
      comment: "Number of constituents with valid GDPR consent. Compliance KPI — organizations must maintain consent rates above regulatory thresholds for EU donor communications."
    - name: "email_opted_in_count"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN 1 END)
      comment: "Number of constituents opted in to email. Determines the addressable digital fundraising audience size."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents. Measures the cumulative philanthropic value of the donor base."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Benchmarks donor value and informs major gift qualification thresholds."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across the constituent base. Represents the theoretical fundraising ceiling and informs campaign goal-setting."
    - name: "avg_largest_gift_amount"
      expr: AVG(CAST(largest_gift_amount AS DOUBLE))
      comment: "Average of each constituent's largest single gift. Benchmarks major gift potential and ask-string calibration across the portfolio."
    - name: "deceased_constituent_count"
      expr: COUNT(CASE WHEN deceased_flag = TRUE THEN 1 END)
      comment: "Number of deceased constituents. Used to assess planned giving pipeline maturity and suppress deceased records from active solicitation."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect research and qualification pipeline metrics. Tracks prospect pool depth, capacity estimates, qualification rates, and research pipeline stage distribution. Used by prospect research officers and major gift teams to prioritize cultivation and manage officer portfolios. Systems of record: Salesforce Nonprofit Cloud, iWave, DonorSearch, Raiser's Edge NXT. NOTE: Fields such as email_address, mailing_address, phone_number, prospect_name are classified [pii_donor] per VREQ-029."
  source: "`vibe_ngo_v1`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (e.g. identified, qualifying, cultivating, soliciting, closed). Primary pipeline stage dimension."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g. individual, foundation, corporate). Enables prospect pool segmentation by donor type."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research completion (e.g. initial screen, deep research, validated). Tracks research pipeline throughput."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect in the major gift pipeline. Enables stage-gate conversion analysis."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus area of the prospect's philanthropic interest. Informs geographic fundraising strategy and officer territory assignment."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Programmatic area of interest for the prospect. Aligns prospect cultivation to organizational funding priorities."
    - name: "identification_date_year"
      expr: YEAR(identification_date)
      comment: "Year the prospect was identified. Enables prospect pipeline vintage analysis and time-to-qualification benchmarking."
  measures:
    - name: "prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospect records. Measures the size of the major gift prospect pipeline."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Represents the theoretical major gift pipeline ceiling for goal-setting."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Benchmarks prospect pool quality and informs major gift ask calibration."
    - name: "total_estimated_gift_range_max"
      expr: SUM(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Total upper bound of estimated gift ranges across all prospects. Represents the optimistic major gift pipeline ceiling."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total amount solicited across all prospects. Compared against estimated capacity to assess ask calibration."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average close probability across all prospects. Declining average probability signals pipeline quality issues requiring research team intervention."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across the prospect pool. Measures overall prospect pool quality and informs research prioritization."
    - name: "converted_prospect_count"
      expr: COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 END)
      comment: "Number of prospects who have converted to donors. Core pipeline conversion KPI for major gift program effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship engagement metrics tracking touchpoint volume, activity mix, follow-up compliance, and solicitation activity. Used by major gift officers and stewardship teams to ensure donors receive appropriate engagement and to measure relationship management productivity. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of stewardship activity (e.g. call, meeting, site visit, impact report, event). Enables touchpoint mix analysis."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the activity (e.g. planned, completed, cancelled). Used to filter to completed touchpoints for productivity reporting."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship touchpoint (e.g. phone, email, in-person, video). Informs channel preference analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the stewardship activity. Used to assess whether high-priority donors are receiving appropriate attention."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up action is required. Used to track outstanding follow-up obligations and officer accountability."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity. Used to track ask frequency and solicitation pipeline activity."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Indicates whether an impact story was shared during the activity. Measures impact communication frequency as a stewardship quality indicator."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month of the stewardship activity. Enables monthly touchpoint volume trend analysis."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan at which the activity occurred. Tracks stewardship plan execution progress."
  measures:
    - name: "activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities. Measures officer engagement productivity and touchpoint volume."
    - name: "unique_donor_touched_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors who received at least one stewardship touchpoint. Measures stewardship program reach across the donor portfolio."
    - name: "total_activity_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of stewardship activities. Used in cost-per-touchpoint analysis and stewardship program budget management."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total amount solicited during stewardship activities. Tracks ask volume generated through relationship management touchpoints."
    - name: "avg_activity_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Benchmarks stewardship efficiency and informs budget allocation by activity type."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of activities with outstanding follow-up requirements. Elevated counts signal officer accountability gaps requiring management attention."
    - name: "solicitation_activity_count"
      expr: COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 END)
      comment: "Number of activities where a solicitation was made. Tracks ask frequency as a leading indicator of major gift pipeline activity."
    - name: "impact_story_shared_count"
      expr: COUNT(CASE WHEN impact_story_shared_flag = TRUE THEN 1 END)
      comment: "Number of activities where an impact story was shared. Measures impact communication frequency as a stewardship quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_portfolio_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift officer portfolio management metrics covering portfolio load, capacity estimates, engagement readiness, and solicitation pipeline. Used by VP of Development and major gift directors to balance officer workloads, assess portfolio quality, and track cultivation progress. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`portfolio_assignment`"
  dimensions:
    - name: "portfolio_status"
      expr: portfolio_status
      comment: "Current status of the portfolio assignment (e.g. active, transferred, closed). Used to filter to live assignments."
    - name: "portfolio_tier"
      expr: portfolio_tier
      comment: "Tier classification of the portfolio (e.g. major gift, mid-level, planned giving). Enables tier-based workload and performance analysis."
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current solicitation stage for the assigned prospect (e.g. cultivation, solicitation, stewardship). Tracks pipeline stage distribution across officer portfolios."
    - name: "affinity_focus_area"
      expr: affinity_focus_area
      comment: "Programmatic area of donor affinity. Aligns portfolio assignments to program funding priorities."
    - name: "geographic_territory"
      expr: geographic_territory
      comment: "Geographic territory of the portfolio assignment. Enables territory-based portfolio load and performance analysis."
    - name: "proposal_submitted_flag"
      expr: proposal_submitted_flag
      comment: "Indicates whether a proposal has been submitted for this assignment. Tracks proposal pipeline activity across officer portfolios."
    - name: "assignment_date_year"
      expr: YEAR(assignment_date)
      comment: "Year of portfolio assignment. Enables cohort analysis of assignment outcomes and time-to-close benchmarking."
  measures:
    - name: "assignment_count"
      expr: COUNT(1)
      comment: "Total number of portfolio assignments. Measures overall portfolio load across the major gift program."
    - name: "unique_prospect_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct prospects assigned to officer portfolios. Measures the breadth of the managed major gift prospect pool."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Total estimated giving capacity across all portfolio assignments. Represents the theoretical major gift revenue ceiling managed by the officer team."
    - name: "total_expected_ask_amount"
      expr: SUM(CAST(expected_ask_amount AS DOUBLE))
      comment: "Total expected ask amount across all portfolio assignments. Represents the planned solicitation pipeline value."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(total_lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving across all portfolio-assigned constituents. Measures the historical philanthropic value of the managed portfolio."
    - name: "avg_portfolio_load_weight"
      expr: AVG(CAST(portfolio_load_weight AS DOUBLE))
      comment: "Average portfolio load weight per assignment. Used to assess officer workload balance and identify overloaded portfolios."
    - name: "proposal_submitted_count"
      expr: COUNT(CASE WHEN proposal_submitted_flag = TRUE THEN 1 END)
      comment: "Number of portfolio assignments with submitted proposals. Tracks solicitation pipeline activity and officer ask productivity."
    - name: "avg_last_gift_amount"
      expr: AVG(CAST(last_gift_amount AS DOUBLE))
      comment: "Average most recent gift amount across portfolio assignments. Benchmarks current donor generosity and informs upgrade ask calibration."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_planned_giving`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planned and legacy giving pipeline metrics tracking estimated bequest values, realization rates, gift vehicle mix, and stewardship tier distribution. Used by planned giving officers and CFOs for long-term revenue forecasting and legacy society management. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT. NOTE: attorney_name, financial_advisor_name, policy_number, estate_reference are classified [pii_donor] per VREQ-029."
  source: "`vibe_ngo_v1`.`donor`.`planned_giving`"
  dimensions:
    - name: "planned_gift_type"
      expr: planned_gift_type
      comment: "Type of planned gift vehicle (e.g. bequest, charitable remainder trust, charitable gift annuity, life insurance). Enables gift vehicle mix analysis."
    - name: "gift_status"
      expr: gift_status
      comment: "Current status of the planned gift (e.g. expectancy, irrevocable, realized, revoked). Primary pipeline stage dimension."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification of the planned gift (unrestricted, restricted). Required for ASC 958 / IPSAS net asset planning."
    - name: "legacy_society_member"
      expr: legacy_society_member
      comment: "Indicates whether the donor is a legacy society member. Used to track legacy society size and stewardship program reach."
    - name: "stewardship_tier"
      expr: stewardship_tier
      comment: "Stewardship tier assigned to the planned giving donor. Drives stewardship resource allocation for legacy donors."
    - name: "legal_documentation_status"
      expr: legal_documentation_status
      comment: "Status of legal documentation for the planned gift (e.g. received, pending, incomplete). Tracks documentation compliance."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Method used to value the planned gift (e.g. actuarial, face value, market value). Relevant for GAAP/IPSAS fair value disclosure."
    - name: "commitment_date_year"
      expr: YEAR(commitment_date)
      comment: "Year the planned gift commitment was made. Enables vintage cohort analysis of planned giving pipeline."
  measures:
    - name: "planned_gift_count"
      expr: COUNT(1)
      comment: "Total number of planned gift records. Measures the size of the legacy giving pipeline."
    - name: "legacy_society_member_count"
      expr: COUNT(CASE WHEN legacy_society_member = TRUE THEN 1 END)
      comment: "Number of legacy society members. Core planned giving program KPI — society size is a leading indicator of future bequest revenue."
    - name: "total_estimated_value"
      expr: SUM(CAST(estimated_value AS DOUBLE))
      comment: "Total estimated value of all planned gifts in the pipeline. Primary long-term revenue forecast metric for planned giving programs."
    - name: "total_present_value"
      expr: SUM(CAST(present_value AS DOUBLE))
      comment: "Total present value of planned gifts (discounted). Used for GAAP/IPSAS fair value recognition of irrevocable planned gifts."
    - name: "total_realized_value"
      expr: SUM(CAST(realized_value AS DOUBLE))
      comment: "Total value of planned gifts that have been realized (received). Measures actual planned giving revenue collected."
    - name: "avg_estimated_value"
      expr: AVG(CAST(estimated_value AS DOUBLE))
      comment: "Average estimated value per planned gift. Benchmarks bequest size and informs legacy society cultivation investment."
    - name: "avg_probability_score"
      expr: AVG(CAST(probability_score AS DOUBLE))
      comment: "Average realization probability across planned gifts. Declining probability scores signal pipeline quality issues requiring officer attention."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics covering revenue, attendance, cost efficiency, and net revenue. Used by event managers and development directors to evaluate event ROI, optimize event portfolio, and plan future events. Systems of record: Salesforce Nonprofit Cloud, Eventbrite, Cvent."
  source: "`vibe_ngo_v1`.`donor`.`fundraising_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of fundraising event (e.g. gala, auction, run/walk, virtual, cultivation dinner). Enables event type ROI benchmarking."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (e.g. planned, active, completed, cancelled). Used to filter to completed events for ROI analysis."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Indicates whether the event is virtual. Enables virtual vs. in-person event performance comparison."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Indicates whether event tickets are tax-deductible. Relevant for donor receipt compliance and IRS reporting."
    - name: "event_date_year"
      expr: YEAR(event_date)
      comment: "Year of the event. Enables year-over-year event portfolio performance comparison."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the event. Enables seasonal event performance analysis."
    - name: "venue_city"
      expr: venue_city
      comment: "City where the event was held. Enables geographic event performance analysis."
  measures:
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total revenue raised across all fundraising events. Primary event fundraising KPI for portfolio performance reporting."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of running fundraising events. Used in event ROI and cost-per-dollar-raised calculations."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after event costs. Represents the true fundraising yield from the event portfolio."
    - name: "event_count"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Tracks event portfolio volume."
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all events. Used as denominator for event goal attainment rate."
    - name: "total_capacity"
      expr: SUM(CAST(capacity_total AS DOUBLE))
      comment: "Total event capacity across all events. Used to compute attendance fill rate and capacity utilization."
    - name: "avg_ticket_price"
      expr: AVG(CAST(ticket_price_tiers AS DOUBLE))
      comment: "Average ticket price tier across events. Benchmarks event pricing strategy and informs future event pricing decisions."
    - name: "avg_net_revenue"
      expr: AVG(CAST(net_revenue AS DOUBLE))
      comment: "Average net revenue per event. Benchmarks event profitability and informs event portfolio investment decisions."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor segmentation portfolio metrics covering segment size, giving level distribution, lifecycle stage mix, and segment health. Used by direct response and digital fundraising teams to manage the donor segmentation strategy and optimize solicitation targeting. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`segment`"
  dimensions:
    - name: "segment_type"
      expr: segment_type
      comment: "Type of segment (e.g. acquisition, retention, lapsed, major gift, mid-level). Primary segmentation strategy dimension."
    - name: "segment_status"
      expr: segment_status
      comment: "Current status of the segment (e.g. active, archived, draft). Used to filter to active segments for operational reporting."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Donor lifecycle stage represented by the segment (e.g. new, active, lapsed, reactivated). Enables lifecycle portfolio analysis."
    - name: "acquisition_channel"
      expr: acquisition_channel
      comment: "Channel through which segment members were acquired. Informs channel ROI and acquisition strategy analysis."
    - name: "is_dynamic"
      expr: is_dynamic
      comment: "Indicates whether the segment is dynamically refreshed. Dynamic segments require monitoring for membership stability."
    - name: "stewardship_tier"
      expr: stewardship_tier
      comment: "Stewardship tier associated with the segment. Drives stewardship resource allocation by segment."
    - name: "wealth_screening_tier"
      expr: wealth_screening_tier
      comment: "Wealth screening tier of the segment. Enables capacity-based segment performance analysis."
    - name: "creation_date_year"
      expr: YEAR(creation_date)
      comment: "Year the segment was created. Enables segment portfolio vintage analysis."
  measures:
    - name: "segment_count"
      expr: COUNT(1)
      comment: "Total number of donor segments. Tracks segmentation portfolio complexity and coverage."
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN segment_status = 'active' THEN 1 END)
      comment: "Number of active donor segments. Measures the live segmentation portfolio available for solicitation targeting."
    - name: "total_giving_level_max"
      expr: SUM(CAST(giving_level_max AS DOUBLE))
      comment: "Sum of maximum giving level thresholds across segments. Represents the upper bound of giving capacity targeted by the segmentation strategy."
    - name: "avg_giving_level_min"
      expr: AVG(CAST(giving_level_min AS DOUBLE))
      comment: "Average minimum giving level threshold across segments. Benchmarks the entry-level giving bar set by the segmentation strategy."
    - name: "avg_giving_level_max"
      expr: AVG(CAST(giving_level_max AS DOUBLE))
      comment: "Average maximum giving level threshold across segments. Benchmarks the upper giving capacity targeted by the segmentation strategy."
    - name: "dynamic_segment_count"
      expr: COUNT(CASE WHEN is_dynamic = TRUE THEN 1 END)
      comment: "Number of dynamically refreshed segments. Tracks the proportion of the segmentation portfolio using automated membership rules."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_wealth_screening`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prospect wealth screening quality and capacity metrics. Tracks screening coverage, capacity estimates, confidence scores, and screening cost efficiency. Used by prospect research teams and major gift directors to prioritize cultivation and validate capacity ratings. Systems of record: iWave, DonorSearch, WealthEngine, Salesforce Nonprofit Cloud. NOTE: estimated_net_worth, real_estate_value, stock_holdings_value are classified [pii_donor] per VREQ-029."
  source: "`vibe_ngo_v1`.`donor`.`wealth_screening`"
  dimensions:
    - name: "screening_status"
      expr: screening_status
      comment: "Current status of the wealth screening (e.g. pending, completed, reviewed, expired). Used to filter to validated screenings."
    - name: "screening_type"
      expr: screening_type
      comment: "Type of wealth screening performed (e.g. initial, refresh, deep dive). Enables screening type cost and quality benchmarking."
    - name: "screening_provider"
      expr: screening_provider
      comment: "Vendor who performed the wealth screening (e.g. iWave, DonorSearch, WealthEngine). Enables provider quality and cost comparison."
    - name: "capacity_rating_tier"
      expr: capacity_rating_tier
      comment: "Capacity tier assigned by the screening (e.g. $1M+, $100K-$1M, $10K-$100K). Primary dimension for prospect pool capacity distribution analysis."
    - name: "data_privacy_consent_flag"
      expr: data_privacy_consent_flag
      comment: "Indicates whether the constituent consented to wealth screening data use. Critical compliance dimension for GDPR and data privacy governance."
    - name: "screening_date_year"
      expr: YEAR(screening_date)
      comment: "Year the screening was performed. Enables screening vintage analysis and refresh cycle management."
  measures:
    - name: "screening_count"
      expr: COUNT(1)
      comment: "Total number of wealth screenings performed. Tracks prospect research program throughput."
    - name: "unique_screened_constituent_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents who have been wealth screened. Measures screening coverage of the donor and prospect base."
    - name: "total_estimated_net_worth"
      expr: SUM(CAST(estimated_net_worth AS DOUBLE))
      comment: "Total estimated net worth across all screened constituents. Represents the aggregate wealth of the screened prospect pool. [pii_donor — subject to masking policy]"
    - name: "total_philanthropic_capacity_estimate"
      expr: SUM(CAST(philanthropic_capacity_estimate AS DOUBLE))
      comment: "Total estimated philanthropic giving capacity across all screened constituents. Primary prospect pool capacity metric for major gift goal-setting."
    - name: "avg_screening_confidence_score"
      expr: AVG(CAST(screening_confidence_score AS DOUBLE))
      comment: "Average confidence score of wealth screenings. Low confidence scores indicate data quality issues requiring re-screening or manual research."
    - name: "total_screening_cost"
      expr: SUM(CAST(screening_cost AS DOUBLE))
      comment: "Total cost of wealth screenings. Used in cost-per-screened-prospect analysis and research budget management."
    - name: "avg_real_estate_value"
      expr: AVG(CAST(real_estate_value AS DOUBLE))
      comment: "Average real estate holdings value across screened constituents. Real estate is a primary wealth indicator used in major gift capacity assessment. [pii_donor]"
    - name: "privacy_consented_screening_count"
      expr: COUNT(CASE WHEN data_privacy_consent_flag = TRUE THEN 1 END)
      comment: "Number of screenings with valid data privacy consent. Compliance KPI — organizations must ensure screening data is used only for consented constituents."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_segment_membership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor segment membership health and engagement metrics. Tracks active membership rates, engagement scores, lapsed risk, lifetime value distribution, and opt-out rates within segments. Used by direct response teams to monitor segment quality and identify at-risk donors. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`segment_membership`"
  dimensions:
    - name: "membership_status"
      expr: membership_status
      comment: "Current status of the segment membership (e.g. active, lapsed, removed, opted-out). Primary health dimension for segment membership analysis."
    - name: "assignment_method"
      expr: assignment_method
      comment: "Method by which the constituent was assigned to the segment (e.g. manual, automated, imported). Informs data quality and segmentation process analysis."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the segment membership is currently active. Used to filter to live memberships for operational reporting."
    - name: "is_exclusion"
      expr: is_exclusion
      comment: "Indicates whether the membership record represents a suppression/exclusion. Used to track suppression list management."
    - name: "opt_out_flag"
      expr: opt_out_flag
      comment: "Indicates whether the constituent has opted out of this segment's communications. Compliance dimension for solicitation suppression."
    - name: "upgrade_potential_flag"
      expr: upgrade_potential_flag
      comment: "Indicates whether the constituent has been flagged as an upgrade candidate. Used to identify mid-level to major gift upgrade pipeline."
    - name: "preferred_communication_channel"
      expr: preferred_communication_channel
      comment: "Constituent's preferred communication channel within this segment. Informs channel optimization for segment solicitations."
    - name: "membership_start_date_year"
      expr: YEAR(membership_start_date)
      comment: "Year the segment membership began. Enables cohort analysis of membership retention and engagement by vintage."
  measures:
    - name: "membership_count"
      expr: COUNT(1)
      comment: "Total number of segment membership records. Measures total segment membership volume across the donor base."
    - name: "active_membership_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of active segment memberships. Tracks the live addressable audience within each segment."
    - name: "unique_constituent_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct constituents with segment memberships. Measures segment reach across the donor base."
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_value_amount AS DOUBLE))
      comment: "Total lifetime giving value across all segment members. Measures the cumulative philanthropic value of the segmented donor base."
    - name: "avg_engagement_score"
      expr: AVG(CAST(engagement_score AS DOUBLE))
      comment: "Average engagement score across segment members. Declining engagement scores signal donor disengagement requiring re-activation campaigns."
    - name: "avg_lapsed_risk_score"
      expr: AVG(CAST(lapsed_risk_score AS DOUBLE))
      comment: "Average lapsed risk score across segment members. Elevated lapsed risk scores trigger retention intervention campaigns."
    - name: "total_giving_in_segment"
      expr: SUM(CAST(total_giving_in_segment AS DOUBLE))
      comment: "Total giving attributed to segment membership. Measures the revenue contribution of each segment to the overall fundraising program."
    - name: "opt_out_count"
      expr: COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END)
      comment: "Number of segment members who have opted out. Elevated opt-out counts signal messaging fatigue or relevance issues requiring segment strategy review."
    - name: "upgrade_candidate_count"
      expr: COUNT(CASE WHEN upgrade_potential_flag = TRUE THEN 1 END)
      comment: "Number of segment members flagged as upgrade candidates. Measures the mid-level to major gift upgrade pipeline within each segment."
    - name: "avg_last_gift_amount"
      expr: AVG(CAST(last_gift_amount AS DOUBLE))
      comment: "Average most recent gift amount across segment members. Benchmarks current donor generosity within each segment and informs upgrade ask calibration."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_soft_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Soft credit attribution and solicitor performance metrics. Tracks soft credit volume, amounts, recognition eligibility, and solicitor attribution. Used by major gift directors to measure officer credit attribution, recognition program compliance, and lifetime value calculations. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`soft_credit`"
  dimensions:
    - name: "soft_credit_type"
      expr: soft_credit_type
      comment: "Type of soft credit (e.g. solicitor, influencer, household, matching gift). Enables attribution analysis by credit type."
    - name: "soft_credit_status"
      expr: soft_credit_status
      comment: "Current status of the soft credit (e.g. active, reversed, pending). Used to filter to valid soft credit records."
    - name: "solicitor_relationship"
      expr: solicitor_relationship
      comment: "Relationship of the soft-credited constituent to the gift (e.g. solicitor, board member, peer). Informs solicitor attribution analysis."
    - name: "recognition_eligible_flag"
      expr: recognition_eligible_flag
      comment: "Indicates whether the soft credit counts toward donor recognition thresholds. Used to manage recognition society eligibility."
    - name: "lifetime_value_eligible_flag"
      expr: lifetime_value_eligible_flag
      comment: "Indicates whether the soft credit counts toward lifetime value calculations. Ensures accurate lifetime giving totals for major gift qualification."
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Indicates whether the soft credit is anonymous. Used to suppress anonymous credits from public recognition."
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the soft credit. Enables annual solicitor performance and recognition society reporting."
    - name: "soft_credit_date_month"
      expr: DATE_TRUNC('MONTH', soft_credit_date)
      comment: "Month of the soft credit. Enables monthly solicitor attribution trend analysis."
  measures:
    - name: "total_soft_credit_amount"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total soft credit amount attributed. Measures the total philanthropic influence credited to solicitors and influencers."
    - name: "soft_credit_count"
      expr: COUNT(1)
      comment: "Total number of soft credit records. Tracks attribution volume across the major gift program."
    - name: "recognition_eligible_amount"
      expr: SUM(CASE WHEN recognition_eligible_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total soft credit amount eligible for recognition society thresholds. Used to manage recognition society membership and donor acknowledgment."
    - name: "avg_soft_credit_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average soft credit amount per record. Benchmarks typical solicitor attribution value and informs recognition threshold calibration."
    - name: "total_allocation_percentage"
      expr: SUM(CAST(allocation_percentage AS DOUBLE))
      comment: "Sum of allocation percentages across soft credits. Used to validate that soft credit allocations sum correctly to 100% per gift."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_appeal_targeting`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal targeting and segment-level direct response performance metrics. Tracks response rates, ROI, cost allocation, and revenue by target segment. Used by direct response fundraising teams to optimize segment selection, test variant performance, and appeal targeting strategy. Systems of record: Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`appeal_targeting`"
  dimensions:
    - name: "target_segment"
      expr: target_segment
      comment: "Name or code of the target segment for this appeal targeting record. Primary dimension for segment-level response rate analysis."
    - name: "test_variant"
      expr: test_variant
      comment: "Test variant identifier for A/B testing. Used to compare test vs. control performance within appeal targeting."
    - name: "deployment_date_month"
      expr: DATE_TRUNC('MONTH', deployment_date)
      comment: "Month the appeal targeting was deployed. Enables monthly direct response performance trend analysis."
    - name: "deployment_date_year"
      expr: YEAR(deployment_date)
      comment: "Year the appeal targeting was deployed. Enables year-over-year direct response performance comparison."
  measures:
    - name: "total_targeting_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated by appeal targeting records. Measures direct response revenue by segment and test variant."
    - name: "total_cost_allocated"
      expr: SUM(CAST(cost_allocated AS DOUBLE))
      comment: "Total cost allocated to appeal targeting. Used in segment-level cost-per-dollar-raised analysis."
    - name: "targeting_record_count"
      expr: COUNT(1)
      comment: "Total number of appeal targeting records. Tracks direct response targeting volume."
    - name: "avg_response_rate_percent"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeal targeting records. Core direct response performance benchmark by segment and test variant."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average ROI ratio across appeal targeting records. Measures fundraising efficiency by segment — below-benchmark segments trigger targeting strategy review."
    - name: "avg_average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount per appeal targeting record. Benchmarks ask-string effectiveness by segment and test variant."
    - name: "total_segment_ask_amount"
      expr: SUM(CAST(segment_ask_amount AS DOUBLE))
      comment: "Total ask amount across all appeal targeting records. Compared against total revenue to assess ask calibration by segment."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor fund portfolio and compliance metrics tracking fund balances, restriction types, cost share obligations, endowment policies, and compliance status. Used by finance and development leadership for fund stewardship, ASC 958 / IPSAS net asset reporting, and donor compliance management. Systems of record: SAP S/4HANA (VISION), Salesforce Nonprofit Cloud, Raiser's Edge NXT."
  source: "`vibe_ngo_v1`.`donor`.`donor_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of donor fund (e.g. endowment, restricted, unrestricted, quasi-endowment). Primary dimension for ASC 958 / IPSAS net asset classification."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g. active, closed, suspended). Used to filter to active funds for balance reporting."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction classification (unrestricted, temporarily restricted, permanently restricted). Required for ASC 958 / IPSAS net asset reporting."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of the fund (e.g. programmatic, operational, emergency, endowment). Enables fund portfolio analysis by purpose."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the fund requires cost share matching. Used to track cost share obligation compliance."
    - name: "audit_required"
      expr: audit_required
      comment: "Indicates whether the fund requires an independent audit. Compliance dimension for donor audit requirement tracking."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment of the fund. Enables impact-aligned fund portfolio analysis for IATI and donor reporting."
    - name: "inception_date_year"
      expr: YEAR(inception_date)
      comment: "Year the fund was established. Enables fund vintage analysis and endowment growth tracking."
  measures:
    - name: "fund_count"
      expr: COUNT(1)
      comment: "Total number of donor funds. Tracks fund portfolio size and complexity."
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all donor funds. Primary fund portfolio health metric for finance and development leadership."
    - name: "avg_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per donor fund. Benchmarks fund size and informs minimum gift threshold calibration."
    - name: "total_cost_share_percentage"
      expr: SUM(CAST(cost_share_percentage AS DOUBLE))
      comment: "Sum of cost share percentages across all funds requiring cost share. Used to assess aggregate cost share obligation exposure."
    - name: "cost_share_required_fund_count"
      expr: COUNT(CASE WHEN cost_share_required = TRUE THEN 1 END)
      comment: "Number of funds with cost share requirements. Tracks cost share obligation portfolio for compliance management."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of funds requiring independent audits. Compliance KPI for audit planning and donor requirement fulfillment."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate (NICRA/overhead rate) across donor funds. Used to assess cost recovery adequacy and negotiate future fund terms."
    - name: "avg_minimum_gift_amount"
      expr: AVG(CAST(minimum_gift_amount AS DOUBLE))
      comment: "Average minimum gift threshold across donor funds. Benchmarks fund entry requirements and informs gift acceptance policy."
$$;

CREATE OR REPLACE VIEW `vibe_ngo_v1`.`_metrics`.`donor_indicator_funding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor-designated indicator funding metrics linking philanthropic contributions to specific MEL indicators and programmatic outcomes. Used by development and MEL teams to track impact-linked funding commitments, donor target alignment, and funding coverage of program indicators. Supports IATI reporting and results-based financing frameworks. Systems of record: Salesforce Nonprofit Cloud, eTools (UNICEF programme management), InSight (UNHCR BI)."
  source: "`vibe_ngo_v1`.`donor`.`indicator_funding`"
  dimensions:
    - name: "indicator_funding_status"
      expr: indicator_funding_status
      comment: "Current status of the indicator funding commitment (e.g. active, completed, cancelled). Used to filter to active funding commitments."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Restriction type of the indicator funding (e.g. restricted, unrestricted). Informs fund allocation and ASC 958 / IPSAS net asset classification."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Frequency at which the donor requires indicator progress reporting (e.g. quarterly, annual). Drives reporting schedule management."
    - name: "funding_start_date_year"
      expr: YEAR(funding_start_date)
      comment: "Year the indicator funding commitment began. Enables vintage analysis of impact-linked funding commitments."
  measures:
    - name: "total_funding_amount"
      expr: SUM(CAST(funding_amount AS DOUBLE))
      comment: "Total amount of donor funding designated to specific indicators. Measures the volume of impact-linked philanthropic commitments."
    - name: "total_donor_target_value"
      expr: SUM(CAST(donor_target_value AS DOUBLE))
      comment: "Total donor-specified target values across all indicator funding commitments. Used to assess the scale of results-based funding obligations."
    - name: "indicator_funding_count"
      expr: COUNT(1)
      comment: "Total number of indicator funding records. Tracks the volume of impact-linked funding commitments."
    - name: "unique_funded_indicator_count"
      expr: COUNT(DISTINCT indicator_id)
      comment: "Number of distinct program indicators with donor funding designations. Measures the breadth of impact-linked funding coverage across the program portfolio."
    - name: "unique_funding_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of distinct donors making indicator-linked funding commitments. Measures the depth of results-based donor engagement."
    - name: "avg_funding_amount"
      expr: AVG(CAST(funding_amount AS DOUBLE))
      comment: "Average funding amount per indicator funding commitment. Benchmarks typical impact-linked gift size and informs results-based fundraising ask calibration."
$$;