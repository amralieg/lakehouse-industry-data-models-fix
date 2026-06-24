-- Schema for Domain: procurement | Business: Manufacturing | Version: v2_mvm
-- Generated on: 2026-06-24 10:28:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_manufacturing_v1`.`procurement` COMMENT 'Purchasing and sourcing domain managing purchase requisitions, RFQs, RFPs, purchase orders, vendor selection, contract management, supplier performance evaluation, sourcing strategy, spend analysis, and procurement compliance for direct materials, indirect materials, MRO supplies, and capital equipment via SAP Ariba.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Primary key for purchase_requisition',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Engineering Change Request triggers a purchase requisition for the affected component; linking enables traceability of component‑driven procurement.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: In make-to-order and contract manufacturing, PRs are directly triggered by a specific customer accounts demand. This link enables customer-specific procurement cost tracking, demand-driven PR reporti',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supply.demand_forecast. Business justification: Demand forecasts drive requisitions; the relationship is needed for the Forecast‑Driven Requisition analysis.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Procurement requisitions are generated from Engineering Change Orders; linking provides audit of ECO‑driven spend.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: In make-to-order and special procurement manufacturing scenarios, a customer sales order directly triggers a purchase requisition. This link enables order-specific procurement cost traceability, MRP d',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or item being requested. Links to the material master data in SAP MM or inventory management system. Null for service or non-stock requisitions.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: In MRP-driven manufacturing, a purchase requisition is generated directly from a material requirement element. Procurement planners must trace PRs back to the originating material requirement for exce',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP run creates purchase requisitions; the MRP run ID is required for the MRP Run to Requisition traceability report.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Planned orders are converted to purchase requisitions; linking them enables the Planned Order Conversion audit.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the existing contract or blanket purchase order against which this requisition should be fulfilled. Null for non-contract purchases.',
    `purchase_info_record_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_info_record. Business justification: During source determination in SAP, a purchase requisition is assigned to an approved source of supply (purchase info record). purchase_requisition.source_determination_indicator: BOOLEAN flags that s',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: In make-to-order manufacturing, sales quotes trigger purchase requisitions for required materials. Linking PRs to the originating quote enables pre-order cost validation and ensures quoted margins are',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Revision-controlled procurement: when an ECO changes a component revision, PRs must be raised against the specific approved engineering revision. Supports PPAP and supplier qualification traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for the Component Procurement Planning report linking requisitions to the final product SKU they support, enabling traceability from requisition to product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Requisition planning specifies target storage location for incoming material; needed for inbound logistics allocation and warehouse capacity reports.',
    `approval_level_required` BOOLEAN COMMENT 'Number of approval levels required for this requisition based on value thresholds and organizational policy. Higher values require more senior approvals.',
    `approved_date` DATE COMMENT 'Date when the purchase requisition received final approval and became ready for sourcing. Null if not yet approved.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this requisition requires special compliance review (e.g., environmental, safety, export control). True if compliance review is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP). Used for multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition (quantity × estimated unit price). Used for budget control and approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service. Used for budget estimation and approval thresholds. Actual price is determined during sourcing and PO creation.',
    `justification_notes` STRING COMMENT 'Business justification or rationale provided by the requestor for the purchase. Required for high-value or non-standard requisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated. Tracks changes throughout the approval and sourcing lifecycle.',
    `mrp_controller` STRING COMMENT 'MRP controller responsible for material planning and requisition generation for production materials. Used for MRP-driven procurement.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where the material or service is required. Used for delivery planning and inventory allocation in SAP PP.. Valid values are `^PLT-[0-9]{4}$`',
    `po_created_date` DATE COMMENT 'Date when the purchase order was created from this requisition. Marks the transition from requisition to order in the procure-to-pay cycle.',
    `po_number` STRING COMMENT 'Purchase order number generated from this requisition after sourcing and supplier selection. Null if PO not yet created.',
    `pr_date` DATE COMMENT 'Date when the purchase requisition was created or submitted. Represents the principal business event timestamp for the requisition initiation.',
    `pr_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Typically system-generated in SAP Ariba or SAP MM.. Valid values are `^PR-[0-9]{10}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the procure-to-pay workflow. Tracks progression from draft through approval, sourcing, and conversion to purchase order. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|sourcing_assigned|po_created|cancelled|closed — 9 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the purchase requisition based on the nature of the procurement: direct materials for production, indirect materials for operations, MRO (Maintenance, Repair, and Operations) supplies, capital equipment (CapEx), services, or subcontracting work.. Valid values are `direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting`',
    `priority_code` STRING COMMENT 'Priority level of the purchase requisition. Urgent and emergency priorities expedite approval and sourcing processes.. Valid values are `low|normal|high|urgent|emergency`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for sourcing this requisition. Used for workload distribution and supplier relationship management.. Valid values are `^PG-[0-9]{3}$`',
    `purchasing_organization_code` STRING COMMENT 'Code identifying the purchasing organization responsible for procurement activities. Defines the organizational unit for supplier contracts and purchase orders.. Valid values are `^PO-[0-9]{4}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the material or service being requested. Expressed in the unit of measure specified in the UOM field.',
    `rejected_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition. Used for audit trail and process improvement.',
    `requestor_department` STRING COMMENT 'Department or organizational unit of the requestor. Used for spend analysis and budget allocation tracking.',
    `requestor_name` STRING COMMENT 'Full name of the employee who created the purchase requisition. Captured for audit trail and approval workflow visibility.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, supplies, or services must be delivered to meet operational or production requirements. Used for MRP (Material Requirements Planning) scheduling and supplier lead time calculation.',
    `source_determination_indicator` BOOLEAN COMMENT 'Indicates how the supplier source should be determined: automatic sourcing via system rules, manual buyer selection, contract-based assignment, or preferred supplier list.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity. Standard units include EA (each), KG (kilogram), L (liter), M (meter), HR (hour), etc. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|HR|SET|BOX|ROLL|SHEET — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Master record for internal purchase requisition (PR) initiated by a department or MRP run. Captures the request for direct materials, indirect materials, MRO supplies, or capital equipment before a purchase order is raised. Tracks requestor, cost center, required delivery date, material/service description, estimated value, approval status, and sourcing assignment. Serves as the originating document in the procure-to-pay cycle.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: REQUIRED: Drop‑ship to customer needs PO delivery address for logistics and billing reports.',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Purchase orders are raised against a specific BOM for a production run; linking supports BOM‑to‑PO cost tracking.',
    `ecn_id` BIGINT COMMENT 'Foreign key linking to engineering.ecn. Business justification: ECN-driven procurement traceability: when an ECN is released, procurement creates or modifies POs to implement the engineering change. Linking PO to ECN supports change management reporting — which PO',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Required for Make‑to‑Order production planning; links each purchase order to the sales order it fulfills, enabling the Order‑to‑Procure fulfillment report.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Purchase orders are issued to satisfy material requirements; the link supports the Material Requirement Fulfilment KPI.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Manufacturing procurement POs define payment terms that drive AP scheduling, supplier discount capture, and treasury cash-flow planning. Procurement experts expect purchase_order.payment_term_id → bil',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: In SAP Ariba, purchase orders are frequently issued as release orders against a framework agreement or procurement contract. Linking purchase_order to procurement_contract enables contract consumption',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: NPI and capital project procurement: tooling, prototype parts, and development materials are procured against specific engineering projects for budget tracking and project cost rollup. Manufacturing p',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: A purchase order is created from a purchase requisition in the standard procure-to-pay lifecycle (SAP Ariba). The PO is the child document that fulfills the PR. purchase_order.po_number is the POs ow',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Make-to-order manufacturing requires tracing procurement costs back to the originating sales quote for margin validation and cost-to-quote reporting. Procurement controllers and finance teams routinel',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Each purchase order fulfills a specific sales order intake; linking enables end‑to‑end order‑to‑procurement tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Needed for Order‑Driven Procurement process where purchase orders are tied to the specific product SKU being manufactured, supporting make‑to‑order execution.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific delivery address or warehouse location for goods receipt.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Supply plans dictate purchase order creation; linking PO to supply_plan enables the Supply Plan Execution report.',
    `acknowledgement_date` DATE COMMENT 'Date when the supplier acknowledged the purchase order.',
    `acknowledgement_status` STRING COMMENT 'Status indicating whether the supplier has acknowledged receipt and acceptance of the purchase order.. Valid values are `not_sent|sent|acknowledged|rejected|partially_acknowledged`',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the purchase order.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received and invoices processed.',
    `company_code` STRING COMMENT 'Financial accounting organizational unit representing the legal entity for this purchase order.. Valid values are `^[A-Z0-9]{4}$`',
    `compliance_status` STRING COMMENT 'Status indicating whether the purchase order meets all applicable procurement compliance policies and regulatory requirements.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery of goods or completion of services.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_status` STRING COMMENT 'Status indicating the extent to which ordered goods have been received against this purchase order.. Valid values are `not_received|partially_received|fully_received|over_received`',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where risk and cost transfer occurs.',
    `invoice_receipt_status` STRING COMMENT 'Status indicating the extent to which supplier invoices have been received and matched against this purchase order.. Valid values are `not_received|partially_invoiced|fully_invoiced|over_invoiced`',
    `material_category` STRING COMMENT 'High-level classification of the type of materials or services being procured. Direct materials are used in production, indirect materials support operations, MRO is maintenance/repair/operations supplies.. Valid values are `direct_material|indirect_material|mro|capital_equipment|services|subcontracting`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was last modified.',
    `net_po_value` DECIMAL(18,2) COMMENT 'Net total value of the purchase order after taxes and all adjustments.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or comments related to the purchase order.',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for the transaction.',
    `po_number` STRING COMMENT 'Externally-known unique business identifier for the purchase order. Used in supplier communications and invoice matching.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|in_progress|partially_received|fully_received|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type. Standard for one-time orders, blanket for recurring orders with release schedules, framework for long-term agreements, subcontracting for external processing, consignment for supplier-owned inventory.. Valid values are `standard|blanket|framework|contract|subcontracting|consignment`',
    `priority` STRING COMMENT 'Business priority level assigned to the purchase order affecting processing and delivery urgency.. Valid values are `low|normal|high|urgent|critical`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this purchase order.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement activities. Represents the legal entity negotiating with suppliers.. Valid values are `^[A-Z0-9]{4,10}$`',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services.',
    `shipping_method` STRING COMMENT 'Mode of transportation specified for delivery of goods.. Valid values are `air|ocean|rail|truck|courier|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order including all line items before taxes and charges.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-based purchase orders, enabling cost tracking at the project task level.. Valid values are `^[A-Z0-9-.]{8,24}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional document representing a legally binding purchase order (PO) issued to a supplier. Captures PO number, supplier, plant/delivery location, payment terms, incoterms, total PO value, currency, PO type (standard, blanket, framework, subcontracting), approval status, and confirmation status. Central document in the procure-to-pay process linking requisitions to goods receipts and supplier invoices.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line_item product.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Component-level spend analysis and approved sourcing validation: not all PO lines originate from a BOM line (spot buys, MRO). Direct component_id enables component spend reporting, approved vendor lis',
    `engineering_bom_line_id` BIGINT COMMENT 'Foreign key linking to engineering.bom_line. Business justification: Order line items are derived from BOM lines during material planning; linking enables line‑level reconciliation.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Ensures traceability of each PO line to the specific sales order line it supplies, essential for the Order‑to‑Purchase line reconciliation process.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being procured. Links to the specific product, component, or service being ordered.',
    `purchase_info_record_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_info_record. Business justification: Each PO line item is sourced from a specific purchase info record (approved source of supply in SAP). po_line_item.source_of_supply is a STRING denormalization of this relationship. Replacing it with ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Individual PO line items trace back to specific purchase requisition records in SAP. This PR-to-PO-line traceability is essential for demand fulfillment tracking, MRP reconciliation, and audit complia',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Line-level cost-to-quote traceability in make-to-order manufacturing: procurement controllers must match each PO line to the specific quoted line item to validate per-line margins, identify cost overr',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: PO line items must reference the specific SKU being purchased for 3-way match (PO-GR-Invoice), spend analytics by product, and cost accounting. Manufacturing procurement experts expect line-level SKU ',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: PO line items for MRO procurement reference specific spare parts in the asset catalog. Links procurement transactions to the spare parts register for inventory replenishment tracking, last purchase pr',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Line item defines where received material will be stored; required for put‑away execution and inventory valuation per location.',
    `account_assignment_category` STRING COMMENT 'Classification determining how procurement costs are allocated in financial accounting (e.g., to cost center, asset, WBS element, or sales order).. Valid values are `cost_center|asset|project|sales_order|network|unknown`',
    `buyer_name` STRING COMMENT 'Name of the procurement professional responsible for sourcing and managing this purchase order line item.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price and line item value (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating this line item has been marked for deletion or cancellation. Prevents further goods receipt and invoice posting.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Used for MRP planning, production scheduling, and supplier performance tracking.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating the final invoice has been received and no further invoices are expected for this line item.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt is required for this line item. Determines three-way match requirements for invoice verification.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer (e.g., EXW, FOB, CIF, DDP).',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line item. Controls accounts payable processing workflow.',
    `item_category` STRING COMMENT 'Classification of the procurement item type. Determines procurement processing rules, inventory treatment, and account assignment requirements.. Valid values are `standard|consignment|subcontracting|service|stock_transfer|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was last updated or modified.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from open through receipt to closure.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer part number for the material. Used for quality assurance and technical specification verification.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total value of this line item calculated as (quantity_ordered / price_unit) * net_price. Excludes taxes and freight charges.',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure before taxes and additional charges. Used to calculate line item total value.',
    `open_quantity` DECIMAL(18,2) COMMENT 'Outstanding quantity still to be delivered, calculated as quantity_ordered minus quantity_received. Used for supplier follow-up and expediting.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may over-deliver beyond the ordered quantity without requiring approval.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility where the material will be received and consumed. Determines receiving location and inventory posting.',
    `price_unit` DECIMAL(18,2) COMMENT 'The quantity for which the net price is valid (e.g., price per 1, per 100, per 1000 units). Used in unit price calculation.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming quality inspection is mandatory before goods receipt posting for this line item.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the supplier against this line item to date. Used for invoice verification and payment processing.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units being procured on this line item. Used for goods receipt matching and invoice verification.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Used for partial delivery tracking and open quantity calculation.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this line item.',
    `shipping_instruction` STRING COMMENT 'Special instructions for packaging, labeling, or delivery requirements specific to this line item.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item.',
    `supplier_material_number` STRING COMMENT 'The suppliers own part number or SKU for the material being procured. Used for supplier communication and catalog matching.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on tax code and net order value.',
    `tax_code` DECIMAL(18,2) COMMENT 'Tax classification code determining applicable tax rates and tax jurisdiction for this procurement line item.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may under-deliver below the ordered quantity without penalty or rejection.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is expressed (e.g., EA, KG, M, L, HR). Must align with material master and supplier agreement.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material, service, or SKU being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, storage location, account assignment (cost center, WBS element, asset), and goods receipt indicator. Enables granular spend tracking, partial delivery management, and three-way match at the item level.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: In contract manufacturing, a customer blanket order drives a back-to-back supplier procurement contract for raw materials or components. This link enables contract coverage analysis, procurement plann',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Contract quality clauses reference formal engineering specifications defining supplier acceptance criteria. Replaces denormalized quality_requirements text field with a proper FK. Supports supplier qu',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Procurement contracts in manufacturing govern payment terms for all releases and POs under the contract. Treasury and AP teams use this for cash-flow forecasting and discount management. Replaces deno',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supports Family‑Level Supply Contract Management allowing contracts to be associated with product families for volume‑discount negotiations.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Manufacturing procurement contracts are negotiated at both product-family level (already modeled) and individual SKU level for scheduling agreements and blanket orders. SKU-level contracts govern spec',
    `amendment_count` STRING COMMENT 'Total number of amendments or change orders issued against this contract since its original approval.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiration if not explicitly terminated. True for auto-renewing contracts, False otherwise.',
    `compliance_status` STRING COMMENT 'Current compliance state of the contract with internal procurement policies, regulatory requirements, and governance standards. Compliant indicates full adherence, non-compliant flags violations, under review indicates active audit, waived indicates approved exception.. Valid values are `compliant|non_compliant|under_review|waived`',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes confidentiality or non-disclosure provisions protecting proprietary information. True if confidentiality terms are present, False otherwise.',
    `contract_description` STRING COMMENT 'Detailed narrative description of the scope, purpose, and key terms of the procurement contract.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the procurement contract for easy identification and reference.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, typically assigned by SAP Ariba or ERP system.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates initial creation, pending approval awaits authorization, active is in force, suspended is temporarily halted, expired has passed end date, terminated is cancelled before expiration, closed is completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Blanket PO for recurring purchases with predefined terms, scheduling agreement for delivery schedules, value contract for spend-based limits, quantity contract for volume-based commitments, framework agreement for multi-supplier arrangements, or master agreement for overarching terms.. Valid values are `blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Primary delivery destination or plant location for materials or services procured under this contract.',
    `effective_date` DATE COMMENT 'Date when the procurement contract becomes legally binding and operational.',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date when the procurement contract term ends and is no longer in force. Nullable for open-ended contracts.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and supplier per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order release to delivery, as committed by the supplier in the contract.',
    `material_category` STRING COMMENT 'High-level classification of materials or services covered by this contract. Direct materials are production inputs, indirect materials are non-production consumables, MRO supplies are maintenance/repair/operations items, capital equipment are fixed assets, services are labor or professional services.. Valid values are `direct_materials|indirect_materials|mro_supplies|capital_equipment|services`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity per release or purchase order required by the supplier under this contract. Nullable if no MOQ is specified.',
    `penalty_clause` STRING COMMENT 'Description of financial penalties or liquidated damages applicable for supplier non-compliance with contract terms, SLA breaches, or quality failures.',
    `price_deescalation_mechanism` DECIMAL(18,2) COMMENT 'Formula or methodology for reducing contract prices based on volume commitments, market conditions, or continuous improvement targets.',
    `price_escalation_mechanism` DECIMAL(18,2) COMMENT 'Formula or methodology for adjusting contract prices over time based on indices (e.g., CPI, commodity indices), exchange rates, or negotiated percentage increases.',
    `purchasing_group` STRING COMMENT 'Buyer group or category team within the purchasing organization responsible for this contract, typically aligned to commodity or material category.',
    `purchasing_organization` STRING COMMENT 'Organizational unit or division responsible for negotiating and executing this procurement contract within the ERP system.',
    `quantity_unit` STRING COMMENT 'Unit of measure for target quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours).',
    `release_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity already released or called off against this contract through purchase orders or delivery schedules.',
    `release_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value already released or spent against this contract through purchase orders.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity still available for release under this contract, calculated as target quantity minus release quantity.',
    `remaining_value` DECIMAL(18,2) COMMENT 'Monetary value still available for release under this contract, calculated as total contract value minus release value.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto renewal is enabled. Nullable if auto renewal is not applicable.',
    `sla_terms` STRING COMMENT 'Service level commitments and performance targets defined in the contract, such as lead time, on-time delivery rate, quality standards, and response times.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned or committed quantity of materials or services to be procured under this contract for quantity-based agreements. Nullable for value-based contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract before expiration.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this procurement contract for value-based contracts, or estimated total spend for quantity-based contracts.',
    `warranty_terms` STRING COMMENT 'Warranty coverage and duration provided by the supplier for materials or services under this contract, including defect remediation and replacement terms.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master procurement contract or framework agreement established with a supplier for recurring supply of materials or services over a defined term. Captures contract number, contract type (blanket PO, scheduling agreement, value contract, quantity contract), effective/expiration dates, total contract value, target/release quantities, auto-renewal flag, SLA terms, penalty clauses, price escalation/de-escalation mechanisms, compliance status, and contract owner. Distinct from sales contracts owned by the sales domain. Supports contract coverage KPI tracking and maverick spend identification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` (
    `procurement_goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt document. Primary key for the procurement goods receipt entity.',
    `delivery_note_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_note. Business justification: The delivery note is the physical document accompanying goods; the GR is the system posting confirming receipt. Manufacturing three-way match (PO → delivery note → GR) requires this link. delivery_not',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or service received. Links to the material master for product specifications and inventory management.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level three-way matching.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the GR to the originating procurement document.',
    `revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Revision-level goods receipt traceability: received parts must be validated against the current approved engineering revision (IATF 16949, PPAP). Supports incoming inspection routing and non-conforman',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Goods receipt must be traceable to the product SKU for quality inspection routing, shelf-life expiration checks, and inventory valuation by product. Manufacturing receiving operations require this lin',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Goods receipts for MRO materials update spare part inventory levels and last_received_date. Linking GR to spare_part enables real-time stock replenishment tracking and supports min/max inventory manag',
    `stock_location_id` BIGINT COMMENT 'Identifier of the specific storage location within the warehouse where the received goods are placed. Enables precise inventory tracking.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or receiving facility where the goods were physically received.',
    `accounting_document_number` STRING COMMENT 'The financial accounting document number generated when the goods receipt value is posted to the General Ledger (GL). Links the GR to financial transactions.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the goods receipt value is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether the received goods were damaged during transit or delivery. True if damage was observed; false otherwise. Triggers quality hold and supplier notification.',
    `delivery_date` DATE COMMENT 'The actual date on which the goods were physically delivered to the receiving location. Used for supplier performance evaluation and lead time analysis.',
    `document_date` DATE COMMENT 'The date printed on the goods receipt document. May differ from the posting date for backdated or forward-dated transactions.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for tracking, auditing, and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `expiration_date` DECIMAL(18,2) COMMENT 'The date on which the received material expires or becomes unusable. Critical for perishable goods, chemicals, and materials with shelf-life constraints.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the GR is in draft, posted to inventory, blocked for quality issues, cancelled, or reversed.. Valid values are `draft|posted|blocked|cancelled|reversed`',
    `goods_receipt_value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods received, calculated as received quantity multiplied by the purchase order unit price. Posted to inventory and General Ledger (GL) accounts.',
    `gr_ir_clearing_status` STRING COMMENT 'Indicates the clearing status of the GR/IR account in accounts payable. Open means no invoice received; partially cleared means partial invoice match; fully cleared means invoice fully matched and cleared.. Valid values are `open|partially_cleared|fully_cleared`',
    `invoice_verification_flag` BOOLEAN COMMENT 'Indicates whether an invoice has been received and verified against this goods receipt as part of the three-way match process (PO-GR-Invoice). True if invoice verified; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated. Used for change tracking and audit trail purposes.',
    `manufacturing_date` DATE COMMENT 'The date on which the received material was manufactured by the supplier. Used for shelf-life calculation and quality tracking.',
    `material_document_number` STRING COMMENT 'The SAP material document number generated when the goods receipt is posted. Links the GR to inventory movements and financial postings in the ERP system.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'The fiscal year in which the material document was created. Used in combination with material document number for unique identification in SAP.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction (e.g., 101 for GR against PO, 501 for GR without PO). Drives inventory and financial posting logic.. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the receiving personnel regarding the condition of the goods, packaging issues, or any discrepancies observed during receipt.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity originally ordered on the purchase order line. Used to calculate over-delivery or under-delivery variances.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to the inventory and financial systems. This is the accounting date for inventory valuation and General Ledger (GL) posting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released to unrestricted inventory. True if inspection is required; false otherwise.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for the received goods. Determines whether goods can be moved to unrestricted stock or must remain in quality hold.. Valid values are `not_required|pending|in_progress|passed|failed|waived`',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between the received quantity and the ordered quantity. Positive values indicate over-delivery; negative values indicate under-delivery.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units physically received and recorded in this goods receipt. Used for inventory update and three-way match validation.',
    `receiving_person_name` STRING COMMENT 'The name of the individual who physically received and inspected the goods. Used for accountability and audit trail purposes.',
    `receiving_plant_code` STRING COMMENT 'The code of the manufacturing plant or facility that received the goods. Used for multi-plant inventory and cost center allocation.. Valid values are `^[A-Z0-9]{4}$`',
    `return_authorization_flag` BOOLEAN COMMENT 'Indicates whether a Return Material Authorization (RMA) has been initiated for the received goods due to quality issues, damage, or incorrect delivery. True if RMA initiated; false otherwise.',
    `reversal_date` DATE COMMENT 'The date on which this goods receipt was reversed. Used for audit trail and financial period reconciliation.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt has been reversed. Links to the cancelling document for audit trail.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed; false otherwise. Reversed GRs do not contribute to inventory or financial balances.',
    `serial_number` STRING COMMENT 'The unique serial number of the received item, applicable for serialized inventory such as equipment, tools, or high-value components.',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Unrestricted stock is available for use; quality inspection and blocked stock are not.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilogram, L for liter). Must align with the purchase order and material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number assigned by the supplier to the delivered goods. Used for supplier traceability and quality issue root cause analysis.',
    CONSTRAINT pk_procurement_goods_receipt PRIMARY KEY(`procurement_goods_receipt_id`)
) COMMENT 'Goods receipt (GR) document recorded when materials or services are physically received from a supplier against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, unit of measure, storage location, batch number, quality inspection flag, and GR/IR clearing status. Triggers inventory update and initiates the three-way match process (PO–GR–Invoice) for accounts payable.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `asset_work_order_id` BIGINT COMMENT 'Foreign key linking to asset.asset_work_order. Business justification: Supplier invoices for contracted maintenance services reference the work order performed. Enables three-way match (WO+GR+Invoice) for outsourced maintenance billing, actual cost capture against work o',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: Freight invoices from carriers reference the freight order that generated the freight cost obligation. Manufacturing freight cost reconciliation and carrier payment processing require matching supplie',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: AP aging, early-payment discount capture, and cash-flow forecasting in manufacturing require supplier invoices to reference structured payment terms. AP controllers expect supplier_invoice.payment_ter',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched in the three-way match process (PO–GR–Invoice).',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated, typically the invoice date or goods receipt date.',
    `blocking_reason` STRING COMMENT 'The reason why the invoice is blocked for payment, such as price variance, quantity variance, or quality issues.',
    `company_code` STRING COMMENT 'The company code in the ERP system to which this invoice is assigned.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied to the invoice, such as early payment discounts or volume discounts.',
    `document_date` DATE COMMENT 'The date recorded on the invoice document, which may differ from the invoice date or posting date.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied for currency conversion if the invoice currency differs from the company currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice is posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice is posted for accounting purposes.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charges included in the invoice.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and adjustments.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the supplier. This is the principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the supplier. This is the externally-known business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: parked|posted|blocked|cleared|cancelled|rejected|pending_approval — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type or category of the invoice document.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment|final`',
    `material_category` STRING COMMENT 'The category of materials or services covered by this invoice.. Valid values are `direct_material|indirect_material|mro_supplies|capital_equipment|services`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total invoice amount after all taxes, discounts, and adjustments. This is the amount payable to the supplier.',
    `payment_block_indicator` DECIMAL(18,2) COMMENT 'Flag indicating whether the invoice is blocked for payment.',
    `payment_date` DECIMAL(18,2) COMMENT 'The actual date the payment was made to the supplier.',
    `payment_due_date` DECIMAL(18,2) COMMENT 'The date by which payment must be made to the supplier according to the payment terms.',
    `payment_method` DECIMAL(18,2) COMMENT 'The method by which payment will be made to the supplier.',
    `payment_reference_number` DECIMAL(18,2) COMMENT 'The reference number assigned to the payment transaction when the invoice is paid.',
    `payment_status` DECIMAL(18,2) COMMENT 'Current payment status indicating whether the invoice has been paid.',
    `plant_code` STRING COMMENT 'The plant or facility code where the goods or services were received.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial accounting system.',
    `purchasing_group` STRING COMMENT 'The purchasing group or buyer responsible for the procurement transaction.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities related to this invoice.',
    `reference` STRING COMMENT 'Additional reference number or code provided by the supplier on the invoice document for their internal tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice, including VAT, sales tax, or other applicable taxes.',
    `tax_code` DECIMAL(18,2) COMMENT 'The tax code applied to the invoice for tax calculation purposes.',
    `tax_jurisdiction` DECIMAL(18,2) COMMENT 'The tax jurisdiction or authority under which the invoice tax is calculated.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match verification process comparing purchase order, goods receipt, and invoice.. Valid values are `matched|not_matched|partially_matched|override`',
    `tolerance_check_status` STRING COMMENT 'Result of the tolerance check comparing invoice amounts against purchase order and goods receipt amounts.. Valid values are `passed|failed|warning|not_checked`',
    `tolerance_variance_amount` DECIMAL(18,2) COMMENT 'The amount by which the invoice differs from the expected amount based on the purchase order and goods receipt.',
    `tolerance_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between the invoice amount and the expected amount.',
    `wbs_element` STRING COMMENT 'The WBS element for project-related invoices, linking the invoice to a specific project phase or deliverable.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the invoice payment.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier invoice document received from a vendor and processed for three-way match verification (PO–GR–Invoice). Captures invoice number, supplier invoice reference, invoice date, posting date, gross amount, tax amount, currency, payment due date, payment terms, invoice status (parked, posted, blocked, cleared), and tolerance check results. Serves as the SSOT for procurement-side payables within the procure-to-pay cycle.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this entity.',
    `delivery_note_id` BIGINT COMMENT 'Foreign key linking to logistics.delivery_note. Business justification: Three-way match at line level requires invoice line items to reference the delivery note confirming physical receipt of goods. Manufacturing AP teams verify invoiced quantities against delivery note q',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: INVOICE ALLOCATION: Invoice line items for equipment need a FK to the equipment register for accurate asset cost tracking.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent supplier invoice header. Links this line item to the overall invoice document.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Three-way match and invoice verification in manufacturing requires linking invoiced quantities to specific lot/batch records. AP teams verify invoiced amounts against received batches for quality-link',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the product or material being invoiced. Links to the material catalog for direct materials, indirect materials, or MRO supplies.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the purchase order line item that this invoice line corresponds to. Used for three-way matching between PO, goods receipt, and invoice.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Three-way match (PO–GR–Invoice) is the core procurement control. invoice_line_item.goods_receipt_number is a STRING denormalization of the GR reference used in three-way match verification. Replacing ',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Invoice line items must reference the product SKU for 3-way match reconciliation (PO-GR-Invoice), product-level spend reporting, and cost accounting in manufacturing finance. Currently only material_m',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: invoice_line_item is the line-level child of supplier_invoice — this is the fundamental header-line relationship for supplier invoices within the procurement domain. Currently invoice_line_item only h',
    `baseline_date` DATE COMMENT 'The baseline date from which payment terms are calculated for this line item. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `blocking_reason` STRING COMMENT 'The reason code or description explaining why this invoice line is blocked from payment. Examples include price variance exceeds tolerance, quantity mismatch, missing goods receipt, or quality hold.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount and unit price (e.g., USD, EUR, GBP, CNY). Must match the invoice header currency.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied at the line level. Reduces the line amount before tax calculation. May represent early payment discounts, volume discounts, or promotional discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percentage applied to this line item. Expressed as a percentage (e.g., 5.00 for 5% discount).',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded on the goods receipt document. Used to compare against invoiced quantity for quantity variance detection.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units being invoiced on this line. Used for three-way match verification against PO quantity and goods receipt quantity.',
    `line_amount` DECIMAL(18,2) COMMENT 'The total amount for this invoice line before taxes. Typically calculated as invoiced quantity multiplied by unit price, adjusted for any line-level discounts or surcharges.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and position of this line item on the invoice document.',
    `line_type` STRING COMMENT 'Classification of the invoice line item type. Distinguishes between material purchases, services, freight charges, handling fees, taxes, discounts, surcharges, and other cost elements. [ENUM-REF-CANDIDATE: material|service|freight|handling|tax|discount|surcharge|other — 8 candidates stripped; promote to reference product]',
    `match_status` STRING COMMENT 'The three-way match status of this invoice line. Indicates whether the line passed matching validation or has variances requiring resolution. Blocked status prevents payment until resolved.. Valid values are `matched|quantity_variance|price_variance|blocked|unmatched|pending`',
    `material_description` STRING COMMENT 'Textual description of the material, service, or item being invoiced. Provides human-readable detail about what was purchased.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount for this invoice line after applying discounts and adding taxes. Represents the final cost impact of this line item.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice line. May contain variance explanations, special handling instructions, or resolution details.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms applicable to this invoice line if different from header-level terms. May specify early payment discounts or extended payment periods.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the material or service is consumed or delivered. Used for multi-site cost allocation.',
    `po_quantity` DECIMAL(18,2) COMMENT 'The quantity specified on the original purchase order line. Used as the baseline for three-way match verification.',
    `po_unit_price` DECIMAL(18,2) COMMENT 'The unit price specified on the original purchase order line. Used as the baseline for price variance detection during invoice verification.',
    `price_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced unit price and PO unit price, multiplied by invoiced quantity. Indicates pricing discrepancies requiring review.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced quantity and goods receipt quantity. Positive values indicate over-invoicing, negative values indicate under-invoicing.',
    `serial_number` STRING COMMENT 'The serial number for serialized materials or equipment. Enables individual unit tracking for warranty, maintenance, and asset management.',
    `storage_location` STRING COMMENT 'The storage location within the plant where the material is received or stored. Used for inventory management and warehouse assignment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this invoice line based on the tax code and line amount. Added to line amount to determine total line cost.',
    `tax_code` DECIMAL(18,2) COMMENT 'The tax code applied to this invoice line. Determines the tax rate and tax jurisdiction for calculating line-level tax amounts.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to this line item. Expressed as a percentage (e.g., 7.50 for 7.5% tax rate).',
    `tolerance_group` STRING COMMENT 'The tolerance group that defines acceptable variance thresholds for this line item. Different tolerance groups may apply to different material categories or supplier relationships.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the invoiced quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours). Must align with PO and material master UOM for proper matching.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure as stated on the invoice line. Used to calculate line amount and compared against PO price for variance detection.',
    `valuation_type` STRING COMMENT 'The valuation type for split valuation scenarios where the same material is valued differently based on procurement source, quality grade, or other criteria.',
    `verification_date` DATE COMMENT 'The date when this invoice line was verified and approved for payment. Critical for tracking invoice processing cycle time and SLA compliance.',
    `verification_status` STRING COMMENT 'The current verification status of this invoice line in the approval workflow. Tracks progress through invoice verification and approval process.. Valid values are `pending|verified|rejected|on_hold|approved`',
    `wbs_element` STRING COMMENT 'The WBS element for project-related procurement. Links invoice line to specific project phases or deliverables for project cost tracking.',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Individual line item on a supplier invoice corresponding to a specific PO line, service entry sheet, or unplanned delivery cost. Captures line number, material or service description, invoiced quantity, unit price, line amount, tax code, account assignment, and three-way match status (matched, quantity variance, price variance, blocked). Enables granular invoice verification and exception management in logistics invoice verification.';

