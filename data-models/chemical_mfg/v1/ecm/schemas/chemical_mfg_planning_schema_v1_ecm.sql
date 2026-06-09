-- Schema for Domain: planning | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`planning` COMMENT 'Demand planning, sales and operations planning (S&OP), material requirements planning (MRP), capacity planning, and production scheduling for chemical manufacturing operations. Manages demand forecasts, supply-demand balancing, and capacity allocation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Unique system-generated identifier for each demand forecast version.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer‑specific demand forecast drives sales planning and supply allocation; key accounts require separate forecasts for accurate production scheduling.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: REQUIRED: Demand Forecast reports are generated per chemical product; linking enables product‑level demand planning and variance analysis.',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to planning.forecast_version. Business justification: Each demand forecast belongs to a specific forecast version; linking enables version control and eliminates redundant version fields.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Demand forecasting is performed per functional location; linking ties forecast to the exact plant unit for accurate planning.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Demand Forecasting uses the material master to tie forecast SKUs to the authoritative material record, ensuring accurate planning and regulatory reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: S&OP demand forecast uses high‑value sales opportunities to project future demand, a core process linking sales pipeline to planning.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: New‑product demand forecasts are created based on the R&D project that defines the product launch timeline.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: REQUIRED: SKU‑level forecasts drive packaging and logistics planning; FK ties forecast rows to the definitive SKU master.',
    `prior_demand_forecast_id` BIGINT COMMENT 'Self-referencing FK on demand_forecast (prior_demand_forecast_id)',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Quantity after consensus or manual adjustments.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the forecast was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the forecast.',
    `baseline_quantity` DECIMAL(18,2) COMMENT 'Statistical or algorithmic baseline quantity forecast before adjustments.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the forecast quantity.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the forecast quantity.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Confidence percentage (0‑100) associated with the forecast.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the forecast record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values associated with the forecast.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `demand_source` STRING COMMENT 'Origin of the demand signal used for the forecast.. Valid values are `sales|market|internal|external`',
    `forecast_accuracy` DECIMAL(18,2) COMMENT 'Percentage accuracy of past forecasts compared to actuals.',
    `forecast_category` STRING COMMENT 'High‑level category of what is being forecasted.. Valid values are `product|material|service`',
    `forecast_method` STRING COMMENT 'Method used to generate the forecast quantity.. Valid values are `statistical|machine_learning|consensus|expert`',
    `forecast_name` STRING COMMENT 'Human‑readable name describing the forecast (e.g., "2025 Q3 Demand").',
    `forecast_owner` STRING COMMENT 'Department or team responsible for the forecast.',
    `forecast_period_end` DATE COMMENT 'Last calendar date of the forecasted period.',
    `forecast_period_start` DATE COMMENT 'First calendar date of the forecasted period.',
    `forecast_status` STRING COMMENT 'Current lifecycle state of the forecast.. Valid values are `draft|approved|active|closed|rejected`',
    `forecast_type` STRING COMMENT 'Indicates whether the forecast is for demand or supply.. Valid values are `demand|supply`',
    `forecast_version` STRING COMMENT 'Version identifier for the forecast (e.g., "V1", "V2").',
    `forecast_version_date` DATE COMMENT 'Calendar date when this forecast version was released.',
    `is_final` BOOLEAN COMMENT 'True when the forecast version is the definitive one for planning.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the forecast is locked for further edits.',
    `notes` STRING COMMENT 'Additional comments or rationale for the forecast.',
    `planning_bucket` STRING COMMENT 'Granularity of the forecast (e.g., weekly, monthly).. Valid values are `weekly|monthly|quarterly|yearly`',
    `planning_horizon` STRING COMMENT 'Timeframe the forecast covers relative to the planning window.. Valid values are `short_term|mid_term|long_term`',
    `revision_number` STRING COMMENT 'Sequential revision number for the forecast record.',
    `scenario_name` STRING COMMENT 'Name of the scenario applied to the forecast.. Valid values are `base|optimistic|pessimistic`',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the forecast quantity.. Valid values are `kg|lb|ton|gallon|liter|m3`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the forecast.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the forecast record.',
    `created_by` STRING COMMENT 'User identifier of the person who created the forecast.',
    CONSTRAINT pk_demand_forecast PRIMARY KEY(`demand_forecast_id`)
) COMMENT 'Master demand forecast record capturing statistical and consensus-based demand projections for chemical products and SKUs across planning horizons (short, mid, long-term). Stores forecast version, method (statistical, ML, consensus), baseline quantity, adjusted quantity, forecast accuracy metrics, planning bucket (weekly/monthly), and lifecycle status. Serves as the authoritative SSOT for demand signals feeding S&OP and MRP processes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` (
    `forecast_version_id` BIGINT COMMENT 'Unique system-generated identifier for each forecast version snapshot.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system that created the forecast version.',
    `superseded_forecast_version_id` BIGINT COMMENT 'Self-referencing FK on forecast_version (superseded_forecast_version_id)',
    `approval_status` STRING COMMENT 'Current approval state of the forecast version.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the forecast version was approved.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for the forecast.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for the forecast.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the forecast version record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `demand_source` STRING COMMENT 'Origin of the data used to generate the forecast.. Valid values are `sales_orders|historical|market_intel|customer_forecast`',
    `forecast_accuracy_target` DECIMAL(18,2) COMMENT 'Desired forecast accuracy expressed as a percentage.',
    `forecast_category` STRING COMMENT 'High‑level classification of the forecast purpose.. Valid values are `product_demand|material_requirements|capacity|sales`',
    `forecast_method` STRING COMMENT 'Technique applied to produce the demand forecast.. Valid values are `statistical|machine_learning|manual|hybrid`',
    `forecast_run_date` DATE COMMENT 'Date on which the demand forecast was generated.',
    `forecast_version_description` STRING COMMENT 'Narrative description providing context for the forecast version.',
    `forecast_version_status` STRING COMMENT 'Current lifecycle state of the forecast version.. Valid values are `draft|active|archived|retracted`',
    `is_final_version` BOOLEAN COMMENT 'True if this version is the definitive version for the planning cycle.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that performed the most recent update.',
    `notes` STRING COMMENT 'Additional comments or observations about the forecast version.',
    `planning_horizon_end` DATE COMMENT 'Last day of the planning horizon covered by this forecast version.',
    `planning_horizon_start` DATE COMMENT 'First day of the planning horizon covered by this forecast version.',
    `planning_horizon_type` STRING COMMENT 'Time granularity of the forecast horizon.. Valid values are `daily|weekly|monthly|quarterly`',
    `revision_reason` STRING COMMENT 'Explanation for why a new forecast version was created.',
    `scenario_name` STRING COMMENT 'Descriptive name of the forecasting scenario (e.g., Base, Optimistic, Pessimistic).',
    `total_demand_quantity` DECIMAL(18,2) COMMENT 'Sum of forecasted demand across all items for the planning horizon.',
    `total_demand_value` DECIMAL(18,2) COMMENT 'Monetary value (in the selected currency) of the total forecasted demand.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the forecasted quantity.. Valid values are `kg|lb|ton|gal|L|pcs`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the forecast version record.',
    `version_effective_date` DATE COMMENT 'Date when this forecast version becomes effective for planning purposes.',
    `version_expiration_date` DATE COMMENT 'Date after which the forecast version is no longer valid for planning.',
    `version_number` STRING COMMENT 'Sequential number indicating the version order within a forecast cycle.',
    `created_by` STRING COMMENT 'Identifier of the user or system that initially created the forecast version record.',
    CONSTRAINT pk_forecast_version PRIMARY KEY(`forecast_version_id`)
) COMMENT 'Version-controlled snapshot of a demand forecast cycle, capturing the forecast run date, planning horizon start/end, version number, approval status, and the planner or system that generated it. Enables comparison of forecast versions across S&OP cycles and supports forecast accuracy tracking over time. Each version contains the full set of demand_forecast line records for that planning cycle.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` (
    `sop_cycle_id` BIGINT COMMENT 'Unique system-generated identifier for the S&OP planning cycle.',
    `prior_sop_cycle_id` BIGINT COMMENT 'Self-referencing FK on sop_cycle (prior_sop_cycle_id)',
    `approval_status` STRING COMMENT 'Current approval state of the S&OP cycle.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the executive who approved the cycle.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the cycle received final approval.',
    `capacity_plan_version` STRING COMMENT 'Identifier of the capacity planning version referenced.',
    `compliance_review_flag` BOOLEAN COMMENT 'Indicates whether the cycle has passed regulatory compliance review.',
    `consensus_outcome` STRING COMMENT 'Outcome agreed upon by cross‑functional participants (e.g., demand‑supply alignment).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the S&OP cycle record was first created in the system.',
    `cycle_end_date` DATE COMMENT 'Calendar date on which the S&OP cycle ends.',
    `cycle_name` STRING COMMENT 'Human‑readable name or code for the planning cycle (e.g., "FY2025_Q1_SOP").',
    `cycle_quarter` STRING COMMENT 'Fiscal quarter (1‑4) of the S&OP cycle.',
    `cycle_start_date` DATE COMMENT 'Calendar date on which the S&OP cycle begins.',
    `cycle_year` STRING COMMENT 'Fiscal year to which the S&OP cycle belongs.',
    `decision_summary` STRING COMMENT 'Concise summary of key decisions made during the cycle.',
    `demand_forecast_version` STRING COMMENT 'Identifier of the demand forecast version applied in this cycle.',
    `facilitator_name` STRING COMMENT 'Name of the person responsible for facilitating the S&OP cycle.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the cycle is locked from further edits.',
    `notes` STRING COMMENT 'Free‑form notes captured by participants.',
    `phase` STRING COMMENT 'Current phase of the S&OP cycle (e.g., demand review, supply review).. Valid values are `demand_review|supply_review|pre_sop|executive_sop`',
    `planning_horizon` STRING COMMENT 'Time horizon that the cycle covers for demand and supply planning.. Valid values are `month|quarter|year`',
    `planning_scenario` STRING COMMENT 'Scenario used for the cycles forecasts (e.g., base case).. Valid values are `base|optimistic|pessimistic`',
    `review_period` STRING COMMENT 'Frequency at which the S&OP cycle is reviewed.. Valid values are `weekly|monthly|quarterly`',
    `risk_assessment_status` STRING COMMENT 'Status of the risk assessment performed for the cycle.. Valid values are `not_started|in_progress|completed`',
    `sop_cycle_status` STRING COMMENT 'Lifecycle status of the planning cycle.. Valid values are `draft|in_progress|completed|cancelled`',
    `supply_plan_version` STRING COMMENT 'Identifier of the supply plan version used for this cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the S&OP cycle record.',
    `version_number` STRING COMMENT 'Incremental version of the S&OP cycle record for change tracking.',
    CONSTRAINT pk_sop_cycle PRIMARY KEY(`sop_cycle_id`)
) COMMENT 'Sales and Operations Planning (S&OP) cycle master record representing a formal monthly or quarterly S&OP review cycle. Captures cycle ID, planning period, cycle phase (demand review, supply review, pre-S&OP, executive S&OP), status, facilitator, key decisions, and consensus outcome. Serves as the governance record for the integrated business planning process in chemical manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` (
    `sop_consensus_record_id` BIGINT COMMENT 'Unique identifier for the SOP consensus record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit owning the consensus plan.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the specific product (SKU) covered by the consensus.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant associated with the consensus plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the consensus record.',
    `product_family_id` BIGINT COMMENT 'Identifier of the product family for which the consensus is recorded.',
    `sop_cycle_id` BIGINT COMMENT 'Identifier of the S&OP planning cycle (e.g., Q3‑2026).',
    `tertiary_sop_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the record.',
    `revised_sop_consensus_record_id` BIGINT COMMENT 'Self-referencing FK on sop_consensus_record (revised_sop_consensus_record_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the consensus record was approved.',
    `comments` STRING COMMENT 'Free‑text field for additional notes or remarks.',
    `consensus_plan_number` STRING COMMENT 'Business identifier assigned to the consensus plan for traceability.',
    `constrained_supply_qty` DECIMAL(18,2) COMMENT 'Supply quantity after applying capacity, material, and other constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consensus record was first created in the system.',
    `demand_source` STRING COMMENT 'Origin of the demand forecast used in the consensus.. Valid values are `forecast|order|historical|market`',
    `demand_uom` STRING COMMENT 'Unit of measure for the demand quantity (e.g., kg, L, pcs).',
    `forecast_horizon_weeks` STRING COMMENT 'Number of weeks ahead covered by the consensus forecast.',
    `gap_quantity` DECIMAL(18,2) COMMENT 'Difference between unconstrained demand and constrained supply (demand - supply).',
    `gap_reason` STRING COMMENT 'Primary reason for the demand‑supply gap.. Valid values are `capacity|material|quality|logistics|other`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the product is classified as critical for business continuity.',
    `priority_level` STRING COMMENT 'Business priority assigned to the consensus record.. Valid values are `high|medium|low`',
    `resolution_action` STRING COMMENT 'Planned action to address the identified gap (e.g., overtime, subcontract, inventory draw).',
    `scenario_type` STRING COMMENT 'Scenario classification for the consensus plan.. Valid values are `base|optimistic|pessimistic`',
    `sop_consensus_record_status` STRING COMMENT 'Current lifecycle status of the consensus record.. Valid values are `draft|approved|rejected|in_review`',
    `sop_meeting_timestamp` TIMESTAMP COMMENT 'Date and time when the S&OP meeting that produced the consensus was held.',
    `supply_source` STRING COMMENT 'Primary source of the constrained supply quantity.. Valid values are `inventory|production|procurement`',
    `supply_uom` STRING COMMENT 'Unit of measure for the supply quantity (should match demand UOM).',
    `unconstrained_demand_qty` DECIMAL(18,2) COMMENT 'Forecasted demand quantity without any supply constraints.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consensus record.',
    `version_number` STRING COMMENT 'Sequential version number for the consensus record to support change tracking.',
    CONSTRAINT pk_sop_consensus_record PRIMARY KEY(`sop_consensus_record_id`)
) COMMENT 'Transactional record capturing the consensus demand and supply plan agreed upon during an S&OP cycle review for a specific product family, plant, or business unit. Records unconstrained demand, constrained supply plan, gap quantity, resolution action, and approval sign-off. Provides the authoritative agreed plan that drives production scheduling and procurement.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` (
    `mrp_run_id` BIGINT COMMENT 'Unique identifier for the MRP run execution.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated the MRP run.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: MRP runs calculate material requirements using the specific formula version, ensuring accurate procurement for the intended composition.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the MRP run was executed.',
    `prior_mrp_run_id` BIGINT COMMENT 'Self-referencing FK on mrp_run (prior_mrp_run_id)',
    `batch_number` BIGINT COMMENT 'Identifier of the data processing batch that loaded this MRP run record.',
    `comments` STRING COMMENT 'Free-text comments or notes associated with the MRP run.',
    `is_critical` BOOLEAN COMMENT 'Indicates if the MRP run is marked as critical for production planning.',
    `is_simulation` BOOLEAN COMMENT 'Indicates whether the MRP run was a simulation (true) or a live run (false).',
    `mrp_run_status` STRING COMMENT 'Current processing status of the MRP run.. Valid values are `scheduled|running|completed|failed|cancelled`',
    `planning_date` DATE COMMENT 'The date for which the MRP planning is performed.',
    `planning_horizon_days` STRING COMMENT 'Number of days ahead covered by the MRP planning horizon.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the MRP run record was created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the MRP run record.',
    `run_duration_seconds` STRING COMMENT 'Total execution time of the MRP run in seconds.',
    `run_number` STRING COMMENT 'System-generated sequential identifier for the MRP run.',
    `run_timestamp` TIMESTAMP COMMENT 'Date and time when the MRP run started.',
    `run_type` STRING COMMENT 'Specifies the type of MRP execution: regenerative, net change, or net change within planning horizon.. Valid values are `regenerative|net_change|net_change_horizon`',
    `run_user_name` STRING COMMENT 'Full name of the user who initiated the MRP run.',
    `source_system` STRING COMMENT 'System of origin for the MRP run data.. Valid values are `SAP_PP|Other`',
    `total_exception_messages` STRING COMMENT 'Count of exception messages produced during the MRP run.',
    `total_planned_orders` STRING COMMENT 'Number of production orders generated by the MRP run.',
    `total_planned_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity (in base unit) of all planned material requirements.',
    `total_purchase_requisitions` STRING COMMENT 'Number of purchase requisitions generated by the MRP run.',
    CONSTRAINT pk_mrp_run PRIMARY KEY(`mrp_run_id`)
) COMMENT 'Material Requirements Planning (MRP) run master record capturing each MRP execution event in SAP PP/MRP. Records run ID, run type (regenerative, net change, net change in planning horizon), plant scope, planning date, run status, total planned orders generated, total purchase requisitions generated, and exception message count. Serves as the audit header for all MRP-generated planning elements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`planned_order` (
    `planned_order_id` BIGINT COMMENT 'System-generated unique identifier for the planned order.',
    `material_master_id` BIGINT COMMENT 'Unique system identifier of the material to be produced or procured.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — MRP planned orders convert to purchase orders — without this FK, procurement cannot trace which POs originated from MRP requirements. Blocks MRP-to-procurement traceability.',
    `vendor_id` BIGINT COMMENT 'System identifier of the external vendor for purchase-type planned orders.',
    `pegged_planned_order_id` BIGINT COMMENT 'Self-referencing FK on planned_order (pegged_planned_order_id)',
    `batch_number` STRING COMMENT 'Identifier for the batch to which the planned order belongs, if batch management is used.',
    `conversion_status` STRING COMMENT 'Shows if the planned order has been converted to a production or purchase order, or cancelled.. Valid values are `not_converted|converted|cancelled`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost for the planned order based on standard rates.',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the planned order record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the planned order record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost estimate.. Valid values are `USD|EUR|JPY|GBP|CNY|CHF`',
    `demand_quantity` DECIMAL(18,2) COMMENT 'Quantity of material required by dependent demand (e.g., sales orders).',
    `firming_status` STRING COMMENT 'Indicates whether the planned order has been firmed or released for execution.. Valid values are `not_firmed|firmed|released`',
    `last_changed_by_user` STRING COMMENT 'User identifier of the person who last modified the planned order record.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the planned order record.',
    `lead_time_days` STRING COMMENT 'Planned lead time in days from order creation to receipt or production start.',
    `lot_size` DECIMAL(18,2) COMMENT 'Minimum production or procurement lot size applicable to the material.',
    `mrp_controller` STRING COMMENT 'Identifier of the MRP controller responsible for the planning run.',
    `order_number` STRING COMMENT 'Business-visible identifier assigned to the planned order.',
    `order_status` STRING COMMENT 'Overall lifecycle status of the planned order.. Valid values are `planned|released|firmed|converted|cancelled`',
    `order_type` STRING COMMENT 'Indicates whether the order is for internal production, external purchase, or stock transfer.. Valid values are `production|purchase|stock_transfer`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material planned to be produced or procured.',
    `plant_code` STRING COMMENT 'Identifier of the plant where the planned order will be executed.',
    `priority` STRING COMMENT 'Priority code determining the orders execution precedence.',
    `procurement_type` STRING COMMENT 'Specifies whether the material will be sourced internally, externally, or via consignment.. Valid values are `in_house|external|consignment`',
    `scheduled_finish_date` DATE COMMENT 'Planned completion date for the order execution.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the order execution.',
    `scheduling_status` STRING COMMENT 'Current scheduling state of the planned order.. Valid values are `scheduled|unscheduled|blocked`',
    `source_of_supply` STRING COMMENT 'Code or description of the preferred source for the material.',
    `supply_quantity` DECIMAL(18,2) COMMENT 'Quantity of material already available or scheduled from existing supply.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the planned quantity (e.g., kg, L, pcs).',
    CONSTRAINT pk_planned_order PRIMARY KEY(`planned_order_id`)
) COMMENT 'MRP-generated planned order representing a proposed production or procurement action to cover a material requirement. Captures planned order number, material, plant, order type (planned production order, planned purchase order, stock transfer), planned quantity, scheduled start date, scheduled finish date, firming status, and conversion status. Core planning element in SAP PP/MRP that drives production scheduling and procurement planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` (
    `mrp_exception_id` BIGINT COMMENT 'Unique surrogate key for the MRP exception record.',
    `employee_id` BIGINT COMMENT 'Identifier of the planner assigned to resolve the exception.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material (product) to which the exception applies.',
    `related_mrp_exception_id` BIGINT COMMENT 'Self-referencing FK on mrp_exception (related_mrp_exception_id)',
    `batch_number` STRING COMMENT 'Batch identifier of the material associated with the exception.',
    `cause_code` STRING COMMENT 'Code representing the root cause of the exception (e.g., material shortage, lead time variance).',
    `comments` STRING COMMENT 'Free-text comments added by the planner or system.',
    `cost_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact of the exception.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost impact.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `deviation_days` STRING COMMENT 'Number of days the planned date deviates from the target.',
    `exception_date` DATE COMMENT 'Calendar date of the exception (date part of exception_timestamp).',
    `exception_number` STRING COMMENT 'Business identifier assigned to the exception for tracking.',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was generated by the MRP run.',
    `exception_type` STRING COMMENT 'Category of the MRP exception indicating the nature of the planning anomaly.. Valid values are `reschedule_in|reschedule_out|cancel|new_order|shortage|excess_stock`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the exception is considered critical for production continuity.',
    `is_duplicate` BOOLEAN COMMENT 'Indicates if this exception is a duplicate of another.',
    `last_reviewed_by` STRING COMMENT 'User identifier of the person who last reviewed the exception.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the last review action.',
    `lot_number` STRING COMMENT 'Lot number of the material affected by the exception.',
    `mrp_exception_status` STRING COMMENT 'Current lifecycle status of the exception.. Valid values are `open|in_progress|resolved|closed|rejected`',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where the exception occurred.',
    `priority_level` STRING COMMENT 'Priority assigned to the exception for planning response.. Valid values are `low|medium|high|critical`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material impacted by the exception.',
    `recommended_action` STRING COMMENT 'Suggested corrective action for the planner to address the exception.',
    `resolution_status` STRING COMMENT 'Status of the exception resolution process.. Valid values are `pending|completed|not_applicable`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved.',
    `source_system` STRING COMMENT 'Name of the source system that generated the exception record.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity (e.g., kg, L, ton).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exception record.',
    CONSTRAINT pk_mrp_exception PRIMARY KEY(`mrp_exception_id`)
) COMMENT 'MRP exception message record generated during an MRP run flagging planning anomalies requiring planner action. Captures exception type (reschedule in, reschedule out, cancel, new order, shortage, excess stock), material, plant, exception date, days of deviation, recommended action, planner assignment, and resolution status. Critical for exception-based planning in chemical manufacturing where material lead times and minimum order quantities create complex planning constraints.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique surrogate key for each capacity planning record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capacity planning costs are charged to cost centers; required for Capacity Cost Allocation report.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the capacity plan.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: Capacity planning evaluates equipment load using formula characteristics (viscosity, temperature), so linking to formula provides necessary data.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Capacity allocation is performed per sales territory to align manufacturing capacity with regional sales targets.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center, reactor, or line the capacity plan applies to.',
    `revised_capacity_plan_id` BIGINT COMMENT 'Self-referencing FK on capacity_plan (revised_capacity_plan_id)',
    `available_capacity_hours` DECIMAL(18,2) COMMENT 'Total available production capacity for the work center expressed in hours.',
    `available_capacity_kg` DECIMAL(18,2) COMMENT 'Total available production capacity for the work center expressed in kilograms (or tons).',
    `bottleneck_flag` BOOLEAN COMMENT 'True if the work center is identified as a bottleneck in the planning horizon.',
    `capacity_plan_status` STRING COMMENT 'Current lifecycle status of the capacity plan.. Valid values are `draft|approved|active|closed|rejected`',
    `capacity_source` STRING COMMENT 'Origin of the capacity data (e.g., ERP, manual entry, simulation).',
    `capacity_unit` STRING COMMENT 'Unit of measure used for capacity values in this plan.. Valid values are `hours|kg|tons`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the capacity plan record was created.',
    `last_review_date` DATE COMMENT 'Date when the capacity plan was last reviewed or approved.',
    `leveling_status` STRING COMMENT 'Indicates whether capacity leveling has been performed.. Valid values are `leveled|unleveled|pending`',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the capacity plan.',
    `plan_code` STRING COMMENT 'External or business code used to reference the capacity plan.',
    `plan_name` STRING COMMENT 'Human‑readable name describing the capacity plan.',
    `plan_type` STRING COMMENT 'Classification of the planning methodology (e.g., Rough‑Cut Capacity Planning, Detailed Capacity Requirements Planning).. Valid values are `RCCP|CRP|RoughCut|Detailed`',
    `planning_horizon_end` DATE COMMENT 'Last date of the planning horizon covered by the capacity plan.',
    `planning_horizon_start` DATE COMMENT 'First date of the planning horizon covered by the capacity plan.',
    `planning_scenario` STRING COMMENT 'Scenario used for the capacity plan (e.g., base, optimistic, pessimistic).. Valid values are `base|optimistic|pessimistic`',
    `required_capacity_hours` DECIMAL(18,2) COMMENT 'Aggregated capacity demand from planned orders expressed in hours.',
    `required_capacity_kg` DECIMAL(18,2) COMMENT 'Aggregated capacity demand from planned orders expressed in kilograms (or tons).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the capacity plan record.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Ratio of required to available capacity expressed as a percentage.',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Capacity planning master record defining the available and required capacity for a production work center, reactor, or processing line over a planning horizon. Captures work center, planning period, available capacity (hours/kg/tons), required capacity from planned orders, utilization percentage, bottleneck flag, and capacity leveling status. Supports rough-cut capacity planning (RCCP) and detailed capacity requirements planning (CRP) in chemical plant operations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`production_plan` (
    `production_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the production plan record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the finished chemical product or intermediate being planned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Production Cost Allocation report linking each production plan to the cost center that funds it.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Scale‑up planning uses the exact experimental formulation record to generate batch recipes and cost estimates.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Production scheduling requires the exact formula version to generate batch recipes and ensure traceability of composition for each plan.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Production plans are executed at specific functional locations; FK enables location‑specific capacity and compliance tracking.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Production planning links each plan to the material master for bill‑of‑materials, hazard classification, and traceability.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `primary_production_employee_id` BIGINT COMMENT 'Identifier of the employee responsible for the plan.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for Profit Center performance analysis; production plans contribute to profit center results.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Production scheduling is driven by confirmed sales quotes to ensure committed quantities are manufactured on time.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Production Launch Planning requires the originating R&D project ID to schedule start dates and allocate resources.',
    `superseded_production_plan_id` BIGINT COMMENT 'Self-referencing FK on production_plan (superseded_production_plan_id)',
    `capacity_utilization_target` DECIMAL(18,2) COMMENT 'Target percentage of plant capacity to be utilized by this plan.',
    `comments` STRING COMMENT 'User‑entered notes or remarks about the plan.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated production cost for the planned quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production plan record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost estimate.',
    `demand_source` STRING COMMENT 'Origin of the demand that drives the plan.. Valid values are `forecast|sales_order|manual`',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective for execution.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded (null if open‑ended).',
    `ehs_impact_flag` BOOLEAN COMMENT 'Indicates whether the plan has a material environmental, health, or safety impact.',
    `freeze_horizon_flag` BOOLEAN COMMENT 'Indicates whether the plan is frozen for changes (true) or still editable (false).',
    `lead_time_days` STRING COMMENT 'Planned lead time from order release to finished product availability.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot size for the product.',
    `max_inventory_level` DECIMAL(18,2) COMMENT 'Upper bound of inventory to avoid overstock.',
    `min_inventory_level` DECIMAL(18,2) COMMENT 'Lower bound of inventory that should be maintained.',
    `plan_category` STRING COMMENT 'High‑level category of the plan for reporting and analytics.. Valid values are `MPS|MRP|Capacity|Scheduling`',
    `plan_number` STRING COMMENT 'Business-visible identifier or code for the production plan, used in S&OP and MRP processes.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the plan.. Valid values are `draft|approved|released|closed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the plan (e.g., Master Production Schedule, Material Requirements Planning, Capacity Planning, Scheduling).',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Authorized quantity of product to be produced within the planning horizon.',
    `planning_horizon_end` DATE COMMENT 'Last date of the planning horizon covered by this plan.',
    `planning_horizon_start` DATE COMMENT 'First date of the planning horizon covered by this plan.',
    `planning_period` STRING COMMENT 'Granularity of the plan (e.g., daily, weekly).. Valid values are `daily|weekly|monthly|quarterly|yearly`',
    `production_method` STRING COMMENT 'Process mode used to manufacture the product.. Valid values are `batch|continuous|semi_batch`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the plan complies with all applicable chemical regulations (EPA, REACH, etc.).',
    `safety_stock` DECIMAL(18,2) COMMENT 'Buffer inventory quantity to protect against demand variability.',
    `scheduling_priority` STRING COMMENT 'Priority used by MRP/scheduling engines to allocate capacity.. Valid values are `high|medium|low`',
    `uom` STRING COMMENT 'Unit of measure for the planned quantity.. Valid values are `kg|lb|ton|gal|L|m3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the plan.',
    `version_number` STRING COMMENT 'Incremental version of the plan for change tracking.',
    CONSTRAINT pk_production_plan PRIMARY KEY(`production_plan_id`)
) COMMENT 'Master Production Schedule (MPS) and production plan record defining the authorized production quantities for finished chemical products and key intermediates over a planning horizon. Captures product, plant, planning period, planned production quantity, UOM, production method, scheduling priority, freeze horizon flag, and plan status. Bridges the S&OP consensus plan and detailed MRP/scheduling execution in chemical manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` (
    `supply_plan_id` BIGINT COMMENT 'System-generated unique identifier for the supply plan record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: REQUIRED: Supply plans must be aligned to specific chemical products to balance procurement, production, and regulatory compliance.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supply procurement spend is allocated to cost centers for budgeting and variance analysis.',
    `distributor_id` BIGINT COMMENT 'Foreign key linking to sales.distributor. Business justification: Supply planning incorporates distributor agreements and volume commitments, requiring a link to the distributor entity.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Supply planning of raw materials is based on the formula version of the product to be produced, linking ensures correct material quantities.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the manufacturing plant or site for which the plan is created.',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material or product family covered by the supply plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal party (e.g., planning department or manager) responsible for the plan.',
    `tertiary_supply_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who most recently updated the plan.',
    `superseded_supply_plan_id` BIGINT COMMENT 'Self-referencing FK on supply_plan (superseded_supply_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the supply plan.. Valid values are `approved|pending|rejected`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the plan satisfies all applicable regulatory constraints.',
    `confirmed_supply_quantity` DECIMAL(18,2) COMMENT 'Quantity of supply that has been confirmed (e.g., purchase orders, production orders).',
    `constraint_type` STRING COMMENT 'Primary reason limiting the supply plan (e.g., capacity, material shortage).. Valid values are `capacity|material_shortage|lead_time|quality|regulatory`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost associated with executing the supply plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supply plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for cost_estimate.',
    `demand_source` STRING COMMENT 'Origin of the demand that drives the supply plan.. Valid values are `forecast|sales_order|customer_commitment`',
    `effective_from` DATE COMMENT 'Date when the plan becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded (nullable for open‑ended).',
    `ehs_impact_score` DECIMAL(18,2) COMMENT 'Numeric score reflecting environmental, health, and safety impact of the plan.',
    `last_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the plan was last approved.',
    `lead_time_days` STRING COMMENT 'Average lead time in days required to obtain the supply.',
    `notes` STRING COMMENT 'Free‑form comments or remarks entered by planners.',
    `plan_number` STRING COMMENT 'Human‑readable alphanumeric identifier assigned to the supply plan.',
    `plan_timestamp` TIMESTAMP COMMENT 'Timestamp representing the moment the plan was generated or last refreshed.',
    `plan_type` STRING COMMENT 'Indicates whether the plan is an aggregate (high‑level) or detailed (line‑item) plan.. Valid values are `aggregate|detail`',
    `plan_version` STRING COMMENT 'Version number of the plan, incremented on each revision.',
    `planned_supply_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material expected to be supplied (production, procurement, transfers) during the horizon.',
    `planning_horizon_end_date` DATE COMMENT 'Last date of the planning horizon covered by the supply plan.',
    `planning_horizon_start_date` DATE COMMENT 'First date of the planning horizon covered by the supply plan.',
    `planning_methodology` STRING COMMENT 'Algorithmic approach used to generate the supply plan.. Valid values are `mrp|heuristic|optimization|simulation`',
    `priority` STRING COMMENT 'Business priority assigned to the plan for execution sequencing.. Valid values are `high|medium|low`',
    `revision_reason` STRING COMMENT 'Explanation for why the plan was revised.',
    `supply_gap_quantity` DECIMAL(18,2) COMMENT 'Difference between planned and confirmed supply, indicating shortage.',
    `supply_plan_status` STRING COMMENT 'Current lifecycle status of the supply plan.. Valid values are `draft|approved|released|rejected|pending`',
    `supply_source` STRING COMMENT 'Origin of the supply quantity (e.g., internal production, external procurement).. Valid values are `production|procurement|transfer|stock`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the supply quantities (e.g., kilograms, liters).. Valid values are `kg|l|m3|ton|lb`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the supply plan record.',
    CONSTRAINT pk_supply_plan PRIMARY KEY(`supply_plan_id`)
) COMMENT 'Integrated supply plan record representing the constrained supply response plan for a material or product family across the planning horizon. Captures supply plan ID, material, plant, planning period, planned supply quantity (from production, procurement, and transfers), confirmed supply quantity, supply gap quantity, constraint type, and plan approval status. Serves as the supply-side counterpart to the demand forecast in S&OP balancing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` (
    `inventory_target_id` BIGINT COMMENT 'System-generated unique identifier for each inventory target record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: REQUIRED: Inventory target calculations are performed per chemical product; FK allows accurate safety‑stock and reorder‑point reporting.',
    `compound_registry_id` BIGINT COMMENT 'Foreign key linking to research.compound_registry. Business justification: Inventory targets are set per chemical compound; linking to the compound registry ensures correct safety and regulatory data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory valuation and safety‑stock cost tracking require linking targets to the responsible cost center.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Inventory targets are defined per planning horizon; linking provides context and removes need for separate horizon attributes.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Inventory Target calculations require the material master to derive safety stock, reorder points, and compliance flags per material.',
    `superseded_inventory_target_id` BIGINT COMMENT 'Self-referencing FK on inventory_target (superseded_inventory_target_id)',
    `batch_number` STRING COMMENT 'Identifier for the batch associated with the inventory target, if applicable.',
    `classification_type` STRING COMMENT 'Category of material indicating its role in the production process.. Valid values are `raw|intermediate|finished`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost assigned to one unit of the material.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory target record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost values.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `demand_forecast_qty` DECIMAL(18,2) COMMENT 'Projected demand quantity for the planning horizon used to set the target.',
    `effective_end_date` DATE COMMENT 'Date when the inventory target expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the inventory target becomes effective.',
    `ehs_category` STRING COMMENT 'Environmental, Health, and Safety classification for the material.',
    `inventory_status` STRING COMMENT 'Current status of the inventory target record.. Valid values are `active|inactive|discontinued`',
    `last_review_date` DATE COMMENT 'Date of the most recent manual or automated review of the target.',
    `lead_time_days` DECIMAL(18,2) COMMENT 'Average supplier lead time in days for the material.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard production lot size for the material.',
    `max_order_qty` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered in a single purchase order.',
    `max_stock_qty` DECIMAL(18,2) COMMENT 'Upper limit for inventory to avoid overstocking.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Minimum quantity that can be ordered from the supplier.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant where the inventory is held.',
    `regulatory_compliance_flag` STRING COMMENT 'Indicates whether the material meets applicable regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level that triggers a replenishment order.',
    `review_cycle_days` STRING COMMENT 'Frequency in days at which the inventory target is reviewed and possibly adjusted.',
    `safety_stock_percentage` DECIMAL(18,2) COMMENT 'Safety stock expressed as a percentage of average demand.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Quantity of material kept as safety stock to protect against demand variability.',
    `source_system` STRING COMMENT 'Name of the source system that provided the inventory target data.',
    `storage_location` STRING COMMENT 'Warehouse or storage location code within the plant.',
    `target_days_of_supply` DECIMAL(18,2) COMMENT 'Planned number of days the inventory should cover based on forecasted demand.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the material quantities.. Valid values are `kg|lb|l|gal|m3|pcs`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inventory target record.',
    CONSTRAINT pk_inventory_target PRIMARY KEY(`inventory_target_id`)
) COMMENT 'Inventory target and safety stock policy record defining the planned inventory levels for raw materials, intermediates, and finished chemical products. Captures material, plant, storage location, safety stock quantity, reorder point, maximum stock level, target days-of-supply, replenishment lead time, and review cycle. Drives MRP reorder point planning and inventory optimization for chemical feedstocks and finished goods.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` (
    `demand_plan_adjustment_id` BIGINT COMMENT 'System-generated unique identifier for each demand plan adjustment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Key‑account forecast adjustments are recorded per account to reflect negotiated volume changes and support the Demand Adjustment Report.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved or rejected the adjustment.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product to which the demand adjustment applies.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Adjustments to demand forecasts are recorded per material master to maintain audit trails and regulatory compliance.',
    `primary_demand_employee_id` BIGINT COMMENT 'Identifier of the planner who created or submitted the adjustment.',
    `reversal_demand_plan_adjustment_id` BIGINT COMMENT 'Self-referencing FK on demand_plan_adjustment (reversal_demand_plan_adjustment_id)',
    `adjusted_forecast_quantity` DECIMAL(18,2) COMMENT 'Quantity after the manual or consensus adjustment is applied.',
    `adjustment_number` STRING COMMENT 'Business identifier assigned to the adjustment for tracking in S&OP processes.',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was entered or applied.',
    `adjustment_type` STRING COMMENT 'Indicates whether the adjustment was manual, consensus‑driven, or system‑generated.. Valid values are `manual|consensus|system`',
    `approval_status` STRING COMMENT 'Current approval state of the adjustment.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved or rejected.',
    `approver_name` STRING COMMENT 'Display name of the approver.',
    `comments` STRING COMMENT 'Additional free‑form notes related to the adjustment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `demand_plan_adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment record.. Valid values are `draft|pending|approved|rejected`',
    `effective_end_date` DATE COMMENT 'Optional end date for the adjustments validity period.',
    `effective_start_date` DATE COMMENT 'Date from which the adjusted forecast quantity becomes effective.',
    `forecast_horizon` STRING COMMENT 'Planning horizon for which the forecast and adjustment apply.. Valid values are `weekly|monthly|quarterly|yearly`',
    `is_manual` BOOLEAN COMMENT 'Flag indicating whether the adjustment was entered manually (true) or generated by an algorithm (false).',
    `justification` STRING COMMENT 'Narrative explanation supporting the adjustment decision.',
    `original_forecast_quantity` DECIMAL(18,2) COMMENT 'Statistical forecast quantity before any manual adjustment.',
    `planner_name` STRING COMMENT 'Display name of the planner responsible for the adjustment.',
    `quantity_delta` DECIMAL(18,2) COMMENT 'Difference between adjusted and original forecast quantities (adjusted - original).',
    `reason_code` STRING COMMENT 'Standard code indicating why the forecast was adjusted.. Valid values are `demand_change|supply_constraint|new_product|seasonality|promotion|regulatory`',
    `reason_description` STRING COMMENT 'Free-text description providing context for the reason code.',
    `source_system` STRING COMMENT 'System of record where the adjustment originated.. Valid values are `SAP_PP|Oracle_TMS|Manual`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the forecast quantities (e.g., kg, ton, liters).',
    `updated_by` STRING COMMENT 'User identifier who last modified the adjustment record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the adjustment record.',
    `created_by` STRING COMMENT 'User identifier who initially created the adjustment record.',
    CONSTRAINT pk_demand_plan_adjustment PRIMARY KEY(`demand_plan_adjustment_id`)
) COMMENT 'Transactional record capturing manual or consensus-driven adjustments made to a statistical demand forecast during the S&OP demand review process. Records original forecast quantity, adjusted quantity, adjustment delta, adjustment reason code, business justification, adjusting planner, adjustment date, and approval status. Provides full audit trail of human overrides to statistical forecasts for chemical product demand planning.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` (
    `supply_demand_balance_id` BIGINT COMMENT 'Unique identifier for the supply-demand balance record.',
    `plant_id` BIGINT COMMENT 'Unique identifier for the manufacturing plant.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material (product) referenced in the balance.',
    `prior_period_supply_demand_balance_id` BIGINT COMMENT 'Self-referencing FK on supply_demand_balance (prior_period_supply_demand_balance_id)',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost of the material per unit of measure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the balance record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for any monetary fields.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Number of days the projected balance will cover based on average demand.',
    `excess_flag` BOOLEAN COMMENT 'Indicates if projected balance exceeds maximum inventory level.',
    `maximum_inventory_qty` DECIMAL(18,2) COMMENT 'Upper inventory limit to avoid excess holding costs.',
    `notes` STRING COMMENT 'Free‑text comments or remarks about the balance record.',
    `opening_stock_qty` DECIMAL(18,2) COMMENT 'Quantity of material on hand at the beginning of the planning period.',
    `planned_dependent_demand_qty` DECIMAL(18,2) COMMENT 'Quantity required as component for other finished goods.',
    `planned_issues_total` DECIMAL(18,2) COMMENT 'Total quantity expected to be issued (sales + dependent demand).',
    `planned_procurement_qty` DECIMAL(18,2) COMMENT 'Quantity of material expected to be received from external suppliers.',
    `planned_production_qty` DECIMAL(18,2) COMMENT 'Quantity of material scheduled for internal production during the period.',
    `planned_receipts_total` DECIMAL(18,2) COMMENT 'Total quantity expected to be received (production + procurement).',
    `planned_sales_qty` DECIMAL(18,2) COMMENT 'Quantity of material forecasted to be sold to customers.',
    `planning_period_end` DATE COMMENT 'Last day of the planning horizon for which the balance is calculated.',
    `planning_period_start` DATE COMMENT 'First day of the planning horizon for which the balance is calculated.',
    `planning_scenario` STRING COMMENT 'Name of the planning scenario used for the balance calculation.. Valid values are `Base|Optimistic|Pessimistic`',
    `plant_code` STRING COMMENT 'Plant code used in planning and execution systems.',
    `projected_available_balance` DECIMAL(18,2) COMMENT 'Projected net stock after planned receipts and issues.',
    `reorder_point_qty` DECIMAL(18,2) COMMENT 'Inventory level that triggers a procurement action.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum inventory to protect against demand or supply variability.',
    `shortage_flag` BOOLEAN COMMENT 'Indicates if projected balance falls below safety stock.',
    `supply_demand_balance_status` STRING COMMENT 'Current lifecycle status of the balance record.. Valid values are `active|inactive|archived`',
    `total_cost` DECIMAL(18,2) COMMENT 'Projected monetary value of the projected available balance.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for all quantity fields (e.g., kilograms, liters).. Valid values are `kg|lb|ton|g|l|ml`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the balance record.',
    `version_number` STRING COMMENT 'Version identifier for revisions of the balance record.',
    CONSTRAINT pk_supply_demand_balance PRIMARY KEY(`supply_demand_balance_id`)
) COMMENT 'Supply-demand balance record representing the net position for a material at a plant for a specific planning period. Captures opening stock, planned receipts (production + procurement), planned issues (sales orders + dependent demand), projected available balance, days-of-supply, shortage flag, and excess flag. Core planning visibility record used in S&OP reviews and daily planning meetings in chemical manufacturing operations.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the production schedule record.',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product to be manufactured in this schedule.',
    `employee_id` BIGINT COMMENT 'Identifier of the planner responsible for creating or maintaining the schedule.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Production schedules need the exact formula version to set process parameters and track batch composition.',
    `manufacturing_order_id` BIGINT COMMENT 'FK to production.manufacturing_order.manufacturing_order_id — Cannot link production plan to execution without this FK — planners need to see which scheduled items have been released as manufacturing orders. Critical for plan-vs-actual reporting.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the schedule will be executed.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or reactor where the production run will be executed.',
    `rescheduled_production_schedule_id` BIGINT COMMENT 'Self-referencing FK on production_schedule (rescheduled_production_schedule_id)',
    `batch_size` DECIMAL(18,2) COMMENT 'Planned quantity of product to be produced in this run.',
    `campaign_flag` BOOLEAN COMMENT 'Indicates whether the run is part of a multi‑batch campaign (true) or a standalone batch (false).',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Planned utilization of the work center capacity expressed as a percentage.',
    `changeover_time_minutes` STRING COMMENT 'Estimated minutes required to change over the equipment before this run starts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule record was first created in the system.',
    `freeze_status` BOOLEAN COMMENT 'True if the schedule is locked from further changes.',
    `lot_number` STRING COMMENT 'Lot identifier assigned to the batch for traceability.',
    `notes` STRING COMMENT 'Free‑form comments entered by planners or operators.',
    `priority` STRING COMMENT 'Numeric priority used by the optimizer to rank schedules (higher = more urgent).',
    `production_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `planned|released|in_progress|completed|cancelled|frozen`',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was released for execution.',
    `revision_number` STRING COMMENT 'Version counter incremented each time the schedule is modified.',
    `schedule_number` STRING COMMENT 'Business-visible schedule code used for reference in shop floor and planning systems.',
    `schedule_type` STRING COMMENT 'Indicates whether the run is batch, continuous, or semi‑continuous.. Valid values are `batch|continuous|semi_continuous`',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time for the production run.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for the production run.',
    `sequence_number` STRING COMMENT 'Order of this schedule within a larger production campaign.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the batch size (e.g., kilograms, liters).. Valid values are `kg|lb|ton|gal|L`',
    `updated_by` STRING COMMENT 'User identifier of the last person who modified the schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the schedule.',
    `created_by` STRING COMMENT 'User identifier of the planner who created the schedule.',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Detailed production schedule record defining the sequenced and time-phased production runs for chemical manufacturing work centers and reactors. Captures schedule ID, work center, product, batch size, scheduled start datetime, scheduled end datetime, sequence number, campaign flag, changeover time, scheduling status, and freeze status. Drives shop floor execution and feeds the MES/DCS systems in chemical plants.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` (
    `changeover_matrix_id` BIGINT COMMENT 'Unique identifier for the changeover matrix record.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or reactor where the changeover occurs.',
    `reverse_changeover_matrix_id` BIGINT COMMENT 'Self-referencing FK on changeover_matrix (reverse_changeover_matrix_id)',
    `changeover_cost` DECIMAL(18,2) COMMENT 'Monetary cost associated with the changeover, including labor, materials, and waste.',
    `changeover_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the changeover in hours.',
    `changeover_matrix_status` STRING COMMENT 'Current status of the changeover entry.. Valid values are `active|inactive|deprecated`',
    `cleaning_type` STRING COMMENT 'Type of cleaning required during changeover.. Valid values are `CIP|flush|purge|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the changeover record was created.',
    `effective_end_date` DATE COMMENT 'Date until which the changeover record is valid (null if indefinite).',
    `effective_start_date` DATE COMMENT 'Date from which the changeover record is valid.',
    `from_product_code` STRING COMMENT 'Code of the product that is being changed from (source product).',
    `notes` STRING COMMENT 'Free-text remarks or special instructions for the changeover.',
    `to_product_code` STRING COMMENT 'Code of the product that is being changed to (target product).',
    `updated_by` STRING COMMENT 'User or system that performed the most recent update to the changeover record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the changeover record.',
    `created_by` STRING COMMENT 'User or system that created the changeover record.',
    CONSTRAINT pk_changeover_matrix PRIMARY KEY(`changeover_matrix_id`)
) COMMENT 'Reference master defining sequence-dependent changeover times and costs between chemical products on a shared work center or reactor. Captures from-product, to-product, work center, changeover duration (hours), cleaning requirement type (CIP, flush, purge), changeover cost, and validity period. Critical for production scheduling optimization in multi-product chemical plants where reactor cleaning between campaigns is a significant constraint.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`parameter` (
    `parameter_id` BIGINT COMMENT 'Unique identifier for the planning parameter record.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Planning parameters are scoped to a planning horizon; FK consolidates horizon information.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Planning parameters (lot sizing, safety stock) are defined per material master to reflect material‑specific characteristics.',
    `inherited_parameter_id` BIGINT COMMENT 'Self-referencing FK on parameter (inherited_parameter_id)',
    `change_number` STRING COMMENT 'System-generated number indicating the change request that modified the record.',
    `consumption_based_planning` BOOLEAN COMMENT 'True if the material uses consumption-based planning; otherwise false.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the planning parameter record was first created.',
    `effective_end_date` DATE COMMENT 'Date after which the planning parameters are no longer valid (null if open-ended).',
    `effective_start_date` DATE COMMENT 'Date from which the planning parameters become valid.',
    `in_house_production_time_days` STRING COMMENT 'Time required to produce the material within the plant.',
    `lot_size_maximum` DECIMAL(18,2) COMMENT 'Largest permissible production or procurement lot size for the material in the plant.',
    `lot_size_minimum` DECIMAL(18,2) COMMENT 'Smallest permissible production or procurement lot size for the material in the plant.',
    `lot_size_rounding` DECIMAL(18,2) COMMENT 'Rounding quantity applied to the calculated lot size to meet production or procurement constraints.',
    `lot_sizing_procedure` STRING COMMENT 'Procedure that defines how lot sizes are calculated (e.g., EX = Fixed lot size, HB = Lot size based on historical consumption, VB = Lot size based on forecast, FO = Fixed order quantity, FOB = Fixed order quantity with minimum, ND = No lot sizing).. Valid values are `EX|HB|VB|FO|FOB|ND`',
    `mrp_controller` STRING COMMENT 'Person or department responsible for the materials planning.',
    `mrp_type` STRING COMMENT 'Determines the planning method for the material (e.g., PD = MRP, VB = Manual reorder point, FO = Forecast, HB = Consumption based, EX = External, ND = No planning).. Valid values are `PD|VB|FO|HB|EX|ND`',
    `parameter_description` STRING COMMENT 'Free-text description providing additional context for the planning parameters.',
    `parameter_status` STRING COMMENT 'Current lifecycle status of the planning parameter record.. Valid values are `active|inactive|deleted`',
    `planned_delivery_time_days` STRING COMMENT 'Lead time for external procurement or inter-plant delivery.',
    `planning_group` STRING COMMENT 'Group used to aggregate materials for collective planning.',
    `planning_horizon_days` STRING COMMENT 'Number of days into the future for which the material is planned.',
    `plant_code` STRING COMMENT 'Plant identifier where the material is planned and produced.',
    `procurement_type` STRING COMMENT 'Indicates whether the material is procured externally (E) or produced in-house (I).. Valid values are `E|I`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Stock level that triggers a replenishment order.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Additional stock kept to protect against demand or supply variability.',
    `safety_time_days` STRING COMMENT 'Additional days added to the lead time to protect against uncertainties.',
    `scheduling_margin_key` STRING COMMENT 'Key that defines the safety margin applied during production scheduling.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities defined in this record (e.g., KG, L, TON).',
    `updated_by` STRING COMMENT 'Identifier of the user who performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the planning parameter record.',
    `version_number` STRING COMMENT 'Sequential version number for change tracking of the planning parameters.',
    `created_by` STRING COMMENT 'Identifier of the user who created the record.',
    CONSTRAINT pk_parameter PRIMARY KEY(`parameter_id`)
) COMMENT 'Material and plant-level MRP and planning parameter master record defining the control parameters governing how a material is planned. Captures MRP type (MRP, MPS, reorder point, consumption-based), lot sizing procedure, minimum lot size, maximum lot size, rounding value, planning horizon, safety time, in-house production time, planned delivery time, and scheduling margin keys. The authoritative planning configuration record for each material-plant combination in SAP PP/MM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`horizon` (
    `horizon_id` BIGINT COMMENT 'Unique surrogate key for each planning horizon definition.',
    `parent_horizon_id` BIGINT COMMENT 'Self-referencing FK on horizon (parent_horizon_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the horizon record was initially created.',
    `effective_end_date` DATE COMMENT 'Date when this horizon configuration expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when this horizon configuration becomes effective for planning.',
    `fence_type` STRING COMMENT 'Type of planning fence applied (hard, soft, or none).. Valid values are `hard|soft|none`',
    `fence_value` STRING COMMENT 'Numeric value (in days) defining the size of the planning fence.',
    `horizon_description` STRING COMMENT 'Free‑text description of the horizon purpose and usage.',
    `horizon_status` STRING COMMENT 'Current lifecycle status of the horizon definition.. Valid values are `active|inactive|deprecated`',
    `horizon_type` STRING COMMENT 'Category of the planning horizon (e.g., demand planning, MRP, freeze, firming fence, trading).. Valid values are `demand|mrp|freeze|firming|trading`',
    `is_default` BOOLEAN COMMENT 'True if this horizon is the default configuration for its planning level.',
    `length` STRING COMMENT 'Numeric length of the horizon expressed in the selected unit.',
    `length_unit` STRING COMMENT 'Unit of measure for horizon_length (days, weeks, or months).. Valid values are `days|weeks|months`',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the horizon.',
    `planning_level` STRING COMMENT 'Organizational or product level to which the horizon applies (e.g., plant, product family, material, site).. Valid values are `plant|product_family|material|site`',
    `rolling_flag` BOOLEAN COMMENT 'True if the horizon rolls forward automatically each planning cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the horizon record.',
    CONSTRAINT pk_horizon PRIMARY KEY(`horizon_id`)
) COMMENT 'Reference record defining the planning time horizons and fence configurations used in demand and supply planning. Captures horizon type (demand planning horizon, MRP planning horizon, freeze horizon, firming fence, trading horizon), horizon length in days/weeks/months, rolling flag, and applicable planning level (plant, product family, material). Governs the time-phased planning windows used across S&OP, MRP, and production scheduling processes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` (
    `rough_cut_capacity_id` BIGINT COMMENT 'Unique identifier for the rough cut capacity record.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Rough‑cut capacity assessments are performed for a specific planning horizon; linking provides horizon context.',
    `resource_id` BIGINT COMMENT 'Identifier of the resource (work center, equipment, or utility) for which capacity is evaluated.',
    `revised_rough_cut_capacity_id` BIGINT COMMENT 'Self-referencing FK on rough_cut_capacity (revised_rough_cut_capacity_id)',
    `approval_status` STRING COMMENT 'Current approval state of the capacity assessment.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User who approved the capacity assessment.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment was approved.',
    `audit_trail` STRING COMMENT 'Summary of changes made to the record for compliance and traceability.',
    `available_capacity` DECIMAL(18,2) COMMENT 'Total capacity available for the resource in the planning period.',
    `available_capacity_unit` STRING COMMENT 'Unit of measure for available capacity.. Valid values are `hours|kg|m3|tonnes|liters`',
    `capacity_source` STRING COMMENT 'Origin of the available capacity figure.. Valid values are `planned|actual|maintenance_schedule`',
    `constraint_severity` STRING COMMENT 'Severity level of any capacity constraint identified.. Valid values are `low|medium|high|critical`',
    `constraint_type` STRING COMMENT 'Category of constraint causing infeasibility.. Valid values are `capacity|material|equipment|maintenance|quality`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `effective_date` DATE COMMENT 'Date when the capacity assessment becomes effective for planning.',
    `expiration_date` DATE COMMENT 'Date when the capacity assessment expires or is superseded.',
    `feasibility_flag` BOOLEAN COMMENT 'Indicates whether the planned load fits within available capacity (true = feasible).',
    `is_locked` BOOLEAN COMMENT 'Indicates if the record is locked from further edits.',
    `load_source` STRING COMMENT 'Origin of the required load quantity.. Valid values are `MPS|forecast|manual`',
    `notes` STRING COMMENT 'Free-text comments or observations about the capacity assessment.',
    `planning_period_end` DATE COMMENT 'End date of the planning horizon for capacity assessment.',
    `planning_period_start` DATE COMMENT 'Start date of the planning horizon for capacity assessment.',
    `required_load` DECIMAL(18,2) COMMENT 'Total load required by the Master Production Schedule for the resource during the planning period.',
    `required_load_unit` STRING COMMENT 'Unit of measure for required load.. Valid values are `hours|kg|m3|tonnes|liters`',
    `resource_type` STRING COMMENT 'Type of resource being evaluated.. Valid values are `work_center|utility|raw_material|equipment`',
    `revision_number` STRING COMMENT 'Revision number for audit tracking of the capacity record.',
    `scenario_name` STRING COMMENT 'Name of the planning scenario (e.g., Base, Optimistic).',
    `updated_by` STRING COMMENT 'User identifier who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of capacity utilized (required_load / available_capacity * 100).',
    `version_number` STRING COMMENT 'Version of the rough cut capacity record for the scenario.',
    `created_by` STRING COMMENT 'User identifier who created the record.',
    CONSTRAINT pk_rough_cut_capacity PRIMARY KEY(`rough_cut_capacity_id`)
) COMMENT 'Rough-Cut Capacity Planning (RCCP) record assessing high-level capacity feasibility of the Master Production Schedule against key resource profiles. Captures resource (work center, utility, raw material), planning period, required load from MPS, available capacity, utilization rate, feasibility flag, and constraint severity. Used in S&OP supply review to validate whether the production plan is achievable before committing to detailed MRP and scheduling.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` (
    `campaign_plan_id` BIGINT COMMENT 'Unique identifier for the production campaign plan.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Marketing campaigns are targeted to specific customer accounts; linking enables campaign ROI analysis and compliance tracking per account.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign budgeting is managed through cost centers; needed for Campaign Cost Tracking report.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Campaign planning for batch production references the material master to ensure correct safety data sheet and regulatory compliance.',
    `plant_id` BIGINT COMMENT 'Unique identifier of the plant hosting the campaign.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: Campaign Planning process requires linking each campaign plan to the actual production campaign record for execution tracking.',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the associated Safety Data Sheet.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or reactor where the campaign is executed.',
    `preceding_campaign_plan_id` BIGINT COMMENT 'Self-referencing FK on campaign_plan (preceding_campaign_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the campaign plan.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign plan was approved.',
    `approved_by` STRING COMMENT 'User who approved the campaign plan.',
    `batch_size` DECIMAL(18,2) COMMENT 'Standard size of each batch within the campaign.',
    `campaign_code` STRING COMMENT 'Business identifier code for the campaign.',
    `campaign_name` STRING COMMENT 'Human‑readable name of the campaign.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `campaign_trigger` STRING COMMENT 'Condition that initiates the campaign (e.g., inventory level, order backlog).. Valid values are `inventory_level|order_backlog|forecast|manual`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost for executing the campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the campaign record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the campaigns environmental impact.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the campaign plan is locked from further edits.',
    `location_code` STRING COMMENT 'Code identifying the plant or site where the campaign is run.',
    `minimum_campaign_length_days` STRING COMMENT 'Shortest allowable duration for the campaign, in days.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the campaign.',
    `number_of_batches` STRING COMMENT 'Total number of batches planned in the campaign.',
    `planned_end_date` DATE COMMENT 'Scheduled end date of the campaign.',
    `planned_start_date` DATE COMMENT 'Scheduled start date of the campaign.',
    `priority_level` STRING COMMENT 'Business priority assigned to the campaign.. Valid values are `high|medium|low`',
    `product_family` STRING COMMENT 'Family or group of products covered by the campaign.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the product being manufactured.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the campaign meets all applicable regulatory requirements.',
    `schedule_priority` STRING COMMENT 'Numeric priority used by the scheduler to order campaigns.',
    `total_planned_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity to be produced across the campaign.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the planned quantity.. Valid values are `kg|lb|ton|g|l|ml`',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the campaign record.',
    `version_number` STRING COMMENT 'Revision number of the campaign plan.',
    `created_by` STRING COMMENT 'User or system that created the campaign record.',
    CONSTRAINT pk_campaign_plan PRIMARY KEY(`campaign_plan_id`)
) COMMENT 'Production campaign planning record defining a multi-batch campaign for a chemical product or product family on a dedicated reactor or production line. Captures campaign ID, product family, work center, planned campaign start/end dates, total planned quantity, number of batches, minimum campaign length, campaign trigger (inventory level, order backlog), and campaign status. Supports campaign-based scheduling optimization common in specialty chemical and agrochemical manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`atp_check` (
    `atp_check_id` BIGINT COMMENT 'System-generated unique identifier for the ATP check record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer for whom the ATP check was performed.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: ATP (Available‑to‑Promise) checks need the material master to validate stock, hazard, and regulatory status for each material.',
    `product_order_id` BIGINT COMMENT 'Identifier of the sales order associated with the ATP check.',
    `recheck_atp_check_id` BIGINT COMMENT 'Self-referencing FK on atp_check (recheck_atp_check_id)',
    `allocation_rule` STRING COMMENT 'Rule applied to allocate available stock to the request (e.g., FIFO, FEFO).',
    `atp_check_status` STRING COMMENT 'Current processing status of the ATP check.. Valid values are `pending|completed|failed|error`',
    `atp_method` STRING COMMENT 'Algorithm used for the availability check: simple ATP, multi‑level ATP, or capable‑to‑promise (CTP).. Valid values are `simple|multi_level|ctp`',
    `batch_number` STRING COMMENT 'Lot or batch identifier relevant for batch‑controlled materials.',
    `check_number` STRING COMMENT 'Business-visible identifier for the ATP check, used in communications and reporting.',
    `check_timestamp` TIMESTAMP COMMENT 'Date and time when the ATP check was executed.',
    `confirmed_delivery_date` DATE COMMENT 'Date the system can commit to delivering the confirmed quantity.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity that can be promised to the customer after ATP evaluation.',
    `confirmed_uom` STRING COMMENT 'Unit of measure for the confirmed quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ATP check record was first created in the system.',
    `demand_source` STRING COMMENT 'Origin of the demand triggering the ATP check.. Valid values are `forecast|order|manual`',
    `is_backorder_allowed` BOOLEAN COMMENT 'Indicates whether backordering is permitted for this request.',
    `is_batch_constrained` BOOLEAN COMMENT 'True if batch‑level constraints affect availability.',
    `is_capacity_constrained` BOOLEAN COMMENT 'True if production capacity limits the confirmed quantity.',
    `is_lot_constrained` BOOLEAN COMMENT 'True if the material is subject to lot‑level availability constraints.',
    `is_material_availability` BOOLEAN COMMENT 'Indicates whether the material is available in inventory for the request.',
    `is_shortage_flag` BOOLEAN COMMENT 'True when shortage_quantity is greater than zero.',
    `is_simulation` BOOLEAN COMMENT 'True if the ATP check was performed as a simulation rather than a live order.',
    `lead_time_days` STRING COMMENT 'Planned lead time in days used in the ATP calculation.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the ATP check.',
    `planning_horizon_days` STRING COMMENT 'Number of days ahead considered in the ATP calculation.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant where availability is evaluated.',
    `priority_level` STRING COMMENT 'Business priority assigned to the ATP check request.. Valid values are `high|medium|low`',
    `requested_delivery_date` DATE COMMENT 'Date the customer expects delivery of the requested quantity.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity requested by the customer or forecast, before ATP evaluation.',
    `requested_uom` STRING COMMENT 'Unit of measure for the requested quantity (e.g., KG, L, EA).',
    `shortage_quantity` DECIMAL(18,2) COMMENT 'Quantity that cannot be fulfilled due to constraints.',
    `shortage_uom` STRING COMMENT 'Unit of measure for the shortage quantity.',
    `source_system` STRING COMMENT 'System of record that originated the ATP check (e.g., SAP S/4HANA, SAP PP).',
    `supply_source` STRING COMMENT 'Source of supply considered in the ATP calculation.. Valid values are `inventory|production|procurement`',
    `updated_by` STRING COMMENT 'User identifier who last modified the ATP check record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ATP check record.',
    `version_number` STRING COMMENT 'Version of the ATP check record for audit and re‑run purposes.',
    `created_by` STRING COMMENT 'User identifier who created the ATP check record.',
    CONSTRAINT pk_atp_check PRIMARY KEY(`atp_check_id`)
) COMMENT 'Available-to-Promise (ATP) check transactional record capturing the result of an ATP or capable-to-promise (CTP) availability check performed for a customer order or forecast requirement. Records check date/time, material, plant, requested quantity, requested delivery date, confirmed quantity, confirmed delivery date, ATP method used (simple ATP, multi-level ATP, CTP), and shortage quantity. Critical for order promising in chemical manufacturing where lead times and batch constraints affect delivery commitments.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'System-generated unique identifier for the allocation rule.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the rule.',
    `tertiary_allocation_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who performed the latest update.',
    `fallback_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (fallback_allocation_rule_id)',
    `allocation_basis` STRING COMMENT 'Basis on which supply is allocated (e.g., historical share, contract priority, strategic customer tier).. Valid values are `historical_share|contract_priority|strategic_tier`',
    `allocation_method` STRING COMMENT 'Method used to calculate allocations (proportional, fixed quantity, or priority‑based).. Valid values are `proportional|fixed|priority`',
    `allocation_period_end` DATE COMMENT 'Last date of the period for which the rule applies.',
    `allocation_period_start` DATE COMMENT 'First date of the period for which the rule applies.',
    `allocation_rule_description` STRING COMMENT 'Detailed narrative describing the intent and application of the allocation rule.',
    `allocation_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|draft|retired`',
    `allocation_scope` STRING COMMENT 'Scope level at which the rule is applied: per customer, geographic region, or sales channel.. Valid values are `customer|region|channel`',
    `approval_status` STRING COMMENT 'Current approval state of the rule.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was created.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective for operational use.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null if open‑ended.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rule exclusively governs allocation (true) or can be combined with other rules (false).',
    `max_allocation_per_customer` DECIMAL(18,2) COMMENT 'Upper limit of quantity that any single customer can receive under this rule.',
    `min_allocation_per_customer` DECIMAL(18,2) COMMENT 'Lower bound of quantity guaranteed to each eligible customer under this rule.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the rule.',
    `priority_level` STRING COMMENT 'Numeric priority of the rule; lower numbers indicate higher priority when multiple rules apply.',
    `rule_code` STRING COMMENT 'Business code used to reference the rule in external systems and documents.',
    `rule_name` STRING COMMENT 'Human‑readable name describing the purpose of the rule.',
    `total_available_quantity` DECIMAL(18,2) COMMENT 'Total quantity of the product available for allocation during the rule period.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity fields (e.g., kilograms, liters).. Valid values are `kg|L|ton|gal|m3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the rule.',
    `version` STRING COMMENT 'Version number of the rule to support change management.',
    `version_effective_date` DATE COMMENT 'Date when this version of the rule becomes effective.',
    `version_expiration_date` DATE COMMENT 'Date when this version of the rule expires; null if still active.',
    CONSTRAINT pk_allocation_rule PRIMARY KEY(`allocation_rule_id`)
) COMMENT 'Product allocation rule master record defining how constrained supply of a chemical product is allocated across customers, regions, or sales channels during shortage situations. Captures allocation rule ID, product, allocation basis (historical share, contract priority, strategic customer tier), allocation period, total available quantity, allocation method, and approval status. Governs fair and strategic supply allocation during chemical supply shortages or plant outages.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` (
    `customer_allocation_id` BIGINT COMMENT 'System-generated unique identifier for the customer allocation record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer receiving the allocation.',
    `allocation_rule_id` BIGINT COMMENT 'Code identifying the allocation rule applied to this record.',
    `chemical_product_id` BIGINT COMMENT 'Unique identifier of the chemical product being allocated.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Customer allocation of quantities is performed per material master to ensure correct product specification and compliance.',
    `split_from_customer_allocation_id` BIGINT COMMENT 'Self-referencing FK on customer_allocation (split_from_customer_allocation_id)',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Total quantity of product allocated to the customer.',
    `allocated_uom` STRING COMMENT 'Unit of measure for the allocated quantity.. Valid values are `kg|lb|ton|L|gal|m3`',
    `allocated_value` DECIMAL(18,2) COMMENT 'Monetary value of the allocated quantity expressed in the specified currency.',
    `allocated_value_currency` STRING COMMENT 'Currency of the allocated monetary value.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `allocation_end_date` DATE COMMENT 'Date on which the allocation expires or is scheduled to end.',
    `allocation_rule_version` STRING COMMENT 'Version of the allocation rule applied to this record.',
    `allocation_source` STRING COMMENT 'Source system or actor that created the allocation.. Valid values are `system|user|external`',
    `allocation_start_date` DATE COMMENT 'Date on which the allocation becomes effective.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the allocation.. Valid values are `active|inactive|fulfilled|expired|cancelled|pending`',
    `allocation_type` STRING COMMENT 'Classification of the allocation origin or methodology.. Valid values are `contract|forecast|manual|reallocation`',
    `allocation_version` STRING COMMENT 'Version identifier for the allocation rule instance.',
    `approved_by` STRING COMMENT 'User or authority that approved the allocation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation was approved for execution.',
    `batch_number` STRING COMMENT 'Batch identifier associated with the allocated product.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the allocation complies with relevant chemical regulations.',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allocation that has been consumed by the customer.',
    `consumed_uom` STRING COMMENT 'Unit of measure for the consumed quantity.. Valid values are `kg|lb|ton|L|gal|m3`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary values associated with the allocation.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `effective_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the allocation became effective (may include time of day).',
    `ehs_category` STRING COMMENT 'Environmental, Health, and Safety classification of the allocated product.. Valid values are `hazardous|non_hazardous|restricted|controlled`',
    `expiration_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the allocation expires.',
    `is_locked` BOOLEAN COMMENT 'Indicates whether the allocation is locked from further changes.',
    `lot_number` STRING COMMENT 'Lot identifier for the batch of product allocated.',
    `notes` STRING COMMENT 'Free-text field for additional comments or business notes.',
    `priority_level` STRING COMMENT 'Business priority assigned to the allocation for fulfillment sequencing.. Valid values are `high|medium|low`',
    `regulatory_status` STRING COMMENT 'Current regulatory compliance status of the allocation.. Valid values are `compliant|non_compliant|pending_review`',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allocation that remains unconsumed.',
    `remaining_uom` STRING COMMENT 'Unit of measure for the remaining quantity.. Valid values are `kg|lb|ton|L|gal|m3`',
    `revision_number` STRING COMMENT 'Sequential revision number for changes to the allocation record.',
    `status_reason` STRING COMMENT 'Explanation or code describing why the allocation is in its current status.',
    `updated_by` STRING COMMENT 'User or process identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    `created_by` STRING COMMENT 'User or process identifier that created the allocation record.',
    CONSTRAINT pk_customer_allocation PRIMARY KEY(`customer_allocation_id`)
) COMMENT 'Transactional record assigning a specific allocated quantity of a constrained chemical product to a customer account or distribution channel for a defined period. Captures allocation ID, allocation rule reference, customer account, product, allocated quantity, consumed quantity, remaining quantity, allocation period start/end, and allocation status. Enables order management to enforce supply allocation limits during chemical product shortages.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` (
    `forecast_accuracy_record_id` BIGINT COMMENT 'System-generated unique identifier for each forecast accuracy measurement record.',
    `forecast_version_id` BIGINT COMMENT 'Identifier linking the accuracy record to the specific forecast version used.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Forecast accuracy reports tie actual vs. forecast quantities to the material master for performance analysis and regulatory reporting.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the forecast was generated.',
    `prior_period_forecast_accuracy_record_id` BIGINT COMMENT 'Self-referencing FK on forecast_accuracy_record (prior_period_forecast_accuracy_record_id)',
    `accuracy_tier` STRING COMMENT 'Categorical classification of forecast accuracy based on predefined thresholds.. Valid values are `high|medium|low`',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Real quantity sold or consumed during the measurement period.',
    `bias` DECIMAL(18,2) COMMENT 'Average signed deviation indicating systematic over- or under-forecasting.',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence (percentage) associated with the forecast.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values, if applicable.. Valid values are `[A-Z]{3}`',
    `data_quality_flag` STRING COMMENT 'Indicator of the underlying data quality for the forecast inputs.. Valid values are `good|questionable|bad`',
    `error_threshold_percent` DECIMAL(18,2) COMMENT 'Configured percentage threshold used to flag outlier forecast errors.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the forecast accuracy measurement was recorded (typically end of the measurement period).',
    `forecast_horizon_weeks` STRING COMMENT 'Number of weeks the forecast covers.',
    `forecast_method` STRING COMMENT 'Algorithm or technique used to generate the forecast.. Valid values are `ARIMA|ExponentialSmoothing|MachineLearning|Statistical`',
    `forecast_quantity` DECIMAL(18,2) COMMENT 'Quantity forecasted for the measurement period, expressed in the unit of measure.',
    `forecast_source` STRING COMMENT 'Originating system of the forecast (e.g., SAP, external model).',
    `is_outlier` BOOLEAN COMMENT 'True if the forecast error exceeds the defined error threshold.',
    `location_code` STRING COMMENT 'Code representing the specific site or warehouse location.',
    `mad` DECIMAL(18,2) COMMENT 'Average absolute deviation between forecast and actual values.',
    `mape` DECIMAL(18,2) COMMENT 'Percentage error between forecast and actual quantities.',
    `measurement_type` STRING COMMENT 'Indicates whether the record measures demand forecast accuracy or consumption forecast accuracy.. Valid values are `demand|consumption`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the forecast accuracy measurement.',
    `period_end` DATE COMMENT 'Last calendar date of the measurement period.',
    `period_start` DATE COMMENT 'First calendar date of the measurement period.',
    `record_status` STRING COMMENT 'Current lifecycle state of the accuracy record.. Valid values are `active|archived`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the forecast accuracy record is required for regulatory reporting (e.g., EPA, OSHA).',
    `root_cause_category` STRING COMMENT 'High-level reason for significant forecast miss (e.g., demand_volatility, supply_disruption, data_quality).',
    `scenario_name` STRING COMMENT 'Name of the planning scenario (e.g., baseline, promotional, new_product).',
    `unit_of_measure` STRING COMMENT 'Standard unit (e.g., kg, L, metric_ton) used for forecast and actual quantities.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the record.',
    `wmape` DECIMAL(18,2) COMMENT 'Weighted percentage error, accounting for volume importance.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_forecast_accuracy_record PRIMARY KEY(`forecast_accuracy_record_id`)
) COMMENT 'Periodic forecast accuracy measurement record tracking the statistical accuracy of demand forecasts against actual sales or consumption for chemical products. Captures measurement period, product, plant, forecast quantity, actual quantity, forecast error (MAPE, WMAPE, bias, MAD), accuracy tier classification, and root cause category for significant misses. Drives continuous improvement of the demand planning process and statistical model selection.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`constraint` (
    `constraint_id` BIGINT COMMENT 'Unique identifier for the planning constraint record.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Constraints are defined for a specific planning horizon; adding this FK provides temporal context and eliminates the siloed status of planning_constraint.',
    `parent_constraint_id` BIGINT COMMENT 'Self-referencing FK on constraint (parent_constraint_id)',
    `affected_entity_code` STRING COMMENT 'Code identifying the material, work center, utility, or process that the constraint applies to.',
    `affected_entity_type` STRING COMMENT 'Type of entity impacted by the constraint.. Valid values are `material|work_center|utility|process|product`',
    `compliance_status` STRING COMMENT 'Current compliance status of the constraint with respect to applicable regulations.. Valid values are `compliant|non_compliant|exempt`',
    `constraint_category` STRING COMMENT 'Higher‑level grouping of the constraint type.. Valid values are `capacity|availability|quality|safety|environment`',
    `constraint_name` STRING COMMENT 'Human‑readable name of the planning constraint.',
    `constraint_status` STRING COMMENT 'Current lifecycle status of the constraint.. Valid values are `active|inactive|pending|retired`',
    `constraint_type` STRING COMMENT 'Category of the constraint such as raw material availability or reactor capacity.. Valid values are `raw_material|reactor_capacity|utility_limit|regulatory|minimum_batch|shelf_life`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the constraint record was created.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Duration of time‑based constraints expressed in hours.',
    `effective_end_date` DATE COMMENT 'Date when the constraint expires; null if indefinite.',
    `effective_start_date` DATE COMMENT 'Date when the constraint becomes effective.',
    `impact_area` STRING COMMENT 'Business area affected (e.g., production, supply chain, logistics).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the constraint is mandatory (true) or advisory (false).',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the constraint.',
    `mitigation_action` STRING COMMENT 'Planned action to mitigate or resolve the constraint.',
    `notes` STRING COMMENT 'Additional free‑text comments about the constraint.',
    `origin` STRING COMMENT 'Source of the constraint: internal policy, external requirement, or regulatory mandate.. Valid values are `internal|external|regulatory`',
    `priority_level` STRING COMMENT 'Business priority assigned to the constraint.. Valid values are `high|medium|low`',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric value of the constraint (e.g., quantity, capacity, limit).',
    `regulatory_reference` STRING COMMENT 'Citation of the regulatory rule or standard that imposes the constraint (e.g., EPA, REACH).',
    `related_batch_lot` STRING COMMENT 'Lot number or batch identifier associated with the constraint, if applicable.',
    `review_cycle` STRING COMMENT 'Frequency at which the constraint is reviewed.. Valid values are `monthly|quarterly|annually`',
    `risk_level` STRING COMMENT 'Risk rating assigned to the constraint.. Valid values are `critical|high|moderate|low`',
    `source_system` STRING COMMENT 'System of record where the constraint originated (e.g., SAP PP, Honeywell DCS).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for constraint_quantity (e.g., kg, L, MW, hours).',
    `updated_by` STRING COMMENT 'User identifier who last updated the constraint.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the constraint record.',
    `version_number` STRING COMMENT 'Version number of the constraint record for change tracking.',
    `created_by` STRING COMMENT 'User identifier who created the constraint.',
    CONSTRAINT pk_constraint PRIMARY KEY(`constraint_id`)
) COMMENT 'Master record defining known planning constraints that limit production or supply capability for chemical manufacturing operations. Captures constraint ID, constraint type (raw material availability, reactor capacity, utility limitation, regulatory restriction, minimum batch size, shelf life), affected material or work center, constraint quantity or duration, validity period, and mitigation action. Feeds S&OP supply review and capacity planning processes as a structured constraint registry.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` (
    `interplant_supply_plan_id` BIGINT COMMENT 'System-generated unique identifier for the inter‑plant supply plan record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier for the chemical material (e.g., CAS number or ERP material code).',
    `return_interplant_supply_plan_id` BIGINT COMMENT 'Self-referencing FK on interplant_supply_plan (return_interplant_supply_plan_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan was formally approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan record was first created in the system.',
    `effective_from` DATE COMMENT 'Start date of the plans validity period.',
    `effective_until` DATE COMMENT 'End date of the plans validity period; null if open‑ended.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the plan is considered critical for production continuity.',
    `lead_time_days` STRING COMMENT 'Number of days required from dispatch to receipt, used for scheduling.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the plan.',
    `plan_number` STRING COMMENT 'Business‑visible plan code used for tracking and communication across plants.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the supply plan.. Valid values are `draft|approved|released|cancelled|completed`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material planned to be transferred between plants.',
    `planned_transfer_date` DATE COMMENT 'Calendar date on which the material transfer is scheduled to occur.',
    `priority_level` STRING COMMENT 'Business priority assigned to the plan for execution sequencing.. Valid values are `high|medium|low`',
    `quantity_uom` STRING COMMENT 'Unit of measure for the planned quantity.. Valid values are `kg|lb|ton|L|gal|m3`',
    `receiving_plant_code` STRING COMMENT 'Identifier of the plant that will receive the material.',
    `sending_plant_code` STRING COMMENT 'Identifier of the plant that will dispatch the material.',
    `source_system` STRING COMMENT 'Name of the source ERP/system that generated the plan record.',
    `transfer_type` STRING COMMENT 'Category of inter‑plant movement: stock transfer, tolling arrangement, or consignment.. Valid values are `stock_transfer|tolling|consignment`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    `version_number` STRING COMMENT 'Sequential version identifier for plan revisions.',
    `created_by` STRING COMMENT 'User identifier of the person who created the plan.',
    CONSTRAINT pk_interplant_supply_plan PRIMARY KEY(`interplant_supply_plan_id`)
) COMMENT 'Inter-plant supply plan record defining planned stock transfers and tolling arrangements between chemical manufacturing plants to balance supply and demand across the production network. Captures sending plant, receiving plant, material, planned transfer quantity, planned transfer date, transfer type (stock transfer, tolling, consignment), lead time, and plan status. Supports multi-plant supply network optimization in chemical manufacturing groups with multiple production sites.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` (
    `shelf_life_plan_id` BIGINT COMMENT 'Unique identifier for the shelf life planning record.',
    `horizon_id` BIGINT COMMENT 'Foreign key linking to planning.planning_horizon. Business justification: Shelf life planning is horizon‑specific; FK ties plan to its horizon.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Shelf‑life planning requires the material master to apply material‑specific expiry rules and storage conditions.',
    `superseded_shelf_life_plan_id` BIGINT COMMENT 'Self-referencing FK on shelf_life_plan (superseded_shelf_life_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the plan.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan was approved.',
    `approved_by` STRING COMMENT 'User identifier who approved the plan.',
    `at_risk_quantity` DECIMAL(18,2) COMMENT 'Quantity of material approaching expiry and at risk of non-compliance.',
    `at_risk_quantity_unit` STRING COMMENT 'Unit of measure for at-risk quantity.. Valid values are `kg|lb|L|gal`',
    `batch_size` DECIMAL(18,2) COMMENT 'Standard batch size for production runs related to the plan.',
    `batch_size_unit` STRING COMMENT 'Unit of measure for batch size.. Valid values are `kg|lb|L|gal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was created.',
    `disposition_recommendation` STRING COMMENT 'Recommended action for at-risk material.. Valid values are `expedite_sale|rework|disposal|hold`',
    `effective_end_date` DATE COMMENT 'Date when the plan expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes effective.',
    `expiry_date` DATE COMMENT 'Date the material expires based on shelf life.',
    `lot_number` STRING COMMENT 'Identifier for the production lot associated with the plan.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required by customer or market, expressed in days.',
    `mrsl_quantity` DECIMAL(18,2) COMMENT 'Quantity of product that must retain at least the minimum remaining shelf life.',
    `mrsl_unit` STRING COMMENT 'Unit of measure for MRSL quantity.. Valid values are `kg|lb|L|gal`',
    `notes` STRING COMMENT 'Free-text comments or remarks about the plan.',
    `plan_code` STRING COMMENT 'Business identifier code for the plan, used in ERP and planning systems.',
    `plan_type` STRING COMMENT 'Classification of the plan based on business purpose.. Valid values are `shelf_life|mrsl|expiry_driven`',
    `planned_consumption_date` DATE COMMENT 'Target date by which the material should be consumed to meet MRSL.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant associated with the plan.',
    `production_date` DATE COMMENT 'Date the material was produced, start of shelf life.',
    `revision_number` STRING COMMENT 'Version number of the plan for change tracking.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Safety stock amount to buffer against expiry risk.',
    `safety_stock_unit` STRING COMMENT 'Unit of measure for safety stock.. Valid values are `kg|lb|L|gal`',
    `shelf_life_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|closed|draft`',
    `storage_location` STRING COMMENT 'Warehouse location where the material is stored.',
    `updated_by` STRING COMMENT 'User identifier who last updated the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `created_by` STRING COMMENT 'User identifier who created the plan.',
    CONSTRAINT pk_shelf_life_plan PRIMARY KEY(`shelf_life_plan_id`)
) COMMENT 'Shelf life and expiry planning record managing the planning constraints imposed by chemical product shelf life, minimum remaining shelf life (MRSL) requirements, and expiry-driven demand. Captures material, lot, production date, expiry date, MRSL requirement by customer or market, planned consumption date, at-risk quantity (approaching expiry), and disposition recommendation (expedite sale, rework, disposal). Critical planning entity for specialty chemicals, agrochemicals, and performance materials with defined shelf lives.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_prior_demand_forecast_id` FOREIGN KEY (`prior_demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ADD CONSTRAINT `fk_planning_forecast_version_superseded_forecast_version_id` FOREIGN KEY (`superseded_forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ADD CONSTRAINT `fk_planning_sop_cycle_prior_sop_cycle_id` FOREIGN KEY (`prior_sop_cycle_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_sop_cycle_id` FOREIGN KEY (`sop_cycle_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`sop_cycle`(`sop_cycle_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ADD CONSTRAINT `fk_planning_sop_consensus_record_revised_sop_consensus_record_id` FOREIGN KEY (`revised_sop_consensus_record_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`sop_consensus_record`(`sop_consensus_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_prior_mrp_run_id` FOREIGN KEY (`prior_mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_pegged_planned_order_id` FOREIGN KEY (`pegged_planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ADD CONSTRAINT `fk_planning_mrp_exception_related_mrp_exception_id` FOREIGN KEY (`related_mrp_exception_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_exception`(`mrp_exception_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_revised_capacity_plan_id` FOREIGN KEY (`revised_capacity_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_superseded_production_plan_id` FOREIGN KEY (`superseded_production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_superseded_supply_plan_id` FOREIGN KEY (`superseded_supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_superseded_inventory_target_id` FOREIGN KEY (`superseded_inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ADD CONSTRAINT `fk_planning_demand_plan_adjustment_reversal_demand_plan_adjustment_id` FOREIGN KEY (`reversal_demand_plan_adjustment_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment`(`demand_plan_adjustment_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ADD CONSTRAINT `fk_planning_supply_demand_balance_prior_period_supply_demand_balance_id` FOREIGN KEY (`prior_period_supply_demand_balance_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_demand_balance`(`supply_demand_balance_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_rescheduled_production_schedule_id` FOREIGN KEY (`rescheduled_production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ADD CONSTRAINT `fk_planning_changeover_matrix_reverse_changeover_matrix_id` FOREIGN KEY (`reverse_changeover_matrix_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`changeover_matrix`(`changeover_matrix_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ADD CONSTRAINT `fk_planning_parameter_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ADD CONSTRAINT `fk_planning_parameter_inherited_parameter_id` FOREIGN KEY (`inherited_parameter_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`parameter`(`parameter_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ADD CONSTRAINT `fk_planning_horizon_parent_horizon_id` FOREIGN KEY (`parent_horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ADD CONSTRAINT `fk_planning_rough_cut_capacity_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ADD CONSTRAINT `fk_planning_rough_cut_capacity_revised_rough_cut_capacity_id` FOREIGN KEY (`revised_rough_cut_capacity_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`rough_cut_capacity`(`rough_cut_capacity_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_preceding_campaign_plan_id` FOREIGN KEY (`preceding_campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ADD CONSTRAINT `fk_planning_atp_check_recheck_atp_check_id` FOREIGN KEY (`recheck_atp_check_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`atp_check`(`atp_check_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_fallback_allocation_rule_id` FOREIGN KEY (`fallback_allocation_rule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_split_from_customer_allocation_id` FOREIGN KEY (`split_from_customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ADD CONSTRAINT `fk_planning_forecast_accuracy_record_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ADD CONSTRAINT `fk_planning_forecast_accuracy_record_prior_period_forecast_accuracy_record_id` FOREIGN KEY (`prior_period_forecast_accuracy_record_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record`(`forecast_accuracy_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ADD CONSTRAINT `fk_planning_constraint_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ADD CONSTRAINT `fk_planning_constraint_parent_constraint_id` FOREIGN KEY (`parent_constraint_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`constraint`(`constraint_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ADD CONSTRAINT `fk_planning_interplant_supply_plan_return_interplant_supply_plan_id` FOREIGN KEY (`return_interplant_supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`interplant_supply_plan`(`interplant_supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ADD CONSTRAINT `fk_planning_shelf_life_plan_horizon_id` FOREIGN KEY (`horizon_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`horizon`(`horizon_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ADD CONSTRAINT `fk_planning_shelf_life_plan_superseded_shelf_life_plan_id` FOREIGN KEY (`superseded_shelf_life_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`shelf_life_plan`(`shelf_life_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`planning` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`planning` SET TAGS ('dbx_domain' = 'planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `prior_demand_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Forecast Quantity (ADJ_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `baseline_quantity` SET TAGS ('dbx_business_glossary_term' = 'Baseline Forecast Quantity (BASE_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound (CI_LOWER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound (CI_UPPER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Forecast Confidence Level (CONF_LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source (SOURCE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'sales|market|internal|external');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Historical Forecast Accuracy (ACC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category (CATEGORY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'product|material|service');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Methodology (METHOD)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'statistical|machine_learning|consensus|expert');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_owner` SET TAGS ('dbx_business_glossary_term' = 'Forecast Owner');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_period_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_period_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Lifecycle Status (STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type (TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'demand|supply');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_version_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Release Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Final Forecast Indicator');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Forecast Locked Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket (BUCKET)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (HORIZON)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'short_term|mid_term|long_term');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario Name (SCENARIO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `scenario_name` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gallon|liter|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `superseded_forecast_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound (PCT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound (PCT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'sales_orders|historical|market_intel|customer_forecast');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_accuracy_target` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Target (PCT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_category` SET TAGS ('dbx_business_glossary_term' = 'Forecast Category');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_category` SET TAGS ('dbx_value_regex' = 'product_demand|material_requirements|capacity|sales');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'statistical|machine_learning|manual|hybrid');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_run_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_version_description` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Description');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_version_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `forecast_version_status` SET TAGS ('dbx_value_regex' = 'draft|active|archived|retracted');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `is_final_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `planning_horizon_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Forecast Scenario Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `total_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Forecasted Demand Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `total_demand_value` SET TAGS ('dbx_business_glossary_term' = 'Total Forecasted Demand Value');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gal|L|pcs');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Sales and Operations Planning (S&OP) Cycle ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `prior_sop_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `capacity_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `consensus_outcome` SET TAGS ('dbx_business_glossary_term' = 'Consensus Outcome');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `cycle_quarter` SET TAGS ('dbx_business_glossary_term' = 'Cycle Quarter');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Cycle Year');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `decision_summary` SET TAGS ('dbx_business_glossary_term' = 'Decision Summary');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `demand_forecast_version` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Phase');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'demand_review|supply_review|pre_sop|executive_sop');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'month|quarter|year');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `review_period` SET TAGS ('dbx_business_glossary_term' = 'Review Period');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `review_period` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `sop_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'S&OP Cycle Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `sop_cycle_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `supply_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `sop_consensus_record_id` SET TAGS ('dbx_business_glossary_term' = 'SOP Consensus Record ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `product_family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `sop_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `tertiary_sop_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `tertiary_sop_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `tertiary_sop_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `revised_sop_consensus_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `consensus_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Consensus Plan Number (CPN)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `constrained_supply_qty` SET TAGS ('dbx_business_glossary_term' = 'Constrained Supply Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|order|historical|market');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `demand_uom` SET TAGS ('dbx_business_glossary_term' = 'Demand Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `forecast_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Weeks)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `gap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand‑Supply Gap Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `gap_reason` SET TAGS ('dbx_business_glossary_term' = 'Gap Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `gap_reason` SET TAGS ('dbx_value_regex' = 'capacity|material|quality|logistics|other');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Product Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Description');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `sop_consensus_record_status` SET TAGS ('dbx_business_glossary_term' = 'Consensus Record Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `sop_consensus_record_status` SET TAGS ('dbx_value_regex' = 'draft|approved|rejected|in_review');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `sop_meeting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SOP Meeting Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `supply_source` SET TAGS ('dbx_value_regex' = 'inventory|production|procurement');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `supply_uom` SET TAGS ('dbx_business_glossary_term' = 'Supply Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `unconstrained_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Unconstrained Demand Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`sop_consensus_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'MRP Run ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Run User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `prior_mrp_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Run Comments');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Run Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `is_simulation` SET TAGS ('dbx_business_glossary_term' = 'Simulation Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `mrp_run_status` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `mrp_run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `planning_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Run Duration (Seconds)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Run Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regenerative|net_change|net_change_horizon');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_user_name` SET TAGS ('dbx_business_glossary_term' = 'Run User Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `run_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|Other');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `total_exception_messages` SET TAGS ('dbx_business_glossary_term' = 'Total Exception Messages');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `total_planned_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Orders');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `total_planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `total_purchase_requisitions` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Requisitions');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `pegged_planned_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|converted|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CHF');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Demand Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `firming_status` SET TAGS ('dbx_business_glossary_term' = 'Firming Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `firming_status` SET TAGS ('dbx_value_regex' = 'not_firmed|firmed|released');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `last_changed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Changed By User');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP Controller');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'planned|released|firmed|converted|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'production|purchase|stock_transfer');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'in_house|external|consignment');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'scheduled|unscheduled|blocked');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `mrp_exception_id` SET TAGS ('dbx_business_glossary_term' = 'MRP Exception ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Identifier (PLANNER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `related_mrp_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code (CAUSE_CD)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact (COST_IMPACT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `deviation_days` SET TAGS ('dbx_business_glossary_term' = 'Deviation Days (DEV_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number (EXC_NO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp (EXC_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type (EXC_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'reschedule_in|reschedule_out|cancel|new_order|shortage|excess_stock');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag (IS_CRITICAL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag (IS_DUP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By (REVIEWED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (REVIEWED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `mrp_exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status (EXC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `mrp_exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action (REC_ACTION)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status (RES_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp (RES_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Identifier (CAP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Owner Identifier (CAP_OWNER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WC_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `revised_capacity_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `available_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (Hours) (AVAIL_CAP_HRS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `available_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (Kilograms) (AVAIL_CAP_KG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `bottleneck_flag` SET TAGS ('dbx_business_glossary_term' = 'Bottleneck Indicator (BOTTLE_NECK_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Status (CAP_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|closed|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_source` SET TAGS ('dbx_business_glossary_term' = 'Source of Capacity Data (CAP_SOURCE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (CAP_UNIT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_value_regex' = 'hours|kg|tons');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `leveling_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Leveling Status (LEVELING_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `leveling_status` SET TAGS ('dbx_value_regex' = 'leveled|unleveled|pending');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Code (CAP_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Name (CAP_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Type (CAP_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'RCCP|CRP|RoughCut|Detailed');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date (PLAN_END)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date (PLAN_START)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario (SCENARIO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'base|optimistic|pessimistic');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `required_capacity_hours` SET TAGS ('dbx_business_glossary_term' = 'Required Capacity (Hours) (REQ_CAP_HRS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `required_capacity_kg` SET TAGS ('dbx_business_glossary_term' = 'Required Capacity (Kilograms) (REQ_CAP_KG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percentage (UTIL_PCT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `primary_production_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `primary_production_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `primary_production_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `superseded_production_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `capacity_utilization_target` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Target (%)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Plan Comments');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|sales_order|manual');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `ehs_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'EHS Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `freeze_horizon_flag` SET TAGS ('dbx_business_glossary_term' = 'Freeze Horizon Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `max_inventory_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `min_inventory_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Inventory Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'MPS|MRP|Capacity|Scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|yearly');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `production_method` SET TAGS ('dbx_business_glossary_term' = 'Production Method');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `production_method` SET TAGS ('dbx_value_regex' = 'batch|continuous|semi_batch');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gal|L|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Owner Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `tertiary_supply_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `tertiary_supply_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `tertiary_supply_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `superseded_supply_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `confirmed_supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Supply Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Constraint Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'capacity|material_shortage|lead_time|quality|regulatory');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|sales_order|customer_commitment');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `ehs_impact_score` SET TAGS ('dbx_business_glossary_term' = 'EHS Impact Score');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `last_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supply Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `plan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'aggregate|detail');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `planned_supply_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Supply Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `planning_methodology` SET TAGS ('dbx_business_glossary_term' = 'Planning Methodology');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `planning_methodology` SET TAGS ('dbx_value_regex' = 'mrp|heuristic|optimization|simulation');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Priority');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Plan Revision Reason');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_gap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supply Gap Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_source` SET TAGS ('dbx_value_regex' = 'production|procurement|transfer|stock');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|m3|ton|lb');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `inventory_target_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Target Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `compound_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `superseded_inventory_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Material Classification Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'raw|intermediate|finished');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `demand_forecast_qty` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `ehs_category` SET TAGS ('dbx_business_glossary_term' = 'EHS Category');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `max_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `safety_stock_percentage` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Percentage');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `target_days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Target Days of Supply');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|l|gal|m3|pcs');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `demand_plan_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Adjustment ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (APPROVER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PROD_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `primary_demand_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Identifier (PLNR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `primary_demand_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `primary_demand_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `reversal_demand_plan_adjustment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `adjusted_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Forecast Quantity (ADJ_FCST_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number (ADJ_NO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp (ADJ_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ADJ_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'manual|consensus|system');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name (APPROVER_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Comments (COMMENTS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `demand_plan_adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status (ADJ_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `demand_plan_adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (FCST_HORIZON)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Is Manual Adjustment (IS_MANUAL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Business Justification (JUSTIFICATION)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `original_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Forecast Quantity (ORIG_FCST_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `planner_name` SET TAGS ('dbx_business_glossary_term' = 'Planner Name (PLNR_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `quantity_delta` SET TAGS ('dbx_business_glossary_term' = 'Quantity Delta (QTY_DELTA)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (REASON_CD)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'demand_change|supply_constraint|new_product|seasonality|promotion|regulatory');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description (REASON_DESC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|Oracle_TMS|Manual');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_plan_adjustment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `supply_demand_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Demand Balance ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `prior_period_supply_demand_balance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `excess_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `maximum_inventory_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Inventory Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `opening_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Opening Stock Quantity (Quantity)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_dependent_demand_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Dependent Demand Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_issues_total` SET TAGS ('dbx_business_glossary_term' = 'Planned Issues Total');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_procurement_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Procurement Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_production_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_receipts_total` SET TAGS ('dbx_business_glossary_term' = 'Planned Receipts Total');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planned_sales_qty` SET TAGS ('dbx_business_glossary_term' = 'Planned Sales Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planning_period_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planning_period_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'Base|Optimistic|Pessimistic');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `projected_available_balance` SET TAGS ('dbx_business_glossary_term' = 'Projected Available Balance');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `reorder_point_qty` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `shortage_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortage Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `supply_demand_balance_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `supply_demand_balance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|g|l|ml');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_demand_balance` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `rescheduled_production_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `campaign_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percent');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `freeze_status` SET TAGS ('dbx_business_glossary_term' = 'Freeze Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_schedule_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_progress|completed|cancelled|frozen');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|semi_continuous');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gal|L');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `changeover_matrix_id` SET TAGS ('dbx_business_glossary_term' = 'Changeover Matrix ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `reverse_changeover_matrix_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `changeover_cost` SET TAGS ('dbx_business_glossary_term' = 'Changeover Cost (CC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `changeover_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Changeover Duration (Hours)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `changeover_matrix_status` SET TAGS ('dbx_business_glossary_term' = 'Changeover Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `changeover_matrix_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Type (CT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_value_regex' = 'CIP|flush|purge|none');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `from_product_code` SET TAGS ('dbx_business_glossary_term' = 'Source Product Code (SPC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `to_product_code` SET TAGS ('dbx_business_glossary_term' = 'Target Product Code (TPC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`changeover_matrix` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Parameter ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `inherited_parameter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Change Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `consumption_based_planning` SET TAGS ('dbx_business_glossary_term' = 'Consumption-Based Planning Indicator');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `in_house_production_time_days` SET TAGS ('dbx_business_glossary_term' = 'In-House Production Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `lot_size_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `lot_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Lot Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `lot_size_rounding` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Rounding Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Procedure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `lot_sizing_procedure` SET TAGS ('dbx_value_regex' = 'EX|HB|VB|FO|FOB|ND');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'MRP Controller');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|FO|HB|EX|ND');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Planning Parameter Description');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Planning Parameter Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (WERKS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|I');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `safety_time_days` SET TAGS ('dbx_business_glossary_term' = 'Safety Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `scheduling_margin_key` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Margin Key');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`parameter` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `parent_horizon_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `fence_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Fence Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `fence_type` SET TAGS ('dbx_value_regex' = 'hard|soft|none');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `fence_value` SET TAGS ('dbx_business_glossary_term' = 'Planning Fence Value');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_description` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Description');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_status` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `horizon_type` SET TAGS ('dbx_value_regex' = 'demand|mrp|freeze|firming|trading');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Horizon Indicator');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Length');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `length_unit` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Length Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `length_unit` SET TAGS ('dbx_value_regex' = 'days|weeks|months');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `planning_level` SET TAGS ('dbx_business_glossary_term' = 'Planning Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `planning_level` SET TAGS ('dbx_value_regex' = 'plant|product_family|material|site');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `rolling_flag` SET TAGS ('dbx_business_glossary_term' = 'Rolling Horizon Indicator');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`horizon` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `rough_cut_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Rough Cut Capacity Record ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `revised_rough_cut_capacity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (User ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `available_capacity` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (AC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `available_capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Unit (ACU)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `available_capacity_unit` SET TAGS ('dbx_value_regex' = 'hours|kg|m3|tonnes|liters');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `capacity_source` SET TAGS ('dbx_business_glossary_term' = 'Capacity Source (CSRC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `capacity_source` SET TAGS ('dbx_value_regex' = 'planned|actual|maintenance_schedule');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `constraint_severity` SET TAGS ('dbx_business_glossary_term' = 'Constraint Severity (CS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `constraint_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type (CT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'capacity|material|equipment|maintenance|quality');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `feasibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Flag (FF)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Is Locked');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `load_source` SET TAGS ('dbx_business_glossary_term' = 'Load Source (LS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `load_source` SET TAGS ('dbx_value_regex' = 'MPS|forecast|manual');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `planning_period_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `planning_period_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `required_load` SET TAGS ('dbx_business_glossary_term' = 'Required Load (RL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `required_load_unit` SET TAGS ('dbx_business_glossary_term' = 'Required Load Unit (RLU)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `required_load_unit` SET TAGS ('dbx_value_regex' = 'hours|kg|m3|tonnes|liters');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type (RT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'work_center|utility|raw_material|equipment');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (RN)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name (SN)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (User ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percent (UP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`rough_cut_capacity` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (User ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Production Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WORK_CENTER_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `preceding_campaign_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size (BATCH_SIZE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code (CAMPAIGN_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name (CAMPAIGN_NAME)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status (CAMPAIGN_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_trigger` SET TAGS ('dbx_business_glossary_term' = 'Campaign Trigger (CAMPAIGN_TRIGGER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_trigger` SET TAGS ('dbx_value_regex' = 'inventory_level|order_backlog|forecast|manual');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (COST_ESTIMATE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score (ENV_IMPACT_SCORE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Lock Flag (IS_LOCKED)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LOCATION_CODE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `minimum_campaign_length_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Campaign Length (Days) (MIN_CAMPAIGN_LENGTH_DAYS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `number_of_batches` SET TAGS ('dbx_business_glossary_term' = 'Number of Batches (NUM_BATCHES)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign End Date (PLANNED_END_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Campaign Start Date (PLANNED_START_DATE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level (PRIORITY_LEVEL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family (PRODUCT_FAMILY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU (PRODUCT_SKU)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMPLIANCE_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `schedule_priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority (SCHEDULE_PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `total_planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Quantity (TOTAL_PLANNED_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|g|l|ml');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `atp_check_id` SET TAGS ('dbx_business_glossary_term' = 'Available-to-Promise Check ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `recheck_atp_check_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `allocation_rule` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `atp_check_status` SET TAGS ('dbx_business_glossary_term' = 'ATP Check Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `atp_check_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|error');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `atp_method` SET TAGS ('dbx_business_glossary_term' = 'ATP Method');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `atp_method` SET TAGS ('dbx_value_regex' = 'simple|multi_level|ctp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch/Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'ATP Check Number (ATPCHK)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'ATP Check Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `confirmed_uom` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `demand_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `demand_source` SET TAGS ('dbx_value_regex' = 'forecast|order|manual');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_backorder_allowed` SET TAGS ('dbx_business_glossary_term' = 'Backorder Allowed Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_batch_constrained` SET TAGS ('dbx_business_glossary_term' = 'Batch Constraint Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_capacity_constrained` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_lot_constrained` SET TAGS ('dbx_business_glossary_term' = 'Lot Constraint Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_material_availability` SET TAGS ('dbx_business_glossary_term' = 'Material Availability Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_shortage_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortage Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `is_simulation` SET TAGS ('dbx_business_glossary_term' = 'Simulation Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'ATP Check Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `planning_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `requested_uom` SET TAGS ('dbx_business_glossary_term' = 'Requested Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `shortage_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shortage Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `shortage_uom` SET TAGS ('dbx_business_glossary_term' = 'Shortage Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `supply_source` SET TAGS ('dbx_business_glossary_term' = 'Supply Source');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `supply_source` SET TAGS ('dbx_value_regex' = 'inventory|production|procurement');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`atp_check` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `tertiary_allocation_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `tertiary_allocation_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `tertiary_allocation_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `fallback_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'historical_share|contract_priority|strategic_tier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|fixed|priority');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Allocation Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_business_glossary_term' = 'Allocation Scope');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_scope` SET TAGS ('dbx_value_regex' = 'customer|region|channel');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Allocation Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `max_allocation_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allocation Per Customer');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `min_allocation_per_customer` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allocation Per Customer');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `total_available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Available Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|ton|gal|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Version');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `customer_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Identifier (CA_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier (AR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PROD_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `split_from_customer_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity (ALLOC_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_uom` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|L|gal|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_value` SET TAGS ('dbx_business_glossary_term' = 'Allocated Monetary Value (ALLOC_VAL)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Allocated Value Currency (ALLOC_VAL_CURR)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocated_value_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date (END_DT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Version (AR_VER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source (ALC_SRC)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'system|user|external');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date (START_DT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status (ALC_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|fulfilled|expired|cancelled|pending');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type (ALC_TYPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'contract|forecast|manual|reallocation');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_version` SET TAGS ('dbx_business_glossary_term' = 'Allocation Version (ALC_VER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approved By (APPROVED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approval Timestamp (APPROVED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (COMPL_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity (CONS_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `consumed_uom` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `consumed_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|L|gal|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp (EFFECTIVE_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `ehs_category` SET TAGS ('dbx_business_glossary_term' = 'EHS Category (EHS_CAT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `ehs_category` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|restricted|controlled');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp (EXPIRATION_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Allocation Lock Flag (IS_LOCKED)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes (NOTES)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Level (PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status (REG_STATUS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity (REMAIN_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `remaining_uom` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `remaining_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|L|gal|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status Reason (ALC_REASON)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_accuracy_record_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Record Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `prior_period_forecast_accuracy_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `accuracy_tier` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Tier Classification');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `accuracy_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `bias` SET TAGS ('dbx_business_glossary_term' = 'Forecast Bias');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `error_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Error Threshold Percent');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon (Weeks)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'ARIMA|ExponentialSmoothing|MachineLearning|Statistical');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `forecast_source` SET TAGS ('dbx_business_glossary_term' = 'Forecast Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `is_outlier` SET TAGS ('dbx_business_glossary_term' = 'Outlier Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `mad` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Deviation (MAD)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `mape` SET TAGS ('dbx_business_glossary_term' = 'Mean Absolute Percentage Error (MAPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'demand|consumption');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Scenario Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `wmape` SET TAGS ('dbx_business_glossary_term' = 'Weighted Mean Absolute Percentage Error (WMAPE)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_accuracy_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` SET TAGS ('dbx_subdomain' = 'capacity_management');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Constraint ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `parent_constraint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `affected_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'material|work_center|utility|process|product');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_category` SET TAGS ('dbx_business_glossary_term' = 'Constraint Category');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_category` SET TAGS ('dbx_value_regex' = 'capacity|availability|quality|safety|environment');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_name` SET TAGS ('dbx_business_glossary_term' = 'Constraint Name');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_business_glossary_term' = 'Constraint Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'raw_material|reactor_capacity|utility_limit|regulatory|minimum_batch|shelf_life');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration (Hours)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `impact_area` SET TAGS ('dbx_business_glossary_term' = 'Impact Area');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Constraint Origin');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Constraint Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `related_batch_lot` SET TAGS ('dbx_business_glossary_term' = 'Related Batch/Lot');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`constraint` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `interplant_supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Interplant Supply Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (CAS/ERP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `return_interplant_supply_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Plan Approved By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Until Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Plan Flag');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Interplant Supply Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|released|cancelled|completed');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Transfer Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `planned_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Transfer Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|L|gal|m3');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `sending_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'stock_transfer|tolling|consignment');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`interplant_supply_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` SET TAGS ('dbx_subdomain' = 'supply_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `shelf_life_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `horizon_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `superseded_shelf_life_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `at_risk_quantity` SET TAGS ('dbx_business_glossary_term' = 'At-Risk Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `at_risk_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'At-Risk Quantity Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `at_risk_quantity_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `batch_size_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `disposition_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Disposition Recommendation');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `disposition_recommendation` SET TAGS ('dbx_value_regex' = 'expedite_sale|rework|disposal|hold');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `mrsl_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `mrsl_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `mrsl_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Plan Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'shelf_life|mrsl|expiry_driven');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `planned_consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Consumption Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `safety_stock_unit` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Unit');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `safety_stock_unit` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `shelf_life_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `shelf_life_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|draft');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`shelf_life_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
