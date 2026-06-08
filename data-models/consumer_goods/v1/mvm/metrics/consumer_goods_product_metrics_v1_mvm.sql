-- Metric views for domain: product | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over the SKU master. Covers portfolio health, cost structure, sustainability posture, and lifecycle distribution — the primary lens for product portfolio steering decisions."
  source: "`consumer_goods_ecm`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the SKU (e.g. Launch, Growth, Mature, Decline, Discontinued). Used to segment portfolio health and prioritise investment."
    - name: "sku_status"
      expr: sku_status
      comment: "Operational status of the SKU (e.g. Active, Inactive, Discontinued). Drives portfolio rationalisation decisions."
    - name: "portfolio_classification"
      expr: portfolio_classification
      comment: "Strategic portfolio tier (e.g. Core, Innovation, Tail). Used to allocate marketing and supply chain resources."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. Liquid, Powder, Gel, Tablet). Enables cross-form performance comparison."
    - name: "packaging_material_type"
      expr: packaging_material_type
      comment: "Primary packaging material (e.g. PET, HDPE, Glass). Key dimension for sustainability and cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where the SKU is manufactured. Used for trade compliance, tariff exposure, and supply risk analysis."
    - name: "target_demographic"
      expr: target_demographic
      comment: "Intended consumer segment (e.g. Adult, Baby, Senior). Supports portfolio segmentation by consumer cohort."
    - name: "regulatory_category"
      expr: regulatory_category
      comment: "Regulatory classification of the SKU (e.g. OTC Drug, Cosmetic, Food). Critical for compliance reporting."
    - name: "subcategory"
      expr: subcategory
      comment: "Product subcategory within the broader category hierarchy. Enables granular portfolio analysis."
    - name: "launch_year"
      expr: YEAR(launch_date)
      comment: "Year the SKU was launched. Used to analyse portfolio age distribution and innovation pipeline velocity."
    - name: "is_sustainable"
      expr: is_sustainable
      comment: "Flag indicating whether the SKU meets the company sustainability criteria. Used for ESG portfolio reporting."
    - name: "is_regulated_product"
      expr: is_regulated_product
      comment: "Flag indicating whether the SKU is subject to regulatory oversight. Drives compliance workload estimation."
    - name: "is_recyclable_packaging"
      expr: is_recyclable_packaging
      comment: "Flag indicating whether the SKU uses recyclable packaging. Key ESG and retailer-requirement dimension."
  measures:
    - name: "total_active_skus"
      expr: COUNT(CASE WHEN sku_status = 'Active' THEN sku_id END)
      comment: "Count of commercially active SKUs. Baseline portfolio size metric used in every executive portfolio review."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count across all statuses. Used as denominator for portfolio concentration and rationalisation ratios."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Sum of standard cost across all SKUs in USD. Indicates total cost base of the product portfolio; drives margin and pricing decisions."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per SKU. Benchmarks cost efficiency across portfolio segments and lifecycle stages."
    - name: "avg_msrp_usd"
      expr: AVG(CAST(msrp AS DOUBLE))
      comment: "Average manufacturer suggested retail price per SKU. Used to assess pricing tier positioning and margin headroom."
    - name: "total_msrp_usd"
      expr: SUM(CAST(msrp AS DOUBLE))
      comment: "Sum of MSRP across all SKUs. Proxy for total addressable retail value of the portfolio."
    - name: "avg_net_weight_kg"
      expr: AVG(CAST(net_weight_kg AS DOUBLE))
      comment: "Average net weight per SKU in kilograms. Used in logistics cost modelling and packaging efficiency analysis."
    - name: "avg_gross_weight_kg"
      expr: AVG(CAST(gross_weight_kg AS DOUBLE))
      comment: "Average gross weight per SKU in kilograms. Informs freight cost estimation and warehouse slotting decisions."
    - name: "avg_volume_ml"
      expr: AVG(CAST(volume_ml AS DOUBLE))
      comment: "Average fill volume per SKU in millilitres. Used for pack-size strategy and consumer value perception analysis."
    - name: "sustainable_sku_count"
      expr: COUNT(CASE WHEN is_sustainable = TRUE THEN sku_id END)
      comment: "Number of SKUs meeting sustainability criteria. Core ESG KPI tracked in board-level sustainability scorecards."
    - name: "recyclable_packaging_sku_count"
      expr: COUNT(CASE WHEN is_recyclable_packaging = TRUE THEN sku_id END)
      comment: "Number of SKUs with recyclable packaging. Tracks progress against packaging sustainability commitments."
    - name: "regulated_sku_count"
      expr: COUNT(CASE WHEN is_regulated_product = TRUE THEN sku_id END)
      comment: "Number of SKUs subject to regulatory oversight. Drives compliance resource planning and risk exposure assessment."
    - name: "hazardous_sku_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN sku_id END)
      comment: "Number of SKUs classified as hazardous. Used for transport compliance, labelling requirements, and risk management."
    - name: "discontinued_sku_count"
      expr: COUNT(CASE WHEN sku_status = 'Discontinued' THEN sku_id END)
      comment: "Number of discontinued SKUs. Tracks portfolio rationalisation progress and tail-SKU elimination efforts."
    - name: "avg_fefo_threshold_pct"
      expr: AVG(CAST(fefo_threshold_pct AS DOUBLE))
      comment: "Average FEFO (First Expired First Out) threshold percentage across SKUs. Informs inventory freshness policy and waste reduction strategy."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the product Bill of Materials. Covers BOM complexity, compliance posture, cost structure, and manufacturing readiness — essential for R&D, supply chain, and regulatory steering."
  source: "`consumer_goods_ecm`.`product`.`product_bom`"
  dimensions:
    - name: "bom_type"
      expr: bom_type
      comment: "Type of BOM (e.g. Production, Engineering, Costing). Segments BOM analysis by purpose and lifecycle phase."
    - name: "bom_category"
      expr: bom_category
      comment: "Business category of the BOM (e.g. Finished Good, Semi-Finished, Raw Material). Used for portfolio and supply chain segmentation."
    - name: "plm_status"
      expr: plm_status
      comment: "PLM lifecycle status of the BOM (e.g. Draft, Released, Obsolete). Tracks product development pipeline maturity."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the BOM. Critical for launch readiness and compliance gate reviews."
    - name: "plant_code"
      expr: plant_code
      comment: "Manufacturing plant associated with the BOM. Enables plant-level BOM complexity and compliance analysis."
    - name: "bom_level"
      expr: bom_level
      comment: "Depth level within the BOM hierarchy. Used to assess multi-level BOM complexity."
    - name: "gmp_compliant"
      expr: gmp_compliant
      comment: "Flag indicating GMP compliance of the BOM. Mandatory for regulated product categories."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "Flag indicating REACH regulatory compliance. Key for EU market access and chemical safety governance."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO (sustainable palm oil) certification. Tracks sustainable sourcing commitments at BOM level."
    - name: "effective_from_month"
      expr: DATE_TRUNC('MONTH', effective_from)
      comment: "Month the BOM became effective. Used to track BOM release cadence and product development velocity."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total number of BOMs. Baseline measure for BOM portfolio size and complexity management."
    - name: "active_boms"
      expr: COUNT(CASE WHEN deletion_flag = FALSE THEN product_bom_id END)
      comment: "Number of non-deleted, active BOMs. Reflects the live manufacturing recipe portfolio."
    - name: "gmp_compliant_bom_count"
      expr: COUNT(CASE WHEN gmp_compliant = TRUE THEN product_bom_id END)
      comment: "Number of BOMs with confirmed GMP compliance. Tracks regulatory readiness of the manufacturing portfolio."
    - name: "reach_compliant_bom_count"
      expr: COUNT(CASE WHEN reach_compliant = TRUE THEN product_bom_id END)
      comment: "Number of BOMs with REACH compliance confirmed. Tracks EU chemical regulation adherence across the portfolio."
    - name: "rspo_certified_bom_count"
      expr: COUNT(CASE WHEN rspo_certified = TRUE THEN product_bom_id END)
      comment: "Number of BOMs with RSPO certification. Measures sustainable palm oil sourcing coverage."
    - name: "total_base_quantity"
      expr: SUM(CAST(base_quantity AS DOUBLE))
      comment: "Sum of base quantities across all BOMs. Used in production planning and material requirements calculations."
    - name: "avg_base_quantity"
      expr: AVG(CAST(base_quantity AS DOUBLE))
      comment: "Average base quantity per BOM. Benchmarks batch size norms across product categories and plants."
    - name: "avg_lot_size_from"
      expr: AVG(CAST(lot_size_from AS DOUBLE))
      comment: "Average minimum lot size across BOMs. Informs minimum order quantity policy and production scheduling efficiency."
    - name: "avg_lot_size_to"
      expr: AVG(CAST(lot_size_to AS DOUBLE))
      comment: "Average maximum lot size across BOMs. Used to assess production flexibility and capacity utilisation."
    - name: "pending_regulatory_approval_boms"
      expr: COUNT(CASE WHEN regulatory_approval_status NOT IN ('Approved', 'Released') THEN product_bom_id END)
      comment: "Number of BOMs awaiting regulatory approval. Tracks launch risk and compliance bottlenecks in the product pipeline."
    - name: "distinct_skus_with_bom"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs that have at least one BOM defined. Measures BOM coverage of the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over BOM line items. Covers component cost, scrap efficiency, hazardous material exposure, and critical component coverage — key inputs for cost engineering, quality, and regulatory risk management."
  source: "`consumer_goods_ecm`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Type of BOM component (e.g. Raw Material, Packaging, Semi-Finished). Segments cost and risk analysis by component class."
    - name: "bom_item_category"
      expr: bom_item_category
      comment: "SAP/ERP BOM item category (e.g. Stock Item, Non-Stock, Phantom). Used for procurement and planning classification."
    - name: "line_status"
      expr: line_status
      comment: "Status of the BOM line (e.g. Active, Obsolete, Blocked). Filters analysis to live vs. retired components."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the component quantity. Required for quantity normalisation in cost and yield analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which component cost is expressed. Enables multi-currency cost analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Flag indicating whether the component is a hazardous material. Drives safety, transport, and regulatory compliance decisions."
    - name: "is_critical_component"
      expr: is_critical_component
      comment: "Flag indicating whether the component is critical to product performance or supply continuity. Used for dual-sourcing and risk mitigation prioritisation."
    - name: "bulk_material_flag"
      expr: bulk_material_flag
      comment: "Flag indicating bulk material components. Used to separate bulk vs. discrete component cost analysis."
    - name: "issue_method"
      expr: issue_method
      comment: "Method by which the component is issued to production (e.g. Backflush, Manual). Impacts inventory accuracy and production efficiency."
    - name: "valid_from_month"
      expr: DATE_TRUNC('MONTH', valid_from_date)
      comment: "Month from which the BOM line is valid. Used to track component change frequency and BOM revision cadence."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total number of BOM line items. Baseline measure for BOM complexity; high line counts indicate complex formulations."
    - name: "total_component_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE))
      comment: "Total component cost across all BOM lines in USD. Primary cost engineering KPI for material cost management."
    - name: "avg_component_cost_usd"
      expr: AVG(CAST(component_cost_usd AS DOUBLE))
      comment: "Average cost per BOM line component. Benchmarks component cost efficiency and identifies outlier cost drivers."
    - name: "total_required_quantity"
      expr: SUM(CAST(required_quantity AS DOUBLE))
      comment: "Total required quantity across all BOM lines. Used in material requirements planning and procurement volume estimation."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOM lines. Tracks material yield efficiency; high scrap rates signal process improvement opportunities."
    - name: "total_scrap_cost_usd"
      expr: SUM(CAST(component_cost_usd AS DOUBLE) * CAST(scrap_percentage AS DOUBLE) / 100.0)
      comment: "Estimated total scrap cost in USD (component cost × scrap rate). Quantifies waste cost for lean manufacturing initiatives."
    - name: "hazardous_component_count"
      expr: COUNT(CASE WHEN hazardous_material_flag = TRUE THEN bom_line_id END)
      comment: "Number of BOM lines with hazardous materials. Tracks chemical risk exposure and regulatory compliance burden."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN is_critical_component = TRUE THEN bom_line_id END)
      comment: "Number of critical component BOM lines. Drives dual-sourcing strategy and supply continuity risk management."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across BOM line components. Informs procurement lot-size optimisation and working capital management."
    - name: "avg_usage_probability_pct"
      expr: AVG(CAST(usage_probability_pct AS DOUBLE))
      comment: "Average usage probability percentage across BOM lines. Used in probabilistic MRP and alternative component planning."
    - name: "distinct_skus_in_bom_lines"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs represented in BOM lines. Measures BOM coverage breadth across the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_formulation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over product formulations. Covers R&D pipeline health, regulatory approval status, sustainability attributes, and formulation quality parameters — critical for R&D, regulatory, and sustainability governance."
  source: "`consumer_goods_ecm`.`product`.`formulation`"
  dimensions:
    - name: "formulation_type"
      expr: formulation_type
      comment: "Type of formulation (e.g. Rinse-Off, Leave-On, Oral Care). Segments R&D and regulatory analysis by product technology."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Current lifecycle stage of the formulation (e.g. Development, Approved, Obsolete). Tracks R&D pipeline maturity."
    - name: "regulatory_approval_status"
      expr: regulatory_approval_status
      comment: "Regulatory approval status of the formulation. Gate-review KPI for market launch readiness."
    - name: "regulatory_classification"
      expr: regulatory_classification
      comment: "Regulatory classification (e.g. Cosmetic, OTC Drug, Biocide). Determines compliance framework and approval pathway."
    - name: "gmp_compliance_flag"
      expr: gmp_compliance_flag
      comment: "Flag indicating GMP compliance of the formulation. Mandatory for regulated product categories."
    - name: "is_vegan"
      expr: is_vegan
      comment: "Flag indicating vegan formulation status. Tracks portfolio alignment with consumer sustainability preferences."
    - name: "is_cruelty_free"
      expr: is_cruelty_free
      comment: "Flag indicating cruelty-free status. Key consumer-facing sustainability and ethics claim."
    - name: "is_fragrance_free"
      expr: is_fragrance_free
      comment: "Flag indicating fragrance-free formulation. Relevant for sensitive-skin and hypoallergenic product positioning."
    - name: "rspo_certified"
      expr: rspo_certified
      comment: "Flag indicating RSPO certification of the formulation. Tracks sustainable palm oil sourcing at formulation level."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year the formulation was approved. Used to analyse R&D throughput and approval cycle time trends."
    - name: "intended_use"
      expr: intended_use
      comment: "Intended use of the formulation (e.g. Cleansing, Moisturising, Disinfecting). Enables use-case portfolio analysis."
  measures:
    - name: "total_formulations"
      expr: COUNT(1)
      comment: "Total number of formulations. Baseline R&D portfolio size metric."
    - name: "approved_formulations"
      expr: COUNT(CASE WHEN regulatory_approval_status = 'Approved' THEN formulation_id END)
      comment: "Number of regulatory-approved formulations. Tracks the commercially deployable formulation portfolio."
    - name: "gmp_compliant_formulations"
      expr: COUNT(CASE WHEN gmp_compliance_flag = TRUE THEN formulation_id END)
      comment: "Number of GMP-compliant formulations. Measures manufacturing quality standard adherence across the R&D portfolio."
    - name: "vegan_formulation_count"
      expr: COUNT(CASE WHEN is_vegan = TRUE THEN formulation_id END)
      comment: "Number of vegan formulations. Tracks portfolio alignment with vegan consumer segment and sustainability commitments."
    - name: "cruelty_free_formulation_count"
      expr: COUNT(CASE WHEN is_cruelty_free = TRUE THEN formulation_id END)
      comment: "Number of cruelty-free formulations. Tracks ethical sourcing and animal welfare commitments in the portfolio."
    - name: "avg_active_ingredient_pct"
      expr: AVG(CAST(active_ingredient_pct AS DOUBLE))
      comment: "Average active ingredient concentration across formulations. Benchmarks product efficacy and formula potency."
    - name: "avg_total_solid_content_pct"
      expr: AVG(CAST(total_solid_content_pct AS DOUBLE))
      comment: "Average total solid content percentage. Used in formulation quality benchmarking and process efficiency analysis."
    - name: "avg_ph_min"
      expr: AVG(CAST(ph_min AS DOUBLE))
      comment: "Average minimum pH specification across formulations. Tracks formulation stability and skin compatibility benchmarks."
    - name: "avg_ph_max"
      expr: AVG(CAST(ph_max AS DOUBLE))
      comment: "Average maximum pH specification across formulations. Used alongside avg_ph_min to assess pH range breadth and stability risk."
    - name: "avg_viscosity_min_cps"
      expr: AVG(CAST(viscosity_min_cps AS DOUBLE))
      comment: "Average minimum viscosity in centipoise. Informs manufacturing process parameter setting and consumer texture benchmarking."
    - name: "distinct_skus_with_formulation"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with an associated formulation. Measures formulation coverage of the product portfolio."
    - name: "obsolete_formulation_count"
      expr: COUNT(CASE WHEN lifecycle_stage = 'Obsolete' THEN formulation_id END)
      comment: "Number of obsolete formulations. Tracks R&D portfolio hygiene and the pace of formulation retirement."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_formulation_ingredient`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over formulation ingredients. Covers ingredient safety, regulatory compliance, sustainability origin, and concentration risk — essential for regulatory affairs, R&D, and ESG reporting."
  source: "`consumer_goods_ecm`.`product`.`formulation_ingredient`"
  dimensions:
    - name: "ingredient_function"
      expr: ingredient_function
      comment: "Functional role of the ingredient (e.g. Preservative, Emulsifier, Active). Segments ingredient risk and cost analysis by function."
    - name: "ingredient_status"
      expr: ingredient_status
      comment: "Approval status of the ingredient (e.g. Approved, Under Review, Restricted). Tracks regulatory readiness of the ingredient portfolio."
    - name: "fda_status"
      expr: fda_status
      comment: "FDA regulatory status of the ingredient. Critical for US market compliance and product launch readiness."
    - name: "reach_registration_status"
      expr: reach_registration_status
      comment: "REACH registration status of the ingredient. Tracks EU chemical regulation compliance at ingredient level."
    - name: "is_active_ingredient"
      expr: is_active_ingredient
      comment: "Flag indicating whether the ingredient is an active ingredient. Separates efficacy-driving components from excipients."
    - name: "is_restricted_substance"
      expr: is_restricted_substance
      comment: "Flag indicating whether the ingredient is a restricted substance. Drives reformulation and regulatory risk management decisions."
    - name: "is_prohibited_substance"
      expr: is_prohibited_substance
      comment: "Flag indicating whether the ingredient is a prohibited substance. Critical compliance flag — any TRUE value requires immediate action."
    - name: "is_natural_origin"
      expr: is_natural_origin
      comment: "Flag indicating natural origin of the ingredient. Tracks natural/organic portfolio positioning and consumer claim substantiation."
    - name: "is_palm_derived"
      expr: is_palm_derived
      comment: "Flag indicating palm-derived ingredients. Tracks sustainable palm sourcing exposure and RSPO commitment coverage."
    - name: "svhc_flag"
      expr: svhc_flag
      comment: "Flag indicating Substance of Very High Concern (SVHC) under REACH. Highest-priority regulatory risk indicator."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Country of origin of the ingredient. Used for supply chain risk, trade compliance, and geographic concentration analysis."
    - name: "halal_status"
      expr: halal_status
      comment: "Halal certification status of the ingredient. Required for market access in halal-regulated markets."
    - name: "vegan_status"
      expr: vegan_status
      comment: "Vegan status of the ingredient. Supports vegan claim substantiation at formulation level."
  measures:
    - name: "total_ingredient_lines"
      expr: COUNT(1)
      comment: "Total number of formulation ingredient lines. Baseline measure for ingredient portfolio complexity."
    - name: "restricted_substance_count"
      expr: COUNT(CASE WHEN is_restricted_substance = TRUE THEN formulation_ingredient_id END)
      comment: "Number of ingredient lines flagged as restricted substances. Tracks regulatory risk exposure requiring active management."
    - name: "prohibited_substance_count"
      expr: COUNT(CASE WHEN is_prohibited_substance = TRUE THEN formulation_ingredient_id END)
      comment: "Number of ingredient lines flagged as prohibited substances. Critical compliance KPI — any non-zero value triggers immediate reformulation action."
    - name: "svhc_ingredient_count"
      expr: COUNT(CASE WHEN svhc_flag = TRUE THEN formulation_ingredient_id END)
      comment: "Number of SVHC-flagged ingredient lines. Highest-priority REACH compliance KPI for EU market access."
    - name: "natural_origin_ingredient_count"
      expr: COUNT(CASE WHEN is_natural_origin = TRUE THEN formulation_ingredient_id END)
      comment: "Number of natural-origin ingredient lines. Tracks natural ingredient portfolio depth for consumer claim substantiation."
    - name: "palm_derived_ingredient_count"
      expr: COUNT(CASE WHEN is_palm_derived = TRUE THEN formulation_ingredient_id END)
      comment: "Number of palm-derived ingredient lines. Quantifies sustainable palm sourcing exposure for RSPO commitment tracking."
    - name: "avg_concentration_nominal_pct"
      expr: AVG(CAST(concentration_nominal_pct AS DOUBLE))
      comment: "Average nominal concentration percentage across ingredient lines. Benchmarks ingredient loading levels for formulation efficiency analysis."
    - name: "avg_regulatory_max_concentration_pct"
      expr: AVG(CAST(regulatory_max_concentration_pct AS DOUBLE))
      comment: "Average regulatory maximum concentration limit across ingredient lines. Used to assess headroom between actual and permitted concentration levels."
    - name: "avg_natural_origin_index"
      expr: AVG(CAST(natural_origin_index AS DOUBLE))
      comment: "Average natural origin index across ingredient lines. Tracks portfolio-level naturalness score for consumer and retailer reporting."
    - name: "fragrance_allergen_count"
      expr: COUNT(CASE WHEN is_fragrance_allergen = TRUE THEN formulation_ingredient_id END)
      comment: "Number of ingredient lines identified as fragrance allergens. Drives labelling compliance and consumer safety risk management."
    - name: "distinct_formulations_covered"
      expr: COUNT(DISTINCT formulation_id)
      comment: "Number of distinct formulations represented in the ingredient data. Measures ingredient data completeness across the formulation portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over product certifications. Covers certification portfolio health, expiry risk, cost of compliance, and sustainability claim coverage — critical for regulatory affairs, sustainability, and retailer compliance teams."
  source: "`consumer_goods_ecm`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. Organic, Fair Trade, ISO, Halal, Kosher). Segments compliance portfolio by certification scheme."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending Renewal). Tracks compliance portfolio health."
    - name: "sustainability_pillar"
      expr: sustainability_pillar
      comment: "Sustainability pillar the certification supports (e.g. Environmental, Social, Governance). Enables ESG portfolio analysis."
    - name: "applicable_markets"
      expr: applicable_markets
      comment: "Markets where the certification is applicable. Used for market-specific compliance coverage analysis."
    - name: "audit_result"
      expr: audit_result
      comment: "Result of the most recent audit (e.g. Pass, Fail, Conditional). Tracks audit performance and compliance risk."
    - name: "consumer_facing_flag"
      expr: consumer_facing_flag
      comment: "Flag indicating whether the certification is consumer-facing (e.g. on-pack logo). Differentiates marketing claims from internal compliance certifications."
    - name: "retailer_requirement_flag"
      expr: retailer_requirement_flag
      comment: "Flag indicating whether the certification is required by a retailer. Tracks retailer-mandated compliance obligations."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year the certification expires. Used to plan renewal workload and identify near-term expiry risk."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of the certification cost. Required for multi-currency cost of compliance analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications across the portfolio. Baseline measure for compliance portfolio breadth."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of currently active certifications. Tracks live compliance coverage of the product portfolio."
    - name: "expired_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN certification_id END)
      comment: "Number of expired certifications. Identifies compliance gaps requiring immediate renewal action."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total cost of certifications. Tracks total cost of compliance investment across the product portfolio."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification cost efficiency and informs compliance budget planning."
    - name: "consumer_facing_certification_count"
      expr: COUNT(CASE WHEN consumer_facing_flag = TRUE THEN certification_id END)
      comment: "Number of consumer-facing certifications. Tracks on-pack claim portfolio breadth and consumer trust investment."
    - name: "retailer_required_certification_count"
      expr: COUNT(CASE WHEN retailer_requirement_flag = TRUE THEN certification_id END)
      comment: "Number of retailer-mandated certifications. Tracks compliance obligations driven by key retail channel partners."
    - name: "failed_audit_count"
      expr: COUNT(CASE WHEN audit_result = 'Fail' THEN certification_id END)
      comment: "Number of certifications with a failed audit result. Critical quality and compliance risk KPI requiring immediate corrective action."
    - name: "distinct_skus_certified"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one certification. Measures certification coverage breadth across the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over product claims. Covers claim portfolio health, regulatory and legal review status, market coverage, and claim expiry risk — essential for marketing, legal, and regulatory affairs governance."
  source: "`consumer_goods_ecm`.`product`.`product_claim`"
  dimensions:
    - name: "claim_type"
      expr: claim_type
      comment: "Type of product claim (e.g. Efficacy, Environmental, Nutritional, Safety). Segments claim portfolio by claim category."
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the claim (e.g. Active, Withdrawn, Under Review). Tracks live vs. retired claim portfolio."
    - name: "claim_scope"
      expr: claim_scope
      comment: "Scope of the claim (e.g. Global, Regional, Country-specific). Used for market-level claim coverage analysis."
    - name: "channel"
      expr: channel
      comment: "Distribution channel where the claim is used (e.g. Retail, E-commerce, Professional). Enables channel-specific claim compliance analysis."
    - name: "plm_stage"
      expr: plm_stage
      comment: "PLM stage of the claim (e.g. Draft, Approved, Archived). Tracks claim development pipeline maturity."
    - name: "fda_reviewed"
      expr: fda_reviewed
      comment: "Flag indicating FDA review completion. Required for regulated product claims in the US market."
    - name: "ftc_compliant"
      expr: ftc_compliant
      comment: "Flag indicating FTC compliance of the claim. Mandatory for US marketing claims to avoid deceptive advertising risk."
    - name: "marketing_approved"
      expr: marketing_approved
      comment: "Flag indicating marketing team approval of the claim. Tracks internal governance gate completion."
    - name: "legal_reviewed"
      expr: legal_reviewed
      comment: "Flag indicating legal review completion. Tracks legal risk clearance across the claim portfolio."
    - name: "quantitative_claim"
      expr: quantitative_claim
      comment: "Flag indicating whether the claim is quantitative (e.g. '99% effective'). Quantitative claims require stronger substantiation and carry higher regulatory risk."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the claim became effective. Used to analyse claim portfolio age and renewal cadence."
  measures:
    - name: "total_claims"
      expr: COUNT(1)
      comment: "Total number of product claims. Baseline measure for claim portfolio breadth."
    - name: "active_claims"
      expr: COUNT(CASE WHEN claim_status = 'Active' THEN product_claim_id END)
      comment: "Number of currently active claims. Tracks the live consumer-facing and regulatory claim portfolio."
    - name: "withdrawn_claims"
      expr: COUNT(CASE WHEN claim_status = 'Withdrawn' THEN product_claim_id END)
      comment: "Number of withdrawn claims. Tracks claim retraction history; high counts may signal regulatory or legal risk patterns."
    - name: "fda_reviewed_claim_count"
      expr: COUNT(CASE WHEN fda_reviewed = TRUE THEN product_claim_id END)
      comment: "Number of claims with completed FDA review. Tracks US regulatory compliance coverage of the claim portfolio."
    - name: "ftc_compliant_claim_count"
      expr: COUNT(CASE WHEN ftc_compliant = TRUE THEN product_claim_id END)
      comment: "Number of FTC-compliant claims. Tracks US advertising compliance coverage and deceptive advertising risk exposure."
    - name: "legally_reviewed_claim_count"
      expr: COUNT(CASE WHEN legal_reviewed = TRUE THEN product_claim_id END)
      comment: "Number of claims with completed legal review. Measures legal governance coverage of the claim portfolio."
    - name: "marketing_approved_claim_count"
      expr: COUNT(CASE WHEN marketing_approved = TRUE THEN product_claim_id END)
      comment: "Number of marketing-approved claims. Tracks internal approval gate completion for consumer-facing claims."
    - name: "quantitative_claim_count"
      expr: COUNT(CASE WHEN quantitative_claim = TRUE THEN product_claim_id END)
      comment: "Number of quantitative claims. Quantitative claims carry higher substantiation burden; this KPI tracks regulatory risk concentration."
    - name: "distinct_skus_with_claims"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with at least one active claim. Measures claim portfolio coverage across the product range."
    - name: "avg_claim_value"
      expr: AVG(CAST(claim_value AS DOUBLE))
      comment: "Average quantitative claim value across all claims. Used to benchmark claim magnitude and assess consumer expectation levels."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_packaging_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over packaging specifications. Covers packaging cost, sustainability attributes (PCR content, recyclability, FSC/RSPO certification), and specification lifecycle — key for sustainability, procurement, and cost engineering decisions."
  source: "`consumer_goods_ecm`.`product`.`packaging_spec`"
  dimensions:
    - name: "packaging_level"
      expr: packaging_level
      comment: "Packaging hierarchy level (e.g. Primary, Secondary, Tertiary). Segments cost and sustainability analysis by packaging tier."
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Lifecycle status of the packaging specification (e.g. Active, Obsolete, Under Development). Tracks packaging portfolio health."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the packaging specification. Tracks governance gate completion for new packaging introductions."
    - name: "component_type"
      expr: component_type
      comment: "Type of packaging component (e.g. Bottle, Cap, Label, Carton). Enables component-level cost and sustainability analysis."
    - name: "material_composition"
      expr: material_composition
      comment: "Material composition of the packaging (e.g. PET, HDPE, Cardboard). Key dimension for recyclability and sustainability analysis."
    - name: "recyclability_code"
      expr: recyclability_code
      comment: "Recyclability classification code. Tracks packaging recyclability compliance with retailer and regulatory requirements."
    - name: "is_fsc_certified"
      expr: is_fsc_certified
      comment: "Flag indicating FSC (Forest Stewardship Council) certification. Tracks sustainable fibre sourcing in packaging."
    - name: "is_rspo_certified"
      expr: is_rspo_certified
      comment: "Flag indicating RSPO certification for palm-derived packaging materials. Tracks sustainable palm sourcing commitments."
    - name: "hazmat_flag"
      expr: hazmat_flag
      comment: "Flag indicating hazardous material content in packaging. Drives transport compliance and disposal cost analysis."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the packaging component. Used for supply chain risk and trade compliance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which packaging unit cost is expressed. Required for multi-currency cost analysis."
  measures:
    - name: "total_packaging_specs"
      expr: COUNT(1)
      comment: "Total number of packaging specifications. Baseline measure for packaging portfolio complexity."
    - name: "total_packaging_unit_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE))
      comment: "Total packaging unit cost across all specifications. Primary cost engineering KPI for packaging cost management."
    - name: "avg_packaging_unit_cost"
      expr: AVG(CAST(unit_cost AS DOUBLE))
      comment: "Average packaging unit cost per specification. Benchmarks packaging cost efficiency across levels and materials."
    - name: "avg_pcr_content_pct"
      expr: AVG(CAST(pcr_content_pct AS DOUBLE))
      comment: "Average post-consumer recycled (PCR) content percentage across packaging specifications. Tracks progress against PCR content sustainability targets."
    - name: "total_pcr_weighted_cost"
      expr: SUM(CAST(unit_cost AS DOUBLE) * CAST(pcr_content_pct AS DOUBLE) / 100.0)
      comment: "Cost-weighted PCR content across packaging specifications. Quantifies the cost investment in recycled content packaging."
    - name: "fsc_certified_spec_count"
      expr: COUNT(CASE WHEN is_fsc_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of FSC-certified packaging specifications. Tracks sustainable fibre sourcing coverage in the packaging portfolio."
    - name: "rspo_certified_spec_count"
      expr: COUNT(CASE WHEN is_rspo_certified = TRUE THEN packaging_spec_id END)
      comment: "Number of RSPO-certified packaging specifications. Tracks sustainable palm sourcing coverage in packaging."
    - name: "avg_gross_weight_g"
      expr: AVG(CAST(gross_weight_g AS DOUBLE))
      comment: "Average gross weight of packaging specifications in grams. Used for lightweighting initiatives and logistics cost modelling."
    - name: "avg_tare_weight_g"
      expr: AVG(CAST(tare_weight_g AS DOUBLE))
      comment: "Average tare (empty) weight of packaging in grams. Tracks packaging material reduction progress in lightweighting programmes."
    - name: "regulatory_compliant_spec_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN packaging_spec_id END)
      comment: "Number of packaging specifications with confirmed regulatory compliance. Tracks packaging compliance coverage for market access."
    - name: "distinct_skus_with_packaging_spec"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with a defined packaging specification. Measures packaging specification coverage of the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`product_material`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "KPI layer over the material master. Covers material cost, weight, lifecycle health, and hazardous material exposure — key for procurement, supply chain, and regulatory risk management."
  source: "`consumer_goods_ecm`.`product`.`material`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Type of material (e.g. Raw Material, Packaging, Semi-Finished). Primary segmentation dimension for material portfolio analysis."
    - name: "material_status"
      expr: material_status
      comment: "Operational status of the material (e.g. Active, Blocked, Obsolete). Tracks material portfolio health and rationalisation."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the material. Used to segment procurement and supply risk analysis by material maturity."
    - name: "packaging_type"
      expr: packaging_type
      comment: "Packaging type of the material. Enables packaging-specific cost and sustainability analysis."
    - name: "regulatory_status"
      expr: regulatory_status
      comment: "Regulatory status of the material. Tracks compliance clearance for procurement and manufacturing use."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin of the material. Used for supply chain risk, tariff exposure, and geographic concentration analysis."
    - name: "hazardous_flag"
      expr: hazardous_flag
      comment: "Flag indicating hazardous material classification. Drives safety, transport, and disposal compliance decisions."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which material standard cost is expressed. Required for multi-currency cost analysis."
    - name: "effective_from_year"
      expr: YEAR(effective_from)
      comment: "Year the material record became effective. Used to analyse material portfolio age and refresh cadence."
  measures:
    - name: "total_materials"
      expr: COUNT(1)
      comment: "Total number of materials in the master. Baseline measure for material portfolio size and complexity."
    - name: "active_material_count"
      expr: COUNT(CASE WHEN material_status = 'Active' THEN material_id END)
      comment: "Number of active materials. Tracks the live procurement-eligible material portfolio."
    - name: "total_standard_cost"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all materials. Indicates total material cost base for procurement and cost engineering decisions."
    - name: "avg_standard_cost"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per material. Benchmarks material cost efficiency and identifies high-cost outliers."
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average material weight in kilograms. Used in logistics cost modelling and packaging lightweighting analysis."
    - name: "avg_volume_l"
      expr: AVG(CAST(volume_l AS DOUBLE))
      comment: "Average material volume in litres. Informs storage capacity planning and transport optimisation."
    - name: "hazardous_material_count"
      expr: COUNT(CASE WHEN hazardous_flag = TRUE THEN material_id END)
      comment: "Number of hazardous materials. Tracks chemical risk exposure and regulatory compliance burden in the material portfolio."
    - name: "avg_storage_temperature_c"
      expr: AVG(CAST(storage_temperature_c AS DOUBLE))
      comment: "Average required storage temperature in Celsius. Informs cold chain infrastructure requirements and energy cost planning."
    - name: "avg_unit_conversion_factor"
      expr: AVG(CAST(unit_conversion_factor AS DOUBLE))
      comment: "Average unit conversion factor across materials. Used to validate UoM consistency and identify data quality issues in the material master."
$$;