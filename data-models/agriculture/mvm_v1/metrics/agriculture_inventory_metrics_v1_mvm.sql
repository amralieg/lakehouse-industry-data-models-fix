-- Metric views for domain: inventory | Business: Agriculture | Version: 1 | Generated on: 2026-05-01 18:41:06

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_stock_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic inventory stock position metrics providing a real-time view of on-hand quantities, availability, blocked stock, quality inspection holds, and total inventory value. Used by supply chain executives and inventory managers to steer replenishment, release decisions, and working capital allocation."
  source: "`agriculture_ecm`.`inventory`.`stock_position`"
  dimensions:
    - name: "stock_status"
      expr: stock_status
      comment: "Current status of the stock position (e.g., available, blocked, restricted) — primary filter for operational stock reviews."
    - name: "stock_type"
      expr: stock_type
      comment: "Classification of stock type (e.g., unrestricted, quality inspection, blocked) — used to segment inventory by usability."
    - name: "uom_primary"
      expr: uom_primary
      comment: "Primary unit of measure for the stock position — enables cross-commodity quantity comparisons."
    - name: "valuation_method"
      expr: valuation_method
      comment: "Inventory valuation method applied (e.g., FIFO, FEFO, standard cost) — critical for finance and audit reporting."
    - name: "rotation_method"
      expr: rotation_method
      comment: "Stock rotation method (FIFO/FEFO) — used to assess compliance with perishability and food safety policies."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates whether the stock position is organically certified — supports premium product segregation and compliance reporting."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the stock is GMO — required for segregation compliance and customer contract adherence."
    - name: "valuation_date"
      expr: DATE_TRUNC('month', valuation_date)
      comment: "Month of inventory valuation — enables trend analysis of stock value over time."
    - name: "last_movement_date"
      expr: DATE_TRUNC('month', last_movement_date)
      comment: "Month of last stock movement — used to identify slow-moving or stagnant inventory."
    - name: "expiration_date"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month of stock expiration — critical for perishability risk management and FEFO compliance."
  measures:
    - name: "total_inventory_value_usd"
      expr: SUM(CAST(total_value_usd AS DOUBLE))
      comment: "Total USD value of all stock positions. Core working capital KPI used by CFO and supply chain leadership to assess inventory investment and balance sheet exposure."
    - name: "total_qty_on_hand"
      expr: SUM(CAST(qty_on_hand AS DOUBLE))
      comment: "Total quantity on hand across all stock positions. Fundamental supply availability metric used in replenishment planning and customer commitment decisions."
    - name: "total_qty_available"
      expr: SUM(CAST(qty_available AS DOUBLE))
      comment: "Total quantity available for use or sale. Directly drives order fulfillment capacity and available-to-promise calculations."
    - name: "total_qty_blocked"
      expr: SUM(CAST(qty_blocked AS DOUBLE))
      comment: "Total quantity in blocked status. Elevated blocked stock signals quality, compliance, or operational issues requiring executive intervention."
    - name: "total_qty_in_quality_inspection"
      expr: SUM(CAST(qty_in_quality_inspection AS DOUBLE))
      comment: "Total quantity currently under quality inspection hold. High values indicate quality bottlenecks that delay fulfillment and increase working capital lock-up."
    - name: "total_qty_reserved"
      expr: SUM(CAST(qty_reserved AS DOUBLE))
      comment: "Total quantity reserved against open orders or contracts. Measures committed inventory exposure and supports available-to-promise accuracy."
    - name: "total_qty_shrinkage"
      expr: SUM(CAST(qty_shrinkage AS DOUBLE))
      comment: "Total quantity lost to shrinkage across all stock positions. Directly impacts margin and is a key loss-prevention KPI for operations leadership."
    - name: "avg_unit_price_usd"
      expr: AVG(CAST(unit_price_usd AS DOUBLE))
      comment: "Average unit price across stock positions. Used to benchmark inventory cost levels and detect valuation anomalies."
    - name: "total_price_variance_usd"
      expr: SUM(CAST(price_variance_usd AS DOUBLE))
      comment: "Total price variance (actual vs. standard cost) across stock positions. A key procurement and finance KPI — large variances trigger cost investigation and supplier renegotiation."
    - name: "blocked_stock_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_blocked AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is blocked. A rising blocked stock percentage signals systemic quality or compliance issues requiring leadership action."
    - name: "available_stock_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_available AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Percentage of on-hand inventory that is available for fulfillment. Core service-level and supply readiness KPI used in S&OP and executive dashboards."
    - name: "shrinkage_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(qty_shrinkage AS DOUBLE)) / NULLIF(SUM(CAST(qty_on_hand AS DOUBLE)), 0), 2)
      comment: "Shrinkage as a percentage of total on-hand inventory. Directly tied to margin erosion — a key loss-prevention and operational efficiency KPI."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt performance and quality metrics tracking inbound inventory volumes, moisture quality, weight accuracy, and receipt throughput. Used by procurement, operations, and quality leadership to evaluate supplier performance and inbound supply chain efficiency."
  source: "`agriculture_ecm`.`inventory`.`inventory_goods_receipt`"
  dimensions:
    - name: "receipt_status"
      expr: receipt_status
      comment: "Status of the goods receipt (e.g., posted, pending, reversed) — used to filter completed vs. in-progress receipts."
    - name: "receipt_type"
      expr: receipt_type
      comment: "Type of goods receipt (e.g., purchase order, return, farm harvest) — enables segmentation of inbound supply by source type."
    - name: "crop_season"
      expr: crop_season
      comment: "Crop season associated with the receipt — critical for seasonal supply planning and year-over-year harvest volume comparisons."
    - name: "crop_variety"
      expr: crop_variety
      comment: "Crop variety received — supports variety-level quality and volume analysis for agronomic and commercial decisions."
    - name: "uom_primary"
      expr: uom_primary
      comment: "Primary unit of measure for received quantities — enables cross-commodity volume comparisons."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates whether the received goods are organically certified — supports premium supply segregation and compliance tracking."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the received goods are GMO — required for identity preservation and contract compliance."
    - name: "grade_determination"
      expr: grade_determination
      comment: "Grade assigned at receipt (e.g., No. 1, No. 2, sample grade) — key quality dimension for pricing and contract settlement."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month of goods receipt — enables trend analysis of inbound supply volumes over time."
    - name: "harvest_month"
      expr: DATE_TRUNC('month', harvest_date)
      comment: "Month of harvest — used to correlate receipt timing with harvest cycles and assess post-harvest logistics efficiency."
  measures:
    - name: "total_receipts"
      expr: COUNT(1)
      comment: "Total number of goods receipt transactions. Baseline throughput KPI for inbound supply chain operations."
    - name: "total_quantity_received_mt"
      expr: SUM(CAST(quantity_mt AS DOUBLE))
      comment: "Total quantity received in metric tonnes. Primary volume KPI for procurement and supply planning — directly tied to harvest intake and contract fulfillment."
    - name: "total_quantity_received_bu"
      expr: SUM(CAST(quantity_bu AS DOUBLE))
      comment: "Total quantity received in bushels. Standard grain trade volume measure used in commodity contracts and elevator operations."
    - name: "total_net_weight_kg"
      expr: SUM(CAST(net_weight_kg AS DOUBLE))
      comment: "Total net weight received in kilograms. Used to reconcile physical intake against purchase order quantities and weight ticket settlements."
    - name: "total_gross_weight_kg"
      expr: SUM(CAST(gross_weight_kg AS DOUBLE))
      comment: "Total gross weight received in kilograms. Used alongside net weight to calculate tare and assess dockage at intake."
    - name: "total_tare_weight_kg"
      expr: SUM(CAST(tare_weight_kg AS DOUBLE))
      comment: "Total tare weight (container/vehicle weight) across receipts. Elevated tare relative to gross weight may indicate measurement or fraud risk."
    - name: "avg_moisture_pct"
      expr: AVG(CAST(moisture_pct AS DOUBLE))
      comment: "Average moisture content percentage at receipt. Critical grain quality KPI — high moisture increases storage risk, drying costs, and shrinkage. Directly impacts margin."
    - name: "avg_test_weight_lb_bu"
      expr: AVG(CAST(test_weight_lb_bu AS DOUBLE))
      comment: "Average test weight (lbs/bushel) at receipt. Key grain quality indicator — lower test weight signals lower density and reduced market value."
    - name: "net_to_gross_weight_ratio"
      expr: ROUND(SUM(CAST(net_weight_kg AS DOUBLE)) / NULLIF(SUM(CAST(gross_weight_kg AS DOUBLE)), 0), 4)
      comment: "Ratio of net weight to gross weight across receipts. Measures dockage and tare efficiency — a declining ratio may indicate increased impurities or measurement issues."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_goods_issue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods issue performance and cost metrics tracking outbound inventory movements, application rates, and total issue costs. Used by operations, agronomy, and finance leadership to manage input consumption efficiency, cost of goods issued, and field application compliance."
  source: "`agriculture_ecm`.`inventory`.`goods_issue`"
  dimensions:
    - name: "issue_status"
      expr: issue_status
      comment: "Status of the goods issue (e.g., posted, reversed, pending) — used to filter completed vs. in-progress outbound movements."
    - name: "movement_type_code"
      expr: movement_type_code
      comment: "SAP/WMS movement type code for the goods issue — enables segmentation by consumption purpose (e.g., production, field application, sales delivery)."
    - name: "movement_category"
      expr: movement_category
      comment: "High-level category of the goods movement — supports executive-level reporting on consumption patterns by category."
    - name: "destination_type"
      expr: destination_type
      comment: "Type of destination for the issued goods (e.g., field, production, customer) — critical for cost allocation and agronomic input tracking."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates whether the issued material is organically certified — supports organic program compliance and cost tracking."
    - name: "is_gmo"
      expr: is_gmo
      comment: "Indicates whether the issued material is GMO — required for identity preservation and regulatory compliance."
    - name: "phi_compliant"
      expr: phi_compliant
      comment: "Indicates whether the goods issue complies with pre-harvest interval (PHI) requirements — a critical food safety and regulatory compliance dimension."
    - name: "rei_compliant"
      expr: rei_compliant
      comment: "Indicates whether the goods issue complies with re-entry interval (REI) requirements — a critical worker safety and regulatory compliance dimension."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the goods issue cost — enables multi-currency cost analysis for global operations."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month of goods issue posting — enables trend analysis of outbound consumption and cost over time."
  measures:
    - name: "total_goods_issues"
      expr: COUNT(1)
      comment: "Total number of goods issue transactions. Baseline throughput KPI for outbound inventory operations."
    - name: "total_quantity_issued_mt"
      expr: SUM(CAST(quantity_issued_mt AS DOUBLE))
      comment: "Total quantity issued in metric tonnes. Primary outbound volume KPI — directly tied to production consumption, field application, and sales fulfillment."
    - name: "total_quantity_issued"
      expr: SUM(CAST(quantity_issued AS DOUBLE))
      comment: "Total quantity issued in primary UOM. Used alongside MT measure for commodity-specific consumption analysis."
    - name: "total_cost_issued_usd"
      expr: SUM(CAST(total_cost_usd AS DOUBLE))
      comment: "Total USD cost of all goods issued. Core cost-of-goods-consumed KPI used by finance and operations to track input spend and margin impact."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost of goods issued. Used to benchmark input pricing and detect cost anomalies across suppliers or periods."
    - name: "avg_application_rate"
      expr: AVG(CAST(application_rate AS DOUBLE))
      comment: "Average application rate of agrochemicals or inputs issued to fields. Deviations from agronomic recommendations signal over-application risk (cost and environmental) or under-application risk (yield loss)."
    - name: "phi_non_compliance_count"
      expr: COUNT(CASE WHEN phi_compliant = FALSE THEN 1 END)
      comment: "Number of goods issues that are not PHI-compliant. Any non-zero value is a critical food safety risk requiring immediate executive escalation and regulatory notification."
    - name: "rei_non_compliance_count"
      expr: COUNT(CASE WHEN rei_compliant = FALSE THEN 1 END)
      comment: "Number of goods issues that are not REI-compliant. Non-compliance represents worker safety violations with regulatory and reputational consequences."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN reversal_document_number IS NOT NULL THEN 1 END)
      comment: "Number of goods issues that have been reversed. High reversal rates indicate operational errors, quality rejections, or process breakdowns requiring investigation."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory adjustment analytics tracking shrinkage, variance, value impact, and adjustment patterns. Used by finance, operations, and audit leadership to monitor inventory accuracy, loss drivers, and the financial impact of stock corrections."
  source: "`agriculture_ecm`.`inventory`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of inventory adjustment (e.g., shrinkage, write-off, cycle count correction) — primary dimension for categorizing loss and correction events."
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of the adjustment (e.g., approved, pending, reversed) — used to filter finalized vs. in-progress adjustments."
    - name: "movement_type"
      expr: movement_type
      comment: "Inventory movement type associated with the adjustment — enables drill-down into specific adjustment drivers."
    - name: "shrinkage_type"
      expr: shrinkage_type
      comment: "Classification of shrinkage cause (e.g., moisture loss, theft, spoilage) — critical for loss prevention strategy and root cause analysis."
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code for the adjustment — enables systematic analysis of recurring loss drivers."
    - name: "reason_code"
      expr: reason_code
      comment: "Business reason code for the adjustment — supports audit trail and compliance reporting."
    - name: "is_reversal"
      expr: is_reversal
      comment: "Indicates whether the adjustment is a reversal of a prior document — used to net out corrections and identify error patterns."
    - name: "plant_code"
      expr: plant_code
      comment: "Plant or facility code where the adjustment occurred — enables location-level loss analysis."
    - name: "stock_type_before"
      expr: stock_type_before
      comment: "Stock type classification before the adjustment — used to understand what inventory category was impacted."
    - name: "posting_month"
      expr: DATE_TRUNC('month', posting_date)
      comment: "Month the adjustment was posted — enables trend analysis of inventory corrections and loss events over time."
    - name: "shrinkage_event_month"
      expr: DATE_TRUNC('month', shrinkage_event_date)
      comment: "Month the shrinkage event occurred — used to correlate loss events with seasonal patterns, storage conditions, or operational changes."
  measures:
    - name: "total_adjustments"
      expr: COUNT(1)
      comment: "Total number of inventory adjustment transactions. Baseline frequency KPI — high adjustment counts signal inventory accuracy issues."
    - name: "total_value_impact_usd"
      expr: SUM(CAST(value_impact_usd AS DOUBLE))
      comment: "Total USD financial impact of all inventory adjustments. Core P&L KPI — directly measures the cost of inventory inaccuracy, shrinkage, and write-offs."
    - name: "total_variance_qty"
      expr: SUM(CAST(variance_qty AS DOUBLE))
      comment: "Total quantity variance across all adjustments. Measures the aggregate physical discrepancy between system and actual inventory — a key inventory accuracy KPI."
    - name: "total_adjusted_qty"
      expr: SUM(CAST(adjusted_qty AS DOUBLE))
      comment: "Total quantity adjusted across all adjustment transactions. Measures the scale of inventory corrections applied to the system."
    - name: "avg_shrinkage_pct"
      expr: AVG(CAST(shrinkage_pct AS DOUBLE))
      comment: "Average shrinkage percentage across adjustment events. Benchmarks loss rates against industry standards and internal targets — a key margin protection KPI."
    - name: "avg_unit_cost_usd"
      expr: AVG(CAST(unit_cost_usd AS DOUBLE))
      comment: "Average unit cost of inventory involved in adjustments. Used to assess the financial weight of adjustments and prioritize high-value loss events."
    - name: "reversal_count"
      expr: COUNT(CASE WHEN is_reversal = TRUE THEN 1 END)
      comment: "Number of adjustment reversals. High reversal counts indicate process errors or control weaknesses in the adjustment workflow."
    - name: "total_original_qty"
      expr: SUM(CAST(original_qty AS DOUBLE))
      comment: "Total original quantity before adjustment. Used as the denominator baseline for calculating adjustment magnitude and shrinkage rates."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_cycle_count`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cycle count accuracy and variance metrics used to assess inventory record accuracy, count program effectiveness, and financial exposure from stock discrepancies. Used by warehouse operations, finance, and audit leadership to drive inventory control improvements."
  source: "`agriculture_ecm`.`inventory`.`cycle_count`"
  dimensions:
    - name: "count_status"
      expr: count_status
      comment: "Status of the cycle count (e.g., completed, in-progress, pending approval) — used to filter finalized counts for accuracy analysis."
    - name: "count_type"
      expr: count_type
      comment: "Type of cycle count (e.g., full physical inventory, cycle count, spot check) — enables comparison of accuracy across count methodologies."
    - name: "count_method"
      expr: count_method
      comment: "Method used to perform the count (e.g., manual, RF scanner, RFID) — used to assess technology impact on count accuracy."
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type being counted — enables accuracy analysis by inventory category."
    - name: "material_type"
      expr: material_type
      comment: "Material type being counted — supports accuracy benchmarking across commodity and input categories."
    - name: "recount_flag"
      expr: recount_flag
      comment: "Indicates whether this is a recount of a previously counted location — high recount rates signal persistent accuracy issues."
    - name: "adjustment_posted_flag"
      expr: adjustment_posted_flag
      comment: "Indicates whether a financial adjustment was posted as a result of this count — used to measure the rate of counts requiring correction."
    - name: "variance_root_cause_code"
      expr: variance_root_cause_code
      comment: "Root cause code for count variance — enables systematic analysis of recurring accuracy failure drivers."
    - name: "count_month"
      expr: DATE_TRUNC('month', count_date)
      comment: "Month the cycle count was performed — enables trend analysis of inventory accuracy over time."
  measures:
    - name: "total_cycle_counts"
      expr: COUNT(1)
      comment: "Total number of cycle count records. Measures the volume and cadence of the inventory counting program."
    - name: "total_variance_qty"
      expr: SUM(CAST(variance_qty AS DOUBLE))
      comment: "Total quantity variance (system vs. physical count) across all cycle counts. Core inventory accuracy KPI — large variances indicate systemic record-keeping failures."
    - name: "total_variance_value_usd"
      expr: SUM(CAST(variance_value_usd AS DOUBLE))
      comment: "Total USD financial value of cycle count variances. Directly measures the financial exposure from inventory inaccuracy — a key audit and finance KPI."
    - name: "avg_variance_pct"
      expr: AVG(CAST(variance_pct AS DOUBLE))
      comment: "Average variance percentage across cycle counts. Benchmarks inventory record accuracy against targets (e.g., 99.5% accuracy) — a standard warehouse KPI."
    - name: "total_count_qty"
      expr: SUM(CAST(count_qty AS DOUBLE))
      comment: "Total physical quantity counted across all cycle count records. Measures the scale of the counting program and coverage."
    - name: "total_system_qty"
      expr: SUM(CAST(system_qty AS DOUBLE))
      comment: "Total system-recorded quantity at time of count. Used alongside count_qty to calculate aggregate accuracy and identify systemic over/under-recording."
    - name: "counts_with_variance"
      expr: COUNT(CASE WHEN variance_qty <> 0 THEN 1 END)
      comment: "Number of cycle counts that identified a quantity variance. Measures the frequency of inventory discrepancies — a key inventory control health indicator."
    - name: "adjustment_posted_count"
      expr: COUNT(CASE WHEN adjustment_posted_flag = TRUE THEN 1 END)
      comment: "Number of cycle counts that resulted in a financial adjustment posting. Measures the rate of counts requiring system correction — directly tied to inventory accuracy and financial integrity."
    - name: "recount_rate_pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recount_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cycle counts that required a recount. High recount rates indicate counting process failures, difficult storage conditions, or persistent accuracy issues."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_quarantine_hold`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Quarantine hold risk and resolution metrics tracking the volume, duration, and disposition of inventory placed on hold for quality, regulatory, or safety reasons. Used by quality, compliance, and supply chain leadership to manage food safety risk, regulatory exposure, and supply availability impact."
  source: "`agriculture_ecm`.`inventory`.`quarantine_hold`"
  dimensions:
    - name: "hold_status"
      expr: hold_status
      comment: "Current status of the quarantine hold (e.g., active, released, disposed) — primary filter for open vs. resolved holds."
    - name: "hold_type"
      expr: hold_type
      comment: "Type of quarantine hold (e.g., quality, regulatory, MRL exceedance, pest) — enables risk categorization and prioritization."
    - name: "hold_reason"
      expr: hold_reason
      comment: "Reason for placing inventory on hold — supports root cause analysis and recurring issue identification."
    - name: "disposition_decision"
      expr: disposition_decision
      comment: "Final disposition decision for held inventory (e.g., release, destroy, rework, return to vendor) — measures the outcome distribution of quality events."
    - name: "initiating_event_type"
      expr: initiating_event_type
      comment: "Type of event that triggered the hold (e.g., lab result, customer complaint, regulatory inspection) — used to identify the primary sources of quality risk."
    - name: "is_recall_related"
      expr: is_recall_related
      comment: "Indicates whether the hold is related to a product recall — critical flag for food safety crisis management and regulatory reporting."
    - name: "regulatory_notification_required"
      expr: regulatory_notification_required
      comment: "Indicates whether regulatory notification is required for this hold — used to track compliance obligations and notification deadlines."
    - name: "uom_primary"
      expr: uom_primary
      comment: "Primary unit of measure for held quantities — enables cross-commodity hold volume comparisons."
    - name: "hold_start_month"
      expr: DATE_TRUNC('month', hold_start_date)
      comment: "Month the quarantine hold was initiated — enables trend analysis of hold frequency and seasonal quality risk patterns."
    - name: "actual_release_month"
      expr: DATE_TRUNC('month', actual_release_date)
      comment: "Month the hold was released — used to analyze hold resolution cycle times and disposition throughput."
  measures:
    - name: "total_active_holds"
      expr: COUNT(CASE WHEN hold_status = 'active' THEN 1 END)
      comment: "Number of currently active quarantine holds. Real-time supply risk KPI — high active hold counts signal systemic quality issues impacting supply availability."
    - name: "total_holds"
      expr: COUNT(1)
      comment: "Total number of quarantine hold records. Baseline frequency KPI for quality event management."
    - name: "total_qty_on_hold_mt"
      expr: SUM(CAST(qty_on_hold_mt AS DOUBLE))
      comment: "Total quantity on hold in metric tonnes. Measures the supply volume at risk — directly impacts available-to-promise and customer fulfillment commitments."
    - name: "total_qty_on_hold_bu"
      expr: SUM(CAST(qty_on_hold_bu AS DOUBLE))
      comment: "Total quantity on hold in bushels. Standard grain trade measure for held commodity volumes — used in elevator and grain merchandising operations."
    - name: "avg_mrl_detected_level"
      expr: AVG(CAST(mrl_detected_level AS DOUBLE))
      comment: "Average maximum residue level (MRL) detected in held inventory. Elevated MRL levels indicate pesticide application non-compliance with food safety regulatory thresholds."
    - name: "recall_related_hold_count"
      expr: COUNT(CASE WHEN is_recall_related = TRUE THEN 1 END)
      comment: "Number of holds related to product recalls. Any non-zero value represents a critical food safety event requiring immediate executive and regulatory response."
    - name: "regulatory_notification_pending_count"
      expr: COUNT(CASE WHEN regulatory_notification_required = TRUE AND regulatory_notification_date IS NULL THEN 1 END)
      comment: "Number of holds requiring regulatory notification where notification has not yet been filed. Represents active regulatory compliance risk and potential penalty exposure."
    - name: "hold_resolution_days_avg"
      expr: AVG(CAST(DATEDIFF(actual_release_date, hold_start_date) AS DOUBLE))
      comment: "Average number of days from hold initiation to actual release. Measures quality resolution cycle time — prolonged holds increase supply risk and working capital lock-up."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_commodity_lot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Commodity lot quality, quantity, and traceability metrics providing visibility into lot-level inventory status, moisture, grade, and expiration risk. Used by grain merchandising, quality, and supply chain leadership to manage commodity inventory quality and traceability compliance."
  source: "`agriculture_ecm`.`inventory`.`commodity_lot`"
  dimensions:
    - name: "lot_status"
      expr: lot_status
      comment: "Current status of the commodity lot (e.g., available, on-hold, consumed, expired) — primary filter for active vs. inactive lots."
    - name: "grade"
      expr: grade
      comment: "Grade assigned to the commodity lot — key quality and pricing dimension for grain merchandising and contract settlement."
    - name: "gmo_status"
      expr: gmo_status
      comment: "GMO status of the lot (e.g., GMO, non-GMO, identity preserved) — critical for contract compliance and premium market access."
    - name: "is_organic_certified"
      expr: is_organic_certified
      comment: "Indicates whether the lot is organically certified — supports organic program integrity and premium pricing."
    - name: "storage_type"
      expr: storage_type
      comment: "Type of storage facility holding the lot (e.g., flat storage, bin, silo) — used to assess storage condition risk and capacity utilization."
    - name: "rotation_method"
      expr: rotation_method
      comment: "Stock rotation method applied to the lot (FIFO/FEFO) — used to assess compliance with perishability management policies."
    - name: "disposition_action"
      expr: disposition_action
      comment: "Planned or executed disposition action for the lot — used to track lot lifecycle decisions and supply availability."
    - name: "country_of_origin"
      expr: country_of_origin
      comment: "Country of origin for the commodity lot — required for trade compliance, import/export documentation, and country-of-origin labeling."
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_date)
      comment: "Month the lot was received — enables trend analysis of inbound lot volumes and seasonal intake patterns."
    - name: "expiration_month"
      expr: DATE_TRUNC('month', expiration_date)
      comment: "Month the lot expires — critical for perishability risk management and FEFO compliance planning."
  measures:
    - name: "total_lots"
      expr: COUNT(1)
      comment: "Total number of commodity lots. Baseline lot inventory count used for traceability coverage and lot management program assessment."
    - name: "total_quantity_mt"
      expr: SUM(CAST(quantity_mt AS DOUBLE))
      comment: "Total commodity quantity across all lots in metric tonnes. Primary volume KPI for commodity inventory management and merchandising decisions."
    - name: "total_quantity_bu"
      expr: SUM(CAST(quantity_bu AS DOUBLE))
      comment: "Total commodity quantity across all lots in bushels. Standard grain trade volume measure for elevator and merchandising operations."
    - name: "total_received_quantity_bu"
      expr: SUM(CAST(received_quantity_bu AS DOUBLE))
      comment: "Total quantity received at intake in bushels. Used to calculate net shrinkage by comparing received vs. current quantity."
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_pct AS DOUBLE))
      comment: "Average moisture content percentage across commodity lots. Elevated moisture increases spoilage risk and drying costs — a critical grain quality and storage management KPI."
    - name: "avg_test_weight_lbs_bu"
      expr: AVG(CAST(test_weight_lbs_bu AS DOUBLE))
      comment: "Average test weight (lbs/bushel) across commodity lots. Key grain quality indicator — lower test weight reduces market value and contract settlement amounts."
    - name: "avg_shrinkage_pct"
      expr: AVG(CAST(shrinkage_pct AS DOUBLE))
      comment: "Average shrinkage percentage across commodity lots. Measures post-receipt quantity loss — directly impacts margin and storage efficiency."
    - name: "lots_expiring_within_30_days"
      expr: COUNT(CASE WHEN expiration_date <= DATE_ADD(CURRENT_DATE(), 30) AND expiration_date >= CURRENT_DATE() THEN 1 END)
      comment: "Number of commodity lots expiring within the next 30 days. Critical perishability risk KPI — drives urgent disposition and sales prioritization decisions."
    - name: "organic_certified_lot_count"
      expr: COUNT(CASE WHEN is_organic_certified = TRUE THEN 1 END)
      comment: "Number of organically certified commodity lots. Measures organic supply availability — directly tied to premium market commitments and organic program revenue."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_stock_transfer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Stock transfer efficiency and volume metrics tracking inter-facility and inter-company inventory movements. Used by supply chain, logistics, and finance leadership to optimize network inventory positioning, monitor transfer cycle times, and manage inter-company settlement."
  source: "`agriculture_ecm`.`inventory`.`stock_transfer`"
  dimensions:
    - name: "transfer_status"
      expr: transfer_status
      comment: "Current status of the stock transfer (e.g., in-transit, completed, cancelled) — primary filter for active vs. completed transfers."
    - name: "transfer_type"
      expr: transfer_type
      comment: "Type of stock transfer (e.g., plant-to-plant, inter-company, storage location) — enables segmentation of transfer volumes by network movement type."
    - name: "transfer_reason"
      expr: transfer_reason
      comment: "Business reason for the transfer (e.g., rebalancing, customer order, production supply) — used to analyze the drivers of network inventory movements."
    - name: "transfer_priority"
      expr: transfer_priority
      comment: "Priority level of the transfer — used to assess urgency distribution and identify bottlenecks in high-priority movements."
    - name: "is_inter_company"
      expr: is_inter_company
      comment: "Indicates whether the transfer is between legal entities — critical for inter-company accounting, transfer pricing, and consolidation."
    - name: "quality_inspection_required"
      expr: quality_inspection_required
      comment: "Indicates whether a quality inspection is required upon receipt — used to plan inspection resource allocation and assess transfer cycle time impact."
    - name: "rotation_method"
      expr: rotation_method
      comment: "Stock rotation method applied to the transferred inventory — used to verify FIFO/FEFO compliance across network movements."
    - name: "uom"
      expr: uom
      comment: "Unit of measure for transferred quantities — enables cross-commodity transfer volume comparisons."
    - name: "transfer_month"
      expr: DATE_TRUNC('month', transfer_date)
      comment: "Month the transfer was initiated — enables trend analysis of network inventory movement volumes over time."
  measures:
    - name: "total_transfers"
      expr: COUNT(1)
      comment: "Total number of stock transfer transactions. Baseline throughput KPI for supply chain network operations."
    - name: "total_qty_transferred_mt"
      expr: SUM(CAST(qty_transferred_mt AS DOUBLE))
      comment: "Total quantity transferred in metric tonnes. Primary network movement volume KPI — used to assess supply chain network utilization and logistics cost drivers."
    - name: "total_qty_transferred"
      expr: SUM(CAST(qty_transferred AS DOUBLE))
      comment: "Total quantity transferred in primary UOM. Used alongside MT measure for commodity-specific transfer volume analysis."
    - name: "avg_transit_days"
      expr: AVG(CAST(DATEDIFF(goods_receipt_timestamp, goods_issue_timestamp) AS DOUBLE))
      comment: "Average transit time in days from goods issue to goods receipt. Measures supply chain network responsiveness — prolonged transit times increase working capital and supply risk."
    - name: "inter_company_transfer_count"
      expr: COUNT(CASE WHEN is_inter_company = TRUE THEN 1 END)
      comment: "Number of inter-company stock transfers. Measures the volume of cross-entity movements requiring inter-company accounting and transfer pricing treatment."
    - name: "quality_inspection_required_count"
      expr: COUNT(CASE WHEN quality_inspection_required = TRUE THEN 1 END)
      comment: "Number of transfers requiring quality inspection upon receipt. Used to plan inspection resource allocation and assess quality gate impact on transfer cycle times."
    - name: "in_transit_count"
      expr: COUNT(CASE WHEN transfer_status = 'in_transit' THEN 1 END)
      comment: "Number of transfers currently in transit. Measures open supply chain exposure — high in-transit counts with long durations signal logistics bottlenecks."
