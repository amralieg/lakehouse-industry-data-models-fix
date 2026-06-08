-- Schema for Domain: ingredient | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`ingredient` COMMENT 'Authoritative domain for all raw materials, additives, flavors, preservatives, and packaging components used in F&B manufacturing. Manages ingredient specifications, supplier-approved ingredient lists, Brix/pH/CFU tolerances, clean-label attributes, allergen declarations, GMO status, organic certifications, certificates of analysis (COA), and ingredient traceability for FSMA compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`raw_material` (
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the raw material. Primary key for this master data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Key accounts often have approved‑ingredient lists; linking raw material to the account records which accounts have approved each ingredient.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Ingredient Compliance Report requires mapping each raw material to the brand that uses it for labeling and regulatory compliance.',
    `category_strategy_id` BIGINT COMMENT 'Foreign key linking to procurement.category_strategy. Business justification: REQUIRED: Sourcing strategy reports assign each raw material to a category strategy defining risk, spend, and sustainability targets.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Required for FDA facility traceability of raw material source; regulatory compliance reports demand linking each ingredient to its registered establishment.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Novel ingredient registration requires a FK to product_registration to track approval status, jurisdiction, and compliance deadlines.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: Raw material hazard categories are incorporated into HACCP plans; FK supports hazard‑based control documentation.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Raw material specification management requires linking each raw material to its quality specification for compliance reporting.',
    `allergen_eggs` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from eggs. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_fish` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from fish. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_milk` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from milk. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_peanuts` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from peanuts. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_sesame` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from sesame. Required for FDA FASTER Act allergen labeling compliance (effective 2023).',
    `allergen_shellfish` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from crustacean shellfish. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_soybeans` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from soybeans. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_tree_nuts` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from tree nuts. Required for FDA FALCPA allergen labeling compliance.',
    `allergen_wheat` BOOLEAN COMMENT 'Indicates the ingredient contains or is derived from wheat. Required for FDA FALCPA allergen labeling compliance.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance. Critical for regulatory compliance and supplier specifications.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `category_l1` STRING COMMENT 'Top-level hierarchical category classification (e.g., Dairy, Sweeteners, Proteins, Fats & Oils, Spices & Seasonings). First tier of ingredient taxonomy.',
    `category_l2` STRING COMMENT 'Second-level hierarchical category classification providing more granular segmentation within L1 class (e.g., under Dairy: Milk Powders, Whey Products, Cheese Cultures).',
    `category_l3` STRING COMMENT 'Third-level hierarchical category classification providing most specific ingredient type within L2 sub-class (e.g., under Milk Powders: Skim Milk Powder, Whole Milk Powder, Buttermilk Powder).',
    `clean_label_eligible` BOOLEAN COMMENT 'Indicates whether the ingredient meets clean-label criteria (recognizable, simple ingredients without artificial additives). Key attribute for consumer-facing product claims and NPD.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this raw material master record was first created in the system. Audit trail for data governance and compliance.',
    `e_number` STRING COMMENT 'EU-assigned code for food additives approved for use in the European Economic Area. Required for EU labeling compliance.. Valid values are `^E[0-9]{3,4}[a-z]?$`',
    `fair_trade_certified` BOOLEAN COMMENT 'Indicates the ingredient has been sourced under fair trade standards, ensuring ethical labor practices and fair compensation to producers.',
    `gluten_free` BOOLEAN COMMENT 'Indicates the ingredient is free from gluten proteins (wheat, barley, rye, triticale). Required for gluten-free product formulation and FDA gluten-free labeling compliance.',
    `gmo_classification` STRING COMMENT 'Classification of the ingredients GMO status. Critical for regulatory compliance, labeling requirements, and consumer transparency.. Valid values are `non-GMO|GMO|GMO-derived|unknown`',
    `gmo_verification_method` STRING COMMENT 'Method used to verify the GMO status of the ingredient. Documents the rigor of GMO status validation for compliance and audit purposes.. Valid values are `supplier declaration|PCR testing|third-party certification|identity preservation|not verified`',
    `halal_certified` BOOLEAN COMMENT 'Indicates the ingredient has been certified as meeting halal dietary requirements by a recognized halal certification body.',
    `identity_preserved` BOOLEAN COMMENT 'Indicates the ingredient has been kept segregated throughout the supply chain to maintain its specific identity characteristics (e.g., non-GMO, organic, specific variety). Critical for premium ingredient sourcing and traceability.',
    `inci_name` STRING COMMENT 'Standardized INCI name for the ingredient, used for regulatory labeling and international ingredient identification.',
    `ingredient_class` STRING COMMENT 'High-level classification of the ingredient type. Primary categorical segmentation for procurement, formulation, and regulatory purposes. [ENUM-REF-CANDIDATE: raw material|flavor|preservative|colorant|packaging component|additive|processing aid|nutrient fortification — 8 candidates stripped; promote to reference product]',
    `kosher_certified` BOOLEAN COMMENT 'Indicates the ingredient has been certified as meeting kosher dietary laws by a recognized kosher certification agency.',
    `lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the raw material in the PLM system. Governs availability for new formulations and procurement authorization.. Valid values are `active|under evaluation|approved|restricted|discontinued|phased out`',
    `material_code` STRING COMMENT 'Externally-known unique business identifier for the raw material, typically sourced from ERP system (SAP MM Material Master). Used across procurement, manufacturing, and quality systems.. Valid values are `^[A-Z0-9]{8,12}$`',
    `material_name` STRING COMMENT 'Human-readable name of the raw material, additive, flavor, preservative, or packaging component. Primary identity label for business users.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this raw material master record was last modified. Audit trail for data governance and change tracking.',
    `moisture_sensitive` BOOLEAN COMMENT 'Indicates the ingredient is sensitive to moisture and requires special handling or packaging to prevent degradation. Impacts storage, handling, and packaging specifications.',
    `no_artificial_colors` BOOLEAN COMMENT 'Indicates the ingredient is free from synthetic or artificial color additives. Supports clean-label and natural product positioning.',
    `no_artificial_flavors` BOOLEAN COMMENT 'Indicates the ingredient is free from synthetic or artificial flavor compounds. Critical for natural and clean-label claims.',
    `no_artificial_preservatives` BOOLEAN COMMENT 'Indicates the ingredient is free from synthetic preservatives. Supports clean-label and natural product claims.',
    `non_gmo_project_verified` BOOLEAN COMMENT 'Indicates the ingredient has been verified by the Non-GMO Project, the leading third-party verification program for non-GMO products in North America.',
    `organic_certification_body` STRING COMMENT 'Name of the organization that issued the organic certification (e.g., USDA, EU Organic, IFOAM). Required for organic claim substantiation and audit trails.',
    `organic_certified` BOOLEAN COMMENT 'Indicates the ingredient has been certified organic by a recognized certification body (USDA Organic, EU Organic, etc.).',
    `origin_type` STRING COMMENT 'Source origin classification of the raw material. Critical for dietary compliance, allergen management, and clean-label positioning.. Valid values are `animal|plant|mineral|synthetic|microbial|biotechnology`',
    `plant_based` BOOLEAN COMMENT 'Indicates the ingredient is derived from plant sources. Supports plant-based product positioning and consumer trend alignment.',
    `regulatory_restriction_profile` STRING COMMENT 'Summary of regulatory restrictions or usage limitations by jurisdiction (e.g., banned in EU, restricted use levels in US, requires warning label in CA). Critical for global product formulation and compliance.',
    `sensory_appearance` STRING COMMENT 'Standard sensory profile description for visual appearance characteristics. Used by sensory panels and quality control for organoleptic evaluation.',
    `sensory_aroma` STRING COMMENT 'Standard sensory profile description for aroma characteristics. Used by sensory panels and quality control for organoleptic evaluation.',
    `sensory_color` STRING COMMENT 'Standard sensory profile description for color characteristics. Used by sensory panels and quality control for organoleptic evaluation.',
    `sensory_flavor` STRING COMMENT 'Standard sensory profile description for flavor characteristics. Used by sensory panels and quality control for organoleptic evaluation.',
    `sensory_texture` STRING COMMENT 'Standard sensory profile description for texture and mouthfeel characteristics. Used by sensory panels and quality control for organoleptic evaluation.',
    `shelf_life_days` STRING COMMENT 'Expected shelf life of the raw material in days under specified storage conditions. Critical for inventory management, FEFO rotation, and formulation planning.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the raw material (e.g., ambient, refrigerated 2-8°C, frozen -18°C, controlled humidity). Essential for warehouse management and quality preservation.',
    `vegan` BOOLEAN COMMENT 'Indicates the ingredient contains no animal-derived components or by-products. Essential for vegan product formulation and certification.',
    CONSTRAINT pk_raw_material PRIMARY KEY(`raw_material_id`)
) COMMENT 'Master record and Single Source of Truth for all raw materials, additives, flavors, preservatives, and packaging components used in F&B manufacturing. Captures INCI name, CAS number, E-number (EU additive code), ingredient class (raw material, flavor, preservative, colorant, packaging component), hierarchical category classification (L1 class > L2 sub-class > L3 type), origin type (animal, plant, mineral, synthetic), clean-label eligibility and consumer-facing claim attributes (no artificial colors/flavors/preservatives, gluten-free, vegan, plant-based, fair trade), dietary compliance flags (vegan, kosher, halal), organic certification status, GMO classification (non-GMO, GMO, GMO-derived), GMO verification method (supplier declaration, PCR testing, third-party certification), Non-GMO Project Verified flag, identity preservation flag, allergen declaration flags per FDA FALCPA and EFSA categories, shelf life parameters, storage conditions, moisture sensitivity, PLM lifecycle stage, sensory standard profile (appearance, color, aroma, flavor, texture descriptors), and regulatory restriction profile by jurisdiction. Referenced by every transactional record in this domain.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` (
    `approved_supplier_id` BIGINT COMMENT 'Primary key for approved_supplier',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Supplier approval process mandates linking each approved supplier to the regulatory establishment registration of its manufacturing site.',
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the approved supplier-ingredient relationship record. Primary key for the approved supplier list entry.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier entity that is approved to supply this ingredient. Links to the supplier master data.',
    `allergen_declaration_on_file` BOOLEAN COMMENT 'Indicates whether a current allergen declaration document is on file for this supplier-ingredient combination. Critical for FSMA compliance and allergen management programs.',
    `approval_date` DATE COMMENT 'The date when the supplier was officially approved to supply this ingredient. Marks the start of the authorized sourcing relationship.',
    `approval_status` STRING COMMENT 'Current approval status of the supplier for this specific ingredient. Approved = fully authorized; Conditional = approved with restrictions; Suspended = temporarily not allowed; Revoked = permanently removed; Pending = under review.. Valid values are `approved|conditional|suspended|revoked|pending`',
    `coa_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis (COA) must be provided with each shipment of this ingredient from this supplier. COAs verify ingredient specifications and quality parameters.',
    `contract_reference_number` STRING COMMENT 'Reference to the master purchase contract or supply agreement governing this supplier-ingredient relationship. Links to contract management systems for terms and conditions.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the ingredient is sourced or manufactured by the supplier. Critical for FSMA (Food Safety Modernization Act) traceability and customs compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this approved supplier record was first created in the system. Part of the audit trail for data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing (e.g., USD, EUR, GBP). Essential for multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this approved supplier relationship expires or is terminated. Null indicates an open-ended relationship. Used for contract lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this approved supplier relationship is effective. Used for time-based sourcing decisions and historical tracking.',
    `gfsi_certificate_expiry_date` DATE COMMENT 'The expiration date of the suppliers GFSI certification. Suppliers must maintain valid certification to remain on the approved supplier list.',
    `gfsi_certificate_number` STRING COMMENT 'The unique certificate number issued by the GFSI certification body. Used for verification and audit trail purposes.',
    `gfsi_certification_type` STRING COMMENT 'The type of GFSI (Global Food Safety Initiative) certification held by the supplier. Common schemes include SQF (Safe Quality Food), BRC (Brand Reputation Compliance), FSSC 22000 (Food Safety System Certification), IFS (International Featured Standards), GLOBALG.A.P., and PrimusGFS.. Valid values are `SQF|BRC|FSSC 22000|IFS|GLOBALG.A.P.|PrimusGFS`',
    `gmo_status` STRING COMMENT 'The GMO (Genetically Modified Organism) status of the ingredient from this supplier. GMO = contains genetically modified material; Non-GMO = does not contain GMO; Non-GMO Verified = third-party verified; Organic = certified organic (inherently non-GMO).. Valid values are `GMO|Non-GMO|Non-GMO Verified|Organic`',
    `halal_certified` BOOLEAN COMMENT 'Indicates whether this supplier is certified to provide this ingredient as Halal-compliant. Required for products targeting Muslim consumers and certain export markets.',
    `incoterms` STRING COMMENT 'The Incoterms rule governing the delivery, risk transfer, and cost responsibilities between buyer and supplier. Common terms include EXW (Ex Works), FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `kosher_certified` BOOLEAN COMMENT 'Indicates whether this supplier is certified to provide this ingredient as Kosher-compliant. Required for products targeting Jewish consumers and certain retail channels.',
    `last_audit_date` DATE COMMENT 'The date of the most recent supplier audit conducted for this ingredient. Audits verify compliance with quality, safety, and regulatory standards.',
    `last_audit_score` DECIMAL(18,2) COMMENT 'The numerical score from the most recent supplier audit, typically on a 0-100 scale. Higher scores indicate better compliance and performance. Used for supplier risk assessment and scorecard evaluation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this approved supplier record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `lead_time_days` STRING COMMENT 'The number of calendar days from purchase order placement to expected delivery at the receiving facility. Critical for demand planning and inventory optimization.',
    `moq_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity (MOQ) required by the supplier for this ingredient. Represents the smallest amount that can be ordered in a single purchase order.',
    `moq_uom` STRING COMMENT 'The unit of measure for the minimum order quantity, such as kg, lbs, liters, gallons, cases, pallets. Must align with supplier pricing and ordering systems.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next supplier audit. Ensures regular monitoring and continuous compliance verification.',
    `organic_certified` BOOLEAN COMMENT 'Indicates whether this supplier is certified to provide this ingredient as organic (USDA Organic, EU Organic, or equivalent). Required for clean-label and organic product lines.',
    `payment_terms` STRING COMMENT 'The negotiated payment terms for this supplier-ingredient relationship, such as Net 30, Net 60, 2/10 Net 30. Defines when payment is due and any early payment discounts available.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is designated as a preferred supplier for this ingredient. Preferred suppliers receive priority in sourcing decisions based on quality, reliability, and cost performance.',
    `price_per_uom` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure for this ingredient from this supplier. Used for cost estimation and procurement decisions. Business-confidential pricing information.',
    `price_uom` STRING COMMENT 'The unit of measure basis for the price, such as per kg, per lb, per liter, per case. Must be clearly defined for accurate cost calculations.',
    `reapproval_due_date` DATE COMMENT 'The date by which the supplier must be re-evaluated and re-approved for continued authorization. Ensures periodic review of supplier compliance and quality performance.',
    `supplier_item_code` STRING COMMENT 'The unique item code or SKU (Stock Keeping Unit) that the supplier uses to identify this ingredient in their catalog. Used for purchase orders and supplier communication.',
    `supplier_item_description` STRING COMMENT 'The suppliers description of the ingredient item, which may differ from internal nomenclature. Provides supplier-specific product naming and specification details.',
    CONSTRAINT pk_approved_supplier PRIMARY KEY(`approved_supplier_id`)
) COMMENT 'Approved Supplier List (ASL) association between a specific supplier and a specific raw material, representing the authorized sourcing relationship. Captures supplier item code, supplier item description, supplier country of origin, approval status (approved, conditional, suspended, revoked), approval date, re-approval due date, GFSI certification type (SQF, BRC, FSSC 22000, IFS), GFSI certificate expiry, MOQ (Minimum Order Quantity), lead time days, price UOM, and last audit score. Sourced from TraceGains Supplier Compliance and SAP MM Source List.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`lot` (
    `lot_id` BIGINT COMMENT 'Primary key for lot',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Recall traceability report requires linking each ingredient lot to the end‑customer account that received the product for rapid recall actions.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: FSMA traceability requires linking each ingredient lot to the equipment that processed it, enabling recall, compliance reporting, and equipment‑level accountability.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inventory valuation: lot balances are reported per legal entity (company code) for financial statements and compliance.',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: FSMA compliance requires each ingredient lot to be associated with a specific FSMA record for traceability and audit.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: REQUIRED: Quality inspection and FSMA traceability reports link each lot to the specific goods receipt that delivered it.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: REQUIRED: FSMA traceability report needs to link each raw‑material lot to its inbound shipment for recall and compliance.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Lot‑level quality inspections are recorded; linking lot to inspection_lot enables traceability reports.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: FSMA traceability: link ingredient lot to sales order to identify which orders contain the lot for recall and compliance reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Recall & audit process needs to map each raw‑material lot to its originating purchase order for traceability and compliance.',
    `raw_material_id` BIGINT COMMENT 'Reference to the master ingredient specification that this lot represents.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Traceability Report: each ingredient lot must be linked to the outbound shipment for recall and FSMA compliance.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: REQUIRED: Raw material receipt location tracking for inventory audit and FSMA traceability; experts expect each lot to reference its storage location.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided this ingredient lot.',
    `allergen_declaration` STRING COMMENT 'Comma-separated list of allergens present in or potentially cross-contaminated with this ingredient lot.',
    `best_before_date` DATE COMMENT 'Date until which the ingredient maintains optimal quality characteristics, may still be usable after this date subject to quality review.',
    `coa_document_number` STRING COMMENT 'Document number of the Certificate of Analysis provided by the supplier, containing test results and quality parameters.',
    `coa_received_date` DATE COMMENT 'Date when the Certificate of Analysis was received from the supplier.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the ingredient was grown, harvested, or manufactured.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingredient lot record was first created in the system.',
    `disposition_reason` STRING COMMENT 'Reason for the current disposition status of the lot (e.g., failed specification, expired, contamination risk).',
    `expiry_date` DATE COMMENT 'Date after which the ingredient lot should not be used in production due to quality or safety concerns.',
    `fefo_sequence_number` STRING COMMENT 'Sequence number used to prioritize lot consumption based on expiry date, ensuring oldest lots are used first.',
    `gmo_status` STRING COMMENT 'Indicates whether the ingredient lot contains genetically modified organisms.. Valid values are `GMO|NON_GMO|UNKNOWN`',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient lot is certified halal by a recognized halal certification body.',
    `hold_release_date` DATE COMMENT 'Date when a quality hold or quarantine status was released, allowing the lot to be used in production.',
    `internal_lot_number` STRING COMMENT 'Company-assigned unique lot number for internal traceability and inventory management. Primary business identifier for the lot.. Valid values are `^[A-Z0-9]{6,20}$`',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient lot is certified kosher by a recognized kosher certification agency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ingredient lot record was last updated or modified.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the ingredient lot indicating its availability for production use.. Valid values are `UNRESTRICTED|QUALITY_HOLD|BLOCKED|CONSUMED|EXPIRED|QUARANTINE`',
    `manufacturing_date` DATE COMMENT 'Date when the ingredient was manufactured or produced by the supplier.',
    `organic_certificate_number` STRING COMMENT 'Certificate number from the organic certification body if the lot is organic certified.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient lot is certified organic by a recognized certification body.',
    `plant_code` STRING COMMENT 'Manufacturing plant or distribution center code where the ingredient lot was received and is stored.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection and testing for the ingredient lot.. Valid values are `PENDING|IN_PROGRESS|APPROVED|REJECTED|CONDITIONAL`',
    `quantity_available` DECIMAL(18,2) COMMENT 'Current available quantity of the ingredient lot after consumption, adjustments, and reservations.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Total quantity of ingredient received in this lot, measured in the unit of measure specified.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the lot is under quarantine pending quality inspection and approval.',
    `receipt_date` DATE COMMENT 'Date when the ingredient lot was physically received at the plant or distribution center.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special handling instructions related to the ingredient lot.',
    `retest_date` DATE COMMENT 'Date when the ingredient lot must be retested to confirm continued compliance with specifications before further use.',
    `sscc` STRING COMMENT 'GS1 Serial Shipping Container Code for pallet or container-level traceability in the supply chain.. Valid values are `^[0-9]{18}$`',
    `storage_condition` STRING COMMENT 'Required environmental storage condition for the ingredient lot to maintain quality and safety.. Valid values are `AMBIENT|REFRIGERATED|FROZEN|CONTROLLED_HUMIDITY|TEMPERATURE_CONTROLLED`',
    `supplier_lot_number` STRING COMMENT 'Lot or batch number assigned by the supplier, used for backward traceability to supplier production records.',
    `temperature_at_receipt` DECIMAL(18,2) COMMENT 'Measured temperature of the ingredient lot at the time of receipt, critical for temperature-sensitive materials.',
    `traceability_lot_code` STRING COMMENT 'Extended traceability code used for FSMA compliance, enabling forward and backward traceability through the supply chain.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the ingredient lot quantity (e.g., kilograms, liters, pounds). [ENUM-REF-CANDIDATE: KG|LB|L|GAL|MT|TON|EA|CS|BAG|DRUM|PALLET — 11 candidates stripped; promote to reference product]',
    `vendor_certification_status` STRING COMMENT 'Certification status of the supplier at the time this lot was received, indicating compliance with company quality standards.. Valid values are `CERTIFIED|PROVISIONAL|SUSPENDED|NOT_CERTIFIED`',
    CONSTRAINT pk_lot PRIMARY KEY(`lot_id`)
) COMMENT 'Lot-level traceability record for each received batch of raw material, enabling FSMA forward and backward traceability. Captures internal lot number, supplier lot number, GS1 SSCC (Serial Shipping Container Code), receipt date, expiry date, best-before date, quantity received (UOM), plant/DC received at, storage location, FEFO sequence number, quarantine flag, lot status (unrestricted, quality hold, blocked, consumed, expired), and disposition reason. Links to COA and purchase receipt. Sourced from SAP MM Batch Management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`allergen` (
    `allergen_id` BIGINT COMMENT 'Primary key for allergen',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient for which this allergen declaration applies. Links to the ingredient master data.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided the allergen declaration or certificate of analysis for this ingredient.',
    `allergen_type` STRING COMMENT 'The specific allergen category as defined by FDA FALCPA and EU Regulation 1169/2011. Identifies which of the major allergen groups this declaration addresses. [ENUM-REF-CANDIDATE: peanut|tree_nut|milk|egg|wheat_gluten|soy|fish|shellfish|sesame|mustard|celery|lupin|molluscs|sulphites — 14 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which this allergen declaration was formally approved by the quality assurance team.',
    `approved_by` STRING COMMENT 'Name or identifier of the quality assurance professional who approved this allergen declaration for use in finished goods labeling.',
    `coa_document_number` STRING COMMENT 'The unique document identifier for the Certificate of Analysis that supports this allergen declaration. Used for traceability and audit purposes.',
    `comments` STRING COMMENT 'Free-text field for additional notes, clarifications, or special handling instructions related to this allergen declaration.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allergen declaration record was first created in the system.',
    `cross_contact_risk_level` STRING COMMENT 'Assessment of the risk that the ingredient may be cross-contaminated with the allergen during manufacturing, processing, or transportation. Used to determine may-contain declarations.. Valid values are `none|low|medium|high`',
    `declaration_basis` STRING COMMENT 'The method or source used to determine the allergen status. Indicates whether the declaration is based on ingredient formulation, supplier-provided documentation, laboratory testing, or facility risk assessment.. Valid values are `formulation|supplier_declaration|lab_test|risk_assessment|facility_audit`',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the allergen declaration record. Tracks the approval workflow and validity state.. Valid values are `draft|pending_review|approved|rejected|expired|superseded`',
    `declaration_type` STRING COMMENT 'The nature of the allergen declaration indicating whether the allergen is intentionally present, potentially present due to cross-contact, or absent from the ingredient.. Valid values are `contains|may_contain|free_from|not_present`',
    `detection_limit_ppm` DECIMAL(18,2) COMMENT 'The minimum concentration level in parts per million at which the allergen can be reliably detected by the test method. Applicable only when declaration is based on laboratory testing.',
    `effective_date` DATE COMMENT 'The date from which this allergen declaration becomes valid and applicable for regulatory compliance and labeling purposes.',
    `expiration_date` DATE COMMENT 'The date after which this allergen declaration is no longer valid. Used to manage changes in ingredient formulation or supplier declarations over time.',
    `jurisdiction` STRING COMMENT 'The country or regulatory region for which this allergen declaration is applicable. Different jurisdictions have different allergen labeling requirements. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|ITA|ESP|AUS|NZL|JPN|CHN|BRA|ARG|IND — 15 candidates stripped; promote to reference product]',
    `last_review_date` DATE COMMENT 'The most recent date on which this allergen declaration was reviewed for accuracy and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allergen declaration record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next mandatory review of this allergen declaration.',
    `precautionary_statement` STRING COMMENT 'The specific precautionary allergen labeling statement to be used on finished goods (e.g., May contain traces of peanuts, Processed in a facility that also processes milk). Used for label generation.',
    `review_frequency_days` STRING COMMENT 'The number of days between required reviews of this allergen declaration. Used to ensure declarations remain current and accurate.',
    `shared_equipment_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is processed on equipment that is also used for allergen-containing products. True if shared equipment is used, False otherwise.',
    `shared_facility_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is manufactured in a facility that also processes allergen-containing products. True if shared facility, False otherwise.',
    `source_record_code` STRING COMMENT 'The unique identifier of this allergen declaration in the source operational system. Used for traceability and reconciliation.',
    `source_system` STRING COMMENT 'The operational system from which this allergen declaration record originated (e.g., TraceGains, SAP QM, Veeva Vault).',
    `test_method` STRING COMMENT 'The specific analytical method or protocol used if the allergen declaration is based on laboratory testing (e.g., ELISA, PCR, mass spectrometry). Empty if not lab-tested.',
    CONSTRAINT pk_allergen PRIMARY KEY(`allergen_id`)
) COMMENT 'Authoritative allergen declaration record for each raw material, capturing the presence, absence, or may-contain status of each major allergen category as required by FDA FALCPA, EU Regulation 1169/2011, and other jurisdictions. Captures allergen type (peanut, tree nut, milk, egg, wheat/gluten, soy, fish, shellfish, sesame, mustard, celery, lupin, molluscs, sulphites), declaration type (contains, may contain/cross-contact, free-from), declaration basis (formulation, supplier declaration, lab test), effective date, and jurisdiction. Supports allergen matrix generation for finished goods labeling.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` (
    `formulation_line_id` BIGINT COMMENT 'Primary key for formulation_line',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Approval of BOM line items requires tracking which employee approved the formulation; the BOM approval report references approver_employee_id.',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header record representing the finished good or intermediate SKU. Links this line item to its parent formulation.',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or intermediate product SKU that this BOM line contributes to. Enables traceability from raw material to final product.',
    `supplier_id` BIGINT COMMENT 'Reference to the approved supplier for this ingredient in this formulation. Links to the approved vendor list (AVL) for procurement and traceability.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material, ingredient, additive, flavor, preservative, or packaging component used in this formulation line. Links to the ingredient master data.',
    `specification_id` BIGINT COMMENT 'Reference to the ingredient specification document that defines quality parameters, tolerances, and acceptance criteria (e.g., Brix, pH, CFU limits).',
    `addition_sequence` STRING COMMENT 'The order in which this ingredient is added within its phase of addition. Ensures proper sequencing for recipe execution and quality control.',
    `allergen_type` STRING COMMENT 'The specific allergen type if this ingredient is flagged as an allergen. Supports allergen declaration on nutritional panels and consumer safety. [ENUM-REF-CANDIDATE: milk|eggs|fish|shellfish|tree_nuts|peanuts|wheat|soybeans|sesame|none — 10 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which this BOM line item was approved for production use. Required for regulatory compliance and quality management system (QMS) documentation.',
    `bom_status` STRING COMMENT 'The current lifecycle status of this BOM line item. Controls whether the formulation can be used in production planning and manufacturing execution.. Valid values are `active|draft|obsolete|pending_approval|archived`',
    `bom_version` STRING COMMENT 'Version identifier for the BOM formulation. Tracks changes to formulations over time for product lifecycle management (PLM) and regulatory compliance.. Valid values are `^[A-Z0-9]{1,10}$`',
    `change_description` STRING COMMENT 'Detailed description of the change made to this BOM line item. Provides context for formulation modifications and supports regulatory documentation.',
    `change_reason_code` STRING COMMENT 'The business reason for creating or modifying this BOM line item. Supports change management and audit trail for formulation changes.. Valid values are `cost_reduction|quality_improvement|regulatory_compliance|supplier_change|reformulation|obsolescence`',
    `cost_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the cost per unit. Supports multi-currency cost management for global operations.. Valid values are `^[A-Z]{3}$`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'The standard cost per unit of measure for this ingredient at the time of BOM creation. Used for cost of goods sold (COGS) calculation and margin analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line item record was first created in the lakehouse. Supports audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'The date after which this BOM line item is no longer effective for production use. Nullable for open-ended formulations. Supports phase-out of ingredients and reformulation tracking.',
    `effective_start_date` DATE COMMENT 'The date from which this BOM line item becomes effective for production use. Supports time-phased formulation changes and product reformulations.',
    `is_allergen` BOOLEAN COMMENT 'Indicates whether this ingredient is a declared allergen or contains allergen components. Used for allergen matrix management and labeling compliance.',
    `is_critical_ingredient` BOOLEAN COMMENT 'Indicates whether this ingredient is critical to product safety, quality, or regulatory compliance. Critical ingredients require enhanced traceability and certificate of analysis (COA) verification.',
    `is_gmo` BOOLEAN COMMENT 'Indicates whether this ingredient is genetically modified or contains GMO components. Required for clean-label claims and regulatory compliance in certain jurisdictions.',
    `is_halal` BOOLEAN COMMENT 'Indicates whether this ingredient is halal certified. Supports halal product formulation and labeling for Muslim consumers.',
    `is_kosher` BOOLEAN COMMENT 'Indicates whether this ingredient is kosher certified. Supports kosher product formulation and labeling.',
    `is_organic_certified` BOOLEAN COMMENT 'Indicates whether this ingredient is certified organic. Required for organic product labeling and USDA National Organic Program (NOP) compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this BOM line item record was last modified in the lakehouse. Supports change tracking and audit compliance.',
    `line_item_sequence` STRING COMMENT 'Sequential ordering of the BOM line item within the parent BOM header. Determines the order of ingredient addition in manufacturing processes.',
    `phase_of_addition` STRING COMMENT 'The manufacturing phase or stage at which this ingredient is added to the formulation (e.g., mixing, blending, coating, filling). Critical for manufacturing execution system (MES) scheduling and process control.. Valid values are `mixing|blending|coating|filling|packaging|pre-mix`',
    `quantity_per_batch` DECIMAL(18,2) COMMENT 'The quantity of raw material required per production batch of the finished good. Used for material requirements planning (MRP) and cost of goods sold (COGS) calculation.',
    `scrap_factor_percent` DECIMAL(18,2) COMMENT 'The expected scrap or waste percentage for this ingredient during production. Used for accurate material planning and waste management tracking.',
    `source_system` STRING COMMENT 'The operational system of record from which this BOM line item was sourced (e.g., SAP PP, PLM formulation system). Supports data lineage and reconciliation.. Valid values are `SAP_PP|PLM|MES|ERP|MANUAL`',
    `source_system_code` STRING COMMENT 'The unique identifier of this BOM line item in the source operational system. Enables traceability back to the system of record for reconciliation and troubleshooting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity per batch field. Standardized to support accurate material planning and inventory management. [ENUM-REF-CANDIDATE: kg|g|L|mL|oz|lb|gal|unit|each — 9 candidates stripped; promote to reference product]',
    `yield_factor_percent` DECIMAL(18,2) COMMENT 'The expected yield percentage for this ingredient in the manufacturing process. Accounts for material loss during processing (e.g., evaporation, trimming). Used to calculate actual material requirements.',
    CONSTRAINT pk_formulation_line PRIMARY KEY(`formulation_line_id`)
) COMMENT 'Bill of Materials (BOM) line-item record linking a finished good or intermediate SKU to its constituent raw materials and sub-components. Captures BOM header reference (finished good SKU), BOM version, line item sequence, raw material reference, quantity per batch (UOM), yield factor %, scrap factor %, phase of addition (mixing, blending, coating, filling), and BOM status (active, draft, obsolete). Enables formulation management, COGS calculation, and nutritional panel computation. Sourced from SAP PP BOM and PLM formulation records.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` (
    `nutritional_profile_id` BIGINT COMMENT 'Primary key for nutritional_profile',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Nutritional panel approvals are recorded for compliance audits; linking to employee ensures traceability of the approving staff.',
    `raw_material_id` BIGINT COMMENT 'FK to ingredient.raw_material',
    `primary_nutritional_raw_material_id` BIGINT COMMENT 'Foreign key reference to the ingredient master record for which this nutritional profile is defined.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Nutritional panels must conform to nutrition specifications; linking enables compliance dashboards.',
    `added_sugars_g` DECIMAL(18,2) COMMENT 'Added sugar content in grams per serving size. Mandatory declaration under updated FDA Nutrition Facts Panel requirements.',
    `analysis_date` DATE COMMENT 'Date when the nutritional analysis was performed by the laboratory or R&D team.',
    `analytical_method` STRING COMMENT 'Laboratory analytical method or protocol used to determine the nutritional composition. Examples include AOAC methods, wet chemistry, NIR spectroscopy, or chromatography techniques.',
    `approval_date` DATE COMMENT 'Date when the nutritional profile was formally approved by quality assurance or regulatory affairs for use in finished goods labeling.',
    `calcium_mg` DECIMAL(18,2) COMMENT 'Calcium content in milligrams per serving size. Essential mineral for bone health and mandatory FDA declaration.',
    `cholesterol_mg` DECIMAL(18,2) COMMENT 'Cholesterol content in milligrams per serving size. Required for FDA Nutrition Facts Panel.',
    `coa_reference_number` STRING COMMENT 'Reference number of the Certificate of Analysis document that contains the detailed nutritional test results for this ingredient batch or lot.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional profile record was first created in the system.',
    `data_source` STRING COMMENT 'Origin of the nutritional data. Indicates whether values are from direct laboratory analysis, supplier-provided specifications, USDA nutrient database, published literature, or calculated from recipe formulation.. Valid values are `laboratory_analysis|supplier_specification|usda_database|literature_value|calculated`',
    `dietary_fiber_g` DECIMAL(18,2) COMMENT 'Dietary fiber content in grams per serving size. Includes soluble and insoluble fiber components.',
    `effective_date` DATE COMMENT 'Date from which this nutritional profile becomes effective and valid for use in finished goods nutritional calculations and labeling.',
    `energy_kcal` DECIMAL(18,2) COMMENT 'Energy content expressed in kilocalories (kcal) per serving size. Required for FDA Nutrition Facts Panel and EU nutritional declaration.',
    `energy_kj` DECIMAL(18,2) COMMENT 'Energy content expressed in kilojoules (kJ) per serving size. Required for EU nutritional declaration and optional for FDA labeling.',
    `expiration_date` DATE COMMENT 'Date after which this nutritional profile is no longer valid and should not be used for new product formulations or label declarations. Nullable for profiles with indefinite validity.',
    `iron_mg` DECIMAL(18,2) COMMENT 'Iron content in milligrams per serving size. Essential mineral for blood health and mandatory FDA declaration.',
    `laboratory_name` STRING COMMENT 'Name of the laboratory or testing facility that performed the nutritional analysis. May be internal R&D lab or third-party accredited laboratory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this nutritional profile record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or contextual information about the nutritional profile. May include notes on variability, seasonal differences, or analytical limitations.',
    `nutritional_profile_status` STRING COMMENT 'Current lifecycle status of the nutritional profile record. Indicates whether the data is draft, approved for use in finished goods labeling, under regulatory review, expired, or superseded by a newer version.. Valid values are `draft|approved|under_review|expired|superseded`',
    `potassium_mg` DECIMAL(18,2) COMMENT 'Potassium content in milligrams per serving size. Mandatory declaration under updated FDA Nutrition Facts Panel.',
    `protein_g` DECIMAL(18,2) COMMENT 'Protein content in grams per serving size. Essential macronutrient for nutritional labeling.',
    `saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fatty acid content in grams per serving size. Required nutrient declaration for cardiovascular health labeling.',
    `serving_size_uom` STRING COMMENT 'Unit of measure for the serving size. Common values include grams (g), milliliters (ml), ounces (oz), or standardized serving units. [ENUM-REF-CANDIDATE: g|ml|oz|cup|tbsp|tsp|serving — 7 candidates stripped; promote to reference product]',
    `serving_size_value` DECIMAL(18,2) COMMENT 'Numeric value representing the serving size for which nutritional values are declared. Typically expressed per 100g or per defined serving unit.',
    `sodium_mg` DECIMAL(18,2) COMMENT 'Sodium content in milligrams per serving size. Critical for cardiovascular health and regulatory compliance.',
    `total_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrate content in grams per serving size, including sugars, starches, and dietary fiber.',
    `total_fat_g` DECIMAL(18,2) COMMENT 'Total fat content in grams per serving size. Includes all fatty acids and lipid components.',
    `total_sugars_g` DECIMAL(18,2) COMMENT 'Total sugar content in grams per serving size, including naturally occurring and added sugars.',
    `trans_fat_g` DECIMAL(18,2) COMMENT 'Trans fatty acid content in grams per serving size. Mandatory declaration under FDA and many international regulations.',
    `version_number` STRING COMMENT 'Version identifier for the nutritional profile record. Supports change tracking and audit trail for ingredient nutritional data updates.',
    `vitamin_a_mcg` DECIMAL(18,2) COMMENT 'Vitamin A content in micrograms per serving size, expressed as retinol activity equivalents (RAE).',
    `vitamin_c_mg` DECIMAL(18,2) COMMENT 'Vitamin C (ascorbic acid) content in milligrams per serving size.',
    `vitamin_d_mcg` DECIMAL(18,2) COMMENT 'Vitamin D content in micrograms per serving size. Mandatory declaration under updated FDA Nutrition Facts Panel.',
    CONSTRAINT pk_nutritional_profile PRIMARY KEY(`nutritional_profile_id`)
) COMMENT 'Nutritional composition record for each raw material, capturing per-100g and per-serving nutrient values required for finished goods nutritional labeling. Captures energy (kcal/kJ), total fat, saturated fat, trans fat, cholesterol, sodium, total carbohydrate, dietary fiber, total sugars, added sugars, protein, and micronutrients (vitamins A, C, D, calcium, iron, potassium) with unit of measure and analytical method. Supports FDA Nutrition Facts Panel and EU Regulation 1169/2011 nutritional declaration. Sourced from TraceGains and internal R&D lab data.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` (
    `organic_certification_id` BIGINT COMMENT 'Unique identifier for the organic certification record. Primary key.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient that is certified organic.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the certified organic ingredient.',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certified organic ingredient is approved for use in production based on current certification status.',
    `audit_date` DATE COMMENT 'The date of the most recent organic compliance audit conducted by the certifying body.',
    `certificate_document_reference` STRING COMMENT 'Digital document reference or file path to the scanned organic certificate stored in the document management system.',
    `certificate_document_url` STRING COMMENT 'URL or hyperlink to access the digital organic certificate document in the document management system.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued by the certifying body for this organic certification.',
    `certification_grade` STRING COMMENT 'The organic grade or classification level of the certified ingredient (100% Organic, Organic, Made with Organic).. Valid values are `100% Organic|Organic|Made with Organic`',
    `certification_standard` STRING COMMENT 'The organic standard or regulation under which the certification was granted.. Valid values are `USDA NOP|EU Organic 2018/848|JAS|COR (Canada Organic Regime)|IFOAM|Other`',
    `certification_status` STRING COMMENT 'Current lifecycle status of the organic certification.. Valid values are `Active|Inactive|Suspended|Revoked|Expired|Pending`',
    `certified_ingredient_name` STRING COMMENT 'The ingredient name as it appears on the organic certificate, which may differ from internal nomenclature.',
    `certified_scope` STRING COMMENT 'Description of the scope of certification, including specific products, processes, or operations covered by the certificate.',
    `certifying_body` STRING COMMENT 'Name of the accredited organization that issued the organic certification (e.g., USDA NOP, ECOCERT, Soil Association, JAS).',
    `certifying_body_code` STRING COMMENT 'Standardized code or accreditation number of the certifying body.',
    `compliance_notes` STRING COMMENT 'Additional notes or comments regarding organic compliance, audit findings, or special conditions of the certification.',
    `country_of_origin` STRING COMMENT 'The country where the certified organic ingredient was produced or grown, using 3-letter ISO country code.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organic certification record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which the organic certification becomes valid and can be used for organic claims.',
    `expiry_date` DATE COMMENT 'The date on which the organic certification expires and must be renewed.',
    `gmo_status` STRING COMMENT 'Genetically Modified Organism status of the certified organic ingredient. Organic certification typically requires non-GMO status.. Valid values are `Non-GMO|GMO-Free|Not Applicable`',
    `issue_date` DATE COMMENT 'The date on which the organic certification was issued by the certifying body.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this organic certification record was last modified.',
    `lot_number` STRING COMMENT 'Specific lot or batch number of the ingredient covered by this organic certification, enabling traceability.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next organic compliance audit.',
    `non_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any non-compliance issues have been identified with this organic certification.',
    `organic_percentage` DECIMAL(18,2) COMMENT 'The percentage of organic content in the certified ingredient, expressed as a decimal (e.g., 95.00 for 95% organic).',
    `production_region` STRING COMMENT 'The specific geographic region or state within the country where the organic ingredient was produced.',
    `renewal_status` STRING COMMENT 'Current status of the certification renewal process.. Valid values are `Current|Pending Renewal|Expired|Suspended|Revoked|Not Required`',
    `traceability_code` STRING COMMENT 'Unique traceability code linking this organic certification to supply chain tracking systems for FSMA compliance.',
    `verification_date` DATE COMMENT 'The date when the organic certification was last verified by internal quality assurance or procurement teams.',
    `verified_by` STRING COMMENT 'Name or identifier of the person or team who last verified the organic certification.',
    CONSTRAINT pk_organic_certification PRIMARY KEY(`organic_certification_id`)
) COMMENT 'Organic certification record for a raw material from a specific supplier, capturing certifying body (USDA NOP, EU Organic Regulation 2018/848, JAS, etc.), certificate number, certified scope (ingredient name as certified), certification grade (100% organic, organic, made with organic), certificate issue date, certificate expiry date, renewal status, and digital certificate document reference. Enables organic claim substantiation for finished goods labeling and USDA NOP audit trail. Sourced from TraceGains Document Management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Primary key for test_result',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Certain key accounts require ingredient test results for regulatory compliance; linking test results to the account enables automated reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Laboratory test results are generated by an analyst; analyst_employee_id links result to the responsible lab employee for QA.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_claim. Business justification: Claim substantiation process references lab test results; linking test_result to the specific marketing claim it supports enables audit trails.',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: Test results are reviewed against FSMA records; linking enables compliance dashboards linking lab results to regulatory filings.',
    `lot_id` BIGINT COMMENT 'Reference to the specific ingredient lot that was tested. Links to the raw material batch received from supplier.',
    `original_test_result_id` BIGINT COMMENT 'Reference to the original test result record if this is a retest. Null for initial tests.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Test results are evaluated against a defined specification; FK ties each result to its spec for audit.',
    `raw_material_id` BIGINT COMMENT 'Reference to the master ingredient specification being tested against.',
    `sample_id` BIGINT COMMENT 'Unique identifier for the physical sample taken from the ingredient lot for testing. Links laboratory result to sample chain of custody.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Quality Inspection Dashboard: test results are reported per shipment to verify compliance of shipped lots.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided the ingredient lot being tested.',
    `coa_document_url` STRING COMMENT 'Link to the digital COA document stored in the document management system.',
    `coa_number` STRING COMMENT 'Unique certificate of analysis document number issued by the testing laboratory or supplier. Primary business identifier for the test result.',
    `coa_received_date` DATE COMMENT 'Date when the COA document was received from the supplier or testing laboratory.',
    `comments` STRING COMMENT 'Free-text notes or observations from the analyst or reviewer regarding the test result or sample condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was first created in the system.',
    `deviation_flag` BOOLEAN COMMENT 'Indicates whether the test result triggered a quality deviation or non-conformance requiring investigation.',
    `deviation_number` STRING COMMENT 'Reference number of the quality deviation or non-conformance record if the test failed specification.',
    `hold_release_status` STRING COMMENT 'Current disposition status of the ingredient lot based on test results. Determines whether lot can be used in production.. Valid values are `hold|released|rejected|conditional_release`',
    `laboratory_accreditation` STRING COMMENT 'Accreditation standard or certification held by the testing laboratory (e.g., ISO 17025, A2LA, UKAS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this test result record was last updated.',
    `pass_fail_status` STRING COMMENT 'Disposition of the test result against specification limits. Determines whether the ingredient lot meets quality requirements.. Valid values are `pass|fail|conditional|pending`',
    `record_source_system` STRING COMMENT 'Name of the source system that created this test result record (e.g., SAP QM, TraceGains, Veeva Vault, LIMS).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this test is mandated by regulatory authority (FDA, USDA, EFSA) versus internal quality control.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the ingredient lot was rejected based on test results. Documents root cause of failure.',
    `release_date` DATE COMMENT 'Date when the ingredient lot was released for use in production based on passing test results.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this test result is a retest of a previously failed or inconclusive test.',
    `review_date` DATE COMMENT 'Date when the test result was reviewed and approved by quality assurance.',
    `reviewer_name` STRING COMMENT 'Name of the quality assurance reviewer who verified and approved the test result.',
    `sample_collection_date` DATE COMMENT 'Date when the sample was collected from the ingredient lot for laboratory testing.',
    `specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the test parameter as defined in the ingredient specification. Null if no upper limit applies.',
    `specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the test parameter as defined in the ingredient specification. Null if no lower limit applies.',
    `specification_target` DECIMAL(18,2) COMMENT 'Target or nominal value for the test parameter. Represents the ideal value within the acceptable range.',
    `test_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory test was completed and results were finalized.',
    `test_cost` DECIMAL(18,2) COMMENT 'Cost incurred for performing the laboratory test. Used for quality cost tracking and analysis.',
    `test_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the test cost amount.. Valid values are `^[A-Z]{3}$`',
    `test_date` DATE COMMENT 'Date when the laboratory test was performed. Principal business event timestamp for the test result.',
    `test_method` STRING COMMENT 'Specific analytical method or protocol used to perform the test (e.g., AOAC 991.14, USP 621, ISO 4833). References standardized laboratory procedures.',
    `test_parameter` STRING COMMENT 'Specific characteristic or property being measured (e.g., Total Plate Count, pH, Moisture Content, Brix, Salmonella, Aflatoxin).',
    `test_priority` STRING COMMENT 'Priority level assigned to the test based on business urgency or regulatory requirement.. Valid values are `routine|expedited|critical|regulatory`',
    `test_result_value` DECIMAL(18,2) COMMENT 'Measured value or observation from the laboratory test. May be numeric, qualitative (detected/not detected), or descriptive depending on test type.',
    `test_type` STRING COMMENT 'Category of laboratory test performed on the ingredient lot. Classifies the analytical method domain. [ENUM-REF-CANDIDATE: microbiological|chemical|physical|sensory|nutritional|allergen|contaminant|shelf_life — 8 candidates stripped; promote to reference product]',
    `testing_laboratory` STRING COMMENT 'Name of the laboratory that performed the test (internal lab or third-party contract lab).',
    `unit_of_measure` STRING COMMENT 'Unit in which the test result is expressed (e.g., CFU/g, %, ppm, pH units, degrees Brix). Empty for qualitative tests.',
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Laboratory test result and Certificate of Analysis record for raw material lots, capturing individual analytical test results, COA reference data, supplier COA receipt, and pass/fail disposition against specifications';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` (
    `supplier_document_id` BIGINT COMMENT 'Unique identifier for the supplier document record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality assurance or procurement team member who reviewed and approved or rejected the document.',
    `plant_id` BIGINT COMMENT 'Reference to the supplier facility or site that this document certifies. Null if the document applies to the supplier organization as a whole.',
    `raw_material_id` BIGINT COMMENT 'Reference to the specific ingredient or raw material that this document applies to. Null if the document applies to multiple ingredients or the supplier in general.',
    `superseded_by_document_supplier_document_id` BIGINT COMMENT 'Reference to the newer supplier document that replaces this one. Null if this is the current version.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this document.',
    `allergen_declaration` STRING COMMENT 'Text field capturing the allergen statement from the supplier, listing all major allergens present or potentially present due to cross-contact (e.g., Contains: Milk, Soy. May Contain: Tree Nuts). Applicable to allergen statements.',
    `approval_status` STRING COMMENT 'Approval decision status indicating whether the document has been accepted, rejected, or is awaiting review by the quality or procurement team.. Valid values are `approved|rejected|pending|conditional`',
    `audit_grade` STRING COMMENT 'Qualitative grade or rating assigned by the certifying body for GFSI audit certificates (e.g., AA, A, B, C for BRC; Excellent, Good for SQF). Null for non-audit documents.. Valid values are `excellent|good|compliant|non_compliant`',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the certifying body during a GFSI audit (e.g., SQF, BRC, FSSC 22000, IFS). Typically expressed as a percentage or points out of a maximum. Null for non-audit documents.',
    `certification_grade` STRING COMMENT 'Grade or designation of the certification. For organic: 100% organic, organic, made with organic. For kosher: Pareve, Dairy, Meat, Passover. Null for non-graded certifications. [ENUM-REF-CANDIDATE: 100_percent_organic|organic|made_with_organic|pareve|dairy|meat|passover — 7 candidates stripped; promote to reference product]',
    `certification_standard` STRING COMMENT 'The specific standard or regulation under which the document was issued (e.g., USDA NOP, EU Organic 2018/848, JAS, SQF Level 3, BRC Issue 9, FSSC 22000 v5.1, IFS Food v7).',
    `certified_scope` STRING COMMENT 'Description of the products, processes, or facilities covered by this certificate (e.g., Organic Cane Sugar, Halal Beef Processing Facility, Kosher Dairy Ingredients).',
    `certifying_body` STRING COMMENT 'Name of the organization or authority that issued the certificate or document (e.g., USDA, MUI, JAKIM, OU, SQF, BRC, FSSC 22000, IFS, IFANCA, OK, Star-K).',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the certified ingredient or product originates. Applicable to country of origin declarations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier document record was first created in the system.',
    `document_language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of the document (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `document_number` STRING COMMENT 'Unique certificate or document number assigned by the certifying body or supplier.',
    `document_status` STRING COMMENT 'Current lifecycle status of the supplier document in the compliance workflow.. Valid values are `current|expired|pending_review|approved|rejected|superseded`',
    `document_storage_reference` STRING COMMENT 'URI, file path, or storage system reference pointing to the digital copy of the document in the document management system (e.g., TraceGains, SharePoint, S3 bucket).',
    `document_title` STRING COMMENT 'Full title or name of the supplier document as it appears on the original certificate or statement.',
    `document_type` STRING COMMENT 'Type of supplier compliance document. [ENUM-REF-CANDIDATE: organic_certificate|halal_certificate|kosher_certificate|gfsi_audit|allergen_statement|gmo_declaration|safety_data_sheet|pesticide_residue_statement|heavy_metals_statement|country_of_origin_declaration|certificate_of_analysis|nutritional_data_sheet|microbiological_test_report|shelf_life_study|process_validation|facility_inspection_report — promote to reference product]. Valid values are `organic_certificate|halal_certificate|kosher_certificate|gfsi_audit|allergen_statement|gmo_declaration`',
    `document_version` STRING COMMENT 'Version number or revision identifier of the document, used to track updates and amendments.',
    `effective_date` DATE COMMENT 'Date from which the certificate or document becomes valid and enforceable for compliance purposes.',
    `expiry_date` DATE COMMENT 'Date when the certificate or document expires and is no longer valid. Null for documents without expiration.',
    `file_format` STRING COMMENT 'Digital file format of the stored document.. Valid values are `pdf|docx|xlsx|jpg|png|tiff`',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the document file in kilobytes.',
    `gfsi_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether this document is a GFSI-benchmarked audit certificate (SQF, BRC, FSSC 22000, IFS).',
    `gmo_status` STRING COMMENT 'Declaration of whether the ingredient or product contains genetically modified organisms. Applicable to GMO declarations.. Valid values are `gmo_free|contains_gmo|not_tested`',
    `halal_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether this document certifies the ingredient or product as halal under a recognized certifying body (MUI, JAKIM, IFANCA).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this document record is currently active and should be used for compliance verification. False indicates the record has been archived or soft-deleted.',
    `issue_date` DATE COMMENT 'Date when the certifying body or supplier originally issued the document or certificate.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether this document certifies the ingredient or product as kosher under a recognized certifying agency (OU, OK, Star-K).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier document record was last updated in the system.',
    `non_conformance_count` STRING COMMENT 'Number of non-conformances or deficiencies identified during a GFSI audit. Zero indicates full compliance. Null for non-audit documents.',
    `organic_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether this document certifies the ingredient or product as organic under a recognized standard (USDA NOP, EU Organic, JAS).',
    `renewal_due_date` DATE COMMENT 'Target date by which the supplier must submit a renewed or updated version of the document to maintain continuous compliance.',
    `review_date` DATE COMMENT 'Date when the document was reviewed and an approval decision was made.',
    `review_notes` STRING COMMENT 'Comments or observations recorded by the reviewer during the document review process, including reasons for rejection or conditions for approval.',
    `submission_date` DATE COMMENT 'Date when the supplier submitted the document to the organization for review and approval.',
    CONSTRAINT pk_supplier_document PRIMARY KEY(`supplier_document_id`)
) COMMENT 'Consolidated repository and Single Source of Truth for ALL supplier-submitted compliance, certification, and qualification documents for raw materials — including organic certificates (USDA NOP, EU Organic 2018/848, JAS, with certification grade: 100% organic, organic, made with organic), halal certificates (MUI, JAKIM, IFANCA), kosher certificates (OU, OK, Star-K — Pareve, Dairy, Meat, Passover designations), GFSI audit certificates (SQF, BRC, FSSC 22000, IFS), allergen statements, GMO declarations, safety data sheets, pesticide residue statements, heavy metals statements, and country of origin declarations. Captures document type, certifying body, certificate number, certified scope, certification grade/designation, document version, submission date, expiry date, renewal status, document status (current, expired, pending review, rejected), reviewer ID, review date, and digital document storage reference. This is the SOLE authoritative source for organic certification status, religious dietary certification (halal/kosher), and all supplier qualification documents. Supports supplier qualification, re-approval workflows, religious dietary compliance claims, organic claim substantiation, finished goods labeling claim verification, and audit readiness. Sourced from TraceGains Document Management module.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`substitution` (
    `substitution_id` BIGINT COMMENT 'Primary key for substitution',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ingredient substitution approvals are signed by a responsible employee; approver_employee_id captures who authorized the substitution.',
    `raw_material_id` BIGINT COMMENT 'Reference to the primary raw material or ingredient that is being substituted. Links to the ingredient master data.',
    `substitution_substitute_ingredient_raw_material_id` BIGINT COMMENT 'Reference to the approved alternative raw material or ingredient that can replace the primary ingredient. Links to the ingredient master data.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: REQUIRED: Substitution approval workflow records which supplier provides the approved substitute ingredient.',
    `allergen_equivalence_flag` BOOLEAN COMMENT 'Indicates whether the substitute ingredient has the same allergen profile as the primary ingredient. True = same allergen declaration, False = different allergen profile requiring label review.',
    `approval_date` DATE COMMENT 'Date when the substitution rule was formally approved and authorized for use in production.',
    `clean_label_compatible_flag` BOOLEAN COMMENT 'Indicates whether the substitute ingredient maintains clean label status (free from artificial additives, preservatives, and highly processed ingredients). Critical for products marketed as natural or clean label.',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must be provided with each batch of the substitute ingredient. True for ingredients with critical quality or safety parameters.',
    `cost_impact_percentage` DECIMAL(18,2) COMMENT 'Percentage change in raw material cost when using the substitute versus the primary ingredient. Positive values indicate cost increase, negative values indicate cost savings. Used for COGS (Cost of Goods Sold) analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the substitution record was first created in the system. Audit trail for data lineage and compliance.',
    `effective_end_date` DATE COMMENT 'Date when the substitution rule expires or is no longer valid. Nullable for permanent substitutions. Used for temporary or emergency substitutions with defined time limits.',
    `effective_start_date` DATE COMMENT 'Date when the substitution rule becomes active and can be used in manufacturing operations. Supports phased implementation and supply chain planning.',
    `functional_equivalence_notes` STRING COMMENT 'Detailed technical notes describing how the substitute ingredient performs the same functional role as the primary ingredient. Includes chemical properties, processing behavior, and performance characteristics.',
    `gmo_status_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute ingredient has the same GMO status as the primary ingredient. True = both GMO or both non-GMO, False = different GMO status requiring label and certification review.',
    `label_change_required_flag` BOOLEAN COMMENT 'Indicates whether using the substitute ingredient requires changes to product labeling, including ingredient list, allergen statements, or nutritional panel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the substitution record. Tracks change history for audit and compliance purposes.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the substitution rule. Used to track compliance with review frequency requirements.',
    `manufacturing_impact_notes` STRING COMMENT 'Detailed notes on how the substitution affects manufacturing processes, including equipment settings, processing times, temperature adjustments, and yield impacts.',
    `maximum_substitution_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable percentage of the primary ingredient that can be replaced by the substitute in a formulation. Range 0.00 to 100.00. Critical for maintaining product quality and regulatory compliance.',
    `modified_by_user` STRING COMMENT 'Username or employee identifier of the person who last modified the substitution record. Supports audit trail and accountability.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the substitution rule. Calculated based on last review date and review frequency.',
    `organic_certification_match_flag` BOOLEAN COMMENT 'Indicates whether the substitute ingredient maintains the same organic certification status as the primary ingredient. Critical for products with USDA Organic or equivalent certifications.',
    `priority_rank` STRING COMMENT 'Ranking of this substitution option when multiple substitutes exist for the same primary ingredient. Lower numbers indicate higher priority. Used by manufacturing execution systems to select optimal substitute.',
    `quality_specification_reference` STRING COMMENT 'Reference to the quality specification document that defines acceptance criteria for the substitute ingredient, including Brix, pH, CFU (Colony Forming Units), and other quality parameters.',
    `regulatory_review_required_flag` BOOLEAN COMMENT 'Indicates whether the substitution requires formal regulatory review and approval before implementation. True when substitution impacts nutritional panel, allergen declaration, or regulatory compliance.',
    `review_frequency_days` STRING COMMENT 'Number of days between periodic reviews of the substitution rule. Ensures ongoing validation of functional equivalence, cost impact, and regulatory compliance.',
    `sensory_impact_assessment` STRING COMMENT 'Evaluation of the substitutes impact on organoleptic properties (taste, texture, aroma, appearance). None = no detectable difference, Minor = slight variation within acceptable range, Moderate = noticeable but acceptable, Significant = substantial change requiring consumer testing.. Valid values are `none|minor|moderate|significant`',
    `substitution_code` STRING COMMENT 'Business identifier for the substitution rule. Externally-known code used in manufacturing and procurement systems.. Valid values are `^SUB-[A-Z0-9]{6,12}$`',
    `substitution_status` STRING COMMENT 'Current lifecycle status of the substitution rule. Tracks approval workflow and operational readiness. [ENUM-REF-CANDIDATE: draft|pending_review|approved|active|suspended|expired|rejected — 7 candidates stripped; promote to reference product]',
    `substitution_type` STRING COMMENT 'Classification of the substitution rule. Full = complete replacement at 100%, Partial = limited percentage replacement, Emergency = crisis-driven short-term use, Temporary = time-bound approval, Permanent = long-term approved alternative.. Valid values are `full|partial|emergency|temporary|permanent`',
    `supplier_approval_status` STRING COMMENT 'Status of supplier qualification and approval for the substitute ingredient. Tracks whether the substitute ingredient supplier has passed quality audits and compliance checks.. Valid values are `not_required|pending|approved|rejected`',
    `supply_continuity_reason` STRING COMMENT 'Business justification for establishing the substitution rule. Examples: primary ingredient supply risk, cost optimization, seasonal availability, supplier diversification, quality improvement.',
    `traceability_lot_control_flag` BOOLEAN COMMENT 'Indicates whether the substitute ingredient requires lot-level traceability tracking for FSMA compliance and recall readiness. True for high-risk ingredients.',
    `usage_count` STRING COMMENT 'Number of times the substitution rule has been applied in production batches. Tracks actual utilization and validates business value of maintaining the substitution rule.',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Approved ingredient substitution record defining authorized alternative raw materials that can replace a primary ingredient in a formulation when the primary is unavailable or out-of-spec. Captures primary raw material reference, substitute raw material reference, substitution type (full, partial, emergency), maximum substitution percentage, functional equivalence notes, sensory impact assessment (none, minor, significant), regulatory review required flag, approval status, approved by, and effective date range. Supports supply continuity planning and manufacturing flexibility.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`cost` (
    `cost_id` BIGINT COMMENT 'Primary key for cost',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Profitability analysis allocates ingredient cost records to specific customer accounts to calculate margin per account.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cost records are approved by finance staff; cost approval workflow needs employee reference for audit and variance analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for cost accounting: raw material cost must be allocated to a cost center for internal reporting and budgeting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Expense posting: each ingredient cost entry needs a GL account to record raw material expense in the general ledger.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient for which this cost record applies. Links to the ingredient.raw_material product.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing this ingredient at the specified cost. Links to the procurement.supplier product.',
    `approval_date` DATE COMMENT 'Date on which this cost record was approved by the authorized approver. Part of cost governance and audit trail.',
    `commodity_index_reference` STRING COMMENT 'Reference to the commodity market index used for index-linked pricing (e.g., CME Corn Futures, ICE Sugar No. 11, CBOT Wheat). Applies when price_type is index_linked.',
    `contract_number` STRING COMMENT 'Reference to the purchasing contract number under which this cost is negotiated. Applies when price_type is contract.. Valid values are `^[A-Z0-9]{10}$`',
    `contract_price` DECIMAL(18,2) COMMENT 'Negotiated contract price per unit of measure agreed with the supplier. Applies when price_type is contract.',
    `cost_status` STRING COMMENT 'Current lifecycle status of this cost record: active (currently in use), pending (approved but not yet effective), expired (past expiry_date), superseded (replaced by newer record), or draft (not yet approved).. Valid values are `active|pending|expired|superseded|draft`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the cost is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `duty_cost_per_unit` DECIMAL(18,2) COMMENT 'Import duty or tariff cost per unit of measure for this ingredient. Applies to imported raw materials and contributes to landed cost.',
    `effective_date` DATE COMMENT 'The date from which this cost record becomes valid and applicable for procurement and costing purposes. Start of the validity period.',
    `expiry_date` DATE COMMENT 'The date on which this cost record ceases to be valid. End of the validity period. Null indicates open-ended validity.',
    `freight_cost_per_unit` DECIMAL(18,2) COMMENT 'Freight or transportation cost per unit of measure allocated to this ingredient. Used to calculate total landed cost.',
    `incoterms_code` STRING COMMENT 'Three-letter Incoterms code defining the delivery terms and transfer of risk (e.g., FOB, CIF, EXW, DDP). Impacts landed cost calculation.. Valid values are `^[A-Z]{3}$`',
    `index_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the commodity index value to calculate the index-linked price. Used in formula: price = index_value * index_multiplier + base_adjustment.',
    `invoice_price` DECIMAL(18,2) COMMENT 'Actual invoiced price per unit of measure from the supplier invoice. Represents the final settled price including any adjustments.',
    `is_current_cost` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active cost record for the ingredient-supplier-plant-purchasing_org combination. True for the most recent active record, False for historical records.',
    `landed_cost_per_unit` DECIMAL(18,2) COMMENT 'Total landed cost per unit of measure including base price, freight, duty, and other procurement-related costs. Represents the true total cost of the ingredient delivered to the plant.',
    `last_purchase_price` DECIMAL(18,2) COMMENT 'The most recent actual purchase price per unit of measure paid for this ingredient from this supplier.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity required by the supplier for this ingredient at the specified price. Expressed in the unit_of_measure.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Rolling moving average price per unit of measure calculated from historical purchase transactions. Used for valuation in moving average price materials.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context about this cost record, such as negotiation details, market conditions, or special pricing arrangements.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Aligns with SAP payment terms master data.. Valid values are `^[A-Z0-9]{4}$`',
    `planned_price` DECIMAL(18,2) COMMENT 'Forecasted or budgeted price per unit of measure for future procurement planning and cost modeling.',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant or distribution center where this cost applies. Aligns with SAP plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `price_type` STRING COMMENT 'Classification of the cost record indicating the pricing mechanism: standard (standard cost estimate), contract (negotiated contract price), spot (market spot price), index_linked (commodity index-based price), moving_average (rolling average price), planned (forecasted future price), or historical (actual past purchase price). [ENUM-REF-CANDIDATE: standard|contract|spot|index_linked|moving_average|planned|historical — 7 candidates stripped; promote to reference product]',
    `price_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between current and prior period price, calculated as ((current_price - prior_price) / prior_price) * 100. Expressed as a decimal (e.g., 5.25 for 5.25%).',
    `price_variance_vs_prior_period` DECIMAL(18,2) COMMENT 'Variance between the current period price and the prior period price for the same ingredient and supplier. Used for trend analysis and price escalation tracking.',
    `purchase_order_line_item` STRING COMMENT 'Line item number within the purchase order for this ingredient. Five-digit line item number.. Valid values are `^[0-9]{5}$`',
    `purchase_order_number` STRING COMMENT 'Reference to the purchase order number associated with this cost record for historical purchase price records. Ten-digit SAP purchase order number.. Valid values are `^[0-9]{10}$`',
    `purchasing_org_code` STRING COMMENT 'Four-character code identifying the purchasing organization responsible for procuring this ingredient. Aligns with SAP purchasing organization structure.. Valid values are `^[A-Z0-9]{4}$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost record was first created in the data product. Part of audit trail for data lineage and compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost record was last modified or updated. Part of audit trail for data lineage and compliance.',
    `source_system` STRING COMMENT 'The operational system from which this cost record was sourced: SAP_MM (Material Management), SAP_CO (Controlling/Product Costing), Oracle_Procurement, Manual_Entry (manually entered by procurement), or Market_Feed (commodity market data feed).. Valid values are `SAP_MM|SAP_CO|Oracle_Procurement|Manual_Entry|Market_Feed`',
    `spot_price` DECIMAL(18,2) COMMENT 'Current market spot price per unit of measure for the ingredient. Applies when price_type is spot.',
    `standard_cost` DECIMAL(18,2) COMMENT 'The standard cost per unit of measure as defined in the cost estimate. Used as the baseline for Cost of Goods Sold (COGS) calculation and variance analysis.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for which the cost is expressed (e.g., KG for kilogram, LB for pound, LT for liter, EA for each). Aligns with SAP UOM master data.. Valid values are `^[A-Z]{2,3}$`',
    `update_reason` STRING COMMENT 'Business reason or justification for the cost update or change (e.g., annual contract renewal, commodity price increase, supplier negotiation, standard cost cycle update).',
    `variance_vs_standard` DECIMAL(18,2) COMMENT 'Variance between the actual cost (invoice_price or last_purchase_price) and the standard_cost. Positive values indicate unfavorable variance (actual > standard), negative values indicate favorable variance.',
    `version` STRING COMMENT 'Version number of this cost record for the same ingredient-supplier-plant-purchasing_org combination. Increments with each update to maintain full historical lineage.',
    CONSTRAINT pk_cost PRIMARY KEY(`cost_id`)
) COMMENT 'Single Source of Truth for all raw material pricing and cost data — current standard costs, contract prices, spot prices, AND complete historical purchase price records by supplier and purchasing organization. Captures standard cost per UOM, moving average price, last purchase price, planned price, contract price, spot price, index-linked price, invoice price, cost/price currency, validity period (from/to date), price type (standard, contract, spot, index-linked, historical), plant code, purchasing organization, supplier reference, commodity index reference (CME corn futures, ICE sugar, CBOT wheat), cost variance vs. standard, price variance vs. prior period, and price effective/expiry dates for time-series analysis. This is the SOLE authoritative source for both current and historical ingredient pricing — no other product in any domain stores raw material price records. Supports COGS calculation, formulation cost modeling, procurement negotiation benchmarking, commodity cost trend analysis, standard cost update cycles, and year-over-year price variance reporting. Sourced from SAP MM/CO standard cost estimates, purchase order history, and Oracle Procurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` (
    `fsma_traceability_id` BIGINT COMMENT 'Primary key for fsma_traceability',
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Regulatory FSMA reports must capture the specific asset generating the traceability lot code, ensuring equipment‑level provenance for ingredient batches.',
    `raw_material_id` BIGINT COMMENT 'Reference to the ingredient or raw material subject to FSMA traceability requirements. Links to the raw material master for ingredients on the Food Traceability List (FTL).',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Regulatory Traceability Requirement: FSMA records must reference the specific shipment carrying the raw material.',
    `supplier_id` BIGINT COMMENT 'Reference to the immediate previous source (IPS) supplier who provided the ingredient. Required for receiving CTE traceability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FSMA traceability verification is performed by a qualified employee; verifier_employee_id links verification to responsible staff for regulatory reporting.',
    `compliance_status` STRING COMMENT 'Current compliance status of this traceability record against FSMA Section 204 requirements. Indicates whether all required KDEs are present and accurate.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `cooling_date` DATE COMMENT 'Date when the ingredient was cooled (for produce and other temperature-sensitive items). Required KDE for certain FTL items.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the ingredient was produced or harvested. Required for import traceability and COOL (Country of Origin Labeling) compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this traceability record was first created in the system. Provides audit trail for record creation.',
    `cte_date` DATE COMMENT 'Date when the Critical Tracking Event occurred. Required Key Data Element (KDE) for FSMA 204 compliance. Must enable 24-hour FDA traceability response.',
    `cte_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the Critical Tracking Event occurred, including time zone. Provides granular traceability for time-sensitive food safety investigations.',
    `cte_type` STRING COMMENT 'Type of Critical Tracking Event as defined by FSMA Section 204. Receiving CTE is owned by ingredient domain; transformation and shipping CTEs are owned by manufacturing and distribution domains respectively.. Valid values are `receiving|transformation|shipping|cooling|initial_packing|first_land_based_receiving`',
    `data_source_system` STRING COMMENT 'Name of the source system from which this traceability record was captured (e.g., SAP Batch Management, TraceGains, FoodLogiQ, Rfxcel). Enables data lineage tracking.',
    `exemption_reason` STRING COMMENT 'Reason for exemption from FSMA 204 traceability requirements, if applicable. Certain small businesses and specific food types may be exempt.',
    `fda_facility_registration_number` STRING COMMENT 'FDA-assigned facility registration number for the location where the CTE occurred. Required KDE for FSMA 204 compliance.',
    `ftl_classification` STRING COMMENT 'Classification of the ingredient according to the FDA Food Traceability List. Identifies which FTL category the ingredient belongs to (e.g., leafy greens, fresh-cut fruit, shell eggs, nut butters, finfish, crustaceans, mollusks, prepared ready-to-eat deli salads, tropical tree fruits, cheeses).',
    `ftl_item_code` STRING COMMENT 'Standardized code identifying the specific FTL item. Used for consistent classification across the supply chain.',
    `gln` STRING COMMENT 'GS1 Global Location Number identifying the physical location where the CTE occurred. Provides standardized location identification for supply chain traceability.. Valid values are `^[0-9]{13}$`',
    `growing_location` STRING COMMENT 'Geographic location where the ingredient was grown or harvested. Required KDE for certain FTL items to enable rapid source tracing during outbreaks.',
    `harvest_date` DATE COMMENT 'Date when the ingredient was harvested (for agricultural products). Required KDE for certain FTL items such as leafy greens and fresh produce.',
    `immediate_previous_source_address` STRING COMMENT 'Physical address of the immediate previous source facility. Required for FSMA traceability to enable rapid source identification during food safety events.',
    `immediate_previous_source_name` STRING COMMENT 'Name of the immediate previous source (supplier, grower, processor) who provided the ingredient. Required KDE for receiving CTE.',
    `immediate_previous_source_phone` STRING COMMENT 'Contact phone number for the immediate previous source. Enables rapid communication during food safety investigations and recalls.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this traceability record was last modified. Enables tracking of record changes for audit and compliance purposes.',
    `location_description` STRING COMMENT 'Description of the physical location where the CTE occurred. May include facility name, warehouse, production line, or receiving dock identifier.',
    `notes` STRING COMMENT 'Additional notes or comments related to this traceability event. May include special handling instructions, quality observations, or investigation findings.',
    `packing_date` DATE COMMENT 'Date when the ingredient was initially packed. Required KDE for certain FTL items to track the packing CTE.',
    `product_description` STRING COMMENT 'Description of the ingredient or food product subject to traceability. Required KDE for FSMA 204 compliance to clearly identify the traceable item.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of ingredient received, transformed, or shipped in this Critical Tracking Event. Required KDE for FSMA 204 compliance.',
    `reference_document_number` STRING COMMENT 'Unique identifier of the source document supporting this traceability record. Links the CTE to the originating business transaction or production event.',
    `reference_document_type` STRING COMMENT 'Type of source document supporting this traceability record. Examples include Bill of Lading (BOL), Purchase Order (PO), Advanced Shipping Notice (ASN), production record, or Certificate of Analysis (COA). [ENUM-REF-CANDIDATE: BOL|PO|ASN|production_record|COA|receiving_report|batch_record|shipping_manifest — 8 candidates stripped; promote to reference product]',
    `tlc_source` STRING COMMENT 'Origin of the traceability lot code. Indicates whether the TLC was assigned by the supplier, internally generated, or provided by the original grower/processor.. Valid values are `supplier|internal|grower|processor|manufacturer`',
    `tlc_source_reference` STRING COMMENT 'Reference identifier linking the TLC to the source system or document where it was originally assigned. Enables upstream traceability to the immediate previous source.',
    `traceability_lot_code` STRING COMMENT 'Unique lot code assigned to the ingredient batch for FSMA traceability purposes. The TLC is the core identifier linking all CTEs for a specific ingredient lot throughout the supply chain.',
    `traceability_plan_version` STRING COMMENT 'Version identifier of the FSMA traceability plan under which this record was created. Enables audit trail of traceability process changes.',
    `uom` STRING COMMENT 'Unit of measure for the quantity field (e.g., kg, lbs, gallons, cases). Required KDE for FSMA 204 compliance.',
    `verification_date` DATE COMMENT 'Date when this traceability record was last verified for accuracy and completeness. Supports audit readiness for FDA inspections.',
    `verification_status` STRING COMMENT 'Status of data verification for this traceability record. Indicates whether the record has been validated against source documents and supplier data.. Valid values are `verified|unverified|failed_verification|pending_verification`',
    CONSTRAINT pk_fsma_traceability PRIMARY KEY(`fsma_traceability_id`)
) COMMENT 'FSMA Section 204 Key Data Element (KDE) traceability record capturing Critical Tracking Events (CTEs) required for FDA Food Traceability Rule compliance for foods on the Food Traceability List (FTL). Captures CTE type (receiving, transformation, shipping), traceability lot code (TLC), TLC source reference, location description (FDA facility registration number, GLN), date of CTE, quantity and UOM, reference document type (BOL, PO, production record, ASN), reference document number, immediate previous source (IPS), and KDE data elements per FDA 21 CFR Part 1 Subpart S. This domain owns the ingredient-receiving CTE; manufacturing and distribution domains own transformation and shipping CTEs respectively. Enables 24-hour FDA traceability response capability as mandated by FSMA 204 (compliance deadline January 2026). Sourced from SAP Batch Management, TraceGains, and dedicated traceability platforms (FoodLogiQ, Rfxcel).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` (
    `religious_cert_id` BIGINT COMMENT 'Primary key for religious_cert',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Halal/Kosher certification approvals are signed off by a certifying employee; linking enables certification audit trails.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient that is certified under this religious certification.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the certified ingredient. Religious certifications are supplier-specific as different suppliers of the same ingredient may have different certification statuses.',
    `approval_date` DATE COMMENT 'Date on which the certified ingredient was approved for use in production by internal quality or regulatory teams.',
    `approved_for_use_flag` BOOLEAN COMMENT 'Boolean indicator of whether this certified ingredient from this supplier is approved for use in production. True indicates approval; False indicates the certification exists but ingredient is not yet approved for use (e.g., pending internal review).',
    `audit_date` DATE COMMENT 'Date of the most recent audit or inspection conducted by the certifying body to verify ongoing compliance with religious dietary standards.',
    `certificate_document_reference` STRING COMMENT 'Reference identifier or file path to the digital copy of the certification certificate stored in the document management system. Enables traceability and audit support.',
    `certificate_document_url` STRING COMMENT 'Uniform Resource Locator (URL) or hyperlink to access the digital certificate document. May point to internal document management system or external certifying body portal.',
    `certificate_number` STRING COMMENT 'Unique certificate number or identifier issued by the certifying body. This is the externally-known business identifier for the certification.',
    `certification_standard` STRING COMMENT 'The specific religious dietary standard or guideline under which the certification was granted. May reference specific Halal standards (e.g., MS 1500, SMIIC) or Kosher standards (e.g., OU standards, Star-K guidelines).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the religious certification. Active indicates the certification is valid and in effect. Expired indicates the certificate has passed its expiry date. Suspended indicates temporary hold. Pending Renewal indicates renewal process is underway. Revoked indicates certification was withdrawn. Under Review indicates certification is being audited or reassessed.. Valid values are `Active|Expired|Suspended|Pending Renewal|Revoked|Under Review`',
    `certification_type` STRING COMMENT 'Type of religious dietary certification. Halal certifies compliance with Islamic dietary law. Kosher certifications include Pareve (neutral, contains no meat or dairy), Dairy (contains dairy or dairy equipment), Meat (contains meat or meat equipment), and Passover (meets additional Passover requirements).. Valid values are `Halal|Kosher Pareve|Kosher Dairy|Kosher Meat|Kosher Passover`',
    `certified_ingredient_name` STRING COMMENT 'The ingredient name as it appears on the religious certification certificate. May differ slightly from internal ingredient naming conventions.',
    `certified_scope` STRING COMMENT 'Description of what is covered under this certification. May include specific production facilities, processes, product forms, or lot ranges that are certified.',
    `certifying_body` STRING COMMENT 'Name of the organization or authority that issued the religious certification. Examples include Islamic Food and Nutrition Council (IFNC), Orthodox Union (OU), OK Kosher Certification, Star-K, Majelis Ulama Indonesia (MUI), Department of Islamic Development Malaysia (JAKIM).',
    `certifying_body_code` STRING COMMENT 'Standardized code or abbreviation for the certifying body. Examples: OU, OK, STAR-K, IFANCA, MUI, JAKIM. Used for efficient filtering and reporting.',
    `comments` STRING COMMENT 'General free-text field for additional comments, notes, or context related to this religious certification that do not fit in other structured fields.',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, observations, or special conditions related to the religious certification. May include audit findings, special handling requirements, or restrictions.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the certified ingredient was produced or sourced. Religious certification requirements may vary by country of origin.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this certification record was first created in the system. Supports audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date from which the religious certification becomes valid and can be used for compliance claims. May differ from issue date if there is a grace period or delayed activation.',
    `expiry_date` DATE COMMENT 'Date on which the religious certification expires and is no longer valid. Ingredients cannot be used with certification claims after this date unless renewed.',
    `issue_date` DATE COMMENT 'Date on which the religious certification certificate was issued by the certifying body.',
    `last_review_date` DATE COMMENT 'Date of the most recent internal review of this certification record. Used to track compliance with review frequency requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this certification record was most recently modified. Supports change tracking and audit trail.',
    `lot_number` STRING COMMENT 'Specific lot or batch number of the ingredient covered by this certification, if the certification is lot-specific. Supports traceability for FSMA Food Safety Modernization Act compliance.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit or inspection by the certifying body. Used for planning and ensuring continuous compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next internal review of this certification. Calculated based on last_review_date and review_frequency_days. Supports proactive compliance management.',
    `non_compliance_details` STRING COMMENT 'Description of any non-compliance issues, deviations, or corrective actions required. Populated when non_compliance_flag is True.',
    `non_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether any non-compliance issues have been identified with this certification. True indicates non-compliance detected; False indicates no issues. Triggers investigation and corrective action.',
    `production_region` STRING COMMENT 'Geographic region or facility where the certified ingredient is produced. May include state, province, or specific production site information.',
    `renewal_date` DATE COMMENT 'Date on which the certification was last renewed or is scheduled for renewal. Used for tracking renewal cycles and planning.',
    `renewal_status` STRING COMMENT 'Status of the certification renewal process. Tracks whether renewal is required, underway, completed, or overdue. Critical for maintaining continuous certification coverage.. Valid values are `Not Required|Pending|In Progress|Completed|Overdue|Not Renewed`',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of this certification. Defines the review cycle for ongoing compliance monitoring.',
    `source_record_code` STRING COMMENT 'Unique identifier of this certification record in the source operational system. Enables cross-reference and reconciliation between lakehouse and source systems.',
    `source_system` STRING COMMENT 'Name of the operational system from which this certification record originated. Examples: TraceGains, SAP QM Quality Management, Veeva Vault. Supports data lineage and troubleshooting.',
    `traceability_code` STRING COMMENT 'Unique traceability identifier linking this certification to supply chain traceability systems. Enables end-to-end tracking from raw material to finished goods for recall and compliance purposes.',
    `verification_date` DATE COMMENT 'Date on which the certification was last verified or validated by internal quality assurance or regulatory teams. Supports ongoing compliance monitoring.',
    `verified_by` STRING COMMENT 'Name or identifier of the person or role who performed the most recent verification of the certification. Supports audit trail and accountability.',
    CONSTRAINT pk_religious_cert PRIMARY KEY(`religious_cert_id`)
) COMMENT 'Halal and Kosher certification record for a raw material from a specific supplier, capturing certification type (Halal, Kosher Pareve, Kosher Dairy, Kosher Meat, Kosher Passover), certifying body (Islamic Food and Nutrition Council, Orthodox Union, OK Kosher, Star-K, MUI, JAKIM), certificate number, certified scope, certificate issue date, certificate expiry date, renewal status, and digital certificate reference. Supports religious dietary compliance claims on finished goods and retailer/foodservice customer requirements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` (
    `ingredient_price_history_id` BIGINT COMMENT 'Unique identifier for each ingredient price history record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Contract pricing management tracks historical ingredient prices per customer account for price‑agreement compliance and renegotiation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Price changes are approved by pricing analysts; approver_employee_id provides accountability for price change logs.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient for which the price is recorded.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the ingredient at this price point.',
    `approval_date` DATE COMMENT 'The date on which this price was approved for use in procurement transactions.',
    `baseline_price` DECIMAL(18,2) COMMENT 'The baseline or reference price used for variance calculation. May represent prior period price, budget price, or standard cost.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special conditions related to this price record.',
    `commodity_index_reference` STRING COMMENT 'Reference to the commodity index used for index-linked pricing (e.g., CME corn futures, ICE sugar No. 11, CBOT soybean oil). Enables tracking of price correlation to market indices.',
    `contract_number` STRING COMMENT 'The procurement contract number under which this price was agreed, if applicable.',
    `contract_price` DECIMAL(18,2) COMMENT 'The negotiated contract price for this ingredient, if a contract is in place. May differ from invoice price due to adjustments or spot purchases.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this price history record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the price is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this price becomes effective and applicable for procurement transactions.',
    `expiry_date` DATE COMMENT 'The date on which this price expires and is no longer valid. Null indicates an open-ended price agreement.',
    `freight_cost_included_flag` BOOLEAN COMMENT 'Boolean flag indicating whether freight and logistics costs are included in the stated price. Critical for total landed cost calculation.',
    `incoterms` STRING COMMENT 'The International Commercial Terms (Incoterms) defining the delivery and risk transfer point for this price (e.g., FOB, CIF, DDP). Affects total landed cost. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `index_value` DECIMAL(18,2) COMMENT 'The value of the commodity index at the time this price was set, if index-linked pricing is used.',
    `invoice_price` DECIMAL(18,2) COMMENT 'The actual price invoiced by the supplier for this ingredient at this point in time. Represents the transactional price paid.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this price history record was last updated in the data platform.',
    `lead_time_days` STRING COMMENT 'The number of days from order placement to delivery at this price point. Impacts supply planning and safety stock calculations.',
    `moq` DECIMAL(18,2) COMMENT 'The minimum order quantity required by the supplier to receive this price. Critical for procurement planning and inventory optimization.',
    `moq_uom` STRING COMMENT 'The unit of measure for the minimum order quantity (e.g., kilograms, pounds, cases).',
    `negotiation_reference` STRING COMMENT 'Reference to the sourcing event, RFQ, or negotiation process that resulted in this price. Enables traceability to procurement strategy execution.',
    `payment_terms` STRING COMMENT 'The payment terms associated with this price (e.g., Net 30, Net 60, 2/10 Net 30). Impacts effective cost and cash flow.',
    `price_approval_status` STRING COMMENT 'Approval workflow status for this price record. Supports procurement governance and compliance controls.. Valid values are `approved|pending_approval|rejected|not_required`',
    `price_change_reason` STRING COMMENT 'Business reason or justification for the price change (e.g., commodity market increase, supplier negotiation, volume discount, currency fluctuation, quality upgrade).',
    `price_condition_type` STRING COMMENT 'SAP MM condition type code representing the pricing element (e.g., PB00 for gross price, RA01 for discount). Enables detailed price breakdown analysis.',
    `price_source` STRING COMMENT 'The source system or document from which this price record was captured (e.g., purchase order, contract, purchasing info record, invoice, market data feed, manual entry).. Valid values are `purchase_order|contract|info_record|invoice|market_data|manual_entry`',
    `price_status` STRING COMMENT 'Current lifecycle status of this price record: active (currently in use), expired (past expiry date), superseded (replaced by newer price), pending (not yet effective), or cancelled (voided).. Valid values are `active|expired|superseded|pending|cancelled`',
    `price_type` STRING COMMENT 'Classification of the price mechanism: contract (long-term agreement), spot (market rate at time of purchase), index-linked (tied to commodity index), standard (internal standard cost), or promotional (temporary discount).. Valid values are `contract|spot|index_linked|standard|promotional`',
    `price_uom` STRING COMMENT 'The unit of measure for which the price is quoted (e.g., per kilogram, per pound, per metric ton, per liter). Critical for price normalization and comparison.',
    `price_validity_region` STRING COMMENT 'Geographic region or market for which this price is valid (e.g., North America, EMEA, APAC). Supports multi-region procurement operations.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'The absolute variance in price compared to the prior period or baseline price. Used for cost trend analysis and procurement performance tracking.',
    `price_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance in price compared to the prior period or baseline price. Supports commodity cost trend analysis and negotiation benchmarking.',
    `purchase_order_number` STRING COMMENT 'The purchase order number associated with this price record, if applicable. Sourced from SAP MM or Oracle Procurement.',
    `purchasing_organization_code` STRING COMMENT 'Code identifying the purchasing organization or plant that negotiated or received this price. Aligns with SAP MM purchasing organization structure.',
    `source_record_code` STRING COMMENT 'The unique identifier of this price record in the source system. Enables traceability and reconciliation back to the operational system.',
    `source_system` STRING COMMENT 'The operational system from which this price record was sourced (e.g., SAP MM, Oracle Procurement, manual entry, market data feed).. Valid values are `SAP_MM|Oracle_Procurement|Manual_Entry|Market_Data_Feed`',
    `spot_price` DECIMAL(18,2) COMMENT 'The market spot price for this ingredient at the time of purchase, if applicable. Used for commodities purchased on open market.',
    `standard_cost_update_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this price record triggered or should trigger an update to the ingredients standard cost in the ERP system. Supports standard cost update cycles.',
    `tax_included_flag` BOOLEAN COMMENT 'Boolean flag indicating whether taxes (VAT, GST, sales tax) are included in the stated price.',
    CONSTRAINT pk_ingredient_price_history PRIMARY KEY(`ingredient_price_history_id`)
) COMMENT 'Historical purchase price record for each raw material by supplier and purchasing organization, capturing invoice price, contract price, spot price, price UOM, currency, effective date, expiry date, price type (contract, spot, index-linked), commodity index reference (e.g., CME corn futures, ICE sugar), and price variance vs. prior period. Supports commodity cost trend analysis, procurement negotiation benchmarking, and standard cost update cycles. Sourced from SAP MM purchase order history and Oracle Procurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` (
    `material_asset_cleaning_id` BIGINT COMMENT 'Primary key for the material_asset_cleaning association',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the asset master',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to the raw material master',
    `cleaning_frequency_days` STRING COMMENT 'Number of days between required cleanings for this material‑asset pair',
    `cross_contact_risk_level` STRING COMMENT 'Risk classification (e.g., Low, Medium, High) for allergen cross‑contact between the material and asset',
    `last_cleaned_date` DATE COMMENT 'Date when the material‑asset pair was last cleaned',
    CONSTRAINT pk_material_asset_cleaning PRIMARY KEY(`material_asset_cleaning_id`)
) COMMENT 'Represents the cleaning schedule and cross‑contact risk management between a raw material and a production asset. Each record links one raw material to one asset and captures attributes that exist only in the context of this relationship.. Existence Justification: Each raw material can be processed on many production assets and each asset can handle many raw materials. The company tracks cleaning frequency, cross‑contact risk level, and the last cleaned date for every material‑asset pair to ensure allergen control and GMP compliance. This relationship is actively managed and recorded by operators.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` (
    `formulation_ingredient_id` BIGINT COMMENT 'Primary key for the FormulationIngredient association',
    `formulation_version_id` BIGINT COMMENT 'Foreign key linking to the formulation version',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to the raw material master',
    `allergen_type` STRING COMMENT 'Specific allergen category (e.g., milk, nuts)',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Cost of one unit of the raw material for this formulation',
    `is_allergen` BOOLEAN COMMENT 'Indicates whether the raw material is an allergen in this formulation',
    `is_critical_ingredient` BOOLEAN COMMENT 'Flag indicating if the ingredient is critical for product functionality',
    `is_gmo` BOOLEAN COMMENT 'GMO status of the ingredient for this formulation',
    `is_halal` BOOLEAN COMMENT 'Halal certification status for this ingredient in the formulation',
    `is_kosher` BOOLEAN COMMENT 'Kosher certification status for this ingredient in the formulation',
    `is_organic_certified` BOOLEAN COMMENT 'Whether the ingredient is certified organic in this formulation',
    `quantity_per_batch` DECIMAL(18,2) COMMENT 'Amount of the raw material required per production batch',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity (e.g., kg, L)',
    CONSTRAINT pk_formulation_ingredient PRIMARY KEY(`formulation_ingredient_id`)
) COMMENT 'This association product represents the bill‑of‑materials linking raw_materials to formulation_version records. It captures the quantity, cost, and regulatory attributes that are specific to each raw_materials use in a formulation.. Existence Justification: In R&D, each formulation version is built from many raw materials, and each raw material can appear in many formulation versions. The link is actively managed as a bill‑of‑materials with quantities, cost, allergen and regulatory flags, making the relationship a true operational entity.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`sample` (
    `sample_id` BIGINT COMMENT 'Primary key for sample',
    `raw_material_id` BIGINT COMMENT 'Reference to the ingredient that this sample represents.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier that provided the sample.',
    `parent_sample_id` BIGINT COMMENT 'Self-referencing FK on sample (parent_sample_id)',
    `allergen_declaration` STRING COMMENT 'Allergens present in the sample, listed as a comma‑separated string.',
    `analysis_date` DATE COMMENT 'Date the latest analysis was performed.',
    `analysis_lab` STRING COMMENT 'Name or identifier of the laboratory that performed the analysis.',
    `analysis_result` STRING COMMENT 'Outcome of the most recent quality analysis for the sample.',
    `batch_number` STRING COMMENT 'Manufacturing batch number associated with the sample.',
    `brix_value` DOUBLE COMMENT 'Sugar concentration expressed in degrees Brix.',
    `cfus` BIGINT COMMENT 'Microbial count expressed as colony forming units per gram or milliliter.',
    `coa_number` STRING COMMENT 'Reference number of the Certificate of Analysis associated with the sample.',
    `collected_by` STRING COMMENT 'Name of the employee or technician who collected the sample.',
    `collection_date` DATE COMMENT 'Date the sample was collected from the source.',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the sample was taken.',
    `color` STRING COMMENT 'Observed color of the sample.',
    `compliance_notes` STRING COMMENT 'Free‑text notes regarding regulatory or quality compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sample record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date after which the sample is considered expired for testing or use.',
    `gmo_status` STRING COMMENT 'Indicates whether the sample contains genetically modified organisms.',
    `hazard_status` STRING COMMENT 'Safety classification of the sample.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent testing performed on the sample.',
    `moisture_content_percent` DOUBLE COMMENT 'Percentage of moisture present in the sample.',
    `odor` STRING COMMENT 'Observed odor characteristics of the sample.',
    `organic_certified` BOOLEAN COMMENT 'True if the sample is certified organic, otherwise false.',
    `ph_value` DOUBLE COMMENT 'Measured pH level of the sample.',
    `quality_score` DOUBLE COMMENT 'Numerical score representing overall quality assessment of the sample.',
    `regulatory_status` STRING COMMENT 'Compliance status with relevant food safety regulations.',
    `remarks` STRING COMMENT 'Additional free‑form comments about the sample.',
    `sample_code` STRING COMMENT 'Business code used to reference the sample across systems.',
    `sample_name` STRING COMMENT 'Human‑readable name or label for the sample.',
    `sample_type` STRING COMMENT 'Classification of the sample based on its processing stage.',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample.',
    `storage_location` STRING COMMENT 'Physical location (e.g., warehouse, freezer) where the sample is stored.',
    `storage_temperature_c` DOUBLE COMMENT 'Temperature in degrees Celsius at which the sample is stored.',
    `taste_profile` STRING COMMENT 'Descriptive notes on the taste of the sample.',
    `test_equipment_code` STRING COMMENT 'Identifier of the equipment used for the analysis.',
    `test_method` STRING COMMENT 'Standard method or protocol used for testing the sample.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sample record.',
    `volume_ml` DOUBLE COMMENT 'Volume of the sample in milliliters.',
    `weight_g` DOUBLE COMMENT 'Weight of the sample in grams.',
    CONSTRAINT pk_sample PRIMARY KEY(`sample_id`)
) COMMENT 'Master reference table for sample. Referenced by sample_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_primary_nutritional_raw_material_id` FOREIGN KEY (`primary_nutritional_raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ADD CONSTRAINT `fk_ingredient_organic_certification_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_original_test_result_id` FOREIGN KEY (`original_test_result_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`test_result`(`test_result_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`sample`(`sample_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ADD CONSTRAINT `fk_ingredient_supplier_document_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ADD CONSTRAINT `fk_ingredient_supplier_document_superseded_by_document_supplier_document_id` FOREIGN KEY (`superseded_by_document_supplier_document_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`supplier_document`(`supplier_document_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ADD CONSTRAINT `fk_ingredient_substitution_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ADD CONSTRAINT `fk_ingredient_substitution_substitution_substitute_ingredient_raw_material_id` FOREIGN KEY (`substitution_substitute_ingredient_raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ADD CONSTRAINT `fk_ingredient_ingredient_price_history_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ADD CONSTRAINT `fk_ingredient_material_asset_cleaning_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ADD CONSTRAINT `fk_ingredient_formulation_ingredient_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` ADD CONSTRAINT `fk_ingredient_sample_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` ADD CONSTRAINT `fk_ingredient_sample_parent_sample_id` FOREIGN KEY (`parent_sample_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`sample`(`sample_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`ingredient` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`ingredient` SET TAGS ('dbx_domain' = 'ingredient');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `category_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Haccp Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_eggs` SET TAGS ('dbx_business_glossary_term' = 'Allergen Eggs Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_fish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Fish Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_milk` SET TAGS ('dbx_business_glossary_term' = 'Allergen Milk Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_peanuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Peanuts Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_sesame` SET TAGS ('dbx_business_glossary_term' = 'Allergen Sesame Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_shellfish` SET TAGS ('dbx_business_glossary_term' = 'Allergen Shellfish Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_soybeans` SET TAGS ('dbx_business_glossary_term' = 'Allergen Soybeans Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_tree_nuts` SET TAGS ('dbx_business_glossary_term' = 'Allergen Tree Nuts Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `allergen_wheat` SET TAGS ('dbx_business_glossary_term' = 'Allergen Wheat Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `category_l1` SET TAGS ('dbx_business_glossary_term' = 'Category Level 1 Class');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `category_l2` SET TAGS ('dbx_business_glossary_term' = 'Category Level 2 Sub-Class');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `category_l3` SET TAGS ('dbx_business_glossary_term' = 'Category Level 3 Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `clean_label_eligible` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Eligible Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `e_number` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) E-Number Additive Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `e_number` SET TAGS ('dbx_value_regex' = '^E[0-9]{3,4}[a-z]?$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `fair_trade_certified` SET TAGS ('dbx_business_glossary_term' = 'Fair Trade Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Gluten-Free Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gmo_classification` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Classification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gmo_classification` SET TAGS ('dbx_value_regex' = 'non-GMO|GMO|GMO-derived|unknown');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gmo_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Verification Method');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gmo_verification_method` SET TAGS ('dbx_value_regex' = 'supplier declaration|PCR testing|third-party certification|identity preservation|not verified');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `halal_certified` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `identity_preserved` SET TAGS ('dbx_business_glossary_term' = 'Identity Preserved Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `ingredient_class` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Class');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `kosher_certified` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Lifecycle Stage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'active|under evaluation|approved|restricted|discontinued|phased out');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `moisture_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Moisture Sensitive Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `no_artificial_colors` SET TAGS ('dbx_business_glossary_term' = 'No Artificial Colors Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `no_artificial_flavors` SET TAGS ('dbx_business_glossary_term' = 'No Artificial Flavors Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `no_artificial_preservatives` SET TAGS ('dbx_business_glossary_term' = 'No Artificial Preservatives Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `non_gmo_project_verified` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO Project Verified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `organic_certification_body` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Body');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `origin_type` SET TAGS ('dbx_business_glossary_term' = 'Origin Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `origin_type` SET TAGS ('dbx_value_regex' = 'animal|plant|mineral|synthetic|microbial|biotechnology');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `plant_based` SET TAGS ('dbx_business_glossary_term' = 'Plant-Based Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `regulatory_restriction_profile` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Restriction Profile');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `sensory_appearance` SET TAGS ('dbx_business_glossary_term' = 'Sensory Appearance Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `sensory_aroma` SET TAGS ('dbx_business_glossary_term' = 'Sensory Aroma Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `sensory_color` SET TAGS ('dbx_business_glossary_term' = 'Sensory Color Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `sensory_flavor` SET TAGS ('dbx_business_glossary_term' = 'Sensory Flavor Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `sensory_texture` SET TAGS ('dbx_business_glossary_term' = 'Sensory Texture Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `allergen_declaration_on_file` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration On File');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|revoked|pending');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gfsi_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certificate Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gfsi_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certificate Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gfsi_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Certification Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gfsi_certification_type` SET TAGS ('dbx_value_regex' = 'SQF|BRC|FSSC 22000|IFS|GLOBALG.A.P.|PrimusGFS');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'GMO|Non-GMO|Non-GMO Verified|Organic');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `halal_certified` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `kosher_certified` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `last_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Score');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `moq_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Quantity');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `price_per_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `price_per_uom` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `reapproval_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reapproval Due Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_item_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Item Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_item_description` SET TAGS ('dbx_business_glossary_term' = 'Supplier Item Description');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `coa_document_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `coa_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `fefo_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Sequence Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'GMO|NON_GMO|UNKNOWN');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `internal_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Lot Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `internal_lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'UNRESTRICTED|QUALITY_HOLD|BLOCKED|CONSUMED|EXPIRED|QUARANTINE');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `organic_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Organic Certificate Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'PENDING|IN_PROGRESS|APPROVED|REJECTED|CONDITIONAL');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `sscc` SET TAGS ('dbx_business_glossary_term' = 'Serial Shipping Container Code (SSCC)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `sscc` SET TAGS ('dbx_value_regex' = '^[0-9]{18}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'AMBIENT|REFRIGERATED|FROZEN|CONTROLLED_HUMIDITY|TEMPERATURE_CONTROLLED');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `supplier_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lot Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `temperature_at_receipt` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt (Celsius)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `traceability_lot_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Lot Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `vendor_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `vendor_certification_status` SET TAGS ('dbx_value_regex' = 'CERTIFIED|PROVISIONAL|SUSPENDED|NOT_CERTIFIED');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` SET TAGS ('dbx_subdomain' = 'product_formulation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `allergen_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `coa_document_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Cross-Contact Risk Level');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_value_regex' = 'none|low|medium|high');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_basis` SET TAGS ('dbx_business_glossary_term' = 'Declaration Basis');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_basis` SET TAGS ('dbx_value_regex' = 'formulation|supplier_declaration|lab_test|risk_assessment|facility_audit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|superseded');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'contains|may_contain|free_from|not_present');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `detection_limit_ppm` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit (Parts Per Million)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `precautionary_statement` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Allergen Statement');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `shared_equipment_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Equipment Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `shared_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Facility Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Test Method');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` SET TAGS ('dbx_subdomain' = 'product_formulation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `formulation_line_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Line Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `addition_sequence` SET TAGS ('dbx_business_glossary_term' = 'Addition Sequence Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|draft|obsolete|pending_approval|archived');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bom_version` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Version');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bom_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'cost_reduction|quality_improvement|regulatory_compliance|supplier_change|reformulation|obsolescence');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_allergen` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_critical_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Critical Ingredient Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_gmo` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Certification Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certification Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `is_organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `line_item_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Item Sequence Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `phase_of_addition` SET TAGS ('dbx_business_glossary_term' = 'Phase of Addition');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `phase_of_addition` SET TAGS ('dbx_value_regex' = 'mixing|blending|coating|filling|packaging|pre-mix');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `quantity_per_batch` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Batch');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `scrap_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Scrap Factor Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|PLM|MES|ERP|MANUAL');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `yield_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Factor Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` SET TAGS ('dbx_subdomain' = 'product_formulation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `nutritional_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Profile Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `primary_nutritional_raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `added_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `calcium_mg` SET TAGS ('dbx_business_glossary_term' = 'Calcium (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `cholesterol_mg` SET TAGS ('dbx_business_glossary_term' = 'Cholesterol (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `coa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Reference Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'laboratory_analysis|supplier_specification|usda_database|literature_value|calculated');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `dietary_fiber_g` SET TAGS ('dbx_business_glossary_term' = 'Dietary Fiber (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `energy_kcal` SET TAGS ('dbx_business_glossary_term' = 'Energy (kcal)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `energy_kj` SET TAGS ('dbx_business_glossary_term' = 'Energy (kJ)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `iron_mg` SET TAGS ('dbx_business_glossary_term' = 'Iron (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `nutritional_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Profile Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `nutritional_profile_status` SET TAGS ('dbx_value_regex' = 'draft|approved|under_review|expired|superseded');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `potassium_mg` SET TAGS ('dbx_business_glossary_term' = 'Potassium (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `protein_g` SET TAGS ('dbx_business_glossary_term' = 'Protein (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `saturated_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `serving_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Serving Size Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `serving_size_value` SET TAGS ('dbx_business_glossary_term' = 'Serving Size Value');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `sodium_mg` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `total_carbohydrate_g` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `total_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Total Fat (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `total_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Total Sugars (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `trans_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Trans Fat (g)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `vitamin_a_mcg` SET TAGS ('dbx_business_glossary_term' = 'Vitamin A (mcg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `vitamin_c_mg` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `vitamin_d_mcg` SET TAGS ('dbx_business_glossary_term' = 'Vitamin D (mcg)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `organic_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certificate_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL (Uniform Resource Locator)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_grade` SET TAGS ('dbx_business_glossary_term' = 'Certification Grade');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_grade` SET TAGS ('dbx_value_regex' = '100% Organic|Organic|Made with Organic');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_standard` SET TAGS ('dbx_value_regex' = 'USDA NOP|EU Organic 2018/848|JAS|COR (Canada Organic Regime)|IFOAM|Other');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Revoked|Expired|Pending');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certified_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Ingredient Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certified_scope` SET TAGS ('dbx_business_glossary_term' = 'Certified Scope');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `certifying_body_code` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'GMO (Genetically Modified Organism) Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'Non-GMO|GMO-Free|Not Applicable');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `non_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `organic_percentage` SET TAGS ('dbx_business_glossary_term' = 'Organic Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `production_region` SET TAGS ('dbx_business_glossary_term' = 'Production Region');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'Current|Pending Renewal|Expired|Suspended|Revoked|Not Required');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`organic_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `original_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `coa_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document URL');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `coa_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Deviation Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `deviation_number` SET TAGS ('dbx_business_glossary_term' = 'Deviation Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `hold_release_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `hold_release_status` SET TAGS ('dbx_value_regex' = 'hold|released|rejected|conditional_release');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `laboratory_accreditation` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|pending');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `specification_max` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `specification_min` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `specification_target` SET TAGS ('dbx_business_glossary_term' = 'Specification Target');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_cost` SET TAGS ('dbx_business_glossary_term' = 'Test Cost');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Test Cost Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_parameter` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'routine|expedited|critical|regulatory');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_result_value` SET TAGS ('dbx_business_glossary_term' = 'Test Result Value');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `testing_laboratory` SET TAGS ('dbx_business_glossary_term' = 'Testing Laboratory');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `supplier_document_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Document ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Facility ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `superseded_by_document_supplier_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|conditional');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `audit_grade` SET TAGS ('dbx_value_regex' = 'excellent|good|compliant|non_compliant');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `certification_grade` SET TAGS ('dbx_business_glossary_term' = 'Certification Grade');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `certified_scope` SET TAGS ('dbx_business_glossary_term' = 'Certified Scope');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending_review|approved|rejected|superseded');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'organic_certificate|halal_certificate|kosher_certificate|gfsi_audit|allergen_statement|gmo_declaration');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|jpg|png|tiff');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `gfsi_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'GFSI (Global Food Safety Initiative) Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'GMO (Genetically Modified Organism) Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'gmo_free|contains_gmo|not_tested');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`supplier_document` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` SET TAGS ('dbx_subdomain' = 'product_formulation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_substitute_ingredient_raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Substitute Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `allergen_equivalence_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Equivalence Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `clean_label_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Clean Label Compatible Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'COA (Certificate of Analysis) Required Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `cost_impact_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `cost_impact_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `functional_equivalence_notes` SET TAGS ('dbx_business_glossary_term' = 'Functional Equivalence Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `gmo_status_match_flag` SET TAGS ('dbx_business_glossary_term' = 'GMO (Genetically Modified Organism) Status Match Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `label_change_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Change Required Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `manufacturing_impact_notes` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Impact Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `maximum_substitution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Substitution Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `organic_certification_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Match Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `quality_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `regulatory_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Required Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `sensory_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Sensory Impact Assessment');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `sensory_impact_assessment` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|significant');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_code` SET TAGS ('dbx_value_regex' = '^SUB-[A-Z0-9]{6,12}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_status` SET TAGS ('dbx_business_glossary_term' = 'Substitution Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_business_glossary_term' = 'Substitution Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `substitution_type` SET TAGS ('dbx_value_regex' = 'full|partial|emergency|temporary|permanent');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `supplier_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Approval Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `supplier_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `supply_continuity_reason` SET TAGS ('dbx_business_glossary_term' = 'Supply Continuity Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `traceability_lot_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Traceability Lot Control Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`substitution` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `commodity_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|draft');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `duty_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Duty Cost per Unit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `freight_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost per Unit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `index_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Index Multiplier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `invoice_price` SET TAGS ('dbx_business_glossary_term' = 'Invoice Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `is_current_cost` SET TAGS ('dbx_business_glossary_term' = 'Is Current Cost');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `landed_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Landed Cost per Unit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `last_purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `planned_price` SET TAGS ('dbx_business_glossary_term' = 'Planned Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `price_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `price_variance_vs_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Price Variance vs Prior Period');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchase_order_line_item` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Item');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchase_order_line_item` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|SAP_CO|Oracle_Procurement|Manual_Entry|Market_Feed');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `spot_price` SET TAGS ('dbx_business_glossary_term' = 'Spot Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `update_reason` SET TAGS ('dbx_business_glossary_term' = 'Cost Update Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `variance_vs_standard` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance vs Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `fsma_traceability_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Traceability Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verifier Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `cooling_date` SET TAGS ('dbx_business_glossary_term' = 'Cooling Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `cte_date` SET TAGS ('dbx_business_glossary_term' = 'Critical Tracking Event (CTE) Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `cte_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Critical Tracking Event (CTE) Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `cte_type` SET TAGS ('dbx_business_glossary_term' = 'Critical Tracking Event (CTE) Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `cte_type` SET TAGS ('dbx_value_regex' = 'receiving|transformation|shipping|cooling|initial_packing|first_land_based_receiving');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `fda_facility_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Facility Registration Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `ftl_classification` SET TAGS ('dbx_business_glossary_term' = 'Food Traceability List (FTL) Classification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `ftl_item_code` SET TAGS ('dbx_business_glossary_term' = 'Food Traceability List (FTL) Item Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `growing_location` SET TAGS ('dbx_business_glossary_term' = 'Growing Location');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `harvest_date` SET TAGS ('dbx_business_glossary_term' = 'Harvest Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_address` SET TAGS ('dbx_business_glossary_term' = 'Immediate Previous Source (IPS) Address');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_name` SET TAGS ('dbx_business_glossary_term' = 'Immediate Previous Source (IPS) Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_phone` SET TAGS ('dbx_business_glossary_term' = 'Immediate Previous Source (IPS) Phone Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `immediate_previous_source_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `packing_date` SET TAGS ('dbx_business_glossary_term' = 'Packing Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `tlc_source` SET TAGS ('dbx_business_glossary_term' = 'Traceability Lot Code (TLC) Source');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `tlc_source` SET TAGS ('dbx_value_regex' = 'supplier|internal|grower|processor|manufacturer');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `tlc_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Traceability Lot Code (TLC) Source Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `traceability_lot_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Lot Code (TLC)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `traceability_plan_version` SET TAGS ('dbx_business_glossary_term' = 'Traceability Plan Version');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed_verification|pending_verification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `religious_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Religious Cert Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `approved_for_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Use Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certificate_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Suspended|Pending Renewal|Revoked|Under Review');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'Halal|Kosher Pareve|Kosher Dairy|Kosher Meat|Kosher Passover');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certified_ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Ingredient Name');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certified_scope` SET TAGS ('dbx_business_glossary_term' = 'Certified Scope');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `certifying_body_code` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `non_compliance_details` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Details');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `non_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `production_region` SET TAGS ('dbx_business_glossary_term' = 'Production Region');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|In Progress|Completed|Overdue|Not Renewed');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Traceability Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` SET TAGS ('dbx_subdomain' = 'ingredient_sourcing');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `ingredient_price_history_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Price History ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `baseline_price` SET TAGS ('dbx_business_glossary_term' = 'Baseline Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `commodity_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `freight_cost_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Included Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `index_value` SET TAGS ('dbx_business_glossary_term' = 'Index Value');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `invoice_price` SET TAGS ('dbx_business_glossary_term' = 'Invoice Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `moq_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `negotiation_reference` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Reference');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Price Approval Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Price Condition Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'purchase_order|contract|info_record|invoice|market_data|manual_entry');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|expired|superseded|pending|cancelled');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'contract|spot|index_linked|standard|promotional');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_uom` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_validity_region` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Region');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `price_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|Oracle_Procurement|Manual_Entry|Market_Data_Feed');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `spot_price` SET TAGS ('dbx_business_glossary_term' = 'Spot Price');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `standard_cost_update_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Update Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`ingredient_price_history` ALTER COLUMN `tax_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Included Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` SET TAGS ('dbx_association_edges' = 'ingredient.raw_material,maintenance.asset');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `material_asset_cleaning_id` SET TAGS ('dbx_business_glossary_term' = 'Material Asset Cleaning - Material Asset Cleaning Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Material Asset Cleaning - Asset Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Asset Cleaning - Raw Material Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `cleaning_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Frequency');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `cleaning_frequency_days` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Contact Risk');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `cross_contact_risk_level` SET TAGS ('dbx_risk' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `last_cleaned_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cleaned Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`material_asset_cleaning` ALTER COLUMN `last_cleaned_date` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` SET TAGS ('dbx_subdomain' = 'product_formulation');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` SET TAGS ('dbx_association_edges' = 'ingredient.raw_material,research.formulation_version');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Formulationingredient - Formulation Ingredient Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `formulation_version_id` SET TAGS ('dbx_business_glossary_term' = 'Formulationingredient - Formulation Version Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Formulationingredient - Raw Material Id');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost per Unit');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_allergen` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_critical_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Critical Ingredient Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_gmo` SET TAGS ('dbx_business_glossary_term' = 'GMO Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `is_organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `quantity_per_batch` SET TAGS ('dbx_business_glossary_term' = 'Quantity per Batch');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_ingredient` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` ALTER COLUMN `sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`sample` ALTER COLUMN `parent_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
