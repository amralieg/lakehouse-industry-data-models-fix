-- Schema for Domain: customs | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`customs` COMMENT 'Manages end-to-end customs brokerage and trade compliance for cross-border shipments. Owns HS Code classification, import/export declarations, ISF and AMS filings, denied party screening, C-TPAT and AEO program compliance, duty and tax calculation, FTZ management, tariff management, and Incoterms-based liability determination. Powered by Descartes Customs GTM and aligned to WCO, WTO, and national customs authority requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`declaration` (
    `declaration_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Customs declarations operate under master service agreements that govern clearance terms, billing rates, SLA commitments, and Incoterms obligations. Brokers and importers track which agreement applies',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Customs declarations must track the carrier transporting goods for transport mode validation, duty assessment basis (CIF/FOB), and regulatory compliance reporting. Carrier details are essential for cu',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Every customs declaration is filed for a specific shipment/consignment. Customs clearance tracking, release status monitoring, and duty reconciliation all require linking declaration to the physical c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Customs declarations require supplier/exporter master data for denied party screening, origin verification, and duty assessment. Brokers link declarations to supplier records for compliance validation',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer in customs declaration is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many declarations can have the sa',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Customs declarations must reference the transport lane for duty calculation based on origin/destination routing. Customs authorities track transport corridors for risk profiling and trade compliance. ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Port of entry is a physical network node where customs clearance occurs. Required for customs processing location tracking, facility capacity planning, and clearance time analysis by node. Replaces de',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Customs declarations reference a specific free trade agreement or preferential trade arrangement to claim preferential duty rates. declaration carries trade_agreement as a STRING denormalized referenc',
    `amendment_reason` STRING COMMENT 'Reason for amending the declaration after initial submission (e.g., corrected HS code, updated value, additional documentation). Null if declaration was not amended.',
    `certificate_of_origin_number` STRING COMMENT 'Reference number of the certificate of origin document supporting preferential duty treatment or country-of-origin claims. Null if not applicable.',
    `country_of_destination` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the final destination country where the goods will be consumed or used.. Valid values are `^[A-Z]{3}$`',
    `country_of_export` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country from which the goods are being exported.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the goods were manufactured, produced, or substantially transformed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration record was first created in the system.',
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
    CONSTRAINT pk_declaration PRIMARY KEY(`declaration_id`)
) COMMENT 'Core master record for import and export customs declarations filed with national customs authorities. Captures declaration type (import/export/transit/re-export), declaration number, associated shipment reference, declarant identity, country of origin, country of destination, port of entry/exit, Incoterms, declaration status (draft/submitted/under_review/released/rejected), filing date, release date, and regulatory authority reference. Sourced from Descartes Customs GTM and aligned to WCO SAD (Single Administrative Document) standards.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`declaration_line` (
    `declaration_line_id` BIGINT COMMENT 'Unique identifier for the customs declaration line item. Primary key for the declaration line entity.',
    `declaration_id` BIGINT COMMENT 'Reference to the parent customs declaration header. Links this line item to its parent declaration document.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Each declaration line declares goods under a specific HS classification. Linking to hs_classification provides traceability to the classification decision. Not removing hs_code as its a point-in-time',
    `license_permit_id` BIGINT COMMENT 'Foreign key linking to customs.license_permit. Business justification: Declaration lines for controlled goods reference a license/permit. Currently has license_number as denormalized string. Adding FK to license_permit normalizes this and enables tracking of license util',
    `origin_determination_id` BIGINT COMMENT 'Foreign key linking to customs.origin_determination. Business justification: Each declaration line declares a country of origin. Linking to origin_determination provides the supporting determination for the declared origin, especially important for preferential tariff claims. ',
    `package_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_package. Business justification: Multi-SKU shipments require line-level mapping between customs declaration lines and physical packages for inspection, examination, and selective release. Enables package-level customs status tracking',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Customs declaration lines map to PO line items for item-level duty tracking and compliance audit. Brokers trace declaration lines to PO lines for valuation verification, HS code validation, and transf',
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
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Tariff rates are defined for specific HS codes. tariff_rate carries hs_code as a STRING denormalized reference. Replacing it with hs_classification_id FK normalizes this to the authoritative hs_classi',
    `superseded_by_tariff_rate_id` BIGINT COMMENT 'Reference to the tariff_rate_id that replaces this record when status is superseded. Enables rate history tracking.',
    `trade_agreement_id` BIGINT COMMENT 'FK to customs.trade_agreement',
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
    `agent_id` BIGINT COMMENT 'Reference to the licensed customs broker who prepared and filed the customs declaration and calculated the duty assessment.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Duty assessments must reference the governing service agreement to determine duty payment responsibility (importer vs carrier vs 3PL), apply contracted duty management services, validate Incoterms cos',
    `plan_leg_id` BIGINT COMMENT 'Foreign key linking to route.plan_leg. Business justification: Duty assessments generate accessorial charges allocated to specific transport legs for landed cost calculation. Finance systems need leg-level duty attribution to reconcile carrier invoices, calculate',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this duty assessment. Links to the freight shipment being cleared through customs.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration for which this duty assessment was performed. Links to the parent customs entry filing.',
    `declaration_line_id` BIGINT COMMENT 'Foreign key linking to customs.declaration_line. Business justification: Duty assessments are calculated at the commodity/tariff line level, not just at the declaration header level. duty_assessment already has customs_declaration_id (header link) but lacks a declaration_l',
    `original_assessment_duty_assessment_id` BIGINT COMMENT 'Reference to the original duty assessment record if this is an adjusted or corrected assessment. Creates audit trail for assessment changes. Null for original assessments.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Duty assessments must trace to specific PO lines for landed cost calculation, three-way matching with supplier invoices, and cost allocation to inventory. Enables audit trail linking customs duty char',
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
    `payment_date` DATE COMMENT 'Date when the duties and taxes were paid to the customs authority. Null if payment status is unpaid.',
    `payment_due_date` DATE COMMENT 'Date by which the assessed duties and taxes must be paid to the customs authority. Failure to pay by this date may result in penalties, interest, or cargo holds.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the duty payment. Links to the payment transaction in the financial system or customs payment portal.',
    `payment_status` STRING COMMENT 'Current payment status of the assessed duties and taxes. Unpaid = not yet paid; Paid = fully settled; Partial = partially paid; Overdue = past due date; Waived = exempted from payment.. Valid values are `unpaid|paid|partial|overdue|waived`',
    `port_of_entry_code` STRING COMMENT 'Code identifying the customs port or border crossing where the goods entered the country and duty was assessed. UN/LOCODE or national port code.. Valid values are `^[A-Z0-9]{5,6}$`',
    `preferential_duty_rate` DECIMAL(18,2) COMMENT 'Reduced duty rate percentage applied under a preferential tariff program or free trade agreement. Lower than the standard Most Favored Nation (MFN) rate.',
    `preferential_tariff_program` STRING COMMENT 'Free trade agreement or preferential tariff program applied to reduce or eliminate duty. Examples: USMCA, EU-UK TCA, CPTPP, GSP. Empty if no preference claimed.',
    `total_duty_tax_amount` DECIMAL(18,2) COMMENT 'Total liability including all duties, taxes, and fees assessed on this customs entry. Sum of customs duty, anti-dumping duty, countervailing duty, VAT, excise tax, and all fees.',
    `vat_amount` DECIMAL(18,2) COMMENT 'Value-Added Tax or Goods and Services Tax (GST) assessed on the imported goods. Consumption tax collected at the point of import.',
    CONSTRAINT pk_duty_assessment PRIMARY KEY(`duty_assessment_id`)
) COMMENT 'Transactional record of duty and tax calculations performed for a customs declaration or shipment. Captures total customs duty, anti-dumping duty, countervailing duty, VAT/GST, excise tax, port handling levies, total tax liability, currency, exchange rate applied, calculation basis (CIF/FOB/DDP), assessment date, assessment status (estimated/assessed/final/disputed), and payment due date. Supports duty payment reconciliation and landed cost computation. Generated by Descartes Customs GTM duty calculation engine.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`isf_filing` (
    `isf_filing_id` BIGINT COMMENT 'Unique identifier for the ISF filing record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: ISF filings are performed under master service agreements that define filing responsibilities, timing SLAs, penalty allocation for late/inaccurate filings, and service fees. Linking ISF to agreement e',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: ISF (Importer Security Filing) requires carrier identification for CBP 10+2 compliance. Linking to carrier master data ensures accurate SCAC/IATA code validation, vessel/voyage tracking, and regulator',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: ISF (10+2) filing is mandatory for ocean shipments to US 24 hours before loading. CBP compliance, penalty avoidance, and shipment release all require linking ISF to the consignment. Critical for US im',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: An ISF filing (Importer Security Filing) is a pre-arrival filing that precedes and is associated with the formal customs declaration for the same shipment. Linking isf_filing to the customs declaratio',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: ISF filings require HTSUS (Harmonized Tariff Schedule of the United States) code reporting to CBP. isf_filing carries htsus_code as a STRING denormalized reference. Replacing it with hs_classification',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer of record in ISF filing is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many ISF filings can have the sa',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: ISF 10+2 filings require manufacturer/supplier details for CBP compliance. Customs brokers pull supplier master data (name, address, country) from procurement systems for accurate ISF submission and i',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: ISF 10+2 rule requires specifying the port where cargo will be unladed. CBP uses this for vessel arrival coordination and security screening. Critical for ISF compliance validation and arrival plannin',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: ISF (Importer Security Filing) requires detailed PO information for US customs advance cargo screening 24 hours before vessel loading. Direct link supports ISF compliance, enables automated filing fro',
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
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: An AMS (Automated Manifest System) filing is the advance cargo report that precedes the formal customs declaration. Linking ams_filing to the customs declaration closes the workflow loop: AMS -> Decla',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: AMS filings include HS code commodity reporting for advance cargo manifest purposes. ams_filing carries hs_code as a STRING denormalized reference. Replacing it with hs_classification_id FK normalizes',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Importer of record in AMS filing is a trade party. Adding importer_trade_party_id FK to trade_party.trade_party_id normalizes the importer reference. Cardinality: N:1 (many AMS filings can have the sa',
    `isf_filing_id` BIGINT COMMENT 'Foreign key linking to customs.isf_filing. Business justification: AMS filings are directly associated with ISF filings for the same ocean shipment. The ams_filing table already carries isf_number as a STRING denormalized reference to the ISF transaction number. Repl',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: AMS advance manifest submissions must specify unlading port for CBP security screening. Required for manifest compliance validation and arrival port coordination. Replaces denormalized port_of_unladin',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: AMS (Automated Manifest System) filings require PO details for cargo screening and customs clearance. Linking enables automated manifest generation, ensures consistency between customs filings and pro',
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
    `incoterm` STRING COMMENT 'The Incoterm governing the transfer of risk and responsibility between shipper and consignee. Determines liability and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
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
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Denied party screening services incur per-transaction fees when performed by third-party compliance vendors or internal compliance departments. These screening charges must be tracked per screening ev',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Denied party screening results block billing and credit extension; direct link enforces compliance holds, prevents invoicing to sanctioned entities, and supports regulatory reporting.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment being screened for denied party compliance.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Denied party screening is performed as part of customs declaration processing. The declaration has denied_party_screening_status indicating this relationship. Adding a FK from screening to declaration',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Trade parties (importers/exporters) are billing entities requiring account mapping for invoicing, credit management, and payment collection in international trade operations.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Trade parties (importers, exporters, brokers) are often also network partners (freight forwarders, NVOCCs, agents). Unified partner master enables compliance screening, performance tracking, settlemen',
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
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Customs brokers are licensed to operate at specific ports/nodes. Required for broker jurisdiction enforcement, service coverage planning, and assignment validation. Replaces denormalized assigned_port',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Customs broker assignments must link to the agent entity for operational coordination, performance tracking (filing accuracy, release times), and network management. Role prefix distinguishes from bro',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Customs broker is a trade party entity. Adding broker_trade_party_id FK to trade_party.trade_party_id normalizes the broker reference. Cardinality: N:1 (many assignments can use the same broker). Remo',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Compliance programs (AEO, C-TPAT) operate under master service agreements defining audit rights, data sharing obligations, liability caps, and compliance cost allocation. Logistics operators need to t',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: AEO/C-TPAT certification affects billing terms, credit limits, and payment conditions; direct link enables compliance-based pricing and preferential billing treatment for certified participants.',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: AEO/C-TPAT compliance programs grant expedited processing at specific certified ports and hubs. Routing optimization must know which nodes have program certification to leverage reduced inspection rat',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Compliance program memberships (C-TPAT, AEO, etc.) are held by trade parties. The compliance_program product appears to be an association entity tracking trade party participation in compliance progra',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Compliance programs (AEO, C-TPAT, Authorized Economic Operator) are held by legal entities that operate as network partners. Direct link enables operational queries: which partners have which authoriz',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Compliance programs (AEO, C-TPAT) grant expedited release and reduced inspection rates, which are formalized as SLA commitments in service agreements (e.g., AEO-certified shipments released within 4 ',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Trade compliance programs (C-TPAT, AEO, etc.) are often established under or recognized by specific trade agreements and mutual recognition arrangements. compliance_program has mutual_recognition_coun',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the customs hold record. Primary key.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Customs holds generate detention, storage, examination, and demurrage charges. Essential for billing customers for hold-related costs and tracking financial impact of customs delays in logistics opera',
    `agent_id` BIGINT COMMENT 'Reference to the customs broker handling the resolution of this hold.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Customs holds trigger SLA breaches and penalty clauses in service agreements. Tracking which agreement governs a held shipment is essential for penalty calculation, dispute resolution, credit note iss',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that is subject to this customs hold.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration associated with this hold.',
    `denied_party_screening_id` BIGINT COMMENT 'Foreign key linking to customs.denied_party_screening. Business justification: A customs hold can be placed as a direct result of a denied party screening match (regulatory_hold_flag on denied_party_screening). Linking hold to the triggering denied_party_screening record provide',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Customs holds require physical examination/storage at a facility (CFS, bonded warehouse, examination site) operated by a partner. Links hold to the facility partner for operational coordination, cost ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Customs holds generate detention, demurrage, and storage charges that must be invoiced to customers; direct link supports hold-related billing and financial impact tracking.',
    `penalty_clause_id` BIGINT COMMENT 'Foreign key linking to contract.penalty_clause. Business justification: Customs holds that cause delivery delays trigger contractual penalty clauses for SLA breaches (on-time delivery commitments). Logistics operators must link holds to penalty clauses to calculate financ',
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Customs holds are placed at specific examination locations/ports. Required for hold resolution workflow by facility, resource allocation, and examination capacity planning. Replaces denormalized port_',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Date and time when the customs hold was actually lifted and the shipment was released. Null if hold is still active.',
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
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Certificate of origin issuance, verification, legalization, and chamber of commerce endorsement incur specific fees charged as accessorials. Logistics providers must track these charges per certificat',
    `declaration_id` BIGINT COMMENT 'Foreign key reference to the export customs declaration record associated with this certificate. Links to the declaration product in the customs domain.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Exporter in certificate of origin is a trade party. Adding exporter_trade_party_id FK to trade_party.trade_party_id normalizes the exporter reference. Cardinality: N:1 (many certificates can have the ',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: A certificate of origin is issued for goods identified by their HS classification. certificate_of_origin carries hs_code as a STRING denormalized reference. Replacing it with hs_classification_id FK n',
    `origin_determination_id` BIGINT COMMENT 'Foreign key linking to customs.origin_determination. Business justification: A certificate of origin is supported by an origin determination that establishes the country of origin through rules of origin analysis. Linking certificate to its supporting origin determination prov',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Certificates of origin support preferential duty treatment claimed on specific POs. Linking enables verification that origin documentation matches procurement commitments, validates duty savings again',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Certificates of origin identify exporter/supplier for preferential tariff claims under trade agreements. Customs teams validate supplier details against certificates for origin determination and duty ',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Certificates of origin are issued under specific trade agreements to claim preferential tariff treatment. The certificate has trade_agreement_code as a denormalized string. Adding FK to trade_agreemen',
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
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: The buyer party in an incoterms assignment is a trade party managed in the customs domain. incoterms_assignment carries buyer_party_name as a STRING denormalized reference. Replacing it with buyer_tra',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment to which this Incoterms rule is assigned. Links the Incoterms assignment to the specific shipment transaction.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Incoterms assignments directly govern customs liability determination — they define who is responsible for import/export customs clearance, duty payment, and risk transfer. Linking incoterms_assignmen',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order associated with this Incoterms assignment. Used when Incoterms are assigned at the freight order level rather than individual shipment level.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Incoterms define cost/risk transfer points that align with transport lanes. Required for freight costing by lane, liability determination, and route planning based on trade terms. Lane determines appl',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Incoterms assignments determine cost/risk transfer points and must align with PO terms for landed cost calculation, duty basis determination, and ensuring customs declarations match procurement agreem',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Incoterms assignments for cross-border shipments must align with service corridor handoff points (DDP vs DAP determines where customs clearance occurs in corridor). Essential for cost allocation and r',
    `assigned_timestamp` TIMESTAMP COMMENT 'The date and time when this Incoterms assignment was created in the system. Provides audit trail for compliance and dispute resolution.',
    `assignment_number` STRING COMMENT 'Business-readable unique identifier for the Incoterms assignment. Used for external communication and audit trail purposes.',
    `assignment_source` STRING COMMENT 'Indicates the source document or process from which this Incoterms assignment was derived. Supports audit trail and data lineage tracking.. Valid values are `contract|purchase_order|booking|manual`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the Incoterms assignment. Indicates whether the assignment is currently in force, has been replaced by a newer assignment, was cancelled, or has been completed.. Valid values are `active|superseded|cancelled|completed`',
    `buyer_cost_responsibility` STRING COMMENT 'Detailed enumeration of costs that the buyer is responsible for under the assigned Incoterms rule. Complements seller cost responsibility to provide full cost allocation picture.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`license_permit` (
    `license_permit_id` BIGINT COMMENT 'Unique identifier for the import/export license or permit record. Primary key for the license_permit product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Import/export licenses are often obtained under framework agreements specifying which party bears application costs, timeline commitments, and renewal responsibilities. Freight forwarders need to trac',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Export/import licenses for controlled commodities (ITAR, dual-use, pharmaceuticals) restrict which lanes can be used. License terms specify authorized ports of entry/exit; routing systems must validat',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Import/export licenses specify authorized suppliers or beneficiaries for controlled goods. Compliance teams validate shipments against licensed supplier lists, requiring supplier master linkage for li',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: A license or permit is issued for a specific commodity identified by its HS code classification. license_permit carries hs_code as a STRING denormalized reference. Replacing it with hs_classification_',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Import/export licenses are obtained for specific POs involving controlled goods. Linking enables compliance verification that licensed quantities match procurement orders, supports quota management, a',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Import/export licenses and permits are frequently issued under or governed by specific free trade agreements or preferential trade arrangements (e.g., USMCA certificates, EU preferential licenses). Li',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` (
    `trade_agreement_id` BIGINT COMMENT 'Unique identifier for the trade agreement record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Commercial service agreements often reference trade agreements (USMCA, EU FTAs) to validate preferential rate eligibility, origin compliance requirements, and duty drawback programs. Linking trade agr',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` (
    `declaration_compliance_benefit_id` BIGINT COMMENT 'Unique identifier for this declaration-compliance program benefit application record. Primary key.',
    `compliance_program_id` BIGINT COMMENT 'Foreign key linking to the compliance program whose benefits were applied to this declaration',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to the customs declaration that invoked compliance program benefits',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the importer or declarant holds AEO status, which provides trade facilitation benefits and reduced customs controls in the EU and other jurisdictions. [Moved from declaration: This boolean flag indicates AEO certification status, which is a specific compliance program benefit. It should be represented as a relationship record in declaration_compliance_benefit rather than a direct attribute on declaration, allowing tracking of which specific AEO program was applied and when.]',
    `benefit_application_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance program benefit was applied to this declaration in the customs processing system',
    `benefit_applied_flag` BOOLEAN COMMENT 'Indicates whether the compliance program benefit was successfully applied to this declaration during customs processing',
    `benefit_claimed_by` STRING COMMENT 'Name or identifier of the party (importer, broker, carrier) that claimed the compliance program benefit on this declaration',
    `benefit_effective_date` DATE COMMENT 'Date when the compliance program benefit was applied or became effective for this declaration',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this declaration compliance benefit record was first created in the system',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the importer or declarant is C-TPAT certified, which may expedite customs clearance and reduce inspections. [Moved from declaration: This boolean flag indicates C-TPAT certification status, which is a specific compliance program benefit. It should be represented as a relationship record in declaration_compliance_benefit rather than a direct attribute on declaration, allowing tracking of which specific C-TPAT tier was applied and when.]',
    `customs_verification_status` STRING COMMENT 'Status of customs authority verification that the compliance program benefit was validly claimed and applied (verified, pending, rejected, not_applicable)',
    `expedited_release_applied` BOOLEAN COMMENT 'Indicates whether expedited customs release processing was granted based on this compliance program membership',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the application of this compliance program benefit to the declaration',
    `program_benefit_type` STRING COMMENT 'Type of compliance program benefit applied to this declaration (e.g., expedited_release, reduced_examination, priority_processing, dedicated_lane, fee_reduction)',
    `reduced_examination_applied` BOOLEAN COMMENT 'Indicates whether reduced physical examination rate was applied to this declaration based on compliance program membership',
    CONSTRAINT pk_declaration_compliance_benefit PRIMARY KEY(`declaration_compliance_benefit_id`)
) COMMENT 'This association product represents the application of trade compliance program benefits to specific customs declarations. It captures which compliance programs (C-TPAT, AEO, trusted trader certifications) were invoked for each declaration to obtain expedited processing, reduced examination rates, or other program-specific benefits. Each record links one declaration to one compliance program with attributes documenting the specific benefits applied and their effectiveness. This is a recognized operational record in customs management systems used for program performance measurement and audit trail requirements.. Existence Justification: In customs clearance operations, a single declaration can invoke multiple compliance program benefits simultaneously (e.g., C-TPAT for security, AEO for EU recognition, and ISO 28000 for supply chain certification), and each compliance program is applied to thousands of declarations over time. Customs authorities require tracking which specific program benefits were claimed and verified for each declaration for audit, program performance measurement, and mutual recognition reporting. This is an operational business entity called declaration compliance benefit or program benefit application that is actively managed in trade compliance systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ADD CONSTRAINT `fk_customs_declaration_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_license_permit_id` FOREIGN KEY (`license_permit_id`) REFERENCES `transport_shipping_ecm`.`customs`.`license_permit`(`license_permit_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ADD CONSTRAINT `fk_customs_declaration_line_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ADD CONSTRAINT `fk_customs_hs_classification_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_superseded_by_tariff_rate_id` FOREIGN KEY (`superseded_by_tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ADD CONSTRAINT `fk_customs_tariff_rate_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_declaration_line_id` FOREIGN KEY (`declaration_line_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration_line`(`declaration_line_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_original_assessment_duty_assessment_id` FOREIGN KEY (`original_assessment_duty_assessment_id`) REFERENCES `transport_shipping_ecm`.`customs`.`duty_assessment`(`duty_assessment_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_tariff_rate_id` FOREIGN KEY (`tariff_rate_id`) REFERENCES `transport_shipping_ecm`.`customs`.`tariff_rate`(`tariff_rate_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ADD CONSTRAINT `fk_customs_duty_assessment_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ADD CONSTRAINT `fk_customs_isf_filing_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ADD CONSTRAINT `fk_customs_ams_filing_isf_filing_id` FOREIGN KEY (`isf_filing_id`) REFERENCES `transport_shipping_ecm`.`customs`.`isf_filing`(`isf_filing_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ADD CONSTRAINT `fk_customs_denied_party_screening_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ADD CONSTRAINT `fk_customs_broker_assignment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ADD CONSTRAINT `fk_customs_compliance_program_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ADD CONSTRAINT `fk_customs_hold_denied_party_screening_id` FOREIGN KEY (`denied_party_screening_id`) REFERENCES `transport_shipping_ecm`.`customs`.`denied_party_screening`(`denied_party_screening_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` ADD CONSTRAINT `fk_customs_origin_determination_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_origin_determination_id` FOREIGN KEY (`origin_determination_id`) REFERENCES `transport_shipping_ecm`.`customs`.`origin_determination`(`origin_determination_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ADD CONSTRAINT `fk_customs_certificate_of_origin_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_trade_party_id` FOREIGN KEY (`trade_party_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_party`(`trade_party_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ADD CONSTRAINT `fk_customs_incoterms_assignment_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_hs_classification_id` FOREIGN KEY (`hs_classification_id`) REFERENCES `transport_shipping_ecm`.`customs`.`hs_classification`(`hs_classification_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ADD CONSTRAINT `fk_customs_license_permit_trade_agreement_id` FOREIGN KEY (`trade_agreement_id`) REFERENCES `transport_shipping_ecm`.`customs`.`trade_agreement`(`trade_agreement_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ADD CONSTRAINT `fk_customs_declaration_compliance_benefit_compliance_program_id` FOREIGN KEY (`compliance_program_id`) REFERENCES `transport_shipping_ecm`.`customs`.`compliance_program`(`compliance_program_id`);
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ADD CONSTRAINT `fk_customs_declaration_compliance_benefit_declaration_id` FOREIGN KEY (`declaration_id`) REFERENCES `transport_shipping_ecm`.`customs`.`declaration`(`declaration_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`customs` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `transport_shipping_ecm`.`customs` SET TAGS ('dbx_domain' = 'customs');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` SET TAGS ('dbx_subdomain' = 'declaration_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `certificate_of_origin_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_business_glossary_term' = 'Country of Export');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_export` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` SET TAGS ('dbx_subdomain' = 'declaration_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `license_permit_id` SET TAGS ('dbx_business_glossary_term' = 'License Permit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `origin_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` SET TAGS ('dbx_subdomain' = 'classification_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hs_classification` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Classification ID');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` SET TAGS ('dbx_subdomain' = 'classification_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `superseded_by_tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`tariff_rate` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` SET TAGS ('dbx_subdomain' = 'declaration_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `plan_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed Plan Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `original_assessment_duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Assessment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|overdue|waived');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_business_glossary_term' = 'Port of Entry Code');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `port_of_entry_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,6}$');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `preferential_duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Preferential Duty Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `preferential_tariff_program` SET TAGS ('dbx_business_glossary_term' = 'Preferential Tariff Program');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `total_duty_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Duty and Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`duty_assessment` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value-Added Tax (VAT) Amount');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Security Filing (ISF) Filing ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Unlading Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`isf_filing` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `ams_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Manifest System (AMS) Filing ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Importer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Isf Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Unlading Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`ams_filing` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `denied_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`denied_party_screening` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_party` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Assignment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Port Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`broker_assignment` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Trade Party Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`compliance_program` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `denied_party_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `penalty_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Entry Network Node Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`origin_determination` SET TAGS ('dbx_subdomain' = 'classification_management');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` SET TAGS ('dbx_subdomain' = 'declaration_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Origin ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Exporter Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `origin_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`certificate_of_origin` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` SET TAGS ('dbx_subdomain' = 'classification_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `incoterms_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Assignment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Assignment Number');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_source` SET TAGS ('dbx_value_regex' = 'contract|purchase_order|booking|manual');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|superseded|cancelled|completed');
ALTER TABLE `transport_shipping_ecm`.`customs`.`incoterms_assignment` ALTER COLUMN `buyer_cost_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Buyer Cost Responsibility');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `license_permit_id` SET TAGS ('dbx_business_glossary_term' = 'License Permit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`customs`.`license_permit` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` SET TAGS ('dbx_subdomain' = 'classification_management');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`trade_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Agreement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` SET TAGS ('dbx_subdomain' = 'declaration_processing');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` SET TAGS ('dbx_association_edges' = 'customs.declaration,customs.compliance_program');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `declaration_compliance_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Compliance Benefit ID');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `compliance_program_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Compliance Benefit - Compliance Program Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Compliance Benefit - Declaration Id');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `benefit_application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Application Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `benefit_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Benefit Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `benefit_claimed_by` SET TAGS ('dbx_business_glossary_term' = 'Benefit Claimed By');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `benefit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective Date');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `customs_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Verification Status');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `expedited_release_applied` SET TAGS ('dbx_business_glossary_term' = 'Expedited Release Applied');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `program_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Program Benefit Type');
ALTER TABLE `transport_shipping_ecm`.`customs`.`declaration_compliance_benefit` ALTER COLUMN `reduced_examination_applied` SET TAGS ('dbx_business_glossary_term' = 'Reduced Examination Applied');