CREATE OR REPLACE TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` (
    `purchase_info_record_id` BIGINT COMMENT 'System-generated unique identifier for the purchase info record.',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material or service for which this info record is maintained.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: A purchase info record (PIR) is an approved source master that often references the procurement contract under which the supplier-material relationship is governed. purchase_info_record.contract_refer',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Purchase info records are the core vendor-SKU sourcing master data in manufacturing procurement, storing approved prices, lead times, and sourcing conditions per SKU. Manufacturing procurement experts',
    `approved_source_flag` BOOLEAN COMMENT 'Indicates whether the supplier is an approved source for the material (true = approved).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the info record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the net price is expressed.. Valid values are `^[A-Z]{3}$`',
    `fixed_source_flag` BOOLEAN COMMENT 'True if procurement must always source from this supplier for the material.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities; limited to six most common values.. Valid values are `EXW|FCA|FOB|CFR|CIF|DAP`',
    `info_record_number` STRING COMMENT 'Business identifier assigned to the purchase info record, used for reference in procurement processes.',
    `info_record_type` STRING COMMENT 'Classification of the info record indicating the sourcing strategy (e.g., standard, subcontracting, pipeline, consignment).. Valid values are `standard|subcontracting|pipeline|consignment`',
    `last_price_update_timestamp` DECIMAL(18,2) COMMENT 'Date‑time when the price information was last updated in the system.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from the approved source.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'True if the info record should be considered during MRP runs.',
    `net_price` DECIMAL(18,2) COMMENT 'Negotiated net price for the material/service from the approved supplier.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `order_quantity_multiple` DECIMAL(18,2) COMMENT 'Quantity increment that must be respected when ordering (e.g., multiples of 10).',
    `planned_delivery_time_days` STRING COMMENT 'Expected number of days from order creation to delivery for this source.',
    `plant_code` STRING COMMENT 'Code of the plant where the approved source is valid.',
    `price_change_date` DECIMAL(18,2) COMMENT 'Date on which the most recent price change became effective.',
    `price_change_indicator` DECIMAL(18,2) COMMENT 'Indicates whether the price has increased, decreased, or remained unchanged since the previous version.',
    `price_change_reason` DECIMAL(18,2) COMMENT 'Business justification for the latest price adjustment.',
    `price_unit` DECIMAL(18,2) COMMENT 'Unit of measure for the net price (e.g., per piece, per kilogram).',
    `purchase_info_record_status` STRING COMMENT 'Current lifecycle status of the info record.. Valid values are `active|inactive|blocked|pending|expired`',
    `purchasing_group` STRING COMMENT 'Group of buyers assigned to handle transactions for this info record.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities for this info record.',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the planned delivery date when a reminder is generated.',
    `source_of_supply_category` STRING COMMENT 'Broad classification of the source (e.g., internal, external, third‑party).',
    `source_priority` STRING COMMENT 'Numeric rank indicating preference order among multiple approved sources for the same material.',
    `tax_code` DECIMAL(18,2) COMMENT 'Tax classification applicable to the purchase price.',
    `tolerance_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowed deviation (percentage) from the negotiated price before a tolerance check is triggered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the info record.',
    `validity_end_date` DATE COMMENT 'Date after which the info record is no longer valid (nullable for open‑ended).',
    `validity_start_date` DATE COMMENT 'Date from which the info record becomes effective.',
    `vendor_material_number` STRING COMMENT 'Suppliers own material identifier for the supplied item.',
    `vendor_price_list` DECIMAL(18,2) COMMENT 'Reference to the suppliers price list or catalogue containing this price.',
    CONSTRAINT pk_purchase_info_record PRIMARY KEY(`purchase_info_record_id`)
) COMMENT 'Approved source master record linking a material or service to a qualified supplier, storing the negotiated price, standard order quantity, planned delivery time, tolerance limits, validity period, and plant-level sourcing assignments. Captures info record type (standard, subcontracting, pipeline, consignment), net price, price unit, minimum order quantity, reminder lead times, approved source indicators, MRP relevance flags, fixed source flags, valid-from/to dates, and outline agreement references. Drives automatic price proposals during PO creation and ensures MRP-driven orders are directed to approved suppliers at the correct plant.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ADD CONSTRAINT `fk_procurement_invoice_line_item_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ADD CONSTRAINT `fk_procurement_purchase_info_record_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_manufacturing_v1`.`procurement`.`procurement_contract`(`procurement_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_manufacturing_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'purchase_ordering');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Identifier');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_level_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Level Required');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Justification Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^PLT-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `po_created_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Created Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^PG-[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Rejected Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_business_glossary_term' = 'Source Determination Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_ordering');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `ecn_id` SET TAGS ('dbx_business_glossary_term' = 'Ecn Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|partially_acknowledged');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_received|fully_received|over_received');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_invoiced|fully_invoiced|over_invoiced');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro|capital_equipment|services|subcontracting');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `net_po_value` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Order (PO) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|contract|subcontracting|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|pickup');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{8,24}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` SET TAGS ('dbx_subdomain' = 'purchase_ordering');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|asset|project|sales_order|network|unknown');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `buyer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `buyer_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|stock_transfer|third_party');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `shipping_instruction` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instruction');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'supplier_agreements');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|waived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_materials|indirect_materials|mro_supplies|capital_equipment|services');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price De-escalation Mechanism');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Mechanism');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_business_glossary_term' = 'Release Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|blocked|cancelled|reversed');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_value` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Value');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt / Invoice Receipt (GR/IR) Clearing Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `invoice_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `return_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `asset_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Work Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment|final');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro_supplies|capital_equipment|services');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Reference');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|not_matched|partially_matched|override');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Check Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_checked');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `tolerance_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Percentage');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoice_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `delivery_note_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|blocked|unmatched|pending');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `po_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|on_hold|approved');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`invoice_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` SET TAGS ('dbx_subdomain' = 'supplier_agreements');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `approved_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `fixed_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DAP');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_business_glossary_term' = 'Info Record Type');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|pipeline|consignment');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `last_price_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'MRP Relevant Flag');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `order_quantity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Multiple');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Change Indicator');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending|expired');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `source_of_supply_category` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply Category');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `source_priority` SET TAGS ('dbx_business_glossary_term' = 'Source Priority');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `tolerance_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Limit (%)');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_manufacturing_v1`.`procurement`.`purchase_info_record` ALTER COLUMN `vendor_price_list` SET TAGS ('dbx_business_glossary_term' = 'Vendor Price List');
