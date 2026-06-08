-- Schema for Domain: planning | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`planning` COMMENT 'Demand planning, sales and operations planning (S&OP), material requirements planning (MRP), capacity planning, and production scheduling for chemical manufacturing operations. Manages demand forecasts, supply-demand balancing, and capacity allocation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` (
    `demand_forecast_id` BIGINT COMMENT 'Unique system-generated identifier for each demand forecast version.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer‑specific demand forecast drives sales planning and supply allocation; key accounts require separate forecasts for accurate production scheduling.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Demand forecasts drive revenue budget plans in chemical manufacturing. Linking demand_forecast to budget_plan supports top-down/bottom-up budget reconciliation, S&OP financial review, and revenue fore',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: REQUIRED: Demand Forecast reports are generated per chemical product; linking enables product‑level demand planning and variance analysis.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Site-level demand planning is standard in chemical manufacturing — bulk delivery forecasts are tied to specific customer receiving sites (tank farms, bulk terminals). Planners need site-level forecast',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Demand forecasts in chemical manufacturing are period-bound planning documents. Linking to fiscal_period enables revenue forecast-to-actual variance reporting, period-close demand reconciliation, and ',
    `forecast_version_id` BIGINT COMMENT 'Foreign key linking to planning.forecast_version. Business justification: Each demand forecast belongs to a specific forecast version; linking enables version control and eliminates redundant version fields.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Demand forecasts in chemical manufacturing are grade-specific — customers forecast ACS reagent grade separately from technical grade. Without a grade FK, the forecast cannot drive grade-level producti',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Demand Forecasting uses the material master to tie forecast SKUs to the authoritative material record, ensuring accurate planning and regulatory reporting.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: S&OP demand forecast uses high‑value sales opportunities to project future demand, a core process linking sales pipeline to planning.',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: In chemical manufacturing S&OP, demand forecasts are owned, submitted, and approved by sales organizations. This link is required for forecast consolidation by sales org, quota-vs-forecast variance re',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Demand forecasts in chemical manufacturing are often packaging-specific — customers forecast 500 drums vs. 20 IBCs separately. Without a packaging_config FK, the forecast cannot drive packaging materi',
    `prior_demand_forecast_id` BIGINT COMMENT 'Self-referencing FK on demand_forecast (prior_demand_forecast_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Demand forecasts in chemical manufacturing are profit-center scoped for revenue planning and P&L budgeting. Linking demand_forecast to profit_center enables revenue budget alignment, profit center-lev',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: Demand forecasts for qualified products must reference the qualification record to enforce approved volume limits (max_approved_volume_kg, min_approved_volume_kg). Planners use qualification-constrain',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Segment-level demand forecasting is a core S&OP process in chemical manufacturing — planners build forecasts by customer segment (automotive, ag-chem, construction) to drive production planning. A dom',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: REQUIRED: SKU‑level forecasts drive packaging and logistics planning; FK ties forecast rows to the definitive SKU master.',
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
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Forecast versions in chemical manufacturing are created for specific fiscal periods (monthly, quarterly rolling forecasts). Linking forecast_version to fiscal_period enables period-based forecast accu',
    `organization_id` BIGINT COMMENT 'Foreign key linking to sales.sales_organization. Business justification: Forecast versions in chemical manufacturing S&OP are submitted and approved per sales organization. The approval workflow, version comparison reports, and forecast accuracy KPIs are all structured by ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` (
    `mrp_run_id` BIGINT COMMENT 'Unique identifier for the MRP run execution.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: MRP runs in chemical manufacturing are executed within fiscal planning periods. Linking mrp_run to fiscal_period enables period-based MRP analysis, budget consumption tracking per period, and audit tr',
    `prior_mrp_run_id` BIGINT COMMENT 'Self-referencing FK on mrp_run (prior_mrp_run_id)',
    `production_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the MRP run was executed.',
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
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: In chemical manufacturing MRP, planned orders are pegged to specific supply contracts when contract-based procurement is active. This drives contract consumption tracking, ensures planned orders respe',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Planned orders in chemical manufacturing are executed within specific cost centers. MRP cost roll-up, cost center budget consumption tracking, and planned vs. actual cost reporting at the cost center ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Planned orders for R&D batches, trial runs, or capital projects in chemical manufacturing are funded via internal orders. Linking planned_order to internal_order enables cost settlement from MRP-gener',
    `maintenance_plant_id` BIGINT COMMENT 'Foreign key linking to maintenance.plant. Business justification: Planned orders generated by MRP are always plant-specific. plant_code on planned_order is a denormalized reference violating 3NF. Linking to maintenance.plant enables MRP controllers to access plant m',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Planned orders are firmed and converted to manufacturing orders in chemical manufacturing. Planners need this link to track planned-to-actual order conversion, manage firming horizons, and report on M',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: MRP planned order generation in chemical mfg requires the approved material specification (purity, assay, grade) to set procurement quality requirements. Planners and buyers reference the spec when fi',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: Every planned order in SAP PP/MRP is generated by a specific MRP run execution. This is a fundamental 1:N relationship: one MRP run generates many planned orders. The mrp_run_id FK on planned_order li',
    `pegged_planned_order_id` BIGINT COMMENT 'Self-referencing FK on planned_order (pegged_planned_order_id)',
    `material_master_id` BIGINT COMMENT 'Unique system identifier of the material to be produced or procured.',
    `purchase_order_id` BIGINT COMMENT 'FK to supply.purchase_order.purchase_order_id — MRP planned orders convert to purchase orders — without this FK, procurement cannot trace which POs originated from MRP requirements. Blocks MRP-to-procurement traceability.',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: MRP-generated planned orders in chemical manufacturing carry a cost_estimate derived from standard costs for the material. Linking planned_order to standard_cost enables cost roll-up, purchase price v',
    `vendor_id` BIGINT COMMENT 'System identifier of the external vendor for purchase-type planned orders.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Planned orders for externally procured chemicals must reference the specific vendor site — not just the vendor — to accurately determine lead times, hazmat handling capability, and logistics routing. ',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Unique surrogate key for each capacity planning record.',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Capacity plans in chemical manufacturing require budget authorization for capital expenditure (new equipment, overtime, debottlenecking). Linking capacity_plan to budget_plan enables capacity investme',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Capacity plans in chemical manufacturing are often product-specific — planning capacity for a specific chemical product line (e.g., epoxy resins, specialty solvents) is standard for S&OP reporting. A ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capacity planning costs are charged to cost centers; required for Capacity Cost Allocation report.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Capacity plans in chemical manufacturing are scoped to specific process equipment (reactors, columns). Available capacity hours must account for equipment criticality, maintenance strategy, and inspec',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Capacity plans in chemical manufacturing are time-bounded and aligned to fiscal periods for resource budgeting and utilization reporting. Period-based capacity cost absorption and utilization variance',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Capacity plans must deduct planned maintenance downtime from available_capacity_hours. PM plan cycle_length and next_scheduled_date directly reduce available capacity. This is standard capacity planni',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Capacity planning is performed in the context of a production plan: the required_capacity_hours and required_capacity_kg on capacity_plan are derived from the production_plans planned quantities. Lin',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Capacity plans are defined at plant level in chemical manufacturing. Without a plant FK, capacity plans cannot be aggregated or filtered by site. Multi-site capacity planning, plant investment decisio',
    `revised_capacity_plan_id` BIGINT COMMENT 'Self-referencing FK on capacity_plan (revised_capacity_plan_id)',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center, reactor, or line the capacity plan applies to.',
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
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to production.bill_of_materials. Business justification: Production plans reference BOMs to drive material requirements planning. Chemical manufacturing S&OP processes use BOM data to calculate raw material demand, plan procurement, and estimate production ',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Production plans in chemical manufacturing must be authorized against approved budget plans. Budget-to-actual variance reporting for production costs and S&OP financial review depend on linking produc',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the finished chemical product or intermediate being planned.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Production Cost Allocation report linking each production plan to the cost center that funds it.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Production plans for PSM-covered chemical processes are tied to specific equipment (reactors, vessels). Planners must verify equipment status, next inspection date, and maintenance strategy before com',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Production plans are scoped to a specific EHS facility. The ehs_impact_flag and regulatory_compliance_flag on production_plan are evaluated against facility-level permit limits and inspection status d',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Production plans in chemical manufacturing are aligned to fiscal periods for budget absorption, period-end cost reporting, and production variance analysis. Financial controllers require this link for',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Production plans are executed at specific functional locations; FK enables location‑specific capacity and compliance tracking.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Production plans in chemical manufacturing are grade-specific — pharmaceutical-grade vs. technical-grade batches require different process parameters, QC checkpoints, and regulatory compliance steps. ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Production plans for capital projects, plant turnarounds, or new product trials in chemical manufacturing are funded via internal orders. Linking production_plan to internal_order enables cost settlem',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Production planning links each plan to the material master for bill‑of‑materials, hazard classification, and traceability.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Production planning in chemical mfg ties to the approved material specification governing input quality for the planned batch. Regulatory compliance checks, batch record preparation, and capacity plan',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: The Master Production Schedule (MPS) / production_plan is generated or updated as an output of MRP run execution. Linking production_plan to the mrp_run that authorized it provides full planning trace',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Production plans for regulated chemicals are validated against specific operating permit emission limits and annual throughput caps. The regulatory_compliance_flag on production_plan is assessed again',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Production plans in chemical manufacturing include packaging as part of the plan — the packaging configuration determines filling line assignment, batch size constraints, and packaging material requir',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Production plans must be coordinated with preventive maintenance plans to avoid scheduling production during planned downtime windows. In chemical manufacturing, production planners explicitly referen',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: Production plans for PSM-covered chemicals must reference process safety information to ensure planned quantities and operating conditions are within safe limits. The ehs_impact_flag on production_pla',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Production plans in chemical manufacturing must reference the product specification to ensure planned production meets required quality parameters. The specification defines acceptance criteria, test ',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Production plans are plant-specific in chemical manufacturing. The existing plant_code is a denormalized plain attribute; replacing with a proper FK to production.plant enables plant-level production ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Needed for Profit Center performance analysis; production plans contribute to profit center results.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: Production plans reference routings to estimate capacity requirements and lead times during S&OP planning. Chemical manufacturing planners use routing cycle times and work center assignments to valida',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Production plans in chemical manufacturing are executed at the SKU level — the plan must specify which pack size/configuration is being produced to schedule the correct filling line, packaging materia',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Production plan cost estimates in chemical manufacturing are computed from standard costs (planned_quantity × standard_cost). Standard cost variance analysis (actual vs. standard) is a core chemical m',
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
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Supply plans in chemical manufacturing drive procurement spend that must be tracked against approved budget plans. Procurement cost control, spend variance analysis, and period-end budget consumption ',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: REQUIRED: Supply plans must be aligned to specific chemical products to balance procurement, production, and regulatory compliance.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: Supply plans in chemical manufacturing are constrained by and built upon existing supply contracts (volume commitments, pricing, delivery windows). Planners must reference the governing contract to en',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Supply procurement spend is allocated to cost centers for budgeting and variance analysis.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to planning.demand_forecast. Business justification: The supply plan is the constrained supply response to a demand signal. Linking supply_plan to the demand_forecast it is responding to is the core S&OP relationship: demand drives supply. This FK enabl',
    `distributor_id` BIGINT COMMENT 'Foreign key linking to sales.distributor. Business justification: Supply planning incorporates distributor agreements and volume commitments, requiring a link to the distributor entity.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Supply plans for hazardous materials are facility-scoped. The ehs_impact_score on supply_plan is assessed against facility-level permit thresholds and on-site quantity limits. EHS teams review supply ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Supply plans in chemical manufacturing are period-bound. Linking to fiscal_period enables procurement spend tracking per fiscal period, period-end supply plan variance reporting, and cash flow plannin',
    `functional_location_id` BIGINT COMMENT 'Identifier of the manufacturing plant or site for which the plan is created.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Supply plans in chemical manufacturing must specify grade because sourcing, lead times, and supplier qualifications differ by grade. A supply plan for pharmaceutical-grade material has different procu',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Supply plans for capital procurement or special projects in chemical manufacturing are funded via internal orders. Linking supply_plan to internal_order enables procurement cost settlement and budget ',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material or product family covered by the supply plan.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Supply planning for chemicals must reference the approved specification to validate that planned supply sources meet quality requirements. Supply planners use spec data (purity grade, analytical limit',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: The integrated supply plan is a constrained output derived from MRP run results. Linking supply_plan to the mrp_run that generated it enables S&OP teams to trace which MRP execution produced each supp',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Supply plans for hazardous raw materials are constrained by operating permit on-site inventory limits and receipt quantity caps. The compliance_flag on supply_plan is evaluated against specific permit',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Supply plans are plant-specific in chemical manufacturing — each plant has its own supply constraints, capacities, and regulatory permits. Linking supply plans to plants enables multi-site supply plan',
    `reach_registration_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.reach_registration. Business justification: Supply planning for REACH-regulated substances in EU chemical manufacturing must verify registration status and tonnage band compliance. Planners need to confirm planned supply quantities do not excee',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Supply plans in chemical manufacturing are built to serve specific customer segments as part of S&OP. Segment-level supply planning enables demand-supply balancing by market vertical (automotive, cons',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Supply plans in chemical manufacturing are often SKU-specific — sourcing a product in 200L drums vs. bulk tanker has different lead times, approved suppliers, and logistics constraints. SKU-level supp',
    `superseded_supply_plan_id` BIGINT COMMENT 'Self-referencing FK on supply_plan (superseded_supply_plan_id)',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Supply plans in chemical manufacturing designate a specific vendor as the planned source of supply for raw materials. Planners validate vendor lead times, compliance certifications, and capacity again',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Supply plans for chemical raw materials must specify the vendor site to accurately model lead times, hazmat handling capability, and logistics constraints. Site-level detail is critical in chemical ma',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory valuation and safety‑stock cost tracking require linking targets to the responsible cost center.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to planning.demand_forecast. Business justification: inventory_target already has a demand_forecast_qty attribute, indicating it is directly driven by demand forecast data. Formalizing this as a FK to demand_forecast links the inventory policy (safety s',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Inventory targets for hazardous chemicals must not exceed facility-level permit thresholds (RMP/PSM on-site quantity limits, Tier II reporting). The ehs_category and regulatory_compliance_flag on inve',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Inventory targets in chemical manufacturing are set per planning period aligned to fiscal periods. Period-end inventory valuation, working capital reporting, and inventory budget variance analysis all',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Safety stock and reorder points differ by grade in chemical manufacturing — pharmaceutical grades require tighter inventory controls and shorter shelf-life management than technical grades. Inventory ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Inventory Target calculations require the material master to derive safety stock, reorder points, and compliance flags per material.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Safety stock and reorder point calculations in chemical mfg depend on specification parameters — shelf life, retest interval, and storage conditions directly drive min/max inventory targets. Planners ',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Inventory targets for regulated chemicals are directly constrained by operating permit maximum on-site quantity thresholds (RMP threshold quantities, RCRA storage limits). The regulatory_compliance_fl',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Inventory targets are defined per plant in chemical manufacturing. The existing plant_code is denormalized; a proper FK to production.plant enables plant-level inventory policy reporting, multi-site s',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Inventory targets in chemical manufacturing are set by customer segment — strategic segments (e.g., automotive OEMs) require higher days-of-supply buffers. Segment-level inventory target setting is a ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Inventory targets in chemical manufacturing are set at the SKU level because different pack sizes have different storage footprints, shelf lives, and reorder economics. A 200L drum and a 1000L IBC of ',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Inventory targets in chemical manufacturing include cost_per_unit derived from standard costs. Linking inventory_target to standard_cost enables inventory valuation at standard cost, working capital r',
    `superseded_inventory_target_id` BIGINT COMMENT 'Self-referencing FK on inventory_target (superseded_inventory_target_id)',
    `batch_number` STRING COMMENT 'Identifier for the batch associated with the inventory target, if applicable.',
    `classification_type` STRING COMMENT 'Category of material indicating its role in the production process.. Valid values are `raw|intermediate|finished`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory target record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost values.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the production schedule record.',
    `campaign_plan_id` BIGINT COMMENT 'Foreign key linking to planning.campaign_plan. Business justification: production_schedule already has a campaign_flag boolean indicating whether a schedule belongs to a campaign. When campaign_flag=true, the schedule should reference the campaign_plan it belongs to. Thi',
    `chemical_product_id` BIGINT COMMENT 'Identifier of the chemical product to be manufactured in this schedule.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production schedules in chemical manufacturing are executed within specific cost centers (reactor lines, mixing units). Cost absorption, scheduling reports, and cost center budget consumption tracking',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Production schedule slots in chemical manufacturing are assigned to specific process equipment. Maintenance windows on that equipment directly determine schedule feasibility. Schedulers must check equ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Production schedules drive real-time emissions and waste generation at a specific EHS facility. EHS teams use production schedules to forecast permit utilization and schedule compliance monitoring. Di',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Production schedules in chemical manufacturing are grade-specific — scheduling a USP-grade batch vs. technical-grade requires different equipment setup, cleaning validation, and QC hold times. The sch',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Individual production schedule runs in chemical manufacturing (R&D batches, trial production, capital project runs) are charged to internal orders. This link enables cost allocation from production ex',
    `manufacturing_order_id` BIGINT COMMENT 'FK to production.manufacturing_order.manufacturing_order_id — Cannot link production plan to execution without this FK — planners need to see which scheduled items have been released as manufacturing orders. Critical for plan-vs-actual reporting.',
    `packaging_config_id` BIGINT COMMENT 'Foreign key linking to product.packaging_config. Business justification: Production schedules must reference packaging configuration to schedule the correct filling/packaging line and calculate changeover times. In chemical manufacturing, switching between drum fills and I',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Production schedules must be built around PM plan call dates to avoid scheduling production during planned maintenance windows. In chemical plants, PM-scheduled downtime is a hard scheduling constrain',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Production schedules in GMP chemical manufacturing reference product specifications to configure in-process quality checks and final release testing. The schedule must be tied to the approved specific',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: The production_schedule is the detailed, time-phased execution schedule derived from the production_plan (MPS). This is a fundamental planning hierarchy: production_plan (MPS level) → production_sched',
    `production_plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the schedule will be executed.',
    `rescheduled_production_schedule_id` BIGINT COMMENT 'Self-referencing FK on production_schedule (rescheduled_production_schedule_id)',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: Production schedules reference routings to sequence operations and assign work centers in chemical manufacturing. Schedulers use routing operation sequences and standard times to build feasible produc',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: The production_schedule is the detailed execution of the supply plans production component. Linking production_schedule to the supply_plan it executes closes the planning-to-execution loop: supply_pl',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or reactor where the production run will be executed.',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` (
    `campaign_plan_id` BIGINT COMMENT 'Unique identifier for the production campaign plan.',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to production.bill_of_materials. Business justification: Campaign plans reference BOMs to determine material requirements for the planned campaign. Chemical manufacturing campaign planners need BOM data to calculate raw material procurement needs, plan mate',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Production campaigns in chemical manufacturing are significant cost events requiring budget authorization. Campaign cost estimates must be validated against approved budget plans for cost control and ',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Campaign plans in chemical manufacturing are organized around a specific chemical product (e.g., multi-batch campaign for a specialty polymer). The existing product_family plain-text column is a denor',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: Campaign plans in chemical manufacturing are frequently triggered by or aligned with supply/toll manufacturing contracts specifying volume, timing, and quality requirements. Campaign planners referenc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Campaign budgeting is managed through cost centers; needed for Campaign Cost Tracking report.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Campaign plans in chemical manufacturing are executed on specific process equipment. Campaign planners must verify equipment maintenance status and next calibration date before locking planned_start_d',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Campaign plans for chemical batch production are executed at a specific EHS facility. EHS teams assess campaign environmental_impact_score against facility permit limits and emergency response readine',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Campaign plans in chemical manufacturing are time-bounded and aligned to fiscal periods for cost budgeting and campaign performance reporting. Period-based campaign cost absorption and financial varia',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Campaign plans in chemical manufacturing are grade-specific — a campaign to produce pharmaceutical-grade material requires different equipment qualification, cleaning validation, and regulatory docume',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: Chemical manufacturing requires HAZOP study sign-off before a production campaign is approved. The regulatory_compliance_flag on campaign_plan depends on a completed, approved HAZOP for the planned pr',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Production campaigns in chemical manufacturing (specialty chemicals, new product launches) are frequently funded and tracked via internal orders. Linking campaign_plan to internal_order enables campai',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Campaign planning for batch production references the material master to ensure correct safety data sheet and regulatory compliance.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Campaign planning for chemical production requires the approved material specification to define acceptable input quality for the entire campaign. GMP-regulated chemical manufacturers reference the sp',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Campaign plans must avoid overlapping with PM plan windows. Campaign planners in chemical manufacturing check PM schedules before setting planned_start_date and planned_end_date. A campaign running in',
    `preceding_campaign_plan_id` BIGINT COMMENT 'Self-referencing FK on campaign_plan (preceding_campaign_plan_id)',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: Campaign Planning process requires linking each campaign plan to the actual production campaign record for execution tracking.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: A campaign_plan (multi-batch production campaign) is authorized by and derived from a production_plan (MPS). The campaign_plans total_planned_quantity and planned dates must align with the production',
    `production_plant_id` BIGINT COMMENT 'Unique identifier of the plant hosting the campaign.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: Campaign plans reference production routings to determine operation sequences, cycle times, and resource requirements for campaign scheduling. Chemical manufacturing campaign planners use routing data',
    `safety_data_sheet_id` BIGINT COMMENT 'Reference to the associated Safety Data Sheet.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Production campaigns in chemical manufacturing are frequently triggered by segment-level demand (e.g., an agricultural-grade campaign driven by the ag-chem segments seasonal demand). Linking campaign',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Campaign plans reference product_sku as plain text. In chemical manufacturing, campaigns are planned at the SKU level (specific pack size/grade combination). A proper FK to sku enables campaign-to-SKU',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Campaign cost estimates in chemical manufacturing are built from standard costs per unit multiplied by planned quantity. Linking campaign_plan to standard_cost supports campaign cost roll-up, cost est',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: Campaign planning in chemical mfg specifies which approved supplier material (specific grade from a qualified supplier) will be used for the campaign. This is essential for GMP compliance, supplier qu',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or reactor where the campaign is executed.',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` (
    `allocation_rule_id` BIGINT COMMENT 'System-generated unique identifier for the allocation rule.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Allocation rules in chemical manufacturing are product-specific — a rule defines how available supply of a specific chemical product is distributed among customers during shortage. Without a chemical_',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to planning.demand_forecast. Business justification: Allocation rules are triggered by demand exceeding constrained supply. Linking allocation_rule to the demand_forecast that revealed the supply-demand gap provides the demand context for the allocation',
    `fallback_allocation_rule_id` BIGINT COMMENT 'Self-referencing FK on allocation_rule (fallback_allocation_rule_id)',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Allocation rules in chemical manufacturing are effective for specific planning periods aligned to fiscal periods. Period-based allocation reporting and financial reconciliation of allocated vs. actual',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Allocation rules in chemical mfg govern how limited supply of a specific material is distributed across customers or plants. A material-specific allocation rule (e.g., for a constrained specialty chem',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Allocation rules in chemical manufacturing are defined at segment level during supply constraints — strategic segments (e.g., automotive, pharma) receive priority allocation. Segment-based allocation ',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: An allocation_rule is created specifically when supply is constrained — it defines how the constrained supply from a supply_plan is distributed across customers. Linking allocation_rule to the supply_',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Territory-scoped allocation rules are standard in chemical manufacturing S&OP — regional supply constraints require allocation rules specific to sales territories. Planners and sales managers jointly ',
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
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Allocations in chemical manufacturing are fulfilled to specific customer delivery sites. Site-level allocation tracking is required for logistics scheduling, EHS compliance (hazmat receiving capabilit',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Customer allocations in chemical manufacturing are period-specific. Linking to fiscal_period enables period-end allocation revenue recognition, financial reconciliation of allocated vs. invoiced volum',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Customer allocations in chemical manufacturing are grade-specific — a customer allocated 10 MT may specifically need USP grade, not technical grade. Without a grade FK, allocation cannot enforce grade',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: During supply constraints in chemical manufacturing, customer allocations are prioritized by opportunity stage and strategic value. S&OP allocation decisions require tracing which opportunity drives e',
    `price_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.price_agreement. Business justification: Price agreements in chemical manufacturing define contracted volume commitments that directly govern customer allocation entitlements. Allocation planners must reference the price agreement to enforce',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Customer allocations in chemical manufacturing generate revenue attributed to profit centers for P&L reporting. Linking customer_allocation to profit_center enables revenue allocation reporting by pro',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: In chemical manufacturing, product allocations must be gated by customer qualification records — a customer can only receive an allocated product/grade they are qualified for. This qualification-gated',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Customer allocations in specialty chemical manufacturing are grade/spec-specific — pharmaceutical-grade vs. industrial-grade product is allocated to different customers under different quality specifi',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Customer allocations are naturally at the SKU level in chemical manufacturing — a customer is allocated a specific pack size and grade combination. The existing chemical_product_id FK is too coarse; S',
    `split_from_customer_allocation_id` BIGINT COMMENT 'Self-referencing FK on customer_allocation (split_from_customer_allocation_id)',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: customer_allocation is the transactional record assigning allocated quantities to specific customers from a constrained supply. Linking customer_allocation to the supply_plan it draws from closes the ',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_forecast_version_id` FOREIGN KEY (`forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ADD CONSTRAINT `fk_planning_demand_forecast_prior_demand_forecast_id` FOREIGN KEY (`prior_demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ADD CONSTRAINT `fk_planning_forecast_version_superseded_forecast_version_id` FOREIGN KEY (`superseded_forecast_version_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`forecast_version`(`forecast_version_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ADD CONSTRAINT `fk_planning_mrp_run_prior_mrp_run_id` FOREIGN KEY (`prior_mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ADD CONSTRAINT `fk_planning_planned_order_pegged_planned_order_id` FOREIGN KEY (`pegged_planned_order_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`planned_order`(`planned_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ADD CONSTRAINT `fk_planning_capacity_plan_revised_capacity_plan_id` FOREIGN KEY (`revised_capacity_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`capacity_plan`(`capacity_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ADD CONSTRAINT `fk_planning_production_plan_superseded_production_plan_id` FOREIGN KEY (`superseded_production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_mrp_run_id` FOREIGN KEY (`mrp_run_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`mrp_run`(`mrp_run_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ADD CONSTRAINT `fk_planning_supply_plan_superseded_supply_plan_id` FOREIGN KEY (`superseded_supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ADD CONSTRAINT `fk_planning_inventory_target_superseded_inventory_target_id` FOREIGN KEY (`superseded_inventory_target_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`inventory_target`(`inventory_target_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_campaign_plan_id` FOREIGN KEY (`campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_rescheduled_production_schedule_id` FOREIGN KEY (`rescheduled_production_schedule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ADD CONSTRAINT `fk_planning_production_schedule_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_preceding_campaign_plan_id` FOREIGN KEY (`preceding_campaign_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`campaign_plan`(`campaign_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ADD CONSTRAINT `fk_planning_campaign_plan_production_plan_id` FOREIGN KEY (`production_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`production_plan`(`production_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_fallback_allocation_rule_id` FOREIGN KEY (`fallback_allocation_rule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ADD CONSTRAINT `fk_planning_allocation_rule_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_allocation_rule_id` FOREIGN KEY (`allocation_rule_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`allocation_rule`(`allocation_rule_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_split_from_customer_allocation_id` FOREIGN KEY (`split_from_customer_allocation_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`customer_allocation`(`customer_allocation_id`);
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ADD CONSTRAINT `fk_planning_customer_allocation_supply_plan_id` FOREIGN KEY (`supply_plan_id`) REFERENCES `chemical_mfg_ecm`.`planning`.`supply_plan`(`supply_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`planning` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`planning` SET TAGS ('dbx_domain' = 'planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` SET TAGS ('dbx_subdomain' = 'demand_forecasting');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `forecast_version_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `prior_demand_forecast_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`demand_forecast` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`forecast_version` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` SET TAGS ('dbx_subdomain' = 'requirements_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'MRP Run ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `prior_mrp_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`mrp_run` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` SET TAGS ('dbx_subdomain' = 'requirements_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `maintenance_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `pegged_planned_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`planned_order` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'requirements_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Identifier (CAP_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `revised_capacity_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`capacity_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WC_ID)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_plan` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` SET TAGS ('dbx_subdomain' = 'requirements_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `distributor_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `reach_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Registration Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `superseded_supply_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`supply_plan` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` SET TAGS ('dbx_subdomain' = 'requirements_planning');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `inventory_target_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Target Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `superseded_inventory_target_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Material Classification Type');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'raw|intermediate|finished');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`inventory_target` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `packaging_config_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Config Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `rescheduled_production_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`production_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` SET TAGS ('dbx_subdomain' = 'production_scheduling');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `preceding_campaign_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Production Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Identifier (SDS_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WORK_CENTER_ID)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (REG_COMPLIANCE_FLAG)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `schedule_priority` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority (SCHEDULE_PRIORITY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `total_planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Quantity (TOTAL_PLANNED_QTY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|g|l|ml');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`campaign_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (CREATED_BY)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` SET TAGS ('dbx_subdomain' = 'supply_allocation');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `fallback_allocation_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`allocation_rule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` SET TAGS ('dbx_subdomain' = 'supply_allocation');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `customer_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Allocation Identifier (CA_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `allocation_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rule Identifier (AR_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (PROD_ID)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `price_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Price Agreement Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `split_from_customer_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`planning`.`customer_allocation` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
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
