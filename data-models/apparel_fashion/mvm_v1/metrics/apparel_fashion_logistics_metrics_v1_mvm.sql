-- Metric views for domain: logistics | Business: Apparel Fashion | Version: 1 | Generated on: 2026-05-05 18:03:30

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment performance metrics tracking on-time delivery, freight costs, and operational efficiency across transportation modes and lanes"
  source: "`apparel_fashion_ecm`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment (in-transit, delivered, delayed, etc.)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transportation (air, ocean, ground, rail)"
    - name: "shipment_type"
      expr: shipment_type
      comment: "Type of shipment (inbound, outbound, transfer, return)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country code where shipment originated"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Country code of shipment destination"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms defining delivery responsibilities"
    - name: "current_milestone"
      expr: current_milestone
      comment: "Current milestone in the shipment journey"
    - name: "otif_compliant"
      expr: otif_compliant_flag
      comment: "Whether shipment met On-Time In-Full requirements"
    - name: "gsp_eligible"
      expr: gsp_eligible_flag
      comment: "Whether shipment qualifies for Generalized System of Preferences duty reduction"
    - name: "priority_shipment"
      expr: priority_flag
      comment: "Whether shipment is flagged as priority"
    - name: "shipment_month"
      expr: DATE_TRUNC('MONTH', actual_departure_timestamp)
      comment: "Month when shipment departed"
    - name: "shipment_quarter"
      expr: DATE_TRUNC('QUARTER', actual_departure_timestamp)
      comment: "Quarter when shipment departed"
    - name: "shipment_year"
      expr: YEAR(actual_departure_timestamp)
      comment: "Year when shipment departed"
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipments"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Total estimated freight costs across all shipments"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total customs duty paid across all shipments"
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value AS DOUBLE))
      comment: "Total declared insurance value across all shipments"
    - name: "total_cubic_volume"
      expr: SUM(CAST(cubic_volume_m3 AS DOUBLE))
      comment: "Total cubic volume in cubic meters shipped"
    - name: "total_gross_weight"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight in kilograms shipped"
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost_estimate AS DOUBLE))
      comment: "Average freight cost per shipment"
    - name: "otif_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments meeting On-Time In-Full service level agreement"
    - name: "gsp_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gsp_eligible_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments utilizing Generalized System of Preferences for duty savings"
    - name: "avg_freight_cost_per_cbm"
      expr: ROUND(SUM(CAST(freight_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(cubic_volume_m3 AS DOUBLE)), 0), 2)
      comment: "Average freight cost per cubic meter, key efficiency metric for space utilization"
    - name: "avg_freight_cost_per_kg"
      expr: ROUND(SUM(CAST(freight_cost_estimate AS DOUBLE)) / NULLIF(SUM(CAST(gross_weight_kg AS DOUBLE)), 0), 4)
      comment: "Average freight cost per kilogram, key efficiency metric for weight-based pricing"
    - name: "duty_to_freight_ratio"
      expr: ROUND(100.0 * SUM(CAST(duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(freight_cost_estimate AS DOUBLE)), 0), 2)
      comment: "Duty costs as percentage of freight costs, indicates landed cost structure"
    - name: "priority_shipment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN priority_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of shipments flagged as priority, indicates urgency and expedite costs"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_shipment_milestone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment milestone tracking metrics measuring transit time variance, SLA compliance, and exception rates across the supply chain"
  source: "`apparel_fashion_ecm`.`logistics`.`shipment_milestone`"
  dimensions:
    - name: "milestone_code"
      expr: milestone_code
      comment: "Standard code for the milestone event"
    - name: "milestone_name"
      expr: milestone_name
      comment: "Descriptive name of the milestone"
    - name: "location_type"
      expr: location_type
      comment: "Type of location where milestone occurred (port, warehouse, customs, etc.)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport at this milestone"
    - name: "country"
      expr: country_code
      comment: "Country where milestone occurred"
    - name: "exception_occurred"
      expr: exception_flag
      comment: "Whether an exception was recorded at this milestone"
    - name: "customs_cleared"
      expr: customs_cleared_flag
      comment: "Whether customs clearance was completed at this milestone"
    - name: "sla_compliant"
      expr: sla_compliance_flag
      comment: "Whether milestone met service level agreement timing"
    - name: "otif_compliant"
      expr: otif_compliant_flag
      comment: "Whether milestone met On-Time In-Full requirements"
    - name: "responsible_party_type"
      expr: responsible_party_type
      comment: "Type of party responsible for this milestone (carrier, 3PL, customs broker, etc.)"
    - name: "milestone_month"
      expr: DATE_TRUNC('MONTH', actual_timestamp)
      comment: "Month when milestone was achieved"
    - name: "milestone_year"
      expr: YEAR(actual_timestamp)
      comment: "Year when milestone was achieved"
  measures:
    - name: "total_milestones"
      expr: COUNT(1)
      comment: "Total number of milestone events recorded"
    - name: "total_duty_at_milestones"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total duty amounts recorded at milestone events"
    - name: "avg_variance_hours"
      expr: AVG(CAST(variance_hours AS DOUBLE))
      comment: "Average time variance in hours between planned and actual milestone achievement"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sla_compliance_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones meeting service level agreement timing targets"
    - name: "exception_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exception_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones with exceptions, key indicator of supply chain disruptions"
    - name: "customs_clearance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customs_cleared_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones where customs clearance was completed"
    - name: "otif_milestone_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN otif_compliant_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of milestones meeting On-Time In-Full requirements"
    - name: "avg_temperature_reading"
      expr: AVG(CAST(temperature_reading AS DOUBLE))
      comment: "Average temperature reading across temperature-controlled shipment milestones"
    - name: "avg_humidity_reading"
      expr: AVG(CAST(humidity_reading AS DOUBLE))
      comment: "Average humidity reading across climate-controlled shipment milestones"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier performance metrics tracking on-time delivery scores, damage rates, and service quality for transportation provider management"
  source: "`apparel_fashion_ecm`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_name"
      expr: carrier_name
      comment: "Full legal name of the carrier"
    - name: "carrier_status"
      expr: carrier_status
      comment: "Current operational status of the carrier"
    - name: "carrier_type"
      expr: carrier_type
      comment: "Classification of carrier (asset-based, broker, freight forwarder, etc.)"
    - name: "service_mode"
      expr: service_mode
      comment: "Primary service mode offered (air, ocean, ground, rail, intermodal)"
    - name: "geographic_coverage"
      expr: geographic_coverage
      comment: "Geographic regions covered by carrier"
    - name: "is_active"
      expr: is_active
      comment: "Whether carrier is currently active in the network"
    - name: "api_integration_enabled"
      expr: api_integration_flag
      comment: "Whether carrier has API integration for real-time tracking"
    - name: "edi_capable"
      expr: edi_capability_flag
      comment: "Whether carrier supports EDI for electronic data interchange"
    - name: "sustainability_certified"
      expr: sustainability_certification
      comment: "Sustainability certification held by carrier (ISO 14001, SmartWay, etc.)"
    - name: "headquarters_country"
      expr: headquarters_country_code
      comment: "Country where carrier is headquartered"
    - name: "contract_year"
      expr: YEAR(contract_effective_date)
      comment: "Year when current contract became effective"
  measures:
    - name: "total_carriers"
      expr: COUNT(1)
      comment: "Total number of carriers in the network"
    - name: "avg_on_time_performance"
      expr: AVG(CAST(on_time_performance_score AS DOUBLE))
      comment: "Average on-time performance score across carriers, critical KPI for carrier selection"
    - name: "avg_otif_score"
      expr: AVG(CAST(otif_score AS DOUBLE))
      comment: "Average On-Time In-Full score across carriers, key service quality metric"
    - name: "avg_damage_claim_rate"
      expr: AVG(CAST(damage_claim_rate AS DOUBLE))
      comment: "Average damage claim rate across carriers, indicates cargo handling quality"
    - name: "total_insurance_coverage"
      expr: SUM(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Total insurance coverage amount across all carriers"
    - name: "avg_insurance_coverage"
      expr: AVG(CAST(insurance_coverage_amount AS DOUBLE))
      comment: "Average insurance coverage per carrier"
    - name: "api_integration_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN api_integration_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with API integration, indicates digital maturity of carrier network"
    - name: "edi_capability_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN edi_capability_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with EDI capability for automated data exchange"
    - name: "sustainability_certified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of carriers with sustainability certifications, supports ESG reporting"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_duty_calculation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs duty and landed cost metrics tracking duty amounts, trade program utilization, and cost reconciliation for international shipments"
  source: "`apparel_fashion_ecm`.`logistics`.`duty_calculation`"
  dimensions:
    - name: "calculation_status"
      expr: calculation_status
      comment: "Status of the duty calculation (draft, submitted, approved, paid)"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods originated"
    - name: "destination_country"
      expr: destination_country
      comment: "Country where goods are imported"
    - name: "fta_claimed"
      expr: fta_claimed_flag
      comment: "Whether Free Trade Agreement benefits were claimed"
    - name: "fta_name"
      expr: fta_name
      comment: "Name of Free Trade Agreement utilized"
    - name: "gsp_claimed"
      expr: gsp_claimed_flag
      comment: "Whether Generalized System of Preferences benefits were claimed"
    - name: "port_of_entry"
      expr: port_of_entry
      comment: "Port where goods entered the destination country"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Status of duty reconciliation process"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which duty was calculated"
    - name: "calculation_month"
      expr: DATE_TRUNC('MONTH', calculation_timestamp)
      comment: "Month when duty was calculated"
    - name: "calculation_year"
      expr: YEAR(calculation_timestamp)
      comment: "Year when duty was calculated"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Month when duty was paid"
  measures:
    - name: "total_duty_calculations"
      expr: COUNT(1)
      comment: "Total number of duty calculations processed"
    - name: "total_base_duty"
      expr: SUM(CAST(base_duty_amount AS DOUBLE))
      comment: "Total base duty amount before any reductions or additional charges"
    - name: "total_duty_amount"
      expr: SUM(CAST(total_duty_amount AS DOUBLE))
      comment: "Total duty amount including all charges and reductions"
    - name: "total_fta_savings"
      expr: SUM(CAST(fta_reduction_amount AS DOUBLE))
      comment: "Total duty savings from Free Trade Agreement utilization"
    - name: "total_gsp_savings"
      expr: SUM(CAST(gsp_reduction_amount AS DOUBLE))
      comment: "Total duty savings from Generalized System of Preferences utilization"
    - name: "total_anti_dumping_duty"
      expr: SUM(CAST(anti_dumping_duty_amount AS DOUBLE))
      comment: "Total anti-dumping duty assessed"
    - name: "total_countervailing_duty"
      expr: SUM(CAST(countervailing_duty_amount AS DOUBLE))
      comment: "Total countervailing duty assessed"
    - name: "total_mpf"
      expr: SUM(CAST(mpf_amount AS DOUBLE))
      comment: "Total Merchandise Processing Fee paid to customs"
    - name: "total_hmf"
      expr: SUM(CAST(hmf_amount AS DOUBLE))
      comment: "Total Harbor Maintenance Fee paid"
    - name: "total_vat"
      expr: SUM(CAST(vat_amount AS DOUBLE))
      comment: "Total Value Added Tax paid on imports"
    - name: "total_ldp_cost"
      expr: SUM(CAST(ldp_total_amount AS DOUBLE))
      comment: "Total Landed Duty Paid cost including all duties, taxes, and fees"
    - name: "total_fob_value"
      expr: SUM(CAST(fob_value AS DOUBLE))
      comment: "Total Free On Board value of goods"
    - name: "total_cif_value"
      expr: SUM(CAST(cif_value AS DOUBLE))
      comment: "Total Cost Insurance Freight value of goods"
    - name: "avg_ldp_unit_cost"
      expr: AVG(CAST(ldp_unit_cost AS DOUBLE))
      comment: "Average Landed Duty Paid cost per unit"
    - name: "fta_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN fta_claimed_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calculations utilizing Free Trade Agreements, key metric for duty optimization"
    - name: "gsp_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gsp_claimed_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of calculations utilizing GSP benefits, indicates duty savings opportunity capture"
    - name: "duty_to_fob_ratio"
      expr: ROUND(100.0 * SUM(CAST(total_duty_amount AS DOUBLE)) / NULLIF(SUM(CAST(fob_value AS DOUBLE)), 0), 2)
      comment: "Total duty as percentage of FOB value, key metric for landed cost analysis"
    - name: "ldp_to_fob_ratio"
      expr: ROUND(100.0 * SUM(CAST(ldp_total_amount AS DOUBLE)) / NULLIF(SUM(CAST(fob_value AS DOUBLE)), 0), 2)
      comment: "Landed Duty Paid cost as percentage of FOB value, total cost multiplier for imports"
    - name: "trade_program_savings_rate"
      expr: ROUND(100.0 * (SUM(CAST(fta_reduction_amount AS DOUBLE)) + SUM(CAST(gsp_reduction_amount AS DOUBLE))) / NULLIF(SUM(CAST(base_duty_amount AS DOUBLE)), 0), 2)
      comment: "Total trade program savings as percentage of base duty, measures effectiveness of duty optimization"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_distribution_center`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution center capacity and capability metrics tracking facility utilization, automation levels, and channel support"
  source: "`apparel_fashion_ecm`.`logistics`.`distribution_center`"
  dimensions:
    - name: "facility_name"
      expr: facility_name
      comment: "Name of the distribution center facility"
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (DC, fulfillment center, cross-dock, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "country"
      expr: country_code
      comment: "Country where facility is located"
    - name: "automation_level"
      expr: automation_level
      comment: "Level of automation in the facility (manual, semi-automated, fully automated)"
    - name: "supports_dtc"
      expr: supports_dtc_channel
      comment: "Whether facility supports direct-to-consumer fulfillment"
    - name: "supports_retail"
      expr: supports_retail_replenishment_channel
      comment: "Whether facility supports retail store replenishment"
    - name: "supports_wholesale"
      expr: supports_wholesale_channel
      comment: "Whether facility supports wholesale distribution"
    - name: "supports_outlet"
      expr: supports_outlet_channel
      comment: "Whether facility supports outlet channel"
    - name: "rfid_enabled"
      expr: rfid_enabled_flag
      comment: "Whether facility has RFID technology enabled"
    - name: "customs_bonded"
      expr: customs_bonded_warehouse_flag
      comment: "Whether facility is a customs bonded warehouse"
    - name: "sustainability_certification"
      expr: sustainability_certification
      comment: "Sustainability certification held by facility (LEED, BREEAM, etc.)"
    - name: "go_live_year"
      expr: YEAR(go_live_date)
      comment: "Year when facility went live"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of distribution center facilities"
    - name: "total_square_footage"
      expr: SUM(CAST(total_square_footage AS DOUBLE))
      comment: "Total square footage across all facilities"
    - name: "total_bulk_storage_capacity"
      expr: SUM(CAST(bulk_storage_capacity_sqft AS DOUBLE))
      comment: "Total bulk storage capacity in square feet"
    - name: "total_hanging_storage_capacity"
      expr: SUM(CAST(hanging_storage_capacity_sqft AS DOUBLE))
      comment: "Total hanging garment storage capacity in square feet"
    - name: "total_cold_storage_capacity"
      expr: SUM(CAST(cold_storage_capacity_sqft AS DOUBLE))
      comment: "Total cold storage capacity in square feet"
    - name: "total_pick_zone_capacity"
      expr: SUM(CAST(pick_zone_capacity_sqft AS DOUBLE))
      comment: "Total pick zone capacity in square feet"
    - name: "avg_facility_size"
      expr: AVG(CAST(total_square_footage AS DOUBLE))
      comment: "Average facility size in square feet"
    - name: "dtc_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_dtc_channel = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities supporting direct-to-consumer channel, indicates omnichannel capability"
    - name: "retail_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_retail_replenishment_channel = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities supporting retail replenishment"
    - name: "wholesale_support_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN supports_wholesale_channel = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities supporting wholesale distribution"
    - name: "rfid_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rfid_enabled_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with RFID technology, indicates inventory visibility maturity"
    - name: "customs_bonded_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN customs_bonded_warehouse_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities that are customs bonded, enables duty deferral strategies"
    - name: "sustainability_certified_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sustainability_certification IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of facilities with sustainability certifications, supports ESG goals"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transportation lane performance metrics tracking rates, transit times, and service levels for network optimization"
  source: "`apparel_fashion_ecm`.`logistics`.`lane`"
  dimensions:
    - name: "lane_name"
      expr: lane_name
      comment: "Descriptive name of the transportation lane"
    - name: "lane_status"
      expr: lane_status
      comment: "Current status of the lane (active, inactive, suspended)"
    - name: "lane_type"
      expr: lane_type
      comment: "Type of lane (inbound, outbound, inter-facility, return)"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for this lane (air, ocean, ground, rail)"
    - name: "service_level"
      expr: service_level
      comment: "Service level offered on this lane (express, standard, economy)"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country for this lane"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms for this lane"
    - name: "gsp_eligible"
      expr: gsp_eligible
      comment: "Whether lane is eligible for GSP benefits"
    - name: "landed_duty_paid"
      expr: landed_duty_paid
      comment: "Whether lane pricing includes landed duty paid"
    - name: "requires_customs"
      expr: requires_customs_clearance
      comment: "Whether lane requires customs clearance"
    - name: "hazmat_approved"
      expr: hazmat_approved
      comment: "Whether lane is approved for hazardous materials"
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Whether lane offers temperature-controlled transport"
    - name: "rate_currency"
      expr: rate_currency_code
      comment: "Currency in which lane rates are quoted"
  measures:
    - name: "total_lanes"
      expr: COUNT(1)
      comment: "Total number of transportation lanes in the network"
    - name: "total_base_rate"
      expr: SUM(CAST(base_rate_amount AS DOUBLE))
      comment: "Total base rate amount across all lanes"
    - name: "avg_base_rate"
      expr: AVG(CAST(base_rate_amount AS DOUBLE))
      comment: "Average base rate per lane"
    - name: "avg_transit_time_days"
      expr: AVG(CAST(transit_time_days AS DOUBLE))
      comment: "Average transit time in days across lanes, key metric for lead time planning"
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average distance in kilometers across lanes"
    - name: "total_capacity_weight"
      expr: SUM(CAST(capacity_weight_kg AS DOUBLE))
      comment: "Total weight capacity in kilograms across all lanes"
    - name: "total_capacity_volume"
      expr: SUM(CAST(capacity_volume_cbm AS DOUBLE))
      comment: "Total volume capacity in cubic meters across all lanes"
    - name: "avg_sla_otd_target"
      expr: AVG(CAST(sla_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery SLA target percentage across lanes"
    - name: "avg_rate_per_km"
      expr: ROUND(SUM(CAST(base_rate_amount AS DOUBLE)) / NULLIF(SUM(CAST(distance_km AS DOUBLE)), 0), 4)
      comment: "Average rate per kilometer, key efficiency metric for lane cost comparison"
    - name: "gsp_eligible_lane_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gsp_eligible = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes eligible for GSP benefits, indicates duty savings potential"
    - name: "ldp_lane_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN landed_duty_paid = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes with landed duty paid pricing, simplifies cost forecasting"
    - name: "hazmat_capable_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_approved = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes approved for hazardous materials transport"
    - name: "temp_controlled_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN temperature_controlled = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of lanes offering temperature-controlled transport for sensitive goods"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_customs_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customs entry processing metrics tracking clearance times, duty payments, and compliance for international trade operations"
  source: "`apparel_fashion_ecm`.`logistics`.`customs_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of customs entry (consumption, warehouse, temporary import, etc.)"
    - name: "clearance_status"
      expr: clearance_status
      comment: "Current clearance status of the entry"
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country where goods originated"
    - name: "port_of_entry"
      expr: port_of_entry_code
      comment: "Port where goods entered the country"
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the entry"
    - name: "bond_type"
      expr: bond_type
      comment: "Type of customs bond used"
    - name: "exam_type"
      expr: exam_type
      comment: "Type of customs examination performed"
    - name: "protest_filed"
      expr: protest_filed_indicator
      comment: "Whether a protest was filed against the entry"
    - name: "reconciliation_required"
      expr: reconciliation_indicator
      comment: "Whether entry requires reconciliation"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used to pay duties and fees"
    - name: "filing_month"
      expr: DATE_TRUNC('MONTH', entry_filing_date)
      comment: "Month when entry was filed"
    - name: "filing_year"
      expr: YEAR(entry_filing_date)
      comment: "Year when entry was filed"
    - name: "release_month"
      expr: DATE_TRUNC('MONTH', release_date)
      comment: "Month when goods were released"
  measures:
    - name: "total_entries"
      expr: COUNT(1)
      comment: "Total number of customs entries processed"
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount_usd AS DOUBLE))
      comment: "Total duty amount paid in USD"
    - name: "total_mpf"
      expr: SUM(CAST(merchandise_processing_fee_usd AS DOUBLE))
      comment: "Total Merchandise Processing Fee paid"
    - name: "total_hmf"
      expr: SUM(CAST(harbor_maintenance_fee_usd AS DOUBLE))
      comment: "Total Harbor Maintenance Fee paid"
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared value of goods in USD"
    - name: "total_bond_amount"
      expr: SUM(CAST(bond_amount_usd AS DOUBLE))
      comment: "Total customs bond amount posted"
    - name: "total_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of goods across all entries"
    - name: "total_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight in kilograms across all entries"
    - name: "avg_duty_per_entry"
      expr: AVG(CAST(duty_amount_usd AS DOUBLE))
      comment: "Average duty amount per customs entry"
    - name: "effective_duty_rate"
      expr: ROUND(100.0 * SUM(CAST(duty_amount_usd AS DOUBLE)) / NULLIF(SUM(CAST(declared_value_usd AS DOUBLE)), 0), 2)
      comment: "Effective duty rate as percentage of declared value, key metric for landed cost modeling"
    - name: "protest_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN protest_filed_indicator = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries with protests filed, indicates classification or valuation disputes"
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_indicator = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of entries requiring reconciliation, indicates complexity of duty calculations"
$$;

