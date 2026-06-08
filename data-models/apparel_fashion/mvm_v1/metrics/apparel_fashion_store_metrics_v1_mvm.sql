-- Metric views for domain: store | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:07:08

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_associate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Associate business metrics"
  source: "`apparel_fashion_ecm`.`store`.`associate`"
  dimensions:
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Associate Number"
      expr: associate_number
    - name: "Bopis Fulfillment Enabled"
      expr: bopis_fulfillment_enabled
    - name: "Commission Eligible"
      expr: commission_eligible
    - name: "Commission Plan Code"
      expr: commission_plan_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Employment Type"
      expr: employment_type
    - name: "First Name"
      expr: first_name
    - name: "Hire Date"
      expr: hire_date
    - name: "Keyholder Flag"
      expr: keyholder_flag
    - name: "Language Code"
      expr: language_code
    - name: "Last Name"
      expr: last_name
    - name: "Last Performance Review Date"
      expr: last_performance_review_date
    - name: "Loss Prevention Flag"
      expr: loss_prevention_flag
    - name: "Performance Rating"
      expr: performance_rating
    - name: "Pos Login Enabled"
      expr: pos_login_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Associate"
      expr: COUNT(DISTINCT associate_id)
    - name: "Total Commission Rate"
      expr: SUM(commission_rate)
    - name: "Average Commission Rate"
      expr: AVG(commission_rate)
    - name: "Total Nps Score Avg"
      expr: SUM(nps_score_avg)
    - name: "Average Nps Score Avg"
      expr: AVG(nps_score_avg)
    - name: "Total Scheduled Hours Per Week"
      expr: SUM(scheduled_hours_per_week)
    - name: "Average Scheduled Hours Per Week"
      expr: AVG(scheduled_hours_per_week)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_bopis_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bopis Order business metrics"
  source: "`apparel_fashion_ecm`.`store`.`bopis_order`"
  dimensions:
    - name: "Assigned Timestamp"
      expr: assigned_timestamp
    - name: "Cancellation Notes"
      expr: cancellation_notes
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Cancelled Timestamp"
      expr: cancelled_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Curbside Flag"
      expr: curbside_flag
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Notified Timestamp"
      expr: customer_notified_timestamp
    - name: "Expiry Timestamp"
      expr: expiry_timestamp
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Item Count"
      expr: item_count
    - name: "Notification Method"
      expr: notification_method
    - name: "Order Number"
      expr: order_number
    - name: "Order Placed Timestamp"
      expr: order_placed_timestamp
    - name: "Pick Complete Timestamp"
      expr: pick_complete_timestamp
    - name: "Pick Start Timestamp"
      expr: pick_start_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bopis Order"
      expr: COUNT(DISTINCT bopis_order_id)
    - name: "Total Order Total Amount"
      expr: SUM(order_total_amount)
    - name: "Average Order Total Amount"
      expr: AVG(order_total_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_cluster`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cluster business metrics"
  source: "`apparel_fashion_ecm`.`store`.`cluster`"
  dimensions:
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Cluster Code"
      expr: cluster_code
    - name: "Cluster Description"
      expr: cluster_description
    - name: "Cluster Name"
      expr: cluster_name
    - name: "Cluster Status"
      expr: cluster_status
    - name: "Cluster Tier"
      expr: cluster_tier
    - name: "Cluster Type"
      expr: cluster_type
    - name: "Competitive Intensity"
      expr: competitive_intensity
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Geographic Region"
      expr: geographic_region
    - name: "Is Flagship Cluster"
      expr: is_flagship_cluster
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Manager Email"
      expr: manager_email
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Cluster"
      expr: COUNT(DISTINCT cluster_id)
    - name: "Total Average Store Size Sqft"
      expr: SUM(average_store_size_sqft)
    - name: "Average Average Store Size Sqft"
      expr: AVG(average_store_size_sqft)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_daily_sales_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily Sales Summary business metrics"
  source: "`apparel_fashion_ecm`.`store`.`daily_sales_summary`"
  dimensions:
    - name: "Adjustment Reason"
      expr: adjustment_reason
    - name: "Bopis Order Count"
      expr: bopis_order_count
    - name: "Business Date"
      expr: business_date
    - name: "Closing Inventory Units"
      expr: closing_inventory_units
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Traffic Count"
      expr: customer_traffic_count
    - name: "Is Adjusted"
      expr: is_adjusted
    - name: "Is Reconciled"
      expr: is_reconciled
    - name: "Opening Inventory Units"
      expr: opening_inventory_units
    - name: "Pos Close Timestamp"
      expr: pos_close_timestamp
    - name: "Reconciliation Timestamp"
      expr: reconciliation_timestamp
    - name: "Return Transaction Count"
      expr: return_transaction_count
    - name: "Ship From Store Order Count"
      expr: ship_from_store_order_count
    - name: "Source System Code"
      expr: source_system_code
    - name: "Store Number"
      expr: store_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Daily Sales Summary"
      expr: COUNT(DISTINCT daily_sales_summary_id)
    - name: "Total Asp"
      expr: SUM(asp)
    - name: "Average Asp"
      expr: AVG(asp)
    - name: "Total Aur"
      expr: SUM(aur)
    - name: "Average Aur"
      expr: AVG(aur)
    - name: "Total Card Tender Amount"
      expr: SUM(card_tender_amount)
    - name: "Average Card Tender Amount"
      expr: AVG(card_tender_amount)
    - name: "Total Cash Tender Amount"
      expr: SUM(cash_tender_amount)
    - name: "Average Cash Tender Amount"
      expr: AVG(cash_tender_amount)
    - name: "Total Conversion Rate"
      expr: SUM(conversion_rate)
    - name: "Average Conversion Rate"
      expr: AVG(conversion_rate)
    - name: "Total Digital Tender Amount"
      expr: SUM(digital_tender_amount)
    - name: "Average Digital Tender Amount"
      expr: AVG(digital_tender_amount)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
    - name: "Total Gift Card Tender Amount"
      expr: SUM(gift_card_tender_amount)
    - name: "Average Gift Card Tender Amount"
      expr: AVG(gift_card_tender_amount)
    - name: "Total Gross Sales Amount"
      expr: SUM(gross_sales_amount)
    - name: "Average Gross Sales Amount"
      expr: AVG(gross_sales_amount)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Net Sales Amount"
      expr: SUM(net_sales_amount)
    - name: "Average Net Sales Amount"
      expr: AVG(net_sales_amount)
    - name: "Total Returns Amount"
      expr: SUM(returns_amount)
    - name: "Average Returns Amount"
      expr: AVG(returns_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_district`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District business metrics"
  source: "`apparel_fashion_ecm`.`store`.`district`"
  dimensions:
    - name: "Bopis Enabled"
      expr: bopis_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "District Code"
      expr: district_code
    - name: "District Name"
      expr: district_name
    - name: "District Status"
      expr: district_status
    - name: "District Type"
      expr: district_type
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Headquarters Address Line 1"
      expr: headquarters_address_line_1
    - name: "Headquarters Address Line 2"
      expr: headquarters_address_line_2
    - name: "Headquarters City"
      expr: headquarters_city
    - name: "Headquarters Country Code"
      expr: headquarters_country_code
    - name: "Headquarters Email Address"
      expr: headquarters_email_address
    - name: "Headquarters Phone Number"
      expr: headquarters_phone_number
    - name: "Headquarters Postal Code"
      expr: headquarters_postal_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct District"
      expr: COUNT(DISTINCT district_id)
    - name: "Total Annual Sales Target"
      expr: SUM(annual_sales_target)
    - name: "Average Annual Sales Target"
      expr: AVG(annual_sales_target)
    - name: "Total Annual Traffic Target"
      expr: SUM(annual_traffic_target)
    - name: "Average Annual Traffic Target"
      expr: AVG(annual_traffic_target)
    - name: "Total Comp Store Sales Target Percent"
      expr: SUM(comp_store_sales_target_percent)
    - name: "Average Comp Store Sales Target Percent"
      expr: AVG(comp_store_sales_target_percent)
    - name: "Total Shrinkage Target Percent"
      expr: SUM(shrinkage_target_percent)
    - name: "Average Shrinkage Target Percent"
      expr: AVG(shrinkage_target_percent)
    - name: "Total Total Selling Square Footage"
      expr: SUM(total_selling_square_footage)
    - name: "Average Total Selling Square Footage"
      expr: AVG(total_selling_square_footage)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_markdown_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Markdown Event business metrics"
  source: "`apparel_fashion_ecm`.`store`.`markdown_event`"
  dimensions:
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authorization Reference"
      expr: authorization_reference
    - name: "Channel Applicability"
      expr: channel_applicability
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Effective Date"
      expr: effective_date
    - name: "End Date"
      expr: end_date
    - name: "Event Status"
      expr: event_status
    - name: "Markdown Event Number"
      expr: markdown_event_number
    - name: "Markdown Level"
      expr: markdown_level
    - name: "Markdown Reason Code"
      expr: markdown_reason_code
    - name: "Markdown Type"
      expr: markdown_type
    - name: "Notes"
      expr: notes
    - name: "On Hand Qty"
      expr: on_hand_qty
    - name: "Pos Applied Flag"
      expr: pos_applied_flag
    - name: "Price Label Required Flag"
      expr: price_label_required_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Markdown Event"
      expr: COUNT(DISTINCT markdown_event_id)
    - name: "Total Cost Price"
      expr: SUM(cost_price)
    - name: "Average Cost Price"
      expr: AVG(cost_price)
    - name: "Total Initial Markup Pct"
      expr: SUM(initial_markup_pct)
    - name: "Average Initial Markup Pct"
      expr: AVG(initial_markup_pct)
    - name: "Total Maintained Markup Pct"
      expr: SUM(maintained_markup_pct)
    - name: "Average Maintained Markup Pct"
      expr: AVG(maintained_markup_pct)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Markdown Pct"
      expr: SUM(markdown_pct)
    - name: "Average Markdown Pct"
      expr: AVG(markdown_pct)
    - name: "Total Markdown Price"
      expr: SUM(markdown_price)
    - name: "Average Markdown Price"
      expr: AVG(markdown_price)
    - name: "Total Msrp Price"
      expr: SUM(msrp_price)
    - name: "Average Msrp Price"
      expr: AVG(msrp_price)
    - name: "Total Original Retail Price"
      expr: SUM(original_retail_price)
    - name: "Average Original Retail Price"
      expr: AVG(original_retail_price)
    - name: "Total Sell Through Rate"
      expr: SUM(sell_through_rate)
    - name: "Average Sell Through Rate"
      expr: AVG(sell_through_rate)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_planogram`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Planogram business metrics"
  source: "`apparel_fashion_ecm`.`store`.`planogram`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Color Story"
      expr: color_story
    - name: "Compliance Required"
      expr: compliance_required
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Digital Integration Enabled"
      expr: digital_integration_enabled
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixture Count"
      expr: fixture_count
    - name: "Fixture Type"
      expr: fixture_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Merchandising Zone"
      expr: merchandising_zone
    - name: "Notes"
      expr: notes
    - name: "Omnichannel Enabled"
      expr: omnichannel_enabled
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Planogram"
      expr: COUNT(DISTINCT planogram_id)
    - name: "Total Average Unit Retail Usd"
      expr: SUM(average_unit_retail_usd)
    - name: "Average Average Unit Retail Usd"
      expr: AVG(average_unit_retail_usd)
    - name: "Total Floor Space Sqm"
      expr: SUM(floor_space_sqm)
    - name: "Average Floor Space Sqm"
      expr: AVG(floor_space_sqm)
    - name: "Total Height Cm"
      expr: SUM(height_cm)
    - name: "Average Height Cm"
      expr: AVG(height_cm)
    - name: "Total Implementation Duration Hours"
      expr: SUM(implementation_duration_hours)
    - name: "Average Implementation Duration Hours"
      expr: AVG(implementation_duration_hours)
    - name: "Total Projected Sales Per Sqm Usd"
      expr: SUM(projected_sales_per_sqm_usd)
    - name: "Average Projected Sales Per Sqm Usd"
      expr: AVG(projected_sales_per_sqm_usd)
    - name: "Total Wall Space Linear M"
      expr: SUM(wall_space_linear_m)
    - name: "Average Wall Space Linear M"
      expr: AVG(wall_space_linear_m)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_pos_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Transaction business metrics"
  source: "`apparel_fashion_ecm`.`store`.`pos_transaction`"
  dimensions:
    - name: "Business Date"
      expr: business_date
    - name: "Channel Type"
      expr: channel_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Item Count"
      expr: item_count
    - name: "Line Count"
      expr: line_count
    - name: "Loyalty Points Earned"
      expr: loyalty_points_earned
    - name: "Loyalty Points Redeemed"
      expr: loyalty_points_redeemed
    - name: "Manager Override Flag"
      expr: manager_override_flag
    - name: "Price Override Flag"
      expr: price_override_flag
    - name: "Receipt Delivery Method"
      expr: receipt_delivery_method
    - name: "Receipt Number"
      expr: receipt_number
    - name: "Return Reason Code"
      expr: return_reason_code
    - name: "Rfid Verified Flag"
      expr: rfid_verified_flag
    - name: "Tax Jurisdiction Code"
      expr: tax_jurisdiction_code
    - name: "Training Mode Flag"
      expr: training_mode_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Transaction"
      expr: COUNT(DISTINCT pos_transaction_id)
    - name: "Total Discount Amount"
      expr: SUM(discount_amount)
    - name: "Average Discount Amount"
      expr: AVG(discount_amount)
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
    - name: "Total Tender Cash Amount"
      expr: SUM(tender_cash_amount)
    - name: "Average Tender Cash Amount"
      expr: AVG(tender_cash_amount)
    - name: "Total Tender Credit Amount"
      expr: SUM(tender_credit_amount)
    - name: "Average Tender Credit Amount"
      expr: AVG(tender_credit_amount)
    - name: "Total Tender Debit Amount"
      expr: SUM(tender_debit_amount)
    - name: "Average Tender Debit Amount"
      expr: AVG(tender_debit_amount)
    - name: "Total Tender Gift Card Amount"
      expr: SUM(tender_gift_card_amount)
    - name: "Average Tender Gift Card Amount"
      expr: AVG(tender_gift_card_amount)
    - name: "Total Tender Mobile Wallet Amount"
      expr: SUM(tender_mobile_wallet_amount)
    - name: "Average Tender Mobile Wallet Amount"
      expr: AVG(tender_mobile_wallet_amount)
    - name: "Total Tender Store Credit Amount"
      expr: SUM(tender_store_credit_amount)
    - name: "Average Tender Store Credit Amount"
      expr: AVG(tender_store_credit_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_pos_transaction_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pos Transaction Line business metrics"
  source: "`apparel_fashion_ecm`.`store`.`pos_transaction_line`"
  dimensions:
    - name: "Class Code"
      expr: class_code
    - name: "Currency Code"
      expr: currency_code
    - name: "Department Code"
      expr: department_code
    - name: "Discount Reason Code"
      expr: discount_reason_code
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "Ingestion Timestamp"
      expr: ingestion_timestamp
    - name: "Is Clearance Item"
      expr: is_clearance_item
    - name: "Is Markdown Item"
      expr: is_markdown_item
    - name: "Is Rfid Scanned"
      expr: is_rfid_scanned
    - name: "Line Number"
      expr: line_number
    - name: "Line Type"
      expr: line_type
    - name: "Quantity Sold"
      expr: quantity_sold
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Register Code"
      expr: register_code
    - name: "Return Reason Code"
      expr: return_reason_code
    - name: "Size Code"
      expr: size_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pos Transaction Line"
      expr: COUNT(DISTINCT pos_transaction_line_id)
    - name: "Total Cogs"
      expr: SUM(cogs)
    - name: "Average Cogs"
      expr: AVG(cogs)
    - name: "Total Imu Pct"
      expr: SUM(imu_pct)
    - name: "Average Imu Pct"
      expr: AVG(imu_pct)
    - name: "Total Line Discount Amount"
      expr: SUM(line_discount_amount)
    - name: "Average Line Discount Amount"
      expr: AVG(line_discount_amount)
    - name: "Total Line Extended Amount"
      expr: SUM(line_extended_amount)
    - name: "Average Line Extended Amount"
      expr: AVG(line_extended_amount)
    - name: "Total Markdown Amount"
      expr: SUM(markdown_amount)
    - name: "Average Markdown Amount"
      expr: AVG(markdown_amount)
    - name: "Total Mmu Pct"
      expr: SUM(mmu_pct)
    - name: "Average Mmu Pct"
      expr: AVG(mmu_pct)
    - name: "Total Msrp"
      expr: SUM(msrp)
    - name: "Average Msrp"
      expr: AVG(msrp)
    - name: "Total Original Retail Price"
      expr: SUM(original_retail_price)
    - name: "Average Original Retail Price"
      expr: AVG(original_retail_price)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Register business metrics"
  source: "`apparel_fashion_ecm`.`store`.`register`"
  dimensions:
    - name: "Activation Date"
      expr: activation_date
    - name: "Barcode Scanner Enabled"
      expr: barcode_scanner_enabled
    - name: "Card Reader Enabled"
      expr: card_reader_enabled
    - name: "Cash Drawer Enabled"
      expr: cash_drawer_enabled
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Deactivation Date"
      expr: deactivation_date
    - name: "Firmware Version"
      expr: firmware_version
    - name: "Floor Level"
      expr: floor_level
    - name: "Installation Date"
      expr: installation_date
    - name: "Ip Address"
      expr: ip_address
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Location Zone"
      expr: location_zone
    - name: "Mac Address"
      expr: mac_address
    - name: "Manufacturer"
      expr: manufacturer
    - name: "Model Number"
      expr: model_number
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Register"
      expr: COUNT(DISTINCT register_id)
    - name: "Total Max Transaction Amount"
      expr: SUM(max_transaction_amount)
    - name: "Average Max Transaction Amount"
      expr: AVG(max_transaction_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_retail_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Retail Store business metrics"
  source: "`apparel_fashion_ecm`.`store`.`retail_store`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "City"
      expr: city
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Email Address"
      expr: email_address
    - name: "Fitting Room Count"
      expr: fitting_room_count
    - name: "Headcount Capacity"
      expr: headcount_capacity
    - name: "Is Bopis Enabled"
      expr: is_bopis_enabled
    - name: "Is Rfid Enabled"
      expr: is_rfid_enabled
    - name: "Is Ship From Store Enabled"
      expr: is_ship_from_store_enabled
    - name: "Lease Expiry Date"
      expr: lease_expiry_date
    - name: "Lease Start Date"
      expr: lease_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Retail Store"
      expr: COUNT(DISTINCT retail_store_id)
    - name: "Total Annual Base Rent"
      expr: SUM(annual_base_rent)
    - name: "Average Annual Base Rent"
      expr: AVG(annual_base_rent)
    - name: "Total Gross Selling Sqft"
      expr: SUM(gross_selling_sqft)
    - name: "Average Gross Selling Sqft"
      expr: AVG(gross_selling_sqft)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Net Selling Sqft"
      expr: SUM(net_selling_sqft)
    - name: "Average Net Selling Sqft"
      expr: AVG(net_selling_sqft)
    - name: "Total Stockroom Sqft"
      expr: SUM(stockroom_sqft)
    - name: "Average Stockroom Sqft"
      expr: AVG(stockroom_sqft)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_return_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return Transaction business metrics"
  source: "`apparel_fashion_ecm`.`store`.`return_transaction`"
  dimensions:
    - name: "Business Date"
      expr: business_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Days Since Purchase"
      expr: days_since_purchase
    - name: "Disposition Code"
      expr: disposition_code
    - name: "Item Condition Code"
      expr: item_condition_code
    - name: "Loss Prevention Flag"
      expr: loss_prevention_flag
    - name: "Loyalty Points Reversed"
      expr: loyalty_points_reversed
    - name: "Manager Override Flag"
      expr: manager_override_flag
    - name: "Original Order Channel"
      expr: original_order_channel
    - name: "Original Purchase Date"
      expr: original_purchase_date
    - name: "Original Tender Type"
      expr: original_tender_type
    - name: "Quantity Returned"
      expr: quantity_returned
    - name: "Receipt Number"
      expr: receipt_number
    - name: "Receipt Presented Flag"
      expr: receipt_presented_flag
    - name: "Refund Method"
      expr: refund_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Return Transaction"
      expr: COUNT(DISTINCT return_transaction_id)
    - name: "Total Register Code"
      expr: SUM(register_code)
    - name: "Average Register Code"
      expr: AVG(register_code)
    - name: "Total Return Discount Amount"
      expr: SUM(return_discount_amount)
    - name: "Average Return Discount Amount"
      expr: AVG(return_discount_amount)
    - name: "Total Return Gross Amount"
      expr: SUM(return_gross_amount)
    - name: "Average Return Gross Amount"
      expr: AVG(return_gross_amount)
    - name: "Total Return Net Amount"
      expr: SUM(return_net_amount)
    - name: "Average Return Net Amount"
      expr: AVG(return_net_amount)
    - name: "Total Return Tax Amount"
      expr: SUM(return_tax_amount)
    - name: "Average Return Tax Amount"
      expr: AVG(return_tax_amount)
    - name: "Total Unit Retail Price"
      expr: SUM(unit_retail_price)
    - name: "Average Unit Retail Price"
      expr: AVG(unit_retail_price)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_ship_from_store`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ship From Store business metrics"
  source: "`apparel_fashion_ecm`.`store`.`ship_from_store`"
  dimensions:
    - name: "Business Date"
      expr: business_date
    - name: "Cancellation Reason Code"
      expr: cancellation_reason_code
    - name: "Carrier Service Level"
      expr: carrier_service_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Exception Code"
      expr: exception_code
    - name: "Fulfillment Request Number"
      expr: fulfillment_request_number
    - name: "Fulfillment Status"
      expr: fulfillment_status
    - name: "Fulfillment Type"
      expr: fulfillment_type
    - name: "In Full Flag"
      expr: in_full_flag
    - name: "Notes"
      expr: notes
    - name: "On Time Flag"
      expr: on_time_flag
    - name: "Ordered Quantity"
      expr: ordered_quantity
    - name: "Otif Flag"
      expr: otif_flag
    - name: "Pack Timestamp"
      expr: pack_timestamp
    - name: "Partial Fulfillment Flag"
      expr: partial_fulfillment_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ship From Store"
      expr: COUNT(DISTINCT ship_from_store_id)
    - name: "Total Package Weight Kg"
      expr: SUM(package_weight_kg)
    - name: "Average Package Weight Kg"
      expr: AVG(package_weight_kg)
    - name: "Total Retail Value Amount"
      expr: SUM(retail_value_amount)
    - name: "Average Retail Value Amount"
      expr: AVG(retail_value_amount)
    - name: "Total Shipping Cost Amount"
      expr: SUM(shipping_cost_amount)
    - name: "Average Shipping Cost Amount"
      expr: AVG(shipping_cost_amount)
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`store_visual_merchandising_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visual Merchandising Plan business metrics"
  source: "`apparel_fashion_ecm`.`store`.`visual_merchandising_plan`"
  dimensions:
    - name: "Approved By"
      expr: approved_by
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Audit Date"
      expr: audit_date
    - name: "Audit Status"
      expr: audit_status
    - name: "Collection Display Guidelines"
      expr: collection_display_guidelines
    - name: "Color Blocking Direction"
      expr: color_blocking_direction
    - name: "Compliance Deadline"
      expr: compliance_deadline
    - name: "Corrective Action Deadline"
      expr: corrective_action_deadline
    - name: "Corrective Action Notes"
      expr: corrective_action_notes
    - name: "Corrective Action Required"
      expr: corrective_action_required
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Fixture Layout Code"
      expr: fixture_layout_code
    - name: "Mannequin Count"
      expr: mannequin_count
    - name: "Mannequin Styling Notes"
      expr: mannequin_styling_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Visual Merchandising Plan"
      expr: COUNT(DISTINCT visual_merchandising_plan_id)
    - name: "Total Audit Score"
      expr: SUM(audit_score)
    - name: "Average Audit Score"
      expr: AVG(audit_score)
$$;