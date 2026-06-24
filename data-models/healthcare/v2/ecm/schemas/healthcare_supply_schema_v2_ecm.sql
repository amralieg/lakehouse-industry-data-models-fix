-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 13:03:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`supply` COMMENT 'Healthcare supply chain and materials management. Owns medical-surgical supplies, implantable device tracking (UDI), prosthetics, procurement, inventory management, requisitions, par-level replenishment, expiration tracking, recall management, vendor management, BOM (Bill of Materials) for surgical procedures, and sterile processing. Integrates with Infor Lawson and SAP MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for each material master record.',
    `compliance_program_id` BIGINT COMMENT 'Compliance program governing this material (e.g., controlled substance, hazmat).',
    `chart_of_accounts_id` BIGINT COMMENT 'General ledger account for expense posting.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for billing and reimbursement.',
    `ndc_drug_id` BIGINT COMMENT 'National Drug Code reference for pharmaceuticals.',
    `payer_id` BIGINT COMMENT 'Payer for reimbursement tracking.',
    `vendor_id` BIGINT COMMENT 'Preferred vendor for this material.',
    `terminology_mapping_id` BIGINT COMMENT 'Mapping to standard terminologies (SNOMED, LOINC, etc.).',
    `approved_date` DATE COMMENT 'Date the material was approved for use.',
    `catalog_price` DECIMAL(18,2) COMMENT 'List price from vendor catalog.',
    `cdm_charge_code` STRING COMMENT 'Charge master code for billing.',
    `contract_price` DECIMAL(18,2) COMMENT 'Negotiated contract price.',
    `cost_center_code` STRING COMMENT 'Cost center for expense allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule (I-V).',
    `discontinuation_date` DATE COMMENT 'Date the material was discontinued.',
    `fda_device_class` STRING COMMENT 'FDA device classification (I, II, III).',
    `fda_product_code` STRING COMMENT 'FDA product code.',
    `formulary_status` STRING COMMENT 'Formulary status (preferred, non-preferred, restricted).',
    `gl_account_code` STRING COMMENT 'General ledger account code.',
    `gtin` STRING COMMENT 'Global Trade Item Number.',
    `is_controlled_substance` BOOLEAN COMMENT 'Indicates if material is a controlled substance.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates if material is hazardous.',
    `is_implantable` BOOLEAN COMMENT 'Indicates if material is an implantable device.',
    `is_latex_free` BOOLEAN COMMENT 'Indicates if material is latex-free.',
    `is_sterile` BOOLEAN COMMENT 'Indicates if material is sterile.',
    `item_category_code` STRING COMMENT 'Material category code.',
    `item_category_name` STRING COMMENT 'Material category name.',
    `item_description` STRING COMMENT 'Full description of the material.',
    `item_number` STRING COMMENT 'Internal item number.',
    `item_status` STRING COMMENT 'Status (active, inactive, obsolete).',
    `item_type` STRING COMMENT 'Type (supply, device, pharmaceutical, etc.).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `lead_time_days` STRING COMMENT 'Lead time in days for procurement.',
    `lot_tracking_required` BOOLEAN COMMENT 'Indicates if lot tracking is required.',
    `manufacturer_item_number` STRING COMMENT 'Manufacturers item number.',
    `manufacturer_name` STRING COMMENT 'Manufacturer name.',
    `ndc_code` STRING COMMENT 'National Drug Code.',
    `order_unit_of_measure` STRING COMMENT 'Unit of measure for ordering.',
    `par_level` DECIMAL(18,2) COMMENT 'Par level for inventory management.',
    `preferred_vendor_item_number` STRING COMMENT 'Preferred vendors item number.',
    `recall_status` STRING COMMENT 'Current recall status.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Reorder point for inventory replenishment.',
    `reorder_quantity` DECIMAL(18,2) COMMENT 'Reorder quantity.',
    `serial_tracking_required` BOOLEAN COMMENT 'Indicates if serial tracking is required.',
    `shelf_life_days` STRING COMMENT 'Shelf life in days.',
    `storage_location_type` STRING COMMENT 'Type of storage location required.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in Celsius.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in Celsius.',
    `udi` STRING COMMENT 'Unique Device Identifier.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure.',
    `unspsc_code` STRING COMMENT 'United Nations Standard Products and Services Code.',
    `uom_conversion_factor` DECIMAL(18,2) COMMENT 'Conversion factor between units of measure.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Master catalog of all materials, supplies, devices, and pharmaceuticals procured and managed by the health system. Supports supply chain management, inventory control, clinical order fulfillment, and regulatory compliance (UDI, FDA, DEA). Links to vendor contracts, formulary status, and charge master for revenue cycle integration.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for each vendor.',
    `trading_partner_id` BIGINT COMMENT 'EDI trading partner record.',
    `address_line1` STRING COMMENT 'Vendor address line 1.',
    `address_line2` STRING COMMENT 'Vendor address line 2.',
    `approved_date` DATE COMMENT 'Date vendor was approved.',
    `bank_account_number` STRING COMMENT 'Vendor bank account number for ACH payments.',
    `bank_routing_number` STRING COMMENT 'Vendor bank routing number.',
    `city` STRING COMMENT 'Vendor city.',
    `contract_end_date` DATE COMMENT 'Contract end date.',
    `contract_start_date` DATE COMMENT 'Contract start date.',
    `contract_tier` STRING COMMENT 'Contract tier (national, regional, local).',
    `country_code` STRING COMMENT 'Vendor country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code for transactions.',
    `dea_registration_number` DECIMAL(18,2) COMMENT 'DEA registration number for controlled substances.',
    `diversity_certification_expiration_date` DECIMAL(18,2) COMMENT 'Diversity certification expiration date.',
    `diversity_certification_number` STRING COMMENT 'Diversity certification number.',
    `diversity_classification` STRING COMMENT 'Diversity classification (MBE, WBE, SDVOSB, etc.).',
    `doing_business_as_name` STRING COMMENT 'Doing business as name.',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates if vendor supports EDI.',
    `fda_establishment_number` STRING COMMENT 'FDA establishment number.',
    `fill_rate` DECIMAL(18,2) COMMENT 'Vendor fill rate percentage.',
    `gpo_affiliation` STRING COMMENT 'Group purchasing organization affiliation.',
    `gpo_contract_number` STRING COMMENT 'GPO contract number.',
    `insurance_certificate_number` STRING COMMENT 'Vendor insurance certificate number.',
    `insurance_expiration_date` DECIMAL(18,2) COMMENT 'Vendor insurance expiration date.',
    `lead_time_days` STRING COMMENT 'Average lead time in days.',
    `minimum_order_amount` DECIMAL(18,2) COMMENT 'Minimum order amount.',
    `vendor_name` STRING COMMENT 'Vendor legal name.',
    `npi` STRING COMMENT 'National Provider Identifier (for clinical vendors).',
    `oig_excluded_flag` BOOLEAN COMMENT 'Indicates if vendor is on OIG exclusion list.',
    `oig_exclusion_checked_date` DATE COMMENT 'Date OIG exclusion was last checked.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'On-time delivery rate percentage.',
    `payment_method` STRING COMMENT 'Payment method (ACH, check, wire, etc.).',
    `payment_terms` STRING COMMENT 'Payment terms (Net 30, Net 60, etc.).',
    `performance_rating` DECIMAL(18,2) COMMENT 'Vendor performance rating (0-5 scale).',
    `postal_code` STRING COMMENT 'Vendor postal code.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates if vendor is preferred.',
    `primary_contact_email` STRING COMMENT 'Primary contact email address.',
    `primary_contact_name` STRING COMMENT 'Primary contact name.',
    `primary_contact_phone` STRING COMMENT 'Primary contact phone number.',
    `punchout_catalog_url` STRING COMMENT 'URL for punchout catalog integration.',
    `recall_notification_flag` BOOLEAN COMMENT 'Indicates if vendor provides recall notifications.',
    `remittance_email` STRING COMMENT 'Email for remittance advice.',
    `state_code` STRING COMMENT 'Vendor state code.',
    `tax_number` STRING COMMENT 'Vendor tax identification number.',
    `udi_capable_flag` BOOLEAN COMMENT 'Indicates if vendor supports UDI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_number` STRING COMMENT 'Vendor number.',
    `vendor_status` STRING COMMENT 'Vendor status (active, inactive, suspended).',
    `vendor_type` STRING COMMENT 'Vendor type (distributor, manufacturer, GPO, etc.).',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master vendor registry for all suppliers of materials, devices, pharmaceuticals, and services. Supports vendor performance tracking, compliance screening (OIG exclusion, DEA registration), diversity spend reporting, and EDI integration for automated procurement workflows.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for each purchase order.',
    `employee_id` BIGINT COMMENT 'Employee who created the purchase order.',
    `care_site_id` BIGINT COMMENT 'Care site for delivery.',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for expense posting.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order triggering this purchase (for patient-specific implants).',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period for budget tracking.',
    `inventory_location_id` BIGINT COMMENT 'Delivery location.',
    `payer_id` BIGINT COMMENT 'Payer for reimbursement tracking (for patient-specific items).',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract governing this PO.',
    `vendor_id` BIGINT COMMENT 'Vendor receiving the purchase order.',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date.',
    `approval_status` STRING COMMENT 'Approval status (pending, approved, rejected).',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `budget_year` STRING COMMENT 'Budget year.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation.',
    `confirmed_delivery_date` DATE COMMENT 'Vendor-confirmed delivery date.',
    `cost_center_code` STRING COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight charges.',
    `freight_terms_code` STRING COMMENT 'Freight terms (FOB, prepaid, etc.).',
    `fulfillment_status` STRING COMMENT 'Fulfillment status (open, partial, complete).',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `gpo_contract_number` STRING COMMENT 'GPO contract number.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross amount before discounts.',
    `invoice_status` STRING COMMENT 'Invoice status (not invoiced, partial, complete).',
    `is_capital_expenditure` BOOLEAN COMMENT 'Indicates if this is a capital expenditure.',
    `is_contract_compliant` BOOLEAN COMMENT 'Indicates if PO is contract-compliant.',
    `is_emergency_order` BOOLEAN COMMENT 'Indicates if this is an emergency order.',
    `line_item_count` STRING COMMENT 'Number of line items.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after discounts.',
    `notes` STRING COMMENT 'PO notes.',
    `order_date` DATE COMMENT 'Order date.',
    `payment_terms_code` STRING COMMENT 'Payment terms.',
    `po_number` STRING COMMENT 'Purchase order number.',
    `po_status` STRING COMMENT 'PO status (draft, open, closed, cancelled).',
    `po_type` STRING COMMENT 'PO type (standard, blanket, contract, etc.).',
    `purchasing_group_code` STRING COMMENT 'Purchasing group code.',
    `purchasing_org_code` STRING COMMENT 'Purchasing organization code.',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `source_system_po_key` STRING COMMENT 'Source system PO key.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `three_way_match_status` STRING COMMENT 'Three-way match status (pending, matched, exception).',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_quote_number` STRING COMMENT 'Vendor quote number.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase orders issued to vendors for materials, supplies, devices, and services. Supports three-way match (PO-receipt-invoice), budget tracking, contract compliance, and integration with accounts payable and general ledger for financial reconciliation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique identifier for each purchase order line.',
    `care_site_id` BIGINT COMMENT 'Care site for delivery.',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for expense posting.',
    `cpt_code_id` BIGINT COMMENT 'CPT code for billing.',
    `fund_id` BIGINT COMMENT 'Fund for budget tracking.',
    `hcpcs_code_id` BIGINT COMMENT 'HCPCS code for billing.',
    `material_master_id` BIGINT COMMENT 'Material master record.',
    `purchase_order_id` BIGINT COMMENT 'Parent purchase order.',
    `requisition_id` BIGINT COMMENT 'Requisition triggering this line.',
    `vendor_contract_id` BIGINT COMMENT 'Vendor contract governing this line.',
    `vendor_id` BIGINT COMMENT 'Vendor for this line.',
    `approval_status` STRING COMMENT 'Approval status.',
    `approved_by` STRING COMMENT 'User who approved this line.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `backorder_quantity` DECIMAL(18,2) COMMENT 'Quantity on backorder.',
    `cancelled_quantity` DECIMAL(18,2) COMMENT 'Quantity cancelled.',
    `cost_center_code` STRING COMMENT 'Cost center code.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `discount_percent` DECIMAL(18,2) COMMENT 'Discount percentage.',
    `expense_type` STRING COMMENT 'Expense type (operating, capital).',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date for perishable items.',
    `extended_amount` DECIMAL(18,2) COMMENT 'Extended amount (quantity * unit price).',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight charges for this line.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `gpo_contract_number` STRING COMMENT 'GPO contract number.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity invoiced.',
    `is_contract_item` BOOLEAN COMMENT 'Indicates if item is on contract.',
    `is_formulary_item` BOOLEAN COMMENT 'Indicates if item is on formulary.',
    `is_recall_active` BOOLEAN COMMENT 'Indicates if item is under recall.',
    `item_category` STRING COMMENT 'Item category.',
    `item_description` STRING COMMENT 'Item description.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `line_number` STRING COMMENT 'Line number within PO.',
    `line_status` STRING COMMENT 'Line status (open, closed, cancelled).',
    `line_type` STRING COMMENT 'Line type (material, service, freight).',
    `lot_number` STRING COMMENT 'Lot number.',
    `ndc_code` STRING COMMENT 'National Drug Code.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity ordered.',
    `promised_delivery_date` DATE COMMENT 'Vendor-promised delivery date.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity received.',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date.',
    `ship_to_location_code` STRING COMMENT 'Ship-to location code.',
    `source_system_code` STRING COMMENT 'Source system code.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `udi` STRING COMMENT 'Unique Device Identifier.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price.',
    `vendor_item_number` STRING COMMENT 'Vendor item number.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Line-item detail for purchase orders, linking to material master, vendor contracts, and requisitions. Supports three-way match reconciliation, backorder tracking, and GL account allocation for financial reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for each goods receipt transaction.',
    `clinical_order_id` BIGINT COMMENT 'Clinical order awaiting this receipt (for patient-specific implants).',
    `care_site_id` BIGINT COMMENT 'Care site where goods were received.',
    `chart_of_accounts_id` BIGINT COMMENT 'GL account for inventory valuation.',
    `fiscal_period_id` BIGINT COMMENT 'Fiscal period for financial reporting.',
    `inventory_location_id` BIGINT COMMENT 'Inventory location where goods were received.',
    `material_master_id` BIGINT COMMENT 'Material master record.',
    `employee_id` BIGINT COMMENT 'Employee who received the goods.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order for this receipt.',
    `purchase_order_line_id` BIGINT COMMENT 'Purchase order line for this receipt.',
    `vendor_id` BIGINT COMMENT 'Vendor who shipped the goods.',
    `condition_on_receipt` STRING COMMENT 'Condition of goods on receipt (good, damaged, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `currency_code` STRING COMMENT 'Currency code.',
    `delivery_note_number` STRING COMMENT 'Vendor delivery note number.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates if there was a discrepancy.',
    `discrepancy_notes` STRING COMMENT 'Notes on discrepancy.',
    `discrepancy_type` STRING COMMENT 'Type of discrepancy (quantity, quality, etc.).',
    `expiration_date` DECIMAL(18,2) COMMENT 'Expiration date.',
    `implantable_device_flag` BOOLEAN COMMENT 'Indicates if item is an implantable device.',
    `inventory_update_flag` BOOLEAN COMMENT 'Indicates if inventory was updated.',
    `lot_number` STRING COMMENT 'Lot number.',
    `manufacture_date` DATE COMMENT 'Manufacture date.',
    `movement_type` STRING COMMENT 'Movement type (receipt, return, etc.).',
    `plant_code` STRING COMMENT 'Plant code.',
    `posting_timestamp` TIMESTAMP COMMENT 'Posting timestamp.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity ordered.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Quantity received.',
    `recall_flag` BOOLEAN COMMENT 'Indicates if item is under recall.',
    `recall_reference_number` STRING COMMENT 'Recall reference number.',
    `receipt_date` DATE COMMENT 'Receipt date.',
    `receipt_number` STRING COMMENT 'Receipt number.',
    `receipt_status` STRING COMMENT 'Receipt status (complete, partial, etc.).',
    `serial_number` STRING COMMENT 'Serial number.',
    `source_document_number` STRING COMMENT 'Source document number.',
    `sterile_processing_required` BOOLEAN COMMENT 'Indicates if sterile processing is required.',
    `storage_condition` STRING COMMENT 'Storage condition (room temp, refrigerated, etc.).',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates if temperature excursion occurred.',
    `three_way_match_status` STRING COMMENT 'Three-way match status.',
    `total_receipt_value` DECIMAL(18,2) COMMENT 'Total receipt value.',
    `udi_device_identifier` STRING COMMENT 'UDI device identifier.',
    `udi_production_identifier` STRING COMMENT 'UDI production identifier.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    `vendor_invoice_number` STRING COMMENT 'Vendor invoice number.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Goods receipt transactions recording the physical receipt of materials from vendors. Supports three-way match (PO-receipt-invoice), lot/serial tracking, UDI capture for implantable devices, expiration date tracking, and recall management. Triggers inventory balance updates and accounts payable accruals.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` (
    `inventory_location_id` BIGINT COMMENT 'Unique identifier for each inventory location.',
    `building_id` BIGINT COMMENT 'Building where location is located.',
    `care_site_id` BIGINT COMMENT 'Care site where location is located.',
    `cost_center_id` BIGINT COMMENT 'Cost center for expense allocation.',
    `equipment_asset_id` BIGINT COMMENT 'Equipment asset (e.g., ADC machine).',
    `org_unit_id` BIGINT COMMENT 'Organizational unit responsible for this location.',
    `osha_safety_program_id` BIGINT COMMENT 'OSHA safety program governing this location.',
    `parent_location_inventory_location_id` BIGINT COMMENT 'Parent inventory location (for hierarchical locations).',
    `access_restriction_level` STRING COMMENT 'Access restriction level (public, restricted, controlled).',
    `adc_manufacturer` STRING COMMENT 'Automated dispensing cabinet manufacturer.',
    `bin_aisle` STRING COMMENT 'Bin aisle.',
    `bin_shelf` STRING COMMENT 'Bin shelf.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `cycle_count_frequency` STRING COMMENT 'Cycle count frequency (daily, weekly, monthly).',
    `deactivation_date` DATE COMMENT 'Deactivation date.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_tracking_enabled` DECIMAL(18,2) COMMENT 'Indicates if expiration tracking is enabled.',
    `floor_number` STRING COMMENT 'Floor number.',
    `gl_account_code` STRING COMMENT 'GL account code for inventory valuation.',
    `hazardous_material_storage` BOOLEAN COMMENT 'Indicates if location stores hazardous materials.',
    `humidity_controlled` BOOLEAN COMMENT 'Indicates if location is humidity-controlled.',
    `last_cycle_count_date` DATE COMMENT 'Last cycle count date.',
    `lawson_location_code` STRING COMMENT 'Lawson location code.',
    `location_code` STRING COMMENT 'Location code.',
    `location_name` STRING COMMENT 'Location name.',
    `location_notes` STRING COMMENT 'Location notes.',
    `location_status` STRING COMMENT 'Location status (active, inactive).',
    `location_type` STRING COMMENT 'Location type (warehouse, OR, nursing unit, ADC, etc.).',
    `next_cycle_count_date` DATE COMMENT 'Next cycle count date.',
    `par_level_managed` BOOLEAN COMMENT 'Indicates if location is par-level managed.',
    `par_replenishment_method` STRING COMMENT 'Par replenishment method (manual, automated).',
    `primary_contact_name` STRING COMMENT 'Primary contact name.',
    `primary_contact_phone` STRING COMMENT 'Primary contact phone.',
    `recall_management_enabled` BOOLEAN COMMENT 'Indicates if recall management is enabled.',
    `replenishment_frequency` STRING COMMENT 'Replenishment frequency.',
    `room_number` STRING COMMENT 'Room number.',
    `sap_storage_location_code` STRING COMMENT 'SAP storage location code.',
    `secure_controlled_substance` BOOLEAN COMMENT 'Indicates if location stores controlled substances.',
    `sterile_processing_staging` BOOLEAN COMMENT 'Indicates if location is sterile processing staging area.',
    `storage_capacity_cubic_ft` DECIMAL(18,2) COMMENT 'Storage capacity in cubic feet.',
    `storage_capacity_units` STRING COMMENT 'Storage capacity in units.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius.',
    `temperature_requirement` STRING COMMENT 'Temperature requirement (room temp, refrigerated, frozen).',
    `udi_tracking_enabled` BOOLEAN COMMENT 'Indicates if UDI tracking is enabled.',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp.',
    CONSTRAINT pk_inventory_location PRIMARY KEY(`inventory_location_id`)
) COMMENT 'Inventory storage locations (central warehouse, OR supply rooms, nursing units, automated dispensing cabinets, etc.). Supports par-level management, cycle counting, temperature/humidity monitoring for controlled substances and refrigerated items, and integration with ADC systems.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Surrogate primary key for requisition',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal requisitions for materials and supplies from clinical departments, nursing units, and OR. Supports approval workflows, budget checking, par-level replenishment, and conversion to purchase orders. Links to surgical cases and clinical orders for demand forecasting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`udi_record` (
    `udi_record_id` BIGINT COMMENT 'Surrogate primary key for udi_record',
    CONSTRAINT pk_udi_record PRIMARY KEY(`udi_record_id`)
) COMMENT 'Unique Device Identifier (UDI) records for implantable medical devices. Supports FDA UDI requirements, patient-device linkage for recalls and adverse event reporting, explant tracking, and MDR (Medical Device Reporting) compliance. Critical for patient safety and regulatory compliance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` (
    `surgical_bom_id` BIGINT COMMENT 'Surrogate primary key for surgical_bom',
    CONSTRAINT pk_surgical_bom PRIMARY KEY(`surgical_bom_id`)
) COMMENT 'Surgical bill of materials (BOM) defining standard supply and implant requirements for surgical procedures. Supports preference card management, case cart assembly, cost estimation, and supply chain planning. Links to CPT codes, surgeons, and OR locations for standardization and cost control.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`case_cart` (
    `case_cart_id` BIGINT COMMENT 'Surrogate primary key for case_cart',
    CONSTRAINT pk_case_cart PRIMARY KEY(`case_cart_id`)
) COMMENT 'Case cart assembly and fulfillment for surgical cases. Tracks picking, assembly, delivery, usage, returns, and waste for OR supply management. Supports implant tracking, UDI capture, recall management, and cost-per-case analytics. Links to surgical cases and surgical BOMs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` (
    `recall_notice_id` BIGINT COMMENT 'Surrogate primary key for recall_notice',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_recall_notice PRIMARY KEY(`recall_notice_id`)
) COMMENT 'FDA and vendor recall notices for materials, devices, and pharmaceuticals. Supports recall class determination, patient impact assessment, inventory quarantine, patient notification workflows, and regulatory reporting. Links to UDI records, inventory balances, and patient procedures for recall remediation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Surrogate primary key for vendor_contract',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Vendor contracts governing pricing, terms, rebates, and compliance requirements. Supports GPO contract tracking, diversity spend reporting, sole-source justification, and contract compliance monitoring. Links to purchase orders and vendor performance metrics for contract optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`location_audit` (
    `location_audit_id` BIGINT COMMENT '',
    `audit_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Employee who performed the physical inventory audit at the location.',
    `care_site_id` BIGINT COMMENT 'Facility where the audited inventory location resides.',
    `corrective_action_plan_id` BIGINT COMMENT 'Link to formal corrective action plan if audit findings require remediation.',
    `inventory_location_id` BIGINT COMMENT '',
    `accuracy_rate` DECIMAL(18,2) COMMENT 'Inventory accuracy rate (percentage of items matching expected)',
    `audit_date` DATE COMMENT '',
    `audit_duration_minutes` DECIMAL(18,2) COMMENT 'Duration of the audit in minutes',
    `audit_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit was completed; used for audit duration and resource planning.',
    `audit_pass_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.location_audit.',
    `audit_report_url` STRING COMMENT 'URL or path to detailed audit report document',
    `audit_result` STRING COMMENT 'Overall audit result (pass, pass with findings, fail)',
    `audit_scope` STRING COMMENT 'Scope of audit (all items, high-value items, controlled substances, expired items, specific material category)',
    `audit_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit began; used for audit duration calculation and scheduling.',
    `audit_status` STRING COMMENT 'Current status of the audit (e.g., scheduled, in progress, completed, findings pending review).',
    `audit_type` STRING COMMENT 'Type of inventory audit (e.g., cycle count, full physical, spot check, regulatory, expiration review).',
    `auditor_notes` STRING COMMENT '',
    `auditor_signature_date` DATE COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.location_audit.',
    `compliance_score` DECIMAL(18,2) COMMENT '',
    `controlled_substance_audit_flag` BOOLEAN COMMENT 'Flag indicating whether controlled substances were included in this audit',
    `controlled_substance_discrepancy_flag` BOOLEAN COMMENT 'Flag indicating whether controlled substance discrepancies were found',
    `controlled_substance_discrepancy_reported_flag` BOOLEAN COMMENT 'Flag indicating whether controlled substance discrepancies were reported to regulatory authorities',
    `corrective_action_completed_date` DATE COMMENT '',
    `corrective_action_due_date` DATE COMMENT 'Due date for corrective action',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Flag indicating whether corrective action is required',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was created.',
    `critical_findings_count` STRING COMMENT 'Number of critical findings (e.g., expired controlled substances, recalled items in use, temperature excursions).',
    `damaged_items_count` STRING COMMENT 'Number of damaged items found',
    `damaged_items_value` DECIMAL(18,2) COMMENT 'Total dollar value of damaged items',
    `discrepancies_found_count` STRING COMMENT 'Number of discrepancies found',
    `discrepancy_count` STRING COMMENT 'Number of items where physical count did not match system inventory balance.',
    `discrepancy_items_count` STRING COMMENT 'Number of items with discrepancies found',
    `discrepancy_rate` DECIMAL(18,2) COMMENT 'Percentage of items with discrepancies',
    `discrepancy_value` DECIMAL(18,2) COMMENT 'Total dollar value of inventory discrepancies identified during the audit.',
    `documentation_compliance_flag` BOOLEAN COMMENT 'Whether documentation is complete and compliant',
    `documentation_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether required documentation (logs, records) was complete',
    `expired_items_count` STRING COMMENT 'Number of expired items found during the audit, critical for patient safety and regulatory compliance.',
    `expired_items_found` STRING COMMENT 'Number of expired items discovered during audit',
    `expired_items_value` DECIMAL(18,2) COMMENT 'Total dollar value of expired items',
    `findings_count` STRING COMMENT '',
    `follow_up_due_date` DATE COMMENT 'Date by which follow-up actions must be completed; used for corrective action tracking.',
    `follow_up_required` BOOLEAN COMMENT '',
    `inventory_variance_amount` DECIMAL(18,2) COMMENT 'Total dollar value of inventory variance identified during the audit; used for shrinkage and loss reporting.',
    `items_audited_count` STRING COMMENT 'Total number of distinct items (SKUs) audited during this audit; used for audit completeness tracking.',
    `items_counted` STRING COMMENT 'Number of distinct items counted during audit',
    `items_with_discrepancy_count` STRING COMMENT 'Number of items with inventory discrepancies',
    `labeling_compliance_flag` BOOLEAN COMMENT 'Indicates whether all items were properly labeled with UDI, lot number, and expiration date per regulatory requirements.',
    `labeling_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether items were properly labeled',
    `location_status_at_audit` STRING COMMENT '',
    `net_variance_value` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.location_audit.',
    `next_audit_date` DATE COMMENT '',
    `organization_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether location organization and cleanliness were compliant',
    `overage_value` DECIMAL(18,2) COMMENT 'Total dollar value of inventory overages',
    `par_level_compliance_flag` BOOLEAN COMMENT 'Whether inventory levels meet established par levels',
    `re_audit_due_date` DATE COMMENT 'Due date for re-audit',
    `re_audit_required_flag` BOOLEAN COMMENT 'Whether re-audit is required',
    `recall_items_found` STRING COMMENT 'Number of recalled items discovered during audit',
    `recalled_items_count` STRING COMMENT 'Number of recalled items found that should have been removed',
    `recalled_items_found_count` STRING COMMENT 'Number of recalled items identified during the audit that should have been removed from inventory.',
    `recalled_items_found_flag` BOOLEAN COMMENT 'Indicates whether any recalled items were found during the audit; triggers immediate corrective action.',
    `recalled_items_value` DECIMAL(18,2) COMMENT 'Total dollar value of recalled items found',
    `regulatory_report_date` DATE COMMENT 'Date discrepancies were reported to regulatory agency',
    `regulatory_report_reference_number` STRING COMMENT 'Reference number from regulatory agency',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Whether findings must be reported to regulatory body',
    `regulatory_requirement_met_flag` BOOLEAN COMMENT 'Whether the location meets all applicable regulatory storage and inventory requirements.',
    `security_compliance_flag` BOOLEAN COMMENT 'Whether security controls are adequate (locked storage, access logs)',
    `security_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether security controls (locks, access logs) were compliant',
    `shortage_value` DECIMAL(18,2) COMMENT 'Total dollar value of inventory shortages',
    `storage_compliance_flag` BOOLEAN COMMENT 'Indicates whether items were stored according to manufacturer and regulatory requirements.',
    `storage_condition_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether storage conditions (temperature, humidity, security) were compliant',
    `storage_condition_notes` STRING COMMENT 'Notes on storage conditions observed (temperature, humidity, organization, cleanliness).',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether temperature-sensitive storage areas were within required ranges during the audit period.',
    `temperature_compliant_flag` BOOLEAN COMMENT 'Whether storage temperature requirements were met at the time of audit (critical for biologics, reagents).',
    `temperature_log_compliant_flag` BOOLEAN COMMENT 'Flag indicating whether temperature logs were complete and within range',
    `total_discrepancy_value` DECIMAL(18,2) COMMENT 'Total dollar value of inventory discrepancies (positive for overages, negative for shortages)',
    `total_items_counted` STRING COMMENT 'Total number of distinct items physically counted during the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Total dollar variance identified during audit',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance as percentage of expected inventory value',
    `variance_units` STRING COMMENT 'Total unit count variance identified during audit',
    `vibe_enriched_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.location_audit.',
    `location_id` BIGINT COMMENT 'inventory location audited',
    `auditor_id` BIGINT COMMENT 'person who performed the audit',
    `expected_quantity` DECIMAL(18,2) COMMENT 'expected on-hand quantity',
    `counted_quantity` DECIMAL(18,2) COMMENT 'physically counted quantity',
    `variance_quantity` DECIMAL(18,2) COMMENT 'difference between counted and expected',
    `adjustment_posted_flag` BOOLEAN COMMENT 'whether variance adjustment posted',
    CONSTRAINT pk_location_audit PRIMARY KEY(`location_audit_id`)
) COMMENT 'Inventory location audit: re-derived from business context to track physical count audits, variance/discrepancy valuation, expired/recalled/damaged item findings, storage/temperature/security/labeling compliance, controlled-substance discrepancy reporting, corrective-action linkage, and re-audit scheduling for supply chain governance.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` (
    `material_policy_governance_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT 'Employee ID of the person who approved the governance decision',
    `care_site_id` BIGINT COMMENT 'Facility where the material policy governance applies, supporting site-specific policy enforcement.',
    `compliance_policy_id` BIGINT COMMENT '',
    `contract_id` BIGINT COMMENT 'Contract governing this material',
    `material_approved_by_employee_id` BIGINT COMMENT 'Employee who approved exception or compliance',
    `material_master_id` BIGINT COMMENT 'Recommended alternative material if this one is restricted',
    `material_policy_owner_employee_id` BIGINT COMMENT 'Employee who owns or is responsible for this policy',
    `vendor_id` BIGINT COMMENT 'Preferred vendor for this material under this policy',
    `material_vendor_id` BIGINT COMMENT 'Vendor associated with the governed material, linking supply chain governance to vendor management.',
    `primary_material_master_id` BIGINT COMMENT '',
    `recall_notice_id` BIGINT COMMENT 'Foreign key to recall notice',
    `reviewer_employee_id` BIGINT COMMENT 'FK to the employee responsible for reviewing and maintaining this governance record.',
    `superseded_by_material_policy_governance_id` BIGINT COMMENT 'ID of governance record that supersedes this one',
    `tertiary_material_master_id` BIGINT COMMENT 'Foreign key to preferred alternative material if this material is restricted',
    `committee_id` BIGINT COMMENT 'Value analysis committee that reviewed this material',
    `vendor_contract_id` BIGINT COMMENT 'FK to the vendor contract associated with this material; links governance to contractual obligations.',
    `annual_spend_threshold` DECIMAL(18,2) COMMENT 'Dollar threshold above which additional governance controls are triggered for this material.',
    `approval_authority` STRING COMMENT 'Authority required for approval (department chair, value analysis committee, pharmacy & therapeutics committee, chief medical officer)',
    `approval_authority_role` STRING COMMENT 'Role or committee that must approve exceptions or purchases of this governed material.',
    `approval_criteria` STRING COMMENT 'Criteria that must be met for approval',
    `approval_date` DATE COMMENT 'Date approval was granted',
    `approval_required_flag` BOOLEAN COMMENT 'Whether purchasing this material requires additional approval beyond standard procurement workflow.',
    `approval_status` STRING COMMENT 'Approval state of the governance decision (e.g. draft, approved, rejected, retired).',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Dollar threshold above which approval is required',
    `clinical_equivalence_flag` BOOLEAN COMMENT 'Flag indicating whether preferred alternative is clinically equivalent',
    `clinical_evidence_reference` STRING COMMENT 'Reference to clinical evidence or value analysis committee decision supporting the governance policy.',
    `clinical_evidence_summary` STRING COMMENT 'Summary of clinical evidence supporting policy decision',
    `compliance_score` DECIMAL(18,2) COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.material_policy_governance.',
    `compliance_status` STRING COMMENT '',
    `contract_compliance_flag` BOOLEAN COMMENT 'Whether material is compliant with GPO or system contracts',
    `controlled_substance_flag` BOOLEAN COMMENT 'Indicates this material is a DEA-scheduled controlled substance; triggers DEA 222 and PDMP reporting requirements.',
    `corrective_action_completed_date` DATE COMMENT 'Date corrective actions were completed and verified.',
    `corrective_action_due_date` DATE COMMENT 'Date by which corrective actions must be completed.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether a corrective action is required to bring this material into compliance.',
    `cost_comparison_preferred_vs_restricted` DECIMAL(18,2) COMMENT 'Cost difference between preferred alternative and restricted material',
    `cost_impact_category` STRING COMMENT 'Classification of cost impact (e.g., high-cost, physician preference item, commodity, strategic).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the governance record was created for lineage and audit tracking.',
    `effective_date` DATE COMMENT '',
    `environmental_impact_rating` STRING COMMENT 'Environmental impact rating (low, medium, high)',
    `environmental_sustainability_flag` BOOLEAN COMMENT 'Flag indicating whether policy is related to environmental sustainability goals',
    `exception_approved_by` STRING COMMENT 'Name or employee ID of the authority who approved the exception; supports governance accountability.',
    `exception_expiration_date` DECIMAL(18,2) COMMENT 'Date the policy exception expires; triggers re-evaluation or corrective action.',
    `exception_flag` BOOLEAN COMMENT '',
    `exception_justification` STRING COMMENT '',
    `expiration_date` DECIMAL(18,2) COMMENT 'Date when the governance policy expires and must be renewed or reviewed.',
    `formulary_restricted_flag` BOOLEAN COMMENT 'Indicates this material is subject to formulary restriction; requires P&T committee approval for use.',
    `formulary_status` STRING COMMENT 'Formulary status (on-formulary, non-formulary, conditional)',
    `governance_category` STRING COMMENT 'Category of governance (e.g., Regulatory Compliance, Formulary Control, Recall Management, Hazardous Material, Controlled Substance, Single-Use Device).',
    `governance_level` STRING COMMENT 'Organizational level at which the policy is enforced (e.g., enterprise, region, facility, department).',
    `governance_notes` STRING COMMENT '',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates this material is classified as hazardous; triggers OSHA HazCom and EPA waste disposal requirements.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit covering this material-policy linkage.',
    `last_override_date` DATE COMMENT 'Date of most recent policy override',
    `last_violation_date` DATE COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.material_policy_governance.',
    `material_category` STRING COMMENT 'Category of material (implant, surgical supply, pharmaceutical, diagnostic, durable medical equipment)',
    `monitoring_frequency` STRING COMMENT 'Cadence at which compliance against the policy is monitored (e.g. monthly, quarterly, annual).',
    `next_review_date` DATE COMMENT '',
    `override_allowed_flag` BOOLEAN COMMENT 'Flag indicating whether policy can be overridden',
    `override_count` STRING COMMENT 'Number of times policy has been overridden for this material',
    `policy_category` STRING COMMENT 'Category of policy (clinical appropriateness, cost control, safety, regulatory, environmental)',
    `policy_effective_date` DATE COMMENT 'Date policy became effective',
    `policy_enforcement_method` STRING COMMENT 'Method of policy enforcement (system hard stop, soft alert, post-use review, periodic audit)',
    `policy_expiration_date` DECIMAL(18,2) COMMENT 'Date policy expires or is scheduled for review',
    `policy_requirement` STRING COMMENT 'Specific policy requirement or restriction',
    `policy_type` STRING COMMENT 'Type of governance policy (e.g., formulary restriction, value analysis, standardization, recall response, sustainability).',
    `policy_version` STRING COMMENT 'Version of the compliance policy applied; supports policy change impact analysis.',
    `recall_flag` BOOLEAN COMMENT 'Flag indicating whether material is subject to recall',
    `regulatory_body` STRING COMMENT 'Regulatory or accrediting body whose requirements govern this material (e.g., FDA, DEA, Joint Commission, EPA, OSHA).',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the material driving governance scope (e.g. hazardous, controlled, implantable).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Whether material meets regulatory requirements (FDA, EPA, OSHA)',
    `regulatory_reference` STRING COMMENT 'Reference to regulatory requirement driving this governance',
    `restriction_level` STRING COMMENT 'Level of restriction on material usage (unrestricted, limited, restricted, prohibited)',
    `restriction_reason` STRING COMMENT 'Reason for restriction (cost, safety concern, recall, formulary non-compliance, clinical evidence insufficient)',
    `restriction_type` STRING COMMENT 'Type of restriction (prohibited, restricted to specific indications, requires approval, preferred alternative available)',
    `review_date` DATE COMMENT '',
    `review_outcome` STRING COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.material_policy_governance.',
    `reviewer_role` STRING COMMENT '',
    `risk_level` STRING COMMENT 'Assessed governance risk level for the material-policy linkage (e.g. low, medium, high).',
    `safety_alert_date` DATE COMMENT 'Date safety alert was issued',
    `safety_alert_flag` BOOLEAN COMMENT 'Flag indicating whether a safety alert is associated with this material',
    `safety_alert_source` STRING COMMENT 'Source of safety alert (FDA, manufacturer, internal quality review)',
    `single_use_only_flag` BOOLEAN COMMENT 'Indicates this is a single-use device; reprocessing is prohibited per FDA and Joint Commission requirements.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Whether an approved substitute material may be used in place of this item.',
    `sustainability_criteria` STRING COMMENT 'Sustainability criteria (recyclable, reduced packaging, lower carbon footprint, reusable)',
    `udi_required_flag` BOOLEAN COMMENT 'Indicates whether FDA UDI (Unique Device Identifier) tracking is required for this material.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the governance record was last updated for lineage and audit tracking.',
    `utilization_monitoring_flag` BOOLEAN COMMENT 'Flag indicating whether utilization is actively monitored',
    `utilization_target` STRING COMMENT 'Target utilization level or reduction goal',
    `utilization_variance_threshold` DECIMAL(18,2) COMMENT 'Threshold for utilization variance that triggers review',
    `value_analysis_committee_review_date` DATE COMMENT 'Date material was reviewed by value analysis committee',
    `value_analysis_date` DATE COMMENT 'Date of value analysis review',
    `value_analysis_recommendation` STRING COMMENT 'Recommendation from value analysis committee',
    `value_analysis_score` DECIMAL(18,2) COMMENT 'Value analysis score (clinical efficacy, cost, safety composite)',
    `vibe_enriched_flag` BOOLEAN COMMENT 'Re-derived attribute added during thin-product expansion based on business context for supply.material_policy_governance.',
    `governance_status` STRING COMMENT 'active|under_review|retired',
    `review_cycle_months` BIGINT COMMENT 'cadence of policy review',
    `last_review_date` DATE COMMENT 'date of last policy review',
    `compliance_owner_id` BIGINT COMMENT 'owner accountable for compliance',
    CONSTRAINT pk_material_policy_governance PRIMARY KEY(`material_policy_governance_id`)
) COMMENT 'Material-level policy governance records linking materials to compliance policies (e.g., controlled substance, hazmat, formulary). Supports exception tracking, policy compliance monitoring, and regulatory audit trail.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` (
    `vendor_site_id` BIGINT COMMENT 'Surrogate primary key for vendor_site',
    `vibe_placeholder` STRING COMMENT 'Added by VIBE mutator to ensure target entity is touched.',
    CONSTRAINT pk_vendor_site PRIMARY KEY(`vendor_site_id`)
) COMMENT 'Vendor site-level detail for multi-site vendors. Supports site-specific performance tracking, lead times, and audit records. Links to vendor master for consolidated vendor management.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`requisition`(`requisition_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ADD CONSTRAINT `fk_supply_purchase_order_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ADD CONSTRAINT `fk_supply_inventory_location_parent_location_inventory_location_id` FOREIGN KEY (`parent_location_inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ADD CONSTRAINT `fk_supply_location_audit_inventory_location_id` FOREIGN KEY (`inventory_location_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`inventory_location`(`inventory_location_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_material_vendor_id` FOREIGN KEY (`material_vendor_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_primary_material_master_id` FOREIGN KEY (`primary_material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_recall_notice_id` FOREIGN KEY (`recall_notice_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`recall_notice`(`recall_notice_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_superseded_by_material_policy_governance_id` FOREIGN KEY (`superseded_by_material_policy_governance_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_policy_governance`(`material_policy_governance_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_tertiary_material_master_id` FOREIGN KEY (`tertiary_material_master_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ADD CONSTRAINT `fk_supply_material_policy_governance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_healthcare_v1`.`supply`.`vendor_contract`(`vendor_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`supply` SET TAGS ('pii_domain' = 'supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_subdomain' = 'vendor_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `compliance_program_id` SET TAGS ('pii_business_glossary_term' = 'Compliance Program');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Expense GL Account');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `ndc_drug_id` SET TAGS ('pii_business_glossary_term' = 'NDC Drug');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `terminology_mapping_id` SET TAGS ('pii_business_glossary_term' = 'Terminology Mapping');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `catalog_price` SET TAGS ('pii_business_glossary_term' = 'Catalog Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `cdm_charge_code` SET TAGS ('pii_business_glossary_term' = 'CDM Charge Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `contract_price` SET TAGS ('pii_business_glossary_term' = 'Contract Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_business_glossary_term' = 'DEA Schedule');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `dea_schedule` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `discontinuation_date` SET TAGS ('pii_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_device_class` SET TAGS ('pii_business_glossary_term' = 'FDA Device Class');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `fda_product_code` SET TAGS ('pii_business_glossary_term' = 'FDA Product Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `formulary_status` SET TAGS ('pii_business_glossary_term' = 'Formulary Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `gtin` SET TAGS ('pii_business_glossary_term' = 'GTIN');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_controlled_substance` SET TAGS ('pii_business_glossary_term' = 'Controlled Substance Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_hazardous` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_implantable` SET TAGS ('pii_business_glossary_term' = 'Implantable Device Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_latex_free` SET TAGS ('pii_business_glossary_term' = 'Latex Free Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `is_sterile` SET TAGS ('pii_business_glossary_term' = 'Sterile Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_code` SET TAGS ('pii_business_glossary_term' = 'Item Category Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_business_glossary_term' = 'Item Category Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_category_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_number` SET TAGS ('pii_business_glossary_term' = 'Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_status` SET TAGS ('pii_business_glossary_term' = 'Item Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `item_type` SET TAGS ('pii_business_glossary_term' = 'Item Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `lot_tracking_required` SET TAGS ('pii_business_glossary_term' = 'Lot Tracking Required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_item_number` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `order_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Order Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `par_level` SET TAGS ('pii_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `preferred_vendor_item_number` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `recall_status` SET TAGS ('pii_business_glossary_term' = 'Recall Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('pii_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `reorder_quantity` SET TAGS ('pii_business_glossary_term' = 'Reorder Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `serial_tracking_required` SET TAGS ('pii_business_glossary_term' = 'Serial Tracking Required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('pii_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_type` SET TAGS ('pii_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Max');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('pii_business_glossary_term' = 'Storage Temperature Min');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `udi` SET TAGS ('pii_business_glossary_term' = 'UDI');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('pii_business_glossary_term' = 'UNSPSC Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_master` ALTER COLUMN `uom_conversion_factor` SET TAGS ('pii_business_glossary_term' = 'UOM Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_subdomain' = 'vendor_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` SET TAGS ('pii_vendor_management' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `trading_partner_id` SET TAGS ('pii_business_glossary_term' = 'Trading Partner');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_end_date` SET TAGS ('pii_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_start_date` SET TAGS ('pii_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `contract_tier` SET TAGS ('pii_business_glossary_term' = 'Contract Tier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_business_glossary_term' = 'DEA Registration Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `dea_registration_number` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Diversity Certification Expiration');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification_number` SET TAGS ('pii_business_glossary_term' = 'Diversity Certification Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('pii_business_glossary_term' = 'Diversity Classification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_business_glossary_term' = 'DBA Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `doing_business_as_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('pii_business_glossary_term' = 'EDI Capable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `fda_establishment_number` SET TAGS ('pii_business_glossary_term' = 'FDA Establishment Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `fill_rate` SET TAGS ('pii_business_glossary_term' = 'Fill Rate');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `gpo_affiliation` SET TAGS ('pii_business_glossary_term' = 'GPO Affiliation');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `gpo_contract_number` SET TAGS ('pii_business_glossary_term' = 'GPO Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('pii_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('pii_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('pii_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('pii_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `minimum_order_amount` SET TAGS ('pii_business_glossary_term' = 'Minimum Order Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_business_glossary_term' = 'NPI');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `npi` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `oig_excluded_flag` SET TAGS ('pii_business_glossary_term' = 'OIG Excluded');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `oig_exclusion_checked_date` SET TAGS ('pii_business_glossary_term' = 'OIG Exclusion Checked Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('pii_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('pii_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `punchout_catalog_url` SET TAGS ('pii_business_glossary_term' = 'Punchout Catalog URL');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `recall_notification_flag` SET TAGS ('pii_business_glossary_term' = 'Recall Notification');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_business_glossary_term' = 'Remittance Email');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `state_code` SET TAGS ('pii_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `udi_capable_flag` SET TAGS ('pii_business_glossary_term' = 'UDI Capable');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('pii_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('pii_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_subdomain' = 'procurement_purchasing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_transaction' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Buyer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `inventory_location_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `payer_id` SET TAGS ('pii_business_glossary_term' = 'Reimbursement Payer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `budget_year` SET TAGS ('pii_business_glossary_term' = 'Budget Year');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('pii_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('pii_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_terms_code` SET TAGS ('pii_business_glossary_term' = 'Freight Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `fulfillment_status` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gpo_contract_number` SET TAGS ('pii_business_glossary_term' = 'GPO Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `gross_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `invoice_status` SET TAGS ('pii_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_capital_expenditure` SET TAGS ('pii_business_glossary_term' = 'Capital Expenditure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_contract_compliant` SET TAGS ('pii_business_glossary_term' = 'Contract Compliant');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `is_emergency_order` SET TAGS ('pii_business_glossary_term' = 'Emergency Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `line_item_count` SET TAGS ('pii_business_glossary_term' = 'Line Item Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('pii_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'PO Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('pii_business_glossary_term' = 'PO Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('pii_business_glossary_term' = 'PO Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group_code` SET TAGS ('pii_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('pii_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `source_system_po_key` SET TAGS ('pii_business_glossary_term' = 'Source System PO Key');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_quote_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Quote Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_subdomain' = 'procurement_purchasing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_transaction' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cpt_code_id` SET TAGS ('pii_business_glossary_term' = 'CPT Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `fund_id` SET TAGS ('pii_business_glossary_term' = 'Fund');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('pii_business_glossary_term' = 'HCPCS Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `requisition_id` SET TAGS ('pii_business_glossary_term' = 'Requisition');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_contract_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Contract');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `backorder_quantity` SET TAGS ('pii_business_glossary_term' = 'Backorder Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cancelled_quantity` SET TAGS ('pii_business_glossary_term' = 'Cancelled Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `discount_percent` SET TAGS ('pii_business_glossary_term' = 'Discount Percent');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expense_type` SET TAGS ('pii_business_glossary_term' = 'Expense Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `extended_amount` SET TAGS ('pii_business_glossary_term' = 'Extended Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `freight_amount` SET TAGS ('pii_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `gpo_contract_number` SET TAGS ('pii_business_glossary_term' = 'GPO Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('pii_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_contract_item` SET TAGS ('pii_business_glossary_term' = 'Contract Item');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_formulary_item` SET TAGS ('pii_business_glossary_term' = 'Formulary Item');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `is_recall_active` SET TAGS ('pii_business_glossary_term' = 'Recall Active');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `item_category` SET TAGS ('pii_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `item_description` SET TAGS ('pii_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('pii_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `line_type` SET TAGS ('pii_business_glossary_term' = 'Line Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ndc_code` SET TAGS ('pii_business_glossary_term' = 'NDC Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ordered_quantity` SET TAGS ('pii_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `received_quantity` SET TAGS ('pii_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('pii_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `ship_to_location_code` SET TAGS ('pii_business_glossary_term' = 'Ship To Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `udi` SET TAGS ('pii_business_glossary_term' = 'UDI');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('pii_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`purchase_order_line` ALTER COLUMN `vendor_item_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_subdomain' = 'procurement_purchasing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_transaction' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` SET TAGS ('pii_receiving' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('pii_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `clinical_order_id` SET TAGS ('pii_business_glossary_term' = 'Awaiting Clinical Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('pii_business_glossary_term' = 'Chart of Accounts');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('pii_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `inventory_location_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('pii_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Received By');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_line_id` SET TAGS ('pii_business_glossary_term' = 'Purchase Order Line');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('pii_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('pii_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_flag` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_notes` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `discrepancy_type` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `implantable_device_flag` SET TAGS ('pii_business_glossary_term' = 'Implantable Device');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `inventory_update_flag` SET TAGS ('pii_business_glossary_term' = 'Inventory Update');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('pii_business_glossary_term' = 'Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `manufacture_date` SET TAGS ('pii_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('pii_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('pii_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `posting_timestamp` SET TAGS ('pii_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_ordered` SET TAGS ('pii_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('pii_business_glossary_term' = 'Quantity Received');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `recall_flag` SET TAGS ('pii_business_glossary_term' = 'Recall Flag');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `recall_reference_number` SET TAGS ('pii_business_glossary_term' = 'Recall Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('pii_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('pii_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('pii_business_glossary_term' = 'Receipt Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('pii_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `source_document_number` SET TAGS ('pii_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `sterile_processing_required` SET TAGS ('pii_business_glossary_term' = 'Sterile Processing Required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `storage_condition` SET TAGS ('pii_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('pii_business_glossary_term' = 'Temperature Excursion');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('pii_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_receipt_value` SET TAGS ('pii_business_glossary_term' = 'Total Receipt Value');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_device_identifier` SET TAGS ('pii_business_glossary_term' = 'UDI Device Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `udi_production_identifier` SET TAGS ('pii_business_glossary_term' = 'UDI Production Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('pii_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_invoice_number` SET TAGS ('pii_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_inventory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` SET TAGS ('pii_location' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `inventory_location_id` SET TAGS ('pii_business_glossary_term' = 'Inventory Location Identifier');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `building_id` SET TAGS ('pii_business_glossary_term' = 'Building');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `equipment_asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment Asset');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `osha_safety_program_id` SET TAGS ('pii_business_glossary_term' = 'OSHA Safety Program');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `parent_location_inventory_location_id` SET TAGS ('pii_business_glossary_term' = 'Parent Location');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `access_restriction_level` SET TAGS ('pii_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `adc_manufacturer` SET TAGS ('pii_business_glossary_term' = 'ADC Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `bin_aisle` SET TAGS ('pii_business_glossary_term' = 'Bin Aisle');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `bin_shelf` SET TAGS ('pii_business_glossary_term' = 'Bin Shelf');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `cycle_count_frequency` SET TAGS ('pii_business_glossary_term' = 'Cycle Count Frequency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `deactivation_date` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `expiration_tracking_enabled` SET TAGS ('pii_business_glossary_term' = 'Expiration Tracking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `expiration_tracking_enabled` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `floor_number` SET TAGS ('pii_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `hazardous_material_storage` SET TAGS ('pii_business_glossary_term' = 'Hazardous Material Storage');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `humidity_controlled` SET TAGS ('pii_business_glossary_term' = 'Humidity Controlled');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('pii_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `lawson_location_code` SET TAGS ('pii_business_glossary_term' = 'Lawson Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_notes` SET TAGS ('pii_business_glossary_term' = 'Location Notes');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_status` SET TAGS ('pii_business_glossary_term' = 'Location Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `location_type` SET TAGS ('pii_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `next_cycle_count_date` SET TAGS ('pii_business_glossary_term' = 'Next Cycle Count Date');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_level_managed` SET TAGS ('pii_business_glossary_term' = 'Par Level Managed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `par_replenishment_method` SET TAGS ('pii_business_glossary_term' = 'Par Replenishment Method');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `recall_management_enabled` SET TAGS ('pii_business_glossary_term' = 'Recall Management Enabled');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `replenishment_frequency` SET TAGS ('pii_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `room_number` SET TAGS ('pii_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('pii_business_glossary_term' = 'SAP Storage Location Code');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `secure_controlled_substance` SET TAGS ('pii_business_glossary_term' = 'Secure Controlled Substance');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `sterile_processing_staging` SET TAGS ('pii_business_glossary_term' = 'Sterile Processing Staging');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_business_glossary_term' = 'Storage Capacity Cubic Feet');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_cubic_ft` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_business_glossary_term' = 'Storage Capacity Units');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `storage_capacity_units` SET TAGS ('pii_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('pii_business_glossary_term' = 'Temperature Max Celsius');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('pii_business_glossary_term' = 'Temperature Min Celsius');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `temperature_requirement` SET TAGS ('pii_business_glossary_term' = 'Temperature Requirement');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `udi_tracking_enabled` SET TAGS ('pii_business_glossary_term' = 'UDI Tracking Enabled');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`inventory_location` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_subdomain' = 'procurement_purchasing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_transaction' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`requisition` SET TAGS ('pii_request' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_subdomain' = 'compliance_recall');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`udi_record` SET TAGS ('pii_tracking' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_subdomain' = 'surgical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_surgical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`surgical_bom` SET TAGS ('pii_preference' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_subdomain' = 'surgical_supply');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_transaction' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_surgical' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`case_cart` SET TAGS ('pii_fulfillment' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_subdomain' = 'compliance_recall');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_regulatory' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_recall' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`recall_notice` SET TAGS ('pii_patient_safety' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_subdomain' = 'vendor_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_contract' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_contract` SET TAGS ('pii_procurement' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_subdomain' = 'inventory_management');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_association_edges' = 'supply.inventory_location,compliance.audit');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` SET TAGS ('pii_quality' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Auditor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('pii_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_duration_minutes` SET TAGS ('pii_business_glossary_term' = 'Audit Duration');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_duration_minutes` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `audit_type` SET TAGS ('pii_business_glossary_term' = 'Audit Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `discrepancy_count` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Count');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `discrepancy_items_count` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Items');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `discrepancy_value` SET TAGS ('pii_business_glossary_term' = 'Discrepancy Value');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `expired_items_count` SET TAGS ('pii_business_glossary_term' = 'Expired Items');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `expired_items_found` SET TAGS ('pii_business_glossary_term' = 'Expired Items Found');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `items_counted` SET TAGS ('pii_business_glossary_term' = 'Items Counted');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `recall_items_found` SET TAGS ('pii_business_glossary_term' = 'Recall Items Found');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `recalled_items_found_count` SET TAGS ('pii_business_glossary_term' = 'Recalled Items Found');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `regulatory_requirement_met_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Requirement Met');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `storage_condition_notes` SET TAGS ('pii_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `temperature_compliant_flag` SET TAGS ('pii_business_glossary_term' = 'Temperature Compliant');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `total_items_counted` SET TAGS ('pii_business_glossary_term' = 'Items Counted');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_amount` SET TAGS ('pii_business_glossary_term' = 'Variance Amount');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_units` SET TAGS ('pii_business_glossary_term' = 'Variance Units');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `location_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `location_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `auditor_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `auditor_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `expected_quantity` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `expected_quantity` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `counted_quantity` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `counted_quantity` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_quantity` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `variance_quantity` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`location_audit` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_subdomain' = 'compliance_recall');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_association_edges' = 'supply.material_master,compliance.policy');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_compliance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` SET TAGS ('pii_policy' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `care_site_id` SET TAGS ('pii_business_glossary_term' = 'Care Site');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_approved_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_approved_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_policy_owner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_policy_owner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Preferred Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `material_vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `reviewer_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `annual_spend_threshold` SET TAGS ('pii_business_glossary_term' = 'Annual Spend Threshold');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `approval_authority_role` SET TAGS ('pii_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `approval_required_flag` SET TAGS ('pii_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `approval_threshold_amount` SET TAGS ('pii_business_glossary_term' = 'Approval Threshold');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `clinical_evidence_reference` SET TAGS ('pii_business_glossary_term' = 'Clinical Evidence');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `cost_impact_category` SET TAGS ('pii_business_glossary_term' = 'Cost Impact');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `exception_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Policy Expiration');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `governance_level` SET TAGS ('pii_business_glossary_term' = 'Governance Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_expiration_date` SET TAGS ('pii_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `policy_type` SET TAGS ('pii_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `regulatory_reference` SET TAGS ('pii_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `restriction_level` SET TAGS ('pii_business_glossary_term' = 'Restriction Level');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('pii_business_glossary_term' = 'Substitution Allowed');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `governance_status` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `governance_status` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `review_cycle_months` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `last_review_date` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `last_review_date` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `compliance_owner_id` SET TAGS ('pii_vibe_added' = 'VREQ-037');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`material_policy_governance` ALTER COLUMN `compliance_owner_id` SET TAGS ('pii_source' = 'business_context');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_subdomain' = 'vendor_sourcing');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_master_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_vendor' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`supply`.`vendor_site` SET TAGS ('pii_location' = 'true');
