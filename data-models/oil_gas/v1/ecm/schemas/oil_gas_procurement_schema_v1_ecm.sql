-- Schema for Domain: procurement | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`procurement` COMMENT 'Manages the full source-to-pay lifecycle including vendor qualification, sourcing, contract administration, purchase orders, EPC and FEED contractor management, materials management, and spend analytics for drilling services, oilfield equipment, refinery catalysts, and maintenance materials. Supports CAPEX project procurement, rig contracts, AFE budget control, and service agreements. Integrates with SAP MM/PS modules aligned with COPAS material procurement standards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Vendors specialized in supplying specific petroleum products (crude traders, refined product suppliers, NGL marketers). Enables vendor segmentation, sourcing strategy, and supplier performance trackin',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the vendor is currently active and available for new procurement activities.',
    `address_line1` STRING COMMENT 'First line of the vendors registered business address, typically containing street number and street name.',
    `address_line2` STRING COMMENT 'Second line of the vendors registered business address for additional address details such as suite, building, or floor number.',
    `bank_account_number` STRING COMMENT 'Vendors bank account number for electronic funds transfer and payment processing.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendor maintains their primary business account for payment receipt.',
    `bank_routing_number` STRING COMMENT 'Bank routing number, SWIFT code, or IBAN used for international and domestic wire transfers to the vendor.',
    `blacklist_date` DATE COMMENT 'Date when the vendor was added to the blacklist.',
    `blacklist_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the vendor is blacklisted or prohibited from doing business due to compliance violations, safety incidents, or contractual breaches.',
    `blacklist_reason` STRING COMMENT 'Detailed explanation of why the vendor was blacklisted, including reference to specific incidents, violations, or regulatory actions.',
    `business_category` STRING COMMENT 'Detailed business category describing the vendors primary goods or services: drilling services, oilfield equipment, refinery chemicals, catalysts, MRO (Maintenance Repair and Operations) materials, EPC services, FEED services, transportation, logistics, or other specialized categories. [ENUM-REF-CANDIDATE: drilling_services|oilfield_equipment|refinery_chemicals|catalysts|mro_materials|epc_services|feed_services|transportation|logistics|consulting|inspection|testing|environmental_services — promote to reference product]',
    `city` STRING COMMENT 'City or municipality of the vendors registered business address.',
    `copas_classification` STRING COMMENT 'COPAS-compliant vendor classification code used for joint interest billing and AFE (Authorization for Expenditure) cost allocation in joint ventures.',
    `country` STRING COMMENT 'Three-letter ISO country code for the vendors registered business address.. Valid values are `^[A-Z]{3}$`',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the country where the vendor is legally incorporated or registered.. Valid values are `^[A-Z]{3}$`',
    `created_date` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the procurement system.',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number assigned by Dun & Bradstreet for vendor identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `hse_rating` STRING COMMENT 'HSE (Health Safety and Environment) performance rating based on incident history, safety audits, and compliance with OSHA, EPA, and API standards.. Valid values are `excellent|good|satisfactory|needs_improvement|poor`',
    `insurance_certificate_number` STRING COMMENT 'Certificate number for the vendors liability insurance policy, required for contractor and service provider qualification.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the vendors current liability insurance coverage.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when the vendor record was last updated or modified.',
    `last_purchase_order_date` DATE COMMENT 'Date of the most recent purchase order issued to this vendor, used for vendor activity tracking and performance analysis.',
    `minority_owned_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the vendor is certified as a minority-owned business enterprise for diversity and inclusion reporting.',
    `payment_currency` STRING COMMENT 'Three-letter ISO currency code representing the preferred or default currency for payments to this vendor.. Valid values are `^[A-Z]{3}$`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor, such as Net 30, Net 60, 2/10 Net 30, or other custom payment schedules.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendors registered business address.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the vendor has preferred status based on performance, pricing, or strategic partnership agreements.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for procurement communications, purchase order confirmations, and vendor correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the vendor organization for procurement and operational communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact, including country and area codes.',
    `qualification_date` DATE COMMENT 'Date when the vendor was last qualified or approved for procurement activities.',
    `qualification_expiry_date` DATE COMMENT 'Date when the vendors current qualification status expires and requires renewal or reassessment.',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor based on HSE (Health Safety and Environment) compliance, financial stability, technical capability, and past performance assessments.. Valid values are `qualified|pending|disqualified|under_review|expired`',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number issued by the vendors country of incorporation. Used for legal verification and compliance.',
    `small_business_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the vendor qualifies as a small business under applicable government or industry definitions.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the vendors registered business address.',
    `tax_identification_number` STRING COMMENT 'Tax identification number or employer identification number (EIN) used for tax reporting and compliance in the vendors jurisdiction.',
    `vendor_code` STRING COMMENT 'External business identifier or vendor number used in procurement systems and purchase orders. Maps to SAP vendor master number.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor, supplier, or service provider as registered in their country of incorporation.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on their primary business relationship: contractor (drilling, construction), supplier (equipment, materials), service provider (maintenance, logistics), EPC (Engineering Procurement and Construction) firm, FEED (Front-End Engineering Design) contractor, or consultant.. Valid values are `contractor|supplier|service_provider|epc_firm|feed_contractor|consultant`',
    `website_url` STRING COMMENT 'Vendors official website URL for reference and additional company information.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all vendors, suppliers, and service providers in the oil and gas procurement ecosystem, including drilling contractors, oilfield equipment suppliers, EPC firms, FEED contractors, catalyst suppliers, and maintenance material vendors. Captures vendor legal name, registration number, country of incorporation, vendor type (contractor, supplier, service provider), business category (drilling services, oilfield equipment, refinery chemicals, MRO), tax identification, DUNS number, SAP vendor master number, payment terms, currency, bank details, preferred contact, qualification status, blacklist flag, COPAS-compliant vendor classification, and active/inactive status. Serves as the SSOT for vendor identity within the procurement domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification entity.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Vendor qualification scoped to specific petroleum product categories (crude supply, refined products, petrochemicals). Ensures vendors meet quality, compliance, and technical requirements for specific',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor entity being qualified. Links to the vendor master record in the procurement system.',
    `api_certification_numbers` STRING COMMENT 'Comma-separated list of American Petroleum Institute (API) certification numbers held by the vendor. API certifications validate compliance with industry standards for equipment, materials, and services used in oil and gas operations. Examples include API Spec Q1, API Spec 6A, API Spec 5CT.',
    `approval_authority` STRING COMMENT 'Name and title of the authorized individual who granted final approval for the vendor qualification. Typically a Procurement Manager, Supply Chain Director, or Vice President depending on qualification scope and value limit.',
    `approval_date` DATE COMMENT 'Date on which the approval authority officially approved the vendor qualification. May differ from qualification date if approval is backdated to evaluation completion.',
    `approval_scope` STRING COMMENT 'Geographic or organizational scope of the vendor qualification. Global indicates qualification for all Oil Gas operations worldwide, regional indicates qualification for specific geographic regions (e.g., North America, Middle East), asset-specific indicates qualification for specific facilities or fields, and project-specific indicates qualification for a single Capital Expenditure (CAPEX) project.. Valid values are `global|regional|asset-specific|project-specific`',
    `approved_assets` STRING COMMENT 'Comma-separated list of specific asset identifiers (facility codes, field names, or refinery identifiers) where the vendor is qualified to provide goods or services. Applicable when approval scope is asset-specific.',
    `approved_regions` STRING COMMENT 'Comma-separated list of geographic regions or countries where the vendor is qualified to operate. Uses three-letter ISO country codes (e.g., USA, SAU, NOR, BRA). Applicable when approval scope is regional or asset-specific.',
    `approved_value_limit_usd` DECIMAL(18,2) COMMENT 'Maximum cumulative contract value in United States Dollars (USD) that the vendor is authorized to supply under this qualification. Used for Authorization for Expenditure (AFE) and Capital Expenditure (CAPEX) budget control. Null indicates no monetary limit.',
    `avl_status` STRING COMMENT 'Current status of the vendor on the Approved Vendor List (AVL) for the qualified commodity category. Active indicates vendor is eligible for Request for Quotation (RFQ) issuance and direct awards, inactive indicates qualification expired or vendor requested removal, suspended indicates temporary hold due to performance or compliance issues, and pending removal indicates disqualification process underway.. Valid values are `active|inactive|suspended|pending removal`',
    `background_check_completed_flag` BOOLEAN COMMENT 'Indicates whether background checks (corporate due diligence, sanctions screening, anti-corruption checks, beneficial ownership verification) have been completed for the vendor. True indicates background check completed and cleared, False indicates background check not completed or issues identified.',
    `commodity_category_code` STRING COMMENT 'Standardized commodity classification code aligned with SAP Material Management (MM) material groups or UNSPSC codes. Defines the specific product or service category the vendor is qualified to supply.. Valid values are `^[A-Z0-9]{4,10}$`',
    `commodity_category_name` STRING COMMENT 'Human-readable name of the commodity category corresponding to the commodity category code. Examples include Drilling Services, Wellhead Equipment, Refinery Catalysts, Piping and Valves, or Instrumentation and Controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was first created in the system. Used for audit trail and data lineage tracking.',
    `disqualification_reason` STRING COMMENT 'Detailed explanation for vendor disqualification or qualification rejection. May include technical deficiencies, financial instability, Health Safety and Environment (HSE) violations, ethical breaches, contract performance failures, or regulatory non-compliance. Null if qualification is approved.',
    `evaluator_email` STRING COMMENT 'Email address of the evaluator who conducted the vendor qualification assessment. Used for follow-up questions and audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `evaluator_name` STRING COMMENT 'Full name of the procurement or technical specialist who conducted the vendor qualification evaluation. Provides accountability and contact for qualification questions.',
    `expiry_date` DATE COMMENT 'Date on which the vendor qualification expires and requires renewal or re-qualification. Null indicates indefinite qualification subject to periodic review.',
    `financial_evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors financial stability and creditworthiness assessment. Typically scored on a 0-100 scale based on financial statements, credit rating, liquidity ratios, debt-to-equity ratio, and payment history. Ensures vendor can fulfill long-term contracts.',
    `hse_evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors Health Safety and Environment (HSE) performance and compliance assessment. Typically scored on a 0-100 scale based on Total Recordable Incident Rate (TRIR), Lost Time Injury Frequency (LTIF), environmental compliance record, HSE management systems, and safety culture. Critical for high-risk operations such as drilling and Simultaneous Operations (SIMOPS).',
    `insurance_coverage_verified_flag` BOOLEAN COMMENT 'Indicates whether the vendors insurance coverage (general liability, professional indemnity, workers compensation, pollution liability) has been verified and meets Oil Gas requirements. True indicates insurance verified and adequate, False indicates insurance not verified or inadequate.',
    `insurance_expiry_date` DATE COMMENT 'Expiry date of the vendors insurance coverage. Used to trigger insurance renewal verification and prevent engagement of vendors with lapsed coverage.',
    `iso_14001_certification_number` STRING COMMENT 'Certificate number for ISO 14001 Environmental Management System certification. Validates vendors environmental management processes and compliance capability.',
    `iso_45001_certification_number` STRING COMMENT 'Certificate number for ISO 45001 Occupational Health and Safety Management System certification. Validates vendors occupational health and safety management processes.',
    `iso_9001_certification_number` STRING COMMENT 'Certificate number for ISO 9001 Quality Management System certification. Validates vendors quality management processes and continuous improvement capability.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last modified the vendor qualification record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was last updated. Used for audit trail, change tracking, and data freshness assessment.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification assessment of the vendor. Used to trigger re-qualification workflows and ensure ongoing vendor capability and compliance.',
    `overall_qualification_score` DECIMAL(18,2) COMMENT 'Composite weighted score combining technical, financial, and Health Safety and Environment (HSE) evaluation scores. Used for vendor ranking and Approved Vendor List (AVL) prioritization. Typically scored on a 0-100 scale.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor has preferred vendor status for the qualified commodity category. Preferred vendors receive priority consideration in Request for Quotation (RFQ) processes and may have negotiated pricing agreements. True indicates preferred status, False indicates standard qualified vendor.',
    `qualification_date` DATE COMMENT 'Date on which the vendor qualification was officially approved and became effective. Represents the start of the qualification validity period.',
    `qualification_reference_number` STRING COMMENT 'Business identifier for the qualification record, used for external communication and tracking. Format: VQ-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^VQ-[0-9]{8}$`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification. Pending indicates submission received, under review indicates active evaluation, approved indicates full qualification granted, conditionally approved requires specific conditions to be met, rejected indicates disqualification, expired indicates qualification period ended, suspended indicates temporary hold, and withdrawn indicates vendor or company cancelled the qualification. [ENUM-REF-CANDIDATE: pending|under review|approved|conditionally approved|rejected|expired|suspended|withdrawn — 8 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Type of qualification assessment being performed. Pre-qualification is initial screening, full qualification is comprehensive assessment, re-qualification is periodic renewal, conditional qualification requires remediation, and expedited qualification is fast-track for urgent needs.. Valid values are `pre-qualification|full qualification|re-qualification|conditional qualification|expedited qualification`',
    `reinstatement_date` DATE COMMENT 'Date on which a previously suspended vendor qualification was reinstated to active status after remediation of suspension issues. Null if qualification has never been suspended or has not been reinstated.',
    `sanctions_screening_status` STRING COMMENT 'Result of sanctions screening against Office of Foreign Assets Control (OFAC), United Nations (UN), European Union (EU), and other sanctions lists. Cleared indicates no matches found, flagged indicates potential match requiring investigation, pending indicates screening in progress, and not screened indicates screening not yet performed.. Valid values are `cleared|flagged|pending|not screened`',
    `scope_of_supply` STRING COMMENT 'Detailed description of the goods or services the vendor is qualified to provide. May include drilling services, Engineering Procurement and Construction (EPC), Front-End Engineering Design (FEED), catalyst supply, Maintenance Repair and Operations (MRO) materials, oilfield equipment, refinery equipment, petrochemical feedstocks, or specialized technical services.',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether the vendor is the sole qualified source for the specified commodity category, typically due to proprietary technology, intellectual property rights, or unique capability. Sole source vendors may be exempt from competitive bidding requirements. True indicates sole source, False indicates competitive market.',
    `strategic_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor is designated as a strategic partner with long-term relationship agreements, joint development programs, or integrated supply chain arrangements. Strategic vendors typically support critical operations or provide unique capabilities. True indicates strategic status, False indicates transactional relationship.',
    `suspension_date` DATE COMMENT 'Date on which the vendor qualification was suspended. Null if qualification has never been suspended.',
    `suspension_reason` STRING COMMENT 'Detailed explanation for temporary suspension of vendor qualification. May include ongoing investigation of Health Safety and Environment (HSE) incident, quality non-conformance, contract dispute, financial concerns, or regulatory enforcement action. Null if qualification is not suspended.',
    `technical_evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score representing the vendors technical capability assessment. Typically scored on a 0-100 scale based on technical expertise, equipment capability, process maturity, quality systems, and past performance. Used to rank vendors for Request for Quotation (RFQ) issuance.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the vendor qualification record. Used for audit trail and accountability.',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Qualification and pre-qualification assessment record for vendors seeking approval to supply goods or services to Oil Gas, including Approved Vendor List (AVL) status and commodity-level approval scope. Captures qualification reference number, vendor ID, qualification type (pre-qualification, full qualification, re-qualification), scope of supply (drilling services, EPC, catalyst supply, MRO), commodity category code, approved value limit (USD), qualification date, expiry date, qualification status (pending, approved, conditionally approved, rejected, expired, suspended), technical evaluation score, financial evaluation score, HSE evaluation score, QHSE certification references (ISO 9001, ISO 14001, ISO 45001), API certification numbers, evaluator name, approval authority, approval scope (global, regional, asset-specific), preferred vendor flag, strategic vendor flag, sole source flag, and disqualification reason. Supports COPAS and API vendor qualification standards and governs vendor selection eligibility for RFQ issuance and direct award decisions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material master catalog.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Material master records for petroleum products enable procurement of crude grades, refined products, NGLs for operations or trading. Links commodity product specifications to procurement system for so',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on consumption value and criticality. A items are high-value or critical, B items are moderate, C items are low-value or non-critical. Drives inventory control policies and procurement strategies.. Valid values are `A|B|C`',
    `api_specification` STRING COMMENT 'API specification number or standard that the material conforms to. Ensures materials meet industry technical requirements for oil and gas operations.',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory management and procurement. Standard units include barrels for crude oil, gallons for refined products, pounds or kilograms for chemicals and catalysts, and each for equipment. [ENUM-REF-CANDIDATE: EA|LB|KG|GAL|L|BBL|FT|M|TON|MT — 10 candidates stripped; promote to reference product]',
    `batch_management_flag` BOOLEAN COMMENT 'Indicates whether the material requires batch or lot number tracking for quality control, traceability, and recall management. Typically required for chemicals, catalysts, and consumables.',
    `copas_material_classification` STRING COMMENT 'COPAS standard material classification code used for joint venture accounting, authorization for expenditure tracking, and joint interest billing. Ensures consistent material categorization across joint operating agreements.. Valid values are `^[A-Z0-9]{4,8}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the material is manufactured or produced. Required for customs declarations, trade compliance, and tariff classification.. Valid values are `^[A-Z]{3}$`',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for master data governance and audit trails.',
    `critical_material_flag` BOOLEAN COMMENT 'Indicates whether the material is critical for operations with limited alternative sources or long lead times. Critical materials receive priority in procurement planning and inventory management.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the standard cost. Typically USD for U.S. operations but may vary for international subsidiaries.. Valid values are `^[A-Z]{3}$`',
    `h2s_service_flag` BOOLEAN COMMENT 'Indicates whether the material is rated for use in hydrogen sulfide service environments. Critical for equipment and materials used in sour gas production and processing.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under EPA, OSHA, or PHMSA regulations. Triggers special handling, storage, and transportation requirements.',
    `height_m` DECIMAL(18,2) COMMENT 'Height dimension of the material in meters. Used for storage space planning and transportation logistics.',
    `hts_code` STRING COMMENT 'Harmonized tariff schedule code for customs classification and duty calculation. Required for international procurement and import/export compliance.. Valid values are `^[0-9]{6,10}$`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming materials must undergo quality inspection before being released to inventory. Ensures materials meet specifications before use in operations.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Used for master data governance, change tracking, and audit trails.',
    `lead_time_days` STRING COMMENT 'Average number of days from purchase order creation to material receipt. Used for materials requirements planning and inventory replenishment calculations.',
    `length_m` DECIMAL(18,2) COMMENT 'Length dimension of the material in meters. Used for storage space planning and transportation logistics for tubular goods, pipe, and long equipment.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer or producer of the material. Used for vendor qualification, quality assurance, and sourcing decisions.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer part number for the material. Used for cross-referencing, warranty claims, and ensuring correct replacement parts are procured.',
    `material_category` STRING COMMENT 'High-level business category for the material aligned with oil and gas operational domains. Used for spend analytics, sourcing strategies, and procurement reporting. [ENUM-REF-CANDIDATE: drilling_services|oilfield_equipment|refinery_catalyst|maintenance_material|rig_consumable|safety_equipment|chemical_additive|tubular_goods — 8 candidates stripped; promote to reference product]',
    `material_description` STRING COMMENT 'Full textual description of the material including technical specifications, grade, and distinguishing characteristics. Used for procurement requisitions and purchase orders.',
    `material_group` STRING COMMENT 'Material group code used for grouping materials with similar characteristics for procurement analytics, spend analysis, and vendor sourcing strategies. Aligns with commodity codes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Externally-known unique material number assigned by the enterprise resource planning system. This is the business identifier used across procurement, inventory, and supply chain processes.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record. Controls whether the material can be procured, issued, or used in operations.. Valid values are `active|inactive|blocked|obsolete|pending_approval`',
    `material_type` STRING COMMENT 'Classification of the material by procurement and inventory management category. Determines procurement processes, valuation methods, and inventory control procedures. [ENUM-REF-CANDIDATE: raw_material|spare_part|chemical|catalyst|consumable|capital_equipment|service|trading_good — 8 candidates stripped; promote to reference product]',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from vendors in the base unit of measure. Drives procurement planning and inventory optimization.',
    `norm_flag` BOOLEAN COMMENT 'Indicates whether the material contains naturally occurring radioactive material commonly found in oil and gas production equipment and waste streams. Requires special disposal and handling procedures.',
    `plant_specific_status` STRING COMMENT 'Material status at the plant or facility level, which may differ from the enterprise-wide status. Allows local control of material availability for specific locations.',
    `procurement_type` STRING COMMENT 'Indicates whether the material is procured externally from vendors, manufactured in-house, or both. Drives procurement planning and sourcing strategies.. Valid values are `external|in_house|both`',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for sourcing this material. Used for workload distribution and procurement accountability.. Valid values are `^[A-Z0-9]{3,4}$`',
    `serial_number_profile` STRING COMMENT 'Indicates whether serial number tracking is required, optional, or not applicable for this material. Mandatory for capital equipment and high-value assets requiring individual traceability.. Valid values are `none|mandatory|optional`',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before it expires or degrades. Critical for chemicals, catalysts, and consumables with limited storage life.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the material in the base currency used for inventory valuation, cost accounting, and variance analysis. Updated periodically based on procurement history and market conditions.',
    `storage_conditions` STRING COMMENT 'Required environmental conditions for safe storage of the material including temperature range, humidity controls, ventilation requirements, and segregation rules.',
    `unspsc_code` STRING COMMENT 'United Nations standard product and service classification code. Used for spend analytics, supplier management, and procurement category management.. Valid values are `^[0-9]{8}$`',
    `valuation_class` STRING COMMENT 'Accounting valuation class that determines the general ledger accounts for inventory postings, cost of goods sold, and material consumption. Links material master to financial accounting.. Valid values are `^[0-9]{4}$`',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of one base unit of the material in kilograms. Used for transportation planning, freight cost calculation, and logistics optimization.',
    `width_m` DECIMAL(18,2) COMMENT 'Width dimension of the material in meters. Used for storage space planning and transportation logistics.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Master catalog of all materials, equipment, spare parts, chemicals, and consumables procured by Oil Gas. Aligned with SAP MM Material Master. Captures material number, material description, material type (raw material, spare part, chemical, catalyst, consumable, capital equipment), material group, base unit of measure, procurement type (external, in-house), valuation class, hazardous material flag, NORM flag, H2S service flag, API material specification, manufacturer part number, shelf life, storage conditions, weight, dimensions, country of origin, and COPAS material classification code. Serves as the SSOT for material identity across procurement and supply chain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key for the purchase requisition entity.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Requisitions for petroleum products (crude, refined products, NGLs) are common in oil & gas for fuel, feedstock, or trading inventory. Enables procurement planning and sourcing strategy for commodity ',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the recommended or assigned vendor in the supplier master. Links requisition to qualified supplier base and contract agreements.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Requisitions for capital projects require WBS tracking for AFE alignment, project cost authorization, and proper capital vs. operational classification. Standard project-based procurement in oil & gas',
    `account_assignment_category` STRING COMMENT 'Type of financial account assignment for the requisition expenditure. Determines whether costs are charged to OPEX (cost center), CAPEX (project/asset), or revenue-generating activities.. Valid values are `cost_center|project|asset|sales_order|network`',
    `afe_number` STRING COMMENT 'AFE document number authorizing capital expenditure for drilling, completion, facilities, or major projects. Critical for CAPEX budget control and joint venture cost allocation.. Valid values are `^AFE-[0-9]{8}$`',
    `approval_date` DATE COMMENT 'Date when the purchase requisition received final approval and was released for conversion to purchase order. Critical for procurement cycle time analytics and AFE timeline tracking.',
    `approver_name` STRING COMMENT 'Full name of the manager or authorized signatory who approved the purchase requisition. Establishes approval authority and audit trail per SOX controls.',
    `asset_number` STRING COMMENT 'Fixed asset number for capital equipment purchases that will be capitalized and depreciated. Links requisition to asset lifecycle management and DD&A calculations.. Valid values are `^ASSET-[0-9]{10}$`',
    `contract_number` STRING COMMENT 'Reference to existing procurement contract, frame agreement, or master service agreement under which this requisition will be fulfilled. Ensures contract compliance and pricing adherence.. Valid values are `^CNT-[0-9]{10}$`',
    `conversion_date` DATE COMMENT 'Date when the approved purchase requisition was converted into a purchase order. Measures procurement cycle time from requisition to order placement.',
    `cost_center` STRING COMMENT 'Cost center code to which the requisition expenditure will be charged. Links procurement spend to organizational budget responsibility.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase requisition record was first created in the procurement system. Audit trail for record creation per SOX compliance requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value. Supports multi-currency procurement for international operations and joint ventures.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical location, facility, rig site, or warehouse where the materials or equipment must be delivered. Critical for logistics planning and freight cost estimation.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition calculated as quantity multiplied by estimated unit price. Represents budget impact for approval workflow and AFE tracking.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of measure for the requested materials or services. Used for budget planning and AFE cost estimation prior to formal quotation.',
    `gl_account` STRING COMMENT 'General ledger account code to which the procurement expense will be posted. Aligns with chart of accounts and financial reporting requirements per GAAP/IFRS.. Valid values are `^[0-9]{10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the purchase requisition record. Tracks change history and supports audit trail for procurement workflow modifications.',
    `material_description` STRING COMMENT 'Detailed textual description of the materials, equipment, or services being requested. Includes specifications, technical requirements, and scope of work for services.',
    `material_group` STRING COMMENT 'Procurement category or commodity code grouping similar materials or services. Used for spend analytics, sourcing strategy, and supplier segmentation.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, technical specifications, delivery requirements, or special handling instructions relevant to the procurement request.',
    `plant_code` STRING COMMENT 'SAP plant code representing the receiving facility, refinery, production platform, or operational site. Links requisition to asset location and inventory management.. Valid values are `^[A-Z0-9]{4}$`',
    `priority` STRING COMMENT 'Business priority level indicating urgency of the procurement need. Emergency and critical priorities trigger expedited approval workflows and sourcing for operational continuity.. Valid values are `routine|urgent|emergency|critical`',
    `procurement_category` STRING COMMENT 'High-level procurement category specific to oil and gas operations. Aligns with industry spend taxonomy for drilling, production, refining, and project execution. [ENUM-REF-CANDIDATE: drilling_services|oilfield_equipment|refinery_catalyst|maintenance_materials|epc_contractor|feed_contractor|rig_contract|well_services|pipeline_materials|safety_equipment — 10 candidates stripped; promote to reference product]',
    `project_number` STRING COMMENT 'Project identifier for capital projects, drilling campaigns, or facility construction. Links requisition to broader project portfolio management.. Valid values are `^PROJ-[0-9]{8}$`',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated when the approved requisition is converted to a formal purchase order. Tracks progression from requisition to committed procurement.. Valid values are `^PO-[0-9]{10}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of materials, equipment units, or service hours being requested. Precision supports fractional quantities for bulk materials and chemicals.',
    `rejection_reason` STRING COMMENT 'Textual explanation provided by approver when requisition is rejected. Captures business rationale for denial such as budget constraints, specification issues, or alternative sourcing decisions.',
    `requesting_department` STRING COMMENT 'Name or code of the operational department or business unit that originated the purchase requisition. Used for spend analytics and budget tracking.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, equipment, or services must be delivered to the requesting location. Critical for operational planning and AFE schedule adherence.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created and submitted into the procurement system. Principal business event timestamp for the requisition lifecycle.',
    `requisition_number` STRING COMMENT 'Externally visible business identifier for the purchase requisition. Unique document number used across procurement workflows and AFE tracking.. Valid values are `^PR-[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the procurement workflow. Tracks progression from creation through approval to purchase order conversion. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|cancelled|converted_to_po|closed — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on the nature of goods or services being requested. Determines procurement workflow and approval routing.. Valid values are `material|service|capital_equipment|rental|subcontract|consumable`',
    `requisitioner_email` STRING COMMENT 'Email address of the requisitioner for procurement workflow notifications and supplier communication. Classified as restricted PII per GDPR and privacy regulations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requisitioner_name` STRING COMMENT 'Full name of the employee or contractor who created and submitted the purchase requisition. Provides accountability and contact point for clarifications.',
    `source_of_supply` STRING COMMENT 'Recommended supplier, vendor, or contractor name for sourcing the requested materials or services. May reference preferred supplier agreements or frame contracts.',
    `storage_location` STRING COMMENT 'Storage location code within the plant where materials will be received and stored. Supports warehouse management and inventory control.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_code` STRING COMMENT 'Tax jurisdiction code determining applicable sales tax, VAT, or GST rates for the procurement transaction. Supports multi-jurisdictional tax compliance.. Valid values are `^[A-Z0-9]{2}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requisitioned quantity. Includes oil and gas industry-specific units such as barrels (BBL), thousand cubic feet (MCF), and standard commercial units. [ENUM-REF-CANDIDATE: EA|BBL|MCF|TON|GAL|LB|FT|M|HR|DAY|LOT|KG|L — 13 candidates stripped; promote to reference product]',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request document initiating the procurement process for materials, equipment, or services required by operational departments. Captures requisition number, requisition date, requesting department, cost center, WBS element (linked to AFE), project number, material or service description, quantity, unit of measure, required delivery date, estimated value (USD), currency, priority (routine, urgent, emergency), requisition type (material, service, capital equipment), approval status (draft, pending approval, approved, rejected), approver name, approval date, and source of supply recommendation. Integrates with SAP MM PR workflow and AFE budget control.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: RFQs for CAPEX procurement are issued against AFE budgets. This enables validation that estimated contract value is within AFE approved budget during sourcing stage, and provides traceability from AFE',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom the RFQ was awarded. Links to the vendor master record for contract execution and payment processing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: RFQ issuance requires employee accountability for procurement compliance and audit trails. Issuing_buyer_name denormalizes employee data. Critical for vendor selection governance and SOX compliance in',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: RFQs for petroleum product supply (crude tenders, refined product bids, NGL purchase agreements). Links bidding process to product specifications, quality requirements, and pricing benchmarks for comm',
    `purchase_requisition_id` BIGINT COMMENT 'Identifier of the originating purchase requisition that triggered this RFQ. Links sourcing activity back to operational demand.',
    `award_date` DATE COMMENT 'Date the RFQ was officially awarded to the winning vendor. Marks the transition from evaluation to contract execution.',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Actual contract value awarded to the winning vendor. May differ from estimated value based on competitive bidding results and negotiations.',
    `bid_bond_percentage` DECIMAL(18,2) COMMENT 'Percentage of the bid amount that must be secured as a bid bond (typically 2-10%). Protects buyer if winning vendor fails to execute the contract.',
    `bid_bond_required_flag` BOOLEAN COMMENT 'Indicates whether vendors must submit a bid bond or bid security to participate. True if bid bond is mandatory, False if not required.',
    `bid_opening_date` TIMESTAMP COMMENT 'Date and time when submitted bids are officially opened and recorded. For sealed bids, this is when envelopes are opened in the presence of authorized personnel.',
    `bid_submission_deadline` TIMESTAMP COMMENT 'Date and time by which vendors must submit their quotations. Bids received after this timestamp are typically rejected unless extension is granted.',
    `bids_received_count` STRING COMMENT 'Number of valid bids received by the submission deadline. Used to assess market response and competition level.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled without award (e.g., project deferred, insufficient bids, budget constraints, scope change, vendor non-responsiveness).',
    `commercial_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to commercial (price) evaluation criteria in best-value evaluation method. Technical weight is the complement (100 minus this value).',
    `commodity_category` STRING COMMENT 'High-level classification of the goods or services being procured (e.g., drilling services, oilfield equipment, refinery catalysts, maintenance materials, EPC services, FEED engineering, rig contracts, well completion services, production chemicals, pipeline materials).',
    `contract_duration_months` STRING COMMENT 'Expected duration of the resulting contract in months. Used for multi-year service agreements and framework contracts.',
    `contract_type` STRING COMMENT 'Pricing structure for the resulting contract: lump sum (fixed price), unit price (rate per unit), cost plus (reimbursable with fee), time and materials (hourly rates), or framework (call-off agreement).. Valid values are `lump_sum|unit_price|cost_plus|time_and_materials|framework`',
    `cost_center` STRING COMMENT 'Accounting cost center to which operating expenses (OPEX) for this procurement will be charged. Used for lease operating expense (LOE) tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this RFQ record was first created in the procurement system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the RFQ and bid amounts (e.g., USD, EUR, GBP). All financial values in this RFQ are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical location where goods or services must be delivered (e.g., rig site, refinery, warehouse, field office). May include GPS coordinates for remote locations.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Internal estimate of the total contract value for budgeting and approval purposes. Used to determine authorization levels per Authorization for Expenditure (AFE) thresholds.',
    `evaluation_completion_date` DATE COMMENT 'Date when the technical and commercial evaluation of all bids was completed and award recommendation was finalized.',
    `evaluation_method` STRING COMMENT 'Method used to evaluate and select the winning bid: lowest price (price only), best value (weighted technical and commercial), BAFO (best and final offer negotiation), technical merit (technical score primary), or life cycle cost (total cost of ownership).. Valid values are `lowest_price|best_value|bafo|technical_merit|life_cycle_cost`',
    `hse_requirements` STRING COMMENT 'Mandatory health, safety, and environmental compliance requirements for vendors (e.g., ISNetworld qualification, OSHA compliance, H2S training, confined space certification, environmental permits).',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for delivery, insurance, and risk transfer (e.g., FOB, CIF, DDP). Governs logistics and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage requirements for vendors (e.g., general liability, workers compensation, professional indemnity, pollution liability). Includes coverage amounts and certificate of insurance requirements.',
    `issuing_organization` STRING COMMENT 'Business unit, operating company, or joint venture that issued the RFQ and will be the contracting party (e.g., Upstream Division, Refining Operations, Midstream JV).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this RFQ record was last updated. Tracks the most recent change to any field for audit and data quality purposes.',
    `payment_terms` STRING COMMENT 'Standard payment terms for the contract (e.g., Net 30, Net 60, progress payments, milestone-based). Defines when vendor invoices are due for payment.',
    `project_code` STRING COMMENT 'Capital project or work breakdown structure (WBS) code to which this procurement is charged. Links RFQ to CAPEX project tracking and AFE budget control.',
    `rfq_date` DATE COMMENT 'Date the RFQ was officially issued to vendors. Marks the start of the competitive bidding period.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ document issued to vendors. Externally visible reference number used in vendor communications and contract documentation.. Valid values are `^RFQ-[0-9]{6,10}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ: draft (being prepared), issued (sent to vendors), clarification (vendor questions period), evaluation (bids under review), awarded (vendor selected), closed (completed), or cancelled (terminated without award). [ENUM-REF-CANDIDATE: draft|issued|clarification|evaluation|awarded|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `rfq_type` STRING COMMENT 'Classification of the RFQ procurement method: open tender (public competitive bidding), selective tender (pre-qualified vendors only), sole source (single vendor negotiation), emergency (expedited procurement), framework agreement (multi-year call-off), or two-stage (technical then commercial evaluation).. Valid values are `open_tender|selective_tender|sole_source|emergency|framework_agreement|two_stage`',
    `scope_description` STRING COMMENT 'Detailed narrative description of the materials, equipment, or services being requested. Includes technical specifications, quantities, delivery requirements, and performance criteria.',
    `technical_specification_reference` STRING COMMENT 'Reference to the detailed technical specification document or standard that governs the procurement (e.g., API 5L for line pipe, API 6A for wellhead equipment, ASME B31.3 for process piping).',
    `technical_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to technical evaluation criteria in best-value evaluation method. Commercial weight is the complement (100 minus this value).',
    `vendors_invited_count` STRING COMMENT 'Number of qualified vendors invited to submit bids for this RFQ. Indicates the breadth of market engagement.',
    `warranty_period_months` STRING COMMENT 'Duration of the warranty or guarantee period for equipment or services in months. Defines vendor liability for defects and performance issues.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation or tender document issued to qualified vendors for competitive bidding on materials, equipment, or services. Captures RFQ number, RFQ date, RFQ type (open tender, selective tender, sole source, emergency), commodity category, scope of supply description, bid submission deadline, bid bond requirement, technical and commercial evaluation criteria and weightings, incoterms, delivery location, currency, estimated contract value, issuing buyer name, number of vendors invited, number of bids received, evaluation method (lowest price, best value, BAFO), award recommendation date, awarded vendor reference, award value, and RFQ status (draft, issued, evaluation, awarded, closed, cancelled). Links to the originating purchase requisition. Serves as the single entity for managing the full competitive sourcing lifecycle from market engagement through vendor award for drilling services, EPC contracts, and oilfield equipment.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` (
    `vendor_bid_id` BIGINT COMMENT 'Unique identifier for the vendor bid record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Vendor bids are evaluated against AFE budget constraints. This enables bid evaluation to consider budget availability, and provides traceability from AFE to bid evaluation to contract award. Currently',
    `contract_id` BIGINT COMMENT 'Reference to the resulting contract or purchase order created if this bid was awarded. Links bid to execution phase.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Bid evaluation accountability tracks employee responsibility for technical and commercial scoring. Evaluated_by is text but represents employee. Essential for procurement fairness, audit trails, and v',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Vendor bids quote specific petroleum products with quality specs, pricing benchmarks, and delivery terms. Essential for bid evaluation, quality compliance verification, and contract award decisions in',
    `project_id` BIGINT COMMENT 'Reference to the capital project, drilling program, or FEED/EPC project that this procurement supports. Links bid to project cost tracking.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ or tender that this bid responds to. Links the bid to the originating procurement request.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier submitting this bid. Identifies the counterparty in the bidding process.',
    `approval_date` DATE COMMENT 'Date when the bid evaluation and award recommendation was formally approved by the authorized signatory.',
    `approved_by` STRING COMMENT 'Name or identifier of the approving authority who authorized the bid award decision. Required for SOX compliance and audit trail.',
    `award_date` DATE COMMENT 'Date when the bid was awarded and the vendor was selected. Null if bid was not awarded.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond or security provided by the vendor, typically a percentage of the bid value.',
    `bid_bond_reference` STRING COMMENT 'Reference number or identifier for the bid bond or bid security submitted by the vendor to guarantee bid validity. Required for large CAPEX projects and EPC contracts.',
    `bid_document_url` STRING COMMENT 'URL or file path to the complete bid submission document package stored in the document management system.',
    `bid_reference_number` STRING COMMENT 'External business identifier for the bid as assigned by the vendor or procurement system. Used for tracking and communication.',
    `bid_status` STRING COMMENT 'Current lifecycle status of the vendor bid in the evaluation and award process. [ENUM-REF-CANDIDATE: received|under_evaluation|shortlisted|awarded|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `combined_evaluation_score` DECIMAL(18,2) COMMENT 'Weighted combined score from technical and commercial evaluations. Used for final vendor selection and award recommendation.',
    `commercial_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during commercial evaluation based on pricing competitiveness, payment terms, delivery lead time, and total cost of ownership.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was first created in the procurement system. Used for audit trail and process timeline tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted prices and total value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Number of days from purchase order issuance to delivery, as committed by the vendor. Critical for project scheduling and rig mobilization planning.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluation team regarding the bids strengths, weaknesses, risks, and recommendations.',
    `exceptions_and_deviations` STRING COMMENT 'List of exceptions, deviations, or clarifications the vendor has taken from the RFQ specifications or terms. Must be evaluated for acceptability.',
    `hse_plan_reference` STRING COMMENT 'Reference to the HSE plan document submitted by the vendor outlining safety procedures, environmental controls, and compliance measures. Critical for drilling and EPC contractor selection.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between vendor and buyer (e.g., FOB, CIF, DDP). Critical for logistics cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was last updated. Tracks changes during evaluation and status updates.',
    `material_group_code` STRING COMMENT 'SAP material group or commodity code classifying the type of goods or services being procured (e.g., drilling services, refinery catalysts, oilfield equipment).',
    `payment_terms` STRING COMMENT 'Payment terms offered by the vendor, such as net 30, net 60, advance payment percentage, or milestone-based payment schedule. Impacts cash flow and commercial evaluation.',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement type to support spend analytics and category management. [ENUM-REF-CANDIDATE: drilling_services|oilfield_equipment|refinery_catalysts|maintenance_materials|epc_contractor|feed_contractor|rig_contract|professional_services|logistics|other — 10 candidates stripped; promote to reference product]',
    `quoted_total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the bid including all line items, before taxes and adjustments. Used for budget comparison and commercial scoring.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Price per unit quoted by the vendor for the material, service, or equipment being procured. Basis for commercial evaluation.',
    `rejection_reason` STRING COMMENT 'Reason code or description explaining why the bid was rejected (e.g., non-compliant, pricing too high, late submission, failed technical evaluation).',
    `submission_date` DATE COMMENT 'Date when the vendor submitted the bid response to the procurement team. Key event timestamp for bid evaluation timeline.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vendor submitted the bid, used for deadline compliance verification and audit trail.',
    `technical_compliance_statement` STRING COMMENT 'Vendors declaration of compliance with technical specifications, API standards, and engineering requirements outlined in the RFQ. Used for technical evaluation.',
    `technical_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during technical evaluation based on compliance with specifications, vendor qualifications, past performance, and technical capability. Used in weighted bid evaluation.',
    `validity_end_date` DATE COMMENT 'Date until which the bid pricing and terms remain valid. After this date, vendor may revise or withdraw the bid.',
    `validity_start_date` DATE COMMENT 'Date from which the bid pricing and terms become valid and binding on the vendor.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor contact for bid-related communication and clarifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted the bid and serves as the primary point of contact for clarifications.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor contact for urgent bid clarifications and negotiations.',
    CONSTRAINT pk_vendor_bid PRIMARY KEY(`vendor_bid_id`)
) COMMENT 'Vendor quotation or bid response submitted in response to an RFQ or tender. Captures bid reference number, RFQ reference, vendor ID, bid submission date, bid validity period, quoted unit price, quoted total value, currency, delivery lead time, payment terms offered, technical compliance statement, exceptions and deviations, bid bond reference, HSE plan reference, bid status (received, under evaluation, shortlisted, awarded, rejected), technical score, commercial score, and combined evaluation score. Supports bid tabulation and vendor selection for drilling rig contracts, EPC awards, and material supply agreements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key for the purchase order entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Purchase orders for CAPEX procurement are charged to AFE budgets. This is critical for AFE budget control, commitment tracking, and COPAS-compliant cost accounting. Currently has afe_number (STRING) w',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO buyer accountability is fundamental to procurement authorization chains and segregation of duties. Buyer_name denormalizes employee. Required for AFE cost tracking, JV partner reporting, and intern',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Purchase orders can be issued as call-offs against master procurement contracts or framework agreements. Currently has contract_reference (STRING) which should be replaced with proper FK to enable con',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Purchase orders are created from purchase requisitions in standard procurement flow. The PO should reference its originating requisition. Currently has requisition_number (STRING) which should be repl',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor or supplier to whom the purchase order is issued. Links to the vendor master data entity.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: POs for drilling programs and capital projects must link to WBS for project cost tracking, AFE budget control, and asset capitalization. Critical for project accounting and financial reporting.',
    `approval_authority` STRING COMMENT 'Name or identifier of the manager or executive who authorized the purchase order based on delegation of authority limits.',
    `approval_date` DATE COMMENT 'Date the purchase order was formally approved and released for transmission to the vendor.',
    `cancellation_reason` STRING COMMENT 'Business reason or justification for cancelling the purchase order before fulfillment. Used for procurement process improvement and vendor performance analysis.',
    `closed_date` DATE COMMENT 'Date the purchase order was administratively closed after all deliveries and invoices were completed. Marks the end of the PO lifecycle.',
    `company_code` STRING COMMENT 'Financial accounting organizational unit representing the legal entity for which the purchase order is issued. Used for financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Organizational cost center to which OPEX purchase order costs are allocated. Used for departmental budgeting and expense tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order transaction. Defines the currency in which amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full address where materials or equipment are to be delivered. May differ from plant address for field locations or offshore platforms.',
    `gl_account` STRING COMMENT 'General ledger account number to which purchase order costs are posted. Defines the financial statement line item for expense or asset capitalization.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining the responsibilities of buyers and sellers for delivery, insurance, and risk transfer. Aligned with ICC Incoterms 2020 standards. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `material_group` STRING COMMENT 'Classification code grouping similar materials or services for procurement category management. Examples include drilling equipment, refinery catalysts, maintenance materials, oilfield services.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the purchase order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was last modified. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or comments related to the purchase order. May include delivery instructions, quality requirements, or vendor-specific notes.',
    `payment_terms` STRING COMMENT 'Contractual payment conditions specifying due dates, discounts, and payment schedules. Examples include Net 30, Net 60, 2/10 Net 30.',
    `plant` STRING COMMENT 'Physical location or facility where materials or services will be received. May represent a refinery, production platform, drilling site, or warehouse.',
    `po_date` DATE COMMENT 'Date the purchase order was issued to the vendor. Represents the principal business event timestamp for the transaction and establishes the contractual commitment date.',
    `po_number` STRING COMMENT 'Externally visible purchase order document number used for vendor communication and tracking. Unique business identifier aligned with SAP MM document numbering.. Valid values are `^[A-Z0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Draft indicates pending approval, open indicates active and awaiting delivery, partially delivered indicates some line items received, fully delivered indicates all items received, closed indicates administratively completed, cancelled indicates voided before fulfillment.. Valid values are `draft|open|partially_delivered|fully_delivered|closed|cancelled`',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy and contract structure. Standard for one-time purchases, blanket for recurring releases, framework for multi-year agreements, emergency for urgent requirements, subcontract for EPC/FEED contractor work, service for non-material procurement.. Valid values are `standard|blanket|framework|emergency|subcontract|service`',
    `procurement_category` STRING COMMENT 'High-level spend category for strategic sourcing and spend analytics. Aligns with oil and gas industry procurement taxonomy. [ENUM-REF-CANDIDATE: drilling_services|oilfield_equipment|refinery_catalysts|maintenance_materials|construction_services|engineering_services|IT_equipment|office_supplies — 8 candidates stripped; promote to reference product]',
    `project_number` STRING COMMENT 'Unique identifier for the capital project or drilling program associated with the purchase order. Used for CAPEX tracking and project portfolio management.',
    `purchasing_group` STRING COMMENT 'Buyer group or team responsible for specific categories of procurement. Used for workload distribution and category management.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Represents the legal entity or business unit executing the purchase.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of materials or completion of services. Used for supply chain planning and vendor performance tracking.',
    `sap_document_number` STRING COMMENT 'Internal SAP system document number for the purchase order. Used for technical integration and audit trail purposes.',
    `storage_location` STRING COMMENT 'Specific storage area within the plant where materials will be received and stored. Used for inventory management and warehouse operations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for the purchase order based on applicable tax codes and rates.',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applied to the purchase order. Determines sales tax, VAT, GST, or other applicable taxes based on delivery location and vendor.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items before taxes and adjustments. Represents the gross commitment amount.',
    `total_po_value_usd` DECIMAL(18,2) COMMENT 'Total purchase order value converted to United States Dollars for consolidated reporting and spend analytics. Conversion performed at PO date exchange rate.',
    `vendor_site_code` STRING COMMENT 'Code identifying the specific vendor location or site for delivery and invoicing purposes. Used when a vendor has multiple operational sites.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the purchase order record in the system.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Legally binding procurement document issued to a vendor for the supply of materials, equipment, or services. Aligned with SAP MM Purchase Order. Captures PO number, PO date, PO type (standard, blanket, framework, emergency, subcontract), vendor ID, vendor name, delivery address, incoterms, payment terms, currency, total PO value (USD), tax code, WBS element, cost center, AFE number, project number, plant, storage location, PO status (open, partially delivered, fully delivered, closed, cancelled), buyer name, approval authority, and SAP document number. Core transactional entity for CAPEX and OPEX procurement including rig contracts and EPC awards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the PO line item entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Individual PO line items can be charged to different AFE budgets (common in oil & gas when one PO covers materials for multiple wells or projects). Line-level AFE assignment provides more granular cos',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center assignment enables split accounting for mixed POs (operational and capital items). Required for accurate departmental cost allocation and expense recognition in oil & gas operat',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being procured. Links to the material catalog for drilling equipment, oilfield supplies, refinery catalysts, or maintenance materials.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Direct procurement of petroleum products on PO line items (crude purchases, refined product trading, feedstock acquisition). Critical for pricing, quality specifications, and custody transfer document',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Line-level WBS tracking enables mixed orders with some lines charged to capital projects and others to operations. Standard SAP MM-FI integration pattern for project-based procurement.',
    `account_assignment_category` STRING COMMENT 'Determines how the procurement cost is assigned in financial accounting. Distinguishes between Operating Expenditure (OPEX) cost center assignments and Capital Expenditure (CAPEX) project assignments.. Valid values are `cost_center|wbs_element|asset|order|project`',
    `asset_number` STRING COMMENT 'The fixed asset number when the procurement is for asset acquisition or capitalization. Used for asset lifecycle management and Depreciation Depletion and Amortization (DD&A) tracking.',
    `created_date` DATE COMMENT 'The date when this purchase order line item record was created in the system. Used for procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price and line item value. Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion. Deleted line items are excluded from goods receipt and invoice processing.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Critical for project scheduling, rig mobilization, and turnaround planning.',
    `delivery_status` STRING COMMENT 'Current status of goods receipt processing for this line item. Tracks fulfillment progress from vendor.. Valid values are `open|partially_received|fully_received|cancelled`',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating that the final invoice has been received for this line item and no further invoices are expected. Closes the line item for invoice processing.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether a goods receipt is required for this line item. True for physical materials, false for services or non-stock items.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether an invoice is expected for this line item. Controls invoice verification processing and three-way matching requirements.',
    `invoice_status` STRING COMMENT 'Current status of invoice receipt and verification for this line item. Tracks accounts payable processing progress.. Valid values are `not_invoiced|partially_invoiced|fully_invoiced|blocked`',
    `item_category` STRING COMMENT 'Classification of the procurement item type. Determines procurement processing rules, inventory treatment, and account assignment behavior.. Valid values are `standard|consignment|subcontracting|service|third_party|stock_transfer`',
    `last_modified_date` DATE COMMENT 'The date when this purchase order line item was last changed. Tracks the most recent update to quantity, price, delivery date, or other line item attributes.',
    `line_item_value_usd` DECIMAL(18,2) COMMENT 'Total monetary value of this line item calculated as quantity ordered multiplied by unit price, expressed in USD. Used for spend analytics and Authorization for Expenditure (AFE) tracking.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and position of this line item in the PO document.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material. Critical for equipment maintenance and spare parts management.',
    `material_group` STRING COMMENT 'High-level classification of the material type for spend analytics and procurement strategy. Examples include drilling services, tubular goods, chemicals, catalysts, or maintenance supplies.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may over-deliver against the ordered quantity without requiring approval. Expressed as a percentage.',
    `plant_code` STRING COMMENT 'The plant or facility code where the material will be received. Represents refineries, production facilities, drilling sites, or distribution terminals.',
    `purchasing_group` STRING COMMENT 'The buyer or procurement team responsible for this line item. Used for workload distribution and procurement performance tracking.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the vendor against this line item to date. Used for three-way matching and variance analysis.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units ordered on this line item. Represents the total amount requested from the vendor.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Used to calculate open quantity and delivery completion percentage.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this PO line item. Used for procurement accountability and spend analysis.',
    `short_text` STRING COMMENT 'Additional short text description or notes for this line item. Provides supplementary information beyond the material description.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where the material will be stored upon receipt. Used for inventory management and materials tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this line item based on the tax code and line item value.',
    `tax_code` STRING COMMENT 'The tax jurisdiction code applicable to this line item. Determines sales tax, use tax, or value-added tax (VAT) calculation.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Allowable percentage by which the vendor may under-deliver against the ordered quantity without requiring approval. Expressed as a percentage.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the ordered quantity. Common values include barrels (BBL), cubic feet (CF), tons (TON), each (EA), meters (M), kilograms (KG), liters (L), or service hours (HR).',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure for this line item. Expressed in the purchase order currency.',
    `valuation_type` STRING COMMENT 'Valuation classification for materials with split valuation. Used when the same material is valued differently based on procurement source or quality grade.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or catalog number for this material. Used for cross-reference and vendor communication.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material, equipment item, or service position. Captures PO line number, purchase order reference, material master reference, material description, item category (standard, consignment, subcontracting, service), quantity ordered, unit of measure, unit price, line item value (USD), delivery date, plant, storage location, account assignment category (cost center, WBS, asset), WBS element, cost center, asset number, goods receipt indicator, invoice receipt indicator, delivery status (open, partially received, fully received), and invoice status. Supports granular CAPEX/OPEX tracking per AFE line.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Goods receipts post actual costs to AFE budgets at the point of receipt (accrual accounting). This enables real-time AFE actual spend tracking and variance analysis against committed spend (PO) and ap',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GR postings generate accounting documents requiring cost center for expense recognition and inventory valuation. Direct GL posting requirement for operational materials in oil & gas field operations.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record identifying the specific material, equipment, or spare part received.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Receiving petroleum products requires quality verification against product specs (API gravity, sulfur content, etc.). Essential for custody transfer, quality settlement, and inventory valuation in oil',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Goods receipts are posted against specific PO line items, not just PO headers. This provides precise traceability for 3-way match (PO line - GR - Invoice line), delivery performance by line item, and ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Goods receipt inspection requires qualified employee certification for NORM, H2S, and API specifications. Receiving_inspector_name denormalizes employee. Critical for quality assurance, HSE compliance',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Materials (tubulars, wellheads, pumps, chemicals) received via truck/rail/vessel shipments require linkage for three-way match (PO/Shipment/GR). Real business process: inventory reconciliation, freigh',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who delivered the materials or equipment.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: GR for capital projects (tubulars, completion equipment) must post to WBS for asset under construction tracking and proper capitalization. Required for drilling and completion asset accounting.',
    `batch_number` STRING COMMENT 'The manufacturer or supplier batch or lot number for the received materials, critical for quality control, traceability, and recall management.. Valid values are `^[A-Z0-9]{6,12}$`',
    `certificate_of_conformance_reference` STRING COMMENT 'Reference number for the certificate of conformance or material test report provided by the vendor, documenting that materials meet specified quality and safety standards.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `condition_on_receipt` STRING COMMENT 'The physical condition assessment of the materials upon receipt, indicating whether they are acceptable for use, damaged, rejected, or require further inspection.. Valid values are `acceptable|damaged|rejected|partial|quarantine|inspection_required`',
    `created_by_user` STRING COMMENT 'The system user ID or name of the individual who created this goods receipt record, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system, providing audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the monetary values in this goods receipt transaction.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The vendor delivery note or packing slip number accompanying the shipment, used for reconciliation and dispute resolution.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `gr_date` DATE COMMENT 'The date when the physical receipt of materials or equipment occurred at the facility, warehouse, or rig site. This is the principal business event timestamp for the transaction.',
    `gr_document_number` STRING COMMENT 'The externally-known business identifier for this goods receipt transaction, typically the SAP Material Document number used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'The current lifecycle status of the goods receipt transaction, indicating whether it is posted to inventory, reversed due to error, cancelled, or pending approval.. Valid values are `posted|reversed|cancelled|pending|blocked`',
    `h2s_service_certification_flag` BOOLEAN COMMENT 'Indicates whether the received materials are certified for use in hydrogen sulfide service environments, a critical safety requirement for sour gas operations.',
    `hazmat_classification` STRING COMMENT 'The hazardous material classification code for the received materials, critical for HSE compliance and safe handling procedures.',
    `inspection_lot_number` STRING COMMENT 'The quality management inspection lot number created for this goods receipt, triggering quality inspection workflows for critical materials.. Valid values are `^[A-Z0-9]{10}$`',
    `last_modified_by_user` STRING COMMENT 'The system user ID or name of the individual who last modified this goods receipt record, supporting accountability and audit requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated, providing audit trail for record changes.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction, such as GR against PO, GR without PO, or return delivery.. Valid values are `^[0-9]{3}$`',
    `norm_inspection_flag` BOOLEAN COMMENT 'Indicates whether the received materials were inspected for naturally occurring radioactive material contamination, a critical safety requirement for oilfield equipment and tubulars.',
    `plant_code` STRING COMMENT 'The code identifying the Oil Gas facility, refinery, production site, or operational plant where the goods were received.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date when the goods receipt transaction was posted to the financial and inventory accounting systems, which may differ from the physical receipt date.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or equipment physically received and accepted at the receiving location. This is the principal quantitative fact for the goods receipt.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions recorded by the receiving inspector at the time of goods receipt.',
    `serial_number` STRING COMMENT 'The unique serial number for serialized equipment or high-value assets received, enabling individual asset tracking throughout its lifecycle.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `storage_location_code` STRING COMMENT 'The specific warehouse, yard, or storage area within the plant where the received materials are physically stored.. Valid values are `^[A-Z0-9]{4}$`',
    `total_value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods receipt, calculated as received quantity multiplied by unit price, used for financial posting and spend analytics.',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is measured, such as barrels, gallons, kilograms, or each. [ENUM-REF-CANDIDATE: EA|BBL|GAL|LB|KG|TON|FT|M|M3|L|BOX|DRUM|PALLET|ROLL — 14 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the received materials as specified in the purchase order, used for inventory valuation and three-way match.',
    `valuation_type` STRING COMMENT 'The valuation type used to differentiate materials with the same material number but different procurement sources or quality grades for inventory valuation purposes.. Valid values are `^[A-Z0-9]{2,4}$`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Record of physical receipt of materials, equipment, or spare parts against a purchase order at an Oil Gas facility, warehouse, or rig site. Aligned with SAP MM Goods Receipt (MIGO). Captures GR document number, GR date, PO reference, PO line reference, vendor ID, material number, received quantity, unit of measure, storage location, plant, receiving inspector name, condition on receipt (acceptable, damaged, rejected), batch number, serial number, certificate of conformance reference, NORM inspection flag, H2S service certification flag, and GR status (posted, reversed). Triggers inventory update and three-way match for invoice verification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Unique identifier for the service entry sheet record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Service entry sheets post service costs (drilling services, contractor labor, rig time) to AFE budgets. This is critical for AFE cost control in drilling and completion operations. Currently has afe_n',
    `contract_id` BIGINT COMMENT 'Reference to the master service contract or blanket agreement under which the services were performed.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Field supervisor acceptance of services (drilling, completion, workover) requires employee accountability for AFE cost control and JIB billing. Field_supervisor_name denormalizes employee. Essential f',
    `hierarchy_id` BIGINT COMMENT 'Reference to the asset, well, facility, or equipment for which the services were performed.',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line_item. Business justification: Service entry sheets confirm services rendered against specific PO line items for services. This enables precise service-level 3-way match, accrual tracking by service line, and service delivery verif',
    `port_call_id` BIGINT COMMENT 'Foreign key linking to logistics.port_call. Business justification: Port services (pilotage, towage, linesmen, agency fees, berth charges) are recorded per port call for laytime and cost tracking. Real business process: port disbursement account reconciliation, laytim',
    `purchase_order_id` BIGINT COMMENT 'Reference to the service purchase order or blanket order against which services were rendered.',
    `rig_id` BIGINT COMMENT 'Reference to the drilling rig or mobile equipment used for the service, relevant for rig day-rate billing.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment. Business justification: Shipment-specific services (loading/unloading, stevedoring, inspection, fumigation, customs brokerage) are recorded for cost allocation. Real business process: shipment cost tracking, freight invoice ',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor or service provider who rendered the services.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Services performed during voyages (bunker supply, crew changes, underwater inspections, tank cleaning) are recorded via service entry sheets for cost accrual. Real business process: voyage P&L calcula',
    `well_asset_id` BIGINT COMMENT 'Reference to the well for which drilling, completion, or workover services were performed.',
    `acceptance_date` DATE COMMENT 'Date when the field supervisor or authorized representative formally accepted the services as complete and satisfactory.',
    `approval_date` DATE COMMENT 'Date when the service entry sheet was formally approved for invoice verification and payment.',
    `approver_name` STRING COMMENT 'Name of the person who approved the service entry sheet for payment processing.',
    `company_code` STRING COMMENT 'Company code representing the legal entity within the enterprise that is responsible for the service expense.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center to which the service expense is allocated for financial reporting and cost control.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the service value. Typically USD for US operations but may vary for international contracts.. Valid values are `^[A-Z]{3}$`',
    `gl_account` STRING COMMENT 'General Ledger account code to which the service expense is posted for financial accounting.. Valid values are `^[0-9]{6,10}$`',
    `invoice_reference` STRING COMMENT 'Reference to the vendor invoice document that corresponds to this service entry sheet for three-way matching in accounts payable.',
    `location_code` STRING COMMENT 'Code identifying the geographic location, field, or facility where the services were performed.. Valid values are `^[A-Z0-9]{3,10}$`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the service entry sheet record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was last modified in the system.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the due date calculation and discount conditions for vendor payment.. Valid values are `^[A-Z0-9]{4}$`',
    `plant_code` STRING COMMENT 'Plant or operational site code where the services were consumed or applied.. Valid values are `^[A-Z0-9]{4}$`',
    `posted_date` DATE COMMENT 'Date when the service entry sheet was posted to financial accounting and the expense was recognized in the General Ledger.',
    `rejection_reason` STRING COMMENT 'Explanation or reason code if the service entry sheet was rejected by approver or accounts payable, including discrepancies or quality issues.',
    `remarks` STRING COMMENT 'Additional comments, notes, or special instructions related to the service entry sheet, including quality observations or deviations.',
    `service_description` STRING COMMENT 'Detailed description of the services performed, including scope, activities, and deliverables.',
    `service_period_end_date` DATE COMMENT 'End date of the period during which the services were performed.',
    `service_period_start_date` DATE COMMENT 'Start date of the period during which the services were performed.',
    `service_quantity` DECIMAL(18,2) COMMENT 'Quantity of service units performed or delivered, such as hours, days, or other measurable units.',
    `service_type` STRING COMMENT 'Classification of the type of service rendered, such as drilling services, rig day-rate, maintenance, Engineering Procurement and Construction (EPC) milestone, or other service categories. [ENUM-REF-CANDIDATE: drilling|completion|workover|maintenance|inspection|engineering|consulting|transportation|catering|other — 10 candidates stripped; promote to reference product]',
    `ses_date` DATE COMMENT 'Date when the service entry sheet was created or submitted for approval.',
    `ses_number` STRING COMMENT 'Business identifier for the service entry sheet, externally visible document number used for tracking and reference in procurement and accounts payable processes.. Valid values are `^SES-[0-9]{8,12}$`',
    `ses_status` STRING COMMENT 'Current lifecycle status of the service entry sheet in the approval and posting workflow.. Valid values are `draft|submitted|approved|rejected|cancelled|posted`',
    `tax_amount_usd` DECIMAL(18,2) COMMENT 'Tax amount calculated on the service value in United States Dollars.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applicable to the service transaction for sales tax, use tax, or Value Added Tax (VAT) calculation.. Valid values are `^[A-Z0-9]{2,4}$`',
    `total_service_value_usd` DECIMAL(18,2) COMMENT 'Total value of services rendered, calculated as service quantity multiplied by unit rate in United States Dollars.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the service quantity, such as hours, days, shifts, or other standard units. [ENUM-REF-CANDIDATE: hour|day|shift|trip|unit|each|lot|month — 8 candidates stripped; promote to reference product]',
    `unit_rate_usd` DECIMAL(18,2) COMMENT 'Agreed unit rate or price per service unit in United States Dollars as specified in the purchase order or contract.',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element for Capital Expenditure (CAPEX) project tracking, used for Engineering Procurement and Construction (EPC) and Front-End Engineering Design (FEED) projects.. Valid values are `^[A-Z0-9.-]{6,24}$`',
    `created_by` STRING COMMENT 'User ID or name of the person who created the service entry sheet record in the system.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Confirmation document recording the acceptance of services rendered by a contractor or service provider against a service purchase order or blanket order. Captures SES number, SES date, PO reference, service line reference, vendor ID, service description, service period (from/to dates), quantity of service units performed, unit of measure, agreed unit rate, total service value (USD), cost center, WBS element, AFE number, field supervisor acceptance name, acceptance date, SES status (draft, submitted, approved, rejected), and rejection reason. Critical for rig day-rate billing, EPC milestone payments, and maintenance service verification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique system identifier for the procurement contract record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Procurement contracts for CAPEX projects (drilling, completion, EPC, FEED) are executed against AFE budgets. This enables contract value validation against AFE approved budget, commitment tracking, an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contracts need default cost center for budget monitoring, commitment tracking, and organizational cost allocation. Essential for contract management and financial planning in oil & gas operations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract ownership assigns employee accountability for rig contracts, drilling services, and EPC agreements. Contract_owner is text but represents employee. Critical for contract lifecycle management ',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Long-term supply contracts for petroleum products (crude supply agreements, refined product offtake contracts). Links contract terms to product specifications, quality requirements, and pricing mechan',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or contractor party to this procurement contract. Links to vendor master data in SAP MM.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Contracts for drilling rigs, completion services, and capital projects must link to WBS for commitment tracking and budget control. Critical for project-based contract management and AFE monitoring.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories. Distinct from effective date which is when the contract becomes binding.',
    `contract_category` STRING COMMENT 'High-level categorization of the procurement contract by spend category. Drilling services for rig and well services, oilfield equipment for downhole and surface equipment, refinery catalysts for refining process materials, maintenance materials for MRO (Maintenance Repair and Operations), engineering services for FEED and design, construction services for EPC and facilities.. Valid values are `drilling_services|oilfield_equipment|refinery_catalysts|maintenance_materials|engineering_services|construction_services`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract. Used in SAP MM outline agreements and vendor communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates contract under negotiation, active indicates contract in force, expired indicates contract past expiry date, terminated indicates early termination, suspended indicates temporary hold, pending_approval indicates awaiting authorization.. Valid values are `draft|active|expired|terminated|suspended|pending_approval`',
    `contract_type` STRING COMMENT 'Classification of the procurement contract governing the commercial relationship. Master supply agreement for recurring materials, blanket purchase agreement for framework pricing, rig contract for drilling services with day-rate structures, EPC (Engineering Procurement and Construction) contract for capital projects, FEED (Front-End Engineering Design) contract for pre-project engineering, or service agreement for ongoing operational services.. Valid values are `master_supply_agreement|blanket_purchase_agreement|rig_contract|epc_contract|feed_contract|service_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this procurement contract record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contract financial terms (e.g., USD, EUR, GBP). Used for multi-currency contract management and foreign exchange exposure tracking.. Valid values are `^[A-Z]{3}$`',
    `day_rate_usd` DECIMAL(18,2) COMMENT 'Daily operating rate charged by the drilling contractor when the rig is actively drilling, expressed in United States Dollars per day. Core commercial term for rig contracts. Nullable for non-rig contracts.',
    `demobilization_fee_usd` DECIMAL(18,2) COMMENT 'One-time fee paid to the drilling contractor to move the rig away from the operating location at contract end, expressed in United States Dollars. Nullable for non-rig contracts.',
    `dispute_resolution_mechanism` STRING COMMENT 'Agreed method for resolving contractual disputes. Litigation involves court proceedings, arbitration involves binding third-party arbitrator (common in international contracts), mediation involves facilitated negotiation, expert determination involves technical expert decision.. Valid values are `litigation|arbitration|mediation|expert_determination`',
    `early_termination_clause` STRING COMMENT 'Description of conditions and penalties under which either party may terminate the contract before the expiry date. May include termination for convenience provisions with notice periods and termination fees.',
    `effective_date` DATE COMMENT 'Date when the contract becomes legally binding and enforceable. Marks the start of the contract term.',
    `expiry_date` DATE COMMENT 'Date when the contract term ends and obligations cease unless renewed. Nullable for open-ended contracts or contracts with automatic renewal clauses.',
    `governing_law` STRING COMMENT 'Jurisdiction and legal framework governing the interpretation and enforcement of the contract (e.g., State of Texas, USA, English Law, Norwegian Law). Critical for international contracts.',
    `hse_requirements` STRING COMMENT 'Summary of HSE (Health Safety and Environment) standards, certifications, and performance requirements that the vendor must meet. May reference API, OSHA, EPA, or company-specific HSE standards.',
    `insurance_requirements` STRING COMMENT 'Description of insurance coverage types and minimum limits required from the vendor (e.g., general liability, professional indemnity, pollution liability). Critical for HSE (Health Safety and Environment) risk management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this procurement contract record was last updated. Used for change tracking and audit trail.',
    `liquidated_damages_clause` STRING COMMENT 'Description of pre-agreed damages payable by vendor for specific breaches such as late delivery, non-performance, or failure to meet specifications. Common in EPC contracts for schedule delays.',
    `mobilization_fee_usd` DECIMAL(18,2) COMMENT 'One-time fee paid to the drilling contractor to move the rig to the operating location at contract start, expressed in United States Dollars. Nullable for non-rig contracts.',
    `npt_penalty_provisions` STRING COMMENT 'Description of penalties or rate reductions applied when the rig experiences non-productive time due to contractor-caused issues. NPT (Non-Productive Time) is a critical KPI in drilling operations. Nullable for non-rig contracts.',
    `operating_area` STRING COMMENT 'Geographic region or field where the rig will operate under this contract (e.g., Gulf of Mexico - Deepwater, North Sea - Norwegian Sector, Permian Basin). Nullable for non-rig contracts.',
    `payment_terms` STRING COMMENT 'Commercial payment conditions including payment schedule, net days, milestone-based payments, or progress billing terms (e.g., Net 30, 50% upfront / 50% on completion, Monthly arrears).',
    `performance_bond_value_usd` DECIMAL(18,2) COMMENT 'Monetary value of the performance bond or guarantee required from the vendor to secure contract performance, expressed in United States Dollars. Common in EPC and rig contracts to mitigate non-performance risk.',
    `price_escalation_mechanism` STRING COMMENT 'Formula or index used to adjust contract pricing over time (e.g., CPI-linked, oil price index, fixed annual percentage). Protects both parties from inflation or commodity price volatility.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an option for renewal or extension beyond the initial term. True if renewal option exists, False otherwise.',
    `renewal_terms` STRING COMMENT 'Description of renewal or extension terms including notice period, pricing adjustments, and conditions. Nullable if renewal_option_flag is False.',
    `sap_outline_agreement_number` STRING COMMENT 'SAP MM system identifier for the outline agreement (contract or scheduling agreement) linked to this procurement contract. Enables integration between contract management and procurement execution.. Valid values are `^[0-9]{10}$`',
    `scope_of_work_summary` STRING COMMENT 'High-level description of the goods or services covered under this contract. For rig contracts, includes well program reference and operating area. For EPC contracts, includes project deliverables and specifications.',
    `standby_rate_usd` DECIMAL(18,2) COMMENT 'Reduced daily rate charged when the rig is on standby (not actively drilling but available), expressed in United States Dollars per day. Typically 50-80% of day rate. Nullable for non-rig contracts.',
    `title` STRING COMMENT 'Descriptive title or name of the procurement contract summarizing its purpose and scope (e.g., Offshore Drilling Services - Gulf of Mexico 2024, Refinery Catalyst Supply Agreement).',
    `value_usd` DECIMAL(18,2) COMMENT 'Total estimated or maximum monetary value of the contract in United States Dollars. For rig contracts, represents total estimated spend based on day rate and expected duration. For EPC/FEED contracts, represents total project value. Aligns with AFE (Authorization for Expenditure) budget control.',
    `well_program_reference` STRING COMMENT 'Reference to the well program or drilling campaign that this rig contract supports. Links contract to operational drilling plans. Nullable for non-rig contracts.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master procurement contract or framework agreement governing the commercial relationship between Oil Gas and a vendor for supply of materials or services, including rig contracts with day-rate structures. Captures contract number, contract type (master supply agreement, blanket purchase agreement, rig contract, EPC contract, FEED contract, service agreement, rate agreement), vendor ID, contract title, effective date, expiry date, contract value (USD), currency, scope of work summary, payment terms, performance bond value, liquidated damages clause, price escalation mechanism, governing law, dispute resolution mechanism, contract status (draft, active, expired, terminated, suspended), SAP outline agreement number, and for rig contracts: rig name, rig type, day rate (USD/day), standby rate (USD/day), mobilization/demobilization fees, NPT penalty provisions, well program reference, operating area, and early termination clause. Includes milestone schedule for EPC/FEED contracts with milestone descriptions, planned/actual dates, payment percentages, and completion status. Distinct from JOA/PSA agreements owned by the venture domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` (
    `contract_amendment_id` BIGINT COMMENT 'Unique identifier for the procurement contract amendment record. Primary key for the amendment entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Amendment initiation requires employee accountability for scope changes, AFE revisions, and MOC processes. Change_initiator is text but represents employee. Essential for change control and audit trai',
    `contract_id` BIGINT COMMENT 'Reference to the parent procurement contract being amended. Links this amendment to the original contract for EPC, FEED, rig services, or materials procurement agreements.',
    `afe_number` STRING COMMENT 'AFE identifier associated with this amendment for CAPEX project budget tracking. Links the amendment to the capital authorization and enables budget variance analysis.',
    `afe_revision_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment triggers an AFE budget revision. True when amendment value exceeds AFE contingency or requires joint venture partner approval.',
    `amendment_date` DATE COMMENT 'Date when the amendment was formally issued or executed. Represents the business event timestamp for the contract modification.',
    `amendment_document_reference` STRING COMMENT 'Reference identifier or file path to the formal amendment document, change order, or contract modification agreement. Supports document management integration.',
    `amendment_number` STRING COMMENT 'Sequential amendment identifier within the contract lifecycle (e.g., Amendment 001, Amendment 002). Used for tracking change order sequence and version control.',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (in preparation), pending approval (submitted for review), approved (authorized but not yet executed), rejected (denied), executed (signed and binding), or cancelled (withdrawn).. Valid values are `draft|pending_approval|approved|rejected|executed|cancelled`',
    `amendment_type` STRING COMMENT 'Classification of the amendment nature: scope change (work scope modification), value change (contract value adjustment), schedule extension (timeline modification), price adjustment (rate or unit price change), termination for convenience (early contract termination), or force majeure (unforeseen circumstances).. Valid values are `scope_change|value_change|schedule_extension|price_adjustment|termination_for_convenience|force_majeure`',
    `amendment_value` DECIMAL(18,2) COMMENT 'Incremental value change introduced by this amendment. Positive for increases, negative for decreases. Zero for non-financial amendments such as schedule extensions.',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee authorized to approve this amendment. Reflects delegation of authority based on amendment value thresholds per corporate governance policy.',
    `approval_date` DATE COMMENT 'Date when the amendment received formal approval from the designated authority. Critical for audit trail and Management of Change (MOC) compliance.',
    `contract_type` STRING COMMENT 'Classification of the parent contract being amended: EPC (Engineering Procurement Construction), FEED (Front-End Engineering Design), drilling services, rig contract, materials procurement, maintenance services, or consulting. [ENUM-REF-CANDIDATE: epc|feed|drilling_services|rig_contract|materials_procurement|maintenance_services|consulting — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was first created. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this amendment (e.g., USD, CAD, GBP). Supports multi-currency contract management for international operations.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the amendment terms become binding and enforceable. May differ from amendment date for retroactive or future-effective changes.',
    `execution_date` DATE COMMENT 'Date when the amendment was formally signed by all parties and became legally binding. Null for amendments not yet executed.',
    `joint_venture_approval_date` DATE COMMENT 'Date when joint venture partners approved the amendment per JOA requirements. Null if JV approval not required or not yet obtained.',
    `joint_venture_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires approval from joint venture partners per the Joint Operating Agreement (JOA). True when amendment exceeds operator authority limits.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the individual who last updated this amendment record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was last updated. Supports audit trail and version control.',
    `moc_reference_number` STRING COMMENT 'Reference to the MOC request that authorized this amendment. Links contract changes to the formal change management process for HSE and operational risk control.',
    `original_completion_date` DATE COMMENT 'Contract completion date before this amendment. Baseline for measuring schedule variance and extension impact.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'Total contract value before this amendment, representing the baseline commitment amount. Used for calculating amendment impact and AFE budget variance.',
    `price_adjustment_basis` STRING COMMENT 'Justification or formula for price adjustments in this amendment. Captures escalation indices, market rate changes, or cost pass-through mechanisms per contract terms.',
    `reason_for_amendment` STRING COMMENT 'Detailed business justification for the contract modification. Captures scope changes, design revisions, regulatory requirements, market conditions, or operational needs driving the amendment.',
    `revised_completion_date` DATE COMMENT 'New contract completion date after applying this amendment. Reflects schedule extensions or accelerations resulting from the change order.',
    `revised_contract_value` DECIMAL(18,2) COMMENT 'Total contract value after applying this amendment (original value plus amendment value). Represents the new commitment ceiling for AFE budget tracking.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days added to or subtracted from the contract schedule. Positive for extensions, negative for accelerations. Null for amendments with no schedule impact.',
    `scope_change_description` STRING COMMENT 'Detailed description of work scope modifications for scope change amendments. Captures additions, deletions, or revisions to deliverables, specifications, or performance requirements.',
    `termination_for_convenience_flag` BOOLEAN COMMENT 'Indicates whether this amendment represents a termination for convenience clause invocation. True when operator exercises contractual right to terminate without cause.',
    `termination_settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount for termination amendments. Includes demobilization costs, work-in-progress payments, and contractual termination fees. Null for non-termination amendments.',
    `vendor_acceptance_date` DATE COMMENT 'Date when the vendor or contractor formally accepted the amendment terms. Critical for bilateral amendments requiring mutual consent.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this amendment record in the system. Supports audit trail and accountability.',
    CONSTRAINT pk_contract_amendment PRIMARY KEY(`contract_amendment_id`)
) COMMENT 'Formal amendment or change order to an existing procurement contract, capturing modifications to scope, value, schedule, or commercial terms. Captures amendment number, procurement contract reference, amendment date, amendment type (scope change, value change, schedule extension, price adjustment, termination for convenience), original contract value, amendment value, revised total contract value, reason for amendment, change initiator (Oil Gas or vendor), approval authority, approval date, and amendment status (pending, approved, rejected, executed). Supports MOC (Management of Change) compliance and AFE budget revision tracking for EPC and rig contracts.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`afe_budget` (
    `afe_budget_id` BIGINT COMMENT 'Unique identifier for the AFE budget record. Primary key for the AFE budget entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AFE approval by authorized employee is fundamental to capital expenditure controls and authorization matrices. Approving_authority is text but represents employee. Critical for financial governance an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AFE budgets require cost center assignment for organizational cost tracking, reporting hierarchy, and operational vs. capital classification. Standard financial structure for oil & gas capital project',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Procurement AFE must reconcile with finance AFE master for budget vs. actual tracking, variance analysis, and financial reporting. Critical for integrated AFE management and capital project control.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: AFE budgets link to WBS for project structure, capital tracking, and asset capitalization. Standard project accounting requirement for drilling and completion programs in oil & gas.',
    `actual_completion_date` DATE COMMENT 'The actual date on which the AFE project work was completed and the AFE was closed for final cost reconciliation.',
    `actual_spend` DECIMAL(18,2) COMMENT 'The cumulative amount of budget that has been actually spent (invoiced and paid or accrued) against this AFE. Represents realized expenditure.',
    `afe_number` STRING COMMENT 'The externally-known unique AFE number assigned to this authorization for expenditure. This is the business identifier used across joint venture partners and in COPAS joint interest billing.',
    `afe_status` STRING COMMENT 'Current lifecycle status of the AFE: proposed (draft, awaiting approval), approved (authorized but not yet active), active (work in progress, spend occurring), closed (project complete, final reconciliation done), or cancelled (AFE withdrawn before completion).. Valid values are `proposed|approved|active|closed|cancelled`',
    `afe_title` STRING COMMENT 'Descriptive title or name of the AFE project, summarizing the scope of work (e.g., Eagle Ford Well 123 Drilling and Completion, Refinery Turnaround 2024).',
    `afe_type` STRING COMMENT 'Classification of the AFE by project type: drilling (new well), workover (well intervention), completion (well completion activities), facility (surface facility construction), pipeline (pipeline construction or expansion), turnaround (refinery or plant turnaround), or maintenance (major maintenance project). [ENUM-REF-CANDIDATE: drilling|workover|completion|facility|pipeline|turnaround|maintenance — 7 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which the AFE was formally approved by the approving authority, granting spending authorization.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'The total authorized budget amount for this AFE in the specified currency. This is the spending authority granted by the approving authority and represents the CAPEX or OPEX ceiling for the project.',
    `asset_class` STRING COMMENT 'The fixed asset class or category for CAPEX AFEs, used for depreciation calculation and asset accounting (e.g., Producing Wells, Gathering Systems, Processing Facilities, Refining Units).',
    `budget_variance` DECIMAL(18,2) COMMENT 'The variance between approved budget and actual spend, expressed as a monetary amount. Positive values indicate under-budget, negative values indicate over-budget.',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The variance between approved budget and actual spend, expressed as a percentage of the approved budget. Used for performance monitoring and variance analysis.',
    `business_unit` STRING COMMENT 'The business unit or operating division responsible for this AFE (e.g., Upstream E&P, Midstream, Downstream Refining, Petrochemicals).',
    `capex_opex_classification` STRING COMMENT 'Classification of the AFE spend as either CAPEX (capital expenditure for asset acquisition or improvement) or OPEX (operating expenditure for routine operations and maintenance). Determines accounting treatment and depreciation.. Valid values are `CAPEX|OPEX`',
    `committed_spend` DECIMAL(18,2) COMMENT 'The cumulative amount of budget that has been committed through purchase orders, contracts, and service agreements, but not yet invoiced or paid. Represents encumbered funds.',
    `completion_equipment_budget` DECIMAL(18,2) COMMENT 'Budget allocation for well completion equipment including packers, subsurface safety valves, wellheads, Christmas trees, and artificial lift equipment. Part of the AFE cost category breakdown.',
    `contingency_budget` DECIMAL(18,2) COMMENT 'The contingency or reserve amount included in the approved budget to cover unforeseen costs, risks, or scope changes. Typically expressed as a percentage of the base budget.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE budget record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD for US Dollars, CAD for Canadian Dollars). [ENUM-REF-CANDIDATE: USD|CAD|EUR|GBP|AUD|BRL|MXN — 7 candidates stripped; promote to reference product]',
    `depreciation_method` STRING COMMENT 'The depreciation method to be applied to CAPEX assets created by this AFE: straight_line (equal annual depreciation), units_of_production (depreciation based on production volumes), or declining_balance (accelerated depreciation).. Valid values are `straight_line|units_of_production|declining_balance`',
    `drilling_services_budget` DECIMAL(18,2) COMMENT 'Budget allocation for drilling services including rig contracts, directional drilling, MWD/LWD services, and drilling fluids. Part of the AFE cost category breakdown.',
    `epc_budget` DECIMAL(18,2) COMMENT 'Budget allocation for EPC contractor services covering engineering, procurement, and construction activities for facility projects. Part of the AFE cost category breakdown.',
    `estimated_completion_date` DATE COMMENT 'The planned or estimated date for completion of the AFE project work and final cost reconciliation.',
    `feed_budget` DECIMAL(18,2) COMMENT 'Budget allocation for FEED contractor services covering conceptual and detailed engineering design work prior to EPC execution. Part of the AFE cost category breakdown.',
    `field_name` STRING COMMENT 'The name of the oil or gas field, asset, or facility where the AFE work will be performed (e.g., Permian Basin Block 45, Port Arthur Refinery).',
    `jib_billing_code` STRING COMMENT 'The COPAS JIB billing code used for joint interest billing and cost allocation to non-operating partners. Determines how costs are categorized and billed in joint venture accounting.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this AFE budget record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE budget record was last modified. Used for audit trail and change tracking.',
    `net_afe_amount` DECIMAL(18,2) COMMENT 'The companys net share of the AFE budget based on its working interest. Calculated as approved_budget_amount multiplied by working_interest percentage.',
    `operator_name` STRING COMMENT 'The name of the operating company responsible for executing the AFE work. In joint venture operations, this is the company designated as operator under the JOA.',
    `previous_afe_number` STRING COMMENT 'The AFE number of the previous revision if this AFE is a revision or amendment. Used to maintain audit trail of AFE changes.',
    `project_number` STRING COMMENT 'The project identifier from the ERP system (e.g., SAP PS project number) that this AFE is associated with for capital project tracking and financial integration.',
    `remaining_budget` DECIMAL(18,2) COMMENT 'The amount of approved budget that remains available for future commitments and spending. Calculated as approved_budget_amount minus committed_spend minus actual_spend.',
    `revision_number` STRING COMMENT 'The revision or amendment number for this AFE. AFEs may be revised to adjust budget, scope, or timing. Original AFE is revision 0, subsequent revisions increment this counter.',
    `tubulars_budget` DECIMAL(18,2) COMMENT 'Budget allocation for tubular goods including casing, tubing, drill pipe, and related materials. Part of the AFE cost category breakdown.',
    `working_interest` DECIMAL(18,2) COMMENT 'The companys working interest percentage in the project or property covered by this AFE. Expressed as a decimal (e.g., 0.3500 for 35% WI). Determines the companys share of AFE costs.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this AFE budget record. Used for audit trail and accountability.',
    CONSTRAINT pk_afe_budget PRIMARY KEY(`afe_budget_id`)
) COMMENT 'Authorization for Expenditure (AFE) budget record controlling CAPEX procurement spend for drilling, completion, facility construction, and major maintenance projects. Captures AFE number, AFE title, AFE type (drilling, workover, facility, pipeline, turnaround), project number, WBS element, cost center, business unit, field or asset name, AFE status (proposed, approved, active, closed, cancelled), approved budget (USD), currency, approval date, approving authority, budget breakdown by cost category (drilling services, tubulars, completion equipment, EPC, FEED), committed spend to date, actual spend to date, and remaining budget. Integrates with SAP PS and COPAS AFE accounting standards.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record in the lakehouse. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which this invoice amount is allocated for OPEX tracking and financial reporting.',
    `demurrage_claim_id` BIGINT COMMENT 'Foreign key linking to logistics.demurrage_claim. Business justification: Vendor invoices for demurrage settlements (or credits for despatch) must link to claims for payment processing and dispute resolution. Real business process: demurrage claim payment, laytime dispute s',
    `drilling_afe_id` BIGINT COMMENT 'Identifier of the AFE budget authorization under which this invoice expenditure is charged. Critical for CAPEX project cost control and joint venture cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved this invoice for payment. Used for audit trail and segregation of duties compliance.',
    `gl_account_id` BIGINT COMMENT 'Identifier of the GL account to which this invoice is posted for financial accounting and reporting.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the goods receipt document confirming material delivery. Used for three-way match verification when materials are procured.',
    `joint_venture_id` BIGINT COMMENT 'Identifier of the joint venture or production sharing agreement under which this invoice cost is allocated. Used for partner billing and revenue distribution.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Invoicing for petroleum product purchases requires product reference for pricing benchmarks, quality adjustments, and accounting classification. Critical for commodity trading settlements and financia',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order against which this invoice is submitted. Used for three-way match verification.',
    `service_entry_sheet_id` BIGINT COMMENT 'Identifier of the service entry sheet confirming service completion. Used for three-way match verification when services are procured.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who submitted this invoice. Links to the vendor master record.',
    `voyage_id` BIGINT COMMENT 'Foreign key linking to logistics.voyage. Business justification: Vendor invoices for voyage-related services (bunkers, port charges, canal fees, crew costs) must link to voyages for P&L calculation and charter party settlement. Real business process: voyage cost ac',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used for processing time analysis and internal control monitoring.',
    `blocking_reason` STRING COMMENT 'The reason the invoice is blocked from payment if invoice_status is blocked. Examples include price variance, quantity variance, missing documentation, or vendor hold.',
    `company_code` STRING COMMENT 'The SAP company code representing the legal entity that is liable for this invoice payment. Used for multi-entity financial consolidation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The discount amount applied to this invoice in the invoice currency. May include early payment discounts, volume discounts, or negotiated rebates.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the invoice currency to the companys functional currency (USD) at the time of posting. Used for multi-currency consolidation.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year to which this invoice is assigned based on the posting date. Used for monthly financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this invoice is assigned based on the posting date. Used for financial period reporting and year-end closing.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charges included in this invoice in the invoice currency. Separately tracked for cost analysis and allocation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The total payable amount converted to the companys functional currency (USD) using the exchange rate. Used for consolidated financial reporting.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Used to calculate payment due date and aging analysis.',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides additional context for invoice verification and audit purposes.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'The gross invoice amount before taxes and adjustments, in the invoice currency. Represents the base charge for goods or services.',
    `invoice_receipt_date` DATE COMMENT 'The date the invoice was received by the accounts payable department. Used for processing time tracking and internal SLA monitoring.',
    `invoice_status` STRING COMMENT 'The current processing status of the invoice in the accounts payable workflow. Tracks the invoice from receipt through payment or dispute resolution. [ENUM-REF-CANDIDATE: received|under_verification|approved|blocked|paid|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type of invoice document. Standard invoices are for completed goods or services; credit memos reduce amounts owed; debit memos increase amounts; prepayment and down payment invoices are for advance payments.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment|final`',
    `jib_indicator` BOOLEAN COMMENT 'Flag indicating whether this invoice is subject to joint interest billing and cost allocation among joint venture partners per COPAS standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last updated. Used for audit trail and change tracking.',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor. Used for cash flow reporting and vendor payment performance tracking.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the vendor per the agreed payment terms. Used for cash flow planning and vendor relationship management.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor (e.g., ACH, wire transfer, check, credit card, electronic funds transfer).. Valid values are `ach|wire_transfer|check|credit_card|eft`',
    `payment_reference_number` STRING COMMENT 'The reference number of the payment transaction (e.g., check number, wire confirmation number, ACH trace number) once payment has been executed.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this invoice (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment schedule and any early payment discounts available.',
    `plant_code` STRING COMMENT 'The plant or facility code where the goods or services covered by this invoice were received or consumed. Used for operational cost allocation.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the general ledger in SAP. Used for financial period assignment and reporting.',
    `sap_invoice_document_number` STRING COMMENT 'The internal SAP document number assigned to this invoice upon posting in SAP S/4HANA FI. Used for internal tracking and audit trail.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount charged on this invoice in the invoice currency. Includes sales tax, VAT, GST, or other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'The result of the three-way match verification comparing the invoice against the purchase order and goods receipt or service entry sheet. Critical control for payment authorization.. Valid values are `matched|quantity_variance|price_variance|not_matched|override_approved`',
    `total_payable_amount` DECIMAL(18,2) COMMENT 'The total amount payable to the vendor in the invoice currency. Calculated as gross amount plus tax minus discounts plus freight and other charges.',
    `vendor_invoice_number` STRING COMMENT 'The invoice number assigned by the vendor. This is the external invoice identifier printed on the vendors invoice document.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoice submitted for payment against a purchase order or service entry sheet, subject to three-way match verification (PO, GR/SES, invoice). Captures invoice number (vendor), SAP invoice document number, invoice date, vendor ID, PO reference, SES reference, invoice amount (USD), tax amount, total payable amount, currency, payment due date, payment terms, invoice status (received, under verification, approved, blocked, paid, disputed), three-way match status, blocking reason, and invoice receipt date. Distinct from revenue invoices owned by the revenue domain. Supports COPAS joint interest billing and AP processing.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `contract_id` BIGINT COMMENT 'Identifier of the contract under which this performance evaluation is conducted. May reference master service agreements, purchase orders, or project-specific contracts.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual who performed the evaluation. Links to HR employee master for audit trail.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor being evaluated. Links to the vendor master record in procurement system.',
    `approval_date` DATE COMMENT 'Date on which the vendor performance evaluation was formally approved by procurement management.',
    `approval_status` STRING COMMENT 'Workflow approval status of the performance evaluation. Indicates whether the evaluation has been reviewed and approved by procurement management.. Valid values are `draft|submitted|approved|rejected|under_review`',
    `approved_by_name` STRING COMMENT 'Name of the procurement manager or authorized approver who reviewed and approved the vendor performance evaluation.',
    `commercial_compliance_score` DECIMAL(18,2) COMMENT 'Score reflecting adherence to commercial terms including invoicing accuracy, payment terms compliance, contract change order management, and administrative responsiveness. Typically scored 0-100.',
    `contract_reference_number` STRING COMMENT 'External business reference number of the contract being evaluated (e.g., MSA number, AFE number, EPC contract number).',
    `corrective_action_plan_reference` STRING COMMENT 'Reference number or identifier of the corrective action plan document issued to the vendor. Links to formal improvement plan tracking system.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required from the vendor to address performance deficiencies identified during the evaluation.',
    `cost_competitiveness_score` DECIMAL(18,2) COMMENT 'Score reflecting vendor pricing competitiveness relative to market benchmarks and peer vendors. Typically scored 0-100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was first created in the system.',
    `defect_count` STRING COMMENT 'Total number of quality defects, non-conformances, or rejections recorded against vendor deliveries during the evaluation period.',
    `evaluation_comments` STRING COMMENT 'Free-text comments providing qualitative context, notable achievements, specific concerns, or recommendations for vendor performance improvement.',
    `evaluation_date` DATE COMMENT 'Date on which the performance evaluation was completed and finalized.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period. Defines the close of the measurement window for vendor KPIs.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period. Defines the beginning of the measurement window for vendor KPIs.',
    `evaluation_type` STRING COMMENT 'Type or frequency of the performance evaluation. Indicates whether this is a routine periodic review or event-driven assessment.. Valid values are `quarterly|annual|project_completion|ad_hoc|contract_renewal|incident_driven`',
    `evaluator_name` STRING COMMENT 'Name of the procurement or project professional who conducted the vendor performance evaluation.',
    `hse_incident_count` STRING COMMENT 'Total number of HSE incidents (recordable injuries, near misses, environmental releases, safety violations) attributed to the vendor during the evaluation period.',
    `hse_score` DECIMAL(18,2) COMMENT 'Composite HSE performance score based on incident frequency, severity, compliance with safety procedures, and proactive safety culture. Typically scored 0-100.',
    `invoice_accuracy_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of vendor invoices submitted without errors, discrepancies, or disputes requiring correction. Measures commercial process quality.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was last updated or modified.',
    `late_delivery_count` STRING COMMENT 'Total number of purchase orders or milestones delivered after the scheduled due date during the evaluation period.',
    `next_evaluation_due_date` DATE COMMENT 'Scheduled date for the next periodic vendor performance evaluation. Used to trigger evaluation workflow and ensure continuous vendor monitoring.',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of deliveries or milestones completed on or before the scheduled date during the evaluation period. Key performance indicator for schedule adherence.',
    `overall_performance_rating` STRING COMMENT 'Summary performance rating assigned to the vendor based on weighted evaluation of delivery, quality, HSE, and commercial compliance. Drives vendor qualification status and future sourcing decisions.. Valid values are `excellent|satisfactory|marginal|unsatisfactory|suspended`',
    `performance_trend` STRING COMMENT 'Directional trend of vendor performance compared to prior evaluation periods. Indicates whether performance is improving, stable, or declining over time.. Valid values are `improving|stable|declining|insufficient_data`',
    `quality_acceptance_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of delivered goods or services that passed quality inspection on first submission without rework or rejection. Measures conformance to specifications.',
    `recommendation` STRING COMMENT 'Evaluator recommendation for future engagement with the vendor. Drives vendor qualification renewal and approved vendor list maintenance.. Valid values are `continue|continue_with_monitoring|corrective_action_required|probation|disqualify|suspend`',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Score reflecting vendor responsiveness to inquiries, change requests, and issue resolution. Typically scored 0-100 based on turnaround time and communication quality.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score assessing vendor performance on environmental stewardship, social responsibility, and governance practices. Increasingly important for ESG reporting and responsible sourcing. Typically scored 0-100.',
    `technical_capability_score` DECIMAL(18,2) COMMENT 'Score assessing vendor technical competence, innovation, and ability to meet complex specifications. Relevant for EPC, FEED, and specialized service contractors. Typically scored 0-100.',
    `total_purchase_orders_evaluated` STRING COMMENT 'Total number of purchase orders or delivery events included in this evaluation period. Provides context for statistical significance of performance metrics.',
    `total_value_evaluated_usd` DECIMAL(18,2) COMMENT 'Total dollar value of goods and services procured from the vendor during the evaluation period, expressed in USD. Used to weight vendor importance in spend analytics.',
    `vendor_notification_date` DATE COMMENT 'Date on which the vendor was formally notified of the performance evaluation results.',
    `vendor_notified_flag` BOOLEAN COMMENT 'Indicates whether the vendor has been formally notified of the evaluation results and any required corrective actions.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation record assessing a vendors delivery, quality, HSE, and commercial performance against contracted KPIs. Captures evaluation ID, vendor ID, contract reference, evaluation period (from/to dates), evaluation type (quarterly, annual, project completion), on-time delivery rate (%), quality acceptance rate (%), HSE incident count, HSE score, commercial compliance score, overall performance rating (excellent, satisfactory, marginal, unsatisfactory), evaluator name, evaluation date, corrective action required flag, corrective action plan reference, and performance trend (improving, stable, declining). Feeds vendor qualification renewal decisions.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`material_requisition` (
    `material_requisition_id` BIGINT COMMENT 'Unique identifier for the material requisition record. Primary key for the material requisition entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Material requisitions for AFE-controlled projects need to validate against AFE budget availability before conversion to purchase requisition. This enables early-stage AFE budget control and prevents r',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Material requisitions request specific cataloged materials from the material master. This enables validation that requested materials exist, retrieval of material specifications, and standardization o',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or sole-source vendor for this material requisition, if specified by the requester or sourcing strategy.',
    `employee_id` BIGINT COMMENT 'Employee identifier or personnel number of the individual who created the material requisition.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Material requisitions for capital projects need WBS tracking for proper cost allocation and project material planning. Real operational need for drilling and completion material management.',
    `amended_material_requisition_id` BIGINT COMMENT 'Self-referencing FK on material_requisition (amended_material_requisition_id)',
    `account_assignment_category` STRING COMMENT 'Category indicating how the material requisition costs will be assigned in financial accounting, such as to a cost center, project WBS element, or asset.. Valid values are `cost_center|wbs_element|asset|sales_order`',
    `approval_date` DATE COMMENT 'Date when the material requisition was formally approved by the designated authority, allowing it to proceed to procurement.',
    `approver_name` STRING COMMENT 'Full name of the manager or authority who approved the material requisition for procurement processing.',
    `asset_number` STRING COMMENT 'Fixed asset number if the material requisition is for capital equipment or asset-related materials that will be capitalized.',
    `contract_reference_number` STRING COMMENT 'Reference number of an existing procurement contract or outline agreement under which this material requisition should be fulfilled.',
    `conversion_date` DATE COMMENT 'Date when the material requisition was converted into a purchase order or other procurement document.',
    `cost_center` STRING COMMENT 'Cost center code to which the material requisition costs will be charged for financial accounting and budget tracking purposes.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material requisition record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated pricing and financial values on the requisition.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Specific delivery address, warehouse, or field location where the requested materials should be delivered upon fulfillment.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the material requisition calculated as quantity requested multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated or budgeted unit price for the requested material at the time of requisition creation. Used for budget planning and approval thresholds.',
    `gl_account` STRING COMMENT 'General ledger account code to which the material costs will be posted for financial reporting and accounting purposes.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to the material requisition record. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or technical specifications related to the material requisition.',
    `plant_code` STRING COMMENT 'SAP plant code representing the organizational unit or facility for which the material is being requisitioned.',
    `priority` STRING COMMENT 'Priority level assigned to the material requisition indicating the urgency of fulfillment. Emergency priority triggers expedited procurement and approval workflows.. Valid values are `routine|high|urgent|emergency`',
    `procurement_category` STRING COMMENT 'High-level procurement category classification such as drilling services, oilfield equipment, refinery catalysts, or maintenance materials.',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated when the material requisition is converted to a purchase order for vendor fulfillment.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material being requested in the requisition, expressed in the base unit of measure for the material.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the approver if the material requisition was rejected, including corrective actions required for resubmission.',
    `requesting_department` STRING COMMENT 'Department or functional unit within the organization that initiated the material requisition.',
    `requesting_facility` STRING COMMENT 'Name or identifier of the facility, plant, field, or operational site that is requesting the materials.',
    `required_by_date` DATE COMMENT 'Target date by which the requested materials must be delivered to the requesting location to meet operational or project schedules.',
    `requisition_date` DATE COMMENT 'Date when the material requisition was created and submitted by the requesting party. Represents the business event timestamp for the requisition initiation.',
    `requisition_number` STRING COMMENT 'Business-facing unique requisition number assigned to the material request. Used for tracking and reference across procurement workflows.. Valid values are `^MR-[0-9]{8}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the material requisition indicating its position in the approval and fulfillment workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|in_procurement|partially_fulfilled|fulfilled|cancelled — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on the purpose and urgency of the material request. Determines approval workflow and sourcing strategy.. Valid values are `stock_replenishment|project_material|maintenance_spare|emergency|capital_equipment|consumable`',
    `requisitioner_email` STRING COMMENT 'Email address of the requisitioner for communication regarding the material requisition status and fulfillment.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requisitioner_name` STRING COMMENT 'Full name of the employee or contractor who created and submitted the material requisition.',
    `source_of_supply` STRING COMMENT 'Indicates whether the material will be sourced from existing warehouse inventory, requires new procurement, or is available through an existing contract or consignment arrangement.. Valid values are `warehouse_stock|new_procurement|contract|vendor_consignment`',
    `storage_location` STRING COMMENT 'Storage location code within the plant where the material will be received and stored after delivery.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity, such as barrels, cubic meters, kilograms, pieces, or feet.',
    CONSTRAINT pk_material_requisition PRIMARY KEY(`material_requisition_id`)
) COMMENT 'Internal material requisition record requesting specific materials, spare parts, or consumables from warehouse inventory or triggering a new procurement cycle. Captures requisition number, requesting facility, required-by date, material master reference, quantity, and urgency classification.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` (
    `warehouse_inventory_id` BIGINT COMMENT 'Unique identifier for the warehouse inventory record. Primary key for this master resource entity.',
    `material_master_id` BIGINT COMMENT 'FK to procurement.material_master',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Inventory management of petroleum products in tank farms, terminals, or storage facilities. Tracks commodity inventory separately from materials, enabling product quality tracking, blending operations',
    `previous_inventory_snapshot_id` BIGINT COMMENT 'Self-referencing FK on warehouse_inventory (previous_inventory_snapshot_id)',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on value and criticality. A = high value/critical, B = moderate, C = low value/non-critical. Drives cycle count frequency and inventory control rigor.. Valid values are `A|B|C`',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials. Critical for traceability of chemicals, catalysts, and materials with shelf life or quality certifications.',
    `bin_location` STRING COMMENT 'Physical bin, rack, or shelf location within the storage area where the material is stored. Supports warehouse picking and cycle counting operations.',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked from use due to quality inspection holds, damage, or regulatory restrictions.',
    `company_code` STRING COMMENT 'SAP company code for financial reporting and legal entity assignment.',
    `consignment_stock_flag` BOOLEAN COMMENT 'Indicates whether the inventory is consignment stock owned by the vendor but held at Oil Gas facilities. Ownership transfers only upon consumption.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory record was first created in the system.',
    `critical_spare_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as a critical spare part required to maintain production uptime. Drives higher safety stock levels and expedited procurement.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for inventory valuation. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|AUD|NOK|BRL|MXN — 8 candidates stripped; promote to reference product]',
    `h2s_service_flag` BOOLEAN COMMENT 'Indicates whether the material is rated for sour service (H2S environments). Critical for wellhead equipment, valves, and tubulars in sour gas fields.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and disposal procedures.',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently in transit to this warehouse from vendors or other storage locations.',
    `inventory_status` STRING COMMENT 'Current lifecycle status of the inventory record. Active = available for use, Obsolete = marked for disposal, Quarantine = under quality hold, Restricted = limited use authorization.. Valid values are `active|inactive|obsolete|quarantine|restricted`',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased inventory for this material at this location.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased inventory for this material at this location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inventory record was last updated.',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory movement (receipt, issue, or transfer) for this material at this location. Used to identify slow-moving or obsolete stock.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this material at this location.',
    `material_group_code` STRING COMMENT 'SAP material group classification code. Groups similar materials for procurement and reporting purposes (e.g., drilling consumables, tubulars, valves).',
    `material_number` STRING COMMENT 'Unique material identifier from SAP MM master data. Links to the material master catalog for detailed specifications.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_type` STRING COMMENT 'SAP material type classification. Common types: ROH (raw material), ERSA (spare parts), HAWA (trading goods), UNBW (non-valuated material). [ENUM-REF-CANDIDATE: ROH|HALB|FERT|HAWA|ERSA|UNBW|NLAG — 7 candidates stripped; promote to reference product]',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper limit for inventory quantity. Used to prevent overstocking and optimize working capital.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Moving average price per unit, recalculated with each goods receipt. Used for materials valued at moving average price.',
    `norm_flag` BOOLEAN COMMENT 'Indicates whether the material contains or has been exposed to naturally occurring radioactive material. Common in oilfield tubulars and equipment from certain formations.',
    `plant_code` STRING COMMENT 'SAP plant code representing the operational unit or business location associated with this inventory.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum stock level that triggers a replenishment purchase requisition. When stock quantity falls below this threshold, procurement action is initiated.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material reserved for specific work orders, AFE projects, or maintenance activities. Not available for general use.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer stock quantity maintained to protect against demand variability and supply chain disruptions. Critical for high-value drilling and completion equipment.',
    `serial_number` STRING COMMENT 'Serial number for serialized equipment and high-value assets. Enables individual item tracking and warranty management.',
    `shelf_life_expiration_date` DATE COMMENT 'Expiration date for materials with limited shelf life (chemicals, lubricants, seals, elastomers). Material should not be issued after this date.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the material in functional currency. Used for inventory valuation and variance analysis.',
    `stock_quantity` DECIMAL(18,2) COMMENT 'Current on-hand quantity of material available in the warehouse. Represents unrestricted usable stock.',
    `storage_location_code` STRING COMMENT 'SAP storage location code within the warehouse. Represents a specific area or zone within the facility.. Valid values are `^[A-Z0-9]{4,10}$`',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'Total value of on-hand inventory (stock quantity × unit cost). Represents the asset value for financial reporting.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for stock quantity. Common oil and gas units include barrels (BBL), feet (FT), meters (M), kilograms (KG), each (EA). [ENUM-REF-CANDIDATE: EA|FT|M|KG|LB|BBL|GAL|L|TON|MT|EACH|BOX|PALLET — 13 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'SAP valuation class that determines the general ledger account assignment for inventory postings.',
    `warehouse_code` STRING COMMENT 'Unique identifier for the warehouse, laydown yard, or material staging area where inventory is held.. Valid values are `^[A-Z0-9]{4,10}$`',
    `warehouse_name` STRING COMMENT 'Descriptive name of the warehouse or storage facility.',
    CONSTRAINT pk_warehouse_inventory PRIMARY KEY(`warehouse_inventory_id`)
) COMMENT 'Master record for materials and spare parts inventory held at Oil Gas warehouses, laydown yards, and material staging areas. Tracks stock quantity, reorder point, safety stock level, bin location, and last movement date.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'Unique identifier for the quality inspection lot record. Primary key for the inspection lot entity.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Inspection lots for materials received against AFE-controlled POs need to track AFE assignment for cost allocation of inspection activities and for rejected material cost handling. Currently has afe_n',
    `cargo_inspection_id` BIGINT COMMENT 'Foreign key linking to logistics.cargo_inspection. Business justification: Quality inspections of received materials (API specification verification, mill test reports, certificates of conformance) reference cargo inspections performed at load port or discharge terminal. Rea',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document that triggered this quality inspection.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the quality inspector who conducted the inspection, used for traceability and accountability.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being inspected.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Quality inspection of received petroleum products against specifications (API gravity, sulfur, viscosity). Critical for custody transfer, quality settlement, and acceptance decisions in commodity trad',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which the materials or equipment were received and inspected.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who supplied the materials or equipment being inspected.',
    `reinspection_lot_id` BIGINT COMMENT 'Self-referencing FK on inspection_lot (reinspection_lot_id)',
    `acceptance_criteria_reference` STRING COMMENT 'Reference to the technical specification, API standard, or quality requirement document that defines the acceptance criteria for this inspection.',
    `api_specification` STRING COMMENT 'Applicable API specification number for oilfield equipment and materials, such as API 5L for line pipe, API 5CT for casing and tubing, or API 6A for wellhead equipment.',
    `approval_date` DATE COMMENT 'Date on which the inspection results and disposition were formally approved.',
    `approver_name` STRING COMMENT 'Name of the quality manager or authorized person who approved the inspection results and disposition decision.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the materials being inspected, used for traceability.',
    `certificate_of_conformance_number` STRING COMMENT 'Reference number for the vendor-supplied certificate of conformance or certificate of compliance that attests materials meet specified requirements.',
    `corrective_action_reference` STRING COMMENT 'Reference number for the corrective action request or non-conformance report generated from this inspection.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicator of whether corrective action is required based on the inspection findings.',
    `cost_center` STRING COMMENT 'Cost center code for accounting assignment of inspection-related costs or material valuation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the inspection lot record was first created in the quality management system. Audit trail for record creation.',
    `defect_code` STRING COMMENT 'Standardized code or codes identifying the type of defects found, such as dimensional variance, material contamination, corrosion, or documentation discrepancies.',
    `defect_count` STRING COMMENT 'Total number of defects or non-conformances identified during the inspection.',
    `defect_description` STRING COMMENT 'Detailed narrative description of the defects or non-conformances identified during inspection.',
    `disposition` STRING COMMENT 'Decision on how to handle the inspected materials: accept for unrestricted use, reject and block from use, use as-is with deviation approval, rework to meet specifications, return to vendor for replacement, scrap if unusable, or quarantine pending further evaluation. [ENUM-REF-CANDIDATE: accept|reject|use_as_is|rework|return_to_vendor|scrap|quarantine — 7 candidates stripped; promote to reference product]',
    `h2s_service_flag` BOOLEAN COMMENT 'Indicator of whether the materials are certified for sour service in hydrogen sulfide environments, requiring special metallurgy and testing per NACE standards.',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification code if the inspected materials are hazardous, such as flammable liquids, corrosives, or toxic substances.',
    `inspection_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activities were completed.',
    `inspection_date` DATE COMMENT 'The date on which the quality inspection was performed. Principal business event timestamp for the inspection activity.',
    `inspection_lot_number` STRING COMMENT 'Business identifier for the inspection lot, typically generated by the quality management system.',
    `inspection_notes` STRING COMMENT 'Free-text notes and observations recorded by the inspector during the inspection process.',
    `inspection_plan_reference` STRING COMMENT 'Reference to the quality inspection plan or procedure document that defines the inspection criteria, sampling method, and acceptance standards.',
    `inspection_result` STRING COMMENT 'Overall outcome of the quality inspection: accepted when materials meet specifications, rejected when they fail, conditional acceptance when minor deviations exist, rework required when corrective action can resolve issues, or return to vendor when materials must be sent back.. Valid values are `accepted|rejected|conditional_acceptance|rework_required|return_to_vendor`',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activities commenced.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection lot: created when initiated, in progress during inspection activities, completed when inspection finished, approved when results accepted, rejected when materials fail inspection, or on hold when awaiting additional information.. Valid values are `created|in_progress|completed|approved|rejected|on_hold`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity: goods receipt inspection for incoming materials, in-process for production monitoring, final for completed products, source for vendor site inspection, periodic for scheduled equipment checks, or sample for statistical quality control.. Valid values are `goods_receipt|in_process|final|source|periodic|sample`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the inspection lot record was last updated. Audit trail for record changes.',
    `lot_size` DECIMAL(18,2) COMMENT 'Total quantity of materials or equipment in the inspection lot.',
    `mill_test_report_number` STRING COMMENT 'Reference number for the mill test report or material test certificate that documents the chemical composition and mechanical properties of steel or metal products.',
    `norm_flag` BOOLEAN COMMENT 'Indicator of whether the materials contain naturally occurring radioactive material, requiring special handling and disposal procedures.',
    `plant_code` STRING COMMENT 'Code identifying the receiving plant, facility, or warehouse where the inspection was performed.',
    `sample_size` DECIMAL(18,2) COMMENT 'Quantity of items or units selected for inspection from the lot, based on the sampling plan.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized equipment or components being inspected.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location or bin within the plant where inspected materials are stored.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the lot size and sample size, such as each, barrels, cubic meters, kilograms, or feet.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-related materials, enabling project cost tracking and reporting.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Quality inspection record for incoming materials and equipment received against purchase orders. Captures inspection date, inspector, inspection criteria, pass/fail result, defect codes, and disposition (accept, reject, return to vendor).';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`material_reservation` (
    `material_reservation_id` BIGINT COMMENT 'Unique identifier for the material reservation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Material reservations need cost center for expense planning, material cost allocation, and inventory accounting. Standard inventory management requirement for operational materials in oil & gas.',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE budget authorization for which materials are reserved. Critical for drilling, completion, and well construction activities.',
    `hierarchy_id` BIGINT COMMENT 'Reference to the asset or equipment for which materials are reserved, supporting asset maintenance and lifecycle management.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being reserved. Links to the specific material item such as drilling tubulars, completion equipment, refinery catalysts, or maintenance spare parts.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Reserving petroleum products from inventory for specific operations (blending campaigns, feedstock allocation, fuel supply). Enables production planning, blending optimization, and inventory allocatio',
    `project_id` BIGINT COMMENT 'Reference to the capital project or construction project for which materials are reserved. Null if reservation is for a work order or AFE instead.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who created the material reservation, used for audit trail and authorization verification.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well for which materials are reserved, particularly for drilling, completion, or workover operations.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance or operational work order for which materials are reserved. Null if reservation is for a project or AFE instead.',
    `previous_material_reservation_id` BIGINT COMMENT 'Self-referencing FK on material_reservation (previous_material_reservation_id)',
    `actual_issue_date` DATE COMMENT 'Actual date when the reserved materials were physically issued from inventory. Null if materials have not yet been issued.',
    `afe_number` STRING COMMENT 'Business identifier of the AFE budget authorization, used for joint venture billing and capital expenditure tracking in exploration and production operations.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the material reservation was cancelled, supporting audit trail and process improvement analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material reservation record was created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reservation value, supporting multi-currency operations and financial reporting.',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating the reservation has been marked for deletion and should not be processed for further goods issues.',
    `field_name` STRING COMMENT 'Name of the oil or gas field where the reserved materials will be used, supporting field-level cost tracking and operational reporting.',
    `final_issue_indicator` BOOLEAN COMMENT 'Flag indicating whether the reservation is marked for final issue, meaning no further goods movements are expected and the reservation can be closed.',
    `gl_account` STRING COMMENT 'General ledger account code to which the material value will be posted when issued, supporting financial accounting and reporting requirements.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has been physically issued against this reservation. Used to track partial fulfillment and remaining reserved quantity.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or automated process that last modified the material reservation record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the material reservation record was last modified, supporting audit trail and change tracking requirements.',
    `movement_type` STRING COMMENT 'SAP movement type code that will be used when materials are issued from the reservation, defining the inventory transaction type and accounting impact.',
    `planned_issue_date` DATE COMMENT 'Scheduled date when the reserved materials are expected to be physically issued from inventory to the requesting work order, project, or AFE activity.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the physical location or facility where the material is reserved and will be issued from inventory.',
    `priority` STRING COMMENT 'Priority level of the material reservation indicating urgency for material issue, used to sequence fulfillment when inventory is constrained.. Valid values are `critical|high|normal|low`',
    `project_number` STRING COMMENT 'Business identifier of the project consuming the reserved materials, used for CAPEX tracking and project cost control.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity of material still reserved but not yet issued. Calculated as reserved quantity minus issued quantity.',
    `remarks` STRING COMMENT 'Free-text notes or comments about the material reservation, providing additional context for operational users and planners.',
    `reservation_date` DATE COMMENT 'Date when the material reservation was created in the system. Represents the business event timestamp for reservation initiation.',
    `reservation_number` STRING COMMENT 'Business identifier for the material reservation, typically generated by SAP MM or CMMS system. Used for tracking and reference in operational workflows.',
    `reservation_status` STRING COMMENT 'Current lifecycle status of the material reservation indicating whether materials are still reserved, partially or fully issued to the requesting entity, or the reservation has been cancelled or closed.. Valid values are `open|partially_issued|fully_issued|cancelled|closed`',
    `reservation_type` STRING COMMENT 'Classification of the reservation based on the business purpose: work order maintenance, project construction, AFE-driven drilling or completion activities, or emergency response. [ENUM-REF-CANDIDATE: work_order|project|afe|maintenance|drilling|completion|construction|emergency — 8 candidates stripped; promote to reference product]',
    `reservation_value_usd` DECIMAL(18,2) COMMENT 'Total estimated value of the reserved materials in US dollars, calculated as reserved quantity multiplied by standard cost or moving average price.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material reserved for the specific work order, project, or AFE. Represents the amount committed from available inventory.',
    `storage_location` STRING COMMENT 'Storage location code within the plant where the reserved material is physically stored, such as warehouse, yard, or rig location.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the reserved quantity, such as barrels, cubic meters, kilograms, each, feet, or other industry-standard units.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-based reservations, enabling detailed project cost tracking and reporting.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created the material reservation record.',
    CONSTRAINT pk_material_reservation PRIMARY KEY(`material_reservation_id`)
) COMMENT 'Reservation of materials against a specific work order, project, or AFE before physical goods issue. Captures reservation number, material master reference, reserved quantity, movement type, and planned issue date.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for this approved vendor-material sourcing relationship. Primary key.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master record representing the procurable material',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record representing the approved supplier',
    `approved_value_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative purchase value allowed from this vendor for this material within the contract period. Used for contract compliance and spend management.',
    `approved_vendor_list_status` STRING COMMENT 'Current lifecycle status of this approved vendor list record. Controls whether this source can be used for new purchase orders.',
    `contract_reference_number` STRING COMMENT 'Reference number of the master service agreement, frame agreement, or purchase contract governing this vendor-material relationship.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this AVL record was created in the system.',
    `effective_date` DATE COMMENT 'Date from which this vendor-material sourcing relationship becomes effective and can be used for procurement.',
    `expiry_date` DATE COMMENT 'Date when this approved vendor-material relationship expires. After this date, the source cannot be used unless renewed.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this AVL record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this AVL record.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order issued to this vendor for this material. Used for vendor-material performance tracking and source list maintenance.',
    `lead_time_days` STRING COMMENT 'Number of days from purchase order issuance to material delivery for this vendor-material combination. Critical for MRP planning and inventory optimization.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer part number specific to this vendors supply of this material. May differ from the material master OEM number if vendor sources from multiple manufacturers.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from this vendor for this material in the base unit of measure. Vendor-material specific constraint.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred or primary source for this material. Used for automated source selection in procurement systems.',
    `price_currency` STRING COMMENT 'Three-letter ISO currency code for the unit price. May differ from vendors default payment currency.',
    `qualification_date` DATE COMMENT 'Date when this vendor was qualified to supply this specific material following technical and quality review.',
    `qualification_expiry_date` DATE COMMENT 'Date when the vendor-material qualification expires and requires renewal. Critical for compliance in regulated materials like H2S-service equipment.',
    `qualification_status` STRING COMMENT 'Current qualification status of this vendor to supply this specific material. Qualification is material-specific based on technical capability, quality audits, and HSE compliance.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this material from this vendor in the contract currency. Represents the most recent contract or spot price.',
    `vendor_material_number` STRING COMMENT 'The vendors internal part number or catalog number for this material. Used for purchase order line items and vendor communication.',
    `created_by` STRING COMMENT 'User ID or name of the procurement professional who created this AVL record.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'This association product represents the approved sourcing relationship between vendors and materials in the procurement domain. It captures vendor-material qualification, pricing agreements, lead times, and sourcing preferences that exist only in the context of this specific vendor-material combination. Each record represents one approved source for procuring a specific material from a qualified vendor, forming the foundation of strategic sourcing and supply chain risk management in oil and gas operations.. Existence Justification: In oil and gas procurement, the Approved Vendor List (AVL) is a core operational entity that procurement teams actively manage. Materials must be dual-sourced for supply security (especially offshore/remote operations), and vendor qualification is material-specific - a vendor qualified for drill bits may not be qualified for H2S-service valves. Each vendor-material combination has its own negotiated pricing, lead times, minimum order quantities, and qualification status that procurement professionals create, update, and monitor as part of strategic sourcing and supplier performance management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`project` (
    `project_id` BIGINT COMMENT 'Primary key for project',
    `employee_id` BIGINT COMMENT 'Identifier of the person responsible for overall project delivery.',
    `location_id` BIGINT COMMENT 'Identifier of the primary geographic location for the project.',
    `approval_date` DATE COMMENT 'Date when the project was formally approved.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the project.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the project.',
    `classification` STRING COMMENT 'Business classification that segments projects for reporting and governance.',
    `contract_type` STRING COMMENT 'Primary contract type governing the project.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code used for financial allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the project record was first created in the data lake.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values.',
    `project_description` STRING COMMENT 'Narrative description of the projects scope and objectives.',
    `effective_end_date` DATE COMMENT 'Date when the project agreement ends (nullable for open‑ended projects).',
    `effective_start_date` DATE COMMENT 'Date when the project agreement becomes binding.',
    `end_date` DATE COMMENT 'Date when work on the project was completed.',
    `environmental_impact_score` DECIMAL(18,2) COMMENT 'Quantitative score representing the projects environmental impact.',
    `governance_approval_date` DATE COMMENT 'Date when required governance approvals were obtained.',
    `is_governance_required` BOOLEAN COMMENT 'Indicates whether the project is subject to additional governance oversight.',
    `last_review_date` DATE COMMENT 'Date of the most recent project performance review.',
    `location_name` STRING COMMENT 'Human‑readable name of the project location.',
    `objectives` STRING COMMENT 'Key objectives and deliverables for the project.',
    `phase` STRING COMMENT 'Current phase of the project lifecycle.',
    `priority` STRING COMMENT 'Priority level assigned to the project for resource planning.',
    `procurement_strategy` STRING COMMENT 'Strategy used to acquire goods and services for the project.',
    `project_code` STRING COMMENT 'External reference code for the project as used in SAP and other systems.',
    `project_manager_name` STRING COMMENT 'Full name of the project manager.',
    `project_name` STRING COMMENT 'Human‑readable name of the project.',
    `project_type` STRING COMMENT 'Category of the project indicating its financial and operational nature.',
    `region` STRING COMMENT 'Geographic region where the project is situated.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with industry regulations.',
    `review_cycle` STRING COMMENT 'Frequency at which the project is reviewed.',
    `risk_level` STRING COMMENT 'Overall risk rating of the project.',
    `spend_currency_code` STRING COMMENT 'ISO 4217 currency code for spend amounts.',
    `sponsor_name` STRING COMMENT 'Name of the sponsoring organization or business unit.',
    `start_date` DATE COMMENT 'Date when work on the project actually commenced.',
    `project_status` STRING COMMENT 'Current lifecycle status of the project.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Cumulative actual spend incurred to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the project record.',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`procurement`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `address_line1` STRING COMMENT 'Primary street address of the location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total usable floor area of the location in square feet.',
    `city` STRING COMMENT 'City where the location is situated.',
    `location_code` STRING COMMENT 'External reference code used in ERP and procurement systems (e.g., SAP location code).',
    `contact_email` STRING COMMENT 'Primary email address for the locations point of contact.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the locations point of contact.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code responsible for expenses incurred at the location.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the location.',
    `created_by_user_id` BIGINT COMMENT 'User identifier of the person who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the location record was first created in the data lake.',
    `data_source` STRING COMMENT 'Name of the source system that supplied the location data (e.g., SAP_MM).',
    `location_description` STRING COMMENT 'Free‑form textual description of the locations purpose or characteristics.',
    `effective_from` DATE COMMENT 'Date when the location became operational or was officially opened.',
    `effective_until` DATE COMMENT 'Date when the location ceased operations or is scheduled for closure (nullable).',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the site above sea level, expressed in meters.',
    `environmental_permit_number` STRING COMMENT 'Regulatory permit identifier authorizing operations at the location.',
    `external_system_id` STRING COMMENT 'Identifier of the location record in the source ERP or GIS system.',
    `geo_region_code` STRING COMMENT 'Standardized code representing the broader geographic region.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_headquarters` BOOLEAN COMMENT 'Indicates whether the location serves as a corporate headquarters.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `location_name` STRING COMMENT 'Human‑readable name of the facility, site, rig, or office.',
    `operational_status` STRING COMMENT 'Current operational condition of the location.',
    `owner_department` STRING COMMENT 'Business unit or department that owns the location.',
    `parent_location_id` BIGINT COMMENT 'Identifier of the parent location in a hierarchical geography (e.g., region → site).',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the environmental permit.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the location.',
    `production_capacity_bbl_per_day` DECIMAL(18,2) COMMENT 'Maximum oil production capacity of the site, measured in barrels per day.',
    `region` STRING COMMENT 'Broad geographic region (e.g., North America, Middle East).',
    `safety_rating` STRING COMMENT 'Internal safety performance rating for the location.',
    `state_province` STRING COMMENT 'State or province of the location.',
    `location_status` STRING COMMENT 'Current lifecycle state of the location.',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the location (e.g., America/Chicago).',
    `location_type` STRING COMMENT 'Category of the location indicating its operational role.',
    `updated_by_user_id` BIGINT COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the location record.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master reference table for location. Referenced by location_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `oil_gas_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `oil_gas_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `oil_gas_ecm`.`procurement`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ADD CONSTRAINT `fk_procurement_contract_amendment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `oil_gas_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_amended_material_requisition_id` FOREIGN KEY (`amended_material_requisition_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ADD CONSTRAINT `fk_procurement_warehouse_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ADD CONSTRAINT `fk_procurement_warehouse_inventory_previous_inventory_snapshot_id` FOREIGN KEY (`previous_inventory_snapshot_id`) REFERENCES `oil_gas_ecm`.`procurement`.`warehouse_inventory`(`warehouse_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `oil_gas_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_reinspection_lot_id` FOREIGN KEY (`reinspection_lot_id`) REFERENCES `oil_gas_ecm`.`procurement`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`procurement`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_previous_material_reservation_id` FOREIGN KEY (`previous_material_reservation_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_reservation`(`material_reservation_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_location_id` FOREIGN KEY (`location_id`) REFERENCES `oil_gas_ecm`.`procurement`.`location`(`location_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `oil_gas_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_date` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `business_category` SET TAGS ('dbx_business_glossary_term' = 'Business Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `copas_classification` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `hse_rating` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Rating');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `hse_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|disqualified|under_review|expired');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'contractor|supplier|service_provider|epc_firm|feed_contractor|consultant');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `api_certification_numbers` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Certification Numbers');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_scope` SET TAGS ('dbx_business_glossary_term' = 'Approval Scope');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_scope` SET TAGS ('dbx_value_regex' = 'global|regional|asset-specific|project-specific');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_assets` SET TAGS ('dbx_business_glossary_term' = 'Approved Assets');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_regions` SET TAGS ('dbx_business_glossary_term' = 'Approved Regions');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_value_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Value Limit (United States Dollar - USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending removal');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `background_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `commodity_category_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `commodity_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `commodity_category_name` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Email Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `hse_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_coverage_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Verified Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_certification_number` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 14001 Certification Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_certification_number` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 45001 Certification Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_certification_number` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certification Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `overall_qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_reference_number` SET TAGS ('dbx_value_regex' = '^VQ-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'pre-qualification|full qualification|re-qualification|conditional qualification|expedited qualification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not screened');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `scope_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `strategic_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Vendor Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `technical_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `api_specification` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Specification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `batch_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `copas_material_classification` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Material Classification Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `copas_material_classification` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `critical_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `h2s_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Service Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `height_m` SET TAGS ('dbx_business_glossary_term' = 'Height in Meters (M)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `hts_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Inspection Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time in Days');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `length_m` SET TAGS ('dbx_business_glossary_term' = 'Length in Meters (M)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|obsolete|pending_approval');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `norm_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `plant_specific_status` SET TAGS ('dbx_business_glossary_term' = 'Plant-Specific Material Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|in_house|both');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_value_regex' = 'none|mandatory|optional');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ALTER COLUMN `width_m` SET TAGS ('dbx_business_glossary_term' = 'Width in Meters (M)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|project|asset|sales_order|network');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `afe_number` SET TAGS ('dbx_value_regex' = '^AFE-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^ASSET-[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^CNT-[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion to Purchase Order Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material or Service Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency|critical');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^PROJ-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requisition Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'material|service|capital_equipment|rental|subcontract|consumable');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Email Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply Recommendation');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Buyer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `bid_bond_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `bid_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `bid_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Opening Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `bid_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Deadline');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `bids_received_count` SET TAGS ('dbx_business_glossary_term' = 'Bids Received Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `commercial_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Weight Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_price|cost_plus|time_and_materials|framework');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `evaluation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'lowest_price|best_value|bafo|technical_merit|life_cycle_cost');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Issue Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'open_tender|selective_tender|sole_source|emergency|framework_agreement|two_stage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope of Supply Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `technical_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `technical_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Weight Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `vendors_invited_count` SET TAGS ('dbx_business_glossary_term' = 'Vendors Invited Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period in Months');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bid Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluated By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `bid_bond_reference` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `bid_document_url` SET TAGS ('dbx_business_glossary_term' = 'Bid Document Uniform Resource Locator (URL)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `combined_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Combined Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `commercial_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `exceptions_and_deviations` SET TAGS ('dbx_business_glossary_term' = 'Exceptions and Deviations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `hse_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Plan Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `quoted_total_value` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `technical_compliance_statement` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Statement');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `technical_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity End Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity Start Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_value_regex' = 'draft|open|partially_delivered|fully_delivered|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|emergency|subcontract|service');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value United States Dollar (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|wbs_element|asset|order|project');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|cancelled');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'not_invoiced|partially_invoiced|fully_invoiced|blocked');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Item Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|third_party|stock_transfer');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `line_item_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Line Item Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Inspector Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_conformance_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (COC) Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_conformance_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_value_regex' = 'acceptable|damaged|rejected|partial|quarantine|inspection_required');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending|blocked');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `h2s_service_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Service Certification Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `norm_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Inspection Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Supervisor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `port_call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `rig_id` SET TAGS ('dbx_business_glossary_term' = 'Rig ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_date` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_number` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_number` SET TAGS ('dbx_value_regex' = '^SES-[0-9]{8,12}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_status` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `ses_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled|posted');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `total_service_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Service Value (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `unit_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{6,24}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'drilling_services|oilfield_equipment|refinery_catalysts|maintenance_materials|engineering_services|construction_services');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|suspended|pending_approval');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_supply_agreement|blanket_purchase_agreement|rig_contract|epc_contract|feed_contract|service_agreement');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Day Rate (United States Dollar - USD per Day)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `day_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `demobilization_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Fee (United States Dollar - USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `demobilization_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|expert_determination');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `early_termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Clause');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `liquidated_damages_clause` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Clause');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `mobilization_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Fee (United States Dollar - USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `mobilization_fee_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `npt_penalty_provisions` SET TAGS ('dbx_business_glossary_term' = 'Non-Productive Time (NPT) Penalty Provisions');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `operating_area` SET TAGS ('dbx_business_glossary_term' = 'Operating Area');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `performance_bond_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Value (United States Dollar - USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `performance_bond_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Mechanism');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `sap_outline_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Outline Agreement Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `sap_outline_agreement_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `scope_of_work_summary` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work Summary');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `standby_rate_usd` SET TAGS ('dbx_business_glossary_term' = 'Standby Rate (United States Dollar - USD per Day)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `standby_rate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contract Title');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `value_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Value (United States Dollar - USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ALTER COLUMN `well_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Well Program Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `contract_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Amendment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Change Initiator Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `afe_revision_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Revision Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Amendment Document Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|executed|cancelled');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|value_change|schedule_extension|price_adjustment|termination_for_convenience|force_majeure');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `amendment_value` SET TAGS ('dbx_business_glossary_term' = 'Amendment Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `joint_venture_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `joint_venture_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `moc_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Management of Change (MOC) Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `price_adjustment_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Basis');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `reason_for_amendment` SET TAGS ('dbx_business_glossary_term' = 'Reason for Amendment');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `revised_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Revised Total Contract Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `termination_for_convenience_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination for Convenience Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `termination_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Termination Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `vendor_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acceptance Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Budget ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend to Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|active|closed|cancelled');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_title` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Title');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `afe_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `budget_variance` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) or Operating Expenditure (OPEX) Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `capex_opex_classification` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Committed Spend to Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `completion_equipment_budget` SET TAGS ('dbx_business_glossary_term' = 'Completion Equipment Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `contingency_budget` SET TAGS ('dbx_business_glossary_term' = 'Contingency Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `drilling_services_budget` SET TAGS ('dbx_business_glossary_term' = 'Drilling Services Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `epc_budget` SET TAGS ('dbx_business_glossary_term' = 'Engineering Procurement and Construction (EPC) Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `feed_budget` SET TAGS ('dbx_business_glossary_term' = 'Front-End Engineering Design (FEED) Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field or Asset Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `jib_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `net_afe_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Authorization for Expenditure (AFE) Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `previous_afe_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `tubulars_budget` SET TAGS ('dbx_business_glossary_term' = 'Tubulars Budget');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `working_interest` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `demurrage_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Claim Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet (SES) ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `voyage_id` SET TAGS ('dbx_business_glossary_term' = 'Voyage Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment|final');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `jib_indicator` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|eft');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `sap_invoice_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Invoice Document Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|override_approved');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `total_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payable Amount');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Evaluation ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|under_review');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `commercial_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Compliance Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `cost_competitiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'quarterly|annual|project_completion|ad_hoc|contract_renewal|incident_driven');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `hse_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `hse_score` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `late_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `next_evaluation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Evaluation Due Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|marginal|unsatisfactory|suspended');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_trend` SET TAGS ('dbx_business_glossary_term' = 'Performance Trend');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining|insufficient_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_acceptance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Vendor Recommendation');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `recommendation` SET TAGS ('dbx_value_regex' = 'continue|continue_with_monitoring|corrective_action_required|probation|disqualify|suspend');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Sustainability Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `technical_capability_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Capability Score');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_purchase_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders Evaluated');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_value_evaluated_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Value Evaluated United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_value_evaluated_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notified Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `material_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `amended_material_requisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|wbs_element|asset|sales_order');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|emergency');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requesting_facility` SET TAGS ('dbx_business_glossary_term' = 'Requesting Facility');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^MR-[0-9]{8}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requisition Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'stock_replenishment|project_material|maintenance_spare|emergency|capital_equipment|consumable');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Email Address');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'warehouse_stock|new_procurement|contract|vendor_consignment');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `warehouse_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Inventory ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `previous_inventory_snapshot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `consignment_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `h2s_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Service Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|quarantine|restricted');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `norm_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Stock Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `cargo_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Inspection Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `reinspection_lot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `acceptance_criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `api_specification` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Specification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `certificate_of_conformance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (COC) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Material Disposition');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `h2s_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide (H2S) Service Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'accepted|rejected|conditional_acceptance|rework_required|return_to_vendor');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'created|in_progress|completed|approved|rejected|on_hold');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|in_process|final|source|periodic|sample');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `mill_test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Mill Test Report (MTR) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `norm_flag` SET TAGS ('dbx_business_glossary_term' = 'Naturally Occurring Radioactive Material (NORM) Flag');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `material_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Material Reservation Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `previous_material_reservation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `actual_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Issue Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `final_issue_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Issue Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `planned_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Issue Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'open|partially_issued|fully_issued|cancelled|closed');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reservation_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Reservation Value United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.material_master');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'AVL Record ID');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List - Material Master Id');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_value_limit` SET TAGS ('dbx_business_glossary_term' = 'Approved Purchase Value Limit');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_status` SET TAGS ('dbx_business_glossary_term' = 'AVL Record Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'AVL Effective Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'AVL Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Timestamp');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'OEM Part Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Source Indicator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor-Material Qualification Status');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `oil_gas_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `oil_gas_ecm`.`procurement`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`project` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `oil_gas_ecm`.`procurement`.`project` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`procurement`.`location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
