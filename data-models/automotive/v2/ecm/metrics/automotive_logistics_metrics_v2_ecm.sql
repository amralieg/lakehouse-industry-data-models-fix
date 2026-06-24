-- Metric views for domain: logistics | Business: Automotive | Version: 2 | Generated on: 2026-06-23 04:49:37

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Carrier master performance and compliance metrics for strategic carrier management, network optimization, and vendor evaluation decisions."
  source: "`vibe_automotive_v1`.`logistics`.`carrier`"
  dimensions:
    - name: "carrier_type"
      expr: carrier_type
      comment: "Type of carrier (road, rail, ocean, air) for mode-level performance segmentation."
    - name: "carrier_status"
      expr: carrier_status
      comment: "Active/inactive/suspended status of the carrier for network availability analysis."
    - name: "tier"
      expr: tier
      comment: "Carrier tier classification (Tier 1/2/3) for strategic sourcing segmentation."
    - name: "country"
      expr: country
      comment: "Country of carrier headquarters for geographic network coverage analysis."
    - name: "transport_modes"
      expr: transport_modes
      comment: "Transport modes supported by the carrier for multi-modal planning."
    - name: "iatf_compliance_status"
      expr: iatf_compliance_status
      comment: "IATF 16949 compliance status for quality-gated carrier selection."
    - name: "safety_rating"
      expr: safety_rating
      comment: "Safety rating classification for risk-based carrier management."
    - name: "environmental_certification"
      expr: environmental_certification
      comment: "Environmental certification (e.g. ISO 14001) for ESG-aligned carrier selection."
    - name: "contract_start_date"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Contract start month for contract lifecycle and renewal planning."
    - name: "contract_end_date"
      expr: DATE_TRUNC('month', contract_end_date)
      comment: "Contract end month for proactive renewal and risk management."
  measures:
    - name: "total_carriers"
      expr: COUNT(DISTINCT carrier_id)
      comment: "Total number of active carriers in the network; baseline for network breadth assessment."
    - name: "avg_on_time_delivery_pct"
      expr: AVG(CAST(average_on_time_delivery_pct AS DOUBLE))
      comment: "Average on-time delivery percentage across all carriers; primary carrier performance KPI for executive steering."
    - name: "avg_cost_per_mile"
      expr: AVG(CAST(average_cost_per_mile AS DOUBLE))
      comment: "Average freight cost per mile across carriers; key input for logistics cost benchmarking and carrier negotiation."
    - name: "avg_performance_rating"
      expr: AVG(CAST(performance_rating AS DOUBLE))
      comment: "Average carrier performance rating; composite score used in quarterly carrier reviews and award decisions."
    - name: "carriers_with_expiring_contracts_90d"
      expr: COUNT(DISTINCT CASE WHEN contract_end_date BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN carrier_id END)
      comment: "Number of carriers with contracts expiring within 90 days; critical for procurement risk management and renewal prioritization."
    - name: "carriers_iatf_compliant"
      expr: COUNT(DISTINCT CASE WHEN iatf_compliance_status = 'COMPLIANT' THEN carrier_id END)
      comment: "Count of IATF-compliant carriers; required for automotive quality gate decisions on carrier selection."
    - name: "pct_carriers_iatf_compliant"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN iatf_compliance_status = 'COMPLIANT' THEN carrier_id END) / NULLIF(COUNT(DISTINCT carrier_id), 0), 2)
      comment: "Percentage of carriers meeting IATF 16949 compliance; executive KPI for supply chain quality governance."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_carrier_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Periodic carrier performance scorecard metrics for OTD, damage, cost, and transit time — used in carrier reviews, award decisions, and network optimization."
  source: "`vibe_automotive_v1`.`logistics`.`carrier_performance`"
  dimensions:
    - name: "performance_month"
      expr: DATE_TRUNC('month', performance_month)
      comment: "Performance measurement month for trend analysis and period-over-period comparison."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (road/rail/ocean/air) for mode-level performance benchmarking."
    - name: "lane_type"
      expr: lane_type
      comment: "Lane type (domestic/international/CKD) for lane-level performance segmentation."
    - name: "lane_code"
      expr: lane_code
      comment: "Specific lane code for granular lane-level carrier performance analysis."
    - name: "overall_rating"
      expr: overall_rating
      comment: "Overall carrier performance rating category for executive-level carrier tiering."
    - name: "carrier_performance_status"
      expr: carrier_performance_status
      comment: "Status of the performance record (active/closed/under-review) for data quality filtering."
  measures:
    - name: "avg_on_time_delivery_rate_pct"
      expr: AVG(CAST(on_time_delivery_rate_pct AS DOUBLE))
      comment: "Average on-time delivery rate across carrier-lane-period combinations; primary logistics KPI for executive dashboards."
    - name: "avg_otd_rate_pct"
      expr: AVG(CAST(otd_rate_pct AS DOUBLE))
      comment: "Average OTD rate (alternate OTD measure); used for cross-validation and trend steering."
    - name: "avg_damage_rate_ppm"
      expr: AVG(CAST(damage_rate_ppm AS DOUBLE))
      comment: "Average vehicle/parts damage rate in parts-per-million; critical quality KPI driving carrier corrective actions."
    - name: "avg_transit_days"
      expr: AVG(CAST(average_transit_days AS DOUBLE))
      comment: "Average transit time in days; key input for delivery promise accuracy and customer satisfaction."
    - name: "avg_cost_per_shipment_usd"
      expr: AVG(CAST(cost_per_shipment_usd AS DOUBLE))
      comment: "Average freight cost per shipment in USD; used for cost benchmarking and carrier negotiation leverage."
    - name: "avg_transit_time_compliance_pct"
      expr: AVG(CAST(transit_time_compliance_pct AS DOUBLE))
      comment: "Average transit time compliance percentage; measures adherence to contracted transit windows."
    - name: "total_distance_km"
      expr: SUM(CAST(total_distance_km AS DOUBLE))
      comment: "Total distance covered across all carrier-lane records; used for emissions calculation and fuel cost modeling."
    - name: "avg_fuel_consumption_l_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km; ESG and cost efficiency KPI for green logistics programs."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core shipment execution metrics covering cost, OTD, hazardous goods, and customs compliance — the primary logistics operational KPI view for executive and operational steering."
  source: "`vibe_automotive_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (road/rail/ocean/air) for mode-level cost and performance analysis."
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current shipment status (in-transit/delivered/delayed/cancelled) for pipeline visibility."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code (EXW/FOB/CIF/DAP) for trade term-level cost and risk analysis."
    - name: "planned_departure_date"
      expr: DATE_TRUNC('month', planned_departure_date)
      comment: "Planned departure month for shipment volume trend analysis."
    - name: "planned_arrival_date"
      expr: DATE_TRUNC('month', planned_arrival_date)
      comment: "Planned arrival month for delivery schedule adherence tracking."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Export vs. import indicator for trade flow analysis and customs compliance monitoring."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Hazardous material flag for dangerous goods compliance and risk segmentation."
    - name: "load_type"
      expr: load_type
      comment: "Load type (FTL/LTL/container) for capacity utilization and cost-per-unit analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Customs/regulatory compliance status for risk monitoring and clearance bottleneck identification."
  measures:
    - name: "total_shipments"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Total number of shipments; baseline volume KPI for logistics capacity planning."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across all shipments; primary logistics cost KPI for budget management and carrier negotiations."
    - name: "avg_freight_cost_per_shipment"
      expr: AVG(CAST(freight_cost AS DOUBLE))
      comment: "Average freight cost per shipment; benchmarking KPI for cost efficiency and carrier rate negotiations."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net logistics cost after discounts; used for P&L reporting and cost center allocation."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total freight discount captured; measures negotiation effectiveness and contract compliance."
    - name: "otd_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN otd_flag = TRUE THEN shipment_id END)
      comment: "Number of shipments delivered on time; numerator for OTD rate calculation."
    - name: "otd_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN otd_flag = TRUE THEN shipment_id END) / NULLIF(COUNT(DISTINCT shipment_id), 0), 2)
      comment: "On-time delivery rate percentage; the single most important logistics KPI for customer satisfaction and dealer fill-rate."
    - name: "hazardous_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN hazardous_material_flag = TRUE THEN shipment_id END)
      comment: "Count of hazardous material shipments; compliance and risk management KPI for dangerous goods regulatory adherence."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total shipment volume in cubic meters; capacity planning and vessel/truck utilization KPI."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total shipment weight in kilograms; payload utilization and freight rate calculation input."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_transport_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle transport order execution metrics covering OTD, cost, emissions, and expediting — the primary finished vehicle logistics KPI view for plant-to-dealer pipeline management."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_transport_order`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode (road/rail/ocean/RoRo) for mode-level cost and OTD analysis."
    - name: "order_status"
      expr: order_status
      comment: "Transport order status (open/in-transit/delivered/cancelled) for pipeline visibility."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of transport vehicle for ESG emissions segmentation."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Expedited flag for premium freight cost analysis and root cause investigation."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous goods flag for dangerous goods compliance monitoring."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Export vs. import indicator for cross-border logistics cost and compliance analysis."
    - name: "requested_pickup_date"
      expr: DATE_TRUNC('month', requested_pickup_date)
      comment: "Requested pickup month for demand planning and plant dispatch scheduling."
    - name: "delivery_date"
      expr: DATE_TRUNC('month', delivery_date)
      comment: "Delivery month for dealer fill-rate and customer delivery promise tracking."
    - name: "priority"
      expr: priority
      comment: "Transport order priority level for capacity allocation and escalation management."
  measures:
    - name: "total_transport_orders"
      expr: COUNT(DISTINCT finished_vehicle_stock_id)
      comment: "Total vehicle transport orders; baseline volume KPI for finished vehicle logistics capacity planning."
    - name: "total_transport_cost_gross"
      expr: SUM(CAST(transport_cost_gross AS DOUBLE))
      comment: "Total gross transport cost; primary finished vehicle logistics cost KPI for budget and carrier management."
    - name: "total_transport_cost_net"
      expr: SUM(CAST(transport_cost_net AS DOUBLE))
      comment: "Total net transport cost after tax; used for P&L and cost center reporting."
    - name: "avg_transport_cost_net_per_order"
      expr: AVG(CAST(transport_cost_net AS DOUBLE))
      comment: "Average net transport cost per vehicle transport order; benchmarking KPI for cost efficiency and carrier negotiations."
    - name: "otd_order_count"
      expr: COUNT(DISTINCT CASE WHEN on_time_delivery_flag = TRUE THEN finished_vehicle_stock_id END)
      comment: "Number of transport orders delivered on time; numerator for finished vehicle OTD rate."
    - name: "otd_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN on_time_delivery_flag = TRUE THEN finished_vehicle_stock_id END) / NULLIF(COUNT(DISTINCT finished_vehicle_stock_id), 0), 2)
      comment: "On-time delivery rate for finished vehicles; the primary dealer satisfaction and logistics performance KPI."
    - name: "expedited_order_count"
      expr: COUNT(DISTINCT CASE WHEN is_expedited = TRUE THEN finished_vehicle_stock_id END)
      comment: "Count of expedited transport orders; premium freight cost driver and supply chain disruption indicator."
    - name: "expedited_order_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_expedited = TRUE THEN finished_vehicle_stock_id END) / NULLIF(COUNT(DISTINCT finished_vehicle_stock_id), 0), 2)
      comment: "Percentage of transport orders that are expedited; KPI for supply chain stability and premium freight cost control."
    - name: "total_emission_co2_kg"
      expr: SUM(CAST(emission_co2_kg AS DOUBLE))
      comment: "Total CO2 emissions from vehicle transport in kg; ESG reporting KPI for Scope 3 logistics emissions."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average transport distance in km; network optimization and cost-per-km benchmarking input."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_delivery_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Delivery schedule adherence and cost metrics for plant-to-dealer vehicle delivery planning — used for OTD management, last-mile analysis, and logistics cost control."
  source: "`vibe_automotive_v1`.`logistics`.`logistics_delivery_schedule`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for delivery schedule segmentation by logistics channel."
    - name: "logistics_delivery_schedule_status"
      expr: logistics_delivery_schedule_status
      comment: "Schedule status (planned/confirmed/in-transit/delivered/delayed) for pipeline management."
    - name: "d2c_delivery_flag"
      expr: d2c_delivery_flag
      comment: "Direct-to-consumer delivery flag for D2C channel performance tracking."
    - name: "last_mile_delivery_method"
      expr: last_mile_delivery_method
      comment: "Last-mile delivery method for last-mile cost and performance analysis."
    - name: "is_expedited"
      expr: is_expedited
      comment: "Expedited delivery flag for premium freight cost monitoring."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag for regulatory adherence monitoring in delivery scheduling."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Export/import indicator for cross-border delivery schedule analysis."
    - name: "departure_date"
      expr: DATE_TRUNC('month', departure_date)
      comment: "Departure month for delivery volume trend and capacity planning."
    - name: "estimated_delivery_date"
      expr: DATE_TRUNC('month', estimated_delivery_date)
      comment: "Estimated delivery month for forward-looking dealer fill-rate planning."
    - name: "priority_level"
      expr: priority_level
      comment: "Delivery priority level for capacity allocation and escalation management."
  measures:
    - name: "total_scheduled_deliveries"
      expr: COUNT(DISTINCT finished_vehicle_stock_id)
      comment: "Total scheduled delivery records; baseline volume for logistics capacity planning."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned vehicle/unit quantity across all delivery schedules; key input for dealer inventory planning."
    - name: "total_cost_actual"
      expr: SUM(CAST(cost_actual AS DOUBLE))
      comment: "Total actual delivery cost; primary logistics cost KPI for budget vs. actuals reporting."
    - name: "total_cost_estimate"
      expr: SUM(CAST(cost_estimate AS DOUBLE))
      comment: "Total estimated delivery cost; used for budget planning and cost variance analysis."
    - name: "cost_variance"
      expr: SUM(CAST(cost_actual AS DOUBLE) - CAST(cost_estimate AS DOUBLE))
      comment: "Total cost variance (actual minus estimate) across delivery schedules; KPI for logistics cost control and carrier rate accuracy."
    - name: "otd_schedule_count"
      expr: COUNT(DISTINCT CASE WHEN otd_actual_date <= otd_target_date THEN finished_vehicle_stock_id END)
      comment: "Number of delivery schedules where actual delivery met the OTD target; numerator for schedule OTD rate."
    - name: "otd_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN otd_actual_date <= otd_target_date THEN finished_vehicle_stock_id END) / NULLIF(COUNT(DISTINCT finished_vehicle_stock_id), 0), 2)
      comment: "On-time delivery rate for scheduled deliveries; primary dealer satisfaction KPI for logistics operations."
    - name: "d2c_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN d2c_delivery_flag = TRUE THEN finished_vehicle_stock_id END)
      comment: "Count of direct-to-consumer deliveries; strategic KPI for D2C channel growth and last-mile investment decisions."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total delivery volume in cubic meters; capacity utilization and load planning KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_freight_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Freight invoice financial metrics for logistics spend management, carrier payment accuracy, and invoice variance analysis — used in finance and procurement steering."
  source: "`vibe_automotive_v1`.`logistics`.`freight_invoice`"
  dimensions:
    - name: "freight_invoice_status"
      expr: freight_invoice_status
      comment: "Invoice status (pending/approved/paid/disputed) for accounts payable pipeline management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for freight spend analysis by logistics channel."
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status for cash flow and working capital management."
    - name: "approval_status"
      expr: approval_status
      comment: "Invoice approval status for process efficiency and bottleneck identification."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for trade term-level freight cost analysis."
    - name: "invoice_date"
      expr: DATE_TRUNC('month', invoice_date)
      comment: "Invoice month for freight spend trend analysis and budget tracking."
    - name: "payment_due_date"
      expr: DATE_TRUNC('month', payment_due_date)
      comment: "Payment due month for cash flow forecasting and working capital management."
    - name: "currency_code"
      expr: currency_code
      comment: "Invoice currency for multi-currency freight spend analysis and FX exposure."
  measures:
    - name: "total_invoices"
      expr: COUNT(DISTINCT freight_invoice_id)
      comment: "Total freight invoices; baseline volume for accounts payable workload and process efficiency."
    - name: "total_invoiced_amount"
      expr: SUM(CAST(invoiced_amount AS DOUBLE))
      comment: "Total invoiced freight amount; primary logistics spend KPI for budget management and carrier cost control."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net freight amount after discounts; used for P&L and cost center reporting."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on freight invoices; tax compliance and cost reporting KPI."
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total invoice variance (invoiced vs. agreed rate); measures carrier billing accuracy and contract compliance."
    - name: "avg_variance_per_invoice"
      expr: AVG(CAST(variance_amount AS DOUBLE))
      comment: "Average invoice variance per freight invoice; KPI for carrier billing accuracy and dispute management."
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total freight discounts captured; measures negotiation effectiveness and contract utilization."
    - name: "invoices_with_variance_count"
      expr: COUNT(DISTINCT CASE WHEN variance_amount <> 0 THEN freight_invoice_id END)
      comment: "Number of invoices with billing variances; drives carrier audit and dispute resolution prioritization."
    - name: "invoice_variance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN variance_amount <> 0 THEN freight_invoice_id END) / NULLIF(COUNT(DISTINCT freight_invoice_id), 0), 2)
      comment: "Percentage of freight invoices with billing variances; executive KPI for carrier billing quality and audit trigger."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_transport_damage_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport damage claim metrics for vehicle and parts damage cost management, carrier liability, and quality improvement — used in carrier reviews and insurance management."
  source: "`vibe_automotive_v1`.`logistics`.`transport_damage_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Claim status (open/settled/rejected/in-review) for claims pipeline management."
    - name: "claim_type"
      expr: claim_type
      comment: "Type of damage claim (vehicle damage/parts damage/theft) for root cause analysis."
    - name: "damage_category"
      expr: damage_category
      comment: "Damage category (paint/mechanical/structural) for quality improvement targeting."
    - name: "damage_severity"
      expr: damage_severity
      comment: "Damage severity level for prioritization and cost impact analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level damage rate analysis and carrier accountability."
    - name: "claim_priority"
      expr: claim_priority
      comment: "Claim priority for resolution SLA management."
    - name: "claim_settlement_method"
      expr: claim_settlement_method
      comment: "Settlement method (cash/repair/replacement) for claims cost optimization."
    - name: "claim_submission_timestamp"
      expr: DATE_TRUNC('month', claim_submission_timestamp)
      comment: "Claim submission month for damage trend analysis and seasonal pattern detection."
  measures:
    - name: "total_damage_claims"
      expr: COUNT(DISTINCT transport_damage_claim_id)
      comment: "Total transport damage claims; baseline volume KPI for carrier quality management."
    - name: "total_actual_repair_cost"
      expr: SUM(CAST(actual_repair_cost AS DOUBLE))
      comment: "Total actual repair cost from transport damage; primary financial impact KPI for carrier liability and insurance management."
    - name: "total_estimated_repair_cost"
      expr: SUM(CAST(estimated_repair_cost AS DOUBLE))
      comment: "Total estimated repair cost; used for claims provisioning and insurance reserve management."
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settled claim amount; measures actual financial recovery from carriers and insurers."
    - name: "avg_claim_ppm_rate"
      expr: AVG(CAST(claim_ppm_rate AS DOUBLE))
      comment: "Average damage claim rate in parts-per-million; industry-standard quality KPI for carrier performance reviews."
    - name: "repair_cost_recovery_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(settlement_amount AS DOUBLE)) / NULLIF(SUM(CAST(actual_repair_cost AS DOUBLE)), 0), 2)
      comment: "Percentage of actual repair costs recovered through settlements; measures claims management effectiveness and carrier accountability."
    - name: "otd_impacted_claim_count"
      expr: COUNT(DISTINCT CASE WHEN otd_impact_flag = TRUE THEN transport_damage_claim_id END)
      comment: "Number of damage claims that impacted on-time delivery; measures cascading effect of transport damage on dealer fill-rate."
    - name: "fraud_flagged_claim_count"
      expr: COUNT(DISTINCT CASE WHEN is_fraud_flag = TRUE THEN transport_damage_claim_id END)
      comment: "Number of claims flagged for potential fraud; risk management KPI for insurance and compliance oversight."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_compound`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle compound capacity, occupancy, and operational metrics for yard management optimization — used in finished vehicle inventory management and logistics network planning."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_compound`"
  dimensions:
    - name: "compound_type"
      expr: compound_type
      comment: "Compound type (port/plant/distribution center/dealer) for network-level capacity analysis."
    - name: "vehicle_compound_status"
      expr: vehicle_compound_status
      comment: "Compound operational status for network availability and capacity planning."
    - name: "country_code"
      expr: country_code
      comment: "Country of compound for geographic network coverage and regional capacity analysis."
    - name: "region_code"
      expr: region_code
      comment: "Regional code for regional logistics network optimization."
    - name: "is_pdi_capable"
      expr: is_pdi_capable
      comment: "PDI capability flag for pre-delivery inspection capacity planning."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Temperature-controlled storage flag for EV battery and specialty vehicle storage planning."
    - name: "dangerous_goods_storage_flag"
      expr: dangerous_goods_storage_flag
      comment: "Dangerous goods storage capability for hazmat compliance and network routing."
    - name: "yard_management_system"
      expr: yard_management_system
      comment: "Yard management system in use for technology standardization and integration planning."
  measures:
    - name: "total_compounds"
      expr: COUNT(DISTINCT vehicle_compound_id)
      comment: "Total vehicle compounds in the network; baseline for logistics network footprint management."
    - name: "total_storage_area_sqft"
      expr: SUM(CAST(storage_area_sqft AS DOUBLE))
      comment: "Total storage area in square feet across all compounds; network capacity KPI for logistics investment decisions."
    - name: "avg_dwell_time_hours"
      expr: AVG(CAST(average_dwell_time_hours AS DOUBLE))
      comment: "Average vehicle dwell time in hours; critical KPI for compound throughput efficiency and working capital (vehicles in transit = tied-up capital)."
    - name: "avg_otd_target_percentage"
      expr: AVG(CAST(otd_target_percentage AS DOUBLE))
      comment: "Average OTD target percentage across compounds; used for network-level OTD commitment setting."
    - name: "pdi_capable_compound_count"
      expr: COUNT(DISTINCT CASE WHEN is_pdi_capable = TRUE THEN vehicle_compound_id END)
      comment: "Number of PDI-capable compounds; capacity planning KPI for pre-delivery inspection throughput."
    - name: "pdi_capable_compound_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_pdi_capable = TRUE THEN vehicle_compound_id END) / NULLIF(COUNT(DISTINCT vehicle_compound_id), 0), 2)
      comment: "Percentage of compounds with PDI capability; network readiness KPI for quality-at-delivery programs."
    - name: "ev_charging_capable_compound_count"
      expr: COUNT(DISTINCT CASE WHEN ev_charging_slot_count IS NOT NULL THEN vehicle_compound_id END)
      comment: "Number of compounds with EV charging capability; strategic KPI for EV logistics network readiness."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_in_transit_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "In-transit inventory visibility metrics for finished vehicle and parts pipeline management — used for working capital optimization, customs risk, and delivery promise accuracy."
  source: "`vibe_automotive_v1`.`logistics`.`in_transit_inventory`"
  dimensions:
    - name: "transit_status"
      expr: transit_status
      comment: "Current transit status (in-transit/delayed/customs-hold/delivered) for pipeline visibility."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level in-transit inventory analysis."
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status for import compliance and delay risk monitoring."
    - name: "load_type"
      expr: load_type
      comment: "Load type for capacity and cost analysis of in-transit inventory."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Hazardous material flag for dangerous goods compliance monitoring."
    - name: "temperature_control_flag"
      expr: temperature_control_flag
      comment: "Temperature control requirement for cold chain compliance monitoring."
    - name: "estimated_arrival_date"
      expr: DATE_TRUNC('month', estimated_arrival_date)
      comment: "Estimated arrival month for forward-looking inventory availability planning."
    - name: "actual_arrival_date"
      expr: DATE_TRUNC('month', actual_arrival_date)
      comment: "Actual arrival month for delivery performance trend analysis."
  measures:
    - name: "total_in_transit_records"
      expr: COUNT(DISTINCT in_transit_inventory_id)
      comment: "Total in-transit inventory records; baseline for pipeline visibility and working capital exposure."
    - name: "total_transport_cost"
      expr: SUM(CAST(transport_cost_amount AS DOUBLE))
      comment: "Total transport cost for in-transit inventory; working capital and logistics cost KPI."
    - name: "avg_transport_cost_per_unit"
      expr: AVG(CAST(transport_cost_amount AS DOUBLE))
      comment: "Average transport cost per in-transit unit; cost efficiency benchmarking KPI."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from in-transit inventory movements; Scope 3 ESG reporting KPI."
    - name: "total_fuel_consumption_liters"
      expr: SUM(CAST(fuel_consumption_liters AS DOUBLE))
      comment: "Total fuel consumed for in-transit movements; ESG and cost efficiency KPI."
    - name: "total_volume_cubic_meters"
      expr: SUM(CAST(volume_cubic_meters AS DOUBLE))
      comment: "Total volume of in-transit inventory in cubic meters; capacity utilization KPI."
    - name: "customs_hold_count"
      expr: COUNT(DISTINCT CASE WHEN customs_status = 'HOLD' THEN in_transit_inventory_id END)
      comment: "Number of in-transit units on customs hold; compliance risk KPI driving customs broker intervention."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_export_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Export declaration compliance and financial metrics for customs management, trade compliance, and duty cost control — used by trade compliance and finance teams."
  source: "`vibe_automotive_v1`.`logistics`.`export_declaration`"
  dimensions:
    - name: "export_declaration_status"
      expr: export_declaration_status
      comment: "Declaration status (submitted/cleared/rejected/pending) for customs pipeline management."
    - name: "clearance_status"
      expr: clearance_status
      comment: "Customs clearance status for compliance monitoring and delay risk identification."
    - name: "export_type"
      expr: export_type
      comment: "Export type (permanent/temporary/re-export) for trade flow classification."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level export compliance analysis."
    - name: "destination_country_code"
      expr: destination_country_code
      comment: "Destination country for market-level export volume and compliance analysis."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms code for trade term-level duty and cost analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Hazardous goods flag for dangerous goods export compliance monitoring."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Submission month for export declaration volume trend analysis."
  measures:
    - name: "total_export_declarations"
      expr: COUNT(DISTINCT export_declaration_id)
      comment: "Total export declarations; baseline volume for trade compliance workload management."
    - name: "total_declared_value"
      expr: SUM(CAST(declared_value_amount AS DOUBLE))
      comment: "Total declared export value; primary trade finance and customs duty base KPI."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total export duty paid; trade cost KPI for duty optimization and free trade agreement utilization."
    - name: "total_net_value"
      expr: SUM(CAST(net_value_amount AS DOUBLE))
      comment: "Total net export value; used for revenue recognition and trade statistics reporting."
    - name: "avg_duty_per_declaration"
      expr: AVG(CAST(duty_amount AS DOUBLE))
      comment: "Average duty amount per export declaration; benchmarking KPI for duty optimization programs."
    - name: "cleared_declaration_count"
      expr: COUNT(DISTINCT CASE WHEN clearance_status = 'CLEARED' THEN export_declaration_id END)
      comment: "Number of cleared export declarations; numerator for customs clearance rate."
    - name: "clearance_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN clearance_status = 'CLEARED' THEN export_declaration_id END) / NULLIF(COUNT(DISTINCT export_declaration_id), 0), 2)
      comment: "Export customs clearance rate; compliance KPI for trade operations efficiency and regulatory risk management."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total export volume in cubic meters; capacity and vessel planning KPI."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_import_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Import declaration compliance, duty cost, and landed cost metrics for customs management and import cost control — used by trade compliance, finance, and procurement teams."
  source: "`vibe_automotive_v1`.`logistics`.`import_declaration`"
  dimensions:
    - name: "import_declaration_status"
      expr: import_declaration_status
      comment: "Declaration status for customs pipeline management and compliance monitoring."
    - name: "import_type"
      expr: import_type
      comment: "Import type (permanent/temporary/CKD) for trade flow classification."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level import cost and compliance analysis."
    - name: "origin_country_code"
      expr: origin_country_code
      comment: "Origin country for sourcing-level duty and compliance analysis."
    - name: "port_of_entry"
      expr: port_of_entry
      comment: "Port of entry for port-level clearance performance and cost analysis."
    - name: "import_duty_paid_flag"
      expr: import_duty_paid_flag
      comment: "Duty payment status flag for cash flow and compliance monitoring."
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Regulatory compliance flag for import compliance risk monitoring."
    - name: "submission_timestamp"
      expr: DATE_TRUNC('month', submission_timestamp)
      comment: "Submission month for import declaration volume trend analysis."
  measures:
    - name: "total_import_declarations"
      expr: COUNT(DISTINCT import_declaration_id)
      comment: "Total import declarations; baseline volume for trade compliance workload management."
    - name: "total_customs_value"
      expr: SUM(CAST(customs_value_amount AS DOUBLE))
      comment: "Total customs value of imports; primary duty base and trade statistics KPI."
    - name: "total_duty_amount"
      expr: SUM(CAST(duty_amount AS DOUBLE))
      comment: "Total import duty paid; key landed cost component and duty optimization KPI."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost on imports; landed cost component for procurement cost analysis."
    - name: "total_insurance_cost"
      expr: SUM(CAST(insurance_cost AS DOUBLE))
      comment: "Total insurance cost on imports; landed cost component for total cost of ownership analysis."
    - name: "total_landed_cost"
      expr: SUM(CAST(total_landed_cost AS DOUBLE))
      comment: "Total landed cost of imports (duty + freight + insurance + other); primary procurement and finance KPI for import cost management."
    - name: "avg_duty_rate_percent"
      expr: AVG(CAST(duty_rate_percent AS DOUBLE))
      comment: "Average effective duty rate percentage; KPI for free trade agreement utilization and duty optimization programs."
    - name: "avg_total_import_cost"
      expr: AVG(CAST(import_cost_total AS DOUBLE))
      comment: "Average total import cost per declaration; benchmarking KPI for import cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vessel_voyage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel voyage capacity utilization and schedule adherence metrics for ocean freight management — used for RoRo/container capacity planning and shipping line performance reviews."
  source: "`vibe_automotive_v1`.`logistics`.`vessel_voyage`"
  dimensions:
    - name: "voyage_status"
      expr: voyage_status
      comment: "Voyage status (planned/in-transit/arrived/cancelled) for ocean freight pipeline visibility."
    - name: "voyage_type"
      expr: voyage_type
      comment: "Voyage type (RoRo/container/bulk) for fleet type-level capacity analysis."
    - name: "origin_port_code"
      expr: origin_port_code
      comment: "Origin port for trade lane-level volume and capacity analysis."
    - name: "destination_port_code"
      expr: destination_port_code
      comment: "Destination port for trade lane-level volume and capacity analysis."
    - name: "planned_departure_timestamp"
      expr: DATE_TRUNC('month', planned_departure_timestamp)
      comment: "Planned departure month for ocean freight capacity planning and booking management."
    - name: "planned_arrival_timestamp"
      expr: DATE_TRUNC('month', planned_arrival_timestamp)
      comment: "Planned arrival month for port receiving capacity planning."
  measures:
    - name: "total_voyages"
      expr: COUNT(DISTINCT vessel_voyage_id)
      comment: "Total vessel voyages; baseline for ocean freight capacity and shipping line management."
    - name: "total_voyage_cost"
      expr: SUM(CAST(cost_amount AS DOUBLE))
      comment: "Total ocean freight cost across all voyages; primary ocean logistics spend KPI."
    - name: "avg_voyage_cost"
      expr: AVG(CAST(cost_amount AS DOUBLE))
      comment: "Average cost per voyage; benchmarking KPI for shipping line rate negotiations."
    - name: "on_time_arrival_count"
      expr: COUNT(DISTINCT CASE WHEN actual_arrival_timestamp <= planned_arrival_timestamp THEN vessel_voyage_id END)
      comment: "Number of voyages arriving on or before planned arrival; numerator for vessel OTA rate."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN actual_arrival_timestamp <= planned_arrival_timestamp THEN vessel_voyage_id END) / NULLIF(COUNT(DISTINCT vessel_voyage_id), 0), 2)
      comment: "Vessel on-time arrival rate; primary ocean freight performance KPI for shipping line reviews and port planning."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_transport_rate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transport rate benchmarking and cost structure metrics for carrier rate management, lane pricing, and freight budget planning."
  source: "`vibe_automotive_v1`.`logistics`.`transport_rate`"
  dimensions:
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level rate benchmarking and cost analysis."
    - name: "transport_rate_status"
      expr: transport_rate_status
      comment: "Rate status (active/expired/pending) for rate validity management."
    - name: "container_type"
      expr: container_type
      comment: "Container type for equipment-level rate analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Rate unit of measure (per km/per unit/per kg) for rate comparison normalization."
    - name: "origin_location_code"
      expr: origin_location_code
      comment: "Origin location code for lane-level rate analysis."
    - name: "destination_location_code"
      expr: destination_location_code
      comment: "Destination location code for lane-level rate analysis."
    - name: "effective_from"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Rate effective start month for rate lifecycle and renewal management."
    - name: "effective_until"
      expr: DATE_TRUNC('month', effective_until)
      comment: "Rate expiry month for proactive rate renewal and budget planning."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Compliance flag for rate regulatory adherence monitoring."
  measures:
    - name: "total_rate_records"
      expr: COUNT(DISTINCT transport_rate_id)
      comment: "Total transport rate records; baseline for rate catalog completeness and coverage analysis."
    - name: "avg_rate_amount"
      expr: AVG(CAST(rate_amount AS DOUBLE))
      comment: "Average transport rate amount; primary benchmarking KPI for carrier rate negotiations and budget planning."
    - name: "avg_fuel_surcharge_percent"
      expr: AVG(CAST(fuel_surcharge_percent AS DOUBLE))
      comment: "Average fuel surcharge percentage; KPI for fuel cost exposure and hedging decisions."
    - name: "avg_accessorial_charges"
      expr: AVG(CAST(accessorial_charges AS DOUBLE))
      comment: "Average accessorial charges per rate record; measures hidden cost exposure beyond base rates."
    - name: "total_accessorial_charges"
      expr: SUM(CAST(accessorial_charges AS DOUBLE))
      comment: "Total accessorial charges across all rate records; cost exposure KPI for contract renegotiation."
    - name: "expiring_rates_90d_count"
      expr: COUNT(DISTINCT CASE WHEN effective_until BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, 90) THEN transport_rate_id END)
      comment: "Number of transport rates expiring within 90 days; procurement risk KPI for proactive rate renewal management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_pdi_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pre-delivery inspection quality metrics at logistics compounds — used for vehicle quality-at-delivery management, rework cost control, and compound quality performance reviews."
  source: "`vibe_automotive_v1`.`logistics`.`logistics_pdi_inspection`"
  dimensions:
    - name: "inspection_result"
      expr: inspection_result
      comment: "PDI inspection result (pass/fail/conditional) for quality gate performance analysis."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status (completed/pending/in-progress) for PDI throughput management."
    - name: "damage_found_flag"
      expr: damage_found_flag
      comment: "Damage found flag for damage incidence rate analysis."
    - name: "rework_required_flag"
      expr: rework_required_flag
      comment: "Rework required flag for rework cost and throughput impact analysis."
    - name: "inspection_date"
      expr: DATE_TRUNC('month', inspection_date)
      comment: "Inspection month for PDI quality trend analysis."
  measures:
    - name: "total_pdi_inspections"
      expr: COUNT(DISTINCT logistics_pdi_inspection_id)
      comment: "Total PDI inspections performed; baseline for PDI throughput and capacity planning."
    - name: "damage_found_count"
      expr: COUNT(DISTINCT CASE WHEN damage_found_flag = TRUE THEN logistics_pdi_inspection_id END)
      comment: "Number of PDI inspections where damage was found; quality incidence KPI for compound and carrier accountability."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN damage_found_flag = TRUE THEN logistics_pdi_inspection_id END) / NULLIF(COUNT(DISTINCT logistics_pdi_inspection_id), 0), 2)
      comment: "Percentage of vehicles with damage found at PDI; primary quality-at-delivery KPI for executive and dealer satisfaction management."
    - name: "rework_required_count"
      expr: COUNT(DISTINCT CASE WHEN rework_required_flag = TRUE THEN logistics_pdi_inspection_id END)
      comment: "Number of vehicles requiring rework at PDI; cost and throughput impact KPI for compound operations."
    - name: "rework_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rework_required_flag = TRUE THEN logistics_pdi_inspection_id END) / NULLIF(COUNT(DISTINCT logistics_pdi_inspection_id), 0), 2)
      comment: "Percentage of PDI inspections requiring rework; quality cost KPI driving compound process improvement."
    - name: "first_time_pass_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN inspection_result = 'PASS' AND damage_found_flag = FALSE THEN logistics_pdi_inspection_id END) / NULLIF(COUNT(DISTINCT logistics_pdi_inspection_id), 0), 2)
      comment: "First-time PDI pass rate; the primary quality-at-delivery KPI for dealer satisfaction and brand quality perception."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_ckd_kit_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "CKD (Completely Knocked Down) kit shipment metrics for international assembly operations — used for CKD supply chain performance, customs compliance, and cost management."
  source: "`vibe_automotive_v1`.`logistics`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "CKD shipment status for pipeline visibility and production supply risk management."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for CKD logistics channel analysis."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Customs/regulatory compliance status for CKD import compliance monitoring."
    - name: "incoterms_code"
      expr: incoterms_code
      comment: "Incoterms for CKD trade term-level cost and risk analysis."
    - name: "hazardous_material_flag"
      expr: hazardous_material_flag
      comment: "Hazardous material flag for dangerous goods compliance in CKD shipments."
    - name: "otd_flag"
      expr: otd_flag
      comment: "On-time delivery flag for CKD OTD performance analysis."
  measures:
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total CKD freight cost; primary logistics cost KPI for CKD program cost management."
    - name: "total_net_cost"
      expr: SUM(CAST(net_cost AS DOUBLE))
      comment: "Total net CKD shipment cost after discounts; P&L and cost center reporting KPI."
    - name: "total_weight_kg"
      expr: SUM(CAST(weight_kg AS DOUBLE))
      comment: "Total CKD shipment weight in kg; payload utilization and freight rate calculation input."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_route`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Logistics route performance, cost, and sustainability metrics for network optimization — used in route rationalization, carrier assignment, and ESG reporting."
  source: "`vibe_automotive_v1`.`logistics`.`route`"
  dimensions:
    - name: "route_status"
      expr: route_status
      comment: "Route status (active/inactive/under-review) for network availability management."
    - name: "route_type"
      expr: route_type
      comment: "Route type (primary/backup/express) for network resilience and cost analysis."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level route performance analysis."
    - name: "carrier_mode"
      expr: carrier_mode
      comment: "Carrier mode for carrier-level route performance segmentation."
    - name: "is_express"
      expr: is_express
      comment: "Express route flag for premium cost and speed trade-off analysis."
    - name: "last_mile_segment_flag"
      expr: last_mile_segment_flag
      comment: "Last-mile segment flag for last-mile cost and performance analysis."
    - name: "dangerous_goods_approved_flag"
      expr: dangerous_goods_approved_flag
      comment: "Dangerous goods approval flag for hazmat routing compliance."
    - name: "returnable_packaging_route_flag"
      expr: returnable_packaging_route_flag
      comment: "Returnable packaging route flag for circular logistics and container management."
    - name: "regulatory_region"
      expr: regulatory_region
      comment: "Regulatory region for compliance-aware route planning."
  measures:
    - name: "total_routes"
      expr: COUNT(DISTINCT route_id)
      comment: "Total routes in the logistics network; baseline for network coverage and rationalization."
    - name: "total_route_cost_usd"
      expr: SUM(CAST(cost_usd AS DOUBLE))
      comment: "Total route cost in USD; primary network cost KPI for logistics budget management."
    - name: "avg_route_cost_usd"
      expr: AVG(CAST(cost_usd AS DOUBLE))
      comment: "Average route cost in USD; benchmarking KPI for route optimization and carrier negotiations."
    - name: "avg_distance_km"
      expr: AVG(CAST(distance_km AS DOUBLE))
      comment: "Average route distance in km; network efficiency and emissions baseline KPI."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions across all routes; Scope 3 ESG reporting KPI for logistics decarbonization programs."
    - name: "avg_on_time_performance_pct"
      expr: AVG(CAST(on_time_performance_pct AS DOUBLE))
      comment: "Average on-time performance percentage by route; route-level OTD KPI for network optimization decisions."
    - name: "avg_fuel_consumption_l_per_100km"
      expr: AVG(CAST(fuel_consumption_l_per_100km AS DOUBLE))
      comment: "Average fuel consumption per 100km by route; ESG and cost efficiency KPI for green route planning."
    - name: "avg_max_load_capacity_tons"
      expr: AVG(CAST(max_load_capacity_tons AS DOUBLE))
      comment: "Average maximum load capacity in tons; capacity planning KPI for route-level throughput management."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_vehicle_handover`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vehicle handover execution metrics covering delivery performance, cost, and customer experience — used for dealer delivery quality management and D2C program performance."
  source: "`vibe_automotive_v1`.`logistics`.`vehicle_handover`"
  dimensions:
    - name: "handover_status"
      expr: handover_status
      comment: "Handover status (completed/pending/cancelled/rescheduled) for delivery pipeline management."
    - name: "handover_type"
      expr: handover_type
      comment: "Handover type (dealer/home-delivery/fleet) for channel-level delivery performance analysis."
    - name: "handover_condition"
      expr: handover_condition
      comment: "Vehicle condition at handover (excellent/good/damaged) for quality-at-delivery KPI."
    - name: "home_delivery_flag"
      expr: home_delivery_flag
      comment: "Home delivery flag for D2C last-mile delivery performance tracking."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for handover logistics channel analysis."
    - name: "export_import_flag"
      expr: export_import_flag
      comment: "Export/import indicator for cross-border handover compliance analysis."
    - name: "otd_flag"
      expr: otd_flag
      comment: "On-time delivery flag for handover OTD performance analysis."
    - name: "handover_timestamp"
      expr: DATE_TRUNC('month', handover_timestamp)
      comment: "Handover month for delivery volume trend and seasonal analysis."
  measures:
    - name: "total_handovers"
      expr: COUNT(DISTINCT vehicle_handover_id)
      comment: "Total vehicle handovers completed; baseline volume for delivery operations management."
    - name: "total_handover_fee_amount"
      expr: SUM(CAST(handover_fee_amount AS DOUBLE))
      comment: "Total handover fee revenue; financial KPI for delivery service revenue management."
    - name: "total_handover_fee_net"
      expr: SUM(CAST(handover_fee_net_amount AS DOUBLE))
      comment: "Total net handover fee after tax; P&L contribution from delivery services."
    - name: "otd_handover_count"
      expr: COUNT(DISTINCT CASE WHEN otd_flag = TRUE THEN vehicle_handover_id END)
      comment: "Number of vehicle handovers completed on time; numerator for handover OTD rate."
    - name: "otd_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN otd_flag = TRUE THEN vehicle_handover_id END) / NULLIF(COUNT(DISTINCT vehicle_handover_id), 0), 2)
      comment: "Vehicle handover on-time delivery rate; primary customer satisfaction KPI for delivery operations."
    - name: "home_delivery_count"
      expr: COUNT(DISTINCT CASE WHEN home_delivery_flag = TRUE THEN vehicle_handover_id END)
      comment: "Count of home/D2C deliveries; strategic KPI for direct-to-consumer channel growth measurement."
    - name: "home_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN home_delivery_flag = TRUE THEN vehicle_handover_id END) / NULLIF(COUNT(DISTINCT vehicle_handover_id), 0), 2)
      comment: "Percentage of handovers via home delivery; D2C channel penetration KPI for strategic sales channel decisions."
    - name: "total_emissions_kg_co2"
      expr: SUM(CAST(emissions_kg_co2 AS DOUBLE))
      comment: "Total CO2 emissions from vehicle handover logistics; Scope 3 ESG KPI for last-mile decarbonization."
