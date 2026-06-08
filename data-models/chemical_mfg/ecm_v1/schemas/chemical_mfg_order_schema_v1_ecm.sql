-- Schema for Domain: order | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`order` COMMENT 'Manages the full customer order lifecycle: quotes (RFQ), sales orders, order confirmations, delivery scheduling, fulfillment status, and order-to-cash workflows. Captures customer requirements, technical specifications, special handling instructions, MOQ enforcement, and COA/COC attachment to shipments. Integrates with SAP SD and Oracle Transportation Management for end-to-end order visibility.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`order`.`inquiry` (
    `inquiry_id` BIGINT COMMENT 'Primary key for inquiry',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who submitted the inquiry.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the inquiry record.',
    `inquiry_employee_id` BIGINT COMMENT 'Identifier of the sales representative assigned to the inquiry.',
    `inquiry_last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the inquiry record.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: R&D Project Inquiry Tracking records which research project an RFQ originates from for feasibility analysis.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier to which the inquiry is sent.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price amounts.',
    `delivery_date_required` DATE COMMENT 'Date by which the customer expects the product to be delivered.',
    `delivery_location` STRING COMMENT 'Address where the product is to be delivered.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount the customer expects or negotiates on the gross price.',
    `gross_price_amount` DECIMAL(18,2) COMMENT 'Requested gross price before any discounts or adjustments.',
    `inquiry_status` STRING COMMENT 'Current processing state of the inquiry.. Valid values are `draft|submitted|approved|rejected|closed`',
    `inquiry_timestamp` TIMESTAMP COMMENT 'Date and time when the inquiry was initially created/submitted.',
    `internal_notes` STRING COMMENT 'Internal comments or observations added by sales or support staff.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the inquiry contains confidential or proprietary information.',
    `net_price_amount` DECIMAL(18,2) COMMENT 'Final price after discounts, representing the amount the customer expects to pay.',
    `priority_flag` STRING COMMENT 'Priority level assigned to the inquiry for internal processing.. Valid values are `low|medium|high|critical`',
    `product_cas_number` STRING COMMENT 'Standard CAS number identifying the chemical substance requested.',
    `product_code` STRING COMMENT 'Internal product identifier or SKU requested in the inquiry.',
    `product_description` STRING COMMENT 'Free‑text description of the product specifications requested.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Amount of product the customer wishes to purchase.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the inquiry record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inquiry record.',
    `response_due_date` DATE COMMENT 'Date by which the supplier is expected to respond to the inquiry.',
    `rfq_number` STRING COMMENT 'External reference number assigned to the RFQ for customer and internal tracking.',
    `source_channel` STRING COMMENT 'Channel through which the inquiry was received.. Valid values are `email|phone|portal|sales_rep`',
    `special_handling_instructions` STRING COMMENT 'Any special handling, safety, or packaging instructions supplied by the customer.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount based on the net price, if applicable.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the transaction is tax‑exempt.',
    `technical_spec_attachment_reference` BIGINT COMMENT 'Reference to a stored technical specification attachment.',
    `unit_of_measure` STRING COMMENT 'Unit in which the requested quantity is expressed.. Valid values are `kg|lb|L|gal|ton|pcs`',
    `validity_end_date` DATE COMMENT 'Date until which the quoted prices remain valid.',
    `validity_start_date` DATE COMMENT 'Date from which the quoted prices are valid.',
    CONSTRAINT pk_inquiry PRIMARY KEY(`inquiry_id`)
) COMMENT 'Request for Quotation record capturing a customers formal inquiry for pricing, availability, and technical specifications before a sales order is placed. Stores RFQ number, customer account, inquiry date, validity period, requested products and quantities, target price, delivery requirements, technical specification attachments, and assigned sales representative. Represents the pre-order commercial negotiation stage in the order-to-cash workflow. Maps to SAP SD Inquiry (VA11) and Quotation (VA21) transactions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`order`.`quotation` (
    `quotation_id` BIGINT COMMENT 'Unique identifier for the quotation record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer receiving the quotation.',
    `site_id` BIGINT COMMENT 'Reference to the billing address for invoicing.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the quotation.',
    `quotation_created_by_employee_id` BIGINT COMMENT 'Identifier of the employee who created the quotation.',
    `quotation_employee_id` BIGINT COMMENT 'Identifier of the sales representative responsible for the quotation.',
    `quotation_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified the quotation.',
    `quotation_site_id` BIGINT COMMENT 'Reference to the shipping address for delivery.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project‑Based Quotation Management ties custom quotes to the R&D project that defines the specification.',
    `approval_status` STRING COMMENT 'Approval state of the quotation within internal review process.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the quotation was approved.',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents (e.g., COA, COC) are attached to the quotation.',
    `competitor_quote_reference` STRING COMMENT 'Reference identifier for a competitors quote, if captured for win/loss analysis.',
    `conversion_status` STRING COMMENT 'Indicates whether the quotation has been converted to a sales order.. Valid values are `not_converted|converted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quotation record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts in the quotation.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Overall discount percentage applied to the quotation.',
    `ehs_review_required` BOOLEAN COMMENT 'Indicates whether an Environmental Health and Safety review is required for the quoted products.',
    `incoterms` STRING COMMENT 'Delivery terms governing the shipment of goods. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — 7 candidates stripped; promote to reference product]',
    `inquiry_number` STRING COMMENT 'Reference number of the original customer inquiry (RFQ) that led to this quotation.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the quotation contains confidential pricing or terms.',
    `is_price_locked` BOOLEAN COMMENT 'Indicates whether the quoted prices are locked for the validity period.',
    `lead_time_days` STRING COMMENT 'Committed lead time in days from order to delivery.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered for the quoted products.',
    `notes` STRING COMMENT 'Additional free-text notes entered by sales or support staff.',
    `payment_terms` STRING COMMENT 'Payment terms agreed for the quotation (e.g., Net 30).',
    `pricing_method` STRING COMMENT 'Method used to calculate quoted prices.. Valid values are `list|custom|contract`',
    `quotation_date` DATE COMMENT 'Date when the quotation was issued to the customer.',
    `quotation_number` STRING COMMENT 'Unique business identifier for the quotation as used in SAP Sales and Distribution.',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the quotation.. Valid values are `draft|negotiation|accepted|rejected|expired|converted`',
    `quote_version` STRING COMMENT 'Version number of the quotation for revisions.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the quotation complies with relevant chemical regulations (e.g., REACH, TSCA).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the quotation.',
    `technical_specifications` STRING COMMENT 'Free-text description of technical grade specifications for the quoted products.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount applied to the quotation.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Total amount before discounts, taxes, and fees.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount after discounts and before taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the quotation.',
    `valid_until` DATE COMMENT 'End date of the quotations validity period.',
    `win_loss_reason` STRING COMMENT 'Reason recorded for winning or losing the quotation opportunity.',
    `valid_from` DATE COMMENT 'Start date of the quotations validity period.',
    CONSTRAINT pk_quotation PRIMARY KEY(`quotation_id`)
) COMMENT 'Commercial negotiation record spanning the full pre-order lifecycle from initial customer inquiry (RFQ) through formal price quotation, negotiation, and acceptance or expiry. Captures inquiry/quotation number, stage (inquiry_received, qualification, draft_quote, formal_quote, negotiation, accepted, expired, rejected, converted_to_order), customer account, inquiry date, validity period, requested and quoted products with quantities, target and quoted prices, discount structure, payment terms, incoterms, MOQ, lead time commitment, technical grade specifications, delivery requirements, technical specification attachments, assigned sales representative, competitor quote reference, win/loss reason, and acceptance status. Tracks conversion rate from inquiry to quotation to confirmed sales order. Maps to SAP SD Inquiry (VA11) and Quotation (VA21) transactions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'Unique identifier for the blanket order agreement.',
    `employee_id` BIGINT COMMENT 'Identifier of the customer owning the blanket order.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier providing the product.',
    `agreement_type` STRING COMMENT 'Category of the blanket order agreement defining pricing model.. Valid values are `volume|price|service|mix`',
    `approval_date` DATE COMMENT 'Date when the blanket order was approved.',
    `approved_by` STRING COMMENT 'Identifier of the user who approved the blanket order.',
    `blanket_order_status` STRING COMMENT 'Current lifecycle status of the blanket order.. Valid values are `draft|active|suspended|terminated|expired`',
    `call_off_frequency` STRING COMMENT 'Expected frequency of call-off orders under the agreement.. Valid values are `monthly|quarterly|semiannual|annual`',
    `compliance_requirements` STRING COMMENT 'Regulatory compliance requirements applicable to the blanket order (e.g., REACH, GHS).',
    `contract_number` STRING COMMENT 'External contract number assigned to the blanket order.',
    `contract_version` STRING COMMENT 'Version identifier of the blanket order contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket order record was created.',
    `currency_code` STRING COMMENT 'Currency of the price per unit.. Valid values are `USD|EUR|JPY|GBP|CAD|AUD`',
    `effective_from` DATE COMMENT 'Date when the blanket order becomes effective.',
    `effective_until` DATE COMMENT 'Date when the blanket order expires or ends.',
    `is_confidential` BOOLEAN COMMENT 'Indicates if the terms of the blanket order are confidential.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the blanket order grants exclusive supply rights.',
    `minimum_call_off_qty` DECIMAL(18,2) COMMENT 'Minimum quantity required for each call-off.',
    `notes` STRING COMMENT 'Additional free-text notes regarding the blanket order.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price agreed for the product grade.',
    `pricing_tier` STRING COMMENT 'Pricing tier applicable based on volume thresholds.. Valid values are `tier1|tier2|tier3|tier4`',
    `product_grade` STRING COMMENT 'Specific grade or specification of the chemical product covered.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate amount applied when threshold met.',
    `rebate_threshold_volume` DECIMAL(18,2) COMMENT 'Volume threshold at which rebate applies.',
    `regulatory_approval_number` STRING COMMENT 'Approval number from regulatory body for the product under this agreement.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Remaining volume available for call-offs.',
    `renewal_option` STRING COMMENT 'Renewal option for the blanket order after expiry.. Valid values are `auto|manual|none`',
    `special_handling_instructions` STRING COMMENT 'Any special handling or safety instructions for the product.',
    `termination_reason` STRING COMMENT 'Reason for termination if the agreement is terminated.',
    `total_call_offs` STRING COMMENT 'Number of call-off orders released to date.',
    `total_committed_volume` DECIMAL(18,2) COMMENT 'Total volume of product committed under the blanket order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the blanket order record.',
    `volume_uom` STRING COMMENT 'Unit of measure for the committed volume.. Valid values are `kg|lb|ton|gal|L`',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term volume commitment agreement between Chemical Mfg and a customer defining contracted volumes, pricing tiers, and delivery terms over a contract period (typically 12-36 months). Captures contract dates, total committed volume, product grades, agreed pricing tiers, volume rebate thresholds, call-off frequency, minimum call-off quantity, and remaining open quantity. Individual sales orders (call-offs) are released against this agreement. Common in chemical B2B for supply security and volume-based pricing. Maps to SAP SD scheduling agreements and contracts.';

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `chemical_mfg_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` SET TAGS ('dbx_subdomain' = 'order_core');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Potential Supplier Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `delivery_date_required` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Address');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `delivery_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `delivery_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount Applied to Target Price');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `gross_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Target Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes for Inquiry');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Inquiry Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `net_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Target Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Priority Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `priority_flag` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `product_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Requested Product Code');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Requested Product Description');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation Number (RFQ No.)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Source Channel');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'email|phone|portal|sales_rep');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount on Target Price');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `technical_spec_attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Document Identifier');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure for Quantity');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|L|gal|ton|pcs');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`inquiry` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` SET TAGS ('dbx_subdomain' = 'order_core');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `site_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `site_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_site_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quotation Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Presence Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `competitor_quote_reference` SET TAGS ('dbx_business_glossary_term' = 'Competitor Quote Reference');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Conversion Status');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|converted');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quotation Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `ehs_review_required` SET TAGS ('dbx_business_glossary_term' = 'EHS Review Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `inquiry_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry (RFQ) Number');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Quotation Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `is_price_locked` SET TAGS ('dbx_business_glossary_term' = 'Price Locked Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quotation Notes');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'list|custom|contract');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_value_regex' = 'draft|negotiation|accepted|rejected|expired|converted');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quotation Version Number');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Quotation Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Details');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Quotation Discount Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Quotation Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Quotation Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quotation Last Updated Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `valid_until` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid Until Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `win_loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Win/Loss Reason');
ALTER TABLE `chemical_mfg_ecm`.`order`.`quotation` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Quotation Valid From Date');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'order_core');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID (COI)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SI)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AT)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume|price|service|mix');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (AD)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (AS)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `call_off_frequency` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Frequency (COF)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `call_off_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semiannual|annual');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (CR)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version (CV)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CAD|AUD');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Agreement Flag (CAF)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag (EAF)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_call_off_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Call-Off Quantity (MCQ)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (PPU)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier (PT)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `product_grade` SET TAGS ('dbx_business_glossary_term' = 'Product Grade (PG)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount (RA)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `rebate_threshold_volume` SET TAGS ('dbx_business_glossary_term' = 'Rebate Threshold Volume (RTV)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number (RAN)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity (RQ)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RO)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions (SHI)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TR)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `total_call_offs` SET TAGS ('dbx_business_glossary_term' = 'Total Call-Offs (TCO)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `total_committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Volume (TCV)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`order`.`blanket_order` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'kg|lb|ton|gal|L');
