-- Metric views for domain: ancillary | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:57:24

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_ancillary_bundle_component`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary Bundle Component business metrics"
  source: "`airlines_ecm`.`ancillary`.`ancillary_bundle_component`"
  dimensions:
    - name: "Ancillary Bundle Component Status"
      expr: ancillary_bundle_component_status
    - name: "Booking Channel Restriction"
      expr: booking_channel_restriction
    - name: "Cabin Class Restriction"
      expr: cabin_class_restriction
    - name: "Charge Currency Code"
      expr: charge_currency_code
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Component Sequence"
      expr: component_sequence
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Emd Type"
      expr: emd_type
    - name: "Entitlement Unit"
      expr: entitlement_unit
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fulfillment Timing"
      expr: fulfillment_timing
    - name: "Inclusion Type"
      expr: inclusion_type
    - name: "Is Chargeable"
      expr: is_chargeable
    - name: "Is Refundable"
      expr: is_refundable
    - name: "Is Transferable"
      expr: is_transferable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ancillary Bundle Component"
      expr: COUNT(DISTINCT ancillary_bundle_component_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
    - name: "Total Incremental Charge Amount"
      expr: SUM(incremental_charge_amount)
    - name: "Average Incremental Charge Amount"
      expr: AVG(incremental_charge_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_ancillary_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary Category business metrics"
  source: "`airlines_ecm`.`ancillary`.`ancillary_category`"
  dimensions:
    - name: "Ancillary Category Status"
      expr: ancillary_category_status
    - name: "Atpco Service Group"
      expr: atpco_service_group
    - name: "Category Code"
      expr: category_code
    - name: "Category Description"
      expr: category_description
    - name: "Category Level"
      expr: category_level
    - name: "Category Name"
      expr: category_name
    - name: "Category Type"
      expr: category_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Direct Channel Only Flag"
      expr: direct_channel_only_flag
    - name: "Display Sequence"
      expr: display_sequence
    - name: "Dot Reportable Flag"
      expr: dot_reportable_flag
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Emd Eligible Flag"
      expr: emd_eligible_flag
    - name: "Emd Type"
      expr: emd_type
    - name: "Gds Distribution Flag"
      expr: gds_distribution_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ancillary Category"
      expr: COUNT(DISTINCT ancillary_category_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_ancillary_emd`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary Emd business metrics"
  source: "`airlines_ecm`.`ancillary`.`ancillary_emd`"
  dimensions:
    - name: "Ancillary Service Code"
      expr: ancillary_service_code
    - name: "Coupon Number"
      expr: coupon_number
    - name: "Coupon Status"
      expr: coupon_status
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
    - name: "Endorsement Restrictions"
      expr: endorsement_restrictions
    - name: "Exchange Indicator"
      expr: exchange_indicator
    - name: "Flight Number"
      expr: flight_number
    - name: "Form Of Payment"
      expr: form_of_payment
    - name: "Issue Date"
      expr: issue_date
    - name: "Issue Timestamp"
      expr: issue_timestamp
    - name: "Issuing Airline Code"
      expr: issuing_airline_code
    - name: "Origin Airport Code"
      expr: origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ancillary Emd"
      expr: COUNT(DISTINCT ancillary_emd_id)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Percentage"
      expr: SUM(commission_percentage)
    - name: "Average Commission Percentage"
      expr: AVG(commission_percentage)
    - name: "Total Face Value Amount"
      expr: SUM(face_value_amount)
    - name: "Average Face Value Amount"
      expr: AVG(face_value_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_ancillary_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary Order business metrics"
  source: "`airlines_ecm`.`ancillary`.`ancillary_order`"
  dimensions:
    - name: "Booking Class"
      expr: booking_class
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Departure Date"
      expr: departure_date
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Emd Number"
      expr: emd_number
    - name: "Emd Type"
      expr: emd_type
    - name: "Flight Number"
      expr: flight_number
    - name: "Fulfillment Date"
      expr: fulfillment_date
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Order Date"
      expr: order_date
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Origin Airport Code"
      expr: origin_airport_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ancillary Order"
      expr: COUNT(DISTINCT ancillary_order_id)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
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

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_ancillary_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ancillary Refund business metrics"
  source: "`airlines_ecm`.`ancillary`.`ancillary_refund`"
  dimensions:
    - name: "Ancillary Category Code"
      expr: ancillary_category_code
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Emd Coupon Number"
      expr: emd_coupon_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Miles Credited"
      expr: miles_credited
    - name: "Notes"
      expr: notes
    - name: "Payment Method Original"
      expr: payment_method_original
    - name: "Payment Reference Original"
      expr: payment_reference_original
    - name: "Processed Timestamp"
      expr: processed_timestamp
    - name: "Processing Channel"
      expr: processing_channel
    - name: "Processing Location Code"
      expr: processing_location_code
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ancillary Refund"
      expr: COUNT(DISTINCT ancillary_refund_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Original Purchase Amount"
      expr: SUM(original_purchase_amount)
    - name: "Average Original Purchase Amount"
      expr: AVG(original_purchase_amount)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total Tax Refund Amount"
      expr: SUM(tax_refund_amount)
    - name: "Average Tax Refund Amount"
      expr: AVG(tax_refund_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_baggage_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Baggage Allowance business metrics"
  source: "`airlines_ecm`.`ancillary`.`baggage_allowance`"
  dimensions:
    - name: "Allowance Code"
      expr: allowance_code
    - name: "Allowance Name"
      expr: allowance_name
    - name: "Allowance Type"
      expr: allowance_type
    - name: "Applicable Ptc"
      expr: applicable_ptc
    - name: "Baggage Allowance Status"
      expr: baggage_allowance_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Region Code"
      expr: destination_region_code
    - name: "Dimension Limit Cm"
      expr: dimension_limit_cm
    - name: "Dimension Limit Inches"
      expr: dimension_limit_inches
    - name: "Effective Date"
      expr: effective_date
    - name: "Emd Type"
      expr: emd_type
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fare Brand Code"
      expr: fare_brand_code
    - name: "Ffp Tier Code"
      expr: ffp_tier_code
    - name: "Interline Agreement Code"
      expr: interline_agreement_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Baggage Allowance"
      expr: COUNT(DISTINCT baggage_allowance_id)
    - name: "Total Weight Limit Kg"
      expr: SUM(weight_limit_kg)
    - name: "Average Weight Limit Kg"
      expr: AVG(weight_limit_kg)
    - name: "Total Weight Limit Lbs"
      expr: SUM(weight_limit_lbs)
    - name: "Average Weight Limit Lbs"
      expr: AVG(weight_limit_lbs)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_bundle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bundle business metrics"
  source: "`airlines_ecm`.`ancillary`.`bundle`"
  dimensions:
    - name: "Baggage Allowance Pieces"
      expr: baggage_allowance_pieces
    - name: "Booking Channel Restriction"
      expr: booking_channel_restriction
    - name: "Bundle Code"
      expr: bundle_code
    - name: "Bundle Description"
      expr: bundle_description
    - name: "Bundle Name"
      expr: bundle_name
    - name: "Bundle Status"
      expr: bundle_status
    - name: "Bundle Tier"
      expr: bundle_tier
    - name: "Bundle Type"
      expr: bundle_type
    - name: "Cancellation Refundable Flag"
      expr: cancellation_refundable_flag
    - name: "Change Fee Waived Flag"
      expr: change_fee_waived_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Included Services Count"
      expr: included_services_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bundle"
      expr: COUNT(DISTINCT bundle_id)
    - name: "Total Baggage Allowance Weight Kg"
      expr: SUM(baggage_allowance_weight_kg)
    - name: "Average Baggage Allowance Weight Kg"
      expr: AVG(baggage_allowance_weight_kg)
    - name: "Total Base Price Amount"
      expr: SUM(base_price_amount)
    - name: "Average Base Price Amount"
      expr: AVG(base_price_amount)
    - name: "Total Mileage Accrual Percentage"
      expr: SUM(mileage_accrual_percentage)
    - name: "Average Mileage Accrual Percentage"
      expr: AVG(mileage_accrual_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_channel_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Channel Vendor Agreement business metrics"
  source: "`airlines_ecm`.`ancillary`.`channel_vendor_agreement`"
  dimensions:
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Integration Method"
      expr: integration_method
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Service Level Agreement"
      expr: service_level_agreement
    - name: "Settlement Method"
      expr: settlement_method
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Channel Vendor Agreement"
      expr: COUNT(DISTINCT channel_vendor_agreement_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_eligibility_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Eligibility Rule business metrics"
  source: "`airlines_ecm`.`ancillary`.`eligibility_rule`"
  dimensions:
    - name: "Aircraft Type List"
      expr: aircraft_type_list
    - name: "Booking Date From"
      expr: booking_date_from
    - name: "Booking Date To"
      expr: booking_date_to
    - name: "Cabin Class List"
      expr: cabin_class_list
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport List"
      expr: destination_airport_list
    - name: "Destination Country List"
      expr: destination_country_list
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusion Rule Flag"
      expr: exclusion_rule_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fare Class List"
      expr: fare_class_list
    - name: "Ffp Tier List"
      expr: ffp_tier_list
    - name: "Is Combinable"
      expr: is_combinable
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Eligibility Rule"
      expr: COUNT(DISTINCT eligibility_rule_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_emd_coupon`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emd Coupon business metrics"
  source: "`airlines_ecm`.`ancillary`.`emd_coupon`"
  dimensions:
    - name: "Booking Class"
      expr: booking_class
    - name: "Bsp Link Number"
      expr: bsp_link_number
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Conjunctive Ticket Indicator"
      expr: conjunctive_ticket_indicator
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Coupon Currency Code"
      expr: coupon_currency_code
    - name: "Coupon Number"
      expr: coupon_number
    - name: "Coupon Status"
      expr: coupon_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Endorsement Restrictions"
      expr: endorsement_restrictions
    - name: "Exchange Indicator"
      expr: exchange_indicator
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Flight Date"
      expr: flight_date
    - name: "Flight Number"
      expr: flight_number
    - name: "Form Of Payment"
      expr: form_of_payment
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Emd Coupon"
      expr: COUNT(DISTINCT emd_coupon_id)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Coupon Amount"
      expr: SUM(coupon_amount)
    - name: "Average Coupon Amount"
      expr: AVG(coupon_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_excess_baggage_charge`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Excess Baggage Charge business metrics"
  source: "`airlines_ecm`.`ancillary`.`excess_baggage_charge`"
  dimensions:
    - name: "Airport Code"
      expr: airport_code
    - name: "Baggage Allowance Pieces"
      expr: baggage_allowance_pieces
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Charge Status"
      expr: charge_status
    - name: "Charge Timestamp"
      expr: charge_timestamp
    - name: "Collection Point"
      expr: collection_point
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Excess Piece Count"
      expr: excess_piece_count
    - name: "Fare Class"
      expr: fare_class
    - name: "Ffp Tier"
      expr: ffp_tier
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Method"
      expr: payment_method
    - name: "Payment Reference"
      expr: payment_reference
    - name: "Refund Reason"
      expr: refund_reason
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Excess Baggage Charge"
      expr: COUNT(DISTINCT excess_baggage_charge_id)
    - name: "Total Baggage Allowance Kg"
      expr: SUM(baggage_allowance_kg)
    - name: "Average Baggage Allowance Kg"
      expr: AVG(baggage_allowance_kg)
    - name: "Total Base Charge Amount"
      expr: SUM(base_charge_amount)
    - name: "Average Base Charge Amount"
      expr: AVG(base_charge_amount)
    - name: "Total Excess Weight Kg"
      expr: SUM(excess_weight_kg)
    - name: "Average Excess Weight Kg"
      expr: AVG(excess_weight_kg)
    - name: "Total Rate Per Kg"
      expr: SUM(rate_per_kg)
    - name: "Average Rate Per Kg"
      expr: AVG(rate_per_kg)
    - name: "Total Rate Per Piece"
      expr: SUM(rate_per_piece)
    - name: "Average Rate Per Piece"
      expr: AVG(rate_per_piece)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Charge Amount"
      expr: SUM(total_charge_amount)
    - name: "Average Total Charge Amount"
      expr: AVG(total_charge_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_inflight_retail_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inflight Retail Order business metrics"
  source: "`airlines_ecm`.`ancillary`.`inflight_retail_order`"
  dimensions:
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Card Last Four Digits"
      expr: card_last_four_digits
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Fulfillment Timestamp"
      expr: fulfillment_timestamp
    - name: "Item Description"
      expr: item_description
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Miles Earned"
      expr: miles_earned
    - name: "Miles Redeemed"
      expr: miles_redeemed
    - name: "Notes"
      expr: notes
    - name: "Order Number"
      expr: order_number
    - name: "Order Status"
      expr: order_status
    - name: "Order Type"
      expr: order_type
    - name: "Payment Channel"
      expr: payment_channel
    - name: "Payment Method"
      expr: payment_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Inflight Retail Order"
      expr: COUNT(DISTINCT inflight_retail_order_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Unit Price Amount"
      expr: SUM(unit_price_amount)
    - name: "Average Unit Price Amount"
      expr: AVG(unit_price_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_lounge_access`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lounge Access business metrics"
  source: "`airlines_ecm`.`ancillary`.`lounge_access`"
  dimensions:
    - name: "Access Date"
      expr: access_date
    - name: "Access Method"
      expr: access_method
    - name: "Access Status"
      expr: access_status
    - name: "Access Timestamp"
      expr: access_timestamp
    - name: "Access Type"
      expr: access_type
    - name: "Airport Code"
      expr: airport_code
    - name: "Booking Channel"
      expr: booking_channel
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Denial Reason"
      expr: denial_reason
    - name: "Dot Reportable Flag"
      expr: dot_reportable_flag
    - name: "Emd Type"
      expr: emd_type
    - name: "Exit Timestamp"
      expr: exit_timestamp
    - name: "Fare Class"
      expr: fare_class
    - name: "Ffp Tier Code"
      expr: ffp_tier_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lounge Access"
      expr: COUNT(DISTINCT lounge_access_id)
    - name: "Total Charge Amount"
      expr: SUM(charge_amount)
    - name: "Average Charge Amount"
      expr: AVG(charge_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_meal_preorder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meal Preorder business metrics"
  source: "`airlines_ecm`.`ancillary`.`meal_preorder`"
  dimensions:
    - name: "Advance Order Hours"
      expr: advance_order_hours
    - name: "Allergy Flag"
      expr: allergy_flag
    - name: "Cabin Class"
      expr: cabin_class
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Catering Uplift Station"
      expr: catering_uplift_station
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Status"
      expr: delivery_status
    - name: "Dietary Classification"
      expr: dietary_classification
    - name: "Emd Type Code"
      expr: emd_type_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Meal Type Description"
      expr: meal_type_description
    - name: "Minimum Advance Required Hours"
      expr: minimum_advance_required_hours
    - name: "Modification Timestamp"
      expr: modification_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Meal Preorder"
      expr: COUNT(DISTINCT meal_preorder_id)
    - name: "Total Meal Charge Amount"
      expr: SUM(meal_charge_amount)
    - name: "Average Meal Charge Amount"
      expr: AVG(meal_charge_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_order_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Item business metrics"
  source: "`airlines_ecm`.`ancillary`.`order_item`"
  dimensions:
    - name: "Booking Timestamp"
      expr: booking_timestamp
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Emd Type"
      expr: emd_type
    - name: "Flight Date"
      expr: flight_date
    - name: "Flight Number"
      expr: flight_number
    - name: "Fulfilment Reference"
      expr: fulfilment_reference
    - name: "Issued Timestamp"
      expr: issued_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Passenger Name"
      expr: passenger_name
    - name: "Product Code"
      expr: product_code
    - name: "Product Name"
      expr: product_name
    - name: "Quantity"
      expr: quantity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Item"
      expr: COUNT(DISTINCT order_item_id)
    - name: "Total Base Amount"
      expr: SUM(base_amount)
    - name: "Average Base Amount"
      expr: AVG(base_amount)
    - name: "Total Commission Amount"
      expr: SUM(commission_amount)
    - name: "Average Commission Amount"
      expr: AVG(commission_amount)
    - name: "Total Commission Percentage"
      expr: SUM(commission_percentage)
    - name: "Average Commission Percentage"
      expr: AVG(commission_percentage)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
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

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Price business metrics"
  source: "`airlines_ecm`.`ancillary`.`price`"
  dimensions:
    - name: "Booking Class"
      expr: booking_class
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Emd Type"
      expr: emd_type
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fare Basis Code"
      expr: fare_basis_code
    - name: "Market Code"
      expr: market_code
    - name: "Maximum Quantity"
      expr: maximum_quantity
    - name: "Minimum Quantity"
      expr: minimum_quantity
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Passenger Type Code"
      expr: passenger_type_code
    - name: "Price Code"
      expr: price_code
    - name: "Price Description"
      expr: price_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Price"
      expr: COUNT(DISTINCT price_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Fare Amount"
      expr: SUM(fare_amount)
    - name: "Average Fare Amount"
      expr: AVG(fare_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_product_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Catalog business metrics"
  source: "`airlines_ecm`.`ancillary`.`product_catalog`"
  dimensions:
    - name: "Base Price Currency"
      expr: base_price_currency
    - name: "Booking Window End Hours"
      expr: booking_window_end_hours
    - name: "Booking Window Start Hours"
      expr: booking_window_start_hours
    - name: "Cabin Class Eligibility"
      expr: cabin_class_eligibility
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fare Family Eligibility"
      expr: fare_family_eligibility
    - name: "Iata Emd Service Type"
      expr: iata_emd_service_type
    - name: "Iata Ssim Service Code"
      expr: iata_ssim_service_code
    - name: "Inventory Controlled Flag"
      expr: inventory_controlled_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Quantity"
      expr: maximum_quantity
    - name: "Minimum Quantity"
      expr: minimum_quantity
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Product Catalog"
      expr: COUNT(DISTINCT product_catalog_id)
    - name: "Total Base Price Amount"
      expr: SUM(base_price_amount)
    - name: "Average Base Price Amount"
      expr: AVG(base_price_amount)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_sales_channel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sales Channel business metrics"
  source: "`airlines_ecm`.`ancillary`.`sales_channel`"
  dimensions:
    - name: "Api Endpoint Url"
      expr: api_endpoint_url
    - name: "Bundling Supported Flag"
      expr: bundling_supported_flag
    - name: "Channel Category"
      expr: channel_category
    - name: "Channel Owner"
      expr: channel_owner
    - name: "Channel Status"
      expr: channel_status
    - name: "Channel Type"
      expr: channel_type
    - name: "Commission Applicable Flag"
      expr: commission_applicable_flag
    - name: "Commission Structure Type"
      expr: commission_structure_type
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Contract Reference Number"
      expr: contract_reference_number
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Dynamic Pricing Enabled Flag"
      expr: dynamic_pricing_enabled_flag
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sales Channel"
      expr: COUNT(DISTINCT sales_channel_id)
    - name: "Total Commission Rate Percent"
      expr: SUM(commission_rate_percent)
    - name: "Average Commission Rate Percent"
      expr: AVG(commission_rate_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_seat_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seat Assignment business metrics"
  source: "`airlines_ecm`.`ancillary`.`seat_assignment`"
  dimensions:
    - name: "Assignment Method"
      expr: assignment_method
    - name: "Assignment Source System"
      expr: assignment_source_system
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Timestamp"
      expr: assignment_timestamp
    - name: "Block Reason"
      expr: block_reason
    - name: "Boarding Zone"
      expr: boarding_zone
    - name: "Cabin Class Code"
      expr: cabin_class_code
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Change Reason Code"
      expr: change_reason_code
    - name: "Check In Sequence Number"
      expr: check_in_sequence_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Deck Level"
      expr: deck_level
    - name: "Group Booking Indicator"
      expr: group_booking_indicator
    - name: "Infant Indicator"
      expr: infant_indicator
    - name: "Is Blocked"
      expr: is_blocked
    - name: "Is Complimentary"
      expr: is_complimentary
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Seat Assignment"
      expr: COUNT(DISTINCT seat_assignment_id)
    - name: "Total Seat Fee Amount"
      expr: SUM(seat_fee_amount)
    - name: "Average Seat Fee Amount"
      expr: AVG(seat_fee_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_seat_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seat Product business metrics"
  source: "`airlines_ecm`.`ancillary`.`seat_product`"
  dimensions:
    - name: "Advance Selection Window Hours"
      expr: advance_selection_window_hours
    - name: "Bundle Eligibility"
      expr: bundle_eligibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Emd Type"
      expr: emd_type
    - name: "Fare Class Eligibility"
      expr: fare_class_eligibility
    - name: "Ffp Tier Eligibility"
      expr: ffp_tier_eligibility
    - name: "In Seat Entertainment"
      expr: in_seat_entertainment
    - name: "Is Advance Selection Allowed"
      expr: is_advance_selection_allowed
    - name: "Is Bassinet Compatible"
      expr: is_bassinet_compatible
    - name: "Is Bulkhead"
      expr: is_bulkhead
    - name: "Is Chargeable"
      expr: is_chargeable
    - name: "Is Exit Row"
      expr: is_exit_row
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Seat Product"
      expr: COUNT(DISTINCT seat_product_id)
    - name: "Total Base Price Usd"
      expr: SUM(base_price_usd)
    - name: "Average Base Price Usd"
      expr: AVG(base_price_usd)
    - name: "Total Recline Inches"
      expr: SUM(recline_inches)
    - name: "Average Recline Inches"
      expr: AVG(recline_inches)
    - name: "Total Seat Pitch Inches"
      expr: SUM(seat_pitch_inches)
    - name: "Average Seat Pitch Inches"
      expr: AVG(seat_pitch_inches)
    - name: "Total Seat Width Inches"
      expr: SUM(seat_width_inches)
    - name: "Average Seat Width Inches"
      expr: AVG(seat_width_inches)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_upgrade_offer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upgrade Offer business metrics"
  source: "`airlines_ecm`.`ancillary`.`upgrade_offer`"
  dimensions:
    - name: "Aircraft Type Restriction"
      expr: aircraft_type_restriction
    - name: "Channel Availability"
      expr: channel_availability
    - name: "Created By User"
      expr: created_by_user
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Eligible Fare Classes"
      expr: eligible_fare_classes
    - name: "Emd Type Code"
      expr: emd_type_code
    - name: "Ffp Tier Requirement"
      expr: ffp_tier_requirement
    - name: "Inventory Controlled Flag"
      expr: inventory_controlled_flag
    - name: "Last Modified By User"
      expr: last_modified_by_user
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Miles Required"
      expr: miles_required
    - name: "Offer Close Hours"
      expr: offer_close_hours
    - name: "Offer Code"
      expr: offer_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Upgrade Offer"
      expr: COUNT(DISTINCT upgrade_offer_id)
    - name: "Total Fixed Price Amount"
      expr: SUM(fixed_price_amount)
    - name: "Average Fixed Price Amount"
      expr: AVG(fixed_price_amount)
    - name: "Total Maximum Bid Amount"
      expr: SUM(maximum_bid_amount)
    - name: "Average Maximum Bid Amount"
      expr: AVG(maximum_bid_amount)
    - name: "Total Minimum Bid Amount"
      expr: SUM(minimum_bid_amount)
    - name: "Average Minimum Bid Amount"
      expr: AVG(minimum_bid_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`ancillary_upgrade_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Upgrade Transaction business metrics"
  source: "`airlines_ecm`.`ancillary`.`upgrade_transaction`"
  dimensions:
    - name: "Bid Acceptance Timestamp"
      expr: bid_acceptance_timestamp
    - name: "Bid Submission Timestamp"
      expr: bid_submission_timestamp
    - name: "Booking Channel"
      expr: booking_channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Denial Reason Code"
      expr: denial_reason_code
    - name: "Destination Cabin Class"
      expr: destination_cabin_class
    - name: "Destination Fare Class"
      expr: destination_fare_class
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Origin Cabin Class"
      expr: origin_cabin_class
    - name: "Origin Fare Class"
      expr: origin_fare_class
    - name: "Payment Method"
      expr: payment_method
    - name: "Priority Score"
      expr: priority_score
    - name: "Refund Processed Timestamp"
      expr: refund_processed_timestamp
    - name: "Seat Number Destination"
      expr: seat_number_destination
    - name: "Seat Number Origin"
      expr: seat_number_origin
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Upgrade Transaction"
      expr: COUNT(DISTINCT upgrade_transaction_id)
    - name: "Total Bid Amount"
      expr: SUM(bid_amount)
    - name: "Average Bid Amount"
      expr: AVG(bid_amount)
    - name: "Total Miles Redeemed"
      expr: SUM(miles_redeemed)
    - name: "Average Miles Redeemed"
      expr: AVG(miles_redeemed)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Upgrade Amount"
      expr: SUM(upgrade_amount)
    - name: "Average Upgrade Amount"
      expr: AVG(upgrade_amount)
$$;