-- Schema for Domain: supply | Business: Consumer_Goods | Version: v2_mvm
-- Generated on: 2026-06-24 01:55:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_consumer_goods_v1`.`supply` COMMENT 'Owns end-to-end supply chain planning and orchestration including demand planning, supply planning, inventory optimization, S&OP/IBP processes, DRP execution, safety stock targets, ATP/CTP calculations, supply network design, demand sensing, forecast accuracy tracking, and supply risk management. Integrates with SAP IBP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` (
    `demand_plan_id` BIGINT COMMENT 'Unique identifier for the demand plan record. Primary key representing a specific version-point in the S&OP/IBP cycle for a SKU/location/channel/planning period combination.',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: CPG demand planners apply event-level promotional uplifts (promotional_overlay_quantity, marketing_event_uplift_quantity) to demand plans. This FK enables direct traceability from a demand plan versio',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: Demand plans are produced during S&OP/IBP planning runs. Linking demand_plan to the planning_run that generated it enables run-level demand plan analysis, scenario comparison, and audit traceability. ',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Demand plans feed S&OP financial reconciliation where volume forecasts are converted to revenue by profit center. Consumer goods finance teams require demand plan-to-profit center linkage for integrat',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to sales.retail_store. Business justification: Store-level demand planning is standard in consumer goods for DSD and VMI accounts. Demand plans are built at individual store granularity for promotional events and new product launches. Direct FK to',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU for which demand is being planned.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: Demand plans are generated using SKU-level planning parameters (forecast_model_type, planning_horizon_days, demand_pattern_type). Linking demand_plan to sku_planning_param formalizes this dependency. ',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Demand plans are converted to gross margin forecasts using standard cost in consumer goods S&OP financial reviews. Linking demand plan volumes to standard cost enables automated gross profit planning ',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution location, warehouse, or market geography for which demand is planned.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: REQUIRED: Account‑level demand forecast used in S&OP planning; planners need trade_account context for each demand_plan.',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: CPG demand plans are structured around trade calendar periods (planning_period_start_date, planning_period_end_date). Linking demand_plan to trade_calendar aligns demand planning cycles with promotion',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: S&OP consensus demand planning in CPG requires tracing promotional_overlay_quantity back to the authorizing trade promotion. This link enables promotion-to-plan reconciliation reports and ensures prom',
    `approval_status` STRING COMMENT 'Current approval state of the demand plan version within the S&OP governance workflow.. Valid values are `draft|submitted|under_review|approved|rejected|locked`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was formally approved and locked for supply planning execution.',
    `commercial_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand adjustment quantity applied by field sales teams based on customer intelligence, market conditions, and sales pipeline visibility.',
    `confidence_level` STRING COMMENT 'Planner-assigned confidence rating in the demand forecast based on data quality, market visibility, and forecast stability.. Valid values are `high|medium|low`',
    `consensus_quantity` DECIMAL(18,2) COMMENT 'Agreed demand forecast quantity representing the single demand signal passed to supply planning after S&OP consensus process. This is the authoritative demand plan.',
    `created_by_persona` STRING COMMENT 'Role or persona of the user who created this demand plan version, used for accountability and collaboration tracking.. Valid values are `demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for any monetary values associated with this demand plan (e.g., revenue forecasts).. Valid values are `^[A-Z]{3}$`',
    `demand_pattern_type` STRING COMMENT 'Classification of historical demand behavior pattern used to select appropriate statistical forecasting algorithm.. Valid values are `stable|seasonal|trending|intermittent|lumpy|erratic`',
    `demand_plan_status` STRING COMMENT '',
    `demand_sensing_signal` STRING COMMENT 'Short-term demand trend indicator derived from real-time POS data, shipment data, and market signals to enable rapid forecast adjustments.. Valid values are `increasing|stable|decreasing|volatile`',
    `effective_from_date` DATE COMMENT 'Date from which this demand plan version becomes active and is used for supply planning and ATP calculations.',
    `effective_to_date` DATE COMMENT 'Date until which this demand plan version remains active. Null indicates the version is currently active with no planned expiration.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical forecast accuracy metric for this SKU/location/channel combination, used for forecast quality benchmarking and continuous improvement.',
    `forecast_bias_percentage` DECIMAL(18,2) COMMENT 'Systematic tendency to over-forecast or under-forecast, calculated as average percentage deviation from actual demand.',
    `forecast_quantity` DECIMAL(18,2) COMMENT '',
    `is_consensus_version` BOOLEAN COMMENT 'Flag indicating whether this version represents the official consensus demand plan approved through the S&OP process and used for supply planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this demand plan version was last updated or adjusted.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lifecycle_stage` STRING COMMENT 'Product lifecycle stage classification used to apply appropriate forecasting models and demand shaping strategies.. Valid values are `introduction|growth|maturity|decline|phase_out`',
    `marketing_event_uplift_quantity` DECIMAL(18,2) COMMENT 'Incremental demand quantity expected from planned marketing campaigns, promotions, and brand activation events.',
    `npd_launch_volume_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity for new product launches or product line extensions during the planning period.',
    `planner_notes` STRING COMMENT 'Free-text comments and annotations from demand planners explaining assumptions, adjustments, risks, or special considerations for this forecast.',
    `planning_bucket` STRING COMMENT 'Time granularity of the demand plan (daily, weekly, monthly, quarterly) used for aggregation and reporting.. Valid values are `daily|weekly|monthly|quarterly`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period (week or month) for which demand is forecasted.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period (week or month) for which demand is forecasted.',
    `promotional_overlay_quantity` DECIMAL(18,2) COMMENT 'Demand uplift quantity attributed to trade promotions, price discounts, and retail execution activities.',
    `risk_category` STRING COMMENT 'Classification of the primary risk factor affecting demand plan reliability and supply fulfillment capability.. Valid values are `supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none`',
    `risk_flag` BOOLEAN COMMENT 'Indicator that this demand plan carries elevated supply risk due to capacity constraints, material shortages, or demand volatility.',
    `source_system_record_code` STRING COMMENT 'Original unique identifier of this demand plan record in the source system, used for data lineage and reconciliation.',
    `statistical_baseline_quantity` DECIMAL(18,2) COMMENT 'Unconstrained demand forecast quantity generated by statistical forecasting algorithms before any commercial overlays or adjustments.',
    `unit_of_measure` STRING COMMENT 'Unit in which demand quantities are expressed (each, case, pallet, kilogram, liter, etc.). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `variance_to_baseline_quantity` DECIMAL(18,2) COMMENT 'Difference between consensus quantity and statistical baseline quantity, indicating the net impact of all commercial adjustments and overlays.',
    `version_name` STRING COMMENT 'Human-readable name of the demand plan version (e.g., Statistical Baseline Q1 2024, Consensus Final March 2024).',
    `version_sequence_number` STRING COMMENT 'Sequential version number within the planning cycle, used to track iteration history and version progression.',
    `version_type` STRING COMMENT 'Classification of the demand plan version indicating its stage in the S&OP process. Statistical baseline represents unconstrained forecast; consensus represents agreed demand signal passed to supply planning.. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay`',
    CONSTRAINT pk_demand_plan PRIMARY KEY(`demand_plan_id`)
) COMMENT 'Core master entity representing the demand plan across all versions, stages, and consensus outcomes within the S&OP/IBP cycle for each SKU/location/channel/planning period combination. Each record represents a specific version-point: captures version name, version type (statistical baseline/field sales overlay/marketing-adjusted/consensus/final approved), planning cycle reference, created-by persona, approval status, effective date range, planning bucket (weekly/monthly), statistical baseline quantity, commercial overlay, marketing event uplift, new product launch volume, consensus quantity, variance to statistical baseline, channel disaggregation, promotional overlays, and lifecycle stage. The consensus version represents the single agreed demand signal passed to supply planning. Enables forecast accuracy benchmarking across versions. Sourced from SAP IBP Demand Planning module.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` (
    `forecast_version_id` BIGINT COMMENT 'Unique identifier for the forecast version record. Primary key.',
    `baseline_forecast_version_id` BIGINT COMMENT 'Reference to the parent or baseline forecast version from which this version was derived (e.g., statistical baseline that was then adjusted). Nullable for original baseline versions.',
    `demand_plan_id` BIGINT COMMENT '',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: CPG forecast versions incorporating promotional lifts must be traceable to the specific promotion event. This FK supports post-event forecast accuracy reporting (MAPE by promotion event) and enables d',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: Forecast versions are snapshots created during planning runs (IBP cycles). Linking forecast_version to the planning_run that produced it enables run-level forecast version tracking and scenario analys',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Forecast versions are consumed by finance for revenue planning by profit center during budget and rolling forecast cycles. Consumer goods IBP processes require forecast version traceability to profit ',
    `sku_id` BIGINT COMMENT '',
    `network_node_id` BIGINT COMMENT '',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Key account forecasting is a standard consumer goods process where forecast versions are built per trade account (e.g., Walmart-specific forecast). Supply planners and key account managers jointly rev',
    `trade_calendar_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_calendar. Business justification: CPG forecast versions are aligned to trade calendar planning cycles (planning_horizon_start_date, planning_horizon_end_date). This FK enables forecast version management by trade calendar period, supp',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: forecast_version has promotional_events_included flag indicating trade promotions influenced the forecast. Linking to trade_promotion enables forecast accuracy attribution by trade promotion — a stand',
    `aggregation_level` STRING COMMENT 'The level of aggregation at which this forecast version is maintained: Stock Keeping Unit (SKU) level, product family, brand, category, sales channel, customer account, geographic region, or global total. [ENUM-REF-CANDIDATE: sku|product_family|brand|category|channel|customer|region|global — 8 candidates stripped; promote to reference product]',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approver during the approval process, documenting any conditions, concerns, or guidance related to this forecast version. Nullable if not yet approved or no notes provided.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was approved. Nullable if not yet approved.',
    `archived_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version was archived and moved out of active planning use. Nullable if not yet archived.',
    `bias_percentage` DECIMAL(18,2) COMMENT 'Forecast bias percentage indicating systematic over-forecasting (positive bias) or under-forecasting (negative bias). A value near zero indicates an unbiased forecast. Nullable if not yet calculated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary values associated with this forecast version (e.g., revenue forecasts). Nullable if forecast is purely volume-based.. Valid values are `^[A-Z]{3}$`',
    `demand_sensing_applied` BOOLEAN COMMENT 'Boolean flag indicating whether demand sensing algorithms (short-term forecast adjustments based on real-time Point of Sale (POS) data, shipment data, or other leading indicators) were applied to this forecast version.',
    `effective_from_date` DATE COMMENT 'The date from which this forecast version becomes effective and is used for operational planning, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `effective_to_date` DATE COMMENT 'The date until which this forecast version remains effective. Nullable for open-ended versions that remain active until superseded.',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Calculated forecast accuracy percentage for this version, measured as the percentage of forecasted demand that matched actual demand. Used for benchmarking version performance and continuous improvement. Nullable if accuracy has not yet been calculated.',
    `forecast_source_system` STRING COMMENT 'Name or identifier of the source system or application that generated or contributed to this forecast version (e.g., SAP IBP, TradeEdge, Excel Upload, Salesforce CG Cloud).',
    `forecast_version_status` STRING COMMENT '',
    `is_active_version` BOOLEAN COMMENT 'Boolean flag indicating whether this forecast version is currently active and being used for planning and execution. Only one version per planning cycle should typically be active at a time.',
    `is_consensus_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version represents the consensus forecast agreed upon by cross-functional stakeholders (sales, marketing, supply chain, finance) during the S&OP process.',
    `is_final_approved_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version is the final approved forecast that will be used for operational execution, Material Requirements Planning (MRP), and Distribution Requirements Planning (DRP).',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `mean_absolute_percentage_error` DECIMAL(18,2) COMMENT 'Mean Absolute Percentage Error (MAPE) metric for this forecast version, measuring the average magnitude of forecast errors as a percentage. Lower values indicate better forecast accuracy. Nullable if not yet calculated.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this forecast version record was last modified.',
    `new_product_introduction_included` BOOLEAN COMMENT 'Boolean flag indicating whether New Product Development (NPD) or New Product Introduction (NPI) launches were incorporated into this forecast version.',
    `planning_horizon_end_date` DATE COMMENT 'The last date of the planning period covered by this forecast version (e.g., end of the fiscal quarter or rolling 18-month horizon).',
    `planning_horizon_start_date` DATE COMMENT 'The first date of the planning period covered by this forecast version (e.g., start of the fiscal quarter or month).',
    `promotional_events_included` BOOLEAN COMMENT 'Boolean flag indicating whether trade promotions, marketing campaigns, and promotional events were factored into this forecast version.',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided when this forecast version was rejected during the approval process. Nullable if version was not rejected.',
    `snapshot_date` DATE COMMENT '',
    `source_system_record_code` STRING COMMENT '',
    `statistical_model_applied` STRING COMMENT 'Name or identifier of the statistical forecasting model or algorithm applied to generate or adjust this forecast version (e.g., Exponential Smoothing, ARIMA, Machine Learning Ensemble, Holt-Winters). Nullable if no statistical model was used.',
    `time_bucket` STRING COMMENT 'The time granularity or bucket size used for this forecast version: daily, weekly, monthly, quarterly, or annual periods.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which forecast quantities are expressed (e.g., EA for each, CS for case, KG for kilogram, L for liter). Aligns with GS1 standards.',
    `version_code` STRING COMMENT 'Short alphanumeric code or identifier for the forecast version used in system integrations and reporting (e.g., STAT_BASE, CONS_V1, FINAL_APR).',
    `version_description` STRING COMMENT 'Detailed textual description or notes about this forecast version, including assumptions, adjustments made, special considerations, or rationale for key changes.',
    `version_name` STRING COMMENT 'Human-readable name assigned to this forecast version (e.g., Statistical Baseline Q1 2024, Consensus Forecast March, Final Approved Version).',
    `version_sequence_number` STRING COMMENT 'Sequential number indicating the iteration or revision order of this forecast version within the planning cycle (e.g., 1 for first draft, 2 for first revision, 3 for consensus).',
    `version_status` STRING COMMENT 'Current lifecycle status of the forecast version: draft (under construction), in review (submitted for approval), approved (validated and accepted), rejected (not accepted), archived (historical record), or active (currently in use for planning).. Valid values are `draft|in_review|approved|rejected|archived|active`',
    `version_type` STRING COMMENT 'Classification of the forecast version indicating its role in the planning process: statistical baseline (system-generated), field sales overlay (sales team input), marketing adjusted (marketing promotions incorporated), consensus (collaborative agreement), final approved (executive sign-off), or simulation (what-if scenario).. Valid values are `statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation`',
    CONSTRAINT pk_forecast_version PRIMARY KEY(`forecast_version_id`)
) COMMENT 'Tracks each named version or snapshot of the demand forecast within the IBP/S&OP cycle (e.g., statistical baseline, field sales overlay, marketing-adjusted, consensus, final approved). Captures version name, version type, planning cycle reference, created-by persona, approval status, and effective date range. Enables forecast accuracy benchmarking across versions.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` (
    `inventory_policy_id` BIGINT COMMENT 'Unique identifier for the inventory policy record. Primary key for this entity.',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory policies are owned by specific cost centers; linking enables policy‑related budgeting and compliance audits.',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Inventory policies define service level and stock targets that represent working capital commitments by profit center. Consumer goods finance requires inventory policy linkage to profit center for bra',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) for which this inventory policy is defined.',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory policy targets (safety_stock_target_units, maximum_stock_level_units) are financially justified using standard cost for carrying cost calculations. Consumer goods supply finance uses this li',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution facility, warehouse, or storage location node in the supply network where this policy applies.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: Inventory policies in consumer goods are frequently retailer-mandated (retailer_mandated_target_flag, penalty_clause_indicator, customer_otif_commitment_percent). Supply planners must know which trade',
    `approval_date` DATE COMMENT 'Date when this inventory policy was formally approved and authorized for use in supply planning and execution.',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the policy has been reviewed and approved by authorized supply planning personnel.. Valid values are `not_submitted|pending_review|approved|rejected|revision_required`',
    `approved_by_name` STRING COMMENT 'Name of the supply planning manager or director who approved this inventory policy for operational use.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was first created in the system.',
    `customer_otif_commitment_percent` DECIMAL(18,2) COMMENT 'Specific OTIF performance level committed to a customer or channel, which may differ from internal targets and may be contractually binding.',
    `cycle_stock_target_units` DECIMAL(18,2) COMMENT 'Target cycle stock quantity representing the average inventory held to meet expected demand between replenishments, excluding safety stock.',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand variability (coefficient of variation or standard deviation) used in safety stock calculations.',
    `effective_end_date` DATE COMMENT 'Date on which this inventory policy expires or is superseded. Null indicates an open-ended policy.',
    `effective_from_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT 'Date from which this inventory policy becomes active and applicable for planning and execution.',
    `fill_rate_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of customer demand that should be fulfilled from available inventory without backorders or stockouts.',
    `inventory_policy_status` STRING COMMENT '',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory policy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this inventory policy was last reviewed and validated by the supply planning team.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Standard deviation or variance of replenishment lead time in days, used to account for supply uncertainty in safety stock calculations.',
    `maximum_stock_level_units` DECIMAL(18,2) COMMENT 'Maximum inventory level allowed at this location for this SKU, used to prevent overstocking and manage warehouse capacity constraints.',
    `measurement_window_days` STRING COMMENT 'Time period in days over which service level performance is measured and evaluated against targets (e.g., rolling 30 days, 90 days, quarterly).',
    `minimum_stock_level_units` DECIMAL(18,2) COMMENT 'Minimum inventory level that should be maintained at this location for this SKU, typically aligned with safety stock or regulatory requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of this inventory policy, ensuring policies remain aligned with business conditions.',
    `on_time_delivery_target_percent` DECIMAL(18,2) COMMENT 'Target percentage of orders that should be delivered by the customer-requested or committed delivery date.',
    `otif_composite_target_percent` DECIMAL(18,2) COMMENT 'Composite OTIF (On Time In Full) target percentage representing orders delivered both on time and in full quantity, a critical customer service metric.',
    `penalty_clause_indicator` BOOLEAN COMMENT 'Indicates whether failure to meet the defined service level targets will result in financial penalties, chargebacks, or other contractual consequences.',
    `policy_code` STRING COMMENT 'Business identifier code for the inventory policy, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_notes` STRING COMMENT 'Free-text notes capturing special considerations, exceptions, seasonal adjustments, or business context relevant to this inventory policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the inventory policy indicating its approval and operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|archived — 7 candidates stripped; promote to reference product]',
    `policy_type` STRING COMMENT '',
    `reorder_point` DECIMAL(18,2) COMMENT '',
    `reorder_point_units` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered, calculated as lead time demand plus safety stock.',
    `replenishment_method` STRING COMMENT 'The inventory replenishment strategy applied: MRP (Material Requirements Planning), DRP (Distribution Requirements Planning), VMI (Vendor Managed Inventory), JIT (Just In Time), Kanban, or Fixed Order Quantity.. Valid values are `MRP|DRP|VMI|JIT|kanban|fixed_order_quantity`',
    `retailer_mandated_target_flag` BOOLEAN COMMENT 'Indicates whether the service level targets are mandated by a retail customer as part of their supplier requirements or vendor compliance program.',
    `review_cycle_days` STRING COMMENT 'Frequency in days at which inventory levels are reviewed and replenishment decisions are made for this SKU-location combination.',
    `review_period_days` STRING COMMENT '',
    `safety_stock_calculated_units` DECIMAL(18,2) COMMENT 'System-calculated safety stock quantity based on demand variability, lead time variability, and service level inputs before manual approval or adjustment.',
    `safety_stock_calculation_method` STRING COMMENT 'The methodology used to calculate safety stock: fixed value, forecast error-based, demand variability, lead time variability, combined variability, or service level-driven calculation.. Valid values are `fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven`',
    `safety_stock_days_of_supply` DECIMAL(18,2) COMMENT 'Safety stock expressed as the number of days of average demand coverage, providing a time-based view of inventory buffer.',
    `safety_stock_target_units` DECIMAL(18,2) COMMENT 'Target safety stock quantity in base units of measure, representing the buffer inventory to protect against demand and supply variability.',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage (e.g., 95%, 98%, 99.5%) representing the desired probability of not stocking out during the replenishment lead time.',
    `source_system_record_code` STRING COMMENT '',
    `target_service_level_percentage` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_inventory_policy PRIMARY KEY(`inventory_policy_id`)
) COMMENT 'Master entity defining inventory policy parameters, safety stock calculations, service level commitments, and OTIF targets for each SKU/location node in the supply network. Captures safety stock target and calculated quantities (days of supply, units, calculation method, demand variability, lead time variability, service level input, calculated vs approved SS units, effective date, review status), reorder point, min/max levels, cycle stock target, replenishment method (MRP/DRP/VMI), review cycle, service level targets (fill rate %, on-time delivery %, OTIF composite %), customer/channel-level OTIF commitments, retailer-mandated target flags, penalty clause indicators, and measurement windows. Owned by supply planning; consumed by distribution and manufacturing execution.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` (
    `safety_stock_id` BIGINT COMMENT 'Unique identifier for the safety stock calculation record. Primary key for the safety stock entity.',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safety stock holding costs (holding_cost_per_unit, stockout_cost_per_unit) are charged to cost centers for inventory carrying cost allocation and working capital reporting. Consumer goods finance team',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Safety stock calculations are driven by demand plan inputs (average daily demand, forecast accuracy). Linking safety_stock to the governing demand_plan provides full traceability from demand signal to',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: In CPG, safety stock levels are recalculated and elevated ahead of promotional events to prevent stockouts. This FK allows supply planners to trace safety stock overrides (override_reason_code, overri',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to supply.forecast_version. Business justification: Safety stock calculations reference a specific forecast version for demand variability inputs. Linking to forecast_version enables audit traceability — which forecast snapshot drove the safety stock c',
    `inventory_policy_id` BIGINT COMMENT '',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: Safety stock records are computed outputs of planning runs (IBP/S&OP cycles). Linking safety_stock to the planning_run that produced it enables run-level analysis and reprocessing. calculation_timesta',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Safety stock investment is tracked by profit center for brand/channel working capital management. Consumer goods CFOs report safety stock value by profit center in monthly financial reviews; this link',
    `sku_id` BIGINT COMMENT 'Reference to the specific product SKU for which safety stock is calculated. Links to the product master data.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: Safety stock calculations use SKU-level planning parameters (safety_stock_method, lead_time_days, lot_size_rule). Linking safety_stock to sku_planning_param formalizes this dependency and avoids dupli',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Safety stock financial valuation uses standard cost per unit to compute total inventory investment and holding cost. Consumer goods S&OP and working capital reports require linking safety stock quanti',
    `network_node_id` BIGINT COMMENT 'Reference to the storage location, distribution center, or facility where the safety stock applies. Links to distribution facility master data.',
    `abc_classification` STRING COMMENT 'The ABC classification of the SKU based on revenue contribution or volume. A items are high-value requiring tight control; B items are moderate; C items are low-value. Influences service level targets and safety stock investment decisions.. Valid values are `A|B|C`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was approved by the planner. Marks the transition from calculated to approved state in the workflow.',
    `approved_safety_stock_units` DECIMAL(18,2) COMMENT 'The final approved safety stock quantity in base units of measure after planner review and adjustment. This is the target value used for inventory policy execution and Available to Promise (ATP) calculations.',
    `average_daily_demand_units` DECIMAL(18,2) COMMENT 'The mean daily demand quantity in base units of measure. Used as input to safety stock calculations and represents expected consumption rate.',
    `average_lead_time_days` DECIMAL(18,2) COMMENT 'The mean replenishment lead time in days from order placement to receipt. Used in safety stock calculations to determine the exposure period for demand and supply variability.',
    `calculated_safety_stock_units` DECIMAL(18,2) COMMENT 'The system-calculated safety stock quantity in base units of measure. This is the raw output from the calculation engine before any manual adjustments or approvals.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the safety stock quantity. Statistical methods use demand and lead time variability; days-of-supply uses fixed coverage targets; manual override represents planner judgment; service level and lead time methods focus on specific risk factors; hybrid combines multiple approaches.. Valid values are `statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock calculation was executed by the planning system. Provides audit trail for calculation runs and version control.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating the quality of the data record',
    `days_of_supply` DECIMAL(18,2) COMMENT '',
    `days_of_supply_target` DECIMAL(18,2) COMMENT 'The target safety stock coverage expressed in days of average demand. Used when calculation method is days-of-supply based. Represents the buffer duration to protect against stockouts.',
    `demand_classification` STRING COMMENT 'The demand pattern category for this SKU-location. Steady indicates consistent demand; seasonal shows periodic peaks; erratic has high variability; lumpy has infrequent large orders; intermittent has sporadic demand; obsolete indicates phase-out. Influences calculation method selection.. Valid values are `steady|seasonal|erratic|lumpy|intermittent|obsolete`',
    `demand_variability_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of demand volatility expressed as coefficient of variation or standard deviation. Used in statistical safety stock calculations to quantify demand uncertainty.',
    `effective_date` DATE COMMENT 'The date when this safety stock target becomes active and is used for inventory policy execution, Distribution Requirements Planning (DRP), and Available to Promise (ATP) calculations.',
    `expiration_date` DATE COMMENT 'The date when this safety stock target expires and is replaced by a new calculation. Used to manage the lifecycle of safety stock policies and trigger recalculation cycles.',
    `forecast_accuracy_percent` DECIMAL(18,2) COMMENT 'The historical forecast accuracy for this SKU-location combination expressed as a percentage. Used to adjust safety stock calculations based on forecasting reliability. Lower accuracy typically requires higher safety stock.',
    `holding_cost_per_unit` DECIMAL(18,2) COMMENT 'The annual cost to hold one unit of inventory including warehousing, insurance, obsolescence, and capital cost. Used in inventory optimization to balance service level against carrying cost. Expressed in local currency.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this safety stock record is currently active and being used for inventory policy execution. True means active; False means superseded or inactive.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The date and time when the safety stock record was last reviewed by a planner, regardless of whether changes were made. Used to track planner engagement and ensure regular review cycles.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lead_time_variability_days` DECIMAL(18,2) COMMENT 'Measure of supply lead time uncertainty expressed in days. Represents the standard deviation or range of lead time fluctuation used in safety stock calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity constraint from the supplier or manufacturing process. Safety stock calculations must consider MOQ to ensure replenishment orders are feasible.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this safety stock record was last modified. Updated whenever any field changes. Supports change tracking and audit requirements.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next safety stock review cycle. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) processes to ensure regular policy updates.',
    `order_multiple` DECIMAL(18,2) COMMENT 'The order quantity increment or lot size multiple required by supplier or production constraints. Safety stock and reorder quantities must align with this multiple.',
    `override_notes` STRING COMMENT 'Free-text explanation provided by the planner when manually overriding the calculated safety stock. Documents the business context and rationale for the adjustment.',
    `override_reason_code` STRING COMMENT 'The business reason code when approved safety stock differs from calculated safety stock. Captures planner judgment factors such as promotional events, seasonal peaks, supply chain risks, new product introductions, product phase-outs, or quality concerns.. Valid values are `promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue`',
    `planning_period_end_date` DATE COMMENT 'The end date of the planning period for which this safety stock calculation is effective. Defines the validity window for the safety stock target.',
    `planning_period_start_date` DATE COMMENT 'The start date of the planning period for which this safety stock calculation is effective. Used in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP) cycles.',
    `quantity` DECIMAL(18,2) COMMENT '',
    `record_source` STRING COMMENT 'Source system or process that created this record',
    `review_status` STRING COMMENT 'The approval workflow status of the safety stock calculation. Pending review indicates awaiting planner action; approved means active for execution; rejected requires recalculation; under revision is being adjusted; expired indicates the planning period has passed.. Valid values are `pending_review|approved|rejected|under_revision|expired`',
    `safety_stock_status` STRING COMMENT '',
    `shelf_life_days` STRING COMMENT 'The shelf life or expiration period of the product in days. Critical for Fast-Moving Consumer Goods (FMCG) and Consumer Packaged Goods (CPG) safety stock decisions to prevent obsolescence. Influences maximum safety stock levels and First Expired First Out (FEFO) policies.',
    `source_system_record_code` STRING COMMENT '',
    `stockout_cost_per_unit` DECIMAL(18,2) COMMENT 'The estimated cost of a stockout per unit including lost sales, expediting costs, customer dissatisfaction, and brand impact. Used in service level optimization to quantify the cost of Out of Stock (OOS) events. Expressed in local currency.',
    `supply_risk_score` DECIMAL(18,2) COMMENT 'A quantitative risk score assessing supply chain vulnerability for this SKU-location. Higher scores indicate greater risk from supplier reliability, geopolitical factors, transportation disruptions, or single-source dependencies. Used to adjust safety stock buffers.',
    `target_service_level_percent` DECIMAL(18,2) COMMENT 'The desired in-stock probability or fill rate target expressed as a percentage (e.g., 95.00, 98.50). Drives the safety stock buffer size to achieve the specified On Shelf Availability (OSA) or Service Level Agreement (SLA).',
    `unit_of_measure` STRING COMMENT 'The unit of measure for safety stock quantities. EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon. Must align with SKU base unit of measure. [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `xyz_classification` STRING COMMENT 'The XYZ classification based on demand variability. X items have low variability (predictable); Y items have moderate variability; Z items have high variability (unpredictable). Used alongside ABC to determine safety stock strategy.. Valid values are `X|Y|Z`',
    `z_score` DECIMAL(18,2) COMMENT 'The standard normal distribution value corresponding to the target service level. Used in statistical safety stock formulas to translate service level percentage into buffer quantity.',
    CONSTRAINT pk_safety_stock PRIMARY KEY(`safety_stock_id`)
) COMMENT 'Transactional record capturing the calculated and approved safety stock quantity for each SKU/location/time-period combination. Stores calculation method (statistical, days-of-supply, manual override), demand variability, lead time variability, service level input, calculated SS units, approved SS units, effective date, and review status. Distinct from inventory_policy (policy target) as this captures the actual calculated output.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the supply replenishment order record. Primary key for this entity.',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replenishment orders incur expenses that must be tracked against the responsible cost center for expense reporting and internal charge‑backs.',
    `network_node_id` BIGINT COMMENT 'Identifier of the supply network node to which inventory will be delivered (distribution center, warehouse, or retail location).',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: REQUIRED: Replenishment orders are often generated to satisfy demand generated by a specific promotion event.',
    `network_lane_id` BIGINT COMMENT 'Foreign key linking to supply.network_lane. Business justification: Each supply replenishment order travels along a specific network lane between source and destination nodes. Linking to network_lane provides access to lane-level attributes (lead time, cost, transport',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.planned_order. Business justification: Before production order conversion, supply replenishment demand is pegged to planned orders. This FK enables pre-conversion demand-supply pegging in IBP, supporting supply exception management and rep',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: Supply replenishment orders are generated as outputs of DRP/MRP planning runs. The existing drp_run_timestamp is a timestamp field, not a proper FK. Adding planning_run_id formalizes the relationship ',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the supply network node from which inventory will be shipped (plant, distribution center, or warehouse).',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Supply replenishment orders for make-to-stock SKUs are fulfilled by production orders. This FK enables demand-supply pegging for ATP calculations and supply chain visibility reporting — a standard IBP',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replenishment orders drive inventory investment charged to profit centers for brand/channel P&L reporting. Consumer goods financial controllers track supply chain costs by profit center; this link ena',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In Consumer Goods S&OP-to-procurement execution, a DRP-generated replenishment order is fulfilled by raising a purchase order. This FK enables end-to-end traceability from supply planning to procureme',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: The supply_replenishment_order already has safety_stock_trigger_flag (BOOLEAN) indicating the order was triggered by a safety stock breach. Adding safety_stock_id formalizes which specific safety stoc',
    `sku_id` BIGINT COMMENT 'Identifier of the product SKU being replenished through this order.',
    `sku_planning_param_id` BIGINT COMMENT 'Foreign key linking to supply.sku_planning_param. Business justification: Replenishment orders are generated based on SKU planning parameters (MOQ, lot size, reorder point, lead time). Linking supply_replenishment_order to sku_planning_param formalizes the governing paramet',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Replenishment orders are valued at standard cost for inventory receipt accounting and purchase price variance (PPV) analysis. Consumer goods finance requires this link to compute order_cost_amount var',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: A replenishment order sourced externally ships from a specific supplier site. This FK enables shipment origin tracking, supplier site OTIF performance analysis per replenishment order, and inbound log',
    `trade_promotion_id` BIGINT COMMENT 'Foreign key linking to promotion.trade_promotion. Business justification: supply_replenishment_order already links to promotion_event but not to the parent trade_promotion. CPG trade spend vs. supply cost reconciliation requires linking replenishment orders directly to trad',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order-to-replenish fulfillment process: a customer sales order triggers a supply replenishment order. Supply planners and fulfillment teams trace replenishment back to the originating customer order f',
    `actual_receipt_date` DATE COMMENT 'Actual date the goods were received at the destination location.',
    `actual_ship_date` DATE COMMENT 'Actual date the shipment departed from the source location.',
    `available_to_promise_quantity` DECIMAL(18,2) COMMENT 'ATP quantity at the source location at the time the replenishment order was created, used to validate supply availability.',
    `cancellation_reason` STRING COMMENT 'Reason code or description explaining why the replenishment order was cancelled, if applicable.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU confirmed for shipment by the source location, may differ from requested quantity due to supply constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating the quality of the data record',
    `drp_run_timestamp` TIMESTAMP COMMENT 'Date and time when the DRP execution run that generated this order was executed.',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'Forecasted demand quantity at the destination location that drove the replenishment calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this replenishment order record was last modified in the system.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `order_cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with this replenishment order, including product cost, transportation cost, and handling fees.',
    `order_notes` STRING COMMENT 'Free-text notes or special instructions related to this replenishment order, such as handling requirements or routing constraints.',
    `order_quantity` DECIMAL(18,2) COMMENT '',
    `order_status` STRING COMMENT 'Current execution status of the replenishment order in the supply chain workflow.. Valid values are `draft|open|in_transit|received|cancelled|closed`',
    `order_type` STRING COMMENT 'Classification of the replenishment order lifecycle stage: planned (system-generated recommendation), firmed (manually confirmed but not released), or released (committed for execution).. Valid values are `planned|firmed|released`',
    `planned_receipt_date` DATE COMMENT 'Target date for goods receipt at the destination location, accounting for transit lead time.',
    `planned_ship_date` DATE COMMENT 'Target date for shipment departure from the source location as calculated by the DRP engine.',
    `priority` STRING COMMENT '',
    `priority_code` STRING COMMENT 'Priority classification for order fulfillment, typically driven by stock-out risk, customer service level, or strategic importance.. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU received at the destination location, captured at goods receipt.',
    `record_source` STRING COMMENT 'Source system or process that created this record',
    `replenishment_order_number` STRING COMMENT 'Business-facing unique order number for the replenishment order, used for tracking and reference across systems and communications.. Valid values are `^REP-[0-9]{10}$`',
    `requested_delivery_date` DATE COMMENT '',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of the SKU requested for replenishment as calculated by the DRP engine or demand planner.',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this replenishment order was triggered by inventory falling below safety stock threshold at the destination location.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the SKU shipped from the source location, captured at dispatch.',
    `source_system_record_code` STRING COMMENT '',
    `supply_replenishment_order_status` STRING COMMENT '',
    `transit_lead_time_days` STRING COMMENT 'Planned number of days for goods to travel from source to destination location.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation planned or used for this replenishment shipment.. Valid values are `truck|rail|air|ocean|intermodal`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this order (EA=Each, CS=Case, PL=Pallet, KG=Kilogram, LB=Pound, L=Liter, GAL=Gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|EA|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Supply network replenishment order for inter-node stock transfers driven by DRP/MRP planning. SSOT for network-level supply replenishment. Distinct from inventory.inventory_replenishment_order which is location-level restocking.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` (
    `network_node_id` BIGINT COMMENT 'Primary key for network_node',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Network nodes (plants, DCs) belong to legal entities (company codes) for intercompany transfer pricing, statutory reporting, and tax compliance. In multi-entity consumer goods operations, node-to-comp',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Operating costs of each network node (warehouse, DC) are allocated to a cost center for overhead accounting and performance tracking.',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Distribution nodes and plants are mapped to profit centers for facility-level P&L and cost allocation in consumer goods. Finance teams report DC operating costs, throughput, and inventory by profit ce',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: A supply network node of type supplier maps to a procurement supplier site. This FK enables supplier performance scorecards tied to network nodes, lead time validation, and network design decisions ',
    `supply_network_node_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT 'Primary street address line for the supply network node location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line (suite, building, floor) for the supply network node location. Organizational contact data classified as confidential.',
    `capacity_class` STRING COMMENT 'Classification of the supply network node storage and throughput capacity used in IBP supply planning for capacity-constrained optimization.. Valid values are `small|medium|large|extra_large|mega`',
    `city` STRING COMMENT 'City where the supply network node is located. Used for geographic analysis and transportation planning. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was first created in the system. Used for audit trail and data lineage.',
    `cross_dock_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports cross-docking operations (direct transfer without storage). Used in transportation and distribution planning.',
    `dsd_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node supports Direct Store Delivery operations. Used in distribution planning and route optimization.',
    `effective_end_date` DATE COMMENT 'Date when this supply network node was decommissioned or removed from the active supply network. Null for currently active nodes.',
    `effective_start_date` DATE COMMENT 'Date when this supply network node became operational and active in the supply network. Used for historical network analysis and planning.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the physical location of the supply network node for EDI transactions and supply chain visibility.. Valid values are `^[0-9]{13}$`',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether this supply network node is certified to handle and store hazardous materials. Used for product allocation and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network node record was last updated. Used for change tracking and data synchronization.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from this supply network node to downstream nodes or customers. Used in DRP execution and ATP/CTP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supply network node in decimal degrees. Used for transportation optimization and network design analytics.',
    `network_node_status` STRING COMMENT '',
    `node_code` STRING COMMENT 'Business identifier code for the supply network node used across planning and execution systems. Typically a short alphanumeric code used in SAP IBP and ERP systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `node_name` STRING COMMENT 'Human-readable name of the supply network node (e.g., Chicago Regional DC, Memphis Manufacturing Plant, Dallas Forward DC).',
    `node_status` STRING COMMENT 'Current operational status of the supply network node in the supply planning system. Active nodes participate in DRP and IBP planning runs.. Valid values are `active|inactive|planned|decommissioned|temporarily_closed`',
    `node_type` STRING COMMENT 'Classification of the supply network node indicating its role in the supply chain (manufacturing plant, regional distribution center, forward distribution center, co-manufacturer, third-party logistics warehouse, cross-dock facility, or supplier location). [ENUM-REF-CANDIDATE: manufacturing_plant|regional_dc|forward_dc|co_manufacturer|3pl_warehouse|cross_dock|supplier_location — 7 candidates stripped; promote to reference product]',
    `operational_status` STRING COMMENT '',
    `ownership_type` STRING COMMENT 'Ownership model of the supply network node (company-owned, leased, third-party logistics managed, co-manufacturer, or contract facility). Used for cost allocation and strategic network design.. Valid values are `owned|leased|3pl_managed|co_manufacturer|contract`',
    `planning_group` STRING COMMENT 'Planning group or cluster assignment for the supply network node used in IBP and S&OP processes to aggregate nodes for planning purposes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supply network node location. Used for logistics routing and delivery planning. Organizational contact data classified as confidential.',
    `replenishment_frequency` STRING COMMENT 'Standard replenishment frequency for inventory at this supply network node. Used in DRP planning and inventory policy definition.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `safety_stock_days` STRING COMMENT 'Target safety stock coverage in days of supply maintained at this network node. Used in inventory optimization and S&OP planning.',
    `source_system_record_code` STRING COMMENT '',
    `sourcing_priority` STRING COMMENT 'Priority ranking of this supply network node in sourcing rules and allocation logic (lower number = higher priority). Used in IBP supply planning and ATP/CTP allocation.',
    `state_province` STRING COMMENT 'State or province code where the supply network node is located. Used for tax jurisdiction and regulatory compliance. Organizational contact data classified as confidential.',
    `storage_capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the supply network node measured in standard storage units (pallets, cases, or cubic meters). Used for inventory optimization and DRP planning.',
    `storage_capacity_uom` STRING COMMENT 'Unit of measure for the storage capacity (pallets, cases, cubic meters, square meters). Aligns with WMS and IBP planning units.. Valid values are `pallets|cases|cubic_meters|square_meters`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node has temperature-controlled storage capabilities for temperature-sensitive products. Used in product allocation and quality management.',
    `throughput_capacity_daily` DECIMAL(18,2) COMMENT 'Maximum daily throughput capacity of the supply network node measured in standard units (cases, pallets, or production units per day). Used for production and distribution planning.',
    `throughput_capacity_uom` STRING COMMENT 'Unit of measure for the daily throughput capacity. Used in production scheduling and distribution planning.. Valid values are `cases_per_day|pallets_per_day|units_per_day|tons_per_day`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supply network node location (e.g., America/Chicago, America/New_York). Used for scheduling and ATP/CTP calculations.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this supply network node participates in Vendor Managed Inventory programs. Used in collaborative planning and replenishment processes.',
    CONSTRAINT pk_network_node PRIMARY KEY(`network_node_id`)
) COMMENT 'Master entity representing each node in the supply network (manufacturing plant, regional DC, forward DC, co-manufacturer, 3PL site). Captures node type, geographic location, capacity class, lead time to downstream nodes, sourcing rules, and active status. Forms the backbone of the supply network design used in IBP supply planning and DRP.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` (
    `network_lane_id` BIGINT COMMENT 'Primary key for network_lane',
    `cost_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transportation lane costs (lane_cost, cost_per_unit) are charged to cost centers for freight cost allocation and logistics budget management. Consumer goods supply chain finance tracks lane-level frei',
    `network_node_id` BIGINT COMMENT 'Identifier of the receiving supply network node (distribution center, warehouse, retail store, or customer location) to which goods are delivered.',
    `destination_network_node_id` BIGINT COMMENT '',
    `origin_network_node_id` BIGINT COMMENT '',
    `primary_supply_network_node_id` BIGINT COMMENT 'Identifier of the originating supply network node (plant, distribution center, warehouse, or external supplier) from which goods are sourced.',
    `profit_center_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intercompany network lanes require profit center assignment for transfer pricing compliance and intercompany freight cost allocation. Consumer goods companies with multi-entity distribution networks m',
    `sku_id` BIGINT COMMENT '',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: A network lane defines a sourcing route from a supplier site to a DC. This FK enables lane-level supplier performance tracking, lead time validation against contract SLAs, and sourcing strategy analys',
    `capacity_quantity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of this lane per planning period (day, week, month), representing the upper limit of goods that can be moved. Used by Supply Planning and Sales and Operations Planning (S&OP) for capacity-constrained optimization.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity quantity field, indicating how lane capacity is measured and constrained. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    `compliance_requirements` STRING COMMENT 'Regulatory or business compliance requirements applicable to this lane, such as temperature control (Good Manufacturing Practice - GMP), hazardous materials handling (Environmental Protection Agency - EPA), or cross-border customs (Food and Drug Administration - FDA).',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard transportation or transfer cost per unit of measure for moving goods along this lane. Used for supply chain cost modeling and total landed cost calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was first created in the system, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and pricing on this lane (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this supply network lane ceases or will cease to be effective. Null for lanes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this supply network lane becomes or became effective and available for use in planning and execution systems.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is currently active and available for use in supply planning and replenishment. True if active; false if temporarily or permanently disabled.',
    `is_primary_lane` BOOLEAN COMMENT 'Boolean flag indicating whether this lane is the primary (preferred) sourcing route for the destination. True if this is the default lane used under normal conditions; false for backup or secondary lanes.',
    `lane_code` STRING COMMENT 'Business identifier for the supply network lane, typically a concatenation or encoded representation of source-destination pair used in planning systems and operational communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `lane_cost` DECIMAL(18,2) COMMENT '',
    `lane_name` STRING COMMENT 'Human-readable descriptive name for the supply network lane, often including source and destination location names for easy identification in reports and dashboards.',
    `lane_type` STRING COMMENT 'Classification of the supply network lane based on the nature of the sourcing relationship: production (from manufacturing plant), transfer (between internal facilities), external procurement (from supplier), direct shipment (plant to customer), cross-dock (no storage), or drop-ship (supplier to customer).. Valid values are `production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship`',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this supply network lane record, used for audit trail and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply network lane record was most recently updated, following ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard batch or lot size for replenishment orders on this lane. Orders are typically rounded to multiples of this quantity for operational efficiency (e.g., full pallet, full truckload).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or shipped on this lane in a single replenishment cycle, constrained by capacity, vehicle limits, or storage restrictions.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or shipped on this lane to meet operational or economic constraints. Used by DRP to ensure replenishment orders meet minimum thresholds.',
    `network_lane_status` STRING COMMENT 'Current lifecycle status of the supply network lane: active (operational), inactive (temporarily disabled), suspended (on hold), planned (future activation), or decommissioned (permanently closed).. Valid values are `active|inactive|suspended|planned|decommissioned`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or contextual information about this supply network lane.',
    `otif_target_pct` DECIMAL(18,2) COMMENT 'Specific target percentage for On Time In Full delivery performance on this lane, a key supply chain Key Performance Indicator (KPI) measuring the percentage of orders delivered on time and complete.',
    `planning_group` STRING COMMENT 'Organizational grouping or planning segment to which this lane belongs, used for segmented planning and reporting in Sales and Operations Planning (S&OP) and Integrated Business Planning (IBP).',
    `processing_lead_time_days` DECIMAL(18,2) COMMENT 'Time in days required for order processing, picking, packing, and loading at the source location before shipment begins.',
    `risk_category` STRING COMMENT 'Supply risk classification for this lane based on factors such as lead time variability, carrier reliability, geopolitical risk, and single-source dependency. Used for supply risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `safety_stock_days` DECIMAL(18,2) COMMENT 'Number of days of safety stock coverage recommended at the destination to buffer against variability in this lanes lead time and demand. Used by Inventory Optimization to calculate safety stock targets.',
    `service_level_target_pct` DECIMAL(18,2) COMMENT 'Target service level percentage for on-time and in-full delivery performance on this lane, expressed as a percentage (e.g., 95.00 for 95%). Used to measure On Time In Full (OTIF) performance.',
    `source_system_record_code` STRING COMMENT '',
    `sourcing_priority` STRING COMMENT 'Numeric ranking indicating the preference order for this lane when multiple sourcing options exist for the same destination. Lower numbers indicate higher priority (1 = primary, 2 = secondary, etc.). Used by Distribution Requirements Planning (DRP) and Integrated Business Planning (IBP) to determine replenishment routing.',
    `standard_lead_time_days` DECIMAL(18,2) COMMENT 'Total planned lead time in days from order placement to goods receipt at destination, including processing time, transportation time, and buffer. Used by Material Requirements Planning (MRP) and Distribution Requirements Planning (DRP) for replenishment calculations.',
    `transit_time_days` DECIMAL(18,2) COMMENT '',
    `transport_mode` STRING COMMENT '',
    `transportation_lead_time_days` DECIMAL(18,2) COMMENT 'Transit time in days for goods to move from source to destination, excluding processing and handling time. Component of the total standard lead time.',
    `transportation_mode` STRING COMMENT 'Primary method of transportation used for moving goods along this lane: truck (road freight), rail (train), ocean (sea freight), air (air cargo), intermodal (combination), or parcel (small package delivery).. Valid values are `truck|rail|ocean|air|intermodal|parcel`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this lane: EA (each), CS (case), PL (pallet), TU (truck unit), KG (kilogram), LB (pound), L (liter), GAL (gallon). Aligns with GS1 standards. [ENUM-REF-CANDIDATE: EA|CS|PL|TU|KG|LB|L|GAL — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_network_lane PRIMARY KEY(`network_lane_id`)
) COMMENT 'Master entity defining the sourcing lane between two supply network nodes (source-destination pair). Captures lane type (production, transfer, external procurement), primary/secondary sourcing priority, standard lead time, transportation lead time, minimum order quantity (MOQ), lot size, and active status. Used by DRP and IBP to determine replenishment routing.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` (
    `atp_record_id` BIGINT COMMENT 'Primary key for atp_record',
    `batch_release_id` BIGINT COMMENT 'Foreign key linking to quality.batch_release. Business justification: Quality-Gated ATP Calculation: ATP commitments in Consumer_Goods must exclude unreleased batches. The batch_release status directly gates whether on-hand inventory is available for promise. Supply pla',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: ATP records consume demand plan quantities (forecast_consumption_quantity on atp_record). The existing demand_pegging_reference is a STRING reference code, not a proper FK. Adding demand_plan_id forma',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: Promotional ATP reservation is a standard CPG process where available-to-promise quantities are checked and allocated against specific promotion events. This FK enables direct attribution of ATP commi',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to supply.forecast_version. Business justification: ATP calculations consume forecast quantities from a specific forecast version. Linking atp_record to forecast_version provides traceability of which forecast snapshot drove the ATP calculation. foreca',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Quality Hold Impact on ATP: ATP records must reflect quarantined inventory separately from released stock. Linking to the active inspection_lot allows ATP calculations to segregate restricted quantiti',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: ATP check is performed against a specific customer order during order promising. The atp_record stores the result of that check. Linking to the sales order enables order-promising accuracy reporting a',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.planned_order. Business justification: ATP records include planned receipt quantities from planned orders. This FK enables ATP-to-planned-order pegging for future supply visibility, supporting customer order promising and supply risk asses',
    `planning_run_id` BIGINT COMMENT 'Foreign key linking to supply.planning_run. Business justification: ATP/CTP records are computed outputs of planning runs. planning_version on atp_record is a STRING label, not a proper FK. Adding planning_run_id links each ATP record to the planning run that computed',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: ATP records track supply from production orders via production_order_quantity (denormalized). This FK replaces that with a proper production order reference, enabling ATP-to-production pegging for ava',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: ATP records peg available supply to confirmed purchase orders for external supply. This FK enables direct ATP-to-PO pegging for supply confirmation reporting, customer promise accuracy, and procuremen',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to supply.supply_replenishment_order. Business justification: ATP records peg available supply to specific replenishment orders (supply_pegging_reference STRING exists). Adding supply_replenishment_order_id formalizes supply pegging, enabling ATP-to-replenishmen',
    `safety_stock_id` BIGINT COMMENT 'Foreign key linking to supply.safety_stock. Business justification: ATP records include safety_stock_quantity as a deduction from available inventory. Linking atp_record to the governing safety_stock record formalizes which safety stock target is being applied in the ',
    `sku_id` BIGINT COMMENT 'Reference to the SKU for which ATP is calculated.',
    `network_node_id` BIGINT COMMENT 'Reference to the distribution facility or warehouse location where ATP is calculated.',
    `trade_account_id` BIGINT COMMENT 'Foreign key linking to sales.trade_account. Business justification: ATP allocation by customer priority is a core consumer goods process (customer_priority_tier on atp_record confirms this). Direct FK to trade_account enables customer-level ATP allocation queries and ',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity already committed or reserved for existing sales orders, reducing available ATP.',
    `atp_calculation_method` STRING COMMENT 'The method used to calculate ATP. Simple ATP considers only on-hand inventory minus allocations. Cumulative ATP includes planned receipts over time. Multi-level ATP considers BOM components. Product allocation ATP applies allocation rules across customer segments.. Valid values are `simple|cumulative|multi_level|product_allocation`',
    `atp_check_horizon_days` STRING COMMENT 'The number of days into the future that the ATP check considers for availability. Defines the planning horizon for promise calculations.',
    `atp_confirmation_number` STRING COMMENT 'Unique confirmation number generated when ATP is reserved for a sales order, providing traceability between ATP records and order promising.',
    `atp_date` DATE COMMENT 'The date for which ATP quantity is calculated. Represents the promise date for order fulfillment.',
    `atp_quantity` DECIMAL(18,2) COMMENT 'The confirmed quantity available to promise to customers for the given SKU, location, and date. Represents uncommitted inventory available for new orders.',
    `atp_record_status` STRING COMMENT '',
    `atp_status` STRING COMMENT 'The current status of the ATP record. Available indicates positive ATP. Constrained indicates limited availability. Blocked indicates ATP is not available for promising. Expired indicates the ATP date has passed.. Valid values are `available|constrained|blocked|expired`',
    `available_quantity` DECIMAL(18,2) COMMENT '',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'The quantity of unfulfilled demand from previous periods that impacts current ATP availability.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this ATP record was calculated. Critical for understanding data freshness and order promising accuracy.',
    `commitment_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was first created in the lakehouse silver layer.',
    `ctp_quantity` DECIMAL(18,2) COMMENT 'The quantity that can be promised considering both current inventory and planned production or supply receipts. Extends ATP by including future supply.',
    `cumulative_atp_quantity` DECIMAL(18,2) COMMENT 'The cumulative ATP quantity calculated across multiple time periods, showing total available quantity from current date through the ATP date.',
    `customer_priority_tier` STRING COMMENT 'The priority tier of the customer or channel for which ATP is being calculated, used in allocation scenarios where high-priority customers receive preferential ATP.. Valid values are `tier_1|tier_2|tier_3|standard`',
    `demand_pegging_reference` STRING COMMENT 'Reference identifier linking ATP consumption to specific demand sources such as sales orders, forecasts, or customer reservations.',
    `expiration_date` DATE COMMENT 'The expiration date of the inventory lot or batch, relevant for FEFO (First Expired First Out) ATP logic in consumer goods with shelf life constraints.',
    `forecast_consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of forecast demand consumed by actual sales orders, used in ATP calculations to avoid double-counting demand.',
    `intransit_quantity` DECIMAL(18,2) COMMENT 'The quantity currently in transit to the location that will contribute to ATP upon arrival.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `minimum_shelf_life_days` STRING COMMENT 'The minimum remaining shelf life in days required for the product to be available for promising, ensuring customers receive products with adequate shelf life.',
    `on_hand_inventory` DECIMAL(18,2) COMMENT 'The physical inventory quantity available at the location at the time of ATP calculation.',
    `planned_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity expected to be received from production orders, purchase orders, or transfers by the ATP date.',
    `planning_version` STRING COMMENT 'The planning scenario or version identifier in SAP IBP under which this ATP calculation was performed, enabling what-if analysis and scenario planning.',
    `product_allocation_group` STRING COMMENT 'The allocation group or priority segment assigned to this ATP calculation, used when ATP is allocated across customer tiers or channels.',
    `production_order_quantity` DECIMAL(18,2) COMMENT 'The quantity scheduled for production that will be available by the ATP date.',
    `purchase_order_quantity` DECIMAL(18,2) COMMENT 'The quantity on open purchase orders expected to be received by the ATP date.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'The minimum inventory buffer maintained to protect against demand variability and supply uncertainty. May reduce ATP if policy enforces safety stock protection.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this ATP record in the source operational system, enabling traceability and reconciliation.',
    `supply_pegging_reference` STRING COMMENT 'Reference identifier linking ATP availability to specific supply sources such as production orders, purchase orders, or stock transfers.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantity fields in this record. Common values: EA (each), CS (case), PL (pallet), KG (kilogram), LB (pound), L (liter), GAL (gallon). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|L|GAL — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATP record was last updated in the lakehouse silver layer.',
    CONSTRAINT pk_atp_record PRIMARY KEY(`atp_record_id`)
) COMMENT 'Transactional record capturing the Available-to-Promise (ATP) and Capable-to-Promise (CTP) calculation results for each SKU/location/date combination. Stores confirmed ATP quantity, CTP quantity, cumulative ATP, demand pegging reference, supply pegging reference, calculation timestamp, and ATP method (simple, cumulative, multi-level). Consumed by sales order management for order promising.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` (
    `sku_planning_param_id` BIGINT COMMENT 'Unique identifier for the SKU planning parameter record. Primary key for this entity.',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: SKU planning parameters (lead time, MOQ, procurement type) are governed by the approved supplier list. This FK enables planners to validate planning parameters against current ASL status and supports ',
    `inventory_policy_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_policy. Business justification: SKU planning parameters are governed by inventory policies (service level targets, safety stock methods, replenishment methods). Linking sku_planning_param to inventory_policy formalizes the policy-to',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Supply planners must know which BOM version drives component availability and lead time assumptions in planning parameters. This FK links sku_planning_param to the active manufacturing BOM, enabling B',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing plant or production facility where this SKU is produced or sourced. Used for plant-specific planning parameters.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_packaging_spec. Business justification: FEFO inventory planning requires sku_planning_param fields (shelf_life_days, minimum_remaining_shelf_life_days) to be sourced from the authoritative packaging spec. Supply planners configuring FEFO/FI',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: Routing defines production lead times and operation sequences that directly populate planned_delivery_time_days and lead_time_days in sku_planning_param. This FK enables automatic lead time updates wh',
    `sku_id` BIGINT COMMENT 'Reference to the SKU in the product master. Links planning parameters to the specific product variant being planned.',
    `standard_cost_id` DECIMAL(18,2) COMMENT 'Foreign key linking to finance.standard_cost. Business justification: SKU planning parameters include inventory_valuation_method and lot sizing rules that are financially calibrated using standard cost. Consumer goods supply planners use standard cost to set financially',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: sku_planning_param needs to be associated with the network node it applies to; added new FK supply_network_node_id referencing network_node.supply_network_node_id.',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on revenue contribution or consumption value. A items are high-value requiring tight control, C items are low-value with relaxed control.. Valid values are `A|B|C`',
    `backorder_allowed_flag` BOOLEAN COMMENT 'Indicates whether backorders are permitted for this SKU when inventory is insufficient. True allows demand to be backordered, false requires immediate fulfillment or cancellation.',
    `coverage_profile_days` STRING COMMENT 'Target days of supply to maintain in inventory. Represents desired inventory coverage horizon based on demand forecast and replenishment frequency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was first created in the system. Supports audit trail and data lineage tracking.',
    `critical_part_flag` BOOLEAN COMMENT 'Indicates whether this SKU is classified as a critical part requiring special planning attention. Critical parts may have higher service levels or expedited replenishment.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating the quality of the data record',
    `demand_pattern_type` STRING COMMENT 'Characterization of the SKUs historical demand pattern. Determines appropriate forecasting method and safety stock calculation approach.. Valid values are `steady|seasonal|trending|intermittent|lumpy|erratic`',
    `effective_end_date` DATE COMMENT 'Date after which these planning parameters are no longer active. Null indicates parameters are currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which these planning parameters become active and are used by planning systems. Supports time-phased parameter changes.',
    `fixed_lot_size_quantity` DECIMAL(18,2) COMMENT 'Fixed production or procurement lot size quantity when using fixed lot size method. Represents standard batch size for manufacturing or ordering.',
    `forecast_model_type` STRING COMMENT 'Statistical or machine learning model used for demand forecasting. Determines the algorithm applied during forecast generation in IBP or demand planning systems.. Valid values are `moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus`',
    `goods_receipt_processing_time_days` STRING COMMENT 'Time required for quality inspection and goods receipt processing after physical delivery. Adds to total replenishment lead time.',
    `inventory_valuation_method` STRING COMMENT 'Method used for inventory valuation and consumption. FIFO (First In First Out), FEFO (First Expired First Out), LIFO (Last In First Out), or weighted average costing.. Valid values are `fifo|fefo|lifo|weighted_average|standard_cost`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this planning parameter record was last updated. Tracks most recent change for change management and audit purposes.',
    `last_review_date` DATE COMMENT 'Date when planning parameters were last reviewed and validated by the planning team. Supports periodic parameter maintenance and accuracy audits.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `lot_size_method` STRING COMMENT 'Method used to calculate production or procurement lot sizes. Determines how order quantities are calculated in MRP and supply planning runs.. Valid values are `fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size`',
    `lot_size_rule` STRING COMMENT '',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered or produced in a single transaction. Limited by production capacity, storage constraints, or supplier capabilities.',
    `maximum_stock_level_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level target for this SKU. Used in min-max planning to cap inventory investment and prevent overstock situations.',
    `min_order_quantity` DECIMAL(18,2) COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered or produced in a single transaction. Enforced by supplier contracts or manufacturing constraints.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at time of shipment to customer or retail delivery. Ensures product quality and retailer acceptance.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this SKU. Used for workload assignment and exception management routing.',
    `mrp_type` STRING COMMENT 'MRP procedure that controls how the planning system generates procurement proposals. Determines planning logic and automation level.. Valid values are `mrp|reorder_point|forecast_based|time_phased|no_planning`',
    `next_review_date` DATE COMMENT 'Scheduled date for next planning parameter review. Ensures regular validation of planning assumptions and parameter accuracy.',
    `order_multiple_quantity` DECIMAL(18,2) COMMENT 'Quantity increment in which orders must be placed. All order quantities must be multiples of this value due to packaging or production constraints.',
    `parameter_notes` STRING COMMENT 'Free-text notes documenting special planning considerations, parameter rationale, or exceptions for this SKU. Provides context for planning decisions.',
    `parameter_status` STRING COMMENT 'Current lifecycle status of the planning parameter record. Active parameters are used in planning runs, inactive parameters are ignored.. Valid values are `active|inactive|pending_approval|obsolete`',
    `planned_delivery_time_days` STRING COMMENT 'Standard lead time in days from order placement to goods receipt. Used for MRP scheduling and supply plan timing calculations.',
    `planning_group` STRING COMMENT 'IBP planning group assignment for demand and supply planning segmentation. Groups SKUs with similar planning characteristics for collaborative planning processes.',
    `planning_horizon_days` STRING COMMENT 'Number of days into the future for which demand and supply planning is performed. Defines the forward-looking planning window for this SKU.',
    `planning_method` STRING COMMENT '',
    `planning_strategy` STRING COMMENT 'Manufacturing planning strategy that determines how the SKU is planned and produced. Make-to-stock produces to forecast, make-to-order produces against customer orders.. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly`',
    `planning_time_fence_days` STRING COMMENT 'Number of days within which the planning system cannot automatically change planned orders without planner approval. Protects near-term production schedule stability.',
    `procurement_type` STRING COMMENT 'Indicates whether the SKU is externally procured from suppliers, produced in-house, or both. Determines supply planning logic and sourcing strategy.. Valid values are `external_procurement|in_house_production|both|subcontracting`',
    `record_source` STRING COMMENT 'Source system or process that created this record',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order. Calculated based on lead time demand plus safety stock to prevent stockouts.',
    `rounding_profile_code` STRING COMMENT 'Code defining rounding rules for planned order quantities. Ensures quantities align with packaging units, pallet configurations, or production batch constraints.',
    `safety_stock_method` STRING COMMENT 'Method used to calculate safety stock levels. Fixed quantity uses static buffer, service level based uses demand variability and lead time uncertainty.. Valid values are `fixed_quantity|days_of_supply|dynamic_calculation|service_level_based`',
    `seasonality_profile_code` STRING COMMENT 'Code identifying the seasonality pattern applied to this SKU for demand forecasting. Links to predefined seasonal index curves (e.g., summer peak, holiday spike).',
    `service_level_target_percent` DECIMAL(18,2) COMMENT 'Target service level percentage for this SKU (e.g., 95%, 98%, 99%). Drives safety stock calculation to achieve desired product availability.',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the SKU in days from production date to expiration. Critical for FEFO inventory management and demand planning for perishable goods.',
    `sku_planning_param_status` STRING COMMENT '',
    `source_system_record_code` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all planning quantities (e.g., EA for each, CS for case, KG for kilogram). Standardizes quantity representation across planning processes.',
    `xyz_classification` STRING COMMENT 'XYZ demand variability classification. X items have stable demand, Y items have moderate variability, Z items have highly erratic or sporadic demand patterns.. Valid values are `X|Y|Z`',
    CONSTRAINT pk_sku_planning_param PRIMARY KEY(`sku_planning_param_id`)
) COMMENT 'Master entity storing SKU-level planning parameters used in demand and supply planning calculations. Captures planning horizon, lot size, minimum order quantity (MOQ), shelf life (days), FEFO/FIFO flag, planning strategy (make-to-stock/make-to-order), ABC/XYZ classification, demand pattern type, seasonality index, and IBP planning group assignment. Distinct from product master (owned by product domain) as this captures supply-planning-specific parameters.';

CREATE OR REPLACE TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` (
    `planning_run_id` BIGINT COMMENT 'Primary key for planning_run',
    `event_id` BIGINT COMMENT 'Foreign key linking to promotion.promotion_event. Business justification: CPG supply planning runs are frequently triggered by upcoming promotion events (pre-promotion replenishment planning). This FK allows tracing which promotion event triggered a planning run, enabling p',
    `previous_planning_run_id` BIGINT COMMENT 'Self-referencing FK on planning_run (previous_planning_run_id)',
    `network_node_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score indicating the quality of the data record',
    `data_source` STRING COMMENT 'Origin of the input data used for the planning run.',
    `duration_minutes` STRING COMMENT 'Total elapsed time of the run measured in minutes.',
    `error_message` STRING COMMENT 'Error details captured when the run fails or encounters issues.',
    `last_updated_timestamp` TIMESTAMP COMMENT '',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the planner.',
    `outcome_metric` STRING COMMENT 'Key quantitative metric produced by the run (e.g., total forecast error, service level).',
    `planning_algorithm` STRING COMMENT 'Name or code of the algorithm/model used to generate the plan.',
    `planning_horizon_end` DATE COMMENT 'Last date of the planning horizon covered by the run.',
    `planning_horizon_start` DATE COMMENT 'First date of the planning horizon covered by the run.',
    `planning_run_status` STRING COMMENT 'Current lifecycle state of the planning run.',
    `record_source` STRING COMMENT 'Source system or process that created this record',
    `result_summary` STRING COMMENT 'High‑level textual summary of the planning outcomes.',
    `run_completed_timestamp` TIMESTAMP COMMENT '',
    `run_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run execution finished.',
    `run_name` STRING COMMENT 'Human‑readable name given to the planning run for easy identification.',
    `run_number` STRING COMMENT 'External reference number or code used by business users to identify the run.',
    `run_priority` STRING COMMENT 'Business‑assigned priority level influencing scheduling and resource allocation.',
    `run_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning run execution began.',
    `run_started_timestamp` TIMESTAMP COMMENT '',
    `run_status` STRING COMMENT '',
    `run_type` STRING COMMENT 'Category of planning activity performed in the run (e.g., demand, supply, inventory, S&OP, optimization).',
    `scenario_code` STRING COMMENT 'Code representing the scenario (e.g., baseline, best‑case, worst‑case) used for this run.',
    `source_system_record_code` STRING COMMENT '',
    `success_flag` BOOLEAN COMMENT 'True if the run completed without errors; otherwise False.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the planning run record.',
    `version_number` STRING COMMENT 'Version identifier for the run, useful for tracking iterative improvements.',
    CONSTRAINT pk_planning_run PRIMARY KEY(`planning_run_id`)
) COMMENT 'Master reference table for planning_run. Referenced by planning_run_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_baseline_forecast_version_id` FOREIGN KEY (`baseline_forecast_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ADD CONSTRAINT `fk_supply_forecast_version_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ADD CONSTRAINT `fk_supply_inventory_policy_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ADD CONSTRAINT `fk_supply_safety_stock_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_network_lane_id` FOREIGN KEY (`network_lane_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_lane`(`network_lane_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_sku_planning_param_id` FOREIGN KEY (`sku_planning_param_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`sku_planning_param`(`sku_planning_param_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ADD CONSTRAINT `fk_supply_network_node_supply_network_node_id` FOREIGN KEY (`supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_destination_network_node_id` FOREIGN KEY (`destination_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_origin_network_node_id` FOREIGN KEY (`origin_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ADD CONSTRAINT `fk_supply_network_lane_primary_supply_network_node_id` FOREIGN KEY (`primary_supply_network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_demand_plan_id` FOREIGN KEY (`demand_plan_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_planning_run_id` FOREIGN KEY (`planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_safety_stock_id` FOREIGN KEY (`safety_stock_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`safety_stock`(`safety_stock_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ADD CONSTRAINT `fk_supply_atp_record_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_inventory_policy_id` FOREIGN KEY (`inventory_policy_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`inventory_policy`(`inventory_policy_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ADD CONSTRAINT `fk_supply_sku_planning_param_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_previous_planning_run_id` FOREIGN KEY (`previous_planning_run_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`planning_run`(`planning_run_id`);
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ADD CONSTRAINT `fk_supply_planning_run_network_node_id` FOREIGN KEY (`network_node_id`) REFERENCES `vibe_consumer_goods_v1`.`supply`.`network_node`(`network_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_consumer_goods_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|locked');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `commercial_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Commercial Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `consensus_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consensus Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_business_glossary_term' = 'Created By Persona');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_by_persona` SET TAGS ('dbx_value_regex' = 'demand_planner|sales_manager|marketing_analyst|supply_planner|system_generated');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'stable|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Signal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `demand_sensing_signal` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|volatile');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `forecast_bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|phase_out');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `marketing_event_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Marketing Event Uplift Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `npd_launch_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'New Product Development (NPD) Launch Volume Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `promotional_overlay_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Overlay Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supply_constraint|demand_volatility|new_product_uncertainty|promotional_risk|market_disruption|none');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `statistical_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Statistical Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `variance_to_baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance to Baseline Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`demand_plan` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|promotional_overlay');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `baseline_forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Version Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `trade_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Calendar Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `aggregation_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Aggregation Level');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `bias_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `demand_sensing_applied` SET TAGS ('dbx_business_glossary_term' = 'Demand Sensing Applied Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `forecast_source_system` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_active_version` SET TAGS ('dbx_business_glossary_term' = 'Is Active Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_consensus_version` SET TAGS ('dbx_business_glossary_term' = 'Is Consensus Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `is_final_approved_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Approved Version Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `mean_absolute_percentage_error` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `new_product_introduction_included` SET TAGS ('dbx_business_glossary_term' = 'New Product Introduction (NPI) Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `promotional_events_included` SET TAGS ('dbx_business_glossary_term' = 'Promotional Events Included Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `statistical_model_applied` SET TAGS ('dbx_business_glossary_term' = 'Statistical Model Applied');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_business_glossary_term' = 'Forecast Time Bucket');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `time_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Description');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Version Sequence Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|rejected|archived|active');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`forecast_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'statistical_baseline|field_sales_overlay|marketing_adjusted|consensus|final_approved|simulation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_review|approved|rejected|revision_required');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `customer_otif_commitment_percent` SET TAGS ('dbx_business_glossary_term' = 'Customer OTIF Commitment Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `cycle_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Cycle Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `fill_rate_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `maximum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `measurement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `minimum_stock_level_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `on_time_delivery_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `otif_composite_target_percent` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Composite Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `penalty_clause_indicator` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `reorder_point_units` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'MRP|DRP|VMI|JIT|kanban|fixed_order_quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `retailer_mandated_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Retailer Mandated Target Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculated_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculated Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|forecast_error|demand_variability|lead_time_variability|combined_variability|service_level_driven');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days of Supply');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `safety_stock_target_units` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Target Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`inventory_policy` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Inventory Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Approval Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `approved_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Approved Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_daily_demand_units` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Demand (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculated_safety_stock_units` SET TAGS ('dbx_business_glossary_term' = 'Calculated Safety Stock Quantity (Units)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'statistical|days_of_supply|manual_override|service_level_based|lead_time_based|hybrid');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `days_of_supply_target` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply Target');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_classification` SET TAGS ('dbx_value_regex' = 'steady|seasonal|erratic|lumpy|intermittent|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `demand_variability_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Demand Variability Coefficient');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Effective Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `forecast_accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Inventory Holding Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `holding_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `lead_time_variability_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Variability (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Override Reason Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'promotional_event|seasonal_peak|supply_risk|new_product_launch|phase_out|quality_issue');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Review Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|under_revision|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Product Shelf Life (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Stockout Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `stockout_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `supply_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `target_service_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Service Level Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Demand Variability Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`safety_stock` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score (Standard Normal Deviate)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_ssot_superseded_by' = 'inventory.inventory_replenishment_order');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_ssot_status' = 'duplicate_resolved');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Planning Param Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `trade_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Promotion Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `available_to_promise_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `drp_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Distribution Requirements Planning (DRP) Run Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Cost Amount');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|in_transit|received|cancelled|closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|firmed|released');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planned_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `planned_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ship Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{10}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transit_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_business_glossary_term' = 'Capacity Class');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `capacity_class` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large|mega');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `cross_dock_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Dock Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `dsd_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|temporarily_closed');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|3pl_managed|co_manufacturer|contract');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Units');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `storage_capacity_uom` SET TAGS ('dbx_value_regex' = 'pallets|cases|cubic_meters|square_meters');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Throughput Capacity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `throughput_capacity_uom` SET TAGS ('dbx_value_regex' = 'cases_per_day|pallets_per_day|units_per_day|tons_per_day');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_node` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` SET TAGS ('dbx_subdomain' = 'network_replenishment');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_id` SET TAGS ('dbx_business_glossary_term' = 'Network Lane Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `primary_supply_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capacity Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `capacity_uom` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `is_primary_lane` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Lane Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_business_glossary_term' = 'Lane Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_business_glossary_term' = 'Lane Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_business_glossary_term' = 'Lane Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lane_type` SET TAGS ('dbx_value_regex' = 'production|transfer|external_procurement|direct_shipment|cross_dock|drop_ship');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_business_glossary_term' = 'Lane Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `network_lane_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lane Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `processing_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `safety_stock_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `service_level_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percentage');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Transportation Lead Time (Days)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|intermodal|parcel');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`network_lane` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` SET TAGS ('dbx_subdomain' = 'inventory_management');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_record_id` SET TAGS ('dbx_business_glossary_term' = 'Atp Record Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `batch_release_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Release Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Replenishment Order Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `safety_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `trade_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Account Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|cumulative|multi_level|product_allocation');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_check_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Check Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Confirmation Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_date` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise (ATP) Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `atp_status` SET TAGS ('dbx_value_regex' = 'available|constrained|blocked|expired');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `backorder_quantity` SET TAGS ('dbx_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ATP Calculation Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `ctp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Capable-to-Promise (CTP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `cumulative_atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Available-to-Promise (ATP) Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Priority Tier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `customer_priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|standard');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `demand_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `forecast_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Consumption Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `intransit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `minimum_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `on_hand_inventory` SET TAGS ('dbx_business_glossary_term' = 'On-Hand Inventory Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planned_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipt Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `planning_version` SET TAGS ('dbx_business_glossary_term' = 'Planning Version');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `product_allocation_group` SET TAGS ('dbx_business_glossary_term' = 'Product Allocation Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `production_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `purchase_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `supply_pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Supply Pegging Reference');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`atp_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `sku_planning_param_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Planning Parameter ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Policy Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Packaging Spec Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Network Node Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `backorder_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Backorder Allowed Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `coverage_profile_days` SET TAGS ('dbx_business_glossary_term' = 'Coverage Profile Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `critical_part_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Part Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Pattern Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `demand_pattern_type` SET TAGS ('dbx_value_regex' = 'steady|seasonal|trending|intermittent|lumpy|erratic');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `fixed_lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fixed Lot Size Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `forecast_model_type` SET TAGS ('dbx_value_regex' = 'moving_average|exponential_smoothing|holt_winters|arima|machine_learning|consensus');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `goods_receipt_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Processing Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|weighted_average|standard_cost');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `lot_size_method` SET TAGS ('dbx_value_regex' = 'fixed_lot_size|economic_order_quantity|lot_for_lot|period_order_quantity|weekly_lot_size|monthly_lot_size');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `maximum_stock_level_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'mrp|reorder_point|forecast_based|time_phased|no_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `order_multiple_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_notes` SET TAGS ('dbx_business_glossary_term' = 'Parameter Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|obsolete');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Integrated Business Planning (IBP) Planning Group');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Planning Strategy');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order|planning_without_final_assembly');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `planning_time_fence_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Time Fence Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external_procurement|in_house_production|both|subcontracting');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `rounding_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Rounding Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Calculation Method');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `safety_stock_method` SET TAGS ('dbx_value_regex' = 'fixed_quantity|days_of_supply|dynamic_calculation|service_level_based');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `seasonality_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Profile Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `service_level_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target Percent');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_business_glossary_term' = 'XYZ Classification');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`sku_planning_param` ALTER COLUMN `xyz_classification` SET TAGS ('dbx_value_regex' = 'X|Y|Z');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` SET TAGS ('dbx_subdomain' = 'demand_planning');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Run Identifier');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `previous_planning_run_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Planning Run Id');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `previous_planning_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `outcome_metric` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Planning Algorithm');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `planning_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `result_summary` SET TAGS ('dbx_business_glossary_term' = 'Result Summary');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_business_glossary_term' = 'Run Name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_name` SET TAGS ('dbx_pii_type' = 'person_name');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_priority` SET TAGS ('dbx_business_glossary_term' = 'Run Priority');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Scenario Code');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `success_flag` SET TAGS ('dbx_business_glossary_term' = 'Success Flag');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_consumer_goods_v1`.`supply`.`planning_run` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
