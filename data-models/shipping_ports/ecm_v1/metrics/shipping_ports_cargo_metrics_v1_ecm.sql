-- Metric views for domain: cargo | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 03:36:32

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Lading KPIs tracking freight revenue, cargo volume, weight, and dangerous goods handling across shipping lanes and carriers"
  source: "`shipping_ports_ecm`.`cargo`.`bill_of_lading`"
  dimensions:
    - name: "bol_status"
      expr: bol_status
      comment: "Status of the bill of lading (e.g., issued, released, amended)"
    - name: "bol_type"
      expr: bol_type
      comment: "Type of bill of lading (e.g., master, house, seaway)"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (e.g., prepaid, collect)"
    - name: "issuing_carrier_name"
      expr: issuing_carrier_name
      comment: "Name of the carrier issuing the BOL"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether cargo contains dangerous goods"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazard class for dangerous goods"
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month when the BOL was issued"
    - name: "freight_currency"
      expr: freight_currency
      comment: "Currency code for freight charges"
  measures:
    - name: "total_freight_revenue"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight revenue across all BOLs"
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE)) / 1000.0
      comment: "Total gross cargo weight in metric tons"
    - name: "total_net_weight_mt"
      expr: SUM(CAST(net_weight_kg AS DOUBLE)) / 1000.0
      comment: "Total net cargo weight in metric tons"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters"
    - name: "avg_freight_per_bol"
      expr: AVG(CAST(freight_amount AS DOUBLE))
      comment: "Average freight revenue per bill of lading"
    - name: "dangerous_goods_bol_count"
      expr: COUNT(DISTINCT CASE WHEN is_dangerous_goods = TRUE THEN bill_of_lading_id END)
      comment: "Count of BOLs containing dangerous goods"
    - name: "unique_shipping_lanes"
      expr: COUNT(DISTINCT CONCAT(pol_code, '-', pod_code))
      comment: "Number of unique origin-destination shipping lanes"
    - name: "bol_count"
      expr: COUNT(DISTINCT bill_of_lading_id)
      comment: "Total number of bills of lading"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container operations KPIs tracking utilization, dwell time, reefer performance, and hazmat handling efficiency"
  source: "`shipping_ports_ecm`.`cargo`.`container`"
  dimensions:
    - name: "container_status"
      expr: container_status
      comment: "Current operational status of the container"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating refrigerated container"
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating hazardous materials container"
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flag indicating overweight container"
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating oversized container"
    - name: "operator_code"
      expr: operator_code
      comment: "Container operator/shipping line code"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the container"
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month when container entered the terminal"
  measures:
    - name: "total_teu"
      expr: SUM(CAST(size_teu AS DOUBLE))
      comment: "Total container capacity in twenty-foot equivalent units"
    - name: "container_count"
      expr: COUNT(DISTINCT container_id)
      comment: "Total number of containers"
    - name: "reefer_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_reefer = TRUE THEN container_id END)
      comment: "Count of refrigerated containers"
    - name: "hazmat_container_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazmat = TRUE THEN container_id END)
      comment: "Count of hazardous materials containers"
    - name: "avg_tare_weight_kg"
      expr: AVG(CAST(tare_weight_kg AS DOUBLE))
      comment: "Average tare weight of containers in kilograms"
    - name: "avg_max_payload_kg"
      expr: AVG(CAST(max_payload_kg AS DOUBLE))
      comment: "Average maximum payload capacity in kilograms"
    - name: "total_cubic_capacity_cbm"
      expr: SUM(CAST(cubic_capacity_cbm AS DOUBLE))
      comment: "Total cubic capacity across all containers"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Shipment performance KPIs tracking cargo value, transshipment rates, reefer utilization, and dangerous goods compliance"
  source: "`shipping_ports_ecm`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current status of the shipment"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo being shipped"
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Flag indicating transshipment cargo"
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating dangerous goods shipment"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating refrigerated cargo"
    - name: "is_oversized"
      expr: is_oversized
      comment: "Flag indicating oversized cargo"
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of loading code"
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of discharge code"
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms"
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms"
    - name: "discharge_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month when cargo was discharged"
  measures:
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD"
    - name: "total_teu"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total shipment volume in TEU"
    - name: "total_feu"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total shipment volume in FEU (forty-foot equivalent units)"
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross cargo weight in metric tons"
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters"
    - name: "avg_declared_value_per_shipment"
      expr: AVG(CAST(declared_value_usd AS DOUBLE))
      comment: "Average declared value per shipment in USD"
    - name: "transshipment_count"
      expr: COUNT(DISTINCT CASE WHEN is_transshipment = TRUE THEN shipment_id END)
      comment: "Count of transshipment cargo movements"
    - name: "dangerous_goods_shipment_count"
      expr: COUNT(DISTINCT CASE WHEN is_dangerous_goods = TRUE THEN shipment_id END)
      comment: "Count of dangerous goods shipments"
    - name: "shipment_count"
      expr: COUNT(DISTINCT shipment_id)
      comment: "Total number of shipments"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_demurrage_detention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demurrage and detention financial KPIs tracking charges, waivers, disputes, and free-time utilization"
  source: "`shipping_ports_ecm`.`cargo`.`demurrage_detention`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge (demurrage or detention)"
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge"
    - name: "settlement_status"
      expr: settlement_status
      comment: "Payment settlement status"
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating disputed charge"
    - name: "cargo_type"
      expr: cargo_type
      comment: "Type of cargo"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for charges"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month when invoice was issued"
  measures:
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total demurrage and detention charges"
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net charges after waivers"
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total amount waived across all charges"
    - name: "avg_daily_rate"
      expr: AVG(CAST(daily_rate_amount AS DOUBLE))
      comment: "Average daily charge rate"
    - name: "disputed_charge_count"
      expr: COUNT(DISTINCT CASE WHEN dispute_flag = TRUE THEN demurrage_detention_id END)
      comment: "Count of disputed charges"
    - name: "charge_count"
      expr: COUNT(DISTINCT demurrage_detention_id)
      comment: "Total number of demurrage/detention charges"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_handling_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal handling operations KPIs tracking productivity, delays, moves efficiency, and dangerous goods handling"
  source: "`shipping_ports_ecm`.`cargo`.`handling_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the handling order"
    - name: "operation_type"
      expr: operation_type
      comment: "Type of handling operation (load, discharge, shift, restow)"
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the handling order"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating dangerous goods handling"
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating refrigerated cargo"
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag indicating oversized cargo"
    - name: "customs_hold_flag"
      expr: customs_hold_flag
      comment: "Flag indicating customs hold"
    - name: "thc_applicable_flag"
      expr: thc_applicable_flag
      comment: "Flag indicating terminal handling charge applicability"
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month when handling was planned to start"
  measures:
    - name: "total_teu_completed"
      expr: SUM(CAST(total_teu_completed AS DOUBLE))
      comment: "Total TEU handled across all completed operations"
    - name: "total_teu_planned"
      expr: SUM(CAST(total_teu_planned AS DOUBLE))
      comment: "Total TEU planned for handling"
    - name: "avg_gross_crane_productivity"
      expr: AVG(CAST(gross_crane_productivity_target AS DOUBLE))
      comment: "Average gross crane productivity target (moves per hour)"
    - name: "handling_order_count"
      expr: COUNT(DISTINCT handling_order_id)
      comment: "Total number of handling orders"
    - name: "dangerous_goods_order_count"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_flag = TRUE THEN handling_order_id END)
      comment: "Count of handling orders involving dangerous goods"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vessel manifest KPIs tracking cargo volume, container mix, declared value, and customs compliance"
  source: "`shipping_ports_ecm`.`cargo`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest"
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (import, export, transshipment)"
    - name: "customs_submission_status"
      expr: customs_submission_status
      comment: "Status of customs submission"
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating dangerous goods on manifest"
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating refrigerated cargo"
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag indicating oversized cargo"
    - name: "high_value_cargo_flag"
      expr: high_value_cargo_flag
      comment: "Flag indicating high-value cargo"
    - name: "quarantine_required_flag"
      expr: quarantine_required_flag
      comment: "Flag indicating quarantine requirement"
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of loading code"
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of discharge code"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month when manifest was submitted"
  measures:
    - name: "total_declared_value_usd"
      expr: SUM(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD across all manifests"
    - name: "total_teu"
      expr: SUM(CAST(total_teu_count AS DOUBLE))
      comment: "Total container volume in TEU"
    - name: "total_weight_mt"
      expr: SUM(CAST(total_weight_mt AS DOUBLE))
      comment: "Total cargo weight in metric tons"
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic meters"
    - name: "avg_declared_value_per_manifest"
      expr: AVG(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Average declared value per manifest in USD"
    - name: "manifest_count"
      expr: COUNT(DISTINCT manifest_id)
      comment: "Total number of manifests"
    - name: "dangerous_goods_manifest_count"
      expr: COUNT(DISTINCT CASE WHEN dangerous_goods_flag = TRUE THEN manifest_id END)
      comment: "Count of manifests containing dangerous goods"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_damage_claim`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo damage claims KPIs tracking claim value, settlement rates, liability assessment, and loss prevention"
  source: "`shipping_ports_ecm`.`cargo`.`damage_claim`"
  dimensions:
    - name: "claim_status"
      expr: claim_status
      comment: "Current status of the damage claim"
    - name: "damage_type"
      expr: damage_type
      comment: "Type of damage reported"
    - name: "liability_assessment"
      expr: liability_assessment
      comment: "Assessment of liability for the damage"
    - name: "claimant_type"
      expr: claimant_type
      comment: "Type of party filing the claim"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for claim amounts"
    - name: "lodgement_month"
      expr: DATE_TRUNC('MONTH', claim_lodgement_date)
      comment: "Month when claim was lodged"
  measures:
    - name: "total_estimated_loss_value"
      expr: SUM(CAST(estimated_loss_value AS DOUBLE))
      comment: "Total estimated loss value across all claims"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount AS DOUBLE))
      comment: "Total settlement amount paid out"
    - name: "avg_estimated_loss_per_claim"
      expr: AVG(CAST(estimated_loss_value AS DOUBLE))
      comment: "Average estimated loss value per claim"
    - name: "avg_settlement_per_claim"
      expr: AVG(CAST(settlement_amount AS DOUBLE))
      comment: "Average settlement amount per claim"
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight of damaged cargo in kilograms"
    - name: "claim_count"
      expr: COUNT(DISTINCT damage_claim_id)
      comment: "Total number of damage claims"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_verified_gross_mass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "VGM compliance KPIs tracking submission timeliness, verification status, and SOLAS compliance rates"
  source: "`shipping_ports_ecm`.`cargo`.`verified_gross_mass`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of VGM verification"
    - name: "weighing_method"
      expr: weighing_method
      comment: "Method used for weighing (Method 1 or Method 2)"
    - name: "submission_compliance_flag"
      expr: submission_compliance_flag
      comment: "Flag indicating compliance with submission deadline"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "terminal_code"
      expr: terminal_code
      comment: "Terminal code where VGM was verified"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_datetime)
      comment: "Month when VGM was submitted"
  measures:
    - name: "total_gross_mass_mt"
      expr: SUM(CAST(gross_mass_kg AS DOUBLE)) / 1000.0
      comment: "Total verified gross mass in metric tons"
    - name: "avg_gross_mass_kg"
      expr: AVG(CAST(gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per container in kilograms"
    - name: "vgm_count"
      expr: COUNT(DISTINCT verified_gross_mass_id)
      comment: "Total number of VGM declarations"
    - name: "compliant_submission_count"
      expr: COUNT(DISTINCT CASE WHEN submission_compliance_flag = TRUE THEN verified_gross_mass_id END)
      comment: "Count of VGM submissions meeting deadline compliance"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Container move operations KPIs tracking move efficiency, equipment utilization, and operational exceptions"
  source: "`shipping_ports_ecm`.`cargo`.`move`"
  dimensions:
    - name: "move_type"
      expr: move_type
      comment: "Type of container move operation"
    - name: "move_status"
      expr: move_status
      comment: "Current status of the move"
    - name: "kind"
      expr: kind
      comment: "Kind of move (load, discharge, shift, etc.)"
    - name: "stage"
      expr: stage
      comment: "Stage of the move operation"
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous cargo move"
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating refrigerated container move"
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating oversized container move"
    - name: "damage_reported"
      expr: damage_reported
      comment: "Flag indicating damage reported during move"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment used for the move"
    - name: "customs_status"
      expr: customs_status
      comment: "Customs clearance status"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month when move actually started"
  measures:
    - name: "total_cargo_weight_mt"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE)) / 1000.0
      comment: "Total cargo weight moved in metric tons"
    - name: "total_teu_moved"
      expr: SUM(CAST(container_size_teu AS DOUBLE))
      comment: "Total container volume moved in TEU"
    - name: "avg_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per move in minutes"
    - name: "move_count"
      expr: COUNT(DISTINCT move_id)
      comment: "Total number of container moves"
    - name: "hazardous_move_count"
      expr: COUNT(DISTINCT CASE WHEN is_hazardous = TRUE THEN move_id END)
      comment: "Count of moves involving hazardous cargo"
    - name: "damage_reported_count"
      expr: COUNT(DISTINCT CASE WHEN damage_reported = TRUE THEN move_id END)
      comment: "Count of moves with damage reported"
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_dangerous_goods_declaration`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dangerous goods compliance KPIs tracking IMDG declarations, inspection rates, and port authority acceptance"
  source: "`shipping_ports_ecm`.`cargo`.`dangerous_goods_declaration`"
  dimensions:
    - name: "port_authority_acceptance_status"
      expr: port_authority_acceptance_status
      comment: "Port authority acceptance status for dangerous goods"
    - name: "inspection_required_flag"
      expr: inspection_required_flag
      comment: "Flag indicating inspection requirement"
    - name: "imdg_class"
      expr: imdg_class
      comment: "IMDG hazard class"
    - name: "packing_group"
      expr: packing_group
      comment: "UN packing group (I, II, III)"
    - name: "marine_pollutant_flag"
      expr: marine_pollutant_flag
      comment: "Flag indicating marine pollutant"
    - name: "limited_quantity_flag"
      expr: limited_quantity_flag
      comment: "Flag indicating limited quantity exemption"
    - name: "excepted_quantity_flag"
      expr: excepted_quantity_flag
      comment: "Flag indicating excepted quantity exemption"
    - name: "pol_code"
      expr: pol_code
      comment: "Port of loading code"
    - name: "pod_code"
      expr: pod_code
      comment: "Port of discharge code"
    - name: "declaration_month"
      expr: DATE_TRUNC('MONTH', declaration_date)
      comment: "Month when declaration was made"
  measures:
    - name: "total_gross_quantity"
      expr: SUM(CAST(gross_quantity AS DOUBLE))
      comment: "Total gross quantity of dangerous goods declared"
    - name: "total_net_quantity"
      expr: SUM(CAST(net_quantity AS DOUBLE))
      comment: "Total net quantity of dangerous goods declared"
    - name: "avg_flash_point_celsius"
      expr: AVG(CAST(flash_point_celsius AS DOUBLE))
      comment: "Average flash point of flammable dangerous goods"
    - name: "declaration_count"
      expr: COUNT(DISTINCT dangerous_goods_declaration_id)
      comment: "Total number of dangerous goods declarations"
    - name: "inspection_required_count"
      expr: COUNT(DISTINCT CASE WHEN inspection_required_flag = TRUE THEN dangerous_goods_declaration_id END)
      comment: "Count of declarations requiring inspection"
    - name: "marine_pollutant_count"
      expr: COUNT(DISTINCT CASE WHEN marine_pollutant_flag = TRUE THEN dangerous_goods_declaration_id END)
      comment: "Count of marine pollutant declarations"
$$;