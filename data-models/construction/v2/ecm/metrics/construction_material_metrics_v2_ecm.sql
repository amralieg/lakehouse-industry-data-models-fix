-- Metric views for domain: material | Business: Construction | Version: 2 | Generated on: 2026-06-22 15:07:26

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_level`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and stock position metrics across materials and warehouses. Drives replenishment decisions, safety stock compliance, and working capital optimization."
  source: "`vibe_construction_v1`.`material`.`stock_level`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Material identifier for grouping stock metrics by material type."
    - name: "location_code"
      expr: location_code
      comment: "Storage location within the warehouse for granular inventory positioning."
    - name: "stock_level_status"
      expr: stock_level_status
      comment: "Current status of the stock level record (e.g., active, blocked, in-transit)."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity comparisons across materials."
    - name: "last_movement_type"
      expr: last_movement_type
      comment: "Type of last stock movement (receipt, issue, transfer) for activity analysis."
  measures:
    - name: "total_quantity_on_hand"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE))
      comment: "Total physical stock on hand. Core inventory position metric used by supply chain and project managers to assess material availability."
    - name: "total_committed_quantity"
      expr: SUM(CAST(committed_quantity AS DOUBLE))
      comment: "Total quantity committed to open orders or work orders. Indicates how much stock is already allocated and unavailable for new demand."
    - name: "total_reserved_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total quantity reserved for planned consumption. Helps procurement teams understand future demand obligations."
    - name: "total_blocked_quantity"
      expr: SUM(CAST(blocked_quantity AS DOUBLE))
      comment: "Total quantity blocked due to quality holds or compliance issues. High blocked stock signals quality or supplier problems requiring intervention."
    - name: "total_in_transit_quantity"
      expr: SUM(CAST(in_transit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit between locations. Supports logistics planning and expected arrival forecasting."
    - name: "total_quality_inspection_quantity"
      expr: SUM(CAST(quality_inspection_quantity AS DOUBLE))
      comment: "Total quantity under quality inspection. Elevated values indicate quality bottlenecks that may delay project material availability."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average unit cost across stock positions. Used for inventory valuation and cost benchmarking against budget."
    - name: "total_available_quantity"
      expr: SUM(CAST(quantity_on_hand AS DOUBLE) - CAST(reserved_quantity AS DOUBLE) - CAST(blocked_quantity AS DOUBLE))
      comment: "Net available quantity (on-hand minus reserved and blocked). The true free stock available for new project demand."
    - name: "below_safety_stock_count"
      expr: COUNT(CASE WHEN quantity_on_hand < safety_stock THEN 1 END)
      comment: "Number of material-location combinations where stock has fallen below safety stock threshold. A leading indicator of potential project material shortages."
    - name: "below_reorder_point_count"
      expr: COUNT(CASE WHEN quantity_on_hand < reorder_point THEN 1 END)
      comment: "Number of stock positions at or below reorder point. Drives procurement replenishment actions to prevent site stoppages."
    - name: "stock_positions_count"
      expr: COUNT(1)
      comment: "Total number of active stock positions. Baseline measure for inventory breadth and warehouse utilization."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material consumption and goods issue metrics for construction projects. Tracks material flow from warehouse to site, cost of consumption, and compliance with issue processes."
  source: "`vibe_construction_v1`.`material`.`goods_issue`"
  dimensions:
    - name: "goods_issue_status"
      expr: goods_issue_status
      comment: "Current status of the goods issue (pending, approved, issued, returned). Enables pipeline analysis of material flow."
    - name: "issue_reason"
      expr: issue_reason
      comment: "Business reason for the goods issue (project consumption, scrap, return). Supports root-cause analysis of material usage patterns."
    - name: "material_description"
      expr: material_description
      comment: "Description of the material issued. Enables analysis by material type."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the goods issue. Identifies unapproved issues that represent control gaps."
    - name: "hazard_classification"
      expr: hazard_classification
      comment: "Hazard classification of issued material. Supports HSE reporting and compliance tracking."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for cost allocation. Enables project cost tracking by work breakdown structure element."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue transaction for multi-currency project reporting."
  measures:
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity of materials issued from warehouse. Primary throughput metric for material consumption management."
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of goods issued. Directly ties material consumption to project cost and budget burn."
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of goods issued (excluding tax). Used for project cost reporting and earned value calculations."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on goods issued. Required for financial reporting and tax compliance."
    - name: "returned_issues_count"
      expr: COUNT(CASE WHEN is_returned = TRUE THEN 1 END)
      comment: "Number of goods issues that were returned. High return rates indicate over-issuing, poor planning, or quality problems."
    - name: "return_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_returned = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of goods issues that were returned. A key efficiency metric — high return rates waste logistics effort and inflate apparent consumption."
    - name: "uninspected_hazardous_issues_count"
      expr: COUNT(CASE WHEN inspection_required = TRUE AND inspection_status != 'PASSED' THEN 1 END)
      comment: "Number of hazardous material issues where inspection was required but not passed. A critical HSE compliance risk indicator."
    - name: "goods_issues_count"
      expr: COUNT(1)
      comment: "Total number of goods issue transactions. Baseline volume metric for material flow activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_movement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material receipt and stock movement metrics. Tracks inbound material flow, delivery performance, freight costs, and compliance status across construction projects."
  source: "`vibe_construction_v1`.`material`.`stock_movement`"
  dimensions:
    - name: "goods_receipt_type"
      expr: goods_receipt_type
      comment: "Type of goods receipt movement (purchase order receipt, return, transfer). Enables analysis by movement category."
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the stock movement receipt. Identifies pending, posted, or rejected movements."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the received material. Non-compliant receipts represent quality and regulatory risk."
    - name: "material_description"
      expr: material_description
      comment: "Description of the material received. Enables analysis by material category."
    - name: "inspection_status"
      expr: inspection_status
      comment: "Quality inspection status of received goods. Drives quality gate performance analysis."
    - name: "currency_code"
      expr: currency_code
      comment: "Transaction currency for multi-currency financial reporting."
    - name: "is_critical_material"
      expr: is_critical_material
      comment: "Flag indicating whether the material is on the critical path. Enables prioritized monitoring of critical material receipts."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag indicating hazardous material. Supports HSE compliance reporting."
  measures:
    - name: "total_quantity_received"
      expr: SUM(CAST(quantity_received AS DOUBLE))
      comment: "Total quantity of materials received. Primary inbound supply metric for procurement and logistics performance."
    - name: "total_gross_receipt_value"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross value of materials received. Tracks committed spend materializing into physical inventory."
    - name: "total_net_receipt_value"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net value of materials received. Used for accounts payable accruals and project cost recognition."
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_cost AS DOUBLE))
      comment: "Total freight and logistics cost for material receipts. Freight overruns directly impact project cost performance."
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax on received materials. Required for tax compliance and financial reporting."
    - name: "on_time_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END)
      comment: "Number of material receipts delivered on or before the expected date. Measures supplier delivery reliability."
    - name: "late_delivery_count"
      expr: COUNT(CASE WHEN actual_delivery_date > expected_delivery_date THEN 1 END)
      comment: "Number of late material deliveries. Late deliveries are a leading indicator of project schedule risk."
    - name: "on_time_delivery_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_delivery_date <= expected_delivery_date THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_delivery_date IS NOT NULL AND expected_delivery_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of deliveries received on time. A key supplier performance KPI used in vendor scorecards and procurement reviews."
    - name: "non_compliant_receipts_count"
      expr: COUNT(CASE WHEN compliance_status != 'COMPLIANT' THEN 1 END)
      comment: "Number of receipts with non-compliant material status. Compliance failures trigger quarantine and rework, impacting project timelines."
    - name: "accounting_posted_count"
      expr: COUNT(CASE WHEN accounting_entry_posted = TRUE THEN 1 END)
      comment: "Number of stock movements with accounting entries posted. Unposted movements represent financial reporting gaps."
    - name: "stock_movements_count"
      expr: COUNT(1)
      comment: "Total number of stock movement transactions. Baseline volume metric for inbound logistics activity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_wastage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material wastage and loss metrics for construction projects. Tracks waste volumes, costs, disposal compliance, and wastage rates to drive lean construction and sustainability performance."
  source: "`vibe_construction_v1`.`material`.`wastage`"
  dimensions:
    - name: "waste_type"
      expr: waste_type
      comment: "Category of waste (concrete, steel, timber, hazardous). Enables targeted waste reduction initiatives by material type."
    - name: "cause"
      expr: cause
      comment: "Root cause of wastage (over-ordering, damage, design change). Drives corrective action and process improvement."
    - name: "disposal_method"
      expr: disposal_method
      comment: "Method of waste disposal (recycling, landfill, incineration). Supports sustainability and environmental compliance reporting."
    - name: "wastage_status"
      expr: wastage_status
      comment: "Current status of the wastage record. Tracks lifecycle from identification to disposal."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag for hazardous waste. Hazardous waste requires special handling and regulatory reporting."
    - name: "is_recyclable"
      expr: is_recyclable
      comment: "Flag indicating recyclable waste. Supports circular economy and sustainability KPI reporting."
    - name: "reporting_period"
      expr: reporting_period
      comment: "Reporting period for waste aggregation. Enables trend analysis and period-over-period comparison."
    - name: "work_front"
      expr: work_front
      comment: "Site work front where wastage occurred. Identifies high-waste areas for targeted intervention."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for cost allocation of waste. Links waste cost to specific project work packages."
  measures:
    - name: "total_waste_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of material wasted. Primary waste volume metric for lean construction and sustainability programs."
    - name: "total_planned_quantity"
      expr: SUM(CAST(planned_quantity AS DOUBLE))
      comment: "Total planned material quantity against which wastage is measured. Required to compute wastage rate."
    - name: "total_actual_quantity_consumed"
      expr: SUM(CAST(actual_quantity_consumed AS DOUBLE))
      comment: "Total actual material consumed including waste. Used to reconcile planned vs actual material usage."
    - name: "total_waste_cost_gross"
      expr: SUM(CAST(waste_cost_gross AS DOUBLE))
      comment: "Total gross cost of material wasted. Directly quantifies the financial impact of waste on project profitability."
    - name: "total_waste_cost_net"
      expr: SUM(CAST(waste_cost_net AS DOUBLE))
      comment: "Total net cost of material wasted (excluding tax adjustments). Used for project cost reporting and budget variance analysis."
    - name: "total_waste_cost_adjustment"
      expr: SUM(CAST(waste_cost_adjustment AS DOUBLE))
      comment: "Total cost adjustments applied to waste records (credits, recoveries). Tracks financial recovery from waste disposal or recycling."
    - name: "avg_wastage_percentage"
      expr: AVG(CAST(percentage AS DOUBLE))
      comment: "Average wastage percentage across all records. A key lean construction KPI — industry benchmarks typically target below 5% for structural materials."
    - name: "hazardous_waste_quantity"
      expr: SUM(CASE WHEN is_hazardous = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of hazardous waste generated. Regulatory reporting requirement and HSE risk indicator."
    - name: "recyclable_waste_quantity"
      expr: SUM(CASE WHEN is_recyclable = TRUE THEN quantity ELSE 0 END)
      comment: "Total quantity of recyclable waste. Measures circular economy performance and supports green certification targets."
    - name: "regulatory_non_compliant_count"
      expr: COUNT(CASE WHEN regulatory_compliance_flag = FALSE THEN 1 END)
      comment: "Number of wastage records with regulatory compliance failures. Non-compliant waste disposal exposes the organization to fines and reputational risk."
    - name: "wastage_records_count"
      expr: COUNT(1)
      comment: "Total number of wastage records. Baseline volume metric for waste event frequency."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_requisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material requisition pipeline and procurement efficiency metrics. Tracks demand origination, approval cycle times, cost estimates, and fulfillment performance for construction projects."
  source: "`vibe_construction_v1`.`material`.`requisition`"
  dimensions:
    - name: "requisition_status"
      expr: requisition_status
      comment: "Current status of the requisition (draft, submitted, approved, fulfilled). Enables pipeline stage analysis."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the requisition. Identifies bottlenecks in the approval workflow."
    - name: "fulfillment_status"
      expr: fulfillment_status
      comment: "Fulfillment status of the requisition. Tracks whether demand has been satisfied by procurement."
    - name: "priority"
      expr: priority
      comment: "Priority level of the requisition (emergency, high, normal). Enables prioritized management of critical material needs."
    - name: "requester_department"
      expr: requester_department
      comment: "Department originating the requisition. Identifies high-demand departments for resource planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the cost estimate for multi-currency project reporting."
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag for emergency requisitions. Emergency requisitions typically carry premium costs and indicate planning failures."
    - name: "wbs_code"
      expr: wbs_code
      comment: "WBS code for cost allocation. Links material demand to specific project work packages."
  measures:
    - name: "total_cost_estimate_gross"
      expr: SUM(CAST(cost_estimate_gross AS DOUBLE))
      comment: "Total gross estimated cost of all requisitions. Represents uncommitted demand value in the procurement pipeline."
    - name: "total_cost_estimate_net"
      expr: SUM(CAST(cost_estimate_net AS DOUBLE))
      comment: "Total net estimated cost of requisitions. Used for budget commitment forecasting and cash flow planning."
    - name: "total_cost_estimate_tax"
      expr: SUM(CAST(cost_estimate_tax AS DOUBLE))
      comment: "Total estimated tax on requisitions. Required for tax accrual and financial planning."
    - name: "total_quantity_requested"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials requested across all requisitions. Measures aggregate material demand volume."
    - name: "emergency_requisitions_count"
      expr: COUNT(CASE WHEN is_emergency = TRUE THEN 1 END)
      comment: "Number of emergency requisitions. High emergency requisition rates indicate poor material planning and result in premium procurement costs."
    - name: "emergency_requisition_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_emergency = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of requisitions flagged as emergency. A planning maturity KPI — world-class projects target below 5% emergency requisitions."
    - name: "pending_approval_count"
      expr: COUNT(CASE WHEN approval_status = 'PENDING' THEN 1 END)
      comment: "Number of requisitions awaiting approval. Large backlogs indicate approval bottlenecks that delay material procurement and risk project schedules."
    - name: "unfulfilled_requisitions_count"
      expr: COUNT(CASE WHEN fulfillment_status != 'FULFILLED' THEN 1 END)
      comment: "Number of requisitions not yet fulfilled. Unfulfilled demand represents potential project schedule risk."
    - name: "stock_available_count"
      expr: COUNT(CASE WHEN is_stock_available = TRUE THEN 1 END)
      comment: "Number of requisitions where stock is available in warehouse. High availability rates indicate good inventory management."
    - name: "requisitions_count"
      expr: COUNT(1)
      comment: "Total number of material requisitions. Baseline demand volume metric."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_mto_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material take-off (MTO) line metrics for construction projects. Tracks design quantities, procurement status, cost estimates, and variance between design and actual material requirements."
  source: "`vibe_construction_v1`.`material`.`mto_line`"
  dimensions:
    - name: "mto_status"
      expr: mto_status
      comment: "Status of the MTO line (draft, issued, procured, received). Tracks material procurement lifecycle."
    - name: "procurement_status"
      expr: procurement_status
      comment: "Procurement status of the MTO line. Identifies materials not yet sourced, enabling proactive procurement action."
    - name: "discipline"
      expr: discipline
      comment: "Engineering discipline (civil, structural, MEP). Enables analysis of material demand by discipline."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis."
    - name: "is_critical"
      expr: is_critical
      comment: "Flag for critical path materials. Critical materials require priority procurement to avoid schedule delays."
    - name: "is_hazardous"
      expr: is_hazardous
      comment: "Flag for hazardous materials. Supports HSE compliance and special handling planning."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency for cost analysis in multi-currency projects."
  measures:
    - name: "total_design_quantity"
      expr: SUM(CAST(design_quantity AS DOUBLE))
      comment: "Total design quantity from engineering take-off. The baseline material demand from design documents."
    - name: "total_net_required_quantity"
      expr: SUM(CAST(net_required_quantity AS DOUBLE))
      comment: "Total net quantity required after accounting for stock on hand. Drives procurement order quantities."
    - name: "total_actual_received_quantity"
      expr: SUM(CAST(actual_received_quantity AS DOUBLE))
      comment: "Total quantity actually received against MTO lines. Measures procurement fulfillment against design requirements."
    - name: "total_estimated_cost"
      expr: SUM(CAST(total_estimated_cost AS DOUBLE))
      comment: "Total estimated cost of all MTO lines. Provides early-stage material budget for project cost planning."
    - name: "total_variance_cost"
      expr: SUM(CAST(variance_cost AS DOUBLE))
      comment: "Total cost variance between estimated and actual material costs. Negative variance indicates cost overrun on materials."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance between design and actual received quantities. Persistent variances indicate design accuracy issues or procurement failures."
    - name: "avg_wastage_factor"
      expr: AVG(CAST(wastage_factor AS DOUBLE))
      comment: "Average wastage factor applied to MTO lines. Benchmarks assumed waste allowances against actual wastage for continuous improvement."
    - name: "critical_unprocured_count"
      expr: COUNT(CASE WHEN is_critical = TRUE AND procurement_status != 'PROCURED' THEN 1 END)
      comment: "Number of critical MTO lines not yet procured. A leading schedule risk indicator — critical materials without procurement orders threaten project milestones."
    - name: "avg_estimated_unit_price"
      expr: AVG(CAST(estimated_unit_price AS DOUBLE))
      comment: "Average estimated unit price across MTO lines. Used for budget benchmarking and cost normalization across projects."
    - name: "mto_lines_count"
      expr: COUNT(1)
      comment: "Total number of MTO lines. Baseline metric for material scope complexity."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_physical_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Physical inventory count accuracy and variance metrics. Tracks discrepancies between system book quantities and physical counts to drive inventory accuracy and financial integrity."
  source: "`vibe_construction_v1`.`material`.`physical_inventory`"
  dimensions:
    - name: "physical_inventory_status"
      expr: physical_inventory_status
      comment: "Status of the physical inventory count (in-progress, completed, posted). Tracks count lifecycle."
    - name: "count_type"
      expr: count_type
      comment: "Type of inventory count (cycle count, full count, spot check). Enables analysis by count methodology."
    - name: "location_code"
      expr: location_code
      comment: "Storage location of the counted inventory. Identifies locations with persistent accuracy issues."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity variance analysis."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Flag indicating a recount was required. High recount rates indicate counting process quality issues."
    - name: "material_description"
      expr: material_description
      comment: "Description of the material counted. Enables analysis by material category."
  measures:
    - name: "total_counted_quantity"
      expr: SUM(CAST(counted_quantity AS DOUBLE))
      comment: "Total physical quantity counted. Baseline measure for inventory count scope."
    - name: "total_system_book_quantity"
      expr: SUM(CAST(system_book_quantity AS DOUBLE))
      comment: "Total system book quantity at time of count. Compared against counted quantity to compute accuracy."
    - name: "total_variance_quantity"
      expr: SUM(CAST(variance_quantity AS DOUBLE))
      comment: "Total quantity variance (counted minus book). Persistent positive or negative variances indicate systemic inventory management failures."
    - name: "total_variance_value"
      expr: SUM(CAST(variance_value AS DOUBLE))
      comment: "Total financial value of inventory variances. Directly impacts balance sheet accuracy and project cost reporting."
    - name: "inventory_accuracy_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN variance_quantity = 0 THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of inventory count lines with zero variance. World-class warehouses target 99%+ accuracy. Low accuracy drives write-offs and project cost overruns."
    - name: "recount_required_count"
      expr: COUNT(CASE WHEN recount_flag = TRUE THEN 1 END)
      comment: "Number of count lines requiring a recount. High recount rates indicate counting process failures or systemic discrepancies."
    - name: "count_lines_with_variance_count"
      expr: COUNT(CASE WHEN variance_quantity != 0 THEN 1 END)
      comment: "Number of count lines with non-zero variance. Measures the breadth of inventory accuracy issues across the warehouse."
    - name: "physical_inventory_count"
      expr: COUNT(1)
      comment: "Total number of physical inventory count lines. Baseline metric for count scope and coverage."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_conformance_certificate`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Material conformance and quality certification metrics. Tracks test results, compliance status, and certificate validity to ensure materials meet project specifications and regulatory requirements."
  source: "`vibe_construction_v1`.`material`.`conformance_certificate`"
  dimensions:
    - name: "conformance_certificate_status"
      expr: conformance_certificate_status
      comment: "Status of the conformance certificate (active, expired, revoked). Expired certificates represent compliance risk."
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the tested material. Non-compliant materials must be quarantined or rejected."
    - name: "test_result"
      expr: test_result
      comment: "Result of the material test (pass, fail, conditional). Drives accept/reject decisions for material use."
    - name: "material_type"
      expr: material_type
      comment: "Type of material tested. Enables quality performance analysis by material category."
    - name: "test_method"
      expr: test_method
      comment: "Test method applied. Supports standardization and method comparison analysis."
    - name: "test_standard"
      expr: test_standard
      comment: "Standard against which the material was tested (e.g., ASTM, BS, ISO). Ensures regulatory and specification compliance."
    - name: "issuing_lab"
      expr: issuing_lab
      comment: "Laboratory that issued the certificate. Enables lab performance benchmarking."
  measures:
    - name: "total_certificates_count"
      expr: COUNT(1)
      comment: "Total number of conformance certificates. Baseline metric for quality assurance coverage."
    - name: "passed_certificates_count"
      expr: COUNT(CASE WHEN test_result = 'PASS' THEN 1 END)
      comment: "Number of certificates with passing test results. Measures material quality acceptance rate."
    - name: "failed_certificates_count"
      expr: COUNT(CASE WHEN test_result = 'FAIL' THEN 1 END)
      comment: "Number of certificates with failing test results. Failed materials require rejection, substitution, or rework — directly impacting project cost and schedule."
    - name: "pass_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'PASS' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of conformance certificates with passing results. A key supplier quality KPI used in vendor evaluation and procurement decisions."
    - name: "active_certificates_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN 1 END)
      comment: "Number of currently active conformance certificates. Ensures material compliance coverage is maintained."
    - name: "avg_measured_value"
      expr: AVG(CAST(measured_value AS DOUBLE))
      comment: "Average measured test value across certificates. Benchmarks material performance against specification thresholds."
    - name: "avg_temperature_recorded"
      expr: AVG(CAST(temperature_recorded AS DOUBLE))
      comment: "Average temperature recorded during testing. Validates test conditions were within specification for temperature-sensitive materials."
    - name: "avg_humidity_recorded"
      expr: AVG(CAST(humidity_recorded AS DOUBLE))
      comment: "Average humidity recorded during testing. Validates environmental test conditions for moisture-sensitive materials."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inter-warehouse and inter-site stock transfer metrics. Tracks material movement efficiency, transfer volumes, and logistics performance across the construction supply chain."
  source: "`vibe_construction_v1`.`material`.`stock_transfer`"
  dimensions:
    - name: "stock_transfer_status"
      expr: stock_transfer_status
      comment: "Status of the stock transfer (pending, in-transit, received, cancelled). Tracks transfer lifecycle."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer (project demand, rebalancing, return). Enables analysis of transfer drivers."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport used for the transfer. Supports logistics cost and carbon footprint analysis."
    - name: "carrier_name"
      expr: carrier_name
      comment: "Name of the carrier executing the transfer. Enables carrier performance benchmarking."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity analysis."
  measures:
    - name: "total_quantity_transferred"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of materials transferred between warehouses or sites. Measures inter-site material flow volume."
    - name: "on_time_transfer_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp <= CAST(expected_arrival_date AS TIMESTAMP) THEN 1 END)
      comment: "Number of transfers that arrived on or before the expected date. Measures logistics reliability for material supply continuity."
    - name: "late_transfer_count"
      expr: COUNT(CASE WHEN actual_arrival_timestamp > CAST(expected_arrival_date AS TIMESTAMP) THEN 1 END)
      comment: "Number of late stock transfers. Late transfers can cause site stoppages and are a leading indicator of logistics performance issues."
    - name: "on_time_transfer_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN actual_arrival_timestamp <= CAST(expected_arrival_date AS TIMESTAMP) THEN 1 END) / NULLIF(COUNT(CASE WHEN actual_arrival_timestamp IS NOT NULL AND expected_arrival_date IS NOT NULL THEN 1 END), 0), 2)
      comment: "Percentage of stock transfers completed on time. A logistics KPI that directly impacts site material availability and project schedule performance."
    - name: "cancelled_transfers_count"
      expr: COUNT(CASE WHEN stock_transfer_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled stock transfers. High cancellation rates indicate poor demand planning or supply chain instability."
    - name: "stock_transfers_count"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Baseline metric for inter-site logistics activity volume."
$$;

CREATE OR REPLACE VIEW `vibe_construction_v1`.`_metrics`.`material_hazmat_register`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Hazardous material management and compliance metrics. Tracks hazmat inventory, inspection compliance, and regulatory status to manage HSE risk and regulatory obligations on construction sites."
  source: "`vibe_construction_v1`.`material`.`hazmat_register`"
  dimensions:
    - name: "hazmat_register_status"
      expr: hazmat_register_status
      comment: "Status of the hazmat register entry. Identifies active, expired, or disposed hazmat items."
    - name: "material_type"
      expr: material_type
      comment: "Type of hazardous material. Enables risk analysis by hazmat category."
    - name: "un_hazard_class"
      expr: un_hazard_class
      comment: "UN hazard classification. Required for regulatory reporting and transport compliance."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the hazardous material. Drives prioritization of inspection and control measures."
    - name: "hse_notification_status"
      expr: hse_notification_status
      comment: "Status of HSE authority notification. Unnotified hazmat represents regulatory compliance risk."
    - name: "storage_location"
      expr: storage_location
      comment: "Storage location of the hazmat. Enables site-level hazmat risk mapping."
  measures:
    - name: "total_quantity_on_site"
      expr: SUM(CAST(quantity_on_site AS DOUBLE))
      comment: "Total quantity of hazardous materials on site. Regulatory thresholds trigger mandatory reporting — exceeding limits creates compliance risk."
    - name: "overdue_inspection_count"
      expr: COUNT(CASE WHEN next_inspection_due < CURRENT_DATE() THEN 1 END)
      comment: "Number of hazmat items with overdue inspections. Overdue inspections are a direct regulatory compliance failure and HSE risk."
    - name: "inspection_compliance_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN next_inspection_due >= CURRENT_DATE() THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of hazmat items with current (non-overdue) inspections. A critical HSE compliance KPI monitored by regulators and project HSE managers."
    - name: "explosive_materials_count"
      expr: COUNT(CASE WHEN is_explosive = TRUE THEN 1 END)
      comment: "Number of explosive hazmat items on register. Explosives require the highest level of regulatory control and site security."
    - name: "radioactive_materials_count"
      expr: COUNT(CASE WHEN is_radioactive = TRUE THEN 1 END)
      comment: "Number of radioactive hazmat items. Radioactive materials require specialist licensing and regulatory reporting."
    - name: "unnotified_hse_count"
      expr: COUNT(CASE WHEN hse_notification_status != 'NOTIFIED' THEN 1 END)
      comment: "Number of hazmat items where HSE authority has not been notified. Unnotified hazmat represents a regulatory breach risk."
    - name: "avg_temperature_max_celsius"
      expr: AVG(CAST(temperature_max_celsius AS DOUBLE))
      comment: "Average maximum storage temperature threshold across hazmat items. Supports storage condition compliance monitoring."
    - name: "hazmat_items_count"
      expr: COUNT(1)
      comment: "Total number of hazardous material register entries. Baseline metric for site hazmat inventory scope."
$$;