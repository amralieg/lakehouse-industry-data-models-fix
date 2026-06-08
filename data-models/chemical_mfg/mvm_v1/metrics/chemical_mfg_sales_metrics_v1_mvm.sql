-- Metric views for domain: sales | Business: Chemical Mfg | Version: 1 | Generated on: 2026-05-06 14:35:24

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_distributor`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`distributor`"
  dimensions:
    - name: "Agreement Effective Date"
      expr: agreement_effective_date
    - name: "Agreement Expiry Date"
      expr: agreement_expiry_date
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Authorized Product Categories"
      expr: authorized_product_categories
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Certification Expiry Date"
      expr: certification_expiry_date
    - name: "Channel Type"
      expr: channel_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Currency Code"
      expr: credit_currency_code
    - name: "Distributor Code"
      expr: distributor_code
    - name: "Distributor Status"
      expr: distributor_status
    - name: "Distributor Tier"
      expr: distributor_tier
    - name: "Distributor Type"
      expr: distributor_type
    - name: "Duns Number"
      expr: duns_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Distributor"
      expr: COUNT(DISTINCT distributor_id)
    - name: "Total Annual Purchase Commitment"
      expr: SUM(annual_purchase_commitment)
    - name: "Average Annual Purchase Commitment"
      expr: AVG(annual_purchase_commitment)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Moq Kg"
      expr: SUM(moq_kg)
    - name: "Average Moq Kg"
      expr: AVG(moq_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_distributor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distributor Agreement business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`distributor_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Agreement Version"
      expr: agreement_version
    - name: "Amendment Date"
      expr: amendment_date
    - name: "Amendment Description"
      expr: amendment_description
    - name: "Authorized Product Categories"
      expr: authorized_product_categories
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Coa Required"
      expr: coa_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
    - name: "Ehs Training Required"
      expr: ehs_training_required
    - name: "Exclusivity Scope"
      expr: exclusivity_scope
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Distributor Agreement"
      expr: COUNT(DISTINCT distributor_agreement_id)
    - name: "Total Credit Limit Usd"
      expr: SUM(credit_limit_usd)
    - name: "Average Credit Limit Usd"
      expr: AVG(credit_limit_usd)
    - name: "Total Moq Annual Usd"
      expr: SUM(moq_annual_usd)
    - name: "Average Moq Annual Usd"
      expr: AVG(moq_annual_usd)
    - name: "Total Rebate Rate Pct"
      expr: SUM(rebate_rate_pct)
    - name: "Average Rebate Rate Pct"
      expr: AVG(rebate_rate_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "Actual Close Date"
      expr: actual_close_date
    - name: "Close Reason"
      expr: close_reason
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Opportunity Code"
      expr: crm_opportunity_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Decision Criteria"
      expr: decision_criteria
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Forecast Category"
      expr: forecast_category
    - name: "Is Key Account"
      expr: is_key_account
    - name: "Is Won"
      expr: is_won
    - name: "Last Activity Date"
      expr: last_activity_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Lead Source"
      expr: lead_source
    - name: "Next Step"
      expr: next_step
    - name: "Opportunity Description"
      expr: opportunity_description
    - name: "Opportunity Name"
      expr: opportunity_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Opportunity"
      expr: COUNT(DISTINCT opportunity_id)
    - name: "Total Close Probability Pct"
      expr: SUM(close_probability_pct)
    - name: "Average Close Probability Pct"
      expr: AVG(close_probability_pct)
    - name: "Total Closed Amount"
      expr: SUM(closed_amount)
    - name: "Average Closed Amount"
      expr: AVG(closed_amount)
    - name: "Total Estimated Amount"
      expr: SUM(estimated_amount)
    - name: "Average Estimated Amount"
      expr: AVG(estimated_amount)
    - name: "Total Estimated Volume Kg"
      expr: SUM(estimated_volume_kg)
    - name: "Average Estimated Volume Kg"
      expr: AVG(estimated_volume_kg)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_opportunity_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity Product business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`opportunity_product`"
  dimensions:
    - name: "Application End Use"
      expr: application_end_use
    - name: "Close Date"
      expr: close_date
    - name: "Coa Required"
      expr: coa_required
    - name: "Competitive Status"
      expr: competitive_status
    - name: "Competitor Name"
      expr: competitor_name
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Opportunity Product Code"
      expr: crm_opportunity_product_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "First Shipment Date"
      expr: first_shipment_date
    - name: "Formulation Required"
      expr: formulation_required
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Opportunity Product Status"
      expr: opportunity_product_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Opportunity Product"
      expr: COUNT(DISTINCT opportunity_product_id)
    - name: "Total Annual Volume Estimate"
      expr: SUM(annual_volume_estimate)
    - name: "Average Annual Volume Estimate"
      expr: AVG(annual_volume_estimate)
    - name: "Total Discount Pct"
      expr: SUM(discount_pct)
    - name: "Average Discount Pct"
      expr: AVG(discount_pct)
    - name: "Total Estimated Quantity"
      expr: SUM(estimated_quantity)
    - name: "Average Estimated Quantity"
      expr: AVG(estimated_quantity)
    - name: "Total Estimated Revenue"
      expr: SUM(estimated_revenue)
    - name: "Average Estimated Revenue"
      expr: AVG(estimated_revenue)
    - name: "Total List Price"
      expr: SUM(list_price)
    - name: "Average List Price"
      expr: AVG(list_price)
    - name: "Total Moq"
      expr: SUM(moq)
    - name: "Average Moq"
      expr: AVG(moq)
    - name: "Total Probability Weighted Revenue"
      expr: SUM(probability_weighted_revenue)
    - name: "Average Probability Weighted Revenue"
      expr: AVG(probability_weighted_revenue)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Win Probability Pct"
      expr: SUM(win_probability_pct)
    - name: "Average Win Probability Pct"
      expr: AVG(win_probability_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_organization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organization business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`organization`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "City"
      expr: city
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Country"
      expr: country
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Number Of Employees"
      expr: number_of_employees
    - name: "Organization Type"
      expr: organization_type
    - name: "Postal Code"
      expr: postal_code
    - name: "Primary Contact Email"
      expr: primary_contact_email
    - name: "Primary Contact Phone"
      expr: primary_contact_phone
    - name: "Region Code"
      expr: region_code
    - name: "Sales Channel"
      expr: sales_channel
    - name: "Sales Organization Description"
      expr: sales_organization_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Organization"
      expr: COUNT(DISTINCT organization_id)
    - name: "Total Annual Budget"
      expr: SUM(annual_budget)
    - name: "Average Annual Budget"
      expr: AVG(annual_budget)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_price_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Agreement business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`price_agreement`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Date"
      expr: approved_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Escalation Frequency"
      expr: escalation_frequency
    - name: "Escalation Index"
      expr: escalation_index
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Agreement"
      expr: COUNT(DISTINCT price_agreement_id)
    - name: "Total Annual Volume Commitment"
      expr: SUM(annual_volume_commitment)
    - name: "Average Annual Volume Commitment"
      expr: AVG(annual_volume_commitment)
    - name: "Total Base Unit Price"
      expr: SUM(base_unit_price)
    - name: "Average Base Unit Price"
      expr: AVG(base_unit_price)
    - name: "Total Min Order Qty"
      expr: SUM(min_order_qty)
    - name: "Average Min Order Qty"
      expr: AVG(min_order_qty)
    - name: "Total Price Per Qty"
      expr: SUM(price_per_qty)
    - name: "Average Price Per Qty"
      expr: AVG(price_per_qty)
    - name: "Total Rebate Pct"
      expr: SUM(rebate_pct)
    - name: "Average Rebate Pct"
      expr: AVG(rebate_pct)
    - name: "Total Rebate Threshold Qty"
      expr: SUM(rebate_threshold_qty)
    - name: "Average Rebate Threshold Qty"
      expr: AVG(rebate_threshold_qty)
    - name: "Total Surcharge Amount"
      expr: SUM(surcharge_amount)
    - name: "Average Surcharge Amount"
      expr: AVG(surcharge_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_price_agreement_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price Agreement Line business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`price_agreement_line`"
  dimensions:
    - name: "Condition Type Code"
      expr: condition_type_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Index Adjustment Formula"
      expr: index_adjustment_formula
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Payment Terms Code"
      expr: payment_terms_code
    - name: "Plant Code"
      expr: plant_code
    - name: "Price Index Linked"
      expr: price_index_linked
    - name: "Price Index Name"
      expr: price_index_name
    - name: "Rebate Basis"
      expr: rebate_basis
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price Agreement Line"
      expr: COUNT(DISTINCT price_agreement_line_id)
    - name: "Total Agreed Unit Price"
      expr: SUM(agreed_unit_price)
    - name: "Average Agreed Unit Price"
      expr: AVG(agreed_unit_price)
    - name: "Total Annual Volume Commitment"
      expr: SUM(annual_volume_commitment)
    - name: "Average Annual Volume Commitment"
      expr: AVG(annual_volume_commitment)
    - name: "Total Min Order Quantity"
      expr: SUM(min_order_quantity)
    - name: "Average Min Order Quantity"
      expr: AVG(min_order_quantity)
    - name: "Total Price Per Quantity"
      expr: SUM(price_per_quantity)
    - name: "Average Price Per Quantity"
      expr: AVG(price_per_quantity)
    - name: "Total Rebate Percent"
      expr: SUM(rebate_percent)
    - name: "Average Rebate Percent"
      expr: AVG(rebate_percent)
    - name: "Total Surcharge Amount"
      expr: SUM(surcharge_amount)
    - name: "Average Surcharge Amount"
      expr: AVG(surcharge_amount)
    - name: "Total Surcharge Percent"
      expr: SUM(surcharge_percent)
    - name: "Average Surcharge Percent"
      expr: AVG(surcharge_percent)
    - name: "Total Tier 1 Min Qty"
      expr: SUM(tier_1_min_qty)
    - name: "Average Tier 1 Min Qty"
      expr: AVG(tier_1_min_qty)
    - name: "Total Tier 1 Unit Price"
      expr: SUM(tier_1_unit_price)
    - name: "Average Tier 1 Unit Price"
      expr: AVG(tier_1_unit_price)
    - name: "Total Tier 2 Min Qty"
      expr: SUM(tier_2_min_qty)
    - name: "Average Tier 2 Min Qty"
      expr: AVG(tier_2_min_qty)
    - name: "Total Tier 2 Unit Price"
      expr: SUM(tier_2_unit_price)
    - name: "Average Tier 2 Unit Price"
      expr: AVG(tier_2_unit_price)
    - name: "Total Tier 3 Min Qty"
      expr: SUM(tier_3_min_qty)
    - name: "Average Tier 3 Min Qty"
      expr: AVG(tier_3_min_qty)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`quote`"
  dimensions:
    - name: "Coa Required"
      expr: coa_required
    - name: "Coc Required"
      expr: coc_required
    - name: "Converted Order Number"
      expr: converted_order_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Quote Number"
      expr: crm_quote_number
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Po Number"
      expr: customer_po_number
    - name: "Distribution Channel Code"
      expr: distribution_channel_code
    - name: "Division Code"
      expr: division_code
    - name: "Export Control Flag"
      expr: export_control_flag
    - name: "Hazmat Flag"
      expr: hazmat_flag
    - name: "Incoterms Code"
      expr: incoterms_code
    - name: "Incoterms Location"
      expr: incoterms_location
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Payment Terms Code"
      expr: payment_terms_code
    - name: "Price List Type"
      expr: price_list_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote"
      expr: COUNT(DISTINCT quote_id)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Discount Amount"
      expr: SUM(total_discount_amount)
    - name: "Average Total Discount Amount"
      expr: AVG(total_discount_amount)
    - name: "Total Total Surcharge Amount"
      expr: SUM(total_surcharge_amount)
    - name: "Average Total Surcharge Amount"
      expr: AVG(total_surcharge_amount)
    - name: "Total Win Probability Pct"
      expr: SUM(win_probability_pct)
    - name: "Average Win Probability Pct"
      expr: AVG(win_probability_pct)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote Line business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`quote_line`"
  dimensions:
    - name: "Batch Managed"
      expr: batch_managed
    - name: "Coa Required"
      expr: coa_required
    - name: "Coc Required"
      expr: coc_required
    - name: "Confirmed Delivery Date"
      expr: confirmed_delivery_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Lead Time Days"
      expr: delivery_lead_time_days
    - name: "Hazard Class"
      expr: hazard_class
    - name: "Incoterm Code"
      expr: incoterm_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Material Number"
      expr: material_number
    - name: "Price Uom"
      expr: price_uom
    - name: "Product Description"
      expr: product_description
    - name: "Reach Compliant"
      expr: reach_compliant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote Line"
      expr: COUNT(DISTINCT quote_line_id)
    - name: "Total Contribution Margin"
      expr: SUM(contribution_margin)
    - name: "Average Contribution Margin"
      expr: AVG(contribution_margin)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Hazmat Surcharge"
      expr: SUM(hazmat_surcharge)
    - name: "Average Hazmat Surcharge"
      expr: AVG(hazmat_surcharge)
    - name: "Total Line Gross Amount"
      expr: SUM(line_gross_amount)
    - name: "Average Line Gross Amount"
      expr: AVG(line_gross_amount)
    - name: "Total Line Net Amount"
      expr: SUM(line_net_amount)
    - name: "Average Line Net Amount"
      expr: AVG(line_net_amount)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Small Order Surcharge"
      expr: SUM(small_order_surcharge)
    - name: "Average Small Order Surcharge"
      expr: AVG(small_order_surcharge)
    - name: "Total Standard Cost"
      expr: SUM(standard_cost)
    - name: "Average Standard Cost"
      expr: AVG(standard_cost)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_rebate_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rebate Agreement business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`rebate_agreement`"
  dimensions:
    - name: "Accrual Method"
      expr: accrual_method
    - name: "Agreement Notes"
      expr: agreement_notes
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Date"
      expr: approval_date
    - name: "Baseline Period End"
      expr: baseline_period_end
    - name: "Baseline Period Start"
      expr: baseline_period_start
    - name: "Calculation Basis"
      expr: calculation_basis
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Eligible Product Scope"
      expr: eligible_product_scope
    - name: "Is Retroactive"
      expr: is_retroactive
    - name: "Is Tiered"
      expr: is_tiered
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rebate Agreement"
      expr: COUNT(DISTINCT rebate_agreement_id)
    - name: "Total Accrued Amount"
      expr: SUM(accrued_amount)
    - name: "Average Accrued Amount"
      expr: AVG(accrued_amount)
    - name: "Total Growth Target Percent"
      expr: SUM(growth_target_percent)
    - name: "Average Growth Target Percent"
      expr: AVG(growth_target_percent)
    - name: "Total Max Rebate Cap Amount"
      expr: SUM(max_rebate_cap_amount)
    - name: "Average Max Rebate Cap Amount"
      expr: AVG(max_rebate_cap_amount)
    - name: "Total Rebate Amount Fixed"
      expr: SUM(rebate_amount_fixed)
    - name: "Average Rebate Amount Fixed"
      expr: AVG(rebate_amount_fixed)
    - name: "Total Rebate Rate Percent"
      expr: SUM(rebate_rate_percent)
    - name: "Average Rebate Rate Percent"
      expr: AVG(rebate_rate_percent)
    - name: "Total Settled Amount"
      expr: SUM(settled_amount)
    - name: "Average Settled Amount"
      expr: AVG(settled_amount)
    - name: "Total Threshold Basis Amount"
      expr: SUM(threshold_basis_amount)
    - name: "Average Threshold Basis Amount"
      expr: AVG(threshold_basis_amount)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_target`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Target business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`target`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Assignment Level"
      expr: assignment_level
    - name: "Baseline Year"
      expr: baseline_year
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Fiscal Quarter"
      expr: fiscal_quarter
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Last Revised Date"
      expr: last_revised_date
    - name: "Notes"
      expr: notes
    - name: "Period End Date"
      expr: period_end_date
    - name: "Period Granularity"
      expr: period_granularity
    - name: "Period Start Date"
      expr: period_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Target"
      expr: COUNT(DISTINCT target_id)
    - name: "Total Actual Revenue Usd"
      expr: SUM(actual_revenue_usd)
    - name: "Average Actual Revenue Usd"
      expr: AVG(actual_revenue_usd)
    - name: "Total Actual Volume Mt"
      expr: SUM(actual_volume_mt)
    - name: "Average Actual Volume Mt"
      expr: AVG(actual_volume_mt)
    - name: "Total Floor Revenue Usd"
      expr: SUM(floor_revenue_usd)
    - name: "Average Floor Revenue Usd"
      expr: AVG(floor_revenue_usd)
    - name: "Total Growth Rate Pct"
      expr: SUM(growth_rate_pct)
    - name: "Average Growth Rate Pct"
      expr: AVG(growth_rate_pct)
    - name: "Total Margin Pct"
      expr: SUM(margin_pct)
    - name: "Average Margin Pct"
      expr: AVG(margin_pct)
    - name: "Total Revenue Attainment Pct"
      expr: SUM(revenue_attainment_pct)
    - name: "Average Revenue Attainment Pct"
      expr: AVG(revenue_attainment_pct)
    - name: "Total Revenue Usd"
      expr: SUM(revenue_usd)
    - name: "Average Revenue Usd"
      expr: AVG(revenue_usd)
    - name: "Total Stretch Revenue Usd"
      expr: SUM(stretch_revenue_usd)
    - name: "Average Stretch Revenue Usd"
      expr: AVG(stretch_revenue_usd)
    - name: "Total Volume Attainment Pct"
      expr: SUM(volume_attainment_pct)
    - name: "Average Volume Attainment Pct"
      expr: AVG(volume_attainment_pct)
    - name: "Total Volume Mt"
      expr: SUM(volume_mt)
    - name: "Average Volume Mt"
      expr: AVG(volume_mt)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Territory business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`territory`"
  dimensions:
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Plan Code"
      expr: commission_plan_code
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Distribution Channel Code"
      expr: distribution_channel_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hazmat Handling Required"
      expr: hazmat_handling_required
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Industry Vertical"
      expr: industry_vertical
    - name: "Last Realignment Date"
      expr: last_realignment_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Named Account Flag"
      expr: named_account_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Territory"
      expr: COUNT(DISTINCT territory_id)
    - name: "Total Annual Quota Usd"
      expr: SUM(annual_quota_usd)
    - name: "Average Annual Quota Usd"
      expr: AVG(annual_quota_usd)
$$;

CREATE OR REPLACE VIEW `chemical_mfg_ecm`.`_metrics`.`sales_territory_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Territory Assignment business metrics"
  source: "`chemical_mfg_ecm`.`sales`.`territory_assignment`"
  dimensions:
    - name: "Account Count Target"
      expr: account_count_target
    - name: "Approval Date"
      expr: approval_date
    - name: "Assignment Number"
      expr: assignment_number
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Channel Type"
      expr: channel_type
    - name: "Country Code"
      expr: country_code
    - name: "Coverage Scope"
      expr: coverage_scope
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crm Assignment Code"
      expr: crm_assignment_code
    - name: "Distribution Channel Code"
      expr: distribution_channel_code
    - name: "Division Code"
      expr: division_code
    - name: "Effective Fiscal Quarter"
      expr: effective_fiscal_quarter
    - name: "Effective Fiscal Year"
      expr: effective_fiscal_year
    - name: "End Date"
      expr: end_date
    - name: "Geographic Region"
      expr: geographic_region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Territory Assignment"
      expr: COUNT(DISTINCT territory_assignment_id)
    - name: "Total Commission Rate Pct"
      expr: SUM(commission_rate_pct)
    - name: "Average Commission Rate Pct"
      expr: AVG(commission_rate_pct)
    - name: "Total Quota Amount"
      expr: SUM(quota_amount)
    - name: "Average Quota Amount"
      expr: AVG(quota_amount)
$$;