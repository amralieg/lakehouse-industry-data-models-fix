-- Metric views for domain: material | Business: Construction | Version: 2 | Generated on: 2026-06-22 17:18:52

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_batch_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks material batch and lot quality, cost, and compliance KPIs. Enables procurement and QA teams to monitor inspection pass rates, quarantine exposure, and total batch value across projects and suppliers."
  source: "`vibe_construction_v1`.`material`.`batch_lot`"
  dimensions:
    - name: "material_type"
      expr: material_type
      comment: "Category of material in the batch, used to segment quality and cost metrics by material class."
    - name: "batch_status"
      expr: batch_status
      comment: "Current lifecycle status of the batch (e.g. active, expired, consumed), enabling status-based filtering."
    - name: "quarantine_status"
      expr: quarantine_status
      comment: "Indicates whether the batch is under quarantine, critical for compliance and risk dashboards."
    - name: "supplier"
      expr: supplier
      comment: "Supplier name for the batch, enabling supplier-level quality and cost benchmarking."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Manufacturer of the material, used for traceability and quality root-cause analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for batch quantities, required for consistent aggregation across materials."
    - name: "received_date_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month of batch receipt, enabling trend analysis of inbound material volumes and costs."
    - name: "expiry_date_month"
      expr: DATE_TRUNC('MONTH', expiry_date)
      comment: "Month of batch expiry, used to identify near-expiry stock requiring urgent action."
    - name: "storage_location"
      expr: storage_location
      comment: "Physical storage location of the batch, supporting warehouse utilisation and compliance audits."
    - name: "lot_traceability_flag"
      expr: lot_traceability_flag
      comment: "Indicates whether full lot traceability is enabled, a key compliance dimension."
  measures:
    - name: "total_batch_cost"
      expr: SUM(CAST(cost AS DOUBLE))
      comment: "Total procurement cost across all batches. Directly informs material spend management and budget variance analysis."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material received across batches. Drives inventory planning and demand fulfilment tracking."
    - name: "avg_unit_weight_kg"
      expr: AVG(CAST(unit_weight AS DOUBLE))
      comment: "Average unit weight per batch record. Used for logistics cost estimation and transport planning."
    - name: "avg_unit_volume"
      expr: AVG(CAST(unit_volume AS DOUBLE))
      comment: "Average unit volume per batch record. Supports warehouse space planning and storage optimisation."
    - name: "inspection_pass_count"
      expr: COUNT(CASE WHEN inspection_passed = TRUE THEN 1 END)
      comment: "Number of batches that passed inspection. Measures quality assurance effectiveness at the batch level."
    - name: "inspection_fail_count"
      expr: COUNT(CASE WHEN inspection_passed = FALSE THEN 1 END)
      comment: "Number of batches that failed inspection. A rising count signals supplier or process quality issues requiring intervention."
    - name: "test_pass_count"
      expr: COUNT(CASE WHEN test_passed = TRUE THEN 1 END)
      comment: "Number of batches that passed material testing. Validates conformance to specification standards."
    - name: "quarantine_batch_count"
      expr: COUNT(CASE WHEN quarantine_status IS NOT NULL AND quarantine_status <> '' THEN 1 END)
      comment: "Number of batches currently under quarantine. High quarantine counts indicate supply chain quality risk and potential project delays."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier)
      comment: "Number of distinct suppliers contributing batches. Informs supplier diversification and single-source dependency risk."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost AS DOUBLE) / NULLIF(CAST(quantity AS DOUBLE), 0))
      comment: "Average cost per unit of material across batches. Enables price benchmarking and cost trend monitoring by supplier or material type."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_boq_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill of Quantities line-level metrics for material scope, value, and change order analysis. Supports project controls teams in tracking contracted vs. actual quantities and identifying scope creep."
  source: "`vibe_construction_v1`.`material`.`boq_line`"
  dimensions:
    - name: "trade_discipline"
      expr: trade_discipline
      comment: "Trade or discipline associated with the BOQ line (e.g. civil, mechanical, electrical), enabling discipline-level cost analysis."
    - name: "material_boq_line_status"
      expr: material_boq_line_status
      comment: "Current status of the BOQ line (e.g. approved, pending, closed), used to filter active vs. completed scope."
    - name: "is_change_order"
      expr: is_change_order
      comment: "Flags whether the BOQ line originated from a change order, enabling change order cost impact analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for BOQ quantities, required for consistent aggregation."
    - name: "record_created_month"
      expr: DATE_TRUNC('MONTH', record_created_timestamp)
      comment: "Month the BOQ line was created, enabling trend analysis of scope additions over time."
    - name: "revision_number"
      expr: revision_number
      comment: "Revision number of the BOQ line, used to track scope evolution and change history."
  measures:
    - name: "total_boq_value"
      expr: SUM(CAST(total_value AS DOUBLE))
      comment: "Total contracted value across all BOQ lines. The primary measure of material scope value on a project, used in budget and cost-to-complete analysis."
    - name: "total_contract_quantity"
      expr: SUM(CAST(contract_quantity AS DOUBLE))
      comment: "Total contracted quantity across BOQ lines. Drives procurement planning and material take-off validation."
    - name: "total_boq_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total estimated quantity across BOQ lines. Used to compare against contract quantity for scope variance detection."
    - name: "avg_unit_rate"
      expr: AVG(CAST(unit_rate AS DOUBLE))
      comment: "Average unit rate across BOQ lines. Benchmarks pricing competitiveness and identifies outlier rates requiring review."
    - name: "change_order_line_count"
      expr: COUNT(CASE WHEN is_change_order = TRUE THEN 1 END)
      comment: "Number of BOQ lines originating from change orders. A high count signals scope instability and potential cost overrun risk."
    - name: "change_order_value"
      expr: SUM(CASE WHEN is_change_order = TRUE THEN CAST(total_value AS DOUBLE) ELSE 0 END)
      comment: "Total value of change order BOQ lines. Directly measures the financial impact of scope changes on the project."
    - name: "quantity_variance"
      expr: SUM(CAST(quantity AS DOUBLE) - CAST(contract_quantity AS DOUBLE))
      comment: "Aggregate difference between estimated and contracted quantities. Positive values indicate scope growth; negative values indicate scope reduction."
    - name: "distinct_trade_discipline_count"
      expr: COUNT(DISTINCT trade_discipline)
      comment: "Number of distinct trade disciplines covered by BOQ lines. Reflects project complexity and multi-trade coordination requirements."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material goods issue metrics tracking the value, volume, compliance, and return rates of materials issued to site. Supports project controls, procurement, and safety teams in monitoring material consumption and compliance."
  source: "`vibe_construction_v1`.`material`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue transaction (e.g. approved, pending, cancelled), used to filter active vs. completed issues."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the goods issue, enabling governance and compliance monitoring."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Reason for the goods issue (e.g. project consumption, maintenance), enabling demand categorisation."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of the issued material, critical for safety compliance reporting."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for issued quantities, required for consistent aggregation."
    - name: "is_returned"
      expr: is_returned
      comment: "Indicates whether the issued material was subsequently returned, enabling return rate analysis."
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flags whether the goods issue is compliant with regulatory or project requirements."
    - name: "issue_month"
      expr: DATE_TRUNC('MONTH', issue_timestamp)
      comment: "Month of goods issue, enabling trend analysis of material consumption over time."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the issued goods, used to track quality gate compliance at point of issue."
  measures:
    - name: "total_gross_amount_issued"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of materials issued. The primary financial measure of material consumption, used in cost-to-complete and budget burn analysis."
    - name: "total_net_amount_issued"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of materials issued after tax. Used for accurate cost accounting and GL reconciliation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on goods issues. Required for tax compliance reporting and financial close processes."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of material issued to site. Drives material consumption tracking and replenishment planning."
    - name: "returned_issue_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of goods issues that were returned. High return counts indicate over-issuance, planning inefficiency, or quality rejection."
    - name: "non_compliant_issue_count"
      expr: COUNT(CASE WHEN compliance_flag = FALSE THEN 1 END)
      comment: "Number of goods issues flagged as non-compliant. A critical safety and regulatory KPI; rising counts require immediate investigation."
    - name: "inspection_required_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE THEN 1 END)
      comment: "Number of goods issues requiring inspection. Used to manage inspection workload and ensure quality gates are not bypassed."
    - name: "avg_net_amount_per_issue"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per goods issue transaction. Benchmarks typical issue size and identifies unusually large or small transactions."
    - name: "distinct_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of distinct materials issued. Reflects material diversity in consumption and supports category management decisions."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_header`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Take-Off (MTO) header-level metrics tracking total material demand, cost, weight, and criticality across projects. Supports project managers and procurement teams in planning and prioritising material procurement."
  source: "`vibe_construction_v1`.`material`.`mto_header`"
  dimensions:
    - name: "mto_header_status"
      expr: mto_header_status
      comment: "Current status of the MTO (e.g. draft, approved, closed), used to filter active procurement demand."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the MTO, enabling regulatory and contractual compliance monitoring."
    - name: "priority"
      expr: priority
      comment: "Priority level of the MTO (e.g. critical, high, normal), used to triage procurement actions."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags whether the MTO is on the critical path, enabling focused management of high-impact material requirements."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MTO cost, required for multi-currency cost consolidation."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Reason for material transfer associated with the MTO, enabling demand categorisation."
    - name: "approval_month"
      expr: DATE_TRUNC('MONTH', approval_timestamp)
      comment: "Month the MTO was approved, enabling trend analysis of procurement demand approval cadence."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month the MTO was created, used to track demand generation trends over time."
  measures:
    - name: "total_mto_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total estimated cost across all MTO headers. The primary measure of material procurement demand value, used in budget planning and cash flow forecasting."
    - name: "total_mto_quantity"
      expr: SUM(CAST(total_quantity AS DOUBLE))
      comment: "Total quantity of materials demanded across MTO headers. Drives procurement volume planning and supplier capacity assessment."
    - name: "total_mto_weight_kg"
      expr: SUM(CAST(total_weight_kg AS DOUBLE))
      comment: "Total weight of materials demanded across MTO headers. Used for logistics planning, transport cost estimation, and site load management."
    - name: "critical_mto_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of MTOs flagged as critical. Directly informs procurement prioritisation and risk management for schedule-critical materials."
    - name: "critical_mto_cost"
      expr: SUM(CASE WHEN is_critical = TRUE THEN CAST(total_cost AS DOUBLE) ELSE 0 END)
      comment: "Total cost of critical MTOs. Quantifies the financial exposure associated with schedule-critical material procurement."
    - name: "avg_mto_cost"
      expr: AVG(CAST(total_cost AS DOUBLE))
      comment: "Average cost per MTO header. Benchmarks typical procurement demand size and identifies outlier requisitions."
    - name: "non_compliant_mto_count"
      expr: COUNT(CASE WHEN compliance_status IS NOT NULL AND compliance_status <> 'compliant' THEN 1 END)
      comment: "Number of MTOs with a non-compliant status. Compliance failures can block procurement and delay project delivery."
    - name: "distinct_project_count"
      expr: COUNT(DISTINCT construction_project_id)
      comment: "Number of distinct projects with active MTO demand. Reflects the breadth of procurement activity across the portfolio."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material Take-Off line-level metrics tracking quantity, cost, variance, and procurement status for individual material requirements. Enables project controls and procurement teams to manage material demand accuracy and delivery performance."
  source: "`vibe_construction_v1`.`material`.`mto_line`"
  dimensions:
    - name: "mto_status"
      expr: mto_status
      comment: "Current status of the MTO line (e.g. open, procured, received), used to track fulfilment progress."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement status of the MTO line, enabling pipeline visibility from demand to delivery."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline associated with the MTO line, enabling discipline-level demand and cost analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flags whether the MTO line is on the critical path, used to prioritise procurement actions."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates whether the material is hazardous, required for safety compliance and handling planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the MTO line cost estimate, required for multi-currency consolidation."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for MTO line quantities, required for consistent aggregation."
    - name: "required_by_month"
      expr: DATE_TRUNC('MONTH', required_by_date)
      comment: "Month by which the material is required on site, enabling demand timeline and procurement lead time analysis."
    - name: "actual_received_month"
      expr: DATE_TRUNC('MONTH', actual_received_date)
      comment: "Month the material was actually received, used to measure delivery performance against required dates."
  measures:
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated procurement cost across MTO lines. The primary financial measure of material demand, used in budget planning and cost-to-complete forecasting."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net quantity required across MTO lines after wastage and design adjustments. Drives procurement order quantities."
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total design quantity across MTO lines. Baseline for comparing against net required quantity to assess wastage and adjustment factors."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity actually received against MTO lines. Measures procurement fulfilment and identifies shortfalls requiring expediting."
    - name: "total_quantity_variance"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance across MTO lines (actual vs. required). Persistent positive variance indicates over-procurement; negative variance signals delivery shortfalls."
    - name: "total_cost_variance"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance across MTO lines. Directly measures procurement cost overrun or saving against estimates."
    - name: "avg_wastage_factor"
      expr: AVG(CAST(wastage_factor AS DOUBLE))
      comment: "Average wastage factor applied across MTO lines. High wastage factors inflate material costs; monitoring drives waste reduction initiatives."
    - name: "critical_line_count"
      expr: COUNT(CASE WHEN is_critical = TRUE THEN 1 END)
      comment: "Number of critical MTO lines. Informs procurement prioritisation and schedule risk management."
    - name: "hazardous_line_count"
      expr: COUNT(CASE WHEN is_hazardous = TRUE THEN 1 END)
      comment: "Number of hazardous material MTO lines. Required for safety planning, regulatory compliance, and specialist handling resource allocation."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across MTO lines. Enables price benchmarking and identification of high-cost materials for value engineering."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Real-time inventory health metrics tracking stock availability, reorder risk, blocked stock, and carrying cost across warehouses. Enables supply chain and procurement teams to prevent stockouts and optimise inventory investment."
  source: "`vibe_construction_v1`.`material`.`stock_level`"
  dimensions:
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current status of the stock level record (e.g. active, depleted, blocked), used to filter healthy vs. at-risk inventory."
    - name: "location_code"
      expr: location_code
      comment: "Physical storage location code, enabling location-level inventory analysis and space utilisation."
    - name: "material_code"
      expr: material_code
      comment: "Material code for the stock record, enabling material-level inventory tracking and reorder analysis."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for stock quantities, required for consistent aggregation."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of the last stock movement (e.g. receipt, issue, transfer), used to understand inventory activity patterns."
    - name: "supplier_code"
      expr: supplier_code
      comment: "Supplier code associated with the stock, enabling supplier-level inventory and lead time analysis."
    - name: "last_movement_month"
      expr: DATE_TRUNC('MONTH', last_movement_date)
      comment: "Month of the last stock movement, used to identify slow-moving or dormant inventory."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total quantity of material physically on hand across all stock records. The primary inventory availability measure, used in supply planning and project readiness assessments."
    - name: "total_inventory_value"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) * CAST(cost_per_unit AS DOUBLE))
      comment: "Total carrying value of on-hand inventory (quantity × cost per unit). Measures working capital tied up in materials and informs inventory optimisation decisions."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity of material blocked from use (e.g. under quality hold). High blocked quantities reduce effective availability and can delay project delivery."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for planned consumption. Used to calculate free stock available for new demand."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity of material currently in transit. Informs near-term availability forecasting and receiving planning."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to open orders or projects. Used to assess net free stock and prevent over-commitment."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(reorder_point AS DOUBLE) THEN 1 END)
      comment: "Number of stock records where on-hand quantity is below the reorder point. A critical procurement trigger metric; rising counts indicate imminent stockout risk."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN CAST(quantity_on_hand AS DOUBLE) < CAST(safety_stock AS DOUBLE) THEN 1 END)
      comment: "Number of stock records where on-hand quantity is below safety stock. Signals high-risk inventory positions requiring urgent replenishment."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across stock records. Used for inventory valuation benchmarking and cost trend monitoring."
    - name: "quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity currently under quality inspection. Measures the volume of stock temporarily unavailable pending quality clearance."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material stock movement metrics tracking the value, volume, compliance, and delivery performance of all inventory transactions. Supports supply chain, finance, and project teams in monitoring material flow efficiency and cost accuracy."
  source: "`vibe_construction_v1`.`material`.`stock_movement`"
  dimensions:
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt movement (e.g. purchase order receipt, return, transfer), enabling movement categorisation."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Current status of the stock movement receipt, used to filter completed vs. pending movements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the stock movement, enabling regulatory and contractual compliance monitoring."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Inspection status of the received goods, used to track quality gate compliance at point of receipt."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flags whether the movement involves a critical material, enabling focused monitoring of schedule-critical supply."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Indicates whether the movement involves hazardous material, required for safety compliance reporting."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the movement value, required for multi-currency financial consolidation."
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', receipt_timestamp)
      comment: "Month of stock movement receipt, enabling trend analysis of material inflow over time."
    - name: "actual_delivery_month"
      expr: DATE_TRUNC('MONTH', actual_delivery_date)
      comment: "Month of actual delivery, used to measure delivery performance and identify seasonal patterns."
    - name: "accounting_entry_posted"
      expr: accounting_entry_posted
      comment: "Indicates whether the accounting entry has been posted for the movement, used to identify unposted transactions requiring financial close action."
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of all stock movements. The primary financial measure of material inflow, used in cost accounting and budget reconciliation."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of stock movements after tax. Used for accurate cost accounting and GL posting validation."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across stock movements. Required for tax compliance reporting and financial close processes."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight cost across stock movements. Measures logistics spend and informs freight cost optimisation and carrier performance management."
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of material received across all stock movements. Drives inventory replenishment tracking and demand fulfilment measurement."
    - name: "delivery_delay_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Number of stock movements where actual delivery was later than expected. A key supplier performance KPI; high counts indicate supply chain reliability issues."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Number of stock movements delivered on or before the expected date. Used to calculate on-time delivery rate and benchmark supplier performance."
    - name: "unposted_accounting_count"
      expr: COUNT(CASE WHEN accounting_entry_posted = FALSE THEN 1 END)
      comment: "Number of stock movements where the accounting entry has not been posted. Unposted entries create financial close risk and must be resolved before period end."
    - name: "critical_material_movement_count"
      expr: COUNT(CASE WHEN is_critical_material = TRUE THEN 1 END)
      comment: "Number of movements involving critical materials. Used to monitor supply chain activity for schedule-critical items."
    - name: "avg_net_amount_per_movement"
      expr: AVG(CAST(net_amount AS DOUBLE))
      comment: "Average net value per stock movement transaction. Benchmarks typical transaction size and identifies unusually large movements requiring review."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_warehouse`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warehouse capacity, compliance, and operational readiness metrics. Enables facilities and supply chain teams to monitor storage utilisation, certification status, and hazardous material handling capability across the warehouse network."
  source: "`vibe_construction_v1`.`material`.`warehouse`"
  dimensions:
    - name: "warehouse_type"
      expr: warehouse_type
      comment: "Type of warehouse (e.g. bulk, cold store, hazmat), enabling segmentation of capacity and compliance metrics by facility type."
    - name: "warehouse_status"
      expr: warehouse_status
      comment: "Operational status of the warehouse (e.g. active, closed, under maintenance), used to filter operational vs. non-operational facilities."
    - name: "country_code"
      expr: country_code
      comment: "Country where the warehouse is located, enabling geographic analysis of storage capacity and compliance."
    - name: "city"
      expr: city
      comment: "City where the warehouse is located, supporting regional capacity planning."
    - name: "climate_control_type"
      expr: climate_control_type
      comment: "Type of climate control in the warehouse (e.g. ambient, refrigerated), used to match storage capability to material requirements."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the warehouse is temperature controlled, a key capability dimension for sensitive material storage."
    - name: "is_hazardous_material_certified"
      expr: is_hazardous_material_certified
      comment: "Indicates whether the warehouse holds hazardous material certification, required for compliance and safety planning."
    - name: "security_level"
      expr: security_level
      comment: "Security level of the warehouse, used to assess suitability for high-value or sensitive material storage."
    - name: "certification_expiry_month"
      expr: DATE_TRUNC('MONTH', certification_expiry_date)
      comment: "Month of warehouse certification expiry, used to proactively manage recertification and avoid compliance lapses."
  measures:
    - name: "total_capacity_area_sqm"
      expr: SUM(CAST(capacity_area_sqm AS DOUBLE))
      comment: "Total storage area capacity in square metres across the warehouse network. The primary measure of physical storage capacity for network planning."
    - name: "total_capacity_weight_tonnes"
      expr: SUM(CAST(capacity_weight_tonnes AS DOUBLE))
      comment: "Total weight capacity in tonnes across the warehouse network. Used to assess whether the network can accommodate planned material volumes."
    - name: "avg_capacity_area_sqm"
      expr: AVG(CAST(capacity_area_sqm AS DOUBLE))
      comment: "Average storage area per warehouse. Benchmarks facility size and identifies under-utilised or over-stretched locations."
    - name: "hazmat_certified_warehouse_count"
      expr: COUNT(CASE WHEN is_hazardous_material_certified = TRUE THEN 1 END)
      comment: "Number of warehouses certified for hazardous material storage. Directly informs whether the network has sufficient hazmat capacity for project requirements."
    - name: "temperature_controlled_warehouse_count"
      expr: COUNT(CASE WHEN temperature_controlled = TRUE THEN 1 END)
      comment: "Number of temperature-controlled warehouses. Used to assess cold-chain storage capacity for temperature-sensitive materials."
    - name: "active_warehouse_count"
      expr: COUNT(CASE WHEN warehouse_status = 'active' THEN 1 END)
      comment: "Number of operationally active warehouses. Measures the effective size of the storage network available for project support."
    - name: "expiring_certification_count"
      expr: COUNT(CASE WHEN certification_expiry_date <= DATE_ADD(CURRENT_DATE(), 90) AND certification_expiry_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of warehouses with certifications expiring within 90 days. A proactive compliance KPI; unrenewed certifications can result in regulatory penalties and operational shutdowns."
$$;