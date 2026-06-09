-- Metric views for domain: returns | Business: Retail | Version: 1 | Generated on: 2026-05-04 11:04:04

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_rma`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core return merchandise authorization (RMA) metrics tracking return volume, value, fraud risk, and processing efficiency across channels and return types"
  source: "`retail_ecm`.`returns`.`rma`"
  dimensions:
    - name: "rma_status"
      expr: rma_status
      comment: "Current status of the RMA (e.g., pending, approved, closed)"
    - name: "return_channel"
      expr: return_channel
      comment: "Channel through which the return was initiated (e.g., online, in-store, call center)"
    - name: "return_type"
      expr: return_type
      comment: "Type of return (e.g., refund, exchange, store credit)"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Standardized code indicating reason for return"
    - name: "return_method"
      expr: return_method
      comment: "Method used to return the item (e.g., mail, drop-off, pickup)"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue refund (e.g., original payment, store credit, gift card)"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Final disposition decision for returned merchandise"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to the RMA for processing"
    - name: "is_fraudulent_flag"
      expr: is_fraudulent
      comment: "Flag indicating whether the return was identified as fraudulent"
    - name: "authorization_year_month"
      expr: DATE_TRUNC('month', authorization_date)
      comment: "Month when RMA was authorized, for time-series analysis"
    - name: "closed_year_month"
      expr: DATE_TRUNC('month', closed_date)
      comment: "Month when RMA was closed, for completion tracking"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Status of merchandise inspection process"
  measures:
    - name: "total_rmas"
      expr: COUNT(1)
      comment: "Total number of return merchandise authorizations"
    - name: "total_expected_return_value"
      expr: SUM(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Total expected value of all returns in the period"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all RMAs"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected from returns"
    - name: "total_return_shipping_cost"
      expr: SUM(CAST(return_shipping_cost AS DOUBLE))
      comment: "Total cost of return shipping across all RMAs"
    - name: "total_store_credit_issued"
      expr: SUM(CAST(store_credit_issued_amount AS DOUBLE))
      comment: "Total store credit issued in lieu of refunds"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across all RMAs"
    - name: "avg_expected_return_value"
      expr: AVG(CAST(expected_return_value_amount AS DOUBLE))
      comment: "Average expected value per return"
    - name: "avg_refund_amount"
      expr: AVG(CAST(refund_amount AS DOUBLE))
      comment: "Average refund amount per RMA"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers with returns in the period"
    - name: "distinct_locations"
      expr: COUNT(DISTINCT return_location_id)
      comment: "Number of unique return locations processing RMAs"
    - name: "fraudulent_rma_count"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of RMAs flagged as fraudulent"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_rma_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level return metrics tracking individual SKU returns, costs, recovery values, and restocking eligibility for operational and financial analysis"
  source: "`retail_ecm`.`returns`.`rma_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Status of the individual RMA line item"
    - name: "condition_code"
      expr: condition_code
      comment: "Condition assessment code for returned merchandise"
    - name: "disposition_code"
      expr: disposition_code
      comment: "Disposition decision for the line item"
    - name: "return_reason_code"
      expr: return_reason_code
      comment: "Reason code for the return at line level"
    - name: "restocking_eligible_flag"
      expr: restocking_eligible_flag
      comment: "Flag indicating whether item is eligible for restocking"
    - name: "inspection_year_month"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Month when line item was inspected"
    - name: "sku"
      expr: sku
      comment: "Stock keeping unit identifier for the returned product"
  measures:
    - name: "total_rma_lines"
      expr: COUNT(1)
      comment: "Total number of RMA line items"
    - name: "total_quantity_authorized"
      expr: SUM(CAST(quantity_authorized AS DOUBLE))
      comment: "Total quantity of items authorized for return"
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of items actually received back"
    - name: "total_extended_cost"
      expr: SUM(CAST(extended_cost_amount AS DOUBLE))
      comment: "Total cost value of returned merchandise"
    - name: "total_extended_retail"
      expr: SUM(CAST(extended_retail_amount AS DOUBLE))
      comment: "Total retail value of returned merchandise"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total refund amount at line level"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees collected at line level"
    - name: "total_liquidation_sale_amount"
      expr: SUM(CAST(liquidation_sale_amount AS DOUBLE))
      comment: "Total amount recovered from liquidation sales"
    - name: "total_vendor_credit"
      expr: SUM(CAST(vendor_credit_amount AS DOUBLE))
      comment: "Total vendor credit received for returned items"
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost of returned items"
    - name: "avg_unit_retail_price"
      expr: AVG(CAST(unit_retail_price AS DOUBLE))
      comment: "Average unit retail price of returned items"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs returned"
    - name: "distinct_rmas"
      expr: COUNT(DISTINCT rma_id)
      comment: "Number of unique RMAs represented in line items"
    - name: "restocking_eligible_lines"
      expr: SUM(CASE WHEN restocking_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of line items eligible for restocking"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_refund`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Refund processing metrics tracking refund amounts, methods, settlement timing, fraud detection, and processing efficiency for financial reconciliation and risk management"
  source: "`retail_ecm`.`returns`.`refund`"
  dimensions:
    - name: "refund_status"
      expr: refund_status
      comment: "Current status of the refund (e.g., pending, approved, completed, failed)"
    - name: "refund_type"
      expr: refund_type
      comment: "Type of refund being processed"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used to issue the refund (e.g., original payment, store credit, check)"
    - name: "channel"
      expr: channel
      comment: "Channel through which refund was initiated"
    - name: "reason_code"
      expr: reason_code
      comment: "Reason code for the refund"
    - name: "payment_processor"
      expr: payment_processor
      comment: "Payment processor handling the refund"
    - name: "is_fraudulent_flag"
      expr: is_fraudulent
      comment: "Flag indicating whether refund was identified as fraudulent"
    - name: "initiated_year_month"
      expr: DATE_TRUNC('month', CAST(initiated_timestamp AS DATE))
      comment: "Month when refund was initiated"
    - name: "completed_year_month"
      expr: DATE_TRUNC('month', CAST(completed_timestamp AS DATE))
      comment: "Month when refund was completed"
    - name: "actual_settlement_year_month"
      expr: DATE_TRUNC('month', actual_settlement_date)
      comment: "Month when refund was actually settled"
  measures:
    - name: "total_refunds"
      expr: COUNT(1)
      comment: "Total number of refund transactions"
    - name: "total_refund_amount"
      expr: SUM(CAST(total_refund_amount AS DOUBLE))
      comment: "Total refund amount issued across all transactions"
    - name: "total_merchandise_amount"
      expr: SUM(CAST(merchandise_amount AS DOUBLE))
      comment: "Total merchandise value being refunded"
    - name: "total_shipping_amount"
      expr: SUM(CAST(shipping_amount AS DOUBLE))
      comment: "Total shipping amount refunded"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount refunded"
    - name: "total_adjustment_amount"
      expr: SUM(CAST(adjustment_amount AS DOUBLE))
      comment: "Total adjustment amount applied to refunds"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee AS DOUBLE))
      comment: "Total restocking fees deducted from refunds"
    - name: "avg_refund_amount"
      expr: AVG(CAST(total_refund_amount AS DOUBLE))
      comment: "Average refund amount per transaction"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across refund transactions"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers receiving refunds"
    - name: "distinct_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of unique locations processing refunds"
    - name: "fraudulent_refund_count"
      expr: SUM(CASE WHEN is_fraudulent = TRUE THEN 1 ELSE 0 END)
      comment: "Count of refunds flagged as fraudulent"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_liquidation_batch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Liquidation batch performance metrics tracking recovery rates, sale prices, fees, and net recovery for returned merchandise disposition and financial impact analysis"
  source: "`retail_ecm`.`returns`.`liquidation_batch`"
  dimensions:
    - name: "batch_status"
      expr: batch_status
      comment: "Current status of the liquidation batch"
    - name: "liquidation_channel"
      expr: liquidation_channel
      comment: "Channel through which liquidation is being conducted"
    - name: "condition_grade_mix"
      expr: condition_grade_mix
      comment: "Mix of condition grades in the batch"
    - name: "category_mix"
      expr: category_mix
      comment: "Mix of product categories in the batch"
    - name: "is_hazmat_flag"
      expr: is_hazmat
      comment: "Flag indicating whether batch contains hazardous materials"
    - name: "requires_data_destruction_flag"
      expr: requires_data_destruction
      comment: "Flag indicating whether batch requires data destruction"
    - name: "batch_creation_year_month"
      expr: DATE_TRUNC('month', batch_creation_date)
      comment: "Month when batch was created"
    - name: "sale_year_month"
      expr: DATE_TRUNC('month', sale_date)
      comment: "Month when batch was sold"
    - name: "settlement_year_month"
      expr: DATE_TRUNC('month', settlement_date)
      comment: "Month when batch settlement occurred"
  measures:
    - name: "total_batches"
      expr: COUNT(1)
      comment: "Total number of liquidation batches"
    - name: "total_cost_value"
      expr: SUM(CAST(total_cost_value AS DOUBLE))
      comment: "Total cost value of merchandise in liquidation batches"
    - name: "total_final_sale_price"
      expr: SUM(CAST(final_sale_price AS DOUBLE))
      comment: "Total final sale price achieved for liquidation batches"
    - name: "total_net_recovery"
      expr: SUM(CAST(net_recovery_amount AS DOUBLE))
      comment: "Total net recovery amount after fees and costs"
    - name: "total_liquidation_fees"
      expr: SUM(CAST(liquidation_fees AS DOUBLE))
      comment: "Total fees paid to liquidation partners"
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost AS DOUBLE))
      comment: "Total transportation cost for liquidation batches"
    - name: "total_tax_write_off"
      expr: SUM(CAST(tax_write_off_amount AS DOUBLE))
      comment: "Total tax write-off amount for liquidated merchandise"
    - name: "total_reserve_price"
      expr: SUM(CAST(reserve_price AS DOUBLE))
      comment: "Total reserve price set for liquidation batches"
    - name: "avg_recovery_rate_percent"
      expr: AVG(CAST(recovery_rate_percent AS DOUBLE))
      comment: "Average recovery rate as percentage of cost value"
    - name: "total_units"
      expr: SUM(CAST(total_units AS DOUBLE))
      comment: "Total number of units in liquidation batches"
    - name: "total_pallet_count"
      expr: SUM(CAST(pallet_count AS DOUBLE))
      comment: "Total number of pallets in liquidation batches"
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total weight in kilograms of liquidation batches"
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume in cubic meters of liquidation batches"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique liquidation partners/vendors"
    - name: "distinct_dc_facilities"
      expr: COUNT(DISTINCT dc_facility_id)
      comment: "Number of unique distribution centers processing liquidation"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_return_fraud_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Return fraud detection and investigation metrics tracking fraud typology, estimated losses, recovery amounts, and case outcomes for loss prevention and risk mitigation"
  source: "`retail_ecm`.`returns`.`return_fraud_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the fraud investigation case"
    - name: "fraud_typology"
      expr: fraud_typology
      comment: "Type or pattern of fraud detected"
    - name: "detection_method"
      expr: detection_method
      comment: "Method used to detect the fraud"
    - name: "investigation_outcome"
      expr: investigation_outcome
      comment: "Final outcome of the fraud investigation"
    - name: "investigation_priority"
      expr: investigation_priority
      comment: "Priority level assigned to the investigation"
    - name: "enforcement_action_taken"
      expr: enforcement_action_taken
      comment: "Enforcement action taken as result of investigation"
    - name: "recovery_status"
      expr: recovery_status
      comment: "Status of recovery efforts for fraud losses"
    - name: "management_review_required_flag"
      expr: management_review_required_flag
      comment: "Flag indicating whether management review is required"
    - name: "case_opened_year_month"
      expr: DATE_TRUNC('month', CAST(case_opened_timestamp AS DATE))
      comment: "Month when fraud case was opened"
    - name: "case_closed_year_month"
      expr: DATE_TRUNC('month', CAST(case_closed_timestamp AS DATE))
      comment: "Month when fraud case was closed"
    - name: "detection_year_month"
      expr: DATE_TRUNC('month', CAST(detection_timestamp AS DATE))
      comment: "Month when fraud was detected"
  measures:
    - name: "total_fraud_cases"
      expr: COUNT(1)
      comment: "Total number of return fraud cases"
    - name: "total_estimated_fraud_value"
      expr: SUM(CAST(estimated_fraud_value_amount AS DOUBLE))
      comment: "Total estimated value of fraud losses"
    - name: "total_civil_recovery"
      expr: SUM(CAST(civil_recovery_amount AS DOUBLE))
      comment: "Total civil recovery amount collected from fraud cases"
    - name: "total_customer_return_value_90d"
      expr: SUM(CAST(customer_return_value_90d AS DOUBLE))
      comment: "Total return value in 90-day window for customers with fraud cases"
    - name: "avg_fraud_score"
      expr: AVG(CAST(fraud_score AS DOUBLE))
      comment: "Average fraud risk score across cases"
    - name: "avg_estimated_fraud_value"
      expr: AVG(CAST(estimated_fraud_value_amount AS DOUBLE))
      comment: "Average estimated fraud value per case"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers involved in fraud cases"
    - name: "distinct_detection_locations"
      expr: COUNT(DISTINCT detection_location_id)
      comment: "Number of unique locations where fraud was detected"
    - name: "distinct_rmas"
      expr: COUNT(DISTINCT rma_id)
      comment: "Number of unique RMAs associated with fraud cases"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_restock_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Restocking efficiency metrics tracking quantity restocked, restocked value, markdown rates, and inventory adjustment timing for operational performance and inventory accuracy"
  source: "`retail_ecm`.`returns`.`restock_event`"
  dimensions:
    - name: "inventory_status"
      expr: inventory_status
      comment: "Inventory status assigned to restocked items"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Condition grade of restocked merchandise"
    - name: "restock_location_type"
      expr: restock_location_type
      comment: "Type of location where item was restocked"
    - name: "restock_reason_code"
      expr: restock_reason_code
      comment: "Reason code for restocking the item"
    - name: "inspection_required_flag"
      expr: inspection_required
      comment: "Flag indicating whether inspection was required"
    - name: "inspection_completed_flag"
      expr: inspection_completed
      comment: "Flag indicating whether inspection was completed"
    - name: "inventory_adjustment_posted_flag"
      expr: inventory_adjustment_posted
      comment: "Flag indicating whether inventory adjustment was posted"
    - name: "restock_year_month"
      expr: DATE_TRUNC('month', CAST(restock_timestamp AS DATE))
      comment: "Month when item was restocked"
    - name: "inspection_year_month"
      expr: DATE_TRUNC('month', CAST(inspection_timestamp AS DATE))
      comment: "Month when inspection was completed"
  measures:
    - name: "total_restock_events"
      expr: COUNT(1)
      comment: "Total number of restock events"
    - name: "total_quantity_restocked"
      expr: SUM(CAST(quantity_restocked AS DOUBLE))
      comment: "Total quantity of items restocked to inventory"
    - name: "total_restocked_value"
      expr: SUM(CAST(restocked_value AS DOUBLE))
      comment: "Total value of restocked merchandise"
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of restocked items"
    - name: "total_markdown_amount"
      expr: SUM(CAST(markdown_amount AS DOUBLE))
      comment: "Total markdown amount applied to restocked items"
    - name: "avg_markdown_percentage"
      expr: AVG(CAST(markdown_percentage AS DOUBLE))
      comment: "Average markdown percentage applied to restocked items"
    - name: "avg_quantity_restocked"
      expr: AVG(CAST(quantity_restocked AS DOUBLE))
      comment: "Average quantity restocked per event"
    - name: "distinct_skus"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of unique SKUs restocked"
    - name: "distinct_rmas"
      expr: COUNT(DISTINCT rma_id)
      comment: "Number of unique RMAs associated with restock events"
    - name: "distinct_restock_locations"
      expr: COUNT(DISTINCT restock_location_id)
      comment: "Number of unique locations receiving restocked inventory"
    - name: "inspection_required_count"
      expr: SUM(CASE WHEN inspection_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of restock events requiring inspection"
    - name: "inspection_completed_count"
      expr: SUM(CASE WHEN inspection_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of restock events with completed inspection"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_vendor_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor credit and chargeback metrics tracking expected vs actual credit amounts, variance, dispute resolution, and payment terms for supplier relationship and AP management"
  source: "`retail_ecm`.`returns`.`vendor_credit`"
  dimensions:
    - name: "credit_status"
      expr: credit_status
      comment: "Current status of the vendor credit"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of vendor credit being processed"
    - name: "dispute_reason_code"
      expr: dispute_reason_code
      comment: "Reason code for credit dispute if applicable"
    - name: "payment_terms"
      expr: payment_terms
      comment: "Payment terms associated with the vendor credit"
    - name: "credit_year_month"
      expr: DATE_TRUNC('month', credit_date)
      comment: "Month when credit was issued"
    - name: "credit_received_year_month"
      expr: DATE_TRUNC('month', credit_received_date)
      comment: "Month when credit was received"
    - name: "credit_applied_year_month"
      expr: DATE_TRUNC('month', credit_applied_date)
      comment: "Month when credit was applied to AP"
  measures:
    - name: "total_vendor_credits"
      expr: COUNT(1)
      comment: "Total number of vendor credit transactions"
    - name: "total_expected_credit_amount"
      expr: SUM(CAST(expected_credit_amount AS DOUBLE))
      comment: "Total expected credit amount from vendors"
    - name: "total_actual_credit_amount"
      expr: SUM(CAST(credit_amount AS DOUBLE))
      comment: "Total actual credit amount received from vendors"
    - name: "total_credit_variance"
      expr: SUM(CAST(credit_variance_amount AS DOUBLE))
      comment: "Total variance between expected and actual credit amounts"
    - name: "total_restocking_fees"
      expr: SUM(CAST(restocking_fee_amount AS DOUBLE))
      comment: "Total restocking fees charged by vendors"
    - name: "avg_expected_credit"
      expr: AVG(CAST(expected_credit_amount AS DOUBLE))
      comment: "Average expected credit amount per transaction"
    - name: "avg_actual_credit"
      expr: AVG(CAST(credit_amount AS DOUBLE))
      comment: "Average actual credit amount per transaction"
    - name: "avg_credit_variance"
      expr: AVG(CAST(credit_variance_amount AS DOUBLE))
      comment: "Average variance between expected and actual credit"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors issuing credits"
    - name: "distinct_rtv_requests"
      expr: COUNT(DISTINCT rtv_request_id)
      comment: "Number of unique return-to-vendor requests associated with credits"
$$;

CREATE OR REPLACE VIEW `retail_ecm`.`_metrics`.`returns_store_credit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Store credit liability and redemption metrics tracking issued amounts, remaining balances, expiration, escheatment risk, and redemption patterns for financial liability management"
  source: "`retail_ecm`.`returns`.`store_credit`"
  dimensions:
    - name: "store_credit_status"
      expr: store_credit_status
      comment: "Current status of the store credit"
    - name: "credit_type"
      expr: credit_type
      comment: "Type of store credit issued"
    - name: "issuing_channel"
      expr: issuing_channel
      comment: "Channel through which store credit was issued"
    - name: "redemption_channel_restriction"
      expr: redemption_channel_restriction
      comment: "Restrictions on channels where credit can be redeemed"
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Flag indicating whether credit is transferable"
    - name: "combinable_with_promotions_flag"
      expr: combinable_with_promotions_flag
      comment: "Flag indicating whether credit can be combined with promotions"
    - name: "escheatment_eligible_flag"
      expr: escheatment_eligible_flag
      comment: "Flag indicating whether credit is eligible for escheatment"
    - name: "breakage_estimate_applied_flag"
      expr: breakage_estimate_applied_flag
      comment: "Flag indicating whether breakage estimate was applied"
    - name: "issue_year_month"
      expr: DATE_TRUNC('month', issue_date)
      comment: "Month when store credit was issued"
    - name: "expiration_year_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month when store credit expires"
    - name: "escheatment_year_month"
      expr: DATE_TRUNC('month', escheatment_date)
      comment: "Month when store credit becomes subject to escheatment"
  measures:
    - name: "total_store_credits"
      expr: COUNT(1)
      comment: "Total number of store credit instruments issued"
    - name: "total_issued_amount"
      expr: SUM(CAST(issued_amount AS DOUBLE))
      comment: "Total amount of store credit issued"
    - name: "total_remaining_balance"
      expr: SUM(CAST(remaining_balance AS DOUBLE))
      comment: "Total remaining balance across all store credits (current liability)"
    - name: "avg_issued_amount"
      expr: AVG(CAST(issued_amount AS DOUBLE))
      comment: "Average store credit amount issued per instrument"
    - name: "avg_remaining_balance"
      expr: AVG(CAST(remaining_balance AS DOUBLE))
      comment: "Average remaining balance per store credit"
    - name: "distinct_customers"
      expr: COUNT(DISTINCT profile_id)
      comment: "Number of unique customers holding store credits"
    - name: "distinct_issuing_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of unique locations issuing store credits"
    - name: "distinct_rmas"
      expr: COUNT(DISTINCT rma_id)
      comment: "Number of unique RMAs that resulted in store credit"
    - name: "escheatment_eligible_count"
      expr: SUM(CASE WHEN escheatment_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of store credits eligible for escheatment"
$$;