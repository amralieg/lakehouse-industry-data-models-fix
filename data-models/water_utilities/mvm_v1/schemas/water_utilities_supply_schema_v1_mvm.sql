-- Schema for Domain: supply | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`supply` COMMENT 'Procurement and supply chain management including vendor management, purchase requisitions and orders, chemical procurement (chlorine, coagulants, polymers, fluoride), materials and spare parts inventory, warehouse management, contract management, supplier performance, and procurement compliance. Integrates with SAP MM for materials management supporting O&M and CIP execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `address_line1` STRING COMMENT 'Primary street address line for the vendors business location including street number and name.',
    `address_line2` STRING COMMENT 'Secondary address line for suite, building, or unit information for the vendors business location.',
    `approved_by` STRING COMMENT 'Name or identifier of the procurement manager or authority who approved the vendor for business.',
    `approved_date` DATE COMMENT 'Date when the vendor was approved for procurement transactions following vendor qualification and onboarding process.',
    `city` STRING COMMENT 'City name for the vendors business address.',
    `classification` STRING COMMENT 'Business classification indicating the vendors relationship tier and procurement priority with the utility.. Valid values are `strategic|preferred|approved|conditional|restricted`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendors business address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for vendor transactions. Typically USD for domestic water utility vendors.. Valid values are `^[A-Z]{3}$`',
    `diversity_certification` STRING COMMENT 'Diversity business certification status: Minority-owned Business Enterprise (MBE), Women-owned Business Enterprise (WBE), Disadvantaged Business Enterprise (DBE), Small Business Enterprise (SBE), Veteran-owned Business Enterprise (VBE), Service-Disabled Veteran-Owned Small Business (SDVOSB), Historically Underutilized Business Zone (HUBZone), or none. [ENUM-REF-CANDIDATE: mbe|wbe|dbe|sbe|vbe|sdvosb|hubzone|none — 8 candidates stripped; promote to reference product]',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet used for vendor credit assessment and business verification.. Valid values are `^[0-9]{9}$`',
    `email_address` STRING COMMENT 'Primary business email address for vendor communication and electronic invoice delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Business fax number for vendor document transmission if applicable.. Valid values are `^+?[0-9]{10,15}$`',
    `insurance_certificate_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current certificate of insurance meeting utility requirements is on file for this vendor.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the vendors insurance certificate on file, used to track compliance with insurance requirements.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order or invoice transaction with this vendor, used to identify inactive vendors.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was last modified or updated.',
    `name_short` STRING COMMENT 'Abbreviated or common name of the vendor used for display and reporting purposes.',
    `notes` STRING COMMENT 'Free-text field for additional vendor information, special handling instructions, or procurement notes.',
    `payment_method` STRING COMMENT 'Preferred method of payment for vendor invoices as specified in the vendor master record.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor specifying the number of days for invoice payment or early payment discount terms. [ENUM-REF-CANDIDATE: net_10|net_15|net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30 — 8 candidates stripped; promote to reference product]',
    `performance_rating` STRING COMMENT 'Overall vendor performance rating based on quality, delivery, service, and compliance metrics from vendor scorecards.. Valid values are `excellent|good|satisfactory|needs_improvement|poor|not_rated`',
    `phone_number` STRING COMMENT 'Primary business phone number for vendor contact.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP code or postal code for the vendors business address, supporting 5-digit or ZIP+4 format.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_contact_email` STRING COMMENT 'Email address for the primary contact person at the vendor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact or account manager at the vendor organization.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary contact person at the vendor.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the vendor organization.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor qualifies as a small business under SBA size standards.',
    `state_province` STRING COMMENT 'Two-letter state or province code for the vendors business address.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number used for tax reporting and 1099 processing.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with tax authorities and used in contracts.',
    `vendor_number` STRING COMMENT 'External business identifier for the vendor, typically assigned by SAP MM or procurement system. Used in purchase orders and invoices.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record indicating whether the vendor is approved for procurement transactions.. Valid values are `active|inactive|suspended|pending_approval|blocked`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the primary goods or services provided to the water utility.. Valid values are `chemical_supplier|equipment_manufacturer|spare_parts_distributor|service_contractor|professional_services|utility_provider`',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current IRS Form W-9 (Request for Taxpayer Identification Number and Certification) is on file for this vendor.',
    `website_url` STRING COMMENT 'Vendors corporate website URL for reference and product catalog access.',
    `woman_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a woman-owned business enterprise.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors providing goods and services to the water utility, including chemical suppliers (chlorine, coagulants, polymers, fluoride), equipment manufacturers, spare parts distributors, and service contractors. Captures vendor identity, classification, tax information, payment terms, approved status, diversity classification, and SAP MM vendor master attributes. Serves as the SSOT for vendor identity within the supply domain.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material catalog.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Treatment chemicals (chlorine, alum, fluoride) in material_master map to regulated contaminants via CAS number. Water utilities require this link for chemical dosing traceability, CCR reporting, and r',
    `facility_id` BIGINT COMMENT 'Reference to the water treatment plant (WTP) or wastewater treatment plant (WWTP) where this material is stocked and used. Materials may be plant-specific for operational segregation.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management: A (high-value, tight control), B (moderate-value), C (low-value, loose control), X (unclassified). Based on consumption value and criticality.. Valid values are `A|B|C|X`',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory management and procurement. Common units: EA (each), LB (pounds), GAL (gallons), KG (kilograms), L (liters), M (meters), FT (feet), M3 (cubic meters), CF (cubic feet), TON (tons), BOX, DRUM, PAIL. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether material is managed in batches with unique batch numbers for traceability. True for chemicals, coagulants, polymers, and materials requiring lot tracking for quality control and regulatory compliance.',
    `cas_number` STRING COMMENT 'Unique chemical substance identifier assigned by CAS. Used for water treatment chemicals, coagulants, polymers, disinfectants, and fluoride compounds.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for catalog governance and audit trails.',
    `critical_spare_flag` BOOLEAN COMMENT 'Indicates whether the material is a critical spare part required for emergency repairs of high-criticality assets (pumps, motors, valves, SCADA components). True for items with long lead times or single-source suppliers.',
    `discontinued_date` DATE COMMENT 'Date when the material was marked as obsolete or phased out. Used for lifecycle management and historical procurement analysis.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under OSHA, EPA, or DOT regulations. True for chemicals requiring special handling, storage, and disposal (chlorine gas, caustic soda, acids).',
    `hazmat_class` STRING COMMENT 'DOT hazard class for transportation and storage (e.g., Class 2.3 Toxic Gas for chlorine, Class 8 Corrosive for caustic soda). Required for hazardous materials only.',
    `issue_unit_of_measure` STRING COMMENT 'Unit of measure used when issuing materials from warehouse to work orders, maintenance activities, or treatment operations. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Tracks changes to descriptions, pricing, procurement parameters, or classification.',
    `lead_time_days` STRING COMMENT 'Average number of calendar days from purchase order creation to goods receipt. Used for reorder point calculation and production planning.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer or chemical producer. Used for warranty tracking, technical support, and approved vendor management.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number or catalog identifier. Critical for cross-referencing spare parts, ensuring correct replacements, and warranty claims.',
    `material_description` STRING COMMENT 'Full business description of the material, chemical, spare part, or consumable. Includes technical specifications and usage context.',
    `material_group` STRING COMMENT 'Hierarchical classification grouping materials by procurement category (e.g., water treatment chemicals, mechanical spares, electrical components, pipe fittings, meters, PPE). Used for purchasing analytics and vendor management.. Valid values are `^[A-Z0-9]{4,9}$`',
    `material_number` STRING COMMENT 'Externally-known unique material identifier used across procurement, inventory, and operations. Aligns with SAP MM material number format.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Active materials are available for procurement and use; obsolete materials are retained for historical reference only.. Valid values are `active|inactive|obsolete|pending_approval|restricted|phased_out`',
    `material_type` STRING COMMENT 'SAP MM material type classification: ROH (raw material/chemical), HALB (semi-finished), FERT (finished product), HAWA (trading goods), VERP (packaging), DIEN (services), UNBW (non-valuated), NLAG (non-stock). [ENUM-REF-CANDIDATE: ROH|HALB|FERT|HAWA|VERP|DIEN|UNBW|NLAG|ERSA|IBAU|KMAT|LEER|LEIH|PIPE — promote to reference product]',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory level for the material. Used to prevent overstocking and optimize warehouse space utilization.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum acceptable remaining shelf life at time of goods receipt. Materials received with less remaining shelf life are rejected or flagged for immediate use.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Continuously updated average unit cost based on actual procurement transactions. Used for materials with price volatility (chemicals, fuel, metals).',
    `notes` STRING COMMENT 'Free-text field for additional material information including technical specifications, usage instructions, cross-reference notes, or special handling requirements not captured in structured fields.',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is specified (e.g., price per 1, per 100, per 1000). Used when materials are priced in bulk quantities.',
    `procurement_type` STRING COMMENT 'Indicates whether material is procured externally from vendors, produced internally, both, or not procured (non-stock service items).. Valid values are `external|internal|both|no_procurement`',
    `purchase_unit_of_measure` STRING COMMENT 'Unit of measure used for procurement transactions and purchase orders. May differ from base UOM for bulk chemical purchases. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|M3|CF|TON|BOX|DRUM|PAIL — 13 candidates stripped; promote to reference product]',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic purchase requisition generation. Based on lead time demand and safety stock requirements.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory buffer maintained to prevent stockouts during lead time variability or demand spikes. Critical for essential treatment chemicals and high-criticality spare parts.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether individual units of this material are tracked by unique serial numbers. True for high-value equipment, meters, and assets requiring individual lifecycle tracking.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material remains usable from receipt date. Critical for chemicals with expiration dates (polymers, coagulants) and perishable consumables.',
    `short_description` STRING COMMENT 'Abbreviated material description for display in transaction screens, purchase orders, and inventory reports.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard unit cost used for inventory valuation and cost accounting. Updated periodically based on procurement history and market conditions.',
    `storage_condition` STRING COMMENT 'Required storage conditions for the material including temperature range, humidity control, ventilation requirements, and segregation rules. Critical for chemicals and temperature-sensitive spare parts.',
    `storage_location_code` STRING COMMENT 'Four-character code identifying the warehouse, chemical storage facility, or stockroom where the material is physically stored within the plant.. Valid values are `^[A-Z0-9]{4}$`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials used in international shipping and regulatory compliance (e.g., UN1017 for chlorine gas).. Valid values are `^UN[0-9]{4}$`',
    `valuation_class` STRING COMMENT 'Four-digit code linking material to general ledger accounts for inventory valuation, cost of goods sold, and procurement expense posting.. Valid values are `^[0-9]{4}$`',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative catalog of all materials, chemicals, spare parts, and consumables managed within the utilitys supply chain. Includes water treatment chemicals (chlorine, alum, polymer, fluoride, caustic soda), mechanical spare parts, electrical components, pipe fittings, meters, and PPE. Captures material number, description, unit of measure, material group, hazardous material flags, storage conditions, shelf life, and SAP MM material type. Aligns with SAP MM Material Master (MARA/MARC).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Requisitions for project-specific materials and services require formal project linkage for approval workflow, budget validation, and procurement planning. Water utilities capital procurement processe',
    `cost_center_id` BIGINT COMMENT 'Cost center code of the department or operational unit initiating the requisition. Used for budget tracking and financial allocation.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Requisitions check budget availability for pre-encumbrance control. Standard budget workflow ensuring requisitions have budget authority before approval and PO creation.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Requisitions check fund availability before approval in governmental accounting. Required budget control ensuring requisitions dont exceed fund appropriations before PO creation.',
    `general_ledger_id` BIGINT COMMENT 'General ledger account number to which the requisition cost will be charged. Used for financial reporting and compliance with Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB).',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Grant-funded requisitions in water utilities require pre-encumbrance tracking against grant balances before PO issuance. Linking requisitions to grants enables grant budget availability checking and e',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Purchase requisitions request specific materials from the material catalog. Currently uses denormalized material_code STRING; should be proper FK to material_master. Removes redundant material_code, m',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: purchase_requisition has requesting_storage_location (STRING) representing the physical storage location where the requested material should be delivered. Normalizing this to requesting_warehouse_loca',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: purchase_requisition has vendor_code (STRING) representing the preferred or suggested vendor for the requisition. This is a real business relationship — requisitioners often specify a preferred vendor',
    `account_assignment_category` STRING COMMENT 'Type of financial account assignment for the requisition: cost center for Operations and Maintenance (O&M), work order for maintenance tasks, project for Capital Improvement Program (CIP), asset for asset procurement, or sales order for third-party.. Valid values are `cost_center|work_order|project|asset|sales_order`',
    `approval_date` DATE COMMENT 'Date when the requisition was approved by the authorized approver.',
    `asset_number` STRING COMMENT 'Asset master number if the requisition is for procurement of a new asset or major component to be capitalized.. Valid values are `^[A-Z0-9]{8,12}$`',
    `contract_number` STRING COMMENT 'Reference to an existing contract or blanket purchase agreement under which this requisition should be processed.. Valid values are `^[A-Z0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system. Used for audit trail and process analytics.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition (quantity × estimated unit price), used for financial approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service, used for budget planning and approval thresholds.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was last updated. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Additional free-text notes or special instructions provided by the requisitioner to guide procurement or delivery.',
    `priority_code` STRING COMMENT 'Urgency level of the requisition indicating how quickly the procurement must be processed.. Valid values are `low|normal|high|urgent|emergency`',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated from this requisition once it has been converted by the purchasing department.. Valid values are `^[A-Z0-9]{10}$`',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer code responsible for processing the requisition and creating the purchase order.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Purchasing organization code responsible for procurement activities. May represent a regional or centralized procurement function.. Valid values are `^[A-Z0-9]{4}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material or service units requested in the requisition.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the requisition was rejected. Used for feedback and process improvement.',
    `requesting_plant_code` STRING COMMENT 'Plant or facility code where the materials or services are required. Corresponds to Water Treatment Plant (WTP) or Wastewater Treatment Plant (WWTP) location.. Valid values are `^[A-Z0-9]{4}$`',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials or services must be delivered to meet operational or project needs.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requesting department.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Corresponds to SAP BANF number.. Valid values are `^[A-Z0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_ordered|fully_ordered|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on procurement category: standard purchase, stock replenishment, service procurement, subcontracting, consignment, or third-party.. Valid values are `standard|stock|service|subcontracting|consignment|third_party`',
    `requisitioner_name` STRING COMMENT 'Full name of the employee who created the requisition. Provides human-readable context for the request.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which the requisition originated (SAP MM, IBM Maximo CMMS, Microsoft Dynamics 365, or manual entry).. Valid values are `SAP_MM|MAXIMO|DYNAMICS|MANUAL`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity (e.g., EA for each, LB for pounds, GAL for gallons, KG for kilograms).. Valid values are `^[A-Z]{2,3}$`',
    `work_order_number` STRING COMMENT 'Reference to the originating work order in the Computerized Maintenance Management System (CMMS) such as IBM Maximo, if the requisition is triggered by a maintenance or repair task.. Valid values are `^[A-Z0-9]{8,12}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request to procure materials or services, initiated by operations, maintenance, or project teams. Captures requisition number, requesting cost center, material or service description, quantity, estimated value, required delivery date, priority, approval status, and originating work order or CIP project reference. Represents the demand signal that triggers the procurement workflow in SAP MM (BANF/EBAN).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Capital equipment and materials procurement for CIP projects requires direct project assignment on POs for cost allocation, budget tracking, and financial reporting. Water utilities track project cost',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which this purchase order expenditure is charged. Used for Operations and Maintenance (O&M) or Capital Expenditure (CAPEX) tracking.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: POs consume budget line allocations for encumbrance accounting. Core budget control requirement linking purchase commitments to approved budgets for spending authority validation.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: POs encumber fund budgets in governmental accounting per GASB standards. Critical for public water utility fund accounting, ensuring expenditures charge correct funds (operating, capital, debt service',
    `general_ledger_id` BIGINT COMMENT 'General ledger account code for financial posting of this purchase order. Aligns with chart of accounts.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Water utilities frequently procure materials and services under EPA/SRF/FEMA grants. Linking POs to grants enables grant expenditure tracking, allowable cost verification, and federal audit compliance',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Purchase orders can be issued against blanket procurement contracts. Currently uses denormalized contract_number STRING; should be proper FK to enable contract compliance tracking and spend rollup. Ca',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: Purchase orders are created FROM purchase requisitions in the procurement workflow. Currently uses denormalized requisition_number STRING; should be proper FK. This enables tracing PO back to originat',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Purchase orders specify delivery location. Currently uses denormalized ship_to_location_code STRING; should be proper FK to warehouse_location. Label prefix ship_to_ distinguishes this from other po',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor to whom this purchase order is issued. Links to vendor master data.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Purchase orders for capital project scope are assigned to WBS elements for budget encumbrance and project cost control. The plain-text wbs_element column is a denormalization. Water utilities projec',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval and was authorized for issuance to vendor.',
    `approval_status` STRING COMMENT 'Current state in the purchase order approval workflow. Tracks progression through approval chain based on dollar thresholds and authority matrix.. Valid values are `not_submitted|pending|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the approving authority who authorized this purchase order. May be manager, director, or executive based on approval limits.',
    `buyer_email` STRING COMMENT 'Email address of the procurement buyer for vendor communication and order inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer who created and manages this purchase order.',
    `buyer_phone` STRING COMMENT 'Contact phone number of the procurement buyer.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line1` STRING COMMENT 'Primary street address line for delivery location. May be Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), warehouse, or field site.',
    `delivery_address_line2` STRING COMMENT 'Secondary address line for delivery location (building, suite, department).',
    `delivery_city` STRING COMMENT 'City name for the delivery location.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for the delivery location.. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery location.',
    `delivery_state` STRING COMMENT 'Two-letter state or province code for the delivery location.. Valid values are `^[A-Z]{2}$`',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping and freight charges associated with this purchase order. May be included in line items or as separate charge.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_capital_purchase` BOOLEAN COMMENT 'Indicates whether this purchase order is for capital assets (CAPEX) versus operating expenses (OPEX). True for Capital Improvement Program (CIP) purchases.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last updated. Tracks changes to PO details, status, or line items.',
    `notes` STRING COMMENT 'Free-text notes and special instructions for the vendor or internal procurement team. May include delivery instructions, quality requirements, or compliance notes.',
    `payment_terms` STRING COMMENT 'Agreed payment terms with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due after invoice receipt.',
    `po_date` DATE COMMENT 'Date when the purchase order was created or issued. Principal business event timestamp for procurement tracking.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Unique document number used in vendor communications and invoice matching.. Valid values are `^[A-Z0-9]{10,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle state of the purchase order. Tracks progression from creation through approval, issuance, receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement category. Standard for one-time purchases, blanket for recurring, contract for long-term agreements, emergency for urgent needs, capital for Capital Improvement Program (CIP) assets, service for professional services.. Valid values are `standard|blanket|contract|emergency|capital|service`',
    `promised_delivery_date` DATE COMMENT 'Date confirmed by the vendor for delivery. May differ from requested date based on vendor capacity and lead time.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for planning and vendor performance tracking.',
    `requestor_name` STRING COMMENT 'Name of the employee or department that originated the purchase request. May be operations, maintenance, or capital projects team.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order. Includes sales tax, use tax, or value-added tax (VAT) as applicable.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and fees. Represents committed spend.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'Grand total of the purchase order including base amount, taxes, and freight. Represents total financial commitment.',
    `vendor_site_code` STRING COMMENT 'Specific vendor location or site code for delivery and invoicing purposes. Used when vendor has multiple facilities.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal procurement document issued to a vendor for the supply of materials or services at agreed price and delivery terms, including release orders against blanket contracts and scheduling agreements. Captures PO number, vendor, document type (standard, release, framework call-off), parent contract reference, line items, quantities, unit prices, total value, delivery address (WTP, WWTP, warehouse), payment terms, incoterms, approval chain, cumulative released value versus contract ceiling, and SAP MM document type. Supports both O&M consumables and CIP capital procurement. Aligns with SAP MM Purchase Order (EKKO/EKPO).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Cost center code to which Operating Expenditure (OPEX) for this line item is charged. Used for departmental cost tracking and O&M budget management.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Individual PO line items in water utilities can be split-coded to different budget lines (e.g., capital vs. operating, different projects). Line-level budget coding is required for encumbrance account',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Line items allocate to funds for detailed encumbrance tracking in governmental accounting. Enables fund-level budget monitoring and GASB-compliant financial reporting for water utilities.',
    `general_ledger_id` BIGINT COMMENT 'General Ledger account number to which this line item expenditure is posted. Used for financial reporting in accordance with Generally Accepted Accounting Principles (GAAP) and Governmental Accounting Standards Board (GASB) standards for municipal utilities.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record being procured. Identifies the specific chemical, spare part, equipment, or service item.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: PO line items are created FROM purchase requisition line items in the procurement workflow. This traces each PO line back to the originating business need for audit and requirement fulfillment trackin',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: po_line_item has storage_location (STRING) representing the intended storage location for the ordered material. Normalizing this to storage_warehouse_location_id as a proper FK to warehouse_location c',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: PO line items for capital project materials and services are assigned to WBS elements for budget commitment tracking and project cost control. The plain-text wbs_element column is a denormalization.',
    `account_assignment_category` STRING COMMENT 'Type of financial account assignment for this line item. Determines whether costs are charged to a cost center (Operations and Maintenance / O&M), asset (capitalized equipment), Work Breakdown Structure (WBS) element (Capital Improvement Program / CIP project), or internal order.. Valid values are `cost_center|asset|wbs_element|order|network`',
    `asset_number` STRING COMMENT 'Fixed asset number for capitalized equipment or infrastructure. Used when the procurement is for a capital asset that will be depreciated over its useful life.. Valid values are `^[A-Z0-9]{8,12}$`',
    `confirmation_control_key` STRING COMMENT 'Control key determining whether and how vendor confirmations (order acknowledgments, shipping notifications) are required for this line item. Used for supply chain visibility and delivery tracking.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order line item record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price. Typically USD for US-based water utilities.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. Deleted line items are excluded from further processing but retained for audit trail.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Critical for chemical inventory management and project scheduling in Capital Improvement Program (CIP) and Operations and Maintenance (O&M) activities.',
    `delivery_status` STRING COMMENT 'Current delivery fulfillment status of this line item. Tracks progress from order placement through complete goods receipt.. Valid values are `not_delivered|partially_delivered|fully_delivered|over_delivered`',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether a goods receipt is required for this line item. True for materials requiring physical receipt confirmation; false for services or non-stock items.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Updated as goods receipts are posted. Used to track delivery fulfillment and outstanding quantities.',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced against this line item to date. Used for invoice verification and to identify discrepancies between ordered, received, and invoiced quantities.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether an invoice is expected for this line item. Used to control invoice verification and three-way matching (PO, goods receipt, invoice) in accounts payable processing.',
    `item_category` STRING COMMENT 'Classification of the procurement line item type. Determines procurement processing rules, inventory treatment, and account assignment behavior.. Valid values are `standard|consignment|subcontracting|service|stock_transfer|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this line item record. Tracks changes to quantities, prices, delivery dates, or other line item attributes.',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Determines the ordering and position of this item in the multi-line PO document.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number. Critical for spare parts procurement to ensure compatibility with existing equipment in treatment plants and distribution infrastructure.',
    `material_group` STRING COMMENT 'Material group classification code for procurement analytics and spend categorization. Groups similar materials (e.g., all treatment chemicals, all pipe fittings, all electrical components) for supplier performance analysis and contract management.. Valid values are `^[A-Z0-9]{4,9}$`',
    `material_number` STRING COMMENT 'Business identifier for the material being procured. Alphanumeric code used across procurement, inventory, and operations to identify chemicals (chlorine, coagulants, polymers, fluoride), spare parts, equipment, or services.. Valid values are `^[A-Z0-9]{6,18}$`',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value for this line item, calculated as quantity_ordered multiplied by net_price, adjusted for price_unit. Excludes taxes.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit of measure for this line item, excluding taxes and discounts. Used to calculate line item total value.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Expressed as a percentage (e.g., 5.00 for 5%).',
    `plant_code` STRING COMMENT 'Four-character code identifying the receiving plant or facility. Typically represents a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), or warehouse location.. Valid values are `^[A-Z0-9]{4}$`',
    `price_unit` STRING COMMENT 'Number of units to which the net price applies. For example, if price is $100 per 10 gallons, price_unit would be 10.',
    `purchase_requisition_item` STRING COMMENT 'Line item number within the source purchase requisition. Used in conjunction with purchase_requisition_number for complete requisition-to-PO traceability.',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the buyer or purchasing team responsible for this procurement. Used for workload distribution and buyer performance tracking.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of material or service ordered on this line item. Expressed in the unit of measure specified for this line.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this PO line item. Used for procurement tracking and accountability.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item, especially useful for non-stock materials or services.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code determining applicable sales tax, use tax, or VAT for this line item. Used for tax calculation and compliance reporting.. Valid values are `^[A-Z0-9]{1,2}$`',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Expressed as a percentage (e.g., 2.00 for 2%).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. Common units include EA (each), GAL (gallons) for chemicals, LB (pounds), KG (kilograms), HR (hours) for services, TON for bulk materials. [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|TON|CY|HR|DAY — 11 candidates stripped; promote to reference product]',
    `vendor_material_number` STRING COMMENT 'Vendors own material or catalog number for the item being procured. Used for cross-reference and to ensure correct item is supplied, especially critical for chemical procurement (chlorine, coagulants, polymers, fluoride).',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material or service being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, account assignment (cost center, WBS element, asset), goods receipt indicator, invoice receipt indicator, and delivery status. Enables granular tracking of multi-line procurement transactions. Aligns with SAP MM EKPO table.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record.',
    `facility_id` BIGINT COMMENT 'Reference to the utility facility where the goods were received. May be a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), warehouse, or field location.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Goods receipts post to GL accounts for inventory valuation and expense recognition in direct-charge scenarios. Required for three-way match accounting and inventory-to-GL reconciliation.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: Goods receipts are posted against specific PO line items, not just the header. This is critical for three-way matching (PO line, GR, Invoice) in accounts payable. Currently uses denormalized purchase_',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item received. Links to chemicals, spare parts, equipment, or other materials.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods or services were received. Links to the originating procurement document.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who delivered the goods or services. Links to the vendor master record.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Goods receipts post inventory to specific warehouse locations. Currently uses denormalized storage_location_code STRING; should be proper FK to enable location-based inventory tracking and capacity ma',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received material, particularly important for chemicals (chlorine, coagulants, polymers, fluoride) for traceability and quality control.',
    `created_by_user` STRING COMMENT 'The system user ID who created this goods receipt record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this goods receipt record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount. Typically USD for US-based water utilities.. Valid values are `^[A-Z]{3}$`',
    `delivery_condition` STRING COMMENT 'The physical condition of the delivered goods at the time of receipt. Good indicates acceptable condition, damaged indicates physical damage, partial indicates incomplete delivery, incorrect indicates wrong items, contaminated indicates quality issues.. Valid values are `good|damaged|partial|incorrect|contaminated`',
    `delivery_note_number` STRING COMMENT 'The delivery note or packing slip number provided by the vendor at the time of delivery. Used for cross-referencing with vendor documentation.',
    `delivery_notes` STRING COMMENT 'Free-text notes or comments recorded by receiving personnel regarding the delivery. May include observations about packaging, condition, discrepancies, or special handling.',
    `gr_document_date` DATE COMMENT 'The date on the goods receipt document, typically the date of physical receipt or delivery note date.',
    `gr_document_number` STRING COMMENT 'The externally-known goods receipt document number generated by the ERP system. Used for tracking and audit purposes.. Valid values are `^[0-9]{10}$`',
    `gr_posting_date` DATE COMMENT 'The date when the goods receipt was posted in the system. This is the principal business event timestamp for inventory valuation and financial accounting.',
    `gr_status` STRING COMMENT 'Current status of the goods receipt transaction in its lifecycle. Posted indicates successful receipt, reversed indicates cancellation, pending inspection indicates awaiting QC, completed indicates fully processed.. Valid values are `posted|reversed|cancelled|pending_inspection|completed`',
    `inspection_lot_number` STRING COMMENT 'The quality inspection lot number created for this goods receipt if quality inspection is required. Links to quality management records.',
    `invoice_verification_date` DATE COMMENT 'The date when the vendor invoice was verified and matched against this goods receipt. Null if invoice not yet received or verified.',
    `last_modified_by_user` STRING COMMENT 'The system user ID who last modified this goods receipt record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this goods receipt record was last modified. Used for audit trail and change tracking.',
    `material_document_year` STRING COMMENT 'The fiscal year in which the goods receipt material document was created. Used as part of the document key in SAP MM.',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the type of goods receipt transaction. Common types: 101 (GR for PO), 103 (GR into blocked stock), 105 (GR from release order), 161 (GR for returnable transport packaging), 501 (GR without PO), 511 (GR from delivery without PO). [ENUM-REF-CANDIDATE: 101|103|105|161|501|511|Z01|Z02 — 8 candidates stripped; promote to reference product]',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received material requires quality inspection before it can be released for use. True if inspection is required, False otherwise.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service received and accepted. Measured in the base unit of measure for the material.',
    `receiving_personnel_name` STRING COMMENT 'The name of the warehouse or operations personnel who physically received and verified the goods. Used for accountability and audit purposes.',
    `reversal_date` DATE COMMENT 'The date when this goods receipt was reversed or cancelled. Null if not reversed.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt was cancelled. Used for audit trail and reconciliation.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed, False if active.',
    `reversal_reason_code` STRING COMMENT 'The reason code explaining why this goods receipt was reversed. Examples include incorrect quantity, wrong material, damaged goods, vendor return.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as consignment stock, returnable packaging, or project stock. Blank for standard stock.',
    `stock_type` STRING COMMENT 'The type of stock into which the material was received. Unrestricted stock is available for use, quality inspection stock is pending QC, blocked stock is not available, restricted stock has limited use.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and vendor invoice. Matched indicates all documents agree, variance indicates discrepancies, blocked indicates payment hold.. Valid values are `pending|matched|variance|blocked`',
    `total_amount` DECIMAL(18,2) COMMENT 'The total value of the goods receipt calculated as received quantity multiplied by unit price. Used for financial posting and invoice verification.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the received quantity. Common units include EA (each), GAL (gallons) for chemicals, LB (pounds), KG (kilograms), L (liters), TON (tons), DRUM, CYL (cylinder). [ENUM-REF-CANDIDATE: EA|LB|GAL|KG|L|M|FT|TON|BAG|DRUM|PAIL|CYL|BOX — 13 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the received material as per the purchase order. Used for inventory valuation and three-way match.',
    `unloading_point` STRING COMMENT 'The specific physical location or dock where the goods were unloaded at the facility. Used for logistics tracking and facility management.',
    `valuation_type` STRING COMMENT 'The valuation type used for split valuation of materials with different prices or qualities. Used when the same material is valued differently based on source or quality.',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number provided by the vendor on the delivery documentation. Used for vendor traceability and quality issues.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of materials, chemicals, or services at a utility facility (WTP, WWTP, warehouse, field location) against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, storage location, batch/lot number, supplier lot number for chemicals, certificate of analysis reference, quality inspection flag, acceptance status, storage tank or container assigned, delivery vehicle, SDS version, and movement type. Triggers inventory update and three-way match for invoice verification. Supports chemical traceability and regulatory compliance for treatment chemical receipts. Aligns with SAP MM Goods Receipt (MIGO/MSEG).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique identifier for the inventory stock record. Primary key for the inventory stock data product.',
    `facility_id` BIGINT COMMENT 'Reference to the plant or facility where the storage location resides. Links to WTP, WWTP, or operations center.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record. Links to the material being stocked (chemicals, spare parts, equipment, consumables).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Territory-level inventory planning and emergency response SLA compliance require knowing which service territory each stock location serves. Utilities track available pipe repair materials and meters ',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the storage location where the material is held. Links to warehouse, chemical storage facility, or field storeroom.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management prioritization. A = high-value/critical items requiring tight control; B = moderate-value items; C = low-value items with relaxed controls.. Valid values are `A|B|C`',
    `available_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for new consumption or reservation. Calculated as unrestricted stock minus reserved quantity.',
    `average_daily_consumption` DECIMAL(18,2) COMMENT 'Average quantity consumed per day based on historical usage. Used for demand forecasting and reorder point calculation.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether this material is managed at the batch level. True for chemicals and materials requiring lot tracking for quality, expiration, or regulatory compliance.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked from use due to quality issues, expiration, damage, or regulatory hold. Cannot be issued until block is removed.',
    `consignment_stock_flag` BOOLEAN COMMENT 'Indicates whether this stock is held on consignment from a vendor. Consignment stock remains vendor-owned until consumed, reducing carrying costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory stock record was first created in the system.',
    `cycle_count_indicator` STRING COMMENT 'Frequency classification for cycle counting. A = high-frequency (monthly); B = medium-frequency (quarterly); C = low-frequency (annual); X = excluded from cycle counting.. Valid values are `A|B|C|X`',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Number of days the current available stock will last based on average daily consumption. Calculated as available quantity divided by average daily consumption.',
    `expiration_controlled_flag` BOOLEAN COMMENT 'Indicates whether the material has a limited shelf life and requires expiration date tracking. True for chemicals, reagents, and time-sensitive consumables.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and regulatory compliance (e.g., chlorine gas, sodium hypochlorite, acids).',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased stock for this material at this location.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased stock for this material at this location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory stock record was last updated. Tracks any change to stock quantities, valuation, or master data attributes.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical inventory count for this material at this storage location. Used to track inventory accuracy and compliance with audit requirements.',
    `last_stock_adjustment_date` DATE COMMENT 'Date of the most recent manual stock adjustment or inventory correction transaction for this material at this location.',
    `lead_time_days` STRING COMMENT 'Planned delivery time in days from purchase requisition creation to goods receipt. Used for reorder point calculation and procurement planning.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum quantity to be maintained in stock. Used for inventory optimization and to prevent overstocking of chemicals with limited shelf life or high carrying costs.',
    `mrp_type` STRING COMMENT 'MRP procedure used for automatic replenishment. PD = MRP; VB = manual reorder point; VM = forecast-based planning; ND = no planning.. Valid values are `PD|VB|VM|ND`',
    `plant_code` STRING COMMENT 'Four-character code identifying the plant or facility (e.g., WTP1, WWTP2, DIST).. Valid values are `^[A-Z0-9]{4}$`',
    `procurement_type` STRING COMMENT 'Indicates how the material is procured. External = purchased from vendors; In-house = manufactured or produced internally; Both = can be procured either way.. Valid values are `external|in_house|both`',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently under quality inspection. Stock is on hold pending laboratory testing or quality assurance approval before release to unrestricted use.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum stock level that triggers automatic replenishment. When available quantity falls below this threshold, a purchase requisition is generated.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of unrestricted stock reserved for specific work orders, maintenance activities, or planned consumption. Reserved stock is committed but not yet issued.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock maintained to protect against stockouts due to demand variability or supply delays. Critical for chemicals required for continuous treatment operations.',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Indicates whether this material is managed at the serial number level. True for high-value equipment and assets requiring individual unit tracking.',
    `stock_status` STRING COMMENT 'Current status of stock availability. Derived from comparison of available quantity against reorder point and maximum stock level thresholds.. Valid values are `in_stock|low_stock|out_of_stock|overstocked|obsolete`',
    `stock_turnover_ratio` DECIMAL(18,2) COMMENT 'Number of times inventory is consumed and replenished during a period. Indicates inventory efficiency and demand velocity.',
    `stock_type` STRING COMMENT 'Classification of stock ownership and purpose. Distinguishes between utility-owned stock, vendor consignment, project-specific stock, and other special stock categories.. Valid values are `own|consignment|project|subcontracting|returnable_packaging`',
    `stock_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of unrestricted stock at this location. Calculated as unrestricted quantity multiplied by material standard price or moving average price.',
    `storage_location_code` STRING COMMENT 'Four-character alphanumeric code identifying the storage location (e.g., WTP chemical storage, WWTP chemical storage, central warehouse, field storeroom).. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for stock quantities (e.g., EA for each, LB for pounds, GAL for gallons, KG for kilograms, L for liters).. Valid values are `^[A-Z]{2,3}$`',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for unrestricted use. This stock is available for consumption, transfer, or issue to work orders and operations.',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for stock valuation (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Current stock levels for all materials and chemicals held across utility warehouses, treatment plant storage, and field storerooms. Captures material number, storage location, plant, unrestricted stock quantity, quality inspection stock, blocked stock, reserved quantity, reorder point, maximum stock level, safety stock level, days of supply remaining, last physical inventory date, book vs counted quantity (for physical inventory reconciliation), chemical-specific attributes (tank ID, expiry date, hazmat classification), and last replenishment date. Supports chemical dosing continuity, maintenance spare parts availability, and physical inventory audit. Aligns with SAP MM stock overview (MARD/MMBE) and physical inventory (IKPF/ISEG).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement record.',
    `backwash_event_id` BIGINT COMMENT 'Foreign key linking to treatment.backwash_event. Business justification: Backwash events consume filter media and backwash chemicals, generating specific stock movements. Linking stock_movement to backwash_event enables per-event material consumption tracking, filter media',
    `chemical_dose_event_id` BIGINT COMMENT 'Foreign key linking to treatment.chemical_dose_event. Business justification: Chemical consumption stock movements in water treatment are directly triggered by dosing events. Linking stock_movement to chemical_dose_event enables chemical consumption cost accounting, inventory d',
    `cost_center_id` BIGINT COMMENT 'Ten-character cost center code to which the material movement cost is charged. Used for internal consumption and expense allocation.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Stock movements track transfers between warehouse locations. Currently uses denormalized storage_location_from STRING; should be proper FK. Label prefix from_ distinguishes source location from dest',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Stock movements (issues to work orders, projects, or departments) in water utilities require fund coding for GASB governmental accounting compliance. Materials issued from inventory must be charged to',
    `general_ledger_id` BIGINT COMMENT 'Ten-digit general ledger account number to which the material movement value is posted. Determines the financial accounting impact.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Stock movements of type goods receipt should link to the originating goods_receipt record for full traceability. Currently uses denormalized goods_receipt_slip_number STRING; should be proper FK. En',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: stock_movement currently references purchase_order_id (existing FK) and stores purchase_order_item (INT) as a denormalized line item number. Adding po_line_item_id as a proper FK to po_line_item norma',
    `material_master_id` BIGINT COMMENT 'Reference to the material being moved. Links to the material master record for chemicals, spare parts, or other inventory items.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Stock movements related to procurement should link to the originating purchase order for cost tracking and audit trail. Currently uses denormalized purchase_order_number STRING; should be proper FK. C',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor from whom material was received (for goods receipt movements). Null for internal movements and issues.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: In water utilities capital projects, inventory issues (goods issues) are charged to WBS elements for project cost capitalization and CIP cost tracking. The existing plain-text wbs_element column is ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Material consumption (goods issues, movement type 261) is posted against work orders in SAP PM. Linking stock_movement to work_order enables accurate material cost tracking per work order — required f',
    `amount_in_local_currency` DECIMAL(18,2) COMMENT 'The monetary value of the material movement in the local currency of the plant (typically USD for U.S. water utilities). Calculated as quantity × unit price.',
    `asset_number` STRING COMMENT 'Fixed asset number if this material movement is capitalized as part of an asset acquisition or improvement. Links to asset management for depreciation tracking.. Valid values are `^[0-9]{12}$`',
    `batch_number` STRING COMMENT 'Unique identifier for the batch or lot of material being moved. Critical for chemicals (chlorine, coagulants, polymers) to track expiration, quality, and traceability.. Valid values are `^[A-Z0-9]{1,10}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'External document number from the vendors delivery note or packing slip. Used for goods receipt reconciliation and proof of delivery.. Valid values are `^[A-Z0-9]{1,16}$`',
    `document_date` DATE COMMENT 'The date printed on the external document (e.g., delivery note, packing slip, invoice) that accompanies the material movement. May differ from posting date.',
    `entry_date` DATE COMMENT 'The date on which the material document was created in the system. Audit timestamp for record creation.',
    `entry_time` TIMESTAMP COMMENT 'Timestamp when the material document was created in the system. Provides precise audit trail for transaction timing.',
    `material_document_number` STRING COMMENT 'The externally-known unique document number assigned to this material movement transaction in the ERP system. Serves as the business identifier for traceability and audit.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Part of the compound key in SAP MM along with material document number.',
    `movement_indicator` STRING COMMENT 'Single-character indicator for special movement scenarios: B=Goods Movement for Purchase Order, H=Reversal Movement, F=Goods Movement for Production Order, E=Goods Movement for Sales Order, L=Goods Movement for Delivery.. Valid values are `B|H|F|E|L`',
    `movement_status` STRING COMMENT 'Current lifecycle status of the material movement transaction: posted=Successfully posted to inventory and accounting, pending=Awaiting approval or verification, cancelled=Reversed or voided, error=Failed posting requiring correction.. Valid values are `posted|pending|cancelled|error`',
    `movement_type` STRING COMMENT 'Three-digit code classifying the type of inventory movement (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Work Order, 311=Transfer Posting, 122=Return to Vendor, 701=Physical Inventory Adjustment). Determines the accounting and inventory impact.. Valid values are `^[0-9]{3}$`',
    `physical_inventory_document_number` STRING COMMENT 'Reference to the physical inventory count document if this movement is an inventory adjustment resulting from a cycle count or annual physical inventory.. Valid values are `^[0-9]{10}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the plant or facility where the material movement occurred (e.g., WTP1=Water Treatment Plant 1, WWTP=Wastewater Treatment Plant).. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the material movement was posted to inventory and financial accounting. Represents the business event date for the transaction.',
    `profit_center` STRING COMMENT 'Ten-character profit center code for internal management accounting and segment reporting. Used to allocate costs and revenues to business units or service areas.. Valid values are `^[A-Z0-9]{10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material moved in this transaction, expressed in the base unit of measure. Positive for receipts, negative for issues.',
    `reason_code` STRING COMMENT 'Code explaining the reason for the material movement (e.g., MAINT=Maintenance Consumption, EMER=Emergency Issue, QUAL=Quality Hold, SCRAP=Scrap/Disposal, RETN=Return to Vendor). Provides additional context beyond movement type.. Valid values are `^[A-Z0-9]{2,4}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this material movement is a reversal (cancellation) of a previous movement. True if this is a reversal transaction.',
    `reversed_document_number` STRING COMMENT 'Material document number of the original transaction that this movement reverses. Populated only when reversal_indicator is true.. Valid values are `^[0-9]{10}$`',
    `special_stock_indicator` STRING COMMENT 'Single-character code for special stock types: E=Sales Order Stock, K=Consignment Stock, O=Project Stock, Q=Quality Inspection Stock, W=Returnable Packaging. Blank for standard unrestricted stock.. Valid values are `E|K|O|Q|W`',
    `storage_location_to` STRING COMMENT 'Four-character code identifying the destination storage location to which material was moved. Null for goods issues to external consumption.. Valid values are `^[A-Z0-9]{4}$`',
    `text_header` STRING COMMENT 'Free-form text field at the document header level providing additional context, notes, or instructions for the entire material movement transaction.',
    `text_item` STRING COMMENT 'Free-form text field at the line item level providing specific notes or details about this particular material movement (e.g., condition observed, special handling instructions).',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is expressed (e.g., EA=Each, GAL=Gallon, LB=Pound, KG=Kilogram, L=Liter). Aligns with ISO unit codes.. Valid values are `^[A-Z]{2,3}$`',
    `unloading_point` STRING COMMENT 'Physical location or dock where material was received or issued. Provides granular location tracking within a plant or warehouse.. Valid values are `^[A-Z0-9]{1,25}$`',
    `user_name` STRING COMMENT 'System user ID of the person who created or posted the material movement transaction. Used for audit trail and accountability.. Valid values are `^[A-Z0-9_]{1,12}$`',
    `valuation_type` STRING COMMENT 'Code used to differentiate materials with the same material number but different valuations (e.g., different procurement sources, quality grades). Enables split valuation for inventory accounting.. Valid values are `^[A-Z0-9]{0,10}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement including goods receipts, goods issues to work orders, transfers between storage locations, returns to vendor (movement type 122/161), physical inventory adjustments, and scrap postings. Captures movement type, material, quantity, unit of measure, source and destination storage location, posting date, reference document (work order, PO, reservation), movement reason, return reason code, and vendor reference for returns. Provides full material ledger traceability. Aligns with SAP MM Material Document (MSEG/MKPF).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique identifier for the warehouse location record. Primary key.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Territory-to-warehouse assignment drives field crew dispatch and inventory replenishment planning. Water utilities assign warehouses to service territories so dispatchers know which storeroom field cr',
    `access_hours` STRING COMMENT 'Standard operating hours or access schedule for the warehouse location. May be 24/7, business hours only, or by appointment.',
    `address_line_1` STRING COMMENT 'Primary street address of the warehouse location. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, suite, or unit number. Organizational contact data classified as confidential.',
    `available_capacity_sqft` DECIMAL(18,2) COMMENT 'Currently available storage capacity in square feet. Updated based on inventory levels and space allocation.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for capacity reporting. Supports square feet, square meters, cubic feet, cubic meters, or pallet positions.. Valid values are `sqft|sqm|cubic_ft|cubic_m|pallet_positions`',
    `city` STRING COMMENT 'City where the warehouse location is situated. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the warehouse location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse location record was first created in the system.',
    `custodian_contact_email` STRING COMMENT 'Email address for the warehouse custodian. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_contact_phone` STRING COMMENT 'Primary contact phone number for the warehouse custodian. Organizational contact data classified as confidential.',
    `effective_end_date` DATE COMMENT 'Date when the warehouse location was decommissioned or ceased operations. Null for active locations.',
    `effective_start_date` DATE COMMENT 'Date when the warehouse location became operational and available for inventory storage.',
    `facility_type` STRING COMMENT 'Classification of the warehouse facility based on its operational purpose. Central warehouse serves enterprise-wide inventory; WTP (Water Treatment Plant) and WWTP (Wastewater Treatment Plant) chemical stores hold treatment chemicals; field storerooms support distribution network maintenance; maintenance depots support asset management; emergency stockpiles hold critical spare parts.. Valid values are `central_warehouse|wtp_chemical_store|wwtp_chemical_store|field_storeroom|maintenance_depot|emergency_stockpile`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed at the warehouse location. Critical for chemical storage safety and insurance compliance.. Valid values are `sprinkler|foam|gas|none|dry_chemical`',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the location is certified for storage of hazardous materials such as chlorine, coagulants, polymers, and other treatment chemicals. Required for chemical procurement and FOG (Fats Oils and Grease) management compliance.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number covering the warehouse location and its contents. Business-sensitive financial data.',
    `inventory_cycle_count_frequency` STRING COMMENT 'Standard frequency for physical inventory cycle counts at this location. Supports inventory accuracy and audit compliance.. Valid values are `daily|weekly|monthly|quarterly|annual|on_demand`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection of the warehouse location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse location record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse location in decimal degrees. Used for GIS integration and logistics optimization.',
    `location_code` STRING COMMENT 'Business identifier for the warehouse location. Unique alphanumeric code used in SAP MM and operational systems for inventory transactions and storage location assignment.. Valid values are `^[A-Z0-9]{4,12}$`',
    `location_description` STRING COMMENT 'Detailed description of the warehouse location, including purpose, layout, and special characteristics.',
    `location_name` STRING COMMENT 'Human-readable name of the warehouse or storeroom location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse location in decimal degrees. Used for GIS integration and logistics optimization.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next safety or compliance inspection of the warehouse location.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or operational notes about the warehouse location.',
    `operational_status` STRING COMMENT 'Current operational status of the warehouse location. Indicates whether the location is available for inventory storage and transactions.. Valid values are `active|inactive|under_construction|decommissioned|temporarily_closed|restricted_access`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse location. Organizational contact data classified as confidential.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `responsible_custodian` STRING COMMENT 'Name or identifier of the person or role responsible for managing and securing the warehouse location. Accountable for inventory accuracy and safety compliance.',
    `sap_plant_code` STRING COMMENT 'SAP MM plant code to which this warehouse location is assigned. Links warehouse location to the SAP organizational structure for materials management and procurement.. Valid values are `^[A-Z0-9]{4}$`',
    `sap_storage_location_code` STRING COMMENT 'SAP MM storage location code within the plant. Used for inventory transactions, goods receipts, and goods issues in SAP ERP.. Valid values are `^[A-Z0-9]{4}$`',
    `security_level` STRING COMMENT 'Physical security classification of the warehouse location. Determines access control requirements and monitoring protocols.. Valid values are `public|restricted|controlled|high_security`',
    `spill_containment_available` BOOLEAN COMMENT 'Indicates whether the location has spill containment infrastructure for chemical storage. Required for EPA SPCC (Spill Prevention Control and Countermeasure) compliance.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the warehouse is located. Organizational contact data classified as confidential.. Valid values are `^[A-Z]{2}$`',
    `storage_conditions` STRING COMMENT 'Environmental and safety classification of the storage location. Indicates whether the location is temperature-controlled, hazmat-rated for chemical storage, or outdoor. Critical for chemical procurement compliance and inventory safety. [ENUM-REF-CANDIDATE: ambient|temperature_controlled|refrigerated|hazmat_rated|outdoor_covered|outdoor_uncovered|climate_controlled — 7 candidates stripped; promote to reference product]',
    `temperature_control_available` BOOLEAN COMMENT 'Indicates whether the location has active temperature control systems (HVAC). Required for certain chemical and equipment storage.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature maintained at the warehouse location in degrees Fahrenheit. Relevant for temperature-controlled storage.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature maintained at the warehouse location in degrees Fahrenheit. Relevant for temperature-controlled storage.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total storage capacity of the warehouse location measured in square feet. Used for space utilization analysis and capacity planning.',
    `ventilation_type` STRING COMMENT 'Type of ventilation system in the warehouse. Important for chemical storage safety and worker health compliance.. Valid values are `natural|mechanical|forced_air|none|exhaust_only`',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Master data for all physical storage locations within the utilitys warehouse and field storeroom network. Captures location code, description, facility type (central warehouse, WTP chemical store, WWTP chemical store, field storeroom), address, storage conditions (temperature-controlled, hazmat-rated, outdoor), capacity, responsible custodian, and SAP MM plant/storage location assignment. Enables inventory segregation and chemical safety compliance.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Water utility contracts are assigned to cost centers for departmental budget tracking, regulatory cost allocation, and rate case preparation. Contract-to-cost-center linkage is essential for O&M vs. c',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: procurement_contract has delivery_location (STRING) representing the agreed delivery point for contract-based supply. Normalizing this to delivery_warehouse_location_id as a proper FK to warehouse_loc',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Chemical supply contracts in water utilities are routinely scoped to specific treatment facilities (e.g., annual chlorine supply agreement for a named WTP). Facility-specific contract management drive',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Contracts reserve multi-year budget allocations for long-term planning. Critical for contract budgeting, ensuring multi-year commitments have appropriated budget authority across fiscal years.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Contracts encumber multi-year fund commitments for long-term budget planning. Critical for governmental accounting, ensuring multi-year contracts reserve appropriate fund balances per GASB standards.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Procurement contracts in water utilities create encumbrances that post to specific GL accounts. Contract-level GL coding is required for encumbrance accounting, budget control, and rate case cost allo',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this contract is established. Links to the vendor master data.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the contract since its original execution. Used to track contract stability and change frequency.',
    `commodity_category` STRING COMMENT 'High-level classification of the goods or services covered by this contract. Chemicals include chlorine, coagulants, polymers, fluoride, and other treatment chemicals. Other categories support infrastructure maintenance, capital projects, and operations. [ENUM-REF-CANDIDATE: chemicals|pipes_fittings|pumps_motors|valves_actuators|meters_instrumentation|electrical_components|laboratory_supplies|vehicles_equipment|professional_services|maintenance_services — 10 candidates stripped; promote to reference product]',
    `compliance_requirements` STRING COMMENT 'Summary of regulatory, environmental, safety, or quality compliance obligations imposed on the vendor, such as EPA (Environmental Protection Agency) chemical handling standards, OSHA (Occupational Safety and Health Administration) safety requirements, AWWA (American Water Works Association) product certifications, or NSF (National Sanitation Foundation) approval for water treatment chemicals.',
    `contract_approval_date` DATE COMMENT 'The date on which the contract was formally approved by the authorized signatory or approval authority, such as the procurement director, CFO, or board of directors for high-value contracts.',
    `contract_description` STRING COMMENT 'Free-text summary of the contract scope, including the types of goods or services covered, key terms, and any special conditions. Provides context for users reviewing the contract in procurement or financial systems.',
    `contract_document_url` STRING COMMENT 'The file path or URL to the signed contract document stored in the document management system or contract repository. Enables quick access to the full legal agreement for review and audit purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, typically assigned by the procurement system or legal department. Used for vendor communication and reference in purchase orders.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_owner` STRING COMMENT 'The name or identifier of the procurement professional or contract manager responsible for administering this contract, including renewals, amendments, and vendor performance monitoring.',
    `contract_signed_date` DATE COMMENT 'The date on which both parties executed the contract, making it legally binding. May differ from the effective start date if the contract includes a future commencement provision.',
    `contract_status` STRING COMMENT 'Current state of the contract in its lifecycle. Draft contracts are being prepared, pending approval contracts await authorization, active contracts are in force, suspended contracts are temporarily halted, expired contracts have passed their validity period, terminated contracts were ended early, and closed contracts are completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract based on its structure and commitment mechanism. Value contracts specify total monetary value, quantity contracts specify total quantity, framework agreements establish terms without commitment, blanket orders cover recurring purchases, service contracts cover maintenance or professional services, and chemical supply agreements are specialized for treatment chemicals.. Valid values are `value_contract|quantity_contract|framework_agreement|blanket_order|service_contract|chemical_supply_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this contract record was first created in the procurement system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and pricing terms. Typically USD for domestic US water utilities, but may vary for international suppliers or multi-currency organizations.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities for shipping, insurance, and risk transfer. FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid), EXW (Ex Works), and FCA (Free Carrier) are common in chemical and materials procurement.. Valid values are `FOB|CIF|DDP|EXW|FCA`',
    `effective_end_date` DATE COMMENT 'The date on which the contract expires and no further releases or purchases can be made unless renewed. Nullable for open-ended contracts or contracts with automatic renewal clauses.',
    `effective_start_date` DATE COMMENT 'The date from which the contract terms become binding and procurement can begin releasing orders against this contract. Aligns with contract execution date or a future commencement date specified in the agreement.',
    `insurance_requirements` STRING COMMENT 'Description of the insurance coverage the vendor must maintain, including general liability, product liability, workers compensation, and environmental liability. Specifies minimum coverage amounts and certificate of insurance requirements.',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the contract terms, such as price adjustments, scope changes, or term extensions. Nullable if no amendments have been made.',
    `minority_business_enterprise` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a Minority Business Enterprise, supporting diversity and inclusion goals in procurement. Used for compliance reporting and supplier diversity tracking.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this contract record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this contract record was last updated in the procurement system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or internal notes about the contract that do not fit in other structured fields. May include historical context, negotiation outcomes, or operational considerations.',
    `payment_method` STRING COMMENT 'The instrument or mechanism by which payments will be made to the vendor under this contract. ACH (Automated Clearing House) and wire transfers are common for large chemical suppliers, checks for smaller vendors, and procurement cards for low-value recurring purchases.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount conditions. Examples include NET30 (net 30 days), 2/10NET30 (2% discount if paid within 10 days, otherwise net 30), or custom terms negotiated with the vendor.. Valid values are `^[A-Z0-9]{1,10}$`',
    `performance_clause` STRING COMMENT 'Description of performance standards, service level agreements (SLAs), quality requirements, and penalties or incentives tied to vendor performance. May include delivery time commitments, product quality specifications, and response time requirements for emergency chemical deliveries.',
    `price_escalation_clause` STRING COMMENT 'Details of any provisions allowing the vendor to adjust prices during the contract term, including triggers (e.g., CPI increases, raw material cost changes), frequency of adjustments, and caps on increases. Critical for budget forecasting and OPEX management.',
    `pricing_condition` STRING COMMENT 'The pricing structure defined in the contract. Fixed price remains constant, variable price adjusts based on market conditions or volume, cost-plus adds a markup to vendor costs, index-linked ties pricing to a commodity index, and tiered pricing offers volume discounts.. Valid values are `fixed_price|variable_price|cost_plus|index_linked|tiered_pricing`',
    `purchasing_group` STRING COMMENT 'The buyer group or team within the purchasing organization responsible for this contract. Typically organized by commodity category (e.g., chemicals, equipment, services).. Valid values are `^[A-Z0-9]{3,10}$`',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for negotiating and managing this contract. In multi-site utilities, different purchasing organizations may handle different regions or commodity categories.. Valid values are `^[A-Z0-9]{4,10}$`',
    `remaining_contract_value` DECIMAL(18,2) COMMENT 'The remaining monetary value available for future releases under this contract, calculated as total contract value minus total released value. Used for budget planning and procurement decision-making.',
    `renewal_terms` STRING COMMENT 'Free-text description of the renewal provisions, including automatic renewal clauses, notice periods for non-renewal, and conditions for extension. Critical for ensuring continuity of chemical supply and avoiding service interruptions.',
    `small_business_enterprise` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a Small Business Enterprise, supporting local economic development and small business participation goals. Used for compliance reporting and procurement policy adherence.',
    `termination_clause` STRING COMMENT 'Summary of the conditions under which either party may terminate the contract early, including notice periods, penalties, and force majeure provisions. Important for risk management and vendor relationship governance.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The maximum monetary value committed under this contract for value contracts, or the estimated total spend for quantity and framework agreements. Used for budget tracking and OPEX (Operating Expenditure) or CAPEX (Capital Expenditure) allocation. Currency is USD unless otherwise specified in contract terms.',
    `total_released_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods or services released against this contract to date, measured in the contracts unit of measure. Used to track contract utilization for quantity contracts.',
    `total_released_value` DECIMAL(18,2) COMMENT 'The cumulative monetary value of all purchase orders or releases issued against this contract to date. Used to track contract utilization and remaining available value for value contracts.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this contract record. Used for audit trail and accountability.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Long-term supply agreements and blanket purchase orders negotiated with vendors for recurring procurement of chemicals, materials, and services. Captures contract number, vendor, contract type (value contract, quantity contract, framework agreement), validity period, total contract value, pricing conditions, payment terms, renewal terms, performance clauses, and associated commodity categories. Supports chemical supply continuity and OPEX/CAPEX budget management. Aligns with SAP MM Outline Agreement (EKKO with doc type MK/WK).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Three-way match (PO/GR/Invoice) reconciliation requires linking the supply-side vendor invoice to the finance AP invoice. Water utilities AP processing and payment approval workflows depend on this li',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Water utility invoices are cost-center coded for departmental expense tracking and budget control. The existing cost_center is a plain text denormalized field; a proper FK to cost_center enables dep',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Municipal water utilities use fund accounting (GASB); vendor invoices must be coded to specific funds (operating, capital, debt service) for governmental financial reporting. Direct invoices not tied ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Vendor invoices in water utilities are coded to GL accounts for expense posting and financial reporting. The existing general_ledger_account is a denormalized text field; a proper FK enforces refere',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the goods receipt document confirming delivery of materials or services, used in three-way match validation.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: Vendor invoices are matched at line-item level for three-way matching (PO line, GR, Invoice). Currently vendor_invoice only links to purchase_order header; adding line-item FK enables precise matching',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order against which this invoice is matched in the three-way match workflow (PO, GR, invoice).',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who submitted this invoice. Links to the vendor master record.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Vendor invoices for capital project work are posted against WBS elements for project cost accounting and asset capitalization. The plain-text wbs_element column is a denormalization. This FK is esse',
    `approved_by` STRING COMMENT 'User ID of the manager or authorized approver who approved the invoice for payment. Used for segregation of duties and audit compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time the invoice was approved for payment. Used for approval workflow tracking and compliance reporting.',
    `baseline_date` DATE COMMENT 'Reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity or utility district that is the invoice recipient and payer.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the invoice record was first created in the system. Used for audit trail and processing time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount amount available if payment is made within the discount period per payment terms.',
    `document_date` DATE COMMENT 'Date the invoice document was received or entered into the system. Used for document control and audit trail.',
    `exception_code` STRING COMMENT 'Code identifying the type of exception or discrepancy detected during three-way match (e.g., price variance, quantity variance, no PO match, no GR match).',
    `exception_description` STRING COMMENT 'Detailed description of the invoice exception or discrepancy requiring resolution before payment can be released.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year in which the invoice was posted. Used for monthly financial reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was posted. Used for financial reporting and period closing.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax. Sum of all line item amounts for goods and services.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice. Used for aging analysis and payment term calculation.',
    `invoice_number` STRING COMMENT 'Vendor-assigned invoice number as printed on the invoice document. Business identifier for external reference.',
    `invoice_receipt_date` DATE COMMENT 'Date the physical or electronic invoice was received by the accounts payable department. Used for processing time metrics.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: draft|posted|blocked|approved|paid|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User ID of the last person who modified the invoice record. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time the invoice record was last modified. Used for audit trail and version control.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount including tax. Gross amount plus tax amount. The amount payable to the vendor.',
    `payment_block_code` STRING COMMENT 'Code indicating if payment is blocked and the reason (e.g., price variance, quantity variance, quality issue, missing documentation). Blank if no block.',
    `payment_block_reason` STRING COMMENT 'Detailed explanation of why the invoice payment is blocked. Used for exception management and resolution tracking.',
    `payment_cleared_date` DATE COMMENT 'Date the invoice was fully paid and cleared from open items. Used for cash flow analysis and vendor payment performance.',
    `payment_document_number` STRING COMMENT 'Document number of the payment transaction that cleared this invoice. Used to link invoice to payment for reconciliation.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the vendor per the agreed payment terms. Used for cash flow planning and avoiding late payment penalties.',
    `payment_method_code` STRING COMMENT 'Code indicating the method by which payment will be made (e.g., check, wire transfer, ACH, credit card).',
    `payment_run_date` DATE COMMENT 'Date the invoice was included in an automatic payment run. Null if not yet paid or paid manually.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Defines due date and discount conditions.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the water treatment plant (WTP) or wastewater treatment plant (WWTP) or facility receiving the goods or services.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the financial ledger in SAP FI. Determines the fiscal period for accounting purposes.',
    `reference_document_number` STRING COMMENT 'Reference to related documents such as contract number, service entry sheet, or delivery note. Used for audit trail and document linkage.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice. Includes sales tax, VAT, or other applicable taxes.',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction applicable to this invoice (state, county, city). Used for tax compliance and reporting.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per tax regulations. Remitted directly to tax authority.',
    `created_by` STRING COMMENT 'User ID of the accounts payable clerk or system user who created the invoice record in the system.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor-submitted invoice for goods delivered or services rendered, processed through the three-way match (PO, GR, invoice) workflow. Captures invoice number, vendor, invoice date, posting date, gross amount, tax amount, currency, payment due date, payment block status, matched PO and GR references, and exception reason codes. Feeds accounts payable in SAP FI. Aligns with SAP MM Invoice Verification (RBKP/RSEG — Logistics Invoice Verification).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`approved_source` (
    `approved_source_id` BIGINT COMMENT 'Primary key for the approved_source association',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material in the material master catalog.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the approved vendor in the vendor master.',
    `approval_status` STRING COMMENT 'Current approval status of this vendor-material sourcing relationship. Indicates whether this source is active, expired, suspended, or under review.',
    `approved_date` DATE COMMENT 'Date when this vendor was formally approved as an authorized source for this specific material, distinct from the vendors overall approval date.',
    `lead_time_days` STRING COMMENT 'Vendor-specific number of calendar days from purchase order creation to goods receipt for this material. Overrides the default lead time on the material master for this approved source.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from this vendor for this material per purchase order, as negotiated in the sourcing agreement.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred (primary) source for this material among all approved sources. Supports vendor ranking when multiple approved sources exist.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this material from this specific vendor. Varies per vendor-material combination and cannot be stored on either the vendor or material master alone.',
    CONSTRAINT pk_approved_source PRIMARY KEY(`approved_source_id`)
) COMMENT 'This association product represents the Approved Vendor List (AVL) contract between a vendor and a material in the water utilitys supply chain. It captures each formally approved vendor-material sourcing relationship, including vendor-specific pricing, lead times, minimum order quantities, approval status, and preferred vendor ranking. Each record links one vendor to one material master entry and carries attributes that exist only in the context of that specific sourcing relationship. Aligns with SAP MM Source List (ME01) and supports multi-source procurement policy for critical water treatment chemicals and spare parts.. Existence Justification: In water utilities procurement, a single material (e.g., liquid chlorine, alum, polymer) must be sourced from multiple approved vendors for supply security and regulatory compliance, and each vendor supplies many different materials. The Approved Vendor List (AVL) / Source List is a well-established SAP MM operational concept (transaction ME01) that water utilities actively manage — procurement staff create, update, and expire individual vendor-material approval records with their own pricing, lead times, minimum order quantities, and approval status. This is not an analytical correlation; it is an operational business entity that procurement teams manage daily.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`supply`.`contract_line_item` (
    `contract_line_item_id` BIGINT COMMENT 'Primary key for the contract_line_item association',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master record for the specific material, chemical, or spare part covered by this contract line item.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the parent procurement contract (outline agreement header) under which this line item is established.',
    `effective_end_date` DATE COMMENT 'The date on which this contract line item expires. May differ from the contract header effective_end_date for materials with shorter or extended line-level validity periods.',
    `effective_start_date` DATE COMMENT 'The date from which this contract line items pricing and quantity terms become valid. May differ from the contract header effective_start_date when individual materials are added or renegotiated mid-contract.',
    `line_item_number` STRING COMMENT 'The sequential line number identifying this item within the contract (e.g., 00010, 00020). Corresponds to SAP MM EKPO-EBELP. Used for reference in purchase order releases and vendor communications.',
    `line_item_status` STRING COMMENT 'Current status of this contract line item. Active items are available for release. Closed items have reached target quantity or expiry. Blocked items are temporarily suspended. Cancelled items are voided.',
    `price_per_unit_of_measure` STRING COMMENT 'The unit of measure basis for the unit price (e.g., price per KG, per L, per EA). Defines how unit_price is interpreted for this contract line item.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of this material that has been called off (released) against this contract line item via purchase orders or scheduling agreements. Tracks consumption of the target quantity commitment.',
    `release_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value released against this contract line item. Used for budget tracking and contract utilization reporting at the material level.',
    `target_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the material committed under this contract line item. Represents the maximum or agreed volume the utility intends to procure for this material under this contract. Belongs to the contract-material combination, not to either entity alone.',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure for this specific material under this contract. Price varies by contract-material combination and cannot be stored on either the contract header or the material master without loss of specificity.',
    CONSTRAINT pk_contract_line_item PRIMARY KEY(`contract_line_item_id`)
) COMMENT 'This association product represents the Contract (line-item commitment) between procurement_contract and material_master. It captures the material-level terms within a procurement outline agreement — including negotiated unit price, target quantity, release tracking, and line-level validity — that exist only in the context of a specific contract-material combination. Each record links one procurement_contract to one material_master and corresponds to a SAP MM outline agreement item (EKPO). Supports chemical supply planning, OPEX budget tracking, and vendor performance monitoring at the material level.. Existence Justification: In water utilities procurement, a single procurement contract (outline agreement) routinely covers multiple materials — e.g., a chemical supply contract may cover chlorine, alum, polymer, and caustic soda each with individual pricing schedules and quantity commitments. Conversely, a single material (e.g., chlorine) can be covered by multiple active contracts with different vendors or contract periods. This is the well-established SAP MM concept of outline agreement items (EKPO), where each contract line item represents a distinct material-level commitment with its own target quantity, unit price, and validity terms that belong neither to the contract header nor to the material master alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `water_utilities_ecm`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `water_utilities_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `water_utilities_ecm`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `water_utilities_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `water_utilities_ecm`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ADD CONSTRAINT `fk_supply_approved_source_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ADD CONSTRAINT `fk_supply_approved_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ADD CONSTRAINT `fk_supply_contract_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ADD CONSTRAINT `fk_supply_contract_line_item_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`supply` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `water_utilities_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|restricted');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate On File Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `name_short` SET TAGS ('dbx_business_glossary_term' = 'Vendor Short Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor|not_rated');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'chemical_supplier|equipment_manufacturer|spare_parts_distributor|service_contractor|professional_services|utility_provider');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form On File Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Part Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Material Discontinued Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `issue_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Issue Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,9}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval|restricted|phased_out');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Material Master Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both|no_procurement');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Material Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Material Short Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Requirements');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Cost Center');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|work_order|project|asset|sales_order');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|stock|service|subcontracting|consignment|third_party');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|MAXIMO|DYNAMICS|MANUAL');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|cancelled');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `is_capital_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Purchase Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|emergency|capital|service');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Amount With Tax');
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|asset|wbs_element|order|network');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Control Key');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'not_delivered|partially_delivered|fully_delivered|over_delivered');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `invoice_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|stock_transfer|third_party');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,9}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Item Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Short Text');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,2}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_value_regex' = 'good|damaged|partial|incorrect|contaminated');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posting Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection|completed');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `invoice_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|blocked');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `average_daily_consumption` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `consignment_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `expiration_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiration Controlled Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_stock_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stock Adjustment Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|VM|ND');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|in_house|both');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'in_stock|low_stock|out_of_stock|overstocked|obsolete');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_turnover_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stock Turnover Ratio');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'own|consignment|project|subcontracting|returnable_packaging');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Value Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `backwash_event_id` SET TAGS ('dbx_business_glossary_term' = 'Backwash Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dose Event Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = 'B|H|F|E|L');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'posted|pending|cancelled|error');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|O|Q|W');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `storage_location_to` SET TAGS ('dbx_business_glossary_term' = 'Storage Location To');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `storage_location_to` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `text_header` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `text_item` SET TAGS ('dbx_business_glossary_term' = 'Item Text');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `unloading_point` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,25}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `access_hours` SET TAGS ('dbx_business_glossary_term' = 'Access Hours');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `available_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (Square Feet)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'sqft|sqm|cubic_ft|cubic_m|pallet_positions');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Email');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Phone');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'central_warehouse|wtp_chemical_store|wwtp_chemical_store|field_storeroom|maintenance_depot|emergency_stockpile');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|none|dry_chemical');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `inventory_cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count Frequency');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `inventory_cycle_count_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_demand');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|temporarily_closed|restricted_access');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `responsible_custodian` SET TAGS ('dbx_business_glossary_term' = 'Responsible Custodian');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'public|restricted|controlled|high_security');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `spill_containment_available` SET TAGS ('dbx_business_glossary_term' = 'Spill Containment Available');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_control_available` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Available');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Fahrenheit)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Fahrenheit)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Square Feet)');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `ventilation_type` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ALTER COLUMN `ventilation_type` SET TAGS ('dbx_value_regex' = 'natural|mechanical|forced_air|none|exhaust_only');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Warehouse Location Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL (Uniform Resource Locator)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Lifecycle Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'value_contract|quantity_contract|framework_agreement|blanket_order|service_contract|chemical_supply_agreement');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DDP|EXW|FCA');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Vendor Insurance Requirements');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `minority_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Minority Business Enterprise (MBE) Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `performance_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Clause Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'fixed_price|variable_price|cost_plus|index_linked|tiered_pricing');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `remaining_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Contract Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Terms');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `small_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Small Business Enterprise (SBE) Flag');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `total_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Released Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `total_released_value` SET TAGS ('dbx_business_glossary_term' = 'Total Released Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` SET TAGS ('dbx_association_edges' = 'supply.vendor,supply.material_master');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `approved_source_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Source - Approved Source Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Source - Material Master Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Source - Vendor Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Source Approval Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Source Approval Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Indicator');
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_source` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Vendor Unit Price');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` SET TAGS ('dbx_association_edges' = 'supply.procurement_contract,supply.material_master');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `contract_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Contract Line Item Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Material Master Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item - Procurement Contract Id');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Line Item Effective End Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Line Item Effective Start Date');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Item Number');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `price_per_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `release_value` SET TAGS ('dbx_business_glossary_term' = 'Released Value');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Target Quantity');
ALTER TABLE `water_utilities_ecm`.`supply`.`contract_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price');
