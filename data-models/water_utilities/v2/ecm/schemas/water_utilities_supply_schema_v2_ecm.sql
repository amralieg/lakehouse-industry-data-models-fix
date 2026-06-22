-- Schema for Domain: supply | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`supply` COMMENT 'Procurement and supply chain management including vendor management, purchase requisitions and orders, chemical procurement (chlorine, coagulants, polymers, fluoride), materials and spare parts inventory, warehouse management, contract management, supplier performance, and procurement compliance. Integrates with SAP MM for materials management supporting O&M and CIP execution.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique surrogate key for the vendor record.',
    `address_line1` STRING COMMENT 'Primary street address of the vendor.',
    `address_line2` STRING COMMENT 'Secondary address line (suite, unit, etc.).',
    `approved_by` STRING COMMENT 'Name of the person who approved the vendor.',
    `approved_date` DATE COMMENT 'Date the vendor was approved for use.',
    `city` STRING COMMENT 'City of the vendor address.',
    `classification` STRING COMMENT 'Classification category (e.g., chemical supplier, contractor, consultant).',
    `country_code` STRING COMMENT 'ISO country code of the vendor address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was created.',
    `currency_code` STRING COMMENT 'Default transaction currency for the vendor.',
    `diversity_certification` STRING COMMENT 'Diversity certification type held by the vendor.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier.',
    `email_address` STRING COMMENT 'Primary email address for the vendor organization.',
    `fax_number` STRING COMMENT 'Fax number for the vendor.',
    `insurance_certificate_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current insurance certificate is on file.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the vendor insurance certificate.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase from this vendor.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates if the vendor is minority-owned.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the last modification to the vendor record.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor.',
    `name_short` STRING COMMENT 'Abbreviated name for the vendor.',
    `notes` STRING COMMENT 'Free-text notes about the vendor.',
    `payment_method` STRING COMMENT 'Preferred payment method (check, ACH, wire).',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, Net 45).',
    `performance_rating` STRING COMMENT 'Current overall performance rating of the vendor.',
    `phone_number` STRING COMMENT 'Primary phone number for the vendor.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the vendor address.',
    `primary_contact_email` STRING COMMENT 'Email of the primary contact person at the vendor.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `primary_contact_title` STRING COMMENT 'Job title of the primary contact person.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates if the vendor qualifies as a small business.',
    `state_province` STRING COMMENT 'State or province of the vendor address.',
    `tax_identifier` STRING COMMENT 'Federal tax identification number (EIN/TIN).',
    `vendor_number` STRING COMMENT 'Business-assigned vendor number.',
    `vendor_status` STRING COMMENT 'Current status (active, inactive, suspended, blocked).',
    `vendor_type` STRING COMMENT 'Type of vendor (supplier, contractor, consultant, utility).',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a W-9 form is on file.',
    `website_url` STRING COMMENT 'Vendor website URL.',
    `woman_owned_flag` BOOLEAN COMMENT 'Indicates if the vendor is woman-owned.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for suppliers and service providers engaged by the utility for materials, chemicals, equipment, and professional services.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique surrogate key for the material master record.',
    `facility_id` BIGINT COMMENT 'Primary facility associated with this material.',
    `material_wtp_facility_id` BIGINT COMMENT 'Water treatment plant facility using this material.',
    `vendor_id` BIGINT COMMENT 'Preferred vendor for this material.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory prioritization.',
    `base_unit_of_measure` STRING COMMENT 'Base unit of measure for the material.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates if the material is managed in batches.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number.',
    `created_date` DATE COMMENT 'Date the material master was created.',
    `critical_spare_flag` BOOLEAN COMMENT 'Indicates if this is a critical spare part.',
    `discontinued_date` DATE COMMENT 'Date the material was discontinued.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates if the material is classified as hazardous.',
    `hazmat_class` STRING COMMENT 'DOT hazardous material classification.',
    `issue_unit_of_measure` STRING COMMENT 'Unit of measure used when issuing material.',
    `last_modified_date` DATE COMMENT 'Date of last modification.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturer part number.',
    `material_description` STRING COMMENT 'Full description of the material.',
    `material_group` STRING COMMENT 'Grouping category for the material.',
    `material_number` STRING COMMENT 'Business-assigned material number.',
    `material_status` STRING COMMENT 'Current status (active, obsolete, discontinued).',
    `material_type` STRING COMMENT 'Type classification (chemical, spare part, consumable, equipment).',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum stock level for the material.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life required at receipt.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Current moving average price per unit.',
    `notes` STRING COMMENT 'Free-text notes about the material.',
    `price_unit` STRING COMMENT 'Number of units the price refers to.',
    `procurement_type` STRING COMMENT 'Procurement type (external, internal, both).',
    `purchase_unit_of_measure` STRING COMMENT 'Unit of measure used for purchasing.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Stock level that triggers reorder.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum safety stock quantity.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates if the material is serialized.',
    `shelf_life_days` STRING COMMENT 'Total shelf life in days.',
    `short_description` STRING COMMENT 'Short description of the material.',
    `standard_price` DECIMAL(18,2) COMMENT 'Standard price per unit.',
    `storage_condition` STRING COMMENT 'Required storage conditions.',
    `storage_location_code` STRING COMMENT 'Default storage location code.',
    `un_number` STRING COMMENT 'United Nations hazmat identification number.',
    `valuation_class` STRING COMMENT 'Valuation class for accounting purposes.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Central catalog of all materials, chemicals, spare parts, and consumables procured and stocked by the utility.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique surrogate key.',
    `employee_id` BIGINT COMMENT 'Employee who approved the requisition.',
    `cip_project_id` BIGINT COMMENT 'Associated capital improvement project.',
    `cost_center_id` BIGINT COMMENT 'Cost center to be charged.',
    `finance_budget_id` BIGINT COMMENT 'Budget line funding this requisition.',
    `fund_id` BIGINT COMMENT 'Fund to be charged.',
    `general_ledger_id` BIGINT COMMENT 'GL account for the requisition.',
    `material_master_id` BIGINT COMMENT 'Material being requisitioned.',
    `primary_purchase_requisitioner_employee_id` BIGINT COMMENT 'Employee who created the requisition.',
    `account_assignment_category` STRING COMMENT 'Account assignment category code.',
    `approval_date` DATE COMMENT 'Date the requisition was approved.',
    `asset_number` STRING COMMENT 'Fixed asset number if capital purchase.',
    `contract_number` STRING COMMENT 'Reference contract number.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition was created.',
    `currency_code` STRING COMMENT 'Currency for the requisition.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Estimated total value of the requisition.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `notes` STRING COMMENT 'Free-text notes.',
    `priority_code` STRING COMMENT 'Priority level of the requisition.',
    `purchase_order_number` STRING COMMENT 'Resulting PO number once converted.',
    `purchasing_group` STRING COMMENT 'Purchasing group responsible.',
    `purchasing_organization` STRING COMMENT 'Purchasing organization code.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material requested.',
    `rejection_reason` STRING COMMENT 'Reason for rejection if applicable.',
    `requesting_plant_code` STRING COMMENT 'Plant code of the requesting location.',
    `requesting_storage_location` STRING COMMENT 'Storage location requesting the material.',
    `required_delivery_date` DATE COMMENT 'Date by which delivery is required.',
    `requisition_date` DATE COMMENT 'Date the requisition was submitted.',
    `requisition_number` STRING COMMENT 'Business-assigned requisition number.',
    `requisition_status` STRING COMMENT 'Current status (draft, pending, approved, rejected, converted).',
    `requisition_type` STRING COMMENT 'Type of requisition (standard, blanket, emergency).',
    `requisitioner_name` STRING COMMENT 'Name of the person who created the requisition.',
    `source_system_code` STRING COMMENT 'Source system identifier.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity.',
    `vendor_code` STRING COMMENT 'Suggested vendor code.',
    `work_order_number` STRING COMMENT 'Associated work order number.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request to procure materials or services, initiating the procurement workflow.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique surrogate key.',
    `cip_project_id` BIGINT COMMENT 'Associated capital improvement project.',
    `cost_center_id` BIGINT COMMENT 'Cost center charged.',
    `finance_budget_id` BIGINT COMMENT 'Budget funding this PO.',
    `fund_id` BIGINT COMMENT 'Fund charged.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `procurement_category_id` BIGINT COMMENT 'Procurement category.',
    `procurement_contract_id` BIGINT COMMENT 'Associated contract.',
    `purchase_requisition_id` BIGINT COMMENT 'Originating requisition.',
    `warehouse_location_id` BIGINT COMMENT 'Delivery warehouse location.',
    `vendor_id` BIGINT COMMENT 'Vendor fulfilling the order.',
    `approval_date` DATE COMMENT 'Date the PO was approved.',
    `approval_status` STRING COMMENT 'Approval workflow status.',
    `approved_by` STRING COMMENT 'Name of approver.',
    `buyer_email` STRING COMMENT 'Email of the buyer.',
    `buyer_name` STRING COMMENT 'Name of the buyer.',
    `buyer_phone` STRING COMMENT 'Phone of the buyer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when PO was created.',
    `currency_code` STRING COMMENT 'Transaction currency.',
    `delivery_address_line1` STRING COMMENT 'Delivery address line 1.',
    `delivery_address_line2` STRING COMMENT 'Delivery address line 2.',
    `delivery_city` STRING COMMENT 'Delivery city.',
    `delivery_country_code` STRING COMMENT 'Delivery country code.',
    `delivery_postal_code` STRING COMMENT 'Delivery postal code.',
    `delivery_state` STRING COMMENT 'Delivery state.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Freight charges.',
    `incoterms` STRING COMMENT 'International commercial terms.',
    `is_capital_purchase` BOOLEAN COMMENT 'Indicates if this is a capital purchase.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of last modification.',
    `notes` STRING COMMENT 'Free-text notes.',
    `payment_terms` STRING COMMENT 'Payment terms.',
    `po_date` DATE COMMENT 'Date the PO was issued.',
    `po_number` STRING COMMENT 'Business-assigned PO number.',
    `po_status` STRING COMMENT 'Current PO status.',
    `po_type` STRING COMMENT 'Type of purchase order.',
    `promised_delivery_date` DATE COMMENT 'Vendor-promised delivery date.',
    `requested_delivery_date` DATE COMMENT 'Requested delivery date.',
    `requestor_name` STRING COMMENT 'Name of the requestor.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total PO amount before tax.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'Total PO amount including tax.',
    `vendor_site_code` STRING COMMENT 'Vendor site code.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal commitment to a vendor for the purchase of materials or services at agreed terms.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique surrogate key.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `fund_id` BIGINT COMMENT 'Fund.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `material_master_id` BIGINT COMMENT 'Material ordered.',
    `primary_po_material_master_id` BIGINT COMMENT 'Primary material reference.',
    `purchase_order_id` BIGINT COMMENT 'Parent purchase order.',
    `purchase_requisition_id` BIGINT COMMENT 'Originating requisition.',
    `account_assignment_category` STRING COMMENT 'Account assignment category.',
    `asset_number` STRING COMMENT 'Fixed asset number.',
    `confirmation_control_key` STRING COMMENT 'Confirmation control key.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Line item currency.',
    `deletion_indicator` BOOLEAN COMMENT 'Indicates if line is marked for deletion.',
    `delivery_date` DATE COMMENT 'Expected delivery date.',
    `delivery_status` STRING COMMENT 'Delivery status.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Indicates if GR is required.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity received.',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'Quantity invoiced.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Indicates if invoice verification is required.',
    `item_category` STRING COMMENT 'Line item category.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `line_number` STRING COMMENT 'Sequential line number on the PO.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturer part number.',
    `material_group` STRING COMMENT 'Material group.',
    `material_number` STRING COMMENT 'Material number.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Net value of the line.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Over-delivery tolerance percentage.',
    `plant_code` STRING COMMENT 'Receiving plant code.',
    `price_unit` STRING COMMENT 'Price unit quantity.',
    `purchase_requisition_item` STRING COMMENT 'Requisition item number.',
    `purchasing_group` STRING COMMENT 'Purchasing group.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity ordered.',
    `requisitioner_name` STRING COMMENT 'Name of requisitioner.',
    `short_text` STRING COMMENT 'Short description of the line item.',
    `storage_location` STRING COMMENT 'Storage location.',
    `tax_code` STRING COMMENT 'Tax code.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Under-delivery tolerance percentage.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `vendor_material_number` STRING COMMENT 'Vendor material number.',
    `wbs_element` STRING COMMENT 'WBS element.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item on a purchase order specifying material, quantity, price, and delivery details.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique surrogate key.',
    `facility_id` BIGINT COMMENT 'Receiving facility.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `employee_id` BIGINT COMMENT 'Employee who processed the receipt.',
    `material_master_id` BIGINT COMMENT 'Material received.',
    `goods_material_material_master_id` BIGINT COMMENT 'Alternate material reference.',
    `po_line_item_id` BIGINT COMMENT 'PO line item being received against.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order.',
    `receiving_personnel_employee_id` BIGINT COMMENT 'Receiving personnel employee reference.',
    `vendor_id` BIGINT COMMENT 'Vendor who shipped.',
    `warehouse_location_id` BIGINT COMMENT 'Receiving warehouse.',
    `batch_number` STRING COMMENT 'Batch number of received material.',
    `created_by_user` STRING COMMENT 'User who created the GR.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Currency.',
    `delivery_condition` STRING COMMENT 'Condition of delivery.',
    `delivery_note_number` STRING COMMENT 'Vendor delivery note number.',
    `delivery_notes` STRING COMMENT 'Notes about the delivery.',
    `gr_document_date` DATE COMMENT 'Document date.',
    `gr_document_number` STRING COMMENT 'Goods receipt document number.',
    `gr_posting_date` DATE COMMENT 'Posting date.',
    `gr_status` STRING COMMENT 'Status of the goods receipt.',
    `inspection_lot_number` STRING COMMENT 'Quality inspection lot number.',
    `invoice_verification_date` DATE COMMENT 'Date invoice was verified against GR.',
    `last_modified_by_user` STRING COMMENT 'User who last modified.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `material_document_year` STRING COMMENT 'Fiscal year of material document.',
    `movement_type` STRING COMMENT 'Inventory movement type code.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates if QC inspection is required.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity received.',
    `receiving_personnel_name` STRING COMMENT 'Name of receiving personnel.',
    `reversal_date` DATE COMMENT 'Date of reversal if applicable.',
    `reversal_document_number` STRING COMMENT 'Reversal document number.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates if this GR has been reversed.',
    `reversal_reason_code` STRING COMMENT 'Reason code for reversal.',
    `special_stock_indicator` STRING COMMENT 'Special stock indicator.',
    `stock_type` STRING COMMENT 'Type of stock (unrestricted, blocked, QI).',
    `three_way_match_status` STRING COMMENT 'Status of PO/GR/Invoice three-way match.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of goods received.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price at receipt.',
    `unloading_point` STRING COMMENT 'Physical unloading point.',
    `valuation_type` STRING COMMENT 'Valuation type.',
    `vendor_batch_number` STRING COMMENT 'Vendor batch number.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Record of physical receipt of materials at a warehouse or facility against a purchase order.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique surrogate key.',
    `facility_id` BIGINT COMMENT 'Facility.',
    `material_master_id` BIGINT COMMENT 'Primary material reference.',
    `warehouse_location_id` BIGINT COMMENT 'Warehouse location.',
    `abc_indicator` STRING COMMENT 'ABC classification.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Available unrestricted quantity.',
    `average_daily_consumption` DECIMAL(18,2) COMMENT 'Average daily consumption rate.',
    `batch_managed_flag` BOOLEAN COMMENT 'Batch managed indicator.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity in blocked stock.',
    `consignment_stock_flag` BOOLEAN COMMENT 'Indicates consignment stock.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `cycle_count_indicator` STRING COMMENT 'Cycle count classification.',
    `days_of_supply` DECIMAL(18,2) COMMENT 'Calculated days of supply remaining.',
    `expiration_controlled_flag` BOOLEAN COMMENT 'Indicates expiration date tracking.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Hazmat indicator.',
    `last_goods_issue_date` DATE COMMENT 'Date of last goods issue.',
    `last_goods_receipt_date` DATE COMMENT 'Date of last goods receipt.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `last_physical_inventory_date` DATE COMMENT 'Date of last physical count.',
    `last_stock_adjustment_date` DATE COMMENT 'Date of last stock adjustment.',
    `lead_time_days` STRING COMMENT 'Replenishment lead time.',
    `material_description` STRING COMMENT 'Material description.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum stock level.',
    `mrp_type` STRING COMMENT 'Material requirements planning type.',
    `plant_code` STRING COMMENT 'Plant code.',
    `procurement_type` STRING COMMENT 'Procurement type.',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity in quality inspection.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Reorder point level.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity reserved for orders.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Safety stock quantity.',
    `serial_number_managed_flag` BOOLEAN COMMENT 'Serial number managed indicator.',
    `stock_status` STRING COMMENT 'Overall stock status.',
    `stock_turnover_ratio` DECIMAL(18,2) COMMENT 'Inventory turnover ratio.',
    `stock_type` STRING COMMENT 'Stock type.',
    `stock_value_amount` DECIMAL(18,2) COMMENT 'Total value of stock on hand.',
    `storage_location_code` STRING COMMENT 'Storage location code.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Unrestricted use quantity.',
    `valuation_currency_code` STRING COMMENT 'Currency for stock valuation.',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Current stock position for a material at a specific warehouse location including quantities, valuation, and replenishment parameters.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique surrogate key.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `warehouse_location_id` BIGINT COMMENT 'Source warehouse for transfers.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `goods_receipt_id` BIGINT COMMENT 'Associated goods receipt.',
    `material_requisition_id` BIGINT COMMENT 'Associated material requisition.',
    `purchase_order_id` BIGINT COMMENT 'Associated purchase order.',
    `material_master_id` BIGINT COMMENT 'Material moved.',
    `stock_material_material_master_id` BIGINT COMMENT 'Alternate material reference.',
    `vendor_id` BIGINT COMMENT 'Vendor.',
    `amount_in_local_currency` DECIMAL(18,2) COMMENT 'Monetary value of the movement.',
    `asset_number` STRING COMMENT 'Fixed asset number.',
    `batch_number` STRING COMMENT 'Batch number.',
    `currency_code` STRING COMMENT 'Currency.',
    `delivery_note_number` STRING COMMENT 'Delivery note number.',
    `document_date` DATE COMMENT 'Document date.',
    `entry_date` DATE COMMENT 'Entry date.',
    `entry_time` TIMESTAMP COMMENT 'Entry time.',
    `material_document_number` STRING COMMENT 'Material document number.',
    `material_document_year` STRING COMMENT 'Material document year.',
    `movement_indicator` STRING COMMENT 'Movement indicator.',
    `movement_status` STRING COMMENT 'Movement status.',
    `movement_type` STRING COMMENT 'Movement type code.',
    `physical_inventory_document_number` STRING COMMENT 'Physical inventory document.',
    `plant_code` STRING COMMENT 'Plant code.',
    `posting_date` DATE COMMENT 'Posting date.',
    `profit_center` STRING COMMENT 'Profit center.',
    `purchase_order_item` STRING COMMENT 'PO item number.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity moved.',
    `reason_code` STRING COMMENT 'Reason code for the movement.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates if this is a reversal.',
    `reversed_document_number` STRING COMMENT 'Reversed document number.',
    `special_stock_indicator` STRING COMMENT 'Special stock indicator.',
    `storage_location_to` STRING COMMENT 'Destination storage location.',
    `text_header` STRING COMMENT 'Header text.',
    `text_item` STRING COMMENT 'Item text.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `unloading_point` STRING COMMENT 'Unloading point.',
    `user_name` STRING COMMENT 'User who posted the movement.',
    `valuation_type` STRING COMMENT 'Valuation type.',
    `wbs_element` STRING COMMENT 'WBS element.',
    `work_order_number` STRING COMMENT 'Associated work order.',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Record of inventory movement events including receipts, issues, transfers, and adjustments.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique surrogate key.',
    `access_hours` STRING COMMENT 'Hours of access.',
    `address_line_1` STRING COMMENT 'Street address line 1.',
    `address_line_2` STRING COMMENT 'Street address line 2.',
    `available_capacity_sqft` DECIMAL(18,2) COMMENT 'Available capacity in square feet.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for capacity.',
    `city` STRING COMMENT 'City.',
    `country_code` STRING COMMENT 'Country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `custodian_contact_email` STRING COMMENT 'Custodian email.',
    `custodian_contact_phone` STRING COMMENT 'Custodian phone.',
    `effective_end_date` DATE COMMENT 'End date of location use.',
    `effective_start_date` DATE COMMENT 'Start date of location use.',
    `facility_type` STRING COMMENT 'Type of warehouse facility.',
    `fire_suppression_system` STRING COMMENT 'Fire suppression system type.',
    `hazmat_certified` BOOLEAN COMMENT 'Certified for hazmat storage.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy number.',
    `inventory_cycle_count_frequency` STRING COMMENT 'Frequency of cycle counts.',
    `last_inspection_date` DATE COMMENT 'Date of last inspection.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude.',
    `location_code` STRING COMMENT 'Location code.',
    `location_description` STRING COMMENT 'Description of the location.',
    `location_name` STRING COMMENT 'Name of the warehouse location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude.',
    `next_inspection_due_date` DATE COMMENT 'Next inspection due date.',
    `notes` STRING COMMENT 'Free-text notes.',
    `operational_status` STRING COMMENT 'Operational status.',
    `postal_code` STRING COMMENT 'Postal code.',
    `responsible_custodian` STRING COMMENT 'Name of responsible custodian.',
    `sap_plant_code` STRING COMMENT 'SAP plant code.',
    `sap_storage_location_code` STRING COMMENT 'SAP storage location code.',
    `security_level` STRING COMMENT 'Security level.',
    `spill_containment_available` BOOLEAN COMMENT 'Spill containment available.',
    `state_province` STRING COMMENT 'State or province.',
    `storage_conditions` STRING COMMENT 'Storage conditions.',
    `temperature_control_available` BOOLEAN COMMENT 'Temperature control available.',
    `temperature_range_max_f` DECIMAL(18,2) COMMENT 'Maximum temperature in Fahrenheit.',
    `temperature_range_min_f` DECIMAL(18,2) COMMENT 'Minimum temperature in Fahrenheit.',
    `total_capacity_sqft` DECIMAL(18,2) COMMENT 'Total capacity in square feet.',
    `ventilation_type` STRING COMMENT 'Ventilation type.',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Physical storage location for materials, chemicals, and equipment including capacity and environmental controls.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique surrogate key.',
    `finance_budget_id` BIGINT COMMENT 'Associated budget.',
    `fund_id` BIGINT COMMENT 'Fund.',
    `vendor_id` BIGINT COMMENT 'Contracted vendor.',
    `amendment_count` STRING COMMENT 'Number of amendments.',
    `commodity_category` STRING COMMENT 'Commodity category.',
    `compliance_requirements` STRING COMMENT 'Compliance requirements.',
    `contract_approval_date` DATE COMMENT 'Approval date.',
    `contract_description` STRING COMMENT 'Description.',
    `contract_document_url` STRING COMMENT 'URL to contract document.',
    `contract_number` STRING COMMENT 'Contract number.',
    `contract_owner` STRING COMMENT 'Contract owner.',
    `contract_signed_date` DATE COMMENT 'Date signed.',
    `contract_status` STRING COMMENT 'Status.',
    `contract_type` STRING COMMENT 'Type.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Currency.',
    `delivery_location` STRING COMMENT 'Delivery location.',
    `delivery_terms` STRING COMMENT 'Delivery terms.',
    `effective_end_date` DATE COMMENT 'End date.',
    `effective_start_date` DATE COMMENT 'Start date.',
    `insurance_requirements` STRING COMMENT 'Insurance requirements.',
    `last_amendment_date` DATE COMMENT 'Date of last amendment.',
    `minority_business_enterprise` BOOLEAN COMMENT 'MBE indicator.',
    `modified_by` STRING COMMENT 'Last modified by.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `notes` STRING COMMENT 'Notes.',
    `payment_method` STRING COMMENT 'Payment method.',
    `payment_terms` STRING COMMENT 'Payment terms.',
    `performance_clause` STRING COMMENT 'Performance clause.',
    `price_escalation_clause` STRING COMMENT 'Price escalation clause.',
    `pricing_condition` STRING COMMENT 'Pricing condition.',
    `purchasing_group` STRING COMMENT 'Purchasing group.',
    `purchasing_organization` STRING COMMENT 'Purchasing organization.',
    `remaining_contract_value` DECIMAL(18,2) COMMENT 'Remaining contract value.',
    `renewal_terms` STRING COMMENT 'Renewal terms.',
    `small_business_enterprise` BOOLEAN COMMENT 'SBE indicator.',
    `termination_clause` STRING COMMENT 'Termination clause.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total contract value.',
    `total_released_quantity` DECIMAL(18,2) COMMENT 'Total released quantity.',
    `total_released_value` DECIMAL(18,2) COMMENT 'Total released value.',
    `created_by` STRING COMMENT 'Created by user.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Long-term agreement with a vendor establishing terms, pricing, and conditions for procurement of materials or services.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique surrogate key.',
    `goods_receipt_id` BIGINT COMMENT 'Associated goods receipt.',
    `po_line_item_id` BIGINT COMMENT 'PO line item.',
    `purchase_order_id` BIGINT COMMENT 'Purchase order.',
    `vendor_id` BIGINT COMMENT 'Invoicing vendor.',
    `approved_by` STRING COMMENT 'Approver name.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms.',
    `company_code` STRING COMMENT 'Company code.',
    `cost_center` STRING COMMENT 'Cost center.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Invoice currency.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount.',
    `document_date` DATE COMMENT 'Document date.',
    `exception_code` STRING COMMENT 'Exception code.',
    `exception_description` STRING COMMENT 'Exception description.',
    `fiscal_period` STRING COMMENT 'Fiscal period.',
    `fiscal_year` STRING COMMENT 'Fiscal year.',
    `general_ledger_account` STRING COMMENT 'GL account.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross invoice amount.',
    `invoice_date` DATE COMMENT 'Invoice date.',
    `invoice_number` STRING COMMENT 'Vendor invoice number.',
    `invoice_receipt_date` DATE COMMENT 'Date invoice was received.',
    `invoice_status` STRING COMMENT 'Invoice status.',
    `modified_by` STRING COMMENT 'Last modified by.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net invoice amount.',
    `payment_block_code` STRING COMMENT 'Payment block code.',
    `payment_block_reason` STRING COMMENT 'Payment block reason.',
    `payment_cleared_date` DATE COMMENT 'Date payment was cleared.',
    `payment_document_number` STRING COMMENT 'Payment document number.',
    `payment_due_date` DATE COMMENT 'Payment due date.',
    `payment_method_code` STRING COMMENT 'Payment method code.',
    `payment_run_date` DATE COMMENT 'Payment run date.',
    `payment_terms_code` STRING COMMENT 'Payment terms code.',
    `plant_code` STRING COMMENT 'Plant code.',
    `posting_date` DATE COMMENT 'Posting date.',
    `reference_document_number` STRING COMMENT 'Reference document number.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code.',
    `wbs_element` STRING COMMENT 'WBS element.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Withholding tax amount.',
    `created_by` STRING COMMENT 'Created by user.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Invoice received from a vendor for goods or services delivered, subject to three-way match verification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique surrogate key.',
    `employee_id` BIGINT COMMENT 'Evaluating employee.',
    `procurement_contract_id` BIGINT COMMENT 'Associated contract.',
    `vendor_id` BIGINT COMMENT 'Vendor being evaluated.',
    `approved_by_name` STRING COMMENT 'Approver name.',
    `approved_date` DATE COMMENT 'Approval date.',
    `coa_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Certificate of Analysis compliance rate.',
    `commodity_category` STRING COMMENT 'Commodity category evaluated.',
    `corrective_action_description` STRING COMMENT 'Corrective action description.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates if corrective action is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Currency.',
    `evaluation_date` DATE COMMENT 'Date of evaluation.',
    `evaluation_notes` STRING COMMENT 'Evaluation notes.',
    `evaluation_number` STRING COMMENT 'Evaluation number.',
    `evaluation_period_end_date` DATE COMMENT 'Period end date.',
    `evaluation_period_start_date` DATE COMMENT 'Period start date.',
    `evaluation_status` STRING COMMENT 'Evaluation status.',
    `evaluator_name` STRING COMMENT 'Evaluator name.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'On-time delivery rate percentage.',
    `order_fill_rate_pct` DECIMAL(18,2) COMMENT 'Order fill rate percentage.',
    `overall_performance_rating` STRING COMMENT 'Overall rating.',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'Overall numeric score.',
    `pricing_accuracy_rate_pct` DECIMAL(18,2) COMMENT 'Pricing accuracy rate.',
    `quality_conformance_rate_pct` DECIMAL(18,2) COMMENT 'Quality conformance rate.',
    `recommendation` STRING COMMENT 'Recommendation.',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Responsiveness score.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total order value in period.',
    `total_orders_evaluated` STRING COMMENT 'Number of orders evaluated.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic evaluation of vendor performance including delivery, quality, pricing, and responsiveness metrics.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` (
    `material_requisition_id` BIGINT COMMENT 'Unique surrogate key.',
    `cip_project_id` BIGINT COMMENT 'Associated CIP project.',
    `cost_center_id` BIGINT COMMENT 'Cost center.',
    `fund_id` BIGINT COMMENT 'Fund.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `registry_id` BIGINT COMMENT 'Asset registry reference.',
    `material_registry_id` BIGINT COMMENT 'Asset registry.',
    `material_master_id` BIGINT COMMENT 'Material.',
    `work_order_id` BIGINT COMMENT 'Associated work order.',
    `batch_number` STRING COMMENT 'Batch number.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `deleted_flag` BOOLEAN COMMENT 'Soft delete indicator.',
    `final_issue_flag` BOOLEAN COMMENT 'Indicates final issue.',
    `issue_date` DATE COMMENT 'Date material was issued.',
    `issued_by` STRING COMMENT 'Person who issued.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'Quantity issued.',
    `material_description` STRING COMMENT 'Material description.',
    `material_document_number` STRING COMMENT 'Material document number.',
    `material_document_year` STRING COMMENT 'Material document year.',
    `material_number` STRING COMMENT 'Material number.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `movement_type` STRING COMMENT 'Movement type.',
    `notes` STRING COMMENT 'Notes.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Outstanding quantity.',
    `plant_code` STRING COMMENT 'Plant code.',
    `priority` STRING COMMENT 'Priority.',
    `requested_by` STRING COMMENT 'Requestor name.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity requested.',
    `requesting_department` STRING COMMENT 'Requesting department.',
    `required_date` DATE COMMENT 'Date material is required.',
    `requisition_status` STRING COMMENT 'Status.',
    `requisition_type` STRING COMMENT 'Type.',
    `reservation_date` DATE COMMENT 'Reservation date.',
    `reservation_item_number` STRING COMMENT 'Reservation item number.',
    `reservation_number` STRING COMMENT 'Reservation number.',
    `special_stock_indicator` STRING COMMENT 'Special stock indicator.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `valuation_type` STRING COMMENT 'Valuation type.',
    `warehouse_location` STRING COMMENT 'Warehouse location.',
    `wbs_element` STRING COMMENT 'WBS element.',
    CONSTRAINT pk_material_requisition PRIMARY KEY(`material_requisition_id`)
) COMMENT 'Internal request to issue materials from inventory for maintenance, operations, or project use.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique surrogate key.',
    `vendor_id` BIGINT COMMENT 'Vendor awarded the RFQ.',
    `cip_project_id` BIGINT COMMENT 'Associated CIP project.',
    `finance_budget_id` BIGINT COMMENT 'Budget.',
    `fund_id` BIGINT COMMENT 'Fund.',
    `material_master_id` BIGINT COMMENT 'Material.',
    `procurement_category_id` BIGINT COMMENT 'Procurement category.',
    `purchase_requisition_id` BIGINT COMMENT 'Originating requisition.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Awarded amount.',
    `awarded_date` DATE COMMENT 'Award date.',
    `bonding_required_flag` BOOLEAN COMMENT 'Bonding required.',
    `buyer_email` STRING COMMENT 'Buyer email.',
    `buyer_name` STRING COMMENT 'Buyer name.',
    `buyer_phone` STRING COMMENT 'Buyer phone.',
    `cancellation_reason` STRING COMMENT 'Cancellation reason.',
    `closing_date` DATE COMMENT 'Closing date.',
    `closing_time` TIMESTAMP COMMENT 'Closing time.',
    `competitive_bidding_flag` BOOLEAN COMMENT 'Competitive bidding indicator.',
    `cost_center` STRING COMMENT 'Cost center.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `currency_code` STRING COMMENT 'Currency.',
    `delivery_location` STRING COMMENT 'Delivery location.',
    `delivery_required_date` DATE COMMENT 'Required delivery date.',
    `rfq_description` STRING COMMENT 'Description.',
    `diversity_preference_flag` BOOLEAN COMMENT 'Diversity preference.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Estimated budget.',
    `evaluation_criteria` STRING COMMENT 'Evaluation criteria.',
    `general_ledger_account` STRING COMMENT 'GL account.',
    `incoterms` STRING COMMENT 'Incoterms.',
    `insurance_required_flag` BOOLEAN COMMENT 'Insurance required.',
    `invited_vendor_count` STRING COMMENT 'Number of vendors invited.',
    `issue_date` DATE COMMENT 'Issue date.',
    `minimum_vendors_required` STRING COMMENT 'Minimum vendors required.',
    `modified_by` STRING COMMENT 'Modified by.',
    `modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `notes` STRING COMMENT 'Notes.',
    `payment_terms` STRING COMMENT 'Payment terms.',
    `pre_bid_attendance_mandatory_flag` BOOLEAN COMMENT 'Pre-bid attendance mandatory.',
    `pre_bid_meeting_date` DATE COMMENT 'Pre-bid meeting date.',
    `pre_bid_meeting_location` STRING COMMENT 'Pre-bid meeting location.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity requested.',
    `quotes_received_count` STRING COMMENT 'Number of quotes received.',
    `response_due_date` DATE COMMENT 'Response due date.',
    `rfq_number` STRING COMMENT 'RFQ number.',
    `rfq_status` STRING COMMENT 'Status.',
    `rfq_type` STRING COMMENT 'Type.',
    `technical_contact_email` STRING COMMENT 'Technical contact email.',
    `technical_contact_name` STRING COMMENT 'Technical contact name.',
    `title` STRING COMMENT 'RFQ title.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `created_by` STRING COMMENT 'Created by user.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to vendors for competitive bidding on materials or services.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique surrogate key.',
    `employee_id` BIGINT COMMENT 'Approving employee.',
    `procurement_category_id` BIGINT COMMENT 'Procurement category.',
    `procurement_contract_id` BIGINT COMMENT 'Associated contract.',
    `vendor_id` BIGINT COMMENT 'Approved vendor.',
    `approval_justification` STRING COMMENT 'Justification for approval.',
    `approval_number` STRING COMMENT 'Approval number.',
    `approval_status` STRING COMMENT 'Status.',
    `approval_type` STRING COMMENT 'Type.',
    `approved_spend_limit_amount` DECIMAL(18,2) COMMENT 'Spend limit.',
    `approved_spend_limit_currency_code` STRING COMMENT 'Spend limit currency.',
    `approved_spend_limit_period` STRING COMMENT 'Spend limit period.',
    `awwa_standards_compliance_flag` BOOLEAN COMMENT 'AWWA compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `effective_start_date` DATE COMMENT 'Start date.',
    `environmental_qualification_met_flag` BOOLEAN COMMENT 'Environmental qualification met.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `financial_qualification_met_flag` BOOLEAN COMMENT 'Financial qualification met.',
    `insurance_qualification_met_flag` BOOLEAN COMMENT 'Insurance qualification met.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `last_performance_review_date` DATE COMMENT 'Last performance review date.',
    `last_review_date` DATE COMMENT 'Last review date.',
    `local_vendor_flag` BOOLEAN COMMENT 'Local vendor indicator.',
    `minority_owned_business_flag` BOOLEAN COMMENT 'Minority owned.',
    `next_review_date` DATE COMMENT 'Next review date.',
    `notes` STRING COMMENT 'Notes.',
    `nsf_certification_flag` BOOLEAN COMMENT 'NSF certification.',
    `performance_rating_score` DECIMAL(18,2) COMMENT 'Performance rating score.',
    `qualification_date` DATE COMMENT 'Qualification date.',
    `quality_qualification_met_flag` BOOLEAN COMMENT 'Quality qualification met.',
    `reinstatement_date` DATE COMMENT 'Reinstatement date.',
    `reviewing_authority_name` STRING COMMENT 'Reviewing authority name.',
    `reviewing_authority_title` STRING COMMENT 'Reviewing authority title.',
    `safety_qualification_met_flag` BOOLEAN COMMENT 'Safety qualification met.',
    `service_category_code` STRING COMMENT 'Service category code.',
    `small_business_flag` BOOLEAN COMMENT 'Small business indicator.',
    `suspension_date` DATE COMMENT 'Suspension date.',
    `suspension_reason` STRING COMMENT 'Suspension reason.',
    `technical_qualification_met_flag` BOOLEAN COMMENT 'Technical qualification met.',
    `woman_owned_business_flag` BOOLEAN COMMENT 'Woman owned indicator.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Registry of vendors approved to supply specific categories of materials or services to the utility.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` (
    `procurement_category_id` BIGINT COMMENT 'Unique surrogate key.',
    `employee_id` BIGINT COMMENT 'Category manager.',
    `cost_center_id` BIGINT COMMENT 'Default cost center.',
    `finance_budget_id` BIGINT COMMENT 'Budget.',
    `fund_id` BIGINT COMMENT 'Fund.',
    `general_ledger_id` BIGINT COMMENT 'GL account.',
    `parent_procurement_category_id` BIGINT COMMENT 'Parent category in hierarchy.',
    `parent_procurement_category_id_legacy` BIGINT COMMENT 'Legacy parent category reference.',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'Annual spend amount.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Approval threshold.',
    `average_lead_time_days` STRING COMMENT 'Average lead time.',
    `awwa_standards_compliance_flag` BOOLEAN COMMENT 'AWWA compliance.',
    `budget_code` STRING COMMENT 'Budget code.',
    `capital_eligible_flag` BOOLEAN COMMENT 'Capital eligible.',
    `capital_vs_opex_classification` STRING COMMENT 'Capital vs opex.',
    `category_code` STRING COMMENT 'Category code.',
    `category_description` STRING COMMENT 'Description.',
    `category_level` STRING COMMENT 'Hierarchy level.',
    `category_name` STRING COMMENT 'Category name.',
    `category_status` STRING COMMENT 'Status.',
    `category_type` STRING COMMENT 'Type.',
    `chemical_category_flag` BOOLEAN COMMENT 'Chemical category.',
    `commodity_code` STRING COMMENT 'Commodity code.',
    `commodity_group` STRING COMMENT 'Commodity group.',
    `competitive_bid_required_flag` BOOLEAN COMMENT 'Competitive bid required.',
    `competitive_bidding_required_flag` BOOLEAN COMMENT 'Competitive bidding required.',
    `contract_required_flag` BOOLEAN COMMENT 'Contract required.',
    `created_timestamp` TIMESTAMP COMMENT 'Creation timestamp.',
    `critical_spare_flag` BOOLEAN COMMENT 'Critical spare.',
    `currency_code` STRING COMMENT 'Currency.',
    `default_lead_time_days` STRING COMMENT 'Default lead time.',
    `diversity_preference_flag` BOOLEAN COMMENT 'Diversity preference.',
    `effective_end_date` DATE COMMENT 'End date.',
    `effective_start_date` DATE COMMENT 'Start date.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Environmental compliance.',
    `environmental_compliance_required_flag` BOOLEAN COMMENT 'Environmental compliance required.',
    `gl_account_code` STRING COMMENT 'GL account code.',
    `hazardous_material_category_flag` BOOLEAN COMMENT 'Hazmat category.',
    `hazmat_flag` BOOLEAN COMMENT 'Hazmat flag.',
    `insurance_requirement_description` STRING COMMENT 'Insurance requirements.',
    `inventory_managed_flag` BOOLEAN COMMENT 'Inventory managed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modification timestamp.',
    `local_preference_flag` BOOLEAN COMMENT 'Local preference.',
    `material_group_code` STRING COMMENT 'Material group code.',
    `minimum_order_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum order threshold.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum order value.',
    `minority_business_enterprise_goal_percent` DECIMAL(18,2) COMMENT 'MBE goal percentage.',
    `notes` STRING COMMENT 'Notes.',
    `nsf_certification_required_flag` BOOLEAN COMMENT 'NSF certification required.',
    `preferred_sourcing_strategy` STRING COMMENT 'Preferred sourcing strategy.',
    `procurement_category_status` STRING COMMENT 'Procurement category status.',
    `purchasing_group_code` STRING COMMENT 'Purchasing group code.',
    `quality_certification_required` STRING COMMENT 'Quality certification required.',
    `responsible_buyer_email` STRING COMMENT 'Responsible buyer email.',
    `responsible_buyer_name` STRING COMMENT 'Responsible buyer name.',
    `spend_visibility_flag` BOOLEAN COMMENT 'Spend visibility.',
    `standard_unit_of_measure` STRING COMMENT 'Standard UOM.',
    `strategic_category_flag` BOOLEAN COMMENT 'Strategic category.',
    `unspsc_code` STRING COMMENT 'UNSPSC code.',
    `unspsc_description` STRING COMMENT 'UNSPSC description.',
    `woman_business_enterprise_goal_percent` DECIMAL(18,2) COMMENT 'WBE goal percentage.',
    CONSTRAINT pk_procurement_category PRIMARY KEY(`procurement_category_id`)
) COMMENT 'Hierarchical classification of procurement spend categories for reporting, policy enforcement, and sourcing strategy.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` (
    `project_vendor_engagement_id` BIGINT COMMENT 'Unique surrogate key.',
    `cip_project_id` BIGINT COMMENT 'Associated CIP project.',
    `vendor_id` BIGINT COMMENT 'Engaged vendor.',
    `actual_amount_paid` DECIMAL(18,2) COMMENT 'Actual amount paid to date.',
    `change_order_count` STRING COMMENT 'Number of change orders.',
    `contract_award_date` DATE COMMENT 'Award date.',
    `contract_end_date` DATE COMMENT 'End date.',
    `contract_start_date` DATE COMMENT 'Start date.',
    `contract_status` STRING COMMENT 'Status.',
    `contract_value` DECIMAL(18,2) COMMENT 'Contract value.',
    `created_date` TIMESTAMP COMMENT 'Creation timestamp.',
    `design_firm_name` STRING COMMENT 'Design firm name.',
    `general_contractor_name` STRING COMMENT 'General contractor name.',
    `insurance_verified_flag` BOOLEAN COMMENT 'Insurance verified.',
    `last_updated_by` STRING COMMENT 'Last updated by.',
    `last_updated_date` TIMESTAMP COMMENT 'Last update timestamp.',
    `performance_rating` STRING COMMENT 'Performance rating.',
    `purchase_order_number` STRING COMMENT 'PO number.',
    `role_type` STRING COMMENT 'Vendor role type on project.',
    `created_by` STRING COMMENT 'Created by user.',
    CONSTRAINT pk_project_vendor_engagement PRIMARY KEY(`project_vendor_engagement_id`)
) COMMENT 'Tracks vendor engagements on capital improvement projects including contract value, performance, and status.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_primary_po_material_master_id` FOREIGN KEY (`primary_po_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_goods_material_material_master_id` FOREIGN KEY (`goods_material_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_stock_material_material_master_id` FOREIGN KEY (`stock_material_material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_parent_procurement_category_id` FOREIGN KEY (`parent_procurement_category_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_parent_procurement_category_id_legacy` FOREIGN KEY (`parent_procurement_category_id_legacy`) REFERENCES `vibe_water_utilities_v1`.`supply`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ADD CONSTRAINT `fk_supply_project_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_water_utilities_v1`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`supply` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate On File');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `name_short` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii' = 'tax_id');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W9 On File Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_wtp_facility_id` SET TAGS ('dbx_business_glossary_term' = 'WTP Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_wtp_facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `discontinued_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinued Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Class');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `issue_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Issue Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `primary_purchase_requisitioner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requesting_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Requesting Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_requisition` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line1` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_address_line2` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `delivery_state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `is_capital_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Purchase');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'PO Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'PO Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'PO Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'PO Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Amount With Tax');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `primary_po_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary PO Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `primary_po_material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Control Key');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `invoice_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percent');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchase_requisition_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Item');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percent');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`po_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `goods_material_material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_condition` SET TAGS ('dbx_business_glossary_term' = 'Delivery Condition');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_date` SET TAGS ('dbx_business_glossary_term' = 'GR Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'GR Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_posting_date` SET TAGS ('dbx_business_glossary_term' = 'GR Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'GR Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `invoice_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Personnel Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `receiving_personnel_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three Way Match Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Inventory Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `average_daily_consumption` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `consignment_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `days_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Days of Supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `expiration_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Expiration Controlled Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `last_stock_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Stock Adjustment Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'MRP Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `serial_number_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_turnover_ratio` SET TAGS ('dbx_business_glossary_term' = 'Stock Turnover Ratio');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Value Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'From Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `stock_material_material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount In Local Currency');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Item');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `storage_location_to` SET TAGS ('dbx_business_glossary_term' = 'Storage Location To');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `text_header` SET TAGS ('dbx_business_glossary_term' = 'Text Header');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `text_item` SET TAGS ('dbx_business_glossary_term' = 'Text Item');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`stock_movement` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `access_hours` SET TAGS ('dbx_business_glossary_term' = 'Access Hours');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii' = 'address');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `available_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Sqft');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Certified');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `inventory_cycle_count_frequency` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `responsible_custodian` SET TAGS ('dbx_business_glossary_term' = 'Responsible Custodian');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `responsible_custodian` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `sap_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Storage Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `spill_containment_available` SET TAGS ('dbx_business_glossary_term' = 'Spill Containment Available');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_control_available` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Available');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_max_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Max F');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `temperature_range_min_f` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Min F');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `total_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity Sqft');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`warehouse_location` ALTER COLUMN `ventilation_type` SET TAGS ('dbx_business_glossary_term' = 'Ventilation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `minority_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Minority Business Enterprise');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `performance_clause` SET TAGS ('dbx_business_glossary_term' = 'Performance Clause');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `remaining_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `small_business_enterprise` SET TAGS ('dbx_business_glossary_term' = 'Small Business Enterprise');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Released Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `total_released_value` SET TAGS ('dbx_business_glossary_term' = 'Total Released Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_contract` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'PO Line Item ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_invoice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `coa_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'COA Compliance Rate Pct');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Rate Pct');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `order_fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Pct');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `pricing_accuracy_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Pricing Accuracy Rate Pct');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `quality_conformance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality Conformance Rate Pct');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Recommendation');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`vendor_performance` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `registry_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_registry_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `work_order_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `deleted_flag` SET TAGS ('dbx_business_glossary_term' = 'Deleted Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `final_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Issue Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issued_by` SET TAGS ('dbx_business_glossary_term' = 'Issued By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requested_by` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_item_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Item Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`material_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'WBS Element');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'RFQ ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `awarded_date` SET TAGS ('dbx_business_glossary_term' = 'Awarded Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `bonding_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonding Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii' = 'phone');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `closing_time` SET TAGS ('dbx_business_glossary_term' = 'Closing Time');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `competitive_bidding_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bidding Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `delivery_required_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Required Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'RFQ Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `diversity_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `invited_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `minimum_vendors_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Vendors Required');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_attendance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre Bid Attendance Mandatory Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre Bid Meeting Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `pre_bid_meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Pre Bid Meeting Location');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `quotes_received_count` SET TAGS ('dbx_business_glossary_term' = 'Quotes Received Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'RFQ Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'RFQ Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'RFQ Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `technical_contact_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`rfq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_justification` SET TAGS ('dbx_business_glossary_term' = 'Approval Justification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `approved_spend_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Limit Period');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `awwa_standards_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'AWWA Standards Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `environmental_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `financial_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `insurance_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `local_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Vendor Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `minority_owned_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `nsf_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `performance_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating Score');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `quality_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Authority Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `reviewing_authority_title` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Authority Title');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `safety_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `service_category_code` SET TAGS ('dbx_business_glossary_term' = 'Service Category Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `technical_qualification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Qualification Met Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`approved_vendor_list` ALTER COLUMN `woman_owned_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Business Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `fund_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Procurement Category ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id_legacy` SET TAGS ('dbx_business_glossary_term' = 'Parent Procurement Category ID Legacy');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `parent_procurement_category_id_legacy` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `annual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `average_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `awwa_standards_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'AWWA Standards Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `capital_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Eligible Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `capital_vs_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital vs Opex Classification');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Category Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `chemical_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Chemical Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `competitive_bid_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bid Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `competitive_bidding_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Competitive Bidding Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `contract_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `default_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Default Lead Time Days');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `diversity_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversity Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `environmental_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'GL Account Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `hazardous_material_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazmat Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `insurance_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `inventory_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Managed Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `local_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Preference Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minimum_order_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Threshold Amount');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `minority_business_enterprise_goal_percent` SET TAGS ('dbx_business_glossary_term' = 'MBE Goal Percent');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `nsf_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'NSF Certification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `preferred_sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Preferred Sourcing Strategy');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `procurement_category_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer Email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_email` SET TAGS ('dbx_pii' = 'email');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Buyer Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `responsible_buyer_name` SET TAGS ('dbx_pii' = 'name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `spend_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Spend Visibility Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `strategic_category_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Category Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Code');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `unspsc_description` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Description');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`procurement_category` ALTER COLUMN `woman_business_enterprise_goal_percent` SET TAGS ('dbx_business_glossary_term' = 'WBE Goal Percent');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_association_edges' = 'supply.vendor,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` SET TAGS ('dbx_structure_required' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `project_vendor_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Project Vendor Engagement ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `project_vendor_engagement_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `actual_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount Paid');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_award_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Award Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `design_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Design Firm Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_business_glossary_term' = 'General Contractor Name');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `general_contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `insurance_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_water_utilities_v1`.`supply`.`project_vendor_engagement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
