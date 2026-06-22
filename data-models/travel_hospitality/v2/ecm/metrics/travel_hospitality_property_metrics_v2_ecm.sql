-- Metric views for domain: property | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 18:44:46

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property portfolio metrics covering operational status, brand distribution, room inventory, and geographic footprint — used by asset management, brand leadership, and development teams to steer portfolio strategy."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code for grouping properties by brand family (e.g. Marriott, Hilton sub-brands)."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (luxury, upper-upscale, upscale, midscale) for portfolio segmentation."
    - name: "property_type"
      expr: property_type
      comment: "Property type (full-service hotel, select-service, resort, extended-stay) for operational benchmarking."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (open, closed, under-renovation, pre-opening) for active portfolio filtering."
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic portfolio analysis and regional rollups."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification for competitive positioning and revenue strategy."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Flag indicating whether the property operates under a franchise agreement vs. managed/owned."
    - name: "pip_status"
      expr: pip_status
      comment: "Current Property Improvement Plan status — critical for brand compliance and capital planning."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the property opened, used for cohort analysis of portfolio vintage."
    - name: "parent_brand_group"
      expr: parent_brand_group
      comment: "Parent brand group (e.g. Marriott International, IHG) for enterprise-level portfolio rollups."
  measures:
    - name: "total_properties"
      expr: COUNT(1)
      comment: "Total number of properties in the portfolio. Baseline KPI for portfolio size tracking."
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory across all properties. Core capacity metric for revenue potential and market share analysis."
    - name: "avg_rooms_per_property"
      expr: AVG(CAST(total_room_count AS DOUBLE))
      comment: "Average room count per property. Indicates portfolio scale and mix of large vs. boutique properties."
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS BIGINT))
      comment: "Total suite inventory across the portfolio. Premium room tier capacity for luxury revenue strategy."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across the portfolio. Tracks quality positioning and brand standard compliance."
    - name: "franchised_property_count"
      expr: COUNT(CASE WHEN is_franchised = TRUE THEN 1 END)
      comment: "Number of franchised properties. Key metric for franchise revenue (royalty/fee) forecasting."
    - name: "managed_property_count"
      expr: COUNT(CASE WHEN is_franchised = FALSE THEN 1 END)
      comment: "Number of managed/owned properties. Distinguishes direct operational exposure from franchise model."
    - name: "properties_with_active_pip"
      expr: COUNT(CASE WHEN pip_status NOT IN ('completed', 'not_required', 'waived') AND pip_status IS NOT NULL THEN 1 END)
      comment: "Properties currently under an active Property Improvement Plan. Tracks brand compliance risk and capital deployment."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting and event space square footage across the portfolio. Drives group/MICE revenue capacity planning."
    - name: "open_property_count"
      expr: COUNT(CASE WHEN operational_status = 'open' THEN 1 END)
      comment: "Count of currently open and operating properties. Used for active portfolio revenue base calculations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement financial and compliance metrics — used by franchise development, legal, and finance teams to monitor fee structures, agreement health, and brand standard compliance across the franchised portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, terminated, expired, pending-renewal)."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (standard, conversion, new-construction) for portfolio mix analysis."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code associated with the franchise agreement for brand-level fee and compliance reporting."
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment (luxury, upscale, midscale) for fee structure benchmarking."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country governing the agreement — used for regulatory and legal jurisdiction analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Whether a PIP is required under this agreement — flags capital obligation at signing."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective — used for vintage cohort analysis of franchise portfolio."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires — critical for renewal pipeline and revenue-at-risk tracking."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(CASE WHEN agreement_status = 'active' THEN 1 END)
      comment: "Total number of active franchise agreements. Baseline for franchise portfolio size and fee revenue base."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across agreements. Benchmarks fee competitiveness and revenue yield from franchisees."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing/brand fund fee percentage. Tracks brand investment contribution across the franchise system."
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage. Measures loyalty cost burden on franchisees and system revenue."
    - name: "total_pip_budget"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total PIP capital commitment across all franchise agreements. Critical for brand standard investment tracking."
    - name: "avg_pip_budget_per_agreement"
      expr: AVG(CAST(pip_budget_amount AS DOUBLE))
      comment: "Average PIP budget per franchise agreement. Benchmarks renovation investment requirements by brand/segment."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across agreements. Quantifies financial risk from potential early terminations."
    - name: "agreements_expiring_within_2_years"
      expr: COUNT(CASE WHEN expiration_date <= ADD_MONTHS(CURRENT_DATE(), 24) AND agreement_status = 'active' THEN 1 END)
      comment: "Active agreements expiring within 24 months. Drives renewal pipeline prioritization and retention strategy."
    - name: "avg_initial_term_years"
      expr: AVG(CAST(initial_term_years AS DOUBLE))
      comment: "Average initial term length in years. Indicates franchise commitment depth and long-term revenue visibility."
    - name: "avg_quality_assurance_score_min"
      expr: AVG(CAST(quality_assurance_score_min AS DOUBLE))
      comment: "Average minimum QA score threshold required by franchise agreements. Tracks brand standard floor across the system."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_pip_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Improvement Plan execution and financial metrics — used by asset management, development, and brand compliance teams to track capital deployment, project progress, and brand standard remediation."
  source: "`vibe_travel_hospitality_v1`.`property`.`pip_plan`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current PIP project status (in-progress, completed, on-hold, cancelled) for portfolio-wide execution tracking."
    - name: "project_type"
      expr: project_type
      comment: "Type of PIP project (renovation, conversion, new-build, brand-compliance) for capital categorization."
    - name: "brand_compliance_status"
      expr: brand_compliance_status
      comment: "Brand compliance status of the PIP — tracks whether properties are meeting brand standard deadlines."
    - name: "triggering_event"
      expr: triggering_event
      comment: "Event that triggered the PIP (acquisition, brand-audit-failure, ownership-change) for root-cause analysis."
    - name: "ada_compliance_included"
      expr: ada_compliance_included
      comment: "Whether ADA compliance work is included — tracks regulatory obligation fulfillment."
    - name: "fire_safety_upgrade_included"
      expr: fire_safety_upgrade_included
      comment: "Whether fire safety upgrades are included — tracks life-safety capital investment."
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the PIP is scheduled to start — used for capital expenditure planning and cash flow forecasting."
    - name: "projected_completion_year"
      expr: YEAR(projected_completion_date)
      comment: "Year the PIP is projected to complete — used for brand compliance deadline tracking."
  measures:
    - name: "total_pip_plans"
      expr: COUNT(1)
      comment: "Total number of PIP plans across the portfolio. Baseline for capital program scope."
    - name: "total_approved_budget"
      expr: SUM(CAST(approved_budget AS DOUBLE))
      comment: "Total approved capital budget across all PIP plans. Core CapEx commitment metric for finance and asset management."
    - name: "total_estimated_capex"
      expr: SUM(CAST(total_estimated_capex AS DOUBLE))
      comment: "Total estimated CapEx across all PIPs. Tracks full capital requirement vs. approved budget for variance analysis."
    - name: "total_ffe_budget"
      expr: SUM(CAST(ffe_budget AS DOUBLE))
      comment: "Total FF&E (Furniture, Fixtures & Equipment) budget. Key component of renovation cost tracking."
    - name: "total_ffe_actual_spend"
      expr: SUM(CAST(ffe_actual_spend AS DOUBLE))
      comment: "Total actual FF&E spend to date. Tracks execution against FF&E budget for cost control."
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average PIP completion percentage across active projects. Tracks portfolio-wide renovation progress."
    - name: "total_revenue_displacement_estimate"
      expr: SUM(CAST(revenue_displacement_estimate AS DOUBLE))
      comment: "Total estimated revenue displaced by PIP construction activity. Quantifies short-term revenue sacrifice for long-term asset value."
    - name: "avg_expected_roi_pct"
      expr: AVG(CAST(expected_roi_percentage AS DOUBLE))
      comment: "Average expected ROI percentage across PIP investments. Validates capital allocation decisions."
    - name: "budget_variance"
      expr: SUM(CAST(total_estimated_capex AS DOUBLE) - CAST(approved_budget AS DOUBLE))
      comment: "Total variance between estimated CapEx and approved budget. Identifies projects at risk of cost overrun."
    - name: "total_opex_impact_estimate"
      expr: SUM(CAST(opex_impact_estimate AS DOUBLE))
      comment: "Total estimated ongoing OpEx impact from PIP completions. Tracks post-renovation cost structure changes."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_pip_item`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "PIP line-item execution metrics — used by project managers, procurement, and asset management to track individual work items, cost performance, and brand compliance at the granular task level."
  source: "`vibe_travel_hospitality_v1`.`property`.`pip_item`"
  dimensions:
    - name: "item_status"
      expr: item_status
      comment: "Current status of the PIP line item (pending, in-progress, completed, deferred) for execution tracking."
    - name: "work_type"
      expr: work_type
      comment: "Type of work (construction, FF&E, technology, life-safety) for cost categorization."
    - name: "ffe_category"
      expr: ffe_category
      comment: "FF&E category (guestroom, lobby, F&B, exterior) for capital spend analysis."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the PIP item (critical, high, medium, low) for resource allocation decisions."
    - name: "property_area"
      expr: property_area
      comment: "Property area affected (guestroom, lobby, pool, restaurant) for scope and impact analysis."
    - name: "brand_requirement_flag"
      expr: brand_requirement_flag
      comment: "Whether this item is a mandatory brand requirement — distinguishes compliance-driven vs. discretionary spend."
    - name: "life_safety_flag"
      expr: life_safety_flag
      comment: "Whether this item is a life-safety requirement — highest priority for regulatory and liability management."
    - name: "sustainability_flag"
      expr: sustainability_flag
      comment: "Whether this item contributes to sustainability goals — tracks ESG capital investment."
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Outcome of the item inspection (pass, fail, conditional) for quality assurance tracking."
  measures:
    - name: "total_pip_items"
      expr: COUNT(1)
      comment: "Total number of PIP line items. Baseline for project scope and workload tracking."
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Total estimated cost across all PIP items. Drives budget planning and procurement sourcing."
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Total actual cost incurred across completed PIP items. Core CapEx spend tracking metric."
    - name: "cost_variance"
      expr: SUM(CAST(actual_cost AS DOUBLE) - CAST(estimated_cost AS DOUBLE))
      comment: "Total cost variance (actual minus estimated) across PIP items. Identifies systematic cost overrun patterns."
    - name: "avg_cost_per_item"
      expr: AVG(CAST(estimated_cost AS DOUBLE))
      comment: "Average estimated cost per PIP item. Benchmarks unit cost for similar work types across properties."
    - name: "life_safety_item_count"
      expr: COUNT(CASE WHEN life_safety_flag = TRUE THEN 1 END)
      comment: "Count of life-safety PIP items. Tracks regulatory compliance obligation fulfillment."
    - name: "brand_required_item_count"
      expr: COUNT(CASE WHEN brand_requirement_flag = TRUE THEN 1 END)
      comment: "Count of mandatory brand-requirement items. Tracks brand standard compliance exposure."
    - name: "deferred_item_count"
      expr: COUNT(CASE WHEN item_status = 'deferred' THEN 1 END)
      comment: "Count of deferred PIP items. Tracks brand compliance risk from delayed remediation."
    - name: "total_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of units across PIP items (rooms, fixtures, units). Supports procurement volume planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property certification and compliance metrics — used by compliance, operations, and brand teams to monitor certification health, audit scores, deficiency rates, and renewal timelines across the portfolio."
  source: "`vibe_travel_hospitality_v1`.`property`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (food-safety, fire-safety, brand-audit, sustainability, ADA) for compliance category analysis."
    - name: "certification_status"
      expr: certification_status
      comment: "Current certification status (active, expired, suspended, pending-renewal) for compliance risk monitoring."
    - name: "certification_level"
      expr: certification_level
      comment: "Certification level achieved (gold, silver, bronze, pass, fail) for quality benchmarking."
    - name: "issuing_authority"
      expr: issuing_authority
      comment: "Authority that issued the certification for regulatory jurisdiction analysis."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Accreditation body (e.g. NSF, ISO, brand QA team) for standards compliance tracking."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification — identifies certifications at risk of lapsing."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for the certification — used for geographic compliance reporting."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires — used for renewal pipeline planning."
  measures:
    - name: "total_certifications"
      expr: COUNT(1)
      comment: "Total number of certifications across the portfolio. Baseline for compliance program scope."
    - name: "active_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'active' THEN 1 END)
      comment: "Count of currently active certifications. Tracks compliance coverage across the portfolio."
    - name: "expired_certification_count"
      expr: COUNT(CASE WHEN certification_status = 'expired' THEN 1 END)
      comment: "Count of expired certifications. Identifies immediate compliance gaps requiring remediation."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all certifications. Portfolio-wide quality and standards adherence KPI."
    - name: "total_permit_fee_spend"
      expr: SUM(CAST(permit_fee_amount AS DOUBLE))
      comment: "Total permit and certification fee expenditure. Tracks regulatory compliance cost across the portfolio."
    - name: "certifications_expiring_90_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_status = 'active' THEN 1 END)
      comment: "Active certifications expiring within 90 days. Drives proactive renewal management to avoid compliance gaps."
    - name: "avg_critical_deficiency_count"
      expr: AVG(CAST(critical_deficiency_count AS DOUBLE))
      comment: "Average number of critical deficiencies per certification audit. Tracks systemic quality issues requiring urgent remediation."
    - name: "avg_minor_deficiency_count"
      expr: AVG(CAST(minor_deficiency_count AS DOUBLE))
      comment: "Average number of minor deficiencies per audit. Monitors ongoing quality improvement trends."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting and event space capacity and configuration metrics — used by sales, revenue management, and operations teams to optimize group/MICE revenue, space utilization, and event capability positioning."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (ballroom, boardroom, breakout, pre-function) for capacity planning and sales targeting."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space (active, under-renovation, closed) for availability tracking."
    - name: "rental_rate_tier"
      expr: rental_rate_tier
      comment: "Rental rate tier for the space — used for revenue yield analysis and pricing strategy."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into smaller sections — impacts flexible capacity and multi-event revenue."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA/accessibility compliance flag — required for regulatory reporting and inclusive event marketing."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Whether WiFi is available — key amenity for corporate and technology-driven events."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether natural light is available — premium feature that commands higher rental rates."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the meeting space — used for venue positioning and accessibility planning."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(1)
      comment: "Total number of meeting spaces across the property. Baseline for MICE capacity inventory."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total meeting space square footage. Core capacity metric for group revenue potential and competitive positioning."
    - name: "avg_square_footage_per_space"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average square footage per meeting space. Benchmarks space scale for event type suitability."
    - name: "total_banquet_capacity"
      expr: SUM(CAST(capacity_banquet AS BIGINT))
      comment: "Total banquet-style seating capacity across all meeting spaces. Drives catering revenue potential and event sizing."
    - name: "total_theater_capacity"
      expr: SUM(CAST(capacity_theater AS BIGINT))
      comment: "Total theater-style seating capacity. Key metric for conference and general session event sales."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hour requirement. Impacts booking flexibility and short-notice event revenue."
    - name: "avg_minimum_catering_spend"
      expr: AVG(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Average minimum catering spend requirement. Tracks F&B revenue floor attached to meeting space bookings."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height in feet. Determines suitability for production events, trade shows, and high-impact setups."
    - name: "divisible_space_count"
      expr: COUNT(CASE WHEN divisible = TRUE THEN 1 END)
      comment: "Count of divisible meeting spaces. Tracks flexible inventory for simultaneous multi-event revenue optimization."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting space allocation and utilization metrics — used by event sales, revenue management, and operations to track space booking density, rental revenue, and setup configuration patterns."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_space_allocation`"
  dimensions:
    - name: "allocation_status"
      expr: allocation_status
      comment: "Status of the space allocation (confirmed, tentative, cancelled, completed) for pipeline and utilization analysis."
    - name: "setup_style"
      expr: setup_style
      comment: "Setup configuration (banquet, theater, classroom, reception) for operational planning and revenue mix analysis."
    - name: "allocation_date"
      expr: allocation_date
      comment: "Date of the space allocation — used for time-series utilization and demand pattern analysis."
    - name: "allocation_month"
      expr: DATE_TRUNC('month', allocation_date)
      comment: "Month of allocation for seasonal demand and revenue trend analysis."
  measures:
    - name: "total_allocations"
      expr: COUNT(1)
      comment: "Total number of space allocations. Baseline for meeting space booking volume and utilization tracking."
    - name: "total_rental_revenue"
      expr: SUM(CAST(rental_charge AS DOUBLE))
      comment: "Total rental charge revenue from meeting space allocations. Core group/MICE revenue KPI."
    - name: "avg_rental_charge_per_allocation"
      expr: AVG(CAST(rental_charge AS DOUBLE))
      comment: "Average rental charge per space allocation. Tracks yield per booking and pricing effectiveness."
    - name: "confirmed_allocation_count"
      expr: COUNT(CASE WHEN allocation_status = 'confirmed' THEN 1 END)
      comment: "Count of confirmed space allocations. Tracks definite group business on the books."
    - name: "total_guaranteed_attendance"
      expr: SUM(CAST(guaranteed_attendance AS BIGINT))
      comment: "Total guaranteed attendance across all allocations. Drives catering, staffing, and F&B revenue forecasting."
    - name: "avg_guaranteed_attendance"
      expr: AVG(CAST(guaranteed_attendance AS DOUBLE))
      comment: "Average guaranteed attendance per allocation. Benchmarks event size for space and service planning."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property facility inventory and operational metrics — used by operations, asset management, and brand teams to track facility availability, compliance, and fee-generating amenity performance."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (pool, fitness center, spa, parking, business center) for amenity portfolio analysis."
    - name: "facility_category"
      expr: facility_category
      comment: "Facility category for grouping related amenities in operational and revenue reporting."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility (open, closed, under-renovation) for availability tracking."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Whether the facility charges a usage fee — distinguishes revenue-generating amenities from complimentary ones."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for regulatory reporting and inclusive guest experience tracking."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Whether the facility operates seasonally — impacts availability planning and guest satisfaction."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Whether the facility is outdoor or indoor — used for weather-dependent operational planning."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status — tracks capital investment progress and temporary capacity reduction."
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of property facilities. Baseline for amenity portfolio inventory."
    - name: "active_facility_count"
      expr: COUNT(CASE WHEN property_facility_status = 'open' THEN 1 END)
      comment: "Count of currently open and operational facilities. Tracks guest-accessible amenity availability."
    - name: "fee_based_facility_count"
      expr: COUNT(CASE WHEN is_fee_based = TRUE THEN 1 END)
      comment: "Count of fee-generating facilities. Identifies ancillary revenue sources beyond room revenue."
    - name: "total_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total square footage of all property facilities. Tracks physical asset footprint for valuation and maintenance planning."
    - name: "avg_max_occupancy_pct"
      expr: AVG(CAST(max_occupancy_pct AS DOUBLE))
      comment: "Average maximum occupancy percentage across facilities. Tracks capacity utilization ceiling for operational planning."
    - name: "total_usage_fee_revenue_potential"
      expr: SUM(CASE WHEN is_fee_based = TRUE THEN usage_fee_amount ELSE 0 END)
      comment: "Total potential usage fee revenue from fee-based facilities. Quantifies ancillary revenue opportunity."
    - name: "facilities_under_renovation"
      expr: COUNT(CASE WHEN renovation_status IN ('in-progress', 'planned') THEN 1 END)
      comment: "Count of facilities currently or soon to be under renovation. Tracks temporary amenity reduction impact on guest satisfaction."
    - name: "ada_compliant_facility_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_ada_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are ADA compliant. Tracks regulatory compliance and inclusive accessibility across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property outlet (restaurant, bar, retail) operational and revenue metrics — used by F&B leadership, operations, and revenue management to track outlet performance, capacity, and service capability."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (restaurant, bar, cafe, retail, room-service) for F&B portfolio mix analysis."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (open, closed, seasonal, under-renovation)."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for restaurant outlets — used for F&B concept portfolio and competitive positioning."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Whether the outlet operates seasonally — impacts annual revenue capacity planning."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Whether purchases at this outlet earn loyalty points — tracks loyalty program integration and member engagement."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Whether mobile ordering is enabled — tracks digital capability adoption and contactless service readiness."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Whether the outlet serves alcohol — impacts licensing compliance and beverage revenue potential."
  measures:
    - name: "total_outlets"
      expr: COUNT(1)
      comment: "Total number of property outlets. Baseline for F&B and retail portfolio inventory."
    - name: "active_outlet_count"
      expr: COUNT(CASE WHEN outlet_status = 'open' THEN 1 END)
      comment: "Count of currently open outlets. Tracks operational F&B and retail revenue capacity."
    - name: "total_seating_capacity"
      expr: SUM(CAST(seating_capacity AS BIGINT))
      comment: "Total seating capacity across all outlets. Core F&B revenue capacity metric for covers and throughput planning."
    - name: "avg_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount across outlets. Tracks F&B revenue yield per cover and pricing effectiveness."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across outlets. Tracks ancillary revenue attached to F&B covers."
    - name: "loyalty_eligible_outlet_count"
      expr: COUNT(CASE WHEN loyalty_points_eligible_flag = TRUE THEN 1 END)
      comment: "Count of outlets integrated with the loyalty program. Tracks loyalty touchpoint coverage for member engagement."
    - name: "mobile_ordering_outlet_count"
      expr: COUNT(CASE WHEN mobile_ordering_enabled_flag = TRUE THEN 1 END)
      comment: "Count of outlets with mobile ordering enabled. Tracks digital transformation progress in F&B operations."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal demand and performance forecast metrics — used by revenue management, sales, and operations to plan pricing strategy, staffing, and inventory controls across demand seasons."
  source: "`vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "season_code"
      expr: season_code
      comment: "Season code (peak, shoulder, off-peak) for demand-based pricing and inventory strategy."
    - name: "season_name"
      expr: season_name
      comment: "Descriptive season name for business reporting and stakeholder communication."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification (high, medium, low, blackout) for revenue strategy and restriction setting."
    - name: "seasonal_calendar_status"
      expr: seasonal_calendar_status
      comment: "Status of the seasonal calendar entry (active, draft, archived) for planning cycle management."
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Whether the period includes a major holiday — drives premium pricing and advance booking strategy."
    - name: "market_segment_focus"
      expr: market_segment_focus
      comment: "Primary market segment targeted during this season (leisure, corporate, group) for sales strategy alignment."
    - name: "season_year"
      expr: season_year
      comment: "Calendar year of the season for year-over-year demand trend comparison."
    - name: "rate_season_code"
      expr: rate_season_code
      comment: "Rate season code linked to revenue management system for pricing strategy alignment."
  measures:
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across seasonal periods. Core demand forecast KPI for revenue strategy."
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated ADR (Average Daily Rate) across seasonal periods. Drives pricing strategy and rate plan configuration."
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated RevPAR across seasonal periods. Primary revenue performance forecast metric for ownership and management."
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average no-show rate percentage by season. Informs overbooking policy calibration and deposit requirement strategy."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average cancellation rate percentage by season. Drives cancellation policy tightening and revenue protection strategy."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target by season. Tracks competitive market share goal vs. STR comp set."
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage. Tracks demand trend momentum for forward pricing decisions."
    - name: "blackout_period_count"
      expr: COUNT(CASE WHEN demand_classification = 'blackout' THEN 1 END)
      comment: "Count of blackout periods in the calendar. Tracks high-demand dates where standard discounts and restrictions apply."
    - name: "seasonal_hiring_required_count"
      expr: COUNT(CASE WHEN seasonal_hiring_required = TRUE THEN 1 END)
      comment: "Count of seasonal periods requiring additional staffing. Drives workforce planning and labor cost forecasting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_channel_connection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution channel connectivity and performance metrics — used by revenue management, distribution, and technology teams to monitor channel health, rate parity compliance, and booking flow."
  source: "`vibe_travel_hospitality_v1`.`property`.`channel_connection`"
  dimensions:
    - name: "connectivity_status"
      expr: connectivity_status
      comment: "Current connectivity status of the channel (active, inactive, error, pending) for distribution health monitoring."
    - name: "inventory_allocation_method"
      expr: inventory_allocation_method
      comment: "Method used to allocate inventory to this channel (pooled, allotment, on-request) for distribution strategy analysis."
    - name: "rate_loading_protocol"
      expr: rate_loading_protocol
      comment: "Protocol used for rate loading (push, pull, two-way) for technology and distribution operations."
    - name: "rate_parity_exception"
      expr: rate_parity_exception
      comment: "Whether a rate parity exception exists for this channel — critical for brand compliance and OTA contract management."
    - name: "activation_year"
      expr: YEAR(activation_date)
      comment: "Year the channel connection was activated — used for distribution portfolio vintage analysis."
  measures:
    - name: "total_channel_connections"
      expr: COUNT(1)
      comment: "Total number of channel connections. Baseline for distribution footprint and reach."
    - name: "active_channel_count"
      expr: COUNT(CASE WHEN connectivity_status = 'active' THEN 1 END)
      comment: "Count of active channel connections. Tracks live distribution reach for booking volume potential."
    - name: "avg_commission_rate_override"
      expr: AVG(CAST(commission_rate_override AS DOUBLE))
      comment: "Average commission rate override across channel connections. Tracks distribution cost vs. standard commission schedules."
    - name: "rate_parity_exception_count"
      expr: COUNT(CASE WHEN rate_parity_exception = TRUE THEN 1 END)
      comment: "Count of channels with active rate parity exceptions. Tracks brand compliance risk and OTA contract violation exposure."
    - name: "rate_parity_exception_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN rate_parity_exception = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of channel connections with rate parity exceptions. Key brand compliance KPI for distribution management."
    - name: "inactive_channel_count"
      expr: COUNT(CASE WHEN connectivity_status != 'active' THEN 1 END)
      comment: "Count of inactive or errored channel connections. Tracks distribution gaps and technology issues impacting booking flow."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_vendor_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property-level vendor agreement performance and financial metrics — used by procurement, operations, and finance teams to monitor vendor relationships, cost management, and service quality at the property level."
  source: "`vibe_travel_hospitality_v1`.`property`.`vendor_agreement`"
  dimensions:
    - name: "relationship_status"
      expr: relationship_status
      comment: "Current status of the vendor relationship (active, expired, terminated, on-hold) for supplier portfolio management."
    - name: "preferred_vendor_tier"
      expr: preferred_vendor_tier
      comment: "Preferred vendor tier classification (preferred, approved, conditional) for procurement strategy and sourcing decisions."
    - name: "relationship_start_year"
      expr: YEAR(relationship_start_date)
      comment: "Year the vendor relationship started — used for relationship tenure and loyalty analysis."
    - name: "relationship_end_year"
      expr: YEAR(relationship_end_date)
      comment: "Year the vendor relationship ended or is scheduled to end — used for contract renewal pipeline management."
  measures:
    - name: "total_vendor_agreements"
      expr: COUNT(1)
      comment: "Total number of vendor agreements at property level. Baseline for supplier portfolio scope."
    - name: "active_vendor_agreement_count"
      expr: COUNT(CASE WHEN relationship_status = 'active' THEN 1 END)
      comment: "Count of active vendor agreements. Tracks current supplier base size and procurement coverage."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average vendor performance rating across agreements. Core supplier quality KPI for procurement decisions."
    - name: "avg_property_specific_discount_pct"
      expr: AVG(CAST(property_specific_discount_pct AS DOUBLE))
      comment: "Average property-specific discount percentage negotiated with vendors. Tracks procurement savings vs. standard pricing."
    - name: "total_minimum_order_value"
      expr: SUM(CAST(minimum_order_value AS DOUBLE))
      comment: "Total minimum order value commitments across vendor agreements. Tracks procurement spend obligations."
    - name: "avg_payment_terms_override"
      expr: AVG(CAST(payment_terms_override AS DOUBLE))
      comment: "Average payment terms override (days) across vendor agreements. Tracks cash flow impact of vendor payment schedules."
    - name: "preferred_vendor_count"
      expr: COUNT(CASE WHEN preferred_vendor_tier = 'preferred' THEN 1 END)
      comment: "Count of preferred-tier vendor agreements. Tracks strategic supplier concentration and dependency risk."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational hierarchy and portfolio structure metrics — used by corporate leadership, finance, and strategy teams to understand portfolio composition, reporting structure, and geographic distribution."
  source: "`vibe_travel_hospitality_v1`.`property`.`hierarchy`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of hierarchy node (region, brand, country, cluster, property) for organizational structure analysis."
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level in the hierarchy (1=enterprise, 2=region, 3=brand, 4=cluster, 5=property) for rollup and drill-down analysis."
    - name: "node_status"
      expr: node_status
      comment: "Current status of the hierarchy node (active, inactive, restructured) for organizational change tracking."
    - name: "management_type"
      expr: management_type
      comment: "Management type (managed, franchised, owned) for portfolio mix and fee structure analysis."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region for portfolio geographic distribution and regional performance analysis."
    - name: "chain_scale"
      expr: chain_scale
      comment: "Chain scale (luxury, upper-upscale, upscale, midscale) for competitive positioning and brand portfolio analysis."
    - name: "is_reporting_node"
      expr: is_reporting_node
      comment: "Whether this node is a designated reporting node — used for financial consolidation and KPI rollup configuration."
    - name: "kpi_rollup_method"
      expr: kpi_rollup_method
      comment: "Method used to roll up KPIs at this node (sum, average, weighted) for financial reporting accuracy."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(1)
      comment: "Total number of hierarchy nodes. Baseline for organizational structure complexity and reporting scope."
    - name: "total_properties_in_hierarchy"
      expr: SUM(CAST(property_count AS BIGINT))
      comment: "Total property count rolled up across hierarchy nodes. Tracks portfolio scale at each organizational level."
    - name: "total_rooms_in_hierarchy"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory rolled up across hierarchy nodes. Core capacity metric for revenue potential at each organizational level."
    - name: "active_node_count"
      expr: COUNT(CASE WHEN node_status = 'active' THEN 1 END)
      comment: "Count of active hierarchy nodes. Tracks current organizational structure scope for reporting and governance."
    - name: "reporting_node_count"
      expr: COUNT(CASE WHEN is_reporting_node = TRUE THEN 1 END)
      comment: "Count of designated reporting nodes. Tracks financial consolidation points for management reporting."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_ownership_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ownership entity portfolio and financial metrics — used by asset management, investor relations, and finance teams to track ownership structure, portfolio value, and compliance obligations."
  source: "`vibe_travel_hospitality_v1`.`property`.`ownership_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Type of ownership entity (REIT, private equity, family office, institutional) for investor classification."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current ownership status (active, divested, in-acquisition) for portfolio transaction tracking."
    - name: "management_company_affiliation"
      expr: management_company_affiliation
      comment: "Management company affiliated with the ownership entity — tracks operator-owner relationships."
    - name: "reit_compliance_flag"
      expr: reit_compliance_flag
      comment: "Whether the entity is subject to REIT compliance requirements — critical for tax and regulatory reporting."
    - name: "sox_compliance_required"
      expr: sox_compliance_required
      comment: "Whether SOX compliance is required — tracks public company financial control obligations."
    - name: "registered_country_code"
      expr: registered_country_code
      comment: "Country of registration for the ownership entity — used for tax jurisdiction and regulatory analysis."
  measures:
    - name: "total_ownership_entities"
      expr: COUNT(1)
      comment: "Total number of ownership entities. Baseline for investor and ownership structure complexity."
    - name: "total_portfolio_acquisition_value"
      expr: SUM(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Total portfolio acquisition value in USD across all ownership entities. Core asset value metric for investor reporting."
    - name: "avg_portfolio_acquisition_value"
      expr: AVG(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Average portfolio acquisition value per ownership entity. Benchmarks investment scale and entity size."
    - name: "total_properties_owned"
      expr: SUM(CAST(total_properties_owned AS BIGINT))
      comment: "Total properties owned across all ownership entities. Tracks portfolio concentration and diversification."
    - name: "reit_entity_count"
      expr: COUNT(CASE WHEN reit_compliance_flag = TRUE THEN 1 END)
      comment: "Count of REIT-compliant ownership entities. Tracks REIT structure exposure for tax and distribution planning."
    - name: "active_entity_count"
      expr: COUNT(CASE WHEN ownership_status = 'active' THEN 1 END)
      comment: "Count of active ownership entities. Tracks current investor base size and portfolio ownership breadth."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "GDS (Global Distribution System) profile quality and content metrics — used by distribution, revenue management, and marketing teams to ensure accurate property representation across GDS channels and maximize booking conversion."
  source: "`vibe_travel_hospitality_v1`.`property`.`gds_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the GDS profile (active, inactive, pending-update) for distribution readiness tracking."
    - name: "distribution_channel_type"
      expr: distribution_channel_type
      comment: "Type of distribution channel (GDS, OTA, direct, CRS) for channel-specific content performance analysis."
    - name: "property_category"
      expr: property_category
      comment: "Property category as displayed in GDS (hotel, resort, extended-stay) for search and filter optimization."
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic distribution analysis and regional GDS performance."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag in GDS profile — required for accessibility filtering and regulatory compliance."
    - name: "is_pet_friendly"
      expr: is_pet_friendly
      comment: "Pet-friendly flag in GDS profile — key amenity filter for leisure traveler booking conversion."
    - name: "has_meeting_facilities"
      expr: has_meeting_facilities
      comment: "Meeting facilities flag in GDS profile — critical for corporate and group booking channel visibility."
  measures:
    - name: "total_gds_profiles"
      expr: COUNT(1)
      comment: "Total number of GDS profiles. Baseline for distribution content coverage."
    - name: "active_profile_count"
      expr: COUNT(CASE WHEN profile_status = 'active' THEN 1 END)
      comment: "Count of active GDS profiles. Tracks live distribution presence and booking-ready content."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating displayed in GDS profiles. Tracks quality positioning consistency across distribution channels."
    - name: "total_room_count_in_gds"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room count as represented in GDS profiles. Validates inventory accuracy in distribution channels."
    - name: "profiles_with_hero_image"
      expr: COUNT(CASE WHEN hero_image_url IS NOT NULL AND hero_image_url != '' THEN 1 END)
      comment: "Count of GDS profiles with a hero image. Tracks visual content completeness for booking conversion optimization."
    - name: "content_completeness_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN hero_image_url IS NOT NULL AND long_description IS NOT NULL AND phone_number IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of GDS profiles with complete core content (image, description, phone). Tracks content quality for search ranking and conversion."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_currency`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Currency business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`currency`"
  dimensions:
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Currency Name"
      expr: currency_name
    - name: "Currency Status"
      expr: currency_status
    - name: "Decimal Places"
      expr: decimal_places
    - name: "Display Format"
      expr: display_format
    - name: "Effective Date"
      expr: effective_date
    - name: "Erp Currency Code"
      expr: erp_currency_code
    - name: "Exchange Rate Source"
      expr: exchange_rate_source
    - name: "Exchange Rate Update Frequency"
      expr: exchange_rate_update_frequency
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Is Active"
      expr: is_active
    - name: "Is Base Currency"
      expr: is_base_currency
    - name: "Is Crypto Currency"
      expr: is_crypto_currency
    - name: "Minor Unit"
      expr: minor_unit
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Currency"
      expr: COUNT(DISTINCT currency_id)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_legal_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Legal Entity business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`legal_entity`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dissolution Date"
      expr: dissolution_date
    - name: "Doing Business As Name"
      expr: doing_business_as_name
    - name: "Duns Number"
      expr: duns_number
    - name: "Entity Subtype"
      expr: entity_subtype
    - name: "Entity Type"
      expr: entity_type
    - name: "Fiscal Year End Day"
      expr: fiscal_year_end_day
    - name: "Fiscal Year End Month"
      expr: fiscal_year_end_month
    - name: "Franchisee Name"
      expr: franchisee_name
    - name: "Functional Currency Code"
      expr: functional_currency_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Incorporation Jurisdiction"
      expr: incorporation_jurisdiction
    - name: "Is Franchise Entity"
      expr: is_franchise_entity
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Legal Entity"
      expr: COUNT(DISTINCT legal_entity_id)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_media`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Media business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`media`"
  dimensions:
    - name: "Alt Text"
      expr: alt_text
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved By"
      expr: approved_by
    - name: "Aspect Ratio"
      expr: aspect_ratio
    - name: "Asset Code"
      expr: asset_code
    - name: "Brand Website Approved"
      expr: brand_website_approved
    - name: "Caption"
      expr: caption
    - name: "Capture Date"
      expr: capture_date
    - name: "Cdn Path"
      expr: cdn_path
    - name: "Copyright Holder"
      expr: copyright_holder
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Display Order"
      expr: display_order
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "File Format"
      expr: file_format
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Media"
      expr: COUNT(DISTINCT media_id)
    - name: "Total File Size Kb"
      expr: SUM(file_size_kb)
    - name: "Average File Size Kb"
      expr: AVG(file_size_kb)
    - name: "Total View Count"
      expr: SUM(view_count)
    - name: "Average View Count"
      expr: AVG(view_count)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Party business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`party`"
  dimensions:
    - name: "Address Line 1"
      expr: address_line_1
    - name: "Address Line 2"
      expr: address_line_2
    - name: "City"
      expr: city
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Employee Count"
      expr: employee_count
    - name: "Fax Number"
      expr: fax_number
    - name: "Incorporation Country Code"
      expr: incorporation_country_code
    - name: "Incorporation Date"
      expr: incorporation_date
    - name: "Industry Classification Code"
      expr: industry_classification_code
    - name: "Is Publicly Traded"
      expr: is_publicly_traded
    - name: "Is Tax Exempt"
      expr: is_tax_exempt
    - name: "Legal Name"
      expr: legal_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Party"
      expr: COUNT(DISTINCT party_id)
    - name: "Total Annual Revenue Amount"
      expr: SUM(annual_revenue_amount)
    - name: "Average Annual Revenue Amount"
      expr: AVG(annual_revenue_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "Address Line1"
      expr: address_line1
    - name: "Address Line2"
      expr: address_line2
    - name: "Brand Code"
      expr: brand_code
    - name: "Brand Name"
      expr: brand_name
    - name: "Brand Tier"
      expr: brand_tier
    - name: "City"
      expr: city
    - name: "Closure Date"
      expr: closure_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dos Email"
      expr: dos_email
    - name: "Dos Name"
      expr: dos_name
    - name: "Franchise Agreement Number"
      expr: franchise_agreement_number
    - name: "Gds Property Code"
      expr: gds_property_code
    - name: "Gm Email"
      expr: gm_email
    - name: "Gm Name"
      expr: gm_name
    - name: "Is Franchised"
      expr: is_franchised
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property"
      expr: COUNT(DISTINCT property_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Star Rating"
      expr: SUM(star_rating)
    - name: "Average Star Rating"
      expr: AVG(star_rating)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Facility business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`property_facility`"
  dimensions:
    - name: "Ada Features"
      expr: ada_features
    - name: "Age Restriction"
      expr: age_restriction
    - name: "Av Equipment Available"
      expr: av_equipment_available
    - name: "Building Wing"
      expr: building_wing
    - name: "Capacity"
      expr: capacity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dress Code"
      expr: dress_code
    - name: "Facility Category"
      expr: facility_category
    - name: "Facility Code"
      expr: facility_code
    - name: "Facility Name"
      expr: facility_name
    - name: "Facility Type"
      expr: facility_type
    - name: "Floor Number"
      expr: floor_number
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Is 24 Hour"
      expr: is_24_hour
    - name: "Is Ada Compliant"
      expr: is_ada_compliant
    - name: "Is Fee Based"
      expr: is_fee_based
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Facility"
      expr: COUNT(DISTINCT property_facility_id)
    - name: "Total Area Sqft"
      expr: SUM(area_sqft)
    - name: "Average Area Sqft"
      expr: AVG(area_sqft)
    - name: "Total Max Occupancy Pct"
      expr: SUM(max_occupancy_pct)
    - name: "Average Max Occupancy Pct"
      expr: AVG(max_occupancy_pct)
    - name: "Total Usage Fee Amount"
      expr: SUM(usage_fee_amount)
    - name: "Average Usage Fee Amount"
      expr: AVG(usage_fee_amount)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Outlet business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "Alcohol Service Flag"
      expr: alcohol_service_flag
    - name: "Closure Date"
      expr: closure_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Cuisine Type"
      expr: cuisine_type
    - name: "Delivery Service Available Flag"
      expr: delivery_service_available_flag
    - name: "Dress Code"
      expr: dress_code
    - name: "Floor Number"
      expr: floor_number
    - name: "Gratuity Policy"
      expr: gratuity_policy
    - name: "Health Permit Number"
      expr: health_permit_number
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Renovation Date"
      expr: last_renovation_date
    - name: "Liquor License Number"
      expr: liquor_license_number
    - name: "Location Description"
      expr: location_description
    - name: "Loyalty Points Eligible Flag"
      expr: loyalty_points_eligible_flag
    - name: "Menu Url"
      expr: menu_url
    - name: "Mobile Ordering Enabled Flag"
      expr: mobile_ordering_enabled_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Outlet"
      expr: COUNT(DISTINCT property_outlet_id)
    - name: "Total Average Check Amount"
      expr: SUM(average_check_amount)
    - name: "Average Average Check Amount"
      expr: AVG(average_check_amount)
    - name: "Total Service Charge Percentage"
      expr: SUM(service_charge_percentage)
    - name: "Average Service Charge Percentage"
      expr: AVG(service_charge_percentage)
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_property_space_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property Space Allocation business metrics"
  source: "`vibe_travel_hospitality_v1`.`property`.`property_space_allocation`"
  dimensions:
    - name: "Allocation Created Timestamp"
      expr: allocation_created_timestamp
    - name: "Allocation Date"
      expr: allocation_date
    - name: "Allocation Modified Timestamp"
      expr: allocation_modified_timestamp
    - name: "Allocation Status"
      expr: allocation_status
    - name: "End Time"
      expr: end_time
    - name: "Guaranteed Attendance"
      expr: guaranteed_attendance
    - name: "Setup Style"
      expr: setup_style
    - name: "Special Requirements"
      expr: special_requirements
    - name: "Start Time"
      expr: start_time
    - name: "Allocation Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', allocation_created_timestamp)
    - name: "Allocation Date Month"
      expr: DATE_TRUNC('MONTH', allocation_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Property Space Allocation"
      expr: COUNT(DISTINCT property_space_allocation_id)
    - name: "Total Rental Charge"
      expr: SUM(rental_charge)
    - name: "Average Rental Charge"
      expr: AVG(rental_charge)
$$;