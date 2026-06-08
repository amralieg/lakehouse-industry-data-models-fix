-- Metric views for domain: route | Business: Airlines | Version: 1 | Generated on: 2026-05-07 12:57:00

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_ask_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Ask Plan business metrics"
  source: "`airlines_ecm`.`route`.`ask_plan`"
  dimensions:
    - name: "Bilateral Agreement Code"
      expr: bilateral_agreement_code
    - name: "Codeshare Indicator"
      expr: codeshare_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Hub Spoke Classification"
      expr: hub_spoke_classification
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Plan Approval Date"
      expr: plan_approval_date
    - name: "Plan Notes"
      expr: plan_notes
    - name: "Plan Status"
      expr: plan_status
    - name: "Plan Version"
      expr: plan_version
    - name: "Planned Business Class Seats"
      expr: planned_business_class_seats
    - name: "Planned Economy Seats"
      expr: planned_economy_seats
    - name: "Planned First Class Seats"
      expr: planned_first_class_seats
    - name: "Planned Frequency"
      expr: planned_frequency
    - name: "Planned Premium Economy Seats"
      expr: planned_premium_economy_seats
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Ask Plan"
      expr: COUNT(DISTINCT ask_plan_id)
    - name: "Total Planned Ask"
      expr: SUM(planned_ask)
    - name: "Average Planned Ask"
      expr: AVG(planned_ask)
    - name: "Total Planned Block Hours"
      expr: SUM(planned_block_hours)
    - name: "Average Planned Block Hours"
      expr: AVG(planned_block_hours)
    - name: "Total Planned Cask"
      expr: SUM(planned_cask)
    - name: "Average Planned Cask"
      expr: AVG(planned_cask)
    - name: "Total Planned Rask"
      expr: SUM(planned_rask)
    - name: "Average Planned Rask"
      expr: AVG(planned_rask)
    - name: "Total Planned Yield"
      expr: SUM(planned_yield)
    - name: "Average Planned Yield"
      expr: AVG(planned_yield)
    - name: "Total Target Load Factor Percent"
      expr: SUM(target_load_factor_percent)
    - name: "Average Target Load Factor Percent"
      expr: AVG(target_load_factor_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_authority`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Authority business metrics"
  source: "`airlines_ecm`.`route`.`authority`"
  dimensions:
    - name: "Application Date"
      expr: application_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Authority Number"
      expr: authority_number
    - name: "Authority Status"
      expr: authority_status
    - name: "Authority Type"
      expr: authority_type
    - name: "Capacity Authorized"
      expr: capacity_authorized
    - name: "Cargo Permitted Flag"
      expr: cargo_permitted_flag
    - name: "Codeshare Permitted Flag"
      expr: codeshare_permitted_flag
    - name: "Conditions And Restrictions"
      expr: conditions_and_restrictions
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fifth Freedom Permitted Flag"
      expr: fifth_freedom_permitted_flag
    - name: "Frequency Limit"
      expr: frequency_limit
    - name: "Issuing Authority"
      expr: issuing_authority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Authority"
      expr: COUNT(DISTINCT authority_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_bilateral_asa`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bilateral Asa business metrics"
  source: "`airlines_ecm`.`route`.`bilateral_asa`"
  dimensions:
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Amendment Count"
      expr: amendment_count
    - name: "Cabotage Permitted"
      expr: cabotage_permitted
    - name: "Capacity Entitlement Type"
      expr: capacity_entitlement_type
    - name: "Change Of Gauge Permitted"
      expr: change_of_gauge_permitted
    - name: "Codeshare Permitted"
      expr: codeshare_permitted
    - name: "Country A Code"
      expr: country_a_code
    - name: "Country B Code"
      expr: country_b_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Designated Carriers Country A"
      expr: designated_carriers_country_a
    - name: "Designated Carriers Country B"
      expr: designated_carriers_country_b
    - name: "Dispute Resolution Mechanism"
      expr: dispute_resolution_mechanism
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bilateral Asa"
      expr: COUNT(DISTINCT bilateral_asa_id)
    - name: "Total Ask Limit Country A"
      expr: SUM(ask_limit_country_a)
    - name: "Average Ask Limit Country A"
      expr: AVG(ask_limit_country_a)
    - name: "Total Ask Limit Country B"
      expr: SUM(ask_limit_country_b)
    - name: "Average Ask Limit Country B"
      expr: AVG(ask_limit_country_b)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_block_time_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Block Time Standard business metrics"
  source: "`airlines_ecm`.`route`.`block_time_standard`"
  dimensions:
    - name: "Airborne Time Minutes"
      expr: airborne_time_minutes
    - name: "Approval Date"
      expr: approval_date
    - name: "Atc Delay Factor Minutes"
      expr: atc_delay_factor_minutes
    - name: "Block Time Standard Status"
      expr: block_time_standard_status
    - name: "Contingency Buffer Minutes"
      expr: contingency_buffer_minutes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Duty Time Minutes"
      expr: crew_duty_time_minutes
    - name: "Data Source"
      expr: data_source
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Direction"
      expr: direction
    - name: "Effective Date"
      expr: effective_date
    - name: "Etops Time Adjustment Minutes"
      expr: etops_time_adjustment_minutes
    - name: "Expiry Date"
      expr: expiry_date
    - name: "Fuel Planning Time Minutes"
      expr: fuel_planning_time_minutes
    - name: "Historical Average Block Time Minutes"
      expr: historical_average_block_time_minutes
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Block Time Standard"
      expr: COUNT(DISTINCT block_time_standard_id)
    - name: "Total Standard Deviation Minutes"
      expr: SUM(standard_deviation_minutes)
    - name: "Average Standard Deviation Minutes"
      expr: AVG(standard_deviation_minutes)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier business metrics"
  source: "`airlines_ecm`.`route`.`carrier`"
  dimensions:
    - name: "Accounting Code"
      expr: accounting_code
    - name: "Alliance Membership"
      expr: alliance_membership
    - name: "Aoc Expiry Date"
      expr: aoc_expiry_date
    - name: "Aoc Issue Date"
      expr: aoc_issue_date
    - name: "Aoc Issuing Authority"
      expr: aoc_issuing_authority
    - name: "Aoc Number"
      expr: aoc_number
    - name: "Callsign"
      expr: callsign
    - name: "Cargo Operations Flag"
      expr: cargo_operations_flag
    - name: "Carrier Name"
      expr: carrier_name
    - name: "Carrier Type"
      expr: carrier_type
    - name: "Ceased Operations Date"
      expr: ceased_operations_date
    - name: "Codeshare Participant Flag"
      expr: codeshare_participant_flag
    - name: "Commenced Operations Date"
      expr: commenced_operations_date
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Country Code"
      expr: country_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Carrier"
      expr: COUNT(DISTINCT carrier_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_city_pair`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "City Pair business metrics"
  source: "`airlines_ecm`.`route`.`city_pair`"
  dimensions:
    - name: "Active Flag"
      expr: active_flag
    - name: "Bilateral Agreement Code"
      expr: bilateral_agreement_code
    - name: "Codeshare Eligible Flag"
      expr: codeshare_eligible_flag
    - name: "Competitive Intensity"
      expr: competitive_intensity
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Destination City Code"
      expr: destination_city_code
    - name: "Destination Country Code"
      expr: destination_country_code
    - name: "Destination Iata Region"
      expr: destination_iata_region
    - name: "Directionality"
      expr: directionality
    - name: "Distance Band"
      expr: distance_band
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Etops Required Flag"
      expr: etops_required_flag
    - name: "Hub Spoke Classification"
      expr: hub_spoke_classification
    - name: "Interline Eligible Flag"
      expr: interline_eligible_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct City Pair"
      expr: COUNT(DISTINCT city_pair_id)
    - name: "Total Great Circle Distance Km"
      expr: SUM(great_circle_distance_km)
    - name: "Average Great Circle Distance Km"
      expr: AVG(great_circle_distance_km)
    - name: "Total Great Circle Distance Miles"
      expr: SUM(great_circle_distance_miles)
    - name: "Average Great Circle Distance Miles"
      expr: AVG(great_circle_distance_miles)
    - name: "Total Scheduled Distance Km"
      expr: SUM(scheduled_distance_km)
    - name: "Average Scheduled Distance Km"
      expr: AVG(scheduled_distance_km)
    - name: "Total Time Zone Difference Hours"
      expr: SUM(time_zone_difference_hours)
    - name: "Average Time Zone Difference Hours"
      expr: AVG(time_zone_difference_hours)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_codeshare_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Codeshare Agreement business metrics"
  source: "`airlines_ecm`.`route`.`codeshare_agreement`"
  dimensions:
    - name: "Agreement Code"
      expr: agreement_code
    - name: "Agreement Name"
      expr: agreement_name
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Alliance Affiliation"
      expr: alliance_affiliation
    - name: "Auto Renewal Flag"
      expr: auto_renewal_flag
    - name: "Baggage Allowance Harmonization"
      expr: baggage_allowance_harmonization
    - name: "Bilateral Agreement Reference"
      expr: bilateral_agreement_reference
    - name: "Block Space Seats"
      expr: block_space_seats
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Fare Basis Code Sharing Allowed"
      expr: fare_basis_code_sharing_allowed
    - name: "Frequent Flyer Accrual Allowed"
      expr: frequent_flyer_accrual_allowed
    - name: "Interline Ticketing Allowed"
      expr: interline_ticketing_allowed
    - name: "Inventory Control Party"
      expr: inventory_control_party
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Codeshare Agreement"
      expr: COUNT(DISTINCT codeshare_agreement_id)
    - name: "Total Marketing Carrier Share Percentage"
      expr: SUM(marketing_carrier_share_percentage)
    - name: "Average Marketing Carrier Share Percentage"
      expr: AVG(marketing_carrier_share_percentage)
    - name: "Total Operating Carrier Share Percentage"
      expr: SUM(operating_carrier_share_percentage)
    - name: "Average Operating Carrier Share Percentage"
      expr: AVG(operating_carrier_share_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_fleet_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fleet Assignment business metrics"
  source: "`airlines_ecm`.`route`.`fleet_assignment`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By User"
      expr: approved_by_user
    - name: "Assignment Code"
      expr: assignment_code
    - name: "Assignment Duration Days"
      expr: assignment_duration_days
    - name: "Assignment Priority"
      expr: assignment_priority
    - name: "Assignment Rationale"
      expr: assignment_rationale
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Assignment Type"
      expr: assignment_type
    - name: "Business Class Seats"
      expr: business_class_seats
    - name: "Codeshare Eligible Flag"
      expr: codeshare_eligible_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Of Operation"
      expr: days_of_operation
    - name: "Economy Class Seats"
      expr: economy_class_seats
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Etops Rating Minutes"
      expr: etops_rating_minutes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fleet Assignment"
      expr: COUNT(DISTINCT fleet_assignment_id)
    - name: "Total Cargo Belly Capacity Kg"
      expr: SUM(cargo_belly_capacity_kg)
    - name: "Average Cargo Belly Capacity Kg"
      expr: AVG(cargo_belly_capacity_kg)
    - name: "Total Cargo Belly Capacity M3"
      expr: SUM(cargo_belly_capacity_m3)
    - name: "Average Cargo Belly Capacity M3"
      expr: AVG(cargo_belly_capacity_m3)
    - name: "Total Planned Ask Capacity"
      expr: SUM(planned_ask_capacity)
    - name: "Average Planned Ask Capacity"
      expr: AVG(planned_ask_capacity)
    - name: "Total Target Load Factor Percent"
      expr: SUM(target_load_factor_percent)
    - name: "Average Target Load Factor Percent"
      expr: AVG(target_load_factor_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_flight_number`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flight Number business metrics"
  source: "`airlines_ecm`.`route`.`flight_number`"
  dimensions:
    - name: "Bilateral Agreement Reference"
      expr: bilateral_agreement_reference
    - name: "Block Time Minutes"
      expr: block_time_minutes
    - name: "Carrier Code"
      expr: carrier_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Direction"
      expr: direction
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Etops Certified Indicator"
      expr: etops_certified_indicator
    - name: "Flight Number"
      expr: flight_number
    - name: "Flight Number Status"
      expr: flight_number_status
    - name: "Flight Number Type"
      expr: flight_number_type
    - name: "Flight Time Minutes"
      expr: flight_time_minutes
    - name: "Frequency Pattern"
      expr: frequency_pattern
    - name: "Full Flight Number"
      expr: full_flight_number
    - name: "Gds Distribution Indicator"
      expr: gds_distribution_indicator
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Flight Number"
      expr: COUNT(DISTINCT flight_number_id)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_hub_spoke_topology`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hub Spoke Topology business metrics"
  source: "`airlines_ecm`.`route`.`hub_spoke_topology`"
  dimensions:
    - name: "Allocated Slot Time"
      expr: allocated_slot_time
    - name: "Arrival Wave End Time"
      expr: arrival_wave_end_time
    - name: "Arrival Wave Start Time"
      expr: arrival_wave_start_time
    - name: "Bilateral Agreement Reference"
      expr: bilateral_agreement_reference
    - name: "Codeshare Partner Indicator"
      expr: codeshare_partner_indicator
    - name: "Connection Bank Number"
      expr: connection_bank_number
    - name: "Daily Frequency Count"
      expr: daily_frequency_count
    - name: "Departure Wave End Time"
      expr: departure_wave_end_time
    - name: "Departure Wave Start Time"
      expr: departure_wave_start_time
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hub Tier Classification"
      expr: hub_tier_classification
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Minimum Connecting Time Minutes"
      expr: minimum_connecting_time_minutes
    - name: "Network Optimization Priority"
      expr: network_optimization_priority
    - name: "Planning System Source"
      expr: planning_system_source
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Hub Spoke Topology"
      expr: COUNT(DISTINCT hub_spoke_topology_id)
    - name: "Total Misconnect Risk Score"
      expr: SUM(misconnect_risk_score)
    - name: "Average Misconnect Risk Score"
      expr: AVG(misconnect_risk_score)
    - name: "Total Planned Ask Capacity"
      expr: SUM(planned_ask_capacity)
    - name: "Average Planned Ask Capacity"
      expr: AVG(planned_ask_capacity)
    - name: "Total Target Load Factor Percentage"
      expr: SUM(target_load_factor_percentage)
    - name: "Average Target Load Factor Percentage"
      expr: AVG(target_load_factor_percentage)
    - name: "Total Target Otp Percentage"
      expr: SUM(target_otp_percentage)
    - name: "Average Target Otp Percentage"
      expr: AVG(target_otp_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_interline_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interline Agreement business metrics"
  source: "`airlines_ecm`.`route`.`interline_agreement`"
  dimensions:
    - name: "Agreement Notes"
      expr: agreement_notes
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Alliance Membership"
      expr: alliance_membership
    - name: "Baggage Through Check Eligible"
      expr: baggage_through_check_eligible
    - name: "Codeshare Eligible"
      expr: codeshare_eligible
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "E Ticket Interline Capable"
      expr: e_ticket_interline_capable
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Frequent Flyer Accrual Eligible"
      expr: frequent_flyer_accrual_eligible
    - name: "Gds Distribution Enabled"
      expr: gds_distribution_enabled
    - name: "Irop Reprotection Eligible"
      expr: irop_reprotection_eligible
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Minimum Connecting Time Minutes"
      expr: minimum_connecting_time_minutes
    - name: "Modified By User"
      expr: modified_by_user
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Interline Agreement"
      expr: COUNT(DISTINCT interline_agreement_id)
    - name: "Total Liability Limit Sdr"
      expr: SUM(liability_limit_sdr)
    - name: "Average Liability Limit Sdr"
      expr: AVG(liability_limit_sdr)
    - name: "Total Prorate Percentage"
      expr: SUM(prorate_percentage)
    - name: "Average Prorate Percentage"
      expr: AVG(prorate_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_market_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Market Assessment business metrics"
  source: "`airlines_ecm`.`route`.`market_assessment`"
  dimensions:
    - name: "Assessment Date"
      expr: assessment_date
    - name: "Assessment Notes"
      expr: assessment_notes
    - name: "Assessment Status"
      expr: assessment_status
    - name: "Assessment Type"
      expr: assessment_type
    - name: "Bilateral Agreement Status"
      expr: bilateral_agreement_status
    - name: "Codeshare Opportunity Flag"
      expr: codeshare_opportunity_flag
    - name: "Competitor Weekly Frequencies"
      expr: competitor_weekly_frequencies
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Interline Opportunity Flag"
      expr: interline_opportunity_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Market Maturity Stage"
      expr: market_maturity_stage
    - name: "Origin Airport Code"
      expr: origin_airport_code
    - name: "Peak Season Months"
      expr: peak_season_months
    - name: "Recommended Aircraft Type"
      expr: recommended_aircraft_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Market Assessment"
      expr: COUNT(DISTINCT market_assessment_id)
    - name: "Total Airline Market Share Percent"
      expr: SUM(airline_market_share_percent)
    - name: "Average Airline Market Share Percent"
      expr: AVG(airline_market_share_percent)
    - name: "Total Average Market Fare Usd"
      expr: SUM(average_market_fare_usd)
    - name: "Average Average Market Fare Usd"
      expr: AVG(average_market_fare_usd)
    - name: "Total Business Traffic Percent"
      expr: SUM(business_traffic_percent)
    - name: "Average Business Traffic Percent"
      expr: AVG(business_traffic_percent)
    - name: "Total Competitor Capacity Ask Annual"
      expr: SUM(competitor_capacity_ask_annual)
    - name: "Average Competitor Capacity Ask Annual"
      expr: AVG(competitor_capacity_ask_annual)
    - name: "Total Connecting Traffic Percent"
      expr: SUM(connecting_traffic_percent)
    - name: "Average Connecting Traffic Percent"
      expr: AVG(connecting_traffic_percent)
    - name: "Total Growth Trend Percent Yoy"
      expr: SUM(growth_trend_percent_yoy)
    - name: "Average Growth Trend Percent Yoy"
      expr: AVG(growth_trend_percent_yoy)
    - name: "Total Leisure Traffic Percent"
      expr: SUM(leisure_traffic_percent)
    - name: "Average Leisure Traffic Percent"
      expr: AVG(leisure_traffic_percent)
    - name: "Total Od Traffic Percent"
      expr: SUM(od_traffic_percent)
    - name: "Average Od Traffic Percent"
      expr: AVG(od_traffic_percent)
    - name: "Total Revenue Opportunity Estimate Usd"
      expr: SUM(revenue_opportunity_estimate_usd)
    - name: "Average Revenue Opportunity Estimate Usd"
      expr: AVG(revenue_opportunity_estimate_usd)
    - name: "Total Seasonality Index"
      expr: SUM(seasonality_index)
    - name: "Average Seasonality Index"
      expr: AVG(seasonality_index)
    - name: "Total Total Market Passengers Annual"
      expr: SUM(total_market_passengers_annual)
    - name: "Average Total Market Passengers Annual"
      expr: AVG(total_market_passengers_annual)
    - name: "Total Vfr Traffic Percent"
      expr: SUM(vfr_traffic_percent)
    - name: "Average Vfr Traffic Percent"
      expr: AVG(vfr_traffic_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_operational_standard`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational Standard business metrics"
  source: "`airlines_ecm`.`route`.`operational_standard`"
  dimensions:
    - name: "Airborne Time Minutes"
      expr: airborne_time_minutes
    - name: "Applicable Season Code"
      expr: applicable_season_code
    - name: "Approval Date"
      expr: approval_date
    - name: "Approval Status"
      expr: approval_status
    - name: "Block Time Minutes"
      expr: block_time_minutes
    - name: "Boarding Time Minutes"
      expr: boarding_time_minutes
    - name: "Cargo Loading Time Minutes"
      expr: cargo_loading_time_minutes
    - name: "Cargo Unloading Time Minutes"
      expr: cargo_unloading_time_minutes
    - name: "Catering Time Minutes"
      expr: catering_time_minutes
    - name: "Cleaning Time Minutes"
      expr: cleaning_time_minutes
    - name: "Confidence Level"
      expr: confidence_level
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source"
      expr: data_source
    - name: "Deboarding Time Minutes"
      expr: deboarding_time_minutes
    - name: "Direction"
      expr: direction
    - name: "Effective Date"
      expr: effective_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Operational Standard"
      expr: COUNT(DISTINCT operational_standard_id)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_partnership`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Partnership business metrics"
  source: "`airlines_ecm`.`route`.`partnership`"
  dimensions:
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Antitrust Immunity Granted"
      expr: antitrust_immunity_granted
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By"
      expr: approved_by
    - name: "Auto Renewal Enabled"
      expr: auto_renewal_enabled
    - name: "Baggage Through Check Eligible"
      expr: baggage_through_check_eligible
    - name: "Block Space Seat Count"
      expr: block_space_seat_count
    - name: "Cabin Class Availability"
      expr: cabin_class_availability
    - name: "Codeshare Flight Number Range End"
      expr: codeshare_flight_number_range_end
    - name: "Codeshare Flight Number Range Start"
      expr: codeshare_flight_number_range_start
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Eticket Interline Capable"
      expr: eticket_interline_capable
    - name: "Expiry Date"
      expr: expiry_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Partnership"
      expr: COUNT(DISTINCT partnership_id)
    - name: "Total Prorate Percentage"
      expr: SUM(prorate_percentage)
    - name: "Average Prorate Percentage"
      expr: AVG(prorate_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route business metrics"
  source: "`airlines_ecm`.`route`.`route`"
  dimensions:
    - name: "Authority Type"
      expr: authority_type
    - name: "Block Time Minutes"
      expr: block_time_minutes
    - name: "Codeshare Eligible"
      expr: codeshare_eligible
    - name: "Competitive Route Indicator"
      expr: competitive_route_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Etops Rating Minutes"
      expr: etops_rating_minutes
    - name: "Etops Required"
      expr: etops_required
    - name: "Flight Time Minutes"
      expr: flight_time_minutes
    - name: "Inaugural Date"
      expr: inaugural_date
    - name: "Interline Eligible"
      expr: interline_eligible
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Number Of Competitors"
      expr: number_of_competitors
    - name: "Operating Season"
      expr: operating_season
    - name: "Planned Launch Date"
      expr: planned_launch_date
    - name: "Profitability Tier"
      expr: profitability_tier
    - name: "Route Code"
      expr: route_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Route"
      expr: COUNT(DISTINCT route_id)
    - name: "Total Average Load Factor Percent"
      expr: SUM(average_load_factor_percent)
    - name: "Average Average Load Factor Percent"
      expr: AVG(average_load_factor_percent)
    - name: "Total Average Otp Percent"
      expr: SUM(average_otp_percent)
    - name: "Average Average Otp Percent"
      expr: AVG(average_otp_percent)
    - name: "Total Distance Km"
      expr: SUM(distance_km)
    - name: "Average Distance Km"
      expr: AVG(distance_km)
    - name: "Total Distance Miles"
      expr: SUM(distance_miles)
    - name: "Average Distance Miles"
      expr: AVG(distance_miles)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_route_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route Performance business metrics"
  source: "`airlines_ecm`.`route`.`route_performance`"
  dimensions:
    - name: "Available Seats Total"
      expr: available_seats_total
    - name: "Cost Currency Code"
      expr: cost_currency_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Flights Cancelled Count"
      expr: flights_cancelled_count
    - name: "Flights Diverted Count"
      expr: flights_diverted_count
    - name: "Flights Operated Count"
      expr: flights_operated_count
    - name: "Flights Scheduled Count"
      expr: flights_scheduled_count
    - name: "Grade"
      expr: grade
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Measurement Period End Date"
      expr: measurement_period_end_date
    - name: "Measurement Period Start Date"
      expr: measurement_period_start_date
    - name: "Measurement Period Type"
      expr: measurement_period_type
    - name: "Notes"
      expr: notes
    - name: "Passengers Carried Count"
      expr: passengers_carried_count
    - name: "Revenue Currency Code"
      expr: revenue_currency_code
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Route Performance"
      expr: COUNT(DISTINCT route_performance_id)
    - name: "Total Ask"
      expr: SUM(ask)
    - name: "Average Ask"
      expr: AVG(ask)
    - name: "Total Average Block Time Minutes"
      expr: SUM(average_block_time_minutes)
    - name: "Average Average Block Time Minutes"
      expr: AVG(average_block_time_minutes)
    - name: "Total Average Delay Minutes"
      expr: SUM(average_delay_minutes)
    - name: "Average Average Delay Minutes"
      expr: AVG(average_delay_minutes)
    - name: "Total Block Time Variance Minutes"
      expr: SUM(block_time_variance_minutes)
    - name: "Average Block Time Variance Minutes"
      expr: AVG(block_time_variance_minutes)
    - name: "Total Cancellation Rate Percent"
      expr: SUM(cancellation_rate_percent)
    - name: "Average Cancellation Rate Percent"
      expr: AVG(cancellation_rate_percent)
    - name: "Total Cask"
      expr: SUM(cask)
    - name: "Average Cask"
      expr: AVG(cask)
    - name: "Total Diversion Rate Percent"
      expr: SUM(diversion_rate_percent)
    - name: "Average Diversion Rate Percent"
      expr: AVG(diversion_rate_percent)
    - name: "Total Load Factor Percent"
      expr: SUM(load_factor_percent)
    - name: "Average Load Factor Percent"
      expr: AVG(load_factor_percent)
    - name: "Total Otp Percent"
      expr: SUM(otp_percent)
    - name: "Average Otp Percent"
      expr: AVG(otp_percent)
    - name: "Total Rask"
      expr: SUM(rask)
    - name: "Average Rask"
      expr: AVG(rask)
    - name: "Total Rpk"
      expr: SUM(rpk)
    - name: "Average Rpk"
      expr: AVG(rpk)
    - name: "Total Total Cost Amount"
      expr: SUM(total_cost_amount)
    - name: "Average Total Cost Amount"
      expr: AVG(total_cost_amount)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_route_promotion`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route Promotion business metrics"
  source: "`airlines_ecm`.`route`.`route_promotion`"
  dimensions:
    - name: "Actual Booking Count"
      expr: actual_booking_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eligible Routes"
      expr: eligible_routes
    - name: "End Date"
      expr: end_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Priority Rank"
      expr: priority_rank
    - name: "Route Promotion Status"
      expr: route_promotion_status
    - name: "Start Date"
      expr: start_date
    - name: "Target Booking Count"
      expr: target_booking_count
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "End Date Month"
      expr: DATE_TRUNC('MONTH', end_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Route Promotion"
      expr: COUNT(DISTINCT route_promotion_id)
    - name: "Total Competitive Impact Score"
      expr: SUM(competitive_impact_score)
    - name: "Average Competitive Impact Score"
      expr: AVG(competitive_impact_score)
    - name: "Total Incremental Revenue"
      expr: SUM(incremental_revenue)
    - name: "Average Incremental Revenue"
      expr: AVG(incremental_revenue)
    - name: "Total Route Specific Bonus Multiplier"
      expr: SUM(route_specific_bonus_multiplier)
    - name: "Average Route Specific Bonus Multiplier"
      expr: AVG(route_specific_bonus_multiplier)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_route_slot_allocation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Route Slot Allocation business metrics"
  source: "`airlines_ecm`.`route`.`route_slot_allocation`"
  dimensions:
    - name: "Aircraft Size Category"
      expr: aircraft_size_category
    - name: "Aircraft Type Restriction"
      expr: aircraft_type_restriction
    - name: "Allocated Time"
      expr: allocated_time
    - name: "Bilateral Agreement Reference"
      expr: bilateral_agreement_reference
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Days Of Operation"
      expr: days_of_operation
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
    - name: "Environmental Restriction Flag"
      expr: environmental_restriction_flag
    - name: "Historical Precedence Flag"
      expr: historical_precedence_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Slot Allocation Timestamp"
      expr: slot_allocation_timestamp
    - name: "Slot Cancellation Reason"
      expr: slot_cancellation_reason
    - name: "Slot Conference Reference"
      expr: slot_conference_reference
    - name: "Slot Confirmation Timestamp"
      expr: slot_confirmation_timestamp
    - name: "Slot Coordination Level"
      expr: slot_coordination_level
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Route Slot Allocation"
      expr: COUNT(DISTINCT route_slot_allocation_id)
    - name: "Total Slot Priority Score"
      expr: SUM(slot_priority_score)
    - name: "Average Slot Priority Score"
      expr: AVG(slot_priority_score)
    - name: "Total Slot Usage Percentage"
      expr: SUM(slot_usage_percentage)
    - name: "Average Slot Usage Percentage"
      expr: AVG(slot_usage_percentage)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_schedule_season`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule Season business metrics"
  source: "`airlines_ecm`.`route`.`schedule_season`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Daylight Saving Transition Applicable Flag"
      expr: daylight_saving_transition_applicable_flag
    - name: "Duration Days"
      expr: duration_days
    - name: "End Date"
      expr: end_date
    - name: "Iata Schedules Conference End Date"
      expr: iata_schedules_conference_end_date
    - name: "Iata Schedules Conference Location"
      expr: iata_schedules_conference_location
    - name: "Iata Schedules Conference Start Date"
      expr: iata_schedules_conference_start_date
    - name: "Iata Season Year"
      expr: iata_season_year
    - name: "Initial Schedule Submission Deadline"
      expr: initial_schedule_submission_deadline
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Northern Hemisphere Dst End Date"
      expr: northern_hemisphere_dst_end_date
    - name: "Northern Hemisphere Dst Start Date"
      expr: northern_hemisphere_dst_start_date
    - name: "Notes"
      expr: notes
    - name: "Peak Travel Period Flag"
      expr: peak_travel_period_flag
    - name: "Schedule Season Status"
      expr: schedule_season_status
    - name: "Season Code"
      expr: season_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedule Season"
      expr: COUNT(DISTINCT schedule_season_id)
    - name: "Total Historical Use It Or Lose It Threshold Percent"
      expr: SUM(historical_use_it_or_lose_it_threshold_percent)
    - name: "Average Historical Use It Or Lose It Threshold Percent"
      expr: AVG(historical_use_it_or_lose_it_threshold_percent)
$$;

CREATE OR REPLACE VIEW `airlines_ecm`.`_metrics`.`route_seasonal_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Seasonal Schedule business metrics"
  source: "`airlines_ecm`.`route`.`seasonal_schedule`"
  dimensions:
    - name: "Aircraft Configuration Code"
      expr: aircraft_configuration_code
    - name: "Aircraft Owner"
      expr: aircraft_owner
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Arrival Time Local"
      expr: arrival_time_local
    - name: "Arrival Time Utc"
      expr: arrival_time_utc
    - name: "Block Time Minutes"
      expr: block_time_minutes
    - name: "Codeshare Indicator"
      expr: codeshare_indicator
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Change Indicator"
      expr: day_change_indicator
    - name: "Days Of Operation"
      expr: days_of_operation
    - name: "Departure Time Local"
      expr: departure_time_local
    - name: "Departure Time Utc"
      expr: departure_time_utc
    - name: "Destination Airport Code"
      expr: destination_airport_code
    - name: "Destination Terminal"
      expr: destination_terminal
    - name: "Effective From Date"
      expr: effective_from_date
    - name: "Effective To Date"
      expr: effective_to_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Seasonal Schedule"
      expr: COUNT(DISTINCT seasonal_schedule_id)
    - name: "Total Ask Planned"
      expr: SUM(ask_planned)
    - name: "Average Ask Planned"
      expr: AVG(ask_planned)
$$;