-- Metric views for domain: reference | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_property_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic property type classification metrics for portfolio composition, investment strategy alignment, and asset class performance analysis"
  source: "`real_estate_ecm`.`reference`.`property_type`"
  dimensions:
    - name: "property_type_name"
      expr: type_name
      comment: "Full property type name for classification and reporting"
    - name: "property_type_code"
      expr: type_code
      comment: "Standardized property type code for system integration"
    - name: "asset_class"
      expr: asset_class
      comment: "High-level asset class grouping (e.g., Core, Value-Add, Opportunistic)"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Property type taxonomy depth for drill-down analysis"
    - name: "is_commercial"
      expr: is_commercial
      comment: "Commercial property flag for sector segmentation"
    - name: "is_residential"
      expr: is_residential
      comment: "Residential property flag for sector segmentation"
    - name: "is_investment_grade"
      expr: is_investment_grade
      comment: "Investment grade classification for portfolio quality assessment"
    - name: "is_reit_eligible"
      expr: is_reit_eligible
      comment: "REIT eligibility flag for regulatory compliance and tax strategy"
    - name: "is_esg_relevant"
      expr: is_esg_relevant
      comment: "ESG materiality flag for sustainability reporting and impact investing"
    - name: "property_type_status"
      expr: property_type_status
      comment: "Active/inactive status for data quality and governance"
    - name: "costar_property_type_code"
      expr: costar_property_type_code
      comment: "CoStar integration code for market benchmarking"
  measures:
    - name: "property_type_count"
      expr: COUNT(1)
      comment: "Total number of property type classifications in the reference taxonomy"
    - name: "avg_cap_rate_benchmark_pct"
      expr: AVG(CAST(cap_rate_benchmark_pct AS DOUBLE))
      comment: "Average capitalization rate benchmark across property types for investment yield expectations"
    - name: "avg_ti_allowance_benchmark_psf"
      expr: AVG(CAST(ti_allowance_benchmark_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot for budgeting and deal structuring"
    - name: "investment_grade_property_type_count"
      expr: COUNT(CASE WHEN is_investment_grade = TRUE THEN 1 END)
      comment: "Count of investment-grade property types for portfolio quality assessment"
    - name: "reit_eligible_property_type_count"
      expr: COUNT(CASE WHEN is_reit_eligible = TRUE THEN 1 END)
      comment: "Count of REIT-eligible property types for regulatory compliance and tax planning"
    - name: "esg_relevant_property_type_count"
      expr: COUNT(CASE WHEN is_esg_relevant = TRUE THEN 1 END)
      comment: "Count of ESG-relevant property types for sustainability strategy and impact reporting"
    - name: "commercial_property_type_count"
      expr: COUNT(CASE WHEN is_commercial = TRUE THEN 1 END)
      comment: "Count of commercial property types for sector exposure analysis"
    - name: "residential_property_type_count"
      expr: COUNT(CASE WHEN is_residential = TRUE THEN 1 END)
      comment: "Count of residential property types for sector exposure analysis"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_building_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Building quality and investment grade classification metrics for asset valuation, underwriting standards, and portfolio positioning"
  source: "`real_estate_ecm`.`reference`.`building_class`"
  dimensions:
    - name: "building_class_name"
      expr: class_name
      comment: "Building class name (e.g., Class A, Class B, Class C) for quality segmentation"
    - name: "building_class_code"
      expr: class_code
      comment: "Standardized building class code for system integration"
    - name: "boma_class_designation"
      expr: boma_class_designation
      comment: "BOMA (Building Owners and Managers Association) standard classification"
    - name: "asset_segment"
      expr: asset_segment
      comment: "Asset segment grouping for portfolio strategy alignment"
    - name: "investment_grade_flag"
      expr: investment_grade_flag
      comment: "Investment grade indicator for underwriting and acquisition decisions"
    - name: "reit_eligible_flag"
      expr: reit_eligible_flag
      comment: "REIT eligibility for regulatory compliance and tax optimization"
    - name: "construction_quality_grade"
      expr: construction_quality_grade
      comment: "Construction quality tier for asset valuation and maintenance planning"
    - name: "location_grade"
      expr: location_grade
      comment: "Location quality grade for market positioning and rent premium analysis"
    - name: "building_class_status"
      expr: building_class_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "building_class_count"
      expr: COUNT(1)
      comment: "Total number of building class definitions in the reference taxonomy"
    - name: "avg_min_cap_rate_pct"
      expr: AVG(CAST(min_cap_rate_pct AS DOUBLE))
      comment: "Average minimum capitalization rate across building classes for investment yield floor expectations"
    - name: "avg_max_cap_rate_pct"
      expr: AVG(CAST(max_cap_rate_pct AS DOUBLE))
      comment: "Average maximum capitalization rate across building classes for investment yield ceiling expectations"
    - name: "avg_typical_psf_rent_min"
      expr: AVG(CAST(typical_psf_rent_min AS DOUBLE))
      comment: "Average minimum rent per square foot for market rent benchmarking and underwriting"
    - name: "avg_typical_psf_rent_max"
      expr: AVG(CAST(typical_psf_rent_max AS DOUBLE))
      comment: "Average maximum rent per square foot for market rent benchmarking and underwriting"
    - name: "avg_typical_vacancy_rate_pct"
      expr: AVG(CAST(typical_vacancy_rate_pct AS DOUBLE))
      comment: "Average typical vacancy rate for occupancy forecasting and risk assessment"
    - name: "avg_parking_ratio_min"
      expr: AVG(CAST(parking_ratio_min AS DOUBLE))
      comment: "Average minimum parking ratio for site planning and tenant requirements"
    - name: "avg_min_gla_sqf"
      expr: AVG(CAST(min_gla_sqf AS DOUBLE))
      comment: "Average minimum gross leasable area for building class qualification thresholds"
    - name: "investment_grade_class_count"
      expr: COUNT(CASE WHEN investment_grade_flag = TRUE THEN 1 END)
      comment: "Count of investment-grade building classes for portfolio quality standards"
    - name: "reit_eligible_class_count"
      expr: COUNT(CASE WHEN reit_eligible_flag = TRUE THEN 1 END)
      comment: "Count of REIT-eligible building classes for regulatory compliance planning"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_market_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment strategy and market segment performance metrics for portfolio allocation, risk-return profiling, and capital deployment decisions"
  source: "`real_estate_ecm`.`reference`.`market_segment`"
  dimensions:
    - name: "market_segment_name"
      expr: segment_name
      comment: "Market segment name for investment strategy classification"
    - name: "market_segment_code"
      expr: segment_code
      comment: "Standardized market segment code for system integration"
    - name: "segment_category"
      expr: segment_category
      comment: "High-level segment category grouping for portfolio strategy"
    - name: "risk_profile"
      expr: risk_profile
      comment: "Risk classification (e.g., Core, Core-Plus, Value-Add, Opportunistic) for risk-return alignment"
    - name: "investment_strategy_type"
      expr: investment_strategy_type
      comment: "Investment strategy type for capital allocation and fund structuring"
    - name: "property_type_focus"
      expr: property_type_focus
      comment: "Target property types for segment-specific investment mandates"
    - name: "geographic_focus"
      expr: geographic_focus
      comment: "Geographic focus for regional allocation and diversification strategy"
    - name: "investor_type_target"
      expr: investor_type_target
      comment: "Target investor profile for fund marketing and capital raising"
    - name: "is_active"
      expr: is_active
      comment: "Active segment flag for current investment strategy relevance"
  measures:
    - name: "market_segment_count"
      expr: COUNT(1)
      comment: "Total number of market segments in the investment strategy taxonomy"
    - name: "avg_target_irr_min_pct"
      expr: AVG(CAST(target_irr_min_pct AS DOUBLE))
      comment: "Average minimum target internal rate of return for investment hurdle rate setting"
    - name: "avg_target_irr_max_pct"
      expr: AVG(CAST(target_irr_max_pct AS DOUBLE))
      comment: "Average maximum target internal rate of return for investment return expectations"
    - name: "avg_target_cap_rate_min_pct"
      expr: AVG(CAST(target_cap_rate_min_pct AS DOUBLE))
      comment: "Average minimum target capitalization rate for acquisition underwriting"
    - name: "avg_target_cap_rate_max_pct"
      expr: AVG(CAST(target_cap_rate_max_pct AS DOUBLE))
      comment: "Average maximum target capitalization rate for acquisition underwriting"
    - name: "avg_target_ltv_max_pct"
      expr: AVG(CAST(target_ltv_max_pct AS DOUBLE))
      comment: "Average maximum loan-to-value ratio for leverage strategy and debt capacity planning"
    - name: "avg_target_dscr_min"
      expr: AVG(CAST(target_dscr_min AS DOUBLE))
      comment: "Average minimum debt service coverage ratio for lender requirements and risk management"
    - name: "avg_equity_multiple_min"
      expr: AVG(CAST(equity_multiple_min AS DOUBLE))
      comment: "Average minimum equity multiple for investor return expectations"
    - name: "avg_equity_multiple_max"
      expr: AVG(CAST(equity_multiple_max AS DOUBLE))
      comment: "Average maximum equity multiple for investor return expectations"
    - name: "avg_hold_period_min_years"
      expr: AVG(CAST(hold_period_min_years AS DOUBLE))
      comment: "Average minimum hold period for investment horizon planning and exit strategy"
    - name: "avg_hold_period_max_years"
      expr: AVG(CAST(hold_period_max_years AS DOUBLE))
      comment: "Average maximum hold period for investment horizon planning and exit strategy"
    - name: "avg_typical_asset_size_min_usd"
      expr: AVG(CAST(typical_asset_size_min_usd AS DOUBLE))
      comment: "Average minimum asset size for deal sourcing and portfolio construction"
    - name: "avg_typical_asset_size_max_usd"
      expr: AVG(CAST(typical_asset_size_max_usd AS DOUBLE))
      comment: "Average maximum asset size for deal sourcing and portfolio construction"
    - name: "avg_occupancy_threshold_min_pct"
      expr: AVG(CAST(occupancy_threshold_min_pct AS DOUBLE))
      comment: "Average minimum occupancy threshold for acquisition criteria and stabilization targets"
    - name: "active_segment_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Count of active market segments for current investment strategy portfolio"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_lease_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease structure classification metrics for revenue recognition, tenant cost allocation, and lease portfolio risk management"
  source: "`real_estate_ecm`.`reference`.`lease_type`"
  dimensions:
    - name: "lease_type_name"
      expr: lease_type_name
      comment: "Lease type name (e.g., Gross, Net, Triple Net) for lease structure classification"
    - name: "lease_type_code"
      expr: lease_type_code
      comment: "Standardized lease type code for system integration"
    - name: "lease_category"
      expr: lease_category
      comment: "High-level lease category grouping for portfolio analysis"
    - name: "rent_structure"
      expr: rent_structure
      comment: "Rent structure type for cash flow modeling and revenue forecasting"
    - name: "asc842_lease_classification"
      expr: asc842_lease_classification
      comment: "ASC 842 lease classification (Operating/Finance) for US GAAP accounting compliance"
    - name: "ifrs16_lease_classification"
      expr: ifrs16_lease_classification
      comment: "IFRS 16 lease classification for international accounting compliance"
    - name: "cam_responsibility"
      expr: cam_responsibility
      comment: "Common area maintenance cost responsibility allocation (Landlord/Tenant/Shared)"
    - name: "opex_responsibility"
      expr: opex_responsibility
      comment: "Operating expense responsibility allocation for cost recovery analysis"
    - name: "tax_responsibility"
      expr: tax_responsibility
      comment: "Property tax responsibility allocation for tenant billing and budgeting"
    - name: "lease_type_status"
      expr: lease_type_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "lease_type_count"
      expr: COUNT(1)
      comment: "Total number of lease type classifications in the reference taxonomy"
    - name: "cam_reconciliation_required_count"
      expr: COUNT(CASE WHEN cam_reconciliation_required = TRUE THEN 1 END)
      comment: "Count of lease types requiring CAM reconciliation for accounting workload planning"
    - name: "percentage_rent_applicable_count"
      expr: COUNT(CASE WHEN percentage_rent_applicable = TRUE THEN 1 END)
      comment: "Count of lease types with percentage rent for revenue upside potential analysis"
    - name: "ti_allowance_applicable_count"
      expr: COUNT(CASE WHEN ti_allowance_applicable = TRUE THEN 1 END)
      comment: "Count of lease types with tenant improvement allowances for capital budgeting"
    - name: "sublease_permitted_count"
      expr: COUNT(CASE WHEN sublease_permitted = TRUE THEN 1 END)
      comment: "Count of lease types permitting subleases for tenant flexibility and risk assessment"
    - name: "ground_lease_count"
      expr: COUNT(CASE WHEN is_ground_lease = TRUE THEN 1 END)
      comment: "Count of ground lease types for land investment and long-term lease strategy"
    - name: "short_term_lease_count"
      expr: COUNT(CASE WHEN is_short_term = TRUE THEN 1 END)
      comment: "Count of short-term lease types for lease rollover risk and renewal opportunity analysis"
    - name: "esg_reporting_applicable_count"
      expr: COUNT(CASE WHEN esg_reporting_applicable = TRUE THEN 1 END)
      comment: "Count of lease types requiring ESG reporting for sustainability disclosure compliance"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_transaction_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real estate transaction classification metrics for deal pipeline management, regulatory compliance, and transaction cost analysis"
  source: "`real_estate_ecm`.`reference`.`transaction_type`"
  dimensions:
    - name: "transaction_type_name"
      expr: type_name
      comment: "Transaction type name (e.g., Acquisition, Disposition, Lease, Refinance) for deal classification"
    - name: "transaction_type_code"
      expr: type_code
      comment: "Standardized transaction type code for system integration"
    - name: "transaction_type_category"
      expr: transaction_type_category
      comment: "High-level transaction category grouping for pipeline reporting"
    - name: "sub_category"
      expr: sub_category
      comment: "Transaction sub-category for detailed deal type analysis"
    - name: "capex_or_opex"
      expr: capex_or_opex
      comment: "Capital vs operating expenditure classification for financial statement impact"
    - name: "is_taxable_event"
      expr: is_taxable_event
      comment: "Taxable event flag for tax planning and compliance"
    - name: "is_1031_eligible"
      expr: is_1031_eligible
      comment: "1031 exchange eligibility for tax-deferred transaction structuring"
    - name: "is_sec_reportable"
      expr: is_sec_reportable
      comment: "SEC reporting requirement flag for public company disclosure compliance"
    - name: "reit_qualifying_income"
      expr: reit_qualifying_income
      comment: "REIT qualifying income flag for REIT compliance and tax optimization"
    - name: "transaction_type_status"
      expr: transaction_type_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "transaction_type_count"
      expr: COUNT(1)
      comment: "Total number of transaction type classifications in the reference taxonomy"
    - name: "appraisal_required_count"
      expr: COUNT(CASE WHEN appraisal_required = TRUE THEN 1 END)
      comment: "Count of transaction types requiring appraisals for valuation workload planning"
    - name: "environmental_review_required_count"
      expr: COUNT(CASE WHEN environmental_review_required = TRUE THEN 1 END)
      comment: "Count of transaction types requiring environmental review for due diligence planning"
    - name: "title_insurance_required_count"
      expr: COUNT(CASE WHEN title_insurance_required = TRUE THEN 1 END)
      comment: "Count of transaction types requiring title insurance for closing cost estimation"
    - name: "transfer_tax_applicable_count"
      expr: COUNT(CASE WHEN transfer_tax_applicable = TRUE THEN 1 END)
      comment: "Count of transaction types subject to transfer tax for transaction cost modeling"
    - name: "broker_commission_applicable_count"
      expr: COUNT(CASE WHEN broker_commission_applicable = TRUE THEN 1 END)
      comment: "Count of transaction types with broker commissions for transaction cost budgeting"
    - name: "sec_reportable_count"
      expr: COUNT(CASE WHEN is_sec_reportable = TRUE THEN 1 END)
      comment: "Count of SEC-reportable transaction types for public company disclosure planning"
    - name: "reit_qualifying_income_count"
      expr: COUNT(CASE WHEN reit_qualifying_income = TRUE THEN 1 END)
      comment: "Count of REIT-qualifying transaction types for REIT compliance and tax strategy"
    - name: "taxable_event_count"
      expr: COUNT(CASE WHEN is_taxable_event = TRUE THEN 1 END)
      comment: "Count of taxable transaction types for tax planning and cash flow impact analysis"
    - name: "exchange_1031_eligible_count"
      expr: COUNT(CASE WHEN is_1031_eligible = TRUE THEN 1 END)
      comment: "Count of 1031-eligible transaction types for tax-deferred exchange strategy"
    - name: "esg_disclosure_required_count"
      expr: COUNT(CASE WHEN esg_disclosure_required = TRUE THEN 1 END)
      comment: "Count of transaction types requiring ESG disclosure for sustainability reporting compliance"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_geographic_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic market intelligence metrics for market selection, demographic analysis, and regional portfolio diversification strategy"
  source: "`real_estate_ecm`.`reference`.`geographic_hierarchy`"
  dimensions:
    - name: "node_name"
      expr: node_name
      comment: "Geographic node name for location-based analysis and reporting"
    - name: "node_code"
      expr: node_code
      comment: "Standardized geographic node code for system integration"
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Geographic hierarchy level (Country/State/MSA/City/Submarket) for drill-down analysis"
    - name: "market_tier"
      expr: market_tier
      comment: "Market tier classification (Primary/Secondary/Tertiary) for investment strategy alignment"
    - name: "msa_name"
      expr: msa_name
      comment: "Metropolitan Statistical Area name for metro market analysis"
    - name: "state_province_name"
      expr: state_province_name
      comment: "State or province name for regional segmentation"
    - name: "city_name"
      expr: city_name
      comment: "City name for local market analysis"
    - name: "opportunity_zone_flag"
      expr: opportunity_zone_flag
      comment: "Opportunity Zone designation for tax incentive investment strategy"
    - name: "enterprise_zone_flag"
      expr: enterprise_zone_flag
      comment: "Enterprise Zone designation for economic development incentive analysis"
    - name: "esg_climate_risk_zone"
      expr: esg_climate_risk_zone
      comment: "Climate risk zone classification for ESG risk assessment and resilience planning"
    - name: "flood_zone_designation"
      expr: flood_zone_designation
      comment: "FEMA flood zone designation for insurance cost and risk mitigation planning"
    - name: "node_status"
      expr: node_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "geographic_node_count"
      expr: COUNT(1)
      comment: "Total number of geographic nodes in the location hierarchy for market coverage assessment"
    - name: "total_population"
      expr: SUM(CAST(population AS DOUBLE))
      comment: "Total population across geographic nodes for market size and demand analysis"
    - name: "avg_population"
      expr: AVG(CAST(population AS DOUBLE))
      comment: "Average population per geographic node for market density assessment"
    - name: "total_area_sqm"
      expr: SUM(CAST(area_sqm AS DOUBLE))
      comment: "Total geographic area in square meters for land availability and density analysis"
    - name: "avg_median_household_income"
      expr: AVG(CAST(median_household_income AS DOUBLE))
      comment: "Average median household income for purchasing power and tenant quality assessment"
    - name: "avg_unemployment_rate"
      expr: AVG(CAST(unemployment_rate AS DOUBLE))
      comment: "Average unemployment rate for economic health and tenant credit risk assessment"
    - name: "opportunity_zone_count"
      expr: COUNT(CASE WHEN opportunity_zone_flag = TRUE THEN 1 END)
      comment: "Count of Opportunity Zones for tax-advantaged investment strategy and capital deployment"
    - name: "enterprise_zone_count"
      expr: COUNT(CASE WHEN enterprise_zone_flag = TRUE THEN 1 END)
      comment: "Count of Enterprise Zones for economic development incentive capture"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_zoning_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zoning and land use regulation metrics for development feasibility, entitlement risk assessment, and highest-and-best-use analysis"
  source: "`real_estate_ecm`.`reference`.`zoning_code`"
  dimensions:
    - name: "zoning_code_name"
      expr: zoning_code_name
      comment: "Zoning code name for land use classification and regulatory compliance"
    - name: "zoning_code_code"
      expr: zoning_code_code
      comment: "Standardized zoning code for system integration and GIS mapping"
    - name: "zoning_code_category"
      expr: zoning_code_category
      comment: "High-level zoning category (Residential/Commercial/Industrial/Mixed-Use) for use classification"
    - name: "jurisdiction_name"
      expr: jurisdiction_name
      comment: "Zoning jurisdiction name for regulatory authority identification"
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Jurisdiction type (City/County/Regional) for regulatory hierarchy"
    - name: "density_class"
      expr: density_class
      comment: "Density classification for development intensity and unit count planning"
    - name: "overlay_district_flag"
      expr: overlay_district_flag
      comment: "Overlay district flag for additional regulatory requirements and restrictions"
    - name: "environmental_overlay_flag"
      expr: environmental_overlay_flag
      comment: "Environmental overlay flag for environmental protection and mitigation requirements"
    - name: "affordable_housing_requirement_flag"
      expr: affordable_housing_requirement_flag
      comment: "Affordable housing requirement flag for inclusionary zoning compliance and cost impact"
    - name: "variance_allowed_flag"
      expr: variance_allowed_flag
      comment: "Variance allowance flag for entitlement flexibility and approval risk assessment"
    - name: "rezoning_pending_flag"
      expr: rezoning_pending_flag
      comment: "Rezoning pending flag for regulatory uncertainty and timing risk"
    - name: "zoning_code_status"
      expr: zoning_code_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "zoning_code_count"
      expr: COUNT(1)
      comment: "Total number of zoning codes in the reference taxonomy for regulatory complexity assessment"
    - name: "avg_far_max"
      expr: AVG(CAST(far_max AS DOUBLE))
      comment: "Average maximum floor area ratio for development density and building size potential"
    - name: "avg_far_min"
      expr: AVG(CAST(far_min AS DOUBLE))
      comment: "Average minimum floor area ratio for minimum development intensity requirements"
    - name: "avg_height_limit_ft"
      expr: AVG(CAST(height_limit_ft AS DOUBLE))
      comment: "Average height limit in feet for building design and unit count constraints"
    - name: "avg_lot_coverage_pct"
      expr: AVG(CAST(lot_coverage_pct AS DOUBLE))
      comment: "Average lot coverage percentage for site planning and open space requirements"
    - name: "avg_min_lot_size_sqf"
      expr: AVG(CAST(min_lot_size_sqf AS DOUBLE))
      comment: "Average minimum lot size in square feet for land assembly and subdivision feasibility"
    - name: "avg_parking_ratio_min"
      expr: AVG(CAST(parking_ratio_min AS DOUBLE))
      comment: "Average minimum parking ratio for parking structure sizing and cost estimation"
    - name: "avg_front_setback_ft"
      expr: AVG(CAST(front_setback_ft AS DOUBLE))
      comment: "Average front setback in feet for site layout and buildable area calculation"
    - name: "avg_min_lot_width_ft"
      expr: AVG(CAST(min_lot_width_ft AS DOUBLE))
      comment: "Average minimum lot width in feet for lot configuration and subdivision design"
    - name: "overlay_district_count"
      expr: COUNT(CASE WHEN overlay_district_flag = TRUE THEN 1 END)
      comment: "Count of overlay districts for additional regulatory complexity and compliance cost"
    - name: "affordable_housing_requirement_count"
      expr: COUNT(CASE WHEN affordable_housing_requirement_flag = TRUE THEN 1 END)
      comment: "Count of zones with affordable housing requirements for inclusionary zoning impact analysis"
    - name: "variance_allowed_count"
      expr: COUNT(CASE WHEN variance_allowed_flag = TRUE THEN 1 END)
      comment: "Count of zones allowing variances for entitlement flexibility and approval strategy"
    - name: "rezoning_pending_count"
      expr: COUNT(CASE WHEN rezoning_pending_flag = TRUE THEN 1 END)
      comment: "Count of zones with pending rezoning for regulatory uncertainty and timing risk assessment"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_construction_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction methodology and building system metrics for development cost estimation, insurance underwriting, and asset durability assessment"
  source: "`real_estate_ecm`.`reference`.`construction_type`"
  dimensions:
    - name: "construction_type_name"
      expr: construction_type_name
      comment: "Construction type name for building system classification"
    - name: "construction_type_code"
      expr: construction_type_code
      comment: "Standardized construction type code for system integration"
    - name: "construction_category"
      expr: construction_category
      comment: "High-level construction category grouping for cost benchmarking"
    - name: "primary_material"
      expr: primary_material
      comment: "Primary structural material for material cost and durability analysis"
    - name: "structural_system"
      expr: structural_system
      comment: "Structural system type for engineering design and load capacity"
    - name: "ibc_construction_type"
      expr: ibc_construction_type
      comment: "International Building Code construction type for code compliance and fire safety"
    - name: "is_combustible"
      expr: is_combustible
      comment: "Combustible material flag for fire risk and insurance rating"
    - name: "leed_compatibility"
      expr: leed_compatibility
      comment: "LEED certification compatibility for green building strategy"
    - name: "breeam_compatibility"
      expr: breeam_compatibility
      comment: "BREEAM certification compatibility for international sustainability standards"
    - name: "construction_type_status"
      expr: construction_type_status
      comment: "Active/inactive status for reference data governance"
  measures:
    - name: "construction_type_count"
      expr: COUNT(1)
      comment: "Total number of construction type classifications in the reference taxonomy"
    - name: "avg_typical_cost_psf_low"
      expr: AVG(CAST(typical_cost_psf_low AS DOUBLE))
      comment: "Average low-end construction cost per square foot for development budget floor estimation"
    - name: "avg_typical_cost_psf_high"
      expr: AVG(CAST(typical_cost_psf_high AS DOUBLE))
      comment: "Average high-end construction cost per square foot for development budget ceiling estimation"
    - name: "avg_fire_resistance_rating_hours"
      expr: AVG(CAST(fire_resistance_rating_hours AS DOUBLE))
      comment: "Average fire resistance rating in hours for fire safety and insurance underwriting"
    - name: "avg_floor_load_capacity_psf"
      expr: AVG(CAST(floor_load_capacity_psf AS DOUBLE))
      comment: "Average floor load capacity per square foot for structural design and tenant use suitability"
    - name: "avg_max_building_height_ft"
      expr: AVG(CAST(max_building_height_ft AS DOUBLE))
      comment: "Average maximum building height in feet for construction type limitations and zoning compliance"
    - name: "avg_typical_span_ft"
      expr: AVG(CAST(typical_span_ft AS DOUBLE))
      comment: "Average typical structural span in feet for column-free space and tenant flexibility"
    - name: "avg_replacement_cost_multiplier"
      expr: AVG(CAST(replacement_cost_multiplier AS DOUBLE))
      comment: "Average replacement cost multiplier for insurance valuation and risk assessment"
    - name: "combustible_construction_count"
      expr: COUNT(CASE WHEN is_combustible = TRUE THEN 1 END)
      comment: "Count of combustible construction types for fire risk and insurance premium impact"
    - name: "bim_support_count"
      expr: COUNT(CASE WHEN bim_support = TRUE THEN 1 END)
      comment: "Count of BIM-compatible construction types for digital design and construction technology adoption"
$$;