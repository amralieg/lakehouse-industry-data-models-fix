-- Metric views for domain: donor | Business: Ngo | Version: 1 | Generated on: 2026-05-07 03:19:07

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue metrics derived from individual gift transactions. Tracks donation volume, value, net revenue, matching gifts, and gift quality indicators to steer fundraising strategy and donor stewardship decisions."
  source: "`ngo_ecm`.`donor`.`gift`"
  dimensions:
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (e.g., one-time, recurring, in-kind) used to segment revenue streams and inform fundraising channel strategy."
    - name: "gift_status"
      expr: gift_status
      comment: "Processing status of the gift (e.g., posted, pending, reversed) enabling operational monitoring of gift pipeline health."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (e.g., credit card, check, wire transfer) to analyze channel preferences and optimize payment processing."
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which the gift was received (e.g., online, direct mail, event) for multi-channel fundraising performance analysis."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Whether the gift is restricted or unrestricted, critical for fund allocation planning and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the gift transaction, enabling multi-currency revenue analysis across global donor bases."
    - name: "gift_date_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift receipt, used for trend analysis, seasonality detection, and year-over-year fundraising comparisons."
    - name: "gift_date_year"
      expr: YEAR(gift_date)
      comment: "Fiscal year of gift receipt for annual fundraising performance reporting and board-level revenue tracking."
    - name: "matching_gift_flag"
      expr: matching_gift_flag
      comment: "Indicates whether the gift has a corporate matching component, used to track employer match leverage and maximize gift value."
    - name: "refund_flag"
      expr: refund_flag
      comment: "Indicates whether the gift was refunded, used to monitor gift reversal rates and donor satisfaction issues."
    - name: "anonymous_flag"
      expr: anonymous_flag
      comment: "Indicates anonymous gifts, relevant for stewardship planning and public recognition reporting."
    - name: "tribute_flag"
      expr: tribute_flag
      comment: "Indicates tribute or memorial gifts, used to segment and steward this high-affinity donor cohort."
    - name: "acknowledgement_type"
      expr: acknowledgement_type
      comment: "Type of acknowledgement issued for the gift, used to monitor stewardship compliance and donor recognition quality."
  measures:
    - name: "total_gift_count"
      expr: COUNT(1)
      comment: "Total number of gift transactions recorded. Baseline volume metric for fundraising pipeline and donor engagement tracking."
    - name: "total_gross_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift amount received across all transactions. Primary top-line fundraising revenue KPI used in board and executive reporting."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue after fees and deductions. Reflects actual funds available for mission delivery and is the preferred revenue metric for financial planning."
    - name: "total_fee_amount"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing and transaction fees incurred. Tracks cost of fundraising at the transaction level to optimize payment channel mix."
    - name: "avg_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size per transaction. A key donor quality indicator — rising average gift signals donor upgrade success and major gift pipeline growth."
    - name: "total_matching_gift_count"
      expr: COUNT(CASE WHEN matching_gift_flag = TRUE THEN 1 END)
      comment: "Number of gifts with a corporate matching component. Tracks leverage of employer match programs to amplify fundraising revenue."
    - name: "total_goods_services_value"
      expr: SUM(CAST(goods_services_value AS DOUBLE))
      comment: "Total value of goods or services provided in exchange for gifts. Required for IRS quid pro quo disclosure compliance and net deductible gift calculation."
    - name: "distinct_donor_count"
      expr: COUNT(DISTINCT gift_constituent_id)
      comment: "Number of unique donors who made at least one gift. Core donor base breadth metric used to track donor acquisition and retention performance."
    - name: "total_refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN 1 END)
      comment: "Number of refunded gifts. Elevated refund rates signal donor dissatisfaction, processing errors, or fraud — triggers immediate operational review."
    - name: "total_match_ratio_sum"
      expr: SUM(CAST(match_ratio AS DOUBLE))
      comment: "Sum of match ratios across matching gifts. Used alongside matching gift count to compute average employer match leverage for fundraising ROI analysis."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge pipeline and fulfillment metrics tracking committed donor revenue, outstanding balances, write-offs, and installment health. Essential for cash flow forecasting and major gift portfolio management."
  source: "`ngo_ecm`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of the pledge (e.g., active, fulfilled, cancelled, written-off) for pipeline health monitoring and revenue forecasting."
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge (e.g., major gift, recurring, bequest) used to segment the pledge portfolio by strategic giving category."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method associated with the pledge installments, used to optimize collection processes and reduce payment failures."
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of pledge installments (e.g., monthly, quarterly, annual) for cash flow planning and donor communication scheduling."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the pledge commitment for multi-currency portfolio valuation and reporting."
    - name: "is_recurring"
      expr: is_recurring
      comment: "Indicates whether the pledge is a recurring commitment, a key indicator of predictable revenue and donor loyalty."
    - name: "is_matching_gift_eligible"
      expr: is_matching_gift_eligible
      comment: "Indicates whether the pledge qualifies for employer matching, used to identify leverage opportunities in the pledge portfolio."
    - name: "pledge_date_year"
      expr: YEAR(pledge_date)
      comment: "Year the pledge was made, used for cohort analysis and year-over-year pledge volume comparisons."
    - name: "pledge_date_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month the pledge was made, used for seasonal pledge acquisition trend analysis."
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for pledge cancellation, used to identify systemic issues in donor commitment and inform retention strategies."
  measures:
    - name: "total_pledge_count"
      expr: COUNT(1)
      comment: "Total number of pledges in the portfolio. Baseline volume metric for major gift pipeline and recurring revenue program tracking."
    - name: "total_pledged_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total committed pledge value across all active and historical pledges. Primary pipeline revenue metric for major gift forecasting and board reporting."
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount collected against pledges to date. Measures pledge fulfillment progress and actual cash received from committed donors."
    - name: "total_outstanding_balance"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total uncollected pledge balance remaining. Critical for accounts receivable management and short-term cash flow forecasting."
    - name: "total_write_off_amount"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total pledge value written off as uncollectable. Tracks pledge default risk and informs credit quality assessment of the donor portfolio."
    - name: "avg_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average pledge commitment size. Tracks major gift program health — rising average pledge size signals successful donor upgrade and cultivation strategies."
    - name: "distinct_pledging_donor_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors with active or historical pledges. Measures depth of committed donor relationships in the major gift portfolio."
    - name: "total_cancelled_pledge_count"
      expr: COUNT(CASE WHEN pledge_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled pledges. Elevated cancellation rates trigger donor retention interventions and stewardship program reviews."
    - name: "avg_last_payment_amount"
      expr: AVG(CAST(last_payment_amount AS DOUBLE))
      comment: "Average amount of the most recent installment payment. Used to monitor installment payment trends and detect early signs of donor financial stress."
    - name: "total_next_installment_amount"
      expr: SUM(CAST(next_installment_amount AS DOUBLE))
      comment: "Total value of all upcoming installment payments due. Provides a near-term cash flow forecast for pledge receivables management."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor constituent portfolio metrics tracking giving capacity, lifetime value, engagement quality, and demographic composition. Drives major gift prospecting, segmentation strategy, and donor retention decisions."
  source: "`ngo_ecm`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (e.g., individual, foundation, corporation, government) for portfolio segmentation and tailored engagement strategies."
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier assigned to the constituent (e.g., major donor, mid-level, annual fund) for tiered stewardship and resource allocation."
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of the funder type (e.g., bilateral, multilateral, private foundation) for grant strategy and compliance planning."
    - name: "record_status"
      expr: record_status
      comment: "Active/inactive status of the constituent record, used to maintain a clean, actionable donor database."
    - name: "mailing_country_code"
      expr: mailing_country_code
      comment: "Country of the constituent's mailing address for geographic fundraising analysis and international donor portfolio management."
    - name: "gdpr_consent_flag"
      expr: gdpr_consent_flag
      comment: "Indicates GDPR consent status, critical for compliance with data privacy regulations governing donor communications in the EU."
    - name: "email_opt_in_flag"
      expr: email_opt_in_flag
      comment: "Indicates whether the constituent has opted into email communications, used to size the reachable digital fundraising audience."
    - name: "deceased_flag"
      expr: deceased_flag
      comment: "Indicates deceased constituents, used to suppress from active solicitation and identify planned giving/bequest opportunities."
    - name: "preferred_grant_modality"
      expr: preferred_grant_modality
      comment: "Preferred grant mechanism of the funder (e.g., project-based, core support, pooled fund) for proposal alignment and grant strategy."
    - name: "prospect_research_rating"
      expr: prospect_research_rating
      comment: "Wealth screening and prospect research rating used to prioritize major gift cultivation and solicitation efforts."
    - name: "first_gift_date_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift, used for donor cohort analysis and long-term retention rate calculations."
    - name: "oda_eligibility_flag"
      expr: oda_eligibility_flag
      comment: "Indicates whether the constituent qualifies as Official Development Assistance eligible, relevant for DAC reporting and grant compliance."
  measures:
    - name: "total_constituent_count"
      expr: COUNT(1)
      comment: "Total number of constituent records in the donor database. Baseline metric for database health, growth tracking, and fundraising universe sizing."
    - name: "total_lifetime_giving"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Aggregate lifetime giving across all constituents. Measures the total historical value of the donor portfolio and informs major gift investment decisions."
    - name: "avg_lifetime_giving"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent. Tracks donor quality and portfolio upgrade progress — a rising average signals successful major gift cultivation."
    - name: "total_estimated_giving_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across the constituent portfolio. Quantifies the addressable major gift opportunity and informs fundraising goal-setting."
    - name: "avg_estimated_giving_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent. Used to benchmark portfolio quality and identify segments with untapped giving potential."
    - name: "total_largest_gift_sum"
      expr: SUM(CAST(largest_gift_amount AS DOUBLE))
      comment: "Sum of each constituent's largest single gift. Provides a proxy for peak donor generosity and major gift program ceiling across the portfolio."
    - name: "active_constituent_count"
      expr: COUNT(CASE WHEN record_status = 'Active' THEN 1 END)
      comment: "Number of active constituent records. Tracks the size of the actionable donor universe for solicitation and stewardship planning."
    - name: "gdpr_consented_count"
      expr: COUNT(CASE WHEN gdpr_consent_flag = TRUE THEN 1 END)
      comment: "Number of constituents with valid GDPR consent. Measures compliance coverage and the legally reachable EU donor audience for digital campaigns."
    - name: "email_opted_in_count"
      expr: COUNT(CASE WHEN email_opt_in_flag = TRUE THEN 1 END)
      comment: "Number of constituents opted into email communications. Defines the digital fundraising reachable audience size for campaign planning."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising campaign performance metrics tracking revenue attainment, cost efficiency, ROI, and donor engagement at the campaign level. Drives strategic decisions on campaign investment, channel mix, and program prioritization."
  source: "`ngo_ecm`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of fundraising campaign (e.g., emergency appeal, annual fund, capital campaign) for performance benchmarking across campaign categories."
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign (e.g., active, closed, planned) for pipeline monitoring and resource allocation decisions."
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary solicitation channel of the campaign (e.g., digital, direct mail, major gifts) for multi-channel ROI comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which campaign financials are denominated, enabling consistent multi-currency performance reporting."
    - name: "is_active"
      expr: is_active
      comment: "Indicates whether the campaign is currently active, used to filter live campaign dashboards from historical reporting."
    - name: "tax_deductible"
      expr: tax_deductible
      comment: "Indicates whether gifts to this campaign are tax-deductible, relevant for donor communication and compliance reporting."
    - name: "matching_gift_eligible"
      expr: matching_gift_eligible
      comment: "Indicates whether the campaign is eligible for employer matching gifts, used to identify leverage opportunities in campaign planning."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN Sustainable Development Goal alignment of the campaign, used for impact reporting and donor engagement with SDG-focused funders."
    - name: "campaign_start_year"
      expr: YEAR(start_date)
      comment: "Year the campaign launched, used for cohort-based campaign performance analysis and year-over-year fundraising comparisons."
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target donor segment for the campaign, used to evaluate segment-level response rates and optimize audience targeting strategies."
  measures:
    - name: "total_campaign_count"
      expr: COUNT(1)
      comment: "Total number of fundraising campaigns. Baseline metric for campaign portfolio size and organizational fundraising activity level."
    - name: "total_raised_amount"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total revenue raised across all campaigns. Primary top-line fundraising performance metric for executive and board reporting."
    - name: "total_goal_amount"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all campaigns. Used alongside total raised to compute goal attainment and assess fundraising ambition vs. performance."
    - name: "total_cost_of_fundraising"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost incurred to raise funds across campaigns. Core efficiency metric — high cost-of-fundraising ratios trigger campaign strategy reviews."
    - name: "avg_roi_percentage"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment percentage across campaigns. Measures fundraising efficiency and is a key metric for campaign investment prioritization."
    - name: "active_campaign_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active campaigns. Tracks the live fundraising portfolio size and organizational capacity utilization."
    - name: "max_roi_percentage"
      expr: MAX(CAST(roi_percentage AS DOUBLE))
      comment: "Highest ROI achieved by any single campaign. Identifies best-performing campaign models to replicate and scale."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising appeal performance metrics tracking response rates, revenue per appeal, cost efficiency, and ROI at the solicitation level. Enables data-driven optimization of appeal design, channel selection, and ask amounts."
  source: "`ngo_ecm`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of fundraising appeal (e.g., acquisition, renewal, upgrade, emergency) for performance benchmarking across appeal categories."
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of the appeal (e.g., active, closed, draft) for pipeline monitoring and operational management."
    - name: "channel"
      expr: channel
      comment: "Solicitation channel used for the appeal (e.g., email, direct mail, telemarketing) for multi-channel performance comparison and budget allocation."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency in which appeal costs are denominated, enabling consistent cost reporting across international fundraising operations."
    - name: "control_group_flag"
      expr: control_group_flag
      comment: "Indicates whether the appeal is a control group in an A/B test, used to isolate treatment effects in appeal optimization experiments."
    - name: "test_segment_flag"
      expr: test_segment_flag
      comment: "Indicates whether the appeal targets a test segment, used to evaluate new appeal strategies before full-scale rollout."
    - name: "mailing_date_month"
      expr: DATE_TRUNC('MONTH', mailing_date)
      comment: "Month the appeal was mailed or deployed, used for seasonal performance analysis and campaign calendar optimization."
    - name: "mailing_date_year"
      expr: YEAR(mailing_date)
      comment: "Year the appeal was deployed, used for year-over-year appeal performance trending and historical benchmarking."
  measures:
    - name: "total_appeal_count"
      expr: COUNT(1)
      comment: "Total number of fundraising appeals executed. Baseline metric for solicitation activity volume and fundraising program scale."
    - name: "total_appeal_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated across all appeals. Primary appeal-level revenue KPI for evaluating solicitation program financial performance."
    - name: "total_appeal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred to execute all appeals. Used to compute cost-per-dollar-raised and evaluate appeal efficiency."
    - name: "avg_response_rate"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average donor response rate across appeals. A key appeal effectiveness metric — declining response rates trigger creative and targeting strategy reviews."
    - name: "avg_roi_ratio"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals. Measures fundraising efficiency at the appeal level to guide channel and format investment decisions."
    - name: "avg_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount across appeals. Tracks ask string strategy and its alignment with donor capacity to optimize gift size outcomes."
    - name: "avg_average_gift_amount"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average of the per-appeal average gift amounts. Provides a portfolio-level view of gift quality and donor upgrade effectiveness across the appeal program."
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total ask amount across all appeals. Represents the aggregate solicitation value deployed and is used to benchmark against total revenue raised."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_prospect`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift prospect pipeline metrics tracking cultivation stage progression, estimated capacity, solicitation amounts, and conversion rates. Drives major gift officer performance management and pipeline investment decisions."
  source: "`ngo_ecm`.`donor`.`prospect`"
  dimensions:
    - name: "prospect_status"
      expr: prospect_status
      comment: "Current status of the prospect (e.g., identified, qualified, cultivating, solicited, closed) for pipeline stage analysis and conversion tracking."
    - name: "prospect_type"
      expr: prospect_type
      comment: "Type of prospect (e.g., individual, foundation, corporate) for portfolio segmentation and tailored cultivation strategy development."
    - name: "stage"
      expr: stage
      comment: "Cultivation stage of the prospect in the major gift pipeline, used for stage-gate conversion analysis and pipeline velocity measurement."
    - name: "research_stage"
      expr: research_stage
      comment: "Stage of prospect research completion, used to prioritize research resources and ensure pipeline readiness for solicitation."
    - name: "program_interest_area"
      expr: program_interest_area
      comment: "Program area of interest for the prospect, used to align solicitation proposals with donor passion and maximize conversion probability."
    - name: "geographic_interest"
      expr: geographic_interest
      comment: "Geographic focus of the prospect's philanthropic interest, used for regional fundraising strategy and country office engagement planning."
    - name: "identification_date_year"
      expr: YEAR(identification_date)
      comment: "Year the prospect was identified, used for prospect cohort analysis and pipeline aging assessment."
    - name: "last_contact_type"
      expr: last_contact_type
      comment: "Type of most recent contact with the prospect (e.g., meeting, call, event) used to assess engagement quality and cultivation progress."
  measures:
    - name: "total_prospect_count"
      expr: COUNT(1)
      comment: "Total number of prospects in the major gift pipeline. Baseline metric for pipeline size and major gift program capacity planning."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across all prospects. Quantifies the addressable major gift opportunity in the pipeline for goal-setting and resource allocation."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per prospect. Tracks pipeline quality — a rising average signals successful identification of higher-capacity prospects."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total ask amount across all active solicitations. Measures the aggregate value of proposals in play and is a leading indicator of near-term major gift revenue."
    - name: "avg_probability_percentage"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average probability of gift conversion across prospects. Used to compute probability-weighted pipeline value and forecast major gift revenue."
    - name: "avg_wealth_screening_score"
      expr: AVG(CAST(wealth_screening_score AS DOUBLE))
      comment: "Average wealth screening score across the prospect pool. Tracks portfolio quality and the effectiveness of prospect identification and research processes."
    - name: "total_estimated_gift_range_max"
      expr: SUM(CAST(estimated_gift_range_max AS DOUBLE))
      comment: "Sum of maximum estimated gift ranges across all prospects. Represents the optimistic ceiling of the major gift pipeline for scenario planning."
    - name: "total_estimated_gift_range_min"
      expr: SUM(CAST(estimated_gift_range_min AS DOUBLE))
      comment: "Sum of minimum estimated gift ranges across all prospects. Represents the conservative floor of the major gift pipeline for downside scenario planning."
    - name: "converted_prospect_count"
      expr: COUNT(CASE WHEN conversion_date IS NOT NULL THEN 1 END)
      comment: "Number of prospects who have converted to donors. Tracks major gift pipeline conversion effectiveness and major gift officer performance."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics tracking revenue, cost, net return, attendance, and goal attainment. Enables data-driven decisions on event investment, format (virtual vs. in-person), and portfolio prioritization."
  source: "`ngo_ecm`.`donor`.`fundraising_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of fundraising event (e.g., gala, auction, walkathon, webinar) for performance benchmarking across event formats."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event (e.g., planned, active, completed, cancelled) for event pipeline monitoring and operational management."
    - name: "is_virtual_event"
      expr: is_virtual_event
      comment: "Indicates whether the event is virtual or in-person, used to compare ROI and engagement outcomes across event delivery formats."
    - name: "is_tax_deductible"
      expr: is_tax_deductible
      comment: "Indicates whether event ticket purchases are tax-deductible, relevant for donor communication and IRS compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which event financials are denominated for consistent multi-currency event portfolio reporting."
    - name: "venue_country_code"
      expr: venue_country_code
      comment: "Country where the event is held, used for geographic fundraising analysis and country office event performance tracking."
    - name: "event_date_year"
      expr: YEAR(event_date)
      comment: "Year the event took place, used for year-over-year event performance trending and annual event calendar planning."
    - name: "event_date_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month the event took place, used for seasonal event performance analysis and optimal event scheduling decisions."
  measures:
    - name: "total_event_count"
      expr: COUNT(1)
      comment: "Total number of fundraising events. Baseline metric for event program scale and organizational event capacity utilization."
    - name: "total_revenue_raised"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total gross revenue raised across all fundraising events. Primary event revenue KPI for executive reporting and event portfolio valuation."
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost incurred to execute all fundraising events. Used to compute net event revenue and cost-per-dollar-raised efficiency metrics."
    - name: "total_net_revenue"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net revenue after event costs. The definitive event profitability metric — negative net revenue triggers event format and cost structure reviews."
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across all events. Used alongside total revenue raised to compute event goal attainment rates."
    - name: "avg_net_revenue_per_event"
      expr: AVG(CAST(net_revenue AS DOUBLE))
      comment: "Average net revenue per fundraising event. Tracks event portfolio efficiency and informs decisions on which event types to scale or discontinue."
    - name: "avg_tax_deductible_percentage"
      expr: AVG(CAST(tax_deductible_percentage AS DOUBLE))
      comment: "Average tax-deductible percentage of event ticket prices. Used for donor communication, IRS quid pro quo compliance, and gift acknowledgement accuracy."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor fund portfolio metrics tracking fund balances, restriction compliance, cost share obligations, and fund lifecycle health. Essential for fund stewardship, compliance reporting, and restricted fund management."
  source: "`ngo_ecm`.`donor`.`donor_fund`"
  dimensions:
    - name: "fund_type"
      expr: fund_type
      comment: "Type of donor fund (e.g., restricted, unrestricted, endowment, emergency) for portfolio segmentation and compliance monitoring."
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of the fund (e.g., active, closed, suspended) for fund lifecycle management and portfolio health monitoring."
    - name: "fund_category"
      expr: fund_category
      comment: "Category of the fund (e.g., humanitarian, development, advocacy) for programmatic alignment analysis and strategic portfolio review."
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction on fund usage (e.g., purpose-restricted, time-restricted, unrestricted) for compliance planning and fund utilization reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the fund is denominated for multi-currency fund portfolio valuation and reporting."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the fund's intended use (e.g., global, regional, country-specific) for geographic portfolio analysis."
    - name: "sdg_alignment"
      expr: sdg_alignment
      comment: "UN SDG alignment of the fund for impact reporting to SDG-focused donors and compliance with grant reporting requirements."
    - name: "reporting_frequency"
      expr: reporting_frequency
      comment: "Required reporting frequency for the fund (e.g., quarterly, annual) for stewardship planning and compliance calendar management."
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "OECD DAC sector code for the fund, required for ODA-eligible grant reporting and bilateral donor compliance."
    - name: "inception_date_year"
      expr: YEAR(inception_date)
      comment: "Year the fund was established, used for fund cohort analysis and portfolio aging assessment."
    - name: "cost_share_required"
      expr: cost_share_required
      comment: "Indicates whether the fund requires a cost-share contribution from the organization, used to track co-financing obligations and compliance risk."
    - name: "audit_required"
      expr: audit_required
      comment: "Indicates whether the fund requires an independent audit, used for compliance planning and audit resource allocation."
  measures:
    - name: "total_fund_count"
      expr: COUNT(1)
      comment: "Total number of donor funds under management. Baseline metric for fund portfolio scale and stewardship workload assessment."
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total balance across all donor funds. Primary fund portfolio valuation metric for treasury management and financial sustainability reporting."
    - name: "avg_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per donor fund. Tracks fund portfolio health and identifies funds at risk of depletion requiring donor re-engagement."
    - name: "total_minimum_gift_amount"
      expr: SUM(CAST(minimum_gift_amount AS DOUBLE))
      comment: "Sum of minimum gift thresholds across all funds. Used to assess the aggregate minimum fundraising commitment required to maintain fund compliance."
    - name: "avg_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost recovery rate across donor funds. Tracks organizational cost recovery performance and negotiated overhead rates with funders."
    - name: "avg_cost_share_percentage"
      expr: AVG(CAST(cost_share_percentage AS DOUBLE))
      comment: "Average cost-share percentage required across funds with co-financing obligations. Used to quantify the organization's aggregate co-financing burden."
    - name: "active_fund_count"
      expr: COUNT(CASE WHEN fund_status = 'Active' THEN 1 END)
      comment: "Number of currently active donor funds. Tracks the live fund portfolio size and stewardship team workload."
    - name: "audit_required_fund_count"
      expr: COUNT(CASE WHEN audit_required = TRUE THEN 1 END)
      comment: "Number of funds requiring independent audits. Drives audit planning, resource allocation, and compliance risk management."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_portfolio_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift officer portfolio metrics tracking assignment load, capacity estimates, expected ask pipeline, and engagement readiness. Drives major gift team performance management, portfolio rebalancing, and solicitation prioritization."
  source: "`ngo_ecm`.`donor`.`portfolio_assignment`"
  dimensions:
    - name: "portfolio_status"
      expr: portfolio_status
      comment: "Current status of the portfolio assignment (e.g., active, inactive, transferred) for portfolio health monitoring and officer workload management."
    - name: "portfolio_tier"
      expr: portfolio_tier
      comment: "Tier of the portfolio assignment (e.g., major gift, mid-level, planned giving) for tiered resource allocation and performance benchmarking."
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current solicitation stage of the assignment (e.g., identification, cultivation, solicitation, stewardship) for pipeline stage analysis."
    - name: "geographic_territory"
      expr: geographic_territory
      comment: "Geographic territory of the portfolio assignment for regional fundraising performance analysis and territory management decisions."
    - name: "affinity_focus_area"
      expr: affinity_focus_area
      comment: "Donor's primary affinity or program interest area, used to align solicitation strategies with donor passion and maximize conversion rates."
    - name: "portfolio_priority_rank"
      expr: portfolio_priority_rank
      comment: "Priority ranking of the assignment within the portfolio, used to focus major gift officer time on highest-value cultivation opportunities."
    - name: "engagement_readiness_indicator"
      expr: engagement_readiness_indicator
      comment: "Indicator of the donor's readiness for solicitation, used to time asks appropriately and maximize conversion probability."
    - name: "assignment_date_year"
      expr: YEAR(assignment_date)
      comment: "Year the portfolio assignment was made, used for cohort analysis of assignment outcomes and officer performance over time."
    - name: "proposal_submitted_flag"
      expr: proposal_submitted_flag
      comment: "Indicates whether a formal proposal has been submitted to the donor, used to track solicitation pipeline progression and close rate analysis."
  measures:
    - name: "total_assignment_count"
      expr: COUNT(1)
      comment: "Total number of portfolio assignments. Baseline metric for major gift officer workload and portfolio coverage analysis."
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Total estimated giving capacity across all portfolio assignments. Quantifies the aggregate major gift opportunity managed by the team."
    - name: "avg_estimated_capacity"
      expr: AVG(CAST(estimated_capacity_amount AS DOUBLE))
      comment: "Average estimated giving capacity per portfolio assignment. Tracks portfolio quality and the effectiveness of prospect identification and assignment processes."
    - name: "total_expected_ask_amount"
      expr: SUM(CAST(expected_ask_amount AS DOUBLE))
      comment: "Total expected ask amount across all active portfolio assignments. Represents the aggregate solicitation pipeline value and is a leading indicator of major gift revenue."
    - name: "avg_portfolio_load_weight"
      expr: AVG(CAST(portfolio_load_weight AS DOUBLE))
      comment: "Average portfolio load weight per assignment. Used to assess major gift officer workload balance and identify over- or under-loaded portfolios."
    - name: "total_lifetime_giving_amount"
      expr: SUM(CAST(total_lifetime_giving_amount AS DOUBLE))
      comment: "Total lifetime giving across all constituents in managed portfolios. Measures the historical value of the major gift portfolio under active management."
    - name: "avg_last_gift_amount"
      expr: AVG(CAST(last_gift_amount AS DOUBLE))
      comment: "Average most recent gift amount across portfolio assignments. Tracks recent donor generosity trends and informs next ask amount calibration."
    - name: "proposal_submitted_count"
      expr: COUNT(CASE WHEN proposal_submitted_flag = TRUE THEN 1 END)
      comment: "Number of portfolio assignments with a submitted proposal. Tracks solicitation activity volume and major gift officer productivity."
    - name: "distinct_managed_constituent_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents under active portfolio management. Measures the breadth of the major gift relationship management program."
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_stewardship_activity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor stewardship activity metrics tracking engagement volume, cost, solicitation activity, and follow-up compliance. Drives stewardship program effectiveness evaluation and major gift relationship management decisions."
  source: "`ngo_ecm`.`donor`.`stewardship_activity`"
  dimensions:
    - name: "activity_type"
      expr: activity_type
      comment: "Type of stewardship activity (e.g., site visit, impact report, thank-you call, event invitation) for activity mix analysis and stewardship strategy optimization."
    - name: "activity_status"
      expr: activity_status
      comment: "Current status of the stewardship activity (e.g., planned, completed, cancelled) for pipeline monitoring and follow-through compliance tracking."
    - name: "communication_channel"
      expr: communication_channel
      comment: "Channel used for the stewardship activity (e.g., email, phone, in-person, mail) for channel effectiveness analysis and preference alignment."
    - name: "donor_sentiment"
      expr: donor_sentiment
      comment: "Recorded donor sentiment following the activity (e.g., positive, neutral, negative) for relationship health monitoring and early warning detection."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the stewardship activity, used to ensure high-value donor relationships receive appropriate attention and resource investment."
    - name: "stewardship_plan_stage"
      expr: stewardship_plan_stage
      comment: "Stage within the stewardship plan (e.g., acknowledgement, impact reporting, cultivation) for plan progression tracking and compliance monitoring."
    - name: "activity_date_month"
      expr: DATE_TRUNC('MONTH', activity_date)
      comment: "Month the stewardship activity occurred, used for activity volume trending and stewardship calendar management."
    - name: "activity_date_year"
      expr: YEAR(activity_date)
      comment: "Year the stewardship activity occurred, used for annual stewardship program performance reporting."
    - name: "follow_up_required_flag"
      expr: follow_up_required_flag
      comment: "Indicates whether a follow-up action is required, used to monitor stewardship compliance and ensure no donor relationship falls through the cracks."
    - name: "solicitation_made_flag"
      expr: solicitation_made_flag
      comment: "Indicates whether a solicitation was made during the activity, used to track ask frequency and stewardship-to-solicitation conversion patterns."
    - name: "impact_story_shared_flag"
      expr: impact_story_shared_flag
      comment: "Indicates whether an impact story was shared during the activity, used to measure impact communication frequency and its correlation with donor retention."
    - name: "acknowledgement_sent_flag"
      expr: acknowledgement_sent_flag
      comment: "Indicates whether a gift acknowledgement was sent, used to monitor acknowledgement compliance and timeliness as a donor retention driver."
  measures:
    - name: "total_activity_count"
      expr: COUNT(1)
      comment: "Total number of stewardship activities recorded. Baseline metric for stewardship program activity volume and team productivity tracking."
    - name: "total_stewardship_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost incurred for stewardship activities. Tracks cost-of-stewardship and informs ROI analysis of donor relationship investment."
    - name: "avg_stewardship_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per stewardship activity. Used to benchmark stewardship efficiency and identify high-cost activity types for optimization."
    - name: "total_solicitation_amount"
      expr: SUM(CAST(solicitation_amount AS DOUBLE))
      comment: "Total ask amount across all solicitations made during stewardship activities. Tracks the revenue pipeline generated through relationship management activities."
    - name: "distinct_constituent_touched_count"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique constituents who received at least one stewardship touch. Measures stewardship program reach and coverage of the donor portfolio."
    - name: "follow_up_required_count"
      expr: COUNT(CASE WHEN follow_up_required_flag = TRUE THEN 1 END)
      comment: "Number of activities with outstanding follow-up actions required. Tracks stewardship compliance backlog and risk of donor relationship neglect."
    - name: "solicitation_activity_count"
      expr: COUNT(CASE WHEN solicitation_made_flag = TRUE THEN 1 END)
      comment: "Number of stewardship activities that included a solicitation. Tracks ask frequency within the stewardship program and informs cultivation-to-solicitation timing strategy."
    - name: "impact_story_shared_count"
      expr: COUNT(CASE WHEN impact_story_shared_flag = TRUE THEN 1 END)
      comment: "Number of activities where an impact story was shared with the donor. Measures impact communication frequency, a key driver of donor retention and upgrade."
$$;