-- Metric views for domain: property | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 04:45:11

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the real estate asset portfolio — acquisition cost basis, portfolio composition, GLA/NLA sizing, and encumbrance exposure. Used by portfolio managers, CFOs, and investment committees to evaluate portfolio scale, cost basis, and risk."
  source: "`real_estate_ecm`.`property`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Lifecycle status of the asset (e.g., Active, Disposed, Under Development) — used to filter operating vs. non-operating portfolio."
    - name: "asset_code"
      expr: asset_code
      comment: "Internal asset identifier code for drill-down reporting and cross-system reconciliation."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the asset was acquired — enables vintage analysis and cohort-based performance tracking."
    - name: "disposition_year"
      expr: YEAR(disposition_date)
      comment: "Year the asset was disposed — used to track portfolio turnover and exit timing."
    - name: "leed_certification"
      expr: leed_certification
      comment: "LEED sustainability certification level — used for ESG reporting and green portfolio segmentation."
    - name: "is_encumbered"
      expr: is_encumbered
      comment: "Flag indicating whether the asset carries a lien or encumbrance — critical for debt and risk reporting."
    - name: "coo_status"
      expr: coo_status
      comment: "Certificate of Occupancy status — indicates whether the asset is legally cleared for occupancy."
    - name: "year_built"
      expr: year_built
      comment: "Year the asset was originally constructed — used for age-based depreciation and capital planning segmentation."
    - name: "year_renovated"
      expr: year_renovated
      comment: "Most recent renovation year — used to assess capital reinvestment recency and asset quality."
    - name: "fips_code"
      expr: fips_code
      comment: "Federal Information Processing Standard geographic code — enables regulatory and geographic market segmentation."
  measures:
    - name: "total_assets"
      expr: COUNT(DISTINCT asset_id)
      comment: "Total number of distinct assets in the portfolio. Baseline KPI for portfolio scale used in board decks and investor reporting."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital deployed across all acquired assets. Core investment basis metric used by CFOs and investment committees to track total cost basis."
    - name: "avg_acquisition_cost"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset. Used to benchmark deal sizing and identify outliers in the portfolio."
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total Gross Leasable Area in square feet across the portfolio. Fundamental portfolio sizing metric used in investor presentations and market comparisons."
    - name: "total_nla_sqft"
      expr: SUM(CAST(nla_sqft AS DOUBLE))
      comment: "Total Net Leasable Area in square feet. Represents the revenue-generating footprint of the portfolio — key for occupancy and rent roll analysis."
    - name: "avg_far"
      expr: AVG(CAST(far AS DOUBLE))
      comment: "Average Floor Area Ratio across assets. Indicates land utilization intensity — used in development planning and zoning compliance reviews."
    - name: "encumbered_asset_count"
      expr: COUNT(DISTINCT CASE WHEN is_encumbered = TRUE THEN asset_id END)
      comment: "Number of assets carrying liens or encumbrances. Used by risk and legal teams to monitor debt exposure and title risk across the portfolio."
    - name: "encumbrance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_encumbered = TRUE THEN asset_id END) / NULLIF(COUNT(DISTINCT asset_id), 0), 2)
      comment: "Percentage of portfolio assets that are encumbered. A rising rate signals increasing leverage risk — monitored by CFOs and lenders."
    - name: "nla_to_gla_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(nla_sqft AS DOUBLE)) / NULLIF(SUM(CAST(gla_sqft AS DOUBLE)), 0), 2)
      comment: "Ratio of Net Leasable Area to Gross Leasable Area expressed as a percentage. Measures how efficiently gross space is converted to rentable area — higher values indicate better space utilization."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_occupancy_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and financial occupancy KPIs at the asset, building, space, or unit level. Covers physical and economic occupancy rates, absorption, rent performance, and income metrics. Used by asset managers, leasing teams, and CFOs to steer leasing strategy and income forecasting."
  source: "`real_estate_ecm`.`property`.`occupancy_record`"
  filter: record_status = 'Active'
  dimensions:
    - name: "period_type"
      expr: period_type
      comment: "Reporting period granularity (e.g., Monthly, Quarterly, Annual) — used to align metrics to financial reporting cycles."
    - name: "reporting_period_start_date"
      expr: reporting_period_start_date
      comment: "Start date of the reporting period — used as the primary time axis for trend analysis."
    - name: "reporting_period_end_date"
      expr: reporting_period_end_date
      comment: "End date of the reporting period — used to bound period-over-period comparisons."
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Point-in-time snapshot date for the occupancy record — enables as-of reporting and historical comparisons."
    - name: "measurement_level"
      expr: measurement_level
      comment: "Granularity level of the occupancy measurement (e.g., Asset, Building, Space, Unit) — used to control aggregation scope."
    - name: "is_same_store"
      expr: is_same_store
      comment: "Flag indicating whether the property is included in same-store comparisons — critical for like-for-like performance benchmarking."
    - name: "is_stabilized"
      expr: is_stabilized
      comment: "Flag indicating whether the asset has reached stabilized occupancy — used to separate lease-up assets from mature portfolio."
    - name: "data_quality_flag"
      expr: data_quality_flag
      comment: "Data quality indicator for the occupancy record — used to filter or flag records with known data issues."
    - name: "source_system"
      expr: source_system
      comment: "Source system that generated the occupancy record (e.g., Yardi, MRI) — used for data lineage and reconciliation."
    - name: "snapshot_year_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month-level truncation of the snapshot date — enables monthly trend analysis of occupancy and income metrics."
  measures:
    - name: "avg_physical_occupancy_rate_pct"
      expr: ROUND(AVG(CAST(physical_occupancy_rate AS DOUBLE)), 2)
      comment: "Average physical occupancy rate across records in the period. Core leasing KPI — measures what percentage of space is physically occupied. Tracked weekly by asset managers and reported to investors quarterly."
    - name: "avg_economic_occupancy_rate_pct"
      expr: ROUND(AVG(CAST(economic_occupancy_rate AS DOUBLE)), 2)
      comment: "Average economic occupancy rate — accounts for rent concessions, free rent, and credit loss. More conservative than physical occupancy; used by CFOs to forecast actual income collection."
    - name: "total_effective_gross_income"
      expr: SUM(CAST(effective_gross_income AS DOUBLE))
      comment: "Total Effective Gross Income across the portfolio for the period. Primary top-line revenue metric for real estate operations — used in NOI calculations and investor reporting."
    - name: "total_potential_gross_income"
      expr: SUM(CAST(potential_gross_income AS DOUBLE))
      comment: "Total Potential Gross Income assuming 100% occupancy at market rents. Establishes the revenue ceiling — the gap between PGI and EGI quantifies vacancy and credit loss impact."
    - name: "total_vacancy_loss_amount"
      expr: SUM(CAST(vacancy_loss_amount AS DOUBLE))
      comment: "Total revenue lost due to vacant space. Directly quantifies the financial cost of vacancy — used by leasing teams to prioritize lease-up efforts and by CFOs to stress-test income projections."
    - name: "total_credit_loss_amount"
      expr: SUM(CAST(credit_loss_amount AS DOUBLE))
      comment: "Total revenue lost due to tenant credit risk and bad debt. Monitors tenant credit quality impact on income — rising credit loss triggers tenant credit review and collection action."
    - name: "income_realization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(effective_gross_income AS DOUBLE)) / NULLIF(SUM(CAST(potential_gross_income AS DOUBLE)), 0), 2)
      comment: "Ratio of Effective Gross Income to Potential Gross Income expressed as a percentage. Composite efficiency metric capturing combined vacancy and credit loss drag — a key metric in asset performance reviews and lender covenant monitoring."
    - name: "avg_market_rent_psf"
      expr: ROUND(AVG(CAST(market_rent_psf AS DOUBLE)), 2)
      comment: "Average market rent per square foot. Benchmark for pricing new leases and renewals — used by leasing teams to assess competitiveness and by asset managers to identify mark-to-market opportunity."
    - name: "avg_in_place_rent_psf"
      expr: ROUND(AVG(CAST(average_in_place_rent_psf AS DOUBLE)), 2)
      comment: "Average in-place (contracted) rent per square foot. Compared against market rent to quantify mark-to-market upside or downside — a key metric for lease renewal strategy."
    - name: "rent_to_market_spread_psf"
      expr: ROUND(AVG(CAST(average_in_place_rent_psf AS DOUBLE)) - AVG(CAST(market_rent_psf AS DOUBLE)), 2)
      comment: "Difference between average in-place rent and market rent per square foot. Positive spread indicates above-market leases (rolldown risk); negative spread indicates below-market leases (mark-to-market upside). Critical for lease renewal and disposition pricing decisions."
    - name: "total_net_absorption_sqf"
      expr: SUM(CAST(net_absorption_sqf AS DOUBLE))
      comment: "Total net absorption in square feet — the net change in occupied space. Fundamental demand indicator used by leasing teams and market analysts to assess space demand trends."
    - name: "total_gross_absorption_sqf"
      expr: SUM(CAST(gross_absorption_sqf AS DOUBLE))
      comment: "Total gross absorption in square feet — all new space leased regardless of move-outs. Measures leasing velocity and is used to evaluate leasing team productivity."
    - name: "total_vacant_area_sqf"
      expr: SUM(CAST(vacant_area_sqf AS DOUBLE))
      comment: "Total vacant area in square feet across the portfolio. Directly quantifies the unleased inventory — used to prioritize leasing resources and capital allocation."
    - name: "avg_wale_years"
      expr: ROUND(AVG(CAST(wale_years AS DOUBLE)), 2)
      comment: "Weighted Average Lease Expiry by area in years. Measures portfolio income security — longer WALE indicates more stable future cash flows. Monitored by investors and lenders as a credit quality indicator."
    - name: "avg_walt_years"
      expr: ROUND(AVG(CAST(walt_years AS DOUBLE)), 2)
      comment: "Weighted Average Lease Term by area in years. Indicates the average remaining lease duration — used alongside WALE to assess lease rollover risk and refinancing timing."
    - name: "total_lease_expirations_sqf"
      expr: SUM(CAST(lease_expirations_sqf AS DOUBLE))
      comment: "Total square footage of leases expiring in the period. Quantifies near-term rollover risk — used by leasing teams to prioritize renewal campaigns and by CFOs to model income at risk."
    - name: "total_new_leases_sqf"
      expr: SUM(CAST(new_leases_sqf AS DOUBLE))
      comment: "Total square footage of new leases executed in the period. Measures new leasing activity — used to track leasing team performance and portfolio growth."
    - name: "total_renewal_leases_sqf"
      expr: SUM(CAST(renewal_leases_sqf AS DOUBLE))
      comment: "Total square footage of lease renewals executed in the period. Measures tenant retention — high renewal volume reduces re-leasing costs and vacancy risk."
    - name: "renewal_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(renewal_leases_sqf AS DOUBLE)) / NULLIF(SUM(CAST(lease_expirations_sqf AS DOUBLE)), 0), 2)
      comment: "Percentage of expiring square footage that was renewed. Core tenant retention KPI — a declining renewal rate signals tenant satisfaction issues or competitive market pressure."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_building`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical and operational KPIs for buildings within the portfolio. Covers rentable area, load factor efficiency, parking ratios, and ADA/ESG compliance. Used by asset managers, property managers, and sustainability officers to evaluate building quality and operational readiness."
  source: "`real_estate_ecm`.`property`.`building`"
  dimensions:
    - name: "building_status"
      expr: building_status
      comment: "Operational status of the building (e.g., Active, Under Construction, Decommissioned) — used to filter the operating portfolio."
    - name: "building_name"
      expr: building_name
      comment: "Human-readable building name — used as the primary label in building-level dashboards and reports."
    - name: "year_built"
      expr: year_built
      comment: "Year the building was constructed — used for age-based capital planning and depreciation analysis."
    - name: "year_renovated"
      expr: year_renovated
      comment: "Most recent renovation year — used to assess capital reinvestment recency and building quality tier."
    - name: "hvac_system_type"
      expr: hvac_system_type
      comment: "Type of HVAC system installed — used for energy efficiency benchmarking and capital replacement planning."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag — used for regulatory compliance reporting and risk management."
    - name: "is_esg_reported"
      expr: is_esg_reported
      comment: "Flag indicating whether the building is included in ESG reporting — used to track sustainability disclosure coverage."
    - name: "fire_suppression_type"
      expr: fire_suppression_type
      comment: "Type of fire suppression system — used for life safety compliance audits and insurance underwriting."
    - name: "coo_date_year"
      expr: YEAR(coo_date)
      comment: "Year the Certificate of Occupancy was issued — used to track building commissioning timelines."
  measures:
    - name: "total_buildings"
      expr: COUNT(DISTINCT building_id)
      comment: "Total number of distinct buildings in the portfolio. Baseline scale metric used in portfolio summaries and investor reporting."
    - name: "total_rentable_sqft"
      expr: SUM(CAST(total_rentable_sqft AS DOUBLE))
      comment: "Total rentable square footage across all buildings. Primary revenue-capacity metric — used to size the leasable portfolio and benchmark against market peers."
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total Gross Leasable Area in square feet. Used alongside NLA to compute building efficiency ratios and benchmark against market standards."
    - name: "total_nla_sqft"
      expr: SUM(CAST(nla_sqft AS DOUBLE))
      comment: "Total Net Leasable Area in square feet. Represents the net revenue-generating footprint — used in rent roll analysis and income forecasting."
    - name: "avg_load_factor"
      expr: ROUND(AVG(CAST(load_factor AS DOUBLE)), 4)
      comment: "Average load factor (ratio of rentable to usable area) across buildings. Measures how much common area tenants pay for — higher load factors reduce tenant value; used in lease negotiation and building repositioning decisions."
    - name: "avg_parking_ratio"
      expr: ROUND(AVG(CAST(parking_ratio AS DOUBLE)), 2)
      comment: "Average parking ratio (stalls per 1,000 sq ft) across buildings. Key amenity metric for commercial tenants — used in leasing marketing and building competitiveness assessments."
    - name: "nla_to_gla_efficiency_pct"
      expr: ROUND(100.0 * SUM(CAST(nla_sqft AS DOUBLE)) / NULLIF(SUM(CAST(gla_sqft AS DOUBLE)), 0), 2)
      comment: "Ratio of Net Leasable Area to Gross Leasable Area as a percentage. Measures building space efficiency — lower ratios indicate higher common area overhead, impacting tenant economics and leasing competitiveness."
    - name: "ada_compliant_building_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN building_id END)
      comment: "Number of ADA-compliant buildings. Used for regulatory compliance tracking and risk management — non-compliant buildings carry legal and reputational risk."
    - name: "ada_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN building_id END) / NULLIF(COUNT(DISTINCT building_id), 0), 2)
      comment: "Percentage of buildings that are ADA compliant. Compliance rate below 100% signals regulatory exposure — monitored by legal, risk, and ESG teams."
    - name: "esg_reported_building_count"
      expr: COUNT(DISTINCT CASE WHEN is_esg_reported = TRUE THEN building_id END)
      comment: "Number of buildings included in ESG reporting. Tracks sustainability disclosure coverage — used by sustainability officers and investor relations teams."
    - name: "esg_reporting_coverage_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_esg_reported = TRUE THEN building_id END) / NULLIF(COUNT(DISTINCT building_id), 0), 2)
      comment: "Percentage of buildings covered by ESG reporting. Measures sustainability disclosure completeness — a key metric for ESG-focused investors and regulatory frameworks like GRESB."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Leasing and space utilization KPIs at the individual space level. Covers rentable area inventory, asking vs. effective rent spreads, TI allowance exposure, and space availability. Used by leasing teams, asset managers, and CFOs to manage space inventory and optimize rental income."
  source: "`real_estate_ecm`.`property`.`space`"
  dimensions:
    - name: "space_status"
      expr: space_status
      comment: "Current status of the space (e.g., Vacant, Occupied, Under Renovation) — primary filter for available inventory reporting."
    - name: "space_type"
      expr: space_type
      comment: "Type of space (e.g., Office, Retail, Industrial, Storage) — used to segment leasing metrics by use type."
    - name: "occupancy_class"
      expr: occupancy_class
      comment: "Occupancy classification of the space — used for regulatory and operational segmentation."
    - name: "condition"
      expr: condition
      comment: "Physical condition of the space (e.g., Shell, Warm Shell, Turnkey) — used to assess TI investment requirements and leasing readiness."
    - name: "is_subdivisible"
      expr: is_subdivisible
      comment: "Flag indicating whether the space can be subdivided — used to assess flexibility for smaller tenant requirements."
    - name: "is_contiguous"
      expr: is_contiguous
      comment: "Flag indicating whether the space is contiguous with adjacent spaces — used to identify large-block availability for anchor tenants."
    - name: "cam_eligible"
      expr: cam_eligible
      comment: "Flag indicating whether the space is subject to CAM (Common Area Maintenance) charges — used in lease structuring and income modeling."
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED certification level of the space — used for ESG reporting and green leasing premium analysis."
    - name: "available_date"
      expr: available_date
      comment: "Date the space becomes available for leasing — used to build availability pipelines and forecast vacancy timelines."
  measures:
    - name: "total_spaces"
      expr: COUNT(DISTINCT space_id)
      comment: "Total number of distinct spaces in the inventory. Baseline inventory count used in leasing pipeline management and portfolio reporting."
    - name: "total_rentable_area_sqf"
      expr: SUM(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Total rentable area in square feet across all spaces. Primary inventory sizing metric — used to quantify the leasable portfolio and benchmark against market absorption."
    - name: "total_usable_area_sqf"
      expr: SUM(CAST(usable_area_sqf AS DOUBLE))
      comment: "Total usable area in square feet. Represents the actual occupiable area for tenants — used alongside rentable area to compute load factors and tenant economics."
    - name: "vacant_space_count"
      expr: COUNT(DISTINCT CASE WHEN space_status = 'Vacant' THEN space_id END)
      comment: "Number of vacant spaces. Directly quantifies unleased inventory — used by leasing teams to prioritize outreach and by CFOs to model vacancy loss."
    - name: "avg_asking_rent_psf"
      expr: ROUND(AVG(CAST(asking_rent_psf AS DOUBLE)), 2)
      comment: "Average asking rent per square foot across spaces. Benchmark for market positioning — used by leasing teams to set competitive pricing and by asset managers to assess revenue potential."
    - name: "avg_effective_rent_psf"
      expr: ROUND(AVG(CAST(effective_rent_psf AS DOUBLE)), 2)
      comment: "Average effective rent per square foot after concessions. Measures actual economic rent achieved — the gap between asking and effective rent quantifies concession costs and leasing market competitiveness."
    - name: "asking_to_effective_rent_spread_psf"
      expr: ROUND(AVG(CAST(asking_rent_psf AS DOUBLE)) - AVG(CAST(effective_rent_psf AS DOUBLE)), 2)
      comment: "Spread between average asking rent and average effective rent per square foot. Quantifies the concession burden — a widening spread signals a tenant-favorable market and rising leasing costs."
    - name: "avg_ti_allowance_psf"
      expr: ROUND(AVG(CAST(ti_allowance_psf AS DOUBLE)), 2)
      comment: "Average Tenant Improvement allowance per square foot. Measures capital commitment per lease — used by CFOs to budget TI expenditures and by leasing teams to assess deal competitiveness."
    - name: "total_cam_area_sqf"
      expr: SUM(CAST(cam_area_sqf AS DOUBLE))
      comment: "Total CAM-eligible area in square feet. Used to calculate CAM recovery pools and ensure accurate operating expense reconciliation."
    - name: "avg_load_factor"
      expr: ROUND(AVG(CAST(load_factor AS DOUBLE)), 4)
      comment: "Average load factor across spaces. Measures common area overhead charged to tenants — used in lease negotiation and space pricing strategy."
    - name: "avg_pro_rata_share"
      expr: ROUND(AVG(CAST(pro_rata_share AS DOUBLE)), 4)
      comment: "Average pro-rata share of building expenses allocated to spaces. Used to validate CAM billing accuracy and ensure equitable expense allocation across tenants."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Residential and mixed-use unit-level KPIs covering rent pricing, unit inventory, TI allowances, and unit efficiency. Used by property managers, leasing teams, and asset managers to optimize unit pricing, track availability, and manage capital investment per unit."
  source: "`real_estate_ecm`.`property`.`unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of the unit (e.g., Vacant, Occupied, Down, Under Renovation) — primary filter for availability and occupancy reporting."
    - name: "unit_type"
      expr: unit_type
      comment: "Unit type classification (e.g., Studio, 1BR, 2BR, Penthouse) — used to segment pricing and occupancy metrics by unit mix."
    - name: "bedroom_count"
      expr: bedroom_count
      comment: "Number of bedrooms in the unit — used for unit mix analysis and rent pricing segmentation."
    - name: "configuration"
      expr: configuration
      comment: "Unit layout configuration — used for product differentiation and leasing marketing segmentation."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for the unit — used for regulatory compliance tracking and accessible housing reporting."
    - name: "is_furnished"
      expr: is_furnished
      comment: "Flag indicating whether the unit is furnished — used to segment furnished vs. unfurnished inventory and pricing."
    - name: "has_balcony"
      expr: has_balcony
      comment: "Flag indicating whether the unit has a balcony — used as a premium amenity indicator in pricing analysis."
    - name: "view_type"
      expr: view_type
      comment: "Type of view from the unit (e.g., City, Park, Water) — used as a premium pricing factor in rent analysis."
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy efficiency rating of the unit — used for ESG reporting and utility cost benchmarking."
    - name: "coo_status"
      expr: coo_status
      comment: "Certificate of Occupancy status for the unit — used to track legal occupancy readiness."
  measures:
    - name: "total_units"
      expr: COUNT(DISTINCT unit_id)
      comment: "Total number of distinct units in the portfolio. Baseline inventory count used in occupancy reporting and investor presentations."
    - name: "total_rentable_area_sqf"
      expr: SUM(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Total rentable area in square feet across all units. Measures the revenue-generating residential footprint — used in rent roll analysis and portfolio sizing."
    - name: "avg_asking_rent_psf"
      expr: ROUND(AVG(CAST(asking_rent_psf AS DOUBLE)), 2)
      comment: "Average asking rent per square foot across units. Used by leasing teams to benchmark pricing against market comps and by asset managers to assess revenue potential."
    - name: "avg_market_rent_psf"
      expr: ROUND(AVG(CAST(market_rent_psf AS DOUBLE)), 2)
      comment: "Average market rent per square foot. Establishes the market pricing benchmark — compared against asking rent to assess pricing competitiveness."
    - name: "asking_to_market_rent_spread_psf"
      expr: ROUND(AVG(CAST(asking_rent_psf AS DOUBLE)) - AVG(CAST(market_rent_psf AS DOUBLE)), 2)
      comment: "Spread between average asking rent and market rent per square foot. Positive spread indicates above-market pricing (risk of extended vacancy); negative spread indicates below-market pricing (revenue upside opportunity)."
    - name: "avg_ti_allowance_psf"
      expr: ROUND(AVG(CAST(ti_allowance_psf AS DOUBLE)), 2)
      comment: "Average Tenant Improvement allowance per square foot for units. Used by CFOs to budget unit improvement capital and by leasing teams to assess deal competitiveness."
    - name: "avg_efficiency_ratio"
      expr: ROUND(AVG(CAST(efficiency_ratio AS DOUBLE)), 4)
      comment: "Average unit efficiency ratio (usable to rentable area). Measures how much of the rentable area is actually usable by tenants — higher ratios indicate better unit design and tenant value."
    - name: "avg_bathroom_count"
      expr: ROUND(AVG(CAST(bathroom_count AS DOUBLE)), 2)
      comment: "Average number of bathrooms per unit. Used in unit mix analysis and pricing strategy — higher bathroom counts typically command premium rents."
    - name: "furnished_unit_count"
      expr: COUNT(DISTINCT CASE WHEN is_furnished = TRUE THEN unit_id END)
      comment: "Number of furnished units in the portfolio. Used to track furnished inventory for premium short-term and corporate leasing programs."
    - name: "ada_compliant_unit_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN unit_id END)
      comment: "Number of ADA-compliant units. Used for regulatory compliance reporting and accessible housing program tracking."
    - name: "ada_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN unit_id END) / NULLIF(COUNT(DISTINCT unit_id), 0), 2)
      comment: "Percentage of units that are ADA compliant. Compliance rate below regulatory minimums triggers remediation — monitored by legal and property management teams."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property inspection quality, compliance, and cost KPIs. Covers deficiency rates, remediation cost exposure, regulatory compliance, and inspection outcomes. Used by property managers, risk officers, and compliance teams to manage building safety, regulatory obligations, and capital repair planning."
  source: "`real_estate_ecm`.`property`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., Fire Safety, Structural, Environmental, Routine) — used to segment compliance and deficiency metrics by inspection category."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection (e.g., Scheduled, Completed, Overdue) — used to track inspection pipeline and compliance deadlines."
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass/Fail outcome of the inspection — primary quality indicator used in compliance dashboards and regulatory reporting."
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Flag indicating whether the inspection is mandated by regulation — used to prioritize compliance-critical inspections."
    - name: "has_critical_deficiency"
      expr: has_critical_deficiency
      comment: "Flag indicating whether the inspection identified a critical deficiency — triggers immediate escalation and work order creation."
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Flag indicating whether a reinspection is required — used to track open compliance items and remediation follow-through."
    - name: "environmental_phase"
      expr: environmental_phase
      comment: "Environmental assessment phase (e.g., Phase I, Phase II) — used for environmental risk and due diligence reporting."
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was conducted — used for annual compliance trend analysis and capital planning."
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was conducted — used for monthly compliance tracking and seasonal inspection pattern analysis."
    - name: "frequency"
      expr: frequency
      comment: "Inspection frequency schedule (e.g., Annual, Semi-Annual, Quarterly) — used to validate inspection cadence compliance."
  measures:
    - name: "total_inspections"
      expr: COUNT(DISTINCT inspection_id)
      comment: "Total number of inspections conducted. Baseline compliance activity metric — used to track inspection program coverage and regulatory obligation fulfillment."
    - name: "critical_deficiency_inspection_count"
      expr: COUNT(DISTINCT CASE WHEN has_critical_deficiency = TRUE THEN inspection_id END)
      comment: "Number of inspections with critical deficiencies identified. Directly measures life safety and regulatory risk exposure — triggers immediate remediation and escalation to senior management."
    - name: "critical_deficiency_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_critical_deficiency = TRUE THEN inspection_id END) / NULLIF(COUNT(DISTINCT inspection_id), 0), 2)
      comment: "Percentage of inspections resulting in critical deficiencies. Key risk KPI — a rising rate signals deteriorating building conditions and increasing regulatory and liability exposure."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pass_fail_result = 'Pass' THEN inspection_id END) / NULLIF(COUNT(DISTINCT inspection_id), 0), 2)
      comment: "Percentage of inspections that passed. Primary compliance quality metric — used in regulatory reporting and property management performance reviews."
    - name: "reinspection_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN reinspection_required = TRUE THEN inspection_id END) / NULLIF(COUNT(DISTINCT inspection_id), 0), 2)
      comment: "Percentage of inspections requiring reinspection. Measures first-time compliance failure rate — high reinspection rates indicate systemic maintenance or compliance program deficiencies."
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated cost to remediate all identified deficiencies. Quantifies the capital liability from inspection findings — used by CFOs and asset managers to budget unplanned capital expenditures."
    - name: "total_immediate_repair_cost"
      expr: SUM(CAST(immediate_repair_cost AS DOUBLE))
      comment: "Total cost of repairs required immediately. Measures urgent capital exposure — used to prioritize emergency capital allocation and assess near-term cash flow impact."
    - name: "total_short_term_repair_cost"
      expr: SUM(CAST(short_term_repair_cost AS DOUBLE))
      comment: "Total cost of repairs required in the short term (typically within 1 year). Used in annual capital budgeting and reserve fund planning."
    - name: "total_long_term_repair_cost"
      expr: SUM(CAST(long_term_repair_cost AS DOUBLE))
      comment: "Total cost of repairs required in the long term (typically 1-5 years). Used in multi-year capital expenditure planning and asset lifecycle management."
    - name: "avg_remediation_cost_per_inspection"
      expr: ROUND(SUM(CAST(estimated_remediation_cost AS DOUBLE)) / NULLIF(COUNT(DISTINCT inspection_id), 0), 2)
      comment: "Average estimated remediation cost per inspection. Benchmarks inspection cost intensity — used to compare building condition across the portfolio and prioritize capital allocation."
    - name: "work_order_trigger_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN work_order_triggered = TRUE THEN inspection_id END) / NULLIF(COUNT(DISTINCT inspection_id), 0), 2)
      comment: "Percentage of inspections that triggered a work order. Measures inspection-to-action conversion rate — low rates may indicate deficiencies are not being actioned, creating compliance and liability risk."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_parcel`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Land and parcel-level KPIs covering assessed value, lot sizing, development capacity, and environmental risk. Used by acquisition teams, development officers, and tax/legal teams to evaluate land value, development potential, and environmental exposure."
  source: "`real_estate_ecm`.`property`.`parcel`"
  dimensions:
    - name: "parcel_status"
      expr: parcel_status
      comment: "Current status of the parcel (e.g., Active, Pending, Disposed) — used to filter the active land inventory."
    - name: "parcel_type"
      expr: parcel_type
      comment: "Type of parcel (e.g., Residential, Commercial, Industrial, Mixed-Use) — used to segment land metrics by use classification."
    - name: "flood_zone_designation"
      expr: flood_zone_designation
      comment: "FEMA flood zone designation — used for environmental risk assessment, insurance underwriting, and regulatory compliance."
    - name: "environmental_designation"
      expr: environmental_designation
      comment: "Environmental classification of the parcel (e.g., Brownfield, Greenfield, Superfund) — used for environmental due diligence and remediation cost planning."
    - name: "phase_i_esa_completed"
      expr: phase_i_esa_completed
      comment: "Flag indicating whether a Phase I Environmental Site Assessment has been completed — used to track environmental due diligence coverage."
    - name: "soil_classification"
      expr: soil_classification
      comment: "Soil classification of the parcel — used in development feasibility and foundation engineering assessments."
    - name: "subdivision_name"
      expr: subdivision_name
      comment: "Name of the subdivision the parcel belongs to — used for geographic clustering and development project grouping."
    - name: "assessed_value_year"
      expr: assessed_value_year
      comment: "Year of the most recent assessed value — used to identify stale assessments and flag parcels requiring revaluation."
    - name: "last_sale_year"
      expr: YEAR(last_sale_date)
      comment: "Year of the most recent arm's-length sale — used for market value benchmarking and acquisition timing analysis."
  measures:
    - name: "total_parcels"
      expr: COUNT(DISTINCT parcel_id)
      comment: "Total number of distinct parcels in the land inventory. Baseline land portfolio count used in acquisition pipeline and portfolio reporting."
    - name: "total_assessed_land_value"
      expr: SUM(CAST(assessed_land_value AS DOUBLE))
      comment: "Total assessed land value across all parcels. Measures the tax-assessed value of the land portfolio — used for property tax budgeting and portfolio valuation benchmarking."
    - name: "avg_assessed_land_value"
      expr: ROUND(AVG(CAST(assessed_land_value AS DOUBLE)), 2)
      comment: "Average assessed land value per parcel. Used to benchmark individual parcel values against portfolio averages and identify undervalued or overvalued parcels."
    - name: "total_lot_size_acres"
      expr: SUM(CAST(lot_size_acres AS DOUBLE))
      comment: "Total land area in acres across all parcels. Measures the total land bank — used in development capacity planning and portfolio land exposure reporting."
    - name: "total_last_sale_value"
      expr: SUM(CAST(last_sale_price AS DOUBLE))
      comment: "Total value of the most recent arm's-length sales across parcels. Provides a market-based valuation anchor for the land portfolio — used in acquisition underwriting and disposition pricing."
    - name: "avg_far_allowed"
      expr: ROUND(AVG(CAST(far_allowed AS DOUBLE)), 2)
      comment: "Average Floor Area Ratio allowed by zoning across parcels. Measures development density potential — used by development teams to assess buildable capacity and maximize land utilization."
    - name: "avg_max_building_height_ft"
      expr: ROUND(AVG(CAST(max_building_height_ft AS DOUBLE)), 2)
      comment: "Average maximum allowable building height in feet. Used in development feasibility analysis to assess vertical development potential and air rights value."
    - name: "phase_i_esa_completion_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN phase_i_esa_completed = TRUE THEN parcel_id END) / NULLIF(COUNT(DISTINCT parcel_id), 0), 2)
      comment: "Percentage of parcels with a completed Phase I Environmental Site Assessment. Measures environmental due diligence coverage — parcels without Phase I ESAs carry unquantified environmental liability risk."
    - name: "assessed_value_per_acre"
      expr: ROUND(SUM(CAST(assessed_land_value AS DOUBLE)) / NULLIF(SUM(CAST(lot_size_acres AS DOUBLE)), 0), 2)
      comment: "Average assessed land value per acre across the portfolio. Normalizes land value by size — used to compare land pricing across markets and identify value outliers."
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_ownership_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership structure, equity, and debt KPIs for real estate assets. Covers ownership concentration, equity contributions, debt allocation, preferred returns, and voting rights. Used by investment managers, legal teams, and CFOs to monitor ownership structures, capital stack composition, and governance rights."
  source: "`real_estate_ecm`.`property`.`property_ownership_interest`"
  filter: ownership_status = 'Active'
  dimensions:
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership interest (e.g., Active, Disposed, Transferred) — used to filter the active ownership registry."
    - name: "ownership_structure"
      expr: ownership_structure
      comment: "Legal ownership structure (e.g., Fee Simple, Joint Venture, TIC, DST) — used to segment ownership metrics by deal structure type."
    - name: "distribution_priority"
      expr: distribution_priority
      comment: "Distribution waterfall priority tier — used to analyze capital stack composition and investor return sequencing."
    - name: "is_controlling_interest"
      expr: is_controlling_interest
      comment: "Flag indicating whether this interest represents a controlling stake — used for governance and consolidation analysis."
    - name: "is_managing_member"
      expr: is_managing_member
      comment: "Flag indicating whether the interest holder is the managing member — used for operational control and fiduciary responsibility tracking."
    - name: "transfer_restriction_flag"
      expr: transfer_restriction_flag
      comment: "Flag indicating whether the interest has transfer restrictions — used for liquidity risk assessment and secondary market eligibility."
    - name: "snda_status"
      expr: snda_status
      comment: "Status of the Subordination, Non-Disturbance, and Attornment agreement — used for lender compliance and tenant protection monitoring."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the ownership interest was acquired — used for vintage analysis and hold period tracking."
    - name: "effective_date"
      expr: effective_date
      comment: "Date the ownership interest became effective — used as the primary time axis for ownership timeline analysis."
  measures:
    - name: "total_ownership_interests"
      expr: COUNT(DISTINCT property_ownership_interest_id)
      comment: "Total number of distinct ownership interests in the registry. Baseline count for ownership structure complexity analysis — used in legal entity and governance reporting."
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost across all ownership interests. Measures total capital deployed — used by CFOs and investment committees to track cost basis and return on investment."
    - name: "total_equity_contribution"
      expr: SUM(CAST(equity_contribution_amount AS DOUBLE))
      comment: "Total equity capital contributed across all ownership interests. Measures the equity component of the capital stack — used in leverage ratio analysis and investor reporting."
    - name: "total_allocated_debt"
      expr: SUM(CAST(allocated_debt_amount AS DOUBLE))
      comment: "Total debt allocated across ownership interests. Measures the debt component of the capital stack — used in leverage analysis, covenant monitoring, and refinancing planning."
    - name: "avg_ownership_percentage"
      expr: ROUND(AVG(CAST(ownership_percentage AS DOUBLE)), 2)
      comment: "Average ownership percentage per interest. Used to assess ownership concentration and identify majority vs. minority interest structures."
    - name: "avg_preferred_return_rate"
      expr: ROUND(AVG(CAST(preferred_return_rate AS DOUBLE)), 2)
      comment: "Average preferred return rate across ownership interests. Measures the cost of preferred equity — used by CFOs to model distribution obligations and assess capital structure efficiency."
    - name: "avg_voting_rights_percentage"
      expr: ROUND(AVG(CAST(voting_rights_percentage AS DOUBLE)), 2)
      comment: "Average voting rights percentage per ownership interest. Used to analyze governance concentration and identify interests with disproportionate control relative to economic ownership."
    - name: "controlling_interest_count"
      expr: COUNT(DISTINCT CASE WHEN is_controlling_interest = TRUE THEN property_ownership_interest_id END)
      comment: "Number of controlling ownership interests. Used for consolidation accounting analysis and governance structure reporting."
    - name: "transfer_restricted_interest_count"
      expr: COUNT(DISTINCT CASE WHEN transfer_restriction_flag = TRUE THEN property_ownership_interest_id END)
      comment: "Number of ownership interests with transfer restrictions. Measures illiquidity exposure in the ownership registry — used by investment managers to assess exit optionality."
    - name: "debt_to_equity_ratio"
      expr: ROUND(SUM(CAST(allocated_debt_amount AS DOUBLE)) / NULLIF(SUM(CAST(equity_contribution_amount AS DOUBLE)), 0), 2)
      comment: "Ratio of total allocated debt to total equity contributions. Core leverage metric — used by CFOs, lenders, and investors to assess financial risk and covenant compliance. A rising ratio signals increasing leverage risk."
$$;