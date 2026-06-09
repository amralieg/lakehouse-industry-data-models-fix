-- Metric views for domain: promotion | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:08:09

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_circular_ad`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular Ad business metrics"
  source: "`retail_ecm`.`promotion`.`circular_ad`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Circular Name"
      expr: circular_name
    - name: "Circular Number"
      expr: circular_number
    - name: "Circular Type"
      expr: circular_type
    - name: "Compliance Review Flag"
      expr: compliance_review_flag
    - name: "Cover Image Url"
      expr: cover_image_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Impressions Target"
      expr: digital_impressions_target
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Edition Number"
      expr: edition_number
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Market"
      expr: geographic_market
    - name: "Is Vendor Funded"
      expr: is_vendor_funded
    - name: "Language Code"
      expr: language_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Circular Ad"
      expr: COUNT(DISTINCT circular_ad_id)
    - name: "Total Production Cost Amount"
      expr: SUM(production_cost_amount)
    - name: "Average Production Cost Amount"
      expr: AVG(production_cost_amount)
    - name: "Total Vendor Funding Amount"
      expr: SUM(vendor_funding_amount)
    - name: "Average Vendor Funding Amount"
      expr: AVG(vendor_funding_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_circular_ad_category_feature`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Circular Ad Category Feature business metrics"
  source: "`retail_ecm`.`promotion`.`circular_ad_category_feature`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Creative Theme"
      expr: creative_theme
    - name: "Feature Prominence"
      expr: feature_prominence
    - name: "Feature Sequence"
      expr: feature_sequence
    - name: "Featured Sku Count"
      expr: featured_sku_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Page Number"
      expr: page_number
    - name: "Target Currency Code"
      expr: target_currency_code
    - name: "Vendor Co Op Flag"
      expr: vendor_co_op_flag
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Last Modified Timestamp Month"
      expr: DATE_TRUNC('MONTH', last_modified_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Circular Ad Category Feature"
      expr: COUNT(DISTINCT circular_ad_category_feature_id)
    - name: "Total Actual Sales Amount"
      expr: SUM(actual_sales_amount)
    - name: "Average Actual Sales Amount"
      expr: AVG(actual_sales_amount)
    - name: "Total Allocated Space Sqin"
      expr: SUM(allocated_space_sqin)
    - name: "Average Allocated Space Sqin"
      expr: AVG(allocated_space_sqin)
    - name: "Total Category Sales Target"
      expr: SUM(category_sales_target)
    - name: "Average Category Sales Target"
      expr: AVG(category_sales_target)
    - name: "Total Sales Lift Percent"
      expr: SUM(sales_lift_percent)
    - name: "Average Sales Lift Percent"
      expr: AVG(sales_lift_percent)
    - name: "Total Traffic Attribution Percent"
      expr: SUM(traffic_attribution_percent)
    - name: "Average Traffic Attribution Percent"
      expr: AVG(traffic_attribution_percent)
    - name: "Total Vendor Co Op Amount"
      expr: SUM(vendor_co_op_amount)
    - name: "Average Vendor Co Op Amount"
      expr: AVG(vendor_co_op_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon business metrics"
  source: "`retail_ecm`.`promotion`.`coupon`"
  dimensions:
    - name: "Barcode"
      expr: barcode
    - name: "Coupon Code"
      expr: coupon_code
    - name: "Coupon Status"
      expr: coupon_status
    - name: "Coupon Type"
      expr: coupon_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Digital Distribution Quantity"
      expr: digital_distribution_quantity
    - name: "Digital Wallet Enabled Flag"
      expr: digital_wallet_enabled_flag
    - name: "Discount Type"
      expr: discount_type
    - name: "Eligible Channel"
      expr: eligible_channel
    - name: "Eligible Product Scope"
      expr: eligible_product_scope
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Restriction"
      expr: geographic_restriction
    - name: "Issue Channel"
      expr: issue_channel
    - name: "Issue Date"
      expr: issue_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coupon"
      expr: COUNT(DISTINCT coupon_id)
    - name: "Total Face Value"
      expr: SUM(face_value)
    - name: "Average Face Value"
      expr: AVG(face_value)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_coupon_distribution`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Coupon Distribution business metrics"
  source: "`retail_ecm`.`promotion`.`coupon_distribution`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Distribution Date"
      expr: distribution_date
    - name: "Distribution Status"
      expr: distribution_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Distribution Date Month"
      expr: DATE_TRUNC('MONTH', distribution_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Coupon Distribution"
      expr: COUNT(DISTINCT coupon_distribution_id)
    - name: "Total Actual Reach"
      expr: SUM(actual_reach)
    - name: "Average Actual Reach"
      expr: AVG(actual_reach)
    - name: "Total Distribution Cost"
      expr: SUM(distribution_cost)
    - name: "Average Distribution Cost"
      expr: AVG(distribution_cost)
    - name: "Total Quantity Distributed"
      expr: SUM(quantity_distributed)
    - name: "Average Quantity Distributed"
      expr: AVG(quantity_distributed)
    - name: "Total Redemption Count"
      expr: SUM(redemption_count)
    - name: "Average Redemption Count"
      expr: AVG(redemption_count)
    - name: "Total Redemption Rate Percent"
      expr: SUM(redemption_rate_percent)
    - name: "Average Redemption Rate Percent"
      expr: AVG(redemption_rate_percent)
    - name: "Total Target Reach"
      expr: SUM(target_reach)
    - name: "Average Target Reach"
      expr: AVG(target_reach)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Budget business metrics"
  source: "`retail_ecm`.`promotion`.`promo_budget`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Budget Name"
      expr: budget_name
    - name: "Budget Number"
      expr: budget_number
    - name: "Budget Owner Type"
      expr: budget_owner_type
    - name: "Budget Status"
      expr: budget_status
    - name: "Budget Type"
      expr: budget_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Budget"
      expr: COUNT(DISTINCT promo_budget_id)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Circular Ad Allocation"
      expr: SUM(circular_ad_allocation)
    - name: "Average Circular Ad Allocation"
      expr: AVG(circular_ad_allocation)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Ecommerce Channel Allocation"
      expr: SUM(ecommerce_channel_allocation)
    - name: "Average Ecommerce Channel Allocation"
      expr: AVG(ecommerce_channel_allocation)
    - name: "Total Mobile Channel Allocation"
      expr: SUM(mobile_channel_allocation)
    - name: "Average Mobile Channel Allocation"
      expr: AVG(mobile_channel_allocation)
    - name: "Total Planned Spend Amount"
      expr: SUM(planned_spend_amount)
    - name: "Average Planned Spend Amount"
      expr: AVG(planned_spend_amount)
    - name: "Total Pos Channel Allocation"
      expr: SUM(pos_channel_allocation)
    - name: "Average Pos Channel Allocation"
      expr: AVG(pos_channel_allocation)
    - name: "Total Remaining Budget Amount"
      expr: SUM(remaining_budget_amount)
    - name: "Average Remaining Budget Amount"
      expr: AVG(remaining_budget_amount)
    - name: "Total Total Budget Amount"
      expr: SUM(total_budget_amount)
    - name: "Average Total Budget Amount"
      expr: AVG(total_budget_amount)
    - name: "Total Variance Threshold Amount"
      expr: SUM(variance_threshold_amount)
    - name: "Average Variance Threshold Amount"
      expr: AVG(variance_threshold_amount)
    - name: "Total Variance Threshold Percent"
      expr: SUM(variance_threshold_percent)
    - name: "Average Variance Threshold Percent"
      expr: AVG(variance_threshold_percent)
    - name: "Total Vendor Funded Amount"
      expr: SUM(vendor_funded_amount)
    - name: "Average Vendor Funded Amount"
      expr: AVG(vendor_funded_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Calendar business metrics"
  source: "`retail_ecm`.`promotion`.`promo_calendar`"
  dimensions:
    - name: "Applicable Banner Codes"
      expr: applicable_banner_codes
    - name: "Applicable Market Codes"
      expr: applicable_market_codes
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approved By Name"
      expr: approved_by_name
    - name: "Banner Applicability"
      expr: banner_applicability
    - name: "Blackout Reason"
      expr: blackout_reason
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Circular Production Deadline"
      expr: circular_production_deadline
    - name: "Competitive Response Flag"
      expr: competitive_response_flag
    - name: "Competitive Trigger Description"
      expr: competitive_trigger_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "Fiscal Month"
      expr: fiscal_month
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Calendar"
      expr: COUNT(DISTINCT promo_calendar_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Expected Sales Lift Pct"
      expr: SUM(expected_sales_lift_pct)
    - name: "Average Expected Sales Lift Pct"
      expr: AVG(expected_sales_lift_pct)
    - name: "Total Expected Traffic Lift Pct"
      expr: SUM(expected_traffic_lift_pct)
    - name: "Average Expected Traffic Lift Pct"
      expr: AVG(expected_traffic_lift_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Campaign business metrics"
  source: "`retail_ecm`.`promotion`.`promo_campaign`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Description"
      expr: campaign_description
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Circular Ad Flag"
      expr: circular_ad_flag
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Target"
      expr: customer_segment_target
    - name: "Digital Promotion Flag"
      expr: digital_promotion_flag
    - name: "Discount Strategy"
      expr: discount_strategy
    - name: "End Date"
      expr: end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Campaign"
      expr: COUNT(DISTINCT promo_campaign_id)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Target Revenue"
      expr: SUM(target_revenue)
    - name: "Average Target Revenue"
      expr: AVG(target_revenue)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_conflict_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Conflict Rule business metrics"
  source: "`retail_ecm`.`promotion`.`promo_conflict_rule`"
  dimensions:
    - name: "Applies To Scope"
      expr: applies_to_scope
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Log Required Flag"
      expr: audit_log_required_flag
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment Restriction"
      expr: customer_segment_restriction
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Jurisdiction Code"
      expr: jurisdiction_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Stack Count"
      expr: max_stack_count
    - name: "Notes"
      expr: notes
    - name: "Oms System Flag"
      expr: oms_system_flag
    - name: "Override Allowed Flag"
      expr: override_allowed_flag
    - name: "Override Authorization Level"
      expr: override_authorization_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Conflict Rule"
      expr: COUNT(DISTINCT promo_conflict_rule_id)
    - name: "Total Max Discount Amount"
      expr: SUM(max_discount_amount)
    - name: "Average Max Discount Amount"
      expr: AVG(max_discount_amount)
    - name: "Total Max Discount Percentage"
      expr: SUM(max_discount_percentage)
    - name: "Average Max Discount Percentage"
      expr: AVG(max_discount_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Forecast business metrics"
  source: "`retail_ecm`.`promotion`.`promo_forecast`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Forecast Adjustment Reason"
      expr: forecast_adjustment_reason
    - name: "Forecast Confidence Level"
      expr: forecast_confidence_level
    - name: "Forecast Generation Timestamp"
      expr: forecast_generation_timestamp
    - name: "Forecast Model Version"
      expr: forecast_model_version
    - name: "Forecast Scenario"
      expr: forecast_scenario
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Week End Date"
      expr: forecast_week_end_date
    - name: "Forecast Week Start Date"
      expr: forecast_week_start_date
    - name: "Notes"
      expr: notes
    - name: "Promotion Type"
      expr: promotion_type
    - name: "Replenishment Triggered Flag"
      expr: replenishment_triggered_flag
    - name: "Updated Timestamp"
      expr: updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Forecast"
      expr: COUNT(DISTINCT promo_forecast_id)
    - name: "Total Baseline Sales Forecast Units"
      expr: SUM(baseline_sales_forecast_units)
    - name: "Average Baseline Sales Forecast Units"
      expr: AVG(baseline_sales_forecast_units)
    - name: "Total Forecast Adjustment Factor"
      expr: SUM(forecast_adjustment_factor)
    - name: "Average Forecast Adjustment Factor"
      expr: AVG(forecast_adjustment_factor)
    - name: "Total Forecast Confidence Score"
      expr: SUM(forecast_confidence_score)
    - name: "Average Forecast Confidence Score"
      expr: AVG(forecast_confidence_score)
    - name: "Total Forecast Error Percentage"
      expr: SUM(forecast_error_percentage)
    - name: "Average Forecast Error Percentage"
      expr: AVG(forecast_error_percentage)
    - name: "Total Forecasted Discount Cost Amount"
      expr: SUM(forecasted_discount_cost_amount)
    - name: "Average Forecasted Discount Cost Amount"
      expr: AVG(forecasted_discount_cost_amount)
    - name: "Total Forecasted Revenue Amount"
      expr: SUM(forecasted_revenue_amount)
    - name: "Average Forecasted Revenue Amount"
      expr: AVG(forecasted_revenue_amount)
    - name: "Total Incremental Lift Units"
      expr: SUM(incremental_lift_units)
    - name: "Average Incremental Lift Units"
      expr: AVG(incremental_lift_units)
    - name: "Total Open To Buy Impact Amount"
      expr: SUM(open_to_buy_impact_amount)
    - name: "Average Open To Buy Impact Amount"
      expr: AVG(open_to_buy_impact_amount)
    - name: "Total Promotional Price Amount"
      expr: SUM(promotional_price_amount)
    - name: "Average Promotional Price Amount"
      expr: AVG(promotional_price_amount)
    - name: "Total Regular Price Amount"
      expr: SUM(regular_price_amount)
    - name: "Average Regular Price Amount"
      expr: AVG(regular_price_amount)
    - name: "Total Total Forecasted Units"
      expr: SUM(total_forecasted_units)
    - name: "Average Total Forecasted Units"
      expr: AVG(total_forecasted_units)
    - name: "Total Vendor Funding Amount"
      expr: SUM(vendor_funding_amount)
    - name: "Average Vendor Funding Amount"
      expr: AVG(vendor_funding_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_group`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Group business metrics"
  source: "`retail_ecm`.`promotion`.`promo_group`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Business Owner"
      expr: business_owner
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Conflict Resolution Rule"
      expr: conflict_resolution_rule
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Applicability"
      expr: customer_segment_applicability
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Scope"
      expr: exclusion_scope
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Group Code"
      expr: group_code
    - name: "Group Description"
      expr: group_description
    - name: "Group Name"
      expr: group_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Group"
      expr: COUNT(DISTINCT promo_group_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Inventory Allocation business metrics"
  source: "`retail_ecm`.`promotion`.`promo_inventory_allocation`"
  dimensions:
    - name: "Allocated Inventory Units"
      expr: allocated_inventory_units
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Facility Priority Rank"
      expr: facility_priority_rank
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Inventory Allocation"
      expr: COUNT(DISTINCT promo_inventory_allocation_id)
    - name: "Total Allocation Percentage"
      expr: SUM(allocation_percentage)
    - name: "Average Allocation Percentage"
      expr: AVG(allocation_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Offer business metrics"
  source: "`retail_ecm`.`promotion`.`promo_offer`"
  dimensions:
    - name: "Activation Trigger"
      expr: activation_trigger
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Eligibility"
      expr: channel_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment Eligibility"
      expr: customer_segment_eligibility
    - name: "Digital Delivery Flag"
      expr: digital_delivery_flag
    - name: "Discount Method"
      expr: discount_method
    - name: "Display Message"
      expr: display_message
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective End Time"
      expr: effective_end_time
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Effective Start Time"
      expr: effective_start_time
    - name: "Jurisdiction Restriction Flag"
      expr: jurisdiction_restriction_flag
    - name: "Maximum Redemption Per Customer"
      expr: maximum_redemption_per_customer
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Offer"
      expr: COUNT(DISTINCT promo_offer_id)
    - name: "Total Cost Share Percentage"
      expr: SUM(cost_share_percentage)
    - name: "Average Cost Share Percentage"
      expr: AVG(cost_share_percentage)
    - name: "Total Discount Value"
      expr: SUM(discount_value)
    - name: "Average Discount Value"
      expr: AVG(discount_value)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Performance business metrics"
  source: "`retail_ecm`.`promotion`.`promo_performance`"
  dimensions:
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source System"
      expr: data_source_system
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "New Customer Count"
      expr: new_customer_count
    - name: "Notes"
      expr: notes
    - name: "Out Of Stock Days"
      expr: out_of_stock_days
    - name: "Performance Status"
      expr: performance_status
    - name: "Performance Week End Date"
      expr: performance_week_end_date
    - name: "Performance Week Start Date"
      expr: performance_week_start_date
    - name: "Redemption Count"
      expr: redemption_count
    - name: "Repeat Customer Count"
      expr: repeat_customer_count
    - name: "Sku"
      expr: sku
    - name: "Unique Customer Count"
      expr: unique_customer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Performance"
      expr: COUNT(DISTINCT promo_performance_id)
    - name: "Total Average Transaction Value"
      expr: SUM(average_transaction_value)
    - name: "Average Average Transaction Value"
      expr: AVG(average_transaction_value)
    - name: "Total Baseline Units"
      expr: SUM(baseline_units)
    - name: "Average Baseline Units"
      expr: AVG(baseline_units)
    - name: "Total Cannibalization Estimate"
      expr: SUM(cannibalization_estimate)
    - name: "Average Cannibalization Estimate"
      expr: AVG(cannibalization_estimate)
    - name: "Total Cogs"
      expr: SUM(cogs)
    - name: "Average Cogs"
      expr: AVG(cogs)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Forecast Accuracy Percent"
      expr: SUM(forecast_accuracy_percent)
    - name: "Average Forecast Accuracy Percent"
      expr: AVG(forecast_accuracy_percent)
    - name: "Total Gross Margin"
      expr: SUM(gross_margin)
    - name: "Average Gross Margin"
      expr: AVG(gross_margin)
    - name: "Total Gross Margin Percent"
      expr: SUM(gross_margin_percent)
    - name: "Average Gross Margin Percent"
      expr: AVG(gross_margin_percent)
    - name: "Total Gross Revenue"
      expr: SUM(gross_revenue)
    - name: "Average Gross Revenue"
      expr: AVG(gross_revenue)
    - name: "Total Incremental Units"
      expr: SUM(incremental_units)
    - name: "Average Incremental Units"
      expr: AVG(incremental_units)
    - name: "Total Net Revenue"
      expr: SUM(net_revenue)
    - name: "Average Net Revenue"
      expr: AVG(net_revenue)
    - name: "Total Promotional Roi"
      expr: SUM(promotional_roi)
    - name: "Average Promotional Roi"
      expr: AVG(promotional_roi)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promo_redemption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promo Redemption business metrics"
  source: "`retail_ecm`.`promotion`.`promo_redemption`"
  dimensions:
    - name: "Chargeback Status"
      expr: chargeback_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Type"
      expr: discount_type
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Processing System"
      expr: processing_system
    - name: "Promotion Tier"
      expr: promotion_tier
    - name: "Quantity Redeemed"
      expr: quantity_redeemed
    - name: "Redemption Channel"
      expr: redemption_channel
    - name: "Redemption Limit Type"
      expr: redemption_limit_type
    - name: "Redemption Mechanism"
      expr: redemption_mechanism
    - name: "Redemption Sequence Number"
      expr: redemption_sequence_number
    - name: "Redemption Status"
      expr: redemption_status
    - name: "Redemption Timestamp"
      expr: redemption_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promo Redemption"
      expr: COUNT(DISTINCT promo_redemption_id)
    - name: "Total Chargeback Amount"
      expr: SUM(chargeback_amount)
    - name: "Average Chargeback Amount"
      expr: AVG(chargeback_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Final Price"
      expr: SUM(final_price)
    - name: "Average Final Price"
      expr: AVG(final_price)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_promotion_stack`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promotion Stack business metrics"
  source: "`retail_ecm`.`promotion`.`promotion_stack`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Apply"
      expr: auto_apply
    - name: "Budget Currency Code"
      expr: budget_currency_code
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Combinable With Clearance"
      expr: combinable_with_clearance
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclude Sale Items"
      expr: exclude_sale_items
    - name: "Funding Source"
      expr: funding_source
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promotion Stack"
      expr: COUNT(DISTINCT promotion_stack_id)
    - name: "Total Budget Allocated"
      expr: SUM(budget_allocated)
    - name: "Average Budget Allocated"
      expr: AVG(budget_allocated)
    - name: "Total Maximum Discount Amount"
      expr: SUM(maximum_discount_amount)
    - name: "Average Maximum Discount Amount"
      expr: AVG(maximum_discount_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_rebate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate business metrics"
  source: "`retail_ecm`.`promotion`.`rebate`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Eligibility"
      expr: channel_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Segment Eligibility"
      expr: customer_segment_eligibility
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusion Product List"
      expr: exclusion_product_list
    - name: "Geographic Eligibility"
      expr: geographic_eligibility
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Marketing Message"
      expr: marketing_message
    - name: "Minimum Purchase Quantity"
      expr: minimum_purchase_quantity
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Processing Days"
      expr: payment_processing_days
    - name: "Qualifying Product List"
      expr: qualifying_product_list
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rebate"
      expr: COUNT(DISTINCT rebate_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Maximum Rebate Amount"
      expr: SUM(maximum_rebate_amount)
    - name: "Average Maximum Rebate Amount"
      expr: AVG(maximum_rebate_amount)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
    - name: "Total Total Budget Amount"
      expr: SUM(total_budget_amount)
    - name: "Average Total Budget Amount"
      expr: AVG(total_budget_amount)
    - name: "Total Vendor Funding Percentage"
      expr: SUM(vendor_funding_percentage)
    - name: "Average Vendor Funding Percentage"
      expr: AVG(vendor_funding_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_rebate_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate Claim business metrics"
  source: "`retail_ecm`.`promotion`.`rebate_claim`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Status"
      expr: claim_status
    - name: "Claimant Email"
      expr: claimant_email
    - name: "Claimant Name"
      expr: claimant_name
    - name: "Claimant Phone"
      expr: claimant_phone
    - name: "Claimant Type"
      expr: claimant_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days To Approval"
      expr: days_to_approval
    - name: "Documentation Status"
      expr: documentation_status
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Date"
      expr: payment_date
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rebate Claim"
      expr: COUNT(DISTINCT rebate_claim_id)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Claimed Amount"
      expr: SUM(claimed_amount)
    - name: "Average Claimed Amount"
      expr: AVG(claimed_amount)
    - name: "Total Purchase Amount"
      expr: SUM(purchase_amount)
    - name: "Average Purchase Amount"
      expr: AVG(purchase_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_vendor_promo_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Promo Agreement business metrics"
  source: "`retail_ecm`.`promotion`.`vendor_promo_agreement`"
  dimensions:
    - name: "Accrual Method"
      expr: accrual_method
    - name: "Ad Placement Required"
      expr: ad_placement_required
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Chargeback Eligible"
      expr: chargeback_eligible
    - name: "Contract Document Reference"
      expr: contract_document_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Compliance Required"
      expr: display_compliance_required
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Funding Currency Code"
      expr: funding_currency_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Performance Obligation Description"
      expr: performance_obligation_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Promo Agreement"
      expr: COUNT(DISTINCT vendor_promo_agreement_id)
    - name: "Total Chargeback Penalty Amount"
      expr: SUM(chargeback_penalty_amount)
    - name: "Average Chargeback Penalty Amount"
      expr: AVG(chargeback_penalty_amount)
    - name: "Total Funding Amount"
      expr: SUM(funding_amount)
    - name: "Average Funding Amount"
      expr: AVG(funding_amount)
    - name: "Total Funding Percentage"
      expr: SUM(funding_percentage)
    - name: "Average Funding Percentage"
      expr: AVG(funding_percentage)
    - name: "Total Minimum Purchase Amount"
      expr: SUM(minimum_purchase_amount)
    - name: "Average Minimum Purchase Amount"
      expr: AVG(minimum_purchase_amount)
    - name: "Total Minimum Purchase Quantity"
      expr: SUM(minimum_purchase_quantity)
    - name: "Average Minimum Purchase Quantity"
      expr: AVG(minimum_purchase_quantity)
    - name: "Total Outstanding Balance"
      expr: SUM(outstanding_balance)
    - name: "Average Outstanding Balance"
      expr: AVG(outstanding_balance)
    - name: "Total Total Accrued Amount"
      expr: SUM(total_accrued_amount)
    - name: "Average Total Accrued Amount"
      expr: AVG(total_accrued_amount)
    - name: "Total Total Settled Amount"
      expr: SUM(total_settled_amount)
    - name: "Average Total Settled Amount"
      expr: AVG(total_settled_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`promotion_vendor_promo_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Promo Claim business metrics"
  source: "`retail_ecm`.`promotion`.`vendor_promo_claim`"
  dimensions:
    - name: "Claim Date"
      expr: claim_date
    - name: "Claim Notes"
      expr: claim_notes
    - name: "Claim Number"
      expr: claim_number
    - name: "Claim Period End Date"
      expr: claim_period_end_date
    - name: "Claim Period Start Date"
      expr: claim_period_start_date
    - name: "Claim Source System"
      expr: claim_source_system
    - name: "Claim Status"
      expr: claim_status
    - name: "Claim Type"
      expr: claim_type
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Is Automated Claim"
      expr: is_automated_claim
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Promo Claim"
      expr: COUNT(DISTINCT vendor_promo_claim_id)
    - name: "Total Approved Amount"
      expr: SUM(approved_amount)
    - name: "Average Approved Amount"
      expr: AVG(approved_amount)
    - name: "Total Claimed Amount"
      expr: SUM(claimed_amount)
    - name: "Average Claimed Amount"
      expr: AVG(claimed_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
    - name: "Total Sales Revenue"
      expr: SUM(sales_revenue)
    - name: "Average Sales Revenue"
      expr: AVG(sales_revenue)
    - name: "Total Settled Amount"
      expr: SUM(settled_amount)
    - name: "Average Settled Amount"
      expr: AVG(settled_amount)
    - name: "Total Units Sold"
      expr: SUM(units_sold)
    - name: "Average Units Sold"
      expr: AVG(units_sold)
$$;