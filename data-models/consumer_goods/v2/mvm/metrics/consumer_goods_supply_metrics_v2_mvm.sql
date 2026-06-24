-- Metric views for domain: supply | Business: Consumer_Goods | Version: 2 | Generated on: 2026-06-24 01:51:46

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic demand planning KPIs covering forecast accuracy, bias, consensus coverage, and promotional uplift. Used by S&OP leaders and demand planners to evaluate plan quality and drive corrective action."
  source: "`vibe_consumer_goods_v1`.`supply`.`demand_plan`"
  dimensions:
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Time bucket granularity of the demand plan (e.g. weekly, monthly) — used to slice KPIs by planning horizon resolution."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Characterisation of the demand pattern (e.g. seasonal, intermittent, stable) — key driver of forecast model selection."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk tier assigned to the demand plan record — enables risk-stratified performance monitoring."
    - name: "demand_plan_status"
      expr: demand_plan_status
      comment: "Workflow status of the demand plan (e.g. draft, approved, locked) — filters active vs. historical plans."
    - name: "version_type"
      expr: version_type
      comment: "Type of demand plan version (e.g. statistical, consensus, final) — distinguishes plan stages in the S&OP cycle."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Product lifecycle stage associated with the plan (e.g. launch, growth, decline) — contextualises forecast expectations."
    - name: "planning_period_start_date"
      expr: DATE_TRUNC('month', planning_period_start_date)
      comment: "Month-truncated planning period start — enables time-series trending of demand plan KPIs."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Planner-assigned confidence tier for the forecast — used to weight or filter plan quality analysis."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Flag indicating whether this is the agreed consensus version — isolates the authoritative plan for KPI reporting."
  measures:
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across demand plan records. Core S&OP KPI — directly measures how well the statistical or consensus forecast predicts actual demand. Drives model selection and planner intervention."
    - name: "avg_forecast_bias_pct"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage — positive bias indicates systematic over-forecasting; negative indicates under-forecasting. Executives use this to detect structural planning errors that inflate inventory or cause stockouts."
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus demand quantity across all plan records. Represents the agreed demand signal used for supply planning — a primary input to production and procurement decisions."
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Total statistical baseline forecast quantity before commercial overlays. Benchmarks the algorithmic forecast against the final consensus to quantify human adjustment magnitude."
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional volume uplift added on top of the baseline forecast. Measures the scale of trade promotion impact on the demand plan — critical for marketing ROI and supply readiness."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial adjustment quantity applied by sales or commercial teams. Quantifies the degree of human override on the statistical forecast — high values may indicate model distrust."
    - name: "total_npd_launch_volume_quantity"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product introduction volume planned. Tracks the scale of innovation pipeline demand — used by supply chain and finance to size launch inventory and capacity."
    - name: "total_variance_to_baseline_quantity"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between consensus and statistical baseline quantity. Measures the aggregate human adjustment to the machine forecast — large variances warrant governance review."
    - name: "risk_flagged_plan_count"
      expr: COUNT(CASE WHEN risk_flag = TRUE THEN demand_plan_id END)
      comment: "Number of demand plan records flagged as high-risk. Executives use this to prioritise S&OP review agenda items and allocate risk mitigation resources."
    - name: "consensus_plan_count"
      expr: COUNT(CASE WHEN is_consensus_version = TRUE THEN demand_plan_id END)
      comment: "Number of demand plan records that represent the agreed consensus version. Tracks S&OP process maturity — low consensus coverage signals governance gaps."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_forecast_version`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Forecast version quality and lifecycle KPIs for supply chain planning governance. Used by demand planners and S&OP managers to track forecast accuracy, version progression, and model performance."
  source: "`vibe_consumer_goods_v1`.`supply`.`forecast_version`"
  dimensions:
    - name: "version_type"
      expr: version_type
      comment: "Type of forecast version (e.g. statistical, consensus, final approved) — segments KPIs by planning stage."
    - name: "forecast_version_status"
      expr: forecast_version_status
      comment: "Current workflow status of the forecast version — filters active, archived, or rejected versions."
    - name: "aggregation_level"
      expr: aggregation_level
      comment: "Granularity at which the forecast was generated (e.g. SKU/DC, brand/region) — contextualises accuracy metrics."
    - name: "time_bucket"
      expr: time_bucket
      comment: "Time granularity of the forecast (e.g. weekly, monthly) — used to compare accuracy across planning horizons."
    - name: "statistical_model_applied"
      expr: statistical_model_applied
      comment: "Statistical model used to generate the forecast (e.g. ARIMA, Holt-Winters) — enables model benchmarking."
    - name: "is_active_version"
      expr: is_active_version
      comment: "Flag indicating the currently active forecast version — isolates live plan from historical snapshots."
    - name: "is_final_approved_version"
      expr: is_final_approved_version
      comment: "Flag indicating the final approved version — used to report on the authoritative plan used for execution."
    - name: "snapshot_date"
      expr: DATE_TRUNC('month', snapshot_date)
      comment: "Month-truncated snapshot date — enables time-series trending of forecast version KPIs."
    - name: "demand_sensing_applied"
      expr: demand_sensing_applied
      comment: "Flag indicating whether demand sensing signals were incorporated — measures adoption of advanced forecasting techniques."
  measures:
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across all forecast versions. Primary KPI for evaluating forecast model performance — directly linked to inventory efficiency and service level outcomes."
    - name: "avg_mean_absolute_percentage_error"
      expr: AVG(CAST(mean_absolute_percentage_error AS DOUBLE))
      comment: "Average MAPE across forecast versions. Industry-standard forecast error metric used by S&OP leaders to benchmark model quality and drive continuous improvement."
    - name: "avg_bias_percentage"
      expr: AVG(CAST(bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage — detects systematic over- or under-forecasting tendencies that inflate inventory costs or cause service failures."
    - name: "active_version_count"
      expr: COUNT(CASE WHEN is_active_version = TRUE THEN forecast_version_id END)
      comment: "Number of currently active forecast versions. Governance metric — multiple active versions per SKU/node may indicate process control issues."
    - name: "final_approved_version_count"
      expr: COUNT(CASE WHEN is_final_approved_version = TRUE THEN forecast_version_id END)
      comment: "Number of forecast versions that have reached final approval. Tracks S&OP process completion rate — low counts signal bottlenecks in the approval workflow."
    - name: "demand_sensing_adoption_count"
      expr: COUNT(CASE WHEN demand_sensing_applied = TRUE THEN forecast_version_id END)
      comment: "Number of forecast versions where demand sensing was applied. Measures adoption of real-time demand signal integration — a leading indicator of forecast accuracy improvement."
    - name: "promotional_events_included_count"
      expr: COUNT(CASE WHEN promotional_events_included = TRUE THEN forecast_version_id END)
      comment: "Number of forecast versions that incorporate promotional event uplifts. Ensures trade promotion impact is reflected in supply plans — gaps here cause stockouts during promotions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available-to-Promise (ATP) and Capable-to-Promise (CTP) KPIs for order fulfilment and supply commitment management. Used by customer service, supply planners, and commercial teams to manage order confirmations and backorder risk."
  source: "`vibe_consumer_goods_v1`.`supply`.`atp_record`"
  dimensions:
    - name: "atp_status"
      expr: atp_status
      comment: "Current ATP status of the record (e.g. confirmed, partial, backorder) — primary filter for fulfilment risk analysis."
    - name: "atp_record_status"
      expr: atp_record_status
      comment: "Processing status of the ATP record — distinguishes active commitments from cancelled or expired records."
    - name: "commitment_status"
      expr: commitment_status
      comment: "Customer commitment status — tracks whether supply has been formally committed to a customer order."
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "Method used to calculate ATP (e.g. simple, cumulative, CTP) — contextualises the reliability of the ATP figure."
    - name: "customer_priority_tier"
      expr: customer_priority_tier
      comment: "Priority tier of the customer — enables tiered service level analysis and allocation decisions."
    - name: "product_allocation_group"
      expr: product_allocation_group
      comment: "Product allocation group — used to analyse supply allocation fairness and coverage across customer segments."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields — ensures consistent aggregation across SKUs."
    - name: "atp_date"
      expr: DATE_TRUNC('month', atp_date)
      comment: "Month-truncated ATP date — enables time-series trending of availability and backorder KPIs."
    - name: "planning_version"
      expr: planning_version
      comment: "Planning version associated with the ATP record — allows comparison of ATP outcomes across planning scenarios."
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity. Core supply commitment KPI — directly measures how much supply can be promised to customers without risking existing commitments."
    - name: "total_available_quantity"
      expr: SUM(CAST(available_quantity AS DOUBLE))
      comment: "Total available inventory quantity across all ATP records. Measures gross supply availability before allocation — used to assess fulfilment capacity."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total backorder quantity across all ATP records. Critical service level KPI — high backorder volumes signal supply shortfalls and risk customer relationship damage."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity already allocated to customer orders. Measures supply commitment depth — used alongside ATP quantity to assess remaining availability."
    - name: "total_on_hand_inventory"
      expr: SUM(CAST(on_hand_inventory AS DOUBLE))
      comment: "Total on-hand inventory quantity across ATP records. Baseline inventory position metric — used to assess immediate fulfilment capability without replenishment."
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit. Measures inbound supply pipeline — critical for short-horizon ATP calculations and customer promise accuracy."
    - name: "total_cumulative_atp_quantity"
      expr: SUM(CAST(cumulative_atp_quantity AS DOUBLE))
      comment: "Total cumulative ATP quantity across the planning horizon. Used for rolling availability analysis — supports multi-period customer commitment decisions."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total Capable-to-Promise quantity including planned production. Extends ATP with manufacturing capacity — used for make-to-order and new product launch commitments."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity reserved across ATP records. Measures the buffer inventory protecting service levels — used to assess whether safety stock policies are being respected in ATP calculations."
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(backorder_quantity AS DOUBLE)) / NULLIF(SUM(CAST(available_quantity AS DOUBLE)), 0), 2)
      comment: "Backorder quantity as a percentage of available quantity. Compound KPI measuring supply shortfall severity — executives use this to trigger emergency replenishment or customer allocation decisions."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Replenishment order execution KPIs covering order fulfilment, receipt performance, and supply reliability. Used by supply chain managers and logistics teams to monitor replenishment effectiveness and identify execution gaps."
  source: "`vibe_consumer_goods_v1`.`supply`.`replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. planned, in-transit, received, cancelled) — primary filter for execution monitoring."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g. DRP, safety stock trigger, manual) — segments KPIs by replenishment trigger mechanism."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transport used for the replenishment (e.g. road, rail, air) — enables cost and lead time analysis by transport type."
    - name: "priority"
      expr: priority
      comment: "Priority level of the replenishment order — used to analyse whether high-priority orders are being fulfilled faster."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Flag indicating the order was triggered by a safety stock breach — isolates reactive replenishment from planned replenishment."
    - name: "planned_receipt_date"
      expr: DATE_TRUNC('month', planned_receipt_date)
      comment: "Month-truncated planned receipt date — enables time-series analysis of inbound supply pipeline."
    - name: "actual_receipt_date"
      expr: DATE_TRUNC('month', actual_receipt_date)
      comment: "Month-truncated actual receipt date — used to compare planned vs. actual receipt timing at monthly granularity."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity fields — ensures consistent aggregation across SKUs and nodes."
  measures:
    - name: "total_order_quantity"
      expr: SUM(CAST(order_quantity AS DOUBLE))
      comment: "Total replenishment quantity ordered. Primary volume KPI for supply chain throughput — used to size inbound logistics capacity and supplier commitments."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received from replenishment orders. Measures supply execution completeness — gaps vs. ordered quantity indicate supplier or logistics failures."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped by suppliers or distribution centres. Tracks outbound supply pipeline — used to reconcile shipped vs. received quantities and identify in-transit losses."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by the supplier or source node. Measures supplier commitment reliability — large gaps between ordered and confirmed quantities signal supply risk."
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total cost of replenishment orders. Financial KPI for supply chain cost management — used by finance and supply chain to track replenishment spend against budget."
    - name: "receipt_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(order_quantity AS DOUBLE)), 0), 2)
      comment: "Received quantity as a percentage of ordered quantity. Compound KPI measuring supplier delivery completeness — a key OTIF input. Low fill rates trigger supplier performance reviews."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN replenishment_order_id END)
      comment: "Number of replenishment orders triggered by safety stock breaches. Measures reactive replenishment frequency — high counts indicate chronic supply shortfalls or under-sized safety stocks."
    - name: "avg_order_cost_amount"
      expr: AVG(CAST(order_cost_amount AS DOUBLE))
      comment: "Average cost per replenishment order. Used to benchmark replenishment efficiency and identify high-cost lanes or order patterns that should be consolidated."
    - name: "total_forecast_demand_quantity"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity that drove replenishment orders. Enables comparison of forecast-driven vs. actual replenishment volumes — a key input to demand-supply alignment analysis."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across replenishment order records. Governance KPI — low scores indicate data integrity issues that may compromise supply planning accuracy."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock adequacy and service level KPIs for inventory risk management. Used by supply planners and inventory managers to ensure buffer stock policies protect service levels while minimising holding costs."
  source: "`vibe_consumer_goods_v1`.`supply`.`safety_stock`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU (A=high value, B=medium, C=low) — enables tiered safety stock analysis aligned to inventory investment priorities."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification based on demand variability (X=stable, Y=variable, Z=erratic) — contextualises safety stock levels against demand predictability."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand pattern classification — used to validate that safety stock calculation methods are appropriate for the demand profile."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Method used to calculate safety stock (e.g. statistical, days-of-supply, fixed) — enables benchmarking of method effectiveness."
    - name: "safety_stock_status"
      expr: safety_stock_status
      comment: "Current status of the safety stock record (e.g. active, pending review, expired) — filters live safety stock policies."
    - name: "review_status"
      expr: review_status
      comment: "Review workflow status — identifies safety stock records overdue for review that may be misaligned with current demand patterns."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating whether the safety stock record is currently active — isolates live policies from historical records."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month-truncated effective date — enables time-series analysis of safety stock policy changes."
  measures:
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total calculated safety stock units across all records. Baseline inventory buffer KPI — used to assess total safety stock investment and compare against approved levels."
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units. Represents the authorised inventory buffer — used by finance and supply chain to track approved vs. calculated safety stock alignment."
    - name: "avg_target_service_level_pct"
      expr: AVG(CAST(target_service_level_percent AS DOUBLE))
      comment: "Average target service level percentage across safety stock records. Strategic KPI — measures the ambition of service level commitments embedded in inventory policy."
    - name: "avg_days_of_supply"
      expr: AVG(CAST(days_of_supply AS DOUBLE))
      comment: "Average days of supply represented by safety stock. Operational KPI — used to assess whether buffer inventory provides adequate coverage against lead time and demand variability."
    - name: "avg_days_of_supply_target"
      expr: AVG(CAST(days_of_supply_target AS DOUBLE))
      comment: "Average target days of supply for safety stock. Benchmarks actual days of supply against policy targets — gaps indicate under- or over-stocking relative to policy."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage associated with safety stock calculations. Links forecast quality to safety stock sizing — poor accuracy drives higher safety stock requirements and holding costs."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient across safety stock records. Measures the volatility driving safety stock requirements — high values indicate categories where demand sensing investment would reduce buffer costs."
    - name: "total_holding_cost"
      expr: SUM(CAST(holding_cost_per_unit AS DOUBLE) * CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total estimated holding cost of approved safety stock (holding cost per unit × approved units). Financial KPI linking inventory policy to cost — used by finance to quantify the cost of service level commitments."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across safety stock records. Composite risk KPI — high scores indicate SKU/node combinations where supply disruption risk justifies elevated safety stock investment."
    - name: "safety_stock_override_count"
      expr: COUNT(CASE WHEN override_reason_code IS NOT NULL THEN safety_stock_id END)
      comment: "Number of safety stock records where a manual override was applied. Governance KPI — high override counts may indicate that the calculation method is not trusted or is miscalibrated."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_inventory_policy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory policy compliance and service level target KPIs. Used by supply chain directors and inventory managers to govern replenishment rules, service commitments, and policy adherence across the network."
  source: "`vibe_consumer_goods_v1`.`supply`.`inventory_policy`"
  dimensions:
    - name: "policy_type"
      expr: policy_type
      comment: "Type of inventory policy (e.g. min-max, reorder point, VMI) — segments KPIs by replenishment strategy."
    - name: "replenishment_method"
      expr: replenishment_method
      comment: "Replenishment method defined in the policy (e.g. fixed order quantity, periodic review) — used to analyse method effectiveness."
    - name: "inventory_policy_status"
      expr: inventory_policy_status
      comment: "Current status of the inventory policy — filters active policies from expired or draft records."
    - name: "approval_status"
      expr: approval_status
      comment: "Approval workflow status of the policy — identifies unapproved policies that may be driving non-compliant replenishment."
    - name: "retailer_mandated_target_flag"
      expr: retailer_mandated_target_flag
      comment: "Flag indicating the service level target is mandated by a retailer — isolates contractually binding service commitments."
    - name: "penalty_clause_indicator"
      expr: penalty_clause_indicator
      comment: "Flag indicating a financial penalty clause is attached to the policy — prioritises policies where non-compliance has direct financial consequences."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Month-truncated effective start date — enables time-series analysis of policy changes and their impact on service levels."
    - name: "safety_stock_calculation_method"
      expr: safety_stock_calculation_method
      comment: "Method used to calculate safety stock within the policy — enables benchmarking of calculation method effectiveness."
  measures:
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across inventory policies. Strategic KPI — measures the aggregate service ambition embedded in inventory policy. Used by commercial and supply chain leadership to align service commitments with cost."
    - name: "avg_fill_rate_target_pct"
      expr: AVG(CAST(fill_rate_target_percent AS DOUBLE))
      comment: "Average fill rate target percentage. Measures the order completeness commitment embedded in policy — directly linked to customer satisfaction and retailer penalty risk."
    - name: "avg_otif_composite_target_pct"
      expr: AVG(CAST(otif_composite_target_percent AS DOUBLE))
      comment: "Average OTIF (On-Time In-Full) composite target percentage. Compound service KPI — the primary retailer scorecard metric. Executives use this to assess contractual compliance risk."
    - name: "avg_safety_stock_days_of_supply"
      expr: AVG(CAST(safety_stock_days_of_supply AS DOUBLE))
      comment: "Average safety stock days of supply defined in inventory policies. Measures the buffer coverage mandated by policy — used to assess whether policies are calibrated to demand and lead time variability."
    - name: "total_safety_stock_target_units"
      expr: SUM(CAST(safety_stock_target_units AS DOUBLE))
      comment: "Total safety stock target units across all inventory policies. Quantifies the total buffer inventory investment mandated by policy — used by finance to budget holding costs."
    - name: "avg_customer_otif_commitment_pct"
      expr: AVG(CAST(customer_otif_commitment_percent AS DOUBLE))
      comment: "Average customer OTIF commitment percentage. Measures the service level promised to customers — gaps between this and actual OTIF performance drive penalty exposure and customer churn risk."
    - name: "penalty_clause_policy_count"
      expr: COUNT(CASE WHEN penalty_clause_indicator = TRUE THEN inventory_policy_id END)
      comment: "Number of inventory policies with active penalty clauses. Risk KPI — quantifies the number of policies where non-compliance has direct financial consequences. Used by supply chain risk management."
    - name: "retailer_mandated_policy_count"
      expr: COUNT(CASE WHEN retailer_mandated_target_flag = TRUE THEN inventory_policy_id END)
      comment: "Number of inventory policies with retailer-mandated service targets. Measures the scale of externally imposed service obligations — used to prioritise compliance monitoring resources."
    - name: "avg_reorder_point"
      expr: AVG(CAST(reorder_point AS DOUBLE))
      comment: "Average reorder point quantity across inventory policies. Operational KPI — used to assess whether reorder triggers are appropriately calibrated to lead times and demand variability."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_network_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network lane performance and cost KPIs. Used by supply chain network designers and logistics managers to evaluate lane efficiency, lead times, and service level commitments across the distribution network."
  source: "`vibe_consumer_goods_v1`.`supply`.`network_lane`"
  dimensions:
    - name: "lane_type"
      expr: lane_type
      comment: "Type of network lane (e.g. primary, secondary, cross-dock) — segments KPIs by lane role in the supply network."
    - name: "transport_mode"
      expr: transport_mode
      comment: "Mode of transport for the lane (e.g. road, rail, sea, air) — enables cost and lead time benchmarking by transport type."
    - name: "is_primary_lane"
      expr: is_primary_lane
      comment: "Flag indicating this is the primary sourcing lane — isolates primary vs. backup lane performance."
    - name: "is_active"
      expr: is_active
      comment: "Flag indicating the lane is currently active — filters live lanes from decommissioned or planned lanes."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk tier assigned to the lane — enables risk-stratified network analysis and contingency planning."
    - name: "network_lane_status"
      expr: network_lane_status
      comment: "Current operational status of the network lane — used to monitor lane availability and disruption."
    - name: "sourcing_priority"
      expr: sourcing_priority
      comment: "Sourcing priority of the lane — used to analyse whether high-priority lanes are delivering better performance."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated lane effective start date — enables analysis of network evolution over time."
  measures:
    - name: "avg_standard_lead_time_days"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE))
      comment: "Average standard lead time in days across network lanes. Core supply chain KPI — directly impacts safety stock requirements and customer promise dates. Used by network designers to identify long-lead-time lanes for optimisation."
    - name: "avg_transit_time_days"
      expr: AVG(CAST(transit_time_days AS DOUBLE))
      comment: "Average transit time in days across network lanes. Measures physical transport duration — used to benchmark lanes and identify opportunities for lead time reduction."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit transported across network lanes. Financial efficiency KPI — used by logistics and finance to benchmark lane costs and identify cost reduction opportunities."
    - name: "total_lane_cost"
      expr: SUM(CAST(lane_cost AS DOUBLE))
      comment: "Total cost across all network lanes. Aggregate logistics cost KPI — used by supply chain finance to track total network transportation spend."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average OTIF target percentage across network lanes. Measures the service level commitment embedded in lane design — used to assess whether the network is configured to meet customer service requirements."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across network lanes. Complements OTIF target — used to assess the aggregate service ambition of the supply network design."
    - name: "avg_capacity_quantity"
      expr: AVG(CAST(capacity_quantity AS DOUBLE))
      comment: "Average capacity quantity per network lane. Measures throughput capability — used by network planners to identify capacity-constrained lanes that limit supply responsiveness."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across network lanes. Operational constraint KPI — high MOQs on key lanes limit supply flexibility and increase inventory risk."
    - name: "avg_processing_lead_time_days"
      expr: AVG(CAST(processing_lead_time_days AS DOUBLE))
      comment: "Average processing lead time in days. Measures non-transit handling time — used to identify lanes where warehouse or customs processing is adding avoidable lead time."
