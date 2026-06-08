-- Metric views for domain: material | Business: Construction | Version: 1 | Generated on: 2026-05-07 09:21:54

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks material consumption and issuance activity at the project and cost-center level. Enables monitoring of issued quantities, gross/net material costs, tax exposure, and return rates — critical for project cost control and material accountability."
  source: "`construction_ecm`.`material`.`goods_issue`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the goods issue is charged — primary grouping for project-level material cost analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the goods issue — supports financial accountability and budget tracking."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code classification for the issued material — enables breakdown by work type or trade discipline."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item issued — allows analysis of consumption patterns by material type."
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue (e.g. pending, approved, cancelled) — used to filter active vs. closed transactions."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies issues awaiting authorisation, supporting governance and audit."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Business reason for the goods issue — supports root-cause analysis of material consumption drivers."
    - name: "is_returned"
      expr: is_returned
      comment: "Indicates whether the issued material was subsequently returned — used to calculate net consumption."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the issued material — supports HSE compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency in which the goods issue is valued — required for multi-currency project cost consolidation."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Calendar month of the goods issue — enables trend analysis of material consumption over time."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element to which the issue is allocated — supports earned-value and scope-level cost tracking."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse from which material was issued — identifies high-throughput storage locations."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(1)
      comment: "Total number of goods issue transactions — baseline volume metric for material issuance activity."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of material issued across all transactions — primary consumption volume KPI."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all goods issued — measures overall material cost exposure before tax adjustments."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods issued after deductions — the primary financial measure for material cost tracking."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax charged on goods issues — supports tax liability reporting and financial reconciliation."
    - name: "avg_unit_cost"
      expr: AVG(CAST(net_amount AS DOUBLE) / NULLIF(quantity_issued, 0))
      comment: "Average cost per unit issued — tracks unit price trends and identifies cost escalation by material."
    - name: "return_issue_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of goods issues that were returned — measures material return volume, indicating over-issuance or quality rejection."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods issues that were returned — a key efficiency KPI; high return rates signal over-ordering or site planning issues."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of goods issues awaiting approval — highlights bottlenecks in the material authorisation workflow."
    - name: "compliance_flagged_count"
      expr: COUNT(CASE WHEN compliance_flag = TRUE THEN 1 END)
      comment: "Number of goods issues flagged for compliance review — critical for regulatory risk management on construction sites."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Monitors material requisition lifecycle from request to fulfilment. Supports procurement planning, emergency demand detection, approval cycle performance, and cost estimation accuracy — essential for supply chain and project delivery management."
  source: "`construction_ecm`.`material`.`requisition`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project associated with the requisition — primary dimension for project-level demand analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center raising the requisition — supports budget accountability and spend authorisation."
    - name: "cost_code_id"
      expr: cost_code_id
      comment: "Cost code for the requisitioned material — enables breakdown by work package or trade."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item being requisitioned — identifies high-demand materials and potential supply risks."
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current lifecycle status of the requisition (e.g. draft, approved, fulfilled, cancelled)."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status — identifies requisitions pending authorisation."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfilment status of the requisition — tracks whether material demand has been satisfied."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition — supports triage of urgent material needs."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flags emergency requisitions — high emergency rates indicate poor planning or unexpected site conditions."
    - name: "is_stock_available"
      expr: is_stock_available
      comment: "Indicates whether stock was available at time of requisition — supports inventory adequacy analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost estimate — required for multi-currency project financial reporting."
    - name: "request_month"
      expr: DATE_TRUNC('MONTH', request_timestamp)
      comment: "Month the requisition was raised — enables demand trend analysis over time."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element linked to the requisition — supports scope-level material demand tracking."
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse designated to fulfil the requisition — identifies supply source and stock location."
  measures:
    - name: "total_requisitions"
      expr: COUNT(1)
      comment: "Total number of material requisitions raised — baseline demand volume metric."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material requested across all requisitions — measures aggregate material demand."
    - name: "total_cost_estimate_net"
      expr: SUM(CAST(cost_estimate_net AS DOUBLE))
      comment: "Total net estimated cost of all requisitions — key input for procurement budget planning."
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross estimated cost including taxes — measures full financial exposure from material demand."
    - name: "total_cost_estimate_tax"
      expr: SUM(CAST(cost_estimate_tax AS DOUBLE))
      comment: "Total estimated tax on requisitions — supports tax liability forecasting."
    - name: "emergency_requisition_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency requisitions — a leading indicator of site planning failures and supply chain stress."
    - name: "emergency_requisition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions flagged as emergency — high rates signal procurement planning deficiencies requiring executive intervention."
    - name: "stock_available_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_stock_available = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions where stock was available on-hand — measures inventory service level and warehouse readiness."
    - name: "fulfilled_requisition_count"
      expr: COUNT(CASE WHEN fulfillment_status = 'FULFILLED' THEN 1 END)
      comment: "Number of requisitions fully fulfilled — measures supply chain delivery performance."
    - name: "avg_cost_estimate_per_requisition"
      expr: AVG(CAST(cost_estimate_net AS DOUBLE))
      comment: "Average net cost per requisition — benchmarks typical material order size and detects cost outliers."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks Material Take-Off (MTO) lines representing engineered material requirements derived from design. Measures procurement readiness, quantity variances, cost variances, and critical material status — directly linked to project schedule and cost performance."
  source: "`construction_ecm`.`material`.`mto_line`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project to which the MTO line belongs — primary dimension for project-level material planning analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item defined in the MTO — identifies specific engineered material requirements."
    - name: "mto_status"
      expr: mto_status
      comment: "Current status of the MTO line (e.g. draft, approved, procured) — tracks procurement readiness."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement lifecycle status — identifies materials at risk of late delivery."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags critical path materials — critical material delays directly impact project schedule."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates hazardous material — required for HSE compliance and special handling planning."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (e.g. civil, mechanical, electrical) — supports discipline-level material planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the estimated cost — required for multi-currency project financial consolidation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element linked to the MTO line — supports scope-level material cost and quantity tracking."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the MTO line — supports financial accountability."
    - name: "required_by_month"
      expr: DATE_TRUNC('MONTH', required_by_date)
      comment: "Month by which the material is required on site — enables procurement scheduling and delivery planning."
  measures:
    - name: "total_mto_lines"
      expr: COUNT(1)
      comment: "Total number of MTO lines — baseline measure of material planning scope."
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total engineered quantity of material required per design — the baseline for procurement planning."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net quantity required after applying wastage factors — the actual procurement target quantity."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity of material actually received on site — measures procurement delivery performance against plan."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MTO lines — key input for project budget validation and cost-at-completion forecasting."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance across MTO lines (actual vs. estimated) — a primary project cost control KPI; large variances trigger budget reviews."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (actual received vs. required) — identifies over/under-delivery and scope change impacts."
    - name: "critical_material_line_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical path MTO lines — executives monitor this to assess schedule risk from material delays."
    - name: "avg_wastage_factor"
      expr: AVG(CAST(wastage_factor AS DOUBLE))
      comment: "Average wastage factor applied across MTO lines — benchmarks material efficiency assumptions; high values inflate procurement costs."
    - name: "receipt_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(actual_received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(net_required_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of required material quantity actually received — measures procurement fulfilment rate; below 100% signals delivery risk to project schedule."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provides a real-time view of warehouse inventory health including on-hand stock, committed and blocked quantities, safety stock adequacy, and reorder triggers. Supports inventory optimisation, working capital management, and supply continuity decisions."
  source: "`construction_ecm`.`material`.`stock_level`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse holding the stock — primary dimension for location-level inventory analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item in stock — enables item-level inventory position analysis."
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current status of the stock record (e.g. active, blocked, expired) — filters usable vs. unusable inventory."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the most recent stock movement — identifies whether stock is actively consumed or stagnant."
    - name: "location_code"
      expr: location_code
      comment: "Physical storage location within the warehouse — supports bin-level inventory management."
    - name: "batch_number"
      expr: batch_number
      comment: "Batch identifier for the stock — supports traceability and quality recall management."
    - name: "lot_number"
      expr: lot_number
      comment: "Lot number for the stock — supports lot-level traceability and expiry management."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for stock quantities — required for correct quantity aggregation and comparison."
    - name: "expiration_month"
      expr: DATE_TRUNC('MONTH', expiration_date)
      comment: "Month in which stock expires — enables proactive management of near-expiry inventory to reduce write-offs."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand across all locations — the primary inventory position metric."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to open orders or requisitions — measures demand already allocated against stock."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked (e.g. under quality hold) — measures unusable inventory impacting supply availability."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit to the warehouse — measures inbound supply pipeline."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for specific projects or work orders — measures forward demand allocation."
    - name: "total_inventory_value"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total financial value of on-hand inventory (quantity × unit cost) — key working capital metric for finance and procurement leadership."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock records where on-hand quantity is below the reorder point — a critical supply continuity alert metric."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of stock records below safety stock level — identifies materials at immediate risk of stockout, directly threatening project continuity."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across all stock records — benchmarks inventory valuation and detects price drift."
    - name: "quality_inspection_quantity_total"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection — measures the volume of stock unavailable pending quality clearance."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks all inbound material movements including goods receipts, transfers, and deliveries. Enables measurement of delivery performance, freight cost management, compliance status, and receipt accuracy — critical for supply chain and project logistics management."
  source: "`construction_ecm`.`material`.`stock_movement`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project receiving the material — primary dimension for project-level supply chain analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item received — enables item-level delivery performance tracking."
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt transaction — distinguishes purchase receipts, returns, and transfers."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g. posted, pending, rejected) — tracks receipt processing completeness."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of received material — identifies receipts pending or failing quality clearance."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Regulatory compliance status of the received material — critical for construction site compliance management."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flags critical path materials — late receipt of critical materials directly impacts project schedule."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates hazardous material receipt — required for HSE compliance and special handling tracking."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the receipt valuation — required for multi-currency financial consolidation."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center receiving the material — supports financial accountability for inbound logistics costs."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of goods receipt — enables trend analysis of material inflow over time."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element associated with the receipt — supports scope-level material delivery tracking."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions — baseline measure of inbound material activity."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received — primary inbound supply volume KPI."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods received — measures total material procurement spend posted to the ledger."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods received including taxes — measures full financial exposure from inbound material."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and logistics cost for material deliveries — a controllable cost component for procurement optimisation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goods received — supports tax liability reporting and financial reconciliation."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Number of deliveries received on or before the expected date — measures supplier and logistics on-time performance."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of deliveries received on time — a strategic KPI for supply chain reliability; low rates signal procurement or logistics failures."
    - name: "compliance_failed_count"
      expr: COUNT(CASE WHEN compliance_status = 'FAILED' THEN 1 END)
      comment: "Number of receipts with failed compliance status — measures regulatory risk exposure from non-compliant material deliveries."
    - name: "critical_material_receipt_count"
      expr: COUNT(CASE WHEN is_critical_material = TRUE THEN 1 END)
      comment: "Number of critical material receipts — executives track this to confirm schedule-critical materials are arriving as planned."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_wastage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Measures material wastage across construction projects including waste quantities, costs, hazardous waste volumes, and recyclability rates. Supports sustainability reporting, cost reduction initiatives, and regulatory compliance — a key ESG and project efficiency domain."
  source: "`construction_ecm`.`material`.`wastage`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project generating the wastage — primary dimension for project-level waste performance analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item wasted — identifies high-waste materials for targeted reduction programmes."
    - name: "waste_type"
      expr: waste_type
      comment: "Classification of waste type (e.g. offcut, spoilage, damage) — supports root-cause analysis of waste generation."
    - name: "wastage_status"
      expr: wastage_status
      comment: "Current status of the wastage record — tracks whether waste has been recorded, approved, and disposed."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method used to dispose of waste (e.g. landfill, recycling, incineration) — critical for environmental compliance reporting."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flags hazardous waste — hazardous waste volumes require special regulatory reporting and disposal management."
    - name: "is_recyclable"
      expr: is_recyclable
      comment: "Indicates whether the waste material is recyclable — supports sustainability and circular economy KPIs."
    - name: "cause"
      expr: cause
      comment: "Root cause of the wastage event — enables targeted corrective actions to reduce waste."
    - name: "cost_currency_code"
      expr: cost_currency_code
      comment: "Currency of waste cost values — required for multi-currency financial reporting."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element associated with the wastage — supports scope-level waste cost allocation."
    - name: "wastage_month"
      expr: DATE_TRUNC('MONTH', wastage_date)
      comment: "Month in which wastage occurred — enables trend analysis of waste generation over the project lifecycle."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for the wastage record — supports periodic regulatory and sustainability reporting."
  measures:
    - name: "total_wastage_records"
      expr: COUNT(1)
      comment: "Total number of wastage records — baseline measure of waste event frequency."
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material wasted — primary waste volume KPI for sustainability and efficiency reporting."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned (allowable) waste quantity — the benchmark against which actual waste is compared."
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity_consumed AS DOUBLE))
      comment: "Total actual material consumed including waste — supports comparison against planned consumption for variance analysis."
    - name: "total_waste_cost_net"
      expr: SUM(CAST(waste_cost_net AS DOUBLE))
      comment: "Total net financial cost of material wastage — directly measures the monetary impact of waste on project profitability."
    - name: "total_waste_cost_gross"
      expr: SUM(CAST(waste_cost_gross AS DOUBLE))
      comment: "Total gross cost of wastage including taxes — measures full financial exposure from material waste."
    - name: "total_waste_cost_adjustment"
      expr: SUM(CAST(waste_cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to waste records — tracks corrections and reclassifications affecting waste cost reporting."
    - name: "waste_overrun_pct"
      expr: ROUND(100.0 * SUM(CAST(quantity AS DOUBLE)) / NULLIF(SUM(CAST(planned_quantity AS DOUBLE)), 0) - 100.0, 2)
      comment: "Percentage by which actual waste exceeds planned waste allowance — a critical project efficiency KPI; positive values indicate waste overrun requiring management intervention."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of hazardous waste generated — a mandatory regulatory reporting metric and HSE risk indicator."
    - name: "recyclable_waste_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_recyclable = TRUE THEN quantity ELSE 0 END) / NULLIF(SUM(CAST(quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total waste that is recyclable — a key sustainability and ESG performance metric reported to clients and regulators."
    - name: "avg_wastage_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average wastage percentage per record — benchmarks waste rates across materials, projects, and work fronts to identify outliers."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks inter-warehouse and inter-site material transfers. Measures transfer volumes, on-time arrival performance, and transfer activity by project and cost centre — supports logistics optimisation and material reallocation decisions across the construction portfolio."
  source: "`construction_ecm`.`material`.`stock_transfer`"
  dimensions:
    - name: "construction_project_id"
      expr: construction_project_id
      comment: "Project associated with the stock transfer — primary dimension for project-level logistics analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item being transferred — identifies high-movement materials and reallocation patterns."
    - name: "source_warehouse_id"
      expr: source_warehouse_id
      comment: "Warehouse from which material is being transferred — identifies high-outflow storage locations."
    - name: "destination_warehouse_id"
      expr: destination_warehouse_id
      comment: "Warehouse receiving the transferred material — identifies high-demand storage locations."
    - name: "stock_transfer_status"
      expr: stock_transfer_status
      comment: "Current status of the transfer (e.g. in-transit, completed, cancelled) — tracks transfer lifecycle."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer — supports analysis of reallocation drivers (e.g. project demand, surplus redistribution)."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the transfer — supports logistics cost and carbon footprint analysis."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the transfer — supports financial accountability for logistics costs."
    - name: "transfer_month"
      expr: DATE_TRUNC('MONTH', transfer_timestamp)
      comment: "Month the transfer was initiated — enables trend analysis of inter-site material movement over time."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for transfer quantities — required for correct quantity aggregation."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions — baseline measure of inter-warehouse logistics activity."
    - name: "total_quantity_transferred"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material transferred between warehouses — measures the volume of material reallocation across the project portfolio."
    - name: "on_time_arrival_count"
      expr: COUNT(CASE WHEN CAST(actual_arrival_timestamp AS DATE) <= expected_arrival_date THEN 1 END)
      comment: "Number of transfers that arrived on or before the expected arrival date — measures logistics delivery reliability."
    - name: "on_time_arrival_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN CAST(actual_arrival_timestamp AS DATE) <= expected_arrival_date THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of stock transfers arriving on time — a key logistics performance KPI; low rates indicate transport or planning failures affecting site supply."
    - name: "completed_transfer_count"
      expr: COUNT(CASE WHEN stock_transfer_status = 'COMPLETED' THEN 1 END)
      comment: "Number of fully completed transfers — measures logistics throughput and transfer closure rate."
    - name: "avg_quantity_per_transfer"
      expr: AVG(CAST(quantity AS DOUBLE))
      comment: "Average quantity transferred per transaction — benchmarks transfer batch sizes and identifies inefficiently small or oversized transfers."
$$;

CREATE OR REPLACE VIEW `construction_ecm`.`_metrics`.`material_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Analyses Bill of Quantities (BOQ) material lines representing contracted material scope and value. Measures contract quantities, unit rates, total values, and change order exposure — essential for contract management, cost control, and scope change governance."
  source: "`construction_ecm`.`material`.`material_boq_line`"
  dimensions:
    - name: "boq_id"
      expr: boq_id
      comment: "Bill of Quantities document — primary grouping for contract-level material scope analysis."
    - name: "material_master_id"
      expr: material_master_id
      comment: "Material item in the BOQ line — enables item-level contract value analysis."
    - name: "material_boq_line_status"
      expr: material_boq_line_status
      comment: "Status of the BOQ line (e.g. active, revised, cancelled) — tracks contract scope changes."
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade or engineering discipline for the BOQ line — supports discipline-level contract value breakdown."
    - name: "is_change_order"
      expr: is_change_order
      comment: "Flags BOQ lines arising from change orders — measures scope change volume and financial impact."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for BOQ quantities — required for correct quantity aggregation."
    - name: "wbs_element_id"
      expr: wbs_element_id
      comment: "WBS element linked to the BOQ line — supports scope-level contract value tracking."
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the BOQ line — supports financial accountability."
    - name: "record_created_month"
      expr: DATE_TRUNC('MONTH', record_created_timestamp)
      comment: "Month the BOQ line was created — enables analysis of contract scope evolution over time."
  measures:
    - name: "total_boq_lines"
      expr: COUNT(1)
      comment: "Total number of BOQ material lines — measures the breadth of contracted material scope."
    - name: "total_contract_quantity"
      expr: SUM(CAST(contract_quantity AS DOUBLE))
      comment: "Total contracted quantity of material across all BOQ lines — the baseline for contract scope measurement."
    - name: "total_boq_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total current BOQ quantity (may differ from contract quantity due to revisions) — tracks scope evolution."
    - name: "total_boq_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total financial value of all BOQ material lines — the primary contract material cost KPI used in project financial reviews."
    - name: "change_order_line_count"
      expr: COUNT(CASE WHEN is_change_order = TRUE THEN 1 END)
      comment: "Number of BOQ lines arising from change orders — measures scope change frequency; high counts indicate project instability."
    - name: "change_order_value"
      expr: SUM(CASE WHEN is_change_order = TRUE THEN total_value ELSE 0 END)
      comment: "Total financial value of change order BOQ lines — measures the monetary impact of scope changes on the contract."
    - name: "change_order_value_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_change_order = TRUE THEN total_value ELSE 0 END) / NULLIF(SUM(CAST(total_value AS DOUBLE)), 0), 2)
      comment: "Percentage of total BOQ value attributable to change orders — a strategic contract governance KPI; high percentages signal scope creep requiring executive attention."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across BOQ material lines — benchmarks pricing levels and identifies rate outliers for contract audit."
$$;