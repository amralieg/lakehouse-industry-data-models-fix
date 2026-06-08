-- Metric views for domain: product | Business: Manufacturing | Version: 1 | Generated on: 2026-05-06 09:37:16

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_sku_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the SKU master catalog — covers portfolio composition, cost structure, weight/volume profile, and lifecycle health. Used by product management, supply chain, and finance to steer portfolio rationalization and cost optimization decisions."
  source: "`manufacturing_ecm`.`product`.`sku_master`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the SKU (e.g., Active, Discontinued, End-of-Life). Enables portfolio health segmentation."
    - name: "product_type"
      expr: product_type
      comment: "High-level product type classification (e.g., Finished Good, Semi-Finished, Raw Material). Drives portfolio mix analysis."
    - name: "make_or_buy_code"
      expr: make_or_buy_code
      comment: "Indicates whether the SKU is manufactured in-house or sourced externally. Critical for make-vs-buy strategic decisions."
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC inventory classification (A=high value, B=medium, C=low). Used to prioritize inventory management and cost focus."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced. Supports trade compliance and supply chain risk analysis."
    - name: "hazmat_indicator"
      expr: hazmat_indicator
      comment: "Boolean flag indicating whether the SKU contains hazardous materials. Drives compliance and logistics segmentation."
    - name: "lot_control_required"
      expr: lot_control_required
      comment: "Boolean flag indicating lot traceability requirement. Relevant for quality and regulatory compliance segmentation."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the SKU became effective. Used to track new product introduction cadence over time."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the SKU was discontinued. Used to track portfolio retirement trends."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN sku_master_id END)
      comment: "Count of SKUs currently in Active lifecycle status. Core portfolio size KPI for product management and executive reviews."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total number of SKU records in the master catalog. Baseline portfolio breadth measure."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across all SKUs. Indicates total catalog cost exposure; used in cost reduction and margin management decisions."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU. Benchmarks cost level across product types and lifecycle stages."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight AS DOUBLE))
      comment: "Total gross weight across all SKUs. Informs logistics capacity planning and freight cost estimation."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight AS DOUBLE))
      comment: "Average net weight per SKU. Used to benchmark product weight profiles for packaging and shipping optimization."
    - name: "total_volume"
      expr: SUM(CAST(volume AS DOUBLE))
      comment: "Total volumetric footprint across all SKUs. Supports warehouse space planning and container utilization analysis."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Discontinued' THEN sku_master_id END)
      comment: "Count of discontinued SKUs. Tracks portfolio retirement rate; high values may signal product line rationalization opportunities."
    - name: "hazmat_sku_count"
      expr: COUNT(CASE WHEN hazmat_indicator = TRUE THEN sku_master_id END)
      comment: "Count of SKUs flagged as hazardous materials. Drives compliance cost estimation and logistics risk management."
    - name: "make_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Make' THEN sku_master_id END)
      comment: "Count of SKUs manufactured in-house. Used in capacity planning and make-vs-buy strategic portfolio reviews."
    - name: "buy_sku_count"
      expr: COUNT(CASE WHEN make_or_buy_code = 'Buy' THEN sku_master_id END)
      comment: "Count of externally sourced SKUs. Informs supplier dependency and procurement risk assessments."
    - name: "serial_controlled_sku_count"
      expr: COUNT(CASE WHEN serial_control_required = TRUE THEN sku_master_id END)
      comment: "Count of SKUs requiring serial number control. Indicates traceability overhead and quality management complexity."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the product family hierarchy — covers portfolio structure, pricing, cost, reliability, and lifecycle positioning. Used by product strategy, finance, and R&D leadership to steer portfolio investment and margin decisions."
  source: "`manufacturing_ecm`.`product`.`family`"
  dimensions:
    - name: "family_type"
      expr: family_type
      comment: "Classification of the product family (e.g., Platform, Derivative, Accessory). Drives portfolio structure analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the product family. Enables active vs. retiring portfolio segmentation."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the product family. Supports P&L attribution and investment allocation decisions."
    - name: "market_segment"
      expr: market_segment
      comment: "Target market segment for the product family (e.g., Industrial, Commercial, Residential). Drives go-to-market and revenue mix analysis."
    - name: "manufacturing_strategy"
      expr: manufacturing_strategy
      comment: "Manufacturing approach (e.g., Make-to-Order, Make-to-Stock, Engineer-to-Order). Informs capacity and lead time strategy."
    - name: "technology_platform"
      expr: technology_platform
      comment: "Underlying technology platform of the family. Used to track platform investment concentration and R&D prioritization."
    - name: "innovation_priority"
      expr: innovation_priority
      comment: "Strategic innovation priority level assigned to the family. Guides R&D investment allocation decisions."
    - name: "iot_enabled"
      expr: iot_enabled
      comment: "Boolean flag indicating whether the product family supports IoT connectivity. Tracks digital product portfolio share."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the product family hierarchy. Enables drill-down analysis from portfolio to sub-family."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the product family became effective. Tracks new family introduction cadence."
  measures:
    - name: "total_product_families"
      expr: COUNT(1)
      comment: "Total number of product families in the portfolio. Baseline measure of portfolio breadth for executive reviews."
    - name: "active_family_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN family_id END)
      comment: "Count of product families in Active lifecycle status. Core portfolio health KPI for product strategy leadership."
    - name: "iot_enabled_family_count"
      expr: COUNT(CASE WHEN iot_enabled = TRUE THEN family_id END)
      comment: "Count of product families with IoT capability. Tracks digital transformation progress in the product portfolio."
    - name: "total_list_price"
      expr: SUM(CAST(list_price AS DOUBLE))
      comment: "Sum of list prices across product families. Indicates total addressable revenue potential of the catalog."
    - name: "avg_list_price"
      expr: AVG(CAST(list_price AS DOUBLE))
      comment: "Average list price per product family. Benchmarks pricing level across segments and business units."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard costs across product families. Used in gross margin estimation and cost reduction targeting."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per product family. Benchmarks cost efficiency across technology platforms and business units."
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target gross margin percentage across product families. Key profitability KPI for portfolio steering and pricing strategy."
    - name: "avg_mean_time_between_failures"
      expr: AVG(CAST(mean_time_between_failures AS DOUBLE))
      comment: "Average MTBF across product families. Reliability KPI used by engineering and product management to benchmark quality and warranty risk."
    - name: "avg_mean_time_to_repair"
      expr: AVG(CAST(mean_time_to_repair AS DOUBLE))
      comment: "Average MTTR across product families. Serviceability KPI that informs after-sales cost and customer satisfaction risk."
    - name: "hazardous_family_count"
      expr: COUNT(CASE WHEN hazardous_material_indicator = TRUE THEN family_id END)
      comment: "Count of product families containing hazardous materials. Drives environmental compliance cost and regulatory risk assessment."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_bom_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over BOM headers — covers BOM portfolio complexity, configurability, compliance posture, and lot sizing. Used by engineering, manufacturing, and compliance teams to manage BOM governance and production readiness."
  source: "`manufacturing_ecm`.`product`.`bom_header`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g., Production, Engineering, Sales). Enables segmentation of BOM portfolio by purpose."
    - name: "bom_status"
      expr: bom_status
      comment: "Current status of the BOM (e.g., Active, Obsolete, In Review). Core governance dimension for BOM lifecycle management."
    - name: "bom_category"
      expr: bom_category
      comment: "Category classification of the BOM. Supports portfolio segmentation by product category."
    - name: "bom_usage"
      expr: bom_usage
      comment: "Intended usage context of the BOM (e.g., Production, Costing, Engineering). Drives BOM governance and change management."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Boolean flag indicating whether the BOM supports product configuration. Tracks configurable product portfolio share."
    - name: "is_critical"
      expr: is_critical
      comment: "Boolean flag indicating whether the BOM is critical to production. Prioritizes BOM governance and change control efforts."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Boolean flag indicating environmental compliance status of the BOM. Drives regulatory risk segmentation."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Boolean flag indicating regulatory compliance status of the BOM. Critical for market access and audit readiness."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the BOM became effective. Tracks BOM introduction and change cadence over time."
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion type (e.g., Single-level, Multi-level). Informs manufacturing planning complexity."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of BOM headers. Baseline measure of BOM portfolio size for engineering governance reviews."
    - name: "active_bom_count"
      expr: COUNT(CASE WHEN bom_status = 'Active' THEN bom_header_id END)
      comment: "Count of BOMs in Active status. Core BOM health KPI; declining active BOMs may signal product rationalization or governance gaps."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN bom_header_id END)
      comment: "Count of configurable BOMs. Tracks the share of the portfolio supporting variant/configure-to-order manufacturing."
    - name: "critical_bom_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN bom_header_id END)
      comment: "Count of BOMs flagged as critical. Prioritizes engineering change management and production risk mitigation efforts."
    - name: "non_compliant_bom_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN bom_header_id END)
      comment: "Count of BOMs not meeting regulatory compliance. Directly informs compliance risk exposure and remediation prioritization."
    - name: "environmentally_non_compliant_bom_count"
      expr: COUNT(CASE WHEN environmental_compliance_flag = FALSE THEN bom_header_id END)
      comment: "Count of BOMs failing environmental compliance. Drives sustainability and regulatory risk management decisions."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM. Benchmarks production batch sizing across BOM types and categories."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average lot size across BOMs. Informs production planning efficiency and inventory carrying cost optimization."
    - name: "phantom_bom_count"
      expr: COUNT(CASE WHEN is_phantom = TRUE THEN bom_header_id END)
      comment: "Count of phantom BOMs (virtual assemblies not physically produced). Tracks BOM structural complexity relevant to MRP planning."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over BOM line items — covers component complexity, scrap performance, critical component exposure, and dimensional profile. Used by engineering, procurement, and manufacturing to manage BOM quality, cost, and supply risk."
  source: "`manufacturing_ecm`.`product`.`product_bom_line`"
  dimensions:
    - name: "item_category"
      expr: item_category
      comment: "Category of the BOM line item (e.g., Stock Item, Non-Stock, Service). Drives component sourcing and cost analysis."
    - name: "product_bom_line_status"
      expr: product_bom_line_status
      comment: "Current status of the BOM line (e.g., Active, Obsolete). Enables BOM line governance and cleanup analysis."
    - name: "component_origin"
      expr: component_origin
      comment: "Origin of the component (e.g., Internal, External, Dual-source). Supports supply chain risk and sourcing strategy analysis."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Boolean flag indicating whether the component is critical to the assembly. Prioritizes supply risk mitigation and safety stock decisions."
    - name: "spare_part_indicator"
      expr: spare_part_indicator
      comment: "Boolean flag indicating whether the component is also sold as a spare part. Informs aftermarket revenue and service parts planning."
    - name: "backflush_indicator"
      expr: backflush_indicator
      comment: "Boolean flag indicating whether the component is backflushed in production. Affects inventory accuracy and production cost tracking."
    - name: "bulk_material_indicator"
      expr: bulk_material_indicator
      comment: "Boolean flag indicating bulk material components. Drives material planning and cost allocation decisions."
    - name: "assembly_level"
      expr: assembly_level
      comment: "Level within the BOM assembly hierarchy. Enables multi-level BOM complexity analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the BOM line became effective. Tracks component introduction and engineering change cadence."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total number of BOM line items. Baseline measure of BOM structural complexity across the product portfolio."
    - name: "critical_component_line_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN product_bom_line_id END)
      comment: "Count of BOM lines flagged as critical components. Directly informs supply chain risk exposure and procurement prioritization."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity per assembly. Benchmarks component consumption rates for cost and material planning."
    - name: "total_quantity_per_assembly"
      expr: SUM(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Total component quantity across all BOM lines. Indicates aggregate material demand volume for procurement planning."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor percentage across BOM lines. Key quality and cost KPI — high scrap factors inflate material costs and signal process improvement opportunities."
    - name: "high_scrap_line_count"
      expr: COUNT(CASE WHEN scrap_factor_percent > 5 THEN product_bom_line_id END)
      comment: "Count of BOM lines with scrap factor above 5%. Identifies high-waste components requiring process or design improvement."
    - name: "avg_component_weight_kg"
      expr: AVG(CAST(component_weight_kg AS DOUBLE))
      comment: "Average component weight in kilograms. Informs product weight optimization and logistics cost management."
    - name: "spare_part_line_count"
      expr: COUNT(CASE WHEN spare_part_indicator = TRUE THEN product_bom_line_id END)
      comment: "Count of BOM lines designated as spare parts. Tracks aftermarket service parts portfolio size for service revenue planning."
    - name: "distinct_bom_count"
      expr: COUNT(DISTINCT bom_header_id)
      comment: "Count of distinct BOMs containing at least one line item. Measures active BOM utilization across the product portfolio."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over product certifications — covers compliance coverage, certification cost, expiry risk, and regulatory posture. Used by compliance, legal, and product management to manage market access, regulatory risk, and certification investment."
  source: "`manufacturing_ecm`.`product`.`product_certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Safety, Environmental, Quality, Cybersecurity). Enables compliance portfolio segmentation by regulatory domain."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Pending). Core compliance health dimension."
    - name: "certifying_body"
      expr: certifying_body
      comment: "Organization that issued the certification (e.g., UL, CE, TÜV). Tracks certification authority distribution and renewal relationships."
    - name: "certification_level"
      expr: certification_level
      comment: "Level or tier of the certification. Enables analysis of certification depth across the product portfolio."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "Boolean flag for RoHS compliance. Tracks hazardous substance compliance across the product portfolio."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Boolean flag for REACH compliance. Tracks chemical substance regulatory compliance for EU market access."
    - name: "weee_compliant"
      expr: weee_compliant
      comment: "Boolean flag for WEEE compliance. Tracks electronic waste regulatory compliance for EU market access."
    - name: "is_customer_facing"
      expr: is_customer_facing
      comment: "Boolean flag indicating whether the certification is visible to customers. Differentiates commercial vs. internal compliance certifications."
    - name: "expiry_date"
      expr: DATE_TRUNC('month', expiry_date)
      comment: "Month the certification expires. Enables proactive renewal planning and expiry risk monitoring."
    - name: "issue_date"
      expr: DATE_TRUNC('year', issue_date)
      comment: "Year the certification was issued. Tracks certification acquisition cadence and portfolio age."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of product certifications. Baseline measure of compliance portfolio breadth."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN product_certification_id END)
      comment: "Count of currently active certifications. Core compliance health KPI — declining active certifications signal market access risk."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN product_certification_id END)
      comment: "Count of expired certifications. Directly indicates compliance gap exposure and potential market access restrictions."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total investment in product certifications. Used in compliance budget planning and cost-benefit analysis of certification programs."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification investment efficiency across certifying bodies and certification types."
    - name: "rohs_compliant_count"
      expr: COUNT(CASE WHEN rohs_compliant = TRUE THEN product_certification_id END)
      comment: "Count of certifications with RoHS compliance confirmed. Tracks hazardous substance compliance coverage across the portfolio."
    - name: "reach_compliant_count"
      expr: COUNT(CASE WHEN reach_compliant = TRUE THEN product_certification_id END)
      comment: "Count of certifications with REACH compliance confirmed. Tracks EU chemical regulation compliance coverage."
    - name: "weee_compliant_count"
      expr: COUNT(CASE WHEN weee_compliant = TRUE THEN product_certification_id END)
      comment: "Count of certifications with WEEE compliance confirmed. Tracks EU electronic waste compliance coverage."
    - name: "distinct_certified_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Count of distinct SKUs holding at least one certification. Measures certified product portfolio coverage — a key market access KPI."
    - name: "customer_facing_certification_count"
      expr: COUNT(CASE WHEN is_customer_facing = TRUE THEN product_certification_id END)
      comment: "Count of customer-facing certifications. Tracks commercially visible compliance credentials that influence customer purchasing decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_revision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over product revisions — covers engineering change velocity, impact scope, approval cycle health, and regulatory compliance. Used by engineering, quality, and product management to govern change control and assess revision risk."
  source: "`manufacturing_ecm`.`product`.`product_revision`"
  dimensions:
    - name: "revision_status"
      expr: revision_status
      comment: "Current status of the product revision (e.g., Draft, Approved, Released, Obsolete). Core change control governance dimension."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the revision. Tracks engineering change approval pipeline health."
    - name: "change_impact_level"
      expr: change_impact_level
      comment: "Assessed impact level of the revision (e.g., Minor, Major, Critical). Drives change control prioritization and resource allocation."
    - name: "change_reason_code"
      expr: change_reason_code
      comment: "Reason code for the engineering change (e.g., Cost Reduction, Quality, Regulatory). Enables root cause analysis of change drivers."
    - name: "effectivity_type"
      expr: effectivity_type
      comment: "Type of effectivity control (e.g., Date-based, Serial-based). Informs production planning and inventory transition complexity."
    - name: "bom_affected_flag"
      expr: bom_affected_flag
      comment: "Boolean flag indicating whether the revision affects the BOM. Identifies high-complexity changes requiring BOM governance."
    - name: "regulatory_approval_required_flag"
      expr: regulatory_approval_required_flag
      comment: "Boolean flag indicating whether regulatory approval is required. Tracks compliance-driven change complexity and cycle time risk."
    - name: "customer_notification_required_flag"
      expr: customer_notification_required_flag
      comment: "Boolean flag indicating whether customers must be notified of the revision. Tracks customer-impacting change volume."
    - name: "effectivity_date"
      expr: DATE_TRUNC('month', effectivity_date)
      comment: "Month the revision became effective. Tracks engineering change cadence and release velocity over time."
    - name: "release_date"
      expr: DATE_TRUNC('quarter', release_date)
      comment: "Quarter the revision was released. Enables quarterly engineering change throughput analysis."
  measures:
    - name: "total_revisions"
      expr: COUNT(1)
      comment: "Total number of product revisions. Baseline measure of engineering change volume for governance and capacity planning."
    - name: "approved_revision_count"
      expr: COUNT(CASE WHEN approval_status = 'Approved' THEN product_revision_id END)
      comment: "Count of approved product revisions. Tracks engineering change approval throughput — a key change management KPI."
    - name: "pending_approval_revision_count"
      expr: COUNT(CASE WHEN approval_status = 'Pending' THEN product_revision_id END)
      comment: "Count of revisions awaiting approval. Indicates engineering change backlog and approval bottleneck risk."
    - name: "regulatory_approval_required_count"
      expr: COUNT(CASE WHEN regulatory_approval_required_flag = TRUE THEN product_revision_id END)
      comment: "Count of revisions requiring regulatory approval. Tracks compliance-driven change complexity and associated cycle time risk."
    - name: "bom_impacting_revision_count"
      expr: COUNT(CASE WHEN bom_affected_flag = TRUE THEN product_revision_id END)
      comment: "Count of revisions that impact the BOM. High values indicate significant manufacturing change complexity and production disruption risk."
    - name: "customer_notification_revision_count"
      expr: COUNT(CASE WHEN customer_notification_required_flag = TRUE THEN product_revision_id END)
      comment: "Count of revisions requiring customer notification. Tracks customer-impacting change volume relevant to customer satisfaction and contractual obligations."
    - name: "ppap_required_revision_count"
      expr: COUNT(CASE WHEN ppap_required_flag = TRUE THEN product_revision_id END)
      comment: "Count of revisions requiring PPAP (Production Part Approval Process). Tracks automotive/industrial quality gate compliance burden."
    - name: "distinct_revised_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Count of distinct SKUs with at least one revision. Measures the breadth of the product portfolio undergoing active engineering change."
    - name: "critical_impact_revision_count"
      expr: COUNT(CASE WHEN change_impact_level = 'Critical' THEN product_revision_id END)
      comment: "Count of revisions assessed as critical impact. Directly informs executive risk reviews and change control escalation decisions."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over product configurations — covers orderable portfolio size, pricing structure, lead time, and engineering review burden. Used by sales, product management, and engineering to optimize the configure-to-order portfolio and pricing strategy."
  source: "`manufacturing_ecm`.`product`.`configuration`"
  dimensions:
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current status of the configuration (e.g., Active, Obsolete, Draft). Core portfolio health dimension for configuration management."
    - name: "configuration_type"
      expr: configuration_type
      comment: "Type of product configuration (e.g., Standard, Custom, Engineered). Drives portfolio complexity and margin analysis."
    - name: "customer_segment"
      expr: customer_segment
      comment: "Target customer segment for the configuration. Enables revenue mix and pricing analysis by customer type."
    - name: "manufacturing_complexity"
      expr: manufacturing_complexity
      comment: "Assessed manufacturing complexity of the configuration (e.g., Low, Medium, High). Informs capacity planning and cost estimation."
    - name: "pricing_model"
      expr: pricing_model
      comment: "Pricing model applied to the configuration (e.g., List Price, Cost-Plus, Value-Based). Drives pricing strategy analysis."
    - name: "is_orderable"
      expr: is_orderable
      comment: "Boolean flag indicating whether the configuration can be ordered. Tracks commercially available portfolio share."
    - name: "is_quotable"
      expr: is_quotable
      comment: "Boolean flag indicating whether the configuration can be quoted. Tracks sales-ready portfolio breadth."
    - name: "requires_engineering_review"
      expr: requires_engineering_review
      comment: "Boolean flag indicating whether the configuration requires engineering review before fulfillment. Tracks engineering bottleneck exposure in the order pipeline."
    - name: "regional_availability"
      expr: regional_availability
      comment: "Geographic regions where the configuration is available. Enables regional portfolio coverage and market access analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('quarter', effective_start_date)
      comment: "Quarter the configuration became effective. Tracks new configuration introduction cadence."
  measures:
    - name: "total_configurations"
      expr: COUNT(1)
      comment: "Total number of product configurations. Baseline measure of configure-to-order portfolio breadth."
    - name: "orderable_configuration_count"
      expr: COUNT(CASE WHEN is_orderable = TRUE THEN configuration_id END)
      comment: "Count of configurations available for ordering. Core commercial portfolio KPI — directly impacts revenue opportunity."
    - name: "engineering_review_required_count"
      expr: COUNT(CASE WHEN requires_engineering_review = TRUE THEN configuration_id END)
      comment: "Count of configurations requiring engineering review. Tracks engineering bottleneck volume in the order-to-delivery pipeline."
    - name: "avg_base_price"
      expr: AVG(CAST(base_price AS DOUBLE))
      comment: "Average base price across configurations. Benchmarks pricing level across customer segments and configuration types."
    - name: "total_base_price"
      expr: SUM(CAST(base_price AS DOUBLE))
      comment: "Sum of base prices across all configurations. Indicates total catalog revenue potential of the configure-to-order portfolio."
    - name: "avg_total_configuration_price"
      expr: AVG(CAST(total_configuration_price AS DOUBLE))
      comment: "Average total configuration price including options and adjustments. Key pricing KPI for sales strategy and margin management."
    - name: "avg_price_adjustment"
      expr: AVG(CAST(price_adjustment AS DOUBLE))
      comment: "Average price adjustment applied to configurations. Tracks discounting and premium pricing patterns across segments."
    - name: "avg_power_rating_kw"
      expr: AVG(CAST(power_rating_kw AS DOUBLE))
      comment: "Average power rating in kilowatts across configurations. Benchmarks product capability profile for electrification and energy planning."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average weight per configuration. Informs logistics cost estimation and product design optimization."
    - name: "distinct_configured_skus"
      expr: COUNT(DISTINCT sku_master_id)
      comment: "Count of distinct SKUs with at least one configuration. Measures the breadth of the SKU portfolio supporting configure-to-order fulfillment."