$$;

CREATE OR REPLACE VIEW `agriculture_ecm`.`_metrics`.`inventory_storage_location`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Storage location capacity, utilization, and compliance metrics used by operations, facilities, and food safety leadership to manage storage infrastructure, assess capacity constraints, and ensure regulatory certification compliance."
  source: "`agriculture_ecm`.`inventory`.`storage_location`"
  dimensions:
    - name: "location_status"
      expr: location_status
      comment: "Operational status of the storage location (e.g., active, inactive, decommissioned) — primary filter for operational capacity analysis."
    - name: "location_type"
      expr: location_type
      comment: "Type of storage location (e.g., bin, flat storage, refrigerated warehouse, field bin) — enables capacity and compliance analysis by facility type."
    - name: "commodity_class"
      expr: commodity_class
      comment: "Class of commodity the location is designated for — used to assess commodity-specific storage capacity and segregation compliance."
    - name: "temperature_controlled"
      expr: temperature_controlled
      comment: "Indicates whether the location is temperature-controlled — used to assess cold chain capacity and compliance with perishable storage requirements."
    - name: "humidity_controlled"
      expr: humidity_controlled
      comment: "Indicates whether the location is humidity-controlled — critical for grain and produce storage quality management."
    - name: "organic_certified"
      expr: organic_certified
      comment: "Indicates whether the storage location is certified for organic product storage — measures organic storage capacity availability."
    - name: "gmo_segregation_required"
      expr: gmo_segregation_required
      comment: "Indicates whether GMO segregation is required at this location — critical for identity preservation compliance and premium market access."
    - name: "food_safety_certification"
      expr: food_safety_certification
      comment: "Food safety certification held by the location (e.g., SQF, BRC, FSSC 22000) — used to assess compliance coverage and certification gaps."
    - name: "country_code"
      expr: country_code
      comment: "Country where the storage location is situated — enables geographic capacity and compliance analysis."
    - name: "commissioning_month"
      expr: DATE_TRUNC('month', commissioning_date)
      comment: "Month the storage location was commissioned — used to analyze capacity additions over time and infrastructure investment trends."
  measures:
    - name: "total_storage_locations"
      expr: COUNT(1)
      comment: "Total number of storage locations in the network. Baseline infrastructure KPI for capacity planning and network footprint management."
    - name: "total_capacity_mt"
      expr: SUM(CAST(capacity_mt AS DOUBLE))
      comment: "Total storage capacity in metric tonnes across all locations. Core infrastructure KPI — directly constrains supply chain throughput and seasonal harvest intake capacity."
    - name: "total_capacity_bu"
      expr: SUM(CAST(capacity_bu AS DOUBLE))
      comment: "Total storage capacity in bushels. Standard grain industry capacity measure used for elevator and grain merchandising operations."
    - name: "avg_max_temperature_c"
      expr: AVG(CAST(max_temperature_c AS DOUBLE))
      comment: "Average maximum storage temperature across locations. Used to assess cold chain adequacy and identify locations at risk of exceeding commodity storage temperature thresholds."
    - name: "organic_certified_capacity_mt"
      expr: SUM(CASE WHEN organic_certified = TRUE THEN CAST(capacity_mt AS DOUBLE) ELSE 0 END)
      comment: "Total storage capacity in metric tonnes at organically certified locations. Measures organic supply chain infrastructure — directly constrains organic program growth and premium revenue potential."
    - name: "temperature_controlled_capacity_mt"
      expr: SUM(CASE WHEN temperature_controlled = TRUE THEN CAST(capacity_mt AS DOUBLE) ELSE 0 END)
      comment: "Total storage capacity in metric tonnes at temperature-controlled locations. Measures cold chain infrastructure — critical for perishable commodity and food safety compliance."
    - name: "locations_due_for_inspection"
      expr: COUNT(CASE WHEN next_inspection_due_date <= CURRENT_DATE() THEN 1 END)
      comment: "Number of storage locations with overdue inspections. Measures food safety and regulatory compliance risk — overdue inspections represent potential certification lapses and regulatory exposure."
$$;