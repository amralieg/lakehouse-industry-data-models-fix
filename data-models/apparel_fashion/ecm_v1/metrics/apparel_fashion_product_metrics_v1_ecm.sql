-- Metric views for domain: product | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 15:42:09

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core SKU-level metrics for inventory, pricing, and product performance analysis across channels and lifecycle stages"
  source: "`apparel_fashion_ecm`.`product`.`sku`"
  dimensions:
    - name: "brand_name"
      expr: brand_id
      comment: "Brand identifier for SKU aggregation"
    - name: "category_name"
      expr: category_id
      comment: "Product category identifier for classification analysis"
    - name: "collection_name"
      expr: collection_id
      comment: "Collection identifier for seasonal and thematic grouping"
    - name: "gender_segment"
      expr: gender
      comment: "Target gender segment (Men, Women, Unisex) for market analysis"
    - name: "age_group_segment"
      expr: age_group
      comment: "Target age group (Adult, Youth, Kids) for demographic analysis"
    - name: "product_type_category"
      expr: product_type
      comment: "Product type classification (Apparel, Footwear, Accessories)"
    - name: "sku_status_flag"
      expr: sku_status
      comment: "Current lifecycle status (Active, Discontinued, Pending)"
    - name: "season_code_label"
      expr: season_code
      comment: "Season code for temporal product planning"
    - name: "country_of_origin_label"
      expr: country_of_origin
      comment: "Manufacturing country of origin for compliance and sourcing analysis"
    - name: "sustainability_certified_flag"
      expr: sustainability_certification
      comment: "Sustainability certification status for ESG reporting"
    - name: "launch_month"
      expr: DATE_TRUNC('MONTH', launch_date)
      comment: "Month of SKU launch for new product performance tracking"
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year of SKU launch for cohort analysis"
    - name: "ats_availability_flag"
      expr: ats_flag
      comment: "Available-to-sell flag for inventory availability analysis"
    - name: "nos_replenishment_flag"
      expr: nos_flag
      comment: "Never-out-of-stock flag for core product identification"
    - name: "gsp_eligibility_flag"
      expr: gsp_eligible
      comment: "Generalized System of Preferences eligibility for duty optimization"
  measures:
    - name: "total_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Total number of unique SKUs for assortment breadth analysis"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total manufacturer suggested retail price value across SKUs"
    - name: "total_wholesale_value"
      expr: SUM(CAST(wholesale_price AS DOUBLE))
      comment: "Total wholesale price value for B2B revenue planning"
    - name: "total_cost_value"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of goods sold value for margin analysis"
    - name: "avg_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per SKU for pricing strategy analysis"
    - name: "avg_wholesale_price"
      expr: AVG(CAST(wholesale_price AS DOUBLE))
      comment: "Average wholesale price per SKU for channel pricing analysis"
    - name: "avg_unit_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average unit cost per SKU for cost management"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage for profitability planning"
    - name: "total_product_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total product weight in kilograms for logistics planning"
    - name: "avg_product_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average product weight per SKU for shipping cost estimation"
    - name: "active_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Count of active SKUs for current assortment analysis"
    - name: "discontinued_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sku_status = 'Discontinued' THEN sku_id END)
      comment: "Count of discontinued SKUs for lifecycle management"
    - name: "sustainable_sku_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN sku_id END)
      comment: "Count of sustainability-certified SKUs for ESG reporting"
    - name: "ats_enabled_sku_count"
      expr: COUNT(DISTINCT CASE WHEN ats_flag = TRUE THEN sku_id END)
      comment: "Count of available-to-sell SKUs for inventory availability"
    - name: "nos_core_sku_count"
      expr: COUNT(DISTINCT CASE WHEN nos_flag = TRUE THEN sku_id END)
      comment: "Count of never-out-of-stock core SKUs for replenishment prioritization"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_style`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Style-level strategic metrics for product development, lifecycle management, and portfolio performance"
  source: "`apparel_fashion_ecm`.`product`.`style`"
  dimensions:
    - name: "brand_identifier"
      expr: brand_id
      comment: "Brand identifier for style portfolio analysis"
    - name: "category_identifier"
      expr: category_id
      comment: "Category identifier for product line analysis"
    - name: "collection_identifier"
      expr: collection_id
      comment: "Collection identifier for seasonal performance"
    - name: "gender_target_segment"
      expr: gender
      comment: "Target gender for market segmentation"
    - name: "product_type_classification"
      expr: product_type
      comment: "Product type for category management"
    - name: "lifecycle_stage_status"
      expr: lifecycle_stage
      comment: "Current lifecycle stage (Development, Launch, Growth, Maturity, Decline)"
    - name: "season_code_identifier"
      expr: season_code
      comment: "Season code for temporal planning"
    - name: "silhouette_type"
      expr: silhouette
      comment: "Silhouette classification for design analysis"
    - name: "target_channel_strategy"
      expr: target_channel
      comment: "Target sales channel (Retail, Ecommerce, Wholesale)"
    - name: "country_of_origin_code"
      expr: country_of_origin
      comment: "Manufacturing country for sourcing analysis"
    - name: "core_style_flag"
      expr: is_core_style
      comment: "Core style indicator for portfolio management"
    - name: "exclusive_style_flag"
      expr: is_exclusive
      comment: "Exclusivity flag for premium positioning"
    - name: "sustainability_certified_indicator"
      expr: sustainability_certification
      comment: "Sustainability certification for ESG tracking"
    - name: "launch_year_cohort"
      expr: YEAR(launch_date)
      comment: "Launch year for cohort performance analysis"
    - name: "launch_quarter"
      expr: DATE_TRUNC('QUARTER', launch_date)
      comment: "Launch quarter for seasonal trend analysis"
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approved_timestamp)
      comment: "Approval month for development velocity tracking"
  measures:
    - name: "total_style_count"
      expr: COUNT(DISTINCT style_id)
      comment: "Total number of unique styles for portfolio breadth"
    - name: "total_msrp_portfolio_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value across style portfolio"
    - name: "total_wholesale_portfolio_value"
      expr: SUM(CAST(wholesale_price AS DOUBLE))
      comment: "Total wholesale value for B2B revenue planning"
    - name: "total_cogs_portfolio"
      expr: SUM(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Total cost of goods sold for margin management"
    - name: "avg_style_msrp"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average MSRP per style for pricing strategy"
    - name: "avg_style_wholesale_price"
      expr: AVG(CAST(wholesale_price AS DOUBLE))
      comment: "Average wholesale price per style for channel pricing"
    - name: "avg_style_cogs"
      expr: AVG(CAST(cost_of_goods_sold AS DOUBLE))
      comment: "Average COGS per style for cost efficiency"
    - name: "core_style_count"
      expr: COUNT(DISTINCT CASE WHEN is_core_style = TRUE THEN style_id END)
      comment: "Count of core styles for portfolio stability analysis"
    - name: "exclusive_style_count"
      expr: COUNT(DISTINCT CASE WHEN is_exclusive = TRUE THEN style_id END)
      comment: "Count of exclusive styles for premium positioning"
    - name: "sustainable_style_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN style_id END)
      comment: "Count of sustainability-certified styles for ESG goals"
    - name: "development_stage_style_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_stage = 'Development' THEN style_id END)
      comment: "Count of styles in development for pipeline visibility"
    - name: "active_launch_style_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_stage IN ('Launch', 'Growth') THEN style_id END)
      comment: "Count of styles in launch or growth phase for market momentum"
    - name: "mature_style_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_stage = 'Maturity' THEN style_id END)
      comment: "Count of mature styles for cash cow management"
    - name: "declining_style_count"
      expr: COUNT(DISTINCT CASE WHEN lifecycle_stage = 'Decline' THEN style_id END)
      comment: "Count of declining styles for exit planning"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials cost and margin metrics for product costing, profitability analysis, and supply chain optimization"
  source: "`apparel_fashion_ecm`.`product`.`bom`"
  dimensions:
    - name: "bom_status_flag"
      expr: bom_status
      comment: "BOM approval status (Draft, Approved, Obsolete)"
    - name: "bom_type_category"
      expr: bom_type
      comment: "BOM type classification (Standard, Custom, Engineering)"
    - name: "costing_stage_phase"
      expr: costing_stage
      comment: "Costing stage (Preliminary, Target, Final)"
    - name: "cost_approval_status_flag"
      expr: cost_approval_status
      comment: "Cost approval status for financial governance"
    - name: "country_of_origin_code"
      expr: country_of_origin
      comment: "Manufacturing country for duty and compliance analysis"
    - name: "currency_code_label"
      expr: currency_code
      comment: "Currency code for multi-currency cost management"
    - name: "primary_fabric_type_category"
      expr: primary_fabric_type
      comment: "Primary fabric type for material cost analysis"
    - name: "sustainability_certification_flag"
      expr: sustainability_certification
      comment: "Sustainability certification for ESG cost tracking"
    - name: "cost_approved_month"
      expr: DATE_TRUNC('MONTH', cost_approved_date)
      comment: "Month of cost approval for costing velocity tracking"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Effective year for cost trend analysis"
    - name: "season_identifier"
      expr: season_id
      comment: "Season identifier for seasonal cost planning"
  measures:
    - name: "total_bom_count"
      expr: COUNT(DISTINCT bom_id)
      comment: "Total number of BOMs for product complexity tracking"
    - name: "total_fob_cost"
      expr: SUM(CAST(fob_cost AS DOUBLE))
      comment: "Total Free On Board cost for landed cost analysis"
    - name: "total_material_cost"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost for supply chain spend"
    - name: "total_cmt_cost"
      expr: SUM(CAST(cmt_cost AS DOUBLE))
      comment: "Total cut-make-trim cost for manufacturing spend"
    - name: "total_duty_cost"
      expr: SUM(CAST(duty_cost AS DOUBLE))
      comment: "Total duty cost for import cost management"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for logistics spend"
    - name: "total_ldp_cost"
      expr: SUM(CAST(ldp_cost AS DOUBLE))
      comment: "Total landed duty paid cost for total landed cost"
    - name: "total_target_cogs"
      expr: SUM(CAST(target_cogs AS DOUBLE))
      comment: "Total target cost of goods sold for margin planning"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value for revenue potential"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average FOB cost per BOM for cost benchmarking"
    - name: "avg_material_cost"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per BOM for sourcing efficiency"
    - name: "avg_cmt_cost"
      expr: AVG(CAST(cmt_cost AS DOUBLE))
      comment: "Average CMT cost per BOM for manufacturing efficiency"
    - name: "avg_imu_percentage"
      expr: AVG(CAST(imu_percentage AS DOUBLE))
      comment: "Average initial markup percentage for profitability"
    - name: "avg_duty_rate"
      expr: AVG(CAST(duty_rate AS DOUBLE))
      comment: "Average duty rate for trade cost optimization"
    - name: "approved_bom_count"
      expr: COUNT(DISTINCT CASE WHEN bom_status = 'Approved' THEN bom_id END)
      comment: "Count of approved BOMs for production readiness"
    - name: "cost_approved_bom_count"
      expr: COUNT(DISTINCT CASE WHEN cost_approval_status = 'Approved' THEN bom_id END)
      comment: "Count of cost-approved BOMs for financial governance"
    - name: "sustainable_bom_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN bom_id END)
      comment: "Count of sustainability-certified BOMs for ESG tracking"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collection-level strategic metrics for seasonal planning, budget management, and portfolio performance"
  source: "`apparel_fashion_ecm`.`product`.`collection`"
  dimensions:
    - name: "collection_status_flag"
      expr: collection_status
      comment: "Collection status (Planning, Active, Closed)"
    - name: "collection_type_category"
      expr: collection_type
      comment: "Collection type (Seasonal, Capsule, Collaboration)"
    - name: "season_year_label"
      expr: season_year
      comment: "Season year for multi-year trend analysis"
    - name: "gender_target_segment"
      expr: gender_target
      comment: "Target gender segment for market focus"
    - name: "price_tier_classification"
      expr: price_tier
      comment: "Price tier (Entry, Mid, Premium, Luxury)"
    - name: "target_channel_strategy"
      expr: target_channel
      comment: "Target sales channel for distribution strategy"
    - name: "geographic_market_region"
      expr: geographic_market
      comment: "Geographic market for regional performance"
    - name: "sustainability_certified_flag"
      expr: sustainability_certified
      comment: "Sustainability certification flag for ESG reporting"
    - name: "active_collection_flag"
      expr: is_active
      comment: "Active status for current portfolio analysis"
    - name: "collaboration_partner_name"
      expr: collaboration_partner
      comment: "Collaboration partner for partnership analysis"
    - name: "planned_launch_quarter"
      expr: DATE_TRUNC('QUARTER', planned_launch_date)
      comment: "Planned launch quarter for pipeline planning"
    - name: "actual_launch_quarter"
      expr: DATE_TRUNC('QUARTER', actual_launch_date)
      comment: "Actual launch quarter for performance tracking"
    - name: "season_identifier"
      expr: season_id
      comment: "Season identifier for seasonal analysis"
  measures:
    - name: "total_collection_count"
      expr: COUNT(DISTINCT collection_id)
      comment: "Total number of collections for portfolio breadth"
    - name: "total_otb_budget"
      expr: SUM(CAST(otb_budget_amount AS DOUBLE))
      comment: "Total open-to-buy budget for financial planning"
    - name: "total_aur_target"
      expr: SUM(CAST(average_unit_retail AS DOUBLE))
      comment: "Total average unit retail target for revenue planning"
    - name: "avg_otb_budget_per_collection"
      expr: AVG(CAST(otb_budget_amount AS DOUBLE))
      comment: "Average OTB budget per collection for investment sizing"
    - name: "avg_aur_per_collection"
      expr: AVG(CAST(average_unit_retail AS DOUBLE))
      comment: "Average unit retail per collection for pricing strategy"
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage for profitability goals"
    - name: "active_collection_count"
      expr: COUNT(DISTINCT CASE WHEN is_active = TRUE THEN collection_id END)
      comment: "Count of active collections for current portfolio"
    - name: "sustainable_collection_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certified = TRUE THEN collection_id END)
      comment: "Count of sustainability-certified collections for ESG goals"
    - name: "collaboration_collection_count"
      expr: COUNT(DISTINCT CASE WHEN collaboration_partner IS NOT NULL THEN collection_id END)
      comment: "Count of collaboration collections for partnership strategy"
    - name: "planning_stage_collection_count"
      expr: COUNT(DISTINCT CASE WHEN collection_status = 'Planning' THEN collection_id END)
      comment: "Count of collections in planning for pipeline visibility"
    - name: "launched_collection_count"
      expr: COUNT(DISTINCT CASE WHEN actual_launch_date IS NOT NULL THEN collection_id END)
      comment: "Count of launched collections for market execution"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_cost_sheet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Detailed cost sheet metrics for product costing, margin analysis, and supply chain financial management"
  source: "`apparel_fashion_ecm`.`product`.`cost_sheet`"
  dimensions:
    - name: "cost_sheet_status_flag"
      expr: cost_sheet_status
      comment: "Cost sheet status (Draft, Approved, Obsolete)"
    - name: "costing_stage_phase"
      expr: costing_stage
      comment: "Costing stage (Preliminary, Target, Final)"
    - name: "country_of_origin_code"
      expr: country_of_origin
      comment: "Manufacturing country for sourcing analysis"
    - name: "destination_country_code"
      expr: destination_country
      comment: "Destination country for duty and logistics planning"
    - name: "currency_code_label"
      expr: currency_code
      comment: "Currency code for multi-currency cost management"
    - name: "incoterm_classification"
      expr: incoterm
      comment: "Incoterm for trade term analysis (FOB, CIF, DDP)"
    - name: "payment_terms_category"
      expr: payment_terms
      comment: "Payment terms for cash flow management"
    - name: "approved_month"
      expr: DATE_TRUNC('MONTH', approved_date)
      comment: "Month of cost sheet approval for costing velocity"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Effective year for cost trend analysis"
    - name: "season_identifier"
      expr: season_id
      comment: "Season identifier for seasonal cost planning"
  measures:
    - name: "total_cost_sheet_count"
      expr: COUNT(DISTINCT cost_sheet_id)
      comment: "Total number of cost sheets for costing activity tracking"
    - name: "total_fob_cost_value"
      expr: SUM(CAST(fob_cost AS DOUBLE))
      comment: "Total FOB cost for manufacturing spend"
    - name: "total_material_cost_value"
      expr: SUM(CAST(material_cost AS DOUBLE))
      comment: "Total material cost for supply chain spend"
    - name: "total_labor_cost_value"
      expr: SUM(CAST(labor_cost AS DOUBLE))
      comment: "Total labor cost for manufacturing efficiency"
    - name: "total_freight_cost_value"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost for logistics spend"
    - name: "total_ldp_cost_value"
      expr: SUM(CAST(ldp_cost AS DOUBLE))
      comment: "Total landed duty paid cost for total landed cost"
    - name: "total_actual_cogs"
      expr: SUM(CAST(actual_cogs AS DOUBLE))
      comment: "Total actual cost of goods sold for margin analysis"
    - name: "total_target_cogs_value"
      expr: SUM(CAST(target_cogs AS DOUBLE))
      comment: "Total target COGS for cost goal tracking"
    - name: "total_msrp_value"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Total MSRP value for revenue potential"
    - name: "total_wholesale_price_value"
      expr: SUM(CAST(wholesale_price AS DOUBLE))
      comment: "Total wholesale price for B2B revenue planning"
    - name: "avg_fob_cost"
      expr: AVG(CAST(fob_cost AS DOUBLE))
      comment: "Average FOB cost per cost sheet for benchmarking"
    - name: "avg_material_cost"
      expr: AVG(CAST(material_cost AS DOUBLE))
      comment: "Average material cost per cost sheet for sourcing efficiency"
    - name: "avg_labor_cost"
      expr: AVG(CAST(labor_cost AS DOUBLE))
      comment: "Average labor cost per cost sheet for manufacturing efficiency"
    - name: "avg_imu_percent"
      expr: AVG(CAST(imu_percent AS DOUBLE))
      comment: "Average initial markup percentage for profitability"
    - name: "avg_target_margin_percent"
      expr: AVG(CAST(target_margin_percent AS DOUBLE))
      comment: "Average target margin percentage for margin goals"
    - name: "approved_cost_sheet_count"
      expr: COUNT(DISTINCT CASE WHEN cost_sheet_status = 'Approved' THEN cost_sheet_id END)
      comment: "Count of approved cost sheets for production readiness"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material-level metrics for sourcing, cost management, sustainability tracking, and supply chain optimization"
  source: "`apparel_fashion_ecm`.`product`.`material`"
  dimensions:
    - name: "material_category_classification"
      expr: material_category
      comment: "Material category (Fabric, Trim, Packaging, Hardware)"
    - name: "material_type_classification"
      expr: material_type
      comment: "Material type for detailed classification"
    - name: "material_status_flag"
      expr: material_status
      comment: "Material status (Active, Discontinued, Pending)"
    - name: "country_of_origin_code"
      expr: country_of_origin
      comment: "Material origin country for sourcing analysis"
    - name: "fiber_composition_label"
      expr: fiber_composition
      comment: "Fiber composition for material specification"
    - name: "finish_treatment_type"
      expr: finish_treatment
      comment: "Finish treatment for performance characteristics"
    - name: "sustainability_certification_flag"
      expr: sustainability_certification
      comment: "Sustainability certification for ESG tracking"
    - name: "gots_certified_flag"
      expr: gots_certified
      comment: "Global Organic Textile Standard certification"
    - name: "oeko_tex_certified_flag"
      expr: oeko_tex_certified
      comment: "OEKO-TEX certification for chemical safety"
    - name: "bci_certified_flag"
      expr: bci_certified
      comment: "Better Cotton Initiative certification"
    - name: "restricted_substance_compliant_flag"
      expr: restricted_substance_compliant
      comment: "Restricted substance compliance for regulatory adherence"
    - name: "season_code_label"
      expr: season_code
      comment: "Season code for seasonal material planning"
    - name: "effective_year"
      expr: YEAR(effective_start_date)
      comment: "Effective year for material lifecycle tracking"
  measures:
    - name: "total_material_count"
      expr: COUNT(DISTINCT material_id)
      comment: "Total number of unique materials for supply chain complexity"
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost for material spend planning"
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material for cost benchmarking"
    - name: "avg_moq_quantity"
      expr: AVG(CAST(moq_quantity AS DOUBLE))
      comment: "Average minimum order quantity for sourcing efficiency"
    - name: "avg_recycled_content_percent"
      expr: AVG(CAST(recycled_content_percentage AS DOUBLE))
      comment: "Average recycled content percentage for sustainability goals"
    - name: "avg_cotton_percentage"
      expr: AVG(CAST(cotton_percentage AS DOUBLE))
      comment: "Average cotton percentage for fiber mix analysis"
    - name: "avg_polyester_percentage"
      expr: AVG(CAST(polyester_percentage AS DOUBLE))
      comment: "Average polyester percentage for synthetic content tracking"
    - name: "avg_weight_gsm"
      expr: AVG(CAST(weight_gsm AS DOUBLE))
      comment: "Average weight in grams per square meter for material specification"
    - name: "avg_width_cm"
      expr: AVG(CAST(width_cm AS DOUBLE))
      comment: "Average width in centimeters for yield calculation"
    - name: "active_material_count"
      expr: COUNT(DISTINCT CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Count of active materials for current sourcing portfolio"
    - name: "sustainable_certified_material_count"
      expr: COUNT(DISTINCT CASE WHEN sustainability_certification IS NOT NULL THEN material_id END)
      comment: "Count of sustainability-certified materials for ESG reporting"
    - name: "gots_certified_material_count"
      expr: COUNT(DISTINCT CASE WHEN gots_certified = TRUE THEN material_id END)
      comment: "Count of GOTS-certified materials for organic tracking"
    - name: "oeko_tex_certified_material_count"
      expr: COUNT(DISTINCT CASE WHEN oeko_tex_certified = TRUE THEN material_id END)
      comment: "Count of OEKO-TEX certified materials for chemical safety"
    - name: "bci_certified_material_count"
      expr: COUNT(DISTINCT CASE WHEN bci_certified = TRUE THEN material_id END)
      comment: "Count of BCI-certified materials for sustainable cotton"
    - name: "compliant_material_count"
      expr: COUNT(DISTINCT CASE WHEN restricted_substance_compliant = TRUE THEN material_id END)
      comment: "Count of restricted substance compliant materials for regulatory adherence"
$$;