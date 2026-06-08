-- Metric views for domain: revenue | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:50:37

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_adm`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adm business metrics"
  source: "`airlines_ecm`.`revenue`.`adm`"
  dimensions:
    - name: "Adm Number"
      expr: adm_number
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Dispute Date"
      expr: dispute_date
    - name: "Dispute Deadline Date"
      expr: dispute_deadline_date
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Gds Code"
      expr: gds_code
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Office Code"
      expr: issuing_office_code
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Passenger Name"
      expr: passenger_name
    - name: "Pnr Locator"
      expr: pnr_locator
    - name: "Reason Code"
      expr: reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Adm"
      expr: COUNT(DISTINCT adm_id)
    - name: "Total Authorised Commission Rate"
      expr: SUM(authorised_commission_rate)
    - name: "Average Authorised Commission Rate"
      expr: AVG(authorised_commission_rate)
    - name: "Total Collected Fare Amount"
      expr: SUM(collected_fare_amount)
    - name: "Average Collected Fare Amount"
      expr: AVG(collected_fare_amount)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Debit Amount"
      expr: SUM(debit_amount)
    - name: "Average Debit Amount"
      expr: AVG(debit_amount)
    - name: "Total Net Debit Amount"
      expr: SUM(net_debit_amount)
    - name: "Average Net Debit Amount"
      expr: AVG(net_debit_amount)
    - name: "Total Original Fare Amount"
      expr: SUM(original_fare_amount)
    - name: "Average Original Fare Amount"
      expr: AVG(original_fare_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_agency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Agency business metrics"
  source: "`airlines_ecm`.`revenue`.`agency`"
  dimensions:
    - name: "Accreditation Date"
      expr: accreditation_date
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "Agency Name"
      expr: agency_name
    - name: "Agency Status"
      expr: agency_status
    - name: "Agency Type"
      expr: agency_type
    - name: "Arc Number"
      expr: arc_number
    - name: "Bsp Country Code"
      expr: bsp_country_code
    - name: "City"
      expr: city
    - name: "Contract Effective Date"
      expr: contract_effective_date
    - name: "Contract Expiration Date"
      expr: contract_expiration_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Gds Code"
      expr: gds_code
    - name: "Iata Number"
      expr: iata_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Agency"
      expr: COUNT(DISTINCT agency_id)
    - name: "Total Annual Sales Volume"
      expr: SUM(annual_sales_volume)
    - name: "Average Annual Sales Volume"
      expr: AVG(annual_sales_volume)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Credit Limit"
      expr: SUM(credit_limit)
    - name: "Average Credit Limit"
      expr: AVG(credit_limit)
    - name: "Total Override Commission Rate"
      expr: SUM(override_commission_rate)
    - name: "Average Override Commission Rate"
      expr: AVG(override_commission_rate)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_arc_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Arc Settlement business metrics"
  source: "`airlines_ecm`.`revenue`.`arc_settlement`"
  dimensions:
    - name: "Adm Acm Reason Code"
      expr: adm_acm_reason_code
    - name: "Agency Name"
      expr: agency_name
    - name: "Arc Agency Number"
      expr: arc_agency_number
    - name: "Arc Period Number"
      expr: arc_period_number
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Conjunction Ticket Number"
      expr: conjunction_ticket_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Dispute Reference"
      expr: dispute_reference
    - name: "Endorsement Restriction"
      expr: endorsement_restriction
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Gds Code"
      expr: gds_code
    - name: "Is Codeshare"
      expr: is_codeshare
    - name: "Is Interline"
      expr: is_interline
    - name: "Origin Airport Code"
      expr: origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Arc Settlement"
      expr: COUNT(DISTINCT arc_settlement_id)
    - name: "Total Base Fare Amount"
      expr: SUM(base_fare_amount)
    - name: "Average Base Fare Amount"
      expr: AVG(base_fare_amount)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Amount"
      expr: SUM(gross_amount)
    - name: "Average Gross Amount"
      expr: AVG(gross_amount)
    - name: "Total Net Amount"
      expr: SUM(net_amount)
    - name: "Average Net Amount"
      expr: AVG(net_amount)
    - name: "Total Pfc Amount"
      expr: SUM(pfc_amount)
    - name: "Average Pfc Amount"
      expr: AVG(pfc_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_bid_price_curve`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bid Price Curve business metrics"
  source: "`airlines_ecm`.`revenue`.`bid_price_curve`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Booking Class Code"
      expr: booking_class_code
    - name: "Cabin Class Code"
      expr: cabin_class_code
    - name: "Capacity Available Units"
      expr: capacity_available_units
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Curve Code"
      expr: curve_code
    - name: "Curve Generation Method"
      expr: curve_generation_method
    - name: "Curve Name"
      expr: curve_name
    - name: "Curve Type"
      expr: curve_type
    - name: "Days Before Departure End"
      expr: days_before_departure_end
    - name: "Days Before Departure Start"
      expr: days_before_departure_start
    - name: "Demand Forecast Units"
      expr: demand_forecast_units
    - name: "Destination Airport Code"
      expr: destination_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bid Price Curve"
      expr: COUNT(DISTINCT bid_price_curve_id)
    - name: "Total Base Bid Price Amount"
      expr: SUM(base_bid_price_amount)
    - name: "Average Base Bid Price Amount"
      expr: AVG(base_bid_price_amount)
    - name: "Total Displacement Cost Amount"
      expr: SUM(displacement_cost_amount)
    - name: "Average Displacement Cost Amount"
      expr: AVG(displacement_cost_amount)
    - name: "Total Spill Cost Amount"
      expr: SUM(spill_cost_amount)
    - name: "Average Spill Cost Amount"
      expr: AVG(spill_cost_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_bsp_settlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bsp Settlement business metrics"
  source: "`airlines_ecm`.`revenue`.`bsp_settlement`"
  dimensions:
    - name: "Adjustment Reference"
      expr: adjustment_reference
    - name: "Agent Iata Code"
      expr: agent_iata_code
    - name: "Agent Name"
      expr: agent_name
    - name: "Airline Numeric Code"
      expr: airline_numeric_code
    - name: "Arc Report Reference"
      expr: arc_report_reference
    - name: "Billing Period End Date"
      expr: billing_period_end_date
    - name: "Billing Period Start Date"
      expr: billing_period_start_date
    - name: "Bsp File Reference"
      expr: bsp_file_reference
    - name: "Bsp Market Country Code"
      expr: bsp_market_country_code
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispute Raised Date"
      expr: dispute_raised_date
    - name: "Dispute Reason Code"
      expr: dispute_reason_code
    - name: "Dispute Resolution Date"
      expr: dispute_resolution_date
    - name: "Gds Provider Code"
      expr: gds_provider_code
    - name: "Gl Account Code"
      expr: gl_account_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bsp Settlement"
      expr: COUNT(DISTINCT bsp_settlement_id)
    - name: "Total Acm Amount"
      expr: SUM(acm_amount)
    - name: "Average Acm Amount"
      expr: AVG(acm_amount)
    - name: "Total Adm Amount"
      expr: SUM(adm_amount)
    - name: "Average Adm Amount"
      expr: AVG(adm_amount)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Gross Sales Amount"
      expr: SUM(gross_sales_amount)
    - name: "Average Gross Sales Amount"
      expr: AVG(gross_sales_amount)
    - name: "Total Net Remittance Amount"
      expr: SUM(net_remittance_amount)
    - name: "Average Net Remittance Amount"
      expr: AVG(net_remittance_amount)
    - name: "Total Pfc Amount"
      expr: SUM(pfc_amount)
    - name: "Average Pfc Amount"
      expr: AVG(pfc_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_contract_inventory_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contract Inventory Allocation business metrics"
  source: "`airlines_ecm`.`revenue`.`contract_inventory_allocation`"
  dimensions:
    - name: "Allocated Seats"
      expr: allocated_seats
    - name: "Allocation Status"
      expr: allocation_status
    - name: "Allocation Type"
      expr: allocation_type
    - name: "Applicable Booking Classes"
      expr: applicable_booking_classes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Seats Used"
      expr: seats_used
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Contract Inventory Allocation"
      expr: COUNT(DISTINCT contract_inventory_allocation_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Revenue Generated"
      expr: SUM(revenue_generated)
    - name: "Average Revenue Generated"
      expr: AVG(revenue_generated)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_corporate_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Account business metrics"
  source: "`airlines_ecm`.`revenue`.`corporate_account`"
  dimensions:
    - name: "Account Name"
      expr: account_name
    - name: "Account Number"
      expr: account_number
    - name: "Account Status"
      expr: account_status
    - name: "Account Type"
      expr: account_type
    - name: "Annual Revenue Commitment Currency Code"
      expr: annual_revenue_commitment_currency_code
    - name: "Auto Ticketing Enabled"
      expr: auto_ticketing_enabled
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Cycle Day"
      expr: billing_cycle_day
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Contract End Date"
      expr: contract_end_date
    - name: "Contract Start Date"
      expr: contract_start_date
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Account"
      expr: COUNT(DISTINCT corporate_account_id)
    - name: "Total Annual Revenue Commitment Amount"
      expr: SUM(annual_revenue_commitment_amount)
    - name: "Average Annual Revenue Commitment Amount"
      expr: AVG(annual_revenue_commitment_amount)
    - name: "Total Credit Limit Amount"
      expr: SUM(credit_limit_amount)
    - name: "Average Credit Limit Amount"
      expr: AVG(credit_limit_amount)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_corporate_ancillary_entitlement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Ancillary Entitlement business metrics"
  source: "`airlines_ecm`.`revenue`.`corporate_ancillary_entitlement`"
  dimensions:
    - name: "Auto Apply Flag"
      expr: auto_apply_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Entitlement Status"
      expr: entitlement_status
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Included Quantity"
      expr: included_quantity
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Usage Limit Per Booking"
      expr: usage_limit_per_booking
    - name: "Usage Limit Per Passenger"
      expr: usage_limit_per_passenger
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Ancillary Entitlement"
      expr: COUNT(DISTINCT corporate_ancillary_entitlement_id)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Negotiated Price"
      expr: SUM(negotiated_price)
    - name: "Average Negotiated Price"
      expr: AVG(negotiated_price)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_corporate_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Corporate Contract business metrics"
  source: "`airlines_ecm`.`revenue`.`corporate_contract`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Applicable Booking Classes"
      expr: applicable_booking_classes
    - name: "Applicable Cabin Classes"
      expr: applicable_cabin_classes
    - name: "Auto Renewal Indicator"
      expr: auto_renewal_indicator
    - name: "Blackout Dates"
      expr: blackout_dates
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Changeable Indicator"
      expr: changeable_indicator
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Corporate Contact Email"
      expr: corporate_contact_email
    - name: "Corporate Contact Name"
      expr: corporate_contact_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Codes"
      expr: destination_airport_codes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Corporate Contract"
      expr: COUNT(DISTINCT corporate_contract_id)
    - name: "Total Commission Override Rate"
      expr: SUM(commission_override_rate)
    - name: "Average Commission Override Rate"
      expr: AVG(commission_override_rate)
    - name: "Total Discount Percentage"
      expr: SUM(discount_percentage)
    - name: "Average Discount Percentage"
      expr: AVG(discount_percentage)
    - name: "Total Min Revenue Commitment"
      expr: SUM(min_revenue_commitment)
    - name: "Average Min Revenue Commitment"
      expr: AVG(min_revenue_commitment)
    - name: "Total Net Fare Amount"
      expr: SUM(net_fare_amount)
    - name: "Average Net Fare Amount"
      expr: AVG(net_fare_amount)
    - name: "Total Rebate Rate"
      expr: SUM(rebate_rate)
    - name: "Average Rebate Rate"
      expr: AVG(rebate_rate)
    - name: "Total Rebate Threshold Amount"
      expr: SUM(rebate_threshold_amount)
    - name: "Average Rebate Threshold Amount"
      expr: AVG(rebate_threshold_amount)
    - name: "Total Soft Dollar Credit Amount"
      expr: SUM(soft_dollar_credit_amount)
    - name: "Average Soft Dollar Credit Amount"
      expr: AVG(soft_dollar_credit_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_fare`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare business metrics"
  source: "`airlines_ecm`.`revenue`.`fare`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Atpco Record Type"
      expr: atpco_record_type
    - name: "Basis Code"
      expr: basis_code
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Changeable Indicator"
      expr: changeable_indicator
    - name: "Class Code"
      expr: class_code
    - name: "Combinability Code"
      expr: combinability_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Directionality"
      expr: directionality
    - name: "Discontinue Date"
      expr: discontinue_date
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fare"
      expr: COUNT(DISTINCT fare_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_fare_applicability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare Applicability business metrics"
  source: "`airlines_ecm`.`revenue`.`fare_applicability`"
  dimensions:
    - name: "Authorized Capacity"
      expr: authorized_capacity
    - name: "Availability Status"
      expr: availability_status
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Discontinue Date"
      expr: discontinue_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Fare Applicability Status"
      expr: fare_applicability_status
    - name: "Last Booking Timestamp"
      expr: last_booking_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Seats Sold Under Fare"
      expr: seats_sold_under_fare
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Discontinue Date Month"
      expr: DATE_TRUNC('MONTH', discontinue_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fare Applicability"
      expr: COUNT(DISTINCT fare_applicability_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_fare_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare Class business metrics"
  source: "`airlines_ecm`.`revenue`.`fare_class`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Availability Control Method"
      expr: availability_control_method
    - name: "Award Redemption Class"
      expr: award_redemption_class
    - name: "Blackout Applicable"
      expr: blackout_applicable
    - name: "Carry On Bag Allowance"
      expr: carry_on_bag_allowance
    - name: "Changeable"
      expr: changeable
    - name: "Checked Bag Allowance"
      expr: checked_bag_allowance
    - name: "Codeshare Eligible"
      expr: codeshare_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distribution Channel"
      expr: distribution_channel
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Family"
      expr: family
    - name: "Fare Basis Code Pattern"
      expr: fare_basis_code_pattern
    - name: "Fare Class Description"
      expr: fare_class_description
    - name: "Fare Class Status"
      expr: fare_class_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fare Class"
      expr: COUNT(DISTINCT fare_class_id)
    - name: "Total Mileage Accrual Multiplier"
      expr: SUM(mileage_accrual_multiplier)
    - name: "Average Mileage Accrual Multiplier"
      expr: AVG(mileage_accrual_multiplier)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_fare_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare Family business metrics"
  source: "`airlines_ecm`.`revenue`.`fare_family`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Ancillary Bundle Code"
      expr: ancillary_bundle_code
    - name: "Brand Name"
      expr: brand_name
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Carry On Bags Included"
      expr: carry_on_bags_included
    - name: "Change Permitted"
      expr: change_permitted
    - name: "Checked Bags Included"
      expr: checked_bags_included
    - name: "Combinability Permitted"
      expr: combinability_permitted
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discontinue Date"
      expr: discontinue_date
    - name: "Display Priority"
      expr: display_priority
    - name: "Effective Date"
      expr: effective_date
    - name: "Family Status"
      expr: family_status
    - name: "Fare Class Mapping"
      expr: fare_class_mapping
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fare Family"
      expr: COUNT(DISTINCT fare_family_id)
    - name: "Total Change Fee Amount"
      expr: SUM(change_fee_amount)
    - name: "Average Change Fee Amount"
      expr: AVG(change_fee_amount)
    - name: "Total Miles Accrual Rate"
      expr: SUM(miles_accrual_rate)
    - name: "Average Miles Accrual Rate"
      expr: AVG(miles_accrual_rate)
    - name: "Total Refund Fee Amount"
      expr: SUM(refund_fee_amount)
    - name: "Average Refund Fee Amount"
      expr: AVG(refund_fee_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_fare_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fare Rule business metrics"
  source: "`airlines_ecm`.`revenue`.`fare_rule`"
  dimensions:
    - name: "Advance Purchase Hours"
      expr: advance_purchase_hours
    - name: "Atpco Category Number"
      expr: atpco_category_number
    - name: "Blackout End Date"
      expr: blackout_end_date
    - name: "Blackout Start Date"
      expr: blackout_start_date
    - name: "Cabin Type"
      expr: cabin_type
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Category Name"
      expr: category_name
    - name: "Change Fee Currency"
      expr: change_fee_currency
    - name: "Combinability Type"
      expr: combinability_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Discontinue Date"
      expr: discontinue_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Endorsement Text"
      expr: endorsement_text
    - name: "Fare Class Code"
      expr: fare_class_code
    - name: "Global Indicator"
      expr: global_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fare Rule"
      expr: COUNT(DISTINCT fare_rule_id)
    - name: "Total Change Fee Amount"
      expr: SUM(change_fee_amount)
    - name: "Average Change Fee Amount"
      expr: AVG(change_fee_amount)
    - name: "Total Refund Penalty Amount"
      expr: SUM(refund_penalty_amount)
    - name: "Average Refund Penalty Amount"
      expr: AVG(refund_penalty_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_flight_revenue_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Revenue Performance business metrics"
  source: "`airlines_ecm`.`revenue`.`flight_revenue_performance`"
  dimensions:
    - name: "Aircraft Type Code"
      expr: aircraft_type_code
    - name: "Available Seats"
      expr: available_seats
    - name: "Business Passengers"
      expr: business_passengers
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Denied Boarding Count"
      expr: denied_boarding_count
    - name: "Departure Timestamp"
      expr: departure_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Economy Passengers"
      expr: economy_passengers
    - name: "First Class Passengers"
      expr: first_class_passengers
    - name: "Flight Date"
      expr: flight_date
    - name: "Flight Number"
      expr: flight_number
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "No Show Count"
      expr: no_show_count
    - name: "Overbooking Outcome"
      expr: overbooking_outcome
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Revenue Performance"
      expr: COUNT(DISTINCT flight_revenue_performance_id)
    - name: "Total Ancillary Revenue Amount"
      expr: SUM(ancillary_revenue_amount)
    - name: "Average Ancillary Revenue Amount"
      expr: AVG(ancillary_revenue_amount)
    - name: "Total Ask"
      expr: SUM(ask)
    - name: "Average Ask"
      expr: AVG(ask)
    - name: "Total Average Fare Amount"
      expr: SUM(average_fare_amount)
    - name: "Average Average Fare Amount"
      expr: AVG(average_fare_amount)
    - name: "Total Business Fare Revenue Amount"
      expr: SUM(business_fare_revenue_amount)
    - name: "Average Business Fare Revenue Amount"
      expr: AVG(business_fare_revenue_amount)
    - name: "Total Economy Fare Revenue Amount"
      expr: SUM(economy_fare_revenue_amount)
    - name: "Average Economy Fare Revenue Amount"
      expr: AVG(economy_fare_revenue_amount)
    - name: "Total First Class Fare Revenue Amount"
      expr: SUM(first_class_fare_revenue_amount)
    - name: "Average First Class Fare Revenue Amount"
      expr: AVG(first_class_fare_revenue_amount)
    - name: "Total Flight Distance Km"
      expr: SUM(flight_distance_km)
    - name: "Average Flight Distance Km"
      expr: AVG(flight_distance_km)
    - name: "Total Load Factor"
      expr: SUM(load_factor)
    - name: "Average Load Factor"
      expr: AVG(load_factor)
    - name: "Total Overbooking Factor"
      expr: SUM(overbooking_factor)
    - name: "Average Overbooking Factor"
      expr: AVG(overbooking_factor)
    - name: "Total Rask"
      expr: SUM(rask)
    - name: "Average Rask"
      expr: AVG(rask)
    - name: "Total Rpk"
      expr: SUM(rpk)
    - name: "Average Rpk"
      expr: AVG(rpk)
    - name: "Total Total Fare Revenue Amount"
      expr: SUM(total_fare_revenue_amount)
    - name: "Average Total Fare Revenue Amount"
      expr: AVG(total_fare_revenue_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_interline_prorate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline Prorate business metrics"
  source: "`airlines_ecm`.`revenue`.`interline_prorate`"
  dimensions:
    - name: "Agreement Reference Number"
      expr: agreement_reference_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Directionality"
      expr: directionality
    - name: "Dispute Status"
      expr: dispute_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Global Indicator"
      expr: global_indicator
    - name: "Iata Conference Area"
      expr: iata_conference_area
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interline Prorate"
      expr: COUNT(DISTINCT interline_prorate_id)
    - name: "Total Collected Fare Amount"
      expr: SUM(collected_fare_amount)
    - name: "Average Collected Fare Amount"
      expr: AVG(collected_fare_amount)
    - name: "Total Maximum Prorate Amount"
      expr: SUM(maximum_prorate_amount)
    - name: "Average Maximum Prorate Amount"
      expr: AVG(maximum_prorate_amount)
    - name: "Total Minimum Prorate Amount"
      expr: SUM(minimum_prorate_amount)
    - name: "Average Minimum Prorate Amount"
      expr: AVG(minimum_prorate_amount)
    - name: "Total Prorate Amount"
      expr: SUM(prorate_amount)
    - name: "Average Prorate Amount"
      expr: AVG(prorate_amount)
    - name: "Total Prorate Factor"
      expr: SUM(prorate_factor)
    - name: "Average Prorate Factor"
      expr: AVG(prorate_factor)
    - name: "Total Prorate Percentage"
      expr: SUM(prorate_percentage)
    - name: "Average Prorate Percentage"
      expr: AVG(prorate_percentage)
    - name: "Total Prorated Revenue Amount"
      expr: SUM(prorated_revenue_amount)
    - name: "Average Prorated Revenue Amount"
      expr: AVG(prorated_revenue_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ndc_offer_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ndc Offer Order business metrics"
  source: "`airlines_ecm`.`revenue`.`ndc_offer_order`"
  dimensions:
    - name: "Buyer Type"
      expr: buyer_type
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Ffp Member Number"
      expr: ffp_member_number
    - name: "Form Of Payment Type"
      expr: form_of_payment_type
    - name: "Last Servicing Timestamp"
      expr: last_servicing_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Loyalty Miles Earned"
      expr: loyalty_miles_earned
    - name: "Ndc Order Reference"
      expr: ndc_order_reference
    - name: "Ndc Provider Code"
      expr: ndc_provider_code
    - name: "Ndc Schema Version"
      expr: ndc_schema_version
    - name: "Order Created Timestamp"
      expr: order_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ndc Offer Order"
      expr: COUNT(DISTINCT ndc_offer_order_id)
    - name: "Total Ancillary Amount"
      expr: SUM(ancillary_amount)
    - name: "Average Ancillary Amount"
      expr: AVG(ancillary_amount)
    - name: "Total Base Fare Amount"
      expr: SUM(base_fare_amount)
    - name: "Average Base Fare Amount"
      expr: AVG(base_fare_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Order Amount"
      expr: SUM(total_order_amount)
    - name: "Average Total Order Amount"
      expr: AVG(total_order_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_pricing_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing Record business metrics"
  source: "`airlines_ecm`.`revenue`.`pricing_record`"
  dimensions:
    - name: "Advance Purchase Days"
      expr: advance_purchase_days
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Changeable Flag"
      expr: changeable_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Fare Type"
      expr: fare_type
    - name: "Form Of Payment Restriction"
      expr: form_of_payment_restriction
    - name: "Max Stay Requirement"
      expr: max_stay_requirement
    - name: "Min Stay Requirement"
      expr: min_stay_requirement
    - name: "Ndc Offer Reference"
      expr: ndc_offer_reference
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Passenger Type Code"
      expr: passenger_type_code
    - name: "Pnr Locator"
      expr: pnr_locator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pricing Record"
      expr: COUNT(DISTINCT pricing_record_id)
    - name: "Total Base Fare Amount"
      expr: SUM(base_fare_amount)
    - name: "Average Base Fare Amount"
      expr: AVG(base_fare_amount)
    - name: "Total Carrier Surcharge Amount"
      expr: SUM(carrier_surcharge_amount)
    - name: "Average Carrier Surcharge Amount"
      expr: AVG(carrier_surcharge_amount)
    - name: "Total Equivalent Fare Amount"
      expr: SUM(equivalent_fare_amount)
    - name: "Average Equivalent Fare Amount"
      expr: AVG(equivalent_fare_amount)
    - name: "Total Iata Rate Of Exchange"
      expr: SUM(iata_rate_of_exchange)
    - name: "Average Iata Rate Of Exchange"
      expr: AVG(iata_rate_of_exchange)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Fare Amount"
      expr: SUM(total_fare_amount)
    - name: "Average Total Fare Amount"
      expr: AVG(total_fare_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_recognition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recognition business metrics"
  source: "`airlines_ecm`.`revenue`.`recognition`"
  dimensions:
    - name: "Accounting Period"
      expr: accounting_period
    - name: "Accounting Status"
      expr: accounting_status
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Codeshare Flag"
      expr: codeshare_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Emd Number"
      expr: emd_number
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Flight Date"
      expr: flight_date
    - name: "Flight Number"
      expr: flight_number
    - name: "Form Of Payment Type"
      expr: form_of_payment_type
    - name: "Interline Flag"
      expr: interline_flag
    - name: "Issuing Airline Code"
      expr: issuing_airline_code
    - name: "Operating Airline Code"
      expr: operating_airline_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Recognition"
      expr: COUNT(DISTINCT recognition_id)
    - name: "Total Exchange Rate"
      expr: SUM(exchange_rate)
    - name: "Average Exchange Rate"
      expr: AVG(exchange_rate)
    - name: "Total Fare Amount"
      expr: SUM(fare_amount)
    - name: "Average Fare Amount"
      expr: AVG(fare_amount)
    - name: "Total Fuel Surcharge Amount"
      expr: SUM(fuel_surcharge_amount)
    - name: "Average Fuel Surcharge Amount"
      expr: AVG(fuel_surcharge_amount)
    - name: "Total Prorate Amount"
      expr: SUM(prorate_amount)
    - name: "Average Prorate Amount"
      expr: AVG(prorate_amount)
    - name: "Total Reporting Currency Amount"
      expr: SUM(reporting_currency_amount)
    - name: "Average Reporting Currency Amount"
      expr: AVG(reporting_currency_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_revenue_bundle_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Bundle Component business metrics"
  source: "`airlines_ecm`.`revenue`.`revenue_bundle_component`"
  dimensions:
    - name: "Channel Override"
      expr: channel_override
    - name: "Display Priority"
      expr: display_priority
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Inclusion Type"
      expr: inclusion_type
    - name: "Marketing Highlight Flag"
      expr: marketing_highlight_flag
    - name: "Quantity Entitlement"
      expr: quantity_entitlement
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
    - name: "Expiry Date Month"
      expr: DATE_TRUNC('MONTH', expiry_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Bundle Component"
      expr: COUNT(DISTINCT revenue_bundle_component_id)
    - name: "Total Incremental Charge Amount"
      expr: SUM(incremental_charge_amount)
    - name: "Average Incremental Charge Amount"
      expr: AVG(incremental_charge_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_revenue_emd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Emd business metrics"
  source: "`airlines_ecm`.`revenue`.`revenue_emd`"
  dimensions:
    - name: "Associated Ticket Coupon"
      expr: associated_ticket_coupon
    - name: "Bsp Arc Billing Period"
      expr: bsp_arc_billing_period
    - name: "Bsp Arc Reporting Flag"
      expr: bsp_arc_reporting_flag
    - name: "Coupon Number"
      expr: coupon_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Emd Number"
      expr: emd_number
    - name: "Emd Status"
      expr: emd_status
    - name: "Emd Type"
      expr: emd_type
    - name: "Exchange Emd Number"
      expr: exchange_emd_number
    - name: "Flight Number"
      expr: flight_number
    - name: "Form Of Payment Detail"
      expr: form_of_payment_detail
    - name: "Form Of Payment Type"
      expr: form_of_payment_type
    - name: "Gds Code"
      expr: gds_code
    - name: "Interline Indicator"
      expr: interline_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Emd"
      expr: COUNT(DISTINCT revenue_emd_id)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Equivalent Amount"
      expr: SUM(equivalent_amount)
    - name: "Average Equivalent Amount"
      expr: AVG(equivalent_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_revenue_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Refund business metrics"
  source: "`airlines_ecm`.`revenue`.`revenue_refund`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Bsp Arc Settlement Date"
      expr: bsp_arc_settlement_date
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Ffp Miles Refunded"
      expr: ffp_miles_refunded
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Involuntary Reason"
      expr: involuntary_reason
    - name: "Issuing Airline Code"
      expr: issuing_airline_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Original Departure Date"
      expr: original_departure_date
    - name: "Original Form Of Payment Code"
      expr: original_form_of_payment_code
    - name: "Pnr Code"
      expr: pnr_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Refund"
      expr: COUNT(DISTINCT revenue_refund_id)
    - name: "Total Fare Amount"
      expr: SUM(fare_amount)
    - name: "Average Fare Amount"
      expr: AVG(fare_amount)
    - name: "Total Gross Fare Amount"
      expr: SUM(gross_fare_amount)
    - name: "Average Gross Fare Amount"
      expr: AVG(gross_fare_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Tax Refund Amount"
      expr: SUM(tax_refund_amount)
    - name: "Average Tax Refund Amount"
      expr: AVG(tax_refund_amount)
    - name: "Total Total Refund Amount"
      expr: SUM(total_refund_amount)
    - name: "Average Total Refund Amount"
      expr: AVG(total_refund_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_revenue_surcharge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Surcharge business metrics"
  source: "`airlines_ecm`.`revenue`.`revenue_surcharge`"
  dimensions:
    - name: "Atpco Record Type"
      expr: atpco_record_type
    - name: "Booking Class Applicability"
      expr: booking_class_applicability
    - name: "Cabin Applicability"
      expr: cabin_applicability
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Directionality"
      expr: directionality
    - name: "Discontinue Date"
      expr: discontinue_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Filing Date"
      expr: filing_date
    - name: "Filing Source"
      expr: filing_source
    - name: "Global Indicator"
      expr: global_indicator
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Surcharge"
      expr: COUNT(DISTINCT revenue_surcharge_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Maximum Amount"
      expr: SUM(maximum_amount)
    - name: "Average Maximum Amount"
      expr: AVG(maximum_amount)
    - name: "Total Minimum Amount"
      expr: SUM(minimum_amount)
    - name: "Average Minimum Amount"
      expr: AVG(minimum_amount)
    - name: "Total Nuc Amount"
      expr: SUM(nuc_amount)
    - name: "Average Nuc Amount"
      expr: AVG(nuc_amount)
    - name: "Total Percentage Rate"
      expr: SUM(percentage_rate)
    - name: "Average Percentage Rate"
      expr: AVG(percentage_rate)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_tax_fee`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax Fee business metrics"
  source: "`airlines_ecm`.`revenue`.`tax_fee`"
  dimensions:
    - name: "Airport Code"
      expr: airport_code
    - name: "Applicability Scope"
      expr: applicability_scope
    - name: "Cabin Class Applicability"
      expr: cabin_class_applicability
    - name: "Calculation Method"
      expr: calculation_method
    - name: "Collecting Authority Name"
      expr: collecting_authority_name
    - name: "Collecting Authority Type"
      expr: collecting_authority_type
    - name: "Corsia Applicable"
      expr: corsia_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Exempt Passenger Types"
      expr: exempt_passenger_types
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gds Display Code"
      expr: gds_display_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Iata Tax Category"
      expr: iata_tax_category
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tax Fee"
      expr: COUNT(DISTINCT tax_fee_id)
    - name: "Total Maximum Amount"
      expr: SUM(maximum_amount)
    - name: "Average Maximum Amount"
      expr: AVG(maximum_amount)
    - name: "Total Minimum Amount"
      expr: SUM(minimum_amount)
    - name: "Average Minimum Amount"
      expr: AVG(minimum_amount)
    - name: "Total Rate Amount"
      expr: SUM(rate_amount)
    - name: "Average Rate Amount"
      expr: AVG(rate_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ticket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket business metrics"
  source: "`airlines_ecm`.`revenue`.`ticket`"
  dimensions:
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Conjunction Ticket Indicator"
      expr: conjunction_ticket_indicator
    - name: "Conjunction Ticket Number"
      expr: conjunction_ticket_number
    - name: "Coupon Count"
      expr: coupon_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Endorsement Restriction Text"
      expr: endorsement_restriction_text
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Fare Currency Code"
      expr: fare_currency_code
    - name: "Fare Type"
      expr: fare_type
    - name: "Ffp Miles Earned"
      expr: ffp_miles_earned
    - name: "Form Of Payment Detail"
      expr: form_of_payment_detail
    - name: "Form Of Payment Type"
      expr: form_of_payment_type
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Origin Airport Code"
      expr: origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ticket"
      expr: COUNT(DISTINCT ticket_id)
    - name: "Total Base Fare Amount"
      expr: SUM(base_fare_amount)
    - name: "Average Base Fare Amount"
      expr: AVG(base_fare_amount)
    - name: "Total Net Remit Amount"
      expr: SUM(net_remit_amount)
    - name: "Average Net Remit Amount"
      expr: AVG(net_remit_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Total Amount"
      expr: SUM(tax_total_amount)
    - name: "Average Tax Total Amount"
      expr: AVG(tax_total_amount)
    - name: "Total Total Fare Amount"
      expr: SUM(total_fare_amount)
    - name: "Average Total Fare Amount"
      expr: AVG(total_fare_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ticket_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket Coupon business metrics"
  source: "`airlines_ecm`.`revenue`.`ticket_coupon`"
  dimensions:
    - name: "Actual Departure Date"
      expr: actual_departure_date
    - name: "Baggage Allowance"
      expr: baggage_allowance
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Coupon Number"
      expr: coupon_number
    - name: "Coupon Status"
      expr: coupon_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Departure Date"
      expr: departure_date
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Exchange Ticket Number"
      expr: exchange_ticket_number
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Fare Construction Indicator"
      expr: fare_construction_indicator
    - name: "Fare Currency Code"
      expr: fare_currency_code
    - name: "Flight Number"
      expr: flight_number
    - name: "Flown Date"
      expr: flown_date
    - name: "Issuing Date"
      expr: issuing_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ticket Coupon"
      expr: COUNT(DISTINCT ticket_coupon_id)
    - name: "Total Fare Amount"
      expr: SUM(fare_amount)
    - name: "Average Fare Amount"
      expr: AVG(fare_amount)
    - name: "Total Nuc Amount"
      expr: SUM(nuc_amount)
    - name: "Average Nuc Amount"
      expr: AVG(nuc_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_ticket_exchange`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ticket Exchange business metrics"
  source: "`airlines_ecm`.`revenue`.`ticket_exchange`"
  dimensions:
    - name: "Collection Method"
      expr: collection_method
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Emd Number"
      expr: emd_number
    - name: "Exchange Date"
      expr: exchange_date
    - name: "Exchange Reference Number"
      expr: exchange_reference_number
    - name: "Exchange Status"
      expr: exchange_status
    - name: "Exchange Type"
      expr: exchange_type
    - name: "Gds Transaction Reference"
      expr: gds_transaction_reference
    - name: "Involuntary Reason Code"
      expr: involuntary_reason_code
    - name: "Issuing Carrier Code"
      expr: issuing_carrier_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "New Cabin Class"
      expr: new_cabin_class
    - name: "New Destination Airport Code"
      expr: new_destination_airport_code
    - name: "New Fare Basis Code"
      expr: new_fare_basis_code
    - name: "New Origin Airport Code"
      expr: new_origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ticket Exchange"
      expr: COUNT(DISTINCT ticket_exchange_id)
    - name: "Total Fare Difference Amount"
      expr: SUM(fare_difference_amount)
    - name: "Average Fare Difference Amount"
      expr: AVG(fare_difference_amount)
    - name: "Total New Fare Amount"
      expr: SUM(new_fare_amount)
    - name: "Average New Fare Amount"
      expr: AVG(new_fare_amount)
    - name: "Total Original Fare Amount"
      expr: SUM(original_fare_amount)
    - name: "Average Original Fare Amount"
      expr: AVG(original_fare_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Tax Difference Amount"
      expr: SUM(tax_difference_amount)
    - name: "Average Tax Difference Amount"
      expr: AVG(tax_difference_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`revenue_yield_parameter`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Yield Parameter business metrics"
  source: "`airlines_ecm`.`revenue`.`yield_parameter`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Booking Class Threshold Count"
      expr: booking_class_threshold_count
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Dynamic Pricing Enabled"
      expr: dynamic_pricing_enabled
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Forecast Horizon Days"
      expr: forecast_horizon_days
    - name: "Forecast Model Type"
      expr: forecast_model_type
    - name: "Group Booking Threshold"
      expr: group_booking_threshold
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Od Control Enabled"
      expr: od_control_enabled
    - name: "Optimization Method"
      expr: optimization_method
    - name: "Origin Airport Code"
      expr: origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Yield Parameter"
      expr: COUNT(DISTINCT yield_parameter_id)
    - name: "Total Cancellation Rate"
      expr: SUM(cancellation_rate)
    - name: "Average Cancellation Rate"
      expr: AVG(cancellation_rate)
    - name: "Total Cask Benchmark"
      expr: SUM(cask_benchmark)
    - name: "Average Cask Benchmark"
      expr: AVG(cask_benchmark)
    - name: "Total Dilution Tolerance"
      expr: SUM(dilution_tolerance)
    - name: "Average Dilution Tolerance"
      expr: AVG(dilution_tolerance)
    - name: "Total Dynamic Pricing Ceiling"
      expr: SUM(dynamic_pricing_ceiling)
    - name: "Average Dynamic Pricing Ceiling"
      expr: AVG(dynamic_pricing_ceiling)
    - name: "Total Dynamic Pricing Floor"
      expr: SUM(dynamic_pricing_floor)
    - name: "Average Dynamic Pricing Floor"
      expr: AVG(dynamic_pricing_floor)
    - name: "Total Historical Weight"
      expr: SUM(historical_weight)
    - name: "Average Historical Weight"
      expr: AVG(historical_weight)
    - name: "Total Load Factor Minimum"
      expr: SUM(load_factor_minimum)
    - name: "Average Load Factor Minimum"
      expr: AVG(load_factor_minimum)
    - name: "Total Load Factor Target"
      expr: SUM(load_factor_target)
    - name: "Average Load Factor Target"
      expr: AVG(load_factor_target)
    - name: "Total Minimum Yield Floor"
      expr: SUM(minimum_yield_floor)
    - name: "Average Minimum Yield Floor"
      expr: AVG(minimum_yield_floor)
    - name: "Total No Show Rate"
      expr: SUM(no_show_rate)
    - name: "Average No Show Rate"
      expr: AVG(no_show_rate)
    - name: "Total Overbooking Authorization Rate"
      expr: SUM(overbooking_authorization_rate)
    - name: "Average Overbooking Authorization Rate"
      expr: AVG(overbooking_authorization_rate)
    - name: "Total Pickup Weight"
      expr: SUM(pickup_weight)
    - name: "Average Pickup Weight"
      expr: AVG(pickup_weight)
$$;