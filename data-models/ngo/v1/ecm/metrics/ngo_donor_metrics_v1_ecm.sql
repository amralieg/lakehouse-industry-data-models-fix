-- Metric views for domain: donor | Business: Ngo | Version: 1 | Generated on: 2026-05-07 01:23:35

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_gift`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core fundraising revenue and gift performance metrics tracking donations, matching gifts, and donor contribution patterns"
  source: "`ngo_ecm`.`donor`.`gift`"
  dimensions:
    - name: "gift_date"
      expr: gift_date
      comment: "Date the gift was received"
    - name: "gift_year"
      expr: YEAR(gift_date)
      comment: "Calendar year of gift receipt"
    - name: "gift_month"
      expr: DATE_TRUNC('MONTH', gift_date)
      comment: "Month of gift receipt for trend analysis"
    - name: "gift_type"
      expr: gift_type
      comment: "Type of gift (cash, in-kind, stock, etc.)"
    - name: "gift_status"
      expr: gift_status
      comment: "Current status of the gift (completed, pending, refunded)"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment (credit card, check, wire, etc.)"
    - name: "payment_channel"
      expr: payment_channel
      comment: "Channel through which gift was received (online, mail, event, etc.)"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction on gift use (unrestricted, restricted, temporarily restricted)"
    - name: "is_matching_gift"
      expr: matching_gift_flag
      comment: "Whether this gift is a matching gift from an employer"
    - name: "is_anonymous"
      expr: anonymous_flag
      comment: "Whether the donor requested anonymity"
    - name: "is_tribute_gift"
      expr: tribute_flag
      comment: "Whether this gift is in honor or memory of someone"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the gift was received"
    - name: "acknowledgement_type"
      expr: acknowledgement_type
      comment: "Type of acknowledgement sent to donor"
  measures:
    - name: "total_gift_revenue"
      expr: SUM(CAST(amount AS DOUBLE))
      comment: "Total gross gift revenue before fees"
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net gift revenue after processing fees"
    - name: "total_processing_fees"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total payment processing fees incurred"
    - name: "average_gift_amount"
      expr: AVG(CAST(amount AS DOUBLE))
      comment: "Average gift size across all donations"
    - name: "gift_count"
      expr: COUNT(gift_id)
      comment: "Total number of gifts received"
    - name: "unique_donors"
      expr: COUNT(DISTINCT gift_constituent_id)
      comment: "Number of unique donors who made gifts"
    - name: "matching_gift_revenue"
      expr: SUM(CASE WHEN matching_gift_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from employer matching gifts"
    - name: "matching_gift_count"
      expr: COUNT(CASE WHEN matching_gift_flag = TRUE THEN gift_id END)
      comment: "Number of matching gifts received"
    - name: "refunded_revenue"
      expr: SUM(CASE WHEN refund_flag = TRUE THEN CAST(amount AS DOUBLE) ELSE 0 END)
      comment: "Total revenue from gifts that were refunded"
    - name: "refund_count"
      expr: COUNT(CASE WHEN refund_flag = TRUE THEN gift_id END)
      comment: "Number of gifts that were refunded"
    - name: "fee_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(fee_amount AS DOUBLE)) / NULLIF(SUM(CAST(amount AS DOUBLE)), 0), 2)
      comment: "Average processing fee rate as percentage of gross revenue"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_pledge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pledge commitment and fulfillment metrics tracking donor promises, payment schedules, and pledge completion rates"
  source: "`ngo_ecm`.`donor`.`pledge`"
  dimensions:
    - name: "pledge_date"
      expr: pledge_date
      comment: "Date the pledge commitment was made"
    - name: "pledge_year"
      expr: YEAR(pledge_date)
      comment: "Calendar year of pledge commitment"
    - name: "pledge_month"
      expr: DATE_TRUNC('MONTH', pledge_date)
      comment: "Month of pledge commitment"
    - name: "pledge_status"
      expr: pledge_status
      comment: "Current status of pledge (active, fulfilled, cancelled, written off)"
    - name: "pledge_type"
      expr: pledge_type
      comment: "Type of pledge commitment"
    - name: "is_recurring"
      expr: is_recurring
      comment: "Whether this is a recurring pledge"
    - name: "installment_frequency"
      expr: installment_frequency
      comment: "Frequency of pledge installment payments"
    - name: "payment_method"
      expr: payment_method
      comment: "Method for pledge payments"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of pledge commitment"
  measures:
    - name: "total_pledged_amount"
      expr: SUM(CAST(total_pledge_amount AS DOUBLE))
      comment: "Total value of all pledge commitments"
    - name: "total_amount_paid"
      expr: SUM(CAST(amount_paid AS DOUBLE))
      comment: "Total amount paid against pledges"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(balance_outstanding AS DOUBLE))
      comment: "Total remaining balance on active pledges"
    - name: "total_written_off"
      expr: SUM(CAST(write_off_amount AS DOUBLE))
      comment: "Total pledge amount written off as uncollectible"
    - name: "pledge_count"
      expr: COUNT(pledge_id)
      comment: "Total number of pledges made"
    - name: "unique_pledging_donors"
      expr: COUNT(DISTINCT constituent_id)
      comment: "Number of unique donors who made pledges"
    - name: "average_pledge_amount"
      expr: AVG(CAST(total_pledge_amount AS DOUBLE))
      comment: "Average size of pledge commitments"
    - name: "fulfillment_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(amount_paid AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of pledged amount that has been paid"
    - name: "write_off_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(write_off_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_pledge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of pledged amount written off"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance and ROI metrics tracking fundraising campaign effectiveness, goal attainment, and cost efficiency"
  source: "`ngo_ecm`.`donor`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the fundraising campaign"
    - name: "campaign_code"
      expr: campaign_code
      comment: "Unique code identifying the campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (annual, capital, special appeal, etc.)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of campaign (active, completed, cancelled)"
    - name: "start_date"
      expr: start_date
      comment: "Campaign start date"
    - name: "end_date"
      expr: end_date
      comment: "Campaign end date"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year campaign started"
    - name: "appeal_channel"
      expr: appeal_channel
      comment: "Primary channel used for campaign appeals"
    - name: "target_audience_segment"
      expr: target_audience_segment
      comment: "Target donor segment for campaign"
    - name: "is_active"
      expr: is_active
      comment: "Whether campaign is currently active"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for campaign financial metrics"
  measures:
    - name: "total_raised"
      expr: SUM(CAST(total_raised_amount AS DOUBLE))
      comment: "Total revenue raised by campaigns"
    - name: "total_goal"
      expr: SUM(CAST(goal_amount AS DOUBLE))
      comment: "Total fundraising goal across campaigns"
    - name: "total_fundraising_cost"
      expr: SUM(CAST(cost_of_fundraising AS DOUBLE))
      comment: "Total cost of fundraising activities"
    - name: "campaign_count"
      expr: COUNT(campaign_id)
      comment: "Number of campaigns"
    - name: "average_campaign_revenue"
      expr: AVG(CAST(total_raised_amount AS DOUBLE))
      comment: "Average revenue per campaign"
    - name: "goal_attainment_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(total_raised_amount AS DOUBLE)) / NULLIF(SUM(CAST(goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved"
    - name: "average_roi_percent"
      expr: AVG(CAST(roi_percentage AS DOUBLE))
      comment: "Average return on investment across campaigns"
    - name: "cost_to_raise_dollar"
      expr: ROUND(SUM(CAST(cost_of_fundraising AS DOUBLE)) / NULLIF(SUM(CAST(total_raised_amount AS DOUBLE)), 0), 3)
      comment: "Cost to raise one dollar of revenue"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_constituent`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor constituent engagement and lifetime value metrics tracking donor relationships, giving capacity, and retention patterns"
  source: "`ngo_ecm`.`donor`.`constituent`"
  dimensions:
    - name: "constituent_type"
      expr: constituent_type
      comment: "Type of constituent (individual, foundation, corporation, etc.)"
    - name: "relationship_tier"
      expr: relationship_tier
      comment: "Relationship tier or donor level"
    - name: "funder_classification"
      expr: funder_classification
      comment: "Classification of funder type"
    - name: "record_status"
      expr: record_status
      comment: "Status of constituent record (active, inactive, deceased)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for constituent"
    - name: "first_gift_year"
      expr: YEAR(first_gift_date)
      comment: "Year of first gift for donor acquisition cohort analysis"
    - name: "is_deceased"
      expr: deceased_flag
      comment: "Whether constituent is deceased"
    - name: "has_gdpr_consent"
      expr: gdpr_consent_flag
      comment: "Whether constituent has provided GDPR consent"
    - name: "email_opt_in"
      expr: email_opt_in_flag
      comment: "Whether constituent has opted in to email communications"
    - name: "is_dac_member"
      expr: dac_member_flag
      comment: "Whether constituent is a DAC (Development Assistance Committee) member"
  measures:
    - name: "total_lifetime_value"
      expr: SUM(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Total lifetime giving across all constituents"
    - name: "total_estimated_capacity"
      expr: SUM(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Total estimated giving capacity across constituents"
    - name: "total_largest_gifts"
      expr: SUM(CAST(largest_gift_amount AS DOUBLE))
      comment: "Sum of largest single gifts from each constituent"
    - name: "constituent_count"
      expr: COUNT(constituent_id)
      comment: "Total number of constituents"
    - name: "active_donor_count"
      expr: COUNT(CASE WHEN first_gift_date IS NOT NULL THEN constituent_id END)
      comment: "Number of constituents who have made at least one gift"
    - name: "average_lifetime_value"
      expr: AVG(CAST(lifetime_giving_total AS DOUBLE))
      comment: "Average lifetime giving per constituent"
    - name: "average_estimated_capacity"
      expr: AVG(CAST(estimated_giving_capacity AS DOUBLE))
      comment: "Average estimated giving capacity per constituent"
    - name: "donor_conversion_rate_percent"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_gift_date IS NOT NULL THEN constituent_id END) / NULLIF(COUNT(constituent_id), 0), 2)
      comment: "Percentage of constituents who have become donors"
    - name: "capacity_utilization_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(lifetime_giving_total AS DOUBLE)) / NULLIF(SUM(CAST(estimated_giving_capacity AS DOUBLE)), 0), 2)
      comment: "Percentage of estimated capacity that has been realized as gifts"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_major_gift_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Major gift pipeline and conversion metrics tracking high-value donor prospects, solicitation stages, and expected revenue"
  source: "`ngo_ecm`.`donor`.`major_gift_opportunity`"
  dimensions:
    - name: "opportunity_name"
      expr: opportunity_name
      comment: "Name of the major gift opportunity"
    - name: "solicitation_stage"
      expr: solicitation_stage
      comment: "Current stage in the solicitation process"
    - name: "gift_type"
      expr: gift_type
      comment: "Type of major gift being solicited"
    - name: "gift_purpose"
      expr: gift_purpose
      comment: "Purpose or designation of the gift"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of restriction on gift use"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year for opportunity tracking"
    - name: "expected_close_year"
      expr: YEAR(expected_close_date)
      comment: "Expected year of opportunity close"
    - name: "is_active"
      expr: is_active
      comment: "Whether opportunity is currently active"
    - name: "is_anonymous"
      expr: is_anonymous
      comment: "Whether donor has requested anonymity"
    - name: "source_channel"
      expr: source_channel
      comment: "Channel through which opportunity was sourced"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for opportunity amounts"
  measures:
    - name: "total_ask_amount"
      expr: SUM(CAST(ask_amount AS DOUBLE))
      comment: "Total amount being asked across all opportunities"
    - name: "total_expected_revenue"
      expr: SUM(CAST(expected_gift_amount AS DOUBLE))
      comment: "Total expected gift amount across opportunities"
    - name: "total_weighted_value"
      expr: SUM(CAST(weighted_value AS DOUBLE))
      comment: "Total probability-weighted pipeline value"
    - name: "opportunity_count"
      expr: COUNT(major_gift_opportunity_id)
      comment: "Number of major gift opportunities in pipeline"
    - name: "average_ask_amount"
      expr: AVG(CAST(ask_amount AS DOUBLE))
      comment: "Average ask amount per opportunity"
    - name: "average_probability"
      expr: AVG(CAST(probability_percentage AS DOUBLE))
      comment: "Average probability of close across opportunities"
    - name: "pipeline_conversion_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(expected_gift_amount AS DOUBLE)) / NULLIF(SUM(CAST(ask_amount AS DOUBLE)), 0), 2)
      comment: "Expected conversion rate of ask to expected gift amount"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_fundraising_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fundraising event performance metrics tracking event revenue, attendance, costs, and net proceeds"
  source: "`ngo_ecm`.`donor`.`fundraising_event`"
  dimensions:
    - name: "event_name"
      expr: event_name
      comment: "Name of the fundraising event"
    - name: "event_code"
      expr: event_code
      comment: "Unique code for the event"
    - name: "event_type"
      expr: event_type
      comment: "Type of fundraising event (gala, auction, walk, etc.)"
    - name: "event_status"
      expr: event_status
      comment: "Current status of event (planned, active, completed, cancelled)"
    - name: "event_date"
      expr: event_date
      comment: "Date the event took place"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year of event"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of event"
    - name: "is_virtual"
      expr: is_virtual_event
      comment: "Whether event was held virtually"
    - name: "venue_city"
      expr: venue_city
      comment: "City where event was held"
    - name: "venue_country"
      expr: venue_country_code
      comment: "Country where event was held"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for event financial metrics"
  measures:
    - name: "total_event_revenue"
      expr: SUM(CAST(total_revenue_raised AS DOUBLE))
      comment: "Total gross revenue raised from events"
    - name: "total_event_cost"
      expr: SUM(CAST(total_event_cost AS DOUBLE))
      comment: "Total cost of producing events"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_revenue AS DOUBLE))
      comment: "Total net proceeds after event costs"
    - name: "total_fundraising_goal"
      expr: SUM(CAST(fundraising_goal_amount AS DOUBLE))
      comment: "Total fundraising goal across events"
    - name: "event_count"
      expr: COUNT(fundraising_event_id)
      comment: "Number of fundraising events"
    - name: "average_event_revenue"
      expr: AVG(CAST(total_revenue_raised AS DOUBLE))
      comment: "Average revenue per event"
    - name: "average_net_proceeds"
      expr: AVG(CAST(net_revenue AS DOUBLE))
      comment: "Average net proceeds per event"
    - name: "event_roi_percent"
      expr: ROUND(100.0 * SUM(CAST(net_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_event_cost AS DOUBLE)), 0), 2)
      comment: "Return on investment for events as percentage"
    - name: "goal_achievement_rate_percent"
      expr: ROUND(100.0 * SUM(CAST(total_revenue_raised AS DOUBLE)) / NULLIF(SUM(CAST(fundraising_goal_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of fundraising goal achieved"
    - name: "cost_ratio_percent"
      expr: ROUND(100.0 * SUM(CAST(total_event_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue_raised AS DOUBLE)), 0), 2)
      comment: "Event cost as percentage of gross revenue"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_fund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Donor-restricted fund balance and compliance metrics tracking fund balances, restrictions, and spending policies"
  source: "`ngo_ecm`.`donor`.`donor_fund`"
  dimensions:
    - name: "fund_name"
      expr: fund_name
      comment: "Name of the donor fund"
    - name: "fund_code"
      expr: fund_code
      comment: "Unique code for the fund"
    - name: "fund_type"
      expr: fund_type
      comment: "Type of fund (endowment, restricted, unrestricted, etc.)"
    - name: "fund_status"
      expr: fund_status
      comment: "Current status of fund (active, closed, suspended)"
    - name: "fund_category"
      expr: fund_category
      comment: "Category of fund"
    - name: "restriction_type"
      expr: restriction_type
      comment: "Type of donor restriction on fund use"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of fund activities"
    - name: "dac_sector_code"
      expr: dac_sector_code
      comment: "DAC sector code for fund classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for fund balances"
    - name: "inception_year"
      expr: YEAR(inception_date)
      comment: "Year fund was established"
    - name: "is_audit_required"
      expr: audit_required
      comment: "Whether fund requires separate audit"
  measures:
    - name: "total_fund_balance"
      expr: SUM(CAST(balance AS DOUBLE))
      comment: "Total current balance across all donor funds"
    - name: "fund_count"
      expr: COUNT(donor_fund_id)
      comment: "Number of donor funds"
    - name: "average_fund_balance"
      expr: AVG(CAST(balance AS DOUBLE))
      comment: "Average balance per fund"
    - name: "average_indirect_cost_rate"
      expr: AVG(CAST(indirect_cost_rate AS DOUBLE))
      comment: "Average indirect cost rate across funds"
$$;

CREATE OR REPLACE VIEW `ngo_ecm`.`_metrics`.`donor_appeal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appeal campaign effectiveness metrics tracking response rates, ROI, and cost per acquisition across fundraising appeals"
  source: "`ngo_ecm`.`donor`.`appeal`"
  dimensions:
    - name: "appeal_name"
      expr: appeal_name
      comment: "Name of the fundraising appeal"
    - name: "appeal_code"
      expr: appeal_code
      comment: "Unique code for the appeal"
    - name: "appeal_type"
      expr: appeal_type
      comment: "Type of appeal (direct mail, email, phone, etc.)"
    - name: "appeal_status"
      expr: appeal_status
      comment: "Current status of appeal"
    - name: "channel"
      expr: channel
      comment: "Communication channel used for appeal"
    - name: "mailing_date"
      expr: mailing_date
      comment: "Date appeal was sent"
    - name: "mailing_year"
      expr: YEAR(mailing_date)
      comment: "Year appeal was sent"
    - name: "is_control_group"
      expr: control_group_flag
      comment: "Whether this is a control group for testing"
    - name: "is_test_segment"
      expr: test_segment_flag
      comment: "Whether this is a test segment"
    - name: "cost_currency"
      expr: cost_currency_code
      comment: "Currency for appeal costs"
    - name: "revenue_currency"
      expr: revenue_currency_code
      comment: "Currency for appeal revenue"
  measures:
    - name: "total_appeal_revenue"
      expr: SUM(CAST(total_revenue_amount AS DOUBLE))
      comment: "Total revenue generated from appeals"
    - name: "total_appeal_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of producing and distributing appeals"
    - name: "appeal_count"
      expr: COUNT(appeal_id)
      comment: "Number of appeals executed"
    - name: "average_response_rate"
      expr: AVG(CAST(response_rate_percent AS DOUBLE))
      comment: "Average response rate across appeals"
    - name: "average_roi"
      expr: AVG(CAST(roi_ratio AS DOUBLE))
      comment: "Average return on investment ratio across appeals"
    - name: "average_gift_per_appeal"
      expr: AVG(CAST(average_gift_amount AS DOUBLE))
      comment: "Average gift amount per appeal"
    - name: "blended_roi_ratio"
      expr: ROUND(SUM(CAST(total_revenue_amount AS DOUBLE)) / NULLIF(SUM(CAST(cost_amount AS DOUBLE)), 0), 2)
      comment: "Blended ROI ratio across all appeals"
$$;