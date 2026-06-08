-- Metric views for domain: pricing | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:05:50

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_competitive_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Competitive Price business metrics"
  source: "`retail_ecm`.`pricing`.`competitive_price`"
  dimensions:
    - name: "Category Code"
      expr: category_code
    - name: "Competitor Channel"
      expr: competitor_channel
    - name: "Competitor In Stock Flag"
      expr: competitor_in_stock_flag
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Competitor Product Name"
      expr: competitor_product_name
    - name: "Competitor Promo End Date"
      expr: competitor_promo_end_date
    - name: "Competitor Promo Flag"
      expr: competitor_promo_flag
    - name: "Competitor Promo Type"
      expr: competitor_promo_type
    - name: "Competitor Sku Code"
      expr: competitor_sku_code
    - name: "Competitor Unit Of Measure"
      expr: competitor_unit_of_measure
    - name: "Competitor Url"
      expr: competitor_url
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Source Type"
      expr: data_source_type
    - name: "Data Source Vendor"
      expr: data_source_vendor
    - name: "Department Code"
      expr: department_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Competitive Price"
      expr: COUNT(DISTINCT competitive_price_id)
    - name: "Total Competitor Pack Size"
      expr: SUM(competitor_pack_size)
    - name: "Average Competitor Pack Size"
      expr: AVG(competitor_pack_size)
    - name: "Total Competitor Price"
      expr: SUM(competitor_price)
    - name: "Average Competitor Price"
      expr: AVG(competitor_price)
    - name: "Total Match Confidence Score"
      expr: SUM(match_confidence_score)
    - name: "Average Match Confidence Score"
      expr: AVG(match_confidence_score)
    - name: "Total Normalized Unit Price"
      expr: SUM(normalized_unit_price)
    - name: "Average Normalized Unit Price"
      expr: AVG(normalized_unit_price)
    - name: "Total Previous Competitor Price"
      expr: SUM(previous_competitor_price)
    - name: "Average Previous Competitor Price"
      expr: AVG(previous_competitor_price)
    - name: "Total Price Gap"
      expr: SUM(price_gap)
    - name: "Average Price Gap"
      expr: AVG(price_gap)
    - name: "Total Price Gap Pct"
      expr: SUM(price_gap_pct)
    - name: "Average Price Gap Pct"
      expr: AVG(price_gap_pct)
    - name: "Total Price Index"
      expr: SUM(price_index)
    - name: "Average Price Index"
      expr: AVG(price_index)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_cost_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Price business metrics"
  source: "`retail_ecm`.`pricing`.`cost_price`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Cost Change Reason"
      expr: cost_change_reason
    - name: "Cost Currency"
      expr: cost_currency
    - name: "Cost Notes"
      expr: cost_notes
    - name: "Cost Status"
      expr: cost_status
    - name: "Cost Type"
      expr: cost_type
    - name: "Cost Uom"
      expr: cost_uom
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Hts Code"
      expr: hts_code
    - name: "Incoterm"
      expr: incoterm
    - name: "Is Current"
      expr: is_current
    - name: "Source System"
      expr: source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Price"
      expr: COUNT(DISTINCT cost_price_id)
    - name: "Total Base Cost"
      expr: SUM(base_cost)
    - name: "Average Base Cost"
      expr: AVG(base_cost)
    - name: "Total Cost Change Pct"
      expr: SUM(cost_change_pct)
    - name: "Average Cost Change Pct"
      expr: AVG(cost_change_pct)
    - name: "Total Cost Per Inner Pack"
      expr: SUM(cost_per_inner_pack)
    - name: "Average Cost Per Inner Pack"
      expr: AVG(cost_per_inner_pack)
    - name: "Total Duty Amount"
      expr: SUM(duty_amount)
    - name: "Average Duty Amount"
      expr: AVG(duty_amount)
    - name: "Total Duty Rate Pct"
      expr: SUM(duty_rate_pct)
    - name: "Average Duty Rate Pct"
      expr: AVG(duty_rate_pct)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Handling Cost"
      expr: SUM(handling_cost)
    - name: "Average Handling Cost"
      expr: AVG(handling_cost)
    - name: "Total Landed Cost"
      expr: SUM(landed_cost)
    - name: "Average Landed Cost"
      expr: AVG(landed_cost)
    - name: "Total Landed Cost Local"
      expr: SUM(landed_cost_local)
    - name: "Average Landed Cost Local"
      expr: AVG(landed_cost_local)
    - name: "Total Other Cost"
      expr: SUM(other_cost)
    - name: "Average Other Cost"
      expr: AVG(other_cost)
    - name: "Total Prior Landed Cost"
      expr: SUM(prior_landed_cost)
    - name: "Average Prior Landed Cost"
      expr: AVG(prior_landed_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_cost_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost Zone business metrics"
  source: "`retail_ecm`.`pricing`.`cost_zone`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Code"
      expr: code
    - name: "Competitive Intensity"
      expr: competitive_intensity
    - name: "Cost Review Frequency"
      expr: cost_review_frequency
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Default Cost Method"
      expr: default_cost_method
    - name: "Description"
      expr: description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Scope"
      expr: geographic_scope
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Last Cost Review Date"
      expr: last_cost_review_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name"
      expr: name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cost Zone"
      expr: COUNT(DISTINCT cost_zone_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
    - name: "Total Annual Volume Units"
      expr: SUM(annual_volume_units)
    - name: "Average Annual Volume Units"
      expr: AVG(annual_volume_units)
    - name: "Total Approval Threshold Amount"
      expr: SUM(approval_threshold_amount)
    - name: "Average Approval Threshold Amount"
      expr: AVG(approval_threshold_amount)
    - name: "Total Cost Adjustment Factor"
      expr: SUM(cost_adjustment_factor)
    - name: "Average Cost Adjustment Factor"
      expr: AVG(cost_adjustment_factor)
    - name: "Total Duty Factor Percentage"
      expr: SUM(duty_factor_percentage)
    - name: "Average Duty Factor Percentage"
      expr: AVG(duty_factor_percentage)
    - name: "Total Freight Factor Percentage"
      expr: SUM(freight_factor_percentage)
    - name: "Average Freight Factor Percentage"
      expr: AVG(freight_factor_percentage)
    - name: "Total Minimum Margin Percentage"
      expr: SUM(minimum_margin_percentage)
    - name: "Average Minimum Margin Percentage"
      expr: AVG(minimum_margin_percentage)
    - name: "Total Overhead Factor Percentage"
      expr: SUM(overhead_factor_percentage)
    - name: "Average Overhead Factor Percentage"
      expr: AVG(overhead_factor_percentage)
    - name: "Total Target Margin Percentage"
      expr: SUM(target_margin_percentage)
    - name: "Average Target Margin Percentage"
      expr: AVG(target_margin_percentage)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_margin_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Margin Target business metrics"
  source: "`retail_ecm`.`pricing`.`margin_target`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Brand Classification"
      expr: brand_classification
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Locked"
      expr: is_locked
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Markdown Optimization Strategy"
      expr: markdown_optimization_strategy
    - name: "Notes"
      expr: notes
    - name: "Planning Period Label"
      expr: planning_period_label
    - name: "Planning Period Type"
      expr: planning_period_type
    - name: "Revision Number"
      expr: revision_number
    - name: "Revision Reason"
      expr: revision_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Margin Target"
      expr: COUNT(DISTINCT margin_target_id)
    - name: "Total Asp Target"
      expr: SUM(asp_target)
    - name: "Average Asp Target"
      expr: AVG(asp_target)
    - name: "Total Aur Target"
      expr: SUM(aur_target)
    - name: "Average Aur Target"
      expr: AVG(aur_target)
    - name: "Total Budget Utilization Pct"
      expr: SUM(budget_utilization_pct)
    - name: "Average Budget Utilization Pct"
      expr: AVG(budget_utilization_pct)
    - name: "Total Cogs Rate Pct"
      expr: SUM(cogs_rate_pct)
    - name: "Average Cogs Rate Pct"
      expr: AVG(cogs_rate_pct)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Markdown Budget Consumed"
      expr: SUM(markdown_budget_consumed)
    - name: "Average Markdown Budget Consumed"
      expr: AVG(markdown_budget_consumed)
    - name: "Total Markdown Budget Remaining"
      expr: SUM(markdown_budget_remaining)
    - name: "Average Markdown Budget Remaining"
      expr: AVG(markdown_budget_remaining)
    - name: "Total Markdown Budget Total"
      expr: SUM(markdown_budget_total)
    - name: "Average Markdown Budget Total"
      expr: AVG(markdown_budget_total)
    - name: "Total Minimum Margin Floor Pct"
      expr: SUM(minimum_margin_floor_pct)
    - name: "Average Minimum Margin Floor Pct"
      expr: AVG(minimum_margin_floor_pct)
    - name: "Total Private Label Margin Premium Pct"
      expr: SUM(private_label_margin_premium_pct)
    - name: "Average Private Label Margin Premium Pct"
      expr: AVG(private_label_margin_premium_pct)
    - name: "Total Target Gross Margin Pct"
      expr: SUM(target_gross_margin_pct)
    - name: "Average Target Gross Margin Pct"
      expr: AVG(target_gross_margin_pct)
    - name: "Total Target Sell Through Rate Pct"
      expr: SUM(target_sell_through_rate_pct)
    - name: "Average Target Sell Through Rate Pct"
      expr: AVG(target_sell_through_rate_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_markdown`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown business metrics"
  source: "`retail_ecm`.`pricing`.`markdown`"
  dimensions:
    - name: "Actual Exit Date"
      expr: actual_exit_date
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Clearance Closure Date"
      expr: clearance_closure_date
    - name: "Clearance Initiation Date"
      expr: clearance_initiation_date
    - name: "Clearance Stage"
      expr: clearance_stage
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Disposition Method"
      expr: disposition_method
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Competitive Response"
      expr: is_competitive_response
    - name: "Is Dead Stock"
      expr: is_dead_stock
    - name: "Markdown Number"
      expr: markdown_number
    - name: "Markdown Status"
      expr: markdown_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Markdown"
      expr: COUNT(DISTINCT markdown_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Marked Down Price"
      expr: SUM(marked_down_price)
    - name: "Average Marked Down Price"
      expr: AVG(marked_down_price)
    - name: "Total Original Retail Price"
      expr: SUM(original_retail_price)
    - name: "Average Original Retail Price"
      expr: AVG(original_retail_price)
    - name: "Total Percent"
      expr: SUM(percent)
    - name: "Average Percent"
      expr: AVG(percent)
    - name: "Total Sell Through Actual Pct"
      expr: SUM(sell_through_actual_pct)
    - name: "Average Sell Through Actual Pct"
      expr: AVG(sell_through_actual_pct)
    - name: "Total Sell Through Target Pct"
      expr: SUM(sell_through_target_pct)
    - name: "Average Sell Through Target Pct"
      expr: AVG(sell_through_target_pct)
    - name: "Total Weeks Of Supply"
      expr: SUM(weeks_of_supply)
    - name: "Average Weeks Of Supply"
      expr: AVG(weeks_of_supply)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_approval`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Approval business metrics"
  source: "`retail_ecm`.`pricing`.`price_approval`"
  dimensions:
    - name: "Approval Channel"
      expr: approval_channel
    - name: "Approval Notes"
      expr: approval_notes
    - name: "Approval Number"
      expr: approval_number
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Tier"
      expr: approval_tier
    - name: "Approval Type"
      expr: approval_type
    - name: "Business Justification"
      expr: business_justification
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Timestamp"
      expr: decision_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Escalation Tier"
      expr: escalation_tier
    - name: "Escalation Timestamp"
      expr: escalation_timestamp
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Approval"
      expr: COUNT(DISTINCT price_approval_id)
    - name: "Total Competitive Price Ref"
      expr: SUM(competitive_price_ref)
    - name: "Average Competitive Price Ref"
      expr: AVG(competitive_price_ref)
    - name: "Total Current Price"
      expr: SUM(current_price)
    - name: "Average Current Price"
      expr: AVG(current_price)
    - name: "Total Gross Margin Pct"
      expr: SUM(gross_margin_pct)
    - name: "Average Gross Margin Pct"
      expr: AVG(gross_margin_pct)
    - name: "Total Price Change Pct"
      expr: SUM(price_change_pct)
    - name: "Average Price Change Pct"
      expr: AVG(price_change_pct)
    - name: "Total Proposed Price"
      expr: SUM(proposed_price)
    - name: "Average Proposed Price"
      expr: AVG(proposed_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_audit_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Audit Log business metrics"
  source: "`retail_ecm`.`pricing`.`price_audit_log`"
  dimensions:
    - name: "Actor Role"
      expr: actor_role
    - name: "Actor Type"
      expr: actor_type
    - name: "Actor Username"
      expr: actor_username
    - name: "Approval Tier"
      expr: approval_tier
    - name: "Approver Username"
      expr: approver_username
    - name: "Audit Action"
      expr: audit_action
    - name: "Audit Event Type"
      expr: audit_event_type
    - name: "Audit Notes"
      expr: audit_notes
    - name: "Audit Status"
      expr: audit_status
    - name: "Business Justification"
      expr: business_justification
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Channel"
      expr: channel
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Audit Log"
      expr: COUNT(DISTINCT price_audit_log_id)
    - name: "Total Competitive Reference Price"
      expr: SUM(competitive_reference_price)
    - name: "Average Competitive Reference Price"
      expr: AVG(competitive_reference_price)
    - name: "Total Margin Impact"
      expr: SUM(margin_impact)
    - name: "Average Margin Impact"
      expr: AVG(margin_impact)
    - name: "Total New Cost Price"
      expr: SUM(new_cost_price)
    - name: "Average New Cost Price"
      expr: AVG(new_cost_price)
    - name: "Total New Margin Percent"
      expr: SUM(new_margin_percent)
    - name: "Average New Margin Percent"
      expr: AVG(new_margin_percent)
    - name: "Total New Retail Price"
      expr: SUM(new_retail_price)
    - name: "Average New Retail Price"
      expr: AVG(new_retail_price)
    - name: "Total Price Change Amount"
      expr: SUM(price_change_amount)
    - name: "Average Price Change Amount"
      expr: AVG(price_change_amount)
    - name: "Total Price Change Percent"
      expr: SUM(price_change_percent)
    - name: "Average Price Change Percent"
      expr: AVG(price_change_percent)
    - name: "Total Prior Cost Price"
      expr: SUM(prior_cost_price)
    - name: "Average Prior Cost Price"
      expr: AVG(prior_cost_price)
    - name: "Total Prior Margin Percent"
      expr: SUM(prior_margin_percent)
    - name: "Average Prior Margin Percent"
      expr: AVG(prior_margin_percent)
    - name: "Total Prior Retail Price"
      expr: SUM(prior_retail_price)
    - name: "Average Prior Retail Price"
      expr: AVG(prior_retail_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_change`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Change business metrics"
  source: "`retail_ecm`.`pricing`.`price_change`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Change Category"
      expr: change_category
    - name: "Change Type"
      expr: change_type
    - name: "Channel"
      expr: channel
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Event Timestamp"
      expr: event_timestamp
    - name: "Execution Mode"
      expr: execution_mode
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Cost Change"
      expr: is_cost_change
    - name: "Is Margin Breach"
      expr: is_margin_breach
    - name: "Notes"
      expr: notes
    - name: "Pricing Strategy"
      expr: pricing_strategy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Change"
      expr: COUNT(DISTINCT price_change_id)
    - name: "Total Competitive Reference Price"
      expr: SUM(competitive_reference_price)
    - name: "Average Competitive Reference Price"
      expr: AVG(competitive_reference_price)
    - name: "Total Cost Change Pct"
      expr: SUM(cost_change_pct)
    - name: "Average Cost Change Pct"
      expr: AVG(cost_change_pct)
    - name: "Total New Cost"
      expr: SUM(new_cost)
    - name: "Average New Cost"
      expr: AVG(new_cost)
    - name: "Total New Margin Pct"
      expr: SUM(new_margin_pct)
    - name: "Average New Margin Pct"
      expr: AVG(new_margin_pct)
    - name: "Total New Retail Price"
      expr: SUM(new_retail_price)
    - name: "Average New Retail Price"
      expr: AVG(new_retail_price)
    - name: "Total Prior Cost"
      expr: SUM(prior_cost)
    - name: "Average Prior Cost"
      expr: AVG(prior_cost)
    - name: "Total Prior Margin Pct"
      expr: SUM(prior_margin_pct)
    - name: "Average Prior Margin Pct"
      expr: AVG(prior_margin_pct)
    - name: "Total Prior Retail Price"
      expr: SUM(prior_retail_price)
    - name: "Average Prior Retail Price"
      expr: AVG(prior_retail_price)
    - name: "Total Retail Price Change Amount"
      expr: SUM(retail_price_change_amount)
    - name: "Average Retail Price Change Amount"
      expr: AVG(retail_price_change_amount)
    - name: "Total Retail Price Change Pct"
      expr: SUM(retail_price_change_pct)
    - name: "Average Retail Price Change Pct"
      expr: AVG(retail_price_change_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price List business metrics"
  source: "`retail_ecm`.`pricing`.`price_list`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Default"
      expr: is_default
    - name: "Is Taxable"
      expr: is_taxable
    - name: "List Type"
      expr: list_type
    - name: "Loyalty Tier Code"
      expr: loyalty_tier_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price List"
      expr: COUNT(DISTINCT price_list_id)
    - name: "Total Base Margin Pct"
      expr: SUM(base_margin_pct)
    - name: "Average Base Margin Pct"
      expr: AVG(base_margin_pct)
    - name: "Total Competitive Index"
      expr: SUM(competitive_index)
    - name: "Average Competitive Index"
      expr: AVG(competitive_index)
    - name: "Total Markdown Pct"
      expr: SUM(markdown_pct)
    - name: "Average Markdown Pct"
      expr: AVG(markdown_pct)
    - name: "Total Max Selling Price"
      expr: SUM(max_selling_price)
    - name: "Average Max Selling Price"
      expr: AVG(max_selling_price)
    - name: "Total Min Selling Price"
      expr: SUM(min_selling_price)
    - name: "Average Min Selling Price"
      expr: AVG(min_selling_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_override`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Override business metrics"
  source: "`retail_ecm`.`pricing`.`price_override`"
  dimensions:
    - name: "Approval Required"
      expr: approval_required
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Channel"
      expr: channel
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Exceeds Threshold"
      expr: exceeds_threshold
    - name: "Override Reference Number"
      expr: override_reference_number
    - name: "Override Status"
      expr: override_status
    - name: "Override Timestamp"
      expr: override_timestamp
    - name: "Override Type"
      expr: override_type
    - name: "Quantity"
      expr: quantity
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Shrinkage Related"
      expr: shrinkage_related
    - name: "Sku"
      expr: sku
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Override"
      expr: COUNT(DISTINCT price_override_id)
    - name: "Total Competitor Price"
      expr: SUM(competitor_price)
    - name: "Average Competitor Price"
      expr: AVG(competitor_price)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
    - name: "Total Override Amount"
      expr: SUM(override_amount)
    - name: "Average Override Amount"
      expr: AVG(override_amount)
    - name: "Total Override Limit Threshold"
      expr: SUM(override_limit_threshold)
    - name: "Average Override Limit Threshold"
      expr: AVG(override_limit_threshold)
    - name: "Total Override Percentage"
      expr: SUM(override_percentage)
    - name: "Average Override Percentage"
      expr: AVG(override_percentage)
    - name: "Total Override Price"
      expr: SUM(override_price)
    - name: "Average Override Price"
      expr: AVG(override_price)
    - name: "Total Total Override Impact"
      expr: SUM(total_override_impact)
    - name: "Average Total Override Impact"
      expr: AVG(total_override_impact)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_sensitivity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Sensitivity business metrics"
  source: "`retail_ecm`.`pricing`.`price_sensitivity`"
  dimensions:
    - name: "Analysis Notes"
      expr: analysis_notes
    - name: "Analysis Period End Date"
      expr: analysis_period_end_date
    - name: "Analysis Period Start Date"
      expr: analysis_period_start_date
    - name: "Analysis Status"
      expr: analysis_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Elasticity Classification"
      expr: elasticity_classification
    - name: "Model Type"
      expr: model_type
    - name: "Sample Size"
      expr: sample_size
    - name: "Source System Code"
      expr: source_system_code
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Analysis Period End Date Month"
      expr: DATE_TRUNC('MONTH', analysis_period_end_date)
    - name: "Analysis Period Start Date Month"
      expr: DATE_TRUNC('MONTH', analysis_period_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Sensitivity"
      expr: COUNT(DISTINCT price_sensitivity_id)
    - name: "Total Baseline Demand Units"
      expr: SUM(baseline_demand_units)
    - name: "Average Baseline Demand Units"
      expr: AVG(baseline_demand_units)
    - name: "Total Competitive Response Factor"
      expr: SUM(competitive_response_factor)
    - name: "Average Competitive Response Factor"
      expr: AVG(competitive_response_factor)
    - name: "Total Confidence Level Pct"
      expr: SUM(confidence_level_pct)
    - name: "Average Confidence Level Pct"
      expr: AVG(confidence_level_pct)
    - name: "Total Cross Price Elasticity"
      expr: SUM(cross_price_elasticity)
    - name: "Average Cross Price Elasticity"
      expr: AVG(cross_price_elasticity)
    - name: "Total Current Retail Price"
      expr: SUM(current_retail_price)
    - name: "Average Current Retail Price"
      expr: AVG(current_retail_price)
    - name: "Total Demand Curve Intercept"
      expr: SUM(demand_curve_intercept)
    - name: "Average Demand Curve Intercept"
      expr: AVG(demand_curve_intercept)
    - name: "Total Demand Curve Slope"
      expr: SUM(demand_curve_slope)
    - name: "Average Demand Curve Slope"
      expr: AVG(demand_curve_slope)
    - name: "Total Elasticity Coefficient"
      expr: SUM(elasticity_coefficient)
    - name: "Average Elasticity Coefficient"
      expr: AVG(elasticity_coefficient)
    - name: "Total Markdown Sensitivity Score"
      expr: SUM(markdown_sensitivity_score)
    - name: "Average Markdown Sensitivity Score"
      expr: AVG(markdown_sensitivity_score)
    - name: "Total Optimal Price Point"
      expr: SUM(optimal_price_point)
    - name: "Average Optimal Price Point"
      expr: AVG(optimal_price_point)
    - name: "Total Price Change Threshold Pct"
      expr: SUM(price_change_threshold_pct)
    - name: "Average Price Change Threshold Pct"
      expr: AVG(price_change_threshold_pct)
    - name: "Total Profit Maximizing Price"
      expr: SUM(profit_maximizing_price)
    - name: "Average Profit Maximizing Price"
      expr: AVG(profit_maximizing_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_strategy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Strategy business metrics"
  source: "`retail_ecm`.`pricing`.`price_strategy`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Scope"
      expr: channel_scope
    - name: "Competitor Benchmark Set"
      expr: competitor_benchmark_set
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dynamic Pricing Enabled"
      expr: dynamic_pricing_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hilo Swing Frequency Days"
      expr: hilo_swing_frequency_days
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Map Enforcement Enabled"
      expr: map_enforcement_enabled
    - name: "Markdown Optimization Enabled"
      expr: markdown_optimization_enabled
    - name: "Notes"
      expr: notes
    - name: "Price Change Approval Required"
      expr: price_change_approval_required
    - name: "Price Review Frequency"
      expr: price_review_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Strategy"
      expr: COUNT(DISTINCT price_strategy_id)
    - name: "Total Approval Threshold Pct"
      expr: SUM(approval_threshold_pct)
    - name: "Average Approval Threshold Pct"
      expr: AVG(approval_threshold_pct)
    - name: "Total Aur Floor"
      expr: SUM(aur_floor)
    - name: "Average Aur Floor"
      expr: AVG(aur_floor)
    - name: "Total Competitive Index Target"
      expr: SUM(competitive_index_target)
    - name: "Average Competitive Index Target"
      expr: AVG(competitive_index_target)
    - name: "Total Cost Plus Markup Pct"
      expr: SUM(cost_plus_markup_pct)
    - name: "Average Cost Plus Markup Pct"
      expr: AVG(cost_plus_markup_pct)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Hilo Promo Depth Pct"
      expr: SUM(hilo_promo_depth_pct)
    - name: "Average Hilo Promo Depth Pct"
      expr: AVG(hilo_promo_depth_pct)
    - name: "Total Private Label Differential Pct"
      expr: SUM(private_label_differential_pct)
    - name: "Average Private Label Differential Pct"
      expr: AVG(private_label_differential_pct)
    - name: "Total Sell Through Rate Target Pct"
      expr: SUM(sell_through_rate_target_pct)
    - name: "Average Sell Through Rate Target Pct"
      expr: AVG(sell_through_rate_target_pct)
    - name: "Total Target Margin Max Pct"
      expr: SUM(target_margin_max_pct)
    - name: "Average Target Margin Max Pct"
      expr: AVG(target_margin_max_pct)
    - name: "Total Target Margin Min Pct"
      expr: SUM(target_margin_min_pct)
    - name: "Average Target Margin Min Pct"
      expr: AVG(target_margin_min_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_price_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Zone business metrics"
  source: "`retail_ecm`.`pricing`.`price_zone`"
  dimensions:
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fulfillment Node Count"
      expr: fulfillment_node_count
    - name: "Is Competitive Zone"
      expr: is_competitive_zone
    - name: "Is Default Zone"
      expr: is_default_zone
    - name: "Is Ecommerce Enabled"
      expr: is_ecommerce_enabled
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Market Tier"
      expr: market_tier
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Override Allowed"
      expr: override_allowed
    - name: "Price Approval Required"
      expr: price_approval_required
    - name: "Price Change Lead Days"
      expr: price_change_lead_days
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Zone"
      expr: COUNT(DISTINCT price_zone_id)
    - name: "Total Base Price Multiplier"
      expr: SUM(base_price_multiplier)
    - name: "Average Base Price Multiplier"
      expr: AVG(base_price_multiplier)
    - name: "Total Competitive Index"
      expr: SUM(competitive_index)
    - name: "Average Competitive Index"
      expr: AVG(competitive_index)
    - name: "Total Max Markdown Pct"
      expr: SUM(max_markdown_pct)
    - name: "Average Max Markdown Pct"
      expr: AVG(max_markdown_pct)
    - name: "Total Min Margin Pct"
      expr: SUM(min_margin_pct)
    - name: "Average Min Margin Pct"
      expr: AVG(min_margin_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rule business metrics"
  source: "`retail_ecm`.`pricing`.`rule`"
  dimensions:
    - name: "Adjustment Method"
      expr: adjustment_method
    - name: "Algorithm Version"
      expr: algorithm_version
    - name: "Applicable Days Of Week"
      expr: applicable_days_of_week
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Mode"
      expr: execution_mode
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Loyalty Exclusive"
      expr: loyalty_exclusive
    - name: "Override Approval Required"
      expr: override_approval_required
    - name: "Override Permitted"
      expr: override_permitted
    - name: "Priority"
      expr: priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rule"
      expr: COUNT(DISTINCT rule_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
    - name: "Total Competitor Price Index"
      expr: SUM(competitor_price_index)
    - name: "Average Competitor Price Index"
      expr: AVG(competitor_price_index)
    - name: "Total Cost Plus Margin Pct"
      expr: SUM(cost_plus_margin_pct)
    - name: "Average Cost Plus Margin Pct"
      expr: AVG(cost_plus_margin_pct)
    - name: "Total Markdown Depth Pct"
      expr: SUM(markdown_depth_pct)
    - name: "Average Markdown Depth Pct"
      expr: AVG(markdown_depth_pct)
    - name: "Total Max Price"
      expr: SUM(max_price)
    - name: "Average Max Price"
      expr: AVG(max_price)
    - name: "Total Min Price"
      expr: SUM(min_price)
    - name: "Average Min Price"
      expr: AVG(min_price)
    - name: "Total Sell Through Target Pct"
      expr: SUM(sell_through_target_pct)
    - name: "Average Sell Through Target Pct"
      expr: AVG(sell_through_target_pct)
    - name: "Total Trigger Threshold Value"
      expr: SUM(trigger_threshold_value)
    - name: "Average Trigger Threshold Value"
      expr: AVG(trigger_threshold_value)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_rule_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rule Application business metrics"
  source: "`retail_ecm`.`pricing`.`rule_application`"
  dimensions:
    - name: "Adjustment Method"
      expr: adjustment_method
    - name: "Application Status"
      expr: application_status
    - name: "Created Date"
      expr: created_date
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Execution Sequence"
      expr: execution_sequence
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Override Permitted"
      expr: override_permitted
    - name: "Rule Priority"
      expr: rule_priority
    - name: "Stackable Flag"
      expr: stackable_flag
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rule Application"
      expr: COUNT(DISTINCT rule_application_id)
    - name: "Total Adjustment Value"
      expr: SUM(adjustment_value)
    - name: "Average Adjustment Value"
      expr: AVG(adjustment_value)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_sku_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sku Price business metrics"
  source: "`retail_ecm`.`pricing`.`sku_price`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Channel Price Variance Reason"
      expr: channel_price_variance_reason
    - name: "Channel Type"
      expr: channel_type
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Dynamic Pricing Enabled"
      expr: is_dynamic_pricing_enabled
    - name: "Is Price Locked"
      expr: is_price_locked
    - name: "Price Change Reason"
      expr: price_change_reason
    - name: "Price Per Unit Uom"
      expr: price_per_unit_uom
    - name: "Price Resolution Priority"
      expr: price_resolution_priority
    - name: "Price Type"
      expr: price_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sku Price"
      expr: COUNT(DISTINCT sku_price_id)
    - name: "Total Channel Price Variance"
      expr: SUM(channel_price_variance)
    - name: "Average Channel Price Variance"
      expr: AVG(channel_price_variance)
    - name: "Total Competitive Price Ref"
      expr: SUM(competitive_price_ref)
    - name: "Average Competitive Price Ref"
      expr: AVG(competitive_price_ref)
    - name: "Total Gross Margin Pct"
      expr: SUM(gross_margin_pct)
    - name: "Average Gross Margin Pct"
      expr: AVG(gross_margin_pct)
    - name: "Total Initial Markup Pct"
      expr: SUM(initial_markup_pct)
    - name: "Average Initial Markup Pct"
      expr: AVG(initial_markup_pct)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Markdown Pct"
      expr: SUM(markdown_pct)
    - name: "Average Markdown Pct"
      expr: AVG(markdown_pct)
    - name: "Total Min Advertised Price"
      expr: SUM(min_advertised_price)
    - name: "Average Min Advertised Price"
      expr: AVG(min_advertised_price)
    - name: "Total Original Retail Price"
      expr: SUM(original_retail_price)
    - name: "Average Original Retail Price"
      expr: AVG(original_retail_price)
    - name: "Total Price Ceiling"
      expr: SUM(price_ceiling)
    - name: "Average Price Ceiling"
      expr: AVG(price_ceiling)
    - name: "Total Price Floor"
      expr: SUM(price_floor)
    - name: "Average Price Floor"
      expr: AVG(price_floor)
    - name: "Total Price Per Unit Display"
      expr: SUM(price_per_unit_display)
    - name: "Average Price Per Unit Display"
      expr: AVG(price_per_unit_display)
    - name: "Total Retail Price"
      expr: SUM(retail_price)
    - name: "Average Retail Price"
      expr: AVG(retail_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`pricing_zone_price_list_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zone Price List Assignment business metrics"
  source: "`retail_ecm`.`pricing`.`zone_price_list_assignment`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Assigned By"
      expr: assigned_by
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Assignment Reason"
      expr: assignment_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Is Active"
      expr: is_active
    - name: "Override Rules"
      expr: override_rules
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Source System Code"
      expr: source_system_code
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
    - name: "Assigned Timestamp Month"
      expr: DATE_TRUNC('MONTH', assigned_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Zone Price List Assignment"
      expr: COUNT(DISTINCT zone_price_list_assignment_id)
    - name: "Total Currency Conversion Rate"
      expr: SUM(currency_conversion_rate)
    - name: "Average Currency Conversion Rate"
      expr: AVG(currency_conversion_rate)
$$;