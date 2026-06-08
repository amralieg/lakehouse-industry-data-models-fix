-- Schema for Domain: production | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`production` COMMENT 'Captures manufacturing processes, cut-make-trim (CMT) execution, work orders, production scheduling, factory capacity planning, and production milestone tracking. Manages PP samples, bulk production runs, and manufacturing partner coordination across SAP S/4HANA PP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order. Primary key for the work order entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Work orders link to factory audit records to verify production facility compliance status. Brands require valid audit (social, environmental) before issuing production orders - mandatory gate in ethic',
    `bom_id` BIGINT COMMENT 'FK to product.bom.bom_id — MUST-HAVE: Links production work orders to the authoritative BOM in the product domain, enabling material requirements planning and cost tracking. Critical after production.bom removal.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Production orders consume OTB (Open-to-Buy) budget for manufacturing spend control, enabling real-time budget utilization tracking and production cost commitment management—core apparel financial plan',
    `collection_id` BIGINT COMMENT 'Reference to the product collection this work order belongs to. Links production to merchandising assortment strategy.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Work orders require valid compliance certifications (GOTS, OEKO-TEX, Fair Trade) before production approval. Apparel manufacturers gate production start on certification status - standard compliance w',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: Work orders track originating design concept for collection performance reporting, design ROI analysis, and concept-to-production success metrics. Enables design team performance evaluation.',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Product-level LCA and EPD (Environmental Product Declaration) reporting require linking production orders to environmental impact assessments. Apparel brands publish carbon footprints per style/order ',
    `factory_id` BIGINT COMMENT 'FK to supplier.factory.factory_id — MUST-HAVE: Links production work orders to the factory master for capacity planning, compliance verification, and production allocation decisions.',
    `letter_of_credit_id` BIGINT COMMENT 'Foreign key linking to finance.letter_of_credit. Business justification: International production orders require LC tracking for payment terms, trade finance management, and supplier payment security—standard in global apparel sourcing operations with overseas factories.',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Production orders specify packaging requirements (retail vs. wholesale, channel-specific). Linking to packaging sustainability enables EPR (Extended Producer Responsibility) compliance tracking, plast',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production orders must allocate manufacturing costs to cost centers for standard costing, variance analysis, and factory overhead allocation—core requirement in apparel manufacturing accounting.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility assigned to execute this work order. Links to the supplier/factory master.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Work orders require profit center assignment for margin analysis by brand/channel/region, enabling P&L reporting at collection and season level—standard apparel financial reporting requirement.',
    `routing_id` BIGINT COMMENT 'Foreign key linking to production.routing. Business justification: Every work order executes a specific manufacturing routing that defines the sequence of operations, work centers, and standard times. This is core SAP PP functionality. The routing defines HOW to manu',
    `season_id` BIGINT COMMENT 'Reference to the merchandising season this work order supports. Links production to collection planning and retail calendar.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Work orders reference approved design sketches for manufacturing specifications, pattern instructions, and construction details. Core production workflow linking design intent to factory execution.',
    `style_id` BIGINT COMMENT 'Reference to the style being manufactured in this work order. Links to the product master style definition.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Work orders for export require trade compliance classification (HS codes, country of origin, duty rates). Links production order to trade compliance data - mandatory for international shipments and cu',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Work orders must track the executing vendor for vendor performance scorecards, payment processing, compliance audits, and OTIF reporting. Essential for vendor management and production accountability ',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the distribution center or warehouse where finished goods will be received. Links production to supply chain fulfillment.',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: B2B wholesale accounts commission production runs for their orders. Work orders track which account the production is for, enabling account-level production tracking, capacity allocation, and fulfillm',
    `actual_ex_factory_date` DATE COMMENT 'Actual date when finished goods departed the factory. Used to measure OTIF performance and update logistics schedules.',
    `aql_level` STRING COMMENT 'Acceptable Quality Limit standard applied for inspection (e.g., 2.5, 4.0). Defines the maximum acceptable defect rate per ISO 2859 sampling standards.. Valid values are `^[0-9].[0-9]$|critical_zero`',
    `cmt_type` STRING COMMENT 'Manufacturing service model defining the scope of work performed by the factory. Cut-Make-Trim includes all production steps; Make-Trim excludes cutting; Full Package includes material sourcing.. Valid values are `cut_make_trim|make_trim|trim_only|full_package|fob`',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether this work order requires compliance certifications (e.g., OEKO-TEX, GOTS, WRAP, FLA). True if certifications must be provided before shipment.',
    `confirmed_quantity` STRING COMMENT 'Quantity confirmed by the factory as feasible for production. May differ from ordered quantity based on capacity constraints or material availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this work order. Typically USD for international apparel manufacturing.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the final destination of finished goods. Used for customs, compliance, and logistics planning.. Valid values are `^[A-Z]{3}$`',
    `incoterms` STRING COMMENT 'Incoterms code defining the division of costs and risks between buyer and seller. FOB (Free on Board) is common in apparel manufacturing.. Valid values are `EXW|FOB|CIF|DDP|DAP|FCA`',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, production requirements, or coordination details for this work order.',
    `ordered_quantity` STRING COMMENT 'Total quantity of units authorized for production in this work order. Represents the target production volume.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the factory for this work order (e.g., 30% deposit, 70% on shipment). Defines cash flow and financial settlement.',
    `priority` STRING COMMENT 'Business priority level for production scheduling. Critical orders receive expedited processing and resource allocation.. Valid values are `critical|high|normal|low`',
    `produced_quantity` STRING COMMENT 'Actual quantity completed and confirmed through production execution. Updated as production progresses and goods are received.',
    `production_end_date` DATE COMMENT 'Planned or actual date when production execution is completed. Marks readiness for final inspection and shipment preparation.',
    `production_start_date` DATE COMMENT 'Planned or actual date when production execution begins at the factory. Key milestone in Time and Action (TNA) calendar.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for this work order. Passed status is required before goods can be shipped.. Valid values are `pending|in_progress|passed|failed|conditional`',
    `rejected_quantity` STRING COMMENT 'Quantity rejected during quality inspection. Represents units that failed quality standards and cannot be shipped.',
    `requested_delivery_date` DATE COMMENT 'Date by which the customer or distribution center requires delivery of finished goods. Drives production scheduling and logistics planning.',
    `sap_pp_order_number` STRING COMMENT 'SAP S/4HANA PP module production order number. System of record identifier linking this work order to the ERP production planning system.. Valid values are `^[0-9]{10}$`',
    `shipping_mode` STRING COMMENT 'Primary transportation mode for delivering finished goods from factory to destination. Impacts lead time and logistics cost.. Valid values are `air|ocean|truck|rail|courier`',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific color-size combination being manufactured. Represents the sellable unit at retail.. Valid values are `^[A-Z0-9]{8,15}$`',
    `target_ex_factory_date` DATE COMMENT 'Target date for goods to leave the factory. Critical milestone for logistics planning and On Time In Full (OTIF) performance measurement.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total manufacturing cost for this work order (unit cost × ordered quantity). Represents the Cost of Goods Sold (COGS) for this production run.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for manufacturing this work order. Includes CMT charges, materials (if applicable), and factory overhead. Used for COGS calculation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields in this work order. Typically pieces for apparel manufacturing.. Valid values are `pieces|units|pairs|dozens|cartons`',
    `updated_by` STRING COMMENT 'User ID or name of the person who last modified this work order. Audit trail for change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order record was last modified. Audit trail for record changes.',
    `work_order_number` STRING COMMENT 'Externally-known business identifier for the work order. Human-readable unique reference used across manufacturing systems and communications with factory partners.. Valid values are `^WO-[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order. Tracks progression from initial creation through production execution to final closure. [ENUM-REF-CANDIDATE: draft|released|confirmed|in_progress|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User ID or name of the person who created this work order. Audit trail for accountability.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core manufacturing work order authorizing production of a specific quantity of a style/SKU at a designated factory. Captures work order number, style reference, factory assignment, ordered and confirmed quantities, production start/end dates, CMT type (Cut/Make/Trim), status lifecycle (draft → released → in-progress → completed → closed), SAP PP order number, season, collection, priority, customer PO reference, and target ex-factory date. SSOT for all bulk production execution instructions. Links downstream to operations, confirmations, cut orders, T&A milestones, and production lots.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` (
    `work_order_operation_id` BIGINT COMMENT 'Unique identifier for the work order operation. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual operations require cost center assignment for activity-based costing, labor cost allocation by department, and detailed production cost variance analysis—standard in apparel manufacturing c',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or worker who performed or is assigned to this operation. Used for performance tracking and labor management.',
    `tertiary_work_confirmed_by_user_employee_id` BIGINT COMMENT 'System user ID of the person who confirmed the operation completion in the ERP system.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center (production resource or machine) where this operation is performed. Links to factory floor resources.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order that contains this operation. Links this operation to the overall production order.',
    `actual_duration_minutes` DECIMAL(18,2) COMMENT 'Actual time taken to complete this operation, measured in minutes. Used to calculate efficiency variance against SAM.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the operation execution was completed on the factory floor, captured from production confirmation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the operation execution began on the factory floor, captured from production confirmation.',
    `confirmation_number` STRING COMMENT 'Unique confirmation document number generated when the operation is confirmed in the system, linking to goods movement and time confirmation.. Valid values are `^[0-9]{10}$`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the operation was confirmed in the system, marking the official completion record.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of units successfully processed and confirmed for this operation. Used to track production progress and yield.',
    `control_key` STRING COMMENT 'SAP control key that determines how the operation is processed, including scheduling, costing, and confirmation requirements (e.g., PP01, PP02, PP03).. Valid values are `^[A-Z0-9]{2,4}$`',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the operation cost amount (e.g., USD, EUR, CNY, INR, BDT).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this operation record was first created in the system, typically when the work order was released.',
    `efficiency_percentage` DECIMAL(18,2) COMMENT 'Operation efficiency calculated as (standard_allowed_minutes / actual_duration_minutes) * 100. Measures operator and work center performance against standard.',
    `factory_location_code` STRING COMMENT 'Three-letter code identifying the manufacturing facility or factory where this operation is performed (e.g., BDH for Bangladesh Dhaka, CNS for China Shenzhen).. Valid values are `^[A-Z]{3}$`',
    `inspection_lot_number` STRING COMMENT 'Quality inspection lot number assigned to this operation for tracking quality control results and defects.. Valid values are `^[0-9]{10,12}$`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether quality inspection is required after completing this operation. True if inspection is mandatory, False otherwise.',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours consumed for this operation, including direct production time, setup, and teardown. Used for labor costing and capacity analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this operation record was last updated in the system, tracking the most recent change to any field.',
    `machine_hours` DECIMAL(18,2) COMMENT 'Total machine or equipment hours utilized for this operation. Used for machine costing and utilization tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about this operation, including special instructions, issues encountered, or deviations from standard process.',
    `operation_code` STRING COMMENT 'Standardized code identifying the type of manufacturing operation (e.g., CUT, SEW, FINISH, PRESS, PACK, INSPECT, EMBROIDER, PRINT).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `operation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this operation, including labor, machine, overhead, and material costs. Used for production costing and variance analysis.',
    `operation_description` STRING COMMENT 'Detailed textual description of the manufacturing operation, including specific instructions, techniques, or requirements for execution.',
    `operation_number` STRING COMMENT 'The unique operation number within the routing sequence, typically a 4-digit code (e.g., 0010, 0020, 0030) that defines the order of manufacturing steps.. Valid values are `^[0-9]{4}$`',
    `operation_sequence` STRING COMMENT 'Sequential order of this operation within the work order routing. Determines the execution order of manufacturing steps.',
    `operation_status` STRING COMMENT 'Current lifecycle status of the manufacturing operation indicating its execution state in the production workflow. [ENUM-REF-CANDIDATE: planned|released|in_progress|completed|confirmed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `planned_end_date` DATE COMMENT 'Scheduled date when this operation is planned to be completed based on standard times and production scheduling.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Target quantity of units planned to be processed in this operation based on the work order requirements.',
    `planned_start_date` DATE COMMENT 'Scheduled date when this operation is planned to begin execution based on production scheduling and capacity planning.',
    `production_line` STRING COMMENT 'Identifier for the production line or assembly line where this operation is executed. Used for line balancing and capacity planning.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `quality_status` STRING COMMENT 'Quality inspection result status for this operation indicating whether output meets quality standards.. Valid values are `not_inspected|passed|failed|conditional|pending`',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Quantity of units requiring rework or reprocessing due to quality issues identified during or after this operation.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Quantity of units rejected or scrapped during this operation due to quality defects or production errors.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Time required to prepare the work center, tools, and materials before starting production for this operation, measured in minutes.',
    `shift_code` STRING COMMENT 'Production shift during which this operation was executed. Used for shift performance analysis and labor scheduling.. Valid values are `SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|OVERTIME`',
    `standard_allowed_minutes` DECIMAL(18,2) COMMENT 'Standard time allocated for completing this operation per unit, measured in minutes. Used for capacity planning, costing, and efficiency measurement in apparel manufacturing.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Time required to clean up, reset, or prepare the work center for the next operation after completing this operation, measured in minutes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities in this operation (EA=Each, PC=Piece, DZ=Dozen, PR=Pair, SET=Set, KG=Kilogram, M=Meter, YD=Yard). [ENUM-REF-CANDIDATE: EA|PC|DZ|PR|SET|KG|M|YD — 8 candidates stripped; promote to reference product]',
    `yield_percentage` DECIMAL(18,2) COMMENT 'Percentage of good output relative to input for this operation, calculated as (confirmed_quantity / planned_quantity) * 100. Key metric for production efficiency.',
    CONSTRAINT pk_work_order_operation PRIMARY KEY(`work_order_operation_id`)
) COMMENT 'Individual manufacturing operation or routing step within a work order, representing each discrete production activity (cutting, sewing, finishing, pressing, packing). Captures operation sequence number, operation code, work center, standard time (SAM — Standard Allowed Minutes), actual time, planned quantity, confirmed quantity, operation status, and yield percentage. Derived from SAP PP routing operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` (
    `order_confirmation_id` BIGINT COMMENT 'Unique identifier for the production order confirmation record. Primary key for the goods confirmation transaction.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which labor and overhead costs from this confirmation are allocated. Used for management accounting.',
    `material_id` BIGINT COMMENT 'Reference to the finished good or semi-finished material being produced in this operation. Links to the product master data.',
    `employee_id` BIGINT COMMENT 'Reference to the production operator or worker who performed and confirmed this operation. Used for labor tracking and performance management.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or plant where this production confirmation occurred. Used for multi-site production tracking.',
    `reversed_confirmation_order_confirmation_id` BIGINT COMMENT 'Reference to the original confirmation record that this reversal transaction is cancelling. Creates audit trail for corrections.',
    `work_center_id` BIGINT COMMENT 'Reference to the manufacturing work center or production line where this operation was executed. Represents the physical production resource.',
    `work_order_id` BIGINT COMMENT 'Reference to the production work order against which this confirmation is recorded. Links to the manufacturing order being executed.',
    `work_order_operation_id` BIGINT COMMENT 'Reference to the specific operation within the work order routing that this confirmation applies to. Represents a discrete manufacturing step.',
    `activity_type_code` STRING COMMENT 'Classification of the production activity performed during this operation. Used for activity-based costing and capacity planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'The total number of labor hours consumed to complete this operation. Used for labor cost calculation and capacity planning.',
    `actual_machine_hours` DECIMAL(18,2) COMMENT 'The total number of machine or equipment hours utilized during this operation. Used for equipment utilization analysis and maintenance scheduling.',
    `backflush_indicator` BOOLEAN COMMENT 'Indicates whether component materials were automatically consumed via backflushing when this confirmation was posted. Used for automated material consumption.',
    `batch_number` STRING COMMENT 'The production batch or lot number assigned to the output from this confirmation. Used for traceability and quality control.. Valid values are `^[A-Z0-9]{6,15}$`',
    `confirmation_date` DATE COMMENT 'The calendar date on which the production activity was completed and confirmed. Represents the actual manufacturing event date.',
    `confirmation_number` STRING COMMENT 'Business-facing confirmation document number generated by the production system. Used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{8,12}$`',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the confirmation record indicating whether it is in draft, submitted for approval, posted to inventory, cancelled, or reversed.. Valid values are `draft|submitted|posted|cancelled|reversed`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the confirmation transaction was recorded in the system. Used for audit trail and real-time production tracking.',
    `confirmation_type` STRING COMMENT 'Classification of the confirmation transaction indicating whether this is a partial completion, final completion, milestone achievement, rework confirmation, or scrap reporting.. Valid values are `partial|final|milestone|rework|scrap`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was first created in the database. Used for audit trail and data lineage.',
    `final_confirmation_indicator` BOOLEAN COMMENT 'Indicates whether this is the final confirmation for the operation, signaling that no further output is expected and the operation can be closed.',
    `goods_movement_posted` BOOLEAN COMMENT 'Indicates whether the confirmed quantities have been posted to inventory through a goods receipt transaction. Links confirmation to inventory update.',
    `goods_receipt_number` STRING COMMENT 'The material document number generated when confirmed output was posted to inventory. Used for inventory reconciliation and traceability.. Valid values are `^[A-Z0-9]{8,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this confirmation record was last updated. Used for change tracking and audit purposes.',
    `posting_date` DATE COMMENT 'The accounting date on which the confirmation was posted to inventory and financial ledgers. May differ from confirmation date for period-end adjustments.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether this confirmation triggers a mandatory quality inspection before the output can be moved to finished goods inventory.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection associated with this confirmation. Determines whether output can be released to inventory.. Valid values are `pending|passed|failed|waived|not_required`',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this confirmation has been reversed or cancelled. Used to track corrections and adjustments to previously posted confirmations.',
    `rework_quantity` DECIMAL(18,2) COMMENT 'The quantity of units that require rework or reprocessing to meet quality standards. Represents non-conforming output that can be salvaged.',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or units that were scrapped or rejected during this production operation due to defects or quality failures.',
    `setup_time_hours` DECIMAL(18,2) COMMENT 'The time spent preparing equipment, tooling, and materials before production could begin. Separate from actual production time.',
    `shift_code` STRING COMMENT 'The production shift during which this confirmation was recorded. Used for shift-based performance analysis and labor scheduling.. Valid values are `^[A-Z0-9]{1,4}$`',
    `teardown_time_hours` DECIMAL(18,2) COMMENT 'The time spent cleaning, resetting, or breaking down equipment after the production operation was completed.',
    `unit_of_measure` STRING COMMENT 'The standard unit in which quantities are measured and reported for this confirmation. Common values include EA (each), PC (piece), KG (kilogram), M (meter).. Valid values are `^[A-Z]{2,3}$`',
    `variance_notes` STRING COMMENT 'Free-text explanation providing additional context about production variances, quality issues, or operational challenges encountered during this confirmation.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any variance between planned and actual quantities or times. Used for root cause analysis of production inefficiencies.. Valid values are `^[A-Z0-9]{2,6}$`',
    `yield_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of good output produced and confirmed for this operation. Represents conforming units that passed quality inspection.',
    CONSTRAINT pk_order_confirmation PRIMARY KEY(`order_confirmation_id`)
) COMMENT 'Goods confirmation event recording actual output quantities, scrap, rework, and labor hours against a work order operation. Captures confirmation date, confirmed yield quantity, scrap quantity, rework quantity, actual machine time, actual labor time, shift, operator ID, and confirmation type (partial, final). Represents the SAP PP goods confirmation transaction (CO11N/CO15).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`production_factory` (
    `production_factory_id` BIGINT COMMENT 'Unique identifier for the manufacturing facility. Primary key for the factory entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Factories operate as cost centers for overhead allocation, factory performance analysis, and manufacturing cost tracking—fundamental to apparel manufacturing accounting and factory profitability analy',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Factories require operational managers for production oversight, capacity planning, compliance audits, and vendor relationship management. Links factory operations to internal employee accountability ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Factories map to profit centers for regional/brand P&L segmentation in multi-brand apparel operations, enabling factory-level margin analysis and strategic sourcing decisions.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the factory is currently active and available for new production orders. Inactive factories are retained for historical reference but excluded from sourcing and planning.',
    `address_line_1` STRING COMMENT 'Primary street address of the factory facility. Used for shipping, audits, and official correspondence.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building name, floor, or suite number.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score from the most recent audit, typically on a 0-100 scale. Used for factory performance benchmarking and risk assessment.',
    `certified_capacity_units_per_week` STRING COMMENT 'Maximum production capacity in units per week as certified by the factory and validated through capacity audits. Used for production planning and allocation decisions.',
    `city` STRING COMMENT 'City or municipality where the factory is located. Used for logistics planning and regional risk assessment.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the factory is located. Used for duty calculation, trade compliance, and origin marking requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory record was first created in the system. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for pricing and invoicing with this factory (e.g., USD, EUR, CNY, BDT, VND).. Valid values are `^[A-Z]{3}$`',
    `email_address` STRING COMMENT 'Primary email address for factory communications, Purchase Order (PO) transmission, and Time and Action (TNA) updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_count` STRING COMMENT 'Total number of employees working at the factory. Used for capacity assessment, social compliance monitoring, and risk evaluation.',
    `facility_size_sqm` STRING COMMENT 'Total floor area of the factory in square meters. Used for capacity planning and facility assessment.',
    `factory_code` STRING COMMENT 'Externally-known unique business identifier for the factory, used across systems and documentation. Typically alphanumeric code assigned during factory onboarding.. Valid values are `^[A-Z0-9]{4,12}$`',
    `factory_name` STRING COMMENT 'Common business name of the manufacturing facility as used in operational communications and planning.',
    `factory_type` STRING COMMENT 'Classification of the manufacturing relationship model. CMT (Cut Make Trim) = factory provides labor only; OEM (Original Equipment Manufacturer) = factory manufactures to buyer specs; ODM (Original Design Manufacturer) = factory provides design and manufacturing; INTERNAL = company-owned facility; HYBRID = mixed model; SUBCONTRACTOR = secondary tier supplier.. Valid values are `CMT|OEM|ODM|INTERNAL|HYBRID|SUBCONTRACTOR`',
    `incoterm` STRING COMMENT 'Standard International Commercial Terms (Incoterms) used for shipments from this factory. Defines responsibility for shipping costs, insurance, and risk transfer. FOB (Free on Board) is most common in apparel. [ENUM-REF-CANDIDATE: EXW|FOB|FCA|CIF|DDP|DAP|CPT|CIP — 8 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or quality audit conducted at the factory. Used to track audit recency and schedule follow-up audits.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from Purchase Order (PO) confirmation to ex-factory shipment readiness. Used in Time and Action (TNA) calendar planning.',
    `legal_entity_name` STRING COMMENT 'Official registered legal name of the factory entity as it appears on contracts, licenses, and regulatory filings.',
    `moq_units` STRING COMMENT 'Minimum Order Quantity in units that the factory requires per style or per order to accept production. Critical for buy plan feasibility and allocation planning.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance or quality audit. Used for audit planning and vendor compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional factory information, special handling instructions, strategic notes, or historical context not captured in structured fields.',
    `onboarding_date` DATE COMMENT 'Date when the factory was approved and onboarded into the companys vendor network. Used for relationship tenure analysis and vendor lifecycle tracking.',
    `otif_performance_pct` DECIMAL(18,2) COMMENT 'Percentage of orders delivered On Time In Full over the trailing 12 months. Key performance indicator for factory reliability and used in allocation decisions.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the factory (e.g., Net 30, Net 60, Letter of Credit (LC), 30% deposit + 70% on shipment). Used for cash flow planning and Purchase Order (PO) processing.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the factory. Used for operational coordination and emergency communication.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the factory location. Used for logistics and regional analysis.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this factory has preferred vendor status based on performance, quality, compliance, and strategic relationship. Preferred vendors receive priority allocation and longer-term commitments.',
    `production_capabilities` STRING COMMENT 'Comma-separated list of product categories and manufacturing techniques the factory is equipped to produce (e.g., woven, knit, denim, footwear, accessories, leather goods, outerwear, activewear, swimwear, intimate apparel).',
    `quality_rating` STRING COMMENT 'Letter grade quality rating based on defect rates, inspection results, and customer returns. A = excellent (defect rate <1%), B = good (1-2%), C = acceptable (2-4%), D = needs improvement (4-6%), F = unacceptable (>6%).. Valid values are `A|B|C|D|F`',
    `risk_rating` STRING COMMENT 'Overall risk classification for the factory based on compliance history, audit findings, geographic risk, and operational stability. Used for sourcing decisions and monitoring frequency.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the factory is located. Used for regional compliance and logistics routing.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite sustainability score (0-100) based on environmental practices, energy efficiency, waste management, water usage, and chemical compliance. Used for ESG reporting and sustainable sourcing initiatives.',
    `termination_date` DATE COMMENT 'Date when the business relationship with the factory was terminated or the factory was deactivated. Null for active factories.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the factory location (e.g., Asia/Shanghai, Asia/Dhaka, Europe/Istanbul). Used for scheduling meetings, coordinating shipments, and Time and Action (TNA) planning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory record was last modified. Used for change tracking and data freshness monitoring.',
    CONSTRAINT pk_production_factory PRIMARY KEY(`production_factory_id`)
) COMMENT 'Master record for each manufacturing facility (CMT factory, OEM, ODM) engaged in production. Captures factory code, factory name, legal entity name, country, city, address, factory type (CMT/OEM/ODM/internal), production capabilities (woven, knit, denim, footwear, accessories), certified capacity (units/week), compliance certifications (WRAP, BSCI, FLA, OEKO-TEX, SA8000), audit status, lead time profile, minimum order quantity, and active flag. SSOT for factory identity within the production domain; supplier domain owns the broader vendor relationship and commercial terms.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` (
    `factory_capacity_id` BIGINT COMMENT 'Unique identifier for the factory capacity planning record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Capacity planning ties to factory overhead budgets for resource allocation decisions, enabling capacity cost planning and factory investment budget tracking in apparel manufacturing operations.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Capacity planning by product category (knits vs wovens, footwear vs apparel) reflects different machine/skill requirements. Enables category-level capacity allocation and booking. Removes denormalized',
    `production_factory_id` BIGINT COMMENT 'Identifier of the manufacturing facility or CMT (Cut Make Trim) partner to which this capacity plan applies.',
    `season_id` BIGINT COMMENT 'Identifier of the merchandise season for which capacity is reserved or allocated.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Factory capacity is often planned and tracked at the work center or production line level. The table currently has production_line_id (STRING) but no formal FK to work_center. Adding work_center_id en',
    `allocated_capacity_units` DECIMAL(18,2) COMMENT 'Production capacity units already allocated to confirmed purchase orders (PO) or work orders during the planning period.',
    `approved_by` STRING COMMENT 'Name or identifier of the production planner or manager who approved this capacity plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity plan was approved for execution.',
    `available_capacity_units` DECIMAL(18,2) COMMENT 'Remaining production capacity units available for new bookings, calculated as total capacity minus allocated and reserved capacity.',
    `available_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours available for production during the planning period, based on workforce headcount and shift schedules.',
    `available_machine_hours` DECIMAL(18,2) COMMENT 'Total machine hours available for production during the planning period, accounting for scheduled maintenance and downtime.',
    `booking_cutoff_date` DATE COMMENT 'Last date by which new production orders can be booked for this capacity period.',
    `booking_status` STRING COMMENT 'Current booking status of the capacity period, indicating whether additional orders can be accepted.. Valid values are `open|partially_booked|fully_booked|overbooked|closed`',
    `capacity_allocation_priority` STRING COMMENT 'Priority level for capacity allocation, used to manage competing demands from multiple customers or product lines.. Valid values are `high|medium|low`',
    `capacity_buffer_percent` DECIMAL(18,2) COMMENT 'Safety buffer percentage applied to capacity planning to account for variability, quality issues, or unexpected delays.',
    `capacity_status` STRING COMMENT 'Operational status of the factory or production line during the planning period.. Valid values are `active|inactive|suspended|maintenance|holiday`',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure used to express production capacity (e.g., pieces, garments, dozens, pairs).. Valid values are `pieces|garments|dozens|units|pairs`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity planning record was first created in the system.',
    `department_code` STRING COMMENT 'Manufacturing department or process stage to which this capacity allocation applies (e.g., cutting, sewing, finishing). [ENUM-REF-CANDIDATE: cutting|sewing|finishing|packing|embroidery|printing|dyeing|quality_control — 8 candidates stripped; promote to reference product]',
    `efficiency_rate_percent` DECIMAL(18,2) COMMENT 'Factory or production line efficiency rate as a percentage, representing actual output versus theoretical maximum capacity.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this capacity plan is currently active and in use for production scheduling.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from order confirmation to shipment for orders booked in this capacity period.',
    `machine_count` STRING COMMENT 'Total number of production machines or equipment units available during the planning period.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity (MOQ) in units that the factory requires for accepting new production bookings during this period.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding capacity constraints, special conditions, or planning assumptions for this period.',
    `overtime_hours_available` DECIMAL(18,2) COMMENT 'Additional overtime hours available for production if needed to meet demand during the planning period.',
    `planned_downtime_hours` DECIMAL(18,2) COMMENT 'Total hours of planned downtime for maintenance, changeovers, or scheduled breaks during the planning period.',
    `planning_period_end_date` DATE COMMENT 'End date of the capacity planning period (weekly or monthly bucket).',
    `planning_period_start_date` DATE COMMENT 'Start date of the capacity planning period (weekly or monthly bucket).',
    `planning_period_type` STRING COMMENT 'Granularity of the capacity planning period (daily, weekly, or monthly).. Valid values are `weekly|monthly|daily`',
    `reserved_capacity_units` DECIMAL(18,2) COMMENT 'Production capacity units reserved for specific seasons, collections, or customers but not yet confirmed by purchase order.',
    `shift_count` STRING COMMENT 'Number of production shifts per day during the planning period (e.g., 1, 2, or 3 shifts).',
    `standard_minute_value` DECIMAL(18,2) COMMENT 'Average standard minute value (SMV) per unit for the product mix planned during this capacity period, used for capacity calculation.',
    `total_capacity_units` DECIMAL(18,2) COMMENT 'Total production capacity expressed in units (pieces, garments, or SKUs) that can be manufactured during the planning period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity planning record was last modified.',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Capacity utilization rate as a percentage, calculated as allocated capacity divided by total available capacity.',
    `version_number` STRING COMMENT 'Version number of the capacity plan, incremented with each revision to support change tracking and audit trail.',
    `workforce_headcount` STRING COMMENT 'Total number of production workers assigned to the factory or production line during the planning period.',
    `working_days` STRING COMMENT 'Number of working days available during the planning period, excluding holidays and factory closures.',
    CONSTRAINT pk_factory_capacity PRIMARY KEY(`factory_capacity_id`)
) COMMENT 'Weekly or monthly capacity plan and reservation record for a factory, capturing available machine hours, labor hours, allocated capacity (units), reserved capacity by season/booking, efficiency rate, utilization percentage, and booking status by production line or department. Supports OTB capacity planning, T&A scheduling, forward capacity booking, and load balancing across manufacturing partners.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the production schedule record. Primary key for the master production schedule (MPS) entity.',
    `delivery_window_id` BIGINT COMMENT 'Reference to the target delivery window or time bucket for finished goods. Aligns production schedule with retail distribution calendar and store delivery requirements.',
    `employee_id` BIGINT COMMENT 'Reference to the production planner responsible for this schedule. Identifies the person accountable for schedule creation and maintenance.',
    `factory_capacity_id` BIGINT COMMENT 'Foreign key linking to production.factory_capacity. Business justification: Production schedules allocate capacity from factory capacity plans. The MPS (Master Production Schedule) record should reference the specific capacity plan/slot it is consuming. This enables capacity ',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility where production is scheduled. Identifies the factory partner or internal plant assigned to execute this production run.',
    `production_line_id` BIGINT COMMENT 'Reference to the specific production line or work center within the factory allocated for this schedule. Represents the capacity slot assignment.',
    `season_id` BIGINT COMMENT 'Reference to the fashion season or collection period this production schedule supports. Links schedule to merchandising calendar for seasonal product delivery.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Production schedules reference design sketches for visual production planning boards, design-driven scheduling, and design complexity-based capacity allocation. Enables design-aware production plannin',
    `work_order_id` BIGINT COMMENT 'Reference to the work order being scheduled. Links this schedule record to the production work order that defines what is being manufactured.',
    `actual_cut_date` DATE COMMENT 'Actual date when fabric cutting operations began. Used for On-Time In-Full (OTIF) performance tracking and schedule variance analysis.',
    `actual_ex_factory_date` DATE COMMENT 'Actual date when finished goods left the factory. Critical for OTIF performance measurement and supply chain delivery tracking.',
    `actual_finishing_date` DATE COMMENT 'Actual date when finishing operations completed. Used for quality gate tracking and final production milestone confirmation.',
    `actual_sew_end_date` DATE COMMENT 'Actual date when sewing operations completed. Used for cycle time analysis and production efficiency measurement.',
    `actual_sew_start_date` DATE COMMENT 'Actual date when sewing operations commenced. Used for production milestone tracking and factory performance measurement.',
    `change_reason` STRING COMMENT 'Business reason for the most recent schedule change or revision. Captures rationale for date shifts, quantity adjustments, or factory reassignments to support root cause analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production schedule record was first created in the system. Used for audit trail and schedule age analysis.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this schedule is on the critical path for seasonal delivery. True for schedules with no slack time that directly impact retail delivery deadlines.',
    `factory_capacity_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of factory production line capacity consumed by this schedule. Used for capacity planning and factory loading optimization.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who most recently updated this production schedule record. Used for accountability and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this production schedule record was most recently updated. Used for change tracking and data freshness monitoring.',
    `lead_time_days` STRING COMMENT 'Total number of days from cut date to ex-factory date. Represents the complete production cycle time for this schedule.',
    `locked_by` STRING COMMENT 'User identifier of the planner or manager who locked this schedule. Locked schedules are committed to factory and cannot be changed without approval.',
    `locked_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was locked. Marks the point when the schedule became committed and change-controlled.',
    `notes` STRING COMMENT 'Free-text notes and comments about this production schedule. Captures special instructions, constraints, or coordination details for factory partners.',
    `otif_target_flag` BOOLEAN COMMENT 'Indicates whether this schedule met the On-Time In-Full (OTIF) delivery target. True if actual ex-factory date matched planned date and full quantity was delivered.',
    `planned_cut_date` DATE COMMENT 'Scheduled date for fabric cutting operations to begin. First milestone in the Cut-Make-Trim (CMT) production process, marking when raw materials are cut into garment pieces.',
    `planned_ex_factory_date` DATE COMMENT 'Scheduled date for finished goods to leave the factory. Critical milestone for Free On Board (FOB) shipment and supply chain handoff to logistics partners.',
    `planned_finishing_date` DATE COMMENT 'Scheduled date for finishing operations including washing, pressing, quality inspection, and packaging. Final production milestone before ex-factory shipment.',
    `planned_sew_end_date` DATE COMMENT 'Scheduled date for sewing operations to complete. Marks the end of garment assembly before finishing operations begin.',
    `planned_sew_start_date` DATE COMMENT 'Scheduled date for sewing operations to commence. Marks the beginning of garment assembly on the production line.',
    `planning_group` STRING COMMENT 'Planning group or team responsible for this schedule. Used for workload distribution and organizational reporting.',
    `priority_level` STRING COMMENT 'Priority classification for production scheduling and resource allocation. Rush and urgent priorities receive expedited handling and preferential capacity allocation.. Valid values are `low|medium|high|urgent|rush`',
    `production_method` STRING COMMENT 'Manufacturing model for this production schedule. Cut-Make-Trim (CMT) is contract manufacturing, Free On Board (FOB) is full-package manufacturing, Original Design Manufacturer (ODM) provides design and manufacturing, Original Equipment Manufacturer (OEM) manufactures to buyer specifications, and in-house is internal production.. Valid values are `cmt|fob|odm|oem|in_house`',
    `production_type` STRING COMMENT 'Classification of production run type. Pre-production (PP) samples are for approval, bulk production is main volume manufacturing, pilot runs are small test batches, and reorders are repeat production of proven styles.. Valid values are `bulk|pre_production|sample|pilot|reorder`',
    `schedule_number` STRING COMMENT 'Business identifier for the production schedule record. Human-readable schedule number used in communications with factory partners and internal planning teams.. Valid values are `^MPS-[0-9]{8}-[A-Z0-9]{6}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the production schedule. Draft schedules are under planning, confirmed schedules are committed to factory, locked schedules cannot be changed, in-progress schedules are actively executing, completed schedules are finished, cancelled schedules are voided, and on-hold schedules are temporarily suspended. [ENUM-REF-CANDIDATE: draft|confirmed|locked|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `scheduled_quantity` STRING COMMENT 'Total quantity of units scheduled for production in this schedule record. Represents the planned output volume for the production run.',
    `version` STRING COMMENT 'Version number of this schedule record. Increments with each revision to track schedule changes and maintain audit trail of planning iterations.',
    `change_date` DATE COMMENT 'Date when the most recent schedule change was made. Used for change frequency analysis and schedule stability measurement.',
    `created_by` STRING COMMENT 'User identifier of the person who created this production schedule record. Used for accountability and audit purposes.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Master production schedule (MPS) record linking work orders to factory capacity slots, defining planned cut dates, sew start dates, sew end dates, finishing dates, and ex-factory dates by production line. Captures schedule version, schedule status (draft, confirmed, locked), season, delivery window, critical path flags, and schedule change reason. Supports T&A calendar management, on-time delivery tracking (OTIF), and weekly production planning meetings with factory partners.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` (
    `production_tna_milestone_id` BIGINT COMMENT 'Unique identifier for the Time and Action milestone record. Primary key for tracking critical production lifecycle events.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Critical TNA milestones (fabric approval, sample approval, shipment authorization) require buyer contact approval in B2B workflows. Linking enables approval routing, notification, and compliance track',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: TNA tracks concept approval milestones, concept review gates, and concept-to-sketch transition events for collection development timeline management. Enables concept-phase critical path tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the specific party (factory, supplier, vendor, team) responsible for executing this milestone. Links to the appropriate master data entity based on responsible_party_type.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing factory or production facility where this milestone is executed. Critical for factory performance analysis and capacity planning.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: TNA (Time and Action) milestones include regulatory filing deadlines (customs declarations, import permits, certificates of origin). Links production timeline to compliance filing requirements - criti',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: TNA milestones track design sketch approval gates, design handoff events, and design revision completion in the critical path. Essential for design-phase timeline management.',
    `style_id` BIGINT COMMENT 'Reference to the product style or design this milestone tracks. Enables milestone tracking at the style level across multiple production runs.',
    `work_order_id` BIGINT COMMENT 'Reference to the production work order or manufacturing order this milestone belongs to. Links milestone to the production execution context.',
    `actual_date` DATE COMMENT 'The actual date when the milestone was achieved or completed. Used for OTIF (On Time In Full) performance measurement and variance analysis.',
    `actual_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the milestone was completed, including time of day. Provides granular tracking for time-sensitive milestones and shift-level analysis.',
    `approval_date` DATE COMMENT 'Date when the milestone was formally approved. Null if approval is not required or not yet approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Flag indicating whether this milestone requires formal approval before proceeding to the next stage (e.g., PP sample approval, fabric approval). True if approval gate exists.',
    `approval_status` STRING COMMENT 'Status of the approval process for this milestone if approval is required. Indicates whether approval is pending, approved, rejected, or conditionally approved. Not_required if no approval needed.. Valid values are `not_required|pending_approval|approved|rejected|conditional_approval`',
    `comments` STRING COMMENT 'Free-text comments or notes about this milestone execution. Captures additional context, issues, or observations from the responsible party or production team.',
    `days_variance` STRING COMMENT 'Number of days difference between planned (or revised) date and actual date. Positive values indicate delay, negative values indicate early completion. Key metric for OTIF performance.',
    `delay_reason_code` STRING COMMENT 'Standardized code indicating the reason for milestone delay if the milestone was not achieved on time. Used for root cause analysis and process improvement. Null if milestone was on time.',
    `delay_reason_description` STRING COMMENT 'Detailed description or notes explaining the reason for the delay. Provides context beyond the standardized delay reason code. Null if milestone was on time.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination market of this production order. Used for logistics milestone tracking and country-specific lead time analysis.. Valid values are `^[A-Z]{3}$`',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this milestone record is currently active and relevant. False if the milestone was cancelled or superseded by a revised plan.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether this milestone is on the critical path for the production schedule. True if any delay to this milestone will delay the overall ex-factory date.',
    `is_customer_visible` BOOLEAN COMMENT 'Flag indicating whether this milestone is visible to the customer or buyer in external milestone tracking reports. True for customer-facing milestones like PP sample approval and ex-factory.',
    `milestone_sequence` STRING COMMENT 'Sequential order of this milestone within the production lifecycle for the work order or style. Used to establish the chronological flow of production events.',
    `milestone_status` STRING COMMENT 'Current execution status of the milestone. Indicates whether the milestone is pending, in-progress, completed, overdue, cancelled, or on hold.. Valid values are `pending|in_progress|completed|overdue|cancelled|on_hold`',
    `milestone_type` STRING COMMENT 'The type of production milestone being tracked. Defines the specific critical event in the Time and Action calendar (fabric approval, PP sample submission/approval, bulk fabric receipt, cut start, sew start, finishing, QC inspection, ex-factory, cargo receipt). [ENUM-REF-CANDIDATE: fabric_approval|pp_sample_submission|pp_sample_approval|bulk_fabric_receipt|cut_start|sew_start|finishing_start|qc_inspection|ex_factory|cargo_receipt — 10 candidates stripped; promote to reference product]',
    `planned_date` DATE COMMENT 'Original planned date for achieving this milestone as defined in the initial Time and Action calendar. Baseline for measuring schedule adherence.',
    `purchase_order_number` STRING COMMENT 'External purchase order number from the buyer or customer associated with this production milestone. Used for customer-facing milestone reporting.',
    `quantity_at_milestone` DECIMAL(18,2) COMMENT 'The quantity of units (pieces, garments, SKUs) that reached this milestone. Enables tracking of partial completions and yield analysis across production stages.',
    `recorded_by` STRING COMMENT 'Name or identifier of the user or system that recorded this milestone completion. Provides audit trail for data entry accountability.',
    `recorded_timestamp` TIMESTAMP COMMENT 'Timestamp when this milestone record was created or updated in the system. Distinct from actual_timestamp which represents the real-world event time.',
    `responsible_party_name` STRING COMMENT 'Name of the party responsible for this milestone. Denormalized for reporting convenience and historical tracking even if party master data changes.',
    `responsible_party_type` STRING COMMENT 'The type of party responsible for completing this milestone (internal team, factory, supplier, vendor, logistics provider, quality agency). Categorizes accountability.. Valid values are `internal_team|factory|supplier|vendor|logistics_provider|quality_agency`',
    `revised_date` DATE COMMENT 'Updated target date for the milestone if the original plan was revised. Captures schedule adjustments due to delays, expedites, or other changes. Null if no revision occurred.',
    `season_code` STRING COMMENT 'The fashion season or collection code this milestone belongs to (e.g., SS24, FW24). Enables season-level milestone performance analysis.',
    `shipping_mode` STRING COMMENT 'The mode of transportation for shipment-related milestones (ex-factory, cargo receipt). Impacts lead time expectations and milestone planning.. Valid values are `air|sea|road|rail|courier`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity at milestone (pieces, units, dozens, cartons, pairs). Standardizes quantity reporting across different production contexts.. Valid values are `pieces|units|dozens|cartons|pairs`',
    CONSTRAINT pk_production_tna_milestone PRIMARY KEY(`production_tna_milestone_id`)
) COMMENT 'Time and Action (T&A) calendar milestone record tracking each critical event in the production lifecycle for a style or work order, including both planned and actual execution data. Captures milestone type (fabric approval, PP sample submission/approval, bulk fabric receipt, cut start, sew start, finishing, QC inspection, ex-factory, cargo receipt), planned date, revised date, actual date, actual timestamp, days variance, quantity at milestone, responsible party, milestone status (pending, in-progress, completed, overdue), delay reason code, and recorded-by reference. Core tool for production milestone tracking and OTIF performance measurement.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`pp_sample` (
    `pp_sample_id` BIGINT COMMENT 'Unique identifier for the pre-production sample record.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Pre-production samples undergo mandatory safety testing (lead content, phthalates, flammability) before bulk production approval. Direct 1:1 link between sample submission and test results - standard ',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or CMT (Cut Make Trim) partner that produced this sample.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Wholesale buyer contacts are the named individuals who review and approve samples. Linking to contact enables approval workflow routing, notification delivery, and audit trail of who approved what. re',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Pre-production samples are physical manifestations of specific design sketches for fit, construction, and aesthetic approval. Fundamental sample approval workflow linking design intent to physical val',
    `style_id` BIGINT COMMENT 'Reference to the parent style or product design that this sample represents.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: PP samples are submitted by vendors for pre-production approval. Vendor link required to track vendor sample approval rates, revision rounds, and sample lead time performance—key metrics in vendor sco',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: Pre-production samples are submitted to wholesale buyers for approval before bulk production. Linking samples to accounts enables account-specific sample tracking, approval workflow routing, and quali',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: PP (Pre-Production) samples are submitted for approval before bulk production begins. Once a work order is created for bulk production, linking the approved PP sample to the work order enables quality',
    `approval_date` DATE COMMENT 'Date when the sample received final approval or rejection decision.',
    `approval_status` STRING COMMENT 'Current approval state of the sample in the review workflow. [ENUM-REF-CANDIDATE: Submitted|Under Review|Approved|Approved with Comments|Rejected|Revision Required|Cancelled — 7 candidates stripped; promote to reference product]',
    `colorway_code` STRING COMMENT 'Code representing the specific color variant of the style for this sample.. Valid values are `^[A-Z0-9]{2,10}$`',
    `colorway_name` STRING COMMENT 'Descriptive name of the colorway (e.g., Navy Heather, Crimson Red).',
    `construction_approval_status` STRING COMMENT 'Specific approval decision for the construction dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `construction_comments` STRING COMMENT 'Consolidated feedback on the construction quality, stitching, and assembly of the sample.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was first created in the system.',
    `critical_issue_flag` BOOLEAN COMMENT 'Indicates whether the sample has critical defects that must be resolved before production (True = critical issues present, False = no critical issues).',
    `fabric_approval_status` STRING COMMENT 'Specific approval decision for the fabric dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `fabric_comments` STRING COMMENT 'Feedback on fabric quality, hand feel, color accuracy, and material performance.',
    `fit_approval_status` STRING COMMENT 'Specific approval decision for the fit dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `fit_comments` STRING COMMENT 'Consolidated feedback on the fit and sizing of the sample garment.',
    `issue_severity` STRING COMMENT 'Overall severity classification of issues found during sample review.. Valid values are `Critical|Major|Minor|None`',
    `labeling_approval_status` STRING COMMENT 'Specific approval decision for the labeling dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `labeling_comments` STRING COMMENT 'Feedback on care labels, brand labels, size tags, and regulatory labeling compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample record was last updated.',
    `overall_comments` STRING COMMENT 'General feedback and summary notes from the review team covering all aspects of the sample.',
    `packaging_approval_status` STRING COMMENT 'Specific approval decision for the packaging dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `packaging_comments` STRING COMMENT 'Feedback on packaging materials, folding, hangtags, and presentation.',
    `received_date` DATE COMMENT 'Date when the sample was physically received by the brand or design team for evaluation.',
    `resolution_status` STRING COMMENT 'Current status of issue resolution and corrective action implementation.. Valid values are `Open|In Progress|Resolved|Verified|Closed`',
    `review_due_date` DATE COMMENT 'Target date by which the sample review and approval decision must be completed.',
    `revision_round` STRING COMMENT 'Sequential number indicating which iteration of the sample this represents (1 = first submission, 2 = first revision, etc.).',
    `sample_cost` DECIMAL(18,2) COMMENT 'Cost incurred to produce this individual sample unit, typically charged by the factory.',
    `sample_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the sample cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `sample_number` STRING COMMENT 'Business identifier for the sample, typically assigned by the PLM or production system.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sample_type` STRING COMMENT 'Classification of the sample stage in the pre-production workflow (PP1 = first pre-production sample, PP2 = second pre-production sample, TOP = top of production, Salesman = sales sample, Photoshoot = marketing sample). [ENUM-REF-CANDIDATE: PP1|PP2|TOP|Salesman|Photoshoot|Size Set|Fit|Proto — 8 candidates stripped; promote to reference product]',
    `season_code` STRING COMMENT 'Code representing the fashion season or collection period (e.g., SS24 = Spring/Summer 2024, FW24 = Fall/Winter 2024).. Valid values are `^[A-Z]{2}[0-9]{2}$`',
    `size` STRING COMMENT 'Size of the sample garment (e.g., S, M, L, XL, or numeric sizing).',
    `submission_date` DATE COMMENT 'Date when the sample was submitted for review by the factory or supplier.',
    `target_production_date` DATE COMMENT 'Planned date for bulk production to commence following sample approval.',
    `tech_pack_version` STRING COMMENT 'Version number of the technical specification package that this sample was produced against.. Valid values are `^[0-9]+.[0-9]+$`',
    `trim_approval_status` STRING COMMENT 'Specific approval decision for the trim dimension of the sample.. Valid values are `Approved|Rejected|Needs Adjustment`',
    `trim_comments` STRING COMMENT 'Feedback on trims, accessories, buttons, zippers, and embellishments.',
    CONSTRAINT pk_pp_sample PRIMARY KEY(`pp_sample_id`)
) COMMENT 'Pre-Production (PP) sample master record tracking each sample submitted for approval during production development, including structured review feedback. Captures sample type (PP1, PP2, TOP, Salesman, Photoshoot), style reference, colorway, size, factory, submission/approval dates, approval status (submitted, approved, approved-with-comments, rejected), fit comments, construction comments, reviewer annotations by category (fit, construction, fabric, trim, labeling, packaging) with severity and resolution status, and revision round. Manages the complete PP sample approval workflow including feedback loops between design, technical, and factory teams.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` (
    `bulk_fabric_receipt_id` BIGINT COMMENT 'Unique identifier for the bulk fabric receipt record at the CMT factory. Primary key for this entity.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Fabric receipts must link to AP invoices for three-way matching (PO-GR-IR), accrual accuracy, and fabric cost verification—fundamental procurement accounting control in apparel manufacturing.',
    `material_id` BIGINT COMMENT 'Foreign key linking to product.material. Business justification: Fabric receipts track specific material articles for shade lot traceability, quality inspection, and BOM reconciliation. Removes denormalized fabric attributes (article_code, description, composition,',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this fabric was procured. Links the receipt to the upstream procurement transaction.',
    `production_factory_id` BIGINT COMMENT 'Reference to the CMT factory location where the fabric was received. Supports multi-factory production planning and inventory visibility.',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to compliance.restricted_substance. Business justification: Fabric receipts must be screened against Restricted Substance List (RSL) for banned chemicals. Apparel manufacturers check incoming fabric against specific restricted substances (formaldehyde, azo dye',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or mill that manufactured and supplied the fabric. Critical for supplier performance tracking and quality management.',
    `work_order_id` BIGINT COMMENT 'Reference to the production work order or bulk production run that this fabric receipt is intended to support. Enables production scheduling and material availability tracking.',
    `approved_for_production_date` DATE COMMENT 'The date on which the fabric was officially approved and released for use in production cutting. Gates the start of cutting operations.',
    `aql_inspection_result` STRING COMMENT 'The outcome of the AQL-based statistical sampling inspection. Indicates whether the fabric lot meets the agreed quality standards.. Valid values are `accept|reject|conditional`',
    `aql_level` STRING COMMENT 'The AQL level applied during inspection (e.g., 1.0, 2.5, 4.0). Defines the maximum acceptable defect rate for the fabric lot.. Valid values are `^(1.0|1.5|2.5|4.0|6.5)$`',
    `batch_number` STRING COMMENT 'The production batch number assigned by the fabric mill. Enables traceability back to the manufacturing process and raw material sources.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `color_fastness_result` STRING COMMENT 'The outcome of the color fastness test, indicating whether the fabric color is resistant to fading or bleeding during washing, rubbing, or light exposure.. Valid values are `pass|fail|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fabric receipt record was first created in the system. Supports audit trail and data lineage tracking.',
    `defect_count` STRING COMMENT 'The total number of defects identified during the fabric inspection. Used to calculate defect rate and determine acceptance or rejection.',
    `defect_type` STRING COMMENT 'Description of the primary types of defects found during inspection (e.g., holes, stains, weaving flaws, color inconsistency). Supports root cause analysis and supplier feedback.',
    `expected_delivery_date` DATE COMMENT 'The originally scheduled delivery date from the purchase order or supplier commitment. Used to calculate delivery performance and OTIF metrics.',
    `inspection_date` DATE COMMENT 'The date on which the fabric quality inspection was completed. Used to track inspection cycle time and compliance with receiving procedures.',
    `inspection_status` STRING COMMENT 'The current status of the quality inspection process for the received fabric. Determines whether the fabric can be released for cutting.. Valid values are `pending|in_progress|passed|failed|conditional_accept|rejected`',
    `inspector_name` STRING COMMENT 'The name of the quality inspector who performed the fabric inspection. Supports accountability and quality audit trails.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fabric receipt record was most recently modified. Tracks the currency of the data and supports change auditing.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of fabric originally ordered on the purchase order. Used for variance analysis against received quantity.',
    `packing_list_number` STRING COMMENT 'The packing list or delivery note number accompanying the fabric shipment. Used for cross-verification during receiving and inspection.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `receipt_date` DATE COMMENT 'The date on which the fabric was physically received at the CMT factory. Gates the earliest possible cut-start date for production scheduling.',
    `receipt_number` STRING COMMENT 'Business identifier for the fabric receipt transaction, typically generated by the warehouse management system or factory receiving system. Used for tracking and reference in communications with suppliers and production planning.. Valid values are `^[A-Z0-9]{8,20}$`',
    `receipt_status` STRING COMMENT 'The overall status of the fabric receipt in the factory workflow. Tracks progression from physical receipt through inspection to production release.. Valid values are `received|inspected|approved|rejected|quarantined|released_to_production`',
    `receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the fabric receipt was recorded in the warehouse management system. Supports detailed logistics and lead time analysis.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of fabric received at the factory. Compared against ordered quantity to identify shortages or overages.',
    `remarks` STRING COMMENT 'Free-text field for capturing additional notes, observations, or special handling instructions related to the fabric receipt. Supports communication between receiving, quality, and production teams.',
    `roll_count` STRING COMMENT 'The number of fabric rolls received in this shipment. Used for physical inventory verification and warehouse space planning.',
    `shade_lot_number` STRING COMMENT 'The dye lot or shade lot number assigned by the mill. Ensures color consistency within a production run, as different lots may have slight color variations.. Valid values are `^[A-Z0-9-]{4,15}$`',
    `shrinkage_percentage_length` DECIMAL(18,2) COMMENT 'The measured shrinkage percentage in the length (warp) direction after washing. Used to verify compliance with technical specifications.',
    `shrinkage_percentage_width` DECIMAL(18,2) COMMENT 'The measured shrinkage percentage in the width (weft) direction after washing. Used to verify compliance with technical specifications.',
    `shrinkage_test_result` STRING COMMENT 'The outcome of the fabric shrinkage test, indicating whether the fabric meets the specified shrinkage tolerance after washing. Critical for garment fit and quality.. Valid values are `pass|fail|not_tested`',
    `storage_location` STRING COMMENT 'The warehouse location or bin where the received fabric is stored. Supports efficient material retrieval for cutting operations.',
    `unit_of_measure` STRING COMMENT 'The unit in which fabric quantity is measured (meters, yards, kilograms, pounds, or rolls). Must align with purchase order and production planning units.. Valid values are `meters|yards|kilograms|pounds|rolls`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between ordered and received quantity (received minus ordered). Positive values indicate overage, negative values indicate shortage.',
    CONSTRAINT pk_bulk_fabric_receipt PRIMARY KEY(`bulk_fabric_receipt_id`)
) COMMENT 'Record of bulk fabric or raw material receipt at the CMT factory prior to cutting, capturing receipt date, fabric article reference, supplier/mill, purchase order number, ordered vs received quantity (meters/yards/kg), AQL inspection result, fabric width, weight, shrinkage test result, shade lot number, and receipt status. Tracks inbound material availability at the factory level to gate cut-start decisions and support production scheduling. Owned by production as the factory-floor receipt event; supply domain owns the upstream PO and logistics owns transit.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`cut_order` (
    `cut_order_id` BIGINT COMMENT 'Unique identifier for the cut order record. Primary key.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to product.bom. Business justification: Cut orders consume fabric per BOM specifications for marker efficiency calculation, fabric variance tracking, and costing reconciliation. No existing BOM reference on cut_order.',
    `colorway_id` BIGINT COMMENT 'Reference to the specific colorway variant of the style being cut.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cutting operations track cost centers for fabric utilization efficiency, cutting department cost allocation, and marker efficiency variance analysis—standard in apparel production costing.',
    `fabric_roll_id` BIGINT COMMENT 'Reference to the primary fabric roll allocated for this cut order. Links to inventory fabric roll tracking.',
    `ftc_label_id` BIGINT COMMENT 'Foreign key linking to compliance.ftc_label. Business justification: Cut orders require approved FTC-compliant labels (fiber content, care, COO) before cutting can proceed. US apparel production gates cutting on label approval - regulatory requirement for domestic manu',
    `marker_id` BIGINT COMMENT 'Reference to the CAD marker layout used for this cut. The marker defines the pattern piece arrangement on fabric for optimal material utilization.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor responsible for overseeing this cut order execution. Links to workforce management system.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility where the cutting operation is performed. Links to factory master data.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Cut orders execute cutting based on approved design specifications, pattern layouts, and construction details from design sketches. Links cutting operations to design-approved pattern instructions.',
    `style_id` BIGINT COMMENT 'Reference to the style being cut. Links to the product style master in PLM system.',
    `tertiary_cut_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last updated this cut order record. Audit trail for change tracking.',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Fabric cutting generates 15-25% pre-consumer waste in apparel manufacturing. Linking cut orders to waste records enables yield optimization, circular material recovery programs, and ZWTL (Zero Waste t',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order that this cut order is part of. Links to the manufacturing work order in SAP S/4HANA PP.',
    `actual_panels_count` STRING COMMENT 'Actual number of fabric panels cut during execution. Used for yield tracking and quality control.',
    `bundle_ticket_generated` BOOLEAN COMMENT 'Indicates whether bundle tickets have been generated for the cut panels to track them through sewing operations. True when cut panels are bundled and tagged for downstream workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cut order record was first created in the system. Audit trail for record creation.',
    `cut_date` DATE COMMENT 'The date on which the cutting operation was executed. Primary business event timestamp for this cut order.',
    `cut_efficiency_percentage` DECIMAL(18,2) COMMENT 'Actual cutting efficiency achieved versus the marker plan, expressed as a percentage. Calculated as (actual fabric consumed / planned fabric consumption) * 100. Key KPI for material utilization and waste reduction.',
    `cut_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the cutting operation was completed. Used for cycle time calculation and throughput analysis.',
    `cut_order_number` STRING COMMENT 'Business identifier for the cut order, externally visible and used for tracking and communication with cut room supervisors and production planners.. Valid values are `^CO-[0-9]{8}$`',
    `cut_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the cutting operation began. Used for cycle time analysis and labor productivity tracking.',
    `cut_status` STRING COMMENT 'Current lifecycle status of the cut order. Tracks progression through the cutting workflow and gates downstream sewing operations.. Valid values are `planned|in_progress|completed|on_hold|cancelled`',
    `cutting_machine_code` BIGINT COMMENT 'Reference to the cutting equipment used (manual table, straight knife, die cutter, laser cutter, automated spreader). Links to equipment asset master.',
    `defect_count` STRING COMMENT 'Number of defective panels identified during cutting or post-cut inspection. Used for quality tracking and scrap analysis.',
    `defect_notes` STRING COMMENT 'Free-text description of defects encountered during cutting (e.g., fabric flaws, miscuts, pattern misalignment). Used for root cause analysis and continuous improvement.',
    `fabric_consumption_per_unit` DECIMAL(18,2) COMMENT 'Planned fabric consumption per garment unit based on marker efficiency, measured in meters or yards. Used for material costing and yield analysis.',
    `fabric_consumption_uom` STRING COMMENT 'Unit of measure for fabric consumption (meters, yards, or feet).. Valid values are `meters|yards|feet`',
    `marker_efficiency_percentage` DECIMAL(18,2) COMMENT 'Theoretical marker efficiency from the CAD marker layout, representing the percentage of fabric utilized in the marker versus waste. Baseline for cut efficiency comparison.',
    `marker_reference_code` STRING COMMENT 'External marker code from CAD system used for cross-reference and traceability to the digital marker file.. Valid values are `^MKR-[A-Z0-9]{6,12}$`',
    `planned_panels_count` STRING COMMENT 'Number of fabric panels planned to be cut based on the marker layout and order quantity.',
    `ply_count` STRING COMMENT 'Number of fabric layers (plies) stacked and cut simultaneously in this cut order. Higher ply counts improve efficiency but require precision equipment.',
    `priority_level` STRING COMMENT 'Production priority assigned to this cut order. Influences scheduling sequence and resource allocation in the cut room.. Valid values are `standard|high|urgent|rush`',
    `quality_inspection_status` STRING COMMENT 'Quality control status for the cut panels. Indicates whether the cut pieces meet quality standards for pattern accuracy, edge finish, and fabric integrity before release to sewing.. Valid values are `pending|passed|failed|conditional`',
    `remarks` STRING COMMENT 'General notes or special instructions related to this cut order (e.g., special handling requirements, fabric characteristics, customer-specific requirements).',
    `scheduled_cut_date` DATE COMMENT 'Originally planned date for the cutting operation based on production scheduling and TNA (Time and Action) calendar.',
    `size_ratio_breakdown` STRING COMMENT 'Size distribution for this cut order, typically expressed as ratio notation (e.g., XS:2, S:4, M:6, L:4, XL:2). Defines the quantity of each size to be cut.',
    `total_fabric_allocated` DECIMAL(18,2) COMMENT 'Total fabric quantity allocated to this cut order in the specified unit of measure. Represents the material reservation for this cutting operation.',
    `total_fabric_consumed` DECIMAL(18,2) COMMENT 'Actual fabric quantity consumed during cutting execution. Captured post-cut for variance analysis and material accounting.',
    `total_units_cut` STRING COMMENT 'Actual number of garment units cut and passed to downstream sewing operations. May differ from planned due to fabric defects or cutting errors.',
    `total_units_planned` STRING COMMENT 'Total number of garment units planned to be produced from this cut order across all sizes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cut order record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_cut_order PRIMARY KEY(`cut_order_id`)
) COMMENT 'Cutting order record authorizing the cutting of fabric panels for a specific style, colorway, and size ratio within a work order. Captures cut order number, cut date, marker reference (CAD marker ID), fabric consumption per unit, total fabric allocated (meters/yards), planned vs actual panels cut, size ratio breakdown, ply count, cut efficiency percentage (vs marker plan), cut room supervisor, and cut status (planned, in-progress, completed). Represents the first physical production step in CMT manufacturing and gates downstream sewing operations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`routing` (
    `routing_id` BIGINT COMMENT 'Unique identifier for the manufacturing routing master record.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.product_category. Business justification: Routing templates are category-specific (footwear construction differs from apparel). Supports routing library management and category-level standard costing. No existing category reference on routing',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Production routings may require process certifications (Fair Trade, SA8000, Bluesign) that mandate specific manufacturing methods. Links routing to certification requirements - ensures compliant produ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Routings are designed and approved by industrial engineers who own process standards, SAM calculations, and line balancing. Critical for engineering accountability, continuous improvement tracking, an',
    `environmental_impact_id` BIGINT COMMENT 'Foreign key linking to sustainability.environmental_impact. Business justification: Process routing (operation sequence, SAM values, machine types) determines energy and water consumption per garment. LCA modeling requires routing-level impact data for accurate style-level carbon foo',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or CMT (Cut Make Trim) partner where this routing is executed.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Production routings reference design sketches for operation planning, construction sequence definition, and SAM calculation when style_id alone is insufficient. Enables design-driven routing optimizat',
    `style_id` BIGINT COMMENT 'Reference to the style or product that this routing defines the manufacturing process for.',
    `approved_by` STRING COMMENT 'Name or identifier of the industrial engineer or production manager who approved this routing for production use.',
    `approved_date` DATE COMMENT 'Date when this routing was formally approved for production use.',
    `cmt_cost_per_unit` DECIMAL(18,2) COMMENT 'Calculated CMT (Cut Make Trim) cost per unit based on total SAM, labor rates, and overhead allocation. Used for product costing and pricing decisions.',
    `complexity_rating` STRING COMMENT 'Overall complexity rating of this routing based on number of operations, skill requirements, and technical difficulty. Used for capacity planning and factory assignment.. Valid values are `low|medium|high|very_high`',
    `critical_path_operations` STRING COMMENT 'Comma-separated list of operation sequence numbers that form the critical path for this routing. These operations determine the minimum production time.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for CMT cost per unit (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date after which this routing version is no longer valid for new production. Null indicates the routing is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date from which this routing version becomes valid and can be used for production planning and work order generation.',
    `last_updated_date` DATE COMMENT 'Date when this routing record was last modified. Used to track routing changes and improvements over time.',
    `line_balancing_target` DECIMAL(18,2) COMMENT 'Target line balancing efficiency percentage for this routing. Represents the ideal distribution of work across operations to minimize bottlenecks.',
    `machine_type_requirements` STRING COMMENT 'Comma-separated list of machine types required to execute this routing (e.g., single needle, overlock, flatlock, buttonhole, bartack, pressing).',
    `maximum_batch_size` STRING COMMENT 'Maximum production batch size that this routing can handle without requiring line reconfiguration or additional resources.',
    `minimum_batch_size` STRING COMMENT 'Minimum production batch size for which this routing is economically viable. Below this quantity, setup costs make production inefficient.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this routing. May include historical context, change reasons, or production tips.',
    `operation_count` STRING COMMENT 'Total number of discrete manufacturing operations defined in this routing sequence.',
    `production_line_type` STRING COMMENT 'Type of production line configuration required for this routing. Modular lines use flexible workstations, progressive bundle systems move work in batches, unit production systems use overhead conveyors, and lean cells use cellular manufacturing.. Valid values are `modular|progressive_bundle|unit_production_system|lean_cell`',
    `quality_check_points` STRING COMMENT 'Number of quality inspection checkpoints defined within this routing sequence to ensure product quality standards.',
    `routing_code` STRING COMMENT 'Business identifier for the routing, typically a combination of style code and factory code.. Valid values are `^[A-Z0-9]{6,20}$`',
    `routing_description` STRING COMMENT 'Detailed description of the manufacturing routing including special instructions, quality requirements, and production notes.',
    `routing_name` STRING COMMENT 'Descriptive name of the routing, typically including style name and factory name for easy identification.',
    `routing_status` STRING COMMENT 'Current lifecycle status of the routing. Draft routings are under development, approved routings are ready for use, active routings are in production, inactive routings are temporarily suspended, and obsolete routings are retired.. Valid values are `draft|approved|active|inactive|obsolete|under_review`',
    `routing_type` STRING COMMENT 'Classification of the routing based on its purpose. Standard routings are the default process, alternative routings are backup options, prototype routings are for PP (Pre-Production) samples, sample routings are for SMS (Sample Management System), and bulk production routings are for high-volume manufacturing.. Valid values are `standard|alternative|prototype|sample|bulk_production`',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes required to set up the production line before starting this routing. Includes machine setup, material preparation, and line configuration.',
    `skill_level_requirements` STRING COMMENT 'Minimum operator skill level required to execute this routing. Used for workforce planning and training needs assessment.. Valid values are `entry|intermediate|advanced|expert`',
    `special_equipment_required` STRING COMMENT 'Comma-separated list of special equipment or tools required for this routing beyond standard sewing machines (e.g., heat press, ultrasonic welder, laser cutter, embroidery machine).',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Sustainability rating of this routing based on energy consumption, waste generation, and environmental impact. Scale of 0-100 with higher scores indicating more sustainable processes.',
    `target_efficiency_percentage` DECIMAL(18,2) COMMENT 'Target production efficiency percentage for this routing. Used to calculate expected output and labor costs.',
    `target_output_per_hour` STRING COMMENT 'Expected number of units that can be produced per hour when this routing is executed at standard efficiency.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes required to tear down the production line after completing this routing. Includes cleanup, machine reset, and material removal.',
    `total_sam` DECIMAL(18,2) COMMENT 'Total Standard Allowed Minutes for completing all operations in the routing. Used for capacity planning, CMT (Cut Make Trim) cost calculation, and labor costing. Sum of SAM values across all operations.',
    `version` STRING COMMENT 'Version number of the routing to track changes and improvements over time. Incremented when routing is revised.. Valid values are `^[0-9]{2,4}$`',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Manufacturing routing master defining the standard sequence of operations and work centers required to produce a style at a specific factory. Captures routing version, total SAM (Standard Allowed Minutes), number of operations, machine type requirements, skill level requirements, line balancing targets, routing status, and effective date range. Derived from SAP PP routing master (CA01). Used for capacity planning, CMT cost calculation, and as the template from which work_order_operations are generated.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Unique identifier for the work center. Primary key.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility where this work center is located.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Work centers have supervisors managing daily operations, quality control, staffing, and equipment utilization. Essential for labor cost allocation, performance reviews, and operational accountability.',
    `capacity_category` STRING COMMENT 'Capacity category code used for grouping work centers with similar capacity characteristics in capacity planning.',
    `capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Available production capacity of the work center measured in hours per day. Used for capacity planning and production scheduling.',
    `control_key` STRING COMMENT 'SAP PP control key that determines which operations are relevant for scheduling, capacity planning, and costing at this work center.. Valid values are `^[A-Z0-9]{2,4}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with this work center for cost allocation and tracking in SAP FI/CO module.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_by_user` STRING COMMENT 'User ID of the person who created this work center record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was first created in the system.',
    `department_type` STRING COMMENT 'Type of production department this work center belongs to within the apparel manufacturing process. [ENUM-REF-CANDIDATE: cutting|sewing|finishing|pressing|packing|embroidery|printing|quality_inspection — 8 candidates stripped; promote to reference product]',
    `efficiency_rate_percent` DECIMAL(18,2) COMMENT 'Standard efficiency rate of the work center expressed as a percentage. Represents the ratio of standard time to actual time for production operations.',
    `formula_key` STRING COMMENT 'Key identifying the formula used to calculate standard values (setup time, machine time, labor time) for operations at this work center.',
    `labor_time_per_unit_minutes` DECIMAL(18,2) COMMENT 'Standard labor time per production unit, measured in minutes. Used for workforce planning and costing.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this work center record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work center record was last modified.',
    `location_description` STRING COMMENT 'Physical location description within the factory (e.g., Building A Floor 2, Production Hall 3 Zone B).',
    `machine_time_per_unit_minutes` DECIMAL(18,2) COMMENT 'Standard machine processing time per production unit, measured in minutes. Used for capacity planning and costing.',
    `move_time_minutes` DECIMAL(18,2) COMMENT 'Standard time required to move materials to the next work center after operation completion, measured in minutes.',
    `number_of_machines` STRING COMMENT 'Total count of machines or equipment units available in this work center.',
    `number_of_operators` STRING COMMENT 'Total count of operators or workers assigned to this work center for production operations.',
    `planning_group` STRING COMMENT 'Planning group code used to organize work centers for capacity planning and production scheduling purposes.',
    `quality_certification_code` STRING COMMENT 'Quality certification or compliance code applicable to this work center (e.g., ISO 9001, WRAP, OEKO-TEX).',
    `queue_time_minutes` DECIMAL(18,2) COMMENT 'Standard queue time (waiting time before operation starts) at this work center, measured in minutes. Used in production scheduling.',
    `scheduling_type` STRING COMMENT 'Scheduling method used for operations at this work center: forward scheduling from start date, backward scheduling from due date, or midpoint scheduling.. Valid values are `forward|backward|midpoint`',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Standard setup time required to prepare the work center for a production operation, measured in minutes.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern for this work center (single shift, two shifts, three shifts, or continuous 24/7 operation).. Valid values are `single_shift|two_shift|three_shift|continuous`',
    `standard_value_unit` STRING COMMENT 'Unit of measure for standard time values (minutes, hours, seconds, days) used in capacity and scheduling calculations.. Valid values are `MIN|HR|SEC|DAY`',
    `utilization_rate_percent` DECIMAL(18,2) COMMENT 'Current utilization rate of the work center expressed as a percentage of available capacity. Calculated from actual production data.',
    `valid_from_date` DATE COMMENT 'Date from which this work center record becomes effective and available for production planning.',
    `valid_to_date` DATE COMMENT 'Date until which this work center record remains effective. Null indicates no planned end date.',
    `work_center_category` STRING COMMENT 'Classification of the work center based on resource type: machine-intensive, labor-intensive, or mixed operations.. Valid values are `machine|labor|mixed`',
    `work_center_code` STRING COMMENT 'Business identifier for the work center used in production planning and routing. Externally-known unique code used in SAP PP module.. Valid values are `^[A-Z0-9]{4,12}$`',
    `work_center_name` STRING COMMENT 'Human-readable name of the work center (e.g., Sewing Line 3, Cutting Room A, Finishing Department B).',
    `work_center_status` STRING COMMENT 'Current operational status of the work center in its lifecycle. Determines availability for production planning and scheduling.. Valid values are `active|inactive|maintenance|blocked|decommissioned`',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Work center master record representing a production unit (sewing line, cutting room, finishing department, pressing station, packing line) within a factory. Captures work center code, work center name, factory reference, department type, available capacity (hours/day), efficiency rate, number of machines, number of operators, work center category (machine, labor, mixed), and active status. Used for capacity planning and production routing in SAP PP.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` (
    `subcontracting_order_id` BIGINT COMMENT 'Unique identifier for the subcontracting purchase order. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Subcontracting orders require valid audit status before placement. Brands verify subcontractor audit compliance (social, safety) before issuing orders - mandatory vendor approval gate in ethical sourc',
    `employee_id` BIGINT COMMENT 'Reference to the purchasing buyer or planner responsible for this subcontracting order.',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Subcontracting orders (CMT operations) are issued against customer purchase orders for cost allocation, compliance tracking, and delivery coordination. Critical for subcontract-to-PO traceability in a',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific factory location where the subcontracting operation will be performed.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Subcontracted production requires profit center assignment for margin analysis comparing outsourced vs in-house manufacturing, critical for strategic sourcing decisions in apparel operations.',
    `season_id` BIGINT COMMENT 'Reference to the fashion season or collection this subcontracting order supports.',
    `style_id` BIGINT COMMENT 'Reference to the product style being manufactured through this subcontracting order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: CMT subcontracting costs must allocate to cost centers for accurate production cost tracking, outsourced vs in-house cost comparison, and subcontractor performance analysis.',
    `vendor_id` BIGINT COMMENT 'Reference to the external CMT factory or specialist subcontractor performing the manufacturing operation.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent production work order that this subcontracting order supports.',
    `actual_completion_date` DATE COMMENT 'Actual date when the subcontractor completed the operation and returned finished goods.',
    `actual_start_date` DATE COMMENT 'Actual date when the subcontractor began the manufacturing operation.',
    `cmt_price_per_unit` DECIMAL(18,2) COMMENT 'Agreed unit price for the subcontracting operation, typically representing the CMT cost.',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether compliance certifications (e.g., OEKO-TEX, GOTS, WRAP) are required from the subcontractor.',
    `components_sent_date` DATE COMMENT 'Date when component materials were sent to the subcontractor for processing.',
    `components_sent_quantity` DECIMAL(18,2) COMMENT 'Total quantity of component materials sent to the subcontractor.',
    `created_by_user` STRING COMMENT 'SAP user ID of the person who created the subcontracting order.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontracting order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order value and pricing.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'International commercial terms defining delivery responsibilities. Common values: FOB, CIF, EXW, DDP.. Valid values are `^[A-Z]{3}$`',
    `inspection_status` STRING COMMENT 'Current status of quality inspection for received goods.. Valid values are `not_started|in_progress|passed|failed|conditional_approval`',
    `last_modified_by_user` STRING COMMENT 'SAP user ID of the person who last modified the subcontracting order.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the subcontracting order record was last updated.',
    `operation_type` STRING COMMENT 'Type of manufacturing or finishing operation being subcontracted (e.g., CMT, embroidery, printing, washing, dyeing). [ENUM-REF-CANDIDATE: cut_make_trim|embroidery|printing|washing|dyeing|finishing|stitching|assembly|packaging — 9 candidates stripped; promote to reference product]',
    `order_quantity` DECIMAL(18,2) COMMENT 'Total quantity of units ordered for the subcontracting operation.',
    `order_status` STRING COMMENT 'Current lifecycle status of the subcontracting order. [ENUM-REF-CANDIDATE: draft|released|in_progress|partially_received|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Agreed payment terms with the subcontractor (e.g., Net 30, Net 60, LC at sight).',
    `planned_completion_date` DATE COMMENT 'Scheduled date when the subcontractor is expected to complete the operation and return finished goods.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the subcontractor is expected to begin the manufacturing operation.',
    `plant_code` STRING COMMENT 'SAP plant code where the finished goods will be received after subcontracting.. Valid values are `^[A-Z0-9]{4}$`',
    `po_item_number` STRING COMMENT 'Line item number within the subcontracting purchase order. SAP item category L for subcontracting.. Valid values are `^[0-9]{5,6}$`',
    `po_number` STRING COMMENT 'External business identifier for the subcontracting purchase order. SAP MM document number for order type NB.. Valid values are `^[A-Z0-9]{10,20}$`',
    `purchasing_group` STRING COMMENT 'SAP purchasing group code responsible for managing this subcontracting relationship.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization code responsible for this subcontracting order.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether quality inspection is required upon receipt of finished goods from the subcontractor.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of finished goods received back from the subcontractor to date.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods rejected due to quality issues during inspection.',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements for the subcontractor regarding quality, packaging, or handling.',
    `storage_location` STRING COMMENT 'SAP storage location code where finished goods will be stored upon receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of the subcontracting order (order quantity × CMT price per unit).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the order quantity (e.g., EA for each, PC for pieces, DZ for dozen).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_subcontracting_order PRIMARY KEY(`subcontracting_order_id`)
) COMMENT 'Subcontracting purchase order issued to an external CMT factory or specialist subcontractor for a specific manufacturing operation (e.g., embroidery, printing, washing, dyeing). Captures subcontracting PO number, subcontractor reference, operation type, style reference, quantity, planned start date, planned completion date, component materials sent, finished goods expected, agreed CMT price, and order status. Represents SAP MM subcontracting PO (order type NB with item category L).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`lot` (
    `lot_id` BIGINT COMMENT 'Unique identifier for the production lot or batch. Primary key. [ROLE: MASTER_RESOURCE - canonical entity representing a discrete manufacturing run]',
    `colorway_id` BIGINT COMMENT 'Foreign key linking to product.colorway. Business justification: Production lots are colorway-specific for shade lot control and quality traceability. Reuses existing colorway_code(unlinked) pattern but needs proper FK. Removes denormalized colorway_code.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production lots require cost center assignment for batch costing, production variance tracking by lot, and quality cost analysis—enables detailed cost control in apparel manufacturing.',
    `cut_order_id` BIGINT COMMENT 'Reference to the cut order that generated the fabric panels for this lot.',
    `employee_id` BIGINT COMMENT 'Primary operator or line supervisor responsible for this production lot.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Production lots undergo batch safety testing for compliance verification. Apparel manufacturers test representative samples from each lot for chemical/physical safety - standard QA/compliance workflow',
    `production_factory_id` BIGINT COMMENT 'Manufacturing facility where this lot was produced.',
    `production_line_id` BIGINT COMMENT 'Identifier of the manufacturing line or assembly line where this lot was produced.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Lots need profit center links for collection/season profitability analysis, enabling margin tracking at production batch level for apparel financial planning and performance analysis.',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Production lots track originating design sketch for design performance traceability, design-to-quality correlation analysis, and design defect root cause investigation. Enables design quality feedback',
    `style_id` BIGINT COMMENT 'Reference to the style or design being manufactured in this lot.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order that authorized this production lot.',
    `rework_source_lot_id` BIGINT COMMENT 'Self-referencing FK on lot (rework_source_lot_id)',
    `accepted_quantity` STRING COMMENT 'Number of units that passed quality inspection and are approved for shipment.',
    `aql_level` STRING COMMENT 'Acceptable Quality Limit standard applied to this lot (e.g., 2.5, 4.0) defining the maximum acceptable defect rate.',
    `carton_range_end` STRING COMMENT 'Last carton number in the range of shipping cartons packed from this lot.',
    `carton_range_start` STRING COMMENT 'First carton number in the range of shipping cartons packed from this lot, enabling downstream shipment traceability.',
    `cmt_type` STRING COMMENT 'Manufacturing arrangement type. CMT is cut-make-trim (factory provides labor only); FOB is free-on-board (factory sources materials); CM is cut-and-make (buyer provides fabric); full_package is turnkey production; consignment is buyer-owned materials.. Valid values are `cmt|fob|cm|full_package|consignment`',
    `compliance_certificate_number` STRING COMMENT 'Certificate number for regulatory compliance documentation (e.g., CPSIA certificate, OEKO-TEX certificate) associated with this lot.',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether this lot requires regulatory compliance certification (CPSIA, REACH, CA Prop 65, etc.) before shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this lot record was first created in the system.',
    `critical_defect_count` STRING COMMENT 'Number of critical defects (safety hazards, non-compliance issues) found in this lot.',
    `cut_date` DATE COMMENT 'Date when fabric cutting was performed for this lot.',
    `defect_count` STRING COMMENT 'Total number of defects identified during quality inspection of this lot.',
    `fabric_shade_lot_number` STRING COMMENT 'Shade lot identifier for the bulk fabric used in this production lot, critical for color consistency and traceability.',
    `finishing_date` DATE COMMENT 'Date when finishing operations (pressing, trimming, packaging) were completed for this lot.',
    `inspection_date` DATE COMMENT 'Date when final quality inspection was performed on this lot.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this lot record was last updated.',
    `lot_number` STRING COMMENT 'Business identifier for the production lot, used for traceability and recall scenarios. Externally-known unique code for the manufacturing batch.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the production lot. Open indicates lot is active and receiving production; in_progress indicates manufacturing underway; closed indicates lot is complete; on_hold indicates temporary suspension; cancelled indicates lot was terminated; quarantined indicates quality hold.. Valid values are `open|in_progress|closed|on_hold|cancelled|quarantined`',
    `lot_type` STRING COMMENT 'Classification of the production lot by purpose. Bulk production is main manufacturing run; pre-production sample is PP sample lot; top sample is first production unit; shipment sample is quality check sample; development sample is design validation; reorder is repeat production; rework is defect correction. [ENUM-REF-CANDIDATE: bulk_production|pre_production_sample|top_sample|shipment_sample|development_sample|reorder|rework — 7 candidates stripped; promote to reference product]',
    `major_defect_count` STRING COMMENT 'Number of major defects (functional failures, significant appearance issues) found in this lot.',
    `minor_defect_count` STRING COMMENT 'Number of minor defects (cosmetic issues, small workmanship flaws) found in this lot.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, issues, or observations related to this production lot.',
    `planned_quantity` STRING COMMENT 'Target number of units to be produced in this lot as per the work order.',
    `produced_quantity` STRING COMMENT 'Actual number of finished units produced in this lot, including all quality grades.',
    `production_end_date` DATE COMMENT 'Date when manufacturing of this lot was completed.',
    `production_start_date` DATE COMMENT 'Date when manufacturing of this lot commenced at the factory.',
    `quality_inspection_status` STRING COMMENT 'Result of the final quality inspection for this lot. Passed indicates lot meets AQL standards; failed indicates rejection; conditional_pass indicates minor issues accepted; re_inspection_required indicates additional checks needed.. Valid values are `pending|in_progress|passed|failed|conditional_pass|re_inspection_required`',
    `rejected_quantity` STRING COMMENT 'Number of units that failed quality inspection and were rejected.',
    `rework_quantity` STRING COMMENT 'Number of units sent for rework or repair to correct defects.',
    `scrap_quantity` STRING COMMENT 'Number of units that were scrapped or discarded due to irreparable defects.',
    `season_code` STRING COMMENT 'Fashion season or collection identifier for which this lot was produced (e.g., SS24, FW24, Holiday23).',
    `sew_end_date` DATE COMMENT 'Date when sewing operations were completed for this lot.',
    `sew_start_date` DATE COMMENT 'Date when sewing operations began for this lot.',
    `shift_code` STRING COMMENT 'Work shift during which this lot was primarily produced (e.g., day, night, A, B, C).',
    `size_range` STRING COMMENT 'Size assortment included in this production lot (e.g., XS-XL, 2-14).',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific product variant (style-color-size combination) produced in this lot.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for lot quantities (typically pieces for apparel).. Valid values are `pieces|units|pairs|sets|dozens`',
    CONSTRAINT pk_lot PRIMARY KEY(`lot_id`)
) COMMENT 'Production lot or batch record representing a discrete manufacturing run of a style/SKU at a factory, enabling end-to-end traceability from raw materials through finished goods. Captures lot number, work order reference, factory, style/SKU, production date range, quantity produced, fabric shade lot references, cut order references, operator/line assignment, lot status (open, closed, on-hold), and traceability chain linking upstream material lots to downstream carton/shipment IDs. Supports recall scenarios, customer complaint investigation, regulatory compliance (CPSIA, EU textile regulation), and batch-level quality metrics. SSOT for production batch identity within the production domain.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` (
    `factory_designer_collaboration_id` BIGINT COMMENT 'Primary key for factory_designer_collaboration',
    `designer_id` BIGINT COMMENT 'Foreign key linking to the designer participating in the collaboration',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the manufacturing facility engaged in the collaboration',
    `assignment_end_date` DATE COMMENT 'Date when the designer-factory collaboration ended or is scheduled to end. Null for ongoing collaborations. Explicitly identified in detection phase relationship data.',
    `assignment_start_date` DATE COMMENT 'Date when the designer began collaborating with this factory for sample development or production trials. Explicitly identified in detection phase relationship data.',
    `collaboration_type` STRING COMMENT 'Classification of the nature of collaboration between designer and factory. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collaboration record was created in the system.',
    `factory_designer_collaboration_status` STRING COMMENT 'Current lifecycle status of the collaboration relationship, indicating whether it is actively in progress, temporarily paused, completed, or cancelled.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collaboration record was last updated.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this designer is the primary contact for this factory within their assigned product category. Explicitly identified in detection phase relationship data.',
    `product_category_focus` STRING COMMENT 'Specific product category that this collaboration focuses on, aligning the designers specialization with the factorys production capabilities. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_factory_designer_collaboration PRIMARY KEY(`factory_designer_collaboration_id`)
) COMMENT 'This association product represents the operational collaboration relationship between manufacturing factories and designers during sample development, production trials, and technical consultations. It captures the assignment period, product category focus, and collaboration scope that exist only in the context of this working relationship. Each record links one factory to one designer with attributes tracking the nature and timeline of their collaboration.. Existence Justification: In apparel fashion operations, designers collaborate with multiple factories across different product categories and production capabilities (e.g., a footwear designer may work with Factory A for athletic shoes and Factory B for luxury boots). Simultaneously, factories work with multiple designers across different collections, seasons, and specializations (e.g., Factory X may support Designer 1 for menswear and Designer 2 for accessories). This collaboration is actively managed as an operational assignment with specific timelines, category focus, and collaboration scope.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` (
    `factory_embellishment_capability_id` BIGINT COMMENT 'Primary key for the factory_embellishment_capability association',
    `embellishment_id` BIGINT COMMENT 'Foreign key linking to the embellishment design that the factory is capable of executing',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the manufacturing factory that has been certified for the embellishment capability',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this factory-embellishment capability is currently active and available for production planning. Capabilities may be deactivated due to equipment changes, quality issues, or factory specialization shifts.',
    `capability_certification_date` DATE COMMENT 'Date when the factory was certified or approved to execute this specific embellishment technique, following quality audits or sample approval processes',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost, enabling multi-currency capability tracking across global factory networks',
    `last_used_date` DATE COMMENT 'Date when this factory-embellishment combination was most recently used in production, used for capability currency tracking and factory relationship management',
    `lead_time_days` STRING COMMENT 'Factory-specific lead time in days to execute this embellishment technique, which varies based on factory capacity, equipment availability, and complexity handling',
    `minimum_order_quantity` STRING COMMENT 'Factory-specific minimum order quantity for this embellishment type, driven by setup costs, equipment changeover time, and factory policies',
    `notes` STRING COMMENT 'Free-text notes capturing factory-specific considerations for this embellishment, such as equipment limitations, special setup requirements, or quality considerations',
    `quality_rating` DECIMAL(18,2) COMMENT 'Quality performance rating for this factory-embellishment combination based on defect rates, consistency, and sample approval history, typically on a 0-5 scale',
    `unit_cost` DECIMAL(18,2) COMMENT 'Factory-specific cost per unit to execute this embellishment, which varies by factory based on labor rates, equipment, and efficiency. Used for costing and factory selection decisions.',
    CONSTRAINT pk_factory_embellishment_capability PRIMARY KEY(`factory_embellishment_capability_id`)
) COMMENT 'This association product represents the certified capability relationship between a manufacturing factory and an embellishment technique. It captures factory-specific capability certifications, pricing, quality performance, and production parameters for each embellishment type that a factory is qualified to execute. Each record links one factory to one embellishment with attributes that exist only in the context of this manufacturing capability relationship.. Existence Justification: In apparel manufacturing operations, factories develop and maintain certifications for specific embellishment techniques based on equipment, expertise, and quality standards. A single factory can be certified to execute multiple embellishment types (embroidery, beading, screen printing, etc.), and each embellishment design can be executed by multiple qualified factories with varying costs, lead times, and quality ratings. Production planners actively manage this capability matrix when selecting factories for style production, evaluating factory-specific pricing, lead times, and quality performance for each embellishment requirement.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` (
    `production_factory_certification_id` BIGINT COMMENT 'Primary key for production_factory_certification',
    `certification_compliance_certification_id` BIGINT COMMENT 'Foreign key linking to the compliance certification standard held by this factory',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key to compliance.compliance_certification.compliance_certification_id',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the manufacturing facility that holds this certification',
    `audit_score` DECIMAL(18,2) COMMENT 'The numerical audit score achieved by this factory for this specific certification, typically on a 0-100 scale. Corresponds to audit_score from detection phase. This is certification-specific and may differ from the factorys overall audit_score.',
    `audit_status` STRING COMMENT 'Current status of the factorys most recent social compliance or quality audit. APPROVED = passed all requirements; CONDITIONAL = passed with minor findings requiring follow-up; PENDING = audit scheduled or in progress; FAILED = did not meet minimum standards; EXPIRED = audit validity period has lapsed; NOT_AUDITED = no audit on record. [Moved from factory: If audit_status is certification-specific (e.g., WRAP audit passed, SA8000 under review), it belongs in factory_certification. However, if this represents an overall factory audit status independent of specific certifications, it should remain in factory. Recommend clarifying with business stakeholders.]. Valid values are `APPROVED|CONDITIONAL|PENDING|FAILED|EXPIRED|NOT_AUDITED`',
    `certificate_document_url` STRING COMMENT 'URL or file path to the factory-specific certification certificate document.',
    `certificate_number` STRING COMMENT 'The unique certificate number issued to this factory for this certification. This is factory-specific and distinct from the master certification records certificate_number.',
    `certification_status` STRING COMMENT 'Current lifecycle status of this factory-certification relationship. Values: Active, Suspended, Expired, Withdrawn, Under Review.',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of active compliance and social responsibility certifications held by the factory (e.g., WRAP, BSCI, FLA, OEKO-TEX Standard 100, SA8000, GOTS, BCI, ISO 9001, ISO 14001, ISO 45001). Used for vendor qualification and brand compliance reporting. [Moved from factory: This comma-separated list in factory is a denormalized representation of the M:N relationship. The proper model is to track each factory-certification relationship as a separate record in factory_certification with full lifecycle attributes (dates, scores, renewal status). The factory table should not contain certification-specific data.]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory-certification record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this specific certification became effective for this factory. Corresponds to certification_effective_date from detection phase. This is the factory-specific issuance date, which may differ from the master certification issue_date if the certification was obtained at different times by different facilities.',
    `expiry_date` DATE COMMENT 'The date on which this certification expires for this factory. Corresponds to certification_expiry_date from detection phase. Used for renewal planning and compliance tracking.',
    `issuing_auditor_name` STRING COMMENT 'Name of the specific auditor or audit firm that conducted the certification audit for this factory.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit conducted for this factory-certification combination. Used for tracking audit frequency and planning surveillance audits.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next surveillance or renewal audit for this factory-certification. Used for compliance planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional context about this factory-certification relationship, including audit findings, corrective actions, or special conditions.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process for this factory-certification combination. Corresponds to renewal_status from detection phase. Values: Not Due, Renewal Initiated, Under Review, Renewed, Expired, Withdrawn.',
    `scope` STRING COMMENT 'The specific scope of this certification as it applies to this factory. May include product categories covered (e.g., woven apparel only), production lines certified, or facility areas included. Corresponds to certification_scope from detection phase.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory-certification record was last updated.',
    CONSTRAINT pk_production_factory_certification PRIMARY KEY(`production_factory_certification_id`)
) COMMENT 'This association product represents the certification relationship between a manufacturing facility and a compliance certification standard. It captures the factory-specific certification lifecycle including issuance, expiry, audit results, and renewal status. Each record links one factory to one compliance certification with attributes that exist only in the context of this specific factory-certification combination.. Existence Justification: In apparel manufacturing, factories obtain multiple compliance certifications (WRAP, SA8000, BSCI, ISO 9001, OEKO-TEX) to demonstrate social responsibility, quality management, and product safety. Each certification standard applies to multiple factories across the supply chain. The business actively manages factory-specific certification lifecycles including issuance dates, expiry dates, audit scores, renewal status, and certification scope (which product categories or production lines are covered). Compliance teams query which factories hold which certifications and when do certifications expire as core operational workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` (
    `factory_initiative_implementation_id` BIGINT COMMENT 'Unique identifier for this factory-initiative implementation record. Primary key.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to the sustainability initiative being implemented at this factory',
    `production_factory_id` BIGINT COMMENT 'Foreign key linking to the manufacturing facility where the sustainability initiative is being implemented',
    `audit_verification_date` DATE COMMENT 'Date when the implementation and impact claims were verified through audit or third-party assessment, used for SBTi and ESG reporting credibility.',
    `audit_verification_status` STRING COMMENT 'Status of third-party verification for this factory implementation, required for certain certifications and SBTi progress tracking.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of implementation milestones completed at this factory, used for progress tracking and portfolio reporting. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation record was created in the system.',
    `factory_carbon_reduction_mt_co2e` DECIMAL(18,2) COMMENT 'Measured annual greenhouse gas emissions reduction in metric tons of CO2 equivalent achieved at this specific factory. Factory-level impact contributing to initiative total. Identified in detection phase relationship data as impact_achieved.',
    `factory_energy_savings_mwh` DECIMAL(18,2) COMMENT 'Measured annual energy consumption reduction in megawatt hours achieved at this factory. Factory-level impact contributing to initiative total.',
    `factory_investment_amount` DECIMAL(18,2) COMMENT 'Capital and operational expenditure allocated specifically to this factory for implementing this initiative. Subset of the total initiative investment. Identified in detection phase relationship data.',
    `factory_investment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the factory-level investment amount, may differ from initiative-level currency.',
    `factory_waste_diversion_kg` DECIMAL(18,2) COMMENT 'Measured annual waste diverted from landfill in kilograms at this factory. Factory-level impact contributing to initiative total.',
    `factory_water_savings_m3` DECIMAL(18,2) COMMENT 'Measured annual water consumption reduction in cubic meters achieved at this factory. Factory-level impact contributing to initiative total.',
    `implementation_actual_completion_date` DATE COMMENT 'Actual date when implementation was completed at this factory. Null if still in progress.',
    `implementation_lead` STRING COMMENT 'Name or identifier of the person responsible for executing the initiative at this factory (factory manager, sustainability coordinator, or project lead).',
    `implementation_notes` STRING COMMENT 'Free-text notes capturing factory-specific implementation details, challenges, lessons learned, or contextual information for supplier engagement reporting.',
    `implementation_start_date` DATE COMMENT 'Date when implementation activities commenced at this specific factory. May differ from the initiative-level start date. Identified in detection phase relationship data.',
    `implementation_status` STRING COMMENT 'Current status of the initiative implementation at this specific factory. Tracks lifecycle from planning through completion. Identified in detection phase relationship data.',
    `implementation_target_completion_date` DATE COMMENT 'Planned completion date for implementation at this factory. Factory-specific milestone within the broader initiative timeline.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation record was last modified, used for change tracking and data freshness monitoring.',
    CONSTRAINT pk_factory_initiative_implementation PRIMARY KEY(`factory_initiative_implementation_id`)
) COMMENT 'This association product represents the implementation of a sustainability initiative at a specific factory. It captures the factory-level execution details, investment allocation, progress tracking, and impact measurement for each initiative deployment. Each record links one factory to one sustainability initiative with attributes that exist only in the context of this implementation relationship, enabling portfolio management of sustainability programs across the manufacturing network.. Existence Justification: In apparel fashion sustainability operations, a single factory participates in multiple sustainability initiatives simultaneously (e.g., solar installation, wastewater treatment, worker training programs), and each initiative is deployed across multiple factories in the manufacturing network. The business actively manages factory-level implementation tracking with specific investment allocations, progress milestones, and impact measurements for each factory-initiative combination to support supplier engagement reporting and SBTi progress tracking.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`marker` (
    `marker_id` BIGINT COMMENT 'Primary key for marker',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this marker for production use.',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or factory where this marker will be used for cutting operations.',
    `material_id` BIGINT COMMENT 'Reference to the specific fabric material for which this marker layout is optimized.',
    `work_order_id` BIGINT COMMENT 'Reference to the production order or work order for which this marker was created.',
    `style_id` BIGINT COMMENT 'Reference to the garment style for which this marker is designed.',
    `revised_marker_id` BIGINT COMMENT 'Self-referencing FK on marker (revised_marker_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the marker was officially approved for production use.',
    `cad_system_name` STRING COMMENT 'Name of the CAD software system used to create the marker, such as Gerber, Lectra, or Optitex.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the marker record was first created in the system.',
    `cutting_table_width_cm` DECIMAL(18,2) COMMENT 'Width of the cutting table for which this marker is optimized, ensuring compatibility with factory equipment.',
    `fabric_consumption_per_garment` DECIMAL(18,2) COMMENT 'Amount of fabric required to produce one garment based on this marker, measured in meters or yards depending on business unit of measure.',
    `fabric_fold_type` STRING COMMENT 'Type of fabric fold configuration used when laying the marker for cutting operations.',
    `fabric_grain_direction` STRING COMMENT 'Primary grain direction of the fabric used in the marker layout, critical for pattern alignment and garment drape.',
    `fabric_unit_of_measure` STRING COMMENT 'Unit of measurement used for fabric consumption and marker dimensions.',
    `fabric_utilization_percentage` DECIMAL(18,2) COMMENT 'Efficiency metric representing the percentage of fabric area utilized by pattern pieces within the marker, calculated as (pattern area / marker area) * 100.',
    `fabric_wastage_percentage` DECIMAL(18,2) COMMENT 'Percentage of fabric area that is wasted (not utilized) in the marker layout, calculated as 100 minus fabric utilization percentage.',
    `garment_quantity_per_marker` STRING COMMENT 'Number of complete garments that can be cut from one marker repeat.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this marker is currently active and available for use in production operations.',
    `marker_creation_method` STRING COMMENT 'Method or system used to create the marker layout, indicating whether it was manually created, designed using CAD software, or generated automatically.',
    `marker_length_cm` DECIMAL(18,2) COMMENT 'Total length of the marker layout measured in centimeters, representing the fabric length required for one marker repeat.',
    `marker_name` STRING COMMENT 'Human-readable name or title for the marker layout, typically describing the style and size combination.',
    `marker_notes` STRING COMMENT 'Additional notes, instructions, or comments related to the marker layout, cutting process, or special handling requirements.',
    `marker_number` STRING COMMENT 'Business identifier for the marker used in production planning and fabric cutting operations. Externally visible reference number.',
    `marker_status` STRING COMMENT 'Current lifecycle status of the marker in the production workflow.',
    `marker_type` STRING COMMENT 'Classification of the marker based on its intended use and size configuration.',
    `marker_version` STRING COMMENT 'Version number of the marker layout, used to track revisions and improvements over time.',
    `marker_width_cm` DECIMAL(18,2) COMMENT 'Width of the marker layout measured in centimeters, corresponding to the usable fabric width.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the marker record was last modified or updated.',
    `nesting_algorithm` STRING COMMENT 'Name or identifier of the algorithm used to optimize pattern piece placement within the marker to maximize fabric utilization.',
    `plies_count` STRING COMMENT 'Number of fabric layers (plies) that can be stacked and cut simultaneously using this marker.',
    `season_code` STRING COMMENT 'Code representing the fashion season for which this marker is intended, such as Spring/Summer (SS), Fall/Winter (FW), Autumn/Winter (AW), or Spring (SP) followed by year.',
    `total_pieces_count` STRING COMMENT 'Total number of individual pattern pieces arranged within the marker layout.',
    CONSTRAINT pk_marker PRIMARY KEY(`marker_id`)
) COMMENT 'Master reference table for marker. Referenced by marker_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` (
    `fabric_roll_id` BIGINT COMMENT 'Primary key for fabric_roll',
    `fabric_type_id` BIGINT COMMENT 'Reference to the fabric type classification (e.g., cotton, polyester, denim, jersey). Links to fabric_type reference table.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this fabric roll was procured. Links to purchase_order table.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or mill that produced this fabric roll. Links to supplier master table.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or storage facility where the fabric roll is currently located. Links to warehouse_location table.',
    `split_from_fabric_roll_id` BIGINT COMMENT 'Self-referencing FK on fabric_roll (split_from_fabric_roll_id)',
    `bin_location` STRING COMMENT 'Specific bin, rack, or shelf location within the warehouse where the fabric roll is stored. Used for inventory picking and cycle counting.',
    `care_instructions` STRING COMMENT 'Recommended care and maintenance instructions for the fabric (e.g., machine wash cold, dry clean only, tumble dry low). Used for garment labeling compliance.',
    `certification` STRING COMMENT 'Quality or sustainability certifications held by the fabric (e.g., OEKO-TEX Standard 100, GOTS, BCI, Bluesign). Used for compliance and marketing claims.',
    `color_code` STRING COMMENT 'Standardized color code or Pantone reference for the fabric roll. Used for color matching and quality control.',
    `color_name` STRING COMMENT 'Human-readable color name or description (e.g., Navy Blue, Charcoal Grey, Crimson Red).',
    `composition` STRING COMMENT 'Detailed fiber content composition of the fabric (e.g., 100% Cotton, 60% Cotton 40% Polyester, 95% Polyester 5% Spandex). Required for labeling compliance.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the fabric was manufactured. Required for customs compliance and trade documentation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fabric roll record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost values (e.g., USD, EUR, GBP, CNY).',
    `defect_count` STRING COMMENT 'Total number of defects identified during fabric inspection. Used for quality scoring and acceptance decisions.',
    `defect_points` DECIMAL(18,2) COMMENT 'Total defect points calculated using the Four Point System or similar fabric inspection methodology. Lower points indicate higher quality.',
    `expiry_date` DATE COMMENT 'Date after which the fabric roll should not be used due to aging, degradation, or shelf-life limitations. Applicable for certain specialty fabrics with time-sensitive properties.',
    `finish_type` STRING COMMENT 'Type of finishing treatment applied to the fabric (e.g., raw, dyed, printed, washed, brushed, coated). Affects fabric properties and handling requirements.',
    `grade` STRING COMMENT 'Quality grade assigned to the fabric roll based on inspection results. Grade A is first quality, B and C have minor defects, seconds and irregular have more significant flaws.',
    `gsm` DECIMAL(18,2) COMMENT 'Fabric weight per unit area measured in grams per square meter. Key specification for fabric quality and performance characteristics.',
    `harmonized_code` STRING COMMENT 'Harmonized System tariff classification code for the fabric. Used for customs declarations, duty calculations, and international trade compliance.',
    `inspected_by` STRING COMMENT 'Name or identifier of the quality inspector who performed the fabric inspection. Used for accountability and quality audit trails.',
    `inspection_date` DATE COMMENT 'Date when the fabric roll underwent quality inspection. Used for quality control tracking and compliance documentation.',
    `is_organic` BOOLEAN COMMENT 'Boolean flag indicating whether the fabric is certified organic. Used for product labeling and sustainability reporting.',
    `is_recycled` BOOLEAN COMMENT 'Boolean flag indicating whether the fabric contains recycled content. Used for sustainability claims and circular economy initiatives.',
    `length_meters` DECIMAL(18,2) COMMENT 'Total length of fabric on the roll measured in meters. Used for inventory planning and cutting calculations.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned by the fabric mill. Used for quality control and traceability of fabric production runs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fabric roll record was last modified. Used for audit trails and change tracking.',
    `received_date` DATE COMMENT 'Date when the fabric roll was received into inventory from the supplier. Used for aging analysis and FIFO inventory management.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or observations about the fabric roll. Used for operational communication and issue tracking.',
    `roll_number` STRING COMMENT 'Externally-known unique identifier assigned to the fabric roll by the supplier or manufacturer. Used for tracking and traceability across the supply chain.',
    `shrinkage_percentage` DECIMAL(18,2) COMMENT 'Expected shrinkage percentage of the fabric after washing or processing. Critical for pattern grading and cutting calculations.',
    `fabric_roll_status` STRING COMMENT 'Current lifecycle status of the fabric roll. Available for use, reserved for specific orders, allocated to production, consumed, in quarantine for quality issues, or rejected.',
    `stretch_percentage` DECIMAL(18,2) COMMENT 'Percentage of stretch or elasticity in the fabric. Important for fit and comfort specifications in garment construction.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite sustainability score for the fabric based on environmental impact, ethical sourcing, and certifications. Used for ESG reporting and sustainable product development.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fabric roll (unit cost multiplied by length). Used for inventory valuation and financial reporting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per meter of fabric in the base currency. Used for inventory valuation, costing analysis, and margin calculations.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the fabric roll in kilograms. Used for logistics, shipping calculations, and yield analysis.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width of the fabric roll measured in centimeters. Standard measurement for fabric dimensions used in cutting and pattern making.',
    CONSTRAINT pk_fabric_roll PRIMARY KEY(`fabric_roll_id`)
) COMMENT 'Master reference table for fabric_roll. Referenced by fabric_roll_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Primary key for production_line',
    `production_factory_id` BIGINT COMMENT 'Reference to the manufacturing facility or factory where this production line is physically located.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who serves as the primary line supervisor or production manager responsible for this production line.',
    `work_center_id` BIGINT COMMENT 'Reference to the work center or production cell that this line belongs to within the factory organizational structure.',
    `feeds_production_line_id` BIGINT COMMENT 'Self-referencing FK on production_line (feeds_production_line_id)',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure used to quantify the production capacity (e.g., pieces for shirts, pairs for shoes, dozens for socks).',
    `capacity_units_per_hour` DECIMAL(18,2) COMMENT 'Standard production capacity of the line measured in units (garments, pieces, or items) that can be produced per hour under normal operating conditions.',
    `changeover_time_minutes` STRING COMMENT 'Standard time required in minutes to change over the production line from one product style or order to another, critical for production scheduling.',
    `commissioning_date` DATE COMMENT 'Date when the production line was first commissioned and became operational for production activities.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which production costs, labor, and overhead for this line are allocated for accounting and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was first created in the system.',
    `efficiency_target_percentage` DECIMAL(18,2) COMMENT 'Target operational efficiency percentage for this production line, representing the expected ratio of actual output to standard capacity.',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Average energy consumption in kilowatt-hours required to produce one unit of output on this production line, used for sustainability tracking and cost analysis.',
    `environmental_certification` STRING COMMENT 'Environmental certifications or sustainability standards applicable to this production line (e.g., ISO 14001, LEED, carbon-neutral certification).',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Total floor space occupied by the production line including equipment, operator stations, and material handling areas, measured in square meters.',
    `is_flexible_line` BOOLEAN COMMENT 'Indicates whether this production line is configured for flexible manufacturing, capable of quick changeovers between different product styles or categories.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major equipment upgrade, technology refresh, or significant capacity enhancement to the production line.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this production line master record was most recently updated or modified.',
    `line_code` STRING COMMENT 'Externally-known unique business identifier for the production line, used across manufacturing systems and factory floor documentation.',
    `line_length_meters` DECIMAL(18,2) COMMENT 'Physical length of the production line measured in meters, relevant for layout planning and material flow optimization.',
    `line_name` STRING COMMENT 'Human-readable name or designation of the production line, typically reflecting location or product category (e.g., Knitting Line A, Cut-Make-Trim Line 3).',
    `line_status` STRING COMMENT 'Current operational lifecycle status of the production line indicating availability for production scheduling.',
    `line_type` STRING COMMENT 'Classification of the production line based on its primary manufacturing function within the apparel production process.',
    `minimum_batch_size` STRING COMMENT 'Minimum economical batch size or order quantity that can be efficiently produced on this line, considering setup costs and changeover time.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the production line configuration, capabilities, or operational considerations.',
    `number_of_machines` STRING COMMENT 'Total count of machines, equipment units, or workstations that comprise this production line.',
    `number_of_operators` STRING COMMENT 'Standard number of production operators or workers assigned to operate this production line at full capacity.',
    `planned_maintenance_schedule` STRING COMMENT 'Frequency of scheduled preventive maintenance activities for this production line to ensure optimal performance and minimize downtime.',
    `product_category` STRING COMMENT 'Primary product category or garment type that this production line is configured to manufacture (e.g., Mens Shirts, Athletic Footwear, Outerwear).',
    `production_method` STRING COMMENT 'Manufacturing methodology or production system employed on this line (e.g., progressive bundle system, modular manufacturing, lean production).',
    `quality_grade` STRING COMMENT 'Quality tier or grade of products that this production line is certified and configured to produce.',
    `quality_target_percentage` DECIMAL(18,2) COMMENT 'Target quality pass rate or first-time-right percentage for products manufactured on this line, used for quality performance monitoring.',
    `safety_certification` STRING COMMENT 'Workplace safety certifications or compliance standards that this production line has achieved (e.g., OSHA, ISO 45001, local safety regulations).',
    `shift_pattern` STRING COMMENT 'Standard operating shift pattern for this production line indicating how many shifts per day the line typically operates.',
    `standard_labor_cost_per_hour` DECIMAL(18,2) COMMENT 'Standard labor cost rate per hour for operating this production line, used for production costing and variance analysis.',
    `standard_overhead_rate` DECIMAL(18,2) COMMENT 'Standard manufacturing overhead allocation rate applied to production on this line, expressed as a decimal multiplier or percentage.',
    `technology_level` STRING COMMENT 'Classification of the automation and technology sophistication level of the production line equipment and processes.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Master reference table for production_line. Referenced by production_line_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`production`.`delivery_window` (
    `delivery_window_id` BIGINT COMMENT 'Primary key for delivery_window',
    `production_factory_id` BIGINT COMMENT 'Identifier of the primary manufacturing facility or CMT (Cut-Make-Trim) partner assigned to this delivery window.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center where goods produced in this delivery window will be received.',
    `prior_delivery_window_id` BIGINT COMMENT 'Self-referencing FK on delivery_window (prior_delivery_window_id)',
    `allocated_capacity_units` DECIMAL(18,2) COMMENT 'The amount of capacity already assigned to work orders within this delivery window, measured in the same unit as capacity_units.',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this delivery window for use in production planning.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery window was approved and activated for production scheduling.',
    `available_capacity_units` DECIMAL(18,2) COMMENT 'Remaining unallocated capacity within this delivery window, calculated as capacity_units minus allocated_capacity_units.',
    `buffer_days` STRING COMMENT 'Number of contingency days built into the delivery window schedule to accommodate delays, quality issues, or rework.',
    `capacity_unit_of_measure` STRING COMMENT 'The unit of measure used to quantify capacity for this delivery window.',
    `capacity_units` DECIMAL(18,2) COMMENT 'Total production capacity allocated to this delivery window, measured in standard production units (pieces, dozens, or cartons depending on business configuration).',
    `closed_by` STRING COMMENT 'User identifier or name of the person who closed this delivery window.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery window was closed and no longer available for new work order assignments.',
    `compliance_certification_required` BOOLEAN COMMENT 'Indicates whether specific compliance certifications (e.g., safety, environmental, labor standards) must be verified for production in this delivery window.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery window record was first created in the system.',
    `end_date` DATE COMMENT 'The latest date by which production or delivery must be completed within this window.',
    `incoterm` STRING COMMENT 'International Commercial Terms code defining the responsibilities, costs, and risks between buyer and seller for shipments in this delivery window.',
    `lead_time_days` STRING COMMENT 'Standard number of days required from production start to delivery completion for orders within this window.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this delivery window record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery window record was last updated.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or contextual information about this delivery window.',
    `priority_level` STRING COMMENT 'Business priority assigned to this delivery window, determining resource allocation and scheduling precedence in production planning.',
    `production_category` STRING COMMENT 'Primary product category that this delivery window is designed to support in the manufacturing schedule.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether mandatory quality inspection checkpoints are required for production within this delivery window.',
    `region_code` STRING COMMENT 'Three-letter code representing the geographic region where production or delivery occurs (e.g., CHN for China, VNM for Vietnam, BGD for Bangladesh).',
    `sample_approval_required` BOOLEAN COMMENT 'Indicates whether PP (Pre-Production) sample approval is mandatory before bulk production can proceed within this delivery window.',
    `season_code` STRING COMMENT 'Code representing the fashion season or collection period this delivery window supports (e.g., SS24 for Spring/Summer 2024, FW24 for Fall/Winter 2024).',
    `shipping_method` STRING COMMENT 'Primary mode of transportation planned for moving goods produced within this delivery window from factory to destination.',
    `start_date` DATE COMMENT 'The earliest date when production or delivery activities can begin within this window.',
    `delivery_window_status` STRING COMMENT 'Current lifecycle status of the delivery window. Draft indicates planning phase, active means available for work order assignment, locked prevents new assignments, closed indicates completion, cancelled means the window was terminated.',
    `target_delivery_date` DATE COMMENT 'The planned date when finished goods should arrive at the destination (warehouse, distribution center, or retail location) to fulfill the delivery window.',
    `target_ship_date` DATE COMMENT 'The planned date when finished goods should ship from the manufacturing facility to meet the delivery window commitment.',
    `window_code` STRING COMMENT 'Business identifier code for the delivery window, used for external reference and communication with manufacturing partners and logistics providers.',
    `window_name` STRING COMMENT 'Human-readable name or label for the delivery window (e.g., Spring 2024 Early, Holiday Rush Window, Q3 Bulk Production).',
    `window_type` STRING COMMENT 'Classification of the delivery window based on production urgency and business purpose. Standard for regular production cycles, expedited for rush orders, seasonal for collection launches, bulk for large volume runs, sample for PP (Pre-Production) samples.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this delivery window record.',
    CONSTRAINT pk_delivery_window PRIMARY KEY(`delivery_window_id`)
) COMMENT 'Master reference table for delivery_window. Referenced by delivery_window_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_factory_id` FOREIGN KEY (`factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ADD CONSTRAINT `fk_production_work_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `apparel_fashion_ecm`.`production`.`routing`(`routing_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ADD CONSTRAINT `fk_production_work_order_operation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_reversed_confirmation_order_confirmation_id` FOREIGN KEY (`reversed_confirmation_order_confirmation_id`) REFERENCES `apparel_fashion_ecm`.`production`.`order_confirmation`(`order_confirmation_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ADD CONSTRAINT `fk_production_order_confirmation_work_order_operation_id` FOREIGN KEY (`work_order_operation_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order_operation`(`work_order_operation_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ADD CONSTRAINT `fk_production_factory_capacity_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_delivery_window_id` FOREIGN KEY (`delivery_window_id`) REFERENCES `apparel_fashion_ecm`.`production`.`delivery_window`(`delivery_window_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_factory_capacity_id` FOREIGN KEY (`factory_capacity_id`) REFERENCES `apparel_fashion_ecm`.`production`.`factory_capacity`(`factory_capacity_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ADD CONSTRAINT `fk_production_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ADD CONSTRAINT `fk_production_production_tna_milestone_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ADD CONSTRAINT `fk_production_pp_sample_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ADD CONSTRAINT `fk_production_bulk_fabric_receipt_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_fabric_roll_id` FOREIGN KEY (`fabric_roll_id`) REFERENCES `apparel_fashion_ecm`.`production`.`fabric_roll`(`fabric_roll_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_marker_id` FOREIGN KEY (`marker_id`) REFERENCES `apparel_fashion_ecm`.`production`.`marker`(`marker_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ADD CONSTRAINT `fk_production_cut_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ADD CONSTRAINT `fk_production_routing_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ADD CONSTRAINT `fk_production_work_center_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ADD CONSTRAINT `fk_production_subcontracting_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_cut_order_id` FOREIGN KEY (`cut_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`cut_order`(`cut_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ADD CONSTRAINT `fk_production_lot_rework_source_lot_id` FOREIGN KEY (`rework_source_lot_id`) REFERENCES `apparel_fashion_ecm`.`production`.`lot`(`lot_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ADD CONSTRAINT `fk_production_factory_designer_collaboration_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ADD CONSTRAINT `fk_production_factory_embellishment_capability_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ADD CONSTRAINT `fk_production_production_factory_certification_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ADD CONSTRAINT `fk_production_factory_initiative_implementation_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_order`(`work_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ADD CONSTRAINT `fk_production_marker_revised_marker_id` FOREIGN KEY (`revised_marker_id`) REFERENCES `apparel_fashion_ecm`.`production`.`marker`(`marker_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ADD CONSTRAINT `fk_production_fabric_roll_split_from_fabric_roll_id` FOREIGN KEY (`split_from_fabric_roll_id`) REFERENCES `apparel_fashion_ecm`.`production`.`fabric_roll`(`fabric_roll_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `apparel_fashion_ecm`.`production`.`work_center`(`work_center_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ADD CONSTRAINT `fk_production_production_line_feeds_production_line_id` FOREIGN KEY (`feeds_production_line_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_line`(`production_line_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_production_factory_id` FOREIGN KEY (`production_factory_id`) REFERENCES `apparel_fashion_ecm`.`production`.`production_factory`(`production_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ADD CONSTRAINT `fk_production_delivery_window_prior_delivery_window_id` FOREIGN KEY (`prior_delivery_window_id`) REFERENCES `apparel_fashion_ecm`.`production`.`delivery_window`(`delivery_window_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`production` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`production` SET TAGS ('dbx_domain' = 'production');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `collection_id` SET TAGS ('dbx_business_glossary_term' = 'Collection ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Credit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Production Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `actual_ex_factory_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ex-Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Limit (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `aql_level` SET TAGS ('dbx_value_regex' = '^[0-9].[0-9]$|critical_zero');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `cmt_type` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `cmt_type` SET TAGS ('dbx_value_regex' = 'cut_make_trim|make_trim|trim_only|full_package|fob');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|DAP|FCA');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Work Order Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `produced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Produced Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|conditional');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `sap_pp_order_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Production Planning (PP) Order Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `sap_pp_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_business_glossary_term' = 'Shipping Mode');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|truck|rail|courier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `target_ex_factory_date` SET TAGS ('dbx_business_glossary_term' = 'Target Ex-Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|units|pairs|dozens|cartons');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Operation ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `tertiary_work_confirmed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmed By User ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `tertiary_work_confirmed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `tertiary_work_confirmed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `efficiency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `factory_location_code` SET TAGS ('dbx_business_glossary_term' = 'Factory Location Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `factory_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Machine Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operation Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_code` SET TAGS ('dbx_business_glossary_term' = 'Operation Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Operation Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `production_line` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `production_line` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'not_inspected|passed|failed|conditional|pending');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'SHIFT_1|SHIFT_2|SHIFT_3|DAY|NIGHT|OVERTIME');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `standard_allowed_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Allowed Minutes (SAM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_order_operation` ALTER COLUMN `yield_percentage` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Order Confirmation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `reversed_confirmation_order_confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Confirmation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `work_order_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Operation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `actual_machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Machine Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `backflush_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backflush Indicator');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|posted|cancelled|reversed');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `confirmation_type` SET TAGS ('dbx_value_regex' = 'partial|final|milestone|rework|scrap');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `final_confirmation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Confirmation Indicator');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `goods_movement_posted` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Posted Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived|not_required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `setup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `teardown_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`order_confirmation` ALTER COLUMN `yield_quantity` SET TAGS ('dbx_business_glossary_term' = 'Yield Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `certified_capacity_units_per_week` SET TAGS ('dbx_business_glossary_term' = 'Certified Capacity Units Per Week');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `facility_size_sqm` SET TAGS ('dbx_business_glossary_term' = 'Facility Size Square Meters (sqm)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `factory_code` SET TAGS ('dbx_business_glossary_term' = 'Factory Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `factory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `factory_name` SET TAGS ('dbx_business_glossary_term' = 'Factory Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `factory_type` SET TAGS ('dbx_business_glossary_term' = 'Factory Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `factory_type` SET TAGS ('dbx_value_regex' = 'CMT|OEM|ODM|INTERNAL|HYBRID|SUBCONTRACTOR');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `otif_performance_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Performance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `production_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Production Capabilities');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `factory_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Capacity ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `allocated_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `available_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `available_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Labor Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `available_machine_hours` SET TAGS ('dbx_business_glossary_term' = 'Available Machine Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `booking_cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Booking Cutoff Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'open|partially_booked|fully_booked|overbooked|closed');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Priority');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_allocation_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_buffer_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Buffer Percent');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|maintenance|holiday');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|garments|dozens|units|pairs');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `efficiency_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `machine_count` SET TAGS ('dbx_business_glossary_term' = 'Machine Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Planning Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `overtime_hours_available` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Available');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `planned_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Downtime Hours');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `planning_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|daily');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `reserved_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `shift_count` SET TAGS ('dbx_business_glossary_term' = 'Shift Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `standard_minute_value` SET TAGS ('dbx_business_glossary_term' = 'Standard Minute Value (SMV)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `total_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_capacity` ALTER COLUMN `working_days` SET TAGS ('dbx_business_glossary_term' = 'Working Days');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `delivery_window_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Production Planner ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `factory_capacity_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Capacity Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `actual_cut_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cut Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `actual_ex_factory_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ex-Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `actual_finishing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finishing Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `actual_sew_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Sew End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `actual_sew_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Sew Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Reason');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `factory_capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Factory Capacity Utilization Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Production Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `locked_by` SET TAGS ('dbx_business_glossary_term' = 'Schedule Locked By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `locked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Locked Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `otif_target_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Target Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planned_cut_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Cut Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planned_ex_factory_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Ex-Factory Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planned_finishing_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finishing Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planned_sew_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Sew End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planned_sew_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Sew Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Production Planning Group');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Production Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent|rush');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_method` SET TAGS ('dbx_business_glossary_term' = 'Production Method');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_method` SET TAGS ('dbx_value_regex' = 'cmt|fob|odm|oem|in_house');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `production_type` SET TAGS ('dbx_value_regex' = 'bulk|pre_production|sample|pilot|reorder');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Master Production Schedule (MPS) Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^MPS-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Production Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `change_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Change Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `production_tna_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (T&A) Milestone ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `actual_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_approval|approved|rejected|conditional_approval');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Milestone Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `days_variance` SET TAGS ('dbx_business_glossary_term' = 'Days Variance');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `delay_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Path Milestone');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `is_customer_visible` SET TAGS ('dbx_business_glossary_term' = 'Is Customer Visible Milestone');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|cancelled|on_hold');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `quantity_at_milestone` SET TAGS ('dbx_business_glossary_term' = 'Quantity at Milestone');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `recorded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recorded Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'internal_team|factory|supplier|vendor|logistics_provider|quality_agency');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `revised_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Milestone Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_business_glossary_term' = 'Shipping Mode');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `shipping_mode` SET TAGS ('dbx_value_regex' = 'air|sea|road|rail|courier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_tna_milestone` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|units|dozens|cartons|pairs');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `pp_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Contact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `colorway_code` SET TAGS ('dbx_business_glossary_term' = 'Colorway Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `colorway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `colorway_name` SET TAGS ('dbx_business_glossary_term' = 'Colorway Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `construction_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Construction Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `construction_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `construction_comments` SET TAGS ('dbx_business_glossary_term' = 'Construction Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `critical_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Issue Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fabric_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fabric Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fabric_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fabric_comments` SET TAGS ('dbx_business_glossary_term' = 'Fabric Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fit_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Fit Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fit_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `fit_comments` SET TAGS ('dbx_business_glossary_term' = 'Fit Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `issue_severity` SET TAGS ('dbx_business_glossary_term' = 'Issue Severity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `issue_severity` SET TAGS ('dbx_value_regex' = 'Critical|Major|Minor|None');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `labeling_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Labeling Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `labeling_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `labeling_comments` SET TAGS ('dbx_business_glossary_term' = 'Labeling Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `overall_comments` SET TAGS ('dbx_business_glossary_term' = 'Overall Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `packaging_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `packaging_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `packaging_comments` SET TAGS ('dbx_business_glossary_term' = 'Packaging Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Resolved|Verified|Closed');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `revision_round` SET TAGS ('dbx_business_glossary_term' = 'Revision Round');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_cost` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Sample Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `target_production_date` SET TAGS ('dbx_business_glossary_term' = 'Target Production Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Version');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `tech_pack_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `trim_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Trim Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `trim_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Rejected|Needs Adjustment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`pp_sample` ALTER COLUMN `trim_comments` SET TAGS ('dbx_business_glossary_term' = 'Trim Comments');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `bulk_fabric_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Fabric Receipt ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Cut-Make-Trim (CMT) Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `approved_for_production_date` SET TAGS ('dbx_business_glossary_term' = 'Approved for Production Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `aql_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Inspection Result');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `aql_inspection_result` SET TAGS ('dbx_value_regex' = 'accept|reject|conditional');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `aql_level` SET TAGS ('dbx_value_regex' = '^(1.0|1.5|2.5|4.0|6.5)$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `color_fastness_result` SET TAGS ('dbx_business_glossary_term' = 'Color Fastness Test Result');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `color_fastness_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|conditional_accept|rejected');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_business_glossary_term' = 'Packing List Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'received|inspected|approved|rejected|quarantined|released_to_production');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `roll_count` SET TAGS ('dbx_business_glossary_term' = 'Roll Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shade_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Shade Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shade_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,15}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shrinkage_percentage_length` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Percentage (Length)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shrinkage_percentage_width` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Percentage (Width)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shrinkage_test_result` SET TAGS ('dbx_business_glossary_term' = 'Shrinkage Test Result');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `shrinkage_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'meters|yards|kilograms|pounds|rolls');
ALTER TABLE `apparel_fashion_ecm`.`production`.`bulk_fabric_receipt` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_order_id` SET TAGS ('dbx_business_glossary_term' = 'Cut Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cutting Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `fabric_roll_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Roll ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `ftc_label_id` SET TAGS ('dbx_business_glossary_term' = 'Ftc Label Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `marker_id` SET TAGS ('dbx_business_glossary_term' = 'Marker ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cut Room Supervisor ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `tertiary_cut_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `tertiary_cut_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `tertiary_cut_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `actual_panels_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Panels Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `bundle_ticket_generated` SET TAGS ('dbx_business_glossary_term' = 'Bundle Ticket Generated');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_date` SET TAGS ('dbx_business_glossary_term' = 'Cut Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_efficiency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cut Efficiency Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cut End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_order_number` SET TAGS ('dbx_business_glossary_term' = 'Cut Order Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_order_number` SET TAGS ('dbx_value_regex' = '^CO-[0-9]{8}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cut Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_status` SET TAGS ('dbx_business_glossary_term' = 'Cut Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cut_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|on_hold|cancelled');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `cutting_machine_code` SET TAGS ('dbx_business_glossary_term' = 'Cutting Machine ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `defect_notes` SET TAGS ('dbx_business_glossary_term' = 'Defect Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `fabric_consumption_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Fabric Consumption Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `fabric_consumption_uom` SET TAGS ('dbx_business_glossary_term' = 'Fabric Consumption Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `fabric_consumption_uom` SET TAGS ('dbx_value_regex' = 'meters|yards|feet');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `marker_efficiency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Marker Efficiency Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `marker_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Marker Reference Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `marker_reference_code` SET TAGS ('dbx_value_regex' = '^MKR-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `planned_panels_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Panels Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `ply_count` SET TAGS ('dbx_business_glossary_term' = 'Ply Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|rush');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|conditional');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `scheduled_cut_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Cut Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `size_ratio_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Size Ratio Breakdown');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `total_fabric_allocated` SET TAGS ('dbx_business_glossary_term' = 'Total Fabric Allocated');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `total_fabric_consumed` SET TAGS ('dbx_business_glossary_term' = 'Total Fabric Consumed');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `total_units_cut` SET TAGS ('dbx_business_glossary_term' = 'Total Units Cut');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `total_units_planned` SET TAGS ('dbx_business_glossary_term' = 'Total Units Planned');
ALTER TABLE `apparel_fashion_ecm`.`production`.`cut_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Engineer Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `environmental_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `cmt_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `cmt_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `complexity_rating` SET TAGS ('dbx_business_glossary_term' = 'Complexity Rating');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `complexity_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `critical_path_operations` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Operations');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `line_balancing_target` SET TAGS ('dbx_business_glossary_term' = 'Line Balancing Target');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `machine_type_requirements` SET TAGS ('dbx_business_glossary_term' = 'Machine Type Requirements');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `maximum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `minimum_batch_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Batch Size');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `operation_count` SET TAGS ('dbx_business_glossary_term' = 'Operation Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `production_line_type` SET TAGS ('dbx_business_glossary_term' = 'Production Line Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `production_line_type` SET TAGS ('dbx_value_regex' = 'modular|progressive_bundle|unit_production_system|lean_cell');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `quality_check_points` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Points');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Description');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|inactive|obsolete|under_review');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'standard|alternative|prototype|sample|bulk_production');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `skill_level_requirements` SET TAGS ('dbx_business_glossary_term' = 'Skill Level Requirements');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `skill_level_requirements` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `target_efficiency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Efficiency Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `target_output_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Target Output Per Hour');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `total_sam` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Allowed Minutes (SAM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Routing Version');
ALTER TABLE `apparel_fashion_ecm`.`production`.`routing` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `capacity_category` SET TAGS ('dbx_business_glossary_term' = 'Capacity Category');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `capacity_hours_per_day` SET TAGS ('dbx_business_glossary_term' = 'Capacity Hours Per Day');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_business_glossary_term' = 'Control Key');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `department_type` SET TAGS ('dbx_business_glossary_term' = 'Department Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `efficiency_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `formula_key` SET TAGS ('dbx_business_glossary_term' = 'Formula Key');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `labor_time_per_unit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Labor Time Per Unit Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `machine_time_per_unit_minutes` SET TAGS ('dbx_business_glossary_term' = 'Machine Time Per Unit Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `move_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Move Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `number_of_machines` SET TAGS ('dbx_business_glossary_term' = 'Number of Machines');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `number_of_operators` SET TAGS ('dbx_business_glossary_term' = 'Number of Operators');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `quality_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `queue_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Queue Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `scheduling_type` SET TAGS ('dbx_value_regex' = 'forward|backward|midpoint');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time Minutes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = 'single_shift|two_shift|three_shift|continuous');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `standard_value_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Value Unit');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `standard_value_unit` SET TAGS ('dbx_value_regex' = 'MIN|HR|SEC|DAY');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `utilization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_business_glossary_term' = 'Work Center Category');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_category` SET TAGS ('dbx_value_regex' = 'machine|labor|mixed');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_name` SET TAGS ('dbx_business_glossary_term' = 'Work Center Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_business_glossary_term' = 'Work Center Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`work_center` ALTER COLUMN `work_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|blocked|decommissioned');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `subcontracting_order_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `cmt_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Price Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `cmt_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `components_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Components Sent Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `components_sent_quantity` SET TAGS ('dbx_business_glossary_term' = 'Components Sent Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|conditional_approval');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `po_item_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Item Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `po_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `total_order_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`subcontracting_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `colorway_id` SET TAGS ('dbx_business_glossary_term' = 'Colorway Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `cut_order_id` SET TAGS ('dbx_business_glossary_term' = 'Cut Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `rework_source_lot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `aql_level` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Quality Limit (AQL) Level');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `carton_range_end` SET TAGS ('dbx_business_glossary_term' = 'Carton Range End');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `carton_range_start` SET TAGS ('dbx_business_glossary_term' = 'Carton Range Start');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `cmt_type` SET TAGS ('dbx_business_glossary_term' = 'Cut Make Trim (CMT) Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `cmt_type` SET TAGS ('dbx_value_regex' = 'cmt|fob|cm|full_package|consignment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `compliance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `compliance_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `critical_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `cut_date` SET TAGS ('dbx_business_glossary_term' = 'Cut Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `fabric_shade_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Fabric Shade Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `finishing_date` SET TAGS ('dbx_business_glossary_term' = 'Finishing Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|on_hold|cancelled|quarantined');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `major_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Major Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `minor_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Defect Count');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `produced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Produced Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|passed|failed|conditional_pass|re_inspection_required');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `rework_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rework Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `scrap_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scrap Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `sew_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sew End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `sew_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sew Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `size_range` SET TAGS ('dbx_business_glossary_term' = 'Size Range');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`production`.`lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'pieces|units|pairs|sets|dozens');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` SET TAGS ('dbx_association_edges' = 'production.factory,design.designer');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `factory_designer_collaboration_id` SET TAGS ('dbx_business_glossary_term' = 'factory_designer_collaboration Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Designer Collaboration - Designer Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Designer Collaboration - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `collaboration_type` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Type');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `factory_designer_collaboration_status` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_designer_collaboration` ALTER COLUMN `product_category_focus` SET TAGS ('dbx_business_glossary_term' = 'Product Category Focus');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` SET TAGS ('dbx_association_edges' = 'production.factory,design.embellishment');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `factory_embellishment_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Embellishment Capability - Factory Embellishment Capability Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `embellishment_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Embellishment Capability - Embellishment Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Embellishment Capability - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `capability_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Capability Certification Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_embellishment_capability` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` SET TAGS ('dbx_association_edges' = 'production.factory,compliance.compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `production_factory_certification_id` SET TAGS ('dbx_business_glossary_term' = 'production_factory_certification Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `certification_compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Certification - Compliance Certification Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Certification - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'APPROVED|CONDITIONAL|PENDING|FAILED|EXPIRED|NOT_AUDITED');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `issuing_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_factory_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` SET TAGS ('dbx_association_edges' = 'production.factory,sustainability.sustainability_initiative');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_initiative_implementation_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Initiative Implementation ID');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Initiative Implementation - Sustainability Initiative Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Initiative Implementation - Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `audit_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `audit_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_carbon_reduction_mt_co2e` SET TAGS ('dbx_business_glossary_term' = 'Factory Carbon Reduction');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_energy_savings_mwh` SET TAGS ('dbx_business_glossary_term' = 'Factory Energy Savings');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Factory Investment Amount');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_investment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Factory Investment Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_waste_diversion_kg` SET TAGS ('dbx_business_glossary_term' = 'Factory Waste Diversion');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `factory_water_savings_m3` SET TAGS ('dbx_business_glossary_term' = 'Factory Water Savings');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Actual Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_lead` SET TAGS ('dbx_business_glossary_term' = 'Implementation Lead');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Notes');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Start Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `implementation_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Target Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`production`.`factory_initiative_implementation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ALTER COLUMN `marker_id` SET TAGS ('dbx_business_glossary_term' = 'Marker Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`marker` ALTER COLUMN `revised_marker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ALTER COLUMN `fabric_roll_id` SET TAGS ('dbx_business_glossary_term' = 'Fabric Roll Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ALTER COLUMN `split_from_fabric_roll_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`fabric_roll` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` SET TAGS ('dbx_subdomain' = 'factory_resources');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ALTER COLUMN `feeds_production_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ALTER COLUMN `standard_labor_cost_per_hour` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`production_line` ALTER COLUMN `standard_overhead_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` SET TAGS ('dbx_subdomain' = 'material_handling');
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ALTER COLUMN `delivery_window_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Identifier');
ALTER TABLE `apparel_fashion_ecm`.`production`.`delivery_window` ALTER COLUMN `prior_delivery_window_id` SET TAGS ('dbx_self_ref_fk' = 'true');
