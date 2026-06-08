-- Metric views for domain: merchandising | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:07:57

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_assortment_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment Item business metrics"
  source: "`retail_ecm`.`merchandising`.`assortment_item`"
  dimensions:
    - name: "Assortment Depth Tier"
      expr: assortment_depth_tier
    - name: "Assortment Role"
      expr: assortment_role
    - name: "Attributes Checklist Complete"
      expr: attributes_checklist_complete
    - name: "Clearance Strategy"
      expr: clearance_strategy
    - name: "Cpsc Certification Status"
      expr: cpsc_certification_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Reason"
      expr: discontinuation_reason
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fda Certification Status"
      expr: fda_certification_status
    - name: "Final Disposition Date"
      expr: final_disposition_date
    - name: "Go Live Date"
      expr: go_live_date
    - name: "Inclusion Status"
      expr: inclusion_status
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Order Date"
      expr: last_order_date
    - name: "Lifecycle Stage"
      expr: lifecycle_stage
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment Item"
      expr: COUNT(DISTINCT assortment_item_id)
    - name: "Total Planned Aur"
      expr: SUM(planned_aur)
    - name: "Average Planned Aur"
      expr: AVG(planned_aur)
    - name: "Total Planned Gmroi"
      expr: SUM(planned_gmroi)
    - name: "Average Planned Gmroi"
      expr: AVG(planned_gmroi)
    - name: "Total Planned Sell Through Rate"
      expr: SUM(planned_sell_through_rate)
    - name: "Average Planned Sell Through Rate"
      expr: AVG(planned_sell_through_rate)
    - name: "Total Planned Weeks Of Supply"
      expr: SUM(planned_weeks_of_supply)
    - name: "Average Planned Weeks Of Supply"
      expr: AVG(planned_weeks_of_supply)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_assortment_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Assortment Plan business metrics"
  source: "`retail_ecm`.`merchandising`.`assortment_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Cluster Strategy Description"
      expr: cluster_strategy_description
    - name: "Clustering Methodology"
      expr: clustering_methodology
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "External Plan Reference"
      expr: external_plan_reference
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Review Date"
      expr: last_review_date
    - name: "National Brand Sku Count"
      expr: national_brand_sku_count
    - name: "Next Review Date"
      expr: next_review_date
    - name: "Notes"
      expr: notes
    - name: "Otb Currency Code"
      expr: otb_currency_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Assortment Plan"
      expr: COUNT(DISTINCT assortment_plan_id)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Private Label Mix Percent"
      expr: SUM(private_label_mix_percent)
    - name: "Average Private Label Mix Percent"
      expr: AVG(private_label_mix_percent)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Inventory Turn Rate"
      expr: SUM(target_inventory_turn_rate)
    - name: "Average Target Inventory Turn Rate"
      expr: AVG(target_inventory_turn_rate)
    - name: "Total Target Sell Through Rate Percent"
      expr: SUM(target_sell_through_rate_percent)
    - name: "Average Target Sell Through Rate Percent"
      expr: AVG(target_sell_through_rate_percent)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buyer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer business metrics"
  source: "`retail_ecm`.`merchandising`.`buyer`"
  dimensions:
    - name: "Assigned Category Codes"
      expr: assigned_category_codes
    - name: "Assigned Department Codes"
      expr: assigned_department_codes
    - name: "Assortment Planning System Access"
      expr: assortment_planning_system_access
    - name: "Buyer Code"
      expr: buyer_code
    - name: "Buyer Name"
      expr: buyer_name
    - name: "Buyer Status"
      expr: buyer_status
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Certification Credentials"
      expr: certification_credentials
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Division Code"
      expr: division_code
    - name: "Email Address"
      expr: email_address
    - name: "Hire Date"
      expr: hire_date
    - name: "International Sourcing Flag"
      expr: international_sourcing_flag
    - name: "Language Proficiency"
      expr: language_proficiency
    - name: "Last Modified By User"
      expr: last_modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer"
      expr: COUNT(DISTINCT buyer_id)
    - name: "Total Buying Authority Limit"
      expr: SUM(buying_authority_limit)
    - name: "Average Buying Authority Limit"
      expr: AVG(buying_authority_limit)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Inventory Turn Target"
      expr: SUM(inventory_turn_target)
    - name: "Average Inventory Turn Target"
      expr: AVG(inventory_turn_target)
    - name: "Total Markdown Percentage Limit"
      expr: SUM(markdown_percentage_limit)
    - name: "Average Markdown Percentage Limit"
      expr: AVG(markdown_percentage_limit)
    - name: "Total Otb Budget Limit"
      expr: SUM(otb_budget_limit)
    - name: "Average Otb Budget Limit"
      expr: AVG(otb_budget_limit)
    - name: "Total Sell Through Rate Target"
      expr: SUM(sell_through_rate_target)
    - name: "Average Sell Through Rate Target"
      expr: AVG(sell_through_rate_target)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buyer_profit_center_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buyer Profit Center Assignment business metrics"
  source: "`retail_ecm`.`merchandising`.`buyer_profit_center_assignment`"
  dimensions:
    - name: "Assigned Category List"
      expr: assigned_category_list
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Primary Flag"
      expr: primary_flag
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
    - name: "Effective Start Date Month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buyer Profit Center Assignment"
      expr: COUNT(DISTINCT buyer_profit_center_assignment_id)
    - name: "Total Otb Allocation Amount"
      expr: SUM(otb_allocation_amount)
    - name: "Average Otb Allocation Amount"
      expr: AVG(otb_allocation_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buying_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buying Order business metrics"
  source: "`retail_ecm`.`merchandising`.`buying_order`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Workflow Code"
      expr: approval_workflow_code
    - name: "Cancel Date"
      expr: cancel_date
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Type"
      expr: destination_type
    - name: "Fob Terms"
      expr: fob_terms
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Order Date"
      expr: order_date
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Planned Receipt Date"
      expr: planned_receipt_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buying Order"
      expr: COUNT(DISTINCT buying_order_id)
    - name: "Total Duty Cost"
      expr: SUM(duty_cost)
    - name: "Average Duty Cost"
      expr: AVG(duty_cost)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Freight Cost"
      expr: SUM(freight_cost)
    - name: "Average Freight Cost"
      expr: AVG(freight_cost)
    - name: "Total Landed Cost"
      expr: SUM(landed_cost)
    - name: "Average Landed Cost"
      expr: AVG(landed_cost)
    - name: "Total Total Order Cost"
      expr: SUM(total_order_cost)
    - name: "Average Total Order Cost"
      expr: AVG(total_order_cost)
    - name: "Total Total Order Quantity"
      expr: SUM(total_order_quantity)
    - name: "Average Total Order Quantity"
      expr: AVG(total_order_quantity)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_buying_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Buying Order Line business metrics"
  source: "`retail_ecm`.`merchandising`.`buying_order_line`"
  dimensions:
    - name: "Cancel Date"
      expr: cancel_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Date"
      expr: delivery_date
    - name: "Drop Ship Flag"
      expr: drop_ship_flag
    - name: "Gtin"
      expr: gtin
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Pack Size"
      expr: pack_size
    - name: "Private Label Flag"
      expr: private_label_flag
    - name: "Product Description"
      expr: product_description
    - name: "Sku"
      expr: sku
    - name: "Store Cluster Code"
      expr: store_cluster_code
    - name: "Upc"
      expr: upc
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Buying Order Line"
      expr: COUNT(DISTINCT buying_order_line_id)
    - name: "Total Allocation Quantity"
      expr: SUM(allocation_quantity)
    - name: "Average Allocation Quantity"
      expr: AVG(allocation_quantity)
    - name: "Total Cancelled Quantity"
      expr: SUM(cancelled_quantity)
    - name: "Average Cancelled Quantity"
      expr: AVG(cancelled_quantity)
    - name: "Total Extended Cost"
      expr: SUM(extended_cost)
    - name: "Average Extended Cost"
      expr: AVG(extended_cost)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Planned Margin Amount"
      expr: SUM(planned_margin_amount)
    - name: "Average Planned Margin Amount"
      expr: AVG(planned_margin_amount)
    - name: "Total Planned Margin Percent"
      expr: SUM(planned_margin_percent)
    - name: "Average Planned Margin Percent"
      expr: AVG(planned_margin_percent)
    - name: "Total Received Quantity"
      expr: SUM(received_quantity)
    - name: "Average Received Quantity"
      expr: AVG(received_quantity)
    - name: "Total Retail Price"
      expr: SUM(retail_price)
    - name: "Average Retail Price"
      expr: AVG(retail_price)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category business metrics"
  source: "`retail_ecm`.`merchandising`.`category`"
  dimensions:
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Assortment Gap Findings"
      expr: assortment_gap_findings
    - name: "Category Code"
      expr: category_code
    - name: "Category Description"
      expr: category_description
    - name: "Category Name"
      expr: category_name
    - name: "Category Role"
      expr: category_role
    - name: "Category Status"
      expr: category_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Division"
      expr: division
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Leaf Node"
      expr: is_leaf_node
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category"
      expr: COUNT(DISTINCT category_id)
    - name: "Total Actual Gmroi"
      expr: SUM(actual_gmroi)
    - name: "Average Actual Gmroi"
      expr: AVG(actual_gmroi)
    - name: "Total Actual Sell Through Rate"
      expr: SUM(actual_sell_through_rate)
    - name: "Average Actual Sell Through Rate"
      expr: AVG(actual_sell_through_rate)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Private Label Penetration Target"
      expr: SUM(private_label_penetration_target)
    - name: "Average Private Label Penetration Target"
      expr: AVG(private_label_penetration_target)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Inventory Turns"
      expr: SUM(target_inventory_turns)
    - name: "Average Target Inventory Turns"
      expr: AVG(target_inventory_turns)
    - name: "Total Target Margin Percent"
      expr: SUM(target_margin_percent)
    - name: "Average Target Margin Percent"
      expr: AVG(target_margin_percent)
    - name: "Total Target Sell Through Rate"
      expr: SUM(target_sell_through_rate)
    - name: "Average Target Sell Through Rate"
      expr: AVG(target_sell_through_rate)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_category_accrual_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Accrual Rule business metrics"
  source: "`retail_ecm`.`merchandising`.`category_accrual_rule`"
  dimensions:
    - name: "Category Accrual Rule Status"
      expr: category_accrual_rule_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Rule Priority"
      expr: rule_priority
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Accrual Rule"
      expr: COUNT(DISTINCT category_accrual_rule_id)
    - name: "Total Minimum Spend Threshold"
      expr: SUM(minimum_spend_threshold)
    - name: "Average Minimum Spend Threshold"
      expr: AVG(minimum_spend_threshold)
    - name: "Total Points Multiplier"
      expr: SUM(points_multiplier)
    - name: "Average Points Multiplier"
      expr: AVG(points_multiplier)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_category_campaign_placement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Category Campaign Placement business metrics"
  source: "`retail_ecm`.`merchandising`.`category_campaign_placement`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Is Featured"
      expr: is_featured
    - name: "Placement Status"
      expr: placement_status
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective End Date Month"
      expr: DATE_TRUNC('MONTH', effective_end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Category Campaign Placement"
      expr: COUNT(DISTINCT category_campaign_placement_id)
    - name: "Total Actual Sales Amount"
      expr: SUM(actual_sales_amount)
    - name: "Average Actual Sales Amount"
      expr: AVG(actual_sales_amount)
    - name: "Total Actual Spend Amount"
      expr: SUM(actual_spend_amount)
    - name: "Average Actual Spend Amount"
      expr: AVG(actual_spend_amount)
    - name: "Total Budget Allocation Amount"
      expr: SUM(budget_allocation_amount)
    - name: "Average Budget Allocation Amount"
      expr: AVG(budget_allocation_amount)
    - name: "Total Target Sales Amount"
      expr: SUM(target_sales_amount)
    - name: "Average Target Sales Amount"
      expr: AVG(target_sales_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_markdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown Event business metrics"
  source: "`retail_ecm`.`merchandising`.`markdown_event`"
  dimensions:
    - name: "Actual Units Sold"
      expr: actual_units_sold
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Markdown Number"
      expr: markdown_number
    - name: "Markdown Reason"
      expr: markdown_reason
    - name: "Markdown Status"
      expr: markdown_status
    - name: "Markdown Type"
      expr: markdown_type
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Projected Units Sold"
      expr: projected_units_sold
    - name: "Approval Timestamp Month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Markdown Event"
      expr: COUNT(DISTINCT markdown_event_id)
    - name: "Total Actual Margin Impact"
      expr: SUM(actual_margin_impact)
    - name: "Average Actual Margin Impact"
      expr: AVG(actual_margin_impact)
    - name: "Total Actual Revenue Impact"
      expr: SUM(actual_revenue_impact)
    - name: "Average Actual Revenue Impact"
      expr: AVG(actual_revenue_impact)
    - name: "Total Actual Sell Through Lift Percentage"
      expr: SUM(actual_sell_through_lift_percentage)
    - name: "Average Actual Sell Through Lift Percentage"
      expr: AVG(actual_sell_through_lift_percentage)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Markdown Percentage"
      expr: SUM(markdown_percentage)
    - name: "Average Markdown Percentage"
      expr: AVG(markdown_percentage)
    - name: "Total Markdown Price"
      expr: SUM(markdown_price)
    - name: "Average Markdown Price"
      expr: AVG(markdown_price)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
    - name: "Total Projected Margin Impact"
      expr: SUM(projected_margin_impact)
    - name: "Average Projected Margin Impact"
      expr: AVG(projected_margin_impact)
    - name: "Total Projected Revenue Impact"
      expr: SUM(projected_revenue_impact)
    - name: "Average Projected Revenue Impact"
      expr: AVG(projected_revenue_impact)
    - name: "Total Projected Sell Through Lift Percentage"
      expr: SUM(projected_sell_through_lift_percentage)
    - name: "Average Projected Sell Through Lift Percentage"
      expr: AVG(projected_sell_through_lift_percentage)
    - name: "Total Vendor Contribution Amount"
      expr: SUM(vendor_contribution_amount)
    - name: "Average Vendor Contribution Amount"
      expr: AVG(vendor_contribution_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_merch_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merch Plan business metrics"
  source: "`retail_ecm`.`merchandising`.`merch_plan`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Is Active"
      expr: is_active
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Plan Code"
      expr: plan_code
    - name: "Plan End Date"
      expr: plan_end_date
    - name: "Plan Name"
      expr: plan_name
    - name: "Plan Notes"
      expr: plan_notes
    - name: "Plan Start Date"
      expr: plan_start_date
    - name: "Plan Status"
      expr: plan_status
    - name: "Plan Type"
      expr: plan_type
    - name: "Source System Code"
      expr: source_system_code
    - name: "Approval Date Month"
      expr: DATE_TRUNC('MONTH', approval_date)
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Merch Plan"
      expr: COUNT(DISTINCT merch_plan_id)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Inventory Turn Target"
      expr: SUM(inventory_turn_target)
    - name: "Average Inventory Turn Target"
      expr: AVG(inventory_turn_target)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Planned Beginning Inventory Amount"
      expr: SUM(planned_beginning_inventory_amount)
    - name: "Average Planned Beginning Inventory Amount"
      expr: AVG(planned_beginning_inventory_amount)
    - name: "Total Planned Cost Amount"
      expr: SUM(planned_cost_amount)
    - name: "Average Planned Cost Amount"
      expr: AVG(planned_cost_amount)
    - name: "Total Planned Ending Inventory Amount"
      expr: SUM(planned_ending_inventory_amount)
    - name: "Average Planned Ending Inventory Amount"
      expr: AVG(planned_ending_inventory_amount)
    - name: "Total Planned Margin Amount"
      expr: SUM(planned_margin_amount)
    - name: "Average Planned Margin Amount"
      expr: AVG(planned_margin_amount)
    - name: "Total Planned Margin Percent"
      expr: SUM(planned_margin_percent)
    - name: "Average Planned Margin Percent"
      expr: AVG(planned_margin_percent)
    - name: "Total Planned Markdown Amount"
      expr: SUM(planned_markdown_amount)
    - name: "Average Planned Markdown Amount"
      expr: AVG(planned_markdown_amount)
    - name: "Total Planned Markdown Percent"
      expr: SUM(planned_markdown_percent)
    - name: "Average Planned Markdown Percent"
      expr: AVG(planned_markdown_percent)
    - name: "Total Planned Receipt Amount"
      expr: SUM(planned_receipt_amount)
    - name: "Average Planned Receipt Amount"
      expr: AVG(planned_receipt_amount)
    - name: "Total Planned Sales Amount"
      expr: SUM(planned_sales_amount)
    - name: "Average Planned Sales Amount"
      expr: AVG(planned_sales_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_merchandising_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Merchandising Planogram business metrics"
  source: "`retail_ecm`.`merchandising`.`merchandising_planogram`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Compliance Required Flag"
      expr: compliance_required_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Implementation Instructions"
      expr: implementation_instructions
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Reset Date"
      expr: last_reset_date
    - name: "Merchandising Planogram Status"
      expr: merchandising_planogram_status
    - name: "Next Scheduled Reset Date"
      expr: next_scheduled_reset_date
    - name: "Planogram Code"
      expr: planogram_code
    - name: "Planogram Name"
      expr: planogram_name
    - name: "Seasonal Flag"
      expr: seasonal_flag
    - name: "Shelf Count"
      expr: shelf_count
    - name: "Space Planning System Code"
      expr: space_planning_system_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Merchandising Planogram"
      expr: COUNT(DISTINCT merchandising_planogram_id)
    - name: "Total Compliance Tolerance Pct"
      expr: SUM(compliance_tolerance_pct)
    - name: "Average Compliance Tolerance Pct"
      expr: AVG(compliance_tolerance_pct)
    - name: "Total Fixture Depth Cm"
      expr: SUM(fixture_depth_cm)
    - name: "Average Fixture Depth Cm"
      expr: AVG(fixture_depth_cm)
    - name: "Total Fixture Height Cm"
      expr: SUM(fixture_height_cm)
    - name: "Average Fixture Height Cm"
      expr: AVG(fixture_height_cm)
    - name: "Total Fixture Width Cm"
      expr: SUM(fixture_width_cm)
    - name: "Average Fixture Width Cm"
      expr: AVG(fixture_width_cm)
    - name: "Total Space Allocation Sqft"
      expr: SUM(space_allocation_sqft)
    - name: "Average Space Allocation Sqft"
      expr: AVG(space_allocation_sqft)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Sales Per Sqft"
      expr: SUM(target_sales_per_sqft)
    - name: "Average Target Sales Per Sqft"
      expr: AVG(target_sales_per_sqft)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_otb_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Otb Budget business metrics"
  source: "`retail_ecm`.`merchandising`.`otb_budget`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Budget End Date"
      expr: budget_end_date
    - name: "Budget Name"
      expr: budget_name
    - name: "Budget Number"
      expr: budget_number
    - name: "Budget Start Date"
      expr: budget_start_date
    - name: "Budget Status"
      expr: budget_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Last Reconciliation Date"
      expr: last_reconciliation_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Notes"
      expr: notes
    - name: "Approved Timestamp Month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Otb Budget"
      expr: COUNT(DISTINCT otb_budget_id)
    - name: "Total Actual Receipts At Cost"
      expr: SUM(actual_receipts_at_cost)
    - name: "Average Actual Receipts At Cost"
      expr: AVG(actual_receipts_at_cost)
    - name: "Total Available Otb Balance"
      expr: SUM(available_otb_balance)
    - name: "Average Available Otb Balance"
      expr: AVG(available_otb_balance)
    - name: "Total Budget Adjustment Amount"
      expr: SUM(budget_adjustment_amount)
    - name: "Average Budget Adjustment Amount"
      expr: AVG(budget_adjustment_amount)
    - name: "Total Budget Decrease Amount"
      expr: SUM(budget_decrease_amount)
    - name: "Average Budget Decrease Amount"
      expr: AVG(budget_decrease_amount)
    - name: "Total Budget Increase Amount"
      expr: SUM(budget_increase_amount)
    - name: "Average Budget Increase Amount"
      expr: AVG(budget_increase_amount)
    - name: "Total Budget Transfer In Amount"
      expr: SUM(budget_transfer_in_amount)
    - name: "Average Budget Transfer In Amount"
      expr: AVG(budget_transfer_in_amount)
    - name: "Total Budget Transfer Out Amount"
      expr: SUM(budget_transfer_out_amount)
    - name: "Average Budget Transfer Out Amount"
      expr: AVG(budget_transfer_out_amount)
    - name: "Total Committed Amount"
      expr: SUM(committed_amount)
    - name: "Average Committed Amount"
      expr: AVG(committed_amount)
    - name: "Total Gmroi Target"
      expr: SUM(gmroi_target)
    - name: "Average Gmroi Target"
      expr: AVG(gmroi_target)
    - name: "Total Inventory Turn Target"
      expr: SUM(inventory_turn_target)
    - name: "Average Inventory Turn Target"
      expr: AVG(inventory_turn_target)
    - name: "Total Markdown Budget Pct"
      expr: SUM(markdown_budget_pct)
    - name: "Average Markdown Budget Pct"
      expr: AVG(markdown_budget_pct)
    - name: "Total Planned Receipts At Cost"
      expr: SUM(planned_receipts_at_cost)
    - name: "Average Planned Receipts At Cost"
      expr: AVG(planned_receipts_at_cost)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_planogram_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram Position business metrics"
  source: "`retail_ecm`.`merchandising`.`planogram_position`"
  dimensions:
    - name: "Bay Number"
      expr: bay_number
    - name: "Capacity Units"
      expr: capacity_units
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Orientation"
      expr: display_orientation
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Facing Count"
      expr: facing_count
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Is Hero Position"
      expr: is_hero_position
    - name: "Is New Item"
      expr: is_new_item
    - name: "Is Promotional"
      expr: is_promotional
    - name: "Last Audit Date"
      expr: last_audit_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Facings"
      expr: maximum_facings
    - name: "Merchandising Zone"
      expr: merchandising_zone
    - name: "Minimum Facings"
      expr: minimum_facings
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Planogram Position"
      expr: COUNT(DISTINCT planogram_position_id)
    - name: "Total Compliance Score"
      expr: SUM(compliance_score)
    - name: "Average Compliance Score"
      expr: AVG(compliance_score)
    - name: "Total Position Depth Cm"
      expr: SUM(position_depth_cm)
    - name: "Average Position Depth Cm"
      expr: AVG(position_depth_cm)
    - name: "Total Position Height Cm"
      expr: SUM(position_height_cm)
    - name: "Average Position Height Cm"
      expr: AVG(position_height_cm)
    - name: "Total Position Width Cm"
      expr: SUM(position_width_cm)
    - name: "Average Position Width Cm"
      expr: AVG(position_width_cm)
    - name: "Total Space Productivity Index"
      expr: SUM(space_productivity_index)
    - name: "Average Space Productivity Index"
      expr: AVG(space_productivity_index)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_private_label_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Private Label Program business metrics"
  source: "`retail_ecm`.`merchandising`.`private_label_program`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Competitive Positioning"
      expr: competitive_positioning
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Exclusive Flag"
      expr: exclusive_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Launch Date"
      expr: launch_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Markdown Strategy"
      expr: markdown_strategy
    - name: "Minimum Order Quantity"
      expr: minimum_order_quantity
    - name: "Packaging Specification"
      expr: packaging_specification
    - name: "Program Code"
      expr: program_code
    - name: "Program Description"
      expr: program_description
    - name: "Program Status"
      expr: program_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Private Label Program"
      expr: COUNT(DISTINCT private_label_program_id)
    - name: "Total Marketing Investment Usd"
      expr: SUM(marketing_investment_usd)
    - name: "Average Marketing Investment Usd"
      expr: AVG(marketing_investment_usd)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Margin Premium Pct"
      expr: SUM(target_margin_premium_pct)
    - name: "Average Target Margin Premium Pct"
      expr: AVG(target_margin_premium_pct)
    - name: "Total Target Price Point Usd"
      expr: SUM(target_price_point_usd)
    - name: "Average Target Price Point Usd"
      expr: AVG(target_price_point_usd)
    - name: "Total Target Sell Through Rate Pct"
      expr: SUM(target_sell_through_rate_pct)
    - name: "Average Target Sell Through Rate Pct"
      expr: AVG(target_sell_through_rate_pct)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Season business metrics"
  source: "`retail_ecm`.`merchandising`.`season`"
  dimensions:
    - name: "Assortment Breadth Target"
      expr: assortment_breadth_target
    - name: "Assortment Depth Target"
      expr: assortment_depth_target
    - name: "Buy Deadline Date"
      expr: buy_deadline_date
    - name: "Clearance Exit Date"
      expr: clearance_exit_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Date"
      expr: end_date
    - name: "First Receipt Date"
      expr: first_receipt_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Is Active"
      expr: is_active
    - name: "Line Review Date"
      expr: line_review_date
    - name: "Markdown Entry Date"
      expr: markdown_entry_date
    - name: "Notes"
      expr: notes
    - name: "Planning Start Date"
      expr: planning_start_date
    - name: "Season Code"
      expr: season_code
    - name: "Season Name"
      expr: season_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Season"
      expr: COUNT(DISTINCT season_id)
    - name: "Total Otb Budget Amount"
      expr: SUM(otb_budget_amount)
    - name: "Average Otb Budget Amount"
      expr: AVG(otb_budget_amount)
    - name: "Total Target Gmroi"
      expr: SUM(target_gmroi)
    - name: "Average Target Gmroi"
      expr: AVG(target_gmroi)
    - name: "Total Target Inventory Turns"
      expr: SUM(target_inventory_turns)
    - name: "Average Target Inventory Turns"
      expr: AVG(target_inventory_turns)
    - name: "Total Target Sell Through Rate"
      expr: SUM(target_sell_through_rate)
    - name: "Average Target Sell Through Rate"
      expr: AVG(target_sell_through_rate)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`merchandising_vendor_negotiation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor Negotiation business metrics"
  source: "`retail_ecm`.`merchandising`.`vendor_negotiation`"
  dimensions:
    - name: "Allowance Type"
      expr: allowance_type
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Cost Change Reason Code"
      expr: cost_change_reason_code
    - name: "Cost Change Reason Description"
      expr: cost_change_reason_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Incoterms"
      expr: incoterms
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Moq"
      expr: moq
    - name: "Moq Unit Of Measure"
      expr: moq_unit_of_measure
    - name: "Negotiation End Date"
      expr: negotiation_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Vendor Negotiation"
      expr: COUNT(DISTINCT vendor_negotiation_id)
    - name: "Total Allowance Amount"
      expr: SUM(allowance_amount)
    - name: "Average Allowance Amount"
      expr: AVG(allowance_amount)
    - name: "Total Coop Advertising Fund"
      expr: SUM(coop_advertising_fund)
    - name: "Average Coop Advertising Fund"
      expr: AVG(coop_advertising_fund)
    - name: "Total Cost Change Percentage"
      expr: SUM(cost_change_percentage)
    - name: "Average Cost Change Percentage"
      expr: AVG(cost_change_percentage)
    - name: "Total Fill Rate Commitment Percentage"
      expr: SUM(fill_rate_commitment_percentage)
    - name: "Average Fill Rate Commitment Percentage"
      expr: AVG(fill_rate_commitment_percentage)
    - name: "Total Markdown Support Amount"
      expr: SUM(markdown_support_amount)
    - name: "Average Markdown Support Amount"
      expr: AVG(markdown_support_amount)
    - name: "Total New Cost Price"
      expr: SUM(new_cost_price)
    - name: "Average New Cost Price"
      expr: AVG(new_cost_price)
    - name: "Total Old Cost Price"
      expr: SUM(old_cost_price)
    - name: "Average Old Cost Price"
      expr: AVG(old_cost_price)
$$;