$$;

CREATE OR REPLACE VIEW `manufacturing_ecm`.`_metrics`.`product_plant_data`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over plant-level material master data — covers inventory planning parameters, safety stock adequacy, lot sizing efficiency, and MRP configuration health. Used by supply chain, production planning, and operations to optimize material availability and inventory investment."
  source: "`manufacturing_ecm`.`product`.`plant_data`"
  dimensions:
    - name: "plant_status"
      expr: plant_status
      comment: "Status of the material at the plant level (e.g., Active, Blocked, Discontinued). Core material availability dimension."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type assigned to the material (e.g., MRP, Reorder Point, Consumption-Based). Drives planning strategy analysis."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type at the plant level (e.g., In-house, External, Both). Informs make-vs-buy and supply chain strategy."
    - name: "abc_indicator"
      expr: abc_indicator
      comment: "ABC classification at the plant level. Prioritizes inventory management focus and safety stock investment."
    - name: "lot_size_procedure"
      expr: lot_size_procedure
      comment: "Lot sizing procedure applied (e.g., Fixed, Economic, Period). Drives inventory carrying cost and production efficiency analysis."
    - name: "batch_management_required"
      expr: batch_management_required
      comment: "Boolean flag indicating batch management requirement. Tracks traceability overhead and quality management complexity."
    - name: "negative_stock_allowed"
      expr: negative_stock_allowed
      comment: "Boolean flag indicating whether negative stock is permitted. Identifies inventory accuracy risk and process control gaps."
    - name: "quality_inspection_type"
      expr: quality_inspection_type
      comment: "Type of quality inspection applied at goods receipt. Informs quality control overhead and lead time impact."
    - name: "discontinuation_date"
      expr: DATE_TRUNC('month', discontinuation_date)
      comment: "Month the material was discontinued at the plant. Tracks material phase-out cadence for inventory wind-down planning."
  measures:
    - name: "total_plant_material_records"
      expr: COUNT(1)
      comment: "Total number of plant-level material records. Baseline measure of material master data scope across plants."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity across all plant-material combinations. Key inventory investment KPI for supply chain risk management."
    - name: "avg_safety_stock_quantity"
      expr: AVG(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Average safety stock quantity per plant-material record. Benchmarks buffer inventory levels for supply chain resilience assessment."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point across plant-material records. Informs replenishment trigger calibration and stockout risk management."
    - name: "avg_minimum_lot_size"
      expr: AVG(CAST(minimum_lot_size AS DOUBLE))
      comment: "Average minimum lot size across plant-material records. Benchmarks production batch efficiency and supplier minimum order alignment."
    - name: "avg_maximum_lot_size"
      expr: AVG(CAST(maximum_lot_size AS DOUBLE))
      comment: "Average maximum lot size across plant-material records. Informs inventory carrying cost risk and warehouse capacity planning."
    - name: "avg_maximum_stock_level"
      expr: AVG(CAST(maximum_stock_level AS DOUBLE))
      comment: "Average maximum stock level across plant-material records. Tracks inventory ceiling parameters for working capital optimization."
    - name: "negative_stock_allowed_count"
      expr: COUNT(CASE WHEN negative_stock_allowed = TRUE THEN plant_data_id END)
      comment: "Count of plant-material records permitting negative stock. Identifies inventory accuracy risk exposure requiring process control intervention."
    - name: "batch_managed_material_count"
      expr: COUNT(CASE WHEN batch_management_required = TRUE THEN plant_data_id END)
      comment: "Count of plant-material records requiring batch management. Tracks traceability and quality management overhead across the plant network."
    - name: "distinct_plants_with_materials"
      expr: COUNT(DISTINCT plant_id)
      comment: "Count of distinct plants with active material master records. Measures plant network material coverage for supply chain planning."
$$;