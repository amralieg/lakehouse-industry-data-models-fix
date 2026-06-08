-- Metric views for domain: order | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:06:06

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_cancellation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cancellation business metrics"
  source: "`retail_ecm`.`order`.`cancellation`"
  dimensions:
    - name: "Approval Required Flag"
      expr: approval_required_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Cancellation Number"
      expr: cancellation_number
    - name: "Cancellation Status"
      expr: cancellation_status
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Initiator Type"
      expr: initiator_type
    - name: "Inventory Release Timestamp"
      expr: inventory_release_timestamp
    - name: "Inventory Released Flag"
      expr: inventory_released_flag
    - name: "Processing System Code"
      expr: processing_system_code
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cancellation"
      expr: COUNT(DISTINCT cancellation_id)
    - name: "Total Cancelled Amount"
      expr: SUM(cancelled_amount)
    - name: "Average Cancelled Amount"
      expr: AVG(cancelled_amount)
    - name: "Total Cancelled Quantity"
      expr: SUM(cancelled_quantity)
    - name: "Average Cancelled Quantity"
      expr: AVG(cancelled_quantity)
    - name: "Total Fee Amount"
      expr: SUM(fee_amount)
    - name: "Average Fee Amount"
      expr: AVG(fee_amount)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
    - name: "Total Restocking Fee Amount"
      expr: SUM(restocking_fee_amount)
    - name: "Average Restocking Fee Amount"
      expr: AVG(restocking_fee_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount business metrics"
  source: "`retail_ecm`.`order`.`discount`"
  dimensions:
    - name: "Applied At Level"
      expr: applied_at_level
    - name: "Applied Timestamp"
      expr: applied_timestamp
    - name: "Approval Status"
      expr: approval_status
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Code"
      expr: discount_code
    - name: "Discount Method"
      expr: discount_method
    - name: "Discount Type"
      expr: discount_type
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Reason Code"
      expr: reason_code
    - name: "Reason Description"
      expr: reason_description
    - name: "Source System"
      expr: source_system
    - name: "Source System Discount Code"
      expr: source_system_discount_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discount"
      expr: COUNT(DISTINCT discount_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Final Price"
      expr: SUM(final_price)
    - name: "Average Final Price"
      expr: AVG(final_price)
    - name: "Total Original Price"
      expr: SUM(original_price)
    - name: "Average Original Price"
      expr: AVG(original_price)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
    - name: "Total Taxable Amount Adjustment"
      expr: SUM(taxable_amount_adjustment)
    - name: "Average Taxable Amount Adjustment"
      expr: AVG(taxable_amount_adjustment)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_gift_card`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift Card business metrics"
  source: "`retail_ecm`.`order`.`gift_card`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Barcode"
      expr: barcode
    - name: "Card Number"
      expr: card_number
    - name: "Card Status"
      expr: card_status
    - name: "Card Type"
      expr: card_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Escheatment Date"
      expr: escheatment_date
    - name: "Escheatment Eligible Flag"
      expr: escheatment_eligible_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fraud Flag"
      expr: fraud_flag
    - name: "Fraud Reason Code"
      expr: fraud_reason_code
    - name: "Issue Date"
      expr: issue_date
    - name: "Issuing Channel"
      expr: issuing_channel
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Transaction Date"
      expr: last_transaction_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gift Card"
      expr: COUNT(DISTINCT gift_card_id)
    - name: "Total Current Balance"
      expr: SUM(current_balance)
    - name: "Average Current Balance"
      expr: AVG(current_balance)
    - name: "Total Initial Balance"
      expr: SUM(initial_balance)
    - name: "Average Initial Balance"
      expr: AVG(initial_balance)
    - name: "Total Total Fees Charged"
      expr: SUM(total_fees_charged)
    - name: "Average Total Fees Charged"
      expr: AVG(total_fees_charged)
    - name: "Total Total Redeemed Amount"
      expr: SUM(total_redeemed_amount)
    - name: "Average Total Redeemed Amount"
      expr: AVG(total_redeemed_amount)
    - name: "Total Total Reloaded Amount"
      expr: SUM(total_reloaded_amount)
    - name: "Average Total Reloaded Amount"
      expr: AVG(total_reloaded_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_gift_card_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gift Card Transaction business metrics"
  source: "`retail_ecm`.`order`.`gift_card_transaction`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Business Date"
      expr: business_date
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Escheatment Flag"
      expr: escheatment_flag
    - name: "Escheatment Jurisdiction"
      expr: escheatment_jurisdiction
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fraud Decision"
      expr: fraud_decision
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Notes"
      expr: notes
    - name: "Payment Method Type"
      expr: payment_method_type
    - name: "Processor Reference Code"
      expr: processor_reference_code
    - name: "Reversal Flag"
      expr: reversal_flag
    - name: "Reversal Reason Code"
      expr: reversal_reason_code
    - name: "Source System"
      expr: source_system
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gift Card Transaction"
      expr: COUNT(DISTINCT gift_card_transaction_id)
    - name: "Total Activation Fee Amount"
      expr: SUM(activation_fee_amount)
    - name: "Average Activation Fee Amount"
      expr: AVG(activation_fee_amount)
    - name: "Total Balance After"
      expr: SUM(balance_after)
    - name: "Average Balance After"
      expr: AVG(balance_after)
    - name: "Total Balance Before"
      expr: SUM(balance_before)
    - name: "Average Balance Before"
      expr: AVG(balance_before)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Transaction Amount"
      expr: SUM(transaction_amount)
    - name: "Average Transaction Amount"
      expr: AVG(transaction_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Header business metrics"
  source: "`retail_ecm`.`order`.`header`"
  dimensions:
    - name: "Actual Delivery Date"
      expr: actual_delivery_date
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Email"
      expr: customer_email
    - name: "Customer Phone"
      expr: customer_phone
    - name: "Locale"
      expr: locale
    - name: "Oms Reference Code"
      expr: oms_reference_code
    - name: "Order Date"
      expr: order_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Header"
      expr: COUNT(DISTINCT header_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Grand Total Amount"
      expr: SUM(grand_total_amount)
    - name: "Average Grand Total Amount"
      expr: AVG(grand_total_amount)
    - name: "Total Shipping Amount"
      expr: SUM(shipping_amount)
    - name: "Average Shipping Amount"
      expr: AVG(shipping_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hold business metrics"
  source: "`retail_ecm`.`order`.`hold`"
  dimensions:
    - name: "Address Verification Status"
      expr: address_verification_status
    - name: "Assigned To Team Code"
      expr: assigned_to_team_code
    - name: "Auto Release Eligible Flag"
      expr: auto_release_eligible_flag
    - name: "Auto Release Timestamp"
      expr: auto_release_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Channel"
      expr: customer_notification_channel
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "End Timestamp"
      expr: end_timestamp
    - name: "Expected Resolution Timestamp"
      expr: expected_resolution_timestamp
    - name: "Fraud Decision"
      expr: fraud_decision
    - name: "Hold Number"
      expr: hold_number
    - name: "Hold Status"
      expr: hold_status
    - name: "Hold Type"
      expr: hold_type
    - name: "Manual Review Required Flag"
      expr: manual_review_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hold"
      expr: COUNT(DISTINCT hold_id)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_line_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line Status History business metrics"
  source: "`retail_ecm`.`order`.`line_status_history`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Current Status"
      expr: current_status
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Exception Category"
      expr: exception_category
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Fulfillment Node Type"
      expr: fulfillment_node_type
    - name: "Line Sequence Number"
      expr: line_sequence_number
    - name: "Notes"
      expr: notes
    - name: "Previous Status"
      expr: previous_status
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Sku"
      expr: sku
    - name: "Sla Met Flag"
      expr: sla_met_flag
    - name: "Sla Target Timestamp"
      expr: sla_target_timestamp
    - name: "Status Reason Code"
      expr: status_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Line Status History"
      expr: COUNT(DISTINCT line_status_history_id)
    - name: "Total Quantity Affected"
      expr: SUM(quantity_affected)
    - name: "Average Quantity Affected"
      expr: AVG(quantity_affected)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Order Line business metrics"
  source: "`retail_ecm`.`order`.`order_line`"
  dimensions:
    - name: "Actual Ship Date"
      expr: actual_ship_date
    - name: "Backorder Flag"
      expr: backorder_flag
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Expected Ship Date"
      expr: expected_ship_date
    - name: "Fulfillment Method"
      expr: fulfillment_method
    - name: "Gift Flag"
      expr: gift_flag
    - name: "Gift Message"
      expr: gift_message
    - name: "Gtin"
      expr: gtin
    - name: "Line Number"
      expr: line_number
    - name: "Line Status"
      expr: line_status
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Original Sku"
      expr: original_sku
    - name: "Personalization Notes"
      expr: personalization_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Order Line"
      expr: COUNT(DISTINCT order_line_id)
    - name: "Total Cancelled Quantity"
      expr: SUM(cancelled_quantity)
    - name: "Average Cancelled Quantity"
      expr: AVG(cancelled_quantity)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Extended Price"
      expr: SUM(extended_price)
    - name: "Average Extended Price"
      expr: AVG(extended_price)
    - name: "Total Margin Amount"
      expr: SUM(margin_amount)
    - name: "Average Margin Amount"
      expr: AVG(margin_amount)
    - name: "Total Ordered Quantity"
      expr: SUM(ordered_quantity)
    - name: "Average Ordered Quantity"
      expr: AVG(ordered_quantity)
    - name: "Total Returned Quantity"
      expr: SUM(returned_quantity)
    - name: "Average Returned Quantity"
      expr: AVG(returned_quantity)
    - name: "Total Shipped Quantity"
      expr: SUM(shipped_quantity)
    - name: "Average Shipped Quantity"
      expr: AVG(shipped_quantity)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total"
      expr: SUM(total)
    - name: "Average Total"
      expr: AVG(total)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`retail_ecm`.`order`.`payment`"
  dimensions:
    - name: "Authorization Code"
      expr: authorization_code
    - name: "Authorization Timestamp"
      expr: authorization_timestamp
    - name: "Avs Result Code"
      expr: avs_result_code
    - name: "Billing Address Line1"
      expr: billing_address_line1
    - name: "Billing Address Line2"
      expr: billing_address_line2
    - name: "Billing City"
      expr: billing_city
    - name: "Billing Country Code"
      expr: billing_country_code
    - name: "Billing Postal Code"
      expr: billing_postal_code
    - name: "Billing State Province"
      expr: billing_state_province
    - name: "Bnpl Provider"
      expr: bnpl_provider
    - name: "Capture Timestamp"
      expr: capture_timestamp
    - name: "Card Brand"
      expr: card_brand
    - name: "Card Expiry Month"
      expr: card_expiry_month
    - name: "Card Expiry Year"
      expr: card_expiry_year
    - name: "Cardholder Name"
      expr: cardholder_name
    - name: "Channel"
      expr: channel
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Fraud Score"
      expr: SUM(fraud_score)
    - name: "Average Fraud Score"
      expr: AVG(fraud_score)
    - name: "Total Refund Amount"
      expr: SUM(refund_amount)
    - name: "Average Refund Amount"
      expr: AVG(refund_amount)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Transaction business metrics"
  source: "`retail_ecm`.`order`.`pos_transaction`"
  dimensions:
    - name: "Business Date"
      expr: business_date
    - name: "Coupon Count"
      expr: coupon_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Fiscal Receipt Number"
      expr: fiscal_receipt_number
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "Item Count"
      expr: item_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Loyalty Card Number"
      expr: loyalty_card_number
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Manager Override Flag"
      expr: manager_override_flag
    - name: "Payment Method Count"
      expr: payment_method_count
    - name: "Primary Payment Method"
      expr: primary_payment_method
    - name: "Promotion Count"
      expr: promotion_count
    - name: "Receipt Email"
      expr: receipt_email
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Transaction"
      expr: COUNT(DISTINCT pos_transaction_id)
    - name: "Total Change Amount"
      expr: SUM(change_amount)
    - name: "Average Change Amount"
      expr: AVG(change_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Subtotal Amount"
      expr: SUM(subtotal_amount)
    - name: "Average Subtotal Amount"
      expr: AVG(subtotal_amount)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tender Amount"
      expr: SUM(tender_amount)
    - name: "Average Tender Amount"
      expr: AVG(tender_amount)
    - name: "Total Total Amount"
      expr: SUM(total_amount)
    - name: "Average Total Amount"
      expr: AVG(total_amount)
    - name: "Total Total Quantity"
      expr: SUM(total_quantity)
    - name: "Average Total Quantity"
      expr: AVG(total_quantity)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Transaction Line business metrics"
  source: "`retail_ecm`.`order`.`pos_transaction_line`"
  dimensions:
    - name: "Category Code"
      expr: category_code
    - name: "Coupon Code"
      expr: coupon_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Department Code"
      expr: department_code
    - name: "Ean"
      expr: ean
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "Gtin"
      expr: gtin
    - name: "Item Description"
      expr: item_description
    - name: "Line Number"
      expr: line_number
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "Private Label Flag"
      expr: private_label_flag
    - name: "Promotion Code"
      expr: promotion_code
    - name: "Return Flag"
      expr: return_flag
    - name: "Return Reason Code"
      expr: return_reason_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Transaction Line"
      expr: COUNT(DISTINCT pos_transaction_line_id)
    - name: "Total Cost Of Goods Sold"
      expr: SUM(cost_of_goods_sold)
    - name: "Average Cost Of Goods Sold"
      expr: AVG(cost_of_goods_sold)
    - name: "Total Extended Price"
      expr: SUM(extended_price)
    - name: "Average Extended Price"
      expr: AVG(extended_price)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Net Line Amount"
      expr: SUM(net_line_amount)
    - name: "Average Net Line Amount"
      expr: AVG(net_line_amount)
    - name: "Total Quantity Sold"
      expr: SUM(quantity_sold)
    - name: "Average Quantity Sold"
      expr: AVG(quantity_sold)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Tax Rate"
      expr: SUM(tax_rate)
    - name: "Average Tax Rate"
      expr: AVG(tax_rate)
    - name: "Total Total Line Amount"
      expr: SUM(total_line_amount)
    - name: "Average Total Line Amount"
      expr: AVG(total_line_amount)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
    - name: "Total Weight Actual"
      expr: SUM(weight_actual)
    - name: "Average Weight Actual"
      expr: AVG(weight_actual)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_promise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Promise business metrics"
  source: "`retail_ecm`.`order`.`promise`"
  dimensions:
    - name: "Accuracy Flag"
      expr: accuracy_flag
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Calculation Engine Version"
      expr: calculation_engine_version
    - name: "Calculation Source"
      expr: calculation_source
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Channel"
      expr: customer_notification_channel
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Customer Notification Timestamp"
      expr: customer_notification_timestamp
    - name: "Cutoff Time Applied"
      expr: cutoff_time_applied
    - name: "Fulfillment Method"
      expr: fulfillment_method
    - name: "Inventory Availability Timestamp"
      expr: inventory_availability_timestamp
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Revision Timestamp"
      expr: last_revision_timestamp
    - name: "Order Channel"
      expr: order_channel
    - name: "Peak Season Flag"
      expr: peak_season_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Promise"
      expr: COUNT(DISTINCT promise_id)
    - name: "Total Confidence Score"
      expr: SUM(confidence_score)
    - name: "Average Confidence Score"
      expr: AVG(confidence_score)
    - name: "Total Variance Hours"
      expr: SUM(variance_hours)
    - name: "Average Variance Hours"
      expr: AVG(variance_hours)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Status History business metrics"
  source: "`retail_ecm`.`order`.`status_history`"
  dimensions:
    - name: "Actual Delivery Timestamp"
      expr: actual_delivery_timestamp
    - name: "Assigned To Team Code"
      expr: assigned_to_team_code
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created By Process"
      expr: created_by_process
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Notification Channel"
      expr: customer_notification_channel
    - name: "Customer Notification Sent Flag"
      expr: customer_notification_sent_flag
    - name: "Duration In Previous Status Minutes"
      expr: duration_in_previous_status_minutes
    - name: "Estimated Delivery Date"
      expr: estimated_delivery_date
    - name: "Event Sequence Number"
      expr: event_sequence_number
    - name: "Exception Category"
      expr: exception_category
    - name: "Exception Flag"
      expr: exception_flag
    - name: "Fulfillment Node Type"
      expr: fulfillment_node_type
    - name: "Notes"
      expr: notes
    - name: "Order Type"
      expr: order_type
    - name: "Previous Status Code"
      expr: previous_status_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Status History"
      expr: COUNT(DISTINCT status_history_id)
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`order_subscription`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Subscription business metrics"
  source: "`retail_ecm`.`order`.`subscription`"
  dimensions:
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Billing Cycle"
      expr: billing_cycle
    - name: "Cancellation Date"
      expr: cancellation_date
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Cancellation Reason Description"
      expr: cancellation_reason_description
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Channel"
      expr: channel
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Frequency"
      expr: delivery_frequency
    - name: "Delivery Frequency Days"
      expr: delivery_frequency_days
    - name: "End Date"
      expr: end_date
    - name: "External Subscription Code"
      expr: external_subscription_code
    - name: "Gift Message"
      expr: gift_message
    - name: "Gift Subscription Flag"
      expr: gift_subscription_flag
    - name: "Last Delivery Date"
      expr: last_delivery_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Subscription"
      expr: COUNT(DISTINCT subscription_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
$$;