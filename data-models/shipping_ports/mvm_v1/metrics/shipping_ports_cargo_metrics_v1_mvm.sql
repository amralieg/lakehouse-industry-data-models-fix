-- Metric views for domain: cargo | Business: Shipping Ports | Version: 1 | Generated on: 2026-05-10 06:46:03

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_shipment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic KPI layer over cargo shipments. Tracks volume throughput, cargo value, weight, reefer/hazmat/transshipment mix, and delivery performance to steer port capacity planning, revenue forecasting, and trade-lane strategy."
  source: "`shipping_ports_ecm`.`cargo`.`shipment`"
  dimensions:
    - name: "shipment_status"
      expr: shipment_status
      comment: "Current lifecycle status of the shipment (e.g. In-Transit, Delivered, On-Hold). Used to segment active vs completed cargo pipelines."
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of Loading code. Enables trade-lane origin analysis and volume attribution by loading port."
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of Discharge code. Enables trade-lane destination analysis and discharge throughput reporting."
    - name: "final_destination_port_code"
      expr: final_destination_port_code
      comment: "Ultimate destination port code. Supports transshipment routing analysis and final-mile trade intelligence."
    - name: "incoterm"
      expr: incoterm
      comment: "International commercial terms (e.g. FOB, CIF, EXW). Drives freight revenue attribution and liability analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (Prepaid / Collect). Used to reconcile freight revenue and receivables."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether the shipment contains dangerous goods. Drives hazmat compliance reporting and berth allocation."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating whether the shipment requires refrigerated handling. Drives reefer plug capacity planning."
    - name: "is_transshipment"
      expr: is_transshipment
      comment: "Flag indicating whether the shipment is a transshipment cargo. Supports hub-port throughput and feeder-service analysis."
    - name: "is_oversized"
      expr: is_oversized
      comment: "Flag indicating whether the shipment contains oversized cargo. Drives special-handling resource planning."
    - name: "cargo_condition"
      expr: cargo_condition
      comment: "Physical condition of cargo at receipt (e.g. Good, Damaged). Used for cargo quality and claims monitoring."
    - name: "discharge_date_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Month of discharge date. Enables monthly throughput trend analysis."
    - name: "gate_out_date_month"
      expr: DATE_TRUNC('MONTH', gate_out_date)
      comment: "Month of gate-out date. Supports dwell-time and yard-clearance trend reporting."
  measures:
    - name: "total_shipments"
      expr: COUNT(1)
      comment: "Total number of shipment records. Baseline throughput KPI used in all capacity and volume dashboards."
    - name: "total_teu_count"
      expr: SUM(CAST(teu_count AS DOUBLE))
      comment: "Total TEU (Twenty-foot Equivalent Units) across all shipments. Primary port throughput KPI used in capacity planning, tariff benchmarking, and trade-lane reporting."
    - name: "total_feu_count"
      expr: SUM(CAST(feu_count AS DOUBLE))
      comment: "Total FEU (Forty-foot Equivalent Units) across all shipments. Complements TEU count for equipment-mix and slot-utilisation analysis."
    - name: "total_gross_weight_mt"
      expr: SUM(CAST(gross_weight_mt AS DOUBLE))
      comment: "Total gross cargo weight in metric tonnes. Drives berth load planning, crane capacity scheduling, and port dues calculation."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD across all shipments. Key revenue-risk and insurance exposure KPI for port authority and customs reporting."
    - name: "avg_declared_value_per_teu_usd"
      expr: ROUND(SUM(CAST(declared_value_usd AS DOUBLE)) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Average declared cargo value per TEU in USD. Measures cargo value density per slot — informs premium-cargo strategy and tariff optimisation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in cubic metres. Supports stowage planning, warehouse utilisation, and LCL consolidation analysis."
    - name: "reefer_shipment_count"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN 1 END)
      comment: "Number of reefer shipments. Drives cold-chain infrastructure investment decisions and reefer plug capacity planning."
    - name: "dangerous_goods_shipment_count"
      expr: COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END)
      comment: "Number of dangerous goods shipments. Critical for IMDG compliance monitoring, berth segregation planning, and regulatory reporting."
    - name: "transshipment_shipment_count"
      expr: COUNT(CASE WHEN is_transshipment = TRUE THEN 1 END)
      comment: "Number of transshipment shipments. Measures hub-port connectivity value and feeder-service dependency."
    - name: "transshipment_teu_ratio_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_transshipment = TRUE THEN teu_count ELSE 0 END) / NULLIF(SUM(CAST(teu_count AS DOUBLE)), 0), 2)
      comment: "Percentage of total TEU that is transshipment cargo. Strategic KPI for hub-port positioning and feeder-network investment decisions."
    - name: "avg_teu_per_shipment"
      expr: ROUND(SUM(CAST(teu_count AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average TEU per shipment. Indicates cargo consolidation efficiency and booking size trends."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_container`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer over individual containers. Tracks equipment utilisation, reefer/hazmat mix, weight compliance, dwell time, and yard positioning to drive terminal efficiency and equipment management decisions."
  source: "`shipping_ports_ecm`.`cargo`.`container`"
  dimensions:
    - name: "container_status"
      expr: container_status
      comment: "Current operational status of the container (e.g. In-Yard, Loaded, Gated-Out). Primary dimension for yard inventory and throughput reporting."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading code on the container record. Enables origin-based container flow analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code on the container record. Enables destination-based container flow analysis."
    - name: "owner_code"
      expr: owner_code
      comment: "Container owner/operator code (ISO BIC prefix). Supports equipment ownership and leasing cost attribution."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating whether the container is a reefer unit. Drives cold-chain capacity and plug-point planning."
    - name: "is_hazmat"
      expr: is_hazmat
      comment: "Flag indicating whether the container carries hazardous materials. Drives IMDG compliance and segregation planning."
    - name: "is_overweight"
      expr: is_overweight
      comment: "Flag indicating whether the container exceeds weight limits. Drives VGM compliance and crane load-planning alerts."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating whether the container is oversized. Drives special-handling resource and berth allocation planning."
    - name: "condition_grade"
      expr: condition_grade
      comment: "Physical condition grade of the container (e.g. A, B, C). Supports equipment maintenance prioritisation and damage liability reporting."
    - name: "current_location_code"
      expr: current_location_code
      comment: "Current yard or terminal location code. Enables real-time yard inventory and slot utilisation analysis."
    - name: "gate_in_month"
      expr: DATE_TRUNC('MONTH', gate_in_timestamp)
      comment: "Month of container gate-in. Enables monthly inbound volume trend analysis."
    - name: "gate_out_month"
      expr: DATE_TRUNC('MONTH', gate_out_timestamp)
      comment: "Month of container gate-out. Enables monthly outbound volume and dwell-time trend analysis."
  measures:
    - name: "total_containers"
      expr: COUNT(1)
      comment: "Total number of container records. Baseline equipment inventory KPI."
    - name: "total_teu_capacity"
      expr: SUM(CAST(size_teu AS DOUBLE))
      comment: "Total TEU capacity across all containers. Measures slot utilisation and equipment pool size for capacity planning."
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight of all containers in kg. Used in gross weight compliance and vessel stability calculations."
    - name: "total_max_payload_kg"
      expr: SUM(CAST(max_payload_kg AS DOUBLE))
      comment: "Total maximum payload capacity across all containers in kg. Measures theoretical cargo-carrying capacity of the equipment pool."
    - name: "total_cubic_capacity_cbm"
      expr: SUM(CAST(cubic_capacity_cbm AS DOUBLE))
      comment: "Total cubic capacity of all containers in CBM. Supports stowage planning and LCL utilisation analysis."
    - name: "reefer_container_count"
      expr: COUNT(CASE WHEN is_reefer = TRUE THEN 1 END)
      comment: "Number of reefer containers in the fleet. Drives cold-chain infrastructure investment and plug-point capacity decisions."
    - name: "hazmat_container_count"
      expr: COUNT(CASE WHEN is_hazmat = TRUE THEN 1 END)
      comment: "Number of hazmat containers. Critical for IMDG compliance monitoring and segregation planning."
    - name: "overweight_container_count"
      expr: COUNT(CASE WHEN is_overweight = TRUE THEN 1 END)
      comment: "Number of overweight containers. Drives VGM compliance alerts and crane load-planning interventions."
    - name: "overweight_container_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_overweight = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of containers flagged as overweight. Key compliance KPI — high rates trigger regulatory and safety interventions."
    - name: "avg_reefer_set_temp_celsius"
      expr: AVG(CAST(reefer_set_temp_celsius AS DOUBLE))
      comment: "Average reefer set-point temperature in Celsius across all reefer containers. Monitors cold-chain compliance and temperature-sensitive cargo management."
    - name: "avg_max_gross_weight_kg"
      expr: AVG(CAST(max_gross_weight_kg AS DOUBLE))
      comment: "Average maximum gross weight rating per container in kg. Supports equipment fleet profiling and load-planning benchmarking."
    - name: "distinct_container_owners"
      expr: COUNT(DISTINCT owner_code)
      comment: "Number of distinct container owner/operator codes. Measures equipment diversity and leasing dependency in the terminal's container pool."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_demurrage_detention`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial KPI layer over demurrage and detention charges. Tracks charge volumes, waiver rates, dispute rates, and settlement performance — directly informing revenue recovery, free-time policy, and customer dispute management."
  source: "`shipping_ports_ecm`.`cargo`.`demurrage_detention`"
  dimensions:
    - name: "charge_type"
      expr: charge_type
      comment: "Type of charge: Demurrage (port/terminal dwell) or Detention (equipment off-hire). Primary split for financial reporting."
    - name: "charge_status"
      expr: charge_status
      comment: "Current status of the charge (e.g. Pending, Invoiced, Settled, Waived). Drives accounts-receivable and revenue-recognition reporting."
    - name: "settlement_status"
      expr: settlement_status
      comment: "Settlement state of the charge (e.g. Outstanding, Partially Paid, Fully Settled). Drives cash-collection and aging analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the charge. Enables multi-currency revenue reporting and FX exposure analysis."
    - name: "dispute_flag"
      expr: dispute_flag
      comment: "Flag indicating whether the charge is under dispute. Drives dispute-rate KPIs and customer relationship management."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate the charge (e.g. Per-Day, Tiered). Supports tariff policy review and rate-card optimisation."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code. Enables port-level demurrage revenue and free-time policy benchmarking."
    - name: "container_size_type"
      expr: container_size_type
      comment: "Container size and type (e.g. 20GP, 40HC). Supports equipment-type-level charge analysis and tariff calibration."
    - name: "invoice_date_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice date. Enables monthly demurrage/detention revenue trend analysis."
    - name: "payment_due_date_month"
      expr: DATE_TRUNC('MONTH', payment_due_date)
      comment: "Month of payment due date. Supports aging and overdue-payment trend reporting."
  measures:
    - name: "total_charge_records"
      expr: COUNT(1)
      comment: "Total number of demurrage/detention charge records. Baseline volume KPI for charge pipeline monitoring."
    - name: "total_charge_amount"
      expr: SUM(CAST(total_charge_amount AS DOUBLE))
      comment: "Total gross demurrage and detention charges raised in the period. Primary revenue KPI for port tariff and free-time policy decisions."
    - name: "total_net_charge_amount"
      expr: SUM(CAST(net_charge_amount AS DOUBLE))
      comment: "Total net demurrage/detention charges after waivers. Measures actual revenue collected and informs waiver policy impact."
    - name: "total_waiver_amount"
      expr: SUM(CAST(waiver_amount AS DOUBLE))
      comment: "Total amount waived across all demurrage/detention charges. Quantifies revenue concessions — high values trigger free-time policy review."
    - name: "waiver_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(waiver_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_charge_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of gross charges waived. Key policy KPI — high waiver rates indicate over-generous free-time allowances or weak enforcement."
    - name: "dispute_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dispute_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of charge records under dispute. Measures tariff clarity and customer satisfaction — high rates signal billing or policy issues."
    - name: "avg_daily_rate_amount"
      expr: AVG(CAST(daily_rate_amount AS DOUBLE))
      comment: "Average daily demurrage/detention rate across all charge records. Benchmarks tariff competitiveness against market rates."
    - name: "disputed_charge_amount"
      expr: SUM(CASE WHEN dispute_flag = TRUE THEN total_charge_amount ELSE 0 END)
      comment: "Total gross charge amount currently under dispute. Measures at-risk revenue requiring resolution to protect cash flow."
    - name: "distinct_liable_parties"
      expr: COUNT(DISTINCT liable_party_port_community_participant_id)
      comment: "Number of distinct parties liable for demurrage/detention charges. Measures customer exposure concentration and collection risk."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_handling_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational KPI layer over terminal handling orders. Tracks crane productivity, move completion rates, delay attribution, and operational efficiency to steer terminal performance and vessel turnaround decisions."
  source: "`shipping_ports_ecm`.`cargo`.`handling_order`"
  dimensions:
    - name: "operation_type"
      expr: operation_type
      comment: "Type of handling operation (e.g. Discharge, Load, Shift, Restow). Primary dimension for productivity benchmarking by operation."
    - name: "order_status"
      expr: order_status
      comment: "Current status of the handling order (e.g. Planned, In-Progress, Completed, Cancelled). Drives operational pipeline and backlog reporting."
    - name: "billing_status"
      expr: billing_status
      comment: "Billing status of the handling order. Drives revenue recognition and unbilled-work reporting."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating whether the handling order involves dangerous goods. Drives IMDG compliance and special-handling resource planning."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating whether the handling order involves reefer cargo. Drives cold-chain handling resource allocation."
    - name: "oversized_cargo_flag"
      expr: oversized_cargo_flag
      comment: "Flag indicating whether the handling order involves oversized cargo. Drives special-equipment and berth-clearance planning."
    - name: "customs_hold_flag"
      expr: customs_hold_flag
      comment: "Flag indicating whether the handling order is subject to a customs hold. Drives compliance-related delay attribution."
    - name: "thc_applicable_flag"
      expr: thc_applicable_flag
      comment: "Flag indicating whether Terminal Handling Charges apply. Drives THC revenue recognition and billing completeness checks."
    - name: "planned_start_month"
      expr: DATE_TRUNC('MONTH', planned_start_datetime)
      comment: "Month of planned handling start. Enables monthly workload planning and capacity trend analysis."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_datetime)
      comment: "Month of actual handling start. Enables monthly throughput and schedule-adherence trend analysis."
  measures:
    - name: "total_handling_orders"
      expr: COUNT(1)
      comment: "Total number of handling orders. Baseline operational throughput KPI for terminal workload monitoring."
    - name: "total_teu_planned"
      expr: SUM(CAST(total_teu_planned AS DOUBLE))
      comment: "Total TEU planned across all handling orders. Drives berth and crane capacity planning and vessel schedule commitments."
    - name: "total_teu_completed"
      expr: SUM(CAST(total_teu_completed AS DOUBLE))
      comment: "Total TEU actually completed across all handling orders. Measures actual throughput delivered against plan."
    - name: "teu_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_teu_completed AS DOUBLE)) / NULLIF(SUM(CAST(total_teu_planned AS DOUBLE)), 0), 2)
      comment: "Percentage of planned TEU actually completed. Key terminal productivity KPI — low rates trigger operational investigation and vessel delay penalties."
    - name: "avg_gross_crane_productivity_target"
      expr: AVG(CAST(gross_crane_productivity_target AS DOUBLE))
      comment: "Average gross crane productivity target (moves per hour) across handling orders. Benchmarks planned productivity against industry standards and contractual SLAs."
    - name: "total_equipment_delay_minutes"
      expr: COUNT(CASE WHEN equipment_delay_minutes IS NOT NULL THEN 1 END)
      comment: "Count of handling orders with equipment delays recorded. Proxy for equipment reliability impact on terminal throughput — drives maintenance investment decisions."
    - name: "total_vessel_delay_minutes"
      expr: COUNT(CASE WHEN vessel_delay_minutes IS NOT NULL THEN 1 END)
      comment: "Count of handling orders with vessel delays recorded. Measures vessel-side delay frequency — informs port dues, demurrage, and shipping-line SLA management."
    - name: "total_weather_delay_minutes"
      expr: COUNT(CASE WHEN weather_delay_minutes IS NOT NULL THEN 1 END)
      comment: "Count of handling orders with weather delays recorded. Supports force-majeure reporting and seasonal capacity planning."
    - name: "dangerous_goods_order_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handling orders involving dangerous goods. Drives IMDG compliance resource planning and risk exposure reporting."
    - name: "customs_hold_order_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_hold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of handling orders subject to customs holds. Measures compliance-driven operational disruption — high rates trigger customs authority engagement."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_manifest`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance and throughput KPI layer over cargo manifests. Tracks submission timeliness, customs inspection rates, dangerous goods and reefer cargo mix, and declared cargo value to support port authority oversight and trade facilitation."
  source: "`shipping_ports_ecm`.`cargo`.`manifest`"
  dimensions:
    - name: "manifest_status"
      expr: manifest_status
      comment: "Current status of the manifest (e.g. Draft, Submitted, Accepted, Rejected). Primary dimension for submission pipeline and compliance reporting."
    - name: "manifest_type"
      expr: manifest_type
      comment: "Type of manifest (e.g. Import, Export, Transshipment, Coastal). Enables trade-direction analysis and regulatory reporting segmentation."
    - name: "customs_submission_status"
      expr: customs_submission_status
      comment: "Status of customs submission for the manifest. Drives customs compliance rate reporting and trade facilitation KPIs."
    - name: "pol_port_code"
      expr: pol_port_code
      comment: "Port of Loading code on the manifest. Enables origin-based manifest volume and compliance analysis."
    - name: "pod_port_code"
      expr: pod_port_code
      comment: "Port of Discharge code on the manifest. Enables destination-based manifest volume and compliance analysis."
    - name: "dangerous_goods_flag"
      expr: dangerous_goods_flag
      comment: "Flag indicating whether the manifest contains dangerous goods. Drives IMDG compliance and port authority notification reporting."
    - name: "reefer_cargo_flag"
      expr: reefer_cargo_flag
      comment: "Flag indicating whether the manifest contains reefer cargo. Drives cold-chain infrastructure and inspection resource planning."
    - name: "customs_inspection_required_flag"
      expr: customs_inspection_required_flag
      comment: "Flag indicating whether customs inspection is required. Drives inspection resource planning and dwell-time impact analysis."
    - name: "high_value_cargo_flag"
      expr: high_value_cargo_flag
      comment: "Flag indicating whether the manifest contains high-value cargo. Drives security and insurance risk reporting."
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', submission_timestamp)
      comment: "Month of manifest submission. Enables monthly submission volume and timeliness trend analysis."
  measures:
    - name: "total_manifests"
      expr: COUNT(1)
      comment: "Total number of manifests processed. Baseline trade volume KPI for port authority and customs reporting."
    - name: "total_declared_value_usd"
      expr: SUM(CAST(total_declared_value_usd AS DOUBLE))
      comment: "Total declared cargo value in USD across all manifests. Key customs revenue and trade-value KPI for port authority and government reporting."
    - name: "total_teu_count"
      expr: SUM(CAST(total_teu_count AS DOUBLE))
      comment: "Total TEU count declared across all manifests. Primary throughput KPI for port capacity and trade-lane reporting."
    - name: "total_weight_mt"
      expr: SUM(CAST(total_weight_mt AS DOUBLE))
      comment: "Total declared cargo weight in metric tonnes across all manifests. Drives berth load planning and port dues calculation."
    - name: "total_volume_cbm"
      expr: SUM(CAST(total_volume_cbm AS DOUBLE))
      comment: "Total declared cargo volume in CBM across all manifests. Supports stowage and warehouse capacity planning."
    - name: "customs_inspection_required_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN customs_inspection_required_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of manifests requiring customs inspection. Measures compliance burden and dwell-time risk — high rates signal trade facilitation improvement opportunities."
    - name: "dangerous_goods_manifest_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN dangerous_goods_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of manifests containing dangerous goods. Drives IMDG compliance resource planning and port authority risk reporting."
    - name: "avg_declared_value_per_teu_usd"
      expr: ROUND(SUM(CAST(total_declared_value_usd AS DOUBLE)) / NULLIF(SUM(CAST(total_teu_count AS DOUBLE)), 0), 2)
      comment: "Average declared cargo value per TEU in USD across manifests. Measures cargo value density — informs premium-cargo strategy and customs duty benchmarking."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines with manifests in the period. Measures port connectivity and shipping-line diversity — key for commercial and trade-lane strategy."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_bill_of_lading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document and freight KPI layer over Bills of Lading. Tracks freight revenue, cargo weight and volume, dangerous goods exposure, amendment rates, and release performance to support freight billing, compliance, and document management decisions."
  source: "`shipping_ports_ecm`.`cargo`.`bill_of_lading`"
  dimensions:
    - name: "bol_status"
      expr: bol_status
      comment: "Current status of the Bill of Lading (e.g. Draft, Issued, Released, Surrendered). Primary dimension for document lifecycle and freight release reporting."
    - name: "bol_type"
      expr: bol_type
      comment: "Type of Bill of Lading (e.g. Original, Seaway, Telex Release). Drives document management and release-type analysis."
    - name: "release_status"
      expr: release_status
      comment: "Release status of the Bill of Lading. Drives cargo release pipeline and freight clearance reporting."
    - name: "release_type"
      expr: release_type
      comment: "Method of release (e.g. Original, Express, Telex). Supports digital trade facilitation and release-channel analysis."
    - name: "freight_terms"
      expr: freight_terms
      comment: "Freight payment terms (Prepaid / Collect). Drives freight revenue attribution and receivables management."
    - name: "freight_currency"
      expr: freight_currency
      comment: "Currency of freight charges on the BOL. Enables multi-currency freight revenue reporting and FX exposure analysis."
    - name: "is_dangerous_goods"
      expr: is_dangerous_goods
      comment: "Flag indicating whether the BOL covers dangerous goods. Drives IMDG compliance and port authority notification reporting."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading code on the BOL. Enables origin-based freight revenue and volume analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code on the BOL. Enables destination-based freight revenue and volume analysis."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of BOL issue date. Enables monthly freight revenue and document issuance trend analysis."
  measures:
    - name: "total_bols"
      expr: COUNT(1)
      comment: "Total number of Bills of Lading issued. Baseline document volume KPI for freight and trade reporting."
    - name: "total_freight_amount"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight charges across all Bills of Lading. Primary freight revenue KPI for shipping-line and port revenue reporting."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross cargo weight in kg across all BOLs. Drives port dues calculation and vessel load planning."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net cargo weight in kg across all BOLs. Supports customs duty calculation and cargo value benchmarking."
    - name: "total_volume_cbm"
      expr: SUM(CAST(volume_cbm AS DOUBLE))
      comment: "Total cargo volume in CBM across all BOLs. Supports stowage planning and freight rate (W/M) calculation."
    - name: "avg_freight_amount_per_bol"
      expr: ROUND(SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(COUNT(1), 0), 2)
      comment: "Average freight amount per Bill of Lading. Measures freight yield per shipment — informs tariff and rate-card optimisation."
    - name: "dangerous_goods_bol_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_dangerous_goods = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of BOLs covering dangerous goods. Drives IMDG compliance monitoring and port authority risk reporting."
    - name: "amended_bol_count"
      expr: COUNT(CASE WHEN amendment_count IS NOT NULL AND amendment_count != '0' THEN 1 END)
      comment: "Number of BOLs that have been amended at least once. Measures document quality and amendment workload — high rates indicate booking or data quality issues."
    - name: "distinct_shipping_lines"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines represented in BOLs. Measures port connectivity and commercial diversity."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_move`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Terminal operations KPI layer over individual container moves. Tracks move throughput, duration efficiency, hazardous cargo handling, damage rates, and equipment utilisation to drive crane productivity and yard operations decisions."
  source: "`shipping_ports_ecm`.`cargo`.`move`"
  dimensions:
    - name: "move_type"
      expr: move_type
      comment: "Type of container move (e.g. Discharge, Load, Shift, Delivery, Receive). Primary dimension for terminal productivity analysis by operation type."
    - name: "move_status"
      expr: move_status
      comment: "Current status of the move (e.g. Planned, In-Progress, Completed, Exception). Drives operational pipeline and exception management reporting."
    - name: "stage"
      expr: stage
      comment: "Operational stage of the move (e.g. Vessel, Yard, Gate). Enables stage-level productivity and bottleneck analysis."
    - name: "kind"
      expr: kind
      comment: "Move kind classification (e.g. Full, Empty). Drives equipment utilisation and empty-repositioning cost analysis."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating whether the move involves hazardous cargo. Drives IMDG compliance and special-handling resource planning."
    - name: "is_reefer"
      expr: is_reefer
      comment: "Flag indicating whether the move involves a reefer container. Drives cold-chain handling resource allocation."
    - name: "is_oversize"
      expr: is_oversize
      comment: "Flag indicating whether the move involves an oversized container. Drives special-equipment and clearance planning."
    - name: "damage_reported"
      expr: damage_reported
      comment: "Flag indicating whether damage was reported during the move. Drives cargo damage rate KPIs and liability management."
    - name: "destination_location_type"
      expr: destination_location_type
      comment: "Type of destination location (e.g. Vessel, Yard, Gate, Warehouse). Enables flow-path analysis and yard layout optimisation."
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month of actual move start. Enables monthly throughput trend and productivity benchmarking."
  measures:
    - name: "total_moves"
      expr: COUNT(1)
      comment: "Total number of container moves executed. Primary terminal throughput KPI — the foundational measure for all productivity analysis."
    - name: "total_cargo_weight_kg"
      expr: SUM(CAST(cargo_weight_kg AS DOUBLE))
      comment: "Total cargo weight handled in kg across all moves. Drives crane load planning, berth structural assessments, and port dues calculation."
    - name: "total_teu_moved"
      expr: SUM(CAST(container_size_teu AS DOUBLE))
      comment: "Total TEU moved across all container moves. Measures actual terminal throughput in TEU — the industry-standard productivity metric."
    - name: "avg_move_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average duration per container move in minutes. Measures crane and equipment cycle time — directly drives gross crane productivity (GCP) calculations."
    - name: "damage_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN damage_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of moves resulting in reported cargo damage. Key quality KPI — high rates trigger operational investigation, insurance claims, and customer compensation."
    - name: "hazardous_move_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of moves involving hazardous cargo. Drives IMDG compliance resource planning and risk exposure reporting."
    - name: "total_teu_per_hour"
      expr: ROUND(SUM(CAST(container_size_teu AS DOUBLE)) / NULLIF(SUM(CAST(duration_minutes AS DOUBLE)) / 60.0, 0), 2)
      comment: "Gross TEU throughput rate per hour across all moves. Approximates terminal crane productivity — the primary operational efficiency KPI for terminal operators and shipping lines."
    - name: "exception_move_count"
      expr: COUNT(CASE WHEN exception_code IS NOT NULL THEN 1 END)
      comment: "Number of moves with exception codes recorded. Measures operational disruption frequency — drives root-cause analysis and process improvement initiatives."
    - name: "distinct_equipment_used"
      expr: COUNT(DISTINCT equipment_id)
      comment: "Number of distinct equipment units used for moves. Measures equipment utilisation breadth and fleet deployment efficiency."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_delivery_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cargo release and delivery KPI layer over delivery orders. Tracks release cycle times, clearance rates, demurrage/detention clearance, and revalidation rates to drive port gate efficiency and cargo release performance."
  source: "`shipping_ports_ecm`.`cargo`.`delivery_order`"
  dimensions:
    - name: "delivery_order_status"
      expr: delivery_order_status
      comment: "Current status of the delivery order (e.g. Issued, Presented, Released, Cancelled). Primary dimension for cargo release pipeline reporting."
    - name: "release_type"
      expr: release_type
      comment: "Method of cargo release (e.g. Original, Telex, Express). Supports digital trade facilitation and release-channel analysis."
    - name: "freight_clearance_status"
      expr: freight_clearance_status
      comment: "Status of freight payment clearance. Drives freight receivables and cargo-hold management reporting."
    - name: "port_dues_clearance_status"
      expr: port_dues_clearance_status
      comment: "Status of port dues clearance. Drives port revenue collection and cargo-hold management reporting."
    - name: "demurrage_cleared_flag"
      expr: demurrage_cleared_flag
      comment: "Flag indicating whether demurrage charges have been cleared. Drives demurrage revenue collection and cargo release gate-keeping."
    - name: "detention_cleared_flag"
      expr: detention_cleared_flag
      comment: "Flag indicating whether detention charges have been cleared. Drives detention revenue collection and equipment release management."
    - name: "port_of_discharge_code"
      expr: port_of_discharge_code
      comment: "Port of discharge code on the delivery order. Enables port-level release performance and clearance rate analysis."
    - name: "terminal_code"
      expr: terminal_code
      comment: "Terminal code where the delivery order is processed. Enables terminal-level release efficiency benchmarking."
    - name: "issue_date_month"
      expr: DATE_TRUNC('MONTH', issue_date)
      comment: "Month of delivery order issue date. Enables monthly release volume and cycle-time trend analysis."
    - name: "release_datetime_month"
      expr: DATE_TRUNC('MONTH', release_datetime)
      comment: "Month of actual cargo release. Enables monthly release throughput and clearance performance trend analysis."
  measures:
    - name: "total_delivery_orders"
      expr: COUNT(1)
      comment: "Total number of delivery orders issued. Baseline cargo release volume KPI."
    - name: "released_delivery_order_count"
      expr: COUNT(CASE WHEN delivery_order_status = 'Released' THEN 1 END)
      comment: "Number of delivery orders with Released status. Measures cargo release throughput and gate efficiency."
    - name: "release_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_order_status = 'Released' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders successfully released. Key gate efficiency KPI — low rates indicate clearance bottlenecks or compliance holds."
    - name: "demurrage_cleared_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN demurrage_cleared_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with demurrage charges cleared. Measures demurrage revenue collection effectiveness and cargo release gate-keeping."
    - name: "detention_cleared_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN detention_cleared_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders with detention charges cleared. Measures detention revenue collection effectiveness and equipment release management."
    - name: "cancelled_delivery_order_count"
      expr: COUNT(CASE WHEN delivery_order_status = 'Cancelled' THEN 1 END)
      comment: "Number of cancelled delivery orders. Measures booking cancellation and cargo abandonment rates — high values signal commercial or compliance issues."
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_order_status = 'Cancelled' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of delivery orders cancelled. Measures cargo abandonment and booking reliability — informs commercial risk management."
    - name: "distinct_consignees"
      expr: COUNT(DISTINCT participant_account_id)
      comment: "Number of distinct consignee accounts with delivery orders. Measures customer base breadth and concentration risk for cargo release operations."
$$;

CREATE OR REPLACE VIEW `shipping_ports_ecm`.`_metrics`.`cargo_verified_gross_mass`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SOLAS VGM compliance KPI layer over verified gross mass records. Tracks submission compliance rates, weighing method distribution, amendment rates, and deadline adherence to support SOLAS regulatory reporting and port safety management."
  source: "`shipping_ports_ecm`.`cargo`.`verified_gross_mass`"
  dimensions:
    - name: "verification_status"
      expr: verification_status
      comment: "Status of the VGM verification (e.g. Verified, Rejected, Pending). Primary dimension for SOLAS compliance pipeline reporting."
    - name: "weighing_method"
      expr: weighing_method
      comment: "Method used to verify gross mass (e.g. Method 1 - Weighing, Method 2 - Calculation). Drives SOLAS compliance method-mix analysis and regulatory reporting."
    - name: "submission_compliance_flag"
      expr: submission_compliance_flag
      comment: "Flag indicating whether the VGM was submitted in compliance with SOLAS deadlines. Primary SOLAS compliance KPI dimension."
    - name: "pol_code"
      expr: pol_code
      comment: "Port of Loading code on the VGM record. Enables port-level SOLAS compliance rate analysis."
    - name: "pod_code"
      expr: pod_code
      comment: "Port of Discharge code on the VGM record. Enables destination-based VGM compliance analysis."
    - name: "weighing_datetime_month"
      expr: DATE_TRUNC('MONTH', weighing_datetime)
      comment: "Month of VGM weighing. Enables monthly compliance trend and submission volume analysis."
    - name: "submission_datetime_month"
      expr: DATE_TRUNC('MONTH', submission_datetime)
      comment: "Month of VGM submission. Enables monthly submission timeliness and compliance trend analysis."
  measures:
    - name: "total_vgm_records"
      expr: COUNT(1)
      comment: "Total number of VGM records submitted. Baseline SOLAS compliance volume KPI."
    - name: "total_gross_mass_kg"
      expr: SUM(CAST(gross_mass_kg AS DOUBLE))
      comment: "Total verified gross mass in kg across all VGM records. Drives vessel stability calculations, crane load planning, and port safety management."
    - name: "avg_gross_mass_kg"
      expr: AVG(CAST(gross_mass_kg AS DOUBLE))
      comment: "Average verified gross mass per container in kg. Benchmarks cargo weight density and supports vessel stowage planning."
    - name: "solas_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN submission_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VGM submissions compliant with SOLAS deadlines. Primary regulatory KPI — non-compliance triggers cargo loading refusal and port authority penalties."
    - name: "non_compliant_vgm_count"
      expr: COUNT(CASE WHEN submission_compliance_flag = FALSE THEN 1 END)
      comment: "Number of VGM submissions that failed SOLAS compliance. Measures regulatory risk exposure — each non-compliant record represents a potential loading refusal or penalty."
    - name: "rejected_vgm_count"
      expr: COUNT(CASE WHEN verification_status = 'Rejected' THEN 1 END)
      comment: "Number of VGM records rejected by the port authority or shipping line. Measures data quality and submission accuracy — high rejection rates trigger shipper education and process improvement."
    - name: "rejection_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'Rejected' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VGM submissions rejected. Key data quality and compliance KPI — high rates indicate systemic shipper or system issues requiring intervention."
    - name: "amended_vgm_count"
      expr: COUNT(CASE WHEN amendment_version IS NOT NULL AND amendment_version != '0' THEN 1 END)
      comment: "Number of VGM records that have been amended. Measures submission accuracy and rework burden — high amendment rates indicate data quality issues upstream."
    - name: "distinct_shippers_submitting"
      expr: COUNT(DISTINCT shipping_line_id)
      comment: "Number of distinct shipping lines submitting VGM records. Measures SOLAS compliance coverage across the shipping-line community calling at the port."
$$;