CREATE OR REPLACE VIEW `apparel_fashion_ecm`.`_metrics`.`logistics_freight_booking`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight booking metrics tracking space allocation, booking status, and freight charges for capacity planning and cost management"
  source: "`apparel_fashion_ecm`.`logistics`.`freight_booking`"
  dimensions:
    - name: "booking_status"
      expr: booking_status
      comment: "Current status of the freight booking"
    - name: "service_type"
      expr: service_type
      comment: "Type of freight service booked (FCL, LCL, air freight, etc.)"
    - name: "container_type"
      expr: container_type
      comment: "Type of container booked (20ft, 40ft, 40ft HC, etc.)"
    - name: "origin_country"
      expr: origin_country_code
      comment: "Country of origin for the booking"
    - name: "destination_country"
      expr: destination_country_code
      comment: "Destination country for the booking"
    - name: "incoterm"
      expr: incoterm_code
      comment: "Incoterm for the booking"
    - name: "gsp_eligible"
      expr: gsp_eligible_flag
      comment: "Whether booking is eligible for GSP benefits"
    - name: "hazmat"
      expr: hazmat_flag
      comment: "Whether booking contains hazardous materials"
    - name: "insurance_required"
      expr: insurance_required_flag
      comment: "Whether insurance is required for the booking"
    - name: "port_of_loading"
      expr: port_of_loading_code
      comment: "Port where goods will be loaded"
    - name: "port_of_discharge"
      expr: port_of_discharge_code
      comment: "Port where goods will be discharged"
    - name: "freight_currency"
      expr: freight_charge_currency_code
      comment: "Currency in which freight charges are denominated"
    - name: "booking_month"
      expr: DATE_TRUNC('MONTH', booking_date)
      comment: "Month when booking was made"
    - name: "booking_year"
      expr: YEAR(booking_date)
      comment: "Year when booking was made"
  measures:
    - name: "total_bookings"
      expr: COUNT(1)
      comment: "Total number of freight bookings"
    - name: "total_freight_charges"
      expr: SUM(CAST(freight_charge_amount AS DOUBLE))
      comment: "Total freight charges across all bookings"
    - name: "total_insurance_value"
      expr: SUM(CAST(insurance_value_amount AS DOUBLE))
      comment: "Total insurance value across all bookings"
    - name: "total_space_allocated"
      expr: SUM(CAST(confirmed_space_allocation AS DOUBLE))
      comment: "Total confirmed space allocation across all bookings"
    - name: "avg_freight_charge"
      expr: AVG(CAST(freight_charge_amount AS DOUBLE))
      comment: "Average freight charge per booking"
    - name: "avg_space_per_booking"
      expr: AVG(CAST(confirmed_space_allocation AS DOUBLE))
      comment: "Average space allocation per booking"
    - name: "gsp_eligible_booking_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN gsp_eligible_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings eligible for GSP benefits"
    - name: "hazmat_booking_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hazmat_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings containing hazardous materials, indicates specialized handling needs"
    - name: "insurance_required_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_required_flag = True THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of bookings requiring insurance coverage"
$$;