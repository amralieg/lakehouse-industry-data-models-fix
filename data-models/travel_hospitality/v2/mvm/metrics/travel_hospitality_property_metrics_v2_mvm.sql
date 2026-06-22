-- Metric views for domain: property | Business: Travel_Hospitality | Version: 2 | Generated on: 2026-06-22 19:35:58

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs for the property master entity — portfolio composition, operational status, physical scale, and brand/franchise mix. Used by asset management, development, and executive leadership to steer portfolio strategy."
  source: "`vibe_travel_hospitality_v1`.`property`.`property`"
  dimensions:
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code of the property, enabling brand-level portfolio analysis."
    - name: "brand_name"
      expr: brand_name
      comment: "Full brand name for labeling in dashboards and reports."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier (e.g. luxury, upscale, select-service) for tier-level performance segmentation."
    - name: "property_type"
      expr: property_type
      comment: "Type of property (hotel, resort, extended-stay, etc.) for product-type analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status (open, closed, under renovation) for active portfolio filtering."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification for competitive and revenue strategy segmentation."
    - name: "country_code"
      expr: country_code
      comment: "Country where the property is located for geographic portfolio analysis."
    - name: "state_province"
      expr: state_province
      comment: "State or province for sub-national geographic drill-down."
    - name: "city"
      expr: city
      comment: "City of the property for local market analysis."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Flag indicating whether the property operates under a franchise agreement, enabling owned vs. franchised portfolio split."
    - name: "pip_status"
      expr: pip_status
      comment: "Property Improvement Plan status, indicating capital investment pipeline stage."
    - name: "parent_brand_group"
      expr: parent_brand_group
      comment: "Parent brand group for portfolio roll-up reporting."
    - name: "opening_date_month"
      expr: DATE_TRUNC('MONTH', opening_date)
      comment: "Month of property opening for cohort and vintage analysis."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year of property opening for vintage portfolio analysis."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last renovation for asset age and capital cycle analysis."
  measures:
    - name: "total_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties in the portfolio. Core portfolio size KPI used in every executive review."
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory across the portfolio. Drives capacity planning, RevPAR denominator, and market share calculations."
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS BIGINT))
      comment: "Total suite inventory across the portfolio. Informs premium room mix strategy and upsell revenue potential."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting and event space square footage across the portfolio. Key driver of group and MICE revenue strategy."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across properties in the selected segment. Indicates portfolio quality positioning."
    - name: "franchised_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END)
      comment: "Number of franchised properties. Informs franchise vs. managed portfolio mix decisions."
    - name: "franchised_property_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END) / NULLIF(COUNT(DISTINCT property_id), 0), 2)
      comment: "Percentage of portfolio that is franchised. Tracks franchise penetration rate for strategic portfolio management."
    - name: "properties_open"
      expr: COUNT(DISTINCT CASE WHEN operational_status = 'OPEN' THEN property_id END)
      comment: "Count of currently open/operating properties. Baseline for active portfolio performance measurement."
    - name: "properties_under_renovation"
      expr: COUNT(DISTINCT CASE WHEN pip_status = 'IN_PROGRESS' THEN property_id END)
      comment: "Count of properties currently undergoing a Property Improvement Plan. Tracks capital deployment pipeline."
    - name: "avg_total_floor_count"
      expr: AVG(CAST(total_floor_count AS DOUBLE))
      comment: "Average number of floors across properties. Proxy for property scale and vertical development profile."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and contractual KPIs for franchise agreements — fee structures, compliance timelines, and investment obligations. Used by franchise development, legal, and finance leadership to manage franchise portfolio economics."
  source: "`vibe_travel_hospitality_v1`.`property`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (active, terminated, expired) for portfolio health filtering."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement for segmenting fee and term structures."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code associated with the franchise agreement for brand-level economics analysis."
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment (luxury, full-service, select-service) for segment-level franchise economics."
    - name: "franchisee_entity_name"
      expr: franchisee_entity_name
      comment: "Legal entity name of the franchisee for franchisee-level portfolio analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Whether a Property Improvement Plan is required under this agreement, flagging capital obligation."
    - name: "effective_date_year"
      expr: YEAR(effective_date)
      comment: "Year the agreement became effective for vintage cohort analysis."
    - name: "expiration_date_year"
      expr: YEAR(expiration_date)
      comment: "Year the agreement expires for renewal pipeline management."
    - name: "governing_law_state"
      expr: governing_law_state
      comment: "State governing the franchise agreement for jurisdictional risk analysis."
    - name: "exclusive_territory"
      expr: exclusive_territory
      comment: "Whether the agreement grants exclusive territory rights, impacting competitive positioning."
  measures:
    - name: "total_agreements"
      expr: COUNT(DISTINCT franchise_agreement_id)
      comment: "Total number of franchise agreements. Core franchise portfolio size KPI."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across agreements. Key revenue yield metric for franchise economics."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing/brand fund fee percentage. Tracks brand investment contribution rate."
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage. Measures loyalty program cost burden on franchisees."
    - name: "avg_reservation_fee_pct"
      expr: AVG(CAST(reservation_fee_pct AS DOUBLE))
      comment: "Average reservation/distribution fee percentage. Tracks CRS/distribution cost structure."
    - name: "total_pip_budget"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total committed PIP (Property Improvement Plan) budget across all agreements. Tracks capital investment pipeline for brand standard compliance."
    - name: "avg_pip_budget"
      expr: AVG(CAST(pip_budget_amount AS DOUBLE))
      comment: "Average PIP budget per agreement. Benchmarks capital investment requirement per property."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all agreements. Critical risk metric for legal and finance leadership."
    - name: "avg_quality_assurance_score_min"
      expr: AVG(CAST(quality_assurance_score_min AS DOUBLE))
      comment: "Average minimum QA score threshold required by franchise agreements. Tracks brand standard stringency."
    - name: "pip_required_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END)
      comment: "Number of agreements with a mandatory PIP. Quantifies capital obligation pipeline."
    - name: "pip_required_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END) / NULLIF(COUNT(DISTINCT franchise_agreement_id), 0), 2)
      comment: "Percentage of franchise agreements requiring a PIP. Tracks brand reinvestment mandate rate."
    - name: "avg_ff_and_e_reserve_pct"
      expr: AVG(CAST(ff_and_e_reserve_pct AS DOUBLE))
      comment: "Average FF&E reserve percentage required. Tracks ongoing capital reserve obligation for asset maintenance."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and compliance KPIs for property facilities — capacity utilization potential, fee-based revenue mix, ADA compliance, and inspection health. Used by operations, asset management, and compliance teams."
  source: "`vibe_travel_hospitality_v1`.`property`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (pool, gym, spa, restaurant, etc.) for facility-type performance segmentation."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility for active vs. inactive filtering."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Whether the facility charges a usage fee, enabling revenue-generating vs. complimentary facility analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag for regulatory compliance tracking."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Whether the facility operates seasonally, informing seasonal capacity planning."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Indoor or outdoor classification for facility mix analysis."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status for capital project pipeline tracking."
    - name: "category"
      expr: category
      comment: "Facility category for grouping similar facility types in portfolio analysis."
    - name: "last_inspection_date_month"
      expr: DATE_TRUNC('MONTH', last_inspection_date)
      comment: "Month of last inspection for compliance cycle monitoring."
    - name: "building_wing"
      expr: building_wing
      comment: "Building wing or zone where the facility is located for spatial analysis."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT facility_id)
      comment: "Total number of facilities across the portfolio. Baseline for facility portfolio sizing."
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total facility area in square feet. Drives space utilization and asset value analysis."
    - name: "avg_facility_area_sqft"
      expr: AVG(CAST(area_sqft AS DOUBLE))
      comment: "Average facility size in square feet. Benchmarks facility scale across property types."
    - name: "fee_based_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN facility_id END)
      comment: "Number of fee-generating facilities. Tracks ancillary revenue source count."
    - name: "fee_based_facility_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_fee_based = TRUE THEN facility_id END) / NULLIF(COUNT(DISTINCT facility_id), 0), 2)
      comment: "Percentage of facilities that are fee-based. Measures ancillary revenue monetization rate."
    - name: "ada_compliant_facility_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN facility_id END) / NULLIF(COUNT(DISTINCT facility_id), 0), 2)
      comment: "Percentage of facilities that are ADA compliant. Critical regulatory compliance KPI."
    - name: "avg_usage_fee_amount"
      expr: AVG(CAST(usage_fee_amount AS DOUBLE))
      comment: "Average usage fee charged by fee-based facilities. Informs ancillary pricing strategy."
    - name: "total_usage_fee_potential"
      expr: SUM(CAST(usage_fee_amount AS DOUBLE))
      comment: "Sum of all usage fees across facilities. Proxy for total ancillary fee revenue potential."
    - name: "avg_max_occupancy_pct"
      expr: AVG(CAST(max_occupancy_pct AS DOUBLE))
      comment: "Average maximum occupancy percentage threshold across facilities. Used in capacity and safety planning."
    - name: "facilities_under_renovation"
      expr: COUNT(DISTINCT CASE WHEN renovation_status = 'IN_PROGRESS' THEN facility_id END)
      comment: "Number of facilities currently under renovation. Tracks operational disruption and capital deployment."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity and revenue potential KPIs for meeting and event spaces — square footage, seating configurations, rental economics, and compliance. Used by group sales, revenue management, and asset teams to maximize MICE revenue."
  source: "`vibe_travel_hospitality_v1`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (ballroom, boardroom, breakout, etc.) for product-type revenue analysis."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space for active inventory filtering."
    - name: "divisible"
      expr: divisible
      comment: "Whether the space can be divided into sections, enabling flexible configuration analysis."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "ADA/accessibility compliance flag for regulatory and inclusivity reporting."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Whether WiFi is available in the space, a key amenity driver for group bookings."
    - name: "catering_required"
      expr: catering_required
      comment: "Whether catering is required when booking the space, impacting F&B revenue attachment."
    - name: "climate_control_type"
      expr: climate_control_type
      comment: "Type of climate control system for facility quality and comfort segmentation."
    - name: "last_renovation_date_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of last renovation for asset age and quality cycle analysis."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Whether natural light is available, a premium amenity factor for event space pricing."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Total number of meeting spaces in the portfolio. Core MICE inventory size KPI."
    - name: "total_meeting_sqft"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total meeting space square footage. Primary capacity metric for group sales and revenue management."
    - name: "avg_meeting_sqft"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average meeting space size in square feet. Benchmarks space scale for competitive positioning."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across meeting spaces. Key quality and suitability metric for large-format events."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hour requirement. Informs booking policy and revenue yield strategy."
    - name: "avg_minimum_catering_spend"
      expr: AVG(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Average minimum catering spend requirement. Tracks F&B revenue floor attached to meeting space bookings."
    - name: "total_minimum_catering_spend_potential"
      expr: SUM(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Total minimum catering spend potential across all meeting spaces. Proxy for guaranteed F&B revenue floor."
    - name: "avg_rental_rate_tier"
      expr: AVG(CAST(rental_rate_tier AS DOUBLE))
      comment: "Average rental rate tier across meeting spaces. Tracks pricing tier distribution for revenue strategy."
    - name: "divisible_space_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END) / NULLIF(COUNT(DISTINCT meeting_space_id), 0), 2)
      comment: "Percentage of meeting spaces that are divisible. Measures flexible inventory ratio for multi-event configurations."
    - name: "accessibility_compliant_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN accessibility_compliant = TRUE THEN meeting_space_id END) / NULLIF(COUNT(DISTINCT meeting_space_id), 0), 2)
      comment: "Percentage of meeting spaces that are accessibility compliant. Regulatory compliance and inclusivity KPI."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand forecasting and revenue strategy KPIs derived from the seasonal calendar — estimated ADR, occupancy, RevPAR, and demand classification. Used by revenue management and commercial leadership for seasonal pricing and staffing decisions."
  source: "`vibe_travel_hospitality_v1`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "season_code"
      expr: season_code
      comment: "Season code for grouping periods into defined revenue seasons."
    - name: "season_name"
      expr: season_name
      comment: "Human-readable season name for dashboard labeling."
    - name: "season_year"
      expr: season_year
      comment: "Year of the season for year-over-year seasonal comparison."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification (peak, shoulder, off-peak) for demand-tier revenue strategy."
    - name: "operating_status"
      expr: operating_status
      comment: "Operational status of the property during this seasonal period."
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Whether the period includes a holiday, enabling holiday vs. non-holiday performance comparison."
    - name: "market_segment_focus"
      expr: market_segment_focus
      comment: "Primary market segment targeted during this season for segment-level revenue strategy."
    - name: "rate_season_code"
      expr: rate_season_code
      comment: "Rate season code linking to rate plan structures for pricing strategy analysis."
    - name: "seasonal_hiring_required"
      expr: seasonal_hiring_required
      comment: "Whether seasonal staffing is required, informing labor cost planning."
    - name: "start_date_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the season starts for time-series demand analysis."
    - name: "yoy_demand_trend"
      expr: yoy_demand_trend
      comment: "Year-over-year demand trend direction for forward-looking revenue strategy."
    - name: "competitive_set_position"
      expr: competitive_set_position
      comment: "Competitive set positioning during this season for market share strategy."
  measures:
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated ADR (Average Daily Rate) across seasonal periods. Core revenue management KPI for pricing strategy."
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across seasonal periods. Drives capacity and staffing planning."
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated RevPAR (Revenue Per Available Room) across seasonal periods. The primary hotel revenue performance KPI."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target. Measures competitive revenue performance goal vs. comp set."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average estimated cancellation rate. Informs overbooking strategy and net revenue forecasting."
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average estimated no-show rate. Drives overbooking policy and revenue protection strategy."
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage. Tracks demand momentum for forward pricing decisions."
    - name: "total_seasonal_periods"
      expr: COUNT(DISTINCT seasonal_calendar_id)
      comment: "Total number of distinct seasonal calendar periods. Baseline for seasonal planning coverage."
    - name: "peak_season_period_count"
      expr: COUNT(DISTINCT CASE WHEN demand_classification = 'PEAK' THEN seasonal_calendar_id END)
      comment: "Number of peak demand periods. Quantifies high-revenue opportunity windows for pricing and staffing."
    - name: "holiday_period_count"
      expr: COUNT(DISTINCT CASE WHEN is_holiday_period = TRUE THEN seasonal_calendar_id END)
      comment: "Number of holiday periods in the calendar. Informs special event pricing and staffing strategy."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational and revenue KPIs for property food & beverage and retail outlets — average check, service charges, capacity, and amenity mix. Used by F&B leadership and revenue management to optimize outlet performance."
  source: "`vibe_travel_hospitality_v1`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of outlet (restaurant, bar, café, retail, spa, etc.) for outlet-type performance segmentation."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet for active inventory filtering."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type for F&B outlet segmentation and competitive positioning."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Whether the outlet serves alcohol, impacting revenue mix and licensing compliance."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Whether the outlet operates seasonally, informing capacity and staffing planning."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Whether purchases at this outlet earn loyalty points, impacting loyalty program economics."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Whether mobile ordering is enabled, tracking digital channel adoption."
    - name: "private_dining_available_flag"
      expr: private_dining_available_flag
      comment: "Whether private dining is available, a premium revenue and guest experience indicator."
    - name: "opening_date_year"
      expr: YEAR(opening_date)
      comment: "Year the outlet opened for vintage and lifecycle analysis."
    - name: "pos_system_code"
      expr: pos_system_code
      comment: "POS system used at the outlet for technology stack and integration analysis."
  measures:
    - name: "total_outlets"
      expr: COUNT(DISTINCT property_outlet_id)
      comment: "Total number of property outlets. Core F&B and ancillary portfolio size KPI."
    - name: "avg_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount across outlets. Primary F&B revenue yield KPI for pricing strategy."
    - name: "avg_service_charge_pct"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage. Tracks service charge revenue contribution across the outlet portfolio."
    - name: "alcohol_serving_outlet_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN alcohol_service_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets serving alcohol. Informs beverage revenue mix and licensing compliance posture."
    - name: "mobile_ordering_adoption_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets with mobile ordering enabled. Tracks digital channel adoption rate across the F&B portfolio."
    - name: "loyalty_eligible_outlet_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN loyalty_points_eligible_flag = TRUE THEN property_outlet_id END) / NULLIF(COUNT(DISTINCT property_outlet_id), 0), 2)
      comment: "Percentage of outlets participating in the loyalty program. Measures loyalty program coverage and guest engagement potential."
    - name: "private_dining_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN private_dining_available_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets offering private dining. Tracks premium experience inventory for high-value guest segments."
    - name: "total_average_check_potential"
      expr: SUM(CAST(average_check_amount AS DOUBLE))
      comment: "Sum of average check amounts across all outlets. Proxy for total F&B revenue yield potential across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_travel_hospitality_v1`.`_metrics`.`property_gds_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution and digital presence KPIs for GDS profiles — star ratings, amenity flags, and profile health. Used by distribution, revenue management, and marketing to optimize global distribution system presence and channel performance."
  source: "`vibe_travel_hospitality_v1`.`property`.`gds_profile`"
  dimensions:
    - name: "profile_status"
      expr: profile_status
      comment: "Current status of the GDS profile (active, inactive, pending) for distribution health filtering."
    - name: "distribution_channel_type"
      expr: distribution_channel_type
      comment: "Type of distribution channel (GDS, OTA, direct, etc.) for channel mix analysis."
    - name: "property_category"
      expr: property_category
      comment: "Property category as represented in the GDS for channel-level product segmentation."
    - name: "brand_code"
      expr: brand_code
      comment: "Brand code in the GDS profile for brand-level distribution analysis."
    - name: "chain_code"
      expr: chain_code
      comment: "Chain code in the GDS for chain-level distribution coverage analysis."
    - name: "country_code"
      expr: country_code
      comment: "Country code for geographic distribution coverage analysis."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "ADA compliance flag as published in the GDS profile for compliance and accessibility reporting."
    - name: "is_pet_friendly"
      expr: is_pet_friendly
      comment: "Pet-friendly flag for amenity-based distribution segmentation."
    - name: "has_pool"
      expr: has_pool
      comment: "Pool availability flag for amenity-driven distribution and marketing analysis."
    - name: "has_meeting_facilities"
      expr: has_meeting_facilities
      comment: "Meeting facilities flag for group and MICE channel distribution analysis."
    - name: "profile_effective_date_year"
      expr: YEAR(profile_effective_date)
      comment: "Year the GDS profile became effective for profile vintage and refresh cycle analysis."
  measures:
    - name: "total_gds_profiles"
      expr: COUNT(DISTINCT gds_profile_id)
      comment: "Total number of active GDS profiles. Measures global distribution footprint."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating as published in GDS profiles. Tracks quality positioning in global distribution channels."
    - name: "active_profile_count"
      expr: COUNT(DISTINCT CASE WHEN profile_status = 'ACTIVE' THEN gds_profile_id END)
      comment: "Number of currently active GDS profiles. Core distribution health KPI."
    - name: "active_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN profile_status = 'ACTIVE' THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles that are active. Measures distribution channel activation rate."
    - name: "pet_friendly_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_pet_friendly = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles flagged as pet-friendly. Tracks amenity coverage for pet-travel market segment."
    - name: "meeting_facilities_profile_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN has_meeting_facilities = TRUE THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles advertising meeting facilities. Measures MICE distribution coverage."
    - name: "avg_latitude"
      expr: AVG(CAST(latitude AS DOUBLE))
      comment: "Average latitude of properties in GDS profiles. Used for geographic clustering and market coverage analysis."
    - name: "profiles_with_hero_image"
      expr: COUNT(DISTINCT CASE WHEN hero_image_url IS NOT NULL THEN gds_profile_id END)
      comment: "Number of GDS profiles with a hero image populated. Tracks content completeness, a key driver of GDS conversion rates."
    - name: "content_completeness_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN hero_image_url IS NOT NULL AND long_description IS NOT NULL THEN gds_profile_id END) / NULLIF(COUNT(DISTINCT gds_profile_id), 0), 2)
      comment: "Percentage of GDS profiles with both hero image and long description populated. Measures distribution content quality, directly linked to booking conversion."
$$;