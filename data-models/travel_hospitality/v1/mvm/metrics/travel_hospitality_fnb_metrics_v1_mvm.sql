-- Metric views for domain: fnb | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check-level metrics covering outlet revenue performance, average check value, discount impact, service charge yield, and tip capture. Primary operational KPI layer for F&B outlet managers and finance leadership."
  source: "`travel_hospitality_ecm`.`fnb`.`pos_check`"
  filter: check_status != 'VOIDED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Calendar date of the transaction used for daily, weekly, and monthly trend analysis."
    - name: "meal_period"
      expr: meal_period
      comment: "Day-part (Breakfast, Lunch, Dinner, Late Night) enabling revenue and cover analysis by service period."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Dine-In, Takeaway, Delivery, Room Charge) for channel-mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Origin channel of the order (POS, Mobile App, Phone, Online) to evaluate channel contribution."
    - name: "payment_method"
      expr: payment_method
      comment: "Tender type used (Cash, Credit Card, Room Charge, Loyalty Points) for payment-mix reporting."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the POS check (Open, Closed, Voided) for operational monitoring."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency revenue reporting."
    - name: "pos_terminal_code"
      expr: pos_terminal_code
      comment: "POS terminal identifier enabling terminal-level throughput and error analysis."
  measures:
    - name: "total_checks"
      expr: COUNT(1)
      comment: "Total number of POS checks opened. Baseline volume metric for outlet throughput and staffing decisions."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue collected across all checks including tax and service charge. Primary top-line F&B revenue KPI."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-service-charge check subtotals. Used to isolate net food and beverage revenue from ancillary charges."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total monetary value of discounts applied across all checks. Tracks promotional spend and discount leakage."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected. Informs service charge yield and labor cost offset analysis."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all checks. Required for tax compliance and remittance reporting."
    - name: "total_tips"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity captured at POS. Indicator of guest satisfaction and staff incentive pool size."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per check. Core KPI for pricing strategy, upsell effectiveness, and outlet performance benchmarking."
    - name: "avg_discount_per_check"
      expr: AVG(CAST(discount_amount AS DOUBLE))
      comment: "Average discount applied per check. Monitors discount depth and promotional program efficiency."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional intensity and revenue dilution risk."
    - name: "service_charge_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of subtotal revenue. Validates service charge policy compliance and yield consistency."
    - name: "tip_capture_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(tip_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_amount AS DOUBLE)), 0), 2)
      comment: "Tips as a percentage of total revenue. Proxy for guest satisfaction and service quality at the outlet level."
    - name: "distinct_loyalty_members"
      expr: COUNT(DISTINCT loyalty_member_id)
      comment: "Count of unique loyalty members transacting at the outlet. Measures loyalty program engagement in F&B."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level metrics for POS transactions enabling menu item profitability, void analysis, discount attribution, and cost-of-sales tracking. Used by F&B directors and menu engineers to optimize menu mix and margin."
  source: "`travel_hospitality_ecm`.`fnb`.`pos_check_line`"
  filter: is_voided = False
  dimensions:
    - name: "family_group_code"
      expr: family_group_code
      comment: "Menu family group (e.g., Food, Beverage, Dessert) for category-level revenue and margin analysis."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major menu group classification enabling hierarchical menu mix reporting."
    - name: "course_number"
      expr: course_number
      comment: "Course sequence (Starter, Main, Dessert) for dining flow and upsell pattern analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Used to track comp cost and guest recovery spend."
    - name: "is_open_item"
      expr: is_open_item
      comment: "Flag for open-price items (not linked to a menu item). Monitors pricing control and exception handling."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency line-item revenue reporting."
  measures:
    - name: "total_line_items_sold"
      expr: COUNT(1)
      comment: "Total number of non-voided line items sold. Baseline volume metric for menu item throughput."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items ordered across all line items. Drives procurement planning and menu popularity ranking."
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue generated at line-item level including tax and service charge. Granular revenue attribution by menu item."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE))
      comment: "Sum of line subtotals before tax and service charge. Used for net menu revenue analysis."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of goods sold at line-item level. Core input for gross margin and food cost percentage calculations."
    - name: "total_line_discount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value applied at line level. Identifies high-discount menu items and promotional leakage."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across all line items. Monitors pricing consistency and menu price realization."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE) - CAST(cost_of_sales AS DOUBLE))
      comment: "Total gross margin (revenue minus cost of sales) at line level. Primary profitability KPI for menu engineering decisions."
    - name: "food_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_of_sales AS DOUBLE)) / NULLIF(SUM(CAST(line_subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Cost of sales as a percentage of line subtotal revenue. Benchmark KPI for kitchen efficiency and recipe cost control."
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of unique menu items sold. Measures menu breadth utilization and identifies slow-moving items for rationalization."
    - name: "avg_items_per_check"
      expr: ROUND(CAST(COUNT(1) AS DOUBLE) / NULLIF(COUNT(DISTINCT pos_check_id), 0), 2)
      comment: "Average number of line items per check. Indicator of upsell success and dining experience depth."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_banquet_event_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet and event order metrics covering event revenue, food and beverage mix, service charge yield, and tax compliance. Used by catering sales directors and event operations teams to manage event profitability and pipeline."
  source: "`travel_hospitality_ecm`.`fnb`.`banquet_event_order`"
  filter: event_status NOT IN ('CANCELLED', 'NO_SHOW')
  dimensions:
    - name: "event_date"
      expr: event_date
      comment: "Date of the banquet event for temporal trend and seasonality analysis."
    - name: "event_type"
      expr: event_type
      comment: "Category of event (Wedding, Conference, Gala, Meeting) for segment-level revenue and profitability analysis."
    - name: "event_status"
      expr: event_status
      comment: "Current status of the event order (Confirmed, Tentative, Completed) for pipeline and conversion tracking."
    - name: "beverage_package_type"
      expr: beverage_package_type
      comment: "Type of beverage package selected (Open Bar, Consumption, Non-Alcoholic) for beverage revenue mix analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Room setup configuration (Theatre, Banquet, Classroom) for space utilization and capacity planning."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency event revenue reporting."
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of banquet event orders. Baseline volume metric for catering pipeline and event operations capacity."
    - name: "total_event_revenue"
      expr: SUM(CAST(total_revenue AS DOUBLE))
      comment: "Total gross revenue from banquet events including food, beverage, service charge, and tax. Primary catering top-line KPI."
    - name: "total_food_revenue"
      expr: SUM(CAST(food_revenue AS DOUBLE))
      comment: "Total food revenue from banquet events. Measures food component contribution to overall event revenue."
    - name: "total_beverage_revenue"
      expr: SUM(CAST(beverage_revenue AS DOUBLE))
      comment: "Total beverage revenue from banquet events. Tracks beverage upsell performance and package adoption."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charge collected on banquet events. Validates service charge policy application and yield."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on banquet events. Required for tax compliance and regulatory remittance reporting."
    - name: "avg_event_revenue"
      expr: AVG(CAST(total_revenue AS DOUBLE))
      comment: "Average revenue per banquet event. Benchmarks event value and informs minimum spend policy decisions."
    - name: "avg_per_person_food_price"
      expr: AVG(CAST(per_person_food_price AS DOUBLE))
      comment: "Average per-person food price across events. Monitors menu package pricing realization and upsell effectiveness."
    - name: "avg_per_person_beverage_price"
      expr: AVG(CAST(per_person_beverage_price AS DOUBLE))
      comment: "Average per-person beverage price across events. Tracks beverage package pricing and revenue per attendee."
    - name: "beverage_revenue_mix_pct"
      expr: ROUND(100.0 * SUM(CAST(beverage_revenue AS DOUBLE)) / NULLIF(SUM(CAST(total_revenue AS DOUBLE)), 0), 2)
      comment: "Beverage revenue as a percentage of total event revenue. Measures beverage upsell penetration and mix optimization opportunity."
    - name: "service_charge_yield_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(food_revenue AS DOUBLE) + CAST(beverage_revenue AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of food and beverage revenue. Validates consistent service charge application across events."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average contracted service charge percentage across events. Monitors rate consistency and contract compliance."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order metrics covering delivery performance, revenue per order, on-time delivery rates, and guest satisfaction. Used by F&B operations managers and hotel GMs to manage in-room dining quality and profitability."
  source: "`travel_hospitality_ecm`.`fnb`.`room_service_order`"
  filter: order_status NOT IN ('CANCELLED')
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Calendar date of the room service order for daily trend and demand pattern analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the room service order (Pending, Dispatched, Delivered, Cancelled) for operational monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the order was placed (Phone, In-Room Tablet, App) for channel mix and digital adoption analysis."
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method used (Room Charge, Credit Card, Cash) for payment mix and folio posting analysis."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Boolean flag indicating whether the order was delivered within the promised time window. Core service quality dimension."
    - name: "is_vip_guest"
      expr: is_vip_guest
      comment: "Flag indicating VIP guest orders. Enables differentiated service level analysis and VIP revenue contribution."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency room service revenue reporting."
  measures:
    - name: "total_orders"
      expr: COUNT(1)
      comment: "Total number of room service orders. Baseline volume metric for in-room dining demand and staffing decisions."
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross revenue from room service orders. Primary in-room dining revenue KPI for F&B P&L."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Sum of pre-tax, pre-service-charge order subtotals. Net food and beverage revenue from in-room dining."
    - name: "total_delivery_charge"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Measures delivery fee revenue contribution and pricing strategy effectiveness."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge AS DOUBLE))
      comment: "Total service charge collected on room service orders. Validates service charge policy application."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on room service orders. Indicator of guest satisfaction and staff incentive pool."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Tracks promotional spend and discount leakage in in-room dining."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average revenue per room service order. Core KPI for in-room dining pricing strategy and upsell effectiveness."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_delivery_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room service orders delivered on time. Critical service quality KPI directly linked to guest satisfaction scores."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue for room service. Monitors promotional intensity and revenue dilution."
    - name: "vip_order_share_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_vip_guest = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room service orders from VIP guests. Measures VIP service demand and informs dedicated staffing decisions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_void_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Void transaction metrics tracking revenue loss from voided checks and line items, void reason patterns, and operational control compliance. Used by F&B controllers and audit teams to detect fraud risk and operational inefficiencies."
  source: "`travel_hospitality_ecm`.`fnb`.`void_transaction`"
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Calendar date of the void transaction for daily trend and anomaly detection."
    - name: "void_type"
      expr: void_type
      comment: "Classification of the void (Item Void, Check Void, Correction) for root cause analysis."
    - name: "void_reason_code"
      expr: void_reason_code
      comment: "Coded reason for the void (e.g., Guest Complaint, Order Error, Manager Comp) for operational control reporting."
    - name: "void_status"
      expr: void_status
      comment: "Current status of the void transaction (Approved, Pending Investigation) for compliance monitoring."
    - name: "day_part"
      expr: day_part
      comment: "Service period during which the void occurred. Identifies high-void meal periods for targeted operational intervention."
    - name: "is_employee_meal"
      expr: is_employee_meal
      comment: "Flag indicating employee meal voids. Separates legitimate employee meal comps from operational errors."
    - name: "is_manager_meal"
      expr: is_manager_meal
      comment: "Flag indicating manager-authorized meal voids. Monitors management comp usage and policy compliance."
    - name: "requires_investigation"
      expr: requires_investigation
      comment: "Flag indicating voids flagged for investigation. Prioritizes audit and fraud detection workflows."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency void amount reporting."
  measures:
    - name: "total_voids"
      expr: COUNT(1)
      comment: "Total number of void transactions. Baseline volume metric for operational control and exception rate benchmarking."
    - name: "total_voided_amount"
      expr: SUM(CAST(voided_amount AS DOUBLE))
      comment: "Total monetary value of voided items. Measures revenue at risk from operational errors and potential fraud."
    - name: "total_voided_total_amount"
      expr: SUM(CAST(voided_total_amount AS DOUBLE))
      comment: "Total gross amount voided including tax and service charge. Full financial exposure from void activity."
    - name: "total_voided_service_charge"
      expr: SUM(CAST(voided_service_charge_amount AS DOUBLE))
      comment: "Total service charge amount voided. Tracks service charge revenue lost through void activity."
    - name: "total_voided_tax"
      expr: SUM(CAST(voided_tax_amount AS DOUBLE))
      comment: "Total tax amount voided. Required for tax reconciliation and compliance reporting."
    - name: "avg_voided_amount"
      expr: AVG(CAST(voided_amount AS DOUBLE))
      comment: "Average monetary value per void transaction. Benchmarks void severity and identifies unusually large void events."
    - name: "investigation_required_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_investigation = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of voids flagged for investigation. Key fraud risk and internal control KPI for F&B audit teams."
    - name: "distinct_outlets_with_voids"
      expr: COUNT(DISTINCT fnb_outlet_id)
      comment: "Number of distinct outlets generating void transactions. Identifies outlets with systemic void issues requiring management attention."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory stock transaction metrics covering cost of goods movement, waste tracking, variance analysis, and stock control efficiency. Used by F&B cost controllers and procurement teams to manage food and beverage cost targets."
  source: "`travel_hospitality_ecm`.`fnb`.`stock_transaction`"
  filter: transaction_status != 'REVERSED'
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for daily inventory movement and cost trend analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (Purchase, Issue, Transfer, Waste, Adjustment) for inventory flow categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the stock transaction (Posted, Pending, Reversed) for ledger reconciliation."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock issue. Enables cost attribution by service period."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (Spoilage, Over-Production, Breakage) for waste reduction program targeting."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste. Enables root cause analysis and corrective action prioritization."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency cost reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the stock transaction quantity (KG, Litre, Each) for physical inventory reconciliation."
  measures:
    - name: "total_transactions"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Baseline volume metric for inventory activity and control point monitoring."
    - name: "total_stock_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost value of all stock movements. Primary cost-of-goods metric for F&B cost control and P&L reporting."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total physical quantity moved across all stock transactions. Drives procurement planning and par level validation."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total monetary variance between expected and actual stock values. Key shrinkage and control KPI for F&B audit."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across all stock transactions. Monitors purchasing price trends and supplier cost management."
    - name: "waste_cost_total"
      expr: SUM(CASE WHEN waste_category IS NOT NULL THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of waste transactions. Directly measures food and beverage waste financial impact for sustainability and cost programs."
    - name: "waste_cost_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waste_category IS NOT NULL THEN CAST(total_cost AS DOUBLE) ELSE 0 END) / NULLIF(SUM(CAST(total_cost AS DOUBLE)), 0), 2)
      comment: "Waste cost as a percentage of total stock cost. Benchmark KPI for food waste reduction programs and sustainability targets."
    - name: "distinct_items_transacted"
      expr: COUNT(DISTINCT inventory_item_id)
      comment: "Number of distinct inventory items with stock movements. Measures inventory breadth and identifies inactive items for rationalization."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item master metrics covering pricing, cost, gross margin, and dietary attribute profiling. Used by menu engineers and F&B directors to rationalize the menu, set pricing strategy, and ensure dietary compliance."
  source: "`travel_hospitality_ecm`.`fnb`.`menu_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level menu category (Food, Beverage, Dessert) for category-level margin and pricing analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Detailed menu subcategory for granular menu engineering and item rationalization."
    - name: "menu_section"
      expr: menu_section
      comment: "Section of the menu where the item appears (Starters, Mains, Sides) for menu layout optimization."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (Active, Inactive, Seasonal) for menu lifecycle management."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Flag indicating alcoholic items. Enables alcohol vs. non-alcohol revenue and margin split analysis."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag for vegan menu items. Tracks dietary-inclusive menu coverage for guest segment targeting."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Flag for vegetarian menu items. Measures plant-based menu breadth for dietary compliance and guest satisfaction."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Flag for gluten-free items. Monitors allergen-safe menu coverage for compliance and inclusive dining."
    - name: "is_halal"
      expr: is_halal
      comment: "Flag for halal-certified items. Tracks halal menu coverage for religious dietary compliance."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Flag for signature menu items. Enables signature item performance tracking and brand differentiation analysis."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Flag for seasonal menu items. Supports seasonal menu planning and availability management."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency menu pricing analysis."
  measures:
    - name: "total_menu_items"
      expr: COUNT(1)
      comment: "Total number of active menu items. Baseline metric for menu size and complexity management."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average standard selling price across menu items. Monitors overall menu pricing level and price tier positioning."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average cost price across menu items. Benchmarks cost structure and informs pricing floor decisions."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Primary menu profitability KPI for menu engineering and pricing strategy."
    - name: "total_menu_cost_value"
      expr: SUM(CAST(cost_price AS DOUBLE))
      comment: "Sum of cost prices across all active menu items. Measures total cost exposure of the active menu portfolio."
    - name: "total_menu_price_value"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Sum of standard prices across all active menu items. Measures total revenue potential of the active menu portfolio."
    - name: "dietary_inclusive_item_count"
      expr: SUM(CASE WHEN is_vegan = True OR is_vegetarian = True OR is_gluten_free = True OR is_halal = True OR is_kosher = True THEN 1 ELSE 0 END)
      comment: "Count of menu items meeting at least one dietary inclusion criterion. Measures menu inclusivity for diverse guest segments."
    - name: "signature_item_count"
      expr: SUM(CASE WHEN is_signature_item = True THEN 1 ELSE 0 END)
      comment: "Count of signature menu items. Tracks brand differentiation through proprietary menu offerings."
    - name: "avg_alcohol_content_pct"
      expr: AVG(CASE WHEN is_alcoholic = True THEN CAST(alcohol_content_percent AS DOUBLE) ELSE NULL END)
      comment: "Average alcohol content percentage across alcoholic menu items. Supports responsible service compliance and menu labeling."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`fnb_banquet_menu_package`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Banquet menu package metrics covering package pricing, cost structure, service charge configuration, and seasonal availability. Used by catering sales and F&B directors to optimize package portfolio and pricing strategy."
  source: "`travel_hospitality_ecm`.`fnb`.`banquet_menu_package`"
  filter: package_status = 'ACTIVE'
  dimensions:
    - name: "package_type"
      expr: package_type
      comment: "Type of banquet package (Full Day, Half Day, Dinner, Cocktail) for portfolio segmentation and revenue mix analysis."
    - name: "menu_category"
      expr: menu_category
      comment: "Menu category of the package (Buffet, Plated, Stations) for service style and cost structure analysis."
    - name: "package_status"
      expr: package_status
      comment: "Current status of the package (Active, Inactive, Seasonal) for portfolio lifecycle management."
    - name: "seasonal_indicator"
      expr: seasonal_indicator
      comment: "Flag indicating seasonal packages. Enables seasonal pricing strategy and availability planning."
    - name: "beverage_inclusion"
      expr: beverage_inclusion
      comment: "Beverage inclusion type (Included, Excluded, Optional) for package revenue mix and upsell opportunity analysis."
    - name: "service_style"
      expr: service_style
      comment: "Service style of the package (Buffet, Plated, Family Style) for labor cost and operational planning."
    - name: "tax_inclusive_flag"
      expr: tax_inclusive_flag
      comment: "Flag indicating whether the package price is tax-inclusive. Critical for accurate revenue and tax reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "ISO currency code for multi-currency package pricing analysis."
  measures:
    - name: "total_packages"
      expr: COUNT(1)
      comment: "Total number of active banquet menu packages. Baseline metric for package portfolio size and complexity."
    - name: "avg_per_person_price"
      expr: AVG(CAST(per_person_price AS DOUBLE))
      comment: "Average per-person package price. Core pricing KPI for catering sales strategy and competitive benchmarking."
    - name: "avg_food_cost_pct"
      expr: AVG(CAST(food_cost_percentage AS DOUBLE))
      comment: "Average food cost percentage across packages. Monitors food cost structure and margin sustainability of the package portfolio."
    - name: "avg_beverage_cost_pct"
      expr: AVG(CAST(beverage_cost_percentage AS DOUBLE))
      comment: "Average beverage cost percentage across packages. Tracks beverage cost efficiency and package profitability."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across packages. Validates service charge consistency and policy compliance."
    - name: "avg_labor_hours_per_guest"
      expr: AVG(CAST(labor_hours_per_guest AS DOUBLE))
      comment: "Average labor hours required per guest across packages. Key input for staffing cost modeling and event profitability forecasting."
    - name: "total_price_value"
      expr: SUM(CAST(per_person_price AS DOUBLE))
      comment: "Sum of per-person prices across all active packages. Measures total revenue potential of the active package portfolio."
    - name: "seasonal_package_count"
      expr: SUM(CASE WHEN seasonal_indicator = True THEN 1 ELSE 0 END)
      comment: "Count of seasonal banquet packages. Tracks seasonal portfolio depth and informs seasonal revenue planning."
$$;