$$;

CREATE OR REPLACE VIEW `vibe_automotive_v1`.`_metrics`.`logistics_load_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load plan capacity utilization and efficiency metrics for outbound logistics planning — used for transport capacity optimization, cost reduction, and dangerous goods compliance."
  source: "`vibe_automotive_v1`.`logistics`.`load_plan`"
  dimensions:
    - name: "load_plan_status"
      expr: load_plan_status
      comment: "Load plan status (draft/confirmed/executed/cancelled) for planning pipeline management."
    - name: "load_status"
      expr: load_status
      comment: "Load execution status for operational monitoring."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Transport mode for mode-level load plan efficiency analysis."
    - name: "planned_departure_date"
      expr: DATE_TRUNC('month', planned_departure_date)
      comment: "Planned departure month for outbound logistics volume planning."
    - name: "planned_delivery_date"
      expr: DATE_TRUNC('month', planned_delivery_date)
      comment: "Planned delivery month for dealer fill-rate planning."
  measures:
    - name: "total_load_plans"
      expr: COUNT(DISTINCT load_plan_id)
      comment: "Total load plans created; baseline for outbound logistics planning workload."
    - name: "avg_capacity_utilization_pct"
      expr: AVG(CAST(capacity_utilization_pct AS DOUBLE))
      comment: "Average load plan capacity utilization percentage; primary logistics efficiency KPI for cost-per-unit optimization."
    - name: "avg_utilization_percent"
      expr: AVG(CAST(utilization_percent AS DOUBLE))
      comment: "Average utilization percentage (alternate measure); used for cross-validation of capacity efficiency."
    - name: "total_planned_volume_cbm"
      expr: SUM(CAST(planned_volume_cbm AS DOUBLE))
      comment: "Total planned volume in cubic meters across all load plans; capacity demand KPI for transport procurement."
    - name: "total_planned_weight_kg"
      expr: SUM(CAST(planned_weight_kg AS DOUBLE))
      comment: "Total planned weight in kg across all load plans; payload utilization and freight rate calculation input."
    - name: "underutilized_load_plan_count"
      expr: COUNT(DISTINCT CASE WHEN capacity_utilization_pct < 80.0 THEN load_plan_id END)
      comment: "Number of load plans with less than 80% capacity utilization; cost efficiency KPI driving load consolidation decisions."
    - name: "underutilization_rate_pct"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN capacity_utilization_pct < 80.0 THEN load_plan_id END) / NULLIF(COUNT(DISTINCT load_plan_id), 0), 2)
      comment: "Percentage of load plans below 80% utilization; executive KPI for logistics cost efficiency and consolidation opportunity identification."
$$;