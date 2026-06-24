-- Schema for Domain: vendor | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`vendor` COMMENT 'Manages non-provider third-party vendor and supplier relationships — IT service providers, office supply vendors, facilities management companies, consulting firms, print/mail houses, and other business partners. Tracks vendor master data, contracts, performance, spend, compliance certifications, and risk assessments.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor',
    `parent_vendor_id` BIGINT COMMENT 'Parent vendor for hierarchy',
    `business_category` STRING COMMENT 'Business category classification',
    `compliance_status` STRING COMMENT 'Current compliance status',
    `contract_effective_date` DATE COMMENT 'The date value representing contract effective date for this vendor record.',
    `contract_expiration_date` DATE COMMENT 'The date value representing contract expiration date for this vendor record.',
    `contract_number` STRING COMMENT 'Primary contract number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `credit_rating` STRING COMMENT 'Credit rating of the vendor',
    `dba_name` STRING COMMENT 'Doing-business-as name',
    `default_currency` STRING COMMENT 'Default currency for transactions',
    `duns_number` STRING COMMENT 'Dun and Bradstreet number',
    `incorporation_state` STRING COMMENT 'State of incorporation',
    `insurance_certifications` STRING COMMENT 'Insurance certifications held',
    `last_risk_assessment_date` DATE COMMENT 'Date of last risk assessment',
    `legal_name` STRING COMMENT 'Legal registered name of the vendor',
    `minority_owned_flag` BOOLEAN COMMENT 'Whether vendor is minority-owned',
    `vendor_name` STRING COMMENT 'Business name of the vendor',
    `notes` STRING COMMENT 'Free-text notes',
    `onboarding_status` STRING COMMENT 'Onboarding workflow status',
    `ownership_structure` STRING COMMENT 'Ownership structure type',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms',
    `primary_naics_code` STRING COMMENT 'Primary NAICS industry code',
    `relationship_end_date` DATE COMMENT 'End of vendor relationship',
    `relationship_start_date` DATE COMMENT 'Start of vendor relationship',
    `risk_score` STRING COMMENT 'Calculated risk score',
    `secondary_naics_codes` STRING COMMENT 'The secondary naics codes attribute capturing relevant data for the vendor in the vendor domain.',
    `small_business_flag` BOOLEAN COMMENT 'Whether vendor qualifies as small business',
    `tax_identification_number` STRING COMMENT 'The tax identification number attribute capturing relevant data for the vendor in the vendor domain.',
    `tax_identifier` STRING COMMENT 'Alternate tax identifier',
    `tier` STRING COMMENT 'Tier classification for vendor management',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_number` STRING COMMENT 'External vendor number for reference',
    `vendor_status` STRING COMMENT 'Current status of the vendor relationship',
    `vendor_type` STRING COMMENT 'Classification of vendor type',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `website_url` STRING COMMENT 'Vendor website URL',
    `women_owned_flag` BOOLEAN COMMENT 'Whether vendor is women-owned',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for third-party vendors, suppliers, and business partners. Aligned with FHIR Organization resource conventions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'Unique identifier for vendor contact',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity',
    `employee_id` BIGINT COMMENT 'FK to internal employee if applicable',
    `parent_vendor_contact_id` BIGINT COMMENT 'Parent contact for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the vendor contact in the vendor domain.',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `country_code` STRING COMMENT 'A standardized code representing the country classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `department` STRING COMMENT 'Department within vendor org',
    `email_address` STRING COMMENT 'The email address attribute capturing relevant data for the vendor contact in the vendor domain.',
    `end_date` DATE COMMENT 'Contact effective end date',
    `first_name` STRING COMMENT 'Contact first name',
    `is_primary_contact` BOOLEAN COMMENT 'Whether this is the primary contact',
    `last_name` STRING COMMENT 'Contact last name',
    `notes` STRING COMMENT 'Free-text notes',
    `phone_number` STRING COMMENT 'The phone number attribute capturing relevant data for the vendor contact in the vendor domain.',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification.',
    `preferred_communication_channel` STRING COMMENT 'The preferred communication channel attribute capturing relevant data for the vendor contact in the vendor domain.',
    `primary_contact_method` STRING COMMENT 'Preferred contact method',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the vendor contact in the vendor domain.',
    `role_type` STRING COMMENT 'Role type of the contact',
    `start_date` DATE COMMENT 'Contact effective start date',
    `state_province` STRING COMMENT 'State or province',
    `title` STRING COMMENT 'The title attribute capturing relevant data for the vendor contact in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_contact_status` STRING COMMENT 'Status of the contact record',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Contact persons associated with a vendor. Aligned with FHIR ContactPoint conventions.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` (
    `vendor_address_id` BIGINT COMMENT 'Unique identifier for vendor address',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity',
    `parent_vendor_address_id` BIGINT COMMENT 'Parent address for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `address_description` STRING COMMENT 'Description of the address',
    `address_name` STRING COMMENT 'Name for the address location',
    `address_status` STRING COMMENT 'Status of the address',
    `address_type` STRING COMMENT 'Type of address',
    `change_reason` STRING COMMENT 'Reason for address change',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the vendor address in the vendor domain.',
    `contact_email` STRING COMMENT 'Contact email at this address',
    `contact_phone` STRING COMMENT 'Contact phone at this address',
    `country_code` STRING COMMENT 'A standardized code representing the country classification.',
    `county` STRING COMMENT 'The county attribute capturing relevant data for the vendor address in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Address effective date',
    `end_date` DATE COMMENT 'Address end date',
    `fax_number` STRING COMMENT 'The fax number attribute capturing relevant data for the vendor address in the vendor domain.',
    `geocode_accuracy` STRING COMMENT 'Geocode accuracy level',
    `is_current` BOOLEAN COMMENT 'Whether this address is current',
    `is_primary` BOOLEAN COMMENT 'Whether this is the primary address',
    `last_verified_date` DATE COMMENT 'Last verification date',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate',
    `line1` STRING COMMENT 'Address line 1',
    `line2` STRING COMMENT 'Address line 2',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate',
    `notes` STRING COMMENT 'Free-text notes',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification.',
    `state_province` STRING COMMENT 'State or province',
    `time_zone` STRING COMMENT 'The time zone attribute capturing relevant data for the vendor address in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `validation_source` STRING COMMENT 'Source of validation',
    `validation_status` STRING COMMENT 'Address validation status',
    `vendor_address_status` STRING COMMENT 'Vendor address record status',
    `verification_notes` STRING COMMENT 'The verification notes attribute capturing relevant data for the vendor address in the vendor domain.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_address PRIMARY KEY(`vendor_address_id`)
) COMMENT 'Physical and mailing addresses for vendors. Aligned with FHIR Address datatype.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for vendor contract',
    `employee_id` BIGINT COMMENT 'FK to business owner employee',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity',
    `parent_vendor_contract_id` BIGINT COMMENT 'Parent contract for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `amendment_count` STRING COMMENT 'Number of amendments',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'The annual contract value attribute capturing relevant data for the vendor contract in the vendor domain.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Whether contract auto-renews',
    `compliance_certifications` STRING COMMENT 'Required compliance certifications',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification',
    `contract_description` STRING COMMENT 'Description of contract',
    `contract_number` STRING COMMENT 'The contract number attribute capturing relevant data for the vendor contract in the vendor domain.',
    `contract_type` STRING COMMENT 'Type of contract',
    `created_by_user` STRING COMMENT 'User who created the record',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `data_security_requirements` STRING COMMENT 'The data security requirements attribute capturing relevant data for the vendor contract in the vendor domain.',
    `effective_date` DATE COMMENT 'Contract effective date',
    `execution_date` DATE COMMENT 'Date contract was executed',
    `expiration_date` DATE COMMENT 'Contract expiration date',
    `governing_law` STRING COMMENT 'Governing law jurisdiction',
    `insurance_requirements` STRING COMMENT 'The insurance requirements attribute capturing relevant data for the vendor contract in the vendor domain.',
    `is_exclusive` BOOLEAN COMMENT 'Whether contract is exclusive',
    `is_mandatory` BOOLEAN COMMENT 'Whether contract is mandatory',
    `last_amendment_date` DATE COMMENT 'Date of last amendment',
    `notes` STRING COMMENT 'Free-text notes',
    `notice_sent_date` DATE COMMENT 'Date notice was sent',
    `notice_sent_flag` BOOLEAN COMMENT 'Whether renewal notice was sent',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the vendor contract in the vendor domain.',
    `penalty_clause` STRING COMMENT 'Penalty clause details',
    `performance_metric` STRING COMMENT 'Key performance metrics',
    `regulatory_compliance` STRING COMMENT 'Regulatory compliance details',
    `renewal_notice_period_days` STRING COMMENT 'Days notice required for renewal',
    `renewal_option` STRING COMMENT 'Renewal option details',
    `risk_score` STRING COMMENT 'Contract risk score',
    `service_scope` STRING COMMENT 'Scope of services',
    `signed_date` DATE COMMENT 'Date contract was signed',
    `status_reason` STRING COMMENT 'Reason for current status',
    `termination_date` DATE COMMENT 'Termination date if terminated early',
    `title` STRING COMMENT 'Contract title',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total contract value attribute capturing relevant data for the vendor contract in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `url` STRING COMMENT 'URL to contract document',
    `vendor_contract_status` STRING COMMENT 'Current contract status',
    `version` STRING COMMENT 'Contract version',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Contracts between the organization and vendors. Aligned with FHIR Contract resource.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` (
    `contract_term_id` BIGINT COMMENT 'Unique identifier for contract term',
    `parent_contract_term_id` BIGINT COMMENT 'Parent term for hierarchy',
    `employee_id` BIGINT COMMENT 'FK to responsible employee',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `amendment_number` STRING COMMENT 'Amendment number if amended',
    `auto_renew_flag` BOOLEAN COMMENT 'Whether term auto-renews',
    `clause_number` STRING COMMENT 'Clause number reference',
    `compliance_regulation` STRING COMMENT 'Applicable regulation',
    `compliance_required` BOOLEAN COMMENT 'Whether compliance is required',
    `contact_email` STRING COMMENT 'Contact email for term',
    `contact_phone` STRING COMMENT 'Contact phone for term',
    `contract_term_status` STRING COMMENT 'Status of the term',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_end_date` DATE COMMENT 'Term effective end date',
    `effective_start_date` DATE COMMENT 'Term effective start date',
    `escalation_procedure` STRING COMMENT 'The escalation procedure attribute capturing relevant data for the contract term in the vendor domain.',
    `is_mandatory` BOOLEAN COMMENT 'Whether term is mandatory',
    `jurisdiction` STRING COMMENT 'Applicable jurisdiction',
    `last_review_timestamp` TIMESTAMP COMMENT 'The last review timestamp attribute capturing relevant data for the contract term in the vendor domain.',
    `measurement_method` STRING COMMENT 'Method of measurement',
    `notes` STRING COMMENT 'Free-text notes',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The numeric penalty amount value associated with this contract term record.',
    `penalty_description` STRING COMMENT 'A detailed textual description of the penalty.',
    `penalty_type` STRING COMMENT 'Type of penalty',
    `performance_metric` STRING COMMENT 'The performance metric attribute capturing relevant data for the contract term in the vendor domain.',
    `renewal_notice_days` STRING COMMENT 'Days notice for renewal',
    `renewal_option` STRING COMMENT 'Renewal option details',
    `review_frequency_days` STRING COMMENT 'Review frequency in days',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score for the term',
    `target_value` DECIMAL(18,2) COMMENT 'Target value for metric',
    `term_description` STRING COMMENT 'Description of the term',
    `term_type` STRING COMMENT 'Type of contract term',
    `termination_fee` DECIMAL(18,2) COMMENT 'Fee for early termination',
    `termination_notice_days` STRING COMMENT 'Days notice for termination',
    `threshold_value` DECIMAL(18,2) COMMENT 'Threshold value for metric',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute capturing relevant data for the contract term in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_contract_term PRIMARY KEY(`contract_term_id`)
) COMMENT 'Individual terms and clauses within a vendor contract.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique identifier for contract amendment',
    `employee_id` BIGINT COMMENT 'FK to approving employee',
    `parent_contract_amendment_id` BIGINT COMMENT 'Parent amendment for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `amendment_amount` DECIMAL(18,2) COMMENT 'Financial impact of amendment',
    `amendment_number` STRING COMMENT 'Amendment sequence number',
    `amendment_reason` STRING COMMENT 'Reason for amendment',
    `amendment_type` STRING COMMENT 'Type of amendment',
    `approval_date` DATE COMMENT 'Date of approval',
    `change_summary` STRING COMMENT 'Summary of changes',
    `contract_amendment_status` STRING COMMENT 'Status of the amendment',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `contract_amendment_description` STRING COMMENT 'Description of amendment',
    `effective_date` DATE COMMENT 'Amendment effective date',
    `expiration_date` DATE COMMENT 'Amendment expiration date',
    `notes` STRING COMMENT 'Free-text notes',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` STRING COMMENT 'User who created the amendment',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Amendments to vendor contracts tracking changes over time.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`spend` (
    `spend_id` BIGINT COMMENT 'Unique identifier for spend record',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to approving employee',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `parent_spend_id` BIGINT COMMENT 'Parent spend for hierarchy',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `amount_discount` DECIMAL(18,2) COMMENT 'Discount amount',
    `amount_gross` DECIMAL(18,2) COMMENT 'Gross amount',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount',
    `amount_original_currency` DECIMAL(18,2) COMMENT 'Amount in original currency',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax amount',
    `amount_usd` DECIMAL(18,2) COMMENT 'Amount in USD',
    `approval_date` DATE COMMENT 'The date value representing approval date for this spend record.',
    `budget_period` STRING COMMENT 'The budget period attribute capturing relevant data for the spend in the vendor domain.',
    `spend_category` STRING COMMENT 'The spend category attribute capturing relevant data for the spend in the vendor domain.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `spend_description` STRING COMMENT 'Description of spend',
    `due_date` DATE COMMENT 'Payment due date',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied',
    `expense_type` DECIMAL(18,2) COMMENT 'Expense type classification',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter attribute capturing relevant data for the spend in the vendor domain.',
    `fiscal_year` STRING COMMENT 'The calendar or fiscal year associated with the fiscal.',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification.',
    `internal_order_number` STRING COMMENT 'The internal order number attribute capturing relevant data for the spend in the vendor domain.',
    `invoice_date` DATE COMMENT 'The date value representing invoice date for this spend record.',
    `invoice_number` STRING COMMENT 'The invoice number attribute capturing relevant data for the spend in the vendor domain.',
    `is_approved` BOOLEAN COMMENT 'Whether spend is approved',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_date` DATE COMMENT 'The date value representing payment date for this spend record.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the spend in the vendor domain.',
    `payment_reference` DECIMAL(18,2) COMMENT 'Payment reference number',
    `project_code` STRING COMMENT 'A standardized code representing the project classification.',
    `receipt_date` DATE COMMENT 'The date value representing receipt date for this spend record.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the spend in the vendor domain.',
    `spend_status` STRING COMMENT 'Status of spend record',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate applied',
    `transaction_date` DATE COMMENT 'Date of the spend transaction',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_rating` STRING COMMENT 'Vendor rating at time of spend',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_spend PRIMARY KEY(`spend_id`)
) COMMENT 'Vendor spend transactions tracking all expenditures with vendors.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for purchase order',
    `budget_line_id` BIGINT COMMENT 'FK to budget line',
    `parent_purchase_order_id` BIGINT COMMENT 'Parent PO for hierarchy',
    `provider_network_id` BIGINT COMMENT 'FK to provider network',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `approval_date` DATE COMMENT 'The date value representing approval date for this purchase order record.',
    `approved_by` BIGINT COMMENT 'Approver ID',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `purchase_order_description` STRING COMMENT 'Description of purchase order',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this purchase order record.',
    `discount_code` STRING COMMENT 'A standardized code representing the discount classification.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The numeric exchange rate value associated with this purchase order record.',
    `invoice_date` DATE COMMENT 'The date value representing invoice date for this purchase order record.',
    `invoice_number` STRING COMMENT 'The invoice number attribute capturing relevant data for the purchase order in the vendor domain.',
    `is_three_way_match_enabled` BOOLEAN COMMENT 'Whether three-way match is enabled',
    `last_modified_by` BIGINT COMMENT 'Last modifier ID',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this purchase order record.',
    `notes` STRING COMMENT 'Free-text notes',
    `order_timestamp` TIMESTAMP COMMENT 'Order placement timestamp',
    `payment_amount` DECIMAL(18,2) COMMENT 'The numeric payment amount value associated with this purchase order record.',
    `payment_date` DATE COMMENT 'The date value representing payment date for this purchase order record.',
    `payment_due_date` DATE COMMENT 'The date value representing payment due date for this purchase order record.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the purchase order in the vendor domain.',
    `po_number` STRING COMMENT 'Purchase order number',
    `po_type` STRING COMMENT 'Type of purchase order',
    `procurement_category` STRING COMMENT 'The procurement category attribute capturing relevant data for the purchase order in the vendor domain.',
    `project_code` STRING COMMENT 'A standardized code representing the project classification.',
    `purchase_order_status` STRING COMMENT 'Status of purchase order',
    `receipt_received_date` DATE COMMENT 'Date receipt was received',
    `requesting_department` STRING COMMENT 'The requesting department attribute capturing relevant data for the purchase order in the vendor domain.',
    `required_delivery_date` DATE COMMENT 'The date value representing required delivery date for this purchase order record.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the purchase order in the vendor domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this purchase order record.',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total PO amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` BIGINT COMMENT 'Creator ID',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase orders issued to vendors for goods and services.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for PO line',
    `parent_po_line_id` BIGINT COMMENT 'Parent PO line for hierarchy',
    `purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `actual_delivery_date` DATE COMMENT 'The date value representing actual delivery date for this po line record.',
    `catalog_item_code` STRING COMMENT 'A standardized code representing the catalog item classification.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `contract_number` STRING COMMENT 'Contract number reference',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `delivery_date` DATE COMMENT 'Expected delivery date',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this po line record.',
    `expiration_date` DATE COMMENT 'Line expiration date',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification.',
    `is_approved` BOOLEAN COMMENT 'Whether line is approved',
    `is_tax_exempt` BOOLEAN COMMENT 'Whether line is tax exempt',
    `item_category` STRING COMMENT 'The item category attribute capturing relevant data for the po line in the vendor domain.',
    `item_description` STRING COMMENT 'Description of item',
    `line_amount` DECIMAL(18,2) COMMENT 'Line total amount',
    `line_number` STRING COMMENT 'Line number within PO',
    `line_status` STRING COMMENT 'Line processing status',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this po line record.',
    `notes` STRING COMMENT 'Free-text notes',
    `po_line_status` STRING COMMENT 'Status of PO line',
    `procurement_method` STRING COMMENT 'The procurement method attribute capturing relevant data for the po line in the vendor domain.',
    `quantity` DECIMAL(18,2) COMMENT 'Ordered quantity',
    `receipt_status` STRING COMMENT 'The current status indicator for the receipt within the workflow.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the po line in the vendor domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this po line record.',
    `tax_code` STRING COMMENT 'A standardized code representing the tax classification.',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute capturing relevant data for the po line in the vendor domain.',
    `unit_price` DECIMAL(18,2) COMMENT 'The unit price attribute capturing relevant data for the po line in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the po line in the vendor domain.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for goods receipt',
    `parent_goods_receipt_id` BIGINT COMMENT 'Parent receipt for hierarchy',
    `purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `accepted_quantity` STRING COMMENT 'Quantity accepted',
    `comments` STRING COMMENT 'The comments attribute capturing relevant data for the goods receipt in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `delivery_note_number` STRING COMMENT 'The delivery note number attribute capturing relevant data for the goods receipt in the vendor domain.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this goods receipt record.',
    `freight_cost` DECIMAL(18,2) COMMENT 'The freight cost attribute capturing relevant data for the goods receipt in the vendor domain.',
    `goods_receipt_status` STRING COMMENT 'Status of goods receipt',
    `gross_amount` DECIMAL(18,2) COMMENT 'The numeric gross amount value associated with this goods receipt record.',
    `inspection_date` DATE COMMENT 'The date value representing inspection date for this goods receipt record.',
    `is_inspection_required` BOOLEAN COMMENT 'Whether inspection is required',
    `match_status` STRING COMMENT 'Three-way match status',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this goods receipt record.',
    `notes` STRING COMMENT 'Free-text notes',
    `receipt_number` STRING COMMENT 'The receipt number attribute capturing relevant data for the goods receipt in the vendor domain.',
    `receipt_status` STRING COMMENT 'Receipt processing status',
    `receipt_timestamp` TIMESTAMP COMMENT 'Timestamp of receipt',
    `received_quantity` STRING COMMENT 'Quantity received',
    `receiver_name` STRING COMMENT 'Name of receiver',
    `receiving_location` STRING COMMENT 'The receiving location attribute capturing relevant data for the goods receipt in the vendor domain.',
    `rejected_quantity` STRING COMMENT 'Quantity rejected',
    `rejection_reason` STRING COMMENT 'Reason for rejection',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this goods receipt record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records of goods and services received from vendors.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for invoice',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity',
    `parent_invoice_id` BIGINT COMMENT 'Parent invoice for hierarchy',
    `employee_id` BIGINT COMMENT 'FK to processing employee',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `currency_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate',
    `invoice_description` STRING COMMENT 'A detailed textual description of the invoice.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this invoice record.',
    `discount_reason` STRING COMMENT 'Reason for discount',
    `dispute_flag` BOOLEAN COMMENT 'Whether invoice is disputed',
    `dispute_reason` STRING COMMENT 'Reason for dispute',
    `due_date` DATE COMMENT 'Payment due date',
    `early_payment_discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount',
    `expense_category` DECIMAL(18,2) COMMENT 'The expense category attribute capturing relevant data for the invoice in the vendor domain.',
    `invoice_date` DATE COMMENT 'The date value representing invoice date for this invoice record.',
    `invoice_number` STRING COMMENT 'The invoice number attribute capturing relevant data for the invoice in the vendor domain.',
    `invoice_status` STRING COMMENT 'The current status indicator for the invoice within the workflow.',
    `is_early_payment_discount` BOOLEAN COMMENT 'Whether early payment discount applies',
    `line_item_count` STRING COMMENT 'Number of line items',
    `net_amount` DECIMAL(18,2) COMMENT 'The numeric net amount value associated with this invoice record.',
    `notes` STRING COMMENT 'Free-text notes',
    `payment_date` DATE COMMENT 'The date value representing payment date for this invoice record.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method attribute capturing relevant data for the invoice in the vendor domain.',
    `payment_status` DECIMAL(18,2) COMMENT 'The current status indicator for the payment within the workflow.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the invoice in the vendor domain.',
    `po_number` STRING COMMENT 'PO number reference',
    `receipt_date` DATE COMMENT 'The date value representing receipt date for this invoice record.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory compliance condition or state.',
    `retention_amount` DECIMAL(18,2) COMMENT 'The numeric retention amount value associated with this invoice record.',
    `retention_release_date` DATE COMMENT 'The date value representing retention release date for this invoice record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this invoice record.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Whether tax exempt',
    `tax_exempt_reason` STRING COMMENT 'Tax exemption reason',
    `tax_rate` DECIMAL(18,2) COMMENT 'The numeric tax rate value associated with this invoice record.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total invoice amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Invoices received from vendors for goods and services rendered.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`performance` (
    `performance_id` BIGINT COMMENT 'Unique identifier for performance record',
    `delegated_entity_id` BIGINT COMMENT 'FK to delegated entity',
    `employee_id` BIGINT COMMENT 'FK to evaluator employee',
    `parent_performance_id` BIGINT COMMENT 'Parent performance for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `customer_satisfaction_rating` DECIMAL(18,2) COMMENT 'The customer satisfaction rating attribute capturing relevant data for the performance in the vendor domain.',
    `evaluation_end_date` DATE COMMENT 'The date value representing evaluation end date for this performance record.',
    `evaluation_period` STRING COMMENT 'The evaluation period attribute capturing relevant data for the performance in the vendor domain.',
    `evaluation_start_date` DATE COMMENT 'The date value representing evaluation start date for this performance record.',
    `evaluation_status` STRING COMMENT 'The current status indicator for the evaluation within the workflow.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'The evaluation timestamp attribute capturing relevant data for the performance in the vendor domain.',
    `evaluator_notes` STRING COMMENT 'The evaluator notes attribute capturing relevant data for the performance in the vendor domain.',
    `financial_stability_rating` DECIMAL(18,2) COMMENT 'The financial stability rating attribute capturing relevant data for the performance in the vendor domain.',
    `issue_resolution_time_days` DECIMAL(18,2) COMMENT 'Average issue resolution time in days',
    `notes` STRING COMMENT 'Free-text notes',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'On-time delivery rate',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall performance score',
    `performance_status` STRING COMMENT 'Performance record status',
    `quality_defect_rate` DECIMAL(18,2) COMMENT 'The numeric quality defect rate value associated with this performance record.',
    `reference` STRING COMMENT 'Reference information',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the performance in the vendor domain.',
    `sla_compliance_rate` DECIMAL(18,2) COMMENT 'The numeric sla compliance rate value associated with this performance record.',
    `tier_decision` STRING COMMENT 'Tier decision based on performance',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_performance PRIMARY KEY(`performance_id`)
) COMMENT 'Vendor performance evaluations and scorecards.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` (
    `sla_event_id` BIGINT COMMENT 'Unique identifier for SLA event',
    `parent_sla_event_id` BIGINT COMMENT 'Parent SLA event for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual measured value',
    `breach_severity` STRING COMMENT 'Severity of breach if applicable',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cure_period_end` DATE COMMENT 'Cure period end date',
    `cure_period_start` DATE COMMENT 'Cure period start date',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp attribute capturing relevant data for the sla event in the vendor domain.',
    `measurement_method` STRING COMMENT 'The measurement method attribute capturing relevant data for the sla event in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The numeric penalty amount value associated with this sla event record.',
    `penalty_triggered` BOOLEAN COMMENT 'Whether penalty was triggered',
    `resolution_date` DATE COMMENT 'The date value representing resolution date for this sla event record.',
    `resolution_status` STRING COMMENT 'The current status indicator for the resolution within the workflow.',
    `sla_event_status` STRING COMMENT 'Event record status',
    `sla_metric_name` STRING COMMENT 'Name of SLA metric',
    `sla_status` STRING COMMENT 'SLA compliance status',
    `target_value` DECIMAL(18,2) COMMENT 'Target SLA value',
    `unit_of_measure` STRING COMMENT 'The unit of measure attribute capturing relevant data for the sla event in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variance` DECIMAL(18,2) COMMENT 'Variance from target',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_sla_event PRIMARY KEY(`sla_event_id`)
) COMMENT 'Service level agreement events tracking compliance and breaches.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for risk assessment',
    `parent_risk_assessment_id` BIGINT COMMENT 'Parent assessment for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `assessment_conducted_by` STRING COMMENT 'Who conducted the assessment',
    `assessment_date` DATE COMMENT 'The date value representing assessment date for this risk assessment record.',
    `assessment_methodology` STRING COMMENT 'The assessment methodology attribute capturing relevant data for the risk assessment in the vendor domain.',
    `assessment_reference_code` STRING COMMENT 'Reference code',
    `assessment_type` STRING COMMENT 'Type of assessment',
    `business_continuity_score` DECIMAL(18,2) COMMENT 'The business continuity score attribute capturing relevant data for the risk assessment in the vendor domain.',
    `compliance_certifications` STRING COMMENT 'The compliance certifications attribute capturing relevant data for the risk assessment in the vendor domain.',
    `concentration_risk_flag` BOOLEAN COMMENT 'Boolean indicator for the concentration risk condition or state.',
    `control_effectiveness_rating` STRING COMMENT 'The control effectiveness rating attribute capturing relevant data for the risk assessment in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cybersecurity_score` DECIMAL(18,2) COMMENT 'The cybersecurity score attribute capturing relevant data for the risk assessment in the vendor domain.',
    `financial_stability_score` DECIMAL(18,2) COMMENT 'The financial stability score attribute capturing relevant data for the risk assessment in the vendor domain.',
    `inherent_risk_rating` STRING COMMENT 'The inherent risk rating attribute capturing relevant data for the risk assessment in the vendor domain.',
    `key_risk_findings` STRING COMMENT 'The key risk findings attribute capturing relevant data for the risk assessment in the vendor domain.',
    `next_assessment_due_date` DATE COMMENT 'The date value representing next assessment due date for this risk assessment record.',
    `notes` STRING COMMENT 'Free-text notes',
    `overall_residual_score` DECIMAL(18,2) COMMENT 'Residual risk score',
    `recommended_mitigations` STRING COMMENT 'The recommended mitigations attribute capturing relevant data for the risk assessment in the vendor domain.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory compliance condition or state.',
    `regulatory_compliance_score` DECIMAL(18,2) COMMENT 'The regulatory compliance score attribute capturing relevant data for the risk assessment in the vendor domain.',
    `reputational_risk_flag` BOOLEAN COMMENT 'Boolean indicator for the reputational risk condition or state.',
    `residual_risk_rating` STRING COMMENT 'The residual risk rating attribute capturing relevant data for the risk assessment in the vendor domain.',
    `risk_assessment_status` STRING COMMENT 'Assessment status',
    `risk_domain` STRING COMMENT 'Risk domain being assessed',
    `risk_score` DECIMAL(18,2) COMMENT 'Overall risk score',
    `risk_tier` STRING COMMENT 'Risk tier classification',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Risk assessments conducted on vendors covering financial, operational, and compliance risks.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'Unique identifier',
    `parent_vendor_certification_id` BIGINT COMMENT 'Parent certification',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `certification_name` STRING COMMENT 'The descriptive name assigned to the certification for identification purposes.',
    `certification_number` STRING COMMENT 'The certification number attribute capturing relevant data for the vendor certification in the vendor domain.',
    `certification_type` STRING COMMENT 'Type of certification',
    `compliance_category` STRING COMMENT 'The compliance category attribute capturing relevant data for the vendor certification in the vendor domain.',
    `compliance_requirements` STRING COMMENT 'The compliance requirements attribute capturing relevant data for the vendor certification in the vendor domain.',
    `compliance_scope` STRING COMMENT 'The compliance scope attribute capturing relevant data for the vendor certification in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `document_reference` STRING COMMENT 'The document reference attribute capturing relevant data for the vendor certification in the vendor domain.',
    `document_url` STRING COMMENT 'The document url attribute capturing relevant data for the vendor certification in the vendor domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this vendor certification record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this vendor certification record.',
    `expiration_notice_date` DATE COMMENT 'The date value representing expiration notice date for this vendor certification record.',
    `expiration_notice_sent` BOOLEAN COMMENT 'Whether expiration notice was sent',
    `issue_date` DATE COMMENT 'The date value representing issue date for this vendor certification record.',
    `issuing_body` STRING COMMENT 'The issuing body attribute capturing relevant data for the vendor certification in the vendor domain.',
    `jurisdiction` STRING COMMENT 'The jurisdiction attribute capturing relevant data for the vendor certification in the vendor domain.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The last review timestamp attribute capturing relevant data for the vendor certification in the vendor domain.',
    `next_review_due_date` DATE COMMENT 'The date value representing next review due date for this vendor certification record.',
    `notes` STRING COMMENT 'Free-text notes',
    `renewal_due_date` DATE COMMENT 'The date value representing renewal due date for this vendor certification record.',
    `risk_assessment_level` STRING COMMENT 'The risk assessment level attribute capturing relevant data for the vendor certification in the vendor domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the vendor certification in the vendor domain.',
    `status_date` DATE COMMENT 'The date value representing status date for this vendor certification record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_certification_status` STRING COMMENT 'Certification status',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'Certifications and accreditations held by vendors.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` (
    `baa_agreement_id` BIGINT COMMENT 'Unique identifier',
    `parent_baa_agreement_id` BIGINT COMMENT 'Parent BAA for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `agreement_number` STRING COMMENT 'The agreement number attribute capturing relevant data for the baa agreement in the vendor domain.',
    `agreement_type` STRING COMMENT 'Type of BAA',
    `baa_agreement_status` STRING COMMENT 'Agreement status',
    `breach_notification_obligation` BOOLEAN COMMENT 'Whether breach notification is required',
    `breach_notification_period_days` STRING COMMENT 'Breach notification period in days',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `covered_phi_elements` STRING COMMENT 'PHI elements covered',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `execution_date` DATE COMMENT 'The date value representing execution date for this baa agreement record.',
    `last_review_timestamp` TIMESTAMP COMMENT 'The last review timestamp attribute capturing relevant data for the baa agreement in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `permitted_disclosures` STRING COMMENT 'The permitted disclosures attribute capturing relevant data for the baa agreement in the vendor domain.',
    `permitted_uses` STRING COMMENT 'Permitted uses of PHI',
    `review_frequency_days` STRING COMMENT 'Review frequency in days',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the baa agreement in the vendor domain.',
    `security_safeguard_requirements` STRING COMMENT 'The security safeguard requirements attribute capturing relevant data for the baa agreement in the vendor domain.',
    `signatory_email` STRING COMMENT 'The signatory email attribute capturing relevant data for the baa agreement in the vendor domain.',
    `signatory_name` STRING COMMENT 'The descriptive name assigned to the signatory for identification purposes.',
    `signatory_phone` STRING COMMENT 'The signatory phone attribute capturing relevant data for the baa agreement in the vendor domain.',
    `signatory_title` STRING COMMENT 'The signatory title attribute capturing relevant data for the baa agreement in the vendor domain.',
    `termination_notice_period_days` STRING COMMENT 'Termination notice period',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `version` STRING COMMENT 'Agreement version',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_baa_agreement PRIMARY KEY(`baa_agreement_id`)
) COMMENT 'Business Associate Agreements for HIPAA compliance with vendors handling PHI.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`incident` (
    `incident_id` BIGINT COMMENT 'Unique identifier',
    `parent_incident_id` BIGINT COMMENT 'Parent incident for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `affected_member_count` BIGINT COMMENT 'Number of affected members',
    `breach_notification_date` DATE COMMENT 'The date value representing breach notification date for this incident record.',
    `breach_notification_sent` BOOLEAN COMMENT 'Whether breach notification was sent',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `corrective_action_required` STRING COMMENT 'Required corrective actions',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `incident_description` STRING COMMENT 'Description of incident',
    `impacted_functions` STRING COMMENT 'Impacted business functions',
    `incident_date` DATE COMMENT 'Date of incident',
    `incident_number` STRING COMMENT 'The incident number attribute capturing relevant data for the incident in the vendor domain.',
    `incident_status` STRING COMMENT 'The current status indicator for the incident within the workflow.',
    `incident_type` STRING COMMENT 'Type of incident',
    `is_phi_involved` BOOLEAN COMMENT 'Whether PHI is involved',
    `notes` STRING COMMENT 'Free-text notes',
    `regulatory_notification_date` DATE COMMENT 'The date value representing regulatory notification date for this incident record.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Whether regulatory notification is required',
    `reported_by` STRING COMMENT 'Who reported the incident',
    `reporting_channel` STRING COMMENT 'The reporting channel attribute capturing relevant data for the incident in the vendor domain.',
    `resolution_date` DATE COMMENT 'The date value representing resolution date for this incident record.',
    `risk_assessment_score` STRING COMMENT 'The risk assessment score attribute capturing relevant data for the incident in the vendor domain.',
    `root_cause` STRING COMMENT 'Root cause analysis',
    `severity_level` STRING COMMENT 'The severity level attribute capturing relevant data for the incident in the vendor domain.',
    `severity_score` STRING COMMENT 'The severity score attribute capturing relevant data for the incident in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_response_date` DATE COMMENT 'The date value representing vendor response date for this incident record.',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'Vendor-related incidents including security breaches, service failures, and compliance violations.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` (
    `vendor_document_id` BIGINT COMMENT 'Unique identifier',
    `parent_vendor_document_id` BIGINT COMMENT 'Parent document for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `credential_document_id` BIGINT COMMENT 'SSOT reference to credential document',
    `business_owner` STRING COMMENT 'The business owner attribute capturing relevant data for the vendor document in the vendor domain.',
    `checksum` STRING COMMENT 'File checksum',
    `compliance_requirements` STRING COMMENT 'The compliance requirements attribute capturing relevant data for the vendor document in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `vendor_document_description` STRING COMMENT 'Document description',
    `document_number` STRING COMMENT 'The document number attribute capturing relevant data for the vendor document in the vendor domain.',
    `document_type` STRING COMMENT 'Type of document',
    `effective_date` DATE COMMENT 'The date value representing effective date for this vendor document record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this vendor document record.',
    `file_size_bytes` BIGINT COMMENT 'File size in bytes',
    `is_mandatory` BOOLEAN COMMENT 'Whether document is mandatory',
    `notes` STRING COMMENT 'Free-text notes',
    `retention_period_days` STRING COMMENT 'Retention period in days',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the vendor document in the vendor domain.',
    `storage_location_uri` STRING COMMENT 'The storage location uri attribute capturing relevant data for the vendor document in the vendor domain.',
    `title` STRING COMMENT 'Document title',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `uploaded_by` STRING COMMENT 'Uploaded by user',
    `vendor_credential_document_id` BIGINT COMMENT 'FK to SSOT credential document',
    `vendor_document_status` STRING COMMENT 'Document status',
    `version` STRING COMMENT 'Document version',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_document PRIMARY KEY(`vendor_document_id`)
) COMMENT 'Documents associated with vendors including contracts, certifications, and compliance records. References credential.credential_document as SSOT for document management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` (
    `onboarding_id` BIGINT COMMENT 'Unique identifier',
    `parent_onboarding_id` BIGINT COMMENT 'Parent onboarding for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `approval_date` DATE COMMENT 'The date value representing approval date for this onboarding record.',
    `approved_by` STRING COMMENT 'The approved by attribute capturing relevant data for the onboarding in the vendor domain.',
    `business_justification` STRING COMMENT 'The business justification attribute capturing relevant data for the onboarding in the vendor domain.',
    `checklist_baa_executed` BOOLEAN COMMENT 'BAA executed checklist item',
    `checklist_diversity_cert_verified` BOOLEAN COMMENT 'Diversity certification verified',
    `checklist_financial_due_diligence` BOOLEAN COMMENT 'Financial due diligence completed',
    `checklist_insurance_verified` BOOLEAN COMMENT 'Insurance verified checklist item',
    `checklist_security_questionnaire` BOOLEAN COMMENT 'Security questionnaire completed',
    `checklist_w9_received` BOOLEAN COMMENT 'W9 received checklist item',
    `completion_date` DATE COMMENT 'The date value representing completion date for this onboarding record.',
    `compliance_certification_status` STRING COMMENT 'The current status indicator for the compliance certification within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this onboarding record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this onboarding record.',
    `notes` STRING COMMENT 'Free-text notes',
    `onboarding_status` STRING COMMENT 'The current status indicator for the onboarding within the workflow.',
    `outcome` STRING COMMENT 'Outcome of onboarding',
    `request_date` DATE COMMENT 'The date value representing request date for this onboarding record.',
    `request_number` STRING COMMENT 'The request number attribute capturing relevant data for the onboarding in the vendor domain.',
    `requestor_department` STRING COMMENT 'Requesting department',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the onboarding in the vendor domain.',
    `stage` STRING COMMENT 'Current stage',
    `total_onboarding_cost` DECIMAL(18,2) COMMENT 'The total onboarding cost attribute capturing relevant data for the onboarding in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_onboarding PRIMARY KEY(`onboarding_id`)
) COMMENT 'Vendor onboarding workflow tracking from request through completion.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` (
    `rfp_id` BIGINT COMMENT 'Unique identifier',
    `vendor_id` BIGINT COMMENT 'FK to awarded vendor',
    `employee_id` BIGINT COMMENT 'FK to managing employee',
    `parent_rfp_id` BIGINT COMMENT 'Parent RFP for hierarchy',
    `approval_date` DATE COMMENT 'The date value representing approval date for this rfp record.',
    `approval_status` STRING COMMENT 'The current status indicator for the approval within the workflow.',
    `award_amount` DECIMAL(18,2) COMMENT 'The numeric award amount value associated with this rfp record.',
    `award_currency` STRING COMMENT 'The award currency attribute capturing relevant data for the rfp in the vendor domain.',
    `award_date` DATE COMMENT 'The date value representing award date for this rfp record.',
    `award_status` STRING COMMENT 'The current status indicator for the award within the workflow.',
    `compliance_requirements` STRING COMMENT 'The compliance requirements attribute capturing relevant data for the rfp in the vendor domain.',
    `contract_end_estimate` DATE COMMENT 'Estimated contract end',
    `contract_start_estimate` DATE COMMENT 'Estimated contract start',
    `contract_term_months` STRING COMMENT 'Contract term in months',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `rfp_description` STRING COMMENT 'A detailed textual description of the rfp.',
    `estimated_value` DECIMAL(18,2) COMMENT 'The estimated value attribute capturing relevant data for the rfp in the vendor domain.',
    `evaluation_criteria` STRING COMMENT 'The evaluation criteria attribute capturing relevant data for the rfp in the vendor domain.',
    `invited_vendor_count` STRING COMMENT 'Number of invited vendors',
    `issue_date` DATE COMMENT 'The date value representing issue date for this rfp record.',
    `notes` STRING COMMENT 'Free-text notes',
    `received_response_count` STRING COMMENT 'Number of responses received',
    `response_due_date` DATE COMMENT 'The date value representing response due date for this rfp record.',
    `rfp_status` STRING COMMENT 'The current status indicator for the rfp within the workflow.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the rfp in the vendor domain.',
    `solicitation_number` STRING COMMENT 'The solicitation number attribute capturing relevant data for the rfp in the vendor domain.',
    `solicitation_type` STRING COMMENT 'The category or classification type of the solicitation.',
    `spend_category` STRING COMMENT 'The spend category attribute capturing relevant data for the rfp in the vendor domain.',
    `title` STRING COMMENT 'The title attribute capturing relevant data for the rfp in the vendor domain.',
    `updated_by` STRING COMMENT 'Last updater',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the rfp in the vendor domain.',
    CONSTRAINT pk_rfp PRIMARY KEY(`rfp_id`)
) COMMENT 'Requests for Proposal issued to solicit vendor bids.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` (
    `rfp_response_id` BIGINT COMMENT 'Unique identifier',
    `employee_id` BIGINT COMMENT 'FK to evaluating employee',
    `parent_rfp_response_id` BIGINT COMMENT 'Parent response for hierarchy',
    `rfp_id` BIGINT COMMENT 'Unique identifier for the rfp record within the rfp response entity.',
    `vendor_id` BIGINT COMMENT 'FK to responding vendor',
    `commercial_score` DECIMAL(18,2) COMMENT 'The commercial score attribute capturing relevant data for the rfp response in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this rfp response record.',
    `evaluation_comments` STRING COMMENT 'The evaluation comments attribute capturing relevant data for the rfp response in the vendor domain.',
    `evaluation_status` STRING COMMENT 'The current status indicator for the evaluation within the workflow.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'The evaluation timestamp attribute capturing relevant data for the rfp response in the vendor domain.',
    `net_price` DECIMAL(18,2) COMMENT 'The net price attribute capturing relevant data for the rfp response in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `overall_score` DECIMAL(18,2) COMMENT 'Overall evaluation score',
    `proposal_reference_number` STRING COMMENT 'The proposal reference number attribute capturing relevant data for the rfp response in the vendor domain.',
    `response_type` STRING COMMENT 'The category or classification type of the response.',
    `rfp_response_status` STRING COMMENT 'Response status',
    `short_list_flag` BOOLEAN COMMENT 'Whether on short list',
    `submission_timestamp` TIMESTAMP COMMENT 'The submission timestamp attribute capturing relevant data for the rfp response in the vendor domain.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The numeric tax amount value associated with this rfp response record.',
    `technical_score` DECIMAL(18,2) COMMENT 'The technical score attribute capturing relevant data for the rfp response in the vendor domain.',
    `total_price` DECIMAL(18,2) COMMENT 'Total proposed price',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_rfp_response PRIMARY KEY(`rfp_response_id`)
) COMMENT 'Vendor responses to RFPs including pricing and scoring.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` (
    `insurance_id` BIGINT COMMENT 'Unique identifier',
    `parent_insurance_id` BIGINT COMMENT 'Parent insurance for hierarchy',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `additional_insured` BOOLEAN COMMENT 'Whether additional insured',
    `additional_insured_entity` STRING COMMENT 'Additional insured entity name',
    `certificate_document_url` STRING COMMENT 'The certificate document url attribute capturing relevant data for the insurance in the vendor domain.',
    `certificate_issue_date` DATE COMMENT 'The date value representing certificate issue date for this insurance record.',
    `certificate_status` STRING COMMENT 'The current status indicator for the certificate within the workflow.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `coverage_effective_date` DATE COMMENT 'The date value representing coverage effective date for this insurance record.',
    `coverage_expiration_date` DATE COMMENT 'The date value representing coverage expiration date for this insurance record.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'The numeric coverage limit amount value associated with this insurance record.',
    `coverage_limit_currency` STRING COMMENT 'The coverage limit currency attribute capturing relevant data for the insurance in the vendor domain.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The numeric deductible amount value associated with this insurance record.',
    `deductible_currency` DECIMAL(18,2) COMMENT 'The deductible currency attribute capturing relevant data for the insurance in the vendor domain.',
    `insurance_status` STRING COMMENT 'The current status indicator for the insurance within the workflow.',
    `insurance_type` STRING COMMENT 'Type of insurance',
    `insurer_name` STRING COMMENT 'Insurance company name',
    `is_active` BOOLEAN COMMENT 'Whether insurance is active',
    `minimum_coverage_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum coverage threshold',
    `minimum_coverage_threshold_currency` STRING COMMENT 'The minimum coverage threshold currency attribute capturing relevant data for the insurance in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `policy_number` STRING COMMENT 'The policy number attribute capturing relevant data for the insurance in the vendor domain.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'The risk assessment score attribute capturing relevant data for the insurance in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_insurance PRIMARY KEY(`insurance_id`)
) COMMENT 'Insurance policies and certificates held by vendors.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` (
    `vendor_dispute_id` BIGINT COMMENT 'Unique identifier',
    `case_id` BIGINT COMMENT 'FK to appeal case',
    `parent_vendor_dispute_id` BIGINT COMMENT 'Parent dispute for hierarchy',
    `purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `header_id` BIGINT COMMENT 'FK to claim header',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `contract_dispute_id` BIGINT COMMENT 'SSOT reference to contract dispute',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `dispute_category` STRING COMMENT 'The dispute category attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `dispute_description` STRING COMMENT 'Description of dispute',
    `dispute_number` STRING COMMENT 'The dispute number attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `dispute_type` STRING COMMENT 'Type of dispute',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The numeric disputed amount value associated with this vendor dispute record.',
    `escalation_flag` BOOLEAN COMMENT 'Whether escalated',
    `escalation_reason` STRING COMMENT 'The escalation reason attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `internal_recommendation` STRING COMMENT 'The internal recommendation attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `open_timestamp` TIMESTAMP COMMENT 'When dispute was opened',
    `priority` STRING COMMENT 'Priority level',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `resolution_timestamp` TIMESTAMP COMMENT 'When dispute was resolved',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the vendor dispute in the vendor domain.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The numeric settlement amount value associated with this vendor dispute record.',
    `supporting_evidence_refs` STRING COMMENT 'Supporting evidence references',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_contract_dispute_id` BIGINT COMMENT 'FK to SSOT contract dispute',
    `vendor_dispute_status` STRING COMMENT 'Dispute status',
    `vendor_position` STRING COMMENT 'Vendor position on dispute',
    `vendor_response_timestamp` TIMESTAMP COMMENT 'When vendor responded',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the vendor dispute in the vendor domain.',
    CONSTRAINT pk_vendor_dispute PRIMARY KEY(`vendor_dispute_id`)
) COMMENT 'Disputes with vendors including billing, contract, and service disputes. References contract.contract_dispute as SSOT for dispute management.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Unique identifier',
    `parent_category_spend_category_id` BIGINT COMMENT 'FK to parent category',
    `parent_spend_category_id` BIGINT COMMENT 'Parent category for hierarchy',
    `applicable_vendor_type` STRING COMMENT 'Applicable vendor types',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The numeric budget allocation amount value associated with this spend category record.',
    `category_code` STRING COMMENT 'A standardized code representing the category classification.',
    `category_level` STRING COMMENT 'Level in hierarchy',
    `category_name` STRING COMMENT 'The descriptive name assigned to the category for identification purposes.',
    `category_owner` STRING COMMENT 'The category owner attribute capturing relevant data for the spend category in the vendor domain.',
    `compliance_requirements` STRING COMMENT 'The compliance requirements attribute capturing relevant data for the spend category in the vendor domain.',
    `cost_center_code` DECIMAL(18,2) COMMENT 'A standardized code representing the cost center classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `spend_category_description` STRING COMMENT 'Category description',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `external_reference_code` STRING COMMENT 'A standardized code representing the external reference classification.',
    `gl_account_code` STRING COMMENT 'A standardized code representing the gl account classification.',
    `hierarchy_path` STRING COMMENT 'Full hierarchy path',
    `last_review_timestamp` TIMESTAMP COMMENT 'The last review timestamp attribute capturing relevant data for the spend category in the vendor domain.',
    `notes` STRING COMMENT 'Free-text notes',
    `preferred_sourcing_strategy` DECIMAL(18,2) COMMENT 'The preferred sourcing strategy attribute capturing relevant data for the spend category in the vendor domain.',
    `review_frequency_days` STRING COMMENT 'Review frequency in days',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the spend category in the vendor domain.',
    `spend_category_status` STRING COMMENT 'Category status',
    `unspsc_code` STRING COMMENT 'A standardized code representing the unspsc classification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Hierarchical classification of vendor spend categories.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` (
    `relationship_id` BIGINT COMMENT 'Unique identifier',
    `parent_relationship_id` BIGINT COMMENT 'Parent relationship for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `annual_spend_amount` DECIMAL(18,2) COMMENT 'The numeric annual spend amount value associated with this relationship record.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `end_date` DATE COMMENT 'Relationship end date',
    `is_preferred_vendor` BOOLEAN COMMENT 'Whether preferred vendor',
    `is_strategic_partner` BOOLEAN COMMENT 'Whether strategic partner',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this relationship record.',
    `next_review_date` DATE COMMENT 'The date value representing next review date for this relationship record.',
    `notes` STRING COMMENT 'Free-text notes',
    `owner` STRING COMMENT 'Relationship owner',
    `relationship_status` STRING COMMENT 'The current status indicator for the relationship within the workflow.',
    `relationship_type` STRING COMMENT 'Type of relationship',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the relationship in the vendor domain.',
    `satisfaction_score` DECIMAL(18,2) COMMENT 'The satisfaction score attribute capturing relevant data for the relationship in the vendor domain.',
    `start_date` DATE COMMENT 'Relationship start date',
    `strategic_importance` DECIMAL(18,2) COMMENT 'Strategic importance level',
    `tier` STRING COMMENT 'Relationship tier',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_relationship PRIMARY KEY(`relationship_id`)
) COMMENT 'Vendor relationship records tracking the nature and status of vendor partnerships.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` (
    `vendor_audit_id` BIGINT COMMENT 'Unique identifier',
    `parent_vendor_audit_id` BIGINT COMMENT 'Parent audit for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `audit_end_date` DATE COMMENT 'The date value representing audit end date for this vendor audit record.',
    `audit_number` STRING COMMENT 'The audit number attribute capturing relevant data for the vendor audit in the vendor domain.',
    `audit_scope` STRING COMMENT 'Scope of audit',
    `audit_start_date` DATE COMMENT 'The date value representing audit start date for this vendor audit record.',
    `audit_type` STRING COMMENT 'Type of audit',
    `auditor_name` STRING COMMENT 'The descriptive name assigned to the auditor for identification purposes.',
    `auditor_organization` STRING COMMENT 'The auditor organization attribute capturing relevant data for the vendor audit in the vendor domain.',
    `compliance_score` DECIMAL(18,2) COMMENT 'The compliance score attribute capturing relevant data for the vendor audit in the vendor domain.',
    `corrective_action_due_date` DATE COMMENT 'The date value representing corrective action due date for this vendor audit record.',
    `corrective_action_required` BOOLEAN COMMENT 'Whether corrective action is required',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `critical_finding_count` STRING COMMENT 'Number of critical findings',
    `finding_count` STRING COMMENT 'Number of findings',
    `next_audit_due_date` DATE COMMENT 'The date value representing next audit due date for this vendor audit record.',
    `notes` STRING COMMENT 'Free-text notes',
    `overall_rating` STRING COMMENT 'Overall audit rating',
    `report_date` DATE COMMENT 'The date value representing report date for this vendor audit record.',
    `risk_score` DECIMAL(18,2) COMMENT 'The risk score attribute capturing relevant data for the vendor audit in the vendor domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_audit_status` STRING COMMENT 'Audit status',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_audit PRIMARY KEY(`vendor_audit_id`)
) COMMENT 'Audit records for vendor compliance and performance audits.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` (
    `vendor_lifecycle_event_id` BIGINT COMMENT 'Unique identifier',
    `contract_lifecycle_event_id` BIGINT COMMENT 'Foreign key reference to SSOT contract.contract_lifecycle_event for lifecycle_event concept',
    `parent_vendor_lifecycle_event_id` BIGINT COMMENT 'Parent event for hierarchy',
    `vendor_contract_id` BIGINT COMMENT 'FK to vendor contract',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `approved_by` STRING COMMENT 'Who approved the event',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `effective_date` DATE COMMENT 'Effective date of change',
    `event_description` STRING COMMENT 'Description of event',
    `event_subtype` STRING COMMENT 'Subtype of event',
    `event_timestamp` TIMESTAMP COMMENT 'The event timestamp attribute capturing relevant data for the vendor lifecycle event in the vendor domain.',
    `event_type` STRING COMMENT 'Type of lifecycle event',
    `initiated_by` STRING COMMENT 'Who initiated the event',
    `is_reversible` BOOLEAN COMMENT 'Whether event is reversible',
    `new_status` STRING COMMENT 'The current status indicator for the new within the workflow.',
    `notes` STRING COMMENT 'Free-text notes',
    `notification_date` DATE COMMENT 'The date value representing notification date for this vendor lifecycle event record.',
    `notification_sent_flag` BOOLEAN COMMENT 'Whether notification was sent',
    `previous_status` STRING COMMENT 'The current status indicator for the previous within the workflow.',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification.',
    `reason_description` STRING COMMENT 'A detailed textual description of the reason.',
    `requires_notification` BOOLEAN COMMENT 'Whether notification is required',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `vendor_lifecycle_event_status` STRING COMMENT 'Event status',
    `vreq_validated` BOOLEAN COMMENT 'VREQ validation marker',
    CONSTRAINT pk_vendor_lifecycle_event PRIMARY KEY(`vendor_lifecycle_event_id`)
) COMMENT 'Lifecycle events tracking vendor status changes over time. References contract/credential/member lifecycle_event patterns.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ADD CONSTRAINT `fk_vendor_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_parent_vendor_contact_id` FOREIGN KEY (`parent_vendor_contact_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ADD CONSTRAINT `fk_vendor_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ADD CONSTRAINT `fk_vendor_vendor_address_parent_vendor_address_id` FOREIGN KEY (`parent_vendor_address_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_address`(`vendor_address_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ADD CONSTRAINT `fk_vendor_vendor_address_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_parent_vendor_contract_id` FOREIGN KEY (`parent_vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ADD CONSTRAINT `fk_vendor_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ADD CONSTRAINT `fk_vendor_contract_term_parent_contract_term_id` FOREIGN KEY (`parent_contract_term_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`contract_term`(`contract_term_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ADD CONSTRAINT `fk_vendor_contract_term_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_parent_contract_amendment_id` FOREIGN KEY (`parent_contract_amendment_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`contract_amendment`(`contract_amendment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ADD CONSTRAINT `fk_vendor_contract_amendment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_parent_spend_id` FOREIGN KEY (`parent_spend_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`spend`(`spend_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ADD CONSTRAINT `fk_vendor_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_parent_purchase_order_id` FOREIGN KEY (`parent_purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` ADD CONSTRAINT `fk_vendor_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_parent_po_line_id` FOREIGN KEY (`parent_po_line_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` ADD CONSTRAINT `fk_vendor_po_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_parent_goods_receipt_id` FOREIGN KEY (`parent_goods_receipt_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ADD CONSTRAINT `fk_vendor_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_parent_invoice_id` FOREIGN KEY (`parent_invoice_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ADD CONSTRAINT `fk_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_parent_performance_id` FOREIGN KEY (`parent_performance_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`performance`(`performance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ADD CONSTRAINT `fk_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ADD CONSTRAINT `fk_vendor_sla_event_parent_sla_event_id` FOREIGN KEY (`parent_sla_event_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`sla_event`(`sla_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ADD CONSTRAINT `fk_vendor_sla_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_parent_risk_assessment_id` FOREIGN KEY (`parent_risk_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` ADD CONSTRAINT `fk_vendor_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ADD CONSTRAINT `fk_vendor_vendor_certification_parent_vendor_certification_id` FOREIGN KEY (`parent_vendor_certification_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_certification`(`vendor_certification_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ADD CONSTRAINT `fk_vendor_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ADD CONSTRAINT `fk_vendor_baa_agreement_parent_baa_agreement_id` FOREIGN KEY (`parent_baa_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`baa_agreement`(`baa_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ADD CONSTRAINT `fk_vendor_baa_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_parent_incident_id` FOREIGN KEY (`parent_incident_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`incident`(`incident_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` ADD CONSTRAINT `fk_vendor_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_parent_vendor_document_id` FOREIGN KEY (`parent_vendor_document_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` ADD CONSTRAINT `fk_vendor_vendor_document_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_parent_onboarding_id` FOREIGN KEY (`parent_onboarding_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`onboarding`(`onboarding_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` ADD CONSTRAINT `fk_vendor_onboarding_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ADD CONSTRAINT `fk_vendor_rfp_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ADD CONSTRAINT `fk_vendor_rfp_parent_rfp_id` FOREIGN KEY (`parent_rfp_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp`(`rfp_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_parent_rfp_response_id` FOREIGN KEY (`parent_rfp_response_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp_response`(`rfp_response_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_rfp_id` FOREIGN KEY (`rfp_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`rfp`(`rfp_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ADD CONSTRAINT `fk_vendor_rfp_response_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ADD CONSTRAINT `fk_vendor_insurance_parent_insurance_id` FOREIGN KEY (`parent_insurance_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`insurance`(`insurance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ADD CONSTRAINT `fk_vendor_insurance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_parent_vendor_dispute_id` FOREIGN KEY (`parent_vendor_dispute_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_dispute`(`vendor_dispute_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` ADD CONSTRAINT `fk_vendor_vendor_dispute_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ADD CONSTRAINT `fk_vendor_spend_category_parent_category_spend_category_id` FOREIGN KEY (`parent_category_spend_category_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ADD CONSTRAINT `fk_vendor_spend_category_parent_spend_category_id` FOREIGN KEY (`parent_spend_category_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_parent_relationship_id` FOREIGN KEY (`parent_relationship_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`relationship`(`relationship_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` ADD CONSTRAINT `fk_vendor_relationship_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_parent_vendor_audit_id` FOREIGN KEY (`parent_vendor_audit_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ADD CONSTRAINT `fk_vendor_vendor_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_parent_vendor_lifecycle_event_id` FOREIGN KEY (`parent_vendor_lifecycle_event_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event`(`vendor_lifecycle_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` ADD CONSTRAINT `fk_vendor_vendor_lifecycle_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_health_insurance_v1`.`vendor`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`vendor` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`vendor` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `incorporation_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` SET TAGS ('dbx_fhir_resource' = 'ContactPoint');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` SET TAGS ('dbx_fhir_resource' = 'Address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `parent_vendor_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_description` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_address` ALTER COLUMN `vendor_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('dbx_fhir_resource' = 'Contract');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_term` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`purchase_order` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`po_line` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` SET TAGS ('dbx_preserved' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`sla_event` ALTER COLUMN `sla_metric_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`risk_assessment` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` SET TAGS ('dbx_hipaa' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`baa_agreement` ALTER COLUMN `signatory_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`incident` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_document` SET TAGS ('dbx_ssot_ref' = 'credential.credential_document');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`onboarding` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`rfp_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`insurance` ALTER COLUMN `insurer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_dispute` SET TAGS ('dbx_ssot_ref' = 'contract.contract_dispute');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('dbx_subdomain' = 'procurement_spend');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`spend_category` ALTER COLUMN `category_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`relationship` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('dbx_subdomain' = 'performance_oversight');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('dbx_domain' = 'vendor');
ALTER TABLE `vibe_health_insurance_v1`.`vendor`.`vendor_lifecycle_event` SET TAGS ('dbx_ssot_pattern' = 'lifecycle_event');
