-- Schema for Domain: manufacturing | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`manufacturing` COMMENT 'Manages production execution data including batch records, production orders, work centers, MES data (Aveva/Wonderware), OEE metrics, line performance, changeovers, GMP compliance events, HACCP critical control point logs, co-packing and toll manufacturing arrangements, production scheduling, and FIFO/FEFO inventory consumption with lot traceability.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Unique identifier for the production order. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for Order‑to‑Production traceability; production orders originate from customer sales orders, so linking to account enables order fulfillment reporting.',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to product.bill_of_materials. Business justification: Production orders are executed against a specific BOM version for material staging, goods issue, and variance analysis. In F&B ERP, production orders explicitly reference the BOM used. bom_version on ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand performance report requires linking each production order to its brand for tracking volume and cost per brand.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Co‑packer supplier must be recorded for FDA/HACCP traceability and allergen control.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for Manufacturing Cost Allocation Report to allocate production costs to the correct cost center; cost_center string is denormalized and replaced.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Production orders are created from demand plans; linking enables S&OP reconciliation and demand‑supply variance analysis.',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: FSMA compliance requires each production order to be executed under a documented, approved food safety plan. Linking production_order to food_safety_plan enables regulatory audit traceability — confir',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: Production orders are assigned a specific formulation version at order creation (planned formulation), distinct from batch_record which captures actual formulation used. This supports formulation devi',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: S&OP/IBP supply plans authorize and drive production orders in MRP/IBP execution. Linking production_order to supply.plan enables plan-vs-actual production reporting, supply plan adherence KPIs, and t',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Linking production_order to plant centralizes plant metadata and removes the redundant plant_code string.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Production order release requires verified product registration to ensure compliance with FDA/USDA regulations.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Supports Profitability Analysis per production order, linking manufacturing output to finance profit_center for reporting.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Production Planning uses Promotion Events to drive order quantities; linking enables the Production Planning Report to allocate capacity to specific promotions.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Production runs are executed under specific supplier contracts; linking enables contract compliance reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: OTIF and cost tracking require linking each production order to the originating purchase order.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: HACCP plan execution is tracked per production order for compliance reporting and audit traceability.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: A production order is executed according to a specific routing that defines the sequence of manufacturing operations. The production_order currently has routing_version (STRING) as a denormalized refe',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order fulfillment process requires linking each production order to the originating sales order for traceability and scheduling.',
    `sku_id` BIGINT COMMENT 'Reference to the finished goods SKU or semi-finished intermediate being produced in this order.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: A production order is executed on a specific work center; linking to work_center provides hierarchy and eliminates the free‑text production_line column.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution was completed and final confirmation posted. Captured from MES or CO11N transaction.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when production execution began on the shop floor. Captured from MES or manual confirmation.',
    `batch_size` DECIMAL(18,2) COMMENT 'Standard or planned batch size for this production run. Represents the nominal production lot size for the SKU on the assigned line.',
    `bom_version` STRING COMMENT 'Version identifier of the BOM used for this production order. Ensures traceability of ingredient and component specifications used in production.. Valid values are `^[A-Z0-9]{1,8}$`',
    `confirmation_number` STRING COMMENT 'SAP PP confirmation document number generated by CO11N transaction. Links to detailed confirmation records including time, quantity, and goods movements.. Valid values are `^[0-9]{10}$`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the production confirmation was posted in SAP PP via CO11N transaction.',
    `confirmation_type` STRING COMMENT 'Type of production confirmation: partial (interim confirmation during production run) or final (completion confirmation closing the order).. Valid values are `partial|final`',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity confirmed as produced via CO11N confirmation transaction. Represents good output quantity posted to inventory.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the production order record was first created in SAP S/4HANA PP system. Represents the beginning of the order lifecycle.',
    `fefo_lot_consumption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether raw material lot consumption for this order followed FEFO inventory management rules (consuming lots with nearest expiration first). True if FEFO was enforced, False otherwise. Critical for perishable food and beverage ingredients.',
    `fifo_lot_consumption_flag` BOOLEAN COMMENT 'Boolean flag indicating whether raw material lot consumption for this order followed FIFO inventory management rules. True if FIFO was enforced, False otherwise.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this production order was executed in full compliance with GMP requirements. True if all GMP critical control points were met and documented, False if any deviations occurred.',
    `goods_movement_document` STRING COMMENT 'SAP MM material document number for the goods receipt posting (MIGO 101 movement type) that moved confirmed quantity into finished goods inventory.. Valid values are `^[0-9]{10}$`',
    `haccp_ccp_log_reference` STRING COMMENT 'Reference identifier to the HACCP CCP monitoring log for this production order. Links to detailed records of critical control point measurements (temperature, pH, time, etc.) taken during production.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the production order record was last updated in the source system. Tracks the most recent change to order header data, status, or confirmations.',
    `mes_work_order_reference` STRING COMMENT 'Work order identifier from Aveva/Wonderware MES system. Provides linkage between SAP PP production order and detailed MES execution records including real-time process data, equipment performance, and operator actions.. Valid values are `^[A-Z0-9-]{10,20}$`',
    `order_number` STRING COMMENT 'SAP PP production order number - the externally-known business identifier for this manufacturing execution record. Typically 10-12 alphanumeric characters.. Valid values are `^[A-Z0-9]{10,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the production order: created (order created but not released to shop floor), released (released for execution), in_progress (active production), confirmed (production completed and confirmed via CO11N), technically_complete (all confirmations and goods movements posted), closed (order financially settled and closed), cancelled (order cancelled before completion). [ENUM-REF-CANDIDATE: created|released|in_progress|confirmed|technically_complete|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the production order: standard (regular production run), rework (reprocessing of non-conforming product), trial (R&D or NPD pilot batch), co-pack (third-party manufacturing arrangement), toll (toll manufacturing arrangement where customer provides materials).. Valid values are `standard|rework|trial|co-pack|toll`',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity to be produced as specified in the production order header. Measured in base unit of measure for the SKU.',
    `rework_disposition` STRING COMMENT 'Final disposition of reworked material: reprocessed (successfully reworked to original spec), downgraded (reworked to lower-grade product), scrapped (could not be salvaged), returned_to_vendor (raw material defect). Applicable only when order_type is rework.. Valid values are `reprocessed|downgraded|scrapped|returned_to_vendor`',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of product requiring rework or reprocessing. This quantity is typically moved to a rework order for corrective processing.',
    `rework_reason_code` STRING COMMENT 'Code identifying the reason for rework when order_type is rework. Examples: quality defect, packaging error, labeling error, contamination, off-spec product. Null for non-rework orders.. Valid values are `^[A-Z0-9]{2,6}$`',
    `routing_version` STRING COMMENT 'Version identifier of the production routing or recipe used for this order. Defines the sequence of operations and process parameters.. Valid values are `^[A-Z0-9]{1,8}$`',
    `scheduled_end_date` DATE COMMENT 'Planned completion date for production order execution as determined by production scheduling or SAP IBP.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for production order execution as determined by production scheduling or SAP IBP.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of product scrapped or discarded during production due to quality defects, process failures, or other non-conformances. Measured in base unit of measure.',
    `shift` STRING COMMENT 'Shift during which the production order was executed: day, evening, night, or weekend shift.. Valid values are `day|evening|night|weekend`',
    `toll_manufacturer_name` STRING COMMENT 'Name of the toll manufacturing partner when order_type is toll. In toll arrangements, the customer provides raw materials and the toll manufacturer provides processing services. Null for non-toll orders.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all quantities on this order (e.g., KG for kilograms, EA for each, LB for pounds, CS for cases). ISO standard unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Actual yield percentage calculated as (confirmed_quantity / planned_quantity) * 100. Measures production efficiency and material utilization.',
    `yield_variance_percentage` DECIMAL(18,2) COMMENT 'Variance between planned and actual yield, calculated as (actual_yield - planned_yield) / planned_yield * 100. Positive values indicate over-yield, negative values indicate under-yield.',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Core manufacturing execution record representing a discrete production run, work order, or rework order issued against a finished goods SKU or semi-finished intermediate — serving as the complete lifecycle record from creation through confirmation and closure. Captures order type (standard, rework, trial), planned vs. actual quantities, scheduled start/end times, actual start/end times, production line assignment, shift, batch size, yield, scrap, rework quantities, order status (created, released, in-progress, confirmed, technically complete, closed), SAP PP production order number, MES work order reference, BOM version used, routing version, cost center, plant code, FIFO/FEFO lot consumption flags, rework reason code and originating order reference (if rework type), rework yield and disposition (if rework), confirmation number, confirmed quantity, yield variance percentage, scrap quantity confirmed, rework quantity confirmed, confirmation type (partial, final), goods movement document number, confirming operator ID, and confirmation datetime. Primary transactional anchor for manufacturing execution in SAP S/4HANA PP module. Rework orders are modeled as production orders with type=rework per SAP PP standard. Confirmations (CO11N) are lifecycle events on this entity — each production order carries its own confirmation records including partial and final confirmations, goods movements, and yield variance calculations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` (
    `batch_record_id` BIGINT COMMENT 'Unique identifier for the electronic batch record. Primary key for the batch record entity. Serves as the system-generated surrogate key for tracking manufacturing batch execution history.',
    `allergen_id` BIGINT COMMENT 'Foreign key linking to ingredient.allergen. Business justification: Allergen management process: batch_record.allergen_statement (plain text) should reference authoritative ingredient.allergen declaration records. Enables accurate allergen labeling compliance, recall ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand-level batch traceability is required for product recall management, brand quality audits, and regulatory reporting. F&B operations track which brand a batch belongs to independently of the produ',
    `supplier_id` BIGINT COMMENT 'Reference to the co-packer supplier who manufactured this batch. Populated only when co_packer_flag is True. Links to supplier master data for contract terms and quality agreements.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Private label and co-manufacturing traceability: F&B batch records must be traceable to the sales contract specifying quality standards, certifications, and labeling requirements. Required for custome',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Batch costing is a core F&B process: actual batch costs (labor, overhead, materials) are posted to cost centers for COGS reporting and manufacturing variance analysis. Every batch record must referenc',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: FSMA compliance requires each batch record to be traceable to the food safety plan version in effect at time of production. Auditors verify that CCPs and critical limits applied during the batch match',
    `formulation_id` BIGINT COMMENT 'Reference to the approved formulation (recipe) used for this batch. Links to the bill of materials and ingredient specifications.',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_receipt. Business justification: FSMA and GFSI food safety traceability requires linking the batch produced to the specific goods receipt of raw materials consumed. batch_record → inbound_receipt enables one-step upstream traceabilit',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Batch traceability to the inbound shipment is required for recall, quality investigation, and regulatory reporting.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Inspection results are recorded per batch; linking enables release decisions and traceability of quality inspections.',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: Batch records must document which packaging specification version was active during production for product recall traceability, regulatory holds, and packaging compliance audits. packaging_configurati',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: A batch record documents the complete manufacturing history of a production batch at a specific plant. The plant_id FK directly on batch_record enables plant-level batch traceability, GMP compliance r',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that authorized this batch manufacturing run. Links the batch record to the planning and scheduling system.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: In F&B, batch records are assigned to profit centers to support brand/segment P&L reporting. Finance teams require batch-level profit center assignment to allocate production costs to the correct busi',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Batch traceability to the source PO is required for recalls and cost allocation.',
    `sku_id` BIGINT COMMENT 'Reference to the finished goods SKU being manufactured in this batch. Identifies the specific product variant produced.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Batch release requires confirming the batch was produced to the correct specification version. Linking batch_record to quality.specification enables was this batch produced to spec? — mandatory for ',
    `storage_location_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this batch was produced. Critical for multi-site traceability and regulatory compliance.',
    `work_center_id` BIGINT COMMENT 'Reference to the production line or work center where this batch was manufactured. Identifies the physical manufacturing resource.',
    `actual_yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of finished goods produced and approved from this batch. May differ from batch size due to process losses, quality rejections, or overproduction.',
    `allergen_statement` STRING COMMENT 'The allergen declaration for this batch as it appears on the product label. Lists all major allergens present (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans, sesame) and may-contain statements for cross-contact allergens. Critical for consumer safety and regulatory compliance.',
    `batch_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to this batch. May include process notes, quality observations, equipment issues, or other relevant information not captured in structured fields.',
    `batch_number` STRING COMMENT 'The unique alphanumeric identifier assigned to a specific production batch. Also known as lot number. This is the externally-known business identifier used for traceability, recall management, and regulatory compliance. Must be unique across all production facilities and time periods.. Valid values are `^[A-Z0-9]{8,20}$`',
    `batch_size_quantity` DECIMAL(18,2) COMMENT 'The planned or target quantity of finished goods to be produced in this batch. Represents the theoretical yield based on the formulation and production order.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the batch record. Tracks the batch through manufacturing execution, quality approval, and release stages. In-process indicates active manufacturing; pending QA indicates awaiting quality approval; released indicates approved for distribution; rejected indicates failed quality checks; quarantine indicates isolated pending investigation; on hold indicates regulatory or quality hold.. Valid values are `in_process|pending_qa|released|rejected|quarantine|on_hold`',
    `best_before_date` DATE COMMENT 'The date until which the product is expected to retain optimal quality characteristics. May differ from expiry date. Used for quality assurance and consumer guidance. Common in food and beverage products where safety extends beyond optimal quality period.',
    `co_packer_flag` BOOLEAN COMMENT 'Indicates whether this batch was manufactured by a third-party co-packer (contract manufacturer) rather than in-house. True indicates co-packer production; False indicates internal manufacturing. Critical for supply chain visibility and quality accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was first created in the system. Audit trail field for data governance and compliance.',
    `deviation_count` STRING COMMENT 'The total number of manufacturing deviations, exceptions, or non-conformances recorded during batch execution. Includes process parameter excursions, equipment failures, and procedural deviations. Zero indicates perfect execution. Used for quality trending and CAPA analysis.',
    `expiry_date` DATE COMMENT 'The date after which the product should not be consumed or used. Calculated based on manufacturing date plus shelf life days. Critical for FEFO inventory management and regulatory compliance.',
    `gluten_free_claim_flag` BOOLEAN COMMENT 'Indicates whether this batch carries a gluten-free claim on the label. True indicates gluten-free claim present; False indicates no claim. Must meet FDA gluten-free standard of less than 20 ppm gluten. Requires testing and validation.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether this batch was manufactured in full compliance with Good Manufacturing Practice requirements. True indicates all GMP controls were met; False indicates GMP deviations occurred. Critical for regulatory audit trail.',
    `haccp_signoff_status` STRING COMMENT 'Status of HACCP critical control point verification and approval for this batch. Indicates whether all critical control points were monitored and within acceptable limits. Pending indicates awaiting review; approved indicates all CCPs passed; rejected indicates CCP failure; not applicable for products not requiring HACCP.. Valid values are `pending|approved|rejected|not_applicable`',
    `halal_certification_flag` BOOLEAN COMMENT 'Indicates whether this batch is certified halal per Islamic dietary law. True indicates halal certified; False indicates not certified. Requires halal certificate and compliance documentation.',
    `kosher_certification_flag` BOOLEAN COMMENT 'Indicates whether this batch is certified kosher by a recognized kosher certification agency. True indicates kosher certified; False indicates not certified. Requires kosher certificate and supervision records.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this batch record was last updated. Audit trail field for tracking changes and data lineage.',
    `manufacturing_date` DATE COMMENT 'The calendar date of batch production. This is the date printed on product labels and used for regulatory compliance. Typically the date manufacturing started or the date the batch was completed, per company policy.',
    `manufacturing_end_timestamp` TIMESTAMP COMMENT 'The date and time when batch manufacturing execution was completed. Marks the completion of all processing steps and final packaging. Used for cycle time analysis and OEE calculation.',
    `manufacturing_start_timestamp` TIMESTAMP COMMENT 'The date and time when batch manufacturing execution began. Marks the start of raw material dispensing and processing. Critical for shelf life calculation and FIFO/FEFO inventory management.',
    `non_gmo_verified_flag` BOOLEAN COMMENT 'Indicates whether this batch is verified as non-genetically modified organism (non-GMO) by a third-party certification program. True indicates non-GMO verified; False indicates not verified or contains GMO ingredients.',
    `organic_certification_flag` BOOLEAN COMMENT 'Indicates whether this batch is certified organic per USDA NOP or equivalent organic standards. True indicates certified organic; False indicates conventional. Requires organic certificate and audit trail.',
    `packaging_configuration` STRING COMMENT 'Description of the primary and secondary packaging used for this batch. Includes package type, size, and material. Examples: 12oz PET bottle 24-pack, 500g stand-up pouch, 1L Tetra Pak carton. Links to packaging specification.',
    `parent_batch_number` STRING COMMENT 'The batch number of the original batch from which reworked material was sourced. Populated only when rework_flag is True. Maintains traceability chain for reworked batches.. Valid values are `^[A-Z0-9]{8,20}$`',
    `qa_approval_timestamp` TIMESTAMP COMMENT 'The date and time when the quality assurance reviewer approved this batch for release to distribution. Marks the transition from pending QA to released status.',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether this batch is under regulatory hold pending investigation or approval from regulatory authorities (FDA, USDA, etc.). True indicates hold in place; False indicates no regulatory restriction. Prevents distribution until cleared.',
    `regulatory_hold_reason` STRING COMMENT 'Free-text description of the reason for regulatory hold. Populated only when regulatory_hold_flag is True. Documents the specific regulatory concern, investigation, or pending approval.',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether this batch includes reworked material from a previous batch. True indicates rework present; False indicates all new material. Rework must be documented per GMP requirements.',
    `shelf_life_days` STRING COMMENT 'The number of days from manufacturing date to expiry date. Defines the product stability period. Used to calculate expiry and best before dates. Derived from product specification and stability studies.',
    `sterilization_method` STRING COMMENT 'The thermal or non-thermal sterilization process applied to this batch. Pasteurization indicates low-temperature short-time treatment; UHT indicates ultra-high temperature; retort indicates in-container sterilization; aseptic indicates sterile processing and packaging; none indicates no sterilization (e.g., dry goods); other for alternative methods. Critical for food safety and shelf life.. Valid values are `pasteurization|uht|retort|aseptic|none|other`',
    `toll_manufacturing_flag` BOOLEAN COMMENT 'Indicates whether this batch was produced under a toll manufacturing arrangement where the company provides raw materials and the toll manufacturer provides processing services. True indicates toll manufacturing; False indicates standard production. Distinct from co-packing where the manufacturer may source materials.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for batch size and yield quantities. Common values include KG (kilograms), LB (pounds), L (liters), GAL (gallons), EA (each), CS (cases). Must align with SKU base unit of measure.. Valid values are `^[A-Z]{2,6}$`',
    CONSTRAINT pk_batch_record PRIMARY KEY(`batch_record_id`)
) COMMENT 'Electronic batch record (EBR) capturing the complete manufacturing history of a single production batch from raw material dispensing through finished goods release. Includes batch number (lot number), batch size, unit of measure, manufacturing date, expiry date, best-before date, shelf life days, batch status (in-process, pending QA, released, rejected, quarantine), GMP compliance flag, HACCP sign-off status, deviation count, operator IDs, line supervisor sign-off, co-packer flag, toll manufacturing flag, and regulatory hold indicator. Serves as the legal manufacturing record per FDA 21 CFR Part 211 and GMP requirements. Sourced from Aveva/Wonderware MES Batch Management module.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the financial cost center to which production costs and overhead for this work center are allocated.',
    `network_node_id` BIGINT COMMENT 'SCADA system node identifier for real-time monitoring and control of this work centers automation equipment.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant where this work center is located.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Work center is part of a production line; adding production_line_id links work_center to its line and provides needed connectivity.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Each work center has an associated WIP staging storage location for materials in process (standard in SAP as production storage location per work center). Inventory managers and production planners us',
    `active_from_date` DATE COMMENT 'Date when this work center became operational and available for production scheduling.',
    `active_to_date` DATE COMMENT 'Date when this work center was decommissioned or taken out of service. Null for currently active work centers.',
    `allergen_capable_flag` BOOLEAN COMMENT 'Indicates whether this work center is capable of processing products containing major food allergens (milk, eggs, fish, shellfish, tree nuts, peanuts, wheat, soybeans). Critical for allergen control and production scheduling.',
    `allergen_types` STRING COMMENT 'Comma-separated list of specific allergen types that this work center is approved to handle (e.g., milk, peanuts, tree nuts, soy). Empty if allergen_capable_flag is false. [ENUM-REF-CANDIDATE: milk|eggs|fish|shellfish|tree_nuts|peanuts|wheat|soybeans|sesame|sulfites — promote to reference product]',
    `available_hours_per_day` DECIMAL(18,2) COMMENT 'Total available production hours per day for this work center based on shift pattern and planned maintenance windows.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the rated capacity (e.g., cases per hour, bottles per minute, pounds per hour). [ENUM-REF-CANDIDATE: cases|bottles|cans|pounds|kilograms|liters|gallons|pallets — 8 candidates stripped; promote to reference product]',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes required to switch from one product or SKU to another, including teardown, cleaning, setup, and validation. Key metric for production efficiency and scheduling.',
    `cip_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard duration in minutes for a complete CIP cleaning cycle on this work center. Null if CIP is not required.',
    `cip_required_flag` BOOLEAN COMMENT 'Indicates whether this work center requires automated clean-in-place procedures between production runs. Critical for liquid processing, dairy, and beverage lines.',
    `co_packing_approved_flag` BOOLEAN COMMENT 'Indicates whether this work center is approved for co-packing or toll manufacturing operations for third-party brands.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system.',
    `gmp_classification` STRING COMMENT 'GMP hygiene classification level of the work center determining the sanitation, personnel, and environmental control requirements.. Valid values are `standard|high_care|high_risk|low_risk`',
    `haccp_ccp_flag` BOOLEAN COMMENT 'Indicates whether this work center contains one or more HACCP critical control points requiring continuous monitoring and documentation.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether this work center is certified for halal food production by a recognized halal certification body.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether this work center is certified for kosher food production by a recognized kosher certification agency.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance or major service performed on this work center.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last updated in the system.',
    `line_type` STRING COMMENT 'Classification of the work center by its primary production process type. Determines the type of operations and products that can be manufactured on this line. [ENUM-REF-CANDIDATE: mixing|filling|packaging|pasteurization|fermentation|extrusion|co-packing|blending|bottling|canning — 10 candidates stripped; promote to reference product]',
    `maximum_run_size` DECIMAL(18,2) COMMENT 'Maximum production quantity that can be manufactured on this work center in a single run due to equipment, storage, or process constraints.',
    `mes_asset_tag` STRING COMMENT 'Unique asset identifier used by the MES system (Aveva/Wonderware) to track real-time production data, OEE metrics, and equipment performance for this work center.',
    `minimum_run_size` DECIMAL(18,2) COMMENT 'Minimum production quantity that can be economically manufactured on this work center in a single run. Used to enforce MOQ constraints in production scheduling.',
    `next_scheduled_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance shutdown for this work center. Used for production scheduling and capacity planning.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target OEE percentage for this work center representing the product of availability, performance, and quality rates. Industry benchmark for world-class manufacturing is 85%.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this work center is certified for organic food production under USDA NOP or equivalent organic standards.',
    `production_area` STRING COMMENT 'Physical production area or zone within the plant where the work center is located (e.g., Mixing Room, Filling Hall, Packaging Wing, Cold Storage).',
    `rated_capacity_units_per_hour` DECIMAL(18,2) COMMENT 'Maximum theoretical production capacity of the work center expressed in units per hour under optimal operating conditions. Used for production planning and scheduling.',
    `run_size_unit_of_measure` STRING COMMENT 'Unit of measure for minimum and maximum run sizes. [ENUM-REF-CANDIDATE: cases|bottles|cans|pounds|kilograms|liters|gallons|batches — 8 candidates stripped; promote to reference product]',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to prepare the work center for a production run, including equipment configuration, material staging, and pre-operational checks.',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for this work center determining its available production hours per day.. Valid values are `single|two_shift|three_shift|continuous|custom`',
    `standard_cycle_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to produce one unit or batch on this work center under normal operating conditions. Used for production scheduling and costing.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Standard time in minutes required to clean, sanitize, and restore the work center after a production run. Critical for GMP compliance and allergen control.',
    `work_center_category` STRING COMMENT 'High-level categorization of the work center by its functional role in the manufacturing process.. Valid values are `production|quality_control|maintenance|warehouse|co-packing`',
    `work_center_code` STRING COMMENT 'Business identifier code for the work center used in production planning and scheduling systems. Typically alphanumeric code assigned by manufacturing operations.. Valid values are `^[A-Z0-9]{4,12}$`',
    `work_center_description` STRING COMMENT 'Detailed description of the work center including its purpose, capabilities, and operational characteristics.',
    `work_center_name` STRING COMMENT 'Descriptive name of the work center for human identification and reporting purposes.',
    `work_center_status` STRING COMMENT 'Current operational status of the work center indicating its availability for production scheduling and execution.. Valid values are `active|maintenance|idle|decommissioned|startup|shutdown`',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Master data for all production work centers, lines, and cells within manufacturing plants. Captures work center code, description, plant, production area, line type (mixing, filling, packaging, pasteurization, fermentation, extrusion, co-packing), rated capacity (units/hour), standard cycle time, setup time, teardown time, OEE target, minimum run size, maximum run size, allergen capability flags, kosher/halal certification flag, clean-in-place (CIP) required flag, work center status (active, maintenance, decommissioned), and MES asset tag. SSOT for production line master data used in scheduling and OEE reporting. Sourced from SAP PP work center master and Aveva/Wonderware MES.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Production Planning report; schedules are built around specific customer orders, linking to account provides accurate capacity planning per customer.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand managers participate in S&OP reviews requiring brand-level production schedule visibility. F&B companies plan production capacity by brand for launch windows, seasonal campaigns, and brand portf',
    `campaign_id` BIGINT COMMENT 'Identifier for a production campaign (a series of related production runs for similar products to minimize changeovers). Used in campaign-based manufacturing strategies.',
    `capacity_constraint_id` BIGINT COMMENT 'Foreign key linking to supply.capacity_constraint. Business justification: Production scheduling in F&B must respect active capacity constraints (line availability, allergen changeovers, regulatory holds). Linking production_schedule to capacity_constraint enables constraint',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.center. Business justification: Production scheduling in F&B must designate the destination DC for each production run to support DC inventory replenishment planning, Available-to-Promise commitments, and inbound receiving schedulin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production scheduling drives capacity cost planning; finance uses schedule data to allocate manufacturing overhead to cost centers. Budget vs. actual capacity cost tracking in S&OP requires production',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: Pre-production food safety validation requires confirming the applicable HACCP plan is approved before scheduling. production_schedule has quality_specification_id but no HACCP plan link. Planners and',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: The supply plan (IBP/S&OP output) is the authorizing source for production schedules. Linking production_schedule to supply.plan enables schedule adherence reporting, plan-vs-schedule variance analysi',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: MRP/production planning process: schedulers confirm specific ingredient lot availability (FEFO sequencing) before releasing a schedule. lot_number_planned is a plain text field; a proper FK enables ma',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: A production schedule is always generated for a specific manufacturing plant. This is a fundamental in-domain relationship — the schedule drives production at a plant. Currently production_schedule ha',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Scheduling must verify product registration status to avoid producing non‑compliant SKUs.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order that this schedule entry is planning for. Links to the production order master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: S&OP financial reconciliation in F&B requires production schedules to be mapped to profit centers so that planned production volumes can be reconciled against financial forecasts and segment budgets d',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Production schedules are aligned with Promotion Events to ensure capacity meets promotional demand; required for the Promotion Capacity Planning report.',
    `promotion_plan_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_plan. Business justification: F&B production scheduling is directly driven by promotion plans: volume targets, timing windows, and SKU commitments in a promotion_plan determine capacity allocation. S&OP and IBP processes require t',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Schedules reference the approved product specification to ensure correct parameters and compliance during execution.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.routing. Business justification: A production schedule references a specific routing to plan the sequence of operations, estimate run times, and allocate work center capacity. The routing defines the standard production time and oper',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: S&OP process: production schedules are directly driven by sales orders in F&B. Schedulers need to see which sales orders each schedule entry fulfills for OTIF tracking and capacity commitment reportin',
    `sku_id` BIGINT COMMENT 'Reference to the SKU (Stock Keeping Unit) that is scheduled to be produced in this schedule entry.',
    `supplier_id` BIGINT COMMENT 'Reference to the co-packing or toll manufacturing partner if this production is outsourced. Null if production is internal.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production line, machine, or manufacturing cell) where this production is scheduled to occur.',
    `allergen_changeover_required` BOOLEAN COMMENT 'Flag indicating whether allergen-related line clearance and deep cleaning is required before this production run due to allergen matrix considerations.',
    `batch_size_target` DECIMAL(18,2) COMMENT 'Target batch size for this production run, expressed in the same UOM as planned quantity. Used for batch manufacturing and Good Manufacturing Practice (GMP) compliance.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Planned utilization percentage of the work centers available capacity for this schedule entry. Used for capacity planning and bottleneck analysis.',
    `changeover_time_minutes` STRING COMMENT 'Allocated time in minutes for changeover activities (cleaning, setup, line clearance) before this production run. Critical for sequencing optimization and minimizing downtime.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this production schedule record was first created in the system. Used for audit trail and data lineage.',
    `crew_size_required` STRING COMMENT 'Number of operators or crew members required to execute this production schedule entry. Used for labor capacity planning.',
    `execution_completion_timestamp` TIMESTAMP COMMENT 'The date and time when the actual production execution for this schedule entry was completed and confirmed by the MES. Used for schedule vs. actual performance analysis.',
    `forecast_demand_quantity` DECIMAL(18,2) COMMENT 'The forecasted demand quantity that this schedule entry is intended to fulfill. Used for demand-driven planning and forecast accuracy tracking.',
    `frozen_zone_flag` BOOLEAN COMMENT 'Flag indicating whether this schedule entry falls within the frozen planning horizon where changes are restricted to maintain schedule stability.',
    `haccp_ccp_applicable` BOOLEAN COMMENT 'Flag indicating whether this production schedule entry involves HACCP Critical Control Points that require monitoring and documentation per food safety regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this production schedule record was last updated. Used for audit trail and change tracking.',
    `last_replanning_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule entry was last revised or replanned. Used for tracking schedule stability and replanning frequency.',
    `lot_number_planned` STRING COMMENT 'Pre-assigned lot number for traceability purposes. Enables First In First Out (FIFO) and First Expired First Out (FEFO) inventory consumption tracking and lot genealogy.',
    `material_availability_status` STRING COMMENT 'Status indicating whether all required raw materials and ingredients are available for this scheduled production. Confirmed indicates full availability; partial indicates some materials available; pending indicates materials not yet checked; shortage indicates insufficient inventory.. Valid values are `confirmed|partial|pending|shortage`',
    `otif_target_date` DATE COMMENT 'The target delivery date for On Time In Full (OTIF) performance measurement. Used to track schedule adherence and customer service level.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of the SKU planned to be produced in this schedule entry, expressed in the base unit of measure for the SKU.',
    `planned_quantity_uom` STRING COMMENT 'Unit of measure for the planned quantity (e.g., cases, kilograms, liters, pallets). Aligns with SKU base UOM.',
    `planning_horizon` STRING COMMENT 'The planning time bucket or horizon this schedule belongs to (e.g., weekly, daily, shift-level). Indicates the granularity of the planning cycle.',
    `priority_code` STRING COMMENT 'Business priority level assigned to this schedule entry. Critical indicates customer-committed or regulatory deadline; high indicates tight inventory; normal indicates standard planning; low indicates buffer or make-to-stock.. Valid values are `critical|high|normal|low`',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether this production run requires in-process or post-production quality inspection per Quality Management (QM) protocols.',
    `released_to_mes_timestamp` TIMESTAMP COMMENT 'The date and time when this schedule entry was released to the Manufacturing Execution System (MES) for execution. Marks the transition from planning to execution.',
    `replanning_reason` STRING COMMENT 'Business reason for the most recent replanning event (e.g., demand change, material shortage, equipment breakdown, customer request). Used for root cause analysis of schedule instability.',
    `safety_stock_target` DECIMAL(18,2) COMMENT 'Target safety stock level that this production schedule entry is intended to maintain or replenish. Used for inventory optimization.',
    `schedule_notes` STRING COMMENT 'Free-text notes or comments from the planner regarding special considerations, constraints, or instructions for this schedule entry.',
    `schedule_source` STRING COMMENT 'Origin system or method that generated this schedule entry. MRP indicates Material Requirements Planning; manual indicates planner override; IBP indicates Integrated Business Planning system; demand_sensing indicates real-time demand signal; optimization indicates algorithmic sequencing.. Valid values are `MRP|manual|IBP|demand_sensing|optimization`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule entry. Draft indicates preliminary planning; firmed indicates committed plan; released indicates sent to MES for execution; executed indicates production completed; cancelled indicates schedule entry voided.. Valid values are `draft|firmed|released|executed|cancelled`',
    `schedule_version` STRING COMMENT 'Version identifier for the production schedule. Allows tracking of schedule revisions and replanning iterations (e.g., V1, V2, V2.1).',
    `scheduled_duration_minutes` STRING COMMENT 'Total planned production duration in minutes, including run time but excluding changeover time. Used for Overall Equipment Effectiveness (OEE) baseline calculations.',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The planned date and time when production for this schedule entry is expected to be completed. Used for capacity planning and On Time In Full (OTIF) tracking.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The planned date and time when production for this schedule entry is expected to begin. Used for capacity planning and sequencing.',
    `sequence_number` STRING COMMENT 'The order position of this schedule entry within the work centers production sequence for the planning period. Used for sequencing optimization and changeover minimization.',
    `setup_instructions` STRING COMMENT 'Special setup or configuration instructions for the work center to execute this schedule entry. May reference standard operating procedures (SOPs) or work instructions.',
    `shift_code` STRING COMMENT 'Identifier for the production shift during which this schedule entry is planned (e.g., Day, Night, Swing). Used for labor planning and shift performance analysis.',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Forward-looking production schedule records generated by the planning system (SAP IBP / JDA Blue Yonder) and executed via MES. Captures schedule version, planning horizon, scheduled production order reference, work center assignment, SKU, planned quantity, scheduled start datetime, scheduled end datetime, schedule status (draft, firmed, released, executed, cancelled), schedule source (MRP, manual, IBP), changeover time allocated, sequence number on line, and last replanning timestamp. Enables sequencing optimization, changeover minimization, and OTIF performance tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` (
    `haccp_ccp_log_id` BIGINT COMMENT 'Unique identifier for the HACCP critical control point monitoring log entry. Primary key for the log record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: A HACCP CCP log entry is recorded during the execution of a specific production batch. Adding batch_record_id as a FK to batch_record normalizes the relationship and replaces the denormalized batch_nu',
    `critical_control_point_id` BIGINT COMMENT 'Foreign key linking to quality.critical_control_point. Business justification: A CCP log entry records a monitoring event at a specific CCP. Linking to quality.critical_control_point identifies which CCP (with its defined limits and hazard type) was monitored — the core HACCP co',
    `equipment_master_id` BIGINT COMMENT 'Identifier of the specific equipment or instrument used to perform the CCP monitoring (e.g., thermometer serial number, metal detector unit ID). Critical for calibration traceability.',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: Each CCP monitoring log entry is governed by a specific food safety plan defining critical limits and monitoring procedures. FSMA and HACCP regulations require CCP records to reference the controlling',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: HACCP CCP log measurements (temperature, pH, pressure) must be validated against formulation-specified critical limits (pasteurization_temperature, target_ph_min/max). Regulatory audits require tracin',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: FSMA/FDA requires CCP monitoring records be traceable to the governing HACCP plan. haccp_ccp_log records measured values at CCPs; the HACCP plan defines the critical limits and monitoring requirements',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: FSMA Section 204 and HACCP regulations require CCP monitoring records to be traceable to the specific ingredient lot processed at each control point. Enables precise recall scope determination and reg',
    `production_order_id` BIGINT COMMENT 'Reference to the production order under which this CCP monitoring occurred. Links the CCP log to the manufacturing execution context.',
    `quarantine_hold_id` BIGINT COMMENT 'Foreign key linking to inventory.quarantine_hold. Business justification: When a HACCP CCP log records a critical limit deviation (regulatory_hold_triggered_flag=true), a quarantine hold is immediately placed on affected inventory. Food safety regulations require direct tra',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: HACCP plans are ingredient-specific; CCP monitoring records must be traceable to the raw material being processed at each control point. FSMA and HACCP regulatory requirements mandate this link for fo',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where the CCP monitoring took place. Enables location-specific analysis of control point performance.',
    `ccp_identifier` STRING COMMENT 'The unique code or identifier for the critical control point as defined in the HACCP plan (e.g., CCP-1, CCP-2-PASTEURIZE).',
    `ccp_name` STRING COMMENT 'The descriptive name of the critical control point being monitored (e.g., Pasteurization Temperature, Metal Detection, pH Check, Brix Measurement, Allergen Verification).',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context related to the CCP monitoring event. May include operator observations, environmental conditions, or other relevant details.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a corrective action is required based on the CCP monitoring result (True = corrective action needed, False = no action needed).',
    `corrective_action_taken` STRING COMMENT 'Detailed description of the corrective action(s) taken in response to a CCP deviation. Documents the specific steps taken to bring the process back into control and disposition of affected product.',
    `critical_limit_lower` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this CCP as defined in the HACCP plan. Values below this threshold indicate a deviation requiring corrective action.',
    `critical_limit_upper` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this CCP as defined in the HACCP plan. Values above this threshold indicate a deviation requiring corrective action.',
    `data_source` STRING COMMENT 'The origin of the CCP monitoring data (mes_automated = automatically captured from Aveva/Wonderware MES, manual_entry = operator-entered, laboratory_system = from LIMS, sensor_network = from IoT sensors).. Valid values are `mes_automated|manual_entry|laboratory_system|sensor_network`',
    `deviation_severity` STRING COMMENT 'Classification of the severity of the CCP deviation if one occurred (minor = slight deviation with low risk, major = significant deviation requiring investigation, critical = severe deviation with immediate food safety risk).. Valid values are `minor|major|critical`',
    `hazard_type` STRING COMMENT 'The category of food safety hazard that this CCP is designed to control (biological, chemical, physical, or allergen).. Valid values are `biological|chemical|physical|allergen`',
    `in_limit_flag` BOOLEAN COMMENT 'Boolean indicator of whether the measured value falls within the defined critical limits (True = within limits, False = out of specification).',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual measured or observed value at the critical control point (e.g., temperature reading, pH level, Brix degree, metal detector sensitivity test result).',
    `monitoring_frequency` STRING COMMENT 'The required frequency of monitoring for this CCP as defined in the HACCP plan (e.g., continuous, every 15 minutes, every batch, hourly).',
    `monitoring_method` STRING COMMENT 'The method or procedure used to monitor this CCP (e.g., calibrated thermometer, pH meter, metal detector test, visual inspection, laboratory analysis).',
    `monitoring_timestamp` TIMESTAMP COMMENT 'The exact date and time when the CCP measurement or observation was recorded. Critical for establishing real-time compliance and traceability.',
    `product_disposition` STRING COMMENT 'The final disposition decision for product affected by this CCP monitoring event (released = approved for distribution, rework = reprocessed to meet specifications, reprocess = returned to earlier production step, destroyed = disposed of, quarantine = held pending investigation).. Valid values are `released|rework|reprocess|destroyed|quarantine`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this CCP log record was first created in the system. Audit trail for data integrity and compliance.',
    `record_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this CCP log record was last modified. Critical for audit trail and data integrity compliance.',
    `regulatory_hold_triggered_flag` BOOLEAN COMMENT 'Boolean indicator of whether this CCP deviation triggered a regulatory hold on the batch, preventing release until investigation and disposition are complete (True = hold triggered, False = no hold).',
    `review_timestamp` TIMESTAMP COMMENT 'The date and time when the supervisor or quality manager completed their review of this CCP log entry.',
    `supervisor_review_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this CCP log entry requires supervisor or quality manager review due to deviation or other exceptional circumstances (True = review required, False = no review needed).',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed (e.g., Celsius, Fahrenheit, pH units, Brix degrees, ppm, CFU/g).',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the CCP monitoring record was verified and signed off by the responsible operator or quality personnel.',
    CONSTRAINT pk_haccp_ccp_log PRIMARY KEY(`haccp_ccp_log_id`)
) COMMENT 'Real-time and operator-entered log of HACCP (Hazard Analysis Critical Control Points) critical control point (CCP) monitoring records for each production batch. Captures CCP identifier, CCP name (e.g., pasteurization temperature, metal detection, pH check, Brix measurement), production order, batch number, work center, monitoring timestamp, measured value, unit of measure, critical limit lower bound, critical limit upper bound, in-limit flag, corrective action required flag, corrective action taken description, verified by operator ID, and regulatory hold triggered flag. Mandatory for FDA FSMA compliance and GFSI certification. Sourced from Aveva/Wonderware MES and manual entry. SSOT boundary: This entity owns real-time CCP monitoring readings and corrective actions during production execution. The quality domain owns the HACCP plan definition, hazard analysis, and CCP validation/verification programs.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` (
    `lot_consumption_id` BIGINT COMMENT 'Unique identifier for the lot consumption transaction record. Primary key for the lot consumption entity.',
    `batch_record_id` BIGINT COMMENT 'Reference to the batch record documenting the production run. Links lot consumption to the specific batch manufacturing execution record for GMP compliance and traceability.',
    `bom_line_id` BIGINT COMMENT 'Foreign key linking to product.bom_line. Business justification: Lot consumption records track which ingredient lots were consumed against specific BOM line items. FSMA 204 traceability requires linking actual consumed lots to the BOM component they satisfy. BOM li',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Needed for Material Consumption Costing and variance analysis; cost_center_code is a denormalized code that should reference finance.cost_center.',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_receipt. Business justification: FSMA one-up/one-back traceability requires linking material consumption records to the specific goods receipt document. lot_consumption → inbound_receipt enables precise recall scope determination, FE',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: REQUIRED: Enables lot‑level traceability for recalls and FDA FSMA reporting by linking each consumption record to the specific ingredient lot used.',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: FSMA one-up-one-down traceability requires linking ingredient lot consumption events to the inventory lot trace record of the consumed ingredient lot. Recall investigations must identify which product',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Lot consumption records occur at a plant; linking to plant provides authoritative plant data and removes the free‑text plant_code.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Linking consumption to a specific PO line enables variance analysis and accurate spend tracking.',
    `production_order_id` BIGINT COMMENT 'Reference to the production order against which this lot consumption occurred. Links consumption to the manufacturing order that triggered the material usage.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Material consumption is allocated to specific promotions for accurate cost‑of‑goods‑sold and promotional spend reconciliation.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: During a recall, ingredient lot consumption records identify which raw material lots entered affected finished goods batches. FSMA traceability rules require forward and backward lot tracing — linking',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: REQUIRED: Links each consumption event to the exact inventory lot consumed, supporting lot traceability, regulatory reporting, and OTIF calculations.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Identifying the supplier of each consumed lot supports quality audits and allergen compliance.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production line where the material was consumed. Links consumption to the specific manufacturing resource.',
    `allergen_flag` BOOLEAN COMMENT 'Indicator of whether the consumed material contains or may contain allergens as defined by FDA and FALCPA regulations. Used for allergen control and cross-contamination prevention.',
    `backflush_indicator` BOOLEAN COMMENT 'Flag indicating whether this consumption was automatically backflushed based on production confirmation (True) or manually posted (False). Backflushing automates material consumption based on BOM and production output.',
    `bom_quantity` DECIMAL(18,2) COMMENT 'The planned or standard quantity of this material specified in the Bill of Materials for the production order. Used to calculate consumption variance.',
    `confirmation_status` STRING COMMENT 'The current status of the consumption transaction in the system workflow: confirmed (posted to inventory), pending (awaiting approval), rejected (not accepted), or reversed (cancelled after posting).. Valid values are `confirmed|pending|rejected|reversed`',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of material consumed from the specified lot during production. Recorded in the unit of measure specified in the unit_of_measure field.',
    `consumption_timestamp` TIMESTAMP COMMENT 'The precise date and time when the material lot was consumed in the production process. Critical for FIFO/FEFO compliance and production timeline tracking.',
    `consumption_type` STRING COMMENT 'Classification of the consumption event indicating the purpose or nature of material usage: standard production, rework/reprocessing, trial run, quality sample, or waste/scrap.. Valid values are `standard|rework|trial|sample|waste`',
    `created_by_user` STRING COMMENT 'The user ID or username of the person who created this consumption record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lot consumption record was first created in the system. Part of the audit trail for data governance and compliance.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the cost values are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fifo_fefo_sequence_number` STRING COMMENT 'Sequential number indicating the order in which lots were consumed according to FIFO or FEFO inventory management rules. Lower numbers indicate earlier consumption priority.',
    `gmo_status` STRING COMMENT 'Classification of the consumed material regarding genetically modified organism content: GMO (contains GMO), non-GMO (verified non-GMO), or unknown (not tested/declared).. Valid values are `gmo|non_gmo|unknown`',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicator of whether the consumed lot is certified halal according to Islamic dietary law. Required for halal product manufacturing and labeling.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicator of whether the consumed lot is certified kosher by a recognized kosher certification agency. Required for kosher product manufacturing and labeling.',
    `lot_expiry_date` DATE COMMENT 'The expiration or best-before date of the consumed lot. Used to enforce FEFO consumption rules and ensure materials are used before expiration.',
    `material_document_number` STRING COMMENT 'The unique document number generated by the ERP system for this goods movement transaction. Used for audit trail and transaction traceability.',
    `material_document_year` STRING COMMENT 'The fiscal year in which the material document was posted. Combined with material_document_number forms a unique key in the source system.',
    `modified_by_user` STRING COMMENT 'The user ID or username of the person who last modified this consumption record. Used for accountability and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lot consumption record was last modified. Tracks the most recent change for audit and data quality purposes.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the inventory transaction (e.g., 261 for goods issue to production order, 262 for reversal). Determines how the consumption affects inventory and financial accounts.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicator of whether the consumed lot is certified organic according to USDA NOP or equivalent organic certification standards. Critical for organic product integrity and labeling compliance.',
    `posting_date` DATE COMMENT 'The date on which the consumption transaction was posted to the financial and inventory ledgers. May differ from consumption_timestamp for backdated postings.',
    `reservation_number` STRING COMMENT 'The material reservation document number that allocated this lot for consumption against the production order. Links consumption to the planned material requirement.',
    `supplier_lot_number` STRING COMMENT 'The original lot or batch number assigned by the supplier for the consumed material. Critical for traceability back to the raw material source and supplier quality investigations.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the consumed quantity, calculated as consumption_quantity * unit_cost. Represents the material cost component of the production order.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The standard or actual cost per unit of measure for the consumed material at the time of consumption. Used for production cost calculation and COGS determination.',
    `unit_of_measure` STRING COMMENT 'The unit in which the consumption quantity is measured (e.g., KG, LB, EA, L, GAL). Must align with the material master unit of measure.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The consumption variance expressed as a percentage of the BOM quantity. Calculated as (variance_quantity / bom_quantity) * 100.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual consumption quantity and the BOM planned quantity. Positive values indicate over-consumption; negative values indicate under-consumption.',
    `warehouse_location_code` STRING COMMENT 'The storage location or warehouse from which the material lot was withdrawn for consumption. Links to the warehouse management system location master.',
    CONSTRAINT pk_lot_consumption PRIMARY KEY(`lot_consumption_id`)
) COMMENT 'Transactional records of raw material, ingredient, and packaging component lot consumption against production orders, implementing FIFO/FEFO inventory management. Captures production order, batch record, consumed material code, consumed lot number, consumption quantity, unit of measure, consumption timestamp, FIFO/FEFO sequence number, expiry date of consumed lot, warehouse storage location, consumption type (standard, rework, trial), variance from BOM quantity, and confirmation status. Provides full lot traceability from raw material to finished goods batch. Sourced from SAP S/4HANA MM goods movement and MES batch management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the production routing master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Standard cost estimates in F&B ERP are built from routings; each routing operation references a cost center to apply the correct overhead rate. This link is required for standard cost roll-up, activit',
    `finance_standard_cost_id` BIGINT COMMENT 'Foreign key linking to finance.finance_standard_cost. Business justification: In F&B, standard cost estimates are directly derived from routings (machine/labor time) and BOMs. Linking routing to finance_standard_cost enables cost roll-up traceability, standard cost release audi',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: Production routings define the process steps where CCPs are applied. FSMA requires that process controls documented in the food safety plan are linked to the specific routing operations — this FK enab',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: F&B routings are market-specific due to differing regulatory requirements (EU allergen handling, USDA organic steps, Halal processing requirements by market). Market-specific routing variants are stan',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant where this routing is executed.',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party co-packing supplier if this routing represents externally manufactured production. Null for internal production.',
    `routing_toll_manufacturer_supplier_id` BIGINT COMMENT 'Reference to the toll manufacturing supplier if this routing represents production where the company provides raw materials and the supplier provides processing. Null for internal or co-packed production.',
    `sku_id` BIGINT COMMENT 'Reference to the finished good SKU that this routing produces.',
    `work_center_id` BIGINT COMMENT 'Reference to the primary production line or work center group where this routing is executed. Used for capacity planning and scheduling.',
    `allergen_handling_required_flag` BOOLEAN COMMENT 'Indicates whether this routing requires special allergen handling procedures, such as line changeover cleaning or dedicated equipment, to prevent cross-contact.',
    `approval_status` STRING COMMENT 'The current approval state of this routing. Approved routings are released for production use; pending routings await engineering or quality approval; rejected routings require rework; expired routings have passed their review date.. Valid values are `pending|approved|rejected|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this routing was approved for production use.',
    `base_quantity` DECIMAL(18,2) COMMENT 'The standard production lot size for which the routing times are defined. Actual production order times are scaled proportionally from this base.',
    `base_unit_of_measure` STRING COMMENT 'The unit of measure for the base quantity (e.g., KG, LB, EA, CS). Aligns with the SKU primary UOM.',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'The standard time required to change over the production line from the previous SKU to this routing, including cleaning, setup, and first-article inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this routing record was first created in the system.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this routing has been validated for GMP compliance. True means all operations meet GMP documentation, training, and control requirements.',
    `haccp_critical_flag` BOOLEAN COMMENT 'Indicates whether this routing contains one or more HACCP critical control points (CCPs) that require monitoring and documentation per the food safety plan.',
    `last_review_date` DATE COMMENT 'The date when this routing was last reviewed and validated by engineering or production management.',
    `lot_size_from` DECIMAL(18,2) COMMENT 'The minimum production lot size for which this routing is valid. Supports lot-size-dependent routing selection.',
    `lot_size_to` DECIMAL(18,2) COMMENT 'The maximum production lot size for which this routing is valid. Null indicates no upper limit.',
    `maximum_batch_size` DECIMAL(18,2) COMMENT 'The largest production quantity that can be produced in a single batch using this routing, constrained by equipment capacity or process limits.',
    `minimum_batch_size` DECIMAL(18,2) COMMENT 'The smallest production quantity that can be economically or technically produced using this routing, expressed in the base UOM.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this routing record was last modified.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this routing to ensure continued accuracy and compliance.',
    `operation_count` STRING COMMENT 'The total number of sequential operations (work center steps) defined in this routing.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether this routing is certified for organic production under USDA NOP or equivalent standards, requiring segregation and documentation.',
    `rework_allowed_flag` BOOLEAN COMMENT 'Indicates whether non-conforming product from this routing can be reworked through a defined rework operation sequence.',
    `routing_description` STRING COMMENT 'Free-text description of the routing, typically summarizing the production method or key process characteristics (e.g., High-speed aseptic filling line, Manual batch mixing and packaging).',
    `routing_number` STRING COMMENT 'Business identifier for the routing. The externally-known unique code used to reference this routing in production planning and scheduling systems.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Active routings are available for production order creation; draft and under-review routings are in development; inactive and obsolete routings are no longer used.. Valid values are `draft|active|inactive|obsolete|under_review`',
    `routing_type` STRING COMMENT 'Classification of the routing. Standard routings are the default production method; alternative routings provide flexibility for capacity or material constraints; trial routings support NPD; co-packing and toll manufacturing routings reflect external production arrangements.. Valid values are `standard|alternative|trial|co_packing|toll_manufacturing`',
    `scrap_percentage` DECIMAL(18,2) COMMENT 'The expected percentage of material loss or waste across all operations in this routing, used for material planning and costing.',
    `total_standard_production_time_minutes` DECIMAL(18,2) COMMENT 'The sum of all operation standard times (setup, machine, labor) across the routing, expressed in minutes. Used for capacity planning and production scheduling.',
    `usage` STRING COMMENT 'The business purpose for which this routing is maintained. Production routings drive MES execution; costing routings feed standard cost calculations; maintenance and quality inspection routings support non-production work orders.. Valid values are `production|costing|maintenance|quality_inspection`',
    `valid_from_date` DATE COMMENT 'The date from which this routing version becomes effective for production planning and scheduling.',
    `valid_to_date` DATE COMMENT 'The date until which this routing version remains effective. Null indicates open-ended validity.',
    `version` STRING COMMENT 'Version identifier for the routing. Allows multiple versions of the same routing to coexist for different time periods or production scenarios.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Production routing master data defining the sequence of manufacturing operations (work center steps) required to produce a SKU. Captures routing number, routing version, SKU, plant, valid-from/to dates, routing status, total standard production time, and the ordered list of operations with their work center assignments, standard times (setup, machine, labor), and operation descriptions (e.g., mixing, pasteurization, filling, capping, labeling, palletizing). Sourced from SAP PP routing master. Distinct from the BOM (what goes in) — the routing defines how it is made and in what sequence.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`plant` (
    `plant_id` BIGINT COMMENT 'Unique identifier for the manufacturing plant, co-packing facility, or production site. Primary key for the plant master data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: In ERP, every manufacturing plant is assigned to exactly one company code — a foundational organizational mapping required for statutory financial reporting, intercompany transactions, tax jurisdictio',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Each plant must be linked to its regulatory establishment registration for audit and reporting.',
    `market_id` BIGINT COMMENT 'Foreign key linking to marketing.market. Business justification: F&B plants are designated to serve specific geographic markets, driving regulatory compliance (FDA vs. EU vs. LATAM requirements), brand distribution planning, and market-specific production capacity ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to supply.network_node. Business justification: Logistics planning maps each plant to a distribution network node for transportation scheduling and OTIF performance reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: F&B plants are mapped to profit centers for segment and geographic P&L reporting. This link supports plant-level profitability analysis, transfer pricing between plants, and management reporting by ma',
    `address_line_1` STRING COMMENT 'Primary street address line for the plant location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details such as building number, suite, or floor.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the daily capacity metric (e.g., cases, pallets, kilograms, pounds, liters, gallons) aligned with the primary output of the facility.. Valid values are `cases|pallets|kg|lbs|liters|gallons`',
    `city` STRING COMMENT 'City or municipality where the plant is located.',
    `cold_storage_capacity_pallets` STRING COMMENT 'Refrigerated and frozen storage capacity at the plant site measured in standard pallet positions for temperature-sensitive products and ingredients.',
    `commissioning_date` DATE COMMENT 'Date when the plant was first commissioned and began commercial production operations.',
    `country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where the plant is located (e.g., USA, MEX, CAN, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this plant master data record was first created in the system.',
    `daily_capacity_units` DECIMAL(18,2) COMMENT 'Maximum daily production capacity of the plant measured in standard production units per day. Used for capacity planning, demand allocation, and OEE (Overall Equipment Effectiveness) calculations.',
    `decommissioning_date` DATE COMMENT 'Date when the plant was permanently closed and ceased all production operations. Null for active facilities.',
    `erp_plant_code` STRING COMMENT 'Plant code or site identifier used in the primary ERP system (SAP S/4HANA, Oracle Cloud ERP) for transactional processing, inventory management, and financial reporting. May differ from the business plant_code for legacy integration reasons.',
    `fda_registration_number` STRING COMMENT 'FDA facility registration number required for food manufacturing facilities under FSMA (Food Safety Modernization Act) regulations. Mandatory for US-based facilities and importers.. Valid values are `^[0-9]{10,15}$`',
    `gfsi_certification_expiry_date` DATE COMMENT 'Expiration date of the current GFSI certification requiring renewal to maintain compliance and customer approval status.',
    `gfsi_scheme` STRING COMMENT 'The GFSI-benchmarked food safety certification scheme held by the plant. SQF (Safe Quality Food), BRC (British Retail Consortium), FSSC 22000 (Food Safety System Certification), IFS (International Featured Standards), or none if not certified.. Valid values are `SQF|BRC|FSSC_22000|IFS|none`',
    `gmp_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the plant holds current GMP (Good Manufacturing Practice) certification required for food and beverage manufacturing quality standards.',
    `halal_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the plant holds halal certification from a recognized Islamic authority enabling production of halal-certified products.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the plant holds kosher certification from a recognized rabbinical authority enabling production of kosher-certified products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this plant master data record was most recently updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the plant location in decimal degrees format for mapping and logistics optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the plant location in decimal degrees format for mapping and logistics optimization.',
    `mes_site_code` STRING COMMENT 'Site or facility identifier used in the Manufacturing Execution System (Aveva/Wonderware MES) for production scheduling, batch management, and OEE tracking.',
    `number_of_production_lines` STRING COMMENT 'Total count of active production lines or manufacturing lines within the plant used for production scheduling and line allocation.',
    `operating_days_per_week` STRING COMMENT 'Standard number of operating days per week for the plant (typically 5, 6, or 7) used for production planning and capacity calculations.',
    `operating_hours_per_day` DECIMAL(18,2) COMMENT 'Standard operating hours per day for the plant used for capacity planning and OEE calculations. Typically 8, 16, or 24 hours depending on shift structure.',
    `organic_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the plant holds organic certification (USDA Organic, EU Organic, or equivalent) enabling production of certified organic products.',
    `organic_certifying_body` STRING COMMENT 'Name of the accredited organic certification body that issued the organic certification (e.g., QAI, CCOF, Oregon Tilth, Ecocert).',
    `plant_code` STRING COMMENT 'Business identifier code for the plant used across operational systems. Typically a 4-10 character alphanumeric code used in ERP systems (SAP plant code, Oracle site code).. Valid values are `^[A-Z0-9]{4,10}$`',
    `plant_name` STRING COMMENT 'Official business name of the manufacturing plant or production facility.',
    `plant_status` STRING COMMENT 'Current operational status of the plant in its lifecycle. Active indicates full production operations, idle indicates temporarily not producing but maintained, decommissioned indicates permanently closed, under construction indicates new facility being built, and temporarily closed indicates short-term shutdown for maintenance or seasonal operations.. Valid values are `active|idle|decommissioned|under_construction|temporarily_closed`',
    `plant_type` STRING COMMENT 'Classification of the facility type indicating ownership and operational model. Owned manufacturing indicates company-operated production facilities, co-packer indicates third-party contract manufacturing, toll manufacturer indicates facilities where the company provides ingredients and the manufacturer provides processing, pilot plant indicates small-scale testing facilities, R&D facility indicates research and development sites, and distribution center indicates warehousing and logistics hubs.. Valid values are `owned_manufacturing|co_packer|toll_manufacturer|pilot_plant|r_and_d_facility|distribution_center`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the plant address used for mail delivery and logistics routing.',
    `primary_product_category` STRING COMMENT 'Primary product category or product line manufactured at this plant (e.g., beverages, snacks, dairy, bakery, confectionery) used for portfolio planning and specialization tracking.',
    `region` STRING COMMENT 'Business-defined geographic region or market area for reporting and planning purposes (e.g., North America, EMEA, APAC, Latin America).',
    `state_province` STRING COMMENT 'State, province, or regional administrative division where the plant is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the plant location (e.g., America/New_York, Europe/London, Asia/Shanghai) used for production scheduling and shift management.',
    `usda_establishment_number` STRING COMMENT 'USDA establishment number assigned to facilities that process meat, poultry, or egg products under USDA inspection. Required for facilities producing USDA-regulated products.. Valid values are `^[0-9]{1,5}[A-Z]?$`',
    `warehouse_capacity_pallets` STRING COMMENT 'Total warehouse storage capacity at the plant site measured in standard pallet positions for finished goods and raw material inventory management.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master data for all manufacturing plants, co-packing facilities, and production sites operated or contracted by the business. Captures plant code, plant name, plant type (owned manufacturing, co-packer, toll manufacturer, pilot plant, R&D facility), address, country, region, plant manager, plant capacity (units/day), number of production lines, GMP certification status, GFSI scheme (SQF, BRC, FSSC 22000), certification expiry date, FDA registration number, USDA establishment number, kosher certification flag, halal certification flag, organic certification flag, plant status (active, idle, decommissioned), and ERP plant code. SSOT for manufacturing facility master data.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` (
    `equipment_master_id` BIGINT COMMENT 'Unique identifier for the production equipment asset record. Primary key for the equipment master data product.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.claim. Business justification: Specific equipment enables specific marketing claims in F&B (e.g., certified organic processing equipment enables organic claims; cold-press equipment enables cold-pressed claims). Claim substantiatio',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Equipment maintenance costs, calibration expenses, and depreciation charges are posted directly to cost centers in F&B ERP systems. Equipment_master must reference its cost center for maintenance cost',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Every F&B production equipment item is capitalized as a fixed asset. Linking equipment_master to fixed_asset enables depreciation tracking, capex reporting, asset lifecycle management, and physical in',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where this equipment is physically located and operated.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Capital equipment asset lifecycle management: F&B operations link equipment assets to their originating purchase order for asset capitalization, warranty period calculation, and audit trails. No exist',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Equipment procurement and warranty management: F&B plants track which supplier/OEM supplied each piece of equipment for spare parts sourcing, warranty claims, and maintenance contracts. A domain exper',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production area within the plant where this equipment is assigned for production scheduling and capacity planning.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or total capitalized cost of acquiring and installing the equipment, used for asset valuation and depreciation calculations.',
    `acquisition_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the acquisition cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `allergen_handling_capability` STRING COMMENT 'Description of allergen types this equipment is qualified to handle, or designation as allergen-free equipment. Critical for allergen control and production scheduling to prevent cross-contamination.',
    `asset_owner_department` STRING COMMENT 'Department or business unit responsible for the ownership, budgeting, and strategic decisions related to this equipment asset.',
    `calibration_certificate_number` STRING COMMENT 'Reference number of the most recent calibration certificate documenting the equipments measurement accuracy and compliance with specifications.',
    `calibration_frequency_days` STRING COMMENT 'Number of days between required calibration activities as defined by regulatory requirements, manufacturer specifications, or internal quality standards.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the rated capacity value, indicating how production throughput is quantified for this equipment.. Valid values are `units_per_hour|kg_per_hour|liters_per_hour|cases_per_minute|pallets_per_hour`',
    `cip_capable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this equipment is designed for automated clean-in-place sanitation without disassembly, enabling efficient changeover and sanitation cycles.',
    `commissioning_date` DATE COMMENT 'Date when the equipment was validated, qualified, and approved for production use following installation and testing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment master record was first created in the system, supporting audit trail and data lineage requirements.',
    `criticality_level` STRING COMMENT 'Business criticality classification of the equipment based on its impact to production continuity, safety, and quality. Critical equipment requires highest priority maintenance and monitoring.. Valid values are `critical|high|medium|low`',
    `decommission_date` DATE COMMENT 'Date when the equipment was permanently removed from service and decommissioned, marking the end of its operational lifecycle.',
    `decommission_reason` STRING COMMENT 'Business justification or reason for decommissioning the equipment (e.g., end of life, obsolescence, facility closure, technology upgrade).',
    `energy_consumption_rating_kwh` DECIMAL(18,2) COMMENT 'Rated or average energy consumption of the equipment per operating hour, used for sustainability tracking and operational cost analysis.',
    `equipment_category` STRING COMMENT 'High-level grouping of equipment by operational category for reporting and analysis purposes.. Valid values are `processing|packaging|quality_control|material_handling|cleaning|utility`',
    `equipment_name` STRING COMMENT 'Human-readable descriptive name of the equipment asset (e.g., Line 3 Filling Machine, Pasteurizer Unit A).',
    `equipment_tag_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the equipment asset for operational tracking and maintenance purposes. This is the externally-known business identifier used in MES systems, work orders, and maintenance schedules.. Valid values are `^[A-Z0-9]{3,20}$`',
    `equipment_type` STRING COMMENT 'Classification of the equipment by its primary production function within the manufacturing process. [ENUM-REF-CANDIDATE: filling_machine|mixer|blender|pasteurizer|extruder|packaging_line|labeler|metal_detector|checkweigher|cip_system|oven|cooler|conveyor|palletizer|wrapper|sealer — 16 candidates stripped; promote to reference product]',
    `food_contact_surface_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this equipment has surfaces that come into direct contact with food products, requiring specific sanitation and material compliance standards.',
    `gmp_critical_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this equipment is classified as GMP-critical, requiring enhanced documentation, validation, and change control procedures.',
    `installation_date` DATE COMMENT 'Date when the equipment was physically installed at the manufacturing facility.',
    `last_calibration_date` DATE COMMENT 'Date when the equipment was last calibrated or verified for measurement accuracy, applicable to equipment requiring calibration per GMP or quality standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment master record was last updated, supporting change tracking and audit trail requirements.',
    `mes_asset_tag` STRING COMMENT 'Unique identifier used by the MES system (Aveva/Wonderware) to track this equipment in real-time production monitoring, batch execution, and performance analytics.',
    `model_number` STRING COMMENT 'Manufacturers model designation for the equipment, used for parts ordering and technical documentation reference.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or verification activity to maintain equipment qualification status.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or contextual information about the equipment that does not fit structured fields.',
    `oee_baseline_target_percent` DECIMAL(18,2) COMMENT 'Target OEE percentage established as the performance baseline for this equipment, used for monitoring and continuous improvement initiatives. OEE measures availability, performance, and quality.',
    `operational_status` STRING COMMENT 'Current operational state of the equipment indicating its availability for production use.. Valid values are `operational|under_maintenance|down|decommissioned|standby|quarantined`',
    `preventive_maintenance_schedule_code` STRING COMMENT 'Reference code linking this equipment to its preventive maintenance plan schedule defining frequency and tasks for routine maintenance activities.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Maximum production capacity of the equipment as specified by the manufacturer or validated during commissioning, expressed in the unit of measure appropriate to the equipment type.',
    `safety_certification_code` STRING COMMENT 'Reference code or identifier for safety certifications held by this equipment (e.g., UL, CE, CSA), documenting compliance with electrical and mechanical safety standards.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific equipment unit for warranty and service tracking.',
    `technical_specification_document_code` STRING COMMENT 'Reference identifier for the technical specification document containing detailed engineering specifications, operating parameters, and maintenance procedures for this equipment.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage for this equipment expires, after which repairs and parts are no longer covered under warranty.',
    CONSTRAINT pk_equipment_master PRIMARY KEY(`equipment_master_id`)
) COMMENT 'Master data for all production equipment assets within manufacturing plants — filling machines, mixers, blenders, pasteurizers, extruders, packaging lines, labelers, metal detectors, checkweighers, and CIP systems. Captures equipment tag number, equipment name, equipment type, manufacturer, model, serial number, plant, work center assignment, installation date, commissioning date, rated capacity, current status (operational, under maintenance, decommissioned), preventive maintenance schedule reference, last calibration date, next calibration due date, calibration certificate number, OEE baseline target, and MES asset tag. SSOT for production equipment master data used in OEE, maintenance, and calibration tracking.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`manufacturing`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Primary key for production_line',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OEE, downtime costs, and line-level manufacturing overhead are tracked per production line against cost centers for overhead absorption and variance reporting. F&B finance teams require this link for ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Production lines (e.g., bottling lines, packaging lines) are capitalized as fixed assets in F&B. Linking production_line to fixed_asset supports capex tracking, depreciation allocation per line, asset',
    `location_id` BIGINT COMMENT 'Identifier of the facility location where the line resides.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Each production line has a designated finished goods staging storage location where completed products are placed before transfer to warehouse. Warehouse management and production scheduling use this ',
    `parent_production_line_id` BIGINT COMMENT 'Self-referencing FK on production_line (parent_production_line_id)',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant containing the line.',
    `capacity_per_hour` DECIMAL(18,2) COMMENT 'Maximum production capacity per hour (units per hour).',
    `changeover_time_minutes` STRING COMMENT 'Average time required to change over the line between products.',
    `control_system` STRING COMMENT 'Type of control system governing the line.',
    `downtime_minutes` STRING COMMENT 'Accumulated downtime minutes for the reporting period.',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total energy used by the line in kilowatt‑hours.',
    `gmp_compliant` BOOLEAN COMMENT 'Indicates if the line meets Good Manufacturing Practice requirements.',
    `haccp_status` STRING COMMENT 'Current HACCP compliance status for the line.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the line is fully automated.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety inspection.',
    `last_maintenance_date` DATE COMMENT 'Date when the line was last maintained.',
    `last_quality_check_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent quality inspection.',
    `line_code` STRING COMMENT 'Unique alphanumeric code assigned to the line.',
    `line_description` STRING COMMENT 'Narrative description of the lines purpose and characteristics.',
    `line_end_date` DATE COMMENT 'Date the line was retired or removed from service.',
    `line_group` STRING COMMENT 'Logical group or family the line belongs to (e.g., primary, secondary).',
    `line_name` STRING COMMENT 'Human‑readable name of the production line.',
    `line_operating_mode` STRING COMMENT 'Mode in which the line operates.',
    `line_speed_m_per_min` DECIMAL(18,2) COMMENT 'Physical speed of the line in meters per minute.',
    `line_start_date` DATE COMMENT 'Date the production line was first put into service.',
    `line_type` STRING COMMENT 'Functional type of the line (e.g., bottling, mixing).',
    `maintenance_status` STRING COMMENT 'Status of the lines maintenance cycle.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next maintenance activity.',
    `oee_actual` DECIMAL(18,2) COMMENT 'Measured OEE percentage for the line.',
    `oee_target` DECIMAL(18,2) COMMENT 'Planned OEE percentage for the line.',
    `production_line_status` STRING COMMENT 'Current lifecycle status of the line.',
    `quality_score` DECIMAL(18,2) COMMENT 'Aggregated quality score for the line (0‑100).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the production line record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the production line record.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents recorded for the line.',
    `safety_status` STRING COMMENT 'Current safety condition of the line.',
    `setup_time_minutes` STRING COMMENT 'Average time to set up the line for a production run.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Percentage of time the line was operational.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Master reference table for production_line. Referenced by production_line_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ADD CONSTRAINT `fk_manufacturing_batch_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_equipment_master_id` FOREIGN KEY (`equipment_master_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`equipment_master`(`equipment_master_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ADD CONSTRAINT `fk_manufacturing_haccp_ccp_log_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_batch_record_id` FOREIGN KEY (`batch_record_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`batch_record`(`batch_record_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ADD CONSTRAINT `fk_manufacturing_lot_consumption_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ADD CONSTRAINT `fk_manufacturing_equipment_master_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_parent_production_line_id` FOREIGN KEY (`parent_production_line_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `food_beverage_ecm`.`manufacturing`.`plant`(`plant_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co Packer Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Haccp Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `batch_size` SET TAGS ('dbx_business_glossary_term' = 'Batch Size');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_value_regex' = 'partial|final');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Production Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `fefo_lot_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Lot Consumption Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `fifo_lot_consumption_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Lot Consumption Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `goods_movement_document` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Document Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `goods_movement_document` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `haccp_ccp_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Critical Control Point (CCP) Log Reference');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `haccp_ccp_log_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `mes_work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Work Order Reference');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `mes_work_order_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,20}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,12}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Production Order Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Production Order Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rework|trial|co-pack|toll');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_disposition` SET TAGS ('dbx_business_glossary_term' = 'Rework Disposition');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_disposition` SET TAGS ('dbx_value_regex' = 'reprocessed|downgraded|scrapped|returned_to_vendor');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rework Reason Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `rework_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `routing_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,8}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Production Shift');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|evening|night|weekend');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `toll_manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturer Name');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `toll_manufacturer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Production Yield Percentage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_order` ALTER COLUMN `yield_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `allergen_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Packer Supplier ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `actual_yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `allergen_statement` SET TAGS ('dbx_business_glossary_term' = 'Allergen Statement');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_notes` SET TAGS ('dbx_business_glossary_term' = 'Batch Notes');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (Lot Number)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'in_process|pending_qa|released|rejected|quarantine|on_hold');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date (Best By Date)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `co_packer_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Packer Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (Expiration Date)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gluten_free_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Claim Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `haccp_signoff_status` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Sign-Off Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `haccp_signoff_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_applicable');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `halal_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certification Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `kosher_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certification Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing End Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `manufacturing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `non_gmo_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO Verified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `organic_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `packaging_configuration` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `parent_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Parent Batch Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `parent_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `qa_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `regulatory_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reason');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'pasteurization|uht|retort|aseptic|none|other');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `toll_manufacturing_flag` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturing Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`batch_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Node ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Staging Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `allergen_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Capable Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `allergen_types` SET TAGS ('dbx_business_glossary_term' = 'Allergen Types');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `available_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Available Hours Per Day');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `cip_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Cycle Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `cip_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Required Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `co_packing_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Packing Approved Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'standard|high_care|high_risk|low_risk');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `haccp_ccp_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Point (HACCP) Critical Control Point (CCP) Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `maximum_run_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Run Size');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Asset Tag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `minimum_run_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Run Size');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Target Percent');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `production_area` SET TAGS ('dbx_business_glossary_term' = 'Production Area');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `rated_capacity_units_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity (Units Per Hour)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `run_size_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Run Size Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single|two_shift|three_shift|continuous|custom');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `standard_cycle_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Cycle Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'production|quality_control|maintenance|warehouse|co-packing');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_description` SET TAGS ('dbx_business_glossary_term' = 'Work Center Description');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|maintenance|idle|decommissioned|startup|shutdown');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `capacity_constraint_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Constraint Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `promotion_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Packer ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `allergen_changeover_required` SET TAGS ('dbx_business_glossary_term' = 'Allergen Changeover Required');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `batch_size_target` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Target');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percent');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time Minutes');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `crew_size_required` SET TAGS ('dbx_business_glossary_term' = 'Crew Size Required');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `execution_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `forecast_demand_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecast Demand Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `frozen_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Frozen Zone Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `haccp_ccp_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Critical Control Point (CCP) Applicable');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `last_replanning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Replanning Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `lot_number_planned` SET TAGS ('dbx_business_glossary_term' = 'Lot Number Planned');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `material_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Material Availability Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `material_availability_status` SET TAGS ('dbx_value_regex' = 'confirmed|partial|pending|shortage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `otif_target_date` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `planned_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `released_to_mes_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released to Manufacturing Execution System (MES) Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `replanning_reason` SET TAGS ('dbx_business_glossary_term' = 'Replanning Reason');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `safety_stock_target` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Target');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_source` SET TAGS ('dbx_value_regex' = 'MRP|manual|IBP|demand_sensing|optimization');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|firmed|released|executed|cancelled');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration Minutes');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date Time');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date Time');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `setup_instructions` SET TAGS ('dbx_business_glossary_term' = 'Setup Instructions');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `haccp_ccp_log_id` SET TAGS ('dbx_business_glossary_term' = 'HACCP (Hazard Analysis Critical Control Points) CCP (Critical Control Point) Log ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `critical_control_point_id` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `quarantine_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `ccp_identifier` SET TAGS ('dbx_business_glossary_term' = 'CCP (Critical Control Point) Identifier');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `ccp_name` SET TAGS ('dbx_business_glossary_term' = 'CCP (Critical Control Point) Name');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken Description');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `critical_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Lower Bound');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `critical_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Critical Limit Upper Bound');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'mes_automated|manual_entry|laboratory_system|sensor_network');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_business_glossary_term' = 'Deviation Severity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `deviation_severity` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `hazard_type` SET TAGS ('dbx_business_glossary_term' = 'Hazard Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `hazard_type` SET TAGS ('dbx_value_regex' = 'biological|chemical|physical|allergen');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `in_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'In Limit Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Method');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `product_disposition` SET TAGS ('dbx_business_glossary_term' = 'Product Disposition');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `product_disposition` SET TAGS ('dbx_value_regex' = 'released|rework|reprocess|destroyed|quarantine');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `record_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `regulatory_hold_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Triggered Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `supervisor_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Required Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`haccp_ccp_log` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` SET TAGS ('dbx_subdomain' = 'production_execution');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `lot_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Consumption ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `bom_quantity` SET TAGS ('dbx_business_glossary_term' = 'BOM (Bill of Materials) Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|rejected|reversed');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumption Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_business_glossary_term' = 'Consumption Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `consumption_type` SET TAGS ('dbx_value_regex' = 'standard|rework|trial|sample|waste');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `fifo_fefo_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'FIFO/FEFO (First In First Out/First Expired First Out) Sequence Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'GMO (Genetically Modified Organism) Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'gmo|non_gmo|unknown');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `lot_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Expiry Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`lot_consumption` ALTER COLUMN `warehouse_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `finance_standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Standard Cost Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Packer ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_toll_manufacturer_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturer ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `allergen_handling_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Handling Required Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Base Quantity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `haccp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Critical Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `lot_size_from` SET TAGS ('dbx_business_glossary_term' = 'Lot Size From');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `lot_size_to` SET TAGS ('dbx_business_glossary_term' = 'Lot Size To');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `maximum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `minimum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `operation_count` SET TAGS ('dbx_business_glossary_term' = 'Operation Count');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `rework_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Allowed Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|obsolete|under_review');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'standard|alternative|trial|co_packing|toll_manufacturing');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `scrap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Scrap Percentage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `total_standard_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Production Time (Minutes)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Routing Usage');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'production|costing|maintenance|quality_inspection');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'cases|pallets|kg|lbs|liters|gallons');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `cold_storage_capacity_pallets` SET TAGS ('dbx_business_glossary_term' = 'Cold Storage Capacity in Pallets');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `daily_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Daily Production Capacity in Units');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `erp_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Plant Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registration Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `gfsi_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'GFSI Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Scheme');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_value_regex' = 'SQF|BRC|FSSC_22000|IFS|none');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `mes_site_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Site Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `operating_days_per_week` SET TAGS ('dbx_business_glossary_term' = 'Operating Days Per Week');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `operating_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Per Day');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `organic_certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Organic Certifying Body');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_status` SET TAGS ('dbx_business_glossary_term' = 'Plant Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_status` SET TAGS ('dbx_value_regex' = 'active|idle|decommissioned|under_construction|temporarily_closed');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_value_regex' = 'owned_manufacturing|co_packer|toll_manufacturer|pilot_plant|r_and_d_facility|distribution_center');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `primary_product_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Business Region');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `usda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'United States Department of Agriculture (USDA) Establishment Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `usda_establishment_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,5}[A-Z]?$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`plant` ALTER COLUMN `warehouse_capacity_pallets` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Capacity in Pallets');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Master ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Currency Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `acquisition_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `allergen_handling_capability` SET TAGS ('dbx_business_glossary_term' = 'Allergen Handling Capability');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `asset_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner Department');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `calibration_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency Days');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'units_per_hour|kg_per_hour|liters_per_hour|cases_per_minute|pallets_per_hour');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `cip_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean-In-Place (CIP) Capable Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `energy_consumption_rating_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Rating Kilowatt-Hours (kWh)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'processing|packaging|quality_control|material_handling|cleaning|utility');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_name` SET TAGS ('dbx_business_glossary_term' = 'Equipment Name');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `food_contact_surface_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Contact Surface Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `gmp_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Critical Flag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `mes_asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Asset Tag');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `oee_baseline_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Overall Equipment Effectiveness (OEE) Baseline Target Percent');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|under_maintenance|down|decommissioned|standby|quarantined');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `preventive_maintenance_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `safety_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Code');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `technical_specification_document_code` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document ID');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`equipment_master` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Output Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`manufacturing`.`production_line` ALTER COLUMN `parent_production_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
