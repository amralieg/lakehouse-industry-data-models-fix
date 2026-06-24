-- Metric views for domain: product | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the SKU master. Covers portfolio health, cost economics, sustainability posture, and lifecycle distribution — the primary lens for product portfolio steering decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`sku`"
  dimensions:
    - name: "sku_lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the SKU (e.g. Introduction, Growth, Maturity, Decline) — used to segment portfolio health analysis."
    - name: "sku_status"
      expr: sku_status
      comment: "Operational status of the SKU (e.g. Active, Discontinued, Pending) — key filter for active portfolio sizing."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. Liquid, Powder, Tablet) — used for formulation-level portfolio analysis."
    - name: "portfolio_classification"
      expr: portfolio_classification
      comment: "Strategic portfolio tier classification (e.g. Core, Innovation, Tail) — drives investment prioritisation decisions."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Intended consumer demographic segment — used for consumer-centric portfolio segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured or sourced — relevant for trade compliance and supply risk analysis."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Boolean flag indicating whether the SKU meets sustainability criteria — used for ESG portfolio reporting."
    - name: "is_regulated_product"
      expr: is_regulated_product
      comment: "Boolean flag indicating whether the SKU is subject to regulatory oversight — used for compliance risk segmentation."
    - name: "is_recyclable_packaging"
      expr: is_recyclable_packaging
      comment: "Boolean flag indicating recyclable packaging — used for sustainability KPI segmentation."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory classification of the SKU — used for compliance reporting and market access analysis."
    - name: "subcategory"
      expr: subcategory
      comment: "Product subcategory within the broader category — enables granular portfolio mix analysis."
    - name: "launch_year"
      expr: DATE_TRUNC('YEAR', launch_date)
      comment: "Year the SKU was launched — used for cohort-based portfolio age and innovation pipeline analysis."
    - name: "discontinuation_year"
      expr: DATE_TRUNC('YEAR', discontinuation_date)
      comment: "Year the SKU was or is scheduled to be discontinued — used for portfolio rationalisation planning."
  measures:
    - name: "active_sku_count"
      expr: COUNT(CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Number of currently active SKUs in the portfolio. Core portfolio size KPI used in every executive portfolio review."
    - name: "total_sku_count"
      expr: COUNT(sku_id)
      comment: "Total number of SKUs across all lifecycle stages. Baseline for portfolio complexity and rationalisation analysis."
    - name: "sustainable_sku_count"
      expr: COUNT(CASE WHEN is_sustainable = TRUE THEN sku_id END)
      comment: "Number of SKUs flagged as sustainable. Tracks ESG portfolio commitment and progress toward sustainability targets."
    - name: "regulated_sku_count"
      expr: COUNT(CASE WHEN is_regulated_product = TRUE THEN sku_id END)
      comment: "Number of SKUs subject to regulatory oversight. Drives compliance resource allocation and risk exposure assessment."
    - name: "recyclable_packaging_sku_count"
      expr: COUNT(CASE WHEN is_recyclable_packaging = TRUE THEN sku_id END)
      comment: "Number of SKUs with recyclable packaging. Key ESG metric for packaging sustainability commitments."
    - name: "hazardous_sku_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN sku_id END)
      comment: "Number of SKUs classified as hazardous. Informs safety compliance, logistics restrictions, and regulatory risk exposure."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU in USD. Used for cost benchmarking, margin modelling, and pricing strategy decisions."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all SKUs. Provides aggregate cost base for portfolio-level margin and investment analysis."
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price across SKUs. Used for pricing tier analysis and competitive positioning."
    - name: "total_msrp_usd"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value across all SKUs. Proxy for total addressable retail value of the portfolio."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU in kilograms. Used for logistics cost modelling and packaging efficiency analysis."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU in kilograms. Used for fill-rate and product-to-packaging ratio analysis."
    - name: "avg_net_content_volume_ml"
      expr: AVG(CAST(volume_ml AS DOUBLE))
      comment: "Average net content volume per SKU in millilitres. Used for pack-size strategy and consumer value analysis."
    - name: "avg_fefo_threshold_pct"
      expr: AVG(CAST(fefo_threshold_pct AS DOUBLE))
      comment: "Average First-Expired-First-Out threshold percentage across SKUs. Informs inventory freshness policy and waste reduction strategy."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN sku_status = 'Discontinued' THEN sku_id END)
      comment: "Number of discontinued SKUs. Tracks portfolio rationalisation velocity and tail-SKU elimination progress."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_brand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the Brand master. Covers brand portfolio health, licensing exposure, sustainability certification, trade promotion eligibility, and lifecycle stage distribution — essential for brand investment and portfolio strategy decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`brand`"
  dimensions:
    - name: "brand_status"
      expr: brand_status
      comment: "Current operational status of the brand (e.g. Active, Divested, Pending) — primary filter for active brand portfolio analysis."
    - name: "architecture_type"
      expr: architecture_type
      comment: "Brand architecture classification (e.g. Masterbrand, Endorsed, Standalone) — used for brand portfolio structure analysis."
    - name: "tier"
      expr: tier
      comment: "Brand tier (e.g. Premium, Mainstream, Value) — drives pricing strategy and investment prioritisation."
    - name: "geographic_scope"
      expr: geographic_scope
      comment: "Geographic reach of the brand (e.g. Global, Regional, Local) — used for market expansion and resource allocation decisions."
    - name: "owner_division"
      expr: owner_division
      comment: "Business division that owns the brand — used for P&L attribution and divisional portfolio analysis."
    - name: "target_consumer_segment"
      expr: target_consumer_segment
      comment: "Primary consumer segment targeted by the brand — used for consumer-centric portfolio segmentation."
    - name: "plm_stage"
      expr: plm_stage
      comment: "Product lifecycle management stage of the brand — used for innovation pipeline and brand maturity analysis."
    - name: "primary_country_code"
      expr: primary_country_code
      comment: "Primary country of the brand — used for geographic portfolio distribution analysis."
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by the brand (e.g. B-Corp, Rainforest Alliance) — used for ESG portfolio reporting."
    - name: "is_licensed_brand"
      expr: is_licensed_brand
      comment: "Boolean flag indicating whether the brand operates under a license — used for licensing risk and renewal management."
    - name: "trade_promotion_eligible"
      expr: trade_promotion_eligible
      comment: "Boolean flag indicating trade promotion eligibility — used for commercial planning and trade spend allocation."
    - name: "launch_year"
      expr: DATE_TRUNC('YEAR', launch_date)
      comment: "Year the brand was launched — used for brand age cohort analysis and portfolio vintage assessment."
    - name: "divestiture_year"
      expr: DATE_TRUNC('YEAR', divestiture_date)
      comment: "Year the brand was or is scheduled to be divested — used for portfolio rationalisation and M&A planning."
  measures:
    - name: "active_brand_count"
      expr: COUNT(CASE WHEN brand_status = 'Active' THEN brand_id END)
      comment: "Number of currently active brands. Core portfolio size KPI for brand investment and resource allocation decisions."
    - name: "total_brand_count"
      expr: COUNT(brand_id)
      comment: "Total number of brands across all statuses. Baseline for portfolio complexity and rationalisation analysis."
    - name: "licensed_brand_count"
      expr: COUNT(CASE WHEN is_licensed_brand = TRUE THEN brand_id END)
      comment: "Number of licensed brands. Tracks licensing dependency and renewal risk exposure in the portfolio."
    - name: "trade_promotion_eligible_brand_count"
      expr: COUNT(CASE WHEN trade_promotion_eligible = TRUE THEN brand_id END)
      comment: "Number of brands eligible for trade promotions. Informs commercial planning and trade spend allocation decisions."
    - name: "nps_tracked_brand_count"
      expr: COUNT(CASE WHEN nps_tracking_enabled = TRUE THEN brand_id END)
      comment: "Number of brands with NPS tracking enabled. Indicates consumer sentiment measurement coverage across the portfolio."
    - name: "sustainability_certified_brand_count"
      expr: COUNT(CASE WHEN sustainability_certification IS NOT NULL AND sustainability_certification <> '' THEN brand_id END)
      comment: "Number of brands holding a sustainability certification. Key ESG metric for brand-level sustainability commitment reporting."
    - name: "gmp_certified_brand_count"
      expr: COUNT(CASE WHEN gmp_certification_ref IS NOT NULL AND gmp_certification_ref <> '' THEN brand_id END)
      comment: "Number of brands with a GMP certification reference. Tracks quality and regulatory compliance coverage across the brand portfolio."
    - name: "divested_brand_count"
      expr: COUNT(CASE WHEN divestiture_date IS NOT NULL THEN brand_id END)
      comment: "Number of brands that have been or are scheduled to be divested. Tracks portfolio rationalisation and M&A activity."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over BOM line items. Covers component cost economics, scrap efficiency, critical component exposure, hazardous material risk, and sourcing complexity — essential for product cost management and supply chain resilience decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of BOM component (e.g. Raw Material, Packaging, Semi-Finished) — used for cost and risk segmentation by component category."
    - name: "bom_item_category"
      expr: bom_item_category
      comment: "SAP/ERP BOM item category — used for procurement and manufacturing planning segmentation."
    - name: "issue_method"
      expr: issue_method
      comment: "Material issue method (e.g. Backflush, Manual) — used for production efficiency and inventory accuracy analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the component quantity — used for normalisation and cross-component comparison."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which component cost is denominated — used for multi-currency cost analysis."
    - name: "line_status"
      expr: line_status
      comment: "Current status of the BOM line (e.g. Active, Obsolete) — used to filter active vs. historical cost analysis."
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Boolean flag indicating whether the component is critical to production — used for supply risk and continuity planning."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Boolean flag indicating hazardous material — used for safety compliance and logistics restriction analysis."
    - name: "bulk_material_flag"
      expr: bulk_material_flag
      comment: "Boolean flag indicating bulk material — used for procurement volume and storage planning analysis."
    - name: "valid_from_year"
      expr: DATE_TRUNC('YEAR', valid_from_date)
      comment: "Year the BOM line became valid — used for BOM vintage and change frequency analysis."
  measures:
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total cost of all BOM components in USD. Primary cost driver metric for product cost-of-goods-sold (COGS) analysis and margin management."
    - name: "avg_component_cost_usd"
      expr: AVG(CAST(component_cost_usd AS DOUBLE))
      comment: "Average cost per BOM component line in USD. Used for component cost benchmarking and supplier negotiation prioritisation."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity across all BOM lines. Used for material requirements planning (MRP) and procurement volume analysis."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. Directly measures production waste efficiency — a key lever for COGS reduction and sustainability targets."
    - name: "total_scrap_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE) * CAST(scrap_percentage AS DOUBLE) / 100.0)
      comment: "Estimated total cost of scrap across all BOM lines in USD. Quantifies the financial impact of production waste for cost reduction prioritisation."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN is_critical_component = TRUE THEN bom_line_id END)
      comment: "Number of BOM lines flagged as critical components. Tracks supply chain single-point-of-failure exposure and resilience risk."
    - name: "hazardous_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN bom_line_id END)
      comment: "Number of BOM lines involving hazardous materials. Drives safety compliance, regulatory reporting, and logistics cost planning."
    - name: "avg_usage_probability_pct"
      expr: AVG(CAST(usage_probability_pct AS DOUBLE))
      comment: "Average usage probability percentage across BOM lines. Used for alternative component planning and demand variability analysis."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across BOM components. Informs procurement strategy, working capital requirements, and supplier negotiation."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by BOM lines. Measures BOM coverage breadth and identifies SKUs lacking complete BOM definitions."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers across BOM lines. Tracks supplier base concentration and diversification for supply risk management."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over packaging specifications. Covers packaging cost economics, sustainability credentials (PCR content, FSC, RSPO), dimensional efficiency, and lifecycle status — essential for packaging cost reduction, ESG commitments, and supplier management."
  source: "`vibe_consumer_goods_v1`.`product`.`packaging_spec`"
  dimensions:
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. Primary, Secondary, Tertiary) — used for cost and sustainability analysis by packaging tier."
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (e.g. Bottle, Cap, Carton) — used for material-level packaging cost and sustainability analysis."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle status of the packaging spec (e.g. Active, Obsolete) — used to filter active vs. historical packaging analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the packaging specification — used for quality gate and compliance readiness analysis."
    - name: "recyclability_code"
      expr: recyclability_code
      comment: "Recyclability classification code — used for ESG packaging sustainability reporting and consumer communication."
    - name: "is_fsc_certified"
      expr: is_fsc_certified
      comment: "Boolean flag indicating FSC (Forest Stewardship Council) certification — used for sustainable sourcing compliance reporting."
    - name: "is_rspo_certified"
      expr: is_rspo_certified
      comment: "Boolean flag indicating RSPO (Roundtable on Sustainable Palm Oil) certification — used for palm oil sustainability compliance."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Boolean flag indicating hazardous material packaging — used for safety compliance and logistics restriction analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which packaging unit cost is denominated — used for multi-currency cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the packaging component — used for trade compliance and supply risk analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the packaging spec became effective — used for spec vintage and change frequency analysis."
  measures:
    - name: "total_unit_cost_usd"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total packaging unit cost across all specs. Primary packaging cost driver for COGS and margin management decisions."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average packaging unit cost per spec. Used for cost benchmarking across packaging types and supplier negotiation."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled (PCR) content percentage across packaging specs. Key ESG metric for circular economy and sustainability target tracking."
    - name: "total_gross_weight_g"
      expr: SUM(CAST(gross_weight_g AS DOUBLE))
      comment: "Total gross weight of packaging components in grams. Used for logistics cost modelling and packaging lightweighting initiatives."
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight per packaging spec in grams. Benchmarks packaging weight efficiency and lightweighting progress."
    - name: "avg_tare_weight_g"
      expr: AVG(CAST(tare_weight_g AS DOUBLE))
      comment: "Average tare (empty packaging) weight per spec in grams. Used for product-to-packaging weight ratio and material efficiency analysis."
    - name: "fsc_certified_spec_count"
      expr: COUNT(CASE WHEN is_fsc_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of packaging specs with FSC certification. Tracks sustainable forestry sourcing compliance across the packaging portfolio."
    - name: "rspo_certified_spec_count"
      expr: COUNT(CASE WHEN is_rspo_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of packaging specs with RSPO certification. Tracks sustainable palm oil sourcing compliance — a key ESG commitment metric."
    - name: "regulatory_compliant_spec_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN packaging_spec_id END)
      comment: "Number of packaging specs meeting regulatory compliance requirements. Tracks compliance readiness and risk exposure across the packaging portfolio."
    - name: "active_spec_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN packaging_spec_id END)
      comment: "Number of currently active packaging specifications. Baseline for active packaging portfolio size and complexity management."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs covered by packaging specs. Measures packaging spec coverage and identifies SKUs lacking approved packaging definitions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over product and brand certifications. Covers certification portfolio health, cost of compliance, audit outcomes, sustainability pillar coverage, and expiry risk — essential for regulatory compliance management and ESG reporting."
  source: "`vibe_consumer_goods_v1`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Organic, Fair Trade, ISO 22716) — used for compliance portfolio segmentation and gap analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending Renewal) — primary filter for compliance risk analysis."
    - name: "sustainability_pillar"
      expr: sustainability_pillar
      comment: "ESG sustainability pillar covered by the certification (e.g. Environmental, Social, Governance) — used for ESG portfolio coverage analysis."
    - name: "applicable_markets"
      expr: applicable_markets
      comment: "Markets where the certification is applicable — used for market access and regulatory compliance analysis."
    - name: "applicable_channels"
      expr: applicable_channels
      comment: "Sales channels where the certification applies — used for channel-level compliance and retailer requirement analysis."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent certification audit (e.g. Pass, Fail, Conditional) — used for quality and compliance performance tracking."
    - name: "consumer_facing_flag"
      expr: consumer_facing_flag
      comment: "Boolean flag indicating whether the certification is consumer-facing — used for brand trust and marketing claim analysis."
    - name: "retailer_requirement_flag"
      expr: retailer_requirement_flag
      comment: "Boolean flag indicating whether the certification is required by a retailer — used for trade compliance and listing risk analysis."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency in which certification cost is denominated — used for multi-currency compliance cost analysis."
    - name: "effective_year"
      expr: DATE_TRUNC('YEAR', effective_date)
      comment: "Year the certification became effective — used for certification vintage and renewal cycle analysis."
    - name: "expiry_year"
      expr: DATE_TRUNC('YEAR', expiry_date)
      comment: "Year the certification expires — used for renewal pipeline planning and compliance risk forecasting."
  measures:
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of currently active certifications. Core compliance portfolio size KPI for regulatory and ESG reporting."
    - name: "total_certification_count"
      expr: COUNT(certification_id)
      comment: "Total number of certifications across all statuses. Baseline for compliance portfolio breadth and investment analysis."
    - name: "total_certification_cost_usd"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of all certifications. Quantifies the total cost of compliance — a key input for regulatory investment decisions and budget planning."
    - name: "avg_certification_cost_usd"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Used for cost benchmarking across certification types and bodies to optimise compliance spend."
    - name: "consumer_facing_certification_count"
      expr: COUNT(CASE WHEN consumer_facing_flag = TRUE THEN certification_id END)
      comment: "Number of consumer-facing certifications. Tracks brand trust credentials and marketing claim substantiation coverage."
    - name: "retailer_required_certification_count"
      expr: COUNT(CASE WHEN retailer_requirement_flag = TRUE THEN certification_id END)
      comment: "Number of certifications required by retailers. Tracks trade compliance exposure and listing risk across the product portfolio."
    - name: "logo_approved_certification_count"
      expr: COUNT(CASE WHEN logo_usage_approved = TRUE THEN certification_id END)
      comment: "Number of certifications with approved logo usage. Tracks readiness to use certification marks in consumer-facing materials."
    - name: "distinct_sku_certified_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs holding at least one certification. Measures certification coverage across the active product portfolio."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_result = 'Fail' THEN certification_id END)
      comment: "Number of certifications with a failed audit result. Critical compliance risk KPI — triggers immediate investigation and remediation action."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over product BOMs (Bills of Materials). Covers BOM portfolio health, regulatory compliance (REACH, GMP), configurability, and lot-size economics — essential for product engineering, regulatory compliance, and manufacturing readiness decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`product_bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Production, Engineering, Costing) — used for BOM portfolio segmentation by purpose."
    - name: "bom_category"
      expr: bom_category
      comment: "BOM category classification — used for manufacturing planning and cost analysis segmentation."
    - name: "bom_level"
      expr: bom_level
      comment: "Depth level of the BOM structure — used for multi-level BOM complexity analysis."
    - name: "plm_status"
      expr: plm_status
      comment: "PLM lifecycle status of the BOM (e.g. Released, In Development, Obsolete) — used for innovation pipeline and readiness analysis."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the BOM — used for market release readiness and compliance risk analysis."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "Boolean flag indicating GMP compliance of the BOM — used for quality and regulatory compliance segmentation."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Boolean flag indicating REACH regulatory compliance — used for chemical safety compliance reporting."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Boolean flag indicating RSPO certification of the BOM — used for sustainable palm oil sourcing compliance."
    - name: "is_configurable"
      expr: is_configurable
      comment: "Boolean flag indicating whether the BOM supports product configuration — used for mass customisation and variant management analysis."
    - name: "base_uom"
      expr: base_uom
      comment: "Base unit of measure for the BOM — used for cross-BOM quantity normalisation."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the BOM became effective — used for BOM vintage and change frequency analysis."
  measures:
    - name: "active_bom_count"
      expr: COUNT(CASE WHEN deletion_flag = FALSE OR deletion_flag IS NULL THEN product_bom_id END)
      comment: "Number of active (non-deleted) BOMs. Core BOM portfolio size KPI for manufacturing readiness and product engineering governance."
    - name: "total_bom_count"
      expr: COUNT(product_bom_id)
      comment: "Total number of BOMs across all statuses. Baseline for BOM portfolio complexity and governance analysis."
    - name: "gmp_compliant_bom_count"
      expr: COUNT(CASE WHEN gmp_compliant = TRUE THEN product_bom_id END)
      comment: "Number of BOMs meeting GMP compliance requirements. Tracks quality system compliance coverage across the product portfolio."
    - name: "reach_compliant_bom_count"
      expr: COUNT(CASE WHEN reach_compliant = TRUE THEN product_bom_id END)
      comment: "Number of BOMs meeting REACH chemical safety compliance. Tracks regulatory compliance coverage and chemical risk exposure."
    - name: "rspo_certified_bom_count"
      expr: COUNT(CASE WHEN rspo_certified = TRUE THEN product_bom_id END)
      comment: "Number of BOMs with RSPO certification. Tracks sustainable palm oil sourcing compliance at the formulation level."
    - name: "configurable_bom_count"
      expr: COUNT(CASE WHEN is_configurable = TRUE THEN product_bom_id END)
      comment: "Number of configurable BOMs. Tracks mass customisation capability and variant management complexity."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM. Used for production batch size analysis and manufacturing efficiency benchmarking."
    - name: "avg_lot_size_from"
      expr: AVG(CAST(lot_size_from AS DOUBLE))
      comment: "Average minimum lot size across BOMs. Informs production scheduling, minimum run economics, and capacity planning."
    - name: "avg_lot_size_to"
      expr: AVG(CAST(lot_size_to AS DOUBLE))
      comment: "Average maximum lot size across BOMs. Used for production capacity ceiling analysis and batch size optimisation."
    - name: "distinct_sku_bom_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one BOM defined. Measures BOM coverage completeness — SKUs without BOMs cannot be manufactured."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the material master. Covers material cost economics, hazardous material exposure, lifecycle stage distribution, and physical characteristics — essential for procurement strategy, COGS management, and regulatory compliance decisions."
  source: "`vibe_consumer_goods_v1`.`product`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (e.g. Raw Material, Packaging, Finished Good) — primary segmentation dimension for material portfolio analysis."
    - name: "material_group"
      expr: material_group
      comment: "Material group classification — used for category-level procurement and cost analysis."
    - name: "material_status"
      expr: material_status
      comment: "Current status of the material (e.g. Active, Blocked, Discontinued) — used to filter active vs. obsolete material analysis."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the material — used for material portfolio age and rationalisation analysis."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type associated with the material — used for packaging cost and sustainability analysis."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory compliance status of the material — used for compliance risk and market access analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the material — used for trade compliance, tariff analysis, and supply risk management."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Boolean flag indicating hazardous material — used for safety compliance, logistics restrictions, and regulatory reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which material standard cost is denominated — used for multi-currency cost analysis."
    - name: "effective_from_year"
      expr: DATE_TRUNC('YEAR', effective_from)
      comment: "Year the material record became effective — used for material vintage and portfolio refresh analysis."
  measures:
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all materials. Primary cost base metric for COGS analysis, procurement budget planning, and margin management."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material. Used for cost benchmarking across material types and supplier negotiation prioritisation."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_flag = TRUE THEN material_id END)
      comment: "Number of hazardous materials in the portfolio. Tracks safety compliance exposure and logistics restriction scope."
    - name: "active_material_count"
      expr: COUNT(CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Number of currently active materials. Core material portfolio size KPI for procurement and supply chain planning."
    - name: "total_material_count"
      expr: COUNT(material_id)
      comment: "Total number of materials across all statuses. Baseline for material portfolio complexity and rationalisation analysis."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average material weight in kilograms. Used for logistics cost modelling and material density/efficiency analysis."
    - name: "avg_volume_l"
      expr: AVG(CAST(volume_l AS DOUBLE))
      comment: "Average material volume in litres. Used for storage capacity planning and volumetric efficiency analysis."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average required storage temperature in Celsius. Used for cold chain infrastructure planning and energy cost analysis."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers across the material portfolio. Tracks supplier base concentration and diversification for supply risk management."
$$;