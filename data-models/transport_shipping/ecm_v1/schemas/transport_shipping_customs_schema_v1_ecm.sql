-- Schema for Domain: customs | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`customs` COMMENT 'Manages end-to-end customs brokerage and trade compliance for cross-border shipments. Owns HS Code classification, import/export declarations, ISF and AMS filings, denied party screening, C-TPAT and AEO program compliance, duty and tax calculation, FTZ management, tariff management, and Incoterms-based liability determination. Powered by Descartes Customs GTM and aligned to WCO, WTO, and national customs authority requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`declaration` (
    `declaration_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Customs declarations operate under master service agreements that govern clearance terms, billing rates, SLA commitments, and Incoterms obligations. Brokers and importers track which agreement applies',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Customs declarations must track the carrier transporting goods for transport mode validation, duty assessment basis (CIF/FOB), and regulatory compliance reporting. Carrier details are essential for cu',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every customs declaration is filed by a legal entity (company code) for financial reporting and duty/tax accounting. Essential for posting customs entries to the correct legal entitys books and conso',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Every customs declaration is filed for a specific shipment/consignment. Customs clearance tracking, release status monitoring, and duty reconciliation all require linking declaration to the physical c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Customs declarations require supplier/exporter master data for denied party screening, origin verification, and duty assessment. Brokers link declarations to supplier records for compliance validation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customs declarations must be filed by licensed customs brokers (employees). Critical for regulatory compliance, audit trail, and CBP accountability requirements. Tracks who submitted the declaration.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer in customs declaration is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many declarations can have the sa',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customs declarations trigger billable charges for clearance services, duty/tax handling, and broker fees. Invoice links declaration to customer billing for these services—core revenue recognition even',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Customs declarations must reference the transport lane for duty calculation based on origin/destination routing. Customs authorities track transport corridors for risk profiling and trade compliance. ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Port of entry is a physical network node where customs clearance occurs. Required for customs processing location tracking, facility capacity planning, and clearance time analysis by node. Replaces de',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the importer or declarant holds AEO status, which provides trade facilitation benefits and reduced customs controls in the EU and other jurisdictions.',
    `amendment_reason` STRING COMMENT 'Reason for amending the declaration after initial submission (e.g., corrected HS code, updated value, additional documentation). Null if declaration was not amended.',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document supporting preferential duty treatment or country-of-origin claims. Null if not applicable.',
    `country_of_destination` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the final destination country where the goods will be consumed or used.. Valid values are `^[A-Z]{3}$`',
    `country_of_export` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country from which the goods are being exported.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the goods were manufactured, produced, or substantially transformed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration record was first created in the system.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the importer or declarant is C-TPAT certified, which may expedite customs clearance and reduce inspections.',
    `customs_authority` STRING COMMENT 'Name of the national customs authority or agency to which the declaration was filed (e.g., US CBP, UK HMRC, EU Member State Customs).',
    `customs_office_code` STRING COMMENT 'Official code of the specific customs office or location where the declaration was processed.',
    `customs_procedure_code` STRING COMMENT 'Code indicating the customs procedure or regime applied to the goods (e.g., free circulation, temporary admission, inward processing, customs warehousing).',
    `declarant_identifier` STRING COMMENT 'Official identifier of the declarant assigned by customs authority (e.g., customs broker license number, SCAC code, or national business registration number).',
    `declarant_name` STRING COMMENT 'Legal name of the party (customs broker, freight forwarder, or direct importer/exporter) filing the declaration with customs authorities.',
    `declaration_number` STRING COMMENT 'Official customs declaration number assigned by the national customs authority upon submission. This is the externally-known business identifier used for tracking and reference.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the customs declaration: draft (being prepared), submitted (filed with customs), under_review (customs examination in progress), released (cleared for movement), rejected (not accepted by customs), cancelled (withdrawn), or amended (modified after submission). [ENUM-REF-CANDIDATE: draft|submitted|under_review|released|rejected|cancelled|amended — 7 candidates stripped; promote to reference product]',
    `declaration_type` STRING COMMENT 'Type of customs declaration indicating the nature of the cross-border movement: import (goods entering), export (goods leaving), transit (goods passing through), re-export (previously imported goods leaving), temporary admission (goods entering temporarily), or inward processing (goods for processing then re-export).. Valid values are `import|export|transit|re_export|temporary_admission|inward_processing`',
    `declared_value_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the total declared value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `denied_party_screening_status` STRING COMMENT 'Result of screening all parties (importer, exporter, consignee, shipper) against denied party lists (OFAC, BIS, EU sanctions, etc.): cleared (no matches), flagged (potential match requiring review), pending (screening in progress), or not_screened.. Valid values are `cleared|flagged|pending|not_screened`',
    `duty_tax_currency` STRING COMMENT 'ISO 4217 three-letter currency code for duty and tax amounts (typically the currency of the importing country).. Valid values are `^[A-Z]{3}$`',
    `filing_date` DATE COMMENT 'Date when the customs declaration was officially submitted to the customs authority.',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customs declaration was submitted to the customs authority, including timezone.',
    `ftz_entry_number` STRING COMMENT 'Entry number assigned when goods are admitted into a Free Trade Zone or Foreign Trade Zone. Null if goods are not entering an FTZ.',
    `incoterms` STRING COMMENT 'ICC Incoterms 2020 code defining the division of costs, risks, and responsibilities between buyer and seller in international trade (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether customs authority has flagged this declaration for physical inspection or examination of goods.',
    `inspection_type` STRING COMMENT 'Type of customs inspection conducted or required: none, document review only, x-ray scan, physical examination, full examination, or random sample. Null if inspection_required is false.. Valid values are `none|document_review|x_ray|physical_exam|full_exam|random_sample`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration record was last updated in the system.',
    `payment_method` STRING COMMENT 'Method by which duties and taxes are paid: cash, check, wire transfer, ACH, credit card, customs bond (for bonded warehouse or continuous bond), deferred payment (for approved traders), or duty drawback (refund claim). [ENUM-REF-CANDIDATE: cash|check|wire_transfer|ach|credit_card|customs_bond|deferred_payment|duty_drawback — 8 candidates stripped; promote to reference product]',
    `port_of_exit` STRING COMMENT 'Name or code of the port, airport, or border crossing where goods exit the country of export.',
    `rejection_reason` STRING COMMENT 'Reason provided by customs authority for rejecting the declaration (e.g., incorrect HS code, missing documentation, valuation discrepancy). Null if declaration was not rejected.',
    `release_date` DATE COMMENT 'Date when customs authority released the goods for movement after clearance. Null if not yet released.',
    `release_timestamp` TIMESTAMP COMMENT 'Precise date and time when customs authority released the goods, including timezone. Null if not yet released.',
    `total_declared_value` DECIMAL(18,2) COMMENT 'Total customs value of all goods declared on this declaration, used as the basis for duty and tax calculation.',
    `total_duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty assessed on the declared goods. Null if not yet calculated or if duty-free.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total taxes (VAT, GST, excise, etc.) assessed on the declared goods. Null if not yet calculated or if tax-exempt.',
    `trade_agreement` STRING COMMENT 'Name or code of the preferential trade agreement under which reduced or zero duty rates are claimed (e.g., USMCA, EU-UK TCA, CPTPP). Null if no preference claimed.',
    CONSTRAINT pk_declaration PRIMARY KEY(`declaration_id`)
) COMMENT 'Core master record for import and export customs declarations filed with national customs authorities. Captures declaration type (import/export/transit/re-export), declaration number, associated shipment reference, declarant identity, country of origin, country of destination, port of entry/exit, Incoterms, declaration status (draft/submitted/under_review/released/rejected), filing date, release date, and regulatory authority reference. Sourced from Descartes Customs GTM and aligned to WCO SAD (Single Administrative Document) standards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`declaration_line` (
    `declaration_line_id` BIGINT COMMENT 'Unique identifier for the customs declaration line item. Primary key for the declaration line entity.',
    `commodity_rate_class_id` BIGINT COMMENT 'Foreign key linking to pricing.commodity_rate_class. Business justification: Each declaration line needs commodity rate classification to determine freight class, apply correct pricing multipliers, and calculate chargeable weight. Essential for accurate freight pricing and bil',
    `declaration_id` BIGINT COMMENT 'Reference to the parent customs declaration header. Links this line item to its parent declaration document.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Each declaration line declares goods under a specific HS classification. Linking to hs_classification provides traceability to the classification decision. Not removing hs_code as its a point-in-time',
    `license_permit_id` BIGINT COMMENT 'Foreign key linking to customs.license_permit. Business justification: Declaration lines for controlled goods reference a license/permit. Currently has license_number as denormalized string. Adding FK to license_permit normalizes this and enables tracking of license util',
    `origin_determination_id` BIGINT COMMENT 'Foreign key linking to customs.origin_determination. Business justification: Each declaration line declares a country of origin. Linking to origin_determination provides the supporting determination for the declared origin, especially important for preferential tariff claims. ',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Customs declaration lines map to PO line items for item-level duty tracking and compliance audit. Brokers trace declaration lines to PO lines for valuation verification, HS code validation, and transf',
    `shipment_package_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_package. Business justification: Multi-SKU shipments require line-level mapping between customs declaration lines and physical packages for inspection, examination, and selective release. Enables package-level customs status tracking',
    `tariff_rate_id` BIGINT COMMENT 'Foreign key linking to customs.tariff_rate. Business justification: Each declaration line has an hs_code and duty_rate_percent. Linking to tariff_rate provides the authoritative rate reference. Not removing duty_rate_percent as its a point-in-time transactional value',
    `antidumping_case_number` STRING COMMENT 'Reference number of the antidumping or countervailing duty investigation or order. Null if not subject to trade remedy measures.',
    `antidumping_indicator` BOOLEAN COMMENT 'Indicates whether this line item is subject to antidumping or countervailing duties. True if subject to trade remedy measures, false otherwise.',
    `brand_name` STRING COMMENT 'Commercial brand or trademark name of the goods. Used for intellectual property enforcement and product identification.',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document supporting the country of origin claim and preferential treatment. Required when preference is claimed.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the goods being declared. Includes material composition, intended use, brand, model, and other identifying characteristics required by customs authorities.',
    `container_number` STRING COMMENT 'ISO 6346 container identification number for containerized shipments. Format: four letters followed by seven digits. Null for non-containerized cargo.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `country_of_origin_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code representing the country where the goods were manufactured, produced, or substantially transformed. Used for preferential tariff determination and trade agreement eligibility.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration line record was first created in the system. Supports audit trail and data lineage tracking.',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'Declared customs value of the goods for duty calculation purposes. Represents the transaction value or adjusted value per WCO Valuation Agreement (GATT Article VII).',
    `customs_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the customs value amount. Indicates the currency in which the goods value is declared.. Valid values are `^[A-Z]{3}$`',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Indicates whether this line item contains dangerous goods requiring special handling and documentation per IMDG Code or IATA Dangerous Goods Regulations. True if dangerous goods, false otherwise.',
    `duty_amount` DECIMAL(18,2) COMMENT 'Calculated customs duty amount payable on this line item. Computed as customs value multiplied by duty rate, subject to any preferential treatment or exemptions.',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Applicable customs duty rate expressed as a percentage of the customs value. Determined by HS code classification and country of origin.',
    `excise_tax_amount` DECIMAL(18,2) COMMENT 'Calculated excise tax amount payable on this line item for goods subject to special excise duties (e.g., alcohol, tobacco, fuel). Zero if not applicable.',
    `ftz_entry_number` STRING COMMENT 'Reference number of the FTZ admission or bonded warehouse entry. Null if not admitted to FTZ.',
    `ftz_indicator` BOOLEAN COMMENT 'Indicates whether this line item is admitted into a free trade zone or bonded warehouse with duty suspension. True if FTZ admission, false otherwise.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the goods including all packaging materials, expressed in kilograms. Used for freight calculation and customs valuation.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the commodity. Six to ten digit code used for customs duty determination and trade statistics. Aligned to WCO Harmonized System nomenclature.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'Three-letter Incoterms code defining the delivery terms and liability split between buyer and seller. Used for customs valuation adjustments and freight cost allocation.. Valid values are `^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$`',
    `line_number` STRING COMMENT 'Sequential line number within the customs declaration. Determines the ordering of line items within the parent declaration.',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer or producer of the goods. Required for origin verification and product safety traceability.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer or producer of the goods. Required for certain product categories and origin verification purposes.',
    `model_number` STRING COMMENT 'Manufacturers model number or part number for the goods. Used for product identification and classification verification.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration line record was last modified. Supports audit trail and change tracking for compliance purposes.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the goods excluding all packaging materials, expressed in kilograms. Used for duty calculation and statistical purposes.',
    `package_count` STRING COMMENT 'Number of packages or shipping units containing the goods on this line item. Used for cargo handling and inspection planning.',
    `package_type_code` STRING COMMENT 'Two-letter UN/CEFACT code identifying the type of packaging. Examples: CT=carton, PL=pallet, DR=drum, BX=box. Aligned to UN/CEFACT Recommendation 21.. Valid values are `^[A-Z]{2}$`',
    `preference_indicator` BOOLEAN COMMENT 'Indicates whether preferential tariff treatment is claimed for this line item under a free trade agreement or trade preference program. True if preference is claimed, false otherwise.',
    `preference_program_code` STRING COMMENT 'Code identifying the specific trade agreement or preference program under which preferential treatment is claimed. Examples include USMCA, EU-GSP, CPTPP. Null if no preference is claimed.. Valid values are `^[A-Z0-9]{2,10}$`',
    `prohibited_restricted_indicator` BOOLEAN COMMENT 'Indicates whether this line item contains goods subject to import prohibitions or restrictions (e.g., endangered species, hazardous materials, dual-use goods). True if restricted, false otherwise.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of goods declared on this line item, expressed in the unit of measure specified. Used for duty calculation and statistical reporting.',
    `quota_indicator` BOOLEAN COMMENT 'Indicates whether this line item is subject to a tariff rate quota or quantitative import restriction. True if quota applies, false otherwise.',
    `quota_number` STRING COMMENT 'Reference number of the quota allocation or license under which this line item is imported. Null if no quota applies.',
    `serial_number` STRING COMMENT 'Unique serial number or identification number for serialized goods. Required for high-value items, controlled goods, and warranty tracking.',
    `statistical_value_amount` DECIMAL(18,2) COMMENT 'Value of the goods for trade statistics purposes, typically converted to the importing countrys currency. Used for balance of payments and trade flow analysis.',
    `statistical_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the statistical value amount. Typically the local currency of the importing country.. Valid values are `^[A-Z]{3}$`',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total of all taxes and duties payable on this line item. Sum of duty amount, VAT amount, excise tax amount, and any other applicable charges.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying dangerous goods for transport and customs purposes. Format: UN followed by four digits. Null if not dangerous goods.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure code for the declared quantity. Examples include KGM (kilogram), MTR (meter), PCE (piece), LTR (liter). Aligned to UN/CEFACT Recommendation 20.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_method_code` STRING COMMENT 'Code indicating the WCO valuation method used to determine customs value. Values: 1=Transaction Value, 2=Identical Goods, 3=Similar Goods, 4=Deductive Value, 5=Computed Value, 6=Fall-back Method.. Valid values are `^[1-6]$`',
    `vat_amount` DECIMAL(18,2) COMMENT 'Calculated value-added tax or goods and services tax amount payable on this line item. Computed based on the taxable base (customs value plus duty) and applicable VAT rate.',
    `vat_rate_percent` DECIMAL(18,2) COMMENT 'Applicable value-added tax or goods and services tax rate expressed as a percentage. Applied to the sum of customs value and duty amount.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the goods expressed in cubic meters. Used for freight calculation and warehouse space planning.',
    CONSTRAINT pk_declaration_line PRIMARY KEY(`declaration_line_id`)
) COMMENT 'Line-level detail within a customs declaration representing each distinct commodity or tariff line item. Captures HS code, commodity description, country of origin, quantity, unit of measure, gross weight, net weight, CBM, declared value, currency, duty rate applied, duty amount, VAT/tax amount, statistical value, and preference claim indicator. Each declaration may contain multiple lines corresponding to different goods classifications. Aligned to WCO tariff nomenclature and national customs tariff schedules.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`hs_classification` (
    `hs_classification_id` BIGINT COMMENT 'Unique identifier for the HS Code classification record. Primary key for the HS classification master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: HS classification performed by licensed customs brokers or trade compliance specialists (employees). Required for binding rulings, audit trail, and regulatory compliance. Classifier_name is denormaliz',
    `commodity_rate_class_id` BIGINT COMMENT 'Foreign key linking to pricing.commodity_rate_class. Business justification: HS codes map to freight rate classes for pricing purposes. Logistics operators maintain HS-to-rate-class mappings to automate freight class assignment and ensure consistent pricing across shipments wi',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for whom this HS classification was created. Links the classification to the trading party.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: HS classification teams maintain supplier-specific product classifications for binding rulings and consistent tariff application across shipments. Classification records reference supplier part catalo',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: HS classifications can reference a specific trade agreement for preferential duty treatment. Adding trade_agreement_id FK to trade_agreement.trade_agreement_id establishes which FTA/trade agreement ap',
    `binding_ruling_expiry_date` DATE COMMENT 'The date on which the binding tariff ruling expires and is no longer valid for use. Nullable if the ruling has no expiration or is valid indefinitely.',
    `binding_ruling_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this classification is based on a binding tariff ruling issued by a customs authority. Binding rulings provide legal certainty and protection from reclassification penalties.',
    `binding_ruling_issue_date` DATE COMMENT 'The date on which the binding tariff ruling was officially issued by the customs authority. Determines the start of the ruling validity period.',
    `binding_ruling_issuing_authority` STRING COMMENT 'The name of the customs authority or government agency that issued the binding tariff ruling. Examples include US CBP, HMRC, EU Commission.',
    `binding_ruling_reference` STRING COMMENT 'The official reference number or identifier of the binding tariff ruling issued by the customs authority. Used to cite the ruling in customs declarations and audits.',
    `classification_confidence_score` DECIMAL(18,2) COMMENT 'A numerical score (0-100) representing the confidence level in the assigned HS Code classification. Used for automated classifications to flag low-confidence assignments for manual review.',
    `classification_date` DATE COMMENT 'The date on which the HS Code classification was assigned or approved. Used to determine applicability of tariff rates and trade regulations in effect at that time.',
    `classification_method` STRING COMMENT 'The method by which the HS Code classification was determined. Automated indicates system-driven classification; manual indicates customs broker review; binding ruling indicates official customs authority determination; third party ruling indicates external consultant classification; customer declared indicates shipper-provided classification.. Valid values are `automated|manual|binding_ruling|third_party_ruling|customer_declared`',
    `classification_notes` STRING COMMENT 'Free-text notes and comments from the classifier explaining the rationale for the HS Code assignment, including references to tariff schedule notes, explanatory notes, or ruling precedents.',
    `classification_status` STRING COMMENT 'Current lifecycle status of the HS classification record. Tracks whether the classification is in draft, under review, approved for use, rejected, expired, or superseded by a newer classification.. Valid values are `draft|pending_review|approved|rejected|expired|superseded`',
    `classifier_license_number` STRING COMMENT 'Professional license or certification number of the customs broker who performed the classification. Required for regulatory compliance and audit purposes in jurisdictions that mandate licensed brokers.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the goods being classified. Includes material composition, intended use, manufacturing process, and other characteristics relevant to tariff classification.',
    `country_of_classification` STRING COMMENT 'The 3-letter ISO country code indicating the jurisdiction for which this HS classification applies. HS codes may vary by country at the 8-digit and 10-digit levels.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this HS classification record was first created in the system. Used for audit trail and data lineage purposes.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the classified goods are classified as dangerous goods under IMDG, IATA DGR, or other hazardous materials regulations. Affects handling, packaging, and transport requirements.',
    `destination_country_code` STRING COMMENT 'The 3-letter ISO country code indicating the country to which the goods are being shipped. Destination country determines applicable import duties and regulations.. Valid values are `^[A-Z]{3}$`',
    `duty_rate_percentage` DECIMAL(18,2) COMMENT 'The applicable customs duty rate as a percentage of the goods value, based on the assigned HS Code and destination country. Used for landed cost calculation and duty estimation.',
    `effective_from_date` DATE COMMENT 'The date from which this HS classification becomes valid and can be used for customs declarations. Supports time-bound classification validity periods.',
    `effective_to_date` DATE COMMENT 'The date until which this HS classification remains valid. Nullable for open-ended classifications. Used to manage classification expiration and renewal cycles.',
    `excise_tax_applicable_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether excise taxes apply to the classified goods in addition to customs duties. Common for alcohol, tobacco, fuel, and luxury goods.',
    `export_control_classification_number` STRING COMMENT 'The ECCN assigned to the goods for export control purposes. Used to determine whether an export license is required under dual-use or military export regulations.',
    `hs_code_10_digit` STRING COMMENT 'The 10-digit national tariff code used by specific countries (e.g., USA HTS code). Provides the most granular level of commodity classification for duty and tax calculation.. Valid values are `^[0-9]{10}$`',
    `hs_code_6_digit` STRING COMMENT 'The 6-digit HS Code as defined by the World Customs Organization (WCO). This is the internationally standardized classification code used globally for customs tariff purposes.. Valid values are `^[0-9]{6}$`',
    `hs_code_8_digit` STRING COMMENT 'The 8-digit HS Code used in the European Union Combined Nomenclature (CN). Extends the 6-digit WCO code with two additional digits for EU-specific classification.. Valid values are `^[0-9]{8}$`',
    `import_license_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether an import license or permit is required for the classified goods in the destination country. Used to trigger license application workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this HS classification record was last updated or modified. Used for audit trail and change tracking purposes.',
    `last_review_date` DATE COMMENT 'The date on which this HS classification was last reviewed or validated by a customs broker or trade compliance specialist. Used to track classification currency and trigger re-review cycles.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this HS classification record. Used for accountability and audit trail purposes.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review or re-validation of this HS classification. Nullable if no review is scheduled. Used to manage proactive classification maintenance.',
    `origin_country_code` STRING COMMENT 'The 3-letter ISO country code indicating the country where the goods were manufactured or produced. Country of origin affects duty rates and eligibility for preferential trade agreements.. Valid values are `^[A-Z]{3}$`',
    `preferential_duty_rate_percentage` DECIMAL(18,2) COMMENT 'The reduced duty rate applicable under a Free Trade Agreement (FTA) or preferential trade program. Nullable if no preferential treatment applies.',
    `product_category` STRING COMMENT 'The high-level product category or commodity group to which the classified goods belong. Used for reporting and analytics on classification patterns by product type.',
    `product_sku` STRING COMMENT 'The customer or internal SKU code for the specific product or commodity to which this HS classification applies. Links the classification to inventory and order management systems.',
    `record_version_number` STRING COMMENT 'Sequential version number incremented each time the classification record is modified. Used for optimistic locking and change history tracking.',
    `restricted_goods_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the classified goods are subject to import or export restrictions, embargoes, or sanctions. Triggers compliance screening and approval workflows.',
    `review_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this classification requires periodic review or re-validation. Set to true for complex classifications, borderline cases, or when tariff schedules are updated.',
    `source_system` STRING COMMENT 'The name of the operational system from which this HS classification record originated. Typically Descartes Customs GTM or another trade management system.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this classification record in the source operational system. Used for data lineage, reconciliation, and troubleshooting.',
    `un_number` STRING COMMENT 'The four-digit UN number assigned to dangerous goods for identification in transport. Format is UN followed by four digits (e.g., UN1203 for gasoline).. Valid values are `^UN[0-9]{4}$`',
    `vat_rate_percentage` DECIMAL(18,2) COMMENT 'The applicable VAT or Goods and Services Tax (GST) rate as a percentage, based on the HS Code and destination country. Used for total landed cost calculation.',
    CONSTRAINT pk_hs_classification PRIMARY KEY(`hs_classification_id`)
) COMMENT 'Master record for HS Code (Harmonized System Code) classification assignments made for specific goods traded by customers. Captures the assigned HS code at 6-digit (WCO), 8-digit (EU CN), and 10-digit (national tariff) levels, commodity description, classification ruling reference, classification method (automated/manual/ruling), classifier identity, classification date, validity period, country-specific applicability, and binding ruling indicator. Managed by customs brokers in Descartes Customs GTM. SSOT for tariff classification within the enterprise.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` (
    `tariff_rate_id` BIGINT COMMENT 'Unique identifier for the tariff rate record.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Customs tariff rates reference pricing tariff structures for duty-inclusive freight quotes and landed cost calculations. Enables integrated quoting where freight and duty costs are presented together ',
    `superseded_by_tariff_rate_id` BIGINT COMMENT 'Reference to the tariff_rate_id that replaces this record when status is superseded. Enables rate history tracking.',
    `trade_agreement_id` BIGINT COMMENT 'FK to customs.trade_agreement',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tariff rates require periodic verification by qualified trade compliance analysts (employees). Critical for duty calculation accuracy and regulatory compliance. Verified_by is denormalized employee id',
    `anti_dumping_duty_rate` DECIMAL(18,2) COMMENT 'Additional duty imposed on imports sold below fair market value to protect domestic industry. Expressed as a percentage or specific amount per unit.',
    `countervailing_duty_rate` DECIMAL(18,2) COMMENT 'Additional duty imposed to offset foreign government subsidies that distort trade. Expressed as a percentage or specific amount per unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary duty amounts and specific duty calculations.. Valid values are `^[A-Z]{3}$`',
    `duty_calculation_method` STRING COMMENT 'Method used to calculate the duty: ad valorem (percentage of value), specific (fixed amount per unit), compound (combination), or mixed.. Valid values are `ad_valorem|specific|compound|mixed`',
    `effective_date` DATE COMMENT 'The date from which this tariff rate becomes applicable and enforceable for customs declarations.',
    `excise_duty_rate` DECIMAL(18,2) COMMENT 'Special tax levied on specific goods such as alcohol, tobacco, fuel, or luxury items. Expressed as a percentage or specific amount per unit.',
    `expiry_date` DATE COMMENT 'The date on which this tariff rate ceases to be valid. Null indicates an open-ended rate with no scheduled expiration.',
    `exporting_country_code` STRING COMMENT 'Three-letter ISO country code of the origin country from which goods are being exported.. Valid values are `^[A-Z]{3}$`',
    `gst_rate` DECIMAL(18,2) COMMENT 'The goods and services tax rate applicable in jurisdictions using GST instead of VAT. Expressed as a percentage.',
    `hs_code` STRING COMMENT 'The Harmonized System code classifying the commodity for customs purposes. Six to ten digit code used globally for tariff classification.. Valid values are `^[0-9]{6,10}$`',
    `importing_country_code` STRING COMMENT 'Three-letter ISO country code of the destination country where goods are being imported.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tariff rate record was last updated in the system.',
    `last_verified_date` DATE COMMENT 'Date when this tariff rate was last verified against official customs authority publications to ensure accuracy.',
    `mfn_duty_rate` DECIMAL(18,2) COMMENT 'The standard duty rate applied to imports from WTO member countries in the absence of a preferential trade agreement. Expressed as a percentage or specific rate.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or operational guidance related to the application of this tariff rate.',
    `origin_criteria` STRING COMMENT 'Rules of origin requirements that must be met to qualify for preferential duty rates under the trade agreement (e.g., regional value content, tariff shift, specific process).',
    `preferential_duty_rate` DECIMAL(18,2) COMMENT 'Reduced duty rate available under a specific trade agreement when origin and compliance criteria are met. Expressed as a percentage or specific rate.',
    `publication_reference` STRING COMMENT 'Official document reference, gazette number, or regulation identifier where this tariff rate was published.',
    `quota_order_number` STRING COMMENT 'Official quota order number or TRQ identifier when tariff_quota_flag is true. Used to track quota utilization.',
    `rate_source_authority` STRING COMMENT 'The official government or regulatory body that published this tariff rate (e.g., US Customs and Border Protection, HMRC, European Commission DG TAXUD).',
    `rate_type` STRING COMMENT 'Classification of the tariff rate type for operational and reporting purposes.. Valid values are `standard|preferential|suspended|quota|seasonal|provisional`',
    `seasonal_period` STRING COMMENT 'Description of the seasonal period when this rate applies (e.g., January-March, Summer, Harvest Season). Populated when seasonal_rate_flag is true.',
    `seasonal_rate_flag` BOOLEAN COMMENT 'Indicates whether this tariff rate varies by season or time of year (common for agricultural products).',
    `special_conditions` STRING COMMENT 'Additional conditions, restrictions, or requirements that apply to this tariff rate (e.g., licensing requirements, certification needs, end-use restrictions).',
    `specific_duty_amount` DECIMAL(18,2) COMMENT 'Fixed duty amount per unit of measure when specific or compound duty calculation method applies.',
    `suspension_flag` BOOLEAN COMMENT 'Indicates whether duty collection is temporarily suspended for this HS code and country pair (autonomous suspension).',
    `suspension_reason` STRING COMMENT 'Explanation for duty suspension when suspension_flag is true (e.g., economic interest, shortage of domestic supply, industrial development).',
    `tariff_quota_flag` BOOLEAN COMMENT 'Indicates whether this rate is subject to a tariff rate quota (TRQ) limiting the quantity eligible for preferential rates.',
    `tariff_rate_status` STRING COMMENT 'Current lifecycle status of the tariff rate record in the system.. Valid values are `active|inactive|pending|superseded`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for specific duty calculations (e.g., kilogram, liter, piece, square meter). Applicable when duty_calculation_method is specific or compound.',
    `vat_rate` DECIMAL(18,2) COMMENT 'The value-added tax or goods and services tax rate applicable to the imported goods in the destination country. Expressed as a percentage.',
    `version_number` STRING COMMENT 'Version number of this tariff rate record to track changes over time for the same HS code and country pair combination.',
    CONSTRAINT pk_tariff_rate PRIMARY KEY(`tariff_rate_id`)
) COMMENT 'Reference data for duty and tax rates applicable to specific HS codes by country pair and trade agreement. Captures HS code, importing country, exporting country, applicable trade agreement (e.g., USMCA, EU-UK TCA, RCEP), MFN (Most Favoured Nation) duty rate, preferential duty rate, anti-dumping duty rate, countervailing duty rate, VAT/GST rate, excise rate, effective date, expiry date, and rate source authority. Enables automated duty calculation in declarations. Aligned to WTO tariff schedules and national customs authority publications.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` (
    `duty_assessment_id` BIGINT COMMENT 'Unique identifier for the duty assessment record. Primary key for the duty assessment transaction.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Assessed customs duties become payables to customs authorities. Essential for cash management, payment run processing, aging analysis, and reconciliation of duty payments against assessments.',
    `agent_id` BIGINT COMMENT 'Reference to the licensed customs broker who prepared and filed the customs declaration and calculated the duty assessment.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Duty assessments must reference the governing service agreement to determine duty payment responsibility (importer vs carrier vs 3PL), apply contracted duty management services, validate Incoterms cos',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Duty assessments performed by customs officers or licensed brokers (employees). Regulatory requirement for accountability, audit trail, and dispute resolution. Tracks who calculated and approved the a',
    `billing_invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Each duty assessment (duties, taxes, fees paid on customers behalf) generates specific invoice line items for charge-back. Essential for reconciling customs payments to customer invoices and revenue ',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: EU Carbon Border Adjustment Mechanism (CBAM) requires linking customs duty assessments to carbon offset purchases for embedded emissions in imported goods. Real process: CBAM certificate surrender at ',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this duty assessment. Links to the freight shipment being cleared through customs.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration for which this duty assessment was performed. Links to the parent customs entry filing.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Duty assessments generate GL postings for duty expense and payables. Critical for financial close process, duty accrual reconciliation, and audit trail linking customs transactions to financial record',
    `original_assessment_duty_assessment_id` BIGINT COMMENT 'Reference to the original duty assessment record if this is an adjusted or corrected assessment. Creates audit trail for assessment changes. Null for original assessments.',
    `charge_code_id` BIGINT COMMENT 'Foreign key linking to pricing.charge_code. Business justification: Duty assessments generate billable charges that must map to pricing charge codes for invoicing and revenue recognition. Required for integrating customs duty costs into customer billing and financial ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Duty assessments track supplier/exporter for landed cost calculation by supplier. Procurement teams analyze total cost of ownership including duties, requiring supplier linkage for cost allocation and',
    `tariff_rate_id` BIGINT COMMENT 'Foreign key linking to customs.tariff_rate. Business justification: Duty assessment calculates duties based on a specific tariff rate. Currently has tariff_code and duty_rate_percentage as denormalized values. Linking to tariff_rate provides the authoritative rate sou',
    `trade_party_id` BIGINT COMMENT 'Reference to the party legally responsible for paying the assessed duties and taxes. The importer of record as declared on the customs entry.',
    `adjustment_reason` STRING COMMENT 'Reason for adjusting the duty assessment after initial calculation. May include post-entry amendment, reconciliation, or customs authority correction. Null if no adjustment made.',
    `anti_dumping_duty_amount` DECIMAL(18,2) COMMENT 'Anti-dumping duty assessed when goods are imported at below fair market value. Additional duty imposed to protect domestic industry from unfair trade practices.',
    `assessment_date` DATE COMMENT 'Date when the duty assessment was calculated and issued by the customs authority or broker system. Principal business event timestamp for this transaction.',
    `assessment_method` STRING COMMENT 'Method by which the duty assessment was calculated. Automated = system-calculated; Manual = customs officer review; Hybrid = system with officer override; Post_audit = retrospective assessment after release.. Valid values are `automated|manual|hybrid|post_audit`',
    `assessment_number` STRING COMMENT 'Business identifier for the duty assessment. Externally visible reference number used in customs documentation and payment processing.. Valid values are `^[A-Z0-9]{8,20}$`',
    `assessment_source_system` STRING COMMENT 'Name of the system that generated the duty assessment calculation. Typically the customs broker GTM system or customs authority automated system.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the duty assessment. Estimated = preliminary calculation; Assessed = official customs authority calculation; Final = confirmed and payable; Disputed = under review or appeal; Adjusted = modified after initial assessment; Cancelled = voided assessment.. Valid values are `estimated|assessed|final|disputed|adjusted|cancelled`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the duty assessment calculation was executed. Used for audit trail and calculation sequencing.',
    `calculation_basis` STRING COMMENT 'Incoterms basis used for duty calculation. CIF = Cost Insurance Freight; FOB = Free on Board; DDP = Delivered Duty Paid; DAP = Delivered at Place; EXW = Ex Works; FCA = Free Carrier. Determines which costs are included in the customs value.. Valid values are `CIF|FOB|DDP|DAP|EXW|FCA`',
    `countervailing_duty_amount` DECIMAL(18,2) COMMENT 'Countervailing duty assessed to offset foreign government subsidies. Additional duty imposed when imported goods benefit from subsidies in the country of origin.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166 country code representing the country where the goods were manufactured or substantially transformed. Determines applicable duty rates and trade preferences.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this duty assessment record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this assessment. Indicates the currency in which duties and taxes are denominated.. Valid values are `^[A-Z]{3}$`',
    `customs_duty_amount` DECIMAL(18,2) COMMENT 'Total customs duty assessed on the imported or exported goods. Standard ad valorem or specific duty based on HS Code classification and tariff schedule.',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'Total customs value of the goods used as the basis for duty calculation. Represents the transaction value adjusted per WCO valuation rules.',
    `dispute_filed_date` DATE COMMENT 'Date when a formal dispute or protest was filed with the customs authority regarding this assessment. Null if no dispute filed.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the duty assessment if status is disputed. May include classification disagreement, valuation dispute, or rate application error. Null if not disputed.',
    `entry_type` STRING COMMENT 'Type of customs entry for which duty is assessed. Consumption = immediate release for domestic use; Warehouse = bonded storage; Temporary = temporary import; FTZ = Free Trade Zone; Carnet = temporary admission under ATA Carnet.. Valid values are `consumption|warehouse|temporary|ftz|carnet`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert invoice currency to local currency for duty calculation. Rate published by customs authority or central bank on the assessment date.',
    `exchange_rate_date` DATE COMMENT 'Date for which the exchange rate was published and applied. Typically the date of export, entry filing, or customs authority determination.',
    `excise_tax_amount` DECIMAL(18,2) COMMENT 'Excise tax assessed on specific categories of goods such as alcohol, tobacco, fuel, or luxury items. Product-specific indirect tax.',
    `harbor_maintenance_fee` DECIMAL(18,2) COMMENT 'Fee assessed on cargo loaded or unloaded at US ports. Used to fund harbor maintenance and dredging operations.',
    `import_export_indicator` STRING COMMENT 'Indicates whether this duty assessment is for an import or export transaction. Most assessments are for imports; some jurisdictions assess export duties.. Valid values are `import|export`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this duty assessment record was last updated. Audit trail for record changes.',
    `merchandise_processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by customs authority for processing the import entry. Administrative charge for customs clearance services.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the duty assessment. May include special instructions, calculation explanations, or customs officer remarks.',
    `other_fees_amount` DECIMAL(18,2) COMMENT 'Sum of miscellaneous customs-related fees not captured in standard categories. May include inspection fees, storage fees, or special handling charges.',
    `payment_date` DATE COMMENT 'Date when the duties and taxes were paid to the customs authority. Null if payment status is unpaid.',
    `payment_due_date` DATE COMMENT 'Date by which the assessed duties and taxes must be paid to the customs authority. Failure to pay by this date may result in penalties, interest, or cargo holds.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the duty payment. Links to the payment transaction in the financial system or customs payment portal.',
    `payment_status` STRING COMMENT 'Current payment status of the assessed duties and taxes. Unpaid = not yet paid; Paid = fully settled; Partial = partially paid; Overdue = past due date; Waived = exempted from payment.. Valid values are `unpaid|paid|partial|overdue|waived`',
    `port_of_entry_code` STRING COMMENT 'Code identifying the customs port or border crossing where the goods entered the country and duty was assessed. UN/LOCODE or national port code.. Valid values are `^[A-Z0-9]{5,6}$`',
    `preferential_duty_rate` DECIMAL(18,2) COMMENT 'Reduced duty rate percentage applied under a preferential tariff program or free trade agreement. Lower than the standard Most Favored Nation (MFN) rate.',
    `preferential_tariff_program` STRING COMMENT 'Free trade agreement or preferential tariff program applied to reduce or eliminate duty. Examples: USMCA, EU-UK TCA, CPTPP, GSP. Empty if no preference claimed.',
    `tariff_code` STRING COMMENT 'Harmonized System classification code used to determine applicable duty rates. Six to ten digit code identifying the product category for tariff purposes.. Valid values are `^[0-9]{6,10}$`',
    `total_duty_tax_amount` DECIMAL(18,2) COMMENT 'Total liability including all duties, taxes, and fees assessed on this customs entry. Sum of customs duty, anti-dumping duty, countervailing duty, VAT, excise tax, and all fees.',
    `vat_amount` DECIMAL(18,2) COMMENT 'Value-Added Tax or Goods and Services Tax (GST) assessed on the imported goods. Consumption tax collected at the point of import.',
    CONSTRAINT pk_duty_assessment PRIMARY KEY(`duty_assessment_id`)
) COMMENT 'Transactional record of duty and tax calculations performed for a customs declaration or shipment. Captures total customs duty, anti-dumping duty, countervailing duty, VAT/GST, excise tax, port handling levies, total tax liability, currency, exchange rate applied, calculation basis (CIF/FOB/DDP), assessment date, assessment status (estimated/assessed/final/disputed), and payment due date. Supports duty payment reconciliation and landed cost computation. Generated by Descartes Customs GTM duty calculation engine.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`isf_filing` (
    `isf_filing_id` BIGINT COMMENT 'Unique identifier for the ISF filing record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: ISF filings are performed under master service agreements that define filing responsibilities, timing SLAs, penalty allocation for late/inaccurate filings, and service fees. Linking ISF to agreement e',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: ISF (Importer Security Filing) requires carrier identification for CBP 10+2 compliance. Linking to carrier master data ensures accurate SCAC/IATA code validation, vessel/voyage tracking, and regulator',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: ISF (10+2) filing is mandatory for ocean shipments to US 24 hours before loading. CBP compliance, penalty avoidance, and shipment release all require linking ISF to the consignment. Critical for US im',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ISF filings must be submitted by licensed customs brokers (employees). CBP regulatory requirement for ocean shipments. Tracks individual broker accountability. Customs_broker_name is denormalized empl',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer of record in ISF filing is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many ISF filings can have the sa',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: ISF 10+2 filings require manufacturer/supplier details for CBP compliance. Customs brokers pull supplier master data (name, address, country) from procurement systems for accurate ISF submission and i',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: ISF 10+2 rule requires specifying the port where cargo will be unladed. CBP uses this for vessel arrival coordination and security screening. Critical for ISF compliance validation and arrival plannin',
    `actual_arrival_date` DATE COMMENT 'Actual date when the vessel arrived at the US port of unlading.',
    `amendment_count` STRING COMMENT 'Number of times this ISF filing has been amended after initial submission. ISF data must be updated if changes occur before cargo arrival.',
    `bond_number` STRING COMMENT 'Unique identifier for the customs bond that guarantees payment of duties, taxes, and penalties for this ISF filing.. Valid values are `^[A-Z0-9]{8,15}$`',
    `bond_type` STRING COMMENT 'Type of customs bond covering this ISF filing. Single transaction bond covers one shipment. Continuous bond covers multiple shipments over a year.. Valid values are `single_transaction|continuous`',
    `buyer_address` STRING COMMENT 'Full address of the buyer, including street, city, state/province, postal code, and country.',
    `buyer_name` STRING COMMENT 'Name of the last known entity to whom the goods are sold or agreed to be sold. If the goods are to be imported otherwise than in pursuance of a purchase, the name of the owner. This is one of the 10 required data elements for ISF-10.',
    `cbp_rejection_reason` STRING COMMENT 'Detailed reason provided by CBP for rejecting the ISF filing. May include error codes, missing data elements, or compliance violations.',
    `cbp_response_date` TIMESTAMP COMMENT 'Date and time when CBP responded to the ISF filing with acceptance, rejection, or request for amendment.',
    `cbp_response_status` STRING COMMENT 'Status of CBPs response to the ISF filing. Accepted indicates the filing meets all requirements. Rejected indicates the filing contains errors or missing data. Amendment required indicates CBP requires corrections. Pending review indicates CBP has not yet completed their review.. Valid values are `accepted|rejected|amendment_required|pending_review`',
    `consignee_address` STRING COMMENT 'Full address of the consignee, including street, city, state/province, postal code, and country.',
    `consignee_name` STRING COMMENT 'Name of the party to whom the goods are being shipped. This is one of the 10 required data elements for ISF-10.',
    `consolidator_address` STRING COMMENT 'Full address of the consolidator, including street, city, state/province, postal code, and country.',
    `consolidator_name` STRING COMMENT 'Name of the party who stuffed the container or arranged for the stuffing of the container. This is one of the 10 required data elements for ISF-10.',
    `container_stuffing_location` STRING COMMENT 'Physical location where the container was stuffed (loaded). Must include the name and address of the facility. This is one of the 10 required data elements for ISF-10.',
    `country_of_origin` STRING COMMENT 'Country where the goods were manufactured, produced, or grown, as determined by the applicable rules of origin. Represented as a 3-letter ISO country code. This is one of the 10 required data elements for ISF-10.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ISF filing record was first created in the system.',
    `customs_broker_license_number` STRING COMMENT 'CBP-issued license number of the customs broker who filed the ISF.. Valid values are `^[0-9]{5,10}$`',
    `estimated_arrival_date` DATE COMMENT 'Estimated date when the vessel is expected to arrive at the US port of unlading.',
    `filing_date` TIMESTAMP COMMENT 'Date and time when the ISF was submitted to US Customs and Border Protection (CBP). Must be submitted at least 24 hours before cargo is laden aboard the vessel at the foreign port.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the ISF filing. Draft indicates the filing is being prepared. Submitted indicates the filing has been sent to CBP. Accepted indicates CBP has accepted the filing. Rejected indicates CBP has rejected the filing due to errors or missing data. Amended indicates the filing has been updated after initial submission. Withdrawn indicates the filing has been cancelled.. Valid values are `draft|submitted|accepted|rejected|amended|withdrawn`',
    `filing_type` STRING COMMENT 'Type of ISF filing. ISF-10 is for standard ocean shipments (10 data elements required). ISF-5 is for specific scenarios such as FROB (Foreign Remaining On Board), IE (Immediate Exportation), or TE (Transportation and Exportation) shipments (5 data elements required).. Valid values are `ISF-10|ISF-5`',
    `htsus_code` STRING COMMENT 'The 6-digit or 10-digit Harmonized Tariff Schedule classification code for the commodity. Used to determine duty rates and trade compliance requirements. This is one of the 10 required data elements for ISF-10.. Valid values are `^[0-9]{6,10}$`',
    `isf_transaction_number` STRING COMMENT 'Unique transaction number assigned by US Customs and Border Protection (CBP) upon successful ISF submission. This is the official CBP reference number for the filing.. Valid values are `^[A-Z0-9]{10,20}$`',
    `last_amendment_date` TIMESTAMP COMMENT 'Date and time when the most recent amendment to this ISF filing was submitted to CBP.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ISF filing record was last modified in the system.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed by CBP for ISF violations. Penalties can range from $5,000 to $10,000 per violation depending on severity and whether the violation was timely, accurate, or complete.',
    `penalty_reason` STRING COMMENT 'Detailed explanation of why a penalty was assessed by CBP. May include late filing, inaccurate data, missing data elements, or failure to update.',
    `penalty_risk_flag` BOOLEAN COMMENT 'Indicates whether this ISF filing is at risk of CBP penalties due to late filing, inaccurate data, or non-compliance. True indicates penalty risk exists. False indicates no known penalty risk.',
    `port_of_lading` STRING COMMENT 'Foreign port where the cargo was laden aboard the vessel. Represented as a 5-character UN/LOCODE.. Valid values are `^[A-Z]{5}$`',
    `seller_address` STRING COMMENT 'Full address of the seller, including street, city, state/province, postal code, and country.',
    `seller_name` STRING COMMENT 'Name of the last known entity by whom the goods are sold or agreed to be sold. If the goods are to be imported otherwise than in pursuance of a purchase, the name of the owner. This is one of the 10 required data elements for ISF-10.',
    `ship_to_party_address` STRING COMMENT 'Full address of the ship-to party, including street, city, state/province, postal code, and country.',
    `ship_to_party_name` STRING COMMENT 'Name of the first deliver-to party scheduled to physically receive the goods after the goods have been released from customs custody. This is one of the 10 required data elements for ISF-10.',
    `vessel_name` STRING COMMENT 'Name of the ocean vessel carrying the cargo to the United States. Required for CBP to identify the specific voyage.',
    `voyage_number` STRING COMMENT 'Unique identifier for the specific voyage of the vessel. Assigned by the carrier.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_isf_filing PRIMARY KEY(`isf_filing_id`)
) COMMENT 'Importer Security Filing (ISF) record submitted to US CBP for ocean shipments bound for the United States, as mandated under 19 CFR Part 149. Captures ISF transaction number, filing type (ISF-10 or ISF-5), importer of record, consignee, seller, buyer, ship-to party, manufacturer/supplier, country of origin, HTSUS code, container stuffing location, consolidator, vessel name, voyage number, bill of lading number, filing date, CBP response status, and penalty risk flag. Sourced from Descartes Customs GTM AMS/ISF module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`ams_filing` (
    `ams_filing_id` BIGINT COMMENT 'Unique identifier for the AMS filing record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: AMS filings operate under service agreements that govern filing obligations, timing commitments, cost allocation, and penalty terms. Linking AMS to agreement supports SLA compliance tracking, penalty ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: AMS (Automated Manifest System) filings require carrier identification for CBP advance manifest compliance. Carrier FK enables validation of SCAC/IATA codes, vessel/flight details, and supports regula',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: AMS filing is required for air/ocean cargo to US for security screening. CBP hold resolution, exam coordination, and release authorization depend on linking AMS to consignment. Mandatory for US-bound ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AMS filings submitted by licensed customs brokers (employees). CBP regulatory requirement for manifest data. Critical for tracking individual broker performance and regulatory compliance.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer of record in AMS filing is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many AMS filings can have the sa',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: AMS advance manifest submissions must specify unlading port for CBP security screening. Required for manifest compliance validation and arrival port coordination. Replaces denormalized port_of_unladin',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: AMS cargo manifest filings identify shipper (often supplier) for CBP advance screening. Carriers reference supplier master for accurate shipper details in manifest submissions, enabling denied party s',
    `actual_arrival_date` DATE COMMENT 'The actual date when the conveyance arrived at the US port of unlading. Updated after arrival occurs.',
    `amendment_number` STRING COMMENT 'Sequential number tracking amendments to the original AMS filing. Zero for original filing, incremented for each amendment.',
    `ams_transaction_number` STRING COMMENT 'The unique transaction number assigned by US Customs and Border Protection (CBP) upon successful AMS filing submission. This is the official CBP reference for the manifest filing.',
    `bond_number` STRING COMMENT 'The customs bond number guaranteeing payment of duties and compliance with CBP regulations.',
    `bond_type` STRING COMMENT 'The type of customs bond covering this shipment. Single transaction bond or continuous bond for regular importers.. Valid values are `single|continuous|none`',
    `broker_filer_code` STRING COMMENT 'The CBP-assigned filer code identifying the licensed customs broker who submitted this AMS filing on behalf of the importer.',
    `cbp_hold_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether CBP has placed a hold on this shipment for inspection or further review. True if hold is active.',
    `commodity_description` STRING COMMENT 'A detailed description of the cargo being shipped. Must be sufficiently detailed for CBP to assess admissibility and security risk.',
    `consignee_address` STRING COMMENT 'The full US address of the consignee. Required for AMS filing and delivery.',
    `consignee_name` STRING COMMENT 'The name of the party receiving the goods (the importer or buyer). Required for AMS filing.',
    `container_count` STRING COMMENT 'The number of containers (TEU/FEU) associated with this AMS filing for ocean shipments.',
    `conveyance_name` STRING COMMENT 'The name or identifier of the conveyance (truck, rail car, barge) for rail and truck AMS filings.',
    `country_of_origin` STRING COMMENT 'The three-letter ISO country code identifying where the goods were manufactured or produced. Used for duty assessment and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AMS filing record was first created in the system.',
    `estimated_arrival_date` DATE COMMENT 'The estimated date when the conveyance is expected to arrive at the US port of unlading. Critical for AMS filing timing requirements.',
    `exam_location` STRING COMMENT 'The facility or terminal where the CBP examination will take place or has taken place.',
    `exam_type` STRING COMMENT 'The type of physical examination ordered by CBP. VACIS = Vehicle and Cargo Inspection System (non-intrusive imaging), CET = Container Examination Team (physical inspection), tailgate = partial inspection, intensive = full unload and inspection.. Valid values are `none|vacis|cet|tailgate|intensive`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the AMS filing. Tracks progression from draft through submission, acceptance, or rejection by CBP.. Valid values are `draft|submitted|accepted|rejected|amended|cancelled`',
    `filing_timestamp` TIMESTAMP COMMENT 'The date and time when the AMS filing was submitted to US CBP. This is the official filing timestamp for compliance purposes.',
    `filing_type` STRING COMMENT 'The transport mode for which this AMS filing was submitted. Ocean filings use AMS Ocean, air filings use AMS Air, and rail/truck use ABI (Automated Broker Interface).. Valid values are `ocean|air|rail|truck`',
    `flight_number` STRING COMMENT 'The airline flight number for air shipments. Identifies the specific flight carrying the cargo.',
    `hs_code` STRING COMMENT 'The 6 to 10-digit Harmonized Tariff Schedule code classifying the commodity for customs and duty purposes.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'The Incoterm governing the transfer of risk and responsibility between shipper and consignee. Determines liability and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `isf_number` STRING COMMENT 'The ISF (10+2) filing number associated with this ocean shipment. ISF must be filed 24 hours before vessel loading.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AMS filing record was last modified or updated.',
    `notify_party_name` STRING COMMENT 'The name of the party to be notified upon arrival of the cargo. Often the consignee or their customs broker.',
    `piece_count` STRING COMMENT 'The total number of pieces or packages in the shipment covered by this AMS filing.',
    `port_of_lading_code` STRING COMMENT 'The five-character UN/LOCODE identifying the foreign port where the cargo was loaded onto the conveyance.. Valid values are `^[A-Z]{5}$`',
    `rejection_reason` STRING COMMENT 'The reason code or message provided by CBP when an AMS filing is rejected. Used to correct and resubmit.',
    `release_date` DATE COMMENT 'The date when CBP released the cargo for delivery after completing all inspections and clearance procedures.',
    `vessel_imo_number` STRING COMMENT 'The seven-digit IMO ship identification number, a unique permanent identifier for the vessel.. Valid values are `^IMO[0-9]{7}$`',
    `vessel_name` STRING COMMENT 'The name of the ocean vessel carrying the cargo. Required for ocean AMS filings.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the cargo in cubic meters. Used for capacity planning and dimensional weight calculations.',
    `voyage_number` STRING COMMENT 'The carrier-assigned voyage or trip number for ocean shipments. Identifies the specific sailing.',
    `weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the cargo in kilograms. Required for AMS filing.',
    CONSTRAINT pk_ams_filing PRIMARY KEY(`ams_filing_id`)
) COMMENT 'Automated Manifest System (AMS) filing record submitted to US CBP for advance cargo reporting on ocean (AMS), air (AMS Air), and rail/truck (ABI) shipments. Captures AMS transaction number, transport mode, carrier SCAC/IATA code, vessel/flight/conveyance identifier, voyage/flight number, port of lading, port of unlading, estimated arrival date, master bill of lading number, house bill of lading number, commodity description, piece count, weight, filing status, CBP hold indicator, and exam type (VACIS/CET/tailgate). Sourced from Descartes Customs GTM AMS module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` (
    `denied_party_screening_id` BIGINT COMMENT 'Unique identifier for the denied party screening record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment being screened for denied party compliance.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Denied party screening is performed as part of customs declaration processing. The declaration has denied_party_screening_status indicating this relationship. Adding a FK from screening to declaration',
    `employee_id` BIGINT COMMENT 'User identifier of the compliance analyst who reviewed the screening result.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: The denied_party_screening table has denormalized party attributes (name, address, city, state, postal_code, country_code, tax_number) that correspond to trade_party master data. Linking to trade_part',
    `analyst_review_outcome` STRING COMMENT 'Outcome of the compliance analyst review for potential or confirmed matches (approved, rejected, escalated, pending review).. Valid values are `approved|rejected|escalated|pending_review`',
    `analyst_review_required_flag` BOOLEAN COMMENT 'Indicates whether manual analyst review is required for this screening result (true for potential matches, false for clear results).',
    `analyst_review_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance analyst completed their review of the screening result.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this screening record to the complete audit trail for regulatory reporting and compliance verification.',
    `compliance_program` STRING COMMENT 'Trade compliance program under which this screening was performed (C-TPAT, AEO, Partners in Protection, Customs Self Assessment, Secure Exports Scheme).. Valid values are `C-TPAT|AEO|PIP|CSA|SES`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this screening record was first created in the system.',
    `escalation_level` STRING COMMENT 'Level of escalation for high-risk matches requiring senior management or legal review (none, tier 1, tier 2, tier 3, executive).. Valid values are `none|tier1|tier2|tier3|executive`',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether the match was determined to be a false positive after analyst review.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory hold was released and the shipment was cleared for processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this screening record was last updated.',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0.00 to 100.00) indicating the strength of the match between the screened party and denied party list entries.',
    `match_status` STRING COMMENT 'Result of the screening check indicating whether the party matched any denied party list (clear, potential match, confirmed match, false positive).. Valid values are `clear|potential_match|confirmed_match|false_positive`',
    `matched_entity_code` STRING COMMENT 'Unique identifier of the matched entity on the denied party list (e.g., OFAC SDN number).',
    `matched_entity_name` STRING COMMENT 'Name of the denied party entity from the sanctions list that matched the screened party.',
    `matched_entity_program` STRING COMMENT 'Sanctions program or regulatory program associated with the matched denied party (e.g., Iran Sanctions, Counter-Terrorism, Narcotics Trafficking).',
    `matched_list_name` STRING COMMENT 'Name of the specific denied party list where a match was found (e.g., OFAC SDN, BIS Entity List).',
    `override_justification` STRING COMMENT 'Detailed justification provided by the compliance analyst for overriding a potential or confirmed match and approving the shipment.',
    `party_type` STRING COMMENT 'Type of shipment party being screened (shipper, consignee, notify party, manufacturer, broker, carrier, freight forwarder). [ENUM-REF-CANDIDATE: shipper|consignee|notify_party|manufacturer|broker|carrier|freight_forwarder — 7 candidates stripped; promote to reference product]',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether the shipment is placed on regulatory hold due to denied party screening results, preventing further processing until cleared.',
    `risk_score` DECIMAL(18,2) COMMENT 'Overall risk score (0.00 to 100.00) assigned to this screening result based on match quality, party type, and destination country risk.',
    `screening_engine_version` STRING COMMENT 'Version number of the denied party screening engine used to perform this check.',
    `screening_list_sources` STRING COMMENT 'Comma-separated list of denied party and restricted entity lists checked during this screening (OFAC SDN, BIS Entity List, EU Consolidated List, UN Sanctions, C-TPAT denied parties, HMT Sanctions, DFAT Sanctions, etc.).',
    `screening_notes` STRING COMMENT 'Additional notes or comments recorded during the screening process or analyst review.',
    `screening_reference_number` STRING COMMENT 'Externally-known unique reference number for this screening transaction, used for audit trail and compliance reporting.. Valid values are `^DPS-[0-9]{10}$`',
    `screening_rule_set_version` STRING COMMENT 'Version number of the screening rule set and list data used during this check.',
    `screening_run_timestamp` TIMESTAMP COMMENT 'Date and time when the denied party screening check was executed. Principal business event timestamp for this transaction.',
    `screening_status` STRING COMMENT 'Current lifecycle status of the screening check workflow.. Valid values are `pending|in_progress|completed|failed|cancelled`',
    CONSTRAINT pk_denied_party_screening PRIMARY KEY(`denied_party_screening_id`)
) COMMENT 'Transactional record of denied party and restricted entity screening checks performed against shipment parties (shipper, consignee, notify party, manufacturer, broker). Captures screening run date and time, screened party name and address, screening list sources checked (OFAC SDN, BIS Entity List, EU Consolidated List, UN Sanctions, C-TPAT denied parties), match status (clear/potential_match/confirmed_match), match score, analyst review outcome, override justification, and regulatory hold flag. Powered by Descartes Customs GTM denied party screening module. Critical for trade compliance and AEO/C-TPAT program adherence.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`trade_party` (
    `trade_party_id` BIGINT COMMENT 'Unique identifier for the trade party record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: KYC verification performed by compliance officers (employees). AML/CTF regulatory requirement. Tracks who verified the trade party for denied party screening and risk assessment.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Trade parties (importers/exporters) are often suppliers in procurement systems. Links enable supplier master synchronization, AEO/C-TPAT certification tracking, and unified denied party screening acro',
    `address_line_1` STRING COMMENT 'The primary street address line for the trade partys registered business location.',
    `address_line_2` STRING COMMENT 'The secondary address line for additional location details such as suite, floor, or building number.',
    `aeo_certificate_number` STRING COMMENT 'The certificate number issued to parties granted AEO status, indicating they meet supply chain security and compliance standards and are eligible for customs facilitation benefits.',
    `aeo_status` STRING COMMENT 'Current status of the partys AEO certification, indicating their standing in the trusted trader program.. Valid values are `certified|pending|suspended|revoked|not_applicable`',
    `business_registration_number` STRING COMMENT 'The official registration number assigned by the national business registry or companies house in the country of establishment.',
    `cbp_importer_number` STRING COMMENT 'The unique identifier assigned by US Customs and Border Protection to importers of record conducting business in the United States. Required for ISF and AMS filings.',
    `city` STRING COMMENT 'The city or municipality of the trade partys registered business address.',
    `country_code` STRING COMMENT 'The country of the trade partys registered business address, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `country_of_establishment` STRING COMMENT 'The country where the trade party is legally registered and established, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade party record was first created in the system.',
    `credit_rating` STRING COMMENT 'The credit rating or score assigned to the trade party based on financial assessment, used for determining payment terms and credit limits.',
    `ctpat_status` STRING COMMENT 'Current status of the partys participation in the US C-TPAT voluntary supply chain security program, including tier level if certified. [ENUM-REF-CANDIDATE: certified|tier_1|tier_2|tier_3|pending|suspended|removed|not_applicable — 8 candidates stripped; promote to reference product]',
    `ctpat_svi_number` STRING COMMENT 'The unique identifier assigned to C-TPAT certified members following successful supply chain security validation.',
    `customs_broker_license_number` STRING COMMENT 'The license number issued by the customs authority authorizing the party to act as a customs broker. Only applicable when party_type is customs_broker.',
    `denied_party_screening_status` STRING COMMENT 'Result of the most recent denied party screening check against government restricted party lists (OFAC, BIS, EU sanctions, etc.). Flagged or blocked parties require compliance officer review.. Valid values are `cleared|flagged|under_review|blocked`',
    `duns_number` STRING COMMENT 'The nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for credit assessment and supplier verification.. Valid values are `^[0-9]{9}$`',
    `eori_number` STRING COMMENT 'The unique identification number assigned to economic operators and other persons for customs purposes in the European Union. Required for all customs declarations in EU member states.. Valid values are `^[A-Z]{2}[A-Z0-9]{1,15}$`',
    `ftz_operator_number` STRING COMMENT 'The authorization number for parties approved to operate or use Free Trade Zone facilities for customs-privileged storage and processing.',
    `incoterms_preference` STRING COMMENT 'The preferred Incoterms rule this party typically uses for international trade transactions, determining the division of costs and risks between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `kyc_verification_date` DATE COMMENT 'The date when the most recent KYC verification was completed for this trade party.',
    `kyc_verification_status` STRING COMMENT 'Status of the Know Your Customer due diligence verification process for this trade party, ensuring compliance with anti-money laundering and trade compliance requirements.. Valid values are `verified|pending|failed|expired|not_required`',
    `last_screening_date` DATE COMMENT 'The date when the trade party was last screened against denied party and sanctions lists.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent customs declaration or trade transaction involving this party.',
    `legal_name` STRING COMMENT 'The official registered legal name of the trade party as it appears on government registration documents and customs declarations.',
    `lei_code` STRING COMMENT 'The 20-character ISO 17442 standard identifier for legal entities participating in financial transactions. Used for regulatory reporting and entity verification.. Valid values are `^[A-Z0-9]{20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade party record was last updated or modified.',
    `next_screening_due_date` DATE COMMENT 'The date by which the next periodic denied party screening must be completed to maintain compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or compliance observations related to this trade party.',
    `onboarding_date` DATE COMMENT 'The date when the trade party was first registered and approved for use in customs and trade transactions.',
    `party_status` STRING COMMENT 'Current operational status of the trade party in the customs management system. Blocked parties cannot be used in new shipments pending compliance review.. Valid values are `active|suspended|blocked|inactive|pending_verification`',
    `party_type` STRING COMMENT 'Classification of the partys role in international trade transactions. Determines the partys responsibilities and compliance obligations under customs regulations. [ENUM-REF-CANDIDATE: importer_of_record|exporter|manufacturer|supplier|consignee|notify_party|customs_broker|freight_forwarder|carrier|warehouse_operator — 10 candidates stripped; promote to reference product]',
    `payment_terms_days` STRING COMMENT 'The standard number of days allowed for payment of customs duties, taxes, and brokerage fees for this trade party.',
    `postal_code` STRING COMMENT 'The postal or ZIP code of the trade partys registered business address.',
    `preferred_currency` STRING COMMENT 'The preferred currency for invoicing and payment transactions with this trade party, represented as ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `preferred_language` STRING COMMENT 'The preferred language for customs documentation and communications with this trade party, represented as ISO 639-1 two-letter language code.. Valid values are `^[a-z]{2}$`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary contact person for customs and trade compliance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary contact person for customs and trade compliance matters at the trade party organization.',
    `primary_contact_phone` STRING COMMENT 'The telephone number of the primary contact person for customs and trade compliance matters.',
    `risk_classification` STRING COMMENT 'The risk level assigned to this trade party based on compliance history, denied party screening results, geographic risk factors, and transaction patterns.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'The state, province, or administrative region of the trade partys registered business address.',
    `tax_identification_number` STRING COMMENT 'The national tax identification number assigned by the tax authority of the partys country of establishment. Used for customs duty and tax assessment.',
    `trading_name` STRING COMMENT 'The commercial or trading name under which the party conducts business, if different from the legal name. Also known as DBA (Doing Business As).',
    `vat_registration_number` STRING COMMENT 'The VAT registration number assigned by the tax authority, required for VAT-registered businesses conducting trade within VAT jurisdictions.',
    CONSTRAINT pk_trade_party PRIMARY KEY(`trade_party_id`)
) COMMENT 'Master record for all parties involved in international trade transactions managed by the customs domain — importers of record, exporters, manufacturers, suppliers, consignees, notify parties, and customs brokers. Captures party type, legal name, trading name, tax identification number, EORI number (EU), CBP importer number (US), AEO certificate number, C-TPAT status, country of establishment, address, contact details, party status (active/suspended/blocked), and denied party screening clearance status. Distinct from the customer domains account entity — trade_party covers all supply chain counterparties, not just Transport Shippings direct customers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Unique identifier for the customs broker assignment record. Primary key for this entity.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Broker assignments incur accessorial charges (customs clearance fees, documentation fees, POA processing). Direct cost-to-charge mapping required for billing customers and tracking brokerage service p',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Broker assignments made by operations managers (employees). Critical for workload management, SLA tracking, and performance monitoring. Tracks who assigned the broker to the shipment.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Customs brokers are licensed to operate at specific ports/nodes. Required for broker jurisdiction enforcement, service coverage planning, and assignment validation. Replaces denormalized assigned_port',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Customs broker assignments must link to the agent entity for operational coordination, performance tracking (filing accuracy, release times), and network management. Role prefix distinguishes from bro',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Customs broker is a trade party entity. Adding broker_trade_party_id FK to trade_party.trade_party_id normalizes the broker reference. Cardinality: N:1 (many assignments can use the same broker). Remo',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: When carrier agreements include customs brokerage services, broker assignments must reference the carrier agreement to validate service scope, apply contracted brokerage rates, track SLA compliance, a',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment for which the customs broker is assigned. Links this assignment to the specific shipment requiring customs clearance.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration document that this broker is handling. Links to the specific import or export declaration filing.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Broker assignments trigger invoicing for brokerage services, filing fees, and clearance charges. Links assignment to invoice for billing broker services—core revenue stream in customs brokerage busine',
    `spot_quote_id` BIGINT COMMENT 'Foreign key linking to pricing.spot_quote. Business justification: Spot quotes include customs brokerage fees as line items. Broker assignments must reference the originating quote to ensure quoted brokerage fees match actual service delivery and for quote-to-invoice',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this broker assignment is currently active. True for active assignments, false for completed or cancelled assignments. Used for filtering current workload.',
    `actual_filing_date` DATE COMMENT 'Actual date when the customs declaration was filed with the customs authority. Used for SLA compliance measurement and audit trails.',
    `actual_release_date` DATE COMMENT 'Actual date when the shipment was released by customs authority. Critical milestone for supply chain visibility and performance measurement.',
    `aeo_certified_flag` BOOLEAN COMMENT 'Indicates whether the broker holds AEO certification, which provides expedited customs processing and reduced inspection rates. True if certified, false otherwise.',
    `assigned_country_code` STRING COMMENT 'Three-letter ISO country code for the country where customs clearance is being performed. Determines applicable customs regulations and procedures.. Valid values are `^[A-Z]{3}$`',
    `assignment_date` DATE COMMENT 'Date when the customs broker was assigned to handle this shipment or declaration. Marks the start of broker responsibility.',
    `assignment_notes` STRING COMMENT 'Free-text field for capturing special instructions, exceptions, or contextual information relevant to this broker assignment. Used for operational communication.',
    `assignment_priority` STRING COMMENT 'Priority level for this broker assignment. Influences processing sequence and resource allocation for time-sensitive shipments.. Valid values are `standard|expedited|urgent|critical`',
    `assignment_status` STRING COMMENT 'Current status of the broker assignment in the customs clearance workflow. Tracks progression from assignment through final release or cancellation.. Valid values are `assigned|in_progress|filed|released|cancelled|on_hold`',
    `assignment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the broker assignment was created in the system. Used for audit trails and SLA tracking.',
    `assignment_type` STRING COMMENT 'Type of customs procedure the broker is handling. Determines applicable regulations, documentation requirements, and processing workflows.. Valid values are `import|export|transit|temporary_admission|re_export`',
    `average_release_time_hours` DECIMAL(18,2) COMMENT 'Average time in hours from declaration filing to customs release for shipments handled by this broker. Performance metric for broker efficiency.',
    `broker_contact_email` STRING COMMENT 'Primary email address for communicating with the assigned customs broker. Used for document exchange and status updates.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `broker_contact_phone` STRING COMMENT 'Primary phone number for reaching the assigned customs broker. Critical for urgent communications and issue resolution.',
    `broker_fee_amount` DECIMAL(18,2) COMMENT 'Total fee charged by the customs broker for handling this declaration. Excludes government duties and taxes.',
    `broker_fee_currency` STRING COMMENT 'Three-letter ISO currency code for the broker fee amount. Supports multi-currency brokerage operations.. Valid values are `^[A-Z]{3}$`',
    `brokerage_office_code` STRING COMMENT 'Internal code identifying the specific brokerage office or branch handling this assignment. Supports multi-location brokerage operations and workload distribution.. Valid values are `^[A-Z0-9]{3,10}$`',
    `brokerage_office_location` STRING COMMENT 'City and country location of the brokerage office handling this assignment. Enables geographic analysis of broker utilization.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was first created. Used for audit trails and data lineage.',
    `ctpat_certified_flag` BOOLEAN COMMENT 'Indicates whether the broker is C-TPAT certified for enhanced supply chain security. True if certified, false otherwise. Applicable for US customs operations.',
    `customs_office_code` STRING COMMENT 'Official code of the customs authority office where the declaration will be filed. Used for routing submissions to the correct government office.. Valid values are `^[A-Z0-9]{4,10}$`',
    `estimated_filing_date` DATE COMMENT 'Projected date when the customs declaration will be filed by the broker. Used for planning and customer communication.',
    `estimated_release_date` DATE COMMENT 'Projected date when customs clearance and release will be completed. Used for downstream logistics planning and customer expectations.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this assignment encountered exceptions requiring special handling (e.g., inspection, document discrepancies, regulatory holds). True if exceptions exist, false otherwise.',
    `exception_reason` STRING COMMENT 'Description of the exception or issue encountered during customs processing. Populated only when exception_flag is true. Used for root cause analysis.',
    `filing_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of declarations filed by this broker that were accepted without errors or rejections. Key performance indicator for broker quality. Expressed as percentage (0.00 to 100.00).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was last updated. Supports change tracking and audit compliance.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this assignment record. Used for accountability and audit trails.',
    `payment_terms` STRING COMMENT 'Terms governing how and when the broker fee will be paid. Determines billing and collection workflows.. Valid values are `prepaid|collect|third_party|credit_account`',
    `poa_effective_date` DATE COMMENT 'Date when the power of attorney authorization becomes effective. Used to validate broker authority at time of filing.',
    `poa_expiry_date` DATE COMMENT 'Date when the power of attorney authorization expires. Nullable for indefinite authorizations. Critical for compliance validation.',
    `power_of_attorney_reference` STRING COMMENT 'Reference number of the legal power of attorney document authorizing the broker to act on behalf of the importer or exporter. Required for regulatory compliance.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `previous_broker_license_number` STRING COMMENT 'License number of the previous broker if this assignment was reassigned. Nullable for initial assignments. Supports audit trails and handoff tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `reassignment_count` STRING COMMENT 'Number of times this declaration has been reassigned to a different broker. High values may indicate complexity or resource constraints.',
    `service_level_agreement` STRING COMMENT 'Contractual service level tier governing response times, filing deadlines, and support availability for this broker assignment.. Valid values are `standard|premium|enterprise|custom`',
    `source_system` STRING COMMENT 'Name of the operational system that originated this assignment record (e.g., Descartes Customs GTM). Supports data lineage and integration troubleshooting.',
    `specialization_codes` STRING COMMENT 'Comma-separated list of commodity or procedure specialization codes indicating the brokers areas of expertise (e.g., dangerous goods, pharmaceuticals, automotive). Used for intelligent broker assignment.',
    `total_declarations_handled` STRING COMMENT 'Cumulative count of customs declarations this broker has processed. Used for workload balancing and performance trending.',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Association record linking a shipment or declaration to the customs broker or brokerage office responsible for handling the filing. Captures broker license number, broker name, brokerage office, assigned country/port, power of attorney reference, assignment date, assignment status, and broker performance indicators (filing accuracy rate, average release time). Enables tracking of which broker handled each declaration and supports broker performance management. Managed within Descartes Customs GTM.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`compliance_program` (
    `compliance_program_id` BIGINT COMMENT 'Unique identifier for the trade compliance program membership or certification record.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Compliance program memberships (C-TPAT, AEO, etc.) are held by trade parties. The compliance_program product appears to be an association entity tracking trade party participation in compliance progra',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AEO/C-TPAT programs require designated program managers (employees). Regulatory requirement for certification maintenance. Tracks accountability for compliance obligations. Contact_person_name is deno',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: AEO (Authorized Economic Operator) and C-TPAT programs increasingly include sustainability commitments (e.g., green lane access) aligned with corporate carbon reduction targets. Real process: Integrat',
    `annual_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the program requires submission of annual compliance reports, self-assessments, or status updates.',
    `application_date` DATE COMMENT 'Date when Transport Shipping or its client submitted the initial application for program membership.',
    `approval_date` DATE COMMENT 'Date when the certifying authority approved the membership or certification application.',
    `audit_frequency_months` STRING COMMENT 'Required interval in months between compliance audits or validation visits as mandated by the program.',
    `authority_contact_email` STRING COMMENT 'Email address of the assigned contact person at the certifying authority.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `authority_contact_name` STRING COMMENT 'Name of the assigned contact person or account manager at the certifying authority.',
    `authority_contact_phone` STRING COMMENT 'Phone number of the assigned contact person at the certifying authority.',
    `authority_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the certifying authoritys jurisdiction (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `certificate_number` STRING COMMENT 'Unique certificate, authorization, or membership identification number issued by the certifying authority.',
    `certifying_authority` STRING COMMENT 'Name of the government agency, customs authority, or international body that issues and governs the program (e.g., US Customs and Border Protection, European Commission, ISO).',
    `compliance_obligations_description` STRING COMMENT 'Detailed narrative description of all compliance requirements, obligations, and commitments that must be maintained to retain program membership.',
    `contact_person_email` STRING COMMENT 'Email address of the primary internal contact person responsible for this program.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary internal contact person responsible for this program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance program record was first created in the system.',
    `dedicated_account_manager_flag` BOOLEAN COMMENT 'Indicates whether the program provides access to a dedicated customs account manager or liaison officer.',
    `effective_date` DATE COMMENT 'Date from which the program membership benefits and obligations become active.',
    `expedited_release_flag` BOOLEAN COMMENT 'Indicates whether the program membership provides access to expedited customs clearance or release procedures.',
    `expiry_date` DATE COMMENT 'Date when the current certification or membership period expires and renewal is required. Null for programs with indefinite validity.',
    `geographic_scope` STRING COMMENT 'Geographic coverage or jurisdictional scope of the program membership (e.g., United States, European Union, Global, specific trade lanes).',
    `issue_date` DATE COMMENT 'Date when the certificate or membership authorization was officially issued.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit, validation visit, or review conducted by the certifying authority.',
    `last_self_assessment_date` DATE COMMENT 'Date when the most recent internal compliance self-assessment or security profile review was completed.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the compliance program membership or certification. [ENUM-REF-CANDIDATE: active|pending|suspended|revoked|expired|withdrawn|under_review — 7 candidates stripped; promote to reference product]',
    `membership_tier` STRING COMMENT 'Level or tier of membership within the program (e.g., Tier 1, Tier 2, Tier 3 for C-TPAT; Full AEO, AEO-C, AEO-S for EU AEO). Empty if program has no tier structure.',
    `mutual_recognition_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this program membership is recognized through mutual recognition agreements (MRAs).',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit, validation visit, or periodic review.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or special instructions related to this compliance program membership.',
    `participant_type` STRING COMMENT 'Role or capacity in which Transport Shipping or its client participates in the compliance program. [ENUM-REF-CANDIDATE: importer|exporter|carrier|broker|warehouse|manufacturer|consolidator|forwarder — 8 candidates stripped; promote to reference product]',
    `priority_processing_flag` BOOLEAN COMMENT 'Indicates whether shipments under this program receive priority processing during customs clearance.',
    `program_benefits_description` STRING COMMENT 'Detailed narrative description of all benefits, privileges, and advantages conferred by this program membership.',
    `program_name` STRING COMMENT 'Official name of the trade compliance or trusted trader program (e.g., C-TPAT, AEO, ISO 28000, FAST, PIP).',
    `program_type` STRING COMMENT 'Classification of the compliance program by its primary focus area (trusted trader, security, quality, environmental, customs partnership).. Valid values are `trusted_trader|security_certification|quality_management|environmental_compliance|customs_partnership|other`',
    `program_website_url` STRING COMMENT 'Official website URL of the compliance program for reference and documentation access.',
    `reduced_examination_rate_flag` BOOLEAN COMMENT 'Indicates whether the program membership grants eligibility for reduced physical or documentary examination rates at customs.',
    `renewal_due_date` DATE COMMENT 'Date by which renewal application or recertification must be submitted to maintain continuous membership.',
    `renewal_status` STRING COMMENT 'Current status of the membership renewal or recertification process.. Valid values are `not_due|renewal_pending|renewal_submitted|renewal_approved|renewal_denied|lapsed`',
    `revocation_reason` STRING COMMENT 'Explanation of the reason for revocation if membership was revoked. Null if not revoked.',
    `security_criteria_met_flag` BOOLEAN COMMENT 'Indicates whether all mandatory security criteria and minimum security requirements of the program are currently met.',
    `suspension_reason` STRING COMMENT 'Explanation of the reason for suspension if membership status is suspended. Null if not suspended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance program record was last modified in the system.',
    CONSTRAINT pk_compliance_program PRIMARY KEY(`compliance_program_id`)
) COMMENT 'Master record for trade compliance program memberships and certifications held by Transport Shipping or its clients, including C-TPAT (Customs-Trade Partnership Against Terrorism), AEO (Authorized Economic Operator), ISO 28000, and national trusted trader programs. Captures program name, certifying authority, membership tier, certificate number, issue date, expiry date, renewal status, program benefits (reduced examination rates, expedited release), and compliance obligations. SSOT for trusted trader program status across the enterprise.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key for the compliance audit entity.',
    `agent_id` BIGINT COMMENT 'Identifier of the customs broker or brokerage firm whose activities were audited. Links to the customs broker master data for broker-specific compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance audits performed by qualified internal or external auditors (employees). Regulatory and internal control requirement. Tracks auditor qualifications and independence. Auditor_name is denorma',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to customs.compliance_program. Business justification: Compliance audits are conducted against specific compliance programs (C-TPAT, AEO, etc.). The audit has program_certification_impacted and compliance_program_code strings but no proper FK. Adding FK e',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Customs compliance audit results feed into ESG disclosure reports as evidence of governance, regulatory adherence, and supply chain transparency. Real process: Annual CSRD/GRI reporting aggregates cus',
    `finance_audit_finding_id` BIGINT COMMENT 'Foreign key linking to finance.audit_finding. Business justification: Customs compliance audits may identify financial control deficiencies (e.g., duty calculation errors, SOX controls). Essential for integrated audit management, remediation tracking, and regulatory rep',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Compliance audits (pre-clearance reviews, classification audits, AEO assessments) are billable consulting services. Links audit to invoice for professional services billing—standard practice for trade',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the compliance audit, including auditor fees, travel expenses, and internal resource costs. Expressed in the companys reporting currency.',
    `audit_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount, such as USD, EUR, or GBP.. Valid values are `^[A-Z]{3}$`',
    `audit_date` DATE COMMENT 'The principal date when the compliance audit was conducted or fieldwork commenced. Represents the business event timestamp for the audit activity.',
    `audit_end_date` DATE COMMENT 'The date when the audit fieldwork or assessment activities were completed. Used for tracking audit duration and closure timelines.',
    `audit_methodology` STRING COMMENT 'Description of the audit methodology or framework applied, such as risk-based sampling, full population review, process walkthrough, or specific regulatory audit protocol. Defines the approach used to conduct the assessment.',
    `audit_number` STRING COMMENT 'Externally-known unique reference number assigned to the compliance audit for tracking and reporting purposes. Used in communications with customs authorities and internal stakeholders.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `audit_period_end_date` DATE COMMENT 'The ending date of the time period being audited. Defines the end of the lookback window for transactions, declarations, and compliance activities under review.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the time period being audited. Defines the start of the lookback window for transactions, declarations, and compliance activities under review.',
    `audit_report_document_reference` STRING COMMENT 'Reference identifier or file path to the formal audit report document containing detailed findings, evidence, and recommendations. Links to document management system or repository.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including specific customs processes, declarations, shipment lanes, time periods, or compliance programs being audited. Defines the boundaries and focus areas of the audit engagement.',
    `audit_start_date` DATE COMMENT 'The date when the audit fieldwork or assessment activities officially began. Used for tracking audit duration and scheduling.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the compliance audit. Planned indicates scheduled but not started, in_progress indicates active fieldwork, completed indicates findings issued but corrective actions pending, closed indicates all corrective actions completed and audit finalized.. Valid values are `planned|in_progress|completed|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit based on the conducting party and scope. Internal audits are self-assessments, external audits are conducted by third parties or regulatory bodies such as CBP (Customs and Border Protection), AEO (Authorized Economic Operator), C-TPAT (Customs-Trade Partnership Against Terrorism), or WCO (World Customs Organization).. Valid values are `internal|external|cbp|aeo|ctpat|wco`',
    `auditor_certification` STRING COMMENT 'Professional certifications or qualifications held by the lead auditor, such as Certified Customs Specialist (CCS), Licensed Customs Broker, ISO 19011 Lead Auditor, or other relevant trade compliance credentials.',
    `auditor_organization` STRING COMMENT 'Name of the organization or entity that the auditor represents. May be internal department name, external consulting firm, or regulatory authority such as CBP, AEO certification body, or customs administration.',
    `business_unit` STRING COMMENT 'Name or code of the business unit, division, or operational entity that was the subject of the compliance audit. Used for organizational segmentation and reporting.',
    `compliance_rating` STRING COMMENT 'Overall compliance rating assigned to the audited entity or process based on the audit findings. Excellent indicates no significant findings, satisfactory indicates minor findings only, needs_improvement indicates major findings requiring corrective action, unsatisfactory indicates critical findings, and non_compliant indicates severe violations requiring immediate remediation.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|non_compliant`',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numerical compliance score expressed as a percentage (0.00 to 100.00) representing the overall compliance performance based on audit criteria. Higher scores indicate better compliance posture.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which all corrective actions must be completed and verified. Used for tracking compliance with audit remediation timelines and regulatory requirements.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference identifier or document number for the corrective action plan developed in response to audit findings. Links the audit to the remediation activities and follow-up tracking.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this compliance audit record. Used for accountability and audit trail purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was first created in the system. Used for audit trail and data lineage tracking.',
    `critical_findings_count` STRING COMMENT 'Total number of critical severity findings identified during the audit. Critical findings represent major compliance violations with significant regulatory risk, potential penalties, or program suspension implications.',
    `facility_location` STRING COMMENT 'Name or identifier of the specific facility, warehouse, or operational location where the audit was conducted. Used for site-specific compliance tracking.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled or actual date for the follow-up audit to verify corrective action implementation. Null if no follow-up audit is required.',
    `follow_up_audit_required` BOOLEAN COMMENT 'Boolean indicator of whether a follow-up audit is required to verify implementation of corrective actions. True indicates follow-up audit is mandatory, false indicates no follow-up required.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this compliance audit record. Used for accountability and audit trail purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was last updated or modified. Used for audit trail and change tracking.',
    `major_findings_count` STRING COMMENT 'Total number of major severity findings identified during the audit. Major findings represent significant compliance gaps that require corrective action but do not pose immediate program suspension risk.',
    `minor_findings_count` STRING COMMENT 'Total number of minor severity findings identified during the audit. Minor findings represent opportunities for improvement or minor procedural deviations that do not pose significant compliance risk.',
    `population_size` STRING COMMENT 'Total number of transactions, declarations, or records in the population from which the audit sample was drawn. Used for calculating sampling rates and extrapolating findings.',
    `program_certification_impacted` STRING COMMENT 'Name of the trade compliance program or certification whose status may be impacted by the audit findings, such as C-TPAT, AEO, or other trusted trader programs. Used to track program-specific compliance obligations.',
    `regulatory_authority` STRING COMMENT 'Name of the customs or regulatory authority with jurisdiction over the audit, such as U.S. Customs and Border Protection (CBP), European Commission, or national customs administration. Identifies the governing body for compliance requirements.',
    `remarks` STRING COMMENT 'Free-text field for additional comments, observations, or contextual information related to the audit that does not fit into structured fields. Used for capturing qualitative insights and special circumstances.',
    `risk_level` STRING COMMENT 'Overall risk level assigned to the audited entity or process based on the audit findings and compliance posture. Used for prioritizing remediation efforts and resource allocation.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of transactions, declarations, or records sampled and reviewed during the audit. Used for statistical analysis and audit scope documentation.',
    `total_findings_count` STRING COMMENT 'Total number of all findings identified during the audit across all severity levels. Represents the aggregate count of critical, major, and minor findings.',
    `trade_lane` STRING COMMENT 'Specific trade lane or shipping corridor that was the focus of the audit, such as US-China, EU-Asia, or Intra-EU. Used for lane-specific compliance analysis.',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Transactional record of internal and external trade compliance audits conducted against customs processes, declarations, and program requirements. Captures audit type (internal/external/CBP/AEO), audit scope, audit date, auditor identity, findings count by severity (critical/major/minor), corrective action plan reference, audit status (planned/in_progress/completed/closed), and overall compliance rating. Supports C-TPAT and AEO program maintenance and regulatory self-assessment obligations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` (
    `ftz_inventory_id` BIGINT COMMENT 'Unique identifier for the FTZ inventory record. Primary key for tracking goods held within Foreign Trade Zone facilities.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: FTZ inventory is managed by specific cost centers for warehouse overhead allocation and profitability analysis. Required for cost allocation, transfer pricing, and zone-level P&L reporting.',
    `declaration_id` BIGINT COMMENT 'CBP entry number assigned when goods are withdrawn from the FTZ and entered into US commerce. Links FTZ inventory to formal customs entry.',
    `ftz_admission_id` BIGINT COMMENT 'Unique reference number assigned by CBP or FTZ operator at the time of goods admission. Used for tracking and audit purposes.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: FTZ zones are physical locations in the logistics network. Required for inventory visibility by node, zone-to-zone transfer planning, and network capacity management. Replaces denormalized ftz_site_lo',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FTZ inventory requires designated inventory managers (employees). CBP regulatory requirement for zone accountability. Tracks who is responsible for inventory accuracy and cycle counts.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: FTZ inventory is owned by a trade party (importer, manufacturer, etc.). Adding owner_trade_party_id FK to trade_party.trade_party_id normalizes the owner reference. Cardinality: N:1 (many inventory re',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Free Trade Zone inventory operations track packaging materials for Extended Producer Responsibility (EPR) compliance and circular economy reporting. Real process: Warehouse-level packaging waste track',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: FTZ inventory management tracks goods by supplier for zone lot control, withdrawal planning, and duty deferral accounting. Zone operators link inventory records to supplier master for compliance repor',
    `aeo_certified_indicator` BOOLEAN COMMENT 'Flag indicating whether the goods owner or FTZ operator holds AEO or C-TPAT certification, enabling expedited customs processing and reduced inspections.',
    `cbp_bond_number` STRING COMMENT 'CBP continuous bond number covering the FTZ operator and goods. Required for FTZ operations to guarantee duty payment and compliance.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the goods held in the FTZ, including product name, specifications, and characteristics.',
    `consignee_name` STRING COMMENT 'Name of the party designated to receive the goods upon exit from the FTZ. Used for customs declarations and shipping documentation.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing where the goods were manufactured or substantially transformed. Used for trade compliance and preferential tariff determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the FTZ inventory record was first created in the warehouse management system. Used for audit trail and data lineage.',
    `customs_value_usd` DECIMAL(18,2) COMMENT 'Declared customs value of the inventory in US dollars. Used for duty calculation and financial reporting. Based on transaction value or WTO valuation methods.',
    `cycle_count_variance_quantity` DECIMAL(18,2) COMMENT 'Difference between system quantity and physical count during last cycle count. Positive values indicate overages, negative values indicate shortages.',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Applicable customs duty rate percentage for the commodity based on HS code and country of origin. Used to calculate potential duty liability upon FTZ exit.',
    `estimated_duty_amount_usd` DECIMAL(18,2) COMMENT 'Calculated potential duty liability in US dollars if goods were to enter US commerce. Computed as customs value multiplied by duty rate.',
    `expiration_date` DATE COMMENT 'Date when the goods expire or become obsolete. Critical for inventory rotation, FIFO management, and preventing storage of expired goods.',
    `export_date` DATE COMMENT 'Date when goods were exported from the FTZ to a foreign destination. Exports from FTZ are not subject to US customs duties.',
    `export_destination_country` STRING COMMENT 'Three-letter ISO country code representing the final destination country for exported goods. Used for export compliance and trade statistics.. Valid values are `^[A-Z]{3}$`',
    `ftz_operator_name` STRING COMMENT 'Legal name of the entity operating the FTZ facility. May be Transport Shipping or a third-party logistics provider.',
    `ftz_zone_number` STRING COMMENT 'Official zone number assigned by the FTZ Board (e.g., 123, 45A). Identifies the specific FTZ facility where goods are held.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `ftz_zone_type` STRING COMMENT 'Classification of the FTZ facility: general purpose (multi-user), subzone (single-user dedicated), or usage-driven (hybrid model).. Valid values are `general_purpose|subzone|usage_driven`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the inventory contains hazardous materials requiring special handling, storage, and compliance with IMDG or IATA dangerous goods regulations.',
    `hs_code` STRING COMMENT 'International tariff classification code (6-10 digits) used for customs declarations and duty calculation. Critical for FTZ compliance and duty deferral.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'Standard trade term defining the responsibilities, costs, and risks between buyer and seller for goods in the FTZ. Determines liability and insurance requirements. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_value_usd` DECIMAL(18,2) COMMENT 'Declared insurance value of the inventory in US dollars. Used for cargo insurance coverage and claims processing.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent physical inventory cycle count for this lot. Used for inventory accuracy monitoring and audit compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the FTZ inventory record was last updated. Tracks changes to quantity, status, or other attributes for audit purposes.',
    `manipulation_description` STRING COMMENT 'Detailed description of manufacturing, assembly, repackaging, or other manipulation activities performed on the goods within the FTZ.',
    `manipulation_status` STRING COMMENT 'Current status of any manufacturing, processing, or manipulation activities performed on the goods within the FTZ. FTZ regulations permit certain value-added activities.. Valid values are `none|in_progress|completed|approved|pending_approval`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current quantity of the commodity physically present in the FTZ facility. Updated in real-time as goods are admitted, manipulated, or removed.',
    `sku` STRING COMMENT 'Internal stock keeping unit identifier for the commodity held in the FTZ. Used for inventory tracking and warehouse management.',
    `storage_location` STRING COMMENT 'Specific warehouse location within the FTZ facility (e.g., aisle, rack, bin) where the inventory is physically stored. Used for warehouse management and cycle counting.',
    `temperature_controlled_indicator` BOOLEAN COMMENT 'Flag indicating whether the inventory requires temperature-controlled storage (refrigerated or frozen). Critical for cold chain management.',
    `temperature_range_celsius` STRING COMMENT 'Required storage temperature range in Celsius (e.g., 2-8°C for pharmaceuticals, -18°C for frozen goods). Used for cold chain compliance.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials (e.g., UN1203 for gasoline). Required for dangerous goods compliance in FTZ operations.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify the inventory (e.g., EA=each, KG=kilogram, CBM=cubic meter, TEU=twenty-foot equivalent unit). [ENUM-REF-CANDIDATE: EA|KG|LB|CBM|M3|L|GAL|TON|TEU|CASE|PALLET — 11 candidates stripped; promote to reference product]',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the inventory in cubic meters. Used for warehouse space planning and freight rate calculations.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the inventory in kilograms. Used for freight calculations, capacity planning, and customs declarations.',
    `zone_lot_number` STRING COMMENT 'Internal lot or batch number assigned by the FTZ operator for inventory tracking and First In First Out (FIFO) or Last In First Out (LIFO) management.',
    `zone_status` STRING COMMENT 'Current disposition of the inventory: in-zone (still in FTZ), transferred (moved to another FTZ), exported (left US), consumed (used in manufacturing), destroyed, or entered commerce (duty paid and released to US market).. Valid values are `in_zone|transferred|exported|consumed|destroyed|entered_commerce`',
    CONSTRAINT pk_ftz_inventory PRIMARY KEY(`ftz_inventory_id`)
) COMMENT 'Master inventory record for goods held within a Foreign Trade Zone (FTZ) or Free Trade Zone facility operated or used by Transport Shipping. Captures FTZ zone number, zone type (general purpose/subzone), SKU, commodity description, HS code, country of origin, quantity on hand, unit of measure, admission date, admission type (privileged foreign/non-privileged foreign/domestic/zone restricted), manipulation status, and zone status (in-zone/transferred/exported/consumed). Managed in compliance with US CBP FTZ Board regulations and equivalent national FTZ authorities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` (
    `ftz_admission_id` BIGINT COMMENT 'Unique identifier for the FTZ admission record. Primary key for the ftz_admission product.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: FTZ admissions trigger specific handling, storage, and manipulation charges. Required for billing FTZ-related services and tracking zone operation costs in logistics operations with free trade zone fa',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: FTZ admissions processed by licensed customs brokers (employees). CBP regulatory requirement. Tracks individual accountability for admission accuracy and compliance with FTZ regulations.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: FTZ admissions operate under warehouse/logistics agreements that govern admission procedures, storage terms, manipulation services, withdrawal processes, and billing rates. Linking admission to agreem',
    `billing_invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: FTZ admission processing is a billable service charged per admission event. Links admission to invoice line for FTZ handling fee billing—standard charge in foreign trade zone operations.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: FTZ admissions track inbound carrier for zone entry documentation, bonded movement tracking, and carrier liability determination. Carrier FK supports admission audit trails, transport mode validation,',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: FTZ admission records goods entering foreign trade zones from inbound shipments. Duty deferral tracking, zone inventory reconciliation, and admission-to-withdrawal audit trails require linking admissi',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer of record in FTZ admission is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many FTZ admissions can have ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: FTZ admissions occur at specific entry ports. Required for admission processing location tracking, zone capacity management, and CBP coordination. Replaces denormalized port_of_entry_code.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: FTZ admission records identify supplier/manufacturer of goods entering the zone for inventory tracking and compliance. Zone operators link admissions to supplier master for duty calculation and origin',
    `admission_date` DATE COMMENT 'The date on which the merchandise was formally admitted into the FTZ. This is the principal business event timestamp for the admission transaction.',
    `admission_number` STRING COMMENT 'The official admission number assigned by CBP for this FTZ entry. This is the externally-known business identifier for the admission transaction.. Valid values are `^[A-Z0-9]{8,20}$`',
    `admission_status` STRING COMMENT 'Current lifecycle status of the FTZ admission. Tracks the admission from initial filing through final disposition.. Valid values are `pending|admitted|withdrawn|cancelled|expired`',
    `admission_type` STRING COMMENT 'Classification of the admission based on the origin and status of the merchandise. Determines duty treatment and compliance requirements.. Valid values are `privileged_foreign|non_privileged_foreign|domestic|zone_to_zone_transfer`',
    `broker_license_number` STRING COMMENT 'CBP-issued license number of the customs broker. Required for compliance and audit purposes.. Valid values are `^[0-9]{5,10}$`',
    `broker_name` STRING COMMENT 'Name of the licensed customs broker who prepared and filed the FTZ admission on behalf of the importer.',
    `consignee_name` STRING COMMENT 'Name of the party to whom the merchandise is consigned within the FTZ.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing the country where the merchandise was manufactured or substantially transformed.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this admission record. Used for accountability and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTZ admission record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original declared value, if different from USD. Conversion to USD is recorded in declared_value_usd.. Valid values are `^[A-Z]{3}$`',
    `declared_value_usd` DECIMAL(18,2) COMMENT 'The declared customs value of the merchandise in US Dollars. Used for duty calculation and inventory accounting within the FTZ.',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'The applicable duty rate percentage for the HS Code and country of origin combination. Used for estimated duty calculation.',
    `estimated_duty_amount_usd` DECIMAL(18,2) COMMENT 'Estimated customs duty that would be owed if the merchandise were entered for consumption. Used for duty deferral accounting and financial planning.',
    `expiration_date` DATE COMMENT 'Date by which the merchandise must be withdrawn from the FTZ, exported, or destroyed. Typically 5 years from admission date per CBP regulations.',
    `filing_method` STRING COMMENT 'The method by which the FTZ admission was filed with CBP. ACE is the preferred electronic filing system.. Valid values are `ACE|paper|EDI`',
    `ftz_operator_name` STRING COMMENT 'Name of the entity operating the FTZ facility where the merchandise is admitted.',
    `ftz_zone_number` STRING COMMENT 'The designated FTZ zone number where the merchandise is being admitted. Format follows CBP zone numbering convention.. Valid values are `^[0-9]{1,4}[A-Z]?$`',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the merchandise including packaging, expressed in kilograms.',
    `hs_code` STRING COMMENT 'The Harmonized Tariff Schedule classification code for the merchandise. Used for duty calculation and trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'The Incoterm governing the transfer of risk and cost responsibility for this shipment. Determines liability and valuation for customs purposes. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `lot_number` STRING COMMENT 'Manufacturer or importer lot number for traceability and quality control purposes.',
    `merchandise_description` STRING COMMENT 'Detailed textual description of the goods being admitted into the FTZ. Must be sufficient for CBP classification and valuation purposes.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this admission record. Used for accountability and audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTZ admission record was last modified. Used for audit trail and change tracking.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the merchandise excluding packaging, expressed in kilograms. Used for duty calculation when applicable.',
    `quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of merchandise being admitted, expressed in the unit of measure specified in quantity_unit.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the quantity field. Must align with HS Code reporting requirements. [ENUM-REF-CANDIDATE: pieces|cartons|pallets|units|kilograms|pounds|liters|gallons — 8 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or clarifications related to the FTZ admission.',
    `serial_number` STRING COMMENT 'Unique serial number of the merchandise, if applicable. Used for high-value or regulated goods tracking.',
    `special_program_indicator` STRING COMMENT 'Indicates if the admission is subject to special compliance programs or regulatory oversight beyond standard CBP requirements.. Valid values are `C-TPAT|AEO|FDA_regulated|USDA_regulated|EPA_regulated|None`',
    `trade_agreement` STRING COMMENT 'Name of the preferential trade agreement under which duty relief is claimed, if applicable (e.g., USMCA, CAFTA-DR). [ENUM-REF-CANDIDATE: USMCA|CAFTA-DR|KORUS|AUSFTA|GSP|MFN|None — promote to reference product]',
    `warehouse_location` STRING COMMENT 'Specific warehouse or storage location within the FTZ where the merchandise is stored. Used for inventory tracking.',
    `withdrawal_date` DATE COMMENT 'Date on which the merchandise was withdrawn from the FTZ for consumption, export, or destruction. Null if still in zone.',
    `withdrawal_type` STRING COMMENT 'The manner in which the merchandise was withdrawn from the FTZ. Determines final duty treatment and compliance obligations.. Valid values are `consumption|export|destruction|zone_to_zone_transfer|None`',
    CONSTRAINT pk_ftz_admission PRIMARY KEY(`ftz_admission_id`)
) COMMENT 'Transactional record for the formal admission of merchandise into a Foreign Trade Zone (FTZ). Captures FTZ admission number, zone number, admission date, merchandise description, HS code, country of origin, quantity, weight, value, admission type (privileged foreign/non-privileged foreign/domestic), carrier, port of entry, CBP entry number, and admission status. Each admission triggers inventory tracking and duty deferral accounting within the FTZ. Aligned to CBP Form 214 (Application for Foreign Trade Zone Admission).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the customs hold record. Primary key.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Customs holds generate detention, storage, examination, and demurrage charges. Essential for billing customers for hold-related costs and tracking financial impact of customs delays in logistics opera',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to finance.accrual. Business justification: Customs holds trigger financial accruals for potential penalties, additional duties, or storage costs. Required for financial risk provisioning, period-end close, and contingent liability reporting.',
    `agent_id` BIGINT COMMENT 'Reference to the customs broker handling the resolution of this hold.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Customs holds trigger SLA breaches and penalty clauses in service agreements. Tracking which agreement governs a held shipment is essential for penalty calculation, dispute resolution, credit note iss',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that is subject to this customs hold.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration associated with this hold.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this customs hold record.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Customs holds are placed at specific examination locations/ports. Required for hold resolution workflow by facility, resource allocation, and examination capacity planning. Replaces denormalized port_',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Customs holds are frequently triggered by HSE incidents discovered during inspection (DG leakage, contamination, hazmat misdeclaration). Real business process: hold reason documentation, incident inve',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Customs holds on rejected, expired, or non-compliant goods result in disposal events that must be tracked as hazardous or non-hazardous waste. Real process: Waste disposal compliance and ESG waste div',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Date and time when the customs hold was actually lifted and the shipment was released. Null if hold is still active.',
    `additional_duty_amount` DECIMAL(18,2) COMMENT 'Additional customs duty amount assessed as a result of the examination, in the currency specified by additional_duty_currency_code.',
    `additional_duty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the additional duty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `aeo_certified_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipper or consignee holds Authorized Economic Operator (AEO) certification, which may expedite hold resolution. True if certified, False otherwise.',
    `c_tpat_certified_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipper or consignee holds C-TPAT certification, which may expedite hold resolution. True if certified, False otherwise.',
    `country_of_examination_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the examination took place (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this customs hold record was first created in the system.',
    `customer_notification_sent_indicator` BOOLEAN COMMENT 'Flag indicating whether the customer was notified about the customs hold. True if notification was sent, False otherwise.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the customer was notified about the customs hold.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the hold in hours, calculated from hold placed timestamp to actual release timestamp. Used for Service Level Agreement (SLA) impact analysis.',
    `escalation_level` STRING COMMENT 'Numeric indicator of escalation level for complex or disputed holds. 0 = no escalation, 1 = first-level escalation, 2 = management escalation, 3 = executive escalation.',
    `escalation_reason` STRING COMMENT 'Explanation of why the hold was escalated to a higher level of review or management intervention.',
    `examination_findings` STRING COMMENT 'Detailed narrative of the examination findings, including any discrepancies, violations, or compliance issues discovered during the inspection.',
    `examination_location` STRING COMMENT 'Physical location where the examination was conducted (e.g., port facility, Container Freight Station (CFS), bonded warehouse, Inland Container Depot (ICD)).',
    `examination_result_code` STRING COMMENT 'Outcome of the customs examination. CLEARED = no issues found, DISCREPANCY_FOUND = documentation or commodity discrepancies identified, VIOLATION_DETECTED = regulatory violation discovered, ADDITIONAL_DUTY_ASSESSED = additional duties or taxes levied, SEIZURE = goods seized, PENALTY_ISSUED = monetary penalty imposed.. Valid values are `CLEARED|DISCREPANCY_FOUND|VIOLATION_DETECTED|ADDITIONAL_DUTY_ASSESSED|SEIZURE|PENALTY_ISSUED`',
    `examination_type_code` STRING COMMENT 'Type of physical or documentary examination conducted. VACIS = Vehicle and Cargo Inspection System (non-intrusive imaging), CET = Container Examination Team (physical inspection), INTENSIVE = full intensive examination, TAILGATE = tailgate inspection, DOCUMENT_ONLY = documentary review only, NO_EXAM = hold released without examination.. Valid values are `VACIS|CET|INTENSIVE|TAILGATE|DOCUMENT_ONLY|NO_EXAM`',
    `expected_release_date` DATE COMMENT 'Anticipated date when the hold is expected to be resolved and the shipment released, based on examination schedule and processing timelines.',
    `hold_number` STRING COMMENT 'Externally-known unique identifier or reference number assigned to this customs hold by the issuing authority or internal system.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the customs hold. ACTIVE = hold is in effect, PENDING_RELEASE = awaiting clearance, RELEASED = hold has been lifted, ESCALATED = requires higher-level review, CANCELLED = hold was cancelled or withdrawn.. Valid values are `ACTIVE|PENDING_RELEASE|RELEASED|ESCALATED|CANCELLED`',
    `issuing_authority_code` STRING COMMENT 'Code identifying the customs authority or regulatory agency that placed the hold (e.g., CBP, USDA, FDA, port authority, internal compliance team).',
    `issuing_authority_name` STRING COMMENT 'Full name of the customs authority or regulatory agency that issued the hold.',
    `issuing_officer_badge_number` STRING COMMENT 'Badge or identification number of the customs officer who placed the hold.',
    `issuing_officer_name` STRING COMMENT 'Name of the customs officer or inspector who placed the hold.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this customs hold record was last updated in the system.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount imposed due to violations or non-compliance discovered during the hold examination, in the currency specified by penalty_currency_code.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `placed_timestamp` TIMESTAMP COMMENT 'Date and time when the customs hold was officially placed on the shipment. Principal business event timestamp for this transaction.',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for the hold (e.g., random inspection, high-risk commodity, incomplete documentation, valuation discrepancy, denied party screening hit).',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of why the customs hold was placed, including any specific regulatory concerns or compliance issues identified.',
    `resolution_action_code` STRING COMMENT 'Code representing the action taken to resolve the hold (e.g., documentation provided, duty paid, goods returned, goods destroyed, appeal filed).',
    `resolution_notes` STRING COMMENT 'Detailed notes describing how the hold was resolved, including any corrective actions taken, documentation submitted, or negotiations with customs authorities.',
    `responsible_party_code` STRING COMMENT 'Code identifying which party is responsible for resolving the hold. SHIPPER = shipper responsible, CONSIGNEE = consignee responsible, BROKER = customs broker responsible, CARRIER = carrier responsible, INTERNAL = internal compliance team responsible.. Valid values are `SHIPPER|CONSIGNEE|BROKER|CARRIER|INTERNAL`',
    `risk_score` DECIMAL(18,2) COMMENT 'Automated risk score assigned to the shipment that triggered the hold, typically from customs risk management systems. Higher scores indicate higher risk.',
    `sla_breach_indicator` BOOLEAN COMMENT 'Flag indicating whether the hold caused a breach of the shipment Service Level Agreement (SLA) for on-time delivery. True if SLA was breached, False otherwise.',
    `total_financial_impact_amount` DECIMAL(18,2) COMMENT 'Total financial impact of the hold including additional duties, penalties, storage fees, and other charges, in the currency specified by total_financial_impact_currency_code.',
    `total_financial_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `type_code` STRING COMMENT 'Classification of the customs hold type. CBP_EXAM = Customs and Border Protection examination, USDA_INSPECTION = United States Department of Agriculture inspection, FDA_INSPECTION = Food and Drug Administration inspection, SECURITY_HOLD = security-related detention, COMPLIANCE_REVIEW = internal compliance review, DOCUMENTATION_REVIEW = documentation verification hold.. Valid values are `CBP_EXAM|USDA_INSPECTION|FDA_INSPECTION|SECURITY_HOLD|COMPLIANCE_REVIEW|DOCUMENTATION_REVIEW`',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Transactional record capturing customs examination holds, detentions, and regulatory stops placed on shipments by customs authorities or internal compliance teams. Captures hold type (CBP exam/USDA/FDA/security/compliance_review), hold reason, issuing authority, hold date, expected release date, actual release date, examination type (VACIS/CET/intensive/tailgate), examination result, additional duties or penalties assessed, and hold resolution notes. Critical for shipment exception management and SLA impact tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`ruling_request` (
    `ruling_request_id` BIGINT COMMENT 'Unique identifier for the customs ruling request record.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Ruling requests are submitted to customs authorities for tariff classification decisions. The ruling results in an approved HS code which corresponds to an hs_classification record. Linking ruling_req',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customs ruling requests (classification, valuation, origin rulings) are billable advisory services. Links ruling request to invoice for professional services billing—standard practice for trade adviso',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Customs ruling requests reference manufacturer/supplier for product-specific classification or valuation rulings. Brokers submit rulings with supplier technical specifications and production details f',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Requesting party in ruling request is a trade party. Adding requesting_party_trade_party_id FK to trade_party.trade_party_id normalizes the requesting party reference. Cardinality: N:1 (many ruling re',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ruling requests submitted by licensed customs brokers or trade compliance specialists (employees). Regulatory requirement for binding rulings. Tracks who prepared and submitted the request.',
    `appeal_decision_date` DATE COMMENT 'Date the appeal authority issued a final decision on the appeal, if applicable. Null if no appeal decision has been rendered.',
    `appeal_filing_date` DATE COMMENT 'Date an appeal was filed against the ruling decision, if applicable. Null if no appeal has been filed.',
    `appeal_status` STRING COMMENT 'Status of any appeal filed against the ruling decision. Tracks whether the requesting party or other interested parties have challenged the ruling and the outcome of that appeal process.. Valid values are `not_appealed|appeal_filed|appeal_under_review|appeal_granted|appeal_denied|appeal_withdrawn`',
    `approved_hs_code` STRING COMMENT 'The official HS Code determined and approved by the customs authority in the ruling decision. This becomes the binding classification for future declarations involving the same commodity.',
    `binding_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the ruling is legally binding on the customs authority for future declarations involving the same commodity and circumstances.',
    `brand_name` STRING COMMENT 'Brand or trademark name of the commodity covered by the ruling, if applicable. May be relevant for classification and valuation determinations.',
    `commodity_description` STRING COMMENT 'Detailed description of the goods or commodity for which the ruling is requested. Must include sufficient detail for the customs authority to make an informed classification, valuation, or origin determination.',
    `country_of_origin_code` STRING COMMENT 'Three-letter ISO country code representing the country of origin for the commodity as determined or confirmed by the ruling. Critical for preferential trade agreement eligibility and duty calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ruling request record was first created in the system.',
    `customs_office_code` STRING COMMENT 'Specific customs office or port code where the ruling request was filed or that has jurisdiction over the request.',
    `duty_rate_percent` DECIMAL(18,2) COMMENT 'Applicable duty rate percentage determined by the ruling based on the approved HS Code and origin determination. Used for calculating import duties on future shipments.',
    `effective_date` DATE COMMENT 'Date from which the ruling becomes legally effective and binding for customs declarations. May differ from the decision date if the authority specifies a future effective date.',
    `expiry_date` DATE COMMENT 'Date when the ruling expires and is no longer valid for use in customs declarations. Binding rulings typically have a fixed validity period (e.g., 3-5 years depending on jurisdiction).',
    `importer_identifier` STRING COMMENT 'Official customs identifier for the importer of record such as Importer Number, EORI, or Tax ID.',
    `importer_name` STRING COMMENT 'Name of the importer of record who will use the ruling for customs declarations. May differ from the requesting party if a broker or consultant submitted on behalf of the importer.',
    `incoterms_code` STRING COMMENT 'Incoterms code applicable to the transaction or commodity covered by the ruling. Relevant for valuation rulings as Incoterms determine which costs are included in customs value.',
    `model_number` STRING COMMENT 'Manufacturers model number or product code for the commodity. Helps ensure the ruling is applied only to the specific product variant covered by the decision.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ruling request record was last modified or updated in the system.',
    `preference_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the ruling confirms eligibility for preferential duty treatment under a trade agreement.',
    `proposed_hs_code` STRING COMMENT 'The HS Code proposed by the requesting party for tariff classification of the commodity. This is the applicants suggested classification subject to customs authority review and approval.',
    `public_availability_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the ruling is publicly available in the customs authoritys ruling database or if it is confidential to the requesting party.',
    `revocation_date` DATE COMMENT 'Date the ruling was revoked or invalidated by the customs authority, if applicable. Null if the ruling remains valid or expired naturally.',
    `revocation_reason` STRING COMMENT 'Explanation for why the ruling was revoked, such as changes in law, discovery of incorrect information, or changes in product specifications.',
    `ruling_authority_code` STRING COMMENT 'Code identifying the customs authority responsible for issuing the ruling. Examples include CBP (US Customs and Border Protection), HMRC (UK), EU member state customs authorities, or other national customs agencies.',
    `ruling_authority_name` STRING COMMENT 'Full name of the customs authority or agency that issued or is reviewing the ruling request.',
    `ruling_decision_date` DATE COMMENT 'Date the customs authority issued the final ruling decision. Marks the official determination and start of the rulings validity period.',
    `ruling_number` STRING COMMENT 'Official ruling number issued by the customs authority upon approval. Serves as the external reference identifier for the binding or advance ruling decision.',
    `ruling_outcome` STRING COMMENT 'Final decision outcome of the ruling request. Indicates whether the customs authority approved the request as submitted, approved with modifications to the proposed classification or determination, denied the request, or if the applicant withdrew it.. Valid values are `approved_as_proposed|approved_with_modification|denied|withdrawn|pending`',
    `ruling_rationale` STRING COMMENT 'Detailed explanation provided by the customs authority for the ruling decision, including legal basis, classification reasoning, and interpretation of applicable regulations.',
    `ruling_status` STRING COMMENT 'Current lifecycle status of the ruling request. Tracks progression from initial draft through submission, authority review, final decision, and post-decision states including expiration and appeals. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|denied|withdrawn|expired|appealed — 8 candidates stripped; promote to reference product]',
    `ruling_type` STRING COMMENT 'Type of ruling requested from the customs authority. Classification rulings determine HS Code assignment, valuation rulings establish customs value methodology, origin rulings confirm country of origin for preferential treatment, marking rulings clarify labeling requirements, binding rulings provide legal certainty, and advance rulings are issued before importation.. Valid values are `classification|valuation|origin|marking|binding|advance`',
    `submission_date` DATE COMMENT 'Date the ruling request was officially submitted to the customs authority. Marks the start of the formal review process and is used to calculate processing timelines and expiration dates.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the ruling request was submitted to the customs authority, including time zone information. Used for audit trails and compliance verification.',
    `supporting_documentation` STRING COMMENT 'List or description of supporting documents submitted with the ruling request such as product samples, technical drawings, certificates of origin, manufacturing process descriptions, or laboratory test results.',
    `technical_specifications` STRING COMMENT 'Detailed technical specifications of the commodity including materials, dimensions, composition, functionality, and other characteristics relevant to classification or origin determination.',
    `trade_agreement_code` STRING COMMENT 'Code identifying the preferential trade agreement under which the ruling is requested or granted, such as USMCA, EU-UK TCA, CPTPP, or other free trade agreements.',
    `validity_period_months` STRING COMMENT 'Number of months the ruling remains valid from the effective date. Standard validity periods vary by jurisdiction and ruling type.',
    `valuation_method_code` STRING COMMENT 'Code representing the customs valuation method approved in the ruling, based on WTO Valuation Agreement methods (transaction value, identical goods, similar goods, deductive, computed, fallback).',
    CONSTRAINT pk_ruling_request PRIMARY KEY(`ruling_request_id`)
) COMMENT 'Master record for binding and advance ruling requests submitted to customs authorities for tariff classification, valuation, or origin determination. Captures ruling type (classification/valuation/origin/marking), requesting party, submission date, ruling authority (CBP/HMRC/EU customs authority), commodity description, proposed HS code, ruling number issued, ruling outcome, effective date, expiry date, and appeal status. Binding rulings provide legal certainty for duty calculations and are managed as authoritative reference within Descartes Customs GTM.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`origin_determination` (
    `origin_determination_id` BIGINT COMMENT 'Unique identifier for the origin determination record.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Origin determination is performed for a specific HS-classified good. Currently has hs_code as denormalized string. Adding FK to hs_classification links the determination to the authoritative classific',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer in origin determination is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many origin determinations can h',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Origin determinations require manufacturer/supplier details for regional value content calculations and tariff shift analysis. Origin analysts verify supplier production locations and material sourcin',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Origin determinations are made in the context of specific trade agreements to qualify for preferential tariff treatment. Adding trade_agreement_id FK to trade_agreement.trade_agreement_id establishes ',
    `approval_date` DATE COMMENT 'Date on which the origin determination was approved for use.',
    `approved_by_user` STRING COMMENT 'Name or identifier of the supervisor or manager who approved the origin determination.',
    `certificate_number` STRING COMMENT 'Reference number of the certificate of origin or other supporting document.',
    `commodity_description` STRING COMMENT 'Detailed description of the goods for which country of origin is being determined.',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 code representing the determined country of origin for the goods.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this origin determination record was first created in the system.',
    `determination_date` DATE COMMENT 'Date on which the origin determination was made.',
    `determination_method` STRING COMMENT 'The method used to determine country of origin: wholly obtained (goods entirely produced in one country), substantial transformation (goods undergo significant processing), tariff shift (change in HS classification), value added content (percentage of value added in origin country), change in tariff classification, or regional value content (for trade agreement purposes).. Valid values are `wholly_obtained|substantial_transformation|tariff_shift|value_added_content|change_in_tariff_classification|regional_value_content`',
    `determination_number` STRING COMMENT 'Business reference number assigned to this origin determination for tracking and audit purposes.',
    `determination_status` STRING COMMENT 'Current lifecycle status of the origin determination: draft (being prepared), pending review (submitted for validation), approved (validated and active), rejected (not accepted), expired (validity period ended), or superseded (replaced by newer determination).. Valid values are `draft|pending_review|approved|rejected|expired|superseded`',
    `determined_by_user` STRING COMMENT 'Name or identifier of the customs specialist or trade compliance officer who made the origin determination.',
    `duty_savings_amount` DECIMAL(18,2) COMMENT 'Estimated or actual duty savings realized by claiming preferential origin under the trade agreement.',
    `duty_savings_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the duty savings amount.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this origin determination is valid and can be used for preferential tariff claims.',
    `effective_until_date` DATE COMMENT 'Date until which this origin determination remains valid. Nullable for determinations without expiration.',
    `exporter_identifier` STRING COMMENT 'Tax ID, customs registration number, or other official identifier of the exporter.',
    `exporter_name` STRING COMMENT 'Name of the exporting party who prepared or provided the origin documentation.',
    `hs_code` STRING COMMENT 'The HS Code of the goods for which origin is being determined. Links the origin determination to the commodity classification.. Valid values are `^[0-9]{6,10}$`',
    `issuing_authority` STRING COMMENT 'Name of the government agency, chamber of commerce, or authorized body that issued the certificate of origin or validated the origin determination.',
    `issuing_authority_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 code of the country where the issuing authority is located.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this origin determination record was last updated.',
    `materials_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for materials values.. Valid values are `^[A-Z]{3}$`',
    `non_originating_materials_value` DECIMAL(18,2) COMMENT 'Total value of non-originating materials used in production, relevant for regional value content calculations.',
    `notes` STRING COMMENT 'Additional notes, comments, or justification supporting the origin determination decision.',
    `origin_criterion_met` STRING COMMENT 'Specific origin criterion satisfied under the applicable trade agreement (e.g., Criterion A: wholly obtained, Criterion B: produced exclusively from originating materials, Criterion C: tariff shift rule met).',
    `originating_materials_value` DECIMAL(18,2) COMMENT 'Total value of originating materials used in production, relevant for regional value content calculations.',
    `preferential_tariff_rate_percent` DECIMAL(18,2) COMMENT 'The preferential duty rate (as percentage) claimed under the applicable trade agreement based on this origin determination.',
    `production_location` STRING COMMENT 'Specific facility, plant, or location where the goods were produced or substantially transformed.',
    `regional_value_content_percent` DECIMAL(18,2) COMMENT 'Percentage of regional value content calculated for trade agreement compliance, representing the proportion of value added within the trade agreement region.',
    `rvc_calculation_method` STRING COMMENT 'Method used to calculate regional value content: transaction value (based on sale price), net cost (based on production costs), build-up (sum of originating materials and costs), or build-down (subtract non-originating materials from total value).. Valid values are `transaction_value|net_cost|build_up|build_down`',
    `standard_tariff_rate_percent` DECIMAL(18,2) COMMENT 'The standard (Most Favored Nation) duty rate that would apply without preferential origin, for comparison purposes.',
    `supporting_document_type` STRING COMMENT 'Type of documentation supporting the origin determination: certificate of origin (traditional paper certificate), EUR.1 (EU preferential certificate), Form A (GSP certificate), REX declaration (Registered Exporter system), USMCA certification, manufacturer affidavit, supplier declaration, or origin declaration on commercial invoice. [ENUM-REF-CANDIDATE: certificate_of_origin|eur1|form_a|rex_declaration|usmca_certification|manufacturer_affidavit|supplier_declaration|origin_declaration — 8 candidates stripped; promote to reference product]',
    `tariff_shift_rule_met` STRING COMMENT 'Description of the specific tariff shift rule satisfied (e.g., change from any other chapter, change from any other heading, change from any other subheading).',
    `verification_date` DATE COMMENT 'Date on which the customs authority verified or audited this origin determination.',
    `verification_reference_number` STRING COMMENT 'Reference number assigned by customs authority during verification or audit of the origin determination.',
    `verified_by_customs_authority` BOOLEAN COMMENT 'Indicates whether this origin determination has been verified or audited by the destination country customs authority.',
    CONSTRAINT pk_origin_determination PRIMARY KEY(`origin_determination_id`)
) COMMENT 'Master record for country of origin determinations made for specific goods, supporting preferential tariff claims and trade agreement benefits. Captures determination method (wholly obtained/substantial transformation/tariff shift/value added content), applicable trade agreement, origin criterion met, supporting documentation type (certificate of origin/EUR.1/Form A/REX declaration), determination date, validity period, issuing authority, and preferential rate claimed. Distinct from hs_classification — origin_determination establishes WHERE goods were made, not WHAT they are.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` (
    `certificate_of_origin_id` BIGINT COMMENT 'Unique identifier for the certificate of origin record.',
    `declaration_id` BIGINT COMMENT 'Foreign key reference to the export customs declaration record associated with this certificate. Links to the declaration product in the customs domain.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Exporter in certificate of origin is a trade party. Adding exporter_trade_party_id FK to trade_party.trade_party_id normalizes the exporter reference. Cardinality: N:1 (many certificates can have the ',
    `origin_determination_id` BIGINT COMMENT 'Foreign key linking to customs.origin_determination. Business justification: A certificate of origin is supported by an origin determination that establishes the country of origin through rules of origin analysis. Linking certificate to its supporting origin determination prov',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Certificates of origin identify exporter/supplier for preferential tariff claims under trade agreements. Customs teams validate supplier details against certificates for origin determination and duty ',
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: Origin certificates support preferential tariff treatment, affecting duty rates and tax accounts. Required for duty savings validation, tax reporting, and audit support for preferential tariff claims.',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Certificates of origin are issued under specific trade agreements to claim preferential tariff treatment. The certificate has trade_agreement_code as a denormalized string. Adding FK to trade_agreemen',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: COO verification performed by trade compliance officers (employees). Regulatory requirement for preferential tariff claims. Tracks who verified the certificate authenticity and origin criteria.',
    `awb_number` STRING COMMENT 'Air waybill number for air freight shipments covered by this certificate. Nullable if shipment is not by air.',
    `bol_number` STRING COMMENT 'Bill of lading number for ocean or ground freight shipments covered by this certificate. Nullable if shipment is not by ocean or ground.',
    `certificate_number` STRING COMMENT 'Unique certificate number assigned by the issuing authority or system. This is the externally-known business identifier for the certificate.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certificate. Draft indicates preparation; issued means certificate is active; endorsed means validated by authority; revoked means certificate has been invalidated; expired means validity period has passed; pending approval means awaiting authority review.. Valid values are `draft|issued|endorsed|revoked|expired|pending_approval`',
    `certificate_type` STRING COMMENT 'Type of certificate of origin. Preferential certificates support duty reduction under trade agreements; non-preferential certificates confirm origin without tariff benefits; GSP Form A for Generalized System of Preferences; EUR.1 for EU trade; USMCA for United States-Mexico-Canada Agreement; RCEP for Regional Comprehensive Economic Partnership.. Valid values are `preferential|non-preferential|gsp_form_a|eur1|usmca|rcep`',
    `consignee_address` STRING COMMENT 'Full business address of the consignee including street, city, state/province, postal code, and country.',
    `consignee_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the destination country where the consignee is located.. Valid values are `^[A-Z]{3}$`',
    `consignee_identifier` STRING COMMENT 'Unique business identifier for the consignee, such as tax ID, EORI number, or customs registration number.',
    `consignee_name` STRING COMMENT 'Full legal name of the consignee or importer receiving the goods covered by this certificate.',
    `country_of_origin_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the goods were produced, manufactured, or underwent substantial transformation qualifying them for origin status.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate of origin record was first created in the system.',
    `endorsement_date` DATE COMMENT 'Date when the certificate was endorsed or validated by the issuing authority. Nullable if not yet endorsed.',
    `endorsement_official_name` STRING COMMENT 'Name of the official or authorized signatory who endorsed the certificate. Nullable if not yet endorsed.',
    `expiry_date` DATE COMMENT 'Date when the certificate of origin expires and is no longer valid for customs clearance or preferential duty claims. Nullable for certificates without expiration.',
    `export_declaration_number` STRING COMMENT 'Reference number of the export customs declaration to which this certificate is linked.',
    `goods_description` STRING COMMENT 'Detailed description of the goods covered by this certificate, including product name, specifications, and characteristics sufficient for customs identification.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for the goods. Six-digit minimum for international classification; may extend to 8 or 10 digits for national subheadings.. Valid values are `^[0-9]{6,10}$`',
    `invoice_date` DATE COMMENT 'Date of the commercial invoice associated with the goods covered by this certificate.',
    `invoice_number` STRING COMMENT 'Commercial invoice number associated with the goods covered by this certificate.',
    `issue_date` DATE COMMENT 'Date when the certificate of origin was officially issued by the issuing body.',
    `issuing_body_identifier` STRING COMMENT 'Unique identifier or registration number of the issuing body, such as chamber registration number or customs authority code.',
    `issuing_body_name` STRING COMMENT 'Full legal name of the organization or authority that issued the certificate of origin.',
    `issuing_body_type` STRING COMMENT 'Type of organization or authority that issued the certificate. Chamber of commerce for trade association issuance; customs authority for government-issued certificates; exporter self-certification for approved exporter programs; authorized body for designated third-party certifiers.. Valid values are `chamber_of_commerce|customs_authority|exporter_self_certification|authorized_body`',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the certificate was issued.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate of origin record was last updated or modified in the system.',
    `origin_criterion` STRING COMMENT 'Specific rule or criterion under which the goods qualify for origin status, such as wholly obtained, substantial transformation, regional value content percentage, or change in tariff classification. Format and content vary by trade agreement.',
    `package_count` STRING COMMENT 'Total number of packages or shipping units covered by this certificate.',
    `package_type_code` STRING COMMENT 'UN/CEFACT Recommendation 21 code indicating the type of packaging, such as CT (carton), PX (pallet), DR (drum), BX (box).',
    `remarks` STRING COMMENT 'Additional notes, comments, or special instructions related to the certificate of origin, such as back-to-back certificate references, third-country invoicing details, or clarifications on origin criteria.',
    `revocation_date` DATE COMMENT 'Date when the certificate was revoked by the issuing authority. Nullable if certificate has not been revoked.',
    `revocation_reason` STRING COMMENT 'Explanation or reason for certificate revocation, such as fraudulent information, incorrect origin determination, or exporter request. Nullable if certificate has not been revoked.',
    `shipment_reference` STRING COMMENT 'Reference number linking this certificate to the associated export shipment, such as internal shipment ID or booking reference.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of all goods covered by this certificate, including packaging, measured in kilograms.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of all goods covered by this certificate, excluding packaging, measured in kilograms.',
    CONSTRAINT pk_certificate_of_origin PRIMARY KEY(`certificate_of_origin_id`)
) COMMENT 'Transactional record for certificates of origin issued or managed for export shipments, supporting preferential duty claims at destination. Captures certificate number, certificate type (preferential/non-preferential/GSP Form A/EUR.1/USMCA/RCEP), issuing body (chamber of commerce/customs authority/exporter self-certification), issue date, expiry date, exporter details, consignee details, goods description, HS code, origin criterion, and certification status (draft/issued/endorsed/revoked). Managed in Descartes Customs GTM and linked to export declarations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` (
    `incoterms_assignment_id` BIGINT COMMENT 'Unique identifier for the Incoterms assignment record. Primary key for this entity.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment to which this Incoterms rule is assigned. Links the Incoterms assignment to the specific shipment transaction.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order associated with this Incoterms assignment. Used when Incoterms are assigned at the freight order level rather than individual shipment level.',
    `incoterms_charge_allocation_id` BIGINT COMMENT 'Foreign key linking to pricing.incoterms_charge_allocation. Business justification: Incoterms assignments must reference charge allocation rules to determine cost responsibility (seller vs buyer) for freight, insurance, customs, and handling charges. Core pricing logic for internatio',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Incoterms define cost/risk transfer points that align with transport lanes. Required for freight costing by lane, liability determination, and route planning based on trade terms. Lane determines appl',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created this Incoterms assignment. Supports accountability and audit trail requirements.',
    `trade_transaction_id` BIGINT COMMENT 'Reference to the broader trade transaction or commercial invoice to which this Incoterms assignment applies. Supports cross-border trade compliance tracking.',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when this Incoterms assignment was created in the system. Provides audit trail for compliance and dispute resolution.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the Incoterms assignment. Used for external communication and audit trail purposes.',
    `assignment_source` STRING COMMENT 'Indicates the source document or process from which this Incoterms assignment was derived. Supports audit trail and data lineage tracking.. Valid values are `contract|purchase_order|booking|manual`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the Incoterms assignment. Indicates whether the assignment is currently in force, has been replaced by a newer assignment, was cancelled, or has been completed.. Valid values are `active|superseded|cancelled|completed`',
    `buyer_cost_responsibility` STRING COMMENT 'Detailed enumeration of costs that the buyer is responsible for under the assigned Incoterms rule. Complements seller cost responsibility to provide full cost allocation picture.',
    `buyer_party_name` STRING COMMENT 'Name of the buyer party in the transaction governed by this Incoterms assignment. Provides business context for liability and cost allocation.',
    `commodity_type` STRING COMMENT 'General classification of the commodity being shipped under this Incoterms assignment. Certain commodities may have preferred or restricted Incoterms rules.',
    `contract_reference_number` STRING COMMENT 'Reference to the sales contract or purchase order that specifies the Incoterms rule for this transaction. Provides traceability to the commercial agreement.',
    `cost_responsibility_boundary` STRING COMMENT 'Description of the point up to which the seller bears transportation and logistics costs. Defines the financial split between buyer and seller for freight, handling, and related charges.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipment governed by this Incoterms assignment contains dangerous goods. Dangerous goods may affect Incoterms selection and insurance requirements.',
    `duty_basis_calculation_method` STRING COMMENT 'Indicates the valuation basis used for customs duty calculation. CIF-based Incoterms include cost, insurance, and freight in the customs value; FOB-based rules include only the goods value. Critical for accurate duty and tax assessment.. Valid values are `FOB|CIF|other`',
    `effective_date` DATE COMMENT 'The date from which this Incoterms assignment becomes effective and governs the transaction. Typically aligns with the contract date or shipment booking date.',
    `expiry_date` DATE COMMENT 'The date on which this Incoterms assignment ceases to be effective. Nullable for assignments that remain valid indefinitely or until shipment completion.',
    `export_customs_clearance_party` STRING COMMENT 'Indicates which party is responsible for completing export customs clearance formalities and paying export duties and taxes. Under most Incoterms rules, the seller handles export clearance.. Valid values are `seller|buyer`',
    `import_customs_clearance_party` STRING COMMENT 'Indicates which party is responsible for completing import customs clearance formalities and paying import duties and taxes. Only under DDP does the seller handle import clearance; under all other rules, the buyer is responsible.. Valid values are `seller|buyer`',
    `incoterms_rule_code` STRING COMMENT 'The three-letter code representing the specific Incoterms rule assigned to the transaction. Defines the allocation of costs, risks, and responsibilities between buyer and seller. Examples: EXW (Ex Works), FOB (Free on Board), CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_rule_name` STRING COMMENT 'The full descriptive name of the Incoterms rule. Provides human-readable context for the rule code (e.g., Free on Board, Delivered Duty Paid).',
    `incoterms_version` STRING COMMENT 'The version year of the Incoterms rules being applied. Determines which rule set and interpretations govern the transaction. Most common versions are 2020 and 2010.. Valid values are `2020|2010|2000`',
    `insurance_coverage_level` STRING COMMENT 'The minimum insurance coverage level required under the Incoterms rule. For CIP, Institute Cargo Clauses (A) or equivalent is required; for CIF, Institute Cargo Clauses (C) or equivalent minimum coverage applies.',
    `insurance_obligation_party` STRING COMMENT 'Indicates which party (seller or buyer) is obligated to procure cargo insurance under the assigned Incoterms rule. For CIP and CIF, the seller must insure; for most other rules, insurance is optional or buyers responsibility.. Valid values are `seller|buyer|none`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this Incoterms assignment record was last modified. Provides audit trail for compliance and change management.',
    `named_place` STRING COMMENT 'The specific location or port designated in the Incoterms rule where risk and cost transfer occurs. This is the critical point that defines obligations (e.g., Port of Shanghai, Warehouse in Hamburg, Customer facility in Chicago).',
    `named_place_country_code` STRING COMMENT 'Three-letter ISO country code for the country where the named place is located. Supports geographic analysis and customs compliance.. Valid values are `^[A-Z]{3}$`',
    `named_place_type` STRING COMMENT 'Classification of the named place location type. Indicates whether the named place is a seaport, airport, inland terminal, warehouse, or customer facility.. Valid values are `port|warehouse|facility|address|terminal`',
    `notes` STRING COMMENT 'Free-text field for additional notes, clarifications, or special conditions related to this Incoterms assignment. Supports documentation of exceptions or unique circumstances.',
    `risk_transfer_point` STRING COMMENT 'Detailed description of the exact point at which risk transfers from seller to buyer under the assigned Incoterms rule. Critical for liability determination and insurance coverage decisions.',
    `seller_cost_responsibility` STRING COMMENT 'Detailed enumeration of costs that the seller is responsible for under the assigned Incoterms rule. May include export packing, loading, main carriage, insurance, unloading, and import duties depending on the rule.',
    `seller_party_name` STRING COMMENT 'Name of the seller party in the transaction governed by this Incoterms assignment. Provides business context for liability and cost allocation.',
    `source_system` STRING COMMENT 'The name of the operational system from which this Incoterms assignment record originated (e.g., Descartes Customs, SAP TM, Oracle TMS). Supports data lineage and integration troubleshooting.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this record in the source operational system. Enables traceability and reconciliation between the lakehouse and source systems.',
    `special_handling_requirements` STRING COMMENT 'Any special handling, storage, or transport requirements that may affect the application of the Incoterms rule (e.g., temperature control, hazmat handling, security requirements).',
    `trade_lane` STRING COMMENT 'The origin-destination trade lane for this transaction (e.g., Asia-Europe, Transpacific Eastbound). Supports analysis of Incoterms usage patterns by trade corridor.',
    `transport_mode_applicability` STRING COMMENT 'Indicates whether the assigned Incoterms rule can be used for any mode of transport or is restricted to sea and inland waterway transport only. Rules like FOB, CFR, CIF, FAS are sea/waterway only; rules like EXW, FCA, CPT, CIP, DAP, DPU, DDP apply to any mode.. Valid values are `any|sea_inland_waterway_only`',
    CONSTRAINT pk_incoterms_assignment PRIMARY KEY(`incoterms_assignment_id`)
) COMMENT 'Reference and association record capturing the Incoterms rule assigned to a shipment or trade transaction, governing the allocation of costs, risks, and responsibilities between buyer and seller. Captures Incoterms version (2020/2010), rule code (EXW/FCA/CPT/CIP/DAP/DPP/DDP/FAS/FOB/CFR/CIF), named place or port, risk transfer point, cost responsibility boundary, insurance obligation party, customs clearance responsibility (import/export), and effective date. Supports liability determination and duty basis calculation (CIF vs FOB).';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` (
    `dg_declaration_id` BIGINT COMMENT 'Unique identifier for the dangerous goods declaration record. Primary key.',
    `billing_invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Dangerous goods declaration preparation is a specialized billable service requiring certified expertise. Links DG declaration to invoice line for hazmat handling fee billing—standard surcharge in dang',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DG declarations certified by IATA-certified dangerous goods specialists (employees). IATA/ICAO regulatory requirement. Tracks certification authority and ensures only qualified personnel handle danger',
    `dg_certification_id` BIGINT COMMENT 'Foreign key linking to safety.dg_certification. Business justification: IATA/IMDG regulations require DG declarations to be prepared or reviewed by certified dangerous goods personnel. Logistics operators must validate certification status before accepting DG shipments. R',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Dangerous goods declarations are filed per shipment containing hazmat. Regulatory compliance (IATA/IMDG), carrier acceptance, and customs clearance all require linking DG declaration to consignment. M',
    `declaration_id` BIGINT COMMENT 'Reference to the parent customs declaration to which this dangerous goods declaration is attached.',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Dangerous goods declarations trigger hazmat surcharges based on UN number, hazard class, and packaging. Required for applying regulatory-mandated dangerous goods pricing and ensuring compliance with I',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Dangerous goods declarations must link to the specific transport document (AWB/BOL) they accompany - IATA/IMDG regulatory requirement for hazmat shipment documentation and carrier acceptance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods declaration was approved by the reviewing authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved the dangerous goods declaration.',
    `competent_authority_approval` STRING COMMENT 'Approval number issued by the competent authority for dangerous goods requiring special authorization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods declaration record was first created in the system.',
    `emergency_contact_name` STRING COMMENT 'Name of the person or organization to contact in case of emergency involving the dangerous goods.',
    `emergency_contact_phone` STRING COMMENT '24-hour emergency telephone number for immediate response in case of incident involving the dangerous goods.',
    `excepted_quantity_indicator` BOOLEAN COMMENT 'Indicates whether the dangerous goods are shipped in excepted quantities, subject to minimal regulatory requirements.',
    `exemption_reference` STRING COMMENT 'Reference number of any regulatory exemption or special approval granted for the transport of these dangerous goods.',
    `filing_timestamp` TIMESTAMP COMMENT 'Date and time when the dangerous goods declaration was filed with the customs authority or carrier.',
    `flash_point_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature at which the dangerous goods give off sufficient vapor to form an ignitable mixture with air, measured in degrees Celsius.',
    `gross_quantity` DECIMAL(18,2) COMMENT 'Gross quantity of the dangerous goods including packaging, expressed in the unit of measure specified.',
    `hazard_class` STRING COMMENT 'Primary hazard class of the dangerous goods (1=Explosives, 2=Gases, 3=Flammable Liquids, 4=Flammable Solids, 5=Oxidizing Substances, 6=Toxic Substances, 7=Radioactive Material, 8=Corrosive Substances, 9=Miscellaneous). [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|7|8|9 — 9 candidates stripped; promote to reference product]',
    `hazard_division` STRING COMMENT 'Subdivision within the hazard class providing more specific categorization of the dangerous goods (e.g., 1.1, 1.2, 2.1, 2.2).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dangerous goods declaration record was last updated in the system.',
    `limited_quantity_indicator` BOOLEAN COMMENT 'Indicates whether the dangerous goods are shipped in limited quantities, allowing for relaxed packaging and labeling requirements.',
    `marine_pollutant_indicator` BOOLEAN COMMENT 'Indicates whether the dangerous goods are classified as a marine pollutant under IMDG Code.',
    `net_quantity` DECIMAL(18,2) COMMENT 'Net quantity of the dangerous goods excluding packaging, expressed in the unit of measure specified.',
    `package_count` STRING COMMENT 'Number of packages containing the dangerous goods in this declaration.',
    `packaging_instruction` STRING COMMENT 'Specific packaging instruction number from the applicable dangerous goods regulation (e.g., P001, IBC01, LP01).',
    `packaging_type_code` STRING COMMENT 'Code identifying the type of packaging used for the dangerous goods (e.g., drum, box, cylinder).',
    `packing_group` STRING COMMENT 'Degree of danger presented by the substance (I=Great Danger, II=Medium Danger, III=Minor Danger).. Valid values are `I|II|III`',
    `proper_shipping_name` STRING COMMENT 'Official name of the dangerous goods as specified in the UN Model Regulations, used for identification and documentation.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the net and gross quantities (e.g., kilograms, liters).. Valid values are `kg|L|g|mL|lbs|gal`',
    `regulatory_compliance_status` STRING COMMENT 'Status indicating whether the dangerous goods declaration meets all applicable regulatory requirements for the transport mode and jurisdictions involved.. Valid values are `compliant|non_compliant|pending_review|exemption_granted`',
    `rejection_reason` STRING COMMENT 'Explanation of why the dangerous goods declaration was rejected, if applicable.',
    `segregation_group` STRING COMMENT 'Segregation group code indicating compatibility and stowage requirements for the dangerous goods in relation to other cargo.',
    `shipper_address` STRING COMMENT 'Full address of the shipper or consignor of the dangerous goods.',
    `shipper_certification_date` DATE COMMENT 'Date on which the shipper certified the dangerous goods declaration.',
    `shipper_certification_signature` STRING COMMENT 'Name or digital signature of the authorized person who certified the dangerous goods declaration on behalf of the shipper.',
    `shipper_certification_statement` STRING COMMENT 'Certification statement signed by the shipper declaring that the dangerous goods are properly classified, packaged, marked, and labeled, and in proper condition for transport.',
    `shipper_name` STRING COMMENT 'Name of the shipper or consignor responsible for the dangerous goods shipment.',
    `source_system` STRING COMMENT 'Name of the operational system from which this dangerous goods declaration record originated (e.g., Descartes Customs GTM).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this dangerous goods declaration in the source operational system.',
    `special_provision_codes` STRING COMMENT 'Comma-separated list of special provision codes applicable to the dangerous goods, indicating exceptions or additional requirements.',
    `stowage_category` STRING COMMENT 'Stowage category for ocean transport indicating where the dangerous goods may be stowed on the vessel (A=on deck or under deck, B=on deck only, C=away from living quarters, D=on deck only away from living quarters, E=on deck only in open cargo space).. Valid values are `A|B|C|D|E`',
    `subsidiary_hazard` STRING COMMENT 'Secondary hazard class or division if the dangerous goods present more than one type of hazard.',
    `technical_name` STRING COMMENT 'Chemical or technical name of the dangerous goods, required when the proper shipping name is a generic or N.O.S. (Not Otherwise Specified) entry.',
    `transport_mode` STRING COMMENT 'Mode of transportation for the dangerous goods shipment, determining applicable regulatory framework.. Valid values are `air|ocean|road|rail|multimodal`',
    `un_number` STRING COMMENT 'Four-digit UN identification number assigned to the hazardous substance or article, prefixed with UN.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_dg_declaration PRIMARY KEY(`dg_declaration_id`)
) COMMENT 'Transactional record for dangerous goods (DG) declarations accompanying shipments containing hazardous materials, as required by IMDG Code (ocean), ICAO Technical Instructions (air), and ADR/RID (road/rail). Captures UN number, proper shipping name, hazard class and division, packing group, subsidiary hazard, net quantity, gross quantity, packaging type, emergency contact, shipper certification, transport mode, and regulatory compliance status. Managed in Descartes Customs GTM and linked to the parent declaration and shipment. Critical for customs clearance of restricted commodities.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`valuation` (
    `valuation_id` BIGINT COMMENT 'Unique identifier for the customs valuation determination record. Primary key.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Customs valuation includes CBAM charges (carbon border adjustment) that are offset through carbon credit purchases. Real process: CBAM certificate procurement and surrender linked to customs value adj',
    `declaration_id` BIGINT COMMENT 'Reference to the parent customs declaration for which this valuation determination was performed.',
    `declaration_line_id` BIGINT COMMENT 'Reference to the specific declaration line item being valued. Valuation is performed at the line level for each imported good.',
    `employee_id` BIGINT COMMENT 'Identifier of the customs officer who reviewed and approved the valuation determination.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Customs valuation adjustments trigger GL postings for duty expense corrections. Essential for audit trail, financial statement accuracy, and reconciliation of customs value to landed cost accounting.',
    `valuation_employee_id` BIGINT COMMENT 'Identifier of the user or system that created this valuation determination record.',
    `valuation_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that last modified this valuation determination record.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Net adjustments made by customs authority to the declared valuation. Positive for additions, negative for reductions. Reflects customs examination findings.',
    `assists_value_amount` DECIMAL(18,2) COMMENT 'Value of goods and services supplied by the buyer free of charge or at reduced cost for use in production and sale for export of the imported goods (materials, tools, dies, molds, engineering, development work). Must be added to transaction value per Article 8.1(b).',
    `basis` STRING COMMENT 'Incoterms basis used for customs valuation: CIF (Cost Insurance Freight), FOB (Free On Board), DAP (Delivered At Place), DDP (Delivered Duty Paid), EXW (Ex Works), FCA (Free Carrier). Determines which costs are included in dutiable value.. Valid values are `CIF|FOB|DAP|DDP|EXW|FCA`',
    `cif_value_amount` DECIMAL(18,2) COMMENT 'Total CIF (Cost, Insurance, Freight) value: transaction value plus freight, insurance, and loading charges to the port of importation. Standard basis for customs valuation in many jurisdictions.',
    `commissions_brokerage_amount` DECIMAL(18,2) COMMENT 'Buying commissions and brokerage fees (except buying commissions) included in the transaction value. Selling commissions are not added per Article 8.1(a).',
    `confidence_score` DECIMAL(18,2) COMMENT 'Automated or analyst-assigned confidence score (0-100) indicating the reliability and completeness of the valuation determination. Higher scores indicate greater confidence in the declared values and method.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation determination record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this valuation record (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `customs_authority_code` STRING COMMENT 'Code identifying the customs authority or office that reviewed and accepted this valuation determination.',
    `customs_query_raised_indicator` BOOLEAN COMMENT 'Indicates whether the customs authority raised a query or requested additional documentation regarding this valuation determination.',
    `customs_value_accepted_amount` DECIMAL(18,2) COMMENT 'Final customs value accepted by the customs authority for duty calculation purposes. This is the definitive dutiable value base after all adjustments, additions, and deductions.',
    `declared_transaction_value_amount` DECIMAL(18,2) COMMENT 'The price actually paid or payable for the imported goods when sold for export to the country of importation, as declared by the importer. This is the starting point for Method 1 (Transaction Value) valuation.',
    `deductions_amount` DECIMAL(18,2) COMMENT 'Total value of allowable deductions from the declared transaction value (e.g., post-importation costs, construction/installation charges incurred after importation). Reduces the customs value base.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency transaction values to the importing countrys currency for duty calculation. Rate as of the valuation date.',
    `exchange_rate_source` STRING COMMENT 'Authority or system that provided the exchange rate (e.g., Central Bank, Customs Authority Official Rate, Commercial Bank Rate).',
    `fob_value_amount` DECIMAL(18,2) COMMENT 'FOB (Free On Board) value: transaction value at the point of export, excluding international freight and insurance. Used as alternative valuation basis in some jurisdictions.',
    `freight_charges_amount` DECIMAL(18,2) COMMENT 'Cost of transportation of the imported goods to the port or place of importation. Added to transaction value to determine customs value under CIF (Cost, Insurance, Freight) basis.',
    `insurance_charges_amount` DECIMAL(18,2) COMMENT 'Cost of insurance for the imported goods during international transport. Added to transaction value to determine customs value under CIF basis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation determination record was last updated or modified.',
    `loading_handling_charges_amount` DECIMAL(18,2) COMMENT 'Costs associated with loading, unloading, and handling the goods up to the place of importation. Included in customs value calculation per Article 8.',
    `method_code` STRING COMMENT 'The WCO Customs Valuation Agreement method applied: METHOD_1 (Transaction Value - Article 1), METHOD_2 (Identical Goods - Article 2), METHOD_3 (Similar Goods - Article 3), METHOD_4 (Deductive Value - Article 5), METHOD_5 (Computed Value - Article 6), METHOD_6 (Fallback - Article 7). [ENUM-REF-CANDIDATE: METHOD_1|METHOD_2|METHOD_3|METHOD_4|METHOD_5|METHOD_6 — promote to reference product]. Valid values are `METHOD_1|METHOD_2|METHOD_3|METHOD_4|METHOD_5|METHOD_6`',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the valuation determination, including justification for method selection, explanation of adjustments, or special circumstances.',
    `packing_costs_amount` DECIMAL(18,2) COMMENT 'Cost of containers and packing materials, whether for labor or materials, treated as part of the imported goods. Included in customs value per Article 8.1(a).',
    `proceeds_resale_amount` DECIMAL(18,2) COMMENT 'Value of any part of the proceeds of subsequent resale, disposal, or use of the imported goods that accrues directly or indirectly to the seller. Must be added to transaction value per Article 8.1(d).',
    `query_resolution_date` DATE COMMENT 'Date on which any customs query regarding this valuation was resolved and the valuation was finalized.',
    `reference_number` STRING COMMENT 'External business identifier for this valuation determination, used for tracking and audit purposes across systems and with customs authorities.',
    `relationship_buyer_seller_indicator` BOOLEAN COMMENT 'Indicates whether a relationship exists between the buyer and seller that might influence the transaction value. If true, customs may examine whether the relationship influenced the price.',
    `resale_disposal_restriction_indicator` BOOLEAN COMMENT 'Indicates whether the buyers resale, disposal, or use of the goods is restricted (other than restrictions imposed by law, geographic limitations, or restrictions that do not substantially affect value). May affect acceptability of transaction value.',
    `risk_flag` BOOLEAN COMMENT 'Indicates whether this valuation has been flagged for risk review due to unusual values, method selection, or discrepancies with historical data.',
    `royalties_license_fees_amount` DECIMAL(18,2) COMMENT 'Royalties and license fees related to the imported goods that the buyer must pay as a condition of sale, directly or indirectly. Must be added to transaction value per Article 8.1(c).',
    `ruling_expiry_date` DATE COMMENT 'Date on which the advance valuation ruling expires and is no longer valid for customs valuation purposes.',
    `ruling_issue_date` DATE COMMENT 'Date on which the advance valuation ruling was issued by the customs authority.',
    `ruling_issuing_authority` STRING COMMENT 'Name of the customs authority or office that issued the advance valuation ruling.',
    `ruling_reference` STRING COMMENT 'Reference number of any advance valuation ruling or binding valuation decision issued by the customs authority for this commodity or transaction type.',
    `sale_condition_restrictions_indicator` BOOLEAN COMMENT 'Indicates whether the sale or price is subject to conditions or considerations for which a value cannot be determined. If true, transaction value method may not be acceptable.',
    `supporting_documents_reference` STRING COMMENT 'Reference identifiers or file paths to supporting documentation for this valuation (invoices, contracts, price lists, technical specifications, test reports, certificates).',
    `valuation_date` DATE COMMENT 'Date on which the customs valuation was determined. Typically the date of importation or the date the goods are entered for customs purposes. Determines applicable exchange rates and tariff schedules.',
    `valuation_status` STRING COMMENT 'Current lifecycle status of the valuation determination: draft (prepared but not submitted), submitted (sent to customs), accepted (approved by customs authority), adjusted (modified by customs), rejected (not accepted), under_review (pending customs examination).. Valid values are `draft|submitted|accepted|adjusted|rejected|under_review`',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Master record for customs valuation determinations applied to imported goods, establishing the dutiable value basis for duty calculation. Captures valuation method (transaction value/identical goods/similar goods/deductive/computed/fallback — WTO Customs Valuation Agreement Articles 1-7), declared transaction value, freight charges, insurance charges, royalties, assists, CIF value, FOB value, customs value accepted, currency, exchange rate, valuation date, and any adjustments made by customs authority. Distinct from duty_assessment — valuation establishes the BASE, assessment applies the RATE.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`license_permit` (
    `license_permit_id` BIGINT COMMENT 'Unique identifier for the import/export license or permit record. Primary key for the license_permit product.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Import/export licenses incur processing, filing, and compliance verification fees. Required for billing customers for license-related services and tracking regulatory compliance costs in controlled go',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Applicant for license/permit is a trade party. Adding applicant_trade_party_id FK to trade_party.trade_party_id normalizes the applicant reference. Cardinality: N:1 (many license/permit applications c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Import/export licenses specify authorized suppliers or beneficiaries for controlled goods. Compliance teams validate shipments against licensed supplier lists, requiring supplier master linkage for li',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Import/export licenses are required for controlled goods (dual-use, restricted commodities). License utilization tracking, quota consumption, and shipment release authorization require linking permit ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Import licenses for capital equipment link to asset capitalization. Essential for capex tracking, asset acquisition compliance, and audit trail linking import permits to capitalized assets.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Import/export licenses reviewed by trade compliance officers (employees). Regulatory requirement for controlled goods. Tracks who verified license validity and utilization before shipment release.',
    `application_date` DATE COMMENT 'Date on which the license or permit application was submitted to the issuing authority. Used for tracking processing times and compliance with advance filing requirements.',
    `authorized_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of goods authorized for import or export under this license or permit. Measured in the unit specified in authorized_unit_of_measure.',
    `authorized_unit_of_measure` STRING COMMENT 'Unit of measure for the authorized quantity (e.g., kilograms, pieces, liters, cubic meters). Aligns with customs declaration unit standards.',
    `authorized_value_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value of goods authorized for import or export under this license or permit. Expressed in the currency specified in authorized_value_currency_code.',
    `authorized_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the authorized value amount.. Valid values are `^[A-Z]{3}$`',
    `commodity_description` STRING COMMENT 'Detailed textual description of the goods, products, or materials covered by this license or permit. Provides human-readable context for the authorized commodity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this license or permit record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether the goods covered by this license are classified as dangerous goods (hazmat) requiring special handling and documentation. True if dangerous goods, false otherwise.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code representing the final destination country for export licenses or the importing country for import licenses. Determines jurisdiction-specific licensing requirements.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the license or permit becomes valid and can be used for customs declarations. May differ from issue_date if there is a waiting period.',
    `end_use_description` STRING COMMENT 'Description of the intended end use or purpose of the goods covered by this license. Required for certain controlled items and dual-use export authorizations to ensure compliance with end-use restrictions.',
    `end_user_name` STRING COMMENT 'Legal name of the final end user or consignee of the goods covered by this license. Required for export control compliance and denied party screening.',
    `expiry_date` DATE COMMENT 'Date on which the license or permit expires and can no longer be used for customs declarations. After this date, the authorization is no longer valid unless renewed.',
    `export_control_classification_number` STRING COMMENT 'Alphanumeric code identifying the export control classification for dual-use or controlled technology items. Used for compliance with export control regulations and dual-use export authorizations.',
    `hs_code` STRING COMMENT 'Harmonized System commodity classification code (6, 8, or 10 digits) that identifies the specific goods covered by this license or permit. Used for tariff classification and trade compliance.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'Three-letter Incoterms code defining the delivery terms and liability allocation for the goods covered by this license. Determines responsibility for customs clearance and duty payment. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date on which the license or permit was officially issued by the regulatory authority. Marks the beginning of the authorization period.',
    `issuing_authority` STRING COMMENT 'Name of the government agency, regulatory body, or customs authority that issued the license or permit. Examples include national customs administrations, agriculture departments, or trade ministries.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO country code of the jurisdiction that issued the license or permit.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this license or permit record was most recently updated in the data platform. Used for change tracking and data freshness monitoring.',
    `license_number` STRING COMMENT 'Official license or permit number issued by the regulatory authority. This is the externally-known unique identifier used for customs declarations and trade compliance filings.',
    `license_status` STRING COMMENT 'Current lifecycle status of the license or permit. Indicates whether the authorization is valid and available for use in customs declarations.. Valid values are `active|exhausted|suspended|revoked|expired|pending`',
    `license_type` STRING COMMENT 'Classification of the license or permit based on regulatory purpose. Determines the type of authorization granted for controlled, restricted, or regulated goods movement.. Valid values are `import_license|export_license|dual_use_export_authorization|cites_permit|phytosanitary_certificate|fda_prior_notice`',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or internal annotations related to this license or permit. Used for operational context and compliance documentation.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code representing the country where the goods covered by this license were manufactured, produced, or substantially transformed. Used for preferential trade agreement eligibility and origin-based licensing requirements.. Valid values are `^[A-Z]{3}$`',
    `previous_license_number` STRING COMMENT 'License number of the previous authorization if this is a renewal. Provides audit trail and continuity for renewed licenses.',
    `quota_indicator` BOOLEAN COMMENT 'Flag indicating whether this license or permit is subject to a tariff rate quota (TRQ) or quantitative import/export restriction. True if quota applies, false otherwise.',
    `quota_order_number` STRING COMMENT 'Official quota order number or tariff rate quota (TRQ) reference assigned by the customs authority. Used to track utilization against quota limits.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Available balance of quantity that can still be utilized under this license or permit. Calculated as authorized_quantity minus utilized_quantity.',
    `remaining_value_amount` DECIMAL(18,2) COMMENT 'Available balance of monetary value that can still be utilized under this license or permit. Calculated as authorized_value_amount minus utilized_value_amount.',
    `renewal_indicator` BOOLEAN COMMENT 'Flag indicating whether this license or permit is a renewal of a previously expired authorization. True if renewal, false if original issuance.',
    `restricted_goods_indicator` BOOLEAN COMMENT 'Flag indicating whether the goods covered by this license are classified as restricted or controlled items requiring special authorization. True if restricted, false otherwise.',
    `revocation_date` DATE COMMENT 'Date on which the license or permit was permanently revoked by the issuing authority. Indicates when the authorization was terminated prior to its natural expiry date.',
    `revocation_reason` STRING COMMENT 'Explanation or regulatory justification for the revocation of this license or permit. Provides context for compliance enforcement and audit trail.',
    `source_system` STRING COMMENT 'Name of the operational system from which this license or permit record was extracted. Typically Descartes Customs GTM trade compliance module or equivalent customs management system.',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this license or permit record in the source operational system. Used for data lineage and reconciliation with upstream systems.',
    `special_conditions` STRING COMMENT 'Additional terms, restrictions, or conditions imposed by the issuing authority on the use of this license or permit. May include handling requirements, reporting obligations, or geographic restrictions.',
    `suspension_date` DATE COMMENT 'Date on which the license or permit was suspended by the issuing authority. Indicates when the authorization was temporarily invalidated due to compliance issues or regulatory action.',
    `suspension_reason` STRING COMMENT 'Explanation or regulatory justification for the suspension of this license or permit. Provides context for compliance review and remediation.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying the dangerous goods classification if dangerous_goods_indicator is true. Used for hazmat compliance and transport safety.. Valid values are `^UN[0-9]{4}$`',
    `utilized_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods that have been imported or exported against this license or permit to date. Measured in the same unit as authorized_quantity.',
    `utilized_value_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of goods that have been imported or exported against this license or permit to date. Expressed in the same currency as authorized_value_amount.',
    CONSTRAINT pk_license_permit PRIMARY KEY(`license_permit_id`)
) COMMENT 'Master record for import and export licenses, permits, and authorizations required for controlled, restricted, or regulated goods. Captures license type (import license/export license/dual-use export authorization/CITES permit/phytosanitary certificate/FDA prior notice), issuing authority, license number, commodity covered, HS code, authorized quantity, authorized value, country of origin/destination, issue date, expiry date, utilization balance, and license status (active/exhausted/suspended/revoked). Managed in Descartes Customs GTM trade compliance module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` (
    `drawback_claim_id` BIGINT COMMENT 'Unique identifier for the duty drawback claim record. Primary key.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Approved drawback claims become receivables from customs authorities. Critical for cash forecasting, aging analysis, and reconciliation of duty refunds against claims filed.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Claimant in drawback claim is a trade party. Adding claimant_trade_party_id FK to trade_party.trade_party_id normalizes the claimant reference. Cardinality: N:1 (many drawback claims can have the same',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Drawback claims recover duties on exported goods. Claims require proof of export via consignment documentation. Linking claim to export consignment enables automated duty recovery, audit trail, and cl',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Drawback claims reference the original import declaration to prove duty was paid. Adding import_declaration_id FK to declaration.declaration_id establishes this relationship. Cardinality: N:1 (many dr',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Drawback claim filing services are billable, and successful claims may trigger revenue-share invoicing. Links claim to invoice for drawback service fee billing—standard practice in duty recovery opera',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Drawback claims prepared by licensed customs brokers (employees). CBP regulatory requirement for duty recovery. Tracks individual accountability for claim accuracy and supporting documentation.',
    `accelerated_payment_indicator` BOOLEAN COMMENT 'Flag indicating whether the claim qualifies for accelerated payment processing under CBPs accelerated drawback program.',
    `amendment_count` STRING COMMENT 'Number of times the drawback claim has been amended or resubmitted after initial filing.',
    `approval_date` DATE COMMENT 'Date the customs authority officially approved the drawback claim for payment.',
    `approved_drawback_amount` DECIMAL(18,2) COMMENT 'Final drawback amount approved by customs authority for payment after review and validation.',
    `broker_license_number` STRING COMMENT 'Official license number of the customs broker authorized to file drawback claims.',
    `claim_number` STRING COMMENT 'Official claim number assigned by customs authority (e.g., CBP) for tracking and reference purposes.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the drawback claim in the customs authority review and payment process. [ENUM-REF-CANDIDATE: draft|filed|under_review|approved|paid|denied|withdrawn — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drawback claim record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in the drawback claim.',
    `customs_broker_name` STRING COMMENT 'Name of the licensed customs broker or agent who prepared and filed the drawback claim on behalf of the claimant.',
    `customs_office_code` STRING COMMENT 'Code identifying the customs office or port where the drawback claim was filed and is being processed.',
    `denial_date` DATE COMMENT 'Date the customs authority officially denied the drawback claim.',
    `denial_reason` STRING COMMENT 'Explanation provided by customs authority if the drawback claim was denied, including regulatory citation and corrective action required.',
    `destination_country_code` STRING COMMENT 'ISO 3-letter country code for the final destination of the exported goods.',
    `destruction_date` DATE COMMENT 'Date the goods were destroyed under customs supervision if destruction method was used instead of export.',
    `destruction_indicator` BOOLEAN COMMENT 'Flag indicating whether the goods were destroyed under customs supervision rather than exported, qualifying for drawback under destruction provisions.',
    `drawback_amount_claimed` DECIMAL(18,2) COMMENT 'Total drawback amount being claimed for recovery, calculated per drawback regulations (typically 99% of duty paid).',
    `drawback_type` STRING COMMENT 'Type of drawback claim being filed: manufacturing drawback (goods used in manufacturing exported products), unused merchandise drawback (imported goods exported without use), rejected merchandise drawback (defective goods returned/destroyed), or substitution drawback variants.. Valid values are `manufacturing|unused_merchandise|rejected_merchandise|substitution_unused|substitution_manufacturing`',
    `duty_paid_amount` DECIMAL(18,2) COMMENT 'Total amount of customs duty originally paid on the imported goods at time of import entry.',
    `exported_commodity_description` STRING COMMENT 'Detailed description of the exported goods or manufactured articles qualifying for drawback.',
    `exported_hs_code` STRING COMMENT 'HS tariff classification code for the exported merchandise at time of export.',
    `filing_date` DATE COMMENT 'Date the drawback claim was officially filed with the customs authority.',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the drawback claim was submitted to the customs authority system.',
    `imported_commodity_description` STRING COMMENT 'Detailed description of the imported goods on which duty was originally paid.',
    `imported_hs_code` STRING COMMENT 'HS tariff classification code for the imported merchandise at time of import entry.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or correction to the drawback claim.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this drawback claim record was last updated or modified.',
    `manufacturing_process_description` STRING COMMENT 'Description of the manufacturing process applied to imported goods to create the exported article (required for manufacturing drawback claims).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the drawback claim processing.',
    `payment_date` DATE COMMENT 'Date the approved drawback amount was paid to the claimant by the customs authority.',
    `payment_method` STRING COMMENT 'Method by which the drawback refund was paid to the claimant (ACH, wire transfer, check, or offset against other duties owed).. Valid values are `ach|wire_transfer|check|offset`',
    `quantity_exported` DECIMAL(18,2) COMMENT 'Quantity of goods exported or destroyed that qualifies for drawback recovery.',
    `quantity_imported` DECIMAL(18,2) COMMENT 'Quantity of goods originally imported on which duty was paid.',
    `review_officer_name` STRING COMMENT 'Name of the customs officer assigned to review and validate the drawback claim.',
    `substitution_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a substitution drawback claim where commercially interchangeable merchandise was substituted for the imported goods.',
    `supporting_documents_submitted` STRING COMMENT 'List or summary of supporting documentation submitted with the claim (import entry, export documentation, manufacturing records, certificates of delivery, etc.).',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the imported and exported quantities (e.g., KG, LBS, PCS, LTR).',
    CONSTRAINT pk_drawback_claim PRIMARY KEY(`drawback_claim_id`)
) COMMENT 'Transactional record for duty drawback claims filed to recover customs duties paid on imported goods that are subsequently exported or destroyed. Captures drawback type (manufacturing/unused merchandise/rejected merchandise), claim number, filing date, original import entry number, export entry number, imported commodity, exported commodity, HS codes, duty paid amount, drawback amount claimed, approved drawback amount, claim status (filed/under_review/approved/paid/denied), and payment date. Managed per CBP drawback regulations (19 CFR Part 191) and equivalent national programs.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` (
    `trade_agreement_id` BIGINT COMMENT 'Unique identifier for the trade agreement record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Commercial service agreements often reference trade agreements (USMCA, EU FTAs) to validate preferential rate eligibility, origin compliance requirements, and duty drawback programs. Linking trade agr',
    `employee_id` BIGINT COMMENT 'User identifier of the trade compliance analyst or customs broker who last verified the accuracy of this trade agreement record.',
    `administering_authority` STRING COMMENT 'Name of the international body, secretariat, or national agency responsible for administering and monitoring compliance with the trade agreement (e.g., WTO Secretariat, European Commission DG Trade, USTR).',
    `agreement_code` STRING COMMENT 'Standardized short code or abbreviation for the trade agreement (e.g., USMCA, CPTPP, EU-UK_TCA). Used for system lookups and operational references.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `agreement_name` STRING COMMENT 'Full official name of the trade agreement as published by the administering authority (e.g., United States-Mexico-Canada Agreement, Comprehensive and Progressive Agreement for Trans-Pacific Partnership).',
    `agreement_type` STRING COMMENT 'Classification of the trade agreement. FTA (Free Trade Agreement) = reciprocal tariff elimination; Customs Union = common external tariff; GSP (Generalized System of Preferences) = unilateral preference; EBA (Everything But Arms) = duty-free for LDCs; Bilateral = two parties; Multilateral = three or more parties.. Valid values are `fta|customs_union|gsp|eba|bilateral|multilateral`',
    `amendment_count` STRING COMMENT 'Total number of formal amendments, protocols, or annexes that have modified the original trade agreement since its entry into force. Used to track agreement evolution.',
    `authority_website_url` STRING COMMENT 'Official website URL of the administering authority where the full text of the agreement, tariff schedules, and implementation guidance are published.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$`',
    `certificate_of_origin_format` STRING COMMENT 'Standardized format or form type required for the Certificate of Origin under this agreement (e.g., Form A for GSP, EUR.1 for EU agreements, self-certification for USMCA).. Valid values are `form_a|eur1|movement_certificate|self_certification|invoice_declaration|not_applicable`',
    `certificate_of_origin_required` BOOLEAN COMMENT 'Indicates whether a formal Certificate of Origin document must be presented to customs authorities to claim preferential duty rates under this agreement. True = COO required; False = self-certification or no certification required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade agreement record was first created in the lakehouse. Used for audit trail and data lineage tracking.',
    `cumulation_rules` STRING COMMENT 'Type of origin cumulation permitted under the agreement. Bilateral = materials from partner country count as originating; Diagonal = materials from multiple FTA partners cumulate; Full = all processing in partner countries cumulates; None = no cumulation allowed.. Valid values are `bilateral|diagonal|full|none`',
    `data_source_system` STRING COMMENT 'Name of the source system or database from which this trade agreement record was ingested (e.g., Descartes Customs GTM, WTO RTA Database, internal trade compliance repository).',
    `digital_trade_provisions` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions on e-commerce, cross-border data flows, digital services, and prohibition of data localization requirements. True = digital trade provisions included; False = no digital trade provisions.',
    `dispute_resolution_mechanism` STRING COMMENT 'Summary of the dispute settlement procedures established by the agreement for resolving conflicts between member countries regarding interpretation or implementation (e.g., arbitration panels, joint committees).',
    `effective_date` DATE COMMENT 'Date when the trade agreement entered into force and became legally binding. Used to determine applicability of preferential duty rates.',
    `environmental_provisions` BOOLEAN COMMENT 'Indicates whether the agreement includes commitments on environmental protection, sustainable development, and enforcement of environmental laws. True = environmental provisions included; False = no environmental provisions.',
    `expiry_date` DATE COMMENT 'Date when the trade agreement ceases to be in force. Nullable for open-ended agreements without a fixed termination date.',
    `government_procurement_provisions` BOOLEAN COMMENT 'Indicates whether the agreement opens government procurement markets to suppliers from member countries on a non-discriminatory basis. True = procurement provisions included; False = no procurement provisions.',
    `intellectual_property_provisions` BOOLEAN COMMENT 'Indicates whether the agreement includes chapters or provisions on intellectual property rights protection, enforcement, and cooperation. True = IP provisions included; False = no IP provisions.',
    `investment_provisions` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions on foreign direct investment protection, investor-state dispute settlement, and national treatment for investors. True = investment provisions included; False = no investment provisions.',
    `labor_standards_provisions` BOOLEAN COMMENT 'Indicates whether the agreement includes enforceable labor rights and working conditions standards aligned with International Labour Organization (ILO) conventions. True = labor provisions included; False = no labor provisions.',
    `last_amendment_date` DATE COMMENT 'Date when the most recent amendment, protocol, or annex to the trade agreement entered into force.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade agreement record was most recently updated in the lakehouse. Used for change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review or assessment of the trade agreement by member countries or the administering authority.',
    `last_verified_date` DATE COMMENT 'Date when the trade agreement details were last verified against official sources by Transport Shippings trade compliance team. Used to ensure data accuracy for preferential duty rate calculations.',
    `mutual_recognition_agreements` STRING COMMENT 'Description of any mutual recognition agreements for conformity assessment, product standards, professional qualifications, or Authorized Economic Operator (AEO) programs included in or linked to the trade agreement.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review or renegotiation of the trade agreement. Used for compliance planning and tariff rate updates in Descartes Customs GTM.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, implementation guidance, or special considerations relevant to Transport Shippings use of this trade agreement in customs declarations and duty calculations.',
    `participating_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing all member countries or customs territories party to the agreement (e.g., USA,CAN,MEX for USMCA).',
    `product_coverage_scope` STRING COMMENT 'Defines the breadth of goods and services covered by the trade agreement. All Goods = comprehensive coverage; Industrial Goods Only = excludes agriculture; Agricultural Excluded = industrial focus; Services Included = covers trade in services; Limited Product List = specific HS Codes only.. Valid values are `all_goods|industrial_goods_only|agricultural_excluded|services_included|limited_product_list`',
    `publication_reference` STRING COMMENT 'Official publication citation or document reference number for the trade agreement text (e.g., treaty series number, official journal citation, UN registration number).',
    `quota_provisions` STRING COMMENT 'Description of any tariff-rate quotas (TRQs) or quantitative restrictions included in the agreement. Specifies product categories subject to quota limits and the preferential in-quota duty rates.',
    `review_cycle_years` STRING COMMENT 'Number of years between scheduled reviews or renegotiations of the trade agreement by member countries. Used to track when agreement terms may be updated or modernized.',
    `rules_of_origin_criteria` STRING COMMENT 'Summary of the origin determination rules required to qualify for preferential treatment under this agreement (e.g., change in tariff classification, regional value content percentage, specific processing requirements). Full rules are maintained in tariff_rate product.',
    `safeguard_measures` STRING COMMENT 'Summary of bilateral safeguard provisions that allow temporary suspension or modification of preferential treatment if imports cause or threaten serious injury to domestic industry.',
    `signature_date` DATE COMMENT 'Date when the trade agreement was formally signed by participating parties, prior to ratification and entry into force.',
    `superseded_by_agreement_code` STRING COMMENT 'Agreement code of the successor trade agreement that replaced this agreement, if applicable. Used to maintain historical lineage when agreements are renegotiated or replaced (e.g., NAFTA superseded by USMCA).',
    `tariff_elimination_schedule` STRING COMMENT 'Classification of the duty reduction timeline under the agreement. Immediate = zero duty on entry into force; Staged = phased reduction over specified years; Partial = some products excluded; Product Specific = varies by HS Code.. Valid values are `immediate|staged_5yr|staged_10yr|staged_15yr|partial|product_specific`',
    `trade_agreement_status` STRING COMMENT 'Current lifecycle status of the trade agreement. In Force = active and applicable; Under Negotiation = being drafted; Signed Not Ratified = awaiting legislative approval; Suspended = temporarily inactive; Terminated = ended by parties; Expired = reached end date.. Valid values are `in_force|under_negotiation|signed_not_ratified|suspended|terminated|expired`',
    `trade_facilitation_provisions` STRING COMMENT 'Description of customs procedures simplification, advance rulings, single window systems, and other trade facilitation commitments included in the agreement to reduce border clearance times and costs.',
    `wto_notification_number` STRING COMMENT 'WTO Regional Trade Agreement notification number assigned when the agreement was notified to the WTO under GATT Article XXIV or GATS Article V (e.g., WT/REG123/N/1).. Valid values are `^[A-Z]{2,4}/[0-9]{1,5}$`',
    CONSTRAINT pk_trade_agreement PRIMARY KEY(`trade_agreement_id`)
) COMMENT 'Reference master for free trade agreements (FTAs), preferential trade arrangements, and customs unions applicable to Transport Shippings trade lanes. Captures agreement name, agreement type (FTA/customs union/GSP/EBA/bilateral), participating countries, effective date, expiry date, key provisions (tariff elimination schedule, rules of origin criteria, cumulation rules), administering authority, and agreement status (in_force/under_renegotiation/suspended). Enables automated preferential duty rate lookup and origin criterion validation in Descartes Customs GTM.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`customs_event` (
    `customs_event_id` BIGINT COMMENT 'Unique identifier for the customs event record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this customs event. Enables cross-domain traceability between customs and shipment operations.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration that this event pertains to. Links the event to the parent declaration lifecycle.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customs events recorded by operations staff (employees). Audit trail requirement for status changes, holds, releases. Tracks who performed the action for accountability and dispute resolution.',
    `amendment_sequence_number` STRING COMMENT 'Sequential number indicating the order of amendments to the customs declaration. Used to track the version history when this event represents an amendment.',
    `appeal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this event represents an appeal or dispute of a previous customs decision. True if this is an appeal event, false otherwise.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process, if applicable. Indicates whether the appeal was approved, denied, partially approved, or is still pending.. Valid values are `APPROVED|DENIED|PARTIALLY_APPROVED|PENDING`',
    `compliance_program_code` STRING COMMENT 'Code identifying any trade compliance program applicable to this customs event, such as C-TPAT, AEO, or other trusted trader programs. Affects processing priority and examination rates.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this customs event record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `customs_authority_code` STRING COMMENT 'Standardized code identifying the customs authority or agency that triggered or recorded this event. Typically an ISO country code or agency-specific identifier.',
    `customs_office_code` STRING COMMENT 'Code identifying the specific customs office or port location where the event was processed. Used for geographic and jurisdictional tracking.',
    `document_reference_number` STRING COMMENT 'Reference number of any supporting document associated with this customs event, such as a certificate, permit, or inspection report.',
    `event_description` STRING COMMENT 'Detailed textual description of the customs event. Provides human-readable context about what occurred, including any specific instructions or notes from the customs authority.',
    `event_source` STRING COMMENT 'The originating system or channel that generated this customs event. Indicates whether the event was received via customs authority EDI, Descartes GTM system, manual broker entry, or other integration channel. [ENUM-REF-CANDIDATE: CUSTOMS_EDI|DESCARTES_GTM|MANUAL_ENTRY|AMS|ISF|BROKER_PORTAL|API — 7 candidates stripped; promote to reference product]',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customs event occurred in the real world. This is the business event time, distinct from system audit timestamps.',
    `examination_type` STRING COMMENT 'Type of customs examination conducted during this event, if applicable. Indicates whether the event involved physical inspection, document review, x-ray scanning, canine inspection, or no examination.. Valid values are `PHYSICAL|DOCUMENTARY|X_RAY|CANINE|NONE`',
    `hold_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this event resulted in a customs hold or detention of the shipment. True if the shipment was placed on hold, false otherwise.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when a customs hold was released, if applicable. Null if no hold was placed or if the hold remains active.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this customs event record was last updated in the data platform. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or observations related to this customs event. Used for capturing context not covered by structured fields.',
    `notification_sent_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether an automated notification was sent to relevant parties (importer, broker, customer) about this customs event. True if notification was sent, false otherwise.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the notification about this customs event was sent to relevant parties. Null if no notification was sent.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of any penalty or fine assessed during this customs event. Null if no penalty was applied.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount. Null if no penalty was applied.. Valid values are `^[A-Z]{3}$`',
    `penalty_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this event resulted in a penalty, fine, or sanction being assessed. True if a penalty was applied, false otherwise.',
    `previous_declaration_status` STRING COMMENT 'The status of the customs declaration immediately before this event occurred. Enables state transition tracking and audit trail reconstruction. [ENUM-REF-CANDIDATE: DRAFT|SUBMITTED|ACCEPTED|UNDER_EXAMINATION|RELEASED|REJECTED|AMENDED|CLOSED — 8 candidates stripped; promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason or trigger for this customs event. Examples include random examination, risk-based selection, documentation discrepancy, or routine processing.',
    `reason_description` STRING COMMENT 'Detailed textual explanation of the reason for this customs event. Supplements the reason code with additional context.',
    `reference_number` STRING COMMENT 'External reference number assigned by the customs authority or system for this specific event. Used for audit trail and dispute resolution.',
    `responsible_party_identifier` STRING COMMENT 'Unique identifier for the responsible party, such as a customs officer badge number, broker license number, or employee ID.',
    `responsible_party_name` STRING COMMENT 'Name of the individual, organization, or role responsible for initiating or handling this customs event. May be a customs officer, broker, or internal staff member.',
    `resulting_declaration_status` STRING COMMENT 'The new status of the customs declaration after this event was processed. Captures the state transition outcome. [ENUM-REF-CANDIDATE: DRAFT|SUBMITTED|ACCEPTED|UNDER_EXAMINATION|RELEASED|REJECTED|AMENDED|CLOSED — 8 candidates stripped; promote to reference product]',
    `risk_category` STRING COMMENT 'Categorical risk classification assigned to this customs event. Used for prioritization and resource allocation in customs processing.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk assessment score assigned to this customs event by the customs authority or internal risk engine. Higher scores indicate higher risk requiring additional scrutiny.',
    `sla_compliance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this customs event was completed within the defined SLA timeframe. True if compliant, false if SLA was breached.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'The target date and time by which this customs event should have been completed according to service level agreements or regulatory requirements. Used for SLA measurement and performance tracking.',
    `type_code` STRING COMMENT 'Standardized code representing the type of customs lifecycle event. Defines the nature of the milestone (e.g., submission, acceptance, examination notification, release, amendment, rejection, appeal, closure). [ENUM-REF-CANDIDATE: SUBMISSION|ACCEPTANCE|EXAMINATION|RELEASE|AMENDMENT|REJECTION|APPEAL|CLOSURE|HOLD|CLEARANCE — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_customs_event PRIMARY KEY(`customs_event_id`)
) COMMENT 'Transactional event log capturing all significant customs lifecycle milestones for a declaration or filing — submission, acceptance, examination notification, release, amendment, rejection, appeal, and closure. Captures event type, event timestamp, event source (customs authority EDI/Descartes GTM/manual), event description, responsible party, and resulting declaration status change. Provides a complete audit trail of customs processing history for compliance reporting, SLA measurement, and dispute resolution. Distinct from customs_hold which captures only examination/detention events.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`program_participation` (
    `program_participation_id` BIGINT COMMENT 'Unique identifier for this specific enrollment of a company code in a compliance program',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to the legal entity/company code that is enrolled in the compliance program',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program (C-TPAT, AEO, etc.) in which the legal entity participates',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for managing this company codes compliance with this program. Identified in detection phase relationship_data.',
    `audit_frequency` STRING COMMENT 'Audit frequency in months for this specific company codes participation in this program. May vary by entity based on risk profile. Identified in detection phase relationship_data.',
    `certificate_number` STRING COMMENT 'Entity-specific certificate number issued for this company codes participation in this program',
    `certification_status` STRING COMMENT 'Current certification status for this company codes participation in this program. Identified in detection phase relationship_data.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Compliance score or rating for this company codes performance in this program. Identified in detection phase relationship_data.',
    `effective_date` DATE COMMENT 'Date from which this company codes program benefits become active',
    `enrollment_date` DATE COMMENT 'Date when this specific company code enrolled in this compliance program. Identified in detection phase relationship_data.',
    `expiry_date` DATE COMMENT 'Date when this company codes certification in this program expires',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit for this company codes compliance with this program. Identified in detection phase relationship_data.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next compliance audit for this company code in this program',
    `participation_notes` STRING COMMENT 'Free-text notes specific to this company codes participation in this program',
    `renewal_status` STRING COMMENT 'Current status of renewal process for this company codes participation',
    CONSTRAINT pk_program_participation PRIMARY KEY(`program_participation_id`)
) COMMENT 'This association product represents the participation relationship between compliance_program and company_code. It captures the enrollment of legal entities in trade compliance programs (C-TPAT, AEO, ISO 28000) with entity-specific certification status, audit schedules, and compliance metrics. Each record links one compliance_program to one company_code with attributes that exist only in the context of this specific enrollment.. Existence Justification: In Transport Shippings global logistics operations, a single compliance program (e.g., C-TPAT, AEO) can cover multiple legal entities across different countries, and each legal entity typically participates in multiple compliance programs based on their operational jurisdictions and trade lanes. The business actively manages these enrollments as distinct operational records, tracking entity-specific certification status, audit schedules, compliance scores, and responsible employees for each program-entity combination.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` (
    `trade_agreement_utilization_id` BIGINT COMMENT 'Unique surrogate identifier for the customer account trade agreement utilization record. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the Transport Shipping customs specialist authorized to sign Certificates of Origin and preference declarations for this customer-agreement combination. Required for audit trail and compliance documentation.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer account that is utilizing the trade agreement for preferential duty treatment',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to the trade agreement being utilized by the customer account',
    `annual_duty_savings` DECIMAL(18,2) COMMENT 'Total customs duty amount saved in the current calendar year by applying preferential rates under this trade agreement for this customer account. Calculated as sum of (standard_duty_amount - preferential_duty_amount) across all shipments. Expressed in USD equivalent.',
    `certificate_count` BIGINT COMMENT 'Total number of Certificates of Origin issued for this customer account under this trade agreement in the current calendar year. Used to track documentation volume and compliance activity.',
    `compliance_audit_status` STRING COMMENT 'Result of the most recent customs compliance audit for this customer-agreement utilization relationship. compliant = no issues found; minor_findings = documentation gaps that do not affect duty treatment; major_findings = issues requiring corrective action; non_compliant = preference claims suspended pending remediation; not_audited = no audit conducted yet.',
    `first_utilization_date` DATE COMMENT 'Calendar date when this customer account first claimed preferential duty treatment under this trade agreement. Marks the start of the utilization relationship.',
    `last_audit_date` DATE COMMENT 'Calendar date of the most recent compliance audit conducted for this customer account trade agreement utilization relationship. Null if never audited.',
    `last_claim_date` DATE COMMENT 'Calendar date of the most recent shipment for which this customer account claimed preferential duty treatment under this trade agreement. Used to identify dormant utilization relationships and trigger re-engagement campaigns.',
    `notes` STRING COMMENT 'Free-text field for customs team to record special instructions, restrictions, or observations specific to this customer account trade agreement utilization relationship (e.g., specific HS code exclusions, product-specific origin requirements, customer-requested documentation preferences).',
    `preference_eligibility_status` STRING COMMENT 'Current eligibility status of the customer account to claim preferential duty rates under this trade agreement. eligible = account meets all origin and compliance criteria; conditionally_eligible = eligible subject to specific product restrictions or documentation requirements; ineligible = account does not meet agreement criteria; under_review = eligibility assessment in progress; suspended = eligibility temporarily revoked due to compliance issues.',
    `total_shipments_claimed` BIGINT COMMENT 'Cumulative count of shipments for which this customer account has claimed preferential duty treatment under this trade agreement since first utilization date.',
    `utilization_rate` DECIMAL(18,2) COMMENT 'Percentage of eligible shipments under this customer-agreement combination for which preferential duty treatment was actually claimed. Calculated as (shipments_with_preference_claimed / total_eligible_shipments) * 100. Used to measure FTA adoption and identify optimization opportunities.',
    CONSTRAINT pk_trade_agreement_utilization PRIMARY KEY(`trade_agreement_utilization_id`)
) COMMENT 'This association product represents the operational utilization relationship between customer accounts and trade agreements in the Transport Shipping logistics network. It captures the active use of preferential trade agreements by customer accounts across their trade lanes, tracking duty savings realized, certificate of origin issuance, preference claim history, and eligibility status. Each record links one customer account to one trade agreement with metrics and operational data that exist only in the context of this specific account-agreement utilization relationship.. Existence Justification: In Transport Shipping logistics operations, customer accounts actively utilize multiple trade agreements across their diverse trade lanes (e.g., a global shipper uses USMCA for US-Mexico shipments, CPTPP for Asia-Pacific routes, and EU-UK TCA for European lanes). Conversely, each trade agreement is utilized by multiple customer accounts. The business actively manages this many-to-many relationship through customs operations, tracking duty savings, preference utilization rates, certificate of origin issuance, and compliance status for each unique customer-agreement combination.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` (
    `trade_transaction_id` BIGINT COMMENT 'Primary key for trade_transaction',
    `agent_id` BIGINT COMMENT 'Identifier of the customs broker handling the transaction.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Trade transaction has customs_declaration_number as a denormalized string. Adding proper FK to declaration normalizes this reference. customs_declaration_number becomes redundant as it can be retrieve',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Trade transaction has party_id BIGINT with no FK defined. Adding trade_party_id FK properly links to the trade_party master. party_id becomes redundant. The trade_party table is the master for all par',
    `amended_trade_transaction_id` BIGINT COMMENT 'Self-referencing FK on trade_transaction (amended_trade_transaction_id)',
    `actual_arrival_date` DATE COMMENT 'Actual date the shipment arrived at the destination.',
    `aeo_status` STRING COMMENT 'Authorized Economic Operator status of the party.',
    `clearance_date` DATE COMMENT 'Date on which customs clearance was completed.',
    `clearance_status` STRING COMMENT 'Current customs clearance status of the transaction.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the transaction passed all compliance checks (true = compliant).',
    `container_number` STRING COMMENT 'Standard 11‑character container identification code.',
    `ctp_at_compliance` BOOLEAN COMMENT 'Indicates participation in the C‑TPAT secure supply‑chain program.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.',
    `denied_party_flag` BOOLEAN COMMENT 'True if the counter‑party appears on a denied‑party list.',
    `destination_country` STRING COMMENT 'Three‑letter country code of the final destination.',
    `duty_amount` DECIMAL(18,2) COMMENT 'Customs duty assessed on the transaction.',
    `duty_rate` DECIMAL(18,2) COMMENT 'Duty rate expressed as a percentage of the goods value.',
    `entry_port` STRING COMMENT 'Port or airport code where goods entered the customs jurisdiction.',
    `estimated_arrival_date` DATE COMMENT 'Planned date of arrival at the destination port.',
    `exit_port` STRING COMMENT 'Port or airport code where goods exited the customs jurisdiction.',
    `filing_type` STRING COMMENT 'Category of customs filing (e.g., ISF, AMS, entry, export).',
    `ftz_indicator` BOOLEAN COMMENT 'True if the transaction involves a free‑trade‑zone facility.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the transaction before taxes, duties, and fees.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the shipment contains hazardous materials requiring special handling.',
    `hs_code` STRING COMMENT 'International commodity classification code for the goods.',
    `incoterm` STRING COMMENT 'International commercial term defining delivery responsibilities.',
    `mode_of_transport` STRING COMMENT 'Primary transportation mode used for the shipment.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, duties, and fees are applied.',
    `number_of_items` STRING COMMENT 'Count of individual items or packages in the shipment.',
    `origin_country` STRING COMMENT 'Three‑letter country code where the goods originated.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade transaction record was first captured in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this trade transaction record.',
    `release_date` DATE COMMENT 'Date when goods were released from customs custody.',
    `special_handling_instructions` STRING COMMENT 'Free‑text field for any additional handling or compliance instructions.',
    `tariff_code` STRING COMMENT 'Code referencing the applicable tariff schedule.',
    `tariff_description` STRING COMMENT 'Human‑readable description of the tariff applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax (e.g., VAT, GST) applied to the transaction.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate applied to the transaction, expressed as a percentage.',
    `trade_type` STRING COMMENT 'Classification of the transaction as import, export, re‑export, or transit.',
    `transaction_number` STRING COMMENT 'External business identifier assigned to the trade transaction (e.g., customs filing reference).',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the trade transaction within the customs workflow.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp when the trade transaction was initially created or filed with customs.',
    `vessel_name` STRING COMMENT 'Name of the vessel carrying the cargo (if sea transport).',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total cargo volume in cubic meters.',
    `voyage_number` STRING COMMENT 'Identifier for the specific voyage or flight.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_trade_transaction PRIMARY KEY(`trade_transaction_id`)
) COMMENT 'Master reference table for trade_transaction. Referenced by trade_transaction_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_superseded_by_tariff_rate_id` FOREIGN KEY (`superseded_by_tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_original_assessment_duty_assessment_id` FOREIGN KEY (`original_assessment_duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ADD CONSTRAINT `fk_customs_compliance_audit_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_ftz_admission_id` FOREIGN KEY (`ftz_admission_id`) REFERENCES `transport_shipping_ecm`.`customs`.`ftz_admission`(`ftz_admission_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ADD CONSTRAINT `fk_customs_ftz_inventory_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ADD CONSTRAINT `fk_customs_ftz_admission_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ADD CONSTRAINT `fk_customs_ruling_request_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ADD CONSTRAINT `fk_customs_ruling_request_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_trade_transaction_id` FOREIGN KEY (`trade_transaction_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_transaction`(`trade_transaction_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ADD CONSTRAINT `fk_customs_dg_declaration_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ADD CONSTRAINT `fk_customs_valuation_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ADD CONSTRAINT `fk_customs_drawback_claim_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ADD CONSTRAINT `fk_customs_customs_event_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ADD CONSTRAINT `fk_customs_program_participation_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ADD CONSTRAINT `fk_customs_trade_agreement_utilization_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ADD CONSTRAINT `fk_customs_trade_transaction_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ADD CONSTRAINT `fk_customs_trade_transaction_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ADD CONSTRAINT `fk_customs_trade_transaction_amended_trade_transaction_id` FOREIGN KEY (`amended_trade_transaction_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_transaction`(`trade_transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`customs` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`customs` SET TAGS ('dbx_domain' = 'customs');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_business_glossary_term' = 'Country of Export');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `customs_authority` SET TAGS ('dbx_business_glossary_term' = 'Customs Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `customs_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Procedure Code (CPC)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declarant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Declarant Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declarant_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declarant_name` SET TAGS ('dbx_business_glossary_term' = 'Declarant Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declarant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|re_export|temporary_admission|inward_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `duty_tax_currency` SET TAGS ('dbx_business_glossary_term' = 'Duty and Tax Currency');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `duty_tax_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `ftz_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Entry Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'none|document_review|x_ray|physical_exam|full_exam|random_sample');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Duty Payment Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `port_of_exit` SET TAGS ('dbx_business_glossary_term' = 'Port of Exit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `total_declared_value` SET TAGS ('dbx_business_glossary_term' = 'Total Declared Value');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `total_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `trade_agreement` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Class Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `license_permit_id` SET TAGS ('dbx_business_glossary_term' = 'License Permit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `origin_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `antidumping_case_number` SET TAGS ('dbx_business_glossary_term' = 'Antidumping Case Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `antidumping_indicator` SET TAGS ('dbx_business_glossary_term' = 'Antidumping Duty Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `customs_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `customs_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `excise_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Excise Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `ftz_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Entry Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `ftz_indicator` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `package_type_code` SET TAGS ('dbx_business_glossary_term' = 'Package Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `package_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `preference_indicator` SET TAGS ('dbx_business_glossary_term' = 'Preferential Treatment Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `preference_program_code` SET TAGS ('dbx_business_glossary_term' = 'Preference Program Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `preference_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `prohibited_restricted_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prohibited or Restricted Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Declared Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `quota_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quota Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `quota_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `statistical_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Statistical Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `statistical_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Statistical Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `statistical_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `valuation_method_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Valuation Method Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `valuation_method_code` SET TAGS ('dbx_value_regex' = '^[1-6]$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `vat_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Classification ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Classifier Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `commodity_rate_class_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Rate Class Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `binding_ruling_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Binding Ruling Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `binding_ruling_indicator` SET TAGS ('dbx_business_glossary_term' = 'Binding Ruling Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `binding_ruling_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Binding Ruling Issue Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `binding_ruling_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Binding Ruling Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `binding_ruling_reference` SET TAGS ('dbx_business_glossary_term' = 'Binding Ruling Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Classification Confidence Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_method` SET TAGS ('dbx_business_glossary_term' = 'Classification Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_method` SET TAGS ('dbx_value_regex' = 'automated|manual|binding_ruling|third_party_ruling|customer_declared');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_notes` SET TAGS ('dbx_business_glossary_term' = 'Classification Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `classifier_license_number` SET TAGS ('dbx_business_glossary_term' = 'Classifier License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `country_of_classification` SET TAGS ('dbx_business_glossary_term' = 'Country of Classification');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `country_of_classification` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `duty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `excise_tax_applicable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Excise Tax Applicable Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `export_control_classification_number` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_10_digit` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code 10-Digit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_10_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_6_digit` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code 6-Digit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_6_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_8_digit` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code 8-Digit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_code_8_digit` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `import_license_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Import License Required Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `preferential_duty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `record_version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `restricted_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Restricted Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `review_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Review Required Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `vat_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `superseded_by_tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `anti_dumping_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping Duty Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `countervailing_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `duty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Duty Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `duty_calculation_method` SET TAGS ('dbx_value_regex' = 'ad_valorem|specific|compound|mixed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `excise_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `exporting_country_code` SET TAGS ('dbx_business_glossary_term' = 'Exporting Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `exporting_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `gst_rate` SET TAGS ('dbx_business_glossary_term' = 'Goods and Services Tax (GST) Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `importing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Importing Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `importing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `mfn_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Most Favoured Nation (MFN) Duty Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `origin_criteria` SET TAGS ('dbx_business_glossary_term' = 'Origin Criteria');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `preferential_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `quota_order_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Order Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `rate_source_authority` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|preferential|suspended|quota|seasonal|provisional');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `seasonal_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `specific_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Specific Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_quota_flag` SET TAGS ('dbx_business_glossary_term' = 'Tariff Quota Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `vat_rate` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `original_assessment_duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Assessment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `charge_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Charge Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `anti_dumping_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid|post_audit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assessment Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'estimated|assessed|final|disputed|adjusted|cancelled');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'CIF|FOB|DDP|DAP|EXW|FCA');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `countervailing_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty (CVD) Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin (ISO 3166)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `customs_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `dispute_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filed Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'consumption|warehouse|temporary|ftz|carnet');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `excise_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Excise Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `harbor_maintenance_fee` SET TAGS ('dbx_business_glossary_term' = 'Harbor Maintenance Fee (HMF)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `import_export_indicator` SET TAGS ('dbx_business_glossary_term' = 'Import or Export Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `import_export_indicator` SET TAGS ('dbx_value_regex' = 'import|export');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `merchandise_processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Processing Fee (MPF)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `other_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Fees Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|overdue|waived');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,6}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `preferential_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `preferential_tariff_program` SET TAGS ('dbx_business_glossary_term' = 'Preferential Tariff Program');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Tariff Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `total_duty_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Duty and Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Filing ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Unlading Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `bond_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `bond_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'single_transaction|continuous');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `buyer_address` SET TAGS ('dbx_business_glossary_term' = 'Buyer Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `buyer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `buyer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `buyer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `cbp_rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'US Customs and Border Protection (CBP) Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `cbp_response_date` SET TAGS ('dbx_business_glossary_term' = 'US Customs and Border Protection (CBP) Response Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `cbp_response_status` SET TAGS ('dbx_business_glossary_term' = 'US Customs and Border Protection (CBP) Response Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `cbp_response_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|amendment_required|pending_review');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consolidator_address` SET TAGS ('dbx_business_glossary_term' = 'Consolidator (Stuffer) Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consolidator_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consolidator_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consolidator_name` SET TAGS ('dbx_business_glossary_term' = 'Consolidator (Stuffer) Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consolidator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `container_stuffing_location` SET TAGS ('dbx_business_glossary_term' = 'Container Stuffing Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Arrival Date (ETA)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Filing Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|withdrawn');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Filing Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'ISF-10|ISF-5');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `htsus_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule of the United States (HTSUS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `htsus_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `isf_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `isf_transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `penalty_reason` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `penalty_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Risk Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `port_of_lading` SET TAGS ('dbx_business_glossary_term' = 'Port of Lading');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `port_of_lading` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `seller_address` SET TAGS ('dbx_business_glossary_term' = 'Seller Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `seller_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `seller_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `seller_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `ship_to_party_address` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `ship_to_party_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `ship_to_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `ship_to_party_name` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `ship_to_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `voyage_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `ams_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Manifest System (AMS) Filing ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Unlading Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `ams_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Automated Manifest System (AMS) Transaction Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `bond_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `bond_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Bond Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `bond_type` SET TAGS ('dbx_value_regex' = 'single|continuous|none');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `broker_filer_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Filer Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `cbp_hold_indicator` SET TAGS ('dbx_business_glossary_term' = 'Customs and Border Protection (CBP) Hold Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `container_count` SET TAGS ('dbx_business_glossary_term' = 'Container Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `conveyance_name` SET TAGS ('dbx_business_glossary_term' = 'Conveyance Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `exam_location` SET TAGS ('dbx_business_glossary_term' = 'Examination Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `exam_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `exam_type` SET TAGS ('dbx_value_regex' = 'none|vacis|cet|tailgate|intensive');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'AMS Filing Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended|cancelled');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'AMS Filing Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'AMS Filing Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'ocean|air|rail|truck');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `isf_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `piece_count` SET TAGS ('dbx_business_glossary_term' = 'Piece Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `port_of_lading_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Lading Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `port_of_lading_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'CBP Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'CBP Release Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Organization (IMO) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `vessel_imo_number` SET TAGS ('dbx_value_regex' = '^IMO[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `vessel_name` SET TAGS ('dbx_business_glossary_term' = 'Vessel Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `denied_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst User Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `analyst_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Outcome');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `analyst_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|escalated|pending_review');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `analyst_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Required Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `analyst_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `compliance_program` SET TAGS ('dbx_value_regex' = 'C-TPAT|AEO|PIP|CSA|SES');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|tier1|tier2|tier3|executive');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|false_positive');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `matched_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `matched_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `matched_entity_program` SET TAGS ('dbx_business_glossary_term' = 'Matched Entity Program');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `matched_list_name` SET TAGS ('dbx_business_glossary_term' = 'Matched List Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `override_justification` SET TAGS ('dbx_business_glossary_term' = 'Override Justification');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `override_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Engine Version');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_list_sources` SET TAGS ('dbx_business_glossary_term' = 'Screening List Sources');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_value_regex' = '^DPS-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Rule Set Version');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Run Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` SET TAGS ('dbx_subdomain' = 'party_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Verified By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `aeo_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `aeo_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `aeo_status` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `aeo_status` SET TAGS ('dbx_value_regex' = 'certified|pending|suspended|revoked|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `cbp_importer_number` SET TAGS ('dbx_business_glossary_term' = 'US Customs and Border Protection (CBP) Importer Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `cbp_importer_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `cbp_importer_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Address Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `country_of_establishment` SET TAGS ('dbx_business_glossary_term' = 'Country of Establishment');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `country_of_establishment` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `ctpat_status` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `ctpat_svi_number` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Supply Chain Security Validation Identifier (SVI) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `ctpat_svi_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `customs_broker_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|under_review|blocked');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `eori_number` SET TAGS ('dbx_business_glossary_term' = 'Economic Operators Registration and Identification (EORI) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `eori_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{1,15}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `eori_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `eori_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `ftz_operator_number` SET TAGS ('dbx_business_glossary_term' = 'Free Trade Zone (FTZ) Operator Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `ftz_operator_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `incoterms_preference` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Preference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired|not_required');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `last_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Last Denied Party Screening Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `lei_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `next_screening_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Denied Party Screening Due Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Onboarding Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|suspended|blocked|inactive|pending_verification');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code or ZIP Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Transaction Currency');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Risk Classification');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name or DBA (Doing Business As)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Port Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `spot_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Spot Quote Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `actual_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `aeo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assigned_country_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assigned_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|filed|released|cancelled|on_hold');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|temporary_admission|re_export');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `average_release_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Release Time (Hours)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Email');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Broker Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Broker Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Broker Fee Currency');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `brokerage_office_code` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `brokerage_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `brokerage_office_location` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Office Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `ctpat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `estimated_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `estimated_release_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Release Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `filing_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Filing Accuracy Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|credit_account');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `poa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `poa_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `power_of_attorney_reference` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `power_of_attorney_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `previous_broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Previous Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `previous_broker_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `service_level_agreement` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `specialization_codes` SET TAGS ('dbx_business_glossary_term' = 'Broker Specialization Codes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `total_declarations_handled` SET TAGS ('dbx_business_glossary_term' = 'Total Declarations Handled');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `annual_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Reporting Required Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Authority Contact Email');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Authority Contact Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Authority Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Authority Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `certifying_authority` SET TAGS ('dbx_business_glossary_term' = 'Certifying Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `compliance_obligations_description` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Email');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Phone');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `dedicated_account_manager_flag` SET TAGS ('dbx_business_glossary_term' = 'Dedicated Account Manager Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `expedited_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Release Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `last_self_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Self-Assessment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `membership_tier` SET TAGS ('dbx_business_glossary_term' = 'Membership Tier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `mutual_recognition_countries` SET TAGS ('dbx_business_glossary_term' = 'Mutual Recognition Countries');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `participant_type` SET TAGS ('dbx_business_glossary_term' = 'Participant Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `priority_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Processing Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `program_benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Program Benefits Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'trusted_trader|security_certification|quality_management|environmental_compliance|customs_partnership|other');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `program_website_url` SET TAGS ('dbx_business_glossary_term' = 'Program Website URL');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `reduced_examination_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Reduced Examination Rate Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|renewal_pending|renewal_submitted|renewal_approved|renewal_denied|lapsed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `security_criteria_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Criteria Met Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `finance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|cbp|aeo|ctpat|wco');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Rating');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|non_compliant');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `facility_location` SET TAGS ('dbx_business_glossary_term' = 'Facility Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `follow_up_audit_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `program_certification_impacted` SET TAGS ('dbx_business_glossary_term' = 'Program Certification Impacted');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Audit Remarks');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_audit` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` SET TAGS ('dbx_subdomain' = 'zone_operations');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Inventory ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Entry Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Admission Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ftz Site Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Manager Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Pkg Sustainability Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `aeo_certified_indicator` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `cbp_bond_number` SET TAGS ('dbx_business_glossary_term' = 'Customs and Border Protection (CBP) Bond Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `customs_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Customs Value United States Dollar (USD)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `cycle_count_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `estimated_duty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duty Amount United States Dollar (USD)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `export_date` SET TAGS ('dbx_business_glossary_term' = 'Export Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `export_destination_country` SET TAGS ('dbx_business_glossary_term' = 'Export Destination Country');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `export_destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Operator Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_zone_number` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Zone Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_zone_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_zone_type` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Zone Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `ftz_zone_type` SET TAGS ('dbx_value_regex' = 'general_purpose|subzone|usage_driven');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `insurance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value United States Dollar (USD)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `manipulation_description` SET TAGS ('dbx_business_glossary_term' = 'Manipulation Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `manipulation_status` SET TAGS ('dbx_business_glossary_term' = 'Manipulation Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `manipulation_status` SET TAGS ('dbx_value_regex' = 'none|in_progress|completed|approved|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `temperature_controlled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `temperature_range_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Celsius');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Cubic Meter (CBM)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Kilogram (KG)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `zone_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Zone Lot Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `zone_status` SET TAGS ('dbx_business_glossary_term' = 'Zone Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_inventory` ALTER COLUMN `zone_status` SET TAGS ('dbx_value_regex' = 'in_zone|transferred|exported|consumed|destroyed|entered_commerce');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` SET TAGS ('dbx_subdomain' = 'zone_operations');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Admission ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Admitted By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_number` SET TAGS ('dbx_business_glossary_term' = 'FTZ Admission Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_business_glossary_term' = 'Admission Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_status` SET TAGS ('dbx_value_regex' = 'pending|admitted|withdrawn|cancelled|expired');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_business_glossary_term' = 'Admission Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `admission_type` SET TAGS ('dbx_value_regex' = 'privileged_foreign|non_privileged_foreign|domestic|zone_to_zone_transfer');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Declared Value (United States Dollars)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `declared_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `estimated_duty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duty Amount (United States Dollars)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `estimated_duty_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Expiration Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'ACE|paper|EDI');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Operator Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_zone_number` SET TAGS ('dbx_business_glossary_term' = 'Foreign Trade Zone (FTZ) Zone Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `ftz_zone_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}[A-Z]?$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `merchandise_description` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Program Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `special_program_indicator` SET TAGS ('dbx_value_regex' = 'C-TPAT|AEO|FDA_regulated|USDA_regulated|EPA_regulated|None');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `trade_agreement` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `warehouse_location` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `withdrawal_type` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ftz_admission` ALTER COLUMN `withdrawal_type` SET TAGS ('dbx_value_regex' = 'consumption|export|destruction|zone_to_zone_transfer|None');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `additional_duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Additional Duty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `additional_duty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Additional Duty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `additional_duty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `aeo_certified_indicator` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `c_tpat_certified_indicator` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `country_of_examination_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Examination Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `country_of_examination_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `customer_notification_sent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_findings` SET TAGS ('dbx_business_glossary_term' = 'Examination Findings');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_location` SET TAGS ('dbx_business_glossary_term' = 'Examination Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_result_code` SET TAGS ('dbx_business_glossary_term' = 'Examination Result Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_result_code` SET TAGS ('dbx_value_regex' = 'CLEARED|DISCREPANCY_FOUND|VIOLATION_DETECTED|ADDITIONAL_DUTY_ASSESSED|SEIZURE|PENALTY_ISSUED');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_type_code` SET TAGS ('dbx_business_glossary_term' = 'Examination Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `examination_type_code` SET TAGS ('dbx_value_regex' = 'VACIS|CET|INTENSIVE|TAILGATE|DOCUMENT_ONLY|NO_EXAM');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|PENDING_RELEASE|RELEASED|ESCALATED|CANCELLED');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_officer_badge_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Officer Badge Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_officer_badge_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Officer Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `issuing_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `resolution_action_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `responsible_party_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `responsible_party_code` SET TAGS ('dbx_value_regex' = 'SHIPPER|CONSIGNEE|BROKER|CARRIER|INTERNAL');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `sla_breach_indicator` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `total_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `total_financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Total Financial Impact Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `total_financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = 'CBP_EXAM|USDA_INSPECTION|FDA_INSPECTION|SECURITY_HOLD|COMPLIANCE_REVIEW|DOCUMENTATION_REVIEW');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_request_id` SET TAGS ('dbx_business_glossary_term' = 'Ruling Request ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `appeal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_filed|appeal_under_review|appeal_granted|appeal_denied|appeal_withdrawn');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `approved_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Approved Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `binding_indicator` SET TAGS ('dbx_business_glossary_term' = 'Binding Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `duty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `importer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Importer Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `importer_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `importer_name` SET TAGS ('dbx_business_glossary_term' = 'Importer Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `importer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `preference_indicator` SET TAGS ('dbx_business_glossary_term' = 'Preference Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `proposed_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Proposed Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `public_availability_indicator` SET TAGS ('dbx_business_glossary_term' = 'Public Availability Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Ruling Authority Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Ruling Authority Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Ruling Decision Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_number` SET TAGS ('dbx_business_glossary_term' = 'Ruling Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_outcome` SET TAGS ('dbx_business_glossary_term' = 'Ruling Outcome');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_outcome` SET TAGS ('dbx_value_regex' = 'approved_as_proposed|approved_with_modification|denied|withdrawn|pending');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_rationale` SET TAGS ('dbx_business_glossary_term' = 'Ruling Rationale');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_status` SET TAGS ('dbx_business_glossary_term' = 'Ruling Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_type` SET TAGS ('dbx_business_glossary_term' = 'Ruling Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `ruling_type` SET TAGS ('dbx_value_regex' = 'classification|valuation|origin|marking|binding|advance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `supporting_documentation` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Months');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ruling_request` ALTER COLUMN `valuation_method_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `origin_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_date` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_method` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_method` SET TAGS ('dbx_value_regex' = 'wholly_obtained|substantial_transformation|tariff_shift|value_added_content|change_in_tariff_classification|regional_value_content');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_number` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determination_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|superseded');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `determined_by_user` SET TAGS ('dbx_business_glossary_term' = 'Determined By User');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `duty_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Savings Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `duty_savings_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Savings Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `duty_savings_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `exporter_identifier` SET TAGS ('dbx_business_glossary_term' = 'Exporter Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `exporter_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `exporter_name` SET TAGS ('dbx_business_glossary_term' = 'Exporter Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `materials_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Materials Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `materials_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `non_originating_materials_value` SET TAGS ('dbx_business_glossary_term' = 'Non-Originating Materials Value');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `origin_criterion_met` SET TAGS ('dbx_business_glossary_term' = 'Origin Criterion Met');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `originating_materials_value` SET TAGS ('dbx_business_glossary_term' = 'Originating Materials Value');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `preferential_tariff_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Preferential Tariff Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `production_location` SET TAGS ('dbx_business_glossary_term' = 'Production Location');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `regional_value_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Regional Value Content (RVC) Percent');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `rvc_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Regional Value Content (RVC) Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `rvc_calculation_method` SET TAGS ('dbx_value_regex' = 'transaction_value|net_cost|build_up|build_down');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `standard_tariff_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Standard Tariff Rate Percent');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `supporting_document_type` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `tariff_shift_rule_met` SET TAGS ('dbx_business_glossary_term' = 'Tariff Shift Rule Met');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Verification Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `verification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Verification Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ALTER COLUMN `verified_by_customs_authority` SET TAGS ('dbx_business_glossary_term' = 'Verified by Customs Authority Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `origin_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'draft|issued|endorsed|revoked|expired|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'preferential|non-preferential|gsp_form_a|eur1|usmca|rcep');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Consignee Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_identifier` SET TAGS ('dbx_business_glossary_term' = 'Consignee Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `country_of_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `endorsement_date` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `endorsement_official_name` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Official Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `export_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Export Declaration Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_body_identifier` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_body_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_body_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_body_type` SET TAGS ('dbx_value_regex' = 'chamber_of_commerce|customs_authority|exporter_self_certification|authorized_body');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `origin_criterion` SET TAGS ('dbx_business_glossary_term' = 'Origin Criterion');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `package_type_code` SET TAGS ('dbx_business_glossary_term' = 'Package Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Assignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_charge_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Charge Allocation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `trade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Transaction Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'contract|purchase_order|booking|manual');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|completed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `buyer_cost_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Buyer Cost Responsibility');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `buyer_party_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Party Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `cost_responsibility_boundary` SET TAGS ('dbx_business_glossary_term' = 'Cost Responsibility Boundary');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `duty_basis_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Duty Basis Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `duty_basis_calculation_method` SET TAGS ('dbx_value_regex' = 'FOB|CIF|other');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `export_customs_clearance_party` SET TAGS ('dbx_business_glossary_term' = 'Export Customs Clearance Party');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `export_customs_clearance_party` SET TAGS ('dbx_value_regex' = 'seller|buyer');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `import_customs_clearance_party` SET TAGS ('dbx_business_glossary_term' = 'Import Customs Clearance Party');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `import_customs_clearance_party` SET TAGS ('dbx_value_regex' = 'seller|buyer');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Rule Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Rule Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Version');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_value_regex' = '2020|2010|2000');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `insurance_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Level');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `insurance_obligation_party` SET TAGS ('dbx_business_glossary_term' = 'Insurance Obligation Party');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `insurance_obligation_party` SET TAGS ('dbx_value_regex' = 'seller|buyer|none');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `named_place` SET TAGS ('dbx_business_glossary_term' = 'Named Place');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `named_place_country_code` SET TAGS ('dbx_business_glossary_term' = 'Named Place Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `named_place_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `named_place_type` SET TAGS ('dbx_business_glossary_term' = 'Named Place Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `named_place_type` SET TAGS ('dbx_value_regex' = 'port|warehouse|facility|address|terminal');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `risk_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Risk Transfer Point');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `seller_cost_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Seller Cost Responsibility');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `seller_party_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Party Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `special_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Requirements');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `trade_lane` SET TAGS ('dbx_business_glossary_term' = 'Trade Lane');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `transport_mode_applicability` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode Applicability');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `transport_mode_applicability` SET TAGS ('dbx_value_regex' = 'any|sea_inland_waterway_only');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `dg_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods (DG) Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certified By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `dg_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Dg Certification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `competent_authority_approval` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority Approval Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `excepted_quantity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Excepted Quantity Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `exemption_reference` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `flash_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `gross_quantity` SET TAGS ('dbx_business_glossary_term' = 'Gross Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `hazard_division` SET TAGS ('dbx_business_glossary_term' = 'Hazard Division');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `limited_quantity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Limited Quantity Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `marine_pollutant_indicator` SET TAGS ('dbx_business_glossary_term' = 'Marine Pollutant Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `net_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `packaging_instruction` SET TAGS ('dbx_business_glossary_term' = 'Packaging Instruction');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `packaging_type_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|g|mL|lbs|gal');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exemption_granted');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `segregation_group` SET TAGS ('dbx_business_glossary_term' = 'Segregation Group');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_certification_signature` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Signature');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_certification_statement` SET TAGS ('dbx_business_glossary_term' = 'Shipper Certification Statement');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `special_provision_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Provision Codes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `stowage_category` SET TAGS ('dbx_business_glossary_term' = 'Stowage Category');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `stowage_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `subsidiary_hazard` SET TAGS ('dbx_business_glossary_term' = 'Subsidiary Hazard');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `technical_name` SET TAGS ('dbx_business_glossary_term' = 'Technical Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`dg_declaration` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Valuation ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Officer ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `assists_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Assists Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'CIF|FOB|DAP|DDP|EXW|FCA');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `cif_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Insurance and Freight (CIF) Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `commissions_brokerage_amount` SET TAGS ('dbx_business_glossary_term' = 'Commissions and Brokerage Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Valuation Confidence Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `customs_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Authority Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `customs_query_raised_indicator` SET TAGS ('dbx_business_glossary_term' = 'Customs Query Raised Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `customs_value_accepted_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Accepted Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `declared_transaction_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Transaction Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `deductions_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductions Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `exchange_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Source');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `fob_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `insurance_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `loading_handling_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Loading and Handling Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `method_code` SET TAGS ('dbx_value_regex' = 'METHOD_1|METHOD_2|METHOD_3|METHOD_4|METHOD_5|METHOD_6');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `packing_costs_amount` SET TAGS ('dbx_business_glossary_term' = 'Packing Costs Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `proceeds_resale_amount` SET TAGS ('dbx_business_glossary_term' = 'Proceeds from Resale Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `query_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Query Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `relationship_buyer_seller_indicator` SET TAGS ('dbx_business_glossary_term' = 'Relationship Between Buyer and Seller Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `resale_disposal_restriction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Resale or Disposal Restriction Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `royalties_license_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalties and License Fees Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `ruling_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Ruling Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `ruling_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Ruling Issue Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `ruling_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Valuation Ruling Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `ruling_reference` SET TAGS ('dbx_business_glossary_term' = 'Valuation Ruling Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `sale_condition_restrictions_indicator` SET TAGS ('dbx_business_glossary_term' = 'Sale Condition Restrictions Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `supporting_documents_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|adjusted|rejected|under_review');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_permit_id` SET TAGS ('dbx_business_glossary_term' = 'License Permit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `authorized_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Authorized Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `authorized_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `authorized_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Authorized Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `authorized_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `end_use_description` SET TAGS ('dbx_business_glossary_term' = 'End Use Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `end_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `export_control_classification_number` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|exhausted|suspended|revoked|expired|pending');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'import_license|export_license|dual_use_export_authorization|cites_permit|phytosanitary_certificate|fda_prior_notice');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `previous_license_number` SET TAGS ('dbx_business_glossary_term' = 'Previous License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `quota_indicator` SET TAGS ('dbx_business_glossary_term' = 'Quota Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `quota_order_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Order Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `remaining_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Renewal Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `restricted_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Restricted Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `utilized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Utilized Quantity');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `utilized_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Value Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` SET TAGS ('dbx_subdomain' = 'tariff_valuation');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `drawback_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Drawback Claim Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Export Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Import Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `accelerated_payment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Payment Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `approved_drawback_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Drawback Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `broker_license_number` SET TAGS ('dbx_business_glossary_term' = 'Broker License Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Drawback Claim Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `customs_broker_name` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `destruction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Destruction Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `drawback_amount_claimed` SET TAGS ('dbx_business_glossary_term' = 'Drawback Amount Claimed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `drawback_type` SET TAGS ('dbx_business_glossary_term' = 'Drawback Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `drawback_type` SET TAGS ('dbx_value_regex' = 'manufacturing|unused_merchandise|rejected_merchandise|substitution_unused|substitution_manufacturing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `duty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Duty Paid Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `exported_commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Exported Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `exported_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Exported Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `imported_commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Imported Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `imported_hs_code` SET TAGS ('dbx_business_glossary_term' = 'Imported Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `manufacturing_process_description` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|offset');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `quantity_exported` SET TAGS ('dbx_business_glossary_term' = 'Quantity Exported');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `quantity_imported` SET TAGS ('dbx_business_glossary_term' = 'Quantity Imported');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `review_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Review Officer Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `substitution_indicator` SET TAGS ('dbx_business_glossary_term' = 'Substitution Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `supporting_documents_submitted` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documents Submitted');
ALTER TABLE `transport_shipping_ecm`.`customs`.`drawback_claim` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `administering_authority` SET TAGS ('dbx_business_glossary_term' = 'Administering Authority');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'fta|customs_union|gsp|eba|bilateral|multilateral');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `authority_website_url` SET TAGS ('dbx_business_glossary_term' = 'Authority Website Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `authority_website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}(/.*)?$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `certificate_of_origin_format` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin (COO) Format');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `certificate_of_origin_format` SET TAGS ('dbx_value_regex' = 'form_a|eur1|movement_certificate|self_certification|invoice_declaration|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `certificate_of_origin_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin (COO) Required Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `cumulation_rules` SET TAGS ('dbx_business_glossary_term' = 'Cumulation Rules');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `cumulation_rules` SET TAGS ('dbx_value_regex' = 'bilateral|diagonal|full|none');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `digital_trade_provisions` SET TAGS ('dbx_business_glossary_term' = 'Digital Trade Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `environmental_provisions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `government_procurement_provisions` SET TAGS ('dbx_business_glossary_term' = 'Government Procurement Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `intellectual_property_provisions` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `investment_provisions` SET TAGS ('dbx_business_glossary_term' = 'Investment Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `labor_standards_provisions` SET TAGS ('dbx_business_glossary_term' = 'Labor Standards Provisions Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `mutual_recognition_agreements` SET TAGS ('dbx_business_glossary_term' = 'Mutual Recognition Agreements (MRA)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `participating_countries` SET TAGS ('dbx_business_glossary_term' = 'Participating Countries');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `product_coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Coverage Scope');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `product_coverage_scope` SET TAGS ('dbx_value_regex' = 'all_goods|industrial_goods_only|agricultural_excluded|services_included|limited_product_list');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `quota_provisions` SET TAGS ('dbx_business_glossary_term' = 'Quota Provisions');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `review_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Years');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `rules_of_origin_criteria` SET TAGS ('dbx_business_glossary_term' = 'Rules of Origin (ROO) Criteria');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `safeguard_measures` SET TAGS ('dbx_business_glossary_term' = 'Safeguard Measures');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signature Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `superseded_by_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Agreement Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `tariff_elimination_schedule` SET TAGS ('dbx_business_glossary_term' = 'Tariff Elimination Schedule');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `tariff_elimination_schedule` SET TAGS ('dbx_value_regex' = 'immediate|staged_5yr|staged_10yr|staged_15yr|partial|product_specific');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `trade_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `trade_agreement_status` SET TAGS ('dbx_value_regex' = 'in_force|under_negotiation|signed_not_ratified|suspended|terminated|expired');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `trade_facilitation_provisions` SET TAGS ('dbx_business_glossary_term' = 'Trade Facilitation Provisions');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `wto_notification_number` SET TAGS ('dbx_business_glossary_term' = 'World Trade Organization (WTO) Notification Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `wto_notification_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}/[0-9]{1,5}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` SET TAGS ('dbx_subdomain' = 'declaration_filing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `customs_event_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Event ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorded By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `amendment_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `appeal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Appeal Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'APPROVED|DENIED|PARTIALLY_APPROVED|PENDING');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `compliance_program_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `customs_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Authority Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `customs_office_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Office Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'PHYSICAL|DOCUMENTARY|X_RAY|CANINE|NONE');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `hold_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hold Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `notification_sent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `penalty_indicator` SET TAGS ('dbx_business_glossary_term' = 'Penalty Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `previous_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Declaration Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Event Reason Description');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `responsible_party_identifier` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `resulting_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Resulting Declaration Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `sla_compliance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Indicator');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`customs_event` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Event Type Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` SET TAGS ('dbx_association_edges' = 'customs.compliance_program,finance.company_code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Company Code Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Compliance Program Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `participation_notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`program_participation` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` SET TAGS ('dbx_subdomain' = 'trade_compliance');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` SET TAGS ('dbx_association_edges' = 'customer.customer_account,customs.trade_agreement');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `trade_agreement_utilization_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Utilization ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Employee ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Utilization - Customer Account Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Utilization - Trade Agreement Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `annual_duty_savings` SET TAGS ('dbx_business_glossary_term' = 'Annual Duty Savings Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `certificate_count` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Count');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `first_utilization_date` SET TAGS ('dbx_business_glossary_term' = 'First Utilization Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preference Claim Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Utilization Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `preference_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Eligibility Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `total_shipments_claimed` SET TAGS ('dbx_business_glossary_term' = 'Total Shipments with Preference Claimed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement_utilization` ALTER COLUMN `utilization_rate` SET TAGS ('dbx_business_glossary_term' = 'Utilization Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` SET TAGS ('dbx_subdomain' = 'party_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ALTER COLUMN `trade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Transaction Identifier');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_transaction` ALTER COLUMN `amended_trade_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
