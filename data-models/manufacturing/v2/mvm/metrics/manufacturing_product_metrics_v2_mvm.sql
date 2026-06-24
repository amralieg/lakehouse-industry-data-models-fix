-- Metric views for domain: product | Business: Manufacturing | Version: 2 | Generated on: 2026-06-24 10:21:17

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the SKU master catalog — covers portfolio composition, cost structure, weight/volume profile, and lifecycle health. Used by product management, supply chain, and finance to steer portfolio decisions."
  source: "`vibe_manufacturing_v1`.`product`.`sku_master`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g. Active, Discontinued, End-of-Life). Primary filter for portfolio health analysis."
    - name: "product_type"
      expr: product_type
      comment: "Classification of the SKU by product type. Used to segment portfolio metrics by product category."
    - name: "make_or_buy_code"
      expr: make_or_buy_code
      comment: "Indicates whether the SKU is manufactured in-house or procured externally. Drives make-vs-buy strategic analysis."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification of the SKU. Used to prioritize focus on high-value (A) vs low-value (C) items."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Relevant for trade compliance and supply risk analysis."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the SKU is classified as hazardous material. Used for compliance and logistics segmentation."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective. Used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to track portfolio retirement trends."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_master_id END)
      comment: "Count of SKUs currently in Active lifecycle status. Core portfolio health KPI — executives track this to understand the size of the live product catalog."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total number of SKU records in the master catalog. Baseline portfolio size metric used for portfolio rationalization decisions."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all SKUs. Represents the total theoretical cost exposure of the product portfolio — used in cost management and margin planning."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU. Benchmarks cost levels across product types and lifecycle stages to identify cost outliers."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight AS DOUBLE))
      comment: "Average gross weight (kg) per SKU. Used in logistics planning and freight cost estimation at the portfolio level."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight (kg) per SKU. Supports packaging design and material cost analysis."
    - name: "avg_volume"
      expr: AVG(CAST(volume AS DOUBLE))
      comment: "Average volume per SKU. Used in warehouse slotting, packaging, and transportation planning."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN sku_master_id END)
      comment: "Number of SKUs classified as hazardous materials. Tracks compliance exposure and logistics complexity in the portfolio."
    - name: "lot_controlled_sku_count"
      expr: COUNT(CASE WHEN lot_control_required = TRUE THEN sku_master_id END)
      comment: "Number of SKUs requiring lot control. Indicates traceability and quality management complexity in the portfolio."
    - name: "serial_controlled_sku_count"
      expr: COUNT(CASE WHEN serial_control_required = TRUE THEN sku_master_id END)
      comment: "Number of SKUs requiring serial number control. Reflects high-value or regulated product exposure requiring individual unit traceability."
    - name: "active_sku_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_master_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of SKUs in Active lifecycle status. Portfolio vitality KPI — a declining ratio signals excessive legacy product drag and triggers rationalization reviews."
    - name: "make_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Make' THEN sku_master_id END)
      comment: "Number of SKUs manufactured in-house. Used in capacity planning and make-vs-buy strategic decisions."
    - name: "buy_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Buy' THEN sku_master_id END)
      comment: "Number of SKUs procured externally. Used to assess supply chain dependency and outsourcing exposure."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_catalog_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial product catalog KPIs covering pricing, availability, lifecycle, and compliance. Used by sales, product management, and pricing teams to manage the sellable product portfolio."
  source: "`vibe_manufacturing_v1`.`product`.`catalog_entry`"
  dimensions:
    - name: "catalog_status"
      expr: catalog_status
      comment: "Current status of the catalog entry (e.g. Active, Inactive, Discontinued). Primary dimension for catalog health segmentation."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage in the commercial catalog (e.g. Introduction, Growth, Maturity, Decline). Used for portfolio strategy analysis."
    - name: "product_category"
      expr: product_category
      comment: "Commercial product category. Used to segment pricing and availability metrics by category."
    - name: "sales_channel"
      expr: sales_channel
      comment: "Sales channel through which the catalog entry is sold. Used to analyze pricing and availability by channel."
    - name: "sales_organization"
      expr: sales_organization
      comment: "Sales organization responsible for the catalog entry. Used for regional and organizational performance segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the catalog entry. Used for trade compliance and regional availability analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating hazardous material classification. Used to segment compliance-sensitive catalog entries."
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Boolean flag indicating whether the catalog entry is currently orderable. Key availability dimension for sales operations."
    - name: "oem_offering_flag"
      expr: oem_offering_flag
      comment: "Boolean flag indicating OEM product offerings. Used to segment OEM vs standard commercial catalog analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the catalog entry became effective. Used to track new product introduction cadence."
  measures:
    - name: "total_catalog_entries"
      expr: COUNT(1)
      comment: "Total number of catalog entries. Baseline measure for catalog portfolio size — used in portfolio rationalization and coverage analysis."
    - name: "orderable_catalog_entries"
      expr: COUNT(CASE WHEN orderable_flag = TRUE THEN catalog_entry_id END)
      comment: "Number of catalog entries currently available for ordering. Directly measures commercial availability — a drop triggers sales and supply chain investigation."
    - name: "orderable_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN orderable_flag = TRUE THEN catalog_entry_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of catalog entries that are orderable. Catalog availability health KPI — executives use this to assess commercial readiness of the product portfolio."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across catalog entries. Used in pricing strategy reviews and competitive benchmarking."
    - name: "total_list_price_value"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Sum of list prices across all catalog entries. Represents the total theoretical revenue ceiling of the catalog — used in pricing and revenue planning."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across catalog entries. Used in sales operations and customer experience analysis — high MOQ can suppress order conversion."
    - name: "distinct_product_categories"
      expr: COUNT(DISTINCT product_category)
      comment: "Number of distinct product categories in the catalog. Measures portfolio breadth — used in market coverage and category management decisions."
    - name: "distinct_sales_channels"
      expr: COUNT(DISTINCT sales_channel)
      comment: "Number of distinct sales channels represented in the catalog. Measures go-to-market channel diversity — used in channel strategy reviews."
    - name: "hazmat_catalog_entries"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN catalog_entry_id END)
      comment: "Number of catalog entries classified as hazardous materials. Tracks compliance and logistics complexity exposure in the commercial catalog."
    - name: "active_lifecycle_entries"
      expr: COUNT(CASE WHEN lifecycle_stage NOT IN ('Discontinued', 'End-of-Life', 'Obsolete') THEN catalog_entry_id END)
      comment: "Number of catalog entries not in end-of-life lifecycle stages. Measures the commercially viable portion of the catalog for revenue planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_order_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product-level order line KPIs covering revenue, pricing, discounting, fulfillment, and cancellation. Primary commercial performance view used by sales, finance, and operations leadership."
  source: "`vibe_manufacturing_v1`.`product`.`order_line`"
  dimensions:
    - name: "line_status"
      expr: line_status
      comment: "Current status of the order line (e.g. Open, Shipped, Cancelled). Primary operational dimension for order line analysis."
    - name: "order_line_status"
      expr: order_line_status
      comment: "Detailed order line status code. Used for granular fulfillment and backlog analysis."
    - name: "line_type"
      expr: line_type
      comment: "Type classification of the order line (e.g. Standard, Return, Service). Used to segment revenue and volume metrics by transaction type."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the order line is denominated. Used for multi-currency revenue analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the ordered quantity. Used to normalize volume metrics across product lines."
    - name: "backorder_flag"
      expr: backorder_flag
      comment: "Boolean flag indicating whether the order line is on backorder. Key supply-demand gap indicator for operations."
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Boolean flag indicating whether the order line has been cancelled. Used to segment cancellation analysis."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status of the order line. Used to track fulfillment performance and identify delivery bottlenecks."
    - name: "confirmed_delivery_date"
      expr: DATE_TRUNC('month', confirmed_delivery_date)
      comment: "Month of confirmed delivery date. Used to analyze delivery commitments and fulfillment trends over time."
    - name: "requested_delivery_date"
      expr: DATE_TRUNC('month', requested_delivery_date)
      comment: "Month of customer-requested delivery date. Used to analyze demand timing and delivery lead time performance."
    - name: "created_timestamp"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the order line was created. Used for order intake trend analysis."
  measures:
    - name: "total_net_revenue"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net revenue across all order lines. Primary top-line revenue KPI — used in every financial review and steering meeting."
    - name: "total_gross_revenue"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross revenue before discounts and adjustments. Used alongside net revenue to measure discount impact at portfolio level."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount value granted across order lines. Tracks pricing discipline — excessive discounting triggers pricing strategy reviews."
    - name: "avg_discount_percent"
      expr: AVG(CAST(discount_percent AS DOUBLE))
      comment: "Average discount percentage across order lines. Measures pricing discipline and discount depth — used in margin management and sales incentive reviews."
    - name: "total_ordered_quantity"
      expr: SUM(CAST(ordered_quantity AS DOUBLE))
      comment: "Total quantity ordered across all order lines. Volume KPI used in demand planning, capacity management, and sales performance reviews."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped across all order lines. Measures actual fulfillment output — compared against ordered quantity to compute fill rate."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity on backorder. Measures supply-demand gap — a rising backorder quantity triggers supply chain escalation."
    - name: "total_open_quantity"
      expr: SUM(CAST(open_quantity AS DOUBLE))
      comment: "Total open (unfulfilled) quantity across order lines. Represents the current order backlog — used in production scheduling and capacity planning."
    - name: "order_line_fill_rate"
      expr: ROUND(100.0 * SUM(CAST(shipped_quantity AS DOUBLE)) / NULLIF(SUM(CAST(ordered_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of ordered quantity that has been shipped. Core fulfillment KPI — directly tied to customer satisfaction and revenue realization."
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_cancelled = TRUE THEN order_line_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines that have been cancelled. Measures demand leakage — a rising cancellation rate triggers investigation into pricing, availability, or customer experience issues."
    - name: "backorder_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN backorder_flag = TRUE THEN order_line_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of order lines on backorder. Supply availability KPI — directly tied to customer service levels and revenue at risk."
    - name: "avg_net_price_per_unit"
      expr: AVG(CAST(unit_net_price AS DOUBLE))
      comment: "Average net price per unit across order lines. Used in pricing analysis and revenue per unit benchmarking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across order lines. Used in financial reporting and tax liability management."
    - name: "total_order_lines"
      expr: COUNT(1)
      comment: "Total number of order lines. Baseline volume metric used to normalize other KPIs and track order activity levels."
    - name: "distinct_skus_ordered"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs appearing in order lines. Measures product portfolio demand breadth — used in assortment and portfolio strategy decisions."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials header KPIs covering BOM portfolio health, compliance, configurability, and engineering change activity. Used by engineering, manufacturing, and compliance teams to govern product structure integrity."
  source: "`vibe_manufacturing_v1`.`product`.`bom_header`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g. Active, Inactive, Under Review). Primary dimension for BOM portfolio health analysis."
    - name: "bom_type"
      expr: bom_type
      comment: "Type classification of the BOM (e.g. Production, Engineering, Sales). Used to segment BOM metrics by usage context."
    - name: "bom_usage"
      expr: bom_usage
      comment: "Intended usage of the BOM (e.g. Production, Costing, Engineering). Used to filter BOM analysis by operational context."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM. Used for portfolio segmentation in engineering and manufacturing reviews."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Boolean flag indicating whether the BOM supports product configuration. Used to segment configurable vs standard product BOMs."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating whether the BOM is classified as critical. Used to prioritize BOM governance and change control activities."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Boolean flag indicating environmental compliance status of the BOM. Used in sustainability and regulatory reporting."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating regulatory compliance status of the BOM. Used in compliance audits and risk management."
    - name: "erp_system_code"
      expr: erp_system_code
      comment: "Source ERP system code for the BOM. Used to segment BOM data quality and coverage by system of record."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the BOM became effective. Used to track BOM introduction and revision cadence over time."
    - name: "approval_date"
      expr: DATE_TRUNC('month', approval_date)
      comment: "Month the BOM was approved. Used to track engineering approval throughput and cycle time trends."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of BOM headers. Baseline measure for BOM portfolio size — used in engineering governance and data quality reviews."
    - name: "active_boms"
      expr: COUNT(CASE WHEN bom_status = 'Active' THEN bom_header_id END)
      comment: "Number of BOMs in Active status. Core BOM portfolio health KPI — used to track the size of the production-ready BOM library."
    - name: "active_bom_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN bom_status = 'Active' THEN bom_header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs in Active status. BOM portfolio vitality KPI — a declining ratio signals BOM governance issues or excessive legacy structure debt."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN bom_header_id END)
      comment: "Number of BOMs flagged as critical. Used to prioritize change control, compliance review, and risk management activities."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN bom_header_id END)
      comment: "Number of configurable BOMs. Measures product configuration complexity — used in variant management and CPQ strategy decisions."
    - name: "environmental_compliant_bom_count"
      expr: COUNT(CASE WHEN environmental_compliance_flag = TRUE THEN bom_header_id END)
      comment: "Number of BOMs meeting environmental compliance requirements. Tracks sustainability compliance coverage across the product structure portfolio."
    - name: "regulatory_compliant_bom_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN bom_header_id END)
      comment: "Number of BOMs meeting regulatory compliance requirements. Critical compliance KPI — used in regulatory audits and risk reporting."
    - name: "environmental_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN environmental_compliance_flag = TRUE THEN bom_header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs with environmental compliance flag set. Sustainability governance KPI — used in ESG reporting and regulatory risk management."
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN bom_header_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOMs with regulatory compliance flag set. Compliance coverage KPI — a declining rate triggers immediate regulatory risk escalation."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM. Used in production planning and material requirements analysis."
    - name: "distinct_products_with_bom"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with at least one BOM header. Measures BOM coverage of the product portfolio — gaps indicate products not yet structured for manufacturing."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials line-level KPIs covering component usage, scrap, critical components, and BOM structure complexity. Used by engineering, manufacturing engineering, and cost management teams."
  source: "`vibe_manufacturing_v1`.`product`.`product_bom_line`"
  dimensions:
    - name: "product_bom_line_status"
      expr: product_bom_line_status
      comment: "Current status of the BOM line item. Used to filter active vs inactive component assignments."
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (e.g. Stock, Non-Stock, Phantom). Used to segment component analysis by procurement and planning category."
    - name: "component_origin"
      expr: component_origin
      comment: "Origin classification of the component (e.g. Internal, External, Subcontracted). Used in make-vs-buy and supply chain risk analysis."
    - name: "assembly_level"
      expr: assembly_level
      comment: "Level of the component within the BOM assembly hierarchy. Used to analyze BOM depth and complexity."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Boolean flag indicating whether the component is critical to the assembly. Used to prioritize supply chain risk management and safety stock decisions."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Boolean flag indicating whether the component is backflushed in production. Used in production control and inventory accuracy analysis."
    - name: "spare_part_indicator"
      expr: spare_part_indicator
      comment: "Boolean flag indicating whether the component is also a spare part. Used in aftermarket and service parts planning."
    - name: "cost_relevance_indicator"
      expr: cost_relevance_indicator
      comment: "Boolean flag indicating whether the component is cost-relevant. Used to focus cost reduction efforts on material cost drivers."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the BOM line became effective. Used to track component introduction and engineering change activity over time."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total number of BOM line items. Measures BOM structure complexity and component portfolio size — used in engineering governance and PLM data quality reviews."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN product_bom_line_id END)
      comment: "Number of BOM lines flagged as critical components. Used to quantify supply chain risk exposure — critical components require priority sourcing and safety stock strategies."
    - name: "critical_component_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN critical_component_flag = TRUE THEN product_bom_line_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOM lines classified as critical components. Risk concentration KPI — a high ratio signals elevated supply chain vulnerability requiring strategic sourcing action."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity required per assembly. Used in material requirements planning and production cost estimation."
    - name: "total_quantity_per_assembly"
      expr: SUM(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Total component quantity across all BOM lines. Represents aggregate material demand — used in procurement planning and supplier capacity negotiations."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines. Measures material waste embedded in product structures — a key cost reduction lever in manufacturing operations."
    - name: "high_scrap_component_count"
      expr: COUNT(CASE WHEN scrap_factor_percent > 5 THEN product_bom_line_id END)
      comment: "Number of BOM lines with scrap factor above 5%. Identifies high-waste components for targeted process improvement and cost reduction initiatives."
    - name: "avg_component_weight_kg"
      expr: AVG(CAST(component_weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms. Used in product weight optimization, logistics planning, and material cost analysis."
    - name: "distinct_skus_with_bom_lines"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with active BOM line assignments. Measures BOM completeness across the product portfolio — gaps indicate unstructured products that cannot be manufactured."
    - name: "spare_part_component_count"
      expr: COUNT(CASE WHEN spare_part_indicator = TRUE THEN product_bom_line_id END)
      comment: "Number of BOM lines also designated as spare parts. Used in aftermarket service planning and spare parts inventory strategy."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification KPIs covering technical parameter coverage, compliance, environmental ratings, and specification lifecycle health. Used by engineering, quality, and regulatory teams to govern product technical integrity."
  source: "`vibe_manufacturing_v1`.`product`.`product_specification`"
  dimensions:
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of the product specification (e.g. Active, Draft, Obsolete). Primary dimension for specification portfolio health analysis."
    - name: "specification_type"
      expr: specification_type
      comment: "Type classification of the specification (e.g. Mechanical, Electrical, Environmental). Used to segment technical KPIs by engineering discipline."
    - name: "application_suitability"
      expr: application_suitability
      comment: "Application suitability classification of the specification. Used to segment products by intended use environment."
    - name: "mounting_type"
      expr: mounting_type
      comment: "Mounting type of the product. Used in product design and application engineering analysis."
    - name: "ip_rating"
      expr: ip_rating
      comment: "Ingress Protection (IP) rating of the product. Used to segment products by environmental protection level for market and compliance analysis."
    - name: "nema_rating"
      expr: nema_rating
      comment: "NEMA enclosure rating of the product. Used in compliance and application suitability analysis for industrial markets."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the specification became effective. Used to track specification release cadence and engineering productivity."
    - name: "approved_date"
      expr: DATE_TRUNC('month', approved_date)
      comment: "Month the specification was approved. Used to track approval throughput and engineering change cycle times."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of product specifications. Baseline measure for specification portfolio size — used in PLM governance and data quality reviews."
    - name: "active_specifications"
      expr: COUNT(CASE WHEN specification_status = 'Active' THEN product_specification_id END)
      comment: "Number of specifications in Active status. Core specification portfolio health KPI — used to track the size of the current approved technical specification library."
    - name: "active_specification_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN specification_status = 'Active' THEN product_specification_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of specifications in Active status. Specification portfolio vitality KPI — a declining ratio signals specification debt and engineering governance issues."
    - name: "avg_power_rating_watts"
      expr: AVG(CAST(power_rating_watts AS DOUBLE))
      comment: "Average power rating (watts) across product specifications. Used in energy efficiency analysis, product positioning, and regulatory compliance reporting."
    - name: "avg_operating_temp_max_c"
      expr: AVG(CAST(operating_temperature_max_c AS DOUBLE))
      comment: "Average maximum operating temperature (°C) across specifications. Used in product application suitability analysis and market segmentation by operating environment."
    - name: "avg_operating_temp_min_c"
      expr: AVG(CAST(operating_temperature_min_c AS DOUBLE))
      comment: "Average minimum operating temperature (°C) across specifications. Used alongside max temperature to characterize the thermal operating envelope of the product portfolio."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average product weight (kg) from specifications. Used in logistics planning, packaging design, and product weight optimization initiatives."
    - name: "avg_current_rating_amperes"
      expr: AVG(CAST(current_rating_amperes AS DOUBLE))
      comment: "Average current rating (amperes) across electrical product specifications. Used in product line positioning and electrical compliance analysis."
    - name: "avg_humidity_rating_percent"
      expr: AVG(CAST(humidity_rating_percent AS DOUBLE))
      comment: "Average humidity rating (%) across specifications. Used in environmental suitability analysis and product positioning for harsh-environment markets."
    - name: "distinct_skus_with_specifications"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with at least one product specification. Measures specification coverage of the product portfolio — gaps indicate products lacking formal technical documentation."
    - name: "avg_vibration_resistance"
      expr: AVG(CAST(vibration_resistance AS DOUBLE))
      comment: "Average vibration resistance rating across specifications. Used in product qualification for industrial and harsh-environment applications."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant-level product planning KPIs covering inventory policy, lot sizing, safety stock, and MRP configuration. Used by supply chain planners, production schedulers, and plant managers to optimize material planning parameters."
  source: "`vibe_manufacturing_v1`.`product`.`plant_data`"
  dimensions:
    - name: "plant_code"
      expr: plant_code
      comment: "Plant identifier. Primary dimension for segmenting planning KPIs by manufacturing location."
    - name: "plant_status"
      expr: plant_status
      comment: "Current status of the plant-material record. Used to filter active vs inactive planning records."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type for the material at this plant (e.g. MRP, Reorder Point, Consumption-Based). Used to segment planning policy analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for the material at this plant (e.g. In-House Production, External Procurement). Used in make-vs-buy and supply chain strategy analysis."
    - name: "lot_size_procedure"
      expr: lot_size_procedure
      comment: "Lot sizing procedure applied to the material (e.g. Fixed, Economic, Lot-for-Lot). Used to analyze inventory policy configuration across the plant portfolio."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification indicator for the material at this plant. Used to prioritize planning attention on high-value (A) materials."
    - name: "batch_management_required"
      expr: batch_management_required
      comment: "Boolean flag indicating whether batch management is required. Used to segment materials requiring traceability and quality management."
    - name: "negative_stock_allowed"
      expr: negative_stock_allowed
      comment: "Boolean flag indicating whether negative stock is permitted. Used to identify planning configuration risks and inventory accuracy issues."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the material was discontinued at this plant. Used to track product phase-out activity and planning record cleanup."
  measures:
    - name: "total_plant_material_records"
      expr: COUNT(1)
      comment: "Total number of plant-material planning records. Baseline measure for planning master data coverage — used in data quality and MRP readiness assessments."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity across plant-material records. Used in inventory investment analysis and service level optimization — high safety stock signals planning inefficiency or supply uncertainty."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all plant-material records. Represents aggregate buffer inventory investment — used in working capital optimization and inventory reduction programs."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across plant-material records. Used to assess inventory replenishment trigger levels and their alignment with demand and lead time parameters."
    - name: "avg_maximum_stock_level"
      expr: AVG(CAST(maximum_stock_level AS DOUBLE))
      comment: "Average maximum stock level across plant-material records. Used in warehouse capacity planning and inventory policy optimization."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across plant-material records. Used in procurement and production planning to assess order flexibility and supplier constraints."
    - name: "avg_fixed_lot_size"
      expr: AVG(CAST(fixed_lot_size AS DOUBLE))
      comment: "Average fixed lot size across plant-material records. Used in production scheduling and procurement planning to understand batch size constraints."
    - name: "avg_shelf_life_expiration_days"
      expr: AVG(CAST(shelf_life_expiration_days AS DOUBLE))
      comment: "Average shelf life expiration days across plant-material records. Used in inventory rotation policy design and obsolescence risk management."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_required = TRUE THEN plant_data_id END)
      comment: "Number of plant-material records requiring batch management. Measures traceability and quality management complexity in the plant portfolio."
    - name: "distinct_plants_with_materials"
      expr: COUNT(DISTINCT plant_code)
      comment: "Number of distinct plants with active material planning records. Measures manufacturing footprint coverage — used in network optimization and plant rationalization decisions."
    - name: "distinct_skus_in_plants"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Number of distinct SKUs with plant-level planning data. Measures MRP master data completeness — gaps indicate materials not yet configured for production planning."
$$;

CREATE OR REPLACE VIEW `vibe_manufacturing_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family portfolio KPIs covering cost structure, reliability, margin targets, and lifecycle health. Used by product line owners, finance, and executive leadership to steer product portfolio strategy."
  source: "`vibe_manufacturing_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the product family (e.g. Active, Declining, End-of-Life). Primary dimension for portfolio health analysis."
    - name: "family_type"
      expr: family_type
      comment: "Type classification of the product family. Used to segment portfolio metrics by family structure."
    - name: "market_segment"
      expr: market_segment
      comment: "Market segment targeted by the product family. Used to analyze portfolio performance and investment by market."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the product family. Used to segment portfolio KPIs by organizational unit for P&L accountability."
    - name: "manufacturing_strategy"
      expr: CAST(manufacturing_strategy AS DOUBLE)
      comment: "Manufacturing strategy score/code for the product family. Used to segment families by production approach."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for the product family. Used in make-vs-buy and supply chain strategy analysis."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Technology platform underlying the product family. Used to segment R&D investment and innovation pipeline analysis."
    - name: "hazardous_material_indicator"
      expr: hazardous_material_indicator
      comment: "Boolean flag indicating whether the product family contains hazardous materials. Used in compliance and logistics segmentation."
    - name: "iot_enabled"
      expr: iot_enabled
      comment: "Boolean flag indicating whether the product family is IoT-enabled. Used to track digital product portfolio growth and smart product strategy execution."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the product family became effective. Used to track portfolio vintage and new family introduction cadence."
  measures:
    - name: "total_product_families"
      expr: COUNT(1)
      comment: "Total number of product families. Baseline portfolio breadth measure — used in portfolio rationalization and market coverage analysis."
    - name: "active_product_families"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN family_id END)
      comment: "Number of product families in Active lifecycle status. Core portfolio health KPI — used to track the size of the commercially active product portfolio."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per product family. Used in cost benchmarking and margin analysis across the product portfolio."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage across product families. Strategic profitability KPI — used in pricing strategy and portfolio investment prioritization."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price across product families. Used in pricing strategy reviews and competitive positioning analysis."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF (Mean Time Between Failures) across product families. Core product reliability KPI — used in quality strategy, warranty cost management, and customer satisfaction decisions."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR (Mean Time To Repair) across product families. Serviceability KPI — used in service strategy, spare parts planning, and customer support cost management."
    - name: "iot_enabled_family_count"
      expr: COUNT(CASE WHEN iot_enabled = TRUE THEN family_id END)
      comment: "Number of IoT-enabled product families. Measures digital product portfolio penetration — used in smart product strategy and digital transformation progress tracking."
    - name: "iot_enabled_ratio"
      expr: ROUND(100.0 * COUNT(CASE WHEN iot_enabled = TRUE THEN family_id END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of product families that are IoT-enabled. Digital portfolio transformation KPI — used in technology strategy reviews and investor communications."
    - name: "distinct_market_segments"
      expr: COUNT(DISTINCT market_segment)
      comment: "Number of distinct market segments served by product families. Measures market coverage breadth — used in go-to-market strategy and portfolio diversification analysis."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all product families. Represents aggregate cost base of the product portfolio — used in cost management and margin planning at the portfolio level."
$$;