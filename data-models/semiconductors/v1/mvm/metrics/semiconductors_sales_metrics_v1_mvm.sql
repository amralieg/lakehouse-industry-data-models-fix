-- Metric views for domain: sales | Business: Semiconductors | Version: 1 | Generated on: 2026-05-06 20:33:21

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking business metrics"
  source: "`semiconductors_ecm`.`sales`.`booking`"
  dimensions:
    - name: "Backlog Flag"
      expr: backlog_flag
    - name: "Booking Number"
      expr: booking_number
    - name: "Booking Source"
      expr: booking_source
    - name: "Booking Status"
      expr: booking_status
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Comments"
      expr: comments
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Mode"
      expr: delivery_mode
    - name: "External Order Ref"
      expr: external_order_ref
    - name: "Forecast Flag"
      expr: forecast_flag
    - name: "Is Critical"
      expr: is_critical
    - name: "Order Type"
      expr: order_type
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Pricing Model"
      expr: pricing_model
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Booking"
      expr: COUNT(DISTINCT booking_id)
    - name: "Total Booked Quantity"
      expr: SUM(booked_quantity)
    - name: "Average Booked Quantity"
      expr: AVG(booked_quantity)
    - name: "Total Booked Revenue Gross"
      expr: SUM(booked_revenue_gross)
    - name: "Average Booked Revenue Gross"
      expr: AVG(booked_revenue_gross)
    - name: "Total Booked Revenue Net"
      expr: SUM(booked_revenue_net)
    - name: "Average Booked Revenue Net"
      expr: AVG(booked_revenue_net)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_campaign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Campaign business metrics"
  source: "`semiconductors_ecm`.`sales`.`campaign`"
  dimensions:
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Campaign Code"
      expr: campaign_code
    - name: "Campaign Description"
      expr: campaign_description
    - name: "Campaign Name"
      expr: campaign_name
    - name: "Campaign Status"
      expr: campaign_status
    - name: "Campaign Type"
      expr: campaign_type
    - name: "Channel"
      expr: channel
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "End Date"
      expr: end_date
    - name: "External Campaign Code"
      expr: external_campaign_code
    - name: "Kpi Actual"
      expr: kpi_actual
    - name: "Kpi Target"
      expr: kpi_target
    - name: "Marketing Platform"
      expr: marketing_platform
    - name: "Notes"
      expr: notes
    - name: "Objective"
      expr: objective
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Campaign"
      expr: COUNT(DISTINCT campaign_id)
    - name: "Total Actual Spend"
      expr: SUM(actual_spend)
    - name: "Average Actual Spend"
      expr: AVG(actual_spend)
    - name: "Total Approved By"
      expr: SUM(approved_by)
    - name: "Average Approved By"
      expr: AVG(approved_by)
    - name: "Total Budget Amount"
      expr: SUM(budget_amount)
    - name: "Average Budget Amount"
      expr: AVG(budget_amount)
    - name: "Total Roi Estimate"
      expr: SUM(roi_estimate)
    - name: "Average Roi Estimate"
      expr: AVG(roi_estimate)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_channel_partner`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Partner business metrics"
  source: "`semiconductors_ecm`.`sales`.`channel_partner`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Authorized Product Lines"
      expr: authorized_product_lines
    - name: "Channel Partner Status"
      expr: channel_partner_status
    - name: "City"
      expr: city
    - name: "Contract Effective From"
      expr: contract_effective_from
    - name: "Contract Effective Until"
      expr: contract_effective_until
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "External Partner Code"
      expr: external_partner_code
    - name: "Hub Consignment Level"
      expr: hub_consignment_level
    - name: "Inventory Reporting Obligation"
      expr: inventory_reporting_obligation
    - name: "Last Audit Timestamp"
      expr: last_audit_timestamp
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Partner"
      expr: COUNT(DISTINCT channel_partner_id)
    - name: "Total Sell Through Rate"
      expr: SUM(sell_through_rate)
    - name: "Average Sell Through Rate"
      expr: AVG(sell_through_rate)
    - name: "Total Stock On Hand"
      expr: SUM(stock_on_hand)
    - name: "Average Stock On Hand"
      expr: AVG(stock_on_hand)
    - name: "Total Weeks Of Supply"
      expr: SUM(weeks_of_supply)
    - name: "Average Weeks Of Supply"
      expr: AVG(weeks_of_supply)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer Contract business metrics"
  source: "`semiconductors_ecm`.`sales`.`customer_contract`"
  dimensions:
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Arbitration Clause"
      expr: arbitration_clause
    - name: "Auto Renew Flag"
      expr: auto_renew_flag
    - name: "Confidentiality Clause"
      expr: confidentiality_clause
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Currency"
      expr: currency
    - name: "Customer Contract Description"
      expr: customer_contract_description
    - name: "Customer Contract Status"
      expr: customer_contract_status
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Eol Clause"
      expr: eol_clause
    - name: "Invoicing Frequency"
      expr: invoicing_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Customer Contract"
      expr: COUNT(DISTINCT customer_contract_id)
    - name: "Total Annual Value"
      expr: SUM(annual_value)
    - name: "Average Annual Value"
      expr: AVG(annual_value)
    - name: "Total Contract Value Total"
      expr: SUM(contract_value_total)
    - name: "Average Contract Value Total"
      expr: AVG(contract_value_total)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Discount Rate"
      expr: SUM(discount_rate)
    - name: "Average Discount Rate"
      expr: AVG(discount_rate)
    - name: "Total Max Order Quantity"
      expr: SUM(max_order_quantity)
    - name: "Average Max Order Quantity"
      expr: AVG(max_order_quantity)
    - name: "Total Min Order Quantity"
      expr: SUM(min_order_quantity)
    - name: "Average Min Order Quantity"
      expr: AVG(min_order_quantity)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
    - name: "Total Volume Commitment"
      expr: SUM(volume_commitment)
    - name: "Average Volume Commitment"
      expr: AVG(volume_commitment)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_lead`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lead business metrics"
  source: "`semiconductors_ecm`.`sales`.`lead`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Company Industry"
      expr: company_industry
    - name: "Company Name"
      expr: company_name
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Conversion Date"
      expr: conversion_date
    - name: "Conversion Outcome"
      expr: conversion_outcome
    - name: "Country"
      expr: country
    - name: "Creation Timestamp"
      expr: creation_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Data Classification"
      expr: data_classification
    - name: "Device Interest"
      expr: device_interest
    - name: "Expected Close Date"
      expr: expected_close_date
    - name: "Is Nre"
      expr: is_nre
    - name: "Itar Required"
      expr: itar_required
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lead"
      expr: COUNT(DISTINCT lead_id)
    - name: "Total Estimated Quantity"
      expr: SUM(estimated_quantity)
    - name: "Average Estimated Quantity"
      expr: AVG(estimated_quantity)
    - name: "Total Estimated Revenue"
      expr: SUM(estimated_revenue)
    - name: "Average Estimated Revenue"
      expr: AVG(estimated_revenue)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Opportunity business metrics"
  source: "`semiconductors_ecm`.`sales`.`opportunity`"
  dimensions:
    - name: "Competitive Landscape"
      expr: competitive_landscape
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "End Market"
      expr: end_market
    - name: "Expected Close Date"
      expr: expected_close_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Opportunity Name"
      expr: opportunity_name
    - name: "Opportunity Number"
      expr: opportunity_number
    - name: "Pricing Model"
      expr: pricing_model
    - name: "Probability Percent"
      expr: probability_percent
    - name: "Region"
      expr: region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Opportunity"
      expr: COUNT(DISTINCT opportunity_id)
    - name: "Total Expected Discount Amount"
      expr: SUM(expected_discount_amount)
    - name: "Average Expected Discount Amount"
      expr: AVG(expected_discount_amount)
    - name: "Total Expected Gross Amount"
      expr: SUM(expected_gross_amount)
    - name: "Average Expected Gross Amount"
      expr: AVG(expected_gross_amount)
    - name: "Total Expected Net Amount"
      expr: SUM(expected_net_amount)
    - name: "Average Expected Net Amount"
      expr: AVG(expected_net_amount)
    - name: "Total Nre Amount"
      expr: SUM(nre_amount)
    - name: "Average Nre Amount"
      expr: AVG(nre_amount)
    - name: "Total Price Per Unit"
      expr: SUM(price_per_unit)
    - name: "Average Price Per Unit"
      expr: AVG(price_per_unit)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_price_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price List business metrics"
  source: "`semiconductors_ecm`.`sales`.`price_list`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "End Market"
      expr: end_market
    - name: "Is Default"
      expr: is_default
    - name: "Notes"
      expr: notes
    - name: "Price List Description"
      expr: price_list_description
    - name: "Price List Name"
      expr: price_list_name
    - name: "Price List Status"
      expr: price_list_status
    - name: "Price Type"
      expr: price_type
    - name: "Pricing Condition Code"
      expr: pricing_condition_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price List"
      expr: COUNT(DISTINCT price_list_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_quote`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote business metrics"
  source: "`semiconductors_ecm`.`sales`.`quote`"
  dimensions:
    - name: "Conversion Date"
      expr: conversion_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency"
      expr: currency
    - name: "Delivery Terms"
      expr: delivery_terms
    - name: "Incoterms"
      expr: incoterms
    - name: "Is Converted"
      expr: is_converted
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Payment Terms"
      expr: payment_terms
    - name: "Quote Date"
      expr: quote_date
    - name: "Quote Description"
      expr: quote_description
    - name: "Quote Number"
      expr: quote_number
    - name: "Quote Status"
      expr: quote_status
    - name: "Reason Lost"
      expr: reason_lost
    - name: "Sales Region"
      expr: sales_region
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Valid Until"
      expr: valid_until
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote"
      expr: COUNT(DISTINCT quote_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_quote_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quote Line business metrics"
  source: "`semiconductors_ecm`.`sales`.`quote_line`"
  dimensions:
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Requested Delivery Date"
      expr: customer_requested_delivery_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Internal Approval Status"
      expr: internal_approval_status
    - name: "Is Custom"
      expr: is_custom
    - name: "Is Price Locked"
      expr: is_price_locked
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Line Comment"
      expr: line_comment
    - name: "Line Number"
      expr: line_number
    - name: "Package Type"
      expr: package_type
    - name: "Pricing Tier"
      expr: pricing_tier
    - name: "Quote Line Status"
      expr: quote_line_status
    - name: "Sales Channel"
      expr: sales_channel
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Quote Line"
      expr: COUNT(DISTINCT quote_line_id)
    - name: "Total Discount Percent"
      expr: SUM(discount_percent)
    - name: "Average Discount Percent"
      expr: AVG(discount_percent)
    - name: "Total Net Price"
      expr: SUM(net_price)
    - name: "Average Net Price"
      expr: AVG(net_price)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total Price"
      expr: SUM(total_price)
    - name: "Average Total Price"
      expr: AVG(total_price)
    - name: "Total Unit Price"
      expr: SUM(unit_price)
    - name: "Average Unit Price"
      expr: AVG(unit_price)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_sales_design_registration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Design Registration business metrics"
  source: "`semiconductors_ecm`.`sales`.`sales_design_registration`"
  dimensions:
    - name: "Approval Comments"
      expr: approval_comments
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Audit Trail"
      expr: audit_trail
    - name: "Claim Number"
      expr: claim_number
    - name: "Compliance Iso9001"
      expr: compliance_iso9001
    - name: "Compliance Itar"
      expr: compliance_itar
    - name: "Compliance Rohs"
      expr: compliance_rohs
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
    - name: "End Application"
      expr: end_application
    - name: "Estimated Annual Volume"
      expr: estimated_annual_volume
    - name: "Expiration Reason"
      expr: expiration_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Design Registration"
      expr: COUNT(DISTINCT sales_design_registration_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Protected Price Usd"
      expr: SUM(protected_price_usd)
    - name: "Average Protected Price Usd"
      expr: AVG(protected_price_usd)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_sales_design_win`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Design Win business metrics"
  source: "`semiconductors_ecm`.`sales`.`sales_design_win`"
  dimensions:
    - name: "Compliance Regulation"
      expr: compliance_regulation
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Contract Term Months"
      expr: contract_term_months
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Design Win Number"
      expr: design_win_number
    - name: "Displacement Reason"
      expr: displacement_reason
    - name: "Export Controlled"
      expr: export_controlled
    - name: "Is Key Account"
      expr: is_key_account
    - name: "Last Review Date"
      expr: last_review_date
    - name: "Market Segment"
      expr: market_segment
    - name: "Notes"
      expr: notes
    - name: "Pricing Model"
      expr: pricing_model
    - name: "Region"
      expr: region
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Design Win"
      expr: COUNT(DISTINCT sales_design_win_id)
    - name: "Total Competitor Displacement Score"
      expr: SUM(competitor_displacement_score)
    - name: "Average Competitor Displacement Score"
      expr: AVG(competitor_displacement_score)
    - name: "Total Displaced Competitor Code"
      expr: SUM(displaced_competitor_code)
    - name: "Average Displaced Competitor Code"
      expr: AVG(displaced_competitor_code)
    - name: "Total Displaced Device Code"
      expr: SUM(displaced_device_code)
    - name: "Average Displaced Device Code"
      expr: AVG(displaced_device_code)
    - name: "Total Estimated Annual Revenue Gross"
      expr: SUM(estimated_annual_revenue_gross)
    - name: "Average Estimated Annual Revenue Gross"
      expr: AVG(estimated_annual_revenue_gross)
    - name: "Total Estimated Annual Revenue Net"
      expr: SUM(estimated_annual_revenue_net)
    - name: "Average Estimated Annual Revenue Net"
      expr: AVG(estimated_annual_revenue_net)
    - name: "Total Estimated Annual Unit Volume"
      expr: SUM(estimated_annual_unit_volume)
    - name: "Average Estimated Annual Unit Volume"
      expr: AVG(estimated_annual_unit_volume)
    - name: "Total Forecast Accuracy"
      expr: SUM(forecast_accuracy)
    - name: "Average Forecast Accuracy"
      expr: AVG(forecast_accuracy)
    - name: "Total Forecasted Ramp Rate Per Month"
      expr: SUM(forecasted_ramp_rate_per_month)
    - name: "Average Forecasted Ramp Rate Per Month"
      expr: AVG(forecasted_ramp_rate_per_month)
    - name: "Total Revenue Adjustment"
      expr: SUM(revenue_adjustment)
    - name: "Average Revenue Adjustment"
      expr: AVG(revenue_adjustment)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_sales_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Forecast business metrics"
  source: "`semiconductors_ecm`.`sales`.`sales_forecast`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End"
      expr: effective_end
    - name: "Effective Start"
      expr: effective_start
    - name: "End Market"
      expr: end_market
    - name: "Fiscal Period"
      expr: fiscal_period
    - name: "Forecast Category"
      expr: forecast_category
    - name: "Forecast Number"
      expr: forecast_number
    - name: "Forecast Status"
      expr: forecast_status
    - name: "Forecast Type"
      expr: forecast_type
    - name: "Geography"
      expr: geography
    - name: "Horizon Months"
      expr: horizon_months
    - name: "Is Locked"
      expr: is_locked
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Forecast"
      expr: COUNT(DISTINCT sales_forecast_id)
    - name: "Total Bias"
      expr: SUM(bias)
    - name: "Average Bias"
      expr: AVG(bias)
    - name: "Total Mape"
      expr: SUM(mape)
    - name: "Average Mape"
      expr: AVG(mape)
    - name: "Total Quantity"
      expr: SUM(quantity)
    - name: "Average Quantity"
      expr: AVG(quantity)
    - name: "Total Revenue"
      expr: SUM(revenue)
    - name: "Average Revenue"
      expr: AVG(revenue)
    - name: "Total Variance To Actual"
      expr: SUM(variance_to_actual)
    - name: "Average Variance To Actual"
      expr: AVG(variance_to_actual)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_sales_nre_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Nre Agreement business metrics"
  source: "`semiconductors_ecm`.`sales`.`sales_nre_agreement`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Approval Status"
      expr: approval_status
    - name: "Change Order Flag"
      expr: change_order_flag
    - name: "Change Order Number"
      expr: change_order_number
    - name: "Completed Milestones"
      expr: completed_milestones
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contract Reference"
      expr: contract_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deliverable Type"
      expr: deliverable_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Exclusivity Flag"
      expr: exclusivity_flag
    - name: "Invoice Trigger Flag"
      expr: invoice_trigger_flag
    - name: "Ip Ownership Clause"
      expr: ip_ownership_clause
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Nre Agreement"
      expr: COUNT(DISTINCT sales_nre_agreement_id)
    - name: "Total Actual Revenue Recognized"
      expr: SUM(actual_revenue_recognized)
    - name: "Average Actual Revenue Recognized"
      expr: AVG(actual_revenue_recognized)
    - name: "Total Forecasted Revenue"
      expr: SUM(forecasted_revenue)
    - name: "Average Forecasted Revenue"
      expr: AVG(forecasted_revenue)
    - name: "Total Milestone Amount"
      expr: SUM(milestone_amount)
    - name: "Average Milestone Amount"
      expr: AVG(milestone_amount)
    - name: "Total Nre Total Amount"
      expr: SUM(nre_total_amount)
    - name: "Average Nre Total Amount"
      expr: AVG(nre_total_amount)
$$;

CREATE OR REPLACE VIEW `semiconductors_ecm`.`_metrics`.`sales_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Territory business metrics"
  source: "`semiconductors_ecm`.`sales`.`territory`"
  dimensions:
    - name: "Channel Tier"
      expr: channel_tier
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fiscal Year"
      expr: fiscal_year
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Is Overlay"
      expr: is_overlay
    - name: "Multi Rep Coverage"
      expr: multi_rep_coverage
    - name: "Notes"
      expr: notes
    - name: "Region Code"
      expr: region_code
    - name: "Territory Code"
      expr: territory_code
    - name: "Territory Description"
      expr: territory_description
    - name: "Territory Name"
      expr: territory_name
    - name: "Territory Status"
      expr: territory_status
    - name: "Territory Type"
      expr: territory_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Territory"
      expr: COUNT(DISTINCT territory_id)
    - name: "Total Revenue Target Amount"
      expr: SUM(revenue_target_amount)
    - name: "Average Revenue Target Amount"
      expr: AVG(revenue_target_amount)
$$;