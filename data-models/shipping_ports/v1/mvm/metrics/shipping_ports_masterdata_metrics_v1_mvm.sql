-- Metric views for domain: masterdata | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_vessel_master`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPIs over the vessel master registry — fleet composition, compliance posture, capacity, and operational readiness. Used by port operations, commercial, and compliance teams to steer vessel acceptance, berth planning, and regulatory risk management."
  source: "`shipping_ports_ecm`.`masterdata`.`vessel_master`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the vessel (e.g. Active, Laid-up, Scrapped) — primary filter for fleet health dashboards."
    - name: "vessel_name"
      expr: vessel_name
      comment: "Commercial name of the vessel for vessel-level drill-down reporting."
    - name: "classification_society_code"
      expr: classification_society_code
      comment: "Classification society (e.g. Lloyd's, DNV, BV) — used to assess quality and risk profile of the fleet."
    - name: "engine_type"
      expr: engine_type
      comment: "Propulsion engine type — relevant for environmental compliance and fuel cost analysis."
    - name: "ice_class"
      expr: ice_class
      comment: "Ice class rating of the vessel — determines route eligibility for polar or ice-prone trade lanes."
    - name: "is_current_record"
      expr: is_current_record
      comment: "Flag indicating whether this is the current active version of the vessel record — used to filter out historical snapshots."
    - name: "isps_compliant"
      expr: isps_compliant
      comment: "ISPS Code compliance flag — mandatory for port entry; used in security risk dashboards."
    - name: "marpol_compliant"
      expr: marpol_compliant
      comment: "MARPOL environmental compliance flag — used for environmental risk and regulatory reporting."
    - name: "solas_compliant"
      expr: solas_compliant
      comment: "SOLAS safety compliance flag — critical for port state control and vessel acceptance decisions."
    - name: "valid_from_date"
      expr: DATE_TRUNC('YEAR', valid_from_date)
      comment: "Year the vessel record became valid — used for fleet vintage and renewal trend analysis."
    - name: "last_psc_inspection_date"
      expr: DATE_TRUNC('MONTH', last_psc_inspection_date)
      comment: "Month of last Port State Control inspection — used to identify vessels overdue for inspection."
  measures:
    - name: "total_vessels"
      expr: COUNT(DISTINCT vessel_master_id)
      comment: "Total number of distinct vessels in the registry. Baseline fleet size KPI used in capacity planning and commercial negotiations."
    - name: "total_fleet_summer_dwt"
      expr: SUM(CAST(summer_dwt AS DOUBLE))
      comment: "Aggregate summer deadweight tonnage across the fleet. Measures total cargo-carrying capacity available to the port — a primary commercial throughput indicator."
    - name: "avg_vessel_summer_dwt"
      expr: AVG(CAST(summer_dwt AS DOUBLE))
      comment: "Average summer DWT per vessel. Indicates the typical vessel size calling the port — informs berth and equipment sizing decisions."
    - name: "total_fleet_grt"
      expr: SUM(CAST(grt AS DOUBLE))
      comment: "Total gross registered tonnage of the fleet. Used for port dues calculation, berth allocation, and regulatory reporting."
    - name: "avg_vessel_loa_meters"
      expr: AVG(CAST(loa_meters AS DOUBLE))
      comment: "Average length overall (LOA) of vessels in the registry. Drives berth length planning and infrastructure investment decisions."
    - name: "avg_maximum_draft_meters"
      expr: AVG(CAST(maximum_draft_meters AS DOUBLE))
      comment: "Average maximum draft across the fleet. Critical for channel depth management and dredging investment prioritisation."
    - name: "total_propulsion_power_kw"
      expr: SUM(CAST(propulsion_power_kw AS DOUBLE))
      comment: "Total installed propulsion power across the fleet in kilowatts. Proxy for fleet modernity and fuel/emissions exposure."
    - name: "avg_propulsion_power_kw"
      expr: AVG(CAST(propulsion_power_kw AS DOUBLE))
      comment: "Average propulsion power per vessel. Used to benchmark fleet modernity and assess environmental upgrade requirements."
    - name: "isps_compliant_vessel_count"
      expr: COUNT(CASE WHEN isps_compliant = TRUE THEN vessel_master_id END)
      comment: "Number of vessels that are ISPS Code compliant. Non-compliant vessels cannot enter ISPS-designated port facilities — a direct operational risk metric."
    - name: "marpol_compliant_vessel_count"
      expr: COUNT(CASE WHEN marpol_compliant = TRUE THEN vessel_master_id END)
      comment: "Number of vessels compliant with MARPOL environmental regulations. Drives environmental risk exposure and potential port surcharge revenue."
    - name: "solas_compliant_vessel_count"
      expr: COUNT(CASE WHEN solas_compliant = TRUE THEN vessel_master_id END)
      comment: "Number of vessels compliant with SOLAS safety conventions. Non-compliant vessels are subject to detention — a key port state control risk indicator."
    - name: "avg_beam_meters"
      expr: AVG(CAST(beam_meters AS DOUBLE))
      comment: "Average vessel beam in metres. Determines berth width requirements and crane outreach planning for terminal infrastructure."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_port_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Infrastructure capacity and operational readiness KPIs for port locations — berths, water depth, vessel size limits, and yard capacity. Used by port planners, commercial teams, and infrastructure investment committees."
  source: "`shipping_ports_ecm`.`masterdata`.`port_location`"
  dimensions:
    - name: "location_type"
      expr: location_type
      comment: "Type of port location (e.g. Berth, Yard, Gate, Anchorage) — primary grouping for infrastructure analysis."
    - name: "location_zone"
      expr: location_zone
      comment: "Operational zone within the port — used for spatial capacity planning and zone-level performance reporting."
    - name: "location_area"
      expr: location_area
      comment: "Physical area designation within the terminal — supports granular infrastructure utilisation analysis."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the location (e.g. Active, Under Maintenance, Decommissioned) — filters for live capacity reporting."
    - name: "crane_type"
      expr: crane_type
      comment: "Type of crane installed at the location — used to match vessel type requirements to berth capabilities."
    - name: "isps_security_level"
      expr: isps_security_level
      comment: "ISPS security level assigned to the location — used in security compliance and vessel acceptance workflows."
    - name: "environmental_zone"
      expr: environmental_zone
      comment: "Environmental zone classification — relevant for emissions control area (ECA) compliance and environmental reporting."
    - name: "rfid_enabled"
      expr: rfid_enabled
      comment: "Whether the location has RFID tracking enabled — indicates digitisation maturity and cargo visibility capability."
    - name: "shore_crane_coverage"
      expr: shore_crane_coverage
      comment: "Whether shore crane coverage is available at this location — determines container handling capability."
    - name: "commissioning_date"
      expr: DATE_TRUNC('YEAR', commissioning_date)
      comment: "Year the location was commissioned — used for infrastructure age analysis and capital replacement planning."
    - name: "fender_type"
      expr: fender_type
      comment: "Type of fender system installed — relevant for vessel compatibility and berth safety assessments."
  measures:
    - name: "total_port_locations"
      expr: COUNT(DISTINCT port_location_id)
      comment: "Total number of distinct port locations in the registry. Baseline infrastructure inventory count used in capacity planning."
    - name: "avg_water_depth_meters"
      expr: AVG(CAST(water_depth_meters AS DOUBLE))
      comment: "Average water depth across port locations in metres. Determines the maximum vessel draft that can be accommodated — a critical infrastructure constraint for large vessel acceptance."
    - name: "max_water_depth_meters"
      expr: MAX(CAST(water_depth_meters AS DOUBLE))
      comment: "Maximum water depth available across all port locations. Indicates the deepest berth available — used in marketing to ultra-large vessel operators."
    - name: "avg_maximum_vessel_loa_meters"
      expr: AVG(CAST(maximum_vessel_loa_meters AS DOUBLE))
      comment: "Average maximum vessel LOA (length overall) that can be accommodated. Drives berth length investment decisions and vessel size acceptance policies."
    - name: "avg_maximum_vessel_dwt_tonnes"
      expr: AVG(CAST(maximum_vessel_dwt_tonnes AS DOUBLE))
      comment: "Average maximum vessel DWT that can be handled. Indicates the cargo throughput ceiling per berth — a key commercial capacity metric."
    - name: "total_bollard_swl_tonnes"
      expr: SUM(CAST(bollard_swl_tonnes AS DOUBLE))
      comment: "Total safe working load across all bollards in the port. Measures the aggregate mooring capacity — relevant for simultaneous large-vessel berthing scenarios."
    - name: "avg_fender_energy_absorption_kj"
      expr: AVG(CAST(fender_energy_absorption_kj AS DOUBLE))
      comment: "Average fender energy absorption capacity in kilojoules. Indicates the port's ability to safely handle larger, heavier vessels — an infrastructure safety and investment metric."
    - name: "avg_maximum_vessel_beam_meters"
      expr: AVG(CAST(maximum_vessel_beam_meters AS DOUBLE))
      comment: "Average maximum vessel beam that can be accommodated across berths. Used to assess compatibility with wide-beam ultra-large container vessels (ULCVs)."
    - name: "rfid_enabled_location_count"
      expr: COUNT(CASE WHEN rfid_enabled = TRUE THEN port_location_id END)
      comment: "Number of port locations with RFID tracking enabled. Measures digital infrastructure coverage — a proxy for cargo visibility and operational efficiency maturity."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_vessel_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel type classification KPIs covering capacity ranges, physical dimensions, and operational capability flags. Used by commercial, operations, and infrastructure teams to align port capabilities with vessel type mix."
  source: "`shipping_ports_ecm`.`masterdata`.`vessel_type`"
  dimensions:
    - name: "vessel_category"
      expr: vessel_category
      comment: "High-level vessel category (e.g. Container, Bulk, Tanker, RoRo) — primary grouping for fleet mix and commercial strategy analysis."
    - name: "vessel_type_name"
      expr: vessel_type_name
      comment: "Descriptive name of the vessel type — used for detailed vessel type reporting and tariff classification."
    - name: "vessel_type_status"
      expr: vessel_type_status
      comment: "Current status of the vessel type record (e.g. Active, Deprecated) — filters for live classification data."
    - name: "requires_pilotage"
      expr: requires_pilotage
      comment: "Whether vessels of this type require pilotage — drives pilotage revenue forecasting and resource planning."
    - name: "requires_towage"
      expr: requires_towage
      comment: "Whether vessels of this type require towage — drives tug fleet sizing and towage revenue projections."
    - name: "dangerous_goods_capable"
      expr: dangerous_goods_capable
      comment: "Whether the vessel type is certified to carry dangerous goods — used in hazmat berth allocation and compliance planning."
    - name: "environmental_category"
      expr: environmental_category
      comment: "Environmental classification of the vessel type — used for emissions reporting and ECA surcharge applicability."
    - name: "marpol_annex_reference"
      expr: marpol_annex_reference
      comment: "MARPOL annex applicable to this vessel type — used for environmental compliance categorisation and regulatory reporting."
    - name: "vts_tracking_required"
      expr: vts_tracking_required
      comment: "Whether Vessel Traffic Service tracking is required — relevant for port VTS resource planning and safety compliance."
  measures:
    - name: "total_vessel_types"
      expr: COUNT(DISTINCT vessel_type_id)
      comment: "Total number of distinct vessel types in the classification registry. Baseline count for fleet diversity and tariff schedule coverage assessment."
    - name: "avg_typical_dwt_max"
      expr: AVG(CAST(typical_dwt_max AS DOUBLE))
      comment: "Average upper bound of typical DWT range across vessel types. Indicates the cargo capacity ceiling the port's vessel mix can deliver — a strategic throughput planning metric."
    - name: "avg_typical_dwt_min"
      expr: AVG(CAST(typical_dwt_min AS DOUBLE))
      comment: "Average lower bound of typical DWT range across vessel types. Used alongside avg_typical_dwt_max to understand the DWT spread of the port's vessel type portfolio."
    - name: "avg_typical_loa_max_m"
      expr: AVG(CAST(typical_loa_max_m AS DOUBLE))
      comment: "Average maximum LOA across vessel types. Drives berth length infrastructure planning and determines compatibility with port facilities."
    - name: "avg_typical_draft_max_m"
      expr: AVG(CAST(typical_draft_max_m AS DOUBLE))
      comment: "Average maximum draft across vessel types. Critical for channel and berth depth planning — directly linked to dredging investment decisions."
    - name: "avg_typical_grt_max"
      expr: AVG(CAST(typical_grt_max AS DOUBLE))
      comment: "Average maximum GRT across vessel types. Used for port dues revenue modelling and berth allocation prioritisation."
    - name: "pilotage_required_type_count"
      expr: COUNT(CASE WHEN requires_pilotage = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types requiring pilotage. Drives pilotage service demand forecasting and pilot resource planning."
    - name: "towage_required_type_count"
      expr: COUNT(CASE WHEN requires_towage = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types requiring towage. Drives tug fleet sizing decisions and towage revenue projections."
    - name: "dangerous_goods_capable_type_count"
      expr: COUNT(CASE WHEN dangerous_goods_capable = TRUE THEN vessel_type_id END)
      comment: "Number of vessel types certified for dangerous goods carriage. Informs hazmat berth allocation capacity and IMDG compliance planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_shipping_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commercial and operational KPIs for shipping line (carrier) master data — fleet capacity, call frequency, compliance posture, and EDI integration maturity. Used by commercial, operations, and compliance teams to manage carrier relationships and port revenue."
  source: "`shipping_ports_ecm`.`masterdata`.`shipping_line`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the shipping line (e.g. Active, Suspended) — primary filter for live carrier reporting."
    - name: "alliance_membership"
      expr: alliance_membership
      comment: "Shipping alliance the carrier belongs to (e.g. 2M, THE Alliance, Ocean Alliance) — used for alliance-level volume and revenue analysis."
    - name: "service_type"
      expr: service_type
      comment: "Type of shipping service offered (e.g. Feeder, Mainline, Regional) — used to segment carrier revenue and volume contributions."
    - name: "fleet_size_category"
      expr: fleet_size_category
      comment: "Categorical fleet size of the carrier (e.g. Small, Medium, Large, Mega) — used for commercial tiering and negotiation strategy."
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating of the shipping line — used for financial risk assessment and payment terms decisions."
    - name: "iso_certification_status"
      expr: iso_certification_status
      comment: "ISO certification status of the carrier — used in quality and compliance vendor assessments."
    - name: "isps_compliant_flag"
      expr: isps_compliant_flag
      comment: "Whether the shipping line is ISPS Code compliant — mandatory for port access; a security risk indicator."
    - name: "edi_enabled_flag"
      expr: edi_enabled_flag
      comment: "Whether the carrier has EDI integration enabled — indicates digital connectivity maturity and operational efficiency potential."
    - name: "dangerous_goods_approved_flag"
      expr: dangerous_goods_approved_flag
      comment: "Whether the carrier is approved to handle dangerous goods — used in hazmat cargo acceptance and berth planning."
    - name: "reefer_capable_flag"
      expr: reefer_capable_flag
      comment: "Whether the carrier can handle refrigerated cargo — used in reefer plug capacity planning and commercial targeting."
    - name: "tariff_group_code"
      expr: tariff_group_code
      comment: "Tariff group assigned to the carrier — used for revenue classification and tariff schedule management."
    - name: "service_commencement_date"
      expr: DATE_TRUNC('YEAR', service_commencement_date)
      comment: "Year the carrier commenced service at the port — used for carrier tenure and relationship longevity analysis."
  measures:
    - name: "total_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Total number of distinct shipping lines in the registry. Baseline carrier portfolio count — used in commercial diversity and concentration risk analysis."
    - name: "total_avg_teu_per_call"
      expr: SUM(CAST(average_teu_per_call AS DOUBLE))
      comment: "Sum of average TEU per call across all carriers. Proxy for total TEU throughput potential from the carrier portfolio — a primary commercial volume metric."
    - name: "avg_teu_per_call"
      expr: AVG(CAST(average_teu_per_call AS DOUBLE))
      comment: "Average TEU per vessel call across all shipping lines. Indicates typical vessel utilisation and cargo density — used to benchmark carrier productivity."
    - name: "avg_vessel_calls_per_month"
      expr: AVG(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Average number of vessel calls per month across all carriers. Drives berth scheduling demand forecasting and resource planning."
    - name: "total_vessel_calls_per_month"
      expr: SUM(CAST(average_vessel_calls_per_month AS DOUBLE))
      comment: "Total expected vessel calls per month across all active carriers. Primary berth demand and port throughput planning metric."
    - name: "edi_enabled_carrier_count"
      expr: COUNT(CASE WHEN edi_enabled_flag = TRUE THEN shipping_line_id END)
      comment: "Number of carriers with EDI integration enabled. Measures digital connectivity coverage — directly linked to documentation processing efficiency and error reduction."
    - name: "dangerous_goods_approved_carrier_count"
      expr: COUNT(CASE WHEN dangerous_goods_approved_flag = TRUE THEN shipping_line_id END)
      comment: "Number of carriers approved for dangerous goods handling. Determines hazmat cargo acceptance capacity and IMDG compliance exposure."
    - name: "reefer_capable_carrier_count"
      expr: COUNT(CASE WHEN reefer_capable_flag = TRUE THEN shipping_line_id END)
      comment: "Number of carriers capable of handling refrigerated cargo. Drives reefer plug infrastructure investment and cold chain commercial strategy."
    - name: "isps_compliant_carrier_count"
      expr: COUNT(CASE WHEN isps_compliant_flag = TRUE THEN shipping_line_id END)
      comment: "Number of ISPS-compliant carriers. Non-compliant carriers cannot access ISPS-designated facilities — a direct security risk and revenue exposure metric."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_cargo_category`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo category master data KPIs covering handling complexity, regulatory requirements, and storage characteristics. Used by operations, compliance, and commercial teams to manage cargo acceptance policies and tariff structures."
  source: "`shipping_ports_ecm`.`masterdata`.`cargo_category`"
  dimensions:
    - name: "category_type"
      expr: category_type
      comment: "High-level cargo category type (e.g. General, Hazardous, Reefer, OOG) — primary grouping for cargo mix and handling complexity analysis."
    - name: "category_name"
      expr: category_name
      comment: "Descriptive name of the cargo category — used for operational reporting and tariff schedule management."
    - name: "active_flag"
      expr: active_flag
      comment: "Whether the cargo category is currently active — filters for live cargo acceptance policy reporting."
    - name: "storage_area_type"
      expr: storage_area_type
      comment: "Type of storage area required (e.g. Open Yard, Covered Shed, Reefer Block) — drives yard capacity planning and infrastructure investment."
    - name: "handling_method"
      expr: handling_method
      comment: "Method of cargo handling (e.g. Crane, Forklift, Conveyor) — used for equipment planning and operational cost modelling."
    - name: "environmental_risk_level"
      expr: environmental_risk_level
      comment: "Environmental risk classification of the cargo category — used for environmental compliance reporting and risk-based surcharge decisions."
    - name: "security_level"
      expr: security_level
      comment: "Security level required for this cargo category — used in ISPS compliance planning and secure storage allocation."
    - name: "imdg_applicable"
      expr: imdg_applicable
      comment: "Whether IMDG dangerous goods regulations apply — used to identify hazmat cargo categories requiring special handling."
    - name: "reefer_capable"
      expr: reefer_capable
      comment: "Whether the cargo category requires or supports refrigerated handling — drives reefer infrastructure planning."
    - name: "oog_capable"
      expr: oog_capable
      comment: "Whether the cargo category includes out-of-gauge (OOG) cargo — drives specialised equipment and berth planning."
    - name: "demurrage_applicable"
      expr: demurrage_applicable
      comment: "Whether demurrage charges apply to this cargo category — used in revenue management and customer contract analysis."
    - name: "tariff_group_code"
      expr: tariff_group_code
      comment: "Tariff group assigned to the cargo category — used for revenue classification and tariff schedule management."
    - name: "stowage_priority"
      expr: stowage_priority
      comment: "Stowage priority level for this cargo category — used in vessel planning and yard management optimisation."
  measures:
    - name: "total_cargo_categories"
      expr: COUNT(DISTINCT cargo_category_id)
      comment: "Total number of distinct cargo categories in the master registry. Baseline count for cargo acceptance policy coverage and tariff schedule completeness."
    - name: "avg_teu_conversion_factor"
      expr: AVG(CAST(teu_conversion_factor AS DOUBLE))
      comment: "Average TEU conversion factor across cargo categories. Used to normalise cargo volumes to TEU equivalents for throughput reporting and capacity planning."
    - name: "imdg_applicable_category_count"
      expr: COUNT(CASE WHEN imdg_applicable = TRUE THEN cargo_category_id END)
      comment: "Number of cargo categories subject to IMDG dangerous goods regulations. Measures hazmat cargo exposure — drives compliance resource allocation and specialised handling investment."
    - name: "reefer_capable_category_count"
      expr: COUNT(CASE WHEN reefer_capable = TRUE THEN cargo_category_id END)
      comment: "Number of cargo categories requiring refrigerated handling. Drives reefer plug capacity planning and cold chain infrastructure investment decisions."
    - name: "oog_capable_category_count"
      expr: COUNT(CASE WHEN oog_capable = TRUE THEN cargo_category_id END)
      comment: "Number of out-of-gauge capable cargo categories. Informs specialised lifting equipment requirements and OOG berth allocation planning."
    - name: "demurrage_applicable_category_count"
      expr: COUNT(CASE WHEN demurrage_applicable = TRUE THEN cargo_category_id END)
      comment: "Number of cargo categories where demurrage charges apply. Used in revenue management to quantify demurrage income potential and customer contract risk."
    - name: "special_handling_required_category_count"
      expr: COUNT(CASE WHEN special_handling_required = TRUE THEN cargo_category_id END)
      comment: "Number of cargo categories requiring special handling. Drives operational complexity assessment and specialised labour/equipment cost planning."
    - name: "quarantine_inspection_required_category_count"
      expr: COUNT(CASE WHEN quarantine_inspection_required = TRUE THEN cargo_category_id END)
      comment: "Number of cargo categories requiring quarantine inspection. Informs biosecurity resource planning and customs dwell time modelling."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_equipment_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment type master data KPIs covering capacity, performance, energy consumption, and compliance characteristics. Used by terminal operations, maintenance, and sustainability teams to optimise equipment fleet composition and investment."
  source: "`shipping_ports_ecm`.`masterdata`.`equipment_type`"
  dimensions:
    - name: "equipment_category"
      expr: equipment_category
      comment: "High-level equipment category (e.g. Crane, Straddle Carrier, Reach Stacker, AGV) — primary grouping for fleet composition analysis."
    - name: "equipment_subcategory"
      expr: equipment_subcategory
      comment: "Sub-category of equipment — used for granular fleet planning and maintenance scheduling."
    - name: "equipment_type_status"
      expr: equipment_type_status
      comment: "Current status of the equipment type (e.g. Active, Phased Out) — filters for live equipment planning data."
    - name: "power_type"
      expr: power_type
      comment: "Power source type (e.g. Electric, Diesel, Hybrid) — used for energy cost modelling and emissions reduction planning."
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation (e.g. Manual, Semi-Automated, Fully Automated) — used to assess terminal modernisation maturity and labour cost impact."
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Equipment manufacturer — used for vendor concentration risk analysis and procurement strategy."
    - name: "emission_standard"
      expr: emission_standard
      comment: "Emission standard compliance level (e.g. Tier 4, Stage V) — used for environmental compliance reporting and green port certification."
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Whether the equipment type meets current environmental compliance standards — used in sustainability reporting and regulatory risk management."
    - name: "iot_sensor_enabled_flag"
      expr: iot_sensor_enabled_flag
      comment: "Whether the equipment type has IoT sensors enabled — measures digital infrastructure maturity and predictive maintenance readiness."
    - name: "gps_tracking_enabled_flag"
      expr: gps_tracking_enabled_flag
      comment: "Whether GPS tracking is enabled — indicates real-time asset visibility capability for operational efficiency."
    - name: "certification_required_flag"
      expr: certification_required_flag
      comment: "Whether operator certification is required for this equipment type — drives training investment and compliance cost planning."
  measures:
    - name: "total_equipment_types"
      expr: COUNT(DISTINCT equipment_type_id)
      comment: "Total number of distinct equipment types in the registry. Baseline fleet type diversity count used in procurement and maintenance planning."
    - name: "avg_swl_rating_tonnes"
      expr: AVG(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Average safe working load (SWL) rating in tonnes across equipment types. Indicates the typical lifting capacity of the terminal fleet — a key throughput and vessel compatibility metric."
    - name: "max_swl_rating_tonnes"
      expr: MAX(CAST(swl_rating_tonnes AS DOUBLE))
      comment: "Maximum SWL rating available in the equipment fleet. Determines the heaviest lifts the terminal can perform — critical for OOG and heavy-lift cargo acceptance decisions."
    - name: "avg_fuel_consumption_litres_per_hour"
      expr: AVG(CAST(fuel_consumption_litres_per_hour AS DOUBLE))
      comment: "Average fuel consumption per hour across equipment types. Primary operational cost and emissions intensity metric — used in energy cost budgeting and decarbonisation planning."
    - name: "avg_power_consumption_kw"
      expr: AVG(CAST(power_consumption_kw AS DOUBLE))
      comment: "Average power consumption in kilowatts across equipment types. Used for energy infrastructure planning and electricity cost modelling for electric/hybrid fleets."
    - name: "avg_lift_height_metres"
      expr: AVG(CAST(lift_height_metres AS DOUBLE))
      comment: "Average lift height in metres across equipment types. Determines stacking tier capability — directly linked to yard density and storage capacity optimisation."
    - name: "avg_operational_speed_kmh"
      expr: AVG(CAST(operational_speed_kmh AS DOUBLE))
      comment: "Average operational speed in km/h across equipment types. Proxy for equipment productivity and cycle time — used in moves-per-hour benchmarking."
    - name: "avg_outreach_metres"
      expr: AVG(CAST(outreach_metres AS DOUBLE))
      comment: "Average crane outreach in metres. Determines the maximum vessel beam that can be served — a critical infrastructure constraint for ULCV acceptance."
    - name: "iot_enabled_equipment_type_count"
      expr: COUNT(CASE WHEN iot_sensor_enabled_flag = TRUE THEN equipment_type_id END)
      comment: "Number of equipment types with IoT sensors enabled. Measures predictive maintenance and real-time monitoring coverage — a digital transformation maturity KPI."
    - name: "environmentally_compliant_equipment_type_count"
      expr: COUNT(CASE WHEN environmental_compliance_flag = TRUE THEN equipment_type_id END)
      comment: "Number of equipment types meeting current environmental compliance standards. Used in green port certification reporting and regulatory risk management."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_flag_state`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Flag state registry KPIs covering compliance posture, PSC risk, fleet size, and international convention ratification. Used by port state control, compliance, and commercial teams to assess vessel risk profiles and manage flag state relationships."
  source: "`shipping_ports_ecm`.`masterdata`.`flag_state`"
  dimensions:
    - name: "active_status"
      expr: active_status
      comment: "Current active status of the flag state record — filters for live flag state data in compliance reporting."
    - name: "registry_type"
      expr: registry_type
      comment: "Type of ship registry (e.g. Open, Closed, Second) — used to assess flag of convenience risk and regulatory oversight quality."
    - name: "flag_of_convenience"
      expr: flag_of_convenience
      comment: "Whether the flag state is classified as a flag of convenience — a primary risk indicator for PSC targeting and vessel acceptance decisions."
    - name: "psc_list_classification"
      expr: psc_list_classification
      comment: "PSC performance list classification (e.g. White, Grey, Black list) — the most critical risk indicator for port state control targeting."
    - name: "risk_rating"
      expr: risk_rating
      comment: "Overall risk rating assigned to the flag state — used in vessel acceptance, insurance, and compliance risk scoring."
    - name: "imo_member_status"
      expr: imo_member_status
      comment: "IMO membership status of the flag state — used to assess regulatory oversight quality and convention compliance."
    - name: "marpol_ratified"
      expr: marpol_ratified
      comment: "Whether the flag state has ratified MARPOL — used in environmental compliance risk assessment."
    - name: "solas_ratified"
      expr: solas_ratified
      comment: "Whether the flag state has ratified SOLAS — used in safety compliance risk assessment and vessel acceptance decisions."
    - name: "mlc_ratified"
      expr: mlc_ratified
      comment: "Whether the flag state has ratified the Maritime Labour Convention — used in crew welfare compliance and PSC inspection targeting."
    - name: "paris_mou_member"
      expr: paris_mou_member
      comment: "Whether the flag state is a Paris MOU member — indicates participation in European PSC regime."
    - name: "tokyo_mou_member"
      expr: tokyo_mou_member
      comment: "Whether the flag state is a Tokyo MOU member — indicates participation in Asia-Pacific PSC regime."
  measures:
    - name: "total_flag_states"
      expr: COUNT(DISTINCT flag_state_id)
      comment: "Total number of distinct flag states in the registry. Baseline count for flag state portfolio coverage and PSC risk exposure breadth."
    - name: "total_registered_dwt"
      expr: SUM(CAST(total_registered_dwt AS DOUBLE))
      comment: "Total deadweight tonnage registered across all flag states. Measures the aggregate cargo capacity of the flagged fleet — a strategic indicator of flag state commercial significance."
    - name: "total_registered_grt"
      expr: SUM(CAST(total_registered_grt AS DOUBLE))
      comment: "Total gross registered tonnage across all flag states. Used for port dues revenue modelling and flag state fleet size benchmarking."
    - name: "avg_psc_targeting_factor"
      expr: AVG(CAST(psc_targeting_factor AS DOUBLE))
      comment: "Average PSC targeting factor across flag states. Indicates the overall risk level of the flag state portfolio — a key metric for port state control resource planning and vessel inspection prioritisation."
    - name: "max_psc_targeting_factor"
      expr: MAX(CAST(psc_targeting_factor AS DOUBLE))
      comment: "Maximum PSC targeting factor in the flag state registry. Identifies the highest-risk flag state — used to trigger enhanced inspection protocols and vessel acceptance reviews."
    - name: "flag_of_convenience_count"
      expr: COUNT(CASE WHEN flag_of_convenience = TRUE THEN flag_state_id END)
      comment: "Number of flag states classified as flags of convenience. Measures the port's exposure to higher-risk registries — used in PSC targeting strategy and insurance risk assessment."
    - name: "marpol_ratified_flag_state_count"
      expr: COUNT(CASE WHEN marpol_ratified = TRUE THEN flag_state_id END)
      comment: "Number of flag states that have ratified MARPOL. Used to assess environmental compliance coverage of the flag state portfolio."
    - name: "solas_ratified_flag_state_count"
      expr: COUNT(CASE WHEN solas_ratified = TRUE THEN flag_state_id END)
      comment: "Number of flag states that have ratified SOLAS. Measures safety convention coverage — a key indicator of fleet safety risk exposure."
    - name: "mlc_ratified_flag_state_count"
      expr: COUNT(CASE WHEN mlc_ratified = TRUE THEN flag_state_id END)
      comment: "Number of flag states that have ratified the Maritime Labour Convention. Used in crew welfare compliance reporting and PSC inspection planning."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_commodity_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity code master data KPIs covering hazardous goods classification, regulatory requirements, and temperature control characteristics. Used by customs, compliance, and commercial teams to manage cargo acceptance, tariff classification, and regulatory risk."
  source: "`shipping_ports_ecm`.`masterdata`.`commodity_code`"
  dimensions:
    - name: "commodity_code_status"
      expr: commodity_code_status
      comment: "Current status of the commodity code (e.g. Active, Deprecated) — filters for live commodity classification data."
    - name: "hs_chapter"
      expr: hs_chapter
      comment: "Harmonised System chapter — primary grouping for customs tariff and trade statistics reporting."
    - name: "marpol_category"
      expr: marpol_category
      comment: "MARPOL pollution category of the commodity — used for environmental risk classification and spill response planning."
    - name: "packing_group"
      expr: packing_group
      comment: "IMDG packing group (I, II, III) — indicates hazard severity level; used in dangerous goods handling and stowage planning."
    - name: "storage_area_type"
      expr: storage_area_type
      comment: "Required storage area type for the commodity — drives yard planning and specialised storage infrastructure investment."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether the commodity requires temperature-controlled storage or transport — drives reefer infrastructure planning."
    - name: "marine_pollutant"
      expr: marine_pollutant
      comment: "Whether the commodity is classified as a marine pollutant — used in environmental risk management and MARPOL compliance reporting."
    - name: "prohibited_goods_flag"
      expr: prohibited_goods_flag
      comment: "Whether the commodity is classified as prohibited goods — used in cargo acceptance control and customs compliance."
    - name: "export_license_required"
      expr: export_license_required
      comment: "Whether an export licence is required for this commodity — used in customs compliance and trade facilitation reporting."
    - name: "import_license_required"
      expr: import_license_required
      comment: "Whether an import licence is required — used in customs compliance and cargo clearance time modelling."
    - name: "wco_control_flag"
      expr: wco_control_flag
      comment: "Whether the commodity is subject to WCO control — used in customs risk profiling and inspection resource planning."
    - name: "valid_from_date"
      expr: DATE_TRUNC('YEAR', valid_from_date)
      comment: "Year the commodity code became valid — used for HS code revision cycle analysis and tariff schedule maintenance."
  measures:
    - name: "total_commodity_codes"
      expr: COUNT(DISTINCT commodity_code_id)
      comment: "Total number of distinct commodity codes in the registry. Baseline count for tariff schedule coverage and customs classification completeness."
    - name: "avg_tariff_rate_percent"
      expr: AVG(CAST(tariff_rate_percent AS DOUBLE))
      comment: "Average tariff rate percentage across commodity codes. Used in trade cost modelling and revenue forecasting for port-related customs services."
    - name: "avg_flash_point_celsius"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point temperature across applicable commodity codes. Used in fire safety risk assessment and hazmat storage planning for flammable goods."
    - name: "avg_temperature_range_max_celsius"
      expr: AVG(CAST(temperature_range_max_celsius AS DOUBLE))
      comment: "Average maximum temperature threshold across temperature-controlled commodities. Used in reefer infrastructure specification and cold chain compliance planning."
    - name: "avg_temperature_range_min_celsius"
      expr: AVG(CAST(temperature_range_min_celsius AS DOUBLE))
      comment: "Average minimum temperature threshold across temperature-controlled commodities. Used alongside avg_temperature_range_max_celsius to define reefer operating range requirements."
    - name: "marine_pollutant_commodity_count"
      expr: COUNT(CASE WHEN marine_pollutant = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes classified as marine pollutants. Measures environmental risk exposure in the cargo portfolio — used in MARPOL compliance and spill contingency planning."
    - name: "prohibited_goods_commodity_count"
      expr: COUNT(CASE WHEN prohibited_goods_flag = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes flagged as prohibited goods. Used in cargo acceptance control and customs compliance risk reporting."
    - name: "temperature_controlled_commodity_count"
      expr: COUNT(CASE WHEN temperature_controlled = TRUE THEN commodity_code_id END)
      comment: "Number of temperature-controlled commodity codes. Drives reefer plug capacity planning and cold chain infrastructure investment decisions."
    - name: "export_license_required_commodity_count"
      expr: COUNT(CASE WHEN export_license_required = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes requiring export licences. Used in trade compliance resource planning and cargo clearance time modelling."
    - name: "wco_controlled_commodity_count"
      expr: COUNT(CASE WHEN wco_control_flag = TRUE THEN commodity_code_id END)
      comment: "Number of commodity codes subject to WCO control. Measures customs inspection workload exposure and compliance resource requirements."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_service_code`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service code master data KPIs covering tariff rates, billing characteristics, and service portfolio composition. Used by commercial, finance, and operations teams to manage port service pricing, revenue classification, and tariff schedule governance."
  source: "`shipping_ports_ecm`.`masterdata`.`service_code`"
  dimensions:
    - name: "service_category"
      expr: service_category
      comment: "High-level service category (e.g. Stevedoring, Pilotage, Storage, Towage) — primary grouping for revenue analysis and tariff schedule management."
    - name: "service_status"
      expr: service_status
      comment: "Current status of the service code (e.g. Active, Discontinued) — filters for live tariff schedule reporting."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the service code — used in tariff governance and change management reporting."
    - name: "billing_basis"
      expr: billing_basis
      comment: "Basis on which the service is billed (e.g. Per TEU, Per Move, Per Hour, Per Day) — used in revenue modelling and invoice accuracy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the service is priced — used for multi-currency revenue reporting and FX exposure analysis."
    - name: "uom_code"
      expr: uom_code
      comment: "Unit of measure for the service charge — used in billing accuracy and tariff schedule consistency checks."
    - name: "tax_applicable_flag"
      expr: tax_applicable_flag
      comment: "Whether tax applies to this service — used in revenue net/gross analysis and tax compliance reporting."
    - name: "surcharge_applicable_flag"
      expr: surcharge_applicable_flag
      comment: "Whether surcharges can be applied to this service — used in revenue uplift analysis and commercial negotiation."
    - name: "discount_eligible_flag"
      expr: discount_eligible_flag
      comment: "Whether discounts can be applied to this service — used in commercial pricing strategy and margin management."
    - name: "is_bundled_service"
      expr: is_bundled_service
      comment: "Whether this is a bundled service offering — used in revenue recognition and tariff unbundling analysis."
    - name: "service_owner_department"
      expr: service_owner_department
      comment: "Department responsible for the service — used for departmental revenue attribution and P&L reporting."
    - name: "valid_from_date"
      expr: DATE_TRUNC('YEAR', valid_from_date)
      comment: "Year the service code became effective — used for tariff schedule vintage analysis and pricing history reporting."
  measures:
    - name: "total_service_codes"
      expr: COUNT(DISTINCT service_code_id)
      comment: "Total number of distinct service codes in the tariff schedule. Baseline count for service portfolio breadth and tariff schedule completeness."
    - name: "avg_standard_rate"
      expr: AVG(CAST(standard_rate AS DOUBLE))
      comment: "Average standard rate across all service codes. Used to benchmark pricing levels and identify outliers in the tariff schedule."
    - name: "total_standard_rate"
      expr: SUM(CAST(standard_rate AS DOUBLE))
      comment: "Sum of standard rates across the service portfolio. Proxy for total tariff schedule value — used in commercial portfolio valuation and pricing strategy reviews."
    - name: "avg_minimum_charge"
      expr: AVG(CAST(minimum_charge AS DOUBLE))
      comment: "Average minimum charge across service codes. Used in revenue floor analysis and commercial negotiation strategy."
    - name: "avg_maximum_charge"
      expr: AVG(CAST(maximum_charge AS DOUBLE))
      comment: "Average maximum charge across service codes. Used in revenue ceiling analysis and tariff cap governance."
    - name: "tax_applicable_service_count"
      expr: COUNT(CASE WHEN tax_applicable_flag = TRUE THEN service_code_id END)
      comment: "Number of service codes subject to tax. Used in tax compliance reporting and net revenue calculation."
    - name: "surcharge_applicable_service_count"
      expr: COUNT(CASE WHEN surcharge_applicable_flag = TRUE THEN service_code_id END)
      comment: "Number of service codes eligible for surcharges. Measures revenue uplift potential in the tariff schedule — used in commercial strategy and revenue optimisation."
    - name: "discount_eligible_service_count"
      expr: COUNT(CASE WHEN discount_eligible_flag = TRUE THEN service_code_id END)
      comment: "Number of service codes eligible for discounts. Used in commercial negotiation risk assessment and margin management."
    - name: "bundled_service_count"
      expr: COUNT(CASE WHEN is_bundled_service = TRUE THEN service_code_id END)
      comment: "Number of bundled service offerings in the tariff schedule. Used in revenue recognition analysis and tariff unbundling strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`masterdata_container_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container type master data KPIs covering capacity, weight limits, and operational capability flags. Used by operations, commercial, and equipment planning teams to manage container acceptance policies, yard planning, and tariff classification."
  source: "`shipping_ports_ecm`.`masterdata`.`container_type`"
  dimensions:
    - name: "container_category"
      expr: container_category
      comment: "High-level container category (e.g. Dry, Reefer, Tank, OOG, Flat Rack) — primary grouping for container mix and handling complexity analysis."
    - name: "container_type_name"
      expr: container_type_name
      comment: "Descriptive name of the container type — used for operational reporting and tariff classification."
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the container type (e.g. Active, Phased Out) — filters for live container acceptance policy reporting."
    - name: "iso_type_code"
      expr: iso_type_code
      comment: "ISO type code for the container — used for standardised container classification and EDI message mapping."
    - name: "size_code"
      expr: size_code
      comment: "Container size code (e.g. 20, 40, 45) — used for TEU calculation and yard slot planning."
    - name: "height_category"
      expr: height_category
      comment: "Height category (e.g. Standard, High Cube) — used for stacking tier planning and crane height clearance analysis."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Whether the container type is a reefer unit — drives reefer plug capacity planning and cold chain infrastructure investment."
    - name: "is_hazmat_approved"
      expr: is_hazmat_approved
      comment: "Whether the container type is approved for hazardous materials — used in IMDG compliance and hazmat stowage planning."
    - name: "is_oog_capable"
      expr: is_oog_capable
      comment: "Whether the container type can accommodate out-of-gauge cargo — drives specialised equipment and berth planning."
    - name: "is_collapsible"
      expr: is_collapsible
      comment: "Whether the container type is collapsible — relevant for empty container repositioning cost and yard density optimisation."
    - name: "tariff_class_code"
      expr: tariff_class_code
      comment: "Tariff class assigned to the container type — used for revenue classification and tariff schedule management."
    - name: "yard_block_preference"
      expr: yard_block_preference
      comment: "Preferred yard block type for this container — used in yard planning and slot allocation optimisation."
  measures:
    - name: "total_container_types"
      expr: COUNT(DISTINCT container_type_id)
      comment: "Total number of distinct container types in the registry. Baseline count for container acceptance policy coverage and tariff schedule completeness."
    - name: "avg_teu_equivalent"
      expr: AVG(CAST(teu_equivalent AS DOUBLE))
      comment: "Average TEU equivalent factor across container types. Used to normalise container volumes to TEU for throughput reporting and capacity planning."
    - name: "avg_max_gross_weight_kg"
      expr: AVG(CAST(max_gross_weight_kg AS DOUBLE))
      comment: "Average maximum gross weight in kg across container types. Used in structural load planning for yard stacking and vessel stowage."
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity in kg. Indicates the typical cargo weight capacity — used in cargo acceptance and vessel weight distribution planning."
    - name: "avg_internal_capacity_cbm"
      expr: AVG(CAST(internal_capacity_cbm AS DOUBLE))
      comment: "Average internal volume capacity in cubic metres. Used in cargo stowage planning and volumetric utilisation analysis."
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average tare weight in kg across container types. Used in VGM (Verified Gross Mass) compliance calculations and vessel weight planning."
    - name: "avg_swl_kg"
      expr: AVG(CAST(swl_kg AS DOUBLE))
      comment: "Average safe working load in kg across container types. Used in lifting equipment selection and crane capacity planning."
    - name: "reefer_container_type_count"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN container_type_id END)
      comment: "Number of reefer container types in the registry. Drives reefer plug infrastructure planning and cold chain capacity investment decisions."
    - name: "hazmat_approved_container_type_count"
      expr: COUNT(CASE WHEN is_hazmat_approved = TRUE THEN container_type_id END)
      comment: "Number of container types approved for hazardous materials. Informs IMDG compliance capacity and hazmat stowage planning."
    - name: "oog_capable_container_type_count"
      expr: COUNT(CASE WHEN is_oog_capable = TRUE THEN container_type_id END)
      comment: "Number of out-of-gauge capable container types. Drives specialised lifting equipment requirements and OOG berth allocation planning."
$$;