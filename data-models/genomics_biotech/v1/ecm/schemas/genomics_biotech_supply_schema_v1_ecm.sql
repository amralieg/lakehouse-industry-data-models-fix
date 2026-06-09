-- Schema for Domain: supply | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`supply` COMMENT 'Manages the end-to-end supply chain for raw materials, components, and finished goods — including supplier master data, procurement, purchase orders, inbound logistics, warehouse inventory, demand planning, cold-chain handling, and distribution. Integrates SAP MM for procurement and inventory management. Supports COGS visibility and ensures uninterrupted supply of critical genomics inputs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record. Primary key.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to commercial.channel_partner. Business justification: Genomics suppliers often also act as distribution partners (resellers, OEM partners). Business process: consolidated vendor management, partner-supplier dual relationship tracking, unified performance',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Suppliers of regulated materials must maintain FDA establishment registration and device listing. Required for supplier qualification audits, regulatory compliance verification, and supply chain trace',
    `approved_by` STRING COMMENT 'Name or identifier of the quality assurance manager or procurement director who approved the supplier.',
    `approved_date` DATE COMMENT 'Date when the supplier was formally approved for procurement following qualification and quality system assessment.',
    `blocked_for_purchasing` BOOLEAN COMMENT 'Indicates whether new purchase orders are blocked for this supplier due to quality issues, compliance violations, or financial concerns.',
    `blocking_reason` STRING COMMENT 'Business reason for blocking purchasing activity with this supplier (e.g., quality hold, financial distress, regulatory non-compliance, contract dispute).',
    `classification` STRING COMMENT 'Business classification tier indicating the suppliers qualification status and procurement priority. GMP (Good Manufacturing Practice)-qualified suppliers meet regulatory standards for genomics manufacturing.. Valid values are `gmp_qualified|preferred|approved|conditional|probationary|blocked`',
    `cold_chain_capable` BOOLEAN COMMENT 'Indicates whether the supplier has validated cold-chain logistics capabilities required for temperature-sensitive reagents and biological materials used in genomics workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for transactions with this supplier.. Valid values are `^[A-Z]{3}$`',
    `diversity_classification` STRING COMMENT 'Supplier diversity program classification (e.g., minority-owned, women-owned, veteran-owned, small business). [ENUM-REF-CANDIDATE: minority_owned|women_owned|veteran_owned|small_business|disadvantaged_business|lgbtq_owned|disability_owned|none — promote to reference product]',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier for the supplier entity, used for credit assessment and supplier risk management.. Valid values are `^[0-9]{9}$`',
    `gmp_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid GMP (Good Manufacturing Practice) certification required for supplying materials used in regulated genomics products.',
    `headquarters_address_line1` STRING COMMENT 'First line of the suppliers headquarters street address.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the suppliers headquarters street address (suite, building, floor).',
    `headquarters_city` STRING COMMENT 'City where the suppliers headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the suppliers headquarters location.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the suppliers headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State or province where the suppliers headquarters is located.',
    `iso_13485_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 13485 certification for medical device quality management systems, required for suppliers of IVD (In Vitro Diagnostic) components.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 9001 quality management system certification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier quality audit or site inspection conducted by Genomics Biotech quality assurance (QA) team.',
    `legal_name` STRING COMMENT 'Full legal registered name of the supplier entity as it appears on contracts and regulatory filings.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the supplier relationship in the procurement system.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum purchase order value required by the supplier, in the suppliers currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was last updated.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier quality audit based on risk tier and audit frequency policy.',
    `notes` STRING COMMENT 'Free-text field for additional supplier information, special handling instructions, or procurement guidance.',
    `on_time_delivery_percentage` DECIMAL(18,2) COMMENT 'Rolling 12-month percentage of purchase orders delivered on or before the requested delivery date. Key performance indicator (KPI) for supplier performance management.',
    `payment_method` STRING COMMENT 'Preferred payment instrument for remitting payment to the supplier. ACH (Automated Clearing House) is the standard electronic payment method.. Valid values are `ach|wire_transfer|check|credit_card|letter_of_credit`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the payment schedule and conditions for this supplier (e.g., NET30, NET60, 2/10NET30).. Valid values are `^[A-Z0-9]{2,6}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the supplier for procurement communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization for procurement and supply chain coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the supplier business contact.',
    `quality_rating` STRING COMMENT 'Current quality performance rating based on QC (Quality Control) results, COA (Certificate of Analysis) compliance, and nonconformance history.. Valid values are `excellent|good|acceptable|marginal|unacceptable`',
    `risk_tier` STRING COMMENT 'Supply chain risk classification based on business continuity impact, single-source dependency, geographic risk, and financial stability. Critical tier indicates suppliers of materials with no qualified alternative source.. Valid values are `low|medium|high|critical`',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the sole qualified source for one or more critical materials or components, representing elevated supply chain risk.',
    `standard_lead_time_days` STRING COMMENT 'Typical number of calendar days from purchase order placement to delivery for standard items from this supplier. Used for demand planning and inventory management.',
    `supplier_type` STRING COMMENT 'Primary category of goods or services provided by the supplier. OEM (Original Equipment Manufacturer) indicates suppliers of sequencing instruments and genomics equipment. [ENUM-REF-CANDIDATE: raw_material|reagent|consumable|component|equipment|service|contract_manufacturer|distributor|oem — 9 candidates stripped; promote to reference product]',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the supplier entity (e.g., EIN, VAT number).',
    `termination_date` DATE COMMENT 'Date when the supplier relationship was formally terminated or the supplier status was changed to inactive.',
    `trade_name` STRING COMMENT 'Commercial or doing-business-as name used by the supplier in day-to-day operations.',
    `vendor_code` STRING COMMENT 'External business identifier for the supplier as maintained in SAP MM vendor master. Used across procurement and supply chain operations.. Valid values are `^[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all suppliers and vendors providing raw materials, reagents, components, and services to Genomics Biotech. Captures supplier identity, classification (GMP-qualified, preferred, approved, conditional), regulatory certifications (ISO 13485, GMP), contact hierarchy, geographic footprint, payment terms, lead time profiles, and risk tier. SSOT for supplier identity across procurement and supply chain operations. Sourced from SAP MM vendor master.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`material` (
    `material_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: IVD reagents, kits, and devices require regulatory approval (510k, CE mark, etc.) before clinical use. Essential for material master compliance verification, QC release decisions, and ensuring only ap',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Materials that are also commercial products (finished goods, spare parts, consumables) should reference the product catalog. This links supply chain material master to commercial product catalog, enab',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: Medical devices and IVD products require UDI assignment for FDA GUDID submission and EU MDR compliance. Direct link needed for automated labeling generation, regulatory reporting, and traceability req',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: High-value equipment (sequencers, mass spectrometers, bioreactors) are procured as materials but capitalized as fixed assets. Links procurement records to asset register for depreciation and asset lif',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Gene-specific reagents (targeted panels, CRISPR guides, gene expression assays) are designed against specific gene models. Material specifications must reference gene targets for clinical validation d',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Genomic reagents (primers, probes, NGS controls) are designed for specific reference genomes. Material master must track target genome build for assay compatibility validation, QC release decisions, a',
    `glossary_term_id` BIGINT COMMENT 'Foreign key linking to data.glossary_term. Business justification: Materials reference standardized terminology for regulatory submissions, data sharing, and interoperability (e.g., "genomic DNA", "NGS library", "CRISPR reagent"). Real business process: regulatory do',
    `metadata_schema_id` BIGINT COMMENT 'Foreign key linking to data.metadata_schema. Business justification: Materials representing genomic datasets, sequencing kits, or array products require metadata schemas for FAIR compliance and data submission to repositories (SRA, EGA, dbGaP). Real business process: g',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management based on consumption value or criticality. A=High value/critical, B=Medium value/importance, C=Low value/routine. Sourced from SAP MM Material Master (MARC-ABCIN).. Valid values are `A|B|C`',
    `base_unit_of_measure` STRING COMMENT 'Base unit in which stock of the material is managed (e.g., EA=Each, L=Liter, KG=Kilogram, ML=Milliliter). Sourced from SAP MM Material Master (MARA-MEINS).. Valid values are `^[A-Z]{2,3}$`',
    `batch_management_required` BOOLEAN COMMENT 'Indicates whether the material requires batch/lot number tracking for traceability and quality control. True for reagents, consumables, and materials subject to expiration or quality testing. Sourced from SAP MM Material Master (MARA-XCHPF).',
    `bom_relevance` BOOLEAN COMMENT 'Indicates whether this material is relevant for BOM (Bill of Materials) explosion and production planning. True if material is a component or assembly used in manufacturing.',
    `cas_number` STRING COMMENT 'Unique CAS Registry Number for chemical substances. Required for chemical inventory reporting and regulatory compliance (e.g., REACH, TSCA).. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `coa_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must be provided by the supplier for each lot/batch of this material. True for reagents, chemicals, and biological materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was created. Sourced from SAP MM Material Master (MARA-ERSDA).',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether the material is flagged for deletion. True if material is marked for archival and removal from active use. Sourced from SAP MM Material Master (MARA-LVORM).',
    `gmp_classification` STRING COMMENT 'Indicates whether the material is subject to GMP regulations. GMP=GMP-regulated material, NON_GMP=Not subject to GMP, GMP_CRITICAL=Critical GMP material requiring enhanced controls.. Valid values are `GMP|NON_GMP|GMP_CRITICAL`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the material including packaging in kilograms. Used for logistics planning and freight calculation. Sourced from SAP MM Material Master (MARA-BRGEW).',
    `hazard_class` STRING COMMENT 'Classification of material hazard level per GHS (Globally Harmonized System) for chemical safety and handling (e.g., Flammable Liquid Category 2, Acute Toxicity Category 3, Corrosive). Required for SDS (Safety Data Sheet) compliance.',
    `industry_sector` STRING COMMENT 'Industry sector classification for the material (e.g., P=Pharmaceuticals, C=Chemicals, M=Mechanical Engineering). Sourced from SAP MM Material Master (MARA-MBRSH).. Valid values are `^[A-Z]{1}$`',
    `last_modified_by` STRING COMMENT 'User ID of the person who last modified the material master record. Sourced from SAP MM Material Master (MARA-AENAM).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the material master record was last modified. Sourced from SAP MM Material Master (MARA-LAEDA).',
    `lot_size_procedure` STRING COMMENT 'Procedure for calculating lot size in procurement and production (e.g., EX=Lot-for-lot, FX=Fixed lot size, HB=Replenishment to maximum stock level). Sourced from SAP MM Material Master (MARC-DISLS).. Valid values are `^[A-Z]{2}$`',
    `manufacturer_part_number` STRING COMMENT 'Original manufacturers part number or catalog number for the material. Used for cross-referencing and supplier communication.',
    `material_description` STRING COMMENT 'Short text description of the material for identification and reporting purposes. Sourced from SAP MM Material Master (MAKT-MAKTX).',
    `material_group` STRING COMMENT 'Grouping code for materials with similar characteristics for procurement and inventory management. Sourced from SAP MM Material Master (MARA-MATKL).. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Externally-known unique material number used across procurement, manufacturing, and sales. Sourced from SAP MM Material Master (MARA-MATNR).. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record. ACTIVE=Available for use, INACTIVE=Temporarily unavailable, BLOCKED=Blocked for procurement/production, OBSOLETE=Phased out, PENDING_APPROVAL=Awaiting approval for release.. Valid values are `ACTIVE|INACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL`',
    `mrp_type` STRING COMMENT 'MRP procedure used for planning this material (e.g., PD=MRP, VB=Manual reorder point, ND=No planning). Sourced from SAP MM Material Master (MARC-DISMM).. Valid values are `^[A-Z0-9]{2}$`',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the material excluding packaging in kilograms. Sourced from SAP MM Material Master (MARA-NTGEW).',
    `procurement_type` STRING COMMENT 'Defines how the material is procured. E=External procurement (purchased), F=In-house production (manufactured), X=Both external and in-house. Sourced from SAP MM Material Master (MARC-BESKZ).. Valid values are `E|F|X`',
    `product_hierarchy` STRING COMMENT 'Hierarchical classification code for grouping materials into product families and categories for sales and marketing analysis. Sourced from SAP MM Material Master (MARA-PRDHA).. Valid values are `^[A-Z0-9]{5,18}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming goods of this material must undergo quality inspection before release to unrestricted stock. True for GMP-critical materials and reagents. Sourced from SAP QM Quality Management (MARC-QMATV).',
    `regulatory_status` STRING COMMENT 'Regulatory classification of the material. RUO=Research Use Only, IVD=In Vitro Diagnostic (FDA-cleared), CE_IVD=CE-marked IVD (EU), LDT=Laboratory Developed Test, INVESTIGATIONAL=Under clinical investigation.. Valid values are `RUO|IVD|CE_IVD|LDT|INVESTIGATIONAL`',
    `remaining_shelf_life_days` STRING COMMENT 'Minimum remaining shelf life in days required at goods receipt. Materials with shorter remaining shelf life are rejected. Sourced from SAP MM Material Master (MARA-MHDRZ).',
    `serial_number_profile` STRING COMMENT 'Profile defining serial number management requirements for the material. Used for instruments, flow cells, and high-value components requiring individual tracking. Sourced from SAP MM Material Master (MARA-SERNP).. Valid values are `^[A-Z0-9]{4}$`',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the material in days from manufacturing date. Used for expiration date calculation and inventory rotation (FEFO - First Expired First Out). Sourced from SAP MM Material Master (MARA-MHDHB).',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the material including temperature range, humidity, and light exposure requirements (e.g., -20°C to -80°C for frozen reagents, 2°C to 8°C for refrigerated items, room temperature for stable materials).',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for cold-chain and temperature-sensitive materials. Critical for reagent stability and quality assurance.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for cold-chain and temperature-sensitive materials. Critical for reagent stability and quality assurance.',
    `un_number` STRING COMMENT 'Four-digit UN number for hazardous materials used in international transport and shipping documentation (e.g., UN1170 for ethanol).. Valid values are `^UN[0-9]{4}$`',
    `valid_from_date` DATE COMMENT 'Date from which the material master record is valid and available for transactions. Used for new product introductions and material master effective dating.',
    `valid_to_date` DATE COMMENT 'Date until which the material master record is valid. Used for material phase-out and obsolescence management. Null for materials with indefinite validity.',
    `volume_liters` DECIMAL(18,2) COMMENT 'Volume of the material in liters. Used for storage space planning and logistics. Sourced from SAP MM Material Master (MARA-VOLUM).',
    `created_by` STRING COMMENT 'User ID of the person who created the material master record. Sourced from SAP MM Material Master (MARA-ERNAM).',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master record for all materials managed within the supply chain — including raw chemicals, biological reagents, flow cell components, array substrates, packaging materials, and finished goods SKUs. Captures material number, description, material type (ROH, HALB, FERT), base unit of measure, storage conditions (cold-chain temperature range, hazard class), shelf life, GMP classification, BOM relevance, and regulatory status (RUO, IVD). Sourced from SAP MM Material Master (MARA/MARC).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record. Primary key.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: POs consume budget allocations; procurement verifies budget availability before issuing orders for reagents/equipment. Enables budget compliance tracking and variance analysis in genomics operations.',
    `material_id` BIGINT COMMENT 'Reference to the material or service being procured on this purchase order line. Links to material master data.',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Purchase orders must comply with MDM policies governing supplier master data quality, procurement authorization limits, and data governance standards. Real business process: PO approval workflow valid',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Capital equipment demo units, evaluation instruments, or beta-test reagents are procured via POs tied to specific sales opportunities. Business process: demo asset cost allocation, opportunity ROI tra',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO requisitioner tracking required for approval workflows, budget accountability, and SOX/GxP audit trails. Replaces denormalized requisitioner_name text field with proper FK for personnel accountab',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) who will fulfill this purchase order. Links to supplier master data.',
    `approval_date` DATE COMMENT 'Date when the purchase order was approved by authorized personnel. Marks transition from draft to committed procurement.',
    `approved_by` STRING COMMENT 'Name or user ID of the person who approved the purchase order. Supports audit trail and Sarbanes-Oxley (SOX) compliance.',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after full receipt and invoice verification. Marks end of procurement lifecycle.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the supplier for delivery. May differ from ordered quantity based on supplier availability.',
    `cost_center` STRING COMMENT 'Cost center to which the purchase order expense will be charged. Enables Research and Development (R&D) vs. Cost of Goods Sold (COGS) allocation.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Requested or confirmed delivery date for the purchase order line item. Critical for production planning and inventory management.',
    `general_ledger_account` STRING COMMENT 'General ledger account number for financial posting of the purchase order expense. Supports Profit and Loss (P&L) and balance sheet reporting.. Valid values are `^[0-9]{6,10}$`',
    `gmp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this purchase order is subject to Good Manufacturing Practice (GMP) regulations. True for materials used in In Vitro Diagnostic (IVD) or Clinical Laboratory Improvement Amendments (CLIA) products.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Indicates whether goods receipt posting is required for this purchase order line. True for physical materials, false for services.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and supplier (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Indicates whether invoice verification is required for this purchase order line. Controls accounts payable workflow.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Establishes ordering and uniqueness of line items within the PO.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was last modified. Audit trail for record updates.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value of the purchase order line item (ordered quantity × unit price), excluding tax and freight. Contributes to total PO value and Cost of Goods Sold (COGS).',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units ordered from the supplier on this line item.',
    `overdelivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Permitted percentage by which the supplier may exceed the ordered quantity without requiring approval. Accommodates supplier packaging constraints.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30).. Valid values are `^[A-Z0-9]{4}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the receiving plant or manufacturing facility for the procured materials.. Valid values are `^[A-Z0-9]{4}$`',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for procurement commitment.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number issued to supplier. Business identifier for procurement commitment.. Valid values are `^[A-Z0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from creation through approval, fulfillment, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of purchase order by procurement model: standard (one-time), blanket (recurring), consignment (supplier-owned inventory), subcontracting (external processing), framework (long-term agreement), or service (non-material).. Valid values are `standard|blanket|consignment|subcontracting|framework|service`',
    `purchasing_group` STRING COMMENT 'Buyer or purchasing group responsible for this purchase order. Identifies the procurement specialist managing supplier relationships.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Defines procurement authority and supplier relationships.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming goods receipt requires Quality Control (QC) inspection before release to inventory. Mandatory for critical reagents and consumables.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity received to date via goods receipt transactions. Tracks fulfillment progress.',
    `release_date` DATE COMMENT 'Date when the purchase order was released to the supplier for fulfillment. Starts the supplier Turnaround Time (TAT) clock.',
    `storage_location` STRING COMMENT 'Storage location code within the plant where received goods will be placed. Critical for cold-chain reagents and controlled materials.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the purchase order line item. Calculated based on tax jurisdiction and material tax classification.',
    `total_value` DECIMAL(18,2) COMMENT 'Total value of the purchase order line item including tax and other charges. Sum of net value and tax amount.',
    `underdelivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Permitted percentage by which the supplier may deliver less than the ordered quantity without penalty. Manages supply risk for critical materials.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the ordered quantity. Common genomics units include EA (each), KG (kilogram), L (liter), VIAL, PLATE, KIT. [ENUM-REF-CANDIDATE: EA|KG|L|M|BOX|VIAL|PLATE|KIT|SET|UNIT — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for the material or service. Basis for line item net value calculation.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Transactional record of a formal procurement commitment issued to a supplier for materials or services. Header captures PO number, PO type (standard, blanket, consignment, subcontracting), supplier reference, plant/storage location, requested delivery date, incoterms, payment terms, total net value, currency, GMP-relevant flags, and approval workflow status. Line items (after po_line merge) capture material reference, ordered quantity, confirmed quantity, unit price, delivery schedule, storage location assignment, over/under-delivery tolerances, and goods receipt/invoice receipt indicators. The line item is the grain of this product. Each PO is the authoritative procurement document linking demand signals to supplier fulfillment. Sourced from SAP MM (EKKO/EKPO/EKET).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Purchase order lines specify which reagent catalog item is procured. Enables procurement spend analytics by reagent type, supplier performance by product category, automated goods receipt validation—c',
    `material_id` BIGINT COMMENT 'Reference to the material master record representing the specific reagent, consumable, component, or finished good being procured on this line.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header under which this line item is grouped.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Line-level requisitioner tracking enables cost center accountability, budget variance analysis by personnel, and audit trail for split POs. Replaces denormalized requisitioner_name with FK for perso',
    `account_assignment_category` STRING COMMENT 'Defines how the procurement cost is assigned in financial accounting, such as cost center, internal order, project, or asset.',
    `batch_management_required` BOOLEAN COMMENT 'Flag indicating whether the material on this line requires batch or lot number tracking for traceability, quality control, and regulatory compliance.',
    `cold_chain_required` BOOLEAN COMMENT 'Flag indicating whether the material requires temperature-controlled storage and transportation, essential for preserving the integrity of sensitive genomics reagents.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The quantity confirmed by the supplier for delivery, which may differ from the ordered quantity due to availability or negotiation.',
    `cost_center_code` STRING COMMENT 'The cost center to which the procurement expense for this line item is charged, enabling departmental cost tracking and analysis.',
    `created_by_user` STRING COMMENT 'The username or identifier of the individual who created this purchase order line item, supporting accountability and audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was first created in the system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the net price is denominated, such as USD, EUR, or GBP.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this line item has been marked for deletion or cancellation, preventing further processing while preserving audit history.',
    `delivery_date` DATE COMMENT 'The scheduled or requested delivery date for the material on this purchase order line, critical for production planning and inventory management.',
    `gl_account_code` STRING COMMENT 'The general ledger account number to which the procurement cost is posted, supporting financial reporting and Cost of Goods Sold (COGS) visibility.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether a goods receipt is required for this line item before invoice processing can occur, enforcing three-way match controls.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous, requiring special handling, storage, and shipping procedures per safety regulations.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer, such as EXW, FOB, or DDP.',
    `incoterms_location` STRING COMMENT 'The specific geographic location or port associated with the Incoterms designation, clarifying the point of risk transfer.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether an invoice is expected for this line item, controlling accounts payable processing workflows.',
    `item_category` STRING COMMENT 'Classification of the purchase order line item type, such as standard, consignment, subcontracting, or service, which determines procurement processing rules.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order, used for ordering and referencing individual line items.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item, tracking progression from creation through goods receipt, invoicing, and closure.. Valid values are `open|partially_received|fully_received|invoiced|closed|cancelled`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'The total monetary value for this line item, calculated as ordered quantity multiplied by net price, before taxes and discounts.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material, used for precise identification and quality assurance in genomics reagent procurement.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials together for procurement analysis, supplier negotiation, and spend visibility.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the individual who last modified this purchase order line item, enabling change accountability and compliance tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was last updated, enabling change tracking and audit compliance.',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure for the material, excluding taxes and additional charges.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of material ordered on this purchase order line, expressed in the unit of measure specified.',
    `overdelivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the supplier may exceed the ordered quantity without requiring approval, supporting flexible receiving processes.',
    `plant_code` STRING COMMENT 'The manufacturing or distribution plant to which the material will be delivered, representing the receiving location within the enterprise.',
    `price_unit` STRING COMMENT 'The quantity unit to which the net price applies. For example, if price_unit is 100 and net_price is 50.00, the price is 50.00 per 100 units.',
    `shelf_life_expiration_date` DATE COMMENT 'The date by which the material must be used or disposed of, critical for managing reagent and consumable inventory in genomics laboratories.',
    `short_text` STRING COMMENT 'Additional free-form text providing supplementary information or special instructions for this purchase order line item.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse area within the plant where the material will be received and stored upon delivery.',
    `tax_code` STRING COMMENT 'The tax classification code applied to this line item, determining the applicable tax rate and jurisdiction.',
    `underdelivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the supplier may deliver less than the ordered quantity without triggering a shortage alert or requiring follow-up.',
    `unit_of_measure` STRING COMMENT 'The unit in which the material quantity is expressed, such as EA (each), L (liters), KG (kilograms), or BOX.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material, quantity, unit price, delivery schedule, and storage location assignment. Captures line number, material reference, ordered quantity, confirmed quantity, unit of measure, net price, delivery date, goods receipt indicator, invoice receipt indicator, and over/under-delivery tolerances. Enables granular tracking of multi-material procurement events. Sourced from SAP MM (EKPO/EKET).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `account_id` BIGINT COMMENT 'Foreign key reference to the customer master for goods issues related to sales orders or customer returns.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Goods receipts create or reference batch records for batch-managed materials. The goods_receipt table has batch_number (STRING) but no FK to batch. Adding batch_id FK enables joining to batch master f',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: Goods receipts are posted against inbound delivery documents in the logistics flow. The goods_receipt table has delivery_document_number (STRING) and delivery_line_item (INT) but no FK to inbound_deli',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Goods receipts trigger accounting postings (inventory debit, GR/IR clearing account credit). Finance reconciles material movements to general ledger for inventory valuation and COGS calculation.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Goods receipt creates or updates reagent lot in inventory. GMP operations require traceability from material document to specific lot for audit trails, deviation investigations, and batch record recon',
    `material_id` BIGINT COMMENT 'Foreign key reference to the material master. Identifies the specific reagent, consumable, instrument component, or finished good involved in the movement.',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the plant (manufacturing site or distribution center) where the goods movement occurred.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Goods receipts are posted against purchase orders in SAP MM. The goods_receipt table currently has purchase_order_number (STRING) and purchase_order_line_item (INT) but no FK to purchase_order. Adding',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Goods receipts generate quality issues during inspection for wrong material, quantity variance, COA missing, or specification non-conformance. Real business process: goods receipt non-conformance work',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GMP/GxP regulations require personnel accountability for all material receipts. Enables training qualification verification (only qualified personnel can receive GMP materials), audit trails, and pers',
    `storage_location_id` BIGINT COMMENT 'Foreign key reference to the storage location within the plant (e.g., warehouse zone, cold storage room, quarantine area).',
    `supplier_id` BIGINT COMMENT 'Foreign key reference to the supplier master for goods receipts from external vendors. Critical for supplier performance tracking and quality management.',
    `coa_reference_number` STRING COMMENT 'Reference to the Certificate of Analysis document for the received batch. Mandatory for GMP-regulated materials. Enables linkage to quality test results and release decisions.. Valid values are `^COA-[A-Z0-9]{12}$`',
    `cold_chain_log_reference` STRING COMMENT 'Reference to the cold chain temperature monitoring log for temperature-sensitive genomics reagents and biologics. Critical for ensuring material integrity and regulatory compliance.. Valid values are `^CCL-[A-Z0-9]{10}$`',
    `company_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code currency used in consolidated reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the material document was created. Part of the immutable audit trail for GxP and SOX compliance.',
    `document_date` DATE COMMENT 'Date on the source document (e.g., delivery note, production order). May differ from posting date when documents are processed retrospectively.',
    `entry_date` DATE COMMENT 'Date when the material document was created in the system. Used for audit trail and document lifecycle tracking.',
    `gmp_batch_record_reference` STRING COMMENT 'Reference to the GMP batch manufacturing record for materials issued to or received from production. Mandatory for FDA-regulated manufacturing operations.. Valid values are `^BMR-[A-Z0-9]{12}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the local plant currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `material_document_line_item` STRING COMMENT 'Line item number within the material document. Enables tracking of individual material movements within a single document.',
    `material_document_number` STRING COMMENT 'SAP material document number (MBLNR) that uniquely identifies the goods movement transaction in the source ERP system. Used for cross-system reconciliation and audit trails.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Part of the composite key in SAP MM along with material document number.',
    `movement_type` STRING COMMENT 'Three-digit SAP movement type code that classifies the nature of the goods movement. Examples: 101 (GR against PO), 261 (goods issue to production), 301 (plant-to-plant transfer), 122 (return to supplier), 551 (scrapping).. Valid values are `^[0-9]{3}$`',
    `movement_type_description` STRING COMMENT 'Human-readable description of the movement type for reporting and user interfaces.',
    `movement_value_company_currency` DECIMAL(18,2) COMMENT 'Total value of the goods movement in company code currency for consolidated financial reporting. Confidential for competitive pricing protection.',
    `movement_value_local_currency` DECIMAL(18,2) COMMENT 'Total value of the goods movement in local plant currency. Used for inventory valuation, COGS calculation, and financial reporting. Confidential for competitive pricing protection.',
    `posting_date` DATE COMMENT 'Date on which the goods movement was posted to inventory and financial ledgers. Critical for period-end closing, COGS calculation, and financial reporting.',
    `production_order_number` STRING COMMENT 'Reference to the production order for goods issues to manufacturing (movement type 261) or finished goods receipts from production. Critical for manufacturing cost allocation and work-in-process tracking.. Valid values are `^[0-9]{12}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material moved in base unit of measure. Positive for receipts/inbound movements, negative for issues/outbound movements.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the goods movement (e.g., quality defect, expiration, process deviation, customer return). Critical for root cause analysis and quality investigations.. Valid values are `^[A-Z0-9]{4}$`',
    `reason_description` STRING COMMENT 'Human-readable description of the movement reason for reporting and quality review.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this goods movement is a reversal of a previous transaction. True if this is a reversal document.',
    `reversed_document_number` STRING COMMENT 'Material document number of the original transaction that this document reverses. Populated only when reversal_indicator is true.. Valid values are `^[0-9]{10}$`',
    `special_stock_indicator` STRING COMMENT 'SAP special stock type: E (sales order stock), K (consignment stock), O (project stock), Q (quality inspection stock), W (blocked stock). Critical for inventory segregation and financial reporting.. Valid values are `E|K|O|Q|W`',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for the quantity (e.g., EA for each, L for liters, KG for kilograms). Follows ISO standards for laboratory and manufacturing materials.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_type` STRING COMMENT 'Split valuation type for materials with multiple valuation classes (e.g., RUO vs IVD grade reagents). Enables separate inventory valuation for materials with different quality grades or regulatory classifications.. Valid values are `^[A-Z0-9]{10}$`',
    `vendor_number` STRING COMMENT 'SAP vendor account number. Retained for cross-system reconciliation and legacy reporting.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional ledger of all material movements within the Genomics Biotech supply chain — including goods receipts against POs (mvt 101), goods issues to production (mvt 261), stock transfers between plants/locations (mvt 301/311), returns to supplier (mvt 122), and scrapping events (mvt 551). Captures movement type, posting date, material, plant, storage location, batch, quantity, movement value, reference document (PO, production order, delivery), cold-chain temperature log reference, COA reference, and movement reason code. Provides the single authoritative material ledger for GMP audit trails, COGS calculation, and full lot traceability. Sourced from SAP MM (MSEG/MKPF).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique identifier for the inventory stock record. Primary key for the inventory stock data product.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Inventory stock positions are tracked by batch for batch-managed materials. The inventory_stock table has batch_number (STRING) but no FK to batch. Adding batch_id FK enables joining to batch master f',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Links ERP inventory stock to quality-controlled reagent lot (CoA-released unit). Enables real-time expiry monitoring, FEFO execution, quality hold propagation across systems—essential for genomics bio',
    `material_id` BIGINT COMMENT 'Reference to the material master record representing the genomics product, reagent, consumable, or instrument component being stocked.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing or distribution plant where the material is stocked.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Inventory stock positions may reference the originating purchase order for procurement traceability and COGS analysis. The inventory_stock table has purchase_order_number (STRING) but no FK to purchas',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the material is physically stored.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom this batch was procured. Used for supplier performance tracking and traceability.',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management. A = high-value/critical, B = moderate, C = low-value/non-critical. Used for prioritization and cycle counting.. Valid values are `A|B|C`',
    `available_stock_quantity` DECIMAL(18,2) COMMENT 'Calculated available quantity: unrestricted stock minus reserved stock. Represents stock available for new commitments.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked for use due to quality issues, regulatory hold, or other restrictions. Requires disposition decision.',
    `certificate_of_analysis_number` STRING COMMENT 'Certificate of Analysis document number provided by the vendor for this batch. Contains quality test results and specifications.. Valid values are `^COA[A-Z0-9]{8,16}$`',
    `cold_chain_storage_zone` STRING COMMENT 'Temperature-controlled storage zone assignment for materials requiring cold-chain handling. Critical for reagent stability and GMP compliance.. Valid values are `AMBIENT|REFRIGERATED_2_8C|FROZEN_MINUS_20C|ULTRA_FROZEN_MINUS_80C|CRYOGENIC_MINUS_196C`',
    `consignment_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material held on consignment from a vendor. Ownership transfers only upon consumption.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory stock record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the stock value amount. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|CHF|AUD|CAD|SGD — 9 candidates stripped; promote to reference product]',
    `cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count for this stock record. Used to ensure inventory accuracy.',
    `expiry_date` DATE COMMENT 'Shelf-life expiration date for the batch. Critical for reagents, consumables, and biologics with limited stability. Must be monitored to prevent use of expired materials.',
    `gmp_controlled_flag` BOOLEAN COMMENT 'Indicates whether this material is subject to GMP controls requiring batch-level traceability, quality documentation, and regulatory compliance.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this material is classified as hazardous, requiring special handling, storage, and Safety Data Sheet (SDS) compliance.',
    `in_transit_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently in transit between plants or storage locations. Not yet available at the destination.',
    `last_goods_movement_date` DATE COMMENT 'Date of the most recent goods movement (receipt, issue, transfer) for this stock record. Used to identify slow-moving or obsolete inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory stock record was last updated. Used for change tracking and audit trails.',
    `manufacture_date` DATE COMMENT 'Date the batch was manufactured or produced. Used for shelf-life calculation and traceability.',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum stock level allowed at this location. Used to prevent overstocking and optimize working capital.',
    `mrp_controller_code` STRING COMMENT 'Code identifying the MRP controller or planner responsible for managing replenishment of this material.. Valid values are `^[A-Z0-9]{2,4}$`',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently under quality inspection or Quality Control (QC) testing. Cannot be used until QC release.',
    `receipt_date` DATE COMMENT 'Date the material was received into the storage location. Used for FIFO/FEFO inventory management.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Minimum stock level that triggers a replenishment order. Used in automated procurement planning to ensure uninterrupted supply.',
    `reserved_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of unrestricted stock reserved for specific production orders, sales orders, or projects. Committed but not yet issued.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock maintained to protect against demand variability and supply disruptions. Critical for high-priority genomics inputs.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether this material is managed at the individual serial number level (e.g., instruments, high-value equipment).',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock position snapshot was captured. Supports historical stock analysis and trend reporting.',
    `stock_status` STRING COMMENT 'Current operational status of the stock record. Indicates availability, alerts, or restrictions. [ENUM-REF-CANDIDATE: AVAILABLE|LOW_STOCK|OUT_OF_STOCK|EXPIRING_SOON|EXPIRED|BLOCKED|QUARANTINE — 7 candidates stripped; promote to reference product]',
    `stock_type` STRING COMMENT 'Classification of stock ownership and purpose. Distinguishes between own stock, consignment, project-specific stock, and other special stock types.. Valid values are `OWN_STOCK|CONSIGNMENT|PROJECT_STOCK|SALES_ORDER_STOCK|RETURNABLE_PACKAGING`',
    `stock_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the stock at this location, calculated using the material valuation price. Critical for Cost of Goods Sold (COGS) visibility.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for stock quantities. Common genomics units include EA (each), KG (kilogram), L (liter), ML (milliliter), UL (microliter), VIAL, KIT, PLATE. [ENUM-REF-CANDIDATE: EA|KG|L|ML|UL|G|MG|BOX|KIT|VIAL|PLATE|TUBE|ROLL — 13 candidates stripped; promote to reference product]',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for unrestricted use. This stock can be issued for production, sales orders, or other consumption without restrictions.',
    `valuation_price_per_unit` DECIMAL(18,2) COMMENT 'Standard or moving average price per unit used for inventory valuation. Basis for COGS calculation.',
    `valuation_type` STRING COMMENT 'Method used for inventory valuation. Standard valuation uses a single price; split valuation allows different prices for different stock segments.. Valid values are `STANDARD|SPLIT_VALUATION|BATCH_VALUATION`',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Current and historical stock position for each material at each plant and storage location. Captures unrestricted stock, quality inspection stock, blocked stock, consignment stock, and in-transit stock quantities. Includes batch-level granularity for GMP-controlled materials, expiry date tracking, cold-chain storage zone assignment, and reorder point/safety stock parameters. Supports COGS visibility and uninterrupted supply assurance for critical genomics inputs. Sourced from SAP MM (MARD/MCHB/MBEW).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement log.',
    `account_id` BIGINT COMMENT 'Reference to the customer if this movement is a goods issue for sales order fulfillment or customer return.',
    `batch_id` BIGINT COMMENT 'Reference to the batch or lot number for batch-managed materials. Critical for GMP (Good Manufacturing Practice) traceability and Certificate of Analysis (COA) linkage.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center charged or credited for this stock movement. Used for internal cost allocation and Controlling (CO) reporting.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Stock movements (issues, transfers, adjustments) must trace to specific reagent lots for GMP compliance. Lot-level traceability required for batch records, experiment reproducibility, regulatory inspe',
    `material_id` BIGINT COMMENT 'Reference to the material (raw material, reagent, consumable, or finished good) involved in this stock movement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Material movement audit trail requires employee linkage for GxP compliance, training qualification verification, and investigation of inventory discrepancies. Replaces text user_name with FK to enab',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing or distribution plant where the stock movement occurred.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Stock movements (goods receipts, transfers, issues) often reference the originating purchase order for procurement-related movements. The stock_movement table has purchase_order_number (STRING) and pu',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location (warehouse zone, cold storage, quarantine area) within the plant.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor if this movement is a goods receipt from external procurement.',
    `amount_in_company_currency` DECIMAL(18,2) COMMENT 'The total value of the stock movement converted to the company codes reporting currency. Used for consolidated financial reporting and Profit and Loss (P&L) analysis.',
    `amount_in_local_currency` DECIMAL(18,2) COMMENT 'The total value of the stock movement in the plants local currency. Used for inventory valuation and COGS (Cost of Goods Sold) calculation. Derived from material price and quantity.',
    `company_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the companys reporting currency.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this stock movement record was first created in the data warehouse. Used for data lineage and audit purposes.',
    `delivery_number` STRING COMMENT 'Reference to the outbound delivery document if this movement is a goods issue for shipment. Links to logistics execution.. Valid values are `^[0-9]{10}$`',
    `document_date` DATE COMMENT 'The date printed on the source document (e.g., delivery note date, production order completion date). May differ from posting date.',
    `entry_timestamp` TIMESTAMP COMMENT 'The exact date and time when the material document was created in the system. Used for audit trail and Turnaround Time (TAT) analysis.',
    `entry_unit_of_measure` STRING COMMENT 'The unit of measure used during transaction entry. Supports multi-unit scenarios (e.g., ordering in cases but stocking in units).. Valid values are `^[A-Z]{2,3}$`',
    `general_ledger_account` STRING COMMENT 'The General Ledger account number to which the inventory value change is posted. Links stock movement to financial accounting.. Valid values are `^[0-9]{6,10}$`',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the local currency (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `material_document_line_item` STRING COMMENT 'Line item number within the material document. Uniquely identifies this movement within the document header.',
    `material_document_number` STRING COMMENT 'SAP material document number (MBLNR) that groups one or more movement line items into a single posting transaction. Serves as the business identifier for audit and reconciliation.. Valid values are `^[0-9]{10}$`',
    `movement_indicator` STRING COMMENT 'High-level classification of the movement direction: receipt (inbound), issue (outbound), or transfer (location-to-location).. Valid values are `receipt|issue|transfer`',
    `movement_type_code` STRING COMMENT 'Three-digit SAP movement type code that classifies the nature of the stock movement (e.g., 101=Goods Receipt from PO, 261=Goods Issue to Production Order, 311=Transfer Posting, 551=Scrapping). Determines accounting impact and inventory valuation logic.. Valid values are `^[0-9]{3}$`',
    `movement_type_description` STRING COMMENT 'Human-readable description of the movement type (e.g., Goods Receipt, Goods Issue, Stock Transfer, Return, Scrapping).',
    `posting_date` DATE COMMENT 'The date on which the stock movement was posted to the material ledger and financial accounting. Used for period-end closing and Cost of Goods Sold (COGS) calculation.',
    `production_order_number` STRING COMMENT 'Reference to the production order if this movement is a goods issue to manufacturing or a goods receipt from production. Links to Manufacturing Execution System (MES) processes.. Valid values are `^[0-9]{12}$`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material moved, expressed in the base unit of measure. Positive for receipts, negative for issues in some reporting contexts.',
    `quantity_in_entry_unit` DECIMAL(18,2) COMMENT 'The quantity in the unit of measure used during data entry (e.g., purchase order unit). May differ from base unit for conversion tracking.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the stock movement (e.g., quality defect, expiration, customer return, process scrap). Used for root cause analysis and Quality Assurance (QA) investigations.. Valid values are `^[A-Z0-9]{2,4}$`',
    `reason_description` STRING COMMENT 'Human-readable description of the movement reason code.',
    `reservation_line_item` STRING COMMENT 'Line item number within the reservation document.',
    `reservation_number` STRING COMMENT 'Reference to the material reservation document if this movement fulfills a reservation (e.g., for production or project consumption).. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this movement is a reversal (cancellation) of a previous material document. True if reversal, False otherwise.',
    `reversed_document_number` STRING COMMENT 'The material document number that this movement reverses. Populated only if reversal_indicator is True.. Valid values are `^[0-9]{10}$`',
    `sales_order_line_item` STRING COMMENT 'Line item number within the sales order. Identifies the specific material line being shipped.',
    `sales_order_number` STRING COMMENT 'Reference to the sales order if this movement is a goods issue for customer delivery. Links to Order Management (SD) process.. Valid values are `^[0-9]{10}$`',
    `special_stock_indicator` STRING COMMENT 'Single-character code indicating special stock scenarios (e.g., consignment stock, project stock, sales order stock). Blank for standard stock.. Valid values are `^[A-Z]{1}$`',
    `stock_type` STRING COMMENT 'Classification of the stock status: unrestricted (available for use), quality_inspection (under QC testing), blocked (quarantined), or restricted (conditionally available). Critical for GMP compliance and Quality Control (QC) workflows.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is expressed (e.g., EA=Each, KG=Kilogram, L=Liter, BOX=Box). Aligns with ISO unit codes where applicable.. Valid values are `^[A-Z]{2,3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this stock movement record was last updated in the data warehouse. Used for change tracking and incremental load processing.',
    `valuation_type` STRING COMMENT 'Sub-classification of material for split valuation purposes (e.g., different pricing for domestic vs. imported batches). Blank if not used.. Valid values are `^[A-Z0-9]{0,10}$`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional log of every material movement within the supply chain — including goods receipts, goods issues, stock transfers, returns, and scrapping events. Captures movement type, posting date, material, plant, storage location, batch, quantity, value, reference document (PO, production order, delivery), and movement reason. Provides full material ledger traceability required for GMP audit trails and COGS calculation. Sourced from SAP MM (MSEG/MKPF).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`batch` (
    `batch_id` BIGINT COMMENT 'Unique identifier for the production or procurement batch. Primary key for the batch master record.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: GMP batch release requires verification that batch specifications conform to approved regulatory dossier. Critical for QC disposition decisions, certificate of analysis generation, and ensuring batche',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GMP batch record regulations require personnel accountability for batch creation. Enables training qualification verification, electronic signature compliance (21 CFR Part 11), and batch record audit ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Sequencing reagent batches (library prep kits, sequencing chemistry) are validated against specific genome builds. Batch records must document reference genome used in validation studies for FDA/IVDR ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Custom synthesis batches, validation batches, and R&D material lots are charged to internal orders for project costing. Enables accurate allocation of material costs to research projects and clinical ',
    `material_id` BIGINT COMMENT 'Reference to the material master record for which this batch was produced or procured. Links to the material product in the supply domain.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the batch was produced. Links to the facility master in the supply or manufacturing domain.',
    `work_order_id` BIGINT COMMENT 'Reference to the production order under which this batch was manufactured. Null for procured batches. Links to manufacturing domain.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order under which this batch was procured. Null for internally manufactured batches.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier master record if the batch was externally procured. Null for internally manufactured batches.',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical interpretation software batches (variant calling pipelines, annotation tools) are locked to specific variant database versions at manufacture. Batch records must capture database version for ',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the primary warehouse location where the batch is stored. Links to warehouse master in the supply domain.',
    `available_quantity` DECIMAL(18,2) COMMENT 'Current unrestricted quantity available for use or shipment from this batch. Updated in real-time as inventory is consumed or reserved.',
    `batch_number` STRING COMMENT 'Business-facing batch or lot number assigned to the production or procurement batch. Used for traceability and quality control. Also known as lot number.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_status` STRING COMMENT 'Overall lifecycle status of the batch indicating its current state in inventory and usability.. Valid values are `active|depleted|expired|recalled|quarantined|obsolete`',
    `blocked_quantity` DECIMAL(18,2) COMMENT 'Quantity from this batch that is blocked for quality or compliance reasons and cannot be used or shipped until released.',
    `coa_number` STRING COMMENT 'Unique identifier for the Certificate of Analysis document that certifies the batch meets quality specifications. Required for GMP compliance and customer shipments.. Valid values are `^COA-[A-Z0-9]{8,15}$`',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the batch has been maintained within required cold-chain temperature ranges throughout its lifecycle. False indicates a temperature excursion event occurred.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the batch was manufactured or procured. Required for customs, trade compliance, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was first created in the system. Used for audit trail and data lineage.',
    `expiry_date` DATE COMMENT 'Date after which the batch should not be used due to potential degradation or loss of efficacy. Mandatory for reagents, consumables, and IVD products.',
    `gmp_classification` STRING COMMENT 'Indicates whether the batch was manufactured under GMP, non-GMP, or GMP-equivalent conditions. Critical for regulatory compliance and product classification.. Valid values are `gmp|non_gmp|gmp_equivalent`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the batch contains hazardous materials requiring special handling, storage, and shipping procedures.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the batch record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch record was last updated in the system. Used for audit trail and change tracking.',
    `manufacturing_date` DATE COMMENT 'Date on which the batch was manufactured or produced. Critical for shelf-life calculation and expiry determination.',
    `origin` STRING COMMENT 'Source of the batch indicating whether it was produced internally, procured from an external supplier, manufactured by a contract manufacturer, reworked from a previous batch, or is a sample batch.. Valid values are `internal_production|external_procurement|contract_manufacturing|rework|sample`',
    `qc_release_date` DATE COMMENT 'Date on which the batch was officially released by Quality Assurance for use or distribution. Null if batch is not yet released.',
    `qc_status` STRING COMMENT 'Current quality control release status of the batch. Only released batches are available for use or shipment. Managed by Quality Management module.. Valid values are `pending|in_progress|released|rejected|on_hold|conditionally_released`',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity from this batch that is in quality inspection and not yet released for use. Managed by Quality Management.',
    `recall_date` DATE COMMENT 'Date on which the recall was initiated for this batch. Null if no recall has been issued.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this batch is subject to a product recall. True triggers immediate inventory blocking and customer notification workflows.',
    `recall_reason` STRING COMMENT 'Detailed explanation of why the batch was recalled. Includes quality defect description, safety concern, or regulatory non-compliance issue.',
    `regulatory_classification` STRING COMMENT 'Regulatory category of the batch indicating its intended use and compliance requirements. IVD (In Vitro Diagnostic), RUO (Research Use Only), GMP API (Good Manufacturing Practice Active Pharmaceutical Ingredient).. Valid values are `ivd|ruo|gmp_api|medical_device|research_grade`',
    `retest_date` DATE COMMENT 'Date by which the batch must be retested to confirm continued quality and stability. Applicable to raw materials and intermediates.',
    `sds_number` STRING COMMENT 'Unique identifier for the Safety Data Sheet associated with this batch. Required for hazardous materials and chemicals.. Valid values are `^SDS-[A-Z0-9]{6,12}$`',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the batch in days from manufacturing date to expiry date. Used for inventory planning and FEFO (First Expired First Out) logic.',
    `size_quantity` DECIMAL(18,2) COMMENT 'Total quantity produced or procured in this batch. Expressed in the base unit of measure for the material.',
    `size_uom` STRING COMMENT 'Unit of measure for the batch size quantity. Examples: EA (each), KG (kilogram), L (liter), ML (milliliter).. Valid values are `^[A-Z]{2,3}$`',
    `sterilization_date` DATE COMMENT 'Date on which the batch was sterilized. Null if sterilization is not applicable.',
    `sterilization_method` STRING COMMENT 'Method used to sterilize the batch if applicable. Critical for consumables and reagents used in clinical or diagnostic applications.. Valid values are `autoclave|gamma_irradiation|ethylene_oxide|filtration|not_applicable`',
    `storage_condition` STRING COMMENT 'Required storage condition for the batch to maintain quality and stability. Defines temperature and environmental requirements.. Valid values are `room_temperature|refrigerated|frozen|ultra_low_temperature|controlled_ambient`',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius for the batch. Exceeding this threshold may compromise batch quality.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius for the batch. Used for cold-chain monitoring and compliance.',
    `supplier_batch_number` STRING COMMENT 'Original batch or lot number assigned by the supplier for externally procured materials. Used for supplier traceability and quality investigations.',
    CONSTRAINT pk_batch PRIMARY KEY(`batch_id`)
) COMMENT 'Master record for a specific production or procurement batch of a material, enabling full lot traceability from supplier through manufacturing to customer delivery. Captures batch number, material reference, manufacturing date, expiry date, COA number, QC release status, storage conditions, cold-chain compliance flag, GMP classification, and batch origin (internal production vs. external procurement). Critical for GxP compliance, recall management, and reagent/consumable quality assurance. Sourced from SAP MM/QM (MCH1/MCHA).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` (
    `inbound_delivery_id` BIGINT COMMENT 'Unique identifier for the inbound delivery document. Primary key for the inbound delivery entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Deliveries trigger 3-way match (PO-GR-Invoice) for AP invoice verification. Links physical receipt to invoice for payment authorization, critical for GMP-compliant procurement and financial controls.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that triggered this inbound delivery. Links delivery to procurement document.',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse employee or receiving clerk who physically accepted the delivery. Required for audit trail and accountability.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who is shipping the materials. Primary counterparty for this inbound delivery.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the Genomics Biotech facility, warehouse, or laboratory receiving the inbound shipment.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the receiving dock. Critical for TAT (Turnaround Time) measurement and SLA (Service Level Agreement) compliance.',
    `bill_of_lading_number` STRING COMMENT 'Carrier-issued document serving as receipt of goods and contract of carriage. Required for international shipments and freight claims.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier or freight forwarder responsible for transporting the shipment.',
    `cold_chain_device_code` STRING COMMENT 'Identifier of the temperature monitoring device attached to the shipment. Essential for reagent and consumable shipments requiring temperature control per GMP (Good Manufacturing Practice).. Valid values are `^[A-Z0-9]{6,20}$`',
    `commercial_invoice_number` STRING COMMENT 'Supplier invoice number associated with this delivery. Used for three-way match in accounts payable (invoice, PO, goods receipt).. Valid values are `^[A-Z0-9-]{6,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound delivery record was first created in the system. Part of audit trail for regulatory compliance.',
    `customs_clearance_date` DATE COMMENT 'Date when customs clearance was completed for international shipments. Impacts delivery lead time and TAT (Turnaround Time).',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance process for international shipments. Critical for cross-border deliveries of reagents, instruments, and consumables.. Valid values are `not_required|pending|cleared|held|rejected`',
    `delivery_note_text` STRING COMMENT 'Free-text notes or special instructions related to the inbound delivery. Captures handling requirements, supplier communications, or receiving observations.',
    `delivery_number` STRING COMMENT 'Externally-known business identifier for the inbound delivery document. Used for tracking and communication with suppliers.. Valid values are `^[A-Z0-9]{10,20}$`',
    `delivery_priority` STRING COMMENT 'Business priority assigned to the inbound delivery. Determines receiving sequence and expedited handling for critical reagents or time-sensitive materials.. Valid values are `low|normal|high|urgent|critical`',
    `delivery_status` STRING COMMENT 'Current state of the inbound delivery in its lifecycle. Tracks progression from planning through goods receipt posting.. Valid values are `planned|in_transit|arrived|goods_receipt_posted|cancelled|blocked`',
    `expected_arrival_date` DATE COMMENT 'Planned date when the inbound delivery is expected to arrive at the receiving location. Used for warehouse planning and scheduling.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight and transportation cost for the inbound delivery. Contributes to landed cost calculation and COGS (Cost of Goods Sold).',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for freight cost amount. Required for multi-currency operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_date` DATE COMMENT 'Date when goods receipt was posted in the system, triggering inventory update and invoice verification. Key event for COGS (Cost of Goods Sold) recognition.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling per SDS (Safety Data Sheet) and regulatory requirements.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between supplier and buyer. Critical for international shipments and customs. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_lot_number` STRING COMMENT 'Identifier for the quality inspection lot created for this inbound delivery. Links to QC (Quality Control) results and COA (Certificate of Analysis).. Valid values are `^[A-Z0-9]{8,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inbound delivery record was last updated. Tracks changes for audit trail and data lineage.',
    `max_temperature_celsius` DECIMAL(18,2) COMMENT 'Highest temperature recorded during shipment transit in degrees Celsius. Used for cold-chain validation and quality assessment.',
    `min_temperature_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature recorded during shipment transit in degrees Celsius. Used for cold-chain validation and quality assessment.',
    `package_count` STRING COMMENT 'Total number of packages, boxes, or containers in the inbound delivery. Used for receiving verification and warehouse handling.',
    `packing_list_number` STRING COMMENT 'Supplier-provided packing list identifier detailing contents of the shipment. Used for receiving verification and quality inspection.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `proof_of_delivery_document_url` STRING COMMENT 'URL or file path to the signed proof of delivery document. Used for dispute resolution and freight claim processing.. Valid values are `^https?://.*`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming materials require QC (Quality Control) inspection before goods receipt posting. Critical for GMP (Good Manufacturing Practice) compliance.',
    `receiving_dock_location` STRING COMMENT 'Specific dock, bay, or receiving area within the facility where the delivery was unloaded. Used for warehouse operations and material flow tracking.',
    `shipping_point` STRING COMMENT 'Supplier facility or warehouse location from which the shipment originated. Used for supplier performance analysis and lead time calculation.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system that created or last updated this delivery record. Supports data lineage and integration troubleshooting.. Valid values are `SAP_MM|SAP_LE|MANUAL|EDI|API`',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates whether the shipment experienced temperature deviations outside acceptable range during transit. Critical for quality control and product acceptance decisions.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the inbound delivery in cubic meters. Used for warehouse space allocation and freight cost calculation.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the entire inbound delivery in kilograms. Used for freight cost validation and warehouse capacity planning.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for real-time shipment visibility and proof of delivery.. Valid values are `^[A-Z0-9]{8,30}$`',
    `un_number` STRING COMMENT 'UN number identifying hazardous materials classification for dangerous goods in shipment. Required for HAZMAT compliance.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_inbound_delivery PRIMARY KEY(`inbound_delivery_id`)
) COMMENT 'Logistics document tracking the physical inbound shipment of materials from a supplier to a Genomics Biotech receiving location. Captures delivery number, carrier, tracking number, expected arrival date, actual arrival date, incoterms, cold-chain monitoring device ID, temperature excursion flag, number of packages, total weight, and customs clearance status for international shipments. Links to purchase orders and triggers goods receipt processing. Sourced from SAP MM/LE (LIKP/LIPS).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Unique identifier for the supplier contract record. Primary key.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contracts are budgeted and tracked by owning cost center (R&D reagents, manufacturing supplies, lab services). Enables contract budget ownership, spend tracking, and variance reporting by department.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Supplier contracts specify which products/SKUs are covered (reagent supply agreements, service contracts). Contract management, pricing validation, and procurement authorization require knowing which ',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Supplier contracts are governed by MDM policies for contract master data standards, approval authority matrices, and retention requirements. Real business process: contract lifecycle management enforc',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier party with whom this contract is established. Links to supplier master data.',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Contracts with bioinformatics vendors (ClinVar, COSMIC, proprietary annotation services) specify licensed variant database versions, update schedules, and access tiers. Contract records must track dat',
    `approval_date` DATE COMMENT 'Date on which the contract was formally approved by authorized signatories and became legally binding.',
    `approved_by_name` STRING COMMENT 'Name of the authorized person who approved this contract on behalf of the purchasing organization.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether materials supplied under this contract require cold chain handling and temperature-controlled logistics. True if cold chain is mandatory.',
    `company_code` STRING COMMENT 'Legal entity or company code under which this contract is executed. Four-character SAP company code for financial and legal segregation.. Valid values are `^[A-Z0-9]{4}$`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract or scheduling agreement. Sourced from SAP MM EKKO-EBELN.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the supplier contract: draft (under negotiation), active (in force), suspended (temporarily paused), expired (validity period ended), terminated (cancelled before expiry), or closed (completed and archived).. Valid values are `draft|active|suspended|expired|terminated|closed`',
    `contract_type` STRING COMMENT 'Classification of the procurement contract defining the commitment structure: value contract (monetary ceiling), quantity contract (volume ceiling), scheduling agreement (delivery schedule), blanket order, framework agreement, or master agreement.. Valid values are `value_contract|quantity_contract|scheduling_agreement|blanket_order|framework_agreement|master_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order release to expected delivery at the receiving location. Used for material planning and scheduling.',
    `gmp_required_flag` BOOLEAN COMMENT 'Indicates whether materials supplied under this contract must comply with GMP regulations for pharmaceutical and biotechnology manufacturing. True if GMP compliance is mandatory.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms, risk transfer point, and cost responsibilities between buyer and supplier (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs (e.g., San Diego Port, Frankfurt Airport).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per release or purchase order as agreed with the supplier. Enforces supplier capacity constraints.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per release or purchase order as agreed with the supplier. Enforces supplier MOQ requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last modified. Audit trail for record updates.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the payment schedule and conditions agreed with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Four-character SAP payment terms key.. Valid values are `^[A-Z0-9]{4}$`',
    `plant_code` STRING COMMENT 'Manufacturing or distribution plant for which materials under this contract are procured. Four-character SAP plant code.. Valid values are `^[A-Z0-9]{4}$`',
    `price_adjustment_clause` STRING COMMENT 'Description of the price adjustment mechanism or escalation clause agreed in the contract (e.g., annual CPI adjustment, raw material index-linked pricing).',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for this contract. Three-character code identifying the purchasing group within the organization.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'SAP organizational unit responsible for negotiating and managing this contract. Typically a four-character code representing a procurement division or business unit.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_agreement_reference` STRING COMMENT 'Reference number or identifier of the quality agreement or quality technical agreement (QTA) associated with this contract, defining quality specifications, testing requirements, and acceptance criteria.',
    `regulatory_compliance_notes` STRING COMMENT 'Free-text notes capturing specific regulatory compliance requirements, certifications, or clauses applicable to this contract (e.g., FDA registration, ISO 13485 certification, GDPR data processing terms).',
    `release_strategy` STRING COMMENT 'Strategy for releasing purchase orders or delivery schedules against this contract: automatic (system-triggered), manual (buyer-initiated), scheduled (time-based), forecast-based (demand-driven), or JIT (Just-In-Time).. Valid values are `automatic|manual|scheduled|forecast_based|jit`',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether this contract is eligible for automatic renewal upon expiry. True if renewal is enabled.',
    `renewal_notice_days` STRING COMMENT 'Number of days before contract expiry that renewal notice must be provided to the supplier or by the supplier to continue the contract.',
    `sla_on_time_delivery_target_pct` DECIMAL(18,2) COMMENT 'Target percentage for on-time delivery performance agreed in the SLA. Expressed as a percentage (e.g., 95.00 for 95%).',
    `sla_turnaround_time_hours` STRING COMMENT 'Maximum turnaround time in hours committed by the supplier for order fulfillment or service delivery under this contract. Key SLA metric for performance monitoring.',
    `source_system` STRING COMMENT 'Operational system from which this contract record was sourced (e.g., SAP MM, Oracle Procurement, Ariba, Manual entry).. Valid values are `SAP_MM|Oracle_Procurement|Ariba|Manual`',
    `target_quantity` DECIMAL(18,2) COMMENT 'Total quantity committed under this contract for quantity contracts. Represents the volume of materials or units to be procured over the contract period.',
    `target_value` DECIMAL(18,2) COMMENT 'Total monetary value committed under this contract for value contracts. Represents the maximum spend ceiling or target procurement value over the contract period.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius for storage and transportation of materials under this contract. Applicable for temperature-sensitive reagents and consumables.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius for storage and transportation of materials under this contract. Applicable for temperature-sensitive reagents and consumables.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required to terminate this contract before its natural expiry date, as agreed in the contract terms.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantities specified in this contract (e.g., EA for each, KG for kilogram, L for liter). Aligns with ISO standards and SAP UOM.. Valid values are `^[A-Z]{2,3}$`',
    `validity_end_date` DATE COMMENT 'Date on which the contract expires. After this date, no further releases or purchase orders can be created against this contract unless renewed.',
    `validity_start_date` DATE COMMENT 'Date from which the contract terms become effective and binding. Contract cannot be used for procurement before this date.',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Master procurement contract or scheduling agreement with a supplier defining agreed pricing, volume commitments, delivery cadence, quality requirements, and SLA terms for materials critical to genomics operations. Captures contract number, contract type (value contract, quantity contract, scheduling agreement), validity period, target value, release order strategy, price conditions, and GMP/quality clauses. Enables blanket order releases and long-term supply security. Sourced from SAP MM (EKKO with contract document types).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` (
    `demand_plan_id` BIGINT COMMENT 'Unique identifier for the demand plan record. Primary key for the demand plan entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Demand planning approval workflow requires personnel accountability for forecast commitments and budget implications. Enables approval delegation analysis, planner performance tracking, and audit trai',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Demand plans drive procurement budgets; finance validates forecast-driven budget requests for reagents, consumables, and materials. Enables budget planning, forecast accuracy tracking, and spend autho',
    `material_id` BIGINT COMMENT 'Reference to the material or finished good for which demand is being planned. Links to reagent kits, sequencing consumables, instruments, or other genomics products.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Demand planning incorporates weighted pipeline opportunities, especially for capital equipment with long lead times. Business process: sales & operations planning (S&OP), forecast-to-plan reconciliati',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center where the material is produced or stocked.',
    `previous_plan_demand_plan_id` BIGINT COMMENT 'Reference to the prior version of this demand plan, enabling revision history tracking and audit trail.',
    `approval_status` STRING COMMENT 'Approval state of the demand plan. Indicates whether the plan is pending review, approved by demand planning manager, or rejected for revision.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the demand plan was approved for execution.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'Lower bound of the confidence interval for the forecasted quantity. Represents the minimum expected demand under normal variability.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'Upper bound of the confidence interval for the forecasted quantity. Represents the maximum expected demand under normal variability.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'Statistical confidence level associated with the forecast interval, typically 90%, 95%, or 99%. Indicates the probability that actual demand will fall within the confidence interval.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the demand plan record was first created in the system.',
    `customer_order_backlog_quantity` DECIMAL(18,2) COMMENT 'Quantity of confirmed customer orders not yet fulfilled. Represents committed demand that must be satisfied in the planning period.',
    `demand_category` STRING COMMENT 'Classification of demand type. Independent demand is driven by customer orders (finished goods), dependent demand is driven by production schedules (components), and service parts demand is driven by maintenance and support needs.. Valid values are `independent|dependent|service_parts`',
    `demand_signal_source` STRING COMMENT 'Origin of the demand signal driving the forecast. Indicates whether demand is driven by sales forecasts, production schedules, safety stock replenishment needs, confirmed customer orders, promotional campaigns, or new product launches.. Valid values are `sales_forecast|production_plan|safety_stock_replenishment|customer_order|promotional_campaign|new_product_launch`',
    `forecast_accuracy_percentage` DECIMAL(18,2) COMMENT 'Historical accuracy of the forecast method for this material and plant combination, expressed as a percentage. Used to assess forecast reliability and adjust safety stock levels.',
    `forecast_method` STRING COMMENT 'Methodology used to generate the demand forecast. Indicates whether the forecast was derived from statistical models, consensus planning sessions, MRP net requirements, manual planner input, machine learning algorithms, or historical averages.. Valid values are `statistical|consensus|mrp_driven|manual|machine_learning|historical_average`',
    `forecasted_quantity` DECIMAL(18,2) COMMENT 'Predicted demand quantity for the material during the planning period. Represents units of reagent kits, flow cells, instruments, or other genomics products required to meet anticipated customer orders and production schedules.',
    `lead_time_days` STRING COMMENT 'Number of days required to procure or produce the material. Critical for calculating reorder points and ensuring uninterrupted supply of genomics consumables.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the demand plan record was last updated.',
    `mrp_element_type` STRING COMMENT 'Type of MRP element generated or influenced by this demand plan. Indicates whether the plan drives planned orders, purchase requisitions, production orders, or stock transfers.. Valid values are `planned_order|purchase_requisition|production_order|stock_transfer|none`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the demand plan. Tracks whether the plan is in draft, approved for execution, actively driving procurement, superseded by a newer version, or archived.. Valid values are `draft|approved|active|superseded|archived`',
    `plan_version` STRING COMMENT 'Version identifier for the demand plan, enabling tracking of plan revisions and iterations over time.',
    `planner_name` STRING COMMENT 'Name of the demand planner or supply chain analyst responsible for creating and maintaining this demand plan.',
    `planner_notes` STRING COMMENT 'Free-text notes and comments from the demand planner. May include assumptions, market intelligence, customer feedback, or adjustments made to statistical forecasts.',
    `planning_horizon` STRING COMMENT 'Time granularity of the demand plan. Indicates whether the plan is weekly, monthly, quarterly, or annual.. Valid values are `weekly|monthly|quarterly|annual`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period for which demand is forecasted.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period for which demand is forecasted. Typically aligned with monthly, quarterly, or weekly planning cycles.',
    `procurement_trigger_flag` BOOLEAN COMMENT 'Indicates whether the demand plan has triggered a procurement action. True when forecasted demand exceeds available inventory and requires purchase order creation.',
    `product_lifecycle_stage` STRING COMMENT 'Current stage of the material in its product lifecycle. Influences demand planning strategies, with introduction and growth stages requiring aggressive forecasting and end-of-life stages requiring phase-out planning.. Valid values are `introduction|growth|maturity|decline|end_of_life`',
    `production_plan_quantity` DECIMAL(18,2) COMMENT 'Demand quantity derived from production schedules and manufacturing plans. Represents materials required to support planned production runs of reagent kits, library prep kits, or instrument assembly.',
    `promotional_impact_quantity` DECIMAL(18,2) COMMENT 'Additional demand quantity expected due to promotional campaigns, product launches, or marketing initiatives.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level at which procurement or production should be triggered to replenish stock. Calculated based on lead time demand and safety stock requirements.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking changes to the demand plan over time. Incremented each time the plan is updated.',
    `revision_reason` STRING COMMENT 'Explanation for why the demand plan was revised. Examples include market changes, customer order updates, supply disruptions, or forecast accuracy adjustments.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained to protect against demand variability and supply disruptions. Critical for high-value genomics consumables with long lead times.',
    `sales_forecast_quantity` DECIMAL(18,2) COMMENT 'Demand quantity derived from sales team forecasts and customer pipeline analysis. Represents anticipated customer orders for NGS kits, microarray products, or CRISPR tools.',
    `seasonality_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to baseline forecast to account for seasonal demand patterns. Values greater than 1.0 indicate peak seasons, values less than 1.0 indicate off-peak periods.',
    `supplier_capacity_reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of supplier production capacity reserved based on this demand plan. Ensures critical raw materials and components for genomics products are available when needed.',
    `unit_of_measure` STRING COMMENT 'Unit in which the forecasted quantity is expressed. Examples include EA (each), KIT, BOX, L (liters), or other units relevant to genomics consumables and instruments.',
    CONSTRAINT pk_demand_plan PRIMARY KEY(`demand_plan_id`)
) COMMENT 'Forward-looking demand forecast for materials and finished goods required to support genomics production schedules, reagent kit assembly, and customer order fulfillment. Captures planning period, material, plant, forecasted quantity, forecast method (statistical, consensus, MRP-driven), confidence interval, demand signal source (sales forecast, production plan, safety stock replenishment), revision history, and planner notes. Drives procurement triggers, supplier capacity reservations, and MRP net requirements calculation. Supports uninterrupted supply of critical NGS, microarray, and CRISPR inputs.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order record. Primary key for this entity.',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: Equipment/instrument replenishment orders originate from approved capex requests. Links procurement execution to capital budget authorization, enabling capex spend tracking and project completion veri',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: MRP-generated replenishment orders specify which reagent catalog item needs restocking. Enables demand planning by product, safety stock calculations by reagent type, conversion to purchase requisitio',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Replenishment orders (planned orders from MRP) are converted to purchase orders when released. The replenishment_order table has converted_document_number (STRING) and converted_document_type (STRING)',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center that will be charged for this replenishment order. Links to the financial organizational unit responsible for the procurement cost.',
    `material_id` BIGINT COMMENT 'Reference to the material master record being replenished. Links to the genomics product, reagent, consumable, or component requiring stock replenishment.',
    `plant_id` BIGINT COMMENT 'Reference to the destination plant or manufacturing facility where the material is required. Links to the organizational unit receiving the replenishment.',
    `reagent_subscription_id` BIGINT COMMENT 'Foreign key linking to commercial.reagent_subscription. Business justification: Replenishment orders may be triggered by subscription consumption forecasts or committed volumes. Business process: subscription-driven MRP, automated replenishment for subscription customers, subscri',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: MRP-generated replenishment order requisitioner tracking enables cost center accountability, planner workload analysis, and audit trail for automated procurement. Replaces denormalized requisitioner_',
    `source_plant_id` BIGINT COMMENT 'Reference to the source plant from which material will be transferred. Applicable when source type is internal plant or distribution center. Links to the supplying organizational unit.',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the material will be received. Links to warehouse, cold storage, or controlled environment area.',
    `supplier_id` BIGINT COMMENT 'Reference to the external supplier or vendor from whom the material will be procured. Applicable when source type is external supplier. Links to supplier master data.',
    `batch_managed` BOOLEAN COMMENT 'Flag indicating whether the material is batch-managed requiring lot number tracking and Certificate of Analysis (COA) documentation. True for reagents, consumables, and controlled materials.',
    `cold_chain_required` BOOLEAN COMMENT 'Flag indicating whether the material requires cold chain handling and temperature-controlled logistics. True for temperature-sensitive reagents, enzymes, and biological materials.',
    `conversion_date` DATE COMMENT 'Date when the replenishment order was converted into an execution document such as a purchase order, stock transfer order, or production order. Null if not yet converted.',
    `converted_document_number` STRING COMMENT 'Business identifier of the execution document created from this replenishment order. Purchase order number, stock transfer order number, or production order number. Null if not yet converted.. Valid values are `^[A-Z0-9]{10,20}$`',
    `converted_document_type` STRING COMMENT 'Type of execution document created from this replenishment order. Indicates the downstream procurement or manufacturing process triggered.. Valid values are `purchase_order|stock_transfer_order|production_order|subcontracting_order`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the replenishment order record was first created in the system. Audit trail for order lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost. Standard currency for procurement transactions.. Valid values are `^[A-Z]{3}$`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for fulfilling this replenishment order. Calculated based on material standard cost, last purchase price, or contract price. Used for budget planning and Cost of Goods Sold (COGS) forecasting.',
    `gmp_indicator` BOOLEAN COMMENT 'Flag indicating whether this replenishment order is for Good Manufacturing Practice (GMP) controlled materials requiring enhanced quality and compliance tracking. Critical for regulated genomics products.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the replenishment order record was last updated. Tracks changes to order status, quantities, or dates throughout the procurement lifecycle.',
    `lead_time_days` STRING COMMENT 'Planned procurement or transfer lead time in days from order creation to material availability. Used for scheduling and delivery date calculation.',
    `mrp_controller` STRING COMMENT 'Code identifying the MRP controller or planner responsible for this material and replenishment order. Links to the person or team managing material availability.. Valid values are `^[A-Z0-9]{3}$`',
    `mrp_run_date` DATE COMMENT 'Date when the MRP calculation was executed that generated this replenishment order. Provides traceability to the planning cycle.',
    `notes` STRING COMMENT 'Free-text notes and comments related to the replenishment order. Captures special instructions, handling requirements, or planning considerations.',
    `order_status` STRING COMMENT 'Current lifecycle status of the replenishment order indicating its position in the procurement or transfer workflow. Tracks conversion from planned order to execution document. [ENUM-REF-CANDIDATE: open|converted_to_po|confirmed|partially_fulfilled|fulfilled|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the replenishment order indicating the procurement or transfer mechanism. Determines the execution workflow and system integration path.. Valid values are `purchase_requisition|stock_transfer_order|production_order_trigger|subcontracting_order|consignment_order|pipeline_order`',
    `planned_order_number` STRING COMMENT 'Business identifier for the planned order generated by Material Requirements Planning (MRP) or demand planning system. Externally visible order number used for tracking and reference.. Valid values are `^[A-Z0-9]{10,20}$`',
    `priority` STRING COMMENT 'Business priority level for the replenishment order. Indicates urgency based on stock-out risk, production schedule impact, or customer commitment criticality.. Valid values are `critical|high|normal|low`',
    `purchasing_group` STRING COMMENT 'Code identifying the purchasing group responsible for converting this replenishment order into a purchase order. Links to the procurement team handling supplier negotiations.. Valid values are `^[A-Z0-9]{3}$`',
    `reorder_point_indicator` BOOLEAN COMMENT 'Flag indicating whether this replenishment order was triggered by reaching the reorder point threshold. True if reorder point logic initiated the order.',
    `required_date` DATE COMMENT 'Date by which the material must be available at the destination plant or storage location to meet production or customer demand. Drives procurement lead time calculations.',
    `required_quantity` DECIMAL(18,2) COMMENT 'Quantity of material required to fulfill the replenishment need. Calculated by Material Requirements Planning (MRP) based on demand, safety stock, and reorder point logic.',
    `safety_stock_indicator` BOOLEAN COMMENT 'Flag indicating whether this replenishment order was triggered to maintain safety stock levels. True if the order is for safety stock replenishment, false if for normal demand.',
    `shelf_life_expiration_date` DATE COMMENT 'Expected expiration date for the material based on shelf life and required date. Used for First Expired First Out (FEFO) inventory management and quality control.',
    `source_type` STRING COMMENT 'Classification of the source from which the material will be procured or transferred. Determines whether the order triggers external procurement or internal stock transfer.. Valid values are `external_supplier|internal_plant|distribution_center|contract_manufacturer|consignment_stock`',
    `special_procurement_type` STRING COMMENT 'Classification of special procurement logic applied to this replenishment order. Indicates non-standard procurement scenarios such as consignment, subcontracting, or pipeline materials.. Valid values are `standard|consignment|subcontracting|stock_transfer|pipeline|direct_procurement`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the required quantity. Standard units include EA (each), KG (kilogram), L (liter), BOX, VIAL, KIT, etc.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Internal procurement or transfer order generated by MRP or demand planning to replenish stock of a material at a plant or storage location. Captures planned order number, order type (purchase requisition, stock transfer order, production order trigger), material, required quantity, required date, source plant/supplier, and conversion status (open, converted to PO, confirmed). Bridges demand planning and execution in the SAP MM/PP integration. Sourced from SAP MM (EBAN/EBKN for purchase requisitions).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique identifier for the physical storage location within the warehouse or distribution center. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Storage locations (labs, cold storage, warehouses) are cost centers for overhead allocation. Enables facility cost accounting, space utilization analysis, and overhead rate calculation for costing mod',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Warehouse location setup accountability required for GMP facility qualification and audit trails. Enables personnel accountability for warehouse configuration and training verification for warehouse m',
    `warehouse_id` BIGINT COMMENT 'Reference to the parent warehouse or distribution center facility where this storage location resides.',
    `aisle_number` STRING COMMENT 'Aisle identifier within the warehouse where this storage location resides. Used for warehouse navigation and picking route optimization.. Valid values are `^[A-Z0-9]{1,5}$`',
    `batch_managed_indicator` BOOLEAN COMMENT 'Flag indicating whether inventory stored in this location requires batch or lot number tracking. True if batch management is enforced for traceability and quality control. Critical for reagents, flow cells, and consumables subject to Certificate of Analysis (COA) requirements.',
    `bin_location` STRING COMMENT 'Specific bin, shelf, or pallet position within the storage section. Represents the most granular physical address for inventory placement (e.g., A12-R03-B05).. Valid values are `^[A-Z0-9-]{1,20}$`',
    `blocked_indicator` BOOLEAN COMMENT 'Flag indicating whether the storage location is currently blocked for use due to maintenance, damage, temperature excursion, or other operational issues. True if location is unavailable for inventory placement or retrieval.',
    `blocked_reason` STRING COMMENT 'Free-text explanation for why the storage location is blocked (e.g., Temperature excursion detected, Structural damage, Scheduled maintenance). Populated only when blocked_indicator is True.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location in cubic meters. Used for space utilization planning and warehouse optimization.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms. Used for load planning and safety compliance to prevent structural overload.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the warehouse management system. Used for audit trail and data lineage.',
    `current_utilization_percent` DECIMAL(18,2) COMMENT 'Current utilization of the storage location as a percentage of total capacity (weight or volume). Calculated based on inventory currently stored. Used for warehouse efficiency KPIs and replenishment planning.',
    `cycle_count_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location is included in regular cycle counting programs for inventory accuracy verification. True if location is subject to periodic physical counts.',
    `fefo_enforcement` BOOLEAN COMMENT 'Flag indicating whether First Expired First Out (FEFO) inventory rotation is enforced for this storage location. True if the WMS must prioritize inventory with the earliest expiration date for picking. Used for biological reagents, enzymes, and flow cells with strict shelf-life requirements.',
    `fifo_enforcement` BOOLEAN COMMENT 'Flag indicating whether First In First Out (FIFO) inventory rotation is enforced for this storage location. True if the warehouse management system (WMS) must prioritize oldest inventory for picking. Critical for reagents and consumables with limited shelf life.',
    `gmp_zone_classification` STRING COMMENT 'GMP cleanliness classification for the storage location. Grade A (highest sterility) for aseptic operations, Grade B for background environment for Grade A, Grade C and D for less critical manufacturing steps, non_gmp for non-regulated storage. Required for IVD and RUO product manufacturing compliance.. Valid values are `non_gmp|grade_d|grade_c|grade_b|grade_a`',
    `hazard_class` STRING COMMENT 'UN hazard classification for materials stored in this location (e.g., 3 for flammable liquids, 6.2 for infectious substances, 8 for corrosives). Used for segregation and emergency response planning.. Valid values are `^[1-9](.[1-6])?$`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location is designated for hazardous materials. True if the location is certified for hazmat storage per regulatory requirements.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent cycle count performed for this storage location. Used to schedule next cycle count and monitor inventory accuracy compliance.',
    `level_number` STRING COMMENT 'Vertical level or shelf position within the rack (e.g., 1 for ground level, 2 for first shelf above ground). Used for ergonomic picking optimization and safety compliance.',
    `location_status` STRING COMMENT 'Current operational status of the storage location. Active for normal use, inactive for temporarily unused, blocked for operational issues, quarantine for QC hold, maintenance for scheduled work, decommissioned for permanently retired locations.. Valid values are `active|inactive|blocked|quarantine|maintenance|decommissioned`',
    `mixed_storage_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location allows multiple Stock Keeping Units (SKUs) to be stored simultaneously. True if mixed SKU storage is permitted, False if location is dedicated to a single SKU.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this storage location record. Used for change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last modified. Used for change tracking and audit compliance.',
    `picking_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location is designated for active picking operations (order fulfillment). True if location is in the pick zone, False if it is a reserve or bulk storage location.',
    `picking_strategy` STRING COMMENT 'WMS strategy for selecting inventory from this storage location during order fulfillment. FIFO for oldest first, FEFO for earliest expiration first, LIFO for last in first out, nearest_location for travel optimization, highest_stock for inventory balancing.. Valid values are `fifo|fefo|lifo|nearest_location|highest_stock`',
    `putaway_strategy` STRING COMMENT 'Warehouse management system (WMS) strategy for directing incoming inventory to this storage location. Fixed_bin for dedicated SKU locations, next_empty_bin for dynamic allocation, bulk_storage for pallet-level storage, high_rack for vertical storage systems, floor_storage for oversized items.. Valid values are `fixed_bin|next_empty_bin|bulk_storage|high_rack|floor_storage`',
    `quarantine_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location is designated for quarantined inventory pending quality control (QC) release or investigation. True if location is restricted for quarantine use only.',
    `rack_number` STRING COMMENT 'Rack or shelving unit identifier within the aisle. Used for precise physical location addressing.. Valid values are `^[A-Z0-9]{1,5}$`',
    `replenishment_indicator` BOOLEAN COMMENT 'Flag indicating whether this storage location requires automatic replenishment from reserve storage when inventory falls below a threshold. True if location is part of an automated replenishment strategy.',
    `serial_number_managed_indicator` BOOLEAN COMMENT 'Flag indicating whether inventory stored in this location requires serial number tracking at the individual unit level. True if serial number management is enforced. Used for high-value instruments, flow cells, and components requiring unit-level traceability.',
    `storage_incompatibilities` STRING COMMENT 'Comma-separated list of hazard classes or material types that must NOT be stored in proximity to this location due to chemical incompatibility (e.g., acids,oxidizers). Used to enforce segregation rules and prevent dangerous reactions.',
    `storage_location_code` STRING COMMENT 'Business identifier for the storage location, typically a combination of warehouse number, aisle, rack, and bin identifiers (e.g., WH01-A12-R03-B05). Used for operational picking and putaway instructions.. Valid values are `^[A-Z0-9]{4,10}$`',
    `storage_section` STRING COMMENT 'Logical subdivision within the warehouse (e.g., aisle, zone, or area designation) used to organize storage locations by product category, temperature zone, or operational workflow.. Valid values are `^[A-Z0-9]{1,10}$`',
    `storage_type` STRING COMMENT 'Classification of the storage environment based on temperature control and regulatory requirements. Ambient for room temperature, refrigerated for 2–8°C, frozen for −20°C or −80°C, ultra_cold for liquid nitrogen storage, hazmat for hazardous materials, gmp_controlled for Good Manufacturing Practice (GMP) zones.. Valid values are `ambient|refrigerated|frozen|ultra_cold|hazmat|gmp_controlled`',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for this storage location. Excursions beyond this threshold trigger quality alerts and potential quarantine of affected inventory.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for this storage location. Used for cold-chain monitoring and compliance validation.',
    `temperature_zone` STRING COMMENT 'Controlled temperature range for the storage location. Critical for cold-chain management of biological reagents, flow cells, enzymes, and CRISPR components. Values: ambient (15–25°C), 2_to_8_celsius (refrigerated), minus_20_celsius (frozen), minus_80_celsius (ultra-frozen), liquid_nitrogen (−196°C).. Valid values are `ambient|2_to_8_celsius|minus_20_celsius|minus_80_celsius|liquid_nitrogen`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials stored in this location (e.g., UN1170 for ethanol). Required for transport and storage compliance of dangerous goods.. Valid values are `^UN[0-9]{4}$`',
    `x_coordinate` DECIMAL(18,2) COMMENT 'X-axis coordinate of the storage location within the warehouse floor plan (in meters). Used for automated guided vehicle (AGV) navigation and warehouse mapping.',
    `y_coordinate` DECIMAL(18,2) COMMENT 'Y-axis coordinate of the storage location within the warehouse floor plan (in meters). Used for AGV navigation and warehouse mapping.',
    `z_coordinate` DECIMAL(18,2) COMMENT 'Z-axis (height) coordinate of the storage location within the warehouse (in meters). Used for vertical storage systems and automated retrieval systems.',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Master record for physical storage locations within Genomics Biotech warehouses and distribution centers — including ambient, refrigerated (2–8°C), frozen (−20°C, −80°C), and ultra-cold (liquid nitrogen) zones required for biological reagents, flow cells, and CRISPR components. Captures warehouse number, storage type, storage section, bin location, temperature zone, capacity (weight/volume), hazardous material classification (UN number, hazard class, storage incompatibilities), GMP zone classification, and current utilization. Supports cold-chain zone management and regulatory compliance for transport/storage of hazardous genomics inputs. Sourced from SAP WM/EWM.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Supplier qualification scope often tied to specific product approvals and manufacturing authorizations. Needed to verify supplier is qualified for materials used in approved products, supporting suppl',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Supplier qualification records are created/updated based on GMP audits. The qualification must reference the audit that established approved status, scope, and findings for regulatory defense and re-q',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Supplier audit findings requiring corrective action must be tracked via CAPA. Qualification status (approved/suspended) depends on CAPA closure. Essential for supplier risk management and audit readin',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supplier qualification ownership tracking required for quality system compliance, audit trails, and personnel workload analysis. Enables qualification review assignment and personnel accountability fo',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Suppliers of genomic reference materials (characterized cell lines, DNA standards, control samples) must be qualified against the genome builds their materials represent. Qualification scope documents',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to finance.sox_control. Business justification: Supplier qualification is a SOX-relevant control for procurement integrity in regulated biotech. Links qualification process to SOX control testing, audit evidence, and compliance attestation for fina',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being qualified. Links to the supplier master record.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier qualification was formally approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person (typically Quality Assurance manager or Director) who approved the supplier qualification.',
    `approved_material_scope` STRING COMMENT 'Description of the material categories, product families, or specific Stock Keeping Units (SKUs) for which the supplier is qualified. May reference material groups, reagent types, consumable categories, or instrument components.',
    `audit_date` DATE COMMENT 'Date of the most recent supplier audit (on-site or remote) that contributed to this qualification decision. Nullable if qualification was not audit-based.',
    `audit_findings_summary` STRING COMMENT 'Summary of key findings from the supplier audit, including observations, non-conformances, and areas of concern. May reference detailed audit report stored in Veeva Vault.',
    `audit_type` STRING COMMENT 'Type of audit conducted: on-site (physical visit to supplier facility), remote (virtual audit), desktop (document review only), hybrid (combination), or not_applicable (no audit conducted for this qualification).. Valid values are `on-site|remote|desktop|hybrid|not_applicable`',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the supplier must complete and submit evidence of corrective actions. Nullable if no corrective actions are required.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions are required from the supplier as a condition of qualification or to maintain qualification status.',
    `corrective_action_status` STRING COMMENT 'Current status of required corrective actions: not_required (no CAPA needed), open (CAPA assigned but not started), in_progress (supplier working on CAPA), submitted (supplier submitted evidence), verified (CAPA effectiveness verified), closed (CAPA complete), or overdue (past due date). [ENUM-REF-CANDIDATE: not_required|open|in_progress|submitted|verified|closed|overdue — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this supplier qualification record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances identified during the audit. Critical findings typically require immediate corrective action and may result in conditional or suspended qualification.',
    `document_reference` STRING COMMENT 'Reference identifier or hyperlink to the detailed supplier qualification documentation stored in Veeva Vault or document management system. May include audit reports, qualification protocols, and supporting evidence.',
    `effective_date` DATE COMMENT 'Date from which the supplier qualification becomes effective and the supplier is authorized to supply materials or services.',
    `expiry_date` DATE COMMENT 'Date on which the supplier qualification expires and re-qualification is required. Nullable for indefinite qualifications subject to periodic review.',
    `fda_registered` BOOLEAN COMMENT 'Indicates whether the supplier is registered with the U.S. Food and Drug Administration (FDA) as required for suppliers of medical device components or In Vitro Diagnostic (IVD) materials.',
    `gmp_scope` STRING COMMENT 'Indicates whether the supplier qualification covers Good Manufacturing Practice (GMP) controlled supply: full (all materials under GMP), partial (specific materials or processes under GMP), or not_applicable (non-GMP materials).. Valid values are `full|partial|not_applicable`',
    `iso_13485_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 13485 certification for medical devices quality management system.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 9001 certification for general quality management system.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances identified during the audit. Major findings require corrective action within a defined timeframe.',
    `material_group_code` STRING COMMENT 'SAP Material Management (MM) material group code representing the category of materials the supplier is qualified to provide (e.g., reagents, consumables, flow cells, library prep kits).. Valid values are `^[A-Z0-9]{4,10}$`',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or observations identified during the audit. Minor findings are tracked for continuous improvement.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this supplier qualification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this supplier qualification record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification of the supplier. Ensures ongoing compliance and performance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the supplier qualification. May include restrictions, special handling requirements, or historical context.',
    `qualification_date` DATE COMMENT 'Date on which the supplier was formally qualified or the qualification decision was made.',
    `qualification_number` STRING COMMENT 'Business identifier for the supplier qualification record, typically generated by Veeva Vault or SAP QM (Quality Management) module. Format: SQ-NNNNNNNN.. Valid values are `^SQ-[0-9]{8}$`',
    `qualification_owner` STRING COMMENT 'Name or identifier of the Quality Assurance (QA) or procurement professional responsible for managing this supplier qualification record.',
    `qualification_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the supplier based on qualification assessment criteria (e.g., audit results, documentation completeness, certifications, past performance). Scale typically 0-100.',
    `qualification_status` STRING COMMENT 'Current status of the supplier qualification: approved (fully qualified), conditional (qualified with restrictions or corrective actions required), suspended (temporarily not approved), disqualified (failed qualification), pending (awaiting decision), or under_review (evaluation in progress).. Valid values are `approved|conditional|suspended|disqualified|pending|under_review`',
    `qualification_type` STRING COMMENT 'Type of supplier qualification process conducted: initial (first-time qualification), re-qualification (periodic renewal), audit-based (triggered by on-site audit), risk-based (triggered by risk assessment), expedited (fast-track for low-risk suppliers), or conditional (qualified with restrictions).. Valid values are `initial|re-qualification|audit-based|risk-based|expedited|conditional`',
    `regulatory_body_alignment` STRING COMMENT 'Comma-separated list of regulatory bodies and standards to which this supplier qualification aligns (e.g., FDA, EMA, ISO 13485, ISO 9001, CLIA, CAP). Indicates the regulatory frameworks under which the supplier is qualified.',
    `reinstatement_date` DATE COMMENT 'Date on which a previously suspended supplier qualification was reinstated following successful corrective actions. Nullable if never suspended or not yet reinstated.',
    `review_frequency_months` STRING COMMENT 'Frequency (in months) at which the supplier qualification must be reviewed or renewed. Typically 12, 24, or 36 months depending on risk tier and regulatory requirements.',
    `risk_tier` STRING COMMENT 'Risk classification of the supplier based on the criticality of supplied materials, regulatory requirements, and supply chain impact: critical (single-source GMP materials), high (GMP or critical non-GMP), medium (important non-GMP), or low (commodity materials).. Valid values are `critical|high|medium|low`',
    `suspension_date` DATE COMMENT 'Date on which the supplier qualification was suspended or revoked. Nullable if never suspended.',
    `suspension_reason` STRING COMMENT 'Reason for suspension or disqualification of the supplier, if applicable. May include quality issues, audit failures, regulatory non-compliance, or business reasons. Nullable if status is not suspended or disqualified.',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Record of the formal qualification and approval status of a supplier for specific material categories or GMP-controlled supply. Captures qualification type (initial, re-qualification, audit-based), qualification date, expiry date, approved material scope, audit findings summary, corrective action requirements, qualification status (approved, conditional, suspended, disqualified), and regulatory body alignment (FDA, EMA, ISO 13485). Ensures only qualified suppliers provide critical genomics inputs. Sourced from Veeva Vault / SAP QM.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` (
    `supplier_performance_id` BIGINT COMMENT 'Unique identifier for the supplier performance scorecard record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supplier scorecard approval authority tracking required for quality system compliance and procurement decision audit trails. Enables approval delegation analysis and personnel accountability for suppl',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being evaluated in this performance scorecard.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier performance scorecard was formally approved and published.',
    `audit_score` STRING COMMENT 'Most recent supplier audit score (0-100) from quality or regulatory audit conducted during or prior to the evaluation period.',
    `avg_response_time_hours` DECIMAL(18,2) COMMENT 'Average time in hours for the supplier to respond to quality notifications and technical inquiries during the evaluation period.',
    `coa_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments accompanied by complete and accurate Certificate of Analysis documentation meeting GMP requirements.',
    `cold_chain_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of temperature-sensitive shipments that maintained required cold chain conditions throughout transit, critical for reagent integrity.',
    `corrective_action_closure_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of corrective actions from quality notifications that were closed on time with effective root cause analysis and preventive measures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier performance scorecard record was first created in the system.',
    `critical_deviation_count` STRING COMMENT 'Number of critical or major quality deviations that posed significant risk to product quality or regulatory compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total purchase order value.. Valid values are `^[A-Z]{3}$`',
    `deviation_count` STRING COMMENT 'Total number of quality deviations raised against this supplier during the evaluation period.',
    `documentation_completeness_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments accompanied by complete regulatory and quality documentation including COA, SDS, and compliance certificates.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period for this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period for this scorecard.',
    `evaluator_email` STRING COMMENT 'Email address of the evaluator responsible for this scorecard.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `evaluator_name` STRING COMMENT 'Name of the procurement or quality professional who prepared and approved this performance scorecard.',
    `improvement_action_description` STRING COMMENT 'Description of required improvement actions, development programs, or corrective measures to be implemented with the supplier.',
    `improvement_action_required_flag` BOOLEAN COMMENT 'Indicates whether formal supplier improvement actions or development programs are required based on scorecard results.',
    `in_full_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered with complete quantities as ordered during the evaluation period.',
    `incoming_quality_acceptance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of received lots that passed incoming quality inspection on first attempt without rejection or rework.',
    `innovation_contribution_score` STRING COMMENT 'Qualitative score (0-100) assessing the suppliers contribution to product innovation, process improvements, and technical collaboration during the period.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or GMP audit conducted at the supplier facility.',
    `late_delivery_count` STRING COMMENT 'Number of purchase order line items delivered after the committed delivery date.',
    `lead_time_adherence_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of orders delivered within the contracted standard lead time window.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier performance scorecard record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next supplier performance review or scorecard update.',
    `notes` STRING COMMENT 'Additional comments, context, or qualitative observations about supplier performance during the evaluation period.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the committed delivery date during the evaluation period.',
    `otif_rate_pct` DECIMAL(18,2) COMMENT 'Combined metric representing the percentage of orders delivered both on time and in full, a key supply chain KPI for genomics materials.',
    `partial_delivery_count` STRING COMMENT 'Number of purchase order line items delivered with incomplete quantities requiring follow-up shipments.',
    `performance_tier` STRING COMMENT 'Overall performance classification tier assigned to the supplier based on scorecard results, driving sourcing strategy and supplier development programs.. Valid values are `strategic|preferred|approved|conditional|at_risk|disqualified`',
    `price_variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance between contracted prices and actual invoiced prices during the evaluation period, indicating pricing stability.',
    `purchasing_group` STRING COMMENT 'SAP purchasing group code responsible for procurement activities with this supplier.',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization code responsible for managing this supplier relationship.',
    `rejected_lot_count` STRING COMMENT 'Number of material lots rejected during incoming inspection due to quality failures.',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the supplier performance scorecard.. Valid values are `draft|published|under_review|approved|archived`',
    `sla_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Overall percentage of contracted SLA metrics met during the evaluation period across delivery, quality, and service dimensions.',
    `total_po_count` STRING COMMENT 'Total number of purchase orders issued to this supplier during the evaluation period.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of all purchase orders issued to this supplier during the evaluation period.',
    CONSTRAINT pk_supplier_performance PRIMARY KEY(`supplier_performance_id`)
) COMMENT 'Periodic scorecard record measuring a suppliers delivery, quality, and service performance against contracted SLAs. Captures evaluation period, supplier reference, on-time delivery rate, in-full delivery rate (OTIF), incoming quality acceptance rate, COA compliance rate, number of deviations raised, response time to quality notifications, and overall performance tier (strategic, preferred, approved, at-risk). Drives supplier development programs and sourcing decisions for critical genomics materials.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` (
    `sourcing_agreement_id` BIGINT COMMENT 'Unique identifier for this sourcing agreement record. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to the material being sourced in this agreement',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier party in this sourcing agreement',
    `agreement_effective_date` DATE COMMENT 'Date when this sourcing agreement became effective and available for procurement use.',
    `agreement_expiration_date` DATE COMMENT 'Date when this sourcing agreement expires. After expiration, the supplier-material combination must be re-qualified or the agreement renewed.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this sourcing agreement. ACTIVE=Available for procurement, INACTIVE=Not currently used, SUSPENDED=Temporarily blocked, EXPIRED=Past expiration date.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this sourcing agreement record was created in the system.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this sourcing agreement record was last updated.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed with this supplier for this material. Used to identify inactive sourcing relationships and trigger re-qualification if needed.',
    `last_purchase_price` DECIMAL(18,2) COMMENT 'Actual unit price paid on the most recent purchase order for this supplier-material combination. Used for price variance analysis and negotiation benchmarking.',
    `lead_time_days` STRING COMMENT 'Negotiated lead time in calendar days from PO placement to delivery for this specific supplier-material combination. Overrides the suppliers standard lead time when material-specific terms apply.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity that this supplier can fulfill for this material in a single order, in the materials base unit of measure. Reflects supplier capacity constraints for this specific material.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this supplier for this material, in the materials base unit of measure. Specific to the supplier-material pairing.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred source for this material based on quality, price, reliability, or strategic relationship. Used by MRP and procurement to prioritize sourcing decisions.',
    `price_validity_end_date` DATE COMMENT 'End date of the current negotiated price validity period. After this date, the price must be renegotiated or the agreement becomes inactive.',
    `price_validity_start_date` DATE COMMENT 'Start date of the current negotiated price validity period for this supplier-material agreement. Prices are time-bound and require renegotiation after expiry.',
    `qualification_status` STRING COMMENT 'Current qualification status of this supplier for this specific material. QUALIFIED=Approved for production use, CONDITIONAL=Approved with restrictions, UNDER_EVALUATION=In qualification process, DISQUALIFIED=Not approved. Material-specific qualification is separate from general supplier certification.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this material from this supplier, in the suppliers currency. This price is specific to the supplier-material combination and cannot be stored on supplier (varies by material) or material (varies by supplier).',
    CONSTRAINT pk_sourcing_agreement PRIMARY KEY(`sourcing_agreement_id`)
) COMMENT 'This association product represents the sourcing agreement or approved supplier list (ASL) entry between a supplier and a material. It captures negotiated commercial terms, lead times, qualification status, and pricing that exist only in the context of a specific supplier-material combination. Each record links one supplier to one material with procurement terms that cannot be stored on supplier alone (varies by material) or material alone (varies by supplier). This is the operational SSOT for multi-sourcing decisions and procurement execution.. Existence Justification: In genomics biotech procurement operations, materials are routinely multi-sourced from multiple qualified suppliers, each with negotiated pricing, lead times, and minimum order quantities specific to that supplier-material combination. Conversely, each supplier provides multiple materials to the organization. Procurement teams actively manage these sourcing agreements as operational entities - they negotiate terms per supplier-material pair, maintain approved supplier lists (ASLs) per material, track qualification status, and execute sourcing decisions based on price, lead time, and supplier performance for each specific material.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`contract_line` (
    `contract_line_id` BIGINT COMMENT 'Unique identifier for this contract line item record. Primary key.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to the specific reagent catalog item covered by this contract line',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to the master supplier contract under which this line item is defined',
    `contract_line_number` STRING COMMENT 'Business-visible line item number within the contract. Typically a sequential number (00010, 00020, etc.) used in SAP MM contract line items.',
    `contracted_quantity` DECIMAL(18,2) COMMENT 'Total quantity of this specific reagent committed under this contract line. For quantity contracts, this represents the target quantity to be released over the contract validity period.',
    `contracted_unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this reagent under this contract. This is the price used for purchase order releases and invoice validation. Price may include volume-based tiers or discounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted unit price (e.g., USD, EUR, GBP).',
    `incoterms` STRING COMMENT 'Incoterms code specific to this contract line, defining delivery terms and risk transfer point. May override master contract incoterms for specific reagents requiring special handling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract line record was last updated. Used for change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order release to expected delivery for this specific reagent from this supplier. Used for MRP planning and delivery date calculation.',
    `line_status` STRING COMMENT 'Current lifecycle status of this contract line: active (available for releases), suspended (temporarily blocked), expired (validity period ended), closed (manually closed or quantity exhausted).',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per release for this specific reagent. May be constrained by supplier capacity or storage limitations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per release for this specific reagent as agreed with the supplier. Enforced during purchase order creation.',
    `price_condition_type` STRING COMMENT 'SAP pricing condition type code defining how the contracted price is applied (e.g., PB00 for gross price, RA01 for discount). Used for invoice verification.',
    `quantity_released_to_date` DECIMAL(18,2) COMMENT 'Cumulative quantity released against this contract line via purchase orders. Used to track contract utilization and remaining quantity available.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities and pricing on this contract line (e.g., EA for each, KIT for kit, L for liter). Must align with reagent catalog UOM or have a defined conversion factor.',
    `validity_end_date` DATE COMMENT 'Date on which this contract line expires. After this date, no further releases can be made against this line. May differ from master contract end date.',
    `validity_start_date` DATE COMMENT 'Date from which this contract line becomes effective. May differ from the master contract start date if line items are added via amendments.',
    `value_released_to_date` DECIMAL(18,2) COMMENT 'Cumulative monetary value released against this contract line. Calculated as sum of (quantity × unit_price) across all purchase order releases.',
    CONSTRAINT pk_contract_line PRIMARY KEY(`contract_line_id`)
) COMMENT 'This association product represents the line-item-level contract terms between a supplier contract and a specific reagent catalog item. It captures the contracted pricing, quantities, lead times, and validity periods that are negotiated per supplier-reagent combination. Each record links one supplier contract to one reagent catalog item with attributes that exist only in the context of this specific contractual relationship. This is the operational record used for contract compliance validation, price verification during procurement, and supplier performance tracking.. Existence Justification: In genomics biotech procurement operations, supplier contracts are structured with multiple line items, each covering a specific reagent catalog item with its own negotiated pricing, quantities, lead times, and validity periods. A single blanket contract (e.g., annual agreement with a reagent supplier) covers multiple reagent SKUs (flow cells, library prep kits, enzymes), and conversely, a single reagent can be sourced under multiple contracts from different suppliers or under overlapping contract periods for supply security. The business actively manages these contract lines for price validation, release order creation, and supplier performance tracking.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` (
    `supplier_reagent_qualification_id` BIGINT COMMENT 'Unique identifier for this supplier-reagent qualification association record. Primary key.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to the specific reagent catalog item that this supplier is qualified to provide',
    `supplier_qualification_id` BIGINT COMMENT 'Foreign key linking to the supplier qualification record that establishes the suppliers overall qualification status and audit history',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this supplier-reagent qualification was formally approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this specific supplier-reagent qualification.',
    `approved_material_scope` STRING COMMENT 'Description of the specific material categories or SKUs within this reagent that the supplier is qualified to provide. Moved from supplier_qualification because scope is specific to each reagent qualification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier-reagent qualification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this supplier-reagent qualification becomes effective and the supplier is approved to supply this reagent. Moved from supplier_qualification because effective dates are specific to each supplier-reagent pairing.',
    `expiry_date` DATE COMMENT 'Date on which this supplier-reagent qualification expires and re-qualification is required for this specific reagent. Moved from supplier_qualification because expiry dates vary by material scope.',
    `gmp_scope` STRING COMMENT 'Indicates whether this supplier qualification for this reagent covers Good Manufacturing Practice (GMP) requirements. Moved from supplier_qualification because GMP scope varies by reagent type and intended use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier-reagent qualification record was last updated.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order placed with this supplier for this reagent. Used to track active vs inactive supplier-reagent relationships.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days for this supplier to deliver this reagent. Varies by supplier-reagent combination and is critical for inventory planning.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this supplier for this reagent. Varies by supplier terms and reagent type.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred source for this reagent among multiple qualified suppliers. Used for procurement routing and AVL prioritization.',
    `qualification_date` DATE COMMENT 'Date on which this specific supplier was formally qualified to supply this specific reagent. Moved from supplier_qualification because qualification dates vary by reagent scope.',
    `qualification_owner` STRING COMMENT 'Name or identifier of the Quality Assurance or procurement professional responsible for managing this supplier-reagent qualification relationship.',
    `qualification_status` STRING COMMENT 'Current status of this supplier-reagent qualification: approved (fully qualified), conditional (qualified with restrictions), suspended (temporarily not approved), disqualified (approval revoked). Moved from supplier_qualification because status can vary by reagent.',
    `risk_tier` STRING COMMENT 'Risk classification of this supplier-reagent pairing based on the criticality of the reagent and supplier reliability. Moved from supplier_qualification because risk tier is assessed per supplier-reagent combination.',
    `unit_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this reagent from this supplier. Critical for procurement decision-making and cost optimization across qualified suppliers.',
    CONSTRAINT pk_supplier_reagent_qualification PRIMARY KEY(`supplier_reagent_qualification_id`)
) COMMENT 'This association product represents the formal qualification and approval of a specific supplier to provide a specific reagent catalog item. It captures the qualification scope, effective dates, GMP classification, risk tier, and approval status that exist only in the context of this supplier-reagent pairing. Each record links one supplier qualification to one reagent catalog item, enabling Approved Vendor List (AVL) management and procurement compliance tracking.. Existence Justification: In genomics biotech operations, suppliers undergo qualification processes that are scoped to specific reagent categories or individual reagent catalog items. A single supplier qualification record can cover multiple reagents (e.g., a supplier qualified for all PCR enzymes), and a single reagent can be sourced from multiple qualified suppliers with different pricing, lead times, and risk profiles. The business actively manages Approved Vendor Lists (AVLs) that track which suppliers are qualified to provide which reagents, with qualification dates, expiry dates, GMP scope, and approval status specific to each supplier-reagent pairing.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` (
    `batch_quality_test_id` BIGINT COMMENT 'Unique identifier for this specific test execution. Primary key for the batch quality test association.',
    `asset_id` BIGINT COMMENT 'Identifier of the laboratory instrument or equipment used to perform this test. Required for equipment qualification traceability.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to the batch being tested',
    `approval_date` TIMESTAMP COMMENT 'Date and time when this test result was officially approved by QA. Batch cannot be released until all critical tests are approved.',
    `approved_by` STRING COMMENT 'Identifier of the QA supervisor or manager who reviewed and approved this test result. Required for batch release authorization.',
    `deviation_number` STRING COMMENT 'Reference to the formal deviation record if this test failed or produced out-of-specification results. Links to deviation management system for investigation and CAPA.',
    `pass_fail_status` STRING COMMENT 'Determination of whether the batch met the quality rule specification. PASS indicates compliance, FAIL indicates non-compliance, CONDITIONAL_PASS indicates acceptable with deviation, PENDING indicates test not yet complete.',
    `retest_required` BOOLEAN COMMENT 'Indicates whether this test must be repeated due to inconclusive results, equipment failure, or approaching retest date. Triggers retest workflow.',
    `test_date` TIMESTAMP COMMENT 'Date and time when this quality rule test was executed against the batch. Critical for traceability and compliance documentation.',
    `test_method_reference` STRING COMMENT 'Reference to the specific test method, SOP, or analytical procedure used to execute this test. May vary by laboratory or equipment.',
    `test_notes` STRING COMMENT 'Free-text notes from the analyst regarding test execution, observations, or contextual information relevant to interpreting the result.',
    `test_result_value` DECIMAL(18,2) COMMENT 'The actual measured or observed value from executing this quality rule test on the batch. May be numeric, categorical, or descriptive depending on the rule type.',
    `tested_by` STRING COMMENT 'Identifier of the QA analyst, laboratory technician, or automated system that performed this test. Required for GxP compliance and audit trail.',
    CONSTRAINT pk_batch_quality_test PRIMARY KEY(`batch_quality_test_id`)
) COMMENT 'This association product represents the Quality Test Event between batch and quality_rule. It captures the execution and results of a specific quality rule test performed on a specific batch. Each record links one batch to one quality_rule with test execution details, results, pass/fail determination, and deviation tracking that exist only in the context of this specific test execution.. Existence Justification: In genomics biotech manufacturing, each batch must be tested against multiple quality specifications (completeness checks, purity thresholds, potency assays, sterility tests, etc.) before release, and each quality rule is applied to many batches over time. The business actively manages test execution records with specific results, pass/fail determinations, analyst assignments, and deviation tracking for each batch-rule combination. This is an operational quality control process, not an analytical correlation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` (
    `material_qualification_id` BIGINT COMMENT 'Unique identifier for the material qualification record. Primary key.',
    `assessor_employee_id` BIGINT COMMENT 'Employee ID of the qualified assessor who conducted the competency evaluation and granted the qualification. Required for GMP audit trail.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who holds the qualification',
    `material_id` BIGINT COMMENT 'Foreign key linking to the material master record that requires qualified handling',
    `certification_number` STRING COMMENT 'Unique certification or qualification reference number issued by training system or regulatory body. Required for audit documentation.',
    `competency_level` STRING COMMENT 'Level of competency achieved for handling this material. Basic=supervised use only, Intermediate=independent use, Advanced=complex procedures, Expert=troubleshooting, Trainer=can qualify others.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was created in the system. Used for audit trail and data lineage.',
    `expiry_date` DATE COMMENT 'Date on which the qualification expires and requires renewal. Critical for compliance scheduling and personnel availability planning.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent competency reassessment or proficiency check for this material. Used to track ongoing competency maintenance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified. Used for audit trail and change tracking.',
    `next_assessment_due_date` DATE COMMENT 'Date by which the next competency reassessment must be completed to maintain qualification status. Used for scheduling and compliance alerts.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or additional context for this qualification (e.g., Qualified for use in cleanroom only, Requires buddy system).',
    `qualification_date` DATE COMMENT 'Date on which the employee was qualified to handle this specific material. Sourced from training system or competency assessment records.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification. Active=currently valid, Expired=requires renewal, Suspended=temporarily invalid, Pending_Renewal=in renewal process, Revoked=permanently removed.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory requirement driving this qualification (e.g., GMP, CLIA, OSHA Hazard Communication, DEA Controlled Substance). Links qualification to compliance framework.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total hours of training completed for this specific material qualification. Used for compliance reporting and competency documentation.',
    CONSTRAINT pk_material_qualification PRIMARY KEY(`material_qualification_id`)
) COMMENT 'This association product represents the qualification relationship between materials and employees in genomics biotech operations. It captures personnel qualification and competency tracking for handling specific materials (reagents, controlled substances, hazardous materials) in compliance with GMP, CLIA, and safety regulations. Each record links one material to one employee with qualification status, dates, competency level, and training details that exist only in the context of this relationship.. Existence Justification: In genomics biotech operations, material handling qualifications represent a true many-to-many operational relationship. Each employee can be qualified to handle multiple materials (reagents, controlled substances, hazardous chemicals), and each material requires multiple qualified personnel for operational continuity, shift coverage, and regulatory compliance. The qualification itself is a managed business entity with lifecycle attributes (qualification date, expiry, status, competency level, assessor) that belong to neither the material nor the employee alone.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `parent_plant_id` BIGINT COMMENT 'Self-referencing FK on plant (parent_plant_id)',
    `address` STRING COMMENT 'Street address of the plant location.',
    `capacity_per_year` DECIMAL(18,2) COMMENT 'Maximum number of units the plant can produce in a calendar year.',
    `certification_iso_13485_expiry` DATE COMMENT 'Expiration date of the ISO 13485 certification.',
    `certification_iso_13485_status` STRING COMMENT 'Current status of ISO 13485 (medical device quality) certification.',
    `city` STRING COMMENT 'City where the plant is located.',
    `cold_chain_capability` BOOLEAN COMMENT 'Indicates whether the plant can handle temperature‑controlled products.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier for financial reporting.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the plant location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the data lake.',
    `emergency_contact_email` STRING COMMENT 'Email address for the plants emergency contact.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the plants emergency contact.',
    `energy_consumption_mwh_per_year` DECIMAL(18,2) COMMENT 'Total electricity consumption per year measured in megawatt‑hours.',
    `labor_headcount` STRING COMMENT 'Total number of employees assigned to the plant.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last data quality audit for this plant record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the plant (decimal degrees).',
    `lease_expiry_date` DATE COMMENT 'Date when the current lease agreement ends (if applicable).',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the plant (decimal degrees).',
    `manager_email` STRING COMMENT 'Primary email address for the plant manager.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the plant manager.',
    `plant_name` STRING COMMENT 'Human‑readable name of the plant.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the plant.',
    `number_of_shifts` STRING COMMENT 'Number of production shifts operated per day.',
    `operational_end_date` DATE COMMENT 'Date when the plant ceased operations (null if still active).',
    `operational_start_date` DATE COMMENT 'Date when the plant began commercial operations.',
    `ownership_type` STRING COMMENT 'Legal ownership model of the plant.',
    `plant_code` STRING COMMENT 'External business code used to reference the plant in SAP MM and other systems.',
    `plant_manager_name` STRING COMMENT 'Full name of the person responsible for plant operations.',
    `plant_type` STRING COMMENT 'Category of the plant based on its primary function.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the plant address.',
    `power_source` STRING COMMENT 'Primary source of electricity for the plant.',
    `safety_rating` STRING COMMENT 'Overall safety performance rating of the plant.',
    `security_level` STRING COMMENT 'Overall security classification of the plant facility.',
    `state` STRING COMMENT 'State or province of the plant location.',
    `plant_status` STRING COMMENT 'Current lifecycle status of the plant.',
    `tax_number` STRING COMMENT 'Tax identification number assigned to the plant entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plant record.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master reference table for plant. Referenced by plant_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`supply`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Primary key for warehouse',
    `parent_warehouse_id` BIGINT COMMENT 'Self-referencing FK on warehouse (parent_warehouse_id)',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `backup_generator` BOOLEAN COMMENT 'Indicates whether a backup generator is installed for power redundancy.',
    `capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum storage volume the warehouse can hold, measured in cubic meters.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `closing_date` DATE COMMENT 'Date the warehouse ceased operations (null if still active).',
    `warehouse_code` STRING COMMENT 'Business identifier or code used to reference the warehouse in external systems.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the warehouse resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `current_occupancy_cubic_meters` DECIMAL(18,2) COMMENT 'Current used storage volume in cubic meters.',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed.',
    `forklift_available` BOOLEAN COMMENT 'Indicates whether forklifts are available for material handling.',
    `hazardous_material_allowed` BOOLEAN COMMENT 'Flag indicating if the warehouse is permitted to store hazardous materials.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the warehouse insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Identifier of the insurance policy covering the warehouse.',
    `inventory_audit_status` STRING COMMENT 'Result of the latest inventory audit.',
    `last_inventory_audit_date` DATE COMMENT 'Date of the most recent inventory audit.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance activity was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the warehouse.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the warehouse.',
    `maintenance_schedule` STRING COMMENT 'Regular maintenance cadence for the warehouse.',
    `manager_email` STRING COMMENT 'Email address of the warehouse manager.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for warehouse operations.',
    `manager_phone` STRING COMMENT 'Contact phone number for the warehouse manager.',
    `max_weight_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum total weight the warehouse can safely store, in kilograms.',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `occupancy_percentage` DECIMAL(18,2) COMMENT 'Percentage of total capacity currently occupied.',
    `opening_date` DATE COMMENT 'Date the warehouse became operational.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse address.',
    `power_capacity_kw` DECIMAL(18,2) COMMENT 'Electrical power capacity of the warehouse in kilowatts.',
    `receiving_dock_count` STRING COMMENT 'Number of receiving docks available for inbound shipments.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with industry regulations (e.g., FDA, EMA).',
    `security_level` STRING COMMENT 'Security classification of the warehouse (high, medium, low).',
    `shipping_dock_count` STRING COMMENT 'Number of shipping docks for outbound shipments.',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `warehouse_status` STRING COMMENT 'Current lifecycle status of the warehouse.',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the warehouse maintains controlled temperature conditions.',
    `temperature_range_celsius` STRING COMMENT 'Allowed temperature range for the warehouse, expressed in Celsius (e.g., "-20 to 4").',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse (e.g., distribution center, cold storage, laboratory, fulfillment).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master reference table for warehouse. Referenced by warehouse_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ADD CONSTRAINT `fk_supply_batch_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ADD CONSTRAINT `fk_supply_demand_plan_previous_plan_demand_plan_id` FOREIGN KEY (`previous_plan_demand_plan_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`demand_plan`(`demand_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_source_plant_id` FOREIGN KEY (`source_plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ADD CONSTRAINT `fk_supply_replenishment_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ADD CONSTRAINT `fk_supply_warehouse_location_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ADD CONSTRAINT `fk_supply_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ADD CONSTRAINT `fk_supply_supplier_performance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ADD CONSTRAINT `fk_supply_sourcing_agreement_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ADD CONSTRAINT `fk_supply_sourcing_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ADD CONSTRAINT `fk_supply_contract_line_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ADD CONSTRAINT `fk_supply_supplier_reagent_qualification_supplier_qualification_id` FOREIGN KEY (`supplier_qualification_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`supplier_qualification`(`supplier_qualification_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ADD CONSTRAINT `fk_supply_batch_quality_test_batch_id` FOREIGN KEY (`batch_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`batch`(`batch_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ADD CONSTRAINT `fk_supply_material_qualification_material_id` FOREIGN KEY (`material_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`material`(`material_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ADD CONSTRAINT `fk_supply_plant_parent_plant_id` FOREIGN KEY (`parent_plant_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ADD CONSTRAINT `fk_supply_warehouse_parent_warehouse_id` FOREIGN KEY (`parent_warehouse_id`) REFERENCES `genomics_biotech_ecm`.`supply`.`warehouse`(`warehouse_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Approved Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `blocked_for_purchasing` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Purchasing');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'gmp_qualified|preferred|approved|conditional|probationary|blocked');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `cold_chain_capable` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Capable');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `gmp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `iso_13485_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Certified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Supplier Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `on_time_delivery_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|letter_of_credit');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|marginal|unacceptable');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Tier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Termination Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Trade Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Udi Assignment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `glossary_term_id` SET TAGS ('dbx_business_glossary_term' = 'Glossary Term Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `metadata_schema_id` SET TAGS ('dbx_business_glossary_term' = 'Metadata Schema Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `batch_management_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `bom_relevance` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Relevance');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'GMP|NON_GMP|GMP_CRITICAL');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `industry_sector` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_business_glossary_term' = 'Lot Size Procedure');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `lot_size_procedure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'E|F|X');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `product_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `product_hierarchy` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,18}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|LDT|INVESTIGATIONAL');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Liters)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `gmp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `overdelivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Overdelivery Tolerance Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|consignment|subcontracting|framework|service');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `underdelivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Tolerance Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`purchase_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `batch_management_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|invoiced|closed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `overdelivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Overdelivery Tolerance Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `underdelivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Tolerance Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cold_chain_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Temperature Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cold_chain_log_reference` SET TAGS ('dbx_value_regex' = '^CCL-[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gmp_batch_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Batch Record Reference');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gmp_batch_record_reference` SET TAGS ('dbx_value_regex' = '^BMR-[A-Z0-9]{12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Material Document Line Item');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_value_company_currency` SET TAGS ('dbx_business_glossary_term' = 'Movement Value (Company Currency)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_value_company_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_value_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Movement Value (Local Currency)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_value_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `production_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|O|Q|W');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `available_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_value_regex' = '^COA[A-Z0-9]{8,16}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `cold_chain_storage_zone` SET TAGS ('dbx_business_glossary_term' = 'Cold-Chain Storage Zone');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `cold_chain_storage_zone` SET TAGS ('dbx_value_regex' = 'AMBIENT|REFRIGERATED_2_8C|FROZEN_MINUS_20C|ULTRA_FROZEN_MINUS_80C|CRYOGENIC_MINUS_196C');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `consignment_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `gmp_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Controlled Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `in_transit_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Movement Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `mrp_controller_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection (QI) Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (ROP) Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `reserved_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'OWN_STOCK|CONSIGNMENT|PROJECT_STOCK|SALES_ORDER_STOCK|RETURNABLE_PACKAGING');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Value Amount');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `stock_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Valuation Price Per Unit');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inventory_stock` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'STANDARD|SPLIT_VALUATION|BATCH_VALUATION');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Movement Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_company_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Company Currency');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_company_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `amount_in_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Company Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `company_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `entry_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Entry Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `entry_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Material Document Line Item Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `movement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `production_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `quantity_in_entry_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Entry Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reservation_line_item` SET TAGS ('dbx_business_glossary_term' = 'Reservation Line Item Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Material Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `sales_order_line_item` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Item Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `sales_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `available_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'active|depleted|expired|recalled|quarantined|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `blocked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `coa_number` SET TAGS ('dbx_value_regex' = '^COA-[A-Z0-9]{8,15}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp|non_gmp|gmp_equivalent');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `origin` SET TAGS ('dbx_business_glossary_term' = 'Batch Origin');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `origin` SET TAGS ('dbx_value_regex' = 'internal_production|external_procurement|contract_manufacturing|rework|sample');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `qc_release_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Release Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|released|rejected|on_hold|conditionally_released');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ivd|ruo|gmp_api|medical_device|research_grade');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `sds_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `sds_number` SET TAGS ('dbx_value_regex' = '^SDS-[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `size_quantity` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `size_uom` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `sterilization_date` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'autoclave|gamma_irradiation|ethylene_oxide|filtration|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated|frozen|ultra_low_temperature|controlled_ambient');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum in Celsius');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch` ALTER COLUMN `supplier_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Batch Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Company Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `cold_chain_device_code` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Monitoring Device Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `cold_chain_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `cold_chain_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `cold_chain_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `customs_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|held|rejected');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_note_text` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Text');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|arrived|goods_receipt_posted|cancelled|blocked');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `max_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Celsius');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `min_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Celsius');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_business_glossary_term' = 'Packing List Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `proof_of_delivery_document_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Document URL');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `proof_of_delivery_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `receiving_dock_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Dock Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Supplier Shipping Point');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_MM|SAP_LE|MANUAL|EDI|API');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Volume Cubic Meters (M3)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Weight Kilograms (KG)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Hazard Classification Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Covered Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|closed');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'value_contract|quantity_contract|scheduling_agreement|blanket_order|framework_agreement|master_agreement');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `gmp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `price_adjustment_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Clause');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `release_strategy` SET TAGS ('dbx_business_glossary_term' = 'Release Strategy');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `release_strategy` SET TAGS ('dbx_value_regex' = 'automatic|manual|scheduled|forecast_based|jit');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `sla_on_time_delivery_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On-Time Delivery Target Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `sla_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Turnaround Time (TAT) Hours');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|Oracle_Procurement|Ariba|Manual');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_contract` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `previous_plan_demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Plan Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `customer_order_backlog_quantity` SET TAGS ('dbx_business_glossary_term' = 'Customer Order Backlog Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_category` SET TAGS ('dbx_business_glossary_term' = 'Demand Category');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_category` SET TAGS ('dbx_value_regex' = 'independent|dependent|service_parts');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_signal_source` SET TAGS ('dbx_business_glossary_term' = 'Demand Signal Source');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `demand_signal_source` SET TAGS ('dbx_value_regex' = 'sales_forecast|production_plan|safety_stock_replenishment|customer_order|promotional_campaign|new_product_launch');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecast_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Forecast Accuracy Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'statistical|consensus|mrp_driven|manual|machine_learning|historical_average');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `forecasted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `mrp_element_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `mrp_element_type` SET TAGS ('dbx_value_regex' = 'planned_order|purchase_requisition|production_order|stock_transfer|none');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|superseded|archived');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planner_name` SET TAGS ('dbx_business_glossary_term' = 'Planner Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `procurement_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Procurement Trigger Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Stage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `product_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'introduction|growth|maturity|decline|end_of_life');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `production_plan_quantity` SET TAGS ('dbx_business_glossary_term' = 'Production Plan Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `promotional_impact_quantity` SET TAGS ('dbx_business_glossary_term' = 'Promotional Impact Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `sales_forecast_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Forecast Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `seasonality_factor` SET TAGS ('dbx_business_glossary_term' = 'Seasonality Factor');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `supplier_capacity_reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Supplier Capacity Reserved Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`demand_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Purchase Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `reagent_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Subscription Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `source_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `batch_managed` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `converted_document_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Document Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `converted_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `converted_document_type` SET TAGS ('dbx_business_glossary_term' = 'Converted Document Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `converted_document_type` SET TAGS ('dbx_value_regex' = 'purchase_order|stock_transfer_order|production_order|subcontracting_order');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `gmp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `mrp_run_date` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|stock_transfer_order|production_order_trigger|subcontracting_order|consignment_order|pipeline_order');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `planned_order_number` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `planned_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Priority');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `reorder_point_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `required_date` SET TAGS ('dbx_business_glossary_term' = 'Required Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `safety_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Source Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'external_supplier|internal_plant|distribution_center|contract_manufacturer|consignment_stock');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Procurement Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `special_procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|stock_transfer|pipeline|direct_procurement');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_business_glossary_term' = 'Aisle Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `aisle_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `batch_managed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `bin_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `blocked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blocked Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume (Cubic Meters)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `current_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Utilization Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `cycle_count_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `fefo_enforcement` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Enforcement');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `fifo_enforcement` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Enforcement');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `gmp_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Zone Classification');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `gmp_zone_classification` SET TAGS ('dbx_value_regex' = 'non_gmp|grade_d|grade_c|grade_b|grade_a');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `hazard_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `level_number` SET TAGS ('dbx_business_glossary_term' = 'Level Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|quarantine|maintenance|decommissioned');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `mixed_storage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mixed Storage Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `picking_indicator` SET TAGS ('dbx_business_glossary_term' = 'Picking Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_business_glossary_term' = 'Picking Strategy');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `picking_strategy` SET TAGS ('dbx_value_regex' = 'fifo|fefo|lifo|nearest_location|highest_stock');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_business_glossary_term' = 'Putaway Strategy');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `putaway_strategy` SET TAGS ('dbx_value_regex' = 'fixed_bin|next_empty_bin|bulk_storage|high_rack|floor_storage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `quarantine_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `rack_number` SET TAGS ('dbx_business_glossary_term' = 'Rack Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `rack_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,5}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `replenishment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `serial_number_managed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Managed Indicator');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_incompatibilities` SET TAGS ('dbx_business_glossary_term' = 'Storage Incompatibilities');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_section` SET TAGS ('dbx_business_glossary_term' = 'Storage Section');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_section` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|ultra_cold|hazmat|gmp_controlled');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|2_to_8_celsius|minus_20_celsius|minus_80_celsius|liquid_nitrogen');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse_location` ALTER COLUMN `z_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Z Coordinate');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `approved_material_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Scope');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'on-site|remote|desktop|hybrid|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `fda_registered` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Registered');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `gmp_scope` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Scope');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `gmp_scope` SET TAGS ('dbx_value_regex' = 'full|partial|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `iso_13485_certified` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 13485 Certified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 9001 Certified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^SQ-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Qualification Score');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|disqualified|pending|under_review');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|re-qualification|audit-based|risk-based|expedited|conditional');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `regulatory_body_alignment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Alignment');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `supplier_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `avg_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Hours');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `coa_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Compliance Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `cold_chain_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliance Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `corrective_action_closure_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Closure Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `critical_deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `documentation_completeness_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Documentation Completeness Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Email');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `improvement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Description');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `improvement_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Improvement Action Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `in_full_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'In-Full Delivery Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `incoming_quality_acceptance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Incoming Quality Acceptance Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `innovation_contribution_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Contribution Score');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `late_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `lead_time_adherence_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Adherence Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `otif_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `partial_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Partial Delivery Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|at_risk|disqualified');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `price_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `rejected_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Lot Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|under_review|approved|archived');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `sla_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `total_po_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_performance` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` SET TAGS ('dbx_association_edges' = 'supply.supplier,supply.material');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `sourcing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement - Material Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement - Supplier Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `agreement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`sourcing_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` SET TAGS ('dbx_association_edges' = 'supply.supplier_contract,reagent.reagent_catalog');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line - Reagent Catalog Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Line - Supplier Contract Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `contract_line_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `contracted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contracted Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `contracted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Line Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `price_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Type');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `quantity_released_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released to Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Line Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Line Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`contract_line` ALTER COLUMN `value_released_to_date` SET TAGS ('dbx_business_glossary_term' = 'Value Released to Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` SET TAGS ('dbx_association_edges' = 'supply.supplier_qualification,reagent.reagent_catalog');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `supplier_reagent_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reagent Qualification ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reagent Qualification - Reagent Catalog Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reagent Qualification - Supply Supplier Qualification Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `approved_material_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Scope');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `gmp_scope` SET TAGS ('dbx_business_glossary_term' = 'GMP Scope');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `qualification_owner` SET TAGS ('dbx_business_glossary_term' = 'Qualification Owner');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`supplier_reagent_qualification` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` SET TAGS ('dbx_association_edges' = 'supply.batch,data.quality_rule');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `batch_quality_test_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Quality Test Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Instrument Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Quality Test - Batch Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Test Result Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Test Result Approver');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Test Pass/Fail Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `retest_required` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `test_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Method Reference');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `test_result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`batch_quality_test` ALTER COLUMN `tested_by` SET TAGS ('dbx_business_glossary_term' = 'Test Performer');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` SET TAGS ('dbx_subdomain' = 'material_planning');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` SET TAGS ('dbx_association_edges' = 'supply.material,workforce.employee');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `material_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Qualification ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `assessor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `assessor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Material Qualification - Employee Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Qualification - Material Id');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`material_qualification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `parent_plant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `plant_manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `plant_manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`plant` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `parent_warehouse_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`supply`.`warehouse` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