$$;

CREATE OR REPLACE VIEW `vibe_consumer_goods_v1`.`_metrics`.`supply_sku_planning_param`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level supply planning parameter KPIs for MRP/DRP governance. Used by supply planners and planning managers to monitor planning parameter quality, lead time profiles, and lot sizing policies across the SKU portfolio."
  source: "`vibe_consumer_goods_v1`.`supply`.`sku_planning_param`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU — enables tiered analysis of planning parameter quality aligned to inventory value."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ demand variability classification — contextualises planning parameters against demand predictability."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (e.g. MRP, MPS, consumption-based) — segments KPIs by planning methodology."
    - name: "planning_method"
      expr: planning_method
      comment: "Planning method applied to the SKU (e.g. reorder point, min-max, DRP) — used to benchmark method effectiveness."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g. in-house, external, subcontracting) — segments planning parameters by supply source type."
    - name: "lot_size_method"
      expr: lot_size_method
      comment: "Lot sizing method (e.g. fixed, economic order quantity, lot-for-lot) — used to analyse lot sizing policy coverage and appropriateness."
    - name: "sku_planning_param_status"
      expr: sku_planning_param_status
      comment: "Current status of the SKU planning parameter record — filters active parameters from expired or draft records."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern type associated with the SKU — used to validate that planning methods are appropriate for the demand profile."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month-truncated effective start date — enables time-series analysis of planning parameter changes."
  measures:
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across SKU planning parameters. Strategic KPI — measures the aggregate service ambition embedded in SKU-level planning. Used to assess alignment between planning parameters and commercial commitments."
    - name: "avg_minimum_order_quantity"
      expr: AVG(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Average minimum order quantity across SKU planning parameters. Operational constraint KPI — high MOQs limit supply flexibility and increase inventory risk. Used to identify candidates for MOQ renegotiation."
    - name: "avg_maximum_stock_level_quantity"
      expr: AVG(CAST(maximum_stock_level_quantity AS DOUBLE))
      comment: "Average maximum stock level quantity. Measures the upper inventory bound defined in planning parameters — used to assess whether stock caps are preventing over-investment in slow-moving SKUs."
    - name: "avg_reorder_point_quantity"
      expr: AVG(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Average reorder point quantity across SKU planning parameters. Measures the inventory trigger level for replenishment — used to assess whether reorder points are calibrated to lead times and demand variability."
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across SKU planning parameter records. Governance KPI — low scores indicate parameter records with missing or inconsistent data that may compromise MRP/DRP plan quality."
    - name: "critical_part_count"
      expr: COUNT(CASE WHEN critical_part_flag = TRUE THEN sku_planning_param_id END)
      comment: "Number of SKUs flagged as critical parts. Risk KPI — critical parts require elevated supply chain attention. Used by supply risk managers to size contingency inventory and dual-sourcing programmes."
    - name: "backorder_allowed_sku_count"
      expr: COUNT(CASE WHEN backorder_allowed_flag = TRUE THEN sku_planning_param_id END)
      comment: "Number of SKUs where backorders are permitted. Commercial risk KPI — measures the scale of the portfolio where supply shortfalls will result in backorders rather than lost sales. Used to assess customer service risk exposure."
    - name: "avg_order_multiple_quantity"
      expr: AVG(CAST(order_multiple_quantity AS DOUBLE))
      comment: "Average order multiple quantity across SKU planning parameters. Measures rounding constraints on replenishment orders — large order multiples increase inventory investment and reduce supply flexibility."
$$;