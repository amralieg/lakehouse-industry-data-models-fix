-- Schema for Domain: production | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`production` COMMENT 'Core manufacturing execution domain governing shop floor control, work orders, routing, scheduling, WIP tracking, cycle time, takt time, throughput, and OEE. Integrates with MES (Siemens Opcenter) and ERP (SAP PP) to orchestrate production runs, machine assignments, capacity planning, and shift-level output reporting via SCADA/DCS systems.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`production_work_order` (
    `production_work_order_id` BIGINT COMMENT 'Unique identifier for the production work order. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for make-to-order production, if applicable.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In engineer-to-order and project manufacturing, work orders are created for a specific customer installation site. The account_site captures the physical facility receiving the manufactured system. Pr',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Subcontracting compliance: subcontracted work orders are executed under a supplier scheduling agreement or outline agreement. Linking enables contract utilization tracking, price validation, and compl',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Work orders are released against a specific product BOM header to drive component picks, material staging, and cost rollups. The product.bom_header is the product-domain BOM governing production execu',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: Configure-to-order and engineer-to-order work orders must reference the specific product configuration being built. The configuration drives BOM selection, routing, and assembly instructions. Industri',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: Work orders reference the applicable control plan to ensure operators follow specified process controls and measurement requirements. Standard ERP-QMS integration in automotive and industrial manufact',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Cost of Goods Sold reporting; each work order must be allocated to a cost center for accurate product costing.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Work orders must be traceable to the engineering change order that triggered production for compliance and cost impact analysis.',
    `engineering_bom_line_id` BIGINT COMMENT 'Reference to the specific BOM revision used for this production run, defining the component structure and quantities.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Work orders are executed against approved engineering specifications defining dimensional tolerances and process parameters. ISO 9001/IATF 16949 requires traceability from production work order to the',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Production work orders are executed on specific equipment; linking to equipment_register enables OEE calculation per work order, maintenance-production coordination, and equipment utilization reportin',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Order‑driven work‑order execution requires linking each work order to its sales order for scheduling and cost allocation.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Work order release requires referencing the applicable inspection plan to drive in-process quality checks. IATF 16949 and AS9100 mandate traceability from production order to inspection plan. Standard',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Required for OEE and safety reporting to capture the physical location where each production work order is executed.',
    `material_master_id` BIGINT COMMENT 'Reference to the finished or semi-finished good being produced in this work order.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Work orders are created to fulfill specific MRP material requirements. Pegging work orders to material requirements is a core ERP function enabling demand traceability, order confirmation, and net req',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Order‑to‑Production report requires linking each work order to the originating sales opportunity for fulfillment tracking.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Work orders execute against supply plans. Supply planners need to reconcile work order actuals (actual_cost, yield_rate, scrap) against the originating supply plan for plan adherence KPIs. planned_ord',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: MRP creates planned orders then converts them to production work orders; linking enables traceability in the Production Order Execution Report.',
    `product_revision_id` BIGINT COMMENT 'Foreign key linking to product.product_revision. Business justification: ISO 9001 and AS9100 traceability requirements mandate recording which product revision was manufactured on each work order. Product revision determines applicable BOM effectivity, PPAP requirements, a',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A work order runs on a specific production line; the FK replaces the free‑text line identifier.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Work orders in industrial manufacturing are assigned to profit centers for product costing and P&L attribution. Standard SAP CO-PC configuration requires work order-to-profit-center assignment for seg',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI and prototype work orders are directly tied to engineering projects. Production planners need to track which engineering project a pilot or first-article work order supports, enabling project cost',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Required for traceability of external component procurement to a work order, used in scheduling and cost reporting.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: A work order is executed according to a specific manufacturing routing that defines the sequence of operations. production_work_order.routing_number (STRING) is a denormalized reference to routing.rou',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Production‑to‑Sales reconciliation needs a direct FK from work order to the sales order intake that generated it, replacing the denormalized sales_order_number.',
    `shift_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: A work order is scheduled for a particular shift; the FK provides a proper relational link.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Work orders must be linked to the SKU produced for inventory, costing, and sales order fulfillment reporting.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: SLA agreements define on-time delivery targets, quality thresholds, and penalty clauses that directly govern work order prioritization and execution in industrial manufacturing. Production managers re',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific storage location where finished goods from this work order will be received.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Work Order Supplier Performance Report requires linking each work order to its primary supplier for quality and delivery metrics.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Subcontracting work order routing: subcontract work orders are dispatched to a specific supplier site, not just the supplier. Site determines capacity, lead time, and quality certification. Industrial',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or plant location where production is executed.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: A work order is assigned to a primary work center for execution. This is a fundamental manufacturing relationship — work orders are dispatched to specific work centers for capacity loading and schedul',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this work order, including material, labor, and overhead.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution was completed on the shop floor.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished goods produced and confirmed, in base unit of measure.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution began on the shop floor.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the output of this work order for traceability and quality control.. Valid values are `^[A-Z0-9]{1,20}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this work order was formally closed and all confirmations finalized.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work order completion based on actual quantity versus planned quantity (0.00 to 100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this work order.. Valid values are `^[A-Z]{3}$`',
    `cycle_time_minutes` DECIMAL(18,2) COMMENT 'Actual cycle time in minutes to produce one unit, used for OEE calculation and capacity planning.',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime in minutes during work order execution, impacting OEE availability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this work order record was last modified.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Calculated OEE percentage for this work order, combining availability, performance, and quality metrics (0.00 to 100.00).',
    `planned_finish_date` DATE COMMENT 'Scheduled date when production is planned to be completed for this work order.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of finished goods to be produced by this work order, in base unit of measure.',
    `planned_start_date` DATE COMMENT 'Scheduled date when production is planned to begin for this work order.',
    `priority_code` STRING COMMENT 'Scheduling priority assigned to this work order, determining its sequence in the production queue.. Valid values are `urgent|high|normal|low`',
    `production_notes` STRING COMMENT 'Free-text notes capturing special instructions, issues, or observations during work order execution.',
    `release_date` DATE COMMENT 'Date when the work order was released to the shop floor for execution.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of material scrapped or rejected during production, in base unit of measure.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of material scrapped or rejected during production (0.00 to 100.00).',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Actual time in minutes required to set up equipment and tooling before production begins.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Planned standard cost per unit for this production run, used for variance analysis.',
    `takt_time_minutes` DECIMAL(18,2) COMMENT 'Target takt time in minutes per unit, representing the rate at which products must be completed to meet customer demand.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantities (e.g., EA for each, KG for kilogram, L for liter).. Valid values are `^[A-Z]{2,6}$`',
    `wip_value` DECIMAL(18,2) COMMENT 'Current financial value of work in progress for this order, including material, labor, and overhead costs.',
    `work_order_number` STRING COMMENT 'Externally-known unique business identifier for the work order, typically generated by ERP or MES systems.. Valid values are `^[A-Z0-9]{8,20}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the manufacturing execution workflow. [ENUM-REF-CANDIDATE: created|released|in_progress|completed|closed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by production purpose: standard production, rework, prototype, maintenance, or sample run.. Valid values are `standard|rework|prototype|maintenance|sample`',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of good units produced versus total units started, used for OEE quality calculation (0.00 to 100.00).',
    CONSTRAINT pk_production_work_order PRIMARY KEY(`production_work_order_id`)
) COMMENT 'Core manufacturing work order representing a discrete production job issued to the shop floor. Authorizes manufacture of a specific quantity of finished or semi-finished goods by linking a routing, BOM revision, and production version. Tracks planned vs. actual dates, priority, order status, WIP value, and completion percentage. The SSOT for all production execution activity within this domain. Sourced from ERP production orders (e.g., SAP PP) and MES work order management (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Scheduling agreement releases: in automotive and industrial manufacturing, production schedules generate delivery schedule lines against supplier scheduling agreements. This link enables contract rele',
    `bom_id` BIGINT COMMENT 'Reference to the bill of materials used for this scheduled production. Defines the material components and structure.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: Production scheduling in configure-to-order manufacturing must reference the specific product configuration to correctly determine lead time, routing, and BOM. Capacity planning and MRP scheduling dep',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production schedules are planned against cost centers for capacity cost planning and budget variance reporting. In industrial manufacturing MRP/production planning, schedule-to-cost-center assignment ',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Production schedules must be locked to a specific engineering revision to prevent scheduling against superseded designs. PPAP and IATF 16949 require revision-level traceability on all scheduled produc',
    `header_id` BIGINT COMMENT 'Reference to the customer order driving this production schedule, if make-to-order. Null for make-to-stock schedules.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Production scheduling requires knowing the applicable inspection plan to plan quality resource capacity (inspectors, gauges) alongside production. APQP and advanced quality planning in industrial manu',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Associates production schedule with the plant location to enable plant‑level capacity planning and compliance reporting.',
    `material_master_id` BIGINT COMMENT 'Reference to the material or product being scheduled for production.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: MRP generates material requirements that directly trigger production schedules. Pegging — tracing a schedule back to the material requirement that drove it — is a core MRP function required for demand',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Production schedules are generated as output of MRP runs. Tracing a schedule to its originating MRP run is essential for audit, exception management, and replanning when MRP parameters change. No exis',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Production schedules in industrial manufacturing are directly driven by confirmed sales order intakes. This link enables ATP (Available-to-Promise) reporting, delivery commitment tracking, and MRP peg',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Production scheduling is directly driven by supply plans in MRP/ERP. Planners need to trace schedule adherence back to the originating supply plan for variance analysis and replanning decisions. No ex',
    `plant_data_id` BIGINT COMMENT 'Foreign key linking to product.plant_data. Business justification: MRP-driven production scheduling directly consumes plant_data parameters: MRP type, lot size procedure, safety stock, reorder point, and in-house production time. Linking production_schedule to plant_',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.asset_pm_schedule. Business justification: Production schedulers must coordinate with planned maintenance windows to avoid scheduling production during PM activities. This maintenance-production conflict avoidance is a named process in industr',
    `production_work_order_id` BIGINT COMMENT 'Reference to the production order generated from this schedule. Links planning to execution.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production schedules drive planned output mapped to profit centers for product-line P&L reporting. Industrial manufacturing profit center accounting requires linking scheduled production volumes to th',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI production schedules are governed by engineering project timelines. Program managers track scheduled production milestones against engineering project gates (e.g., SOP, pilot build). No existing F',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Supply-demand pegging: production schedules for externally sourced or subcontracted items are pegged to purchase orders. This link supports MRP pegging reports, supply chain visibility, and on-time de',
    `routing_id` BIGINT COMMENT 'Reference to the production routing or process plan used for this schedule. Defines the sequence of operations and work centers.',
    `schedule_line_id` BIGINT COMMENT 'Foreign key linking to order.schedule_line. Business justification: MRP pegging: production schedules are generated to fulfill specific order schedule lines (confirmed delivery dates/quantities). This ATP and MRP pegging relationship is fundamental to industrial manuf',
    `shift_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: A production schedule is planned for a specific shift. production_schedule.shift_assignment (STRING) is a denormalized reference to the shift. Adding shift_id as a proper FK normalizes this relationsh',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Master production schedules are created per SKU; linking enables MPS reporting and demand planning.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line assigned to execute this schedule.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this schedule requires management approval before release. True for high-value, high-risk, or exception schedules; false for routine schedules.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule was cancelled. Null if the schedule was not cancelled.',
    `capacity_requirement_hours` DECIMAL(18,2) COMMENT 'Total machine or labor hours required to complete this schedule. Used for capacity planning and load leveling.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when production for this schedule was completed. Used for schedule performance analysis and cycle time measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was first created in the system. Used for audit trail and schedule age analysis.',
    `firmed_flag` BOOLEAN COMMENT 'Indicates whether this schedule is firmed (locked) and should not be automatically rescheduled by planning systems. True means the schedule is manually controlled; false means it can be adjusted by MRP/APS.',
    `freeze_horizon_date` DATE COMMENT 'Date beyond which this schedule is frozen and cannot be changed without formal approval. Protects near-term execution from planning volatility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was last updated. Tracks schedule volatility and planning changes.',
    `lead_time_days` STRING COMMENT 'Total lead time from schedule release to completion, including queue time, setup, run, and move time. Used for order promising and planning.',
    `lot_size_quantity` DECIMAL(18,2) COMMENT 'Standard lot or batch size for this production schedule. May be driven by economic order quantity, equipment constraints, or process requirements.',
    `lot_sizing_rule` STRING COMMENT 'Algorithm used to determine production lot sizes. Fixed lot uses a constant quantity; lot-for-lot matches demand exactly; EOQ optimizes ordering costs; POQ aggregates demand over periods.. Valid values are `fixed_lot|lot_for_lot|economic_order_quantity|period_order_quantity`',
    `mrp_controller` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this schedule. Used for accountability and workload distribution.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Free-text notes and comments from planners regarding special instructions, constraints, or considerations for this schedule.',
    `pegging_reference` STRING COMMENT 'Reference to the demand source (sales order, forecast, safety stock) that this schedule is pegged to. Enables traceability from supply to demand.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of the material to be produced according to this schedule. Expressed in the base unit of measure for the material.',
    `planning_bucket` STRING COMMENT 'Time granularity of the schedule planning horizon. Daily for short-term detailed scheduling, weekly for medium-term planning, monthly for long-term capacity planning.. Valid values are `daily|weekly|monthly`',
    `planning_horizon_weeks` STRING COMMENT 'Number of weeks into the future that this schedule covers. Defines the forward visibility window for production planning.',
    `planning_strategy` STRING COMMENT 'Manufacturing strategy governing how this schedule is planned and executed. Make-to-stock builds for inventory; make-to-order builds against customer orders; assemble-to-order configures from standard components; engineer-to-order designs and builds custom products.. Valid values are `make_to_stock|make_to_order|assemble_to_order|engineer_to_order`',
    `priority_rank` STRING COMMENT 'Relative priority of this schedule compared to other schedules. Lower numbers indicate higher priority. Used for resource allocation and sequencing decisions.',
    `released_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule was released for execution. Marks the transition from planning to active production.',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to produce the planned quantity, excluding setup and teardown. Used for cycle time analysis.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained to protect against demand variability and supply disruptions. Influences schedule timing and quantities.',
    `schedule_number` STRING COMMENT 'Business identifier for the production schedule. Externally visible schedule reference number used in planning and execution systems.. Valid values are `^MPS-[0-9]{8}-[0-9]{4}$`',
    `schedule_source` STRING COMMENT 'System or process that generated this schedule. MRP run for material requirements planning; APS optimization for advanced planning and scheduling; manual planning for planner-created schedules; demand forecast for forecast-driven schedules; customer order for order-driven schedules.. Valid values are `mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule. Draft schedules are under planning; released schedules are active; frozen schedules are locked for execution; revised schedules have been updated; cancelled schedules are voided; completed schedules are finished.. Valid values are `draft|released|frozen|revised|cancelled|completed`',
    `schedule_type` STRING COMMENT 'Classification of the schedule by planning level. MPS for top-level finished goods; FAS for final assembly operations; RCCP for high-level capacity validation; MRP for detailed component planning.. Valid values are `master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan`',
    `scheduled_finish_date` DATE COMMENT 'Planned date when production for this schedule is expected to be completed. Used for order promising and delivery planning.',
    `scheduled_finish_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to finish, used for detailed capacity loading and sequencing.',
    `scheduled_start_date` DATE COMMENT 'Planned date when production for this schedule is expected to begin. Key input for capacity planning and material availability checks.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise timestamp when production execution is scheduled to start, including shift and time-of-day information for detailed shop floor scheduling.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'Estimated time required to set up equipment and tooling before production can begin. Part of total lead time calculation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the planned quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters).. Valid values are `^[A-Z]{2,3}$`',
    `version` STRING COMMENT 'Version number of the schedule. Incremented each time the schedule is revised or replanned.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Master production schedule (MPS) record defining planned production quantities, start/finish dates, and shift assignments for a given production item across a planning horizon. Tracks schedule version, freeze horizon, planning bucket (daily/weekly), and schedule status (draft, released, frozen, revised). Represents the output of APS/MRP II scheduling runs. Sourced from ERP production planning (e.g., SAP PP) and APS systems (e.g., Microsoft Dynamics 365 Supply Chain).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center for financial tracking and allocation of work center expenses.',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Work centers operate under process qualification specifications (welding procedure specs, machine capability studies, PPAP process specs). Linking work centers to their governing engineering specifica',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this work center is located.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Work centers in industrial manufacturing controlling are assigned to profit centers for activity cost allocation and profitability analysis. Standard CO-OM configuration links work centers to profit c',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Line-side stock (supermarket/kanban staging) is assigned per work center in lean industrial manufacturing. Replenishment planning, kanban card generation, and WIP material staging reports all require ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: External/subcontracted work center: in industrial manufacturing, a work center can be designated as an external processing work center permanently assigned to a specific subcontract supplier. This is ',
    `available_capacity_per_shift` DECIMAL(18,2) COMMENT 'Standard available capacity of the work center per shift, measured in the capacity category unit.',
    `capacity_category` STRING COMMENT 'Unit of measure for capacity planning (e.g., machine hours, labor hours, throughput units).. Valid values are `machine_hours|labor_hours|units_per_hour|setup_hours`',
    `capacity_planning_group` STRING COMMENT 'Grouping code for aggregating work centers in capacity planning and leveling activities.. Valid values are `^[A-Z0-9]{2,8}$`',
    `control_key` STRING COMMENT 'Control key defining how operations are processed at this work center (e.g., internal processing, external processing, inspection).. Valid values are `^[A-Z0-9]{2,4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system.',
    `efficiency_rate_percent` DECIMAL(18,2) COMMENT 'Standard efficiency rate of the work center expressed as a percentage, representing the ratio of actual output to theoretical maximum output.',
    `formula_key` STRING COMMENT 'Formula key used for calculating operation times and capacity requirements at this work center.. Valid values are `^[A-Z0-9]{2,6}$`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this work center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last modified.',
    `location_description` STRING COMMENT 'Physical location description of the work center within the plant (e.g., Building 2, Floor 3, Bay 5).',
    `mes_integration_enabled` BOOLEAN COMMENT 'Indicates whether this work center is integrated with the MES for real-time shop floor control and data collection.',
    `number_of_machines` STRING COMMENT 'Count of individual machines or equipment units within this work center.',
    `number_of_operators` STRING COMMENT 'Standard number of operators or workers assigned to this work center during normal operation.',
    `oee_baseline_target_percent` DECIMAL(18,2) COMMENT 'Target OEE baseline for this work center, calculated as Availability × Performance × Quality. Used for capacity planning and performance benchmarking.',
    `plc_address` STRING COMMENT 'Network address or identifier of the PLC controlling this work center, used for SCADA and MES integration.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether operations at this work center require mandatory quality inspection before proceeding to the next step.',
    `scada_tag_prefix` STRING COMMENT 'SCADA tag prefix used to identify real-time data points from this work center in the process control system.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `scheduling_type` STRING COMMENT 'Scheduling strategy used for operations at this work center (forward scheduling, backward scheduling, or capacity-only).. Valid values are `forward|backward|midpoint|only_capacity_requirements`',
    `standard_processing_time_minutes` DECIMAL(18,2) COMMENT 'Standard processing or cycle time in minutes per unit for operations performed at this work center.',
    `standard_queue_time_hours` DECIMAL(18,2) COMMENT 'Standard queue time in hours representing the typical wait time before an operation begins at this work center.',
    `standard_setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup or changeover time in minutes required to prepare the work center for a new production run.',
    `standard_teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard teardown time in minutes required to complete and clean up after an operation at this work center.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Target utilization rate of the work center expressed as a percentage, representing the ratio of actual operating time to available time.',
    `valid_from_date` DATE COMMENT 'Date from which this work center configuration is effective and available for production planning.',
    `valid_to_date` DATE COMMENT 'Date until which this work center configuration is effective. Null indicates indefinite validity.',
    `work_center_category` STRING COMMENT 'Classification of the work center type indicating the nature of the production resource.. Valid values are `machine|assembly_line|production_cell|labor_group|inspection_station|packaging_line`',
    `work_center_code` STRING COMMENT 'Business identifier for the work center used in ERP and MES systems. Externally-known unique code for capacity planning and routing assignments.. Valid values are `^[A-Z0-9]{4,12}$`',
    `work_center_name` STRING COMMENT 'Human-readable name or description of the work center (e.g., Assembly Line 3, CNC Machining Cell A, Welding Station 5).',
    `work_center_status` STRING COMMENT 'Current lifecycle status of the work center indicating its operational availability.. Valid values are `active|inactive|maintenance|decommissioned|planned`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this work center record in the system.',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master data entity representing a physical or logical production resource on the shop floor — a machine, assembly cell, production line segment, or labor group — at which manufacturing operations are performed. Captures work center code, plant, cost center linkage, capacity category, available capacity per shift, efficiency rate, utilization rate, and OEE baseline target. The SSOT for capacity planning and routing assignments within the production domain. Sourced from ERP work center master (e.g., SAP CR01).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the manufacturing routing. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Subcontract routing costing: external processing routing operations are priced and governed by supplier agreements. Linking routing to agreement enables standard cost calculation for subcontracted ste',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials (BOM) that defines the material components consumed by this routing. Links routing to BOM for integrated production planning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Routings define standard costs per operation assigned to cost centers for activity-based costing and standard cost calculation. In industrial manufacturing product costing, routing-to-cost-center assi',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: ECNs with routing_impact_flag=true directly trigger routing updates. Traceability from the updated routing back to the ECN that caused the change is a standard engineering change management requiremen',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Routings are revision-controlled and must align with the engineering revision of the product. When an ECN changes a component, the routing is updated and must reference the new revision. Standard PLM/',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Routing operations reference engineering/process specifications for critical parameters (weld specs, torque values, surface finish). Process engineers link routings to governing specifications for ope',
    `material_master_id` BIGINT COMMENT 'Reference to the material or finished good that this routing produces. Links to the material master in inventory domain.',
    `plant_id` BIGINT COMMENT 'Manufacturing plant or facility where this routing is executed. Links to plant master data.',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Subcontracted operations: routing operations in industrial manufacturing can be externally processed (e.g., heat treatment, plating, machining). The routing must reference the subcontract supplier to ',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Subcontract operation site: external processing routing steps are performed at a specific supplier site, which determines lead time, capacity, and quality certification requirements. Site-level routin',
    `approval_date` DATE COMMENT 'Date on which this routing was approved for production use.',
    `approval_status` STRING COMMENT 'Current approval status of the routing. Pending routings await review; approved routings are authorized for production; rejected routings require rework; under_review routings are in the approval workflow.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this routing for production use.',
    `base_quantity` DECIMAL(18,2) COMMENT 'Standard lot size or batch quantity for which the routing times and resource requirements are defined. All operation times are calculated relative to this base quantity.',
    `base_unit_of_measure` STRING COMMENT 'Unit of measure for the base quantity. Standard ISO unit codes such as EA (each), KG (kilogram), L (liter), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `change_number` STRING COMMENT 'Engineering Change Notice (ECN) or Engineering Change Order (ECO) number that authorized the creation or last modification of this routing. Supports traceability of process changes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard cost amount.. Valid values are `^[A-Z]{3}$`',
    `counter` STRING COMMENT 'Sequential counter within the routing group. Together with routing_group, forms an alternative business key.. Valid values are `^[0-9]{1,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was first created in the system.',
    `is_default_routing` BOOLEAN COMMENT 'Indicates whether this routing is the default routing for the material. True if this is the primary routing; false if it is an alternative.',
    `is_phantom_routing` BOOLEAN COMMENT 'Indicates whether this is a phantom routing that is automatically consumed without generating a separate production order. Used for subassemblies that are immediately incorporated into parent assemblies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this routing record was last modified.',
    `last_used_date` DATE COMMENT 'Most recent date on which this routing was used in a production order or work order. Used to identify obsolete or inactive routings.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'Minimum lot size for which this routing is applicable. Supports lot-size-dependent routing selection.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'Maximum lot size for which this routing is applicable. Null indicates no upper limit.',
    `planner_group` STRING COMMENT 'Production planning team or planner responsible for maintaining and scheduling this routing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `routing_description` STRING COMMENT 'Detailed textual description of the routing purpose, scope, and special instructions. Provides context for production planners and shop floor operators.',
    `routing_group` STRING COMMENT 'Grouping code for related routings. Used to organize routings by product family, process type, or manufacturing cell.. Valid values are `^[A-Z0-9]{1,8}$`',
    `routing_number` STRING COMMENT 'Business identifier for the routing. Externally visible routing code used in production planning and shop floor documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Draft routings are under development; released routings are approved for use; active routings are currently in production; inactive routings are temporarily suspended; obsolete routings are retired; blocked routings are prohibited from use.. Valid values are `draft|released|active|inactive|obsolete|blocked`',
    `routing_text` STRING COMMENT 'Extended free-form text field for detailed routing notes, special handling instructions, safety warnings, and quality requirements.',
    `routing_type` STRING COMMENT 'Classification of the routing purpose. Production routings define standard manufacturing sequences; inspection routings define quality check sequences; rework routings define repair processes; universal routings apply across multiple materials; rate routings define continuous process flows; reference routings serve as templates.. Valid values are `production|inspection|rework|universal|rate|reference`',
    `scheduling_type` STRING COMMENT 'Scheduling strategy for this routing. Forward scheduling starts from the earliest start date; backward scheduling works back from the required finish date; midpoint scheduling balances around a target date.. Valid values are `forward|backward|midpoint`',
    `source_system` STRING COMMENT 'System of record from which this routing was sourced. SAP_PP indicates SAP S/4HANA Production Planning; TEAMCENTER indicates Siemens Teamcenter PLM; OPCENTER indicates Siemens Opcenter MES; MANUAL indicates manually entered routing.. Valid values are `SAP_PP|TEAMCENTER|OPCENTER|MANUAL`',
    `source_system_code` STRING COMMENT 'Unique identifier of this routing in the source system. Used for data lineage and reconciliation.',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard cost to execute this routing for the base quantity. Includes labor, machine, overhead, and tooling costs. Used for cost accounting and variance analysis.',
    `total_labor_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative labor time in minutes across all operations for the base quantity. Labor time may scale differently than machine time.',
    `total_lead_time_hours` DECIMAL(18,2) COMMENT 'Total cumulative lead time in hours required to complete all operations in this routing for the base quantity. Includes setup, machine, labor, and queue times.',
    `total_machine_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative machine processing time in minutes across all operations for the base quantity. Machine time scales with lot size.',
    `total_operation_count` STRING COMMENT 'Total number of operations (steps) defined in this routing. Derived from routing operation line items.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Total cumulative setup time in minutes across all operations for the base quantity. Setup time is independent of lot size.',
    `usage` STRING COMMENT 'Intended application context for the routing. Standard routings are the default production method; alternative routings provide backup processes; trial routings support pilot runs; prototype routings support R&D; emergency routings address contingency scenarios.. Valid values are `standard|alternative|trial|prototype|emergency`',
    `usage_count` STRING COMMENT 'Total number of times this routing has been used in production orders or work orders. Indicates routing popularity and stability.',
    `valid_from_date` DATE COMMENT 'Effective start date from which this routing is valid and can be used in production planning and execution.',
    `valid_to_date` DATE COMMENT 'Effective end date after which this routing is no longer valid. Null indicates indefinite validity.',
    `version` STRING COMMENT 'Version identifier for the routing. Supports versioning of routing definitions to track engineering changes and process improvements.. Valid values are `^[A-Z0-9]{1,4}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Manufacturing routing master defining the ordered sequence of operations required to produce a finished or semi-finished item. Captures routing number, routing type (production, inspection, universal), base quantity, status, and validity dates. Each routing is composed of individual operations (modeled as line items) linked to work centers with standard times for setup, machine run, and labor. The SSOT for standard production process definitions. Sourced from ERP routing master (e.g., SAP CA01) and PLM process plans (e.g., Siemens Teamcenter).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique identifier for the shift definition record. Primary key.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Links shift to its site location, enabling shift‑level labor cost and safety incident aggregation per plant.',
    `work_center_id` BIGINT COMMENT 'Reference to the specific work center or production line where this shift is applicable. Nullable if the shift applies plant-wide. Used for capacity planning and machine-specific scheduling.',
    `break_duration_minutes` STRING COMMENT 'Sum of all scheduled break periods (lunch, rest breaks) within the shift, in minutes. Subtracted from gross duration to calculate net available time for production.',
    `break_schedule` STRING COMMENT 'Textual description of the break structure, including start times and durations (e.g., 10:00-10:15 (15 min), 12:00-12:30 (30 min)). Used for communication to shop floor personnel and HMI display.',
    `changeover_allowance_minutes` STRING COMMENT 'Standard time reserved within the shift for product changeovers, tool changes, or setup activities. Used to adjust net available time for multi-product shifts and to calculate planned downtime for OEE.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift definition record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_size` STRING COMMENT 'Standard number of operators or workers assigned to this shift pattern. Used for labor capacity planning and cost allocation. Nullable if crew size varies by work center.',
    `days_of_week` STRING COMMENT 'Comma-separated list of weekday codes (MON, TUE, WED, THU, FRI, SAT, SUN) indicating which days this shift pattern applies to. Used for weekly capacity planning and workforce rostering.',
    `effective_end_date` DATE COMMENT 'Date after which this shift definition is no longer valid. Nullable for open-ended shift patterns. Used to retire obsolete shift definitions while preserving historical data.',
    `effective_start_date` DATE COMMENT 'Date from which this shift definition becomes active and can be used for production scheduling. Supports versioning of shift patterns over time.',
    `end_time` TIMESTAMP COMMENT 'Time of day when the shift ends, in HH:mm:ss format (24-hour clock). May be less than start_time for shifts that cross midnight. Used to calculate gross shift duration.',
    `gross_duration_minutes` STRING COMMENT 'Total elapsed time of the shift from start to end, in minutes, including all breaks and non-productive time. Used as the denominator for availability calculations.',
    `handover_duration_minutes` STRING COMMENT 'Planned overlap time between consecutive shifts for handover communication, equipment status review, and safety briefing. Subtracted from net available time if included in shift boundaries. Nullable for non-continuous operations.',
    `is_continuous_operation` BOOLEAN COMMENT 'Indicates whether this shift is part of a 24/7 continuous manufacturing operation (True) or a discrete batch operation (False). Used to determine handover requirements and WIP tracking rules.',
    `labor_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base labor rates for this shift type (e.g., 1.0 for regular, 1.5 for overtime, 2.0 for holiday). Used for labor cost calculation and variance analysis.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this shift definition record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift definition record was last updated. Used for audit trail and to track the currency of master data.',
    `net_available_minutes` STRING COMMENT 'Net productive time available for manufacturing execution, calculated as gross_duration_minutes minus break_duration_minutes. Used as the planned production time for OEE availability calculation and takt time planning.',
    `notes` STRING COMMENT 'Free-text field for additional information about the shift pattern, special instructions, or exceptions. Used for communication to planners and supervisors.',
    `number_of_breaks` STRING COMMENT 'Count of distinct break periods scheduled within the shift (e.g., 2 for a shift with one lunch break and one rest break). Used for workforce scheduling and labor compliance reporting.',
    `planned_output_quantity` DECIMAL(18,2) COMMENT 'Target production volume for this shift, in base unit of measure. Used as the denominator for performance OEE calculation and as input to takt time calculation. Nullable for non-production shifts.',
    `priority` STRING COMMENT 'Numeric priority ranking for shift selection when multiple shift definitions are valid for the same time period (lower number = higher priority). Used by APS systems to resolve scheduling conflicts.',
    `rotation_pattern` STRING COMMENT 'Description of the multi-day or multi-week rotation cycle this shift belongs to (e.g., 2-2-3 Continental, 4-on-4-off, DuPont 12-hour). Used for long-term workforce scheduling and fatigue management.',
    `sequence` STRING COMMENT 'Ordinal position of this shift within a daily rotation (e.g., 1 for first shift, 2 for second shift, 3 for third shift). Used for shift handover reporting and continuous production tracking.',
    `shift_category` STRING COMMENT 'Broad categorization of shift purpose. Production shifts are used for manufacturing execution and OEE calculation; non-production shifts (e.g., maintenance, training) are excluded from throughput metrics; mixed shifts include both activities.. Valid values are `production|non_production|mixed`',
    `shift_code` STRING COMMENT 'Unique business identifier for the shift pattern (e.g., DAY_1, NIGHT_A, SWING_2). Used as the externally-known reference in scheduling systems and MES.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `shift_name` STRING COMMENT 'Human-readable name of the shift (e.g., Day Shift, Night Shift, Morning Shift). Used for display in reports and HMI screens.',
    `shift_status` STRING COMMENT 'Current lifecycle state of the shift definition. Active shifts are available for scheduling; inactive shifts are temporarily disabled; draft shifts are under review; archived shifts are retained for historical reference only.. Valid values are `active|inactive|draft|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift pattern indicating the nature of the working period. Regular shifts are standard production periods; overtime, weekend, and holiday shifts may carry premium labor rates; maintenance and emergency shifts are non-production periods.. Valid values are `regular|overtime|weekend|holiday|maintenance|emergency`',
    `start_time` TIMESTAMP COMMENT 'Time of day when the shift begins, in HH:mm:ss format (24-hour clock). Used to calculate shift boundaries for production tracking and OEE reporting.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target cycle time per unit to meet customer demand, calculated as net_available_minutes * 60 / planned_output_quantity. Used for production pacing and line balancing. Nullable if not applicable to this shift type.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the plant location where this shift operates (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used to convert shift boundaries to UTC for global reporting and to handle daylight saving time transitions.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for planned_output_quantity (e.g., EA for each, KG for kilograms, M for meters). Must align with material master UOM for the products manufactured during this shift.. Valid values are `^[A-Z]{2,5}$`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this shift definition record. Used for audit trail and data governance.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Shift definition master representing a named working period pattern for a plant or work center. Defines shift code, start/end times, break structure, net available minutes, and shift type (regular, overtime, weekend). Used as the time-boundary reference for capacity planning, OEE shift-level reporting, takt time calculation, and workforce scheduling integration.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`shift_report` (
    `shift_report_id` BIGINT COMMENT 'Unique identifier for the shift report record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift reports capture actual production costs (energy, labor, materials) allocated to cost centers for shift-level cost variance analysis. Industrial manufacturing controllers use shift-to-cost-center',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Allows shift reports to be tied to the plant location for accurate reporting of downtime and quality metrics per site.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Shift reports record which lot/batch was produced each shift for quality traceability and regulatory compliance. Industrial manufacturing requires linking shift output directly to lot_batch for batch ',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Shift reports track material_consumed_quantity and material_waste_quantity but have no FK to material_master. Material consumption variance reporting and shop-floor material accountability in industri',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Shift reports document quality holds (quality_hold_flag) and nonconformances discovered during a shift. When a quality hold is raised, the shift report must reference the resulting NCR for shift-level',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A shift report is generated for a specific production line. While shift_report already has work_center_id, the production line is the higher-level operational unit for OEE and throughput reporting. Di',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: A shift report captures actual production results for a specific shift, and those results are tied to the work order being executed during that shift. This link enables traceability from shift-level O',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.run. Business justification: A shift report documents the production performance of a specific production run during a shift. The run entity represents a continuous execution campaign, and shift reports are the granular performan',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to production.production_schedule. Business justification: A shift report captures actual vs. planned production, and the planned quantities come from the production schedule. Linking shift_report to production_schedule enables schedule adherence analysis — c',
    `shift_id` BIGINT COMMENT 'Reference to the shift definition (e.g., Day Shift, Night Shift, Swing Shift).',
    `sku_master_id` BIGINT COMMENT 'Reference to the product or material that was produced during this shift.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where this shift occurred.',
    `actual_good_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of conforming units produced during the shift that passed quality inspection.',
    `actual_production_time_minutes` DECIMAL(18,2) COMMENT 'Actual time the work center was actively producing during the shift, excluding downtime.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Percentage of planned production time that the equipment was available and operating, calculated as (Planned Time - Downtime) / Planned Time × 100.',
    `changeover_count` STRING COMMENT 'Number of production changeovers or setups performed during the shift.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time spent on changeovers and setups during the shift.',
    `comments` STRING COMMENT 'Free-text comments from the shift supervisor documenting notable events, issues, or observations during the shift.',
    `cycle_time_seconds` DECIMAL(18,2) COMMENT 'Average time in seconds to complete one production cycle or unit during the shift.',
    `data_source_system` STRING COMMENT 'Identifies the primary source system from which shift data was captured (MES, SCADA, ERP, or manual entry).. Valid values are `MES|SCADA|ERP|MANUAL`',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the shift due to equipment failures, material shortages, or other interruptions.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total electrical energy consumed by the work center during the shift, measured in kilowatt-hours.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this shift report requires management escalation due to performance issues, quality problems, or safety concerns.',
    `material_consumed_quantity` DECIMAL(18,2) COMMENT 'Total quantity of raw materials or components consumed during the shift.',
    `material_waste_quantity` DECIMAL(18,2) COMMENT 'Quantity of material wasted or lost during production beyond normal scrap allowances.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness calculated as Availability × Performance × Quality, expressed as a percentage.',
    `operator_count` STRING COMMENT 'Number of operators assigned to the work center during this shift.',
    `performance_percentage` DECIMAL(18,2) COMMENT 'Percentage of maximum possible output achieved during operating time, calculated as (Actual Output / Theoretical Maximum Output) × 100.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total planned available production time for the shift, excluding scheduled breaks and maintenance windows.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target production quantity planned for this shift based on production schedule and capacity.',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether production output from this shift is on quality hold pending inspection or investigation.',
    `quality_percentage` DECIMAL(18,2) COMMENT 'Percentage of good units produced out of total units, calculated as (Good Quantity / Total Produced Quantity) × 100.',
    `report_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift report was officially closed and finalized in the MES system.',
    `report_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift report record was first created in the system.',
    `report_number` STRING COMMENT 'Business identifier for the shift report, typically formatted as YYYYMMDD-SHIFT-WORKCENTER.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of units requiring rework or reprocessing to meet quality standards.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this shift requiring documentation and follow-up.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of units scrapped during the shift due to defects or non-conformance.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of total produced quantity that was scrapped, calculated as (Scrap Quantity / Total Produced Quantity) × 100.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred.',
    `shift_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the shift in minutes, calculated from start to end timestamp.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift ended production activities.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when the shift started production activities.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target production rate in seconds per unit, calculated from customer demand and available production time.',
    `throughput_rate_per_hour` DECIMAL(18,2) COMMENT 'Average number of units produced per hour during the shift.',
    `total_produced_quantity` DECIMAL(18,2) COMMENT 'Total quantity produced during the shift, including good, scrap, and rework units.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this report (e.g., EA for each, KG for kilograms). [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|TON|LB|GAL|FT — 10 candidates stripped; promote to reference product]',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'First-pass yield rate representing the percentage of units that passed quality inspection without rework.',
    CONSTRAINT pk_shift_report PRIMARY KEY(`shift_report_id`)
) COMMENT 'Shift-level production performance report capturing actual results for a specific shift at a work center or line. Records planned vs. actual good quantity, scrap, rework, downtime minutes, OEE (availability × performance × quality), cycle time, takt time, and throughput rate. The SSOT for shift-level OEE and production KPIs. Drives daily production meetings, continuous improvement actions, and management escalation triggers. Sourced from MES shift close procedures (e.g., Siemens Opcenter) and SCADA data aggregation.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`production_downtime_event` (
    `production_downtime_event_id` BIGINT COMMENT 'Unique identifier for the production downtime event record. Primary key.',
    `capacity_plan_id` BIGINT COMMENT 'Foreign key linking to supply.capacity_plan. Business justification: Downtime events directly impact capacity plan actuals. Capacity planners reconcile unplanned downtime against capacity plans to update available capacity, trigger replanning, and calculate capacity va',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Downtime events caused by component failures must reference the specific engineering component for root cause analysis, FMEA updates, and reliability engineering. Enables component-level MTBF/MTTR ana',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Downtime events generate production loss values (production_loss_value column exists) posted to cost centers for variance analysis and OEE cost impact reporting. Industrial manufacturing controllers t',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: Downtime root‑cause analysis often references an engineering change notice; linking enables systematic CAPA tracking.',
    `equipment_register_id` BIGINT COMMENT 'Identifier of the specific equipment or machine that experienced downtime. Links to equipment register.',
    `failure_record_id` BIGINT COMMENT 'Foreign key linking to asset.failure_record. Business justification: Every significant production downtime event generates a failure record for FMEA and root cause analysis. Linking production_downtime_event to failure_record enables corrective action tracking, MTBF ca',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Captures the exact plant location of each downtime event, required for safety incident analysis and regulatory reporting.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: Downtime events caused by quality failures (nonconforming materials, tooling defects) are linked to NCRs for root cause analysis and OEE impact classification. Standard MES/QMS integration for downtim',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: A downtime event occurs at a specific production line. While production_downtime_event already has work_center_id, the production line is the primary operational unit for availability and OEE reportin',
    `production_work_order_id` BIGINT COMMENT 'Identifier of the production order that was interrupted by this downtime event. May be null for unplanned stoppages outside scheduled production.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Defective delivery traceability: downtime caused by a specific defective delivery is traced to the originating purchase order to support supplier quality claims, return material authorizations, and co',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.run. Business justification: A downtime event occurs during a production run, interrupting the continuous execution campaign. Linking production_downtime_event to run enables run-level downtime aggregation (total_downtime_minutes',
    `shift_id` BIGINT COMMENT 'Identifier of the production shift during which the downtime event occurred. Links to shift schedule master data.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Supplier-caused downtime tracking: production downtime caused by defective incoming materials or late deliveries must reference the responsible supplier for root cause analysis, corrective action requ',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production line where the downtime occurred. Links to the work center master data.',
    `alarm_code` STRING COMMENT 'SCADA or DCS alarm code that triggered the downtime event. Used to correlate downtime with specific equipment faults.',
    `alarm_description` STRING COMMENT 'Human-readable description of the SCADA alarm that initiated the downtime event.',
    `approval_status` STRING COMMENT 'Approval status of the downtime event record. Pending indicates awaiting supervisor review, approved indicates validated, rejected indicates disputed or incorrect entry.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the downtime event record was approved by a supervisor or manager.',
    `comments` STRING COMMENT 'Additional free-text comments or notes about the downtime event from operators, technicians, or supervisors.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for production loss value (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event: breakdown (unplanned equipment failure), planned_maintenance (scheduled PM), changeover (product/tool change), material_shortage (feedstock unavailable), quality_hold (production stopped for quality issue), operator_absence (staffing gap).. Valid values are `breakdown|planned_maintenance|changeover|material_shortage|quality_hold|operator_absence`',
    `downtime_event_number` STRING COMMENT 'Business-readable unique identifier for the downtime event, typically generated by MES or SCADA system.. Valid values are `^DT-[0-9]{10}$`',
    `downtime_reason` STRING COMMENT 'Operator or supervisor entered reason for the downtime event. Free-text field capturing immediate observed cause.',
    `downtime_type` STRING COMMENT 'Indicates whether the downtime was planned (scheduled maintenance, changeover) or unplanned (breakdown, material shortage, quality hold).. Valid values are `planned|unplanned`',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event in minutes. Calculated as the difference between end_timestamp and start_timestamp, or current time if still ongoing.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when production resumed after the downtime event. Null if downtime is still ongoing.',
    `impact_on_oee` DECIMAL(18,2) COMMENT 'Calculated percentage impact of this downtime event on the work center or line OEE for the shift or day. Expressed as percentage points lost.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this downtime event record is currently active. False indicates the record has been logically deleted or superseded.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this downtime event is part of a recurring pattern at this work center or equipment. True if similar events have occurred within the past 30 days.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was last updated. Audit trail field.',
    `mttr_minutes` DECIMAL(18,2) COMMENT 'Mean time to repair for this type of downtime event, calculated from historical data. Used for benchmarking and performance tracking.',
    `notification_sent` BOOLEAN COMMENT 'Flag indicating whether automated notifications were sent to supervisors, maintenance team, or management when this downtime event occurred.',
    `preventive_action` STRING COMMENT 'Description of preventive measures implemented to avoid recurrence of this type of downtime event.',
    `production_loss_units` DECIMAL(18,2) COMMENT 'Estimated quantity of production units lost due to this downtime event. Calculated based on standard cycle time and downtime duration.',
    `production_loss_value` DECIMAL(18,2) COMMENT 'Estimated financial value of production lost due to this downtime event. Calculated using standard cost per unit and production loss units.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Date and time when this downtime event record was first created in the system. Audit trail field.',
    `recurrence_count` STRING COMMENT 'Number of times this type of downtime event has occurred at this work center or equipment within the past 30 days. Used for chronic loss identification.',
    `resolution_action` STRING COMMENT 'Description of the corrective action taken to resolve the downtime event and restore production.',
    `responsible_department` STRING COMMENT 'Department accountable for resolving the downtime event: production (operator-related), maintenance (equipment repair), quality (inspection/testing), materials (supply chain), engineering (design/process), operations (planning/scheduling).. Valid values are `production|maintenance|quality|materials|engineering|operations`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the root cause of the downtime event. Typically references a root cause taxonomy maintained in the CMMS or MES system.',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings for this downtime event.',
    `severity_level` STRING COMMENT 'Business impact severity of the downtime event: critical (full line stoppage, safety risk), high (major capacity loss), medium (partial degradation), low (minor impact).. Valid values are `critical|high|medium|low`',
    `shift_date` DATE COMMENT 'Calendar date of the shift during which the downtime occurred. Used for daily OEE reporting and trend analysis.',
    `source_system` STRING COMMENT 'System that originated this downtime event record: MES (Siemens Opcenter), SCADA (Aveva), ERP (SAP PP), CMMS (Maximo), or Manual (operator entry).. Valid values are `MES|SCADA|ERP|CMMS|Manual`',
    `source_system_code` STRING COMMENT 'Unique identifier of this downtime event in the source system. Used for data lineage and reconciliation.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the downtime event began. Captured from SCADA alarm logs or MES operator entry.',
    CONSTRAINT pk_production_downtime_event PRIMARY KEY(`production_downtime_event_id`)
) COMMENT 'Downtime event capturing a planned or unplanned production stoppage at a work center or line. Records start/end timestamps, duration, downtime category (breakdown, planned maintenance, changeover, material shortage, quality hold, operator absence), root cause code, and responsible department. Critical input for OEE availability calculation, TPM analysis, and changeover time (SMED) tracking. Sourced from SCADA alarm logs and MES downtime tracking (e.g., Siemens Opcenter).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the production goods receipt event. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for the production activity. Used for cost allocation and variance analysis.',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: Finished-goods GR reconciliation: when production completes and goods are received into stock, the GR is matched to the outbound delivery document to confirm fulfillment quantities and update delivery',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Goods receipts for finished goods must record the engineering revision produced for serialized product traceability, customer delivery documentation, and regulatory compliance (e.g., automotive part t',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: The quality_inspection_required flag on goods receipt triggers inspection against a specific engineering specification. Linking the receipt to the governing specification enables automated inspection ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Production goods receipts trigger inventory and WIP clearing postings to GL accounts (stock accounts, finished goods accounts). In industrial manufacturing, GR document posting requires a GL account r',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Production goods receipts trigger quality inspection lots for usage decision. The GR document must reference the inspection lot for stock posting decisions. Standard SAP QM / ERP-QMS flow in industria',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Connects goods receipt to the receiving plant location, supporting traceability and inventory valuation per site.',
    `lot_batch_id` BIGINT COMMENT 'Reference to the lot or batch number assigned to the received goods for traceability and quality control purposes.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the finished or semi-finished good that was received. Links to the material being produced.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: Goods receipts are posted as a result of an MRP run; linking enables receipt verification against the originating run in the Goods Receipt Reconciliation report.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Goods receipts from production confirm and close planned orders in MRP. The GR-to-planned-order confirmation is a fundamental MRP process that updates available stock and triggers downstream supply ch',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supplier.po_line_item. Business justification: 3-way match process: each production goods receipt maps to a specific PO line item for quantity confirmation, open-quantity reduction, and invoice verification. Industrial manufacturing ERP systems re',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to production.production_line. Business justification: Replace string line code with a proper foreign key to the production line entity for referential integrity.',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Link goods receipt to the work order it finalizes, enabling traceability from receipt to production work order.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: GR/IR clearing process: production goods receipts must reference the originating purchase order to confirm delivery, close the GR/IR clearing account, and enable 3-way match (PO/GR/Invoice). Standard ',
    `run_id` BIGINT COMMENT 'Foreign key linking to production.run. Business justification: A goods receipt records the formal completion and stock posting of goods produced during a production run. Linking production_goods_receipt to run enables run-level yield tracking — comparing actual_q',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Goods receipt against a sales order intake is the trigger for order fulfillment confirmation and revenue recognition in industrial manufacturing. Direct GR-to-order-intake traceability is required for',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Goods receipt of serialized finished goods (automation systems, drives, PLCs) in industrial manufacturing creates a serialized_unit record. The goods receipt must reference the serialized unit for ser',
    `shift_id` BIGINT COMMENT 'Foreign key linking to production.shift. Business justification: Replace string shift identifier with a foreign key to the shift entity, allowing accurate shift‑level reporting.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Goods receipt records need the SKU to validate received quantity against the product master and enable downstream inventory updates.',
    `stock_location_id` BIGINT COMMENT 'Reference to the storage location within the plant where the received goods were posted to inventory. Links to warehouse storage location.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Goods receipt must record the supplying vendor to enable invoice matching and supplier performance tracking.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: A goods receipt is posted from a specific work center where the finished or semi-finished goods were produced. This link enables work-center-level yield and output tracking, connecting the physical pr',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received goods for traceability. May be system-generated or manually assigned based on batch management configuration.',
    `confirmation_number` STRING COMMENT 'The production confirmation number from the MES or ERP system that triggered this goods receipt. Links shop floor execution to inventory posting.',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was first created in the data warehouse. Used for data lineage and audit purposes.',
    `delivery_note_number` STRING COMMENT 'Reference number from the physical delivery documentation or packing slip accompanying the goods. Used for reconciliation with physical documents.',
    `document_date` DATE COMMENT 'The date on which the goods receipt document was created or initiated. May differ from posting date in cases of backdated transactions.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the goods receipt was posted. Used for monthly financial closing and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the goods receipt was posted. Used for period-based financial reporting and inventory valuation.',
    `gr_document_number` STRING COMMENT 'The unique document number generated by the ERP system for this goods receipt transaction. This is the business identifier used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the receipt has been successfully posted, reversed, cancelled, or is awaiting quality inspection.. Valid values are `posted|reversed|cancelled|pending_quality|blocked`',
    `modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this goods receipt record was last updated in the data warehouse. Used for change tracking and data quality monitoring.',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the type of inventory transaction. For production goods receipts, typically 101 (goods receipt to stock) or 131 (goods receipt from production order).. Valid values are `^[0-9]{3}$`',
    `note` STRING COMMENT 'Free-text notes or comments entered by the operator or warehouse personnel regarding the goods receipt. Captures exceptions, observations, or special handling instructions.',
    `order_quantity` DECIMAL(18,2) COMMENT 'The total quantity originally planned to be produced on the work order. Used to calculate yield and completion percentage.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to inventory in the ERP system. This is the accounting-effective date for inventory valuation.',
    `posting_user` STRING COMMENT 'The system user ID who posted the goods receipt transaction in the ERP system. Used for audit trail and accountability.',
    `production_version` STRING COMMENT 'Identifies the specific production version (combination of BOM and routing) used to manufacture the goods. Used for process traceability and costing.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released to unrestricted stock. Drives QM workflow.',
    `receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the goods were physically received and confirmed on the shop floor or warehouse. Captures the real-world event time for production completion.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of finished or semi-finished goods received and posted to inventory. Measured in the base unit of measure for the material.',
    `reservation_number` STRING COMMENT 'The material reservation number that was created for the work order and fulfilled by this goods receipt. Links production output to material planning.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt was reversed. Provides audit trail for corrections.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this goods receipt has been reversed or cancelled. Used to filter active vs. reversed transactions in reporting.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the goods receipt (e.g., quantity error, wrong material, quality issue). Used for root cause analysis.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The quantity of material scrapped or rejected during the production run that resulted in this goods receipt. Used for yield calculation and quality analysis.',
    `special_stock_indicator` STRING COMMENT 'Code indicating if the goods receipt is for special stock types such as consignment, project stock, or sales order stock. Affects inventory valuation and availability.',
    `stock_type` STRING COMMENT 'The type of stock to which the goods were received. Unrestricted stock is available for use, quality inspection stock is awaiting QA approval, blocked stock cannot be used.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilograms, L for liters). Must match the material master base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Classification code used for split valuation of materials when the same material is valued differently based on procurement type or quality grade.',
    `vendor_batch_number` STRING COMMENT 'External batch number from a supplier or contract manufacturer, if the goods receipt is for subcontracted production. Used for external traceability.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The percentage of good output relative to the total input or planned quantity. Calculated as (received_quantity / order_quantity) * 100. Key OEE component.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt event recording formal completion and stock posting of finished or semi-finished goods produced against a work order. Captures GR document number, posting date, material, plant, storage location, received quantity, batch number, and movement type (101). Sourced from SAP PP/WM (MIGO). This is the production domains handoff point — it triggers inventory update in the inventory domain and signals work order completion. Does NOT own ongoing stock balances (inventory domain owns those).';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`run` (
    `run_id` BIGINT COMMENT 'Primary key for run',
    `account_id` BIGINT COMMENT 'Reference to the customer account for whom this production run is being executed, applicable for make-to-order scenarios.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Subcontract agreement utilization: production runs for subcontracted operations are executed under a supplier agreement. Linking enables contract utilization tracking, price validation per agreement t',
    `bom_id` BIGINT COMMENT 'Reference to the Bill of Materials used for this production run, defining the component structure and recipe.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: A production run executes a specific product configuration in configure-to-order manufacturing. The configuration governs assembly instructions, component selection, and quality acceptance criteria fo',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: Each production run executes under a specific control plan specifying process controls, measurement frequencies, and reaction plans. Control plan compliance per run is a core IATF 16949 / APQP require',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production runs accumulate actual costs (actual_cost column exists) assigned to cost centers for cost object controlling. In industrial manufacturing, run-level cost tracking by cost center is standar',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Production runs initiated to implement an ECO (first production run after an engineering change) must reference the governing ECO for change effectivity tracking and customer notification. Supports en',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Production runs must be traceable to the engineering revision being manufactured — fundamental for customer traceability reports, warranty analysis, and regulatory compliance (IATF 16949, ISO 9001). N',
    `equipment_register_id` BIGINT COMMENT 'Reference to the primary equipment or machine asset assigned to execute this production run.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Run‑level reporting and profitability analysis need a direct reference to the originating sales order.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Each production run is governed by a specific inspection plan for in-process SPC and quality gate decisions. Run-level inspection plan traceability is required for automotive and aerospace manufacturi',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Each production run produces a specific lot/batch. Batch genealogy, quality hold management, and lot traceability in industrial manufacturing require a direct run→lot_batch link. batch_number on run i',
    `material_master_id` BIGINT COMMENT 'Reference to the primary material or product being manufactured in this production run.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Production run actuals (actual_quantity, oee_percentage, scrap_rate) must be reconciled against the supply plan for plan adherence reporting. Run-level plan traceability is required for S&OP review an',
    `production_line_id` BIGINT COMMENT 'FK to production.production_line',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: A production run executes against a specific work order. The run entity tracks continuous execution campaigns on a production line, and each run is authorized by a work order. run.work_order_count con',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Subcontracted run traceability: production runs executing subcontracted operations reference the purchase order issued to the supplier. This enables cost confirmation, goods receipt posting against th',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: A production run follows a specific manufacturing routing that defines the sequence of operations. run.routing_number (STRING) is a denormalized reference to routing.routing_number. Adding routing_id ',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Run scheduling dashboards rely on the originating sales order intake to allocate runs; the FK replaces the redundant sales_order_number field.',
    `shift_id` BIGINT COMMENT 'FK to production.shift',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Each production run must reference the SKU to calculate yield, OEE, and cost per product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Production runs output finished goods to a specific stock location (finished goods staging area). MES-to-WMS integration and finished goods putaway processes require the run to reference its output st',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Production runs need supplier reference to calculate cost, quality impact, and compliance per material batch.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where finished goods from this run are received.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: A production run is executed at a specific work center or machine. While a run is associated with a production_line (existing FK), the work center provides finer-grained resource assignment for schedu',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this production run, including material, labor, and overhead costs.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution was completed or terminated.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Total actual quantity produced during this run, representing the sum of good output across all work orders.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the production run execution began on the shop floor.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Equipment availability during the production run, calculated as (operating time / planned production time) * 100.',
    `campaign_code` STRING COMMENT 'Campaign or project code associated with this production run, used for grouping related runs for reporting and analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost and financial values in this production run.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this production run record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments about the production run, capturing operational observations, issues, or special instructions.',
    `oee_percentage` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness metric for this production run, calculated as availability * performance * quality, expressed as a percentage.',
    `performance_percentage` DECIMAL(18,2) COMMENT 'Equipment performance efficiency during the production run, calculated as (actual output / target output) * 100.',
    `planned_finish_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the production run is planned to complete execution.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Total planned production quantity for this run across all included work orders.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the production run is planned to begin execution.',
    `priority_code` STRING COMMENT 'Priority level assigned to this production run for scheduling and resource allocation purposes.. Valid values are `low|normal|high|urgent|critical`',
    `quality_percentage` DECIMAL(18,2) COMMENT 'Quality rate during the production run, calculated as (good units / total units produced) * 100.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material sent for rework or reprocessing during this production run.',
    `run_number` STRING COMMENT 'Business identifier for the production run campaign, externally visible and used for tracking and reporting purposes.',
    `run_status` STRING COMMENT 'Current lifecycle status of the production run indicating its operational state.. Valid values are `planned|active|paused|completed|cancelled|aborted`',
    `run_type` STRING COMMENT 'Classification of the production run indicating the purpose or nature of the execution (standard production, pilot run, rework campaign, validation run, trial batch, or extended campaign).. Valid values are `standard|pilot|rework|validation|trial|campaign`',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Total quantity of scrap or rejected material generated during this production run.',
    `scrap_rate_percentage` DECIMAL(18,2) COMMENT 'Overall scrap rate for the production run, calculated as (scrap quantity / (actual quantity + scrap quantity)) * 100.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit for this production run based on the costing model and BOM.',
    `takt_time_minutes` DECIMAL(18,2) COMMENT 'Target production rate or takt time for this run, representing the available production time divided by customer demand, measured in minutes per unit.',
    `throughput_rate` DECIMAL(18,2) COMMENT 'Average throughput rate achieved during the production run, measured as units produced per hour.',
    `total_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Total cycle time for the production run, representing the sum of all processing time across all operations, measured in minutes.',
    `total_downtime_minutes` DECIMAL(18,2) COMMENT 'Total unplanned downtime during the production run, measured in minutes.',
    `total_setup_time_minutes` DECIMAL(18,2) COMMENT 'Total setup and changeover time for the production run, measured in minutes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this production run (e.g., EA, KG, L, M).',
    `work_order_count` STRING COMMENT 'Number of individual work orders included or consolidated within this production run campaign.',
    `yield_rate_percentage` DECIMAL(18,2) COMMENT 'Overall yield rate for the production run, calculated as (actual quantity / (actual quantity + scrap quantity)) * 100.',
    CONSTRAINT pk_run PRIMARY KEY(`run_id`)
) COMMENT 'Production run entity representing a continuous execution campaign on a production line or work center, potentially spanning multiple work orders for the same or similar products. Captures run number, production line, start timestamp, end timestamp, total planned quantity, total actual quantity, total scrap quantity, overall yield rate, number of work orders included, and run status (active, completed, cancelled). Sourced from Siemens Opcenter MES campaign/run management. Enables campaign-level performance analysis beyond individual work orders.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Unique identifier for the production line. Primary key for the production line master entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production line overhead is budgeted and reported per cost center; the link supports line‑level cost reporting.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Production lines in industrial manufacturing are typically dedicated to specific product families (e.g., switchgear assembly line, motor winding line). This link drives capacity planning by product fa',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Needed to associate each production line with its plant location for capacity planning and regulatory compliance.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: A production line is physically located within a plant. This is a critical missing master data relationship — production lines are plant-specific assets and all capacity, OEE, and throughput reporting',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production lines are assigned to profit centers for line-level profitability reporting in industrial manufacturing. Controllers use production line-to-profit-center mapping for contribution margin ana',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Production lines are commissioned, upgraded, or decommissioned as part of engineering capital projects. Linking production lines to their governing engineering project enables project cost tracking, c',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Production lines have dedicated line-side stock locations (supermarket/kanban input buffers and finished goods output staging). Lean manufacturing replenishment planning and line-feeding logistics req',
    `actual_oee_percentage` DECIMAL(18,2) COMMENT 'Most recent calculated Overall Equipment Effectiveness percentage for this production line based on actual performance data.',
    `automation_level` STRING COMMENT 'Degree of automation implemented on the production line, ranging from manual operations to fully automated lights-out manufacturing.. Valid values are `manual|semi_automated|fully_automated|lights_out`',
    `capacity_constraint_flag` BOOLEAN COMMENT 'Indicates whether this production line is identified as a bottleneck or capacity constraint in the manufacturing process requiring special attention in scheduling.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time from last good piece of previous run to first good piece of new run, including setup and stabilization time.',
    `commissioning_date` DATE COMMENT 'Date when the production line was first commissioned and put into operational service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was first created in the system.',
    `cycle_time_seconds` DECIMAL(18,2) COMMENT 'Actual average time required to complete one production cycle on this line. Used to compare against takt time for performance analysis.',
    `data_source_system` STRING COMMENT 'Identifier of the source system from which this production line master data originated or is synchronized.. Valid values are `SAP_PP|OPCENTER_MES|SCADA|MDM|MANUAL`',
    `design_throughput_rate` DECIMAL(18,2) COMMENT 'Theoretical maximum production rate of the line measured in units per hour under ideal conditions. Used for capacity planning and OEE calculations.',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Average energy consumption in kilowatt-hours required to produce one unit of output on this production line. Used for energy management and cost analysis.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this production line is subject to environmental compliance monitoring and reporting requirements.',
    `erp_work_center_code` STRING COMMENT 'Corresponding work center code in the ERP system for integration with production planning and costing modules.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major upgrade or modernization performed on the production line equipment or control systems.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was most recently updated or modified.',
    `layout_diagram_url` STRING COMMENT 'Reference URL or document path to the physical layout diagram or CAD drawing of the production line configuration.',
    `line_code` STRING COMMENT 'Unique business identifier code for the production line used across MES and ERP systems. Externally-known identifier for scheduling, capacity planning, and shop floor control.. Valid values are `^[A-Z0-9]{4,12}$`',
    `line_name` STRING COMMENT 'Human-readable name of the production line for identification and reporting purposes.',
    `line_type` STRING COMMENT 'Classification of the production line based on its primary manufacturing function. Determines the type of operations performed on this line.. Valid values are `assembly|machining|fabrication|painting|testing|packaging`',
    `mes_line_identifier` STRING COMMENT 'Unique identifier for this production line in the Manufacturing Execution System used for shop floor control and production tracking.',
    `mtbf_hours` DECIMAL(18,2) COMMENT 'Average time between equipment failures on this production line, used for reliability analysis and preventive maintenance planning.',
    `mttr_hours` DECIMAL(18,2) COMMENT 'Average time required to repair and restore this production line to operational status after a failure event.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations specific to this production line.',
    `number_of_stations` STRING COMMENT 'Total count of work stations or process steps configured on this production line. Defines the line configuration and complexity.',
    `operational_status` STRING COMMENT 'Current operational state of the production line indicating availability for production scheduling and capacity planning.. Valid values are `active|inactive|maintenance|standby|decommissioned`',
    `planned_availability_hours_per_day` DECIMAL(18,2) COMMENT 'Total hours per day that the production line is scheduled to be available for production, excluding planned maintenance windows.',
    `planned_decommission_date` DATE COMMENT 'Planned date for decommissioning or retirement of this production line from active service.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether output from this production line requires mandatory quality inspection before release to inventory.',
    `safety_certification_required` STRING COMMENT 'List of safety certifications or compliance requirements applicable to this production line based on the products manufactured and jurisdictional regulations.',
    `scada_system_tag` STRING COMMENT 'Unique tag identifier in the SCADA system used to monitor and control this production line in real-time.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Average time required to change over the production line from one product or batch to another, including tooling changes and adjustments.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern configured for this production line defining daily operational hours and crew rotation.. Valid values are `single_shift|two_shift|three_shift|continuous|custom`',
    `standard_operating_procedure_url` STRING COMMENT 'Reference URL or document path to the standard operating procedures governing operation of this production line.',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Target time interval between completion of successive units, calculated as available production time divided by customer demand. Critical metric for lean manufacturing and production scheduling.',
    `target_oee_percentage` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage for this production line, representing the goal for availability, performance, and quality combined.',
    `throughput_unit_of_measure` STRING COMMENT 'Unit of measure for the throughput rate indicating how production output is quantified for this line.. Valid values are `units_per_hour|pieces_per_hour|kg_per_hour|liters_per_hour`',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Production line master entity representing a named, configured manufacturing line within a plant, composed of an ordered set of work centers and machines. Captures line code, line name, plant, line type (assembly, machining, fabrication, painting, testing), design throughput rate (units/hour), takt time target, number of stations, automation level (manual, semi-automated, fully automated), and current operational status. The SSOT for production line configuration used in scheduling, OEE reporting, and capacity planning.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: A plant belongs to exactly one company code — fundamental organizational assignment in industrial manufacturing ERP for financial reporting, intercompany transactions, statutory reporting, and tax jur',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Plants are assigned to profit centers for plant-level P&L reporting in industrial manufacturing controlling. Standard SAP CO-PCA configuration requires plant-to-profit-center assignment for segment re',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Plants contain warehouses — this is a fundamental organizational hierarchy in industrial manufacturing ERP. Inventory planning, MRP, and stock reporting require navigating from plant to its associated',
    `address_line1` STRING COMMENT 'Primary street address of the plant.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building).',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical output capacity of the plant in megawatts.',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Total CO₂ equivalent emissions for the plant in kilograms.',
    `city` STRING COMMENT 'City where the plant is located.',
    `closure_date` DATE COMMENT 'Date the plant was permanently shut down, if applicable.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the plant.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption for the reporting period in megawatt‑hours.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the plant record is currently active in the system.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the plant site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the plant site.',
    `maintenance_cycle_days` STRING COMMENT 'Standard interval in days between routine maintenance events.',
    `manager_email` STRING COMMENT 'Email address of the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the plant manager.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the plant manager.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next major maintenance activity.',
    `notes` STRING COMMENT 'Supplementary information or remarks about the plant.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Measured OEE percentage achieved.',
    `oee_target` DECIMAL(18,2) COMMENT 'Planned OEE percentage target for the plant.',
    `operational_since` DATE COMMENT 'Date the plant began commercial operations.',
    `plant_code` STRING COMMENT 'External business code used to reference the plant in ERP/MES systems.',
    `plant_description` STRING COMMENT 'Free‑form textual description of the plants purpose and characteristics.',
    `plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `plant_status` STRING COMMENT 'Current operational state of the plant.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary function.',
    `region` STRING COMMENT 'Higher‑level region (e.g., North America, EMEA) for reporting.',
    `safety_incident_count` STRING COMMENT 'Number of recorded safety incidents in the reporting period.',
    `safety_incident_last_date` DATE COMMENT 'Date of the most recent safety incident.',
    `state_province` STRING COMMENT 'State or province of the plant location.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the plant location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    `waste_generated_tons` DECIMAL(18,2) COMMENT 'Quantity of waste produced by the plant in metric tons.',
    `water_consumption_m3` DECIMAL(18,2) COMMENT 'Total water usage for the reporting period in cubic metres.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`production`.`routing_operation` (
    `routing_operation_id` BIGINT COMMENT 'Primary key for the routing_operation association',
    `routing_id` BIGINT COMMENT 'Foreign key linking this operation step to its parent manufacturing routing header.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking this operation step to the work center where the operation is performed.',
    `control_key` STRING COMMENT 'Control key defining how this specific operation is processed — whether it triggers confirmations, quality inspections, costing, or external processing. Operation-level override of the work center default control key.',
    `labor_time_minutes` DECIMAL(18,2) COMMENT 'Standard labor time in minutes per base quantity for this operation step. May differ from machine time when operator and machine run concurrently.',
    `machine_time_minutes` DECIMAL(18,2) COMMENT 'Standard machine time in minutes per base quantity for this operation step. Used for machine capacity planning and OEE calculations.',
    `operation_description` STRING COMMENT 'Short description of the work to be performed at this operation step within this routing. Describes the specific task (e.g., Rough mill housing bore), not the work center capability in general.',
    `operation_number` STRING COMMENT 'Business identifier for the operation step within the routing (e.g., 0010, 0020, 0030). Determines the display and reference sequence of operations. Corresponds to SAP PP field VORNR.',
    `processing_time_minutes` DECIMAL(18,2) COMMENT 'Standard machine or processing time in minutes per base quantity for this operation step. Used for capacity planning and standard cost calculation.',
    `sequence_number` STRING COMMENT 'Scheduling sequence number defining the execution order of operations within the routing. Used for parallel or alternative sequences. Corresponds to SAP PP field PLFL.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup or changeover time in minutes required to prepare the work center for this specific operation within this routing. This value is operation-specific and may differ from the work center default.',
    `standard_values` STRING COMMENT 'Standard value key defining which standard values (setup, machine, labor, teardown) are relevant for this operation and how they are used in costing and scheduling formulas.',
    CONSTRAINT pk_routing_operation PRIMARY KEY(`routing_operation_id`)
) COMMENT 'This association product represents the assignment of a work center to a specific operation step within a manufacturing routing. It captures the ordered sequence of operations that constitute a routing, with each record linking one routing to one work center at a defined operation step. Attributes that exist only in the context of this assignment — operation sequence, time standards for setup/processing/labor/machine, control key, and costing standard values — are stored here. This is the SSOT for operation-level process definitions and is the primary source for capacity planning, production scheduling, and standard cost calculation. Corresponds to SAP PP table PLPO (routing operation) and Siemens Opcenter process step assignment.. Existence Justification: In manufacturing ERP systems (SAP PP, Siemens Opcenter), a routing is composed of ordered operation steps, and each operation step is explicitly assigned to a specific work center. One routing references many work centers (one per operation step, and potentially the same work center at multiple steps), and one work center appears in many routings across different products and production scenarios. The routing operation is a well-recognized, actively managed business entity in manufacturing — planners create, update, and delete operation assignments as part of process engineering, and each assignment carries its own time standards, control keys, and costing data that belong neither to the routing header nor to the work center master alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ADD CONSTRAINT `fk_production_production_work_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ADD CONSTRAINT `fk_production_shift_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `manufacturing_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ADD CONSTRAINT `fk_production_shift_report_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ADD CONSTRAINT `fk_production_production_downtime_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_run_id` FOREIGN KEY (`run_id`) REFERENCES `manufacturing_ecm`.`production`.`run`(`run_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ADD CONSTRAINT `fk_production_goods_receipt_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `manufacturing_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_production_work_order_id` FOREIGN KEY (`production_work_order_id`) REFERENCES `manufacturing_ecm`.`production`.`production_work_order`(`production_work_order_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `manufacturing_ecm`.`production`.`shift`(`shift_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`run` ADD CONSTRAINT `fk_production_run_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `manufacturing_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ADD CONSTRAINT `fk_production_routing_operation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `manufacturing_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ADD CONSTRAINT `fk_production_routing_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `manufacturing_ecm`.`production`.`work_center`(`work_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `manufacturing_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `product_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `production_notes` SET TAGS ('dbx_business_glossary_term' = 'Production Notes');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `takt_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `wip_value` SET TAGS ('dbx_business_glossary_term' = 'Work In Progress (WIP) Value');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `wip_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'standard|rework|prototype|maintenance|sample');
ALTER TABLE `manufacturing_ecm`.`production`.`production_work_order` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Order ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `plant_data_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Data Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Pm Schedule Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cancelled Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `capacity_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement in Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Completed Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `firmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule Firmed Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `freeze_horizon_date` SET TAGS ('dbx_business_glossary_term' = 'Freeze Horizon Date');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Production Lead Time in Days');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `lot_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Size Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_business_glossary_term' = 'Lot Sizing Rule');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `lot_sizing_rule` SET TAGS ('dbx_value_regex' = 'fixed_lot|lot_for_lot|economic_order_quantity|period_order_quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Planning Notes');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `pegging_reference` SET TAGS ('dbx_business_glossary_term' = 'Demand Pegging Reference');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_business_glossary_term' = 'Planning Bucket Granularity');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planning_bucket` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planning_horizon_weeks` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon in Weeks');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_business_glossary_term' = 'Production Planning Strategy');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `planning_strategy` SET TAGS ('dbx_value_regex' = 'make_to_stock|make_to_order|assemble_to_order|engineer_to_order');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Schedule Priority Rank');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Released Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Time in Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Number');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^MPS-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source System');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'mrp_run|aps_optimization|manual_planning|demand_forecast|customer_order');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|released|frozen|revised|cancelled|completed');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type Classification');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'master_production_schedule|final_assembly_schedule|rough_cut_capacity_plan|material_requirements_plan');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_finish_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time in Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `available_capacity_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Per Shift');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_value_regex' = 'machine_hours|labor_hours|units_per_hour|setup_hours');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `capacity_planning_group` SET TAGS ('dbx_business_glossary_term' = 'Capacity Planning Group');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `capacity_planning_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `efficiency_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rate Percent');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_business_glossary_term' = 'Formula Key');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `mes_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration Enabled');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `number_of_machines` SET TAGS ('dbx_business_glossary_term' = 'Number of Machines');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `number_of_operators` SET TAGS ('dbx_business_glossary_term' = 'Number of Operators');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `oee_baseline_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Baseline Target Percent');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Address');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `plc_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint|only_capacity_requirements');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `standard_processing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Processing Time Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `standard_queue_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Standard Queue Time Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `standard_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Setup Time Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `standard_teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Teardown Time Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percent');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'machine|assembly_line|production_cell|labor_group|inspection_station|packaging_line');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|planned');
ALTER TABLE `manufacturing_ecm`.`production`.`work_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `change_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `counter` SET TAGS ('dbx_business_glossary_term' = 'Routing Group Counter');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `counter` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `is_default_routing` SET TAGS ('dbx_business_glossary_term' = 'Is Default Routing Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `is_phantom_routing` SET TAGS ('dbx_business_glossary_term' = 'Is Phantom Routing Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `planner_group` SET TAGS ('dbx_business_glossary_term' = 'Planner Group');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `planner_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_business_glossary_term' = 'Routing Group');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|released|active|inactive|obsolete|blocked');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_text` SET TAGS ('dbx_business_glossary_term' = 'Routing Long Text');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'production|inspection|rework|universal|rate|reference');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|TEAMCENTER|OPCENTER|MANUAL');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `total_labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `total_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Lead Time (Hours)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `total_machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Machine Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `total_operation_count` SET TAGS ('dbx_business_glossary_term' = 'Total Operation Count');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Routing Usage');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'standard|alternative|trial|prototype|emergency');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `manufacturing_ecm`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Break Duration in Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `break_schedule` SET TAGS ('dbx_business_glossary_term' = 'Break Schedule Description');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `changeover_allowance_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Allowance in Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `crew_size` SET TAGS ('dbx_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Applicable Days of Week');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `gross_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Gross Shift Duration in Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `handover_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Duration in Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `is_continuous_operation` SET TAGS ('dbx_business_glossary_term' = 'Continuous Operation Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `labor_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Multiplier');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `net_available_minutes` SET TAGS ('dbx_business_glossary_term' = 'Net Available Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Definition Notes');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `number_of_breaks` SET TAGS ('dbx_business_glossary_term' = 'Number of Scheduled Breaks');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `planned_output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Output Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Shift Priority');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Rotation Pattern');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Shift Sequence Number');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_business_glossary_term' = 'Shift Category');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_value_regex' = 'production|non_production|mixed');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Definition Status');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|weekend|holiday|maintenance|emergency');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time in Seconds');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Shift Timezone');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `timezone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `manufacturing_ecm`.`production`.`shift` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report ID');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `actual_good_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Good Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `actual_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `changeover_count` SET TAGS ('dbx_business_glossary_term' = 'Changeover Count');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Shift Comments');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Seconds)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'MES|SCADA|ERP|MANUAL');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `material_consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Consumed Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `material_waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Waste Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `performance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `quality_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `report_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Closed Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `report_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Number');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Seconds)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `throughput_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Throughput Rate (Per Hour)');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `total_produced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Produced Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`production`.`shift_report` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Production Downtime Event ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `capacity_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `failure_record_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Record Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `alarm_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA Alarm Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `alarm_description` SET TAGS ('dbx_business_glossary_term' = 'SCADA Alarm Description');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Comments');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'breakdown|planned_maintenance|changeover|material_shortage|quality_hold|operator_absence');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_value_regex' = '^DT-[0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_reason` SET TAGS ('dbx_business_glossary_term' = 'Downtime Reason');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `downtime_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `impact_on_oee` SET TAGS ('dbx_business_glossary_term' = 'Impact on Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Downtime');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `mttr_minutes` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Minutes');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_units` SET TAGS ('dbx_business_glossary_term' = 'Production Loss (Units)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_value` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Value (Currency)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `production_loss_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `recurrence_count` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Count');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `responsible_department` SET TAGS ('dbx_value_regex' = 'production|maintenance|quality|materials|engineering|operations');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Downtime Severity Level');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MES|SCADA|ERP|CMMS|Manual');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_downtime_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Production Goods Receipt ID');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch ID');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_quality|blocked');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `manufacturing_ecm`.`production`.`goods_receipt` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`production`.`run` SET TAGS ('dbx_subdomain' = 'shop_execution');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register ID');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `production_line_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `shift_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Run Notes');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `performance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `planned_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `quality_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Production Run Number');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Production Run Status');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'planned|active|paused|completed|cancelled|aborted');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Production Run Type');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'standard|pilot|rework|validation|trial|campaign');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `scrap_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `takt_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `throughput_rate` SET TAGS ('dbx_business_glossary_term' = 'Throughput Rate');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `total_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `total_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Downtime (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `total_setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Setup Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `work_order_count` SET TAGS ('dbx_business_glossary_term' = 'Work Order Count');
ALTER TABLE `manufacturing_ecm`.`production`.`run` ALTER COLUMN `yield_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `actual_oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual OEE (Overall Equipment Effectiveness) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated|lights_out');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `capacity_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Seconds)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|OPCENTER_MES|SCADA|MDM|MANUAL');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `design_throughput_rate` SET TAGS ('dbx_business_glossary_term' = 'Design Throughput Rate');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `energy_consumption_kwh_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption (kWh per Unit)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `erp_work_center_code` SET TAGS ('dbx_business_glossary_term' = 'ERP (Enterprise Resource Planning) Work Center Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `layout_diagram_url` SET TAGS ('dbx_business_glossary_term' = 'Line Layout Diagram URL');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Production Line Name');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'assembly|machining|fabrication|painting|testing|packaging');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `mes_line_identifier` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Line Identifier');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'MTBF (Mean Time Between Failures) Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'MTTR (Mean Time To Repair) Hours');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Production Line Notes');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `number_of_stations` SET TAGS ('dbx_business_glossary_term' = 'Number of Stations');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|standby|decommissioned');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `planned_availability_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Planned Availability Hours Per Day');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `planned_decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Decommission Date');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `safety_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `scada_system_tag` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) System Tag');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous|custom');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `standard_operating_procedure_url` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) URL');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time (Seconds)');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `target_oee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target OEE (Overall Equipment Effectiveness) Percentage');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `throughput_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Throughput Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`production`.`production_line` ALTER COLUMN `throughput_unit_of_measure` SET TAGS ('dbx_value_regex' = 'units_per_hour|pieces_per_hour|kg_per_hour|liters_per_hour');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` SET TAGS ('dbx_subdomain' = 'floor_resources');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` SET TAGS ('dbx_association_edges' = 'production.routing,production.work_center');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `routing_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Routing Operation Id');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Routing Id');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Work Center Id');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Operation Control Key');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `labor_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operation Labor Time');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `machine_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operation Machine Time');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `processing_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operation Processing Time');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operation Setup Time');
ALTER TABLE `manufacturing_ecm`.`production`.`routing_operation` ALTER COLUMN `standard_values` SET TAGS ('dbx_business_glossary_term' = 'Standard Value Key');
