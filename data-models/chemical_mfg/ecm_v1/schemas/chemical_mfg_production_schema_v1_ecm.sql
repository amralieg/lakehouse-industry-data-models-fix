-- Schema for Domain: production | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`production` COMMENT 'Core manufacturing execution domain managing batch and continuous chemical processes, reaction sequences, synthesis operations, and production runs. Includes production orders, batch records, process parameters (temperature, pressure, pH), DCS/PLC integration data (Honeywell Experion, Siemens PCS 7), MES execution logs, yield tracking, lot genealogy, BOM consumption, MOC records, and production scheduling. Captures real-time process data from SCADA systems and maintains production history for traceability and process optimization (SPC, OEE).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` (
    `manufacturing_order_id` BIGINT COMMENT 'Primary key for manufacturing_order',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for order fulfillment: each manufacturing order must be linked to the customer account that placed the order, enabling production scheduling, invoicing, and customer‑specific reporting.',
    `bill_of_materials_id` BIGINT COMMENT 'Identifier for the Bill of Materials defining the raw materials, intermediates, and components required for this production order.',
    `campaign_id` BIGINT COMMENT 'Identifier linking this order to a multi-batch production campaign. Used for extended runs of the same product to optimize changeover and yield.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Production order execution needs product master to fetch specifications, SDS, and regulatory compliance for the material being produced.',
    `control_recipe_id` BIGINT COMMENT 'Identifier for the control recipe instance downloaded to the DCS (Honeywell Experion, Siemens PCS 7) for automated execution of process phases and unit procedures.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Production Cost Allocation Report: each manufacturing order must be charged to a cost center for monthly cost accounting.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to planning.demand_forecast. Business justification: Order release uses the demand forecast that generated the manufacturing order; linking enables the Order Release report.',
    `employee_id` BIGINT COMMENT 'User ID or name of the production planner or system user who created the production order.',
    `formula_id` BIGINT COMMENT 'Foreign key linking to formulation.formula. Business justification: Production Order Specification Report requires the exact formula to be produced; planners assign a formula to each manufacturing order.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Manufacturing Order Planning uses material_master for specs, hazard data, and costing; linking provides single source of truth for each order.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Margin tracking: each manufacturing order references the sales price list used for the customer order to align production cost with pricing.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Production planning ties each manufacturing order to the purchase order that supplies its raw materials, enabling material availability and cost tracking.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: PRODUCTION: Production orders are generated from approved sales quotes; linking enables traceability, cost accounting, and revenue recognition.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Required for new‑product launch reporting linking each manufacturing order to its originating R&D project for cost allocation and regulatory traceability.',
    `routing_id` BIGINT COMMENT 'Identifier for the production routing or master recipe defining the sequence of operations, process steps, and control parameters.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Required for Production Order Material Allocation Report linking each order to the allocated stock position.',
    `work_center_id` BIGINT COMMENT 'Identifier for the primary work center (production line, reactor, blending unit) assigned to execute this order.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this production order, settled from material consumption, labor confirmations, and activity allocations.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Precise date and time when production execution completed, including final operation confirmation and goods receipt posting.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished product manufactured and confirmed via goods receipt. Used for yield calculation and variance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when production execution began, typically captured from MES or DCS system when the first operation started.',
    `actual_yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield percentage achieved in this production run: (actual output / theoretical output) * 100. Key performance indicator for process efficiency.',
    `batch_number` STRING COMMENT 'Unique lot or batch number assigned to the output of this production order. Critical for traceability, COA issuance, and regulatory compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Planned total cost for this production order, including raw materials, labor, utilities, and overhead. Used for cost accounting and variance analysis.',
    `cost_variance_flag` BOOLEAN COMMENT 'Indicator that actual cost exceeded planned cost by a threshold percentage, triggering variance investigation and root cause analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production order record was first created in the ERP system, marking the beginning of the order lifecycle.',
    `dcs_batch_reference` STRING COMMENT 'Batch identifier assigned by the DCS (Honeywell Experion, Siemens PCS 7) for automated process control and SCADA data historian linkage.',
    `deviation_flag` BOOLEAN COMMENT 'Indicator that one or more process deviations, out-of-specification events, or quality exceptions occurred during production execution.',
    `inspection_lot_number` STRING COMMENT 'Identifier for the quality inspection lot created for this production order output, linking to LIMS test results and Certificate of Analysis.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the production order, supporting change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the production order record, capturing any changes to quantities, dates, or status.',
    `master_recipe_reference` STRING COMMENT 'Reference to the master recipe or Process Instruction (PI) sheet governing the synthesis, reaction conditions, and quality parameters for this product.',
    `mes_integration_reference` STRING COMMENT 'External identifier used for integration with MES systems. Links ERP production order to MES work order for real-time execution tracking.',
    `moc_reference` STRING COMMENT 'Reference number for any Management of Change request associated with this production order, documenting process deviations or recipe modifications.',
    `order_number` STRING COMMENT 'Business identifier for the production order, externally visible and used across systems. Typically follows plant-specific numbering conventions.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_status` STRING COMMENT 'Current lifecycle state of the production order: created (planned but not released), released (authorized for execution), started (production begun), in_progress (active manufacturing), confirmed (goods receipt posted), technically_complete (production finished, pending final settlement), closed (financially settled), cancelled (order voided). [ENUM-REF-CANDIDATE: created|released|started|in_progress|confirmed|technically_complete|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the manufacturing process mode: batch (discrete lots), continuous (steady-state flow), semi-continuous (hybrid), campaign (extended multi-batch run), rework (reprocessing off-spec material), or trial (R&D pilot run).. Valid values are `batch|continuous|semi-continuous|campaign|rework|trial`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of finished product to be manufactured, as specified in the production order. Expressed in the base unit of measure.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or production facility where the order is executed.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Scheduling priority ranking for the production order. Lower numbers indicate higher priority. Used by MES and DCS systems for sequencing and resource allocation.',
    `process_order_type` STRING COMMENT 'Specific classification of the order purpose: standard (normal production), rework (reprocessing), trial (R&D pilot), validation (process qualification), cleaning (CIP campaign).. Valid values are `standard|rework|trial|validation|cleaning`',
    `production_version` STRING COMMENT 'Four-digit version number linking the specific BOM and routing combination used for this order. Enables traceability of recipe changes over time.. Valid values are `^[0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicator that finished product must undergo quality control inspection and COA issuance before release to inventory or shipment.',
    `scheduled_finish_date` DATE COMMENT 'Planned date for production order completion, including all manufacturing operations and goods receipt confirmation.',
    `scheduled_start_date` DATE COMMENT 'Planned date for production order to begin execution, as determined by production scheduling and capacity planning.',
    `settlement_rule` STRING COMMENT 'Configuration defining how production order costs are settled to inventory, cost centers, or profitability segments upon order closure.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the production quantity: KG (kilograms), L (liters), MT (metric tons), GAL (gallons), LB (pounds), TON (short tons), M3 (cubic meters). [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3 — 7 candidates stripped; promote to reference product]',
    `yield_target_percentage` DECIMAL(18,2) COMMENT 'Expected yield percentage based on master recipe and historical performance. Used as benchmark for variance analysis and process optimization.',
    CONSTRAINT pk_manufacturing_order PRIMARY KEY(`manufacturing_order_id`)
) COMMENT 'Core execution entity authorizing and tracking the manufacture of a chemical product or intermediate, serving as the single ISA-95 Level 3 production order and ISA-88 batch control entity. Captures order number, order type (batch/continuous/semi-continuous), master recipe reference (PI sheet), process order type, planned and actual quantities, unit of measure, scheduled and actual start/finish dates, order status lifecycle (created, released, started, confirmed, technically complete, closed), priority, plant, work center assignment, BOM reference, routing/recipe reference, production version, MES integration ID, DCS control recipe destination, phase sequence, settlement rule, cost estimate vs actual cost, yield target, and variance analysis flags. The single source of truth for what are we making, when, and how much — the central entity that batch records, BOM consumption, yield records, deviations, and campaigns all reference.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch record. Primary key for the batch record entity. Serves as the authoritative reference for all batch-level traceability, genealogy, and regulatory audit requirements.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Batch record must reference the specific chemical product to associate batch data with product specifications and compliance documents.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Needed for logistics and traceability: batch records must reference the customer site where the product will be delivered, supporting shipping plans, regulatory SDS/COA delivery, and site‑level yield ',
    `equipment_id` BIGINT COMMENT 'Primary reactor, vessel, or processing unit used for this batch. Links to the equipment master for asset tracking and maintenance correlation.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Ensures batch traceability to the exact experimental formulation developed in R&D, needed for quality audits and compliance reporting.',
    `formula_id` BIGINT COMMENT 'Reference to the master formula or recipe used for this batch. Captures the formulation version and Bill of Materials (BOM) applied during production.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Batch records must capture the exact formula version used for regulatory traceability and deviation analysis.',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Batch-to-QC traceability is mandatory for cGMP compliance. Every batch record must link to its quality inspection lot for release decisions. Without this, cannot answer what QC results exist for batc',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Needed for Batch‑Level Expense Tracking: batches are billed against internal orders to capture project‑specific production costs.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Batch‑to‑order line mapping enables batch traceability, invoicing, and regulatory batch‑lot reporting for each sold line item.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Enables batch traceability required by FDA/EMA regulations linking batch records to physical lots.',
    `notification_id` BIGINT COMMENT 'Foreign key linking to maintenance.notification. Business justification: Needed for Batch Execution Log to capture the maintenance notification that caused a batch hold, used in compliance and downtime analysis reports.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order that authorized this batch. Links the batch record to the planning and scheduling system (SAP PP Production Planning).',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: Each batch record originates from an MRP run; linking supports the Batch‑to‑MRP traceability audit.',
    `employee_id` BIGINT COMMENT 'Reference to the primary operator or production technician responsible for executing this batch. Used for accountability, training tracking, and electronic signature compliance (21 CFR Part 11).',
    `quaternary_batch_approved_by_employee_id` BIGINT COMMENT 'Reference to the authorized person (typically QA manager or production manager) who gave final approval for batch release. Required for GMP batch release authorization.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: BATCH: Each batch fulfills a specific quote line; FK supports batch‑level traceability to sales commitments and compliance reporting.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: REQUIRED: Quality and traceability reports link each batch record to the goods receipt that delivered the raw material lot.',
    `tertiary_batch_reviewed_by_employee_id` BIGINT COMMENT 'Reference to the quality assurance (QA) or quality control (QC) personnel who reviewed this batch record. Required for GMP compliance and electronic signature audit trail.',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'Actual quantity produced by this batch after completion. Used to calculate yield percentage, material efficiency, and production performance (OEE - Overall Equipment Effectiveness).',
    `actual_yield_uom` STRING COMMENT 'Unit of measure for the actual yield quantity. Should match batch_size_uom for yield percentage calculation.. Valid values are `^[A-Z]{2,6}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record received final approval for release to inventory. Part of the electronic signature audit trail and batch release documentation.',
    `batch_number` STRING COMMENT 'Externally-known unique batch identifier (LOT number) used for product traceability, customer communication, Certificate of Analysis (COA) issuance, and regulatory reporting. Must be globally unique across all production history.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'Planned or target quantity for this batch expressed in the base unit of measure. Used for yield calculation, material consumption planning, and production scheduling.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size quantity (e.g., KG, L, MT, GAL). Must align with the formula base unit and inventory unit of measure.. Valid values are `^[A-Z]{2,6}$`',
    `batch_status` STRING COMMENT 'Current lifecycle state of the batch in the manufacturing execution workflow. Governs whether the batch can be released to inventory, requires quality review, or is blocked for regulatory or quality reasons.. Valid values are `in_process|released|rejected|quarantine|on_hold|completed`',
    `coa_issued_flag` BOOLEAN COMMENT 'Boolean indicator that a Certificate of Analysis (COA) has been issued for this batch. COA is required for customer shipments and regulatory compliance.',
    `coa_number` STRING COMMENT 'Unique identifier for the Certificate of Analysis issued for this batch. Links the batch record to the quality test results and customer documentation.. Valid values are `^[A-Z0-9_-]{6,30}$`',
    `comments` STRING COMMENT 'Free-text field for operator or supervisor comments, observations, or notes about the batch execution. Used for capturing contextual information not covered by structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was first created in the system. Part of the audit trail for electronic records compliance (21 CFR Part 11).',
    `dcs_batch_reference` STRING COMMENT 'Unique batch identifier from the Distributed Control System (Honeywell Experion, Siemens PCS 7) that executed the process automation. Links the batch record to real-time process data historian (Aveva PI System).. Valid values are `^[A-Z0-9_-]{6,40}$`',
    `deviation_count` STRING COMMENT 'Number of process deviations, exceptions, or Out of Specification (OOS) events recorded during batch execution. Triggers CAPA (Corrective and Preventive Action) and RCI (Root Cause Investigation) workflows.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator that one or more exceptions occurred during batch execution. Used to filter batches requiring quality review or management attention.',
    `expiry_date` DATE COMMENT 'Date after which the batch is no longer suitable for use or sale. Calculated based on manufacturing date and product shelf-life specification. Critical for FEFO (First Expired First Out) inventory management.',
    `formula_version` STRING COMMENT 'Version identifier of the formula or recipe used for this batch. Critical for traceability when formulas are revised due to MOC (Management of Change) or process optimization.. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean indicator that this batch was produced under GMP-compliant conditions and meets all regulatory requirements for pharmaceutical or food-contact chemical production.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this batch record was last updated. Part of the audit trail for electronic records compliance and change tracking.',
    `manufacturing_date` DATE COMMENT 'Calendar date of batch production. Used for shelf-life calculation, expiry date determination, and regulatory labeling (GHS - Globally Harmonized System).',
    `manufacturing_end_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was completed and the batch was ready for quality inspection. Used for cycle time analysis and production scheduling.',
    `manufacturing_start_timestamp` TIMESTAMP COMMENT 'Date and time when batch production was initiated on the manufacturing floor. Captured from MES (Manufacturing Execution System) or DCS (Distributed Control System) transaction log.',
    `mes_system_version` STRING COMMENT 'Version of the MES or DCS system that recorded this batch. Required for 21 CFR Part 11 compliance and system validation audit trail.. Valid values are `^[A-Z0-9._-]{1,20}$`',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction identifier from the MES system that initiated or recorded this batch. Used for audit trail linkage and electronic records compliance (21 CFR Part 11).. Valid values are `^[A-Z0-9_-]{10,50}$`',
    `process_ph_avg` DECIMAL(18,2) COMMENT 'Average pH level during the critical reaction phase. Key process parameter for chemical synthesis quality control and product specification compliance.',
    `process_pressure_avg` DECIMAL(18,2) COMMENT 'Average process pressure during the critical reaction phase, measured in bar. Key process parameter for quality control and process safety management (PSM).',
    `process_temperature_avg` DECIMAL(18,2) COMMENT 'Average process temperature during the critical reaction phase, measured in degrees Celsius. Key process parameter for quality control and SPC (Statistical Process Control) analysis.',
    `reaction_time_minutes` STRING COMMENT 'Total duration of the chemical reaction phase in minutes. Critical process parameter for yield optimization and product quality consistency.',
    `recipe_phase_executed` STRING COMMENT 'Comma-separated list or summary of recipe phases executed during this batch (e.g., charging, heating, reaction, cooling, discharge). Provides high-level execution summary for batch genealogy.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Boolean indicator that this batch is under regulatory hold and cannot be released to inventory or shipped until regulatory clearance is obtained. May be set by EHS (Environment Health and Safety) or quality assurance.',
    `retest_date` DATE COMMENT 'Date when the batch must be retested to confirm continued compliance with quality specifications. Common for raw materials and intermediate products with extended storage periods.',
    `review_status` STRING COMMENT 'Current status of the batch record review and approval workflow. Governs whether the batch can be released to inventory or requires additional quality or management review.. Valid values are `pending|in_review|approved|rejected`',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record was reviewed and approved or rejected by quality assurance. Part of the electronic signature audit trail (21 CFR Part 11).',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield efficiency as a percentage of actual yield to planned batch size. Key performance indicator for production efficiency and process optimization (SPC - Statistical Process Control).',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic Batch Record (EBR) and complete MES execution audit trail serving as the authoritative manufacturing history for a single production batch (21 CFR Part 11 compliant). Captures batch number (LOT), batch size, batch status (in-process, released, rejected, quarantine), manufacturing date, expiry/retest dates, manufacturing order reference, formula/recipe version, and the full step-by-step execution log: MES transaction IDs, recipe phases executed, execution start/end timestamps per step, operator IDs, equipment IDs, actual parameter values entered, electronic signatures (21 CFR Part 11), instruction text displayed, operator responses/confirmations, exception flags, deviation count, review/approval signatures, GMP compliance flag, COA linkage, regulatory hold flags, and MES system version. The single authoritative document for batch genealogy tracing, regulatory audits, GMP batch release, electronic records compliance, and production floor execution verification.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_order` (
    `process_order_id` BIGINT COMMENT 'Unique identifier for the process order. Primary key for the process order entity in the SAP PP (Production Planning) module.',
    `campaign_id` BIGINT COMMENT 'Identifier linking multiple process orders in a production campaign. Used for extended manufacturing runs of the same product to minimize changeover, reduce CIP cycles, and optimize asset utilization.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Process order scheduling and quality checks depend on product master to obtain recipe, hazard class, and regulatory data.',
    `control_recipe_id` BIGINT COMMENT 'Identifier for the control recipe downloaded to the DCS (Honeywell Experion, Siemens PCS 7) or PLC (Programmable Logic Controller) for automated execution. Links master recipe to real-time process control logic.',
    `employee_id` BIGINT COMMENT 'SAP user ID of the production planner or scheduler who created the process order. Used for audit trail and SOX (Sarbanes-Oxley Act) compliance.',
    `formula_version_id` BIGINT COMMENT 'Foreign key linking to formulation.formula_version. Business justification: Process Order Execution Sheet tracks the specific formula version executed for compliance and quality release.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Required for Production‑Maintenance Coordination Report that matches each process order with its scheduled maintenance work order to avoid line conflicts.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Process Order Execution requires raw‑material safety and quality data; FK enables real‑time compliance checks.',
    `product_order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Production scheduling dashboards require linking process orders directly to the originating sales order for capacity planning and KPI tracking.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: PROCESS_ORDER: Schedules execution of a quoted line item; linking enables alignment of production planning with sales commitments.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Supports Process Order Planned Inventory Allocation used in material planning dashboards.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when manufacturing execution completed and product was discharged, as confirmed by MES or operator. Triggers quality inspection workflow and lot release process.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when manufacturing execution began, as confirmed by MES or operator. Used for OEE (Overall Equipment Effectiveness) calculation and schedule variance analysis.',
    `batch_size_category` STRING COMMENT 'Classification of process order scale. Lab for R&D bench-scale (<10kg), pilot for scale-up trials (10-1000kg), commercial for standard production (>1000kg), full_scale for maximum reactor capacity utilization.. Valid values are `lab|pilot|commercial|full_scale`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished product manufactured and confirmed by operator or MES. May differ from planned due to yield loss, reaction efficiency, or quality rejections.',
    `cost_center` STRING COMMENT 'Financial cost center to which process order costs (raw materials, labor, utilities, overhead) are allocated. Used for COGS (Cost of Goods Sold) calculation and OpEx (Operating Expenditure) tracking.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the process order record was created in SAP PP. Marks the beginning of the order lifecycle for lead time analysis and planning cycle measurement.',
    `dcs_system_reference` STRING COMMENT 'Identifier for the DCS or SCADA system instance managing this process order. Maps to Honeywell Experion, Siemens SIMATIC PCS 7, or Aveva PI System historian for real-time data integration.',
    `environmental_permit_number` STRING COMMENT 'EPA or state environmental permit number authorizing manufacture of this chemical. Required for VOC (Volatile Organic Compound), HAP (Hazardous Air Pollutant), and TRI reportable substances. Links to air quality monitoring and emissions reporting.',
    `hazard_classification` STRING COMMENT 'GHS hazard classification for the product being manufactured. Determines PSM (Process Safety Management) requirements, permit-to-work rules, and EHS monitoring. Aligns with SDS Section 2 hazard identification. [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|explosive|reactive — 7 candidates stripped; promote to reference product]',
    `inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number created for quality testing. Links process order to LIMS (Laboratory Information Management System) sample management and COA generation workflow.',
    `last_modified_by` STRING COMMENT 'SAP user ID of the last person to update the process order. Tracks changes to quantities, dates, or status for change management and compliance audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the process order record. Used for data synchronization, incremental ETL, and change data capture in the lakehouse silver layer.',
    `lot_number` STRING COMMENT 'Unique lot or batch number assigned to the finished product for traceability. Links to COA (Certificate of Analysis), lot genealogy, and regulatory reporting (TRI - Toxics Release Inventory, TSCA - Toxic Substances Control Act). Required for GMP (Good Manufacturing Practice) compliance.. Valid values are `^[A-Z0-9]{8,15}$`',
    `mes_integration_status` STRING COMMENT 'Status of process order synchronization with MES. Tracks order handoff from SAP PP to shop floor execution system. Failed status triggers manual intervention and CAPA (Corrective and Preventive Action) workflow.. Valid values are `not_sent|sent|acknowledged|in_execution|completed|failed`',
    `moc_number` STRING COMMENT 'Management of Change request number if this process order executes under modified conditions (new raw material supplier, revised process parameters, equipment substitution). Required for PSM compliance and HAZOP (Hazard and Operability Study) review.',
    `order_status` STRING COMMENT 'Current lifecycle state of the process order. Created indicates planning stage, released means approved for execution, in_progress indicates active manufacturing, confirmed means operator has reported completion, completed indicates all confirmations and quality checks done, closed means financially settled, cancelled means order terminated, on_hold indicates temporary suspension pending MOC (Management of Change) or safety review. [ENUM-REF-CANDIDATE: created|released|in_progress|confirmed|completed|closed|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the process order based on manufacturing execution mode. Batch for discrete lot production, continuous for ongoing flow processes, campaign for extended multi-batch runs, rework for reprocessing OOS (Out of Specification) material, trial for R&D (Research and Development) scale-up, pilot for pre-commercial validation.. Valid values are `batch|continuous|campaign|rework|trial|pilot`',
    `planned_end_date` DATE COMMENT 'Scheduled date for process order completion and final product discharge. Used for capacity planning and customer delivery commitments.',
    `planned_end_time` TIMESTAMP COMMENT 'Precise timestamp for scheduled process order completion. Includes reaction time, cooling, CIP (Clean In Place), and quality hold time.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of finished product to be manufactured in this process order. Expressed in base unit of measure from material master (kg, L, MT).',
    `planned_start_date` DATE COMMENT 'Scheduled date for process order release and initiation of manufacturing operations. Used for production scheduling, raw material staging, and resource allocation.',
    `planned_start_time` TIMESTAMP COMMENT 'Precise timestamp for scheduled process order start. Critical for continuous processes and multi-stage reaction sequences requiring tight timing control.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant where the process order is executed. Maps to SAP plant master data and determines applicable EHS (Environment Health and Safety) regulations, DCS system instance, and local SOP (Standard Operating Procedure) library.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_code` STRING COMMENT 'Scheduling priority for the process order. Urgent for customer expedite or safety stock replenishment, high for committed delivery dates, normal for standard production, low for inventory build.. Valid values are `urgent|high|normal|low`',
    `process_order_number` STRING COMMENT 'Externally visible business identifier for the process order. Unique alphanumeric code used across SAP PP, MES (Manufacturing Execution System), and DCS (Distributed Control System) integration points.. Valid values are `^[A-Z0-9]{10,12}$`',
    `production_line` STRING COMMENT 'Identifier for the specific production line, reactor train, or blending unit where the process order is scheduled. Links to P&ID (Piping and Instrumentation Diagram) and SCADA (Supervisory Control and Data Acquisition) tag hierarchy.',
    `production_version` STRING COMMENT 'Four-digit version number linking the material to a specific BOM and routing combination. Enables multiple manufacturing pathways for the same product (e.g., different catalyst systems, alternate raw materials under REACH compliance).. Valid values are `^[0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Boolean indicator that finished product requires QC (Quality Control) inspection and COA generation before lot release. True for GMP products, API (Active Pharmaceutical Ingredient), food-contact chemicals, and customer-specific quality agreements.',
    `recipe_number` STRING COMMENT 'Identifier for the master recipe (PI sheet) that defines the synthesis pathway, reaction sequence, process parameters, and control strategy. Links to BOM (Bill of Materials), routing, and control recipe in DCS.. Valid values are `^[A-Z0-9]{8,12}$`',
    `settlement_rule` STRING COMMENT 'Financial settlement method for process order costs. Standard for normal production, variance for cost deviation analysis, scrap for write-off of OOS material, rework for reprocessing cost allocation. Links to FI/CO (Finance and Controlling) cost center settlement.. Valid values are `standard|variance|scrap|rework`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for quantity fields. KG for kilograms, L for liters, MT for metric tons, GAL for gallons, LB for pounds, TON for short tons. Must align with material master UOM.. Valid values are `KG|L|MT|GAL|LB|TON`',
    `variance_flag` BOOLEAN COMMENT 'Boolean indicator that actual results (yield, cycle time, cost) deviated significantly from plan. True triggers variance analysis workflow and potential RCI (Root Cause Investigation) for process improvement.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Calculated yield as percentage of actual output versus theoretical maximum based on stoichiometry and recipe. Used for process optimization, SPC (Statistical Process Control), and variance analysis. Formula: (confirmed_quantity / theoretical_quantity) * 100.',
    CONSTRAINT pk_process_order PRIMARY KEY(`process_order_id`)
) COMMENT 'SAP PP Process Order entity representing a discrete manufacturing execution instruction for a chemical synthesis or blending run. Distinct from production_order in that it is specifically tied to a master recipe (PI sheet) and process industry workflow. Captures process order number, recipe reference, process order type, plant, production version, scheduled quantities, actual confirmed quantities, phase sequence, control recipe destination (DCS/PLC system ID), MES integration status, settlement rule, and variance analysis flags. Used for batch and continuous chemical process manufacturing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` (
    `batch_genealogy_id` BIGINT COMMENT 'Unique identifier for the batch genealogy record tracking parent-child lineage relationships between chemical batches.',
    `employee_id` BIGINT COMMENT 'The identifier of the production operator who executed or confirmed the batch transfer creating this genealogy relationship.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Link batch genealogy to its manufacturing order for traceability; production_order_number is redundant once the FK exists.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Batch Genealogy traceability links each child batch to the originating raw material for audit and regulatory reporting.',
    `bom_item_number` STRING COMMENT 'The BOM item number from the production recipe that defines this parent-child material relationship. Links to SAP PP BOM structure.',
    `child_batch_number` STRING COMMENT 'The batch number of the downstream child batch (intermediate or finished good) produced in this production relationship. Part of the lot genealogy traceability chain.',
    `coa_reference_number` STRING COMMENT 'The COA reference number associated with this batch genealogy relationship, linking to quality test results and compliance documentation.',
    `consumption_percentage` DECIMAL(18,2) COMMENT 'The percentage of the parent batch consumed to produce the child batch, enabling yield and material balance calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this batch genealogy record was first created in the system, providing audit trail for data lineage.',
    `customer_order_number` STRING COMMENT 'The customer order number if this batch genealogy relationship was created for a specific customer order, enabling customer-specific traceability.',
    `dcs_batch_reference` STRING COMMENT 'The batch identifier from the DCS (Honeywell Experion or Siemens PCS 7) that recorded this batch relationship in real-time process control.',
    `deviation_number` STRING COMMENT 'The deviation number if this batch relationship occurred under non-standard conditions requiring documentation and approval.',
    `expiration_date` DATE COMMENT 'The expiration date of the child batch produced in this genealogy relationship, inherited or calculated from parent batch shelf life.',
    `genealogy_status` STRING COMMENT 'The current status of this batch genealogy record: active (normal traceability), archived (historical record), quarantined (batch under quality hold), recalled (batch subject to recall action).. Valid values are `active|archived|quarantined|recalled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this batch genealogy record was last modified, supporting audit trail and change tracking requirements.',
    `mes_transaction_reference` STRING COMMENT 'The MES transaction identifier that recorded this batch genealogy event, providing audit trail linkage to the execution system.',
    `moc_number` STRING COMMENT 'The MOC number if this batch genealogy relationship was created under a process change or deviation. Links to EHS Management of Change records.',
    `parent_batch_number` STRING COMMENT 'The batch number of the upstream parent batch (raw material or intermediate) consumed in this production relationship. Part of the lot genealogy traceability chain.',
    `plant_code` STRING COMMENT 'The manufacturing plant code where this batch genealogy relationship was created. Links to SAP organizational structure.',
    `process_step_code` STRING COMMENT 'The specific process step or operation code in the manufacturing route where this batch relationship occurred (e.g., synthesis, blending, filtration, drying). Maps to MES (Manufacturing Execution System) operation codes.',
    `process_step_description` STRING COMMENT 'Human-readable description of the process step where the batch relationship occurred, providing context for the genealogy link.',
    `quality_status` STRING COMMENT 'The quality status of the batch relationship at the time of transfer: released (approved for use), blocked (quality hold), restricted (conditional use), inspection (pending QC).. Valid values are `released|blocked|restricted|inspection`',
    `quantity_transferred` DECIMAL(18,2) COMMENT 'The quantity of material transferred from parent batch to child batch in this genealogy relationship. Measured in the unit of measure specified.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this batch genealogy relationship meets all applicable regulatory traceability requirements (REACH, FDA, TSCA). True if compliant, False if non-compliant or pending verification.',
    `relationship_type` STRING COMMENT 'The type of genealogy relationship between parent and child batches: consumed (parent used to make child), produced (child created from parent), split (one parent divided into multiple children), merged (multiple parents combined into one child), blended (multiple parents mixed into child), reworked (defective batch reprocessed).. Valid values are `consumed|produced|split|merged|blended|reworked`',
    `remarks` STRING COMMENT 'Free-text remarks or notes about this batch genealogy relationship, capturing any special conditions, observations, or contextual information.',
    `source_system` STRING COMMENT 'The source system that created this batch genealogy record: SAP_PP (SAP Production Planning), MES (Manufacturing Execution System), DCS (Distributed Control System), LIMS (Laboratory Information Management System), MANUAL (manual entry).. Valid values are `SAP_PP|MES|DCS|LIMS|MANUAL`',
    `storage_location` STRING COMMENT 'The storage location code where the batch transfer occurred or where the child batch was placed after production.',
    `traceability_chain_depth` STRING COMMENT 'The depth level of this batch relationship in the overall genealogy chain, where 1 represents direct parent-child, 2 represents grandparent-grandchild, etc. Enables multi-level traceability queries.',
    `traceability_direction` STRING COMMENT 'The direction of traceability this record supports: forward (parent to child), backward (child to parent), or bidirectional (both directions).. Valid values are `forward|backward|bidirectional`',
    `transfer_date` DATE COMMENT 'The date when the material transfer from parent to child batch occurred, establishing the temporal sequence in the genealogy chain.',
    `transfer_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the material transfer from parent to child batch was recorded in the MES or DCS system, providing exact traceability timing.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity transferred: KG (kilogram), L (liter), MT (metric ton), GAL (gallon), LB (pound), TON (ton), M3 (cubic meter). [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3 — 7 candidates stripped; promote to reference product]',
    `work_center` STRING COMMENT 'The specific work center or production line where the batch relationship occurred. Maps to SAP PP work center master data.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The yield percentage achieved in this batch transformation from parent to child, calculated as (actual output / theoretical output) * 100.',
    CONSTRAINT pk_batch_genealogy PRIMARY KEY(`batch_genealogy_id`)
) COMMENT 'Tracks the parent-child lineage of chemical batches through multi-stage synthesis and blending operations. Records upstream raw material lot numbers, intermediate batch numbers, and downstream finished goods batch numbers involved in a production run. Captures relationship type (consumed, produced, split, merged), quantity transferred, transfer date, process step, and traceability chain depth. Enables full forward and backward lot traceability required by FDA, REACH, and customer COA requests. Links raw material batches through intermediates to finished product batches.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Unique identifier for the process parameter record. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Reference to the production batch or lot during which this parameter was measured or controlled.',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment or asset where this parameter was measured or controlled.',
    `mes_recipe_id` BIGINT COMMENT 'Reference to the process recipe or formula that defines the target parameter values and control limits.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or technician who recorded or validated the parameter measurement, if applicable.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the quality assurance or process engineer who reviewed and approved this parameter record.',
    `work_order_id` BIGINT COMMENT 'Reference to the production work order under which this process parameter was recorded.',
    `alarm_priority` STRING COMMENT 'Priority level of the alarm triggered by this parameter measurement, if applicable.. Valid values are `Critical|High|Medium|Low`',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an alarm was triggered by the control system due to this parameter measurement (True if alarm triggered, False otherwise).',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the parameter measurement, deviations, or corrective actions.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action taken or planned in response to parameter deviation or violation.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required based on this parameter measurement (True if action required, False otherwise).',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality or reliability of the measured data (e.g., Good, Questionable, Bad, Estimated).. Valid values are `Good|Questionable|Bad|Estimated`',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation of the measured value from the set point, calculated as (deviation_value / set_point_value) * 100.',
    `deviation_value` DECIMAL(18,2) COMMENT 'Calculated deviation of the measured value from the set point (measured_value minus set_point_value).',
    `engineering_unit` STRING COMMENT 'Unit of measure for the parameter value (e.g., Celsius, Fahrenheit, bar, psi, pH units, liters per minute, RPM, percent, ppm).',
    `historian_source_system` STRING COMMENT 'Name of the process historian system from which this parameter data was sourced (e.g., Aveva PI System, Honeywell PHD, OSIsoft PI).',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit for Statistical Process Control (SPC). Values below this threshold indicate the process may be out of statistical control.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Lower specification limit defining the minimum acceptable value for the parameter. Values below this limit may result in out-of-specification (OOS) product.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured or observed value of the process parameter at the recorded timestamp.',
    `measurement_source` STRING COMMENT 'Source system or method by which the parameter was measured or entered (e.g., DCS, PLC, SCADA, Manual Entry, LIMS, Historian).. Valid values are `DCS|PLC|SCADA|Manual Entry|LIMS|Historian`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the parameter value was measured or recorded by the control system or operator. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `parameter_name` STRING COMMENT 'Name of the critical process parameter being measured or controlled (e.g., temperature, pressure, pH, flow rate, agitation speed, dissolved oxygen, viscosity, concentration).',
    `parameter_status` STRING COMMENT 'Current status of the parameter measurement indicating whether it is within acceptable ranges or requires investigation.. Valid values are `In Control|Out of Control|OOS|Acceptable|Under Investigation|Approved`',
    `parameter_tag_reference` STRING COMMENT 'Unique tag identifier from the DCS (Distributed Control System), SCADA (Supervisory Control and Data Acquisition), or PLC (Programmable Logic Controller) system that sources this parameter. Used for traceability to Honeywell Experion, Siemens PCS 7, or Aveva PI System.',
    `phase_name` STRING COMMENT 'Name of the batch phase or process step during which this parameter was measured (e.g., Charging, Reaction, Distillation, Cooling, Discharge).',
    `quality_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this parameter measurement has potential impact on product quality (True if quality impact identified, False otherwise).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this process parameter record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this process parameter record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the parameter record was reviewed and approved by quality assurance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sampling_interval_seconds` STRING COMMENT 'Time interval in seconds between consecutive parameter measurements or samples.',
    `set_point_value` DECIMAL(18,2) COMMENT 'Target or desired value for the process parameter as defined by the process recipe or control system.',
    `spc_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the measured value violated SPC control limits (True if violation detected, False otherwise).',
    `specification_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the measured value violated specification limits (True if out-of-specification, False otherwise).',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit for Statistical Process Control (SPC). Values above this threshold indicate the process may be out of statistical control.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Upper specification limit defining the maximum acceptable value for the parameter. Values exceeding this limit may result in out-of-specification (OOS) product.',
    CONSTRAINT pk_process_parameter PRIMARY KEY(`process_parameter_id`)
) COMMENT 'Time-series record of critical process parameters (CPPs) measured or set during a chemical manufacturing operation. Captures parameter name (temperature, pressure, pH, flow rate, agitation speed, dissolved oxygen, viscosity, concentration), tag ID from DCS/SCADA (Honeywell Experion or Siemens PCS 7), measured value, engineering unit, set point value, upper control limit (UCL), lower control limit (LCL), upper specification limit (USL), lower specification limit (LSL), timestamp, measurement source (DCS, PLC, manual entry), operator ID, and SPC violation flag. Sourced from Aveva PI System historian integration.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`reaction_step` (
    `reaction_step_id` BIGINT COMMENT 'Unique identifier for the reaction step within the chemical synthesis sequence. Primary key for the reaction step entity.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit assigned to execute this reaction step. Links to the equipment master data for traceability.',
    `formula_id` BIGINT COMMENT 'Reference to the master recipe or control recipe that defines this reaction step. Provides the template for the synthesis sequence.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the parent production order under which this reaction step is executed. Links the step to the overall manufacturing order.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Reaction Step records the specific raw material charged; linking to material_master ensures traceability and regulatory reporting.',
    `phase_id` BIGINT COMMENT 'Control recipe phase identifier from the Manufacturing Execution System (MES). Maps the step to the DCS or PLC phase for automation execution.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or technician who executed or supervised the reaction step. Required for GMP batch record traceability.',
    `synthesis_procedure_id` BIGINT COMMENT 'Foreign key linking to research.synthesis_procedure. Business justification: Links each production reaction step to the validated R&D synthesis procedure, supporting SOP enforcement and deviation investigations.',
    `actual_duration_minutes` DECIMAL(18,2) COMMENT 'Actual elapsed time for the reaction step execution in minutes. Captured from MES or DCS for process performance analysis and Overall Equipment Effectiveness (OEE) calculation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this step requires supervisory or quality approval before proceeding to the next step. Used for critical process control points.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the reaction step was approved. Captures the approval event for audit trail and batch record documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reaction step record was first created in the system. Audit trail for data lineage and record creation tracking.',
    `critical_step_flag` BOOLEAN COMMENT 'Indicates whether this step is a critical control point requiring enhanced monitoring, verification, or approval. Used for Good Manufacturing Practice (GMP) and Process Safety Management (PSM) compliance.',
    `dcs_batch_reference` STRING COMMENT 'Batch identifier from the Distributed Control System (Honeywell Experion, Siemens PCS 7) that executed this reaction step. Links MES data to process automation data.',
    `deviation_description` STRING COMMENT 'Detailed description of any process deviation, out-of-specification condition, or abnormal event that occurred during the reaction step execution. Used for Root Cause Investigation (RCI) and CAPA.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether any process deviation or out-of-specification (OOS) condition occurred during this reaction step. Triggers investigation and Corrective and Preventive Action (CAPA) processes.',
    `material_charge_quantity` DECIMAL(18,2) COMMENT 'Quantity of material charged or added during this reaction step. Applicable for charge-type steps and used for Bill of Materials (BOM) consumption tracking.',
    `material_charge_uom` STRING COMMENT 'Unit of measure for the material charge quantity (e.g., kg, L, mol). Ensures proper inventory consumption and yield calculation.',
    `moc_reference` STRING COMMENT 'Reference to any Management of Change (MOC) record associated with modifications to this reaction step. Ensures controlled changes to the manufacturing process.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this reaction step record was last modified. Audit trail for change tracking and data governance.',
    `required_equipment_type` STRING COMMENT 'Type or class of equipment required to execute this reaction step (e.g., reactor, distillation column, filter press, blender). Used for resource allocation and scheduling.',
    `scada_tag_reference` STRING COMMENT 'Reference to the SCADA or process historian (Aveva PI System) tag that captures real-time process data for this reaction step. Enables linkage to time-series process data.',
    `sequence_order` STRING COMMENT 'Execution order within the overall synthesis sequence. May differ from step_number if parallel or conditional steps exist.',
    `sop_reference` STRING COMMENT 'Reference to the Standard Operating Procedure document governing the execution of this reaction step. Ensures compliance with documented procedures.',
    `step_end_timestamp` TIMESTAMP COMMENT 'Date and time when the reaction step execution completed. Used to calculate actual duration and for batch genealogy tracking.',
    `step_name` STRING COMMENT 'Descriptive name of the reaction step (e.g., Charge Reactant A, Heat to Reflux, Cool and Filter). Provides human-readable identification of the process phase.',
    `step_notes` STRING COMMENT 'Free-text notes or comments recorded by the operator during the execution of this reaction step. Captures observations, adjustments, or contextual information for the batch record.',
    `step_number` STRING COMMENT 'Sequential number of this step within the reaction sequence. Defines the order of execution in the synthesis workflow.',
    `step_start_timestamp` TIMESTAMP COMMENT 'Date and time when the reaction step execution began. Captured from MES or DCS for process traceability and batch record documentation.',
    `step_status` STRING COMMENT 'Current execution status of the reaction step. Tracks the lifecycle state of the step within the production order. [ENUM-REF-CANDIDATE: not_started|in_progress|completed|paused|aborted|failed|skipped — 7 candidates stripped; promote to reference product]',
    `step_type` STRING COMMENT 'Classification of the reaction step operation type. Defines the nature of the process activity being performed. [ENUM-REF-CANDIDATE: charge|heat|react|cool|filter|distill|blend|transfer|clean|sample|hold|neutralize|crystallize|dry — 14 candidates stripped; promote to reference product]',
    `target_agitation_rpm` DECIMAL(18,2) COMMENT 'Target agitation or stirring speed in revolutions per minute (RPM). Controls mixing intensity for homogeneous reaction conditions.',
    `target_duration_minutes` DECIMAL(18,2) COMMENT 'Planned or target duration for the reaction step in minutes as defined in the master recipe. Used for scheduling and capacity planning.',
    `target_ph` DECIMAL(18,2) COMMENT 'Target pH level for the reaction step. Critical for acid-base reactions, neutralization, and pH-sensitive synthesis processes.',
    `target_pressure_bar` DECIMAL(18,2) COMMENT 'Target or setpoint pressure for the reaction step in bar. Critical process parameter for reactions requiring pressurized conditions.',
    `target_temperature_c` DECIMAL(18,2) COMMENT 'Target or setpoint temperature for the reaction step in degrees Celsius. Critical process parameter for chemical synthesis control.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield achieved in this reaction step as a percentage of theoretical yield. Key performance indicator for process efficiency and optimization.',
    CONSTRAINT pk_reaction_step PRIMARY KEY(`reaction_step_id`)
) COMMENT 'Defines individual reaction or process steps within a chemical synthesis sequence or master recipe. Captures step number, step name, step type (charge, heat, react, cool, filter, distill, blend, transfer, clean), target duration, actual duration, sequence order, phase assignment, critical step flag, SOP reference, control recipe phase ID, required equipment type, and step completion status. Supports multi-step synthesis workflows and provides the operational backbone for process order execution and MES phase tracking.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` (
    `bom_consumption_id` BIGINT COMMENT 'Unique identifier for the BOM consumption transaction record.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: BOM consumption tracking needs product master reference to validate material codes, safety data, and costing.',
    `employee_id` BIGINT COMMENT 'User ID of the person who posted the consumption transaction in the system.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order against which this material consumption was posted.',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or intermediate component consumed in this transaction.',
    `actual_quantity_consumed` DECIMAL(18,2) COMMENT 'Actual quantity of material consumed and posted against the production order.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this consumption was posted automatically via backflushing at production confirmation.',
    `bom_line_item_number` STRING COMMENT 'Line item sequence number in the BOM structure indicating which component this consumption relates to.',
    `cas_number` STRING COMMENT 'CAS registry number of the consumed chemical substance for regulatory tracking and compliance.',
    `cost_center_code` STRING COMMENT 'Cost center to which the material consumption cost is allocated.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date of the physical goods movement or consumption event.',
    `goods_recipient` STRING COMMENT 'Name or identifier of the person or entity receiving the goods for production use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consumption record was last updated or modified.',
    `lot_number` STRING COMMENT 'Lot or batch number of the consumed material, enabling full traceability and genealogy.',
    `material_document_number` STRING COMMENT 'Unique document number generated by SAP MM for the goods movement transaction.',
    `material_document_year` STRING COMMENT 'Fiscal year of the material document for archival and retrieval purposes.',
    `movement_type` STRING COMMENT 'SAP MM movement type code indicating the nature of the goods movement (e.g., 261 for goods issue to production order, 262 for reversal).',
    `operation_number` STRING COMMENT 'Routing operation number to which this material consumption is allocated.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Quantity of material planned to be consumed according to the BOM for this production order.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the consumption occurred.',
    `posting_date` DATE COMMENT 'Date on which the material consumption was posted in the system.',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consumption record was created in the system.',
    `production_order_number` STRING COMMENT 'Business identifier of the production order for which materials were consumed.',
    `reason_code` STRING COMMENT 'Code indicating the reason for consumption variance or manual posting, if applicable.',
    `reservation_item_number` STRING COMMENT 'Line item number within the reservation document.',
    `reservation_number` STRING COMMENT 'Material reservation number linked to this consumption, if applicable.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this consumption record is a reversal of a previous posting.',
    `reversed_document_number` STRING COMMENT 'Material document number of the original transaction that this record reverses, if applicable.',
    `special_stock_indicator` STRING COMMENT 'Code indicating special stock type (e.g., consignment, project stock, sales order stock).',
    `standard_cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for the consumed material at the time of posting.',
    `storage_location_code` STRING COMMENT 'Code identifying the storage location from which the material was withdrawn.',
    `total_cost_amount` DECIMAL(18,2) COMMENT 'Total cost impact of this consumption transaction, calculated as actual_quantity_consumed * standard_cost_per_unit.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the consumed quantity (e.g., KG, L, MT, GAL).',
    `unloading_point` STRING COMMENT 'Physical location or point where the material was delivered for consumption.',
    `valuation_type` STRING COMMENT 'Valuation type or split valuation category for the consumed material.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between planned and actual consumption, calculated as (variance_quantity / planned_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between planned and actual consumed quantity (actual minus planned).',
    `work_center_code` STRING COMMENT 'Code of the work center where the material was consumed during production.',
    CONSTRAINT pk_bom_consumption PRIMARY KEY(`bom_consumption_id`)
) COMMENT 'Transactional record of actual raw material and intermediate component consumption against a production or process order BOM. Captures material number, component description, BOM line item, planned quantity, actual quantity consumed, unit of measure, lot number consumed, storage location, goods movement type (SAP MM 261/262), posting date, backflush flag, variance quantity, variance percentage, and cost impact. Enables yield analysis, material balance reconciliation, and COGS calculation per batch. Sourced from SAP PP goods movement postings.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the yield record. Primary key for the yield record entity.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Yield reporting ties actual yields to the product master for performance analysis and regulatory reporting.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order or manufacturing order (SAP PP module) for which this yield was recorded. Links yield data to the specific production execution.',
    `employee_id` BIGINT COMMENT 'The employee or operator identifier who confirmed the yield and completed the batch record. Used for accountability and training effectiveness tracking.',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of product produced and confirmed in the production run. This is the measured output after completion of the batch.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to this production run. Critical for traceability, genealogy tracking, and Certificate of Analysis (COA) linkage.. Valid values are `^[A-Z0-9]{6,20}$`',
    `by_product_code` STRING COMMENT 'The material code or SKU for the by-product generated. References the by-product master data in the materials management system.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `by_product_quantity` DECIMAL(18,2) COMMENT 'The quantity of by-products or co-products generated during the production process. By-products may have commercial value or require disposal.',
    `data_source_system` STRING COMMENT 'The source system from which the yield data was captured. Indicates whether data originated from SAP PP, MES, DCS (Honeywell Experion or Siemens PCS 7), LIMS, or manual entry.. Valid values are `SAP_PP|MES|DCS_Honeywell|DCS_Siemens|LIMS|Manual`',
    `inspection_lot_number` STRING COMMENT 'The quality inspection lot number assigned to this batch for QC testing. Links yield records to quality inspection results and COA (Certificate of Analysis) data.. Valid values are `^[A-Z0-9]{6,20}$`',
    `loss_reason_code` STRING COMMENT 'Categorical code indicating the primary reason for yield loss. Used for root cause analysis, process improvement, and CAPA (Corrective and Preventive Action) initiatives. [ENUM-REF-CANDIDATE: evaporation|spillage|sampling|reaction_inefficiency|filtration_loss|equipment_holdup|transfer_loss|quality_rejection|other — 9 candidates stripped; promote to reference product]',
    `planned_yield_quantity` DECIMAL(18,2) COMMENT 'The theoretical or planned yield quantity expected from the production order based on the Bill of Materials (BOM) and process parameters. Represents the target output under ideal conditions.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility where the production occurred. Aligns with SAP plant master data.. Valid values are `^[A-Z0-9]{2,10}$`',
    `process_order_type` STRING COMMENT 'The type of production process used for this yield record. Distinguishes between batch processing, continuous processing, semi-batch, or campaign manufacturing modes.. Valid values are `batch|continuous|semi_batch|campaign`',
    `production_end_timestamp` TIMESTAMP COMMENT 'The date and time when the production batch or run was completed and yield was confirmed. Used for cycle time analysis and OEE calculation.',
    `production_line_code` STRING COMMENT 'Identifier for the production line, reactor, or processing unit where the batch was manufactured. May reference DCS (Distributed Control System) or MES (Manufacturing Execution System) equipment identifiers.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `production_start_timestamp` TIMESTAMP COMMENT 'The date and time when the production batch or run was started. Captured from MES (Manufacturing Execution System) or DCS (Distributed Control System) logs.',
    `quality_status` STRING COMMENT 'The quality control status of the batch. Indicates whether the batch has been approved for release, is pending QC testing, or has been rejected. Links to Certificate of Analysis (COA) and quality inspection results.. Valid values are `pending|approved|rejected|on_hold|released`',
    `raw_material_cost` DECIMAL(18,2) COMMENT 'The total cost of raw materials consumed in this production run. Used for cost accounting, COGS (Cost of Goods Sold) calculation, and yield-based profitability analysis.',
    `recipe_version` STRING COMMENT 'The version of the production recipe or master formula used for this batch. Critical for traceability and Management of Change (MOC) compliance.. Valid values are `^[A-Z0-9.]{1,20}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was first created in the data system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this yield record was last modified. Critical for change tracking and audit compliance.',
    `remarks` STRING COMMENT 'Free-text field for operator or supervisor comments regarding yield performance, process deviations, or special conditions during production. Used for batch record documentation and deviation investigations.',
    `theoretical_yield_basis` STRING COMMENT 'The method or basis used to calculate the planned yield. Indicates whether the theoretical yield was derived from BOM standards, process simulation (e.g., Aspen HYSYS), historical averages, or lab/pilot scale data.. Valid values are `bom_standard|process_simulation|historical_average|lab_scale|pilot_scale`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for yield quantities (e.g., kilograms, liters, metric tons). Must align with product master data and BOM unit of measure. [ENUM-REF-CANDIDATE: kg|g|L|mL|MT|lb|gal|ton|m3 — 9 candidates stripped; promote to reference product]',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage used to determine if yield_variance_flag should be set. Typically defined in process control plans or SOPs (Standard Operating Procedures).',
    `waste_classification` STRING COMMENT 'Classification of the waste material for environmental and regulatory purposes. Indicates whether waste is hazardous, contains VOC (Volatile Organic Compounds), HAP (Hazardous Air Pollutants), or is recyclable.. Valid values are `hazardous|non_hazardous|recyclable|voc|hap`',
    `waste_quantity` DECIMAL(18,2) COMMENT 'The quantity of waste material generated during production that requires disposal or treatment. Critical for environmental reporting and TRI (Toxics Release Inventory) compliance.',
    `yield_confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the actual yield quantity was confirmed and recorded in the system. May differ from production_end_timestamp if post-production weighing or measurement is required.',
    `yield_efficiency_score` DECIMAL(18,2) COMMENT 'A normalized efficiency score (0-100) that factors in yield percentage, quality status, and process losses. Used for benchmarking and continuous improvement initiatives.',
    `yield_loss_quantity` DECIMAL(18,2) COMMENT 'The total quantity of material lost during the production process due to evaporation, spillage, sampling, filtration loss, reaction inefficiency, or other process losses. Represents unrecoverable material.',
    `yield_percentage` DECIMAL(18,2) COMMENT 'The yield efficiency expressed as a percentage, calculated as (actual_yield_quantity / planned_yield_quantity) * 100. Key performance indicator for process efficiency and OEE (Overall Equipment Effectiveness) calculation.',
    `yield_variance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the yield variance exceeds acceptable tolerance limits. True indicates an out-of-specification (OOS) or out-of-trend (OOT) condition requiring investigation.',
    `yield_variance_quantity` DECIMAL(18,2) COMMENT 'The absolute difference between planned and actual yield (planned_yield_quantity - actual_yield_quantity). Positive values indicate under-production; negative values indicate over-production.',
    CONSTRAINT pk_yield_record PRIMARY KEY(`yield_record_id`)
) COMMENT 'Captures actual production yield data for each batch or production run, comparing theoretical yield to actual output. Records planned yield quantity, actual yield quantity, yield percentage, theoretical yield basis, yield loss quantity, loss reason code (evaporation, sampling, spillage, reaction inefficiency, filtration loss), unit of measure, by-product quantities, waste quantities, and yield variance flag. Supports process optimization, SPC trending, OEE calculation, and raw material efficiency reporting. Critical for cost accounting and process improvement initiatives.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Primary key for schedule',
    `bill_of_materials_id` BIGINT COMMENT 'Reference to the Bill of Materials that defines the raw material components and quantities required for this scheduled production.',
    `campaign_id` BIGINT COMMENT 'Identifier linking this schedule to a production campaign when campaign_flag is true. Multiple schedules may share the same campaign ID.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Production scheduling aligns planned quantities with product master data for capacity planning and compliance.',
    `demand_forecast_id` BIGINT COMMENT 'Reference to the demand forecast that is driving this production schedule, if this is make-to-stock production.',
    `employee_id` BIGINT COMMENT 'Reference to the production planner or scheduler responsible for creating and maintaining this schedule.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the parent production order that this schedule is fulfilling.',
    `product_order_id` BIGINT COMMENT 'Reference to the customer sales order that is driving this production schedule, if this is make-to-order production.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the quality control plan that defines the inspection points, test methods, and acceptance criteria for this scheduled production.',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: SCHEDULE: Production schedules are driven by sales quotes; FK provides end‑to‑end visibility from quote to scheduled capacity.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Aligns production scheduling with R&D project timelines, critical for integrated planning, resource allocation, and milestone tracking.',
    `routing_id` BIGINT COMMENT 'Reference to the production routing that defines the sequence of operations, work centers, and process parameters for manufacturing this product.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Links production schedules to the specific stock positions reserved for the scheduled quantities.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where the scheduled production will occur.',
    `batch_size` DECIMAL(18,2) COMMENT 'The standard batch size for this production schedule. In batch chemical manufacturing, this represents the quantity produced in a single reactor charge or process cycle.',
    `campaign_flag` BOOLEAN COMMENT 'Indicates whether this schedule is part of a multi-batch production campaign where the same product is manufactured continuously across multiple batches to optimize changeover time and yield.',
    `capacity_requirement_hours` DECIMAL(18,2) COMMENT 'The total work center capacity required to complete this schedule, expressed in machine hours or labor hours.',
    `changeover_time_minutes` STRING COMMENT 'The estimated time in minutes required to changeover the work center from the previous product to this scheduled product, including cleaning (CIP), equipment reconfiguration, and line clearance.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when this scheduled production was completed and confirmed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule record was first created in the system.',
    `environmental_permit_number` STRING COMMENT 'Reference to the environmental permit or air quality permit required for this production, particularly for processes that emit VOCs (Volatile Organic Compounds) or HAPs (Hazardous Air Pollutants).',
    `expected_yield_percentage` DECIMAL(18,2) COMMENT 'The expected production yield as a percentage of theoretical maximum, accounting for normal process losses, waste, and off-spec material.',
    `frozen_flag` BOOLEAN COMMENT 'Indicates whether this schedule is frozen and locked from further changes, typically within the frozen planning horizon where changes require special approval.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule record was last updated or modified.',
    `moc_number` STRING COMMENT 'Reference to the Management of Change record if this schedule involves a process change, new formulation, or deviation from standard operating procedures.. Valid values are `^MOC-[0-9]{6}$`',
    `number_of_batches` STRING COMMENT 'The total number of batches required to fulfill the planned quantity for this schedule.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The target quantity of product to be manufactured in this schedule, expressed in the base unit of measure for the material.',
    `planning_period` STRING COMMENT 'The planning horizon period for this schedule entry, expressed as year-quarter, year-month, or year-week (e.g., 2024-Q2, 2024-M06, 2024-W23).. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2])|W(0[1-9]|[1-4][0-9]|5[0-3]))$`',
    `plant_code` STRING COMMENT 'The SAP plant code identifying the manufacturing facility where this production is scheduled.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_rank` STRING COMMENT 'Numeric priority ranking for scheduling sequence, where lower numbers indicate higher priority. Used for sequencing when multiple schedules compete for the same work center.',
    `production_line` STRING COMMENT 'The specific production line or reactor train within the work center where this schedule will be executed.',
    `released_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule was released for execution to the Manufacturing Execution System (MES) or shop floor.',
    `run_time_minutes` STRING COMMENT 'The estimated production run time in minutes to manufacture the planned quantity, excluding setup and changeover.',
    `safety_review_required_flag` BOOLEAN COMMENT 'Indicates whether this schedule requires a safety review or Process Hazard Analysis (PHA) before execution, typically for new products, process changes, or hazardous materials.',
    `schedule_number` STRING COMMENT 'Business identifier for the production schedule, externally visible and used for tracking and communication across planning and execution teams.. Valid values are `^SCH-[0-9]{8}-[0-9]{4}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule: planned (initial draft), firmed (committed but not released), released (authorized for execution), in_progress (actively running), completed (finished), cancelled (voided).. Valid values are `planned|firmed|released|in_progress|completed|cancelled`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The planned date and time when production is scheduled to complete for this schedule entry.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The planned date and time when production is scheduled to begin for this schedule entry.',
    `scheduling_constraint_notes` STRING COMMENT 'Free-text notes capturing any special scheduling constraints, dependencies, or considerations such as raw material availability, regulatory windows, customer delivery commitments, or equipment maintenance windows.',
    `scheduling_method` STRING COMMENT 'The scheduling algorithm used to create this schedule: forward (from earliest start), backward (from required delivery), finite (capacity-constrained), or infinite (capacity-unconstrained).. Valid values are `forward|backward|finite|infinite`',
    `setup_time_minutes` STRING COMMENT 'The time in minutes required to set up equipment, load raw materials, and prepare the work center before production can begin.',
    `shift_pattern` STRING COMMENT 'The shift pattern during which this production is scheduled to run (day, night, swing, continuous 24/7, or weekend).. Valid values are `day|night|swing|continuous|weekend`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned quantity (e.g., KG for kilograms, L for liters, MT for metric tons). [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3|EA — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Master production schedule (MPS) record defining planned production runs across work centers and production lines for a planning horizon. Captures schedule ID, planning period, work center, product/material number, planned quantity, scheduled start datetime, scheduled end datetime, schedule status (planned, firmed, released, completed), capacity requirement, priority rank, campaign flag (for multi-batch campaigns), changeover time, and scheduling constraint notes. Integrates with SAP PP capacity planning and MES scheduling modules.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key for work_center',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Overhead Allocation Process: work center overhead costs are allocated to a cost center for OEE and cost analysis reports.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Work center is located at a plant; adding plant_id links to plant master and allows removal of redundant plant_code.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to production.process_unit. Business justification: Work center belongs to a process unit type; adding process_unit_id creates parent reference and removes silo.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to production.resource. Business justification: Work center may be associated with a generic resource; adding resource_id creates proper reference.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the supervisor responsible for this work center, used for accountability and reporting.',
    `available_capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Standard available operating hours per day for this work center, used in capacity planning and scheduling calculations.',
    `batch_size_unit_of_measure` STRING COMMENT 'Unit of measure for batch size specifications (minimum and maximum) for this work center.. Valid values are `kg|l|m3|ton|gal|lb`',
    `capacity_category` STRING COMMENT 'Classification of capacity type used for production planning and scheduling calculations in SAP PP.. Valid values are `machine|labor|both|none`',
    `capacity_utilization_rate_percent` DECIMAL(18,2) COMMENT 'Current capacity utilization rate expressed as a percentage, indicating how much of available capacity is being used.',
    `cip_clean_in_place_capable_flag` BOOLEAN COMMENT 'Indicates whether this work center is equipped with CIP (Clean In Place) automated cleaning systems for sanitation between production runs.',
    `commissioning_date` DATE COMMENT 'Date when this work center was commissioned and put into operational service.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center master data record was first created in the system.',
    `crew_size_standard` STRING COMMENT 'Standard number of operators or crew members required to operate this work center during normal production.',
    `dcs_system_reference` STRING COMMENT 'Identifier for the DCS (Distributed Control System) node or controller managing this work center. Typically references Honeywell Experion or Siemens SIMATIC PCS 7 system nodes.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `dcs_system_type` STRING COMMENT 'Type or vendor of the DCS system controlling this work center for process automation and monitoring.. Valid values are `honeywell_experion|siemens_pcs7|yokogawa_centum|emerson_deltav|abb_800xa|other`',
    `efficiency_factor_percent` DECIMAL(18,2) COMMENT 'Standard efficiency factor applied to capacity calculations, representing the expected performance level relative to theoretical maximum.',
    `ehs_permit_required_flag` BOOLEAN COMMENT 'Indicates whether EHS (Environment Health and Safety) permits or special authorizations are required to operate this work center.',
    `gmp_classification` STRING COMMENT 'GMP (Good Manufacturing Practice) classification level for this work center, indicating compliance requirements for pharmaceutical or food-contact chemical production.. Valid values are `gmp_compliant|non_gmp|food_grade|pharmaceutical_grade|not_applicable`',
    `hazardous_area_classification` STRING COMMENT 'Electrical area classification indicating the level of explosion or fire hazard at this work center location per NFPA 70 (National Electrical Code).. Valid values are `division_1|division_2|zone_0|zone_1|zone_2|non_hazardous`',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul or significant maintenance activity performed on this work center.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center master data record was last updated or modified.',
    `maximum_batch_size` DECIMAL(18,2) COMMENT 'Maximum production batch size that can be processed at this work center, expressed in the standard unit of measure.',
    `minimum_batch_size` DECIMAL(18,2) COMMENT 'Minimum production batch size that can be processed at this work center, expressed in the standard unit of measure.',
    `next_psr_due_date` DATE COMMENT 'Scheduled date for the next required Process Safety Review or PHA (Process Hazard Analysis) for this work center.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next scheduled preventive maintenance activity for this work center.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target OEE (Overall Equipment Effectiveness) percentage for this work center, combining availability, performance, and quality metrics.',
    `operational_status` STRING COMMENT 'Current operational state of the work center indicating availability for production scheduling and execution.. Valid values are `active|inactive|maintenance|decommissioned|startup|shutdown`',
    `ph_control_capability_flag` BOOLEAN COMMENT 'Indicates whether this work center has automated pH (Potential of Hydrogen) control capabilities for chemical process management.',
    `pi_system_tag_prefix` STRING COMMENT 'Aveva PI System tag prefix used for real-time process data historian integration and time-series data collection from this work center.',
    `plc_controller_reference` STRING COMMENT 'Identifier for the PLC (Programmable Logic Controller) managing discrete control functions for this work center.',
    `pressure_control_capability_flag` BOOLEAN COMMENT 'Indicates whether this work center has automated pressure control capabilities for process management.',
    `psr_process_safety_review_date` DATE COMMENT 'Date of the most recent Process Safety Review or Process Hazard Analysis (PHA) conducted for this work center.',
    `scada_node_reference` STRING COMMENT 'SCADA (Supervisory Control and Data Acquisition) system node identifier for real-time monitoring and data collection from this work center.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup or changeover time in minutes required to prepare this work center for a new production run or product.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard teardown or cleanup time in minutes required after completing a production run at this work center.',
    `temperature_control_capability_flag` BOOLEAN COMMENT 'Indicates whether this work center has automated temperature control capabilities for process management.',
    `work_center_category` STRING COMMENT 'Operational category indicating the processing mode and operational characteristics of the work center.. Valid values are `batch_processing|continuous_processing|semi_continuous|packaging|quality_control|storage`',
    `work_center_code` STRING COMMENT 'Business identifier code for the work center used in production planning and scheduling systems. Typically sourced from SAP PP (Production Planning) module.. Valid values are `^[A-Z0-9]{4,12}$`',
    `work_center_name` STRING COMMENT 'Descriptive name of the work center for human identification and reporting purposes.',
    `work_center_type` STRING COMMENT 'Classification of the work center based on its primary production function within the chemical manufacturing process.. Valid values are `reactor|blender|distillation_column|filtration_unit|packaging_line|mixing_vessel`',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master data for production work centers, reactors, vessels, blending units, and processing lines within the chemical plant. Captures work center ID, work center name, work center type (reactor, blender, distillation column, filtration unit, packaging line), plant, cost center reference, capacity category, available capacity (hours/day), efficiency factor, utilization rate, OEE target, DCS system ID (Honeywell Experion or Siemens PCS 7 node), equipment list, and operational status. SSOT for production capacity and equipment assignment within the production domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`production_deviation` (
    `production_deviation_id` BIGINT COMMENT 'Unique identifier for the production deviation record. Primary key.',
    `batch_record_id` BIGINT COMMENT 'Reference to the production batch affected by this deviation.',
    `capa_id` BIGINT COMMENT 'Reference to the formal CAPA record created to track corrective and preventive actions for this deviation.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Deviation records need product master link to retrieve hazard classification and compliance requirements for root‑cause analysis.',
    `quality_deviation_id` BIGINT COMMENT 'FK to quality.deviation.deviation_id — Production deviations must link to formal quality deviation investigations for cGMP compliance. Enables find all deviations for batch X queries spanning production and quality.',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset involved in the deviation, if applicable.',
    `management_of_change_id` BIGINT COMMENT 'Reference to the MOC record if a formal change control process was initiated as a result of this deviation.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order during which the deviation occurred.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Deviation Management reports must reference the exact raw material to assess impact on safety and quality.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who reported the deviation.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Records the inventory location where deviated material is held, needed for deviation handling reports.',
    `tertiary_production_approved_by_employee_id` BIGINT COMMENT 'Reference to the QA manager or authorized employee who approved the deviation closure.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation investigation and resolution were formally approved and the deviation was closed.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation record was officially closed after all actions were completed and approved.',
    `corrective_action` STRING COMMENT 'Description of the corrective actions implemented to address the root cause and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deviation record was first created in the system.',
    `customer_notification_date` DATE COMMENT 'Date when affected customers were notified of the deviation, if applicable.',
    `customer_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator whether customers must be notified of this deviation due to potential product quality or safety impact.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was first detected or observed during production.',
    `deviation_number` STRING COMMENT 'Externally visible unique business identifier for the deviation, typically following format DEV-YYYYNNNN.. Valid values are `^DEV-[0-9]{8}$`',
    `deviation_type` STRING COMMENT 'Classification of the deviation by category: process (out-of-spec process parameter), material (raw material issue), equipment (equipment malfunction), documentation (procedure not followed), environmental (EHS event), safety (PSM incident), quality (OOS result), or other. [ENUM-REF-CANDIDATE: process|material|equipment|documentation|environmental|safety|quality|other — 8 candidates stripped; promote to reference product]',
    `hold_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when a quality or production hold was placed on the affected batch, if applicable.',
    `hold_released_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was released and the batch was cleared for further processing or shipment.',
    `hold_status` STRING COMMENT 'Current hold status of the affected batch or material: no_hold (no restriction), quality_hold (QA hold pending investigation), production_hold (manufacturing stopped), released (hold lifted after investigation).. Valid values are `no_hold|quality_hold|production_hold|released`',
    `immediate_action_taken` STRING COMMENT 'Description of the immediate corrective actions taken at the time of deviation detection to contain the issue.',
    `investigation_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the root cause investigation was completed and documented.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this deviation record was last updated or modified.',
    `lot_number` STRING COMMENT 'Lot or batch number of the affected material, used for traceability and genealogy.. Valid values are `^LOT-[A-Z0-9]{6,12}$`',
    `moc_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this deviation requires a formal Management of Change (MOC) process to modify procedures, equipment, or processes.',
    `oos_flag` BOOLEAN COMMENT 'Boolean indicator whether this deviation resulted in an out-of-specification (OOS) quality result.',
    `oot_flag` BOOLEAN COMMENT 'Boolean indicator whether this deviation represents an out-of-trend (OOT) condition in process or quality data.',
    `operation_number` STRING COMMENT 'Four-digit operation sequence number within the production order routing where the deviation occurred.. Valid values are `^[0-9]{4}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant where the deviation occurred.. Valid values are `^[A-Z0-9]{4}$`',
    `preventive_action` STRING COMMENT 'Description of the preventive actions taken to eliminate potential causes of similar deviations in the future.',
    `production_deviation_description` STRING COMMENT 'Detailed narrative description of the deviation event, including what was observed and the circumstances.',
    `production_deviation_status` STRING COMMENT 'Current lifecycle status of the deviation: open (newly reported), under_investigation (root cause analysis in progress), pending_approval (awaiting management review), closed (resolved and approved), cancelled (determined not a deviation).. Valid values are `open|under_investigation|pending_approval|closed|cancelled`',
    `regulatory_report_date` DATE COMMENT 'Date when the deviation was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator whether this deviation must be reported to regulatory authorities (FDA, EPA, OSHA, etc.) based on severity and impact.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the deviation was formally reported and logged in the system.',
    `root_cause` STRING COMMENT 'Identified root cause of the deviation after investigation, typically determined through RCI (Root Cause Investigation) methods.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause: human_error, equipment_failure, material_defect, process_design, environmental, procedural, or unknown (if investigation incomplete). [ENUM-REF-CANDIDATE: human_error|equipment_failure|material_defect|process_design|environmental|procedural|unknown — 7 candidates stripped; promote to reference product]',
    `severity` STRING COMMENT 'Severity level of the deviation: critical (immediate product/safety impact), major (significant quality impact), minor (low impact, correctable).. Valid values are `critical|major|minor`',
    `work_center_code` STRING COMMENT 'Code identifying the specific work center or production unit where the deviation occurred.. Valid values are `^[A-Z0-9]{6,10}$`',
    CONSTRAINT pk_production_deviation PRIMARY KEY(`production_deviation_id`)
) COMMENT 'Records deviations, non-conformances, OOS events, and production holds that occur during manufacturing. Captures deviation type, severity, affected batch, hold status, root cause, and resolution actions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_change_record` (
    `process_change_record_id` BIGINT COMMENT 'Unique identifier for the Management of Change (MOC) record. Primary key for process change tracking and PSM compliance.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who approved the change.',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: MOC (Management of Change) tracks regulatory status of affected chemicals; FK to CAS registry provides authoritative data.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Process change records must link to the affected chemical product to assess impact on SDS and regulatory filings.',
    `management_of_change_id` BIGINT COMMENT 'FK to ehs.management_of_change.management_of_change_id — Production process changes must link to master MOC for regulatory traceability. Without this, cannot generate a complete MOC audit trail across all affected domains.',
    `primary_process_initiator_employee_id` BIGINT COMMENT 'Employee identifier of the person who initiated the change request.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Associate process change records with the process order they modify; enables tracking of changes per order.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for implementing the change, captured after completion.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was implemented in the production environment.',
    `affected_equipment_tag` STRING COMMENT 'Equipment tag number or identifier for the specific equipment affected by the change, referencing P&ID documentation.',
    `affected_process_unit` STRING COMMENT 'Identification of the process unit, production line, or manufacturing area impacted by the change.',
    `affected_sop_number` STRING COMMENT 'Identifier of the SOP document that requires revision as a result of this change.',
    `approval_date` DATE COMMENT 'Date when the MOC received final approval to proceed with implementation.',
    `approval_workflow_stage` STRING COMMENT 'Current stage in the multi-level approval workflow (e.g., supervisor review, engineering review, safety review, management approval).',
    `approver_name` STRING COMMENT 'Full name of the person who provided final approval for the MOC.',
    `change_category` STRING COMMENT 'Duration classification of the change: temporary (time-limited trial), permanent (long-term modification), or emergency (immediate safety-driven change).. Valid values are `temporary|permanent|emergency`',
    `change_type` STRING COMMENT 'Classification of the type of change being requested: process (reaction parameters, operating conditions), equipment (hardware modifications), material (raw material substitutions), procedure (SOP updates), facility (infrastructure changes), or software (control system updates).. Valid values are `process|equipment|material|procedure|facility|software`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MOC record was first created in the system.',
    `document_references` STRING COMMENT 'List of supporting documents associated with the MOC, including P&IDs, SOPs, risk assessments, training materials, and approval forms.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of implementing the change, including materials, labor, downtime, and training expenses.',
    `hazop_reference_number` STRING COMMENT 'Reference identifier for the HAZOP study conducted to evaluate the change.',
    `implementation_notes` STRING COMMENT 'Detailed notes documenting the implementation process, any deviations from the plan, and observations during execution.',
    `initiator_department` STRING COMMENT 'Department or functional area of the change initiator (e.g., Production, Engineering, Quality, R&D).',
    `initiator_name` STRING COMMENT 'Full name of the person who initiated the MOC request.',
    `justification` STRING COMMENT 'Business and technical justification for the change, including expected benefits, cost savings, safety improvements, or regulatory compliance drivers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the MOC record was last updated or modified.',
    `moc_number` STRING COMMENT 'Business identifier for the MOC record. Externally-known unique number used for tracking and referencing the change across systems and documentation.. Valid values are `^MOC-[0-9]{6,10}$`',
    `pha_reference_number` STRING COMMENT 'Reference identifier for the associated PHA or HAZOP study conducted to evaluate the change.',
    `planned_implementation_date` DATE COMMENT 'Scheduled date for implementing the approved change in the production environment.',
    `post_implementation_review_date` DATE COMMENT 'Date when the post-implementation review was conducted to assess the effectiveness and safety of the change.',
    `post_implementation_review_findings` STRING COMMENT 'Summary of findings from the post-implementation review, including any corrective actions or lessons learned.',
    `post_implementation_review_required` BOOLEAN COMMENT 'Indicates whether a post-implementation review is required to verify the change achieved its objectives and did not introduce new hazards.',
    `process_change_record_description` STRING COMMENT 'Detailed narrative description of the proposed change, including technical specifications, scope, and rationale for the modification.',
    `process_change_record_status` STRING COMMENT 'Current lifecycle status of the MOC record in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|implementation|completed|closed — 8 candidates stripped; promote to reference product]',
    `regulatory_agency` STRING COMMENT 'Name of the regulatory agency that was notified (e.g., EPA, OSHA, ECHA, FDA, state environmental agency).',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory notification was submitted to the appropriate governing body.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether regulatory agencies (EPA, OSHA, ECHA, FDA) must be notified of this change due to compliance requirements.',
    `risk_assessment_required` BOOLEAN COMMENT 'Indicates whether a formal risk assessment (PHA, HAZOP, or other methodology) is required for this change.',
    `risk_assessment_summary` STRING COMMENT 'Summary of the risk assessment findings, including identified hazards, risk levels, and mitigation measures.',
    `risk_level` STRING COMMENT 'Overall risk classification assigned to the change based on the risk assessment (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the change for quick identification and reporting.',
    `training_completion_date` DATE COMMENT 'Date when all required training for affected personnel was completed.',
    `training_description` STRING COMMENT 'Description of the training content and scope provided to personnel affected by the change.',
    `training_required` BOOLEAN COMMENT 'Indicates whether operator or staff training is required before or after implementing the change.',
    CONSTRAINT pk_process_change_record PRIMARY KEY(`process_change_record_id`)
) COMMENT 'Management of Change (MOC) record tracking approved changes to production processes, equipment configurations, raw material substitutions, or operating procedures. Captures MOC number, change type (process, equipment, material, procedure, facility), change description, initiator, affected process/equipment, risk assessment summary, PHA/HAZOP reference, approval workflow status, implementation date, post-implementation review date, training requirements, and regulatory notification flag. Required for PSM compliance (OSHA 29 CFR 1910.119) and process safety management.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` (
    `dcs_event_log_id` BIGINT COMMENT 'Unique identifier for each DCS/SCADA event log entry. Primary key for the event log. Inferred role: EVENT_LOG.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the operator who acknowledged the event, performed the action, or authored the shift entry. Links to workforce/employee master data. Required for audit trail and accountability per 21 CFR Part 11.',
    `manufacturing_order_id` BIGINT COMMENT 'Identifier of the manufacturing order or production batch active at the time of the event. Links event to specific production run for lot genealogy and batch record traceability. Maps to SAP PP Production Order.',
    `research_process_simulation_id` BIGINT COMMENT 'Foreign key linking to research.research_process_simulation. Business justification: Connects DCS events to the HYSYS simulation model used for process design, enabling validation of control actions against the simulated baseline.',
    `acknowledged_flag` BOOLEAN COMMENT 'Indicates whether the event (typically an alarm or interlock) has been acknowledged by an operator. True if acknowledged, False if unacknowledged. Critical for alarm management and operator response tracking.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the event was acknowledged by an operator. Null if not yet acknowledged. Used to calculate alarm response time and operator performance metrics. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `alarm_limit` DECIMAL(18,2) COMMENT 'Configured alarm threshold value that triggered the alarm for alarm-type events. Null for non-alarm events. Used for alarm rationalization and setpoint optimization.',
    `alarm_state` STRING COMMENT 'Current state of the alarm for alarm-type events. Active: alarm condition present. Cleared: alarm condition resolved. Suppressed: alarm temporarily disabled. Shelved: alarm acknowledged but not yet cleared. Null for non-alarm events.. Valid values are `active|cleared|suppressed|shelved`',
    `batches_completed` STRING COMMENT 'Number of production batches completed during the shift for shift summary events. Null for non-shift-summary events. Key performance indicator for shift productivity.',
    `batches_in_progress` STRING COMMENT 'Number of production batches in progress at shift end for shift summary events. Null for non-shift-summary events. Critical for shift handover continuity.',
    `control_mode_new` STRING COMMENT 'New control mode after a mode_change event. Null for non-mode-change events. Tracks transitions between automatic, manual, cascade, remote, and local control modes.. Valid values are `automatic|manual|cascade|remote|local`',
    `control_mode_previous` STRING COMMENT 'Previous control mode before a mode_change event. Null for non-mode-change events. Tracks transitions between automatic, manual, cascade, remote, and local control modes.. Valid values are `automatic|manual|cascade|remote|local`',
    `dcs_node_reference` STRING COMMENT 'Identifier of the DCS/SCADA node or controller that generated the event. Maps to specific Honeywell Experion or Siemens PCS 7 controller instances within the distributed control architecture.',
    `duration_seconds` STRING COMMENT 'Duration of the event in seconds. For alarms: time from activation to clearance. For interlocks: trip duration. For mode changes: time in transient state. Null for instantaneous events.',
    `environmental_readings` STRING COMMENT 'Summary of environmental monitoring readings during the shift (e.g., emissions, VOC levels, wastewater parameters). Null if not recorded. Supports EPA and environmental compliance reporting.',
    `equipment_issues` STRING COMMENT 'Free-text description of equipment problems, malfunctions, or maintenance needs identified during the shift. Null if no issues. Used for shift handover and maintenance planning.',
    `event_description` STRING COMMENT 'Detailed narrative description of the event. For alarms: alarm message text. For operator actions: action description. For shift handovers: handover notes and instructions. For shift summaries: comprehensive shift narrative.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the event occurred in the DCS/SCADA system. Critical for chronological event sequencing, alarm analysis, and incident investigation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `event_type` STRING COMMENT 'Classification of the event type. Discriminates between alarms, interlocks, operator actions, shift documentation, and system state changes. Critical for event filtering, alarm rationalization, and safety analysis. [ENUM-REF-CANDIDATE: alarm|interlock_trip|operator_override|setpoint_change|mode_change|shift_handover|shift_summary|shift_observation|system_fault|process_deviation|safety_event — 11 candidates stripped; promote to reference product]',
    `handover_instructions` STRING COMMENT 'Detailed instructions and action items for the incoming shift. Null for non-handover events. Ensures operational continuity and clear communication between shifts.',
    `interlock_reference` STRING COMMENT 'Unique identifier of the safety interlock that tripped for interlock_trip events. Null for non-interlock events. Links to interlock logic documentation and safety instrumented systems (SIS).',
    `material_shortages` STRING COMMENT 'Free-text description of raw material shortages or supply issues encountered during the shift. Null if none. Used for shift handover and supply chain escalation.',
    `operator_count` STRING COMMENT 'Number of operators on duty during the shift for shift-related events. Null for non-shift events. Used for staffing analysis and workload assessment.',
    `priority_level` STRING COMMENT 'Priority classification of the event. Critical and high priority events require immediate operator response. Used for alarm rationalization and operator workload analysis per ISA-18.2 guidelines.. Valid values are `critical|high|medium|low|informational`',
    `process_value` DECIMAL(18,2) COMMENT 'Actual process measurement value at the time of the event (e.g., temperature, pressure, flow rate, pH). Null if not applicable. Used for alarm analysis and process deviation investigation.',
    `process_value_unit_of_measure` STRING COMMENT 'Unit of measure for the process value (e.g., degC, bar, pH, kg/h, L/min, ppm). Null if process_value is null. Critical for engineering analysis.',
    `quality_holds` STRING COMMENT 'Free-text description of batches or materials placed on quality hold during the shift. Null if none. Critical for QA/QC tracking and batch disposition.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this event log record was created in the lakehouse silver layer. Distinct from event_timestamp (when the event occurred in the DCS). Used for data lineage and ETL audit. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this event log record was last updated in the lakehouse silver layer. Used for change tracking and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `safety_observations` STRING COMMENT 'Free-text description of safety observations, near-misses, or EHS concerns noted during the shift. Null if none. Critical for Process Safety Management and continuous improvement.',
    `setpoint_unit_of_measure` STRING COMMENT 'Unit of measure for setpoint values (e.g., degC, bar, pH, kg/h, L/min). Null for non-setpoint-change events. Critical for engineering analysis and process control.',
    `setpoint_value_new` DECIMAL(18,2) COMMENT 'New setpoint value after a setpoint_change event. Null for non-setpoint-change events. Used for audit trail and process optimization analysis.',
    `setpoint_value_previous` DECIMAL(18,2) COMMENT 'Previous setpoint value before a setpoint_change event. Null for non-setpoint-change events. Used for audit trail and process optimization analysis.',
    `shift_date` DATE COMMENT 'Calendar date of the shift for shift-related events (shift_handover, shift_summary, shift_observation). Null for non-shift events. Format: yyyy-MM-dd.',
    `shift_type` STRING COMMENT 'Type of shift for shift-related events. Identifies day, afternoon (swing), night, weekend, or holiday shifts. Null for non-shift events. Used for shift handover continuity and staffing analysis.. Valid values are `day|afternoon|night|weekend|holiday`',
    `source_system` STRING COMMENT 'Identifier of the source DCS/SCADA system that generated the event. Distinguishes between Honeywell Experion DCS, Siemens SIMATIC PCS 7, Aveva PI System, and other SCADA platforms.. Valid values are `honeywell_experion|siemens_pcs7|aveva_pi|scada_generic`',
    `supervisor_name` STRING COMMENT 'Name of the shift supervisor on duty for shift-related events. Null for non-shift events. Provides accountability and escalation contact for shift operations.',
    `tag_reference` STRING COMMENT 'Unique process tag identifier from the DCS/SCADA system representing the specific instrument, sensor, valve, or control point associated with this event. Used for traceability to P&ID diagrams and process control loops.',
    CONSTRAINT pk_dcs_event_log PRIMARY KEY(`dcs_event_log_id`)
) COMMENT 'Unified operational event log, shift record, and DCS/SCADA audit trail from production control systems (Honeywell Experion, Siemens PCS 7) capturing all production floor events, operator shift documentation, and handover records. Records alarms, interlocks, operator actions, system state changes, setpoint modifications, mode changes, shift handover entries, and shift summary narratives. Captures event timestamp, DCS node ID, tag ID, event type (alarm, interlock_trip, operator_override, setpoint_change, mode_change, shift_handover, shift_summary, shift_observation), event description, priority level, acknowledged flag, operator ID, duration, associated manufacturing order, shift date, shift type (day/afternoon/night), supervisor name, operator count, batches completed, batches in-progress, equipment issues, safety observations, environmental readings, material shortages, quality holds, and handover instructions. The single source of truth for production floor operational continuity, shift-to-shift communication, process safety analysis, alarm rationalization, incident investigation, and regulatory audit trail.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` (
    `mes_execution_log_id` BIGINT COMMENT 'Unique identifier for the MES execution log record. Primary key for the execution log entry capturing a single step or phase execution within a production batch or process order.',
    `batch_record_id` BIGINT COMMENT 'Reference to the production batch or lot for which this execution step was performed. Enables lot genealogy and traceability.',
    `equipment_id` BIGINT COMMENT 'Reference to the production equipment or reactor unit on which this operation was performed. Links execution to physical asset.',
    `employee_id` BIGINT COMMENT 'Reference to the operator or production worker who executed or confirmed this operation step. Critical for accountability and electronic signature compliance.',
    `process_order_id` BIGINT COMMENT 'Reference to the parent process order or production order under which this execution step was performed. Links the execution log to the overall manufacturing order.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this execution step requires supervisory or quality approval before the batch can proceed. True indicates approval workflow is required.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when supervisory or quality approval was granted for this execution step. Part of the approval audit trail.',
    `comments` STRING COMMENT 'Additional free-text comments or notes entered by the operator or supervisor regarding this execution step. Provides supplementary context for the batch record.',
    `data_source` STRING COMMENT 'Source from which the execution data was captured (manual operator entry, automatic DCS feed, SCADA system, PLC, LIMS import). Critical for data integrity assessment.. Valid values are `manual_entry|dcs_auto|scada_auto|plc_auto|lims_import`',
    `dcs_tag_name` STRING COMMENT 'DCS or SCADA tag identifier from which the parameter value was read. Links MES execution data to real-time process control system (Honeywell Experion, Siemens PCS 7).',
    `duration_minutes` STRING COMMENT 'Duration of the execution step in minutes. Calculated from execution start and end timestamps. Used for cycle time analysis and Overall Equipment Effectiveness (OEE) calculation.',
    `electronic_signature` STRING COMMENT 'Encrypted electronic signature of the operator confirming execution of the step. Required for GMP and 21 CFR Part 11 compliance.',
    `exception_code` STRING COMMENT 'Standardized code identifying the type of exception or deviation that occurred (e.g., OOS, equipment malfunction, material shortage). Used for exception categorization and trending.',
    `exception_description` STRING COMMENT 'Detailed description of the exception or deviation that occurred during execution. Provides context for investigation and root cause analysis.',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator of whether an exception or deviation occurred during this execution step. True indicates an abnormal condition requiring investigation.',
    `execution_end_timestamp` TIMESTAMP COMMENT 'Date and time when the execution of this recipe phase or operation step was completed or terminated.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Date and time when the execution of this recipe phase or operation step was initiated by the operator or system.',
    `execution_status` STRING COMMENT 'Current status of the execution step. Tracks the lifecycle state of the operation from initiation through completion or exception. [ENUM-REF-CANDIDATE: started|in_progress|completed|paused|aborted|exception|confirmed — 7 candidates stripped; promote to reference product]',
    `instruction_text` STRING COMMENT 'The full text of the work instruction or Standard Operating Procedure (SOP) step displayed to the operator during execution. Captures what the operator was instructed to do.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower acceptable limit for the process parameter. Values below this threshold trigger Out of Specification (OOS) alerts.',
    `material_lot_number` STRING COMMENT 'Lot number of the raw material or intermediate consumed or produced during this execution step. Enables material traceability and genealogy.',
    `material_quantity` DECIMAL(18,2) COMMENT 'Quantity of material charged, consumed, or produced during this execution step. Used for Bill of Materials (BOM) reconciliation and yield calculation.',
    `material_unit_of_measure` STRING COMMENT 'Unit of measure for the material quantity (e.g., kg, L, gal, lbs). Essential for accurate material accounting.',
    `mes_system_version` STRING COMMENT 'Version number of the MES software system that recorded this execution log entry. Important for audit trail and system validation.',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction identifier generated by the MES system for this execution event. Used for audit trail and system-level traceability.',
    `operation_sequence_number` STRING COMMENT 'Sequential order number of this operation within the process order or batch. Defines the execution order of steps.',
    `operator_response_text` STRING COMMENT 'Free-text response or confirmation entered by the operator in response to the instruction. May include observations, comments, or verification statements.',
    `parameter_name` STRING COMMENT 'Name of the process parameter recorded during this execution step (e.g., Temperature, Pressure, pH, Agitation Speed, Flow Rate). Identifies what was measured or controlled.',
    `parameter_unit_of_measure` STRING COMMENT 'Unit of measure for the parameter value (e.g., Celsius, PSI, pH units, RPM, L/min). Essential for correct interpretation of parameter values.',
    `parameter_value` DECIMAL(18,2) COMMENT 'Actual numeric value of the process parameter entered or recorded during execution. Represents the measured or set value for the parameter.',
    `recipe_phase_code` STRING COMMENT 'Code identifying the specific recipe phase or operation step executed (e.g., CHARGE, HEAT, REACT, COOL, DISCHARGE). Corresponds to the master recipe definition.',
    `recipe_phase_name` STRING COMMENT 'Human-readable name of the recipe phase or operation step executed. Provides business context for the phase code.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this execution log record was first created in the MES system. Part of the electronic batch record audit trail.',
    `record_locked_flag` BOOLEAN COMMENT 'Boolean indicator of whether this execution log record is locked and cannot be modified. True indicates the record is finalized and part of the permanent batch record.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this execution log record was last modified. Tracks changes to the electronic batch record for audit purposes.',
    `signature_meaning` STRING COMMENT 'The meaning or intent of the electronic signature (e.g., performed, reviewed, approved, verified). Defines what the signature certifies.. Valid values are `performed|reviewed|approved|verified`',
    `signature_timestamp` TIMESTAMP COMMENT 'Date and time when the electronic signature was applied by the operator. Part of the electronic signature audit trail.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or setpoint value for the process parameter as defined in the master recipe. Used for comparison against actual parameter value.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the process parameter. Values above this threshold trigger Out of Specification (OOS) alerts.',
    CONSTRAINT pk_mes_execution_log PRIMARY KEY(`mes_execution_log_id`)
) COMMENT 'Manufacturing Execution System (MES) log capturing step-by-step execution records for production operations. Records MES transaction ID, process order reference, recipe phase executed, execution start/end timestamps, operator ID, equipment ID, actual parameter values entered, electronic signature details, instruction text displayed, operator response/confirmation, exception flags, and MES system version. Provides the complete electronic batch record audit trail required for GMP compliance and 21 CFR Part 11 electronic records compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `employee_id` BIGINT COMMENT 'Reference to the production planner responsible for campaign planning and scheduling.',
    `campaign_supervisor_employee_id` BIGINT COMMENT 'Reference to the production supervisor responsible for campaign execution oversight.',
    `formula_bom_id` BIGINT COMMENT 'Reference to the Bill of Materials used for raw material planning and consumption tracking across the campaign.',
    `plant_id` BIGINT COMMENT 'FK to production.plant',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Campaign planning includes the associated preventive maintenance plan for equipment, essential for the Production‑Maintenance Alignment Dashboard.',
    `product_family_id` BIGINT COMMENT 'FK to product.product_family',
    `routing_id` BIGINT COMMENT 'Reference to the production routing or process flow used for all batches in the campaign. Defines the sequence of operations and work centers.',
    `work_center_id` BIGINT COMMENT 'Primary work center or production line assigned to execute this campaign. References the work center master data.',
    `actual_batch_count` STRING COMMENT 'Number of production batches actually executed within this campaign. Updated as batches are completed.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred during campaign execution. Captured from production orders and settled to cost centers.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the last batch of the campaign was completed and equipment was released. Captured from MES or DCS systems.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Total actual production quantity achieved across all batches in the campaign. Updated as batches are completed and yield is confirmed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the first batch of the campaign was started. Captured from MES or DCS systems.',
    `campaign_name` STRING COMMENT 'Descriptive name of the production campaign, typically indicating the product family or synthesis route being manufactured.',
    `campaign_number` STRING COMMENT 'Business identifier for the campaign, externally visible and used in production planning and scheduling systems. Typically follows plant-specific numbering conventions.. Valid values are `^[A-Z0-9]{8,20}$`',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the production campaign. Tracks progression from planning through execution to completion or cancellation. [ENUM-REF-CANDIDATE: planned|scheduled|in_progress|on_hold|completed|cancelled|aborted — 7 candidates stripped; promote to reference product]',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on equipment utilization strategy. Dedicated campaigns run a single product exclusively; shared campaigns alternate between products in the same family; multi-product campaigns produce multiple SKUs; trial campaigns are for R&D validation.. Valid values are `dedicated|shared|multi_product|single_product|trial|validation`',
    `changeover_time_hours` DECIMAL(18,2) COMMENT 'Total time in hours required for equipment changeover and setup at the start of the campaign. Includes line clearance, equipment configuration, and pre-production checks.',
    `cip_duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours allocated for CIP operations during the campaign. Used for OEE calculations and scheduling.',
    `cip_schedule_type` STRING COMMENT 'Cleaning schedule strategy for the campaign. Between-batches requires CIP after each batch; end-of-campaign performs CIP only at campaign completion; as-needed is based on contamination risk assessment.. Valid values are `between_batches|end_of_campaign|as_needed|none`',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost for the campaign including raw materials, labor, utilities, and overhead. Used for financial planning and variance analysis.',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between estimated and actual cost, calculated as ((actual_cost - cost_estimate) / cost_estimate) * 100. Key financial performance indicator.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the campaign record. Audit trail field.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system. Audit trail field.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether any deviations from standard operating procedures occurred during the campaign. Triggers quality review and CAPA processes.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the campaign record. Audit trail field.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last updated. Audit trail field.',
    `master_recipe_reference` STRING COMMENT 'Reference to the master recipe or process specification used for all batches in this campaign. Ensures consistency across campaign execution.. Valid values are `^[A-Z0-9_-]{6,30}$`',
    `mes_campaign_reference` STRING COMMENT 'External identifier from the MES system used for integration and traceability. Links to MES execution logs and real-time process data.. Valid values are `^[A-Z0-9_-]{8,30}$`',
    `moc_reference` STRING COMMENT 'Reference to any Management of Change documentation associated with this campaign. Required when process parameters, equipment, or materials differ from standard operations.. Valid values are `^MOC-[A-Z0-9]{6,20}$`',
    `notes` STRING COMMENT 'Free-text notes and comments about the campaign, including special instructions, lessons learned, or operational observations.',
    `oee_actual_percentage` DECIMAL(18,2) COMMENT 'Actual OEE percentage achieved during the campaign, calculated from availability, performance, and quality metrics. Key KPI for production efficiency.',
    `oee_target_percentage` DECIMAL(18,2) COMMENT 'Target OEE percentage for the campaign, representing planned equipment utilization efficiency. Used for performance benchmarking.',
    `planned_batch_count` STRING COMMENT 'Number of production batches planned for this campaign at the time of campaign creation.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Total planned production quantity for the campaign across all batches. Expressed in the campaign unit of measure.',
    `priority_level` STRING COMMENT 'Business priority assigned to the campaign for scheduling and resource allocation. Critical campaigns receive preferential treatment in capacity planning.. Valid values are `critical|high|normal|low`',
    `quality_hold_flag` BOOLEAN COMMENT 'Indicates whether the campaign output is under quality hold pending final release by QA. Prevents shipment until cleared.',
    `scheduled_end_date` DATE COMMENT 'Planned completion date for the campaign. Used for production scheduling and delivery commitments.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for the campaign. Used for production scheduling and capacity planning.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for campaign quantities. Typically mass (KG, MT, LB, TON) or volume (L, GAL) depending on product characteristics.. Valid values are `KG|MT|L|GAL|LB|TON`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Overall yield percentage for the campaign, calculated as (actual_quantity / planned_quantity) * 100. Key performance indicator for campaign efficiency.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Manages multi-batch production campaigns where the same product or product family is manufactured in consecutive runs to maximize equipment utilization and minimize changeover. Captures campaign ID, campaign name, product family, campaign type (dedicated, shared), planned batch count, actual batch count, campaign start date, campaign end date, work center assignment, total planned quantity, total actual quantity, campaign yield, CIP (Clean-In-Place) schedule between batches, and campaign status. Supports campaign planning, scheduling optimization, and OEE reporting.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`cip_record` (
    `cip_record_id` BIGINT COMMENT 'Unique identifier for the CIP execution record. Primary key for the CIP record entity.',
    `equipment_id` BIGINT COMMENT 'Identifier of the reactor, vessel, pipeline, or processing equipment that was cleaned. Links to the equipment master data.',
    `functional_location_id` BIGINT COMMENT 'Functional location identifier where the CIP operation was performed. Provides hierarchical plant structure context.',
    `manufacturing_order_id` BIGINT COMMENT 'Identifier of the production order that preceded this CIP cycle. Links the CIP record to the manufacturing order for lot genealogy and traceability.',
    `plant_id` BIGINT COMMENT 'FK to production.plant',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: CIP scheduling needs the previous products raw‑material details to validate cleaning effectiveness.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who executed or supervised the CIP cycle. Links to workforce/employee master data.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center (production line or area) where the CIP-cleaned equipment is located. Links to work center master data.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when the CIP cycle was completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the CIP cycle began. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cip_cycle_number` STRING COMMENT 'Sequential cycle number for this equipment. Tracks the number of CIP cycles performed on the equipment for maintenance and lifecycle analysis.',
    `cip_procedure_reference` STRING COMMENT 'Reference code to the Standard Operating Procedure (SOP) or master recipe used for this CIP execution. Defines the cleaning protocol, agent, temperature, duration, and acceptance criteria.. Valid values are `^CIP-[A-Z0-9]{4,12}$`',
    `cip_status` STRING COMMENT 'Current status of the CIP execution: in_progress (cleaning underway), completed (successfully finished), failed (did not meet acceptance criteria), aborted (manually stopped), pending_review (awaiting QA approval).. Valid values are `in_progress|completed|failed|aborted|pending_review`',
    `cip_type` STRING COMMENT 'Type of CIP execution: manual (operator-driven), automatic (fully automated via DCS/PLC), or semi-automatic (operator-initiated, system-controlled).. Valid values are `manual|automatic|semi_automatic`',
    `cleaning_agent_code` STRING COMMENT 'Material code of the cleaning agent or detergent used in the CIP process (e.g., caustic soda, acid wash, sanitizer). Links to material master.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cleaning_agent_concentration_ppm` DECIMAL(18,2) COMMENT 'Concentration of the cleaning agent in parts per million (PPM) used during the CIP cycle. Critical for ensuring effective cleaning without residue.',
    `cleaning_agent_name` STRING COMMENT 'Descriptive name of the cleaning agent used (e.g., Sodium Hydroxide Solution, Nitric Acid 10%, Hydrogen Peroxide Sanitizer).',
    `cleaning_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the CIP cleaning cycle in minutes, from start of cleaning agent circulation to completion of final rinse.',
    `cleaning_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature in degrees Celsius at which the CIP cleaning cycle was executed. Temperature is critical for cleaning efficacy and must meet SOP specifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CIP record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `dcs_batch_reference` STRING COMMENT 'Batch identifier from the DCS (Honeywell Experion or Siemens PCS 7) that executed the automated CIP cycle. Links to real-time process historian data.. Valid values are `^DCS-[A-Z0-9]{8,16}$`',
    `deviation_description` STRING COMMENT 'Detailed description of any deviations from the standard CIP procedure, including root cause and corrective actions taken.',
    `deviation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any deviations from the CIP procedure occurred during execution. True triggers a deviation investigation workflow.',
    `flow_rate_liters_per_minute` DECIMAL(18,2) COMMENT 'Flow rate of cleaning solution in liters per minute during the CIP cycle. Adequate flow rate ensures complete coverage and effective cleaning.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the CIP execution meets GMP requirements. True means compliant; False triggers corrective action.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this CIP record. Captured for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CIP record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mes_integration_reference` STRING COMMENT 'Integration identifier linking this CIP record to the MES system for production scheduling, lot genealogy, and traceability.. Valid values are `^MES-[A-Z0-9]{8,16}$`',
    `next_product_code` STRING COMMENT 'Material code of the chemical product scheduled to be manufactured in the equipment after this CIP cycle. Used to validate cleaning protocol adequacy for product changeover.. Valid values are `^[A-Z0-9]{6,18}$`',
    `next_production_clearance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the equipment has been cleared for the next production run. True means equipment is approved for use; False means additional cleaning or inspection is required.',
    `operator_name` STRING COMMENT 'Full name of the operator who executed or supervised the CIP cycle. Captured for audit trail and accountability.',
    `pass_fail_result` STRING COMMENT 'Final pass/fail result of the CIP execution based on acceptance criteria (rinse water conductivity, temperature profile, duration). Conditional_pass indicates minor deviations requiring management review.. Valid values are `pass|fail|conditional_pass`',
    `qa_comments` STRING COMMENT 'Free-text comments from the QA reviewer regarding the CIP execution, any deviations observed, or additional actions required.',
    `qa_review_timestamp` TIMESTAMP COMMENT 'Date and time when the QA reviewer approved or rejected the CIP record. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `regulatory_compliance_status` STRING COMMENT 'Compliance status of the CIP execution with respect to GMP, FDA, and food-contact regulations. Compliant means all criteria met; non_compliant triggers investigation; pending_review awaits final determination.. Valid values are `compliant|non_compliant|pending_review`',
    `rinse_water_conductivity_us_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity of the final rinse water in microsiemens per centimeter (µS/cm). Low conductivity indicates effective removal of cleaning agent residues. Typical acceptance threshold is below 20 µS/cm.',
    `scada_integration_reference` STRING COMMENT 'Integration identifier linking this CIP record to SCADA system logs and real-time process data captured during the cleaning cycle.. Valid values are `^SCADA-[A-Z0-9]{8,16}$`',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the CIP cycle was scheduled to begin. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_cip_record PRIMARY KEY(`cip_record_id`)
) COMMENT 'Clean-In-Place (CIP) execution record documenting the cleaning and sanitization of reactors, vessels, pipelines, and processing equipment between production runs. Captures CIP record ID, equipment ID, CIP procedure reference, cleaning agent used, cleaning agent concentration (PPM), rinse water conductivity, temperature profile, duration, flow rate, operator ID, pass/fail result, next production clearance flag, and regulatory compliance status. Critical for preventing cross-contamination between chemical products and maintaining GMP/food-contact compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` (
    `equipment_effectiveness_id` BIGINT COMMENT 'Primary key for equipment_effectiveness',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Downtime Cost Reporting: downtime impact is charged to a cost center for financial loss analysis and regulatory reporting.',
    `equipment_id` BIGINT COMMENT 'Identifier of the specific equipment or asset that experienced downtime. Links to equipment master data in SAP PM.',
    `functional_location_id` BIGINT COMMENT 'Identifier of the functional location in the plant hierarchy where the downtime occurred.',
    `notification_id` BIGINT COMMENT 'Reference to the maintenance notification that triggered investigation or repair. Links to SAP PM notification for issue tracking.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to address the downtime event. Links to SAP PM work order for repair tracking and cost capture.',
    `manufacturing_order_id` BIGINT COMMENT 'Identifier of the production order that was interrupted by this downtime event. Links to manufacturing order for impact analysis.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who reported or was on duty during the downtime event. Used for training needs analysis and accountability.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the production shift during which the downtime event occurred. Used for shift-level OEE analysis and performance comparison.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: REQUIRED: Maintenance KPI reports need the equipment vendor to assess service contract performance and downtime root causes.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center where the downtime event occurred. Links to the production work center master data.',
    `batch_number` STRING COMMENT 'Batch or lot number of the product being manufactured when the downtime occurred. Supports lot genealogy and traceability.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether this downtime event requires formal CAPA (Corrective and Preventive Action) investigation and documentation per quality management system.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about the downtime event not captured in structured fields.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this downtime event record. Supports accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was first created in the system. Supports audit trail and data lineage.',
    `dcs_alarm_reference` STRING COMMENT 'Identifier of the DCS or SCADA alarm that triggered or was associated with the downtime event. Links to process control system alarm history.',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event type. Used for OEE availability loss categorization and root cause analysis. [ENUM-REF-CANDIDATE: mechanical_failure|electrical_failure|process_upset|material_shortage|changeover|planned_maintenance|utility_failure|operator_shortage|quality_issue|safety_incident — 10 candidates stripped; promote to reference product]',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the downtime event in minutes. Calculated as the difference between end and start timestamps. Used directly in OEE availability calculation.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the equipment was restored to operational status and production resumed.',
    `downtime_event_number` STRING COMMENT 'Business-readable unique identifier for the downtime event, typically generated by MES or DCS system.. Valid values are `^DT-[0-9]{10}$`',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the downtime event began. Captured from DCS/SCADA system or manually recorded by operator.',
    `downtime_status` STRING COMMENT 'Current lifecycle status of the downtime event record. Tracks progression from detection through resolution and closure.. Valid values are `open|in_progress|resolved|closed|under_investigation`',
    `downtime_subcategory` STRING COMMENT 'Detailed subcategory or specific failure mode within the downtime category. Provides granular classification for maintenance and continuous improvement analysis.',
    `environmental_incident_flag` BOOLEAN COMMENT 'Indicates whether the downtime event resulted in an environmental release or incident requiring EPA or regulatory reporting.',
    `ideal_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Theoretical minimum time to produce one unit of product under ideal conditions. Used for OEE performance calculation.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this downtime event record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this downtime event record was last updated. Tracks record change history for audit and compliance.',
    `mes_transaction_reference` STRING COMMENT 'Unique transaction identifier from the MES system that recorded the downtime event. Supports integration and data lineage.',
    `moc_reference_number` STRING COMMENT 'Reference number of the Management of Change record if the downtime was related to a recent process or equipment modification.',
    `mtbf_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this downtime event should be counted as a failure event in MTBF (Mean Time Between Failures) calculation for reliability analysis.',
    `mttr_inclusion_flag` BOOLEAN COMMENT 'Indicates whether this downtime event should be included in MTTR (Mean Time To Repair) calculation for maintainability analysis.',
    `oee_availability_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event should be included in the OEE availability component calculation (True) or excluded (False).',
    `oee_performance_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event impacted the OEE performance component (speed losses) in addition to availability.',
    `oee_quality_impact_flag` BOOLEAN COMMENT 'Indicates whether this downtime event resulted in quality losses or defects that impact the OEE quality component.',
    `planned_downtime_flag` BOOLEAN COMMENT 'Indicates whether the downtime was scheduled and planned (True) or unplanned/unscheduled (False). Critical for distinguishing availability losses in OEE calculation.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total planned production time for the period in which the downtime occurred. Used as the denominator in OEE availability calculation.',
    `production_impact_batches_delayed` STRING COMMENT 'Number of production batches delayed or rescheduled as a result of this downtime event. Measures schedule adherence impact.',
    `production_impact_quantity_lost` DECIMAL(18,2) COMMENT 'Quantity of product that could not be produced due to the downtime event, measured in the products base unit of measure. Used for throughput loss calculation.',
    `production_impact_uom` STRING COMMENT 'Unit of measure for the quantity lost (e.g., kg, liters, tons, units). Aligns with material master UOM.',
    `recovery_action_code` STRING COMMENT 'Standardized code representing the type of recovery action performed (e.g., repair, replacement, adjustment, restart).',
    `recovery_action_description` STRING COMMENT 'Detailed description of the corrective actions taken to restore equipment to operational status and resume production.',
    `root_cause_code` STRING COMMENT 'Standardized code representing the root cause category from the plants failure mode taxonomy. Enables systematic analysis and trending.',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause identified through RCI (Root Cause Investigation) or failure analysis. Supports CAPA and continuous improvement.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the downtime event was associated with a safety incident requiring EHS reporting or investigation.',
    CONSTRAINT pk_equipment_effectiveness PRIMARY KEY(`equipment_effectiveness_id`)
) COMMENT 'Records unplanned and planned downtime events for production equipment and work centers, serving as the source data for OEE (Overall Equipment Effectiveness) calculations. Captures downtime event ID, work center, equipment ID, downtime start/end datetime, duration minutes, downtime category (mechanical failure, electrical failure, process upset, material shortage, changeover, planned maintenance, utility failure, operator shortage), root cause description, maintenance work order reference, production impact (batches delayed, quantity lost), recovery action, shift reference, planned production time, ideal cycle time, and availability/performance/quality component flags. Feeds OEE calculations (availability × performance × quality), TPM programs, maintenance prioritization, continuous improvement initiatives, and production KPI dashboards.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`shift_log` (
    `shift_log_id` BIGINT COMMENT 'Unique identifier for the shift log record. Primary key for the shift log entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the supervisor who managed the shift.',
    `work_center_id` BIGINT COMMENT 'Identifier of the specific work center or production area covered by this shift log.',
    `batches_completed` STRING COMMENT 'Number of production batches successfully completed during the shift.',
    `batches_in_progress` STRING COMMENT 'Number of production batches that were in-progress at the end of the shift.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created the shift log record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift log record was first created in the system.',
    `dcs_system_status` STRING COMMENT 'Operational status of the Distributed Control System during the shift.. Valid values are `normal|degraded|alarm|fault|maintenance`',
    `environmental_readings` STRING COMMENT 'Summary of environmental monitoring readings such as temperature, humidity, air quality, or emissions captured during the shift.',
    `equipment_downtime_minutes` STRING COMMENT 'Total minutes of unplanned equipment downtime during the shift.',
    `equipment_issues_noted` STRING COMMENT 'Description of any equipment malfunctions, breakdowns, or performance issues observed during the shift.',
    `handover_instructions` STRING COMMENT 'Instructions and guidance provided to the next shift supervisor and operators for operational continuity.',
    `key_events_narrative` STRING COMMENT 'Free-text narrative documenting significant events, observations, and activities that occurred during the shift.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the shift log record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the shift log record was last updated.',
    `material_shortages_flagged` STRING COMMENT 'Description of any raw material or component shortages identified during the shift that impacted production.',
    `moc_activities` STRING COMMENT 'Documentation of any Management of Change activities or temporary process modifications implemented during the shift.',
    `operator_count` STRING COMMENT 'Total number of operators working during the shift.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant where the shift occurred.',
    `process_deviations_noted` STRING COMMENT 'Description of any deviations from standard operating procedures or master recipes observed during the shift.',
    `production_area` STRING COMMENT 'Name or designation of the production area or manufacturing zone covered during the shift.',
    `production_orders_active` STRING COMMENT 'Count of production orders that were active or in-progress during the shift.',
    `production_output_quantity` DECIMAL(18,2) COMMENT 'Total quantity of product manufactured during the shift.',
    `production_output_uom` STRING COMMENT 'Unit of measure for the production output quantity (e.g., kg, liters, tons, gallons).',
    `quality_holds_noted` STRING COMMENT 'Documentation of any quality holds, Out of Specification (OOS) events, or quality concerns raised during the shift.',
    `quality_issues_count` STRING COMMENT 'Number of quality-related issues or deviations identified during the shift.',
    `safety_incidents_count` STRING COMMENT 'Number of safety incidents or near-miss events recorded during the shift.',
    `safety_observations` STRING COMMENT 'Documentation of safety-related observations, near-misses, or incidents noted during the shift.',
    `scada_alarms_count` STRING COMMENT 'Total number of SCADA system alarms triggered during the shift.',
    `shift_date` DATE COMMENT 'Calendar date on which the shift occurred. Principal business event timestamp for the shift log.',
    `shift_end_time` TIMESTAMP COMMENT 'Timestamp when the shift officially ended.',
    `shift_start_time` TIMESTAMP COMMENT 'Timestamp when the shift officially began.',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift log record.. Valid values are `completed|in_progress|aborted|extended`',
    `shift_type` STRING COMMENT 'Classification of the shift period (day, afternoon, night, swing, graveyard, or rotating shift).. Valid values are `day|afternoon|night|swing|graveyard|rotating`',
    `supervisor_name` STRING COMMENT 'Full name of the production supervisor responsible for the shift.',
    `training_conducted` STRING COMMENT 'Description of any operator training, safety briefings, or skill development activities conducted during the shift.',
    `utility_consumption_notes` STRING COMMENT 'Observations regarding utility consumption (electricity, steam, water, compressed air) during the shift.',
    `visitor_contractor_activity` STRING COMMENT 'Documentation of any visitor or contractor activities on-site during the shift.',
    `waste_generation_notes` STRING COMMENT 'Documentation of waste generation, disposal activities, or environmental compliance observations during the shift.',
    `weather_conditions` STRING COMMENT 'Notable weather conditions during the shift that may have impacted operations (e.g., extreme heat, cold, storms).',
    CONSTRAINT pk_shift_log PRIMARY KEY(`shift_log_id`)
) COMMENT 'Operational shift log maintained by production supervisors and operators documenting key events, observations, handover notes, and production status during each shift. Captures shift log ID, shift date, shift type (day, afternoon, night), work center or production area, supervisor name, operator count, production orders active, batches completed, batches in-progress, key events narrative, equipment issues noted, safety observations, environmental readings, material shortages flagged, quality holds noted, and handover instructions for next shift. Provides operational continuity and audit trail.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` (
    `production_procurement_plan_id` BIGINT COMMENT 'Primary key for the procurement_plan association',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the production campaign',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor',
    `approval_status` STRING COMMENT 'Current approval status of the procurement plan (e.g., Pending, Approved, Rejected)',
    `contract_number` STRING COMMENT 'Identifier of the contract governing this procurement',
    `lead_time_days` STRING COMMENT 'Expected lead time in days for the vendor to deliver the material',
    `planned_procurement_quantity` DECIMAL(18,2) COMMENT 'Quantity of material planned to be procured for the campaign from this vendor',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed price per unit of material for this campaign‑vendor pair',
    `total_planned_value` DECIMAL(18,2) COMMENT 'Total monetary value of the planned procurement (quantity * price)',
    CONSTRAINT pk_production_procurement_plan PRIMARY KEY(`production_procurement_plan_id`)
) COMMENT 'Represents the contractual and logistical agreement between a production campaign and a vendor. Each record links one campaign to one vendor and stores procurement‑specific details that belong to the relationship itself.. Existence Justification: A production campaign may source raw materials from multiple vendors, and a vendor can supply to many different campaigns. The procurement team actively creates and maintains a procurement plan for each campaign‑vendor pairing, capturing quantities, pricing, lead times, and contract details. This plan is a managed business entity that is updated throughout the campaign lifecycle.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_unit` (
    `process_unit_id` BIGINT COMMENT 'Primary key for process_unit',
    `plant_id` BIGINT COMMENT 'FK to production.plant',
    `parent_process_unit_id` BIGINT COMMENT 'Self-referencing FK on process_unit (parent_process_unit_id)',
    `capacity` DECIMAL(18,2) COMMENT 'Designed production capacity of the unit.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity field.',
    `commissioning_date` DATE COMMENT 'Date the unit passed all acceptance tests and entered service.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the unit.',
    `control_system` STRING COMMENT 'Distributed control system that governs the unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the master record was first created.',
    `decommission_date` DATE COMMENT 'Date the unit was permanently taken out of service, if applicable.',
    `process_unit_description` STRING COMMENT 'Free‑form description of the units purpose and characteristics.',
    `emission_factor_kg_per_hour` DECIMAL(18,2) COMMENT 'Typical emissions generated by the unit per hour of operation.',
    `energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Average energy consumption of the unit per operating hour.',
    `hazard_classification` STRING COMMENT 'Primary hazard class associated with the unit.',
    `installation_date` DATE COMMENT 'Date the unit was installed and became operational.',
    `integration_point` STRING COMMENT 'Primary integration technology used for data acquisition.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the unit is considered critical for production continuity.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `last_maintenance_date` DATE COMMENT 'Most recent date on which preventive maintenance was performed.',
    `location` STRING COMMENT 'Physical location or plant where the unit resides.',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Company that built the process unit.',
    `max_pressure_bar` DECIMAL(18,2) COMMENT 'Maximum safe operating pressure for the unit.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum safe operating temperature for the unit.',
    `model_number` STRING COMMENT 'Model designation assigned by the manufacturer.',
    `process_unit_name` STRING COMMENT 'Human‑readable name of the process unit used in reports and dashboards.',
    `operating_mode` STRING COMMENT 'Mode in which the unit runs.',
    `operating_shift` STRING COMMENT 'Typical shift schedule for the unit.',
    `process_unit_group` STRING COMMENT 'Logical grouping or line to which the unit belongs.',
    `safety_rating` STRING COMMENT 'Safety classification based on industry standards.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the unit.',
    `process_unit_status` STRING COMMENT 'Current operational status of the unit.',
    `unit_code` STRING COMMENT 'External code or tag assigned to the unit by engineering standards.',
    `unit_type` STRING COMMENT 'Category of the unit describing its primary function in the plant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the master record.',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Master reference table for process_unit. Referenced by process_unit_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `parent_plant_id` BIGINT COMMENT 'Self-referencing FK on plant (parent_plant_id)',
    `address_line1` STRING COMMENT 'Primary street address of the plant location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Design‑rated mass production capacity of the plant.',
    `capacity_volume_m3_per_day` DECIMAL(18,2) COMMENT 'Design‑rated volumetric production capacity of the plant.',
    `city` STRING COMMENT 'City of the plants physical location.',
    `plant_code` STRING COMMENT 'Business identifier code assigned to the plant by the organization.',
    `country_code` STRING COMMENT 'Three‑letter country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the plant record was first created in the system.',
    `plant_description` STRING COMMENT 'Narrative description providing additional context about the plant.',
    `emergency_contact_name` STRING COMMENT 'Name of the person responsible for emergency coordination.',
    `emergency_contact_number` STRING COMMENT 'Phone number to call for plant emergency response.',
    `emissions_co2_tons_per_year` DECIMAL(18,2) COMMENT 'Reported greenhouse‑gas emissions for the plant per year.',
    `environmental_permit_number` STRING COMMENT 'Regulatory permit number authorizing emissions and waste handling.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection activity.',
    `is_hazardous` BOOLEAN COMMENT 'True if the plant processes or stores regulated hazardous substances.',
    `last_inspection_date` DATE COMMENT 'Calendar date of the latest safety or regulatory inspection.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the plant for mapping and GIS analysis.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the plant for mapping and GIS analysis.',
    `maintenance_strategy` STRING COMMENT 'Approach used for maintaining plant equipment.',
    `manager_contact_phone` STRING COMMENT 'Primary contact telephone for the plant manager.',
    `manager_email` STRING COMMENT 'Primary email address for the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for plant operations.',
    `plant_name` STRING COMMENT 'Descriptive name of the plant used in reports and user interfaces.',
    `number_of_shifts` STRING COMMENT 'Count of distinct production shifts run each calendar day.',
    `number_of_units` STRING COMMENT 'Count of primary production equipment units at the plant.',
    `operational_end_date` DATE COMMENT 'Calendar date when the plant was decommissioned or closed; null if still active.',
    `operational_start_date` DATE COMMENT 'Calendar date when the plant first became operational.',
    `permit_expiry_date` DATE COMMENT 'Date on which the environmental permit must be renewed.',
    `plant_area_sq_meters` DECIMAL(18,2) COMMENT 'Physical size of the plant site.',
    `postal_code` STRING COMMENT 'Postal code for the plants address.',
    `primary_energy_source` STRING COMMENT 'Main energy source powering the plants processes.',
    `safety_rating` STRING COMMENT 'Internal safety classification based on OSHA/ISO 45001 audits.',
    `shift_duration_hours` STRING COMMENT 'Standard duration of a production shift.',
    `state_province` STRING COMMENT 'State or province where the plant resides.',
    `plant_status` STRING COMMENT 'Lifecycle status indicating whether the plant is operating, under maintenance, or retired.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the plants local time.',
    `plant_type` STRING COMMENT 'Classification of the plant based on its primary function.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the plant record.',
    `waste_treatment_capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Maximum amount of waste the plant can treat daily.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`resource` (
    `resource_id` BIGINT COMMENT 'Primary key for resource',
    `parent_resource_id` BIGINT COMMENT 'Self-referencing FK on resource (parent_resource_id)',
    `asset_category` STRING COMMENT 'Business classification of the asset based on criticality.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity value.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Primary quantitative capacity of the resource (e.g., volume, weight).',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the resource.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Capital cost incurred to acquire the resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the resource record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.',
    `decommission_date` DATE COMMENT 'Date the resource was retired or removed from service (if applicable).',
    `resource_description` STRING COMMENT 'Detailed textual description of the resource.',
    `installation_date` DATE COMMENT 'Date the resource was installed or commissioned.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance was performed.',
    `location_code` STRING COMMENT 'Code identifying the physical location or site of the resource.',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the resource.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `resource_name` STRING COMMENT 'Human‑readable name of the resource.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the upcoming maintenance.',
    `operating_pressure_bar` DECIMAL(18,2) COMMENT 'Typical operating pressure in bar units.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Typical operating temperature range in degrees Celsius.',
    `resource_code` STRING COMMENT 'Business identifier or catalogue number for the resource.',
    `resource_type` STRING COMMENT 'Category that classifies the kind of resource.',
    `safety_rating` STRING COMMENT 'Safety classification based on internal risk assessment.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the resource.',
    `resource_status` STRING COMMENT 'Current lifecycle state of the resource.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the resource record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty expires.',
    `created_by` STRING COMMENT 'User or system that created the resource record.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Master reference table for resource. Referenced by resource_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`routing` (
    `routing_id` BIGINT COMMENT 'Primary key for routing',
    `work_center_id` BIGINT COMMENT 'Identifier of the primary work center associated with the routing.',
    `superseded_routing_id` BIGINT COMMENT 'Self-referencing FK on routing (superseded_routing_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the routing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the routing was approved.',
    `change_reason` STRING COMMENT 'Reason for the most recent revision of the routing.',
    `routing_code` STRING COMMENT 'Unique business code for the routing.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the routing.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing record was created.',
    `department` STRING COMMENT 'Business department responsible for the routing.',
    `routing_description` STRING COMMENT 'Detailed description of the routing purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the routing is retired or superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the routing becomes effective.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Typical energy usage for the routing per batch.',
    `estimated_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard expected cycle time for the routing.',
    `estimated_yield_percent` DECIMAL(18,2) COMMENT 'Typical yield expected when following this routing.',
    `is_default` BOOLEAN COMMENT 'Indicates if this routing is the default for its product family.',
    `material_consumption_rate` DECIMAL(18,2) COMMENT 'Average material consumption per unit output.',
    `routing_name` STRING COMMENT 'Human readable name of the routing.',
    `notes` STRING COMMENT 'Additional free-text notes about the routing.',
    `plant_location` STRING COMMENT 'Three-letter code of the plant where routing is used.',
    `priority` STRING COMMENT 'Priority order when multiple routings apply (lower number = higher priority).',
    `revision_number` STRING COMMENT 'Revision count for changes to the routing.',
    `routing_type` STRING COMMENT 'Category of routing based on process nature.',
    `safety_rating` STRING COMMENT 'Safety risk rating for the routing.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing.',
    `updated_by` STRING COMMENT 'User identifier who last updated the routing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing record.',
    `version_number` STRING COMMENT 'Version of the routing definition.',
    `created_by` STRING COMMENT 'User identifier who created the routing record.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Master reference table for routing. Referenced by routing_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` (
    `bill_of_materials_id` BIGINT COMMENT 'Primary key for bill_of_materials',
    `parent_bom_id` BIGINT COMMENT 'Identifier of the parent BOM in a hierarchical BOM structure (e.g., for sub‑assemblies).',
    `superseded_bill_of_materials_id` BIGINT COMMENT 'Self-referencing FK on bill_of_materials (superseded_bill_of_materials_id)',
    `approval_status` STRING COMMENT 'Current approval state of the BOM within engineering change control.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM received final approval.',
    `bom_code` STRING COMMENT 'Business identifier code used to reference the BOM in production and planning processes.',
    `bom_type` STRING COMMENT 'Classification of the BOM indicating whether it represents a finished assembly, a kit, raw material collection, or a sub‑assembly.',
    `change_reason` STRING COMMENT 'Free‑text explanation for the most recent change to the BOM.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) applicable to the BOM (e.g., EPA, OSHA, REACH, GHS).',
    `component_count` STRING COMMENT 'Number of distinct component lines defined for this BOM.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the standard_cost field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM record was first created in the system.',
    `bill_of_materials_description` STRING COMMENT 'Detailed textual description of the BOM purpose, scope, and any special handling notes.',
    `effective_from` DATE COMMENT 'Date on which the BOM becomes valid for use in production planning.',
    `effective_until` DATE COMMENT 'Date on which the BOM is retired or superseded; null if open‑ended.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the BOM contains any regulated hazardous substances.',
    `is_default` BOOLEAN COMMENT 'True if this BOM is the default version used for the associated product.',
    `lead_time_days` STRING COMMENT 'Planned number of calendar days required to procure and assemble the BOM.',
    `bill_of_materials_name` STRING COMMENT 'Human‑readable name describing the BOM, typically the product or assembly name.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments about the BOM.',
    `quality_check_required` BOOLEAN COMMENT 'True if a quality inspection is mandatory for the finished product derived from this BOM.',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the BOM.',
    `routing_required` BOOLEAN COMMENT 'Indicates whether a manufacturing routing must be executed for this BOM.',
    `safety_data_sheet_version` STRING COMMENT 'Version identifier of the latest Safety Data Sheet (SDS) associated with hazardous components.',
    `scrap_rate_percent` DECIMAL(18,2) COMMENT 'Expected percentage of material loss during production of the BOM.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost of the BOM based on component costs and engineering estimates.',
    `bill_of_materials_status` STRING COMMENT 'Current lifecycle status of the BOM (e.g., active for production, draft for engineering).',
    `total_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of all components expressed in the base unit of measure for the BOM.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Combined volume of all components in cubic meters, supporting storage planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Combined weight of all components in kilograms, used for logistics and handling.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for the total_quantity field (e.g., kilograms, pieces).',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the BOM record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the BOM record.',
    `version_number` STRING COMMENT 'Sequential version number incremented each time the BOM is revised.',
    `yield_factor_percent` DECIMAL(18,2) COMMENT 'Projected yield efficiency for the BOM, expressed as a percentage of usable output.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the BOM record.',
    CONSTRAINT pk_bill_of_materials PRIMARY KEY(`bill_of_materials_id`)
) COMMENT 'Master reference table for bill_of_materials. Referenced by bom_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`control_recipe` (
    `control_recipe_id` BIGINT COMMENT 'Primary key for control_recipe',
    `material_master_id` BIGINT COMMENT 'Identifier of the catalyst used in this recipe.',
    `template_control_recipe_id` BIGINT COMMENT 'Self-referencing FK on control_recipe (template_control_recipe_id)',
    `approval_status` STRING COMMENT 'Current approval state of the recipe.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe was formally approved for production.',
    `change_reason` STRING COMMENT 'Business reason for the most recent change to the recipe.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the recipe.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recipe record was first created in the system.',
    `control_recipe_description` STRING COMMENT 'Free‑form description of the recipe purpose, scope, and key characteristics.',
    `effective_end_date` DATE COMMENT 'Date after which the recipe is no longer valid (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date from which the recipe is valid for production.',
    `equipment_group` STRING COMMENT 'Logical grouping of equipment (e.g., reactor, distillation column) that the recipe applies to.',
    `flow_rate_lph` DECIMAL(18,2) COMMENT 'Desired liquid flow rate in liters per hour.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this recipe is the default for its product line.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent production run that used this recipe.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the recipe.',
    `ph_setpoint` DECIMAL(18,2) COMMENT 'Target pH value for the reaction environment.',
    `pressure_setpoint_bar` DECIMAL(18,2) COMMENT 'Target pressure in bar for the process step.',
    `recipe_code` STRING COMMENT 'External code or catalogue number that uniquely identifies the recipe across systems.',
    `recipe_name` STRING COMMENT 'Human‑readable name of the control recipe used by operators and engineers.',
    `recipe_type` STRING COMMENT 'Classification of the recipe based on production mode.',
    `revision_number` STRING COMMENT 'Internal revision counter for change management.',
    `safety_class` STRING COMMENT 'Safety classification based on hazard potential.',
    `control_recipe_status` STRING COMMENT 'Current lifecycle status of the recipe.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired product yield expressed as a percentage for this recipe.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature in degrees Celsius for the process step defined by the recipe.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recipe record.',
    `usage_count` STRING COMMENT 'Number of times the recipe has been executed.',
    `version_comment` STRING COMMENT 'Free‑form comment describing the changes in this version.',
    `version_number` STRING COMMENT 'Sequential version number of the recipe definition.',
    CONSTRAINT pk_control_recipe PRIMARY KEY(`control_recipe_id`)
) COMMENT 'Master reference table for control_recipe. Referenced by control_recipe_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`phase` (
    `phase_id` BIGINT COMMENT 'Primary key for phase',
    `predecessor_phase_id` BIGINT COMMENT 'Self-referencing FK on phase (predecessor_phase_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the phase record was first created in the system.',
    `effective_from` DATE COMMENT 'Date from which the phase definition becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the phase definition is no longer valid (null if open‑ended).',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Numeric score representing the phases environmental impact (higher = greater impact).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the phase is currently active and usable in production scheduling.',
    `is_quality_control_phase` BOOLEAN COMMENT 'True if the phase includes mandatory quality control checks.',
    `phase_category` STRING COMMENT 'Category indicating the operational mode of the phase.',
    `phase_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the phase within the plant.',
    `phase_description` STRING COMMENT 'Narrative description of the phase purpose, key activities, and equipment used.',
    `phase_name` STRING COMMENT 'Human‑readable name of the production phase (e.g., Mixing, Reaction, Cooling).',
    `phase_order` STRING COMMENT 'Ordinal position of the phase within a standard production workflow.',
    `pressure_setpoint_bar` DECIMAL(18,2) COMMENT 'Target pressure for the phase expressed in bar.',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether changes to this phase require formal approval.',
    `safety_level` STRING COMMENT 'Safety risk classification for the phase.',
    `temperature_setpoint_c` DECIMAL(18,2) COMMENT 'Target temperature for the phase expressed in degrees Celsius.',
    `typical_duration_minutes` STRING COMMENT 'Average expected duration of the phase in minutes under normal conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the phase record.',
    CONSTRAINT pk_phase PRIMARY KEY(`phase_id`)
) COMMENT 'Master reference table for phase. Referenced by phase_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_control_recipe_id` FOREIGN KEY (`control_recipe_id`) REFERENCES `chemical_mfg_ecm`.`production`.`control_recipe`(`control_recipe_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_control_recipe_id` FOREIGN KEY (`control_recipe_id`) REFERENCES `chemical_mfg_ecm`.`production`.`control_recipe`(`control_recipe_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `chemical_mfg_ecm`.`production`.`phase`(`phase_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `chemical_mfg_ecm`.`production`.`resource`(`resource_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ADD CONSTRAINT `fk_production_dcs_event_log_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ADD CONSTRAINT `fk_production_mes_execution_log_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ADD CONSTRAINT `fk_production_mes_execution_log_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ADD CONSTRAINT `fk_production_equipment_effectiveness_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ADD CONSTRAINT `fk_production_shift_log_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ADD CONSTRAINT `fk_production_production_procurement_plan_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_parent_process_unit_id` FOREIGN KEY (`parent_process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ADD CONSTRAINT `fk_production_plant_parent_plant_id` FOREIGN KEY (`parent_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`plant`(`plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ADD CONSTRAINT `fk_production_resource_parent_resource_id` FOREIGN KEY (`parent_resource_id`) REFERENCES `chemical_mfg_ecm`.`production`.`resource`(`resource_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_superseded_routing_id` FOREIGN KEY (`superseded_routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_parent_bom_id` FOREIGN KEY (`parent_bom_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_superseded_bill_of_materials_id` FOREIGN KEY (`superseded_bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` ADD CONSTRAINT `fk_production_control_recipe_template_control_recipe_id` FOREIGN KEY (`template_control_recipe_id`) REFERENCES `chemical_mfg_ecm`.`production`.`control_recipe`(`control_recipe_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`phase` ADD CONSTRAINT `fk_production_phase_predecessor_phase_id` FOREIGN KEY (`predecessor_phase_id`) REFERENCES `chemical_mfg_ecm`.`production`.`phase`(`phase_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Production Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `control_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Control Recipe ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Order Created By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Production Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `actual_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Production Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `cost_variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Order Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `master_recipe_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Recipe Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `moc_reference` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|semi-continuous|campaign|rework|trial');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Production Priority');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `process_order_type` SET TAGS ('dbx_business_glossary_term' = 'Process Order Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `process_order_type` SET TAGS ('dbx_value_regex' = 'standard|rework|trial|validation|cleaning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Cost Settlement Rule');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `yield_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Formula ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `quaternary_batch_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `quaternary_batch_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `quaternary_batch_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `tertiary_batch_reviewed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `tertiary_batch_reviewed_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `tertiary_batch_reviewed_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `actual_yield_uom` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `actual_yield_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'in_process|released|rejected|quarantine|on_hold|completed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `coa_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Issued Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `coa_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,30}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Batch Comments');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,40}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `formula_version` SET TAGS ('dbx_business_glossary_term' = 'Formula Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `formula_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `manufacturing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `manufacturing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mes_system_version` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) System Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mes_system_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{10,50}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `process_ph_avg` SET TAGS ('dbx_business_glossary_term' = 'Process pH (Potential of Hydrogen) Average');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `process_pressure_avg` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure Average (Bar)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `process_temperature_avg` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature Average (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `reaction_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Reaction Time (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `recipe_phase_executed` SET TAGS ('dbx_business_glossary_term' = 'Recipe Phase Executed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `control_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Control Recipe ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `formula_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formula Version Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `batch_size_category` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `batch_size_category` SET TAGS ('dbx_value_regex' = 'lab|pilot|commercial|full_scale');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `dcs_system_reference` SET TAGS ('dbx_business_glossary_term' = 'DCS (Distributed Control System) System ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `mes_integration_status` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Integration Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `mes_integration_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|in_execution|completed|failed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'MOC (Management of Change) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Process Order Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Process Order Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|campaign|rework|trial|pilot');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `process_order_number` SET TAGS ('dbx_business_glossary_term' = 'Process Order Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `process_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_version` SET TAGS ('dbx_business_glossary_term' = 'Production Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `recipe_number` SET TAGS ('dbx_business_glossary_term' = 'Master Recipe Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `recipe_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'standard|variance|scrap|rework');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|L|MT|GAL|LB|TON');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `batch_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Genealogy Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `bom_item_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Item Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `child_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Child Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `consumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Consumption Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `genealogy_status` SET TAGS ('dbx_business_glossary_term' = 'Genealogy Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `genealogy_status` SET TAGS ('dbx_value_regex' = 'active|archived|quarantined|recalled');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `parent_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Parent Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `process_step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `process_step_description` SET TAGS ('dbx_business_glossary_term' = 'Process Step Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'released|blocked|restricted|inspection');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `quantity_transferred` SET TAGS ('dbx_business_glossary_term' = 'Quantity Transferred');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Relationship Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'consumed|produced|split|merged|blended|reworked');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|MES|DCS|LIMS|MANUAL');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `traceability_chain_depth` SET TAGS ('dbx_business_glossary_term' = 'Traceability Chain Depth');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `traceability_direction` SET TAGS ('dbx_business_glossary_term' = 'Traceability Direction');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `traceability_direction` SET TAGS ('dbx_value_regex' = 'forward|backward|bidirectional');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `transfer_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transfer Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `work_center` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `mes_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_business_glossary_term' = 'Alarm Priority');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `alarm_priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Good|Questionable|Bad|Estimated');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Deviation Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `historian_source_system` SET TAGS ('dbx_business_glossary_term' = 'Historian Source System');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'DCS|PLC|SCADA|Manual Entry|LIMS|Historian');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `parameter_status` SET TAGS ('dbx_value_regex' = 'In Control|Out of Control|OOS|Acceptable|Under Investigation|Approved');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `parameter_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Parameter Tag ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `quality_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `sampling_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Sampling Interval Seconds');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `set_point_value` SET TAGS ('dbx_business_glossary_term' = 'Set Point Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `spc_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Violation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `specification_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Specification Violation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `reaction_step_id` SET TAGS ('dbx_business_glossary_term' = 'Reaction Step Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `formula_id` SET TAGS ('dbx_business_glossary_term' = 'Master Recipe Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `synthesis_procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Procedure Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `critical_step_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `material_charge_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Charge Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `material_charge_uom` SET TAGS ('dbx_business_glossary_term' = 'Material Charge Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `moc_reference` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `required_equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Required Equipment Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `scada_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `sop_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_notes` SET TAGS ('dbx_business_glossary_term' = 'Step Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Step Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `step_type` SET TAGS ('dbx_business_glossary_term' = 'Step Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `target_agitation_rpm` SET TAGS ('dbx_business_glossary_term' = 'Target Agitation Rate (Revolutions Per Minute)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `target_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `target_ph` SET TAGS ('dbx_business_glossary_term' = 'Target pH (Potential of Hydrogen)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `target_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Target Pressure (Bar)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `target_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Target Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `bom_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Consumption ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `actual_quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity Consumed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `bom_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Line Item Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `goods_recipient` SET TAGS ('dbx_business_glossary_term' = 'Goods Recipient');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `reservation_item_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Item Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Amount');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `by_product_code` SET TAGS ('dbx_business_glossary_term' = 'By-Product Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `by_product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `by_product_quantity` SET TAGS ('dbx_business_glossary_term' = 'By-Product Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|MES|DCS_Honeywell|DCS_Siemens|LIMS|Manual');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `loss_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `planned_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Yield Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `process_order_type` SET TAGS ('dbx_business_glossary_term' = 'Process Order Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `process_order_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|semi_batch|campaign');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `production_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `production_line_code` SET TAGS ('dbx_business_glossary_term' = 'Production Line Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `production_line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `production_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Production Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold|released');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `raw_material_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `recipe_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `theoretical_yield_basis` SET TAGS ('dbx_business_glossary_term' = 'Theoretical Yield Basis');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `theoretical_yield_basis` SET TAGS ('dbx_value_regex' = 'bom_standard|process_simulation|historical_average|lab_scale|pilot_scale');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_business_glossary_term' = 'Waste Classification');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `waste_classification` SET TAGS ('dbx_value_regex' = 'hazardous|non_hazardous|recyclable|voc|hap');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `waste_quantity` SET TAGS ('dbx_business_glossary_term' = 'Waste Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Yield Confirmation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_efficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Yield Efficiency Score');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_loss_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `campaign_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `capacity_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Capacity Requirement Hours');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `expected_yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Expected Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `frozen_flag` SET TAGS ('dbx_business_glossary_term' = 'Frozen Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `moc_number` SET TAGS ('dbx_value_regex' = '^MOC-[0-9]{6}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `number_of_batches` SET TAGS ('dbx_business_glossary_term' = 'Number of Batches');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `planning_period` SET TAGS ('dbx_business_glossary_term' = 'Planning Period');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `planning_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2])|W(0[1-9]|[1-4][0-9]|5[0-3]))$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `run_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Run Time Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `safety_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Review Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^SCH-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'planned|firmed|released|in_progress|completed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `scheduling_constraint_notes` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraint Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Method');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `scheduling_method` SET TAGS ('dbx_value_regex' = 'forward|backward|finite|infinite');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'day|night|swing|continuous|weekend');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Supervisor Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `available_capacity_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Hours Per Day');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `batch_size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `batch_size_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|l|m3|ton|gal|lb');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_value_regex' = 'machine|labor|both|none');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `capacity_utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Rate Percent');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `cip_clean_in_place_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean In Place (CIP) Capable Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `crew_size_standard` SET TAGS ('dbx_business_glossary_term' = 'Crew Size Standard');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `dcs_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) System ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `dcs_system_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `dcs_system_type` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) System Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `dcs_system_type` SET TAGS ('dbx_value_regex' = 'honeywell_experion|siemens_pcs7|yokogawa_centum|emerson_deltav|abb_800xa|other');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `efficiency_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Factor Percent');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `ehs_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environment Health and Safety (EHS) Permit Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp_compliant|non_gmp|food_grade|pharmaceutical_grade|not_applicable');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Area Classification');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `hazardous_area_classification` SET TAGS ('dbx_value_regex' = 'division_1|division_2|zone_0|zone_1|zone_2|non_hazardous');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `maximum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `minimum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `next_psr_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Process Safety Review (PSR) Due Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Target Percent');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned|startup|shutdown');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `ph_control_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Potential of Hydrogen (pH) Control Capability Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `pi_system_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Process Information (PI) System Tag Prefix');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `plc_controller_reference` SET TAGS ('dbx_business_glossary_term' = 'Programmable Logic Controller (PLC) Controller ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `pressure_control_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Pressure Control Capability Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `psr_process_safety_review_date` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Review (PSR) Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `scada_node_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Node ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `temperature_control_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Capability Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'batch_processing|continuous_processing|semi_continuous|packaging|quality_control|storage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_type` SET TAGS ('dbx_business_glossary_term' = 'Work Center Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_type` SET TAGS ('dbx_value_regex' = 'reactor|blender|distillation_column|filtration_unit|packaging_line|mixing_vessel');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `production_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Deviation Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `tertiary_production_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `tertiary_production_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `tertiary_production_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `customer_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation Detected Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `deviation_number` SET TAGS ('dbx_value_regex' = '^DEV-[0-9]{8}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `deviation_type` SET TAGS ('dbx_business_glossary_term' = 'Deviation Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `hold_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `hold_released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Released Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'no_hold|quality_hold|production_hold|released');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `immediate_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Immediate Action Taken');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `investigation_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^LOT-[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `moc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `oos_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `oot_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `preventive_action` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `production_deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `production_deviation_status` SET TAGS ('dbx_business_glossary_term' = 'Deviation Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `production_deviation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_approval|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deviation Reported Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Deviation Severity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_change_record_id` SET TAGS ('dbx_business_glossary_term' = 'Process Change Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `primary_process_initiator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiator Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `primary_process_initiator_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `primary_process_initiator_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `affected_equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment Tag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `affected_process_unit` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Unit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `affected_sop_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Standard Operating Procedure (SOP) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Stage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `change_category` SET TAGS ('dbx_value_regex' = 'temporary|permanent|emergency');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'process|equipment|material|procedure|facility|software');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `document_references` SET TAGS ('dbx_business_glossary_term' = 'Document References');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `hazop_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hazard and Operability Study (HAZOP) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `implementation_notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `initiator_department` SET TAGS ('dbx_business_glossary_term' = 'Initiator Department');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `initiator_name` SET TAGS ('dbx_business_glossary_term' = 'Change Initiator Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `initiator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `initiator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Change Justification');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `moc_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `moc_number` SET TAGS ('dbx_value_regex' = '^MOC-[0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `pha_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Process Hazard Analysis (PHA) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `post_implementation_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post Implementation Review Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `post_implementation_review_findings` SET TAGS ('dbx_business_glossary_term' = 'Post Implementation Review Findings');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `post_implementation_review_required` SET TAGS ('dbx_business_glossary_term' = 'Post Implementation Review Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_change_record_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_change_record_status` SET TAGS ('dbx_business_glossary_term' = 'MOC Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `risk_assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `dcs_event_log_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Event Log ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `research_process_simulation_id` SET TAGS ('dbx_business_glossary_term' = 'Research Hysys Simulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Alarm Limit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `alarm_state` SET TAGS ('dbx_business_glossary_term' = 'Alarm State');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `alarm_state` SET TAGS ('dbx_value_regex' = 'active|cleared|suppressed|shelved');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `batches_completed` SET TAGS ('dbx_business_glossary_term' = 'Batches Completed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `batches_in_progress` SET TAGS ('dbx_business_glossary_term' = 'Batches In Progress');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `control_mode_new` SET TAGS ('dbx_business_glossary_term' = 'Control Mode (New)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `control_mode_new` SET TAGS ('dbx_value_regex' = 'automatic|manual|cascade|remote|local');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `control_mode_previous` SET TAGS ('dbx_business_glossary_term' = 'Control Mode (Previous)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `control_mode_previous` SET TAGS ('dbx_value_regex' = 'automatic|manual|cascade|remote|local');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `dcs_node_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Node ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Seconds)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `environmental_readings` SET TAGS ('dbx_business_glossary_term' = 'Environmental Readings');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `equipment_issues` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issues');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `handover_instructions` SET TAGS ('dbx_business_glossary_term' = 'Shift Handover Instructions');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `interlock_reference` SET TAGS ('dbx_business_glossary_term' = 'Interlock ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `material_shortages` SET TAGS ('dbx_business_glossary_term' = 'Material Shortages');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Event Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `process_value` SET TAGS ('dbx_business_glossary_term' = 'Process Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `process_value_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Process Value Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `quality_holds` SET TAGS ('dbx_business_glossary_term' = 'Quality Holds');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `safety_observations` SET TAGS ('dbx_business_glossary_term' = 'Safety Observations');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `setpoint_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `setpoint_value_new` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Value (New)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `setpoint_value_previous` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Value (Previous)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|afternoon|night|weekend|holiday');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'honeywell_experion|siemens_pcs7|aveva_pi|scada_generic');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Supervisor Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`dcs_event_log` ALTER COLUMN `tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Process Tag ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `mes_execution_log_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Execution Log ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'manual_entry|dcs_auto|scada_auto|plc_auto|lims_import');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `dcs_tag_name` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Tag Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `electronic_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `execution_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `instruction_text` SET TAGS ('dbx_business_glossary_term' = 'Instruction Text');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `material_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Material Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `material_quantity` SET TAGS ('dbx_business_glossary_term' = 'Material Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `material_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Material Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `mes_system_version` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) System Version');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `operation_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `operator_response_text` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Text');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `parameter_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `recipe_phase_code` SET TAGS ('dbx_business_glossary_term' = 'Recipe Phase Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `recipe_phase_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Phase Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `record_locked_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Locked Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `record_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `signature_meaning` SET TAGS ('dbx_business_glossary_term' = 'Signature Meaning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `signature_meaning` SET TAGS ('dbx_value_regex' = 'performed|reviewed|approved|verified');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`mes_execution_log` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `formula_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `product_family_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_batch_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Batch Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'dedicated|shared|multi_product|single_product|trial|validation');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `changeover_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Hours');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cip_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Duration Hours');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cip_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Schedule Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cip_schedule_type` SET TAGS ('dbx_value_regex' = 'between_batches|end_of_campaign|as_needed|none');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `master_recipe_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Recipe Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `master_recipe_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,30}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `mes_campaign_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Campaign Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `mes_campaign_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{8,30}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `moc_reference` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `moc_reference` SET TAGS ('dbx_value_regex' = '^MOC-[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `oee_actual_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Actual Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `oee_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Target Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `planned_batch_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Batch Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `quality_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|MT|L|GAL|LB|TON');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Campaign Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Cycle Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Procedure Reference');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_procedure_reference` SET TAGS ('dbx_value_regex' = '^CIP-[A-Z0-9]{4,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_status` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|failed|aborted|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_type` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_type` SET TAGS ('dbx_value_regex' = 'manual|automatic|semi_automatic');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_agent_code` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Agent Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_agent_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_agent_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Agent Concentration (PPM - Parts Per Million)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Agent Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cleaning_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_value_regex' = '^DCS-[A-Z0-9]{8,16}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `deviation_description` SET TAGS ('dbx_business_glossary_term' = 'Deviation Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `flow_rate_liters_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Liters per Minute)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Integration ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `mes_integration_reference` SET TAGS ('dbx_value_regex' = '^MES-[A-Z0-9]{8,16}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `next_product_code` SET TAGS ('dbx_business_glossary_term' = 'Next Product Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `next_product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `next_production_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Next Production Clearance Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `qa_comments` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Comments');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `qa_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `rinse_water_conductivity_us_cm` SET TAGS ('dbx_business_glossary_term' = 'Rinse Water Conductivity (µS/cm - Microsiemens per Centimeter)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `scada_integration_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `scada_integration_reference` SET TAGS ('dbx_value_regex' = '^SCADA-[A-Z0-9]{8,16}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `equipment_effectiveness_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Effectiveness Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notification ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'CAPA (Corrective and Preventive Action) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `dcs_alarm_reference` SET TAGS ('dbx_business_glossary_term' = 'DCS (Distributed Control System) Alarm ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_value_regex' = '^DT-[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|under_investigation');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `downtime_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Downtime Subcategory');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `environmental_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `ideal_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ideal Cycle Time (Seconds)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `mes_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'MES (Manufacturing Execution System) Transaction ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'MOC (Management of Change) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `mtbf_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'MTBF (Mean Time Between Failures) Inclusion Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `mttr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'MTTR (Mean Time To Repair) Inclusion Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `oee_availability_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE (Overall Equipment Effectiveness) Availability Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `oee_performance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE (Overall Equipment Effectiveness) Performance Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `oee_quality_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE (Overall Equipment Effectiveness) Quality Impact Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `planned_downtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Planned Downtime Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time (Minutes)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `production_impact_batches_delayed` SET TAGS ('dbx_business_glossary_term' = 'Production Impact - Batches Delayed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `production_impact_quantity_lost` SET TAGS ('dbx_business_glossary_term' = 'Production Impact - Quantity Lost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `production_impact_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `recovery_action_code` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `recovery_action_description` SET TAGS ('dbx_business_glossary_term' = 'Recovery Action Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `chemical_mfg_ecm`.`production`.`equipment_effectiveness` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_log_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Log ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `batches_completed` SET TAGS ('dbx_business_glossary_term' = 'Batches Completed');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `batches_in_progress` SET TAGS ('dbx_business_glossary_term' = 'Batches In Progress');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `dcs_system_status` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `dcs_system_status` SET TAGS ('dbx_value_regex' = 'normal|degraded|alarm|fault|maintenance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `environmental_readings` SET TAGS ('dbx_business_glossary_term' = 'Environmental Readings');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `equipment_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Minutes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `equipment_issues_noted` SET TAGS ('dbx_business_glossary_term' = 'Equipment Issues Noted');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `handover_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handover Instructions');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `key_events_narrative` SET TAGS ('dbx_business_glossary_term' = 'Key Events Narrative');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `material_shortages_flagged` SET TAGS ('dbx_business_glossary_term' = 'Material Shortages Flagged');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `moc_activities` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Activities');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `operator_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `process_deviations_noted` SET TAGS ('dbx_business_glossary_term' = 'Process Deviations Noted');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `production_area` SET TAGS ('dbx_business_glossary_term' = 'Production Area');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `production_orders_active` SET TAGS ('dbx_business_glossary_term' = 'Production Orders Active');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `production_output_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Output Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `production_output_uom` SET TAGS ('dbx_business_glossary_term' = 'Production Output Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `quality_holds_noted` SET TAGS ('dbx_business_glossary_term' = 'Quality Holds Noted');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `quality_issues_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Issues Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `safety_observations` SET TAGS ('dbx_business_glossary_term' = 'Safety Observations');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `scada_alarms_count` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Alarms Count');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|aborted|extended');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|afternoon|night|swing|graveyard|rotating');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `training_conducted` SET TAGS ('dbx_business_glossary_term' = 'Training Conducted');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `utility_consumption_notes` SET TAGS ('dbx_business_glossary_term' = 'Utility Consumption Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `visitor_contractor_activity` SET TAGS ('dbx_business_glossary_term' = 'Visitor and Contractor Activity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `waste_generation_notes` SET TAGS ('dbx_business_glossary_term' = 'Waste Generation Notes');
ALTER TABLE `chemical_mfg_ecm`.`production`.`shift_log` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` SET TAGS ('dbx_association_edges' = 'production.campaign,supply.vendor');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `production_procurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan - Procurement Plan Id');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan - Production Campaign Id');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan - Vendor Id');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `planned_procurement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Procurement Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_procurement_plan` ALTER COLUMN `total_planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Procurement Value');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `parent_process_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` SET TAGS ('dbx_subdomain' = 'equipment_maintenance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `parent_resource_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `superseded_routing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` SET TAGS ('dbx_subdomain' = 'production_planning');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `superseded_bill_of_materials_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` ALTER COLUMN `control_recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Control Recipe Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`control_recipe` ALTER COLUMN `template_control_recipe_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`phase` SET TAGS ('dbx_subdomain' = 'process_execution');
ALTER TABLE `chemical_mfg_ecm`.`production`.`phase` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`phase` ALTER COLUMN `predecessor_phase_id` SET TAGS ('dbx_self_ref_fk' = 'true');
