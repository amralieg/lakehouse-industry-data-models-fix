-- Metric views for domain: reference | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:46:06

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_amenity_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Amenity Type business metrics"
  source: "`real_estate_ecm`.`reference`.`amenity_type`"
  dimensions:
    - name: "Amenity Category"
      expr: amenity_category
    - name: "Amenity Class"
      expr: amenity_class
    - name: "Amenity Code"
      expr: amenity_code
    - name: "Amenity Name"
      expr: amenity_name
    - name: "Amenity Type Description"
      expr: amenity_type_description
    - name: "Amenity Type Status"
      expr: amenity_type_status
    - name: "Applicable Property Types"
      expr: applicable_property_types
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Costar Amenity Code"
      expr: costar_amenity_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Sort Order"
      expr: display_sort_order
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Icon Identifier"
      expr: icon_identifier
    - name: "Indoor Outdoor Indicator"
      expr: indoor_outdoor_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Amenity Type"
      expr: COUNT(DISTINCT amenity_type_id)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_building_class`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Building Class business metrics"
  source: "`real_estate_ecm`.`reference`.`building_class`"
  dimensions:
    - name: "Amenity Requirement Level"
      expr: amenity_requirement_level
    - name: "Asset Segment"
      expr: asset_segment
    - name: "Boma Class Designation"
      expr: boma_class_designation
    - name: "Building Class Status"
      expr: building_class_status
    - name: "Class Code"
      expr: class_code
    - name: "Class Description"
      expr: class_description
    - name: "Class Name"
      expr: class_name
    - name: "Classification Tier"
      expr: classification_tier
    - name: "Construction Quality Grade"
      expr: construction_quality_grade
    - name: "Costar Class Code"
      expr: costar_class_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Energy Star Min Score"
      expr: energy_star_min_score
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Finish Quality Grade"
      expr: finish_quality_grade
    - name: "Hvac System Requirement"
      expr: hvac_system_requirement
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Building Class"
      expr: COUNT(DISTINCT building_class_id)
    - name: "Total Max Cap Rate Pct"
      expr: SUM(max_cap_rate_pct)
    - name: "Average Max Cap Rate Pct"
      expr: AVG(max_cap_rate_pct)
    - name: "Total Min Cap Rate Pct"
      expr: SUM(min_cap_rate_pct)
    - name: "Average Min Cap Rate Pct"
      expr: AVG(min_cap_rate_pct)
    - name: "Total Min Gla Sqf"
      expr: SUM(min_gla_sqf)
    - name: "Average Min Gla Sqf"
      expr: AVG(min_gla_sqf)
    - name: "Total Parking Ratio Min"
      expr: SUM(parking_ratio_min)
    - name: "Average Parking Ratio Min"
      expr: AVG(parking_ratio_min)
    - name: "Total Typical Psf Rent Max"
      expr: SUM(typical_psf_rent_max)
    - name: "Average Typical Psf Rent Max"
      expr: AVG(typical_psf_rent_max)
    - name: "Total Typical Psf Rent Min"
      expr: SUM(typical_psf_rent_min)
    - name: "Average Typical Psf Rent Min"
      expr: AVG(typical_psf_rent_min)
    - name: "Total Typical Vacancy Rate Pct"
      expr: SUM(typical_vacancy_rate_pct)
    - name: "Average Typical Vacancy Rate Pct"
      expr: AVG(typical_vacancy_rate_pct)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_construction_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Construction Type business metrics"
  source: "`real_estate_ecm`.`reference`.`construction_type`"
  dimensions:
    - name: "Acoustic Performance Rating"
      expr: acoustic_performance_rating
    - name: "Applicable Property Types"
      expr: applicable_property_types
    - name: "Bim Support"
      expr: bim_support
    - name: "Breeam Compatibility"
      expr: breeam_compatibility
    - name: "Construction Category"
      expr: construction_category
    - name: "Construction Method"
      expr: construction_method
    - name: "Construction Type Code"
      expr: construction_type_code
    - name: "Construction Type Description"
      expr: construction_type_description
    - name: "Construction Type Name"
      expr: construction_type_name
    - name: "Construction Type Status"
      expr: construction_type_status
    - name: "Cost Benchmark Year"
      expr: cost_benchmark_year
    - name: "Costar Construction Type Code"
      expr: costar_construction_type_code
    - name: "Depreciation Method"
      expr: depreciation_method
    - name: "Effective Date"
      expr: effective_date
    - name: "Energy Efficiency Profile"
      expr: energy_efficiency_profile
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Construction Type"
      expr: COUNT(DISTINCT construction_type_id)
    - name: "Total Fire Resistance Rating Hours"
      expr: SUM(fire_resistance_rating_hours)
    - name: "Average Fire Resistance Rating Hours"
      expr: AVG(fire_resistance_rating_hours)
    - name: "Total Floor Load Capacity Psf"
      expr: SUM(floor_load_capacity_psf)
    - name: "Average Floor Load Capacity Psf"
      expr: AVG(floor_load_capacity_psf)
    - name: "Total Max Building Height Ft"
      expr: SUM(max_building_height_ft)
    - name: "Average Max Building Height Ft"
      expr: AVG(max_building_height_ft)
    - name: "Total Replacement Cost Multiplier"
      expr: SUM(replacement_cost_multiplier)
    - name: "Average Replacement Cost Multiplier"
      expr: AVG(replacement_cost_multiplier)
    - name: "Total Typical Cost Psf High"
      expr: SUM(typical_cost_psf_high)
    - name: "Average Typical Cost Psf High"
      expr: AVG(typical_cost_psf_high)
    - name: "Total Typical Cost Psf Low"
      expr: SUM(typical_cost_psf_low)
    - name: "Average Typical Cost Psf Low"
      expr: AVG(typical_cost_psf_low)
    - name: "Total Typical Span Ft"
      expr: SUM(typical_span_ft)
    - name: "Average Typical Span Ft"
      expr: AVG(typical_span_ft)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_country`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Country business metrics"
  source: "`real_estate_ecm`.`reference`.`country`"
  dimensions:
    - name: "Alpha2 Code"
      expr: alpha2_code
    - name: "Alpha3 Code"
      expr: alpha3_code
    - name: "Aml Risk Rating"
      expr: aml_risk_rating
    - name: "Area Measurement Body"
      expr: area_measurement_body
    - name: "Breeam Recognized"
      expr: breeam_recognized
    - name: "Capital City"
      expr: capital_city
    - name: "Capital Gains Tax Applicable"
      expr: capital_gains_tax_applicable
    - name: "Country Name"
      expr: country_name
    - name: "Country Status"
      expr: country_status
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Currency Code"
      expr: default_currency_code
    - name: "Dialing Code"
      expr: dialing_code
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Esg Reporting Framework"
      expr: esg_reporting_framework
    - name: "Fatf Member"
      expr: fatf_member
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Country"
      expr: COUNT(DISTINCT country_id)
    - name: "Total Standard Vat Rate Pct"
      expr: SUM(standard_vat_rate_pct)
    - name: "Average Standard Vat Rate Pct"
      expr: AVG(standard_vat_rate_pct)
    - name: "Total Withholding Tax Rate Pct"
      expr: SUM(withholding_tax_rate_pct)
    - name: "Average Withholding Tax Rate Pct"
      expr: AVG(withholding_tax_rate_pct)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_currency_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency Code business metrics"
  source: "`real_estate_ecm`.`reference`.`currency_code`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code Code"
      expr: currency_code_code
    - name: "Currency Code Name"
      expr: currency_code_name
    - name: "Currency Type"
      expr: currency_type
    - name: "Decimal Separator"
      expr: decimal_separator
    - name: "Discontinuation Date"
      expr: discontinuation_date
    - name: "Display Format"
      expr: display_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Exchange Rate Source"
      expr: exchange_rate_source
    - name: "Exchange Rate Type"
      expr: exchange_rate_type
    - name: "Is Active"
      expr: is_active
    - name: "Is Freely Convertible"
      expr: is_freely_convertible
    - name: "Is Functional Currency"
      expr: is_functional_currency
    - name: "Is Hard Currency"
      expr: is_hard_currency
    - name: "Is Reporting Currency"
      expr: is_reporting_currency
    - name: "Iso 4217 Status"
      expr: iso_4217_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency Code"
      expr: COUNT(DISTINCT currency_code_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_document_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document Type business metrics"
  source: "`real_estate_ecm`.`reference`.`document_type`"
  dimensions:
    - name: "Allowed Lifecycle States"
      expr: allowed_lifecycle_states
    - name: "Confidentiality Level"
      expr: confidentiality_level
    - name: "Contains Pii"
      expr: contains_pii
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Lifecycle State"
      expr: default_lifecycle_state
    - name: "Document Type Category"
      expr: document_type_category
    - name: "Document Type Status"
      expr: document_type_status
    - name: "Domain"
      expr: domain
    - name: "Effective Date"
      expr: effective_date
    - name: "Esg Relevant"
      expr: esg_relevant
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Standard Code"
      expr: external_standard_code
    - name: "Filing Obligation"
      expr: filing_obligation
    - name: "Is Legal Instrument"
      expr: is_legal_instrument
    - name: "Is Recordable"
      expr: is_recordable
    - name: "Is Regulated"
      expr: is_regulated
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Document Type"
      expr: COUNT(DISTINCT document_type_id)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_geographic_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Geographic Hierarchy business metrics"
  source: "`real_estate_ecm`.`reference`.`geographic_hierarchy`"
  dimensions:
    - name: "City Name"
      expr: city_name
    - name: "Costar Submarket Code"
      expr: costar_submarket_code
    - name: "Costar Submarket Name"
      expr: costar_submarket_name
    - name: "Effective Date"
      expr: effective_date
    - name: "Enterprise Zone Flag"
      expr: enterprise_zone_flag
    - name: "Esg Climate Risk Zone"
      expr: esg_climate_risk_zone
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Fips Code"
      expr: fips_code
    - name: "Flood Zone Designation"
      expr: flood_zone_designation
    - name: "Hierarchy Depth"
      expr: hierarchy_depth
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Hud Area Code"
      expr: hud_area_code
    - name: "Market Tier"
      expr: market_tier
    - name: "Msa Code"
      expr: msa_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Geographic Hierarchy"
      expr: COUNT(DISTINCT geographic_hierarchy_id)
    - name: "Total Area Sqm"
      expr: SUM(area_sqm)
    - name: "Average Area Sqm"
      expr: AVG(area_sqm)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Median Household Income"
      expr: SUM(median_household_income)
    - name: "Average Median Household Income"
      expr: AVG(median_household_income)
    - name: "Total Population"
      expr: SUM(population)
    - name: "Average Population"
      expr: AVG(population)
    - name: "Total Unemployment Rate"
      expr: SUM(unemployment_rate)
    - name: "Average Unemployment Rate"
      expr: AVG(unemployment_rate)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_industry_classification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Industry Classification business metrics"
  source: "`real_estate_ecm`.`reference`.`industry_classification`"
  dimensions:
    - name: "Classification System"
      expr: classification_system
    - name: "Code Version"
      expr: code_version
    - name: "Costar Category"
      expr: costar_category
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Risk Tier"
      expr: credit_risk_tier
    - name: "Effective Date"
      expr: effective_date
    - name: "Esg Risk Category"
      expr: esg_risk_category
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gics Equivalent Code"
      expr: gics_equivalent_code
    - name: "Hazmat Risk Flag"
      expr: hazmat_risk_flag
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Industry Classification Description"
      expr: industry_classification_description
    - name: "Industry Classification Status"
      expr: industry_classification_status
    - name: "Is Anchor Eligible"
      expr: is_anchor_eligible
    - name: "Is Essential Business"
      expr: is_essential_business
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Industry Classification"
      expr: COUNT(DISTINCT industry_classification_id)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_investment_vehicle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Investment Vehicle business metrics"
  source: "`real_estate_ecm`.`reference`.`investment_vehicle`"
  dimensions:
    - name: "Accounting Standard"
      expr: accounting_standard
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Erisa Eligible"
      expr: erisa_eligible
    - name: "Esg Reporting Required"
      expr: esg_reporting_required
    - name: "Exchange Listed"
      expr: exchange_listed
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Finra Product Type Code"
      expr: finra_product_type_code
    - name: "Fund Structure"
      expr: fund_structure
    - name: "Geographic Focus"
      expr: geographic_focus
    - name: "Hud Regulated"
      expr: hud_regulated
    - name: "Inrev Vehicle Type Code"
      expr: inrev_vehicle_type_code
    - name: "Investment Strategy"
      expr: investment_strategy
    - name: "Investment Vehicle Description"
      expr: investment_vehicle_description
    - name: "Investment Vehicle Status"
      expr: investment_vehicle_status
    - name: "Investor Eligibility"
      expr: investor_eligibility
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Investment Vehicle"
      expr: COUNT(DISTINCT investment_vehicle_id)
    - name: "Total Carried Interest Pct"
      expr: SUM(carried_interest_pct)
    - name: "Average Carried Interest Pct"
      expr: AVG(carried_interest_pct)
    - name: "Total Max Leverage Ratio"
      expr: SUM(max_leverage_ratio)
    - name: "Average Max Leverage Ratio"
      expr: AVG(max_leverage_ratio)
    - name: "Total Min Investment Amount"
      expr: SUM(min_investment_amount)
    - name: "Average Min Investment Amount"
      expr: AVG(min_investment_amount)
    - name: "Total Preferred Return Pct"
      expr: SUM(preferred_return_pct)
    - name: "Average Preferred Return Pct"
      expr: AVG(preferred_return_pct)
    - name: "Total Reit Distribution Requirement Pct"
      expr: SUM(reit_distribution_requirement_pct)
    - name: "Average Reit Distribution Requirement Pct"
      expr: AVG(reit_distribution_requirement_pct)
    - name: "Total Typical Hold Period Years"
      expr: SUM(typical_hold_period_years)
    - name: "Average Typical Hold Period Years"
      expr: AVG(typical_hold_period_years)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_lease_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Lease Type business metrics"
  source: "`real_estate_ecm`.`reference`.`lease_type`"
  dimensions:
    - name: "Abbreviation"
      expr: abbreviation
    - name: "Area Measure Standard"
      expr: area_measure_standard
    - name: "Argus Lease Type Code"
      expr: argus_lease_type_code
    - name: "Asc842 Lease Classification"
      expr: asc842_lease_classification
    - name: "Cam Reconciliation Required"
      expr: cam_reconciliation_required
    - name: "Cam Responsibility"
      expr: cam_responsibility
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Escalation Method"
      expr: escalation_method
    - name: "Esg Reporting Applicable"
      expr: esg_reporting_applicable
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Ifrs16 Lease Classification"
      expr: ifrs16_lease_classification
    - name: "Insurance Responsibility"
      expr: insurance_responsibility
    - name: "Is Ground Lease"
      expr: is_ground_lease
    - name: "Is Short Term"
      expr: is_short_term
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Lease Type"
      expr: COUNT(DISTINCT lease_type_id)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_market_segment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market Segment business metrics"
  source: "`real_estate_ecm`.`reference`.`market_segment`"
  dimensions:
    - name: "Data Steward"
      expr: data_steward
    - name: "Development Allowed"
      expr: development_allowed
    - name: "Distressed Asset Eligible"
      expr: distressed_asset_eligible
    - name: "Effective Date"
      expr: effective_date
    - name: "Esg Classification"
      expr: esg_classification
    - name: "Exit Strategy"
      expr: exit_strategy
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Benchmark Name"
      expr: external_benchmark_name
    - name: "Geographic Focus"
      expr: geographic_focus
    - name: "Income Return Focus"
      expr: income_return_focus
    - name: "Inrev Strategy Code"
      expr: inrev_strategy_code
    - name: "Investment Strategy Type"
      expr: investment_strategy_type
    - name: "Investor Type Target"
      expr: investor_type_target
    - name: "Is Active"
      expr: is_active
    - name: "Last Reviewed Date"
      expr: last_reviewed_date
    - name: "Leverage Strategy"
      expr: leverage_strategy
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Market Segment"
      expr: COUNT(DISTINCT market_segment_id)
    - name: "Total Equity Multiple Max"
      expr: SUM(equity_multiple_max)
    - name: "Average Equity Multiple Max"
      expr: AVG(equity_multiple_max)
    - name: "Total Equity Multiple Min"
      expr: SUM(equity_multiple_min)
    - name: "Average Equity Multiple Min"
      expr: AVG(equity_multiple_min)
    - name: "Total Hold Period Max Years"
      expr: SUM(hold_period_max_years)
    - name: "Average Hold Period Max Years"
      expr: AVG(hold_period_max_years)
    - name: "Total Hold Period Min Years"
      expr: SUM(hold_period_min_years)
    - name: "Average Hold Period Min Years"
      expr: AVG(hold_period_min_years)
    - name: "Total Occupancy Threshold Min Pct"
      expr: SUM(occupancy_threshold_min_pct)
    - name: "Average Occupancy Threshold Min Pct"
      expr: AVG(occupancy_threshold_min_pct)
    - name: "Total Target Cap Rate Max Pct"
      expr: SUM(target_cap_rate_max_pct)
    - name: "Average Target Cap Rate Max Pct"
      expr: AVG(target_cap_rate_max_pct)
    - name: "Total Target Cap Rate Min Pct"
      expr: SUM(target_cap_rate_min_pct)
    - name: "Average Target Cap Rate Min Pct"
      expr: AVG(target_cap_rate_min_pct)
    - name: "Total Target Dscr Min"
      expr: SUM(target_dscr_min)
    - name: "Average Target Dscr Min"
      expr: AVG(target_dscr_min)
    - name: "Total Target Irr Max Pct"
      expr: SUM(target_irr_max_pct)
    - name: "Average Target Irr Max Pct"
      expr: AVG(target_irr_max_pct)
    - name: "Total Target Irr Min Pct"
      expr: SUM(target_irr_min_pct)
    - name: "Average Target Irr Min Pct"
      expr: AVG(target_irr_min_pct)
    - name: "Total Target Ltv Max Pct"
      expr: SUM(target_ltv_max_pct)
    - name: "Average Target Ltv Max Pct"
      expr: AVG(target_ltv_max_pct)
    - name: "Total Typical Asset Size Max Usd"
      expr: SUM(typical_asset_size_max_usd)
    - name: "Average Typical Asset Size Max Usd"
      expr: AVG(typical_asset_size_max_usd)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_program_property_type_coverage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program Property Type Coverage business metrics"
  source: "`real_estate_ecm`.`reference`.`program_property_type_coverage`"
  dimensions:
    - name: "Coverage Requirement"
      expr: coverage_requirement
    - name: "Created Date"
      expr: created_date
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusion List"
      expr: exclusion_list
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Last Modified By"
      expr: last_modified_by
    - name: "Last Modified Date"
      expr: last_modified_date
    - name: "Mandatory Endorsements"
      expr: mandatory_endorsements
    - name: "Rate Tier"
      expr: rate_tier
    - name: "Underwriter Notes"
      expr: underwriter_notes
    - name: "Created Date Month"
      expr: DATE_TRUNC('MONTH', created_date)
    - name: "Effective Date Month"
      expr: DATE_TRUNC('MONTH', effective_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Program Property Type Coverage"
      expr: COUNT(DISTINCT program_property_type_coverage_id)
    - name: "Total Deductible Override"
      expr: SUM(deductible_override)
    - name: "Average Deductible Override"
      expr: AVG(deductible_override)
    - name: "Total Min Coverage Limit"
      expr: SUM(min_coverage_limit)
    - name: "Average Min Coverage Limit"
      expr: AVG(min_coverage_limit)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_property_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Type business metrics"
  source: "`real_estate_ecm`.`reference`.`property_type`"
  dimensions:
    - name: "Amenity Classification"
      expr: amenity_classification
    - name: "Asset Class"
      expr: asset_class
    - name: "Bim Applicable"
      expr: bim_applicable
    - name: "Cam Inclusion Rule"
      expr: cam_inclusion_rule
    - name: "Costar Property Type Code"
      expr: costar_property_type_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Far Applicable"
      expr: far_applicable
    - name: "Hierarchy Level"
      expr: hierarchy_level
    - name: "Hierarchy Path"
      expr: hierarchy_path
    - name: "Hoa Applicable"
      expr: hoa_applicable
    - name: "Ibc Fire Resistance Type"
      expr: ibc_fire_resistance_type
    - name: "Is Cam Applicable"
      expr: is_cam_applicable
    - name: "Is Commercial"
      expr: is_commercial
    - name: "Is Esg Relevant"
      expr: is_esg_relevant
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Type"
      expr: COUNT(DISTINCT property_type_id)
    - name: "Total Cap Rate Benchmark Pct"
      expr: SUM(cap_rate_benchmark_pct)
    - name: "Average Cap Rate Benchmark Pct"
      expr: AVG(cap_rate_benchmark_pct)
    - name: "Total Ti Allowance Benchmark Psf"
      expr: SUM(ti_allowance_benchmark_psf)
    - name: "Average Ti Allowance Benchmark Psf"
      expr: AVG(ti_allowance_benchmark_psf)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_regulatory_framework`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory Framework business metrics"
  source: "`real_estate_ecm`.`reference`.`regulatory_framework`"
  dimensions:
    - name: "Applicable Business Processes"
      expr: applicable_business_processes
    - name: "Applicable Data Domains"
      expr: applicable_data_domains
    - name: "Asset Class Applicability"
      expr: asset_class_applicability
    - name: "Citation Reference"
      expr: citation_reference
    - name: "Compliance Owner"
      expr: compliance_owner
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "External Reference Url"
      expr: external_reference_url
    - name: "Framework Category"
      expr: framework_category
    - name: "Framework Code"
      expr: framework_code
    - name: "Framework Name"
      expr: framework_name
    - name: "Framework Type"
      expr: framework_type
    - name: "Internal Policy Reference"
      expr: internal_policy_reference
    - name: "Is Esg Relevant"
      expr: is_esg_relevant
    - name: "Is Financial Reporting"
      expr: is_financial_reporting
    - name: "Is Mandatory"
      expr: is_mandatory
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Regulatory Framework"
      expr: COUNT(DISTINCT regulatory_framework_id)
    - name: "Total Max Penalty Amount"
      expr: SUM(max_penalty_amount)
    - name: "Average Max Penalty Amount"
      expr: AVG(max_penalty_amount)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_space_use_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space Use Type business metrics"
  source: "`real_estate_ecm`.`reference`.`space_use_type`"
  dimensions:
    - name: "Ada Compliance Required"
      expr: ada_compliance_required
    - name: "Applicable Lease Structures"
      expr: applicable_lease_structures
    - name: "Breakpoint Type"
      expr: breakpoint_type
    - name: "Cam Inclusion Rule"
      expr: cam_inclusion_rule
    - name: "Cam Recovery Method"
      expr: cam_recovery_method
    - name: "Capex Responsibility"
      expr: capex_responsibility
    - name: "Co Tenancy Applicable"
      expr: co_tenancy_applicable
    - name: "Effective Date"
      expr: effective_date
    - name: "Exclusive Use Applicable"
      expr: exclusive_use_applicable
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Code Costar"
      expr: external_code_costar
    - name: "External Code Reso"
      expr: external_code_reso
    - name: "Fire Egress Class"
      expr: fire_egress_class
    - name: "Fit Out Category"
      expr: fit_out_category
    - name: "Food Service Permitted"
      expr: food_service_permitted
    - name: "Hvac Responsibility"
      expr: hvac_responsibility
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Space Use Type"
      expr: COUNT(DISTINCT space_use_type_id)
    - name: "Total Base Rent Benchmark Psf"
      expr: SUM(base_rent_benchmark_psf)
    - name: "Average Base Rent Benchmark Psf"
      expr: AVG(base_rent_benchmark_psf)
    - name: "Total Load Factor Typical"
      expr: SUM(load_factor_typical)
    - name: "Average Load Factor Typical"
      expr: AVG(load_factor_typical)
    - name: "Total Max Contiguous Area"
      expr: SUM(max_contiguous_area)
    - name: "Average Max Contiguous Area"
      expr: AVG(max_contiguous_area)
    - name: "Total Min Divisible Area"
      expr: SUM(min_divisible_area)
    - name: "Average Min Divisible Area"
      expr: AVG(min_divisible_area)
    - name: "Total Occupancy Density Typical"
      expr: SUM(occupancy_density_typical)
    - name: "Average Occupancy Density Typical"
      expr: AVG(occupancy_density_typical)
    - name: "Total Parking Ratio Per 1000sqf"
      expr: SUM(parking_ratio_per_1000sqf)
    - name: "Average Parking Ratio Per 1000sqf"
      expr: AVG(parking_ratio_per_1000sqf)
    - name: "Total Ti Allowance Benchmark Psf"
      expr: SUM(ti_allowance_benchmark_psf)
    - name: "Average Ti Allowance Benchmark Psf"
      expr: AVG(ti_allowance_benchmark_psf)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_sustainability_rating`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Sustainability Rating business metrics"
  source: "`real_estate_ecm`.`reference`.`sustainability_rating`"
  dimensions:
    - name: "Applicable Building Types"
      expr: applicable_building_types
    - name: "Applicable Project Phase"
      expr: applicable_project_phase
    - name: "Breeam Assessment Type"
      expr: breeam_assessment_type
    - name: "Cap Rate Compression Bps"
      expr: cap_rate_compression_bps
    - name: "Carbon Reporting Applicable"
      expr: carbon_reporting_applicable
    - name: "Certifying Body Name"
      expr: certifying_body_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From"
      expr: effective_from
    - name: "Effective Until"
      expr: effective_until
    - name: "Energy Performance Focus"
      expr: energy_performance_focus
    - name: "Energy Star Eligible Property Types"
      expr: energy_star_eligible_property_types
    - name: "Esg Framework Alignment"
      expr: esg_framework_alignment
    - name: "External Reference Url"
      expr: external_reference_url
    - name: "Gresb Score Contribution"
      expr: gresb_score_contribution
    - name: "Indoor Air Quality Applicable"
      expr: indoor_air_quality_applicable
    - name: "Is Renewal Required"
      expr: is_renewal_required
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Sustainability Rating"
      expr: COUNT(DISTINCT sustainability_rating_id)
    - name: "Total Max Possible Score"
      expr: SUM(max_possible_score)
    - name: "Average Max Possible Score"
      expr: AVG(max_possible_score)
    - name: "Total Max Score Threshold"
      expr: SUM(max_score_threshold)
    - name: "Average Max Score Threshold"
      expr: AVG(max_score_threshold)
    - name: "Total Min Score Threshold"
      expr: SUM(min_score_threshold)
    - name: "Average Min Score Threshold"
      expr: AVG(min_score_threshold)
    - name: "Total Premium Rent Uplift Pct"
      expr: SUM(premium_rent_uplift_pct)
    - name: "Average Premium Rent Uplift Pct"
      expr: AVG(premium_rent_uplift_pct)
    - name: "Total Typical Certification Cost Usd"
      expr: SUM(typical_certification_cost_usd)
    - name: "Average Typical Certification Cost Usd"
      expr: AVG(typical_certification_cost_usd)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_tenure_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tenure Type business metrics"
  source: "`real_estate_ecm`.`reference`.`tenure_type`"
  dimensions:
    - name: "Alta Policy Type"
      expr: alta_policy_type
    - name: "Cmbs Eligible"
      expr: cmbs_eligible
    - name: "Cre Applicable"
      expr: cre_applicable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Esg Reporting Flag"
      expr: esg_reporting_flag
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Fasb Asc842 Classification"
      expr: fasb_asc842_classification
    - name: "Fractional Ownership"
      expr: fractional_ownership
    - name: "Ground Lease Applicable"
      expr: ground_lease_applicable
    - name: "Hoa Applicable"
      expr: hoa_applicable
    - name: "Ifrs16 Classification"
      expr: ifrs16_classification
    - name: "Is Financeable"
      expr: is_financeable
    - name: "Is Transferable"
      expr: is_transferable
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Tenure Type"
      expr: COUNT(DISTINCT tenure_type_id)
    - name: "Total Ltv Limit Pct"
      expr: SUM(ltv_limit_pct)
    - name: "Average Ltv Limit Pct"
      expr: AVG(ltv_limit_pct)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_transaction_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transaction Type business metrics"
  source: "`real_estate_ecm`.`reference`.`transaction_type`"
  dimensions:
    - name: "Appraisal Required"
      expr: appraisal_required
    - name: "Asset Class Applicability"
      expr: asset_class_applicability
    - name: "Broker Commission Applicable"
      expr: broker_commission_applicable
    - name: "Capex Or Opex"
      expr: capex_or_opex
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Due Diligence Period Days"
      expr: due_diligence_period_days
    - name: "Effective Date"
      expr: effective_date
    - name: "Environmental Review Required"
      expr: environmental_review_required
    - name: "Esg Disclosure Required"
      expr: esg_disclosure_required
    - name: "Expiry Date"
      expr: expiry_date
    - name: "External Reference Code"
      expr: external_reference_code
    - name: "Gl Transaction Class"
      expr: gl_transaction_class
    - name: "Is 1031 Eligible"
      expr: is_1031_eligible
    - name: "Is Distressed Asset"
      expr: is_distressed_asset
    - name: "Is Fasb Asc842 Applicable"
      expr: is_fasb_asc842_applicable
    - name: "Is Hud Reportable"
      expr: is_hud_reportable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Transaction Type"
      expr: COUNT(DISTINCT transaction_type_id)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_uom`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Uom business metrics"
  source: "`real_estate_ecm`.`reference`.`uom`"
  dimensions:
    - name: "Applicable Property Types"
      expr: applicable_property_types
    - name: "Area Standard"
      expr: area_standard
    - name: "Conversion Formula"
      expr: conversion_formula
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Region Code"
      expr: default_region_code
    - name: "Dimension Type"
      expr: dimension_type
    - name: "Display Order"
      expr: display_order
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Is Base Unit"
      expr: is_base_unit
    - name: "Is Rate Based"
      expr: is_rate_based
    - name: "Is Regulatory Disclosure Required"
      expr: is_regulatory_disclosure_required
    - name: "Is Rentable Area Measure"
      expr: is_rentable_area_measure
    - name: "Iso Uom Code"
      expr: iso_uom_code
    - name: "Measurement System"
      expr: measurement_system
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Uom"
      expr: COUNT(DISTINCT uom_id)
    - name: "Total Conversion Factor"
      expr: SUM(conversion_factor)
    - name: "Average Conversion Factor"
      expr: AVG(conversion_factor)
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`reference_zoning_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zoning Code business metrics"
  source: "`real_estate_ecm`.`reference`.`zoning_code`"
  dimensions:
    - name: "Affordable Housing Requirement Flag"
      expr: affordable_housing_requirement_flag
    - name: "Conditional Uses"
      expr: conditional_uses
    - name: "Density Class"
      expr: density_class
    - name: "Effective Date"
      expr: effective_date
    - name: "Environmental Overlay Flag"
      expr: environmental_overlay_flag
    - name: "Esg Designation"
      expr: esg_designation
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Gis Layer Reference"
      expr: gis_layer_reference
    - name: "Height Limit Stories"
      expr: height_limit_stories
    - name: "Jurisdiction Name"
      expr: jurisdiction_name
    - name: "Jurisdiction Type"
      expr: jurisdiction_type
    - name: "Last Amended Date"
      expr: last_amended_date
    - name: "Notes"
      expr: notes
    - name: "Ordinance Reference"
      expr: ordinance_reference
    - name: "Overlay District Flag"
      expr: overlay_district_flag
    - name: "Parking Ratio Unit"
      expr: parking_ratio_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Zoning Code"
      expr: COUNT(DISTINCT zoning_code_id)
    - name: "Total Far Max"
      expr: SUM(far_max)
    - name: "Average Far Max"
      expr: AVG(far_max)
    - name: "Total Far Min"
      expr: SUM(far_min)
    - name: "Average Far Min"
      expr: AVG(far_min)
    - name: "Total Front Setback Ft"
      expr: SUM(front_setback_ft)
    - name: "Average Front Setback Ft"
      expr: AVG(front_setback_ft)
    - name: "Total Height Limit Ft"
      expr: SUM(height_limit_ft)
    - name: "Average Height Limit Ft"
      expr: AVG(height_limit_ft)
    - name: "Total Lot Coverage Pct"
      expr: SUM(lot_coverage_pct)
    - name: "Average Lot Coverage Pct"
      expr: AVG(lot_coverage_pct)
    - name: "Total Min Lot Size Sqf"
      expr: SUM(min_lot_size_sqf)
    - name: "Average Min Lot Size Sqf"
      expr: AVG(min_lot_size_sqf)
    - name: "Total Min Lot Width Ft"
      expr: SUM(min_lot_width_ft)
    - name: "Average Min Lot Width Ft"
      expr: AVG(min_lot_width_ft)
    - name: "Total Parking Ratio Min"
      expr: SUM(parking_ratio_min)
    - name: "Average Parking Ratio Min"
      expr: AVG(parking_ratio_min)
    - name: "Total Rear Setback Ft"
      expr: SUM(rear_setback_ft)
    - name: "Average Rear Setback Ft"
      expr: AVG(rear_setback_ft)
    - name: "Total Side Setback Ft"
      expr: SUM(side_setback_ft)
    - name: "Average Side Setback Ft"
      expr: AVG(side_setback_ft)
$$;