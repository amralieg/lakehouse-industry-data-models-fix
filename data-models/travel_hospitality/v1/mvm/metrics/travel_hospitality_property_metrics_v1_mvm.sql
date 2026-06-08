-- Metric views for domain: property | Business: Travel Hospitality | Version: 1 | Generated on: 2026-05-08 05:56:59

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core property portfolio metrics covering operational status, star rating distribution, room inventory, and renovation pipeline. Used by asset management, development, and executive leadership to evaluate portfolio health and capacity."
  source: "`travel_hospitality_ecm`.`property`.`property`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the property (e.g., Open, Closed, Under Renovation). Primary filter for active portfolio analysis."
    - name: "brand_tier"
      expr: brand_tier
      comment: "Brand tier classification (e.g., Luxury, Premium, Select-Service). Enables performance benchmarking across portfolio tiers."
    - name: "property_type"
      expr: property_type
      comment: "Type of property (e.g., Hotel, Resort, Extended Stay). Supports segment-level portfolio analysis."
    - name: "segment_classification"
      expr: segment_classification
      comment: "Market segment classification assigned to the property. Used for competitive set grouping and revenue strategy."
    - name: "country_code"
      expr: country_code
      comment: "ISO country code of the property location. Enables geographic portfolio rollups."
    - name: "state_province"
      expr: state_province
      comment: "State or province of the property. Supports sub-national geographic analysis."
    - name: "is_franchised"
      expr: is_franchised
      comment: "Indicates whether the property operates under a franchise agreement. Distinguishes managed vs. franchised portfolio composition."
    - name: "pip_status"
      expr: pip_status
      comment: "Property Improvement Plan (PIP) status. Tracks capital reinvestment obligations across the portfolio."
    - name: "parent_brand_group"
      expr: parent_brand_group
      comment: "Parent brand group or family (e.g., Marriott, Hilton). Enables brand-family level portfolio aggregation."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the property opened. Supports cohort analysis of portfolio vintage and age-based performance trends."
    - name: "last_renovation_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of the most recent renovation. Used to identify properties due for capital reinvestment."
  measures:
    - name: "total_properties"
      expr: COUNT(DISTINCT property_id)
      comment: "Total number of distinct properties in the portfolio. Baseline KPI for portfolio scale used in every executive dashboard."
    - name: "total_room_inventory"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room inventory across all properties. Core capacity metric used by revenue management and asset management to size the portfolio."
    - name: "total_suite_inventory"
      expr: SUM(CAST(total_suite_count AS BIGINT))
      comment: "Total suite inventory across all properties. Tracks premium room-type capacity relevant to luxury segment revenue strategy."
    - name: "avg_star_rating"
      expr: AVG(CAST(star_rating AS DOUBLE))
      comment: "Average star rating across the portfolio. Indicates overall quality positioning; a decline signals brand standard erosion requiring intervention."
    - name: "total_meeting_space_sqft"
      expr: SUM(CAST(total_meeting_space_sqft AS DOUBLE))
      comment: "Total meeting and event space square footage across all properties. Drives group and events revenue strategy decisions."
    - name: "franchised_property_count"
      expr: COUNT(DISTINCT CASE WHEN is_franchised = TRUE THEN property_id END)
      comment: "Number of franchised properties. Tracks franchise vs. managed portfolio mix, a key strategic and fee-revenue driver."
    - name: "properties_with_active_pip"
      expr: COUNT(DISTINCT CASE WHEN pip_status = 'Active' THEN property_id END)
      comment: "Number of properties with an active Property Improvement Plan. Quantifies capital reinvestment exposure and brand compliance risk."
    - name: "avg_total_floor_count"
      expr: AVG(CAST(total_floor_count AS DOUBLE))
      comment: "Average number of floors across properties. Proxy for property scale and complexity relevant to operational cost benchmarking."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_franchise_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Franchise agreement financial and compliance metrics covering fee structures, PIP obligations, and agreement lifecycle. Used by legal, development, and finance leadership to manage franchise portfolio economics and risk."
  source: "`travel_hospitality_ecm`.`property`.`franchise_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the franchise agreement (e.g., Active, Terminated, Expired). Primary filter for active franchise portfolio analysis."
    - name: "agreement_type"
      expr: agreement_type
      comment: "Type of franchise agreement (e.g., Standard, Master, License). Differentiates agreement structures for fee and obligation analysis."
    - name: "brand_segment"
      expr: brand_segment
      comment: "Brand segment covered by the agreement (e.g., Luxury, Full-Service, Select-Service). Enables segment-level franchise economics analysis."
    - name: "governing_law_country"
      expr: governing_law_country
      comment: "Country whose law governs the agreement. Supports jurisdictional risk and compliance analysis."
    - name: "governing_law_state"
      expr: governing_law_state
      comment: "State whose law governs the agreement. Enables sub-national legal jurisdiction analysis."
    - name: "pip_required"
      expr: pip_required
      comment: "Indicates whether a Property Improvement Plan is required under the agreement. Flags capital obligation exposure."
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the franchise agreement became effective. Supports vintage cohort analysis of franchise portfolio."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the franchise agreement expires. Critical for renewal pipeline planning and revenue continuity risk management."
    - name: "crs_connectivity_required"
      expr: crs_connectivity_required
      comment: "Indicates whether CRS connectivity is contractually required. Tracks technology compliance obligations across the franchise portfolio."
  measures:
    - name: "total_active_agreements"
      expr: COUNT(DISTINCT CASE WHEN agreement_status = 'Active' THEN franchise_agreement_id END)
      comment: "Total number of active franchise agreements. Baseline KPI for franchise portfolio scale used in development and legal reviews."
    - name: "avg_royalty_fee_pct"
      expr: AVG(CAST(royalty_fee_pct AS DOUBLE))
      comment: "Average royalty fee percentage across franchise agreements. Key economics indicator; deviations from brand standard trigger renegotiation reviews."
    - name: "avg_marketing_fee_pct"
      expr: AVG(CAST(marketing_fee_pct AS DOUBLE))
      comment: "Average marketing fee percentage across agreements. Tracks brand fund contribution rates; used in brand investment planning."
    - name: "avg_loyalty_fee_pct"
      expr: AVG(CAST(loyalty_fee_pct AS DOUBLE))
      comment: "Average loyalty program fee percentage. Measures loyalty cost burden on franchisees; informs loyalty program pricing strategy."
    - name: "total_pip_budget"
      expr: SUM(CAST(pip_budget_amount AS DOUBLE))
      comment: "Total capital committed to Property Improvement Plans across all agreements. Quantifies portfolio-wide reinvestment obligation for asset management."
    - name: "avg_pip_budget_per_agreement"
      expr: AVG(CAST(pip_budget_amount AS DOUBLE))
      comment: "Average PIP budget per franchise agreement. Benchmarks reinvestment intensity; outliers indicate properties requiring elevated capital scrutiny."
    - name: "total_liquidated_damages_exposure"
      expr: SUM(CAST(liquidated_damages_amount AS DOUBLE))
      comment: "Total liquidated damages exposure across all agreements. Quantifies maximum financial risk from early terminations; critical for legal and finance risk reviews."
    - name: "avg_ff_and_e_reserve_pct"
      expr: AVG(CAST(ff_and_e_reserve_pct AS DOUBLE))
      comment: "Average FF&E reserve percentage across agreements. Tracks contractual capital reserve requirements; informs long-term asset maintenance funding."
    - name: "avg_management_fee_base_pct"
      expr: AVG(CAST(management_fee_base_pct AS DOUBLE))
      comment: "Average base management fee percentage. Core economics metric for management contract portfolio; used in fee revenue forecasting."
    - name: "agreements_expiring_within_2_years"
      expr: COUNT(DISTINCT CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 730) AND agreement_status = 'Active' THEN franchise_agreement_id END)
      comment: "Number of active agreements expiring within the next 2 years. Renewal pipeline KPI; drives proactive renegotiation and retention strategy."
    - name: "pip_required_agreement_count"
      expr: COUNT(DISTINCT CASE WHEN pip_required = TRUE THEN franchise_agreement_id END)
      comment: "Number of agreements with a PIP requirement. Tracks capital obligation exposure across the franchise portfolio."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_certification`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property certification and compliance metrics covering audit scores, deficiency rates, and certification lifecycle. Used by quality assurance, legal, and operations leadership to manage regulatory compliance and brand standard adherence."
  source: "`travel_hospitality_ecm`.`property`.`certification`"
  dimensions:
    - name: "certification_type"
      expr: certification_type
      comment: "Type of certification (e.g., Safety, Environmental, Brand Quality). Enables compliance analysis by certification category."
    - name: "certification_name"
      expr: certification_name
      comment: "Name of the specific certification or standard. Supports granular compliance tracking by certification program."
    - name: "certification_status"
      expr: certification_status
      comment: "Current status of the certification (e.g., Active, Expired, Suspended). Primary filter for active compliance posture analysis."
    - name: "certification_level"
      expr: certification_level
      comment: "Level or tier of the certification achieved (e.g., Gold, Silver, Platinum). Tracks quality achievement distribution across the portfolio."
    - name: "accreditation_body"
      expr: accreditation_body
      comment: "Organization that issued or governs the certification. Enables analysis by regulatory or standards body."
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction applicable to the certification. Supports geographic compliance risk analysis."
    - name: "renewal_status"
      expr: renewal_status
      comment: "Renewal status of the certification (e.g., Pending, Renewed, Lapsed). Tracks renewal pipeline and lapse risk."
    - name: "audit_year"
      expr: YEAR(audit_start_date)
      comment: "Year the audit was conducted. Enables year-over-year compliance trend analysis."
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the certification expires. Supports proactive renewal pipeline management."
  measures:
    - name: "total_certifications"
      expr: COUNT(DISTINCT certification_id)
      comment: "Total number of certifications across the portfolio. Baseline compliance coverage metric used in regulatory and brand standard reviews."
    - name: "avg_compliance_score"
      expr: AVG(CAST(compliance_score AS DOUBLE))
      comment: "Average compliance score across all certifications. Portfolio-wide quality health indicator; declines trigger audit and corrective action programs."
    - name: "min_compliance_score"
      expr: MIN(compliance_score)
      comment: "Minimum compliance score observed. Identifies the worst-performing certification in the portfolio; used to prioritize corrective action resources."
    - name: "total_permit_fee_spend"
      expr: SUM(CAST(permit_fee_amount AS DOUBLE))
      comment: "Total permit and certification fee expenditure. Tracks regulatory compliance cost burden across the portfolio."
    - name: "active_certification_count"
      expr: COUNT(DISTINCT CASE WHEN certification_status = 'Active' THEN certification_id END)
      comment: "Number of currently active certifications. Measures active compliance coverage; gaps indicate regulatory exposure."
    - name: "expiring_certifications_90_days"
      expr: COUNT(DISTINCT CASE WHEN expiration_date BETWEEN CURRENT_DATE() AND DATE_ADD(CURRENT_DATE(), 90) THEN certification_id END)
      comment: "Number of certifications expiring within 90 days. Renewal urgency KPI; drives proactive compliance management to avoid lapses."
    - name: "avg_permit_fee_per_certification"
      expr: AVG(CAST(permit_fee_amount AS DOUBLE))
      comment: "Average permit fee per certification. Benchmarks compliance cost per certification; outliers indicate high-cost regulatory jurisdictions."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_meeting_space`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meeting and event space capacity and configuration metrics. Used by group sales, revenue management, and asset management to optimize event space utilization, pricing strategy, and capital investment decisions."
  source: "`travel_hospitality_ecm`.`property`.`meeting_space`"
  dimensions:
    - name: "space_type"
      expr: space_type
      comment: "Type of meeting space (e.g., Ballroom, Boardroom, Breakout). Enables capacity and revenue analysis by space category."
    - name: "meeting_space_status"
      expr: meeting_space_status
      comment: "Current operational status of the meeting space (e.g., Active, Under Renovation, Closed). Primary filter for available inventory analysis."
    - name: "rental_rate_tier"
      expr: rental_rate_tier
      comment: "Pricing tier assigned to the meeting space. Supports revenue strategy analysis by rate tier."
    - name: "floor_level"
      expr: floor_level
      comment: "Floor level of the meeting space. Enables location-based analysis within a property."
    - name: "divisible"
      expr: divisible
      comment: "Indicates whether the space can be divided into smaller sections. Tracks flexible inventory that can serve multiple simultaneous events."
    - name: "wifi_available"
      expr: wifi_available
      comment: "Indicates whether WiFi is available in the space. Tracks technology amenity coverage relevant to corporate group demand."
    - name: "accessibility_compliant"
      expr: accessibility_compliant
      comment: "Indicates ADA or accessibility compliance of the space. Tracks regulatory compliance and inclusivity of event inventory."
    - name: "natural_light_available"
      expr: natural_light_available
      comment: "Indicates whether the space has natural light. Premium amenity attribute influencing group booking preference and rate premiums."
    - name: "last_renovation_year"
      expr: YEAR(last_renovation_date)
      comment: "Year of the most recent renovation. Identifies aging inventory requiring capital reinvestment to maintain competitive positioning."
  measures:
    - name: "total_meeting_spaces"
      expr: COUNT(DISTINCT meeting_space_id)
      comment: "Total number of meeting spaces across the portfolio. Baseline group and events capacity metric used in sales strategy and RFP responses."
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total meeting space square footage across all spaces. Core group capacity metric used in event sales, competitive positioning, and asset valuation."
    - name: "avg_square_footage_per_space"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average square footage per meeting space. Benchmarks space size distribution; informs product mix decisions for group segment targeting."
    - name: "avg_ceiling_height_feet"
      expr: AVG(CAST(ceiling_height_feet AS DOUBLE))
      comment: "Average ceiling height across meeting spaces. Key specification for large-format events and production requirements; influences group booking conversion."
    - name: "total_minimum_catering_spend"
      expr: SUM(CAST(minimum_catering_spend AS DOUBLE))
      comment: "Total minimum catering spend commitments across all meeting spaces. Quantifies guaranteed F&B revenue floor from group events business."
    - name: "avg_minimum_rental_hours"
      expr: AVG(CAST(minimum_rental_hours AS DOUBLE))
      comment: "Average minimum rental hours required across spaces. Tracks booking policy stringency; informs yield management for short-duration event demand."
    - name: "divisible_space_count"
      expr: COUNT(DISTINCT CASE WHEN divisible = TRUE THEN meeting_space_id END)
      comment: "Number of divisible meeting spaces. Tracks flexible inventory that maximizes simultaneous event capacity and revenue yield."
    - name: "active_space_count"
      expr: COUNT(DISTINCT CASE WHEN meeting_space_status = 'Active' THEN meeting_space_id END)
      comment: "Number of currently active and available meeting spaces. Measures sellable group inventory; declines signal renovation or closure impact on revenue."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_outlet`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Food and beverage outlet portfolio metrics covering outlet economics, service capabilities, and operational status. Used by F&B leadership, revenue management, and asset management to optimize outlet mix, pricing, and investment decisions."
  source: "`travel_hospitality_ecm`.`property`.`property_outlet`"
  dimensions:
    - name: "outlet_type"
      expr: outlet_type
      comment: "Type of F&B outlet (e.g., Restaurant, Bar, Café, Room Service). Enables revenue and performance analysis by outlet category."
    - name: "outlet_status"
      expr: outlet_status
      comment: "Current operational status of the outlet (e.g., Open, Closed, Seasonal). Primary filter for active revenue-generating outlet analysis."
    - name: "cuisine_type"
      expr: cuisine_type
      comment: "Cuisine type offered by the outlet. Supports product mix analysis and competitive positioning of F&B portfolio."
    - name: "alcohol_service_flag"
      expr: alcohol_service_flag
      comment: "Indicates whether the outlet serves alcohol. Tracks beverage revenue capability and licensing compliance across the portfolio."
    - name: "loyalty_points_eligible_flag"
      expr: loyalty_points_eligible_flag
      comment: "Indicates whether purchases at the outlet earn loyalty points. Tracks loyalty program integration across F&B outlets."
    - name: "mobile_ordering_enabled_flag"
      expr: mobile_ordering_enabled_flag
      comment: "Indicates whether mobile ordering is enabled. Tracks digital capability adoption across the F&B portfolio."
    - name: "seasonal_operation_flag"
      expr: seasonal_operation_flag
      comment: "Indicates whether the outlet operates seasonally. Distinguishes year-round vs. seasonal revenue contributors."
    - name: "outdoor_seating_flag"
      expr: outdoor_seating_flag
      comment: "Indicates whether outdoor seating is available. Premium amenity attribute influencing guest satisfaction and revenue per cover."
    - name: "opening_year"
      expr: YEAR(opening_date)
      comment: "Year the outlet opened. Supports vintage cohort analysis of F&B portfolio performance."
  measures:
    - name: "total_outlets"
      expr: COUNT(DISTINCT property_outlet_id)
      comment: "Total number of F&B outlets across the portfolio. Baseline metric for F&B portfolio scale used in brand standard and revenue reviews."
    - name: "avg_check_amount"
      expr: AVG(CAST(average_check_amount AS DOUBLE))
      comment: "Average check amount across all outlets. Core F&B revenue intensity metric; declines signal pricing or mix issues requiring management action."
    - name: "total_service_charge_pct_avg"
      expr: AVG(CAST(service_charge_percentage AS DOUBLE))
      comment: "Average service charge percentage across outlets. Tracks ancillary revenue capture rate; informs pricing policy standardization."
    - name: "outlets_with_mobile_ordering"
      expr: COUNT(DISTINCT CASE WHEN mobile_ordering_enabled_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets with mobile ordering enabled. Tracks digital transformation progress in F&B; low penetration signals technology investment gap."
    - name: "outlets_with_alcohol_service"
      expr: COUNT(DISTINCT CASE WHEN alcohol_service_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets with alcohol service. Tracks beverage revenue capability; informs licensing compliance and revenue mix strategy."
    - name: "loyalty_eligible_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN loyalty_points_eligible_flag = TRUE THEN property_outlet_id END)
      comment: "Number of outlets eligible for loyalty points. Measures loyalty program integration depth in F&B; drives member engagement and incremental spend."
    - name: "active_outlet_count"
      expr: COUNT(DISTINCT CASE WHEN outlet_status = 'Open' THEN property_outlet_id END)
      comment: "Number of currently open and operating outlets. Tracks active F&B revenue-generating capacity; declines signal closures impacting guest experience and revenue."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property amenity and facility metrics covering compliance, fee-based revenue, and operational status. Used by operations, asset management, and brand standards teams to manage facility quality, compliance risk, and ancillary revenue."
  source: "`travel_hospitality_ecm`.`property`.`property_facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., Pool, Fitness Center, Spa, Parking). Enables performance and compliance analysis by amenity category."
    - name: "facility_category"
      expr: facility_category
      comment: "Broader category grouping for the facility. Supports portfolio-level amenity mix analysis."
    - name: "property_facility_status"
      expr: property_facility_status
      comment: "Current operational status of the facility (e.g., Open, Closed, Under Renovation). Primary filter for active amenity inventory."
    - name: "is_fee_based"
      expr: is_fee_based
      comment: "Indicates whether the facility charges a usage fee. Distinguishes revenue-generating amenities from complimentary offerings."
    - name: "is_ada_compliant"
      expr: is_ada_compliant
      comment: "Indicates ADA compliance of the facility. Tracks regulatory compliance posture and accessibility risk across the portfolio."
    - name: "is_seasonal"
      expr: is_seasonal
      comment: "Indicates whether the facility operates seasonally. Distinguishes year-round vs. seasonal amenity availability."
    - name: "renovation_status"
      expr: renovation_status
      comment: "Current renovation status of the facility. Tracks capital project pipeline and its impact on available amenity inventory."
    - name: "outdoor_indoor"
      expr: outdoor_indoor
      comment: "Indicates whether the facility is outdoor or indoor. Supports amenity mix and seasonal availability analysis."
    - name: "inspection_result"
      expr: inspection_result
      comment: "Result of the most recent inspection (e.g., Pass, Fail, Conditional). Tracks compliance and safety posture across facilities."
  measures:
    - name: "total_facilities"
      expr: COUNT(DISTINCT property_facility_id)
      comment: "Total number of facilities across the portfolio. Baseline amenity inventory metric used in brand standard compliance and guest experience reviews."
    - name: "total_facility_area_sqft"
      expr: SUM(CAST(area_sqft AS DOUBLE))
      comment: "Total square footage of all facilities. Measures physical amenity footprint; informs capital allocation and renovation prioritization."
    - name: "avg_max_occupancy_pct"
      expr: AVG(CAST(max_occupancy_pct AS DOUBLE))
      comment: "Average maximum occupancy percentage across facilities. Tracks capacity utilization ceiling; informs operational staffing and safety compliance."
    - name: "total_usage_fee_revenue_potential"
      expr: SUM(CASE WHEN is_fee_based = TRUE THEN usage_fee_amount ELSE 0 END)
      comment: "Total potential usage fee revenue from fee-based facilities. Quantifies ancillary revenue opportunity from amenity monetization."
    - name: "avg_usage_fee_amount"
      expr: AVG(CASE WHEN is_fee_based = TRUE THEN usage_fee_amount END)
      comment: "Average usage fee amount for fee-based facilities. Benchmarks ancillary pricing; informs revenue optimization for amenity monetization strategy."
    - name: "ada_compliant_facility_count"
      expr: COUNT(DISTINCT CASE WHEN is_ada_compliant = TRUE THEN property_facility_id END)
      comment: "Number of ADA-compliant facilities. Tracks accessibility compliance coverage; gaps represent regulatory risk and brand reputation exposure."
    - name: "facilities_due_for_inspection"
      expr: COUNT(DISTINCT CASE WHEN next_inspection_date <= DATE_ADD(CURRENT_DATE(), 30) THEN property_facility_id END)
      comment: "Number of facilities with an inspection due within 30 days. Operational compliance urgency KPI; drives proactive inspection scheduling to avoid violations."
    - name: "active_facility_count"
      expr: COUNT(DISTINCT CASE WHEN property_facility_status = 'Open' THEN property_facility_id END)
      comment: "Number of currently open and operational facilities. Tracks active amenity inventory; declines signal renovation or closure impact on guest experience scores."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_seasonal_calendar`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal demand and revenue forecast metrics covering occupancy estimates, ADR targets, RevPAR projections, and demand classification. Used by revenue management, sales, and executive leadership to plan pricing strategy, staffing, and marketing investment by season."
  source: "`travel_hospitality_ecm`.`property`.`seasonal_calendar`"
  dimensions:
    - name: "season_name"
      expr: season_name
      comment: "Name of the season (e.g., Peak Summer, Holiday, Shoulder). Primary grouping dimension for seasonal performance analysis."
    - name: "season_code"
      expr: season_code
      comment: "Standardized season code. Used for cross-property seasonal benchmarking and rate plan alignment."
    - name: "season_year"
      expr: season_year
      comment: "Year of the seasonal calendar entry. Enables year-over-year seasonal performance comparison."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification for the period (e.g., High, Medium, Low, Blackout). Core revenue management segmentation for pricing strategy."
    - name: "is_blackout_date"
      expr: is_blackout_date
      comment: "Indicates whether the date is a blackout period (no discounts/loyalty redemptions). Tracks revenue protection periods across the portfolio."
    - name: "is_holiday_period"
      expr: is_holiday_period
      comment: "Indicates whether the period is a holiday. Enables holiday-specific demand and pricing analysis."
    - name: "market_segment_focus"
      expr: market_segment_focus
      comment: "Primary market segment targeted during this season (e.g., Leisure, Corporate, Group). Aligns revenue strategy with demand source mix."
    - name: "operating_status"
      expr: operating_status
      comment: "Operational status of the property during this seasonal period. Identifies periods of reduced or suspended operations."
    - name: "rate_season_code"
      expr: rate_season_code
      comment: "Rate season code linked to the pricing strategy for this period. Connects seasonal calendar to rate plan management."
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month the seasonal period begins. Enables monthly demand pattern analysis and seasonal trend visualization."
  measures:
    - name: "avg_estimated_occupancy_pct"
      expr: AVG(CAST(estimated_occupancy_pct AS DOUBLE))
      comment: "Average estimated occupancy percentage across seasonal periods. Core demand forecast KPI used in revenue planning, staffing, and procurement decisions."
    - name: "avg_estimated_adr"
      expr: AVG(CAST(estimated_adr AS DOUBLE))
      comment: "Average estimated Average Daily Rate across seasonal periods. Primary pricing forecast metric used in revenue strategy and budget planning."
    - name: "avg_estimated_revpar"
      expr: AVG(CAST(estimated_revpar AS DOUBLE))
      comment: "Average estimated RevPAR (Revenue Per Available Room) across seasonal periods. The single most important hotel performance KPI; drives all revenue management decisions."
    - name: "avg_rgi_target"
      expr: AVG(CAST(rgi_target AS DOUBLE))
      comment: "Average Revenue Generation Index target across seasonal periods. Measures competitive set performance ambition; below 1.0 signals market share loss risk."
    - name: "avg_cancellation_rate_pct"
      expr: AVG(CAST(cancellation_rate_pct AS DOUBLE))
      comment: "Average estimated cancellation rate across seasonal periods. Demand reliability metric; high rates trigger deposit policy and overbooking strategy adjustments."
    - name: "avg_no_show_rate_pct"
      expr: AVG(CAST(no_show_rate_pct AS DOUBLE))
      comment: "Average estimated no-show rate across seasonal periods. Informs overbooking strategy and walk policy; directly impacts realized occupancy vs. forecast."
    - name: "avg_yoy_demand_variance_pct"
      expr: AVG(CAST(yoy_demand_variance_pct AS DOUBLE))
      comment: "Average year-over-year demand variance percentage. Tracks demand growth or contraction trends; negative values trigger revenue strategy intervention."
    - name: "blackout_period_count"
      expr: COUNT(DISTINCT CASE WHEN is_blackout_date = TRUE THEN seasonal_calendar_id END)
      comment: "Number of blackout date periods across the portfolio. Tracks revenue protection coverage; informs loyalty redemption capacity planning."
    - name: "max_estimated_revpar"
      expr: MAX(estimated_revpar)
      comment: "Maximum estimated RevPAR across all seasonal periods. Identifies peak revenue potential periods; used to set performance benchmarks and pricing ceilings."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_hierarchy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Organizational hierarchy and portfolio structure metrics. Used by executive leadership, finance, and operations to understand portfolio composition, reporting structure, and geographic distribution across the management hierarchy."
  source: "`travel_hospitality_ecm`.`property`.`hierarchy`"
  dimensions:
    - name: "hierarchy_level"
      expr: hierarchy_level
      comment: "Level within the organizational hierarchy (e.g., Region, Division, Brand, Property). Enables drill-down analysis from enterprise to property level."
    - name: "node_type"
      expr: node_type
      comment: "Type of hierarchy node (e.g., Geographic, Brand, Management). Distinguishes structural vs. operational hierarchy nodes."
    - name: "node_status"
      expr: node_status
      comment: "Current status of the hierarchy node (e.g., Active, Inactive, Restructured). Filters for active organizational structure."
    - name: "management_type"
      expr: management_type
      comment: "Management type for the node (e.g., Managed, Franchised, Owned). Tracks portfolio composition by management structure."
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region of the hierarchy node. Enables regional portfolio analysis and performance benchmarking."
    - name: "brand_portfolio"
      expr: brand_portfolio
      comment: "Brand portfolio grouping within the hierarchy. Supports brand-family level performance and investment analysis."
    - name: "chain_scale"
      expr: chain_scale
      comment: "Chain scale classification (e.g., Luxury, Upper Upscale, Upscale). Enables competitive set and segment-level portfolio analysis."
    - name: "is_reporting_node"
      expr: is_reporting_node
      comment: "Indicates whether the node is a designated reporting node. Filters hierarchy to official reporting structure for financial consolidation."
    - name: "kpi_rollup_method"
      expr: kpi_rollup_method
      comment: "Method used to roll up KPIs at this hierarchy node (e.g., Sum, Average, Weighted). Ensures correct aggregation logic in financial and operational reporting."
  measures:
    - name: "total_hierarchy_nodes"
      expr: COUNT(DISTINCT hierarchy_id)
      comment: "Total number of hierarchy nodes. Baseline metric for organizational structure complexity; used in restructuring and governance reviews."
    - name: "total_properties_in_hierarchy"
      expr: SUM(CAST(property_count AS BIGINT))
      comment: "Total number of properties rolled up across all hierarchy nodes. Measures portfolio scale as represented in the organizational structure."
    - name: "total_rooms_in_hierarchy"
      expr: SUM(CAST(total_room_count AS BIGINT))
      comment: "Total room count rolled up across all hierarchy nodes. Tracks capacity distribution across the organizational structure for revenue planning."
    - name: "active_node_count"
      expr: COUNT(DISTINCT CASE WHEN node_status = 'Active' THEN hierarchy_id END)
      comment: "Number of currently active hierarchy nodes. Tracks active organizational structure; changes signal restructuring events requiring reporting realignment."
    - name: "reporting_node_count"
      expr: COUNT(DISTINCT CASE WHEN is_reporting_node = TRUE THEN hierarchy_id END)
      comment: "Number of designated reporting nodes. Tracks official financial reporting structure; used in consolidation and governance compliance reviews."
$$;

CREATE OR REPLACE VIEW `travel_hospitality_ecm`.`_metrics`.`property_ownership_entity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Property ownership entity metrics covering portfolio valuation, compliance obligations, and ownership structure. Used by asset management, finance, and legal leadership to manage ownership relationships, REIT compliance, and portfolio investment performance."
  source: "`travel_hospitality_ecm`.`property`.`ownership_entity`"
  dimensions:
    - name: "entity_type"
      expr: entity_type
      comment: "Legal entity type of the ownership entity (e.g., REIT, Private Equity, Individual). Enables ownership structure analysis and compliance segmentation."
    - name: "ownership_status"
      expr: ownership_status
      comment: "Current status of the ownership entity (e.g., Active, Dissolved, Pending). Primary filter for active ownership relationships."
    - name: "reit_compliance_flag"
      expr: reit_compliance_flag
      comment: "Indicates whether the entity is subject to REIT compliance requirements. Tracks regulatory compliance obligations for real estate investment trust structures."
    - name: "sox_compliance_required"
      expr: sox_compliance_required
      comment: "Indicates whether SOX compliance is required for the entity. Tracks financial reporting control obligations for publicly accountable ownership structures."
    - name: "registered_country_code"
      expr: registered_country_code
      comment: "Country of registration for the ownership entity. Enables jurisdictional analysis of ownership structure and tax obligations."
    - name: "management_company_affiliation"
      expr: management_company_affiliation
      comment: "Management company affiliated with the ownership entity. Tracks management relationships across the ownership portfolio."
    - name: "acquisition_year"
      expr: YEAR(acquisition_date)
      comment: "Year the portfolio was acquired. Supports investment vintage analysis and hold-period performance evaluation."
  measures:
    - name: "total_ownership_entities"
      expr: COUNT(DISTINCT ownership_entity_id)
      comment: "Total number of distinct ownership entities. Baseline metric for ownership structure complexity used in asset management and legal reviews."
    - name: "total_portfolio_acquisition_value"
      expr: SUM(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Total portfolio acquisition value in USD across all ownership entities. Core asset management KPI for total invested capital tracking and ROI analysis."
    - name: "avg_portfolio_acquisition_value"
      expr: AVG(CAST(portfolio_acquisition_value_usd AS DOUBLE))
      comment: "Average portfolio acquisition value per ownership entity. Benchmarks investment scale per owner; informs relationship prioritization and asset management resource allocation."
    - name: "total_properties_owned"
      expr: SUM(CAST(total_properties_owned AS BIGINT))
      comment: "Total number of properties owned across all ownership entities. Measures portfolio scale from the ownership perspective; used in asset management capacity planning."
    - name: "reit_compliant_entity_count"
      expr: COUNT(DISTINCT CASE WHEN reit_compliance_flag = TRUE THEN ownership_entity_id END)
      comment: "Number of ownership entities subject to REIT compliance. Tracks regulatory compliance exposure; non-compliance events carry significant financial and legal penalties."
    - name: "sox_compliant_entity_count"
      expr: COUNT(DISTINCT CASE WHEN sox_compliance_required = TRUE THEN ownership_entity_id END)
      comment: "Number of ownership entities requiring SOX compliance. Tracks financial reporting control obligations; used in audit planning and compliance resource allocation."
$$;