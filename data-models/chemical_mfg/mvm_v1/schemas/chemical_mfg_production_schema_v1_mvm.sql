-- Schema for Domain: production | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`production` COMMENT 'Core manufacturing execution domain managing batch and continuous chemical processes, reaction sequences, synthesis operations, and production runs. Includes production orders, batch records, process parameters (temperature, pressure, pH), DCS/PLC integration data (Honeywell Experion, Siemens PCS 7), MES execution logs, yield tracking, lot genealogy, BOM consumption, MOC records, and production scheduling. Captures real-time process data from SCADA systems and maintains production history for traceability and process optimization (SPC, OEE).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` (
    `manufacturing_order_id` BIGINT COMMENT 'Primary key for manufacturing_order',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for order fulfillment: each manufacturing order must be linked to the customer account that placed the order, enabling production scheduling, invoicing, and customer‑specific reporting.',
    `bill_of_materials_id` BIGINT COMMENT 'Identifier for the Bill of Materials defining the raw materials, intermediates, and components required for this production order.',
    `campaign_id` BIGINT COMMENT 'Identifier linking this order to a multi-batch production campaign. Used for extended runs of the same product to optimize changeover and yield.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Production order execution needs product master to fetch specifications, SDS, and regulatory compliance for the material being produced.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Production Cost Allocation Report: each manufacturing order must be charged to a cost center for monthly cost accounting.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to planning.demand_forecast. Business justification: Order release uses the demand forecast that generated the manufacturing order; linking enables the Order Release report.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Manufacturing orders for bulk/dedicated production must reference the customer delivery site to align production parameters (packaging, volume, temperature control) with site capabilities (bulk_receip',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Manufacturing orders in make-to-order chemical manufacturing are settled to internal orders for project cost collection and customer-specific cost tracking. This is distinct from batch_records intern',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Manufacturing Order Planning uses material_master for specs, hazard data, and costing; linking provides single source of truth for each order.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: MRP runs generate planned orders that are firmed into manufacturing orders. Chemical manufacturing planners need this link to audit which MRP run created each manufacturing order and to manage MRP exc',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Manufacturing orders in chemical plants must be authorized under a valid environmental/operating permit. Production scheduling and order release workflows verify permit validity before execution. Regu',
    `order_id` BIGINT COMMENT 'Foreign key linking to product.product_order. Business justification: Manufacturing orders are triggered by customer product orders in make-to-order chemical manufacturing. This link enables order-to-production traceability, delivery date confirmation, and customer-spec',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Manufacturing orders are created to fulfill production plans. Chemical manufacturing S&OP and production control require tracing each manufacturing order to its originating production plan for plan fu',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: manufacturing_order has plant_code as a string field. Normalizing to plant_id FK references the plant master data directly, enabling plant-level manufacturing order aggregation, capacity reporting, an',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: REQUIRED: Production planning ties each manufacturing order to the purchase order that supplies its raw materials, enabling material availability and cost tracking.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: Manufacturing orders for customer-qualified products must reference the governing qualification to enforce correct production version, grade, COA template, and spec. Production planners and QA require',
    `routing_id` BIGINT COMMENT 'Identifier for the production routing or master recipe defining the sequence of operations, process steps, and control parameters.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Manufacturing orders in chemical plants are created at the SKU level to drive production planning, packaging line scheduling, and label generation. This link supports finished goods costing and order-',
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
    `order_status` STRING COMMENT 'Current lifecycle state of the production order: created (planned but not released), released (authorized for execution), started (production begun), in_progress (active manufacturing), confirmed (goods receipt posted), technically_complete (production finished, pending final settlement), closed (financially settled), cancelled (order voided). [ENUM-REF-CANDIDATE: created|released|started|in_progress|confirmed|technically_complete|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the manufacturing process mode: batch (discrete lots), continuous (steady-state flow), semi-continuous (hybrid), campaign (extended multi-batch run), rework (reprocessing off-spec material), or trial (R&D pilot run).. Valid values are `batch|continuous|semi-continuous|campaign|rework|trial`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of finished product to be manufactured, as specified in the production order. Expressed in the base unit of measure.',
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
    `storage_bin_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_bin. Business justification: GMP chemical manufacturing requires tracking the physical storage bin where each produced batch is held pending QC release. Batch-to-bin traceability is mandatory for FIFO/FEFO management and regulato',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: batch_record is the execution record for a single batch. Campaigns manage multi-batch production runs. Linking batch_record to campaign ties each batch EBR to its parent campaign, enabling campaign-le',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Batch record must reference the specific chemical product to associate batch data with product specifications and compliance documents.',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: The batch record is the master GMP document; QA batch release requires direct reference to the primary raw material lot consumed, including its CoA reference, quality inspection result, and supplier l',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Needed for logistics and traceability: batch records must reference the customer site where the product will be delivered, supporting shipping plans, regulatory SDS/COA delivery, and site‑level yield ',
    `equipment_id` BIGINT COMMENT 'Primary reactor, vessel, or processing unit used for this batch. Links to the equipment master for asset tracking and maintenance correlation.',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Each batch in chemical manufacturing is produced to a specific quality grade (reagent, technical, USP, pharmaceutical). Grade determines specification limits, CoA content, and release criteria. A doma',
    `inspection_lot_id` BIGINT COMMENT 'FK to quality.inspection_lot.inspection_lot_id — Batch-to-QC traceability is mandatory for cGMP compliance. Every batch record must link to its quality inspection lot for release decisions. Without this, cannot answer what QC results exist for batc',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Needed for Batch‑Level Expense Tracking: batches are billed against internal orders to capture project‑specific production costs.',
    `line_item_id` BIGINT COMMENT 'Foreign key linking to order.line_item. Business justification: Batch‑to‑order line mapping enables batch traceability, invoicing, and regulatory batch‑lot reporting for each sold line item.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Enables batch traceability required by FDA/EMA regulations linking batch records to physical lots.',
    `notification_id` BIGINT COMMENT 'Foreign key linking to maintenance.notification. Business justification: Needed for Batch Execution Log to capture the maintenance notification that caused a batch hold, used in compliance and downtime analysis reports.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order that authorized this batch. Links the batch record to the planning and scheduling system (SAP PP Production Planning).',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: Each batch record originates from an MRP run; linking supports the Batch‑to‑MRP traceability audit.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: The Electronic Batch Record (EBR) is the execution audit trail for a batch. In SAP PP environments, each batch execution is tied to a specific process_order. Linking batch_record to process_order prov',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: GMP regulations require each batch record to reference the product specification against which the batch was tested and released. This is a mandatory link for batch disposition, OOS investigations, an',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Batch records document actual execution of planning-domain production schedules. GMP compliance and schedule adherence reporting in chemical manufacturing requires linking each batch record to the pla',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: GMP traceability requirement: each batch must reference the customer qualification (APL entry) that authorized production of that product grade/spec. QA uses this link to verify COA template, spec lim',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: BATCH: Each batch fulfills a specific quote line; FK supports batch‑level traceability to sales commitments and compliance reporting.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: GMP and process safety regulations require each batch record to reference the active SDS version in effect during manufacturing. Regulatory inspections and incident investigations verify SDS currency ',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to production.schedule. Business justification: batch_record execution should reference the schedule that planned it. Linking batch_record to schedule enables schedule adherence analysis — comparing planned vs. actual batch execution times, quantit',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: In GMP chemical manufacturing, each batch is produced to a specific SKU (pack size, packaging config, grade). This link drives Certificate of Analysis issuance, lot traceability at the SKU level, and ',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: REQUIRED: Quality and traceability reports link each batch record to the goods receipt that delivered the raw material lot.',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: Batch records in chemical manufacturing are directly linked to usage decisions for batch disposition (release/reject/reprocess). The usage decision is the formal quality release step that closes the b',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Batch records in chemical manufacturing generate specific waste streams (solvent residues, reaction by-products). RCRA compliance and TRI reporting require linking each batch to its waste stream. GMP ',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: batch_record is the EBR for a batch execution. Linking to work_center identifies which reactor, vessel, or processing line executed the batch, enabling work center-level batch history, OEE calculation',
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
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to production.bill_of_materials. Business justification: In SAP PP, process orders are created with reference to a BOM for material requirements planning. Linking process_order to bill_of_materials normalizes the BOM reference and enables BOM-level process ',
    `campaign_id` BIGINT COMMENT 'Identifier linking multiple process orders in a production campaign. Used for extended manufacturing runs of the same product to minimize changeover, reduce CIP cycles, and optimize asset utilization.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Process order scheduling and quality checks depend on product master to obtain recipe, hazard class, and regulatory data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process orders are primary cost collection objects in chemical manufacturing controlling. Every process order is assigned to a cost center for variance analysis and period-end cost settlement. The exi',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Process orders in chemical manufacturing are grade-specific — the grade determines the master recipe, quality inspection plan, and specification limits applied during execution. A domain expert would ',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Process orders in chemical manufacturing are executed against a specific inspection plan defining quality gates at each production stage. This is a standard SAP PP-QM integration point enabling automa',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: In chemical manufacturing, process orders for campaign-based or project-based production are settled to internal orders for cost collection. This supports make-to-order cost tracking and project manuf',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: A SAP PP Process Order is the execution-level instruction that implements a manufacturing_order authorization. In chemical manufacturing ERP/MES environments, the process_order (SAP entity) and manufa',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Process Order Execution requires raw‑material safety and quality data; FK enables real‑time compliance checks.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: MRP runs generate planned orders that are converted to process orders in chemical manufacturing. Planners and production controllers need to trace which MRP run originated a process order for exceptio',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Chemical manufacturing process orders must be executed under a valid operating permit. Order release workflows verify permit validity; regulatory audits trace each production run to its authorizing pe',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Production scheduling dashboards require linking process orders directly to the originating sales order for capacity planning and KPI tracking.',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Process orders are executed to fulfill production plans in chemical manufacturing. S&OP reporting requires tracing actual process order execution back to the originating production plan for plan vs. a',
    `production_plant_id` BIGINT COMMENT 'FK to production.plant',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Planning production schedules drive process order creation and sequencing in chemical manufacturing. Production controllers need this link to confirm scheduled vs. actual execution and manage schedule',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: In SAP PP, process orders reference a master recipe/routing that defines the sequence of operations. Linking process_order to routing normalizes the routing reference (complementing the string recipe_',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Process orders in chemical manufacturing are executed to produce a specific SKU, driving packaging instructions, labeling requirements, and shipping documentation. SKU-level process orders enable accu',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Each process order generates predictable waste streams. Environmental compliance programs and TRI/RCRA reporting require linking process orders to their associated waste streams for waste generation f',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: process_order has production_line as a string field but no work_center_id FK. In SAP PP, process orders are assigned to work centers for capacity planning and scheduling. Linking to work_center normal',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual timestamp when manufacturing execution completed and product was discharged, as confirmed by MES or operator. Triggers quality inspection workflow and lot release process.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual timestamp when manufacturing execution began, as confirmed by MES or operator. Used for OEE (Overall Equipment Effectiveness) calculation and schedule variance analysis.',
    `batch_size_category` STRING COMMENT 'Classification of process order scale. Lab for R&D bench-scale (<10kg), pilot for scale-up trials (10-1000kg), commercial for standard production (>1000kg), full_scale for maximum reactor capacity utilization.. Valid values are `lab|pilot|commercial|full_scale`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished product manufactured and confirmed by operator or MES. May differ from planned due to yield loss, reaction efficiency, or quality rejections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the process order record was created in SAP PP. Marks the beginning of the order lifecycle for lead time analysis and planning cycle measurement.',
    `dcs_system_reference` STRING COMMENT 'Identifier for the DCS or SCADA system instance managing this process order. Maps to Honeywell Experion, Siemens SIMATIC PCS 7, or Aveva PI System historian for real-time data integration.',
    `hazard_classification` STRING COMMENT 'GHS hazard classification for the product being manufactured. Determines PSM (Process Safety Management) requirements, permit-to-work rules, and EHS monitoring. Aligns with SDS Section 2 hazard identification. [ENUM-REF-CANDIDATE: non_hazardous|flammable|corrosive|toxic|oxidizer|explosive|reactive — 7 candidates stripped; promote to reference product]',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: batch_genealogy tracks parent-child lineage of chemical batches through multi-stage synthesis. Linking to batch_record ties the genealogy record to the specific EBR for each batch in the lineage chain',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Batch genealogy records trace parent/child batch relationships for a specific chemical product — essential for regulatory traceability, product recall management, and REACH/FDA compliance reporting. A',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Batch genealogy tracks parent-child batch relationships for traceability. Linking the child batch to its inventory lot enables recall management and forward/backward traceability reports required by F',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: Batch genealogy tracing in chemical manufacturing requires equipment-level traceability for contamination investigations and regulatory audits (FDA 21 CFR Part 11, EU GMP Annex 11). batch_genealogy ha',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Batch genealogy in chemical manufacturing must trace raw material batches to their vendor goods receipts for full provenance — required by FDA 21 CFR Part 11, REACH, and GMP regulations. This link ena',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Batch genealogy records must reference inspection lots for each batch node in the traceability chain — a GMP and regulatory requirement. This link enables full quality traceability across parent-child',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Batch genealogy tracks which raw material lots fed into which production batches — the foundational traceability requirement in chemical manufacturing. Linking batch_genealogy to lot_record enables fo',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: Link batch genealogy to its manufacturing order for traceability; production_order_number is redundant once the FK exists.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Batch Genealogy traceability links each child batch to the originating raw material for audit and regulatory reporting.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to production.process_unit. Business justification: batch_genealogy tracks the lineage of chemical batches through multi-stage synthesis. Linking to process_unit identifies which process unit (reactor, vessel, blending unit) was used at each stage of t',
    `quality_deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Batch genealogy nodes reference quality deviations that affected specific batches in the traceability chain. This link enables identification of which genealogy nodes were impacted by quality events, ',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: batch_genealogy has work_center as a string field. Normalizing to work_center_id FK references the work center master data directly, enabling work center-level genealogy analysis and traceability. The',
    `bom_item_number` STRING COMMENT 'The BOM item number from the production recipe that defines this parent-child material relationship. Links to SAP PP BOM structure.',
    `child_batch_number` STRING COMMENT 'The batch number of the downstream child batch (intermediate or finished good) produced in this production relationship. Part of the lot genealogy traceability chain.',
    `coa_reference_number` STRING COMMENT 'The COA reference number associated with this batch genealogy relationship, linking to quality test results and compliance documentation.',
    `consumption_percentage` DECIMAL(18,2) COMMENT 'The percentage of the parent batch consumed to produce the child batch, enabling yield and material balance calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this batch genealogy record was first created in the system, providing audit trail for data lineage.',
    `customer_order_number` STRING COMMENT 'The customer order number if this batch genealogy relationship was created for a specific customer order, enabling customer-specific traceability.',
    `dcs_batch_reference` STRING COMMENT 'The batch identifier from the DCS (Honeywell Experion or Siemens PCS 7) that recorded this batch relationship in real-time process control.',
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
    `yield_percentage` DECIMAL(18,2) COMMENT 'The yield percentage achieved in this batch transformation from parent to child, calculated as (actual output / theoretical output) * 100.',
    CONSTRAINT pk_batch_genealogy PRIMARY KEY(`batch_genealogy_id`)
) COMMENT 'Tracks the parent-child lineage of chemical batches through multi-stage synthesis and blending operations. Records upstream raw material lot numbers, intermediate batch numbers, and downstream finished goods batch numbers involved in a production run. Captures relationship type (consumed, produced, split, merged), quantity transferred, transfer date, process step, and traceability chain depth. Enables full forward and backward lot traceability required by FDA, REACH, and customer COA requests. Links raw material batches through intermediates to finished product batches.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Unique identifier for the process parameter record. Primary key for this entity.',
    `batch_record_id` BIGINT COMMENT 'Reference to the production batch or lot during which this parameter was measured or controlled.',
    `equipment_id` BIGINT COMMENT 'Reference to the equipment or asset where this parameter was measured or controlled.',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_characteristic. Business justification: Process parameters (DCS/historian readings) map directly to inspection characteristics for process capability analysis and SPC. In chemical manufacturing PAT frameworks, each monitored parameter corre',
    `measurement_point_id` BIGINT COMMENT 'Foreign key linking to maintenance.measurement_point. Business justification: Process parameters in chemical manufacturing are measured by calibrated instruments registered as maintenance measurement points. parameter_tag_reference is a plain-text denormalization of measurement',
    `reaction_step_id` BIGINT COMMENT 'Foreign key linking to production.reaction_step. Business justification: process_parameter records CPPs (Critical Process Parameters) measured during manufacturing. Linking to reaction_step provides the specific step context for each parameter measurement (e.g., temperatur',
    `spc_control_id` BIGINT COMMENT 'Foreign key linking to quality.spc_control. Business justification: Process parameter measurements are the source data for SPC control charts in chemical manufacturing. Linking process_parameter to spc_control enables real-time SPC violation detection, control chart u',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: reaction_step defines individual steps within a chemical synthesis sequence. Linking to batch_record ties each step execution to the specific EBR, enabling step-level audit trail within the batch reco',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Step-level lot traceability is required in GMP chemical manufacturing (FDA 21 CFR Part 211, EU GMP Annex 15). Each reaction step consumes a specific raw material lot. Role-prefix consumed_ distingui',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment unit assigned to execute this reaction step. Links to the equipment master data for traceability.',
    `inspection_characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_characteristic. Business justification: GMP regulations require specific reaction steps (pH adjustment, temperature hold) to be tied to defined inspection characteristics for in-process control (IPC). This link enables process analytical te',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the parent production order under which this reaction step is executed. Links the step to the overall manufacturing order.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Reaction Step records the specific raw material charged; linking to material_master ensures traceability and regulatory reporting.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Each reaction step charges a specific material quantity that must be validated against the material specification (assay limits, pH, viscosity, purity). GMP regulations require that the specification ',
    `process_safety_info_id` BIGINT COMMENT 'Foreign key linking to ehs.process_safety_info. Business justification: PSM regulations (OSHA 1910.119, EPA RMP) require process safety information to be linked to specific process steps. HAZOP and PHA studies reference process steps against PSI documents. Chemical manufa',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: reaction_step defines individual steps within a chemical synthesis sequence. routing defines the master sequence of operations for a production process. Linking reaction_step to routing normalizes the',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: bom_consumption records actual material consumption against a production order. Linking to batch_record provides the specific batch execution context for each consumption transaction, enabling traceab',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: BOM consumption tracking needs product master reference to validate material codes, safety data, and costing.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Material consumption postings in chemical manufacturing are assigned to cost elements (raw material cost elements) for cost component split reporting and product costing. This link enables the control',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: BOM consumption records in GMP chemical manufacturing reference the specific goods receipt from which consumed raw material was drawn — required for batch traceability, material document reconciliatio',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: BOM consumption records which specific inventory lot of raw material was consumed in a batch. Required for full material traceability (REACH, FDA 21 CFR Part 211). lot_number is a denormalized referen',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Actual material consumption must be traceable to a specific incoming raw material lot for GMP batch genealogy, FDA/REACH regulatory traceability, and recall management. bom_consumption has lot_number ',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order against which this material consumption was posted.',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or intermediate component consumed in this transaction.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: In SAP PP, goods movements (material consumption) are posted against process orders. Linking bom_consumption to process_order provides the SAP-side traceability for material consumption transactions, ',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Each BOM consumption event reduces a specific stock position. Linking directly enables real-time inventory impact reconciliation per goods-issue posting, supporting material requirements planning accu',
    `supplier_material_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.supplier_material. Business justification: BOM consumption records must reference the specific supplier material used (grade, compliance status, price) for supplier performance tracking, cost accounting by supplier, and compliance verification',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: bom_consumption has work_center_code as a string field. Normalizing to work_center_id FK references the work center master data directly, enabling work center-level material consumption analysis and c',
    `actual_quantity_consumed` DECIMAL(18,2) COMMENT 'Actual quantity of material consumed and posted against the production order.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this consumption was posted automatically via backflushing at production confirmation.',
    `bom_line_item_number` STRING COMMENT 'Line item sequence number in the BOM structure indicating which component this consumption relates to.',
    `cas_number` STRING COMMENT 'CAS registry number of the consumed chemical substance for regulatory tracking and compliance.',
    `cost_center_code` STRING COMMENT 'Cost center to which the material consumption cost is allocated.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date of the physical goods movement or consumption event.',
    `goods_recipient` STRING COMMENT 'Name or identifier of the person or entity receiving the goods for production use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this consumption record was last updated or modified.',
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
    CONSTRAINT pk_bom_consumption PRIMARY KEY(`bom_consumption_id`)
) COMMENT 'Transactional record of actual raw material and intermediate component consumption against a production or process order BOM. Captures material number, component description, BOM line item, planned quantity, actual quantity consumed, unit of measure, lot number consumed, storage location, goods movement type (SAP MM 261/262), posting date, backflush flag, variance quantity, variance percentage, and cost impact. Enables yield analysis, material balance reconciliation, and COGS calculation per batch. Sourced from SAP PP goods movement postings.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`yield_record` (
    `yield_record_id` BIGINT COMMENT 'Unique identifier for the yield record. Primary key for the yield record entity.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to production.batch_record. Business justification: yield_record captures actual production yield for each batch. The batch_record IS the authoritative EBR for that batch. Linking yield_record to batch_record normalizes the batch reference (replacing t',
    `breakdown_event_id` BIGINT COMMENT 'Foreign key linking to maintenance.breakdown_event. Business justification: OEE and yield-loss reporting in chemical manufacturing explicitly correlates production yield losses with equipment breakdown events. This link enables root-cause yield analysis and is a standard KPI ',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Yield reporting ties actual yields to the product master for performance analysis and regulatory reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Yield confirmation in chemical manufacturing creates or updates an inventory lot. Linking yield_record to lot enables yield-to-lot traceability required for regulatory batch release reporting and qual',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order or manufacturing order (SAP PP module) for which this yield was recorded. Links yield data to the specific production execution.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Yield variance analysis requires comparing actual yield against the theoretical_yield_basis derived from material specification parameters (assay_min/max, purity). Chemical manufacturing yield reports',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: In SAP PP, yield confirmation (goods receipt) is posted against the process_order. Linking yield_record to process_order provides the SAP-side traceability for yield data, enabling reconciliation betw',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Actual yield records are compared against production plan targets in chemical manufacturing for plan accuracy reporting and future plan calibration. Planners use yield variance data to adjust safety s',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to production.schedule. Business justification: yield_record captures actual production yield for each batch/production run. Linking to schedule enables comparison of actual yield against planned yield quantities in the master production schedule, ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Yield performance in chemical manufacturing is tracked at the SKU level for standard cost accounting, profitability analysis, and production efficiency reporting. SKU-level yield records enable varian',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: Yield variance reporting in chemical manufacturing requires the standard cost per unit to calculate the financial value of yield losses. Linking yield_record to standard_cost enables automated yield v',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Yield confirmation posts produced quantity to a specific stock position. This direct link enables yield-to-stock reconciliation for production accounting and inventory accuracy reporting — a standard ',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: Yield records in chemical manufacturing are finalized only after a usage decision (release/reject/reprocess) is made. The usage decision determines whether yield counts as saleable output. This link e',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: Yield records capture waste_quantity and waste_classification attributes, confirming waste generation tracking. Linking yield records to the specific waste stream enables RCRA and TRI regulatory waste',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: yield_record captures actual production yield for each batch/production run. Linking to work_center enables work center-level yield analysis, OEE calculation, and capacity utilization reporting. yield',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of product produced and confirmed in the production run. This is the measured output after completion of the batch.',
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
    `inspection_plan_id` BIGINT COMMENT 'Reference to the quality control plan that defines the inspection points, test methods, and acceptance criteria for this scheduled production.',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the parent production order that this schedule is fulfilling.',
    `order_id` BIGINT COMMENT 'Reference to the customer sales order that is driving this production schedule, if this is make-to-order production.',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Production scheduling in chemical mfg must coordinate with PM plans to avoid scheduling production runs during planned shutdowns. Schedulers explicitly check PM plan windows when building production s',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: The master production schedule drives the creation of process orders in SAP PP. Linking schedule to process_order provides the planning-to-execution traceability chain, enabling analysis of schedule a',
    `production_plan_id` BIGINT COMMENT 'Foreign key linking to planning.production_plan. Business justification: Production schedules are derived from and must reconcile with production plans. Chemical manufacturing S&OP processes require tracing each production schedule back to the authorizing production plan f',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: schedule has plant_code as a string field. Normalizing to plant_id FK references the plant master data directly, enabling plant-level schedule aggregation and reporting. The plant_code string field be',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: The planning-domain production_schedule is the upstream driver of the production-domain schedule. Chemical manufacturing execution systems need this link to confirm that production schedules are execu',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: SCHEDULE: Production schedules are driven by sales quotes; FK provides end‑to‑end visibility from quote to scheduled capacity.',
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
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to production.process_unit. Business justification: Work center belongs to a process unit type; adding process_unit_id creates parent reference and removes silo.',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Work center is located at a plant; adding plant_id links to plant master and allows removal of redundant plant_code.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to production.resource. Business justification: Work center may be associated with a generic resource; adding resource_id creates proper reference.',
    `sampling_plan_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_plan. Business justification: Work centers have associated sampling plans defining how and how frequently samples are taken at that production location — a GMP in-process control requirement. This link enables work-center-specific',
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
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Deviation records need product master link to retrieve hazard classification and compliance requirements for root‑cause analysis.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: GMP and quality regulations in chemical manufacturing require production deviations to be linked to corrective maintenance work orders when equipment is the root cause. Role-prefix corrective_ disti',
    `equipment_id` BIGINT COMMENT 'Reference to the specific equipment or asset involved in the deviation, if applicable.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Production deviations requiring rework, reprocessing, or disposal generate costs tracked against internal orders in chemical manufacturing (e.g., rework internal orders, scrap disposal orders). This l',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Production deviations are tied to specific inventory lots for quarantine and disposition decisions. lot_number on production_deviation is a denormalized reference to inventory.lot. Direct FK enables a',
    `lot_record_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.lot_record. Business justification: Production deviations frequently involve specific raw material lots (wrong lot used, OOS lot, contaminated lot). Linking to lot_record enables deviation investigation to access the full lot history, C',
    `manufacturing_order_id` BIGINT COMMENT 'Reference to the production order during which the deviation occurred.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Deviation Management reports must reference the exact raw material to assess impact on safety and quality.',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: OOS (out-of-specification) and OOT deviations directly reference the material specification that was violated — the specification defines the acceptance criteria that triggered the deviation. producti',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: production_deviation records OOS events and production holds. In SAP PP environments, deviations are tied to the process_order as the execution entity. Linking to process_order provides the SAP-side t',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Production deviations (OOS/OOT events) are evaluated against the product specification to determine severity and regulatory reportability. GMP regulations require deviations to reference the specifica',
    `quality_deviation_id` BIGINT COMMENT 'FK to quality.deviation.deviation_id — Production deviations must link to formal quality deviation investigations for cGMP compliance. Enables find all deviations for batch X queries spanning production and quality.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Production deviations directly impact specific customer order lines (shipment holds, quantity shortfalls, customer notifications). production_deviation has customer_notification_required_flag and cust',
    `reaction_step_id` BIGINT COMMENT 'Foreign key linking to production.reaction_step. Business justification: Deviations in chemical manufacturing often occur at specific reaction steps (e.g., temperature excursion during step 3, pH deviation during step 5). Linking production_deviation to reaction_step provi',
    `regulatory_profile_id` BIGINT COMMENT 'Foreign key linking to customer.regulatory_profile. Business justification: When a production deviation is regulatory-reportable, EHS and QA must reference the customers regulatory profile to determine notification obligations (REACH, TSCA, export license). This directly dri',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Records the inventory location where deviated material is held, needed for deviation handling reports.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: production_deviation has work_center_code as a string field. Normalizing to work_center_id FK references the work center master data directly, enabling work center-level deviation analysis and OEE imp',
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
    CONSTRAINT pk_production_deviation PRIMARY KEY(`production_deviation_id`)
) COMMENT 'Records deviations, non-conformances, OOS events, and production holds that occur during manufacturing. Captures deviation type, severity, affected batch, hold status, root cause, and resolution actions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_change_record` (
    `process_change_record_id` BIGINT COMMENT 'Unique identifier for the Management of Change (MOC) record. Primary key for process change tracking and PSM compliance.',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to production.bill_of_materials. Business justification: MOC records frequently involve changes to BOMs (formula changes, raw material substitutions). Linking process_change_record to bill_of_materials normalizes the BOM reference and enables BOM version ch',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: MOC records can affect entire production campaigns (e.g., a process change implemented mid-campaign). Linking process_change_record to campaign enables campaign-level change impact tracking and post-i',
    `cas_registry_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.cas_registry. Business justification: MOC (Management of Change) tracks regulatory status of affected chemicals; FK to CAS registry provides authoritative data.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Process change records must link to the affected chemical product to assess impact on SDS and regulatory filings.',
    `equipment_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment. Business justification: MOC records in chemical mfg reference specific equipment being modified or affected. affected_equipment_tag is a plain-text denormalization of maintenance.equipment. A proper FK enforces referential i',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: OSHA PSM and EPA RMP mandate that MOC (Management of Change) processes include hazard review documentation. Process change records must reference the HAZOP study that assessed the change. The denormal',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Management of Change (MOC) in chemical manufacturing requires identifying and updating affected inspection plans when process changes are implemented. This link enables the MOC workflow to track which',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Management of Change (MOC) activities in chemical manufacturing incur engineering, validation, and training costs tracked against internal orders. process_change_record already has actual_cost and ',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: MOC (Management of Change) records track approved changes to production processes. Linking to manufacturing_order identifies which specific production runs were affected by or implemented under the ch',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Management of Change (MOC) in chemical manufacturing frequently involves changes to material specifications — new supplier qualification, revised purity limits, or changed hazard classification. The p',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Process changes in chemical manufacturing may require permit modifications or regulatory notifications. MOC procedures require verifying permit compliance before implementing changes. Regulatory audit',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: In chemical manufacturing, process change records (MOC) are frequently initiated by customer-driven requirements surfaced through sales opportunities (formulation changes, new application specs, regul',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: Associate process change records with the process order they modify; enables tracking of changes per order.',
    `product_specification_id` BIGINT COMMENT 'Foreign key linking to product.product_specification. Business justification: Management of Change (MOC) records in chemical manufacturing must reference the product specification affected by the process change. Regulatory agencies (FDA, ECHA) require change control documentati',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to customer.qualification. Business justification: MOC/change control requirement: process changes affecting a qualified product must reference the impacted customer qualification to trigger change notification obligations (change_notification_require',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: MOC records frequently involve changes to production routings (process sequences, operation parameters). Linking process_change_record to routing normalizes the routing reference and enables routing v',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: MOC records have affected_process_unit and affected_equipment_tag as string fields. Linking to work_center normalizes the work center reference for process changes, enabling work center-level change h',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Management of Change (MOC) in chemical manufacturing requires process changes to trigger maintenance work orders for equipment modification, re-commissioning, or re-validation. process_change_record h',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for implementing the change, captured after completion.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the change was implemented in the production environment.',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to production.bill_of_materials. Business justification: A campaign manages multi-batch production runs for the same product or product family. The campaign should reference the BOM used for all batches in the campaign, enabling campaign-level material plan',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: Production campaigns in chemical manufacturing are dedicated to a specific chemical product — campaign planning, CIP scheduling, and OEE reporting are all product-specific. A domain expert would expec',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production campaigns in chemical manufacturing aggregate costs across multiple batches and are assigned to cost centers for campaign-level cost roll-up, OEE financial reporting, and period-end cost al',
    `grade_id` BIGINT COMMENT 'Foreign key linking to product.grade. Business justification: Campaigns in chemical manufacturing are often grade-dedicated (pharmaceutical grade vs industrial grade runs require different cleaning validation and quality protocols). Grade-level campaign tracking',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Production campaigns in chemical manufacturing are executed against a campaign-level inspection plan defining quality checkpoints across all batches in the campaign. This link enables campaign quality',
    `pm_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_plan. Business justification: Campaign planning includes the associated preventive maintenance plan for equipment, essential for the Production‑Maintenance Alignment Dashboard.',
    `production_plant_id` BIGINT COMMENT 'FK to production.plant',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Campaigns are planned to produce a chemical product to a specific quality specification (grade, purity, regulatory standard). The quality specification governs the entire campaigns quality targets an',
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
    `campaign_id` BIGINT COMMENT 'Foreign key linking to production.campaign. Business justification: CIP (Clean-In-Place) records document cleaning operations between production runs. In chemical manufacturing, CIP is a critical part of campaign changeover — cleaning is performed between campaigns or',
    `campaign_plan_id` BIGINT COMMENT 'Foreign key linking to planning.campaign_plan. Business justification: CIP (Clean-In-Place) records are planned and scheduled as part of campaign plans in chemical manufacturing. Campaign plans include CIP duration and scheduling between product runs; linking CIP records',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: GMP CIP records must document the specific lot of cleaning agent used for equipment cleaning validation. Required for regulatory audit trails (FDA, EMA). Role-prefix cleaning_agent_ distinguishes th',
    `equipment_id` BIGINT COMMENT 'Identifier of the reactor, vessel, pipeline, or processing equipment that was cleaned. Links to the equipment master data.',
    `functional_location_id` BIGINT COMMENT 'Functional location identifier where the CIP operation was performed. Provides hierarchical plant structure context.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: CIP (Clean-In-Place) records generate inspection lots for cleaning validation — a mandatory GMP requirement in chemical manufacturing. The inspection lot verifies cleaning effectiveness (residue testi',
    `manufacturing_order_id` BIGINT COMMENT 'Identifier of the production order that preceded this CIP cycle. Links the CIP record to the manufacturing order for lot genealogy and traceability.',
    `chemical_product_id` BIGINT COMMENT 'Foreign key linking to product.chemical_product. Business justification: CIP (Clean-In-Place) records document equipment cleaning between product campaigns. The next product to be manufactured determines cleaning validation requirements and cross-contamination risk assessm',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: CIP scheduling needs the previous products raw‑material details to validate cleaning effectiveness.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to production.process_unit. Business justification: CIP records document cleaning of reactors, vessels, and processing lines. process_unit is the master reference for these physical units. Linking cip_record to process_unit normalizes the equipment/uni',
    `production_plant_id` BIGINT COMMENT 'FK to production.plant',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: CIP activities are scheduled within planning production schedules as changeover/cleaning blocks between product campaigns. Chemical manufacturing schedulers need this link to track CIP execution again',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: CIP records reference quality specifications for cleaning validation acceptance criteria (residue limits, microbial limits). GMP regulations require cleaning validation to be performed against defined',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to production.schedule. Business justification: CIP operations are planned cleaning activities that should be reflected in the production schedule. Linking cip_record to schedule ties cleaning execution to the planned schedule, enabling schedule ad',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to ehs.waste_stream. Business justification: CIP operations generate specific waste streams (spent cleaning agents, contaminated rinse water). Environmental compliance requires tracking CIP-generated waste to the appropriate waste stream for dis',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center (production line or area) where the CIP-cleaned equipment is located. Links to work center master data.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: In GMP-regulated chemical facilities, CIP operations are executed under maintenance work orders for traceability, labor tracking, and compliance documentation. cip_record has equipment_id and function',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`process_unit` (
    `process_unit_id` BIGINT COMMENT 'Primary key for process_unit',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process units (reactors, distillation columns) in chemical plants are assigned to cost centers for maintenance cost collection, depreciation allocation, and energy cost tracking. A chemical manufactur',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Process units are major capital assets in chemical manufacturing. Linking to fixed_asset enables depreciation tracking, net book value reporting, insurance valuation, and capital expenditure managemen',
    `hazop_study_id` BIGINT COMMENT 'Foreign key linking to ehs.hazop_study. Business justification: HAZOP studies are conducted on specific process units under OSHA PSM and EPA RMP requirements. Process safety management requires each process unit to reference its governing HAZOP study for risk mana',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Each process unit in a chemical plant operates under specific permit conditions (air permits, water discharge permits). Permit compliance monitoring, inspection scheduling, and regulatory reporting re',
    `tank_id` BIGINT COMMENT 'Foreign key linking to inventory.tank. Business justification: In chemical manufacturing, process units (reactors, distillation columns) feed directly into product tanks. This operational link is required for tank-level inventory management, feed-forward scheduli',
    `parent_process_unit_id` BIGINT COMMENT 'Self-referencing FK on process_unit (parent_process_unit_id)',
    `production_plant_id` BIGINT COMMENT 'FK to production.plant',
    `capacity` DECIMAL(18,2) COMMENT 'Designed production capacity of the unit.',
    `capacity_uom` STRING COMMENT 'Unit of measure for the capacity field.',
    `commissioning_date` DATE COMMENT 'Date the unit passed all acceptance tests and entered service.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the unit.',
    `control_system` STRING COMMENT 'Distributed control system that governs the unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the master record was first created.',
    `decommission_date` DATE COMMENT 'Date the unit was permanently taken out of service, if applicable.',
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
    `operating_mode` STRING COMMENT 'Mode in which the unit runs.',
    `operating_shift` STRING COMMENT 'Typical shift schedule for the unit.',
    `process_unit_description` STRING COMMENT 'Free‑form description of the units purpose and characteristics.',
    `process_unit_group` STRING COMMENT 'Logical grouping or line to which the unit belongs.',
    `process_unit_status` STRING COMMENT 'Current operational status of the unit.',
    `safety_rating` STRING COMMENT 'Safety classification based on industry standards.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the unit.',
    `unit_code` STRING COMMENT 'External code or tag assigned to the unit by engineering standards.',
    `unit_type` STRING COMMENT 'Category of the unit describing its primary function in the plant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the master record.',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Master reference table for process_unit. Referenced by process_unit_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`production_plant` (
    `production_plant_id` BIGINT COMMENT 'Primary key for plant',
    `facility_id` BIGINT COMMENT 'Foreign key linking to ehs.facility. Business justification: Chemical manufacturing plants must be linked to their EHS facility record for integrated environmental compliance, permit management, emissions reporting, and regulatory submissions. Integrated EHS-pr',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Chemical manufacturing plants belong to legal entities for statutory financial reporting, transfer pricing between plants, environmental liability reporting, and regulatory compliance. Every plant mus',
    `parent_plant_production_plant_id` BIGINT COMMENT 'Self-referencing FK on plant (parent_plant_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Plants in chemical manufacturing are mapped to profit centers for segment P&L reporting, transfer pricing, and management reporting by business segment. This is a standard SAP organizational assignmen',
    `address_line1` STRING COMMENT 'Primary street address of the plant location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sq_meters` DECIMAL(18,2) COMMENT 'Physical size of the plant site.',
    `capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Design‑rated mass production capacity of the plant.',
    `capacity_volume_m3_per_day` DECIMAL(18,2) COMMENT 'Design‑rated volumetric production capacity of the plant.',
    `city` STRING COMMENT 'City of the plants physical location.',
    `country_code` STRING COMMENT 'Three‑letter country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the plant record was first created in the system.',
    `emergency_contact_name` STRING COMMENT 'Name of the person responsible for emergency coordination.',
    `emergency_contact_number` STRING COMMENT 'Phone number to call for plant emergency response.',
    `emissions_co2_tons_per_year` DECIMAL(18,2) COMMENT 'Reported greenhouse‑gas emissions for the plant per year.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection activity.',
    `is_hazardous` BOOLEAN COMMENT 'True if the plant processes or stores regulated hazardous substances.',
    `last_inspection_date` DATE COMMENT 'Calendar date of the latest safety or regulatory inspection.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the plant for mapping and GIS analysis.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the plant for mapping and GIS analysis.',
    `maintenance_strategy` STRING COMMENT 'Approach used for maintaining plant equipment.',
    `manager_contact_phone` STRING COMMENT 'Primary contact telephone for the plant manager.',
    `manager_email` STRING COMMENT 'Primary email address for the plant manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for plant operations.',
    `number_of_shifts` STRING COMMENT 'Count of distinct production shifts run each calendar day.',
    `number_of_units` STRING COMMENT 'Count of primary production equipment units at the plant.',
    `operational_end_date` DATE COMMENT 'Calendar date when the plant was decommissioned or closed; null if still active.',
    `operational_start_date` DATE COMMENT 'Calendar date when the plant first became operational.',
    `permit_expiry_date` DATE COMMENT 'Date on which the environmental permit must be renewed.',
    `plant_code` STRING COMMENT 'Business identifier code assigned to the plant by the organization.',
    `plant_description` STRING COMMENT 'Narrative description providing additional context about the plant.',
    `plant_name` STRING COMMENT 'Descriptive name of the plant used in reports and user interfaces.',
    `plant_status` STRING COMMENT 'Lifecycle status indicating whether the plant is operating, under maintenance, or retired.',
    `plant_type` STRING COMMENT 'Classification of the plant based on its primary function.',
    `postal_code` STRING COMMENT 'Postal code for the plants address.',
    `primary_energy_source` STRING COMMENT 'Main energy source powering the plants processes.',
    `safety_rating` STRING COMMENT 'Internal safety classification based on OSHA/ISO 45001 audits.',
    `shift_duration_hours` STRING COMMENT 'Standard duration of a production shift.',
    `state_province` STRING COMMENT 'State or province where the plant resides.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier for the plants local time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the plant record.',
    `waste_treatment_capacity_tons_per_day` DECIMAL(18,2) COMMENT 'Maximum amount of waste the plant can treat daily.',
    CONSTRAINT pk_production_plant PRIMARY KEY(`production_plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`resource` (
    `resource_id` BIGINT COMMENT 'Primary key for resource',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production resources (equipment, tools, instruments) in chemical manufacturing are assigned to cost centers for maintenance cost collection and depreciation allocation. Resource cost center assignment',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Production resources are physical capital assets requiring depreciation tracking, insurance valuation, and capex management. Linking resource to fixed_asset enables asset lifecycle cost reporting and ',
    `parent_resource_id` BIGINT COMMENT 'Self-referencing FK on resource (parent_resource_id)',
    `asset_category` STRING COMMENT 'Business classification of the asset based on criticality.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the capacity value.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Primary quantitative capacity of the resource (e.g., volume, weight).',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the resource.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Capital cost incurred to acquire the resource.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the resource record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.',
    `decommission_date` DATE COMMENT 'Date the resource was retired or removed from service (if applicable).',
    `installation_date` DATE COMMENT 'Date the resource was installed or commissioned.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance was performed.',
    `location_code` STRING COMMENT 'Code identifying the physical location or site of the resource.',
    `maintenance_interval_days` STRING COMMENT 'Planned number of days between routine maintenance activities.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the resource.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the upcoming maintenance.',
    `operating_pressure_bar` DECIMAL(18,2) COMMENT 'Typical operating pressure in bar units.',
    `operating_temperature_c` DECIMAL(18,2) COMMENT 'Typical operating temperature range in degrees Celsius.',
    `resource_code` STRING COMMENT 'Business identifier or catalogue number for the resource.',
    `resource_description` STRING COMMENT 'Detailed textual description of the resource.',
    `resource_name` STRING COMMENT 'Human‑readable name of the resource.',
    `resource_status` STRING COMMENT 'Current lifecycle state of the resource.',
    `resource_type` STRING COMMENT 'Category that classifies the kind of resource.',
    `safety_rating` STRING COMMENT 'Safety classification based on internal risk assessment.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the resource.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the resource record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty expires.',
    `created_by` STRING COMMENT 'User or system that created the resource record.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Master reference table for resource. Referenced by resource_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`routing` (
    `routing_id` BIGINT COMMENT 'Primary key for routing',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Routings define production operations with associated activity types and cost rates in chemical manufacturing. Linking routing to cost_element enables standard cost calculation by operation — labor an',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Routings in chemical manufacturing define the sequence of operations and are directly associated with inspection plans specifying quality checks at each operation. This is a core SAP PP-QM integration',
    `superseded_routing_id` BIGINT COMMENT 'Self-referencing FK on routing (superseded_routing_id)',
    `task_list_id` BIGINT COMMENT 'Foreign key linking to maintenance.task_list. Business justification: In chemical manufacturing SAP PP-PM integration, production routings reference maintenance task lists for equipment setup, inspection steps, or cleaning operations embedded in the production process. ',
    `work_center_id` BIGINT COMMENT 'Identifier of the primary work center associated with the routing.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the routing.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the routing was approved.',
    `change_reason` STRING COMMENT 'Reason for the most recent revision of the routing.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the routing.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing record was created.',
    `department` STRING COMMENT 'Business department responsible for the routing.',
    `effective_end_date` DATE COMMENT 'Date when the routing is retired or superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the routing becomes effective.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Typical energy usage for the routing per batch.',
    `estimated_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard expected cycle time for the routing.',
    `estimated_yield_percent` DECIMAL(18,2) COMMENT 'Typical yield expected when following this routing.',
    `is_default` BOOLEAN COMMENT 'Indicates if this routing is the default for its product family.',
    `material_consumption_rate` DECIMAL(18,2) COMMENT 'Average material consumption per unit output.',
    `notes` STRING COMMENT 'Additional free-text notes about the routing.',
    `plant_location` STRING COMMENT 'Three-letter code of the plant where routing is used.',
    `priority` STRING COMMENT 'Priority order when multiple routings apply (lower number = higher priority).',
    `revision_number` STRING COMMENT 'Revision count for changes to the routing.',
    `routing_code` STRING COMMENT 'Unique business code for the routing.',
    `routing_description` STRING COMMENT 'Detailed description of the routing purpose and scope.',
    `routing_name` STRING COMMENT 'Human readable name of the routing.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing.',
    `routing_type` STRING COMMENT 'Category of routing based on process nature.',
    `safety_rating` STRING COMMENT 'Safety risk rating for the routing.',
    `updated_by` STRING COMMENT 'User identifier who last updated the routing record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing record.',
    `version_number` STRING COMMENT 'Version of the routing definition.',
    `created_by` STRING COMMENT 'User identifier who created the routing record.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Master reference table for routing. Referenced by routing_id.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` (
    `bill_of_materials_id` BIGINT COMMENT 'Primary key for bill_of_materials',
    `parent_bom_bill_of_materials_id` BIGINT COMMENT 'Identifier of the parent BOM in a hierarchical BOM structure (e.g., for sub‑assemblies).',
    `primary_superseded_bill_of_materials_id` BIGINT COMMENT 'Self-referencing FK on bill_of_materials (superseded_bill_of_materials_id)',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: BOMs in chemical manufacturing reference quality specifications to define the quality requirements the finished product must meet. The BOM version is tied to a specific quality specification version f',
    `standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.standard_cost. Business justification: BOMs are the primary input for standard cost calculation in chemical manufacturing. Linking BOM to its standard_cost record enables cost roll-up traceability, BOM change impact analysis on product cos',
    `approval_status` STRING COMMENT 'Current approval state of the BOM within engineering change control.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM received final approval.',
    `bill_of_materials_description` STRING COMMENT 'Detailed textual description of the BOM purpose, scope, and any special handling notes.',
    `bill_of_materials_name` STRING COMMENT 'Human‑readable name describing the BOM, typically the product or assembly name.',
    `bill_of_materials_status` STRING COMMENT 'Current lifecycle status of the BOM (e.g., active for production, draft for engineering).',
    `bom_code` STRING COMMENT 'Business identifier code used to reference the BOM in production and planning processes.',
    `bom_type` STRING COMMENT 'Classification of the BOM indicating whether it represents a finished assembly, a kit, raw material collection, or a sub‑assembly.',
    `change_reason` STRING COMMENT 'Free‑text explanation for the most recent change to the BOM.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) applicable to the BOM (e.g., EPA, OSHA, REACH, GHS).',
    `component_count` STRING COMMENT 'Number of distinct component lines defined for this BOM.',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the standard_cost field.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the BOM record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the BOM becomes valid for use in production planning.',
    `effective_until` DATE COMMENT 'Date on which the BOM is retired or superseded; null if open‑ended.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the BOM contains any regulated hazardous substances.',
    `is_default` BOOLEAN COMMENT 'True if this BOM is the default version used for the associated product.',
    `lead_time_days` STRING COMMENT 'Planned number of calendar days required to procure and assemble the BOM.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments about the BOM.',
    `quality_check_required` BOOLEAN COMMENT 'True if a quality inspection is mandatory for the finished product derived from this BOM.',
    `revision_date` DATE COMMENT 'Date of the most recent revision to the BOM.',
    `routing_required` BOOLEAN COMMENT 'Indicates whether a manufacturing routing must be executed for this BOM.',
    `safety_data_sheet_version` STRING COMMENT 'Version identifier of the latest Safety Data Sheet (SDS) associated with hazardous components.',
    `scrap_rate_percent` DECIMAL(18,2) COMMENT 'Expected percentage of material loss during production of the BOM.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost of the BOM based on component costs and engineering estimates.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ADD CONSTRAINT `fk_production_manufacturing_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `chemical_mfg_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ADD CONSTRAINT `fk_production_batch_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ADD CONSTRAINT `fk_production_process_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ADD CONSTRAINT `fk_production_batch_genealogy_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ADD CONSTRAINT `fk_production_process_parameter_reaction_step_id` FOREIGN KEY (`reaction_step_id`) REFERENCES `chemical_mfg_ecm`.`production`.`reaction_step`(`reaction_step_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ADD CONSTRAINT `fk_production_reaction_step_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ADD CONSTRAINT `fk_production_bom_consumption_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `chemical_mfg_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ADD CONSTRAINT `fk_production_yield_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `chemical_mfg_ecm`.`production`.`resource`(`resource_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `chemical_mfg_ecm`.`production`.`batch_record`(`batch_record_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_reaction_step_id` FOREIGN KEY (`reaction_step_id`) REFERENCES `chemical_mfg_ecm`.`production`.`reaction_step`(`reaction_step_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ADD CONSTRAINT `fk_production_production_deviation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_process_order_id` FOREIGN KEY (`process_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_order`(`process_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ADD CONSTRAINT `fk_production_process_change_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_bill_of_materials_id` FOREIGN KEY (`bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ADD CONSTRAINT `fk_production_campaign_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `chemical_mfg_ecm`.`production`.`campaign`(`campaign_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_manufacturing_order_id` FOREIGN KEY (`manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`production`.`manufacturing_order`(`manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `chemical_mfg_ecm`.`production`.`schedule`(`schedule_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ADD CONSTRAINT `fk_production_cip_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_parent_process_unit_id` FOREIGN KEY (`parent_process_unit_id`) REFERENCES `chemical_mfg_ecm`.`production`.`process_unit`(`process_unit_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ADD CONSTRAINT `fk_production_process_unit_production_plant_id` FOREIGN KEY (`production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ADD CONSTRAINT `fk_production_production_plant_parent_plant_production_plant_id` FOREIGN KEY (`parent_plant_production_plant_id`) REFERENCES `chemical_mfg_ecm`.`production`.`production_plant`(`production_plant_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ADD CONSTRAINT `fk_production_resource_parent_resource_id` FOREIGN KEY (`parent_resource_id`) REFERENCES `chemical_mfg_ecm`.`production`.`resource`(`resource_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_superseded_routing_id` FOREIGN KEY (`superseded_routing_id`) REFERENCES `chemical_mfg_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `chemical_mfg_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_parent_bom_bill_of_materials_id` FOREIGN KEY (`parent_bom_bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ADD CONSTRAINT `fk_production_bill_of_materials_primary_superseded_bill_of_materials_id` FOREIGN KEY (`primary_superseded_bill_of_materials_id`) REFERENCES `chemical_mfg_ecm`.`production`.`bill_of_materials`(`bill_of_materials_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Production Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Product Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|semi-continuous|campaign|rework|trial');
ALTER TABLE `chemical_mfg_ecm`.`production`.`manufacturing_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `storage_bin_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Storage Bin Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consumed Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `batch_size_category` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Category');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `batch_size_category` SET TAGS ('dbx_value_regex' = 'lab|pilot|commercial|full_scale');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `dcs_system_reference` SET TAGS ('dbx_business_glossary_term' = 'DCS (Distributed Control System) System ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_order` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `batch_genealogy_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Genealogy Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Child Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `quality_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `bom_item_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Item Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `child_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Child Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `consumption_percentage` SET TAGS ('dbx_business_glossary_term' = 'Consumption Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `customer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Number');
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `dcs_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distributed Control System (DCS) Batch Identifier (ID)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`batch_genealogy` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `process_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Process Parameter ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `reaction_step_id` SET TAGS ('dbx_business_glossary_term' = 'Reaction Step Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_parameter` ALTER COLUMN `spc_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `reaction_step_id` SET TAGS ('dbx_business_glossary_term' = 'Reaction Step Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Consumed Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `inspection_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `process_safety_info_id` SET TAGS ('dbx_business_glossary_term' = 'Process Safety Info Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`reaction_step` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `bom_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Consumption ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `supplier_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bom_consumption` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `yield_record_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Record Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `breakdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Breakdown Event Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`yield_record` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `production_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`schedule` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`work_center` ALTER COLUMN `sampling_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Plan Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `production_deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Production Deviation Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `lot_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Record Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `reaction_step_id` SET TAGS ('dbx_business_glossary_term' = 'Reaction Step Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `regulatory_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Profile Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_deviation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_change_record_id` SET TAGS ('dbx_business_glossary_term' = 'Process Change Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `cas_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Cas Registry Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `product_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Product Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_change_record` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `grade_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `pm_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`campaign` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` SET TAGS ('dbx_subdomain' = 'quality_compliance');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `cip_record_id` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Record ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `campaign_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Agent Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `equipment_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `chemical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Next Chemical Product Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `chemical_mfg_ecm`.`production`.`cip_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `hazop_study_id` SET TAGS ('dbx_business_glossary_term' = 'Hazop Study Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `tank_id` SET TAGS ('dbx_business_glossary_term' = 'Output Tank Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `parent_process_unit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`process_unit` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `parent_plant_production_plant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`production_plant` ALTER COLUMN `waste_treatment_capacity_tons_per_day` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `parent_resource_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`resource` ALTER COLUMN `cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `superseded_routing_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`routing` ALTER COLUMN `task_list_id` SET TAGS ('dbx_business_glossary_term' = 'Task List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` SET TAGS ('dbx_subdomain' = 'planning_configuration');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Identifier');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `primary_superseded_bill_of_materials_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`production`.`bill_of_materials` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Id (Foreign Key)');
