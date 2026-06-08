-- Metric views for domain: supply | Business: Consumer Goods | Version: 1 | Generated on: 2026-05-05 10:59:38

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_atp_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Available-to-Promise (ATP) and Capable-to-Promise (CTP) supply availability metrics. Tracks confirmed supply commitments, backorder exposure, forecast consumption, and in-transit inventory to support order promising and supply risk decisions."
  source: "`consumer_goods_ecm`.`supply`.`atp_record`"
  dimensions:
    - name: "atp_status"
      expr: atp_status
      comment: "Current ATP confirmation status (e.g. Confirmed, Partial, Rejected) — primary filter for supply availability analysis."
    - name: "atp_calculation_method"
      expr: atp_calculation_method
      comment: "Method used to calculate ATP (e.g. Discrete, Cumulative, CTP) — used to segment supply availability by planning logic."
    - name: "customer_priority_tier"
      expr: customer_priority_tier
      comment: "Customer priority tier assigned to the ATP record — enables allocation analysis by customer importance."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields on the ATP record."
    - name: "product_allocation_group"
      expr: product_allocation_group
      comment: "Product allocation group — used to segment ATP availability across product families or allocation pools."
    - name: "atp_date"
      expr: DATE_TRUNC('month', atp_date)
      comment: "ATP confirmation date truncated to month — enables time-series trending of supply availability."
    - name: "source_system"
      expr: source_system
      comment: "Source system originating the ATP record — useful for reconciliation and data lineage analysis."
  measures:
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total confirmed Available-to-Promise quantity across all records. Core supply availability KPI used in order promising and allocation decisions."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total Capable-to-Promise quantity, reflecting supply that can be committed based on planned production capacity. Drives manufacturing and procurement escalation decisions."
    - name: "total_cumulative_atp_quantity"
      expr: SUM(CAST(cumulative_atp_quantity AS DOUBLE))
      comment: "Cumulative ATP quantity rolled forward across the planning horizon. Used to assess sustained supply availability over time."
    - name: "total_backorder_quantity"
      expr: SUM(CAST(backorder_quantity AS DOUBLE))
      comment: "Total quantity in backorder status — a direct indicator of unmet demand and customer service risk."
    - name: "total_allocated_quantity"
      expr: SUM(CAST(allocated_quantity AS DOUBLE))
      comment: "Total quantity already allocated to customer orders or demand pegs — measures committed supply consumption."
    - name: "total_intransit_quantity"
      expr: SUM(CAST(intransit_quantity AS DOUBLE))
      comment: "Total quantity currently in transit toward the supply node — represents near-term supply pipeline visibility."
    - name: "total_planned_receipt_quantity"
      expr: SUM(CAST(planned_receipt_quantity AS DOUBLE))
      comment: "Total planned inbound supply receipts — used to project future ATP availability and validate supply plans."
    - name: "total_forecast_consumption_quantity"
      expr: SUM(CAST(forecast_consumption_quantity AS DOUBLE))
      comment: "Total forecast demand consumed against ATP — measures how much of the supply plan is being absorbed by demand signals."
    - name: "backorder_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(backorder_quantity AS DOUBLE)) / NULLIF(SUM(CAST(atp_quantity AS DOUBLE) + CAST(backorder_quantity AS DOUBLE)), 0), 2)
      comment: "Backorder quantity as a percentage of total demand (ATP + backorder). A rising backorder rate signals supply shortfalls requiring executive intervention."
    - name: "atp_fulfillment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(atp_quantity AS DOUBLE)) / NULLIF(SUM(CAST(atp_quantity AS DOUBLE) + CAST(backorder_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of total demand that can be confirmed via ATP. Core service-level KPI for supply planning and customer commitment reviews."
    - name: "avg_atp_quantity_per_record"
      expr: AVG(CAST(atp_quantity AS DOUBLE))
      comment: "Average ATP quantity per planning record — used to benchmark supply availability depth across SKUs, nodes, and periods."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with ATP records — measures breadth of supply availability coverage across the product portfolio."
    - name: "distinct_supply_node_count"
      expr: COUNT(DISTINCT supply_network_node_id)
      comment: "Number of distinct supply network nodes with active ATP records — indicates geographic and network coverage of supply availability."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_consensus_demand`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Consensus demand planning metrics capturing the agreed-upon demand signal after commercial, statistical, and marketing overlays. Supports S&OP review, forecast accuracy tracking, and demand risk assessment."
  source: "`consumer_goods_ecm`.`supply`.`consensus_demand`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the consensus demand record (e.g. Approved, Pending, Rejected) — used to filter to committed demand signals."
    - name: "demand_category"
      expr: demand_category
      comment: "Category of demand (e.g. Base, Promotional, New Product) — enables decomposition of demand drivers in S&OP reviews."
    - name: "confidence_level"
      expr: confidence_level
      comment: "Planner-assigned confidence level for the consensus forecast — used to weight and risk-adjust demand signals."
    - name: "planning_horizon_type"
      expr: planning_horizon_type
      comment: "Horizon type (e.g. Short-term, Mid-term, Long-term) — segments demand metrics by planning time fence."
    - name: "bias_indicator"
      expr: bias_indicator
      comment: "Indicates systematic forecast bias direction (Over/Under) — critical for identifying structural forecast quality issues."
    - name: "constrained_flag"
      expr: constrained_flag
      comment: "Boolean flag indicating whether the consensus demand is supply-constrained — used to quantify demand at risk."
    - name: "promotion_flag"
      expr: promotion_flag
      comment: "Boolean flag indicating promotional demand — enables separation of baseline vs. promotional volume in demand analysis."
    - name: "last_review_date"
      expr: DATE_TRUNC('month', last_review_date)
      comment: "Month of last demand review — used to track S&OP cadence and identify stale demand records."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields on the consensus demand record."
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total agreed consensus demand quantity — the primary demand signal used to drive supply planning, procurement, and production scheduling."
    - name: "total_statistical_forecast_quantity"
      expr: SUM(CAST(statistical_forecast_quantity AS DOUBLE))
      comment: "Total statistical baseline forecast quantity — the model-generated demand signal before human overlays. Compared against consensus to measure overlay impact."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial overlay applied on top of the statistical forecast — quantifies the business judgment adjustment to the demand plan."
    - name: "total_marketing_event_uplift_quantity"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total demand uplift attributed to marketing events — used to evaluate marketing ROI and event-driven supply requirements."
    - name: "total_new_product_launch_quantity"
      expr: SUM(CAST(new_product_launch_quantity AS DOUBLE))
      comment: "Total demand volume attributed to new product launches — critical for NPD supply readiness and launch risk assessment."
    - name: "total_unconstrained_demand_quantity"
      expr: SUM(CAST(unconstrained_demand_quantity AS DOUBLE))
      comment: "Total unconstrained demand quantity before supply limitations are applied — measures true market demand potential."
    - name: "total_customer_commitment_quantity"
      expr: SUM(CAST(customer_commitment_quantity AS DOUBLE))
      comment: "Total quantity committed to customers — represents firm demand obligations that must be fulfilled to protect service levels."
    - name: "avg_forecast_accuracy_previous_period"
      expr: AVG(CAST(forecast_accuracy_previous_period AS DOUBLE))
      comment: "Average forecast accuracy from the prior planning period — the primary KPI for demand planning quality and process improvement."
    - name: "avg_demand_volatility_index"
      expr: AVG(CAST(demand_volatility_index AS DOUBLE))
      comment: "Average demand volatility index across consensus records — high volatility signals increased safety stock and supply buffer requirements."
    - name: "avg_variance_to_statistical_pct"
      expr: AVG(CAST(variance_to_statistical AS DOUBLE))
      comment: "Average variance between consensus and statistical forecast — measures the magnitude of human override on the demand plan."
    - name: "avg_seasonality_factor"
      expr: AVG(CAST(seasonality_factor AS DOUBLE))
      comment: "Average seasonality factor applied to demand records — used to validate seasonal planning assumptions in S&OP reviews."
    - name: "constrained_demand_quantity"
      expr: SUM(CASE WHEN constrained_flag = TRUE THEN CAST(consensus_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total consensus demand quantity that is supply-constrained — directly measures demand at risk due to supply limitations."
    - name: "unconstrained_vs_consensus_gap"
      expr: SUM(CAST(unconstrained_demand_quantity AS DOUBLE) - CAST(consensus_quantity AS DOUBLE))
      comment: "Gap between unconstrained demand and consensus quantity — quantifies total demand being left unserved due to supply or commercial constraints."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active consensus demand records — measures demand planning portfolio coverage."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_demand_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand plan version metrics supporting S&OP governance, forecast quality tracking, and demand plan lifecycle management. Enables comparison of plan versions, overlay analysis, and risk identification."
  source: "`consumer_goods_ecm`.`supply`.`demand_plan`"
  dimensions:
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the demand plan version (e.g. Draft, Approved, Locked) — used to filter to committed plan versions."
    - name: "version_type"
      expr: version_type
      comment: "Type of demand plan version (e.g. Statistical, Consensus, Budget) — enables comparison across plan types."
    - name: "lifecycle_stage"
      expr: lifecycle_stage
      comment: "Lifecycle stage of the demand plan (e.g. Active, Archived, Superseded) — used to filter to current planning horizon."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern classification (e.g. Seasonal, Trend, Intermittent) — used to segment forecast quality by demand behavior."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category assigned to the demand plan record — enables risk-weighted demand analysis."
    - name: "risk_flag"
      expr: risk_flag
      comment: "Boolean flag indicating the demand plan record carries elevated risk — used to surface at-risk demand in S&OP reviews."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (e.g. Week, Month, Quarter) — segments demand metrics by planning granularity."
    - name: "is_consensus_version"
      expr: is_consensus_version
      comment: "Boolean flag indicating this is the official consensus version of the demand plan — used to isolate the governing demand signal."
    - name: "effective_from_date"
      expr: DATE_TRUNC('month', effective_from_date)
      comment: "Effective start month of the demand plan — used for time-series analysis of plan evolution."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for financial demand plan values — required for multi-currency demand value analysis."
  measures:
    - name: "total_consensus_quantity"
      expr: SUM(CAST(consensus_quantity AS DOUBLE))
      comment: "Total consensus demand quantity across all plan records — the primary volume signal driving supply, procurement, and production planning."
    - name: "total_statistical_baseline_quantity"
      expr: SUM(CAST(statistical_baseline_quantity AS DOUBLE))
      comment: "Total statistical baseline demand quantity — the model-generated signal before any human or commercial overlays."
    - name: "total_promotional_overlay_quantity"
      expr: SUM(CAST(promotional_overlay_quantity AS DOUBLE))
      comment: "Total promotional volume overlay applied to the demand plan — quantifies the supply impact of trade and consumer promotions."
    - name: "total_commercial_overlay_quantity"
      expr: SUM(CAST(commercial_overlay_quantity AS DOUBLE))
      comment: "Total commercial overlay applied to the statistical baseline — measures the magnitude of business judgment adjustments."
    - name: "total_npd_launch_volume_quantity"
      expr: SUM(CAST(npd_launch_volume_quantity AS DOUBLE))
      comment: "Total new product development launch volume in the demand plan — critical for NPD supply readiness and launch risk management."
    - name: "total_marketing_event_uplift_quantity"
      expr: SUM(CAST(marketing_event_uplift_quantity AS DOUBLE))
      comment: "Total marketing event uplift volume in the demand plan — used to validate marketing-driven supply requirements."
    - name: "total_variance_to_baseline_quantity"
      expr: SUM(CAST(variance_to_baseline_quantity AS DOUBLE))
      comment: "Total variance between consensus and statistical baseline — measures the net human adjustment to the demand plan across the portfolio."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percentage AS DOUBLE))
      comment: "Average forecast accuracy percentage across demand plan records — the headline KPI for demand planning process quality."
    - name: "avg_forecast_bias_pct"
      expr: AVG(CAST(forecast_bias_percentage AS DOUBLE))
      comment: "Average forecast bias percentage — identifies systematic over- or under-forecasting that distorts supply plans and inventory levels."
    - name: "at_risk_demand_quantity"
      expr: SUM(CASE WHEN risk_flag = TRUE THEN CAST(consensus_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total consensus demand quantity flagged as at-risk — directly measures demand volume exposed to supply, commercial, or market risk."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active demand plan records — measures demand planning portfolio coverage."
    - name: "distinct_plan_version_count"
      expr: COUNT(DISTINCT version_name)
      comment: "Number of distinct demand plan versions — used to track S&OP version proliferation and governance discipline."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply plan execution metrics covering planned production, replenishment, inventory projection, and supply risk. Supports integrated supply planning reviews, capacity constraint identification, and supply risk escalation."
  source: "`consumer_goods_ecm`.`supply`.`plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the supply plan record (e.g. Draft, Released, Executed) — used to filter to actionable plan records."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of supply plan (e.g. MPS, MRP, DRP) — segments supply metrics by planning methodology."
    - name: "planning_bucket"
      expr: planning_bucket
      comment: "Planning time bucket (e.g. Week, Month) — segments supply plan metrics by planning granularity."
    - name: "supply_source"
      expr: supply_source
      comment: "Source of supply (e.g. Internal Manufacturing, External Supplier, Transfer) — enables make-vs-buy and sourcing analysis."
    - name: "capacity_constraint_flag"
      expr: capacity_constraint_flag
      comment: "Boolean flag indicating the plan record is capacity-constrained — used to quantify supply at risk due to capacity limitations."
    - name: "material_constraint_flag"
      expr: material_constraint_flag
      comment: "Boolean flag indicating a material constraint on the plan record — used to identify supply risk from material shortages."
    - name: "transportation_constraint_flag"
      expr: transportation_constraint_flag
      comment: "Boolean flag indicating a transportation constraint — used to identify logistics bottlenecks in the supply plan."
    - name: "planned_order_release_date"
      expr: DATE_TRUNC('month', planned_order_release_date)
      comment: "Month of planned order release — used for time-series analysis of supply plan execution timing."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields on the supply plan record."
    - name: "source_system"
      expr: source_system
      comment: "Source planning system (e.g. SAP APO, o9, Kinaxis) — used for system reconciliation and data lineage."
  measures:
    - name: "total_planned_production_quantity"
      expr: SUM(CAST(planned_production_quantity AS DOUBLE))
      comment: "Total planned production quantity across all supply plan records — the primary manufacturing volume KPI for capacity and resource planning."
    - name: "total_planned_replenishment_quantity"
      expr: SUM(CAST(planned_replenishment_quantity AS DOUBLE))
      comment: "Total planned replenishment quantity — measures the volume of supply being transferred or procured to fulfill demand."
    - name: "total_demand_forecast_quantity"
      expr: SUM(CAST(demand_forecast_quantity AS DOUBLE))
      comment: "Total demand forecast quantity driving the supply plan — used to validate supply-demand alignment."
    - name: "total_atp_quantity"
      expr: SUM(CAST(atp_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity from the supply plan — measures confirmed supply availability for order promising."
    - name: "total_ctp_quantity"
      expr: SUM(CAST(ctp_quantity AS DOUBLE))
      comment: "Total Capable-to-Promise quantity from the supply plan — measures supply that can be committed based on planned capacity."
    - name: "total_projected_inventory_balance"
      expr: SUM(CAST(projected_inventory_balance AS DOUBLE))
      comment: "Total projected inventory balance at end of planning period — used to identify over-stock and stock-out risk across the network."
    - name: "total_safety_stock_quantity"
      expr: SUM(CAST(safety_stock_quantity AS DOUBLE))
      comment: "Total safety stock quantity in the supply plan — measures the buffer inventory investment required to achieve target service levels."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across plan records — a composite risk indicator used to prioritize supply risk mitigation actions."
    - name: "supply_demand_coverage_ratio"
      expr: ROUND(SUM(CAST(planned_production_quantity AS DOUBLE) + CAST(planned_replenishment_quantity AS DOUBLE)) / NULLIF(SUM(CAST(demand_forecast_quantity AS DOUBLE)), 0), 4)
      comment: "Ratio of total planned supply (production + replenishment) to total demand forecast — values below 1.0 indicate supply shortfall risk."
    - name: "capacity_constrained_quantity"
      expr: SUM(CASE WHEN capacity_constraint_flag = TRUE THEN CAST(planned_production_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total planned production quantity on capacity-constrained records — measures supply volume at risk from capacity bottlenecks."
    - name: "material_constrained_quantity"
      expr: SUM(CASE WHEN material_constraint_flag = TRUE THEN CAST(planned_replenishment_quantity AS DOUBLE) ELSE 0 END)
      comment: "Total planned replenishment quantity on material-constrained records — measures supply volume at risk from material shortages."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active supply plan records — measures supply planning portfolio coverage."
    - name: "distinct_supply_node_count"
      expr: COUNT(DISTINCT supply_network_node_id)
      comment: "Number of distinct supply network nodes in the plan — measures geographic and network coverage of the supply plan."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_safety_stock`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Safety stock policy and performance metrics. Tracks buffer inventory levels, service level targets, demand and lead time variability, and holding cost exposure to support inventory optimization and supply risk management decisions."
  source: "`consumer_goods_ecm`.`supply`.`safety_stock`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU (A=high value, B=medium, C=low) — primary segmentation for inventory policy prioritization."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification of the SKU by demand variability (X=stable, Y=variable, Z=irregular) — used to set appropriate safety stock policies."
    - name: "demand_classification"
      expr: demand_classification
      comment: "Demand classification (e.g. Fast-moving, Slow-moving, Intermittent) — used to segment safety stock policy by demand behavior."
    - name: "calculation_method"
      expr: calculation_method
      comment: "Safety stock calculation method (e.g. Statistical, Fixed, Days-of-Supply) — used to audit policy consistency across the portfolio."
    - name: "review_status"
      expr: review_status
      comment: "Review status of the safety stock record (e.g. Approved, Pending Review, Overdue) — used to track governance compliance."
    - name: "is_active"
      expr: is_active
      comment: "Boolean flag indicating the safety stock record is currently active — used to filter to live policy records."
    - name: "effective_date"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month the safety stock policy became effective — used for time-series analysis of policy changes."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields on the safety stock record."
  measures:
    - name: "total_approved_safety_stock_units"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE))
      comment: "Total approved safety stock units across all active policies — the primary inventory buffer investment KPI."
    - name: "total_calculated_safety_stock_units"
      expr: SUM(CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Total statistically calculated safety stock units — compared against approved levels to identify policy overrides."
    - name: "safety_stock_override_gap"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE) - CAST(calculated_safety_stock_units AS DOUBLE))
      comment: "Net difference between approved and calculated safety stock — positive values indicate management overrides above statistical recommendations, negative values indicate under-stocking risk."
    - name: "total_holding_cost"
      expr: SUM(CAST(approved_safety_stock_units AS DOUBLE) * CAST(holding_cost_per_unit AS DOUBLE))
      comment: "Total holding cost of approved safety stock inventory — measures the financial cost of the buffer inventory policy."
    - name: "total_stockout_cost_exposure"
      expr: SUM(CAST(stockout_cost_per_unit AS DOUBLE) * CAST(average_daily_demand_units AS DOUBLE))
      comment: "Total daily stockout cost exposure (stockout cost × average daily demand) — quantifies the financial risk of a stockout event across the portfolio."
    - name: "avg_target_service_level_pct"
      expr: AVG(CAST(target_service_level_percent AS DOUBLE))
      comment: "Average target service level percentage across safety stock policies — the headline service commitment KPI for supply planning."
    - name: "avg_forecast_accuracy_pct"
      expr: AVG(CAST(forecast_accuracy_percent AS DOUBLE))
      comment: "Average forecast accuracy percentage used in safety stock calculations — lower accuracy drives higher safety stock requirements."
    - name: "avg_demand_variability_coefficient"
      expr: AVG(CAST(demand_variability_coefficient AS DOUBLE))
      comment: "Average demand variability coefficient (coefficient of variation) — high values indicate volatile demand requiring larger safety buffers."
    - name: "avg_lead_time_variability_days"
      expr: AVG(CAST(lead_time_variability_days AS DOUBLE))
      comment: "Average lead time variability in days — a key driver of safety stock levels; high variability increases buffer requirements."
    - name: "avg_days_of_supply_target"
      expr: AVG(CAST(days_of_supply_target AS DOUBLE))
      comment: "Average days-of-supply target across safety stock policies — used to benchmark inventory coverage against industry norms."
    - name: "avg_supply_risk_score"
      expr: AVG(CAST(supply_risk_score AS DOUBLE))
      comment: "Average supply risk score across safety stock records — used to prioritize risk mitigation and buffer policy reviews."
    - name: "avg_z_score"
      expr: AVG(CAST(z_score AS DOUBLE))
      comment: "Average Z-score (service level multiplier) used in safety stock calculations — reflects the statistical confidence level of the buffer policy."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active safety stock policies — measures inventory policy coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_replenishment_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply replenishment order execution metrics tracking order fulfillment, receipt performance, cost, and service levels. Supports DRP execution reviews, supplier performance management, and supply chain cost optimization."
  source: "`consumer_goods_ecm`.`supply`.`supply_replenishment_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the replenishment order (e.g. Open, In-Transit, Received, Cancelled) — primary filter for order execution analysis."
    - name: "order_type"
      expr: order_type
      comment: "Type of replenishment order (e.g. Purchase Order, Transfer Order, Production Order) — segments replenishment metrics by supply source type."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation used for the replenishment order (e.g. Road, Air, Sea) — used for logistics cost and lead time analysis."
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code assigned to the replenishment order — used to analyze expedited vs. standard replenishment patterns."
    - name: "safety_stock_trigger_flag"
      expr: safety_stock_trigger_flag
      comment: "Boolean flag indicating the order was triggered by a safety stock breach — measures reactive replenishment frequency."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for order cost amounts — required for multi-currency replenishment cost analysis."
    - name: "planned_receipt_date"
      expr: DATE_TRUNC('month', planned_receipt_date)
      comment: "Planned receipt month — used for time-series analysis of inbound supply pipeline."
    - name: "actual_receipt_date"
      expr: DATE_TRUNC('month', actual_receipt_date)
      comment: "Actual receipt month — used to track receipt performance and identify seasonal delivery patterns."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for all quantity fields on the replenishment order."
  measures:
    - name: "total_requested_quantity"
      expr: SUM(CAST(requested_quantity AS DOUBLE))
      comment: "Total quantity requested across all replenishment orders — measures total supply demand placed on the replenishment network."
    - name: "total_confirmed_quantity"
      expr: SUM(CAST(confirmed_quantity AS DOUBLE))
      comment: "Total quantity confirmed by suppliers or production — measures committed inbound supply."
    - name: "total_shipped_quantity"
      expr: SUM(CAST(shipped_quantity AS DOUBLE))
      comment: "Total quantity shipped — measures supply in transit toward destination nodes."
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity actually received — the primary fulfillment completion KPI for replenishment execution."
    - name: "total_order_cost_amount"
      expr: SUM(CAST(order_cost_amount AS DOUBLE))
      comment: "Total replenishment order cost — the primary supply chain cost KPI for procurement and logistics spend management."
    - name: "total_forecast_demand_quantity"
      expr: SUM(CAST(forecast_demand_quantity AS DOUBLE))
      comment: "Total forecast demand quantity that triggered replenishment orders — used to validate demand-driven replenishment alignment."
    - name: "total_atp_quantity"
      expr: SUM(CAST(available_to_promise_quantity AS DOUBLE))
      comment: "Total Available-to-Promise quantity from replenishment orders — measures confirmed supply availability from the replenishment pipeline."
    - name: "order_fill_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested replenishment quantity actually received — the primary replenishment fulfillment KPI. Values below target indicate supplier or logistics failures."
    - name: "order_confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(confirmed_quantity AS DOUBLE)) / NULLIF(SUM(CAST(requested_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of requested quantity confirmed by the supply source — measures supplier responsiveness and commitment reliability."
    - name: "shipment_to_receipt_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(received_quantity AS DOUBLE)) / NULLIF(SUM(CAST(shipped_quantity AS DOUBLE)), 0), 2)
      comment: "Percentage of shipped quantity successfully received — identifies in-transit losses, damage, or discrepancies."
    - name: "safety_stock_triggered_order_count"
      expr: COUNT(CASE WHEN safety_stock_trigger_flag = TRUE THEN supply_replenishment_order_id END)
      comment: "Number of replenishment orders triggered by safety stock breaches — a high count signals chronic supply shortfalls or under-sized safety buffers."
    - name: "avg_order_cost_per_unit"
      expr: ROUND(SUM(CAST(order_cost_amount AS DOUBLE)) / NULLIF(SUM(CAST(received_quantity AS DOUBLE)), 0), 4)
      comment: "Average replenishment cost per unit received — used to benchmark supply chain efficiency and identify high-cost replenishment lanes."
    - name: "distinct_supplier_count"
      expr: COUNT(DISTINCT supplier_id)
      comment: "Number of distinct suppliers fulfilling replenishment orders — measures supply base breadth and single-source concentration risk."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active replenishment orders — measures replenishment coverage across the product portfolio."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_network_lane`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network lane performance and configuration metrics. Tracks lane capacity, lead times, service level targets, and cost efficiency to support network design, sourcing strategy, and logistics optimization decisions."
  source: "`consumer_goods_ecm`.`supply`.`network_lane`"
  dimensions:
    - name: "lane_type"
      expr: lane_type
      comment: "Type of supply network lane (e.g. Primary, Secondary, Emergency) — used to segment lane performance by strategic role."
    - name: "transportation_mode"
      expr: transportation_mode
      comment: "Mode of transportation for the lane (e.g. Road, Rail, Air, Sea) — used for modal cost and lead time benchmarking."
    - name: "network_lane_status"
      expr: network_lane_status
      comment: "Current status of the network lane (e.g. Active, Inactive, Under Review) — used to filter to operational lanes."
    - name: "is_primary_lane"
      expr: is_primary_lane
      comment: "Boolean flag indicating this is the primary sourcing lane — used to separate primary vs. backup lane performance."
    - name: "sourcing_priority"
      expr: sourcing_priority
      comment: "Sourcing priority assigned to the lane — used to analyze lane utilization relative to strategic sourcing intent."
    - name: "risk_category"
      expr: risk_category
      comment: "Risk category of the network lane — used to identify high-risk lanes requiring mitigation or backup sourcing."
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for lane cost fields — required for multi-currency lane cost analysis."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the network lane became effective — used for time-series analysis of network evolution."
  measures:
    - name: "total_lane_capacity_quantity"
      expr: SUM(CAST(capacity_quantity AS DOUBLE))
      comment: "Total capacity across all active supply network lanes — measures the maximum throughput the supply network can sustain."
    - name: "avg_standard_lead_time_days"
      expr: AVG(CAST(standard_lead_time_days AS DOUBLE))
      comment: "Average standard lead time in days across network lanes — a key supply chain responsiveness KPI used in network design and safety stock calculations."
    - name: "avg_transportation_lead_time_days"
      expr: AVG(CAST(transportation_lead_time_days AS DOUBLE))
      comment: "Average transportation lead time in days — used to benchmark logistics performance and identify slow lanes for optimization."
    - name: "avg_processing_lead_time_days"
      expr: AVG(CAST(processing_lead_time_days AS DOUBLE))
      comment: "Average processing lead time in days — measures the non-transport handling time within the supply lane."
    - name: "avg_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit across network lanes — the primary lane cost efficiency KPI for sourcing and logistics optimization."
    - name: "avg_otif_target_pct"
      expr: AVG(CAST(otif_target_pct AS DOUBLE))
      comment: "Average On-Time-In-Full (OTIF) target percentage across network lanes — the headline service level commitment for supply network performance."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_pct AS DOUBLE))
      comment: "Average service level target percentage across lanes — used to benchmark lane service commitments against actual performance."
    - name: "avg_safety_stock_days"
      expr: AVG(CAST(safety_stock_days AS DOUBLE))
      comment: "Average safety stock days built into network lane parameters — measures the buffer inventory policy embedded in lane design."
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity across lanes — used to assess order batching constraints and their impact on inventory and working capital."
    - name: "active_lane_count"
      expr: COUNT(CASE WHEN is_active = TRUE THEN network_lane_id END)
      comment: "Number of currently active supply network lanes — measures the operational breadth of the supply network."
    - name: "primary_lane_count"
      expr: COUNT(CASE WHEN is_primary_lane = TRUE THEN network_lane_id END)
      comment: "Number of primary supply lanes — used to assess single-source dependency and backup lane coverage across the network."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_network_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Supply network node capacity and configuration metrics. Tracks storage and throughput capacity, node capabilities, and network coverage to support network design, capacity planning, and distribution strategy decisions."
  source: "`consumer_goods_ecm`.`supply`.`network_node`"
  dimensions:
    - name: "node_type"
      expr: node_type
      comment: "Type of supply network node (e.g. DC, Factory, 3PL, Cross-dock) — primary segmentation for network capacity analysis."
    - name: "node_status"
      expr: node_status
      comment: "Current operational status of the node (e.g. Active, Inactive, Under Construction) — used to filter to operational network nodes."
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership type of the node (e.g. Owned, Leased, 3PL) — used to segment capacity by ownership model for cost and risk analysis."
    - name: "temperature_controlled_flag"
      expr: temperature_controlled_flag
      comment: "Boolean flag indicating temperature-controlled storage capability — critical for cold chain product planning."
    - name: "hazmat_certified_flag"
      expr: hazmat_certified_flag
      comment: "Boolean flag indicating hazardous materials certification — used to validate network capability for regulated product flows."
    - name: "cross_dock_enabled_flag"
      expr: cross_dock_enabled_flag
      comment: "Boolean flag indicating cross-docking capability — used to identify nodes that can support flow-through distribution strategies."
    - name: "vmi_enabled_flag"
      expr: vmi_enabled_flag
      comment: "Boolean flag indicating Vendor Managed Inventory capability — used to identify nodes supporting VMI programs."
    - name: "effective_start_date"
      expr: DATE_TRUNC('year', effective_start_date)
      comment: "Year the network node became effective — used for network evolution and capacity expansion analysis."
  measures:
    - name: "total_storage_capacity_units"
      expr: SUM(CAST(storage_capacity_units AS DOUBLE))
      comment: "Total storage capacity across all active supply network nodes — the primary network capacity KPI for distribution and inventory planning."
    - name: "total_throughput_capacity_daily"
      expr: SUM(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Total daily throughput capacity across the supply network — measures the maximum daily volume the network can process."
    - name: "active_node_count"
      expr: COUNT(CASE WHEN node_status = 'Active' THEN network_node_id END)
      comment: "Number of currently active supply network nodes — measures operational network footprint."
    - name: "temperature_controlled_node_count"
      expr: COUNT(CASE WHEN temperature_controlled_flag = TRUE THEN network_node_id END)
      comment: "Number of temperature-controlled nodes in the network — measures cold chain capacity coverage for health, hygiene, and perishable product categories."
    - name: "avg_storage_capacity_per_node"
      expr: AVG(CAST(storage_capacity_units AS DOUBLE))
      comment: "Average storage capacity per network node — used to benchmark node sizing and identify under- or over-capacity nodes."
    - name: "avg_throughput_capacity_per_node"
      expr: AVG(CAST(throughput_capacity_daily AS DOUBLE))
      comment: "Average daily throughput capacity per node — used to identify throughput bottlenecks in the supply network."
    - name: "cross_dock_node_count"
      expr: COUNT(CASE WHEN cross_dock_enabled_flag = TRUE THEN network_node_id END)
      comment: "Number of cross-dock enabled nodes — measures the network's capability to support flow-through distribution and reduce inventory holding."
    - name: "vmi_enabled_node_count"
      expr: COUNT(CASE WHEN vmi_enabled_flag = TRUE THEN network_node_id END)
      comment: "Number of VMI-enabled nodes — measures the scale of vendor-managed inventory programs across the supply network."
$$;

CREATE OR REPLACE VIEW `consumer_goods_ecm`.`_metrics`.`supply_sku_planning_param`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "SKU-level supply planning parameter metrics supporting inventory policy governance, MRP configuration audits, and service level target management. Enables identification of policy gaps, over-stocking risk, and planning parameter quality."
  source: "`consumer_goods_ecm`.`supply`.`sku_planning_param`"
  dimensions:
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification of the SKU — primary segmentation for planning parameter policy analysis."
    - name: "xyz_classification"
      expr: xyz_classification
      comment: "XYZ classification by demand variability — used to validate that planning parameters align with demand behavior."
    - name: "mrp_type"
      expr: mrp_type
      comment: "MRP planning type (e.g. MRP, Reorder Point, Kanban) — used to audit planning methodology consistency across the portfolio."
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type (e.g. External, Internal, Subcontracting) — used to segment planning parameters by supply source type."
    - name: "planning_strategy"
      expr: planning_strategy
      comment: "Planning strategy (e.g. Make-to-Stock, Make-to-Order, Assemble-to-Order) — used to validate supply strategy alignment with demand patterns."
    - name: "demand_pattern_type"
      expr: demand_pattern_type
      comment: "Demand pattern type (e.g. Seasonal, Trend, Intermittent) — used to validate forecast model selection against demand behavior."
    - name: "parameter_status"
      expr: parameter_status
      comment: "Status of the planning parameter record (e.g. Active, Inactive, Under Review) — used to filter to live planning configurations."
    - name: "critical_part_flag"
      expr: critical_part_flag
      comment: "Boolean flag indicating the SKU is a critical part — used to apply elevated service level and safety stock policies."
    - name: "effective_start_date"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month the planning parameter became effective — used for time-series analysis of parameter policy changes."
  measures:
    - name: "total_minimum_order_quantity"
      expr: SUM(CAST(minimum_order_quantity AS DOUBLE))
      comment: "Total minimum order quantity across all SKU planning parameters — measures the aggregate order batching constraint and its working capital impact."
    - name: "total_maximum_stock_level_quantity"
      expr: SUM(CAST(maximum_stock_level_quantity AS DOUBLE))
      comment: "Total maximum stock level quantity across all SKUs — measures the upper bound of planned inventory investment."
    - name: "total_reorder_point_quantity"
      expr: SUM(CAST(reorder_point_quantity AS DOUBLE))
      comment: "Total reorder point quantity across all SKUs — measures the aggregate inventory trigger level for replenishment actions."
    - name: "avg_service_level_target_pct"
      expr: AVG(CAST(service_level_target_percent AS DOUBLE))
      comment: "Average service level target percentage across SKU planning parameters — the headline service commitment KPI for supply planning governance."
    - name: "avg_fixed_lot_size_quantity"
      expr: AVG(CAST(fixed_lot_size_quantity AS DOUBLE))
      comment: "Average fixed lot size quantity — used to benchmark order batching efficiency and identify opportunities to reduce minimum order constraints."
    - name: "avg_order_multiple_quantity"
      expr: AVG(CAST(order_multiple_quantity AS DOUBLE))
      comment: "Average order multiple quantity — measures the rounding constraint applied to replenishment orders and its impact on inventory precision."
    - name: "critical_sku_count"
      expr: COUNT(CASE WHEN critical_part_flag = TRUE THEN sku_planning_param_id END)
      comment: "Number of SKUs flagged as critical parts — measures the size of the high-priority supply portfolio requiring elevated monitoring."
    - name: "distinct_sku_count"
      expr: COUNT(DISTINCT sku_id)
      comment: "Number of distinct SKUs with active planning parameters — measures planning parameter coverage across the product portfolio."
    - name: "backorder_allowed_sku_count"
      expr: COUNT(CASE WHEN backorder_allowed_flag = TRUE THEN sku_planning_param_id END)
      comment: "Number of SKUs where backorders are permitted — measures the scope of backorder policy and its customer service implications."
$$;