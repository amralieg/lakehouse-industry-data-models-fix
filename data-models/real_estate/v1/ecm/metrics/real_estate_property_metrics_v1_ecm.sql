-- Metric views for domain: property | Business: Real Estate | Version: 1 | Generated on: 2026-05-02 01:37:58

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core asset-level KPIs for portfolio valuation, acquisition performance, and strategic asset management decisions"
  source: "`real_estate_ecm`.`property`.`asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset (active, disposed, under development)"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type classification (office, retail, industrial, multifamily)"
    - name: "geographic_hierarchy"
      expr: geographic_hierarchy_id
      comment: "Geographic market hierarchy for regional performance analysis"
    - name: "portfolio"
      expr: portfolio_id
      comment: "Portfolio grouping for fund-level performance tracking"
    - name: "legal_entity"
      expr: legal_entity_id
      comment: "Owning legal entity for consolidated reporting"
    - name: "leed_certification"
      expr: leed_certification
      comment: "LEED certification level for ESG reporting and sustainability analysis"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for vintage analysis and hold period tracking"
    - name: "acquisition_quarter"
      expr: CONCAT(CAST(YEAR(acquisition_date) AS STRING), '-Q', CAST(QUARTER(acquisition_date) AS STRING))
      comment: "Acquisition quarter for cohort performance analysis"
    - name: "is_encumbered"
      expr: is_encumbered
      comment: "Flag indicating whether asset has debt or other encumbrances"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total capital deployed in asset acquisitions - key metric for investment committee reporting"
    - name: "asset_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct assets in portfolio - baseline metric for portfolio scale"
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total gross leasable area across assets - key metric for portfolio size and market share"
    - name: "total_nla_sqft"
      expr: SUM(CAST(nla_sqft AS DOUBLE))
      comment: "Total net leasable area - operational metric for revenue-generating space"
    - name: "avg_acquisition_cost_per_asset"
      expr: AVG(CAST(acquisition_cost AS DOUBLE))
      comment: "Average acquisition cost per asset - benchmark for deal sizing and capital allocation"
    - name: "avg_gla_per_asset"
      expr: AVG(CAST(gla_sqft AS DOUBLE))
      comment: "Average gross leasable area per asset - portfolio composition metric"
    - name: "avg_far"
      expr: AVG(CAST(far AS DOUBLE))
      comment: "Average floor area ratio - development potential and zoning efficiency metric"
    - name: "avg_energy_star_score"
      expr: AVG(CAST(energy_star_score AS DOUBLE))
      comment: "Average Energy Star score across portfolio - ESG performance and operating efficiency metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_occupancy_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical occupancy and leasing performance KPIs for revenue forecasting, asset management, and investment decisions"
  source: "`real_estate_ecm`.`property`.`occupancy_record`"
  dimensions:
    - name: "snapshot_date"
      expr: snapshot_date
      comment: "Date of occupancy snapshot for time-series trend analysis"
    - name: "snapshot_year"
      expr: YEAR(snapshot_date)
      comment: "Year of snapshot for annual performance tracking"
    - name: "snapshot_quarter"
      expr: CONCAT(CAST(YEAR(snapshot_date) AS STRING), '-Q', CAST(QUARTER(snapshot_date) AS STRING))
      comment: "Quarter of snapshot for quarterly business reviews"
    - name: "snapshot_month"
      expr: DATE_TRUNC('MONTH', snapshot_date)
      comment: "Month of snapshot for monthly operational reporting"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier for property-level performance analysis"
    - name: "building_id"
      expr: building_id
      comment: "Building identifier for building-level occupancy tracking"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type for sector-level occupancy benchmarking"
    - name: "is_same_store"
      expr: is_same_store
      comment: "Same-store flag for like-for-like performance comparison"
    - name: "is_stabilized"
      expr: is_stabilized
      comment: "Stabilization flag for separating lease-up from stabilized assets"
    - name: "period_type"
      expr: period_type
      comment: "Period type (actual, budget, forecast) for variance analysis"
    - name: "measurement_level"
      expr: measurement_level
      comment: "Measurement level (asset, building, unit) for aggregation control"
  measures:
    - name: "avg_physical_occupancy_rate"
      expr: AVG(CAST(physical_occupancy_rate AS DOUBLE))
      comment: "Average physical occupancy rate - primary operational KPI for asset performance and NOI forecasting"
    - name: "avg_economic_occupancy_rate"
      expr: AVG(CAST(economic_occupancy_rate AS DOUBLE))
      comment: "Average economic occupancy rate - revenue-weighted occupancy for financial performance analysis"
    - name: "total_occupied_area_sqf"
      expr: SUM(CAST(occupied_area_sqf AS DOUBLE))
      comment: "Total occupied square footage - baseline metric for revenue-generating space"
    - name: "total_vacant_area_sqf"
      expr: SUM(CAST(vacant_area_sqf AS DOUBLE))
      comment: "Total vacant square footage - leasing pipeline and revenue opportunity metric"
    - name: "total_gla_sqf"
      expr: SUM(CAST(total_gla_sqf AS DOUBLE))
      comment: "Total gross leasable area - denominator for occupancy rate calculations"
    - name: "total_net_absorption_sqf"
      expr: SUM(CAST(net_absorption_sqf AS DOUBLE))
      comment: "Total net absorption - key leasing velocity metric for market demand and asset performance"
    - name: "total_gross_absorption_sqf"
      expr: SUM(CAST(gross_absorption_sqf AS DOUBLE))
      comment: "Total gross absorption - leasing activity metric including renewals and new leases"
    - name: "total_new_leases_sqf"
      expr: SUM(CAST(new_leases_sqf AS DOUBLE))
      comment: "Total new lease square footage - new tenant acquisition metric"
    - name: "total_renewal_leases_sqf"
      expr: SUM(CAST(renewal_leases_sqf AS DOUBLE))
      comment: "Total renewal lease square footage - tenant retention metric"
    - name: "total_lease_expirations_sqf"
      expr: SUM(CAST(lease_expirations_sqf AS DOUBLE))
      comment: "Total lease expirations - rollover risk and leasing pipeline metric"
    - name: "total_area_under_notice_sqf"
      expr: SUM(CAST(area_under_notice_sqf AS DOUBLE))
      comment: "Total area under notice to vacate - near-term vacancy risk metric"
    - name: "avg_in_place_rent_psf"
      expr: AVG(CAST(average_in_place_rent_psf AS DOUBLE))
      comment: "Average in-place rent per square foot - current revenue yield metric"
    - name: "avg_market_rent_psf"
      expr: AVG(CAST(market_rent_psf AS DOUBLE))
      comment: "Average market rent per square foot - mark-to-market opportunity metric"
    - name: "total_potential_gross_income"
      expr: SUM(CAST(potential_gross_income AS DOUBLE))
      comment: "Total potential gross income - maximum revenue at full occupancy and market rents"
    - name: "total_effective_gross_income"
      expr: SUM(CAST(effective_gross_income AS DOUBLE))
      comment: "Total effective gross income - actual revenue after vacancy and credit loss"
    - name: "total_vacancy_loss_amount"
      expr: SUM(CAST(vacancy_loss_amount AS DOUBLE))
      comment: "Total vacancy loss - revenue opportunity from vacant space"
    - name: "total_credit_loss_amount"
      expr: SUM(CAST(credit_loss_amount AS DOUBLE))
      comment: "Total credit loss - bad debt and collection risk metric"
    - name: "avg_walt_years"
      expr: AVG(CAST(walt_years AS DOUBLE))
      comment: "Average weighted average lease term - lease maturity and rollover risk metric"
    - name: "avg_wale_years"
      expr: AVG(CAST(wale_years AS DOUBLE))
      comment: "Average weighted average lease expiry - income stability and refinancing risk metric"
    - name: "property_count"
      expr: COUNT(DISTINCT asset_id)
      comment: "Number of distinct properties in reporting period - portfolio scale metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_building`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Building-level physical and operational KPIs for asset management, capital planning, and ESG reporting"
  source: "`real_estate_ecm`.`property`.`building`"
  dimensions:
    - name: "building_status"
      expr: building_status
      comment: "Current operational status of building (active, under renovation, decommissioned)"
    - name: "building_class"
      expr: building_class_id
      comment: "Building class (A, B, C) for quality segmentation and rent benchmarking"
    - name: "property_type"
      expr: property_type_id
      comment: "Property type for sector-level analysis"
    - name: "asset_id"
      expr: asset_id
      comment: "Parent asset identifier for rollup reporting"
    - name: "construction_type"
      expr: construction_type_id
      comment: "Construction type for insurance and risk assessment"
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for regulatory and tenant suitability analysis"
    - name: "is_esg_reported"
      expr: is_esg_reported
      comment: "ESG reporting flag for sustainability portfolio segmentation"
    - name: "hvac_system_type"
      expr: hvac_system_type
      comment: "HVAC system type for operating cost and capital planning analysis"
    - name: "fire_suppression_type"
      expr: fire_suppression_type
      comment: "Fire suppression type for insurance and safety compliance"
    - name: "year_built"
      expr: year_built
      comment: "Year built for vintage analysis and capital planning"
    - name: "year_renovated"
      expr: year_renovated
      comment: "Year of last major renovation for asset quality and capex forecasting"
  measures:
    - name: "building_count"
      expr: COUNT(DISTINCT building_id)
      comment: "Number of distinct buildings - portfolio scale and diversification metric"
    - name: "total_gla_sqft"
      expr: SUM(CAST(gla_sqft AS DOUBLE))
      comment: "Total gross leasable area - portfolio size and revenue capacity metric"
    - name: "total_nla_sqft"
      expr: SUM(CAST(nla_sqft AS DOUBLE))
      comment: "Total net leasable area - operational space metric"
    - name: "total_rentable_sqft"
      expr: SUM(CAST(total_rentable_sqft AS DOUBLE))
      comment: "Total rentable square footage - revenue-generating space for NOI calculation"
    - name: "avg_load_factor"
      expr: AVG(CAST(load_factor AS DOUBLE))
      comment: "Average load factor - efficiency metric for tenant cost and building design"
    - name: "avg_parking_ratio"
      expr: AVG(CAST(parking_ratio AS DOUBLE))
      comment: "Average parking ratio - tenant amenity and market competitiveness metric"
    - name: "total_parking_stalls"
      expr: SUM(CAST(parking_stalls_total AS DOUBLE))
      comment: "Total parking stalls - amenity capacity and revenue opportunity metric"
    - name: "avg_far"
      expr: AVG(CAST(far AS DOUBLE))
      comment: "Average floor area ratio - development intensity and zoning efficiency metric"
    - name: "avg_floors_above_grade"
      expr: AVG(CAST(floors_above_grade AS DOUBLE))
      comment: "Average floors above grade - building scale and elevator efficiency metric"
    - name: "total_elevator_count"
      expr: SUM(CAST(elevator_count AS DOUBLE))
      comment: "Total elevator count - tenant service level and capital planning metric"
    - name: "avg_gla_per_building"
      expr: AVG(CAST(gla_sqft AS DOUBLE))
      comment: "Average gross leasable area per building - portfolio composition and scale metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Space-level leasing and availability KPIs for leasing pipeline management, revenue forecasting, and tenant placement"
  source: "`real_estate_ecm`.`property`.`space`"
  dimensions:
    - name: "space_status"
      expr: space_status
      comment: "Current status of space (vacant, occupied, under lease negotiation)"
    - name: "space_type"
      expr: space_type
      comment: "Space type classification (office, retail, storage, etc.)"
    - name: "space_use_type"
      expr: space_use_type_id
      comment: "Permitted use type for zoning and tenant suitability"
    - name: "building_id"
      expr: building_id
      comment: "Parent building identifier for building-level leasing analysis"
    - name: "floor_id"
      expr: floor_id
      comment: "Floor identifier for floor-level availability and stacking plans"
    - name: "occupancy_class"
      expr: occupancy_class
      comment: "Occupancy class for building code and tenant mix analysis"
    - name: "is_contiguous"
      expr: is_contiguous
      comment: "Contiguous space flag for tenant suitability and leasing strategy"
    - name: "is_subdivisible"
      expr: is_subdivisible
      comment: "Subdivisible flag for flexible leasing and tenant mix optimization"
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA compliance flag for regulatory and tenant requirements"
    - name: "cam_eligible"
      expr: cam_eligible
      comment: "CAM eligibility flag for operating expense recovery analysis"
    - name: "energy_star_eligible"
      expr: energy_star_eligible
      comment: "Energy Star eligibility for ESG and operating cost analysis"
    - name: "leed_certification_level"
      expr: leed_certification_level
      comment: "LEED certification level for sustainability and tenant attraction"
    - name: "condition"
      expr: condition
      comment: "Physical condition rating for capital planning and tenant readiness"
  measures:
    - name: "space_count"
      expr: COUNT(DISTINCT space_id)
      comment: "Number of distinct spaces - leasing inventory and portfolio granularity metric"
    - name: "total_rentable_area_sqf"
      expr: SUM(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Total rentable area - revenue-generating space for leasing pipeline"
    - name: "total_usable_area_sqf"
      expr: SUM(CAST(usable_area_sqf AS DOUBLE))
      comment: "Total usable area - tenant-occupied space for efficiency analysis"
    - name: "total_cam_area_sqf"
      expr: SUM(CAST(cam_area_sqf AS DOUBLE))
      comment: "Total CAM-eligible area - operating expense recovery base"
    - name: "avg_load_factor"
      expr: AVG(CAST(load_factor AS DOUBLE))
      comment: "Average load factor - space efficiency and tenant cost metric"
    - name: "avg_asking_rent_psf"
      expr: AVG(CAST(asking_rent_psf AS DOUBLE))
      comment: "Average asking rent per square foot - market positioning and revenue potential metric"
    - name: "avg_effective_rent_psf"
      expr: AVG(CAST(effective_rent_psf AS DOUBLE))
      comment: "Average effective rent per square foot - net revenue after concessions"
    - name: "avg_ti_allowance_psf"
      expr: AVG(CAST(ti_allowance_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot - leasing cost and deal structure metric"
    - name: "avg_pro_rata_share"
      expr: AVG(CAST(pro_rata_share AS DOUBLE))
      comment: "Average pro-rata share - CAM allocation and operating expense recovery metric"
    - name: "avg_ceiling_height_ft"
      expr: AVG(CAST(ceiling_height_ft AS DOUBLE))
      comment: "Average ceiling height - space quality and tenant suitability metric"
    - name: "avg_electrical_capacity_amps"
      expr: AVG(CAST(electrical_capacity_amps AS DOUBLE))
      comment: "Average electrical capacity - tenant suitability for high-power uses"
    - name: "avg_rentable_area_per_space"
      expr: AVG(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Average rentable area per space - portfolio composition and tenant mix metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit-level residential and multifamily KPIs for lease-up, rent optimization, and portfolio performance"
  source: "`real_estate_ecm`.`property`.`unit`"
  dimensions:
    - name: "unit_status"
      expr: unit_status
      comment: "Current status of unit (vacant, occupied, under renovation, notice)"
    - name: "unit_type"
      expr: unit_type
      comment: "Unit type classification (studio, 1BR, 2BR, penthouse, etc.)"
    - name: "space_use_type"
      expr: space_use_type_id
      comment: "Permitted use type for zoning and tenant suitability"
    - name: "building_id"
      expr: building_id
      comment: "Parent building identifier for building-level unit mix analysis"
    - name: "asset_id"
      expr: asset_id
      comment: "Parent asset identifier for property-level performance"
    - name: "bedroom_count"
      expr: bedroom_count
      comment: "Number of bedrooms for unit mix and rent analysis"
    - name: "configuration"
      expr: configuration
      comment: "Unit configuration for layout and tenant preference analysis"
    - name: "floor_number"
      expr: floor_number
      comment: "Floor number for rent premium and tenant preference analysis"
    - name: "view_type"
      expr: view_type
      comment: "View type (city, water, park) for rent premium analysis"
    - name: "has_balcony"
      expr: has_balcony
      comment: "Balcony flag for amenity and rent premium analysis"
    - name: "is_furnished"
      expr: is_furnished
      comment: "Furnished flag for short-term rental and corporate housing analysis"
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for regulatory and tenant requirements"
    - name: "cam_eligible"
      expr: cam_eligible
      comment: "CAM eligibility flag for operating expense recovery"
    - name: "leed_certification"
      expr: leed_certification
      comment: "LEED certification for sustainability and tenant attraction"
    - name: "energy_rating"
      expr: energy_rating
      comment: "Energy rating for operating cost and ESG analysis"
  measures:
    - name: "unit_count"
      expr: COUNT(DISTINCT unit_id)
      comment: "Number of distinct units - portfolio scale and unit mix metric"
    - name: "total_rentable_area_sqf"
      expr: SUM(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Total rentable area - revenue-generating space for NOI calculation"
    - name: "total_usable_area_sqf"
      expr: SUM(CAST(usable_area_sqf AS DOUBLE))
      comment: "Total usable area - tenant-occupied space for efficiency analysis"
    - name: "avg_rentable_area_per_unit"
      expr: AVG(CAST(rentable_area_sqf AS DOUBLE))
      comment: "Average rentable area per unit - unit size and portfolio composition metric"
    - name: "avg_asking_rent_psf"
      expr: AVG(CAST(asking_rent_psf AS DOUBLE))
      comment: "Average asking rent per square foot - market positioning and revenue potential"
    - name: "avg_market_rent_psf"
      expr: AVG(CAST(market_rent_psf AS DOUBLE))
      comment: "Average market rent per square foot - mark-to-market opportunity metric"
    - name: "avg_ti_allowance_psf"
      expr: AVG(CAST(ti_allowance_psf AS DOUBLE))
      comment: "Average tenant improvement allowance per square foot - leasing cost metric"
    - name: "avg_pro_rata_share"
      expr: AVG(CAST(pro_rata_share AS DOUBLE))
      comment: "Average pro-rata share - CAM allocation and operating expense recovery"
    - name: "avg_efficiency_ratio"
      expr: AVG(CAST(efficiency_ratio AS DOUBLE))
      comment: "Average efficiency ratio - usable vs rentable area efficiency metric"
    - name: "avg_bathroom_count"
      expr: AVG(CAST(bathroom_count AS DOUBLE))
      comment: "Average bathroom count - unit quality and tenant preference metric"
    - name: "total_parking_spaces"
      expr: SUM(CAST(parking_spaces AS DOUBLE))
      comment: "Total parking spaces allocated to units - amenity and revenue metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inspection and compliance KPIs for risk management, regulatory compliance, and capital planning decisions"
  source: "`real_estate_ecm`.`property`.`inspection`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (life safety, environmental, structural, regulatory)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of inspection (scheduled, completed, overdue, cancelled)"
    - name: "pass_fail_result"
      expr: pass_fail_result
      comment: "Pass/fail result for compliance and risk tracking"
    - name: "inspection_scope"
      expr: inspection_scope
      comment: "Scope of inspection for resource planning and cost analysis"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier for property-level compliance tracking"
    - name: "building_id"
      expr: building_id
      comment: "Building identifier for building-level inspection history"
    - name: "is_regulatory_required"
      expr: is_regulatory_required
      comment: "Regulatory requirement flag for compliance prioritization"
    - name: "has_critical_deficiency"
      expr: has_critical_deficiency
      comment: "Critical deficiency flag for immediate action and risk escalation"
    - name: "reinspection_required"
      expr: reinspection_required
      comment: "Reinspection required flag for follow-up tracking"
    - name: "work_order_triggered"
      expr: work_order_triggered
      comment: "Work order triggered flag for remediation tracking"
    - name: "leed_relevant"
      expr: leed_relevant
      comment: "LEED relevance flag for sustainability compliance"
    - name: "environmental_phase"
      expr: environmental_phase
      comment: "Environmental assessment phase (Phase I, Phase II) for environmental risk"
    - name: "condition_rating"
      expr: condition_rating
      comment: "Overall condition rating for capital planning and asset quality"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year of inspection for annual compliance tracking"
    - name: "inspection_quarter"
      expr: CONCAT(CAST(YEAR(inspection_date) AS STRING), '-Q', CAST(QUARTER(inspection_date) AS STRING))
      comment: "Quarter of inspection for quarterly compliance reporting"
  measures:
    - name: "inspection_count"
      expr: COUNT(DISTINCT inspection_id)
      comment: "Number of inspections - compliance activity and resource utilization metric"
    - name: "total_deficiency_count"
      expr: SUM(CAST(deficiency_count AS DOUBLE))
      comment: "Total deficiency count - compliance risk and remediation workload metric"
    - name: "total_critical_deficiency_count"
      expr: SUM(CAST(critical_deficiency_count AS DOUBLE))
      comment: "Total critical deficiency count - immediate risk and escalation metric"
    - name: "total_estimated_remediation_cost"
      expr: SUM(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Total estimated remediation cost - capital planning and risk quantification metric"
    - name: "total_immediate_repair_cost"
      expr: SUM(CAST(immediate_repair_cost AS DOUBLE))
      comment: "Total immediate repair cost - urgent capital needs and cash flow impact"
    - name: "total_short_term_repair_cost"
      expr: SUM(CAST(short_term_repair_cost AS DOUBLE))
      comment: "Total short-term repair cost - 1-year capital planning metric"
    - name: "total_long_term_repair_cost"
      expr: SUM(CAST(long_term_repair_cost AS DOUBLE))
      comment: "Total long-term repair cost - multi-year capital planning and reserves metric"
    - name: "avg_deficiency_count_per_inspection"
      expr: AVG(CAST(deficiency_count AS DOUBLE))
      comment: "Average deficiency count per inspection - asset quality and maintenance effectiveness metric"
    - name: "avg_estimated_remediation_cost"
      expr: AVG(CAST(estimated_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per inspection - capital intensity and asset condition metric"
$$;

CREATE OR REPLACE VIEW `real_estate_ecm`.`_metrics`.`property_ownership_interest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership structure and investment KPIs for partnership accounting, capital calls, and distribution waterfall analysis"
  source: "`real_estate_ecm`.`property`.`property_ownership_interest`"
  dimensions:
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of ownership interest (active, disposed, transferred)"
    - name: "ownership_structure"
      expr: ownership_structure
      comment: "Ownership structure type (JV, LP, GP, sole ownership) for governance and reporting"
    - name: "asset_id"
      expr: asset_id
      comment: "Asset identifier for property-level ownership analysis"
    - name: "owner_id"
      expr: owner_id
      comment: "Owner identifier for investor-level performance tracking"
    - name: "legal_entity_id"
      expr: legal_entity_id
      comment: "Legal entity identifier for consolidated financial reporting"
    - name: "tenure_type"
      expr: tenure_type_id
      comment: "Tenure type (freehold, leasehold) for valuation and financing analysis"
    - name: "is_controlling_interest"
      expr: is_controlling_interest
      comment: "Controlling interest flag for consolidation and governance decisions"
    - name: "is_managing_member"
      expr: is_managing_member
      comment: "Managing member flag for operational control and fee analysis"
    - name: "distribution_priority"
      expr: distribution_priority
      comment: "Distribution priority for waterfall and cash flow allocation"
    - name: "snda_status"
      expr: snda_status
      comment: "SNDA status for lender protection and financing risk"
    - name: "transfer_restriction_flag"
      expr: transfer_restriction_flag
      comment: "Transfer restriction flag for liquidity and exit planning"
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year of acquisition for vintage and hold period analysis"
  measures:
    - name: "ownership_interest_count"
      expr: COUNT(DISTINCT property_ownership_interest_id)
      comment: "Number of distinct ownership interests - partnership complexity and governance metric"
    - name: "total_acquisition_cost"
      expr: SUM(CAST(acquisition_cost AS DOUBLE))
      comment: "Total acquisition cost across ownership interests - capital deployed metric"
    - name: "total_equity_contribution"
      expr: SUM(CAST(equity_contribution_amount AS DOUBLE))
      comment: "Total equity contribution - investor capital at risk metric"
    - name: "total_allocated_debt"
      expr: SUM(CAST(allocated_debt_amount AS DOUBLE))
      comment: "Total allocated debt - leverage and financing structure metric"
    - name: "avg_ownership_percentage"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Average ownership percentage - partnership concentration and control metric"
    - name: "avg_voting_rights_percentage"
      expr: AVG(CAST(voting_rights_percentage AS DOUBLE))
      comment: "Average voting rights percentage - governance and control metric"
    - name: "avg_preferred_return_rate"
      expr: AVG(CAST(preferred_return_rate AS DOUBLE))
      comment: "Average preferred return rate - investor return hurdle and distribution waterfall metric"
    - name: "weighted_avg_ownership_pct"
      expr: AVG(CAST(ownership_percentage AS DOUBLE))
      comment: "Weighted average ownership percentage - portfolio-level ownership concentration"
$$;