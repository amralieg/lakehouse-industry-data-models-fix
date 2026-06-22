-- Metric views for domain: fnb | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check metrics providing revenue, discount, tip, and service-charge performance across outlets, meal periods, and order types. Core operational KPI layer for F&B revenue management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the POS check, used for daily and period trending."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (Breakfast, Lunch, Dinner, etc.) for daypart analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (dine-in, takeaway, delivery, room service) for channel mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Source channel through which the order was placed (POS terminal, app, phone)."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the check (open, closed, voided) for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the check was settled, for multi-currency reporting."
  measures:
    - name: "total_check_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue across all POS checks including tax and service charge. Primary F&B revenue KPI."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge revenue. Used for net revenue and margin analysis."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied across checks. Tracks promotional spend and discount leakage."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected. Important for labor cost offset and guest satisfaction benchmarking."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity collected. Indicator of guest satisfaction and service quality."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected across all checks. Required for tax compliance reporting."
    - name: "check_count"
      expr: COUNT(1)
      comment: "Total number of POS checks. Baseline volume metric for throughput and staffing analysis."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average check value per transaction. Key KPI for revenue per cover and upsell effectiveness."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and margin erosion risk."
    - name: "service_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of subtotal. Benchmarks against policy targets."
    - name: "avg_tip_per_check"
      expr: AVG(CAST(tip_amount AS DOUBLE))
      comment: "Average tip per closed check. Proxy for service quality and guest satisfaction."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-level POS metrics enabling menu item profitability, void analysis, and cost-of-sales tracking. Drives menu engineering and pricing decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  dimensions:
    - name: "family_group_code"
      expr: family_group_code
      comment: "Family group classification of the menu item (Food, Beverage, etc.) for category-level analysis."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major group classification for hierarchical revenue reporting."
    - name: "is_voided"
      expr: is_voided
      comment: "Flag indicating whether the line was voided. Used to isolate void impact on revenue."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Tracks comp cost and guest recognition spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the line item for multi-currency reporting."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all POS check lines. Granular revenue base for menu engineering."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of goods sold at line level. Core input for gross margin and food cost percentage."
    - name: "total_discount_applied"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value at line level. Identifies which item categories absorb the most discounting."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge at line level for detailed revenue decomposition."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax at line level for compliance and revenue net-of-tax reporting."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total units sold across all lines. Drives menu popularity and inventory planning."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit. Benchmarks against standard menu pricing."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE) - CAST(cost_of_sales AS DOUBLE))
      comment: "Gross margin in absolute terms (revenue minus cost of sales). Primary profitability KPI for menu items."
    - name: "food_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_of_sales AS DOUBLE)) / NULLIF(SUM(CAST(line_total_amount AS DOUBLE)), 0), 2)
      comment: "Food cost as a percentage of line revenue. Critical F&B profitability metric; target typically 28-35%."
    - name: "void_line_count"
      expr: COUNT(CASE WHEN is_voided = TRUE THEN 1 END)
      comment: "Number of voided lines. Elevated void rates signal operational issues or fraud risk."
    - name: "void_revenue_impact"
      expr: SUM(CASE WHEN is_voided = TRUE THEN line_total_amount ELSE 0 END)
      comment: "Revenue value of voided lines. Quantifies financial exposure from voids for management review."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_event_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet and event order metrics covering food and beverage revenue, service charges, and event performance. Supports catering sales strategy and event profitability management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_event_order`"
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the banquet event for temporal trending and capacity planning."
    - name: "event_type"
      expr: event_type
      comment: "Type of event (wedding, conference, gala, etc.) for segment-level revenue analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event order (confirmed, tentative, cancelled) for pipeline management."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (theatre, banquet, classroom) for space utilization analysis."
    - name: "beverage_package_type"
      expr: beverage_package_type
      comment: "Type of beverage package selected. Drives beverage revenue mix analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the event order for multi-currency reporting."
  measures:
    - name: "total_event_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total revenue from banquet event orders. Primary catering revenue KPI."
    - name: "total_food_revenue"
      expr: SUM(CAST(food_revenue AS DOUBLE))
      comment: "Total food revenue from banquet events. Tracks food mix and per-person food spend."
    - name: "total_beverage_revenue"
      expr: SUM(CAST(beverage_revenue AS DOUBLE))
      comment: "Total beverage revenue from banquet events. Tracks beverage attach rate and upsell performance."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected on banquet orders. Impacts net revenue and labor cost recovery."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on banquet orders for compliance reporting."
    - name: "event_order_count"
      expr: COUNT(1)
      comment: "Total number of banquet event orders. Volume metric for catering pipeline and capacity planning."
    - name: "avg_revenue_per_event"
      expr: AVG(CAST(total_revenue AS DOUBLE))
      comment: "Average total revenue per banquet event. Benchmarks event value and sales effectiveness."
    - name: "avg_food_revenue_per_event"
      expr: AVG(CAST(food_revenue AS DOUBLE))
      comment: "Average food revenue per event. Tracks per-event food spend trends."
    - name: "avg_per_person_food_price"
      expr: AVG(CAST(per_person_food_price AS DOUBLE))
      comment: "Average per-person food price across events. Key pricing benchmark for catering packages."
    - name: "avg_per_person_beverage_price"
      expr: AVG(CAST(per_person_beverage_price AS DOUBLE))
      comment: "Average per-person beverage price. Benchmarks beverage package pricing strategy."
    - name: "beverage_revenue_mix_pct"
      expr: ROUND(100.0 * SUM(CAST(beverage_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue AS DOUBLE)), 0), 2)
      comment: "Beverage revenue as a percentage of total event revenue. Tracks beverage upsell effectiveness."
    - name: "service_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of total event revenue. Monitors compliance with service charge policy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_waste_log`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food and beverage waste metrics tracking waste cost, quantity, and sustainability impact by outlet, category, and meal period. Drives waste reduction programs and cost control."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`waste_log`"
  dimensions:
    - name: "waste_date"
      expr: waste_date
      comment: "Date waste was recorded for daily and period trending."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (spoilage, over-production, plate waste) for root-cause analysis."
    - name: "waste_type"
      expr: waste_type
      comment: "Type of waste (food, beverage, packaging) for sustainability reporting."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Reason for waste occurrence. Identifies systemic issues driving waste."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period during which waste occurred. Identifies high-waste dayparts."
    - name: "food_category"
      expr: food_category
      comment: "Food category of wasted items for category-level waste analysis."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of disposal (composting, landfill, donation) for sustainability tracking."
    - name: "sustainability_impact_flag"
      expr: sustainability_impact_flag
      comment: "Flag indicating whether the waste event has a sustainability impact for ESG reporting."
  measures:
    - name: "total_waste_cost"
      expr: SUM(CAST(total_waste_cost AS DOUBLE))
      comment: "Total cost of food and beverage waste. Primary financial KPI for waste management programs."
    - name: "total_quantity_wasted"
      expr: SUM(CAST(quantity_wasted AS DOUBLE))
      comment: "Total quantity of items wasted. Volume metric for sustainability and operational efficiency."
    - name: "avg_unit_waste_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average cost per unit of wasted item. Identifies high-value waste categories."
    - name: "waste_incident_count"
      expr: COUNT(1)
      comment: "Total number of waste log entries. Frequency metric for waste event monitoring."
    - name: "health_safety_waste_incidents"
      expr: COUNT(CASE WHEN health_safety_incident_flag = TRUE THEN 1 END)
      comment: "Number of waste events flagged as health and safety incidents. Critical compliance and risk KPI."
    - name: "sustainability_impact_incidents"
      expr: COUNT(CASE WHEN sustainability_impact_flag = TRUE THEN 1 END)
      comment: "Number of waste events with sustainability impact. Tracks ESG performance and environmental risk."
    - name: "avg_waste_cost_per_incident"
      expr: AVG(CAST(total_waste_cost AS DOUBLE))
      comment: "Average waste cost per incident. Benchmarks waste severity and informs reduction targets."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_void_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Void transaction metrics tracking voided revenue, quantities, and investigation flags. Elevated void rates are a key fraud and operational risk indicator for F&B management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`void_transaction`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the void for daily trending and anomaly detection."
    - name: "void_type"
      expr: void_type
      comment: "Type of void (item void, check void, etc.) for operational classification."
    - name: "void_reason_code"
      expr: void_reason_code
      comment: "Reason code for the void. Identifies systemic issues and potential fraud patterns."
    - name: "void_status"
      expr: void_status
      comment: "Current status of the void transaction for workflow tracking."
    - name: "day_part"
      expr: day_part
      comment: "Day part during which the void occurred for operational pattern analysis."
    - name: "requires_investigation"
      expr: requires_investigation
      comment: "Flag indicating whether the void requires management investigation. Key fraud risk indicator."
  measures:
    - name: "total_voided_amount"
      expr: SUM(CAST(voided_total_amount AS DOUBLE))
      comment: "Total monetary value of voided transactions. Primary financial exposure KPI for void management."
    - name: "total_voided_quantity"
      expr: SUM(CAST(voided_quantity AS DOUBLE))
      comment: "Total quantity of items voided. Volume metric for operational quality monitoring."
    - name: "total_voided_service_charge"
      expr: SUM(CAST(voided_service_charge_amount AS DOUBLE))
      comment: "Total service charge reversed through voids. Impacts net service charge revenue."
    - name: "total_voided_tax"
      expr: SUM(CAST(voided_tax_amount AS DOUBLE))
      comment: "Total tax reversed through voids. Required for accurate tax liability reporting."
    - name: "void_count"
      expr: COUNT(1)
      comment: "Total number of void transactions. Baseline frequency metric for fraud and quality monitoring."
    - name: "investigation_required_count"
      expr: COUNT(CASE WHEN requires_investigation = TRUE THEN 1 END)
      comment: "Number of voids flagged for investigation. Critical fraud risk and internal control KPI."
    - name: "avg_voided_amount"
      expr: AVG(CAST(voided_total_amount AS DOUBLE))
      comment: "Average value per void transaction. Benchmarks void severity and identifies outliers."
    - name: "investigation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN requires_investigation = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voids requiring investigation. Key internal control and fraud risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock transaction metrics covering cost of goods movement, variance, and waste. Drives inventory control, shrinkage management, and procurement efficiency."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for period-over-period inventory analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (receipt, issue, transfer, waste, adjustment) for inventory flow analysis."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the transaction (posted, pending, reversed) for reconciliation monitoring."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock movement for daypart cost analysis."
    - name: "waste_category"
      expr: waste_category
      comment: "Waste category for transactions classified as waste. Supports waste reduction programs."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction for multi-currency inventory valuation."
  measures:
    - name: "total_transaction_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost value of all stock movements. Primary inventory cost KPI for F&B cost control."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all transaction types. Volume metric for inventory throughput."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total inventory variance value. Measures shrinkage, theft, and counting errors. Critical loss prevention KPI."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock transactions. Benchmarks purchasing efficiency and cost trends."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Volume metric for inventory activity and operational throughput."
    - name: "waste_transaction_cost"
      expr: SUM(CASE WHEN transaction_type = 'WASTE' THEN total_cost ELSE 0 END)
      comment: "Total cost of waste-classified stock transactions. Tracks waste cost separately for sustainability and cost control."
    - name: "avg_cost_per_transaction"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per stock transaction. Benchmarks transaction size and procurement lot efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_physical_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count metrics tracking variance, count accuracy, and adjustment activity. Supports inventory integrity, shrinkage control, and audit compliance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`physical_count`"
  dimensions:
    - name: "count_date"
      expr: count_date
      comment: "Date of the physical count for period-over-period variance trending."
    - name: "count_type"
      expr: count_type
      comment: "Type of count (full, spot, cycle) for count methodology analysis."
    - name: "count_status"
      expr: count_status
      comment: "Status of the count (in-progress, completed, approved) for workflow monitoring."
    - name: "count_reason"
      expr: count_reason
      comment: "Reason for the count (scheduled, discrepancy, audit) for root-cause analysis."
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the count for financial period alignment."
    - name: "adjustment_required"
      expr: adjustment_required
      comment: "Flag indicating whether an inventory adjustment is required. Tracks count accuracy."
    - name: "recount_required"
      expr: recount_required
      comment: "Flag indicating whether a recount was required. Measures count quality and process reliability."
  measures:
    - name: "total_counted_value"
      expr: SUM(CAST(total_counted_value AS DOUBLE))
      comment: "Total value of inventory counted. Baseline for inventory valuation and balance sheet accuracy."
    - name: "total_variance_value"
      expr: SUM(CAST(total_variance_value AS DOUBLE))
      comment: "Total variance value between system and physical count. Primary shrinkage and loss KPI."
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage across counts. Benchmarks inventory accuracy against industry targets."
    - name: "count_events"
      expr: COUNT(1)
      comment: "Total number of physical count events. Tracks count frequency and compliance with count schedules."
    - name: "adjustment_required_count"
      expr: COUNT(CASE WHEN adjustment_required = TRUE THEN 1 END)
      comment: "Number of counts requiring inventory adjustment. Measures count discrepancy frequency."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_required = TRUE THEN 1 END)
      comment: "Number of counts requiring a recount. Indicates count process quality and staff accuracy."
    - name: "adjustment_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN adjustment_required = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of counts requiring adjustment. Key inventory accuracy and control KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_food_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety inspection metrics tracking compliance scores, violation rates, and corrective action status. Critical for regulatory compliance, brand protection, and guest safety."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the food safety inspection for compliance trend analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (routine, follow-up, complaint-driven) for inspection classification."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (completed, pending, failed) for compliance monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status (compliant, non-compliant, conditional) for regulatory reporting."
    - name: "inspection_grade"
      expr: inspection_grade
      comment: "Grade assigned by the inspector (A, B, C, etc.) for public-facing compliance reporting."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory body conducting the inspection for jurisdiction-level compliance tracking."
    - name: "haccp_compliance_flag"
      expr: haccp_compliance_flag
      comment: "HACCP compliance flag for food safety management system monitoring."
    - name: "reinspection_required_flag"
      expr: reinspection_required_flag
      comment: "Flag indicating reinspection is required. Tracks unresolved compliance issues."
  measures:
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average food safety inspection score. Primary compliance quality KPI; below threshold triggers escalation."
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of inspections conducted. Tracks inspection frequency and regulatory engagement."
    - name: "reinspection_required_count"
      expr: COUNT(CASE WHEN reinspection_required_flag = TRUE THEN 1 END)
      comment: "Number of inspections requiring reinspection. Measures unresolved compliance failures."
    - name: "haccp_compliant_count"
      expr: COUNT(CASE WHEN haccp_compliance_flag = TRUE THEN 1 END)
      comment: "Number of inspections with HACCP compliance confirmed. Tracks food safety management system adherence."
    - name: "corrective_action_required_count"
      expr: COUNT(CASE WHEN corrective_actions_required = TRUE THEN 1 END)
      comment: "Number of inspections requiring corrective action. Measures compliance gap frequency."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reinspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections requiring reinspection. Key regulatory risk and compliance KPI."
    - name: "haccp_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN haccp_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections achieving HACCP compliance. Tracks food safety management system effectiveness."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order metrics covering revenue, delivery performance, and guest satisfaction. Drives in-room dining strategy, staffing, and service quality improvement."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the room service order for daily and period trending."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the order (pending, delivered, cancelled) for operational monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the order was placed (phone, app, in-room tablet) for channel mix analysis."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Flag indicating whether the order was delivered on time. Key service quality dimension."
    - name: "is_vip_guest"
      expr: is_vip_guest
      comment: "Flag indicating VIP guest orders for premium service monitoring and revenue attribution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the order for multi-currency revenue reporting."
  measures:
    - name: "total_order_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total revenue from room service orders. Primary in-room dining revenue KPI."
    - name: "total_delivery_charge"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Tracks delivery fee revenue and pricing strategy effectiveness."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on room service orders. Proxy for guest satisfaction."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge AS DOUBLE))
      comment: "Total service charge on room service orders for revenue decomposition."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Tracks promotional spend in in-room dining."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of room service orders. Volume metric for in-room dining demand and staffing."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per room service order. Benchmarks in-room dining spend and upsell effectiveness."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN on_time_delivery_flag = TRUE THEN 1 END)
      comment: "Number of orders delivered on time. Tracks delivery service quality."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN on_time_delivery_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room service orders delivered on time. Key guest satisfaction and operational KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B inventory item master metrics covering stock levels, cost, and compliance attributes. Supports procurement planning, cost control, and food safety compliance."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the inventory item (food, beverage, dry goods) for category-level analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Subcategory for granular inventory classification and reporting."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the item (active, discontinued, on-hold) for inventory lifecycle management."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag for temperature-controlled items. Drives cold chain compliance monitoring."
    - name: "allergen_flag"
      expr: allergen_flag
      comment: "Flag indicating allergen presence. Critical for food safety and guest safety compliance."
    - name: "halal_certified_flag"
      expr: halal_certified_flag
      comment: "Halal certification flag for dietary compliance and market segment reporting."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Organic sourcing flag for sustainability and premium positioning reporting."
    - name: "local_sourced_flag"
      expr: local_sourced_flag
      comment: "Local sourcing flag for sustainability and farm-to-table program tracking."
  measures:
    - name: "total_on_hand_value"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total value of current on-hand inventory (quantity × standard cost). Primary inventory asset KPI."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per inventory item. Benchmarks procurement pricing and cost trends."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE))
      comment: "Total quantity of inventory on hand across all items. Baseline stock level metric."
    - name: "item_count"
      expr: COUNT(1)
      comment: "Total number of inventory items in the master. Tracks catalog breadth and complexity."
    - name: "below_par_item_count"
      expr: COUNT(CASE WHEN current_on_hand_quantity < par_level THEN 1 END)
      comment: "Number of items below par level. Critical procurement trigger and stockout risk KPI."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN current_on_hand_quantity < reorder_point THEN 1 END)
      comment: "Number of items at or below reorder point. Drives urgent procurement action to prevent stockouts."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inventory items. Impacts recipe costing accuracy and food cost targets."
    - name: "allergen_item_count"
      expr: COUNT(CASE WHEN allergen_flag = TRUE THEN 1 END)
      comment: "Number of items with allergen flags. Tracks allergen exposure risk in the inventory portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item profitability and pricing metrics supporting menu engineering decisions. Identifies high-margin stars, low-margin dogs, and pricing optimization opportunities."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the menu item for category-level menu engineering analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Subcategory for granular menu item classification."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (active, 86'd, seasonal) for menu lifecycle management."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Flag for signature items. Tracks performance of brand-defining menu items."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag for seasonal items. Supports seasonal menu planning and revenue forecasting."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary segment analysis and menu diversity reporting."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Alcoholic item flag for beverage revenue mix and compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the menu item pricing for multi-currency menu management."
  measures:
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard selling price across menu items. Benchmarks pricing strategy and menu tier positioning."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price per menu item. Tracks cost of goods for menu profitability analysis."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Primary menu engineering profitability KPI."
    - name: "menu_item_count"
      expr: COUNT(1)
      comment: "Total number of menu items. Tracks menu breadth and complexity."
    - name: "avg_price_cost_spread"
      expr: AVG(CAST(standard_price AS DOUBLE) - CAST(cost_price AS DOUBLE))
      comment: "Average absolute margin (price minus cost) per menu item. Identifies highest-contribution items."
    - name: "high_margin_item_count"
      expr: COUNT(CASE WHEN gross_margin_percent >= 70.0 THEN 1 END)
      comment: "Number of menu items with gross margin at or above 70%. Tracks portfolio of high-value menu stars."
    - name: "signature_item_count"
      expr: COUNT(CASE WHEN is_signature_item = TRUE THEN 1 END)
      comment: "Number of signature menu items. Tracks brand differentiation through the menu portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B outlet master metrics covering cost targets, compliance, and operational configuration. Supports outlet performance benchmarking and portfolio management."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (restaurant, bar, café, banquet) for portfolio segmentation."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (open, closed, renovating) for portfolio monitoring."
    - name: "cuisine_category"
      expr: cuisine_category
      comment: "Cuisine category for market positioning and competitive analysis."
    - name: "service_style"
      expr: service_style
      comment: "Service style (full service, quick service, buffet) for operational benchmarking."
    - name: "iso_22000_certified_flag"
      expr: iso_22000_certified_flag
      comment: "ISO 22000 food safety certification flag. Tracks compliance portfolio across outlets."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "ADA compliance flag for accessibility compliance monitoring."
  measures:
    - name: "outlet_count"
      expr: COUNT(1)
      comment: "Total number of F&B outlets. Portfolio size metric for capacity and investment planning."
    - name: "avg_food_cost_target_pct"
      expr: AVG(CAST(food_cost_percentage_target AS DOUBLE))
      comment: "Average food cost target percentage across outlets. Benchmarks cost management ambition across the portfolio."
    - name: "avg_beverage_cost_target_pct"
      expr: AVG(CAST(beverage_cost_percentage_target AS DOUBLE))
      comment: "Average beverage cost target percentage. Benchmarks beverage cost management targets."
    - name: "avg_check_target"
      expr: AVG(CAST(average_check_target AS DOUBLE))
      comment: "Average check target across outlets. Tracks revenue per cover ambition and pricing strategy."
    - name: "iso_certified_outlet_count"
      expr: COUNT(CASE WHEN iso_22000_certified_flag = TRUE THEN 1 END)
      comment: "Number of outlets with ISO 22000 food safety certification. Tracks compliance portfolio breadth."
    - name: "iso_certification_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iso_22000_certified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of outlets with ISO 22000 certification. Key food safety compliance KPI for brand protection."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_recipe`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Recipe cost and yield metrics supporting menu costing accuracy, food cost management, and nutritional compliance. Drives standardized recipe adherence and cost control."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`recipe`"
  dimensions:
    - name: "recipe_type"
      expr: recipe_type
      comment: "Type of recipe (food, beverage, cocktail) for category-level cost analysis."
    - name: "recipe_status"
      expr: recipe_status
      comment: "Current status of the recipe (active, archived, in-development) for recipe lifecycle management."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for recipe portfolio analysis and menu planning."
    - name: "iso_22000_ccp_flag"
      expr: iso_22000_ccp_flag
      comment: "Flag indicating the recipe has a critical control point per ISO 22000. Tracks food safety compliance."
    - name: "seasonal_availability"
      expr: seasonal_availability
      comment: "Seasonal availability of the recipe for menu planning and ingredient procurement."
  measures:
    - name: "avg_total_recipe_cost"
      expr: AVG(CAST(total_recipe_cost AS DOUBLE))
      comment: "Average total cost per recipe. Benchmarks recipe cost against menu pricing for margin analysis."
    - name: "avg_food_cost_per_portion"
      expr: AVG(CAST(standard_food_cost_per_portion AS DOUBLE))
      comment: "Average standard food cost per portion. Core input for menu pricing and food cost percentage targets."
    - name: "avg_beverage_cost_per_portion"
      expr: AVG(CAST(standard_beverage_cost_per_portion AS DOUBLE))
      comment: "Average standard beverage cost per portion. Benchmarks beverage recipe cost for pricing decisions."
    - name: "avg_yield_quantity"
      expr: AVG(CAST(yield_quantity AS DOUBLE))
      comment: "Average yield quantity per recipe. Tracks production efficiency and portion consistency."
    - name: "recipe_count"
      expr: COUNT(1)
      comment: "Total number of recipes in the library. Tracks recipe portfolio breadth and standardization coverage."
    - name: "ccp_recipe_count"
      expr: COUNT(CASE WHEN iso_22000_ccp_flag = TRUE THEN 1 END)
      comment: "Number of recipes with critical control points. Tracks food safety risk coverage in the recipe library."
    - name: "avg_nutritional_fat_grams"
      expr: AVG(CAST(nutritional_fat_grams AS DOUBLE))
      comment: "Average fat content per recipe portion. Supports nutritional compliance and healthy menu positioning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_banquet_menu_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet menu package pricing and cost metrics supporting catering package strategy, margin management, and seasonal planning."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`banquet_menu_package`"
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of banquet package (full-day, half-day, dinner, etc.) for package portfolio analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (active, discontinued, seasonal) for portfolio management."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category of the package for segment-level pricing analysis."
    - name: "service_style"
      expr: service_style
      comment: "Service style of the package (plated, buffet, stations) for operational planning."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Flag indicating seasonal packages for demand forecasting and pricing strategy."
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Flag indicating whether the package price is tax-inclusive for pricing transparency analysis."
  measures:
    - name: "avg_per_person_price"
      expr: AVG(CAST(per_person_price AS DOUBLE))
      comment: "Average per-person package price. Primary pricing benchmark for catering package strategy."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_percentage AS DOUBLE))
      comment: "Average food cost percentage across packages. Tracks margin performance against cost targets."
    - name: "avg_beverage_cost_pct"
      expr: AVG(CAST(beverage_cost_percentage AS DOUBLE))
      comment: "Average beverage cost percentage across packages. Benchmarks beverage margin in catering packages."
    - name: "avg_labor_hours_per_guest"
      expr: AVG(CAST(labor_hours_per_guest AS DOUBLE))
      comment: "Average labor hours required per guest. Drives staffing cost estimation and package profitability."
    - name: "package_count"
      expr: COUNT(1)
      comment: "Total number of banquet menu packages. Tracks catering portfolio breadth."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across packages. Benchmarks service charge policy compliance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_discount`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discount business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`discount`"
  dimensions:
    - name: "Applicable Menu Item Scope"
      expr: applicable_menu_item_scope
    - name: "Applicable Outlet Scope"
      expr: applicable_outlet_scope
    - name: "Applies To Service Charge"
      expr: applies_to_service_charge
    - name: "Applies To Tax"
      expr: applies_to_tax
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Authorization Level Required"
      expr: authorization_level_required
    - name: "Combinable With Other Discounts"
      expr: combinable_with_other_discounts
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Discount Category"
      expr: discount_category
    - name: "Discount Code"
      expr: discount_code
    - name: "Discount Description"
      expr: discount_description
    - name: "Discount Name"
      expr: discount_name
    - name: "Discount Status"
      expr: discount_status
    - name: "Discount Type"
      expr: discount_type
    - name: "Internal Notes"
      expr: internal_notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Discount"
      expr: COUNT(DISTINCT discount_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Maximum Discount Amount Per Check"
      expr: SUM(maximum_discount_amount_per_check)
    - name: "Average Maximum Discount Amount Per Check"
      expr: AVG(maximum_discount_amount_per_check)
    - name: "Total Minimum Check Amount"
      expr: SUM(minimum_check_amount)
    - name: "Average Minimum Check Amount"
      expr: AVG(minimum_check_amount)
    - name: "Total Percentage"
      expr: SUM(percentage)
    - name: "Average Percentage"
      expr: AVG(percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Outlet business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`"
  dimensions:
    - name: "Accepts Reservations Flag"
      expr: accepts_reservations_flag
    - name: "Ada Compliant Flag"
      expr: ada_compliant_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Category"
      expr: cuisine_category
    - name: "Dress Code"
      expr: dress_code
    - name: "Email Address"
      expr: email_address
    - name: "Iso 22000 Certification Date"
      expr: iso_22000_certification_date
    - name: "Iso 22000 Certified Flag"
      expr: iso_22000_certified_flag
    - name: "Iso 22000 Expiry Date"
      expr: iso_22000_expiry_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Location Description"
      expr: location_description
    - name: "Menu Last Updated Date"
      expr: menu_last_updated_date
    - name: "Opening Date"
      expr: opening_date
    - name: "Operating Hours Weekday"
      expr: operating_hours_weekday
    - name: "Operating Hours Weekend"
      expr: operating_hours_weekend
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fnb Outlet"
      expr: COUNT(DISTINCT fnb_outlet_id)
    - name: "Total Average Check Target"
      expr: SUM(average_check_target)
    - name: "Average Average Check Target"
      expr: AVG(average_check_target)
    - name: "Total Beverage Cost Percentage Target"
      expr: SUM(beverage_cost_percentage_target)
    - name: "Average Beverage Cost Percentage Target"
      expr: AVG(beverage_cost_percentage_target)
    - name: "Total Food Cost Percentage Target"
      expr: SUM(food_cost_percentage_target)
    - name: "Average Food Cost Percentage Target"
      expr: AVG(food_cost_percentage_target)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_fnb_supply_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fnb Supply Agreement business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_supply_agreement`"
  dimensions:
    - name: "Agreement End Date"
      expr: agreement_end_date
    - name: "Agreement Start Date"
      expr: agreement_start_date
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Last Purchase Date"
      expr: last_purchase_date
    - name: "Lead Time Days"
      expr: lead_time_days
    - name: "Preferred Vendor Flag"
      expr: preferred_vendor_flag
    - name: "Vendor Item Code"
      expr: vendor_item_code
    - name: "Agreement End Date Month"
      expr: DATE_TRUNC('MONTH', agreement_end_date)
    - name: "Agreement Start Date Month"
      expr: DATE_TRUNC('MONTH', agreement_start_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fnb Supply Agreement"
      expr: COUNT(DISTINCT fnb_supply_agreement_id)
    - name: "Total Last Purchase Cost"
      expr: SUM(last_purchase_cost)
    - name: "Average Last Purchase Cost"
      expr: AVG(last_purchase_cost)
    - name: "Total Minimum Order Quantity"
      expr: SUM(minimum_order_quantity)
    - name: "Average Minimum Order Quantity"
      expr: AVG(minimum_order_quantity)
    - name: "Total Unit Cost"
      expr: SUM(unit_cost)
    - name: "Average Unit Cost"
      expr: AVG(unit_cost)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Allergen Information"
      expr: allergen_information
    - name: "Approved Date"
      expr: approved_date
    - name: "Beverage Description"
      expr: beverage_description
    - name: "Beverage Inclusion Flag"
      expr: beverage_inclusion_flag
    - name: "Course Count"
      expr: course_count
    - name: "Course Description"
      expr: course_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Currency Code"
      expr: currency_code
    - name: "Dietary Options"
      expr: dietary_options
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Capacity"
      expr: maximum_capacity
    - name: "Meal Period"
      expr: meal_period
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Menu"
      expr: COUNT(DISTINCT menu_id)
    - name: "Total Per Person Price"
      expr: SUM(per_person_price)
    - name: "Average Per Person Price"
      expr: AVG(per_person_price)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_revenue_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Revenue Center business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`revenue_center`"
  dimensions:
    - name: "Allergen Menu Available Flag"
      expr: allergen_menu_available_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Covers Per Day Target"
      expr: covers_per_day_target
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Day Part Service Flag"
      expr: day_part_service_flag
    - name: "Dress Code"
      expr: dress_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Gratuity Policy"
      expr: gratuity_policy
    - name: "Iso 22000 Certified Flag"
      expr: iso_22000_certified_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Micros Rvc Number"
      expr: micros_rvc_number
    - name: "Notes"
      expr: notes
    - name: "Opening Date"
      expr: opening_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Revenue Center"
      expr: COUNT(DISTINCT revenue_center_id)
    - name: "Total Average Check Target Amount"
      expr: SUM(average_check_target_amount)
    - name: "Average Average Check Target Amount"
      expr: AVG(average_check_target_amount)
    - name: "Total Beverage Cost Target Percentage"
      expr: SUM(beverage_cost_target_percentage)
    - name: "Average Beverage Cost Target Percentage"
      expr: AVG(beverage_cost_target_percentage)
    - name: "Total Food Cost Target Percentage"
      expr: SUM(food_cost_target_percentage)
    - name: "Average Food Cost Target Percentage"
      expr: AVG(food_cost_target_percentage)
    - name: "Total Labor Cost Target Percentage"
      expr: SUM(labor_cost_target_percentage)
    - name: "Average Labor Cost Target Percentage"
      expr: AVG(labor_cost_target_percentage)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage Location business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`storage_location`"
  dimensions:
    - name: "Access Restriction Level"
      expr: access_restriction_level
    - name: "Active From Date"
      expr: active_from_date
    - name: "Active Until Date"
      expr: active_until_date
    - name: "Allergen Segregation Required Flag"
      expr: allergen_segregation_required_flag
    - name: "Barcode"
      expr: barcode
    - name: "Building Name"
      expr: building_name
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Decommission Reason"
      expr: decommission_reason
    - name: "Floor Level"
      expr: floor_level
    - name: "Hazmat Approved Flag"
      expr: hazmat_approved_flag
    - name: "Inspection Frequency Days"
      expr: inspection_frequency_days
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Location Code"
      expr: location_code
    - name: "Location Name"
      expr: location_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Storage Location"
      expr: COUNT(DISTINCT storage_location_id)
    - name: "Total Capacity Cubic Meters"
      expr: SUM(capacity_cubic_meters)
    - name: "Average Capacity Cubic Meters"
      expr: AVG(capacity_cubic_meters)
    - name: "Total Target Temperature Max Celsius"
      expr: SUM(target_temperature_max_celsius)
    - name: "Average Target Temperature Max Celsius"
      expr: AVG(target_temperature_max_celsius)
    - name: "Total Target Temperature Min Celsius"
      expr: SUM(target_temperature_min_celsius)
    - name: "Average Target Temperature Min Celsius"
      expr: AVG(target_temperature_min_celsius)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_wine_cellar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Wine Cellar business metrics"
  source: "`vibe_travel_hospitality_v1`.`fnb`.`wine_cellar`"
  dimensions:
    - name: "Appellation"
      expr: appellation
    - name: "Bin Location"
      expr: bin_location
    - name: "Bottle Size Ml"
      expr: bottle_size_ml
    - name: "By The Glass Program Flag"
      expr: by_the_glass_program_flag
    - name: "Country Of Origin"
      expr: country_of_origin
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Food Pairing Recommendations"
      expr: food_pairing_recommendations
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Last Inventory Count Date"
      expr: last_inventory_count_date
    - name: "Last Purchase Date"
      expr: last_purchase_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Optimal Drinking Window End"
      expr: optimal_drinking_window_end
    - name: "Optimal Drinking Window Start"
      expr: optimal_drinking_window_start
    - name: "Par Level"
      expr: par_level
    - name: "Producer Name"
      expr: producer_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Wine Cellar"
      expr: COUNT(DISTINCT wine_cellar_id)
    - name: "Total Alcohol By Volume Pct"
      expr: SUM(alcohol_by_volume_pct)
    - name: "Average Alcohol By Volume Pct"
      expr: AVG(alcohol_by_volume_pct)
    - name: "Total Purchase Cost Per Bottle"
      expr: SUM(purchase_cost_per_bottle)
    - name: "Average Purchase Cost Per Bottle"
      expr: AVG(purchase_cost_per_bottle)
    - name: "Total Selling Price Bottle"
      expr: SUM(selling_price_bottle)
    - name: "Average Selling Price Bottle"
      expr: AVG(selling_price_bottle)
    - name: "Total Selling Price Glass"
      expr: SUM(selling_price_glass)
    - name: "Average Selling Price Glass"
      expr: AVG(selling_price_glass)
    - name: "Total Storage Temperature Celsius"
      expr: SUM(storage_temperature_celsius)
    - name: "Average Storage Temperature Celsius"
      expr: AVG(storage_temperature_celsius)
$$;