-- Metric views for domain: fnb | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Point-of-sale check-level revenue, profitability, and service performance metrics. Primary fact table for F&B outlet financial performance, discount analysis, and guest spend patterns."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check`"
  filter: check_status != 'VOIDED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Calendar date of the transaction, used for daily/weekly/monthly trend analysis."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period (Breakfast, Lunch, Dinner, Late Night) for daypart revenue analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of order (Dine-In, Takeaway, Room Service, Delivery) for channel mix analysis."
    - name: "order_source"
      expr: order_source
      comment: "Origin channel of the order (POS, Mobile App, Phone, Online) for channel attribution."
    - name: "check_status"
      expr: check_status
      comment: "Current status of the POS check (Open, Closed, Voided) for operational monitoring."
    - name: "pos_terminal_code"
      expr: pos_terminal_code
      comment: "POS terminal identifier for terminal-level performance and reconciliation."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency property reporting."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet foreign key for outlet-level revenue aggregation."
    - name: "revenue_center_id"
      expr: revenue_center_id
      comment: "Revenue center foreign key for USALI-aligned departmental reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property foreign key for portfolio-level roll-up."
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total gross F&B revenue including food, beverage, service charges, and taxes. Primary top-line KPI for F&B financial performance."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net F&B revenue before service charges and taxes. Used for food and beverage revenue benchmarking."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges collected. Tracks service charge yield and policy compliance."
    - name: "total_tax_collected"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount collected across all checks. Required for tax remittance and regulatory reporting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied across all checks. Tracks promotional spend and discount policy adherence."
    - name: "total_tip_amount"
      expr: SUM(CAST(tip_amount AS DOUBLE))
      comment: "Total gratuity/tip collected. Indicator of guest satisfaction and service quality."
    - name: "total_tender_amount"
      expr: SUM(CAST(tender_amount AS DOUBLE))
      comment: "Total amount tendered by guests. Used for cash reconciliation and payment method analysis."
    - name: "check_count"
      expr: COUNT(1)
      comment: "Total number of POS checks. Baseline volume metric for covers and transaction throughput."
    - name: "avg_check_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average check value per transaction. Key KPI for spend-per-cover benchmarking against targets."
    - name: "discount_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Discount as a percentage of subtotal revenue. Measures promotional cost burden and discount policy effectiveness."
    - name: "service_charge_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(service_charge_amount AS DOUBLE)) / NULLIF(SUM(CAST(subtotal_amount AS DOUBLE)), 0), 2)
      comment: "Service charge as a percentage of subtotal revenue. Validates service charge policy application consistency."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_pos_check_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Line-item level F&B sales metrics for menu item performance, cost of sales, margin analysis, and void/waste tracking. Enables menu engineering and item-level profitability decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`pos_check_line`"
  filter: is_voided = False
  dimensions:
    - name: "menu_item_id"
      expr: menu_item_id
      comment: "Menu item foreign key for item-level sales and margin analysis."
    - name: "revenue_center_id"
      expr: revenue_center_id
      comment: "Revenue center for departmental sales mix reporting."
    - name: "major_group_code"
      expr: major_group_code
      comment: "Major group classification (Food, Beverage, etc.) for high-level revenue mix analysis."
    - name: "family_group_code"
      expr: family_group_code
      comment: "Family group classification for mid-level category sales analysis."
    - name: "course_number"
      expr: course_number
      comment: "Course sequence (Starter, Main, Dessert) for menu engineering and upsell analysis."
    - name: "is_complimentary"
      expr: is_complimentary
      comment: "Flag indicating complimentary items. Used to track comp cost and guest recognition spend."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency reporting."
    - name: "is_voided"
      expr: is_voided
      comment: "Void flag for waste and error analysis (included as dimension for void-inclusive views)."
  measures:
    - name: "total_line_revenue"
      expr: SUM(CAST(line_total_amount AS DOUBLE))
      comment: "Total revenue from all non-voided line items. Core measure for item-level and category revenue reporting."
    - name: "total_line_subtotal"
      expr: SUM(CAST(line_subtotal_amount AS DOUBLE))
      comment: "Total pre-tax, pre-service-charge line revenue. Used for net sales analysis."
    - name: "total_cost_of_sales"
      expr: SUM(CAST(cost_of_sales AS DOUBLE))
      comment: "Total cost of goods sold at line level. Critical for gross margin and food/beverage cost percentage calculation."
    - name: "total_quantity_sold"
      expr: SUM(CAST(quantity_ordered AS DOUBLE))
      comment: "Total quantity of items sold. Used for menu item popularity ranking and inventory depletion forecasting."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied at line level. Tracks item-level promotional cost."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge_amount AS DOUBLE))
      comment: "Total service charges at line level for detailed service charge attribution."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax at line level for tax category compliance and reporting."
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average selling price per unit across all line items. Used for price realization and menu pricing analysis."
    - name: "gross_margin_amount"
      expr: SUM(CAST(line_total_amount AS DOUBLE) - CAST(cost_of_sales AS DOUBLE))
      comment: "Gross profit at line level (revenue minus cost of sales). Direct measure of item-level profitability."
    - name: "cost_of_sales_pct"
      expr: ROUND(100.0 * SUM(CAST(cost_of_sales AS DOUBLE)) / NULLIF(SUM(CAST(line_total_amount AS DOUBLE)), 0), 2)
      comment: "Cost of sales as a percentage of line revenue. Key F&B cost control KPI benchmarked against food/beverage cost targets."
    - name: "line_item_count"
      expr: COUNT(1)
      comment: "Total number of line items sold. Volume baseline for items-per-cover and throughput analysis."
    - name: "distinct_menu_items_sold"
      expr: COUNT(DISTINCT menu_item_id)
      comment: "Number of distinct menu items ordered. Measures menu breadth utilization and item popularity spread."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_room_service_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Room service order performance metrics covering revenue, delivery efficiency, guest satisfaction, and operational KPIs. Enables management of in-room dining profitability and service quality."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`room_service_order`"
  filter: order_status != 'CANCELLED'
  dimensions:
    - name: "business_date"
      expr: business_date
      comment: "Business date of the room service order for daily trend and daypart analysis."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the room service order (Pending, Delivered, Cancelled) for operational monitoring."
    - name: "order_source"
      expr: order_source
      comment: "Channel through which the order was placed (Phone, App, In-Room Tablet) for channel mix analysis."
    - name: "on_time_delivery_flag"
      expr: on_time_delivery_flag
      comment: "Boolean flag indicating whether the order was delivered within the promised time window. Key service quality dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency property reporting."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet fulfilling the room service order for outlet-level performance attribution."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for portfolio-level room service benchmarking."
    - name: "revenue_center_id"
      expr: revenue_center_id
      comment: "Revenue center for USALI-aligned room service revenue reporting."
  measures:
    - name: "total_room_service_revenue"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total room service revenue including food, delivery charges, service charges, and taxes. Top-line KPI for in-room dining."
    - name: "total_subtotal_revenue"
      expr: SUM(CAST(subtotal_amount AS DOUBLE))
      comment: "Net room service revenue before delivery charges, service charges, and taxes."
    - name: "total_delivery_charge"
      expr: SUM(CAST(delivery_charge AS DOUBLE))
      comment: "Total delivery charges collected. Tracks delivery fee revenue and cost recovery."
    - name: "total_service_charge"
      expr: SUM(CAST(service_charge AS DOUBLE))
      comment: "Total service charges on room service orders. Validates service charge policy application."
    - name: "total_gratuity"
      expr: SUM(CAST(gratuity_amount AS DOUBLE))
      comment: "Total gratuity collected on room service orders. Indicator of guest satisfaction with in-room dining service."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discounts applied to room service orders. Tracks promotional and loyalty discount spend."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax collected on room service orders for tax compliance reporting."
    - name: "order_count"
      expr: COUNT(1)
      comment: "Total number of room service orders. Volume baseline for throughput and staffing analysis."
    - name: "avg_order_value"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average room service order value. Benchmarked against targets to assess upsell effectiveness."
    - name: "on_time_delivery_count"
      expr: SUM(CASE WHEN on_time_delivery_flag = True THEN 1 ELSE 0 END)
      comment: "Count of orders delivered on time. Numerator for on-time delivery rate calculation."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN on_time_delivery_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of room service orders delivered within the promised time window. Critical guest satisfaction and operational KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_stock_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B inventory stock movement metrics covering cost of goods, waste, variance, and inventory flow. Enables food cost control, waste reduction, and supply chain efficiency decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`stock_transaction`"
  filter: transaction_status != 'REVERSED'
  dimensions:
    - name: "transaction_date"
      expr: transaction_date
      comment: "Date of the stock transaction for daily inventory movement and cost trend analysis."
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of stock movement (Purchase, Transfer, Waste, Adjustment, Issue) for inventory flow categorization."
    - name: "transaction_status"
      expr: transaction_status
      comment: "Status of the stock transaction (Posted, Pending, Reversed) for reconciliation and audit."
    - name: "waste_category"
      expr: waste_category
      comment: "Category of waste (Spoilage, Over-production, Breakage) for waste root-cause analysis."
    - name: "waste_reason"
      expr: waste_reason
      comment: "Specific reason for waste to drive targeted waste reduction initiatives."
    - name: "meal_period"
      expr: meal_period
      comment: "Meal period associated with the stock transaction for daypart cost analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity reporting consistency."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency cost reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for portfolio-level inventory cost benchmarking."
    - name: "inventory_item_id"
      expr: inventory_item_id
      comment: "Inventory item foreign key for item-level cost and movement analysis."
  measures:
    - name: "total_stock_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total cost of all stock movements. Primary cost-of-goods metric for F&B cost control and P&L reporting."
    - name: "total_quantity_moved"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of stock moved across all transaction types. Used for inventory throughput and depletion analysis."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total inventory variance amount (actual vs. theoretical). Key KPI for shrinkage, theft, and process control."
    - name: "avg_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average unit cost across stock transactions. Used for cost trend monitoring and supplier price benchmarking."
    - name: "waste_transaction_count"
      expr: SUM(CASE WHEN waste_category IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of waste-related stock transactions. Tracks waste event frequency for operational improvement."
    - name: "total_waste_cost"
      expr: SUM(CASE WHEN waste_category IS NOT NULL THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of wasted inventory. Direct measure of waste financial impact for cost reduction programs."
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Total number of stock transactions. Volume baseline for inventory activity and audit trail completeness."
    - name: "distinct_items_transacted"
      expr: COUNT(DISTINCT inventory_item_id)
      comment: "Number of distinct inventory items with stock movements. Measures inventory breadth and active item utilization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_food_safety_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food safety compliance and inspection performance metrics. Enables risk management, regulatory compliance tracking, and corrective action monitoring across F&B outlets and properties."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`food_safety_inspection`"
  dimensions:
    - name: "inspection_date"
      expr: inspection_date
      comment: "Date of the food safety inspection for trend and compliance timeline analysis."
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (Routine, Follow-up, Complaint-driven) for inspection program analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (Completed, Pending, In-Progress) for workflow monitoring."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance outcome (Compliant, Non-Compliant, Conditional) for risk flagging."
    - name: "inspection_grade"
      expr: inspection_grade
      comment: "Letter or numeric grade assigned by the inspector. Key public-facing compliance indicator."
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Governing body conducting the inspection for multi-jurisdiction compliance tracking."
    - name: "haccp_compliance_flag"
      expr: haccp_compliance_flag
      comment: "HACCP compliance status flag for food safety management system adherence."
    - name: "iso_22000_compliance_flag"
      expr: iso_22000_compliance_flag
      comment: "ISO 22000 compliance flag for international food safety standard adherence."
    - name: "reinspection_required_flag"
      expr: reinspection_required_flag
      comment: "Flag indicating a reinspection is required. Tracks outstanding compliance obligations."
    - name: "corrective_actions_required"
      expr: corrective_actions_required
      comment: "Flag indicating corrective actions were mandated. Used for remediation workload planning."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet for outlet-level compliance performance tracking."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for portfolio-level food safety risk reporting."
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of food safety inspections conducted. Baseline for compliance program coverage and frequency analysis."
    - name: "avg_inspection_score"
      expr: AVG(CAST(inspection_score AS DOUBLE))
      comment: "Average food safety inspection score. Primary KPI for overall food safety performance benchmarking."
    - name: "min_inspection_score"
      expr: MIN(CAST(inspection_score AS DOUBLE))
      comment: "Lowest inspection score recorded. Identifies worst-performing outlets requiring urgent intervention."
    - name: "non_compliant_inspection_count"
      expr: SUM(CASE WHEN compliance_status = 'Non-Compliant' THEN 1 ELSE 0 END)
      comment: "Count of inspections resulting in non-compliance. Key risk metric for regulatory exposure and brand reputation."
    - name: "compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections achieving compliant status. Executive-level food safety KPI for risk governance."
    - name: "reinspection_required_count"
      expr: SUM(CASE WHEN reinspection_required_flag = True THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring reinspection. Tracks outstanding regulatory obligations and remediation backlog."
    - name: "haccp_compliant_count"
      expr: SUM(CASE WHEN haccp_compliance_flag = True THEN 1 ELSE 0 END)
      comment: "Count of inspections with HACCP compliance confirmed. Measures HACCP program effectiveness across outlets."
    - name: "haccp_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN haccp_compliance_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inspections achieving HACCP compliance. Critical food safety management KPI for regulatory and brand risk."
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_actions_required = True THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring corrective actions. Tracks remediation workload and systemic food safety gaps."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_inventory_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B inventory master metrics covering stock valuation, cost benchmarking, dietary compliance, and reorder management. Enables procurement, cost control, and menu compliance decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`inventory_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level category of the inventory item (Food, Beverage, Dry Goods) for category-level cost analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category for granular inventory classification and cost benchmarking."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the inventory item (Active, Discontinued, On-Hold) for active inventory management."
    - name: "alcohol_flag"
      expr: alcohol_flag
      comment: "Flag indicating alcoholic items for beverage cost and compliance segregation."
    - name: "allergen_flag"
      expr: allergen_flag
      comment: "Flag indicating items with allergens for food safety and menu labeling compliance."
    - name: "halal_certified_flag"
      expr: halal_certified_flag
      comment: "Halal certification flag for dietary compliance reporting and guest accommodation."
    - name: "kosher_certified_flag"
      expr: kosher_certified_flag
      comment: "Kosher certification flag for dietary compliance reporting."
    - name: "organic_flag"
      expr: organic_flag
      comment: "Organic sourcing flag for sustainability and premium positioning reporting."
    - name: "local_sourced_flag"
      expr: local_sourced_flag
      comment: "Local sourcing flag for sustainability KPIs and farm-to-table program tracking."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Flag for items requiring temperature-controlled storage for food safety compliance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for inventory quantity standardization."
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location for inventory placement and retrieval efficiency."
  measures:
    - name: "total_inventory_value_on_hand"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE) * CAST(standard_cost AS DOUBLE))
      comment: "Total value of current on-hand inventory (quantity × standard cost). Primary balance sheet and working capital KPI."
    - name: "total_on_hand_quantity"
      expr: SUM(CAST(current_on_hand_quantity AS DOUBLE))
      comment: "Total on-hand quantity across all active inventory items. Used for stock coverage and reorder planning."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per inventory item. Used for cost benchmarking and supplier negotiation."
    - name: "avg_last_purchase_cost"
      expr: AVG(CAST(last_purchase_cost AS DOUBLE))
      comment: "Average last purchase cost. Compared against standard cost to identify cost drift and procurement efficiency."
    - name: "items_below_par_count"
      expr: SUM(CASE WHEN CAST(current_on_hand_quantity AS DOUBLE) < CAST(par_level AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of inventory items currently below par level. Operational KPI for stockout risk and procurement urgency."
    - name: "items_below_reorder_point_count"
      expr: SUM(CASE WHEN CAST(current_on_hand_quantity AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 ELSE 0 END)
      comment: "Count of items at or below reorder point. Triggers procurement action to prevent service disruption."
    - name: "active_item_count"
      expr: COUNT(1)
      comment: "Total count of active inventory items. Baseline for inventory breadth and SKU rationalization analysis."
    - name: "avg_yield_percent"
      expr: AVG(CAST(yield_percent AS DOUBLE))
      comment: "Average yield percentage across inventory items. Used for recipe costing accuracy and waste reduction."
    - name: "local_sourced_item_count"
      expr: SUM(CASE WHEN local_sourced_flag = True THEN 1 ELSE 0 END)
      comment: "Count of locally sourced inventory items. Tracks sustainability program progress and local procurement commitments."
    - name: "local_sourced_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN local_sourced_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active inventory items that are locally sourced. Executive sustainability KPI for ESG reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_menu_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Menu item master metrics for menu engineering, pricing analysis, dietary compliance, and margin performance. Enables data-driven menu optimization and pricing strategy decisions."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`menu_item`"
  filter: item_status = 'ACTIVE'
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "High-level menu item category (Appetizer, Main, Dessert, Beverage) for category mix analysis."
    - name: "item_subcategory"
      expr: item_subcategory
      comment: "Sub-category for granular menu engineering and pricing analysis."
    - name: "menu_section"
      expr: menu_section
      comment: "Section of the menu where the item appears for menu layout and upsell analysis."
    - name: "item_status"
      expr: item_status
      comment: "Current status of the menu item (Active, Inactive, Seasonal) for active menu management."
    - name: "is_signature_item"
      expr: is_signature_item
      comment: "Flag for signature/hero items. Used to track performance of brand-defining menu items."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Seasonal item flag for seasonal menu planning and availability management."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Vegan flag for dietary compliance and plant-based menu mix reporting."
    - name: "is_vegetarian"
      expr: is_vegetarian
      comment: "Vegetarian flag for dietary accommodation and menu diversity reporting."
    - name: "is_halal"
      expr: is_halal
      comment: "Halal flag for dietary compliance and guest accommodation reporting."
    - name: "is_gluten_free"
      expr: is_gluten_free
      comment: "Gluten-free flag for allergen management and dietary accommodation reporting."
    - name: "is_alcoholic"
      expr: is_alcoholic
      comment: "Alcoholic item flag for beverage revenue mix and compliance reporting."
    - name: "fnb_outlet_id"
      expr: fnb_outlet_id
      comment: "F&B outlet for outlet-level menu composition analysis."
    - name: "menu_id"
      expr: menu_id
      comment: "Menu foreign key for menu-level item composition and pricing analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for price reporting consistency."
  measures:
    - name: "active_menu_item_count"
      expr: COUNT(1)
      comment: "Total count of active menu items. Baseline for menu breadth and SKU rationalization."
    - name: "avg_standard_price"
      expr: AVG(CAST(standard_price AS DOUBLE))
      comment: "Average menu item selling price. Used for pricing tier analysis and competitive benchmarking."
    - name: "avg_cost_price"
      expr: AVG(CAST(cost_price AS DOUBLE))
      comment: "Average menu item cost price. Used for food cost benchmarking and recipe costing validation."
    - name: "avg_gross_margin_pct"
      expr: AVG(CAST(gross_margin_percent AS DOUBLE))
      comment: "Average gross margin percentage across menu items. Key menu engineering KPI for profitability optimization."
    - name: "total_menu_revenue_potential"
      expr: SUM(CAST(standard_price AS DOUBLE))
      comment: "Sum of all standard prices across active menu items. Proxy for menu revenue ceiling and pricing strategy scope."
    - name: "signature_item_count"
      expr: SUM(CASE WHEN is_signature_item = True THEN 1 ELSE 0 END)
      comment: "Count of signature/hero menu items. Tracks brand differentiation through menu composition."
    - name: "dietary_compliant_item_count"
      expr: SUM(CASE WHEN is_vegan = True OR is_vegetarian = True OR is_halal = True OR is_gluten_free = True THEN 1 ELSE 0 END)
      comment: "Count of items meeting at least one dietary compliance standard. Measures menu inclusivity for diverse guest needs."
    - name: "dietary_compliant_item_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_vegan = True OR is_vegetarian = True OR is_halal = True OR is_gluten_free = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active menu items meeting at least one dietary compliance standard. Executive KPI for guest inclusivity and market positioning."
    - name: "high_margin_item_count"
      expr: SUM(CASE WHEN CAST(gross_margin_percent AS DOUBLE) >= 70.0 THEN 1 ELSE 0 END)
      comment: "Count of menu items with gross margin at or above 70%. Used to identify and promote star items in menu engineering."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`fnb_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "F&B outlet master metrics for portfolio management, capacity planning, compliance tracking, and operational benchmarking. Enables strategic decisions on outlet investment, renovation, and certification."
  source: "`vibe_travel_hospitality_v1`.`fnb`.`fnb_outlet`"
  filter: outlet_status = 'ACTIVE'
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of F&B outlet (Restaurant, Bar, Café, Banquet) for portfolio mix analysis."
    - name: "cuisine_category"
      expr: cuisine_category
      comment: "Cuisine category for market positioning and guest preference analysis."
    - name: "service_style"
      expr: service_style
      comment: "Service style (Fine Dining, Casual, Buffet, Quick Service) for operational benchmarking."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (Active, Closed, Renovation) for portfolio health monitoring."
    - name: "accepts_reservations_flag"
      expr: accepts_reservations_flag
      comment: "Flag indicating whether the outlet accepts reservations for capacity and demand management."
    - name: "iso_22000_certified_flag"
      expr: iso_22000_certified_flag
      comment: "ISO 22000 food safety certification flag for compliance portfolio reporting."
    - name: "ada_compliant_flag"
      expr: ada_compliant_flag
      comment: "ADA accessibility compliance flag for regulatory and inclusivity reporting."
    - name: "property_id"
      expr: property_id
      comment: "Property identifier for portfolio-level outlet benchmarking."
  measures:
    - name: "active_outlet_count"
      expr: COUNT(1)
      comment: "Total count of active F&B outlets. Portfolio baseline for capacity and investment planning."
    - name: "avg_check_target"
      expr: AVG(CAST(average_check_target AS DOUBLE))
      comment: "Average check target across outlets. Used to benchmark actual average check performance against management targets."
    - name: "avg_food_cost_target_pct"
      expr: AVG(CAST(food_cost_percentage_target AS DOUBLE))
      comment: "Average food cost percentage target across outlets. Baseline for food cost performance benchmarking."
    - name: "avg_beverage_cost_target_pct"
      expr: AVG(CAST(beverage_cost_percentage_target AS DOUBLE))
      comment: "Average beverage cost percentage target across outlets. Baseline for beverage cost performance benchmarking."
    - name: "iso_22000_certified_outlet_count"
      expr: SUM(CASE WHEN iso_22000_certified_flag = True THEN 1 ELSE 0 END)
      comment: "Count of outlets with active ISO 22000 food safety certification. Tracks food safety certification coverage."
    - name: "iso_22000_certification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN iso_22000_certified_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of active outlets with ISO 22000 certification. Executive KPI for food safety governance and brand risk."
    - name: "avg_weekday_operating_hours"
      expr: AVG(CAST(operating_hours_weekday AS DOUBLE))
      comment: "Average weekday operating hours across outlets. Used for labor scheduling and revenue opportunity analysis."
    - name: "avg_weekend_operating_hours"
      expr: AVG(CAST(operating_hours_weekend AS DOUBLE))
      comment: "Average weekend operating hours across outlets. Benchmarks weekend service coverage against demand patterns."
$$;