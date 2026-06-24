-- Metric views for domain: product | Business: Semiconductors | Version: 2 | Generated on: 2026-06-23 23:34:49

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ic_catalog`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the IC product catalog — lifecycle health, compliance posture, and portfolio composition used by product management and executives to steer NPI, EOL, and compliance programs."
  source: "`vibe_semiconductors_v1`.`product`.`ic_catalog`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Product lifecycle stage (NPI, Production, EOL, Discontinued) for portfolio segmentation."
    - name: "product_type"
      expr: product_type
      comment: "High-level product category (ASIC, FPGA, Memory, Analog, etc.) for portfolio mix analysis."
    - name: "process_technology"
      expr: process_technology
      comment: "Fabrication process technology node label for technology-generation analysis."
    - name: "target_market"
      expr: target_market
      comment: "End-market segment (Automotive, Industrial, Consumer, Data Center) for market-mix reporting."
    - name: "automotive_qualified"
      expr: automotive_qualified
      comment: "Flag indicating AEC-Q qualification status, used to segment automotive-grade portfolio."
    - name: "npi_phase"
      expr: npi_phase
      comment: "New product introduction phase (Concept, Prototype, Qualification, Release) for pipeline tracking."
    - name: "design_type"
      expr: design_type
      comment: "Design methodology (Full Custom, Standard Cell, Platform) for R&D investment analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory reporting."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for chemical substance regulatory reporting."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "tapeout_year"
      expr: YEAR(tapeout_date)
      comment: "Year of tapeout for cohort analysis of design investment cycles."
    - name: "production_release_year"
      expr: YEAR(production_release_date)
      comment: "Year of production release for time-to-market analysis."
  measures:
    - name: "total_active_products"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of currently active IC catalog entries — baseline portfolio size KPI for executive portfolio reviews."
    - name: "total_products"
      expr: COUNT(1)
      comment: "Total IC catalog entries including all lifecycle stages — used as denominator for lifecycle mix ratios."
    - name: "avg_die_size_mm2"
      expr: AVG(CAST(die_size_mm2 AS DOUBLE))
      comment: "Average die size in mm² across the portfolio — directly impacts wafer cost and yield economics; tracked by product engineering and finance."
    - name: "avg_transistor_count"
      expr: AVG(CAST(transistor_count AS DOUBLE))
      comment: "Average transistor count across catalog products — proxy for design complexity and process node advancement."
    - name: "avg_max_operating_frequency_mhz"
      expr: AVG(CAST(operating_frequency_max_mhz AS DOUBLE))
      comment: "Average maximum operating frequency (MHz) — performance benchmark used in competitive positioning and product roadmap reviews."
    - name: "avg_max_power_mw"
      expr: AVG(CAST(power_max_mw AS DOUBLE))
      comment: "Average peak power consumption (mW) — critical for power envelope compliance in automotive and data center segments."
    - name: "avg_typical_power_mw"
      expr: AVG(CAST(power_typical_mw AS DOUBLE))
      comment: "Average typical power consumption (mW) — used in product positioning and customer power budget analysis."
    - name: "itar_controlled_product_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled products — compliance exposure metric monitored by legal and export control teams."
    - name: "automotive_qualified_product_count"
      expr: COUNT(CASE WHEN automotive_qualified = TRUE THEN 1 END)
      comment: "Count of AEC-Q qualified products — strategic KPI for automotive market penetration and qualification investment."
    - name: "rohs_non_compliant_count"
      expr: COUNT(CASE WHEN rohs_compliant = FALSE THEN 1 END)
      comment: "Count of non-RoHS-compliant products — regulatory risk indicator requiring remediation or EOL planning."
    - name: "eol_announced_product_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN 1 END)
      comment: "Count of products with an EOL announcement — used to track portfolio wind-down and customer migration planning."
    - name: "total_distinct_process_technologies"
      expr: COUNT(DISTINCT process_technology)
      comment: "Number of distinct process technologies in the active portfolio — measures technology diversification and foundry dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sku`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Orderable SKU portfolio KPIs covering pricing, lifecycle, compliance, and availability — used by sales operations, product management, and supply chain to manage the commercial product catalog."
  source: "`vibe_semiconductors_v1`.`product`.`sku`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "SKU lifecycle stage (Active, EOL, Discontinued) for commercial portfolio management."
    - name: "temperature_range"
      expr: temperature_range
      comment: "Operating temperature grade (Commercial, Industrial, Automotive) for market segment analysis."
    - name: "speed_grade"
      expr: speed_grade
      comment: "Speed grade variant for product mix and pricing tier analysis."
    - name: "voltage_variant"
      expr: voltage_variant
      comment: "Voltage variant for power-supply compatibility segmentation."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for trade compliance and tariff analysis."
    - name: "orderable_flag"
      expr: orderable_flag
      comment: "Whether the SKU is currently orderable — used to filter commercial availability."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance status for environmental regulatory segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "halogen_free"
      expr: halogen_free
      comment: "Halogen-free material flag for green product portfolio tracking."
    - name: "eol_announcement_year"
      expr: YEAR(eol_announcement_date)
      comment: "Year of EOL announcement for wind-down cohort analysis."
    - name: "introduction_year"
      expr: YEAR(introduction_date)
      comment: "Year of SKU introduction for portfolio vintage analysis."
  measures:
    - name: "total_orderable_skus"
      expr: COUNT(CASE WHEN orderable_flag = TRUE THEN 1 END)
      comment: "Count of currently orderable SKUs — primary commercial portfolio availability KPI for sales and supply chain."
    - name: "total_skus"
      expr: COUNT(1)
      comment: "Total SKU count across all lifecycle stages — baseline for portfolio breadth analysis."
    - name: "avg_list_price_usd"
      expr: AVG(CAST(list_price_usd AS DOUBLE))
      comment: "Average list price (USD) across SKUs — pricing benchmark used in competitive analysis and margin reviews."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost_usd AS DOUBLE))
      comment: "Average standard cost (USD) — cost baseline for gross margin estimation at the SKU level."
    - name: "avg_unit_weight_grams"
      expr: AVG(CAST(unit_weight_grams AS DOUBLE))
      comment: "Average unit weight (grams) — logistics cost driver used in packaging and shipping cost modeling."
    - name: "total_list_price_usd"
      expr: SUM(CAST(list_price_usd AS DOUBLE))
      comment: "Sum of list prices across SKUs — used as a proxy for total addressable revenue potential of the catalog."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost_usd AS DOUBLE))
      comment: "Sum of standard costs across SKUs — used in cost-of-goods-sold estimation and inventory valuation."
    - name: "eol_sku_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN 1 END)
      comment: "Count of SKUs with an EOL announcement — tracks portfolio wind-down exposure and customer migration urgency."
    - name: "itar_controlled_sku_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled SKUs — export compliance risk metric monitored by legal and trade compliance teams."
    - name: "distinct_speed_grades"
      expr: COUNT(DISTINCT speed_grade)
      comment: "Number of distinct speed grades in the portfolio — measures product variant complexity and SKU proliferation risk."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_family`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product family portfolio KPIs covering technology positioning, yield targets, power efficiency, and lifecycle health — used by product line managers and executives in roadmap and investment reviews."
  source: "`vibe_semiconductors_v1`.`product`.`family`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Family lifecycle stage (Active, EOL, Discontinued) for portfolio health monitoring."
    - name: "business_unit"
      expr: business_unit
      comment: "Business unit owning the product family — for P&L and investment allocation analysis."
    - name: "target_market_segment"
      expr: target_market_segment
      comment: "Target end-market segment (Automotive, Industrial, Consumer, HPC) for market mix analysis."
    - name: "process_technology"
      expr: process_technology
      comment: "Process technology node for technology generation analysis."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type (DUV, EUV) for advanced node investment tracking."
    - name: "family_type"
      expr: family_type
      comment: "Family classification (Platform, Custom, Standard) for portfolio strategy segmentation."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Hierarchy level within the product family tree for roll-up analysis."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for compliance segmentation."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "npi_start_year"
      expr: YEAR(npi_start_date)
      comment: "Year NPI started for pipeline vintage and time-to-market analysis."
    - name: "volume_production_year"
      expr: YEAR(volume_production_date)
      comment: "Year volume production began for ramp performance analysis."
  measures:
    - name: "total_families"
      expr: COUNT(1)
      comment: "Total product families — baseline portfolio breadth KPI for executive portfolio reviews."
    - name: "active_family_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of active product families — measures current portfolio vitality and investment focus."
    - name: "avg_target_yield_percent"
      expr: AVG(CAST(target_yield_percent AS DOUBLE))
      comment: "Average target wafer yield (%) across families — yield target benchmark used in cost modeling and fab negotiations."
    - name: "avg_target_power_mw"
      expr: AVG(CAST(target_power_mw AS DOUBLE))
      comment: "Average target power consumption (mW) — power efficiency benchmark for product roadmap and competitive positioning."
    - name: "avg_typical_die_size_mm2"
      expr: AVG(CAST(typical_die_size_mm2 AS DOUBLE))
      comment: "Average typical die size (mm²) — cost driver metric used in wafer cost modeling and pricing strategy."
    - name: "avg_dft_coverage_percent"
      expr: AVG(CAST(dft_coverage_percent AS DOUBLE))
      comment: "Average design-for-test coverage (%) — quality and testability metric used in test cost and escape risk reviews."
    - name: "avg_dfm_score"
      expr: AVG(CAST(dfm_score AS DOUBLE))
      comment: "Average design-for-manufacturability score — manufacturing readiness KPI used in NPI gate reviews."
    - name: "eol_announced_family_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN 1 END)
      comment: "Count of families with EOL announcements — portfolio wind-down exposure metric for customer migration planning."
    - name: "itar_controlled_family_count"
      expr: COUNT(CASE WHEN itar_controlled_flag = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled product families — export compliance risk metric for legal and trade compliance teams."
    - name: "distinct_process_technologies"
      expr: COUNT(DISTINCT process_technology)
      comment: "Number of distinct process technologies across families — measures technology diversification and foundry dependency risk."
    - name: "distinct_target_markets"
      expr: COUNT(DISTINCT target_market_segment)
      comment: "Number of distinct target market segments served — measures market diversification of the product portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_spec`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product specification performance KPIs tracking design achievement vs. targets for frequency, power, and die area — used by product engineering and executives to assess design quality and NPI readiness."
  source: "`vibe_semiconductors_v1`.`product`.`product_spec`"
  dimensions:
    - name: "spec_status"
      expr: spec_status
      comment: "Specification approval status (Draft, Approved, Superseded) for governance tracking."
    - name: "process_node_nm"
      expr: process_node_nm
      comment: "Process node in nanometers for technology generation segmentation."
    - name: "automotive_grade"
      expr: automotive_grade
      comment: "Automotive grade classification (AEC-Q100, AEC-Q101) for market segment analysis."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (FinFET, Planar, GAA) for technology analysis."
    - name: "package_type"
      expr: package_type
      comment: "Package type for packaging cost and thermal analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "functional_safety_rating"
      expr: functional_safety_rating
      comment: "Functional safety rating (ASIL-A through ASIL-D) for automotive safety compliance tracking."
    - name: "characterization_year"
      expr: YEAR(characterization_date)
      comment: "Year of characterization for spec vintage analysis."
    - name: "approval_year"
      expr: YEAR(approval_date)
      comment: "Year of spec approval for NPI milestone tracking."
  measures:
    - name: "total_specs"
      expr: COUNT(1)
      comment: "Total product specifications — baseline count for spec governance and NPI pipeline tracking."
    - name: "avg_max_frequency_achieved_mhz"
      expr: AVG(CAST(max_frequency_achieved_mhz AS DOUBLE))
      comment: "Average achieved maximum frequency (MHz) — performance attainment metric used in product positioning and competitive benchmarking."
    - name: "avg_max_frequency_target_mhz"
      expr: AVG(CAST(max_frequency_target_mhz AS DOUBLE))
      comment: "Average target maximum frequency (MHz) — design intent baseline for frequency attainment gap analysis."
    - name: "avg_dynamic_power_achieved_mw"
      expr: AVG(CAST(dynamic_power_achieved_mw AS DOUBLE))
      comment: "Average achieved dynamic power (mW) — power attainment metric for thermal and battery-life compliance reviews."
    - name: "avg_dynamic_power_target_mw"
      expr: AVG(CAST(dynamic_power_target_mw AS DOUBLE))
      comment: "Average target dynamic power (mW) — power design intent baseline for power attainment gap analysis."
    - name: "avg_leakage_power_achieved_mw"
      expr: AVG(CAST(leakage_power_achieved_mw AS DOUBLE))
      comment: "Average achieved leakage power (mW) — standby power metric critical for IoT and mobile product segments."
    - name: "avg_die_area_achieved_mm2"
      expr: AVG(CAST(die_area_achieved_mm2 AS DOUBLE))
      comment: "Average achieved die area (mm²) — cost driver metric used in wafer cost and yield modeling."
    - name: "avg_die_area_target_mm2"
      expr: AVG(CAST(die_area_target_mm2 AS DOUBLE))
      comment: "Average target die area (mm²) — design intent baseline for die area attainment gap analysis."
    - name: "avg_esd_protection_level_kv"
      expr: AVG(CAST(esd_protection_level_kv AS DOUBLE))
      comment: "Average ESD protection level (kV) — reliability metric used in qualification and customer acceptance reviews."
    - name: "avg_operating_temp_max_c"
      expr: AVG(CAST(operating_temperature_max_c AS DOUBLE))
      comment: "Average maximum operating temperature (°C) — thermal envelope metric for market segment qualification."
    - name: "approved_spec_count"
      expr: COUNT(CASE WHEN spec_status = 'Approved' THEN 1 END)
      comment: "Count of approved product specifications — NPI readiness KPI used in program gate reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_pcn`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product Change Notification KPIs tracking change volume, customer impact, qualification status, and compliance — used by product management, quality, and customer success teams to manage change risk and customer communication."
  source: "`vibe_semiconductors_v1`.`product`.`pcn`"
  dimensions:
    - name: "pcn_status"
      expr: pcn_status
      comment: "PCN workflow status (Draft, Issued, Closed, Withdrawn) for change management tracking."
    - name: "pcn_type"
      expr: pcn_type
      comment: "Type of product change (Process, Material, Package, Design) for change category analysis."
    - name: "change_category"
      expr: change_category
      comment: "Change category classification for impact severity segmentation."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Qualification status of the change (Not Started, In Progress, Complete) for readiness tracking."
    - name: "automotive_qualification_required_flag"
      expr: automotive_qualification_required_flag
      comment: "Flag indicating automotive re-qualification is required — used to prioritize high-risk changes."
    - name: "customer_approval_required_flag"
      expr: customer_approval_required_flag
      comment: "Flag indicating customer approval is required before implementation — tracks change governance compliance."
    - name: "samples_available_flag"
      expr: samples_available_flag
      comment: "Flag indicating samples are available for customer evaluation — used in customer communication planning."
    - name: "notification_year"
      expr: YEAR(notification_date)
      comment: "Year of PCN notification for trend analysis of change frequency."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year of change effectivity for implementation timeline analysis."
  measures:
    - name: "total_pcns"
      expr: COUNT(1)
      comment: "Total PCNs issued — baseline change volume KPI for product change governance reviews."
    - name: "open_pcn_count"
      expr: COUNT(CASE WHEN pcn_status NOT IN ('Closed', 'Withdrawn') THEN 1 END)
      comment: "Count of open/active PCNs — operational backlog metric for product management and customer success teams."
    - name: "automotive_qualification_required_count"
      expr: COUNT(CASE WHEN automotive_qualification_required_flag = TRUE THEN 1 END)
      comment: "Count of PCNs requiring automotive re-qualification — high-risk change exposure metric for automotive program managers."
    - name: "customer_approval_required_count"
      expr: COUNT(CASE WHEN customer_approval_required_flag = TRUE THEN 1 END)
      comment: "Count of PCNs requiring customer approval — customer relationship risk metric for account management."
    - name: "qualification_complete_count"
      expr: COUNT(CASE WHEN qualification_status = 'Complete' THEN 1 END)
      comment: "Count of PCNs with completed qualification — implementation readiness KPI for change release planning."
    - name: "distinct_affected_products"
      expr: COUNT(DISTINCT primary_pcn_ic_catalog_id)
      comment: "Number of distinct products affected by PCNs — portfolio change exposure breadth metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_qualification_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product qualification program KPIs tracking qualification progress, test coverage, and completion rates — used by quality, product engineering, and program management to ensure products meet reliability and market standards before release."
  source: "`vibe_semiconductors_v1`.`product`.`product_qualification_program`"
  dimensions:
    - name: "program_status"
      expr: program_status
      comment: "Qualification program status (Planned, In Progress, Complete, Failed) for pipeline tracking."
    - name: "qualification_type"
      expr: qualification_type
      comment: "Type of qualification (AEC-Q100, JEDEC, Customer-Specific) for standard compliance analysis."
    - name: "qualification_standard"
      expr: qualification_standard
      comment: "Governing qualification standard for regulatory and customer requirement tracking."
    - name: "deviation_granted"
      expr: deviation_granted
      comment: "Flag indicating a qualification deviation was granted — risk indicator for quality governance."
    - name: "waiver_granted"
      expr: waiver_granted
      comment: "Flag indicating a qualification waiver was granted — risk indicator for quality governance."
    - name: "htol_enabled"
      expr: htol_enabled
      comment: "Flag indicating High Temperature Operating Life test is included — reliability test coverage indicator."
    - name: "hast_enabled"
      expr: hast_enabled
      comment: "Flag indicating Highly Accelerated Stress Test is included — reliability test coverage indicator."
    - name: "tc_enabled"
      expr: tc_enabled
      comment: "Flag indicating Thermal Cycling test is included — reliability test coverage indicator."
    - name: "planned_start_year"
      expr: YEAR(planned_start_date)
      comment: "Planned start year for qualification pipeline scheduling."
    - name: "actual_completion_year"
      expr: YEAR(actual_completion_date)
      comment: "Actual completion year for qualification cycle time analysis."
  measures:
    - name: "total_qualification_programs"
      expr: COUNT(1)
      comment: "Total qualification programs — baseline pipeline size KPI for quality and program management reviews."
    - name: "completed_program_count"
      expr: COUNT(CASE WHEN program_status = 'Complete' THEN 1 END)
      comment: "Count of completed qualification programs — product release readiness KPI for executive program reviews."
    - name: "in_progress_program_count"
      expr: COUNT(CASE WHEN program_status = 'In Progress' THEN 1 END)
      comment: "Count of qualification programs currently in progress — active pipeline metric for resource planning."
    - name: "deviation_granted_count"
      expr: COUNT(CASE WHEN deviation_granted = TRUE THEN 1 END)
      comment: "Count of programs with granted deviations — quality risk exposure metric for compliance and audit reviews."
    - name: "waiver_granted_count"
      expr: COUNT(CASE WHEN waiver_granted = TRUE THEN 1 END)
      comment: "Count of programs with granted waivers — quality risk exposure metric for compliance and audit reviews."
    - name: "distinct_products_in_qualification"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct products currently in qualification — NPI pipeline breadth metric for product management."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Materials KPIs covering cost, compliance, and complexity — used by product engineering, supply chain, and finance to manage material costs, regulatory compliance, and BOM governance."
  source: "`vibe_semiconductors_v1`.`product`.`bom`"
  dimensions:
    - name: "bom_status"
      expr: bom_status
      comment: "BOM approval and lifecycle status (Draft, Released, Obsolete) for governance tracking."
    - name: "bom_type"
      expr: bom_type
      comment: "BOM type (Engineering, Manufacturing, Sales) for process-stage analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag for chemical substance regulatory segmentation."
    - name: "conflict_minerals_compliant_flag"
      expr: conflict_minerals_compliant_flag
      comment: "Conflict minerals compliance flag for supply chain ethics and regulatory reporting."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "critical_material_flag"
      expr: critical_material_flag
      comment: "Flag indicating the BOM contains critical materials — supply chain risk indicator."
    - name: "explosion_type"
      expr: explosion_type
      comment: "BOM explosion type (Single-Level, Multi-Level) for cost roll-up analysis."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year BOM became effective for vintage and change frequency analysis."
  measures:
    - name: "total_boms"
      expr: COUNT(1)
      comment: "Total BOM records — baseline count for BOM governance and change management reviews."
    - name: "total_material_cost_usd"
      expr: SUM(CAST(total_material_cost AS DOUBLE))
      comment: "Total material cost across all BOMs — primary cost-of-goods-sold input used in finance and pricing reviews."
    - name: "avg_material_cost_usd"
      expr: AVG(CAST(total_material_cost AS DOUBLE))
      comment: "Average material cost per BOM — cost benchmark used in product pricing and margin analysis."
    - name: "avg_lot_size"
      expr: AVG(CAST(lot_size AS DOUBLE))
      comment: "Average BOM lot size — production planning metric used in manufacturing cost modeling."
    - name: "avg_scrap_percentage"
      expr: AVG(CAST(scrap_percentage AS DOUBLE))
      comment: "Average scrap percentage across BOMs — manufacturing efficiency metric used in yield and cost improvement programs."
    - name: "non_rohs_compliant_bom_count"
      expr: COUNT(CASE WHEN rohs_compliant_flag = FALSE THEN 1 END)
      comment: "Count of non-RoHS-compliant BOMs — regulatory risk metric requiring remediation or EOL action."
    - name: "conflict_minerals_non_compliant_count"
      expr: COUNT(CASE WHEN conflict_minerals_compliant_flag = FALSE THEN 1 END)
      comment: "Count of BOMs not compliant with conflict minerals requirements — supply chain ethics and regulatory risk metric."
    - name: "critical_material_bom_count"
      expr: COUNT(CASE WHEN critical_material_flag = TRUE THEN 1 END)
      comment: "Count of BOMs containing critical materials — supply chain risk exposure metric for procurement and operations."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_bom_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "BOM line-level KPIs covering component cost, compliance, sourcing risk, and complexity — used by supply chain, product engineering, and compliance teams to manage component-level risk and cost."
  source: "`vibe_semiconductors_v1`.`product`.`bom_line`"
  dimensions:
    - name: "component_type"
      expr: component_type
      comment: "Component type classification (Active, Passive, Mechanical) for portfolio mix analysis."
    - name: "make_or_buy_indicator"
      expr: make_or_buy_indicator
      comment: "Make vs. buy decision indicator for sourcing strategy analysis."
    - name: "rohs_compliant_flag"
      expr: rohs_compliant_flag
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant_flag"
      expr: reach_compliant_flag
      comment: "REACH compliance flag for chemical substance regulatory segmentation."
    - name: "single_source_flag"
      expr: single_source_flag
      comment: "Flag indicating single-source components — supply chain concentration risk indicator."
    - name: "critical_component_flag"
      expr: critical_component_flag
      comment: "Flag indicating critical components — supply chain risk prioritization indicator."
    - name: "itar_controlled_flag"
      expr: itar_controlled_flag
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "phantom_bom_flag"
      expr: phantom_bom_flag
      comment: "Flag indicating phantom BOM lines (planning-only, not physically built) for cost accuracy."
    - name: "active_flag"
      expr: active_flag
      comment: "Active status flag for filtering current vs. obsolete BOM lines."
    - name: "conflict_minerals_status"
      expr: conflict_minerals_status
      comment: "Conflict minerals compliance status for supply chain ethics reporting."
  measures:
    - name: "total_bom_lines"
      expr: COUNT(1)
      comment: "Total BOM line items — baseline complexity metric for BOM governance and engineering change management."
    - name: "total_standard_cost_usd"
      expr: SUM(CAST(standard_cost AS DOUBLE))
      comment: "Total standard cost across all BOM lines — component cost roll-up used in product cost modeling and margin analysis."
    - name: "avg_standard_cost_usd"
      expr: AVG(CAST(standard_cost AS DOUBLE))
      comment: "Average standard cost per BOM line — component cost benchmark for procurement negotiation and cost reduction programs."
    - name: "avg_quantity_per_assembly"
      expr: AVG(CAST(quantity_per_assembly AS DOUBLE))
      comment: "Average component quantity per assembly — used in material requirements planning and cost scaling analysis."
    - name: "avg_scrap_factor_percent"
      expr: AVG(CAST(scrap_factor_percent AS DOUBLE))
      comment: "Average scrap factor (%) across BOM lines — manufacturing waste metric used in yield improvement and cost reduction programs."
    - name: "single_source_component_count"
      expr: COUNT(CASE WHEN single_source_flag = TRUE THEN 1 END)
      comment: "Count of single-source BOM lines — supply chain concentration risk metric for procurement and operations reviews."
    - name: "critical_component_count"
      expr: COUNT(CASE WHEN critical_component_flag = TRUE THEN 1 END)
      comment: "Count of critical component BOM lines — supply chain risk exposure metric for executive supply chain reviews."
    - name: "non_rohs_compliant_line_count"
      expr: COUNT(CASE WHEN rohs_compliant_flag = FALSE THEN 1 END)
      comment: "Count of non-RoHS-compliant BOM lines — regulatory risk metric requiring component substitution or EOL action."
    - name: "distinct_manufacturers"
      expr: COUNT(DISTINCT manufacturer_name)
      comment: "Number of distinct component manufacturers — supply base diversification metric for procurement strategy reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_license_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "IP license agreement KPIs covering revenue, royalty rates, exclusivity, and portfolio health — used by legal, finance, and product management to manage IP monetization and licensing risk."
  source: "`vibe_semiconductors_v1`.`product`.`license_agreement`"
  dimensions:
    - name: "license_agreement_status"
      expr: license_agreement_status
      comment: "License agreement status (Active, Expired, Terminated) for portfolio health monitoring."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model (Royalty, Paid-Up, Subscription) for revenue model analysis."
    - name: "exclusivity_flag"
      expr: exclusivity_flag
      comment: "Exclusivity flag — used to segment exclusive vs. non-exclusive agreements for strategic IP analysis."
    - name: "exclusivity_type"
      expr: exclusivity_type
      comment: "Type of exclusivity (Field-of-Use, Territory, Full) for IP strategy analysis."
    - name: "sublicense_allowed_flag"
      expr: sublicense_allowed_flag
      comment: "Flag indicating sublicensing is permitted — IP distribution risk indicator."
    - name: "auto_renewal_flag"
      expr: auto_renewal_flag
      comment: "Auto-renewal flag for contract management and revenue continuity planning."
    - name: "payment_frequency"
      expr: payment_frequency
      comment: "Payment frequency (Annual, Quarterly, Monthly) for cash flow planning."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year agreement became effective for portfolio vintage analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year of agreement expiration for renewal pipeline management."
  measures:
    - name: "total_agreements"
      expr: COUNT(1)
      comment: "Total license agreements — baseline IP portfolio size KPI for legal and finance reviews."
    - name: "active_agreement_count"
      expr: COUNT(CASE WHEN license_agreement_status = 'Active' THEN 1 END)
      comment: "Count of active license agreements — current IP revenue-generating portfolio metric."
    - name: "total_annual_fee_usd"
      expr: SUM(CAST(annual_fee_usd AS DOUBLE))
      comment: "Total annual license fees (USD) — recurring IP revenue metric used in finance and IP monetization reviews."
    - name: "total_annual_maintenance_fee_usd"
      expr: SUM(CAST(annual_maintenance_fee_usd AS DOUBLE))
      comment: "Total annual maintenance fees (USD) — recurring IP support revenue metric."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE costs (USD) across license agreements — upfront IP development cost recovery metric."
    - name: "total_minimum_royalty_usd"
      expr: SUM(CAST(minimum_royalty_usd AS DOUBLE))
      comment: "Total minimum guaranteed royalties (USD) — floor revenue metric for IP monetization planning."
    - name: "total_royalty_cap_usd"
      expr: SUM(CAST(royalty_cap_usd AS DOUBLE))
      comment: "Total royalty caps (USD) — maximum IP revenue ceiling metric for financial forecasting."
    - name: "avg_royalty_rate_percent"
      expr: AVG(CAST(royalty_rate_percent AS DOUBLE))
      comment: "Average royalty rate (%) across agreements — IP pricing benchmark used in negotiation and competitive analysis."
    - name: "avg_per_unit_royalty_usd"
      expr: AVG(CAST(per_unit_royalty_usd AS DOUBLE))
      comment: "Average per-unit royalty (USD) — unit economics metric for IP revenue modeling."
    - name: "total_maximum_units_authorized"
      expr: SUM(CAST(maximum_units_authorized AS DOUBLE))
      comment: "Total maximum units authorized across agreements — IP volume exposure metric for compliance monitoring."
    - name: "exclusive_agreement_count"
      expr: COUNT(CASE WHEN exclusivity_flag = TRUE THEN 1 END)
      comment: "Count of exclusive license agreements — strategic IP exclusivity exposure metric for product and legal strategy."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_license_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "License allocation KPIs tracking utilization, compliance, and remaining capacity — used by legal, compliance, and finance teams to monitor IP license consumption and prevent over-allocation."
  source: "`vibe_semiconductors_v1`.`product`.`license_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Allocation status (Active, Expired, Revoked) for portfolio health monitoring."
    - name: "allocation_type"
      expr: allocation_type
      comment: "Allocation type (Volume, Value, Time-Bound) for license structure analysis."
    - name: "eccn_classification"
      expr: eccn_classification
      comment: "ECCN export control classification for trade compliance segmentation."
    - name: "is_active_flag"
      expr: is_active_flag
      comment: "Active flag for filtering current vs. expired allocations."
    - name: "is_revoked"
      expr: is_revoked
      comment: "Revocation flag — compliance risk indicator for legal and export control reviews."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year allocation was issued for cohort analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year allocation expires for renewal and compliance planning."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total license allocations — baseline count for IP compliance and license management reviews."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total allocated license units — IP volume commitment metric for compliance and capacity planning."
    - name: "total_consumed_quantity"
      expr: SUM(CAST(consumed_quantity AS DOUBLE))
      comment: "Total consumed license units — actual IP utilization metric for compliance monitoring."
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining license units — available IP capacity metric for sales and compliance planning."
    - name: "total_allocation_value_usd"
      expr: SUM(CAST(allocation_value_usd AS DOUBLE))
      comment: "Total value of license allocations (USD) — IP revenue commitment metric for finance reviews."
    - name: "total_authorized_value_usd"
      expr: SUM(CAST(authorized_value_usd AS DOUBLE))
      comment: "Total authorized license value (USD) — maximum IP revenue authorization metric for compliance."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average license utilization rate (%) — IP consumption efficiency metric used in license renewal and pricing negotiations."
    - name: "revoked_allocation_count"
      expr: COUNT(CASE WHEN is_revoked = TRUE THEN 1 END)
      comment: "Count of revoked allocations — compliance incident metric for legal and export control reviews."
    - name: "total_authorized_quantity"
      expr: SUM(CAST(authorized_quantity AS DOUBLE))
      comment: "Total authorized license quantity — maximum volume authorization metric for compliance capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ltb_notification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Last-Time-Buy notification KPIs tracking revenue, customer acknowledgment, and discontinuance pipeline — used by product management, sales, and finance to manage EOL revenue capture and customer transition."
  source: "`vibe_semiconductors_v1`.`product`.`product_ltb_notification`"
  dimensions:
    - name: "notification_status"
      expr: notification_status
      comment: "LTB notification status (Draft, Issued, Closed) for pipeline management."
    - name: "notification_type"
      expr: notification_type
      comment: "Notification type (LTB, EOL, Discontinuance) for classification analysis."
    - name: "discontinuance_reason_code"
      expr: discontinuance_reason_code
      comment: "Reason code for product discontinuance for root cause and trend analysis."
    - name: "customer_acknowledgment_required"
      expr: customer_acknowledgment_required
      comment: "Flag indicating customer acknowledgment is required — customer communication governance indicator."
    - name: "regulatory_approval_required"
      expr: regulatory_approval_required
      comment: "Flag indicating regulatory approval is required before discontinuance — compliance risk indicator."
    - name: "replacement_product_qualification_required"
      expr: replacement_product_qualification_required
      comment: "Flag indicating replacement product qualification is required — customer transition risk indicator."
    - name: "notification_channel"
      expr: notification_channel
      comment: "Communication channel used for notification (Email, Portal, Direct) for customer engagement analysis."
    - name: "notification_issue_year"
      expr: YEAR(notification_issue_date)
      comment: "Year notification was issued for EOL pipeline trend analysis."
    - name: "final_order_year"
      expr: YEAR(final_order_date)
      comment: "Year of final order deadline for revenue capture planning."
  measures:
    - name: "total_ltb_notifications"
      expr: COUNT(1)
      comment: "Total LTB notifications issued — baseline EOL pipeline size KPI for product management and sales reviews."
    - name: "total_actual_ltb_revenue_usd"
      expr: SUM(CAST(actual_ltb_revenue AS DOUBLE))
      comment: "Total actual LTB revenue captured (USD) — EOL revenue realization metric used in finance and product management reviews."
    - name: "total_estimated_ltb_revenue_usd"
      expr: SUM(CAST(estimated_ltb_revenue AS DOUBLE))
      comment: "Total estimated LTB revenue (USD) — EOL revenue forecast metric for financial planning."
    - name: "customer_acknowledgment_required_count"
      expr: COUNT(CASE WHEN customer_acknowledgment_required = TRUE THEN 1 END)
      comment: "Count of LTB notifications requiring customer acknowledgment — customer communication workload metric."
    - name: "regulatory_approval_required_count"
      expr: COUNT(CASE WHEN regulatory_approval_required = TRUE THEN 1 END)
      comment: "Count of LTB notifications requiring regulatory approval — compliance risk exposure metric."
    - name: "replacement_qualification_required_count"
      expr: COUNT(CASE WHEN replacement_product_qualification_required = TRUE THEN 1 END)
      comment: "Count of LTBs requiring replacement product qualification — customer transition complexity metric."
    - name: "distinct_products_in_ltb"
      expr: COUNT(DISTINCT primary_replacement_product_ic_catalog_id)
      comment: "Number of distinct products with LTB notifications — EOL portfolio breadth metric for executive reviews."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_compliance_cert`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product compliance certification KPIs tracking certification coverage, expiry risk, and regulatory posture — used by compliance, legal, and product management to manage regulatory obligations and customer requirements."
  source: "`vibe_semiconductors_v1`.`product`.`compliance_cert`"
  dimensions:
    - name: "certification_status"
      expr: certification_status
      comment: "Certification status (Active, Expired, Revoked, Pending) for compliance posture monitoring."
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (RoHS, REACH, AEC-Q, ISO) for regulatory coverage analysis."
    - name: "environmental_standard"
      expr: environmental_standard
      comment: "Environmental standard governing the certification for regulatory framework analysis."
    - name: "rohs_compliant"
      expr: rohs_compliant
      comment: "RoHS compliance flag for environmental regulatory segmentation."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for chemical substance regulatory segmentation."
    - name: "automotive_grade_certified"
      expr: automotive_grade_certified
      comment: "Automotive grade certification flag for automotive market compliance tracking."
    - name: "ear_controlled"
      expr: ear_controlled
      comment: "EAR export control flag for trade compliance segmentation."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "recertification_required"
      expr: recertification_required
      comment: "Flag indicating recertification is required — compliance renewal workload indicator."
    - name: "issue_year"
      expr: YEAR(issue_date)
      comment: "Year certification was issued for compliance vintage analysis."
    - name: "expiry_year"
      expr: YEAR(expiry_date)
      comment: "Year certification expires for renewal pipeline management."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total compliance certifications — baseline regulatory coverage KPI for compliance and legal reviews."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Active' THEN 1 END)
      comment: "Count of active certifications — current regulatory compliance coverage metric."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'Expired' THEN 1 END)
      comment: "Count of expired certifications — compliance gap metric requiring immediate remediation action."
    - name: "recertification_required_count"
      expr: COUNT(CASE WHEN recertification_required = TRUE THEN 1 END)
      comment: "Count of certifications requiring recertification — compliance renewal workload metric for planning."
    - name: "automotive_certified_count"
      expr: COUNT(CASE WHEN automotive_grade_certified = TRUE THEN 1 END)
      comment: "Count of automotive-grade certified products — automotive market compliance coverage metric."
    - name: "itar_controlled_cert_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled certifications — export compliance risk exposure metric."
    - name: "distinct_certified_products"
      expr: COUNT(DISTINCT primary_ic_catalog_id)
      comment: "Number of distinct products with compliance certifications — regulatory coverage breadth metric."
    - name: "distinct_certification_types"
      expr: COUNT(DISTINCT certification_type)
      comment: "Number of distinct certification types held — regulatory framework coverage diversity metric."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_ip_core`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product IP core portfolio KPIs covering performance, cost, power, and lifecycle — used by product management, engineering, and finance to manage IP core investments, licensing revenue, and technology roadmap."
  source: "`vibe_semiconductors_v1`.`product`.`product_ip_core`"
  dimensions:
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "IP core lifecycle status (Active, EOL, Deprecated) for portfolio health monitoring."
    - name: "ip_category"
      expr: ip_category
      comment: "IP category (Processor, Memory, Interface, Analog) for portfolio mix analysis."
    - name: "ip_type"
      expr: ip_type
      comment: "IP type (Hard, Soft, Firm) for technology and licensing strategy analysis."
    - name: "licensing_model"
      expr: licensing_model
      comment: "Licensing model (Royalty, Paid-Up, Subscription) for IP revenue model analysis."
    - name: "interface_protocol"
      expr: interface_protocol
      comment: "Interface protocol (PCIe, USB, DDR) for technology compatibility analysis."
    - name: "design_for_testability"
      expr: design_for_testability
      comment: "DFT flag indicating testability features are included — quality and test cost indicator."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status (Unverified, Simulated, Silicon-Proven) for IP quality and risk assessment."
    - name: "rtl_language"
      expr: rtl_language
      comment: "RTL design language (Verilog, VHDL, SystemVerilog) for EDA tool compatibility analysis."
  measures:
    - name: "total_ip_cores"
      expr: COUNT(1)
      comment: "Total IP cores in the product portfolio — baseline IP asset count for technology and investment reviews."
    - name: "active_ip_core_count"
      expr: COUNT(CASE WHEN lifecycle_status = 'Active' THEN 1 END)
      comment: "Count of active IP cores — current IP portfolio vitality metric for product and technology roadmap reviews."
    - name: "avg_nre_cost_usd"
      expr: AVG(CAST(nre_cost_usd AS DOUBLE))
      comment: "Average NRE cost (USD) per IP core — IP development investment benchmark for make-vs-buy decisions."
    - name: "total_nre_cost_usd"
      expr: SUM(CAST(nre_cost_usd AS DOUBLE))
      comment: "Total NRE investment (USD) across IP cores — cumulative IP development cost metric for finance and R&D reviews."
    - name: "avg_per_unit_royalty_usd"
      expr: AVG(CAST(per_unit_royalty_usd AS DOUBLE))
      comment: "Average per-unit royalty (USD) — IP monetization unit economics metric for licensing strategy."
    - name: "avg_operating_frequency_mhz"
      expr: AVG(CAST(operating_frequency_mhz AS DOUBLE))
      comment: "Average operating frequency (MHz) across IP cores — performance benchmark for technology roadmap positioning."
    - name: "avg_power_consumption_mw"
      expr: AVG(CAST(power_consumption_mw AS DOUBLE))
      comment: "Average power consumption (mW) — power efficiency benchmark for IP core selection and product design."
    - name: "avg_area_mm2"
      expr: AVG(CAST(area_mm2 AS DOUBLE))
      comment: "Average IP core area (mm²) — die area cost driver metric for product cost modeling."
    - name: "avg_gate_count"
      expr: AVG(CAST(gate_count AS DOUBLE))
      comment: "Average gate count — design complexity metric used in integration effort estimation and cost modeling."
    - name: "silicon_proven_count"
      expr: COUNT(CASE WHEN verification_status = 'Silicon-Proven' THEN 1 END)
      comment: "Count of silicon-proven IP cores — IP quality and risk reduction metric for product design decisions."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_process_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Process node portfolio KPIs covering yield, cost, lifecycle, and technology readiness — used by technology strategy, product management, and finance to manage process node investments and foundry relationships."
  source: "`vibe_semiconductors_v1`.`product`.`process_node`"
  dimensions:
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Process node lifecycle stage (Development, Qualification, Production, EOL) for technology portfolio management."
    - name: "lithography_type"
      expr: lithography_type
      comment: "Lithography type (DUV, EUV, Multi-Patterning) for advanced node investment analysis."
    - name: "transistor_architecture"
      expr: transistor_architecture
      comment: "Transistor architecture (Planar, FinFET, GAA) for technology generation analysis."
    - name: "qualification_status"
      expr: qualification_status
      comment: "Node qualification status for production readiness tracking."
    - name: "foundry_source"
      expr: foundry_source
      comment: "Foundry source for supply chain diversification and dependency analysis."
    - name: "technology_readiness_level"
      expr: technology_readiness_level
      comment: "Technology readiness level for R&D maturity and investment risk assessment."
    - name: "opc_required_flag"
      expr: opc_required_flag
      comment: "OPC requirement flag — advanced lithography complexity and cost indicator."
    - name: "node_generation"
      expr: node_generation
      comment: "Node generation label for technology roadmap analysis."
    - name: "pdk_release_year"
      expr: YEAR(pdk_release_date)
      comment: "Year PDK was released for technology availability timeline analysis."
    - name: "qualification_year"
      expr: YEAR(qualification_date)
      comment: "Year node was qualified for production readiness milestone tracking."
  measures:
    - name: "total_process_nodes"
      expr: COUNT(1)
      comment: "Total process nodes in the technology portfolio — baseline technology breadth KPI for strategy reviews."
    - name: "production_ready_node_count"
      expr: COUNT(CASE WHEN qualification_status = 'Qualified' THEN 1 END)
      comment: "Count of production-qualified process nodes — technology readiness metric for product roadmap planning."
    - name: "avg_baseline_yield_percent"
      expr: AVG(CAST(baseline_yield_percent AS DOUBLE))
      comment: "Average baseline wafer yield (%) across process nodes — manufacturing efficiency benchmark for cost modeling and fab negotiations."
    - name: "avg_cost_per_wafer_usd"
      expr: AVG(CAST(cost_per_wafer_usd AS DOUBLE))
      comment: "Average cost per wafer (USD) — primary manufacturing cost metric used in product pricing and margin analysis."
    - name: "avg_minimum_feature_size_nm"
      expr: AVG(CAST(minimum_feature_size_nm AS DOUBLE))
      comment: "Average minimum feature size (nm) — technology advancement metric for competitive positioning and roadmap analysis."
    - name: "avg_cycle_time_days"
      expr: AVG(CAST(cycle_time_days AS DOUBLE))
      comment: "Average fab cycle time (days) — manufacturing throughput metric used in delivery planning and capacity analysis."
    - name: "distinct_foundry_sources"
      expr: COUNT(DISTINCT foundry_source)
      comment: "Number of distinct foundry sources — supply chain diversification metric for risk management reviews."
    - name: "eol_node_count"
      expr: COUNT(CASE WHEN eol_announcement_date IS NOT NULL THEN 1 END)
      comment: "Count of process nodes with EOL announcements — technology wind-down risk metric for product migration planning."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_errata`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product errata KPIs tracking defect severity, resolution status, customer disclosure, and workaround availability — used by product engineering, quality, and customer success to manage product defect risk and customer impact."
  source: "`vibe_semiconductors_v1`.`product`.`errata`"
  dimensions:
    - name: "errata_status"
      expr: errata_status
      comment: "Errata resolution status (Open, In Progress, Resolved, Closed) for defect management tracking."
    - name: "severity"
      expr: severity
      comment: "Errata severity level (Critical, Major, Minor) for risk prioritization."
    - name: "functional_block"
      expr: functional_block
      comment: "Affected functional block (CPU, Memory, IO) for design area impact analysis."
    - name: "customer_disclosure_status"
      expr: customer_disclosure_status
      comment: "Customer disclosure status (Not Disclosed, Disclosed, Pending) for customer communication governance."
    - name: "workaround_available"
      expr: workaround_available
      comment: "Flag indicating a workaround is available — customer impact mitigation indicator."
    - name: "verification_status"
      expr: verification_status
      comment: "Fix verification status for quality assurance tracking."
    - name: "discovered_year"
      expr: YEAR(discovered_date)
      comment: "Year errata was discovered for defect trend analysis."
    - name: "resolution_year"
      expr: YEAR(resolution_date)
      comment: "Year errata was resolved for cycle time analysis."
  measures:
    - name: "total_errata"
      expr: COUNT(1)
      comment: "Total errata records — baseline product defect count KPI for quality and engineering reviews."
    - name: "open_errata_count"
      expr: COUNT(CASE WHEN errata_status = 'Open' THEN 1 END)
      comment: "Count of open errata — active product defect backlog metric for engineering prioritization."
    - name: "critical_errata_count"
      expr: COUNT(CASE WHEN severity = 'Critical' THEN 1 END)
      comment: "Count of critical severity errata — high-risk defect exposure metric for executive quality reviews."
    - name: "workaround_available_count"
      expr: COUNT(CASE WHEN workaround_available = TRUE THEN 1 END)
      comment: "Count of errata with available workarounds — customer impact mitigation coverage metric."
    - name: "undisclosed_errata_count"
      expr: COUNT(CASE WHEN customer_disclosure_status = 'Not Disclosed' THEN 1 END)
      comment: "Count of errata not yet disclosed to customers — customer communication risk metric for legal and customer success."
    - name: "distinct_affected_products"
      expr: COUNT(DISTINCT primary_errata_ic_catalog_id)
      comment: "Number of distinct products with errata — product quality breadth metric for portfolio risk assessment."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_sample_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product sample request KPIs tracking conversion, evaluation outcomes, and compliance — used by sales, product management, and compliance to measure sample program effectiveness and design win pipeline."
  source: "`vibe_semiconductors_v1`.`product`.`product_sample_request`"
  dimensions:
    - name: "product_sample_request_status"
      expr: product_sample_request_status
      comment: "Sample request status (Pending, Approved, Shipped, Evaluated) for pipeline tracking."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status for sample request governance tracking."
    - name: "sample_type"
      expr: sample_type
      comment: "Sample type (Engineering, Qualification, Production) for program mix analysis."
    - name: "request_source"
      expr: request_source
      comment: "Request source (Direct, Distributor, Online) for channel analysis."
    - name: "design_win_conversion_flag"
      expr: design_win_conversion_flag
      comment: "Flag indicating the sample led to a design win — primary conversion KPI for sample program ROI."
    - name: "expedited_flag"
      expr: expedited_flag
      comment: "Expedited flag for priority fulfillment analysis."
    - name: "compliance_itar_flag"
      expr: compliance_itar_flag
      comment: "ITAR compliance flag for export control segmentation."
    - name: "target_application"
      expr: target_application
      comment: "Target application for the sample — used in market segment and design win analysis."
    - name: "request_year"
      expr: YEAR(request_timestamp)
      comment: "Year of sample request for trend and pipeline analysis."
  measures:
    - name: "total_sample_requests"
      expr: COUNT(1)
      comment: "Total sample requests — baseline demand generation pipeline metric for sales and product management."
    - name: "design_win_conversion_count"
      expr: COUNT(CASE WHEN design_win_conversion_flag = TRUE THEN 1 END)
      comment: "Count of sample requests that converted to design wins — primary sample program ROI metric for sales and executive reviews."
    - name: "total_sample_cost_usd"
      expr: SUM(CAST(sample_cost_amount AS DOUBLE))
      comment: "Total sample program cost (USD) — investment metric for sample program budget management."
    - name: "avg_sample_cost_usd"
      expr: AVG(CAST(sample_cost_amount AS DOUBLE))
      comment: "Average sample cost (USD) per request — unit economics metric for sample program cost efficiency."
    - name: "avg_evaluation_score"
      expr: AVG(CAST(evaluation_score AS DOUBLE))
      comment: "Average customer evaluation score — product acceptance quality metric used in NPI and product improvement reviews."
    - name: "itar_controlled_request_count"
      expr: COUNT(CASE WHEN compliance_itar_flag = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled sample requests — export compliance risk metric for legal and trade compliance teams."
    - name: "distinct_products_sampled"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct products with sample requests — demand generation breadth metric for product portfolio analysis."
$$;

CREATE OR REPLACE VIEW `vibe_semiconductors_v1`.`_metrics`.`product_configuration_rule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Product configuration rule KPIs tracking rule coverage, compliance, and governance — used by product management and engineering to manage product variant configurability and regulatory compliance."
  source: "`vibe_semiconductors_v1`.`product`.`configuration_rule`"
  dimensions:
    - name: "configuration_rule_status"
      expr: configuration_rule_status
      comment: "Rule status (Active, Inactive, Superseded) for governance tracking."
    - name: "rule_type"
      expr: rule_type
      comment: "Rule type (Inclusion, Exclusion, Dependency) for configuration logic analysis."
    - name: "applicable_market"
      expr: applicable_market
      comment: "Target market for the rule (Automotive, Industrial, Consumer) for market-specific configuration analysis."
    - name: "automotive_qualified"
      expr: automotive_qualified
      comment: "Automotive qualification flag for automotive-grade configuration tracking."
    - name: "is_default_rule"
      expr: is_default_rule
      comment: "Flag indicating this is a default configuration rule — used to distinguish baseline from override rules."
    - name: "itar_controlled"
      expr: itar_controlled
      comment: "ITAR export control flag for trade compliance segmentation."
    - name: "reach_compliant"
      expr: reach_compliant
      comment: "REACH compliance flag for environmental regulatory segmentation."
    - name: "effective_start_year"
      expr: YEAR(effective_start_date)
      comment: "Year rule became effective for governance timeline analysis."
  measures:
    - name: "total_configuration_rules"
      expr: COUNT(1)
      comment: "Total configuration rules — baseline product configurability complexity metric for product management reviews."
    - name: "active_rule_count"
      expr: COUNT(CASE WHEN configuration_rule_status = 'Active' THEN 1 END)
      comment: "Count of active configuration rules — current product variant governance metric."
    - name: "itar_controlled_rule_count"
      expr: COUNT(CASE WHEN itar_controlled = TRUE THEN 1 END)
      comment: "Count of ITAR-controlled configuration rules — export compliance risk metric for legal and trade compliance teams."
    - name: "automotive_qualified_rule_count"
      expr: COUNT(CASE WHEN automotive_qualified = TRUE THEN 1 END)
      comment: "Count of automotive-qualified configuration rules — automotive market coverage metric."
    - name: "distinct_products_with_rules"
      expr: COUNT(DISTINCT ic_catalog_id)
      comment: "Number of distinct products with configuration rules — product configurability coverage metric."
    - name: "distinct_rule_types"
      expr: COUNT(DISTINCT rule_type)
      comment: "Number of distinct rule types — configuration logic complexity metric for product engineering reviews."
$$;