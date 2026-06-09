-- Schema for Domain: ingredient | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`ingredient` COMMENT 'Authoritative domain for all raw materials, additives, flavors, preservatives, and packaging components used in F&B manufacturing. Manages ingredient specifications, supplier-approved ingredient lists, Brix/pH/CFU tolerances, clean-label attributes, allergen declarations, GMO status, organic certifications, certificates of analysis (COA), and ingredient traceability for FSMA compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`raw_material` (
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the raw material. Primary key for this master data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Key accounts often have approved‑ingredient lists; linking raw material to the account records which accounts have approved each ingredient.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to marketing.brand. Business justification: Brand Ingredient Compliance Report requires mapping each raw material to the brand that uses it for labeling and regulatory compliance.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Required for FDA facility traceability of raw material source; regulatory compliance reports demand linking each ingredient to its registered establishment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Raw materials are assigned to valuation classes that map to inventory GL accounts for goods receipt and consumption postings. In F&B ERP (SAP), the material master GL account assignment drives all inv',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Novel ingredient registration requires a FK to product_registration to track approval status, jurisdiction, and compliance deadlines.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Raw material master records in F&B ERP carry a profit center assignment that drives brand/segment P&L reporting. Inventory consumption and cost of goods sold postings inherit the profit center from th',
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
    `gfsi_certification_id` BIGINT COMMENT 'Foreign key linking to regulatory.gfsi_certification. Business justification: GFSI certification (BRC, SQF, FSSC 22000) is a mandatory requirement for supplier approval in F&B. approved_supplier currently stores gfsi_certificate_number, gfsi_certificate_expiry_date, gfsi_certif',
    `raw_material_id` BIGINT COMMENT 'Unique identifier for the approved supplier-ingredient relationship record. Primary key for the approved supplier list entry.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Approved supplier records in F&B reference the governing supply contract. contract_reference_number on approved_supplier is a denormalized reference to purchase_contract. Direct FK enables navigation ',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier entity that is approved to supply this ingredient. Links to the supplier master data.',
    `supplier_quality_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.supplier_quality_assessment. Business justification: Approved Supplier List (ASL) status is directly driven by supplier quality assessment outcomes. When an SQA is completed, the approved_supplier record is updated (approved/conditional/suspended). This',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier approval in F&B is site-specific — a suppliers German plant may be approved while their Chinese plant is not. Site-level qualification is a named process in AVL management, FSMA compliance, ',
    `allergen_declaration_on_file` BOOLEAN COMMENT 'Indicates whether a current allergen declaration document is on file for this supplier-ingredient combination. Critical for FSMA compliance and allergen management programs.',
    `approval_date` DATE COMMENT 'The date when the supplier was officially approved to supply this ingredient. Marks the start of the authorized sourcing relationship.',
    `approval_status` STRING COMMENT 'Current approval status of the supplier for this specific ingredient. Approved = fully authorized; Conditional = approved with restrictions; Suspended = temporarily not allowed; Revoked = permanently removed; Pending = under review.. Valid values are `approved|conditional|suspended|revoked|pending`',
    `coa_required` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis (COA) must be provided with each shipment of this ingredient from this supplier. COAs verify ingredient specifications and quality parameters.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the ingredient is sourced or manufactured by the supplier. Critical for FSMA (Food Safety Modernization Act) traceability and customs compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this approved supplier record was first created in the system. Part of the audit trail for data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the pricing (e.g., USD, EUR, GBP). Essential for multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this approved supplier relationship expires or is terminated. Null indicates an open-ended relationship. Used for contract lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this approved supplier relationship is effective. Used for time-based sourcing decisions and historical tracking.',
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
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: When a received lot fails quality inspection, the corresponding AP invoice must be disputed or credited. Direct lot-to-invoice traceability supports deduction management, short-pay processing, and sup',
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: A received lot (batch) originates from a specific Approved Supplier List (ASL) entry — the approved_supplier record that authorized the supply of that raw_material from that supplier. Linking lot.appr',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inventory valuation: lot balances are reported per legal entity (company code) for financial statements and compliance.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: FSMA 204 and recall management require tracing ingredient lots to the finished product SKU they were consumed in during production. Role-prefix consumed distinguishes this from lots own identity — ',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: FSMA compliance requires each ingredient lot to be associated with a specific FSMA record for traceability and audit.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: REQUIRED: Quality inspection and FSMA traceability reports link each lot to the specific goods receipt that delivered it.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: REQUIRED: FSMA traceability report needs to link each raw‑material lot to its inbound shipment for recall and compliance.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Lot‑level quality inspections are recorded; linking lot to inspection_lot enables traceability reports.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: FSMA traceability: link ingredient lot to sales order to identify which orders contain the lot for recall and compliance reporting.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Ingredient lots are received and stored at specific manufacturing plants. plant_code on ingredient.lot is a denormalized plain text reference to manufacturing.plant. Normalizing enables plant-level in',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: REQUIRED: Recall & audit process needs to map each raw‑material lot to its originating purchase order for traceability and compliance.',
    `raw_material_id` BIGINT COMMENT 'Reference to the master ingredient specification that this lot represents.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: A specific ingredient lot is the unit of recall action (e.g., contaminated lot triggers Class I recall). Lot disposition, recovery counts, and regulatory reporting all require direct linkage between t',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: REQUIRED: Raw material receipt location tracking for inventory audit and FSMA traceability; experts expect each lot to reference its storage location.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided this ingredient lot.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: FSMA 204 CTEs and country-of-origin traceability require knowing the specific manufacturing site that produced each received lot, not just the supplier company. Lot-to-site linkage is essential for re',
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
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: Allergen cross-contact risk and declaration status can vary by supplier facility — the same raw material sourced from different approved suppliers may carry different shared_equipment_flag or cross_co',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.claim. Business justification: Allergen declaration records substantiate allergen-free marketing claims. When cross_contact_risk_level or shared_equipment_flag changes, linked claims must be reviewed and potentially withdrawn. F&B ',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient for which this allergen declaration applies. Links to the ingredient master data.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: Undeclared allergens are the #1 cause of FDA recalls. When an allergen non-compliance is identified, the allergen record must reference the triggered recall_event for FSMA root cause documentation and',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided the allergen declaration or certificate of analysis for this ingredient.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Allergen cross-contact risk (shared equipment, shared facility flags) is site-specific in F&B. A suppliers Site A may share allergen lines while Site B does not. Allergen declaration management and F',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Private label and co-manufacturing operations require tracking which customer account commissioned or owns a proprietary formulation. F&B domain experts managing contract manufacturing would expect fo',
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: A BOM formulation line specifies not just which raw_material is used but which approved supplier is designated as the primary source for that ingredient in the formulation. Linking formulation_line.ap',
    `approved_vendor_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_vendor_list. Business justification: Formulation approval in F&B requires validating that the preferred supplier for each formulation line is on the AVL for that raw material. Direct formulation_line → AVL linkage enables automated compl',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key reference to the parent BOM header record representing the finished good or intermediate SKU. Links this line item to its parent formulation.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.claim. Business justification: Formulation line composition (allergen, organic, GMO, kosher, halal flags) directly substantiates marketing claims. R&D and regulatory teams link specific formulation versions to the claims they enabl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Formulation lines represent manufacturing process steps (mixing, blending, cooking) that incur costs allocated to plant cost centers in F&B. Linking formulation lines to cost centers enables manufactu',
    `sku_id` BIGINT COMMENT 'Reference to the finished good or intermediate product SKU that this BOM line contributes to. Enables traceability from raw material to final product.',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: formulation_line is the child line-item of a formulation header (product.formulation). F&B recipe management requires this parent-child link for version control, regulatory submission, and nutrient ca',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.haccp_plan. Business justification: HACCP plans govern the manufacturing process for a finished good. Formulation lines define ingredient composition per finished good SKU. Linking formulation_line→haccp_plan enables food safety teams t',
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
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.claim. Business justification: Nutritional profiles are the primary substantiation source for nutrition-content marketing claims (high protein, low sodium, good source of fiber). FDA/FTC claim substantiation requires linking ',
    `nutrition_label_id` BIGINT COMMENT 'Foreign key linking to regulatory.nutrition_label. Business justification: Nutrition labels are calculated from and validated against ingredient nutritional profiles. FDA/EFSA label accuracy audits require tracing the nutrition_label back to the source nutritional_profile da',
    `raw_material_id` BIGINT COMMENT 'Foreign key reference to the ingredient master record for which this nutritional profile is defined.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`test_result` (
    `test_result_id` BIGINT COMMENT 'Primary key for test_result',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: In-process quality testing: ingredient test results generated during manufacturing (e.g., in-process checks at point of ingredient use) must reference the batch_record they support. Drives batch relea',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.center. Business justification: Incoming ingredient quality testing is performed at the receiving distribution center. Linking test_result to center enables facility-level quality reporting, FSMA traceability by receiving location, ',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.marketing_claim. Business justification: Claim substantiation process references lab test results; linking test_result to the specific marketing claim it supports enables audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: test_result carries test_cost and test_cost_currency_code. Lab testing expenses must be allocated to quality cost centers for F&B cost-of-quality reporting and budget tracking. A domain expert would e',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: Ingredient test results (pathogen, allergen, chemical) are conducted as verification activities under a food safety plan (FSMA HARPC/HACCP). Linking test_result to food_safety_plan enables verificatio',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: Test results are reviewed against FSMA records; linking enables compliance dashboards linking lab results to regulatory filings.',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_shipment. Business justification: Quality test results on incoming ingredients are directly triggered by inbound shipments; the shipment is placed on quality hold pending test completion. F&B quality hold/release workflows require lin',
    `lot_id` BIGINT COMMENT 'Reference to the specific ingredient lot that was tested. Links to the raw material batch received from supplier.',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: Quality disposition decisions (release, hold, reject) on ingredient test results must be directly linked to inventory lot trace records to trigger stock status changes. QA teams use this link in daily',
    `original_test_result_id` BIGINT COMMENT 'Reference to the original test result record if this is a retest. Null for initial tests.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Test results are evaluated against a defined specification; FK ties each result to its spec for audit.',
    `raw_material_id` BIGINT COMMENT 'Reference to the master ingredient specification being tested against.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: A positive test result (e.g., Listeria, Salmonella, undeclared allergen) is the direct trigger for a recall event. Linking test_result to recall_event enables root cause analysis documentation and reg',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who provided the ingredient lot being tested.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: CoA and quality test results in F&B are issued by specific manufacturing sites. Quality trending, supplier scorecard inputs, and FSMA preventive controls require knowing which site produced the tested',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`ingredient`.`cost` (
    `cost_id` BIGINT COMMENT 'Primary key for cost',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Profitability analysis allocates ingredient cost records to specific customer accounts to calculate margin per account.',
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: Raw material cost records (contract price, standard cost, invoice price) are inherently tied to a specific approved supplier agreement — the approved_supplier ASL entry captures the negotiated price_p',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Raw material cost records are legal-entity specific in multi-country F&B operations (transfer pricing, local currency valuation, intercompany procurement). ingredient.lot already has company_code_id; ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for cost accounting: raw material cost must be allocated to a cost center for internal reporting and budgeting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Raw material standard cost records are period-bound; period-close and cost variance reporting in F&B require linking ingredient cost versions to fiscal periods. Enables period-over-period price varian',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Expense posting: each ingredient cost entry needs a GL account to record raw material expense in the general ledger.',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.import_export_permit. Business justification: Ingredient landed costs include duty rates and tariff classifications governed by specific import permits. Linking cost to import_export_permit enables trade compliance teams to validate duty_cost_per',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Ingredient costs are plant-specific (different freight, duty, storage costs per facility). plant_code on ingredient.cost is a denormalized plain text reference to manufacturing.plant. Normalizing enab',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Raw material cost reporting by profit center drives brand/product-line P&L in F&B. Standard ERP cost records carry profit center alongside cost_center and GL account. Enables ingredient cost contribut',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: Ingredient cost records in F&B are governed by purchase contracts. contract_number and contract_price on the cost product are denormalized from purchase_contract. Direct FK enables price variance anal',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient for which this cost record applies. Links to the ingredient.raw_material product.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing this ingredient at the specified cost. Links to the procurement.supplier product.',
    `approval_date` DATE COMMENT 'Date on which this cost record was approved by the authorized approver. Part of cost governance and audit trail.',
    `commodity_index_reference` STRING COMMENT 'Reference to the commodity market index used for index-linked pricing (e.g., CME Corn Futures, ICE Sugar No. 11, CBOT Wheat). Applies when price_type is index_linked.',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to distribution.carrier. Business justification: FSMA 204 Section 1.330 requires identifying the transporter for each Critical Tracking Event. fsma_traceability has no structured carrier reference. A Food and Beverage regulatory compliance expert ex',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: FSMA Rule 204 requires each Critical Tracking Event (CTE) to identify the registered facility where it occurred. fsma_traceability.fda_facility_registration_number is a denormalized text field — a pro',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: FSMA 204 Critical Tracking Event records must identify the finished product SKU an ingredient was used in, enabling forward traceability from ingredient receipt to finished goods. product_description ',
    `location_id` BIGINT COMMENT 'Foreign key linking to distribution.location. Business justification: FSMA 204 Critical Tracking Events require linking each CTE to a structured facility record. fsma_traceability.location_description is a denormalized plain-text representation of distribution.location.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: FSMA Section 204 Critical Tracking Events (CTEs) are lot-level traceability records — each CTE (receiving, transformation, shipping) is associated with a specific received batch (lot). Linking fsma_tr',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: FSMA 204 requires linking ingredient-side CTE records (receiving, transformation) to inventory lot trace records to complete the one-up/one-down traceability chain. Regulators and auditors expect this',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: FSMA 204 requires rapid traceability from ingredient source records to the sales event that triggered a recall or FDA investigation. A direct FK from fsma_traceability to sales.order enables regulator',
    `product_recall_id` BIGINT COMMENT 'Foreign key linking to quality.product_recall. Business justification: FSMA 204 traceability records are the primary data source for determining recall scope and FDA notification. Linking fsma_traceability→product_recall enables recall coordinators to pull all traceabili',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: FSMA Section 204 requires traceability records for transformation Key Activity events where ingredients become finished goods. Linking fsma_traceability to production_order documents the manufacturing',
    `raw_material_id` BIGINT COMMENT 'Reference to the ingredient or raw material subject to FSMA traceability requirements. Links to the raw material master for ingredients on the Food Traceability List (FTL).',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Regulatory Traceability Requirement: FSMA records must reference the specific shipment carrying the raw material.',
    `supplier_id` BIGINT COMMENT 'Reference to the immediate previous source (IPS) supplier who provided the ingredient. Required for receiving CTE traceability.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: FSMA 204 requires recording the immediate previous source address, name, and phone — all of which are attributes of supplier_site. Linking fsma_traceability directly to supplier_site normalizes these ',
    `compliance_status` STRING COMMENT 'Current compliance status of this traceability record against FSMA Section 204 requirements. Indicates whether all required KDEs are present and accurate.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `cooling_date` DATE COMMENT 'Date when the ingredient was cooled (for produce and other temperature-sensitive items). Required KDE for certain FTL items.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the ingredient was produced or harvested. Required for import traceability and COOL (Country of Origin Labeling) compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this traceability record was first created in the system. Provides audit trail for record creation.',
    `cte_date` DATE COMMENT 'Date when the Critical Tracking Event occurred. Required Key Data Element (KDE) for FSMA 204 compliance. Must enable 24-hour FDA traceability response.',
    `cte_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the Critical Tracking Event occurred, including time zone. Provides granular traceability for time-sensitive food safety investigations.',
    `cte_type` STRING COMMENT 'Type of Critical Tracking Event as defined by FSMA Section 204. Receiving CTE is owned by ingredient domain; transformation and shipping CTEs are owned by manufacturing and distribution domains respectively.. Valid values are `receiving|transformation|shipping|cooling|initial_packing|first_land_based_receiving`',
    `data_source_system` STRING COMMENT 'Name of the source system from which this traceability record was captured (e.g., SAP Batch Management, TraceGains, FoodLogiQ, Rfxcel). Enables data lineage tracking.',
    `exemption_reason` STRING COMMENT 'Reason for exemption from FSMA 204 traceability requirements, if applicable. Certain small businesses and specific food types may be exempt.',
    `ftl_classification` STRING COMMENT 'Classification of the ingredient according to the FDA Food Traceability List. Identifies which FTL category the ingredient belongs to (e.g., leafy greens, fresh-cut fruit, shell eggs, nut butters, finfish, crustaceans, mollusks, prepared ready-to-eat deli salads, tropical tree fruits, cheeses).',
    `ftl_item_code` STRING COMMENT 'Standardized code identifying the specific FTL item. Used for consistent classification across the supply chain.',
    `gln` STRING COMMENT 'GS1 Global Location Number identifying the physical location where the CTE occurred. Provides standardized location identification for supply chain traceability.. Valid values are `^[0-9]{13}$`',
    `growing_location` STRING COMMENT 'Geographic location where the ingredient was grown or harvested. Required KDE for certain FTL items to enable rapid source tracing during outbreaks.',
    `harvest_date` DATE COMMENT 'Date when the ingredient was harvested (for agricultural products). Required KDE for certain FTL items such as leafy greens and fresh produce.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this traceability record was last modified. Enables tracking of record changes for audit and compliance purposes.',
    `notes` STRING COMMENT 'Additional notes or comments related to this traceability event. May include special handling instructions, quality observations, or investigation findings.',
    `packing_date` DATE COMMENT 'Date when the ingredient was initially packed. Required KDE for certain FTL items to track the packing CTE.',
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
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: A Halal or Kosher certification is issued for a specific suppliers production of a specific raw material — this maps precisely to an approved_supplier record (the ASL entry for that raw_material+supp',
    `claim_id` BIGINT COMMENT 'Foreign key linking to marketing.claim. Business justification: Halal and kosher certification records directly substantiate corresponding marketing claims. F&B marketing compliance teams link certification records to claims to manage claim validity windows tied t',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: A lapsed or failed halal/kosher certification triggers a non-conformance if product was produced using non-certified ingredients. Linking religious_cert→non_conformance enables QA to trace which certi',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Halal and Kosher product registrations in markets like the Middle East and Israel require ingredient-level religious certifications as supporting documents. The religious_cert must reference the produ',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material or ingredient that is certified under this religious certification.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the certified ingredient. Religious certifications are supplier-specific as different suppliers of the same ingredient may have different certification statuses.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Halal and Kosher certifications are issued per manufacturing site by certifying bodies who audit specific facilities. A supplier company may have certified and uncertified sites. Religious cert manage',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ADD CONSTRAINT `fk_ingredient_approved_supplier_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ADD CONSTRAINT `fk_ingredient_lot_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ADD CONSTRAINT `fk_ingredient_allergen_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ADD CONSTRAINT `fk_ingredient_formulation_line_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ADD CONSTRAINT `fk_ingredient_nutritional_profile_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_original_test_result_id` FOREIGN KEY (`original_test_result_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`test_result`(`test_result_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ADD CONSTRAINT `fk_ingredient_test_result_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ADD CONSTRAINT `fk_ingredient_cost_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_lot_id` FOREIGN KEY (`lot_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`lot`(`lot_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ADD CONSTRAINT `fk_ingredient_fsma_traceability_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_approved_supplier_id` FOREIGN KEY (`approved_supplier_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`approved_supplier`(`approved_supplier_id`);
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ADD CONSTRAINT `fk_ingredient_religious_cert_raw_material_id` FOREIGN KEY (`raw_material_id`) REFERENCES `food_beverage_ecm`.`ingredient`.`raw_material`(`raw_material_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`ingredient` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`ingredient` SET TAGS ('dbx_domain' = 'ingredient');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`raw_material` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `gfsi_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Gfsi Certification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Assessment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `allergen_declaration_on_file` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration On File');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|revoked|pending');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `coa_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`approved_supplier` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` SET TAGS ('dbx_subdomain' = 'traceability_operations');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Consumed Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`lot` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `allergen_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`allergen` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `formulation_line_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Line Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Header Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Good Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`formulation_line` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `nutritional_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Nutritional Profile Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`nutritional_profile` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` SET TAGS ('dbx_subdomain' = 'traceability_operations');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `original_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Test Result ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`test_result` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`cost` ALTER COLUMN `commodity_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Commodity Index Reference');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` SET TAGS ('dbx_subdomain' = 'traceability_operations');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `fsma_traceability_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Traceability Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `ftl_classification` SET TAGS ('dbx_business_glossary_term' = 'Food Traceability List (FTL) Classification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `ftl_item_code` SET TAGS ('dbx_business_glossary_term' = 'Food Traceability List (FTL) Item Code');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `growing_location` SET TAGS ('dbx_business_glossary_term' = 'Growing Location');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `harvest_date` SET TAGS ('dbx_business_glossary_term' = 'Harvest Date');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`fsma_traceability` ALTER COLUMN `packing_date` SET TAGS ('dbx_business_glossary_term' = 'Packing Date');
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
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` SET TAGS ('dbx_subdomain' = 'material_specification');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `religious_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Religious Cert Identifier');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`ingredient`.`religious_cert` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
