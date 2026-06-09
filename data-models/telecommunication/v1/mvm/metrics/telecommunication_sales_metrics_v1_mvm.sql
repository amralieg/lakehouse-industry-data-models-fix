-- Metric views for domain: sales | Business: Telecommunication | Version: 1 | Generated on: 2026-05-08 08:27:22

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign performance metrics tracking spend efficiency, response rates, and ROI for marketing campaigns"
  source: "`telecommunication_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "campaign_name"
      expr: campaign_name
      comment: "Name of the marketing campaign"
    - name: "campaign_type"
      expr: campaign_type
      comment: "Type of campaign (e.g., acquisition, retention, upsell)"
    - name: "campaign_status"
      expr: campaign_status
      comment: "Current status of the campaign"
    - name: "target_audience"
      expr: target_audience
      comment: "Target audience segment for the campaign"
    - name: "campaign_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when campaign started"
    - name: "campaign_start_quarter"
      expr: DATE_TRUNC('QUARTER', start_date)
      comment: "Quarter when campaign started"
    - name: "priority"
      expr: priority
      comment: "Campaign priority level"
  measures:
    - name: "total_campaign_spend"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend across all campaigns"
    - name: "total_campaign_budget"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount across all campaigns"
    - name: "avg_campaign_roi"
      expr: AVG(CAST(roi_percent AS DOUBLE))
      comment: "Average return on investment percentage across campaigns"
    - name: "avg_actual_response_rate"
      expr: AVG(CAST(actual_response_rate AS DOUBLE))
      comment: "Average actual response rate achieved across campaigns"
    - name: "avg_cost_per_acquisition"
      expr: AVG(CAST(cost_per_acquisition AS DOUBLE))
      comment: "Average cost to acquire a customer across campaigns"
    - name: "campaign_count"
      expr: COUNT(DISTINCT campaign_id)
      comment: "Number of distinct campaigns"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead generation and conversion metrics tracking lead quality, velocity, and conversion performance"
  source: "`telecommunication_ecm`.`sales`.`lead`"
  dimensions:
    - name: "lead_status"
      expr: lead_status
      comment: "Current status of the lead"
    - name: "lead_source"
      expr: lead_source
      comment: "Source channel where lead originated"
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the lead"
    - name: "grade"
      expr: grade
      comment: "Lead grade indicating quality"
    - name: "priority"
      expr: priority
      comment: "Lead priority level"
    - name: "interest_service_type"
      expr: interest_service_type
      comment: "Type of service the lead is interested in"
    - name: "lead_created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when lead was created"
    - name: "conversion_month"
      expr: DATE_TRUNC('MONTH', conversion_date)
      comment: "Month when lead was converted"
  measures:
    - name: "total_leads"
      expr: COUNT(DISTINCT lead_id)
      comment: "Total number of distinct leads"
    - name: "converted_leads"
      expr: COUNT(DISTINCT CASE WHEN conversion_date IS NOT NULL THEN lead_id END)
      comment: "Number of leads that converted to opportunities"
    - name: "avg_estimated_contract_value"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value across leads"
    - name: "total_estimated_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all leads"
    - name: "avg_estimated_monthly_value"
      expr: AVG(CAST(estimated_monthly_value AS DOUBLE))
      comment: "Average estimated monthly recurring value across leads"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales opportunity pipeline metrics tracking deal value, win rates, and sales velocity"
  source: "`telecommunication_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "sales_stage"
      expr: sales_stage
      comment: "Current stage of the sales opportunity"
    - name: "opportunity_type"
      expr: opportunity_type
      comment: "Type of opportunity (new business, upsell, renewal)"
    - name: "forecast_category"
      expr: forecast_category
      comment: "Forecast category for pipeline management"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for the opportunity"
    - name: "product_category"
      expr: product_category
      comment: "Product category being sold"
    - name: "technology_type"
      expr: technology_type
      comment: "Technology type for the opportunity"
    - name: "competitive_threat_level"
      expr: competitive_threat_level
      comment: "Level of competitive threat"
    - name: "credit_check_status"
      expr: credit_check_status
      comment: "Status of credit check"
    - name: "expected_close_month"
      expr: DATE_TRUNC('MONTH', expected_close_date)
      comment: "Month when opportunity is expected to close"
    - name: "actual_close_month"
      expr: DATE_TRUNC('MONTH', actual_close_date)
      comment: "Month when opportunity actually closed"
  measures:
    - name: "total_opportunities"
      expr: COUNT(DISTINCT opportunity_id)
      comment: "Total number of distinct opportunities"
    - name: "total_pipeline_value"
      expr: SUM(CAST(estimated_contract_value AS DOUBLE))
      comment: "Total estimated contract value across all opportunities"
    - name: "total_estimated_mrr"
      expr: SUM(CAST(estimated_mrr AS DOUBLE))
      comment: "Total estimated monthly recurring revenue across opportunities"
    - name: "avg_deal_size"
      expr: AVG(CAST(estimated_contract_value AS DOUBLE))
      comment: "Average estimated contract value per opportunity"
    - name: "total_one_time_revenue"
      expr: SUM(CAST(estimated_one_time_revenue AS DOUBLE))
      comment: "Total estimated one-time revenue across opportunities"
    - name: "avg_deposit_required"
      expr: AVG(CAST(deposit_required_amount AS DOUBLE))
      comment: "Average deposit amount required across opportunities"
    - name: "closed_won_opportunities"
      expr: COUNT(DISTINCT CASE WHEN actual_close_date IS NOT NULL AND sales_stage = 'Closed Won' THEN opportunity_id END)
      comment: "Number of opportunities closed and won"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote performance metrics tracking quote value, conversion rates, and win/loss analysis"
  source: "`telecommunication_ecm`.`sales`.`quote`"
  dimensions:
    - name: "quote_status"
      expr: quote_status
      comment: "Current status of the quote"
    - name: "quote_type"
      expr: quote_type
      comment: "Type of quote"
    - name: "customer_segment"
      expr: customer_segment
      comment: "Customer segment for the quote"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the quote"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason for quote rejection if applicable"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_date)
      comment: "Month when quote was created"
    - name: "accepted_month"
      expr: DATE_TRUNC('MONTH', accepted_date)
      comment: "Month when quote was accepted"
  measures:
    - name: "total_quotes"
      expr: COUNT(DISTINCT quote_id)
      comment: "Total number of distinct quotes"
    - name: "total_quote_value"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total value of all quotes"
    - name: "total_contract_value"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value across all quotes"
    - name: "total_mrr"
      expr: SUM(CAST(monthly_recurring_revenue AS DOUBLE))
      comment: "Total monthly recurring revenue across quotes"
    - name: "avg_quote_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total value per quote"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(total_discount_percentage AS DOUBLE))
      comment: "Average discount percentage applied across quotes"
    - name: "total_discount_amount"
      expr: SUM(CAST(total_discount_amount AS DOUBLE))
      comment: "Total discount amount given across all quotes"
    - name: "avg_win_probability"
      expr: AVG(CAST(win_probability_percentage AS DOUBLE))
      comment: "Average win probability percentage across quotes"
    - name: "accepted_quotes"
      expr: COUNT(DISTINCT CASE WHEN accepted_date IS NOT NULL THEN quote_id END)
      comment: "Number of quotes that were accepted"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales contract metrics tracking contract value, terms, and revenue commitments"
  source: "`telecommunication_ecm`.`sales`.`sales_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the sales contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of sales contract"
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which contract was signed"
    - name: "billing_frequency"
      expr: billing_frequency
      comment: "Billing frequency for the contract"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms of the contract"
    - name: "etf_schedule_type"
      expr: etf_schedule_type
      comment: "Early termination fee schedule type"
    - name: "signed_month"
      expr: DATE_TRUNC('MONTH', signed_date)
      comment: "Month when contract was signed"
    - name: "effective_start_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month when contract became effective"
  measures:
    - name: "total_contracts"
      expr: COUNT(DISTINCT sales_contract_id)
      comment: "Total number of distinct sales contracts"
    - name: "total_contract_value"
      expr: SUM(CAST(tcv_amount AS DOUBLE))
      comment: "Total contract value across all contracts"
    - name: "total_mrr"
      expr: SUM(CAST(mrr_amount AS DOUBLE))
      comment: "Total monthly recurring revenue across contracts"
    - name: "avg_contract_value"
      expr: AVG(CAST(tcv_amount AS DOUBLE))
      comment: "Average total contract value per contract"
    - name: "avg_mrr"
      expr: AVG(CAST(mrr_amount AS DOUBLE))
      comment: "Average monthly recurring revenue per contract"
    - name: "total_etf_amount"
      expr: SUM(CAST(etf_amount AS DOUBLE))
      comment: "Total early termination fee amount across contracts"
    - name: "avg_uptime_sla"
      expr: AVG(CAST(uptime_sla_percentage AS DOUBLE))
      comment: "Average uptime SLA percentage across contracts"
    - name: "avg_price_escalation"
      expr: AVG(CAST(price_escalation_percentage AS DOUBLE))
      comment: "Average price escalation percentage across contracts"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_retention_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer retention offer metrics tracking offer effectiveness, acceptance rates, and customer lifetime value impact"
  source: "`telecommunication_ecm`.`sales`.`retention_offer`"
  dimensions:
    - name: "offer_status"
      expr: offer_status
      comment: "Current status of the retention offer"
    - name: "offer_type"
      expr: offer_type
      comment: "Type of retention offer"
    - name: "acceptance_outcome"
      expr: acceptance_outcome
      comment: "Outcome of the offer (accepted, rejected, pending)"
    - name: "rejection_reason_code"
      expr: rejection_reason_code
      comment: "Code indicating reason for rejection"
    - name: "offer_priority"
      expr: offer_priority
      comment: "Priority level of the retention offer"
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month when retention offer was created"
    - name: "presented_month"
      expr: DATE_TRUNC('MONTH', presented_timestamp)
      comment: "Month when offer was presented to customer"
  measures:
    - name: "total_retention_offers"
      expr: COUNT(DISTINCT retention_offer_id)
      comment: "Total number of distinct retention offers"
    - name: "total_offer_value"
      expr: SUM(CAST(offer_value_amount AS DOUBLE))
      comment: "Total value of all retention offers"
    - name: "total_offer_cost"
      expr: SUM(CAST(offer_cost_amount AS DOUBLE))
      comment: "Total cost of all retention offers"
    - name: "avg_offer_value"
      expr: AVG(CAST(offer_value_amount AS DOUBLE))
      comment: "Average value per retention offer"
    - name: "avg_discount_percentage"
      expr: AVG(CAST(discount_percentage AS DOUBLE))
      comment: "Average discount percentage offered"
    - name: "total_arpu_impact"
      expr: SUM(CAST(arpu_impact_amount AS DOUBLE))
      comment: "Total impact on average revenue per user across offers"
    - name: "total_cltv_impact"
      expr: SUM(CAST(cltv_impact_amount AS DOUBLE))
      comment: "Total impact on customer lifetime value across offers"
    - name: "accepted_offers"
      expr: COUNT(DISTINCT CASE WHEN acceptance_outcome = 'Accepted' THEN retention_offer_id END)
      comment: "Number of retention offers that were accepted"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion effectiveness metrics tracking budget utilization, redemption rates, and discount impact"
  source: "`telecommunication_ecm`.`sales`.`promotion`"
  dimensions:
    - name: "promotion_status"
      expr: promotion_status
      comment: "Current status of the promotion"
    - name: "promotion_type"
      expr: promotion_type
      comment: "Type of promotion"
    - name: "discount_type"
      expr: discount_type
      comment: "Type of discount offered"
    - name: "eligible_product_category"
      expr: eligible_product_category
      comment: "Product category eligible for the promotion"
    - name: "geographic_eligibility"
      expr: geographic_eligibility
      comment: "Geographic regions eligible for the promotion"
    - name: "promotion_start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month when promotion started"
  measures:
    - name: "total_promotions"
      expr: COUNT(DISTINCT promotion_id)
      comment: "Total number of distinct promotions"
    - name: "total_budget_allocated"
      expr: SUM(CAST(budget_allocated AS DOUBLE))
      comment: "Total budget allocated across all promotions"
    - name: "total_budget_consumed"
      expr: SUM(CAST(budget_consumed AS DOUBLE))
      comment: "Total budget consumed across all promotions"
    - name: "avg_discount_value"
      expr: AVG(CAST(discount_value AS DOUBLE))
      comment: "Average discount value across promotions"
    - name: "avg_minimum_purchase"
      expr: AVG(CAST(minimum_purchase_amount AS DOUBLE))
      comment: "Average minimum purchase amount required for promotions"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales target and quota attainment metrics tracking performance against goals"
  source: "`telecommunication_ecm`.`sales`.`target`"
  dimensions:
    - name: "target_type"
      expr: target_type
      comment: "Type of sales target"
    - name: "target_status"
      expr: target_status
      comment: "Current status of the target"
    - name: "measurement_period_type"
      expr: measurement_period_type
      comment: "Type of measurement period (monthly, quarterly, annual)"
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic scope of the target"
    - name: "product_category_scope"
      expr: product_category_scope
      comment: "Product category scope of the target"
    - name: "segment_scope"
      expr: segment_scope
      comment: "Customer segment scope of the target"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the target"
    - name: "period_start_month"
      expr: DATE_TRUNC('MONTH', period_start_date)
      comment: "Month when target period starts"
  measures:
    - name: "total_targets"
      expr: COUNT(DISTINCT target_id)
      comment: "Total number of distinct sales targets"
    - name: "total_target_value"
      expr: SUM(CAST(target_value AS DOUBLE))
      comment: "Total target value across all targets"
    - name: "total_attainment_value"
      expr: SUM(CAST(attainment_value AS DOUBLE))
      comment: "Total attainment value across all targets"
    - name: "avg_attainment_percentage"
      expr: AVG(CAST(attainment_percentage AS DOUBLE))
      comment: "Average attainment percentage across targets"
    - name: "avg_weight_factor"
      expr: AVG(CAST(weight_factor AS DOUBLE))
      comment: "Average weight factor across targets"
    - name: "avg_threshold_accelerator"
      expr: AVG(CAST(threshold_accelerator AS DOUBLE))
      comment: "Average threshold accelerator across targets"
$$;

CREATE OR REPLACE VIEW `telecommunication_ecm`.`_metrics`.`sales_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales channel performance metrics tracking channel effectiveness and capacity utilization"
  source: "`telecommunication_ecm`.`sales`.`channel`"
  dimensions:
    - name: "channel_type"
      expr: channel_type
      comment: "Type of sales channel"
    - name: "channel_status"
      expr: channel_status
      comment: "Current status of the channel"
    - name: "performance_tier"
      expr: performance_tier
      comment: "Performance tier classification of the channel"
    - name: "territory_type"
      expr: territory_type
      comment: "Type of territory the channel serves"
    - name: "region_name"
      expr: region_name
      comment: "Region name where channel operates"
    - name: "country_code"
      expr: country_code
      comment: "Country code where channel operates"
    - name: "lead_assignment_priority"
      expr: lead_assignment_priority
      comment: "Priority for lead assignment to this channel"
  measures:
    - name: "total_channels"
      expr: COUNT(DISTINCT channel_id)
      comment: "Total number of distinct sales channels"
    - name: "active_channels"
      expr: COUNT(DISTINCT CASE WHEN channel_status = 'Active' THEN channel_id END)
      comment: "Number of active sales channels"
$$;