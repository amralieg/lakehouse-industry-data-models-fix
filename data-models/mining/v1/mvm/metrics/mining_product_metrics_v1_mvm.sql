-- Metric views for domain: product | Business: Mining | Version: 1 | Generated on: 2026-05-05 14:14:10

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_saleable_product`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the saleable product catalogue — tracks portfolio health, carbon intensity, minimum order economics, and moisture compliance thresholds to support product management and commercial decisions."
  source: "`mining_ecm`.`product`.`saleable_product`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Current lifecycle stage of the product (e.g. Active, Discontinued, Development) — used to filter the active commercial portfolio."
    - name: "product_form"
      expr: product_form
      comment: "Physical form of the product (e.g. Lump, Fines, Pellet, Concentrate) — key commercial and logistics segmentation dimension."
    - name: "processing_route"
      expr: processing_route
      comment: "Processing route used to produce the product (e.g. DMS, Flotation, Crushing) — links product quality to operational cost."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target customer market segment (e.g. Steel Mills, Battery Manufacturers) — supports commercial strategy and portfolio alignment."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country from which the product originates — relevant for export licensing, royalty, and trade compliance reporting."
    - name: "pricing_basis"
      expr: pricing_basis
      comment: "Default pricing basis applied to the product (e.g. CFR, FOB, Index-linked) — drives revenue recognition and contract structuring."
    - name: "available_for_sale_flag"
      expr: available_for_sale_flag
      comment: "Boolean flag indicating whether the product is currently available for sale — used to scope active commercial inventory."
    - name: "export_license_required_flag"
      expr: export_license_required_flag
      comment: "Boolean flag indicating whether an export licence is required — critical for trade compliance and shipment planning."
    - name: "quality_certificate_required_flag"
      expr: quality_certificate_required_flag
      comment: "Boolean flag indicating whether a quality certificate must accompany shipments — affects logistics and customer acceptance."
    - name: "effective_from_date"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month in which the product became commercially effective — used for portfolio vintage and launch cohort analysis."
  measures:
    - name: "total_saleable_products"
      expr: COUNT(1)
      comment: "Total number of saleable product records in the catalogue. Baseline measure for portfolio size tracking."
    - name: "active_saleable_products"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' AND available_for_sale_flag = TRUE THEN 1 END)
      comment: "Count of products that are both in Active lifecycle status and flagged as available for sale. Directly measures the live commercial portfolio size — a key executive KPI for product strategy reviews."
    - name: "avg_carbon_footprint_kg_co2e_per_tonne"
      expr: AVG(CAST(carbon_footprint_kg_co2e_per_tonne AS DOUBLE))
      comment: "Average carbon footprint in kg CO2-equivalent per tonne across the product portfolio. Tracks environmental performance and supports ESG reporting and decarbonisation target-setting."
    - name: "max_carbon_footprint_kg_co2e_per_tonne"
      expr: MAX(CAST(carbon_footprint_kg_co2e_per_tonne AS DOUBLE))
      comment: "Maximum carbon footprint across all products. Identifies the highest-emission product for targeted decarbonisation intervention."
    - name: "avg_minimum_order_quantity_tonnes"
      expr: AVG(CAST(minimum_order_quantity_tonnes AS DOUBLE))
      comment: "Average minimum order quantity in tonnes across the product portfolio. Informs logistics planning, vessel sizing, and customer contract negotiation."
    - name: "avg_moisture_content_max_pct"
      expr: AVG(CAST(moisture_content_max_pct AS DOUBLE))
      comment: "Average maximum permitted moisture content (%) across products. Moisture directly affects product weight, quality compliance, and transportable moisture limit (TML) safety — a critical operational and commercial KPI."
    - name: "products_requiring_export_licence"
      expr: COUNT(CASE WHEN export_license_required_flag = TRUE THEN 1 END)
      comment: "Number of products requiring an export licence. Drives trade compliance workload planning and regulatory risk exposure assessment."
    - name: "products_requiring_quality_certificate"
      expr: COUNT(CASE WHEN quality_certificate_required_flag = TRUE THEN 1 END)
      comment: "Number of products requiring a quality certificate for shipment. Informs laboratory scheduling, certification cost budgeting, and customer service planning."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_specification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quality and specification compliance KPIs — tracks guaranteed grade targets, typical vs guaranteed grade gaps, and specification portfolio health to support product quality management and customer contract governance."
  source: "`mining_ecm`.`product`.`specification`"
  dimensions:
    - name: "specification_type"
      expr: specification_type
      comment: "Type of specification (e.g. Customer, Internal, Export, Regulatory) — segments the specification portfolio by commercial purpose."
    - name: "specification_status"
      expr: specification_status
      comment: "Current status of the specification (e.g. Active, Superseded, Draft) — used to scope live contractual quality commitments."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type covered by the specification (e.g. Iron Ore, Copper, Coal) — enables cross-commodity quality benchmarking."
    - name: "is_customer_specific"
      expr: is_customer_specific
      comment: "Boolean flag indicating whether the specification is tailored to a specific customer — distinguishes bespoke from standard product specs."
    - name: "is_export_specification"
      expr: is_export_specification
      comment: "Boolean flag indicating whether the specification applies to export product — relevant for trade compliance and international quality standards."
    - name: "grade_basis"
      expr: grade_basis
      comment: "Basis on which grade is measured (e.g. Dry, As-Received, Air-Dried) — critical for interpreting all grade KPIs correctly."
    - name: "effective_from_date"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the specification became effective — used for specification vintage and contract renewal cohort analysis."
  measures:
    - name: "total_specifications"
      expr: COUNT(1)
      comment: "Total number of product specifications. Baseline measure for specification portfolio size."
    - name: "active_specifications"
      expr: COUNT(CASE WHEN specification_status = 'Active' THEN 1 END)
      comment: "Number of currently active specifications. Measures the live contractual quality commitment footprint — key for quality governance oversight."
    - name: "customer_specific_specifications"
      expr: COUNT(CASE WHEN is_customer_specific = TRUE THEN 1 END)
      comment: "Number of customer-specific specifications. High counts indicate bespoke product complexity and associated quality management cost."
    - name: "avg_guaranteed_fe_percent_min"
      expr: AVG(CAST(guaranteed_fe_percent_min AS DOUBLE))
      comment: "Average guaranteed minimum iron (Fe) grade across specifications. Tracks the quality floor committed to customers — a primary revenue and pricing driver for iron ore products."
    - name: "avg_guaranteed_moisture_percent_max"
      expr: AVG(CAST(guaranteed_moisture_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum moisture content across specifications. Moisture limits directly affect product weight, TML safety compliance, and customer acceptance — a critical operational KPI."
    - name: "avg_guaranteed_sio2_percent_max"
      expr: AVG(CAST(guaranteed_sio2_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum silica (SiO2) content across specifications. Silica is a key penalty element in iron ore pricing — tracking this drives commercial and blending decisions."
    - name: "avg_guaranteed_al2o3_percent_max"
      expr: AVG(CAST(guaranteed_al2o3_percent_max AS DOUBLE))
      comment: "Average guaranteed maximum alumina (Al2O3) content across specifications. Alumina is a penalty element affecting steel mill efficiency — a key quality KPI for iron ore commercial teams."
    - name: "avg_typical_fe_percent"
      expr: AVG(CAST(typical_fe_percent AS DOUBLE))
      comment: "Average typical iron (Fe) grade across specifications. Used alongside guaranteed Fe to assess the grade buffer above contractual minimums — informs blending strategy and pricing upside."
    - name: "avg_top_size_mm"
      expr: AVG(CAST(top_size_mm AS DOUBLE))
      comment: "Average top size (mm) across specifications. Sizing directly affects product classification (Lump vs Fines), logistics, and customer process compatibility."
    - name: "avg_tml_percent"
      expr: AVG(CAST(tml_percent AS DOUBLE))
      comment: "Average Transportable Moisture Limit (TML %) across specifications. TML is a maritime safety requirement — products shipped above TML risk cargo liquefaction, making this a critical safety and compliance KPI."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_grade_limit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Grade limit and penalty/bonus economics KPIs — tracks contractual grade thresholds, penalty and bonus rates, and compliance tolerances to support commercial negotiation, quality management, and revenue optimisation."
  source: "`mining_ecm`.`product`.`grade_limit`"
  dimensions:
    - name: "limit_type"
      expr: limit_type
      comment: "Type of grade limit (e.g. Maximum, Minimum, Target, Rejection) — classifies the commercial and quality significance of each limit."
    - name: "limit_status"
      expr: limit_status
      comment: "Current status of the grade limit (e.g. Active, Superseded, Draft) — used to scope live contractual grade commitments."
    - name: "parameter_category"
      expr: parameter_category
      comment: "Category of the grade parameter (e.g. Major Element, Penalty Element, Bonus Element) — enables analysis by commercial impact category."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for the grade limit (e.g. %, kcal/kg, ppm) — essential context for interpreting all grade KPIs."
    - name: "effective_from_date"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the grade limit became effective — used for contract vintage and limit revision trend analysis."
  measures:
    - name: "total_grade_limits"
      expr: COUNT(1)
      comment: "Total number of grade limit records. Baseline measure for the contractual grade limit portfolio size."
    - name: "active_grade_limits"
      expr: COUNT(CASE WHEN limit_status = 'Active' THEN 1 END)
      comment: "Number of currently active grade limits. Measures the live contractual quality constraint footprint — key for quality governance and commercial risk management."
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate per unit of grade deviation across all active limits. Directly quantifies the revenue-at-risk per unit of quality shortfall — a primary commercial and blending optimisation KPI."
    - name: "avg_bonus_rate"
      expr: AVG(CAST(bonus_rate AS DOUBLE))
      comment: "Average bonus rate per unit of grade improvement across all limits. Quantifies the revenue upside achievable through quality optimisation — drives blending and processing investment decisions."
    - name: "avg_penalty_threshold"
      expr: AVG(CAST(penalty_threshold AS DOUBLE))
      comment: "Average grade level at which penalties are triggered. Understanding where penalties activate informs blending targets and quality control intervention thresholds."
    - name: "avg_bonus_threshold"
      expr: AVG(CAST(bonus_threshold AS DOUBLE))
      comment: "Average grade level at which bonuses are earned. Identifies the quality target required to capture pricing upside — directly informs production and blending strategy."
    - name: "avg_rejection_limit"
      expr: AVG(CAST(rejection_limit AS DOUBLE))
      comment: "Average grade level at which product is rejected by customers. Rejection limits define the absolute quality floor — breaches result in cargo rejection and significant financial loss."
    - name: "avg_compliance_tolerance"
      expr: AVG(CAST(compliance_tolerance AS DOUBLE))
      comment: "Average compliance tolerance band across grade limits. Wider tolerances reduce quality risk exposure; narrower tolerances increase penalty risk — informs contract negotiation strategy."
    - name: "limits_with_penalty_exposure"
      expr: COUNT(CASE WHEN penalty_rate > 0 THEN 1 END)
      comment: "Number of grade limits that carry a financial penalty. Measures the breadth of penalty exposure across the product portfolio — a key commercial risk KPI."
    - name: "limits_with_bonus_opportunity"
      expr: COUNT(CASE WHEN bonus_rate > 0 THEN 1 END)
      comment: "Number of grade limits that offer a financial bonus. Measures the breadth of revenue upside opportunity — informs quality investment prioritisation."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_pricing_configuration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pricing configuration economics KPIs — tracks penalty and bonus rate structures, provisional pricing percentages, and rejection limit economics to support commercial pricing governance and revenue optimisation."
  source: "`mining_ecm`.`product`.`pricing_configuration`"
  dimensions:
    - name: "configuration_status"
      expr: configuration_status
      comment: "Current status of the pricing configuration (e.g. Active, Superseded, Draft) — scopes live commercial pricing arrangements."
    - name: "adjustment_calculation_method"
      expr: adjustment_calculation_method
      comment: "Method used to calculate price adjustments (e.g. Linear, Stepped, Formula-based) — affects revenue calculation complexity and accuracy."
    - name: "pricing_currency_code"
      expr: pricing_currency_code
      comment: "Currency in which pricing is denominated (e.g. USD, AUD) — essential for multi-currency revenue analysis and FX risk management."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code governing delivery obligations (e.g. FOB, CFR, CIF) — determines cost and risk allocation between seller and buyer."
    - name: "effective_from_date"
      expr: DATE_TRUNC('MONTH', effective_from_date)
      comment: "Month the pricing configuration became effective — used for pricing vintage and contract renewal cohort analysis."
  measures:
    - name: "total_pricing_configurations"
      expr: COUNT(1)
      comment: "Total number of pricing configuration records. Baseline measure for the commercial pricing arrangement portfolio."
    - name: "active_pricing_configurations"
      expr: COUNT(CASE WHEN configuration_status = 'Active' THEN 1 END)
      comment: "Number of currently active pricing configurations. Measures the live commercial pricing footprint — key for revenue governance and contract management oversight."
    - name: "avg_penalty_rate_per_unit"
      expr: AVG(CAST(penalty_rate_per_unit AS DOUBLE))
      comment: "Average penalty rate per unit of grade deviation across pricing configurations. Quantifies the average revenue-at-risk per unit of quality shortfall — a primary commercial risk KPI."
    - name: "avg_bonus_rate_per_unit"
      expr: AVG(CAST(bonus_rate_per_unit AS DOUBLE))
      comment: "Average bonus rate per unit of grade improvement across pricing configurations. Quantifies the average revenue upside per unit of quality improvement — drives quality investment decisions."
    - name: "avg_provisional_pricing_percentage"
      expr: AVG(CAST(provisional_pricing_percentage AS DOUBLE))
      comment: "Average provisional pricing percentage across configurations. Provisional pricing affects cash flow timing — high provisional percentages reduce working capital risk for the seller."
    - name: "avg_penalty_cap_amount"
      expr: AVG(CAST(penalty_cap_amount AS DOUBLE))
      comment: "Average maximum penalty cap amount across pricing configurations. Penalty caps limit downside revenue exposure — tracking this informs contract risk management and negotiation strategy."
    - name: "avg_bonus_cap_amount"
      expr: AVG(CAST(bonus_cap_amount AS DOUBLE))
      comment: "Average maximum bonus cap amount across pricing configurations. Bonus caps limit upside revenue capture — understanding caps informs quality investment return calculations."
    - name: "avg_base_reference_grade"
      expr: AVG(CAST(base_reference_grade AS DOUBLE))
      comment: "Average base reference grade used in pricing calculations. The reference grade is the benchmark from which penalties and bonuses are calculated — a foundational commercial pricing KPI."
    - name: "configurations_with_penalty_exposure"
      expr: COUNT(CASE WHEN penalty_rate_per_unit > 0 THEN 1 END)
      comment: "Number of pricing configurations carrying a penalty rate. Measures the breadth of commercial penalty exposure across the pricing portfolio."
    - name: "configurations_with_bonus_opportunity"
      expr: COUNT(CASE WHEN bonus_rate_per_unit > 0 THEN 1 END)
      comment: "Number of pricing configurations offering a bonus rate. Measures the breadth of revenue upside opportunity across the pricing portfolio — informs quality investment prioritisation."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_blend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Blend design and quality target KPIs — tracks target grade profiles, tolerance ranges, and blend portfolio health to support blending optimisation, quality assurance, and production planning decisions."
  source: "`mining_ecm`.`product`.`blend`"
  dimensions:
    - name: "blend_status"
      expr: blend_status
      comment: "Current status of the blend (e.g. Active, Approved, Superseded) — scopes the live blend design portfolio."
    - name: "blend_type"
      expr: blend_type
      comment: "Type of blend (e.g. Export, Domestic, Trial) — segments blends by commercial purpose and quality regime."
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type of the blend (e.g. Iron Ore, Coal, Copper) — enables cross-commodity blending performance analysis."
    - name: "blending_location_type"
      expr: blending_location_type
      comment: "Type of location where blending occurs (e.g. Stockyard, Port, Plant) — links blend quality to operational location and cost."
    - name: "optimization_objective"
      expr: optimization_objective
      comment: "Primary objective driving blend optimisation (e.g. Maximise Fe, Minimise Cost, Meet Specification) — reveals the commercial and operational trade-offs being managed."
    - name: "complexity_rating"
      expr: complexity_rating
      comment: "Complexity rating of the blend design — higher complexity blends carry greater operational risk and cost, informing resource allocation."
    - name: "approval_date"
      expr: DATE_TRUNC('MONTH', approval_date)
      comment: "Month the blend was approved — used for blend vintage and approval cycle time analysis."
  measures:
    - name: "total_blends"
      expr: COUNT(1)
      comment: "Total number of blend design records. Baseline measure for the blend portfolio size."
    - name: "active_blends"
      expr: COUNT(CASE WHEN blend_status = 'Active' THEN 1 END)
      comment: "Number of currently active blend designs. Measures the live operational blending portfolio — a key production planning and quality management KPI."
    - name: "avg_target_fe_grade_percent"
      expr: AVG(CAST(target_fe_grade_percent AS DOUBLE))
      comment: "Average target iron (Fe) grade across blend designs. Fe grade is the primary value driver for iron ore — tracking blend targets against specifications reveals quality risk and revenue opportunity."
    - name: "avg_target_moisture_percent"
      expr: AVG(CAST(target_moisture_percent AS DOUBLE))
      comment: "Average target moisture content across blend designs. Moisture affects product weight, TML safety, and customer acceptance — a critical operational and commercial quality KPI."
    - name: "avg_target_silica_percent"
      expr: AVG(CAST(target_silica_percent AS DOUBLE))
      comment: "Average target silica (SiO2) content across blend designs. Silica is a key penalty element in iron ore pricing — blend silica targets directly affect revenue outcomes."
    - name: "avg_target_alumina_percent"
      expr: AVG(CAST(target_alumina_percent AS DOUBLE))
      comment: "Average target alumina (Al2O3) content across blend designs. Alumina is a penalty element affecting steel mill efficiency — blend alumina targets drive commercial and processing decisions."
    - name: "avg_target_phosphorus_percent"
      expr: AVG(CAST(target_phosphorus_percent AS DOUBLE))
      comment: "Average target phosphorus content across blend designs. Phosphorus is a critical penalty element with strict customer limits — tracking blend targets against rejection thresholds is essential for cargo acceptance."
    - name: "avg_tolerance_range_percent"
      expr: AVG(CAST(tolerance_range_percent AS DOUBLE))
      comment: "Average tolerance range (%) across blend designs. Wider tolerances provide operational flexibility but increase quality risk — this KPI informs the trade-off between blending precision and operational cost."
    - name: "avg_target_energy_content_kcal_kg"
      expr: AVG(CAST(target_energy_content_kcal_kg AS DOUBLE))
      comment: "Average target energy content (kcal/kg) across blend designs. Energy content is the primary value driver for coal products — tracking blend energy targets against specifications reveals quality risk and pricing impact."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product certification portfolio and cost KPIs — tracks certification coverage, renewal obligations, cost exposure, and compliance status to support regulatory governance, trade compliance, and certification cost management."
  source: "`mining_ecm`.`product`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g. ISO, Environmental, Hazmat, Export) — segments the certification portfolio by regulatory and commercial purpose."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g. Active, Expired, Pending Renewal) — critical for compliance risk monitoring."
    - name: "applicable_jurisdiction"
      expr: applicable_jurisdiction
      comment: "Jurisdiction in which the certification applies — enables compliance gap analysis by market and regulatory regime."
    - name: "applicable_market"
      expr: applicable_market
      comment: "Market for which the certification is required — links certification coverage to commercial market access."
    - name: "compliance_standard"
      expr: compliance_standard
      comment: "Compliance standard the certification satisfies (e.g. ISO 9001, REACH, GHS) — enables analysis by regulatory framework."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which certification costs are denominated — required for multi-currency cost aggregation and budgeting."
    - name: "renewal_required_flag"
      expr: renewal_required_flag
      comment: "Boolean flag indicating whether the certification requires periodic renewal — scopes the renewal management workload."
    - name: "expiry_date"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month in which the certification expires — used for renewal pipeline planning and compliance risk horizon analysis."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of product certification records. Baseline measure for the certification portfolio size."
    - name: "active_certifications"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Number of currently active certifications. Measures the live compliance coverage — a key regulatory governance KPI for market access and trade compliance."
    - name: "certifications_requiring_renewal"
      expr: COUNT(CASE WHEN renewal_required_flag = TRUE THEN 1 END)
      comment: "Number of certifications that require periodic renewal. Drives renewal workload planning, budget forecasting, and compliance risk management."
    - name: "total_certification_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total cost of all certifications in the portfolio. Directly measures the regulatory compliance cost burden — a key input to product cost-to-serve and profitability analysis."
    - name: "avg_certification_cost"
      expr: AVG(CAST(cost AS DOUBLE))
      comment: "Average cost per certification. Benchmarks certification cost efficiency and informs make-vs-buy decisions for certification management."
    - name: "distinct_jurisdictions_covered"
      expr: COUNT(DISTINCT applicable_jurisdiction)
      comment: "Number of distinct jurisdictions covered by active certifications. Measures the regulatory footprint and market access breadth — a strategic KPI for international expansion planning."
    - name: "distinct_compliance_standards_held"
      expr: COUNT(DISTINCT compliance_standard)
      comment: "Number of distinct compliance standards held across the certification portfolio. Measures the regulatory diversity and compliance capability — informs market access strategy."
$$;

CREATE OR REPLACE VIEW `mining_ecm`.`_metrics`.`product_commodity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity portfolio and recovery KPIs — tracks the strategic commodity mix, typical recovery rates, and royalty/hazmat exposure to support portfolio strategy, resource planning, and regulatory compliance decisions."
  source: "`mining_ecm`.`product`.`commodity`"
  dimensions:
    - name: "commodity_class"
      expr: commodity_class
      comment: "Class of commodity (e.g. Base Metal, Bulk Commodity, Energy) — primary portfolio segmentation dimension for strategic analysis."
    - name: "commodity_group"
      expr: commodity_group
      comment: "Commodity group (e.g. Iron Ore, Copper, Coal, Lithium) — enables group-level portfolio and market analysis."
    - name: "commodity_status"
      expr: commodity_status
      comment: "Current status of the commodity (e.g. Active, Discontinued, Exploration) — scopes the active commercial commodity portfolio."
    - name: "primary_end_use_market"
      expr: primary_end_use_market
      comment: "Primary end-use market for the commodity (e.g. Steel, Battery, Energy) — links commodity portfolio to downstream market demand drivers."
    - name: "strategic_importance_level"
      expr: strategic_importance_level
      comment: "Strategic importance classification of the commodity (e.g. Core, Growth, Non-Core) — drives capital allocation and portfolio prioritisation decisions."
    - name: "royalty_applicable"
      expr: royalty_applicable
      comment: "Boolean flag indicating whether royalties apply to the commodity — scopes royalty cost exposure across the portfolio."
    - name: "is_hazardous_material"
      expr: is_hazardous_material
      comment: "Boolean flag indicating whether the commodity is classified as a hazardous material — drives logistics, storage, and regulatory compliance requirements."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Boolean flag indicating whether an export licence is required for the commodity — affects trade compliance workload and market access planning."
  measures:
    - name: "total_commodities"
      expr: COUNT(1)
      comment: "Total number of commodity records in the portfolio. Baseline measure for commodity portfolio breadth."
    - name: "active_commodities"
      expr: COUNT(CASE WHEN commodity_status = 'Active' THEN 1 END)
      comment: "Number of currently active commodities. Measures the live commercial commodity portfolio — a key strategic portfolio management KPI."
    - name: "avg_typical_recovery_rate_percent"
      expr: AVG(CAST(typical_recovery_rate_percent AS DOUBLE))
      comment: "Average typical metallurgical recovery rate (%) across commodities. Recovery rate directly determines the volume of saleable product from ore — a primary operational efficiency and revenue KPI."
    - name: "commodities_with_royalty_obligation"
      expr: COUNT(CASE WHEN royalty_applicable = TRUE THEN 1 END)
      comment: "Number of commodities subject to royalty obligations. Measures the royalty cost exposure breadth across the portfolio — a key financial planning and cost management KPI."
    - name: "commodities_classified_hazardous"
      expr: COUNT(CASE WHEN is_hazardous_material = TRUE THEN 1 END)
      comment: "Number of commodities classified as hazardous materials. Drives HSE compliance workload, logistics cost, and regulatory risk exposure assessment."
    - name: "commodities_requiring_export_licence"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN 1 END)
      comment: "Number of commodities requiring an export licence. Measures trade compliance complexity and regulatory risk exposure — informs government relations and compliance resourcing."
$$;